//
//  FavoriteViewController.swift
//  SportsApp
//
//  Created by rahma zakaria on 3/29/21.
//

import UIKit
import Reachability

class FavoriteViewController: UIViewController {
    @IBOutlet weak var leaguesTabelView: UITableView!{
    didSet{
        leaguesTabelView.delegate = self
        leaguesTabelView.dataSource = self
    }
}
var leagues = [FavoriteLeague]()
let reachability = try! Reachability()
    var isConected: Bool?
    
override func viewDidLoad() {
    super.viewDidLoad()
}
    override func viewWillAppear(_ animated: Bool) {
        
        reachability.whenReachable = { reachability in
            self.isConected = true
        }
        reachability.whenUnreachable = { _ in
            self.isConected = false
        }
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
        let coreData = CoreDataModel()
        leagues = []
        print(leagues.count)
        leagues = coreData.gitAllData()
        print(leagues.count)
        leaguesTabelView.reloadData()
    }
    override func viewDidAppear(_ animated: Bool) {
        reachability.stopNotifier()
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
    if isConected! {
        let name = self.leagues[indexPath.row].name ?? ""
        let id = self.leagues[indexPath.row].id ?? ""
        let image = self.leagues[indexPath.row].image ?? ""
        let youtube = self.leagues[indexPath.row].youtubeUrl ?? ""
        let myLeague = FavoriteLeague(id: id, name: name, image: image, youtubeUrl:youtube)
        pushToTeamsView(myLeague: myLeague)
    }else{
        print("hi")
        let alert = UIAlertController(title: "No Connection", message: "Pleas Connect Internet And Connect Agian", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

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
