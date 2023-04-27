//
//  Router.m
//  DynamicLazyLoading
//
//  Created by jianglinshan on 2023/4/24.
//

#import "Router.h"
#include <dlfcn.h>
#include <mach-o/getsect.h>
#import "FrameworkLoader.h"
#include <mach-o/dyld.h>
@implementation Router

static NSDictionary<NSString*,NSString*>* ReadSectionConfiguration(const char *section)
{
    NSMutableDictionary *configs = [NSMutableDictionary dictionary];
    
    Dl_info info;
    dladdr((__bridge void *)NSClassFromString(@"ViewController"), &info);
    
#ifndef __LP64__ ///32位，结构体定义不一样，需要单独读取
    const struct mach_header *mhp = (struct mach_header*)info.dli_fbase;
    unsigned long size = 0;
    uint32_t *memory = (uint32_t*)getsectiondata(mhp, "__DATA", section, &size);
#else /* defined(__LP64__) */ ///64位
    const struct mach_header_64 *mhp = (struct mach_header_64*)info.dli_fbase;
    unsigned long size = 0;
    uint64_t *memory = (uint64_t*)getsectiondata(mhp, "__DATA", section, &size);
#endif /* defined(__LP64__) */
    
    unsigned long schemeCounter = size/sizeof(struct ModuleInfo);
    struct ModuleInfo *items = (struct ModuleInfo*)memory;
    for(int idx = 0; idx < schemeCounter; ++idx){
        NSString * key = [NSString stringWithUTF8String:items[idx].key];
        NSString * value = [NSString stringWithUTF8String:items[idx].value];
        [configs setObject:value forKey:key];
    }
    
    return configs;
}

+ (NSDictionary<NSString*,NSString*>*)getModulesData {
    return ReadSectionConfiguration(SectionName.UTF8String);
}

+ (NSString*)getModuleByName:(NSString*)moduleName {
    return nil;
}

@end
