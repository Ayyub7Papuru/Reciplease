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
    
    var recipeTitle: String? = ""
    var recipeImage: String? = ""
    var recipeIngredients: [String?] = []
    var recipeSlices: String? = ""
    var recipeTime: String? = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    //MARK: - Functions
    func setUp() {
        recipeLabel.text = recipeTitle
        recipeImageView.sd_setImage(with: URL(string: recipeImage ?? ""), completed: nil)
        slicesLabel.text = recipeSlices
        totalTimeLabel.text = recipeTime
    }
    @available(iOS 13.0, *)
    @IBAction func favButtonTapped(_ sender: UIBarButtonItem) {
        sender.tintColor = .orange
    }
}

//MARK: - TableView Extension
extension RecipeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeIngredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = recipeIngredientsTableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath)
        cell.textLabel?.text = recipeIngredients[indexPath.row]
        return cell
    }
}
