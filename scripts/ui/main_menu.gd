extends Control

@onready var showcase_arena: ColorRect = $showcase_arena

func _on_play_button_button_up() -> void:
	UIManager.show_match_settings()
	return

func _on_settings_button_button_up() -> void:
	# display application settings ui view
	UIManager.show_application_settings()
	return

func _on_exit_button_button_up() -> void:
	# send notification to all nodes about incoming app termination
	# to perform final operations before quitting
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	GameManager.quit()
	return

func load_showcase_arena(arena: Arena)->void:
	_clear_showcase_arena()
	# arena.apply_scale(showcase_arena.scale)
	arena.reparent(showcase_arena)
	arena.set_scale(Vector2.ONE)
	arena.position.x = 31.776
	arena.position.y = 24.299
	return

func _clear_showcase_arena()->void:
	for child in showcase_arena.get_children():
		child.free()
	return
