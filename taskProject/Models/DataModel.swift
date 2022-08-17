//
//  DataModel.swift
//  taskProject
//
//  Created by apple on 16/08/22.
//

import Foundation

// MARK: - DataModel
struct DataModel: Decodable {
 
    let totalResults: Int
    let articles: [Article]
}

// MARK: - Article
struct Article: Decodable {
    let author: String
    let content: String
    let title: String
    let urlToImage: String
    let url: String
}

