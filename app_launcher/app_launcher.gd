extends Button

@export var path: String = "gnome-text-editor"

@export var arguments: PackedStringArray = []

var current_mouse_button: int = 0


func _on_button_down() -> void:
	current_mouse_button = Input.get_mouse_button_mask()


func _on_button_up() -> void:
	current_mouse_button = 0


func _on_pressed() -> void:
	if current_mouse_button & MOUSE_BUTTON_MASK_LEFT == MOUSE_BUTTON_MASK_LEFT:
		OS.create_process(path, [])
	elif current_mouse_button & MOUSE_BUTTON_MASK_RIGHT == MOUSE_BUTTON_MASK_RIGHT:
		pass
	elif current_mouse_button & MOUSE_BUTTON_MASK_MIDDLE == MOUSE_BUTTON_MASK_MIDDLE:
		pass
