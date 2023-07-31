//
//  RandomRecipePageViewController.swift
//  RecipeFinder
//
//  Created by Nazlıcan Çay on 28.07.2023.
//

import UIKit

class RandomRecipePageViewController: UIViewController {

    var randomRecipe: Meal?
    
    @IBOutlet weak var DisplayRandomRecipe: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
