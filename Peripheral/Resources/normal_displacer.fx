
#define VS_SHADERMODEL vs_4_0_level_9_1
#define PS_SHADERMODEL ps_4_0_level_9_1

SamplerState TexSampler : register(s0);
Texture2D TextureSampler : register(t0);
Texture2D RefractSampler : register(t1);

float3 screen = float3(320, 640, 0);
float3 pos = float3(0.5, 0.5, 0);
float angle;
float altangle;
float2 Displace(float2 uv, float4 normal)
{
	float4 color1 = normal;
	float2 coords;
	float mul;

	coords = uv - pos / screen;

	mul = (color1.r * 0.5f);

	coords.x += (color1.r * mul) - mul / 2;
	coords.y += (color1.g * mul) - mul / 2;

	return coords;
}

float4 main(float4 pos : SV_POSITION, float4 Diffuse : COLOR, float2 uv : TEXCOORD0) : SV_TARGET0
{
	float4 offset = RefractSampler.Sample(TexSampler, uv);
	float2 local = Displace(uv, offset);
	return TextureSampler.Sample(TexSampler, local);
}

technique Warper
{
	pass P0
	{
		//VertexShader = compile VS_SHADERMODEL vs_main();
		PixelShader = compile PS_SHADERMODEL main();
	}
};
