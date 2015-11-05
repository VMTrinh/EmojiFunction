//
//  ViewController.m
//  DemoEmoji
//
//  Created by Mai Trinh on 10/12/15.
//  Copyright © 2015 EBIZWORLD. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *viewEmoji;
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    myObject = [[NSMutableArray alloc] init];
    [myObject addObject:@"Label 1"];
    [myObject addObject:@"Label 2"];
    [myObject addObject:@"Label 3"];
    [myObject addObject:@"Label 4"];
    [myObject addObject:@"Label 5"];
    [myObject addObject:@"Label 6"];
    [myObject addObject:@"Label 7"];
    [myObject addObject:@"Label 8"];
    [myObject addObject:@"Label 9"];
    
    [self.scroll setDelegate:self];
    pageControlBeingUsed = NO;
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHight = screenRect.size.height;
    
    for (int i = 0; i < myObject.count; i ++) {
        CGRect frame;
        frame.origin.x = self.scroll.frame.size.width * i;
        frame.origin.y = 0;
        frame.size = self.scroll.frame.size;
        
        NSString *strValue = [myObject objectAtIndex:i];
        
        UILabel *txt = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth*i,0,screenWidth ,50)];
        txt.text = strValue;
        txt.textColor = [UIColor blackColor];
        txt.backgroundColor = [UIColor purpleColor];
        txt.textAlignment = NSTextAlignmentCenter;
        
        [self.scroll addSubview:txt];
    }
    self.scroll.contentSize = CGSizeMake(self.scroll.frame.size.width * [myObject count], self.scroll.frame.size.height-100);
    self.pageControl.currentPage = 0;
    self.pageControl.numberOfPages = [myObject count];
    [self.pageControl setBackgroundColor:[UIColor purpleColor]];
    [self.scroll setBackgroundColor:[UIColor greenColor]];
}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    if (!pageControlBeingUsed) {
        // Switch the indicator when more than 50% of the previous/next page is visible
        CGFloat pageWidth = self.scroll.frame.size.width;
        int page = floor((self.scroll.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        self.pageControl.currentPage = page;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    pageControlBeingUsed = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    pageControlBeingUsed = NO;
}

- (IBAction)changePage:(id)sender {
    // Update the scroll view to the appropriate page
    CGRect frame;
    frame.origin.x = self.scroll.frame.size.width * self.pageControl.currentPage;
    frame.origin.y = 0;
    frame.size = self.scroll.frame.size;
    [self.scroll scrollRectToVisible:frame animated:YES];
    pageControlBeingUsed = YES;
}

- (void)viewDidUnload {
    self.scroll = nil;
    self.pageControl = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
