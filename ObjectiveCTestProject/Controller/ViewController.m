//
//  ViewController.m
//  ObjectiveCTestProject
//
//  Created by Angelina on 04.01.2021.
//

#import "ViewController.h"
#import "CustomTableViewCell.h"
#import "NSMutableAttributedString+Color.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *namesArray;
    NSMutableArray *dateArray;
    NSMutableArray *applicationStatusArray;
    NSMutableArray *creditAmountArray;
    NSMutableArray *commentsArray;
    BOOL isSearching;
}
@property (strong, nonatomic) CustomTableViewCell *customCell;

@end

@implementation ViewController
@synthesize searchBar;
@synthesize searchBarController;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    namesArray = [@[@"Иванов Иван Иванович",@"Романенко Антонина Николаевна",@"Павлова Анна Константиновна",@"Киселев Иван Андреевич",@"Карачаев Дмитрий Анатольевич",@"Саркисян Давид Араратович", @"Степанов Николай Владимирович",] mutableCopy];
    dateArray = [@[@"04/07/2020",@"07/07/2020",@"15/03/2020",@"17/01/2020",@"10/10/2020",@"11/05/2020", @"20/03/2020",] mutableCopy];
    applicationStatusArray = [@[@"Одобрена",@"Не одобрена",@"На рассмотрении",@"Одобрена",@"На рассмотрении",@"Одобрена", @"Не одобрена",] mutableCopy];
    creditAmountArray = [@[@"30000.00",@"80000.00",@"170000.00",@"50000.00",@"120000.00",@"75000.00", @"200000.00",] mutableCopy];
    commentsArray = [@[@"",@"Позвонить в феврале.",@"Запрошена справка о доходах.",@"",@"Ожидание ответа от банка.",@"", @"Отказ.",] mutableCopy];
    
    searchBar.enablesReturnKeyAutomatically = false;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    CustomTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cellIdentifier"];
    
    self.tableView.allowsSelection = false;
    
    cell.fullNameLabel.text = namesArray[indexPath.row];
    cell.dateLabel.text = dateArray[indexPath.row];
    cell.applicationLabel.text = applicationStatusArray[indexPath.row];
    cell.creditLabel.text = creditAmountArray[indexPath.row];
    cell.commentLabel.text = @"Комментарий:";
    cell.commentLabel.hidden = false;
    cell.comment.text = commentsArray[indexPath.row];
    
    if ([commentsArray[indexPath.row] isEqual: @""]) {
        cell.commentLabel.hidden = true;
    }
    
    if ([applicationStatusArray[indexPath.row]  isEqual: @"Одобрена"]) {
        cell.indicatorImage.image = [UIImage imageNamed:@"green.png"];
    } else if ([applicationStatusArray[indexPath.row]  isEqual: @"На рассмотрении"]) {
        cell.indicatorImage.image = [UIImage imageNamed:@"yellow.png"];
    } else {
        cell.indicatorImage.image = [UIImage imageNamed:@"red.png"];
    }
    
    if (isSearching) {
        NSString *strColor = [filteredContentList objectAtIndex:indexPath.row];
        NSString *strName = searchBar.text;


        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:strColor];
        [string setColorForText: strName withColor:[UIColor redColor]];
        cell.comment.attributedText = string;

    }
    else {
        NSString *strColor = commentsArray[indexPath.row];
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:strColor];
        cell.comment.attributedText = string;
    }
    
    return  cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (isSearching) {
        return [filteredContentList count];
    }
    else {
        return [commentsArray count];
    }
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 360;
}

- (void)searchTableList {
    filteredContentList = [[NSMutableArray alloc] init];

    NSString *searchString = searchBar.text;
    NSMutableArray *rows = [NSMutableArray array];

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self contains[cd] %@",searchString];
    rows = [NSMutableArray arrayWithArray:[commentsArray filteredArrayUsingPredicate: predicate]];

    NSLog(@"rows = %@",rows);

    for (NSString *tempStr in rows) {
        [filteredContentList addObject:tempStr];
        NSUInteger index = [commentsArray indexOfObject:tempStr];
        NSLog(@"index = = %lu",(unsigned long)index);
    }

}

#pragma mark - Search Implementation

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    isSearching = YES;

}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSLog(@"Text change - %d",isSearching);

    //Remove all objects first.
    [filteredContentList removeAllObjects];

    if([searchText length] != 0) {
        isSearching = YES;
        [self searchTableList];
    }
    else {
        isSearching = NO;
    }
    [self.tableView reloadData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"Cancel clicked");

}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"Search Clicked");
    [self.searchBar resignFirstResponder];

    [self searchTableList];

}

-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    return YES;
}


@end
