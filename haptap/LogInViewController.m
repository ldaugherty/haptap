//
//  LogInViewController.m
//  haptap
//
//  Created by Lucy Daugherty on 5/9/15.
//  Copyright (c) 2015 Lucy Daugherty. All rights reserved.
//

#import "LogInViewController.h"
#import <Parse/Parse.h>

@interface LogInViewController ()

@end

@implementation LogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    if ([PFUser currentUser]){
        [self dismissViewControllerAnimated:(NO) completion:nil];
    }
}

- (IBAction)signInButtonPressed:(UIButton *)sender; {

    NSString *username = self.usernameTextField.text;
    NSString *password = self.passwordTextField.text;

    if (username.length != 0 && password.length != 0) {
        // Begin login process
        self.errorMessageLabel.text = @"";
        if ([PFUser logInWithUsername:username password:password]) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        else {
            self.errorMessageLabel.text = @"Please try again.";
        }
    }
    else {
    self.errorMessageLabel.text = @"Please fill out both fields!";
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
