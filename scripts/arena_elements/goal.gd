class_name Goal extends Area2D

var team : Team

func assign_team(_team : Team):
	self.team = _team
	return
	
func _on_area_entered(area):
	if area is Ball:
		var scorer = area.get_scorer_except(team)
		# own goal or ball didn't touch any player
		if scorer == null:
			GameManager.get_match_manager().register_score_except(team)
		else:
			GameManager.get_match_manager().register_score(scorer)
		GameManager.get_match_manager().mark_ball_for_removal(area)
	return

