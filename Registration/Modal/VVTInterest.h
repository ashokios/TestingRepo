//
//  VVTInterest.h
//  Registration
//
//  Created by Vipra Ferro Alloys on 23/04/14.
//  Copyright (c) 2014 ValvirtTechnologies. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VVTInterest : NSObject
@property (assign, nonatomic) NSUInteger interestId;
@property (strong, nonatomic) NSString *interestName;
@property (strong, nonatomic) NSString *interestpicURL;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;
+(NSURLSessionDataTask *)fetchInterestsWithCompletionBlock:(void (^)(BOOL success, NSArray *interests, NSError *error))block;
@end
