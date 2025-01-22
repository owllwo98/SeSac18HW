//
//  NetworkManager.swift
//  SeSac18HW
//
//  Created by 변정훈 on 1/18/25.
//

import UIKit
import Alamofire

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}

    func request<T: Decodable>(url: String, T: T.Type ,completion: @escaping (T) -> Void) {
        
        AF.request(url, method: .get).responseDecodable(of: T.self) { response in
            switch response.result {
                
            case.success(let value):
                completion(value.self)
            case.failure(let error) :
                print(error)
                
            }
        }
    }
    
    func fetchData<T: Decodable>(api: PhotoRouter , T: T.Type,  completion: @escaping (T) -> Void, errorCompletion: @escaping (Int) -> Void) {
        AF.request(api)
            .responseDecodable(of: T.self){ response in
            switch response.result {
                
            case .success(let value):
                guard let decodedData = response.value else { return }
                completion(decodedData)
            case .failure(let error):
                guard let errorResponse = response.response?.statusCode else {
                    errorCompletion(response.response?.statusCode ?? 500)
                    return
                }
                errorCompletion(errorResponse)
            }
        }
    }
}
