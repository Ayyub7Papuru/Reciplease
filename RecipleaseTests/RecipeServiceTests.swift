//
//  RecipeServiceTests.swift
//  RecipleaseTests
//
//  Created by SayajinPapuru on 18/05/2020.
//  Copyright © 2020 sayajin papuru. All rights reserved.
//

import XCTest
@testable import Reciplease

class RecipeServiceTests: XCTestCase {

    // MARK: - Reciplease Tests
    func testGetDishes() {
            let fakeSession = MockRecipeSession(fakeResponse: FakeResponse(response: nil, data: nil, error: nil))
            let requestService = RecipeService(session: fakeSession)
            let expectation = XCTestExpectation(description: "wait for queue change")
        
            requestService.getDishes(ingredients: [""]) { (result) in
               guard case .failure(let error) = result else {
                   XCTFail("Test getDishes method with no data failed")
                   return
               }
               XCTAssertNotNil(error)
               expectation.fulfill()
           }
           wait(for: [expectation], timeout: 0.01)
       }
    
    func testShouldPostFailedCallabackIfError() {
        let fakeSession = MockRecipeSession(fakeResponse: FakeResponse(response: nil, data: nil, error: FakeResponseData.networkError))
         let requestService = RecipeService(session: fakeSession)
         let expectation = XCTestExpectation(description: "wait for queue change")
        
         requestService.getDishes(ingredients: [""]) { (result) in
            guard case .failure(let error) = result else {
                XCTFail("Test getDishes method with no data failed")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testShouldPostFailedCallabackIfResponseOKandDataIncorrect() {
        let fakeSession = MockRecipeSession(fakeResponse: FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.incorrectData, error: nil))
         let requestService = RecipeService(session: fakeSession)
         let expectation = XCTestExpectation(description: "wait for queue change")
         requestService.getDishes(ingredients: [""]) { (result) in
            guard case .failure(let error) = result else {
                XCTFail("Test getDishes method with no data failed")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testShouldPostFailedCallabackIfResponseKOandCorrectData() {
        let fakeSession = MockRecipeSession(fakeResponse: FakeResponse(response: FakeResponseData.responseKO, data: FakeResponseData.correctData, error: nil))
         let requestService = RecipeService(session: fakeSession)
         let expectation = XCTestExpectation(description: "wait for queue change")
        
         requestService.getDishes(ingredients: [""]) { (result) in
            guard case .failure(let error) = result else {
                XCTFail("Test getDishes method with no data failed")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testShouldPostFailedCallabackResponseOKandCorrectData() {
        let fakeSession = MockRecipeSession(fakeResponse: FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.correctData, error: nil))
         let requestService = RecipeService(session: fakeSession)
         let expectation = XCTestExpectation(description: "wait for queue change")
        
         requestService.getDishes(ingredients: [""]) { (result) in
            XCTAssertNotNil(result)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
}
