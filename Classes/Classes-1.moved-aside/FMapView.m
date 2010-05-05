//
//  FMapView.m
//  MapRoutes
//
//  Created by Grant Davis on 5/3/10.
//  Copyright 2010 Factory Design Labs. All rights reserved.
//

#import "FMapView.h"


@implementation FMapView


- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


/*
 Plots a series of points into a defined graphics context.
 */
-(void)drawPathFromPoints:(NSArray*)points withContext:(CGContextRef)context withinView:(UIView*)view
{
	for(int i=0; i < points.count; i++)
	{
		CLLocation* location = [points objectAtIndex:i];
		CGPoint point = [self convertCoordinate:location.coordinate toPointToView:view];
		
		if(i == 0)
		{
			// move to the first point
			CGContextMoveToPoint(context, point.x, point.y);
		}
		else
		{
			CGContextAddLineToPoint(context, point.x, point.y);
		}
	}
}


- (void)dealloc {
    [super dealloc];
}


@end
