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
	self.selector = [RSSChannelSelector sharedRSSChannel];
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
			[self.selector setCurrentChannelFromString:key_LeMondeAlaUne];
			break;
		case 1:
			[self.selector setCurrentChannelFromString:key_LeMondeCulture];
			break;
		case 2:
			[self.selector setCurrentChannelFromString:Key_LeMondeEconomie];
			break;
		case 3:
			[self.selector setCurrentChannelFromString:key_LeMondeLitterature];
			break;
		case 4:
			[self.selector setCurrentChannelFromString:key_LeMondePolitique];
			break;
		case 5:
			[self.selector setCurrentChannelFromString:key_LeMondeInternational];
			break;
		case 6:
			[self.selector setCurrentChannelFromString:key_LeMondeSport];
			break;
		case 7:
			[self.selector setCurrentChannelFromString:Key_LeMondeTechnologies];
			break;
		default:
			break;
	}
}

@end