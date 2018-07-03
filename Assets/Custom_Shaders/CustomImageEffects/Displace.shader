// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Hidden/Displace"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
		_DisplaceTex("Displacement Texture", 2D) = "White"{}
		_DispMag("Magnitude", range(0,1)) = 0.5
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
			sampler2D _DisplaceTex;
			float4 _Color;
			float _DispMag;

			float4 frag(v2f i):SV_Target
			{
				float2 disp = tex2D(_DisplaceTex, i.uv).xy;
				disp = ((2*disp) -1) *_DispMag*_SinTime.w;
				float4 col = tex2D(_MainTex, i.uv + disp)*_Color;
				return col;
			}
			ENDCG
		}
	}
}
