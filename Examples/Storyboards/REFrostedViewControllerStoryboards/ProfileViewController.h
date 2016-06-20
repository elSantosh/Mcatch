//
//  ProfileViewController.h
//  MCatch
//
//  Created by MCOM Admin on 25/03/2016.
//  Copyright © 2016 Roman Efimov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REFrostedViewController.h"

@interface ProfileViewController : UIViewController

@property(nonatomic, strong) NSString *urlString;
@property(nonatomic,strong) NSString *advName;

- (IBAction)menu:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *accName;

@property (weak, nonatomic) IBOutlet UITextField *fullName;
@property (weak, nonatomic) IBOutlet UITextField *mobileNumber;
@property (weak, nonatomic) IBOutlet UITextField *officeNumber;
@property (weak, nonatomic) IBOutlet UITextField *address;

@property (weak, nonatomic) IBOutlet UITextField *location;

- (IBAction)save:(id)sender;
@end
