//
//  ArticleCellViewModel.swift
//  NewsApp
//
//  Created by Кристина Олейник on 06.08.2025.
//

import Foundation

struct ArticleCellViewModel {
    let title: String
    let description: String
    let data: String
    let imageUrl: String
    var imageData: Data?
    
    init(article: ArticleResponseObject) {
        title = article.title
        description = article.description
        data = article.date
        imageUrl = article.urlToImage
    }
}
