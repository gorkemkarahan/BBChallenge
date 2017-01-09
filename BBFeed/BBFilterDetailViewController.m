//
//  BBFilterDetailViewController.m
//  BBFeed
//
//  Created by Görkem Karahan on 08/01/2017.
//  Copyright © 2017 BB. All rights reserved.
//

#import "BBFilterDetailViewController.h"
#import "ConstantStrings.h"


@interface BBFilterDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lblFilterTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblFilterSubtitle;
@property (weak, nonatomic) IBOutlet UILabel *lblCouponCount;
@property (weak, nonatomic) IBOutlet UIImageView *imgVFilter;
@property (weak, nonatomic) IBOutlet UICollectionView *cvFeeds;

@property (nonatomic, strong) BBFilterCollectionViewDataSource *dataSource;
@end

@implementation BBFilterDetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.lblFilterTitle.text = self.filter.title;
    self.lblFilterSubtitle.text = self.filter.subtitle;
    self.lblCouponCount.text = [NSString stringWithFormat:@"%ld", (long)self.filter.coupons.count];
    self.imgVFilter.image = [UIImage imageNamed:self.filter.imageName];
    NSDictionary *normalAttributes = @{NSFontAttributeName:[UIFont fontWithName:kDefaultFontnameRegular size:13], NSForegroundColorAttributeName : [UIColor colorWithRed:156.0/255.0f green:170.0/255.0f blue:179.0/255.0f alpha:1]};
    
    NSDictionary *selectedAttributes = @{NSFontAttributeName:[UIFont fontWithName:kDefaultFontnameRegular size:13], NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    [self.segmentedCTimePopularity setTitleTextAttributes:normalAttributes forState:UIControlStateNormal];
    [self.segmentedCTimePopularity setTitleTextAttributes:selectedAttributes forState:UIControlStateSelected];
    
    UISwipeGestureRecognizer *swipeDownGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipedDown:)];
    swipeDownGestureRecognizer.direction = UISwipeGestureRecognizerDirectionDown;
    
    [self.view addGestureRecognizer:swipeDownGestureRecognizer];
    self.dataSource = [[BBFilterCollectionViewDataSource alloc] initWithCollectionView:self.cvFeeds andCoupons:self.filter.coupons];
    // Do any additional setup after loading the view.
}

- (void)swipedDown:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(collectionView.frame.size.width, 60);
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (IBAction)segmentedControlValueChanged:(UISegmentedControl *)sender {
    
    NSArray *fromArray = nil;
    NSArray *toArray = nil;
    if (sender.selectedSegmentIndex == 1) {
        self.dataSource = [[BBFilterCollectionViewDataSource alloc] initWithCollectionView:self.cvFeeds andCoupons:[self sortedArray]];
        fromArray = self.filter.coupons;
        toArray = [self sortedArray];
    } else {
        self.dataSource = [[BBFilterCollectionViewDataSource alloc] initWithCollectionView:self.cvFeeds andCoupons:self.filter.coupons];
        fromArray = self.dataSource.coupons;
        toArray = [self sortedArray];
    }
    
    [self.cvFeeds performBatchUpdates:^{
        for (NSInteger i = 0; i < fromArray.count; i++) {
            NSIndexPath *fromIndexPath = [NSIndexPath indexPathForRow:i inSection:0];
            NSInteger j = [toArray indexOfObject:fromArray[i]];
            NSIndexPath *toIndexPath = [NSIndexPath indexPathForRow:j inSection:0];
            [self.cvFeeds moveItemAtIndexPath:fromIndexPath toIndexPath:toIndexPath];
        }
    } completion:^(BOOL finished) {}];
}

- (NSArray *)sortedArray {
    
    return [self.filter.coupons sortedArrayUsingComparator:^NSComparisonResult(BBCoupon* a, BBCoupon* b) {
        if ( a.popularity > b.popularity) {
            return (NSComparisonResult)NSOrderedAscending;
        } else if ( a.popularity < b.popularity) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        return (NSComparisonResult)NSOrderedSame;
    }];
}


@end
