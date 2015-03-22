//
//  NetworkManager.m
//  JSONTheWeather
//
//  Created by María Jesús Senosiain Caamiña on 22/03/15.
//  Copyright (c) 2015 María Jesús Senosiain Caamiña. All rights reserved.
//

#import "MJSCNetworkManager.h"
#import "MJSCDay.h"

#define CityWeatherURL(city) ([NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/forecast/daily?q=%@&units=metric&lang=sp", city])

@implementation MJSCNetworkManager

-(void)downloadDaysFromCity:(NSString *)city
            completionBlock:(void(^)(NSArray *days, NSError *error))completion {
    
   
    NSURL *url = [NSURL URLWithString:CityWeatherURL(city)];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (data) {
            NSError *jSONError = nil;
            
            NSDictionary *root = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jSONError];
            NSArray *days = [self loadDaysFromArray:[root objectForKey:@"list"]];
            
            completion(days, jSONError);
            
        } else {
            //TODO Crear un NSError con datos
            NSError *errorNoData = [[NSError alloc] init];
            completion(nil, errorNoData);
            NSLog(@"ERROR in request, no data returned");
        }
        
    }];
}



-(NSArray *)loadDaysFromArray:(NSArray *)array {
    
    NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
    
    for (id object in array) {
        MJSCDay *day = [[MJSCDay alloc] initWithJSONDictionary:object];
        
        if (day) {
            [mutableArray addObject:day];
        }
    }
    
    return mutableArray;
}



@end
