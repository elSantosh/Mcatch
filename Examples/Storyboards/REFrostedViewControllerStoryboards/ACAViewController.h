//
//  ACAViewController.h
//  MCatch
//
//  Created by MCOM Admin on 20/04/2016.
//  Copyright © 2016 MCOM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REFrostedViewController.h"

@interface ACAViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *menu;
@property (nonatomic, strong) NSMutableArray *result;
- (IBAction)menu:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *ACATable;
@end
