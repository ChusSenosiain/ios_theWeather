//
//  NetworkManager.h
//  JSONTheWeather
//
//  Created by María Jesús Senosiain Caamiña on 22/03/15.
//  Copyright (c) 2015 María Jesús Senosiain Caamiña. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class MJSCDays;

@interface MJSCNetworkManager : NSObject

-(void) downloadDaysFromCity:(NSString *)city
             completionBlock:(void(^)(NSArray *days, NSError *error))completion;

-(void) downloadIconFromIconName:(NSString *)iconName
                 completionBlock:(void(^)(UIImage* image, NSError *error))completion;

@end
