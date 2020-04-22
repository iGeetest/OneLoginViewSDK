//
//  OLViewConfigModel.h
//  OneIsAllViewSDK
//
//  Created by 刘练 on 2020/4/1.
//  Copyright © 2020 liulian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OPViewWithHintBarModel.h"
#import "OLVAuthViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface OLViewConfigModel : NSObject

@property (nonatomic, strong, nullable) OPViewWithHintBarModel *withHintBarModel;
@property (nonatomic, strong, nullable) OLVAuthViewModel *authViewModel;

@end

NS_ASSUME_NONNULL_END
