//
//  OLVViewMacro.h
//  OneLoginViewSDK
//
//  Created by 刘练 on 2020/2/10.
//  Copyright © 2020 geetest. All rights reserved.
//

#ifndef OLVViewMacro_h
#define OLVViewMacro_h

#import "OLVFontUtil.h"

#define OLVColorWithRGBHex(rgbValue) ([UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0])
#define OLVColorWithRGBHexAlpha(rgbValue, a) ([UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)])

#define OLVBarlowFont(fontSize) ([OLVFontUtil fontFromBundle:fontSize])
#define OLVBoldFont(fontSize) ([UIFont boldSystemFontOfSize:fontSize])
#define OLVFont(fontSize) ([UIFont systemFontOfSize:fontSize])

#define OLVScreenWidth (UIScreen.mainScreen.bounds.size.width < UIScreen.mainScreen.bounds.size.height ? UIScreen.mainScreen.bounds.size.width : UIScreen.mainScreen.bounds.size.height)
#define OLVScreenHeight (UIScreen.mainScreen.bounds.size.width < UIScreen.mainScreen.bounds.size.height ? UIScreen.mainScreen.bounds.size.height : UIScreen.mainScreen.bounds.size.width)

#define OLVScreenWidth_4_7Inch 375.0

#define OLVIsValidatePhone(phone) (!(phone.length > 0 && ![[phone substringToIndex:1] isEqual:@"1"]))

#endif /* OLVViewMacro_h */
