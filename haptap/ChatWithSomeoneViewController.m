//
//  ChatWithSomeoneViewController.m
//  haptap
//
//  Created by Lucy Daugherty on 5/15/15.
//  Copyright (c) 2015 Lucy Daugherty. All rights reserved.
//

#import "ChatWithSomeoneViewController.h"

@interface ChatWithSomeoneViewController ()

@end

@implementation ChatWithSomeoneViewController

{
    NSArray *_pickerData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // Do any additional setup after loading the view.
    // Initialize Data
    _pickerData = @[@"loving", @"happy", @"excited", @"amused", @"any way!", @"confused", @"anxious", @"annoyed", @"angry", @"sad"];
    [self.picker selectRow:4 inComponent:0 animated:NO];
    [self.picker reloadAllComponents];
    
    //
    [self.tipLabelOne setHidden:YES];
    [self.tipLabelTwo setHidden:YES];
    [self.tipLabelThree setHidden:YES];
    [self.tipLabelFour setHidden:YES];
    [self.hideTipsOutlet setHidden:YES];

}


// The number of columns of data
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _pickerData.count;
}

// The data to return for the row and component (column) that's being passed in
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return _pickerData[row];
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
    [self.tipLabelOne setHidden:NO];
    [self.tipLabelTwo setHidden:NO];
    [self.tipLabelThree setHidden:NO];
    [self.tipLabelFour setHidden:NO];
    [self.hideTipsOutlet setHidden:NO];
}
- (IBAction)hideTipsButton:(id)sender {
    [self.tipLabelOne setHidden:YES];
    [self.tipLabelTwo setHidden:YES];
    [self.tipLabelThree setHidden:YES];
    [self.tipLabelFour setHidden:YES];
    [self.hideTipsOutlet setHidden:YES];
}
- (IBAction)chatWithEveryoneButton:(id)sender {
}

- (IBAction)findMeSomeoneButton:(id)sender {
}
@end
