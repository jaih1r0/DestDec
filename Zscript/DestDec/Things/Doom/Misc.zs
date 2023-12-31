Class DD_ShortRedColumn : DD_ShotDecoBase //replaces ShortRedColumn
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
			RPL2 A -1;
			Stop;
		Death:
			TNT1 A 0 A_Startsound("StoneFx",62);
			TNT1 A 0 DD_SpawnDebris("RedRockDebris1",random(4,7),(0,0,40),random(3,8),random(3,8));
			RPL2 B -1;
			stop;
	}
}

Class DD_SkullColumn : DD_ShotDecoBase //replaces SkullColumn
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
			RPL3 A -1;
			Stop;
		Death:
			TNT1 A 0 A_Startsound("StoneFx",62);
			TNT1 A 0 DD_SpawnDebris("RedRockDebris1",random(4,7),(0,0,40),random(3,8),random(3,8));
			TNT1 A 0 DD_SpawnDebris("SkullDebris1",1,(0,0,40),random(3,8),random(3,8));
			RPL3 B -1;
			stop;
	}
}


Class DD_GreenColumn : DD_ShotDecoBase //replaces ShortGreenColumn
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
			GPL2 A -1;
			Stop;
		Death:
			TNT1 A 0 A_Startsound("StoneFx",62);
			TNT1 A 0 DD_SpawnDebris("GreenRockDebris1",random(4,7),(0,0,40),random(3,8),random(3,8));
			GPL2 B -1;
			stop;
	}
}

CLass DD_HeartColumn : DD_ShotDecoBase //replaces HeartColumn
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
			GPL2 C 10;
			GPL2 CCCDE 2;
			TNT1 A 0 A_SpawnBloodMist2();
			GPL2 ED 2;
			loop;
		Death: 
			TNT1 A 0 A_Startsound("StoneFx",62);
			TNT1 A 0 DD_SpawnDebris("GreenRockDebris1",random(4,7),(0,0,40),random(3,8),random(3,8));
			TNT1 AAA 0 A_SpawnBloodMist2();
			TNT1 A 0 DD_SpawnDebris("HeartofGlass1",1,(0,0,40),random(3,8),random(3,8));
			GPL2 B -1;
			stop;
	}
	
	void A_SpawnBloodMist2()
	{

		if(DD_NobloodMist) return;
		FSpawnParticleParams BldFx;
		BldFx.Texture = TexMan.CheckForTexture ("DD_BSM1");
		BldFx.Color1 = "FF0000";
		BldFx.Style = STYLE_Stencil;
		BldFx.Flags = SPF_ROLL;
		BldFx.Vel = (frandom (0.1,-0.1),frandom (0.1,-0.1),frandom (0.1,0.3)); 
		BldFx.Startroll = random(0,360);
		BldFx.RollVel = frandom(-0.2,0.2);
		BldFx.StartAlpha = 0.4;
		BldFx.FadeStep = -0.1;
		BldFx.Size = frandom(10,30);
		BldFx.SizeStep = 1.5;
		BldFx.Lifetime = fRandom(35,35*3); 
		BldFx.Pos = vec3offset(0,0,38);
		
		Level.SpawnParticle (BldFx);
	}
}


Class DD_TallGreenColumn : DD_ShotDecoBase //replaces TallGreenColumn
{
	Default
	{
		Radius 16;
		Height 52;
		ProjectilePassHeight -16;
		+SOLID
	}
	
	states
	{
		Spawn:
			GPL1 A 1;
			TNT1 A 0 A_jumpif(health<halflife,"MidDamaged");
			loop;
		MidDamaged:
			TNT1 A 0 A_Startsound("StoneFx",62);
			TNT1 A 0 DD_SpawnDebris("GreenRockDebris1",random(4,7),(0,0,45),random(3,8),random(3,8));
		MidDamagedLoop:
			GPL1 B 2;
			loop;
		Death:
			TNT1 A 0 A_Startsound("StoneFx",63);
			TNT1 A 0 DD_SpawnDebris("GreenRockDebris1",random(4,7),(0,0,35),random(3,8),random(3,8));
			GPL1 C -1;
			stop;
	}
	
}

Class DD_TallRedColumn : DD_ShotDecoBase //replaces TallRedColumn
{
	Default
	{
		Radius 16;
		Height 52;
		ProjectilePassHeight -16;
		+SOLID
	}
	
	states
	{
		Spawn:
			RPL1 A 1;
			TNT1 A 0 A_jumpif(health<halflife,"MidDamaged");
			loop;
			
		MidDamaged:
			TNT1 A 0 A_Startsound("StoneFx",62);
			TNT1 A 0 DD_SpawnDebris("RedRockDebris1",random(4,6),(0,0,45),random(3,8),random(3,8));
		MidDamagedLoop:
			RPL1 B 2;
			loop;
			
		Death:
			TNT1 A 0 A_Startsound("StoneFx",63);
			TNT1 A 0 DD_SpawnDebris("RedRockDebris1",random(4,7),(0,0,40),random(3,8),random(3,8));
			RPL1 C -1;
			stop;
	}
}


Class DD_FloatingSkull : DD_ShotDecoBase //replaces FloatingSkull
{
	Default
	{
		Radius 16;
		Height 40;
		ProjectilePassHeight -16;
		+SOLID
	}
	
	States
	{
		Spawn:
			CLCC AAAAABCCCCCCCCB 3 BRIGHT A_SpawnUnderFire();
			Loop;
		Death:
			TNT1 A 0 A_Startsound("StoneFx",62); 
			TNT1 A 0 A_Startsound("SkullFx",63);
			TNT1 A 0 DD_SpawnDebris("RedRockDebris1",random(4,7),(0,0,40),random(3,8),random(3,8));
			TNT1 A 0 DD_SpawnDebris("PinkSkullDebris1",2,(0,0,40),random(3,8),random(3,8));
			TNT1 A 1;
			stop;
	}
	
	void A_SpawnUnderFire()
	{
		FSpawnParticleParams DFparticle;
		DFparticle.Texture = TexMan.CheckForTexture("DD_RF1");
		DFparticle.Color1 = "FFFFFF";
		DFparticle.Style = STYLE_Add;
		DFparticle.Flags = SPF_ROLL|SPF_FULLBRIGHT;
		DFparticle.Vel = (FRandom(-0.9,0.9),FRandom(-0.9,0.9),FRandom(0.1,0.6)); 
		DFparticle.Startroll = random(0,360);
		DFparticle.RollVel = frandom(-0.5,0.5);
		DFparticle.StartAlpha = 0.45;
		DFparticle.FadeStep = -0.1;
		DFparticle.Size = frandom(15,40);
		DFparticle.SizeStep = -0.5;
		DFparticle.Lifetime = FRandom (35,35*2); 
		DFparticle.Pos = vec3offset(0,0,10);
		
		Level.SpawnParticle (DFparticle);
	}
}

Class DD_HeadCandles : DD_GoryDec //replaces HeadCandles
{
	Default
	{
		Radius 20;
		Height 40;
	}
	States
	{
		Spawn:
			HDC1 A -1 BRIGHT;
			stop;
		Death:
			TNT1 A 0 A_Startsound("SkullFx",63);
			TNT1 A 0 A_Startsound("StoneFx",62); 
			TNT1 A 0 A_removelight('HEADCAND1');
			TNT1 A 0 DD_SpawnDebris("RedRockDebris1",random(3,6),(0,0,40),random(3,8),random(3,8));
			TNT1 A 0 DD_SpawnDebris("SkullDebris1",4,(0,0,40),random(3,8),random(3,8));
			TNT1 A 0 DD_SpawnDebris("PinkSkullDebris1",2,(0,0,40),random(3,8),random(3,8));
			TNT1 A 1;
			stop;
	}
	override void postbeginplay()
	{
		if(DD_DynLights)
			A_AttachLightDef('HEADCAND1',"YellowLampSmall");
		super.postbeginplay();
	}
}

Class DD_EvilierEye : DD_GoryDec //replaces EvilEye
{
	Default
	{
		Radius 16;
		Height 54;
		ProjectilePassHeight -16;
		+SOLID
		+bright;
		+forcexybillboard;
		health 200;
	}
	
	States
	{
		Spawn:
		Exist:
			EVYE A 10;
			TNT1 A 0 A_jump(256,"Looking","BadLooking","UltraBadLooking");
		Looking:
			EVYE BCAA 2;
			goto exist;
		BadLooking:
			EVYE ADDEEEEEEED 2;
			goto exist;
		UltraBadLooking:
			EVYE BCA 2;
			EVYE BCA 1;
			EVYE ADEADED 1;
			goto exist;
		Xdeath:
		Death:
			TNT1 A 0 A_killFlare();
			TNT1 A 0 A_Startsound("GIBBIE",CHAN_AUTO,0,1.0,ATTN_NORM,frandom(0.8,1.2));
			TNT1 A 0 DD_SpawnDebris("EvilEyeDebris1",1,(0,0,40),random(2,7),random(3,9));
			TNT1 A 0 {
				if(candil) candil.setstatelabel("Death");
			}
			TNT1 A 1;
			stop;
		
	}
	bool damaged; bool flarechanged;
	actor candil;
	override void Tick()
	{
		if(isfrozen())
			return;
		
		if(health > 0 && GetAge() % 5 == 0)
		{
			A_SpawnEyeAura();
			A_SpawnEvilFire();
		}
		
		if(health < 100 && health > 0 && !flarechanged)
		{
			damaged = true;
			A_killflare();
			A_SpawnLensFlare("DD_RedFlare",14,(0.2,0.2));
			flarechanged = True;
			if(candil) candil.setstatelabel("NormalCand");
		}
		
		super.tick();
	}
	
	override string DD_GetBonusDrop()
	{
		return "";
	}
	override void postbeginplay()
	{
		A_SpawnLensFlare("DD_GreenFlare",14,(0.2,0.2));
		candil = Spawn("DD_DummyCandil",self.pos);
		if(DD_SigilEvEyes)
			self.bShootable = false;
		super.postbeginplay();
	}
	
	void A_SpawnEyeAura()
	{
		FSpawnParticleParams EYEFX;
		EYEFX.Texture = TexMan.CheckForTexture ("EVYTB0");
		EYEFX.Color1 = damaged ? "FF2200":"FFFFFF";
		EYEFX.Style = STYLE_ADD;
		EYEFX.Flags = SPF_FULLBRIGHT|SPF_ROLL;
		EYEFX.Vel = (frandom (0.1,-0.1),frandom (0.1,-0.1),frandom (-0.1,0.1)); 
		EYEFX.Startroll = random(0,360);
		EYEFX.RollVel = frandom(-0.3,0.3);
		EYEFX.StartAlpha = 0.55;
		EYEFX.FadeStep = -0.1;
		EYEFX.Size = frandom(20,40);
		EYEFX.SizeStep = 1.5;
		EYEFX.Lifetime = fRandom(35,35*2); 
		EYEFX.Pos = vec3offset(0,0,36);
		
		Level.SpawnParticle (EYEFX);
	}
	
	void A_SpawnEvilFire()
	{			
		FSpawnParticleParams FireParticle;
		FireParticle.Texture = TexMan.CheckForTexture (damaged ? "DD_RF1":"DD_GF1");
		FireParticle.Color1 = damaged ? "FF1717":"FFFFFF";
		FireParticle.Style = STYLE_Add;
		FireParticle.Flags = SPF_ROLL|SPF_FULLBRIGHT;
		FireParticle.Vel = (FRandom (-1.5,1.5),FRandom (-1.5,1.5),FRandom (0.1,0.2)); 
		FireParticle.accel = (0,0,frandom(0.1,0.25));
		FireParticle.Startroll = random(0,360);
		FireParticle.RollVel = frandom(-0.5,0.5);
		FireParticle.StartAlpha = 0.45;
		FireParticle.FadeStep = -0.1;
		FireParticle.Size = frandom(25,40);
		FireParticle.SizeStep = -0.5;
		FireParticle.Lifetime = FRandom (35,35*3); 
		FireParticle.Pos = vec3offset(0,0,10);
		
		Level.SpawnParticle (FireParticle);

	}
	
}

Class DD_DummyCandil : NoTickActor
{
	default
	{
		+bright;
		+nointeraction;
	}
	states
	{
		Spawn:
			EVYT A -1;
			stop;
		NormalCand:
			CND1 A -1;
			stop;
		Death:
			CND1 B -1;
			stop;
	}
}


Class DD_TechPillar : DD_ShotDecoBase //replaces TechPillar
{
	default
	{
		Radius 16;
		Height 128;
		health 200;
		+SOLID
	}
	states
	{
		Spawn:
			TCPA A 1 A_jumpif(health < slightdamaged,"LowDamage");
			loop;
		LowDamage:
			TNT1 A 0 A_Startsound("MetalFx",61);
			TNT1 A 0 A_Startsound("GlassBreakFx",60);
			TNT1 A 0 DD_SpawnDebris("GlassShard1",random(5,9),(0,0,90),random(3,8),random(3,8));
		LowDamageLoop:
			TCPD A 1 A_jumpif(health < halflife,"MidDamage");
			loop;
			
		MidDamage:
			TNT1 A 0 A_Startsound("MetalFx",61);
			TNT1 A 0 A_startsound("TinMetalFx",70);
			TNT1 A 0 DD_SpawnDebris("MetalScrap1",random(4,7),(0,0,60),random(3,8),random(3,8));
		MidDamageLoop:
			TCPD B -1;
			stop;
			
		Death:
			TNT1 A 0 A_Startsound("MetalFx",61);
			TNT1 A 0 A_startsound("TinMetalFx",70);
			TNT1 A 0 DD_SpawnDebris("MetalScrap1",random(6,12),(0,0,40),random(3,8),random(3,8));
			TCPD C -1;
			stop;
	}
}