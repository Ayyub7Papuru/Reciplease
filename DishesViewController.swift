//
//  DishesViewController.swift
//  Reciplease
//
//  Created by SayajinPapuru on 27/02/2020.
//  Copyright © 2020 sayajin papuru. All rights reserved.
//

import UIKit

class DishesViewController: UIViewController {
    @IBOutlet weak var dishesTableView: UITableView!
    var recipes: Reciplease?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dishesTableView.register(UINib(nibName: "DishesTableViewCell", bundle: nil), forCellReuseIdentifier: "dishCell")
       
    }
    
}


extension DishesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes?.hits.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dishesTableView.dequeueReusableCell(withIdentifier: "dishCell", for: indexPath) as! DishesTableViewCell
        cell.recipe = recipes?.hits[indexPath.row].recipe
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return dishesTableView.frame.height / 3
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        <#code#>
//    }
}
