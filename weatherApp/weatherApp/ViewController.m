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
@property (nonatomic, strong) NSString *currentTemperature;
@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)getCurrentTemperature {
    NSURLSession *URLSession = [NSURLSession sharedSession];
    NSURL *weatherURL = [NSURL URLWithString:@"http://api.openweathermap.org/data/2.5/weather?q=\Detroit&APPID=cde859005a79f66e60394e5e2c72546e"];

    NSURLSessionDataTask *dataTask = [URLSession dataTaskWithURL:weatherURL completionHandler:^(NSData *data,
                                                                                                NSURLResponse *response,
                                                                                                NSError *error) {
        if (error == nil) {
            NSDictionary *dictionaryFromJSON = [NSJSONSerialization JSONObjectWithData:data
                                                                               options:0
                                                                                 error:nil];
            
            NSDictionary *weatherDictionary = [dictionaryFromJSON objectForKey:@"weather"];
            NSLog(@"%@", [dictionaryFromJSON objectForKey:@"weather"]);
            NSLog(@"%@", weatherDictionary);
            
            NSString *weatherDescription = [weatherDictionary valueForKey:@"description"];
            self.weatherLabel.text = weatherDescription;
            
            
            NSLog(@"%@", self.weatherLabel.text);
            
        }
    }];
    
    [dataTask resume];
}

- (IBAction)showWeather {
    [self getCurrentTemperature];
}

@end
