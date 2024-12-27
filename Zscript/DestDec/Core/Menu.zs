// little custom menu with tooltips

Class OptionMenuItemDDOption : OptionMenuItemOption
{
	string mtooltip;
	
	OptionMenuItemDDOption Init(String label, String tooltip, Name command, Name values, CVar graycheck = null, int center = 0)
	{
		mtooltip = tooltip;
		Super.init(label,command,values,graycheck,center);
		return self;
	}
}

Class OptionMenuItemDDSlider : OptionMenuItemSlider
{
	string mtooltip;
	OptionMenuItemDDSlider Init(String label, String tooltip, Name command, double min, double max, double step, int showval = 1)
	{
		mTooltip = tooltip;
		Super.Init(label, command, min, max, step, showval);
		return self;
	}
}


Class DestDecMenu : OptionMenu
{
	private BrokenLines bkln;
	int prevSel;
	
	override void Drawer ()
	{
		Super.Drawer();
		
		string tip;
		Font tf;
		
		if (mDesc.mSelectedItem > 0)
		{
			if(mDesc.mItems[mDesc.mSelectedItem] is "OptionMenuItemDDOption")
				tip = StringTable.Localize(OptionMenuItemDDOption(mDesc.mItems[mDesc.mSelectedItem]).mtooltip);
			
			if(mDesc.mItems[mDesc.mSelectedItem] is "OptionMenuItemDDSlider")
				tip = StringTable.Localize(OptionMenuItemDDSlider(mDesc.mItems[mDesc.mSelectedItem]).mtooltip);
		}
		
		if(mDesc.mSelectedItem != prevSel)
		{
			prevSel = mDesc.mSelectedItem;
		}
		
		if(tip.length() > 0)
		{
			if(!tf)
				tf = OptionFont(); 
			double xm = (Screen.GetWidth() - tf.StringWidth (tip) * CleanXfac_1) / 2;
			double ym = (tf.GetHeight() * CleanYfac_1 * 2.5);
			if(!bkln)
				bkln = tf.BreakLines(tip,256);
			
			double dimy = bkln.count() * tf.GetHeight()* CleanYfac_1 * 0.5; 
			Screen.dim("050505",
			0.9,	//a
			xm, 	//x
			ym,		//y
			 tf.StringWidth (tip),	// w
			dimy);		//h
			
			Screen.DrawText(tf, OptionMenuSettings.mFontColorValue,			//font, color
			xm, 	//x
			ym,	//y
			tip, //str
			DTA_CleanNoMove_1, true
			); //flags
			bkln.destroy();
		}
		
	}
}