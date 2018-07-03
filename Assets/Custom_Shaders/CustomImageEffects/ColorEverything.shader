// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Hidden/ColorEverything"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
		_Color("Color", Color) = (0.5,0.5,1,1)
	}

	SubShader
	{
		Pass
		{
			CGPROGRAM
			#include "UnityCG.cginc"
			#pragma vertex vert
			#pragma fragment frag

			struct appdata
			{
				float4 vertex: POSITION;
				float2 uv : Texcoord0;
			};

			struct v2f
			{
				float4 vertex: SV_Position;
				float2 uv:TEXCOORD0;
			};

			v2f vert(appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
				return o;
			}

			sampler2D _MainTex;
			float4 _Color;

			float4 frag(v2f i):SV_Target
			{
				float4 col = tex2D(_MainTex, i.uv)*_Color;
				return col;
			}
			ENDCG
		}
	}
}
