# Spinning Shots
This is a code sample to show how a simple game for iOS can be built and architectured. 
The game is written in Swift, using the SpriteKit framework.

The goal of the game is to shoot at spinning targets, miss a shot and the game is over.

The code in this repo was submitted as v1.0 to the App Store and is currently waiting for review at Apple.
I'm already working on my next projects, so this game won't see any feature additions until next year at least (critical bugs will be fixed if there should be any after-launch).
Feel free to open pull requests for features you would like to add! :)

demo-gif:  
![spinning shots demo gif](https://media.giphy.com/media/26BkO9QLlPBIf9m36/giphy.gif)  
  
    
# Architecture
The app contains one SKScene, in which the whole game takes place. 
Depending on the state the game is in (Menu, Playing, Game Over), additional UI elements are placed on the scene using
distinct SKNodes.

The core game logic is controlled by the scene itself and an instance of Game. 
The game informs the scene about important game events using a delegate protocol.

To get started, take a look at the Core/Scene.swift and Core/Game.swift classes.
