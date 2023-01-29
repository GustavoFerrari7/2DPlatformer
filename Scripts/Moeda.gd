extends Area2D


func _on_Moeda_body_entered(body):
	PersonagemGlobal.moedas = PersonagemGlobal.moedas + 1
	$AnimatedSprite.play("Pickup")
	#print(PersonagemGlobal.moedas)
	PersonagemGlobal.emit_signal("pegouMoeda")
	$SoundCoin.play()
	set_collision_mask_bit(0,false)


func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "Pickup":
		queue_free()

