//
//  CHelpViewController.h
//  SharedLocation
//
//  Created by every2003 on 12-8-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHelpViewController : UIViewController<UIScrollViewDelegate> {
    UIScrollView*   m_scrollView;
    //UIPageControl*  m_pageControl;
    
    IBOutlet UILabel* m_lbTitle2;
    IBOutlet UILabel* m_lbTitle3;
    IBOutlet UILabel* m_lbTitle4;
    
    IBOutlet UITextView* m_text1;
    IBOutlet UITextView* m_text2;
    IBOutlet UITextView* m_text3;
    IBOutlet UITextView* m_text4;
}

@end
