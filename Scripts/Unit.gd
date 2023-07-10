class_name Unit
extends Area2D

@onready var main = get_tree().root.get_node("Main")
@onready var gui = main.get_node("CanvasLayer").get_node("GUI")
@onready var grid: Grid = main.get_node("Grid")
@onready var pf: Pathfinder = grid.get_node("Pathfinding")
@onready var camera: Camera2D = main.get_node("Camera")

@export var show_debug: bool = true

signal  unitSelected(obj)

var data: UnitData = UnitData.new()

var path: PackedVector2Array
var pos: Vector2 :
	get:
		return pos
	set(value):
		pos = value


func _ready() -> void:
	pos = grid.worldToGrid(position)	
	unitSelected.connect(gui.setSelectedObject)


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		emit_signal("unitSelected", self)
	
	if show_debug:
		if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				var clicked = grid.worldToGrid(get_global_mouse_position())
				var worldPath = pf.getPath(pos, clicked)
				path = PackedVector2Array()
				
				for point in worldPath:
					path.append(grid.worldToGrid(point))
				
			
				print_debug("generating path to " + str(clicked))
				for point in path:
					print(str(point))


func _process(delta: float) -> void:
	move(delta)
	
func get_class_name():
	return "Unit"


func move(delta: float) -> void:
	if path.size() > 0:
		if position.distance_to(grid.gridToWorld(path[0])) < 5:
			position = grid.gridToWorld(path[0])
			pos = path[0]
			path.remove_at(0)
			
			if show_debug:
				print_debug("arrived at " + str(pos) )
		else:
			position += (grid.gridToWorld(path[0]) - position).normalized() * data.speed * delta
