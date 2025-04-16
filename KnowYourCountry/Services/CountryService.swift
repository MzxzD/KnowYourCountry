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
        return Observable.create { [weak self] observer in
            guard let self else {
                observer.onError(CountryError.listError("Failed"))
                observer.onCompleted()
                return Disposables.create()
            }
            session.request("\(self.baseURL)\(fetchType.urlPostfix)")
                .validate()
                .responseDecodable(of: [Country].self) { response in
                    switch response.result {
                    case .success(let countries):
                        observer.onNext(countries)
                        observer.onCompleted()
                    case .failure(let error):
                        observer.onError(CountryError.listError(error.localizedDescription))
                        observer.onCompleted()
                    }
                }
            return Disposables.create()
        }
    }
}

private extension CountryListType {
    var urlPostfix: String {
        switch self {
        case .all:
            return "/all"
        case .europe:
            return "/region/\(rawValue.lowercased())"
        }
    }
}
