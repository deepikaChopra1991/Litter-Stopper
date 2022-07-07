//
//  BeachpatrolUrlVC.swift
//  Litter Stopper
//
//  Created by Apple01 on 9/17/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class BeachpatrolUrlVC: UIViewController {
    //    MARK:- IBOUTLETS
@IBOutlet weak fileprivate var navViewHeightConstant: NSLayoutConstraint!
    @IBOutlet weak var lbl_BpDetail: UILabel!
    // MARK:- VARIABLES
    var arrPagesDict = [PagesDataModel]()
    // MARK:- View Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        if DeviceType.iPhoneX {
            navViewHeightConstant.constant = 74.0
        }
        lbl_BpDetail.textColor = App_Blue_Color
        lbl_BpDetail.text = self.arrPagesDict[1].strvalue
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //    MARK:- Button Functions
    @IBAction func BackButtonAction(_ sender: Any) {
      self.navigationController?.popViewController(animated: true)
    }
}

