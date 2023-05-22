//
//  FavoriteNewsController.swift
//  NYNews
//
//  Created by Solovei Ihor on 19.05.2023.
//

import UIKit

class FavoriteNewsController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        tabBarController?.navigationItem.title = "FAVORITE"
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

}
