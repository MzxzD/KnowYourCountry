//
//  CountryListView.swift
//  KnowYourCountry
//
//  Created by Mateo Doslic on 12.04.25.
//

import SwiftUI
import RxSwift
import RxCocoa
import RxFlow

struct CountryListView: View {
    @StateObject var viewModel: CountryListViewModel

    var body: some View {
        Group {
            if viewModel.isLoading {
                ProgressView()
            } else {
                List(viewModel.countries) { country in
                    CountryRow(country: country)
                        .onTapGesture {
                            viewModel.selectCountry(country)
                        }
                }
            }
        }
        .navigationBarTitleDisplayMode(.large)
        .searchable(text: $viewModel.searchText)
        .refreshable {
            viewModel.fetchCountries()
        }
        .overlay {
            if viewModel.countries.isEmpty && !viewModel.isLoading && viewModel.searchText.isEmpty {
                emptyStateView
            } else if viewModel.countries.isEmpty && !viewModel.isLoading && !viewModel.searchText.isEmpty {
                noResultView
            }
        }
        .alert(item: $viewModel.error) { error in
            Alert(title: Text("error"),
                  message: Text(error.description),
                  dismissButton: .default(Text("ok")))
        }
        .onAppear {
            viewModel.fetchCountries()
        }
    }
    
    private var emptyStateView: some View {
        ContentUnavailableView(
            "No Countries available",
            systemImage: "globe",
            description: Text("Pull to refresh")
        )
    }
    
    
    private var noResultView: some View {
        ContentUnavailableView {
            Label("No Countries for \"\(viewModel.searchText)\"", systemImage: "globe")
        } description: {
            Text("Try to search for another title.")
        }
    }
}



struct CountryRow: View {
    let country: Country
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: country.flags.png)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }
            .frame(width: 50, height: 30)
            
            VStack(alignment: .leading) {
                Text(country.name.common)
                    .font(.headline)
                Text(country.name.official)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
}

