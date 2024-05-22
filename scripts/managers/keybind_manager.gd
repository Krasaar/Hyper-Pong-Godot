class_name KeybindManager #extends Node

enum Direction {
	UP,
	DOWN,
	LEFT,
	RIGHT
}
enum KeybindLayout {
	INVALID,
	WSAD,
	IJKL,
	ARROWS,
	NUM_PAD_8546
}
static var assigned_keybinds = {}

const default_layout_by_player_amount = {
	1:KeybindLayout.WSAD,
	2:KeybindLayout.ARROWS,
	3:KeybindLayout.IJKL,
	4:KeybindLayout.NUM_PAD_8546,
}

const presets = {
	KeybindLayout.WSAD: {
		Direction.UP: KEY_W,
		Direction.DOWN: KEY_S,
		Direction.LEFT: KEY_A,
		Direction.RIGHT: KEY_D,
	},
	KeybindLayout.IJKL: {
		Direction.UP: KEY_I,
		Direction.DOWN: KEY_K,
		Direction.LEFT: KEY_J,
		Direction.RIGHT: KEY_L,
	},
	KeybindLayout.NUM_PAD_8546: {
		Direction.UP: KEY_KP_8,
		Direction.DOWN: KEY_KP_2,
		Direction.LEFT: KEY_KP_4,
		Direction.RIGHT: KEY_KP_6,
	},
	KeybindLayout.ARROWS: {
		Direction.UP: KEY_UP,
		Direction.DOWN: KEY_DOWN,
		Direction.LEFT: KEY_LEFT,
		Direction.RIGHT: KEY_RIGHT,
	},
}

static func get_keybinds_by_player_number(active_players: int):
	if active_players > 4:
		# take first as default
		return presets[KeybindLayout.WSAD]
	else:
		var layout = default_layout_by_player_amount[active_players]
		return presets[layout]

static func get_keybinds_by_layout(layout: KeybindLayout):
	return presets[layout]

