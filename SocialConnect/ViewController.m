//
//  ViewController.m
//  SocialConnect
//
//  Created by Manuel Santos on 4/16/15.
//  Copyright (c) 2015 Manuel Santos. All rights reserved.
//

#import "ViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
   [super viewDidLoad];
   // Do any additional setup after loading the view, typically from a nib.
   
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observeProfileChange:) name:FBSDKProfileDidChangeNotification object:nil];
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observeTokenChange:) name:FBSDKAccessTokenDidChangeNotification object:nil];
   
   self.fbLoginButton.delegate = self;
   self.fbLoginButton.readPermissions = @[@"public_profile", @"email", @"user_friends"];

   
   if ([FBSDKAccessToken currentAccessToken]) {
      // User is logged in, do work such as go to next view controller.
      [self observeProfileChange:nil];
      
   }
}


- (void)dealloc {
   [[NSNotificationCenter defaultCenter] removeObserver:self];
}



- (void)didReceiveMemoryWarning {
   [super didReceiveMemoryWarning];
   // Dispose of any resources that can be recreated.
}




#pragma mark - FBSDKLoginButtonDelegate

- (void)loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error {
   if (error) {
      NSLog(@"Unexpected login error: %@", error);
      NSString *alertMessage = error.userInfo[FBSDKErrorLocalizedDescriptionKey] ?: @"There was a problem logging in. Please try again later.";
      NSString *alertTitle = error.userInfo[FBSDKErrorLocalizedTitleKey] ?: @"Oops";
      [[[UIAlertView alloc] initWithTitle:alertTitle
                                  message:alertMessage
                                 delegate:nil
                        cancelButtonTitle:@"OK"
                        otherButtonTitles:nil] show];
   } else {
      
      [self showProfile];
     
      
      //      if (_viewIsVisible) {
      //         [self performSegueWithIdentifier:@"showMain" sender:self];
      //      }

      
      
   }
}

- (void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton {
   //   if (_viewIsVisible) {
   //      [self performSegueWithIdentifier:@"continue" sender:self];
   //   }
   
   NSLog(@"%@", loginButton);
   
}


- (void) showProfile{
    [self performSegueWithIdentifier:@"showInfoSegue" sender:self];

}




#pragma mark - Observations

- (void)observeProfileChange:(NSNotification *)notfication {
   if ([FBSDKProfile currentProfile]) {
     // NSString *title = [NSString stringWithFormat:@"continue as %@", [FBSDKProfile currentProfile].name];
     // [self.continueButton setTitle:title forState:UIControlStateNormal];
      //NSLog(@"Profile %@", [FBSDKProfile currentProfile]);

//      [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:nil]
//       startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
//          if (!error) {
//             NSLog(@"fetched user:%@", result);
//          }
//       }];
      
   }
}

- (void)observeTokenChange:(NSNotification *)notfication {
   if (![FBSDKAccessToken currentAccessToken]) {
      //[self.continueButton setTitle:@"continue as a guest" forState:UIControlStateNormal];
   } else {
      [self observeProfileChange:nil];
   }
}






- (IBAction)viewProfileTapped:(UIButton *)sender {
   
   [self showProfile];
   
}
@end
