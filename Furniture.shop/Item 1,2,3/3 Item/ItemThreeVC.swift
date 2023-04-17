//
//  ItemThreeVC.swift
//  Furniture.shop
//
//  Created by Xachik on 30.01.23.
//

import UIKit

class ItemThreeVC: UIViewController, UISearchResultsUpdating {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        searchV()
        
    }
    
    func searchV() {
        
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        self.navigationItem.searchController = search
        
    }
    @IBAction func translationButton(_ sender: Any) {
        
        let alert = UIAlertController(title: nil, message: "Language", preferredStyle: .actionSheet)
        let freBtn = UIAlertAction(title: "Russian", style: .default)
        let comBtn = UIAlertAction(title: "Armenia", style: .default)
        let galBtn = UIAlertAction(title: "English", style: .default)
        let cencelBtn = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(comBtn)
        alert.addAction(galBtn)
        alert.addAction(cencelBtn)
        alert.addAction(freBtn)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
       print(searchController.searchBar.text!)
   }
}
