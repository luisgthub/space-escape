extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CPUParticles2D.emitting=false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func explode():
	$CPUParticles2D.emitting = true
	await get_tree().create_timer(1.0).timeout
	queue_free()
