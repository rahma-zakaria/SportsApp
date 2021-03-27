//
//  YoutubeViewController.swift
//  SportsApp
//
//  Created by rahma zakaria on 3/27/21.
//

import UIKit
import WebKit

class YoutubeViewController: UIViewController, WKUIDelegate {

    @IBOutlet var youtubeWebView: WKWebView!
    var youtubeLink:String = ""

    override func viewDidLoad() {
       super.viewDidLoad()
       let myURL = URL(string: "https://\(youtubeLink)")
        print(youtubeLink)
        
       let myRequest = URLRequest(url: myURL!)
        youtubeWebView.load(myRequest)
        
        //youtubeWebView.load(NSURLRequest(url: NSURL(string: youtubeLink)! as URL) as URLRequest)
    }
    /*
    override func loadView() {
       let webConfiguration = WKWebViewConfiguration()
        youtubeWebView = WKWebView(frame: .zero, configuration: webConfiguration)
        youtubeWebView.uiDelegate = self
       view = youtubeWebView
    }
*/
}
