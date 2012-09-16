//
//  RootViewController.h
//  iReader-RSS
//
//  Created by Julien Sarazin on 11/09/12.
//  Copyright (c) 2012 Julien Sarazin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RssLoader.h"
#import "RSSChannelSelector.h"

@interface RootViewController : UITableViewController <RSSLoaderDelegate, RSSChannelSelectorDelegate>

@property RssLoader *rssLoader;
@property NSMutableArray *rssItems;
@property BOOL connected;
@property RSSChannelSelector *selector;

- (void)fetchRssItems;

@end
