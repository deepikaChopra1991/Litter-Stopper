//
//  AboutLoveStreetVC.swift
//  Litter Stopper
//
//  Created by Applr on 23/08/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import WebKit

class AboutLoveStreetVC: UIViewController,UIWebViewDelegate {
    //    MARK:- IBOutlets
     @IBOutlet weak var activityInd: UIActivityIndicatorView!
    @IBOutlet weak fileprivate var btn_Back: UIButton!
    @IBOutlet weak fileprivate var navViewHeightConstant: NSLayoutConstraint!
    @IBOutlet weak fileprivate var webview_LoveStreet: UIWebView!
    //MARK:- VIEW METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if DeviceType.iPhoneX {
            navViewHeightConstant.constant = 74.0
        }
 
        self.webview_LoveStreet.delegate = self
        let urlString = "https://www.beachpatrol.com.au/About-Us"
        let request = URLRequest(url: NSURL(string: urlString)! as URL)
        self.webview_LoveStreet.loadRequest(request)
        webview_LoveStreet.scalesPageToFit = true

    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    //MARK:- Button Actios
    @IBAction func BackButtonAction(_ sender: Any) {
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
