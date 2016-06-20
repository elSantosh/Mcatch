//
//  PTSViewController.m
//  MCatch
//
//  Created by MCOM Admin on 20/04/2016.
//  Copyright © 2016 MCOM. All rights reserved.
//

#import "PTSViewController.h"
#import "SVProgressHUD.h"
#import "PTSTableViewCell.h"
#import "Search.h"

@interface PTSViewController ()

@property (strong, nonatomic) NSMutableArray *mutableNames;

@end

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"

@implementation PTSViewController
{
    NSArray *names;
    NSArray *searchResults;
    
}
@synthesize result;

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationController.navigationBar.barTintColor = [UIColor orangeColor];
    
    [self.searchDisplayController.searchResultsTableView setRowHeight:self.PTSTable.rowHeight];
    
    [SVProgressHUD show];
    
    //dispatch_async(dispatch_get_main_queue(), ^{
    
    NSString *accID = [[NSUserDefaults standardUserDefaults] objectForKey:@"AccID"];
    
    NSString *urlString = [NSString stringWithFormat:@"http://mobilemcatch.mcommsg.com/AdminPubTracksummary.aspx?AdminID=%@",accID];
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
                 
                 [self.PTSTable reloadData];
             });
         }
         
     }];
    
    // });
    
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
    static NSString *MyIdentifier = @"PTSCell";
    PTSTableViewCell *cell = [self.PTSTable dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil) {
        cell = [[PTSTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
    }
    
    Search *searching = nil;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        searching   = [searchResults objectAtIndex:indexPath.row];
        NSInteger i=0;
        for (i=0; i<searchResults.count; i++) {
            
            cell.campId.text=searching.record1;
            cell.name.text=searching.record2;
            cell.Id.text=searching.record3;
            cell.costType.text=searching.record4;
            cell.total.text=searching.record5;
        }
    }
    else {
        searching = [names objectAtIndex:indexPath.row];
        
        names = [[NSArray alloc]init];
        
        self.mutableNames = [[NSMutableArray alloc]init];
        
        NSInteger i=0;
        
        for (i=0; i<self.result.count; i++) {
            
            NSString *cId = result[i][@"campaignid"];
            
            NSString *pName = result[i][@"publishername"];
            
            NSString *cType = result[i][@"costtype"];
            
            NSString *camID = result[i][@"channeltype"];
            
            NSString *totUnit = result[i][@"Total"];
            
            Search *record = [Search new];
            
            record.record1 = [NSString stringWithFormat:@"%@",cId];
            record.record2 = [NSString stringWithFormat:@"%@",pName];
            record.record3 = [NSString stringWithFormat:@"%@",camID];
            record.record4 = [NSString stringWithFormat:@"%@",cType];
            record.record5 = [NSString stringWithFormat:@"%@",totUnit];
            [_mutableNames addObject:record];
            
            if (indexPath.row == i) {
                
                cell.campId.text = [NSString stringWithFormat:@"%@",cId];
                cell.Id.text = [NSString stringWithFormat:@"%@",camID];
                cell.name.text = [NSString stringWithFormat:@"%@",pName];
                cell.costType.text = [NSString stringWithFormat:@"%@",cType];
                cell.total.text = [NSString stringWithFormat:@"%@",totUnit];
                
                
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
