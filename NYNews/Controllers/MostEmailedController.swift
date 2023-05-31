//
//  MostEmailedController.swift
//  NYNews
//
//  Created by Solovei Ihor on 17.05.2023.
//

import UIKit
import SwipeCellKit

class MostEmailedController: BaseController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkManager.getURL(category: K.Categories.mostEmailed, reloadView: tableView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tabBarController?.navigationItem.title = "MOST EMAILED"
        tableView.reloadData()
    }
    
    //MARK: -  TableView Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.emailedCellIdentifier) as! SwipeTableViewCell
        
        cell.delegate = self
        
        cell.textLabel?.font = UIFont(name: K.Fonts.cellFont, size: 13)
        cell.textLabel?.text = networkManager.results[indexPath.row].title
        
        return cell
    }

}
