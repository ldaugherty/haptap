//
//  LogInViewController.h
//  haptap
//
//  Created by Lucy Daugherty on 5/9/15.
//  Copyright (c) 2015 Lucy Daugherty. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogInViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *usernameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;

- (IBAction)signInButtonPressed:(UIButton *)sender;

@property (strong, nonatomic) IBOutlet UILabel *errorMessageLabel;



@end
