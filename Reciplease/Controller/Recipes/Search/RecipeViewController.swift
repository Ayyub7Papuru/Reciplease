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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var getDirectionsButton: UIButton!
    
    //MARK: - Properties
    var coreDataManager: CoreDataManager?
    var recipeDetails: RecipeDetails?
    var isComeFromFavorites: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else { return }
              let coredataStack = appdelegate.coreDataStack
        coreDataManager = CoreDataManager(coreDataStack: coredataStack)
        setUp()
        checkFav()
        recipeIngredientsTableView.tableFooterView = UIView()
    }
    
    //MARK: - Functions
    func setUp() {
        recipeLabel.text = recipeDetails?.name
        slicesLabel.text = recipeDetails?.yield
        totalTimeLabel.text = recipeDetails?.time
        if let data = recipeDetails?.data {
            recipeImageView.image = UIImage(data: data)
        } else {
            recipeImageView.image = UIImage(named: "noImage")
        }
        
    }
    func checkFav() {
        guard let coreDataManager = coreDataManager else { return }
        if coreDataManager.isRecipeRegistered(with: recipeDetails?.name ?? "") {
            favItemButton.tintColor = .orange
        } else {
            favItemButton.tintColor = .lightGray
        }
    }
        
    
    @IBAction func favButtonTapped(_ sender: UIBarButtonItem) {
        guard let coreDataManager = coreDataManager else { return }
        if coreDataManager.isRecipeRegistered(with: recipeDetails?.name ?? "") {
            coreDataManager.deleteRecipe(named: recipeDetails?.name ?? "")
            favItemButton.tintColor = .lightGray
            if isComeFromFavorites {
                navigationController?.popViewController(animated: true)
            }
        } else {
            saveRecipe()
            favItemButton.tintColor = .orange
        }
    }
    @IBAction func getDirectionsButton(_ sender: UIButton) {
        startActivityIndicator(sender)
        if let url = URL(string: recipeDetails?.url ?? "https://www.google.com") {
            UIApplication.shared.open(url)
        }
        stopActivityIndicator(sender)
    }
    
    private func saveRecipe() {
        coreDataManager?.createRecipe(ingredients: recipeDetails?.ingredients ?? [], name: recipeDetails?.name ?? "", url: recipeDetails?.url ?? "", yield: recipeDetails?.yield ?? "NA", time: recipeDetails?.time ?? "NA", data: recipeDetails?.data)
    }
    
    func startActivityIndicator(_ sender: UIButton) {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        sender.setTitle("", for: .normal)
    }
    func stopActivityIndicator(_ sender: UIButton) {
        activityIndicator.stopAnimating()
        sender.setTitle("Get directions", for: .normal)
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
