extends StaticBody2D


func _ready():
    get_tree().get_root().connect("size_changed", self, "on_window_resize")

func on_window_resize():
    print("Resizing: ", get_viewport_rect().size)