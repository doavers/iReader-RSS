//
//  RootViewController.h
//  iReader-RSS
//
//  Created by Julien Sarazin on 11/09/12.
//  Copyright (c) 2012 Julien Sarazin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RssLoader.h"
#import "RssManager.h"

@interface RootViewController : UITableViewController <RssManagerDelegate, UIAlertViewDelegate>

@property RssManager *manager;
@property BOOL connected;

@end
