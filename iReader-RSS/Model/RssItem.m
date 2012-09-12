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

@synthesize title;
@synthesize date;
@synthesize description;
@synthesize link;
@synthesize enclosure;

- (id)init
{
	if ([super init] != nil)
	{
		title = nil;
		description = nil;
		link = nil;
	}
	
	return self;
}

- (id)initWithArray:(NSDictionary *)dictionnary
{
	title = [[NSString alloc] initWithString:[dictionnary objectForKey:@"title"]];
	
	NSString *rawDescription = [[NSString alloc ] initWithString:[dictionnary objectForKey:@"description"]];
	description = [rawDescription gtm_stringByUnescapingFromHTML];
	
	link = [[NSURL alloc] initWithString:[dictionnary objectForKey:@"link"]];

	
	return self;
}

- (id)initWithXmlElement:(CXMLElement *)xmlElement
{
	NSError *error;
	
	title = [[xmlElement nodeForXPath:@"title" error:&error] stringValue];
	date = [[xmlElement nodeForXPath:@"pubDate" error:&error] stringValue];
	
	NSString *rawDescription = [[xmlElement nodeForXPath:@"description" error:&error] stringValue];
	if(rawDescription)
		description = [rawDescription gtm_stringByUnescapingFromHTML];
	
	enclosure = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[[xmlElement nodeForXPath:@"enclosure" error:&error] stringValue]]];
	link = [[NSURL alloc] initWithString:[[xmlElement nodeForXPath:@"link" error:nil] stringValue]];
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
	NSLog(@"link: %@\n", link);
	NSLog(@"------------------------------------\n");
}
				 
@end
