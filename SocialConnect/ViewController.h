//
//  ViewController.h
//  SocialConnect
//
//  Created by Manuel Santos on 4/16/15.
//  Copyright (c) 2015 Manuel Santos. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface ViewController : UIViewController <FBSDKLoginButtonDelegate>


@property (weak, nonatomic) IBOutlet FBSDKLoginButton *fbLoginButton;

- (IBAction)viewProfileTapped:(UIButton *)sender;



@end

