//
//  BBCoupon.m
//  BBFeed
//
//  Created by Görkem Karahan on 08/01/2017.
//  Copyright © 2017 BB. All rights reserved.
//

#import "BBCoupon.h"

@implementation BBCoupon


- (instancetype)initWithPlacedBy:(BBProfile *)placedBy
                            name:(NSString *)name
               peoplePlayedCount:(NSInteger)peoplePlayedCount
                bullsPlayedCount:(NSInteger)bullsPlayedCount
                         betMain:(NSInteger)betMain
                      betDivider:(NSInteger)betDivider
                      popularity:(NSInteger)popularity
                  placedHoursAgo:(NSInteger)placedHoursAgo{
    if (self = [super init]) {
        self.placedBy = placedBy;
        self.name = name;
        self.peoplePlayedCount = peoplePlayedCount;
        self.bullsPlayedCount = bullsPlayedCount;
        self.betMain = betMain;
        self.betDivider = betDivider;
        self.popularity = popularity;
        self.placedHoursAgo = placedHoursAgo;
    }
    return self;
}


@end
