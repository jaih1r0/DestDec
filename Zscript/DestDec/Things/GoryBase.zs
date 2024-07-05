Class DD_GoryDec : DD_ShotDecoBase
{
	
	bool StopBleed;
	//this is just because a head on a stick wont be gibbing and spawning tons of blood, isnt?
	bool isGibbingCorpse;
	property isGibbingCorpse : isGibbingCorpse;
	bool reallybloody;
	property reallybloody:reallybloody;
	default
	{
		DD_GoryDec.isGibbingCorpse true;
		DD_GoryDec.reallybloody true;
		+noicedeath;
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
		BldFx.FadeStep = 0.1;
		BldFx.Size = frandom(10,32);
		BldFx.SizeStep = frandom(3.0,5.0);
		BldFx.Lifetime = fRandom(8,18); 
		BldFx.Pos = where;//vec3offset(xofs,yofs,zofs);
		
		Level.SpawnParticle (BldFx);
	}
	
	void DD_SpawnSuperBlood(vector3 offs, bool big = false)
	{
		if(DD_NobloodMist || StopBleed || DD_AllowCustomBlood)
			return;
		string prj = big ? "DD_BigBleedingDebris" : "DD_BleedingDebris";
		actor bl = self.Spawn(prj,self.vec3offset(offs.x,offs.y,offs.z));
		if(bl)
		{
			bl.target = self;
			bl.copybloodcolor(self);
		}
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
		if(inflictor && !DD_NobloodMist && !StopBleed && !DD_AllowCustomBlood && health > 0)
			DD_SpawnSuperBlood(levellocals.vec3diff(pos,inflictor.pos),reallybloody);//A_SpawnBloodMist1(inflictor.pos);
			
		return super.DamageMobj(inflictor,source,damage,mod,flags,angle);
	}
	
	override void Die(Actor Source, Actor inflictor, int dmgflags, Name MeansOfDeath )
	{
		super.Die(Source,inflictor,dmgflags,meansofdeath);
		self.bnogravity = true;
		
		//option to spawn bonus health when a gore decoration is "killed", ala Brutal doom and students from it
		//its kinda cool, and its not intrussive, since it can just be disabled
		if(DD_CrpSpwnbonus)
			DD_SpawnBonusG();
		
	}
	
	Void DD_SpawnBonusG()
	{
		string bon = DD_GetBonusDrop();
		
		if(bon != "")
		{
			int t = DD_GetBonusQt();
			
			if(t <= 0) //just in case
				return;
				
			actor b;
			
			for(int i = 0; i < t; i++)
			{
				b = spawn(bon,pos,ALLOW_REPLACE);
				if(b)
				{
					vector3 newvel = (random(-3,3),random(-3,3),random(-3,3));
					b.vel += newvel;
					
					//this may not work with mods that uses a random spawner or so to spawn health bonuses, but anyways, this is not tied to any particular mod
					inventory bh = inventory(b);
					if(bh)
					{
						if(bh.bCountItem == true)
							level.Total_Items--;
						
						bh.bCountItem = false;
						bh.bQuiet = true;
					}
				}
				
			}
			
		}
	}
	
	//this is mainly cause different games/mods may drop different "bonus" things
	virtual string DD_GetBonusDrop()
	{
		return "HealthBonus";
		//return "" to cancel the spawn
	}
	
	virtual int DD_GetBonusQt()
	{
		return random(1,3);
		//return 0 or any negative number to cancel the spawn
	}
	
	override void postbeginplay()
	{
		super.postbeginplay();
		
		//if custom blood is allowed and its a corpse, make this a monster that doesnt count towards kills counter,
		//allowing it to spawn blood
		if(DD_AllowCustomBlood && isGibbingCorpse)
		{
			bismonster = true;
			bcountkill = false;
			bnoblood = false;
		}
	}
	
}