extends Node2D

@onready var grid = $Grid


func _ready() -> void:
	grid.generateGrid()
	$Grid/Pathfinding.initialize()
