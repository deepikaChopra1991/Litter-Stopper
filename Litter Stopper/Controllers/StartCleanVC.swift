//
//  StartCleanVC.swift
//  Litter Stopper
//
//  Created by Apple01 on 8/29/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

var ID = Int()

class StartCleanVC: UIViewController {
    //MARK:- IBOutlets
    @IBOutlet weak var View_OtherOrg: UIView!
    @IBOutlet weak var View_LoveOurStreet: UIView!
    @IBOutlet weak var View_Beachpatrol: UIView!
    @IBOutlet weak var btn_Next: UIButton!
    @IBOutlet weak var btn_LoveOurStreet: UIButton!
    @IBOutlet weak var btn_BeachPatrol: UIButton!
    @IBOutlet weak var btn_Back: UIButton!
    @IBOutlet weak var tf_EmailAndAddress: UITextField!
    @IBOutlet weak var lbl_enterEmail: UILabel!
    @IBOutlet weak var lbl_OtherOrg: UILabel!
    @IBOutlet weak var lbl_LOS: UILabel!
    @IBOutlet weak var lbl_BP: UILabel!
    //    MARK:- Variable declaration
    var email = String()
    var arrOrgDict = [OrgDataModel]()
    
    //    MARK:- View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
     self.callGetOrganizationNames()
        navigationController?.navigationBar.isHidden = true
    }
    override func viewDidLayoutSubviews() {
        View_Beachpatrol.ViewborderAndRound(color: UIColor.clear, cornerRadius:20)
        View_Beachpatrol.dropShadow()
        View_LoveOurStreet.ViewborderAndRound(color: UIColor.clear, cornerRadius:20)
        View_LoveOurStreet.dropShadow()
        View_OtherOrg.ViewborderAndRound(color: UIColor.clear, cornerRadius:20)
        View_OtherOrg.dropShadow()
        btn_Next.layer.cornerRadius = (btn_Next.frame.height)/2
        lbl_enterEmail.textColor = App_Blue_Color
        lbl_OtherOrg.textColor = App_Blue_Color
        lbl_LOS.textColor = App_Blue_Color
        lbl_BP.textColor = App_Blue_Color
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    // MARK:-  Next Button Action
    @IBAction func NextButton(_ sender: Any) {

      if tf_EmailAndAddress.text == "" {
            let alert = UIAlertController(title: kAlertTitle , message: "Please fill the required email field to continue", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)

        }else
        if AppManager.isValidEmail(tf_EmailAndAddress.text!) == false  {
        let alert = UIAlertController(title: kAlertTitle, message: "Please enter valid Email Address", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else{
        UserDefaults.SFSDefault(setValue: tf_EmailAndAddress.text, forKey: "user_email")

/*let alert = UIAlertController(title: kAlertTitle, message: "Functionality of this phase is under development", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
 */
            let vc = storyboard?.instantiateViewController(withIdentifier: "AboutCleanVC") as! AboutCleanVC
            vc.accessibilityHint = "next"
            vc.emailOtherOrg = tf_EmailAndAddress.text!
            vc.setCountryName = "Australia"
            vc.setStatesname = "Victoria"

            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    //    MARK:- LoveStreet Button Action
    @IBAction func LoveOurStreetBtn(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoveStreetGroupVC") as! LoveStreetGroupVC
        self.navigationController?.pushViewController(vc, animated: true)

    }
//    MARK:- Back Button Action
    @IBAction func BackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
//    MARK:- BeachPatrol Button Action
    @IBAction func BeachPatrolBtn(_ sender: Any) {

        let vc = self.storyboard?.instantiateViewController(withIdentifier: "BeachPatrolGroupVC") as! BeachPatrolGroupVC
            vc.navigationController?.navigationBar.barTintColor = APP_COLOR
            vc.navigationController?.isNavigationBarHidden = false
            vc.navigationItem.title = "Litter Stopper"
            vc.OrgDict = self.arrOrgDict[0]
            self.navigationController?.pushViewController(vc, animated: true)
    }
    //    MARK:- WBS METHODS
    func callGetOrganizationNames() {
        ServerManager.shared.showHud()
        ServerManager.shared.httpGet(request: API_GET_ALL_ORGANIZATION , successHandler: { (JSON) in
            ServerManager.shared.hidHud()
            if JSON["success"].boolValue == true{

            print(JSON)
         let OrgArr = JSON["data"].arrayValue
         for dict in OrgArr{
            let OrgData = OrgDataModel.init(OrgDetails: dict)
            self.arrOrgDict.append(OrgData)
                }}
                else {
                MessageView.show(in: self.view, withMessage:JSON["message"].stringValue )
                }
        }, failureHandler: { (error) in

        }) { (progress) in

        }
}
}
