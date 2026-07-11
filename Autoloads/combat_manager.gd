## Handles the playing of cards during combat.
## will also handle the planting cards in the past mechanics and playing those cards.
## Likely will handle outcomes of enemy turns ie. restart if player dies.
extends Node

var current_stage:int = 1
var current_turn:int = 0
var planted_cards:Dictionary = {} # stage -> {turn -> [planted cards]}

func play_card(card:CardData, target:Combatant, was_planted:bool = false):
	# Create the context for the card
	var context:CombatContext = CombatContext.new(target, current_turn, was_planted)
	# Run every effect (command) on the card ie. Do damage, apply status, etc.
	for effect:CardEffect in card.effects:
		effect.doEffect(context)
	# Emit played card

# Since cards functionally speaking are just an array of effects, we can store
# that array in our dictionary key'd by stage and turn.
func plant_card(card_data:CardData, target_stage:int, target_turn:int, target_slot:int):
	# Check if we've used our max plants for the fight here
	# Check if within bounds
	if target_stage == current_stage and target_turn < current_turn:
		return
	# Create a key for the stage if it's not there
	if not planted_cards.has(target_stage):
		planted_cards[target_stage] = {}
	# Similar for the turn
	if not planted_cards[target_stage].has(target_turn):
		# Create an empty list which we'll fill with the cards we wanna play on this turn
		planted_cards[target_stage][target_turn] = []
	# Store it, might look something like 1:2:[card:fawfwafw, slot:2]
	# so stage 1, turn 2, fire this card at slot 2
	planted_cards[target_stage][target_turn].append({
		"card":card_data.duplicate(true), 
		"slot":target_slot
		})
	

# Will need for AOE's and stuff
func get_enemies():
	pass

func start_of_turn():
	pass

func new_loop():
	current_turn = 0
	current_stage = 1
	# Reset Deck
	# Fire up the first fight
