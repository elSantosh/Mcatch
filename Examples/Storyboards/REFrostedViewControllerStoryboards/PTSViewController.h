//
//  PTSViewController.h
//  MCatch
//
//  Created by MCOM Admin on 20/04/2016.
//  Copyright © 2016 MCOM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REFrostedViewController.h"

@interface PTSViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *menu;
- (IBAction)menu:(id)sender;
@property (nonatomic, strong) NSMutableArray *result;
@property (weak, nonatomic) IBOutlet UITableView *PTSTable;
@end
