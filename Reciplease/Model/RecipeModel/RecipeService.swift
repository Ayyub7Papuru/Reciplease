//
//  RecipeService.swift
//  Reciplease
//
//  Created by SayajinPapuru on 20/02/2020.
//  Copyright © 2020 sayajin papuru. All rights reserved.
//

import Foundation

enum RecipeError: Error {
   case NoData, NoResponse, NoJSON
}

final class RecipeService {
    private var session: RecipeSession
    
    init(session: RecipeSession = RecipeSession()) {
        self.session = session
    }
    
    func getDishes(ingredients: [String], callback: @escaping (Result<Reciplease, Error>) -> Void) {
        guard let url = URL(string: "https://api.edamam.com/search?app_id=24c2394f&app_key=c4cf9f8655c9adb5f9ca07af37f4e372&q=\(ingredients.joined(separator: ","))" ) else { return }
        session.request(with: url) { (DataResponse) in
            guard let data = DataResponse.data else {
                callback(.failure(RecipeError.NoData))
                return
            }
            
            guard DataResponse.response?.statusCode == 200 else {
                callback(.failure(RecipeError.NoResponse))
                return
            }
            
            guard let dataDecoded = try? JSONDecoder().decode(Reciplease.self, from: data) else {
                callback(.failure(RecipeError.NoJSON))
                return
            }
            callback(.success(dataDecoded))
            print(dataDecoded)
        }
    }
}
