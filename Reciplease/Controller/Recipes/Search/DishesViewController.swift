//
//  DishesViewController.swift
//  Reciplease
//
//  Created by SayajinPapuru on 27/02/2020.
//  Copyright © 2020 sayajin papuru. All rights reserved.
//

import UIKit

class DishesViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var dishesTableView: UITableView!
    
    //MARK: - Properties
    var recipes: Reciplease?
    var recipe: Recipe?
    
    var dishName: String = ""
    var dishImage: String = ""
    var dishIngredients: [String] = []
    var dishSlices: String = ""
    var dishTime: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dishesTableView.register(UINib(nibName: "DishesTableViewCell", bundle: nil), forCellReuseIdentifier: "dishCell")
       
    }
    
}

//MARK: - TableView Extension
extension DishesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes?.hits.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dishesTableView.dequeueReusableCell(withIdentifier: "dishCell", for: indexPath) as! DishesTableViewCell
        cell.recipe = recipes?.hits[indexPath.row].recipe
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return dishesTableView.frame.height / 3
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! DishesTableViewCell
        dishName = cell.dishNameLabel.text ?? ""
        dishImage = cell.recipe?.image ?? ""
        dishIngredients = cell.recipe?.ingredientLines ?? [""]
        performSegue(withIdentifier: "cellToRecipe", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "cellToRecipe") {
            let info = segue.destination as! RecipeViewController
            info.recipeTitle = dishName
            info.recipeImage = dishImage
            info.recipeIngredients = dishIngredients
        }
    }

}
