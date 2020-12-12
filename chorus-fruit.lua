local sounds = require ("eating-sounds")

local chorusFruit = {
  type = "capsule",
  name = "chorus-fruit",
  icon = "__factorio-chorus-fruit__/graphics/Chorus_Fruit_JE2_BE2.png",
  icon_size = 150,
  subgroup = "transport",
  order = "b[personal-transport]-c[spidertron]-b[remote]-a[chorusfruit]",
  capsule_action =
  {
    type = "use-on-self",
    attack_parameters =
    {
      type = "projectile",
      activation_type = "consume",
      ammo_category = "capsule",
      cooldown = 60,
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
                damage = {type = "physical", amount = -8}
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
  stack_size = 64
}

local chorusFruitRecipe = {
  type = "recipe",
  name = "chorus-fruit",
  category = "crafting-with-fluid",
  subgroup = "transport",
  order = "b[personal-transport]-c[spidertron]-b[remote]-a[chorusfruit]",
  ingredients = {
    {"wood",4},
    {"uranium-ore",2},
    {type="fluid", name="water", amount=400}
  },
  energy_required = 64,
  result = "chorus-fruit",
  enabled = "true"
}

data:extend({
  chorusFruit,
  chorusFruitRecipe
})
