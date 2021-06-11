////////////////////////////////////////////////////////////////////////////////
// Filename: light_ps.hlsl
////////////////////////////////////////////////////////////////////////////////


/////////////
// GLOBALS //
/////////////
Texture2D colorTexture : register(t0);
Texture2D normalTexture : register(t1);


///////////////////
// SAMPLE STATES //
///////////////////
SamplerState SampleTypePoint : register(s0);


//////////////////////
// CONSTANT BUFFERS //
//////////////////////
cbuffer LightBuffer
{
	float3 lightDirection;
	float padding;
};


//////////////
// TYPEDEFS //
//////////////
struct PixelInputType
{
	float4 position : SV_POSITION;
	float2 tex : TEXCOORD0;
};


////////////////////////////////////////////////////////////////////////////////
// Pixel Shader
////////////////////////////////////////////////////////////////////////////////
float4 LightPixelShader(PixelInputType input) : SV_TARGET
{
	float4 colors;
	float4 normals;
	float3 lightDir;
	float lightIntensity;
	float4 outputColor;


	// �� �ؽ�ó ��ǥ ��ġ���� ����Ʈ ���÷��� ����Ͽ� �÷� ������ �ؽ�ó���� ������ ���ø��մϴ�.
	colors = colorTexture.Sample(SampleTypePoint, input.tex);

	// �� �ؽ��� ��ǥ ��ġ���ִ� ����Ʈ ���÷��� ����Ͽ� normal ���� �ؽ�ó�κ��� ������ ���ø��մϴ�.
	normals = normalTexture.Sample(SampleTypePoint, input.tex);
	
	// ����� ���� �� ������ ������ŵ�ϴ�.
	lightDir = -lightDirection;

	// �� �ȼ��� ���� ���� ����մϴ�.
	lightIntensity = saturate(dot(normals.xyz, lightDir));

	// ������ ���� �� �ȼ��� ������ ������� ���� ���� Ȯ�� ���� �����մϴ�.
	outputColor = saturate(colors * lightIntensity);

	return outputColor;
}