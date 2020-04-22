//
//  OLVAuthViewModel.h
//  OneLoginViewSDK
//
//  Created by 刘练 on 2020/4/14.
//  Copyright © 2020 liulian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OneLoginSDK/OneLoginSDK.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * @abstract 授权页面视图控件自动布局回调，可在该回调中，对控件通过 masonry 或者其他方式进行自动布局，若需要自定义视图，请直接在该回调中添加
 *
 * authView 为授权页面的根视图，为 authContentView 的父视图
 * authContentView 为 authBackButton、olAuthView、authAgreementView、authClosePopupButton 的父视图
 * authAgreementView 为 authCheckbox 和 authProtocolView 的父视图
 * isLandscape 是否为横屏
 * safeAreaInsets 刘海屏 SafeArea
 * authAgreementViewWidth 服务条款视图宽度
 * authAgreementViewHeight 服务条款视图高度
 */
typedef void(^OLVAuthVCAutoLayoutBlock)(UIView *authView, UIView *authContentView, UIView *authBackButton, UIView *olAuthView, UIView *authAgreementView, UIView *authCheckbox, UIView *authProtocolView, UIView *authClosePopupButton, BOOL isLandscape, UIEdgeInsets safeAreaInsets, CGFloat authAgreementViewWidth, CGFloat authAgreementViewHeight);

@interface OLVAuthViewModel : NSObject

// MARK: Status Bar/状态栏

/**
 状态栏样式。 默认 `UIStatusBarStyleDefault`。
 */
@property (nonatomic, assign) UIStatusBarStyle statusBarStyle;


// MARK: Background Image/授权页面背景图片

/**
 授权页背景颜色。默认白色。
 */
@property (nullable, nonatomic, strong) UIColor *backgroundColor;


// MARK: Back Button/返回按钮

/**
 授权页导航左边的返回按钮的图片。默认黑色系统样式返回图片。
 */
@property (nullable, nonatomic, strong) UIImage *naviBackImage;

/**
 返回按钮隐藏。默认不隐藏。
 */
@property (nonatomic, assign) BOOL backButtonHidden;

/**
 * 点击授权页面返回按钮的回调
 */
@property (nullable, nonatomic, copy) OLClickBackButtonBlock clickBackButtonBlock;


// MARK: CheckBox & Privacy Terms/隐私条款勾选框及隐私条款

/**
 授权页面上条款勾选框初始状态。默认 YES。
 */
@property (nonatomic, assign) BOOL defaultCheckBoxState;

/**
 授权页面上勾选框勾选的图标。默认为蓝色图标。推荐尺寸为12x12。
 */
@property (nullable, nonatomic, strong) UIImage *checkedImage;

/**
 授权页面上勾选框未勾选的图标。默认为白色图标。推荐尺寸为12x12。
 */
@property (nullable, nonatomic, strong) UIImage *uncheckedImage;

/**
 隐私条款文字属性。默认基础文字灰色, 条款蓝色高亮, 12pt。
 */
@property (nullable, nonatomic, strong) NSDictionary<NSAttributedStringKey, id> *privacyTermsAttributes;

/**
 额外的条款。默认为空。
 */
@property (nullable, nonatomic, strong) NSArray<OLPrivacyTermItem *> *additionalPrivacyTerms;

/**
 服务条款普通文字的颜色。默认灰色。
 */
@property (nullable, nonatomic, strong) UIColor *termTextColor;

/**
 除隐私条款外的其他文案，数组大小必须为4，元素依次为：条款前的文案、条款一和条款二连接符、条款二和条款三连接符，条款后的文案。
 默认为@[@"登录即同意", @"和", @"、", @"并使用本机号码登录"]
 */
@property (nullable, nonatomic, copy) NSArray<NSString *> *auxiliaryPrivacyWords;

/**
 * 点击授权页面隐私协议前勾选框的回调
 */
@property (nullable, nonatomic, copy) OLClickCheckboxBlock clickCheckboxBlock;

/**
 * 服务条款文案对齐方式，默认为NSTextAlignmentLeft
 */
@property (nonatomic, assign) NSTextAlignment termsAlignment;

/**
 * 点击授权页面运营商隐私协议的回调
 */
@property (nullable, nonatomic, copy) OLViewPrivacyTermItemBlock carrierTermItemBlock;

/**
 * 是否在运营商协议名称上加书名号《》
 */
@property (nonatomic, assign) BOOL hasQuotationMarkOnCarrierProtocol;


// MARK: WebViewController Navigation/服务条款页面导航栏

/**
 * 服务条款页面导航栏隐藏。默认不隐藏。
 */
@property (nonatomic, assign) BOOL webNaviHidden;

/**
 服务条款页面导航栏的标题，默认与协议名称保持一致，粗体、17pt。
 设置后，自定义协议的文案、颜色、字体都与设置的值保持一致，
 运营商协议的颜色、字体与设置的值保持一致，文案不变，与运营商协议名称保持一致。
 */
@property (nullable, nonatomic, strong) NSAttributedString *webNaviTitle;

/**
 * 服务条款页面导航的背景颜色。默认白色。
 */
@property (nullable, nonatomic, strong) UIColor *webNaviBgColor;


// MARK: orientation

/**
 * 授权页面支持的横竖屏方向
 */
@property (nonatomic, assign) UIInterfaceOrientationMask supportedInterfaceOrientations;


// MARK: Popup

/**
 * 是否为弹窗模式
 */
@property (nonatomic, assign) BOOL isPopup;

/**
 弹窗 位置及大小
 */
@property (nonatomic, assign) OLRect popupRect;

/**
 弹窗圆角，默认为6。
 */
@property (nonatomic, assign) CGFloat popupCornerRadius;

/**
 当只需要设置弹窗的部分圆角时，通过popupCornerRadius设置圆角大小，通过popupRectCorners设置需要设置圆角的位置。
 popupRectCorners数组元素不超过四个，超过四个时，只取前四个。比如，要设置左上和右上为圆角，则传值：@[@(UIRectCornerTopLeft), @(UIRectCornerTopRight)]
 */
@property (nonatomic, strong) NSArray<NSNumber *> *popupRectCorners;

/**
 * 弹窗动画类型，当popupAnimationStyle为OLAuthPopupAnimationStyleStyleCustom时，动画为用户自定义，用户需要传一个CATransition对象来设置动画
 */
@property (nonatomic, assign) OLAuthPopupAnimationStyle popupAnimationStyle;

/**
 * 弹窗自定义动画
 */
@property (nonatomic, strong) CAAnimation *popupTransitionAnimation;

/**
 弹窗关闭按钮图片，弹窗关闭按钮的尺寸跟图片尺寸保持一致。
 弹窗关闭按钮位于弹窗右上角，目前只支持设置其距顶部偏移和距右边偏移。
 */
@property (nullable, nonatomic, strong) UIImage *closePopupImage;

/**
 * 是否需要通过点击弹窗的背景区域以关闭授权页面。
 */
@property (nonatomic, assign) BOOL canClosePopupFromTapGesture;

/**
 * 点击授权页面弹窗背景的回调
 */
@property (nonatomic, copy, nullable) OLTapAuthBackgroundBlock tapAuthBackgroundBlock;


// MARK: OLAuthViewLifeCycleBlock

/**
 * 授权页面视图生命周期回调。
 */
@property (nullable, nonatomic, copy) OLAuthViewLifeCycleBlock viewLifeCycleBlock;

/**
 * 授权页面旋转时的回调，可在该回调中修改自定义视图的frame，以适应新的布局
 */
@property (nullable, nonatomic, copy) OLAuthVCTransitionBlock authVCTransitionBlock;


// MARK: Autolayout

/**
 * 授权页面视图控件自动布局回调
 */
@property (nonatomic, copy, nullable) OLVAuthVCAutoLayoutBlock autolayoutBlock;


// MARK: OLPullAuthVCStyle

/**
 * @abstract 进入授权页面的方式，默认为 modal 方式，即 present 到授权页面，从授权页面进入服务条款页面的方式与此保持一致
 */
@property (nonatomic, assign) OLPullAuthVCStyle pullAuthVCStyle;


// MARK: UIUserInterfaceStyle

/**
 * @abstract 授权页面 UIUserInterfaceStyle，iOS 12 及以上系统，默认为 UIUserInterfaceStyleLight
 *
 * UIUserInterfaceStyle
 * UIUserInterfaceStyleUnspecified - 不指定样式，跟随系统设置进行展示
 * UIUserInterfaceStyleLight       - 明亮
 * UIUserInterfaceStyleDark        - 暗黑 仅对 iOS 13+ 系统有效
 */
@property (nonatomic, strong) NSNumber *userInterfaceStyle;


// MARK: UIModalPresentationStyle

/**
 present授权页面时的样式，默认为UIModalPresentationFullScreen
 */
@property (nonatomic, assign) UIModalPresentationStyle modalPresentationStyle;

/**
 * present授权页面时的自定义动画
 */
@property (nonatomic, strong) CAAnimation *modalPresentationAnimation;

/**
 * dismiss授权页面时的自定义动画
 */
@property (nonatomic, strong) CAAnimation *modalDismissAnimation;

@end

NS_ASSUME_NONNULL_END
