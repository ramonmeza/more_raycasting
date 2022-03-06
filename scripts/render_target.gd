class_name RenderTarget
extends Control


# array of LayerData
var layers: Array = []
var line_width: float = 1.0


func add_layer(lines: PoolVector2Array, color: Color):
	layers.append(LayerData.new(lines, color))
	update()


func _draw():
	for layer in layers:
		if len(layer.lines) >= 2 and len(layer.lines) % 2 == 0:
			draw_multiline(layer.lines, layer.color, line_width)


class LayerData:
	
	var lines: PoolVector2Array = []
	var color: Color = Color.black
	
	
	func _init(_lines: PoolVector2Array, _color: Color):
		lines = _lines
		color = _color
