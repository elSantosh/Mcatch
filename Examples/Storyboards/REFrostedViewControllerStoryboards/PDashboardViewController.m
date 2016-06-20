//
//  PDashboardViewController.m
//  MCatch
//
//  Created by MCOM Admin on 28/03/2016.
//  Copyright © 2016 Roman Efimov. All rights reserved.
//

#import "PDashboardViewController.h"
#import "SVProgressHUD.h"

@interface PDashboardViewController ()

@end

@implementation PDashboardViewController

- (void)viewWillAppear:(BOOL)animated {
    
    self.navigationController.navigationBar.barTintColor = [UIColor orangeColor];
    
    [SVProgressHUD show];
//    [NSThread detachNewThreadSelector: @selector(Start) toTarget:self withObject:nil];
    
    [super viewDidLoad];
    
   // NSInteger success = 0;

        
        dispatch_async(dispatch_get_main_queue(), ^{
            // code here
            NSString *accID = [[NSUserDefaults standardUserDefaults] objectForKey:@"AccID"];
            
            NSString *urlString = [NSString stringWithFormat:@"http://mobilemcatch.mcommsg.com/PublisherHome.aspx?PublisherID=%@",accID];
            
            NSURL *url = [[NSURL alloc] initWithString:urlString];
            
            //  NSLog(@"%@",url);
            
            [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
             {
                 
               
                 if (error)
                 {
                     NSLog(@"error");
                 }
                 else
                 {
                     // Id= [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                     //NSLog(@"Response: %@", Id);
                     NSError *error = nil;
                     NSDictionary *jsonData = [NSJSONSerialization
                                               JSONObjectWithData:data
                                               options:NSJSONReadingMutableContainers
                                               error:&error];
                     
                     NSString *Activities = jsonData[@"Activities"];
                     NSString *TotalClk = jsonData[@"TotalClk"] ;
                     NSString *TotalImp = jsonData[@"TotalImp"] ;
                     NSString *TotalCPA = jsonData[@"TotalCPA"] ;
                     
                     NSString *totalEarn = jsonData[@"TotalEarn"] ;
                    
                     dispatch_async(dispatch_get_main_queue(), ^{
                     
                    _activities.text = Activities;
                     _clicks.text = TotalClk;
                     _impressions.text = TotalImp;
                     _totalCPA.text = TotalCPA;
                     _earn.text = totalEarn;
                     [SVProgressHUD dismiss];
                    
                     });
                 }
               
             }];
            
        });
        
    
    
    // [NSThread detachNewThreadSelector: @selector(Stop) toTarget:self withObject:nil];
    // Do any additional setup after loading the view.
    
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
 // Do any additional setup after loading the view.


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)menu:(id)sender {
    // Dismiss keyboard (optional)
    //
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    
    // Present the view controller
    //
    [self.frostedViewController presentMenuViewController];
    
   
}

@end
