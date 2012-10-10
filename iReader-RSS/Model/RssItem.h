//
//  RssItem.h
//  iReader-RSS
//
//  Created by Julien Sarazin on 11/09/12.
//  Copyright (c) 2012 Julien Sarazin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TouchXML.h"
#import "GTMNSString+HTML.h"

@interface RssItem : NSObject

@property NSString *channel;
@property NSString *title;
@property NSURL *link;
@property NSString *date;
@property NSString *description;
@property NSURL *enclosure;

- (id)init;
- (id)initWithArray:(NSDictionary *) dictionary;
- (id)initWithXmlElement:(CXMLElement *) xmlElement;

@end
