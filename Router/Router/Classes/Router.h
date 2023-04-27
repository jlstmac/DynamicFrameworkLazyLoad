//
//  Router.h
//  DynamicLazyLoading
//
//  Created by jianglinshan on 2023/4/24.
//

#import <Foundation/Foundation.h>

struct ModuleInfo{
    char* _Nullable key;
    char* _Nullable value;
};

#define SectionName @"ModuleInfoData"
#define RegisterSection(_key_,_value_)\
__attribute__((used)) static struct ModuleInfo ModuleInfo##_key_ \
__attribute__ ((used, section ("__DATA,ModuleInfoData"))) =\
{\
    .key = #_key_,\
    .value = #_value_,\
};



NS_ASSUME_NONNULL_BEGIN

@interface Router : NSObject
+ (NSDictionary<NSString*,NSString*>*)getModulesData;

+ (NSString*)getModuleByName:(NSString*)moduleName;
@end

NS_ASSUME_NONNULL_END
