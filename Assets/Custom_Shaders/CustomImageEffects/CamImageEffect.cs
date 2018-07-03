using UnityEngine;

[ExecuteInEditMode]
public class CamImageEffect : MonoBehaviour {

	public Material EffectMat;

	void OnRenderImage(RenderTexture src, RenderTexture dst)
	{
		Graphics.Blit (src, dst, EffectMat);
	}
}
