//
//  NetworkingError.swift
//  NewsApp
//
//  Created by Кристина Олейник on 06.08.2025.
//

import Foundation

enum NetworkingError: Error, LocalizedError {
    case networkingError(_ error: Error)
    case apiError(statusCode: Int)
    case decodingError(_ error: Error)
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .networkingError(let error):
            return "Networking Error: \(error.localizedDescription)"
        case .apiError(let statusCode):
            switch statusCode {
            case 400:
                return "Bad Request. The request was unacceptable, often due to a missing or misconfigured parameter."
            case 401:
                return "Unauthorized. Your API key was missing from the request, or wasn't correct."
            case 429:
                return "Too Many Requests. You made too many requests within a window of time and have been rate limited. Back off for a while."
            case 500:
                return "Server Error. Something went wrong on our side."
            default:
                return "Unknown API Error (\(statusCode))."
            }
        case .decodingError(let error):
            return "Decoding Error: \(error.localizedDescription)"
        case .unknown:
            return "Unknown Error"
        }
    }
}
