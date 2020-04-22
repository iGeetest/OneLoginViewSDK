//
//  OnePassView.h
//  OneLoginSDK
//
//  Created by 刘练 on 2020/2/10.
//  Copyright © 2020 geetest. All rights reserved.
//

#import "OPBaseView.h"

@class GOPError;

NS_ASSUME_NONNULL_BEGIN

@protocol OPAuthDelegate;

@interface OPAuthView : OPBaseView

/**
 * @abstract 验证 delegate
 */
@property (nonatomic, weak) id<OPAuthDelegate> delegate;

/**
 * @abstract 建议的视图尺寸
 *
 * @param configModel 配置 model
 *
 * @return 根据是否有提示条返回对应的视图建议尺寸
 */
+ (CGSize)suggestedOPViewSize:(OPViewConfigModel *)configModel;

/**
 * @abstract 视图初始化
 *
 * @param frame frame
 * @param configModel 视图配置
 *
 * @return OPAuthView
 */
- (instancetype)initWithFrame:(CGRect)frame configModel:(OPViewConfigModel * _Nonnull)configModel NS_DESIGNATED_INITIALIZER;

/**
 * @abstract 设置本机号码校验结果
 *
 * @param successed 是否校验成功
 *
 * @discussion 本机号码校验成功时，调用该方法，传 YES，控件会展示成功相关视图，本机号码校验失败时，若需使用 SDK 的短信验证功能，请调用您的短信发送接口，然后将短信发送结果通过 setSendSmsCodeResult: 方法将短信发送结果传给 SDK，
   若本机号码校验失败后不使用 SDK 的短信验证功能，您可以自行处理失败情况，并自行销毁掉该控件，SDK 不处理本机号码校验失败的情况
 *
 */
- (void)setVerifyPhoneResult:(BOOL)successed;

/**
 * @abstract 设置短信发送结果
 *
 * @param successed 短信是否发送成功，短信发送失败时，控件上会展示重新发送按钮，点击之后即可在 delegate 方法中重新调用短信发送接口
 *
 */
- (void)setSendSmsCodeResult:(BOOL)successed;

/**
 * @abstract 设置验证短信验证码的结果
 *
 * @param successed 短信验证成功，短信验证失败时，控件上会展示重新发送按钮，点击之后即可在 delegate 方法中重新调用短信发送接口
 *
 */
- (void)setVerifySmsCodeResult:(BOOL)successed;

/**
 * @abstract 设置重新发送短信验证码的结果
 *
 * @param successed 短信重新发送是否成功
 */
- (void)setResendSmsCodeResult:(BOOL)successed;

/**
 * @abstract 是否弹出键盘
 */
- (BOOL)becomeFirstResponder;

@end

@protocol OPAuthDelegate <NSObject>

/**
 * @abstract 验证手机号返回的数据，将该数据传到服务端进行校验是否为本机手机号
 *
 * @param opAuthView OPAuthView
 * @param data 验证手机号返回的数据
 * @param phone 进行验证的手机号
 *
 */
- (void)opAuthView:(OPAuthView *)opAuthView didReceiveVerifyPhoneData:(NSDictionary *)data phone:(NSString *)phone;

/**
 * @abstract 验证手机号错误
 *
 * @param opAuthView OPAuthView
 * @param error 验证手机号的错误信息
 * @param phone 进行验证的手机号
 *
 */
- (void)opAuthView:(OPAuthView *)opAuthView didVerifyPhoneError:(GOPError *)error phone:(NSString *)phone;

@optional

/**
 * @abstract 开始验证短信验证码
 *
 * @param opAuthView OPAuthView
 * @param smsCode 用户输入的短信验证码
 *
 */
- (void)opAuthView:(OPAuthView *)opAuthView didStartVerifySmsCode:(NSString *)smsCode;

/**
 * @abstract 重新发送短信验证码
 *
 * @param opAuthView OPAuthView
 * @param phone 进行验证的手机号
 *
 */
- (void)opAuthView:(OPAuthView *)opAuthView didResendSmsCode:(NSString *)phone;

@end

NS_ASSUME_NONNULL_END
