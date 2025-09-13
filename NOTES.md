# Shaders used
Pixel
- active_camouflage_draw (NoTint needs to be #1, TintEdgeDensity #2. These are flipped in-game)
- widget_sprite
- shadow_convolve
- transparent_water_opacity
- transparent_water_reflection
- transparent_water_bumpmap_convolution
- transparent_glass_reflection_bumped (registers differ between ce/retail)
- transparent_glass_reflection_flat
- transparent_plasma

(shader model has constants memes for retail)
- model_environment
- model_mask_change_color
- model_mask_multipurpose
- model_mask_none
- model_mask_reflection
- model_mask_self_illumination

- environment_fog
- environment_reflection_bumped
- environment_reflection_flat
- environment_reflection_flat_specular (stock one used in retail)
- environment_reflection_lightmap_mask
- environment_reflection_mirror_bumped (retail only. Cant seem to get it to make any difference in ce)
- environment_reflection_radiosity
- environment_lightmap_normal
- environment_lightmap_no_illumination
- environment_lightmap_no_illumination_no_lightmap (stock one used in retail)
- environment_lightmap_no_lightmap (stock one in retail)
- environment_diffuse_lights
- environment_specular_light_bumped (bunch of bullshit done to get rid of the texture/sampler mismatch the game expects will work. Needs chimera changes to work right)
- environment_specular_light_flat (as above)
- environment_specular_lightmap_bumped
- environment_specular_lightmap_flat
- environment_texture_normal_biased_add_biased_add
- environment_texture_normal_biased_add_biased_multiply
- environment_texture_normal_biased_add_multiply
- environment_texture_normal_biased_multiply_biased_add
- environment_texture_normal_biased_multiply_biased_multiply
- environment_texture_normal_biased_multiply_multiply
- environment_texture_normal_multiply_biased_add
- environment_texture_normal_multiply_multiply

Vertex
- transparent_water_opacity
- transparent_water_opacity_m
- transparent_water_reflection
- transparent_water_reflection_m

- environment_specular_spot_light


Most of the stock ps_2_0 shaders that retail uses have changes to the shader constants to be compatible within the d3dx effects. Check the constants when compiling these shaders against custom edition as they're probably different.

# Retail ps_2_0 shaders
- environment_lightmap_normal
- environment_lightmap_no_lightmap (1_4 in ce)
- environment_lightmap_no_illumination_no_lightmap (1_4 in ce)
- environment_reflection_flat_specular (1_4 in ce)
- environment_reflection_mirror_bumped (1_4 in ce)
- environment_reflection_mirror_flat (1_4 in ce)
- environment_reflection_mirror_flat_specular (1_4 in ce)
- transparent_glass_reflection_bumped
- transparent_glass_reflection_mirror (1_4 in ce)
- all of shader_model
- some of screen effect

# Shaders changed from CEnshine
- Changed transparent_glass_reflection_bumped (for retail samplers)
- Added transparent_glass_reflection_flat (made it work)
- Changed/Added shader_model (Added the rest, fixed the transparency issue with Sleds dev build, enabled xbox channel order support via a shader constant)
- Added environment_reflection_mirror_bumped (for retail)
- Changed environment_lightmap_normal (to support retail)
- Changed environment_lightmap_no_illumination (to use "con" fix via setting a shader constant)
- Changed environment_specular_light_bumped (to meme out the texture/sampler mismatch)
- Changed environment_specular_light_flat (as above)
- Changed/Added active_camouflage_draw (Fixed it)