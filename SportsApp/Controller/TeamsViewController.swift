//
//  TeamsViewController.swift
//  SportsApp
//
//  Created by Ahmed Tarek on 3/27/21.
//

import UIKit

class TeamsViewController: UIViewController {
    
    @IBOutlet weak var teamsTV: UITableView!
    
    var leagueName: String?
    var teams : [[String: String?]]?
    let teamsUrl = "https://www.thesportsdb.com/api/v1/json/1/search_all_teams.php?l="
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestTeams()
        setupTableView()
    }
    
    func requestTeams(){
        if let leagueName = self.leagueName{
            let url = teamsUrl + leagueName.replacingOccurrences(of: " ", with: "_")
            ApiModal.instance.getData(url: url) { (myLeagueTeams: TeamsData?, error) in
                self.teams = myLeagueTeams?.teams
                self.teamsTV.reloadData()
            }
        }
    }
}

extension TeamsViewController: UITableViewDelegate, UITableViewDataSource{
    
    func setupTableView(){
        teamsTV.delegate = self
        teamsTV.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 121
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let teams = self.teams{
            return teams.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let teamCell: teamCell = tableView.dequeueReusableCell(withIdentifier: "teamCell") as! teamCell
        let team = self.teams![indexPath.row]
        teamCell.updateCell(teamName: team["strTeam"]!!, teamImage: team["strTeamLogo"]!!)
        return teamCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let teamDetailes = storyboard?.instantiateViewController(withIdentifier: "TeamDetialesViewController") as! TeamDetialesViewController
         
         self.navigationController?.pushViewController(teamDetailes, animated: true)

    }
    
}
