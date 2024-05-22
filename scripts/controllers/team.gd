class_name Team

var players_in_team : Array[Controller]
var name : String

func _init(_name : String ):
	self.name = _name
	return
	
func add_player(player : Controller):
	players_in_team.append(player)
	player.set_team(self)
	return
