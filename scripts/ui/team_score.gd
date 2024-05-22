class_name TeamScore extends Control

@onready var player_results: VBoxContainer = $player_results
@onready var team_name: Label = $player_results/team_name


func set_team_name(_name: String) -> void :
	team_name.text = _name
	return

func create_player_results(player: Controller) -> void:
	var player_score : PlayerScore = GameManager.instantiate(preload("res://scenes/ui/player_score.tscn"))
	player_results.add_child(player_score)
	player_score.assign_player(player)
	return
