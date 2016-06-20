//
//  MyOffersViewController.m
//  MCatch
//
//  Created by MCOM Admin on 28/03/2016.
//  Copyright © 2016 Roman Efimov. All rights reserved.
//

#import "MyOffersViewController.h"
#import "MyOffersTableViewCell.h"

#import "SVProgressHUD.h"

@interface MyOffersViewController () <UITableViewDataSource,UITableViewDelegate>



@end

@implementation MyOffersViewController

@synthesize result;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [SVProgressHUD show];
    
    self.navigationController.navigationBar.barTintColor = [UIColor orangeColor];
    
   // dispatch_async(dispatch_get_main_queue(), ^{
        NSString *accID = [[NSUserDefaults standardUserDefaults] objectForKey:@"AccID"];
        NSString *urlString = [NSString stringWithFormat:@"http://mobilemcatch.mcommsg.com/Publisheroffer.aspx?PublisherID=%@",accID];
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
                 //NSString *res= [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                 //                     NSLog(@"Response: %@", res);
                 NSError *error = nil;
                 NSMutableArray *jsonData = [NSJSONSerialization
                                             JSONObjectWithData:data
                                             options:NSJSONReadingMutableContainers
                                             error:&error];
              dispatch_async(dispatch_get_main_queue(), ^{
                 self.result = jsonData;
                 
                 [self.myOffersTable reloadData];
              });
             }
         }];
        
 //   });
    

    // Do any additional setup after loading the view.
}

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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Number of rows is the number of time zones in the region for the specified section.
    // Region *region = [regions objectAtIndex:section];
    // return [region.timeZoneWrappers count];
    return [self.result count];
    }

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    // The header for the section is the region name -- get this from the region at the section index.
//   // Region *region = [regions objectAtIndex:section];
//    return NULL;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"myofferscell";
    MyOffersTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    NSInteger i=0;
    for (i=0; i<[self.result count]; i++) {
        
        NSString *advId = result[i][@"advertiserid"];
        
        NSString *txId = result[i][@"Txid"];
        
        NSString *pubname = result[i][@"publishername"];
        
        NSString *CType = result[i][@"CostType"];

        NSString *countr = result[i][@"Countries"];
        
        NSString *URL = result[i][@"URL"];
        
        NSString *payou = result[i][@"payout"];
        
        NSString *plat = result[i][@"Platforms"];
        
        NSString *platDesc = result[i][@"platformtypedesc"];
        
        NSString *remark = result[i][@"Remark"];
        
        NSString *camId = result[i][@"campaignid"];
        
        
        
        if (indexPath.row == i) {
            
        cell.advId.text = [NSString stringWithFormat:@"%@", advId];
        cell.tranId.text =[NSString stringWithFormat:@"%@", txId];
        cell.name.text = [NSString stringWithFormat:@"%@", pubname];
        cell.costType.text = [NSString stringWithFormat:@"%@",CType];
        cell.country.text = [NSString stringWithFormat:@"%@",countr];
            cell.url.text =[NSString stringWithFormat:@"%@",URL];
            cell.payout.text = [NSString stringWithFormat:@"%@",payou];
            cell.platform.text = [NSString stringWithFormat:@"%@",plat];
            cell.platTypeDesc.text = [NSString stringWithFormat:@"%@",platDesc];
            cell.remarks.text = [NSString stringWithFormat:@"%@",remark];
            cell.campId.text = [NSString stringWithFormat:@"%@", camId];
            
            
            
            
        }
    }
    [SVProgressHUD dismiss];
    return cell;
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

@end
