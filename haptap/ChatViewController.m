//
//  GlobalChatTableViewController.m
//  haptap
//
//  Created by Lucy Daugherty on 5/20/15.
//  Copyright (c) 2015 Lucy Daugherty. All rights reserved.
//

#import "ChatViewController.h"
#import <Firebase/Firebase.h>
#import <Parse/Parse.h>

#define FIREBASE_ROOT (@"https://haptap.firebaseIO.com/")
#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 \
blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 \
alpha:1.0]

@interface ChatViewController ()

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *textWrapperView;
@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (nonatomic, strong) NSMutableArray *messages; // Array of FDataSnapshots
@property (nonatomic, strong) Firebase *chatFirebase;
@property (nonatomic) CGFloat keyboardHeight;

@end


@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    self.navigationItem.title = self.chatTitle;
    
    self.chatFirebase = [[[Firebase alloc] initWithUrl:FIREBASE_ROOT] childByAppendingPath:self.firebase_path];
    
    self.messages = [[NSMutableArray alloc] init];
    [self.chatFirebase observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
        [self.messages addObject:snapshot];
        [self.tableView reloadData];
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[self.messages count]-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    [self sendMessage:nil];
    return NO;
}

- (void)keyboardWillShow:(NSNotification*)notification
{
    [self moveControls:notification up:YES];
}

- (void)keyboardWillHide:(NSNotification*)notification
{
    [self moveControls:notification up:NO];
}

- (void)moveControls:(NSNotification*)notification up:(BOOL)up
{
    NSDictionary* userInfo = [notification userInfo];
    CGFloat kbHeight = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size.height;

    kbHeight *= up ? -1 : 1;
    
    CGRect oldframe = self.textWrapperView.frame;
    oldframe.origin.y += kbHeight;
    
    CGRect tableViewFrame = self.tableView.frame;
    tableViewFrame.size.height += kbHeight;
    
    NSTimeInterval duration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationCurve animationCurve = [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    [UIView animateWithDuration:duration
                          delay:0
                        options:(animationCurve << 16)
                     animations:^{
                         self.tableView.frame = tableViewFrame;
                         self.textWrapperView.frame = oldframe;
                     }
                     completion:^(BOOL finished){
                         [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[self.messages count]-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.messages count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChatCell" forIndexPath:indexPath];
    FDataSnapshot *messageSnapshot = [self.messages objectAtIndex:indexPath.row];
    cell.textLabel.text = messageSnapshot.value[@"user"];
    
    // Limit to 1 line and end with ... if too long
    cell.textLabel.numberOfLines = 1;
    cell.textLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    
    cell.textLabel.font = [UIFont fontWithName:@"Arial" size:11];
    
    cell.detailTextLabel.text = messageSnapshot.value[@"msg"];
    cell.detailTextLabel.textColor = UIColorFromRGB(0xFFFFFF);
    cell.detailTextLabel.font = [UIFont fontWithName:@"Times New Roman" size:16];
    cell.backgroundColor = UIColorFromRGB(0xA9D0F5);
    return cell;
    
}

- (BOOL)textField:(UITextField *)textField
    shouldChangeCharactersInRange:(NSRange)range
    replacementString:(NSString *)string {
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (newString.length > 50) {
        // too long
        return NO;
    }
    
   
    _charactersLeftLabel.text = [NSString stringWithFormat:@"%lu",(50)-newString.length];
    
    if (textField.text.length >= 40) {
        // display red, getting long
        self.charactersLeftLabel.textColor = UIColorFromRGB(0xFE2E2E);
    }
     else if (textField.text.length < 40)
     {
         //display green, can be longer
         self.charactersLeftLabel.textColor = UIColorFromRGB(0x00FF40);
     }
    return YES;
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//- (BOOL)textFieldShouldBeginEditing:(UITextField *) textField {
//    [self moveTextFieldDueToKeyboardUp:YES];
//    return YES;
//    
//}
//
//- (void)textFieldDidEndEditing:(UITextField *) textField {
//    [self moveTextFieldDueToKeyboardUp:NO];
//}

- (IBAction)sendMessage:(id)sender {
    
    NSDictionary *messageData = @{
                                @"user": [PFUser currentUser].username,
                                @"msg": self.textField.text
                                  };
    [[self.chatFirebase childByAutoId] setValue:messageData];
    self.textField.text = @"";
    self.charactersLeftLabel.text = @"50";
    self.charactersLeftLabel.textColor = UIColorFromRGB(0x00FF40);
    
}
@end
