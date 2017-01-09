//
//  FeedItemCollectionViewCell.h
//  BBFeed
//
//  Created by Görkem Karahan on 06/01/2017.
//  Copyright © 2017 BB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBCoupon.h"

@interface BBFeedCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgVPlacedBy;
@property (weak, nonatomic) IBOutlet UILabel *lblplacedBy;
@property (weak, nonatomic) IBOutlet UILabel *lblCouponName;
@property (weak, nonatomic) IBOutlet UILabel *lblNumberOfPeoplePlayed;
@property (weak, nonatomic) IBOutlet UIView *viewBetRate;
@property (weak, nonatomic) IBOutlet UILabel *lblBetRate;

- (void)prepareForCoupon:(BBCoupon *)coupon;

@end
