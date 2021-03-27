//
//  LeaguesTableCell.swift
//  SportsApp
//
//  Created by rahma zakaria on 3/26/21.
//

import UIKit

class LeaguesTableCell: UITableViewCell {

    @IBOutlet weak var leagueImage: UIImageView!
    @IBOutlet weak var youtubeButton: UIButton!
    @IBOutlet weak var leagueNameLabel: UILabel!
    @IBOutlet weak var leagueIView: UIView!
    
    var youtubeLink: String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func youtubeButton(_ sender: UIButton) {
        let currentView: UIViewController = self.window!.rootViewController!
        
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let youtubeView = storyboard.instantiateViewController(withIdentifier: "YoutubeViewController") as! YoutubeViewController
        youtubeView.youtubeLink = self.youtubeLink
        let navController = UINavigationController(rootViewController: youtubeView)
        currentView.present(navController, animated:true, completion: nil)
    }

    func setUpLeaguesTableCell(leagueName: String, imageName: String, youtubeLink: String) {
        // var image: UIImage = UIImage(named: "imageName")
        leagueIView!.layer.borderWidth = 1.0
        leagueIView!.layer.masksToBounds = false
        leagueIView!.layer.cornerRadius = leagueIView.frame.size.height/2
        leagueIView!.clipsToBounds = true
        
        leagueNameLabel.text = leagueName
        leagueImage.sd_setImage(with: URL(string: imageName), placeholderImage: UIImage(named: "2"))
        self.youtubeLink = youtubeLink
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
