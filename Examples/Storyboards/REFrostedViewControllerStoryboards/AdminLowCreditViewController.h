//
//  AdminLowCreditViewController.h
//  MCatch
//
//  Created by MCOM Admin on 13/04/2016.
//  Copyright © 2016 MCOM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REFrostedViewController.h"

@interface AdminLowCreditViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *menu;
- (IBAction)menu:(id)sender;
@property (nonatomic, strong) NSMutableArray *result;
@property (weak, nonatomic) IBOutlet UITableView *FLCTable;
@end
