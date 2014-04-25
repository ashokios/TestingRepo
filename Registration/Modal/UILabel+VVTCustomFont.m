//
//  UILabel+VVTCustomFont.m
//  LyfeLog
//
//  Created by Vipra Ferro Alloys on 17/01/14.
//  Copyright (c) 2014 ValvirtTechnologies. All rights reserved.
//

#import "UILabel+VVTCustomFont.h"

@implementation UILabel (VVTCustomFont)

- (NSString *)fontName {
    return self.font.fontName;
}

- (void)setFontName:(NSString *)fontName {
    self.font = [UIFont fontWithName:fontName size:self.font.pointSize];
}

@end
