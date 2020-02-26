//
//  RecipesViewController.swift
//  Reciplease
//
//  Created by SayajinPapuru on 13/02/2020.
//  Copyright © 2020 sayajin papuru. All rights reserved.
//

import UIKit

class RecipesViewController: UIViewController {
    @IBOutlet weak var recipesTableView: UITableView!
    let recipe = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        recipesTableView.register(UINib(nibName: "RecipeTableViewCell", bundle: nil), forCellReuseIdentifier: "recipeCell")
          recipesTableView.register(UINib(nibName: "TestTableViewCell", bundle: nil), forCellReuseIdentifier: "recipeCell")
    }

}

extension RecipesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipe.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath) as! RecipeTableViewCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath) as! TestTableViewCell
//        cell.recipeNameLabel.text = recipe[indexPath.row]
        cell.testLabel.text = recipe[indexPath.row]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / 3
    }
    
}
