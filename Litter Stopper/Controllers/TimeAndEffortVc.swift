//
//  TimeAndEffortVc.swift
//  Litter Stopper
//
//  Created by Apple01 on 9/6/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import MessageUI
import Messages
import DateToolsSwift

class TimeAndEffortVc: UIViewController,MFMailComposeViewControllerDelegate,UITextFieldDelegate{
    //    MARK:- IBOUTLETS
    @IBOutlet var navViewHeightConstant: NSLayoutConstraint!
    @IBOutlet weak var btn_Back: UIButton!
    @IBOutlet weak var btn_Submit: UIButton!
    @IBOutlet weak var tf_lengthCleaned: UITextField!
    @IBOutlet weak var Tf_EnterBags: UITextField!
    @IBOutlet weak var tf_EnterKG: UITextField!
    @IBOutlet weak var lbl_HoursSpent: UILabel!
    @IBOutlet weak var TF_NumberOfPeople: UITextField!
    @IBOutlet weak var btn_stopTimer: UIButton!
    @IBOutlet weak var btn_Timer: UIButton!
    @IBOutlet weak var tf_enterMinutes: UITextField!
    @IBOutlet weak var lbl_minutes: UILabel!
    @IBOutlet weak var tf_otherDetails: UITextField!
    @IBOutlet weak var lbl_otherDetails: UILabel!
    @IBOutlet weak var btn_optionCheckbox: UIButton!
    @IBOutlet weak var tf_widthCleaned  : UITextField!
    @IBOutlet weak var lbl_widthCleaned: UILabel!
    @IBOutlet weak var lblSendTo: UILabel!
    
    //MARK:- Variables
    var seconds = Int()
    var cleanId = Int()
    var duration = String()
    var totalSeconds = Int()
    var timercheck : Bool! = false
    let nc = NotificationCenter.default
    var timer:Timer!
    var mailChoice = String()
    var weatherDetails = String()
    var isFullAudit = false

    //MARK:- View Controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        mailChoice = "no"
        TF_NumberOfPeople.delegate = self
        tf_enterMinutes.delegate = self
        seconds =  AppDelegate.sharedDelegate.timerSecond
        print(seconds)
        if DeviceType.iPhoneX {
            navViewHeightConstant.constant = 74.0
        }

        btn_stopTimer.backgroundColor = App_Green_Color
        lbl_HoursSpent.isHidden = true

        if seconds != 0 {
            runTimer()
            btn_stopTimer.backgroundColor = App_Green_Color
            btn_stopTimer.isEnabled = true
            lbl_minutes.isHidden = true
            tf_enterMinutes.isHidden = true
        }else {
            btn_stopTimer.backgroundColor = BLACK_COLOR
            btn_stopTimer.isEnabled = false
            lbl_minutes.isHidden = false
            tf_enterMinutes.isHidden = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        btn_optionCheckbox.isEnabled = isFullAudit == true ? true : false
        lblSendTo.isEnabled = isFullAudit == true ? true : false
    }
    override func viewDidLayoutSubviews() {
        viewInitialSetup()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    //MARK:- Set up initial view
    func viewInitialSetup(){
        btn_stopTimer.btnRoundCorner(cornerRadius: 15)
        btn_stopTimer.btnRoundCorner(cornerRadius: 15)
        tf_lengthCleaned.setTextFieldBoader(1, borderC: TF_BORDER_COLOR)
        tf_widthCleaned.setTextFieldBoader(1, borderC: TF_BORDER_COLOR)
        Tf_EnterBags.setTextFieldBoader(1, borderC: TF_BORDER_COLOR)
        tf_EnterKG.setTextFieldBoader(1, borderC: TF_BORDER_COLOR)
        TF_NumberOfPeople.setTextFieldBoader(1, borderC: TF_BORDER_COLOR)
        tf_enterMinutes.setTextFieldBoader(1, borderC: TF_BORDER_COLOR)
        tf_lengthCleaned.setLeftPaddingView()
        tf_widthCleaned.setLeftPaddingView()
        Tf_EnterBags.setLeftPaddingView()
        tf_EnterKG.setLeftPaddingView()
        TF_NumberOfPeople.setLeftPaddingView()
        tf_enterMinutes.setLeftPaddingView()
        tf_otherDetails.setTextFieldBoader(1, borderC: TF_BORDER_COLOR)
        tf_otherDetails.setLeftPaddingView()
    }
    //MARK:- Back Button Actions
    @IBAction func BackBtnAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    //MARK:- Submit Button Actions
    @IBAction func SubmitBtnAction(_ sender: Any) {
        if tf_enterMinutes.text == "" && seconds == 0 {
            MessageView.show(in: self.view, withMessage: "Enter Time in Minutes")

        }else if timercheck == false && seconds != 0{
            MessageView.show(in: self.view, withMessage: "Please Stop the timer to Continue.")
        }
        else if TF_NumberOfPeople.text == "" {
            TF_NumberOfPeople.keyboardType = .numberPad
             MessageView.show(in: self.view, withMessage: "Please enter the number of people performing clean.")
        }else if tf_EnterKG.text == "" {
            tf_EnterKG.keyboardType = .decimalPad//.numberPad
            MessageView.show(in: self.view, withMessage: "Please enter the weight of litter collected.")
        }else if Tf_EnterBags.text == "" {
            Tf_EnterBags.keyboardType = .numberPad
            MessageView.show(in: self.view, withMessage: "Please enter the number of bags.")
        }else if tf_lengthCleaned.text == "" {
            tf_lengthCleaned.keyboardType = .numberPad
            MessageView.show(in: self.view, withMessage: "Please enter the length of area cleaned")
        }else {
            finishCleanUp()
        }
    }
    //MARK:- Timer Stop Button Actions
    @IBAction func stopBtnAction(_ sender: Any) {
        self.timer.invalidate()
        nc.post(name: Notification.Name("TimerStopped"), object: nil)
        tf_EnterKG.isUserInteractionEnabled = true
        TF_NumberOfPeople.isUserInteractionEnabled = true
        tf_lengthCleaned.isUserInteractionEnabled = true
        Tf_EnterBags.isUserInteractionEnabled = true
        timercheck = true
        AppDelegate.sharedDelegate.timerSecond = 0
        btn_Back.isHidden = true
        btn_stopTimer.backgroundColor = BLACK_COLOR
    }
    //MARK:- TimerButton Custom Methods
    func stringFromTimeInterval(interval: TimeInterval) -> NSString {
        let ti = NSInteger(interval)
        let seconds = ti % 60
        let minutes = (ti / 60) % 60
        let hours = (ti / 3600)

        return NSString(format: "%0.2d:%0.2d:%0.2d",hours,minutes,seconds)
    }

    @IBAction func btn_TimerAction(_ sender: Any) {
    }
    //MARK:- Timer Custom Methods
    func runTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    @objc func updateTimer() {
        seconds += 1
        let timerStr = String(format: "%02d:%02d", (seconds / 3600),(seconds % 3600) / 60, (seconds % 3600) % 60)
        btn_Timer.setTitle(timerStr, for: .normal)
    }
    //    MARK:- Textfield Delegates
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
//        TF_NumberOfPeople.resignFirstResponder()
        return false
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {

        if textField == TF_NumberOfPeople {
                if tf_enterMinutes.text == "" && seconds == 0 {
                     MessageView.show(in: self.view, withMessage: "Enter Time in Minutes")
                    return false
                }else if timercheck == false && seconds != 0{
                    MessageView.show(in: self.view, withMessage: "Please Stop the timer to Continue.")
                    return false
            }
                return true
            }
//  MessageView.show(in: self.view, withMessage: "Enter Time in Minutes")

//            MessageView.show(in: self.view, withMessage: "Enter Time in Minutes")
        return true
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
        mailComposerVC.setToRecipients(["sfs.shivi18@gmail.com"])
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
   
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//Count for first TxtField
        if textField == tf_enterMinutes {
            let textstr = (tf_enterMinutes.text! as NSString).replacingCharacters(in: range, with: string)
       let length = textstr.count
            if (textField.text) != "" {
                if Int(textField.text!)! >= 100000 && range.length == 0 {
                    return false
                }
                else {
                    return true
                }
            }
        }
        if textField == tf_EnterKG {
            if string.isEmpty { return true }
            let currentText = textField.text ?? ""
            let replacementText = (currentText as NSString).replacingCharacters(in: range, with: string)
            return replacementText.isValidDouble(maxDecimalPlaces: 2)
        }
        
//        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//            if string.isEmpty { return true }
//            let currentText = textField.text ?? ""
//            let replacementText = (currentText as NSString).replacingCharacters(in: range, with: string)
//            return replacementText.isValidDouble(maxDecimalPlaces: 2)
//        }
//Second Textfield
        if textField == TF_NumberOfPeople{
            if let text = TF_NumberOfPeople.text as NSString? {
                let txtAfterUpdate = text.replacingCharacters(in: range, with: string)
                _ = Int(txtAfterUpdate)
                if tf_enterMinutes.text != "" && seconds == 0 && Int(txtAfterUpdate) != nil {
                    
                    totalSeconds =   Int(txtAfterUpdate)! * (Int(tf_enterMinutes.text!)! * 60)
                } else {
                    if txtAfterUpdate == "" || txtAfterUpdate == nil{
                        totalSeconds = 0
                    }else{
                        totalSeconds =   Int(txtAfterUpdate)! * seconds
                    }
                }
                let newTimerStr = String(format: "%02d:%02d",(totalSeconds/3600),((totalSeconds/60) % 60),(totalSeconds % 60))
                
                print(totalSeconds)
                print(newTimerStr)
                lbl_HoursSpent.isHidden = false
                lbl_HoursSpent.text = newTimerStr
                
            }
            
            let textstring = (TF_NumberOfPeople.text! as NSString).replacingCharacters(in: range, with: string)
            let length = textstring.characters.count
            if (textField.text) != ""
            {
                if Int(textField.text!)! >= 100000 && range.length == 0
                {
                    return false
                }
                else {
                    return true
                }
            }

        }
            return true
    }

    @IBAction func checkUncheck(sender:UIButton){
        if btn_optionCheckbox.isSelected {
            btn_optionCheckbox.isSelected = false
            mailChoice = "no"
        }else{
            btn_optionCheckbox.isSelected = true
            mailChoice = "yes"
        }
    }
    //    MARK:- WBS_METHOD
    func finishCleanUp(){
        if TF_NumberOfPeople.text == "0"{
            
        }else {
            let ppl = Int(TF_NumberOfPeople.text!) ?? 0
            self.duration = "\(totalSeconds/ppl)"
        }
        var durationValue = "\(seconds)"
        var timerstatus = "stopped"
        if seconds == 0{
            durationValue = self.duration
            timerstatus = "not started"
        }
        
        let params : [String : String] =
            [  "cleanup_id": "\(cleanId)",
                "duration": durationValue,
                "people_total_duration": "\(totalSeconds)",
                "no_of_bp_bags": Tf_EnterBags.text!,
                "no_of_people": TF_NumberOfPeople.text!,
                "trash_weight":tf_EnterKG.text!,
                "cleaned_length": tf_lengthCleaned.text!,
                "cleaned_width": tf_widthCleaned.text!,
                "optional_mail": mailChoice,
                "special_weather_community_events": tf_otherDetails.text!,
                "timer_status" : timerstatus
               ]
        ServerManager.shared.showHud()
        ServerManager.shared.httpPost(request: API_FINISH_CLEANUP, params: params, successHandler:
            {(JSON) in
                ServerManager.shared.hidHud()
                print(JSON)
                if JSON["success"].boolValue == true {
            _ = UIAlertController.showAlertInViewController(viewController: self, withTitle: kAlertTitle, message: "Email sent Successfully!", cancelButtonTitle: "OK", destructiveButtonTitle: nil, otherButtonTitles: nil, tapBlock: { (c, a, i) in
                if self.seconds != 0 {
                    self.timer.invalidate()
                }
                AppDelegate.sharedDelegate.PassdetailsFullAudit.dictItemFullAuditCount.removeAll()
                AppDelegate.sharedDelegate.PassdetailsFullAudit.totalCount = "TOTAL : 0"
                AppDelegate.sharedDelegate.PassDetailsModel2.dictItemCountDetail.removeAll()
                AppDelegate.sharedDelegate.PassDetailsModel2.totalCount = "TOTAL: 0"
                AppDelegate.sharedDelegate.PassDetailsPartialAudit.dictItemCountDetail.removeAll()
                AppDelegate.sharedDelegate.PassDetailsPartialAudit.totalCount = "TOTAL: 0"
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
                self.navigationController?.pushViewController(vc, animated: true)
                    })
                }
                else{
                    ServerManager.shared.hidHud()
                    AppManager.showErrorDialog(viewControler: self, message: JSON["message"].stringValue)
                }
        }) { (error) in
            ServerManager.shared.hidHud()
            AppManager.showErrorDialog(viewControler: self, message: AppManager.getErrorMessage(error! as NSError))
        }
        }
}

