## Handles the playing of cards during combat.
## will also handle the planting cards in the past mechanics and playing those cards.
## Likely will handle outcomes of enemy turns ie. restart if player dies.
extends Node
var current_stage:int = 1
var current_turn:int = 1
var planted_cards:Dictionary = {} # stage -> {turn -> [planted cards]}


func _process(delta: float) -> void:
	# debug for resetting turn
	if Input.is_action_just_pressed("ui_accept"):
		new_loop()


func play_card(card:CardData, target:Combatant, was_planted:bool = false):
	# Create the context for the card
	var context:CombatContext = CombatContext.new(target, current_turn, was_planted)
	# Run every effect (command) on the card ie. Do damage, apply status, etc.
	for effect:CardEffect in card.effects:
		effect.doEffect(context)
	# Emit played card


# Since cards functionally speaking are just an array of effects, we can store
# that array in our dictionary key'd by stage and turn.
func plant_card(card_data:CardData, target_stage:int, target_turn:int, target_name:String):
	# Check if we've used our max plants for the fight here
	# Create a key for the stage if it's not there
	if not planted_cards.has(target_stage):
		planted_cards[target_stage] = {}
	# Similar for the turn
	if not planted_cards[target_stage].has(target_turn):
		# Create an empty list which we'll fill with the cards we wanna play on this turn
		planted_cards[target_stage][target_turn] = []
	# Store it, might look something like 1:2:[card:fawfwafw, slot:2]
	# so stage 1, turn 2, fire this card at this target
	planted_cards[target_stage][target_turn].append({
		"card":card_data.duplicate(true), 
		"target":target_name
		})
	

func get_combatant(target_name: StringName) -> Combatant:
	for e in get_tree().get_nodes_in_group("enemies"):
		if e.name == target_name and e.current_health > 0:
			return e as Combatant
	return null


func start_of_turn():
	var turns = planted_cards.get(current_stage)
	# Do we have any planted cards to play?
	if turns != null:
		var pcards = turns.get(current_turn)
		# We have cards in this turn to play
		if pcards!=null:
			for card in pcards:
				play_card(card["card"], get_combatant(card["target"]), true) # card["target"] needs to actually be the combatant


func new_loop():
	current_turn = 1
	current_stage = 1
	start_of_turn()
	# Reset Deck or Cooldowns or whatever we do
	# Fire up the first fight
