
//  NetworkManager.swift
//  Wine Helper
//
//  Created by Евгений Митюля on 3/23/24.


import Foundation
import Alamofire
import AlamofireImage
import UIKit

enum RequestError: Error {
    case ErrorRequest
}

final class NetworkManager {
    
    // MARK: - SINGLETON NETWORK MANAGER:
    static let shared = NetworkManager()
    
    private init() {}
    
    enum Constants {
        static let baseURL = "https://fc35af49ba3cae.lhr.life/api/v1.0"
    }
    
    enum EndPoints {
        static let wines = "/Wines"
        
        enum Sections {
            static let special = "/Specs"
            static let newArrivals = "/New"
            static let bestSellers = "/Best"
            
            static let images = "/Imgs/"
            static let cell = "/Cell"
        }
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
    
    func getWineAllInfo(with id: Int, completion: @escaping(Result<WineDTO, RequestError>) -> Void) {
        AF.request(Constants.baseURL + EndPoints.wines + "/" + String(id)).responseDecodable(of: WineDTO.self) { response in
            print(Constants.baseURL + EndPoints.wines + "/" + String(id))
            switch response.result {
            case .success(let coin):
                print(coin)
                completion(.success(coin))
            case .failure:
                completion(.failure(.ErrorRequest))
            }
        }
    }
    
    func getWines(from prevId: Int, to nextId: Int, completion: @escaping(Result<[WineCellDTO], RequestError>) -> Void) {
        AF.request(Constants.baseURL + EndPoints.wines + EndPoints.Sections.cell + "/" + String(prevId) + "/" + String(nextId)).responseDecodable(of: [WineCellDTO].self) { response in
            switch response.result {
            case .success(let coin):
                print(coin)
                completion(.success(coin))
            case .failure:
                completion(.failure(.ErrorRequest))
            }
        }
    }
    
    func getWineSectionCells(completion: @escaping(Result<[WineCellDTO], RequestError>) -> Void) {
        AF.request(Constants.baseURL + EndPoints.wines + EndPoints.Sections.special).responseDecodable(of: [WineCellDTO].self) { response in
            switch response.result {
            case .success(let coin):
                print(coin)
                completion(.success(coin))
            case .failure:
                completion(.failure(.ErrorRequest))
            }
        }
    }
    
    func getWineImage(id: Int, completion: @escaping(Result<UIImage, RequestError>) -> Void) {
        AF.request(Constants.baseURL + EndPoints.wines + EndPoints.Sections.images + String(id)).responseImage { response in
            switch response.result {
            case .success(let image):
                print(image)
                completion(.success(image))
            case .failure:
                completion(.failure(.ErrorRequest))
            }
        }
    }
    
    
    // MARK: - Sections(Special, New Arrivals, Best Sellers)
    
    func getWineSpecialSectionCells(count: Int, completion: @escaping(Result<[WineCellDTO], RequestError>) -> Void) {
        AF.request(Constants.baseURL + EndPoints.wines + EndPoints.Sections.special + "/" + String(count)).responseDecodable(of: [WineCellDTO].self) { response in
            print(Constants.baseURL + EndPoints.wines + EndPoints.Sections.special + "/" + String(count))
            switch response.result {
            case .success(let coin):
                print(coin)
                completion(.success(coin))
            case .failure:
                completion(.failure(.ErrorRequest))
            }
        }
    }
    
    func getWineNewArrivalsSectionCells(count: Int, completion: @escaping(Result<[WineCellDTO], RequestError>) -> Void) {
        AF.request(Constants.baseURL + EndPoints.wines + EndPoints.Sections.newArrivals + "/" + String(count)).responseDecodable(of: [WineCellDTO].self) { response in
            print(Constants.baseURL + EndPoints.wines + EndPoints.Sections.newArrivals + "/" + String(count))
            switch response.result {
            case .success(let coin):
                print(coin)
                completion(.success(coin))
            case .failure:
                completion(.failure(.ErrorRequest))
            }
        }
    }
    
    func getWineBestSellersSectionCells(count: Int, completion: @escaping(Result<[WineCellDTO], RequestError>) -> Void) {
        AF.request(Constants.baseURL + EndPoints.wines + EndPoints.Sections.bestSellers + "/" + String(count)).responseDecodable(of: [WineCellDTO].self) { response in
            print(Constants.baseURL + EndPoints.wines + EndPoints.Sections.bestSellers + "/" + String(count))
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

