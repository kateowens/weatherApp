//
//  ViewController.m
//  weatherApp
//
//  Created by Katherine Owens on 4/4/17.
//  Copyright © 2017 Katherine Owens. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) IBOutlet UILabel *weatherLabel;
@property (strong, nonatomic) IBOutlet UILabel *minAndMaxTemperatureLabel;
@property (nonatomic, strong) IBOutlet UILabel *humidityLabel;
@property (nonatomic, strong) IBOutlet UIImageView *weatherImage;
@property (nonatomic, strong) NSString *currentTemperature;

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)getCurrentTemperature {
    NSURLSession *URLSession = [NSURLSession sharedSession];

    NSURL *weatherURL = [NSURL URLWithString:@"http://api.openweathermap.org/data/2.5/weather?q=Detroit&units=imperial&APPID=cde859005a79f66e60394e5e2c72546e"];

    NSURLSessionDataTask *dataTask = [URLSession dataTaskWithURL:weatherURL completionHandler:^(NSData *data,
                                                                                                NSURLResponse *response,
                                                                                                NSError *error) {
        if (error == nil) {
            NSDictionary *dictionaryFromJSON = [NSJSONSerialization JSONObjectWithData:data
                                                                               options:0
                                                                                 error:nil];
            
            NSDictionary *weatherDictionary = [dictionaryFromJSON objectForKey:@"weather"];
            NSDictionary *temperatureDictionary = [dictionaryFromJSON objectForKey:@"main"];
            
            NSArray *weatherDescription = [weatherDictionary valueForKey:@"description"];
            NSString *temperature = [temperatureDictionary valueForKey:@"temp"];
            NSString *minTemperature = [temperatureDictionary valueForKey:@"temp_min"];
            NSString *maxTemperature = [temperatureDictionary valueForKey:@"temp_max"];
            NSString *humidity = [temperatureDictionary valueForKey:@"humidity"];

            
            self.weatherLabel.text = [weatherDescription objectAtIndex:0];
            NSLog(@"%@", temperatureDictionary);
            NSLog(@"%@", temperature);
            
            NSString *minAndMaxTempString = [NSString stringWithFormat: @"Today's low: %@, today's high: %@", (minTemperature), (maxTemperature)];
            
            
            NSLog(@"%@", minAndMaxTempString);
            self.minAndMaxTemperatureLabel.text = minAndMaxTempString;

            
        }
    }];
    
    [dataTask resume];
}

- (void)getTenDayForecast {
    
}



- (IBAction)showWeather {
    [self getCurrentTemperature];
}

@end
