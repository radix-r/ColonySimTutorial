extends Node

@export var visuals_res: PackedScene
@export var owner_path: NodePath
@export var delay: float = 0.5
@export var follow_mouse: bool = true
@export var offset_x: float = 0.0
@export var offset_y: float = 0.0
@export var padding_x: float = 0.0
@export var padding_y: float = 0.0

var _visuals: Control
var _timer: Timer
var extents: Vector2

@onready var owner_node = get_node(owner_path)
@onready var offset: Vector2 = Vector2(offset_x, offset_y)
@onready var padding: Vector2 = Vector2(padding_x, padding_y)


func _ready() -> void:
	_visuals = visuals_res.instantiate()
	add_child(_visuals)
	_visuals.hide()
	extents = _visuals.size
	
	owner_node.connect("mouse_entered", _mouse_entered)
	owner_node.connect("mouse_exited", _mouse_exited)
	
	_timer = Timer.new()
	add_child(_timer)
	_timer.connect("timeout", _custom_show)


func _process(delta: float) -> void:
	if _visuals.visible:
		# screen boarder accounting for camera pan and zoom
		var border =  Vector2( (Vector2(get_viewport().size).x -get_viewport().canvas_transform.origin.x - padding.x) / get_viewport().get_camera_2d().zoom.x, -get_viewport().canvas_transform.origin.y)

		# want tooltip to be to the right and above by default
		# flip if it would render out of view
		var base_positon = _get_screen_pos()
		var final_x = base_positon.x + offset_x
		if final_x + extents.x > border.x:
			final_x = base_positon.x - offset_x - extents.x 
		var final_y = base_positon.y - extents.y - offset_y
		if final_y < border.y:
			final_y = base_positon.y + offset_y
		_visuals.set_global_position( Vector2(final_x, final_y) )


func _custom_show() -> void:
	_visuals.show()
	_timer.stop()


func _get_screen_pos() -> Vector2:
	if follow_mouse:
		
		return (get_viewport().get_mouse_position()  - get_viewport().canvas_transform.origin) / get_viewport().get_camera_2d().zoom
	
	else:
		return Vector2(0,0) 


func _mouse_entered() -> void:
	_timer.start(delay)
	

func _mouse_exited() -> void:
	_visuals.hide()
	_timer.stop()















