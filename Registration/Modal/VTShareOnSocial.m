//
//  VTShareOnSocial.m
//  VTLogin
//
//  Created by Valvirt Technologies on 17/04/14.
//  Copyright (c) 2014 valvirt. All rights reserved.
//

#import "VTShareOnSocial.h"
#import "VVTUser.h"
#import "ShareMessageHeader.h"


@interface VTShareOnSocial ()


@end


@implementation VTShareOnSocial

-(id)init
{
    self = [super init];
    if (self)
    {
        //custom initialization
    }
    return self;
}

#pragma mark    -   Get Facebook userInfo
+(void)loginWithFacebookUsingNativeAppSuccessfully:(void (^)(BOOL granted, NSDictionary *userDetails))block
{
    ACAccountStore *accountStore = [[ACAccountStore alloc]init];
    ACAccountType *fbAccountType = [[ACAccountType alloc]init];
    __block ACAccount *facebookAccount = [[ACAccount alloc]init];
    
    //define account type facebook
    fbAccountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierFacebook];
    
    //permission for containt
    NSArray * permissions = @[@"publish_stream", @"publish_actions", @"email"];
    
    //decleare app id, permission, and audience
    NSDictionary *facebookInfoDict = @{ACFacebookAppIdKey: FB_APP_ID, ACFacebookPermissionsKey : permissions, ACFacebookAudienceKey : ACFacebookAudienceEveryone};
    
    //request account for user information
    [accountStore requestAccessToAccountsWithType:fbAccountType options:facebookInfoDict completion:^(BOOL granted, NSError *error)
    {
        
        //account is available
        if (granted)//if(facebookInfoDict)
        {
            NSArray *accounts = [accountStore accountsWithAccountType:fbAccountType];
            facebookAccount = [accounts lastObject];
            
            //this is for basic information from facebook
            NSURL *baicInfoURL = [NSURL URLWithString:@"https://graph.facebook.com/me"];
            
            SLRequest *basicInfoRequest = [SLRequest requestForServiceType:SLServiceTypeFacebook
                                                             requestMethod:SLRequestMethodGET
                                                                       URL:baicInfoURL
                                                                parameters:nil];
            basicInfoRequest.account = facebookAccount;
            
            [basicInfoRequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error)
             {
                 
                 NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:responseData
                                                                                    options:NSJSONReadingMutableContainers
                                                                                      error:nil];
                 NSString *profilePicThumbURL = [NSString stringWithFormat:@"http://graph.facebook.com/%@/picture?type=large", responseDictionary[@"id"]];
                 NSString *profilePicOriginalURL = [NSString stringWithFormat:@"http://graph.facebook.com/%@/picture?width=720&height=720", responseDictionary[@"id"]];
                 NSDictionary *userDetails = @{@"FACEBOOK_ID":responseDictionary[@"id"],
                                               @"NAME":responseDictionary[@"name"],
                                               @"EMAIL":responseDictionary[@"email"]?responseDictionary[@"email"]:@"",
                                               @"GENDER":responseDictionary[@"gender"]?responseDictionary[@"gender"]:@"",
                                               @"DOB":responseDictionary[@"birthday"]?responseDictionary[@"birthday"]:@"",
                                               @"PROFILE_PIC_THUMB":profilePicThumbURL,
                                               @"PROFILE_PIC_REGULAR":profilePicOriginalURL
                                               };
                 block(YES,userDetails);
                 
//                 [VVTUser insertUser:params withCompletionBlock:^(BOOL success, VVTUser *user) {
//                     
//                 }];
//                 
//                 NSLog(@"%@",profilePicURL);
//                 UIImage *profilePic = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:profilePicURL]]];
                 
//                                
//                 if (profilePic)
//                 {
//                     NSLog(@"profilePicture yes = %@",profilePic);
//                     
//                 }
//                 else
//                 {
//                     NSLog(@"profilePicture no = %@",profilePic);
//                     
//                 }
                
             }];
            
        }
        else//account not available
        {
            //[VTErrorAlert showAlertWith_errorMessage:@"Facebook access for this app has been denied. Please edit Facebook permissions in Settings." title:@"Error"];
            NSLog(@"not granted");
            block(NO,nil);
            
        }
    }];
    
}

+(void)loginWithFacebookUsingFBWebviewSuccessfully:(void (^)(BOOL fetched, NSDictionary *userDetails, NSError *error))block
{
    @try
    {
        NSLog(@"session is Active");
        
        //permission for gettting user info
        NSArray *permissions = [[NSArray alloc] initWithObjects:@"user_photos", @"publish_actions", @"read_stream", @"friends_photos", @"email", nil];
        
        //set sesstion with permission
        [FBSession setActiveSession:[[FBSession alloc] initWithPermissions:permissions]];
        
        //show facebook login screen with webview
        [[FBSession activeSession] openWithBehavior:FBSessionLoginBehaviorForcingWebView completionHandler:^(FBSession *session, FBSessionState state, NSError *error)
         {
             //get the state
             NSLog(@" state=%d",state);
             
             if (!error)//if login error not occured
             {
                 //get user information if login completed
                 [FBRequestConnection startForMeWithCompletionHandler:^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *responseDictionary, NSError *error)
                  {
                      //NSLog(@"FBUser info: %@",responseDictionary);
                      NSString *profilePicThumbURL = [NSString stringWithFormat:@"http://graph.facebook.com/%@/picture?type=large", responseDictionary[@"id"]];
                      NSString *profilePicOriginalURL = [NSString stringWithFormat:@"http://graph.facebook.com/%@/picture?width=720&height=720", responseDictionary[@"id"]];
                      NSDictionary *userDetails = @{@"FACEBOOK_ID":responseDictionary[@"id"],
                                                    @"NAME":responseDictionary[@"name"],
                                                    @"EMAIL":responseDictionary[@"email"]?responseDictionary[@"email"]:@"",
                                                    @"GENDER":responseDictionary[@"gender"]?responseDictionary[@"gender"]:@"",
                                                    @"DOB":responseDictionary[@"birthday"]?responseDictionary[@"birthday"]:@"",
                                                    @"PROFILE_PIC_THUMB":profilePicThumbURL,
                                                    @"PROFILE_PIC_REGULAR":profilePicOriginalURL
                                                    };
                      block(YES,userDetails,nil);
                  }];
                 
             }
             else //if error occoured show error
             {
                 NSLog(@"Error in FBUser info: %@",[error localizedDescription]);
                 block(NO,nil,error);
             }
         }];
    }
    @catch (NSException *exception)
    {
        NSLog(@"loginWithFacebookUsingFBWebview = %@",exception);
    }
    
}

- (NSDictionary *)prepareUserDetailsFromDict:(NSDictionary *)responseDictionary
{
    NSString *profilePicThumbURL = [NSString stringWithFormat:@"http://graph.facebook.com/%@/picture?type=large", responseDictionary[@"id"]];
    NSString *profilePicOriginalURL = [NSString stringWithFormat:@"http://graph.facebook.com/%@/picture?width=720&height=720", responseDictionary[@"id"]];
    NSDictionary *userDetails = @{@"FACEBOOK_ID":responseDictionary[@"id"],
                                  @"NAME":responseDictionary[@"name"],
                                  @"EMAIL":responseDictionary[@"email"]?responseDictionary[@"email"]:@"",
                                  @"GENDER":responseDictionary[@"gender"]?responseDictionary[@"gender"]:@"",
                                  @"DOB":responseDictionary[@"birthday"]?responseDictionary[@"birthday"]:@"",
                                  @"PROFILE_PIC_THUMB":profilePicThumbURL,
                                  @"TYPE":@"1" // 1 for facebook login
                                  };
    return userDetails;

}


+(void)logoutWithFacebookUsingFBWebview
{
    @try
    {
        if ([[FBSession activeSession] state] == FBSessionStateCreatedTokenLoaded || [[FBSession activeSession] state] == FBSessionStateOpen || [[FBSession activeSession] state] == FBSessionStateClosedLoginFailed)
        {
            
            //close the facebook login session
            [[FBSession activeSession] closeAndClearTokenInformation];
            //[[FBSession activeSession] close];
            
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                NSLog(@"Facebook session deactive");
                
            });
        }
    }
    @catch (NSException *exception)
    {
        NSLog(@"logoutWithFacebookUsingFBWebview = %@",exception);
    }
}

+(void)getFacebookUserProfilePicInfoUsingFBWebView
{
    
    [[FBSession activeSession] openWithBehavior:FBSessionLoginBehaviorForcingWebView completionHandler:^(FBSession *session, FBSessionState state, NSError *error)
     {
         //get the state
         NSLog(@" state=%d",state);
         
         if (!error)//if login error not occured
         {
             //get user information if login completed
             [FBRequestConnection startForMeWithCompletionHandler:^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *user, NSError *error)
              {
                  NSLog(@"FBUser info: %@",user);
                  
                  NSString *profilePicURL = [NSString stringWithFormat:@"http://graph.facebook.com/%@/picture?type=large", user.id];
                  
                  UIImage *profilePic = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:profilePicURL]]];
                  
                  if (profilePic)
                  {
                      NSLog(@"profilePicture yes = %@",profilePic);
                      
                  }
                  else
                  {
                      NSLog(@"profilePicture no = %@",profilePic);
                      
                  }
                  
                  
              }];
             
         }
         else //if error occoured show error
         {
             NSLog(@"Error in FBUser info: %@",error);
             
         }
     }];
    
    
}

#pragma mark    -   Facebook share permission
+(BOOL)isFacebookSharePermissionUsingFBWebview
{
    if ([[FBSession activeSession] state])
    {
        
        
        if ([[[FBSession activeSession] permissions] indexOfObject:@"publish_actions"] == NSNotFound || [[[FBSession activeSession] permissions] indexOfObject:@"publish_stream"])
        {
            NSLog(@"Posting permission is ON");
            
            return YES;
        }
        else
        {
            return NO;
            NSLog(@"Posting permission is OFF");
            //[VTErrorAlert showAlertWith_errorMessage:@"Your pubic post permission is denied" title:@"Erro"];
        }
    }
    else if ([[FBSession activeSession] state] == FBSessionStateCreated)
    {
        //[VTErrorAlert showAlertWith_errorMessage:@"You can't post right now, make sure your device has an internet connection and you have at least one Facebook account setup." title:@"Error"];
        
        return NO;
    }
    else
    {
        return NO;
    }
}
+(void)isFacebookSharePermissionUsingFBNativeCompletion:(void (^)(BOOL granted))permission
{

    
    ACAccountStore *accountStore = [[ACAccountStore alloc]init];
    
    ACAccountType *fbAccountType = [[ACAccountType alloc]init];
    
    __block ACAccount *facebookAccount = [[ACAccount alloc]init];
    
    //define account type facebook
    fbAccountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierFacebook];
    
    
    //permission for containt
    NSArray * permissions = @[@"publish_stream", @"publish_actions"];
    
    NSDictionary * options = @{ACFacebookAppIdKey : FB_APP_ID, ACFacebookPermissionsKey : permissions, ACFacebookAudienceKey : ACFacebookAudienceEveryone};
    

    
    [accountStore requestAccessToAccountsWithType:fbAccountType options:options completion:^(BOOL granted, NSError *error)
    {
            if (granted)
            {
                permission(YES);
            }
            else
            {
                permission(NO);
            }
    }];
    
    //return isFacebookPermission;
}
#pragma mark    -   Facebook Share
+(void)shareOnFacebookUsingNativeApp_viewController:(UIViewController *)viewController
{
    @try
    {
        if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
        {
            SLComposeViewController *objvc = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
            
            //setting the text to post
            [objvc setInitialText:SHARE_FB_MESSAGE];
            
            //adding the image present in the bundle to FB post
            [objvc addImage:[UIImage imageNamed:SHARE_FB_IMAGE]];
            
            //adding the URL to FB post
            [objvc addURL:[NSURL URLWithString:SHARE_FB_URL]];
            
            [viewController presentViewController:objvc animated:YES completion:nil];
            
            
            objvc.completionHandler = ^(SLComposeViewControllerResult result)
            {
                if (result == SLComposeViewControllerResultDone)
                {
                    
                    
                }
                else if (result == SLComposeViewControllerResultCancelled)
                {
                    //[VTErrorAlert showAlertWith_errorMessage:@"Facebook data postring canceled" title:@"Error"];
                }
                
            };
        }
        else
        {
            
            
            // check commented below line here
            
            //[VTShareOnSocial loginWithFacebookUsingFBWebview];
            //[VTErrorAlert showAlertWith_errorMessage:@"You can't post right now, make sure your device has an internet connection and you have at least one Facebook account setup" title:@"Error"];
        }
    }
    @catch (NSException *exception)
    {
        NSLog(@"Facebook share exception = %@",exception);
    }
    
}



#pragma mark    -   Twitter Share
+(void)shareOnTwitter_viewController:(UIViewController *)viewController
{
    @try
    {
        if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
        {
            
            SLComposeViewController *objvc = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
            
            //setting the text to post
            [objvc setInitialText:SHARE_TWITTER_MESSAGE];
            
            //adding the image present in the bundle to FB post
            [objvc addImage:[UIImage imageNamed:SHARE_TWITTER_IMAGE]];
            
            //adding the URL to FB post
            [objvc addURL:[NSURL URLWithString:SHARE_TWITTER_URL]];
            
            [viewController presentViewController:objvc animated:YES completion:nil];
            
            
            
            
            objvc.completionHandler = ^(SLComposeViewControllerResult result)
            {
                if (result == SLComposeViewControllerResultDone)
                {
                    //[VTErrorAlert showAlertWith_errorMessage:@"Your date is posted on Twitter." title:@"Error"];
                    
                }
                else if (result == SLComposeViewControllerResultCancelled)
                {
                    //[VTErrorAlert showAlertWith_errorMessage:@"Twitter posting cancelled" title:@"Error"];
                }
                
            };
        }
        else
        {
            //[VTErrorAlert showAlertWith_errorMessage:@"You can't post right now, make sure your device has an internet connection and you have at least one Twitter account setup" title:@"Error"];
        }
        
        
    }
    @catch (NSException *exception)
    {
        NSLog(@"Twitter share exception = %@",exception);
    }
}

#pragma mark    -   Instagram Share
- (void)shareOnInstagram_frame:(CGRect)frame parentView:(UIView *)parentView shareImage:(UIImage *)shareImage
{
    NSString* imagePath = [NSString stringWithFormat:@"%@/instagramShare.igo", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]];
    [[NSFileManager defaultManager] removeItemAtPath:imagePath error:nil];
    
    UIImage *instagramImage = [UIImage imageNamed:@"CheckedGreen.png"];
    [UIImagePNGRepresentation(instagramImage) writeToFile:imagePath atomically:YES];
    NSLog(@"Image Size >>> %@", NSStringFromCGSize(instagramImage.size));
    
    UIDocumentInteractionController *documentInteractionController = [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:imagePath]];
    documentInteractionController.delegate = self;
    documentInteractionController.UTI = @"com.instagram.exclusivegram";
    [documentInteractionController presentOpenInMenuFromRect:frame inView:parentView animated:YES ];
}



#pragma mark - Actons

@end
