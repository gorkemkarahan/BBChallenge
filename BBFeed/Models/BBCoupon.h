//
//  BBCoupon.h
//  BBFeed
//
//  Created by Görkem Karahan on 08/01/2017.
//  Copyright © 2017 BB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BBProfile.h"

@interface BBCoupon : NSObject

@property (nonatomic, strong) BBProfile *placedBy;
@property (nonatomic, strong) NSString *name;

@property (nonatomic) NSInteger peoplePlayedCount;
@property (nonatomic) NSInteger bullsPlayedCount;

@property (nonatomic) NSInteger betMain;
@property (nonatomic) NSInteger betDivider;

@property (nonatomic) NSInteger popularity;

@property (nonatomic) NSInteger placedHoursAgo;

- (instancetype)initWithPlacedBy:(BBProfile *)placedBy
                            name:(NSString *)name
               peoplePlayedCount:(NSInteger)peoplePlayedCount
                bullsPlayedCount:(NSInteger)bullsPlayedCount
                         betMain:(NSInteger)betMain
                      betDivider:(NSInteger)betDivider
                      popularity:(NSInteger)popularity
                  placedHoursAgo:(NSInteger)placedHoursAgo;

@end
