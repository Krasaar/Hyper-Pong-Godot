class_name PlayerScore extends Control

@onready var player_name: Label = $score_info/player_name
@onready var score: Label = $score_info/score

func assign_player(player: Controller) -> void: 
	player_name.text = player.name
	player.score_label = self
	score.text = str(GameManager.get_match_manager().get_score_by_player(player))
	return

func update_score(value: int) -> void:
	score.text = str(value)
	return 
