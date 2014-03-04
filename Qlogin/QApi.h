//
//  QApi.h
//  Qlogin
//
//  Created by Eric MILLS on 3/3/14.
//  Copyright (c) 2014 westmason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QApi : NSObject
{
    
}

+(NSArray *)login:(NSString *)email password:(NSString *)password;

@end
