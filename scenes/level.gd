extends Node3D

@onready var grid_map: GridMap = $GridMap
@onready var player_camera: Camera3D = $PlayerCamera
@onready var selectionbox: Node3D = $SelectionBox

# Height of the surface you want to pick against.
# Try 0, cell_size.y / 2, or cell_size.y until the box lines up with the tile tops.
@export var pick_height: float = 0


func get_mouse_world_pos(plane_y: float):
	var mouse_pos = get_viewport().get_mouse_position()
	var from = player_camera.project_ray_origin(mouse_pos)
	var dir = player_camera.project_ray_normal(mouse_pos)

	var plane = Plane(Vector3.UP, plane_y)  # horizontal plane at height plane_y
	return plane.intersects_ray(from, dir)  # Vector3 or null


func get_hovered_cell():
	var pos = get_mouse_world_pos(pick_height)
	if pos == null:
		return null
	return grid_map.local_to_map(grid_map.to_local(pos))


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var cell = get_hovered_cell()
		if cell != null:
			print("Clicked cell: ", cell)


func _process(_delta: float) -> void:
	var cell = get_hovered_cell()
	if cell != null:
		selectionbox.global_position = grid_map.to_global(grid_map.map_to_local(cell))
		selectionbox.global_position.y += 1
