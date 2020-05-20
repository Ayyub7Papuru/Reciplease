//
//  FakeResponseData.swift
//  RecipleaseTests
//
//  Created by SayajinPapuru on 18/05/2020.
//  Copyright © 2020 sayajin papuru. All rights reserved.
//

import Foundation
import Alamofire

class FakeResponseData {
    static let responseOK = HTTPURLResponse(url: URL(string: "https://www.apple.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    static let responseKO = HTTPURLResponse(url: URL(string: "https://www.apple.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)!
    
    class NetworkError: Error {}
    static let networkError = NetworkError()
    
    static var correctData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Recipe", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static let incorrectData = "error".data(using: .utf8)!
}
