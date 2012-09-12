//
//  RssItemCell.h
//  iReader-RSS
//
//  Created by Julien Sarazin on 13/09/12.
//  Copyright (c) 2012 Julien Sarazin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RssItemCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UIImageView *enclosure;
@property (strong, nonatomic) IBOutlet UILabel *description;

@end
