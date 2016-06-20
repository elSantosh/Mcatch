//
//  PDashboardViewController.h
//  MCatch
//
//  Created by MCOM Admin on 28/03/2016.
//  Copyright © 2016 Roman Efimov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REFrostedViewController.h"

@interface PDashboardViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *activities;
@property (weak, nonatomic) IBOutlet UILabel *clicks;
@property (weak, nonatomic) IBOutlet UILabel *impressions;

@property (weak, nonatomic) IBOutlet UILabel *totalCPA;
@property (weak, nonatomic) IBOutlet UILabel *earn;
- (IBAction)menu:(id)sender;
@end
