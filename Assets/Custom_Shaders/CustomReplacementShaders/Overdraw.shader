Shader "Custom/Overdraw" {
	// Replacement shader for overdraw effect
	Properties
	{
		_OverDrawColor("Over draw color", Color) = (1,1,1,1)
	}

	SubShader
	{
		
		Tags
		{
			"Queue" = "Transparent"
		}

		ZWrite Off
		ZTest Always
		Blend One One
		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			struct v2f
			{
				float4 vertex : SV_Position;
			};

			v2f vert(appdata_base v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				return o;
			}

			fixed4 _OverDrawColor;
			fixed4 frag(v2f i):SV_Target
			{
				return _OverDrawColor;
			}
			ENDCG
		}

	}
}
