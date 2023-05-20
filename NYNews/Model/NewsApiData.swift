//
//  NewsApiData.swift
//  NYNews
//
//  Created by Solovei Ihor on 17.05.2023.
//

import Foundation
import Alamofire

struct NewsApiData: Codable {
    let results: [Results]
}

struct Results: Codable {
    let title: String
    let url: String
}
