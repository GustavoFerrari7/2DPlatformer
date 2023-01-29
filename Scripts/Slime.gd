extends KinematicBody2D

var movimento = Vector2()
export var direcao = -1
export var detectaQueda = true
export var velocidade = 20
var vida = 2

func _ready():
	if (direcao == 1):
		$AnimatedSprite.flip_h = true
	$RayCast2D.position.x = $CollisionShape2D.shape.get_extents().x * direcao
	$RayCast2D.enabled = detectaQueda
	$AnimatedSprite.play("Walk")
func _physics_process(delta):
	
	if is_on_wall() or !$RayCast2D.is_colliding() and detectaQueda and is_on_floor():
		direcao = direcao * -1
		$AnimatedSprite.flip_h = !$AnimatedSprite.flip_h
		$RayCast2D.position.x = $CollisionShape2D.shape.get_extents().x * direcao
	movimento.y += 9
	movimento.x = velocidade*direcao
	
	movimento = move_and_slide(movimento, Vector2.UP)


func _on_Checker_body_entered(body):
	PersonagemGlobal.PerderVida()
	body.bounce_enemies(position.x)
	#print("ouch")
	


func _on_Checker_area_entered(area):
	vida -=1
	$AnimatedSprite.play("Damage")
	if(vida == 0):	
		$SoundSlime.play()
		velocidade = 0
		set_collision_layer_bit(4, false)
		set_collision_mask_bit(0, false)
		set_collision_mask_bit(4, false)
		set_collision_mask_bit(5, false)
		$Checker.set_collision_mask_bit(0, false)
		$Checker.set_collision_mask_bit(5, false)
		$AnimatedSprite.play("Death")


func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "Damage":
		$AnimatedSprite.play("Walk")
	if $AnimatedSprite.animation == "Death":
		queue_free()
