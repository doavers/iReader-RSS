//
//  RSSChannel.h
//  iReader-RSS
//
//  Created by Julien Sarazin on 16/09/12.
//  Copyright (c) 2012 Julien Sarazin. All rights reserved.
//

#import <Foundation/Foundation.h>

#define Key_LeMondeTechnologies  @"0"
#define Key_LeMondeEconomie  @"1"
#define key_LeMondeAlaUne  @"2"
#define key_LeMondeCulture  @"3"
#define key_LeMondeSport  @"4"
#define key_LeMondePolitique  @"5"
#define key_LeMondeLitterature  @"6"
#define key_LeMondeInternational  @"7"

@protocol RSSChannelSelectorDelegate
@required
- (void)currentChannelChanged;

@end

@interface RSSChannelSelector : NSObject

+ (RSSChannelSelector*)sharedRSSChannel;

@property NSDictionary *channels;
@property NSInteger currentIndex;
@property UIViewController<RSSChannelSelectorDelegate> *delegate;

- (void) setCurrentChannelFromString:(NSString *)channelUrlKey;
- (NSURL*)getCurrentChannel;

@end