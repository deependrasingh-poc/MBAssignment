//
//  UniversityServiceError.swift
//  iOSAssignment
//
//  Created by test on 22/12/25.
//
import Foundation

enum UniversityServiceError: Error, LocalizedError {
    case badURL
    case networkError(Error)
    case invalidResponse
    case decodingError(Error)
    case cancelled
    
    var errorDescription: String? {
        switch self {
        case .badURL:
            return "The URL is invalid."
        case .networkError(let error):
            return "Network error: \(error.localizedDescription)"
        case .invalidResponse:
            return "Invalid response from the server."
        case .decodingError(let error):
            return "Failed to decode response: \(error.localizedDescription)"
        case .cancelled:
            return "The request was cancelled."
        }
    }
}

