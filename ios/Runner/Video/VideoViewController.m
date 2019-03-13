//
//  VideoViewController.m
//  Runner
//
//  Created by Alice Jin on 29/1/2019.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#import "VideoViewController.h"
#import "LSEmojiFlyView.h"

#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

@interface VideoViewController ()

@property (nonatomic, retain) AVPlayerViewController *playerViewController;
@property (nonatomic, retain) AVPlayer *player;
@property (nonatomic, retain) AVPlayerItem *playerItem;

@end

@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_addButton addTarget:self action:@selector(addButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [_cancelButton addTarget:self action:@selector(cancelButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self setUpPlayer];
}

- (void)addButtonClicked {
    LSEmojiFlyView *emoji = [[LSEmojiFlyView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [self.view addSubview:emoji];
    CGPoint fountainSource_emoji = CGPointMake(self.addButton.frame.origin.x + 20, self.addButton.frame.origin.y - 20);
    emoji.center = fountainSource_emoji;
    [emoji animateInView:self.view withImageName:@"emoji_heart_eye.png"];
}

- (void)cancelButtonClicked {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Player
- (void)setUpPlayer {
    [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayback error: nil];
    
    if (!self.playerViewController) {
        self.playerViewController = [[AVPlayerViewController alloc] init];
        _playerViewController.view.frame = self.view.frame;
        if (!self.player) {
            self.player = [[AVPlayer alloc] init];
            _playerViewController.player = self.player;
            [self.view addSubview:_playerViewController.view];
        }
    }
    _playerViewController.showsPlaybackControls = NO;
    _playerViewController.videoGravity = AVVideoScalingModeResizeAspect;
    
    [self bringButtonsToFront];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showVODEnd) name:AVPlayerItemDidPlayToEndTimeNotification object:_playerViewController.player.currentItem];
//
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(handleAVPlayerAccess:)
//                                                 name:AVPlayerItemNewAccessLogEntryNotification
//                                               object:nil];
//
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(handleAVPlayerPlayback:)
//                                                 name:AVPlayerItemPlaybackStalledNotification
//                                               object:nil];
//
//    //set player play
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(setPlayerAfterEnterForeground)
//                                                 name:@"app_enter_foreground" object:nil];
    
    //add KVO
    [self addObserverWithAVPlayerItem];
    [self playSignedCookieUrl];
}

#pragma mark - KVO
-(void)addObserverWithAVPlayerItem{
    //状态添加观察者
    [self.playerViewController.player addObserver:self forKeyPath:@"status" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:nil];
    // 缓存进度添加观察者
    [self.playerViewController.player addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    
    [self.playerViewController.player addObserver:self forKeyPath:@"timeControlStatus" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerStatus status = [[change objectForKey:@"new"] intValue];
        if (status == AVPlayerStatusReadyToPlay) {
            [_playerViewController.player play];
        } else if (status == AVPlayerStatusFailed){
            NSLog(@"AJPlayer 视频准备发生错误");
        }
        //*AVPlayerStatusUnknown
        else {
            NSLog(@"AJPlayer 位置错误");
        }
    }
    else if ([keyPath isEqualToString:@"loadedTimeRanges"]){
        // 可以自定义缓存进度
        
    }
}

#pragma mark - Player-playSignedCookieUrl
- (void)playSignedCookieUrl {
    
    AVURLAsset * asset = [AVURLAsset assetWithURL:[NSURL URLWithString:@"http://184.72.239.149/vod/smil:BigBuckBunny.smil/playlist.m3u8"]];
    self.playerItem = [AVPlayerItem playerItemWithAsset:asset];
    _playerViewController.showsPlaybackControls = YES;
    _playerViewController.player.automaticallyWaitsToMinimizeStalling = YES;
    [_playerViewController.player replaceCurrentItemWithPlayerItem:self.playerItem];
    
    
}

- (void)bringButtonsToFront {
    [self.view bringSubviewToFront:_cancelButton];
    [self.view bringSubviewToFront:_addButton];
}

@end
