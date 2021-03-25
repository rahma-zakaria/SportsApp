//
//  SportsCollectionCell.swift
//  SportsApp
//
//  Created by rahma zakaria on 3/24/21.
//

import UIKit
import SDWebImage

class SportsCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var sportImage: UIImageView!
    @IBOutlet weak var nameLabelView: UIView!
    @IBOutlet weak var sportNameLabel: UILabel!
    
    func setUpSportsCollectionCell(sportName: String, imageName: String) {
        sportNameLabel.text = sportName
        
       /* let imageView = SDAnimatedImageView()
        let animatedImage = SDAnimatedImage(named: "image.gif")
        imageView.image = animatedImage*/
        sportImage.sd_setImage(with: URL(string: imageName), placeholderImage: UIImage(named: "2"))
        //sportImage.image = SDAnimatedImage(named: imageName)
        
        nameLabelView.backgroundColor = UIColor(red: 0, green: 0, blue: 1, alpha: 0.7)
        nameLabelView.layer.cornerRadius = 20
        nameLabelView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]

    }
}
