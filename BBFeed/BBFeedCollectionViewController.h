//
//  BBFeedCollectionViewController.h
//  BBFeed
//
//  Created by Görkem Karahan on 08/01/2017.
//  Copyright © 2017 BB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBFilter.h"

@protocol BBFeedCollectionViewControllerDelegate;

@interface BBFeedCollectionViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *cvFeeds;
@property (weak, nonatomic) id<BBFeedCollectionViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *lblHeader;



@property(nonatomic, strong) BBFilter *filter;

- (void)setScrollEnabled:(BOOL)enabled;
@end


@protocol BBFeedCollectionViewControllerDelegate <NSObject>

- (void)scrollReachedToTopOnCollectionView:(UICollectionView *)collectionView;

@end
