//
//  TeamDetialesViewController.swift
//  SportsApp
//
//  Created by rahma zakaria on 3/27/21.
//

import UIKit

class TeamDetialesViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var teamLogoImage: UIImageView!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var descriptionText: UILabel!
    
    var team : [String: String?]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView(){
        teamLogoImage.layer.cornerRadius = teamLogoImage.frame.size.height/2
        if let team = self.team {
            if let teamImgUrl = team["strTeamLogo"]{
                let img = NSURL(string: teamImgUrl ?? "")! as URL
                self.teamLogoImage.sd_setImage(with: img, completed: nil)
            }
            self.teamNameLabel.text = team["strTeam"] ?? ""
            self.descriptionText.text = team["strDescriptionEN"] ?? ""
        }
    }
    
    @IBAction func faceBookButton(_ sender: Any) {
        
    }
    
    @IBAction func instgramButton(_ sender: Any) {
        
    }
    @IBAction func twitterButton(_ sender: Any) {
        
    }

}
