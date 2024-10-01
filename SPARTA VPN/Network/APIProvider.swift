//
//  APIProvider.swift
//  SPARTA VPN
//
//  Created by Иван Зиныч on 25.09.2024.
//

import Moya
import Foundation

extension MoyaProvider {
    
    func requestAPI(target: Target, completion: @escaping (Swift.Result<Void, APIErrorModel>) -> ()) {
        request(target) { result in
            switch result {
            case .success(let response):
                completion(.success(()))
            case .failure(let error):
                guard let data = error.response?.data else {
                    completion(.failure(APIErrorModel(message: error.localizedDescription)))
                    return
                }

                do {
                    let results = try JSONDecoder().decode(APIErrorModel.self, from: data)
                    completion(.failure(results))
                } catch {
                    do {
                        let results = try JSONDecoder().decode(APIErrorMessageModel.self, from: data)
                        completion(.failure(APIErrorModel(message: results.message)))
                    } catch {
                        completion(.failure(APIErrorModel(message: error.localizedDescription)))
                    }
                }
            }
        }
    }
    
    func requestAPI<T: Decodable>(target: Target, completion: @escaping (Swift.Result<T, APIErrorModel>) -> ()) {
        request(target) { result in
            switch result {
            case .success(let response):
                do {
                    let results = try JSONDecoder().decode(T.self, from: response.data)
                    completion(.success(results))
                }
                catch let decodingError {
                    completion(.failure(APIErrorModel(message: decodingError.localizedDescription)))
                }
            case .failure(let error):
                guard let data = error.response?.data else {
                    completion(.failure(APIErrorModel(message: error.localizedDescription)))
                    return
                }

                do {
                    let results = try JSONDecoder().decode(APIErrorModel.self, from: data)
                    completion(.failure(results))
                } catch {
                    completion(.failure(APIErrorModel(message: error.localizedDescription)))
                }
            }
        }
    }
}
