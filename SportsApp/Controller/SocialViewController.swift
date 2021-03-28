//
//  SocialViewController.swift
//  SportsApp
//
//  Created by rahma zakaria on 3/28/21.
//

import UIKit
import WebKit

class SocialViewController: UIViewController {

    @IBOutlet weak var socialWebView: WKWebView!
    var socialLink:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if socialLink.isEmpty {
            print("\n\n is empty")
            // image here to show no link 
            let newView = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
                newView.backgroundColor = UIColor.red
                view.addSubview(newView)
        }
        let myURL = URL(string: "https://\(socialLink)")
         print(socialLink)
         
        let myRequest = URLRequest(url: myURL!)
        socialWebView.load(myRequest)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
