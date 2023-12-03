Class DD_WoodenBarrel : DD_ShotDecoBase
{
	Default
	{
		Radius 12;
		Height 32;
		+SOLID
	}
	states
	{
		Spawn:
			HWBR A 1;
			TNT1 A 0 A_jumpif(health < slightdamaged,"LowDamage");
			loop;
			
		LowDamage:
			TNT1 A 0 DD_SpawnDebris("MetalScrap1",random(2,5),(0,0,45),random(3,10),random(3,10));
			TNT1 A 0 DD_SpawnDebris("WoodenStickPc",random(3,6),(0,0,35),random(3,10),random(3,10));
			HWBR B -1;
			stop;
		
		Death:
			TNT1 A 0 DD_SpawnDebris("MetalScrap1",random(2,6),(0,0,45),random(3,10),random(3,10));
			TNT1 A 0 DD_SpawnDebris("WoodenStickPc",random(6,10),(0,0,35),random(3,10),random(3,10));
			HWBR C -1;
			stop;
	}
}