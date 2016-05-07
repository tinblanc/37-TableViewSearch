//
//  Animal.h
//  TableViewSearch
//
//  Created by Tin Blanc on 5/6/16.
//  Copyright © 2016 Tin Blanc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"

@interface Animal : NSObject
@property ( nonatomic, strong) NSString* name;
@property ( nonatomic, strong) UIImage* photo;

-(instancetype) initName:(NSString*) name;
@end
