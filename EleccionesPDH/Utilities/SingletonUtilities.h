//
//  SingletonUtilities.h
//  JusticiaAbierta
//
//  Created by Jeffry Turcios on 5/8/17.
//  Copyright © 2017 Codifay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, NavBarType){
    TRANSPARENT,
    SOLID,
};

typedef NS_ENUM(NSInteger, Color) {
    MAIN_COLOR,
    ALT_COLOR,
    LIGHT_GRAY,
    GRAY
};

@interface SingletonUtilities : NSObject

+ (SingletonUtilities *)sharedInstance;

- (UIColor *)colorWithName:(Color)name alpha:(CGFloat)alpha;

@end
