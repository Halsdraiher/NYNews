//
//  MostEmailedController.swift
//  NYNews
//
//  Created by Solovei Ihor on 17.05.2023.
//

import UIKit
import Alamofire

class MostEmailedController: UITableViewController {

    let networkManager = NetworkManager()
    var results = [Results]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkManager.fetchData { result in
            switch result {
            case .success(let userResult):
    
                let result = userResult.results
                self.results = result
                
            case .failure(let error):
                print(error)
            }
            self.tableView.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tabBarController?.navigationItem.title = "MOST EMAILED"
        self.tableView.reloadData()
    }
        
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        results.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.emailedCellIdentifer)
        
        cell?.textLabel?.font = UIFont(name: K.Fonts.cellFont, size:13)
        cell?.textLabel?.text = results[indexPath.row].title
        
        return cell!
    }

    
        
    
}



