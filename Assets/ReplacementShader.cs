using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class ReplacementShader : MonoBehaviour {

	public Shader replacementShader;
	public Color OverDrawColor;


	void OnValidate()
	{
		Shader.SetGlobalColor ("_OverDrawColor", OverDrawColor);
	}
	void OnEnable()
	{
		if(replacementShader != null)
		{
			GetComponent<Camera> ().SetReplacementShader (replacementShader, "");
		}
	}

	void OnDisable()
	{
		GetComponent<Camera> ().ResetReplacementShader ();
	}
}
