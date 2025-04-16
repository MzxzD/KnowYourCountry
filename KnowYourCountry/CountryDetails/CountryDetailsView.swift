//
//  CountryDetailsView.swift
//  KnowYourCountry
//
//  Created by Mateo Doslic on 12.04.25.
//

import SwiftUI
import RxSwift
import RxCocoa

struct CountryDetailView: View {
    @StateObject var viewModel: CountryDetailViewModel
    
    var body: some View {
        Group {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text(viewModel.country.name.official)
                        .font(.subheadline)
                        .bold()
                    flagImage(country: viewModel.country)
                    Text("Capital: \(viewModel.country.capital?.first ?? "N/A")")
                    Text("Population: \(viewModel.country.population)")
                    Text("Area: \(viewModel.country.area.formatted()) km²")
                    Text("Region: \(viewModel.country.region)")
                    Text("Languages: \(viewModel.country.formattedLanguages)")
                }
                .padding()
            }
        }
        .navigationBarTitleDisplayMode(.large)
        .navigationTitle(viewModel.country.name.common)
    }
    
    @ViewBuilder
    private func flagImage(country: Country) -> some View {
        if let flagURL = URL(string: country.flags.png) {
            AsyncImage(url: flagURL) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }
            .frame(maxHeight: 200)
        }
    }
        
}
