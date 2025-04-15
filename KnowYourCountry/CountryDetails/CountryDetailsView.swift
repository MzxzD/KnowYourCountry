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
    @ObservedObject var viewModel: CountryDetailViewModel
    
    init(viewModel: CountryDetailViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Group {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text(viewModel.country.name.common)
                        .font(.largeTitle)
                        .bold()
                    Text(viewModel.country.name.official)
                        .font(.subheadline)
                        .bold()
                    
                    if let flagURL = URL(string: viewModel.country.flags.png) {
                        AsyncImage(url: flagURL) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(maxHeight: 200)
                    }
                    
                    Text("Capital: \(viewModel.country.capital?.first ?? "N/A")")
                    Text("Population: \(viewModel.country.population)")
                    Text("Area: \(viewModel.country.area.formatted()) km²")
                    Text("Region: \(viewModel.country.region)")
                    Text("Languages: \(viewModel.country.formattedLanguages)")
                }
                .padding()
            }
        }
    }
}
