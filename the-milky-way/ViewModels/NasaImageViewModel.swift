//
//  NasaImageViewModel.swift
//  the-milky-way
//
//  Created by Steeve Fong on 2021/08/22.
//

import Foundation
import RxSwift

struct NasaImageViewModel {
    var isLoading = BehaviorSubject(value: false)
    var hasReachedMaxPage = BehaviorSubject(value: false)
    var currentPage = 1
    var items = BehaviorSubject<[NasaImage]>(value: [])
    
    init() {
        fetchItems(page: currentPage)
    }
    
    private func fetchItems(page: Int) {
        isLoading.onNext(true)
        
        ApiManager.shared.fetchNasaImages(page: page, nil) { result in
            switch result {
            case .failure(let error):
                items.onError(error)
            case .success(let collection):
                let prevValues = (try? items.value()) ?? []
                items.onNext(prevValues + collection.items)
                // check if collection does not contain next page
                hasReachedMaxPage.onNext(!collection.hasNext())
            }
            
            isLoading.onNext(false)
        }
    }
    
    mutating func fetchPaginatedItems() {
        currentPage += 1
        fetchItems(page: currentPage)
    }
    
    mutating func refreshList() {
        currentPage = 1
        items.onNext([])
        fetchItems(page: currentPage)
    }
}
