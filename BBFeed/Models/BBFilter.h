//
//  BBFilter.h
//  BBFeed
//
//  Created by Görkem Karahan on 08/01/2017.
//  Copyright © 2017 BB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BBCoupon.h"

@interface BBFilter : NSObject

@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *subtitle;
@property (nonatomic, strong) NSArray <BBCoupon *>* coupons;




//Designated initilizer
- (instancetype)initWithtTitle:(NSString *)title
                      subtitle:(NSString *)subtitle
                     imageName:(NSString *)imageName
                       coupons:(NSArray<BBCoupon*> *)coupons;

@end
