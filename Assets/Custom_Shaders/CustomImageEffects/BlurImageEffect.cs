using UnityEngine;

//[ExecuteInEditMode]
public class BlurImageEffect : MonoBehaviour {

	public Material BlurShaderMat;

	[Range(0,10)]
	public int iterations = 5;

	public bool useDownScale;

	[Range(0,4)]
	public int downRes;
	int width,height;

	void OnRenderImage(RenderTexture src, RenderTexture dst)
	{
		if(useDownScale)
		{
			width = src.width >> downRes;
			height = src.height >> downRes;
		}
		else{
			width = src.width;
			height = src.height;
		}
		RenderTexture tempRT = RenderTexture.GetTemporary (width, height);
		Graphics.Blit (src, tempRT);

		for (int i = 0; i < iterations; i++) {
			RenderTexture tempRT2 = RenderTexture.GetTemporary (width,height);
			Graphics.Blit (tempRT, tempRT2, BlurShaderMat);

			RenderTexture.ReleaseTemporary (tempRT);
			tempRT = tempRT2;
		}

		Graphics.Blit (tempRT, dst);
		RenderTexture.ReleaseTemporary (tempRT);
	}
}
