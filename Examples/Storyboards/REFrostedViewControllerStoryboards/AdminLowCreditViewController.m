//
//  AdminLowCreditViewController.m
//  MCatch
//
//  Created by MCOM Admin on 13/04/2016.
//  Copyright © 2016 MCOM. All rights reserved.
//

#import "AdminLowCreditViewController.h"
#import "SVProgressHUD.h"
#import "ALCTableViewCell.h"
#import "Search.h"

@interface AdminLowCreditViewController ()

@property (strong, nonatomic) NSMutableArray *mutableNames;

@end

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"


@implementation AdminLowCreditViewController
 {
        NSArray *names;
        NSArray *searchResults;
}

@synthesize result;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.searchDisplayController.searchResultsTableView setRowHeight:self.FLCTable.rowHeight];
    
    self.navigationController.navigationBar.barTintColor = [UIColor orangeColor];
    [SVProgressHUD show];
    //dispatch_async(dispatch_get_main_queue(), ^{
    NSString *accID = [[NSUserDefaults standardUserDefaults] objectForKey:@"AccID"];
    
    NSString *urlString = [NSString stringWithFormat:@"http://mobilemcatch.mcommsg.com/AdminBalAlert.aspx?AdminID=%@",accID];
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
                 
                 [self.FLCTable reloadData];
             });
         }
         
     }];
    
    

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [searchResults count];
        
    } else {
        return self.result.count;
    }
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    // The header for the section is the region name -- get this from the region at the section index.
//   // Region *region = [regions objectAtIndex:section];
//    return NULL;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"FLCCell";
    ALCTableViewCell *cell = [self.FLCTable dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil) {
        cell = [[ALCTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
    }
    
    Search *searching = nil;
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        searching   = [searchResults objectAtIndex:indexPath.row];
        NSInteger i=0;
        for (i=0; i<searchResults.count; i++) {
            
            cell.advId.text=searching.record1;
            cell.advName.text=searching.record2;
            cell.balance.text=searching.record3;
            
        }
    }
    else {
        searching = [names objectAtIndex:indexPath.row];
        
        names = [[NSArray alloc]init];
        
        self.mutableNames = [[NSMutableArray alloc]init];
        
        NSInteger i=0;
        
        for (i=0; i<self.result.count; i++) {
            
            
            NSString *advId = result[i][@"AdvertiserId"];
            
            NSString *advName = result[i][@"Advertisername"];
            
            NSString *bal = result[i][@"Currentbal"];
            
            Search *record = [Search new];
            
            record.record1 = [NSString stringWithFormat:@"%@",advId];
            record.record2 = [NSString stringWithFormat:@"%@",advName];
            record.record3 = [NSString stringWithFormat:@"%@",bal];
            
            [_mutableNames addObject:record];
            
            if (indexPath.row == i) {
                
                cell.advId.text = [NSString stringWithFormat:@"%@",advId];
                cell.advName.text = [NSString stringWithFormat:@"%@",advName];
                cell.balance.text = [NSString stringWithFormat:@"%@",bal];
            }

        }
        names = [NSMutableArray arrayWithArray:_mutableNames];
    }

   
    [SVProgressHUD dismiss];
    
    return cell;
}
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"record2 contains [c] %@", searchText];
    
    searchResults = [names filteredArrayUsingPredicate:resultPredicate];
    
}


-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
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
#pragma GCC diagnostic pop

