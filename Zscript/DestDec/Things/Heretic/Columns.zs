Class DD_BrownPillar : DD_ShotDecoBase
{
	Default
	{
		Radius 14;
		Height 128;
		+SOLID
		deathheight 16;
	}
	states
	{
		Spawn:
			HCL1 A 1;
			TNT1 A 0 A_jumpif(health < halflife,"MidDamage");
			loop;
		MidDamage:
			TNT1 A 0 DD_SpawnDebris("MetalScrap1",random(5,10),(0,0,30),random(3,10),random(3,10));
			HCL1 B -1;
			stop;
		Death:
			TNT1 A 0 DD_SpawnDebris("MetalScrap1",random(5,10),(0,0,30),random(3,10),random(3,10));
			HCL1 C -1;
			stop;
	}
}