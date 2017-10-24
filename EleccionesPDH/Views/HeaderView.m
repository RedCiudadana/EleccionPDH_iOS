//
//  HeaderView.m
//  EleccionPDH
//
//  Created by Jeffry Turcios on 5/16/17.
//  Copyright © 2017 Codifay. All rights reserved.
//

#import "HeaderView.h"

@implementation HeaderView{
    NSLayoutConstraint *heightLayoutConstraint;
    NSLayoutConstraint *bottomLayoutConstraint;
    UIView *containerView;
    NSLayoutConstraint *containerLayoutConstraint;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        containerView = [[UIView alloc] init];
        self.backgroundColor = [UIColor whiteColor];
        containerView.translatesAutoresizingMaskIntoConstraints = NO;
        containerView.backgroundColor = [UIColor redColor];
        [self addSubview:containerView];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[containerView]|"
                                                                     options:NSLayoutFormatAlignAllTop
                                                                     metrics:nil
                                                                       views:@{@"containerView":containerView}]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[containerView]|"
                                                                     options:NSLayoutFormatAlignAllTop
                                                                     metrics:nil
                                                                       views:@{@"containerView":containerView}]];

        containerLayoutConstraint = [NSLayoutConstraint constraintWithItem:containerView
                                                                 attribute:NSLayoutAttributeHeight
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self
                                                                 attribute:NSLayoutAttributeHeight
                                                                multiplier:1.0
                                                                  constant:0.0];
        [self addConstraint:containerLayoutConstraint];
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.translatesAutoresizingMaskIntoConstraints = NO;
        imageView.backgroundColor = [UIColor whiteColor];
        imageView.clipsToBounds = NO;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.image = [UIImage imageNamed:@"table_header"];
        [containerView addSubview:imageView];
        [containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[imageView]|"
                                                                              options:NSLayoutFormatAlignAllTop
                                                                              metrics:nil
                                                                                views:@{@"imageView":imageView}]];
        bottomLayoutConstraint = [NSLayoutConstraint constraintWithItem:imageView
                                                              attribute:NSLayoutAttributeBottom
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:containerView
                                                              attribute:NSLayoutAttributeBottom
                                                             multiplier:1.0
                                                               constant:0.0];
        [containerView addConstraint:bottomLayoutConstraint];
        heightLayoutConstraint = [NSLayoutConstraint constraintWithItem:imageView
                                                              attribute:NSLayoutAttributeHeight
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:containerView
                                                              attribute:NSLayoutAttributeHeight
                                                             multiplier:1.0
                                                               constant:0.0];
        [containerView addConstraint:heightLayoutConstraint];
    }
    return self;
}

- (void)scrollViewDidScroll:(UIScrollView*)scrollView{
    NSLog(@"headerView: scrollViewDidScroll");
    containerLayoutConstraint.constant = scrollView.contentInset.top;
    CGFloat offsetY = -(scrollView.contentOffset.y + scrollView.contentInset.top);
    containerView.clipsToBounds = offsetY <= 0;
    bottomLayoutConstraint.constant = offsetY >= 0 ? 0 : -offsetY / 2;
    heightLayoutConstraint.constant = MAX(offsetY + scrollView.contentInset.top, scrollView.contentInset.top);
}

@end
