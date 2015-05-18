//
//  ChatWithSomeoneViewController.h
//  haptap
//
//  Created by Lucy Daugherty on 5/15/15.
//  Copyright (c) 2015 Lucy Daugherty. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatWithSomeoneViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) IBOutlet UIPickerView *picker;

- (IBAction)showTipsButton:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *tipLabelOne;
@property (strong, nonatomic) IBOutlet UILabel *tipLabelTwo;
@property (strong, nonatomic) IBOutlet UILabel *tipLabelThree;
@property (strong, nonatomic) IBOutlet UILabel *tipLabelFour;

- (IBAction)hideTipsButton:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *hideTipsOutlet;

@end
