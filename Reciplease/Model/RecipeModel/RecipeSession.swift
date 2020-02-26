//
//  RecipeSession.swift
//  Reciplease
//
//  Created by SayajinPapuru on 20/02/2020.
//  Copyright © 2020 sayajin papuru. All rights reserved.
//

import Foundation
import Alamofire

protocol RecipeProtocol {
    func request(with url: URL, callBack: @escaping (DataResponse<Any>) -> Void)
}

final class RecipeSession: RecipeProtocol {
    func request(with url: URL, callBack: @escaping (DataResponse<Any>) -> Void) {
        Alamofire.request(url).responseJSON { responseData in
            callBack(responseData)
        }
    }
}

extension RecipeProtocol {
    var myUrl: (String) {
        let id = "&app_id=24c2394f"
        let keyAPI = "&app_key=c4cf9f8655c9adb5f9ca07af37f4e372"
        let url = "https://api.edamam.com/search?"
        var ingredient = "q=Tuna"
        
        return url + ingredient + id + keyAPI
    }
}

