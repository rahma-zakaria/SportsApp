//
//  TeamsViewController.swift
//  SportsApp
//
//  Created by Ahmed Tarek on 3/27/21.
//

import UIKit

class TeamsViewController: UIViewController {
    
 
    @IBOutlet weak var teamsCV: UICollectionView!
    
    var leagueName: String?
    var teams : [[String: String?]]?
    let teamsUrl = "https://www.thesportsdb.com/api/v1/json/1/search_all_teams.php?l="
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestTeams()
        setupCollectionView()
    }
    
    func requestTeams(){
        if let leagueName = self.leagueName{
            let url = teamsUrl + leagueName.replacingOccurrences(of: " ", with: "_")
            ApiModal.instance.getData(url: url) { (myLeagueTeams: TeamsData?, error) in
                self.teams = myLeagueTeams?.teams
                self.teamsCV.reloadData()
            }
        }
    }
}

extension TeamsViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func setupCollectionView(){
        teamsCV.delegate = self
        teamsCV.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let teams = self.teams{
            return teams.count
        }else{
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let teamCell: teamCell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamCell", for: indexPath) as! teamCell
        let team = self.teams![indexPath.row]
        teamCell.updateCell(teamName: team["strTeam"]!!, teamImage: team["strTeamLogo"]!!)
        return teamCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let team = self.teams![indexPath.row]
        pushToTeamDetailsView(team: team)
    }
    
    func pushToTeamDetailsView(team: [String: String?]){
        let teamDetailes = storyboard?.instantiateViewController(withIdentifier: "TeamDetialesViewController") as! TeamDetialesViewController
        teamDetailes.team = team
         self.navigationController?.pushViewController(teamDetailes, animated: true)
    }
    
}
