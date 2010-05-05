//
//  FMapView.h
//  MapRoutes
//
//  Created by Grant Davis on 5/3/10.
//  Copyright 2010 Factory Design Labs. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FMapView : MKMapView {

}

-(void)drawPathFromPoints:(NSArray*)points withContext:(CGContextRef)context withinView:(UIView*)view

@end
