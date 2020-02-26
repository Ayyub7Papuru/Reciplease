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
    let session: RecipeProtocol
    
    init(session: RecipeProtocol = RecipeSession()) {
        self.session = session
    }
    
    
    func getDishes(callback: @escaping (Result<Recipe, Error>) -> Void) {
        guard let url = URL(string: "\(session.myUrl)" ) else { return }
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
