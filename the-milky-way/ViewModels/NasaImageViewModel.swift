//
//  NasaImageViewModel.swift
//  the-milky-way
//
//  Created by Steeve Fong on 2021/08/22.
//

import Foundation
import RxSwift

struct NasaImageViewModel {
    var items = PublishSubject<[NasaImage]>()
    
    func fetchItems(_ query: String?) {
        ApiManager.shared.fetchNasaImages(query) { (results) in
            items.onNext(results)
            items.onCompleted()
        }
    }
}
