class_name TeamSpawn extends Node

var player_spawns : Array[PlayerSpawn]
var goal : Goal

func _ready() -> void:
	goal = get_node("goal")
	for spawn in get_children():
		if spawn is PlayerSpawn:
			player_spawns.append(spawn)
	assert(player_spawns.size() != 0 || goal == null)
	return
	
func get_goal() -> Goal:
	return self.goal
	
func get_player_spawns() -> Array[PlayerSpawn]:
	return self.player_spawns
