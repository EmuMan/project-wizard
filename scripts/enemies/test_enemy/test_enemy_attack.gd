extends State

var time_elapsed: float = 0


# Initialize the state. E.g. change the animation.
func enter() -> void:
	print("Entering attack state...")
	time_elapsed = 0

# Clean up the state. Reinitialize values like a timer.
func exit() -> void:
	print("Exiting attack state...")
	
func update(delta: float):
	time_elapsed += delta
	if time_elapsed >= 3:
		finished.emit("MoveState")
