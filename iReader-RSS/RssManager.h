//
//  RssManager.h
//  iReader-RSS
//
//  Created by Julien Sarazin on 08/10/12.
//  Copyright (c) 2012 Julien Sarazin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RssLoader.h"
#import "RssItem.h"

#define Key_FeedsLeMondeTechnologies  @"http://www.lemonde.fr/rss/tag/technologies.xml"
#define Key_FeedsLeMondeEconomie  @"http://www.lemonde.fr/rss/tag/economie.xml"
#define key_FeedsLeMondeAlaUne  @"http://www.lemonde.fr/rss/une.xml"
#define key_FeedsLeMondeInternational  @"http://www.lemonde.fr/rss/tag/culture.xml"
#define key_FeedsLeMondeSport  @"http://www.lemonde.fr/rss/tag/international.xml"
#define key_FeedsLeMondePolitique  @"http://www.lemonde.fr/rss/tag/politique.xml"
#define key_FeedsLeMondeLitterature  @"http://www.lemonde.fr/rss/tag/livres.xml"
#define key_FeedsLeMondeCulture @"http://www.lemonde.fr/rss/tag/sport.xml"

#define key_Persistence_Favorites @"Favorites"

@protocol RssManagerDelegate
- (void)feedsLoadedForChannel:(NSString *)channel;
- (void)feedsLoadFailedWithError:(NSError *)error;
@end

@interface RssManager : NSObject <RSSLoaderDelegate>

@property RssLoader *loader;
@property (readonly) NSString *currentChannel;
@property NSMutableArray *channelsIndex;
@property NSMutableDictionary *feeds;
@property NSMutableDictionary *favorites;
@property UIViewController<RssManagerDelegate> *delegate;

+ (RssManager *)sharedRssManager;

- (void)reloadFeedsFromAbsolutreStringURL:(NSString *)url;
- (void)loadFeeds;
- (void)addFeedToFavorites:(RssItem *)item;
@end
