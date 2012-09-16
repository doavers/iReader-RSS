//
//  DetailViewController.h
//  iReader-RSS
//
//  Created by Julien Sarazin on 11/09/12.
//  Copyright (c) 2012 Julien Sarazin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RssItem.h"

@interface DetailViewController : UIViewController <UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *webview;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *loader;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *navigationBackButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *navigationForwardButton;

@property RssItem* rssItem;


- (IBAction)onForwardButtonPressed:(id)sender;
- (IBAction)onBackButtonPressed:(id)sender;

@end
