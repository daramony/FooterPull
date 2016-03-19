//
//  FetchMoreFakeDataTableViewController.m
//  Example
//
//  Created by Robert Nash on 31/12/2015.
//  Copyright © 2015 Robert Nash. All rights reserved.
//

#import "FetchMoreFakeDataTableViewController.h"
#import "FooterViewSpinner.h"

@implementation FetchMoreFakeDataTableViewController

-(void)viewDidLoad {
    
    [super viewDidLoad];
    
    __weak typeof (self) weakSelf = self;
    
    CGRect frame = CGRectMake(0, 0, self.tableView.frame.size.width, 60.0f);
    
    FooterViewSpinner <RRNInfiniteScrollFooterViewProtocol> *footer = [[FooterViewSpinner alloc] initWithFrame:frame];
    
    [self.tableView rrn_infinitScrollWithFooter:footer
                               withTriggerBlock:^{
                                   
                                   __strong typeof (weakSelf) strongSelf = weakSelf;
                                   
                                   [strongSelf.fetcher fetchMoreDataWithFetchDuration:2
                                                                       withCompletion:[strongSelf fetchMoreDataCompletionHandler]];
                                   
                               }];
    
}

-(void(^)(BOOL moreDataFound))fetchMoreDataCompletionHandler {
    
    __weak typeof (self) weakSelf = self;
    
    return ^ (BOOL moreDataFound) {
        
        [weakSelf.tableView rrn_completeAnimationForNewContent:moreDataFound
                                          performPeakAnimation:moreDataFound];
    };
}

#pragma mark - UIScrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.tableView rrn_scrollViewDidScroll];
}

-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    [self.tableView rrn_scrollViewWillBeginDecelerating];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self.tableView rrn_scrollViewDidEndDecelerating];
}

@end