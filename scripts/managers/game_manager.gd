class_name GameManager extends Node

static var singleton : GameManager
var player_manager : PlayerManager
var arena_manager : ArenaManager
var ui_manager : UIManager
var match_manager : MatchManager

const CURSOR_ICON_CLICK = preload("res://assets/cursors/CursorIconClick.png")
const CURSOR_ICON_NORMAL = preload("res://assets/cursors/CursorIconNormal.png")

func _ready():
	assert(singleton == null)
	singleton = self
	
	player_manager = get_node("player_manager")
	arena_manager = get_node("arena_manager")
	ui_manager = get_node("ui_manager")
	match_manager = get_node("match_manager")
	return

func set_normal_cursor()->void:
	Input.set_custom_mouse_cursor(CURSOR_ICON_NORMAL, Input.CURSOR_ARROW )
	return
	
func set_on_click_cursor()->void:
	Input.set_custom_mouse_cursor(CURSOR_ICON_CLICK, Input.CURSOR_ARROW )
	return
	
static func get_arena_manager() -> ArenaManager:
	return singleton.arena_manager
	
static func get_player_manager() -> PlayerManager:
	return singleton.player_manager
	
static func get_ui_manager() -> UIManager:
	return singleton.ui_manager

static func get_match_manager() -> MatchManager:
	return singleton.match_manager

func _on_ready() -> void:
	match_manager.initialize()
	UIManager.show_main_menu()
	match_manager.prepare_showcase_match()
	match_manager.start_showcase_game()
	return
		
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("lmb_click"):
		set_on_click_cursor()
	elif Input.is_action_just_released("lmb_click"):
		set_normal_cursor()
	return
	
static func get_group(_name : String) -> Array[Node]:
	return singleton.get_tree().get_nodes_in_group(_name)

static func instantiate(resource : Resource) -> Node : 
	return resource.instantiate()

static func quit()->void:
	singleton.get_tree().quit()
