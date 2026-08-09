extends Area2D
class_name Tile
var is_shaking = false
var y_orin_pos = 0.0
@onready var sprite = $Sprite2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	y_orin_pos = sprite.position.y


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func shake_down():
	is_shaking = true
	var tween = create_tween()
	tween.tween_property(sprite,"position:y",y_orin_pos+2,0.2)
	tween.tween_property(sprite,"position:y",y_orin_pos,0.2)
	await tween.finished
	is_shaking = false

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("player")
		if not is_shaking:
			shake_down()

			
