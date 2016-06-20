//
//  DEMOHomeViewController.m
//  REFrostedViewControllerStoryboards
//
//  Created by Roman Efimov on 10/9/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "DEMOHomeViewController.h"

#import "SVProgressHUD.h"

@interface DEMOHomeViewController ()

@end

@implementation DEMOHomeViewController

@synthesize AdvId2;

- (IBAction)showMenu
{
    // Dismiss keyboard (optional)
    //
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    
    // Present the view controller
    //
    [self.frostedViewController presentMenuViewController];
}

-(void)viewWillAppear:(BOOL)animated {
    
  //  [NSThread detachNewThreadSelector: @selector(Start) toTarget:self withObject:nil];

//    self.mySpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    
//    [self.mySpinner startAnimating];

    [super viewDidLoad];
    
    [SVProgressHUD show];
    
    self.navigationController.navigationBar.barTintColor = [UIColor orangeColor];
    
   // self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:237/255.0f green:127/255.0f blue:10/255.0f alpha:1.0f];
    
   // NSLog(@"home%@",AdvId2);
    //_Activities.text = @"asdfgh";
    NSInteger success = 0;
    @try {
                

      //  dispatch_async(dispatch_get_main_queue(), ^{
                    NSString *accID = [[NSUserDefaults standardUserDefaults] objectForKey:@"AccID"];
        NSString *urlString = [NSString stringWithFormat:@"http://mobilemcatch.mcommsg.com/Home.aspx?AdvertiserID=%@",accID];
        
        NSURL *url = [[NSURL alloc] initWithString:urlString];
        //NSLog(@"%@", urlString);
        [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
         {
             
             //NSLog(@"%@",data);
             if (error)
             {
                 //NSLog(@"error");
             }
             else
             {
                 
                 NSError *error = nil;
                 NSDictionary *jsonData = [NSJSONSerialization
                                           JSONObjectWithData:data
                                           options:NSJSONReadingMutableContainers
                                           error:&error];
        
                 NSString *Activities = jsonData[@"Activities"];
                 NSString *TotalClk = jsonData[@"TotalClk"] ;
                 NSString *TotalImp = jsonData[@"TotalImp"] ;
                 NSString *TotalCPA = jsonData[@"TotalCPA"] ;
                 NSString *CurrentBal = jsonData[@"CurrentBal"] ;
                 NSString *Totalspent = jsonData[@"Totalspent"] ;
   dispatch_async(dispatch_get_main_queue(), ^{
                 _Activities.text = Activities;
                     _Clicks.text = TotalClk;
                     _Impressions.text = TotalImp;
                     _CPA.text = TotalCPA;
                     _Bal.text = CurrentBal;
                     _Spent.text = Totalspent;
              //  NSLog(@"Login SUCCESS");
                 
       [SVProgressHUD dismiss];
   
   });
                  
             }
             
         }];
        
       // });
        
        
    }
    @catch (NSException * e) {
      //  NSLog(@"Exception: %@", e);
        [self alertStatus:@"Sign in Failed." :@"Error!" :0];
    }
    if (success) {
        
    }
  }
- (void) alertStatus:(NSString *)msg :(NSString *)title :(int) tag
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:msg
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil, nil];
    // UIAlertControllerStyle
    alertView.tag = tag;
    [alertView show];
    
}

- (void) Start
{
    _Spinner.hidden = NO;
    [_Spinner startAnimating];
}

- (void) Stop
{
    _Spinner.hidden = YES;
    [_Spinner stopAnimating];
}



@end
