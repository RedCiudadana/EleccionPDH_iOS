//
//  NoticiasController.m
//  EleccionesPDH
//
//  Created by Jeffry Turcios on 5/14/17.
//  Copyright © 2017 Codifay. All rights reserved.
//

#import "NoticiasController.h"
#import <TwitterKit/TwitterKit.h>
#import "TransitionDelegate.h"
#import "PrivateTransitionContext.h"
#import "PrivateAnimatedTransition.h"

@interface NoticiasController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *controlSC;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@end

@implementation NoticiasController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    UserTimelineController *userTimelineC = [self.storyboard instantiateViewControllerWithIdentifier:@"userTimeline"];
    SearchTimelineController *searchTimelineC = [self.storyboard instantiateViewControllerWithIdentifier:@"searchTimeline"];
    _viewControllers = @[
                         userTimelineC,
                         searchTimelineC
                         ];
    
    self.selectedViewController = (self.selectedViewController?:_viewControllers[_controlSC.selectedSegmentIndex]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)setSelectedViewController:(UIViewController *)selectedViewController{
    NSParameterAssert(selectedViewController);
    [self _transitionToChildViewController:selectedViewController];
    _selectedViewController = selectedViewController;
    //    if ([_selectedViewController isKindOfClass:[EventsViewController class]]) {
    //        [((EventsViewController*)_selectedViewController) updateUI];
    //    }
}

- (void)_transitionToChildViewController:(UIViewController *)toViewController {
    
    UIViewController *fromViewController = ([self.childViewControllers count] > 0 ? self.childViewControllers[0] : nil);
    if (toViewController == fromViewController || ![self isViewLoaded]) {
        return;
    }
    
    UIView *toView = toViewController.view;
    [toView setTranslatesAutoresizingMaskIntoConstraints:YES];
    toView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    toView.frame = self.containerView.bounds;
    
    [fromViewController willMoveToParentViewController:nil];
    [self addChildViewController:toViewController];
    
    // If this is the initial presentation, add the new child with no animation.
    if (!fromViewController) {
        [self.containerView addSubview:toViewController.view];
        [toViewController didMoveToParentViewController:self];
        return;
    }
    
    // Animate the transition by calling the animator with our private transition context.
    // Animate the transition by calling the animator with our private transition context. If we don't have a delegate, or if it doesn't return an animated transitioning object, we will use our own, private animator.
    
    id<UIViewControllerAnimatedTransitioning>animator = nil;
    if ([self.delegate respondsToSelector:@selector (containerViewController:animationControllerForTransitionFromViewController:toViewController:)]) {
        animator = [self.delegate containerViewController:self animationControllerForTransitionFromViewController:fromViewController toViewController:toViewController];
    }
    animator = (animator ?: [[PrivateAnimatedTransition alloc] init]);
    
    
    // Because of the nature of our view controller, with horizontally arranged buttons, we instantiate our private transition context with information about whether this is a left-to-right or right-to-left transition. The animator can use this information if it wants.
    NSUInteger fromIndex = [self.viewControllers indexOfObject:fromViewController];
    NSUInteger toIndex = [self.viewControllers indexOfObject:toViewController];
    PrivateTransitionContext *transitionContext = [[PrivateTransitionContext alloc] initWithFromViewController:fromViewController toViewController:toViewController goingRight:toIndex > fromIndex];
    
    transitionContext.animated = YES;
    transitionContext.interactive = NO;
    transitionContext.completionBlock = ^(BOOL didComplete) {
        [fromViewController.view removeFromSuperview];
        [fromViewController removeFromParentViewController];
        [toViewController didMoveToParentViewController:self];
        
        if ([animator respondsToSelector:@selector (animationEnded:)]) {
            [animator animationEnded:didComplete];
        }
        self.controlSC.userInteractionEnabled = YES;
    };
    
    self.controlSC.userInteractionEnabled = NO; // Prevent user tapping buttons mid-transition, messing up state
    [animator animateTransition:transitionContext];
}

- (IBAction)changeViewController:(id)sender {
    UIViewController *selectedViewController = _viewControllers[_controlSC.selectedSegmentIndex];
    NSLog(@"is here and the selectedViewcontroller is: %@", selectedViewController);
    self.selectedViewController = selectedViewController;
}


@end
