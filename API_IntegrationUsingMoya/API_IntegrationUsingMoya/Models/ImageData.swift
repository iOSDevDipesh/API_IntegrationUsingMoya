//
//  ImageData.swift
//  API_IntegrationUsingMoya
//
//  Created by mac on 27/03/23.
//

import Foundation

// MARK: - ImageData

struct ImageData: Codable {
    let id, author: String
    let width, height: Int
    let url, downloadURL: String

    enum CodingKeys: String, CodingKey {
        case id, author, width, height, url
        case downloadURL = "download_url"
    }
}
