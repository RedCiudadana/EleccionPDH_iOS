//
//  SingletonUtilities.m
//  JusticiaAbierta
//
//  Created by Jeffry Turcios on 5/8/17.
//  Copyright © 2017 Codifay. All rights reserved.
//

#import "SingletonUtilities.h"

@implementation SingletonUtilities

+ (SingletonUtilities *)sharedInstance{
    static SingletonUtilities *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

- (UIColor *)colorWithName:(Color)name alpha:(CGFloat)alpha{
    switch (name) {
        case MAIN_COLOR:
            return [UIColor colorWithRed:0/255.0f green:166/255.0f blue:169/255.0 alpha:alpha];
        case ALT_COLOR:
            return [UIColor colorWithRed:62/255.0f green:213/255.0f blue:251/255.0 alpha:alpha];
        case LIGHT_GRAY:
            return [UIColor colorWithRed:245/255.0F green:255/255.0f blue:243/255.0 alpha:alpha];
        case GRAY:
            return [UIColor colorWithRed:200/255.0F green:200/255.0f blue:200/255.0 alpha:alpha];
        default:
            break;
    }
    return [UIColor whiteColor];
}


@end
