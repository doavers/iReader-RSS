//
//  SettingsViewController.h
//  iReader-RSS
//
//  Created by Julien Sarazin on 16/09/12.
//  Copyright (c) 2012 Julien Sarazin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSSChannelSelector.h"

@interface SettingsViewController : UITableViewController

@property RSSChannelSelector *selector;
@end
