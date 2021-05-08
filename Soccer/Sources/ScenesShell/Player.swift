import Scenes
import Igis
import Foundation



class Player : RenderableEntity, MouseMoveHandler, EntityMouseClickHandler {

    var nativeFollow : Bool
    var shouldFollowMouse : Bool
    let jersey : Rectangle
    let jerseyColor : FillStyle
    let head : Rectangle
    let headColor : FillStyle
    var jerseyRect : Rect
    var headRect : Rect
  
    init(teamJerseyColor: FillStyle) {

        nativeFollow = false
        shouldFollowMouse = true
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
        dispatcher.registerEntityMouseClickHandler(handler:self)
    }

    override func teardown() {
        dispatcher.unregisterEntityMouseClickHandler(handler:self)
    }

    
    func move(to point:Point) {
        jersey.rect.topLeft = Point(x:point.x, y: point.y + 50)
        head.rect.topLeft = point
        
    }

    override func hitTest(globalLocation: Point) -> Bool {
        if globalLocation.x >= head.rect.topLeft.x && globalLocation.x <= head.rect.topLeft.x + head.rect.width && globalLocation.y >= jersey.rect.topLeft.y + jersey.rect.height && globalLocation.y <= head.rect.topLeft.y {
            return true
        } else {
            return false
        }
    }
    
    func onMouseMove(globalLocation:Point, movement:Point) {
        if hitTest(globalLocation: globalLocation) {
            shouldFollowMouse = true
        }
        
//        if shouldFollowMouse {
//            jersey.rect.topLeft = Point(x:globalLocation.x, y: globalLocation.y + 50)
//            head.rect.topLeft = globalLocation
//        }
    }

    func onEntityMouseClick(globalLocation: Point) {
        shouldFollowMouse = true
        print("\(shouldFollowMouse)")
        jersey.rect.topLeft = Point(x:globalLocation.x, y: globalLocation.y + 50)
        head.rect.topLeft = globalLocation
    }
    
}
