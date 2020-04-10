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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else { return }
              let coredataStack = appdelegate.coreDataStack
        coreDataManager = CoreDataManager(coreDataStack: coredataStack)
        
        favoriteTableView.register(UINib(nibName: "DishesTableViewCell", bundle: nil), forCellReuseIdentifier: "dishCell")

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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return favoriteTableView.frame.height / 3
    }
}

