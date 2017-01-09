//
//  BBProfile.m
//  BBFeed
//
//  Created by Görkem Karahan on 08/01/2017.
//  Copyright © 2017 BB. All rights reserved.
//

#import "BBProfile.h"

@implementation BBProfile

- (instancetype)initWithName:(NSString *)name profileImageName:(NSString *)profileImageName {
    if (self = [super init]) {
        self.name = name;
        self.profileImageName = profileImageName;
    }
    return self;
}

@end
