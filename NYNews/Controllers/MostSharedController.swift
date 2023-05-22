//
//  MostSharedController.swift
//  NYNews
//
//  Created by Solovei Ihor on 17.05.2023.
//

import UIKit

class MostSharedController: BaseController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkManager.getURL(category: K.Categories.mostShared, reloadView: tableView)
    }
    

    override func viewDidAppear(_ animated: Bool) {
        tabBarController?.navigationItem.title = "MOST SHARED"
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.sharedCellIdentifer)
        
        cell?.textLabel?.font = UIFont(name: K.Fonts.cellFont, size: 13)
        cell?.textLabel?.text = networkManager.results[indexPath.row].title
        
        return cell!
    }
    
}
