class_name Arena extends Node2D

@export var arena_name : String

var background : Sprite2D
var walls : Node
var team_spawns : Node
var ball_spawns : Node
var occupied_spawns = {}

func _ready() -> void:
	walls = get_node("walls")
	team_spawns = get_node("team_spawns")
	ball_spawns = get_node("ball_spawns")
	background = get_node("background")
	return

func get_ball_spawn_positions()->Array[Vector2]:
	var positions : Array[Vector2] = []
	for ball_spawn in ball_spawns.get_children():
		if ball_spawn is BallSpawn:
			positions.push_back(ball_spawn.position)
	return positions

func spawn_arena_preview()->ArenaPreview:
	var preview : ArenaPreview = preload("res://scenes/ui/arena_preview.tscn").instantiate()
	
	preview.set_background(background)
	preview.set_walls(walls.get_children())
	preview.set_team_spawns(team_spawns.get_children())
	preview.set_ball_spawns(ball_spawns.get_children())
	
	return preview
	
func prepare_for_match()->void:
	for team_spawn in team_spawns.get_children():
		assert (team_spawn is TeamSpawn)
		occupied_spawns[team_spawn] = false
	
	respawn_balls()
	return

func respawn_balls() -> void:
	for ball_spawn in ball_spawns.get_children():
		assert (ball_spawn is BallSpawn)
		self.add_child(ball_spawn.spawn_ball())
	return

func get_available_team_spawn() -> TeamSpawn:
	for spawn in occupied_spawns:
		if occupied_spawns[spawn]: continue
		occupied_spawns[spawn] = true
		return spawn
	return null
