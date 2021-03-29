//
//  FavoriteViewController.swift
//  SportsApp
//
//  Created by rahma zakaria on 3/29/21.
//

import UIKit

class FavoriteViewController: UIViewController {
    @IBOutlet weak var leaguesTabelView: UITableView!{
    didSet{
        leaguesTabelView.delegate = self
        leaguesTabelView.dataSource = self
    }
}
var leagues = [FavoriteLeague]()
    
override func viewDidLoad() {
    self.leaguesTabelView.contentInset = UIEdgeInsets(top: 0, left: 8, bottom: 8, right: 8)
    super.viewDidLoad()
}
    override func viewWillAppear(_ animated: Bool) {
        let coreData = CoreDataModel()
        leagues = []
        print(leagues.count)
        leagues = coreData.gitAllData()
        print(leagues.count)
        leaguesTabelView.reloadData()
    }

}


extension FavoriteViewController :UITableViewDelegate, UITableViewDataSource{
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return leagues.count
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = leaguesTabelView.dequeueReusableCell(withIdentifier: "LeaguesTableCellF", for: indexPath) as! LeaguesTableCell
    let youtubeLink = leagues[indexPath.row].youtubeUrl!
    if (youtubeLink.isEmpty){
        cell.youtubeButton.isHidden = true
    } else {
        cell.youtubeButton.isHidden = false
        cell.youtubeButton.tag = indexPath.row
    }
    
    let name = leagues[indexPath.row].name ?? "no name"
    let image = leagues[indexPath.row].image ?? " no"
    cell.setUpLeaguesTableCell(leagueName: name, imageName: image, youtubeLink: youtubeLink)

    cell.layer.borderWidth = 3
    cell.layer.borderColor = UIColor(red: 0, green: 0, blue: 1, alpha: 1).cgColor
    cell.layer.cornerRadius = 30
    cell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
    
    return cell
}

func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let name = self.leagues[indexPath.row].name ?? ""
    let id = self.leagues[indexPath.row].id ?? ""
    let image = self.leagues[indexPath.row].image ?? ""
    let youtube = self.leagues[indexPath.row].youtubeUrl ?? ""
    let myLeague = FavoriteLeague(id: id, name: name, image: image, youtubeUrl:youtube)
    pushToTeamsView(myLeague: myLeague)
}

func pushToTeamsView(myLeague: FavoriteLeague){
    let LeaguesDetialesViewController: LeaguesDetialesViewController = self.storyboard?.instantiateViewController(identifier: "LeaguesDetialesViewController") as! LeaguesDetialesViewController
    LeaguesDetialesViewController.myLeague = myLeague
    self.navigationController?.pushViewController(LeaguesDetialesViewController, animated: true)
    
    let navController = UINavigationController(rootViewController: LeaguesDetialesViewController)
    self.present(navController, animated:true, completion: nil)
}

}

extension FavoriteViewController{
func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return CGFloat(tableView.frame.size.width * 0.3)
}
}
