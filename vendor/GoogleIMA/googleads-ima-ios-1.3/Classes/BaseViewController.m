//
//  BasicViewController.m
//  GettingStartedSampleApp
//
//  Created by Zhihui Chen on 10/23/14.
//
//

#import "BaseViewController.h"
#import "IMASampleViewController.h"

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
  UIViewController *playerController = [[IMASampleViewController alloc] initWithNibName:@"ViewLayout" bundle:nil];

  [self.navigationController pushViewController:playerController animated:YES];
}

@end
