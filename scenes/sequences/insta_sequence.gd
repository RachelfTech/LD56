class_name InstaSequence
extends Sequence

@export var scroll_area: Area2D
@export var photo_position_marker: PhotoFeed

var sequence_text: Array[String] = ["I encouraged you to find new friends and have new experiences."]
var end_sequence_text: Array[String] = ["I enjoyed seeing you grow!"]

var scrolling: bool = false
var photos_to_like_count: int = 0
var photos_liked_count: int = 0

var allow_advance: bool = false
var game_running: bool = false
var game_done: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    super()
    start()
    scroll_area.input_event.connect(_handle_area_input_event)
    photos_to_like_count = photo_position_marker.get_child_count()
    photo_position_marker.feed_photo_liked.connect(_handle_feed_photo_liked)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass

func _input(_event: InputEvent) -> void:
    if allow_advance and Input.is_action_just_pressed("left-click"):
        allow_advance = false
        var text_finished: bool = text_renderer.advance_text()
        if text_finished and not game_done:
            text_renderer.hide_text()
            start_game()
        elif text_finished and game_done:
            end()

func start():
    text_renderer.set_sequence_text(sequence_text)
    animation_player.play("play")

func start_game():
    game_running = true
    print("start game")

func _handle_animation_finished(_animation_name: String):
    pass

func _handle_line_rendered():
    allow_advance = true
    text_renderer.animate_ready()

func _handle_all_text_rendered():
    pass

func _handle_feed_photo_liked():
    photos_liked_count += 1

    if photos_liked_count == photos_to_like_count:
        _finish_game()

func _finish_game():
    game_running = false
    game_done = true

    text_renderer.set_sequence_text(end_sequence_text)
    text_renderer.play_text()

func _handle_area_input_event(_viewport: Node, event: InputEvent, _shape_idx: int):
    if not game_running:
        return
    if event is InputEventMouseMotion and Input.is_mouse_button_pressed(MouseButton.MOUSE_BUTTON_LEFT):
        scrolling = true
        var scroll_velocity: Vector2 = event.velocity

        print(photo_position_marker.position.y)
        print(scroll_velocity.y)
        var new_position_y: float = photo_position_marker.position.y + (scroll_velocity.y * .02)

        photo_position_marker.position.y = clampf(new_position_y, -650, 0)
    elif not Input.is_mouse_button_pressed(MouseButton.MOUSE_BUTTON_LEFT):
        scrolling = false