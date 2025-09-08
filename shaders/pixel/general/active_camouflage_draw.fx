SamplerState TexS0 : register(s0);
TextureCube Texture0 : register(s0);

SamplerState TexS2 : register(s2);
Texture2D Texture2 : register(s2);

struct PS_INPUT {
	float4 Pos : SV_POSITION;
	float4 D0 : COLOR0;
	float4 D1 : COLOR1;
	float4 T0 : TEXCOORD0;
	float4 T1 : TEXCOORD1;
	float4 T2 : TEXCOORD2;
};

cbuffer constants_buffer {
	float4 constants[1];
	//float4 c_effect_intensity;
	//float4 c_split_screen_offset_and_scale;
}

// Pass TintEdgeDensity
half4 main_T0_P0(PS_INPUT i) : SV_TARGET
{
	// Inputs
	half3 Tex0 = i.T0;
	half3 Tex1 = i.T1;
	half3 Tex2 = i.T2;

	float4 c_effect_intensity = constants[0];

	half distance_scale = i.D0.a;
	half3 tint_color = i.D0.rgb;

	half4 r0;

	half4 t0 = Texture0.Sample(TexS0, Tex0.xyz);
	// Fudge factor to match Xbox/MCC refraction
	Tex1.x *= 0.5;
	Tex2.y *= 0.5;

	half2 uv_offset = half2(dot(2*t0.xyz-1, Tex1.xyz), dot(2*t0.xyz-1, Tex2.xyz));
	half4 t2 = Texture2.Sample(TexS2, saturate(uv_offset.xy)); 

	r0.rgb = lerp(1, tint_color, t0.a);
	r0.rgb = lerp(1, r0.rgb, distance_scale) * t2;
	r0.a = c_effect_intensity.a;

	return r0;
};

// Pass NoEdgeTint
half4 main_T0_P1(PS_INPUT i) : SV_TARGET
{
	// Inputs
	half3 Tex0 = i.T0;
	half3 Tex1 = i.T1;
	half3 Tex2 = i.T2;

	float4 c_effect_intensity = constants[0];

	half distance_scale = i.D0.a;
	half3 tint_color = i.D0.rgb;

	half4 r0;

	half4 t0 = Texture0.Sample(TexS0, Tex0.xyz);
	// Fudge factor to match Xbox/MCC refraction
	Tex1.x *= 0.5;
	Tex2.y *= 0.5;

	half2 uv_offset = half2(dot(2*t0.xyz-1, Tex1.xyz), dot(2*t0.xyz-1, Tex2.xyz));
	half4 t2 = Texture2.Sample(TexS2, saturate(uv_offset.xy)); 

	r0.rgb = lerp(1, tint_color, distance_scale) * t2;
	r0.a = c_effect_intensity.a;

	return r0;
};

