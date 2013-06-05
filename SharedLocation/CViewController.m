//
//  CViewController.m
//  SharedLocation
//
//  Created by every2003 on 12-7-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CViewController.h"
#import "CAppDelegate.h"
#import "CMapViewController.h"

#define SEGUE_ID_TO_MAP @"reportLocation"

@implementation CViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

-(void)viewDidAppear:(BOOL)animated
{
    CAppDelegate* appDelegate = (CAppDelegate*) [[UIApplication sharedApplication] delegate];
    if (appDelegate.location.x != 0 && appDelegate.location.y != 0)
    {
        NSLog(@"Got location");
        location = appDelegate.location;
        appDelegate.location = CGPointMake(0.0f, 0.0f);
        [self performSegueWithIdentifier:SEGUE_ID_TO_MAP sender:self];
    }    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"prepareForSegue: %@", segue.identifier);
    
    if ([segue.identifier isEqualToString:SEGUE_ID_TO_MAP]) {
        if (location.x != 0 && location.y != 0) {
            CMapViewController* mapView = (CMapViewController*) segue.destinationViewController;
            CLLocationCoordinate2D locationCoordinate;
            locationCoordinate.latitude = location.x;
            locationCoordinate.longitude = location.y;

            mapView.m_annotation = [[MyAnotation alloc] init];
            [mapView.m_annotation setCoordinate:locationCoordinate];
        }
    }
}

-(IBAction)btnQueryLocationClicked:(id)sender
{
    [self sendSMS:@"http://weiz.mobi/r (location request)" recipientList:nil];
}

-(void)sendSMS:(NSString *)bodyOfMessage recipientList:(NSArray *)recipients
{
    NSLog(@"start");
    MFMessageComposeViewController *controller = [[[MFMessageComposeViewController alloc] init] autorelease];
    
    controller.body = bodyOfMessage;   
    controller.recipients = recipients;
    controller.messageComposeDelegate = self;
    [self presentModalViewController:controller animated:YES];
}

#pragma mark MFMessageComposeViewControllerDelegate

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self dismissModalViewControllerAnimated:YES];
}

@end
