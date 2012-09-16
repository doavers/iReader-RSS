//
//  RssLoader.h
//  iReader-RSS
//
//  Created by Julien Sarazin on 11/09/12.
//  Copyright (c) 2012 Julien Sarazin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RssItem.h"
#import "TouchXML.h"

@protocol RSSLoaderDelegate
@required
- (void)rssItemsUpdated:(NSArray *)items;
- (void)updateFailedWithError:(NSError *)error;
@end

@interface RssLoader : NSObject

@property UIViewController<RSSLoaderDelegate> *delegate;
@property BOOL loaded;

- (void)loadWithURL:(NSURL*)url;

@end
