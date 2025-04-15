//
//  CountryService.swift
//  KnowYourCountry
//
//  Created by Mateo Doslic on 12.04.25.
//

import Foundation
import RxSwift
import Alamofire

protocol CountryServiceable {
    func fetchCountries() -> Observable<[Country]>
}

class CountryService: CountryServiceable {
    private let baseURL = "https://restcountries.com/v3.1"
    private let session: Session
    
    let fetchType: CountryListType
    
    init(fetchType: CountryListType,
         session: Session
    ) {
        self.fetchType = fetchType
        self.session = session
    }
    
    func fetchCountries() -> Observable<[Country]> {

            switch fetchType {
            case .all:
                return fetchAllCountries()
            case .europe: // or other reagons in the futue?
                return fetchCountriesByRegion(fetchType.rawValue)
            }
       
    }
    
    func fetchAllCountries() -> Observable<[Country]> {
        return Observable.create { [weak self] observer in
            guard let self else {
                observer.onError(CountryError.listError("Failed"))
                return Disposables.create()
            }
            session.request("\(self.baseURL)/all")
                .validate()
                .responseDecodable(of: [Country].self) { response in
                    switch response.result {
                    case .success(let countries):
                        observer.onNext(countries)
                        observer.onCompleted()
                    case .failure(let error):
                        observer.onError(CountryError.listError(error.localizedDescription))
                    }
                }
            return Disposables.create()
        }
    }
    
    func fetchCountriesByRegion(_ region: String) -> Observable<[Country]> {
        return Observable.create { [weak self] observer in
            guard let self else {
                observer.onError(CountryError.listError("Failed"))
                return Disposables.create()
            }
            self.session.request("\(self.baseURL)/region/\(region.lowercased())")
                .validate()
                .responseDecodable(of: [Country].self) { response in
                    switch response.result {
                    case .success(let countries):
                        observer.onNext(countries)
                        observer.onCompleted()
                    case .failure(let error):
                        observer.onError(CountryError.listError(error.localizedDescription))
                    }
                }
            return Disposables.create()
        }
    }
}

