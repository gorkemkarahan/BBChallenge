//
//  BBProfile.h
//  BBFeed
//
//  Created by Görkem Karahan on 08/01/2017.
//  Copyright © 2017 BB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBProfile : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *profileImageName;


- (instancetype)initWithName:(NSString *)name profileImageName:(NSString *)profileImageName;
@end
