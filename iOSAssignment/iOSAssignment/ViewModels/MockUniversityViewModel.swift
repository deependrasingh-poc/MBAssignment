//
//  Untitled.swift
//  iOSAssignment
//
//  Created by test on 23/12/25.
//
import Foundation

final class MockUniversityService: UniversityServiceProtocol {

    func fetchUniversities() async throws -> [University] {
        [
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
    }
}
