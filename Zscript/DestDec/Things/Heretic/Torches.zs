Class DD_FireBrazier : DD_TorchBase
{
	Default
	{
		Radius 16;
		Height 44;
		+SOLID
	}
	states
	{
		Spawn:
			HFH1 A 1 A_SpawnBzFireFx("DD_RF1",48);
			TNT1 A 0 A_jumpif(health < slightdamaged,"NoFire");
			HFH1 A 1;
			TNT1 A 0 A_jumpif(health < slightdamaged,"NoFire");
			TNT1 A 0 A_SpawnSmokeFx(56);
			loop;
		NoFire:
			TNT1 A 0 A_killFlare();
		NoFireLoop:
			HFH1 A 1;
			TNT1 A 0 A_jumpif(health < halflife,"NoBowl");
			loop;
		MidDamage:
		NoBowl:
			TNT1 A 0 A_killFlare();
			TNT1 A 0 A_startsound("TinMetalFx",70);
			TNT1 A 0 DD_SpawnDebris("GoldScrap1",random(3,5),(0,0,30),random(3,10),random(3,10));
			HFH1 B -1;
			stop;
		Death:
			TNT1 A 0 A_killFlare();
			TNT1 A 0 A_Startsound("StoneFx",62);
			TNT1 A 0 DD_SpawnDebris("RockDebris1",random(4,6),(0,0,40),random(3,8),random(3,8));
			HFH1 C -1;
			stop;
		Xdeath:
			TNT1 A 0 A_killFlare();
			TNT1 A 0 A_Startsound("StoneFx",62);
			TNT1 A 0 DD_SpawnDebris("RockDebris1",random(4,8),(0,0,40),random(3,8),random(3,8));
			HFH1 D -1;
			stop;
	}
	
	override void A_KillFlare()
	{
		super.A_killflare();
		A_RemoveLight('YFLAR1');
		if(FireOn)
		{
			A_stopsound(69);
			A_startsound("TorchOffFx",69,0,1.0,ATTN_NORM,frandom(0.9,1.1));
			FireOn = false;
		}
	}
	
	override void PostBeginPlay()
	{
		A_SpawnLensFlare("DD_YellowFlare",46,(0.3,0.3));
		if(DD_DynLights)
			A_AttachLightDef('YFLAR1',"BurningBarrelFire");
		super.postbeginplay();
	}
	
	void A_SpawnBzFireFx(string spt = "DD_RF1",int zoffset = 54)
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
		//FireParticle.FadeStep = 0.005;
		FireParticle.Size = frandom(35,50);
		FireParticle.SizeStep = -0.8;
		FireParticle.Lifetime = Random(35,85); 
		FireParticle.Pos = vec3offset(random(-6,6),random(-6,6),zoffset);
		
		Level.SpawnParticle (FireParticle);
	}
	
}


Class DD_WallTorch : DD_TorchBase
{
	Default
	{
		Radius 6;
		Height 16;
		+NOGRAVITY
		+FIXMAPTHINGPOS
	}
	states
	{
		Spawn:
			HTR1 A 1 A_SpawnFireFx("DD_RF1",24);
			TNT1 A 0 A_jumpif(health < slightdamaged,"TorchOff");
			HTR1 A 1;
			TNT1 A 0 A_SpawnSmokeFx(36);
			TNT1 A 0 A_jumpif(health < slightdamaged,"TorchOff");
			loop;
			
		TorchOff:
			TNT1 A 0 A_killFlare();
			HTR1 A -1;
			stop;
		Death:
			TNT1 A 0 A_killFlare();
			TNT1 A 0 A_Startsound("WoodFx",64);
			TNT1 A 0 DD_SpawnDebris("WoodenStickPc",random(3,6),(0,0,35),random(3,10),random(3,10));
			TNT1 A 1;
			stop;
			
	}
	override void A_KillFlare()
	{
		super.A_killflare();
		A_RemoveLight('YFLAR1');
		if(FireOn)
		{
			A_stopsound(69);
			A_startsound("TorchOffFx",69,0,1.0,ATTN_NORM,frandom(0.9,1.1));
			FireOn = false;
		}
	}
	
	override void PostBeginPlay()
	{
		A_SpawnLensFlare("DD_YellowFlare",24,(0.15,0.15));
		if(DD_DynLights)
			A_AttachLightDef('YFLAR1',"YellowLampSmall");
		self.setorigin((self.pos.XY,self.pos.z + 40),0);
		super.postbeginplay();
	}
}

Class DD_SerpentTorch : DD_TorchBase
{
	Default
	{
		Radius 12;
		Height 54;
		+SOLID
	}
	states
	{
		Spawn:
			HTR2 A 1 A_SpawnFireFx("DD_RF1",52);
			TNT1 A 0 A_jumpif(health < slightdamaged,"TorchOff");
			HTR2 A 1;
			TNT1 A 0 A_SpawnSmokeFx(56);
			TNT1 A 0 A_jumpif(health < slightdamaged,"TorchOff");
			loop;
		TorchOff:
			TNT1 A 0 A_killFlare();
		TorchOffLoop:
			HTR2 A 1;
			TNT1 A 0 A_jumpif(health < halflife,"MidDamage");
			loop;
		MidDamage:
			TNT1 A 0 A_killFlare();
			TNT1 A 0 A_Startsound("WoodFx",64,0,0.6);
			TNT1 A 0 A_startsound("TinMetalFx",70);
			TNT1 A 0 DD_SpawnDebris("HWoodenstick1",random(3,6),(0,0,35),random(3,10),random(3,10));
			HTR2 B -1;
			stop;
		
		Death:
			TNT1 A 0 A_startsound("TinMetalFx",70);
			TNT1 A 0 A_Startsound("WoodFx",64,0,0.65);
			TNT1 A 0 DD_SpawnDebris("HWoodenstick1",random(4,8),(0,0,35),random(3,10),random(3,10));
			TNT1 A 0 A_killFlare();
			HTR2 C -1;
			stop;
	}
	
	override void A_KillFlare()
	{
		super.A_killflare();
		A_RemoveLight('YFLAR1');
		if(FireOn)
		{
			A_stopsound(69);
			A_startsound("TorchOffFx",69,0,1.0,ATTN_NORM,frandom(0.9,1.1));
			FireOn = false;
		}
	}
	
	override void PostBeginPlay()
	{
		A_SpawnLensFlare("DD_YellowFlare",54,(0.16,0.16));
		if(DD_DynLights)
			A_AttachLightDef('YFLAR1',"YellowLampSmall");
		super.postbeginplay();
	}
}

Class DD_Candelabra : DD_ShotDecoBase
{
	Default
	{
		Radius 20;
		Height 60;
		+SPAWNCEILING
		+NOGRAVITY
	}
	states
	{
		Spawn:
			HCND A 1;
			TNT1 A 0 A_jumpif(health < slightdamaged,"CandilOff");
			HCND B 1;
			TNT1 A 0 A_jumpif(health < slightdamaged,"CandilOff");
			HCND C 1;
			TNT1 A 0 A_jumpif(health < slightdamaged,"CandilOff");
			loop;
		CandilOff:
			TNT1 A 0 A_startsound("TorchOffFx",69,0,1.0,ATTN_NORM,frandom(0.9,1.1));
			TNT1 A 0 A_killFlare();
			HCND D -1;
			stop;
		Death:
			TNT1 A 0 A_startsound("TinMetalFx",70);
			TNT1 A 0 A_killFlare();
			TNT1 A 0 DD_SpawnDebris("MetalScrap1",random(2,6),(0,0,20),random(3,10),random(3,10));
			HCND E -1;
			stop;
	}
	
	override void A_KillFlare()
	{
		super.A_killflare();
		A_RemoveLight('YFLAR1');
	}
	
	override void PostBeginPlay()
	{
		super.postbeginplay();
		A_SpawnLensFlare("DD_YellowFlare",20,(0.7,0.25));
		if(FB)
			FB.A_Setroll(0);
		if(DD_DynLights)
			A_AttachLightDef('YFLAR1',"YellowLampSmall");
	}
	override void die(actor source,actor inflictor,int dmgflags,name meansofdeath)
	{
		super.die(source,inflictor,dmgflags,meansofdeath);
		bNoGravity = true;
	}
}