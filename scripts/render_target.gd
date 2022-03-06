class_name RenderTarget
extends Control


# array of LayerData
var line_data: Array = []
var line_width: float = 1.0


func add_lines(lines: Array):
	# array of LineData
	line_data.append_array(lines)

func _draw():
	var points: PoolVector2Array = []
	var colors: PoolColorArray = []
	
	for line in line_data:
		points.append(line.start)
		points.append(line.end)
		colors.append(line.color)
		colors.append(line.color)
	
	if len(points) > 0: 
		draw_multiline_colors(points, colors)
	line_data.clear()


class LayerData:
	
	var lines: PoolVector2Array = []
	var color: Color = Color.black
	
	
	func _init(_lines: PoolVector2Array, _color: Color):
		lines = _lines
		color = _color
