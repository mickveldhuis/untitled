extends Camera2D


export var shake_period : float = 10.0


var shake_intensity : float = 0.0
var shake_duration : float = 0.0


var noise : OpenSimplexNoise


func _ready():
	noise = OpenSimplexNoise.new()
	noise.seed = randi()
	noise.period = shake_period


func _process(delta):
	if shake_duration <= 0:
		offset = Vector2.ZERO
		
		shake_intensity = 0.0
		shake_duration = 0.0
		
		return
	
	shake_duration -= delta
	
	# Apply camera shake:
	apply_shake()


func shake(intensity, duration):	
	if intensity > shake_intensity and duration > shake_duration:
		shake_intensity = intensity
		shake_duration = duration


func apply_shake() -> void:
	var shake_offset : Vector2 = Vector2.ZERO

	# Random shake effect:
	# shake_offset = Vector2(randf(), randf()) * shake_intensity
		
	var noise_x = noise.get_noise_1d(OS.get_ticks_msec() * 0.1)
	var noise_y = noise.get_noise_1d(OS.get_ticks_msec() * 0.1 + 100.0)
	
	shake_offset = Vector2(noise_x, noise_y) * shake_intensity * 2.0
		
	offset = shake_offset