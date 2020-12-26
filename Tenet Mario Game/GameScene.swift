//
//  GameScene.swift
//  Tenet Mario Game
//
//  Created by Taral Shah on 12/23/20.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var hero: SKSpriteNode!
    var scrollLayer: SKNode!
    let scrollSpeed: CGFloat = 100
    let fixedDelta: CFTimeInterval = 1.0 / 60.0
    let scrollSpeed2: CGFloat = 200
    var obstacleSource: SKNode!
    var spawnTimer: CFTimeInterval = 0
    var obstacleLayer: SKNode!
    
    override func didMove(to view: SKView) {
      /* Setup your scene here */

      /* Recursive node search for 'hero' (child of referenced node) */
      hero = (self.childNode(withName: "//Hero") as! SKSpriteNode)

      /* allows the hero to animate when it's in the GameScene */
      hero.isPaused = false
        /* Set reference to scroll layer node */
      scrollLayer = self.childNode(withName: "scrollLayer")
      //obstacleSource = self.childNode(withName: "obstacle")
      obstacleLayer = self.childNode(withName: "obstacleLayer")
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      /* Called when a touch begins */

      /* Apply vertical impulse */
      hero.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 30))
    }

    override func update(_ currentTime: TimeInterval) {
        /* Called before each frame is rendered */
        func scrollWorld() {
          /* Scroll World */
          scrollLayer.position.x -= scrollSpeed * CGFloat(fixedDelta)
            
            /*loops through all children of scroll, ground objects*/
            for ground in scrollLayer.children as! [SKSpriteNode] {

              /* Get ground node position, convert node position to scene space */
              let groundPosition = scrollLayer.convert(ground.position, to: self)

              /* Check if ground sprite has left the scene */
              if groundPosition.x <= -ground.size.width / 2 {

                  /* Reposition ground sprite to the second starting position */
                  let newPosition = CGPoint(x: (self.size.width / 2) + ground.size.width, y: groundPosition.y)

                  /* Convert new node position back to scroll layer space */
                  ground.position = self.convert(newPosition, to: scrollLayer)
              }
            }
         }
        scrollWorld()
        updateObstacles()
        spawnTimer+=fixedDelta
    }
    func updateObstacles() {
       /* Update Obstacles */

       obstacleLayer.position.x -= scrollSpeed * CGFloat(fixedDelta)

       /* Loop through obstacle layer nodes */
       for obstacle in obstacleLayer.children as! [SKReferenceNode] {

           /* Get obstacle node position, convert node position to scene space */
           let obstaclePosition = obstacleLayer.convert(obstacle.position, to: self)

           /* Check if obstacle has left the scene */
           if obstaclePosition.x <= -26 {
           // 26 is one half the width of an obstacle

               /* Remove obstacle node from obstacle layer */
               obstacle.removeFromParent()
           }
        /* Time to add a new obstacle? */
            if spawnTimer >= 1.5 {

                /* Create a new obstacle by copying the source obstacle */
                //let newObstacle = obstacleSource.copy() as! SKNode
                //obstacleLayer.addChild(newObstacle)

                /* Generate new obstacle position, start just outside screen and with a random y value */
                let randomPosition =  CGPoint(x: 347, y: CGFloat.random(in: 234...382))

                /* Convert new node position back to obstacle layer space */
                //newObstacle.position = self.convert(randomPosition, to: obstacleLayer)

                // Reset spawn timer
                spawnTimer = 0
            }
        

       }

     }
}
