class_name ArenaPreview extends Control

var area_size : Vector2

func set_background(background : Sprite2D):
	add_child(background.duplicate())
	background.scale = abs(background.scale)
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
		wall_placement.region_enabled = true
		wall_placement.scale = abs(wall_placement.scale)
		
		var wall_size = WALL_SMALL.get_size()
		
		if wall_placement.transform.get_scale().aspect() < 1.0:
			wall_size.y = area_size.y
		else:
			wall_size.x = area_size.x
			
		wall_placement.scale = Vector2.ONE
		
		wall_placement.region_rect.size = wall_size
		add_child(wall_placement)
	return
	
const GOAL_NET = preload("res://assets/goal_net.png")	
const PADDLE_TEXTURE = preload("res://assets/paddle_texture.png")
func set_team_spawns(team_spawns):
	for ts in team_spawns:
		assert(ts is TeamSpawn)
		var team_spawn : TeamSpawn = ts
		var goal_placement : Sprite2D = Sprite2D.new()
		goal_placement.texture = GOAL_NET
		goal_placement.transform = team_spawn.get_goal().transform
		goal_placement.scale = abs(goal_placement.scale)
		goal_placement.region_enabled = true
		
		var goal_size = GOAL_NET.get_size()
		
		if goal_placement.scale.aspect() < 1.0:
			goal_size.y = area_size.y
		else:
			goal_size.x = area_size.x
			
		goal_placement.scale = Vector2.ONE
		
		goal_placement.region_rect.size = goal_size
		add_child(goal_placement)
		
		for ps in team_spawn.player_spawns:
			assert(ps is PlayerSpawn)
			var player_spawn : PlayerSpawn = ps
			var player_placement : Sprite2D = Sprite2D.new()
			player_placement.texture = PADDLE_TEXTURE
			player_placement.transform = player_spawn.transform
			
			match player_spawn.faced_direction:
				PlayerSpawn.Direction.LEFT:
					player_placement.set_rotation_degrees(90)
				PlayerSpawn.Direction.RIGHT:
					player_placement.set_rotation_degrees(90)
				PlayerSpawn.Direction.UP:
					pass
				PlayerSpawn.Direction.DOWN:
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
