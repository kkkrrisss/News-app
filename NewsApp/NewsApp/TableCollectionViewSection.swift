//
//  TableCollectionViewSection.swift
//  NewsApp
//
//  Created by Кристина Олейник on 11.08.2025.
//

import Foundation

protocol TableCollectionViewItemsProtocol { }

struct TableCollectionViewSection {
    var title: String?
    var items: [TableCollectionViewItemsProtocol]
    
    
}
