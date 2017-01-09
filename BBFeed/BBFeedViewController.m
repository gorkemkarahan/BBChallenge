//
//  BBFeedViewController.m
//  BBFeed
//
//  Created by Görkem Karahan on 06/01/2017.
//  Copyright © 2017 BB. All rights reserved.
//

#import "BBFeedViewController.h"
#import "ConstantStrings.h"

#import "AnimationController.h"
#import "BBFilterDetailViewController.h"

@interface BBFeedViewController ()
@property (weak, nonatomic) IBOutlet UITextField *tfSearch;
@property (weak, nonatomic) BBFeedHeaderViewController *headerController;
@property (weak, nonatomic) BBFeedCollectionViewController *collectionViewController;
@property (nonatomic) CGFloat contentOffsetY;
@property (nonatomic, strong) NSArray<BBFilter*> *filters;
@property (nonatomic) NSInteger currentFilterIndex;

@property (nonatomic, strong) AnimationController *animationController;

@property (nonatomic, strong) UISwipeGestureRecognizer *swipeUpGestureRecognizer;

@end

@implementation BBFeedViewController



#pragma mark View lifecycle

- (instancetype)init {
    if (self = [super init]) {
        self.filters = [self createFilterData];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.filters = [self createFilterData];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.animationController = [[AnimationController alloc] init];
    
    self.swipeUpGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipedUp:)];
    self.swipeUpGestureRecognizer.direction = UISwipeGestureRecognizerDirectionUp;
    
    [self.view addGestureRecognizer:self.swipeUpGestureRecognizer];
    
    UISwipeGestureRecognizer *recognizer2 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipedDown:)];
    recognizer2.direction = UISwipeGestureRecognizerDirectionDown;
    
    [self.view addGestureRecognizer:recognizer2];
    
    
    UISwipeGestureRecognizer *recognizer3 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipedLeft:)];
    recognizer3.direction = UISwipeGestureRecognizerDirectionLeft;
    
    [self.view addGestureRecognizer:recognizer3];
    
    UISwipeGestureRecognizer *recognizer4 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipedRight:)];
    recognizer4.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.view addGestureRecognizer:recognizer4];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tfSearch setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"Search..." attributes:@{NSForegroundColorAttributeName:kLightGrayColor}]];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)swipedUp:(id)sender {
    [self.view layoutIfNeeded];
    _cnstrntHeaderViewControllerHeight.constant = 117;
    [self.headerController animateToSmallState];
    [UIView animateWithDuration:0.4f animations:^{
        [self.view layoutIfNeeded];
        [self.collectionViewController setScrollEnabled:YES];
        
    }];    
}

- (void)swipedDown:(id)sender {
    [self.view layoutIfNeeded];
    _cnstrntHeaderViewControllerHeight.constant = 451;
    [self.headerController animateToNormalState];
    [self.collectionViewController setScrollEnabled:NO];
    [UIView animateWithDuration:0.4f animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)swipedLeft:(id)sender {
    if ([self.headerController canSwipeToLeft]) {
        [self.headerController swipedLeft:nil];
        
        BBFeedCollectionViewController *cont = [self.storyboard instantiateViewControllerWithIdentifier:@"BBFeedCollectionViewController"];
        cont.filter = self.filters[++self.currentFilterIndex];
        cont.view.translatesAutoresizingMaskIntoConstraints = NO;
        [cont setScrollEnabled:self.headerController.viewState == BBHeaderViewControllerStateSmall];
        
        [self cycleFromViewController:self.collectionViewController toViewController:cont toLeft:YES];
        self.collectionViewController.delegate = nil;
        self.collectionViewController = cont;
        self.collectionViewController.delegate = self;
    }    
}

- (void)swipedRight:(id)sender {
    if ([self.headerController canSwipeToRight]) {
        [self.headerController swipedRight:sender];
        BBFeedCollectionViewController *newCollectionViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"BBFeedCollectionViewController"];
        newCollectionViewController.filter = self.filters[--self.currentFilterIndex];
        newCollectionViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
        [newCollectionViewController setScrollEnabled:self.headerController.viewState == BBHeaderViewControllerStateSmall];
        [self cycleFromViewController:self.collectionViewController toViewController:newCollectionViewController toLeft:NO];
        self.collectionViewController.delegate = nil;
        self.collectionViewController = newCollectionViewController;
        self.collectionViewController.delegate = self;
    }
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"EmbedBBFeedHeaderViewController"]  ) {
        self.headerController = segue.destinationViewController;
        self.headerController.edgeInsets = UIEdgeInsetsMake(0, 20, 0, 20);
        self.headerController.itemSize = CGSizeMake(200, 300);
        self.headerController.spacing = 20;
        self.headerController.filters = self.filters;
        self.headerController.delegate = self;
    } else if ([segue.identifier isEqualToString:@"EmbedBBFeedCollectionViewController"]) {
        self.collectionViewController = segue.destinationViewController;
        self.collectionViewController.delegate = self;
        self.collectionViewController.filter = self.filters[self.currentFilterIndex];
        [self.collectionViewController setScrollEnabled:NO];
    } else if ([segue.identifier isEqualToString:@"FeedToFeedDetailViewControllerSegue"]) {
        segue.destinationViewController.transitioningDelegate = self;
        ((BBFilterDetailViewController*)segue.destinationViewController).filter = self.filters[self.currentFilterIndex];
    }
}


- (void)cycleFromViewController:(UIViewController*) oldViewController
               toViewController:(UIViewController*) newViewController
                         toLeft:(BOOL)toLeft {
    [oldViewController willMoveToParentViewController:nil];
   
    [self addChildViewController:newViewController];
    [self addSubview:newViewController.view toView:self.footerContainerView];
    
    CGFloat travel = self.collectionViewController.view.frame.size.width;
    
    newViewController.view.transform = CGAffineTransformInvert(CGAffineTransformMakeTranslation(toLeft ? -travel : travel, 0));
    newViewController.view.alpha = 0;
    [newViewController.view layoutIfNeeded];
    
    [UIView animateWithDuration:0.4f
                     animations:^{
                         newViewController.view.alpha = 1;
                         newViewController.view.transform = CGAffineTransformIdentity;
                         oldViewController.view.alpha = 0;
                         oldViewController.view.transform = CGAffineTransformInvert(CGAffineTransformMakeTranslation(toLeft ? travel : -travel, 0));
                     }
                     completion:^(BOOL finished) {
                         [oldViewController.view removeFromSuperview];
                         [oldViewController removeFromParentViewController];
                         [newViewController didMoveToParentViewController:self];
                     }];
}

- (void)addSubview:(UIView *)subView toView:(UIView*)parentView {
    [parentView addSubview:subView];
    
    NSDictionary * views = @{@"subView" : subView,};
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[subView]|"
                                                                   options:0
                                                                   metrics:0
                                                                     views:views];
    [parentView addConstraints:constraints];
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[subView]|"
                                                          options:0
                                                          metrics:0
                                                            views:views];
    [parentView addConstraints:constraints];
}


#pragma mark BBFeedCollectionViewDelegate Methods 

- (void)scrollReachedToTopOnCollectionView:(UICollectionView *)collectionView {
    collectionView.scrollEnabled = NO;
    [self swipedDown:nil];
}

#pragma mark BBFeedHeaderViewControllerDelegate Methods

- (void)filterPressedOnIndex:(NSInteger)index onView:(BBFilterView *)view {
    if (self.currentFilterIndex == index && self.headerController.viewState != BBFilterViewStateSmall) {
        [self performSegueWithIdentifier:@"FeedToFeedDetailViewControllerSegue" sender:self];
        self.animationController.fromImage = view.imgVFilter;
        self.animationController.originalFrameOfImage = [view convertRect:view.bounds toView:self.view];
    } else if (self.currentFilterIndex<index){
        [self swipedLeft:nil];
    }
    
}


#pragma mark UIViewControllerTransitioningDelegate Methods
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    self.animationController.presenting = YES;
    return self.animationController;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    self.animationController.presenting = NO;
    return self.animationController;
}

#pragma mark Mock Data Creation

- (NSArray<BBFilter *> *)createFilterData {
    NSMutableArray<BBFilter*> *filterData = [[NSMutableArray alloc] initWithCapacity:5];
    
    
    NSArray *userNames = @[@"forteko", @"Anfield", @"Scouser"];
    NSArray *couponNames = @[@"4-fold Accumulator", @"Trebles", @"Doubles"];
    NSArray *userImageNames = @[@"ProfilePictureAli", @"ProfilePictureAlmanac", @"ProfilePictureBatistuta", @"ProfilePictureBegbie", @"ProfilePictureBergkamp", @"ProfilePictureBest", @"ProfilePictureBetterCallSaul", @"ProfilePictureBird"];
    
    NSArray *filterNames = @[@"My Feed", @"Popular Bets", @"Bulls", @"Winner Bets", @"Safe Return"];
    NSArray *filterSubtitles = @[@"People you follow", @"Most played ACCAs", @"Only best ones", @"See how magic happens", @"Take no risks"];
    NSArray *filterImages = @[@"MyFeedHeader", @"PopularBetsHeader", @"BullsHeader", @"WinnerBetsHeader", @"SafeReturnHeader"];
    
    
    for (int i = 0; i < 5; i++) {
        
        NSInteger numberOfCoupons = (arc4random() % 50) + 1;
        NSMutableArray<BBCoupon*> *coupons = [[NSMutableArray alloc] initWithCapacity:numberOfCoupons];
        for (int j = 0; j < numberOfCoupons; j++) {
            BBProfile *placedBy = [[BBProfile alloc] initWithName:userNames[(random() % userNames.count)]
                                                 profileImageName:userImageNames[(random() % userImageNames.count)]];
            
            NSInteger betDivider = arc4random() % 5 + 1;
            BBCoupon *coupon = [[BBCoupon alloc] initWithPlacedBy:placedBy
                                                             name:couponNames[(random()%couponNames.count)]
                                                peoplePlayedCount:(arc4random() % 10000 + 1)
                                                 bullsPlayedCount:(arc4random() % 1000 + 1)
                                                          betMain:(arc4random() % 10 + betDivider)
                                                       betDivider:betDivider
                                                       popularity:arc4random() % 1000
                                                   placedHoursAgo:arc4random() % 20 + 1];
            [coupons addObject:coupon];
        }
        
        
        [filterData addObject:[[BBFilter alloc] initWithtTitle:filterNames[i] subtitle:filterSubtitles[i] imageName:filterImages[i] coupons:coupons]];
    }
    
    return filterData;
}


@end
