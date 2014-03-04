//
//  QApi.m
//  Qlogin
//
//  Created by Eric MILLS on 3/3/14.
//  Copyright (c) 2014 westmason. All rights reserved.
//

#import "QApi.h"

@implementation QApi

//Login User
+(NSArray *)login:(NSString *)email password:(NSString *)password
{
    NSMutableURLRequest *apiRequest = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:@"http://test.1q.com/user/authenticate"]];
    [apiRequest setHTTPMethod:@"POST"];
    
    NSString *postString = [NSString stringWithFormat:@"username=%@&password=%@",email,password];
    NSData *postData = [postString dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];

    [apiRequest setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [apiRequest setValue:@"application/json;" forHTTPHeaderField:@"Accept"];
    [apiRequest setValue:@"application/json;" forHTTPHeaderField:@"Content-Type"];
    [apiRequest setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    
    // get response
    NSHTTPURLResponse *urlResponse = nil;
    NSError *error = [[NSError alloc] init];
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:apiRequest
                                                 returningResponse:&urlResponse
                                                             error:&error];
    
    NSError *theError = nil;
    NSArray *authArray = [NSJSONSerialization JSONObjectWithData:responseData
                                                         options:kNilOptions
                                                           error:&theError];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    return authArray;
}

@end
