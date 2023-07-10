extends Control


func _make_custom_tooltip(text:String) -> Object:
	# This exists, and is a Control node, with a panel-container and label inside of it
	var tooltip: Control = preload("res://Scenes/MarkdownTooltip.tscn").instance()
	tooltip.get_node("Label").text = text
	return tooltip
