//
//  VVTAppAPIClient.m
//  Registration
//
//  Created by Vipra Ferro Alloys on 23/04/14.
//  Copyright (c) 2014 ValvirtTechnologies. All rights reserved.
//

#import "VVTAppAPIClient.h"
static NSString * const AFAppAPIBaseURLString = @"http://valvirt.com/valvirt.interests/";
@implementation VVTAppAPIClient
+ (instancetype)sharedClient {
    static VVTAppAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[VVTAppAPIClient alloc] initWithBaseURL:[NSURL URLWithString:AFAppAPIBaseURLString]];
        _sharedClient.requestSerializer = [AFJSONRequestSerializer serializer];
        _sharedClient.responseSerializer = [AFJSONResponseSerializer serializer];
        _sharedClient.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    });
    
    return _sharedClient;
}
@end
