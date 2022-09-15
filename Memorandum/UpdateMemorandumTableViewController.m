//
//  UpdateMemorandumTableViewController.m
//  Memorandum
//
//  Created by Alessandro Masini on 07/09/22.
//

#import "UpdateMemorandumTableViewController.h"

@interface UpdateMemorandumTableViewController () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UITextField *locationTextField;
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *detailsTextField;
@property (weak, nonatomic) IBOutlet UIButton *updateButton;
@property (weak, nonatomic) IBOutlet UIPickerView *statusPicker;

@end

@implementation UpdateMemorandumTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.statusPicker.dataSource = self;
    self.statusPicker.delegate = self;
    
    self.datePicker.date = self.element.instantToTrigger;
    self.locationTextField.text = self.element.location.commonName;
    self.titleTextField.text = self.element.title;
    self.detailsTextField.text = self.element.details;
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (IBAction)updateButtonClicked:(id)sender {
    
    self.updateButton.enabled = NO;
    
    NSDate* now = [NSDate date];

    if(([self.datePicker.date laterDate:now] != now)  && [self.statusPicker selectedRowInComponent:0] == 0) {
        
        //NSLog(@"From correct update: Date is correct? %@ status is %ld", self.datePicker.date, (long)[self.statusPicker selectedRowInComponent:0]);
        
        NSInteger indexElementToUpdate = self.indexPathElementToUpdate.row;
        
        [self.listOfMemorandums removeElementAt:indexElementToUpdate];
        
        MDMemorandum* temp = [[MDMemorandum alloc] initWithDate:self.datePicker.date
                                                       location:self.locationTextField.text
                                                          title:self.titleTextField.text
                                                        details:self.detailsTextField.text
                                                         status:active];
        
        [self.listOfMemorandums add:temp];
        
        [self.updateButton setTitle:@"Memorandum updated" forState:UIControlStateDisabled];
        
    } else if ([self.statusPicker selectedRowInComponent:0] != 0) {
        
        [self.listOfMemorandums removeElementAt:self.indexPathElementToUpdate.row];
        //NSLog(@"Element removed");
        
    } else {
        //NSLog(@"Date is correct? %@ status is %ld", self.datePicker.date, (long)[self.statusPicker selectedRowInComponent:0]);
        [self.updateButton setTitle:@"A memorandum must be in the future" forState:UIControlStateNormal];
        self.updateButton.enabled = YES;
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
     return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
     return 3;
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    switch (row) {
            
        case 0:
            return @"Attivo";
            break;
            
        case 1:
            return @"Scaduto";
            break;
            
        case 2:
            return @"Completato";
            break;
    }
    return @"Attivo";
}


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
