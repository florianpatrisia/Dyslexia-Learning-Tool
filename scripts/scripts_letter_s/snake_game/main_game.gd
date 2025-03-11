extends Node

const SNAKE = 0
const LETTERS = { "A": 3, "B": 4, "C": 5, "E": 6, "I": 7, "M": 8, "O": 9, "S": 10, "U": 11 }
var letters_positions = {}
var snake_body = [Vector2(5, 10), Vector2(4, 10), Vector2(3, 10)]
var snake_direction = Vector2(1, 0)
var add_segment = false
var s_letters_eaten = 0

func _ready():
	$Introduction.play()
	generate_letters()
	draw_letters()
	draw_snake()

func generate_letters():
	randomize()
	letters_positions.clear()
	
	# Ensure at least 4 'S'
	for i in range(4):
		add_random_letter("S")
	
	# Add the remaining 6 letters
	for i in range(6):
		var random_letter = pick_random_letter()
		add_random_letter(random_letter)

func add_random_letter(letter: String):
	while true:
		var position = Vector2(randi() % 29, randi() % 16)
		if not position in letters_positions and not position in snake_body:
			letters_positions[position] = LETTERS[letter]
			break

func pick_random_letter() -> String:
	var keys = LETTERS.keys()
	var random_index = randi() % (keys.size() - 1) + 1
	while (keys[random_index] == "S"):
		random_index = randi() % (keys.size() - 1) + 1
	return keys[random_index]

func draw_letters():
	delete_tiles(-1)  # Clear previous letters
	for position in letters_positions.keys():
		var letter_id = letters_positions[position]
		$SnakeApple.set_cell(Vector2i(position.x, position.y), letter_id, Vector2i(0, 0))

func relation2(first_block: Vector2, second_block: Vector2):
	var block_relation = second_block - first_block
	if block_relation == Vector2(-1, 0): return 'left'
	if block_relation == Vector2(1, 0): return 'right'
	if block_relation == Vector2(0, 1): return 'bottom'
	if block_relation == Vector2(0, -1): return 'top'

func draw_snake():
	for block_index in range(snake_body.size()):
		var block = snake_body[block_index]
		var block_pos = Vector2i(block.x, block.y)

		if block_index == 0:
			var head_dir = relation2(snake_body[0], snake_body[1])
			if head_dir == 'right':
				$SnakeApple.set_cell(block_pos, SNAKE, Vector2i(3, 1))
			elif head_dir == 'left':
				$SnakeApple.set_cell(block_pos, SNAKE, Vector2i(2, 0))
			elif head_dir == 'top':
				$SnakeApple.set_cell(block_pos, SNAKE, Vector2i(3, 0))
			elif head_dir == 'bottom':
				$SnakeApple.set_cell(block_pos, SNAKE, Vector2i(2, 1))
		elif block_index == snake_body.size() - 1:
			var tail_dir = relation2(snake_body[-1], snake_body[-2])
			if tail_dir == 'right':
				$SnakeApple.set_cell(block_pos, SNAKE, Vector2i(0, 0))
			elif tail_dir == 'left':
				$SnakeApple.set_cell(block_pos, SNAKE, Vector2i(1, 0))
			elif tail_dir == 'top':
				$SnakeApple.set_cell(block_pos, SNAKE, Vector2i(1, 1))
			elif tail_dir == 'bottom':
				$SnakeApple.set_cell(block_pos, SNAKE, Vector2i(0, 1))
		else:
			var previous_block = snake_body[block_index + 1] - block
			var next_block = snake_body[block_index - 1] - block

			if previous_block.x == next_block.x:
				$SnakeApple.set_cell(block_pos, SNAKE, Vector2i(4, 1))
			elif previous_block.y == next_block.y:
				$SnakeApple.set_cell(block_pos, SNAKE, Vector2i(4, 0))
			else:
				if (previous_block.x == -1 and next_block.y == -1) or (next_block.x == -1 and previous_block.y == -1):
					$SnakeApple.set_cell(block_pos, SNAKE, Vector2i(6, 1))
				elif (previous_block.x == -1 and next_block.y == 1) or (next_block.x == -1 and previous_block.y == 1):
					$SnakeApple.set_cell(block_pos, SNAKE, Vector2i(6, 0))
				elif (previous_block.x == 1 and next_block.y == -1) or (next_block.x == 1 and previous_block.y == -1):
					$SnakeApple.set_cell(block_pos, SNAKE, Vector2i(5, 1))
				elif (previous_block.x == 1 and next_block.y == 1) or (next_block.x == 1 and previous_block.y == 1):
					$SnakeApple.set_cell(block_pos, SNAKE, Vector2i(5, 0))

func is_valid_move(new_head: Vector2) -> bool:
	if new_head in letters_positions:
		var letter_id = letters_positions[new_head]
		if letter_id == LETTERS["S"]:
			$FoundS.play()
			return true
		else:
			$OtherLetter.play()
			return false
	return true

func move_snake():
	if snake_body.size() < 2:
		return

	delete_tiles(SNAKE)

	var body_copy = snake_body.slice(0, snake_body.size() - 1)
	var new_head = snake_body[0] + snake_direction

	if is_valid_move(new_head):
		body_copy.insert(0, new_head)
		if add_segment:
			body_copy.append(snake_body[-1]) 
			add_segment = false
		snake_body = body_copy
		draw_snake()
	else:
		draw_snake()

func delete_tiles(id: int):
	var cells = $SnakeApple.get_used_cells_by_id(id)
	for cell in cells:
		var cell_pos = Vector2i(cell.x, cell.y)
		$SnakeApple.set_cell(cell_pos, -1)

func _input(event):
	if $Introduction.is_playing():
		await $Introduction.finished
	if Input.is_action_just_pressed("ui_up"): 
		if not snake_direction == Vector2(0, 1):
			snake_direction = Vector2(0, -1)
			move_snake()
	if Input.is_action_just_pressed("ui_right"): 
		if not snake_direction == Vector2(-1, 0):
			snake_direction = Vector2(1, 0)
			move_snake()
	if Input.is_action_just_pressed("ui_left"): 
		if not snake_direction == Vector2(1, 0):
			snake_direction = Vector2(-1, 0)
			move_snake()
	if Input.is_action_just_pressed("ui_down"): 
		if not snake_direction == Vector2(0, -1):
			snake_direction = Vector2(0, 1)
			move_snake()

func check_letter_eaten():
	var head = snake_body[0]
	if head in letters_positions:
		var letter_id = letters_positions[head]
		if letter_id == LETTERS["S"]:
			s_letters_eaten += 1
			add_segment = true
			get_tree().call_group('ScoreGroup', 'update_score', snake_body.size())
			letters_positions.erase(head)
		draw_letters()
		draw_snake()
		
		if s_letters_eaten == 4:
			show_game_over_popup()

func check_game_over():
	var head = snake_body[0]
	if head.x >= 29 or head.x < 0 or head.y < 0 or head.y >= 16:
		reset()
	for block in snake_body.slice(1, snake_body.size() - 1):
		if block == head:
			reset()

func reset():
	snake_body = [Vector2(5, 10), Vector2(4, 10), Vector2(3, 10)]
	snake_direction = Vector2(1, 0)
	generate_letters()
	draw_letters()
	draw_snake()

func _process(delta):
	check_game_over()
	check_letter_eaten()

func show_game_over_popup():
	get_tree().change_scene_to_file("res://scenes/scenes_letter_s/snake_game/end_game.tscn")
