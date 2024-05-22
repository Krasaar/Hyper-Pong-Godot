class_name Wall extends Node2D

var isHorizontal : bool
static var wall_id : int = 0

func _ready():
	self.isHorizontal = self.scale.x > self.scale.y
	self.set_name(str("wall_", wall_id))
	wall_id += 1
	return
	
func wall_bounce(ball : Ball):
	if isHorizontal :
		ball.vertical_bounce()
	else :
		ball.horizontal_bounce()
	return
