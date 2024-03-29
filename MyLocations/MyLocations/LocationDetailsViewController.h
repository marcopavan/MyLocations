//
//  LocationDetailsViewController.h
//  MyLocations
//
//  Created by Marco Pavan on 26/04/12.
//  Copyright (c) 2012 mpsoftware. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryPickerViewController.h"

@interface LocationDetailsViewController : UITableViewController <UITextViewDelegate, CategoryPickerViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (strong, nonatomic) IBOutlet UILabel *categoryLabel;
@property (strong, nonatomic) IBOutlet UILabel *latitudeLabel;
@property (strong, nonatomic) IBOutlet UILabel *longitudeLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong) CLPlacemark *placemark;

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;

@end
