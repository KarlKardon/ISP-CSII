import Scenes
import Igis

/*
 This class is responsible for the interaction Layer.
 Internally, it maintains the RenderableEntities for this layer.
 */


class InteractionLayer : Layer, KeyDownHandler {

    
    let scoreboard = Scoreboard()
    static let player1 = Player(teamJerseyColor : FillStyle(color:Color(.blue)))
    static let player2 = Player(teamJerseyColor : FillStyle(color:Color(.red)))
    static let field = Field()
    static let ball = Ball()

    enum kickType {
        case up
        case down
        case straight
    }

    static var player1KickDirection = kickType.straight
    static var player2KickDirection = kickType.straight
    
    init() {

        
        
        // Using a meaningful name can be helpful for debugging
        super.init(name:"Interaction")

        // We insert our RenderableEntities in the constructor
        
        Self.ball.velocity = Point(x:Self.ball.targetXVelocity/2, y:Self.ball.targetYVelocity/2)
        insert(entity:Self.field, at:.front)
        insert(entity:Self.player2, at:.front) 
        insert(entity:Self.player1, at:.front)
        insert(entity:Self.ball, at:.front)
        insert(entity:scoreboard, at:.front)
        
    }

    override func preSetup(canvasSize: Size, canvas: Canvas) {
        Self.ball.velocity.x = Self.ball.velocity.x/2
        Self.ball.velocity.y = Self.ball.velocity.y/2
        Self.player1.changeVelocity(velocityX:30, velocityY:30)
        Self.player2.changeVelocity(velocityX:30, velocityY:30)
        //Moving players to starting positions
        Self.player2.move(to: Point(x: Self.field.field.rect.topLeft.x + Self.field.field.rect.size.center.x + 100, y: Self.field.fieldCircle.center.y))
        Self.player1.move(to: Point(x: Self.field.field.rect.topLeft.x + Self.field.field.rect.size.center.x - 100, y: Self.field.fieldCircle.center.y))

        //Keydownhandler business
        dispatcher.registerKeyDownHandler(handler: self)
    }

    override func postTeardown() {
        dispatcher.unregisterKeyDownHandler(handler: self)
    }

    
    func onKeyDown(key:String, code:String, ctrlKey:Bool, shiftKey:Bool, altKey:Bool, metaKey:Bool) {
        print ("\(key)")
        print ("\(code)")

        ///////////////////////////////
        //Boundingrect and containments
        ///////////////////////////////
        
        let player1BoundingRect = Self.player1.boundingRect()
        let player2BoundingRect = Self.player2.boundingRect()
        let goalBox1BoundingRect = Self.field.goalBoxBoundingRect(goalBox: Self.field.goalBox1.rect)
        let goalBox2BoundingRect = Self.field.goalBoxBoundingRect(goalBox: Self.field.goalBox2.rect)
        
        let player1ContainmentGoalBox1 = player1BoundingRect.containment(target: goalBox1BoundingRect)
        let player1ContainmentGoalBox2 = player1BoundingRect.containment(target: goalBox2BoundingRect)
        let player2ContainmentGoalBox1 = player2BoundingRect.containment(target: goalBox1BoundingRect)
        let player2ContainmentGoalBox2 = player2BoundingRect.containment(target: goalBox2BoundingRect)

        ///////////////////
        //Player 1 controls
        ///////////////////
        
        if key == "w" && Self.player1.head.rect.topLeft.y >= Self.field.field.rect.topLeft.y + 30 && (!player1ContainmentGoalBox1.contains(.contact) || !player1ContainmentGoalBox1.contains(.overlapsTop)) && (!player1ContainmentGoalBox2.contains(.contact) || !player1ContainmentGoalBox2.contains(.overlapsTop))  {
            Self.player1.moveUp()
        }
        if key == "s" && Self.player1.jersey.rect.topLeft.y + Self.player1.jersey.rect.size.height <= Self.field.field.rect.topLeft.y + Self.field.field.rect.size.height - 30 && (!player1ContainmentGoalBox1.contains(.overlapsBottom) || !player1ContainmentGoalBox1.contains(.contact)) && (!player1ContainmentGoalBox2.contains(.contact) || !player1ContainmentGoalBox2.contains(.overlapsBottom))  {
            Self.player1.moveDown()
        }
        if key == "d" && Self.player1.jersey.rect.topLeft.x + Self.player1.jersey.rect.size.width <= Self.field.field.rect.topLeft.x + Self.field.field.rect.size.width - 30 && (!player1ContainmentGoalBox2.contains(.contact) || !player1ContainmentGoalBox2.contains(.overlapsRight)){
            Self.player1.moveRight()
        }
        if key == "a" && Self.player1.jersey.rect.topLeft.x >= Self.field.field.rect.topLeft.x + 30 && (!player1ContainmentGoalBox1.contains(.overlapsLeft) || !player1ContainmentGoalBox1.contains(.contact)) {
            Self.player1.moveLeft()
        }
        if key == "j" {
            Self.player1KickDirection = .up
        }
        if key == "k" {
            Self.player1KickDirection = .straight
        }
        if key == "l" {
            Self.player1KickDirection = .down
        }

        ///////////////////
        //Player 2 controls
        ///////////////////
        
        if key == "ArrowUp" && Self.player2.head.rect.topLeft.y >= Self.field.field.rect.topLeft.y + 30 && (!player2ContainmentGoalBox1.contains(.contact) || !player2ContainmentGoalBox1.contains(.overlapsTop)) && (!player2ContainmentGoalBox2.contains(.contact) || !player2ContainmentGoalBox2.contains(.overlapsTop)) {
            Self.player2.moveUp()
        }
        if key == "ArrowDown" && Self.player2.jersey.rect.topLeft.y + Self.player2.jersey.rect.size.height  <= Self.field.field.rect.topLeft.y + Self.field.field.rect.size.height - 30 && (!player2ContainmentGoalBox1.contains(.overlapsBottom) || !player2ContainmentGoalBox1.contains(.contact)) && (!player2ContainmentGoalBox2.contains(.contact) || !player2ContainmentGoalBox2.contains(.overlapsBottom)) {
            Self.player2.moveDown()
        }
        if key == "ArrowRight" && Self.player2.jersey.rect.topLeft.x + Self.player2.jersey.rect.size.width <= Self.field.field.rect.topLeft.x + Self.field.field.rect.size.width - 30 && (!player2ContainmentGoalBox2.contains(.contact) || !player2ContainmentGoalBox2.contains(.overlapsRight)) {
            Self.player2.moveRight()
        }
        if key == "ArrowLeft" && Self.player2.jersey.rect.topLeft.x >= Self.field.field.rect.topLeft.x + 30 && (!player2ContainmentGoalBox1.contains(.overlapsLeft) || !player2ContainmentGoalBox1.contains(.contact)){
            Self.player2.moveLeft()
        }

        if key == "4" {
            Self.player2KickDirection = .up
        }
        if key == "5" {
            Self.player2KickDirection = .straight
        }
        if key == "6" {
            Self.player2KickDirection = .down
        }
    }

    
    override func postCalculate(canvas: Canvas) {

        ///////////////////////////////
        //BoundingRect and containments
        ///////////////////////////////
        
        let player1BoundingRect = Self.player1.boundingRect()
        let player2BoundingRect = Self.player2.boundingRect()
        let ballBoundingRect = Self.ball.boundingRect()
        let goal1BoundingRect = Self.field.goal1.rect
        let goal2BoundingRect = Self.field.goal2.rect

        let ballGoal1Containment = goal1BoundingRect.containment(target: ballBoundingRect)
        let ballGoal2Containment = goal2BoundingRect.containment(target: ballBoundingRect)
        let player1Containment = player1BoundingRect.containment(target: ballBoundingRect)
        let player2Containment = player2BoundingRect.containment(target: ballBoundingRect)

        //////////////////
        //Increasing score
        //////////////////
        
        if ballGoal1Containment.contains(.overlapsRight) && ballGoal1Containment.contains(.contact) {
            scoreboard.increasePlayer2Score()
            Self.ball.move(to: Self.field.fieldCircle.center)
            Self.ball.velocity.x = 20
        }

        if ballGoal2Containment.contains(.overlapsLeft) && ballGoal2Containment.contains(.contact){
            scoreboard.increasePlayer1Score()
            Self.ball.move(to: Self.field.fieldCircle.center)
            Self.ball.velocity.x = -20
        }

        ////////////////////////
        //Player -> Ball physics
        ////////////////////////
        
        if  player1Containment.contains(.contact) {
            switch Self.player1KickDirection {
            case .up:
                Self.ball.velocity.x *= -1
                Self.ball.velocity.y = -Self.ball.targetYVelocity
            case .down:
                Self.ball.velocity.x *= -1
                Self.ball.velocity.y = Self.ball.targetYVelocity
            case .straight:
                if Self.ball.velocity.x != Self.ball.targetXVelocity * 2 {
                    Self.ball.velocity.x = -2 * Self.ball.velocity.x
                } else {
                    Self.ball.velocity.x *= -1
                }
                Self.ball.velocity.y = 0
            }
            if Self.ball.velocity.x > 0 {
                Self.ball.move(to: Point(x: Self.ball.ellipse.center.x + Self.ball.ellipse.radiusX + Self.player1.jersey.rect.size.width, y: Self.ball.ellipse.center.y))
            } else {
                Self.ball.move(to: Point(x: Self.ball.ellipse.center.x - Self.ball.ellipse.radiusX - Self.player1.jersey.rect.size.width, y: Self.ball.ellipse.center.y))
            }
        }

        if  player2Containment.contains(.contact) {
            switch Self.player2KickDirection {
            case .up:
                Self.ball.velocity.x *= -1
                Self.ball.velocity.y = -Self.ball.targetYVelocity
            case .down:
                Self.ball.velocity.x *= -1
                Self.ball.velocity.y = Self.ball.targetYVelocity
            case .straight:
                if Self.ball.velocity.x != Self.ball.targetXVelocity * 2 {
                    Self.ball.velocity.x = -2 * Self.ball.velocity.x
                } else {
                    Self.ball.velocity.x *= -1
                }
                Self.ball.velocity.y = 0
                
            }
            if Self.ball.velocity.x > 0 {
                Self.ball.move(to: Point(x: Self.ball.ellipse.center.x + Self.ball.ellipse.radiusX + Self.player1.jersey.rect.size.width, y: Self.ball.ellipse.center.y))
            } else {
                Self.ball.move(to: Point(x: Self.ball.ellipse.center.x - Self.ball.ellipse.radiusX - Self.player1.jersey.rect.size.width, y: Self.ball.ellipse.center.y))
            }
        }

    }
}
