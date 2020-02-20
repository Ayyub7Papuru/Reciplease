//
//  RecipeSession.swift
//  Reciplease
//
//  Created by SayajinPapuru on 20/02/2020.
//  Copyright © 2020 sayajin papuru. All rights reserved.
//

import Foundation
import Alamofire

protocol AlamoSession {
    func request(with url: URL, callBack: @escaping (DataResponse<Any>) -> Void)
}

final class RecipeSession: AlamoSession {
    func request(with url: URL, callBack: @escaping (DataResponse<Any>) -> Void) {
        Alamofire.request(url).responseJSON { responseData in
            callBack(responseData)
        }
    }
}
