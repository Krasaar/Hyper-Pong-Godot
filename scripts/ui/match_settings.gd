extends Control

@onready var arena_display: Control = $arena_display
@onready var start_match_button: Button = $start_match_button
@onready var background_2: ColorRect = $arena_display/background2
@onready var arena_name_label: Label = $arena_name

var previews_data = {}
var currently_selected_preview : int = 0
var current_preview : ArenaPreview

func _ready() -> void:
	start_match_button.set_disabled(true)
	background_2.free()
	return

func _on_ready()->void:
	var previews = ArenaManager.get_arena_previews()
	for arena_name in previews : 
		var arena_preview : ArenaPreview = (previews[arena_name] as ArenaPreview)
		var preview_size = arena_preview.area_size
		var preview_target_scale = arena_display.size / preview_size
		arena_preview.set_scale(preview_target_scale)
		arena_preview.hide()
		arena_display.add_child(arena_preview)
		previews_data[currently_selected_preview] = arena_name
		currently_selected_preview += 1
	
	currently_selected_preview = 0
	arena_name_label.text = previews_data[currently_selected_preview]
	current_preview = arena_display.get_child(0)
	return

func display_arena_previews()->void:
	current_preview.show()
	return
	
func _on_return_button_button_up() -> void:
	UIManager.show_main_menu()
	return

func _on_previous_arena_button_button_up() -> void:
	current_preview.hide()
	currently_selected_preview -= 1
	if currently_selected_preview < 0:
		currently_selected_preview = previews_data.size() - 1
		
	arena_name_label.text = previews_data[currently_selected_preview]
	current_preview = arena_display.get_child(currently_selected_preview)
	current_preview.show()
	return

func _on_next_arena_button_button_up() -> void:
	current_preview.hide()
	currently_selected_preview += 1
	if currently_selected_preview == previews_data.size():
		currently_selected_preview = 0
		
	arena_name_label.text = previews_data[currently_selected_preview]
	current_preview = arena_display.get_child(currently_selected_preview)
	current_preview.show()
	return

func _on_start_match_button_button_up() -> void:
	return
