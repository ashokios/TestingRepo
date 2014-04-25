//
//  VVTProfileVC.m
//  Registration
//
//  Created by Vipra Ferro Alloys on 24/04/14.
//  Copyright (c) 2014 ValvirtTechnologies. All rights reserved.
//

#import "VVTProfileVC.h"
#import "VVTFirstCell.h"
#import "VVTJournalCell.h"

@interface VVTProfileVC ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@end

@implementation VVTProfileVC
{
    NSUInteger journalFoldersCount;
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
    journalFoldersCount = 9;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(section == 0) return 1;
    return journalFoldersCount + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0) {
        VVTFirstCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"VVTFirstCell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor yellowColor];
        return cell;
    } else {
        VVTJournalCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"VVTJournalCell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor redColor];
        //cell.v_titleSection.hidden = YES;
        if(indexPath.row == journalFoldersCount) {
            cell.lbl_journalName.text = @"Add new Journal";
        }
        return cell;
    }
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0)
        return CGSizeMake(320, 320);
    
    if(indexPath.row == journalFoldersCount && indexPath.row %2 == 0)
        return CGSizeMake(320, 120);
    
    return CGSizeMake(160, 120);
}


- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsZero;
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
