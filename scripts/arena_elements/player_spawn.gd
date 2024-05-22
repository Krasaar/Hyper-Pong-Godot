class_name PlayerSpawn extends Node2D

enum Direction {UP, DOWN, LEFT, RIGHT}

@export var faced_direction : Direction

var vector_direction = {
	Direction.UP : Vector2.UP,
	Direction.DOWN : Vector2.DOWN,
	Direction.RIGHT : Vector2.RIGHT,
	Direction.LEFT : Vector2.LEFT,
}

func set_player_pos(player: Paddle):
	player.position = self.position
	player.spawn_position = self.position
	player.face_direction(vector_direction[faced_direction])
	return
