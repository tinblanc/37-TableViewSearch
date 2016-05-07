//
//  DetailVC.m
//  TableViewSearch
//
//  Created by Tin Blanc on 5/6/16.
//  Copyright © 2016 Tin Blanc. All rights reserved.
//

#import "DetailVC.h"


@interface DetailVC ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *lblName;


@end

@implementation DetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.lblName.text = self.animal.name;
    self.imageView.image = self.animal.photo;
    
    
}




@end
