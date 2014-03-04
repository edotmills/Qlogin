//
//  ViewController.m
//  Qlogin
//
//  Created by Eric MILLS on 3/3/14.
//  Copyright (c) 2014 westmason. All rights reserved.
//

#import "ViewController.h"
#import "QApi.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"Q::%@",[QApi login:@"skinnymills@gmail.com" password:@"jaXson77"]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
