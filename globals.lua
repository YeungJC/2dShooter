default_color = {222, 222, 222}
background_color = {16, 16, 16}
ammo_color = {123, 200, 164}
boost_color = {76, 195, 217}
healthpack_color = {255,0,0}
hp_color = {241, 103, 69}
skill_point_color = {255, 198, 93}
sp_color = {204,102,0}
rapid_color = {138, 43, 226}         
double_color = {255, 255, 102}        
triple_color = {255, 80, 80}

default_colors = {default_color, hp_color, ammo_color, boost_color, skill_point_color,healthpack_color,sp_color,rapid_color,double_color,triple_color}
negative_colors = {
    {255-default_color[1], 255-default_color[2], 255-default_color[3]}, 
    {255-hp_color[1], 255-hp_color[2], 255-hp_color[3]}, 
    {255-ammo_color[1], 255-ammo_color[2], 255-ammo_color[3]}, 
    {255-boost_color[1], 255-boost_color[2], 255-boost_color[3]}, 
    {255-skill_point_color[1], 255-skill_point_color[2], 255-skill_point_color[3]},
    {255-healthpack_color[1], 255-healthpack_color[2], 255-healthpack_color[3]},
    {255-sp_color[1], 255-sp_color[2], 255-sp_color[3]},
    {255-rapid_color[1], 255-rapid_color[2], 255-rapid_color[3]},
    {255-double_color[1], 255-double_color[2], 255-double_color[3]},
    {255-triple_color[1], 255-triple_color[2], 255-triple_color[3]}

    
}
all_colors = fn.append(default_colors, negative_colors)

attacks = {
    ['Neutral'] = {cooldown = 0.24, ammo = 0, abbreviation = 'N', color = default_color, box_color = default_color},
    ['Double'] = {cooldown = 0.32, ammo = 2, abbreviation = 'D', color = ammo_color, box_color = double_color},
    ['Triple'] = {cooldown = 0.32, ammo = 3, abbreviation = 'T', color = boost_color, box_color = triple_color},
    ['Rapid'] = {cooldown = 0.12, ammo = 1, abbreviation = 'R', color = default_color, box_color = rapid_color},
}

attack_keys = {'Double', 'Triple', 'Rapid'}
