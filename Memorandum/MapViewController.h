//
//  MapViewController.h
//  Memorandum
//
//  Created by Alessandro Masini on 08/09/22.
//

#import <UIKit/UIKit.h>
#include "Model/MDListOfMemorandums.h"

NS_ASSUME_NONNULL_BEGIN

@interface MapViewController : UIViewController

@property (strong, nonatomic) MDListOfMemorandums* listOfMemorandums;

@end

NS_ASSUME_NONNULL_END
