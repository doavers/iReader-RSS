//
//  RootViewController.m
//  iReader-RSS
//
//  Created by Julien Sarazin on 11/09/12.
//  Copyright (c) 2012 Julien Sarazin. All rights reserved.
//

#import "RootViewController.h"
#import "RssItemCell.h"

@interface RootViewController ()
@end

@implementation RootViewController

- (void)fetchRssItems
{
	if(self.rssLoader == nil)
	{
		self.rssLoader = [[RssLoader alloc] init];
		self.rssLoader.delegate = self;
	}
	NSURL *url = [[NSURL alloc] initWithString:@"http://www.lemonde.fr/rss/tag/technologies.xml"];
	[self.rssLoader loadWithURL:url];
}
#pragma mark TableViewController life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.navigationItem.title = @"FooBar!";
	self.rssItems = nil;
	self.rssLoader = nil;
	
#warning TODO: Test if the internet connection is reachable.
	
	self.connected = YES;
	self.rssItems = [[NSMutableArray alloc] init];
	[self performSelector:@selector(fetchRssItems) withObject:nil];
	[self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

 - (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if (self.rssLoader.loaded)
		return self.rssItems.count;
	
	return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (self.rssLoader.loaded == NO)
	{
		NSLog(@"Prout");
		return [self getLoadingTableCellWithTableView:tableView];
	}
	
    RssItemCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"RssItemCell" owner:self options:nil] objectAtIndex:0];
        
	RssItem* item = [self.rssItems objectAtIndex: indexPath.row];
        
	cell.title.text = item.title;
	cell.description.text = item.description;
	cell.enclosure =  [[UIImageView alloc] initWithImage:[UIImage imageWithData:item.enclosure]];
    return cell;
}

- (UITableViewCell *)getLoadingTableCellWithTableView:(UITableView *)tableView
{
	NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"LoadingCell" owner:self options:nil];
    UITableViewCell *cell = [topLevelObjects lastObject];
	
	cell.textLabel.text = @"Loading...";
	
	UIActivityIndicatorView* activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
	[activity startAnimating];
	[cell setAccessoryView: activity];
	
    return cell;
}

#pragma mark - Table view orientation
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

#pragma mark - RssLoader delegate
- (void)feedTitleUpdated:(NSString *)title
{
	self.navigationItem.title = title;
}

- (void)rssItemsUpdated:(NSMutableArray *)items
{
	self.rssItems = items;
	[self.tableView reloadData];
}

- (void)updateFailedWithError:(NSError *)error
{
	[[[UIAlertView alloc] initWithTitle:@"Error" message:[error description] delegate:nil cancelButtonTitle:@"Ok"otherButtonTitles:nil] show];
}

@end
