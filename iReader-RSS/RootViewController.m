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
- (void)refresh;
@end

@implementation RootViewController

- (void)refresh
{
	self.refreshControl.attributedTitle =[[NSAttributedString alloc] initWithString:@"Refreshing"];
	[self.manager loadFeeds];
}

#pragma mark - TableViewController life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
	self.navigationItem.title = @"Articles";

#pragma mark - UIRefreshControl
	/*
	 * UIREFRESHCONTROL
	 */
	UIRefreshControl *refreshController = [[UIRefreshControl alloc]init];
	refreshController.attributedTitle =[[NSAttributedString alloc] initWithString:@"Pull To Refresh"];
	[refreshController addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
	refreshController.tintColor = [UIColor blackColor];
	self.refreshControl = refreshController;
	
	self.manager = [RssManager sharedRssManager];
	self.manager.delegate = self;
	
#warning TODO: Test if the internet connection is really reachable.	
	self.connected = YES;
	[self.manager reloadFeedsFromAbsolutreStringURL:Key_FeedsLeMondeTechnologies];
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
	NSInteger nbRow = [[self.manager.feeds objectForKey:self.manager.currentChannel] count];
	return MAX(1, nbRow);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (self.manager.loader.loaded == NO)
		return [self getLoadingTableCellWithTableView:tableView];
	
	RssItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RssItemCell"];
 
	RssItem *feed = [[self.manager.feeds objectForKey:self.manager.currentChannel] objectAtIndex:indexPath.row];
	
	cell.title.text = feed.title;
	cell.description.text = feed.description;
	[cell.enclosure setImage:[UIImage imageNamed:@"placeholder_rss.png"]];
	
	dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
	dispatch_async(queue,
				   ^{
					   UIImage *image = [[UIImage alloc] initWithData:feed.enclosure];
					   [cell.enclosure  setImage:image];
					   [cell setNeedsLayout];
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
	[self performSegueWithIdentifier:@"Feeds" sender:self];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if([segue.identifier isEqualToString:@"Feeds"])
	{
		DetailViewController *controller = [segue destinationViewController];
		controller.feed = [[self.manager.feeds objectForKey:self.manager.currentChannel]objectAtIndex:self.tableView.indexPathForSelectedRow.row];
	}
}

#pragma mark - RssManager delegates
- (void)feedsLoadedForChannel:(NSString *)channel
{
	NSLog(@"Feeds received.");
	[self.tableView reloadData];
	[self.refreshControl endRefreshing];
}

- (void)feedsLoadFailedWithError:(NSError *)error
{
	NSString *errorMessage = [NSString stringWithFormat:@"Une erreur s'est produite lors du chargement de votre flux RSS: %@\n", error.localizedDescription];
	
	UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Problème de chargement" message:errorMessage delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	
	[alert show];
}


#pragma mark - UIAlertView delegates
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	NSLog(@"User notified");
	[self.refreshControl endRefreshing];
}



@end
