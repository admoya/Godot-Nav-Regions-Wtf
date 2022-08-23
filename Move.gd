extends Sprite

export var nav_layer = 1
export var speed = 5
var path = null
const ARRIVAL_BUFFER = 10

func _physics_process(delta):
	if path:
		if global_position.distance_to($"../Goal".global_position) <= ARRIVAL_BUFFER:
			queue_free()
		if global_position.distance_to(path[0]) <= ARRIVAL_BUFFER:
			path.remove(0)
			return
		global_position.x = move_toward(global_position.x, path[0].x, speed)
		global_position.y = move_toward(global_position.y, path[0].y, speed)
	else:
		get_path()

func get_path():
	print("Generating Path")
	path = Navigation2DServer.map_get_path(get_world_2d().get_navigation_map(), global_position, $"../Goal".global_position, false, nav_layer)
