//
//  NetworkManager.swift
//  Wine Helper
//
//  Created by Евгений Митюля on 3/23/24.
//
//
//import Foundation
//import Alamofire
//
//enum RequestError: Error {
//    case ErrorRequest
//}
//
//final class NetworkManager {
//    
//    // MARK: - SINGLETON NETWORK MANAGER:
//    static let instance = NetworkManager()
//    
//    private init() {}
//    
//    enum Constanse {
//        static let coinBaseURL = "https://rest.coinapi.io/v1"
//    }
//    
//    enum CoinEndPoint {
//        static let assets = "/assets"
//        static let exchanges = "/exchanges"
//    }
//    
//    // MARK: - API KEY:
//    
//    let header: HTTPHeaders = [
//        "X-CoinAPI-Key": "BECA3812-AEA8-4843-83DA-8744B841C198",
//        "Accept": "application/json"
//    ]
//    
//    // MARK: - NETWORK REQUEST:
//    
//    func getAssets(completion: @escaping(Result<[ModelCoin], RequestError>) -> Void) {
//        AF.request(Constanse.coinBaseURL + CoinEndPoint.assets, headers: header).responseDecodable(of: [ModelCoin].self) { response in
//            switch response.result {
//            case .success(let coin):
//                completion(.success(coin))
//            case .failure:
//                completion(.failure(.ErrorRequest))
//            }
//        }
//    }
//}
//
