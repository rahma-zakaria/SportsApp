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
          //  let newView = UIView(frame: view.frame)
              //  newView.backgroundColor = UIColor.red
            let image = UIImage(named: "notFound")
            let imageView = UIImageView(image: image!)
            imageView.frame = view.frame
            view.addSubview(imageView)
           // view.addSubview(newView)
        }
        let myURL = URL(string: "https://\(socialLink)")
         print(socialLink)
         
        let myRequest = URLRequest(url: myURL!)
        socialWebView.load(myRequest)
        // Do any additional setup after loading the view.
    }

}
