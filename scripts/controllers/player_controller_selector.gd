extends Control

@onready var player_selector: ColorRect = $HBoxContainer/player_selector
@onready var bot_selector: ColorRect = $HBoxContainer/bot_selector
@onready var keybinds: HBoxContainer = $HBoxContainer/player_selector/keybinds

static var temp : InputListener

func _ready() -> void:
	if temp == null:
		temp = InputListener.new()
		temp._ready()
		add_child(temp)
	return

var alpha : int = 170
var currently_selected : ColorRect
func is_player_controller()->bool:
	return player_selector.color.a != 0

func is_left_pressed(event: InputEvent)->bool:
	return event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT
	
func _on_bot_selector_gui_input(event: InputEvent) -> void:
	if currently_selected == bot_selector: return
	if !is_left_pressed(event): return
	player_selector.color.a8 = alpha
	bot_selector.color.a8 = 0
	keybinds.hide()
	return

func _on_player_selector_gui_input(event: InputEvent) -> void:
	if currently_selected == player_selector: return
	if !is_left_pressed(event): return
	bot_selector.color.a8 = alpha
	player_selector.color.a8 = 0
	keybinds.show()
	return
	
func update_config(config: PlayerConfig):
	for movement_binder in keybinds.get_children():
		if movement_binder is MovementBinderControl:
			var key = movement_binder.get_assigned_keycode()
			var direction = movement_binder.get_movement_direction()
			config.assign_keycode(direction, key)
