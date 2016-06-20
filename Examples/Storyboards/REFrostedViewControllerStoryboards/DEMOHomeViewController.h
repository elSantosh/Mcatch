//
//  DEMOHomeViewController.h
//  REFrostedViewControllerStoryboards
//
//  Created by Roman Efimov on 10/9/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REFrostedViewController.h"

@interface DEMOHomeViewController : UIViewController
{
    NSString *AdvId2;
}
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *Spinner;
@property (nonatomic, retain) NSString *AdvId2;
@property (strong) UIActivityIndicatorView *mySpinner;

- (IBAction)showMenu;
@property (weak, nonatomic) IBOutlet UILabel *Activities;
@property (weak, nonatomic) IBOutlet UILabel *Clicks;
@property (weak, nonatomic) IBOutlet UILabel *Impressions;
@property (weak, nonatomic) IBOutlet UILabel *CPA;
@property (weak, nonatomic) IBOutlet UILabel *Bal;
@property (weak, nonatomic) IBOutlet UILabel *Spent;

@end
