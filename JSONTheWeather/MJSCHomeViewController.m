//
//  MJSCHomeViewController.m
//  JSONTheWeather
//
//  Created by María Jesús Senosiain Caamiña on 20/03/15.
//  Copyright (c) 2015 María Jesús Senosiain Caamiña. All rights reserved.
//

#import "MJSCHomeViewController.h"
#import "MJSCDayTableViewCell.h"
#import "MJSCNetworkManager.h"
#import "MJSCDay.h"

@interface MJSCHomeViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UITextField *city;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, copy) NSArray *days;
@property (nonatomic, strong) MJSCNetworkManager *networkManager;

- (IBAction)btnSearchWeatherPush:(id)sender;

@end



@implementation MJSCHomeViewController

# pragma mark - view life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureTableView];
    
    _networkManager = [[MJSCNetworkManager alloc] init];
    
    self.activityIndicator.hidden = YES;
    
    self.title = @"El tiempo :)";
    
    // Para que no deje el espacio entre la tabla y la barra de navegación
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)configureTableView {
    
     // Registro la celda personalizada
    [self registerNibs];
    
    self.table.dataSource = self;
    self.table.delegate = self;
    self.table.alpha = 0;
    self.table.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
}

# pragma mark - actions

- (IBAction)btnSearchWeatherPush:(id)sender {
    
    // Oculto el teclado
    [self.view endEditing:YES];
    
    self.activityIndicator.hidden = NO;
    [self.activityIndicator startAnimating];
    
    [self.networkManager downloadDaysFromCity:self.city.text completionBlock:^(NSArray *days, NSError *error) {
        
        [self.activityIndicator stopAnimating];
        
        
        // TODO: meter en la tabla
        if (!error) {
            self.days = days;
            
            
            [UIView animateWithDuration:0.5 animations:^{
                self.table.alpha = 1;
                self.activityIndicator.alpha = 0;
                self.activityIndicator.hidden = YES;
            }];
            
            
            [self.table reloadData];
            
        } else {
            
        }
        
    }];
}

#pragma mark - Table View DataSource & Delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.days count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Obtengo el día
    MJSCDay *day = [self.days objectAtIndex:indexPath.row];
    
    // Crear la celda
    MJSCDayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[MJSCDayTableViewCell cellId] forIndexPath:indexPath];
    
    NSString *dateString = [NSDateFormatter localizedStringFromDate:day.day
                                                          dateStyle:NSDateFormatterShortStyle
                                                          timeStyle:NSDateFormatterFullStyle];

    cell.day.text = dateString;
    
    [self.networkManager downloadIconFromIconName:day.icon completionBlock:^(UIImage *image, NSError *error) {
        if (!error) {
            cell.icon.image = image;
        }
    }];
    
    /* Con celda sin personalizar
    // Configuro la celda
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"celda_dia"];
    
    // Muestro el día en la celda
    cell.textLabel.text = day.desc;
    
     */
    return cell;
    
}

// Darle un alto máximo a la celda
-(CGFloat) tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [MJSCDayTableViewCell height];
}



#pragma mark - Utils

-(void) registerNibs {
    UINib *nib = [UINib nibWithNibName:@"MJSCDayTableViewCell" bundle:nil];
    [self.table registerNib:nib forCellReuseIdentifier:[MJSCDayTableViewCell cellId]];
}




@end
