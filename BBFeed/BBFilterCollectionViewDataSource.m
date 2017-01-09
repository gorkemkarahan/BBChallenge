//
//  BBFilterCollectionViewDataSource.m
//  BBFeed
//
//  Created by Görkem Karahan on 09/01/2017.
//  Copyright © 2017 BB. All rights reserved.
//

#import "BBFilterCollectionViewDataSource.h"



@interface BBFilterCollectionViewDataSource()

@end

@implementation BBFilterCollectionViewDataSource

static NSString *kBBFeedCollectionViewCell = @"BBFeedCollectionViewCell";

- (instancetype)initWithCollectionView:(UICollectionView *)collectionView andCoupons:(NSArray<BBCoupon *> *)coupons {
    if (self = [super init]) {
        collectionView.dataSource = self;
        [collectionView registerNib:[UINib nibWithNibName:kBBFeedCollectionViewCell bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:kBBFeedCollectionViewCell];
        self.coupons = coupons;
    }
    return self;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BBFeedCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kBBFeedCollectionViewCell forIndexPath:indexPath];
    [cell prepareForCoupon:self.coupons[indexPath.row]];
    return cell;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.coupons.count;
}



@end
