//
//  BaseController.swift
//  NYNews
//
//  Created by Solovei Ihor on 22.05.2023.
//

import UIKit

class BaseController: UITableViewController {

    var networkManager = NetworkManager()
    
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
    
}
