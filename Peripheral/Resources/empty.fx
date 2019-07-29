float3 Color = 1.0f;

Texture2D TextureSampler;

SamplerState TexSampler = sampler_state
{
};

float4 main(float4 p : SV_POSITION, float4 color : COLOR0, float2 uv : TEXCOORD0) : SV_TARGET0
{
	float4 tex = TextureSampler.Sample(TexSampler, uv);
	return tex;
}

technique Technique1
{
	pass Pass1
	{
		PixelShader = compile ps_4_0_level_9_1 main();
	}
}