//
//  Extensions.swift
//  Litter Stopper
//
//  Created by Applr on 24/08/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import Dispatch
import Foundation
struct ScreenSize {
    static let width = UIScreen.main.bounds.size.width
    static let height = UIScreen.main.bounds.size.height
    static let frame = CGRect(x: 0, y: 0, width: ScreenSize.width, height: ScreenSize.height)
    static let maxWH = max(ScreenSize.width, ScreenSize.height)
}
struct DeviceType {
    static let iPhone4orLess  = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxWH < 568.0
    static let iPhone5orSE    = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxWH == 568.0
    static let iPhone678      = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxWH == 667.0
    static let iPhone678p     = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxWH == 736.0
    static let iPhoneX        = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxWH == 812.0
}
//--------------MARK:- NSUserDefaults Extension -
enum PRODUCT_TYPE {
    case new
    case edit
}

enum SHARE_TYPE {
    case invite
    case share
}

enum REPORT_TYPE {
    case user
    case item
}

enum RATE_TYPE {
    case user
    case item
}
enum BLOCK_TYPE {
    case fromMsg
    case fromProfile
}

enum HOME_TYPE {
    case normal
    case category
    case follow
    case evrything
}

enum PICKER_TYPE {
    case profile
    case signUp
}
enum CODE_PICKER_TYPE {
    case settings
    case signUp

}
extension UIView {
    func pushTransition(duration:CFTimeInterval) {
        let animation:CATransition = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            kCAMediaTimingFunctionEaseInEaseOut)
        animation.type = kCATransitionMoveIn
        animation.subtype = kCATransitionFromLeft
        animation.duration = duration
        animation.repeatCount = 99
        self.layer.add(animation, forKey: kCATransitionPush)
    }
}
extension String {
    func isValidDouble(maxDecimalPlaces: Int) -> Bool {
        let formatter = NumberFormatter()
        formatter.allowsFloats = true // Default is true, be explicit anyways
        formatter.locale = Locale(identifier: "en_US_POSIX")
        let decimalSeparator = formatter.decimalSeparator ?? "."  // Gets the locale specific decimal separator. If for some reason there is none we assume "." is used as separator.
        
        if formatter.number(from: self) != nil {
            // Split our string at the decimal separator
            let split = self.components(separatedBy: decimalSeparator)
            
            // Depending on whether there was a decimalSeparator we may have one
            // or two parts now. If it is two then the second part is the one after
            // the separator, aka the digits we care about.
            // If there was no separator then the user hasn't entered a decimal
            // number yet and we treat the string as empty, succeeding the check
            let digits = split.count == 2 ? split.last ?? "" : ""
            let numberValue = split.first ?? ""
            var numberCount = 0
            if let _ = Int(numberValue){
                numberCount = numberValue.count
            }
            
            // Finally check if we're <= the allowed digits
            return digits.count <= 15    // TODO: Swift 4.0 replace with digits.count, YAY!
        }
        
        return false // couldn't turn string into a valid number
    }

    func format(f: String) -> String {
        let myDouble = Double(f)
        let doubleStr = String(format: "%.2f", myDouble!) // "3.14"
        return doubleStr
    }
}
 extension  UILabel {
    func letsRotateLabel(rotatedValue : CGFloat)  {
        let radians = CGFloat(CGFloat(Double.pi) * rotatedValue / CGFloat(180.0))
        self.transform = CGAffineTransform(rotationAngle: radians)
    }
}

extension UserDefaults
{
    class func hasValue(key: String) -> Bool {
        return nil != self.standard.object(forKey: key)
    }
    class func SFSDefault(setIntegerValue integer: Int , forKey key : String)
    {
        UserDefaults.standard.set(integer, forKey: key)
        UserDefaults.standard.synchronize()
    }
    class func SFSDefault(setObject object: Any , forKey key : String)
    {
        UserDefaults.standard.set(object, forKey: key)
        UserDefaults.standard.synchronize()
    }
    class func SFSDefault(setValue object: Any , forKey key : String)
    {
        UserDefaults.standard.setValue(object, forKey: key)
        UserDefaults.standard.synchronize()
    }
    class func SFSDefault(setBool boolObject:Bool  , forKey key : String)
    {
        UserDefaults.standard.set(boolObject, forKey : key)
        UserDefaults.standard.synchronize()
    }
    
    
    class func SFSDefault(integerForKey  key: String) -> Int
    {
        let integerValue : Int = UserDefaults.standard.integer(forKey: key) as Int
        UserDefaults.standard.synchronize()
        
        return integerValue
    }
    class func SFSDefault(objectForKey key: String) -> Any
    {
        let object : Any = UserDefaults.standard.object(forKey: key)! as Any
        if UserDefaults.standard.object(forKey: key) != nil
        {
          return object
        }
       return ""
    }
    class func SFSDefault(valueForKey  key: String) -> Any
    {
        let value : Any = UserDefaults.standard.value(forKey: key)! as Any
        UserDefaults.standard.synchronize()
        return value
    }
    class func SFSDefault(boolForKey  key : String) -> Bool
    {
        let booleanValue : Bool = UserDefaults.standard.bool(forKey: key) as Bool
        UserDefaults.standard.synchronize()
        return booleanValue
    }
    
    class func SFSDefault(removeObjectForKey key: String)
    {
        UserDefaults.standard.removeObject(forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    //Save no-premitive data
    class func SFSDefault(setArchivedDataObject object: Any , forKey key : String)
    {
         let data  = NSKeyedArchiver.archivedData(withRootObject: object)
        UserDefaults.standard.set(data, forKey: key)
        UserDefaults.standard.synchronize()
    }
    class func SFSDefault(getUnArchiveObjectforKey key: String) -> Any?
    {
        var objectValue : Any?
        guard  let storedData  = UserDefaults.standard.object(forKey: key) as? Data else{return objectValue}
        objectValue   =  NSKeyedUnarchiver.unarchiveObject(with: storedData)
        UserDefaults.standard.synchronize()
        return objectValue
        
        
    }
}

extension UIColor
{
    static var AppLogoColor:UIColor           {return UIColor(red: 236.0/255.0, green: 82.0/255.0, blue: 77.0/255.0, alpha: 1.0)}
    static var textFieldBorderColor:UIColor   {return UIColor(red: 244.0/255.0, green: 244.0/255.0, blue: 244.0/255.0, alpha: 1.0)}
    static var smRedColor:UIColor             {return UIColor(red: 199.0/255.0, green: 49.0/255.0, blue: 32.0/255.0, alpha: 1.0)}
    static var smCellBackGroundColor:UIColor  {return UIColor(red: 245.0/255.0, green: 245.0/255.0, blue: 245.0/255.0, alpha: 1.0)}
    static var smCellSelectedColor:UIColor    {return UIColor(red: 230.0/255.0, green: 232.0/255.0, blue: 235.0/255.0, alpha: 1.0)}
    static var smPlaceHolderColor:UIColor     {return UIColor(red: 161.0/255.0, green: 161.0/255.0, blue: 162.0/255.0, alpha: 1.0)}
    static var smSeparatorColor:UIColor       {return UIColor(red: 249.0/255.0, green: 249.0/255.0, blue: 2492.0/255.0, alpha: 1.0) }
    static var smBlueColor:UIColor            {return UIColor(red: 82.0/255.0, green: 158.0/255.0, blue: 179.0/255.0, alpha: 1.0)}
    static var smLightBlueColor:UIColor       {return UIColor(red: 187.0/255.0, green: 216.0/255.0, blue: 224.0/255.0, alpha: 1.0)}
    static var smVioletColor:UIColor          {return UIColor(red: 158.0/255.0, green: 0.0/255.0, blue: 93.0/255.0, alpha: 1.0)}
    static var  getRandomColor: UIColor       {return UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1.0)}
    
    static func smRGB(smRed r:CGFloat , smGrean g: CGFloat , smBlue b: CGFloat)->UIColor
    {
        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1.0)
        
    }
    

}

extension UITabBar {
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        if DeviceType.iPhoneX {
            sizeThatFits.height = 85
        }
        else{
            sizeThatFits.height = 49
        }// adjust your size here
        return sizeThatFits
    }

}
extension UITextField
{
    func borderAndRound(color : UIColor)  {
      //  self.layer.cornerRadius = self.frame.size.height/2
     //   self.clipsToBounds = true
//        self.backgroundColor = UIColor.clear
        self.layer.borderWidth = 1.0
        self.layer.borderColor = color.cgColor
    }
    func textFieldPlaceholderColor(_ color:UIColor){
        let attibutedStr:NSAttributedString=NSAttributedString(string: self.placeholder!, attributes: [NSAttributedStringKey.foregroundColor: color]);
        //        self.attributedPlaceholder = NSAttributedString(string:placeholder,
        //            attributes:[NSForegroundColorAttributeName: color])
        
        self.attributedPlaceholder=attibutedStr
    }
    
    func setLeftPaddingImageIcon(_ imageicon:UIImage){
      self.layer.cornerRadius = self.frame.size.height/2
        self.clipsToBounds = true
//        self.backgroundColor = UIColor.clear
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.smBlueColor.cgColor

        let image1: UIImage? = imageicon
        if image1 != nil {
            let view: UIView? = UIView()
            view!.frame = CGRect(x: 0, y: 0, width: self.frame.size.height, height: self.frame.size.height)
            let imageView=UIImageView()
            imageView.frame=CGRect(x: 16, y: 8, width: self.frame.size.height - 24, height: self.frame.size.height - 16)
            imageView.image=imageicon
            imageView.contentMode = .scaleAspectFit
            view?.addSubview(imageView)
            self.leftView=view
            self.leftViewMode=UITextFieldViewMode.always
            
        }
       // self.setRightPaddingView()
    }
    
    func setLeftPaddingView(){
        let paddingView=UIView()
        paddingView.frame=CGRect(x: 0, y: 0, width: 10, height: 30)
        self.leftView=paddingView
        self.layer.borderColor = UIColor.init(red: 153.0/255.0, green: 153.0/255.0, blue: 153.0/255.0, alpha: 1.0).cgColor

        self.autocorrectionType = .no
        self.leftViewMode=UITextFieldViewMode.always
    }
    
    func setRightPaddingImageIcon(_ imageicon:UIImage){
        self.layer.cornerRadius = self.frame.size.height/2
        self.clipsToBounds = true
        self.layer.borderWidth = 1.0

        let image1: UIImage? = imageicon
        if image1 != nil {
//            let view: UIView? = UIView()
//            view!.frame = CGRect(x: 0, y: 0, width: self.frame.size.height - 16, height: self.frame.size.height)

            let button = UIButton(type: .custom)
            button.setImage(imageicon, for: .normal)
            button.frame = CGRect(x: 0, y: 0, width: self.frame.size.height - 16, height: self.frame.size.height)
            
            button.tag = tag
          //  button.addTarget(viewController, action: #selector(tapAction(_:)), for: .touchUpInside)

//            let imageView=UIImageView()
//            imageView.frame=CGRect(x: 0, y: 8, width: self.frame.size.height-30, height: self.frame.size.height-16)
//            imageView.image=imageicon
//            imageView.contentMode = .scaleAspectFit
//            imageView.isUserInteractionEnabled = true
//            let tap = UITapGestureRecognizer.init(target: <#T##Any?#>, action: )
//
//
//
//
//
//            view?.addSubview(imageView)
            self.rightView=button
            self.rightViewMode=UITextFieldViewMode.always

            
        }
    }
    
    func setRightPaddingView(){
        let paddingView=UIView()
        paddingView.frame=CGRect(x: 0, y: 0, width: 10, height: 30)
        self.rightView=paddingView
        self.rightViewMode=UITextFieldViewMode.always
    }
    
    func setLeftAndRightPadding() {
        self.setLeftPaddingView()
        self.setRightPaddingView()
       // self.setTextAlginmentWithLanguage()
    }
    
//    func setPaddingImageWithAlignment(_ paddingImage: UIImage) {
//        if AppManager.getLanguage() == kEnglish {
//            self.textAlignment = .left
//            self.setLeftPaddingImageIcon(paddingImage)
//            self.setRightPaddingView()
//        }
//        else{
//            self.textAlignment = .right
//            self.setRightPaddingImageIcon(paddingImage)
//            self.setLeftPaddingView()
//        }
//    }
//    
//    func setTextAlginmentWithLanguage() {
//        if AppManager.getLanguage() == kArbic {
//            self.textAlignment = .right
//        }else{
//            self.textAlignment = .left
//        }
//    }
    
    func setTextFieldRadiusCorner(_ cornerRadius:CGFloat){
        self.layer.cornerRadius=cornerRadius;
        self.layer.masksToBounds=true;
    }
    
    func setTextFieldBoader(_ borderW:CGFloat,borderC:UIColor){
        self.layer.borderWidth=borderW;
        self.layer.borderColor=borderC.cgColor;
    }
}
extension UITextView
{
    func setTextViewBoader(_ borderW:CGFloat,borderC:UIColor){
        self.layer.borderWidth=borderW;
        self.layer.borderColor=borderC.cgColor;
    }
}
//MARK
//MARK :- UILabel Extension
extension UILabel{
func lblEdgeCorner(){
    self.layer.cornerRadius = 5;
    self.clipsToBounds = true
}
}
//MARK
//MARK :- UIButton Extension
extension UIButton{
    func borderAndRound(color : UIColor)  {
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
//        self.backgroundColor = UIColor.clear
        self.layer.borderWidth = 1.0
        self.layer.borderColor = color.cgColor
    }

    func btnBackgroundColor(){
        self.backgroundColor = UIColor.init(red: 236.0/255.0, green: 82.0/255.0, blue: 77.0/255.0, alpha: 1.0)
    }
    
    func btnRoundCorner(cornerRadius:CGFloat){
            self.layer.cornerRadius = cornerRadius;
        self.clipsToBounds = true
    }

}

//MARK: - UINAvigationBarItems as UIView
extension UIView{
    func addAsBarButtonItem(view:UIView) -> UIView {
        view.frame = CGRect.init(x: 0, y: 20, width: 44, height: 44)
        return view
    }
    func ViewborderAndRound(color : UIColor,cornerRadius:CGFloat)  {
        self.layer.cornerRadius = cornerRadius
        //  self.clipsToBounds = true
        self.layer.borderWidth = 1.0
        self.layer.borderColor = color.cgColor
    }
    func dropShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize(width: -1, height: 1)
        self.layer.shadowRadius = 2
        //        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true

        self.layer.rasterizationScale = UIScreen.main.scale

    }
}

//--------------MARK: - UIAlertController Extension -
let UIAlertControllerBlocksCancelButtonIndex : Int = 0;
let UIAlertControllerBlocksDestructiveButtonIndex : Int = 1;
let UIAlertControllerBlocksFirstOtherButtonIndex : Int = 2;
typealias UIAlertControllerPopoverPresentationControllerBlock = (_ popover:UIPopoverPresentationController?)->Void
typealias UIAlertControllerCompletionBlock = (_ alertController:UIAlertController?,_ action:UIAlertAction?,_ buttonIndex:Int?)->Void
extension UIAlertController{
     //MARK: - showInViewController -
    class func showInViewController(viewController:UIViewController!,withTitle title:String?,withMessage message:String?,withpreferredStyle preferredStyle:UIAlertControllerStyle?,cancelButtonTitle cancelTitle:String?,destructiveButtonTitle destructiveTitle:String?,otherButtonTitles otherTitles:[String?]?,popoverPresentationControllerBlock:UIAlertControllerPopoverPresentationControllerBlock?,tapBlock:UIAlertControllerCompletionBlock?) -> UIAlertController!{
        
        let strongController : UIAlertController! = UIAlertController(title: title, message: message, preferredStyle: preferredStyle!)
        strongController.view.tintColor = UIColor.black
        if (cancelTitle != nil)
        {
            let cancelAction : UIAlertAction = UIAlertAction(title: cancelTitle, style: .cancel, handler: { (action:UIAlertAction) in
                if (tapBlock != nil){
                    tapBlock!(strongController,action,UIAlertControllerBlocksCancelButtonIndex)
                }
            })
            strongController.addAction(cancelAction)
        }
        if (destructiveTitle != nil)
        {
            let destructiveAction : UIAlertAction = UIAlertAction(title: destructiveTitle, style:.destructive, handler: { (action:UIAlertAction) in
                if (tapBlock != nil){
                    tapBlock!(strongController,action,UIAlertControllerBlocksDestructiveButtonIndex)
                }
            })
            strongController.addAction(destructiveAction)
        }
        if (otherTitles != nil)
        {
            for btnx in 0..<otherTitles!.count
            {
                let otherButtonTitle:String = otherTitles![btnx]!
                
                let otherAction : UIAlertAction = UIAlertAction(title: otherButtonTitle, style: .default, handler: { (action:UIAlertAction) in
                    if (tapBlock != nil){
                        tapBlock!(strongController,action,UIAlertControllerBlocksFirstOtherButtonIndex+btnx)
                    }
                })
                strongController.addAction(otherAction)
                
            }
        }
        
        if (popoverPresentationControllerBlock != nil)
        {
            popoverPresentationControllerBlock!(strongController.popoverPresentationController!)
        }
        
        DispatchQueue.main.async {
            viewController.present(strongController, animated: true, completion:{})
        }
        
        return strongController
    }
    //MARK:- showAlertInViewController -
    class func showAlertInViewController(viewController:UIViewController!,withTitle title:String?,message:String?,cancelButtonTitle cancelTitle:String?,destructiveButtonTitle destructiveTitle:String?,otherButtonTitles otherTitles:[String?]?,tapBlock:UIAlertControllerCompletionBlock?) -> UIAlertController!{
        
        return self.showInViewController(viewController: viewController, withTitle: title, withMessage: message, withpreferredStyle:.alert, cancelButtonTitle: cancelTitle, destructiveButtonTitle: destructiveTitle, otherButtonTitles: otherTitles, popoverPresentationControllerBlock: nil, tapBlock: tapBlock)
    }
    //MARK:- showActionSheetInViewController -
    class func showActionSheetInViewController(viewController:UIViewController!,withTitle title:String?,message:String?,cancelButtonTitle cancelTitle:String?,destructiveButtonTitle destructiveTitle:String?,otherButtonTitles otherTitles:[String?]?,tapBlock:UIAlertControllerCompletionBlock?) -> UIAlertController!{
        
        return self.showInViewController(viewController: viewController, withTitle: title, withMessage: message, withpreferredStyle:.actionSheet, cancelButtonTitle: cancelTitle, destructiveButtonTitle: destructiveTitle, otherButtonTitles: otherTitles, popoverPresentationControllerBlock: nil, tapBlock: tapBlock)
    }
    class func showActionSheetInViewController(viewController:UIViewController!,withTitle title:String?,message:String?,cancelButtonTitle cancelTitle:String?,destructiveButtonTitle destructiveTitle:String?,otherButtonTitles otherTitles:[String?]?,popoverPresentationControllerBlock:UIAlertControllerPopoverPresentationControllerBlock?,tapBlock:UIAlertControllerCompletionBlock?) -> UIAlertController!{
        
        return self.showInViewController(viewController: viewController, withTitle: title, withMessage: message, withpreferredStyle:.actionSheet, cancelButtonTitle: cancelTitle, destructiveButtonTitle: destructiveTitle, otherButtonTitles: otherTitles, popoverPresentationControllerBlock: popoverPresentationControllerBlock, tapBlock: tapBlock)
    }
    
}

extension String{
    func floatValue() -> Float? {
        if let floatval = Float(self) {
            return floatval
        }
        return nil
    }

    func insert(seperator: String, afterEveryXChars: Int, intoString: String) -> String
    {
        var output = ""
        intoString.enumerated().forEach { index, c in
            if index % afterEveryXChars == 0 && index > 0
            {
                output += seperator
            }
            output.append(c)
        }
        //        insert(":", afterEveryXChars: 2, intoString: "11231245")
        print(output)
        return output
    }
    func capitalizingFirstLetter() -> String {
        let first = String(prefix(1)).capitalized
        let other = String(dropFirst())
        return first + other
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
        }



extension UIImage {
    class func imageWithView(view: UIView) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
    
    func setParmentCard(cardType: String) -> UIImage{
        switch cardType {
        case "American Express":
            return #imageLiteral(resourceName: "amex")
        case "MasterCard":
            return #imageLiteral(resourceName: "mastercard")
        case "Discover":
            return #imageLiteral(resourceName: "discover")
        case "Visa":
            return #imageLiteral(resourceName: "visa")
        case "Diners Club":
            return #imageLiteral(resourceName: "diners_club")
        case "JCB":
            return #imageLiteral(resourceName: "jcb")
        case "Amazon":
            return #imageLiteral(resourceName: "amazon")
        case "Citi":
            return #imageLiteral(resourceName: "citi")
        case "Apple Pay":
            return #imageLiteral(resourceName: "apple")
        case "Android Pay":
            return #imageLiteral(resourceName: "android_pay")
        case "PayPal":
            return #imageLiteral(resourceName: "paypal")
        case "Wallet":
            return #imageLiteral(resourceName: "wallet")
        default:
            return #imageLiteral(resourceName: "reverse")
        }
    }
}

extension UIView {
    
    func addConstraintsWithFormat(_ format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
    func addCenterConstraintsOf(item:UIView ,itemSize size:CGSize!){
        item.translatesAutoresizingMaskIntoConstraints = false
        let width : NSLayoutConstraint = NSLayoutConstraint(item: item, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: size.width)
        let height : NSLayoutConstraint = NSLayoutConstraint(item: item, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: size.height)
        let xConstraint : NSLayoutConstraint = NSLayoutConstraint(item: item, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
        let yConstraint : NSLayoutConstraint = NSLayoutConstraint(item: item, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate([width,height,xConstraint,yConstraint])
        item.setNeedsDisplay()
    }
}


extension DispatchQueue {
    
    static var userInteractive: DispatchQueue { return DispatchQueue.global(qos: .userInteractive) }
    static var userInitiated: DispatchQueue { return DispatchQueue.global(qos: .userInitiated) }
    static var utility: DispatchQueue { return DispatchQueue.global(qos: .utility) }
    static var background: DispatchQueue { return DispatchQueue.global(qos: .background) }
    
    func after(_ delay: TimeInterval, execute closure: @escaping () -> Void) {
        asyncAfter(deadline: .now() + delay, execute: closure)
    }
    
    func syncResult<T>(_ closure: () -> T) -> T {
        var result: T!
        sync { result = closure() }
        return result
    }
}

