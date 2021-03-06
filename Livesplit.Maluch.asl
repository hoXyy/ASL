state("maluch")
{
	int isLoad : 0x133E88;
	int currentCp : 0xEF4F0;
	int totalCp : 0xEF91C;
	int currentLevel : 0x92454;
	bool hiperLevel : 0x914A8;
	bool inMenu : 0x83608;
	bool hasControl : 0x92568;
}

isLoading
{
	return current.isLoad != 0;
}

split
{
	return current.currentCp == current.totalCp && current.currentCp != old.currentCp;
}

reset
{
	return !current.hiperLevel && current.currentLevel == 0 && !current.inMenu && current.inMenu != old.inMenu;
}

start
{
	return current.hasControl;
}