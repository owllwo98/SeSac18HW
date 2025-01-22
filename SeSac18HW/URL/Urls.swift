//
//  Urls.swift
//  SeSac18HW
//
//  Created by 변정훈 on 1/20/25.
//

import UIKit
import Alamofire


enum PhotoRouter{
    case getTopic(topicID: String)
    case getSearch(keyword: String, page: Int, per_page: Int, order: String, color: String)
    case getStatistics(imageID: String)
}

extension PhotoRouter: URLRequestConvertible  {
    
    var baseURL: URL {
        guard let url = URL(string: "https://api.unsplash.com/") else {
            fatalError("baseURL Error")
        }
        return url
    }
    
    var path: String {
            switch self {
            case .getTopic(topicID: let topic):
                return "topics/\(topic)/photos"
            case .getSearch:
                return "search/photos"
            case .getStatistics(imageID: let imageID):
                return "photos/\(imageID)/statistics"
            }
        }
    
    var method: HTTPMethod {
        switch self {
        case.getTopic, .getStatistics, .getSearch:
            return .get
        }
    }
    
    var hearder: HTTPHeaders {
        return ["Authorization" : "Client-ID \(APIKey.clientID)"]
    }
    
    var parameters: Parameters? {
        switch self {
        case .getTopic:
            return nil
        case .getSearch(keyword: let keyword, page: let page, per_page: let per_page, order: let order, color: let color):
            return ["query" : keyword, "page" : page, "per_page": per_page, "order_by" : order, "color" : color]
        case .getStatistics:
            return nil
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try baseURL.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        urlRequest.method = method
        urlRequest.headers = hearder
        
        if let parameters = parameters {
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        }
        
        return urlRequest
    }
}
