//
//  GameScene.swift
//  Gravity Ball
//
//  Created by Marek Newton on 6/6/16.
//  Copyright (c) 2016 Marek Newton. All rights reserved.
//

import SpriteKit

struct pysics {
    static let rightSide : UInt32 = 0x1 << 1
    static let leftSide : UInt32 = 0x1 << 2
    static let Ball : UInt32 = 0x1 << 3
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var Ball = SKSpriteNode(imageNamed: "ball")
    var rightSide = SKSpriteNode(imageNamed: "floor")
    var leftSide = SKSpriteNode(imageNamed: "floor")
    var upArrow = SKSpriteNode(imageNamed: "upArrow")
    
    var score = 0
    var scoreLabel = SKLabelNode()
    var gameGoing = true
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        self.physicsWorld.contactDelegate = self
        self.backgroundColor = UIColor.blackColor()
        
        scoreLabel.position = CGPoint(x: self.frame.width / 2, y: self.frame.width / 0.5)
        scoreLabel.text = "\(score)"
        scoreLabel.fontColor = UIColor.whiteColor()
        self.addChild(scoreLabel)
        
        Ball.size = CGSize(width: 100, height: 100)
        Ball.position = CGPoint(x: frame.width + 100, y: frame.height / 2)
        Ball.physicsBody = SKPhysicsBody(circleOfRadius: Ball.frame.width)
        Ball.physicsBody?.categoryBitMask = pysics.Ball
        Ball.physicsBody?.collisionBitMask = pysics.rightSide | pysics.leftSide
        Ball.physicsBody?.contactTestBitMask = pysics.rightSide | pysics.leftSide
        Ball.physicsBody?.dynamic = true
        Ball.physicsBody?.affectedByGravity = false
        
        self.addChild(Ball)
        
        rightSide.size = CGSize(width: frame.width, height: 50)
        rightSide.position = CGPoint(x: frame.width, y: 0 - rightSide.frame.height / 2)
        rightSide.physicsBody = SKPhysicsBody(rectangleOfSize: rightSide.size)
        rightSide.physicsBody?.categoryBitMask = pysics.rightSide
        rightSide.physicsBody?.collisionBitMask = pysics.Ball
        rightSide.physicsBody?.contactTestBitMask = pysics.Ball
        rightSide.physicsBody?.dynamic = false
        //rightSide.physicsBody?.affectedByGravity = false
            
        self.addChild(rightSide)
            
            
        leftSide.size = CGSize(width: frame.width, height: 50)
        leftSide.position = CGPoint(x: 0, y: frame.height / 2)
        leftSide.physicsBody = SKPhysicsBody(rectangleOfSize: leftSide.size)
        leftSide.physicsBody?.categoryBitMask = pysics.leftSide
        leftSide.physicsBody?.collisionBitMask = pysics.leftSide
        leftSide.physicsBody?.contactTestBitMask = pysics.leftSide
        leftSide.physicsBody?.dynamic = false
            
        self.addChild(leftSide)
            
        let moveFloorUp = SKAction.moveBy(CGVectorMake(0,1000), duration: 2.0)
        let resestPosition = SKAction.moveToY(0, duration: 0)
        let resestPosition2 = SKAction.moveToY(-frame.height / 2, duration: 0)
        let ActionSequece = SKAction.sequence([moveFloorUp, resestPosition])
        let ActionSequece2 = SKAction.sequence([moveFloorUp, resestPosition2])

            leftSide.runAction(SKAction.repeatActionForever(ActionSequece))
            rightSide.runAction(SKAction.repeatActionForever(ActionSequece2))
        
    }
    func didBeginContact(contact: SKPhysicsContact) {
        let firstBody = contact.bodyA
        let secoundBody = contact.bodyB
        
        if /*firstBody.categoryBitMask == pysics.Ball && secoundBody.categoryBitMask == pysics.rightSide ||*/ firstBody.categoryBitMask == pysics.rightSide && secoundBody.categoryBitMask == pysics.Ball {
            print("game over")
            gameGoing = false
            print(gameGoing)
        }
        else {
            score += 1
        }
        if /*firstBody.categoryBitMask == pysics.Ball && secoundBody.categoryBitMask == pysics.leftSide ||*/ firstBody.categoryBitMask == pysics.leftSide && secoundBody.categoryBitMask == pysics.Ball {
            print("game over")
            gameGoing = false
            print(gameGoing)
        }
        else {
            score += 1
            print(score)
        }
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        let moveRight = SKAction.moveBy(CGVectorMake(100, 0), duration: 0.1)
        let moveLeft = SKAction.moveBy(CGVectorMake(-100, 0), duration: 0.1)
        var movedRight = false;
        var movedLeft = false;
        
        if gameGoing == true {
            if let touch = touches.first {
                let location = touch.locationInNode(self)
                print(location)
                if location.x > frame.width / 2 && movedRight == false {
                    Ball.runAction(moveRight)
                    movedRight = true
                    movedLeft = false
                }
                else if movedLeft == false {
                    Ball.runAction(moveLeft)
                    movedLeft = true
                    movedRight = false
                }
            }
        }
    }
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
        
}

