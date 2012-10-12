//
//  RssItem.m
//  iReader-RSS
//
//  Created by Julien Sarazin on 11/09/12.
//  Copyright (c) 2012 Julien Sarazin. All rights reserved.
//

#import "RssItem.h"
#import "TouchXML.h"

@interface RssItem ()

- (void)debugLogs;

@end

@implementation RssItem

@synthesize channel;
@synthesize title;
@synthesize date;
@synthesize description;
@synthesize absoluteFeedUrl;
@synthesize enclosure;

- (id)init
{
	if ([super init] != nil)
	{
		title = nil;
		description = nil;
		absoluteFeedUrl = nil;
	}
	
	return self;
}

- (id)initWithArray:(NSDictionary *)dictionnary
{
#warning TODO
	return self;
}

- (id)initWithXmlElement:(CXMLElement *)xmlElement
{
	NSString *rawDescription, *unescapedDescription;
	NSError *error;
	
	title = [[xmlElement nodeForXPath:@"title" error:&error] stringValue];
	date = [[xmlElement nodeForXPath:@"pubDate" error:&error] stringValue];
	
	rawDescription = [[xmlElement nodeForXPath:@"description" error:&error] stringValue];
	if(rawDescription)
		 unescapedDescription = [rawDescription gtm_stringByUnescapingFromHTML];
	
	NSRange rangeOfSubstring = [unescapedDescription rangeOfString:@"<img"];
	
	if(rangeOfSubstring.location != NSNotFound)
		description = [unescapedDescription substringToIndex:rangeOfSubstring.location];
	
	
	enclosure = [NSData  dataWithContentsOfURL:[NSURL URLWithString:[[xmlElement nodeForXPath:@"enclosure/attribute::url" error:&error] stringValue]]];
	
	absoluteFeedUrl = [[xmlElement nodeForXPath:@"link" error:nil] stringValue];
	
	[self debugLogs];
	return self;
}

- (void)debugLogs
{
	NSLog(@"RssItem Created.\n");
	NSLog(@"------------------------------------\n");
	NSLog(@"title: %@\n", title);
	NSLog(@"Date: %@", date);
	NSLog(@"Description: %@", description);
	NSLog(@"Enclosure: %@", enclosure);
	NSLog(@"link: %@\n", absoluteFeedUrl);
	NSLog(@"------------------------------------\n");
}
				 
@end
