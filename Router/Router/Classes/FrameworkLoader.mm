//
//  FrameworkLoader.m
//  FrameWorkLazyLoader
//
//  Created by jianglinshan on 2023/4/20.
//

#import "FrameworkLoader.h"
#import <dlfcn.h>

@implementation FrameworkLoader


+ (BOOL)loadFramework:(NSString *)frameworkName {
    NSString* path = [self getFrameworkPathWithName:frameworkName];
    /// dlopen加载库，RLTD_LAZY表示懒加载
    void* fopen = dlopen(path.UTF8String, RTLD_LAZY);
    
    /// dlerror获取dlopen出错原因
    char* error = dlerror();

    return error == NULL;

}

+ (NSString*)getFrameworkPathWithName:(NSString *)frameworkName {
    return [NSString stringWithFormat:@"%@/%@.framework/%@",
            [self getFrameworksPath],
            frameworkName,
            frameworkName];
}

+ (NSString*)getFrameworksPath {
    static NSString *folder;
    if (!folder) {
        folder = [NSString stringWithFormat:@"%@/Frameworks", [NSBundle mainBundle].bundlePath];
    }
    return folder;
}
@end
