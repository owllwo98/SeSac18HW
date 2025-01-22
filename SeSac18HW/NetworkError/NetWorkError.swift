//
//  NetWorkError.swift
//  SeSac18HW
//
//  Created by 변정훈 on 1/22/25.
//

import Foundation
import Alamofire

enum NetWorkError: Int{
    case BadRequest = 401
    case Unauthorized = 402
    case Forbidden = 403
    case NotFound = 404
    case InternalServerError = 500
    
    var message: String {
        switch self {
        case .BadRequest:
            "The request was unacceptable, often due to missing a required parameter"
        case .Unauthorized:
            "Invalid Access Token"
        case .Forbidden:
            "Missing permissions to perform request"
        case .NotFound:
            "The requested resource doesn’t exist"
        case .InternalServerError:
            "Something went wrong on our end"
        }
    }
}
