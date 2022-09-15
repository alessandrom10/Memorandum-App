//
//  MainTableViewController.m
//  Memorandum
//
//  Created by Alessandro Masini on 06/09/22.
//

#import "MainTableViewController.h"
#import "AddMemorandumTableViewController.h"
#import "UpdateMemorandumTableViewController.h"
#import "MapViewController.h"
#import <MapKit/MapKit.h>

@interface MainTableViewController ()

@end

@implementation MainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
     //self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.listOfMemorandums = [[MDListOfMemorandums alloc] init];
    
    NSDate *nextHour = [NSDate dateWithTimeIntervalSinceNow:3600];
    
    MDMemorandum* memorandum2 = [[MDMemorandum alloc] initWithDate:nextHour
                                                          location:@"Via Galvani, Parma, Italia"
                                                             title:@"Inizio cinema"
                                                           details:@"Titanic"
                                                            status:active];
    
    [_listOfMemorandums add:memorandum2];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listOfMemorandums.length.intValue;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
    
    NSDate* currentDate = [self.listOfMemorandums getElementAt:indexPath.row].instantToTrigger;
    
    NSString* dateString = [formatter stringFromDate:currentDate];
    NSString* title = [self.listOfMemorandums getElementAt:indexPath.row].title;
    NSString* description = [self.listOfMemorandums
                             getElementAt:indexPath.row].details;
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"prototype"
                                           forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@\n%@\n%@", dateString, title, description];
    cell.textLabel.numberOfLines = 3;
    
    return cell;
}

- (void) viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

- (IBAction)deleteButtonClicked:(id)sender {
    
    UIButton* mybutton = sender;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell*)mybutton.superview.superview];
    [_listOfMemorandums removeElementAt:indexPath.row];
    [self.tableView reloadData];
    
}
- (IBAction)mainTableIsRefreshing:(id)sender {
    [sender beginRefreshing];
    [self.tableView reloadData];
    [sender endRefreshing];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if([segue.identifier isEqualToString:@"addNew"] && [segue.destinationViewController isKindOfClass:[AddMemorandumTableViewController class]]) {
        AddMemorandumTableViewController* vc = (AddMemorandumTableViewController* )segue.destinationViewController;
        vc.listOfMemorandums = self.listOfMemorandums;
    }
    else if([segue.identifier isEqualToString:@"update"] && [segue.destinationViewController isKindOfClass:[UpdateMemorandumTableViewController class]]) {
        UIButton* tempButton = sender;
        UpdateMemorandumTableViewController* vc = (UpdateMemorandumTableViewController*)segue.destinationViewController;
        NSIndexPath* indexPath = [self.tableView indexPathForCell:(UITableViewCell*)tempButton.superview.superview];
        vc.listOfMemorandums = self.listOfMemorandums;
        vc.element = [self.listOfMemorandums getElementAt:indexPath.row];
        vc.indexPathElementToUpdate = indexPath;
        
    }
    else if([segue.identifier isEqualToString:@"map"] && [segue.destinationViewController isKindOfClass:[MapViewController class]]) {
        MapViewController* vc = (MapViewController*)segue.destinationViewController;
        vc.listOfMemorandums = self.listOfMemorandums;
    }
    
}

@end
