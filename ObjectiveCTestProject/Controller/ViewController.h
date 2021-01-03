//
//  ViewController.h
//  ObjectiveCTestProject
//
//  Created by Angelina on 04.01.2021.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

{
    NSMutableArray *filteredContentList;

}

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UISearchController *searchBarController;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

