//
//  MDAddress+Annotation.m
//  Memorandum
//
//  Created by Alessandro Masini on 08/09/22.
//

#import "MDAddress+Annotation.h"
//#import <CoreLocation/CoreLocation.h>

@implementation MDAddress (Annotation)

- (CLLocationCoordinate2D)coordinate {
    
    CLLocationCoordinate2D coordinate;
    
    coordinate.latitude = self.latitude.doubleValue;
    coordinate.longitude = self.longitude.doubleValue;
    
    return coordinate;
}

- (NSString *)title {
  return self.commonName;
}

@end
