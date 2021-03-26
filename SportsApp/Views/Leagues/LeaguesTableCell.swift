//
//  LeaguesTableCell.swift
//  SportsApp
//
//  Created by rahma zakaria on 3/26/21.
//

import UIKit

class LeaguesTableCell: UITableViewCell {

    @IBOutlet weak var leagueImage: UIImageView!
   
    @IBOutlet weak var leagueNameLabel: UILabel!
    @IBOutlet weak var leagueIView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func youtubeButton(_ sender: UIButton) {
    }
   /* override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 20, left: 8, bottom: 8, right:20))
    }*/
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }
    /*
    override func layoutSubviews() {
        super.layoutSubviews()
        let padding = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        bounds = bounds.inset(by: padding)
    }
    */
    func setUpLeaguesTableCell(leagueName: String, imageName: String) {
        leagueNameLabel.text = leagueName
        leagueImage.sd_setImage(with: URL(string: imageName), placeholderImage: UIImage(named: "2"))
        /*
        nameLabelView.backgroundColor = UIColor(red: 0, green: 0, blue: 1, alpha: 0.7)
        nameLabelView.layer.cornerRadius = 20
        nameLabelView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
*/
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
