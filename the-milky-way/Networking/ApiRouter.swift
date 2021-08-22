//
//  ApiRouter.swift
//  the-milky-way
//
//  Created by Steeve Fong on 2021/08/21.
//

import Foundation
import Alamofire

enum ApiRouter {
    case fetchNasaImages(String?)
    
    var baseUrl: String {
        switch self {
        case .fetchNasaImages:
            fallthrough
        default:
            return "https://images-api.nasa.gov"
        }
    }
    
    var path: String {
        switch self {
        case .fetchNasaImages:
            return "/search"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetchNasaImages:
            return HTTPMethod.get
        }
    }
    
    var parameters: [String: String]? {
        switch self {
        case .fetchNasaImages(let query):
            return [
                "q": query ?? "\"\""
            ]
        }
    }
}

// MARK: - URLRequestConvertible
extension ApiRouter: URLRequestConvertible {
    func asURLRequest() throws -> URLRequest {
        let url = try baseUrl.asURL().appendingPathComponent(path)
        
        var request = URLRequest(url: url)
        request.method = method
        
        if method == .get {
            request = try URLEncodedFormParameterEncoder()
              .encode(parameters, into: request)
        }
        
        return request
    }
}
