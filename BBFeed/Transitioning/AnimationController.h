//
//  AnimationController.h
//  BBFeed
//
//  Created by Görkem Karahan on 08/01/2017.
//  Copyright © 2017 BB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AnimationController : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic) CGRect originalFrameOfImage;
@property (strong, nonatomic) UIImageView *fromImage;
@property (nonatomic) BOOL presenting;

@end
