float3 LightDirection;
float3 LightColor = 1.0;
float3 AmbientColor = 0.35;

Texture2D ScreenTexture;
Texture2D NormalTexture;

SamplerState TextureSampler = sampler_state
{
	Texture = <ScreenTexture>;
};

SamplerState NormalSampler = sampler_state
{
	Texture = <NormalTexture>;
};

float3 CalculateLight(float3 position, float3 color, float3 normal, float3 pixelPosition)
{

	float3 direction = position - pixelPosition;
	float atten = length(direction);

	direction /= atten;

	float amount = max(dot(normal, direction), 0);

	atten *= 0.01;

	float modifer = max((1 - atten), 0);

	return color * modifer * amount;
}
float Angle;
float3 LightPos;
float4 main(float4 pos : SV_POSITION, float4 color : COLOR0, float2 texCoord : TEXCOORD0) : SV_TARGET0
{
	float4 tex = ScreenTexture.Sample(TextureSampler, texCoord);
	float3 pixelPosition = float3(320 * texCoord.x, 620 * texCoord.y,0);

	float4 normal = normalize(2 * NormalTexture.Sample(NormalSampler, texCoord) - 1);

	float3 finalColor = 0;
	finalColor += CalculateLight(LightPos, LightColor, normal, pixelPosition);

	float lightAmount = saturate(dot(normal.xyz, LightDirection * -1));
	color.rgb *= AmbientColor + finalColor;

	return color * tex;
}

technique Normalmap
{
	pass Pass1
	{
		PixelShader = compile ps_4_0_level_9_1 main();
	}
}
