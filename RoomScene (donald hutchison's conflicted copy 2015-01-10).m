#import "RoomScene.h"


@implementation RoomScene
{
    BOOL _setup;
}


- (void)onEnter
{
    [super onEnter];

    [self setup];

}




- (void)setup
{
    if(_setup) return;



    _setup = YES;
}

- (void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    [super touchBegan:touch withEvent:event];
}

- (void)touchEnded:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    [super touchEnded:touch withEvent:event];

    
}


@end