mixin Class DD_BurnableThing
{
	int burningtics, MinDmgToBurn, actualfiredmg; 
	uint prevTranslt;
	bool IsBurning;
	
	//call this in (post)beginplay() to start some vars
	void SetUpBurnableThing(actor who, int mindmg = -1)
	{
		if(!who)
			return;
		prevTranslt = who.translation;
		IsBurning = false;
		MinDmgToBurn = mindmg <= 0 ? who.spawnhealth() * 0.2 : mindmg;
	}
	
	//call this on DamageMobj
	void AddBurnDamage(int dmg = 0)
	{
		actualfiredmg += dmg;
		if(actualfiredmg >= MinDmgToBurn)
			burningtics = 35 * random(5,15);
	}
	
	//spawn the fire :B
	void DD_SpawnBurnableFire(vector3 ofs = (0,0,20), actor who = null)
	{
		if(!who)
			return;
		FSpawnParticleParams Burnablepx;
		Burnablepx.Texture = TexMan.CheckForTexture("DD_RF1");
		Burnablepx.Color1 = "FFFFFF";
		Burnablepx.Style = STYLE_Add;
		Burnablepx.Flags = SPF_ROLL|SPF_FULLBRIGHT;
		Burnablepx.Vel = (FRandom (-0.5,0.5),FRandom (-0.5,0.5),FRandom (0.5,2.4)); 
		Burnablepx.Startroll = random(0,360);
		Burnablepx.RollVel = frandom(-0.5,0.5);
		Burnablepx.StartAlpha = 0.75;
		//Burnablepx.FadeStep = 0.1;
		Burnablepx.Size = frandom(30,60);
		Burnablepx.SizeStep = -0.85;
		Burnablepx.Lifetime = FRandom (35,60); 
		Burnablepx.Pos = who.vec3offset(ofs.x,ofs.y,ofs.z);
		Level.SpawnParticle (Burnablepx);
	}
	
	void DD_SpawnBurningsmoke(vector3 ofs = (0,0,25), actor who = null)
	{
		if(!who)
			return;
		if(DD_NoSmokeFx) 
			return;
		FSpawnParticleParams Bsmkfx;
		Bsmkfx.Texture = TexMan.CheckForTexture ("DD_BSM1");
		Bsmkfx.Color1 = "FFFFFF";
		Bsmkfx.Style = STYLE_Translucent;
		Bsmkfx.Flags = SPF_ROLL;
		Bsmkfx.Vel = (frandom (0.1,-0.1),frandom (0.1,-0.1),frandom (0.8,1.5)); 
		Bsmkfx.Startroll = random(0,360);
		Bsmkfx.RollVel = frandom(-0.3,0.3);
		Bsmkfx.StartAlpha = 0.3;
		//Bsmkfx.FadeStep = 0.05;
		Bsmkfx.Size = frandom(20,30);
		Bsmkfx.SizeStep = 2.5;
		Bsmkfx.Lifetime = fRandom(35,62); 
		Bsmkfx.Pos = who.vec3offset(ofs.x,ofs.y,ofs.z);
		
		Level.SpawnParticle (Bsmkfx);
	}
	
	
	//fireevery (couldnt think a better name xd) control how often this burning thing would spawn a flame
	//ofs is the offsets
	void DD_handleBurning(int fireevery = 3,vector3 ofs = (0,0,20),actor who = null)
	{
		//if this is disabled, return
		if(DD_NoBurnTree)
			return;
		
		//if this has burningtics but its not actually burning, start burning
		if(burningtics > 0 && !IsBurning)
		{
			IsBurning = true;
			who.A_Settranslation("Burned");
			who.A_Startsound("TorchLoop",39,CHANF_LOOPING,0.85,ATTN_NORM,frandom(0.1,1.1));
			//let dd = DD_ShotDecoBase(who);
			//if(dd)
			//	dd.A_SpawnLensFlare("DD_YellowFlare",ofs.z);
		}
		
		if(!IsBurning) //its not actually burning, return
			return;
			
		if(burningtics > 0)
			burningtics--; //reduce the burning tics if they are more than 0
		
		//spawn the effects
		if(who && (who.getage() % fireevery == 0))
		{
			DD_SpawnBurnableFire(ofs,who);
			//DD_SPawnBurningsmoke((ofs.xy,ofs.z + 10),who);
			DD_SPawnBurningsmoke((-ofs.xy,ofs.z + 5),who);
		}
		
		if(IsBurning && burningtics <= 0) //burning is over
		{
			who.A_stopsound(39);
			IsBurning = false;
		}
		
	}
}