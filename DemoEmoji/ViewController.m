//
//  ViewController.m
//  DemoEmoji
//
//  Created by Mai Trinh on 10/12/15.
//  Copyright © 2015 EBIZWORLD. All rights reserved.
//

#import "ViewController.h"
#import <CoreData+MagicalRecord.h>
#import "Emoji.h"
#import "CategoryEmoji.h"

@interface ViewController ()<UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{
    UICollectionView *collectionView;
    NSMutableArray *getAllCategory;
    NSMutableArray *getAllEmoji;
    NSMutableArray *arrCollectionView;
}

@property (weak, nonatomic) IBOutlet UIView *viewEmoji;
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_viewDetail setHidden:YES];
    if (getAllCategory == nil) {
        getAllCategory = [[NSMutableArray alloc]init];
    }
    if (getAllCategory.count > 0) {
        [getAllCategory removeAllObjects];
    }
    if (getAllEmoji == nil) {
        getAllEmoji = [[NSMutableArray alloc]init];
    }
    if (getAllEmoji.count > 0) {
        [getAllEmoji removeAllObjects];
    }
    
    if (arrCollectionView == nil) {
        arrCollectionView = [[NSMutableArray alloc]init];
    }
    if (arrCollectionView.count > 0) {
        [arrCollectionView removeAllObjects];
    }
    
    NSArray *arrCategory = [CategoryEmoji MR_findAll];
    for (int i = 0; i < arrCategory.count; i++) {
        CategoryEmoji *category = [arrCategory objectAtIndex:i];
        [getAllCategory addObject:category.nameCategory];
    }
    
    getAllEmoji = [[NSMutableArray alloc]init];
    NSArray *arrEmoji = [Emoji MR_findByAttribute:@"category" withValue:[getAllCategory objectAtIndex:0]];
    for (int i = 0; i < arrEmoji.count; i++) {
        Emoji *emoji = [arrEmoji objectAtIndex:i];
        [getAllEmoji addObject:emoji.name_emoji];
    }
    
    UIView *buttonsView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _viewEmoji.frame.size.width, 35)];
    [buttonsView setBackgroundColor:[UIColor greenColor]];
    [_viewEmoji addSubview:buttonsView];
    
    [self.scroll setDelegate:self];
    pageControlBeingUsed = NO;
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHight = screenRect.size.height;
    for (int i = 0; i < getAllCategory.count; i ++) {
        CGRect frame;
        frame.origin.x = self.scroll.frame.size.width * i;
        frame.origin.y = 0;
        frame.size = self.scroll.frame.size;
        
        UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
        collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(screenWidth*i,5,screenWidth ,self.scroll.frame.size.height-5) collectionViewLayout:layout];
        [collectionView setDataSource:self];
        [collectionView setDelegate:self];
        [collectionView setPagingEnabled:YES];
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.showsVerticalScrollIndicator = NO;
        [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
        [collectionView setBackgroundColor:[UIColor purpleColor]];
        collectionView.tag = i;
        [self.scroll addSubview:collectionView];
        
        [arrCollectionView addObject: collectionView];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(35*i + 5, 0, 35, 35)];
        [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@", [getAllCategory objectAtIndex:i]]] forState:UIControlStateNormal];
        button.tag = i;
        [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        [buttonsView addSubview:button];
    }
    
    self.scroll.contentSize = CGSizeMake(self.scroll.frame.size.width * [getAllCategory count], self.scroll.frame.size.height-100);
    self.pageControl.currentPage = 0;
    self.pageControl.numberOfPages = [getAllCategory count];
    [self.pageControl setBackgroundColor:[UIColor purpleColor]];
    [self.scroll setBackgroundColor:[UIColor greenColor]];
}

-(void)clickButton:(UIButton*)sender{
    [getAllEmoji removeAllObjects];
    // Update the scroll view to the appropriate page
    CGRect frame;
    frame.origin.x = self.scroll.frame.size.width * sender.tag;
    frame.origin.y = 0;
    frame.size = self.scroll.frame.size;
    [self.scroll scrollRectToVisible:frame animated:YES];
    self.pageControl.currentPage = sender.tag;
    //Change Emoji when scroll
    NSString *str = [getAllCategory objectAtIndex:sender.tag];
    NSArray *arr = [Emoji MR_findByAttribute:@"category" withValue:str];
    if (arr.count > 0) {
        for (int i = 0; i < arr.count; i++) {
            Emoji *emoji = [arr objectAtIndex:i];
            [getAllEmoji addObject:emoji.name_emoji];
        }
    }
    //        UICollectionView *collectionV = [arrCollectionView objectAtIndex:page];
    //        [collectionV reloadData];
    [arrCollectionView[sender.tag] reloadData];
    pageControlBeingUsed = YES;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return getAllEmoji.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionViewa cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell=[collectionViewa dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    
    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[getAllEmoji objectAtIndex:indexPath.row]]]];
    
    cell.backgroundColor=[UIColor greenColor];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    UICollectionView *collectionV = arrCollectionView[currentCollectionView];
//    UICollectionViewLayoutAttributes *attributes = [collectionV layoutAttributesForItemAtIndexPath:indexPath];
//    CGRect rect = attributes.frame;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(50, 50);
}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    if (!pageControlBeingUsed) {
        [getAllEmoji removeAllObjects];
        // Switch the indicator when more than 50% of the previous/next page is visible
        CGFloat pageWidth = self.scroll.frame.size.width;
        int page = floor((self.scroll.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        currentCollectionView = page;
        self.pageControl.currentPage = page;
        //Change Emoji when scroll
        NSString *str = [getAllCategory objectAtIndex:page];
        NSArray *arr = [Emoji MR_findByAttribute:@"category" withValue:str];
        if (arr.count > 0) {
            for (int i = 0; i < arr.count; i++) {
                Emoji *emoji = [arr objectAtIndex:i];
                [getAllEmoji addObject:emoji.name_emoji];
            }
        }
//        UICollectionView *collectionV = [arrCollectionView objectAtIndex:page];
//        [collectionV reloadData];
        [arrCollectionView[page] reloadData];
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
