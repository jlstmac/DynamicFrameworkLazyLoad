//
//  MyViewController.m
//  MyDynamicFramework
//
//  Created by jianglinshan on 2023/4/24.
//

#import "MyViewController.h"

@interface MyViewController ()

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    // Do any additional setup after loading the view.
    UILabel* label = UILabel.new;
    label.frame = CGRectMake(0, 200, UIScreen.mainScreen.bounds.size.width, 100);
    label.text = @"MyDynamicFramework加载成功";
    label.font = [UIFont systemFontOfSize:20];
    label.textColor = UIColor.redColor;
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
