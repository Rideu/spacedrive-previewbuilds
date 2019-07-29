

#define VS_SHADERMODEL vs_4_0_level_9_1
#define PS_SHADERMODEL ps_4_0_level_9_1

SamplerState TexSampler : register(s0);
Texture2D TextureSampler : register(t0);
Texture2D RefractSampler : register(t1);

float3 screen = float3(320, 640, 0);
float3 pos = float3(0.5, 0.5, 0);
float angle;
float altangle;

float4 EdgeDetectionFilter(Texture2D tex, float2 uv)
{
	float dx = 2080;
	float dy = 2080;
	dx = 1.0f / dx;
	dy = 1.0f / dy;

	float4 color0 = -2.0f * tex.Sample(TexSampler, uv + float2(-dx, 0));
	float4 color1 = -tex.Sample(TexSampler, uv + float2(-dx, dy));
	float4 color2 = -tex.Sample(TexSampler, uv + float2(-dx, -dy));
	float4 color3 = 2.0f * tex.Sample(TexSampler, uv + float2(dx, 0));
	float4 color4 = tex.Sample(TexSampler, uv + float2(dx, dy));
	float4 color5 = tex.Sample(TexSampler, uv + float2(dx, -dy));
	float4 sumX = color0 + color3;
	float4 color6 = -2.0f * tex.Sample(TexSampler, uv + float2(0, -dy));
	float4 color7 = -tex.Sample(TexSampler, uv + float2(dx, -dy));
	float4 color8 = color2;
	float4 color9 = 2.0f * tex.Sample(TexSampler, uv + float2(0, dy));
	float4 color10 = color4;
	float4 color11 = tex.Sample(TexSampler, uv + float2(-dx, dy));
	float4 sumY = color6 + color9;

	float4 t = (color6 + color9);//*float4(float3(0.5,1,0.5)*0.1,1);
	float4 r = (color11 - color10);//*float4(float3(1,0.5,0.5)*0.1,1);
	float4 l = (color3 + color0);//*float4(float3(0,0.5,0.5)*0.1,1);
	float4 b = (color5 - color4);//*float4(float3(0.5,0,0.5)*0.1,1);

	float4 tr = (color6 + color9) + (color11 - color10);
	float4 tl = (color6 + color9) + (color3 + color0);

	float4 br = (color5 - color4) + (color11 - color10);
	float4 bl = (color5 - color4) + (color3 + color0);
	return (normalize(tr) / 10 + tl + br + bl);
	//return sumY*float4(0.5,1,0.5,1)+sumX*float4(0,0.5,0.5,1);
}

float4 main(float4 pos : SV_POSITION, float4 Diffuse : COLOR, float2 uv : TEXCOORD0) : SV_TARGET0
{
	return EdgeDetectionFilter(TextureSampler , uv);
}

technique Warper
{
	pass P0
	{
		//VertexShader = compile VS_SHADERMODEL vs_main();
		PixelShader = compile PS_SHADERMODEL main();
	}
};

