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
    
    func fetchNasaImages(page: Int, _ query: String?, completion: @escaping (Result<NasaImageCollection, MilkyWayError>) -> Void) {

        sessionManager
            .request(ApiRouter.fetchNasaImages(page, query))
            .responseDecodable(of: NasaImageApiResponse.self) {
                response in
                
                if (response.error != nil) {
                    return completion(.failure(MilkyWayError.other(response.error?.errorDescription)))
                }
                
                guard let value = response.value else {
                    return completion(.failure(MilkyWayError.noData))
                }

                completion(.success(value.collection))
            }
    }
}
