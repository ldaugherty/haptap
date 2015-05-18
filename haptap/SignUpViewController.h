//
//  SignUpViewController.h
//  haptap
//
//  Created by Lucy Daugherty on 5/9/15.
//  Copyright (c) 2015 Lucy Daugherty. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpViewController : UIViewController

- (IBAction)alreadyHaveAccountPressed:(id)sender;

@property (strong, nonatomic) IBOutlet UITextField *usernameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UITextField *confirmPasswordTextField;
- (IBAction)signUpButtonPressed:(UIButton *)sender;

@property (strong, nonatomic) IBOutlet UILabel *errorMessageLabel;


@end
