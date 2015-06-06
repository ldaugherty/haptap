//
//  ViewController.m
//  haptap
//
//  Created by Lucy Daugherty on 4/27/15.
//  Copyright (c) 2015 Lucy Daugherty. All rights reserved.
//

#import "ViewController.h"
#import "SignUpViewController.h"
#import "ChatWithSomeoneViewController.h"

@interface Emotion : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIImage *image;

@end

@implementation Emotion


@end

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray *emotions;
@property (nonatomic, strong) Emotion *selectedEmotion;
@property (nonatomic,strong) UIImageView *emojiImageUp;
@end



@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *emotionNames = @[@"sad", @"angry", @"annoyed", @"anxious", @"confused", @"amused", @"excited", @"happy", @"loving", @"neutral"];
    
    self.emotions = [NSMutableArray array];
    
    for (NSString *emotionName in emotionNames) {
        [self.emotions addObject:[self emotionWithTitle:emotionName image:[UIImage imageNamed:emotionName]]];
    }
    
    [self.gridView reloadData];
    
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
    [self.submitEmotionLabel setHidden:YES];
   }

- (Emotion *)emotionWithTitle:(NSString *)title image:(UIImage *)image {
    Emotion *emotion = [Emotion new];
    emotion.title = title;
    emotion.image = image;
    return emotion;
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

- (IBAction)differentEmotionButton:(id)sender {
    self.barelyLabel.hidden = YES;
    self.extremelyLabel.hidden = YES;
    self.gridView.hidden = NO;
    self.gridView.alpha = 1;
    self.differentEmotionLabel.hidden = YES;
    self.howAreYouFeelingLabel.hidden = NO;
    self.howAreYouFeelingLabel.text = @"How are you feeling?";
    self.slider.hidden = YES;
    self.neutralLabel.hidden = NO;
    self.submitEmotionLabel.hidden = YES;
    self.howAreYouLabel.hidden = NO;
    [self.emojiImageUp removeFromSuperview];
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
    self.barelyLabel.hidden = YES;
    self.extremelyLabel.hidden = YES;
    self.differentEmotionLabel.hidden = YES;
    self.emojiImageUp.hidden = YES;
    [self.emojiImageUp removeFromSuperview];
   
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
    [self.reasonTextField becomeFirstResponder];
    
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
     self.oncePerHourLabel.hidden = NO;
}
- (IBAction)submitReasonButton:(id)sender {
    [self.reasonTextField setHidden:YES];
    [self.actuallyNoReasonLabel setHidden:YES];
    [self.goToMyTrendsPageLabel setHidden:NO];
    [self.goToChatWithSomeoneLabel setHidden:NO];
    [self.reasonLabel setHidden:YES];
    [self.submitReasonLabel setHidden:YES];
    [self.thankYouLabel setHidden:YES];
 self.oncePerHourLabel.hidden = NO;
    [self.reasonTextField resignFirstResponder];
   
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
     self.oncePerHourLabel.hidden = NO;
}

- (IBAction)neutralButton:(UIButton *)sender {
    self.gridView.hidden = YES;
    self.neutralLabel.hidden = YES;
    self.howAreYouFeelingLabel.hidden = YES;
    self.submitEmotionLabel.hidden = YES;
    self.goToChatWithSomeoneLabel.hidden = NO;
    self.goToMyTrendsPageLabel.hidden = NO;
    self.howAreYouLabel.hidden = YES;
    //    [self performSegueWithIdentifier:@"viewControllerToChatWithSomeone" sender:self.neutralLabel];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"Cell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(-10, 60, 100, 15)];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:11];
    [cell.contentView addSubview:label];

    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 60, 60)];
    [cell.contentView addSubview:imageView];
   
    Emotion *emotion = [self.emotions objectAtIndex:indexPath.item];
    label.text = emotion.title;
    imageView.image = emotion.image;
    
    return cell;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.emotions count];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Selected emotion: %@", self.emotions[indexPath.item]);
    self.selectedEmotion = self.emotions[indexPath.item];
    self.slider.alpha = 0;
    self.slider.hidden = NO;
    self.barelyLabel.hidden = NO;
    self.extremelyLabel.hidden = NO;
    self.neutralLabel.hidden = YES;
    
    UIView *cellContent = [self.gridView cellForItemAtIndexPath:indexPath].contentView;
    UIImageView *emojiImageView;
    for (UIView *view in cellContent.subviews) {
        if ([view isMemberOfClass:[UIImageView class]]) {
            emojiImageView = (UIImageView *) view;
            break;
        }
    }
    
    if (!emojiImageView) {
        NSLog(@"WUTTT");
        return;
    }
    
    CGPoint p = [emojiImageView.superview convertPoint:emojiImageView.center toView:self.view];
    
    self.emojiImageUp = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    self.emojiImageUp.image = emojiImageView.image;
    
    self.emojiImageUp.center = p;
    
    [self.view addSubview:self.emojiImageUp];
    
    CGPoint center = self.howAreYouFeelingLabel.center;
    
    [UIView animateWithDuration:0.2 animations:^{
        self.gridView.alpha = 0;
        self.slider.alpha = 1;
        self.howAreYouFeelingLabel.text = [NSString stringWithFormat:@"How %@ are you?", self.selectedEmotion.title];
        CGFloat size = 60;
        self.howAreYouLabel.hidden = YES;
        
        self.emojiImageUp.frame = CGRectMake((self.view.frame.size.width / 2.f) - (size/2.f), 162, size, size);
    } completion:^(BOOL finished) {
        self.gridView.hidden = YES;
        self.differentEmotionLabel.hidden = NO;
    }];
    self.submitEmotionLabel.hidden = NO;
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"viewControllerToChatWithSomeone"]) {
        ChatWithSomeoneViewController *vc = [segue destinationViewController];
        
        if (self.selectedEmotion.title!= nil) {
            vc.myCurrentEmotion = self.selectedEmotion.title;
            NSLog(@"%@", vc.myCurrentEmotion);
        }
        else if ([sender isEqual:self.neutralLabel]) {
            vc.myCurrentEmotion = @"neutral";
            NSLog(@"%@", vc.myCurrentEmotion);
        }
    }
}

@end
