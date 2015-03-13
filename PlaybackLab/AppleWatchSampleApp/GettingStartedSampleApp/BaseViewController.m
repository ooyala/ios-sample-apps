//
//  BasicViewController.m
//  GettingStartedSampleApp
//
//  Created by Zhihui Chen on 10/23/14.
//
//

#import "BaseViewController.h"
#import "ViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onCreateVideo:(id)sender {
  UIViewController *playerController;
  // Override point for customization after application launch.
  if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
    playerController = [[ViewController alloc] initWithNibName:@"ViewController_iPhone" bundle:nil];
  } else {
    playerController = [[ViewController alloc] initWithNibName:@"ViewController_iPad" bundle:nil];
  }

  [self.navigationController pushViewController:playerController animated:YES];
}

@end
