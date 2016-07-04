//
//  LDCPRLCollectionView.m
//  Pods
//
//  Created by ITxiansheng on 16/7/1.
//
//

#import "LDCPRLCollectionView.h"
#import "LDCPRefreshControlView.h"
#import "LDCPLoadMoreControlView.h"

typedef void(^LDCPNoneParameterBlock)();

@interface LDCPRLCollectionView ()

@property (nonatomic,strong) LDCPRefreshControlView  * refreshView;
@property (nonatomic,strong) LDCPLoadMoreControlView * loadMoreView;

@property (nonatomic,copy) LDCPNoneParameterBlock refrshBlock;
@property (nonatomic,copy) LDCPNoneParameterBlock loadMoreBlock;
@end

@implementation LDCPRLCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout   {
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if(self){
        _refreshView = [[LDCPRefreshControlView alloc] init];
        _loadMoreView = [[LDCPLoadMoreControlView alloc] init];
        [self addSubview:_refreshView];
        [self addSubview:_loadMoreView];
    }
    return self;
}

- (void) beginRefreshAnimated:(BOOL)animated{
    [self.refreshView beginRefreshAnimated:animated];
}

- (void) endRefreshAnimated:(BOOL)animated{
    [self.refreshView endRefreshAnimated:animated];
}

- (void) setLoadMoreState:(LDCPLoadMoreState ) loadMoreState{
    [self.loadMoreView setLoadMoreState:loadMoreState];
}

- (void) setHideLoadMoreView:(BOOL)shouldLoadMoreViewHidden{
    self.loadMoreView.hidden = shouldLoadMoreViewHidden;
}

- (BOOL) hideLoadMoreView{
    return self.loadMoreView.hidden;
}

- (void) setPullRefreshBlock:(void (^)())pullRefreshBlock{
    _refrshBlock = pullRefreshBlock;
    [self.refreshView addTarget:self action:@selector(pullRefresh:) forControlEvents:UIControlEventValueChanged];
}

- (void) pullRefresh:(id)sender{
    if(self.refrshBlock){
        self.refrshBlock();
    }
}

- (void) setLoadMoreBlock:(void (^)())loadMoreBlock{
    _loadMoreBlock = loadMoreBlock;
    [self.loadMoreView addTarget:self action:@selector(loadMore:) forControlEvents:UIControlEventValueChanged];
}

- (void) loadMore:(id)sender{
    if(self.loadMoreBlock){
        self.loadMoreBlock();
    }
}
@end
