import Scenes
import Igis

/*
 This class is responsible for the interaction Layer.
 Internally, it maintains the RenderableEntities for this layer.
 */


class InteractionLayer : Layer, KeyDownHandler {
    
    static let player1 = Player(teamJerseyColor : FillStyle(color:Color(.blue)))
    static let player2 = Player(teamJerseyColor : FillStyle(color:Color(.red)))
    static let field = Field()
    static let ball = Ball()
    init() {

        
        
        // Using a meaningful name can be helpful for debugging
        super.init(name:"Interaction")

        // We insert our RenderableEntities in the constructor

        insert(entity:Self.field, at:.front)
        insert(entity:Self.player2, at:.front) 
        insert(entity:Self.player1, at:.front)
        insert(entity:Self.ball, at:.front)
        
    }

    override func preSetup(canvasSize: Size, canvas: Canvas) {

        Self.player1.changeVelocity(velocityX:10, velocityY:10)
        Self.player2.changeVelocity(velocityX:10, velocityY:10)
        Self.ball.changeVelocity(velocityX: 20, velocityY: 20)
        //Moving players to starting positions
        Self.player2.move(to: Point(x: canvasSize.center.x + 100, y: canvasSize.center.y))
        Self.player1.move(to: Point(x: canvasSize.center.x - 100, y: canvasSize.center.y))

        //Keydownhandler business
        dispatcher.registerKeyDownHandler(handler: self)
    }

    override func postTeardown() {
        dispatcher.unregisterKeyDownHandler(handler: self)
    }

    func postCalculate(canvasSize: Size) {
        
    }

    func onKeyDown(key:String, code:String, ctrlKey:Bool, shiftKey:Bool, altKey:Bool, metaKey:Bool) {
        print ("\(key)")
        print ("\(code)")
        //Player 1 controls
        if key == "w" {
            Self.player1.moveUp()
        }
        if key == "s" {
            Self.player1.moveDown()
        }
        if key == "d" {
            Self.player1.moveRight()
        }
        if key == "a" {
            Self.player1.moveLeft()
        }

        //Player 2 controls
        if key == "ArrowUp" {
            Self.player2.moveUp()
        }
        if key == "ArrowDown" {
            Self.player2.moveDown()
        }
        if key == "ArrowRight" {
            Self.player2.moveRight()
        }
        if key == "ArrowLeft" {
            Self.player2.moveLeft()
        }
    }

    override func postCalculate(canvas: Canvas) {
        let player1BoundingRect = Self.player1.boundingRect()
        let player2BoundingRect = Self.player2.boundingRect()
        let ballBoundingRect = Self.ball.boundingRect()

        let player1Containment = player1BoundingRect.containment(target: ballBoundingRect)
        let player2Containment = player2BoundingRect.containment(target: ballBoundingRect)

        
        if  player1Containment.contains(.overlapsRight) && player1Containment.contains(.overlapsTop) && player1Containment.contains(.overlapsBottom) && player1Containment.contains(.overlapsRight) && player1Containment.contains(.overlapsLeft) && player1Containment.contains(.overlapsTop) && player1Containment.contains(.overlapsLeft) && player1Containment.contains(.overlapsBottom) {
            Self.ball.velocity.x *= -1
            Self.ball.velocity.y *= -1
        }

        if  player2Containment.contains(.overlapsRight) && player2Containment.contains(.overlapsTop) && player2Containment.contains(.overlapsBottom) && player2Containment.contains(.overlapsRight) && player2Containment.contains(.overlapsLeft) && player2Containment.contains(.overlapsTop) && player2Containment.contains(.overlapsLeft) && player2Containment.contains(.overlapsBottom){
            Self.ball.velocity.x *= -1
            Self.ball.velocity.y *= -1
        }
    }
}
