Class MetalScrap1 : BouncingDebrisBase
{
	default
	{
		scale 0.35;
	}
	
	states
	{
		spawn:
			TNT1 A 0 nodelay A_jump(256,"Fly1","Fly2","Fly3");
		Fly1:
			JNK1 ABCDEFGH 3 A_setroll(roll + rollsidespeed);
			loop;
		Fly2:
			JNK2 ABCDEFGH 3 A_setroll(roll + rollsidespeed);
			loop;
		Fly3:
			JNK3 ABCDEF 3 A_setroll(roll + rollsidespeed);
			loop;
		
		Death:
			"####" "#" -1;
			stop;
			
	}
	override void beginplay()
	{
		bxflip = random(0,1);
		A_Setscale(self.scale.x + frandom(-0.15,0.2));
		super.beginplay();
	}
}

Class GoldScrap1 : MetalScrap1
{
	default
	{
		translation "0:255=@50[240,160,30]";
	}
}

Class GlassShard1 : BouncingDebrisBase
{
	default
	{
		scale 0.5;
		renderstyle "translucent";
	}
	states
	{
		Spawn:
			MSC1 A 0 nodelay {
				int rfm = random(0,3);
				frame = rfm;
			}
			MSC1 "#" 3 A_Setroll(roll + rollsidespeed);
			loop;
		Death:
			MSC1 "#" -1;
			stop;
	}
	
	override void beginplay()
	{
		bxflip = random(0,1);
		A_Setscale(self.scale.x + frandom(-0.2,0.25));
		super.beginplay();
	}
	
}

Class WoodenStickPc :BouncingDebrisBase
{
	default
	{
		scale 0.5;
	}
	states
	{
		Spawn:
			WSPX A 0 nodelay {
				int rfm = random(0,4);
				frame = rfm;
			}
		Existing:
			WSPX "#" 3 A_Setroll(roll + rollsidespeed);
			loop;
		Death:
			TNT1 "#" 0 {A_setroll(0);}
			WSPX "#" -1;
			stop;
	}
	
	override void beginplay()
	{
		bxflip = random(0,1);
		A_Setscale(self.scale.x + frandom(-0.15,0.25));
		super.beginplay();
	}
}

Class WoodenStickPc2 : WoodenStickPc
{
	default
	{
		translation "64:79=96:111","128:159=91:95";
	}
}

//forgot the heretic pallete
Class HWoodenstick1 : WoodenStickPc
{
	default
	{
		translation "0:255=#[143,129,112]";//translation "66:136=4:31";
	}
}

Class BigWoodStick : WoodenStickPc
{
	default
	{
		scale 0.8;
	}
}

Class RockDebris1 : BouncingDebrisBase
{
	default
	{
		scale 0.45;
	}
	states
	{
		Spawn:
			D1BS A 0 nodelay {
				int rfm = random(0,3);
				frame = rfm;
			}
		Existing:
			D1BS "#" 3 A_Setroll(roll + rollsidespeed);
			loop;
		Death:
			D1BS "#" -1;
			stop;
	}
	
	override void beginplay()
	{
		bxflip = random(0,1);
		A_Setscale(self.scale.x + frandom(-0.15,0.25));
		super.beginplay();
	}
}
//"0:255=66:127"
Class RedRockDebris1 : RockDebris1
{
	default
	{
		translation "0:255=#[160,5,5]";
	}
}

Class GreenRockDebris1:RockDebris1
{
	default
	{
		translation "0:255=#[60,96,30]";
	}
}

Class BrownRockDebris1:RockDebris1
{
	default
	{
		translation "0:255=@35[164,70,0]";
//		translation "0:31=66:78", "20:65=66:110", "111:127=209:240";//"0:65=66:110", "209:240=111:122";
	}
}

Class SkullDebris1 : BouncingDebrisBase
{
	default
	{
		scale 0.8;
	}
	states
	{
		Spawn:
			SKP0 A 0 nodelay {
				int rfm = random(0,1);
				frame = rfm;
			}
		Existing:
			SKP0 "#" 3 A_Setroll(roll + rollsidespeed);
			loop;
		Death:
			SKP0 "#" -1;
			stop;
	}
	
	override void beginplay()
	{
		bxflip = random(0,1);
		A_Setscale(self.scale.x + frandom(-0.1,0.15));
		super.beginplay();
	}
}

Class PinkSkullDebris1 : SkullDebris1
{
	default
	{
		translation "0:255=#[225,125,120]";
	}
}

Class HeartofGlass1 : BouncingDebrisBase
{
	default
	{
		scale 0.9;
		//decal "BloodSplat";
	}
	states
	{
		Spawn:
			HRTL AABC 3 {
				A_Setroll(roll + rollsidespeed);
			}
			loop;
		Death:
			TNT1 A 0 { bmissile = false; }
			TNT1 A 0 DD_TraceBlood();
			HRTL AABC 3;
			HRTL AABC 3;
			HRTL AABC 3;
			HRTL AABC 3;
			TNT1 A 0 DD_TraceBlood();
			HRTL AABC 3;
			HRTL AABC 3;
			HRTL AA 50;
			HRTL A -1;
			stop;
	}
	
	override void beginplay()
	{
		bxflip = random(0,1);
		A_Setscale(self.scale.x + frandom(-0.05,0.1));
		super.beginplay();
	}
	
}

Class EvilEyeDebris1 : BouncingDebrisBase
{
	default
	{
		scale 1.0;
		speed 8;
		//decal "BloodSplat";
	}
	states
	{
		Spawn:
			EVYT CCC 3 A_Setroll(roll + rollsidespeed);
			loop;
		Death:
			TNT1 A 0 DD_TraceBlood();
			EVYT C -1;
			stop;
	}
	
	override void beginplay()
	{
		bxflip = random(0,1);
		A_Setscale(self.scale.x + frandom(-0.05,0.1));
		super.beginplay();
	}
	
}

Class BouncingGib1 : BouncingDebrisBase
{
	default
	{
		scale 1.0;
		//decal "BloodSplat";
	}
	states
	{
		Spawn:
			GBBC A 0 nodelay {
				int rfm = random(0,7);
				frame = rfm;
			}
		Existing:
			GBBC "#" 3 {
				A_Setroll(roll + rollsidespeed);
			}
			loop;
		Death:
			TNT1 "#" 0 DD_TraceBlood();
			GBBC "#" -1;
			stop;
	}
	
	override void beginplay()
	{
		bxflip = random(0,1);
		A_Setscale(self.scale.x + frandom(-0.1,0.25));
		super.beginplay();
	}
	
}

Class BlueBounceGib1 : BouncingGib1
{
	default
	{
		translation "168:191=192:207", "16:47=240:240";
		bloodcolor "blue";
	}
}
Class DD_BurningDebris : BouncingDebrisBase
{
	default
	{
		bouncecount 2;
	}
	states
	{
		Spawn:
			TNT1 A 0 nodelay A_FlareFx();
			TNT1 A 1 A_FireTrail();
			loop;
		Death:
			TNT1 A 5;
			TNT1 AAAAAAA 5 A_FireTrail(1);
			stop;
	}
	
	void A_FireTrail(bool up = false,string spt = "DD_RF1")
	{			
		FSpawnParticleParams FireParticle;
		FireParticle.Texture = TexMan.CheckForTexture (spt);
		FireParticle.Color1 = "FFFFFF";
		FireParticle.Style = STYLE_Add;
		FireParticle.Flags = SPF_ROLL|SPF_FULLBRIGHT;
		FireParticle.Vel = up ? (FRandom (0.1,-0.1),FRandom (0.1,-0.1),FRandom (0.5,1.5)) : (FRandom (0.1,-0.1),FRandom (0.1,-0.1),FRandom (0.1,-0.1)); 
		FireParticle.Startroll = random(0,360);
		FireParticle.RollVel = frandom(-0.5,0.5);
		FireParticle.StartAlpha = 0.45;
		FireParticle.FadeStep = 0.1;
		FireParticle.Size = frandom(10,15);
		FireParticle.SizeStep = -1.2;
		FireParticle.Lifetime = FRandom (8,10); 
		FireParticle.Pos = pos;
		
		Level.SpawnParticle (FireParticle);
	}
	
	void A_FlareFx()
	{			
		FSpawnParticleParams FlarePx;
		FlarePx.Texture = TexMan.CheckForTexture ("LFXYA0");
		FlarePx.Color1 = "FFFFFF";//"FE9900";//"FFFFFF";
		FlarePx.Style = STYLE_Add;
		FlarePx.Flags = SPF_ROLL|SPF_FULLBRIGHT;
		FlarePx.Vel = (0,0,0);
		FlarePx.Startroll = random(0,360);
		FlarePx.RollVel = frandom(-0.5,0.5);
		FlarePx.StartAlpha = 0.54;
		FlarePx.FadeStep = 0.35;
		FlarePx.Size = frandom(34,36);
		FlarePx.SizeStep = -0.5;
		FlarePx.Lifetime = 1; 
		FlarePx.Pos = pos;
		Level.SpawnParticle (FlarePx);
	}
}

Class DD_BleedingDebris : NoTickActor
{
	default
	{
		bouncecount 1;
		+noblockmap;
		speed 7;
		+thruactors;
		gravity 2.5;
		//decal "BloodSplat";
	}
	
	states
	{
		Spawn:
			BLUD CBA 2 DD_spawnBlood(pos);
			TNT1 A 0 DD_TraceBlood();
			Stop;
		Spray:
			SPRY ABCDEF 1;
			SPRY G 1;
			TNT1 A 0 DD_TraceBlood();
			Stop;

	}
	
	override void tick()
	{
		super.tick();
		if(isfrozen())
			return;
		setxyz(pos + (0,0,-gravity));
	}
	
	override void postbeginplay()
	{
		if(target)
			copybloodcolor(target);
		super.postbeginplay();
	}
	
	void DD_TraceBlood(int ammount = 1)
	{
		if(DD_NoBloodDecals)
			return;
		if(randompick(0,1,0) == 1)
			self.A_SprayDecal("BloodSplat",15,(0,0,0),(random(-1,1),random(-1,1),0),true);
	}
	
	
	void DD_spawnBlood(vector3 where)
	{
		color col = gameinfo.defaultbloodcolor;
		col = bloodcolor;
		if(col == "000000")
			col = "FF0000";
		
		FSpawnParticleParams BDTIL;
		BDTIL.Texture = TexMan.CheckForTexture("VLOD1");
		BDTIL.Color1 = col;
		BDTIL.Style = STYLE_TRANSLUCENT;
		BDTIL.Flags = SPF_ROLL;
		BDTIL.Vel = (frandom(-2.5,2.5),frandom(-2.5,2.5),frandom(-0.5,1.2)); 
		BDTIL.accel = (0,0,frandom(-0.35,-0.12));
		BDTIL.Startroll = random(0,360);
		BDTIL.RollVel = frandom(-4,4);
		BDTIL.StartAlpha = 0.90;
		BDTIL.FadeStep = 0.027;
		BDTIL.Size = 20;
		BDTIL.SizeStep = int(20 * 0.05);
		BDTIL.Lifetime = random(10,13); 
		BDTIL.Pos = where;
		Level.SpawnParticle(BDTIL);
	}
}

Class DD_BigBleedingDebris : DD_BleedingDebris
{
	states
	{
		Spawn:
			BLUD CCBBAA 1 DD_spawnBlood(pos);
			TNT1 A 0 DD_TraceBlood();
			Stop;
		Spray:
			SPRY ABCDEF 1;
			SPRY G 1;
			TNT1 A 0 DD_TraceBlood();
			Stop;
	}
}