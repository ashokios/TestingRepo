//
//  VVTUser.h
//  Registration
//
//  Created by Vipra Ferro Alloys on 23/04/14.
//  Copyright (c) 2014 ValvirtTechnologies. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VVTUser : NSObject
@property (assign, nonatomic, readonly) NSUInteger userId;
//@property (assign, nonatomic, readonly) NSUInteger facebookId;
@property (strong, nonatomic, readonly) NSString *fullName;
@property (strong, nonatomic, readonly) NSString *email;
@property (strong, nonatomic, readonly) NSString *dateOfBirth;
@property (strong, nonatomic) NSString *ppThumbnailURL;
@property (strong, nonatomic) NSString *ppOriginalURL;
@property (strong, nonatomic, readonly) NSString *gender;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;// implement when web service is ready and remove the bottom inital method
//- (instancetype)initWithId:(NSUInteger)userId name:(NSString *)fullName email:(NSString *)email andThumb:(NSString *)thumbnailURL;

+(NSURLSessionDataTask *)insertUser:(NSDictionary *)params withCompletionBlock:(void (^)(BOOL success, VVTUser *user, BOOL userAlreadyRegistered, NSError *error))block;
+(NSURLSessionDataTask *)registerNewUser:(NSDictionary *)params withCompletionBlock:(void (^)(BOOL success, VVTUser *user, BOOL userAlreadyRegistered, NSError *error))block;
@end
