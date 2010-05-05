//
//  FMapRouteDottedLine.h
//  MapRoutes
//
//  Created by Grant Davis on 5/3/10.
//  Copyright 2010 Factory Design Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMapRouteLine.h"

@interface FMapRouteDottedLine : FMapRouteLine {
	UIColor *_dotColor;
	UIColor *_lineColor;
}

@property (nonatomic,retain) UIColor* dotColor;
@property (nonatomic,retain) UIColor* lineColor;

@end
