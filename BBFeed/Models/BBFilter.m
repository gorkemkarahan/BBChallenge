//
//  BBFilter.m
//  BBFeed
//
//  Created by Görkem Karahan on 08/01/2017.
//  Copyright © 2017 BB. All rights reserved.
//

#import "BBFilter.h"

@implementation BBFilter


//Designated initilizer
- (instancetype)initWithtTitle:(NSString *)title
                      subtitle:(NSString *)subtitle
                     imageName:(NSString *)imageName
                       coupons:(NSArray<BBCoupon*> *)coupons {
    if (self = [super init]) {
        self.title = title;
        self.subtitle = subtitle;
        self.imageName = imageName;
        self.coupons = coupons;
    }
    return self;
}




@end
