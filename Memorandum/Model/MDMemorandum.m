//
//  MDMemorandum.m
//  Memorandum
//
//  Created by Alessandro Masini on 04/09/22.
//

#import "MDMemorandum.h"
#import <CoreLocation/CoreLocation.h>
#include <UserNotifications/UserNotifications.h>

@interface MDMemorandum ()

@property (strong, nonatomic) UNUserNotificationCenter* center;

@end

@implementation MDMemorandum

- (instancetype) initWithDate:(NSDate*)instantToTrigger
                     location:(NSString*)locationString
                        title:(NSString*)title
                      details:(NSString*)details
                       status:(Status)status {
    
    if(self = [super init]) {
        _instantToTrigger = [instantToTrigger copy];
        _location = [[MDAddress alloc] init];
        
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
        
        [geocoder geocodeAddressString:locationString
                     completionHandler:^(NSArray *placemarks, NSError *error) {
            CLPlacemark* firstAnswer = [placemarks firstObject];
            //NSLog(@"First answer is name: %@ locality: %@, our latitude is %f, while our longitude is %f", firstAnswer.name, firstAnswer.locality, firstAnswer.location.coordinate.latitude, firstAnswer.location.coordinate.longitude);
            self->_location.commonName = firstAnswer.name;
            self->_location.latitude = @(firstAnswer.location.coordinate.latitude);
            self->_location.longitude = @(firstAnswer.location.coordinate.longitude);
            
            self->_center = [UNUserNotificationCenter currentNotificationCenter];
            [self->_center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert)
               completionHandler:^(BOOL granted, NSError * _Nullable error) {
            }];
            
            UNMutableNotificationContent* content = [[UNMutableNotificationContent alloc] init];
            content.title = [NSString localizedUserNotificationStringForKey:[NSString stringWithFormat:@"Sei entrato nella regione %@", self->_location.commonName] arguments:nil];
            content.body = [NSString localizedUserNotificationStringForKey:@"Controlla il tuo memorandum relativo a questa regione" arguments:nil];
            
            CLLocationCoordinate2D tempPlace;
            tempPlace.latitude = self->_location.latitude.doubleValue;
            tempPlace.longitude = self->_location.longitude.doubleValue;
            
            CLCircularRegion* tempRegion = [[CLCircularRegion alloc] initWithCenter:tempPlace
                                                                             radius:150
                                                                         identifier:self->_location.commonName];
            tempRegion.notifyOnEntry = YES;
            
            UNLocationNotificationTrigger* locationTrigger = [UNLocationNotificationTrigger triggerWithRegion:tempRegion repeats:NO];
            
            UNNotificationRequest* request = [UNNotificationRequest requestWithIdentifier:[NSString stringWithFormat:@"Region Alarm: %@", self->_location.commonName] content:content trigger:locationTrigger];
            
            //NSLog(@"My new identifier is: %@", [NSString stringWithFormat:@"Region Alarm: %@", self->_location.commonName]);
            
            [self->_center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
               if (error != nil) {
                   //NSLog(@"%@", error.localizedDescription);
               } else {
                   //NSLog(@"Notification succesfully added");
               }
            }];
        }];
        
        _location.commonName = [locationString copy];
        _title = [title copy];
        _details = [details copy];
        _status = status;
    }
    
    return self;
}

/*- (nullable instancetype)initWithCoder:(nonnull NSCoder *)coder {
    
        if(self = [super init])
        {
            self.instantToTrigger = [coder decodeObjectForKey:@"instantToTrigger"];
            self.location = [coder decodeObjectForKey:@"location"];
            self.title = [coder decodeObjectForKey:@"title"];
            self.details = [coder decodeObjectForKey:@"deatils"];
            self.status = ((NSNumber*)[coder decodeObjectForKey:@"status"]).intValue;
        }
        return self;
}*/

/*- (void)encodeWithCoder:(nonnull NSCoder *)coder {
    [coder encodeObject:self.instantToTrigger forKey:@"instantToTrigger"];
    [coder encodeObject:self.location forKey:@"location"];
    [coder encodeObject:self.title forKey:@"title"];
    [coder encodeObject:self.details forKey:@"details"];
    [coder encodeObject:@((int)self.status) forKey:@"status"];
}*/

- (void) dealloc {
    NSArray *identifiers = [NSArray arrayWithObjects: [NSString stringWithFormat:@"Region Alarm: %@", self.location.commonName], nil];
    [self->_center removePendingNotificationRequestsWithIdentifiers:identifiers];
}

@end
