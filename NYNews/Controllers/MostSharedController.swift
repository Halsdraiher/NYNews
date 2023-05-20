//
//  MostSharedController.swift
//  NYNews
//
//  Created by Solovei Ihor on 17.05.2023.
//

import UIKit

class MostSharedController: UITableViewController {
    
    let networkManager = NetworkManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkManager.getURL(category: K.Categories.mostShared, reloadView: tableView)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tabBarController?.navigationItem.title = "MOST SHARED"
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        networkManager.results.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.sharedCellIdentifer)
        
        cell?.textLabel?.font = UIFont(name: K.Fonts.cellFont, size: 13)
        cell?.textLabel?.text = networkManager.results[indexPath.row].title
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Отримуємо вибраний об'єкт з вашого масиву даних
        let selectedResult = networkManager.results[indexPath.row]
        
        // Перевіряємо, чи маємо непустий URL
        let urlString = selectedResult.url, url = URL(string: urlString)
        // Створюємо екземпляр WebViewController та передаємо URL
        let webViewController = WebViewController()
        webViewController.url = url
        
        // Відкриваємо новий екран WebView
        navigationController?.pushViewController(webViewController, animated: true)
    }
    
}
