//
//  VVTShowInterestVC.m
//  Registration
//
//  Created by Vipra Ferro Alloys on 23/04/14.
//  Copyright (c) 2014 ValvirtTechnologies. All rights reserved.
//

#import "VVTShowInterestVC.h"
#import "VVTInterestCell.h"
#import "VVTInterest.h"

@interface VVTShowInterestVC ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@end

@implementation VVTShowInterestVC
{
    NSMutableArray *_interests; // of VVTInterest
    NSCache *imagesCache;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"VVTInterestCell" bundle:nil] forCellWithReuseIdentifier:@"VVTInterestCell"];
    
    imagesCache = [[NSCache alloc] init];
    self.collectionView.allowsMultipleSelection = YES;
    
    [VVTInterest fetchInterestsWithCompletionBlock:^(BOOL success, NSArray *interests, NSError *error) {
        if(success && interests) {
            _interests = [interests mutableCopy];
            [self.collectionView reloadData];
        } else {
            NSLog(@"error while fetching interests:%@",[error localizedDescription]);
        }
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.hidesBackButton = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_interests count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    VVTInterestCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"VVTInterestCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    VVTInterest *interest = _interests[indexPath.item];
    cell.lbl_interestName.text = interest.interestName;
    
    if(cell.isSelected) {
        cell.iv_status.image = [UIImage imageNamed:@"selectedIcon"];
    } else {
        cell.iv_status.image = [UIImage imageNamed:@"deselectedIcon"];
    }
    
    
    
    NSString *key = interest.interestpicURL;
    if([imagesCache objectForKey:key]) {
        cell.iv_interestPic.image = [imagesCache objectForKey:key];
    } else {
    
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:interest.interestpicURL]];
            UIImage *image = [UIImage imageWithData:data];
            if(image) {
                [imagesCache setObject:image forKey:interest.interestpicURL];
                dispatch_async(dispatch_get_main_queue(), ^{
                cell.iv_interestPic.image = image;
                });
            }
        });
    }
    return cell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(160, 120);
}

- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsZero;
}




#pragma mark - Actions

- (IBAction)doneClick:(UIBarButtonItem *)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Count not sufficient" message:@"You have to select atleast 3 interests" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert show];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    VVTInterestCell *cell = (VVTInterestCell *) [collectionView cellForItemAtIndexPath:indexPath];
    cell.iv_status.image = [UIImage imageNamed:@"selectedIcon"];
    //[collectionView reloadItemsAtIndexPaths:@[indexPath]];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    VVTInterestCell *cell = (VVTInterestCell *) [collectionView cellForItemAtIndexPath:indexPath];
    cell.iv_status.image = [UIImage imageNamed:@"deselectedIcon"];
    //[collectionView reloadItemsAtIndexPaths:@[indexPath]];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
