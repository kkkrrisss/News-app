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
                        searchText: String?,
                        completion: @escaping (Result<[ArticleResponseObject], Error>) -> ()) {
        
        var searchParameter: String = ""
        if let searchText = searchText {
            searchParameter = "+\(searchText)"
        }
        
        let stringlUrl = baseURl + path  + "?q=\(enumNewsType.rawValue)" + searchParameter +  "&sources=bbc-news&language=en&pageSize=20&page=\(page)" + "&apiKey=" + apiKey
        
        guard let url = URL(string: stringlUrl) else { return }
        
        let session = URLSession.shared.dataTask(with: url) { data, response, error in
            handleResponse(data: data, response: response, error: error, completion: completion)
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
                                       response: URLResponse?,
                                       error: Error?,
                                       completion: @escaping (Result<[ArticleResponseObject], Error>) -> ()) {
        
        
        if let error = error {
            completion(.failure(NetworkingError.networkingError(error)))
            return
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            completion(.failure(NetworkingError.unknown))
            return
        }
        
        guard httpResponse.statusCode == 200 else {
            completion(.failure(NetworkingError.apiError(statusCode: httpResponse.statusCode)))
            return
        }
        
        guard let data = data else {
            completion(.failure(NetworkingError.unknown))
            return
        }
        
        //            let rawResponse = String(data: data, encoding: .utf8)
        //            print("Raw API response:", rawResponse ?? "No data")
        do {
            //JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any]
            let model = try JSONDecoder().decode(NewsResponseObject.self, from: data)
            completion(.success(model.articles))
        }
        catch let decodeError {
            completion(.failure(decodeError))
        }
    }
}
