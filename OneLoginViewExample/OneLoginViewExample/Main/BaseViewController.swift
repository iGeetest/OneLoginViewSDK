//
//  BaseViewController.swift
//  OneLoginViewExample
//
//  Created by noctis on 2020/4/23.
//  Copyright © 2020 geetest. All rights reserved.
//

import UIKit
import OneLoginViewSDK
import Alamofire

struct CheckSmsResult: Codable {
    var result: Bool
}

struct VerifyPhoneResult: Codable {
    var status: Int
    var result: String
}

class BaseViewController: UIViewController {

    let GTOneLoginAppId = "b41a959b5cac4dd1277183e074630945"
    let GTOneLoginResultURL = "http://onepass.geetest.com/onelogin/result"
    let GTSendSmsCodeURL = "http://onepass.geetest.com/v2.0/send_message"
    let GTCheckSmsCodeURL = "http://onepass.geetest.com/v2.0/check_message"
    
    let GTOnePassCustomId = "3996159873d7ccc36f25803b88dda97a"
    let GTOnePassResultURL = "http://onepass.geetest.com/v2.0/result"

    private var processId: String?

    // MARK: ViewLifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    // MARK: Sms
    
    func sendSms(_ phone: String?, completion: @escaping (_ successed: Bool) -> Void) {
        var params = Dictionary<String, Any>.init()
        if let phone = phone {
            params["phone"] = phone
        }
        
        Alamofire.request(GTSendSmsCodeURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).response { (response) in
            var successed = false
            
            if let data = response.data {
                do {
                    let result = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? Dictionary<AnyHashable, Any>
                    if let result = result, let processId = result["process_id"] {
                        self.processId = processId as? String
                        successed = true
                    }
                } catch {
                    
                }
            }
            
            completion(successed)
        }
    }
    
    func checkSms(_ smsCode: String?, completion: @escaping (Result<CheckSmsResult>) -> Void) {
        var params = Dictionary<String, Any>.init()
        if let smsCode = smsCode {
            params["message_number"] = smsCode
        }
        
        if let processId = self.processId {
            params["process_id"] = processId
        }
        
        Alamofire.request(GTCheckSmsCodeURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).response { (response) in
            var successed = false
            
            if let data = response.data {
                do {
                    let checkSmsResult = try JSONDecoder().decode(CheckSmsResult.self, from: data)
                    if checkSmsResult.result {
                        successed = true
                        completion(.success(checkSmsResult))
                    }
                } catch {
                    print("JSON decode error.")
                }
            }
            
            if !successed {
                if let error = response.error {
                    completion(.failure(error))
                } else {
                    completion(.failure(NSError.init(domain: "check sms code error", code: 30000, userInfo: nil)))
                }
            }
        }
    }

    // MARK: Color
    
    func colorFromHexString(_ string: String) -> UIColor {
        if string.count > 0 {
            var colorString = string
            if colorString.hasPrefix("#") {
                colorString = String(colorString.dropFirst("#".count))
            }
            
            if colorString.lowercased().hasPrefix("0x") {
                colorString = String(colorString.dropFirst("0x".count))
            }
            
            if colorString.count > 0 {
                if colorString.count >= 8 {
                    colorString = String(colorString.suffix(8))
                } else if colorString.count >= 6 {
                    colorString = String(colorString.suffix(6))
                } else {
                    repeat {
                        colorString = "0".appending(colorString)
                    } while colorString.count < 6
                }
                                
                var startIndex = 0
                
                var aStartIndex: String.Index? = nil
                var aEndIndex: String.Index? = nil
                
                if 8 == colorString.count {
                    aStartIndex = colorString.index(colorString.startIndex, offsetBy: 0)
                    aEndIndex = colorString.index(colorString.startIndex, offsetBy: 2)
                    startIndex += 2
                }
                
                let rStartIndex = colorString.index(colorString.startIndex, offsetBy: startIndex)
                let rEndIndex = colorString.index(colorString.startIndex, offsetBy: startIndex + 2)
                
                startIndex += 2
                let gStartIndex = colorString.index(colorString.startIndex, offsetBy: startIndex)
                let gEndIndex = colorString.index(colorString.startIndex, offsetBy: startIndex + 2)
                
                startIndex += 2
                let bStartIndex = colorString.index(colorString.startIndex, offsetBy: startIndex)
                let bEndIndex = colorString.index(colorString.startIndex, offsetBy: startIndex + 2)
                
                let rString = String(colorString[rStartIndex..<rEndIndex])
                let gString = String(colorString[gStartIndex..<gEndIndex])
                let bString = String(colorString[bStartIndex..<bEndIndex])
                                
                var rInt: UInt32 = 0
                Scanner.init(string: rString).scanHexInt32(&rInt)
                
                var gInt: UInt32 = 0
                Scanner.init(string: gString).scanHexInt32(&gInt)
                
                var bInt: UInt32 = 0
                Scanner.init(string: bString).scanHexInt32(&bInt)
                
                var aInt: UInt32 = 255
                if let aStartIndex = aStartIndex, let aEndIndex = aEndIndex {
                    let aString = String(colorString[aStartIndex..<aEndIndex])
                    Scanner.init(string: aString).scanHexInt32(&aInt)
                }
                
                return UIColor.init(red: CGFloat(Double.init(rInt)/255.0), green: CGFloat(Double.init(gInt)/255.0), blue: CGFloat(Double.init(bInt)/255.0), alpha: CGFloat(Double.init(aInt)/255.0))
            }
        }
        
        return .clear
    }
}
