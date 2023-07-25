//
//  HomePageViewController.swift
//  RecipeFinder
//
//  Created by Nazlıcan Çay on 17.07.2023.
//

import UIKit



class HomePageViewController: UIViewController, UISearchResultsUpdating {
    
    var searchResultViewController: SearchResultViewController?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let searchResultViewController = storyboard?.instantiateViewController(withIdentifier: "SearchResultViewControllerIdentifier") as? SearchResultViewController
        let searchController = UISearchController(searchResultsController: searchResultViewController)

        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController

    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text,
                 let searchResultViewController = searchController.searchResultsController as? SearchResultViewController else {
               return
           }
            searchResultViewController.searchQuery = text
            
        
           
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
