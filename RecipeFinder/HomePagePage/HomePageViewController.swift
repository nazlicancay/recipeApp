//
//  RandomRecipePageViewController.swift
//  RecipeFinder
//
//  Created by Nazlıcan Çay on 28.07.2023.
//

import UIKit

class HomePageViewController: UIViewController,UISearchResultsUpdating {

    @IBOutlet weak var btnDesc: UILabel!
    var randomRecipe: Meal?
    
    @IBOutlet weak var FindRecipeBtn: UIButton!
    var searchResultViewController: SearchResultViewController?
    @IBOutlet weak var DisplayRandomRecipe: UIButton!
    
    
    override func viewDidLoad() {
        title = "Home Page"
        view.backgroundColor = Colors.BackgroundColor
      
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = Colors.BtnAndTextColor
        
        btnDesc.textColor = Colors.BtnAndTextColor
        
        FindRecipeBtn.backgroundColor = Colors.BtnAndTextColor
        FindRecipeBtn.titleLabel?.textColor = .white
        FindRecipeBtn.layer.cornerRadius = FindRecipeBtn.frame.height / 2
        FindRecipeBtn.setTitleColor(.white, for: .highlighted)
        FindRecipeBtn.setTitleColor(.white, for: .selected)

        
        let searchResultViewController = storyboard?.instantiateViewController(withIdentifier: "SearchResultViewControllerIdentifier") as? SearchResultViewController
        let searchController = UISearchController(searchResultsController: searchResultViewController)

        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        
        super.viewDidLoad()
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text,
                 let searchResultViewController = searchController.searchResultsController as? SearchResultViewController else {
               return
           }
            searchResultViewController.searchQuery = text
            
        
           
    }
    
    
    @IBAction func DisplayRandomRecipe(_ sender: Any) {
        APIManager.shared.fetchRandomMeal { result in
               switch result {
               case .success(let meal):
                   DispatchQueue.main.async {
                       self.performSegue(withIdentifier: "ShowRandomMealDetail", sender: meal)
                   }
               case .failure(let error):
                   print("Failed to fetch random meal: \(error)")
                   // Handle the error appropriately.
               }
           }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowRandomMealDetail",
            let destinationVC = segue.destination as? MealDetailViewController,
            let meal = sender as? Meal {
            destinationVC.meal = meal
            
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
