//
//  RSSChannel.m
//  iReader-RSS
//
//  Created by Julien Sarazin on 16/09/12.
//  Copyright (c) 2012 Julien Sarazin. All rights reserved.
//

#import "RSSChannelSelector.h"
@interface RSSChannelSelector ()
	@property NSString *selectedChannel;
@end


@implementation RSSChannelSelector

@synthesize channels;

static RSSChannelSelector *_sharedRssChannel;



+ (RSSChannelSelector*)sharedRSSChannel
{
	@synchronized([_sharedRssChannel class])
	{
		if (!_sharedRssChannel)
			_sharedRssChannel = [[RSSChannelSelector alloc] init];
		
		return _sharedRssChannel;
	}
	
	return nil;
}

+ (id)alloc
{
	@synchronized([_sharedRssChannel class])
	{
		NSAssert(_sharedRssChannel == nil, @"Attempted to allocate a second instance of a singleton.");
		_sharedRssChannel = [super alloc];
		return _sharedRssChannel;
	}
	
	return nil;
}

- (id)init {
	self = [super init];
	if (self != nil)
	{
		channels = @{
	Key_LeMondeEconomie:@"http://www.lemonde.fr/rss/tag/economie.xml",
	key_LeMondeAlaUne:@"http://www.lemonde.fr/rss/une.xml",
	key_LeMondeCulture:@"http://www.lemonde.fr/rss/tag/culture.xml",
	key_LeMondeInternational:@"http://www.lemonde.fr/rss/tag/international.xml",
	key_LeMondePolitique:@"http://www.lemonde.fr/rss/tag/politique.xml",
	key_LeMondeLitterature:@"http://www.lemonde.fr/rss/tag/livres.xml",
	key_LeMondeSport:@"http://www.lemonde.fr/rss/tag/sport.xml",
	Key_LeMondeTechnologies:@"http://www.lemonde.fr/rss/tag/technologies.xml"};
	}
	
	return self;
}

- (void)setCurrentChannelFromString:(NSString *)channelUrlKey
{
	self.selectedChannel = [channels valueForKey:channelUrlKey];
	self.currentIndex = [channelUrlKey integerValue];
	[self.delegate currentChannelChanged];
}

- (NSURL*)getCurrentChannel
{
	return [NSURL URLWithString:self.selectedChannel];
}

@end