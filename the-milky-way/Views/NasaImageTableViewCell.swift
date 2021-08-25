//
//  NasaImageTableViewCell.swift
//  the-milky-way
//
//  Created by Steeve Fong on 2021/08/22.
//

import UIKit
import SDWebImage

class NasaImageTableViewCell: UITableViewCell {
    @IBOutlet weak var nasaImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    func setItem(_ item: NasaImage) {
        let data = item.data.first
        
        titleLabel.text = data?.title
        nasaImageView.sd_setImage(with: URL(string: item.links.first?.href ?? ""), completed: nil)
        subtitleLabel.text = data?.getSubtitle()
    }
}
