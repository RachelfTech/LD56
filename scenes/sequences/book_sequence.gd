extends Sequence

@export var books: Node
@export var brain_area: Area2D

var sequence_text: Array[String] = ["I educated myself on your new form."]
var end_sequence_text: Array[String] = ["I hoped it would help us relate."]

var allow_advance: bool = false
var game_running: bool = false

var game_done: bool = false
var num_books: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    super()
    start()

    for book: Book in books.get_children():
        book.selected.connect(_handle_book_selected)
        book.deselected.connect(_handle_book_deselected)

    num_books = books.get_child_count()
    books.process_mode = PROCESS_MODE_DISABLED


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass

func _physics_process(delta: float) -> void:
    if not game_running:
        return
    var overlapping_books: Array[Node2D] = brain_area.get_overlapping_bodies()
    print(overlapping_books.size())

    if overlapping_books.size() == num_books:
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


func start():
    text_renderer.set_sequence_text(sequence_text)
    animation_player.play("play")

func start_game():
    game_running = true
    books.process_mode = PROCESS_MODE_ALWAYS
    unfreeze_books()
    print("start game")

func _handle_animation_finished(_animation_name: String):
    pass

func _handle_line_rendered():
    allow_advance = true
    text_renderer.animate_ready()

func _handle_all_text_rendered():
    pass

func finish_game():
    game_running = false
    game_done = true


    text_renderer.set_sequence_text(end_sequence_text)
    text_renderer.play_text()

func unfreeze_books():
    for book: Book in books.get_children():
        book.freeze = false

func _handle_book_selected(book: Book):
    for other_book: Book in books.get_children():
        if book != other_book:
            other_book.selectable = false

func _handle_book_deselected(_book: Book):
    for book: Book in books.get_children():
        book.selectable = true