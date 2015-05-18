//
//  ViewController.m
//  haptap
//
//  Created by Lucy Daugherty on 4/27/15.
//  Copyright (c) 2015 Lucy Daugherty. All rights reserved.
//

#import "ViewController.h"
#import "SignUpViewController.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    PFObject *emotion = [PFObject objectWithClassName:@"Emotion"];
    PFUser *user = [PFUser currentUser];
    emotion[@"feeling"] = [NSNumber numberWithInt:2];
    emotion[@"user"] = user ? user : [NSNull null];
    [emotion saveInBackground];
    
//set everything after emojis hidden on view
    [self.noReasonLabel setHidden:YES];
    [self.yesReasonLabel setHidden:YES];
    [self.submitReasonLabel setHidden:YES];
    [self.goToMyTrendsPageLabel setHidden:YES];
    [self.goToChatWithSomeoneLabel setHidden:YES];
    [self.reasonTextField setHidden:YES];
    [self.reasonLabel setHidden:YES];
    [self.actuallyNoReasonLabel setHidden:YES];
    [self.thankYouLabel setHidden:YES];
   }

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (![PFUser currentUser]) { // No user logged in
        // Create the log in view controller
        [self performSegueWithIdentifier:@"loginsegue" sender:self];
    }
    
    else {
        self.welcomeLabel.text = [NSString stringWithFormat:@"Welcome, %@!",[PFUser currentUser].username];
                                  
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submitEmotionButton:(id)sender {
    [self.noReasonLabel setHidden:NO];
    [self.yesReasonLabel setHidden:NO];
    [self.reasonLabel setHidden:NO];
    [self.howAreYouFeelingLabel setHidden:YES];
    [self.submitEmotionLabel setHidden:YES];
    [self.slider setHidden:YES];
    [self.sliderLabel setHidden:YES];
    [self.thankYouLabel setHidden:NO];
}

// enter all possible slider values & assign thumb image & label text with emotion



- (IBAction)sliderValueChanged:(id)sender {
    if (self.slider.value < 1) {
        self.sliderLabel.text = @"very sad";
        UIImage *thumbImageNormal = [UIImage imageNamed:@"Tsmile.jpg"];
        [self.slider setThumbImage:thumbImageNormal forState:UIControlStateNormal];
   
    }
    else if (self.slider.value > 1 && self.slider.value < 2) {
    self.sliderLabel.text= @"hateful";
    }
    else if (self.slider.value > 2 && self.slider.value < 3) {
        self.sliderLabel.text= @"sad";
    }
    else if (self.slider.value > 3 && self.slider.value < 4) {
        self.sliderLabel.text= @"angry";
    }
    else if (self.slider.value > 4 && self.slider.value < 5) {
        self.sliderLabel.text= @"annoyed";
    }
    else if (self.slider.value > 5 && self.slider.value < 6) {
        self.sliderLabel.text= @"disgusted";
    }
    else if (self.slider.value > 6 && self.slider.value < 7) {
        self.sliderLabel.text= @"scared";
    }
    else if (self.slider.value > 7 && self.slider.value < 8) {
        self.sliderLabel.text= @"anxious/nervous";
    }
    else if (self.slider.value > 8 && self.slider.value < 9) {
        self.sliderLabel.text= @"wild";
    }
    else if (self.slider.value > 9 && self.slider.value < 10) {
        self.sliderLabel.text= @"confused";
    }
    else if (self.slider.value > 10 && self.slider.value < 11) {
        self.sliderLabel.text= @"fine";
    }
    else if (self.slider.value > 11 && self.slider.value < 12) {
        self.sliderLabel.text= @"content";
    }
    else if (self.slider.value > 12 && self.slider.value < 13) {
        self.sliderLabel.text= @"surprised";
    }
    else if (self.slider.value > 13 && self.slider.value < 14) {
        self.sliderLabel.text= @"amused";
    }
    else if (self.slider.value > 14 && self.slider.value < 15) {
        self.sliderLabel.text= @"excited";
    }
    else if (self.slider.value > 15 && self.slider.value < 16) {
        self.sliderLabel.text= @"happy";
    }
    else if (self.slider.value > 16 && self.slider.value < 17) {
        self.sliderLabel.text= @"loving";
    }
    else if (self.slider.value > 17) {
        self.sliderLabel.text= @"ecstatic";
    }
}
    


- (IBAction)logoutPressed:(id)sender {
    [PFUser logOut];
    [self performSegueWithIdentifier:@"loginsegue" sender:self];
}

- (IBAction)yesReasonButton:(id)sender {
    [self.yesReasonLabel setHidden:YES];
    [self.noReasonLabel setHidden:YES];
    [self.reasonTextField setHidden:NO];
    [self.submitReasonLabel setHidden:NO];
    [self.actuallyNoReasonLabel setHidden:NO];
}

- (IBAction)noReasonButton:(id)sender {
    [self.yesReasonLabel setHidden:YES];
    [self.noReasonLabel setHidden:YES];
    [self.goToMyTrendsPageLabel setHidden:NO];
    [self.goToChatWithSomeoneLabel setHidden:NO];
    [self.reasonLabel setHidden:YES];
    [self.thankYouLabel setHidden:YES];
}
- (IBAction)submitReasonButton:(id)sender {
    [self.reasonTextField setHidden:YES];
    [self.actuallyNoReasonLabel setHidden:YES];
    [self.goToMyTrendsPageLabel setHidden:NO];
    [self.goToChatWithSomeoneLabel setHidden:NO];
    [self.reasonLabel setHidden:YES];
    [self.submitReasonLabel setHidden:YES];
    [self.thankYouLabel setHidden:YES];
}

- (IBAction)goToMyTrendsPageButton:(id)sender {
    
}

- (IBAction)goToChatWithSomeoneButton:(id)sender {
    
}
- (IBAction)actuallyNoReasonButton:(id)sender {
    [self.reasonTextField setHidden:YES];
    [self.submitReasonLabel setHidden:YES];
    [self.actuallyNoReasonLabel setHidden:YES];
    [self.reasonLabel setHidden:YES];
    [self.goToChatWithSomeoneLabel setHidden:NO];
    [self.goToMyTrendsPageLabel setHidden:NO];
    [self.thankYouLabel setHidden:YES];
    
}
@end
