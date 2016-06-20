//
//  ProfileViewController.m
//  MCatch
//
//  Created by MCOM Admin on 25/03/2016.
//  Copyright © 2016 Roman Efimov. All rights reserved.
//

#import "ProfileViewController.h"

#import "SVProgressHUD.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController
@synthesize urlString;



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
- (IBAction)save:(id)sender {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD show];
    NSString *accID = [[NSUserDefaults standardUserDefaults] objectForKey:@"AccID"];
    NSNumber *accType = [[NSUserDefaults standardUserDefaults] objectForKey:@"accType"];
    if ([accType isEqualToNumber:@2]) {
        
        self.urlString = [NSString stringWithFormat:@"http://mobilemcatch.mcommsg.com//UpdateAdvertiserProfile.aspx?AdvertiserID=%@&AdvertiserName=%@&FullName=%@&MobileNum=%@&OfficeNum=%@&Address=%@&CountryCode=%@",accID,_accName.text,_fullName.text,_mobileNumber.text,_officeNumber.text,_address.text,_location.text ];
    }
    else{
       self.urlString = [NSString stringWithFormat:@"http://mobilemcatch.mcommsg.com//UpdatePublisherProfile.aspx?PublisherID=%@&PublisherName=%@&FullName=%@&MobileNum=%@&OfficeNum=%@&Address=%@&CountryCode=%@",accID,_accName.text,_fullName.text,_mobileNumber.text,_officeNumber.text,_address.text,_location.text ];
    }

    NSURL *url = [[NSURL alloc] initWithString:urlString];
    
    [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         //NSLog(@"%@",data);
         if (error)
         {
             NSLog(@"error");
         }
         else
         {
             NSString *res= [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            // NSLog(@"Response: %@", res);
             
             if ([res isEqualToString:@"1"])
             {
                 [self alertStatus:@"Profile Saved!" :@"Success" :0];
                 [SVProgressHUD dismiss];
             }

             NSError *error = nil;
             NSMutableArray *jsonData = [NSJSONSerialization
                                         JSONObjectWithData:data
                                         options:NSJSONReadingMutableContainers
                                         error:&error];
             NSInteger i=0;
             for (i=0; i<[jsonData count]; i++) {
                 
                 
                 NSString *email = jsonData[i][@"LoginEmail"];
                 
                 if ([accType isEqualToNumber:@2]) {
                     
                    // dispatch_async(dispatch_get_main_queue(), ^{
                     self.advName = jsonData[i][@"AdvertiserName"];
                    // });
                 }
                 else{
                   //  dispatch_async(dispatch_get_main_queue(), ^{
                         self.advName = jsonData[i][@"PublisherName"];
                 //});
                 }
                 NSString *fName = jsonData[i][@"FullName"];
                 
                 NSString *mNum = jsonData[i][@"MobileNum"];
                 
                 NSString *oName = jsonData[i][@"OfficeNum"];
                 
                 NSString *loc = jsonData[i][@"CountryCode"];
                 
                 NSString *add = jsonData[i][@"Address"];
                 
                 dispatch_async(dispatch_get_main_queue(), ^{
                     
                 _email.text =  [NSString stringWithFormat:@"%@", email];
                 //
                 _accName.text = [NSString stringWithFormat:@"%@",self.advName];
                 _fullName.text = [NSString stringWithFormat:@"%@",fName];
                 _mobileNumber.text = [NSString stringWithFormat:@"%@",mNum];
                 _officeNumber.text =[NSString stringWithFormat:@"%@",oName];
                 _location.text = [NSString stringWithFormat:@"%@",loc];
                 _address.text = [NSString stringWithFormat:@"%@",add];
                 //
                 });
                
             }
         }
              }];
    

    });
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
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //Iterate through your subviews, or some other custom array of views
    for (UIView *view in self.view.subviews)
        [view resignFirstResponder];
}

-(void)viewDidLoad{
    
    self.navigationController.navigationBar.barTintColor = [UIColor orangeColor];
    [SVProgressHUD show];
   // dispatch_async(dispatch_get_main_queue(), ^{
         NSString *accID = [[NSUserDefaults standardUserDefaults] objectForKey:@"AccID"];
    NSNumber *accType = [[NSUserDefaults standardUserDefaults] objectForKey:@"accType"];
    if ([accType isEqualToNumber:@2]) {
        
        self.urlString = [NSString stringWithFormat:@"http://mobilemcatch.mcommsg.com/AdvertiserProfile.aspx?AdvertiserID=%@",accID];
    }
    else{
         self.urlString = [NSString stringWithFormat:@"http://mobilemcatch.mcommsg.com/PublisherProfile.aspx?PublisherID=%@",accID];
    }
        NSURL *url = [[NSURL alloc] initWithString:urlString];
        
        [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
         {
             //NSLog(@"%@",data);
             if (error)
             {
                 NSLog(@"error");
             }
             else
             {
                 NSString *res= [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                      //NSLog(@"Response: %@", res);
                 NSError *error = nil;
                 NSMutableArray *jsonData = [NSJSONSerialization
                                             JSONObjectWithData:data
                                             options:NSJSONReadingMutableContainers
                                             error:&error];
                // NSLog(@"%@",jsonData);
                 NSInteger i=0;
                 for (i=0; i<[jsonData count]; i++) {
                     
                     
                     NSString *email = jsonData[i][@"LoginEmail"];
                     
                     if ([accType isEqualToNumber:@2]) {

                     
                     self.advName = jsonData[i][@"AdvertiserName"];
                     }
                     else{
                        self.advName = jsonData[i][@"PublisherName"];
                     }
                     NSString *fName = jsonData[i][@"FullName"];
                     
                     NSString *mNum = jsonData[i][@"MobileNum"];
                     
                     NSString *oName = jsonData[i][@"OfficeNum"];
                     
                     NSString *loc = jsonData[i][@"CountryCode"];
                     
                     NSString *add = jsonData[i][@"Address"];
                     
                   dispatch_async(dispatch_get_main_queue(), ^{
                       
                     _email.text =  [NSString stringWithFormat:@"%@", email];
//
                     _accName.text = [NSString stringWithFormat:@"%@",self.advName];
                     _fullName.text = [NSString stringWithFormat:@"%@",fName];
                     _mobileNumber.text = [NSString stringWithFormat:@"%@",mNum];
                     _officeNumber.text =[NSString stringWithFormat:@"%@",oName];
                     _location.text = [NSString stringWithFormat:@"%@",loc];
                     _address.text = [NSString stringWithFormat:@"%@",add];
//                     
                     [SVProgressHUD dismiss];
                   });
                 }
             }
         }];
        
  //  });
    

}
@end
