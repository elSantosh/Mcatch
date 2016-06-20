//
//  PTEViewController.h
//  MCatch
//
//  Created by MCOM Admin on 20/04/2016.
//  Copyright © 2016 MCOM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REFrostedViewController.h"

@interface PTEViewController : UIViewController
@property (nonatomic, strong) NSMutableArray *result;
@property (weak, nonatomic) IBOutlet UIButton *menu;
- (IBAction)menu:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *PTETable;
@end
