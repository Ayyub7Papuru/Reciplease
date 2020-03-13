//
//  RecipeViewController.swift
//  
//
//  Created by SayajinPapuru on 12/03/2020.
//

import UIKit

class RecipeViewController: UIViewController {
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var recipeLabel: UILabel!
    @IBOutlet weak var recipeIngredientsTableView: UITableView!
    
    var recipe: Recipe?
    var myString: String? = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        recipeLabel.text = myString
    }
}
