//
//  ListOfMemorandum.h
//  Memorandum
//
//  Created by Alessandro Masini on 04/09/22.
//

#import <Foundation/Foundation.h>
#import "MDMemorandum.h"

NS_ASSUME_NONNULL_BEGIN

@interface MDListOfMemorandums : NSObject

@property (strong, nonatomic) NSArray* list;

- (instancetype) init;
- (void)add:(MDMemorandum*)memorandum;
- (MDMemorandum*)getElementAt:(NSInteger)index;
- (void)removeElementAt:(NSInteger)index;
- (NSNumber*) length;

@end

NS_ASSUME_NONNULL_END
