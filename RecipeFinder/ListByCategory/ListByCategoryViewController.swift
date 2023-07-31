//
//  ListByCategoryViewController.swift
//  RecipeFinder
//
//  Created by Nazlıcan Çay on 26.07.2023.
//

import UIKit

class ListByCategoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    

    var selectedCategory: Category?
    var SelecedCategoryMeals:[Meal] = []
    
    @IBOutlet weak var MealTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MealTableView.dataSource = self
        MealTableView.delegate = self

        
        guard let category = selectedCategory else {
                   return
               }
        
        APIManager.shared.fetchMealsByCategory(for:String(category.strCategory)) { result in
            print(category.strCategory)
            switch result {
            case .success(let CategoryMeal):
                self.SelecedCategoryMeals = CategoryMeal
                print(self.SelecedCategoryMeals.count)
                DispatchQueue.main.async {
                    self.MealTableView.reloadData()
                }
            case .failure(let error):
                print("Failed to fetch meals: \(error)")
                // Handle the error appropriately.
            }
        }
            }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        SelecedCategoryMeals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = MealTableView.dequeueReusableCell(withIdentifier: "SearcByCategoryCell" , for: indexPath) as! ListByCategoryMealTableViewCell
       
        let recipe = SelecedCategoryMeals[indexPath.row]
        cell.RecipeName.text = recipe.strMeal
        APIManager.shared.loadImage(from: URL(string: recipe.strMealThumb)!, into: cell.RecipeImg)


        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0 // Or any other height you want
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMeal = SelecedCategoryMeals[indexPath.row]
        performSegue(withIdentifier: "ShowDetailFromCategory", sender: selectedMeal)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetailFromCategory",
           let destinationVC = segue.destination as? ShowDetailByCategoryViewController,
           let meal = sender as? Meal {
            destinationVC.meal = meal
           print(meal.strMeal)
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


