//
//  MyDynamicFrameworkService.h
//  MyDynamicFramework
//
//  Created by jianglinshan on 2023/4/24.
//

#import <Foundation/Foundation.h>
#import <Router/Router.h>

NS_ASSUME_NONNULL_BEGIN

RegisterSection(MyDynamicFrameworkService ,MyDynamicFramework);

@interface MyDynamicFrameworkService : NSObject
- (void)pushToVC;
@end

NS_ASSUME_NONNULL_END
