//
//  PickerViewControllerTableViewController.m
//  FreewheelSampleApp
//
//  Created by Zhihui Chen on 10/28/14.
//  Copyright (c) 2014 Ooyala. All rights reserved.
//

#import "PickerViewController.h"
#import "ViewController.h"

@interface PickerViewController ()

@property (nonatomic) NSArray *titles;
@property (nonatomic) NSArray *embedCodes;

@end

@implementation PickerViewController

static NSString *cellId = @"pickerCell";

- (void)viewDidLoad {
    [super viewDidLoad];
  self.titles = [NSArray arrayWithObjects:@"Freewheel Preroll", @"Freewheel Midroll", @"Freewheel Postroll", @"Freewheel PreMidPost", @"Freewheel Overlay", @"Freewheel PreMidPost Overlay", @"Freewheel Multi Midroll", nil];
  self.embedCodes = [NSArray arrayWithObjects:@"Q5MXg2bzq0UAXXMjLIFWio_6U0Jcfk6v", @"NwcGg4bzrwxc6rqAZbYij4pWivBsX57a", @"NmcGg4bzqbeqXO_x9Rfj5IX6gwmRRrse", @"NqcGg4bzoOmMiV35ZttQDtBX1oNQBnT-", @"NucGg4bzrVrilZrMdlSA9tyg6Vty46DN",  @"NscGg4bzpO9s5rUMyW-AAfoeEA7CX6hP", @"htdnB3cDpMzXVL7fecaIWdv9rTd125As", nil];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
  [(UITableView*)self.view registerClass:[UITableViewCell class] forCellReuseIdentifier:cellId];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.titles.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];

  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
  }
  cell.textLabel.text = [self.titles objectAtIndex:indexPath.row];
  return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void) tableView: (UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath
{
  ViewController *playerController;
  // Override point for customization after application launch.
  if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
    playerController = [[ViewController alloc] initWithNibName:@"ViewController_iPhone" bundle:nil];
  } else {
    playerController = [[ViewController alloc] initWithNibName:@"ViewController_iPad" bundle:nil];
  }
  playerController.embedCode = [self.embedCodes objectAtIndex:indexPath.row];
  [self.navigationController pushViewController:playerController animated:YES];

}

@end
