//
//  University.swift
//  iOSAssignment
//
//  Created by test on 22/12/25.
//

import Foundation

struct University: Identifiable, Decodable, Hashable {
    // Stable, deterministic ID
        var id: String {
            name + (stateProvince ?? "") + country
        }
    let name: String
    let country: String
    let stateProvince: String?
    let webPages: [String]
    
    enum CodingKeys: String, CodingKey {
        case name
        case country
        case stateProvince = "state-province"
        case webPages = "web_pages"
    }
}

