//
//  SearchViewController.swift
//  Reciplease
//
//  Created by SayajinPapuru on 13/02/2020.
//  Copyright © 2020 sayajin papuru. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    var ingredients = [String]()
    
    let recipeService = RecipeService()
    @IBOutlet weak var ingredientsTextField: UITextField!
    @IBOutlet weak var ingredientsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(keyboard))
        view.addGestureRecognizer(tap)
    }
    @objc func keyboard() {
        self.view.endEditing(true)
    }
    
    @IBAction func clearButtonTapped(_ sender: UIButton) {
        ingredients.removeAll()
        let indexPath = IndexPath(item: ingredients.count, section: 0)
        ingredientsTableView.deleteRows(at: [indexPath], with: .fade)
        ingredientsTableView.reloadData()
        
    }
    @IBAction func searchButton(_ sender: UIButton) {
        recipeService.getDishes { (result) in
        }
    }
    @IBAction func addButtonTapped(_ sender: UIButton) {
        ingredients.append(ingredientsTextField.text!)
        ingredientsTableView.reloadData()
        ingredientsTextField.text = ""
    }
    
}

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


