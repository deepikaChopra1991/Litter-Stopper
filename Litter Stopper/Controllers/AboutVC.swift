//
//  AboutVC.swift
//  Litter Stopper
//
//  Created by Applr on 24/08/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class AboutVC: UIViewController {
    //    MARK:- IBOUTLETS
    @IBOutlet var navViewHeightConstant: NSLayoutConstraint!
    @IBOutlet weak var btn_Dismiss: UIButton!
    @IBOutlet weak var txtview_AboutDetail: UITextView!
    @IBOutlet weak var top_View: UIView!
    //    MARK:- VARIABLES
    var arrPagesDict = [PagesDataModel]()
    //    MARK:- VIEW METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
       if DeviceType.iPhoneX {
            navViewHeightConstant.constant = 74.0
        }
        txtview_AboutDetail.text = self.arrPagesDict[0].strvalue
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    //MARK:- BUTTON ACTIONS
    @IBAction func DismissBtnAction(_ sender: Any) {
         self.navigationController?.popViewController(animated: true)
    }
}
