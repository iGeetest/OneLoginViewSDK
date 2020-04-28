//
//  OnePassViewXibViewController.swift
//  OneLoginViewExample
//
//  Created by noctis on 2020/4/24.
//  Copyright © 2020 geetest. All rights reserved.
//

import UIKit
import OneLoginViewSDK
import SnapKit
import Alamofire

class OnePassViewXibViewController: BaseViewController {

    @IBOutlet weak var authView1: OPAuthView!
    @IBOutlet weak var authView2: OPAuthView!
    @IBOutlet weak var authView3: OPAuthView!
    @IBOutlet weak var authView4: OPAuthView!
    @IBOutlet weak var authView5: OPAuthView!
        
    // MARK: ViewLifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "OnePassViewXib"
        // Do any additional setup after loading the view.
        self.setupAuthView()
    }
    
    func setupAuthView() {
        self.authView1.delegate = self
        let configModel1 = OPViewNoHintBarModel.init()
        configModel1.customId = GTOnePassCustomId
        configModel1.smsCodeCount = 6
        self.authView1.configModel = configModel1
        self.authView1.snp.updateConstraints { (make) in
            make.height.equalTo(75)
        }
        
        self.authView2.delegate = self
        let configModel2 = OPViewWithHintBarModel.init()
        configModel2.customId = GTOnePassCustomId
        self.authView2.configModel = configModel2
        
        self.authView3.delegate = self
        let configModel3 = OPViewWithHintBarModel.init()
        configModel3.customId = GTOnePassCustomId
        self.authView3.configModel = configModel3
        
        self.authView4.delegate = self
        let configModel4 = OPViewNoHintBarModel.init()
        configModel4.customId = GTOnePassCustomId
        self.authView4.configModel = configModel4
        
        self.authView5.delegate = self
        let configModel5 = OPViewNoHintBarModel.init()
        configModel5.customId = GTOnePassCustomId
        self.authView5.configModel = configModel5
    }

    // MARK: Verify
    
    func verifyPhoneFailed(_ phone: String, opAuthView: OPAuthView) {
        self.sendSms(phone, completion: { (successed) in
            opAuthView.setSendSmsCodeResult(successed)
        })
    }
}

extension OnePassViewXibViewController: OPAuthDelegate {
    func opAuthView(_ opAuthView: OPAuthView, didReceiveVerifyPhoneData data: [AnyHashable : Any], phone: String) {
        var params = data
        params["id_2_sign"] = GTOnePassCustomId
        
        Alamofire.request(GTOnePassResultURL, method: .post, parameters: params as? Parameters, encoding: JSONEncoding.default, headers: nil).response { (response) in
            if let error = response.error {
                print("validate token error: ", error)
                self.verifyPhoneFailed(phone, opAuthView: opAuthView)
                return
            }
            
            var verifyPhoneResult: VerifyPhoneResult?
            if let data = response.data {
                do {
                    verifyPhoneResult = try JSONDecoder().decode(VerifyPhoneResult.self, from: data)
                } catch {
                    
                }
            }
            
            if let verifyPhoneResult = verifyPhoneResult, 200 == verifyPhoneResult.status, "0" == verifyPhoneResult.result {
                opAuthView.setVerifyPhoneResult(true)
            } else {
                self.verifyPhoneFailed(phone, opAuthView: opAuthView)
            }
        }
    }
    
    func opAuthView(_ opAuthView: OPAuthView, didVerifyPhoneError error: GOPError, phone: String) {
        print("verify phone error: ", error)
        self.verifyPhoneFailed(phone, opAuthView: opAuthView)
    }
    
    func opAuthView(_ opAuthView: OPAuthView, didStartVerifySmsCode smsCode: String) {
        self.checkSms(smsCode) { (result) in
            switch result {
            case .success(let checkResult):
                print("check sms code result: ", checkResult)
                opAuthView.setVerifySmsCodeResult(true)
                
            case .failure(let error):
                print("check sms code error: ", error)
                opAuthView.setVerifySmsCodeResult(false)
                
            }
        }
    }
    
    func opAuthView(_ opAuthView: OPAuthView, didResendSmsCode phone: String) {
        self.sendSms(phone, completion: { (successed) in
            opAuthView.setResendSmsCodeResult(successed)
        })
    }
}
