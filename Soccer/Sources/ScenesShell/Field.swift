import Igis
import Scenes
import Foundation

class Field: RenderableEntity {

    let field : Rectangle
    let fieldCircle : Ellipse
    let fieldLineThickness : LineWidth
    let strokeStyle : StrokeStyle
    let goal1 : Rectangle
    let goal2 : Rectangle
    let goalBox1 : Rectangle
    let goalBox2: Rectangle
    
    init() {

        //Main field
        let fieldRect = Rect(topLeft: Point(x:0, y:0), size:Size(width: 0, height:0))
        field = Rectangle(rect:fieldRect, fillMode: .stroke)
        fieldLineThickness = LineWidth(width: 12)
        fieldCircle = Ellipse(center:Point(x:0,y:0), radiusX:50, radiusY: 50)
        strokeStyle = StrokeStyle(color:Color(.white))

        //goals
        let goal1Rect = Rect(topLeft: Point(x:0, y:0), size:Size(width: 0, height:0))
        goal1 = Rectangle(rect:goal1Rect, fillMode: .stroke)
        let goal2Rect = Rect(topLeft: Point(x:0, y:0), size:Size(width: 0, height:0))
        goal2 = Rectangle(rect:goal2Rect, fillMode: .stroke)

        //Goal boxes
        let goalBox1Rect = Rect(topLeft: Point(x:0, y:0), size:Size(width: 0, height:0))
        goalBox1 = Rectangle(rect:goalBox1Rect, fillMode: .stroke)
        let goalBox2Rect = Rect(topLeft: Point(x:0, y:0), size:Size(width: 0, height:0))
        goalBox2 = Rectangle(rect:goalBox2Rect, fillMode: .stroke)
    }

    func goalBoxBoundingRect(goalBox: Rect) -> Rect {
        return Rect(topLeft:Point(x:goalBox.topLeft.x, y: goalBox.topLeft.y), size:Size(width:goalBox.size.width, height:goalBox.size.height))
    }

    override func setup(canvasSize:Size, canvas: Canvas) {

        //field dimensions
        field.rect.topLeft = Point(x: canvasSize.center.x - 750, y: canvasSize.center.y - 300)
        field.rect.size = Size(width: 1500, height: 700)
        fieldCircle.center = Point(x:canvasSize.center.x, y:canvasSize.center.y + 50)

        //goal dimensions
        goal1.rect.topLeft = Point(x:field.rect.topLeft.x - 49, y:field.rect.topLeft.y + field.rect.size.center.y - 100)
        goal1.rect.size = Size(width: 50, height: 200)
        goal2.rect.topLeft = Point(x:field.rect.topLeft.x + field.rect.size.width - 1, y:field.rect.topLeft.y + field.rect.size.center.y - 100)
        goal2.rect.size = Size(width: 50, height: 200)

        //goal box dimensions
        goalBox1.rect.topLeft = Point(x:field.rect.topLeft.x, y:field.rect.topLeft.y + field.rect.size.center.y - 150)
        goalBox1.rect.size = Size(width: 100, height: 300)

        goalBox2.rect.topLeft = Point(x:field.rect.topLeft.x + field.rect.size.width - 100, y:field.rect.topLeft.y + field.rect.size.center.y - 150)
        goalBox2.rect.size = Size(width: 100, height: 300)
    }

    override func render(canvas:Canvas) {
        canvas.render(fieldLineThickness, strokeStyle, field, fieldCircle, goal1, goal2, goalBox1, goalBox2)
    }
}
