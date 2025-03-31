Title ""

Controls {
}

IOControls {
	outputFile = "./diode"
	EnableSections
}

Definitions {
	SubMesh "ExternalProfileDefinition_nwell" {
		Geofile = "diode_fps.tdr"
	}
	Refinement "RefinementDefinition_global" {
		MaxElementSize = ( 0.5 0.5 )
		MinElementSize = ( 0.1 0.1 )
	}
	Refinement "RefinementDefinition_nwell" {
		MaxElementSize = ( 0.5 0.5 )
		MinElementSize = ( 0.01 0.01 )
		RefineFunction = MaxTransDiff(Variable = "DopingConcentration",Value = 1)
	}
	Multibox "MultiboxDefinition_channel"
	{
		MaxElementSize = ( 0.5 0.5 )
		MinElementSize = ( 0.1 0.01 )
		Ratio = ( 1 1.4 )
	}
	Multibox "MultiboxDefinition_gate"
	{
		MaxElementSize = ( 0.05 0.05 )
		MinElementSize = ( 0.003 0.003 )
		Ratio = ( 1 1 )
	}
}

Placements {
	SubMesh "ExternalProfilePlacement_nwell" {
		Reference = "ExternalProfileDefinition_nwell"
		EvaluateWindow {
			Element = Rectangle [(-0.446744978428 -0.270567208529) (1.76576924324 6)]
			DecayLength = 0
		}
	}
	Refinement "RefinementPlacement_global" {
		Reference = "RefinementDefinition_global"
		RefineWindow = Rectangle [(-0.912239432335 -0.70767980814) (20.345636367798 6)]
	}
	Refinement "RefinementPlacement_nwell" {
		Reference = "RefinementDefinition_nwell"
		RefineWindow = Rectangle [(-0.446744978428 -0.270567208529) (1.76576924324 6)]
	}
	Multibox "MultiboxPlacement_channel" {
		Reference = "MultiboxDefinition_channel"
		RefineWindow = Rectangle [(-0.030388358980417 -0.072981245815754) (0.49514442682266 6)]
	}
	Multibox "MultiboxPlacement_gate" {
		Reference = "MultiboxDefinition_gate"
		RefineWindow = Rectangle [(-0.090562343597412 0.1) (0.36938488483429 2.9)]
	}
}

