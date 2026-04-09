//
//  MockUniversityService.swift
//  iOSAssignment
//
//  Created by test on 23/12/25.
//
import Foundation

final class MockUniversityService: UniversityServiceProtocol {
    
    var shouldThrowError = false
    var mockData: [University] = [
        University(
            name: "IIT Delhi",
            country: "India",
            stateProvince: "Delhi",
            webPages: ["https://www.iitd.ac.in"]
        ),
        University(
            name: "IISc Bangalore",
            country: "India",
            stateProvince: "Karnataka",
            webPages: ["https://www.iisc.ac.in"]
        )
    ]
    
    func fetchUniversities(_ serviceUrl: String) async throws -> [University] {
        if shouldThrowError {
            throw URLError(.badServerResponse)
        }
        return mockData
    }
}
