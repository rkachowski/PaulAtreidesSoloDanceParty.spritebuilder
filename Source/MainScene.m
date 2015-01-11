#import <Foundation/Foundation.h>
#import "MainScene.h"
#import "UIFlowManager.h"
#import "CCNode+UIFlow.h"
#import "GameConfig.h"

@implementation MainScene

- (void)onEnter
{
    [super onEnter];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       [self setupGame];
    });
}

- (void)setupGame
{
    [UIFlowManager sharedManager]; //force ui construction
    [[OALSimpleAudio sharedInstance] playBg:@"getup.wav" loop:YES];
}


- (void)onPlay
{
    [self startGame];
}

- (void)startGame
{
    [[GameConfig sharedConfig] setup];
    [self sendUIMessage:@"play"];
}

@end
