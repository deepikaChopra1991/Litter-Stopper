//
//  LOSUrlVc.swift
//  Litter Stopper
//
//  Created by Apple01 on 9/17/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class LOSUrlVc: UIViewController {
    //    MARK:- IBOUTLETS
@IBOutlet weak fileprivate var navViewHeightConstant: NSLayoutConstraint!
    
    @IBOutlet weak var lbl_LosDetail: UILabel!
//    MARK:- VARIABLES
    var arrPagesDict = [PagesDataModel]()
//    MARK- VIEW METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        if DeviceType.iPhoneX {
            navViewHeightConstant.constant = 74.0
        }
        lbl_LosDetail.textColor = App_Green_Color
        lbl_LosDetail.text = self.arrPagesDict[2].strvalue
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //MARK;- BUTTON ACTIONS
    @IBAction func BackBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
