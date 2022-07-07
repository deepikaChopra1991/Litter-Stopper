//
//  AboutCleanVC.swift
//  Litter Stopper
//
//  Created by Applr on 23/08/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import DateToolsSwift

class AboutCleanVC: UIViewController,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource {
    
    //MARK: - IBOutlets
    @IBOutlet weak var lbl_enterCleanArea: UILabel!
    @IBOutlet weak var lbl_enterCountry: UILabel!
    @IBOutlet weak var lbl_enterGroupName: UILabel!
    @IBOutlet weak var lbl_EnterLocation: UILabel!
    @IBOutlet weak var lbl_enterDate: UILabel!
    @IBOutlet weak var lbl_enterState: UILabel!
    @IBOutlet weak var View_Content: UIView!
    @IBOutlet weak var btn_calender: UIButton!
    @IBOutlet weak var btn_StartTimer: UIButton!
    @IBOutlet weak var btn_Timer: UIButton!
    @IBOutlet weak var btn_Back: UIButton!
    @IBOutlet weak var tf_typeOfClean: UITextField!
    @IBOutlet weak var tf_State: UITextField!
    @IBOutlet weak var btn_FullAuditClean: UIButton!
    @IBOutlet weak var btn_PartialClean: UIButton!
    @IBOutlet weak var btn_StandardClean: UIButton!
    @IBOutlet weak var tf_EnterCountry: UITextField!
    @IBOutlet weak var tf_EnterGroupName: UITextField!
    @IBOutlet weak var tf_EnterLocation: UITextField!
    @IBOutlet weak var tf_EnterCleanDate: UITextField!
    
    @IBOutlet weak var tf_PostCode: UITextField!
    @IBOutlet var navViewHeightConstant: NSLayoutConstraint!
    @IBOutlet weak var btn_typeOfCleanDropDown: UIButton!
    @IBOutlet weak var btn_countrydropdown: UIButton!
    @IBOutlet weak var btn_statedropdown: UIButton!
    @IBOutlet weak var btn_NoSortingClean: UIButton!
    @IBOutlet weak var btn_withoutTimer: UIButton!
    //    MARK:- Variable Declarations
    var CleanUpDataDict = [CleanUpModel]()
    var groupData : GroupDataModel!
    var countryData : CountryModel!
    var AreaTypeDict = [TypeOfCleanAreaModel]()
    var CountryDict = [CountryModel]()
    var CleanTypeDict = [TypeOfCleanModel]()
    var StatesDataDict = [StatesDataModel]()
    var strCheckGroup = String()
    var setCountryName = String()
    var setStatesname = String()
    var strCleanType = String()
    var seconds = Int()
    var emailOtherOrg = String()
    let dateFormatter = DateFormatter()
    let locale = NSLocale.current
    var datePicker : UIDatePicker!
    let toolBar = UIToolbar()
    var StartcurrentTime = Int()
    var pauseTime = Int()
    var textCheck = String()
    var countryId = Int()
    var statesName = String()
    var stateId = Int()
    var otherorgStateId = Int()
    static var localTimeZoneAbbreviation: String { return  NSTimeZone.local.abbreviation(for: Date())! }
    let currentdate = Date()
    var statesArr:[String] = ["New South Wales","western Australia","Queensland","South Australia","Victoria","Tasmania"]
  
    let nc = NotificationCenter.default
    var timer = Timer()
    var strWithoutTimer = Int()
    var isFullAudit = false
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        AppManager.getSavedData1()
        tf_EnterCleanDate.text = AppDelegate.sharedDelegate.passDetailsModel1.cleanDate
        tf_EnterGroupName.text = AppDelegate.sharedDelegate.passDetailsModel1.groupName
        //tf_EnterLocation.text = AppDelegate.sharedDelegate.passDetailsModel1.location
        tf_EnterLocation.text = ""
        if DeviceType.iPhoneX {
            navViewHeightConstant.constant = 74.0
        }
        tf_EnterCountry.delegate = self
        tf_State.delegate = self
        tf_typeOfClean.delegate = self
        
        self.setupDatePicker()
        self.setupPicker()
        getCleanArea()
        
        if groupData != nil  {
            tf_EnterGroupName.isUserInteractionEnabled = false
            btn_countrydropdown.isHidden = true
            getStates(countryIDD: 13)
            tf_EnterCountry.isUserInteractionEnabled = false
            //            tf_State.isUserInteractionEnabled = false
            tf_EnterGroupName.text = groupData.name
            tf_PostCode.text = groupData.postCode
            tf_PostCode.isUserInteractionEnabled = false

        } else {
            tf_EnterGroupName.isUserInteractionEnabled = true
            tf_EnterGroupName.text = ""
            tf_EnterCountry.text = "Australia"
            tf_State.text = "Victoria"
            self.countryId = 13
            self.otherorgStateId = 273
            getStates(countryIDD: 13)
            btn_statedropdown.isHidden = false
            tf_State.isUserInteractionEnabled = true
            btn_countrydropdown.isHidden = false
            tf_EnterCountry.isUserInteractionEnabled = true
            tf_PostCode.isUserInteractionEnabled = true
        }
        
        tf_typeOfClean.text = "Beach"
        tf_EnterCountry.text = setCountryName
        tf_State.text = setStatesname
        //        tf_State.textColor =
        nc.addObserver(self, selector: #selector(stopTimer), name: Notification.Name("TimerStopped"), object: nil)
        nc.addObserver(self, selector: #selector(pauseTimer), name: Notification.Name("TimerPaused"), object: nil)
        nc.addObserver(self, selector: #selector(resumeTimer), name: Notification.Name("TimerResumed"), object: nil)
        dateFormatter.locale = Locale.init(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        tf_EnterCleanDate.text = dateFormatter.string(from: Date())
      
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override func viewDidLayoutSubviews() {
        viewInitialSetup()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK:- Back Button Action
    @IBAction func BackButtonAction(_ sender: Any) {
        saveDetails()
        self.navigationController?.popViewController(animated: true)
    }
    //    MARK:- Standard Audit Clean Button Action
    @IBAction func StandardCleanBtnACtion(_ sender: UIButton) {
        //       Mark:- VALIDATIONS
        if StartcurrentTime == 0 {
            let alert = UIAlertController(title: kAlertTitle , message: "Please select a suitable timer option to continue", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else if btn_StartTimer.isSelected == true {
            let alert = UIAlertController(title: kAlertTitle , message: "Please start the timer to continue", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else if tf_EnterCleanDate.text == "" {
            let alert = UIAlertController(title: kAlertTitle , message: "Please fill the required date field to continue", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }else if tf_EnterLocation.text == "" {
            let alert = UIAlertController(title: kAlertTitle , message: "Please fill the required location field to continue", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else if tf_EnterGroupName.text == "" {
            let alert = UIAlertController(title: kAlertTitle , message: "Please fill the required group name field to continue", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else if tf_EnterCountry.text == "" {
            let alert = UIAlertController(title: kAlertTitle , message: "Please fill the required Country field to continue", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else if tf_PostCode.text == "" {
            let alert = UIAlertController(title: kAlertTitle , message: "Please fill the required post code field to continue", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else if tf_State.text == "" {
            let alert = UIAlertController(title: kAlertTitle , message: "Please fill the required State field to continue", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else if tf_typeOfClean.text == "" {
            let alert = UIAlertController(title: kAlertTitle , message: "Please select the required Type Of Clean Area to continue", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else {
            if sender.tag == 1{
                if self.btn_NoSortingClean.isEnabled == true{
                    isFullAudit = false
                    self.postCleanUpContent(cleanId: 4)
                    btn_PartialClean.backgroundColor = BtnUnselectColor
                    btn_FullAuditClean.backgroundColor = BtnUnselectColor
                    btn_StandardClean.backgroundColor = BtnUnselectColor
                }
                self.btn_StandardClean.isEnabled = false
                self.btn_FullAuditClean.isEnabled = false
                self.btn_PartialClean.isEnabled = false
               self.btn_NoSortingClean.isEnabled = true
            }else if sender.tag == 2{
                if pauseTime == 0 {
                    if self.btn_StandardClean.isEnabled == true{
                        isFullAudit = false
                        self.postCleanUpContent(cleanId: 1)
                        btn_FullAuditClean.backgroundColor = BtnUnselectColor
                        btn_PartialClean.backgroundColor = BtnUnselectColor
                        btn_NoSortingClean.backgroundColor = BtnUnselectColor
                    }
                    self.btn_StandardClean.isEnabled = true
                    self.btn_FullAuditClean.isEnabled = false
                    self.btn_PartialClean.isEnabled = false
                    self.btn_NoSortingClean.isEnabled = false
                }
            }else if sender.tag == 3 {
                if self.btn_FullAuditClean.isEnabled == true{
                    isFullAudit = true
                    self.postCleanUpContent(cleanId: 2)
                    btn_StandardClean.backgroundColor = BtnUnselectColor
                    btn_PartialClean.backgroundColor = BtnUnselectColor
                    btn_NoSortingClean.backgroundColor = BtnUnselectColor
                }
                self.btn_StandardClean.isEnabled = false
                self.btn_FullAuditClean.isEnabled = true
                self.btn_PartialClean.isEnabled = false
                 self.btn_NoSortingClean.isEnabled = false
            }else {
                if self.btn_FullAuditClean.isEnabled == true{
                    isFullAudit = false
                    self.postCleanUpContent(cleanId: 3)
                    btn_StandardClean.backgroundColor = BtnUnselectColor
                    btn_NoSortingClean.backgroundColor = BtnUnselectColor
                    btn_PartialClean.backgroundColor = BtnUnselectColor
                }
                self.btn_StandardClean.isEnabled = false
                self.btn_FullAuditClean.isEnabled = false
                self.btn_NoSortingClean.isEnabled = false
                self.btn_PartialClean.isEnabled = true
            }
        }
    }
    
    //MARK:- Timer Button Actions
    @IBAction func TimerBtnAction(_ sender: Any) {
        
    }
    @IBAction func btn_StartTimerAction(_ sender: Any) {
        self.StartcurrentTime = Int(NSDate().timeIntervalSince1970)
        print(self.StartcurrentTime)
        btn_withoutTimer.backgroundColor = BLACK_COLOR
        btn_StartTimer.backgroundColor = App_Green_Color
        btn_StartTimer.isEnabled = false
        btn_withoutTimer.isEnabled = false
        self.runTimer()
    }
    
    @IBAction func btn_withoutTimerAction(_ sender: Any) {
        self.StartcurrentTime = Int(NSDate().timeIntervalSince1970)
        print(self.StartcurrentTime)
        btn_withoutTimer.backgroundColor = App_Green_Color
        btn_StartTimer.backgroundColor = BLACK_COLOR
        btn_StartTimer.isEnabled = false
        btn_withoutTimer.isEnabled = false
        strWithoutTimer = 1
        AppDelegate.sharedDelegate.timerSecond = 0
        self.timer.invalidate()
    }
    
    //      MARK:- Calender Button DropDown
    @IBAction func CalenderBtnAction(_ sender: Any) {
        //        self.setupDatePicker()
    }
    //      MARK:- Type Of Clean DropDown Menu
    @IBAction func TYpeOfCleanBtnDropDownACtion(_ sender: Any) {
        
    }
    //MARK:- Country Drop Down Menu
    @IBAction func CountryDropDownBtnACtion(_ sender: Any) {
    }
    //MARK:- TextField Delegate Methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
//        tf_EnterCleanDate.resignFirstResponder()
//        tf_typeOfClean.resignFirstResponder()
        tf_EnterCountry.resignFirstResponder()
//        tf_PostCode.resignFirstResponder()
//        tf_State.resignFirstResponder()
        return false
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == tf_EnterCountry {
            textCheck = "country"
        }else if textField == tf_typeOfClean {
            textCheck = "clean"
        }else if textField == tf_State {
            textCheck = "state"
        }
        return true
    }
    
    //    MARK:- View Setup Custom Methods
    func viewInitialSetup(){
        btn_PartialClean.layer.cornerRadius = (btn_PartialClean.frame.height)/2
        btn_StandardClean.layer.cornerRadius = (btn_StandardClean.frame.height)/2
        btn_FullAuditClean.layer.cornerRadius = (btn_FullAuditClean.frame.height)/2
        btn_NoSortingClean.layer.cornerRadius = (btn_NoSortingClean.frame.height)/2
        tf_EnterCleanDate.setTextFieldBoader(1, borderC: TF_BORDER_COLOR)
        tf_typeOfClean.setTextFieldBoader(1, borderC: TF_BORDER_COLOR)
        tf_EnterCountry.setTextFieldBoader(1, borderC: TF_BORDER_COLOR)
        tf_EnterLocation.setTextFieldBoader(1, borderC: TF_BORDER_COLOR)
        tf_EnterGroupName.setTextFieldBoader(1, borderC: TF_BORDER_COLOR)
        tf_PostCode.setTextFieldBoader(1, borderC: TF_BORDER_COLOR)
        tf_State.setTextFieldBoader(1, borderC: TF_BORDER_COLOR)
        lbl_enterState.textColor = App_Blue_Color
        tf_State.setLeftPaddingView()
        btn_StartTimer.btnRoundCorner(cornerRadius: 15)
        lbl_enterDate.textColor = App_Blue_Color
        lbl_EnterLocation.textColor = App_Blue_Color
        lbl_enterGroupName.textColor = App_Blue_Color
        lbl_enterCountry.textColor = App_Blue_Color
        lbl_enterCleanArea.textColor = App_Blue_Color
        tf_EnterGroupName.setLeftPaddingView()
        tf_PostCode.setLeftPaddingView()
        tf_EnterLocation.setLeftPaddingView()
        tf_EnterCountry.setLeftPaddingView()
        tf_EnterCleanDate.setLeftPaddingView()
        tf_typeOfClean.setLeftPaddingView()
    }
    
    func checkTypeOfClean(){
    }
    
    //    MARK:- Timer Custom Methods
    func runTimer(){
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    //    let hours = Int(time) / 3600
    //    let minutes = Int(time) / 60 % 60
    //    let seconds = Int(time) % 60
    //    return String(format:”%02i:%02i:%02i”, hours, minutes, seconds)
    
    @objc func updateTimer() {
        seconds += 1
        let timerStr = String(format: "%02d:%02d:%02d",(seconds / 3600),(seconds % 3600) / 60, (seconds % 3600) % 60)
        btn_Timer.setTitle(timerStr, for: .normal)
        btn_Timer.titleLabel?.sizeToFit()
        
        AppDelegate.sharedDelegate.timerSecond = seconds
    }
    @objc func stopTimer(){
        self.timer.invalidate()
    }
    @objc func pauseTimer(){
        self.timer.invalidate()
    }
    @objc func resumeTimer(){
        self.runTimer()
        
    }
    //    MARK:- PickerView Custom Method
    func setupPicker(){
        let picker = UIPickerView()
        picker.backgroundColor = CLEAR_COLOR
        picker.showsSelectionIndicator = true
        picker.delegate = self
        picker.dataSource = self
        tf_typeOfClean.inputView = picker
        if tf_EnterCountry.text == "" {
            tf_EnterCountry.inputView = picker
            tf_State.inputView = picker
        }
    }
    
    //MARK:- Date Picker Methods
    func setupDatePicker(){
        let datePickerView2 = UIDatePicker()
        datePickerView2.datePickerMode = .date
        
        //  datePickerView2.minimumDate = Date()
        /*       dateFormatter.timeZone = NSTimeZone(name: "UTC")! as TimeZone
         let date = dateFormatter.date(from: "2018-12-31")
         let datePickerView = UIDatePicker()
         datePickerView.datePickerMode = .date
         //     datePickerView.minimumDate = (Calendar.current as NSCalendar).date(byAdding: .year, value: -17, to: Date(), options: [])!
         datePickerView.maximumDate = date
         tfDate.inputView = datePickerView
         */
        dateFormatter.timeZone = NSTimeZone(name: "UTC")! as TimeZone
        let date = dateFormatter.date(from: "2018-12-31")
        datePickerView2.maximumDate = date
        tf_EnterCleanDate.inputView = datePickerView2
        datePickerView2.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
    }
    
    @objc func handleDatePicker(sender: UIDatePicker) {
        dateFormatter.locale = Locale.init(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        tf_EnterCleanDate.text = dateFormatter.string(from: sender.date)
    }
    //    MARK:- PickerView Methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if textCheck == "country"{
            return CountryDict.count
        }else if textCheck == "state"{
            return StatesDataDict.count
        }else {
            return AreaTypeDict.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if textCheck == "country"{
            let dict3 = CountryDict[row]
            return dict3.countryName
        }else if textCheck == "state" {
            let dict4 = StatesDataDict[row]
            return dict4.statename
        }else {
            let dict = AreaTypeDict[row]
            return dict.areaType
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if textCheck == "country"{
            let dict3 = CountryDict[row]
            tf_EnterCountry.text = dict3.countryName
            countryId = dict3.cID
            getStates(countryIDD: countryId)
            tf_State.text = ""
        }else if textCheck == "state"{
            let dict4 = StatesDataDict[row]
            otherorgStateId = dict4.stateIDD
            tf_State.text = dict4.statename
        }else{
            let  dict = AreaTypeDict[row]
            tf_typeOfClean.text = dict.areaType
        }}
    
    // MARK:- WBS_METHOD
    func getCleanArea(){
        var params :  [String:String]
        if self.accessibilityHint == "next" {
            params = ["organisation_id":"0"]
        }else {
            params = ["organisation_id":"\(groupData.organizationId)"]
        }
        ServerManager.shared.showHud()
        ServerManager.shared.httpPost(request: API_GET_CLEAN_AREA, params: params, successHandler:
            {(JSON) in
                ServerManager.shared.hidHud()
                print(JSON)
                if JSON["success"].boolValue == true {
                    let typeOfAreaArr = JSON["TypeOfCleanArea"].arrayValue
                    let typeOfCleanArr = JSON["type_of_clean"].arrayValue
                    let countryNamesArr = JSON["countries"].arrayValue
                    
                    for dict in typeOfAreaArr{
                        let AreaTypeData = TypeOfCleanAreaModel.init(CleanAreaDetails :dict)
                        self.AreaTypeDict.append(AreaTypeData)
                        
                    }
                    for dict2 in typeOfCleanArr{
                        let CleanType = TypeOfCleanModel.init(TypeOfCleanDetails :dict2)
                        self.CleanTypeDict.append(CleanType)
                    }
                    for dict3 in countryNamesArr{
                        let Countrynames = CountryModel.init(CountryDetails:dict3)
                        self.CountryDict.append(Countrynames)
                    }
                }
                else{
                    ServerManager.shared.hidHud()
                    AppManager.showErrorDialog(viewControler: self, message: JSON["message"].stringValue)
                }
        }){ (error) in
            ServerManager.shared.hidHud()
            AppManager.showErrorDialog(viewControler: self, message: AppManager.getErrorMessage(error! as NSError))
        }
    }
    //    WBS METHOD FOR GETTING STATES LIST
    func getStates(countryIDD: Int) {
        self.StatesDataDict.removeAll()
        let params : [String : Any] = ["country_id":countryIDD]
        //        ServerManager.shared.showHud()
        ServerManager.shared.httpPost(request: API_GetStates, params: params, successHandler:
            {(JSON) in
                ServerManager.shared.hidHud()
                print(JSON)
                if JSON["success"].boolValue == true {
                    let statesArr = JSON["states"].arrayValue
                    
                    for dict in statesArr{
                        let StatesData = StatesDataModel.init(StatesDetails: dict)
                        self.StatesDataDict.append(StatesData)
                        
                    }
                    
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
    //    MARK:WBS_POST
    func postCleanUpContent(cleanId: Int) {
        var params :  [String:String]
        if accessibilityHint == "next" {
            params =
                [  "group_id": "0",
                   "country_id":"\(self.countryId)",
                    "clean_date":tf_EnterCleanDate.text!,
                    "location":tf_EnterLocation.text!,
                    "timer_start_timestamp":"\(StartcurrentTime)",
                    "type_of_clean_area":tf_typeOfClean.text!,
                    "group_name":tf_EnterGroupName.text!,
                    "post_code":tf_PostCode.text!,
                    "type_of_clean_id":"\(cleanId)",
                    "group_email":emailOtherOrg,
                    "state_id":"\(self.otherorgStateId)"]
        }
        else {
            params =
                [  "group_id": "\(self.groupData.groupid)",
                    "country_id":"\(self.groupData.countryId)",
                    "clean_date":tf_EnterCleanDate.text!,
                    "location":tf_EnterLocation.text!,
                    "timer_start_timestamp":"\(StartcurrentTime)",
                    "type_of_clean_area":tf_typeOfClean.text!,
                    "group_name":tf_EnterGroupName.text!,
                    "post_code":tf_PostCode.text!,
                    "type_of_clean_id":"\(cleanId)",
                    "group_email":"\(self.groupData.email)",
                    "state_id":"\(self.stateId)"]
        }
       saveDetails()
        ServerManager.shared.showHud()
        ServerManager.shared.httpPost(request: API_START_CLEANUP, params: params, successHandler:
            {(JSON) in
                ServerManager.shared.hidHud()
                print(JSON)
                if JSON["success"].boolValue == true {
                    let dict = JSON["newCreatedCleanup"]
                    if cleanId == 1 {
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "BpLosVC") as! BpLosVC
                        vc.isFullAudit = self.isFullAudit
                        vc.typeofCleanID = dict["id"].intValue
                        vc.typeOfCleanArea = dict["type_of_clean_area"].stringValue
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                    else if cleanId == 2 {
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "FullAuditCleanVC") as! FullAuditCleanVC
                        vc.isFullAudit = self.isFullAudit
                        vc.typeofCleanID = dict["id"].intValue
                        vc.typeOfCleanArea = dict["type_of_clean_area"].stringValue
                        vc.withoutTimerStr = self.strWithoutTimer
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                    else if cleanId == 3 {
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PartialAuditVC") as! PartialAuditVC
                        vc.isFullAudit = self.isFullAudit
                        vc.typeofCleanID = dict["id"].intValue
                        vc.withoutTimerStr = self.strWithoutTimer
                        self.navigationController?.pushViewController(vc, animated: true)
                    }else {
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TimeAndEffortVc") as! TimeAndEffortVc
                        vc.isFullAudit = self.isFullAudit
                        vc.cleanId = dict["id"].intValue
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
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
    //    MARK:- CUSTOM FUNCTION FOR SAVING DATA

    func saveDetails(){
        
        if accessibilityHint == "next" {
            AppDelegate.sharedDelegate.passDetailsModel1?.groupID = 0
             AppDelegate.sharedDelegate.passDetailsModel1?.countryID = self.countryId
             AppDelegate.sharedDelegate.passDetailsModel1?.cleanDate = tf_EnterCleanDate.text!
             AppDelegate.sharedDelegate.passDetailsModel1?.location = tf_EnterLocation.text!
             AppDelegate.sharedDelegate.passDetailsModel1?.startCurrentTime = "\(StartcurrentTime)"
             AppDelegate.sharedDelegate.passDetailsModel1?.typeOfCleanArea = tf_typeOfClean.text!
             AppDelegate.sharedDelegate.passDetailsModel1?.groupName = tf_EnterGroupName.text!
             AppDelegate.sharedDelegate.passDetailsModel1?.emailOtherOrg = emailOtherOrg
             AppDelegate.sharedDelegate.passDetailsModel1?.stateID = "\(self.otherorgStateId)"
            AppManager.saveData1(model1:  AppDelegate.sharedDelegate.passDetailsModel1 ?? aboutCleanModel())
        }else{
             AppDelegate.sharedDelegate.passDetailsModel1?.groupID = groupData.groupid
             AppDelegate.sharedDelegate.passDetailsModel1?.countryID = groupData.countryId
             AppDelegate.sharedDelegate.passDetailsModel1?.cleanDate = tf_EnterCleanDate.text!
             AppDelegate.sharedDelegate.passDetailsModel1?.location = tf_EnterLocation.text!
             AppDelegate.sharedDelegate.passDetailsModel1?.startCurrentTime = "\(StartcurrentTime)"
             AppDelegate.sharedDelegate.passDetailsModel1?.typeOfCleanArea = tf_typeOfClean.text!
             AppDelegate.sharedDelegate.passDetailsModel1?.groupName = tf_EnterGroupName.text!
             AppDelegate.sharedDelegate.passDetailsModel1?.emailOtherOrg = self.groupData.email
             AppDelegate.sharedDelegate.passDetailsModel1?.stateID = "\(self.stateId)"
            AppManager.saveData1(model1:  AppDelegate.sharedDelegate.passDetailsModel1 ?? aboutCleanModel())
        }
    }
}

//MARK:- Extension
extension Date {
    func toMillis() -> Int64! {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}

