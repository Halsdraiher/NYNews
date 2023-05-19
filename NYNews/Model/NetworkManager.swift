//
//  NetworkManager.swift
//  NYNews
//
//  Created by Solovei Ihor on 17.05.2023.
//

import Foundation
import Alamofire

class NetworkManager {
    
    var results = [Results]()
    
    
    func getURL(category: String, reloadView: UITableView) {
        let apiUrl = "https://api.nytimes.com/svc/mostpopular/v2/\(category)/30.json?api-key=Nt1gabBpwkGIHhp2g50OCAP5JzRd62Ap"
        
        fetchData(url: apiUrl) { result in
            switch result {
            case .success(let userResult):
    
                let result = userResult.results
                self.results = result
                
            case .failure(let error):
                print(error)
            }
            reloadView.reloadData()
        }
    }
    
    func fetchData(url: String, completion: @escaping (Result<NewsApiData, Error>)-> ()) {
        AF.request(url)
            .validate()
            .response { response in
            guard let data = response.data else {
                if let error = response.error {
                    completion(.failure(error))
                }
                return
            }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
                guard let userResults = try? decoder.decode(NewsApiData.self, from: data) else {
                    completion(.failure(Error.self as! Error))
                    
                    return
                }
                completion(.success(userResults))
            
        }
    }
    
}

