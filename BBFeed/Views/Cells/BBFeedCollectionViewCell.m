//
//  FeedItemCollectionViewCell.m
//  BBFeed
//
//  Created by Görkem Karahan on 06/01/2017.
//  Copyright © 2017 BB. All rights reserved.
//

#import "BBFeedCollectionViewCell.h"
#import "ConstantStrings.h"

@implementation BBFeedCollectionViewCell

- (void)prepareForCoupon:(BBCoupon *)coupon {
    self.imgVPlacedBy.image = [UIImage imageNamed:coupon.placedBy.profileImageName];
    
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ placed this %ld hours ago", coupon.placedBy.name , (long)coupon.placedHoursAgo]];
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:36.0/255.0f green:177.0/255.0f blue:227.0/255.0f alpha:1] range:NSMakeRange(0, coupon.placedBy.name.length)];
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:172.0/255.0f green:184.0/255.0f blue:192.0/255.0f alpha:1] range:NSMakeRange(coupon.placedBy.name.length, string.length - coupon.placedBy.name.length)];
    [string addAttribute:NSFontAttributeName value:[UIFont fontWithName:kDefaultFontnameRegular size:12] range:NSMakeRange(coupon.placedBy.name.length, string.length - coupon.placedBy.name.length)];
    
    self.lblplacedBy.attributedText = string;
    
    self.lblCouponName.text = coupon.name;
    self.lblNumberOfPeoplePlayed.text = [NSString stringWithFormat:@"%ld PEOPLE AND %ld BULLS PLAYED", (long)coupon.peoplePlayedCount, (long)coupon.bullsPlayedCount];

    self.lblBetRate.text = [NSString stringWithFormat:@"%ld/%ld", (long)coupon.betMain, (long)coupon.betDivider];
    if (coupon.betMain > 10) {
        self.viewBetRate.backgroundColor = [UIColor colorWithRed:194.0/255.0f green:48.0/255.0f blue:66.0/255.0f alpha:1];
    } else if (coupon.betMain > 3) {
        self.viewBetRate.backgroundColor = [UIColor colorWithRed:156.0/255.0f green:170.0/255.0f blue:179.0/255.0f alpha:1];
    } else {
        self.viewBetRate.backgroundColor = [UIColor colorWithRed:36.0/255.0f green:177.0/255.0f blue:227.0/255.0f alpha:1];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


@end
