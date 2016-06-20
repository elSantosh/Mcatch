//
//  LoginViewController.m
//  MCatch
//
//  Created by MCOM Admin on 23/03/2016.
//  Copyright © 2016 Mcom. All rights reserved.
//

#import "LoginViewController.h"

#import "DEMORootViewController.h"
#import "DEMOHomeViewController.h"
#import "PDashboardViewController.h"
#import "PubViewController.h"
#import "AdminViewController.h"
#import "AdminDashboardViewController.h"

#import "SVProgressHUD.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UIButton *advBtn;
@property (weak, nonatomic) IBOutlet UIButton *pubBtn;
@property (weak, nonatomic) IBOutlet UIButton *admnBtn;

@end

@implementation LoginViewController

@synthesize Id;

- (void)viewWillAppear:(BOOL)animated {
    [super viewDidLoad];
    
    
    
    self.navigationController.navigationBar.hidden = YES;

    self.view.userInteractionEnabled = TRUE;
  
    [[NSUserDefaults standardUserDefaults] setObject:@0 forKey:@"accType"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSUserDefaults standardUserDefaults] setObject:@0 forKey:@"session"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    //Advertiser-----
    //  _email.text = @"adva@gmail.com";
    //  _password.text = @"2016@dva";
    
    //Publisher------
    // _email.text = @"feifei.mao@pmtmobi.com";
    // _password.text = @"2016@wallet";
    
    //Admin---------
    //  _email.text = @"admin@gmail.com";
    //  _password.text = @"@dmin128";

    //_accType.transform = CGAffineTransformMakeScale(0.80, 0.80);
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //Iterate through your subviews, or some other custom array of views
    for (UIView *view in self.view.subviews)
    
        [view resignFirstResponder];
}
- (IBAction)rememberMe:(id)sender {
    [[NSUserDefaults standardUserDefaults] setObject:@1 forKey:@"session"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (IBAction)selectAdva:(id)sender {
    
    [[NSUserDefaults standardUserDefaults] setObject:@2 forKey:@"accType"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}
- (IBAction)selectPub:(id)sender {
    [[NSUserDefaults standardUserDefaults] setObject:@3 forKey:@"accType"];
    [[NSUserDefaults standardUserDefaults] synchronize];

}
- (IBAction)selectAdmin:(id)sender {
    [[NSUserDefaults standardUserDefaults] setObject:@1 forKey:@"accType"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}
- (IBAction)login:(id)sender {
   
    NSNumber *accType = [[NSUserDefaults standardUserDefaults] objectForKey:@"accType"];
    
    if([_email.text isEqualToString:@""] || [_password.text isEqualToString:@""] ||[accType isEqualToNumber:@0] ) {
        
        [self alertStatus:@"Please fill all details" :@"Sign in Failed!" :0];
        [SVProgressHUD dismiss];
    }
    else{
    
        [SVProgressHUD show];
        
        if ([accType isEqualToNumber:@2]) {
        
       // dispatch_async(dispatch_get_main_queue(), ^{
            
        NSNumber *accType = [[NSUserDefaults standardUserDefaults] objectForKey:@"accType"];
        NSString *urlString = [NSString stringWithFormat:@"http://mobilemcatch.mcommsg.com/login.aspx?Username=%@&Password=%@&ACCtype=%@",_email.text,_password.text,accType];
    
        NSURL *url = [[NSURL alloc] initWithString:urlString];
        
        [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
         {
             if (error)
             {
                 dispatch_async(dispatch_get_main_queue(), ^{
                     //                     NSString *error_msg = (NSString *) jsonData[@"error_message"];
                     [self alertStatus:@"please enter correct details" :@"Sign in Failed!" :0];
                     
                     [[NSUserDefaults standardUserDefaults] setObject:@0 forKey:@"accType"];
                     [[NSUserDefaults standardUserDefaults] synchronize];
                     _advBtn.selected = NO;
                     //                     _pubBtn.selected = NO;
                     //                     _admnBtn.selected = NO;
                     [SVProgressHUD dismiss];
                 });
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
                 
                 NSInteger success = [jsonData[@"Success"] integerValue];
                 
                 //NSLog(@"Success: %ld",(long)success);
                 Id =  jsonData[@"Id"];
                 // NSLog(@"%@",Id);
                 
                 if(success == 1){
                     dispatch_async(dispatch_get_main_queue(), ^{
                     //NSLog(@"Login SUCCESS");
                     DEMORootViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"rootController"];
                    
                    [[NSUserDefaults standardUserDefaults] setObject:Id forKey:@"AccID"];
                     
                     [[NSUserDefaults standardUserDefaults] synchronize];
                     
                     [self presentViewController:vc animated:YES completion:nil];
                    
                     });
                 }
                 
                 else {
                 dispatch_async(dispatch_get_main_queue(), ^{
//                     NSString *error_msg = (NSString *) jsonData[@"error_message"];
                     [self alertStatus:@"please enter correct details" :@"Sign in Failed!" :0];
                     
                     [[NSUserDefaults standardUserDefaults] setObject:@0 forKey:@"accType"];
                     [[NSUserDefaults standardUserDefaults] synchronize];
                     _advBtn.selected = NO;
//                     _pubBtn.selected = NO;
//                     _admnBtn.selected = NO;
                     [SVProgressHUD dismiss];
                 });
                 }
                 
             }
             
         }];
        
        }
     else if ([accType isEqualToNumber:@3]) {
     
        // _email.text = @"feifei.mao@pmtmobi.com";
        // _password.text = @"2016@wallet";
         
//         [[NSUserDefaults standardUserDefaults] setObject:@3 forKey:@"accType"];
//         [[NSUserDefaults standardUserDefaults] synchronize];
//         
       
//        @try {
         
//            if([_email.text isEqualToString:@""] || [_password.text isEqualToString:@""] ) {
//                
//                [self alertStatus:@"Please enter Email and Password" :@"Sign in Failed!" :0];
//                 [SVProgressHUD dismiss];
//            }
           // NSNumber *accType = [[NSUserDefaults standardUserDefaults] objectForKey:@"accType"];
            
            NSString *urlString = [NSString stringWithFormat:@"http://mobilemcatch.mcommsg.com/login.aspx?Username=%@&Password=%@&ACCtype=%@",_email.text,_password.text,accType];
            
            NSURL *url = [[NSURL alloc] initWithString:urlString];
           // NSLog(@"%@", urlString);
            [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
             {
                 if (error)
                 {
                     dispatch_async(dispatch_get_main_queue(), ^{
                         //   NSString *error_msg = (NSString *) jsonData[@"error_message"];
                         
                         [self alertStatus:@"please enter correct details" :@"Sign in Failed!" :0];
                         [[NSUserDefaults standardUserDefaults] setObject:@0 forKey:@"accType"];
                         [[NSUserDefaults standardUserDefaults] synchronize];
                         
                         //_advBtn.selected = NO;
                         _pubBtn.selected = NO;
                         //                             _admnBtn.selected = NO;
                         
                         [SVProgressHUD dismiss];
                     });
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
                     
                     NSInteger success = [jsonData[@"Success"] integerValue];
                     
                     //NSLog(@"Success: %ld",(long)success);
                     Id =  jsonData[@"Id"];
                     // NSLog(@"%@",Id);
                     
                     if(success == 1){
                          dispatch_async(dispatch_get_main_queue(), ^{
                        // NSLog(@"Login SUCCESS");
                              PubViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"pubRoot"];
                         
                              [[NSUserDefaults standardUserDefaults] setObject:Id forKey:@"AccID"];
                         
                         [[NSUserDefaults standardUserDefaults] synchronize];
                         // NSLog(@"login%@",Id);
                        // [vc setAdvId:Id];
                         [self presentViewController:vc animated:YES completion:nil];
                              
                                         });
                     }
                     else {
                         dispatch_async(dispatch_get_main_queue(), ^{
                      //   NSString *error_msg = (NSString *) jsonData[@"error_message"];
                         
                         [self alertStatus:@"please enter correct details" :@"Sign in Failed!" :0];
                             [[NSUserDefaults standardUserDefaults] setObject:@0 forKey:@"accType"];
                             [[NSUserDefaults standardUserDefaults] synchronize];
                             
                             //_advBtn.selected = NO;
                             _pubBtn.selected = NO;
//                             _admnBtn.selected = NO;
                             
                         [SVProgressHUD dismiss];
                         });
                     }
                     
                 }
                 
             }];
      //  }
//        @catch (NSException * e) {
////            NSLog(@"Exception: %@", e);
////            [self alertStatus:@"Sign in Failed." :@"Error!" :0];
//        }

    }
           
   //    });
//    
//});
  //   [SVProgressHUD dismiss];
        
        
     else if([accType isEqualToNumber:@1]){
         
        // NSLog(@"Admin Login");
         
         NSString *urlString = [NSString stringWithFormat:@"http://mobilemcatch.mcommsg.com/login.aspx?Username=%@&Password=%@&ACCtype=%@",_email.text,_password.text,accType];
         
         NSURL *url = [[NSURL alloc] initWithString:urlString];
         // NSLog(@"%@", urlString);
         [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
          {
              if (error)
              {
                  dispatch_async(dispatch_get_main_queue(), ^{
                      // NSString *error_msg = (NSString *) jsonData[@"error_message"];
                      
                      [self alertStatus:@"please enter correct details" :@"Sign in Failed!" :0];
                      
                      [[NSUserDefaults standardUserDefaults] setObject:@0 forKey:@"accType"];
                      [[NSUserDefaults standardUserDefaults] synchronize];
                      
                     
                      _admnBtn.selected = NO;
                      
                      [SVProgressHUD dismiss];
                  });

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
                  
                  NSInteger success = [jsonData[@"Success"] integerValue];
                  
                  //NSLog(@"Success: %ld",(long)success);
                  Id =  jsonData[@"Id"];
                  // NSLog(@"%@",Id);
                  
                  if(success == 1){
                      dispatch_async(dispatch_get_main_queue(), ^{
                          // NSLog(@"Login SUCCESS");
                        AdminViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"AdminRoot"];
                          
                          [[NSUserDefaults standardUserDefaults] setObject:Id forKey:@"AccID"];
                          
                          [[NSUserDefaults standardUserDefaults] synchronize];
                          // NSLog(@"login%@",Id);
                          // [vc setAdvId:Id];
                          [self presentViewController:vc animated:YES completion:nil];
                          
                      });
                  }
                  else {
                        dispatch_async(dispatch_get_main_queue(), ^{
                     // NSString *error_msg = (NSString *) jsonData[@"error_message"];
                      
                      [self alertStatus:@"please enter correct details" :@"Sign in Failed!" :0];
                    
                            [[NSUserDefaults standardUserDefaults] setObject:@0 forKey:@"accType"];
                            [[NSUserDefaults standardUserDefaults] synchronize];
                            
//                            _advBtn.selected = NO;
//                            _pubBtn.selected = NO;
                            _admnBtn.selected = NO;
                            
                      [SVProgressHUD dismiss];
                        });
                  }
                  
              }
              
          }];
         
     }
     
    }

}
-(void)viewDidAppear:(BOOL)animated{
     [SVProgressHUD dismiss];
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

#pragma GCC diagnostic pop

@end

