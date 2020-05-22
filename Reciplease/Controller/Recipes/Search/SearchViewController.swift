//
//  SearchViewController.swift
//  Reciplease
//
//  Created by SayajinPapuru on 13/02/2020.
//  Copyright © 2020 sayajin papuru. All rights reserved.
//

import UIKit

final class SearchViewController: UIViewController {
    
    // MARK: - Properties
    
    private var ingredients = [String]()
    private var recipes: Reciplease?
    private let recipeService = RecipeService()
    
    // MARK: - Outlets
    
    @IBOutlet private weak var ingredientsTextField: UITextField!
    @IBOutlet private weak var ingredientsTableView: UITableView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var searchButton: UIButton!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(keyboard))
        view.addGestureRecognizer(tap)
        ingredientsTableView.tableFooterView = UIView()
    }
    
    //MARK: - Functions
    
    @objc func keyboard() {
        view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let dishesViewController = segue.destination as? DishesViewController else { return }
        dishesViewController.recipes = recipes
    }
    
    @IBAction private func clearButtonTapped(_ sender: UIButton) {
        ingredients.removeAll()
        ingredientsTableView.reloadData()
        
    }
    
    @IBAction private func searchButton(_ sender: UIButton) {
        startActivityIndicator(sender)
        recipeService.getDishes(ingredients: ingredients) { (result) in
            switch result {
            case .success(let recipes):
                DispatchQueue.main.async {
                    self.recipes = recipes
                    self.stopActivityIndicator(sender)
                    self.performSegue(withIdentifier: "searchToDish", sender: nil)
                }
            case .failure(_ ):
                self.stopActivityIndicator(sender)
                let alert = UIAlertController(title: "No connection", message: "", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                
                self.present(alert, animated: true)
                
            }
        }
    }
    
    @IBAction private func addButtonTapped(_ sender: UIButton) {
        ingredients.append(ingredientsTextField.text!)
        ingredientsTableView.reloadData()
        ingredientsTextField.text = ""
    }
    
    func startActivityIndicator(_ sender: UIButton) {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        sender.setTitle("", for: .normal)
    }
    
    func stopActivityIndicator(_ sender: UIButton) {
        activityIndicator.stopAnimating()
        sender.setTitle("Search for recipes", for: .normal)
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
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Add some ingredients"
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .darkGray
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return ingredients.isEmpty  ? 200 : 0
    }
}


