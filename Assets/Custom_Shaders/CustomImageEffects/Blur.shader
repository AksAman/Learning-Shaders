// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Hidden/Blur"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}

	}
	SubShader{
		Pass
		{
			CGPROGRAM
			#include "UnityCG.cginc"
			#pragma vertex vert
			#pragma fragment frag

			struct appdata{
				float4 vertex:POSITION;
				float2 uv:TEXCOORD0;
			};

			struct v2f{
				float4 vertex:SV_Position;
				float2 uv:TEXCOORD0;
			};

			v2f vert(appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
				return o;
			}

			float4 Box(sampler2D tex, float2 uv, float4 size)
			{
				float4 total = (tex2D(tex, uv+float2(-size.x,size.y)) + tex2D(tex, uv+float2(0,size.y)) +tex2D(tex, uv+float2(size.x,size.y)) +
									tex2D(tex, uv+float2(-size.x,0))+ tex2D(tex, uv+float2(0,0))+ tex2D(tex, uv+float2(size.x,0))+
									tex2D(tex, uv+float2(-size.x,-size.y))+ tex2D(tex, uv+float2(0,-size.y))+ tex2D(tex, uv+float2(size.x,size.y)));
				return total/9;
			}

			sampler2D _MainTex;
			float4 _MainTex_TexelSize;

			float4 frag(v2f i):SV_Target
			{
				float4 col = Box(_MainTex, i.uv,_MainTex_TexelSize);
				return col;
			}
			ENDCG
		}
	}
}
