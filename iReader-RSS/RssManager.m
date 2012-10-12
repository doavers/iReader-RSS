//
//  RssManager.m
//  iReader-RSS
//
//  Created by Julien Sarazin on 08/10/12.
//  Copyright (c) 2012 Julien Sarazin. All rights reserved.
//

#import "RssManager.h"

@interface RssManager ()
- (void)loadFavorites;
@end

@implementation RssManager
@synthesize currentChannel;

static RssManager *_sharedRssManagerInstance;

+ (RssManager *)sharedRssManager
{
	@synchronized([_sharedRssManagerInstance class])
	{
		if (!_sharedRssManagerInstance)
			_sharedRssManagerInstance = [[RssManager alloc] init];
		
		return _sharedRssManagerInstance;
	}
	
	return nil;
}

+ (id)alloc
{
	@synchronized([_sharedRssManagerInstance class])
	{
		NSAssert(_sharedRssManagerInstance == nil, @"Attempted to allocate a second instance of a singleton.");
		_sharedRssManagerInstance = [super alloc];
		return _sharedRssManagerInstance;
	}
	
	return nil;
}

- (id)init
{
	self = [super init];
	if (self != nil)
	{
		NSLog(@"Creating Instance of the Rss Manager...");
		self.loader = [[RssLoader alloc] init];
		self.loader.delegate = self;
		self.feeds = [[NSMutableDictionary alloc] init];
		self.channelsIndex =
		[@[
		key_FeedsLeMondeAlaUne,
		key_FeedsLeMondeCulture,
		Key_FeedsLeMondeEconomie,
		key_FeedsLeMondeInternational,
		key_FeedsLeMondeLitterature,
		key_FeedsLeMondePolitique,
		key_FeedsLeMondeSport,
		Key_FeedsLeMondeTechnologies
		] mutableCopy];
		[self loadFavorites];
	}
	return self;
}

#pragma mark - RssLoader delegates
- (void)rssItemsUpdated:(NSArray *)items
{
	NSLog(@"Rss items received by the manager.");
	[self.feeds setObject:items forKey:self.currentChannel];
	NSLog(@"Transmitting feeds to the viewController...");
	[self.delegate performSelectorOnMainThread:@selector(feedsLoadedForChannel:) withObject:self.currentChannel waitUntilDone:YES];
}

- (void)updateFailedWithError:(NSError *)error
{
	NSLog(@"Rss items update Failed.");
	[self.delegate feedsLoadFailedWithError: error];
}

- (void)loadFeeds;
{
	NSLog(@"Fetching feeds...");
	[self.loader updateFeedsWithURL: [NSURL URLWithString:self.currentChannel]];
}

- (void)loadFavorites
{
	NSLog(@"Loading Favorites feeds");
	self.favorites = [[NSUserDefaults standardUserDefaults] objectForKey:key_Persistence_Favorites];
}

- (void)addFeedToFavorites:(RssItem *)item
{
	NSLog(@"Adding new feed to Favorite");
	[[self.favorites objectForKey:self.currentChannel] addObject:item];
	NSLog(@"Saving it on the disk.");
	[[NSUserDefaults standardUserDefaults] setObject:self.favorites forKey:key_Persistence_Favorites];
}

- (void)reloadFeedsFromAbsolutreStringURL:(NSString *)url;
{
	NSLog(@"Reloaing feeds...");
	currentChannel = url;
	[self loadFeeds];
}
@end
