//
//  MyOffersViewController.h
//  MCatch
//
//  Created by MCOM Admin on 28/03/2016.
//  Copyright © 2016 Roman Efimov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REFrostedViewController.h"

@interface MyOffersViewController : UIViewController

@property (nonatomic,strong) NSMutableArray *result;

@property (weak, nonatomic) IBOutlet UITableView *myOffersTable;

- (IBAction)menu:(id)sender;

@end
