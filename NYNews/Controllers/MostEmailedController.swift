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
    var titleName = [Results]()
    var titleNumberCount = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkManager.fetchData { result in
            switch result {
            case .success(let userResult):
                
                let titlesNumber = userResult.results.count
                self.titleNumberCount = titlesNumber
                
                let title = userResult.results
                self.titleName = title
                
            case .failure(let error):
                print(error)
            }
            
            self.tableView.reloadData()
        }
       
        
        }
        
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            titleNumberCount
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: K.emailedCellIdentifer)
            cell?.textLabel?.text = titleName[indexPath.row].title
            return cell!
        }
    
    
        
    
}



