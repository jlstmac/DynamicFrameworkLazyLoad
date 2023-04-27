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
@property (nonatomic, copy) NSMutableSet* loadedFrameworks;

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
            
            BOOL loaded = [self didFrameworkLoaded:moduleName];
            NSLog(@"%@ is loaded:%ld",moduleName,loaded);
            
            /// 先加载动态库，可能会比较耗时，最好放子线程
            if ([FrameworkLoader loadFramework:moduleName]) {

                /// 维护已经加载过的动态库列表
                [self.loadedFrameworks addObject:moduleName];
                
                loaded = [self didFrameworkLoaded:moduleName];
                NSLog(@"%@ is loaded:%ld",moduleName,loaded);
                
                /// 动态库加载完成后，可以通过反射的形式使用类了
                _myDFService = [[NSClassFromString(@"MyDynamicFrameworkService") alloc] init];
            }
            
            
            
        }
    }
    return _myDFService;
}

- (MyDynamicFrameworkService *)myDynamicService {
    return self.myDFService;
}

- (BOOL)didFrameworkLoaded:(NSString*)frameworkName {
    return [[self loadedFrameworks] containsObject:frameworkName];
}


- (NSMutableSet *)loadedFrameworks {
    if (!_loadedFrameworks) {
        _loadedFrameworks = NSMutableSet.new;
        
        /// 可以用NSBundle的方式查看启动时已经加载的库
        /// 也可以用dlyd加载镜像完成的回调的方式来查看启动时已经加载的库：_dyld_register_func_for_add_image(&_load_launch_registed_info_for_image);
        /// 这两种方法都不能判断已动态加载过的库，所以如果这里最好维护一个列表存储 动态加载的库，来判断是否已经加载。
        [[NSBundle allFrameworks] enumerateObjectsUsingBlock:^(NSBundle * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [_loadedFrameworks addObject:[obj.bundlePath.lastPathComponent stringByDeletingPathExtension]];
        }];
    }
    return _loadedFrameworks;
}
@end
