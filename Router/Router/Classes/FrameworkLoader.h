//
//  FrameworkLoader.h
//  FrameWorkLazyLoader
//
//  Created by jianglinshan on 2023/4/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FrameworkLoader : NSObject
+ (BOOL)loadFramework:(NSString *)frameworkName;

@end

NS_ASSUME_NONNULL_END
