//
//  Animator.m
//  BAMMarketing
//
//  Created by Jeffry Turcios on 1/15/15.
//  Copyright (c) 2015 BAM. All rights reserved.
//

#import "Animator.h"

static NSTimeInterval const DEAnimatedTransitionDuration = 0.25f;
static NSTimeInterval const DEAnimatedTransitionMarcoDuration = 0.15f;

@implementation Animator

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *container = [transitionContext containerView];
    
    if (self.reverse) {
        [container insertSubview:toViewController.view belowSubview:fromViewController.view];
        fromViewController.view.transform = CGAffineTransformIdentity;
        fromViewController.view.alpha = 1;
    }
    else {
        toViewController.view.transform = CGAffineTransformMakeScale(2, 2);
        toViewController.view.alpha = 0;
        [container addSubview:toViewController.view];
    }
    
    [UIView animateKeyframesWithDuration:DEAnimatedTransitionDuration delay:0 options:0 animations:^{
        if (self.reverse) {
//            fromViewController.view.transform = CGAffineTransformMakeScale(0, 0);
            fromViewController.view.transform = CGAffineTransformMakeScale(2, 2);
            fromViewController.view.alpha = 0;
        }
        else {
            toViewController.view.transform = CGAffineTransformIdentity;
            toViewController.view.alpha = 1;
        }
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:finished];
    }];
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return DEAnimatedTransitionDuration;
}


@end
