//
//  RecipeViewController.swift
//  
//
//  Created by SayajinPapuru on 12/03/2020.
//

import UIKit

class RecipeViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var recipeLabel: UILabel!
    @IBOutlet weak var recipeIngredientsTableView: UITableView!
    @IBOutlet weak var slicesLabel: UILabel!
    @IBOutlet weak var totalTimeLabel: UILabel!
    
    //MARK: - Properties
    var recipe: RecipesFaved?
    var recipesArray: [RecipesFaved] = []
    var coreDataManager: CoreDataManager?
    var coreDataStack: CoreDataStack?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    //MARK: - Functions
    func setUp() {
        recipeLabel.text = recipe?.label
        recipeImageView.sd_setImage(with: URL(string: recipe?.image ?? ""), completed: nil)
        slicesLabel.text = String(recipe?.yield ?? 0)
        totalTimeLabel.text = String(recipe?.totalTime ?? 0) + "mn"
    }
    @IBAction func favButtonTapped(_ sender: UIBarButtonItem) {
        saveRecipe()
    }
    
    private func saveRecipe() {
        coreDataManager?.createRecipe(name: recipe?.label ?? "", source: recipe?.source ?? "", yield: String(recipe?.yield ?? 0), time: String(recipe?.totalTime ?? 0))
        recipesArray.append(recipe!)
        coreDataStack?.saveContext()
        
    }
    
}

//MARK: - TableView Extension
extension RecipeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipe?.ingredientLines.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = recipeIngredientsTableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath)
        cell.textLabel?.text = recipe?.ingredientLines[indexPath.row]
        return cell
    }
}
