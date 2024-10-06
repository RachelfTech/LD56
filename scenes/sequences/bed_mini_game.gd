extends Sequence

@export var soil_bucket: Sprite2D
@export var dirt_particle: PackedScene
@export var dirt_timer: Timer
@export var win_area: Area2D
@export var soil_spawn_marker: Marker2D

var sequence_text: Array[String] = ["I tried to make the home more comfortable for you."]
var end_sequence_text: Array[String] = ["But that wasn't enough."]

var allow_advance: bool = false
var game_running: bool = false

var game_done: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    super()
    soil_bucket.visible = false
    dirt_timer.timeout.connect(_handle_dirt_timer_timeout)
    start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    if not game_running:
        return
    var mouse_pos: Vector2 = get_viewport().get_mouse_position()

    soil_bucket.global_position = mouse_pos

    var overlapping_dirt: Array[Node2D] = win_area.get_overlapping_bodies()
    if overlapping_dirt.size() > 20:
        finish_game()

func _input(_event: InputEvent) -> void:
    if allow_advance and Input.is_action_just_pressed("left-click"):
        allow_advance = false
        var text_finished: bool = text_renderer.advance_text()
        if text_finished and not game_done:
            text_renderer.hide_text()
            start_game()
        elif text_finished and game_done:
            end()

func start_game():
    game_running = true
    soil_bucket.visible = true
    var tween: Tween = get_tree().create_tween()
    tween.tween_property(soil_bucket, "rotation", 0, .8).set_ease(Tween.EASE_IN_OUT)
    await tween.finished

    dirt_timer.start()
    print("start game")


func _handle_dirt_timer_timeout():
    var dirt: Dirt = dirt_particle.instantiate()
    dirt.global_position = soil_spawn_marker.global_position
    add_child(dirt)

func finish_game():
    dirt_timer.stop()
    game_running = false
    game_done = true

    var tween: Tween = get_tree().create_tween()
    tween.tween_property(soil_bucket, "rotation_degrees", 180, .8).set_ease(Tween.EASE_IN_OUT)
    await tween.finished

    text_renderer.set_sequence_text(end_sequence_text)
    text_renderer.play_text()

func start():
    text_renderer.set_sequence_text(sequence_text)
    animation_player.play("play")

func _handle_animation_finished(_animation_name: String):
    pass

func _handle_line_rendered():
    allow_advance = true
    text_renderer.animate_ready()

func _handle_all_text_rendered():
    pass
