class_name Ball extends Area2D

var direction : Vector2 = Vector2(0,0)
var velocity : float = 250
var last_collider : String = ""
var recent_colliders = {}

var old_last_team_touched : Team
var last_team_touched : Team

var old_last_players_touching : Array[Controller]
var last_players_touching : Array[Controller]

# used to clamp ball position inside playable arena
var constraints : Vector2

func aim_at_position(_position : Vector2) -> void :
	self.direction = self.position.direction_to(_position)
	return

func update(delta: float):
	self.position += direction * delta * velocity
	return
	
#func _physics_process(delta):
	#update(delta)
	#return
	
func vertical_bounce():
	direction.y *= -1
	return
	
func horizontal_bounce():
	direction.x *= -1
	return
	 
func register_last_player_touched(controller : Controller) -> void :
	
	if last_team_touched != controller.team :
		old_last_team_touched = last_team_touched
		last_team_touched = controller.team
		old_last_players_touching = last_players_touching
		last_players_touching.clear()
		
	last_players_touching.push_back(controller)
		
	return

func clear_touching_records() -> void:
	old_last_players_touching.clear()
	last_players_touching.clear()
	last_team_touched = null
	old_last_team_touched = null
	return

func get_scorer_except(team: Team) -> Controller:
	var scorer : Controller = last_players_touching.pop_back()
	if scorer == null || scorer.team == team:
		scorer = old_last_players_touching.pop_back()
	clear_touching_records()
	return scorer
	
func on_body_exited(body):	
	self.recent_colliders.erase(body.get_name())
	return

func on_body_entered(body):
	var _name = body.get_name()
	if self.recent_colliders.has(_name) : return
	self.recent_colliders[_name] = body
	
	if body is Wall:
		print("wall bounce!")
		body.wall_bounce(self)
	else : if body is Paddle :
		print("paddle bounce!")
		body.paddle_bounce(self)
		velocity *= 1.1
	else : 
		print(str(_name, " entered and is not implemented"))
		return
