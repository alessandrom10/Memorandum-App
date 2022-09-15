//
//  MDMemorandum.h
//  Memorandum
//
//  Created by Alessandro Masini on 04/09/22.
//

#import <Foundation/Foundation.h>
#import "MDAddress.h"

NS_ASSUME_NONNULL_BEGIN

@interface MDMemorandum : NSObject

typedef enum Status {
    active,
    expired,
    completed
} Status;

@property (strong, nonatomic) NSDate* instantToTrigger;
@property (strong, nonatomic) MDAddress* location;
@property (strong, nonatomic) NSString* title;
@property (strong, nonatomic) NSString* details;
@property (nonatomic) Status status;

- (instancetype) initWithDate:(NSDate*)instantToTrigger
                     location:(NSString*)locationString
                        title:(NSString*)title
                      details:(NSString*)details
                       status:(Status)status;

@end

NS_ASSUME_NONNULL_END
