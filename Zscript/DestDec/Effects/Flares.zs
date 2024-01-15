Class DD_WhiteFlare:DD_FlareBase
{
	default
	{
		scale 0.50;
		+forcexybillboard;
		+rollsprite;
		+rollcenter;
	}
	states
	{
		Spawn:
			LFXW A 20;
			Loop;
	}
	
	override void beginplay()
	{
		A_setroll(random(0,360));
		super.beginplay();
	}
}

Class DD_RedFlare:DD_FlareBase
{
	default
	{
		scale 0.4;
		+forcexybillboard;
		+rollsprite;
		+rollcenter;
	}
	states
	{
		Spawn:
			LFXR A 20;
			Loop;
	}
	
	override void beginplay()
	{
		A_setroll(random(0,360));
		super.beginplay();
	}
}

Class DD_BlueFlare:DD_FlareBase
{
	default
	{
		scale 0.4;
		+forcexybillboard;
		+rollsprite;
		+rollcenter;
	}
	states
	{
		Spawn:
			LFXB A 20;
			Loop;
	}
	
	override void beginplay()
	{
		A_setroll(random(0,360));
		super.beginplay();
	}
}

Class DD_GreenFlare:DD_FlareBase
{
	default
	{
		scale 0.4;
		+forcexybillboard;
		+rollsprite;
		+rollcenter;
	}
	states
	{
		Spawn:
			LFXG A 20;
			Loop;
	}
	
	override void beginplay()
	{
		A_setroll(random(0,360));
		super.beginplay();
	}
}

Class DD_YellowFlare:DD_FlareBase
{
	default
	{
		scale 0.4;
		+forcexybillboard;
		+rollsprite;
		+rollcenter;
	}
	states
	{
		Spawn:
			LFXY A 20;
			Loop;
	}
	
	override void beginplay()
	{
		A_setroll(random(0,360));
		super.beginplay();
	}
}