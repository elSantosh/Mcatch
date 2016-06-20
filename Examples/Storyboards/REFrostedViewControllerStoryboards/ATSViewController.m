//
//  ATSViewController.m
//  MCatch
//
//  Created by MCOM Admin on 20/04/2016.
//  Copyright © 2016 MCOM. All rights reserved.
//

#import "ATSViewController.h"
#import "SVProgressHUD.h"
#import "ATSTableViewCell.h"
#import "Search.h"

@interface ATSViewController ()

@property (strong, nonatomic) NSMutableArray *mutableNames;

@end

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"

    
@implementation ATSViewController
    {
        NSArray *names;
        NSArray *searchResults;
    }
@synthesize result;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.searchDisplayController.searchResultsTableView setRowHeight:self.ATSTable.rowHeight];
    
    self.navigationController.navigationBar.barTintColor = [UIColor orangeColor];
    
    [SVProgressHUD show];
    //dispatch_async(dispatch_get_main_queue(), ^{
    NSString *accID = [[NSUserDefaults standardUserDefaults] objectForKey:@"AccID"];
    
    NSString *urlString = [NSString stringWithFormat:@"http://mobilemcatch.mcommsg.com/AdminAdvtotalspent.aspx?AdminID=%@",accID];
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
                 
                 [self.ATSTable reloadData];
             });
         }
         
     }];
    
    // });
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
    static NSString *MyIdentifier = @"ATSCell";
    ATSTableViewCell *cell = [self.ATSTable dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil) {
        cell = [[ATSTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
    }
    
    Search *searching = nil;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        searching   = [searchResults objectAtIndex:indexPath.row];
        NSInteger i=0;
        for (i=0; i<searchResults.count; i++) {
            
            cell.campId.text=searching.record1;
            cell.campName.text=searching.record2;
            cell.date.text=searching.record3;
            cell.costType.text=searching.record4;
            cell.curBid.text = searching.record5;
            cell.totalCount.text=searching.record6;
            cell.totalSpent.text=searching.record7;
        }
    }
    else {
        searching = [names objectAtIndex:indexPath.row];
        
        names = [[NSArray alloc]init];
        
        self.mutableNames = [[NSMutableArray alloc]init];
        
        NSInteger i=0;
        
        for (i=0; i<self.result.count; i++) {
            
            NSString *cId = result[i][@"campaignID"];
            
            NSString *cName = result[i][@"campaignname"];
            
            NSString *cDate = result[i][@"campdate"];
            
            NSRange range = [cDate rangeOfString:@"T"];
            
            NSString *date2 = [cDate substringToIndex:range.location];
            
            NSString *cType = result[i][@"iCostType"];
            
            NSString *cBid = result[i][@"CurrentBid"];
            
            NSString *totCount = result[i][@"iTotalCount"];
            
            NSString *totalspent = result[i][@"iTotalSpent"];
            
            Search *record = [Search new];
            
            record.record1 = [NSString stringWithFormat:@"%@",cId];
            record.record2 = [NSString stringWithFormat:@"%@",cName];
            record.record3 = [NSString stringWithFormat:@"%@",date2];
            record.record4 = [NSString stringWithFormat:@"%@",cType];
            record.record5 = [NSString stringWithFormat:@"%@",cBid];
            record.record6 = [NSString stringWithFormat:@"%@",totCount];
            record.record7 = [NSString stringWithFormat:@"%@",totalspent];
            [_mutableNames addObject:record];
            
            if (indexPath.row == i) {
                
                cell.campId.text = [NSString stringWithFormat:@"%@",cId];
                cell.campName.text = [NSString stringWithFormat:@"%@",cName];
                cell.date.text = [NSString stringWithFormat:@"%@",date2];
                cell.costType.text = [NSString stringWithFormat:@"%@",cType];
                cell.curBid.text = [NSString stringWithFormat:@"%@",cBid];
                cell.totalCount.text = [NSString stringWithFormat:@"%@",totCount];
                cell.totalSpent.text = [NSString stringWithFormat:@"%@",totalspent];
                
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
