//
//  RouterAdapter.h
//  DynamicLazyLoading
//
//  Created by jianglinshan on 2023/4/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class MyDynamicFrameworkService;
@interface RouterAdapter : NSObject
@property (nonatomic, copy, readonly) NSDictionary<NSString*, NSString*>* moduleInfos;

+ (instancetype)sharedInstance;

- (MyDynamicFrameworkService*)myDynamicService;

@end

NS_ASSUME_NONNULL_END
