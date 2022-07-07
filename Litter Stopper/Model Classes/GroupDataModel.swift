//
//  GroupDataModel.swift
//  Litter Stopper
//
//  Created by Apple01 on 9/11/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import SwiftyJSON

class GroupDataModel: NSObject {
    var organizationId = Int()
    var name = String()
    var status = String()
    var groupid = Int()
    var email = String()
    var countryId = Int()
    var postCode = String()
    var state = String()
    var stateid = Int()
    
    override init() {
        
    }
    init(GroupDetails: JSON) {
        
        self.organizationId = GroupDetails["organisation_id"].intValue
        self.name = GroupDetails["name"].stringValue
        self.status = GroupDetails["status"].stringValue
        self.groupid = GroupDetails["id"].intValue
        self.email = GroupDetails["email"].stringValue
        self.countryId = GroupDetails["country_id"].intValue
        self.state = GroupDetails["state"].stringValue
        self.stateid = GroupDetails["state_id"].intValue
        self.postCode = GroupDetails["post_code"].stringValue
    }
}

class TypeOfCleanAreaModel: NSObject{
    var areaType = String()
    
    override init() {
        
    }
    init(CleanAreaDetails: JSON){
        self.areaType = CleanAreaDetails["area_type"].stringValue
        
    }
}
class CountryModel: NSObject{
    var countryName = String()
    var cID = Int()
    
    override init() {
        
    }
    init(CountryDetails: JSON){
        self.countryName = CountryDetails["name"].stringValue
        self.cID = CountryDetails["id"].intValue
    }
}
class StatesDataModel: NSObject {
    
    var statename = String()
    var stateIDD = Int()
    
    override init() {
    }
    init(StatesDetails: JSON) {
        
        self.statename = StatesDetails["name"].stringValue
        self.stateIDD = StatesDetails["id"].intValue
    }
}
class TypeOfCleanModel: NSObject{
    var typeOfClean = String()
    override init() {
        
    }
    init(TypeOfCleanDetails: JSON){
        
        self.typeOfClean = TypeOfCleanDetails["name"].stringValue
    }
}


class OrgDataModel: NSObject {
    var orgId = Int()
    var OrgName = String()
    var CountryId = Int()
    
    override init() {
        
    }
    init(OrgDetails: JSON) {
        self.orgId = OrgDetails["id"].intValue
        self.OrgName = OrgDetails["name"].stringValue
        self.CountryId = OrgDetails["country_id"].intValue
    }
}

class CleanUpModel: NSObject {
    
    var groupId = Int()
    var countryId = Int()
    var cleanDate = String()
    var location = String()
    var startTimerTimeStamp = Int()
    var typeOfCleanArea = String()
    var groupName = String()
    var typeofCleanId = Int()
    
    override init() {
        
    }
    init(cleanupDetails: JSON) {
        self.groupId = cleanupDetails["group_id"].intValue
        self.cleanDate = cleanupDetails["clean_date"].stringValue
        self.location = cleanupDetails["location"].stringValue
        self.startTimerTimeStamp = cleanupDetails["timer_start_timestamp"].intValue
        self.typeOfCleanArea = cleanupDetails["type_of_clean_area"].stringValue
        self.groupName = cleanupDetails["group_name"].stringValue
        self.typeofCleanId = cleanupDetails["type_of_clean_id"].intValue
        
    }
}
class PagesDataModel: NSObject {
    var strKey = String()
    var strvalue = String()
    
    override init() {
        
    }
    init(PagesDetails: JSON) {
        self.strKey = PagesDetails["key"].stringValue
        self.strvalue = PagesDetails["value"].stringValue
    }
}
class ItemDetailDataModel: NSObject {
    var desc = String()
    var name = String()
    override init() {
        
    }
    init(ItemDetails: JSON) {
        self.desc = ItemDetails["description"].stringValue
        self.name = ItemDetails["name"].stringValue
    }
}

class aboutCleanModel : NSObject ,NSCoding {
    
    var location = String()
    var groupID = Int()
    var countryID = Int()
    var cleanDate = String()
    var startCurrentTime = String()
    var typeOfCleanArea = String()
    var groupName = String()
    //    var cleanID = String()
    var emailOtherOrg = String()
    var stateID = String()
    
    override init() {
        
    }
    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
        
        if let location = aDecoder.decodeObject(forKey: "location") as? String {
            self.location = location
        }
        if let groupID = aDecoder.decodeObject(forKey: "groupID") as? Int {
            self.groupID = groupID
        }
        if let countryID = aDecoder.decodeObject(forKey: "countryID") as? Int {
            self.countryID = countryID
        }
        if let cleanDate = aDecoder.decodeObject(forKey: "cleanDate") as? String {
            self.cleanDate = cleanDate
        }
        if let startCurrentTime = aDecoder.decodeObject(forKey: "startCurrentTime") as? String {
            self.startCurrentTime = startCurrentTime
        }
        if let typeOfCleanArea = aDecoder.decodeObject(forKey: "typeOfCleanArea") as? String {
            self.typeOfCleanArea = typeOfCleanArea
        }
        if let groupName = aDecoder.decodeObject(forKey: "groupName") as? String {
            self.groupName = groupName
        }
        if let typeOfCleanArea = aDecoder.decodeObject(forKey: "typeOfCleanArea") as? String {
            self.typeOfCleanArea = typeOfCleanArea
        }
        if let emailOtherOrg = aDecoder.decodeObject(forKey: "emailOtherOrg") as? String {
            self.emailOtherOrg = emailOtherOrg
        }
        if let stateID = aDecoder.decodeObject(forKey: "stateID") as? String {
            self.stateID = stateID
        }
    }
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.location , forKey: "location")
        aCoder.encode(self.groupID , forKey: "groupID")
        aCoder.encode(self.countryID , forKey: "countryID")
        aCoder.encode(self.cleanDate , forKey: "cleanDate")
        aCoder.encode(self.startCurrentTime , forKey: "startCurrentTime")
        aCoder.encode(self.typeOfCleanArea , forKey: "typeOfCleanArea")
        aCoder.encode(self.groupName , forKey: "groupName")
        aCoder.encode(self.emailOtherOrg , forKey: "emailOtherOrg")
        aCoder.encode(self.stateID , forKey: "stateID")
        
    }
}

class SaveItemDetailsModel : NSObject {

    var cleanupID = String()
    var notes = String()
   var dictItemCountDetail = [[String:String]]()
    var totalCount = String()
 
    override init() {

    }
}
class SaveItemFullAuditCleanModel : NSObject {
    
    var cleanupID = String()
    var notes = String()
    var dictItemFullAuditCount = [[String:String]]()
    var totalCount = String()
    
    override init() {
        
    }
}
class SaveItempartialAuditCleanModel : NSObject {
    
    var cleanupID = String()
    var notes = String()
    var dictItemCountDetail = [[String:String]]()
    var totalCount = String()
    
    override init() {
        
    }
}

    class SaveTimeAndEffortContentModel: NSObject{
        var cleanID = String()
        var duration = String()
        var totalsec = Int()
        var numberofbags = String()
        var numberofppl = String()
        var kg = String()
        var lengthcleaned = String()
        var widthcleaned = String()
        var optionalmail = String()
        var otherdetails = String()
        var timerstatus = String()
        
        override init() {
            
        }
}


