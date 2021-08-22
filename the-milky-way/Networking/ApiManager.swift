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
        var eventMonitors = [EventMonitor]()
        let config = URLSessionConfiguration.af.default
        config.requestCachePolicy = .returnCacheDataElseLoad
        
        #if DEBUG
        let networkLogger = NetworkLogger()
        eventMonitors.append(networkLogger)
        #endif
        
        return Session(configuration: config, eventMonitors: eventMonitors)
    }()
    
    func fetchNasaImages(_ query: String?, completion: @escaping ([NasaImage]) -> Void) {
        sessionManager
            .request(ApiRouter.fetchNasaImages(query))
            .responseDecodable(of: NasaImageApiResponse.self) {
                response in
                
                guard let value = response.value else {
                    return completion([])
                }
                
                completion(value.collection.items)
            }
    }
}
