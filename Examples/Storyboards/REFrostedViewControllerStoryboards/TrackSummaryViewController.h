//
//  TrackSummaryViewController.h
//  MCatch
//
//  Created by MCOM Admin on 25/03/2016.
//  Copyright © 2016 Roman Efimov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REFrostedViewController.h"

@interface TrackSummaryViewController : UIViewController

@property (nonatomic,strong) NSMutableArray *result;

- (IBAction)menu:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *TrackSummaryTable;
@end
