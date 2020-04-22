//
//  OneIsAll.h
//  OneIsAllViewSDK
//
//  Created by 刘练 on 2020/4/2.
//  Copyright © 2020 liulian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OLViewConfigModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol OLVManagerDelegate;

@interface OLVManager : NSObject

/**
 获取当前 OneLogin 可用的网络信息
 
 @discussion
 当使用的是非移动、联通、电信三大运营商, 则返回nil。
 OneLogin 仅在大陆支持移动、联通、电信三大运营商。
 
 @seealso
 OLNetworkInfo 中有属性的详细描述
 */
+ (nullable OLNetworkInfo *)currentNetworkInfo;

/**
 向SDK注册AppID
 
 @discussion `AppID`通过后台注册获得，从极验后台获取该AppID，AppID需与bundleID配套

 @param appID 产品ID
 */
+ (void)registerWithAppID:(NSString * _Nonnull)appID;

/**
 设置请求超时时长。默认时长5s。

 @param timeout 超时时长
 */
+ (void)setRequestTimeout:(NSTimeInterval)timeout;

/**
 进行用户认证授权, 获取网关 token 。
 
 @discussion 调用限制说明
 
 为避免授权页面多次弹出, 在调用该方法后, 授权页面弹出, 再次调用该方法时,
 该方法会直接跳出, 不执行授权逻辑。
 
 @discussion 需要用户在弹出的页面上同意服务意条款后, 才会进行免密认证。

 @param viewController  present认证页面控制器的vc
 @param viewConfigModel 自定义授权页面的视图模型
 @param completion      结果处理回调
 
 @seealso OLAuthViewModel
 
 */
+ (void)requestTokenWithViewController:(nullable UIViewController *)viewController
                       viewConfigModel:(nullable OLViewConfigModel *)viewConfigModel
                            completion:(void(^)(NSDictionary * _Nullable result))completion;

/**
 * @abstract 重新预取号
 *
 * @discussion 在通过requestTokenWithCompletion方法成功登录之后，为保证用户在退出登录之后，能快速拉起授权页面，请在用户退出登录时，调用此方法
 */
+ (void)renewPreGetToken;

/**
 * @abstract 判断预取号结果是否有效
 *
 * @return YES: 预取号结果有效，可直接拉起授权页面 NO: 预取号结果无效，需加载进度条，等待预取号完成之后拉起授权页面
 */
+ (BOOL)isPreGetTokenResultValidate;

/**
 @abstract 关闭当前的授权页面
 
 @param animated 是否需要动画
 @param completion 关闭页面后的回调
 
 @discussion
 请不要使用其他方式关闭授权页面, 否则可能导致 OneLogin 无法再次调起
 */
+ (void)dismissAuthViewController:(BOOL)animated completion:(void (^ __nullable)(void))completion;
+ (void)dismissAuthViewController:(void (^ __nullable)(void))completion;

/**
 获取SDK版本号
 
 @return SDK当前的版本号
 */
+ (NSString *)sdkVersion;

/**
 * @abstract 自定义接口，自定义之后，SDK内部HTTP请求就会使用该自定义的接口
 *
 * @param URL 接口URL
 */
+ (void)customInterfaceURL:(const NSString * __nullable)URL;

/**
 * @abstract 设置是否允许打印日志
 *
 * @param enabled YES，允许打印日志 NO，禁止打印日志
 */
+ (void)setLogEnabled:(BOOL)enabled;

/**
 * @abstract 指示是否打印日志的状态
 *
 * @return YES，允许打印日志 NO，禁止打印日志
 */
+ (BOOL)isLogEnabled;

/**
 * @abstract 获取当前授权页面对应的配置
 *
 * @return 当前授权页面对应的配置
 */
+ (OLViewConfigModel * _Nullable)currentViewConfigModel;

/**
 * @abstract 获取当前授权页面对应的ViewController
 *
 * @return 当前授权页面对应的ViewController
 */
+ (UIViewController * _Nullable)currentAuthViewController;

/**
 * @abstract 设置获取 token/手机号 结果
 *
 * @param successed 是否获取 token/手机号 成功
 *
 * @discussion 获取 token/手机号 成功时，调用该方法，传 YES，控件会展示成功相关视图，获取 token/手机号 成功失败时，若需使用 SDK 的短信验证功能，调用该方法，传 NO，控件会展示手机号输入框，输入完手机号之后，请在 OLVManagerDelegate 的 didSendSmsCode: 方法中调用您的短信发送接口，然后将短信发送结果通过 setSendSmsCodeResult: 方法将短信发送结果传给 SDK
 *
 */
+ (void)setVerifyPhoneResult:(BOOL)successed;

/**
 * @abstract 设置短信发送结果
 *
 * @param successed 短信是否发送成功，短信发送失败时，控件上会展示重新发送按钮，点击之后即可在 delegate 方法中重新调用短信发送接口
 *
 */
+ (void)setSendSmsCodeResult:(BOOL)successed;

/**
 * @abstract 设置验证短信验证码的结果
 *
 * @param successed 短信验证成功，短信验证失败时，控件上会展示重新发送按钮，点击之后即可在 delegate 方法中重新调用短信发送接口
 *
 */
+ (void)setVerifySmsCodeResult:(BOOL)successed;

/**
 * @abstract 设置重新发送短信验证码的结果
 *
 * @param successed 短信重新发送是否成功
 */
+ (void)setResendSmsCodeResult:(BOOL)successed;

/**
 * @abstract 设置 delegate
 *
 * @param delegate 短信发送 delegate
 */
+ (void)setDelegate:(id<OLVManagerDelegate>)delegate;

@end

@protocol OLVManagerDelegate <NSObject>

@optional

/**
 * @abstract 发送短信验证码
 *
 * @param phone 进行验证的手机号
 *
 */
- (void)didSendSmsCode:(NSString *)phone;

/**
 * @abstract 开始验证短信验证码
 *
 * @param smsCode 用户输入的短信验证码
 *
 */
- (void)didStartVerifySmsCode:(NSString *)smsCode;

/**
 * @abstract 重新发送短信验证码
 *
 * @param phone 进行验证的手机号
 *
 */
- (void)didResendSmsCode:(NSString *)phone;

@end

NS_ASSUME_NONNULL_END
