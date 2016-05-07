//
//  TableViewController.m
//  TableViewSearch
//
//  Created by Tin Blanc on 5/6/16.
//  Copyright © 2016 Tin Blanc. All rights reserved.
//

#import "TableViewController.h"
#import "Animal.h"
#import "DetailVC.h"

@interface TableViewController () <UITableViewDelegate,UITableViewDataSource, UISearchResultsUpdating, UISearchBarDelegate>
@property ( nonatomic, strong) UISearchController *searchController;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) NSDictionary* dic;
@end

@implementation TableViewController{
    NSDictionary *dicAnimals;
    NSArray* arrayKeys; // mảng này lưu tất cả các key trong dicAnimals

    NSMutableArray* filteredNames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    filteredNames = [[NSMutableArray alloc] init];
    
    dicAnimals = @{@"B" : @[@"Bear",@"Black Swan", @"Buffalo"],
                   @"C" : @[@"Camel", @"Cockatoo"],
                   @"D" : @[@"Dog", @"Donkey"],
                   @"E" : @[@"Emu"],
                   @"G" : @[@"Giraffe", @"Greater Rhea"],
                   @"H" : @[@"Hippopotamus", @"Horse"],
                   @"K" : @[@"Koala"],
                   @"L" : @[@"Lion", @"Llama"],
                   @"M" : @[@"Manatus", @"Meerkat"],
                   @"P" : @[@"Panda", @"Peacock", @"Pig", @"Platypus", @"Polar Bear"],
                   @"R" : @[@"Rhinoceros"],
                   @"S" : @[@"Seagull"],
                   @"T" : @[@"Tasmania Devil"],
                   @"W" : @[@"Whale", @"Whale Shark", @"Wombat"]};
    
    arrayKeys = [dicAnimals allKeys];
    

    arrayKeys = [arrayKeys sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    

    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    [self.searchController.searchBar sizeToFit];
    self.tableView.tableHeaderView = self.searchController.searchBar; // Cho search bar lên đầu tableView
    
    self.searchController.searchResultsUpdater = self;
    
    self.searchController.dimsBackgroundDuringPresentation = false; // cho thao tác màn hình khi tap vào search bar
    
    self.definesPresentationContext = YES;

    
    
}


-(NSString*) getImageFileNames: (NSString*) animal {
    NSString* imageFileName = animal.lowercaseString;
    imageFileName = [imageFileName stringByReplacingOccurrencesOfString:@" " withString:@"_"]; // thay thế ký tự " " bằng ký tự "_"
    imageFileName = [imageFileName stringByAppendingString:@".jpg"]; // thêm chuỗi .jpg vào imageFileName
    return imageFileName;
}


#pragma mark - Table view data source


- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    if (self.searchController.searchBar.text.length > 0) {
        return nil;
    }
    
    return arrayKeys;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return arrayKeys[section];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (self.searchController.searchBar.text.length > 0 ) {
        if (filteredNames.count > 0) {
            return 1;
        }else {
            return 0;
        }
    }

    return arrayKeys.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (self.searchController.searchBar.text.length > 0 ) {
        if (filteredNames.count > 0) {
            return [filteredNames count];
        }else {
            return 0;
        }
    }
    
    
    NSString * key = arrayKeys[section]; // lấy key tại vị trí section
    NSArray* arrayAnimalsInSection = dicAnimals[key];
    return arrayAnimalsInSection.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    
    if (self.searchController.searchBar.text.length > 0 && filteredNames.count > 0) {
        
        // Thêm màu cho từ khóa tìm kiếm
        NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:filteredNames[indexPath.row]];
        NSRange range = [filteredNames[indexPath.row] rangeOfString:self.searchController.searchBar.text options:NSCaseInsensitiveSearch];
        [attributedText addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
        
        
        cell.textLabel.attributedText = attributedText;
        NSString *animal = filteredNames[indexPath.row];
        cell.imageView.image = [UIImage imageNamed:[self getImageFileNames:animal]];
        
        return cell;
    }
    
    NSString* key = arrayKeys[indexPath.section];
    NSArray* arrayAnimalsInSection = dicAnimals[key];
    NSString * animal = arrayAnimalsInSection[indexPath.row];
    cell.textLabel.text = animal;
    cell.imageView.image = [UIImage imageNamed:[self getImageFileNames:animal]];

    
    return cell;
}


-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    DetailVC* detail = (DetailVC*) segue.destinationViewController;
    NSIndexPath* selectedIndexPath = [self.tableView indexPathForSelectedRow];
    
    
    NSString* key = arrayKeys[selectedIndexPath.section];
    NSArray* arrayValues = [dicAnimals objectForKey:key];

    
    Animal* animal = [[Animal alloc] initName:arrayValues[selectedIndexPath.row]];
    
    detail.animal = animal;

}



#pragma mark - Search Results Updating

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    [filteredNames removeAllObjects]; // mỗi lần hàm được gọi remove hết đối tượng
    
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"self contains [c] %@",self.searchController.searchBar.text];
    
    for (NSString * key in arrayKeys) {
        NSArray* array = dicAnimals[key];
        NSArray* matches = [array filteredArrayUsingPredicate:predicate];
        [filteredNames addObjectsFromArray:matches];
    }
    
    [self.tableView reloadData];
   
}










@end
