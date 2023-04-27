//
//  MyDynamicFrameworkService.m
//  MyDynamicFramework
//
//  Created by jianglinshan on 2023/4/24.
//

#import "MyDynamicFrameworkService.h"
#import "MyViewController.h"
//#import <Router/Router.h>

//RegisterSection(MyDynamicFramework ,MyDynamicFrameworkService);

@implementation MyDynamicFrameworkService
/// 如果是懒加载的话，load方法将在加载动态库的实际加载时被调用，而不是启动时
+ (void)load {
    NSLog(@"MyDynamicFrameworkService load");

}
- (void)pushToVC {
    MyViewController* vc = MyViewController.new;
    [UIApplication.sharedApplication.keyWindow.rootViewController addChildViewController:vc];
    [UIApplication.sharedApplication.keyWindow.rootViewController.view addSubview:vc.view];
}

@end
