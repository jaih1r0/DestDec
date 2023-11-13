Class DD_TorchBase : DD_ShotDecoBase
{
	default
	{
		Radius 16;
		Height 68;
		ProjectilePassHeight -16;
		+SOLID
	}
	bool FireOn;
	
	void A_SpawnFireFx(string spt = "DD_RF1",int zoffset = 54)
	{			
		FSpawnParticleParams FireParticle;
		FireParticle.Texture = TexMan.CheckForTexture (spt);
		FireParticle.Color1 = "FFFFFF";
		FireParticle.Style = STYLE_Add;
		FireParticle.Flags = SPF_ROLL|SPF_FULLBRIGHT;
		FireParticle.Vel = (FRandom (0.1,-0.1),FRandom (0.1,-0.1),FRandom (0.1,1.5)); 
		FireParticle.Startroll = random(0,360);
		FireParticle.RollVel = frandom(-0.5,0.5);
		FireParticle.StartAlpha = 0.45;
		FireParticle.FadeStep = -0.1;
		FireParticle.Size = frandom(15,32);
		FireParticle.SizeStep = -0.5;
		FireParticle.Lifetime = FRandom (35,35*3); 
		FireParticle.Pos = vec3offset(0,0,zoffset);
		
		Level.SpawnParticle (FireParticle);

	}
	
	void A_SpawnSmokeFx(int zoffset = 70)
	{
		if(DD_NoSmokeFx) return;
		FSpawnParticleParams Smkfx;
		Smkfx.Texture = TexMan.CheckForTexture ("DD_BSM1");
		Smkfx.Color1 = "FFFFFF";
		Smkfx.Style = STYLE_Translucent;
		Smkfx.Flags = SPF_ROLL;
		Smkfx.Vel = (frandom (0.1,-0.1),frandom (0.1,-0.1),frandom (0.6,1.5)); 
		Smkfx.Startroll = random(0,360);
		Smkfx.RollVel = frandom(-0.2,0.2);
		Smkfx.StartAlpha = 0.35;
		Smkfx.FadeStep = -0.1;
		Smkfx.Size = frandom(20,40);
		Smkfx.SizeStep = 1.5;
		Smkfx.Lifetime = fRandom(35,35*4); 
		Smkfx.Pos = vec3offset(0,0,zoffset);
		
		Level.SpawnParticle (Smkfx);
	}
	
	void DD_TurnTorchFire(bool set = false)
	{
		FireOn = set;
	}
	
	override void beginplay()
	{
		A_Startsound("TorchLoop",69,CHANF_LOOPING,1.0,ATTN_NORM,frandom(0.1,1.1));
		FireOn = true;
		super.beginplay();
	}
	
}

Class DD_RedTorch : DD_TorchBase //replaces RedTorch
{
	states
	{
		Spawn:
			TRCS A 2 A_SpawnFireFx();
			TNT1 A 0 A_jumpif(health < slightdamaged,"NoFire");
			TRCS A 2 A_SpawnFireFx();
			TNT1 A 0 A_jumpif(health < slightdamaged,"NoFire");
			TRCS A 1 A_SpawnSmokeFx();
			TNT1 A 0 A_jumpif(health < slightdamaged,"NoFire");
			loop;
		NoFire:
			TNT1 A 0 A_RemoveLight('Red1');
			TNT1 A 0 A_stopsound(69);
			TNT1 A 0 DD_TurnTorchFire();
			TNT1 A 0 A_startsound("TorchOffFx",69,0,1.0,ATTN_NORM,frandom(0.9,1.1));
			TNT1 A 0 A_killFlare();
		NoFireLoop:
			TRCS A 2;
			loop;
		Xdeath:
		Death:
			TNT1 A 0 A_stopsound(69);
			TNT1 A 0 {
				if(FireOn)
					A_startsound("TorchOffFx",69,0,1.0,ATTN_NORM,frandom(0.9,1.1));
			}
			TNT1 A 0 A_Startsound("MetalFx",61);
			TNT1 A 0 A_startsound("TinMetalFx",70);
			TNT1 A 0 A_RemoveLight('Red1');
			TNT1 A 0 DD_SpawnDebris("MetalScrap1",random(3,6),(0,0,30),random(3,10),random(3,10));
			TNT1 A 0 A_SpawnEndSmokeFx(0,0,30);
			TNT1 A 0 A_killFlare();
			TRCS B -1;
			stop;
	}
	
	
	override void postbeginplay()
	{
		A_SpawnLensFlare("DD_RedFlare",56);
		if(DD_DynLights)
			A_AttachLightDef('Red1',"RedtorchLightBig");
		super.postbeginplay();
	}
}

Class DD_BlueTorch : DD_TorchBase //replaces BlueTorch
{
	states
	{
		Spawn:
			TRCS A 2 A_SpawnFireFx("DD_BF1");
			TNT1 A 0 A_jumpif(health < slightdamaged,"NoFire");
			TRCS A 2 A_SpawnFireFx("DD_BF1");
			TNT1 A 0 A_jumpif(health < slightdamaged,"NoFire");
			TRCS A 1 A_SpawnSmokeFx();
			TNT1 A 0 A_jumpif(health < slightdamaged,"NoFire");
			loop;
		NoFire:
			TNT1 A 0 A_stopsound(69);
			TNT1 A 0 A_killFlare();
			TNT1 A 0 DD_TurnTorchFire();
			TNT1 A 0 A_startsound("TorchOffFx",69,0,1.0,ATTN_NORM,frandom(0.9,1.1));
			TNT1 A 0 A_RemoveLight('Blue1');
		NoFireLoop:
			TRCS A 2;
			loop;
		Xdeath:
		Death:
			TNT1 A 0 A_stopsound(69);
			TNT1 A 0 {
				if(FireOn)
					A_startsound("TorchOffFx",69,0,1.0,ATTN_NORM,frandom(0.9,1.1));
			}
			TNT1 A 0 A_Startsound("MetalFx",61);
			TNT1 A 0 A_startsound("TinMetalFx",70);
			TNT1 A 0 A_RemoveLight('Blue1');
			TNT1 A 0 DD_SpawnDebris("MetalScrap1",random(3,6),(0,0,30),random(3,10),random(3,10));
			TNT1 A 0 A_SpawnEndSmokeFx(0,0,30);
			TNT1 A 0 A_killFlare();
			TRCS B -1;
			stop;
	}
	
	override void postbeginplay()
	{
		A_SpawnLensFlare("DD_BlueFlare",56);
		if(DD_DynLights)
			A_AttachLightDef('Blue1',"BluetorchLightBig");
		super.postbeginplay();
	}
}

Class DD_GreenTorch : DD_TorchBase //replaces GreenTorch
{
	states
	{
		Spawn:
			TRCS A 2 A_SpawnFireFx("DD_GF1");
			TNT1 A 0 A_jumpif(health < slightdamaged,"NoFire");
			TRCS A 2 A_SpawnFireFx("DD_GF1");
			TNT1 A 0 A_jumpif(health < slightdamaged,"NoFire");
			TRCS A 1 A_SpawnSmokeFx();
			TNT1 A 0 A_jumpif(health < slightdamaged,"NoFire");
			loop;
		NoFire:
			TNT1 A 0 A_stopsound(69);
			TNT1 A 0 A_killFlare();
			TNT1 A 0 DD_TurnTorchFire();
			TNT1 A 0 A_startsound("TorchOffFx",69,0,1.0,ATTN_NORM,frandom(0.9,1.1));
			TNT1 A 0 A_RemoveLight('Green1');
		NoFireLoop:
			TRCS A 2;
			loop;
		Xdeath:
		Death:
			TNT1 A 0 A_stopsound(69);
			TNT1 A 0 {
				if(FireOn)
					A_startsound("TorchOffFx",69,0,1.0,ATTN_NORM,frandom(0.9,1.1));
			}
			TNT1 A 0 A_Startsound("MetalFx",61);
			TNT1 A 0 A_startsound("TinMetalFx",70);
			TNT1 A 0 A_RemoveLight('Green1');
			TNT1 A 0 DD_SpawnDebris("MetalScrap1",random(3,6),(0,0,30),random(3,10),random(3,10));
			TNT1 A 0 A_SpawnEndSmokeFx(0,0,30);
			TNT1 A 0 A_killFlare();
			TRCS B -1;
			stop;
	}
	
	override void postbeginplay()
	{
		A_SpawnLensFlare("DD_GreenFlare",56);
		if(DD_DynLights)
			A_AttachLightDef('Green1',"GreentorchLightBig");
		super.postbeginplay();
	}
}






Class DD_SmallTorchBase : DD_TorchBase
{
	default
	{
		Radius 16;
		Height 37;
		ProjectilePassHeight -16;
		+SOLID
	}
}


Class DD_SRedTorch : DD_SmallTorchBase //replaces ShortRedTorch
{
	default
	{
		Radius 16;
		Height 37;
		ProjectilePassHeight -16;
		+SOLID
	}
	
	states
	{
		Spawn:
			SRCS A 2 A_SpawnFireFx("DD_RF1",32);
			TNT1 A 0 A_jumpif(health < slightdamaged,"NoFire");
			SRCS A 2 A_SpawnFireFx("DD_RF1",32);
			TNT1 A 0 A_jumpif(health < slightdamaged,"NoFire");
			SRCS A 1 A_SpawnSmokeFx(52);
			TNT1 A 0 A_jumpif(health < slightdamaged,"NoFire");
			loop;
		NoFire:
			TNT1 A 0 A_stopsound(69);
			TNT1 A 0 DD_TurnTorchFire();
			TNT1 A 0 A_startsound("TorchOffFx",69,0,1.0,ATTN_NORM,frandom(0.9,1.1));
			TNT1 A 0 A_RemoveLight('Red2');
			TNT1 A 0 A_killFlare();
		NoFireLoop:
			SRCS A 2;
			loop;
		Xdeath:
		Death:
			TNT1 A 0 A_stopsound(69);
			TNT1 A 0 {
				if(FireOn)
					A_startsound("TorchOffFx",69,0,1.0,ATTN_NORM,frandom(0.9,1.1));
			}
			TNT1 A 0 A_Startsound("WoodFx",64);
			TNT1 A 0 A_RemoveLight('Red2');
			TNT1 A 0 DD_SpawnDebris("WoodenStickPc",random(2,5),(0,0,35),random(3,10),random(3,10));
			TNT1 A 0 A_killFlare();
			SRCS B -1;
			stop;
	}
	override void postbeginplay()
	{ 
		A_SpawnLensFlare("DD_RedFlare",32);
		if(DD_DynLights)
			A_AttachLightDef('Red2',"RedtorchLightSmall");
		super.postbeginplay();
	}
}

Class DD_SblueTorch : DD_SmallTorchBase //replaces ShortBlueTorch
{
	default
	{
		Radius 16;
		Height 37;
		ProjectilePassHeight -16;
		+SOLID
	}
	
	states
	{
		Spawn:
			SRCS A 2 A_SpawnFireFx("DD_BF1",32);
			TNT1 A 0 A_jumpif(health < slightdamaged,"NoFire");
			SRCS A 2 A_SpawnFireFx("DD_BF1",32);
			TNT1 A 0 A_jumpif(health < slightdamaged,"NoFire");
			SRCS A 1 A_SpawnSmokeFx(52);
			TNT1 A 0 A_jumpif(health < slightdamaged,"NoFire");
			loop;
		NoFire:
			TNT1 A 0 A_stopsound(69);
			TNT1 A 0 DD_TurnTorchFire();
			TNT1 A 0 A_startsound("TorchOffFx",69,0,1.0,ATTN_NORM,frandom(0.9,1.1));
			TNT1 A 0 A_RemoveLight('Blue2');
			TNT1 A 0 A_killFlare();
		NoFireLoop:
			SRCS A 2;
			loop;
		Xdeath:
		Death:
			TNT1 A 0 A_stopsound(69);
			TNT1 A 0 {
				if(FireOn)
					A_startsound("TorchOffFx",69,0,1.0,ATTN_NORM,frandom(0.9,1.1));
			}
			TNT1 A 0 A_Startsound("WoodFx",64);
			TNT1 A 0 A_RemoveLight('Blue2');
			TNT1 A 0 DD_SpawnDebris("WoodenStickPc",random(2,5),(0,0,35),random(3,10),random(3,10));
			TNT1 A 0 A_killFlare();
			SRCS B -1;
			stop;
	}
	override void postbeginplay()
	{
		A_SpawnLensFlare("DD_BlueFlare",32);
		if(DD_DynLights)
			A_AttachLightDef('Blue2',"BluetorchLightSmall");
		super.postbeginplay();
	}
}

Class DD_SGreenTorch : DD_SmallTorchBase //replaces ShortGreenTorch
{
	default
	{
		Radius 16;
		Height 37;
		ProjectilePassHeight -16;
		+SOLID
	}
	
	states
	{
		Spawn:
			SRCS A 2 A_SpawnFireFx("DD_GF1",32);
			TNT1 A 0 A_jumpif(health < slightdamaged,"NoFire");
			SRCS A 2 A_SpawnFireFx("DD_GF1",32);
			TNT1 A 0 A_jumpif(health < slightdamaged,"NoFire");
			SRCS A 1 A_SpawnSmokeFx(52);
			TNT1 A 0 A_jumpif(health < slightdamaged,"NoFire");
			loop;
		NoFire:
			TNT1 A 0 A_stopsound(69);
			TNT1 A 0 DD_TurnTorchFire();
			TNT1 A 0 A_startsound("TorchOffFx",69,0,1.0,ATTN_NORM,frandom(0.9,1.1));
			TNT1 A 0 A_RemoveLight('Green2');
			TNT1 A 0 A_killFlare();
		NoFireLoop:
			SRCS A 2;
			loop;
		Xdeath:
		Death:
			TNT1 A 0 A_stopsound(69);
			TNT1 A 0 {
				if(FireOn)
					A_startsound("TorchOffFx",69,0,1.0,ATTN_NORM,frandom(0.9,1.1));
			}
			TNT1 A 0 A_Startsound("WoodFx",64);
			TNT1 A 0 A_RemoveLight('Green2');
			TNT1 A 0 DD_SpawnDebris("WoodenStickPc",random(2,5),(0,0,35),random(3,10),random(3,10));
			TNT1 A 0 A_killFlare();
			SRCS B -1;
			stop;
	}
	override void postbeginplay()
	{
		A_SpawnLensFlare("DD_GreenFlare",32);
		if(DD_DynLights)
			A_AttachLightDef('Green2',"GreentorchLightSmall");
		super.postbeginplay();
	}
}