extends Node2D

export var speed := 300.0
export var direction := Vector2.DOWN
export var wait_min := 2.5
export var wait_max := 3.5
onready var timer := $Timer
onready var health := $Health
onready var animator := $AnimationPlayer
onready var _velocity := speed * direction


func _ready() :
	randomize()
	$Timer.wait_time = rand_range(wait_min, wait_max)


func _on_HurtBox_damage_taken(damage) :
	health.current -= damage
	countdown()


func _process(delta: float) :
	translate(_velocity * delta)


func _on_SensorArea_area_entered(area: Area2D) :
	countdown()


func countdown() :
	if animator.current_animation == "explode":
		return
	if animator.current_animation == "countdown":
		return
	animator.play("countdown")


func _on_Health_depleted() :
	set_process(false)
	if not animator.current_animation == "explode":
		animator.play("explode")


func _on_Timer_timeout() :
	set_process(false)
