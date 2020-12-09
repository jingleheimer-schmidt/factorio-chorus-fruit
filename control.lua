
-- find a non-colliding position within ±64 tiles to teleport
function find_valid_position(player, player_position)
  -- calculate new position
  local new_position = {
    x = (player_position.x + math.random(-64,64)),
    y = (player_position.y + math.random(-64,64))
  }
  -- check if player can fit within 2 tiles of new position
  local valid_position = player.surface.find_non_colliding_position("character", new_position, 2, 1)
  return valid_position
end

-- calculate ouch factor
function calculate_ouch(player, player_position, valid_position)
  -- calculates distance between player and valid_position
  local distance = math.floor(((player_position.x - valid_position.x) ^ 2 + (player_position.y - valid_position.y) ^ 2) ^ 0.5)
  -- calculates a random variable between .91 and 1.09
  local almost = (math.random(91, 109))*.01
  -- sets ouch as ~55% of distance traveled
  local ouch = distance*(.55*almost)
  return ouch
end

-- deal damage or kill player, and play damage and teleporting sounds
function run_damage_logic(valid_position, player, ouch)
  if ( ouch <= 0 ) then
    game.play_sound{
      path = "fall-big", position = valid_position, volume_modifier = 1}
  else
    if ( ouch <= 8) then
      game.play_sound{
        path = "portal-1", position = valid_position, volume_modifier = .7
      }
    else
      game.play_sound{
        path = "portal-2", position = valid_position, volume_modifier = .7
      }
    end
  end
end

-- teleport the player
function chorus_fruit_teleport(player, player_position, valid_position)
  -- calculate ouch
  local ouch = calculate_ouch(player, player_position, valid_position)
  -- teleports player to valid_position
  player.teleport(valid_position)
  -- play sounds
  run_damage_logic(valid_position, player, ouch)
end

function find_position_and_teleport(event)
  -- adds the player and player position as a variable
  local player = event.source_entity
  local player_position = event.source_position
  -- attempt to teleport the player randomly within ±64 tiles 16 times
  for i=1,16 do
    local valid_position = find_valid_position(player, player_position)
    if valid_position then
      chorus_fruit_teleport(player, player_position, valid_position)
      break
    end
  end
end

-- runs when a script is triggered
script.on_event(defines.events.on_script_trigger_effect, function(event)
  -- checks if capsule is chorus fruit
  if event.effect_id == "chorus_fruit_effect_id" then
    find_position_and_teleport(event)
  else
    return
  end
end)
