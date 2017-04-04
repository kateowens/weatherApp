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

//static NSString *const kAPIKey = @"ac7e7e282f1cd5de";

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getCurrentTemperature {
    NSURLSession *URLSession = [NSURLSession sharedSession];
    NSURL *weatherURL = [NSURL URLWithString:@"http://api.wunderground.com/api/ac7e7e282f1cd5de/conditions/q/MI/Detroit.json"];

    NSURLSessionDataTask *dataTask = [URLSession dataTaskWithURL:weatherURL completionHandler:^(NSData *data,
                                                                                                NSURLResponse *response,
                                                                                                NSError *error) {
        if (error == nil) {
            NSDictionary *dictionaryFromJSON = [NSJSONSerialization JSONObjectWithData:data
                                                                               options:0
                                                                                 error:nil];
            
            NSLog(@"%@", [dictionaryFromJSON objectForKey:@"weather"]);
            
            self.currentTemperature = [dictionaryFromJSON valueForKey:@"weather"];
        }
    }];
    
    [dataTask resume];
}

- (IBAction)showWeather {
    [self getCurrentTemperature];
    self.weatherLabel.text = self.currentTemperature;
}

@end
