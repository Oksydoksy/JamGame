extends Node3D

@export var cell_width: int = 2
@export var cell_length: int = 2

@onready var grid_map : GridMap = $GridMap
@onready var player_camera : Camera3D = $PlayerCamera


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		var which_tile = get_tile_from_camera(event.position)
		print(which_tile)
	pass

func get_tile_from_camera(mousepos : Vector2):
	var from = player_camera.project_ray_origin(mousepos)
	var to = from + player_camera.project_ray_normal(mousepos) * 1000.0
	var query = PhysicsRayQueryParameters3D.create(from, to)
	var hit = get_world_3d().direct_space_state.intersect_ray(query)
	if hit.is_empty():
		return null
	# nudge slightly into the surface so you get the cell you hit
	return grid_map.local_to_map(grid_map.to_local(hit.position - hit.normal * 0.01))
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
