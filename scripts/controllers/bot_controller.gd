class_name BotController extends Controller

@onready var move_timer : Timer = $move_timer

var closest_ball_position : Vector2 = Vector2.INF
var asleep : bool = true
const SPEED : float = 350.0
const sight_distance : float = 600
var paddle : Paddle

func _ready():
	self.base_on_ready()
	paddle = self.get_paddle()
	# collider.shape.ext paddle.faced_direction
	move_timer.start()
	return

func is_ball_getting_closer(ball_direction : Vector2) -> bool:
	match paddle.faced_direction:
		Vector2.UP:
			return ball_direction.y > 0
		Vector2.DOWN:
			return ball_direction.y < 0
		Vector2.LEFT:
			return ball_direction.x > 0
		Vector2.RIGHT:
			return ball_direction.x < 0
	return false
	
func search_for_closest_ball_in_sight() -> void:
	var closest_ball : Ball = GameManager.get_match_manager().get_closest_ball(paddle.position)
	if closest_ball == null : return
	closest_ball_position = Vector2.INF
	if !is_ball_getting_closer(closest_ball.direction): return
	
	match paddle.faced_direction:
		Vector2.UP:
			if closest_ball.position.y >= paddle.position.y - sight_distance:
				closest_ball_position = closest_ball.position
		Vector2.DOWN:
			if closest_ball.position.y <= paddle.position.y + sight_distance:
				closest_ball_position = closest_ball.position
		Vector2.LEFT:
			var paddlex = paddle.position.x
			var ballx = closest_ball.position.x
			if paddlex - ballx <= sight_distance:
				closest_ball_position = closest_ball.position
		Vector2.RIGHT:
			if closest_ball.position.x - paddle.position.x <= sight_distance:
				closest_ball_position = closest_ball.position
	#var ballx = closest_ball.position.x
	#var bally = closest_ball.position.y
	#
	#if paddle.faced_direction == Vector2.DOWN && closest_ball.direction.y < 0 :
		#if bally - paddle.position.y <= sight_distance : 
			#closest_ball_position = closest_ball.position
			#return
	#else : if paddle.faced_direction == Vector2.UP && closest_ball.direction.y > 0 :
		#if paddle.position.y - bally <= sight_distance : 
			#closest_ball_position = closest_ball.position
			#return
	#else : if paddle.faced_direction == Vector2.RIGHT && closest_ball.direction.x < 0 :
		#if bally - paddle.position.y <= sight_distance : 
			#closest_ball_position = closest_ball.position
			#return
	#else : #if paddle.faced_direction == Vector2.LEFT && closest_ball.direction.x > 0 :
		#if paddle.position.x - ballx <= sight_distance : 
			#closest_ball_position = closest_ball.position
			#return
	return
	
func _on_move_timer_timeout() -> void:
	search_for_closest_ball_in_sight()
	return

func is_paddle_vertical() -> bool:
	match paddle.faced_direction:
		Vector2.RIGHT, Vector2.LEFT:
			return true
		_: 
			return false


func is_difference_significant(delta: float)->bool:
	if is_paddle_vertical():
		if closest_ball_position.y < paddle.position.y - SPEED * delta || closest_ball_position.y > paddle.position.y + SPEED * delta:
			return true
		else : 
			# slightly adjust paddle's position to avoid jumpy movement
			return false
	else:
		if closest_ball_position.x < paddle.position.x - SPEED * delta || closest_ball_position.x > paddle.position.x + SPEED * delta:
			return true
		else : 
			# slightly adjust paddle's position to avoid jumpy movement
			return false
		
func update_vertical_position(desired_location: Vector2, delta: float) -> void:
	if desired_location.y > paddle.position.y:
		var temp_y_position = paddle.position.y + delta * SPEED
		if temp_y_position > desired_location.y:
			paddle.position.y = desired_location.y
			return
		paddle.position.y = temp_y_position
	else :
		var temp_y_position = paddle.position.y - delta * SPEED
		if temp_y_position < desired_location.y:
			paddle.position.y = desired_location.y
			return
		paddle.position.y = temp_y_position
	return
	
func update_horizontal_position(desired_location: Vector2, delta: float) -> void:
	if (desired_location.x > paddle.position.x) :
		var temp_x_position = paddle.position.x + delta * SPEED
		if temp_x_position > desired_location.x:
			paddle.position.x = desired_location.x
			return
		paddle.position.x = temp_x_position
	else :
		var temp_x_position = paddle.position.x - delta * SPEED
		if temp_x_position < desired_location.x:
			paddle.position.x = desired_location.x
			return
		paddle.position.x = temp_x_position
	return

func move_towards_spawn_position(delta: float) -> void:
	if is_paddle_vertical():
		update_vertical_position(paddle.spawn_position, delta)
	else:
		update_horizontal_position(paddle.spawn_position, delta)
	return
	
func move_towards_ball_position(delta: float) -> void:
	if is_paddle_vertical():
		update_vertical_position(closest_ball_position, delta)
	else:
		update_horizontal_position(closest_ball_position, delta)
	return
	
func _on_update(delta: float) -> void:
	if closest_ball_position == Vector2.INF: 
		move_towards_spawn_position(delta)
		return
		
	if !is_difference_significant(delta): return
		
	move_towards_ball_position(delta)
	return
