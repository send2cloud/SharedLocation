//
//  CViewController.h
//  SharedLocation
//
//  Created by every2003 on 12-7-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAD/iAd.h>
#import <MessageUI/MFMessageComposeViewController.h>

@interface CViewController : UIViewController<MFMessageComposeViewControllerDelegate> {
    IBOutlet UIButton* btnRequest;
    CGPoint location;
}

// 'Request Location' Button responder
-(IBAction)btnQueryLocationClicked:(id)sender;

@end
