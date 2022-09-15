//
//  NewMemorandumTableViewController.h
//  Memorandum
//
//  Created by Alessandro Masini on 07/09/22.
//

#import <UIKit/UIKit.h>
#import "Model/MDListOfMemorandums.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddMemorandumTableViewController : UITableViewController

@property (strong, nonatomic) MDListOfMemorandums* listOfMemorandums;

@end

NS_ASSUME_NONNULL_END
