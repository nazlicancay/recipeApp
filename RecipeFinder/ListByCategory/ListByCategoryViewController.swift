//
//  ListByCategoryViewController.swift
//  RecipeFinder
//
//  Created by Nazlıcan Çay on 26.07.2023.
//

import UIKit

class ListByCategoryViewController: UIViewController {

    var selectedCategory: Category?
    var SelecedCategoryMeals:[Meal] = []
    override func viewDidLoad() {
        super.viewDidLoad()

      //  print(selectedCategory?.strCategory)
        
        guard let category = selectedCategory else {
                   return
               }
        
        APIManager.shared.fetchMealsByCategory(for:String(category.strCategory)) { result in
            print(category.strCategory)
                    switch result {
                    case .success(let CategoryMeal):
                        self.SelecedCategoryMeals = CategoryMeal
                        print(self.SelecedCategoryMeals.count)
                    case .failure(let error):
                        print("Failed to fetch meals: \(error)")
                        // Handle the error appropriately.
                    }
                }
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


