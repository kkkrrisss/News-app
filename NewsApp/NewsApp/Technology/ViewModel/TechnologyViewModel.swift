//
//  TechnologyViewModel.swift
//  NewsApp
//
//  Created by Кристина Олейник on 07.08.2025.
//

import Foundation

final class TechnologyViewModel: NewsListViewModel {
    
    override func loadData(searchText: String?) {
        super.loadData(searchText: searchText)
        
        ApiManager.getNews(enumNewsType: .technology,
                           page: page,
                           searchText: searchText) { [weak self] result in
            self?.handleResult(result)
        }
    }
}
