import Scenes
import Igis
import Foundation



class Player : RenderableEntity, MouseMoveHandler {

    let jersey : Rectangle
    let jerseyColor : FillStyle
    let head : Rectangle
    let headColor : FillStyle
    var jerseyRect : Rect
    var headRect : Rect
  
    init(teamJerseyColor: FillStyle) {
        jerseyRect = Rect(topLeft:Point(x:0, y:0), size:Size(width:50, height: 100))
        jersey = Rectangle(rect:jerseyRect, fillMode:.fill)
        jerseyColor = teamJerseyColor
        headRect = Rect(topLeft:Point(x:0, y:0), size:Size(width:50, height:25))
        head = Rectangle(rect:headRect, fillMode:.fill)
        headColor = FillStyle(color:Color(.brown))
        
        super.init(name:"Player")
    }

    override func render(canvas: Canvas) {
        canvas.render(jerseyColor, jersey, headColor, head)
    }

    override func setup(canvasSize:Size, canvas:Canvas) {
        
        dispatcher.registerMouseMoveHandler(handler:self)
    }

    override func teardown() {
        dispatcher.unregisterMouseMoveHandler(handler:self)
    }

    func move(to point:Point) {
        jersey.rect.topLeft = Point(x:point.x, y: point.y + 50)
        head.rect.topLeft = point
        
    }
    
    func onMouseMove(globalLocation:Point, movement:Point) {
        jersey.rect.topLeft = Point(x:globalLocation.x, y: globalLocation.y + 50)
        head.rect.topLeft = globalLocation        
    }
}
