//
//  SwiftLoginViewViewController.swift
//  OneLoginExample
//
//  Created by 刘练 on 2020/4/17.
//  Copyright © 2020 geetest. All rights reserved.
//

import UIKit
import OneLoginViewSDK
import MediaPlayer
import Alamofire
import SnapKit

struct ValidateTokenResult: Codable {
    var status: Int
    var result: String?
}

class MainViewController: BaseViewController {
    
    @IBOutlet weak var oneloginViewButton: UIButton!
    @IBOutlet weak var popupOneloginViewButton: UIButton!
    @IBOutlet weak var onepassViewHintBarButton: UIButton!
    @IBOutlet weak var onepassViewNoHintBarButton: UIButton!
    @IBOutlet weak var onepassViewInXibButton: UIButton!
        
    private var player: AVPlayer?
    private var playerLayer: AVPlayerLayer?
    
    // MARK: deinit
    
    deinit {
        self.player = nil
        self.playerLayer = nil
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: ViewLifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "OneLoginViewSDK"
        
        self.oneloginViewButton.layer.masksToBounds = true
        self.oneloginViewButton.layer.cornerRadius = 5
        
        self.popupOneloginViewButton.layer.masksToBounds = true
        self.popupOneloginViewButton.layer.cornerRadius = 5
        
        self.onepassViewHintBarButton.layer.masksToBounds = true
        self.onepassViewHintBarButton.layer.cornerRadius = 5
        
        self.onepassViewNoHintBarButton.layer.masksToBounds = true
        self.onepassViewNoHintBarButton.layer.cornerRadius = 5
        
        self.onepassViewInXibButton.layer.masksToBounds = true
        self.onepassViewInXibButton.layer.cornerRadius = 5
        
        // OneLoginViewSDK 初始化
        OLVManager.setLogEnabled(true)
        OLVManager.register(withAppID: GTOneLoginAppId)
        OLVManager.setDelegate(self)
    }
    
    // MARK: Actions
    
    @IBAction func oneloginViewAction(_ sender: UIButton) {
        // OneLoginView 配置
        let viewConfigModel = OLViewConfigModel.init()
        
        // 授权页面配置
        let authViewModel = OLVAuthViewModel.init()
        
        // push 方式进入授权页面
        authViewModel.pullAuthVCStyle = .push
        // 横竖屏配置
        authViewModel.supportedInterfaceOrientations = .allButUpsideDown
        // 黑夜模式适配
        if #available(iOS 12.0, *) {
            authViewModel.userInterfaceStyle = NSNumber.init(value: UIUserInterfaceStyle.unspecified.rawValue)
        }
        // 授权页面生命周期回调
        authViewModel.viewLifeCycleBlock = { (viewLifeCycle, animated) in
            print("view life cycle: ", viewLifeCycle)
            // 进入授权页面时，隐藏加载进度条
            if viewLifeCycle == "viewDidLoad" {
                GTProgressHUD.hideAllHUD()
            }
        }
        // 服务条款配置，授权页面默认带运营商服务条款，若想添加自定义服务条款，可通过如下方法配置
        if let url1 = URL.init(string: "https://docs.geetest.com/"), let url2 = URL.init(string: "https://docs.geetest.com/start") {
            let item1 = OLPrivacyTermItem.init(title: "极验服务条款1", linkURL:url1, index: 0)
            let item2 = OLPrivacyTermItem.init(title: "极验服务条款2", linkURL:url2, index: 0)
            // 服务条款也可以跳转到您自己的页面进行展示
            if let url3 = URL.init(string: "https://docs.geetest.com/onelogin/deploy/server") {
                let item3 = OLPrivacyTermItem.init(title: "极验服务条款3", linkURL: url3, index: 0) { (item, controller) in
                    // 跳转到您自己的页面展示服务条款
                    
                }
                authViewModel.additionalPrivacyTerms = [item1, item2, item3]
            }
        }
        // 设置服务条款外字符
        authViewModel.auxiliaryPrivacyWords = ["登录表示同意", "和", "、", "且使用本机号码登录"]
        // 屏幕旋转回调
        authViewModel.authVCTransitionBlock = { (size, coordinator, customAreaView) in
            // 背景视图横竖屏旋转适配
            if let playerLayer = self.playerLayer {
                playerLayer.frame = CGRect.init(x: playerLayer.frame.origin.x, y: playerLayer.frame.origin.y, width: size.width, height: size.height)
            }
            
            if size.width > size.height {   // 横屏
                
            } else {                        // 竖屏
                
            }
        }
        // autolayout，对授权页面中的控件进行自动布局，插入您需要的自定义控件
        authViewModel.autolayoutBlock = { (authView, authContentView, authBackButton, olAuthView, authAgreementView, authCheckbox, authProtocolView, authClosePopupButton, isLandscape, safeAreaInsets, authAgreementViewWidth, authAgreementViewHeight) in
            // 若要兼容横竖屏切换状态，请使用 remakeConstraints 来进行约束，若不需要横竖屏切换，直接使用 makeConstraints 即可
            authContentView.snp.remakeConstraints { (make) in
                make.edges.equalTo(authView)
            }
            
            authBackButton.snp.remakeConstraints { (make) in
                make.left.equalTo(authContentView).offset(isLandscape && safeAreaInsets.bottom > 0 ? 56 : 12)
                make.top.equalTo(authContentView).offset(isLandscape ? 10 : safeAreaInsets.top > 0 ? (safeAreaInsets.top + 10) : 30)
            }
            
            let olAuthViewSize = olAuthView.bounds.size
            olAuthView.snp.remakeConstraints { (make) in
                make.center.equalTo(authContentView)
                make.size.equalTo(olAuthViewSize)
            }
            
            authAgreementView.snp.remakeConstraints { (make) in
                make.centerX.equalTo(authContentView)
                make.bottom.equalTo(authContentView).offset(-15)
                make.size.equalTo(CGSize.init(width: authAgreementViewWidth, height: authAgreementViewHeight))
            }
            
            let authCheckboxSize = authCheckbox.bounds.size
            authCheckbox.snp.remakeConstraints { (make) in
                make.left.equalTo(authAgreementView)
                make.top.equalTo(authAgreementView).offset(1)
                make.size.equalTo(authCheckboxSize)
            }
            
            authProtocolView.snp.remakeConstraints { (make) in
                make.left.equalTo(authCheckbox.snp_right).offset(2)
                make.top.right.bottom.equalTo(authAgreementView)
            }
            
            // 添加自定义 logo
            var appLogo = authContentView.viewWithTag(1000)
            if nil == appLogo {
                appLogo = UIImageView.init(image: UIImage.init(named: "OneLogin-logo"))
                if let appLogo = appLogo {
                    appLogo.tag = 1000
                    authContentView.addSubview(appLogo)
                }
            }
            if let appLogo = appLogo {
                appLogo.snp.remakeConstraints { (make) in
                    make.centerX.equalTo(authContentView)
                    make.bottom.equalTo(olAuthView.snp_top).offset(isLandscape ? -20 : -50)
                }
            }
            
            // 添加自定义 slogan
            var sloganLabel: UILabel? = authContentView.viewWithTag(1001) as? UILabel
            if nil == sloganLabel {
                sloganLabel = UILabel.init()
                if let sloganLabel = sloganLabel {
                    sloganLabel.tag = 1001
                    sloganLabel.backgroundColor = .clear
                    sloganLabel.textAlignment = .center
                    sloganLabel.font = UIFont.systemFont(ofSize: 12)
                    sloganLabel.textColor = UIColor.init(red: (0x85)/255.0, green: (0x8A)/255.0, blue: (0xB4)/255.0, alpha: 1)
                    authContentView.addSubview(sloganLabel)
                }
            }
            if let sloganLabel = sloganLabel {
                if isLandscape {
                    sloganLabel.snp.remakeConstraints({ (make) in
                        make.centerX.equalTo(authContentView)
                        make.top.equalTo(authAgreementView.snp_bottom).offset(-2)
                    })
                } else {
                    sloganLabel.snp.remakeConstraints { (make) in
                        make.centerX.equalTo(authContentView)
                        make.bottom.equalTo(authAgreementView.snp_top).offset(-30)
                    }
                }
                
                let networkInfo = OLVManager.currentNetworkInfo()
                if OLCM == networkInfo?.carrierName {
                    sloganLabel.text = "中国移动提供认证服务"
                } else if OLCU == networkInfo?.carrierName {
                    sloganLabel.text = "中国联通提供认证服务"
                } else if OLCT == networkInfo?.carrierName {
                    sloganLabel.text = "中国电信提供认证服务"
                }
            }
            
            // 添加其他登录方式
            var otherLoginLabel: UILabel? = authContentView.viewWithTag(1002) as? UILabel
            if nil == otherLoginLabel {
                otherLoginLabel = UILabel.init()
                if let otherLoginLabel = otherLoginLabel {
                    otherLoginLabel.tag = 1002
                    otherLoginLabel.backgroundColor = .clear
                    otherLoginLabel.textAlignment = .center
                    otherLoginLabel.font = UIFont.systemFont(ofSize: 15)
                    otherLoginLabel.textColor = UIColor.init(red: (0x85)/255.0, green: (0x8A)/255.0, blue: (0xB4)/255.0, alpha: 1)
                    otherLoginLabel.text = "其他登录方式"
                    authContentView.addSubview(otherLoginLabel)
                }
            }
            if let otherLoginLabel = otherLoginLabel {
                otherLoginLabel.snp.remakeConstraints { (make) in
                    make.centerX.equalTo(authContentView);
                    make.top.equalTo(olAuthView.snp_bottom).offset(isLandscape ? 5 : 20)
                }
            }
            
            var qqButton: UIButton? = authContentView.viewWithTag(100) as? UIButton
            if nil == qqButton {
                qqButton = UIButton.init(type: UIButton.ButtonType.custom)
                if let qqButton = qqButton {
                    qqButton.tag = 100
                    qqButton.setImage(UIImage.init(named: "qq_icon"), for: UIControl.State.normal)
                    qqButton.addTarget(self, action: #selector(self.otherLoginAction), for: UIControl.Event.touchUpInside)
                    authContentView.addSubview(qqButton)
                }
            }
            if let qqButton = qqButton, let otherLoginLabel = otherLoginLabel {
                qqButton.snp.remakeConstraints { (make) in
                    make.right.equalTo(authContentView.snp_centerX).offset(-20)
                    make.top.equalTo(otherLoginLabel.snp_bottom).offset(isLandscape ? 5 : 10)
                }
            }
            
            var weixinButton: UIButton? = authContentView.viewWithTag(101) as? UIButton
            if nil == weixinButton {
                weixinButton = UIButton.init(type: UIButton.ButtonType.custom)
                if let weixinButton = weixinButton {
                    weixinButton.tag = 101
                    weixinButton.setImage(UIImage.init(named: "weixin_icon"), for: UIControl.State.normal)
                    weixinButton.addTarget(self, action: #selector(self.otherLoginAction), for: UIControl.Event.touchUpInside)
                    authContentView.addSubview(weixinButton)
                }
            }
            if let weixinButton = weixinButton, let qqButton = qqButton {
                weixinButton.snp.remakeConstraints { (make) in
                    make.left.equalTo(authContentView.snp_centerX).offset(20)
                    make.centerY.equalTo(qqButton)
                }
            }
            
            // 插入自定义背景
            let playerView: UIView? = authContentView.viewWithTag(1003)
            if let playerView = playerView, let playerLayer = self.playerLayer {
                playerView.snp.remakeConstraints { (make) in
                    make.edges.equalTo(authContentView)
                }
                
                playerLayer.frame = playerView.bounds
            } else {
                if let path = Bundle.main.path(forResource: "auth_vc_bg", ofType: "mp4") {
                    let url = URL.init(fileURLWithPath: path)
                    let playerItem = AVPlayerItem.init(url: url)
                    self.player = AVPlayer.init(playerItem: playerItem)
                    if let player = self.player {
                        self.playerLayer = AVPlayerLayer.init(player: player)
                        if let playerLayer = self.playerLayer {
                            playerLayer.videoGravity = .resize
                            
                            let playerView = UIView.init()
                            playerView.tag = 1003
                            playerView.frame = UIScreen.main.bounds
                            playerView.backgroundColor = .white
                            playerView.alpha = 0.5
                            authContentView.addSubview(playerView)
                            authContentView.sendSubviewToBack(playerView)
                            playerView.snp.makeConstraints { (make) in
                                make.edges.equalTo(authContentView)
                            }
                            
                            playerView.layer.addSublayer(playerLayer)
                            playerLayer.frame = playerView.bounds
                            
                            player.play()
                            
                            NotificationCenter.default.addObserver(self, selector: #selector(self.didReceiveAVPlayerItemDidPlayToEndTimeNotification(_:)), name: .AVPlayerItemDidPlayToEndTime, object: nil)
                            NotificationCenter.default.addObserver(self, selector: #selector(self.didReceiveBecomeActiveNotification(_:)), name: UIApplication.didBecomeActiveNotification, object: nil)
                        }
                    }
                }
            }
        }
        
        viewConfigModel.authViewModel = authViewModel
        
        // 授权页面 OnePassView 配置
        let withHintBarModel = OPViewWithHintBarModel.init()
        // OnePassView 配置可参考 OnePassViewViewController.swift -> setupOnePassViewWithHintBar 方法中的配置
        viewConfigModel.withHintBarModel = withHintBarModel
        
        // 进入授权页面之前，加载进度条，因为此时可能预取号还未成功，需要先等待预取号成功后才会拉起授权页面
        GTProgressHUD.showLoadingHUD(withMessage: nil)
        OLVManager.requestToken(with: self, viewConfigModel: viewConfigModel) { [unowned self] result in
            self.finishRequsetingToken(result: result)
        }
    }
    
    @IBAction func popupOneloginViewAction(_ sender: UIButton) {
        // OneLoginView 配置
        let viewConfigModel = OLViewConfigModel.init()
        
        // 授权页面配置
        let authViewModel = OLVAuthViewModel.init()
        
        // modal 方式进入授权页面，弹窗模式时，请不要使用 push 方式
        authViewModel.pullAuthVCStyle = .modal
        // 横竖屏配置
        authViewModel.supportedInterfaceOrientations = .allButUpsideDown
        // 黑夜模式适配
        if #available(iOS 12.0, *) {
            authViewModel.userInterfaceStyle = NSNumber.init(value: UIUserInterfaceStyle.unspecified.rawValue)
        }
        // 授权页面生命周期回调
        authViewModel.viewLifeCycleBlock = { (viewLifeCycle, animated) in
            print("view life cycle: ", viewLifeCycle)
            // 进入授权页面时，隐藏加载进度条
            if viewLifeCycle == "viewDidLoad" {
                GTProgressHUD.hideAllHUD()
            }
        }
        // 设置弹窗模式
        authViewModel.isPopup = true
        // 点击空白处可关闭弹窗
        authViewModel.canClosePopupFromTapGesture = true
        
        viewConfigModel.authViewModel = authViewModel
        
        // 进入授权页面之前，加载进度条，因为此时可能预取号还未成功，需要先等待预取号成功后才会拉起授权页面
        GTProgressHUD.showLoadingHUD(withMessage: nil)
        // 弹窗模式时，controller 请传 navigationController
        OLVManager.requestToken(with: self.navigationController, viewConfigModel: viewConfigModel) { [unowned self] result in
            self.finishRequsetingToken(result: result)
        }
    }
    
    @IBAction func onepassHintBarViewAction(_ sender: UIButton) {
        // 使用带提示条的 OnePassView
        let onepassviewViewController = OnePassViewViewController.init()
        onepassviewViewController.hasHintBar = true
        self.navigationController?.pushViewController(onepassviewViewController, animated: true)
    }
    
    @IBAction func onepassNoHintBarViewAction(_ sender: UIButton) {
        // 使用不带提示条的 OnePassView
        let onepassviewViewController = OnePassViewViewController.init()
        self.navigationController?.pushViewController(onepassviewViewController, animated: true)
    }
    
    @IBAction func onepassViewInXibAction(_ sender: UIButton) {
        // xib 中使用 OnePassView
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        let controller = storyboard.instantiateViewController(withIdentifier: "OnePassViewXibViewController")
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func otherLoginAction(_ sender: UIButton) {
        if 100 == sender.tag {
            GTProgressHUD.showToast(withMessage: "qq登录")
        } else if 101 == sender.tag {
            GTProgressHUD.showToast(withMessage: "微信登录")
        }
        
        OLVManager.dismissAuthViewController {
            
        }
    }
    
    // MARK: AVPlayer
    
    @objc func didReceiveAVPlayerItemDidPlayToEndTimeNotification(_ noti: Notification) {
        if let player = self.player {
            let time = CMTime.init(value: 0, timescale: 1)
            player.seek(to: time)
            player.play()
        }
    }
    
    @objc func didReceiveBecomeActiveNotification(_ noti: Notification) {
        if let player = self.player {
            player.play()
        }
    }
    
    // MARK: Validate Token
    
    func finishRequsetingToken(result: Dictionary<AnyHashable, Any>?) {
        if let result = result, let status = result["status"], 200 == (status as! NSNumber).intValue {
            let token = result["token"] as! String
            let appID = result["appID"] as! String
            let processID = result["processID"] as! String
            var authcode: String? = nil
            if nil != result["authcode"] {
                authcode = result["authcode"] as? String
            }
            self.validateToken(token: token, appId: appID, processID: processID, authcode: authcode)
        } else {
            OLVManager.setVerifyPhoneResult(false)
        }
    }
    
    func validateToken(token: String?, appId: String?, processID: String?, authcode: String?) {
        var params = Dictionary<String, Any>.init()
        if let token = token {
            params["token"] = token
        }
        if let processID = processID {
            params["process_id"] = processID
        }
        if let appId = appId {
            params["id_2_sign"] = appId
        }
        if let authcode = authcode {
            params["authcode"] = authcode
        }
        
        Alamofire.request(GTOneLoginResultURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).response { (response) in
            if let error = response.error {
                print("validate token error: ", error)
                self.finishValidatingToken(result: nil, error: error)
                return
            }
            
            var validateTokenResult: ValidateTokenResult?
            if let data = response.data {
                do {
                    validateTokenResult = try JSONDecoder().decode(ValidateTokenResult.self, from: data)
                } catch {
                    
                }
            }
            
            self.finishValidatingToken(result: validateTokenResult, error: response.error)
        }
    }
    
    func finishValidatingToken(result: ValidateTokenResult?, error: Error?) {
        print("validateToken result: , error: ", (nil != result) ? result! : "", (nil != error) ? error! : "")
        DispatchQueue.main.async {
            GTProgressHUD.hideAllHUD()
            var successed = false
            if let result = result, 200 == result.status, let message = result.result {
                successed = true
                print("手机号为：", message)
            }
            
            if successed {
                OLVManager.renewPreGetToken()
                OLVManager.setVerifyPhoneResult(true)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    OLVManager.dismissAuthViewController {
                        
                    }
                }
            } else {
                GTProgressHUD.showToast(withMessage: "token验证失败")
                OLVManager.setVerifyPhoneResult(false)
            }
        }
    }
}

extension MainViewController: OLVManagerDelegate {
    func didSendSmsCode(_ phone: String) {
        self.sendSms(phone, completion: { (successed) in
            OLVManager.setSendSmsCodeResult(successed)
        })
    }
    
    func didStartVerifySmsCode(_ smsCode: String) {
        self.checkSms(smsCode) { (result) in
            switch result {
            case .success(let checkResult):
                print("check sms code result: ", checkResult)
                OLVManager.setVerifySmsCodeResult(true)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    OLVManager.dismissAuthViewController {
                        
                    }
                }
                
            case .failure(let error):
                print("check sms code error: ", error)
                OLVManager.setVerifySmsCodeResult(false)
                
            }
        }
    }
    
    func didResendSmsCode(_ phone: String) {
        self.sendSms(phone, completion: { (successed) in
            OLVManager.setResendSmsCodeResult(successed)
        })
    }
}
