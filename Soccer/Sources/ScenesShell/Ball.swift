import Scenes
import Igis
import Foundation

class Ball : RenderableEntity {
    var ellipse = Ellipse(center:Point(x:0, y:0), radiusX:10, radiusY:10, fillMode:.fillAndStroke)
    let strokeStyle = StrokeStyle(color:Color(.black))
    let fillStyle = FillStyle(color:Color(.white))
    var velocity : Point 
    init () {
        velocity = Point(x:0, y:0)
    }

    public func changeVelocity(velocityX:Int, velocityY:Int) {
        self.velocity.x = velocityX
        self.velocity.y = velocityY
    }

    override func setup(canvasSize: Size, canvas: Canvas) {
        // Position the ellipse at the center of the canvas
        ellipse.center = InteractionLayer.field.fieldCircle.center
    }

    override func boundingRect() -> Rect {
        let left = ellipse.center.x - ellipse.radiusX
        let top = ellipse.center.y - ellipse.radiusY

        let width = ellipse.radiusX * 2
        let height = ellipse.radiusY * 2

        return Rect(topLeft:Point(x: left, y: top), size:Size(width:width, height:height)) 
    }

    override func calculate(canvasSize: Size) {
        //move ball
        ellipse.center += velocity

        let fieldBoundingRect = InteractionLayer.field.field.rect

        // Form a bounding rect around the ball (ellipse)
        let ballBoundingRect = Rect(topLeft:Point(x:ellipse.center.x-ellipse.radiusX, y:ellipse.center.y-ellipse.radiusY),
                                    size:Size(width:ellipse.radiusX*2, height:ellipse.radiusY*2))

        // Determine if we've moved outside of the canvas boundary rect
        let tooFarLeft = ballBoundingRect.topLeft.x < fieldBoundingRect.topLeft.x
        let tooFarRight = ballBoundingRect.topLeft.x + ballBoundingRect.size.width > fieldBoundingRect.topLeft.x + fieldBoundingRect.size.width

        let tooFarUp = ballBoundingRect.topLeft.y < fieldBoundingRect.topLeft.y
        let tooFarDown = ballBoundingRect.topLeft.y + ballBoundingRect.size.height > fieldBoundingRect.topLeft.y + fieldBoundingRect.size.height

        if tooFarLeft || tooFarRight {
            velocity.x = -velocity.x
        }

        if tooFarUp || tooFarDown {
            velocity.y = -velocity.y
        }
    }
    
    override func render(canvas:Canvas) {
        canvas.render(strokeStyle, fillStyle, ellipse)
    }
}
