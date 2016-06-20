//
//  TopupSummaryViewController.h
//  MCatch
//
//  Created by MCOM Admin on 25/03/2016.
//  Copyright © 2016 Roman Efimov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REFrostedViewController.h"

@interface TopupSummaryViewController : UIViewController

- (IBAction)menu:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *topupTable;

@property (nonatomic, strong) NSMutableArray *result;

@end
