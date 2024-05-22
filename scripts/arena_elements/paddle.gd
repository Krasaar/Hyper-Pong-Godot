class_name Paddle extends CharacterBody2D	

@onready var paddle_resizable 	 : Sprite2D = $paddle_resizable
@onready var paddle_side_0 		 : Sprite2D = $paddle_side_0
@onready var paddle_side_1 		 : Sprite2D = $paddle_side_1
@onready var collider			 : CollisionShape2D = $collider

var paddle_resized : bool = false
var DEFAULT_SCALE : Vector2
var faced_direction : Vector2
const SPEED : float = 350.0
var controller : Controller
var spawn_position : Vector2
	
func assign_controller(_controller : Controller) : 
	self.add_child(_controller)
	self.controller = _controller
	return
	
func face_direction(direction : Vector2i) :
	self.faced_direction = direction
	return

func initialize_paddle():
	if paddle_resizable == null :
		call_deferred("initialize_paddle")
		return
	DEFAULT_SCALE = paddle_resizable.scale
	return

func resize_paddle(multiplier):
	paddle_resizable.scale.x *= multiplier
	adjust_paddle_location()
	return
	
func reset_paddle_size():
	paddle_resizable.scale = DEFAULT_SCALE
	adjust_paddle_location()
	return
	
func adjust_paddle_location():
	var paddle_size = paddle_resizable.get_rect().size
	var paddle_offset = paddle_size.y / 2 * paddle_resizable.scale.x
	paddle_side_0.position.y = -paddle_offset
	paddle_side_1.position.y = paddle_offset
	var extents = Vector2(paddle_size.x / 2, paddle_offset + paddle_side_0.get_rect().size.x / 4 + paddle_side_1.get_rect().size.x / 4)
	# collider.shape.extents = extents
	collider.shape.set("Size", extents)
	return
	
	# apply buffs / debuffs 
	# bounce the ball off 
	# etc...
func paddle_bounce(ball : Ball):
	# up / down / left / right
	ball.register_last_player_touched(self.controller)
	
	if faced_direction == Vector2.RIGHT || faced_direction == Vector2.LEFT:
		ball.horizontal_bounce()
	else : if faced_direction == Vector2.UP || faced_direction == Vector2.DOWN :
		ball.vertical_bounce()
	return
	
func move_in_direction(xAxis : float, yAxis : float) :
	self.position.x += xAxis * self.SPEED
	self.position.y += yAxis * self.SPEED
	return
