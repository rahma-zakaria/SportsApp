//
//  SportsViewController.swift
//  SportsApp
//
//  Created by rahma zakaria on 3/24/21.
//

import UIKit
import Reachability

class SportsViewController: UIViewController {
    let reachability = try! Reachability()
    
    @IBOutlet weak var sportsCollection: UICollectionView!{
        didSet{
            sportsCollection.delegate = self
            sportsCollection.dataSource = self
        }
    }
    
    let sportsUrl = "https://www.thesportsdb.com/api/v1/json/1/all_sports.php"
   // var sportsData = SportsModel()
    var sports = [Sports]()
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.global(qos: .background).async {
                   ApiModal.instance.getData(url: self.sportsUrl, completion:{(mySports: SportsModel?,error) in
                       if let myError = error{
                           print(myError)
                       }else{
                           guard let sports = mySports else {return}
                          // self.sportsData = sports
                           guard let mySport = sports.sports  else { return }
                           self.sports = mySport
                           print("my sports")
                           print(self.sports.count)
                           DispatchQueue.main.async {
                               self.sportsCollection.reloadData()
                           }
                       }
                   })
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        reachability.whenReachable = { reachability in
            self.tabBarController?.selectedIndex = 0
        }
        reachability.whenUnreachable = { _ in
            self.tabBarController?.selectedIndex = 1
        }
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        reachability.stopNotifier()
    }
}

    extension SportsViewController: UICollectionViewDelegate, UICollectionViewDataSource{
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return sports.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SportsCollectionCell", for: indexPath) as! SportsCollectionCell
            let name = sports[indexPath.row].strSport!
            let image = sports[indexPath.row].strSportThumb!
            cell.setUpSportsCollectionCell(sportName: name, imageName: image)
            cell.layer.borderWidth = 3
            cell.layer.borderColor = UIColor(red: 0, green: 0, blue: 1, alpha: 1).cgColor
            cell.layer.cornerRadius = 30
            cell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
            
            return cell
        }
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let leaguesView = storyboard?.instantiateViewController(withIdentifier: "LeaguesViewController") as! LeaguesViewController
            leaguesView.sportName = sports[indexPath.row].strSport!
             
             self.navigationController?.pushViewController(leaguesView, animated: true)
        }
    }
    extension SportsViewController: UICollectionViewDelegateFlowLayout{
        
         func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         return CGSize(width: collectionView.frame.size.width * 0.47, height: collectionView.frame.size.width * 0.5)
         }
         
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 6
        }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 6
        }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 6, left: 8, bottom: 6, right: 8)
        }
    }


