//
//  ApiManager.swift
//  the-milky-way
//
//  Created by Steeve Fong on 2021/08/21.
//

import Foundation
import Alamofire

class ApiManager {
    static let shared = ApiManager()
    
    let sessionManager: Session = {
        let config = URLSessionConfiguration.af.default
        config.requestCachePolicy = .returnCacheDataElseLoad
        
        return Session(configuration: config)
    }()
    
    func fetchNasaImages(query: String?, completion: @escaping ([NasaImage]) -> Void) {
        sessionManager
            .request(ApiRouter.fetchNasaImages(query))
            .responseDecodable(of: NasaImages.self) {
                response in
                
                guard let nasaImages = response.value else {
                    return completion([])
                }
                
                completion(nasaImages.items)
            }
    }
}
