#import "RoomScene.h"
#import "CCNode+UIFlow.h"
#import "GameConfig.h"


static const int TIME_LIMIT = 5;


@implementation RoomScene
{
    BOOL _setup;
    BOOL _doCollisions;
    CCTime _animationTimer;
    float _timePerFrame;
    int _playerFrames;
    int _currentFrame;

    int _timeLimit;
    float _timeElapsed;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        self.userInteractionEnabled = TRUE;
    }

    return self;
}

- (void)onEnterTransitionDidFinish
{
    _doCollisions = YES;

    _animationTimer = 0;
    _timePerFrame = 0.05;

    _playerFrames = 2;
    _currentFrame = 1;
    [_player setTexture:[CCTexture textureWithFile:@"walk1.png"]];


    _timeLimit = TIME_LIMIT;
    _timeElapsed = 0;

    _timer.scaleY = 0;
    _cool.scaleY = 0;

    if ([[GameConfig sharedConfig] getValueForKey:@"funk"])
    {
        _cool.scaleY = [[[GameConfig sharedConfig] getValueForKey:@"funk"] floatValue];
    }

    NSString *toRemoveName = [[GameConfig sharedConfig] getValueForKey:@"to_remove"];

    if (toRemoveName)
    {
        CCNode *toRemove = [_roomObjects getChildByName:toRemoveName recursively:NO];

        if (toRemove)
        {
            [self removeRoomObject:toRemove];
        }
    }

    if( _roomObjects.children.count == 0)
    {
        [self sendUIMessage:@"win"];
    }
    [self setup];
}

- (void)removeRoomObject:(CCNode *)toRemove
{
    [toRemove removeFromParent];
    [_foreground addChild:toRemove];
    CCAction *move = [CCActionMoveTo actionWithDuration:0.8 position:ccp(0, 400)];
    CCAction *rotate = [CCActionRotateBy actionWithDuration:0.8 angle:600];
    CCAction *shrink = [CCActionScaleTo actionWithDuration:0.8 scale:0.1];

    CCAction *spawn = [CCActionSpawn actionWithArray:@[move, rotate,shrink]];
    [toRemove runAction:spawn];
}

- (void)setup
{
    if (_setup) return;

    _setup = YES;
}

- (void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
}

- (void)touchEnded:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    [self movePlayerTo:[touch locationInNode:_objects]];
    [super touchEnded:touch withEvent:event];
}

- (void)movePlayerTo:(CGPoint)point
{
    CCAction *move = [CCActionMoveTo actionWithDuration:0.3 position:point];

    [_player runAction:move];
}

- (void)update:(CCTime)delta
{
    _animationTimer += delta;
    if(_animationTimer >= _timePerFrame)
    {
        _animationTimer = 0;
        [self changePlayerFrame];
    }

    if (!_doCollisions) return;
    for (CCSprite *roomObject in _roomObjects.children)
    {
        if (CGRectIntersectsRect(_player.boundingBox, roomObject.boundingBox))
        {
            [self danceOn:roomObject.name];
        }
    }

    _timeElapsed += delta;

    _timer.scaleY = 0.598 *( _timeElapsed / _timeLimit);

    if(_timeElapsed >= _timeLimit)
    {
        [self sendUIMessage:@"die"];
    }
}

- (void)changePlayerFrame
{
    _currentFrame++;
    if(_currentFrame > _playerFrames)
        _currentFrame = 1;

    NSString *frameName = [NSString stringWithFormat:@"walk%d.png", _currentFrame];
    [_player setTexture:[CCTexture textureWithFile:frameName]];
}

- (void)danceOn:(NSString *)name
{
    _doCollisions = NO;

    [[GameConfig sharedConfig] setValue:name forKey:@"dance"];

    [self sendUIMessage:@"dance"];
}

@end