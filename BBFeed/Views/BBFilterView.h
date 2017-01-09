//
//  BBFilterView.h
//  BBFeed
//
//  Created by Görkem Karahan on 08/01/2017.
//  Copyright © 2017 BB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBFilter.h"

typedef NS_ENUM(NSInteger, BBFilterViewState) {
    BBFilterViewStateNormal,
    BBFilterViewStateSmall
    
};


@interface BBFilterView : UIView
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cnstrntSubtitleBottomVerticalSpace;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblSubtitle;
@property (weak, nonatomic) IBOutlet UIImageView *imgVFilter;

@property (weak, nonatomic) NSLayoutConstraint *leftHorizontalSpacingConstraint;
@property (nonatomic) BBFilterViewState viewState;

- (void)prepareViewForFilter:(BBFilter *)filter;

- (void)switchToSmallState;
- (void)switchToNormalState;
- (void)enableShadowAnimated:(BOOL)animated;
- (void)disableShadowAnimated:(BOOL)animated;


@end
