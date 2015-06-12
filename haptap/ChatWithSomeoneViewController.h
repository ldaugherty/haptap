//
//  ChatWithSomeoneViewController.h
//  haptap
//
//  Created by Lucy Daugherty on 5/15/15.
//  Copyright (c) 2015 Lucy Daugherty. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Firebase/Firebase.h>

@interface ChatWithSomeoneViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UIPickerView *picker;

@property (strong, nonatomic) IBOutlet UILabel *whiteBackground;
- (IBAction)showTipsButton:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *tipsWrapper;

- (IBAction)hideTipsButton:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *hideTipsOutlet;

//chat buttons
- (IBAction)chatWithEveryoneButton:(id)sender;
- (IBAction)findMeSomeoneButton:(id)sender;

@end
