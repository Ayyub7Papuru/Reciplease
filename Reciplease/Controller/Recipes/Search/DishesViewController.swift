//
//  DishesViewController.swift
//  Reciplease
//
//  Created by SayajinPapuru on 27/02/2020.
//  Copyright © 2020 sayajin papuru. All rights reserved.
//

import UIKit

final class DishesViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet private weak var dishesTableView: UITableView!
    
    //MARK: - Properties
    var recipes: Reciplease?
    private var recipe: Recipe?
    
    // MARK: - View Life Cycle
    
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
        tableView.deselectRow(at: indexPath, animated: true)
        recipe = recipes?.hits[indexPath.row].recipe
        performSegue(withIdentifier: "cellToRecipe", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let recipeVC = segue.destination as? RecipeViewController else { return }
        let recipeDetails = RecipeDetails(name: recipe?.label ?? "", ingredients: recipe?.ingredientLines ?? [], yield: String(recipe?.yield ?? 0), time: recipe?.totalTime.convertToTime ?? "NA", url: recipe?.url ?? "", data: recipe?.image.data)
        recipeVC.recipeDetails = recipeDetails
        recipeVC.isComeFromFavorites = false
    }
    
}

extension Int {
    var convertToTime: String {
        get {
            let minutes = self % (60 * 60) / 60
            let hours = self / 60 / 60
            let timeFormatString = String(format: "%01dh%02dm", hours, minutes)
            return timeFormatString
        }
    }
}
