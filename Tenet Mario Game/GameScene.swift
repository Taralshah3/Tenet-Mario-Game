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
    
    override func didMove(to view: SKView) {
      /* Setup your scene here */

      /* Recursive node search for 'hero' (child of referenced node) */
      hero = (self.childNode(withName: "//Hero") as! SKSpriteNode)

      /* allows the hero to animate when it's in the GameScene */
      hero.isPaused = false
        /* Set reference to scroll layer node */
      scrollLayer = self.childNode(withName: "scrollLayer")
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
    }
}
