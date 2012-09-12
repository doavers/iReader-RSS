//
//  RssItemCell.m
//  iReader-RSS
//
//  Created by Julien Sarazin on 13/09/12.
//  Copyright (c) 2012 Julien Sarazin. All rights reserved.
//

#import "RssItemCell.h"

@implementation RssItemCell

@synthesize enclosure,description,title;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
