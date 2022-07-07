//
//  Config.swift
//
//  Created by SFS04 on 7/6/17.
//  Copyright © 2017 SFS04. All rights reserved.
//

import Foundation

let kAlertTitle  = "Litter Stopper"
let API_BASE_URL  =  "http://litterstopper.com/public/api/"

let API_GET_ALL_ORGANIZATION = API_BASE_URL + "getAllOrganisation"
let API_GET_ORGANIZATION_GROUP = API_BASE_URL + "getOrganisationGroup?organisation_id="
let API_START_CLEANUP = API_BASE_URL + "startCleanUp"
let API_GET_CLEAN_AREA = API_BASE_URL + "getCountryAndCleanArea"
let API_FINISH_COLLECTION = API_BASE_URL + "finishCollection"
let API_FINISH_CLEANUP = API_BASE_URL + "finishCleanup"
let API_ABOUT_PAGES = API_BASE_URL + "aboutPages"
let API_DESCRIPTION = API_BASE_URL + "itemsWithDescription"
let API_GetStates = API_BASE_URL + "getStateList"


//////////////////////////////////////////////////////////
let SEGMENT_COLOR = UIColor(red: 39.0/255.0, green: 217.0/255.0, blue: 135.0/255.0, alpha: 1)
let TAB_BAR_SELECTED_COLOR = UIColor(red: 26.0/255.0, green: 111.0/255.0, blue: 36.0/255.0, alpha: 1)
let BUTTON_COLOR = UIColor(red: 127.0/255.0, green: 188.0/255.0, blue: 144.0/255.0, alpha: 1)
let SILDER_COLOR = UIColor(red: 65.0/255.0, green: 117.0/255.0, blue: 5.0/255.0, alpha: 1)
let LOGIN_GREEN_COLOR = UIColor(red: 30.0/255.0, green: 118.0/255.0, blue: 40.0/255.0, alpha: 1)
let LIGHT_GREEN_COLOR = UIColor(red: 87.0/255.0, green: 125.0/255.0, blue: 94.0/255.0, alpha: 1)
let CLEAR_COLOR = UIColor.clear
let BLACK_COLOR = UIColor.black
let WHITE_COLOR = UIColor.white
let LIGHTGRAY_COLOR = UIColor.lightGray
let DARKGRAY_COLOR = UIColor.darkGray
let GRAY_COLOR = UIColor.gray
let TF_BORDER_COLOR = UIColor(red: 203.0/255.0, green: 208/255.0, blue: 198/255.0, alpha: 1)
let GROUPED_TABLE_COLOR = UIColor.groupTableViewBackground
let RED_COLOR = UIColor(red: 192.0/255.0, green: 21.0/255.0, blue: 52.0/255.0, alpha: 1)
let BLACK_WITH_ALPHA_COLOR = UIColor.black .withAlphaComponent(0.75)
//let LIGHT_GREEN_COLOR = UIColor(red: 205.0/255.0, green: 231.0/255.0, blue: 109.0/255.0, alpha: 1)
let DARK_GREEN_COLOR = UIColor(red: 72.0/255.0, green: 108.0/255.0, blue: 33.0/255.0, alpha: 1)
//Gradient color:   Purple Shade :  133, 107, 251,   Blue Shade: 48, 161,254
let APP_COLOR_PURPLE = UIColor(red: 133.0/255.0, green: 107.0/255.0, blue: 251.0/255.0, alpha: 1)
let APP_COLOR = UIColor(red: 48.0/255.0, green: 161.0/255.0, blue: 254.0/255.0, alpha: 1)
let APP_TEXT_COLOR = UIColor(red: 30.0/255.0, green: 30.0/255.0, blue: 30.0/255.0, alpha: 1)
let APP_THEME_COLOR = UIColor(red: 52.0/255.0, green: 195.0/255.0, blue: 194.0/255.0, alpha: 1)
let APP_BG_COLOR = UIColor(red: 241.0/255.0, green: 241.0/255.0, blue: 241.0/255.0, alpha: 1)
let GRAY_COLOR_WITH_ALPHA = UIColor(red: 220.0/255.0, green: 220.0/255.0, blue: 220.0/255.0, alpha: 1)
let BTN_PurpleColor = UIColor(red: 04.0/255.0, green: 34.0/255.0, blue: 84.0/255.0, alpha: 1)
let cellBGColor = UIColor(red: 0.0/255.0, green: 121.0/255.0, blue: 236.0/255.0, alpha: 1)
let AboutTxtColor = UIColor(red: 16.0/255.0, green: 41.0/255.0, blue: 97.0/255.0, alpha: 1)
let BtnUnselectColor = UIColor(red: 115.0/255.0, green: 127.0/255.0, blue: 155.0/255.0, alpha: 1)
let App_Blue_Color = UIColor(red: 16.0/255.0, green: 41.0/255.0, blue: 97.0/255.0, alpha: 1)
let App_Green_Color = UIColor(red: 67.0/255.0, green: 140.0/255.0, blue: 61.0/255.0, alpha: 1)
let Btn_Blur_GrayColor = UIColor(red: 119.0/255.0, green: 119.0/255.0, blue: 119.0/255.0, alpha: 1)
//MARK: CONSTANT VARIABLES
let kLanguage = "language"
let kDeviceType = "ios"
let kBusinessName = "Business_Name"
let kUserEmail = "user_email"
let kUserMobile = "user_Mobile"
let kUserPassword = "user_Password"
let kChooseRegistrationType = "Registration_type"
let kStoreAddress = "store_address"
let kQRCodeID = "store_address"
let kStoreLat = "store_lat"
let kStoreLon = "store_lon"
let kDeviceToken = "DeviceToken"
let kUserID = "userID"
let kIsLogin = "isLogin"
let kauthToken = "authentication_token"
let kUserName = "UserName"
let kCurrentUser = "currnetUser"
let kBankStatus = "bankstatus"
let itemData = "itemData"
let kpropertyType = "propertyType"
let kCartItems = "cartItems"
let kNotificationStatus = "notification_status"

let kUserData = "user_data"
let kIsCustomer = "is_customer"
let kZipCode = "ZipCode"
let kDryCleanerID = "defaultDryCleaner"
let kIsFavourites = "isFavourites"
let kAuthToken = "authentication_token"




//var loggedInUser: User!

let kGooglePlaceApiKey = "AIzaSyCb1TyOPFa37Gl1H-3zH49DH4S9dUV1ld0"
let kUsernameValidation = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ "
let kZipCodeValidation = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ0123456789"
let kEmailAcceptableCharacter = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_.@-"


let kPasswordMaxLength = 20
let kUserNameMaxLength = 40
let kAgeMaxLength = 3
let kZipCodeMaxLenght = 10
let kCityMaxLength = 30
let kSubjectMaxLength = 80
let kAddressNoteMaxLength = 80
var kWalkThroughRead = "WalkThroughRead"
var strCityName: String!
var strZipCode: String!
var isFindParternScreen: Bool = false
var isFavouritesRefersh: Bool = false

enum SearchControllerType : Int {
    case SC_Add = 0
    case SC_Search =  1
    case SC_None
}
var isWalkThroughRead:Bool{
    get{
        return UserDefaults.SFSDefault(boolForKey: kWalkThroughRead)
    }
    set{
       return UserDefaults.SFSDefault(setBool: newValue, forKey: kWalkThroughRead)
    }
}
///////////////////////////////////////// For Alert Message

let USER_NAME                = "Please enter User name"
let USER_FULL_NAME           = "Please enter Name"
let USER_FIRST_NAME          = "Enter Firstname"
let USER_LAST_NAME           = "Enter Lastname"
let PHONE_NUMBER             = "Please enter phone number"
let SUBJECT                  = "Please enter Subject"
let CODE                     = "Code"
let VALID_MOBILE_NUMBER      = "Please enter valid Phone number"
let DIALLING_CODE            = "Please enter country dialling code"
let EMAIL                    = "Please enter email address"
let BUSINESS_NAME            = "Please enter Business Name"
let CURRENT_PASSWORD         = "Please enter current password"
let PASSWORD                 = "Please enter password"
let VALID_PASSWORD           = "Please enter valid password"
let CONFIRM_PASS             = "Please enter confirm password"
let VALID_EMAIL              = "Please enter valid email"
let PASSWORD_MIS_MATCH       = "Password did not match"//"Password and Confirm  Password doesn't match"
let VALID_PASS               = "Password should be Atleast 6 Digit"
let USER_IMAGE               = "Please upload image"
let EnterCardNo              = "Enter Card Number"
let ExpirationDate           = "Enter ExpirationDate"
let Cvv                      = "Enter CVV"
let INVALID_CARDNUMBER       = "Enter Valid CardNumber"
let INVALID_CVV              = "Enter Valid CVV"
let INVALID_DATE             = "Enter valid Date"
let DESCRIPTION              = "Enter Description"
let AMOUNT                   = "Enter Amount"
let MESSAGE                  = "Enter Message"

// MARK: Declaration for string constants to be used to notification.
public struct NotificationKeys {
    static let Refersh_EarningVC = "refershEarningVC"
    static let Refersh_Orders = "refershOrdersVC"
//    static let Refersh_SearchVC_Users = "refershSearchVCUsers"
//    static let Refersh_DiscoverVC = "refershDiscoverVC"
//    static let Refersh_WorkoutVC = "refershWorkoutVC"
//    static let Refersh_MyGymVC = "refershMyGymVC"
//    static let Move_To_Notification_Detail = "moveToNotificationDetails"
//    static let Move_To_Message_Detail = "moveToMessageDetails"
//    static let Refersh_YouVC = "refershFeedVC"
}

//MARK:- EMAIL VALIDATION
func IS_VALID_EMAIL(emailId:String) -> Bool {
    let emailRegEx = "[a-zA-Z0-9._%+-]+@[A-Za-z0-9.-]+\\.+[a-z]+"
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: emailId)
}
