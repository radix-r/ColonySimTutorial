class_name CellData3D
extends Object

# This file follows the style guide

#####################################
# SIGNALS
#####################################

signal cell_changed(_pos: Vector3)
signal nav_changed(_pos: Vector3)


#####################################
# CONSTANTS
#####################################

#####################################
# EXPORT VARIABLES 
#####################################

#####################################
# PUBLIC VARIABLES 
#####################################

#####################################
# PRIVATE VARIABLES
#####################################

var pos: Vector3

#####################################
# ONREADY VARIABLES
#####################################

#####################################
# OVERRIDE FUNCTIONS
#####################################

func _init(_pos: Vector3) -> void:
	pos = _pos

#####################################
# API FUNCTIONS
#####################################

#####################################
# HELPER FUNCTIONS
#####################################

var floor_data: FloorData3D :
	set(value):
		floor_data = value
		emit_signal("cell_changed", pos)
	get:
		return floor_data


var occupier = null :
	set(value):
		occupier = value
		emit_signal("cell_changed", pos)
	get:
		return occupier


var navigable: bool = true :
	set(value):
		navigable = value
		emit_signal("cell_changed", pos)
		emit_signal("nav_changed", pos)
	get:
		return navigable











