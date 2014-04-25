//
//  VVTJournalCell.h
//  Registration
//
//  Created by Vipra Ferro Alloys on 24/04/14.
//  Copyright (c) 2014 ValvirtTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VVTJournalCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbl_journalName;
@property (weak, nonatomic) IBOutlet UIImageView *iv_journalPic;
@property (weak, nonatomic) IBOutlet UIView *v_titleSection;
@end
