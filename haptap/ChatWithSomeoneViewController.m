//
//  ChatWithSomeoneViewController.m
//  haptap
//
//  Created by Lucy Daugherty on 5/15/15.
//  Copyright (c) 2015 Lucy Daugherty. All rights reserved.
//

#import "ChatWithSomeoneViewController.h"

#import <Firebase/Firebase.h>
#import <Parse/Parse.h>
#import "MBProgressHUD.h"

#import "ChatViewController.h"
#import "EmotionDataManager.h"

#define FIREBASE_ROOT (@"https://haptap.firebaseIO.com/")

@interface ChatWithSomeoneViewController ()

@property (nonatomic, strong) NSString *firebase_path; // "chats/1234234324"  or  "global_chat"
@property (nonatomic, strong) NSString *chatTitle;
@property (nonatomic, strong) MBProgressHUD *searchingActivityView;
@property (nonatomic, strong) NSArray *pickerData;
@property (nonatomic, strong) Firebase *waitingUserFirebase;

@end

@implementation ChatWithSomeoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // Do any additional setup after loading the view.
    // Initialize Data
    self.pickerData = @[@"loving", @"happy", @"excited", @"amused", @"any way!", @"confused", @"anxious", @"annoyed", @"angry", @"sad"];
    [self.picker selectRow:4 inComponent:0 animated:NO];
    [self.picker reloadAllComponents];
    [self.tipsWrapper setHidden:YES];
    [self.hideTipsOutlet setHidden:YES];
    
    //

}

#pragma mark - Picker View
// The number of columns of data
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.pickerData.count;
}

// The data to return for the row and component (column) that's being passed in
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.pickerData[row];
}

#pragma mark - IBActions

- (IBAction)showTipsButton:(id)sender {
    [self.tipsWrapper setHidden:NO];
    [self.hideTipsOutlet setHidden:NO];
}
- (IBAction)hideTipsButton:(id)sender {
    [self.tipsWrapper setHidden:YES];
    [self.hideTipsOutlet setHidden:YES];
    
}
- (IBAction)chatWithEveryoneButton:(id)sender {
    self.chatTitle = @"Global Chat";
    self.firebase_path = @"global_chat";
    [self performSegueWithIdentifier:@"ChatRoomSegue" sender:self];
//    [self.navigationController performSegueWithIdentifier:@"ChatRoomSegue" sender:self];
}

- (IBAction)findMeSomeoneButton:(id)sender {
    if ([[EmotionDataManager dataManager] getEmotionForCurrentHour]) {
        
        NSString *theirEmotion = [self.pickerData objectAtIndex:[self.picker selectedRowInComponent:0]];
        
        // TODO: change any way to your real emotion
        
        [self findChatWithEmotion:theirEmotion];
        self.chatTitle = @"Chat With Someone";
    }
    
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Woah" message:@"You have to enter how you're feeling to use this feature!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Go to home page", @"Cancel", nil];
        [alert show];
    }
    
}

-(void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:    (NSInteger)buttonIndex
{
    if(buttonIndex==1)
    {
        //release alert if "Cancel" is pressed
    }
    else if(buttonIndex==0)
    {
        [self.tabBarController setSelectedIndex:0];
    }
}


#pragma mark - Searching Indicator

- (void) showSearchingIndicator {
        self.view.alpha = 0.50f;
        self.searchingActivityView = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        self.searchingActivityView.labelText = @"Searching for a buddy...";
        self.searchingActivityView.detailsLabelText = @"Tap anywhere to cancel";
        [self.searchingActivityView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hudWasCancelled)]];
}

- (void)hideSearchingIndicator {
    [self.searchingActivityView hide:YES];
    self.view.alpha = 1.f;
}

- (void)hudWasCancelled {
    [self deleteWaitingFirebaseUser];
    [self hideSearchingIndicator];
}

#pragma mark - Firebase

- (void)deleteWaitingFirebaseUser {
    [self.waitingUserFirebase removeAllObservers];
    [self.waitingUserFirebase removeValue];
}

- (void)initiateNewChatWithFirebaseUser:(FDataSnapshot *)user {
    
    Firebase *newChat = [[[[Firebase alloc] initWithUrl:FIREBASE_ROOT] childByAppendingPath:@"chats"] childByAutoId];
    
    NSString *introMsg = [NSString stringWithFormat:@"%@, meet %@. %@, meet %@.", [PFUser currentUser].username, user.value[@"username"], user.value[@"username"], [PFUser currentUser].username];
    newChat.value = @{@"msg0" : @{
                              @"msg" : introMsg,
                              @"user" : @"HapTap"
                              }
                      };
    
    NSDictionary *dict = @{ @"chat": newChat.key ,
                            @"username2" : [PFUser currentUser].username
                            };

    [user.ref updateChildValues:dict];
    
    self.chatTitle = [NSString stringWithFormat:@"Chat with %@",user.value[@"username"]];
    self.firebase_path = [NSString stringWithFormat:@"chats/%@", newChat.key];
    [self performSegueWithIdentifier:@"ChatRoomSegue" sender:self];
    
}

- (void)createWaitingFirebaseUserWithEmotion:(NSString *)emotion lookingForEmotion:(NSString *)lookingForEmotion {
    Firebase *emotionFirebase = [[[[Firebase alloc] initWithUrl:FIREBASE_ROOT] childByAppendingPath:@"users_waiting"] childByAppendingPath:emotion];
    self.waitingUserFirebase = [emotionFirebase childByAutoId];
    self.waitingUserFirebase.value = @{
                             @"emotion_wanted" : lookingForEmotion,
                             @"username" : [PFUser currentUser].username
                             };
    [self.waitingUserFirebase observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        if (!snapshot.exists) return;
        NSString *chatPath = snapshot.value[@"chat"];
        if ([chatPath length]) {
            self.chatTitle = [NSString stringWithFormat:@"Chat with %@",snapshot.value[@"username2"]];
            self.firebase_path = [NSString stringWithFormat:@"chats/%@", chatPath];
            [self performSegueWithIdentifier:@"ChatRoomSegue" sender:self];
        }
    }];
}

- (void)findChatWithAnyOtherEmotionForMyEmotion {
    Firebase *allEmotionsFirebase = [[[Firebase alloc] initWithUrl:FIREBASE_ROOT] childByAppendingPath:@"users_waiting"];
    NSString *myEmotion = [[EmotionDataManager dataManager] getEmotionForCurrentHour].title;
    [allEmotionsFirebase observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        for (FDataSnapshot *userList in snapshot.children) {
            for (FDataSnapshot *user in userList.children) {
                if ([user.value[@"emotion_wanted"] isEqualToString:myEmotion] || [user.value[@"emotion_wanted"] isEqualToString:@"any way!"]) {
                    if ([user.value[@"chat"] length]) {
                        continue;
                    }
                    [self initiateNewChatWithFirebaseUser:user];
                    return;
                }
            }
        }
        [self createWaitingFirebaseUserWithEmotion:myEmotion lookingForEmotion:@"any way!"];
    }];
}

- (void)findChatWithEmotion:(NSString *)theirEmotion {
 
    [self showSearchingIndicator];
    
    if ([theirEmotion isEqualToString:@"any way!"]) {
     [self findChatWithAnyOtherEmotionForMyEmotion];
        return;
    }
    NSString *myEmotion = [[EmotionDataManager dataManager] getEmotionForCurrentHour].title;

    Firebase *emotionFirebase = [[[[Firebase alloc] initWithUrl:FIREBASE_ROOT] childByAppendingPath:@"users_waiting"] childByAppendingPath:theirEmotion];
    
    [emotionFirebase observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        for (FDataSnapshot *user in snapshot.children) {
            if ([user.value[@"emotion_wanted"] isEqualToString:myEmotion] || [user.value[@"emotion_wanted"] isEqualToString:@"any way!"]) {
                if ([user.value[@"chat"] length]) {
                    continue;
                }
                [self initiateNewChatWithFirebaseUser:user];
                return;
            }
            
           
        }
        [self createWaitingFirebaseUserWithEmotion:myEmotion lookingForEmotion:theirEmotion];
    }];
}



#pragma mark - view stuffs

- (void)viewWillDisappear:(BOOL)animated {
    [self deleteWaitingFirebaseUser];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"ChatRoomSegue"])
    {
        // Get reference to the destination view controller
        ChatViewController *vc = [segue destinationViewController];
        vc.chatTitle = self.chatTitle;
        vc.firebase_path = self.firebase_path;
        [self hideSearchingIndicator];
    }
}

@end
