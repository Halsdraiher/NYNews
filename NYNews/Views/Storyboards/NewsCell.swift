//
//  NewsCell.swift
//  NYNews
//
//  Created by Solovei Ihor on 06.06.2023.
//

import UIKit

class NewsCell: UITableViewCell {

    @IBOutlet weak var textCell: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var isFavorite = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor(named: K.Colors.backColor)
        favoriteButton.setTitle("", for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    

    @IBAction func favoriteButtonPressed(_ sender: UIButton) {
        isFavorite = !isFavorite
        if isFavorite {
            favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
        }
        
        
        
    }
}
