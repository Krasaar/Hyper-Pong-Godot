@tool
class_name MovementBinderControl extends Control

@onready var direction_arrow: TextureRect = $direction_arrow
@onready var dim: ColorRect = $dim
@onready var keycode_name: Label = $keycode

const dim_alpha : int = 170
const active_alpha : int = 40
var assigned_keycode : Key

enum MovementDirection {
	INVALID = -1, UP, RIGHT, DOWN, LEFT
}

@export var movement_direction : MovementDirection:
	get:
		return movement_direction
	set(value):
		var is_loaded : bool = true
		movement_direction = value
		match movement_direction:
			MovementDirection.UP:
				_set_assigned_keycode(KEY_W)
			MovementDirection.RIGHT:
				_set_assigned_keycode(KEY_D)
			MovementDirection.DOWN:
				_set_assigned_keycode(KEY_S)
			MovementDirection.LEFT:
				_set_assigned_keycode(KEY_A)
			_: 
				is_loaded = false
		if !is_loaded: return
		_rotate_arrow_deferred()

func _rotate_arrow_deferred()->void:
	if direction_arrow == null:
		call_deferred("_rotate_arrow_deferred")
		return
	direction_arrow.set_rotation_degrees(90 * movement_direction)
	return

func _on_dim_gui_input(event: InputEvent) -> void:
	if dim.color.a8 == active_alpha: return
	if !(event is InputEventMouseButton): return
	if event.button_index != MOUSE_BUTTON_LEFT: return
	if !event.is_released(): return
	mark_as_active()
	InputListener.register_for_listen(self)
	return

func _set_assigned_keycode(keycode: Key)->void:
	assigned_keycode = keycode
	set_label_text_deferred()
	return

func set_label_text_deferred()->void:
	if keycode_name == null:
		call_deferred("set_label_text_deferred")
		return
	keycode_name.text = char(assigned_keycode)
	return

func set_assigned_keycode(keycode: Key)->void:
	_set_assigned_keycode(keycode)
	mark_as_inactive()
	return
	
func mark_as_inactive()->void:
	dim.color.a8 = dim_alpha
	return
	
func mark_as_active()->void:
	dim.color.a8 = active_alpha
	return

func get_movement_direction()->MovementDirection:
	return movement_direction
	
func get_assigned_keycode()->Key:
	return assigned_keycode

func update_arrow_rotation()->void:
	if direction_arrow == null: return
	direction_arrow.pivot_offset = direction_arrow.size / 2
	return
	#
func _on_direction_arrow_resized() -> void:
	update_arrow_rotation()
	return
