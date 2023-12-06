Class DD_NatureThing : DD_ShotDecoBase
{
	void A_SpawnFiringDeath(int xofs = 0,int yofs = 0,int zofs = 50)
	{
		FSpawnParticleParams BurningParticle;
		BurningParticle.Texture = TexMan.CheckForTexture ("DD_RF1");
		BurningParticle.Color1 = "FFFFFF";
		BurningParticle.Style = STYLE_Add;
		BurningParticle.Flags = SPF_ROLL|SPF_FULLBRIGHT;
		BurningParticle.Vel = (FRandom (0.1,-0.1),FRandom (0.1,-0.1),FRandom (0.1,1.5)); 
		BurningParticle.Startroll = random(0,360);
		BurningParticle.RollVel = frandom(-0.5,0.5);
		BurningParticle.StartAlpha = 0.50;
		BurningParticle.FadeStep = -0.1;
		BurningParticle.Size = frandom(30,50);
		BurningParticle.SizeStep = -0.5;
		BurningParticle.Lifetime = FRandom (35,35*3); 
		BurningParticle.Pos = vec3offset(xofs,yofs,zofs);
		
		Level.SpawnParticle (BurningParticle);
	}
	
	void A_SpawnWoodSmoke(int xofs = 0,int yofs = 0,int zofs = 50)
	{
		FSpawnParticleParams Smkfx;
		Smkfx.Texture = TexMan.CheckForTexture ("DD_BSM1");
		Smkfx.Color1 = "683A28";
		Smkfx.Style = STYLE_Stencil;//STYLE_Translucent;
		Smkfx.Flags = SPF_ROLL;
		Smkfx.Vel = (frandom (0.1,-0.1),frandom (0.1,-0.1),frandom (-0.2,0.2)); 
		Smkfx.Startroll = random(0,360);
		Smkfx.RollVel = frandom(-0.2,0.2);
		Smkfx.StartAlpha = 0.45;
		Smkfx.FadeStep = -0.1;
		Smkfx.Size = frandom(45,80);
		Smkfx.SizeStep = 1.5;
		Smkfx.Lifetime = fRandom(35,35*5); 
		Smkfx.Pos = vec3offset(xofs,yofs,zofs);
		
		Level.SpawnParticle (Smkfx);
	}
	
}

Class DD_BigTree : DD_NatureThing //replaces BigTree
{
	default
	{
		health 500;
		Radius 32;
		Height 108;
		ProjectilePassHeight -16;
		+SOLID
	}
	int stateact;
	int repeattimes;
	states
	{
		spawn:
			BTR3 A 1 A_Jumpif(health < slightdamaged,"LowDamage");
			loop;
			
		LowDamage:
			TNT1 A 0 {stateact = 1; }
			TNT1 A 0 A_SpawnWoodSmoke(0,0,50);
			TNT1 A 0 A_Startsound("WoodFx",64);
			TNT1 A 0 DD_SpawnDebris("BigWoodStick",random(4,7),(0,0,40),random(3,8),random(3,8));
		LowDamageLoop:
			BTR3 B 1 A_Jumpif(health < halflife,"MidDamage");
			loop;
			
		MidDamage:
			TNT1 A 0 {stateact = 2; }
			TNT1 A 0 A_SpawnWoodSmoke(0,0,50);
			TNT1 A 0 A_Startsound("WoodFx",64);
			TNT1 A 0 DD_SpawnDebris("BigWoodStick",random(4,7),(0,0,40),random(3,8),random(3,8));
		MidDamageLoop:
			BTR3 C 1;
			TNT1 A 0 A_Jumpif(health < heavydamaged,"HighDamage");
			loop;
			
		HighDamage:
			TNT1 A 0 {stateact = 3; }
			TNT1 A 0 A_Startsound("WoodFx",64);
			TNT1 A 0 A_SpawnWoodSmoke(0,0,40);
			TNT1 A 0 DD_SpawnDebris("BigWoodStick",random(4,7),(0,0,40),random(3,8),random(3,8));
		highDamageLooP:
			BTR3 D 1 A_Jumpif(health < 1,"Death");
			loop;
			
		Death:
			TNT1 A 0 {stateact = 4; }
			TNT1 A 0 A_Startsound("WoodFx",64);
			TNT1 AA 0 A_SpawnWoodSmoke(0,0,35);
			TNT1 A 0 DD_SpawnDebris("BigWoodStick",random(4,7),(0,0,40),random(3,8),random(3,8));
			BTR3 E -1;
			stop;
			
		Death.Electric:
		Death.Fire:
		Death.Plasma:
			TNT1 "#" 0 A_settranslation("Burned");
			TNT1 "#" 0 A_Startsound("TorchLoop",69,CHANF_LOOPING,1.0,ATTN_NORM,frandom(0.1,1.1));
			TNT1 "#" 0 { repeattimes = random(15,30); }
		BurnLoop:
			TNT1 "#" 0 { repeattimes--; }
			BTR3 "##########" 2 A_SpawnFiringDeath(random(-radius,radius),random(-radius,radius),45);
			BTR3 "#" 1 A_SpawnEndSmokeFx(random(-radius,radius),random(-radius,radius),45);
			BTR3 "#" 0 A_jumpif(repeattimes > 0,"BurnLoop");
			TNT1 "#" 0 A_Stopsound(69);
			TNT1 "#" 0 A_startsound("TorchOffFx",69,0,1.0,ATTN_NORM,frandom(0.9,1.1));
			BTR3 "#" 0 A_KillFlare();
			BTR3 "#" 0 A_SpawnEndSmokeFx(random(-radius,radius),random(-radius,radius),45);
			BTR3 "#" -1;
			stop;
	}
}


Class DD_torchTree : DD_NatureThing //replaces TorchTree
{
	default
	{
		Radius 16;
		Height 56;
		ProjectilePassHeight -16;
		+SOLID
	}
	int rept;
	states
	{
		Spawn:
			TRE3 A -1;
			stop;
		Death:
			TNT1 A 0 A_Startsound("WoodFx",64);
			TNT1 A 0 DD_SpawnDebris("BigWoodStick",random(4,7),(0,0,40),random(3,8),random(3,8));
			TRE3 B -1;
			stop;
		
		Death.Electric:
		Death.plasma:
		Death.Fire:
			TNT1 A 0 A_settranslation("Burned");
			TNT1 A 0 A_Startsound("TorchLoop",69,CHANF_LOOPING,1.0,ATTN_NORM,frandom(0.1,1.1));
			TNT1 A 0 { rept = random(10,25); }
		burnLoop:
			TNT1 A 0 { rept--; }
			TRE3 BBBBBBBBBB 2 A_SpawnFiringDeath(random(-radius,radius),random(-radius,radius),28);
			TNT1 A 0 A_jumpif(rept > 0,"burnLoop");
			TNT1 A 0 A_Stopsound(69);
			TNT1 A 0 A_startsound("TorchOffFx",69,0,1.0,ATTN_NORM,frandom(0.9,1.1));
			TNT1 A 0 A_killflare();
			TRE3 B -1;
			stop;
			
	}
}
//this is the grey one
Class DD_Stalagmite : DD_NatureThing //replaces stalagmite
{
	default
	{
		Radius 16;
		Height 48;
		+SOLID
		ProjectilePassHeight -16;
		health 100;
	}
	states
	{
		Spawn:
			STM3 A -1;
			Stop;
		Death:
			TNT1 A 0 A_Startsound("WoodFx",64);
			TNT1 A 0 A_SpawnWoodSmoke(0,0,30);
			TNT1 A 0 DD_SpawnDebris("WoodenStickPc2",random(4,7),(0,0,40),random(3,8),random(3,8));
			STM3 B -1;
			Stop;
	}
}
//this is not the grey one
Class DD_Stalagtite : DD_NatureThing //replaces Stalagtite
{
	default
	{
		Radius 16;
		Height 40;
		ProjectilePassHeight -16;
		+SOLID
	}
	states
	{
		Spawn:
			STT3 A -1;
			Stop;
		Death:
			TNT1 A 0 A_Startsound("WoodFx",64);
			TNT1 A 0 A_SpawnWoodSmoke(0,0,30);
			TNT1 A 0 DD_SpawnDebris("WoodenStickPc",random(4,7),(0,0,40),random(3,8),random(3,8));
			STT3 B -1;
			Stop;
	}
}
