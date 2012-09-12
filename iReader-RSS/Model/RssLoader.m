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
- (void)fetchRssFromUrl:(NSURL*)url;

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

- (void)loadWithURL:(NSURL *)url
{
	[self dispatchLoadingOperationWithURL:url];
}

- (void)dispatchLoadingOperationWithURL:(NSURL *)url
{
	NSOperationQueue *queue = [NSOperationQueue new];
	NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self
																			selector:@selector(fetchRssFromUrl:)
																			  object:url];
	
	[queue addOperation:operation];
}

- (RssItem *)getRssItemFromXmlElement:(CXMLElement *)xmlElement
{
	return [[RssItem alloc]initWithXmlElement:xmlElement];
}

- (void)fetchRssFromUrl:(NSURL *)url
{

	NSError *error;
	CXMLDocument *parser = [[CXMLDocument alloc] initWithContentsOfURL:url options:0 error:&error];
	if(!parser)
	{
		[self.delegate performSelectorOnMainThread:@selector(updateFailedWithError:) withObject:error waitUntilDone:YES];
		return; 
	}
	
	self.loaded = YES;
	NSString *title = [[[parser rootElement] nodeForXPath:@"/rss/channel/title" error:nil] stringValue];
	NSLog(@"DEBUG: %@ ", title);
	
	[self.delegate performSelectorOnMainThread:@selector(feedTitleUpdated:) withObject:title waitUntilDone:YES];
	
	NSArray *xmlElements = [[parser rootElement] nodesForXPath:@"channel//item" error:nil];
	
	
	NSMutableArray* rssItems = [NSMutableArray arrayWithCapacity:xmlElements.count];
	for(CXMLElement *xmlElement in xmlElements)
		[rssItems addObject: [self getRssItemFromXmlElement:xmlElement]];
	

	[self.delegate performSelectorOnMainThread:@selector(rssItemsUpdated:) withObject:rssItems waitUntilDone:YES];
}




@end
