//
//  CoreDataManagerTest.swift
//  RecipleaseTests
//
//  Created by SayajinPapuru on 23/04/2020.
//  Copyright © 2020 sayajin papuru. All rights reserved.
//

@testable import Reciplease
import XCTest

final class CoreDataManagerTest: XCTestCase {

    
    var coreDataStack:  MockCoreDataStack!
    var coreDataManager: CoreDataManager!
    var data: Data?
    var recipe: Recipe?
    
    override func setUp() {
        super.setUp()
        coreDataStack = MockCoreDataStack()
        coreDataManager = CoreDataManager(coreDataStack: coreDataStack)
    }
    
    override func tearDown() {
        super.tearDown()
        coreDataManager = nil
        coreDataStack = nil
    }
    
    
    func testAddRecipeMethods_WhenARecipeIsCreated_ThenshouldBeCorrectlySaved() {
        coreDataManager.createRecipe(ingredients: [""], name: "", url: "", yield: "", time: "", data: data)
        XCTAssertFalse(coreDataManager.recipesFav.isEmpty)
        XCTAssertTrue(coreDataManager.recipesFav.count == 1)
    }
    
    func testDeleteAllRecipesMethod_WhenFavRecipesAreDeleted_ThenShouldCorrectlyDelete() {
        coreDataManager.createRecipe(ingredients: [""], name: "", url: "", yield: "", time: "", data: data)
        coreDataManager.deleteAllRecipes()
        XCTAssertTrue(coreDataManager.recipesFav.isEmpty)
    }

    func testDeleteOneRecipeMethod_WhenARecipeIsRemoved_ThenShouldCorrectlyDelegte() {
        coreDataManager.createRecipe(ingredients: [""], name: "", url: "", yield: "", time: "", data: data)
        coreDataManager.deleteRecipe(named: "")
        XCTAssertTrue(coreDataManager.recipesFav.isEmpty)
    }
    
    func testIsRegisteredMethod_WhenCheckingIfRecipeIsRegistered_ThenShouldBeRegistered() {
        coreDataManager.createRecipe(ingredients: [""], name: "", url: "", yield: "", time: "", data: data)
        XCTAssertTrue(coreDataManager.isRecipeRegistered(with: ""))
    }
    
    func testIsRegisteredMethod_WhenCheckingIfRecipeIsRegistered_ThenShouldnOTBeRegistered() {
        coreDataManager.createRecipe(ingredients: [""], name: "fr", url: "", yield: "", time: "", data: data)
        coreDataManager.deleteRecipe(named: "fr")
        
        XCTAssertFalse(coreDataManager.isRecipeRegistered(with: "fr"))
        XCTAssertTrue(coreDataManager.recipesFav.isEmpty)
        
    }
}
