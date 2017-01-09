//
//  BBFeedCollectionViewController.m
//  BBFeed
//
//  Created by Görkem Karahan on 08/01/2017.
//  Copyright © 2017 BB. All rights reserved.
//

#import "BBFeedCollectionViewController.h"
#import "BBFeedCollectionViewCell.h"
#import "BBFilterCollectionViewDataSource.h"

@interface BBFeedCollectionViewController ()
@property (nonatomic, strong) BBFilterCollectionViewDataSource *dataSource;
@property (nonatomic) BOOL dragging;

@property (nonatomic) CGPoint lastOffset;
@end



@implementation BBFeedCollectionViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andFilter:(BBFilter *)filter {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.filter = filter;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lblHeader.text = self.filter.title;
    self.dataSource = [[BBFilterCollectionViewDataSource alloc] initWithCollectionView:self.cvFeeds andCoupons:self.filter.coupons];
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (scrollView.contentOffset.y <= 0)  {
        if ([self.delegate respondsToSelector:@selector(scrollReachedToTopOnCollectionView:)]) {
            [self.delegate scrollReachedToTopOnCollectionView:self.cvFeeds];
        }
    }
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y <= 0)  {
        if ([self.delegate respondsToSelector:@selector(scrollReachedToTopOnCollectionView:)]) {
            [self.delegate scrollReachedToTopOnCollectionView:self.cvFeeds];
        }
    }
}



- (void)setScrollEnabled:(BOOL)enabled {
    self.cvFeeds.scrollEnabled = enabled;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(collectionView.frame.size.width, 60);
}

@end
