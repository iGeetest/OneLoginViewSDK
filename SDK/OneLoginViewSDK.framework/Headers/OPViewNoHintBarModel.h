//
//  OPViewNoHintBarModel.h
//  OneLoginSDK
//
//  Created by 刘练 on 2020/2/28.
//  Copyright © 2020 geetest. All rights reserved.
//

#import "OPViewConfigModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface OPViewNoHintBarModel : OPViewConfigModel

// MARK: Verify View

/**
 * 无提示条时，短信验证失败后，验证视图背景色
 */
@property (nonatomic, strong) UIColor *verifySmsCodeFailedBackgroundColor;

/**
 * 无提示条时，输入的手机号格式错误时对应的验证视图背景色
 */
@property (nonatomic, strong) UIColor *phoneFormatErrorBackgroundColor;

// MARK: Phone View

/**
 * 无提示条时，手机号格式错误时的提示文案
 */
@property (nonatomic, copy) NSString *hintPhoneFormatError;

/**
 * 无提示条时，输入的手机号格式错误时对应的提示文字字体，不设置时，SDK 会根据整体控件大小进行适配
 */
@property (nonatomic, strong) UIFont *phoneFormatErrorHintFont;

/**
 * 无提示条时，输入的手机号格式错误时对应的提示文字颜色
 */
@property (nonatomic, strong) UIColor *phoneFormatErrorHintColor;

// MARK: SmsCode View

/**
 * 无提示条时，短信验证码视图中手机号文字的字体，不设置时，SDK 会根据整体控件大小进行适配
 */
@property (nonatomic, strong) UIFont *smsCodePhoneFont;

/**
 * 无提示条时，短信验证码视图中手机号文字的颜色
 */
@property (nonatomic, strong) UIColor *smsCodePhoneColor;

/**
 * 无提示条时，短信验证码视图关闭按钮对应的图标
 */
@property (nonatomic, strong) UIImage *smsCodeCloseImage;

@end

NS_ASSUME_NONNULL_END
