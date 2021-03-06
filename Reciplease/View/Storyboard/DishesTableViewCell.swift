//
//  DishesTableViewCell.swift
//  Reciplease
//
//  Created by SayajinPapuru on 27/02/2020.
//  Copyright © 2020 sayajin papuru. All rights reserved.
//

import UIKit
import SDWebImage

class DishesTableViewCell: UITableViewCell {
    @IBOutlet weak var dishNameLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var personsSlices: UILabel!
    @IBOutlet weak var timeCookLabel: UILabel!
    @IBOutlet weak var dishImageView: UIImageView!
    
    var recipe: Recipe? {
        didSet {
            dishNameLabel.text = recipe?.label
            ingredientsLabel.text = recipe?.ingredientLines.joined(separator: ", ")
            personsSlices.text = String(recipe?.yield ?? 0)
            timeCookLabel.text = String(recipe?.totalTime ?? 0) + "mn"
            dishImageView.sd_setImage(with: URL(string: recipe?.image ?? ""), completed: nil)
            
            
        }
    }
   
    var favoriteRecipe: FavoriteRecipe? {
            didSet {
            dishNameLabel.text = favoriteRecipe?.name
            ingredientsLabel.text = favoriteRecipe?.ingredients?.joined(separator: ",")
            personsSlices.text = favoriteRecipe?.yield
            timeCookLabel.text = favoriteRecipe?.time
                if let data = favoriteRecipe?.image {
                    dishImageView.image = UIImage(data: data)
                } else {
                    
                }
            
        }
    }
}
