//
//  BaseController.swift
//  NYNews
//
//  Created by Solovei Ihor on 22.05.2023.
//

import UIKit
import CoreData
import SwipeCellKit

class BaseController: UITableViewController, SwipeTableViewCellDelegate {
    
    var fetchedResultsController: NSFetchedResultsController<NSManagedObject>?
   
    var networkManager = NetworkManager()
    var favoriteNewsArray = [FavoriteNews?]()
    let newsCell = NewsCell()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 60.0
        
    }
    
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
    
    func checkExistingTitle(_ title: String) -> Bool {
        let fetchRequest: NSFetchRequest<FavoriteNews> = FavoriteNews.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "title == %@", title)
        
        do {
            let count = try context.count(for: fetchRequest)
            return count > 0
        } catch {
            print("Error checking existing title: \(error)")
            return false
        }
    }
    
    func saveTitleToFavorites(_ title: String,_ url: String) {
        let newFavorite = FavoriteNews(context: context)
        newFavorite.title = title
        newFavorite.url = url
        newFavorite.added = true
        
        do {
            try context.save()
            print("Title and url saved")
        } catch {
            print("Error saving title and url: \(error)")
        }
    }
    
    func deleteTitleFromFavorites(_ title: String) {
        let fetchRequest: NSFetchRequest<FavoriteNews> = FavoriteNews.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "title == %@", title)
        
        do {
            if let existingFavorite = try context.fetch(fetchRequest).first {
                context.delete(existingFavorite)
                try context.save()
                print("Title and url deleted")
            }
        } catch {
            print("Error deleting title and url: \(error)")
        }
    }
    
    //MARK: - Swipe action
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeCellKit.SwipeActionsOrientation) -> [SwipeCellKit.SwipeAction]? {
        
        let title = networkManager.results[indexPath.row].title
        let url = networkManager.results[indexPath.row].url
        
        guard orientation == .right else { return nil }
        
        let saveFavorite = SwipeAction(style: .default, title: "Favorite") { [self] action, indexPath in
            if checkExistingTitle(title) {
                
                deleteTitleFromFavorites(title)
                
                tableView.reloadData()
                
            } else {
                
                saveTitleToFavorites(title, url)
                
                tableView.reloadData()
                
            }
        }
        
        return [saveFavorite]
    }
    
    func updateCellBorder(indexPath: IndexPath) {
        let title = self.networkManager.results[indexPath.row].title
        let updatedCell = self.tableView.cellForRow(at: indexPath) as! NewsCell
        
        if self.checkExistingTitle(title) {
            updatedCell.favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            updatedCell.favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
        }
    }
}
