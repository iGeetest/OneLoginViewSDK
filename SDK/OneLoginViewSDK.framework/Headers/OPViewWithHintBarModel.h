//
//  OPViewWithHintBarModel.h
//  OneLoginSDK
//
//  Created by 刘练 on 2020/2/28.
//  Copyright © 2020 geetest. All rights reserved.
//

#import "OPViewConfigModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface OPViewWithHintBarModel : OPViewConfigModel

// MARK: Hint View

/**
 * 提示条视图背景色
 */
@property (nonatomic, strong) UIColor *hintNormalBackgroundColor;

/**
 * 验证错误时，提示条视图背景色
 */
@property (nonatomic, strong) UIColor *hintErrorBackgroundColor;

/**
 * 默认提示文字颜色
 */
@property (nonatomic, strong) UIColor *hintDefaultColor;

/**
 * 提示条左侧提示文字颜色
 */
@property (nonatomic, strong) UIColor *hintColor;

/**
 * 验证错误时，提示条左侧提示文字颜色
 */
@property (nonatomic, strong) UIColor *hintErrorColor;

/**
 * 提示条左侧提示文字字体，不设置时，SDK 会根据整体控件大小进行适配
 */
@property (nonatomic, strong) UIFont *hintFont;

/**
 *  提示条右侧手机号
 */
@property (nonatomic, copy) NSString *hintPhone;

/**
 * 提示条右侧手机号文字颜色
 */
@property (nonatomic, strong) UIColor *hintPhoneColor;

/**
 * 提示条右侧手机号文字字体，不设置时，SDK 会根据整体控件大小进行适配
 */
@property (nonatomic, strong) UIFont *hintPhoneFont;

/**
 * 手机号输入时，手机号格式错误时的提示文案
 */
@property (nonatomic, copy) NSString *hintPhoneFormatError;

/**
 * 手机号输入完之前，提示条提示文案
 */
@property (nonatomic, copy) NSString *hintDefault;

/**
 * 手机号输入完成，出现滑块，提示条刚出现时，提示条左侧提示文案
 */
@property (nonatomic, copy) NSString *hintVerifyPhone;

/**
 * 手机号验证失败，使用短信验证，短信已发送成功时，提示条左侧提示文案
 */
@property (nonatomic, copy) NSString *hintSmsCodeHasSended;

/**
 * 手机号验证失败，使用短信验证，短信发送失败时，提示条左侧提示文案
 */
@property (nonatomic, copy) NSString *hintSendSmsCodeError;

/**
 * 手机号验证失败，使用短信验证，短信验证失败时，提示条左侧提示文案
 */
@property (nonatomic, copy) NSString *hintVerifySmsCodeError;

///**
// * 手机号验证成功提示文案
// */
//@property (nonatomic, copy) NSString *hintVerifyPhoneSuccessed;
//
///**
// * 短信验证成功提示文案
// */
//@property (nonatomic, copy) NSString *hintVerifySmsCodeSuccessed;

/**
 * 提示条右侧关闭按钮对应的图标
 */
@property (nonatomic, strong) UIImage *hintCloseImage;

/**
 * 提示条右侧切换账号按钮对应的图标
 */
@property (nonatomic, strong) UIImage *hintSwitchImage;

@end

NS_ASSUME_NONNULL_END
