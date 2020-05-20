//
//  MockRecipeSession.swift
//  RecipleaseTests
//
//  Created by SayajinPapuru on 18/05/2020.
//  Copyright © 2020 sayajin papuru. All rights reserved.
//

import Foundation
import Alamofire
@testable import Reciplease

struct FakeResponse {
    var response: HTTPURLResponse?
    var data: Data?
    var error: Error?
}

final class MockRecipeSession: RecipeSession {
    

    private let fakeResponse: FakeResponse
    
    init(fakeResponse: FakeResponse) {
        self.fakeResponse = fakeResponse
        super.init()
    }
    
    
    override func request(with url: URL, callBack: @escaping (DataResponse<Any>) -> Void) {
        let httpResponse = fakeResponse.response
        let data = fakeResponse.data
        let error = fakeResponse.error

        let result = Request.serializeResponseJSON(options: .allowFragments, response: httpResponse, data: data, error: error)

        let urlRequest = URLRequest(url: URL(string: "https://www.apple.com")!)
        callBack(DataResponse(request: urlRequest, response: httpResponse, data: data, result: result))
    }
}
