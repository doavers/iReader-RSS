//
//  SettingsViewController.m
//  iReader-RSS
//
//  Created by Julien Sarazin on 16/09/12.
//  Copyright (c) 2012 Julien Sarazin. All rights reserved.
//

#import "SettingsViewController.h"

@implementation SettingsViewController

#pragma mark TableViewController life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.navigationItem.title = @"Réglages";
	self.manager = [RssManager sharedRssManager];
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	for (int i=0; i < 8; i++)
		[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]].accessoryType = UITableViewCellAccessoryNone;
	
	UITableViewCell* cell = [self.tableView cellForRowAtIndexPath:indexPath];
	cell.accessoryType = UITableViewCellAccessoryCheckmark;
	switch (indexPath.row)
	{
		case 0:
			[self.manager reloadFeedsFromAbsolutreStringURL:key_FeedsLeMondeAlaUne];
			break;
		case 1:
			[self.manager reloadFeedsFromAbsolutreStringURL:key_FeedsLeMondeCulture];
			break;
		case 2:
			[self.manager reloadFeedsFromAbsolutreStringURL:Key_FeedsLeMondeEconomie];
			break;
		case 3:
			[self.manager reloadFeedsFromAbsolutreStringURL:key_FeedsLeMondeLitterature];
			break;
		case 4:
			[self.manager reloadFeedsFromAbsolutreStringURL:key_FeedsLeMondePolitique];
			break;
		case 5:
			[self.manager reloadFeedsFromAbsolutreStringURL:
			 key_FeedsLeMondeInternational];
			break;
		case 6:
			[self.manager reloadFeedsFromAbsolutreStringURL:key_FeedsLeMondeSport];
			break;
		case 7:
			[self.manager reloadFeedsFromAbsolutreStringURL:Key_FeedsLeMondeTechnologies];
			break;
			
		default:
			[self.manager reloadFeedsFromAbsolutreStringURL:Key_FeedsLeMondeTechnologies];
			break;
	}
}

@end