//
//  FavoriteNewsController.swift
//  NYNews
//
//  Created by Solovei Ihor on 19.05.2023.
//

import UIKit
import CoreData
import SwipeCellKit

class FavoriteNewsController: UITableViewController, SwipeTableViewCellDelegate {

    var favoriteNews = [FavoriteNews?]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 80.0
        loadFavorites()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tabBarController?.navigationItem.title = "FAVORITE"
        loadFavorites()
    }

    // MARK: - Table view data source
    
    func loadFavorites(with request: NSFetchRequest<FavoriteNews> = FavoriteNews.fetchRequest(), predicate: NSPredicate? = nil) {
        
        do {
            favoriteNews = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
        
        tableView.reloadData()
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favoriteNews.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.favoriteCellIdentifier) as! SwipeTableViewCell
        
        cell.delegate = self
        
        cell.textLabel?.font = UIFont(name: K.Fonts.cellFont, size: 13)
        cell.textLabel!.text = favoriteNews[indexPath.row]!.title
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedResult = favoriteNews[indexPath.row]
        
        let urlString = selectedResult!.url, url = URL(string: urlString!)
        
        let webViewController = WebViewController()
        webViewController.url = url
        
        navigationController?.pushViewController(webViewController, animated: true)
        
    }
    
    func loadNotes(with request: NSFetchRequest<FavoriteNews> = FavoriteNews.fetchRequest(), predicate: NSPredicate? = nil) {
        
        do {
            favoriteNews = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
        
        tableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeCellKit.SwipeActionsOrientation) -> [SwipeCellKit.SwipeAction]? {
        
        guard orientation == .right else { return nil }
        
        let deleteFromFavorite = SwipeAction(style: .default, title: "Delete") { [self] action, indexPath in
            do {
                let cellToDelete = favoriteNews[indexPath.row]
                context.delete(cellToDelete!)
                try context.save()
                loadNotes()
                print("Title and url deleted")
            } catch {
                print("Error deleting title and url: \(error)")
            }
        }
        return [deleteFromFavorite]
    }
    
}
