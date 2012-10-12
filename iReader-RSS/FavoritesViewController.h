//
//  FavoritesViewController.h
//  iReader-RSS
//
//  Created by Julien Sarazin on 16/09/12.
//  Copyright (c) 2012 Julien Sarazin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RssManager.h"

@interface FavoritesViewController : UICollectionViewController

@property RssManager *manager;
@end
