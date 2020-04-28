//
//  OnePassViewViewController.swift
//  OneLoginViewExample
//
//  Created by noctis on 2020/4/23.
//  Copyright © 2020 geetest. All rights reserved.
//

import UIKit
import OneLoginViewSDK
import SnapKit
import Alamofire

class OnePassViewViewController: BaseViewController {

    var hasHintBar: Bool = false
    
    private let customOnePassView = true
    private lazy var opAuthView: OPAuthView = {
        return OPAuthView.init()
    }()
    
    // MARK: ViewLifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        // Do any additional setup after loading the view.
        self.navigationItem.title = "OnePassView"
        self.setupOnePassView()
    }

    // MARK: Setup View
    
    func setupOnePassView() {
        if self.hasHintBar {
            self.setupOnePassViewWithHintBar()
        } else {
            self.setupOnePassViewNoHintBar()
        }
    }
    
    func setupOnePassViewWithHintBar() {
        self.opAuthView.delegate = self
        self.view.addSubview(self.opAuthView)
        
        let withHintBarModel = OPViewWithHintBarModel.init()
        withHintBarModel.customId = GTOnePassCustomId
        
        // OnePassView 配置
        if self.customOnePassView {
            // 验证视图
            withHintBarModel.verifyNormalBackgroundColor = self.colorFromHexString("#FB7199")
            withHintBarModel.verifySuccessedBackgroundColor = self.colorFromHexString("#73BB10")
            
            // 状态视图
            withHintBarModel.statusViewBackgroundColor = self.colorFromHexString("#FFB63F")
            if let image = UIImage.init(named: "") {        // 输入状态图标
                withHintBarModel.inputingStatusImage = image
            }
            if let image = UIImage.init(named: "") {        // 校验成功时图标
                withHintBarModel.successStatusImage = image
            }
            if let image = UIImage.init(named: "") {        // 滑动状态图标
                withHintBarModel.slidingStatusImage = image
            }
            if let image = UIImage.init(named: "") {        // 加载状态图标
                withHintBarModel.loadingStatusImage = image
            }
            if let image = UIImage.init(named: "") {        // 发送短信验证码时图标
                withHintBarModel.sendingSmsCodeStatusImage = image
            }
            
            // 手机号输入视图
            withHintBarModel.phoneViewBackgroundColor = self.colorFromHexString("#4CFFFFFF")
            withHintBarModel.phoneTextFieldColor = .white
//            withHintBarModel.phoneTextFieldFont = OLVFontUtil.font(fromBundle: 26.0) // 字体建议不设置，SDK 会根据控件尺寸进行适配
            withHintBarModel.phoneTextFieldPlaceholder = "请输入您的手机号"
//            withHintBarModel.phoneTextFieldPlaceholderFont = UIFont.systemFont(ofSize: 15.0) // 字体建议不设置，SDK 会根据控件尺寸进行适配
            withHintBarModel.phoneTextFieldPlaceholderColor = .white
            withHintBarModel.phoneCursorColor = .white
            
            // 提示条视图
            withHintBarModel.hintNormalBackgroundColor = self.colorFromHexString("#FCE6EC")
            withHintBarModel.hintErrorBackgroundColor = .red
            withHintBarModel.hintDefaultColor = self.colorFromHexString("#7C8AAC")
            withHintBarModel.hintColor = self.colorFromHexString("#492F3A")
            withHintBarModel.hintErrorColor = self.colorFromHexString("#492F3A")
            withHintBarModel.hintPhoneColor = self.colorFromHexString("#492F3A")
            if let image = UIImage.init(named: "") {        // 关闭按钮
                withHintBarModel.hintCloseImage = image
            }
//            withHintBarModel.hintFont = UIFont.systemFont(ofSize: 12.0) // 字体建议不设置，SDK 会根据控件尺寸进行适配
//            withHintBarModel.hintPhoneFont = UIFont.systemFont(ofSize: 12) // 字体建议不设置，SDK 会根据控件尺寸进行适配
            withHintBarModel.hintDefault = "为您守护账号安全"
            withHintBarModel.hintVerifyPhone = "手机"
            withHintBarModel.hintSmsCodeHasSended = "验证码已发送"
            withHintBarModel.hintVerifySmsCodeError = "验证码不正确"
            withHintBarModel.hintPhoneFormatError = "手机号格式不正确"
            withHintBarModel.hintSendSmsCodeError = "验证码未发送"
            withHintBarModel.particlePointColor = self.colorFromHexString("#FFB2C8")
            withHintBarModel.particleLineColorHexString = "#EFD7DE"
            
            // 滑动视图
            withHintBarModel.sliderViewBackgroundColor = self.colorFromHexString("#4C000000")
            withHintBarModel.sliderColor = self.colorFromHexString("#D9FA4900")
            withHintBarModel.sliderHintTextColor = .white
            if let image = UIImage.init(named: "") {        // 滑动背景图片
                withHintBarModel.sliderViewBackgroundImage = image
            }
            if let image = UIImage.init(named: "滑块") {        // 滑块图片
                withHintBarModel.sliderImage = image
            }
//            withHintBarModel.sliderHintTextFont = UIFont.systemFont(ofSize: 15) // 字体建议不设置，SDK 会根据控件尺寸进行适配
            withHintBarModel.sliderHint = "请拖动滑块"
            
            // 验证码视图
            withHintBarModel.smsCodeViewBackgroundColor = self.colorFromHexString("#4CFFFFFF")
            withHintBarModel.smsCodeTextColor = .white
            withHintBarModel.smsCodeCursorColor = .white
            withHintBarModel.smsCodeCountDownColor = .white
            withHintBarModel.smsCodeResendColor = .white
            withHintBarModel.smsCodeCount = 6 // 验证码位数，默认为 6
            withHintBarModel.smsCodeCountDownSeconds = 60 // 倒计时秒数，默认 60s
//            withHintBarModel.smsCodeTextFont = OLVFontUtil.font(fromBundle: 26.0) // 字体建议不设置，SDK 会根据控件尺寸进行适配
//            withHintBarModel.smsCodeCountDownFont = UIFont.systemFont(ofSize: 15.0) // 字体建议不设置，SDK 会根据控件尺寸进行适配
//            withHintBarModel.smsCodeResendFont = UIFont.systemFont(ofSize: 15.0) // 字体建议不设置，SDK 会根据控件尺寸进行适配
        }
        
        self.opAuthView.configModel = withHintBarModel
        
        let size = OPAuthView.suggestedOPViewSize(withHintBarModel)
        self.opAuthView.snp.makeConstraints({ (make) in
            make.left.equalTo(self.view).offset((UIScreen.main.bounds.size.width - size.width)/2.0)
            make.top.equalTo(self.view).offset(120)
            make.size.equalTo(size)
        })
    }
    
    func setupOnePassViewNoHintBar() {
        self.opAuthView.delegate = self
        self.view.addSubview(self.opAuthView)
        
        let noHintBarModel = OPViewNoHintBarModel.init()
        noHintBarModel.customId = GTOnePassCustomId
        
        self.opAuthView.configModel = noHintBarModel
        
        // OnePassView 配置
        if self.customOnePassView {
            // 验证视图
            noHintBarModel.verifyNormalBackgroundColor = self.colorFromHexString("#FB7199")
            noHintBarModel.verifySuccessedBackgroundColor = self.colorFromHexString("#73BB10")
            noHintBarModel.verifySmsCodeFailedBackgroundColor = self.colorFromHexString("#FF3300")
            noHintBarModel.phoneFormatErrorBackgroundColor = self.colorFromHexString("#FF3300")
            
            // 状态视图
            noHintBarModel.statusViewBackgroundColor = self.colorFromHexString("#FFB63F")
            if let image = UIImage.init(named: "") {        // 输入状态图标
                noHintBarModel.inputingStatusImage = image
            }
            if let image = UIImage.init(named: "") {        // 校验成功时图标
                noHintBarModel.successStatusImage = image
            }
            if let image = UIImage.init(named: "") {        // 滑动状态图标
                noHintBarModel.slidingStatusImage = image
            }
            if let image = UIImage.init(named: "") {        // 加载状态图标
                noHintBarModel.loadingStatusImage = image
            }
            if let image = UIImage.init(named: "") {        // 发送短信验证码时图标
                noHintBarModel.sendingSmsCodeStatusImage = image
            }
            
            // 手机号输入视图
            noHintBarModel.phoneViewBackgroundColor = self.colorFromHexString("#4CFFFFFF")
            noHintBarModel.phoneTextFieldColor = .white
//            noHintBarModel.phoneTextFieldFont = OLVFontUtil.font(fromBundle: 26.0) // 字体建议不设置，SDK 会根据控件尺寸进行适配
            noHintBarModel.phoneTextFieldPlaceholder = "请输入您的手机号"
//            noHintBarModel.phoneTextFieldPlaceholderFont = UIFont.systemFont(ofSize: 15.0) // 字体建议不设置，SDK 会根据控件尺寸进行适配
            noHintBarModel.phoneTextFieldPlaceholderColor = .white
            noHintBarModel.phoneCursorColor = .white
            noHintBarModel.hintPhoneFormatError = "手机号格式不正确"
//            noHintBarModel.phoneFormatErrorHintFont = UIFont.systemFont(ofSize: 15.0) // 字体建议不设置，SDK 会根据控件尺寸进行适配
            noHintBarModel.phoneFormatErrorHintColor = self.colorFromHexString("#FF3300")
            
            // 滑动视图
            noHintBarModel.sliderViewBackgroundColor = self.colorFromHexString("#4C000000")
            noHintBarModel.sliderColor = self.colorFromHexString("#D9FA4900")
            noHintBarModel.sliderHintTextColor = .white
            if let image = UIImage.init(named: "") {        // 滑动背景图片
                noHintBarModel.sliderViewBackgroundImage = image
            }
            if let image = UIImage.init(named: "滑块") {        // 滑块图片
                noHintBarModel.sliderImage = image
            }
//            noHintBarModel.sliderHintTextFont = UIFont.systemFont(ofSize: 15) // 字体建议不设置，SDK 会根据控件尺寸进行适配
            noHintBarModel.sliderHint = "请拖动滑块"
            
            // 验证码视图
            noHintBarModel.smsCodeViewBackgroundColor = self.colorFromHexString("#4CFFFFFF")
            noHintBarModel.smsCodeTextColor = .white
            noHintBarModel.smsCodeCursorColor = .white
            noHintBarModel.smsCodeCountDownColor = .white
            noHintBarModel.smsCodeResendColor = .white
            noHintBarModel.smsCodeCount = 6 // 验证码位数，默认为 6
            noHintBarModel.smsCodeCountDownSeconds = 60 // 倒计时秒数，默认 60s
//            noHintBarModel.smsCodeTextFont = OLVFontUtil.font(fromBundle: 26.0) // 字体建议不设置，SDK 会根据控件尺寸进行适配
//            noHintBarModel.smsCodeCountDownFont = UIFont.systemFont(ofSize: 15.0) // 字体建议不设置，SDK 会根据控件尺寸进行适配
//            noHintBarModel.smsCodeResendFont = UIFont.systemFont(ofSize: 15.0) // 字体建议不设置，SDK 会根据控件尺寸进行适配
            noHintBarModel.smsCodePhoneFont = OLVFontUtil.font(fromBundle: 12.0) // 字体建议不设置，SDK 会根据控件尺寸进行适配
            noHintBarModel.smsCodePhoneColor = .white
            if let image = UIImage.init(named: "") {        // 关闭按钮图片
                noHintBarModel.smsCodeCloseImage = image
            }
        }
        
        self.opAuthView.configModel = noHintBarModel
        
        let size = OPAuthView.suggestedOPViewSize(noHintBarModel)
        self.opAuthView.snp.makeConstraints({ (make) in
            make.left.equalTo(self.view).offset((UIScreen.main.bounds.size.width - size.width)/2.0)
            make.top.equalTo(self.view).offset(120)
            make.size.equalTo(size)
        })
    }
    
    // MARK: Verify
    
    func verifyPhoneFailed(_ phone: String) {
        self.sendSms(phone, completion: { [weak self] (successed) in
            guard let strongSelf = self else { return }
            
            strongSelf.opAuthView.setSendSmsCodeResult(successed)
        })
    }
}

extension OnePassViewViewController: OPAuthDelegate {
    func opAuthView(_ opAuthView: OPAuthView, didReceiveVerifyPhoneData data: [AnyHashable : Any], phone: String) {
        var params = data
        params["id_2_sign"] = GTOnePassCustomId
        
        Alamofire.request(GTOnePassResultURL, method: .post, parameters: params as? Parameters, encoding: JSONEncoding.default, headers: nil).response { (response) in
            if let error = response.error {
                print("validate token error: ", error)
                self.verifyPhoneFailed(phone)
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
                self.verifyPhoneFailed(phone)
            }
        }
    }
    
    func opAuthView(_ opAuthView: OPAuthView, didVerifyPhoneError error: GOPError, phone: String) {
        print("verify phone error: ", error)
        self.verifyPhoneFailed(phone)
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
