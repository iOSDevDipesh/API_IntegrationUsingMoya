//
//  NetworkService.swift
//  API_IntegrationUsingMoya
//
//  Created by mac on 27/03/23.
//

import Foundation
import Moya

// MARK: - API Endpoint

enum API {
    case getImages(page: Int, limit: Int)
}

extension API: TargetType {
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    var baseURL: URL {
        return URL(string: "https://picsum.photos/v2")!
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var path: String {
        switch self {
        case .getImages: return "/list"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getImages: return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getImages(let page, let limit):
            return .requestParameters(parameters: ["page": page, "limit": limit], encoding: URLEncoding.default)
        }
    }
}
