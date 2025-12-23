//
//  Untitled.swift
//  iOSAssignment
//
//  Created by test on 22/12/25.
//

import Foundation

protocol UniversityServiceProtocol {
    func fetchUniversities() async throws -> [University]
}

class UniversityService: UniversityServiceProtocol {
    
    func fetchUniversities() async throws -> [University] {
        guard let url = URL(string: APIEndpoints.universitiesByCountry) else {
            throw UniversityServiceError.badURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        if let httpResponse = response as? HTTPURLResponse,
           !(200...299).contains(httpResponse.statusCode) {
            throw UniversityServiceError.invalidResponse
        }
        
        do {
            return try JSONDecoder().decode([University].self, from: data)
        } catch {
            throw UniversityServiceError.decodingError(error)
        }
    }
}

