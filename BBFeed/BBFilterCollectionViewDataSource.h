//
//  BBFilterCollectionViewDataSource.h
//  BBFeed
//
//  Created by Görkem Karahan on 09/01/2017.
//  Copyright © 2017 BB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BBFeedCollectionViewCell.h"
#import "BBFilter.h"

@interface BBFilterCollectionViewDataSource : NSObject <UICollectionViewDataSource>
@property(nonatomic, strong) NSArray<BBCoupon*> *coupons;

- (instancetype)initWithCollectionView:(UICollectionView *)collectionView andCoupons:(NSArray<BBCoupon*> *) coupons;
@end
