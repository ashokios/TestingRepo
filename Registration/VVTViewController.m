//
//  VVTViewController.m
//  Registration
//
//  Created by Vipra Ferro Alloys on 23/04/14.
//  Copyright (c) 2014 ValvirtTechnologies. All rights reserved.
//

#import "VVTViewController.h"
#import "VTShareOnSocial.h"
#import "VVTUser.h"
#import "VVTAppDelegate.h"

@interface VVTViewController ()

@end

@implementation VVTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)loginWithFbClick:(id)sender
{
    
    NSString *controllerId = @"MainTabBarController";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *initViewController = [storyboard instantiateViewControllerWithIdentifier:controllerId];
    
    VVTAppDelegate *app = [[UIApplication sharedApplication] delegate];
    app.window.rootViewController = initViewController;
    [app.window makeKeyAndVisible];
    
    
//    [VTShareOnSocial loginWithFacebookUsingNativeAppSuccessfully:^(BOOL granted, NSDictionary *userDetails) {
//        if(granted && userDetails) {
//            // fetched user details success fully insert them to server
//            [self insertUserWithParameters:userDetails];
//        } else {
//            // Failed to connect facebook through native app so open dialogue using sdk
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [VTShareOnSocial loginWithFacebookUsingFBWebviewSuccessfully:^(BOOL fetched, NSDictionary *userDetails, NSError *error) {
//                   
//                    if(!error && userDetails) {
//                        // fetched user details success fully insert them to server
//                        [self insertUserWithParameters:userDetails];
//                       
//                    } else {
//                        NSLog(@"failed conecting with fb using sdk with error:%@",[error localizedDescription]);
//                    }
//                }];
//            });
//            
//        }
//    }];
}

#pragma mark Webservices

- (void)insertUserWithParameters:(NSDictionary *)parameters
{
    NSLog(@"parameters to server:%@",parameters);
    [VVTUser insertUser:parameters withCompletionBlock:^(BOOL success, VVTUser *user, BOOL userAlreadyRegistered, NSError *error) {
        if(success && user) {
            NSLog(@"%@",user);// may be i get complete details once I implement profile,
            if(userAlreadyRegistered) {
                // present main tab
                NSLog(@"main tab");
                [self performSegueWithIdentifier:@"Push.ShowInterestsVC" sender:self];
            } else {
                // continue registration next steps
                NSLog(@"registration");
                [self performSegueWithIdentifier:@"Push.ShowInterestsVC" sender:self];
            }
            
        } else {
            NSLog(@"failed inserting user with error:%@",[error localizedDescription]);
        }
    }];

}


- (IBAction)registerClick:(id)sender
{
    
}
@end
