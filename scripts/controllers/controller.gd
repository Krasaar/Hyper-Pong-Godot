class_name Controller extends Node

var _update : Callable
var team : Team
var score_label : PlayerScore
var _paddle : Paddle

func base_on_ready():
	_update = Callable(self, "_on_update")
	assert(_update != null, str(self, "does not implement delegate"))
	_paddle = self.get_parent()
	return

func update(delta: float)->void:
	_update.call(delta)
	return

func get_paddle()->Paddle:
	return _paddle

func set_team(_team : Team) -> void:
	self.team = _team
	return
