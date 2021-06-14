extends KinematicBody2D

const GRAVITY = 400
const JUMP_POWER = -4000
const FLOOR = Vector2(0, -1)
var on_ground = false

var velocity = Vector2()
var speed = 200
var screen_size
var collision

var lifes_p1 = 3
var offset_lifes = 50
var life_list = []
export (PackedScene) var spr_lifes

func _ready():
	screen_size = get_viewport_rect().size
	create_lifes()
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

func create_lifes():
	for i in lifes_p1:
		var newLife = spr_lifes.instance()
		get_tree().get_nodes_in_group("gui")[0].add_child(newLife)
		newLife.global_position.x += offset_lifes * i
		life_list.append(newLife)

func remove_life():
	if (lifes_p1 > 0):
		lifes_p1 -= 1
		life_list[lifes_p1].queue_free()
	else:
		get_tree().change_scene("res://Scenes/Game Over.tscn")
	
	
func add_life():
	lifes_p1 += 1
	var newLife = spr_lifes.instance()
	get_tree().get_nodes_in_group("gui")[0].add_child(newLife)
	newLife.global_position.x += offset_lifes * (lifes_p1 - 1)
	life_list[lifes_p1-1].append(newLife)
	

func _physics_process(delta):
	#Movement
	if Input.is_action_pressed("ui_right"):
		velocity.x = speed
		$AnimatedSprite.play("right")
		$AnimatedSprite.flip_h = false
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -speed
		$AnimatedSprite.play("right")
		$AnimatedSprite.flip_h = true
	else: 
		velocity.x = 0
		
		
	if Input.is_action_pressed("ui_up"):
		if on_ground == true:
			velocity.y = JUMP_POWER
			$AnimatedSprite.play("up")
			on_ground = false
	else: 
		velocity.y = 0
	
	
	if (velocity.y == 0 and velocity.x == 0):
		$AnimatedSprite.play("idle") #idle position
		
	velocity.y += GRAVITY
#
	if is_on_floor():
		on_ground = true
	else:
		on_ground = false
	
	if (position.y >= 650):
#		$pain.volume_db = 5
#		if ($pain.playing == false):
#			$pain.play()
			
			position.x = 53.859
			position.y = 500.353
			start(position)
			remove_life()
		
		
	velocity = move_and_slide(velocity, FLOOR)
	
	if (get_slide_count() == 1):
		for i in range(get_slide_count()):
			if "Enemy" in get_slide_collision(i).collider.name:
				touched(get_slide_collision(i).collider.name)
				print(get_slide_count())
		

func touched(collision_object):
	hide()  # Player disappears after being hit.
	emit_signal("hit")
#	$pain.volume_db = 5
#	if ($pain.playing == false):
#		$pain.play()
	remove_life()
	if (lifes_p1 > 0):
		position.x = 53.859
		position.y = 500.353
		start(position)
	else:
		$CollisionShape2D.set_deferred("disabled", true)

	
