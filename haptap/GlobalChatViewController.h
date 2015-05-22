//
//  GlobalChatTableViewController.h
//  haptap
//
//  Created by Lucy Daugherty on 5/20/15.
//  Copyright (c) 2015 Lucy Daugherty. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GlobalChatViewController : UIViewController

- (IBAction)sendMessage:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *sendMessageLabel;
@property (strong, nonatomic) IBOutlet UILabel *charactersLeftLabel;

@end
