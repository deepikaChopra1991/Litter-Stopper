//
//  HomeVC.swift
//  Litter Stopper
//
//  Created by Applr on 20/08/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import Messages
import MessageUI

class HomeVC: UIViewController,MFMailComposeViewControllerDelegate {
    
    //MARK:- Outlets
    @IBOutlet weak var btnInfo: UIButton!
    @IBOutlet weak var lbl_Abtlos: UILabel!
    @IBOutlet var viewStartClean: UIView!
    @IBOutlet var viewBeachPatrol: UIView!
    @IBOutlet var viewLoveStreet: UIView!
    @IBOutlet weak var btn_ContactBeachPatrol: UIButton!
    @IBOutlet weak var btn_AboutLitterStopper: UIButton!
    @IBOutlet weak var btn_LoveOurStreet: UIButton!
    @IBOutlet weak var btn_BeachPatrol: UIButton!
    @IBOutlet weak var btn_StartClean: UIButton!
    @IBOutlet weak var lbl_abtBp: UILabel!
    @IBOutlet weak var lbl_ContactLine: UILabel!
    @IBOutlet weak var lbl_abtLine: UILabel!
    @IBOutlet weak var lbl_LOS: UILabel!
    @IBOutlet weak var lbl_BP: UILabel!
    @IBOutlet weak var lbl_startClean: UILabel!
    @IBOutlet weak var lblAppVersion: UILabel!
    
    //    MARK:- Variable Declaration
    var arrPagesDict = [PagesDataModel]()
    var Bpdetail = String()
    var LosDetail = String()
    var AboutDetail = String()
    

    //    MARK:- View life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllPages()
        lbl_ContactLine.textColor = App_Blue_Color
        lbl_abtLine.textColor = App_Blue_Color
        lbl_LOS.textColor = App_Blue_Color
        lbl_BP.textColor = App_Blue_Color
        lbl_startClean.textColor = App_Blue_Color
        lbl_abtBp.textColor = App_Blue_Color
        lbl_Abtlos.textColor = App_Blue_Color
    btn_ContactBeachPatrol.setTitleColor(App_Blue_Color, for: .normal)
        btn_AboutLitterStopper.setTitleColor(App_Blue_Color, for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        print(appVersion!)
        lblAppVersion.text = "App Version: " + appVersion!

    }
    override func viewDidLayoutSubviews() {
        viewStartClean.ViewborderAndRound(color: UIColor.clear, cornerRadius: 20)
        viewStartClean.dropShadow()
        viewLoveStreet.ViewborderAndRound(color: UIColor.clear, cornerRadius: 20)
        viewLoveStreet.dropShadow()
        viewBeachPatrol.ViewborderAndRound(color: UIColor.clear, cornerRadius: 20)
        viewBeachPatrol.dropShadow()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }

    //MARK: - UIButton Actions
    @IBAction func startCleanAction(sender:UIButton){

        let vc = storyboard?.instantiateViewController(withIdentifier: "StartCleanVC") as! StartCleanVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func bachPatrolAction(sender:UIButton){
        let vc = storyboard?.instantiateViewController(withIdentifier: "BeachpatrolUrlVC") as! BeachpatrolUrlVC
        vc.arrPagesDict = self.arrPagesDict

        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func loveOurStreetAction(sender:UIButton){
        let vc = storyboard?.instantiateViewController(withIdentifier: "LOSUrlVc") as! LOSUrlVc
         vc.arrPagesDict = self.arrPagesDict
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func contactUsAction(sender:UIButton){
        sendEmail()
//        let alert = UIAlertController(title: "Contact Us", message: "admin@beachpatrol.com.au", preferredStyle: UIAlertControllerStyle.alert)
//        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
//        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func infoBtnAction(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "WalkThroughVC") as! WalkThroughVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func aboutUsAction(sender:UIButton){
        let vc = storyboard?.instantiateViewController(withIdentifier: "AboutVC") as! AboutVC
         vc.arrPagesDict = self.arrPagesDict
        self.navigationController?.pushViewController(vc, animated: true)
    }

    //    MARK:- Custom Email methods
    func sendEmail() {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }

    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        //        mailComposerVC.setToRecipients([UserDefaults.SFSDefault(valueForKey: "user_email") as! String])
        mailComposerVC.setToRecipients(["admin@beachpatrol.com.au"])
        mailComposerVC.setSubject("Litter Stopper")
        mailComposerVC.setMessageBody("This e-mail is about your Litter Collection.", isHTML: false)

        return mailComposerVC
    }

    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }

    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
        navigationController?.popToRootViewController(animated: true)
    }
    //    MARK:- WBS METHODS
    func getAllPages() {
        ServerManager.shared.showHud()
        ServerManager.shared.httpGet(request: API_ABOUT_PAGES , successHandler: { (JSON) in
            ServerManager.shared.hidHud()
            if JSON["success"].boolValue == true{
                print(JSON)

                let PageArr = JSON["data"].arrayValue
                for dict in PageArr{

                    let PageData = PagesDataModel.init(PagesDetails: dict)
                    self.arrPagesDict.append(PageData)
                }}
            else {
                MessageView.show(in: self.view, withMessage:JSON["message"].stringValue )
            }
        }, failureHandler: { (error) in

        }) { (progress) in

        }
    }
}
