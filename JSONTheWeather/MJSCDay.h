//
//  MJSCDay.h
//  JSONTheWeather
//
//  Created by María Jesús Senosiain Caamiña on 20/03/15.
//  Copyright (c) 2015 María Jesús Senosiain Caamiña. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MJSCDay : NSObject

@property(nonatomic, strong) NSDate *day;
@property(nonatomic, strong) NSNumber *tempMin;
@property(nonatomic, strong) NSNumber *tempMax;
@property(nonatomic, strong) NSNumber *humidity;
@property(nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *icon;


-(id) initWithJSONDictionary:(NSDictionary *) dictionary;


@end
