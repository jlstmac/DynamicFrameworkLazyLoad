//
//  ViewController.m
//  DynamicLazyLoading
//
//  Created by jianglinshan on 2023/4/24.
//

#import "ViewController.h"
#import "RouterAdapter.h"
#import <MyDynamicFramework/MyDynamicFrameworkService.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addChildViewController:UINavigationController.new];
    
    CGSize windowSize = self.view.frame.size;
    UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake((windowSize.width - 250)/2.0, (windowSize.height - 50)/2.0, 250, 50)];
    [button setTitle:@"点击加载动态库并跳转" forState:UIControlStateNormal];
    [button setBackgroundColor:UIColor.grayColor];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    // Do any additional setup after loading the view.
}

- (void)buttonClick {
    [[[RouterAdapter sharedInstance] myDynamicService] pushToVC];
}

@end
