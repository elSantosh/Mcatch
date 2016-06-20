//
//  AdminTrackSumViewController.h
//  MCatch
//
//  Created by MCOM Admin on 13/04/2016.
//  Copyright © 2016 MCOM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REFrostedViewController.h"

@interface AdminTrackSumViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *menu;
@property (nonatomic, strong) NSMutableArray *result;
- (IBAction)menu:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *ATSumTable;
@end
