Class DD_GizmoBase : DD_ShotDecoBase
{
	int gizmocolor;
	property gizmocolor:gizmocolor;
	Actor Gizmo;
	Bool GizmoAlive;
	Default
	{
		Radius 16;
		Height 50;
		+SOLID
		DD_GizmoBase.gizmocolor GZ_BLUE;
	}
	enum gizmcol {
		GZ_BLUE = 1,
		GZ_GREEN = 2,
		GZ_YELLOW = 3
	}
	
	void A_SpawnGizmo(int col = GZ_BLUE) //1 blue 2 green 3 yellow
	{
		Gizmo = Spawn("DD_GizmoBall",(pos.XY,pos.z + 64));
		if(!Gizmo)
			return;
		GizmoAlive = true;
		switch(col)
		{
			case 1: Gizmo.setstatelabel("Spawn_Blue"); break;
			case 2: Gizmo.setstatelabel("Spawn_Green"); break;
			case 3: Gizmo.setstatelabel("Spawn_Yellow"); break;
		}
		
	}
	
	virtual void A_KillGizmo()
	{
		A_killFlare();
		if(GizmoAlive)
		{
			A_startsound("TorchOffFx",69,0,1.0,ATTN_NORM,frandom(0.9,1.1));
			A_Startsound("GlassBreakFx",60);
		}	
		if(Gizmo)
			Gizmo.destroy();
		GizmoAlive = false;
	}
	
	void A_SpawnOrbFxs(string fx = "DD_BS1")
	{
		FSpawnParticleParams FxParticle;
		FxParticle.Texture = TexMan.CheckForTexture(fx);
		FxParticle.Color1 = "FFFFFF";
		FxParticle.Style = STYLE_Add;
		FxParticle.Flags = SPF_ROLL|SPF_FULLBRIGHT;
		FxParticle.Vel = (FRandom(-0.7,0.7),FRandom(-0.7,0.7),FRandom (0.5,1.0));
		FxParticle.Accel = (0,0,frandom(-0.1,-0.15));
		FxParticle.Startroll = random(0,360);
		FxParticle.RollVel = frandom(-0.5,0.5);
		FxParticle.StartAlpha = 0.45;
		//FxParticle.FadeStep = 0.1;
		FxParticle.Size = frandom(15,32);
		FxParticle.SizeStep = -0.5;
		FxParticle.Lifetime = FRandom (35,85); 
		FxParticle.Pos = vec3offset(random(-5,5),random(-5,5),random(55,65));
		Level.SpawnParticle (FxParticle);
	}
	
	override void PostBeginplay()
	{
		A_SpawnGizmo(gizmocolor);
		string flare;
		switch(gizmocolor)
		{
			case GZ_BLUE: flare = "DD_BlueFlare"; break;
			case GZ_GREEN: flare = "DD_GreenFlare"; break;
			case GZ_YELLOW: flare = "DD_YellowFlare"; break;
		}
		A_SpawnLensFlare(flare,64,(0.3,0.3));
		super.beginplay();
	}
}

Class DD_GizmoBall : NoTickActor
{
	default
	{
		renderstyle "Add";
		//alpha 0.75;
		scale 1.25;
		+bright;
	}
	states
	{
		spawn:
		Spawn_Blue:
			KGZB A -1;
			stop;
		Spawn_Green:
			KGZG A -1;
			stop;
		Spawn_Yellow:
			KGZY A -1;
			stop;
	}
}

Class DD_KeyGizmoBlue : DD_GizmoBase 
{
	states
	{
		Spawn:
			HKH1 A 1 A_SpawnOrbFxs();
			TNT1 A 0 A_jumpif(health < slightdamaged,"NoGizmo");
			loop;
		NoGizmo:
			TNT1 A 0 A_KillGizmo();
		NoGizmoLoop:
			HKH1 A 1;
			TNT1 A 0 A_jumpif(health < halflife,"MidDamage");
			loop;
		MidDamage:
			TNT1 A 0 A_KillGizmo();
			TNT1 A 0 A_Startsound("StoneFx",62);
			TNT1 A 0 DD_SpawnDebris("RockDebris1",random(4,6),(0,0,40),random(3,8),random(3,8));
			HKH1 B -1;
			stop;
		Death:
			TNT1 A 0 A_KillGizmo();
			TNT1 A 0 A_Startsound("StoneFx",62);
			TNT1 A 0 DD_SpawnDebris("RockDebris1",random(4,10),(0,0,40),random(3,8),random(3,8));
			HKH1 C -1;
			stop;
	}
	override void postbeginplay()
	{
		if(DD_DynLights)
			A_AttachLightDef('Bleu1',"BluetorchLightBig");
		super.postbeginplay();
	}
	
	override void A_KillGizmo()
	{
		A_RemoveLight('Bleu1');
		super.A_KillGizmo();
	}
}

Class DD_KeyGizmoGreen : DD_KeyGizmoBlue
{
	default
	{
		DD_GizmoBase.gizmocolor GZ_GREEN;
	}
	states
	{
		Spawn:
			HKH1 A 1 A_SpawnOrbFxs("DD_GS1");
			TNT1 A 0 A_jumpif(health < slightdamaged,"NoGizmo");
			loop;
	}
	
	override void postbeginplay()
	{
		if(DD_DynLights)
			A_AttachLightDef('Green1',"GreentorchLightBig");
		super.postbeginplay();
	}
	
	override void A_KillGizmo()
	{
		A_RemoveLight('Green1');
		super.A_KillGizmo();
	}
	
}

Class DD_KeyGizmoYellow : DD_KeyGizmoBlue 
{
	default
	{
		DD_GizmoBase.gizmocolor GZ_YELLOW;
	}
	states
	{
		Spawn:
			HKH1 A 1 A_SpawnOrbFxs("DD_RS1");
			TNT1 A 0 A_jumpif(health < slightdamaged,"NoGizmo");
			loop;
	}
	
	override void postbeginplay()
	{
		if(DD_DynLights)
			A_AttachLightDef('YEL1',"YellowLampBig");
		super.postbeginplay();
	}
	
	override void A_KillGizmo()
	{
		A_RemoveLight('YEL1');
		super.A_KillGizmo();
	}
}