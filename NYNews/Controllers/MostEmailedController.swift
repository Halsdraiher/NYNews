//
//  MostEmailedController.swift
//  NYNews
//
//  Created by Solovei Ihor on 17.05.2023.
//

import UIKit
import SwipeCellKit
import CoreData

class MostEmailedController: BaseController {
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkManager.getURL(category: K.Categories.mostEmailed, reloadView: tableView)
        
        tableView.register(UINib(nibName: K.nibName, bundle: nil), forCellReuseIdentifier: K.reusableCell)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tabBarController?.navigationItem.title = "MOST EMAILED"
        tableView.reloadData()
    }
    
    //MARK: -  TableView Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.reusableCell, for: indexPath) as! NewsCell
        
//        cell.delegate = self
        
        cell.textCell?.font = UIFont(name: K.Fonts.cellFont, size: 13)
        cell.textCell?.text = networkManager.results[indexPath.row].title
        
        cell.buttonTapHandler = { [weak self] indexPath in
            // Обробка натискання кнопки і передача IndexPath назад до контролера таблиці
            self?.handleButtonTap(indexPath: indexPath)
        }
        
        DispatchQueue.main.async {
            self.updateCellBorder(indexPath: indexPath)
        }

        return cell
    }
    
    func handleButtonTap(indexPath: IndexPath) {
        // Виконуйте дії, використовуючи IndexPath
        print("Button tapped in cell at IndexPath: \(indexPath)")
        
        let title = networkManager.results[indexPath.row].title
        let url = networkManager.results[indexPath.row].url

        
        if checkExistingTitle(title) {
            
            deleteTitleFromFavorites(title)
            tableView.reloadData()
            
        } else {
            
            saveTitleToFavorites(title, url)
            tableView.reloadData()
            
        }
    }


}

