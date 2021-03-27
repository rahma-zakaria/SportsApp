//
//  LeaguesViewController.swift
//  SportsApp
//
//  Created by rahma zakaria on 3/26/21.
//

import UIKit

class LeaguesViewController: UIViewController {
    @IBOutlet weak var leaguesTabelView: UITableView!{
        didSet{
            leaguesTabelView.delegate = self
            leaguesTabelView.dataSource = self
        }
    }
    var sportName:String!
    let leaguesUrl = "https://www.thesportsdb.com/api/v1/json/1/all_leagues.php"
    let leagueDetailes = "https://www.thesportsdb.com/api/v1/json/1/lookupleague.php?id="
    var leagues = [LeaguesInfoModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.global(qos: .background).async {
            ApiModal.instance.getData(url: self.leaguesUrl, completion:{(myLeague: LeaguesModel?,error) in
                if let myError = error{
                    print("in myError")
                    print(myError)
                }else{
                    guard let myLeagues = myLeague else {return}
                    for index in 0 ..< myLeagues.leagues!.count{
                        if myLeagues.leagues![index].strSport == self.sportName {
                            let league: LeaguesInfoModel = LeaguesInfoModel()
                            league.info = myLeagues.leagues![index]
                            self.leagues.append(league)
                        }
                    }
                    print("\nleagues count")
                    print(self.leagues.count)
                    self.getMoreInfo()
                    DispatchQueue.main.async {
                        self.leaguesTabelView.reloadData()
                    }
                }
            })
        }
    }
    private func getMoreInfo(){
        DispatchQueue.global(qos: .background).async {
            for index in 0..<self.leagues.count{
                ApiModal.instance.getData(url: self.leagueDetailes + self.leagues[index].info.idLeague!, completion:{(myLeagueDetailes: LeaguesDetailesModel?,error) in
                    //print(self.leagueDetailes + self.leagues[index].info.idLeague!)
                    if let myError = error{
                        print(myError)
                    }else{
                        guard let leagues = myLeagueDetailes?.leagues else{print("first return");return}
                        self.leagues[index].moreInfo = leagues[0]
                       // print(self.leagues[index].moreInfo.strYoutube as Any)
                        
                    }
                    DispatchQueue.main.async {
                        self.leaguesTabelView.reloadData()
                    }
                })
            }
            
        }
        
    }
}


extension LeaguesViewController :UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leagues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = leaguesTabelView.dequeueReusableCell(withIdentifier: "LeaguesTableCell", for: indexPath) as! LeaguesTableCell
        let youtubeLink = leagues[indexPath.row].moreInfo.strYoutube!
        if (youtubeLink.isEmpty){
            cell.youtubeButton.isHidden = true
        } else {
            cell.youtubeButton.isHidden = false
            cell.youtubeButton.tag = indexPath.row
        }
        
        let name = leagues[indexPath.row].moreInfo.strLeague ?? "no name"
        let image = leagues[indexPath.row].moreInfo.strLogo ?? " no"
        cell.setUpLeaguesTableCell(leagueName: name, imageName: image, youtubeLink: youtubeLink)
    
        cell.layer.borderWidth = 3
        cell.layer.borderColor = UIColor(red: 0, green: 0, blue: 1, alpha: 1).cgColor
        cell.layer.cornerRadius = 30
        cell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
        
        return cell
    }
}
extension LeaguesViewController{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(tableView.frame.size.width * 0.3)
    }
}
