//
//  Animal.m
//  TableViewSearch
//
//  Created by Tin Blanc on 5/6/16.
//  Copyright © 2016 Tin Blanc. All rights reserved.
//

#import "Animal.h"

@implementation Animal


-(instancetype) initName:(NSString *)name {
    if (self = [super init]) {
        self.name = name;
        
        NSString* imageFileName = name.lowercaseString;
        imageFileName = [imageFileName stringByReplacingOccurrencesOfString:@" " withString:@"_"]; // thay thế ký tự " " bằng ký tự "_"
        imageFileName = [imageFileName stringByAppendingString:@".jpg"];
        
        self.photo = [UIImage imageNamed:imageFileName];
    }
    return self;
}
@end
