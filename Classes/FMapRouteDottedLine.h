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
	NSArray *_dotDashes;
	UIColor *_dotColor;
	NSNumber *_dotPhase;
	UIColor *_lineColor;
	CGLineCap _lineCap;
	CGLineJoin _lineJoin;
}

@property (nonatomic,copy) NSArray* dotDashes;
@property (nonatomic,retain) UIColor* dotColor;
@property (nonatomic,retain) NSNumber* dotPhase;
@property (nonatomic,retain) UIColor* lineColor;
@property (nonatomic,assign) CGLineCap lineCap;
@property (nonatomic,assign) CGLineJoin lineJoin;

@end
