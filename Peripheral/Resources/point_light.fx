float3 screen = float3(320, 640, 0);
float3 pos = float3(289, 870, 0);
float angle;
float altangle;
float2 texel = 1 / 1080.0f;
float val1;
float pi = acos(-1);

Texture2D TextureSampler;

SamplerState TexSampler = sampler_state
{
};

float4 main(float4 p : SV_POSITION, float4 color : COLOR0, float2 uv : TEXCOORD0) : SV_TARGET0
{
	float4 tex = TextureSampler.Sample(TexSampler, uv);
	float2 pix = 1 * (uv - 0.25 - (pos - screen / 2)*texel);
	float r = sqrt(pix.x*pix.x + pix.y*pix.y);
	float4 light = val1 / (float4(r,r,r,r));
	return tex + tex * light*float4(0.3,0.6,1,0);//
}

technique Technique1
{
	pass Pass1
	{
		PixelShader = compile ps_4_0_level_9_1 main();
	}
}