extends Node3D

@onready var budget_label : Label = $"../PlayerCamera/main_uis/Control/budged_text"
@onready var phone : PanelContainer = $"../PlayerCamera/main_uis/Control/PanelContainer"

@export var budget_amount : int = 200

@onready var grid_map : GridMap = $"../buildings_layer"

var phoneopen: bool = false

const UPGRADES := {
	0: [{"to": 42, "cost": 100}],
	1: [{"to": 43, "cost": 150}],
	4: [{"to": 44, "cost": 200}],
	5: [{"to": 45, "cost": 250}],
	9: [{"to": 46, "cost": 300}],
	11: [{"to": 47, "cost": 350}],
	12: [{"to": 48, "cost": 400}],
	13: [{"to": 49, "cost": 450}],
	14: [{"to": 50, "cost": 500}],
	15: [{"to": 51, "cost": 550}],
	16: [{"to": 52, "cost": 600}],
	20: [{"to": 53, "cost": 650}]
	
}

#option index is 0 because we only have one upgrade but later it becomes usefull
func try_upgrade(cell: Vector3i, option_index: int = 0) -> bool:
	var current := grid_map.get_cell_item(cell)
	var options: Array = UPGRADES.get(current, [])
	if option_index >= options.size():
		return false

	var opt: Dictionary = options[option_index]
	if budget_amount < opt.cost:
		print("not enough money")
		return false

	budget_amount -= opt.cost
	grid_map.set_cell_item(cell, opt.to, grid_map.get_cell_item_orientation(cell))
	budget_label.text = "Money: " + str(budget_amount)
	return true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	budget_label.text = "M " + str(budget_amount)
	phone.position.x -= 500
	pass
	
func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("open phone") and event.is_pressed() and !phoneopen:
		phoneopen = true	
		phone.position.x += 500
	else:
		phoneopen = false
		phone.position.x -= 500

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_level_click_cell(cell : Vector3) -> void:
	try_upgrade(Vector3i(cell))
	pass # Replace with function body.
