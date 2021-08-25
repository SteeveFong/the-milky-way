//
//  DetailsViewController.swift
//  the-milky-way
//
//  Created by Steeve Fong on 2021/08/21.
//

import UIKit

class DetailsViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var nasaImage: NasaImage!

    override func viewDidLoad() {
        super.viewDidLoad()
        let data = nasaImage.data.first
        
        titleLabel.text = data?.title
        subtitleLabel.text = data?.getSubtitle()
        descriptionLabel.text = data?.imageDescription
        imageView.sd_setImage(with: URL(string: nasaImage.links.first?.href ?? ""), completed: nil)
        
        navigationController?.navigationBar.topItem?.title = "backButtonTitle".localized
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
}
