//
//  FavoritesViewController.swift
//  Reciplease
//
//  Created by SayajinPapuru on 13/02/2020.
//  Copyright © 2020 sayajin papuru. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var favoriteTableView: UITableView!
    
    //MARK: - Properties
    
    var coreDataManager: CoreDataManager?
    var recipeDetails: RecipeDetails?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else { return }
              let coredataStack = appdelegate.coreDataStack
        coreDataManager = CoreDataManager(coreDataStack: coredataStack)
        
        favoriteTableView.register(UINib(nibName: "DishesTableViewCell", bundle: nil), forCellReuseIdentifier: "dishCell")
        favoriteTableView.reloadData()

    }
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coreDataManager?.recipesFav.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favoriteTableView.dequeueReusableCell(withIdentifier: "dishCell", for: indexPath) as! DishesTableViewCell
        let favoriteRecipe = coreDataManager?.recipesFav[indexPath.row]
        cell.favoriteRecipe = favoriteRecipe
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        favoriteTableView.deselectRow(at: indexPath, animated: true)
        let recipe = coreDataManager?.recipesFav[indexPath.row]
        recipeDetails = RecipeDetails(name: recipe?.name ?? "", ingredients: recipe?.ingredients ?? [], yield: recipe?.yield ?? "NA", time: recipe?.time ?? "NA", source: recipe?.source ?? "", data: recipe?.image)
        performSegue(withIdentifier: "favCellToRecipe", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "favCellToRecipe") {
        let vc = segue.destination as! RecipeViewController
            vc.recipeDetails = recipeDetails
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return favoriteTableView.frame.height / 3
    }
}

