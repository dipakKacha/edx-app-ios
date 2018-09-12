//
//  UIExtension.swift
//  CommonArchitecture
//
//  Created by Beeline2 on 11/23/16.
//  Copyright © 2016 Beeline2. All rights reserved.
//

import Foundation

@IBDesignable extension UIView {
    @IBInspectable var myBorderColor:UIColor? {
        set {
            layer.borderColor = newValue!.cgColor
        }
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor:color)
            }
            else {
                return nil
            }
        }
    }
    @IBInspectable var myBorderWidth:CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    @IBInspectable var myCornerRadius:CGFloat {
        set {
            layer.cornerRadius = newValue
            clipsToBounds = newValue > 0
        }
        get {
            return layer.cornerRadius
        }
    }
}

//@IBDesignable extension UITextField {
//    @IBInspectable var placeHolderColor:UIColor? {
//        set {
//            attributedPlaceholder = NSAttributedString(string: placeholder ?? "",
//                                                       attributes: [NSAttributedStringKey.foregroundColor: newValue!])
//        }
//        get {
//            return (attributedPlaceholder?.attribute(NSAttributedStringKey.foregroundColor, at: 0, effectiveRange: nil) as! UIColor)
//        }
//    }
//}
                                                                                                  
extension String {
//    public func encryptData() throws -> String {
//        let key = StringEncryption().sha256(ENCRYPTION_KEY, length: 32)
//        let encryptedData: Data = StringEncryption().encrypt(self.data(using: String.Encoding.utf8, allowLossyConversion: false), key: key, iv: ENCRYPTION_IV)
//        return encryptedData.base64EncodedString()
//    }
//
//    public func decryptData() throws -> String {
//        let key = StringEncryption().sha256(ENCRYPTION_KEY, length: 32)
//        let decryptedData: Data = StringEncryption().decrypt(Data(base64Encoded: self), key: key, iv: ENCRYPTION_IV)
//        return (NSString(data: decryptedData, encoding: String.Encoding.utf8.rawValue)! as String)
//    }
    
    public func localized()->String{
        return NSLocalizedString(self, comment: "")
    }
    
    // Substring operations methods
    public func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
    
    //Substring from starting from character index
    public mutating func mySubstring(from: Int) {
        let fromIndex = index(from: from)
        self = substring(from: fromIndex)
    }
    
    //Substring to End at Character index
    public mutating func mySubstring(to: Int) {
        let toIndex = index(from: to)
        self = substring(to: toIndex)
    }
    
    //Substring between given range eg. -> 7..<11 Substring from index 7 to 10
    public mutating func mySubstring(with r: Range<Int>){
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        self = substring(with: startIndex..<endIndex)
        //        return substring(with: startIndex..<endIndex)
    }
    
    //MARK: Date Related Methods
    
//    public func changeDateFormat(currentDateFormat: String, expectedFormat: String) -> String {
//        let dateFormatter = DateFormatter()
//        dateFormatter.locale = Locale(identifier: KEY_ENGLISH_LOCALE)
//        dateFormatter.dateFormat = currentDateFormat
//        let date = dateFormatter.date(from: self)
//
//        dateFormatter.dateFormat = expectedFormat
//        return dateFormatter.string(from: date!)
//    }
//
//    public func getDateFromString(currentDateFormat: String) -> Date {
//        let dateFormatter = DateFormatter()
//        dateFormatter.locale = Locale(identifier: KEY_ENGLISH_LOCALE)
//        dateFormatter.dateFormat = currentDateFormat
//        dateFormatter.timeZone = NSTimeZone(abbreviation: "UTC") as TimeZone!
//
//        return dateFormatter.date(from: self)!
//    }
    
    //Convert MiliSeconds to Date of current time zone
    public func convertMiliSecondsToDate(of dateFormat:String) -> String
    {
        let dateVar = Date.init(timeIntervalSince1970: Double(self)!/1000)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.local
        dateFormatter.dateFormat = dateFormat
        return (dateFormatter.string(from: dateVar))
    }
    
    //Convert UTC Date to MiliSeconds
    public func convertDateToMiliSeconds(of currentDateFormat:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = currentDateFormat
        dateFormatter.timeZone = NSTimeZone(name:"UTC")! as TimeZone
        let date = dateFormatter.date(from: self)
        let miliSeconds = ((date?.timeIntervalSince1970)! * 1000.0).rounded()
        return "\(miliSeconds)"
    }
}

extension UIImage {
    public func resizeImage(scaledToWidth: Float) -> UIImage {
        let oldWidth = Float(self.size.width)
        let scaleFactor = scaledToWidth / oldWidth
        
        let newHeight = Float(self.size.height) * scaleFactor
        let newWidth = oldWidth * scaleFactor
        
        UIGraphicsBeginImageContext(CGSize(width: CGFloat(newWidth), height: CGFloat(newHeight)))
        self.draw(in: CGRect(x: 0, y: 0, width: CGFloat(newWidth), height: CGFloat(newHeight)))
        
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
}

//extension Double {
//    public func roundTo(places:Int) -> Double {
//
//        let divisor = pow(10.0, Double(places))
//        return (self * divisor).rounded() / divisor
//    }
//}

extension Date {
    public func getDateByAddingDays(days: Int) -> Date {
        let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
        var dateComponent = DateComponents()
        dateComponent.day = days
        return (calendar?.date(byAdding: dateComponent, to: self, options:NSCalendar.Options.matchFirst))!
    }
    
    public func getDateBySubtractingDays(days: Int) -> Date {
        let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
        var dateComponent = DateComponents()
        dateComponent.day = -days
        return (calendar?.date(byAdding: dateComponent, to: self, options:NSCalendar.Options.matchFirst))!
    }
    
    public func getDateByAddingMins(minute: Int) -> Date {
        let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
        var dateComponent = DateComponents()
        dateComponent.minute = minute
        return (calendar?.date(byAdding: dateComponent, to: self, options:NSCalendar.Options.matchFirst))!
    }
    
    public func getDateBySubtractingMins(minute: Int) -> Date {
        let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
        var dateComponent = DateComponents()
        dateComponent.minute = -minute
        return (calendar?.date(byAdding: dateComponent, to: self, options:NSCalendar.Options.matchFirst))!
    }
    
//    public func getDateString() -> String {
//        let formatter: DateFormatter = DateFormatter()
//        formatter.locale = Locale(identifier: KEY_ENGLISH_LOCALE)
//        formatter.dateFormat = DATE_FORMAT
//
//        return formatter.string(from: self)
//    }
//
//    public func getTimeString() -> String {
//        let formatter: DateFormatter = DateFormatter()
//        formatter.locale = Locale(identifier: KEY_ENGLISH_LOCALE)
//        formatter.dateFormat = TIME_FORMAT
//
//        return formatter.string(from: self)
//    }
//
//    public func getDateORTimeString(dateFormat: String) -> String {
//        let formatter: DateFormatter = DateFormatter()
//        formatter.locale = Locale(identifier: KEY_ENGLISH_LOCALE)
//        formatter.dateFormat = dateFormat
//        return formatter.string(from: self)
//    }
//
//    public func changeDateFormat(expectedFormat: String) -> Date {
//        let formatter: DateFormatter = DateFormatter()
//        formatter.locale = Locale(identifier: KEY_ENGLISH_LOCALE)
//        formatter.dateFormat = expectedFormat
//        let dateString = formatter.string(from: self)
//
//        return formatter.date(from: dateString)!
//    }

    public func getDayOfWeek()->Int {
        let myCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        let myComponents = myCalendar.components(.weekday, from: self)
        let weekDay = myComponents.weekday
        return weekDay! - 1
    }
}

extension UIButton {
    public func setEnabled() {
        self.isEnabled = true
        self.alpha = 1
    }
    public func setDisabled() {
        self.isEnabled = false
        self.alpha = 0.4
    }
}
