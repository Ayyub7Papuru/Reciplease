//
//  SearchViewController.swift
//  Reciplease
//
//  Created by SayajinPapuru on 13/02/2020.
//  Copyright © 2020 sayajin papuru. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    // MARK: - Properties
    var ingredients = [String]()
    var recipes: Reciplease?
    let recipeService = RecipeService()
    
    // MARK: - Outlets
    @IBOutlet weak var ingredientsTextField: UITextField!
    @IBOutlet weak var ingredientsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(keyboard))
        view.addGestureRecognizer(tap)
    }
    
    //MARK: - Functions
    @objc func keyboard() {
        self.view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dishesViewController = segue.destination as! DishesViewController
        dishesViewController.recipes = recipes
    }
    
    @IBAction func clearButtonTapped(_ sender: UIButton) {
        ingredients.removeAll()
        ingredientsTableView.reloadData()
        
    }
    @IBAction func searchButton(_ sender: UIButton) {
        recipeService.getDishes(ingredients: ingredients) { (result) in
            switch result {
            case .success(let recipes):
                DispatchQueue.main.async {
                    self.recipes = recipes
                    self.performSegue(withIdentifier: "searchToDish", sender: nil)
                }
            case .failure(_ ):
                let alert = UIAlertController(title: "No connection", message: "", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                
                self.present(alert, animated: true)
                
            }
        }
    }
    @IBAction func addButtonTapped(_ sender: UIButton) {
        ingredients.append(ingredientsTextField.text!)
        ingredientsTableView.reloadData()
        ingredientsTextField.text = ""
    }
    
}

//MARK: - TableView Extension
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredients", for: indexPath)
        cell.textLabel?.text = ingredients[indexPath.row]
        return cell
    }
}


