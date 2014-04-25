//
//  VVTAppAPIClient.h
//  Registration
//
//  Created by Vipra Ferro Alloys on 23/04/14.
//  Copyright (c) 2014 ValvirtTechnologies. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface VVTAppAPIClient : AFHTTPSessionManager
+ (instancetype)sharedClient;
@end
