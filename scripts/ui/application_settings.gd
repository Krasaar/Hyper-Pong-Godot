extends Control

var default_audio_value : float = 69.0
@onready var sound: HSlider = $sound

func _ready() -> void:
	sound.value = default_audio_value
	return

func _on_return_button_button_up() -> void:
	UIManager.show_main_menu()
	return 

func _on_default_audio_button_up() -> void:
	sound.value = default_audio_value
	return

func _on_sound_value_changed(value: float) -> void:
	#update audio manager values
	print("new audio volume: ", value)
	return
