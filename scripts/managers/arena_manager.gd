class_name ArenaManager extends Node

static var singleton : ArenaManager
var current_arena : Arena
var arenas_resources : Array[Resource]
var arenas = {}
var arena_previews = {}
var showcase_arena = Arena

func _ready() -> void:
	assert(singleton == null)
	singleton = self
	#check if _ready for arena is called
	# even if we don't attach it to arena_manager
	arenas_resources.push_back(preload("res://scenes/arenas/arena_1v1.tscn"))
	arenas_resources.push_back(preload("res://scenes/arenas/arena_training.tscn"))
	for arena_resource in arenas_resources:
		var arena : Arena = arena_resource.instantiate()
		add_child(arena)
		arenas[arena.arena_name] = arena
		arena.hide()
		
	showcase_arena = preload("res://scenes/arenas/arena_1v1_showcase.tscn").instantiate()
	add_child(showcase_arena)
	showcase_arena.hide()
	prepare_arena_previews()
	return

func get_showcase_arena() -> Arena:
	return showcase_arena
	
func get_current_arena() -> Arena:
	return current_arena	

func prepare_arena_previews():
	for arena_name in arenas:
		var preview = (arenas[arena_name] as Arena).spawn_arena_preview()
		arena_previews[arena_name] = preview
	return

static func get_arena_previews():
	return singleton.arena_previews
	
func get_arena_preview(arena_name: String) -> ArenaPreview:
	return arena_previews[arena_name]

func set_current_arena(arena: Arena) -> void:
	if current_arena != null :
		# stop ongoing game
		current_arena.hide()
		pass
	
	current_arena = arena
	current_arena.show()
	return

func respawn_balls() -> void:
	current_arena.respawn_balls()
	return
	
func load_arena_by_name(_name: String) -> void:
	if current_arena != null:
		current_arena.hide()
	current_arena = arenas[_name]
	current_arena.show()
	return
