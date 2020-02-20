//
//  SearchViewController.swift
//  Reciplease
//
//  Created by SayajinPapuru on 13/02/2020.
//  Copyright © 2020 sayajin papuru. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    let recipeService = RecipeService()
    @IBOutlet weak var ingredientsTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    @IBAction func clearButtonTapped(_ sender: UIButton) {
    }
    @IBAction func searchButton(_ sender: UIButton) {
        recipeService.getDishes { (result) in
        }
    }
    
}
