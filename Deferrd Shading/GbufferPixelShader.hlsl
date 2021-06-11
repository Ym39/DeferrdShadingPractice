Texture2D bufferTexture : register(t0);

SamplerState SampleTypePoint : register(s0);

struct PixelInputType
{
	float4 position : SV_POSITION;
	float2 tex : TEXCOORD0;
};

float4 PS(PixelInputType input) : SV_TARGET
{
	float4 colors;

	colors = bufferTexture.Sample(SampleTypePoint, input.tex);

	return colors;
}