//
//  OrganizationNameModel.swift
//  Litter Stopper
//
//  Created by Apple01 on 9/11/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class GroupModel: NSObject {

    var name = String()
    var status = String()
    var id = Int()
    var

    override init() {

    }
    init(OrganizationDetails:JSON) {
        self.itemName = OrderDetails["product_name"].stringValue
        self.ItemPrice = OrderDetails["price"].stringValue
        self.Description = OrderDetails["description"].stringValue
        self
}
