//
//  ShowDetailByCategoryViewController.swift
//  RecipeFinder
//
//  Created by Nazlıcan Çay on 28.07.2023.
//

import UIKit

class ShowDetailByCategoryViewController: UIViewController {

    var meal: Meal?
    
    @IBOutlet weak var MealArea: UILabel!
   
    @IBOutlet weak var MealName: UILabel!
    
    @IBOutlet weak var MealPicture: UIImageView!
    
    @IBOutlet weak var MealRecipe: UILabel!
   
    @IBOutlet weak var Ingredients: UILabel!
   
    @IBOutlet weak var MealCategorie: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        if let meal = meal {
            MealName.text = meal.strMeal
            APIManager.shared.loadImage(from: URL(string: meal.strMealThumb)!, into: MealPicture)
            MealRecipe.text = meal.strInstructions
            Ingredients.text = APIManager.shared.ingredients.map { "• \($0)" }.joined(separator: "\n")
            MealCategorie.text = meal.strCategory
            MealArea.text = meal.strArea
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
