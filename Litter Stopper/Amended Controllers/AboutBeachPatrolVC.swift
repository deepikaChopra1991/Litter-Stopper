//
//  AboutBeachPatrolVC.swift
//  Litter Stopper
//
//  Created by Applr on 23/08/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import WebKit

class AboutBeachPatrolVC: UIViewController,UIWebViewDelegate{

    //MARK: - IBOutlets
    @IBOutlet weak var activityInd: UIActivityIndicatorView!
    @IBOutlet weak var btn_Back: UIButton!
    @IBOutlet weak var Webview_Beachpatrol: UIWebView!
    @IBOutlet var navViewHeightConstant: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()

        if DeviceType.iPhoneX {
            navViewHeightConstant.constant = 74.0
        }
        self.Webview_Beachpatrol.delegate = self
        let urlString = "https://www.beachpatrol.com.au/About-Us"
        let request = URLRequest(url: NSURL(string: urlString)! as URL)
        self.Webview_Beachpatrol.loadRequest(request)
        Webview_Beachpatrol.scalesPageToFit = true
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    //MARK: - Button Actions
    @IBAction func BackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //MARK:- Webview Delegates
    func webViewDidStartLoad(_ webView: UIWebView) {
        activityInd.startAnimating()
    }

    func webView(_ webView: UIWebView, didFailLoadWithError error: Error)
    {
        activityInd.stopAnimating()
        activityInd.hidesWhenStopped = true
    }

    func webViewDidFinishLoad(_ webView: UIWebView)
    {
        activityInd.stopAnimating()
        activityInd.hidesWhenStopped = true
    }
}
