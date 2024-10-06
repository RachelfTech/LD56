class_name Book
extends RigidBody2D

@export var book_title: String
@export var book_label: Label
@export var book_texture: Texture2D
@export var book_sprite: Sprite2D
@export var collision_shape: CollisionShape2D

var selectable = true

var dragging: bool = false
var starting_pos: Vector2

signal selected(book: Book)
signal deselected(book: Book)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    book_label.text = book_title
    book_sprite.texture = book_texture
    sleeping = true

    freeze_mode = FREEZE_MODE_KINEMATIC
    freeze = true

    input_event.connect(_handle_collision_shape_input_event)
    starting_pos = global_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass


func _physics_process(delta: float) -> void:
    if global_position.x < 0 or global_position.x > 640 or global_position.y < 0 or global_position.y > 360:
        global_position = starting_pos
    if not dragging:
        return

    var mouse_pos = get_viewport().get_mouse_position()
    if mouse_pos.x < 0 or mouse_pos.y < 0 or mouse_pos.x > 640 or mouse_pos.y > 360:
        return
    position = mouse_pos

func _handle_collision_shape_input_event(_viewport: Node, event: InputEvent, _shape_idx: int):
    if not selectable:
        return

    if Input.is_action_pressed("left-click"):
        dragging = true
        freeze = true
        selected.emit(self)


func _input(_event: InputEvent) -> void:
    if not selectable:
        return
    if Input.is_action_just_released("left-click"):
        dragging = false
        freeze = false
        deselected.emit(self)