local sounds = require ("eating-sound")

local chorusFruit = {
  type = "capsule",
  name = "chorus-fruit",
  icon = "__factorio-chorus-fruit__/graphics/Chorus_Fruit_JE2_BE2.png",
  icon_size = 150,
  subgroup = "raw-resource",
  capsule_action =
  {
    type = "use-on-self",
    attack_parameters =
    {
      type = "projectile",
      ammo_category = "capsule",
      cooldown = 16,
      range = 0,
      ammo_type =
      {
        category = "capsule",
        target_type = "position",
        action =
        {
          type = "direct",
          action_delivery =
          {
            type = "instant",
            target_effects =
            {
              {
                type = "damage",
                damage = {type = "physical", amount = -16}
              },
              {
                type = "play-sound",
                sound = sounds.eat_chorus_fruit_sound,
              },
              {
                type = "script",
                effect_id = "chorus_fruit_effect_id"
              }
            }
          }
        }
      }
    }
  },
  order = "h[raw-fish][chorus-fruit]",
  stack_size = 64
}

data:extend({
  chorusFruit
})
