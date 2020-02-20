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

class RecipeService {
    let session: AlamoSession
    
    init(session: AlamoSession = RecipeSession()) {
        self.session = session
    }
    
    
    func getDishes(callback: @escaping (Result<Recipe, Error>) -> Void) {
        guard let url = URL(string: "https://api.edamam.com/search?q=Tuna&app_id=24c2394f&app_key=c4cf9f8655c9adb5f9ca07af37f4e372&from=0&to=7") else { return }
        
        session.request(with: url) { (DataResponse) in
            guard let data = DataResponse.data else {
                callback(.failure(RecipeError.NoData))
                return
            }
            print(data)
            
            guard DataResponse.response?.statusCode == 200 else {
                callback(.failure(RecipeError.NoResponse))
                return
            }
            
            guard let dataDecoded = try? JSONDecoder().decode(Recipe.self, from: data) else {
                callback(.failure(RecipeError.NoJSON))
                return
            }
            callback(.success(dataDecoded))
        }
    }
}
