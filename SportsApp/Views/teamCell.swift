//
//  teamCell.swift
//  SportsApp
//
//  Created by Ahmed Tarek on 3/27/21.
//

import UIKit

class teamCell: UITableViewCell {

    @IBOutlet weak var teamImage: UIImageView!
    @IBOutlet weak var teamName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func updateCell(teamName: String, teamImage: String){
        let img = NSURL(string: teamImage)! as URL
        self.teamImage.sd_setImage(with: img, completed: nil)
        self.teamName.text = teamName
    }
    
}
