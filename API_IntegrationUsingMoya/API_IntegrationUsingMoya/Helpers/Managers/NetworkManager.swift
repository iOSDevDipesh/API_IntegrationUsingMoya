//
//  NetworkManager.swift
//  API_IntegrationUsingMoya
//
//  Created by mac on 27/03/23.
//

import Foundation
import Moya

// MARK: - Network Manager

class NetworkManager: NSObject {
    
    // MARK: Singleton
    
    static let shared = NetworkManager()
    
    // MARK: Properties
    
    let provider = MoyaProvider<API>()
    
    // MARK: Public Methods
    
    func request<T: Decodable>(target: API, type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        provider.request(target) { result in
            switch result {
            case .success(let response):
                do {
                    let json = try JSONSerialization.jsonObject(with: response.data, options: [])
                    switch response.statusCode {
                    case 200...299:
                        let data = try JSONSerialization.data(withJSONObject: json, options: [])
                        let decoder = JSONDecoder()
                        let decodedObject = try decoder.decode(type, from: data)
                        completion(.success(decodedObject))
                    case 300...599:
                        let error = self.handleError(data: json)
                        completion(.failure(error))
                    default:
                        completion(.failure(MoyaError.statusCode(response)))
                    }
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // MARK: Private Methods
    
    private func handleError(data: Any) -> MoyaError {
        let nsError = NSError(domain: "com.APIIntegrationUsingMoya", code: 0, userInfo: [NSLocalizedDescriptionKey: "Error"])
        return MoyaError.underlying(nsError, nil)
    }
}

