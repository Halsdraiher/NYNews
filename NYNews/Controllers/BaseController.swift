//
//  BaseController.swift
//  NYNews
//
//  Created by Solovei Ihor on 22.05.2023.
//

import UIKit
import CoreData

class BaseController: UITableViewController {

    var networkManager = NetworkManager()
    var favoriteNews = [FavoriteNews]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        networkManager.results.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedResult = networkManager.results[indexPath.row]
        
        let urlString = selectedResult.url, url = URL(string: urlString)
        
        let webViewController = WebViewController()
        webViewController.url = url
        
        navigationController?.pushViewController(webViewController, animated: true)
    }
    
    //MARK: - Data Manipulating Methods
    
    //Save Data
    
    func saveFavorite() {
        
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    //MARK: - Swipe action
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        // Create swipe action for save news
        
        let saveToFavorite = UIContextualAction(style: .normal, title: "Save") { (action, view, compilationHandler) in
            
            let newFavorite = FavoriteNews(context: self.context)
            
            let results = self.networkManager.results[indexPath.row]
            
            newFavorite.title = results.title
            newFavorite.url = results.url
            
            self.saveFavorite()
            
            
        }
        
        return UISwipeActionsConfiguration(actions: [saveToFavorite])
    }
    
    
}
