//
//  BBFilterView.m
//  BBFeed
//
//  Created by Görkem Karahan on 08/01/2017.
//  Copyright © 2017 BB. All rights reserved.
//

#import "BBFilterView.h"

@interface BBFilterView()

@end

@implementation BBFilterView

- (void)prepareViewForFilter:(BBFilter *)filter {
    self.lblTitle.text = [filter.title capitalizedString];
    self.lblSubtitle.text = filter.subtitle;
    self.imgVFilter.image = [UIImage imageNamed:filter.imageName];
}

- (void)switchToSmallState {
    [self layoutIfNeeded];
    self.cnstrntSubtitleBottomVerticalSpace.constant = 10;
    self.viewState = BBFilterViewStateSmall;
    [UIView animateWithDuration:0.4f animations:^{
        [self layoutIfNeeded];
    }];
}

- (void)switchToNormalState {
    [self layoutIfNeeded];
    self.viewState = BBFilterViewStateNormal;
    self.cnstrntSubtitleBottomVerticalSpace.constant = 20;
    [UIView animateWithDuration:0.4f animations:^{
        [self layoutIfNeeded];
    }];
}

- (void)enableShadowAnimated:(BOOL)animated {

    if (animated) {
        CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"shadowOpacity"];
        anim.fromValue = [NSNumber numberWithFloat:0.0];
        anim.toValue = [NSNumber numberWithFloat:1.0];
        anim.duration = 0.4f;
        [self.layer addAnimation:anim forKey:@"shadowOpacity"];
        self.layer.shadowOpacity = 1.0;
    }
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(20, 0, self.frame.size.width - 40, self.frame.size.height)];
    self.layer.shadowColor = [UIColor colorWithRed:51.0/255.0f green:51.0/255.0f blue:51.0/255.0f alpha:0.5f].CGColor;
    
    self.layer.shadowOffset = CGSizeMake(0, 10);
    self.layer.shadowPath = path.CGPath;
    self.layer.shadowRadius = 10.0f;
    
}

- (void)disableShadowAnimated:(BOOL)animated {
    
    if (self.layer.shadowOpacity > 0) {
        if (animated) {
            CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"shadowOpacity"];
            anim.fromValue = [NSNumber numberWithFloat:1.0];
            anim.toValue = [NSNumber numberWithFloat:0.0];
            anim.duration = 0.4f;
            [self.layer addAnimation:anim forKey:@"shadowOpacity"];
        }
        self.layer.shadowOpacity = 0.0;
    }
}

@end
