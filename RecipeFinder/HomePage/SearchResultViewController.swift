//
//  SearchResultViewController.swift
//  RecipeFinder
//
//  Created by Nazlıcan Çay on 17.07.2023.
//

import UIKit

class SearchResultViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var MealDataDisplay : [Meal] = []

    var searchQuery: String? {
        didSet {
            // Trigger fetchMeals function here when searchQuery changes.
            if let query = searchQuery {
                self.MealDataDisplay.removeAll() // Clear previous results

                APIManager.shared.fetchMeals(query: query) { result in
                    switch result {
                    case .success(let mealData):
                        // use mealData here
                        for meal in mealData.meals {
                            self.MealDataDisplay.append(meal)
                        }
                        DispatchQueue.main.async {
                            self.ResultTableView.reloadData()
                        }
                    case .failure(let error):
                        print(error)
                        // handle error here
                    }
                }
            }
        }
    }


    @IBOutlet weak var ResultTableView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ResultTableView.delegate = self
        ResultTableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        MealDataDisplay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ResultTableView.dequeueReusableCell(withIdentifier: "cell" , for: indexPath) as! ResultTableViewCell
       
        let recipe = MealDataDisplay[indexPath.row]
        cell.RecipeName.text = recipe.strMeal
        APIManager.shared.loadImage(from: URL(string: recipe.strMealThumb)!, into: cell.RecipeImg)

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0 // Or any other height you want
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMeal = MealDataDisplay[indexPath.row]
        performSegue(withIdentifier: "DetailSegue", sender: selectedMeal)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailSegue",
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
