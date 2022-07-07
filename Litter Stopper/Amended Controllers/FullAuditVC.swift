//
//  FullAuditVC.swift
//  Litter Stopper
//
//  Created by Apple01 on 9/5/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class FullAuditVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UINavigationControllerDelegate, UIImagePickerControllerDelegate  {
    //MARK:- IBOUTLETS
    @IBOutlet weak var lbl_TotalCount: UILabel!
    @IBOutlet var navViewHeightConstant: NSLayoutConstraint!
    @IBOutlet weak var btn_finishCollection: UIButton!
    @IBOutlet weak var btn_PauseCollection: UIButton!
    @IBOutlet weak var textView_note: UITextView!
    @IBOutlet weak var btn_camera: UIButton!
    @IBOutlet weak var btn_back: UIButton!
    @IBOutlet weak var collView_content: UICollectionView!

    //    MARK:- Variable Declaration
    var totalcount = Int()
    var typeofCleanID = Int()
    var img : UIImage!
    var typeOfCleanArea = String()
    var cellImgArr = [#imageLiteral(resourceName: "icon2"),#imageLiteral(resourceName: "icon2"),#imageLiteral(resourceName: "icon2"),#imageLiteral(resourceName: "icon2"),#imageLiteral(resourceName: "icon2"),#imageLiteral(resourceName: "icon2"),#imageLiteral(resourceName: "icon2"),#imageLiteral(resourceName: "icon2"),#imageLiteral(resourceName: "icon2"),#imageLiteral(resourceName: "icon2"),#imageLiteral(resourceName: "icon2"),#imageLiteral(resourceName: "icon2"),#imageLiteral(resourceName: "icon2"),#imageLiteral(resourceName: "icon2"),#imageLiteral(resourceName: "icon2"),#imageLiteral(resourceName: "icon2"),#imageLiteral(resourceName: "icon2"),#imageLiteral(resourceName: "icon2"),#imageLiteral(resourceName: "icon2"),#imageLiteral(resourceName: "icon2"),#imageLiteral(resourceName: "icon2"),#imageLiteral(resourceName: "icon2"),#imageLiteral(resourceName: "icon2"),#imageLiteral(resourceName: "icon2")]
    var cellTitleArr = ["Bit Hard>5","Bit Hard<5","Bit Soft>5","Bit  Soft<5","Micro Pi","Bot Glass","Bot Plastic","Can Metal","Food Wrapper","Food Cntr","Bags PI","ZipLockBag","Straw","Bot Top PI","Bot Label PI","Coffee Cup","Cup Other","Balloon","Cutlery","Poly/Foam","Candy/Wrap","Butt","Syringe","Nurdles"]
    var isFullAudit = false

    //    MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if DeviceType.iPhoneX {
            navViewHeightConstant.constant = 74.0
        }
        collView_content.delegate = self
        collView_content.dataSource = self
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
    
    //MARK:- BUTTON ACTIONS
    @IBAction func CameraBtnAction(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.allowsEditing = true
        vc.delegate = self
        present(vc, animated: true)
    }

    @IBAction func PauseBtnACtion(_ sender: Any) {
        if btn_PauseCollection.isSelected == true {
            btn_PauseCollection.isSelected = false
            btn_PauseCollection.setTitle("Pause Collection", for: .normal)
        }else {
       btn_PauseCollection.isSelected = true
       btn_PauseCollection.setTitle("Resume Collection", for: .normal)
    }
    }
    @IBAction func finishBtnAction(_ sender: Any) {
    let vc = self.storyboard?.instantiateViewController(withIdentifier: "TimeAndEffortVc") as! TimeAndEffortVc
        vc.cleanId = self.typeofCleanID

    self.navigationController?.pushViewController(vc, animated: true)
//        if textView_note.text == "" {
//        MessageView.show(in: self.view, withMessage: "Please fill the required Notes field")
//        }else {
//            self.finishCollection()
//        }
    }

    @IBAction func BackBtnACtion(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    //MARK:- Custom Methods
    func viewInitialSetup(){
        textView_note.layer.borderColor = TF_BORDER_COLOR.cgColor
        textView_note.layer.borderWidth = 1
        btn_PauseCollection.layer.cornerRadius = (btn_PauseCollection.frame.height)/2
        btn_finishCollection.layer.cornerRadius = (btn_PauseCollection.frame.height)/2

    }
    //    MARK:- CollectionView Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellImgArr.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collView_content.dequeueReusableCell(withReuseIdentifier: "FullAuditCell", for: indexPath) as! FullAuditCell
        cell.img_Content.image = cellImgArr[indexPath.row]
        cell.lbl_title.textAlignment = .center
        cell.lbl_title.text = cellTitleArr[indexPath.row]
        cell.View_cell.backgroundColor = cellBGColor
        cell.View_cell.layer.cornerRadius = 10.0
        cell.View_cell.layer.masksToBounds = true
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collView_content.cellForItem(at: indexPath) as! FullAuditCell
        cell.count += 1
        cell.lbl_Count.text = "\(cell.count)"
        totalcount += 1
        self.lbl_TotalCount.text = "TOTAL: \(totalcount)"
    }
    //MARK: Collection Flow Layout Delegate Mehtods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.view.frame.size.width/4)-15, height: (self.view.frame.size.width/4)+25)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(8.0, 8.0, 8.0, 8.0)
    }
    
    //    MARK:- UIImagePickerDelegates
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true)

    guard let image = info[UIImagePickerControllerEditedImage] as? UIImage else {
            print("No image found")
            return
        }
        print(image.size)
    }
    //    MARK:- WBS METHODS

    func finishCollection(){
        var ItemData = [[String: AnyObject]]()
        var ItemDict = Dictionary<String, String>()
        var finalDict = Dictionary<String,AnyObject >()

        for (index, element) in self.cellTitleArr.enumerated() {
            let cell = self.collView_content.cellForItem(at: IndexPath(row:index,section:0)) as?BpLosCell

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
        let params : [String:String] = ["cleanup_id": "\(typeofCleanID)","note": textView_note.text!,"item_data": itemDataStr]
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



