Class DestDec_Handler : EventHandler
{
	const DD_DebrisStat = thinker.STAT_USER + 5;
	
	array<actor> worlddebris;
	
	override void worldthingspawned(worldevent e)
	{
		if(e.thing && e.thing is 'BouncingDebrisBase')
			worlddebris.Push(e.thing);
	}
	
	override void worldthingdestroyed(worldevent e)
	{
		if(e.thing && e.thing is 'BouncingDebrisBase')
		{
			worlddebris.delete(worlddebris.find(e.thing));
		}
	}
	
	override void worldtick()
	{
		if(DD_MaxGibsAllowed <= 0)
			return;
		
		while(worlddebris.size() > DD_MaxGibsAllowed)
			worlddebris[0].destroy();
		
	}
	
	Void DD_ClearDebris()
	{
		int totaldebris = worlddebris.size()-1;
		//console.printf("clearing: "..totaldebris.." debris");
		
		if(totaldebris < 0)
			return;
			
		for(int i = totaldebris; i >= 0; i--)
			worlddebris[0].destroy();
	}
	
	override void NetworkProcess(Consoleevent e)
	{
		if(e.name ~== "DD_ClearDebris")
			DD_ClearDebris();
		
	}
	
	//
	//Here is where things are replaced
	//this way it wont fight with other mods using the 'replace' keyword, as this takes priority
	//
	
	override void CheckReplacement(replaceevent e)
	{
		if(DD_Working)
		{
			switch(e.replacee.GetClassName())
			{
				case 'RedTorch'	: e.replacement =	'DD_RedTorch'; 	Break;
				case 'BlueTorch'	: e.replacement =	'DD_BlueTorch'; 	Break;
				case 'GreenTorch'	: e.replacement =	'DD_GreenTorch'; 	Break;
				case 'ShortRedTorch'	: e.replacement =	'DD_SRedTorch'; 	Break;
				case 'ShortBlueTorch'	: e.replacement =	'DD_SBlueTorch'; 	Break;
				case 'ShortGreenTorch'	: e.replacement =	'DD_SGreenTorch'; 	Break;
			
				case 'TechLamp'	: e.replacement =	'DD_Lamp1'; 	Break;
				case 'TechLamp2'	: e.replacement =	'DD_Lamp2'; 	Break;
				case 'column'	: e.replacement =	'DD_Lamp3'; 	Break;
				
				case 'Candelabra'	: e.replacement =	'DD_Candil1'; 	Break;
				case 'Candlestick'	: e.replacement =	'DD_Candilito'; 	Break;
				
				case 'explosivebarrel'	: e.replacement = DD_ReplaceBarrels ? 'DD_NukageBarrel':'explosivebarrel'; 	Break;
				case 'burningbarrel'	: e.replacement = DD_ReplaceBarrels ? 'DD_IncendiaryBarrel':'burningbarrel'; 	Break;
			
				case 'ShortRedColumn'	: e.replacement =	'DD_ShortRedColumn'; 	Break;
				case 'SkullColumn'	: e.replacement =	'DD_SkullColumn'; 	Break;
				case 'ShortGreenColumn'	: e.replacement =	'DD_GreenColumn'; 	Break;
				case 'HeartColumn'	: e.replacement =	'DD_HeartColumn'; 	Break;
				case 'TallGreenColumn'	: e.replacement =	'DD_TallGreenColumn'; 	Break;
			
				case 'TallRedColumn'	: e.replacement =	'DD_TallRedColumn'; 	Break;
				case 'FloatingSkull'	: e.replacement =	'DD_FloatingSkull'; 	Break;
				case 'HeadCandles'	: e.replacement =	'DD_HeadCandles'; 	Break;
				case 'EvilEye'	: e.replacement =	'DD_EvilierEye'; 	Break;
				
				case 'TechPillar'	: e.replacement =	'DD_TechPillar'; 	Break;
				case 'BigTree'	: e.replacement =	'DD_BigTree'; 	Break;
				case 'TorchTree'	: e.replacement =	'DD_torchTree'; 	Break;
				case 'stalagmite'	: e.replacement =	'DD_stalagmite'; 	Break;
				case 'Stalagtite'	: e.replacement =	'DD_Stalagtite'; 	Break;
			
				
				case 'BloodyTwitch'	: e.replacement =	'DD_BloodyTwitch'; 	Break;
				case 'NonsolidTwitch'	: e.replacement =	'DD_NonSolidTwitch'; 	Break;
				case 'Meat2'	: e.replacement =	'DD_Meat2'; 	Break;
				case 'Meat3'	: e.replacement =	'DD_Meat3'; 	Break;
				case 'Meat4'	: e.replacement =	'DD_Meat4'; 	Break;
				case 'Meat5'	: e.replacement =	'DD_Meat5'; 	Break;
				case 'NonsolidMeat2'	: e.replacement =	'DD_Meat2b'; 	Break;
				case 'NonsolidMeat3'	: e.replacement =	'DD_Meat3b'; 	Break;
				case 'NonsolidMeat4'	: e.replacement =	'DD_Meat4b'; 	Break;
				case 'NonsolidMeat5'	: e.replacement =	'DD_Meat5b'; 	Break;
				
				case 'HangNoGuts'	: e.replacement =	'DD_Hang1NG'; 	Break;
				case 'HangBNoBrain'	: e.replacement =	'DD_Hang2NB'; 	Break;
				case 'HangTLookingDown'	: e.replacement =	'DD_Hang3TLD'; 	Break;
				case 'HangTLookingUp'	: e.replacement =	'DD_HAng4TLU'; 	Break;
				case 'HangTSkull'	: e.replacement =	'DD_HangTSK'; 	Break;
				case 'HangTNoBrain'	: e.replacement =	'DD_HangTNB'; 	Break;
				
				case 'DeadStick'	: e.replacement =	'DD_DeadStick'; 	Break;
				case 'livestick'	: e.replacement =	'DD_livestick'; 	Break;
				case 'HeadOnAStick'	: e.replacement =	'DD_HeadStick'; 	Break;
				case 'HeadsOnAStick'	: e.replacement =	'DD_HeadsStick'; 	Break;
				
				
				//Heretic compat
				case 'BrownPillar'	: e.replacement =	'DD_BrownPillar'; 	Break;
				
				case 'KeyGizmoBlue'	: e.replacement =	'DD_KeyGizmoBlue'; 	Break;
				case 'KeyGizmoGreen'	: e.replacement =	'DD_KeyGizmoGreen'; 	Break;
				case 'KeyGizmoYellow'	: e.replacement =	'DD_KeyGizmoYellow'; 	Break;
				
				case 'barrel'	: e.replacement =	'DD_WoodenBarrel'; 	Break;
				
				case 'FireBrazier'	: e.replacement =	'DD_FireBrazier'; 	Break;
				case 'WallTorch'	: e.replacement =	'DD_WallTorch'; 	Break;
				case 'SerpentTorch'	: e.replacement =	'DD_SerpentTorch'; 	Break;
			}
		}
	}
	
	
}