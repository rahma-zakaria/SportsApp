//
//  TeamsViewController.swift
//  SportsApp
//
//  Created by Ahmed Tarek on 3/27/21.
//

import UIKit

class LeaguesDetialesViewController: UIViewController {
    
 
    @IBOutlet weak var teamsCV: UICollectionView!
    @IBOutlet weak var resultsCollection: UICollectionView!
    
    var leagueName: String?
    var leagueId: String?
    var teams : [[String: String?]]?
    var events = [Events]()
    let teamsUrl = "https://www.thesportsdb.com/api/v1/json/1/search_all_teams.php?l="
    let eventsUrl = "https://www.thesportsdb.com/api/v1/json/1/eventspastleague.php?id="
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestTeams()
        requestEvents()
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
    func requestEvents(){
        if let leagueId = self.leagueId{
            let url = eventsUrl + leagueId
                ApiModal.instance.getData(url: url, completion:{(myEvents: EventsModel?,error) in
                    if let myError = error{
                        print(myError)
                    }else{
                        guard let events = myEvents else {return}
                        guard let myEvent = events.events  else { return }
                        self.events = myEvent
                        print("my events")
                        print(self.events.count)
                        self.resultsCollection.reloadData()
                    }
                })
        }
    }
}

extension LeaguesDetialesViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func setupCollectionView(){
        teamsCV.delegate = self
        teamsCV.dataSource = self
        resultsCollection.delegate = self
        resultsCollection.dataSource = self
        resultsCollection.register(UINib(nibName: "EventCollectionCell", bundle: nil), forCellWithReuseIdentifier: "EventCollectionCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 0:
            //frist here
            return 0
        case 1:
            //events here
            print("in case 1 >>")
            return events.count
        default:
            if let teams = self.teams{
                return teams.count
            }else{
                return 0
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.tag {

        case 1:
            let eventCell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventCollectionCell", for: indexPath) as! EventCollectionCell
            let event = events[indexPath.row]
            eventCell.displayImgs(teamAURL: event.idHomeTeam, teamBURL: event.idAwayTeam)
            eventCell.displayNames(teamA: event.strHomeTeam ?? "", teamB: event.strAwayTeam ?? "")
            eventCell.displayResults(teamARes: event.intHomeScore, teamBRes: event.intAwayScore)
            eventCell.displayDateTime(date: event.dateEvent, time: event.strTime)
            
            return eventCell
        default:
        let teamCell: teamCell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamCell", for: indexPath) as! teamCell
        let team = self.teams![indexPath.row]
        teamCell.updateCell(teamName: team["strTeam"]! ?? "", teamImage: team["strTeamLogo"]! ?? "")
        return teamCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView.tag {
        case 0:
            //frist here
            print("first")
        case 1:
            //events here
            print("first")
        default:
        let team = self.teams![indexPath.row]
        pushToTeamDetailsView(team: team)
    }
    }
    
    func pushToTeamDetailsView(team: [String: String?]){
        let teamDetailes = storyboard?.instantiateViewController(withIdentifier: "TeamDetialesViewController") as! TeamDetialesViewController
        teamDetailes.team = team
         self.navigationController?.pushViewController(teamDetailes, animated: true)
    }
    
}
extension LeaguesDetialesViewController: UICollectionViewDelegateFlowLayout{
    
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView.tag {
        case 1:
            return CGSize(width: ((self.view.frame.size.width/2) - 16), height: (self.view.frame.size.width/3))

        default:
            return CGSize(width: collectionView.frame.size.width * 0.3, height: collectionView.frame.size.width * 0.23)
        }

     }
     
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
    }
 
}

