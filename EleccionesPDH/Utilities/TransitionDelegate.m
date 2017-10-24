//
//  TransitionDelegate.m
//  BAMMarketing
//
//  Created by Jeffry Turcios on 1/15/15.
//  Copyright (c) 2015 BAM. All rights reserved.
//

#import "TransitionDelegate.h"
#import "Animator.h"


@implementation TransitionDelegate

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    NSLog(@"TransitionDelegate presentingController");
    Animator *transitioning = [Animator new];
    return transitioning;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    NSLog(@"TransitionDelegate dismissingController");
    Animator *transitioning = [Animator new];
    transitioning.reverse = YES;
    return transitioning;
}

@end
