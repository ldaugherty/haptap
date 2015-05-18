//
//  ViewController.h
//  haptap
//
//  Created by Lucy Daugherty on 4/27/15.
//  Copyright (c) 2015 Lucy Daugherty. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface ViewController : UIViewController
- (IBAction)submitEmotionButton:(id)sender;

//slider
@property (strong, nonatomic) IBOutlet UISlider *slider;
- (IBAction)sliderValueChanged:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *sliderLabel;


-(IBAction)logoutPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *welcomeLabel;
@property (strong, nonatomic) IBOutlet UILabel *thankYouLabel;

@property (strong, nonatomic) IBOutlet UILabel *reasonLabel;
- (IBAction)yesReasonButton:(id)sender;
- (IBAction)noReasonButton:(id)sender;
@property (strong, nonatomic) IBOutlet UITextView *reasonTextField;
- (IBAction)submitReasonButton:(id)sender;
- (IBAction)goToMyTrendsPageButton:(id)sender;
- (IBAction)goToChatWithSomeoneButton:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *howAreYouFeelingLabel;
- (IBAction)actuallyNoReasonButton:(id)sender;


// have to link all buttons as labels all well to hide them on view
@property (strong, nonatomic) IBOutlet UIButton *yesReasonLabel;
@property (strong, nonatomic) IBOutlet UIButton *noReasonLabel;
@property (strong, nonatomic) IBOutlet UIButton *submitReasonLabel;
@property (strong, nonatomic) IBOutlet UIButton *goToMyTrendsPageLabel;
@property (strong, nonatomic) IBOutlet UIButton *goToChatWithSomeoneLabel;
@property (strong, nonatomic) IBOutlet UIButton *submitEmotionLabel;
@property (strong, nonatomic) IBOutlet UIButton *actuallyNoReasonLabel;



@end

