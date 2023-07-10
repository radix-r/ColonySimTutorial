extends Control

var selectedObject = null :
	get:
		return selectedObject
		
	set(value):
		selectedObject = value
		if value != null:
			$InfoPanel.visible = true
			match value.get_class_name() :
				"Unit":
					$InfoPanel/Name. text = value.data.name
					$BaseButtons/HBoxContainer/Bio.visible = true
					
		else:
			$InfoPanel.visible = false
			$BaseButtons/HBoxContainer/Bio.visible = false

func setSelectedObject(obj):
	selectedObject = obj



func _on_construct_pressed() -> void:
	$BaseButtons.visible = false
	$ConstructButtons.visible = true
	



func _on_back_pressed() -> void:
	$BaseButtons.visible = true
	$ConstructButtons.visible = false



func _on_gui_input(event: InputEvent) -> void:
#	if event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
#		selectedObject = null
	pass
