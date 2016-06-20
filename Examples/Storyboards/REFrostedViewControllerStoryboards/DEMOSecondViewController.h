//
//  DEMOSecondViewController.h
//  REFrostedViewControllerStoryboards
//
//  Created by Roman Efimov on 10/9/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REFrostedViewController.h"

#import "DemoBaseViewController.h"
#import <Charts/Charts.h>

@interface DEMOSecondViewController : DemoBaseViewController

@property (nonatomic, strong) NSMutableArray *result;


- (IBAction)showMenu;

@property (weak, nonatomic) IBOutlet UITableView *CampaignInfoTable;

@end
