//
//  CMapViewController.h
//  SharedLocation
//
//  Created by every2003 on 12-7-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MyAnotation.h"
#import <MessageUI/MFMessageComposeViewController.h>
#import <iAd/iAd.h>

@interface CMapViewController : UIViewController<MKMapViewDelegate,MFMessageComposeViewControllerDelegate> {
    
    IBOutlet MKMapView* m_mapView;
    IBOutlet UIBarButtonItem* m_sendBtn;
    IBOutlet UIBarButtonItem* m_homeBtn;
    IBOutlet UIBarButtonItem* m_localBtn;
    IBOutlet UIBarButtonItem* m_pinBtn;
    
    // For indicator
    IBOutlet UIView* m_indiView;
    IBOutlet UIActivityIndicatorView* m_indicator;
    IBOutlet UILabel* m_indiText;
    
    MyAnotation*        m_annotation;
    UILongPressGestureRecognizer* m_longPressGesture;
    BOOL m_bWasUserLocationUpdated;
    BOOL m_bPinDraggable;

    // For Ad
    //IBOutlet ADBannerView* m_adView;
    bool m_isAdVisiable;
}

@property (retain, nonatomic) MyAnotation* m_annotation;

-(IBAction)btnGoHomeClicked:(id)sender;
-(IBAction)btnFindPathClicked:(id)sender;
-(IBAction)btnSendClicked:(id)sender;
-(IBAction)btnFindMeClicked:(id)sender;
@end
