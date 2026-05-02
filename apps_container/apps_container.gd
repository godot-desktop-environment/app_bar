@tool
extends HBoxContainer

const AppLauncher := preload("res://app_bar/apps_container/app_launcher/app_launcher.gd")


func adjust_apps_size(s: int, total_space: int) -> void:
	# Discover available space for the launchers.
	var gap: int = get_theme_constant("separation")
	var count: int = get_child_count()
	var pinned_gap: int = %PinnedContainer.get_theme_constant("separation")
	var pinned_count: int = %PinnedContainer.get_child_count()
	var unpinned_gap: int = %UnpinnedContainer.get_theme_constant("separation")
	var unpinned_count: int = %UnpinnedContainer.get_child_count()
	var available_space: float = (
		total_space -
		# Everything that cost space.
		((count - 1) * gap) -
		((pinned_count - 1) * pinned_gap) -
		((unpinned_count - 1) * unpinned_gap)
	)
	
	# Limit launchers size so it fit everyone.
	# NOTE: Increasing the custom_minium_size can accidentally increase the parent size,
	# because the parent may have to readjust to fit all custom_minium_size's.
	# To prevent that we fake having 1 more launcher.
	var max_s: int = int(available_space / (pinned_count + unpinned_count + 1))
	var best_size: int = min(s, max_s)
	
	for child: AppLauncher in %PinnedContainer.get_children():
		child.custom_minimum_size = Vector2(best_size, s)
		child.reset_size()
	
	for child: AppLauncher in %UnpinnedContainer.get_children():
		child.custom_minimum_size = Vector2(best_size, s)
		child.reset_size()
