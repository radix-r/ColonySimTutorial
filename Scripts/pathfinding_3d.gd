class_name Pathfinder3D
extends Node

var aStar = AStar3D.new()
@onready var main = get_tree().root.get_node("Main")
@onready var grid: Grid3D = main.get_node("Grid")

const DIRECTIONS = [Vector3i.UP, Vector3i.DOWN, Vector3i.LEFT, Vector3i.RIGHT, Vector3i.FORWARD, Vector3i.BACK]

func addPoints():
	var curID = 0
	for point in grid.grid:
		aStar.add_point(curID, point)
		aStar.get_available_point_id()
		curID += 1


func connectPoint(_point: Vector3i) -> void:
	var _pointId = getPointID(_point)
	for direction in DIRECTIONS:
		var neighbor = _point + direction
		var neighborID = getPointID(neighbor)
		if grid.grid.has(neighbor) and grid.grid[neighbor].navigable:
			aStar.connect_points(_pointId, neighborID)


func connectAllPoints() -> void:
	for point in grid.grid:
		connectPoint(point)


func disconnectPoint(_point: Vector3i) -> void:
	var _pointId = getPointID(_point)
	for direction in DIRECTIONS:
		var neighbor = _point + direction
		var neighborID = getPointID(neighbor)
		aStar.disconnect_points(_pointId, neighborID)


func initialize() -> void:
	addPoints()
	connectAllPoints()


func getIDWorldPos(_id: int) -> Vector3i:
	return aStar.get_point_position(_id)


#func getIDGridPos(_id: int) -> Vector2:
#	var worldPos = getIDWorldPos(_id)
#	return grid.worldToGrid(worldPos)


func getPath(_pointA: Vector3i, _pointB: Vector3i) -> PackedVector3Array:
	var aID = getPointID(_pointA)
	var bID = getPointID(_pointB)
	return aStar.get_point_path(aID, bID)


func getPointID(gridPoint: Vector3i) -> int:
	return aStar.get_closest_point(gridPoint)


#func getWorldID(worldPoint: Vector2) -> int:
#	return aStar.get_closest_point(worldPoint)
#

#####################################
# SIGNALS
#####################################

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

#####################################
# ONREADY VARIABLES
#####################################

#####################################
# OVERRIDE FUNCTIONS
#####################################

#####################################
# API FUNCTIONS
#####################################

#####################################
# HELPER FUNCTIONS
#####################################
