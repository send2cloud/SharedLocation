//
//  TAnotation.h
//  LocateMe
//
//  Created by  on 11-10-20.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MyAnotation : NSObject<MKAnnotation>

- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate;

@end
