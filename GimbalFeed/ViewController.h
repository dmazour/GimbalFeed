//
//  ViewController.h
//  GimbalFeed
//
//  Created by Daniel Mazour on 6/15/15.
//  Copyright (c) 2015 Daniel Mazour. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Gimbal/Gimbal.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UITextField *nameLabel;
@property (strong, nonatomic) IBOutlet UITextField *nurseLabel;
@property (strong, nonatomic) IBOutlet UITextField *phoneLabel;
@property (strong, nonatomic) IBOutlet UITextField *NPOLabel;
@property (strong, nonatomic) IBOutlet UITextField *allergiesLabel;
- (IBAction)updateButton:(UIButton *)sender;

- (IBAction)clearButton:(UIButton *)sender;

@end

