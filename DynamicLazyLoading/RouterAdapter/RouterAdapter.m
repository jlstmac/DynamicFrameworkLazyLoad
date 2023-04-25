//
//  RouterAdapter.m
//  DynamicLazyLoading
//
//  Created by jianglinshan on 2023/4/24.
//

#import "RouterAdapter.h"
#import <Router/Router.h>
#import <Router/FrameworkLoader.h>
//#import "Router.h"

//RegisterSection(RouterAdapter , RouterAdapter)
@interface RouterAdapter ()
@property (nonatomic, strong) MyDynamicFrameworkService* myDFService;
@end

@implementation RouterAdapter
- (instancetype)init {
    self = [super init];
    if (self) {
        _moduleInfos = [Router getModulesData];
    }
    return self;
}

+ (instancetype)sharedInstance {
    static RouterAdapter* adapter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        adapter = RouterAdapter.new;
    });
    return adapter;
}

- (MyDynamicFrameworkService *)myDFService {
    if (!_myDFService) {
        NSString* moduleName = [self.moduleInfos objectForKey:@"MyDynamicFrameworkService"];
        if (moduleName) {
            [FrameworkLoader loadFramework:moduleName];
            _myDFService = [[NSClassFromString(@"MyDynamicFrameworkService") alloc] init];
        }
    }
    return _myDFService;
}

- (MyDynamicFrameworkService *)myDynamicService {
    return self.myDFService;
}
@end
