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

#import "ChatViewController.h"

#define FIREBASE_ROOT (@"https://haptap.firebaseIO.com/")

@interface ChatWithSomeoneViewController ()

@property (nonatomic, strong) NSString *firebase_path; // "chats/1234234324"  or  "global_chat"
@property (nonatomic, strong) NSString *chatTitle;

@property (nonatomic, strong) NSArray *pickerData;

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
    NSString *theirEmotion = [self.pickerData objectAtIndex:[self.picker selectedRowInComponent:0]];
    
    // TODO: change any way to your real emotion
    [self findChatWithEmotion:theirEmotion];
    
    self.chatTitle = @"Chat With Someone";
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
    Firebase *newWaitingUser = [emotionFirebase childByAutoId];
    newWaitingUser.value = @{
                             @"emotion_wanted" : lookingForEmotion,
                             @"username" : [PFUser currentUser].username
                             };
    [newWaitingUser observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        if (!snapshot.exists) return;
        NSString *chatPath = snapshot.value[@"chat"];
        if ([chatPath length]) {
            self.chatTitle = [NSString stringWithFormat:@"Chat with %@",snapshot.value[@"username2"]];
            self.firebase_path = [NSString stringWithFormat:@"chats/%@", chatPath];
            [snapshot.ref removeValue]; // delete so the list doesnt get huge.
            [self performSegueWithIdentifier:@"ChatRoomSegue" sender:self];
        }
    }];
}

- (void)findChatWithAnyOtherEmotionForMyEmotion {
    Firebase *allEmotionsFirebase = [[[Firebase alloc] initWithUrl:FIREBASE_ROOT] childByAppendingPath:@"users_waiting"];
    [allEmotionsFirebase observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        for (FDataSnapshot *userList in snapshot.children) {
            for (FDataSnapshot *user in userList.children) {
                if ([user.value[@"emotion_wanted"] isEqualToString:self.myCurrentEmotion] || [user.value[@"emotion_wanted"] isEqualToString:@"any way!"]) {
                    if ([user.value[@"chat"] length]) {
                        continue;
                    }
                    [self initiateNewChatWithFirebaseUser:user];
                    return;
                }
            }
        }
        [self createWaitingFirebaseUserWithEmotion:self.myCurrentEmotion lookingForEmotion:@"any way!"];
    }];
}

- (void)findChatWithEmotion:(NSString *)theirEmotion {
    if ([theirEmotion isEqualToString:@"any way!"]) {
        [self findChatWithAnyOtherEmotionForMyEmotion];
        return;
    }
    
    Firebase *emotionFirebase = [[[[Firebase alloc] initWithUrl:FIREBASE_ROOT] childByAppendingPath:@"users_waiting"] childByAppendingPath:theirEmotion];
    
    [emotionFirebase observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        for (FDataSnapshot *user in snapshot.children) {
            if ([user.value[@"emotion_wanted"] isEqualToString:self.myCurrentEmotion] || [user.value[@"emotion_wanted"] isEqualToString:@"any way!"]) {
                if ([user.value[@"chat"] length]) {
                    continue;
                }
                [self initiateNewChatWithFirebaseUser:user];
                return;
            }
        }
        [self createWaitingFirebaseUserWithEmotion:self.myCurrentEmotion lookingForEmotion:theirEmotion];
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"ChatRoomSegue"])
    {
        // Get reference to the destination view controller
        ChatViewController *vc = [segue destinationViewController];
        vc.chatTitle = self.chatTitle;
        vc.firebase_path = self.firebase_path;
    }
}

@end
