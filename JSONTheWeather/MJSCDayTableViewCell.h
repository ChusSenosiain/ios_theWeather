//
//  MJSCDayTableViewCell.h
//  JSONTheWeather
//
//  Created by María Jesús Senosiain Caamiña on 23/03/15.
//  Copyright (c) 2015 María Jesús Senosiain Caamiña. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MJSCDayTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *day;
@property (weak, nonatomic) IBOutlet UIImageView *icon;

+(CGFloat) height;
+(NSString*) cellId;

@end
