//
//  DetailViewController.m
//  iReader-RSS
//
//  Created by Julien Sarazin on 11/09/12.
//  Copyright (c) 2012 Julien Sarazin. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
- (void) saveFeed;
@end

@implementation DetailViewController

@synthesize webview, feed;

- (void)viewDidLoad
{
    [super viewDidLoad];
	[webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.feed.absoluteFeedUrl]]];
	self.webview.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onBackButtonPressed:(id)sender
{
	[self.webview goBack];
}

- (IBAction)onTouchUpInsideAddToFavorites:(id)sender
{
	[[RssManager sharedRssManager] addFeedToFavorites:feed];
}

- (IBAction)onForwardButtonPressed:(id)sender
{
	[self.webview goForward];
}

#pragma mark - UIWebView delegate
- (void)webViewDidStartLoad:(UIWebView *)webView
{
	self.loader.hidden = NO;
	[self.loader startAnimating];
	
	if(self.webview.canGoForward)
	{
		if(!self.navigationForwardButton.enabled)
			self.navigationForwardButton.enabled = YES;
	}
	else
	{
		if(self.navigationForwardButton.enabled)
			self.navigationForwardButton.enabled = NO;
	}
	
	if(self.webview.canGoBack)
	{
		if(!self.navigationBackButton.enabled)
			self.navigationBackButton.enabled = YES;
	}
	else
	{
		if(self.navigationBackButton.enabled)
			self.navigationBackButton.enabled = NO;
	}
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
	self.loader.hidden = YES;
	[self.loader stopAnimating];
}

- (void)saveFeed
{
	[[RssManager sharedRssManager] addFeedToFavorites:self.feed];
}

@end
