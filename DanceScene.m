#import "DanceScene.h"
#import "GameConfig.h"
#import "CCNode+UIFlow.h"

static const int TIME_LIMIT = 5;

@implementation DanceScene
{
    int _danceFrame;
    int _timeLimit;
    float _timeElapsed;
    int _danceScore;
    CCProgressNode *_timer;
}

- (void)onEnter
{
    [super onEnter];
    NSLog(@"dancing on %@", [[GameConfig sharedConfig] getValueForKey:@"dance"]);

    CCActionScaleTo *scaleDown = [CCActionScaleTo actionWithDuration:0.2 scale:0.7];
    CCActionScaleTo *scaleUp = [CCActionScaleTo actionWithDuration:0.2 scale:1.3];

    CCAction *easeUp = [CCActionEaseIn actionWithAction:scaleUp rate:1];
    CCAction *easeDown = [CCActionEaseIn actionWithAction:scaleDown rate:1];

    CCActionSequence *sequence = [CCActionSequence actionWithArray:@[easeUp, easeDown]];

    [_danceButton runAction:[CCActionRepeatForever actionWithAction:sequence]];

    _danceFrame = 1;
    [_player setTexture:[CCTexture textureWithFile:@"dancemove1.png"]];

    _timeLimit = TIME_LIMIT;
    _timeElapsed = 0;

    _timer = [[CCProgressNode alloc] initWithSprite:_circleSprite];
    _timer.position = _circleSprite.position;
    [_circleSprite.parent addChild:_timer z:-10];
    [_circleSprite removeFromParent];



//    _timer.scaleY = 0;
    _cool.scaleY = 0;
    _danceScore = 0;
    if ([[GameConfig sharedConfig] getValueForKey:@"funk"])
    {
        _cool.scaleY = [[[GameConfig sharedConfig] getValueForKey:@"funk"] floatValue];
    }
}

- (void)onDance
{
    switch (_danceFrame)
    {
        case 1:
            [_player setTexture:[CCTexture textureWithFile:@"dancemove2.png"]];
            _danceFrame = 2;
            break;
        case 2:
            [_player setTexture:[CCTexture textureWithFile:@"dancemove1.png"]];
            _danceFrame = 1;
            break;

    }

    _cool.scaleY += 0.05;
    _danceScore++;

    if(arc4random_uniform(10) <= 3)
    {
        _player.scaleX *= -1;
        CGFloat parentWidth = [(CCSprite *) _danceButton.parent textureRect].size.width;
        CGFloat xDistance = _danceButton.position.x - parentWidth / 2;
        _danceButton.position = ccp(_danceButton.position.x - (xDistance * 2), _danceButton.position.y);

    }
    [self flipButton];
}

- (void)flipButton
{
    CGFloat parentWidth = [(CCSprite *) _danceButton.parent textureRect].size.width;
    CGFloat parentHeight = [(CCSprite *) _danceButton.parent textureRect].size.height;

    CGFloat xDistance = _danceButton.position.x - parentWidth / 2;

    CGFloat yDistance = _danceButton.position.y - parentHeight / 2;

    CGFloat newX, newY;
    newY = _danceButton.position.y - (yDistance * 2);

    newX = _danceButton.position.x - (xDistance * 2);


    _danceButton.position = ccp(newX, newY);
}


- (void)update:(CCTime)delta
{
    _timeElapsed += delta;

    _timer.percentage = 100 * ( _timeElapsed / _timeLimit);

    if(_timeElapsed >= _timeLimit)
    {
        if(_danceScore < 3)
        {
            [self sendUIMessage:@"die"];
        }
        else
        {
            [[GameConfig sharedConfig] setValue:[[GameConfig sharedConfig] getValueForKey:@"dance"] forKey:@"to_remove"];
            [[GameConfig sharedConfig] setValue:@(_cool.scaleY) forKey:@"funk"];

            [self sendUIMessage:@"pop"];
        }
    }
}


@end