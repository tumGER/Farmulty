extends Area2D

signal is_mature

export var Stage: int
export var creation_date: int

var area: Node2D

func _ready():
	if creation_date == 0:
		creation_date = OS.get_unix_time()

func set_area(s_area):
	area = s_area

func _on_Timer_timeout():
	Stage += 1
	
	$AnimatedSprite.frame = Stage

	if Stage == 1:
		area.get_node("Hole").hide()
	
	if Stage == 4:
		area.crop_mature()
		emit_signal("is_mature")
		# $MatureFlag.show() Not sure about that yet
		$Timer.stop()

func harvestable() -> bool:
	if Stage == 4:
		return true
	else:
		return false