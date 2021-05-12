import Scenes
import Igis
import Foundation



class Player : RenderableEntity {

    //Jersey
    let jersey : Rectangle
    let jerseyColor : FillStyle
    var jerseyRect : Rect
    
    //Head
    let head : Rectangle
    let headColor : FillStyle
    var headRect : Rect

    //Velocity
    var velocity : Point

    //THE HOLY MERLIN BEARD
    let beard : Rectangle
    let beardRect : Rect
    let beardColor : FillStyle

    //Determines if player is merlin or not
    let isMerlinDeterminator : Bool
    
    init(teamJerseyColor: FillStyle, isMerlin: Bool) {

        isMerlinDeterminator = isMerlin
        jerseyRect = Rect(topLeft:Point(x:0, y:0), size:Size(width:50, height: 90))
        jersey = Rectangle(rect:jerseyRect, fillMode:.fill)
        jerseyColor = teamJerseyColor
        headRect = Rect(topLeft:Point(x:0, y:0), size:Size(width:50, height:25))
        head = Rectangle(rect:headRect, fillMode:.fill)
        headColor = FillStyle(color:Color(.burlywood))
        velocity = Point(x:0, y:0)

        beardRect = Rect(topLeft:Point(x:0, y:0), size:Size(width:30, height: 50))
        beard = Rectangle(rect:beardRect, fillMode: .fill)
        beardColor = FillStyle(color:Color(.white))
        
        
        super.init(name:"Player")
    }

    override func render(canvas: Canvas) {
        canvas.render(jerseyColor, jersey, headColor, head)
        if isMerlinDeterminator {
            canvas.render(beardColor, beard)
        }
    }

    //Moves the player to wherever specified
    func move(to point:Point) {
        jersey.rect.topLeft = Point(x:point.x, y: point.y + 25)
        head.rect.topLeft = point
        beard.rect.topLeft = Point(x:point.x + 20, y: point.y + 25)
    }

    //Changes player movement speed
    public func changeVelocity(velocityX:Int, velocityY:Int) {
        self.velocity.x = velocityX
        self.velocity.y = velocityY
    }

    //Player movements
    func moveRight() {
        jersey.rect.topLeft.x += velocity.x
        head.rect.topLeft.x += velocity.x
        beard.rect.topLeft.x += velocity.x
    }

    func moveLeft() {
        jersey.rect.topLeft.x += velocity.x * -1
        head.rect.topLeft.x += velocity.x * -1
        beard.rect.topLeft.x += velocity.x * -1
    }

    func moveUp() {
        jersey.rect.topLeft.y += velocity.y * -1
        head.rect.topLeft.y += velocity.y * -1
        beard.rect.topLeft.y += velocity.y * -1
    }

    func moveDown() {
        jersey.rect.topLeft.y += velocity.y 
        head.rect.topLeft.y += velocity.y
        beard.rect.topLeft.y += velocity.y
    }

    //bounding rect for player
    override func boundingRect() -> Rect {
        return Rect(topLeft: head.rect.topLeft, size: Size(width: jersey.rect.size.width, height: head.rect.size.height + jersey.rect.size.height))
    } 
    
}
