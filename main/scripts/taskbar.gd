extends Node2D

var btns = []
onready var window_dupe = $container/ColorRect/v_container/window.duplicate()

func _ready() -> void:
	global.taskbar_scene = self
	
	$container/ColorRect/v_container/window.queue_free()

func _physics_process(delta: float) -> void:
	
	
	$container/right_container/fps.text = str( Engine.get_frames_per_second())
	
	for i in range(global.windows.size()):
		if global.windows[i].minimized:
			btns[i].get_node("rect").modulate += (Color.black - btns[i].get_node("rect").modulate) * 0.2
			btns[i].get_node("text").modulate += (Color.white - btns[i].get_node("text").modulate) * 0.2
		else:
			btns[i].get_node("rect").modulate += (Color.white - btns[i].get_node("rect").modulate) * 0.2
			btns[i].get_node("text").modulate += (Color.black - btns[i].get_node("text").modulate) * 0.2

func _input(event: InputEvent) -> void:
	for i in range(btns.size()):
		if btns[i].is_clicked():
			global.windows[i].minimize()
	
func refresh_windows():
	
	for i in btns:
		i.queue_free()
		
	btns = []
	
	for i in range(global.windows.size()):
		var window_inst = window_dupe.duplicate()
		window_inst.get_node("text").text = global.windows[i].window_name
		window_inst.rect_size.x = 7 + global.windows[i].window_name.length() * 5
		$container/ColorRect/v_container.add_child(window_inst)
		btns.append(window_inst)
		
		
	$container/ColorRect/v_container.refresh()
