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

@end
