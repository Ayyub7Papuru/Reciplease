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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favoriteTableView.reloadData()
    }
    
    @IBAction func unwindToFavorite(_ sender: UIStoryboardUnwindSegueSource) {}
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
        recipeDetails = RecipeDetails(name: recipe?.name ?? "", ingredients: recipe?.ingredients ?? [], yield: recipe?.yield ?? "NA", time: recipe?.time ?? "NA", url: recipe?.url ?? "", data: recipe?.image)
        performSegue(withIdentifier: "favCellToRecipe", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "favCellToRecipe") {
        let vc = segue.destination as! RecipeViewController
            vc.recipeDetails = recipeDetails
            vc.isComeFromFavorites = true
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return favoriteTableView.frame.height / 3
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
           let label = UILabel()
           label.text = "Please add some favorites"
           label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
           label.textAlignment = .center
           label.textColor = .darkGray
           return label
       }

       func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return coreDataManager?.recipesFav.isEmpty ?? true ? 200 : 0
       }
}

