//
//  RssLoader.m
//  iReader-RSS
//
//  Created by Julien Sarazin on 11/09/12.
//  Copyright (c) 2012 Julien Sarazin. All rights reserved.
//

#import "RssLoader.h"

@interface RssLoader ()

- (void)dispatchLoadingOperationWithURL:(NSURL *)url;
- (RssItem *)getRssItemFromXmlElement:(CXMLElement *)xmlElement;
- (void)fetchFeedsFromUrl:(NSURL*)url;

@end

@implementation RssLoader

@synthesize delegate;
@synthesize loaded;

- (id)init
{
	if([super init] != nil)
		self.loaded = NO;
	
	return self;
}

- (void)updateFeedsWithURL:(NSURL *)url
{
	[self dispatchLoadingOperationWithURL:url];
}

- (void)dispatchLoadingOperationWithURL:(NSURL *)url
{
	NSOperationQueue *queue = [NSOperationQueue new];
	NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self
																			selector:@selector(fetchFeedsFromUrl:)
																			  object:url];
	
	[queue addOperation:operation];
}

- (RssItem *)getRssItemFromXmlElement:(CXMLElement *)xmlElement
{
	return [[RssItem alloc]initWithXmlElement:xmlElement];
}

- (void)fetchFeedsFromUrl:(NSURL *)url
{	
	NSLog(@"Fetching Rss from this URL: %@", url.absoluteString);
	NSError *error;
	CXMLDocument *parser = [[CXMLDocument alloc] initWithContentsOfURL:url options:0 error:&error];
	if(!parser)
	{
		[self.delegate performSelectorOnMainThread:@selector(updateFailedWithError:) withObject:error waitUntilDone:YES];
		return; 
	}
	
	NSLog(@"Rss fetched without problems.");
	self.loaded = YES;
	
	NSLog(@"Creating XML nodes from content fetched.");
	NSArray *xmlElements = [[parser rootElement] nodesForXPath:@"channel//item" error:nil];
	NSMutableArray* rssItems = [NSMutableArray arrayWithCapacity:xmlElements.count];
	
	NSLog(@"Creating logic item from xml data...");
	for(CXMLElement *xmlElement in xmlElements)
		[rssItems addObject: [self getRssItemFromXmlElement:xmlElement]];

	NSLog(@"Transmitting feeds to the manager...");
	[self.delegate rssItemsUpdated:rssItems];
}




@end
