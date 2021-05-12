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
        Self.ball.changeVelocity(velocityX: 11, velocityY: 11)
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

        let player1BoundingRect = Self.player1.boundingRect()
        let player2BoundingRect = Self.player2.boundingRect()
        let goalBox1BoundingRect = Self.field.goalBoxBoundingRect(goalBox: Self.field.goalBox1.rect)
        let goalBox2BoundingRect = Self.field.goalBoxBoundingRect(goalBox: Self.field.goalBox2.rect)
        
        let player1ContainmentGoalBox1 = player1BoundingRect.containment(target: goalBox1BoundingRect)
        let player1ContainmentGoalBox2 = player1BoundingRect.containment(target: goalBox2BoundingRect)
        let player2ContainmentGoalBox1 = player2BoundingRect.containment(target: goalBox1BoundingRect)
        let player2ContainmentGoalBox2 = player2BoundingRect.containment(target: goalBox2BoundingRect)

        
        //Player 1 controls
        if key == "w" && Self.player1.head.rect.topLeft.y >= Self.field.field.rect.topLeft.y && (!player1ContainmentGoalBox1.contains(.contact) || !player1ContainmentGoalBox1.contains(.overlapsTop)) && (!player1ContainmentGoalBox2.contains(.contact) || !player1ContainmentGoalBox2.contains(.overlapsTop))  {
            Self.player1.moveUp()
        }
        if key == "s" && Self.player1.jersey.rect.topLeft.y + Self.player1.jersey.rect.size.height <= Self.field.field.rect.topLeft.y + Self.field.field.rect.size.height && (!player1ContainmentGoalBox1.contains(.overlapsBottom) || !player1ContainmentGoalBox1.contains(.contact)) && (!player1ContainmentGoalBox2.contains(.contact) || !player1ContainmentGoalBox2.contains(.overlapsBottom))  {
            Self.player1.moveDown()
        }
        if key == "d" && Self.player1.jersey.rect.topLeft.x + Self.player1.jersey.rect.size.width <= Self.field.field.rect.topLeft.x + Self.field.field.rect.size.width && (!player1ContainmentGoalBox2.contains(.contact) || !player1ContainmentGoalBox2.contains(.overlapsRight)){
            Self.player1.moveRight()
        }
        if key == "a" && Self.player1.jersey.rect.topLeft.x >= Self.field.field.rect.topLeft.x && (!player1ContainmentGoalBox1.contains(.overlapsLeft) || !player1ContainmentGoalBox1.contains(.contact)) {
            Self.player1.moveLeft()
        }

        //Player 2 controls
        if key == "ArrowUp" && Self.player2.head.rect.topLeft.y >= Self.field.field.rect.topLeft.y && (!player2ContainmentGoalBox1.contains(.contact) || !player2ContainmentGoalBox1.contains(.overlapsTop)) && (!player2ContainmentGoalBox2.contains(.contact) || !player2ContainmentGoalBox2.contains(.overlapsTop)) {
            Self.player2.moveUp()
        }
        if key == "ArrowDown" && Self.player2.jersey.rect.topLeft.y + Self.player2.jersey.rect.size.height <= Self.field.field.rect.topLeft.y + Self.field.field.rect.size.height && (!player2ContainmentGoalBox1.contains(.overlapsBottom) || !player2ContainmentGoalBox1.contains(.contact)) && (!player2ContainmentGoalBox2.contains(.contact) || !player2ContainmentGoalBox2.contains(.overlapsBottom)) {
            Self.player2.moveDown()
        }
        if key == "ArrowRight" && Self.player2.jersey.rect.topLeft.x + Self.player2.jersey.rect.size.width <= Self.field.field.rect.topLeft.x + Self.field.field.rect.size.width && (!player2ContainmentGoalBox2.contains(.contact) || !player2ContainmentGoalBox2.contains(.overlapsRight)) {
            Self.player2.moveRight()
        }
        if key == "ArrowLeft" && Self.player2.jersey.rect.topLeft.x >= Self.field.field.rect.topLeft.x && (!player2ContainmentGoalBox1.contains(.overlapsLeft) || !player2ContainmentGoalBox1.contains(.contact)){
            Self.player2.moveLeft()
        }
    }

    override func postCalculate(canvas: Canvas) {
        let player1BoundingRect = Self.player1.boundingRect()
        let player2BoundingRect = Self.player2.boundingRect()
        let ballBoundingRect = Self.ball.boundingRect()

        let player1Containment = player1BoundingRect.containment(target: ballBoundingRect)
        let player2Containment = player2BoundingRect.containment(target: ballBoundingRect)

        
        if  player1Containment.contains(.contact) {
            Self.ball.velocity.x *= -1
            Self.ball.velocity.y *= -1
            if Self.ball.velocity.x > 0 {
                Self.ball.move(to: Point(x: Self.ball.ellipse.center.x + Self.ball.ellipse.radiusX + Self.player1.jersey.rect.size.width, y: Self.ball.ellipse.center.y))
            } else {
                Self.ball.move(to: Point(x: Self.ball.ellipse.center.x - Self.ball.ellipse.radiusX - Self.player1.jersey.rect.size.width, y: Self.ball.ellipse.center.y))
            }
        }
        /*
         (.overlapsRight) && player1Containment.contains(.overlapsTop) && player1Containment.contains(.overlapsBottom) && player1Containment.contains(.overlapsRight) && player1Containment.contains(.overlapsLeft) && player1Containment.contains(.overlapsTop) && player1Containment.contains(.overlapsLeft) && player1Containment.contains(.overlapsBottom)
         */

        if  player2Containment.contains(.contact) {
            Self.ball.velocity.x *= -1
            Self.ball.velocity.y *= -1
        }
    }
}
