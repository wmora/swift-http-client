//
//  ViewController.m
//  DemoAppObjC
//
//  Created by William Mora on 2018-02-01.
//  Copyright © 2018 William Mora. All rights reserved.
//

#import "ViewController.h"
#import <HTTPClient/HTTPClient-Swift.h>

@interface ViewController ()

@property HTTPClient *httpClient;
@property (weak, nonatomic) IBOutlet UILabel *responseLabel;

@end

@implementation ViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    self.httpClient = [[HTTPClient alloc] init];
    self.httpClient.baseURL = @"https://jsonplaceholder.typicode.com";
}

-(IBAction)getButtonDidTouchUpInside:(id)sender
{
    [self.httpClient getWithUrl:@"/todos/1" params:@{} callback:^(HTTPResponse * _Nonnull response) {
        [self updateLabelWithMethod:@"GET" response:response];
    }];
}

-(IBAction)putButtonDidTouchUpInside:(id)sender
{
}

-(IBAction)postButtonDidTouchUpInside:(id)sender
{
}

-(void)updateLabelWithMethod:(NSString *)method response:(HTTPResponse *)response
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.responseLabel.text = [NSString stringWithFormat:@"%@ request complete:\nStatus code: %ld\nResponse data: %@", method, response.statusCode, response.data];
    });
}

@end
