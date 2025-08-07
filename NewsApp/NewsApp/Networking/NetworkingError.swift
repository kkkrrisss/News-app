//
//  NetworkingError.swift
//  NewsApp
//
//  Created by Кристина Олейник on 06.08.2025.
//

import Foundation

enum NetworkingError: Error {
    case networkingError(_ error: Error)
    case unknown
}
