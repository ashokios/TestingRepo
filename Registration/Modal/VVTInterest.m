//
//  VVTInterest.m
//  Registration
//
//  Created by Vipra Ferro Alloys on 23/04/14.
//  Copyright (c) 2014 ValvirtTechnologies. All rights reserved.
//

#import "VVTInterest.h"
#import "VVTAppAPIClient.h"
#import "VVTWebServiceURLs.h"

@implementation VVTInterest

- (instancetype)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if(self) {
        self.interestId = [[attributes valueForKeyPath:@"INTEREST_ID"] integerValue];
        self.interestName = [attributes valueForKeyPath:@"INTEREST_NAME"];
        self.interestpicURL = [attributes valueForKeyPath:@"INTEREST_PIC"];
    }
    return self;
}

+(NSURLSessionDataTask *)fetchInterestsWithCompletionBlock:(void (^)(BOOL success, NSArray *interests, NSError *error))block
{
    return
    [[VVTAppAPIClient sharedClient] GET:FETCH_ALL_INTERESTS parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"response object:%@",responseObject);
        id response = [responseObject objectForKey:@"RESPONSE"];
        if([response isKindOfClass:[NSArray class]]) {
            NSMutableArray *mutableInterests = [[NSMutableArray alloc] init];
            for(NSDictionary *dict in response) {
                VVTInterest *interest = [[VVTInterest alloc] initWithAttributes:dict];
                [mutableInterests addObject:interest];
            }
            block(YES,[NSArray arrayWithArray:mutableInterests],nil);
        } else {
            block(YES,[NSArray array],nil);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        block(NO, nil, nil);
    }];
}

@end
