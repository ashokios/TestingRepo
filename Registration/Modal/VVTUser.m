//
//  VVTUser.m
//  Registration
//
//  Created by Vipra Ferro Alloys on 23/04/14.
//  Copyright (c) 2014 ValvirtTechnologies. All rights reserved.
//

#import "VVTUser.h"
#import "VVTAppAPIClient.h"
#import "VVTWebServiceURLs.h"

@interface VVTUser ()
@property (assign, nonatomic, readwrite) NSUInteger userId;
//@property (assign, nonatomic, readonly) NSUInteger facebookId;
@property (strong, nonatomic, readwrite) NSString *fullName;
@property (strong, nonatomic, readwrite) NSString *email;
@property (strong, nonatomic, readwrite) NSString *dateOfBirth;
@property (strong, nonatomic, readwrite) NSString *gender;
@end

@implementation VVTUser
- (instancetype)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if(self) {
        self.userId = [[attributes valueForKeyPath:@"USER_ID"] integerValue];
        self.fullName = [attributes valueForKeyPath:@"NAME"];
        self.email = [attributes valueForKeyPath:@"EMAIL"];
        self.dateOfBirth = [attributes valueForKeyPath:@"DOB"];
        self.gender = [attributes valueForKeyPath:@"GENDER"];
        self.ppThumbnailURL = [attributes valueForKeyPath:@"PROFILE_THUMB_PIC"];
        self.ppOriginalURL= [attributes valueForKeyPath:@"PROFILE_MAIN_PIC"];
    }
    return self;
}

//- (instancetype)initWithId:(NSUInteger)userId name:(NSString *)fullName email:(NSString *)email andThumb:(NSString *)thumbnailURL
//{
//    self = [super init];
//    if(self) {
//        self.userId = userId;
//        self.fullName = fullName;
//        self.email = email;
//        self.ppThumbnailURL = thumbnailURL;
//    }
//    
//    return self;
//}

+(NSURLSessionDataTask *)insertUser:(NSDictionary *)params withCompletionBlock:(void (^)(BOOL success, VVTUser *user, BOOL userAlreadyRegistered, NSError *error))block
{
    return
    [[VVTAppAPIClient sharedClient] POST:USER_LOGIN_WITH_FACEBOOK parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        //NSLog(@"response:%@",responseObject);
        id response = [responseObject objectForKey:@"RESPONSE"];
        if([response isKindOfClass:[NSDictionary class]]) {
            NSString *status = [response objectForKey:@"STATUS"];
            if([status isEqualToString:@"INSERTED"]) {
                // user login for first time, present interest screen
                VVTUser *user = [[VVTUser alloc] initWithAttributes:[response objectForKey:@"USER_DATA"]];
                block(YES, user, NO ,nil);
            } else if([status isEqualToString:@"UPDATED"]) {
                // user already app user, present main tab
                VVTUser *user = [[VVTUser alloc] initWithAttributes:[response objectForKey:@"USER_DATA"]];
                block(YES, user, YES, nil);
            } else {
                NSLog(@"failed to insert");
                block(YES, nil, NO , nil);
            }
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error");
    }];
}

+(NSURLSessionDataTask *)registerNewUser:(NSDictionary *)params withCompletionBlock:(void (^)(BOOL success, VVTUser *user, BOOL userAlreadyRegistered, NSError *error))block
{
    return
    [[VVTAppAPIClient sharedClient] POST:USER_REGISTRATION_WITH_EMAIL parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"response:%@",responseObject);
        id response = [responseObject objectForKey:@"RESPONSE"];
        if([response isKindOfClass:[NSDictionary class]]) {
            NSString *status = [response objectForKey:@"STATUS"];
            if([status isEqualToString:@"INSERTED"]) {
                // user login for first time, present interest screen
                VVTUser *user = [[VVTUser alloc] initWithAttributes:[response objectForKey:@"USER_DATA"]];
                block(YES, user, NO ,nil);
            } else if([status isEqualToString:@"existed"]) {
                // user already app user, present main tab
                VVTUser *user = [[VVTUser alloc] initWithAttributes:[response objectForKey:@"USER_DATA"]];
                block(YES, user, YES, nil);
            } else {
                NSLog(@"failed to insert");
                block(YES, nil, NO , nil);
            }
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error");
    }];
}



@end
