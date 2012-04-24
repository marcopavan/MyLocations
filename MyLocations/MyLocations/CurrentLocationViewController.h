//
//  CurrentLocationViewController.h
//  MyLocations
//
//  Created by Marco Pavan on 24/04/12.
//  Copyright (c) 2012 mpsoftware. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface CurrentLocationViewController : UIViewController <CLLocationManagerDelegate>

@property (strong, nonatomic) IBOutlet UILabel *messageLabel;
@property (strong, nonatomic) IBOutlet UILabel *latitudeLabel;
@property (strong, nonatomic) IBOutlet UILabel *longitudeLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;

@property (strong, nonatomic) IBOutlet UIButton *tagButton;
@property (strong, nonatomic) IBOutlet UIButton *getButton;

- (IBAction)tagLocation:(id)sender;
- (IBAction)getLocation:(id)sender;

@end
