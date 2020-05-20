//
//  RecipeStruct.swift
//  Reciplease
//
//  Created by SayajinPapuru on 20/02/2020.
//  Copyright © 2020 sayajin papuru. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct Reciplease: Codable {
    let hits: [Hit]
}

// MARK: - Hit
struct Hit: Codable {
    let recipe: Recipe
}

// MARK: - Recipe
struct Recipe: Codable {
    let label: String
    let image: String
    let url: String
    let yield: Int
    let ingredientLines: [String]
    let ingredients: [Ingredient]
    let totalTime: Int
}

// MARK: - Ingredient
struct Ingredient: Codable {
    let text: String
}

struct RecipeDetails {
    var name: String
    var ingredients: [String]
    var yield: String
    var time: String
    var url: String
    var data: Data?
}
