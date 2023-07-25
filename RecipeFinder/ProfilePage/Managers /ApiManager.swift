//
//  ApiManager.swift
//  RecipeFinder
//
//  Created by Nazlıcan Çay on 18.07.2023.
//

import Foundation
import UIKit

class APIManager {
    static let shared = APIManager()
    let baseURL = "https://www.themealdb.com/api/json/v1/1/search.php?s="
    var ingredients: [String] = []


    func fetchMeals(query: String, completion: @escaping (Result<MealData, Error>) -> Void) {
        let urlString = "\(baseURL)\(query)"
        guard let url = URL(string: urlString) else { return }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let mealData = try JSONDecoder().decode(MealData.self, from: data)
                   
                    if let meal = mealData.meals.first {
                                      let mealMirror = Mirror(reflecting: meal)

                                      for child in mealMirror.children {
                                          if child.label?.contains("strIngredient") == true, let ingredient = child.value as? String, !ingredient.isEmpty {
                                              self.ingredients.append(ingredient)
                                          } 
                                      }
                                  }
                    completion(.success(mealData))
                } catch(let error) {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
    func loadImage(from url: URL, into imageView: UIImageView) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                DispatchQueue.main.async {
                    imageView.image = UIImage(data: data)
                }
            }
        }.resume()
    }
}
