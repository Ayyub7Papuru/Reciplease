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
    
   func createRecipe(name: String, source: String, yield: String, time: String) {
        let recipeFaved = FavoriteRecipe(context: managedObjectContext)
        recipeFaved.name = name
        recipeFaved.source = source
//        recipeFaved.ingredients = String(ingredients)
        recipeFaved.time = time
        recipeFaved.yield = yield
        coreDataStack.saveContext()
    }
    
    func deleteAllRecipes() {
        recipesFav.forEach { managedObjectContext.delete($0)}
        coreDataStack.saveContext()
    }

}
