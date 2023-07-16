extends Node2D

func _process(delta):
	for emitter in $ParticleEmitters.get_children():
		if emitter.emitting == false:
			emitter.queue_free()
