class_name BallSpawn extends Node2D

func spawn_ball() -> Ball :
	var ball : Ball = preload("res://scenes/arena_elements/ball.tscn").instantiate()
	ball.position = self.position
	GameManager.get_match_manager().register_ball(ball)
	return ball
