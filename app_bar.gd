@tool
extends PanelContainer

@export var apps_size: int = 40:
	set(s):
		apps_size = s
		_adjust_apps_size.call_deferred(s)


func _adjust_apps_size(s: int) -> void:
	%BarControls.custom_minimum_size.y = s
	%Launcher.custom_minimum_size = Vector2(s, s)
	%BarControls.size.y = 0
	%Launcher.size.x = 0
	
	var controls_gap: int = %BarControls.get_theme_constant("separation")
	var controls_count: int = %BarControls.get_child_count()
	var apps_space: int = (
		%BarControls.size.x -
		%Launcher.size.x -
		%SystemContainer.size.x -
		((controls_count - 1) * controls_gap)
	)
	
	%AppsContainer.adjust_apps_size.call_deferred(s, apps_space)


func _on_resized() -> void:
	_adjust_apps_size.call_deferred(apps_size)
