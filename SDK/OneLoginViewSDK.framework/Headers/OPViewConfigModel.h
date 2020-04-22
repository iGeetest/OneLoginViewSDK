//
//  OPViewConfigModel.h
//  OneLoginSDK
//
//  Created by 刘练 on 2020/2/10.
//  Copyright © 2020 geetest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "OLVViewMacro.h"

NS_ASSUME_NONNULL_BEGIN

extern NSString * const OPHintSlideToVerifyString;
extern NSString * const OPHintPhoneFormatErrorString;

@interface OPViewConfigModel : NSObject

// MARK: Onepass

/**
 * OnePass 对应的 customId，该参数为必传参数，请到极验后台注册并获取该参数
 */
@property (nonatomic, copy, nonnull) NSString *customId;


// MARK: Verify View

/**
 * 除提示条外的验证视图背景色
 */
@property (nonatomic, strong) UIColor *verifyNormalBackgroundColor;

/**
 * 验证成功后，验证视图的背景色
 */
@property (nonatomic, strong) UIColor *verifySuccessedBackgroundColor;

// MARK: Status View

/**
 * 状态指示视图背景色
 */
@property (nonatomic, strong) UIColor *statusViewBackgroundColor;

/**
 * 输入手机号时，状态指示图标
 */
@property (nonatomic, strong) UIImage *inputingStatusImage;

/**
 * 滑条显示时，状态指示图标
 */
@property (nonatomic, strong) UIImage *slidingStatusImage;

/**
 * 验证手机号时，加载状态图标，可使用 gif 展示动画效果
 */
@property (nonatomic, strong) UIImage *loadingStatusImage;

/**
 * 输入短信验证码时，状态指示图标
 */
@property (nonatomic, strong) UIImage *sendingSmsCodeStatusImage;

/**
 * 验证手机号成功后，状态指示图标，可使用 gif 展示动画效果
 */
@property (nonatomic, strong) UIImage *successStatusImage;

// MARK: Phone View

/**
 * 手机号输入视图背景色
 */
@property (nonatomic, strong) UIColor *phoneViewBackgroundColor;

/**
 * 手机号输入 UITextField 对应的字体，不设置时，SDK 会根据整体控件大小进行适配
 */
@property (nonatomic, strong) UIFont *phoneTextFieldFont;

/**
 * 手机号输入 UITextField 对应的文字颜色
 */
@property (nonatomic, strong) UIColor *phoneTextFieldColor;

/**
 * 手机号输入 UITextField 对应的 placeholder
 */
@property (nonatomic, copy) NSString *phoneTextFieldPlaceholder;

/**
 * 手机号输入 UITextField 对应的 placeholder 的字体，不设置时，SDK 会根据整体控件大小进行适配
 */
@property (nonatomic, strong) UIFont *phoneTextFieldPlaceholderFont;

/**
 * 手机号输入 UITextField 对应的 placeholder 的文字颜色
 */
@property (nonatomic, strong) UIColor *phoneTextFieldPlaceholderColor;

/**
 * 手机号输入 UITextField 对应的光标的颜色
 */
@property (nonatomic, strong) UIColor *phoneCursorColor;

// MARK: Slider View

/**
 * 滑条视图背景色
 */
@property (nonatomic, strong) UIColor *sliderViewBackgroundColor;

/**
 * 滑条视图背景图片
 */
@property (nonatomic, strong) UIImage *sliderViewBackgroundImage;

/**
 * 滑条视图滑块图标
 */
@property (nonatomic, strong) UIImage *sliderImage;

/**
 * 滑条视图滑块滑动后滑过区域的背景色
 */
@property (nonatomic, strong) UIColor *sliderColor;

/**
 * 滑条视图提示文案，无提示条时，提示文案为手机号，该字段设置无效
 */
@property (nonatomic, copy) NSString *sliderHint;

/**
 * 滑条视图提示文案对应的字体，不设置时，SDK 会根据整体控件大小进行适配
 */
@property (nonatomic, strong) UIFont *sliderHintTextFont;

/**
 * 滑条视图提示文案的文字颜色
 */
@property (nonatomic, strong) UIColor *sliderHintTextColor;

// MARK: Result

/**
 * 手机号验证成功后，成功结果展示视图上展示的文案
 */
@property (nonatomic, strong) NSAttributedString *verifyPhoneSuccessedString;

/**
 * 手机号验证失败，短信验证成功后，成功结果展示视图上展示的文案
 */
@property (nonatomic, strong) NSAttributedString *verifySmsCodeSuccessedString;

// MARK: SmsCode View

/**
 * 短信验证码视图背景色
 */
@property (nonatomic, strong) UIColor *smsCodeViewBackgroundColor;

/**
 * 短信验证码输入 UITextField 对应的字体，不设置时，SDK 会根据整体控件大小进行适配
 */
@property (nonatomic, strong) UIFont *smsCodeTextFont;

/**
 * 短信验证码输入 UITextField 对应的文字颜色
 */
@property (nonatomic, strong) UIColor *smsCodeTextColor;

/**
 * 短信验证码输入 UITextField 对应的光标的颜色
 */
@property (nonatomic, strong) UIColor *smsCodeCursorColor;

/**
 * 短信验证码视图中倒计时文案的字体，不设置时，SDK 会根据整体控件大小进行适配
 */
@property (nonatomic, strong) UIFont *smsCodeCountDownFont;

/**
 * 短信验证码视图中倒计时文案的颜色
 */
@property (nonatomic, strong) UIColor *smsCodeCountDownColor;

/**
 * 短信验证码视图重新发送文案的字体，不设置时，SDK 会根据整体控件大小进行适配
 */
@property (nonatomic, strong) UIFont *smsCodeResendFont;

/**
 * 短信验证码视图中重新发送文案的颜色
 */
@property (nonatomic, strong) UIColor *smsCodeResendColor;

/**
 * 短信验证码倒计时秒数，默认 60s
 */
@property (nonatomic, assign) NSInteger smsCodeCountDownSeconds;

/**
 * 短信验证码的位数，默认为 6
 */
@property (nonatomic, assign) NSUInteger smsCodeCount;

@end

NS_ASSUME_NONNULL_END
