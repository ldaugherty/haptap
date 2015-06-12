//
//  ViewController.h
//  haptap
//
//  Created by Lucy Daugherty on 4/27/15.
//  Copyright (c) 2015 Lucy Daugherty. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface ViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>
- (IBAction)differentEmotionButton:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *howAreYouLabel;

- (IBAction)submitEmotionButton:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *oncePerHourLabel;

//slider
@property (strong, nonatomic) IBOutlet UISlider *slider;
- (IBAction)sliderValueChanged:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *sliderLabel;
@property (strong, nonatomic) IBOutlet UILabel *extremelyLabel;
@property (strong, nonatomic) IBOutlet UILabel *barelyLabel;


-(IBAction)logoutPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *welcomeLabel;
@property (strong, nonatomic) IBOutlet UILabel *thankYouLabel;

- (IBAction)yesReasonButtonPressed:(id)sender;
- (IBAction)noReasonButtonPressed:(id)sender;
- (IBAction)submitReasonButtonPressed:(id)sender;
- (IBAction)actuallyNoReasonButtonPressed:(id)sender;
- (IBAction)neutralButtonPressed:(UIButton *)sender;


@property (strong, nonatomic) IBOutlet UILabel *reasonLabel;
@property (strong, nonatomic) IBOutlet UITextView *reasonTextField;
@property (strong, nonatomic) IBOutlet UILabel *howAreYouFeelingLabel;
@property (strong, nonatomic) IBOutlet UIButton *yesReasonButton;
@property (strong, nonatomic) IBOutlet UIButton *noReasonButton;
@property (strong, nonatomic) IBOutlet UIButton *submitReasonButton;
@property (strong, nonatomic) IBOutlet UIButton *submitEmotionButton;
@property (strong, nonatomic) IBOutlet UIButton *actuallyNoReasonButton;
@property (strong, nonatomic) IBOutlet UIButton *neutralButton;

@property (strong, nonatomic) IBOutlet UICollectionView *gridView;
@property (strong, nonatomic) IBOutlet UIButton *differentEmotionButton;

//tabs
@property (strong, nonatomic) IBOutlet UITabBarItem *trendsTab;
@property (strong, nonatomic) IBOutlet UITabBarItem *chatTab;
@property (strong, nonatomic) IBOutlet UITabBarItem *moreTab;
@property (strong, nonatomic) IBOutlet UITabBarItem *homeTab;


@end

