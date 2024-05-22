class_name ArenaPreview extends Control

var area_size : Vector2

func set_background(background : Sprite2D):
	add_child(background.duplicate())
	area_size = background.texture.get_size() * background.scale
	return

# instead of duplicating a whole node.
# lookup asset for wall to simply visualize it. 
# there is no need to copy the whole node
const WALL_SMALL = preload("res://assets/wall_small.png")
func set_walls(walls):
	for wall in walls:
		assert(wall is Wall)
		var wall_placement : Sprite2D = Sprite2D.new()
		wall_placement.texture = WALL_SMALL
		wall_placement.transform = wall.transform
		add_child(wall_placement)
	return
	
const GOAL_NET = preload("res://assets/goal_net.png")	
const PADDLE_TEXTURE = preload("res://assets/paddle_texture.png")
func set_team_spawns(team_spawns):
	for team_spawn in team_spawns:
		assert(team_spawn is TeamSpawn)
		var goal_placement : Sprite2D = Sprite2D.new()
		goal_placement.texture = GOAL_NET
		goal_placement.transform = team_spawn.get_goal().transform
		add_child(goal_placement)
		
		for player_spawn in team_spawn.player_spawns:
			var player_placement : Sprite2D = Sprite2D.new()
			player_placement.texture = PADDLE_TEXTURE
			player_placement.position = player_spawn.position
			
			match player_spawn.Direction:
				PlayerSpawn.Direction.LEFT:
					pass
				PlayerSpawn.Direction.RIGHT:
					pass
				PlayerSpawn.Direction.UP:
					player_placement.rotation_degrees = 90
					pass
				PlayerSpawn.Direction.DOWN:
					player_placement.rotation_degrees = 90
					pass
					
			add_child(player_placement)
	return
	
const BALL = preload("res://assets/ball.png")	
func set_ball_spawns(ball_spawns):
	for ball_spawn in ball_spawns :
		assert(ball_spawn is BallSpawn)
		var ball_placement : Sprite2D = Sprite2D.new()
		ball_placement.position = ball_spawn.position
		ball_placement.texture = BALL
		add_child(ball_placement)
	return