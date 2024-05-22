class_name PlayerController extends Controller

var UP : Key
var DOWN : Key
var LEFT : Key
var RIGHT : Key
var paddle : Paddle

func assign_config_data(config: PlayerConfig):
	team = config.team
	UP = config.controls.UP
	DOWN = config.controls.DOWN
	LEFT = config.controls.LEFT
	RIGHT = config.controls.RIGHT
	name = config.name
	return
	
func _ready():
	self.base_on_ready()
	paddle = self.get_paddle()
	return

func assign_keybind_preset(active_players: int, layout: KeybindManager.KeybindLayout = KeybindManager.KeybindLayout.INVALID):
	var keybinds
	
	if layout == KeybindManager.KeybindLayout.INVALID:
		keybinds = KeybindManager.get_keybinds_by_player_number(active_players)
	else:
		keybinds = KeybindManager.get_keybinds_by_layout(layout)
		
	for direction in keybinds:
		match (direction as KeybindManager.Direction):
			KeybindManager.Direction.UP:
				UP = keybinds[direction]
			KeybindManager.Direction.DOWN:
				DOWN = keybinds[direction]
			KeybindManager.Direction.LEFT:
				LEFT = keybinds[direction]
			KeybindManager.Direction.RIGHT:
				RIGHT = keybinds[direction]
	return
	
func _on_update(delta)->void:
	# var xAxis = Input.get_axis("move_left", "move_right") * delta
	# var yAxis = Input.get_axis("move_up", "move_down") * delta
	var xAxis = Vector2(Input.is_key_pressed(LEFT), Input.is_key_pressed(RIGHT)) * delta
	var yAxis = Vector2(Input.is_key_pressed(UP), Input.is_key_pressed(DOWN)) * delta
	paddle.move_in_direction(xAxis, yAxis)
	
	if Input.is_key_pressed(KEY_O):
		if !paddle.paddle_resized:
			paddle.resize_paddle(2)
		paddle.paddle_resized = true
	else: if Input.is_key_pressed(KEY_P):
		if !paddle.paddle_resized:
			paddle.resize_paddle(0.5)
		paddle.paddle_resized = true
	else:
		if paddle.paddle_resized:
			paddle.reset_paddle_size()
		paddle.paddle_resized = false
	return
