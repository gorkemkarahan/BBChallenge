//
//  BBFeedHeaderViewController.h
//  BBFeed
//
//  Created by Görkem Karahan on 07/01/2017.
//  Copyright © 2017 BB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBFilter.h"
#import "BBFilterView.h"

@protocol  BBFeedHeaderViewControllerDelegate;

typedef NS_ENUM(NSInteger, BBHeaderViewControllerState) {
    BBHeaderViewControllerStateNormal,
    BBHeaderViewControllerStateSmall
};

@interface BBFeedHeaderViewController : UIViewController

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cnstrntHeight;

@property (weak, nonatomic) IBOutlet UIView *filtersContainerView;

@property (nonatomic, strong) NSArray<BBFilter *> *filters;

@property (nonatomic) CGSize itemSize;
@property (nonatomic) UIEdgeInsets edgeInsets;
@property (nonatomic) CGFloat spacing;

@property (weak, nonatomic) id<BBFeedHeaderViewControllerDelegate> delegate;
@property (nonatomic) BBHeaderViewControllerState viewState;

- (void)swipedLeft:(id)sender;
- (void)swipedRight:(id)sender;
- (void)animateToSmallState;
- (void) animateToNormalState;

- (BOOL)canSwipeToRight;
- (BOOL)canSwipeToLeft;

@end

@protocol  BBFeedHeaderViewControllerDelegate<NSObject>
-(void)filterPressedOnIndex:(NSInteger)index onView:(BBFilterView*)view;
@end
