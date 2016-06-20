//
//  AdminTrackSumViewController.m
//  MCatch
//
//  Created by MCOM Admin on 13/04/2016.
//  Copyright © 2016 MCOM. All rights reserved.
//

#import "AdminTrackSumViewController.h"
#import "SVProgressHUD.h"
#import "ATSumTableViewCell.h"
#import "Search.h"


@interface AdminTrackSumViewController ()

@property (strong, nonatomic) NSMutableArray *mutableNames;

@end

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"


@implementation AdminTrackSumViewController
{
    NSArray *names;
    NSArray *searchResults;
}
@synthesize result;

- (void)viewDidLoad {
    [super viewDidLoad];
    
     [self.searchDisplayController.searchResultsTableView setRowHeight:self.ATSumTable.rowHeight];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.barTintColor = [UIColor orangeColor];
    [SVProgressHUD show];
    //dispatch_async(dispatch_get_main_queue(), ^{
    NSString *accID = [[NSUserDefaults standardUserDefaults] objectForKey:@"AccID"];
    
    NSString *urlString = [NSString stringWithFormat:@"http://mobilemcatch.mcommsg.com/AdminAdvTrackSummary.aspx?AdminID=%@",accID];
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
                 
                 [self.ATSumTable reloadData];
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
    static NSString *MyIdentifier = @"ATSumCell";
    ATSumTableViewCell *cell = [self.ATSumTable dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[ATSumTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
    }
    
    Search *searching = nil;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        searching   = [searchResults objectAtIndex:indexPath.row];
        NSInteger i=0;
        for (i=0; i<searchResults.count; i++) {
            
            cell.campName.text=searching.record1;
            cell.advName.text=searching.record2;
            cell.costType.text=searching.record3;
            cell.date.text=searching.record4;
            cell.total.text=searching.record5;
        }
    }
    else {
        searching = [names objectAtIndex:indexPath.row];
        
        names = [[NSArray alloc]init];
        
        self.mutableNames = [[NSMutableArray alloc]init];
        
        NSInteger i=0;
        
        for (i=0; i<self.result.count; i++) {
            
            NSString *advNam = result[i][@"advertisername"];
            
            NSString *camName = result[i][@"campaignname"];
            
            NSString *dat = result[i][@"Date"];
            
            NSString *cType = result[i][@"costtype"];
            
            NSString *tot = result[i][@"Total"];
            
            Search *record = [Search new];
            
            record.record1 = [NSString stringWithFormat:@"%@",camName];
            record.record2 = [NSString stringWithFormat:@"%@",advNam];
            record.record3 = [NSString stringWithFormat:@"%@",cType];
            record.record4 = [NSString stringWithFormat:@"%@",dat];
            record.record5 = [NSString stringWithFormat:@"%@",tot];
            
            [_mutableNames addObject:record];
            
            if (indexPath.row == i) {
                
                cell.campName.text = [NSString stringWithFormat:@"%@",camName];
                cell.advName.text = [NSString stringWithFormat:@"%@",advNam];
                cell.date.text = [NSString stringWithFormat:@"%@",dat];
                cell.costType.text = [NSString stringWithFormat:@"%@",cType];
                cell.total.text = [NSString stringWithFormat:@"%@",tot];
                
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
