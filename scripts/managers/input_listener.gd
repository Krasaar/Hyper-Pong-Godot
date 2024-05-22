class_name InputListener extends Node

# create a keybind manager for storing keybind presets
# remembering active setups
# and use it to automatically populate  

static var singleton : InputListener

var registered_binder : MovementBinderControl

func _ready()->void:
	singleton = self
	set_process_unhandled_input(false)
	return

func _unhandled_key_input(event: InputEvent) -> void:
	if registered_binder == null: return
	# InputEventKey
	registered_binder.set_assigned_keycode(event.key_label)
	registered_binder = null
	set_process_unhandled_input(false)
	return
	
static func register_for_listen(binder_control : MovementBinderControl)->void:
	if singleton.registered_binder != null:
		singleton.registered_binder.mark_as_inactive()
	singleton.registered_binder = binder_control
	singleton.set_process_unhandled_input(true)
	return
	
static func stop_listening()->void:
	assert(singleton.registered_binder == null)
	singleton.set_process_unhandled_input(false)
	return
