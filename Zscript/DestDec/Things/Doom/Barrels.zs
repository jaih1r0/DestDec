Class DD_IncendiaryBarrel : DD_ShotDecoBase //replaces burningbarrel
{
	default
	{
		Radius 16;
		Height 32;
		ProjectilePassHeight -16;
		+SOLID
		health 200;
		damagetype "Fire";
		//DeathSound "world/barrelx";
	}
	states
	{
		spawn:
			IBRX AA 2 A_SpawnIncendiaryFx();
			IBRX A 1 A_SpawnIncSmokeFx();
			loop;
		Death:
			TNT1 A 0 A_killFlare();
			TNT1 A 0 A_StopSound(69);
			IBRX AAAAA 4 A_setscale(self.scale.x + frandom(0.03,0.05));
			IBRX BCDE 2 A_setscale(self.scale.x + 0.01); 
			TNT1 A 0 A_RemoveLight('FIREBAR1');
			TNT1 A 0 A_QuakeEx(2,2,2,6,0,150,"");
			TNT1 A 0 A_Startsound("world/barrelx",32);
			TNT1 A 0 A_Spawnitem("DD_BarrelExplosionFx");
			TNT1 A 0 DD_SpawnDebris("MetalScrap1",random(10,16),(0,0,40),random(3,10),random(3,10));
			TNT1 A 0 A_explode(30,-1);
			TNT1 AAA 0 A_SpawnIncSmokeFx(20);
			TNT1 A 0 A_SpawnEndSmokeFx(0,0,30);
			TNT1 A 6;
			stop;
	}
	
	void A_SpawnIncendiaryFx()
	{			
		FSpawnParticleParams IncFx;
		IncFx.Texture = TexMan.CheckForTexture("DD_RF1");
		IncFx.Color1 = "FFFFFF";
		IncFx.Style = STYLE_Add;
		IncFx.Flags = SPF_ROLL|SPF_FULLBRIGHT;
		IncFx.Vel = (FRandom (-0.4,0.4),FRandom (-0.4,0.4),FRandom (0.1,1.5)); 
		IncFx.Startroll = random(0,360);
		IncFx.RollVel = frandom(-0.5,0.5);
		IncFx.StartAlpha = 0.45;
		IncFx.FadeStep = -0.1;
		IncFx.Size = frandom(40,60);
		IncFx.SizeStep = -0.7;
		IncFx.Lifetime = FRandom (35,35*3); 
		IncFx.Pos = vec3offset(random(-2,2),random(-2,2),32);
		Level.SpawnParticle (IncFx);

	}
	
	void A_SpawnIncSmokeFx(int zoffset = 50)
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
		Smkfx.Size = frandom(30,50);
		Smkfx.SizeStep = 1.5;
		Smkfx.Lifetime = fRandom(35,35*3); 
		Smkfx.Pos = vec3offset(random(-2,2),random(-2,2),zoffset);
		
		Level.SpawnParticle (Smkfx);
	}
	
	override void DD_SetSpawnHealth()
	{
		self.StartHealth = int(self.spawnhealth() * DD_BarrelHltMulti);
		self.health = self.starthealth;
	}
	
	override void postbeginplay()
	{
		A_SpawnLensFlare("DD_YellowFlare",30);
		A_Startsound("TorchLoop",69,CHANF_LOOPING,1.0,ATTN_NORM,frandom(0.1,1.1));
		if(DD_DynLights)
			A_AttachLightDef('FIREBAR1',"BurningBarrelFire");
		super.postbeginplay();
	}
}

Class DD_BarrelExplosionFx : NoTickActor
{
	default
	{
		renderstyle "add";
		+bright;
	}
	states
	{
		Spawn:
			BEX0 ABCDEFGHIJKLM 1;
			stop;
	}
	override void beginplay()
	{
		A_Setscale(self.scale.x + frandom(-0.1,0.35));
		bxflip = random(0,1);
		super.beginplay();
	}
}

Class DD_NukageBarrel :DD_ShotDecoBase //replaces explosivebarrel
{
	default
	{
		Radius 10;
		health 20;
		Height 42;
		+SOLID
		+ACTIVATEMCROSS
		+DONTGIB
		+OLDRADIUSDMG
		+NOICEDEATH
		//DeathSound "world/barrelx";
		Obituary "$OB_BARREL";
		-DONTTHRUST;
		-nodamagethrust;
		deathheight 0;
	}
	states
	{
		Spawn:
			BRNK A 3 bright A_SpawnBarrelNukage();
			loop;
		Death:
			BRNK BBBB 3 A_setscale(self.scale.x + frandom(0.03,0.05));
			BRNK BB 1;
			BRNK C 1;
			TNT1 A 0 A_RemoveLight('NUKEBAR1');
			TNT1 A 0 A_QuakeEx(2,2,2,10,0,150,"");
			TNT1 A 0 A_Startsound("world/barrelx",32);
			TNT1 A 0 A_Spawnitem("DD_BarrelExplosionFx");
			TNT1 A 0 DD_SpawnDebris("MetalScrap1",random(10,16),(0,0,40),random(3,10),random(3,10));
			TNT1 A 0 A_SpawnEndSmokeFx(0,0,30);
			BRNK D 10 A_explode();
			BRNK D 350;
			BRNK DDDDDDDD 1 A_Fadeout(0.1);
			stop;
	}
	
	override void DD_SetSpawnHealth()
	{
		self.StartHealth = int(self.spawnhealth() * DD_BarrelHltMulti);
		self.health = self.starthealth;
	}
	
	override void postbeginplay()
	{
		if(DD_DynLights)
			A_AttachLightDef('NUKEBAR1',"GreentorchLightSmall");
		super.postbeginplay();
	}
	
	
	Void A_SpawnBarrelNukage()
	{
		if(DD_NoBarrelNukage) return;
		FSpawnParticleParams NKGFX;
		NKGFX.Texture = TexMan.CheckForTexture ("DD_GBF1");
		NKGFX.Color1 = "FFFFFF";
		NKGFX.Style = STYLE_Add;
		NKGFX.Flags = SPF_ROLL|SPF_FULLBRIGHT;
		NKGFX.Vel = (FRandom(-0.2,0.2),FRandom(-0.2,0.2),FRandom(0.1,-0.1)); 
		NKGFX.Startroll = random(0,360);
		NKGFX.RollVel = frandom(-0.5,0.5);
		NKGFX.StartAlpha = 0.4;
		NKGFX.FadeStep = -0.1;
		NKGFX.Size = frandom(14,28);
		NKGFX.SizeStep = 0.5;
		NKGFX.Lifetime = FRandom (35,35*3); 
		NKGFX.Pos = vec3offset(random(-4,4),random(-4,4),random(30,32));
		
		Level.SpawnParticle (NKGFX);
	}
}