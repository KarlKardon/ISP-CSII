import Scenes
import Igis
import Foundation



class Player : RenderableEntity {

    let jersey : Rectangle
    let jerseyColor : FillStyle
    let head : Rectangle
    let headColor : FillStyle
    var jerseyRect : Rect
    var headRect : Rect
    var velocity : Point
    
    init(teamJerseyColor: FillStyle) {

        jerseyRect = Rect(topLeft:Point(x:0, y:0), size:Size(width:50, height: 100))
        jersey = Rectangle(rect:jerseyRect, fillMode:.fill)
        jerseyColor = teamJerseyColor
        headRect = Rect(topLeft:Point(x:0, y:0), size:Size(width:50, height:25))
        head = Rectangle(rect:headRect, fillMode:.fill)
        headColor = FillStyle(color:Color(.brown))
        velocity = Point(x:0, y:0)
        
        super.init(name:"Player")
    }

    override func render(canvas: Canvas) {
        canvas.render(jerseyColor, jersey, headColor, head)
    }

    override func setup(canvasSize:Size, canvas:Canvas) {
        
    }

    override func teardown() {
    }

    
    func move(to point:Point) {
        jersey.rect.topLeft = Point(x:point.x, y: point.y + 50)
        head.rect.topLeft = point
        
    }
    
    public func changeVelocity(velocityX:Int, velocityY:Int) {
        self.velocity.x = velocityX
        self.velocity.y = velocityY
    }


    func moveRight() {
        jersey.rect.topLeft.x += velocity.x
        head.rect.topLeft.x += velocity.x
    }

    func moveLeft() {
        jersey.rect.topLeft.x += velocity.x * -1
        head.rect.topLeft.x += velocity.x * -1
    }

    func moveUp() {
        jersey.rect.topLeft.y += velocity.y * -1
        head.rect.topLeft.y += velocity.y * -1
    }

    func moveDown() {
        jersey.rect.topLeft.y += velocity.y 
        head.rect.topLeft.y += velocity.y 
    }

    override func boundingRect() -> Rect {
        return Rect(topLeft: head.rect.topLeft, size: Size(width: jersey.rect.size.width, height: head.rect.size.height + jersey.rect.size.height))
    }

    override func calculate(canvasSize:Size) {
        
    }
    
    
}
