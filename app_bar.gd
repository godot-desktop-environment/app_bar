@tool
extends PanelContainer


@export_enum("32:32", "40:40", "48:48", "56:56", "64:64", "72:72", "80:80", "88:88", "96:96") var apps_size: int = 40:
	set(s):
		apps_size = s
		_adjust_apps_size.call_deferred(s)


func _adjust_apps_size(s: int) -> void:
	%BarControls.custom_minimum_size.y = s
	%Launcher.custom_minimum_size.x = s
	%BarControls.size.y = 0
	%Launcher.size.x = 0
	
	# Discover the best size to fit all apps in the bar.
	var controls_gap: int = %BarControls.get_theme_constant("separation")
	var controls_count: int = %BarControls.get_child_count()
	var apps_gap: int = %ApplicationsContainer.get_theme_constant("separation")
	var apps_count: int = %ApplicationsContainer.get_child_count()
	var available_space: float = (
		%BarControls.size.x -
		%Launcher.size.x -
		%SystemContainer.size.x -
		(controls_count * (controls_gap + 1)) -
		(apps_count * (apps_gap + 1))
	)
	var max_s: int = int(available_space / apps_count)
	var best_size: int = min(s, max_s)
	
	for child in %ApplicationsContainer.get_children():
		child.custom_minimum_size.x = best_size
		child.size.x = 0


func _on_resized() -> void:
	_adjust_apps_size.call_deferred(apps_size)
