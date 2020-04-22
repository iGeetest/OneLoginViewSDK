//
//  OPBaseView.h
//  OneLoginSDK
//
//  Created by 刘练 on 2020/2/10.
//  Copyright © 2020 geetest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OPViewConfigModel.h"
#import "OPViewWithHintBarModel.h"
#import "OPViewNoHintBarModel.h"

NS_ASSUME_NONNULL_BEGIN

extern NSInteger const OPNumberCount;

extern CGFloat const OPDefaultWidth;
extern CGFloat const OPDefaultHeight;
extern CGFloat const OPDefaultHintHeight;
extern CGFloat const OPDefaultVerifyHeight;
extern CGFloat const OPDefaultPhoneHeight;
extern CGFloat const OPDefaultStatusWidth;

extern NSString * const OPBar;

@interface OPTextField : UITextField

@end

@interface OPBaseView : UIView

@property (nonatomic, assign, readonly) BOOL hasHintBar;
@property (nonatomic, strong, readonly) OPViewWithHintBarModel *withHintBarModel;
@property (nonatomic, strong, readonly) OPViewNoHintBarModel *noHintBarModel;

@property (nonatomic, strong, nonnull) OPViewConfigModel *configModel;

- (instancetype)initWithFrame:(CGRect)frame configModel:(OPViewConfigModel * _Nonnull)configModel;

- (void)relayoutSubviews:(CGSize)size;

@end

NS_ASSUME_NONNULL_END
