Class DD_ShotDecoBase : Actor
{
	default
	{
		+shootable;
		+vulnerable;
		health 120;
		+MOVEWITHSECTOR;
		+DONTTHRUST;
		+nodamagethrust;
		+NOTAUTOAIMED;
		+NOBLOOD;
		ProjectilePassHeight -16;
		DD_ShotDecoBase.RandomFlipX true;
	}
	
	bool randomflipx;
	property RandomFlipX:randomflipx;
	//variables
	DD_FlareBase FB;
	int zofs;
	
	//this are used instead of explicit values for destruction state checks
	int slightdamaged;
	int halflife;
	int heavydamaged;
	
	//functions
	void A_SpawnSparksFx1(int zoffset = 50)
	{
		FSpawnParticleParams Sparkfx;
		Sparkfx.Texture = TexMan.CheckForTexture ("SPX0A0");
		Sparkfx.Color1 = "FFFFFF";
		Sparkfx.Style = STYLE_Add;
		Sparkfx.Flags = SPF_FULLBRIGHT;
		Sparkfx.Vel = (FRandom (-4.1,4.1),FRandom (-4.1,4.1),FRandom (-0.8,3.2)); 
		Sparkfx.accel = (0,0,frandom(-0.3,-0.9));
		Sparkfx.StartAlpha = 0.45;
		Sparkfx.FadeStep = -0.1;
		Sparkfx.Size = frandom(15,32);
		Sparkfx.SizeStep = -0.5;
		Sparkfx.Lifetime = FRandom (35,35*3); 
		Sparkfx.Pos = vec3offset(0,0,zoffset);
		
		Level.SpawnParticle (Sparkfx);
	}
	
	Void A_SpawnEndSmokeFx(int xof = 0,int yof = 0, int zof = 0 )
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
		Smkfx.Size = frandom(20,40);
		Smkfx.SizeStep = 1.5;
		Smkfx.Lifetime = fRandom(35,35*4); 
		Smkfx.Pos = vec3offset(xof,yof,zof);
		
		Level.SpawnParticle (Smkfx);
	}
	
	
	virtual void A_killFlare()
	{
		if(FB)
			FB.Destroy();
	}
	
	void A_SpawnLensFlare(string type,int zoffs, vector2 scaleflare = (0,0))
	{
		FB = DD_FlareBase(spawn(type,(self.pos.XY,self.pos.Z + zoffs)));
		if(fb)
		{
			fb.Atc = self;
			fb.zofs = zoffs;
			
			if(scaleflare != (0,0))
				fb.scale = scaleflare;
		}
	}
	
	void DD_SpawnDebris(string type,int num,vector3 offs = (0,0,0),int velxy = 1, int velz = 1)
	{
		actor db;
		for(int i = 0; i < num; i++)
		{
			db = Spawn(type,vec3offset(offs.x,offs.y,offs.z));
			if(db)
			{
				db.angle = random(0,360);
				int vad = random(-2,2);
				db.velfromangle(velxy + vad,db.angle);
				db.vel.z += (velz + vad);
			}
		}
	}
	
	virtual void DD_SetSpawnHealth()
	{
		self.StartHealth = int(self.spawnhealth() * DD_HealthMulti);
		self.health = self.starthealth;
	}
	
	virtual void DD_sethealthvars()
	{
		self.slightdamaged = int(health * 0.75);
		self.halflife = int(health *0.5);
		self.heavydamaged = int(health * 0.25);
	}
	
	override void beginplay()
	{
		DD_SetSpawnHealth();
		DD_sethealthvars();
		
		if(RandomFlipX)
			self.bXFLIP = random(0,1);
		Super.Beginplay();
	}
	
	
}