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
    let recipe: RecipesFaved
}

// MARK: - Recipe
struct RecipesFaved: Codable {
    let label: String
    let image: String
    let source: String
    let yield: Int
    let ingredientLines: [String]
    let ingredients: [Ingredient]
    let totalTime: Int
}

// MARK: - Ingredient
struct Ingredient: Codable {
    let text: String
}
