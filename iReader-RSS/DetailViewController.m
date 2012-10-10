//
//  DetailViewController.m
//  iReader-RSS
//
//  Created by Julien Sarazin on 11/09/12.
//  Copyright (c) 2012 Julien Sarazin. All rights reserved.
//

#import "DetailViewController.h"
#import "RssItem.h"

@interface DetailViewController ()
- (void)saveItem:(RssItem *)item;
@end


@implementation DetailViewController

@synthesize webview, rssItem;

- (void)saveItem:(RssItem *)item
{
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
	{
		
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[webview loadRequest:[NSURLRequest requestWithURL:self.rssItem.link]];
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
	[self saveItem:self.rssItem];
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
@end
