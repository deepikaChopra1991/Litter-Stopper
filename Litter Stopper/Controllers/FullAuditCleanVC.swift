//
//  FullAuditCleanVC.swift
//  Litter Stopper
//
//  Created by Apple01 on 9/19/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import AVFoundation

class FullAuditCleanVC: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UINavigationControllerDelegate, UIImagePickerControllerDelegate,UIGestureRecognizerDelegate,UITextFieldDelegate{
    //MARK:- IBOUTLETS
    @IBOutlet var navViewHeightConstant: NSLayoutConstraint!
    @IBOutlet weak var btn_Finishcollection: UIButton!
    @IBOutlet var collectionHeight: NSLayoutConstraint!
    @IBOutlet weak var btn_pauseCollection: UIButton!
    @IBOutlet weak var btn_RemoveItem: UIButton!
    @IBOutlet weak var btn_AddItem: UIButton!
    @IBOutlet weak var view_AddRemovebtns: UIView!
    @IBOutlet weak var txtview_Note: UITextView!
    @IBOutlet weak var lbl_Total: UILabel!
    @IBOutlet weak var collview_Content: UICollectionView!
    @IBOutlet weak var btn_camera: UIButton!
    @IBOutlet weak var btn_Back: UIButton!
    
    //MARK:- Variables
    var totalcount = Int()
    var typeofCleanID = Int()
    var typeOfCleanArea = String()
    var withoutTimerStr = Int()
    var img : UIImage!
    var btnAddRemoveCheck = Int()
    let nc = NotificationCenter.default
    var pauseState : Bool!
    var resumeState : Bool!
     var arrItemsDict = [ItemDetailDataModel]()
    var cellImgArr = [#imageLiteral(resourceName: "bottle_glass"),#imageLiteral(resourceName: "plastic_bottle"),#imageLiteral(resourceName: "canmetal"),#imageLiteral(resourceName: "syrings"),#imageLiteral(resourceName: "h_smaller"),#imageLiteral(resourceName: "h_greater"),#imageLiteral(resourceName: "s_smaller"),#imageLiteral(resourceName: "s_greater"),#imageLiteral(resourceName: "micro"),#imageLiteral(resourceName: "wrap"),#imageLiteral(resourceName: "food_container"),#imageLiteral(resourceName: "bags-plastic"),#imageLiteral(resourceName: "bag-ziplock"),#imageLiteral(resourceName: "straw"),#imageLiteral(resourceName: "top_plastic"),#imageLiteral(resourceName: "label"),#imageLiteral(resourceName: "coffee-cup"),#imageLiteral(resourceName: "cup_other"),#imageLiteral(resourceName: "balloon"),#imageLiteral(resourceName: "cutlery"),#imageLiteral(resourceName: "foam"),#imageLiteral(resourceName: "fish"),#imageLiteral(resourceName: "cigarettebutt"),#imageLiteral(resourceName: "nurdles")]
    var cellTitleArr = ["Bot Gl","Bot Pl","Can Met","Syringe","Bit H","Bit H","Frag  S","Frag S","Micro Pl","Food Wr","Food Ct","Bag Pl","Zip L","Straw","Bot Top","Bot Lab","Cup Cof","Cup Oth","Balloon","Cutlery","PolyS","Fish L","Butt","Nurdles"]
    var isFullAudit = false

    fileprivate  var didUpdateCollectionHeight:CGFloat = 150{
        didSet{
            DispatchQueue.main.async {
                self.collectionHeight.constant = self.didUpdateCollectionHeight * CGFloat(self.cellTitleArr.count/4) + 50
            }
        }
    }
    //    MARK:- View Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        if AppDelegate.sharedDelegate.PassdetailsFullAudit.dictItemFullAuditCount.count == 0 {
            for (indes,_) in cellTitleArr.enumerated() {
                print("index count \(indes)")
        AppDelegate.sharedDelegate.PassdetailsFullAudit.dictItemFullAuditCount.append(["index": "\(indes)","value":"\(0)"])
            }
        }
        self.lbl_Total.text = AppDelegate.sharedDelegate.PassdetailsFullAudit.totalCount
        
        btn_AddItem.isSelected = true
        self.btnAddRemoveCheck = 1
        let lpgr : UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action:#selector(handleLongPress(gestureRecognizer:)))
        lpgr.minimumPressDuration = 0.5
        lpgr.delegate = self
        lpgr.delaysTouchesBegan = true
        self.collview_Content?.addGestureRecognizer(lpgr)
        if DeviceType.iPhoneX {
            navViewHeightConstant.constant = 74.0
        }
        collview_Content.delegate = self
        collview_Content.dataSource = self
        if withoutTimerStr == 1 {
            btn_pauseCollection.isEnabled = false
            btn_pauseCollection.backgroundColor = BtnUnselectColor
        }
        pauseState = UserDefaults.SFSDefault(boolForKey: "pause")
        resumeState = UserDefaults.SFSDefault(boolForKey: "resume")
        if resumeState{
            btn_pauseCollection.setTitle("Resume Collection", for: .normal)
            btn_pauseCollection.isSelected = true
        }
        getallDescription()
    }
    override func viewDidLayoutSubviews() {
        txtview_Note.layer.borderColor = TF_BORDER_COLOR.cgColor
        txtview_Note.layer.borderWidth = 1
        view_AddRemovebtns.layer.cornerRadius = view_AddRemovebtns.frame.size.height/2
        view_AddRemovebtns.layer.borderWidth = 3
        view_AddRemovebtns.layer.borderColor = cellBGColor.cgColor
        btn_pauseCollection.layer.cornerRadius = btn_pauseCollection.frame.size.height/2
        btn_Finishcollection.layer.cornerRadius = btn_Finishcollection.frame.size.height/2
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //MARK:- Button Actions
    @IBAction func backbtnAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func FinishCollBtnAction(_ sender: Any) {
     /*   if txtview_Note.text == "" {
            MessageView.show(in: self.view, withMessage: "Please fill the required Notes field")
        }else */
            if btn_pauseCollection.titleLabel?.text == "Resume Collection"{
            MessageView.show(in: self.view, withMessage: "You need to Resume the Timer to Continue")
        }else{
            self.finishCollection()
        }
    }

    @IBAction func RemoveItemBtnAction(_ sender: Any) {
        btn_AddItem.isSelected = false
        btn_RemoveItem.isSelected = true
        self.btnAddRemoveCheck = 2
    }
    @IBAction func AddItemBtnAction(_ sender: Any) {
        btn_AddItem.isSelected = true
        btn_RemoveItem.isSelected = false
        self.btnAddRemoveCheck = 1
    }
    @IBAction func CameraBtnAction(_ sender: Any) {
        if AVCaptureDevice.authorizationStatus(for: .video) == .authorized {
            //already authorized
            let vc = UIImagePickerController()
            vc.sourceType = .camera
            vc.allowsEditing = true
            vc.delegate = self

            self.present(vc, animated: true)
        } else {
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in if granted {
                //access allowed
                let vc = UIImagePickerController()
                vc.sourceType = .camera
                vc.allowsEditing = true
                vc.delegate = self

                self.present(vc, animated: true)
            } else {
                self.alertPromptToAllowCameraAccessViaSetting()
                } }) }

    }
    func alertPromptToAllowCameraAccessViaSetting() {
        let alert = UIAlertController(title: "Error", message: "Camera access required to...", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .default))
        alert.addAction(UIAlertAction(title: "Settings", style: .cancel))

        guard let settingsUrl = URL(string: UIApplicationOpenSettingsURLString)
            else {
                return
        }
        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                print("Settings opened: \(success)")
            })
        }
    }

    @IBAction func PauseCollBtnAction(_ sender: Any) {
        if btn_pauseCollection.isSelected == true {
            btn_pauseCollection.isSelected = false
        btn_pauseCollection.setTitle("Pause Collection", for: .normal)

        UserDefaults.SFSDefault(setBool: false, forKey: "resume")
        nc.post(name: Notification.Name("TimerResumed"), object: nil)
            btn_Finishcollection.backgroundColor = App_Blue_Color
        }else {
            btn_pauseCollection.isSelected = true
        btn_pauseCollection.setTitle("Resume Collection", for: .normal)
            UserDefaults.SFSDefault(setBool: true, forKey: "resume")
        nc.post(name: Notification.Name("TimerPaused"), object: nil)
            btn_Finishcollection.backgroundColor = BtnUnselectColor
        }
    }
    //    MARK:- CollectionView Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellTitleArr.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collview_Content.dequeueReusableCell(withReuseIdentifier: "FullAuditCell", for: indexPath) as! FullAuditCell
        cell.img_Content.image = cellImgArr[indexPath.row]
        cell.lbl_title.textAlignment = .center
        cell.lbl_title.text = cellTitleArr[indexPath.row]
        cell.View_cell.backgroundColor = cellBGColor
        cell.View_cell.layer.cornerRadius = 10.0
        cell.View_cell.layer.masksToBounds = true
        //        Display-SAVED-DATA
        print(AppDelegate.sharedDelegate.PassdetailsFullAudit.dictItemFullAuditCount)
        
        for dict in AppDelegate.sharedDelegate.PassdetailsFullAudit.dictItemFullAuditCount {
            let indexx = AppDelegate.sharedDelegate.PassdetailsFullAudit.dictItemFullAuditCount[indexPath.row] ["index"]
            let valuee = AppDelegate.sharedDelegate.PassdetailsFullAudit.dictItemFullAuditCount[indexPath.row] ["value"]
            
            cell.lbl_Count.text = valuee
        }
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        tap.delegate = self
        cell.lbl_title.tag = indexPath.row
        cell.lbl_title.addGestureRecognizer(tap)
        cell.lbl_title.isUserInteractionEnabled = true
       
        let tapInfo = UITapGestureRecognizer(target: self, action: #selector(infoTap(sender:)))
        tapInfo.delegate = self
        cell.img_info.addGestureRecognizer(tapInfo)
        cell.img_info.isUserInteractionEnabled = true
        cell.img_info.tag = indexPath.row
        
        return cell
    }
    @objc func infoTap(sender: UITapGestureRecognizer? = nil) {
        let tag = sender?.view?.tag
        var msgStr = String()
        if tag == 0 {
            msgStr = arrItemsDict[0].desc
        }else if tag == 1{
            msgStr = arrItemsDict[1].desc
        }else if tag == 2{
            msgStr = arrItemsDict[2].desc
        }else {
            msgStr = arrItemsDict[3].desc
        }
        let alert = UIAlertController(title: kAlertTitle, message: msgStr, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
  
    }
    @objc func handleTap(sender: UITapGestureRecognizer? = nil) {
        let tag = sender?.view?.tag

        let strMsg = self.arrItemsDict[tag!].desc
        let alert = UIAlertController(title: kAlertTitle, message: strMsg, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collview_Content.cellForItem(at: indexPath) as! FullAuditCell
       
        cell.View_cell.backgroundColor = App_Blue_Color
        UIView.animate(withDuration: 0.1, delay: 0.0, options: [], animations: {
            cell.View_cell.backgroundColor = cellBGColor

        }, completion: { (finished: Bool) in

        })
        
        if self.btnAddRemoveCheck == 1 {
            cell.count += 1

        }else{
            if cell.count > 0 {
                cell.count -= 1
            }else {
                MessageView.show(in: self.view, withMessage: "Invalid")
            }
        }
        cell.lbl_Count.text = "\(cell.count)"
        //SAVE DATA by TAP
    AppDelegate.sharedDelegate.PassdetailsFullAudit.dictItemFullAuditCount[indexPath.row]["value"]  = "\(cell.count)"
        
        saveDetails()
        self.totalCount()

    }
    func totalCount(){
        var totalcount = Int()
        for i in 0...self.cellTitleArr.count-1
        {
            let countCell = collview_Content.cellForItem(at: IndexPath(row:i, section:0)) as! FullAuditCell
            totalcount += countCell.count
        }
        self.lbl_Total.text = "TOTAL: \(totalcount)"
        AppDelegate.sharedDelegate.PassdetailsFullAudit.totalCount = "TOTAL: \(totalcount)"
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.view.frame.size.width/4)-15, height: (self.view.frame.size.width/4)+15)
    }
    //MARK: Collection Flow Layout Delegate Mehtods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(8.0, 8.0, 8.0, 8.0)
    }
    //    MARK:- Custom Methods for gesture recognizer
    @objc func handleLongPress(gestureRecognizer : UILongPressGestureRecognizer){

        if (gestureRecognizer.state != UIGestureRecognizerState.began){
            return
        }
        let p = gestureRecognizer.location(in: self.collview_Content)

        if let indexPath = self.collview_Content.indexPathForItem(at: p) {
        let cell = self.collview_Content.cellForItem(at: indexPath) as?FullAuditCell
        let alert = UIAlertController(title: kAlertTitle, message: "Enter number of collections under selected category", preferredStyle: .alert)
        alert.addTextField { (textField) in
                let countStr:String! = cell!.lbl_Count.text!
                textField.text = countStr
                textField.delegate = self
                textField.textAlignment = .center
                textField.keyboardType = UIKeyboardType.numberPad

            }
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0]
                // VALIDATION
                if textField?.text != "" {

                    if self.btnAddRemoveCheck == 1 {
                        cell?.count += Int((textField?.text)!)!
                    }else{
                        if (cell?.count)! >= Int((textField?.text)!)!{
                            cell?.count -=  Int((textField?.text)!)!
                        }
                    }
                  
                    cell?.lbl_Count.text = "\(cell!.count)"
         //SAVE DATA From Alert
    AppDelegate.sharedDelegate.PassdetailsFullAudit.dictItemFullAuditCount[indexPath.row]["value"]  = "\(cell!.count)"
                }
                self.totalCount()
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    //    MARK:- Textfield Delegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let textstring = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        let length = textstring.characters.count
        if (textField.text) != ""
        {
            if Int(textField.text!)! >= 1000 && range.length == 0
            {
                return false
            }
            else {
                return true
            }
        }
        //        if length > 5{
        //            return false
        //        }else if Int(textstring)! > 1000 && Int(textstring)! == 0{
        //            return false
        //        }
        return true
    }

    //MARK:- UIImagePickerDelegates
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true)

        guard let image = info[UIImagePickerControllerEditedImage] as? UIImage else {
            print("No image found")
            return
        }
        print(image.size)
    }
    //MARK:- CUSTOM FUNCTION FOR SAVING DATA
    func saveDetails() {
        AppDelegate.sharedDelegate.PassdetailsFullAudit.notes = self.txtview_Note.text
        
    }
    //    MARK:- WBS METHODS
    //    WBS GET
    func getallDescription() {
        ServerManager.shared.showHud()
        ServerManager.shared.httpGet(request: API_DESCRIPTION , successHandler: { (JSON) in
            ServerManager.shared.hidHud()
            if JSON["success"].boolValue == true{
                print(JSON)

                let DescArr = JSON["data"].arrayValue
                for dict in DescArr{
                    let ItemsData = ItemDetailDataModel.init(ItemDetails: dict)
                    self.arrItemsDict.append(ItemsData)
                }

            }
            else {
                MessageView.show(in: self.view, withMessage:JSON["message"].stringValue )
            }
        }, failureHandler: { (error) in

        }) { (progress) in

        }
    }
    func finishCollection(){
        var ItemData = [[String: AnyObject]]()
        var ItemDict = Dictionary<String, String>()
        var finalDict = Dictionary<String,AnyObject >()

        for (index, element) in self.cellTitleArr.enumerated() {
            let cell = self.collview_Content.cellForItem(at: IndexPath(row:index,section:0)) as?FullAuditCell

            ItemDict["itemName"] = self.cellTitleArr[index]
            ItemDict["item_id"] = "\(index+1)"
            ItemDict["quantity"] = "\(cell!.count)"
            ItemData.append(ItemDict as [String : AnyObject])
        }
        finalDict["itemData"] = ItemData as AnyObject
        var itemDataStr = String()
        if let theJSONData = try?  JSONSerialization.data(
            withJSONObject: finalDict,
            options: .prettyPrinted
            ),
            let theJSONText = String(data: theJSONData,
                                     encoding: String.Encoding.utf8) {
            itemDataStr = theJSONText.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)!
        }
        let params : [String:String] = ["cleanup_id": "\(typeofCleanID)","note": txtview_Note.text!,"item_data": itemDataStr]
        var temp = [MultipartData]()
        if img == nil {

        }else {
            temp.append(MultipartData.init(medaiObject: img, mediaKey: "image"))
        }
        ServerManager.shared.showHud()
        ServerManager.shared.httpUploadWithHeader(api: API_FINISH_COLLECTION, params: params, multipartObject: temp, successHandler: { (JSON) in
            ServerManager.shared.hidHud()
            print(JSON)
            if JSON["success"].boolValue == true {
                let dict = JSON["newCreatedCleanup"]
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "TimeAndEffortVc") as! TimeAndEffortVc
                vc.isFullAudit = self.isFullAudit
                vc.cleanId = self.typeofCleanID
                self.navigationController?.pushViewController(vc, animated: true)
            } else{
                ServerManager.shared.hidHud()
                AppManager.showErrorDialog(viewControler: self, message: JSON["message"].stringValue)
            }
        }, failureHandler: { (error) in
            ServerManager.shared.hidHud()
            AppManager.showErrorDialog(viewControler: self, message: AppManager.getErrorMessage(error! as NSError))
        }) { (progress) in
            //            self.UpdateProgressBar(progress: progress!)
        }
    }
}

