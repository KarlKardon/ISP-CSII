import Scenes
import Igis
import Foundation

class Ball : RenderableEntity {
    var ellipse = Ellipse(center:Point(x:0, y:0), radiusX:15, radiusY:15, fillMode:.fillAndStroke)
    let strokeStyle = StrokeStyle(color:Color(.black))
    let fillStyle = FillStyle(color:Color(.white))
    var velocity : Point
    let targetXVelocity = 10
    let targetYVelocity = 3
    let lineWidth = LineWidth(width:3)
    init () {
        velocity = Point(x:0, y:0)
    }

    
    override func setup(canvasSize: Size, canvas: Canvas) {
        // Position the ellipse at the center of the canvas
        ellipse.center = InteractionLayer.field.fieldCircle.center
    }

    //bounding rect for containment
    override func boundingRect() -> Rect {
        let left = ellipse.center.x - ellipse.radiusX
        let top = ellipse.center.y - ellipse.radiusY

        let width = ellipse.radiusX * 2
        let height = ellipse.radiusY * 2

        return Rect(topLeft:Point(x: left, y: top), size:Size(width:width, height:height)) 
    }

    //calculates ball physics and movement
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

        if velocity.x < 0 {
            while velocity.x < -targetXVelocity {
                velocity.x += 1
            }
        } else {
            if velocity.x > 0 {
                while velocity.x > targetXVelocity {
                    velocity.x -= 1
                }
            }
        }

        if velocity.x > targetXVelocity * 2 || velocity.x < targetXVelocity * -2{
            velocity.x = targetXVelocity
        }
    }

    func move(to point:Point) {
        ellipse.center = point
    }

    
    override func render(canvas:Canvas) {
        canvas.render(lineWidth, strokeStyle, fillStyle, ellipse)
    }
}
