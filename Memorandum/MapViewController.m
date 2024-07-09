//
//  MapViewController.m
//  Memorandum
//
//  Created by Alessandro Masini on 08/09/22.
//

#import "MapViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "Model/MDListOfMemorandums.h"
#import "MDAddress+Annotation.h"
#include <UserNotifications/UserNotifications.h>

@interface MapViewController () <CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager* locationManager;
@property (weak, nonatomic) IBOutlet MKMapView* map;

@end

@implementation MapViewController

- (CLLocationManager *)locationManager{
    if(!_locationManager) _locationManager = [[CLLocationManager alloc] init];
    return _locationManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = 10;
    self.locationManager.delegate = self;
    [self.locationManager requestAlwaysAuthorization];
    [self.locationManager startUpdatingLocation];
    
    CLLocationCoordinate2D startingPlace;
    startingPlace.latitude = 44.801700;
    startingPlace.longitude = 10.328012;
    
    MKCoordinateRegion mapRegion;
    mapRegion.center = startingPlace;
    mapRegion.span.latitudeDelta = 0.1;
    mapRegion.span.longitudeDelta = 0.1;
    
    [self.map setRegion:mapRegion animated:YES];
    self.map.showsUserLocation = YES;
    
    [self.listOfMemorandums getElementAt:0].location.latitude = @(44.803611);
    [self.listOfMemorandums getElementAt:0].location.longitude = @(10.317278);
        
    for(MDMemorandum* temp in self.listOfMemorandums.list) {
        [self.map addAnnotation:temp.location];
    }
}

/*- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *currentLocation = [locations lastObject];
    
}*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
