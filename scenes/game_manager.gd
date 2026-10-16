extends Node3D

@export var budget_label : Label

var budget_amount : int = 1000

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	budget_label.text = "M " + str(budget_amount)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
