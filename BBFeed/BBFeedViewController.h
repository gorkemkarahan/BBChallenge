//
//  BBFeedViewController.h
//  BBFeed
//
//  Created by Görkem Karahan on 06/01/2017.
//  Copyright © 2017 BB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBFeedCollectionViewController.h"
#import "BBFeedHeaderViewController.h"

@interface BBFeedViewController : UIViewController <BBFeedCollectionViewControllerDelegate, BBFeedHeaderViewControllerDelegate, UIViewControllerTransitioningDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cnstrntHeaderViewControllerHeight;
@property (weak, nonatomic) IBOutlet UIView *headerContainerView;
@property (weak, nonatomic) IBOutlet UIView *footerContainerView;

@end
