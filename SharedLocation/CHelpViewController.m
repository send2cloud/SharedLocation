//
//  CHelpViewController.m
//  SharedLocation
//
//  Created by every2003 on 12-8-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CHelpViewController.h"

#define HELP_IMAGE_COUNT    4

@implementation CHelpViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    CGRect bounds = CGRectMake(0, 0, 320, 480);
    
    // Init Scroll View
    m_scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.width, bounds.size.height)];
    [m_scrollView setContentSize:CGSizeMake(bounds.size.width * (HELP_IMAGE_COUNT + 1),
                                            bounds.size.height)];
    m_scrollView.pagingEnabled = YES;
    [m_scrollView setDelegate:self];
    m_scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:m_scrollView];
    
    for (int i = 0; i < HELP_IMAGE_COUNT; i++) {
        UIImageView* imageView = [[[UIImageView alloc] initWithFrame:CGRectMake(bounds.origin.x + bounds.size.width * i, bounds.origin.y, bounds.size.width, bounds.size.height)] autorelease];
        
        NSString* imageName = [NSString stringWithFormat:@"help%d.png", i];
        [imageView setImage:[UIImage imageNamed:imageName]];
        
        [m_scrollView addSubview:imageView];
    }
    
    
    // Init Page control
//    m_pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 420, 320, 30)];
//    m_pageControl.numberOfPages = HELP_IMAGE_COUNT;
//    m_pageControl.currentPage = 0;
//    [m_pageControl addTarget:self action:@selector(pageTurn:) forControlEvents:UIControlEventValueChanged];
//    [self.view addSubview:m_pageControl];
    
    // Init Lables
    [m_lbTitle2 setFrame:CGRectMake(bounds.size.width, 18, bounds.size.width, 28)];
    [m_lbTitle2 setText:NSLocalizedString(@"help_title2", nil)];
    [m_scrollView addSubview:m_lbTitle2];
    [m_lbTitle3 setFrame:CGRectMake(bounds.size.width * 2, 18, bounds.size.width, 28)];
    [m_lbTitle3 setText:NSLocalizedString(@"help_title3", nil)];
    [m_scrollView addSubview:m_lbTitle3];
    [m_lbTitle4 setFrame:CGRectMake(bounds.size.width * 3, 18, bounds.size.width, 28)];
    [m_lbTitle4 setText:NSLocalizedString(@"help_title4", nil)];
    [m_scrollView addSubview:m_lbTitle4];
    
    // Init help text
    [m_text1 setFrame:CGRectMake(0, 400, bounds.size.width, 60)];
    [m_text1 setText:NSLocalizedString(@"help_text1", nil)];
    [m_scrollView addSubview:m_text1];
    [m_text2 setFrame:CGRectMake(bounds.size.width, 400, bounds.size.width, 60)];
    [m_text2 setText:NSLocalizedString(@"help_text2", nil)];
    [m_scrollView addSubview:m_text2];
    [m_text3 setFrame:CGRectMake(bounds.size.width * 2, 400, bounds.size.width, 60)];
    [m_text3 setText:NSLocalizedString(@"help_text3", nil)];
    [m_scrollView addSubview:m_text3];
    [m_text4 setFrame:CGRectMake(bounds.size.width * 3, 400, bounds.size.width, 60)];
    [m_text4 setText:NSLocalizedString(@"help_text4", nil)];
    [m_scrollView addSubview:m_text4];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

-(void) dealloc
{
    [m_scrollView release];
    //[m_pageControl release];
    [super dealloc];
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;
    CGRect bounds = scrollView.frame;
    int index = offset.x / bounds.size.width;
    
    // Check if it's coming to the last page
    if (index == HELP_IMAGE_COUNT) {
        [self dismissModalViewControllerAnimated:YES];
    }
    
    //[m_pageControl setCurrentPage:offset.x / bounds.size.width];
}
//
//- (void)pageTurn:(UIPageControl*)sender
//{
//    CGSize viewSize = m_scrollView.frame.size;
//    CGRect rect = CGRectMake(sender.currentPage * viewSize.width, 0, viewSize.width, viewSize.height);
//    [m_scrollView scrollRectToVisible:rect animated:YES];
//}

@end
