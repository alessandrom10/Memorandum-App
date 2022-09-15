//
//  ListOfMemorandum.m
//  Memorandum
//
//  Created by Alessandro Masini on 04/09/22.
//

#import "MDListOfMemorandums.h"
#import <MapKit/MapKit.h>
#include <UserNotifications/UserNotifications.h>

@implementation MDListOfMemorandums

- (instancetype) init {
    if(self = [super init]) {
        _list = [[NSArray alloc] init];        
    }
    
    return self;
}

- (void)add:(MDMemorandum*)memorandum {
    NSArray* temp = [self.list arrayByAddingObject:memorandum];
    
    NSSortDescriptor* sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"instantToTrigger"
                                               ascending:YES];
    
    self.list = [temp sortedArrayUsingDescriptors:@[sortDescriptor]];
}

- (MDMemorandum*)getElementAt:(NSInteger)index {
    return [self.list objectAtIndex:index];
}

- (void)removeElementAt:(NSInteger)index {
    
    NSMutableArray* temp = [[NSMutableArray alloc] initWithArray:self.list];
    [temp removeObjectAtIndex:index];
    self.list = [[NSArray alloc] initWithArray:temp];
    
    NSSortDescriptor* sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"instantToTrigger"
                                               ascending:YES];
    
    self.list = [temp sortedArrayUsingDescriptors:@[sortDescriptor]];
}

- (NSNumber*) length {
    return @([self.list count]);
}

@end
