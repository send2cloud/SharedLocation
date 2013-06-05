//
//  CMapViewController.m
//  SharedLocation
//
//  Created by every2003 on 12-7-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CMapViewController.h"
#import "MyAnotation.h"
#import <QuartzCore/QuartzCore.h>

@implementation CMapViewController

@synthesize m_annotation;

- (void)viewDidLoad
{
    NSLog(@"CMapViewController viewDidLoad, location = %f, %f", self.m_annotation.coordinate.latitude, self.m_annotation.coordinate.longitude);
    [super viewDidLoad];
    
    m_bWasUserLocationUpdated = FALSE;
    
    m_bPinDraggable = (m_annotation == nil);
    if (!m_bPinDraggable) {
        m_sendBtn.enabled = NO;
    }
    
    // Set Buttons
    [m_homeBtn setTitle:NSLocalizedString(@"map_bar_btn_home", nil)];
    [m_localBtn setTitle:NSLocalizedString(@"map_bar_btn_local", nil)];
    [m_pinBtn setTitle:NSLocalizedString(@"map_bar_btn_pin", nil)];
    [m_sendBtn setTitle:NSLocalizedString(@"map_bar_btn_send", nil)];
    
    // Set Long press gesture
    m_longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureStateChanged:)];
    [m_mapView addGestureRecognizer:m_longPressGesture];

    // Init Ad Mob
    //m_isAdVisiable = NO;
    //m_adView.requiredContentSizeIdentifiers = [NSSet setWithObject:ADBannerContentSizeIdentifierPortrait];
    //m_adView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierPortrait;
    //[m_adView setHidden:YES];
    //m_adView.delegate = self;
    
    // Init map
    m_indiView.layer.cornerRadius = 10.0f;
    [m_indicator startAnimating];
    [m_indiText setText:NSLocalizedString(@"querying position", nil)];
    [self initMapView];
}
//
//-(void)viewDidDisappear:(BOOL)animated
//{
//    [super viewDidDisappear:animated];
//}

-(void) dealloc
{
    NSLog(@"CMapViewController released");
    [m_longPressGesture release];
    [m_annotation release];
    [m_mapView release];
    [m_sendBtn release];
    [super dealloc];
}

-(void) initMapView
{
    [m_mapView setMapType:MKMapTypeStandard];
    [m_mapView setDelegate:self];

    m_mapView.showsUserLocation = YES;
}

-(IBAction)btnGoHomeClicked:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

-(IBAction)btnFindPathClicked:(id)sender
{
    [m_mapView setCenterCoordinate:m_annotation.coordinate animated:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)btnFindMeClicked:(id)sender
{
    [m_mapView setCenterCoordinate:m_mapView.userLocation.coordinate animated:YES];
}

-(IBAction)btnSendClicked:(id)sender
{
    NSString* sms = [NSString stringWithFormat:@"http://weiz.mobi/r?q=%f,%f (location report)",
                     m_annotation.coordinate.latitude,
                     m_annotation.coordinate.longitude];
    [self sendSMS:sms recipientList:nil];
}

-(void)sendSMS:(NSString *)bodyOfMessage recipientList:(NSArray *)recipients
{
    MFMessageComposeViewController *controller = [[[MFMessageComposeViewController alloc] init] autorelease];
    
    if([MFMessageComposeViewController canSendText])
    {
        controller.body = bodyOfMessage;   
        controller.recipients = recipients;
        controller.messageComposeDelegate = self;
        [self presentModalViewController:controller animated:YES];
    }   
}

-(void)longPressGestureStateChanged:(UIGestureRecognizer*)gestureRecognizer
{
    if (!m_bPinDraggable) {
        return;
    }
    
    CGPoint p = [gestureRecognizer locationInView:m_mapView];    
    CLLocationCoordinate2D loc = [m_mapView convertPoint:p toCoordinateFromView:m_mapView];
    
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        [m_mapView removeAnnotation:m_annotation];
        [m_annotation setCoordinate:loc];
        [m_mapView addAnnotation:m_annotation];
        [m_mapView selectAnnotation:m_annotation animated:YES];
    }
}

#pragma mark MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    if (m_bWasUserLocationUpdated) {
        return;
    }
    
    if (userLocation.coordinate.latitude == 0.0f &&
        userLocation.coordinate.longitude == 0.0f) {
        return;
    }
    
    m_bWasUserLocationUpdated = TRUE;
    [m_indicator stopAnimating];
    [m_indiView setHidden:YES];
    
    NSLog(@"mapView didUpdateUserLocation:%f, %f", userLocation.coordinate.latitude, userLocation.coordinate.longitude);
    if (m_annotation == nil) {
        NSLog(@"Create annotation");
        m_annotation = [[MyAnotation alloc] init];
        [m_annotation setCoordinate:userLocation.coordinate];
        
        [m_mapView addAnnotation:m_annotation];
        MKCoordinateSpan span;
        span.latitudeDelta = 0.05f;
        span.longitudeDelta = 0.05f;
        
        MKCoordinateRegion region;
        region.center = userLocation.coordinate;
        region.span = span;
        
        [m_mapView setRegion:region animated:YES];
    }
    else {
        [m_mapView addAnnotation:m_annotation];

        MKCoordinateSpan span;
        span.latitudeDelta = fabs(userLocation.coordinate.latitude - m_annotation.coordinate.latitude);
        span.longitudeDelta = fabs(userLocation.coordinate.longitude - m_annotation.coordinate.longitude);
        
        MKCoordinateRegion region;
        region.center.latitude = fabs(userLocation.coordinate.latitude + m_annotation.coordinate.latitude) / 2;
        region.center.longitude = fabs(userLocation.coordinate.longitude + m_annotation.coordinate.longitude) / 2;
        region.span = span;
        
        [m_mapView setRegion:region animated:YES];
    }
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    static NSString* annotationID = @"MyLocation";
    if (![annotation isKindOfClass:[MyAnotation class]]) {
        return nil;
    }
    
    MKPinAnnotationView* pinView = (MKPinAnnotationView*) [mapView dequeueReusableAnnotationViewWithIdentifier:annotationID];
    if (pinView == nil) {
        NSLog(@"Add new one");
        pinView = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotationID] autorelease];
        pinView.animatesDrop = YES;
        pinView.canShowCallout = YES;
        pinView.draggable = m_bPinDraggable;
    }
    else {
        NSLog(@"Use old one: %d", pinView.annotation == annotation);
        pinView.annotation = annotation;
    }
    
    return pinView;
}

#pragma mark MFMessageComposeViewControllerDelegate

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark ADBannerViewDelegate

//- (void)bannerViewDidLoadAd:(ADBannerView *)banner
//{
//    if (!m_isAdVisiable) {
//        //m_isAdVisiable = YES;
//        //[m_adView setHidden:NO];
//    }
//}
//
//-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
//{
//    if (m_isAdVisiable) {
//        m_isAdVisiable = NO;
//        [m_adView setHidden:YES];
//    }
//}

@end
