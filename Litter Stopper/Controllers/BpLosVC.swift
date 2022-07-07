//
//  BpLosVC.swift
//  Litter Stopper
//
//  Created by Apple01 on 9/5/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import AVFoundation

class BpLosVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UINavigationControllerDelegate, UIImagePickerControllerDelegate,UIGestureRecognizerDelegate,UITextFieldDelegate {

   // MARK:- IBOUTLETS
    @IBOutlet weak var lbl_TotalCount: UILabel!
    @IBOutlet var navViewHeightConstant: NSLayoutConstraint!
    @IBOutlet weak var btn_camera: UIButton!
    @IBOutlet weak var btn_Back: UIButton!
    @IBOutlet weak var txtview_Notes: UITextView!
    @IBOutlet weak var btn_RemoveItem: UIButton!
    @IBOutlet weak var btn_AddItem: UIButton!
    @IBOutlet weak var btn_finishCollection: UIButton!
    @IBOutlet weak var view_Buttons: UIView!
    @IBOutlet weak var CollView_Category: UICollectionView!

    //    MARK:- Variable Declarations
    var cellImgArr = [#imageLiteral(resourceName: "bottle_glass"),#imageLiteral(resourceName: "plastic_bottle"),#imageLiteral(resourceName: "canmetal"),#imageLiteral(resourceName: "syrings")]
    var typeofCleanID = Int()
    var typeOfCleanArea = String()
    var img : UIImage!
  
    var arrItemsDict = [ItemDetailDataModel]()
    var savedataModel = SaveItemDetailsModel()
    
    var cellTitleArr = ["Bot Gl","Bot Pl","Can Met","Syringe","Bit H","Bit H","Frag  S","Frag S","Micro Pl","Food Wr","Food Ct","Bag Pl","Zip L","Straw","Bot Top","Bot Lab","Cup Cof","Cup Oth","Balloon","Cutlery","PolyS","Fish L","Butt","Nurdles"]
    var btnAddRemoveCheck = Int()
    var isFullAudit = false

    //    MARK:- View Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        if AppDelegate.sharedDelegate.PassDetailsModel2.notes != "" {
            AppDelegate.sharedDelegate.PassDetailsModel2.notes = self.txtview_Notes.text
        }
        if AppDelegate.sharedDelegate.PassDetailsModel2.dictItemCountDetail.count == 0 {
            for (indes,_) in cellImgArr.enumerated() {
                print("index count \(indes)")
            AppDelegate.sharedDelegate.PassDetailsModel2.dictItemCountDetail.append(["index": "\(indes)","value":"\(0)"])
            }
        }
     self.lbl_TotalCount.text = AppDelegate.sharedDelegate.PassDetailsModel2.totalCount
        CollView_Category.delegate = self
        CollView_Category.dataSource = self
        btn_AddItem.isSelected = true
        self.btnAddRemoveCheck = 1
      
        let lpgr : UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action:#selector(handleLongPress(gestureRecognizer:)))
        lpgr.minimumPressDuration = 0.5
        lpgr.delegate = self
        lpgr.delaysTouchesBegan = true
        self.CollView_Category?.addGestureRecognizer(lpgr)

        if DeviceType.iPhoneX {
            navViewHeightConstant.constant = 74.0
        }else{
            navViewHeightConstant.constant = 64.0
        }
        getallDescription()
    }
    override func viewDidLayoutSubviews() {
        viewInitialSetup()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    //MARK:- Custom Methods
    func viewInitialSetup(){
        txtview_Notes.layer.borderColor = TF_BORDER_COLOR.cgColor
        txtview_Notes.layer.borderWidth = 1
        view_Buttons.layer.cornerRadius = (view_Buttons.frame.height)/2
        view_Buttons.layer.borderWidth = 3
        view_Buttons.layer.borderColor = cellBGColor.cgColor
        view_Buttons.layer.masksToBounds = true
        btn_finishCollection.layer.cornerRadius = (btn_finishCollection.frame.height)/2

    }
    //MARK:- Button Actions
    @IBAction func cameraBtnAction(_ sender: Any) {
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

    @IBAction func FinishCollBtnACtion(_ sender: Any) {

        self.finishCollection()
      /*  if txtview_Notes.text == "" {
       MessageView.show(in: self.view, withMessage: "Please fill the required Notes field")
        }else {
        self.finishCollection()
        }
         */
    }
    @IBAction func BackbtnACtion(_ sender: Any) {
        saveDetails()
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func RemoveBtnAction(_ sender: Any) {
        btn_AddItem.isSelected = false
        btn_RemoveItem.isSelected = true
        self.btnAddRemoveCheck = 2
    }
    @IBAction func AddBtnAction(_ sender: Any) {
        btn_AddItem.isSelected = true
        btn_RemoveItem.isSelected = false
        self.btnAddRemoveCheck = 1
    }

    //MARK:- CollectionView Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellImgArr.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = CollView_Category.dequeueReusableCell(withReuseIdentifier: "BpLosCell", for: indexPath) as! BpLosCell
        cell.img_Content.image = cellImgArr[indexPath.row]
        cell.lbl_title.text = cellTitleArr[indexPath.row]
        cell.lbl_title.textAlignment = .center
        cell.View_cell.backgroundColor = cellBGColor
        cell.View_cell.layer.cornerRadius = 10.0
        cell.View_cell.layer.masksToBounds = true
        cell.img_info.bringSubview(toFront: cell.img_info)

//        Display-SAVED-DATA
        print(AppDelegate.sharedDelegate.PassDetailsModel2.dictItemCountDetail)
        
        for dict in AppDelegate.sharedDelegate.PassDetailsModel2.dictItemCountDetail {
   let indexx = AppDelegate.sharedDelegate.PassDetailsModel2.dictItemCountDetail[indexPath.row] ["index"]
  let valuee = AppDelegate.sharedDelegate.PassDetailsModel2.dictItemCountDetail[indexPath.row] ["value"]
          
        cell.lbl_count.text = valuee
        }
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        tap.delegate = self
        cell.lbl_title.addGestureRecognizer(tap)
        cell.lbl_title.isUserInteractionEnabled = true
        cell.lbl_title.tag = indexPath.row
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

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = CollView_Category.cellForItem(at: indexPath) as! BpLosCell
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
        cell.lbl_count.text = "\(cell.count)"
        //SAVE DATA by TAP
        AppDelegate.sharedDelegate.PassDetailsModel2.dictItemCountDetail[indexPath.row]["value"]  = "\(cell.count)"
        
            saveDetails()
           self.totalCount()
    }
    func totalCount(){
        var totalcount = Int()
        for i in 0...3
        {
            let countCell = CollView_Category.cellForItem(at: IndexPath(row:i, section:0)) as! BpLosCell
            totalcount += countCell.count
        }
        self.lbl_TotalCount.text = "TOTAL: \(totalcount)"
        AppDelegate.sharedDelegate.PassDetailsModel2.totalCount = "TOTAL: \(totalcount)"
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.view.frame.size.width/4)-10, height: (self.view.frame.size.width/4)+25)
    }

    //MARK:- Collection Flow Layout Delegate Mehtods
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
        let p = gestureRecognizer.location(in: self.CollView_Category)
        
        if let indexPath = self.self.CollView_Category.indexPathForItem(at: p) {
            let cell = self.self.CollView_Category.cellForItem(at: indexPath) as?BpLosCell
            let alert = UIAlertController(title: kAlertTitle, message: "Enter number of collections under selected category", preferredStyle: .alert)
            alert.addTextField { (textField) in
                let countStr:String! = cell!.lbl_count.text!
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
                   
                    cell?.lbl_count.text = "\(cell!.count)"
                    //SAVE DATA From Alert
        AppDelegate.sharedDelegate.PassDetailsModel2.dictItemCountDetail[indexPath.row]["value"]  = "\(cell!.count)"
                }
                self.totalCount()
            }))
            self.present(alert, animated: true, completion: nil)
        }

    }

 
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

    //    MARK:- UIImagePickerDelegates
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true)

        guard let image = info[UIImagePickerControllerEditedImage] as? UIImage else {
            print("No image found")
            return
        }
        img = image
        print(image.size)
        print (image)
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
//    WBS POST
    func finishCollection(){
        var ItemData = [[String: AnyObject]]()
        var ItemDict = Dictionary<String, String>()
        var finalDict = Dictionary<String,AnyObject >()

        for (index, _) in self.cellTitleArr.enumerated() {
            let cell = self.CollView_Category.cellForItem(at: IndexPath(row:index,section:0)) as?BpLosCell
            if index<4{
                ItemDict["itemName"] = self.cellTitleArr[index]
                ItemDict["item_id"] = "\(index+1)"
                ItemDict["quantity"] = "\(cell!.count)"
            }else {
            ItemDict["itemName"] = self.cellTitleArr[index]
            ItemDict["item_id"] = "\(index+1)"
            ItemDict["quantity"] = "0"
            }
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
        let params : [String:String] = ["cleanup_id": "\(typeofCleanID)","note": txtview_Notes.text!,"item_data": itemDataStr]
        var temp = [MultipartData]()
        if img == nil {

        }else {
            temp.append(MultipartData.init(medaiObject: img, mediaKey: "image"))
        }
        saveDetails()
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
    //MARK:- CUSTOM FUNCTION FOR SAVING DATA
    func saveDetails() {
        AppDelegate.sharedDelegate.PassDetailsModel2.notes = self.txtview_Notes.text
        
    }
}

extension Collection where Iterator.Element == Dictionary<String,AnyObject > {
    func toJSONString(options: JSONSerialization.WritingOptions = .prettyPrinted) -> String {
        if let arr = self as? Dictionary<String,AnyObject >,
            let dat = try? JSONSerialization.data(withJSONObject: arr, options: options),
            let str = String(data: dat, encoding: String.Encoding.utf8) {
            return str
        }
        return "[]"
    }
}
