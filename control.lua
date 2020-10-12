-- runs when a script is triggered
script.on_event(defines.events.on_script_trigger_effect, function(event)
  -- checks if capsule is chorus fruit, then tries twice to teleport the player randomly within ±64 tiles
  if event.effect_id == "chorus_fruit_effect_id" then
    -- calculate offsets
    local x_offset_1 = math.random(-64,64)
    local y_offset_1 = math.random(-64,64)
    -- adds the player and player position as a variable
    local player = event.source_entity
    local player_position = event.source_position
    -- calculate potential teleport location
    local new_position_1 = {
      x = (player_position.x + x_offset_1),
      y = (player_position.y + y_offset_1)
    }
    -- finds a non-colliding position within 10 tiles of new_position
    local valid_position_1 = player.surface.find_non_colliding_position("character", new_position_1, 10, 1)
    if valid_position_1 then
      -- calculates distance between player and valid_position
      local distance = math.floor(((player_position.x - valid_position_1.x) ^ 2 + (player_position.y - valid_position_1.y) ^ 2) ^ 0.5)
      -- calculates a random variable between .91 and 1.09
      local almost = (math.random(91, 109))*.01
      -- saves health deduction
      local health_deduction = distance*(.88*almost)
      -- subtracts ~88% of distance traveled from player health
      local ouch = player.health - health_deduction
      -- teleports player to valid_position
      player.teleport(valid_position_1)
      -- if player health will be at or below zero then kill them
		  if ( ouch <= 0 ) then
           game.play_sound{
             path = "fall-big", position = valid_position_1, volume_modifier = 1}
           player.die()
      -- otherwise subtract ~88% of distance traveled from player health
      else
			   player.health = ouch
         if ( health_deduction <= 16) then
           game.play_sound{
             path = "fall-small", position = valid_position_1, volume_modifier = 1}
         else
           game.play_sound{
             path = "fall-big", position = valid_position_1, volume_modifier = 1}
         end
		  end
    else
      -- try to teleport again: calculate new offsets
      local x_offset_2 = math.random(-64,64)
      local y_offset_2 = math.random(-64,64)
      local new_position_2 = {
        x = (player_position.x + x_offset_2),
        y = (player_position.y + y_offset_2)
      }
      -- find a non-colliding position within 10 tiles of new_position_2
      local valid_position_2 = player.surface.find_non_colliding_position("character", new_position_2, 10, 1)
      if valid_position_2 then
        -- calculates distance between player and valid_position_2
        local distance = math.floor(((player_position.x - valid_position_2.x) ^ 2 + (player_position.y - valid_position_2.y) ^ 2) ^ 0.5)
        -- calculates a random variable between .91 and 1.09
        local almost = (math.random(91, 109))*.01
        -- saves health deduction
        local health_deduction = distance*(.88*almost)
        -- subtracts ~88% of distance traveled from player health
        local ouch = player.health - health_deduction
        -- teleports player to secondary valid_position
        player.teleport(valid_position_2)
        -- if player health will be at or below zero then kill them
  		  if ( ouch <= 0 ) then
             game.play_sound{
               path = "fall-big", position = valid_position_2, volume_modifier = 1}
             player.die()
        -- otherwise subtract ~88% of distance traveled from player health
        else
  			   player.health = ouch
           if ( health_deduction <= 16) then
             game.play_sound{
               path = "fall-small", position = valid_position_2, volume_modifier = 1}
           else
             game.play_sound{
               path = "fall-big", position = valid_position_2, volume_modifier = 1}
           end
  		  end
      else
        -- player.player.print("No safe landing nearby")
        game.play_sound{
        path = "ender-pearl-failed-landing", position = player_position, volume_modifier = 1}
      end
    end
  else
    return
  end
end)
