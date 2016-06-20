//
//  LoginViewController.h
//  MCatch
//
//  Created by MCOM Admin on 23/03/2016.
//  Copyright © 2016 Mcom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
{
     NSString *Id;
}


@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *password;

@property (nonatomic, retain) NSString  *Id;

- (IBAction)login:(id)sender;

@property (weak, nonatomic) IBOutlet UISwitch *accType;

@end
