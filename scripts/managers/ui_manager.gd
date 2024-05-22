class_name UIManager extends Node

@onready var main_menu: Control = $CanvasLayer/main_menu
@onready var match_settings: Control = $CanvasLayer/match_settings
@onready var scoreboard: Scoreboard = $CanvasLayer/scoreboard
@onready var application_settings: Control = $CanvasLayer/application_settings

static var singleton : UIManager

func _ready() -> void:
	assert(singleton == null)
	singleton = self
	scoreboard.hide()
	match_settings.hide()
	return

func set_showcase_arena(arena: Arena)->void:
	main_menu.load_showcase_arena(arena)
	return
	
static func show_main_menu()->void:
	singleton.main_menu.show()
	singleton.application_settings.hide()
	singleton.match_settings.hide()
	GameManager.get_match_manager().resume_match()
	return
	
static func show_match_settings()->void:
	singleton.main_menu.hide()
	singleton.application_settings.hide()
	singleton.match_settings.show()
	singleton.match_settings.display_arena_previews()
	GameManager.get_match_manager().pause_match()
	return
	
static func show_application_settings()->void:
	singleton.main_menu.hide()
	singleton.match_settings.hide()
	singleton.application_settings.show()
	GameManager.get_match_manager().pause_match()
	return
	
func initialize_scoreboard(teams : Array[Team]) -> void:
	for team in teams :
		var team_scoreboard = scoreboard.create_team_scoreboard(team)
		for player in team.players_in_team :
			team_scoreboard.create_player_results(player)
	return

func _process(_delta: float) -> void:
	if Input.is_key_pressed(KEY_TAB) :
		scoreboard.show()
	else :
		scoreboard.hide()
	return
