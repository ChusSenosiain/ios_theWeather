//
//  MJSCDay.m
//  JSONTheWeather
//
//  Created by María Jesús Senosiain Caamiña on 20/03/15.
//  Copyright (c) 2015 María Jesús Senosiain Caamiña. All rights reserved.
//

#import "MJSCDay.h"

static const NSString *k_SERVER_IMAGE_URL = @"http://openweathermap.org/img/w/";

@interface MJSCDay()

@end


@implementation MJSCDay


-(id) initWithJSONDictionary:(NSDictionary *) dictionary {
    
    /*
     "dt": 1426870800,
     "temp": {
     "day": 14.24,
     "min": 11.73,
     "max": 14.24,
     "night": 11.73,
     "eve": 12.07,
     "morn": 14.24
     },
     "pressure": 773.77,
     "humidity": 100,
     "weather": [
     {
     "id": 501,
     "main": "Rain",
     "description": "lluvia moderada",
     "icon": "10d"
     }
     ],
     "speed": 1.22,
     "deg": 294,
     "clouds": 92,
     "rain": 8.49
     */
    
    if (self = [super init]) {
        
        _humidity = [dictionary objectForKey:@"humidity"];
        double dateInMillis = [[dictionary objectForKey:@"dt"] doubleValue];
         _day = [NSDate dateWithTimeIntervalSince1970:dateInMillis];
        
        NSDictionary *temps = [dictionary objectForKey:@"temp"];
        _tempMin = [temps objectForKey:@"min"];
        _tempMax = [temps objectForKey:@"max"];
        
        NSArray *weather = [dictionary objectForKey:@"weather"];
        NSDictionary *weatherDic = [weather objectAtIndex:0];
        _desc = [weatherDic objectForKey:@"description"];
        
        _iconURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@%@", k_SERVER_IMAGE_URL, [weatherDic objectForKey:@"icon"], @".png"]];

    }
    
    return self;
    
    
}


@end
