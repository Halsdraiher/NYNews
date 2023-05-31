//
//  MostViewedController.swift
//  NYNews
//
//  Created by Solovei Ihor on 17.05.2023.
//

import UIKit
import SwipeCellKit

class MostViewedController: BaseController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkManager.getURL(category: K.Categories.mostViewed, reloadView: tableView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tabBarController?.navigationItem.title = "MOST VIEWED"
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.viewedCellIdentifier) as! SwipeTableViewCell
        
        cell.delegate = self
        
        cell.textLabel?.font = UIFont(name: K.Fonts.cellFont, size: 13)
        cell.textLabel?.text = networkManager.results[indexPath.row].title
        
        return cell
    }

}
