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
    var recipe: Recipe?

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
    @available(iOS 13.0, *)
    @IBAction func favButtonTapped(_ sender: UIBarButtonItem) {
        sender.tintColor = .orange
    }
}

//MARK: - TableView Extension
extension RecipeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipe?.ingredientLines.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = recipeIngredientsTableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath)
        cell.textLabel?.text = recipe?.ingredientLines.joined(separator: ",")
        return cell
    }
}
