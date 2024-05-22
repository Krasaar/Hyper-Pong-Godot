class_name PlayerManager extends Node
var controller_count : int
var player_count : int
var bot_count : int

var all_controllers : Array[Controller]
var players : Array[PlayerController]
var bots : Array[BotController]

var rng : RandomNumberGenerator = RandomNumberGenerator.new()

var directions = {
	Vector2.RIGHT: null,
	Vector2.LEFT: null,
	Vector2.DOWN: null,
	Vector2.UP: null,
}

func _ready():
	self.player_count = 0
	self.controller_count = 0
	self.bot_count = 0
	return

func update_controllers(delta: float)->void:
	for controller in all_controllers:
		controller.update(delta)
	return

func initialize_player(player_spawn : PlayerSpawn, controller : Controller) -> Paddle :
	var paddle : Paddle = preload("res://scenes/arena_elements/paddle.tscn").instantiate()
	paddle.assign_controller(controller)
	player_spawn.set_player_pos(paddle)
	
	#var faced_direction : Vector2i
	#for direction in directions:
		#if (directions[direction] == null):
			#directions[direction] = paddle
			#faced_direction = direction
			#break
	#paddle.face_direction(faced_direction)
	paddle.initialize_paddle()
	
	if controller is PlayerController:
		players.append(controller)
		self.player_count += 1
		controller.assign_keybind_preset(player_count)
		
		# get player config corresponding to arena's setup
		
	elif controller is BotController :
		paddle.set_name(str("bot_", self.bot_count))
		bots.append(controller)
		self.bot_count += 1
	
	all_controllers.append(controller)
	controller_count += 1
	return paddle

func stop_bots() -> void :
	for bot in bots:
		bot.get_paddle().set_physics_process(false)
		bot.move_timer.stop()
	return

func start_bots() -> void:
	for bot in bots:
		bot.get_paddle().set_physics_process(true)
		bot.move_timer.start()
	return
	
func get_random_player() -> Paddle:
	#var child_count = players.get_child_count()
	
	if controller_count == 0: 
		print("no player found")
		return
		
	var index = rng.randi_range(0, controller_count - 1)
	return all_controllers[index].get_paddle()
