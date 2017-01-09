//
//  BBFilterDetailViewController.h
//  BBFeed
//
//  Created by Görkem Karahan on 08/01/2017.
//  Copyright © 2017 BB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBFilterCollectionViewDataSource.h"

@interface BBFilterDetailViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedCTimePopularity;

@property (nonatomic, strong) BBFilter *filter;

@end
