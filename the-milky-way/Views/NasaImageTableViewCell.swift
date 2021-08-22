//
//  NasaImageTableViewCell.swift
//  the-milky-way
//
//  Created by Steeve Fong on 2021/08/22.
//

import UIKit

class NasaImageTableViewCell: UITableViewCell {
    @IBOutlet weak var nasaImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var photographerLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setItem(_ item: NasaImageData) {
        titleLabel.text = item.title
        photographerLabel.text = item.photographer
//        dateLabel.text = item.dateCreated?.description
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
