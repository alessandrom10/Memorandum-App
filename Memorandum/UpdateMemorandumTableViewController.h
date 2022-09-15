//
//  UpdateMemorandumTableViewController.h
//  Memorandum
//
//  Created by Alessandro Masini on 07/09/22.
//

#import <UIKit/UIKit.h>
#import "Model/MDMemorandum.h"
#import "Model/MDListOfMemorandums.h"

NS_ASSUME_NONNULL_BEGIN

@interface UpdateMemorandumTableViewController : UITableViewController

@property (strong, nonatomic) MDListOfMemorandums* listOfMemorandums;
@property (strong, nonatomic) MDMemorandum* element;
@property (strong, nonatomic) NSIndexPath* indexPathElementToUpdate;

@end

NS_ASSUME_NONNULL_END
