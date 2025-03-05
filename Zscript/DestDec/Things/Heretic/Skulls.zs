Class DD_HangingSkullBase : DD_ShotDecoBase abstract
{
	default
	{
		+nogravity;
		+spawnceiling;
		Radius 20;
		height 35;
	}
	override void die(actor source,actor inflictor,int dmgflags,name meansofdeath)
	{
		super.die(source,inflictor,dmgflags,meansofdeath);
		bNoGravity = true;
	}
	Void A_SpawnSmokeSkull(int xof = 0,int yof = 0, int zof = 0 )
	{
		if(DD_NoSmokeFx) return;
		FSpawnParticleParams Smkfx;
		Smkfx.Texture = TexMan.CheckForTexture("DD_BSM1");
		Smkfx.Color1 = "B0B3B2";
		Smkfx.Style = STYLE_STENCIL;
		Smkfx.Flags = SPF_ROLL;
		Smkfx.Vel = (frandom (0.1,-0.1),frandom (0.1,-0.1),frandom (-0.1,0.1)); 
		Smkfx.Startroll = random(0,360);
		Smkfx.RollVel = frandom(-0.3,0.3);
		Smkfx.StartAlpha = 0.5;
		Smkfx.FadeStep = 0.05;
		Smkfx.Size = frandom(20,40);
		Smkfx.SizeStep = 1.6;
		Smkfx.Lifetime = fRandom(35,60); 
		Smkfx.Pos = vec3offset(xof,yof,zof);
		Level.SpawnParticle (Smkfx);
	}
}

Class DD_Skull35 : DD_HangingSkullBase 
{
	states
	{
		Spawn:
			HSK1 A -1;
			stop;
		Death:
			TNT1 A 0 A_SpawnSmokeSkull(0,0,20);
			TNT1 A 0 A_Startsound("SkullFx",63);
			TNT1 A 0 DD_SpawnDebris("SkullDebris1",1,(0,0,15),random(3,6),random(3,7));
			HSK1 B -1;
			stop;
	}
}

Class DD_Skull45 : DD_HangingSkullBase 
{
	default
	{
		height 45;
	}
	states
	{
		Spawn:
			HSK2 A -1;
			stop;
		Death:
			TNT1 A 0 A_SpawnSmokeSkull(0,0,15);
			TNT1 A 0 A_Startsound("SkullFx",63);
			TNT1 A 0 DD_SpawnDebris("SkullDebris1",1,(0,0,20),random(3,6),random(3,7));
			HSK2 B -1;
			stop;
	}
}

Class DD_Skull60 : DD_HangingSkullBase 
{
	default
	{
		height 60;
	}
	states
	{
		Spawn:
			HSK3 A -1;
			stop;
		Death:
			TNT1 A 0 A_SpawnSmokeSkull(0,0,10);
			TNT1 A 0 A_Startsound("SkullFx",63);
			TNT1 A 0 DD_SpawnDebris("SkullDebris1",1,(0,0,30),random(3,6),random(3,7));
			HSK3 B -1;
			stop;
	}
	
}

Class DD_Skull70 : DD_HangingSkullBase 
{
	default
	{
		height 70;
	}
	states
	{
		Spawn:
			HSK4 A -1;
			stop;
		Death:
			TNT1 A 0 A_SpawnSmokeSkull();
			TNT1 A 0 A_Startsound("SkullFx",63);
			TNT1 A 0 DD_SpawnDebris("SkullDebris1",1,(0,0,35),random(3,6),random(3,7));
			HSK4 B -1;
			stop;
	}
}

Class DD_HangingCorpse : DD_GoryDec 
{
	Default
	{
		Radius 8;
		Height 104;
		+SOLID
		+SPAWNCEILING
		+NOGRAVITY
	}
	
	states
	{
		Spawn:
			HHC1 A 1;
			TNT1 A 0 A_jumpif(health < halflife,"DamageLow");
			loop;
		DamageLow:
			TNT1 A 0 A_Startsound("GIBBIE",CHAN_AUTO,0,0.75,ATTN_NORM,frandom(0.8,1.2));
			TNT1 A 0 DD_SpawnDebris("BouncingGib1",random(3,5),(0,0,10),random(3,6),random(3,7));
			HHC1 B -1;
			stop;
		Death:
			TNT1 A 0 A_Startsound("GIBBIE",CHAN_AUTO,0,0.75,ATTN_NORM,frandom(0.8,1.2));
			TNT1 A 0 DD_SpawnSuperBlood((random(-5,5),random(-5,5),height + random(-1,1)),true);
			TNT1 A 0 DD_SpawnDebris("BouncingGib1",random(4,7),(0,0,40),random(3,6),random(3,7));
			HHC1 C -1;
			stop;
		XDeath:
			TNT1 A 0 A_Startsound("GIBBIE",CHAN_AUTO,0,0.75,ATTN_NORM,frandom(0.8,1.2));
			TNT1 AAA 0 DD_SpawnSuperBlood((random(-5,5),random(-5,5),height + random(-1,1)),true);
			TNT1 A 0 DD_SpawnDebris("BouncingGib1",random(4,7),(0,0,40),random(3,6),random(3,7));
			HHC1 C 1;
			stop;
	}
	
	override string DD_GetBonusDrop()
	{
		return "CrystalVial";
	}
}