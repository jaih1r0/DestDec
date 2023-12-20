Class DD_GoryDec : DD_ShotDecoBase
{
	
	bool StopBleed;
	//this is just because a head on a stick wont be gibbing and spawning tons of blood, isnt?
	bool isGibbingCorpse;
	property isGibbingCorpse : isGibbingCorpse;
	default
	{
		DD_GoryDec.isGibbingCorpse true;
	}
	
	void A_SpawnBloodMist1(vector3 where)//(int xofs = 0,int yofs = 0, int zofs = 0)
	{
		if(DD_NobloodMist || StopBleed) return;
		if(health < 1) return;
		int fr = random(1,2);
		FSpawnParticleParams BldFx;
		BldFx.Texture = TexMan.CheckForTexture("DD_BLD"..fr); //("DD_BSM1");
		BldFx.Color1 = "FF0000";
		BldFx.Style = STYLE_TRANSLUCENT;
		BldFx.Flags = SPF_ROLL;
		BldFx.Vel = (frandom (0.3,-0.3),frandom (0.3,-0.3),frandom (-0.3,0.3)); 
		BldFx.Startroll = random(0,360);
		BldFx.RollVel = frandom(-0.5,0.5);
		BldFx.accel = (0,0,frandom(-0.9,-0.3));
		BldFx.StartAlpha = 1.0;
		BldFx.FadeStep = -0.1;
		BldFx.Size = frandom(10,32);
		BldFx.SizeStep = frandom(3.0,5.0);
		BldFx.Lifetime = fRandom(8,18); 
		BldFx.Pos = where;//vec3offset(xofs,yofs,zofs);
		
		Level.SpawnParticle (BldFx);
	}
	
	override void SpawnLineAttackBlood(Actor attacker, Vector3 bleedpos, double SrcAngleFromTarget, int originaldamage, int actualdamage)
	{
		//if the custom blood isnt allowed, or is not a corpse, return the function here
		if(!DD_AllowCustomBlood || !isGibbingCorpse)
			return;
			
		super.SpawnLineAttackBlood(attacker,bleedpos,SrcAngleFromTarget,originaldamage,actualdamage);
	}
	
	override int DamageMobj(Actor inflictor, Actor source, int damage, Name mod, int flags, double angle)
	{
		if(inflictor)
			A_SpawnBloodMist1(inflictor.pos);
			
		return super.DamageMobj(inflictor,source,damage,mod,flags,angle);
	}
	
	override void Die(Actor Source, Actor inflictor, int dmgflags, Name MeansOfDeath )
	{
		super.Die(Source,inflictor,dmgflags,meansofdeath);
		self.bnogravity = true;
	}
	
	override void postbeginplay()
	{
		super.postbeginplay();
		
		//if custom blood is allowed and its a corpse, make this a monster that doesnt count towards kills,
		//allowing it to spawn blood
		if(DD_AllowCustomBlood && isGibbingCorpse)
		{
			bismonster = true;
			bcountkill = false;
			bnoblood = false;
		}
	}
	
}


Class DD_BloodyTwitch : DD_GoryDec //replaces BloodyTwitch
{
	default
	{
		Radius 16;
		Height 68;
		+SOLID
		+NOGRAVITY
		+SPAWNCEILING
	}
	states
	{
		Spawn:
			0RE0 A 2 A_jumpif(health < halflife,"DamageLow");
			Loop;
		DamageLow:
			TNT1 A 0 A_Startsound("GIBBIE",CHAN_AUTO,0,0.75,ATTN_NORM,frandom(0.8,1.2));
			TNT1 A 0 DD_SpawnDebris("BouncingGib1",random(4,7),(0,0,40),random(3,6),random(3,7));
		damagelowLoop:
			0RE0 E 2;
			loop;
		Death:
			TNT1 A 0 A_Startsound("GIBBIE",CHAN_AUTO,0,1.0,ATTN_NORM,frandom(0.8,1.2));
			TNT1 A 0 DD_SpawnDebris("SkullDebris1",1,(0,0,45),random(3,6),random(3,7));
			TNT1 A 0 DD_SpawnDebris("BouncingGib1",random(4,7),(0,0,40),random(3,6),random(3,7));
			0RE0 F -1;
			stop;
	}
}

Class DD_NonSolidTwitch : DD_BloodyTwitch //replaces NonsolidTwitch
{
	Default
	{
		-SOLID
		Radius 20;
		Height 68;
		+NOGRAVITY
		+SPAWNCEILING
	}
}

Class DD_Meat2 : DD_GoryDec //replaces meat2
{
	Default
	{
		Radius 16;
		Height 84;
		+SOLID
		+NOGRAVITY
		+SPAWNCEILING
	}
	states
	{
		Spawn:
			0RE2 A 2 A_jumpif(health < halflife,"DamageLow");
			loop;
		DamageLow:
			TNT1 A 0 A_Startsound("GIBBIE",CHAN_AUTO,0,0.7,ATTN_NORM,frandom(0.8,1.2));
			TNT1 A 0 DD_SpawnDebris("BouncingGib1",random(4,7),(0,0,40),random(3,6),random(3,7));
		DamageLowLoop:
			0RE2 B 2;
			loop;
		Death:
			TNT1 A 0 A_Startsound("GIBBIE",CHAN_AUTO,0,1.0,ATTN_NORM,frandom(0.8,1.2));
			TNT1 A 0 DD_SpawnDebris("SkullDebris1",1,(0,0,45),random(3,6),random(3,7));
			TNT1 A 0 DD_SpawnDebris("BouncingGib1",random(4,7),(0,0,40),random(3,6),random(3,7));
			0RE2 C -1;
			stop;
	}
}

Class DD_Meat2b : DD_Meat2 //replaces nonsolidmeat2
{
	default
	{
		-solid;
	}
}


Class DD_Meat3 : DD_GoryDec //replaces meat3
{
	Default
	{
		Radius 16;
		Height 84;
		+SOLID
		+NOGRAVITY
		+SPAWNCEILING
	}
	states
	{
		Spawn:
			0RE1 A 2 A_jumpif(health < halflife,"DamageLow");
			loop;
		DamageLow:
			TNT1 A 0 A_Startsound("GIBBIE",CHAN_AUTO,0,0.75,ATTN_NORM,frandom(0.8,1.2));
			TNT1 A 0 DD_SpawnDebris("BouncingGib1",random(4,7),(0,0,40),random(3,6),random(3,7));
		DamageLowLoop:
			0RE1 D 2;
			loop;
		Death:
			TNT1 A 0 A_Startsound("GIBBIE",CHAN_AUTO,0,1.0,ATTN_NORM,frandom(0.8,1.2));
			TNT1 A 0 DD_SpawnDebris("SkullDebris1",1,(0,0,45),random(3,6),random(3,7));
			TNT1 A 0 DD_SpawnDebris("BouncingGib1",random(4,7),(0,0,40),random(3,6),random(3,7));
			0RE1 E -1;
			stop;
	}
}

Class DD_Meat3b : DD_Meat3 //replaces nonsolidmeat3
{
	default
	{
		-solid;
	}
}

Class DD_Meat4 : DD_GoryDec //replaces Meat4
{
	Default
	{
		Radius 16;
		Height 68;
		+SOLID
		+NOGRAVITY
		+SPAWNCEILING
	}
	states
	{
		Spawn:
			0RE2 D -1;
			stop;
		Death:
			TNT1 A 0 A_Startsound("GIBBIE",CHAN_AUTO,0,1.0,ATTN_NORM,frandom(0.8,1.2));
			TNT1 A 0 DD_SpawnDebris("BouncingGib1",random(3,6),(0,0,40),random(3,6),random(3,7));
			0RE2 C -1;
			stop;
	}
}

Class DD_Meat4b : DD_Meat4 //replaces nonsolidmeat4
{
	default
	{
		-solid;
	}
}

Class DD_Meat5 : DD_GoryDec //replaces meat5
{
	default
	{
		Radius 16;
		Height 52;
		+SOLID
		+NOGRAVITY
		+SPAWNCEILING
	}
	
	states
	{
		Spawn:
			0RE4 A -1;
			stop;
		Death:
			TNT1 A 0 A_Startsound("GIBBIE",CHAN_AUTO,0,1.0,ATTN_NORM,frandom(0.8,1.2));
			TNT1 A 0 DD_SpawnDebris("BouncingGib1",random(3,6),(0,0,40),random(3,6),random(3,7));
			0RE4 B -1;
			stop;
	}
}

Class DD_Meat5b : DD_Meat5 //replaces nonsolidmeat5
{
	default
	{
		-solid;
	}
}


//hangs
Class DD_Hang1NG : DD_GoryDec //replaces HangNoGuts
{
	Default
	{
		Radius 16;
		Height 88;
		+SOLID
		+NOGRAVITY
		+SPAWNCEILING
	}
	states
	{
		Spawn:
			0RE5 A 1 A_jumpif(health < halflife,"DamageLow");
			loop;
		DamageLow:
			TNT1 A 0 A_Startsound("GIBBIE",CHAN_AUTO,0,0.7,ATTN_NORM,frandom(0.8,1.2));
			TNT1 A 0 DD_SpawnDebris("BouncingGib1",random(3,6),(0,0,40),random(3,6),random(3,7));
		DamageLowLoop:
			0RE5 B 1;
			loop;
		Death:
			TNT1 A 0 A_Startsound("GIBBIE",CHAN_AUTO,0,1.0,ATTN_NORM,frandom(0.8,1.2));
			TNT1 A 0 DD_SpawnDebris("BouncingGib1",random(3,6),(0,0,40),random(3,6),random(3,7));
			0RE5 C -1;
			stop;
	}
}

Class DD_Hang2NB : DD_GoryDec //replaces HangBNoBrain
{
	default
	{
		Radius 16;
		Height 88;
		+SOLID
		+NOGRAVITY
		+SPAWNCEILING
	}
	states
	{
		Spawn:
			0RE6 A 1 A_jumpif(health < halflife,"DamageLow");
			loop;
		DamageLow:
			TNT1 A 0 A_Startsound("GIBBIE",CHAN_AUTO,0,0.7,ATTN_NORM,frandom(0.8,1.2));
			TNT1 A 0 DD_SpawnDebris("BouncingGib1",random(3,6),(0,0,40),random(3,6),random(3,7));
		DamageLowLoop:
			0RE6 B 1;
			loop;
		Death:
			TNT1 A 0 A_Startsound("GIBBIE",CHAN_AUTO,0,1.0,ATTN_NORM,frandom(0.8,1.2));
			TNT1 A 0 DD_SpawnDebris("BouncingGib1",random(3,6),(0,0,40),random(3,6),random(3,7));
			0RE6 C -1;
			stop;
	}
}

Class DD_Hang3TLD : DD_GoryDec //replaces HangTLookingDown
{
	Default
	{
		Radius 16;
		Height 64;
		+SOLID
		+NOGRAVITY
		+SPAWNCEILING
	}
	states
	{
		Spawn:
			0RE7 A -1;
			stop;
		Death:
			TNT1 A 0 A_Startsound("GIBBIE",CHAN_AUTO,0,1.0,ATTN_NORM,frandom(0.8,1.2));
			TNT1 A 0 DD_SpawnDebris("BouncingGib1",random(3,6),(0,0,40),random(3,6),random(3,7));
			0RE7 B -1;
			stop;
	}
}

Class DD_HAng4TLU : DD_GoryDec //replaces HangTLookingUp
{
	Default
	{
		Radius 16;
		Height 64;
		+SOLID
		+NOGRAVITY
		+SPAWNCEILING
	}
	states
	{
		Spawn:
			0RE9 A -1;
			stop;
		Death:
			TNT1 A 0 A_Startsound("GIBBIE",CHAN_AUTO,0,1.0,ATTN_NORM,frandom(0.8,1.2));
			TNT1 A 0 DD_SpawnDebris("BouncingGib1",random(3,6),(0,0,40),random(3,6),random(3,7));
			0RE9 B -1;
			stop;
	}
}

Class DD_HangTSK : DD_GoryDec //replaces HangTSkull
{
	Default
	{
		Radius 16;
		Height 64;
		+SOLID
		+NOGRAVITY
		+SPAWNCEILING
	}
	states
	{
		Spawn:
			0RE8 A -1;
			stop;
		Death:
			TNT1 A 0 A_Startsound("GIBBIE",CHAN_AUTO,0,1.0,ATTN_NORM,frandom(0.8,1.2));
			TNT1 A 0 DD_SpawnDebris("BouncingGib1",random(3,6),(0,0,40),random(3,6),random(3,7));
			0RE8 B -1;
			stop;
	}
}

Class DD_HangTNB : DD_GoryDec //replaces HANGTNOBRAIN
{
	Default
	{
		Radius 16;
		Height 64;
		+SOLID
		+NOGRAVITY
		+SPAWNCEILING
	}
	states
	{
		Spawn:
			0REA A -1;
			stop;
		Death:
			TNT1 A 0 A_Startsound("GIBBIE",CHAN_AUTO,0,1.0,ATTN_NORM,frandom(0.8,1.2));
			TNT1 A 0 DD_SpawnDebris("BouncingGib1",random(3,6),(0,0,40),random(3,6),random(3,7));
			0REA B -1;
			stop;
	}
}


Class DD_DeadStick : DD_GoryDec //replaces DeadStick
{
	default
	{
		Radius 16;
		Height 64;
		ProjectilePassHeight -16;
		+SOLID;
		
	}
	states
	{
		Spawn:
			0RE3 F -1;
			stop;
		Death:
			TNT1 A 0 A_Startsound("GIBBIE",CHAN_AUTO,0,1.0,ATTN_NORM,frandom(0.8,1.2));
			TNT1 A 0 DD_SpawnDebris("BouncingGib1",random(8,12),(0,0,40),random(3,6),random(3,7));
			TNT1 A 0 DD_SpawnDebris("PinkSkullDebris1",1,(0,0,40),random(3,6),random(3,7));
			0RE3 E -1;
			stop;
	}

}

Class DD_liveStick : DD_GoryDec //replaces livestick
{
	Default
	{
		Radius 16;
		Height 64;
		ProjectilePassHeight -16;
		+SOLID;
	}
	states
	{
		Spawn:
			0RE3 B 16;
			0RE3 CDA 4;
			loop;
		Death:
			TNT1 A 0 A_Startsound("GIBBIE",CHAN_AUTO,0,1.0,ATTN_NORM,frandom(0.8,1.2));
			TNT1 A 0 DD_SpawnDebris("BouncingGib1",random(8,12),(0,0,40),random(3,6),random(3,7));
			TNT1 A 0 DD_SpawnDebris("PinkSkullDebris1",1,(0,0,40),random(3,6),random(3,7));
			TNT1 A 0 DD_SpawnDebris("HeartofGlass1",1,(0,0,40),random(3,6),random(3,7));
			0RE3 E -1;
			stop;
	}
}


Class DD_HeadStick : DD_GoryDec //replaces HeadOnAStick
{
	Default
	{
		Radius 16;
		Height 56;
		ProjectilePassHeight -16;
		DD_GoryDec.isGibbingCorpse false;
		+SOLID
	}
	states
	{
		Spawn:
			HST1 A 1 A_jumpif(health < halflife,"LowDamage");
			loop;
		LowDamage:
			TNT1 A 0 A_Startsound("SkullFx",66);
			TNT1 A 0 DD_SpawnDebris("SkullDebris1",1,(0,0,45),random(3,6),random(3,7));
			TNT1 A 0 { StopBleed = True; }
		LowDamageLoop:
			HST1 B -1;
			stop;
		Death:
			TNT1 A 0 A_Startsound("WoodFx",64);
			TNT1 A 0 DD_SpawnDebris("WoodenStickPc",random(3,6),(0,0,40),random(3,8),random(3,8));
			HST1 C -1;
			stop;
	}
}

Class DD_HeadsStick : DD_GoryDec //replaces HeadsOnAStick
{
	Default
	{
		Radius 16;
		Height 64;;
		ProjectilePassHeight -16;
		+SOLID
		DD_GoryDec.isGibbingCorpse false;
		health 350;
	}
	int headsleft;
	int health_5head;
	int health_4head;
	int health_3head;
	int health_2head;
	int health_1head;
	
	states
	{
		Spawn:
		HeadFull:
			HST2 A 1 A_jumpif(health < health_4head,"4Heads");
			loop;
			
		4Heads:
			TNT1 A 0 A_Startsound("SkullFx",66);
			TNT1 A 0 DD_SkullSub();
			TNT1 A 0 DD_SpawnDebris("SkullDebris1",1,(0,0,45),random(3,6),random(3,7));
		4HeadsLoop:
			HST2 B 1 A_jumpif(health < health_3head,"3Heads");
			loop;
		
		3Heads:
			TNT1 A 0 A_Startsound("SkullFx",66);
			TNT1 A 0 DD_SkullSub();
			TNT1 A 0 DD_SpawnDebris("SkullDebris1",1,(0,0,45),random(3,6),random(3,7));
		3HeadsLoop:
			HST2 C 1 A_jumpif(health < health_2head,"2Heads");
			loop;
		
		2Heads:
			TNT1 A 0 A_Startsound("SkullFx",66);
			TNT1 A 0 DD_SkullSub();
			TNT1 A 0 DD_SpawnDebris("SkullDebris1",1,(0,0,45),random(3,6),random(3,7));
		2HeadsLoop:
			HST2 D 1 A_jumpif(health < health_1head,"AHead");
			loop;
		
		AHead:
			TNT1 A 0 A_Startsound("SkullFx",66);
			TNT1 A 0 DD_SkullSub();
			TNT1 A 0 DD_SpawnDebris("SkullDebris1",1,(0,0,45),random(3,6),random(3,7));
		AHeadLoop:
			HST2 E 1 A_jumpif(health < heavydamaged,"Stick");
			loop;
		
		Stick:
			TNT1 A 0 A_Startsound("SkullFx",66);
			TNT1 A 0 DD_SkullSub();
			TNT1 A 0 DD_SpawnDebris("SkullDebris1",1,(0,0,45),random(3,6),random(3,7));
			TNT1 A 0 { StopBleed = True; }
		StickLoop:
			HST2 F -1;
			stop;
		Xdeath:
		Death:
			TNT1 A 0 {
				if(headsleft > 0)
					DD_SpawnDebris("SkullDebris1",headsleft,(0,0,45),random(3,6),random(3,7));
			}
			TNT1 A 0 A_Startsound("WoodFx",64);
			TNT1 A 0 DD_SpawnDebris("WoodenStickPc",random(3,6),(0,0,40),random(3,8),random(3,8));
			HST1 C -1;
			stop;
	}
	
	void DD_SkullSub()
	{
		headsleft--;
	}
	
	override void DD_sethealthvars()
	{
		health_5head = int(health);
		health_4head = int(health * 0.8);
		health_3head = int(health * 0.6);
		health_2head = int(health * 0.4);
		health_1head = int(health * 0.2);
		heavydamaged = int(health * 0.1);
	}
	
	override void beginplay()
	{
		headsleft = 5;
		super.beginplay();
	}
	
}