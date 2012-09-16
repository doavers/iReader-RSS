//
//  RootViewController.m
//  iReader-RSS
//
//  Created by Julien Sarazin on 11/09/12.
//  Copyright (c) 2012 Julien Sarazin. All rights reserved.
//

#import "RootViewController.h"
#import "RssItemCell.h"
#import "DetailViewController.h"

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
	
	self.navigationItem.title = @"Articles";
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
	[cell.enclosureLoader startAnimating];
	cell.enclosureLoader.hidden = NO;
	
	dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
	dispatch_async(queue,
				   ^{
					   UIImage *enclosure_rawImage = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:item.enclosure]]];
					   [cell.enclosure  setImage:enclosure_rawImage];
					   [cell.enclosureLoader stopAnimating];
					   cell.enclosureLoader.hidden = YES;
				   });

	
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
	[self performSegueWithIdentifier:@"RssItemDetail" sender:self];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if([segue.identifier isEqualToString:@"RssItemDetail"])
	{
		DetailViewController *controller = [segue destinationViewController];
		controller.rssItem = [self.rssItems objectAtIndex:self.tableView.indexPathForSelectedRow.row];
	}
}

#pragma mark - RssLoader delegate
- (void)feedTitleUpdated:(NSString *)title
{
	//self.navigationItem.title = title;
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
