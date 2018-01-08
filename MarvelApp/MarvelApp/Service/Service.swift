//
//  Service.swift
//  MarvelApp
//
//  Created by Renan Trapp on 08/01/18.
//  Copyright © 2018 Renan Trapp. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error)
    
    var value: T? {
        switch self {
            case .success(let value):
                return value
            case .failure:
                return nil
        }
    }
    
    var error: Error? {
        switch self {
            case .success:
                return nil
            case .failure(let error):
                return error
        }
    }
    
    func flatMap<U>(closure: (T) throws -> U?) -> Result<U> {
        switch self {
            case .failure(let error):
                return .failure(error)
            case .success(let value):
                do {
                    if let newValue = try closure(value) {
                        return .success(newValue)
                    } else {
                        return .failure(ServiceError.invalidResponse)
                    }
                }
                catch {
                    return .failure(error)
                }
        }
    }
}

enum ServiceError: Error {
    case unknown
    case invalidURL(String)
    case invalidResponse
    
    static func fail<T>(with error: ServiceError = .unknown, _ closure: (Result<T>) -> Void) {
        assertionFailure("An Error Occurred")
        closure(.failure(error))
    }
}

class Service {

    @discardableResult static func requestAPI(url: String, completion: @escaping (Result<Data>) -> Void) -> URLSessionDataTask? {
        guard let base = URL(string: url) else {
            completion(.failure(ServiceError.invalidURL(url)))
            return nil
        }
        
        let request = URLRequest(url: base)
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
            }
            else if let data = data {
                completion(.success(data))
            }
            else {
                ServiceError.fail(completion)
            }
        }
        
        task.resume()
        return task
    }
}
