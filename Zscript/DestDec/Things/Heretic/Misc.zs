Class DD_WoodenBarrel : DD_ShotDecoBase
{
	Default
	{
		Radius 12;
		Height 32;
		+SOLID
	}
	states
	{
		Spawn:
			HWBR A 1;
			TNT1 A 0 A_jumpif(health < slightdamaged,"LowDamage");
			loop;
			
		LowDamage:
			TNT1 A 0 DD_SpawnDebris("MetalScrap1",random(2,5),(0,0,45),random(3,10),random(3,10));
			TNT1 A 0 DD_SpawnDebris("WoodenStickPc",random(3,6),(0,0,35),random(3,10),random(3,10));
			HWBR B -1;
			stop;
		
		Death:
			TNT1 A 0 DD_SpawnDebris("MetalScrap1",random(2,6),(0,0,45),random(3,10),random(3,10));
			TNT1 A 0 DD_SpawnDebris("WoodenStickPc",random(6,10),(0,0,35),random(3,10),random(3,10));
			HWBR C -1;
			stop;
	}
}

Class DD_Moss1 : DD_ShotDecoBase 
{
	default
	{
		Radius 20;
		Height 23;
		health 30;
		+SPAWNCEILING
		+NOGRAVITY
	}
	states
	{
		Spawn:
			HMS1 A -1;
			stop;
		Death:
			TNT1 AA 0 A_SpawnMossFx();
			TNT1 AA 0 A_SpawnMossPx();
			TNT1 A 1;
			stop;
	}
	
	void A_SpawnMossFx()
	{
		//27531b
		FSpawnParticleParams MOSFX;
		MOSFX.Texture = TexMan.CheckForTexture("DD_BSM1");
		MOSFX.Color1 = "27531B";
		MOSFX.Style = STYLE_STENCIL;
		MOSFX.Flags = SPF_ROLL;
		MOSFX.Vel = (frandom (0.1,-0.1),frandom (0.1,-0.1),frandom (-0.8,-0.1)); 
		MOSFX.Startroll = random(0,360);
		MOSFX.RollVel = frandom(-0.3,0.3);
		MOSFX.StartAlpha = 0.5;
		MOSFX.FadeStep = -0.1;
		MOSFX.Size = frandom(20,40);
		MOSFX.SizeStep = 1.6;
		MOSFX.Lifetime = fRandom(35,35*4); 
		MOSFX.Pos = pos;
		Level.SpawnParticle (MOSFX);
	}
	
	Void A_SpawnMossPx()
	{
		int fr = random(1,2);
		FSpawnParticleParams BldFx;
		BldFx.Texture = TexMan.CheckForTexture("DD_BLD"..fr);
		BldFx.Color1 = "468335";
		BldFx.Style = STYLE_STENCIL;
		BldFx.Flags = SPF_ROLL;
		BldFx.Vel = (frandom (0.3,-0.3),frandom (0.3,-0.3),frandom (-0.5,-0.1)); 
		BldFx.Startroll = random(0,360);
		BldFx.RollVel = frandom(-0.5,0.5);
		BldFx.accel = (0,0,frandom(-0.9,-0.3));
		BldFx.StartAlpha = 1.0;
		BldFx.FadeStep = -0.1;
		BldFx.Size = frandom(10,40);
		BldFx.SizeStep = frandom(3.5,5.0);
		BldFx.Lifetime = fRandom(8,18); 
		BldFx.Pos = pos;
		Level.SpawnParticle (BldFx);
	}
}

Class DD_Moss2 : DD_Moss1
{
	default
	{
		Radius 20;
		Height 27;
		+SPAWNCEILING
		+NOGRAVITY
	}
	states
	{
		Spawn:
			HMS2 A -1;
			stop;
		Death:
			TNT1 AA 0 A_SpawnMossFx();
			TNT1 AA 0 A_SpawnMossPx();
			TNT1 A 1;
			stop;
	}
}


//Stalagmite - on floor / Stalagtite - on ceil, got it
Class DD_StalactiteSmall : DD_ShotDecoBase 
{
	Default
	{
		Radius 8;
		Height 36;
		+SOLID
		+SPAWNCEILING
		+NOGRAVITY
	}
	states
	{
		Spawn:
			STG2 A -1;
			stop;
		Death:
			TNT1 A 0 DD_SpawnDebris("BrownRockDebris1",random(4,6),(0,0,10),random(3,8),random(3,8));
			STG2 B -1;
			stop;
	}
	override void die(actor source,actor inflictor,int dmgflags,name meansofdeath)
	{
		super.die(source,inflictor,dmgflags,meansofdeath);
		bNoGravity = true;
	}
}

Class DD_StalactiteLarge : DD_StalactiteSmall 
{
	Default
	{
		Radius 12;
		Height 68;
		+SOLID
		+SPAWNCEILING
		+NOGRAVITY
	}
	states
	{
		Spawn:
			STG1 A -1;
			stop;
		Death:
			TNT1 A 0 DD_SpawnDebris("BrownRockDebris1",random(5,10),(0,0,40),random(3,8),random(3,8));
			STG1 B -1;
			stop;
	}
}

Class DD_StalagmiteSmall : DD_ShotDecoBase 
{
	Default
	{
		Radius 8;
		Height 32;
		+SOLID
	}
	states
	{
		Spawn:
			STG4 A -1;
			stop;
		Death:
			TNT1 A 0 DD_SpawnDebris("BrownRockDebris1",random(4,6),(0,0,10),random(3,8),random(3,8));
			STG4 B -1;
			stop;
	}
}

Class DD_StalagmiteLarge : DD_StalagmiteSmall 
{
	Default
	{
		Radius 12;
		Height 64;
		+SOLID
	}
	states
	{
		Spawn:
			STG3 A -1;
			stop;
		Death:
			TNT1 A 0 DD_SpawnDebris("BrownRockDebris1",random(5,10),(0,0,40),random(3,8),random(3,8));
			STG3 B -1;
			stop;
	}
}

Class DD_Volcano : DD_ShotDecoBase
{
	Default
	{
		Radius 12;
		Height 20;
		+SOLID
	}
	states
	{
		Spawn:
			HVLC AB 2;
			HVLC C 2 DD_VolcanoWait();
			HVLC BA 2;
			HVLC C 2 DD_VolcanoWait();
			HVLC DDEEE 2 A_SpawnVolcanoFireFx();
			HVLC FF 1 A_SpawnVolcanoFireFx();
			TNT1 A 0 A_QuakeEx(1,1,1,6,0,100,"",QF_RELATIVE);
			HVLC FFF 1 A_SpawnVolcanoFireFx();
			HVLC F 2 { 
				DD_VBlast();
				A_SpawnVolcanoFireFx();
			}
			HVLC GGGG 1 A_SpawnVolcSmokeFx();
			loop;
		Death:
			TNT1 A 0 DD_VBlast();//DD_VolcanoBlast();
			TNT1 A 0 A_SpawnVolcanoFireFx();
			TNT1 A 0 DD_SpawnDebris("BrownRockDebris1",random(4,8),(0,0,12),random(3,8),random(3,8));
			TNT1 A 1 A_SpawnVolcSmokeFx();
			stop;
	}
	
	//i think this is simpler to do than the vanilla function
	Void DD_VBlast()
	{
		DD_SpawnDebris("DD_VolcanoBlaster",random(1,4),(0,0,40),random(4,7),random(6,9));
		A_StartSound ("world/volcano/shoot",17);
	}
	
	//the vanilla function
	void DD_VolcanoWait()
	{
		tics = random[VolcanoSet](105, 232);
	}
	
	void DD_VolcanoBlast()
	{
		int count = random[VolcanoBlast](1,3);
		for (int i = 0; i < count; i++)
		{
			Actor blast = Spawn("VolcanoBlast", pos + (0, 0, 44), ALLOW_REPLACE);
			if (blast != null)
			{
				blast.target = self;
				blast.Angle = random[VolcanoBlast]() * (360 / 256.);
				blast.VelFromAngle(frandom(1.0,4.0));
				blast.Vel.Z = 7.5 + random[VolcanoBlast]() / 64.;
				blast.A_StartSound ("world/volcano/shoot", CHAN_BODY);
				blast.CheckMissileSpawn (radius);
			}
		}
	}
	
	void A_SpawnVolcanoFireFx()
	{			
		FSpawnParticleParams IncFx;
		IncFx.Texture = TexMan.CheckForTexture("DD_RF1");
		IncFx.Color1 = "FFFFFF";
		IncFx.Style = STYLE_Add;
		IncFx.Flags = SPF_ROLL|SPF_FULLBRIGHT;
		IncFx.Vel = (FRandom (-0.4,0.4),FRandom (-0.4,0.4),FRandom (0.9,3.5)); 
		IncFx.Startroll = random(0,360);
		IncFx.RollVel = frandom(-0.9,0.9);
		IncFx.StartAlpha = 0.54;
		IncFx.FadeStep = -0.1;
		IncFx.Size = frandom(20,35);
		IncFx.SizeStep = -0.8;
		IncFx.Lifetime = FRandom (35,35*2); 
		IncFx.Pos = vec3offset(0,0,21);
		Level.SpawnParticle(IncFx);
	}
	
	void A_SpawnVolcSmokeFx(int zoffset = 28)
	{
		if(DD_NoSmokeFx) return;
		FSpawnParticleParams Smkfx;
		Smkfx.Texture = TexMan.CheckForTexture ("DD_BSM1");
		Smkfx.Color1 = "FFFFFF";
		Smkfx.Style = STYLE_Translucent;
		Smkfx.Flags = SPF_ROLL;
		Smkfx.Vel = (frandom (0.1,-0.1),frandom (0.1,-0.1),frandom (1.2,4.2)); 
		Smkfx.Startroll = random(0,360);
		Smkfx.RollVel = frandom(-0.2,0.2);
		Smkfx.StartAlpha = 0.65;
		Smkfx.FadeStep = -0.1;
		Smkfx.Size = frandom(20,40);
		Smkfx.SizeStep = 1.5;
		Smkfx.Lifetime = fRandom(35,35*2); 
		Smkfx.Pos = vec3offset(0,0,zoffset);
		
		Level.SpawnParticle (Smkfx);
	}
	
}

Class DD_VolcanoBlaster : Actor
{
	default
	{
		+missile;
		-nogravity;
		speed 3;
		Radius 8;
		Height 8;
		Damage 2;
		scale 0.3;
		renderstyle "translucent";
		DamageType "Fire";
		+dropoff;
		+noteleport;
		DeathSound "world/volcano/blast";
	}
	states
	{
		Spawn:
			VFBL AB 1 A_SpawnVBFireFx();
			loop;
		Death:
			TNT1 A 0 A_Explode(1,20);
			TNT1 A 1 A_SpawnItem("DD_FlammingRemnant",0,5);
			stop;
		
	}
	
	
	void A_SpawnVBFireFx()
	{			
		FSpawnParticleParams IncFx;
		IncFx.Texture = TexMan.CheckForTexture("DD_RF1");
		IncFx.Color1 = "FFFFFF";
		IncFx.Style = STYLE_Add;
		IncFx.Flags = SPF_ROLL|SPF_FULLBRIGHT;
		IncFx.Vel = (FRandom (-0.4,0.4),FRandom (-0.4,0.4),FRandom (-0.4,0.4)); 
		IncFx.Startroll = random(0,360);
		IncFx.RollVel = frandom(-0.8,0.8);
		IncFx.StartAlpha = 0.85;
		IncFx.FadeStep = -0.1;
		IncFx.Size = frandom(20,35);
		IncFx.SizeStep = -0.8;
		IncFx.Lifetime = FRandom (15,35); 
		IncFx.Pos = pos;
		Level.SpawnParticle(IncFx);
	}
}

Class DD_FlammingRemnant : NoTickActor
{
	default
	{
		damagetype "Fire";
	}
	states
	{
		Spawn:
			TNT1 AA 2 A_SpawnVisFireFx();
			TNT1 AAAAA 2 A_SpawnVisFireFx();
			TNT1 AA 2 A_SpawnVisFireFx();
			TNT1 AAAAA 2 A_SpawnVisFireFx();
			stop;
	}
	
	void A_SpawnVisFireFx()
	{			
		FSpawnParticleParams IncFx;
		IncFx.Texture = TexMan.CheckForTexture("DD_RF1");
		IncFx.Color1 = "FFFFFF";
		IncFx.Style = STYLE_Add;
		IncFx.Flags = SPF_ROLL|SPF_FULLBRIGHT;
		IncFx.Vel = (FRandom (-0.4,0.4),FRandom (-0.4,0.4),FRandom (1.0,3.0)); 
		IncFx.Startroll = random(0,360);
		IncFx.RollVel = frandom(-0.8,0.8);
		IncFx.StartAlpha = 0.75;
		IncFx.FadeStep = -0.1;
		IncFx.Size = frandom(12,26);
		IncFx.SizeStep = -0.5;
		IncFx.Lifetime = FRandom (10,25); 
		IncFx.Pos = pos;
		Level.SpawnParticle(IncFx);
	}
	
}


Class DD_Pod : DD_ShotDecoBase
{
	Default
	{
		Health 45;
		Radius 16;
		Height 54;
		PushFactor 0.5;
		Painchance 255;
		DeathSound "world/podexplode";
		+SOLID;
		+DROPOFF;
		+WINDTHRUST; 
		+PUSHABLE;
		+SLIDESONWALLS;
		+CANPASS; 
		+TELESTOMP; 
		+DONTMORPH;
		+NOBLOCKMONST; 
		+DONTGIB;
		+OLDRADIUSDMG;
		+Bright;
		+ForceXYBillBoard;
	}
	
	states
	{
		Spawn:
		Spawn1:
			HDP1 AAAAA 2;
			HDP1 ABCDDE 1;
			HDP1 EEEED 2;
			HDP1 DCBAA 1;
			TNT1 A 0 A_jump(128,"Spawn2");
			loop;
		Spawn2:
			HDP1 AAAA 2;
			HDP1 ABCDE 1;
			HDP1 EEEEED 2;
			HDP1 DCBAA 1;
			goto spawn;
		Pain:
			TNT1 A 0 A_SpawnGooFx();
			HDP1 F 7;
			HDP1 A 7;
			goto Spawn;
		Death:
			TNT1 A 0 DD_RemovePOD();
			TNT1 A 0 A_SpawnGXPSmoke();
			TNT1 A 0 A_SpawnGooFx();
			HDP1 F 3;
			HDP1 G 3 A_Scream();
			TNT1 A 0 A_Explode();
			TNT1 A 0 A_QuakeEx(1,1,1,7,0,100,"");
			HDP1 HIJ 2;
			TNT1 A 8;
			stop;
		Grow:
			HDP2 CDEF 2;
			TNT1 A 0 A_SpawnGooFx();
			HDP2 GHIJ 2;
			goto spawn;
	}
	
	override void DD_SetSpawnHealth()
	{
		self.StartHealth = int(self.spawnhealth() * DD_BarrelHltMulti);
		self.health = self.starthealth;
	}
	
	Void A_SpawnGXPSmoke()
	{
		FSpawnParticleParams GSMK;
		GSMK.Texture = TexMan.CheckForTexture ("DD_SMK1");
		GSMK.Color1 = "77FF6F";//"3F832F";
		GSMK.Style = STYLE_STENCIL;
		GSMK.Flags = SPF_ROLL|SPF_FULLBRIGHT;
		GSMK.Vel = (frandom (0.1,-0.1),frandom (0.1,-0.1),frandom (-0.1,0.1)); 
		GSMK.Startroll = random(0,360);
		GSMK.RollVel = frandom(-0.2,0.2);
		GSMK.StartAlpha = 0.8;
		GSMK.FadeStep = -0.1;
		GSMK.Size = frandom(30,60);
		GSMK.SizeStep = 12.0;
		GSMK.Lifetime = fRandom(12,25); 
		GSMK.Pos = vec3offset(0,0,height*2);
		Level.SpawnParticle (GSMK);
	}
	
	Void A_SpawnGooFx()
	{
		FSpawnParticleParams GooPx;
		string goo = "HGoo";
		int fm = random(1,2);
		GooPx.Texture = TexMan.CheckForTexture (goo..fm);
		GooPx.Color1 = "FFFFFF";
		GooPx.Style = STYLE_Normal;
		GooPx.Flags = SPF_ROLL|SPF_FULLBRIGHT;
		GooPx.Vel = (FRandom(-2.5,2.5),FRandom(-2.5,2.5),FRandom (1.5,5.0));
		GooPx.Accel = (0,0,frandom(-1.1,-0.3));
		GooPx.Startroll = random(0,360);
		GooPx.RollVel = frandom(-2.5,2.5);
		GooPx.StartAlpha = 1.0;
		GooPx.FadeStep = 0;
		GooPx.Size = frandom(15,32);
		GooPx.SizeStep = -0.5;
		GooPx.Lifetime = FRandom (35,35*2); 
		GooPx.Pos = vec3offset(0,0,height * 0.9);
		int qt = random(1,4);
		for(int i = 0; i < qt; i++)
		{
			Level.SpawnParticle (GooPx);
			GooPx.Pos = vec3offset(random(-3,3),random(-3,3),height * 0.9);
			GooPx.Vel = (FRandom(-2.5,2.5),FRandom(-2.5,2.5),FRandom (0.7,2.5)); 
		}
	}
	
	
	Void DD_RemovePOD()
	{
		if(Master && master.special1 > 0)
			master.special1--;
	}
}