//
//  Device.swift
//  valet-challenge
//
//  Created by Luiz Felipe Aires Soares on 2022-03-31.
//

import Foundation

struct DeviceListAPIResponse: Codable {
    
    let devices: [Device]
    
}

struct Device: Codable {
    
    let id: String
    let type: String
    let price: Double
    let currency: String
    let isFavorite: Bool
    let imageUrl: URL?
    let title: String
    let desc: String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case type
        case price
        case currency
        case isFavorite
        case imageUrl
        case title
        case desc = "description"
    }
    
}
