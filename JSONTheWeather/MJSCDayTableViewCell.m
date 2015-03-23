//
//  MJSCDayTableViewCell.m
//  JSONTheWeather
//
//  Created by María Jesús Senosiain Caamiña on 23/03/15.
//  Copyright (c) 2015 María Jesús Senosiain Caamiña. All rights reserved.
//

#import "MJSCDayTableViewCell.h"

@implementation MJSCDayTableViewCell

+(CGFloat) height {
    return 60;
}


+(NSString*) cellId {
    return [[self class] description];
}




@end
