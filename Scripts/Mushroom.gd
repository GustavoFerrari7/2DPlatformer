extends KinematicBody2D

var movimento = Vector2()
export var direcao = -1
export var detectaQueda = true
var velocidade = 8

# Called when the node enters the scene tree for the first time.
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


func _on_Topo_body_entered(body):
	$AnimatedSprite.play("Pisado")
	$SoundMush.play()
	body.bounce_mushroom()


func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "Pisado":
		$AnimatedSprite.play("Walk")
