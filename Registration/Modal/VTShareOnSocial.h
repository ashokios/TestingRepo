//
//  VTShareOnSocial.h
//  VTLogin
//
//  Created by Valvirt Technologies on 17/04/14.
//  Copyright (c) 2014 valvirt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Social/Social.h>
#import <Accounts/Accounts.h>
#import <FacebookSDK/FacebookSDK.h>
#import <FBLoginView.h>

#define FB_APP_ID   @"209182672545302"

@interface VTShareOnSocial : NSObject
<UIDocumentInteractionControllerDelegate>


#pragma mark    -   Facebook userInfo
+(void)loginWithFacebookUsingNativeAppSuccessfully:(void (^)(BOOL granted, NSDictionary *userDetails))block;
+(void)loginWithFacebookUsingFBWebviewSuccessfully:(void (^)(BOOL fetched, NSDictionary *userDetails, NSError *error))block;




+(void)logoutWithFacebookUsingFBWebview;
+(void)getFacebookUserProfilePicInfoUsingFBWebView;

#pragma mark    -   Facebook Share Permission
+(BOOL)isFacebookSharePermissionUsingFBWebview;
+(void)isFacebookSharePermissionUsingFBNativeCompletion:(void (^)(BOOL granted))permission;

#pragma mark    -   Facebook Share
+(void)shareOnFacebookUsingNativeApp_viewController:(UIViewController *)viewController;


#pragma mark    -   Twitter Share
+(void)shareOnTwitter_viewController:(UIViewController *)viewController;


#pragma mark    -   Instagram Share
- (void)shareOnInstagram_frame:(CGRect)frame parentView:(UIView *)parentView shareImage:(UIImage *)shareImage;
@end
