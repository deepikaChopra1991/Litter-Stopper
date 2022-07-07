//
//  PartialAuditVC.swift
//  Litter Stopper
//
//  Created by Apple01 on 9/6/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class PartialAuditVC: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    //MARK:- IBOUTLETS
     @IBOutlet var navViewHeightConstant: NSLayoutConstraint!
    @IBOutlet weak var btn_Camera: UIButton!
    @IBOutlet weak var btn_Next: UIButton!
    @IBOutlet weak var colview_Content: UICollectionView!
    @IBOutlet weak var btn_back: UIButton!
    //MARK:- Variable Declarations
       var cellImgArr = [#imageLiteral(resourceName: "bottle_glass"),#imageLiteral(resourceName: "plastic_bottle"),#imageLiteral(resourceName: "canmetal"),#imageLiteral(resourceName: "syrings"),#imageLiteral(resourceName: "h_smaller"),#imageLiteral(resourceName: "h_greater"),#imageLiteral(resourceName: "s_smaller"),#imageLiteral(resourceName: "s_greater"),#imageLiteral(resourceName: "micro"),#imageLiteral(resourceName: "wrap"),#imageLiteral(resourceName: "food_container"),#imageLiteral(resourceName: "bags-plastic"),#imageLiteral(resourceName: "bag-ziplock"),#imageLiteral(resourceName: "straw"),#imageLiteral(resourceName: "top_plastic"),#imageLiteral(resourceName: "label"),#imageLiteral(resourceName: "coffee-cup"),#imageLiteral(resourceName: "cup_other"),#imageLiteral(resourceName: "balloon"),#imageLiteral(resourceName: "cutlery"),#imageLiteral(resourceName: "foam"),#imageLiteral(resourceName: "fish"),#imageLiteral(resourceName: "cigarettebutt"),#imageLiteral(resourceName: "nurdles")]
    var selectedImg = #imageLiteral(resourceName: "selection_tick")
    var totalcount = Int()
    var typeofCleanID = Int()
    var typeOfCleanArea = String()
    var selectedItemsArr = [Int]()
    var withoutTimerStr = Int()
     var cellTitleArr = ["Bot Gl","Bot Pl","Can Met","Syringe","Bit H","Bit H","Frag  S","Frag S","Micro Pl","Food Wr","Food Ct","Bag Pl","Zip L","Straw","Bot Top","Bot Lab","Cup Cof","Cup Oth","Balloon","Cutlery","PolyS","Fish L","Butt","Nurdles"]
    var isFullAudit = false

    //MARK:- View Methods
     override func viewDidLoad() {
        super.viewDidLoad()
        if DeviceType.iPhoneX {
            navViewHeightConstant.constant = 74.0
        }
        colview_Content.delegate = self
        colview_Content.dataSource = self
        btn_Camera.isHidden = true
        btn_Next.layer.cornerRadius = (btn_Next.frame.height)/2
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //MARK:- Button Actions
    @IBAction func BackBtnAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func CamerabtnAction(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.allowsEditing = true
        vc.delegate = self
        present(vc, animated: true)
    }

    @IBAction func NextBtnAction(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "PartialAuditDetailVC") as! PartialAuditDetailVC
        vc.isFullAudit = self.isFullAudit
        vc.typeofCleanID = self.typeofCleanID
        vc.selectedArr = self.selectedItemsArr
        vc.withoutTimerStr = self.withoutTimerStr
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK:- Collection view Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellImgArr.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = colview_Content.dequeueReusableCell(withReuseIdentifier: "PartialAuditCell", for: indexPath) as! PartialAuditCell

        cell.img_Content.image = cellImgArr[indexPath.row]
        cell.img_selectedImg.isHidden = true
        cell.img_selectedImg.image = selectedImg
        cell.lbl_title.textAlignment = .center
        cell.lbl_title.text = cellTitleArr[indexPath.row]
        cell.View_cell.backgroundColor = cellBGColor
        cell.View_cell.layer.cornerRadius = 10.0
        cell.View_cell.layer.masksToBounds = true
        cell.lbl_Count.isHidden = true
          if self.selectedItemsArr.contains(indexPath.row) {
            cell.img_selectedImg.isHidden = false
        }
        return cell
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! PartialAuditCell
        cell.View_cell.backgroundColor = App_Blue_Color
        UIView.animate(withDuration: 0.1, delay: 0.0, options: [], animations: {
            cell.View_cell.backgroundColor = cellBGColor

        }, completion: { (finished: Bool) in

        })
        cell.img_selectedImg.isHidden = false
        if self.selectedItemsArr.contains(indexPath.row) {
            if let index = self.selectedItemsArr.index(of: indexPath.row) {
                self.selectedItemsArr.remove(at: index)
            }
        }else{

            self.selectedItemsArr.append(indexPath.row)
        }
        print(selectedItemsArr)
        colview_Content.reloadData()
    }
  
    //MARK: Collection Flow Layout Delegate Mehtods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.view.frame.size.width/4)-15, height: (self.view.frame.size.width/4)+10)
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
}
