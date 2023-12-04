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