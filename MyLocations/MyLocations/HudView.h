//
//  HudView.h
//  MyLocations
//
//  Created by Marco Pavan on 28/04/12.
//  Copyright (c) 2012 mpsoftware. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HudView : UIView

+ (HudView *)hudInView:(UIView *)view animated:(BOOL)animated;

@property (nonatomic, strong) NSString *text;

@end
