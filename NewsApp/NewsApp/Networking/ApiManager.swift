//
//  ApiManager.swift
//  NewsApp
//
//  Created by Кристина Олейник on 06.08.2025.
//

import Foundation

final class ApiManager {
    
    enum NewsType: String {
        case general = "general"
        case business = "business"
        case technology = "technology"
    }
    
    private static let apiKey = "d00fc88a711b402f95326cca3ab3b6db"
    private static let baseURl = "https://newsapi.org/v2/"
    private static let path = "everything"
    
    //Create url path and make request
    static func getNews(enumNewsType: NewsType,
                        page: Int,
                        completion: @escaping (Result<[ArticleResponseObject], Error>) -> ()) {
        
        let stringlUrl = baseURl + path  + "?q=\(enumNewsType.rawValue)&sources=cnn&language=en&pageSize=20&page=\(page)" + "&apiKey=" + apiKey
        
        guard let url = URL(string: stringlUrl) else { return }
        
        let session = URLSession.shared.dataTask(with: url) { data, _, error in
            handleResponse(data: data, error: error, completion: completion)
        }
        
        session.resume()
    }
    
    static func getImageData(url: String, completion: @escaping (Result<Data, Error>) -> ()) {
        guard let url = URL(string: url) else { return }
        
        let session = URLSession.shared.dataTask(with: url) {
            data, _, error in
            if let data = data {
                completion(.success(data))
            }
            if let error = error {
                completion(.failure(error))
            }
        }
        session.resume()
    }
    
    //Handle response
    private static func handleResponse(data: Data?,
                                       error: Error?,
                                       completion: @escaping (Result<[ArticleResponseObject], Error>) -> ()) {
        if let error = error {
            completion(.failure(NetworkingError.networkingError(error)))
        } else if let data = data {
            do {
                //JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any]
                let model = try JSONDecoder().decode(NewsResponseObject.self, from: data)
                completion(.success(model.articles))
            }
            catch let decodeError {
                completion(.failure(decodeError))
            }
        } else {
            
        }
    }
}
