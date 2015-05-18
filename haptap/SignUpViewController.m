//
//  SignUpViewController.m
//  haptap
//
//  Created by Lucy Daugherty on 5/9/15.
//  Copyright (c) 2015 Lucy Daugherty. All rights reserved.
//

#import "SignUpViewController.h"
#import <Parse/Parse.h>

@interface SignUpViewController ()

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)alreadyHaveAccountPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)signUpButtonPressed:(UIButton *)sender;{
    NSString *username = self.usernameTextField.text;
    NSString *password = self.passwordTextField.text;
    NSString *confirmPassword = self.confirmPasswordTextField.text;
    
    if (![password isEqualToString:confirmPassword])
    {
        self.errorMessageLabel.text=@"Please make sure your passwords match!";
    }
    else if(username.length == 0 || password.length == 0) {
        self.errorMessageLabel.text=@"Please fill in all fields!";
    }
    else if(username.length < 6 || password.length < 6) {
        self.errorMessageLabel.text=@"Username & password must be 6+ characters!";
    }
    else if(username.length > 16) {
        self.errorMessageLabel.text=@"Username must be under 16 characters!";
    }
    
    else{
        PFUser *newUser = [PFUser user];
        newUser.username = username;
        newUser.password = password;
        [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error) {
                [self dismissViewControllerAnimated:YES completion:nil];
                // Hooray! Let them use the app now.
            } else {
                NSString *errorString = [error userInfo][@"error"];   // Show the errorString somewhere and let the user try again.
                NSLog(errorString);
                self.errorMessageLabel.text = errorString;
                
            }
        }];
    }

};

//get values, make sure username is be, make sure password = confirmpass


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
