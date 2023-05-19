//
//  NetworkManager.swift
//  NYNews
//
//  Created by Solovei Ihor on 17.05.2023.
//

import Foundation
import Alamofire

class NetworkManager {
    
    let apiUrl = "https://api.nytimes.com/svc/mostpopular/v2/emailed/30.json?api-key=Nt1gabBpwkGIHhp2g50OCAP5JzRd62Ap"
    var title = NewsModel().testTitle
    
    func fetchData(completion: @escaping (Result<NewsApiData, Error>)-> ()) {
        AF.request(apiUrl)
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
                self.title = userResults.results[0].title ?? "No title"
                
        }
    }
    
}

