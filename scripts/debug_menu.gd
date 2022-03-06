class_name DebugMenu
extends ViewportContainer


onready var fov_property_slider: HSlider = $Viewport/VBoxContainer/FovProperty/HSlider
onready var distance_property_slider: HSlider = $Viewport/VBoxContainer/DistanceProperty/HSlider


func _process(_delta):
	# stops from rotating with parent node
	set_rotation(0)
