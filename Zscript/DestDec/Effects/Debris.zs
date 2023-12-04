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
				int rfm = random(0,1);
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
			HRTL AABC 3;
			HRTL AABC 3;
			HRTL AABC 3;
			HRTL AABC 3;
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
	}
	states
	{
		Spawn:
			EVYT CCC 3 A_Setroll(roll + rollsidespeed);
			loop;
		Death:
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