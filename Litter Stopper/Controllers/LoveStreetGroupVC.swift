//
//  LoveStreetGroupVC.swift
//  Litter Stopper
//
//  Created by Applr on 20/08/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class LoveStreetGroupVC: UIViewController , UITableViewDelegate, UITableViewDataSource{

    //MARK:- IBOutlets
    @IBOutlet weak var img_BgImg: UIImageView!
    @IBOutlet weak var btn_Dismiss: UIButton!
    @IBOutlet var tableview : UITableView!
    @IBOutlet var navViewHeightConstant: NSLayoutConstraint!
    @IBOutlet weak var lbl_title: UILabel!
    //MARK:- Variables
     var countryName = String()
//    var TypeOfCleanBPLOSArr:[String] = ["Beach","River","City","Street"]
    var GroupDataDict = [GroupDataModel]()
    //    MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        if DeviceType.iPhoneX {
            navViewHeightConstant.constant = 74.0
        }
        self.view.bringSubview(toFront: img_BgImg)
        callGetGroupNames()
        lbl_title.textColor = App_Green_Color
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //    MARK:- Button Actions
    @IBAction func DismissBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    //MARK: - UITableview Datasource and Delegate Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GroupDataDict.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "GroupsCell") as! GroupsCell
        let dict = GroupDataDict[indexPath.row]
        cell.lblName.text = dict.name
        cell.lblName.textColor = App_Green_Color
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dict = GroupDataDict[indexPath.row]
        let cell = tableView.cellForRow(at: indexPath) as! GroupsCell
        let vc = storyboard?.instantiateViewController(withIdentifier: "AboutCleanVC") as! AboutCleanVC
        vc.strCleanType = cell.lblName.text!
        vc.strCheckGroup = dict.name
        vc.setCountryName = countryName
//        vc.countryId = dict.countryId
        vc.setStatesname = dict.state
        vc.stateId = dict.stateid
        vc.groupData = dict
        self.navigationController?.pushViewController(vc, animated: true)
    }
    //    MARK:- WBS METHODS
    func callGetGroupNames() {
      let params : [String : Any] = ["organisation_id":2]
        ServerManager.shared.showHud()
        ServerManager.shared.httpPost(request: API_GET_ORGANIZATION_GROUP, params: params, successHandler:
            {(JSON) in
                ServerManager.shared.hidHud()
                print(JSON)
                if JSON["success"].boolValue == true {
                    let groupArr = JSON["groups"].arrayValue
                    self.countryName = JSON["country"].stringValue
                    for dict in groupArr{
                        let GroupData = GroupDataModel.init(GroupDetails: dict)
                        self.GroupDataDict.append(GroupData)
                    }
                    self.tableview.delegate = self
                    self.tableview.dataSource = self
                    self.tableview.reloadData()
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
