//
//  NasaImageViewModel.swift
//  the-milky-way
//
//  Created by Steeve Fong on 2021/08/22.
//

import Foundation
import RxSwift

struct NasaImageViewModel {
    var currentPage = 1
    var isLoading = BehaviorSubject(value: false)
    var items = BehaviorSubject<[NasaImage]>(value: [])
    var hasReachedMaxPage = BehaviorSubject(value: false)
    var errorValue = BehaviorSubject<MilkyWayError?>(value: nil)
    
    init() {
        fetchItems(page: currentPage)
    }
    
    private func fetchItems(page: Int) {
        isLoading.onNext(true)
        
        ApiManager.shared.fetchNasaImages(page: page, nil) { result in
            switch result {
            case .failure(let error):
                errorValue.onNext(error)
                // force pagination to stop fetching new page on error
                hasReachedMaxPage.onNext(true)
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
