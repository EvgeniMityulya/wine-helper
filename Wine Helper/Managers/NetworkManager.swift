
//  NetworkManager.swift
//  Wine Helper
//
//  Created by Евгений Митюля on 3/23/24.


import Foundation
import Alamofire

enum RequestError: Error {
    case ErrorRequest
}

final class NetworkManager {
    
    // MARK: - SINGLETON NETWORK MANAGER:
    static let shared = NetworkManager()
    
    private init() {}
    
    enum Constants {
        static let baseURL = "https://861794a9cf8742.lhr.life/api/v1.0"
    }
    
    enum EndPoints {
        static let wines = "/wines/"
    }
    
    // MARK: - NETWORK REQUEST:
    
//    func getAssets(completion: @escaping(Result<[WineDTO], RequestError>) -> Void) {
//        AF.request(Constanse.baseURL + CoinEndPoint.wines + ).responseDecodable(of: [Wine].self) { response in
//            switch response.result {
//            case .success(let coin):
//                completion(.success(coin))
//            case .failure:
//                completion(.failure(.ErrorRequest))
//            }
//        }
//    }
    
    func getWine(with id: Int, completion: @escaping(Result<[WineDTO], RequestError>) -> Void) {
        AF.request(Constants.baseURL + EndPoints.wines + String(id)).responseDecodable(of: [WineDTO].self) { response in
            print(Constants.baseURL + EndPoints.wines + String(id))
            switch response.result {
            case .success(let coin):
                print(coin)
                completion(.success(coin))
            case .failure:
                completion(.failure(.ErrorRequest))
            }
        }
    }
}

