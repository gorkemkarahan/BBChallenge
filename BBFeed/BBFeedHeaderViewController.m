//
//  BBFeedHeaderViewController.m
//  BBFeed
//
//  Created by Görkem Karahan on 07/01/2017.
//  Copyright © 2017 BB. All rights reserved.
//

#import "BBFeedHeaderViewController.h"
#import "BBFilterView.h"


@interface BBFeedHeaderViewController ()

@property (nonatomic) NSInteger currentIndex;


@end

@implementation BBFeedHeaderViewController


- (void) animateToSmallState {
    self.viewState = BBHeaderViewControllerStateSmall;
    [self.filtersContainerView layoutIfNeeded];
    
    self.cnstrntHeight.constant = 60;
    [UIView animateWithDuration:0.4f animations:^{
        [self.filtersContainerView layoutIfNeeded];
    }];
    

    for (BBFilterView *filterView in self.filtersContainerView.subviews) {
        if ([filterView isKindOfClass:[BBFilterView class]]) {
            [filterView disableShadowAnimated:NO];
            [filterView switchToSmallState];
        }
    }
    
}

- (void) animateToNormalState {
    
    self.viewState = BBHeaderViewControllerStateNormal;
    [self.filtersContainerView layoutIfNeeded];
    self.cnstrntHeight.constant = 300;

    [UIView animateWithDuration:0.4f animations:^{
        [self.filtersContainerView layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self.filtersContainerView.subviews[_currentIndex] enableShadowAnimated:YES];
    }];
    
    for (int i = 0; i < self.filtersContainerView.subviews.count; i++) {
        BBFilterView *filterView = self.filtersContainerView.subviews[i];
        if ([filterView isKindOfClass:[BBFilterView class]]) {
            [filterView switchToNormalState];
        }
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)swipedLeft:(id)sender {
    [self animateViewsToLocationsForLeft:YES];
}

- (void)swipedRight:(id)sender {
    [self animateViewsToLocationsForLeft:NO];
}

- (BOOL)canSwipeToRight {
    return self.currentIndex != 0;
}

- (BOOL)canSwipeToLeft {
    return self.currentIndex != (self.filters.count - 1);
}

- (void) animateViewsToLocationsForLeft:(BOOL)left {
    
    NSInteger nextIndex = left ? self.currentIndex + 1 : self.currentIndex - 1;
    
    for (int i = 0; i < self.filtersContainerView.subviews.count; i++) {
        BBFilterView *viewToAnimate = self.filtersContainerView.subviews[i];
        
        if (viewToAnimate.viewState != BBFilterViewStateSmall) {
            if (nextIndex == i) {
                [viewToAnimate enableShadowAnimated:YES];
            } else {
                [viewToAnimate disableShadowAnimated:YES];
            }
        }
        
        [self.view layoutIfNeeded];
        
        CGFloat constantToMove = left ? -220 : 220;
        CGFloat delay = 0.0f + (left ? ((ABS(i - self.currentIndex))/10.0f) : ((ABS(i - 1 - self.currentIndex))/10.0f));
        viewToAnimate.leftHorizontalSpacingConstraint.constant += constantToMove;
        
        [UIView animateWithDuration:0.4f delay:delay  options:UIViewAnimationOptionCurveEaseIn animations:^{

            
            [self.view layoutIfNeeded];
        } completion:nil];
        
    }
    self.currentIndex = nextIndex;
}

- (void)filterPressed:(UITapGestureRecognizer*)sender {
    
    NSInteger filterIndex = 0;
    for (int i = 0; i<self.filtersContainerView.subviews.count; i++) {
        if (sender.view == self.filtersContainerView.subviews[i]) {
            filterIndex = i;
            break;
        }
    }
    
    if ([self.delegate respondsToSelector:@selector(filterPressedOnIndex:onView:)]) {
        [self.delegate filterPressedOnIndex:filterIndex onView:(BBFilterView*)sender.view];
    }
    
    
    
}


- (void) prepareViews {

    CGFloat xValue = self.edgeInsets.left;
    
    for (BBFilter *filter in self.filters) {
        
        NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:@"BBFilterView" owner:self options:nil];
        BBFilterView *mainView = [subviewArray objectAtIndex:0];
        
        mainView.translatesAutoresizingMaskIntoConstraints = NO;
        [mainView prepareViewForFilter:filter];
        
        NSLayoutConstraint *leftToView = [NSLayoutConstraint constraintWithItem:mainView
                                                                      attribute:NSLayoutAttributeLeft
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:self.filtersContainerView
                                                                      attribute:NSLayoutAttributeLeft
                                                                     multiplier:1
                                                                       constant:xValue];
        
        NSLayoutConstraint *topToView = [NSLayoutConstraint constraintWithItem:mainView
                                                                       attribute:NSLayoutAttributeTop
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:self.filtersContainerView
                                                                       attribute:NSLayoutAttributeTop
                                                                      multiplier:1 constant:self.edgeInsets.top];
        
        NSLayoutConstraint *bottomToView = [NSLayoutConstraint constraintWithItem:mainView
                                                                       attribute:NSLayoutAttributeBottom
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:self.filtersContainerView
                                                                       attribute:NSLayoutAttributeBottom
                                                                      multiplier:1 constant:self.edgeInsets.bottom];
        
        NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:mainView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:self.itemSize.width];
        
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(filterPressed:)];
        recognizer.numberOfTapsRequired = 1;
        [mainView addGestureRecognizer:recognizer];
        mainView.leftHorizontalSpacingConstraint = leftToView;
        [self.filtersContainerView addSubview:mainView];
        [self.filtersContainerView addConstraints:@[leftToView, topToView, bottomToView, width]];
        
        xValue = xValue + self.spacing + self.itemSize.width;
    }
    [self.filtersContainerView.subviews[0] enableShadowAnimated:YES];

}

@end
