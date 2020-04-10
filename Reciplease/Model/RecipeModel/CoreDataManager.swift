//
//  CoreDataManager.swift
//  Reciplease
//
//  Created by SayajinPapuru on 31/03/2020.
//  Copyright © 2020 sayajin papuru. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    
    //MARK: - Properties
    
    private let coreDataStack: CoreDataStack
    private let managedObjectContext: NSManagedObjectContext
    
    var recipesFav: [FavoriteRecipe] {
        let request: NSFetchRequest<FavoriteRecipe> = FavoriteRecipe.fetchRequest()
        guard let recipesFav = try? managedObjectContext.fetch(request) else { return []}
        return recipesFav
    }
    
    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
        self.managedObjectContext = coreDataStack.mainContext
    }
    
    //MARK: - Functions
    
    func createRecipe(ingredients: [String], name: String, source: String, yield: String, time: String, data: Data?) {
        let recipeFaved = FavoriteRecipe(context: managedObjectContext)
        recipeFaved.name = name
        recipeFaved.source = source
        recipeFaved.ingredients = ingredients
        recipeFaved.time = time
        recipeFaved.yield = yield
        recipeFaved.image = data
        coreDataStack.saveContext()
    }
    
    func deleteAllRecipes() {
        recipesFav.forEach { managedObjectContext.delete($0)}
        coreDataStack.saveContext()
    }
    
    func deleteRecipe(named name: String) {
        let request: NSFetchRequest<FavoriteRecipe> = FavoriteRecipe.fetchRequest()
        request.predicate = NSPredicate(format: "name = %@", name)
        guard let recipesFav = try? managedObjectContext.fetch(request) else { return }
        guard let recipe = recipesFav.first else { return }
        managedObjectContext.delete(recipe)
        coreDataStack.saveContext()
    }
    
    func isRecipeRegistered(with name: String) -> Bool {
        let request: NSFetchRequest<FavoriteRecipe> = FavoriteRecipe.fetchRequest()
        request.predicate = NSPredicate(format: "name = %@", name)
        guard let recipesFav = try? managedObjectContext.fetch(request) else { return false}
        
        if recipesFav.isEmpty {
            return false
        }
        
        return true
    }
}
