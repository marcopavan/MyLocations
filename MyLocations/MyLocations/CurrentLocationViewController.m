//
//  CurrentLocationViewController.m
//  MyLocations
//
//  Created by Marco Pavan on 24/04/12.
//  Copyright (c) 2012 mpsoftware. All rights reserved.
//

#import "CurrentLocationViewController.h"

@interface CurrentLocationViewController ()
    -(void)updateLabels;
    - (void)startLocationManager;
    - (void)stopLocationManager;
    -(void)configureGetButton;
@end

@implementation CurrentLocationViewController {
    CLLocationManager *locationManager;
    CLLocation *location;
    BOOL updatingLocation;
    NSError *lastLocationError;
}

@synthesize messageLabel;
@synthesize latitudeLabel;
@synthesize longitudeLabel;
@synthesize addressLabel;
@synthesize tagButton;
@synthesize getButton;

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        locationManager = [[CLLocationManager alloc] init];
    }
    return self;
}

-(void)configureGetButton {
    if (updatingLocation) {
        [self.getButton setTitle:@"Stop" forState:UIControlStateNormal];
    } else {
        [self.getButton setTitle:@"Get My Location" forState:UIControlStateNormal];
    }
}

-(void)updateLabels {
    if (location != nil) {
        self.messageLabel.text = @"GPS Coordinates";
        self.latitudeLabel.text = [NSString stringWithFormat:@"%.8f", location.coordinate.latitude];
        self.longitudeLabel.text = [NSString stringWithFormat:@"%.8f", location.coordinate.longitude];
        self.tagButton.hidden = NO;
    } else {
        self.latitudeLabel.text = @"";
        self.longitudeLabel.text = @"";
        self.addressLabel.text = @"";
        self.tagButton.hidden = YES;
        
        NSString *statusMessage;
        if (lastLocationError != nil) {
            if ([lastLocationError.domain isEqualToString:kCLErrorDomain] &&
                lastLocationError.code == kCLErrorDenied) {
                statusMessage = @"Location Services Disabled";
            } else {
                statusMessage = @"Error Getting Location";
            }
        } else if (![CLLocationManager locationServicesEnabled]) {
            statusMessage = @"Location Services Disabled";
        } else if (updatingLocation) {
            statusMessage = @"Searching...";
        } else {
            statusMessage = @"Press the Button to Start";
        }
        self.messageLabel.text = statusMessage;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateLabels];
    [self configureGetButton];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setMessageLabel:nil];
    [self setLatitudeLabel:nil];
    [self setLongitudeLabel:nil];
    [self setAddressLabel:nil];
    [self setTagButton:nil];
    [self setGetButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)tagLocation:(id)sender {
}

- (IBAction)getLocation:(id)sender {
    if (updatingLocation) {
        [self stopLocationManager];
    } else {
        location = nil;
        lastLocationError = nil;
        [self startLocationManager];
    }
    
    [self updateLabels];
    [self configureGetButton];
}

- (void)startLocationManager {
    if ([CLLocationManager locationServicesEnabled]) {
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
        [locationManager startUpdatingLocation];
        updatingLocation = YES;
    }
}

-(void)stopLocationManager {
    if (updatingLocation) {
        [locationManager stopUpdatingLocation];
        locationManager.delegate = nil;
        updatingLocation = NO;
    }
}

#pragma mark - CLLocationManagerDelegate

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"didFailWithError %@", error);
    if (error.code == kCLErrorLocationUnknown) {
        return;
    }
    [self stopLocationManager];
    lastLocationError = error;
    [self updateLabels];
    [self configureGetButton];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    NSLog(@"didUpdateToLocation %@", newLocation);
    
    if ([newLocation.timestamp timeIntervalSinceNow] < -5.0) {
        return;
    }
    
    if (newLocation.horizontalAccuracy <0) {
        return;
    }
    
    if (location ==nil || location.horizontalAccuracy > newLocation.horizontalAccuracy) {
        lastLocationError = nil;
        location = newLocation;
        [self updateLabels];
        
        if (newLocation.horizontalAccuracy <= locationManager.desiredAccuracy) {
            NSLog(@"*** We're done!");
            [self stopLocationManager];
            [self configureGetButton];
        }
    }
    
    
}

@end
