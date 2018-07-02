// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/TextureAlpha" {
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
		_SecondTex("Texture", 2D) = "white"{}
		_Color("Tint", Color) = (1,1,1,1)
		_Tween("Tween", Range(0,1)) = 0
	}

	SubShader
	{
		Tags
		{
			"Queue" = "Transparent"
			"PreviewType" = "Plane"
		}

		Pass
		{
			Blend SrcAlpha OneMinusSrcAlpha
//			Blend One One

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
				float2 uv : TEXCOORD0;
			};

			v2f vert(appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv=v.uv;
				return o;
			}

			sampler2D _MainTex;
			sampler2D _SecondTex;
			float _Tween;
			float4 _Color;
			float4 frag(v2f i):SV_Target
			{
//				float4 color = (tex2D(_MainTex, i.uv) * (1-_Tween)  + tex2D(_SecondTex, i.uv) * _Tween) * _Color;
				float4 color= tex2D(_MainTex, i.uv);
				float lum = 0.3 * color.r + 0.59 * color.g +0.11*color.b;
				float4 finalCol = (float4(lum,lum,lum,color.a)) ;
				return lum* _Color;
			}

			ENDCG	
		}
	}
}
