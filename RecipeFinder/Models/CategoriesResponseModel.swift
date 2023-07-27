//
//  CategoriesResponseModel.swift
//  RecipeFinder
//
//  Created by Nazlıcan Çay on 26.07.2023.
//

import Foundation

struct CategoriesResponse: Codable {
    let categories: [Category]
}

struct Category: Codable {
    let idCategory: String
    let strCategory: String
    let strCategoryThumb: String
    let strCategoryDescription: String
}
