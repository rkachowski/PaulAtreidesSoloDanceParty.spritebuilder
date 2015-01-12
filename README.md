This is a game made in 6 hours with cocos2d + SpriteBuilder for January 2015 Berlin Mini Jam.

The themes we got were "space", "stayin alive" and "escalation", so the only logical thing to do was to make a dance simulator based on Frank Herbert's Dune. The original idea was to have an anti-beat matching game (dance without rhythm), but a beat syncing algorithm was too much for 6 hours.

## Code

The code is a mess, as is to be expected from 6 hours of caffiene fuelled planning and development. Especially bad are the timers / progress meter implementation. The only cool part I would revisit is the UIFlowManager - I like the approach, and the simple scene based navigation really let us put in stupid one shot animations with almost no overhead (see the game over / win screen).

## Tools

SpriteBuilder is pretty cool, it's the first time I'd played with the animation support and once you get your head around it, it's very powerful. Small things like the logo bounce can be added and tweaked inside the SpriteBuilder editor, so there's no compile/test/tweak cycle like with other animation implementations.

You can watch a video [here](https://www.youtube.com/watch?v=UVuQSYsLyYo&feature=youtu.be) on youtube rather than downloading it.

## Build

You can run it with XCode on iOS as is, and soon be able to load in SpriteBuilder pending a pull request.
For Android you need the SBAndroidPlugin available at www.spritebuilder.com/beta - or [just download the apk](http://www.droidbin.com/p19bfp4su5n65idl0b1pee14us3)

_if you dance without rhythm, you won't attract the worm_
