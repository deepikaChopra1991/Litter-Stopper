    //
    //  LoginVC.swift
    //  WiiBeast
    //
    //  Created by sfs17 on 3/6/17.
    //  Copyright © 2017 sfs17. All rights reserved.
    //
    
    import UIKit
    
    class AppManager: NSObject  {
        //        //MARK: - singleton -
        //        class var sharedInstance:AppManager {
        //            struct Singleton {
        //                static let instance = AppManager()
        //            }
        //            return Singleton.instance
        //        }
        
        
        //MARK: - subview -
        class func setSubViewlayout(_ subView: UIView , mainView : UIView){
            subView.translatesAutoresizingMaskIntoConstraints = false
            mainView.addConstraint(NSLayoutConstraint(item: subView, attribute: .top, relatedBy: .equal, toItem: mainView, attribute: .top, multiplier: 1.0, constant: 0.0))
            
            mainView.addConstraint(NSLayoutConstraint(item: subView, attribute: .leading, relatedBy: .equal, toItem: mainView, attribute: .leading, multiplier: 1.0, constant: 0.0))
            
            mainView.addConstraint(NSLayoutConstraint(item: subView, attribute: .bottom, relatedBy: .equal, toItem: mainView, attribute: .bottom, multiplier: 1.0, constant: 0.0))
            
            mainView.addConstraint(NSLayoutConstraint(item: subView, attribute: .trailing, relatedBy: .equal, toItem: mainView, attribute: .trailing, multiplier: 1.0, constant: 0.0))
        }
        
        //MARK:- Getting Response Data
        class func getObjectValueForKeyClass(keyName:String) -> Any {
            return UserDefaults.standard.object(forKey: keyName) as Any
            
        }
        class func getUserData() -> [String:Any] {
            if let userData = AppManager.getObjectValueForKeyClass(keyName:kUserData) as? [String:Any] {
                return userData
            }else{
                return ["":""]
            }
        }
        
        class func getName() -> String {
            if let userData = AppManager.getObjectValueForKeyClass(keyName:kUserData) as? [String:Any] {
                return (userData["username"] as! String)
            }else{
                return ""
            }
        }
        
        class func getEmail() -> String {
            if let userData = AppManager.getObjectValueForKeyClass(keyName:kUserData) as? [String:Any] {
                return (userData["email"] as? String ?? "")
            }else{
                return ""
            }
        }
        class func getPhoneNumber() -> String {
            if let userData = AppManager.getObjectValueForKeyClass(keyName:kUserData) as? [String:Any] {
                return (userData["phonenumber"] as! String)
            }else{
                return ""
            }
        }
        
        
        class func getProfilePic() -> String {
            if let userData = AppManager.getObjectValueForKeyClass(keyName:kUserData) as? [String:Any] {
                return (userData["profile_pic"] as! String)
            }else{
                return ""
            }
        }
        
        class func isFbLogin() -> Bool {
            if let userData = AppManager.getObjectValueForKeyClass(keyName:kUserData) as? [String:Any] {
                return  (userData["fb_id"] as! String) != "" ? true : false
            }else{
                return false
            }
        }
        
        class func getUserID() -> String {
            if let userData = AppManager.getObjectValueForKeyClass(keyName:kUserData) as? [String:Any] {
                return userData["id"] as! String
            }else{
                return ""
            }
        }
        
        class func getRefralCode() -> String {
            if let userData = AppManager.getObjectValueForKeyClass(keyName:kUserData) as? [String:Any] {
                return userData["refarel_code"] as! String
            }else{
                return ""
            }
        }
        
        class func getAuthToken() -> String {
            if let userData = AppManager.getObjectValueForKeyClass(keyName:kUserData) as? [String:Any] {
                return (userData["auth_token"]) as! String
            }else{
                return ""
            }
        }
        
        class func getEmailAddress() -> String {
            if let userData = AppManager.getObjectValueForKeyClass(keyName:kUserData) as? [String:Any] {
                return userData["email"] as! String
            }else{
                return ""
            }
        }
        
        
        
        //MARK: - email validaton -
        class  func isValidEmail(_ testStr:String) -> Bool {
            print("validate calendar: \(testStr)")
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
            
            let emailTest=NSPredicate(format: "SELF MATCHES %@", emailRegEx);
            if  emailTest.evaluate(with: testStr){
                return true
            }
            return false
        }
        //MARK: - phone number validation -
        class  func validPhoneNumber(_ value: String) -> Bool{
            //            let PHONE_REGEX = "^\\d{3}-\\d{3}-\\d{4}$"
            //            let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
            //            if phoneTest.evaluate(with: value) {
            //                return true
            //            }
            if (value.count >= 8 && value.count <= 12) {
                return true
            }
            return false
        }
        //MARK: - set shadow -
        
        class func setShadowEffect(containerView item:UIView,shadowOffset offset:CGSize,shadowOpacity opacity: Float,shadowRadius radius:CGFloat){
            item.layer.shadowColor =  UIColor.darkGray.cgColor
            item.layer.shadowOffset =  offset
            item.layer.shadowOpacity=opacity
            item.layer.shadowRadius = radius
            item.layer.masksToBounds = true
            item.clipsToBounds = true
        }
        //MARK: - image with image -
        
        class func imageWithImage(_ image:UIImage ,scaledToSize newSize:CGSize) -> UIImage{
            UIGraphicsBeginImageContext( newSize )
            image.draw(in: CGRect(x: 0, y: 0, width: newSize.width,height: newSize.height))
            let newImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext();
            return newImage
        }
        //MARK: - height from string -
        class func calculateHeightForString(_ inString:String,newWidth:CGFloat, font : UIFont) -> CGFloat{
            let messageString = inString
            let attributes = [NSAttributedStringKey.font:font]
            let attrString:NSAttributedString? = NSAttributedString(string: messageString, attributes: attributes )
            let rect:CGRect = attrString!.boundingRect(with: CGSize(width: newWidth,height: CGFloat.greatestFiniteMagnitude), options: NSStringDrawingOptions.usesLineFragmentOrigin, context:nil )//hear u will get nearer height not the exact value
            let requredSize:CGRect = rect
            return requredSize.height  //to include button's in your tableview
            
        }
        //MARK: - date from string -
        
        class func getDateToString(datepicker currentdate :Date )->String{
            let dateformatter = DateFormatter()
            dateformatter.dateStyle = DateFormatter.Style.medium
            dateformatter.dateFormat="dd-MMM-yyyy"
            let dateInStringFormated=dateformatter.string(from: currentdate)
            return dateInStringFormated
        }
        
        class func getFormatedDate(dateString : String) -> String{
            let dateformatter = DateFormatter()
            dateformatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let date  = dateformatter.date(from: dateString)! as Date
            
            let dateformatter1 = DateFormatter()
            dateformatter1.dateFormat = "hh:mm a dd MMMM, yyyy"
            let strDate  = dateformatter1.string(from: date) as String
            return strDate
        }
        
        //MARK: - error message -
        
        class func getErrorMessage(_ error : NSError) -> String {
            var errorMessage: NSString = NSString()
            switch error.code {
            case -998:
                errorMessage = "Unknow Error";
                break;
            case -1000:
                errorMessage = "Bad URL request";
                break;
            case -1001:
                errorMessage = "The request time out";
                break;
            case -1002:
                errorMessage = "Unsupported URL";
                break;
            case -1003:
                errorMessage = "The host could not be found";
                break;
            case -1004:
                errorMessage = "The host could not be connect, Please try after some time";
                break;
            case -1005:
                errorMessage = "The network connection lost, Please try agian";
                break;
            case -1009:
                errorMessage = "The internet connection appear to be  offline";
                break;
            case -1103:
                errorMessage = "Data lenght exceed to maximum defined data";
                break;
            case -1100:
                errorMessage = "File does not exist";
                break;
            case -1013:
                errorMessage = "User authentication required";
                break;
            case -2102:
                errorMessage = "The request time out";
                break;
            default:
                errorMessage = "Server Error";
                break;
            }
            return errorMessage as String
        }
        class func showErrorDialog(viewControler : UIViewController , message : String) {
            _ = UIAlertController.showAlertInViewController(viewController: viewControler, withTitle: nil, message: message, cancelButtonTitle: NSLocalizedString("OK", comment: ""), destructiveButtonTitle: nil, otherButtonTitles: nil) { (controller, action , buttonIndex) in
                
            }
            
        }
        /*func DictionaryRemovingNulls( aDictionary param:[String:Any]) ->[String:Any]{
         var mutableRawData:[String:Any] = [String: Any]()
         for key in param.keys{
         if  let value:Any  = param[key] {
         mutableRawData = [key:"\(value)"]
         }else{
         mutableRawData = [key:""]
         }}
         return mutableRawData
         }
         */
        
        //MARK: - resize image -
        class func resizeImage(image : UIImage , targetSize : CGSize) -> UIImage{
            let originalSize:CGSize =  image.size
            let widthRatio :CGFloat = targetSize.width/originalSize.width
            let heightRatio :CGFloat = targetSize.height/originalSize.height
            var newSize : CGSize!
            if widthRatio > heightRatio {
                newSize =  CGSize(width : originalSize.width*heightRatio ,  height : originalSize.height * heightRatio)
            }
            else{
                newSize = CGSize(width : originalSize.width * widthRatio , height : originalSize.height*widthRatio)
            }
            // preparing rect for new image
            let rect:CGRect =  CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
            UIGraphicsBeginImageContextWithOptions(newSize, false, UIScreen.main.scale)
            image .draw(in: rect)
            let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            return newImage
        }
        //MARK: - convert string to float -
        class func convertStringToFloat(value : String) -> CGFloat {
            if let n = NumberFormatter().number(from: value) {
                let f = CGFloat(truncating: n)
                return f
            }else{
                return 0.0
            }
        }
        class func calculateHeight(_ width: CGFloat , _ height: CGFloat , _ scaleWidth: CGFloat) -> CGFloat {
            let newHeight : CGFloat = (( height  / width ) * scaleWidth)
            return newHeight
        }
        class func resizeImageWithImage (sourceImage:UIImage, scaledToWidth: CGFloat) -> UIImage {
            let oldWidth = sourceImage.size.width
            let scaleFactor = scaledToWidth / oldWidth
            let newHeight = sourceImage.size.height * scaleFactor
            let newWidth = oldWidth * scaleFactor
            UIGraphicsBeginImageContext(CGSize(width:newWidth, height:newHeight))
            sourceImage.draw(in: CGRect(x:0, y:0, width:newWidth, height:newHeight))
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return newImage!
        }
        class func convertStringBeforeSending(text : String) -> String{
            let data: Data = text.data(using: .nonLossyASCII)!
            let strs: String = String(data: data as Data, encoding: .utf8)!
            return strs
        }
        class func convertStringAfterRecieving(text : String) -> String{
            let data: Data = text.data(using: .utf8)!
            let strs: String = String(data: data as Data, encoding: .nonLossyASCII)!
            return strs
        }
        class func daynameFromID(dayID : Int) -> String {
            switch dayID {
            case 1:
                return "Sunday"
            case 2:
                return "Monday"
            case 3:
                return "Tuesday"
            case 4:
                return "Wednessday"
            case 5:
                return "Thursday"
            case 6:
                return "Friday"
            case 7:
                return "Saturday"
            default:
                return ""
            }
        }
        class func convertTimeStampToDate(timeStamp : Double) -> String {
            let timeInterval: TimeInterval = TimeInterval.init(timeStamp)
            let date = NSDate(timeIntervalSince1970: timeInterval)
            let currentData = Date()
            
            let currnet_formatter = DateFormatter()
            currnet_formatter.dateFormat = "dd.MM.yyyy"
            let strDate1 =  currnet_formatter.string(from: date as Date)
            let strDate2 =  currnet_formatter.string(from: currentData)
            if strDate1 == strDate2{
                //Convert time in UTC to Local TimeZone
                let outputTimeZone = NSTimeZone.local
                let outputDateFormatter = DateFormatter()
                outputDateFormatter.timeZone = outputTimeZone
                
                outputDateFormatter.timeStyle = .short
                outputDateFormatter.dateStyle = .none
                outputDateFormatter.doesRelativeDateFormatting = false
                //outputDateFormatter.dateFormat = dateFormat
                let outputString = outputDateFormatter.string(from: date as Date)
                return outputString
            }else{
                let formatter = DateFormatter()
                let outputTimeZone = NSTimeZone.local
                formatter.timeZone = outputTimeZone
                formatter.timeStyle = .none
                formatter.dateStyle = .short
                formatter.doesRelativeDateFormatting = true
                return formatter.string(from: date as Date)
            }
        }
        class func checkMaxLength(textField: UITextField!, maxLength: Int , range : NSRange) -> Bool {
            if (textField.text?.count)! >= maxLength && range.length == 0 {
                return false
            }else {
                return true
            }
        }
        class func compairTwoTimes(startTime: String , endTime: String) ->Bool {
            var startTimeArray = startTime.components(separatedBy: ":")
            let startHours: String = startTimeArray[0]
            let startMinutes: String = startTimeArray[1]
            var endTimeArray = endTime.components(separatedBy: ":")
            let endHours: String = endTimeArray[0]
            let endMinutes: String = endTimeArray[1]
            if Int(startHours)! < Int(endHours)! {
                return true
            }
            else if Int(startHours)! == Int(endHours)! {
                if Int(startMinutes)! == Int(endMinutes)!{
                    return false
                }else if Int(startMinutes)! < Int(endMinutes)!{
                    return true
                }
                else{
                    return false
                }
            }else{
                return false
            }
        }
        //MARK: - SetRGB -
        class func m_setRGB(red:CGFloat, green:CGFloat, blue:CGFloat) -> UIColor{
            return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0)
        }
        //MARK: - Corner Radius/Border TO TEXT FIELD -
        class func setBorderOnTextField(textField: UITextField,with radius:CGFloat) -> Void {
            textField.layer.cornerRadius = radius
            textField.layer.borderWidth = 1.5
            textField.layer.borderColor = UIColor.init(red: 0.66, green: 0.66, blue: 0.66, alpha: 1.0).cgColor
        }
        //MARK: - Corner Radius/Border TO TEXT VIEW -
        class func setBorderOnTextView(textView: UITextView,with radius:CGFloat) -> Void {
            textView.layer.cornerRadius = radius
            textView.layer.borderWidth = 1.5
            textView.layer.borderColor = UIColor.init(red: 0.66, green: 0.66, blue: 0.66, alpha: 1.0).cgColor
        }
        //MARK: - PADDING TO TEXT FIELD -
        class func setLeftViewOnTextField(textField: UITextField) -> Void {
            let paddingView = UIView.init(frame: CGRect.init(x: 0.0, y: 0.0, width: 10.0, height: 20.0))
            textField.leftView = paddingView
            textField.leftViewMode = UITextFieldViewMode.always
        }
        class func setLeftImageViewOnTextField(textField: UITextField, WithImage imageName:UIImage) -> Void {
            let paddingView = UIView.init(frame: CGRect.init(x: 0.0, y: 0.0, width: 50.0, height: textField.frame.size.height))
            let paddingImage = UIImageView(frame: CGRect(x: 14, y: 14, width: textField.frame.size.height-28, height: textField.frame.size.height-28))
            paddingImage.image = imageName
            paddingImage.contentMode = UIViewContentMode.scaleAspectFit
            paddingView.addSubview(paddingImage)
            textField.leftView = paddingView
            textField.leftViewMode = UITextFieldViewMode.always
        }
        class func setRightImageViewOnTextField(textField: UITextField, WithImage imageName:UIImage) -> Void {
            let paddingView = UIView.init(frame: CGRect.init(x: 0.0, y: 0.0, width: 50.0, height: textField.frame.size.height))
            let paddingImage = UIImageView(frame: CGRect(x: 5, y: 5, width: textField.frame.size.height-10, height: textField.frame.size.height-10))
            paddingImage.image = imageName
            paddingImage.contentMode = UIViewContentMode.scaleAspectFit
            paddingView.addSubview(paddingImage)
            textField.rightView = paddingView
            textField.rightViewMode = UITextFieldViewMode.always
        }
        //MARK: - give shadow and corner radius to view -
        class func m_ShadowWithView(view:UIView, WithCornerRadius radius:CGFloat){
            //view.clipsToBounds = true
            view.layer.cornerRadius = radius
            view.layer.shadowOffset = CGSize(width: 0, height: 0)
            view.layer.shadowRadius = 3
            view.layer.shadowOpacity = 0.2
        }
        class func m_BorderWithcolor(view:UIView, WithColor color:UIColor){
            view.layer.borderWidth = 1.0
            view.layer.borderColor = color.cgColor;
            view.layer.masksToBounds = false
        }
        class func m_MakeCallToNumber(number:NSString){
            guard let number = URL(string: "telprompt://\(number)") else { return }
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(number)
            } else {
                UIApplication.shared.openURL(number)
            }
        }
        
        class  func shakeTextField(textField: UITextField, withText:String, currentText:String) -> Void {
            textField.text = ""
            textField.attributedPlaceholder = NSAttributedString(string: currentText,
                                                                 attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
            let isSecured = textField.isSecureTextEntry
            let animation = CABasicAnimation(keyPath: "position")
            animation.duration = 0.10
            animation.repeatCount = 2
            animation.autoreverses = true
            animation.fromValue = NSValue(cgPoint:CGPoint.init(x: textField.center.x - 10, y: textField.center.y) )
            animation.toValue = NSValue(cgPoint: CGPoint.init(x: textField.center.x + 10, y: textField.center.y) )
            textField.layer.add(animation, forKey: "position")
            if isSecured {
                textField.isSecureTextEntry = false
            }
            textField.attributedPlaceholder = NSAttributedString(string: withText,
                                                                 attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
                textField.attributedPlaceholder = NSAttributedString(string: currentText,
                                                                     attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
                //  textField.placeholder = placeholder
                if isSecured {
                    textField.isSecureTextEntry = true
                }
            }
            
        }
        
        class  func shakeTextView(textView: UITextView, withText:String, currentText:String) -> Void {
            //            textView.text = NSAttributedString(string: currentText,
            //                                                                 attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
            let isSecured = textView.isSecureTextEntry
            let animation = CABasicAnimation(keyPath: "position")
            animation.duration = 0.10
            animation.repeatCount = 2
            animation.autoreverses = true
            animation.fromValue = NSValue(cgPoint:CGPoint.init(x: textView.center.x - 10, y: textView.center.y) )
            animation.toValue = NSValue(cgPoint: CGPoint.init(x: textView.center.x + 10, y: textView.center.y) )
            textView.layer.add(animation, forKey: "position")
            if isSecured {
                textView.isSecureTextEntry = false
            }
            //            textView.attributedPlaceholder = NSAttributedString(string: withText,
            //                                                                 attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
                textView.text = withText
                //                    NSAttributedString(string: currentText,attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
                //  textField.placeholder = placeholder
                if isSecured {
                    textView.isSecureTextEntry = true
                }
            }
            
        }
        class func toCheckAlphaOrNumeric(string: String) -> Bool {
            let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
            let compSepByCharInSet = string.components(separatedBy: aSet)
            let numberFiltered = compSepByCharInSet.joined(separator: "")
            return string == numberFiltered
        }
        
        class func showErrorMessage(errorMessage: String , controller: UIViewController){
            _ = UIAlertController.showAlertInViewController(viewController: controller, withTitle: "Error", message: errorMessage, cancelButtonTitle: "Ok", destructiveButtonTitle: nil, otherButtonTitles: nil, tapBlock: { (controller, action, buttonIndex) in
                
            })
        }
//        ABOUT CLEAN VC
        class func saveData1(model1: aboutCleanModel) {
            
            let modelData1 = NSKeyedArchiver.archivedData(withRootObject: model1)
            UserDefaults.standard.set(modelData1, forKey: kCurrentUser)
            UserDefaults.standard.synchronize()
        }
        
        class func getSavedData1() {
    
            if let content = UserDefaults.standard.object(forKey: kCurrentUser) as? Data {
                if let savedData = NSKeyedUnarchiver.unarchiveObject(with: content) as? aboutCleanModel {
                    AppDelegate.sharedDelegate.passDetailsModel1 = aboutCleanModel.init()
                     AppDelegate.sharedDelegate.passDetailsModel1 = savedData
                }
            }
        }
       
//  ITEM DETAILS
        class func saveData2(model2: SaveItemDetailsModel) {
            
            let modelData2 = NSKeyedArchiver.archivedData(withRootObject: model2)
            UserDefaults.standard.set(modelData2, forKey: itemData)
            UserDefaults.standard.synchronize()
        }
        
        class func getSavedData2() {
            
            if let content = UserDefaults.standard.object(forKey: itemData) as? Data {
                if let savedItemData = NSKeyedUnarchiver.unarchiveObject(with: content) as? SaveItemDetailsModel {
                    AppDelegate.sharedDelegate.PassDetailsModel2 = SaveItemDetailsModel.init()
                    AppDelegate.sharedDelegate.PassDetailsModel2 = savedItemData
                }
            }
        }
        
    }
    
    
    
