//
//  FavoritesViewController.m
//  iReader-RSS
//
//  Created by Julien Sarazin on 16/09/12.
//  Copyright (c) 2012 Julien Sarazin. All rights reserved.
//

#import "FavoritesViewController.h"
#import "DetailViewController.h"

@implementation FavoritesViewController


#pragma mark - View lifecycle
- (void)viewDidLoad
{
	self.manager = [RssManager sharedRssManager];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
	
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if([segue.identifier isEqualToString:@"Favorites"])
	{
		/*
		NSString *selectedChannel = self.manager.channelsIndex objectAtIndex:[self.collectionV]
		DetailViewController *controller = [segue destinationViewController];
		controller.feed = [self.manager.favorites objectForKey:@"]
		 */
	}
}


- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
	
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingSupplementaryView:(UICollectionReusableView *)view forElementOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
	
}

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
	
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
	
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
	
}

@end
