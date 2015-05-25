//
//  GlobalChatTableViewController.h
//  haptap
//
//  Created by Lucy Daugherty on 5/20/15.
//  Copyright (c) 2015 Lucy Daugherty. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatViewController : UIViewController

- (IBAction)sendMessage:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *sendMessageLabel;
@property (strong, nonatomic) IBOutlet UILabel *charactersLeftLabel;

@property (nonatomic, strong) NSString *firebase_path; // "chats/1234234324"  or  "global_chat"
@property (nonatomic, strong) NSString *chatTitle;

@end
