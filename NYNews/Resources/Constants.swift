//
//  File.swift
//  NYNews
//
//  Created by Solovei Ihor on 17.05.2023.
//

import Foundation

struct K {
    
    static let emailedCellIdentifier = "emailedCell"
    static let sharedCellIdentifier = "sharedCell"
    static let viewedCellIdentifier = "viewedCell"
    static let favoriteCellIdentifier = "favoriteCell"
    static let reusableCell = "reusableCell"
    static let nibName = "NewsCell"
    
    
    struct Colors {
        static let backColor = "BackColor"
    }
    
    struct Fonts {
        static let cellFont = "Roboto Condensed"
    }
    
    struct Categories {
        static let mostEmailed = "emailed"
        static let mostShared = "shared"
        static let mostViewed = "viewed"
    }
    
    struct Symbols {
        static let star = "Star"
    }
}
