//
//  AnimationController.m
//  BBFeed
//
//  Created by Görkem Karahan on 08/01/2017.
//  Copyright © 2017 BB. All rights reserved.
//

#import "AnimationController.h"

@interface AnimationController()
@property (nonatomic) CGFloat originalCornerRadiusOfImage;

@end

@implementation AnimationController

- (instancetype)init {
    if (self = [super init]) {
        self.presenting = YES;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.4f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIView *contrainerView = [transitionContext containerView];
    
    UIViewController *fromViewController = self.presenting ? [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey] : [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *toViewController = self.presenting ? [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey] : [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    
    CGSize targetFrameSize = toViewController.view.frame.size;
    
    
    //Creating from View Snapshot
    UIGraphicsBeginImageContext(fromViewController.view.bounds.size);
    [fromViewController.view drawViewHierarchyInRect:fromViewController.view.bounds afterScreenUpdates:NO];
    UIImage *fromViewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //Creating to View Snapshot
    UIGraphicsBeginImageContext(toViewController.view.bounds.size);
    [toViewController.view drawViewHierarchyInRect:toViewController.view.bounds afterScreenUpdates:YES];
    UIImage *toViewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //Creating Cropped Image to animate upwards
    UIGraphicsBeginImageContext(toViewController.view.bounds.size);
    [toViewImage drawAtPoint:CGPointMake(0, -200)];
    UIImage *croppedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    UIImageView *croppedImageView = [[UIImageView alloc] initWithImage:croppedImage];
    UIImageView *fromView = [[UIImageView alloc] initWithImage:fromViewImage];

    self.originalCornerRadiusOfImage = self.fromImage.layer.cornerRadius;
    UIImageView *newImageView = [[UIImageView alloc] initWithImage:_fromImage.image];
    newImageView.contentMode = UIViewContentModeScaleAspectFill;
    newImageView.layer.masksToBounds = YES;

    
    if (self.presenting) {
        newImageView.frame = self.originalFrameOfImage;
        newImageView.layer.cornerRadius = self.originalCornerRadiusOfImage;
        
        
        CGRect toFrame = CGRectMake(0, 0, targetFrameSize.width, 200);
        croppedImageView.frame = CGRectMake(0, 484, targetFrameSize.width, croppedImageView.frame.size.height);
        
        
        toViewController.view.hidden = YES;
        [contrainerView addSubview:toViewController.view];
        [contrainerView addSubview:fromView];
        [contrainerView addSubview:croppedImageView];
        [contrainerView addSubview:newImageView];

        [UIView animateWithDuration:([self transitionDuration:transitionContext]) delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            newImageView.frame = toFrame;
            croppedImageView.frame = CGRectMake(0, 200, targetFrameSize.width, croppedImageView.frame.size.height);
            fromView.alpha = 0;
        } completion:^(BOOL finished) {
            [newImageView removeFromSuperview];
            [fromViewController.view removeFromSuperview];
            [croppedImageView removeFromSuperview];
            [fromView removeFromSuperview];
            toViewController.view.hidden = NO;
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
        
    } else {
        
        newImageView.frame = CGRectMake(0, 0, targetFrameSize.width, 200);
        
        croppedImageView.frame = CGRectMake(0, 200, targetFrameSize.width, croppedImageView.frame.size.height);
        CGRect croppedImageViewToFrame = CGRectMake(0, 484, targetFrameSize.width, croppedImageView.frame.size.height);
        
        [contrainerView addSubview:fromViewController.view];
        [contrainerView addSubview:newImageView];
        [contrainerView addSubview:croppedImageView];
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            newImageView.frame = self.originalFrameOfImage;
            newImageView.layer.cornerRadius = self.originalCornerRadiusOfImage;
            croppedImageView.frame = croppedImageViewToFrame;
        } completion:^(BOOL finished) {
            [newImageView removeFromSuperview];
            [croppedImageView removeFromSuperview];
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
        
    }
}





@end
