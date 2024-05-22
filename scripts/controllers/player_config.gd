class_name PlayerConfig

var name : String
var controls : Controls
var team : Team

class Controls:
	var UP : Key
	var DOWN : Key
	var LEFT : Key
	var RIGHT : Key

func assign_keycode(direction: MovementBinderControl.MovementDirection, keycode: Key)->void:
	match direction:
		MovementBinderControl.MovementDirection.UP:
			controls.UP = keycode
		MovementBinderControl.MovementDirection.DOWN:
			controls.DOWN = keycode
		MovementBinderControl.MovementDirection.LEFT:
			controls.LEFT = keycode
		MovementBinderControl.MovementDirection.RIGHT:
			controls.RIGHT = keycode
	
