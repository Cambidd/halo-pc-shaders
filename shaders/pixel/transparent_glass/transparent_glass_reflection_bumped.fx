SamplerState TexSampler0 : register(s0);
Texture2D Texture0 : register(s0);

SamplerState TexSampler3 : register(s2);
TextureCube Texture3 : register(s2);

struct PS_INPUT {
   float4 Pos : SV_POSITION;
   float4 D0 : COLOR0;
   float4 D1 : COLOR1;
   float4 T0 : TEXCOORD0;
   float4 T1 : TEXCOORD1;
   float4 T2 : TEXCOORD2;
   float4 T3 : TEXCOORD3;
};

cbuffer constants_buffer {
   half4 constants[4];
   //float4 c_eye_forward;
   //float4 c_view_perpendicular_color; 
   //float4 c_view_parallel_color; 
   //float4 params;
}

void CalculateEyeDirAndNormal(half2 Tex0, half4 Tex1, half4 Tex2, half4 Tex3, out half3 E, out half3 N)
{
	E = normalize(half3(Tex1.w, Tex2.w, Tex3.w));

	half3 bump_color = 2*Texture0.Sample(TexSampler0, Tex0.xy)-1; // texture0: bump map
	N = normalize(half3(dot(Tex1, bump_color), dot(Tex2, bump_color), dot(Tex3, bump_color)));
}

// GlassReflectionBumped
half4 main(PS_INPUT i) : SV_TARGET
{
	// Inputs
	half4 Diff = i.D0;
	half2 Tex0 = i.T0;
	half4 Tex1 = i.T1;
	half4 Tex2 = i.T2;
	half4 Tex3 = i.T3;

   // Constants (because Gearbox doesn't support cbuffers)
   half4 c_eye_forward = constants[0];
   half4 c_view_perpendicular_color = constants[1]; 
   half4 c_view_parallel_color = constants[2];
   half4 params = constants[3];

   half3 E, N;
   CalculateEyeDirAndNormal(Tex0, Tex1, Tex2, Tex3, E, N);
   half3 R = normalize(2*dot(N, E)*N - E);
	
	half3 reflection_color = Texture3.Sample(TexSampler3, R.xyz); // texture3: specular reflection cube map
	half3 specular_color = pow(reflection_color, 8);
	
	half diffuse_reflection = pow(dot(N, E), 2);


   half specular_mask = Diff.a * params.x; // group intensity

	half attenuation = lerp( c_view_parallel_color.a, c_view_perpendicular_color.a, diffuse_reflection );
	
	half3 tint_color = lerp( c_view_parallel_color, c_view_perpendicular_color, diffuse_reflection );
	
	half3 tinted_reflection = lerp( specular_color, reflection_color, tint_color );

	half3 final_color = tinted_reflection * ( attenuation * specular_mask );

   return half4(final_color, 1.0);
}

