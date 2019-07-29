float3 screen = float3(320, 640, 0);
float3 pos = float3(0.5, 0.5, 0);
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
	float2 pix = 2 * (uv - 0.5 - (pos - screen / 2)*texel);
	float r = sqrt(pix.x*pix.x + pix.y*pix.y);
	float2 dir = -normalize(uv - pix);
	float4 tex1 = TextureSampler.Sample(TexSampler, lerp(uv, uv + (dir), val1));
	return tex1;//+tex*float4(cos(r*val1*120),0.6,0.8,1);//
}

technique Technique1
{
	pass Pass1
	{
		PixelShader = compile ps_4_0_level_9_1 main();
	}
}