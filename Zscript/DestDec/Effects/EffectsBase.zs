Class NoTickActor : Actor abstract	//i need to turn effects inheriting from this into visualthinkers
{
	//this comes from Beautiful Doom
	override void tick()
	{
		if (alpha < 0)
		{
			destroy();
			return;
		}
		if (isFrozen())
			return;
			
		//animation:
		if (tics != -1) 
		{
			if (tics > 0) 
				tics--;
			while (!tics) 
			{
				if (!SetState (CurState.NextState)) // mobj was removed
					return;
			}
		}
		
		
	}
	
}

Class DD_FlareBase : NoTickActor abstract
{
	default
	{
		renderstyle "Add";
		+bright;
		+nointeraction;
	}
	Actor Atc; //the actor this flare is attached to
	int zofs; //the height offset (used to keep it in place)
	vector3 atclastpos; //a vector 3 used to keep track of the last pos of the actor, if it changes, we need to move, otherwise, just dont do anything
	double startalfa,subalfa; //the initial alpha and how many alpha substract
	int dimofstime;
	
	override void tick()
	{
		//play the animation
		NoTickActor.tick();
		
		//if the actor attached doesnt exists or is dead, die
		if(!Atc || Atc.health < 1)
		{
			destroy();
			return;
		}
		//console.printf("last pos: "..atclastpos..", actual pos: "..atc.pos);
		//if the last known pos is different than the actual pos, warp
		if(atclastpos != atc.pos)
			setorigin((atc.pos.XY,atc.pos.z + zofs),1);
		
		DimFlare();
		
		//update the last known pos
		atclastpos = atc ? atc.pos : atclastpos;
	}
	
	override void beginplay()
	{
		//if the flares are disabled, die
		if(DD_NoFlares)
			destroy();
		startalfa = DD_Flarealpha;
		alpha = startalfa;
		subalfa = startalfa * 0.1;
		dimofstime = randompick(5,10,15,20);
		super.beginplay();
	}
	
	Void DimFlare()
	{
		if(DD_NoFlareDim || dimofstime <= 0)
			return;
		if(GetAge() % dimofstime == 0)
		{
			double al = alpha - subalfa;
			self.alpha = al;
		}
		else
			self.alpha = startalfa;
	}
	
}


Class BouncingDebrisBase : Actor abstract
{
	default
	{
		projectile;
		+thruactors;
		+noblockmap;
		damage 0;
		speed 6;
		scale 0.5;
		-nogravity;
		+rollsprite;
		+rollcenter;
		+bounceonwalls;
		+bounceonfloors;
		+bounceonceilings;
		bouncecount 2;
		bouncefactor 0.4;
		radius 3;
		height 3;
	}
	
	int rollsidespeed; //roll speed and direction
	bool died;
	int selfzfloor;
	
	override void beginplay()
	{
		ChangeStatNum(DestDec_Handler.DD_DebrisStat);
		rollsidespeed = randompick(-60,-50,-45,-30,-15,15,30,45,50,60);
		super.beginplay();
	}
	
	override void postbeginplay()
	{
		super.postbeginplay();
		gravity *= frandom[DDGrav](0.9,1.1);
	}
	
	
	override void tick()
	{
		if(isfrozen())
			return;
		
		if(died)
		{
			if(level.time % 35 == 0)
				FindFloorCeiling();
				
			if(selfzfloor != self.floorz)
				self.destroy();
			//console.printf("florz: "..self.floorz.."oldfz: "..selfzfloor);
			//console.printf("Floorz: "..self.floorz.." ");
			
			selfzfloor = self.floorz;
			
		}
		
		if(bouncecount <= 0 && !died)
		{
			died = true;
			self.bcorpse = true;
			self.bmissile = false;
			self.bnogravity = false;
			selfzfloor = self.pos.z;
			self.bnointeraction = true;
		}
		
		if(!died)
			super.tick();
	}
	
	void DD_TraceBlood(int ammount = 1)
	{
		if(DD_NoBloodDecals)
			return;
		if(random(0,1) == 1)
			self.A_SprayDecal("BloodSplat",15,(0,0,0),(random(-1,1),random(-1,1),0),true);
	}
	
}