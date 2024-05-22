class_name MatchManager extends Node

var team_score_board = {}
var score_by_player = {}
var state_of_balls = {}
var teams : Array[Team]
var restarting : bool = false

var arena_manager : ArenaManager
var player_manager : PlayerManager
var ui_manager : UIManager

func initialize() -> void:
	arena_manager = GameManager.get_arena_manager()
	player_manager = GameManager.get_player_manager()
	ui_manager = GameManager.get_ui_manager()
	pause_match()
	return 

func _physics_process(delta: float) -> void:
	for ball in state_of_balls.keys():
		if !state_of_balls[ball]:
			state_of_balls.erase(ball)
			continue
		
		(ball as Ball).update(delta)
		
	player_manager.update_controllers(delta)
	# for each controller in 
	return

func prepare_showcase_match()->void:
	var ziemniaki = Team.new("CZKFC")
	var ziemniak_player = GameManager.instantiate(preload("res://scenes/controllers/bot_controller.tscn"))
	score_by_player[ziemniak_player] = 0
	ziemniaki.add_player(ziemniak_player)
	
	register_team(ziemniaki)
	
	var boty = Team.new("SZKFC")
	var bot_player = GameManager.instantiate(preload("res://scenes/controllers/bot_controller.tscn"))
	score_by_player[bot_player] = 0
	boty.add_player(bot_player)
	
	register_team(boty)
	return

func start_showcase_game()->void:
	# TODO here!!!!
	var current_arena : Arena = arena_manager.get_showcase_arena()
	current_arena.prepare_for_match()
	for team in teams :
		var team_spawn : TeamSpawn = current_arena.get_available_team_spawn()
		assert(team_spawn != null)
		
		# arena's data should be passed forward to UI elements
		# through which players should be initialized in opposite to the old way
		team_spawn.get_goal().assign_team(team)
		var player_spawns :Array[PlayerSpawn] = team_spawn.get_player_spawns()
		for i in player_spawns.size() :
			var paddle = player_manager.initialize_player(player_spawns[i], team.players_in_team[i])
			current_arena.add_child(paddle)
	randomize_ball_direction()
	
	arena_manager.set_current_arena(current_arena)
	ui_manager.initialize_scoreboard(teams)
	ui_manager.set_showcase_arena(current_arena)
	
	resume_match()
	return

func pause_match()->void:
	set_physics_process(false)
	return

func resume_match()->void:
	set_physics_process(true)
	return

func start_game(selected_arena: String)->void:
	# clear ball state / currently playing players / score
	# "arena_1v1"
	
	arena_manager.load_arena_by_name(selected_arena)
	var current_arena : Arena = arena_manager.get_current_arena()
	current_arena.prepare_for_match()
	for team in teams :
		var team_spawn : TeamSpawn = current_arena.get_available_team_spawn()
		assert(team_spawn != null)
		
		# arena's data should be passed forward to UI elements
		# through which players should be initialized in opposite to the old way
		team_spawn.get_goal().assign_team(team)
		var player_spawns :Array[PlayerSpawn] = team_spawn.get_player_spawns()
		for i in player_spawns.size() :
			var paddle = player_manager.initialize_player(player_spawns[i], team.players_in_team[i])
			current_arena.add_child(paddle)
	randomize_ball_direction()
		
	ui_manager.initialize_scoreboard(teams)
	ui_manager.set_showcase_arena(current_arena)
	return
	
func get_closest_ball(position: Vector2) -> Ball:
	if restarting : return null
	var shortest_distance : float = -1.0
	var closest_ball : Ball
	
	for ball in state_of_balls :
		# if ball == null || (ball as Ball).is_queued_for_deletion() : return null
		if !state_of_balls[ball] : continue
		
		var temp_distance = position.distance_to(ball.position)
		if shortest_distance >= 0 && shortest_distance <= temp_distance : continue
		
		shortest_distance = temp_distance
		closest_ball = ball
	return closest_ball
	
func register_ball(ball: Ball) -> void :
	state_of_balls[ball] = true
	return
	
func register_team(team: Team):
	teams.append(team)
	team_score_board[team] = 0
	return
	
func begin_kick_off():
	restarting = true
	player_manager.stop_bots()
	for old_ball in state_of_balls:
		old_ball.free()
	state_of_balls.clear()
	arena_manager.call_deferred("respawn_balls")
	player_manager.call_deferred("start_bots")
	restarting = false
	call_deferred("randomize_ball_direction")
	# get_tree().call_deferred("reload_current_scene")
	return

func randomize_ball_direction() -> void:
	for ball in state_of_balls:
		var random_player : Paddle = player_manager.get_random_player()
		(ball as Ball).aim_at_position(random_player.position)
	return

func mark_ball_for_removal(ball: Ball):
	if state_of_balls.size() == 1:
		begin_kick_off()
	else : 
		state_of_balls[ball] = false
		ball.queue_free()
		for _ball in state_of_balls:
			if state_of_balls[_ball] == true:
				return
		
		state_of_balls.clear()
		begin_kick_off()
	return
	
func register_score_except(_team: Team):
	for team in team_score_board:
		if team == _team: continue
		team_score_board[team] += 1
	return
	
func register_score(player: Controller):
	team_score_board[player.team]+=1
	score_by_player[player]+=1
	player.score_label.update_score(score_by_player[player])
	return
	
func clear_score_board():
	team_score_board.clear()
	return
	
#func associate_score_with_player(score : PlayerScore, controller : Controller) -> void:
	#score_by_player	
	#return
	
func get_score_by_player(controller: Controller) -> int:
	return score_by_player[controller]
