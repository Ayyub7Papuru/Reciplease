//
//  RecipeViewController.swift
//  
//
//  Created by SayajinPapuru on 12/03/2020.
//

import UIKit

class RecipeViewController: UIViewController {
    
    //MARK: - Outlets 
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var recipeLabel: UILabel!
    @IBOutlet weak var recipeIngredientsTableView: UITableView!
    @IBOutlet weak var slicesLabel: UILabel!
    @IBOutlet weak var totalTimeLabel: UILabel!
    @IBOutlet weak var favItemButton: UIBarButtonItem!
    
    //MARK: - Properties
    var coreDataManager: CoreDataManager?
    var recipeDetails: RecipeDetails?

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else { return }
              let coredataStack = appdelegate.coreDataStack
        coreDataManager = CoreDataManager(coreDataStack: coredataStack)
        setUp()
    }
    
    //MARK: - Functions
    func setUp() {
        recipeLabel.text = recipeDetails?.name
//        recipeImageView.sd_setImage(with: URL(string: recipe?.image ?? ""), completed: nil)
        slicesLabel.text = recipeDetails?.yield
        totalTimeLabel.text = recipeDetails?.time
        if let data = recipeDetails?.data {
            recipeImageView.image = UIImage(data: data)
        } else {
            //Image par defaut
        }
        
    }
    ///Lorsqu'on est dans recipeViewController, le coeur doit etre orange si la recette est dans les favoris, si on decoche le coeur la recette disparait des favoris. Lorsqu'on est dans le controller des favoris et qu'on decoche le coeur de la vue des details on retourne imédiatement dans l'ecran des favs.  Trouver un moyen, aller champion repose toi et reflechis bien a comment on va y arriver
    
//    @IBAction func favButtonTapped(_ sender: UIBarButtonItem) {
//        guard let coreDataManager = coreDataManager else { return }
//        if coreDataManager.isRecipeRegistered(with: recipeDetails?.name ?? "") {
//            coreDataManager.deleteRecipe(named: recipeDetails?.name ?? "")
//            favItemButton.tintColor = .lightGray
//        } else {
//            saveRecipe()
//            favItemButton.tintColor = .orange
//        }
//    }
 
    private func saveRecipe() {
        coreDataManager?.createRecipe(ingredients: recipeDetails?.ingredients ?? [], name: recipeDetails?.name ?? "", source: recipeDetails?.source ?? "", yield: recipeDetails?.yield ?? "NA", time: recipeDetails?.time ?? "NA", data: recipeDetails?.data)
    }
    
}

//MARK: - TableView Extension
extension RecipeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeDetails?.ingredients.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = recipeIngredientsTableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath)
        cell.textLabel?.text = recipeDetails?.ingredients[indexPath.row]
        return cell
    }
}
