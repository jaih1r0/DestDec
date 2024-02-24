Class DD_Lamp1 : DD_ShotDecoBase //replaces TechLamp
{
	Default
	{
		Radius 16;
		Height 80;
		ProjectilePassHeight -16;
		+SOLID
		deathheight 16;
		health 100;
		+nodamagethrust;
		+NOBLOOD;
		
	}
	int actstate;
	bool alreadydeath;
	States
	{
		Spawn:
			DLM1 A 1 BRIGHT;
			TNT1 A 0 A_jumpif(health < slightdamaged,"Damaged_Low");
			Loop;
		Damaged_Low:
			TNT1 A 0 A_RemoveLight('Lamp1');
			TNT1 A 0 A_killFlare();
			TNT1 A 0 A_Startsound("GlassBreakFx",60);
			//TNT1 A 0 A_spawnitem("MetalScrap1");
			TNT1 A 0 DD_SpawnDebris("GlassShard1",random(5,9),(0,0,45),random(3,10),random(3,10));
		D_LowLoop:
			DLM1 B 1;
			TNT1 A 0 A_jumpif(health < halflife,"Damaged_Mid");
			loop;
		Damaged_Mid:
			TNT1 A 0 A_RemoveLight('Lamp1');
			TNT1 A 0 A_startsound("TinMetalFx",70);
			TNT1 A 0 A_Startsound("MetalFx",60);
			TNT1 A 0 A_killFlare();
			TNT1 A 0 DD_SpawnDebris("MetalScrap1",random(3,6),(0,0,45),random(3,10),random(3,10));
		D_MidLoop:
			TNT1 A 0 A_killFlare();
			DLM1 C 1;
			TNT1 A 0 A_jumpif(health < heavydamaged,"Damaged_High");
			Loop;
		Damaged_High:
			TNT1 A 0 A_RemoveLight('Lamp1');
			TNT1 A 0 A_startsound("TinMetalFx",70);
			TNT1 A 0 A_Startsound("MetalFx",61);
			TNT1 A 0 A_killFlare();
			TNT1 AAAAA 0 A_SpawnSparksFx1();
			TNT1 A 0 DD_SpawnDebris("MetalScrap1",random(3,6),(0,0,45),random(3,10),random(3,10));
		D_HighLoop:
			DLM1 D -1;
			stop;

		Xdeath:
		Death:
			TNT1 A 0 A_RemoveLight('Lamp1');
			TNT1 A 0 A_Startsound("GlassBreakFx",60);
			TNT1 A 0 A_killFlare();
			TNT1 A 0 A_Startsound("MetalFx",61);
			TNT1 A 0 DD_SpawnDebris("MetalScrap1",random(7,12),(0,0,25),random(3,10),random(3,10));
			TNT1 AAAAA 0 A_SpawnSparksFx1();
			stop;
	}
	
	override void postbeginplay()
	{
		A_SpawnLensFlare("DD_WhiteFlare",70); 
		if(DD_DynLights)
			A_AttachLightDef('Lamp1',"WhiteLampBig");
		super.postbeginplay();
	}
	

}


Class DD_Lamp2 : DD_ShotDecoBase //replaces TechLamp2
{
	Default
	{
		Radius 16;
		Height 60;
		ProjectilePassHeight -16;
		+SOLID
		deathheight 16;
		health 100;
		+nodamagethrust;
		+NOBLOOD;
	}
	
	States
	{
		Spawn:
			DLM2 A 1 BRIGHT;
			TNT1 A 0 A_jumpif(health < slightdamaged,"Damaged_Low");
			Loop;
		Damaged_Low:
			TNT1 A 0 A_RemoveLight('Lamp2');
			TNT1 A 0 A_killFlare();
			TNT1 A 0 A_Startsound("GlassBreakFx",60);
			TNT1 A 0 DD_SpawnDebris("GlassShard1",random(4,7),(0,0,45),random(3,10),random(3,10));
		D_LowLoop:
			DLM2 B 1;
			TNT1 A 0 A_jumpif(health < halflife,"Damaged_Mid");
			loop;
			
		Damaged_Mid:
			TNT1 A 0 A_RemoveLight('Lamp2');
			TNT1 A 0 A_startsound("TinMetalFx",70);
			TNT1 A 0 A_Startsound("MetalFx",61);
			TNT1 A 0 A_killFlare();
			TNT1 AAAA 0 A_SpawnSparksFx1();
			TNT1 A 0 DD_SpawnDebris("MetalScrap1",random(3,6),(0,0,30),random(3,10),random(3,10));
		D_MidLoop:
			DLM2 C -1;
			stop;
		Death:
		Xdeath:
			TNT1 A 0 A_RemoveLight('Lamp2');
			TNT1 A 0 A_Startsound("MetalFx",61);
			TNT1 A 0 A_killFlare();
			TNT1 AAAAA 0 A_SpawnSparksFx1();
			TNT1 A 0 DD_SpawnDebris("MetalScrap1",random(3,6),(0,0,30),random(3,10),random(3,10));
			TNT1 A 1;
			stop;
	}
	
	override void postbeginplay()
	{
		A_SpawnLensFlare("DD_WhiteFlare",48);
		if(DD_DynLights)
			A_AttachLightDef('Lamp2',"WhiteLampSmall");
		super.postbeginplay();
	}
	
}
//YellowFlare
Class DD_Lamp3 : DD_ShotDecoBase //replaces column
{
	Default
	{
		Radius 16;
		Height 60;
		ProjectilePassHeight -16;
		+SOLID
		deathheight 16;
		health 100;
		+nodamagethrust;
		+NOBLOOD;
	}
	
	States
	{
		Spawn:
			DLM3 A 1 BRIGHT;
			TNT1 A 0 A_jumpif(health < slightdamaged,"Damaged_Low");
			Loop;
		Damaged_Low:
			TNT1 A 0 A_RemoveLight('Lamp3');
			TNT1 A 0 A_Startsound("GlassBreakFx",60);
			TNT1 A 0 A_killFlare();
			TNT1 A 0 DD_SpawnDebris("GlassShard1",random(4,7),(0,0,45),random(3,10),random(3,10));
		D_LowLoop:
			DLM3 B 1;
			TNT1 A 0 A_jumpif(health < halflife,"Damaged_Mid");
			loop;
		//Death:
		Damaged_Mid:
			TNT1 A 0 A_RemoveLight('Lamp3');
			TNT1 A 0 A_Startsound("MetalFx",61);
			TNT1 A 0 A_startsound("TinMetalFx",70);
			TNT1 A 0 A_killFlare();
			TNT1 AAAA 0 A_SpawnSparksFx1();
			TNT1 A 0 DD_SpawnDebris("MetalScrap1",random(3,5),(0,0,30),random(3,10),random(3,10));
		D_MidLoop:
			DLM3 C -1;
			stop;
		Death:
		Xdeath:
			TNT1 A 0 A_RemoveLight('Lamp3');
			TNT1 A 0 A_Startsound("MetalFx",61);
			TNT1 A 0 A_killFlare();
			TNT1 AAA 0 A_SpawnSparksFx1();
			TNT1 A 0 DD_SpawnDebris("MetalScrap1",random(5,8),(0,0,30),random(3,10),random(3,10));
			TNT1 A 1;
			stop;
	}
	
	override void postbeginplay()
	{
		A_SpawnLensFlare("DD_YellowFlare",40);
		if(DD_DynLights)
			A_AttachLightDef('Lamp3',"YellowLampSmall");
		super.postbeginplay();
	}

}

Class DD_Candil1 : DD_ShotDecoBase //replaces Candelabra
{
	default
	{	
		Radius 16;
		Height 60;
		ProjectilePassHeight -16;
		+SOLID
	}
	states
	{
		Spawn: 
			CND0 A 1 BRIGHT;
			TNT1 A 0 A_jumpif(health<slightdamaged,"NoCandil");
			loop;
		NoCandil:
			TNT1 A 0 A_RemoveLight('Lamp4');
			TNT1 A 0 A_startsound("TorchOffFx",69,0,1.0,ATTN_NORM,frandom(0.9,1.1));
			TNT1 A 0 A_killFlare();
		NoCandilLoop:
			CND0 B 1;
			TNT1 A 0 A_jumpif(health < halflife,"Damaged_Mid");
			loop;
		Damaged_Mid:
			TNT1 A 0 A_RemoveLight('Lamp4');
			TNT1 A 0 A_Startsound("MetalFx",61);
			TNT1 A 0 A_startsound("TinMetalFx",70);
			TNT1 A 0 DD_SpawnDebris("GoldScrap1",random(3,5),(0,0,30),random(3,10),random(3,10));
			TNT1 A 0 A_killFlare();
			CND0 C -1;
			loop;
		Death:
			TNT1 A 0 A_RemoveLight('Lamp4');
			TNT1 A 0 A_Startsound("MetalFx",61);
			TNT1 A 0 A_startsound("TinMetalFx",70);
			TNT1 A 0 DD_SpawnDebris("GoldScrap1",random(3,5),(0,0,10),random(3,10),random(3,10));
			TNT1 A 0 A_killFlare();
			TNT1 A 1;
			Stop;
	}
	
	override void postbeginplay()
	{
		A_SpawnLensFlare("DD_YellowFlare",56);
		if(DD_DynLights)
			A_AttachLightDef('Lamp4',"YellowLampBig");
		super.postbeginplay();
	}

}

Class DD_Candilito : DD_ShotDecoBase //replaces Candlestick
{
	Default
	{
		Radius 20;
		Height 14;
		health 30;
		ProjectilePassHeight -16;
	}
	
	states
	{
		Spawn:
			CND1 A -1 BRIGHT;
			Stop;
		Death:
			TNT1 A 0 A_startsound("TorchOffFx",69,0,0.6,ATTN_NORM,frandom(0.9,1.1));
			TNT1 A 0 A_RemoveLight('Lamp5');
			TNT1 A 0 A_killFlare();
			//CND1 B -1;
			TNT1 A 1;
			Stop;
	}
	
	override void postbeginplay()
	{
		A_SpawnLensFlare("DD_YellowFlare",15,(0.15,0.15));
		if(DD_DynLights)
			A_AttachLightDef('Lamp5',"YellowLampMini");
		super.postbeginplay();
	}
	
}