//
//  TAnotation.m
//  LocateMe
//
//  Created by  on 11-10-20.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "MyAnotation.h"


////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation MyAnotation

@synthesize coordinate;


////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate
{
    coordinate.latitude = newCoordinate.latitude;
    coordinate.longitude = newCoordinate.longitude;
}


////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Titles


////////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString *)title
{
	return NSLocalizedString(@"Location Reported", nil);
}


////////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString *)subtitle
{
	return NSLocalizedString(@"Long press to drag", nil);
}


@end