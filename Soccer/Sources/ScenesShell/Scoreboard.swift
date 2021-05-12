import Igis
import Scenes
import Foundation


class Scoreboard: RenderableEntity {
    var player1ScoreText : Text
    var player2ScoreText : Text
    let textFillStyle : FillStyle
    var player1Score : Int
    var player2Score : Int
    var field : Field
    let lineWidth : LineWidth
    var title1 : Text
    let title1FillStyle : FillStyle
    var title2 : Text
    let title2FillStyle : FillStyle
    init () {
        title1 = Text(location:Point(x:0, y:0), text:"Merlin", fillMode:.fill)
        title1FillStyle = FillStyle(color:Color(.red))
        title2 = Text(location:Point(x:0, y:0), text:"Soccer", fillMode:.fill)
        title2FillStyle = FillStyle(color:Color(.blue))
        lineWidth = LineWidth(width:1)
        player1Score = 0
        player2Score = 0
        field = Field()
        textFillStyle = FillStyle(color:Color(.white))
        player1ScoreText = Text(location:Point(x:field.field.rect.topLeft.x, y:field.field.rect.topLeft.y - 20), text:"Merlin: \(player1Score)", fillMode: .fill)
        player2ScoreText = Text(location:Point(x:0, y:0), text:"David Ben-Yaakov: \(player2Score)", fillMode: .fill)
    }

    func increasePlayer1Score() {
        player1Score += 1
    }

    func increasePlayer2Score() {
        player2Score += 1
    }

    override func setup(canvasSize:Size, canvas:Canvas) {
        /*
        player1ScoreText = Text(location:Point(x: canvasSize.center.x - canvasSize.center.x + 50, y: canvasSize.center.y - canvasSize.center.y + 50), text:"Merlin: \(player1Score)", fillMode: .fill)
        player2ScoreText = Text(location:Point(x:canvasSize.center.x + canvasSize.center.x - 400, y: canvasSize.center.y - canvasSize.center.y + 50), text:"David-Ben Yaakov: \(player2Score)", fillMode: .fill)
        canvas.render(textFillStyle,lineWidth,player1ScoreText, player2ScoreText)
        title1 = Text(location:Point(x:canvasSize.center.x - 160, y: canvasSize.center.y - canvasSize.center.y + 50), text:"Merlin", fillMode:.fill)
        title2 = Text(location:Point(x: canvasSize.center.x + 40, y: canvasSize.center.y - canvasSize.center.y + 50), text:"Soccer", fillMode:.fill)
        
         */
    }

    override func calculate(canvasSize:Size) {
        title1 = Text(location:Point(x:canvasSize.center.x - 160, y: canvasSize.center.y - canvasSize.center.y + 50), text:"Merlin", fillMode:.fill)
        title2 = Text(location:Point(x: canvasSize.center.x + 40, y: canvasSize.center.y - canvasSize.center.y + 50), text:"Soccer", fillMode:.fill)
        player1ScoreText = Text(location:Point(x: canvasSize.center.x - canvasSize.center.x + 50, y: canvasSize.center.y - canvasSize.center.y + 50), text:"Merlin: \(player1Score)", fillMode: .fill)
        player2ScoreText = Text(location:Point(x:canvasSize.center.x + canvasSize.center.x - 400, y: canvasSize.center.y - canvasSize.center.y + 50), text:"David-Ben Yaakov: \(player2Score)", fillMode: .fill)
        player1ScoreText.text = "Merlin: \(player1Score)"
        player2ScoreText.text = "David Ben-Yaakov: \(player2Score)"
    }

    override func render(canvas:Canvas) {
        title1.font = "50pt Luminari"
        canvas.render(lineWidth, title1FillStyle, title1, title2FillStyle, title2)
        player1ScoreText.font = "30pt Luminari"
        canvas.render(textFillStyle, player1ScoreText, player2ScoreText)
    }
}
