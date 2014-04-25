//
//  VVTRegistrationVC.m
//  Registration
//
//  Created by Vipra Ferro Alloys on 23/04/14.
//  Copyright (c) 2014 ValvirtTechnologies. All rights reserved.
//

#import "VVTRegistrationVC.h"
#import "VVTUser.h"

@interface VVTRegistrationVC ()
@property (weak, nonatomic) IBOutlet UITextField *tf_name;
@property (weak, nonatomic) IBOutlet UITextField *tf_password;
@property (weak, nonatomic) IBOutlet UITextField *tf_email;
@property (weak, nonatomic) IBOutlet UITextField *tf_dateOfBirth;
@property (weak, nonatomic) IBOutlet UITextField *tf_gender;
@end

@implementation VVTRegistrationVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doneClick:(UIBarButtonItem *)sender
{
   /* if([self.tf_name.text length] && [self.tf_password.text length] && [self.tf_email.text length] && [self.tf_dateOfBirth.text length] && [self.tf_gender.text length]) {
        
        NSDictionary *userDetails = @{@"NAME":self.tf_name.text,
                                      @"EMAIL":self.tf_email.text,
                                      @"GENDER":self.tf_gender.text,
                                      @"DOB":self.tf_dateOfBirth.text,
                                      };
        
        [VVTUser registerNewUser:userDetails withCompletionBlock:^(BOOL success, VVTUser *user, BOOL userAlreadyRegistered, NSError *error) {
            if(success) {
                if(userAlreadyRegistered) {
                    // show error that email alredy using app so press forgot password if want
                } else {
                    // present interest screen
                    [self performSegueWithIdentifier:@"Push.ShowInterestsVC" sender:self];
                    
                }
            }
        }];
        
    } else {
        
    }*/
    
    [self performSegueWithIdentifier:@"Push.ShowInterestsVC" sender:self];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
