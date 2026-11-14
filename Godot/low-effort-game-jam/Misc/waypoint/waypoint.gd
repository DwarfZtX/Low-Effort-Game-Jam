extends Node3D

var cam
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cam = get_viewport().get_camera_3d()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	var markerPos = cam.unproject_position(self.global_transform.origin)
	$Node2D.position = markerPos
	
	
	if $VisibleOnScreenNotifier3D.is_on_screen():
		$Node2D.show()
	else:
		$Node2D.hide()
