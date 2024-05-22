class_name Scoreboard extends Control

@onready var teams: HFlowContainer = $teams

func create_team_scoreboard(team: Team) -> TeamScore:
	var team_score : TeamScore = GameManager.instantiate(preload("res://scenes/ui/team_score.tscn"))
	teams.add_child(team_score)
	team_score.set_team_name(team.name)
	return team_score
