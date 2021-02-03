//Public Ve Forward Lar

forward ucsaniyesonra(playerid);
public ucsaniyesonra(playerid)
{
	for(new i=0; i < 95; i++) SendClientMessage(playerid, -1, " ");
	SendClientMessage(playerid, 0xA9C4E4FF, "SA-MP Regular Roleplay Sunucusu Baþlatýlýyor...");
	SendClientMessage(playerid, 0xA9C4E4FF, "Baþlatýldý Anti-Cheat Çalýþtýrýlýyor...");
	SendClientMessage(playerid, 0xA9C4E4FF, "Çalýþtýrýldý Giriþ Yapýlýyor Lütfen Bekleyin...");
	return 1;
}

forward SirketleriYukle();
public SirketleriYukle()
{
	new rows = cache_num_rows();

	if(rows)
	{
		for(new i = 0; i < rows; i++)
		{
			cache_get_value_name_int(i, "sirketID", sirketData[i][sirketID]);
			cache_get_value_name(i, "sirketAd", sirketData[i][sirketAd]);
			cache_get_value_name_int(i, "sirketTip", sirketData[i][sirketTip]);
			cache_get_value_name_int(i, "sirketRank", sirketData[i][sirketRank]);
			cache_get_value_name(i, "sirketSahip", sirketData[i][sirketSahip]);
			cache_get_value_name_int(i, "sirketVergi", sirketData[i][sirketVergi]);
			cache_get_value_name_int(i, "sirketKasa", sirketData[i][sirketKasa]);
			cache_get_value_name_int(i, "sirketVergiZaman", sirketData[i][sirketVergiZaman]);
			cache_get_value_name_int(i, "sirketCP", sirketData[i][sirketCP]);
			cache_get_value_name_int(i, "sirketCPT", sirketData[i][sirketCPT]);
			cache_get_value_name(i, "sirketCEO", sirketData[i][sirketCEO]);
			cache_get_value_name(i, "sirketGM", sirketData[i][sirketGM]);
			cache_get_value_name(i, "sirketCalisanlar0", sirketCalisanlar[i][0]);
			cache_get_value_name(i, "sirketCalisanlar1", sirketCalisanlar[i][1]);
			cache_get_value_name(i, "sirketCalisanlar2", sirketCalisanlar[i][2]);
			cache_get_value_name(i, "sirketCalisanlar3", sirketCalisanlar[i][3]);
			cache_get_value_name(i, "sirketCalisanlar4", sirketCalisanlar[i][4]);
			cache_get_value_name(i, "sirketCalisanlar5", sirketCalisanlar[i][5]);
			cache_get_value_name(i, "sirketCalisanlar6", sirketCalisanlar[i][6]);
			cache_get_value_name(i, "sirketCalisanlar7", sirketCalisanlar[i][7]);
			cache_get_value_name(i, "sirketCalisanlar8", sirketCalisanlar[i][8]);
			cache_get_value_name(i, "sirketCalisanlar9", sirketCalisanlar[i][9]);
			cache_get_value_name(i, "sirketCalisanlar10", sirketCalisanlar[i][10]);
		}
	}

	return 1;
}
forward ilkarabalar(playerid);
public ilkarabalar(playerid)
{
	ilkarabalars = 0;
	return 1;
}
forward RemoveLog(id);
public RemoveLog(id)
{
	if (!Iter_Contains(Logs, id))
		return 1;

	if (LogData[id][logSeconds] > 1)
	{
	    LogData[id][logSeconds]--;

        new label[256];
	    format(label, sizeof(label), "Et (%d)\n\n{F1C40F}%s {FFFFFF}isimli oyuncu býraktý.\n{FFFFFF}%s\nEti almak için {F1C40F}/et yerden al {FFFFFF}yazabilirsin.", id, LogData[id][logDroppedBy], ConvertToMinutes(LogData[id][logSeconds]));
		UpdateDynamic3DTextLabelText(LogData[id][logLabel], 0xF1C40FFF, label);
	}
	else if (LogData[id][logSeconds] == 1)
	{
	    KillTimer(LogData[id][logTimer]);
	    DestroyDynamicObject(LogData[id][logObjID]);
		DestroyDynamic3DTextLabel(LogData[id][logLabel]);

	    LogData[id][logTimer] = -1;
        LogData[id][logObjID] = -1;
        LogData[id][logLabel] = Text3D: -1;

		Iter_Remove(Logs, id);
	}

	return 1;
}
forward YarisBaslat(y);
public YarisBaslat(y)
{
    if(Yarislar[y][yarisGeriSayim] == 3)
    {

        foreach(new i : Player) {
            if(PlayerData[i][pYaris] == y || PlayerData[i][pYarisHazirliyormu] == y) {
            	GameTextForPlayer(i, "~r~3", 1000, 3);
            	TogglePlayerControllable(i, 0);
            	PlayerData[i][pYarisAdim] = 0;
            	SetPlayerRaceCheckpoint(i, 0, Yarislar[i][yarisCPx][0], Yarislar[i][yarisCPy][0], Yarislar[i][yarisCPz][0], Yarislar[i][yarisCPx][1], Yarislar[i][yarisCPy][1], Yarislar[i][yarisCPz][1], 5.0);
            }
        }
        Yarislar[y][yarisGeriSayim]--;
        SetTimerEx("YarisBaslat", 1000, false, "d", y);
    }
    else if(Yarislar[y][yarisGeriSayim] == 2)
    {
        foreach(new i : Player) {
            if(PlayerData[i][pYaris] == y || PlayerData[i][pYarisHazirliyormu] == y) {
            	GameTextForPlayer(i, "~y~2", 1000, 3);
            	TogglePlayerControllable(i, 0);
            }
        }
        Yarislar[y][yarisGeriSayim]--;
        SetTimerEx("YarisBaslat", 1000, false, "d", y);
    }
    else if(Yarislar[y][yarisGeriSayim] == 1)
    {
        foreach(new i : Player) {
            if(PlayerData[i][pYaris] == y || PlayerData[i][pYarisHazirliyormu] == y) {
            	GameTextForPlayer(i, "~y~1", 1000, 3);
            	TogglePlayerControllable(i, 0);
            }
        }
        Yarislar[y][yarisGeriSayim]--;
        SetTimerEx("YarisBaslat", 1000, false, "d", y);
    }
    else if(Yarislar[y][yarisGeriSayim] <= 0)
    {
        foreach(new i : Player) {
            if(PlayerData[i][pYaris] == y || PlayerData[i][pYarisHazirliyormu] == y) {
            	GameTextForPlayer(i, "~g~START!", 1000, 3);
            	TogglePlayerControllable(i, 1);
            }
        }
        Yarislar[y][yarisDurum] = 1;
        Yarislar[y][yarisGeriSayim] = 3;
        CallLocalFunction("YarisBaslat", "d", y);
    }
	return 1;
}
forward AracKontrol();
public AracKontrol()
{
	new Float: vehHP;
	for (new i = 1; i < GetVehiclePoolSize(); i++)
	{
		if (!IsValidVehicle(i))
			continue;

		GetVehicleHealth(i, vehHP);
		if (vehHP < 250)
			SetVehicleHealth(i, 300.0);
	}
	return 1;
}

forward Float:AracHizKontrol(playerid);
stock Float:AracHizKontrol(playerid)
{
    if (IsPlayerInAnyVehicle(playerid)) {
        static Float:fSpeed, Float:fVelocity[3];
        GetVehicleVelocity(GetPlayerVehicleID(playerid), fVelocity[0], fVelocity[1], fVelocity[2]);
        fSpeed = floatmul(floatsqroot((fVelocity[0] * fVelocity[0]) + (fVelocity[1] * fVelocity[1]) + (fVelocity[2] * fVelocity[2])), 100.0);
        return fSpeed;
    }
    return 0.0;
}

forward AntiCheat();
public AntiCheat()
{
for(new i = 0; i < MAX_PLAYERS; i++)
    {

    new vehicleid = GetPlayerVehicleID(i);
/*    if(!IsAPlane(GetPlayerVehicleID(i)) && GetPlayerState(i) == PLAYER_STATE_ONFOOT && GetPlayerSpeed2(i) >= 100)
    {
        AdminMessage(COLOR_LIGHTRED, "[Anti Cheat] %s slapper hack kullandýðý için oyundan atýldý.", ReturnName(i, 0));
        MesajGonder(i, "Slapper hack kullandýðýnýz için oyundan atýldýnýz.");
        Log_Write("logs/antihile.log", "[%s] %s slapper hack kullandýðý için oyundan atýldý.", ReturnDate(), ReturnName(i));
        Kick(i);
    }*/
        if(GetPlayerAnimationIndex(i))
	{
		new anim[2][32];

		GetAnimationName(GetPlayerAnimationIndex(i), anim[0], 32, anim[1], 32);
		if(GetPlayerSpeed2(i) > 10 && !strcmp(anim[0], "BEACH", true) && !strcmp(anim[1], "ParkSit_W_loop", true))
		{
            AdminMessage(COLOR_LIGHTRED, "[Anti Cheat] %s fly hack kullandýðý için oyundan atýldý.", ReturnName(i, 0));
            Log_Write("logs/antihile.log", "[%s] %s fly hack kullandýðý için oyundan atýldý.", ReturnDate(), ReturnName(i));
            Kick(i);
        }
    }
        if (GetPlayerSpecialAction(i) == SPECIAL_ACTION_USEJETPACK && !PlayerData[i][pJetpack])
		{
	    	AdminMessage(COLOR_LIGHTRED, "[Anti Cheat] %s jetpack hilesi kullandýðý için atýldý.", ReturnName(i, 0));
           Log_Write("logs/antihile.log", "[%s] %s jetpack hilesi kullandýðý için atýldý.", ReturnDate(), ReturnName(i));
			Kick(i);
		}
		if (PlayerData[i][pLegalMotor] == 0 && GetPlayerSpeed2(i) > 40 && !IsAPlane(GetPlayerVehicleID(i)) && !GetEngineStatus(vehicleid) && GetPlayerState(i) != PLAYER_STATE_PASSENGER && GetPlayerState(i) == PLAYER_STATE_DRIVER)
        {
        AdminMessage(COLOR_LIGHTRED, "[Anti Cheat] %s motoru kapalý araç kullanmaya çalýþtýðý için araçtan atýldý (%d KM).", ReturnName(i, 0), GetPlayerSpeed2(i));
        MesajGonder(i, "Motoru kapalý araç sürmeye çalýþtýðýnýz için araçtan atýldýnýz.");
        Log_Write("logs/antihile.log", "[%s] %s motoru kapalý araç kullanmaya çalýþtýðý için araçtan atýldý.", ReturnDate(), ReturnName(i));
        GetPlayerPos(i, posX[i], posY[i], posZ[i]);
        SetVehiclePos(GetPlayerVehicleID(i), posX[i], posY[i], posZ[i]);
        PlayerData[i][pLegalTeleport] = gettime() + 2;
        SetPlayerPos(i, posX[i], posY[i], posZ[i]);
        }
	    if (GetPlayerState(i) == PLAYER_STATE_DRIVER && GetPlayerSpeed2(i) > 260)
	    {
           if (!IsAPlane(GetPlayerVehicleID(i)))
           {
           AdminMessage(COLOR_LIGHTRED, "[Anti Cheat] %s speed hack kullandýðý için oyundan atýldý (%d KM).", ReturnName(i, 0), GetPlayerSpeed2(i));
           Log_Write("logs/antihile.log", "[%s] %s speed hack kullandýðý için oyundan atýldý (%d KM).", ReturnDate(), ReturnName(i, 0), GetPlayerSpeed2(i));
           Kick(i);
	       }
        }
    }
            return 1;
}

forward AntiInvisible();
public AntiInvisible()
{
for(new i = 0; i < MAX_PLAYERS; i++)
    {
        if (PlayerData[i][pSpec] == 0 && GetPVarInt(i, "Logged") == 1 && GetPlayerState(i) == PLAYER_STATE_SPECTATING)
        {
		AdminMessage(COLOR_LIGHTRED, "[Anti Cheat] %s invisible hack kullandýðý için oyundan atýldý.", ReturnName(i, 0));
        Log_Write("logs/antihile.log", "[%s] %s invisible hack kullandýðý için oyundan atýldý.", ReturnDate(), ReturnName(i));
		Kick(i);
	    }
    }
          return 1;
}
forward SilahlariniVer(playerid);
public SilahlariniVer(playerid)
{
    SetWeapons(playerid);
	return 1;
}
forward FreezeJacker(playerid); public FreezeJacker(playerid)
{
	TogglePlayerControllable(playerid, 1);
	return 1;
}
forward OnVehicleRequestDeath(vehicleid, killerid);
public OnVehicleRequestDeath(vehicleid, killerid)
{
    new Float:health;

    GetVehicleHealth(vehicleid, health);

    if (health >= 250.0)
    {
        fuckYou(killerid);
        return 0;
    }

    return 1;
}
forward AntiSlap(playerid);
public AntiSlap(playerid)
{
    if(Spawned[playerid] == 1 && GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        if(GetPlayerSpeed3(playerid) >= 400 && !IsPlayerInWater(playerid))
        {
            if(GetPlayerSurfingVehicleID(playerid) == INVALID_VEHICLE_ID && GetPlayerSurfingObjectID(playerid) == INVALID_OBJECT_ID)
            {
                AdminMessage(COLOR_LIGHTRED, "[Anti Cheat] %s, Slapper hilesi kullanýyor olabilir.", ReturnName(playerid, 0));
            }
        }
    }
    return 1;
}

forward absfren(playerid);
public absfren(playerid)
{
 	if (AracHizKontrol(playerid) < 6)
 	{

	}
	else
	{
		SetVehicleSpeed(GetPlayerVehicleID(playerid), AracHizKontrol(playerid) - 6);
	 	SetTimerEx("absfren", 75, false, "i", playerid);
	}
	return 1;
}
forward WalkAnim(playerid);
public  WalkAnim(playerid)
{
	new keys, updown, leftright;
	GetPlayerKeys(playerid,keys,updown,leftright);
	if (GetPlayerWalkingStyle(playerid) == WALK_NORMAL)
	{
 	 	if ((keys & KEY_WALK && updown & KEY_UP) || (keys & KEY_WALK && updown & KEY_DOWN) || (keys & KEY_WALK && leftright & KEY_LEFT) || (keys & KEY_WALK && leftright & KEY_RIGHT))
		{
		   	KillTimer(walktime[playerid]);
			ApplyAnimation(playerid, "PED", "WALK_player",4.1,1,1,1,1,1);
			walktime[playerid] = SetTimerEx("WalkAnim",200,0, "d",playerid);
		}
		else ApplyAnimation(playerid, "PED", "WALK_player",4.0,0,0,0,0,1), KillTimer(walktime[playerid]);
	}
	else if (GetPlayerWalkingStyle(playerid) == WALK_PED)
	{
 	 	if ((keys & KEY_WALK && updown & KEY_UP) || (keys & KEY_WALK && updown & KEY_DOWN) || (keys & KEY_WALK && leftright & KEY_LEFT) || (keys & KEY_WALK && leftright & KEY_RIGHT))
		{
		   	KillTimer(walktime[playerid]);
			ApplyAnimation(playerid, "PED", "WALK_civi",4.1,1,1,1,1,1);
			walktime[playerid] = SetTimerEx("WalkAnim",200,0, "d",playerid);
		}
		else ApplyAnimation(playerid, "PED", "WALK_civi",4.0,0,0,0,0,1), KillTimer(walktime[playerid]);
	}
 	else if (GetPlayerWalkingStyle(playerid) == WALK_GANGSTA)
	{
 	 	if ((keys & KEY_WALK && updown & KEY_UP) || (keys & KEY_WALK && updown & KEY_DOWN) || (keys & KEY_WALK && leftright & KEY_LEFT) || (keys & KEY_WALK && leftright & KEY_RIGHT))
		{
		   	KillTimer(walktime[playerid]);
			ApplyAnimation(playerid, "PED", "WALK_gang1",4.1,1,1,1,1,1);
			walktime[playerid] = SetTimerEx("WalkAnim",200,0, "d",playerid);
		}
		else ApplyAnimation(playerid, "PED", "WALK_gang1",4.0,0,0,0,0,1), KillTimer(walktime[playerid]);
	}
	else if (GetPlayerWalkingStyle(playerid) == WALK_GANGSTA2)
	{
 	 	if ((keys & KEY_WALK && updown & KEY_UP) || (keys & KEY_WALK && updown & KEY_DOWN) || (keys & KEY_WALK && leftright & KEY_LEFT) || (keys & KEY_WALK && leftright & KEY_RIGHT))
		{
		   	KillTimer(walktime[playerid]);
			ApplyAnimation(playerid, "PED", "WALK_gang2",4.1,1,1,1,1,1);
			walktime[playerid] = SetTimerEx("WalkAnim",200,0, "d",playerid);
		}
		else ApplyAnimation(playerid, "PED", "WALK_gang2",4.0,0,0,0,0,1), KillTimer(walktime[playerid]);
	}
	else if (GetPlayerWalkingStyle(playerid) == WALK_OLD)
	{
 	 	if ((keys & KEY_WALK && updown & KEY_UP) || (keys & KEY_WALK && updown & KEY_DOWN) || (keys & KEY_WALK && leftright & KEY_LEFT) || (keys & KEY_WALK && leftright & KEY_RIGHT))
		{
		   	KillTimer(walktime[playerid]);
			ApplyAnimation(playerid, "PED", "WALK_old",4.1,1,1,1,1,1);
			walktime[playerid] = SetTimerEx("WalkAnim",200,0, "d",playerid);
		}
		else ApplyAnimation(playerid, "PED", "WALK_old",4.0,0,0,0,0,1), KillTimer(walktime[playerid]);
	}
	else if (GetPlayerWalkingStyle(playerid) == WALK_FAT_OLD)
	{
 	 	if ((keys & KEY_WALK && updown & KEY_UP) || (keys & KEY_WALK && updown & KEY_DOWN) || (keys & KEY_WALK && leftright & KEY_LEFT) || (keys & KEY_WALK && leftright & KEY_RIGHT))
		{
		   	KillTimer(walktime[playerid]);
			ApplyAnimation(playerid, "PED", "WALK_fatold",4.1,1,1,1,1,1);
			walktime[playerid] = SetTimerEx("WalkAnim",200,0, "d",playerid);
		}
		else ApplyAnimation(playerid, "PED", "WALK_fatold",4.0,0,0,0,0,1), KillTimer(walktime[playerid]);
	}
	else if (GetPlayerWalkingStyle(playerid) == WALK_FAT)
	{
 	 	if ((keys & KEY_WALK && updown & KEY_UP) || (keys & KEY_WALK && updown & KEY_DOWN) || (keys & KEY_WALK && leftright & KEY_LEFT) || (keys & KEY_WALK && leftright & KEY_RIGHT))
		{
		   	KillTimer(walktime[playerid]);
			ApplyAnimation(playerid, "PED", "WALK_fat",4.1,1,1,1,1,1);
			walktime[playerid] = SetTimerEx("WalkAnim",200,0, "d",playerid);
		}
		else ApplyAnimation(playerid, "PED", "WALK_fat",4.0,0,0,0,0,1), KillTimer(walktime[playerid]);
	}
	else if (GetPlayerWalkingStyle(playerid) == WALK_LADY)
	{
 	 	if ((keys & KEY_WALK && updown & KEY_UP) || (keys & KEY_WALK && updown & KEY_DOWN) || (keys & KEY_WALK && leftright & KEY_LEFT) || (keys & KEY_WALK && leftright & KEY_RIGHT))
		{
		   	KillTimer(walktime[playerid]);
			ApplyAnimation(playerid, "PED", "WOMAN_walknorm",4.1,1,1,1,1,1);
			walktime[playerid] = SetTimerEx("WalkAnim",200,0, "d",playerid);
		}
		else ApplyAnimation(playerid, "PED", "WOMAN_walknorm",4.0,0,0,0,0,1), KillTimer(walktime[playerid]);
	}
	else if (GetPlayerWalkingStyle(playerid) == WALK_LADY2)
	{
 	 	if ((keys & KEY_WALK && updown & KEY_UP) || (keys & KEY_WALK && updown & KEY_DOWN) || (keys & KEY_WALK && leftright & KEY_LEFT) || (keys & KEY_WALK && leftright & KEY_RIGHT))
		{
		   	KillTimer(walktime[playerid]);
			ApplyAnimation(playerid, "PED", "WOMAN_walkbusy",4.1,1,1,1,1,1);
			walktime[playerid] = SetTimerEx("WalkAnim",200,0, "d",playerid);
		}
		else ApplyAnimation(playerid, "PED", "WOMAN_walkbusy",4.0,0,0,0,0,1), KillTimer(walktime[playerid]);
	}
	else if (GetPlayerWalkingStyle(playerid) == WALK_WHORE)
	{
 	 	if ((keys & KEY_WALK && updown & KEY_UP) || (keys & KEY_WALK && updown & KEY_DOWN) || (keys & KEY_WALK && leftright & KEY_LEFT) || (keys & KEY_WALK && leftright & KEY_RIGHT))
		{
		   	KillTimer(walktime[playerid]);
			ApplyAnimation(playerid, "PED", "WOMAN_walkpro",4.1,1,1,1,1,1);
			walktime[playerid] = SetTimerEx("WalkAnim",200,0, "d",playerid);
		}
		else ApplyAnimation(playerid, "PED", "WOMAN_walkpro",4.0,0,0,0,0,1), KillTimer(walktime[playerid]);
	}
	else if (GetPlayerWalkingStyle(playerid) == WALK_WHORE2)
	{
 	 	if ((keys & KEY_WALK && updown & KEY_UP) || (keys & KEY_WALK && updown & KEY_DOWN) || (keys & KEY_WALK && leftright & KEY_LEFT) || (keys & KEY_WALK && leftright & KEY_RIGHT))
		{
		   	KillTimer(walktime[playerid]);
			ApplyAnimation(playerid, "PED", "WOMAN_walksexy",4.1,1,1,1,1,1);
			walktime[playerid] = SetTimerEx("WalkAnim",200,0, "d",playerid);
		}
		else ApplyAnimation(playerid, "PED", "WOMAN_walksexy",4.0,0,0,0,0,1), KillTimer(walktime[playerid]);
	}
	else if (GetPlayerWalkingStyle(playerid) == WALK_DRUNK)
	{
 	 	if ((keys & KEY_WALK && updown & KEY_UP) || (keys & KEY_WALK && updown & KEY_DOWN) || (keys & KEY_WALK && leftright & KEY_LEFT) || (keys & KEY_WALK && leftright & KEY_RIGHT))
		{
		   	KillTimer(walktime[playerid]);
			ApplyAnimation(playerid, "PED", "WALK_drunk",4.1,1,1,1,1,1);
			walktime[playerid] = SetTimerEx("WalkAnim",200,0, "d",playerid);
		}
		else ApplyAnimation(playerid, "PED", "WALK_drunk",4.0,0,0,0,0,1), KillTimer(walktime[playerid]);
	}
	else if (GetPlayerWalkingStyle(playerid) == WALK_BLIND)
	{
 	 	if ((keys & KEY_WALK && updown & KEY_UP) || (keys & KEY_WALK && updown & KEY_DOWN) || (keys & KEY_WALK && leftright & KEY_LEFT) || (keys & KEY_WALK && leftright & KEY_RIGHT))
		{
		   	KillTimer(walktime[playerid]);
			ApplyAnimation(playerid, "PED", "Walk_Wuzi",4.1,1,1,1,1,1);
			walktime[playerid] = SetTimerEx("WalkAnim",200,0, "d",playerid);
		}
		else ApplyAnimation(playerid, "PED", "Walk_Wuzi",4.0,0,0,0,0,1), KillTimer(walktime[playerid]);
	}
	return 1;
}
forward OnPlayerCBug(playerid);
public OnPlayerCBug(playerid)
{
	SetPlayerArmedWeapon(playerid, 0);
	TogglePlayerControllable(playerid, false);
	SetTimerEx("CbugUnfreeze", 500, false, "i", playerid);
	GameTextForPlayer(playerid, " ", 1500, 4);
	return 1;
}

forward CbugUnfreeze(playerid);
public CbugUnfreeze(playerid)
{
    TogglePlayerControllable(playerid, true);
	return 1;
}
forward CrouchCheck(playerid);
public CrouchCheck(playerid) {
        CheckCrouch[playerid] = 0;
        return 1;
}
forward LabelYarat(labelid, labeladi[], renk, vw, int, Float: x, Float: y, Float: z, Float: mesafe);
public LabelYarat(labelid, labeladi[], renk, vw, int, Float: x, Float: y, Float: z, Float: mesafe)
{
	new File:ldosya;
	new dosyayolu[128];
	new string[250];
	format(dosyayolu, sizeof(dosyayolu), "/Labeller/%d.cfg", labelid);
	ldosya = fopen(dosyayolu, io_append);
	format(string, sizeof(string), "%s>%d>%d>%d>%f>%f>%f>%f\r\n", labeladi, renk, vw, int, x, y, z, mesafe);
	fwrite(ldosya, string);
	fclose(ldosya);
	return 1;
}

forward fcreate(filename[]);
public fcreate(filename[])
{
	if (fexist(filename)){return false;}
	new File:fhandle = fopen(filename, io_write);
	fwrite(fhandle, "bos");
	fclose(fhandle);
	return true;
}
forward TS_GrupGonderVIP(playerid, group);
public TS_GrupGonderVIP(playerid, group)
{
	new isim[90];

	format(isim, sizeof(isim), "(%d) %s", PlayerData[playerid][pID], ReturnName(playerid, 0));

	new id = TSC_GetClientIdByIpAddress(GetIP(playerid)), channelid = TSC_GetChannelIdByName(isim);

	TSC_MoveClient(id, channelid);
	TSC_SetClientChannelGroup(id, group, channelid);
	TSC_SetChannelParentId(channelid, 157);

	return 1;
}

forward TS_GrupGonderBirlik(playerid, group);
public TS_GrupGonderBirlik(playerid, group)
{
	new isim[90];

	format(isim, sizeof(isim), "(%d) %s", Birlikler[PlayerData[playerid][pFaction]][birlikID], Birlikler[PlayerData[playerid][pFaction]][birlikAd]);

	new id = TSC_GetClientIdByIpAddress(GetIP(playerid)), channelid = TSC_GetChannelIdByName(isim);

	TSC_MoveClient(id, channelid);
	TSC_SetClientChannelGroup(id, group, channelid);
	TSC_SetChannelParentId(channelid, 160);

	return 1;
}
forward KelepceKiriliyor(playerid);
public KelepceKiriliyor(playerid)
{
	new str[256];

	if (KelepceSure[playerid] > 1)
	{
		KelepceSure[playerid] -= 1;

		format(str, sizeof str, "~w~Kelepce Kiriliyor~n~~r~%d", KelepceSure[playerid]);

		GameTextForPlayer(playerid, str, 2000, 4);
	}
	if (KelepceSure[playerid] == 1)
	{
	    PlayerData[playerid][pKelepce] = 0;
    	PlayerData[playerid][pDragged] = 0;
		PlayerData[playerid][pDraggedBy] = INVALID_PLAYER_ID;
		KillTimer(PlayerData[playerid][pDragTimer]);

		SetPlayerCuffed(playerid, false);
    	TogglePlayerControllable(playerid, true);

    	ParaVer(playerid, -2500);

    	SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** Kelepçeci %s adlý kiþinin kelepçelerini kýrar.", ReturnName(playerid, 0));
	    KillTimer(KelepceTimer[playerid]);
	}
	return 1;
}
forward SorulariYukle();
public SorulariYukle()
{
    mysql_query(g_SQL, "SELECT * FROM `sorular`");

	new rows = cache_num_rows();
    printf("» Toplam %d soru yüklendi.",rows);

	if (rows)
	{
	    new ssID;
		for (new i = 0; i < rows; i ++) if (i < MAX_SORU)
	    {
	        cache_get_value_name_int(i, "sid", ssID);

            SoruData[ssID][soruExists] = true;
            SoruData[ssID][soruID] = ssID;

	        cache_get_value_name(i, "Soru",SoruData[ssID][Soru],50);
	        cache_get_value_name(i, "Cevap",SoruData[ssID][SoruCevap],128);
	        cache_get_value_name_int(i, "OkunmaSayisi",SoruData[ssID][OkunmaSayisi]);
	        cache_get_value_name(i, "Tarih",SoruData[ssID][EklenmeTarihi],25);
	        cache_get_value_name(i, "Ekleyen",SoruData[ssID][Ekleyen],24);
	    }
    }
    return 1;
}
forward OnPlayerBasvuru(playerid);
public OnPlayerBasvuru(playerid)
{

   	new name[MAX_PLAYER_NAME + 1];
    GetPlayerName(playerid, name, sizeof name);
    return 1;
}
forward LegalEngine(playerid);
public LegalEngine(playerid)
{
    PlayerData[playerid][pLegalMotor] = 0;
    return 1;
}
forward AracDetaylariGoruntule(playerid, modelid);
public AracDetaylariGoruntule(playerid, modelid)
{
	new rows = cache_num_rows();

	if(rows)
	{
		new fiyat;

		cache_get_value_index_int(0, 0, fiyat);

		SetPVarInt(playerid, "aracFiyat", fiyat);
		SetPVarInt(playerid, "aracModel", modelid);

		Dialog_Show(playerid, AracDetaylari, DIALOG_STYLE_LIST, "Araç Satýn Al", "Araç: %s\nFiyat: $%d\nRenk 1: %d\nRenk 2: %d\nSatýn Al", "Seç", "Kapat", ReturnVehicleModelName(modelid), fiyat, GetPVarInt(playerid, "aracRenk1"), GetPVarInt(playerid, "aracRenk2"));
	}

	else HataMesajGonder(playerid, "Araç verileri alýnamadý.");

	return 1;
}

forward SatilikAraclar(playerid);
public SatilikAraclar(playerid)
{
	new rows = cache_num_rows();

	if(rows)
	{
		new araclar[300];

		for(new i = 0; i < rows; i++)
		{
			cache_get_value_index_int(i, 0, araclar[i]);
		}

		ShowModelSelectionMenuEx(playerid, araclar, rows, "Satilik Araclar", SATILIK_ARACLAR);
	}

	else HataMesaji(playerid, "Satýlýk araç bulunamadý.");

	return 1;
}

forward MDDragUpdate(playerid, targetid);
public MDDragUpdate(playerid, targetid)
{
	if (PlayerData[targetid][pDragged] && PlayerData[targetid][pDraggedBy] == playerid)
	{
	    static Float:fX, Float:fY, Float:fZ, Float:fAngle;

		GetPlayerPos(playerid, fX, fY, fZ);
		GetPlayerFacingAngle(playerid, fAngle);

		fX -= 1.5 * floatsin(-fAngle, degrees);
		fY -= 1.5 * floatcos(-fAngle, degrees);

		SetDynamicObjectPos(Sedye[playerid], fX, fY, fZ - 0.5);
		SetDynamicObjectRot(Sedye[playerid], 0.0000000, 0.0000000, fAngle);

		SetPlayerPos(targetid, fX, fY, fZ + 1.1000);

		ApplyAnimation(targetid, "SWAT", "gnstwall_injurd", 4.1, true, false, false, false, 0, false);

		SetPlayerInterior(targetid, GetPlayerInterior(playerid));
		SetPlayerVirtualWorld(targetid, GetPlayerVirtualWorld(playerid));
	}
	return 1;
}

forward DragUpdate(playerid, targetid);
public DragUpdate(playerid, targetid)
{
	if (PlayerData[targetid][pDragged] && PlayerData[targetid][pDraggedBy] == playerid)
	{
	    static
	        Float:fX,
	        Float:fY,
	        Float:fZ,
			Float:fAngle;

		GetPlayerPos(playerid, fX, fY, fZ);
		GetPlayerFacingAngle(playerid, fAngle);

		fX -= 1.5 * floatsin(-fAngle, degrees);
		fY -= 1.5 * floatcos(-fAngle, degrees);

		SetPlayerPos(targetid, fX, fY, fZ);
		SetPlayerInterior(targetid, GetPlayerInterior(playerid));
		SetPlayerVirtualWorld(targetid, GetPlayerVirtualWorld(playerid));
	}
	return 1;
}
forward GiseKapat(id);
public GiseKapat(id)
{
    Gise[id][gs_Durum] = GISE_KAPALI;
    MoveDynamicObject(Gise[id][gs_Obje], Gise[id][gs_Kapali][0], Gise[id][gs_Kapali][1], Gise[id][gs_Kapali][2], 2.5,  Gise[id][gs_Kapali][3], Gise[id][gs_Kapali][4], Gise[id][gs_Kapali][5]);
	return 1;
}
forward RotateFerrisWheel();
public RotateFerrisWheel()
{
	FerrisWheelAngle += 36;

	if (FerrisWheelAngle >= 360)
		FerrisWheelAngle = 0;

	if (FerrisWheelAlternate)
		FerrisWheelAlternate = 0;
	else
		FerrisWheelAlternate = 1;

	new Float:FerrisWheelModZPos = 0.0;

	if (FerrisWheelAlternate)
		FerrisWheelModZPos = 0.05;

	MoveObject(FerrisWheelObjects[10], 389.7734, -2028.4688, 22.0+FerrisWheelModZPos, FERRIS_WHEEL_SPEED, 0, FerrisWheelAngle, 90);
	return 1;
}
forward ObjeYaratildi(objeid);
public ObjeYaratildi(objeid)
{
	if(objeid == -1 || !Obje[objeid][objeKullanimda])
	    return 0;

	Obje[objeid][objeID] = cache_insert_id();
	Obje_Kaydet(objeid);
	return 1;
}
forward AraclariSpawnla(playerid);
public AraclariSpawnla(playerid)
{
	new count, model;

    for (new i = 0; i < MAX_ARAC; i++)
	{
        if (AracInfo[i][aracExists] && GetVehicleDriver(AracInfo[i][aracVehicle]) == INVALID_PLAYER_ID && GetVehicleModel(AracInfo[i][aracVehicle]) != 435 && GetVehicleModel(AracInfo[i][aracVehicle]) != 450 && GetVehicleModel(AracInfo[i][aracVehicle]) != 591)
        {
        	model = GetVehicleModel(AracInfo[i][aracVehicle]);

        	if(model == 606 || model == 607 || model == 610 || model == 584 || model == 611 || model == 608 || model == 435 || model == 450 || model == 591)
        		continue;

            Arac_Spawn(i);
            count++;
        }
    }

    if (!count)
        return HataMesajGonder(playerid, "Hiç araç yok.");

	foreach (new i : Player)
	{
	    SendClientMessageEx(i, 0x00FF00FF, "[!] {FFFFFF}Sunucudaki kullanýlmayan tüm araçlar respawlandý.");
	}

    MesajGonder(playerid, "%d adet araç respawn edildi.", count);
	return 1;
}
forward OnQueryExecute(playerid, query[]);
public OnQueryExecute(playerid, query[])
{
    new rows;

    cache_get_row_count(rows);
    if (strfind(query, "SELECT", true) != -1)
    {
        MesajGonder(playerid, "Sorgu çalýþtýrýldý, rows: %d", rows);
    }
    else
    {
        MesajGonder(playerid, "Sorgu çalýþtýrýlmýþtýr.");
    }
    return 1;
}
forward OnSicilView(playerid, id);
public OnSicilView(playerid, id)
{
	new rows;
	cache_get_row_count(rows);
	if (!rows) return HataMesajGonder(playerid, "Bu oyuncunun hiç OOC sicil kaydý yok.");
	new str[1000], uygulayan[24], tur, turstring[15], sebep[50], tarih[30];
	strcat(str, "Uygulayan\tTür\tSebep\tTarih\n");
	for (new i; i<rows; i++)
	{
	    cache_get_value_name(i, "Uygulayan", uygulayan, 24);
	    cache_get_value_name_int(i, "Tur", tur);
	    cache_get_value_name(i, "Sebep", sebep, 50);
	    cache_get_value_name(i, "Tarih", tarih, 30);
	    switch (tur)
	    {
	        case 1: turstring = "Kick";
	        case 2: turstring = "Ban";
	        case 3: turstring = "Hapis";
	        case 4: turstring = "Client Ban";
	        default: turstring = "Bilinmiyor";
	    }
	    format(str, sizeof(str), "%s%s\t%s\t%s\t%s\n", str, uygulayan, turstring, sebep, tarih);
	}
	new baslik[50];
	format(baslik, sizeof(baslik), "OOC Sicil Kayýtlarý (Toplam %d)", rows);
	Dialog_Show(playerid, Banli, DIALOG_STYLE_TABLIST_HEADERS, baslik, str, "Kapat", "");
	return 1;
}
forward BanInfo(playerid, bilgi[]);
public BanInfo(playerid, bilgi[])
{
	new rows;
	cache_get_row_count(rows);
	if (!rows) return HataMesajGonder(playerid, "Bu karakter adý veya IP banlý deðil.");
	new ad[24], ip[30], banlanmatarihi[30], sebep[50], banlayan[24], sure;
	cache_get_value_name(0, "Ad", ad, 24);
	cache_get_value_name(0, "IP", ip, 30);
	cache_get_value_name(0, "BanlanmaTarihi", banlanmatarihi, 30);
	cache_get_value_name(0, "Sebep", sebep, 50);
	cache_get_value_name(0, "Banlayan", banlayan, 24);
	cache_get_value_name_int(0, "Sure", sure);
	Dialog_Show(playerid, Banli, DIALOG_STYLE_MSGBOX, "Ban Bilgileri", "Karakter Adý: %s\nIP: %s\nBanlanma Tarihi: %s\nSebep: %s\nBanlayan: %s\nAçýlacaðý Tarih: %s", "Kapat", "", ad, ip, banlanmatarihi, sebep, banlayan, (sure < 1) ? ("Yok") : (convertDatex(sure)));
	return 1;
}
forward UnBan(playerid, ad[]);
public UnBan(playerid, ad[])
{
	new rows;
	cache_get_row_count(rows);
	if (!rows) return HataMesajGonder(playerid, "Bu karakter adý veya IP banlý deðil.");
	RemoveBan(ad, ad);
	if (strfind(ad, "_", true) != -1)
	{
	    MesajGonder(playerid, "%s adlý oyuncunun baný açýlmýþtýr.", ad);
	    AdminMessage(COLOR_LIGHTRED, "ADM: %s baný %s adlý yetkili tarafýndan açýldý.", ad, PlayerData[playerid][pAdminName]);
	}
	else
	{
	     MesajGonder(playerid, "IP: %s baný açýldý.", ad);
	    AdminMessage(COLOR_LIGHTRED, "ADM: %s baný %s adlý yetkili tarafýndan açýldý.", ad, PlayerData[playerid][pAdminName]);
	}
	return 1;
}
forward OnCBanAccount(playerid, isim[], sebep[50]);
public OnCBanAccount(playerid, isim[], sebep[50])
{
	new rows;
	cache_get_row_count(rows);
	if (rows)
	{
	    new admin, ip[30], serial[75];
	    cache_get_value_name_int(0, "AdminLevel", admin);
		cache_get_value_name(0, "LastIP", ip, 30);
		cache_get_value_name(0, "hddserial", serial, 75);
		if (admin > PlayerData[playerid][pAdmin]) return HataMesajGonder(playerid, "Bu oyuncu sizden yüksek yetkiye sahiptir.");
		AddBan(ip, isim, serial, PlayerData[playerid][pAdminName], 0, sebep);
		MesajGonder(playerid, "%s (IP: %s, Serial: %s) adlý oyuncuyu %s sebebiyle client banladýnýz.", isim, ip, serial, sebep);
		AdminMessage(COLOR_LIGHTRED, "ADM: %s adlý yetkili %s (IP: %s) adlý oyuncuyu offline olarak %s sebebiyle client yasakladý.", PlayerData[playerid][pAdminName], isim, ip, sebep);
	}
	return 1;
}
forward OnPanelBanAccount(uygulayan[], isim[], sure, sebep[50]);
public OnPanelBanAccount(uygulayan[], isim[], sure, sebep[50])
{
	new rows;
	cache_get_row_count(rows);
	if (rows)
	{
	    new ip[30], sqlid;
	    cache_get_value_name_int(0, "ID", sqlid);
	    cache_get_value_name(0, "LastIP", ip, 30);
	    AddBan(ip, isim, "", uygulayan, (sure < 1) ? (0) : (gettime()+sure*86400), sebep);
	    foreach (new i:Player) if (PlayerData[i][pAyarlar][3] == 0)
    	{
    		if (sure == 0) SendClientMessageEx(i, COLOR_LIGHTRED, "(%s) - (( %s adlý oyuncu %s tarafýndan %s sebebiyle panelden sýnýrsýz yasaklandý. ))", ReturnDate(), isim,  uygulayan, sebep);
    		else SendClientMessageEx(i, COLOR_LIGHTRED, "(%s) - (( %s adlý oyuncu %s tarafýndan %s sebebiyle panelden %d gün yasaklandý. ))", ReturnDate(), isim,  uygulayan, sebep, sure);
    	}
    	new query[300];
	    format(query, sizeof(query), "INSERT INTO `oocsicil` (`ID`, `Tarih`, `Sebep`, `Uygulayan`, `Tur`) VALUES('%d', '%s', '%s', '%s', '2')",  sqlid, ReturnDate(), sebep, uygulayan);
    	mysql_query(g_SQL, query, false);
	}
	return 1;
}
forward OnBanAccount(playerid, isim[], sure, sebep[50]);
public OnBanAccount(playerid, isim[], sure, sebep[50])
{
	new rows;
	cache_get_row_count(rows);
	if (rows)
	{
	    new admin, ip[30], sqlid;
	    cache_get_value_name_int(0, "ID", sqlid);
	    cache_get_value_name_int(0, "AdminLevel", admin);
		cache_get_value_name(0, "LastIP", ip, 30);
	    if (admin > PlayerData[playerid][pAdmin]) return HataMesajGonder(playerid, "Bu oyuncu sizden yüksek yetkiye sahiptir.");
	    AddBan(ip, isim, "", PlayerData[playerid][pAdminName], (sure < 1) ? (0) : (gettime()+sure*86400), sebep);
	    new suree[12];
	    if (sure == 0) suree = "Sýnýrsýz";
	    else format(suree, sizeof(suree), "%d gün", sure);
	    MesajGonder(playerid, "%s (IP: %s) adlý oyuncuyu %s sebebiyle %s banladýnýz.", isim, ip, sebep, suree);

	    AdminMessage(COLOR_LIGHTRED, "ADM: %s adlý yetkili %s (IP: %s) adlý oyuncuyu offline olarak %s sebebiyle %s yasakladý.", PlayerData[playerid][pAdminName], isim, ip, sebep, suree);
	    new query[300];
	    format(query, sizeof(query), "INSERT INTO `oocsicil` (`ID`, `Tarih`, `Sebep`, `Uygulayan`, `Tur`) VALUES('%d', '%s', '%s', '%s', '2')",  sqlid, ReturnDate(), sebep, PlayerData[playerid][pAdminName]);
    	mysql_query(g_SQL, query, false);
	}
	else HataMesajGonder(playerid, "Karakter adý bulunamadý.");
	return 1;
}
forward NameChanges(playerid, targetid);
public NameChanges(playerid, targetid)
{
	new rows;
	cache_get_row_count(rows);
	if (!rows) return HataMesajGonder(playerid, "Bu oyuncuya ait isim deðiþikliði bulunamadý.");
	new eskiad[24], yeniad[24], tarih[25];
	for (new i; i<rows; i++)
	{
	    cache_get_value_name(i, "EskiAd", eskiad, 24);
	    cache_get_value_name(i, "YeniAd", yeniad, 24);
	    cache_get_value_name(i, "Tarih", tarih, 25);
	    SendClientMessageEx(playerid, 0xFFFF00AA, "(%s) Eski Ad: %s - Yeni Ad: %s", tarih, eskiad, yeniad);
	}
	return 1;
}
forward BanKontrol(playerid, pip[]);
public BanKontrol(playerid, pip[])
{
	new rows;
	cache_get_row_count(rows);
	if (rows)
	{
	    new ad[24], bantarih[30], sebep[50], sure, banlayan[24], hddserial[75];
	    cache_get_value_name(0, "Ad", ad, 24);
	    cache_get_value_name(0, "BanlanmaTarihi", bantarih, 30);
	    cache_get_value_name(0, "Sebep", sebep, 50);
	    cache_get_value_name(0, "Banlayan", banlayan, 24);
	    cache_get_value_name(0, "hddserial", hddserial, 75);
	    cache_get_value_name_int(0, "Sure", sure);
	    if (sure != 0)
	    {
	        if (gettime() > sure)
	        {
	            RemoveBan(Player_GetName(playerid), pip);
	            return 1;
	        }
	        else
	        {
	            Dialog_Show(playerid, Banli, DIALOG_STYLE_MSGBOX, "Yasaklýsýnýz!", "Hesabýnýz bu sunucudan geçici olarak yasaklandý.\n\nHesap: %s\nSebep: %s\nBanlanma Tarihi: %s\nBanlayan Admin: %s\nAçýlacaðý Tarih: %s\n\nF8 tuþuna basýn ve bir ekran görüntüsü alýn, bu ekran görüntüsü ile forumumuzdan yasaklanmanýza itiraz edebilirsiniz.", "Kapat", "", ad, sebep, bantarih, banlayan, convertDatex(sure));
	            Kick(playerid);
	        }
	    }
	    if (strlen(hddserial) >= 5)
	    {
	        Dialog_Show(playerid, Banli, DIALOG_STYLE_MSGBOX, "Yasaklýsýnýz!", "Hesabýnýz client olarak kalýcý yasaklandý.\n\nHesap: %s\nSerial: %s\nSebep: %s\nBanlanma Tarihi: %s\nBanlayan Admin: %s\nAçýlacaðý Tarih: Yok\n\nF8 tuþuna basýn ve bir ekran görüntüsü alýn, bu ekran görüntüsü ile forumumuzdan yasaklanmanýza itiraz edebilirsiniz.", "Kapat", "", ad, hddserial, sebep, bantarih, banlayan);
	        Kick(playerid);
	    }
	    else if (!strcmp(ad, "yok", true) || !ad[0])
	    {
	      	Dialog_Show(playerid, Banli, DIALOG_STYLE_MSGBOX, "Yasaklýsýnýz!", "Bu IP sunucudan kalýcý olarak yasaklý.\n\nIP: %s\nBanlanma Tarihi: %s\nBanlayan Admin: %s\nSebep: %s\n\nBu ekranýn fotoðrafýný çekerek forumdan hatalý yasaklanma açabilirsin.", "Kapat", "", pip, bantarih, banlayan, sebep);
       		Kick(playerid);
       	}
        else
        {
        	Dialog_Show(playerid, Banli, DIALOG_STYLE_MSGBOX, "Yasaklýsýnýz!", "Bu sunucudan kalýcý olarak yasaklandýnýz.\n\nHesap: %s\nBanlanma Tarihi: %s\nBanlayan Admin: %s\nSebep: %s\n\nBu ekranýn fotoðrafýný çekerek forumdan hatalý yasaklanma açabilirsin.", "Kapat", "", ad, bantarih, banlayan, sebep);
         	Kick(playerid);
        }
	}
	return 1;
}
forward OnJailAccount(playerid, isim[], sure, sebep[50]);
public OnJailAccount(playerid, isim[], sure, sebep[50])
{
	new rows;
	cache_get_row_count(rows);
	if (rows)
	{
	    new ck, sqlid;
	    cache_get_value_name_int(0, "ID", sqlid);
	    cache_get_value_name_int(0, "CK", ck);
	    if (ck == 1) return HataMesajGonder(playerid, "Bu karakter CK edilmiþ.");
	    new query[800];
	    format(query, sizeof(query), "UPDATE `oyuncular` SET `HapisSure` = '%d', `HapisSebep` = '%s', `HapiseAtan` = '%s'", sure*60, sebep, PlayerData[playerid][pAdminName]);
	    for (new i; i<13; i++)
	    {
	        format(query, sizeof(query), "%s, `Silah%d` = '0', `Mermi%d` = '0'", query, i+1, i+1);
	    }
	    format(query, sizeof(query), "%s WHERE `Isim` = '%s'", query, isim);
	    mysql_query(g_SQL, query, false);
	    format(query, sizeof(query), "INSERT INTO `oocsicil` (`ID`, `Tarih`, `Sebep`, `Uygulayan`, `Tur`) VALUES('%d', '%s', '%s', '%s', '3')",  sqlid, ReturnDate(), sebep, PlayerData[playerid][pAdminName]);
   	 	mysql_tquery(g_SQL, query);
	    MesajGonder(playerid, "%s adlý kiþiyi %s sebebiyle %d dakika cezalandýrdýnýz.", isim, sebep, sure);
	    Log_Write("logs/jail_log.txt", "[%s] %s adli yetkili %s adli oyuncuyu %s sebebiyle %d dakika offline olarak hapise atti.", ReturnDate(), PlayerData[playerid][pAdminName], isim, sebep, sure);
	}
	else HataMesajGonder(playerid, "Böyle bir oyuncu yok.");
	return 1;
}
forward OnLoginDate(extraid, username[]);
public OnLoginDate(extraid, username[])
{
    if (!IsPlayerConnected(extraid))
        return 0;

    new rows, date[20], lastip[15];

    cache_get_row_count(rows);

    if (rows) {
        cache_get_value_name(0, "SonGiris", date, 20);
        cache_get_value_name(0, "LastIP", lastip, 15);

        MesajGonder(extraid, "%s adlý kiþinin son giriþ tarihi: %s (IP: %s).", username, date, lastip);
    }
    else {
        HataMesajGonder(extraid, "Veritabanýnda böyle bir karakter yok.");
    }
    return 1;
}
forward OzelModelSil(playerid, sqlid, skinid);
public OzelModelSil(playerid, sqlid, skinid)
{
	new rows;
	cache_get_row_count(rows);
	if (!rows) return HataMesajGonder(playerid, "Bu oyuncunun böyle bir özel modeli yok.");
	new query[150];
	format(query, sizeof(query), "DELETE FROM `ozelmodel` WHERE `sqlid` = '%d' AND `skinid` = '%d'", sqlid, skinid);
	mysql_query(g_SQL, query, false);
	format(query, sizeof(query), "UPDATE `oyuncular` SET `Skin` = '101' WHERE `Skin` = '%d'", skinid);
	mysql_query(g_SQL, query, false);
	foreach (new i:Player) if (PlayerData[i][pSkin] == skinid)
	{
	    PlayerData[i][pSkin] = (PlayerData[i][pCinsiyet] == 1) ? (101) : (211);
	    SetPlayerSkin(i, PlayerData[i][pSkin]);
	    BilgiMesajGonder(i, "Kullandýðýnýz skin yetkili tarafýndan silindiði için skininiz deðiþtirildi.");
	}
	MesajGonder(playerid, "%s (SQL ID: %d) adlý kiþinin %d ID'li özel modelini sildiniz.", SQLName(sqlid), sqlid, skinid);
	Log_Write("logs/admin.log", "[%s] %s adli admin %d sql id'li oyuncunun %d id'li ozel modelini sildi.",ReturnDate(),PlayerData[playerid][pAdmin], sqlid, skinid);
	return 1;
}
forward OzelModelVer(playerid, sqlid, skinid);
public OzelModelVer(playerid, sqlid, skinid)
{
	new rows;
	cache_get_row_count(rows);
	if (rows) return HataMesajGonder(playerid, "Bu oyuncunun zaten bu modeli var.");
	new query[150];
	format(query, sizeof(query), "INSERT INTO `ozelmodel` (`sqlid`, `skinid`) VALUES ('%d', '%d')", sqlid, skinid);
	mysql_query(g_SQL, query, false);
	MesajGonder(playerid, "%s (SQL ID: %d) kiþisine %d ID'li özel modeli verdiniz.", SQLName(sqlid), sqlid, skinid);
	Log_Write("logs/admin.log", "[%s] %s adli admin %d sql id'li oyuncuya %d id'li ozel modeli verdi.",ReturnDate(),PlayerData[playerid][pAdmin], sqlid, skinid);
	return 1;
}
forward OOCMarket(playerid);
public OOCMarket(playerid)
{
	new rows;
	cache_get_row_count(rows);
 	new str[1500], string[124];
  	strcat(str, "Ürün\tFiyat\n");
   	strcat(str, "{AFAFAF}Bakiye Gönder\n");
    if (PlayerData[playerid][pAdmin] >= 4) strcat(str, "{AFAFAF}Düzenle\n");
    if (rows)
    {
        new urunadi[40], fiyat;
        for (new i; i<rows; i++)
        {
            cache_get_value_name(i, "urunadi", urunadi, 40);
            cache_get_value_name_int(i, "fiyat", fiyat);

            format(string, sizeof(string), "{FFFFFF}%s\t{FFFFFF}%d TL\n", urunadi, fiyat);
            strcat(str, string);
		}
	}
	format(string, sizeof(string), "Market (Bakiyeniz: %d)", PlayerData[playerid][pBakiye]);
	Dialog_Show(playerid, oocm, DIALOG_STYLE_TABLIST_HEADERS, string, str, "Satýn Al", "Kapat");
	return 1;
}
forward TamirExit(playerid, vehicleid);
public TamirExit(playerid, vehicleid)
{
	new id = GetPVarInt(playerid, "pnsID"),
	    Float:zacisi;

	SetPlayerVirtualWorld(playerid, Tamirhane[id][Tamirhane_World]);
	SetPlayerInterior(playerid, Tamirhane[id][Tamirhane_Interior]);

	zacisi = Tamirhane[id][Tamirhane_Pos][2] + 2.5;

	SetVehiclePos(vehicleid, Tamirhane[id][Tamirhane_Pos][0], Tamirhane[id][Tamirhane_Pos][1], zacisi);
	SetVehicleZAngle(vehicleid, Tamirhane[id][Tamirhane_Pos][3]);

    SetVehicleVirtualWorld(vehicleid, Tamirhane[id][Tamirhane_World]);
    LinkVehicleToInteriorEx(vehicleid, Tamirhane[id][Tamirhane_Interior]);

	foreach(new i: Player)
	{
		if (i != playerid && IsPlayerInVehicle(i, vehicleid) && GetPlayerVehicleSeat(i) != 128 && GetPlayerVehicleSeat(i) != 0)
		{
			TogglePlayerControllable(i, true);

			SetPlayerPos(i, Tamirhane[id][Tamirhane_Pos][0], Tamirhane[id][Tamirhane_Pos][1], zacisi);

			SetPlayerInterior(i, Tamirhane[id][Tamirhane_Interior]);
	        SetPlayerVirtualWorld(i, Tamirhane[id][Tamirhane_World]);

			PutPlayerInVehicle(i, vehicleid, GetPlayerVehicleSeat(i));
	    }
	}

	SetPVarInt(playerid, "pnsID", -1);

	TogglePlayerControllable(playerid, true);

	new idex = Car_GetID(vehicleid);
	if (idex != -1 && AracInfo[idex][aracZirhVarMi] == 1)
	    AracInfo[idex][aracZirh] = 50;

    ChangeVehicleColor(vehicleid, AracInfo[idex][aracRenkler][0],  AracInfo[idex][aracRenkler][1]);

    SetVehicleHealth(vehicleid, 999);
    RepairVehicle(vehicleid);

	Tamirhane[id][Tamirhane_Kullaniliyor] = 0;
    TogglePlayerControllable(playerid, 1);
	BilgiMesajGonder(playerid, "Tamir iþlemi tamamlandý. (Ücret: $%d)", GetServerBilgi("TamirciUcret"));
	return 1;
}

forward AracRespawn(vehicleid);
public AracRespawn(vehicleid)
{
	if (OyundaDegil(GetVehicleDriver(vehicleid))) return 1;
	SetVehicleToRespawn(vehicleid);

	AracYuk[vehicleid] = 0;
	AracCP[vehicleid] = -1;

	LoadedTrash[vehicleid] = 0;

	TirYuk[vehicleid] = 0;
	return 1;
}

forward RepairCar(playerid, vehicleid);
public RepairCar(playerid, vehicleid)
{
    RepairVehicle(vehicleid);
    GameTextForPlayer(playerid, " ", 1, 3);
	SetPVarInt(playerid, "TamirEdiyor", 0);
    SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s aracý tamir etti.", ReturnName(playerid, 0));
    return 1;
}
forward RefillUpdate(playerid, vehicleid);
public RefillUpdate(playerid, vehicleid)
{
    if (GetPVarInt(playerid, "BenzinDolduruyor") == 0 || GetNearestVehicle(playerid) != AracInfo[vehicleid][aracVehicle])
        return 0;

    AracInfo[vehicleid][aracBenzin] = (AracInfo[vehicleid][aracBenzin] + 30.0 >= 100.0) ? (100.0) : (AracInfo[vehicleid][aracBenzin] + 30.0);

    SetPVarInt(playerid, "BenzinDolduruyor", 0);
    TogglePlayerControllable(playerid, true);
    MesajGonder(playerid, "Yakýt dolduruldu. (30L)");
    return 1;
}
forward Refuel(playerid, aracid);
public Refuel(playerid, aracid)
{
    new price = floatround(0.5 * GetServerBilgi("BenzinFiyat"));
    if (PlayerData[playerid][pCash] < price)
    {
        HataMesajGonder(playerid, "Yeterli paranýz yok!");
        Fuel_ResetPlayer(playerid);
        return 1;
    }
    FuelBought[playerid] += 0.5;
    AracInfo[aracid][aracBenzin] += 0.5;
    new string[64];
	format(string, sizeof(string), "~b~~h~Dolduruluyor...~n~~n~~w~Fiyat: ~g~~h~$%d ~y~~h~(%.2f L)", floatround(FuelBought[playerid] * LITRE_PRICE), FuelBought[playerid]);
	PlayerTextDrawSetString(playerid, FuelText[playerid], string);
	ParaVer(playerid, -price);

	if (AracInfo[aracid][aracBenzin] >= 100.0)
	{
		AracInfo[aracid][aracBenzin] = 100.0;
		Fuel_ResetPlayer(playerid);
	}
	return 1;
}
forward IsaretSil(playerid);
public IsaretSil(playerid)
{
	DisablePlayerCheckpoint(playerid);
	return 1;
}
forward RadarGuncelle (vehid);
public RadarGuncelle (vehid)
{
    	new id = GetVehicleInfrontID (vehid);
        if (id < 0 || GetVehicleVirtualWorld(vehid) != GetVehicleVirtualWorld(id))
        {
 				TextDrawSetString(carMDC[vehid][2], "PLAKA: ~y~N/A");
 				TextDrawSetString(carMDC[vehid][3], "MODEL: ~y~N/A");
     			TextDrawSetString(carMDC[vehid][4], "HIZ: ~y~N/A");
        }
        else
        {
				new str[256];
                new ids = Car_GetID(id);
                format(str, sizeof(str), "PLAKA: ~y~%s", AracInfo[ids][aracPlaka]);
	            TextDrawSetString(carMDC[vehid][2], str);
	            format(str, sizeof(str), "MODEL: ~y~%s", ReturnVehicleModelName(GetVehicleModel(id)));
	            TextDrawSetString(carMDC[vehid][3], str);
				format(str, sizeof(str), "HIZ: ~y~%d KMH", GetPlayerSpeed(id));
	            TextDrawSetString(carMDC[vehid][4], str);
	            foreach (new i: Player)
		        {
		                if (IsPlayerInVehicle (i, vehid))
		            	{
							if (GetPlayerSpeed(id) > vehRadarLimit[vehid])
							    BilgiMesajGonder(i, "DÝKKAT! %s plakalý %s model araç hýz limitini aþtý! (Aracýn hýzý: %d KMH)", AracInfo[ids][aracPlaka], ReturnVehicleModelName(GetVehicleModel(id)), GetPlayerSpeed(id));
		                }
		        }
        }
        foreach (new i: Player)
        {
                if (IsPlayerInVehicle (i, vehid) && GetFactionType(i) == BIRLIK_LSPD)
            	{
                    for (new ia; ia < 5; ia++) TextDrawShowForPlayer(i, carMDC[vehid][ia]);
                }
        }
        return 1;
}
forward OnDealerCarCreated(bizid, slotid);
public OnDealerCarCreated(bizid, slotid)
{
	DealershipCars[bizid][slotid][vehID] = cache_insert_id();
	return 1;
}
stock GetVehicleModelByName(const name[])
{
	if (IsNumeric(name) && (strval(name) >= 400 && strval(name) <= 611))
	    return strval(name);

	for (new i = 0; i < sizeof(g_arrVehicleNames); i ++)
	{
	    if (strfind(g_arrVehicleNames[i], name, true) != -1)
	    {
	        return i + 400;
		}
	}
	return 0;
}
forward Business_LoadCars(bizid);
public Business_LoadCars(bizid)
{
	new rows = cache_num_rows();

	if (rows)
	{
	    new lcID;
		for (new i = 0; i != rows; i ++)
		{
			cache_get_value_name_int(i, "vehID", lcID);

			DealershipCars[bizid][lcID][vehID] = lcID;

			cache_get_value_name_int(i, "vehModel", DealershipCars[bizid][lcID][vehModel]);
			cache_get_value_name_int(i, "vehPrice", DealershipCars[bizid][lcID][vehPrice]);
		}
	}
	return 1;
}
forward BalikTutma(playerid);
public BalikTutma(playerid)
{
    new balikorani = BALIK_TUTMA_ORANI;
	if(PlayerData[playerid][pBalikOrani] > gettime()) balikorani += 15;
	switch(PlayerData[playerid][pVip])
	{
	    case 1: balikorani += 10;
	    case 2: balikorani += 15;
	    case 3: balikorani += 20;
	}
	if(random(100) < balikorani)
	{
	    new slot = -1;
	    for(new i; i<10; i++)
		{
	    	if(PlayerData[playerid][pBalikID][i] == -1)
	    	{
	        	slot = i;
	        	break;
	    	}
		}
		if(slot == -1)
		{
		    BalikTimer[playerid] = -1;
		    RemovePlayerAttachedObject(playerid, GetPVarInt(playerid, "OltaSlot"));
			SetPVarInt(playerid, "OltaSlot", -1);
			ClearAnimations(playerid);
			TogglePlayerControllable(playerid, true);
			HataMesajGonder(playerid,"Daha fazla balýk tutamazsýn.");
			return 1;
		}
		new id = RandomEx(0, sizeof(BalikTurleri)-1), gram = RandomEx(BalikTurleri[id][MinAgirlik], BalikTurleri[id][MaxAgirlik]);
		if(BoyleBalikVar(playerid,id))
		{
  		 	BalikTimer[playerid] = -1;
	     	RemovePlayerAttachedObject(playerid, GetPVarInt(playerid, "OltaSlot"));
		 	SetPVarInt(playerid, "OltaSlot", -1);
	     	ClearAnimations(playerid);
	     	TogglePlayerControllable(playerid, true);
	     	BilgiMesajGonder(playerid,"Balýk yakalayamadýnýz.");
	     	return 1;
		}
		new fiyat = floatround(gram * BalikTurleri[id][GramFiyat]);
		PlayerData[playerid][pBalikID][slot] = id;
		PlayerData[playerid][pBalikGram][slot] = gram;
		MesajGonder(playerid,"Bir {808080}%s {FFFFFF}balýðý tuttunuz. {808080}Gram: %d, Fiyat: %s. {FFFFFF}NPC giderek satabilirsin ve 10 Parça aldýn.",BalikTurleri[id][TurAdi],gram,FormatNumber(fiyat));
		PlayerData[playerid][pMateryal] += 10;
	 	BalikTimer[playerid] = -1;
   		RemovePlayerAttachedObject(playerid, GetPVarInt(playerid, "OltaSlot"));
		SetPVarInt(playerid, "OltaSlot", -1);
		ClearAnimations(playerid);
		TogglePlayerControllable(playerid, true);
	}
	else
	{
	     BalikTimer[playerid] = -1;
	     RemovePlayerAttachedObject(playerid, GetPVarInt(playerid, "OltaSlot"));
		 SetPVarInt(playerid, "OltaSlot", -1);
	     ClearAnimations(playerid);
	     TogglePlayerControllable(playerid, true);
	     BilgiMesajGonder(playerid,"Balýk yakalayamadýnýz.");
	}
	return 1;
}
forward CloseGate(gateid, linkid, Float:fX, Float:fY, Float:fZ, Float:speed, Float:fRotX, Float:fRotY, Float:fRotZ);
public CloseGate(gateid, linkid, Float:fX, Float:fY, Float:fZ, Float:speed, Float:fRotX, Float:fRotY, Float:fRotZ)
{
	new id = -1;

	if (GateData[gateid][gateExists] && GateData[gateid][gateOpened])
 	{
	 	MoveDynamicObject(GateData[gateid][gateObject], fX, fY, fZ, speed, fRotX, fRotY, fRotZ);

	 	if ((id = GetGateByID(linkid)) != -1)
            MoveDynamicObject(GateData[id][gateObject], GateData[id][gatePos][0], GateData[id][gatePos][1], GateData[id][gatePos][2], speed, GateData[id][gatePos][3], GateData[id][gatePos][4], GateData[id][gatePos][5]);

		GateData[id][gateOpened] = 0;
		return 1;
	}
	return 0;
}
forward OnGarageCreated(id);
public OnGarageCreated(id)
{
    if (id == -1 || !GarageData[id][gExists])
	    return 0;

	GarageData[id][gID] = cache_insert_id();
	Garaj_Kaydet(id);
	return 1;
}
forward OnGateCreated(gateid);
public OnGateCreated(gateid)
{
	if (gateid == -1 || !GateData[gateid][gateExists])
	    return 0;

	GateData[gateid][gateID] = cache_insert_id();
	Gate_Save(gateid);

	return 1;
}
forward EhliyetUpdate();
public EhliyetUpdate()
{
	foreach (new i : Player)
	{
 		if(PlayerData[i][pEhliyetSinavinda] != 0 && GetPlayerState(i) == PLAYER_STATE_DRIVER)
 		{
 			if(GetPlayerSpeed(GetPlayerVehicleID(i)) > 90)
 			{
 				PlayerData[i][pEhliyetUyari]++;

 				if(PlayerData[i][pEhliyetUyari] == 3)
 				{
					DisablePlayerCheckpoint(i);
				    EhliyetAracCP[GetPlayerVehicleID(i)] = 0;
				    AracCP[GetPlayerVehicleID(i)] = -1;

				    Arac_Spawn(Car_GetID(GetPlayerVehicleID(i)));

				    SetPlayerPos(i, EhliyetX, EhliyetY, EhliyetZ);
				    PlayerData[i][pEhliyetSinavinda] = 0;
				    PlayerData[i][pEhliyetUyari] = 0;
 					HataMesajGonder(i, "Hýz limitini üçüncü kez aþtýðýnýz için sýnav iptal edildi!");
 				}else{
 					HataMesajGonder(i, "Hýz limitini(90) aþtýnýz! %d kez daha aþarsanýz sýnav iptal edilecek.", 3 - PlayerData[i][pEhliyetUyari]);
 				}
 			}
 		}
	}
	return 1;
}

forward SecondUpdate();
public SecondUpdate()
{
	new string[256], saat, dakika;
	gettime(saat, dakika);
	SetWorldTime(saat);
	foreach (new i:Player)
	{
	    if (GetPVarInt(i, "Logged") == 0) continue;
	    SetPlayerTime(i, saat, dakika);

	    if (PlayerData[i][pHUD] == false)
	    {
	        for (new d = 0; d < 5; d++)
	            PlayerTextDrawHide(i, AracHUD[i][d]);
	    }

	    if (PlayerData[i][pHUD] == true)
	    {
	        format(string, sizeof string, "%s[ID:%d]", ReturnName(i, 0), i);  // Ýsim ÝD
		    PlayerTextDrawSetString(i, NitroHUD[i][1], string);

 			format(string, sizeof string, "%s", getDate());                   //Tarih
			PlayerTextDrawSetString(i, NitroHUD[i][2], string);

            format(string, sizeof string, "%s", getTime());                   //Saat
			PlayerTextDrawSetString(i, NitroHUD[i][3], string);

	        format(string, sizeof string, "%d", ReturnHealth(i));
		    PlayerTextDrawSetString(i, NitroHUD[i][4], string);

		    format(string, sizeof string, "%d", ReturnArmour(i));
		    PlayerTextDrawSetString(i, NitroHUD[i][5], string);

		    format(string, sizeof(string), "%d", pFPS[i]);
		    PlayerTextDrawSetString(i, NitroHUD[i][6], string);

		    format(string, sizeof(string), "%d", GetPlayerPing(i));
		    PlayerTextDrawSetString(i, NitroHUD[i][7], string);

		    format(string, sizeof string, "%d/60", floatround(PlayerData[i][pMaasSure]/60));
		    PlayerTextDrawSetString(i, NitroHUD[i][8], string);

		    format(string, sizeof string, "%d", ToplamOnlineOyuncu());
		    PlayerTextDrawSetString(i, NitroHUD[i][9], string);
	    }
	    if (PlayerData[i][pTarife] != -1 && PlayerData[i][pTarifeSure] < gettime())
	    {
	        PlayerData[i][pTarife] = -1;
	        PlayerData[i][pTarifeKalan][0] = 0;
	        PlayerData[i][pTarifeKalan][1] = 0;
	        PlayerData[i][pTarifeKalan][2] = 0;
	        PlayerData[i][pTarifeSure] = 0;
	        MesajGonder(i, "Tarifenizin abonelik süresi doldu, (/telefon | Tarifem | Tarife Yükle) yenileyebilirsiniz.");
	    }
	 	if (PlayerData[i][pSoklandi] > 0)
		{
            PlayerData[i][pSoklandi]--;

			if (GetPlayerAnimationIndex(i) != 388)
            	ApplyAnimation(i, "CRACK", "crckdeth4", 4.0, 0, 0, 0, 1, 0, 1);

            if (!PlayerData[i][pSoklandi])
            {
                if (PlayerData[i][pKelepce] == 0) TogglePlayerControllable(i, 1);
                ClearAnimations(i);
			}
		}
		if (PlayerData[i][pSilahAlmaSayisi] >= 2 && PlayerData[i][pSilahAlma] < gettime())
		{
		    PlayerData[i][pSilahAlmaSayisi] = 0;
		    PlayerData[i][pSilahAlma] = 0;
		}
		if (PlayerData[i][pHapisSure] > 0 && PlayerData[i][pCK] == 0)
		{
		    new str[70];
		    static
		        hours,
		        minutes,
		        seconds;

		    PlayerData[i][pHapisSure]--;
		    GetElapsedTime(PlayerData[i][pHapisSure], hours, minutes, seconds);
		    format(str, sizeof(str), "~r~Kalan Sure:~w~ %02d:%02d:%02d", hours, minutes, seconds);
			PlayerTextDrawSetString(i, HapisTD[i], str);
			if (!PlayerData[i][pHapisSure])
		    {
		        PlayerData[i][pHapis] = 0;

		        SetPlayerPos(i, 1544.2367,-1675.8328,13.5580);
		        SetPlayerInterior(i, 0);
		        SetPlayerVirtualWorld(i, 0);
		        SetCameraBehindPlayer(i);
		        ObjelerYukleniyor(i);
				//MesajGonder(i, "Hapis süreniz doldu.");
		        PlayerTextDrawHide(i, HapisTD[i]);
			}
		}
		if (PlayerData[i][pEXPBoost] < gettime() && PlayerData[i][pEXPBoost] != 0)
		{
		    PlayerData[i][pEXPBoost] = 0;
		    BilgiMesajGonder(i, "EXP Boost adlý ürününüz bitti, (/oocmarket) komutunu kullanarak tekrar satýn alabilirsiniz.");
		}
        if(PlayerData[i][pBalikOrani] < gettime() && PlayerData[i][pBalikOrani] != 0)
		{
		    PlayerData[i][pBalikOrani] = 0;
		    BilgiMesajGonder(i, "Balýk oraný arttýrma adlý ürününüz bitti, (/oocmarket) komutunu kullanarak tekrar satýn alabilirsiniz.");
		}
		if (PlayerData[i][pVip] > 0 && PlayerData[i][pVipSure] < gettime())
		{
		    PlayerData[i][pVip] = 0;
		    PlayerData[i][pVipSure] = 0;
		    PlayerData[i][pDovusStili] = 4;
		    SetPlayerFightingStyle(i, FIGHT_STYLE_NORMAL);
		    Oyuncu_Kaydet(i);
		    Dialog_Show(i, VIPBitti, DIALOG_STYLE_MSGBOX, "VIP Paketiniz Bitti!", "{FFFFFF}VIP Paketinizin süresi doldu, (/oocmarket) komutunu kullanarak tekrar satýn alabilirsiniz.\n\n{FFFFFF}Desteðiniz için ekip adýna teþekkür ederiz :)", "Tamam", "");
		}
		if (PlayerData[i][pMaasSure] < 3600 && PlayerData[i][pHapisSure] < 2)
		{
		    PlayerData[i][pMaasSure]++;
		    if (PlayerData[i][pMaasSure] >= 3600)
		    {
		        PlayerData[i][pMaasSure] = 0;
		        if (GetServerBilgi("2xpayday") == 1) PlayerData[i][pEXP] += 2;
		        else PlayerData[i][pEXP]++;
		        if (PlayerData[i][pEXPBoost] > gettime()) PlayerData[i][pEXP]++;
		        if (GetServerBilgi("2xpayday") == 1) PlayerData[i][pOynamaSaati] += 2;
		        else PlayerData[i][pOynamaSaati]++;
		        switch (PlayerData[i][pVip])
		        {
		            case 1: PlayerData[i][pEXP] += 2;
		            case 2: PlayerData[i][pEXP] += 4;
		            case 3: PlayerData[i][pEXP] += 6;
		        }
		        if (PlayerData[i][pEXP] >= PlayerData[i][pLevel]*5)
				{
				    new kalanexp = 0;
				    if (PlayerData[i][pEXP] > PlayerData[i][pLevel]*5)
				    {
				        kalanexp = PlayerData[i][pEXP] - PlayerData[i][pLevel]*5;
				    }
				    PlayerData[i][pEXP] = kalanexp;
					PlayerData[i][pLevel]++;
					SetPlayerScore(i, PlayerData[i][pLevel]);
					MesajGonder(i, "Seviye atladýnýz!");
					if(PlayerData[i][pLevel] == 5){
						format(PlayerData[i][pBasari5Tarih],25,ReturnDate());
						PlayerData[i][pBasari5] = 1;
					}
					if(PlayerData[i][pLevel] == 10){
						format(PlayerData[i][pBasari10Tarih],25,ReturnDate());
						PlayerData[i][pBasari10] = 1;
					}
				}
				if (PlayerData[i][pHediye] < 1)
				{
				    PlayerData[i][pHediyeSaat]++;
				    if (PlayerData[i][pHediyeSaat] == 5)
					{
					    PlayerData[i][pHediye] = 1;
					    PlayerData[i][pHediyeSaat] = 0;
					}
				}
				PayDay(i);
				if (GetServerBilgi("2xpayday") == 1)
				{
				    if (PlayerData[i][pHediye] < 1)
					{
					    PlayerData[i][pHediyeSaat]++;
					    if (PlayerData[i][pHediyeSaat] == 5)
						{
						    PlayerData[i][pHediye] = 1;
						    PlayerData[i][pHediyeSaat] = 0;
						}
					}
				    PayDay(i);
				}
		    }
		}
		if (PlayerData[i][pYereYatirildi] > 0)
		{
		   PlayerData[i][pYereYatirildi]--;

			if (GetPlayerAnimationIndex(i) != 388)
            	ApplyAnimation(i, "CRACK", "crckdeth4", 4.0, 0, 0, 0, 1, 0, 1);

            if (!PlayerData[i][pYereYatirildi])
            {
                if (PlayerData[i][pKelepce] == 0) TogglePlayerControllable(i, 1);
                ClearAnimations(i);
			}
		}
		if (PlayerData[i][pDestek] > 0)
		{
		    PlayerData[i][pDestek]--;
		    if (PlayerData[i][pDestek] == 0)
		    {
		        DestekKapat(i, 1);
		    }
		}
		if (PlayerData[i][pBagimlilik] > 0 && PlayerData[i][pBagimlilikSayac][1] == 0)
		{
		    PlayerData[i][pBagimlilikSayac][0]++;
		    if (PlayerData[i][pBagimlilikSayac][0] >= 1200)
		    {
		        PlayerData[i][pBagimlilikSayac][1] = 1;
		        PlayerData[i][pBagimlilikSayac][0] = 0;
		        SetPlayerHealth(i, ReturnHealth(i) - 5);
		        SetPlayerDrunkLevel(i, 4999);
		        SetPlayerWeather(i, 234);
		        EffectTimer[i] = SetTimerEx("RemoveEffects", (2 * 7) * 1000, false, "i", i);
		        BilgiMesajGonder(i, "Kendinizi halsiz hissediyorsunuz, uyuþturucu kullanmanýz gerekiyor.");
		    }
		}
		if (PlayerData[i][pBaygin] == 1)
		{
  			if (GetPVarInt(i, "AracaBindi") == 0 && GetPVarInt(i, "Iyilestiriliyor") == 0) PlayerData[i][pBayginSure]++;
			new str[100];
            new playerid;
			format(str, 24, "YARALI (/hasarlar %d)", i);
      		SetPlayerChatBubble(i, str, COLOR_PINK, 10.0, 1500);

        	format(str, sizeof(str), "~y~Yaralisin: ~r~%d", 180 - PlayerData[i][pBayginSure]);
			GameTextForPlayer(i, str, 100, 1);

			if (GetPlayerAnimationIndex(i) != 1701 && GetPVarInt(i, "AracaBindi") == 0 && GetPVarInt(i, "CPsineGelindi") != 1 && PlayerData[i][pDragged] == 0)
				ApplyAnimation(i, "WUZI", "CS_Dead_Guy", 4.1, 1, 0, 0, 0, 0, 1);

			if (GetPlayerWeapon(i) != 0) SetPlayerArmedWeapon(i, 0);
			if (PlayerData[i][pBayginSure] >= 180)
			{
   				PlayerData[i][pBaygin] = 0;
				PlayerData[i][pBayginSure] = 0;
       			TogglePlayerControllable(i, true);
          		SetCameraBehindPlayer(i);
				ClearAnimations(i);
				StopLoopingAnim(i);
				CanAyarla(i, 10);
				SetWeapons(i);
				PlayerData[i][pTopallama] = true;
				PlayerData[i][pTopallamaSayac] = 0;
				SunucuMesaji(i, "Yaralýdan kalktýnýz, koþma ve zýplama özelliklerini 120 saniye boyunca kullanamayacaksýnýz.");
	    	}

			if (GetPVarInt(i, "CPsineGelindi") == 1 && PlayerData[i][pDragged] == 0)
			    ApplyAnimation(i, "SWAT", "gnstwall_injurd", 4.1, 1, 0, 0, 0, 0, 1);
		}
		if (PlayerData[i][pIyilestiriyor] != -1)
		{
		    new Float:pos[3];
		    GetPlayerPos(PlayerData[i][pIyilestiriyor], pos[0], pos[1], pos[2]);
		    if (!OyundaDegil(PlayerData[i][pIyilestiriyor]) || PlayerData[PlayerData[i][pIyilestiriyor]][pBaygin] != 1 || !IsPlayerInRangeOfPoint(i, 5.0, pos[0], pos[1], pos[2]))
		    {
		        SetPVarInt(PlayerData[i][pIyilestiriyor], "Iyilestiriliyor", 0);
		        PlayerData[i][pIyilestiriyor] = -1;
		        PlayerData[i][pIyilestirmeSure] = 0;
		        ClearAnimations(i);
		        StopLoopingAnim(i);
		        TogglePlayerControllable(i, true);
		    }
		    else
		    {
		        PlayerData[i][pIyilestirmeSure]++;
		        new str[65];
		        format(str, sizeof(str), "~g~~h~%d", 15 - PlayerData[i][pIyilestirmeSure]);
				GameTextForPlayer(i, str, 100, 4);
				if (GetPlayerAnimationIndex(i) != 168) ApplyAnimation(i, "BOMBER", "BOM_Plant_Loop", 4.1, 1, 1, 1, 0, 0, 1);
				if (GetPlayerWeapon(i) != 0) SetPlayerArmedWeapon(i, 0);
				if (PlayerData[i][pIyilestirmeSure] >= 15)
				{
				    PlayerData[PlayerData[i][pIyilestiriyor]][pBaygin] = 0;
				    PlayerData[PlayerData[i][pIyilestiriyor]][pBayginSure] = 0;
				    SetCameraBehindPlayer(PlayerData[i][pIyilestiriyor]);
					ClearAnimations(PlayerData[i][pIyilestiriyor]);
					StopLoopingAnim(PlayerData[i][pIyilestiriyor]);
					SetPlayerHealth(PlayerData[i][pIyilestiriyor], 100);
					SetPVarInt(PlayerData[i][pIyilestiriyor], "Iyilestiriliyor", 0);
					MesajGonder(PlayerData[i][pIyilestiriyor], "%s adli kiþi tarafýndan iyileþtirildin.", ReturnName(i, 0));
					MesajGonder(i, "%s adlý kiþiyi iyileþtirdiniz.", ReturnName(PlayerData[i][pIyilestiriyor], 0));
					PlayerData[i][pIyilestiriyor] = -1;
					PlayerData[i][pIyilestirmeSure] = 0;
					ClearAnimations(i);
					StopLoopingAnim(i);
					TogglePlayerControllable(i, true);
				}
		    }
		}
		if (PlayerData[i][pTopallama] == true)
		{
			PlayerData[i][pTopallamaSayac]++;
   			if (PlayerData[i][pTopallamaSayac] >= 120)
      		{
        		PlayerData[i][pTopallama] = false;
          		PlayerData[i][pTopallamaSayac] = 0;
        	}
		}
		if (PlayerData[i][pAramada] == ARAMA_KONUSUYOR && GetPVarInt(i, "Arayan") == 1)
		{
		    PlayerData[i][pKonusmaSure]++;
		    if (PlayerData[i][pKonusmaSure] >= 59)
		    {
		        PlayerData[i][pKonusmaSure] = 0;
		        PlayerData[i][pTarifeKalan][0]--;
		        if (PlayerData[i][pTarifeKalan][0] == 0)
		        {
		            BilgiMesajGonder(i, "Tarifeniz bitti, (/telefon | Tarifem | Tarife Yükle) satýn alabilirsiniz.");
		            BilgiMesajGonder(PlayerData[i][pCallLine], "Çaðrý zaman aþýmýna uðradý. ");
		            DeletePVar(i, "Arayan");
		            DeletePVar(PlayerData[i][pCallLine], "Arayan");
		            PlayerData[i][pAramada] = 0;
		            PlayerData[PlayerData[i][pCallLine]][pAramada] = 0;
		            PlayerData[PlayerData[i][pCallLine]][pCallLine] = -1;
		            PlayerData[i][pCallLine] = -1;
				}
		    }
		}
		static id = -1;
		if ((id = Boombox_Nearest(i)) != INVALID_PLAYER_ID && PlayerData[i][pMuzikKutusu] != id && strlen(BoomboxData[id][boomboxURL]) && !IsPlayerInAnyVehicle(i))
		{
		    PlayerData[i][pMuzikKutusu] = id;

		    StopAudioStreamForPlayer(i);
		    PlayAudioStreamForPlayer(i, BoomboxData[id][boomboxURL], BoomboxData[id][boomboxPos][0], BoomboxData[id][boomboxPos][1], BoomboxData[id][boomboxPos][2], 30.0, 1);
		}
		else if (PlayerData[i][pMuzikKutusu] != INVALID_PLAYER_ID && !IsPlayerInRangeOfPoint(i, 30.0, BoomboxData[PlayerData[i][pMuzikKutusu]][boomboxPos][0], BoomboxData[PlayerData[i][pMuzikKutusu]][boomboxPos][1], BoomboxData[PlayerData[i][pMuzikKutusu]][boomboxPos][2]))
		{
		    PlayerData[i][pMuzikKutusu] = INVALID_PLAYER_ID;
		    StopAudioStreamForPlayer(i);
		}
		/*if (strlen(PlayerData[i][pIhbar]) > 0)
		{
		    PlayerData[i][pIhbarSayac]--;
		    if (PlayerData[i][pIhbarSayac] <= 0)
		    {
		        format(PlayerData[i][pIhbar], 128, "");
		        PlayerData[i][pIhbarSayac] = 0;
		    }
		}*/
		if (strlen(PlayerData[i][pIhbar]) > 0)
		{
		    PlayerData[i][pIhbarSayac]--;
		    if (PlayerData[i][pIhbarSayac] == 0)
		    {
		        format(PlayerData[i][pIhbar], 128, "");
		        PlayerData[i][pIhbarSayac] = 0;
       			if ((GetFactionType(i) == 4 || GetFactionType(i) >= 6) && PlayerData[i][pOnDuty])
					SetFactionColor(i);
				else SetPlayerColor(i, 0xFFFFFFFF);
		    }
		}
		if (PlayerData[i][pMangalKuruldu] == true)
		{
		    if (PlayerData[i][pYemekPisiriliyor] > 1 && PlayerData[i][pPisirilenYemek] > 0)
		    {
		        PlayerData[i][pYemekPisiriliyor]--;
		        new str[100], yemek[10];
		        if (PlayerData[i][pPisirilenYemek] == 1) yemek = "Köfte";
		        if (PlayerData[i][pPisirilenYemek] == 2) yemek = "Tavuk Eti";
		        if (PlayerData[i][pPisirilenYemek] == 3) yemek = "Dana Eti";
		        format(str, sizeof(str), "{FF9900}[Barbekü]\n\n{FFFFFF}Oluþturan: %s\n\n{9ACD32}%s Piþiriliyor...(%d saniye)", ReturnName(i, 0), yemek, PlayerData[i][pYemekPisiriliyor]);
		        UpdateDynamic3DTextLabelText(PlayerData[i][MangalText], -1, str);
			}
			if (PlayerData[i][pYemekPisiriliyor] == 1 && PlayerData[i][pPisirilenYemek] > 0)
			{
			    new str[100], yemek[10];
			    if (PlayerData[i][pPisirilenYemek] == 1) yemek = "Köfte";
		        if (PlayerData[i][pPisirilenYemek] == 2) yemek = "Tavuk Eti";
		        if (PlayerData[i][pPisirilenYemek] == 3) yemek = "Dana Eti";
			    format(str, sizeof(str), "{FF9900}[Barbekü]\n\n{FFFFFF}Oluþturan: %s\n\n{9ACD32}%s Piþti! (N ile alabilirsiniz)", ReturnName(i, 0), yemek);
			    UpdateDynamic3DTextLabelText(PlayerData[i][MangalText], -1, str);
			}
			if (PlayerData[i][pYemekPisiriliyor] == 0 && PlayerData[i][pPisirilenYemek] == 0)
			{
			    new str[100];
	    		format(str, sizeof(str), "{FF9900}[Barbekü]\n\n{FFFFFF}Oluþturan: %s", ReturnName(i, 0));
	    		UpdateDynamic3DTextLabelText(PlayerData[i][MangalText], -1, str);
			}
		}
		if (GetPlayerState(i) == PLAYER_STATE_DRIVER)
		{
		    id = Car_GetID(GetPlayerVehicleID(i));
		    if (id != -1 && AracInfo[id][aracZirh] > 0)
	    	{
		        new Float:health;
		        GetVehicleHealth(GetPlayerVehicleID(i), health);
		        if (health < 999)
		        {
		            AracInfo[id][aracZirh] -= 10;
		            if (AracInfo[id][aracZirh] <= 5) AracInfo[id][aracZirh] = 0;
		            RepairVehicle(GetPlayerVehicleID(i));
		            SetVehicleHealth(GetPlayerVehicleID(i), 999);
		        }
	    	}
		}
		if (AracCekiyor[i] != INVALID_VEHICLE_ID)
		{
		    if (!IsTrailerAttachedToVehicle(GetPlayerVehicleID(i))) AracCekiyor[i] = INVALID_VEHICLE_ID;
		}
	}
	new str[75];
	for (new i; i < MAX_ODA; i++) if (Paintball[i][odaExists])
	{
	    if (Paintball[i][odaDurum] == ODA_BASLADI)
	    {
	        Paintball[i][odaSayac]--;
	        foreach (new p:Player)
	        {
	            if (IsPlayerConnected(p) && pbOda[p] == i && pbTakim[p] > 0)
	            {
	                if (GetLiderOyuncu(i) == -1)
	                {
						format(str, sizeof(str), "N/A");
					}
					else
					{
					    format(str, sizeof(str), "%s (%d kill)", ReturnName(GetLiderOyuncu(i), 0), pbOldurme[GetLiderOyuncu(i)]);
					}
					PlayerTextDrawSetString(p, PaintballTD[p][5], str);
					format(str, sizeof(str), "%d", Paintball[i][odaPuan][0]);
					PlayerTextDrawSetString(p, PaintballTD[p][3], str);
					format(str, sizeof(str), "%d", Paintball[i][odaPuan][1]);
					PlayerTextDrawSetString(p, PaintballTD[p][4], str);
				 	format(str, sizeof(str), "%s", trcar(Paintball[i][odaTakim1Ad]));
				 	PlayerTextDrawSetString(p, PaintballTD[p][1], str);
					format(str, sizeof(str), "%s", trcar(Paintball[i][odaTakim2Ad]));
				 	PlayerTextDrawSetString(p, PaintballTD[p][2], str);
				 	format(str, sizeof(str), "%s", TimeConvert(Paintball[i][odaSayac]));
				 	PlayerTextDrawSetString(p, PaintballTD[p][6], str);
				 	format(str, sizeof(str), "%d", pbOldurme[p]);
				 	PlayerTextDrawSetString(p, PaintballTD[p][7], str);
				 	format(str, sizeof(str), "%d", pbOlme[p]);
				 	PlayerTextDrawSetString(p, PaintballTD[p][8], str);

	            }
	        }
	        if (Paintball[i][odaSayac] == 0)
	        {
	            MacBitir(i);
	        }
	    }
	}
	TollUpdate();
	return 1;
}

forward AddTolls();
public AddTolls() // Needs to be called in the OnGameModeInit function!
{ // Thanks to Nexus for mapping!
    /* Richman */
    CreateDynamicObject( 8168, 612.73895263672, -1191.4602050781, 20.294105529785, 0.000000, 5, 318.31237792969, -1 );
    CreateDynamicObject( 8168, 620.47265625, -1188.49609375, 20.044105529785, 0.000000, 352.99621582031, 138.94409179688, -1 );
    CreateDynamicObject( 966, 613.97229003906, -1197.7174072266, 17.475030899048, 0.000000, 0.000000, 23.81982421875, -1 );
    CreateDynamicObject( 997, 614.33209228516, -1194.3870849609, 17.709369659424, 0.000000, 0.000000, 266.70568847656, -1 );
    CreateDynamicObject( 973, 602.98425292969, -1202.1643066406, 18.000516891479, 0.000000, 0.000000, 19.849853515625, -1 );

	L_a_TollObject[0] = CreateDynamicObject( 968, 613.8935546875, -1197.7329101563, 18.109180450439, 0.000000, -90.000000, 23.81982421875, -1 );

	new str[256];

	CreateDynamicObject( 966, 619.42913818359, -1181.6597900391, 18.725030899048, 0.000000, 0.000000, 214.37744140625, -1 );
    CreateDynamicObject( 973, 629.68823242188, -1176.0551757813, 19.500516891479, 0.000000, 0.000000, 21.831787109375, -1 );
    CreateDynamicObject( 997, 619.26574707031, -1181.6518554688, 18.709369659424, 0.000000, 0.000000, 268.68908691406, -1 );

	/* End of Richman */

    /* Flint */
    CreateDynamicObject( 8168, 61.256042480469, -1533.3946533203, 6.1042537689209, 0.000000, 0.000000, 9.9252624511719, -1 );
    CreateDynamicObject( 8168, 40.966598510742, -1529.5725097656, 6.1042537689209, 0.000000, 0.000000, 188.5712890625, -1 );
    L_a_TollObject[2] = CreateDynamicObject( 968, 35.838928222656, -1525.9034423828, 5.0012145042419, 0.000000, -90.000000, 270.67565917969, -1 );

    L_a_TollObject[3] = CreateDynamicObject( 968, 67.116600036621, -1536.8218994141, 4.7504549026489, 0.000000, -90.000000, 87.337799072266, -1 );

	CreateDynamicObject( 973, 52.9794921875, -1531.9252929688, 5.090488910675, 0.000000, 0.000000, 352.06005859375, -1 );
    CreateDynamicObject( 973, 49.042072296143, -1531.5065917969, 5.1758694648743, 0.000000, 0.000000, 352.05688476563, -1 );
    CreateDynamicObject( 997, 68.289916992188, -1546.6020507813, 4.0626411437988, 0.000000, 0.000000, 119.09942626953, -1 );
    CreateDynamicObject( 997, 34.5198097229, -1516.1402587891, 4.0626411437988, 0.000000, 0.000000, 292.50622558594, -1 );
    CreateDynamicObject( 997, 35.903915405273, -1525.8717041016, 4.0626411437988, 0.000000, 0.000000, 342.13012695313, -1 );
    CreateDynamicObject( 997, 63.914081573486, -1535.7126464844, 4.0626411437988, 0.000000, 0.000000, 342.130859375, -1 );
    /* End of Flint */

    /* LV */
    CreateDynamicObject( 8168, 1789.83203125, 703.189453125, 15.846367835999, 0.000000, 3, 99.24951171875, -1 );
    CreateDynamicObject( 8168, 1784.8334960938, 703.94799804688, 16.070636749268, 0.000000, 357, 278.61096191406, -1 );
    CreateDynamicObject( 966, 1781.4122314453, 697.32531738281, 14.636913299561, 0.000000, 0.000000, 348.09008789063, -1 );
    CreateDynamicObject( 996, 1767.3087158203, 700.50506591797, 15.281567573547, 0.000000, 0.000000, 346.10510253906, -1 );
    CreateDynamicObject( 997, 1781.6832275391, 697.34796142578, 14.698781013489, 0.000000, 3, 77.41455078125, -1 );
    CreateDynamicObject( 997, 1792.7745361328, 706.38543701172, 13.948781013489, 0.000000, 2.999267578125, 81.379638671875, -1 );
    CreateDynamicObject( 966, 1793.4289550781, 709.87982177734, 13.636913299561, 0.000000, 0.000000, 169.43664550781, -1 );
    CreateDynamicObject( 996, 1800.8060302734, 708.38299560547, 14.281567573547, 0.000000, 0.000000, 346.10229492188, -1 );
    L_a_TollObject[4] = CreateDynamicObject( 968, 1781.4133300781, 697.31750488281, 15.420023918152, 0.000000, -90.000000, 348.10229492188, -1 );
    L_a_TollObject[5] = CreateDynamicObject( 968, 1793.6700439453, 709.84631347656, 14.405718803406, 0.000000, -90.000000, 169.43664550781, -1 );

    format(str, sizeof str, "{2F80C1}«« Giþe »»\n{FFFFFF}/gise komutunu kullanarak giþeyi açabilirsiniz.");
	CreateDynamic3DTextLabel(str, -1, 1781.4133300781, 697.31750488281, 15.420023918152, 20.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, -1, -1, STREAMER_3D_TEXT_LABEL_SD, -1, 0);

	format(str, sizeof str, "{2F80C1}«« Giþe »»\n{FFFFFF}/gise komutunu kullanarak giþeyi açabilirsiniz.");
	CreateDynamic3DTextLabel(str, -1, 1793.6700439453, 709.84631347656, 14.405718803406, 20.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, -1, -1, STREAMER_3D_TEXT_LABEL_SD, -1, 0);
    /* End of LV */

    /* Blueberry right */
    CreateDynamicObject(966, 614.42188, 350.81711, 17.92480,   0.00000, 0.00000, 35.00000);
    CreateDynamicObject(966, 602.91162, 342.59781, 17.92480,   0.00000, 0.00000, 215.92000);
    L_a_TollObject[6] = CreateDynamicObject(968, 614.42188, 350.81711, 18.66520,   0.00000, -90.00000, 35.00000);
    L_a_TollObject[7] = CreateDynamicObject(968, 602.91162, 342.59781, 18.66520,   0.00000, -90.00000, 215.92000);

    format(str, sizeof str, "{2F80C1}«« Giþe »»\n{FFFFFF}/gise komutunu kullanarak giþeyi açabilirsiniz.");
	CreateDynamic3DTextLabel(str, -1, 614.42188, 350.81711, 18.66520, 20.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, -1, -1, STREAMER_3D_TEXT_LABEL_SD, -1, 0);

	format(str, sizeof str, "{2F80C1}«« Giþe »»\n{FFFFFF}/gise komutunu kullanarak giþeyi açabilirsiniz.");
	CreateDynamic3DTextLabel(str, -1, 602.91162, 342.59781, 18.66520, 20.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, -1, -1, STREAMER_3D_TEXT_LABEL_SD, -1, 0);
    /* Blueberry right */

    /* Blueberry left */
    CreateDynamicObject(966, -190.35580, 254.64290, 11.07090,   0.00000, 0.00000, 345.00000);
    CreateDynamicObject(966, -204.00880, 258.30411, 11.07090,   0.00000, 0.00000, -195.00000);
    L_a_TollObject[8] = CreateDynamicObject(968, -190.24850, 254.62019, 11.89360,   0.00000, -90.00000, -14.94000);
    L_a_TollObject[9] = CreateDynamicObject(968, -204.10410, 258.34149, 11.89360,   0.00000, -90.00000, -195.00000);

    format(str, sizeof str, "{2F80C1}«« Giþe »»\n{FFFFFF}/gise komutunu kullanarak giþeyi açabilirsiniz.");
	CreateDynamic3DTextLabel(str, -1, -190.24850, 254.62019, 11.89360, 20.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, -1, -1, STREAMER_3D_TEXT_LABEL_SD, -1, 0);

	format(str, sizeof str, "{2F80C1}«« Giþe »»\n{FFFFFF}/gise komutunu kullanarak giþeyi açabilirsiniz.");
	CreateDynamic3DTextLabel(str, -1, -204.10410, 258.34149, 11.89360, 20.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, -1, -1, STREAMER_3D_TEXT_LABEL_SD, -1, 0);
    /* Blueberry right */
    return 1;
}
forward TollUpdate();
public TollUpdate()
{
    for (new i = 0; i < MAX_TOLLS; i++)
    {
        if (aTolls[i][E_tOpenTime] > 0)
        {
            aTolls[i][E_tOpenTime]--;
            if (aTolls[i][E_tOpenTime] == 0)
            {
                Toll_CloseToll(i);
            }
        }
    }
}
forward NT_Update(playerid);
public NT_Update(playerid)
{
    new str[256], oyuncuAdi[24], admincolor[10], hours, minutes, seconds;

    if (!IsValidDynamic3DTextLabel(NameTag[playerid]))
	{
	    NameTag[playerid] = Text3D: -1;
		NameTag[playerid] = CreateDynamic3DTextLabel("-", -1, 0.0, 0.0, 0.1, 10.0, playerid, INVALID_VEHICLE_ID, 0, -1, -1, -1, STREAMER_3D_TEXT_LABEL_SD, -1, 0);
	}

	switch (PlayerData[playerid][pMaske])
	{
	    case false:
	    {
	        format(oyuncuAdi, sizeof oyuncuAdi, "%s", ReturnName(playerid, 0, 1));
	    }
	    case true:
	    {
	        format(oyuncuAdi, sizeof oyuncuAdi, "Gizli");
	    }
	}

	switch (PlayerData[playerid][pAdmin])
	{
		case 1: admincolor = "00FF00";
		case 2: admincolor = "CC0000";
		case 3: admincolor = "CC0000";
		case 4: admincolor = "CC0000";
		case 5: admincolor = "CC0000";
		default: admincolor = "04d3ff";
	}

	if (IsPlayerPause(playerid))
		GetElapsedTime(TimeSincePaused(playerid), hours, minutes, seconds);

	if (PetKontrol[playerid] != -1)
	{
		if (IsPlayerPause(playerid))
		{
			format(str, sizeof(str), "%s{E74C3C}[%02d:%02d:%02d AFK]\n{FFFFFF}%s (%d)", (PlayerData[playerid][pGOD] == true) ? ("{FFA500}[GODMODE]\n") : (""), hours, minutes, seconds, PetBilgi[PetKontrol[playerid]][petAdi], playerid);
		}
		else
		{
			format(str, sizeof(str), "%s{FFFFFF}%s (%d)", (PlayerData[playerid][pGOD] == true) ? ("{FFA500}[GODMODE]\n") : (""), PetBilgi[PetKontrol[playerid]][petAdi], playerid);
		}
		Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, NameTag[playerid], E_STREAMER_Z, 0.1);
	}

	else if ((PlayerData[playerid][pAdmin] > 0 || PlayerData[playerid][pOyunGorevlisi] > 0 || PlayerData[playerid][pForumGorevlisi] > 0) && PlayerData[playerid][pAdminDuty] == 1)
	{
		if (IsPlayerPause(playerid))
		{
			format(str, sizeof(str), "%s{E74C3C}[%02d:%02d:%02d AFK]\n{%s}%s\n{%s}%s", (PlayerData[playerid][pGOD] == true) ? ("{FFA500}[GODMODE]\n") : (""), hours, minutes, seconds, admincolor, PlayerData[playerid][pAdminName], admincolor, GetAdminRank(playerid));
		}
		else
		{
			format(str, sizeof(str), "%s{%s}%s\n{%s}%s", (PlayerData[playerid][pGOD] == true) ? ("{FFA500}[GODMODE]\n") : (""), admincolor, PlayerData[playerid][pAdminName], admincolor, GetAdminRank(playerid));
		}
		Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, NameTag[playerid], E_STREAMER_Z, 0.2);
	}


	else if (PlayerData[playerid][pHelperDuty] == 1 && PlayerData[playerid][pHelper] >= 1)
	{
		if (IsPlayerPause(playerid))
		{
			format(str, sizeof(str), "%s{E74C3C}[%02d:%02d:%02d AFK]\n{e4b400}(Lv. %d) Helper\n{e4b400}%s(%d)", (PlayerData[playerid][pGOD] == true) ? ("{FFA500}[GODMODE]\n") : (""), hours, minutes, seconds, PlayerData[playerid][pHelper], PlayerData[playerid][pAdminName], playerid);
		}
		else
		{
			format(str, sizeof(str), "%s{e4b400}(Lv. %d) Helper\n{e4b400}%s(%d)", (PlayerData[playerid][pGOD] == true) ? ("{FFA500}[GODMODE]\n") : (""), PlayerData[playerid][pHelper], PlayerData[playerid][pAdminName], playerid);
		}
		Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, NameTag[playerid], E_STREAMER_Z, 0.3);
	}

	else if (PlayerData[playerid][pOnDuty])
	{
		if (GetFactionType(playerid) == BIRLIK_LSPD)
		{
			if (IsPlayerPause(playerid))
			{
				format(str, sizeof(str), "%s{E74C3C}[%02d:%02d:%02d AFK]\n{8D8DFF}[ %s ]\n{8D8DFF}%s (%s%d)", (PlayerData[playerid][pGOD] == true) ? ("{FFA500}[GODMODE]\n") : (""), hours, minutes, seconds, Birlik_GetRutbe(playerid), oyuncuAdi, (PlayerData[playerid][pMaske] == true) ? ("#") : (""), (PlayerData[playerid][pMaske] == true) ? (PlayerData[playerid][pMaskeID]) : (playerid));
			}
			else
			{
				format(str, sizeof(str), "%s{8D8DFF}[ %s ]\n{8D8DFF}%s (%s%d)", (PlayerData[playerid][pGOD] == true) ? ("{FFA500}[GODMODE]\n") : (""), Birlik_GetRutbe(playerid),oyuncuAdi, (PlayerData[playerid][pMaske] == true) ? (("#")) : (""), (PlayerData[playerid][pMaske] == true) ? (PlayerData[playerid][pMaskeID]) : (playerid));
			}
		}
		if (GetFactionType(playerid) == BIRLIK_LSMD)
		{
			if (IsPlayerPause(playerid))
			{
				format(str, sizeof(str), "%s{E74C3C}[%02d:%02d:%02d AFK]\n{FF8282}[ %s ]\n{FF8282}%s (%s%d)", (PlayerData[playerid][pGOD] == true) ? ("{FFA500}[GODMODE]\n") : (""), hours, minutes, seconds, Birlik_GetRutbe(playerid), oyuncuAdi, (PlayerData[playerid][pMaske] == true) ? ("#") : (""), (PlayerData[playerid][pMaske] == true) ? (PlayerData[playerid][pMaskeID]) : (playerid));
			}
			else
			{
				format(str, sizeof(str), "%s{FF8282}[ %s ]\n{FF8282}%s (%s%d)", (PlayerData[playerid][pGOD] == true) ? ("{FFA500}[GODMODE]\n") : (""), Birlik_GetRutbe(playerid), oyuncuAdi, (PlayerData[playerid][pMaske] == true) ? (("#")) : (""), (PlayerData[playerid][pMaske] == true) ? (PlayerData[playerid][pMaskeID]) : (playerid));
			}
		}
		if (GetFactionType(playerid) == BIRLIK_HABER)
		{
			if (IsPlayerPause(playerid))
			{
				format(str, sizeof(str), "%s{E74C3C}[%02d:%02d:%02d AFK]\n{9ACD32}[ %s ]\n{9ACD32}%s (%s%d)", (PlayerData[playerid][pGOD] == true) ? ("{FFA500}[GODMODE]\n") : (""), hours, minutes, seconds, Birlikler[PlayerData[playerid][pFaction]][birlikAd], oyuncuAdi, (PlayerData[playerid][pMaske] == true) ? ("#") : (""), (PlayerData[playerid][pMaske] == true) ? (PlayerData[playerid][pMaskeID]) : (playerid));
			}
			else
			{
				format(str, sizeof(str), "%s{9ACD32}[ %s ]\n{9ACD32}%s (%s%d)", (PlayerData[playerid][pGOD] == true) ? ("{FFA500}[GODMODE]\n") : (""), Birlikler[PlayerData[playerid][pFaction]][birlikAd], oyuncuAdi, (PlayerData[playerid][pMaske] == true) ? ("#") : (""), (PlayerData[playerid][pMaske] == true) ? (PlayerData[playerid][pMaskeID]) : (playerid));
   			}
		}
		if (GetFactionType(playerid) == BIRLIK_GOV)
		{
			if (IsPlayerPause(playerid))
			{
				format(str, sizeof(str), "%s{E74C3C}[%02d:%02d:%02d AFK]\n{AFAFAF}[ %s ]\n{AFAFAF}%s (%s%d)", (PlayerData[playerid][pGOD] == true) ? ("{FFA500}[GODMODE]\n") : (""), hours, minutes, seconds, Birlikler[PlayerData[playerid][pFaction]][birlikAd], oyuncuAdi, (PlayerData[playerid][pMaske] == true) ? ("#") : (""), (PlayerData[playerid][pMaske] == true) ? (PlayerData[playerid][pMaskeID]) : (playerid));
			}
			else
			{
		 		format(str, sizeof(str), "%s{AFAFAF}[ %s ]\n{AFAFAF}%s (%s%d)", (PlayerData[playerid][pGOD] == true) ? ("{FFA500}[GODMODE]\n") : (""), Birlikler[PlayerData[playerid][pFaction]][birlikAd], oyuncuAdi, (PlayerData[playerid][pMaske] == true) ? ("#") : (""), (PlayerData[playerid][pMaske] == true) ? (PlayerData[playerid][pMaskeID]) : (playerid));
			}
		}
		if (GetFactionType(playerid) == BIRLIK_FBI)
		{
			if (IsPlayerPause(playerid))
			{
				format(str, sizeof(str), "%s{E74C3C}[%02d:%02d:%02d AFK]\n{0000BB}[ %s ]\n{0000BB}%s (%s%d)", (PlayerData[playerid][pGOD] == true) ? ("{FFA500}[GODMODE]\n") : (""), hours, minutes, seconds, Birlik_GetRutbe(playerid), oyuncuAdi, (PlayerData[playerid][pMaske] == true) ? ("#") : (""), (PlayerData[playerid][pMaske] == true) ? (PlayerData[playerid][pMaskeID]) : (playerid));
			}
			else
			{
				format(str, sizeof(str), "%s{0000BB}[ %s ]\n{0000BB}%s (%s%d)", (PlayerData[playerid][pGOD] == true) ? ("{FFA500}[GODMODE]\n") : (""), Birlik_GetRutbe(playerid),oyuncuAdi, (PlayerData[playerid][pMaske] == true) ? (("#")) : (""), (PlayerData[playerid][pMaske] == true) ? (PlayerData[playerid][pMaskeID]) : (playerid));
			}
		}
		Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, NameTag[playerid], E_STREAMER_Z, 0.3);
	}

	else
	{
		if (IsPlayerPause(playerid))
		{
			if (PlayerData[playerid][pVipRenk] == 1)
			{
				format(str, sizeof(str), "%s{E74C3C}[%02d:%02d:%02d AFK]\n%s\n{%s}%s (%s%d)", (PlayerData[playerid][pGOD] == true) ? ("{FFA500}[GODMODE]\n") : (""), hours, minutes, seconds, (PlayerData[playerid][pYoutuberTag] == true) ? ("{f72020}[Youtuber & Streamer]") : (""), GetVIPRenk(PlayerData[playerid][pVip]), oyuncuAdi, (PlayerData[playerid][pMaske] == true) ? (("#")) : (""), (PlayerData[playerid][pMaske] == true) ? (PlayerData[playerid][pMaskeID]) : (playerid));
			}
			else
			{
				format(str, sizeof(str), "%s{E74C3C}[%02d:%02d:%02d AFK]\n%s\n{FFFFFF}%s (%s%d)", (PlayerData[playerid][pGOD] == true) ? ("{FFA500}[GODMODE]\n") : (""), hours, minutes, seconds, (PlayerData[playerid][pYoutuberTag] == true) ? ("{f72020}[Youtuber & Streamer]") : (""), oyuncuAdi, (PlayerData[playerid][pMaske] == true) ? (("#")) : (""), (PlayerData[playerid][pMaske] == true) ? (PlayerData[playerid][pMaskeID]) : (playerid));
			}
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, NameTag[playerid], E_STREAMER_Z, 0.4);
		}
		else
		{
			if (PlayerData[playerid][pVipRenk] == 1)
			{
				if (PlayerData[playerid][pYoutuberTag] == true)
				{
					format(str, sizeof(str), "%s{f72020}[Youtuber & Streamer]\n\n{%s}%s (%s%d)", (PlayerData[playerid][pGOD] == true) ? ("{FFA500}[GODMODE]\n") : (""), GetVIPRenk(PlayerData[playerid][pVip]), oyuncuAdi, (PlayerData[playerid][pMaske] == true) ? (("#")) : (""), (PlayerData[playerid][pMaske] == true) ? (PlayerData[playerid][pMaskeID]) : (playerid));
				}
				else
				{
					format(str, sizeof(str), "%s{%s}%s (%s%d)", (PlayerData[playerid][pGOD] == true) ? ("{FFA500}[GODMODE]\n") : (""), GetVIPRenk(PlayerData[playerid][pVip]), oyuncuAdi, (PlayerData[playerid][pMaske] == true) ? (("#")) : (""), (PlayerData[playerid][pMaske] == true) ? (PlayerData[playerid][pMaskeID]) : (playerid));
				}
			}
			else
			{
				if (PlayerData[playerid][pYoutuberTag] == true)
				{
			 		format(str, sizeof(str), "%s{f72020}[Youtuber & Streamer]\n\n{FFFFFF}%s (%s%d)", (PlayerData[playerid][pGOD] == true) ? ("{FFA500}[GODMODE]\n") : (""), oyuncuAdi, (PlayerData[playerid][pMaske] == true) ? (("#")) : (""), (PlayerData[playerid][pMaske] == true) ? (PlayerData[playerid][pMaskeID]) : (playerid));
				}
				else
				{
					format(str, sizeof(str), "%s{FFFFFF}%s (%s%d)", (PlayerData[playerid][pGOD] == true) ? ("{FFA500}[GODMODE]\n") : (""), oyuncuAdi, (PlayerData[playerid][pMaske] == true) ? (("#")) : (""), (PlayerData[playerid][pMaske] == true) ? (PlayerData[playerid][pMaskeID]) : (playerid));
				}
			}
			Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, NameTag[playerid], E_STREAMER_Z, 0.1);
		}
	}

	UpdateDynamic3DTextLabelText(NameTag[playerid], -1, str);
    return 1;
}
stock Float:Vehicle_GetSpeed(vehicleid)
{
    new Float: vx, Float: vy, Float: vz, Float: vel;
    vel = GetVehicleVelocity(vehicleid, vx, vy, vz);
    vel = (floatsqroot(((vx*vx)+(vy*vy))+(vz*vz)) * 181.5);
    return vel;
}
forward ConsumeFuel();
public ConsumeFuel()
{
    new Float: mass, Float: speed, Float: dist;
    new panelsx,doorsx,lightsx,tiresx;
    new id;
    for (new i = 1, ps = GetVehiclePoolSize(); i <= ps; i++)
    {
        if (!IsValidVehicle(i)) continue;

		new Float:hp;

		GetVehicleHealth(i, hp);

		if(hp <= 150.0)
		{
			SetVehicleToRespawn(i);
			SetVehicleHealth(i, 1000.0);
		}

		if(hp >= 151.0 && hp <= 249.0)
		{
			if(IsPlayerConnected(GetVehicleDriver(i)))
			{
				SunucuMesaji(GetVehicleDriver(i), "Araç motoru kapandý, kullanýlamaz durumda.");
			}

			SetVehicleHealth(i, 250.0);
			SetEngineStatus(i, false);
		}

        if (Flasher[i] == 1)
        {
        	if (FlasherState[i] == 1)
         	{
          		GetVehicleDamageStatus(i,panelsx,doorsx,lightsx,tiresx);
            	UpdateVehicleDamageStatus(i, panelsx, doorsx, 4, tiresx);
             	FlasherState[i] = 0;
          	}
            else
            {
            	GetVehicleDamageStatus(i,panelsx,doorsx,lightsx,tiresx);
             	UpdateVehicleDamageStatus(i, panelsx, doorsx, 1, tiresx);
              	FlasherState[i] = 1;
            }
        }
        if (Vehicle_IsANoFuelVehicle( GetVehicleModel(i) )) continue;
        if (!GetEngineStatus(i)) continue;
        id = Car_GetID(i);
        if (AracInfo[id][aracTip] != 4) continue;
        dist = GetVehicleDistanceFromPoint(i, VehicleLastCoords[i][0], VehicleLastCoords[i][1], VehicleLastCoords[i][2]);
        mass = GetVehicleModelInfoAsFloat(GetVehicleModel(i), "fMass");
        speed = Vehicle_GetSpeed(i) + 0.001;
        AracInfo[id][aracBenzin] -= ((mass / (mass * 4.5)) * ((speed / 60) + 0.015) / 30) * ((dist / 10) + 0.001);

		if (GetVehicleModel(AracInfo[id][aracVehicle]) != 481 && GetVehicleModel(AracInfo[id][aracVehicle]) != 509 && GetVehicleModel(AracInfo[id][aracVehicle]) != 510)
		{
            if (AracInfo[id][aracBenzin] < 0.1)
				SetEngineStatus(i, false);
		}

		GetVehiclePos(i, VehicleLastCoords[i][0], VehicleLastCoords[i][1], VehicleLastCoords[i][2]);
    }

    return 1;
}

forward MinuteUpdate();
public MinuteUpdate()
{
	saatlikTimer--;

	if(saatlikTimer < 1)
	{
		saatlikTimer = 60;

		mysql_tquery(g_SQL, "SELECT ID, discord_id FROM oyuncular WHERE discord_id != '0'", "DiscordExp");
	}

	SetActorPos(actors[1], 1457.8317,-1777.6063,1815.9910);
 	SetActorPos(actors[2], 1344.7832,27.9946,1000.9609);
 	foreach(new i:Player)
 	{
 	    if(OyundaDegil(i))
 	    {
 	        if(IsValidDynamic3DTextLabel(NameTag[i])) DestroyDynamic3DTextLabel(NameTag[i]);
 	        NameTag[i] = CreateDynamic3DTextLabel("Regular Roleplay", 0xFFFFFFFF, 0.0, 0.0, 0.1, 10.0, i, INVALID_VEHICLE_ID, 1);
 	        Streamer_Update(i, STREAMER_TYPE_3D_TEXT_LABEL);
 	        Oyuncu_Kaydet(i);
 	    }
 	}
	for (new i; i<3; i++)
	{

		if (IsValidActor(DealerData[i][dealerActorID]))
		{
  			SetActorPos(DealerData[i][dealerActorID], DealerData[i][dealerX], DealerData[i][dealerY], DealerData[i][dealerZ]);
 		}
	    if (IsValidActor(BankerData[i][bankerActorID]))
	    {
	        SetActorPos(BankerData[i][bankerActorID], BankerData[i][bankerX], BankerData[i][bankerY], BankerData[i][bankerZ]);
	    }
	}
	for (new i; i<MAX_ARSA; i++) if (ArsaBilgi[i][arsaSahip] != -1 && ArsaBilgi[i][arsaTip] == 2)
	{
	    if (ArsaBilgi[i][KiraSure] <= gettime())
	    {
	        ArsaBilgi[i][arsaSahip] = -1;
	        ArsaBilgi[i][KiraSure] = 0;
	        ArsaUpdate(i);
	        for (new t; t<MAX_TOHUM; t++) if (Tohumlar[t][tohumArsa] == i)
	        {
	            DestroyDynamicObject(Tohumlar[t][tohumObject]);
				DestroyDynamic3DTextLabel(Tohumlar[t][tohumLabel]);
				Tohumlar[t][tohumArsa] = -1;
			    Tohumlar[t][tohumTip] = 0;
			    Tohumlar[t][tohumBuyume] = 0;
			    Tohumlar[t][tohumPos][0] = Tohumlar[t][tohumPos][1] = Tohumlar[t][tohumPos][2] = 0.0;
	        }
	    }
	}
	for (new i; i<MAX_TOHUM; i++) if (Tohumlar[i][tohumArsa] != -1)
	{
	    if (Tohumlar[i][tohumBuyume] < 60)
	    {
	        Tohumlar[i][tohumBuyume]++;
	        if (Tohumlar[i][tohumBuyume] == 20)
	        {
	            DestroyDynamicObject(Tohumlar[i][tohumObject]);
		        DestroyDynamic3DTextLabel(Tohumlar[i][tohumLabel]);
	        }
	        if (Tohumlar[i][tohumBuyume] == 40)
	        {
	            DestroyDynamicObject(Tohumlar[i][tohumObject]);
		        DestroyDynamic3DTextLabel(Tohumlar[i][tohumLabel]);
	        }
	        if (Tohumlar[i][tohumBuyume] >= 60)
	    	{
		        DestroyDynamicObject(Tohumlar[i][tohumObject]);
		        DestroyDynamic3DTextLabel(Tohumlar[i][tohumLabel]);
		        Tohumlar[i][tohumSayi] = RandomEx(5, 11);
	    	}
	        TohumUpdate(i);
	    }
	}
    vergitime++;
    for (new i = 0; i < MAX_ARAC; i++)
    {
    	if (AracInfo[i][aracExists] && AracInfo[i][aracModel] != 509)
        {
            if (vergitime >= 60) AracVergiArttir(i);

			if (AracInfo[i][aracTip] == 3 && AracInfo[i][aracKira] > 0 && AracInfo[i][aracKiralayan] != -1)
            {
                if (AracInfo[i][aracKiraZaman] <= 1)
                {
                    AracInfo[i][aracKiralayan] = -1;
                    AracInfo[i][aracKiraZaman] = 0;
                    AracInfo[i][aracKilit] = false;
                    Arac_Spawn(i);
                }
                else if (AracInfo[i][aracKiraZaman] > 1)
                {
                    AracInfo[i][aracKiraZaman]--;

                    if(AracInfo[i][aracKiraZaman] <= 10)
                    {
                    	if(IsPlayerConnected(GetPlayerIDWithSQLID(AracInfo[i][aracKiralayan])))
                    	{
                    		SunucuMesaji(GetPlayerIDWithSQLID(AracInfo[i][aracKiralayan]), "Araç kira süresinin bitmesine %d dakika kaldý.", AracInfo[i][aracKiraZaman]);
                    	}
                    }
                }
            }

			if (AracInfo[i][aracTip] == 4 && AracInfo[i][aracSahip] > 0 && AracInfo[i][aracTicket] > 0 && AracInfo[i][aracTicketTime] < gettime() && AracInfo[i][aracElKonuldu] == 0)
            {
                AracInfo[i][aracElKonuldu] = 1;
                AracInfo[i][aracTicketTime] = 0;
                AracInfo[i][aracDisplay] = false;
                SetVehicleVirtualWorld(AracInfo[i][aracVehicle], 1000);
                Arac_Kaydet(i);
                new oyuncuID = GetPlayerIDWithSQLID(AracInfo[i][aracSahip]);
                if (oyuncuID != -1)
                {
                    BilgiMesajGonder(oyuncuID, "%s model aracýnýzýn cezasýný ödemediðiniz için devlet tarafýndan el koyuldu.");
                }
                else
                {
                    new str[50];
                    format(str, sizeof(str), "%s model aracýnýzýn cezasýný ödemediðiniz için devlet tarafýndan el koyuldu.",ReturnVehicleModelName(AracInfo[i][aracModel]));
                    BildirimEkle(AracInfo[i][aracSahip], str, "Sistem");
                }
            }
        }
    }
	if (vergitime >= 60)
	{
			for (new i = 0; i < MAX_EV; i++)
		    	{
		    	    if (HouseInfo[i][evExists] && HouseInfo[i][evSahip] > 0)
		    	    {
		    	        if (HouseInfo[i][evVergi] < Ev_MaksVergi(i))
		    	        {
		    	            HouseInfo[i][evVergi] += GetHouseVergi(i);
		    	            Ev_Kaydet(i);
		    	        }
	    	         	if (HouseInfo[i][evVergi] >= Ev_MaksVergi(i) && HouseInfo[i][evVergiSure] < 1)
		    	        {
		    	            HouseInfo[i][evVergiSure] += gettime()+VERGI_GUN*86400;
		    	            Ev_Kaydet(i);
		    	            if (GetPlayerIDWithSQLID(HouseInfo[i][evSahip]) != -1)
			            	{
			                	BilgiMesajGonder(GetPlayerIDWithSQLID(HouseInfo[i][evSahip]), "%s adlý evinizin vergisi doldu, %d gün içerisinde ödemezseniz ev satýlacak.", HouseInfo[i][evIsim], VERGI_GUN);
			            	}
			            	else
			            	{
				                new str[100];
		                  		format(str, sizeof(str), "%s adlý evinizin vergisi doldu, %d gün içerisinde ödemezseniz ev satýlacak.",HouseInfo[i][evIsim], VERGI_GUN);
		                    	BildirimEkle(HouseInfo[i][evSahip], str, "Sistem");
			            	}
		    	        }
		    	        if (HouseInfo[i][evVergi] >= Ev_MaksVergi(i) && HouseInfo[i][evVergiSure] < gettime())
		    	        {
		    	            if (GetPlayerIDWithSQLID(HouseInfo[i][evSahip]) != -1)
		    	            {
		    	                BilgiMesajGonder(GetPlayerIDWithSQLID(HouseInfo[i][evSahip]), "Evinizin vergisini %d gün içerisinde ödemediðiniz için satýldý.", VERGI_GUN);
		    	            }
		    	            else
		    	            {
		    	                BildirimEkle(HouseInfo[i][evSahip], "Evinizin vergisini ödemediðiniz için satýldý.", "Sistem");
		    	            }
		    	            HouseInfo[i][evSahip] = -1;
		    	            HouseInfo[i][evFiyat] = HouseInfo[i][evKendiFiyati];
		    	            format(HouseInfo[i][evIsim], 30, "");
		    	            HouseInfo[i][evVergi] = 0;
		    	            HouseInfo[i][evVergiSure] = 0;
		    	            HouseInfo[i][evKilit] = 0;
		    	            HouseInfo[i][evCash] = 0;
		    	            HouseInfo[i][evSatilik] = 0;
		    	            HouseInfo[i][evKiralik] = 0;
		    	            HouseInfo[i][evKiraUcret] = 0;
		    	            HouseInfo[i][evKiralayan] = -1;
		    	            HouseInfo[i][MobilyaYetki] = -1;
		    	            for (new k; k<10; k++)
		    	            {
		    	                if (k < 5) HouseInfo[i][evKiyafetler][k] = 0;
		    	                HouseInfo[i][evSilahlar][k] = 0;
		    	                HouseInfo[i][evMermiler][k] = 0;
		    	            }
		    	            House_RemoveFurniture(i);
		    	        }
					}
			}
	}
    if (vergitime >= 60)
    {
 			vergitime = 0;
            for (new j; j < MAX_ISYERI; j++)
			{
			    if (Isyeri[j][isyeriExists] && Isyeri[j][isyeriSahip] > 0)
			    {
			        if (Isyeri[j][isyeriVergi] < IsyeriMaksVergi(j))
			        {
				        Isyeri[j][isyeriVergi] += GetIsyeriVergi(j);
				        Isyeri_Kaydet(j);
			        }
			        if (Isyeri[j][isyeriVergi] >= IsyeriMaksVergi(j) && Isyeri[j][isyeriVergiSure] < 1)
			        {
			            Isyeri[j][isyeriVergiSure] = gettime()+VERGI_GUN*86400;
			            Isyeri[j][isyeriKilit] = true;
			            Isyeri_Yenile(j);
	            		Isyeri_Kaydet(j);
			            if (GetPlayerIDWithSQLID(Isyeri[j][isyeriSahip]) != -1)
			            {
			                BilgiMesajGonder(GetPlayerIDWithSQLID(Isyeri[j][isyeriSahip]), "%s adlý iþyerinizin vergisi doldu, %d gün içerisinde ödemezseniz iþyeri satýlacak.", Isyeri[j][isyeriName], VERGI_GUN);
			            }
			            else
			            {
			                new str[100];
	                  		format(str, sizeof(str), "%s adlý iþyerinizin vergisi doldu, %d gün içerisinde ödemezseniz iþyeri satýlacak.",Isyeri[j][isyeriName], VERGI_GUN);
	                    	BildirimEkle(Isyeri[j][isyeriSahip], str, "Sistem");
			            }
			        }
			        if (Isyeri[j][isyeriVergi] >= IsyeriMaksVergi(j) && Isyeri[j][isyeriVergiSure] < gettime())
			        {
			            if (GetPlayerIDWithSQLID(Isyeri[j][isyeriSahip]) != -1)
			            {
			                if (Isyeri[j][isyeriKasa] > 0)
							{
							    ParaVer(GetPlayerIDWithSQLID(Isyeri[j][isyeriSahip]), Isyeri[j][isyeriKasa]);
							    MesajGonder(GetPlayerIDWithSQLID(Isyeri[j][isyeriSahip]), "Ýþyerinizin vergisini %d gün içerisinde ödemediðiniz için satýldý. (Kasadaki %s miktar para geri verildi)", VERGI_GUN, FormatNumber(Isyeri[j][isyeriKasa]));
							}
							else
							{
							    MesajGonder(GetPlayerIDWithSQLID(Isyeri[j][isyeriSahip]), "Ýþyerinizin vergisini %d gün içerisinde ödemediðiniz için satýldý.", VERGI_GUN);
							}
			            }
			            else
			            {
			                if (Isyeri[j][isyeriKasa] > 0)
			                {
			                    OfflineParaVer(Isyeri[j][isyeriSahip], Isyeri[j][isyeriKasa]);
			                	BildirimEkle(Isyeri[j][isyeriSahip], "Ýþyerinizin vergisini ödemediðiniz için satýldý. (Kasadaki para verildi)", "Sistem");
							}
							else BildirimEkle(Isyeri[j][isyeriSahip], "Ýþyerinizin vergisini ödemediðiniz için satýldý.", "Sistem");
			            }
			            format(Isyeri[j][isyeriName], 32, "Satýlýk Ýþyeri");
			            format(Isyeri[j][isyeriMesaj], 100, "");
			            Isyeri[j][isyeriSahip] = -1;
			            Isyeri[j][isyeriFiyat] = Isyeri[j][isyeriKendiFiyati];
			            Isyeri[j][isyeriSatilik] = 0;
			            Isyeri[j][isyeriVergi] = 0;
			            Isyeri[j][isyeriVergiSure] = 0;
			            Isyeri[j][isyeriGirisUcret] = 0;
			            format(Isyeri[j][isyeriMuzik], 256, "");
			            Isyeri[j][isyeriKilit] = 0;
			            Isyeri[j][isyeriKasa] = 0;
			            Isyeri_Kaydet(j);
			            Isyeri_Yenile(j);

		        	}
		    	}
			}
    }
    //PanelUpdate();
	return 1;
}
forward MotorCalistir(playerid, vehicleid);
public MotorCalistir(playerid, vehicleid)
{
	if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return 1;
	SetEngineStatus(vehicleid, true);
	SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "* Aracýn motoru çalýþmýþtýr. (( %s ))",ReturnName(playerid, 0));
	return 1;
}
forward BirlikleriYukle();
public BirlikleriYukle()
{
	mysql_query(g_SQL, "SELECT * FROM `birlikler`");

	new rows = cache_num_rows();

	printf("» Toplam %d birlik yüklendi.", rows);

	if (rows)
	{
		new bID, str[256];
		for (new i = 0; i < rows; i++)
		{
		    cache_get_value_name_int(i, "bid", bID);

			Birlikler[bID][birlikExists] = true;
			Birlikler[bID][birlikID] = bID;

		    cache_get_value_name(i,      "bisim", Birlikler[bID][birlikAd],32);
		    cache_get_value_name_int(i,  "brenk", Birlikler[bID][birlikColor]);
		    cache_get_value_name_int(i,  "btip", Birlikler[bID][birlikTip]);
		    cache_get_value_name_int(i,  "bRutbeler", Birlikler[bID][birlikRutbeler]);
		    cache_get_value_name_int(i,  "sistemselonay", Birlikler[bID][birlikOnaylar][0]);
		    cache_get_value_name_int(i,  "silahonay", Birlikler[bID][birlikOnaylar][1]);
		    cache_get_value_name_int(i,  "uyusturucuonay", Birlikler[bID][birlikOnaylar][2]);
		    cache_get_value_name_int(i,  "graffitionay", Birlikler[bID][birlikOnaylar][3]);
		    cache_get_value_name_int(i,  "hoodonay", Birlikler[bID][birlikOnaylar][4]);
		    cache_get_value_name(i,      "bduyuru", Birlikler[bID][birlikDuyuru],128);
		    cache_get_value_name_int(i,  "bkasacash", Birlikler[bID][birlikKasaPara]);
		    cache_get_value_name_int(i,  "oocdurum", Birlikler[bID][OOCDurum]);
		    cache_get_value_name_int(i,  "yayindurum", Birlikler[bID][yayinDurum]);
		    cache_get_value_name_int(i,  "yayintipi", Birlikler[bID][yayinTipi]);
		    cache_get_value_name_int(i,  "reklamalimi", Birlikler[bID][ReklamAlimi]);
		    cache_get_value_name_int(i,  "reklamucreti", Birlikler[bID][ReklamUcreti]);
		    cache_get_value_name_int(i,  "reklamsayisi", Birlikler[bID][ReklamSayisi]);
		    cache_get_value_name_float(i, "reklamx", Birlikler[bID][reklamPos][0]);
		    cache_get_value_name_float(i, "reklamy", Birlikler[bID][reklamPos][1]);
		    cache_get_value_name_float(i, "reklamz", Birlikler[bID][reklamPos][2]);

		    for (new j = 0; j < 15; j ++)
		    {
		        if (j < 8)
		        {
		            format(str,sizeof(str), "byetki%d",j+1);
		            cache_get_value_name_int(i,str,Birlikler[bID][birlikYetkilendirme][j]);
		        }
		        if (j < 5)
		        {
		            format(str,sizeof str, "bdivizyon%d", j+1);
		            cache_get_value_name(i, str, BirlikDivizyon[bID][j], 15);
		        }
		        format(str, sizeof str, "brutbe%d", j+1);
		        cache_get_value_name(i, str, BirlikRutbe[bID][j], 32);
		    }

		    if (Birlikler[bID][reklamPos][0] != 0.0 && Birlikler[bID][reklamPos][1] != 0.0 && Birlikler[bID][birlikTip] == BIRLIK_HABER)
		    {
		     	Birlikler[bID][reklamPickup] = CreateDynamicPickup(1239, 23, Birlikler[bID][reklamPos][0], Birlikler[bID][reklamPos][1], Birlikler[bID][reklamPos][2]);
		       	format(str, sizeof(str), "{E74C3C}[Reklam Noktasý]\n{E74C3C}Ajans: {FFFFFF}%s\n{E74C3C}Ücret: {FFFFFF}%s\n{E74C3C}(/reklamver)", Birlikler[bID][birlikAd], FormatNumber(Birlikler[bID][ReklamUcreti]));
		        Birlikler[bID][reklamLabel] = CreateDynamic3DTextLabel(str, -1, Birlikler[bID][reklamPos][0], Birlikler[bID][reklamPos][1], Birlikler[bID][reklamPos][2], 10.0);
	        }
		}
	}
	return 1;
}

forward EvleriYukle();
public EvleriYukle()
{
	mysql_query(g_SQL, "SELECT * FROM `evler`");

	new rows = cache_num_rows();

	printf("» Toplam %d ev yüklendi.", rows);

	if (rows)
	{
	    new str[256], hoID;
		for (new i = 0; i < rows; i++)
		{
		    cache_get_value_name_int(i, "evid", hoID);

		    HouseInfo[hoID][evExists] = true;
		    HouseInfo[hoID][evID] = hoID;

		    cache_get_value_name_int(i, "evOwner", HouseInfo[hoID][evSahip]);
		    cache_get_value_name_int(i, "evFiyat", HouseInfo[hoID][evFiyat]);
		    cache_get_value_name_int(i, "evKendiFiyati", HouseInfo[hoID][evKendiFiyati]);
		    cache_get_value_name_float(i, "evPosX", HouseInfo[hoID][evPos][0]);
		    cache_get_value_name_float(i, "evPosY", HouseInfo[hoID][evPos][1]);
		    cache_get_value_name_float(i, "evPosZ", HouseInfo[hoID][evPos][2]);
		    cache_get_value_name(i, "evName", HouseInfo[hoID][evIsim],30);
		    cache_get_value_name_int(i, "MaksMobilya", HouseInfo[hoID][evMaksMobilya]);
		    cache_get_value_name_int(i, "Vergi", HouseInfo[hoID][evVergi]);
		    cache_get_value_name_int(i, "VergiSure", HouseInfo[hoID][evVergiSure]);
		    cache_get_value_name_int(i, "evInterior", HouseInfo[hoID][evInterior]);
		    cache_get_value_name_int(i, "evKilit", HouseInfo[hoID][evKilit]);
		    cache_get_value_name_int(i, "evPara", HouseInfo[hoID][evCash]);
		    cache_get_value_name_int(i, "evSatilik", HouseInfo[hoID][evSatilik]);
		    cache_get_value_name_int(i, "evKiralik", HouseInfo[hoID][evKiralik]);
		    cache_get_value_name_int(i, "evKiraUcret", HouseInfo[hoID][evKiraUcret]);
		    cache_get_value_name_int(i, "evKiralayan", HouseInfo[hoID][evKiralayan]);
		    cache_get_value_name_int(i, "Uyusturucu", HouseInfo[hoID][evUyusturucu]);
		    cache_get_value_name_int(i, "MobilyaYetki", HouseInfo[hoID][MobilyaYetki]);

			for (new j = 0; j < 10; j ++)
		    {
		        if (j < 5)
		        {
		            format(str, 24, "evKiyafet%d", j + 1);
		            cache_get_value_name_int(i, str, HouseInfo[hoID][evKiyafetler][j]);
		        }
		        format(str, 24, "evWeapon%d", j + 1);
		        cache_get_value_name_int(i, str, HouseInfo[hoID][evSilahlar][j]);

		        format(str, 24, "evAmmo%d", j + 1);
		        cache_get_value_name_int(i, str, HouseInfo[hoID][evMermiler][j]);
		    }
		}
		for (new i = 0; i < MAX_EV; i ++) if (HouseInfo[i][evExists])
		{
		    format(str, sizeof(str), "SELECT * FROM `furniture` WHERE `ID` = '%d'", HouseInfo[i][evID]);

			mysql_tquery(g_SQL, str, "OnLoadFurniture", "d", i);
			Ev_Yenile(i);
		}
	}
	return 1;
}

forward OnLoadFurniture(houseid);
public OnLoadFurniture(houseid)
{
	static
	    rows,
		id = -1;

	cache_get_row_count(rows);

	for (new i = 0; i != rows; i ++)
	{
		id = Iter_Free(Mobilyalar[houseid]);
		cache_get_value_name_int(i, "furnitureID",FurnitureData[houseid][id][furnitureID]);
		cache_get_value_name(i, "furnitureName",FurnitureData[houseid][id][furnitureName],32);
		cache_get_value_name_int(i, "furnitureModel",FurnitureData[houseid][id][furnitureModel]);
		cache_get_value_name_int(i, "MateryalDesen1",FurnitureData[houseid][id][furnitureMateryalDesen][0]);
		cache_get_value_name_int(i, "MateryalDesen2",FurnitureData[houseid][id][furnitureMateryalDesen][1]);
		cache_get_value_name_int(i, "MateryalDesen3",FurnitureData[houseid][id][furnitureMateryalDesen][2]);
		cache_get_value_name_int(i, "MateryalDesen4",FurnitureData[houseid][id][furnitureMateryalDesen][3]);
		cache_get_value_name_int(i, "MateryalDesen5",FurnitureData[houseid][id][furnitureMateryalDesen][4]);
		cache_get_value_name_float(i, "furnitureX",FurnitureData[houseid][id][furniturePos][0]);
		cache_get_value_name_float(i, "furnitureY",FurnitureData[houseid][id][furniturePos][1]);
		cache_get_value_name_float(i, "furnitureZ",FurnitureData[houseid][id][furniturePos][2]);
		cache_get_value_name_float(i, "furnitureRX",FurnitureData[houseid][id][furnitureRot][0]);
		cache_get_value_name_float(i, "furnitureRY",FurnitureData[houseid][id][furnitureRot][1]);
		cache_get_value_name_float(i, "furnitureRZ",FurnitureData[houseid][id][furnitureRot][2]);
		cache_get_value_name_int(i, "furniturePrice",FurnitureData[houseid][id][furniturePrice]);
		Iter_Add(Mobilyalar[houseid], id);
	    Furniture_Refresh(id, houseid);
	}
	return 1;
}
forward GateleriYukle();
public GateleriYukle()
{
	mysql_query(g_SQL, "SELECT * FROM `gates`");

	new rows = cache_num_rows();

	printf("» Toplam %d gate yüklendi. ", rows);

	if (rows)
	{
	    new gtID;
		for (new i = 0; i < rows; i ++)
		{
		    cache_get_value_name_int(i, "gateID", gtID);

		    GateData[gtID][gateExists] = true;
		    GateData[gtID][gateOpened] = false;

		    GateData[gtID][gateID] = gtID;

		    cache_get_value_name_int(i, "gateModel", GateData[gtID][gateModel]);
		    cache_get_value_name_float(i, "gateSpeed", GateData[gtID][gateSpeed]);
		    cache_get_value_name_float(i, "gateRadius", GateData[gtID][gateRadius]);
		    cache_get_value_name_int(i, "gateInterior", GateData[gtID][gateInterior]);
		    cache_get_value_name_int(i, "gateWorld", GateData[gtID][gateWorld]);
		    cache_get_value_name_float(i, "gateX", GateData[gtID][gatePos][0]);
		    cache_get_value_name_float(i, "gateY", GateData[gtID][gatePos][1]);
		    cache_get_value_name_float(i, "gateZ", GateData[gtID][gatePos][2]);
		    cache_get_value_name_float(i, "gateRX", GateData[gtID][gatePos][3]);
		    cache_get_value_name_float(i, "gateRY", GateData[gtID][gatePos][4]);
		    cache_get_value_name_float(i, "gateRZ", GateData[gtID][gatePos][5]);
		    cache_get_value_name_float(i, "gateMoveX", GateData[gtID][gateMove][0]);
		    cache_get_value_name_float(i, "gateMoveY", GateData[gtID][gateMove][1]);
		    cache_get_value_name_float(i, "gateMoveZ", GateData[gtID][gateMove][2]);
		    cache_get_value_name_float(i, "gateMoveRX", GateData[gtID][gateMove][3]);
		    cache_get_value_name_float(i, "gateMoveRY", GateData[gtID][gateMove][4]);
		    cache_get_value_name_float(i, "gateMoveRZ", GateData[gtID][gateMove][5]);
		    cache_get_value_name_int(i, "gateLinkID", GateData[gtID][gateLinkID]);
		    cache_get_value_name_int(i, "gateFaction", GateData[gtID][gateFaction]);
		    cache_get_value_name_int(i, "gateOwner", GateData[gtID][gateOwner]);
		    cache_get_value_name(i, "gatePass", GateData[gtID][gatePass], 32);
			cache_get_value_name_int(i, "VIP", GateData[gtID][gateVip]);

	     	GateData[gtID][gateObject] = CreateDynamicObject(GateData[gtID][gateModel], GateData[gtID][gatePos][0], GateData[gtID][gatePos][1], GateData[gtID][gatePos][2], GateData[gtID][gatePos][3], GateData[gtID][gatePos][4], GateData[gtID][gatePos][5], GateData[gtID][gateWorld], GateData[gtID][gateInterior]);
		}
	}
	return 1;
}
forward DroppedWeapons_Load();
public DroppedWeapons_Load()
{
    mysql_query(g_SQL, "SELECT * FROM `droppedWeapons`");

	new rows = cache_num_rows();

    printf("» Toplam %d yere atýlan silah yüklendi.",rows);

	if (rows)
	{
		new str[50], dpID;
	    for (new i = 0; i < rows; i ++) if (i < MAX_DROPPED_WEAPONS)
	    {
	        cache_get_value_name_int(i, "dID", dpID);

	        DroppedWeapon[dpID][droppedExists] = true;
	        DroppedWeapon[dpID][droppedID] = dpID;

	        cache_get_value_name_int(i, "dPlayer",   DroppedWeapon[dpID][droppedPlayer]);
	        cache_get_value_name_float(i, "dropX",   DroppedWeapon[dpID][droppedPos][0]);
	        cache_get_value_name_float(i, "dropY",   DroppedWeapon[dpID][droppedPos][1]);
	        cache_get_value_name_float(i, "dropZ",   DroppedWeapon[dpID][droppedPos][2]);
	        cache_get_value_name_int(i, "dInterior", DroppedWeapon[dpID][droppedInt]);
	        cache_get_value_name_int(i, "dVw",       DroppedWeapon[dpID][droppedVw]);
	        cache_get_value_name_int(i, "dWeapon",   DroppedWeapon[dpID][droppedWeapon]);
	        cache_get_value_name_int(i, "dAmmo",     DroppedWeapon[dpID][droppedAmmo]);

	        DroppedWeapon[dpID][droppedObject] = CreateDynamicObject(GetWeaponModel(DroppedWeapon[dpID][droppedWeapon]), DroppedWeapon[dpID][droppedPos][0], DroppedWeapon[dpID][droppedPos][1], DroppedWeapon[dpID][droppedPos][2], 93.7, 120.0, 120.0, DroppedWeapon[dpID][droppedInt], DroppedWeapon[dpID][droppedVw]);
	        format(str, sizeof(str), "%s (Mermi: %d)", ReturnWeaponName(DroppedWeapon[dpID][droppedWeapon]), DroppedWeapon[dpID][droppedAmmo]);
	        DroppedWeapon[dpID][droppedText] = CreateDynamic3DTextLabel(str, COLOR_LIGHTBLUE, DroppedWeapon[dpID][droppedPos][0], DroppedWeapon[dpID][droppedPos][1], DroppedWeapon[dpID][droppedPos][2], 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, DroppedWeapon[dpID][droppedVw], DroppedWeapon[dpID][droppedInt]);
	    }
    }
    return 1;
}

forward UyusturucuSaticilariniYukle();
public UyusturucuSaticilariniYukle()
{
	new rows = cache_num_rows();

	printf("» Toplam %d uyuþturucu satýcýsý yüklendi.", rows);

	if (rows)
	{
	    new uyID, str[256];

	    for (new i = 0; i < rows; i++)
	    {
	        cache_get_value_name_int(i, "ID", uyID);

            DealerData[uyID][dealerID] = uyID;

            cache_get_value_name_int(i, "Skin", DealerData[uyID][dealerSkin]);
            cache_get_value_name_int(i, "Uyusturucu", DealerData[uyID][dealerDrugs]);
            cache_get_value_name_int(i, "VirtualWorld", DealerData[uyID][dealerVw]);

            cache_get_value_name(i, "Pos", str);

            sscanf(str, "p<|>ffff", DealerData[uyID][dealerX], DealerData[uyID][dealerY], DealerData[uyID][dealerZ], DealerData[uyID][dealerA]);

            DealerData[uyID][dealerActorID] = CreateActor(DealerData[uyID][dealerSkin], DealerData[uyID][dealerX], DealerData[uyID][dealerY], DealerData[uyID][dealerZ], DealerData[uyID][dealerA]);
            SetActorInvulnerable(DealerData[uyID][dealerActorID], 1);
            SetActorVirtualWorld(DealerData[uyID][dealerActorID], DealerData[uyID][dealerVw]);

			format(str, sizeof str, "Uyuþturucu Satýcýsý (%d)\n\n{FFFFFF}{F1C40F}ALT {FFFFFF}tuþuna basarak etkileþime geçebilirsiniz.", DealerData[uyID][dealerID]);
			DealerData[uyID][dealerLabel] = CreateDynamic3DTextLabel(str, 0xF1C40FFF, DealerData[uyID][dealerX], DealerData[uyID][dealerY], DealerData[uyID][dealerZ] + 0.25, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);

            Iter_Add(Dealers, uyID);
		}
	}
	return 1;
}
forward Objeleri_Yukle();
public Objeleri_Yukle()
{
    static rows, fields, mesaj[128];
	cache_get_row_count(rows);
	cache_get_field_count(fields);

	for (new i = 0; i < rows; i ++) if(i < MAX_OBJE)
	{
	    Obje[i][objeKullanimda] = true;
/*	    Obje[i][objeID] = cache_get_value_name_int(i, "objeID");
	    Obje[i][objeModelID] = cache_get_value_name_int(i, "objeModel");
	    Obje[i][objeData] = cache_get_value_name_int(i, "objeData");
	    Obje[i][objePos][0] = cache_get_value_name_float(i, "objeX");
	    Obje[i][objePos][1] = cache_get_value_name_float(i, "objeY");
	    Obje[i][objePos][2] = cache_get_value_name_float(i, "objeZ");
	    Obje[i][objePos][3] = cache_get_value_name_float(i, "objeRX");
	    Obje[i][objePos][4] = cache_get_value_name_float(i, "objeRY");
	    Obje[i][objePos][5] = cache_get_value_name_float(i, "objeRZ");*/
	    cache_get_value_name_int(i, "objeID", Obje[i][objeID]);
	    cache_get_value_name_int(i, "objeData", Obje[i][objeData]);
	    cache_get_value_name_int(i, "objeModel", Obje[i][objeModelID]);
	    cache_get_value_name_float(i, "objeX", Obje[i][objePos][0]);
	    cache_get_value_name_float(i, "objeY", Obje[i][objePos][1]);
	    cache_get_value_name_float(i, "objeZ", Obje[i][objePos][2]);
	    cache_get_value_name_float(i, "objeRX", Obje[i][objePos][3]);
	    cache_get_value_name_float(i, "objeRY", Obje[i][objePos][4]);
	    cache_get_value_name_float(i, "objeRZ", Obje[i][objePos][5]);

	    Obje[i][objeData] = CreateDynamicObject(Obje[i][objeModelID], Obje[i][objePos][0], Obje[i][objePos][1], Obje[i][objePos][2], Obje[i][objePos][3], Obje[i][objePos][4], Obje[i][objePos][5], -1, -1, -1, STREAMER_OBJECT_SD, STREAMER_OBJECT_DD, -1, 0);
	}
	if(rows < 1) {
	    format(mesaj, sizeof(mesaj), "[!] 0 adet obje yüklendi.");
	}
	else if(rows > 0) {
		format(mesaj, sizeof(mesaj), "[!] %d adet obje yüklendi.", rows);
	}
	printf(mesaj);
	return 1;
}

forward GiseleriYukle();
public GiseleriYukle()
{
	new rows = cache_num_rows();

	printf("» Toplam %d giþe yüklendi.", rows);

	if (rows)
	{
		new gisID, str[512];

		for (new i = 0; i < rows; i++)
		{
		    cache_get_value_name_int(i, "ID", gisID);

		    Gise[gisID][gs_Exists] = true;
		    Gise[gisID][gs_ID] = gisID;

		    Gise[gisID][gs_Durum] = GISE_KAPALI;

		    cache_get_value_name(i, "GatePos", str, sizeof str);
		    sscanf(str, "p<|>ffffff", Gise[gisID][gs_GateBar][0], Gise[gisID][gs_GateBar][1], Gise[gisID][gs_GateBar][2], Gise[gisID][gs_GateBar][3], Gise[gisID][gs_GateBar][4], Gise[gisID][gs_GateBar][5]);

			cache_get_value_name(i, "KapaliPos", str, sizeof str);
		    sscanf(str, "p<|>ffffff", Gise[gisID][gs_Kapali][0], Gise[gisID][gs_Kapali][1], Gise[gisID][gs_Kapali][2], Gise[gisID][gs_Kapali][3], Gise[gisID][gs_Kapali][4], Gise[gisID][gs_Kapali][5]);

            cache_get_value_name(i, "AcikPos", str, sizeof str);
		    sscanf(str, "p<|>ffffff", Gise[gisID][gs_Acik][0], Gise[gisID][gs_Acik][1], Gise[gisID][gs_Acik][2], Gise[gisID][gs_Acik][3], Gise[gisID][gs_Acik][4], Gise[gisID][gs_Acik][5]);

			Gise[gisID][gs_GateObje] = CreateDynamicObject(966, Gise[gisID][gs_GateBar][0], Gise[gisID][gs_GateBar][1], Gise[gisID][gs_GateBar][2], Gise[gisID][gs_GateBar][3], Gise[gisID][gs_GateBar][4], Gise[gisID][gs_GateBar][5]);
			Gise[gisID][gs_Obje] = CreateDynamicObject(968, Gise[gisID][gs_Kapali][0], Gise[gisID][gs_Kapali][1], Gise[gisID][gs_Kapali][2], Gise[gisID][gs_Kapali][3], Gise[gisID][gs_Kapali][4], Gise[gisID][gs_Kapali][5]);

            new Float:ortaKoord[2];

			GetXYInFrontOfToll(Gise[i][gs_GateObje], ortaKoord[0], ortaKoord[1], 3.5);

            format(str, sizeof str, "(%d) [Y tuþu]", Gise[i][gs_ID]);
			Gise[i][gs_id] = CreateDynamic3DTextLabel(str, 0xA5A5A5AA, Gise[i][gs_GateBar][0], Gise[i][gs_GateBar][1], Gise[i][gs_GateBar][2]+0.5, 20.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, -1, -1, STREAMER_3D_TEXT_LABEL_SD, -1, 0);
		}
	}

	return 1;
}

forward AraclariYukle();
public AraclariYukle()
{
	mysql_query(g_SQL, "SELECT * FROM `araclar`");
	new rows = cache_num_rows(), aID;

	printf("» Toplam %d araç yüklendi.", rows);

	for (new i = 0; i < rows; i ++)
	{
	    cache_get_value_name_int(i, "aracid",  aID);

	    AracInfo[aID][aracID] = aID;

	    AracInfo[aID][aracExists] = true;

	    cache_get_value_name_int(i, "aracmodel", AracInfo[aID][aracModel]);
	    cache_get_value_name_int(i, "aracowner", AracInfo[aID][aracSahip]);
	    cache_get_value_name_float(i, "aracPosX", AracInfo[aID][aracPos][0]);
	    cache_get_value_name_float(i, "aracPosY", AracInfo[aID][aracPos][1]);
	    cache_get_value_name_float(i, "aracPosZ", AracInfo[aID][aracPos][2]);
	    cache_get_value_name_float(i, "aracPosR", AracInfo[aID][aracPos][3]);
	    cache_get_value_name_int(i, "aracrenk1", AracInfo[aID][aracRenkler][0]);
	    cache_get_value_name_int(i, "aracrenk2", AracInfo[aID][aracRenkler][1]);
	    cache_get_value_name_int(i, "aracpaintjob", AracInfo[aID][aracPaintjob]);
		cache_get_value_name_int(i, "arackilit", AracInfo[aID][aracKilit]);
     	cache_get_value_name_int(i, "aracvergi", AracInfo[aID][aracVergi]);
     	cache_get_value_name_int(i, "VergiSure", AracInfo[aID][aracVergiSure]);
     	cache_get_value_name_int(i, "aracbaglandi", AracInfo[aID][aracBaglandi]);
     	cache_get_value_name_int(i, "aracbaglandiceza", AracInfo[aID][aracBaglandiCeza]);
     	cache_get_value_name_int(i, "Interior", AracInfo[aID][aracInterior]);
     	cache_get_value_name_int(i, "World", AracInfo[aID][aracWorld]);
     	cache_get_value_name_int(i, "Ceza", AracInfo[aID][aracTicket]);
     	cache_get_value_name_int(i, "CezaSure", AracInfo[aID][aracTicketTime]);
     	cache_get_value_name_int(i, "ElKonuldu", AracInfo[aID][aracElKonuldu]);
     	cache_get_value_name_int(i, "aracfaction", AracInfo[aID][aracFaction]);
     	cache_get_value_name_int(i, "aracfactiontype", AracInfo[aID][aracFactionType]);
     	cache_get_value_name_int(i, "arackira", AracInfo[aID][aracKira]);
    	cache_get_value_name_int(i, "aractip", AracInfo[aID][aracTip]);
    	cache_get_value_name_int(i, "aracsatilik", AracInfo[aID][aracSatilik]);
    	cache_get_value_name(i, "aracplaka", AracInfo[aID][aracPlaka], 24);
    	cache_get_value_name_int(i, "aracfiyat", AracInfo[aID][aracFiyat]);
    	cache_get_value_name_int(i, "uyusturucu", AracInfo[aID][aracUyusturucu]);
    	cache_get_value_name_float(i, "arackm", AracInfo[aID][aracKM]);
    	cache_get_value_name_float(i, "aracbenzin", AracInfo[aID][aracBenzin]);
    	cache_get_value_name_int(i, "Zirh", AracInfo[aID][aracZirh]);
    	cache_get_value_name_int(i, "ZirhVarMi", AracInfo[aID][aracZirhVarMi]);
    	cache_get_value_name_int(i, "Garaj", AracInfo[aID][aracGaraj]);
    	cache_get_value_name_int(i, "TaksiPlaka", AracInfo[aID][TaksiPlaka]);
    	cache_get_value_name_int(i, "aracseviye", AracInfo[aID][aracSeviye]);

		cache_get_value_name_int(i, "aracMod1", AracInfo[aID][aracMods][0]);
		cache_get_value_name_int(i, "aracMod2", AracInfo[aID][aracMods][1]);
		cache_get_value_name_int(i, "aracMod3", AracInfo[aID][aracMods][2]);
		cache_get_value_name_int(i, "aracMod4", AracInfo[aID][aracMods][3]);
		cache_get_value_name_int(i, "aracMod5", AracInfo[aID][aracMods][4]);
		cache_get_value_name_int(i, "aracMod6", AracInfo[aID][aracMods][5]);
		cache_get_value_name_int(i, "aracMod7", AracInfo[aID][aracMods][6]);
		cache_get_value_name_int(i, "aracMod8", AracInfo[aID][aracMods][7]);
		cache_get_value_name_int(i, "aracMod9", AracInfo[aID][aracMods][8]);
		cache_get_value_name_int(i, "aracMod10", AracInfo[aID][aracMods][9]);
		cache_get_value_name_int(i, "aracMod11", AracInfo[aID][aracMods][10]);
		cache_get_value_name_int(i, "aracMod12", AracInfo[aID][aracMods][11]);
		cache_get_value_name_int(i, "aracMod13", AracInfo[aID][aracMods][12]);
		cache_get_value_name_int(i, "aracMod14", AracInfo[aID][aracMods][13]);

		cache_get_value_name_int(i, "aracSilah1", AracInfo[aID][aracSilahlar][0]);
		cache_get_value_name_int(i, "aracSilah2", AracInfo[aID][aracSilahlar][1]);
		cache_get_value_name_int(i, "aracSilah3", AracInfo[aID][aracSilahlar][2]);
		cache_get_value_name_int(i, "aracSilah4", AracInfo[aID][aracSilahlar][3]);
		cache_get_value_name_int(i, "aracSilah5", AracInfo[aID][aracSilahlar][4]);

		cache_get_value_name_int(i, "aracMermi1", AracInfo[aID][aracMermiler][0]);
		cache_get_value_name_int(i, "aracMermi2", AracInfo[aID][aracMermiler][1]);
		cache_get_value_name_int(i, "aracMermi3", AracInfo[aID][aracMermiler][2]);
		cache_get_value_name_int(i, "aracMermi4", AracInfo[aID][aracMermiler][3]);
		cache_get_value_name_int(i, "aracMermi5", AracInfo[aID][aracMermiler][4]);

	    AracInfo[aID][aracKiralayan] = -1;

		Arac_Spawn(AracInfo[aID][aracID]);
	}
	return 1;
}
forward objyukleniyor(playerid);
public objyukleniyor(playerid)
{
	TextDrawHideForPlayer(playerid,TDEditor_TD[1]);
    TogglePlayerControllable(playerid,true);
    SetPVarInt(playerid, "KOSKorumasi", 0);
    TextDrawShowForPlayer(playerid, TDEditor_TD[0]);
    SetTimerEx("objeyuklendi",1000,false, "i",playerid);
	return 1;
}
forward objeyuklendi(playerid);
public objeyuklendi(playerid)
{
	TextDrawHideForPlayer(playerid,TDEditor_TD[0]);
	Spawned[playerid] = 1;
	return 1;
}
forward infoyukleniyor(playerid);
public infoyukleniyor(playerid)
{
    TextDrawHideForPlayer(playerid, infohud);
	TextDrawHideForPlayer(playerid, infohud);
    return 1;
}
forward GarajlariYukle();
public GarajlariYukle()
{
    mysql_query(g_SQL, "SELECT * FROM `garajlar`");

	new rows = cache_num_rows();

    printf("» Toplam %d garaj yüklendi.", rows);

    if (rows)
    {
        new grID;
	    for (new i = 0; i < rows; i ++)
	    {
	        cache_get_value_name_int(i, "ID", grID);

	        GarageData[grID][gExists] = true;
	        GarageData[grID][gID] = grID;

	        cache_get_value_name_int(i, "Kilit", GarageData[grID][gKilit]);
	        cache_get_value_name(i, "Sifre", GarageData[grID][gSifre], 30);
	        cache_get_value_name_int(i, "Birlik", GarageData[grID][gBirlik]);
	        cache_get_value_name_int(i, "Sahip", GarageData[grID][gSahip]);
	        cache_get_value_name_float(i, "garageX", GarageData[grID][gPos][0]);
	        cache_get_value_name_float(i, "garageY", GarageData[grID][gPos][1]);
	        cache_get_value_name_float(i, "garageZ", GarageData[grID][gPos][2]);
	        cache_get_value_name_int(i, "VirtualWorld", GarageData[grID][gVw]);
	        cache_get_value_name_int(i, "interior", GarageData[grID][gInterior]);
	        cache_get_value_name_int(i, "parkdurum", GarageData[grID][gParkDurum]);
	        cache_get_value_name(i, "Tip", GarageData[grID][gTip], 20);
	        cache_get_value_name_int(i, "AracLimit", GarageData[grID][gAracLimit]);
	    }

	    for (new i; i < MAX_GARAGE; i++) if (GarageData[i][gExists] == true)
	    {
	        Garaj_Yenile(GarageData[i][gID]);
	    }
    }
	return 1;
}
forward BinalariYukle();
public BinalariYukle()
{
    mysql_query(g_SQL, "SELECT * FROM `entrances`");

	new rows = cache_num_rows();
	printf("» Toplam %d bina yüklendi.", rows);

	if (rows)
	{
	    new entID;
	    for (new i = 0; i < rows; i ++)
	    {
	        cache_get_value_name_int(i, "entranceID", entID);

	        EntranceData[entID][entranceExists] = true;
	        EntranceData[entID][entranceID] = entID;

	        cache_get_value_name(i, "entranceName", EntranceData[entID][entranceName], 32);
	        cache_get_value_name(i, "entrancePass", EntranceData[entID][entrancePass], 32);
	        cache_get_value_name_int(i, "entranceIcon", EntranceData[entID][entranceIcon]);
	        cache_get_value_name_int(i, "entrancepIcon", EntranceData[entID][entrancepIcon]);
	        cache_get_value_name_int(i, "entranceLocked", EntranceData[entID][entranceLocked]);
	        cache_get_value_name_int(i, "entranceInteriorVw", EntranceData[entID][entranceInteriorVw]);
	        cache_get_value_name_int(i, "entranceBaglanti", EntranceData[entID][entranceBaglanti]);
	        cache_get_value_name_float(i, "entrancePosX", EntranceData[entID][entrancePos][0]);
	        cache_get_value_name_float(i, "entrancePosY", EntranceData[entID][entrancePos][1]);
	        cache_get_value_name_float(i, "entrancePosZ", EntranceData[entID][entrancePos][2]);
			cache_get_value_name_float(i, "entrancePosA", EntranceData[entID][entrancePos][3]);
			cache_get_value_name_float(i, "entranceIntX", EntranceData[entID][entranceInt][0]);
			cache_get_value_name_float(i, "entranceIntY", EntranceData[entID][entranceInt][1]);
			cache_get_value_name_float(i, "entranceIntZ", EntranceData[entID][entranceInt][2]);
			cache_get_value_name_float(i, "entranceIntA", EntranceData[entID][entranceInt][3]);
			cache_get_value_name_int(i, "entranceInterior", EntranceData[entID][entranceInterior]);
			cache_get_value_name_int(i, "entranceExterior", EntranceData[entID][entranceExterior]);
			cache_get_value_name_int(i, "entranceExteriorVW", EntranceData[entID][entranceExteriorVW]);
			cache_get_value_name_int(i, "evip", EntranceData[entID][eVip]);

	        Entrance_Refresh(EntranceData[entID][entranceID]);
	    }
    }
    return 1;
}
forward Login(playerid);
public Login(playerid)
{
	new rows = cache_num_rows();

	new string[512], baslik[64];

	if (!rows)
	{
	    if (GetPVarInt(playerid, "wrongpass") >= 5)
		{
		    new sqlid = GetPlayerSQLIDWithName(ReturnName(playerid));
		    BildirimEkle(sqlid, "Hesabýnýza girilmeye çalýþýldý. Birileri hesabýnýza girmek istiyor olabilir.", "Sistem");
		    HataMesajGonder(playerid, "5 defa yanlýþ þifre girdiðiniz için atýldýnýz.");
			return Kick(playerid);
		}

	    SetPVarInt(playerid, "wrongpass", GetPVarInt(playerid, "wrongpass") +1);

		HataMesajGonder(playerid, "Yanlýþ þifre girdiniz. (%d / 5 )", GetPVarInt(playerid, "wrongpass"));
		format(baslik, sizeof baslik, "{ffffff}Doðrulama - %s", ReturnName(playerid, 0));
	    format(string, sizeof string, "{FFFFFF}Regular Roleplay'a tekrardan hoþgeldin, {C3C3C3}%s.\n\n{FFFFFF}Bu hesabýn sana ait olduðunu duðrulayabilmemiz için lütfen\nþifrenini gir.\n\n{ff0000}Yanlýþ þifre girdiniz, tekrar deneyiniz.",ReturnName(playerid,0),ReturnName(playerid,0));
		Dialog_Show(playerid, Giris, DIALOG_STYLE_PASSWORD, baslik, string, "Doðrula", "Iptal");
		SetTimerEx("Tut1", 2000, false, "i", playerid);
	}
 	if(rows)
	{
	    cache_get_value_name_int(0, "ID",PlayerData[playerid][pID]);
	    cache_get_value_name_int(0, "Yas",PlayerData[playerid][pYas]);
	    cache_get_value_name_int(0, "Cinsiyet",PlayerData[playerid][pCinsiyet]);
	    cache_get_value_name(0, "DogumYeri",PlayerData[playerid][pDogum], 30);
	    cache_get_value_name_int(0, "TenRengi",PlayerData[playerid][pTen]);
	    cache_get_value_name_int(0, "Kelepce", PlayerData[playerid][pKelepce]);
	    cache_get_value_name_int(0, "SirketID", PlayerData[playerid][pSirketID]);

	    for(new i = 0; i != MAX_ISYERI; i++)
	    {
	    	if(sirketData[i][sirketID] == PlayerData[playerid][pSirketID])
	    		PlayerData[playerid][pSirket] = i;
	    }

	    cache_get_value_name_int(0, "SirketRank", PlayerData[playerid][pSirketRank]);
	    cache_get_value_name_int(0, "SirketMaas", PlayerData[playerid][pSirketMaas]);
	    cache_get_value_name(0, "Yemler", string);

	    cache_get_value_name_int(0, "Skin",PlayerData[playerid][pSkin]);
	    cache_get_value_name_int(0, "CikisInt",PlayerData[playerid][pCikisInt]);
	    cache_get_value_name_float(0, "CikisX",PlayerData[playerid][pCikisPos][0]);
	    cache_get_value_name_float(0, "CikisY",PlayerData[playerid][pCikisPos][1]);
	    cache_get_value_name_float(0, "CikisZ",PlayerData[playerid][pCikisPos][2]);
	    cache_get_value_name_int(0, "CikisWorld",PlayerData[playerid][pCikisVw]);
	    cache_get_value_name_int(0, "AdminLevel",PlayerData[playerid][pAdmin]);
	    cache_get_value_name_int(0, "Helper",PlayerData[playerid][pHelper]);
	    cache_get_value_name_int(0, "oyungorevlisi",PlayerData[playerid][pOyunGorevlisi]);
	    cache_get_value_name_int(0, "forumgorevlisi",PlayerData[playerid][pForumGorevlisi]);
	    cache_get_value_name_int(0, "Cash",PlayerData[playerid][pCash]);
	    cache_get_value_name(0, "AdminName",PlayerData[playerid][pAdminName],24);
	    cache_get_value_name_int(0, "Ehliyet",PlayerData[playerid][pEhliyet]);
	    cache_get_value_name_int(0, "MotorEhliyet", PlayerData[playerid][pMotorEhliyet]);
	    cache_get_value_name_int(0, "SeferSayi", PlayerData[playerid][pSeferSayi]);
	    cache_get_value_name_int(0, "House",PlayerData[playerid][pHouse]);
	    cache_get_value_name_int(0, "Business",PlayerData[playerid][pIsyeri]);
	    cache_get_value_name_int(0, "Birlik",PlayerData[playerid][pFaction]);
	    cache_get_value_name_int(0, "BirlikRutbe",PlayerData[playerid][pFactionRutbe]);
	    cache_get_value_name_int(0, "BirlikDivizyon",PlayerData[playerid][pFactionDivizyon]);
	    cache_get_value_name_int(0, "Su",PlayerData[playerid][pSu]);
	    cache_get_value_name_float(0, "Health",PlayerData[playerid][pHealth]);
	    cache_get_value_name_float(0, "Armour",PlayerData[playerid][pArmour]);
	    cache_get_value_name_int(0, "OnDuty",PlayerData[playerid][pOnDuty]);
	    cache_get_value_name_int(0, "OnDutySkin",PlayerData[playerid][pOnDutySkin]);
	    cache_get_value_name_int(0, "Aranma",PlayerData[playerid][pAranma]);
	    cache_get_value_name_int(0, "Hapis",PlayerData[playerid][pHapis]);
	    cache_get_value_name_int(0, "HapisSure",PlayerData[playerid][pHapisSure]);
	    cache_get_value_name(0, "HapisSebep",PlayerData[playerid][pHapisSebep], 50);
	    cache_get_value_name(0, "HapiseAtan",PlayerData[playerid][pHapiseAtan], 24);
	    cache_get_value_name_int(0, "Telefon",PlayerData[playerid][pTelefon]);
	    cache_get_value_name_int(0, "Tarife",PlayerData[playerid][pTarife]);
	    cache_get_value_name_int(0, "KalanDK",PlayerData[playerid][pTarifeKalan][0]);
	    cache_get_value_name_int(0, "KalanSMS",PlayerData[playerid][pTarifeKalan][1]);
	    cache_get_value_name_int(0, "KalanNet",PlayerData[playerid][pTarifeKalan][2]);
	    cache_get_value_name_int(0, "TarifeSure",PlayerData[playerid][pTarifeSure]);
	    cache_get_value_name_int(0, "Bitcoin",PlayerData[playerid][pBitcoin]);
	    cache_get_value_name_int(0, "Boombox",PlayerData[playerid][pBoombox]);
	    cache_get_value_name_int(0, "Radyo",PlayerData[playerid][pRadyo]);
	    cache_get_value_name_int(0, "Frekans",PlayerData[playerid][pFrekans]);
	    cache_get_value_name_int(0, "Materyal", PlayerData[playerid][pMateryal]);
	    cache_get_value_name_int(0, "SilahHakki", PlayerData[playerid][pSilahHakki]);
	    cache_get_value_name_int(0, "SilahSuresi", PlayerData[playerid][pSilahSuresi]);
	    cache_get_value_name_int(0, "Parca0", PlayerData[playerid][pSilahParca][0]);
	    cache_get_value_name_int(0, "Parca1", PlayerData[playerid][pSilahParca][1]);
	    cache_get_value_name_int(0, "Parca2", PlayerData[playerid][pSilahParca][2]);
	    cache_get_value_name_int(0, "Level",PlayerData[playerid][pLevel]);
	    cache_get_value_name_int(0, "EXP",PlayerData[playerid][pEXP]);
	    cache_get_value_name_int(0, "MaasSure",PlayerData[playerid][pMaasSure]);
	    cache_get_value_name_int(0, "OynamaSaati",PlayerData[playerid][pOynamaSaati]);
	    cache_get_value_name_int(0, "Maas",PlayerData[playerid][pMaas]);
	    cache_get_value_name_int(0, "Dinle",PlayerData[playerid][pDinle]);
	    cache_get_value_name_int(0, "Zar", PlayerData[playerid][pEsyalar][0]);
	    cache_get_value_name_int(0, "Sigara", PlayerData[playerid][pEsyalar][1]);
	    cache_get_value_name_int(0, "ip", PlayerData[playerid][pEsyalar][2]);
	    cache_get_value_name_int(0, "GozBagi", PlayerData[playerid][pEsyalar][3]);
	    cache_get_value_name_int(0, "Maske", PlayerData[playerid][pEsyalar][4]);
	    cache_get_value_name_int(0, "BenzinKutusu", PlayerData[playerid][pEsyalar][5]);
	    cache_get_value_name_int(0, "Barbeku", PlayerData[playerid][pEsyalar][6]);
	    cache_get_value_name_int(0, "Kofte", PlayerData[playerid][pEsyalar][7]);
	    cache_get_value_name_int(0, "Tavuk", PlayerData[playerid][pEsyalar][8]);
	    cache_get_value_name_int(0, "Dana", PlayerData[playerid][pEsyalar][9]);
	    cache_get_value_name_int(0, "TamirKiti", PlayerData[playerid][pEsyalar][10]);
	    cache_get_value_name_int(0, "Cadir", PlayerData[playerid][pEsyalar][11]);
        cache_get_value_name_int(0, "KampAtes", PlayerData[playerid][pEsyalar][12]);
        cache_get_value_name_int(0, "Sarjor", PlayerData[playerid][pEsyalar][13]);
        cache_get_value_name_int(0, "YanKeski", PlayerData[playerid][pEsyalar][14]);
        cache_get_value_name_int(0, "Bagimlilik", PlayerData[playerid][pBagimlilik]);
        cache_get_value_name_int(0, "TasimacilikSeviye", PlayerData[playerid][pTasimacilikSeviye]);
       	cache_get_value_name_int(0, "TasimacilikSefer", PlayerData[playerid][pTasimacilikSefer]);
        cache_get_value_name_int(0, "Garage", PlayerData[playerid][pGarage]);
        cache_get_value_name_int(0, "Bakiye", PlayerData[playerid][pBakiye]);
        cache_get_value_name_int(0, "EXPBoost", PlayerData[playerid][pEXPBoost]);
        cache_get_value_name_int(0, "BalikOrani", PlayerData[playerid][pBalikOrani]);
        cache_get_value_name_int(0, "Vip", PlayerData[playerid][pVip]);
        cache_get_value_name_int(0, "VipSure", PlayerData[playerid][pVipSure]);
        cache_get_value_name_int(0, "DovusStili", PlayerData[playerid][pDovusStili]);
        cache_get_value_name_int(0, "MaskeID", PlayerData[playerid][pMaskeID]);
        cache_get_value_name_int(0, "MaskeHakki", PlayerData[playerid][pMaskeHakki]);
        cache_get_value_name_int(0, "Baygin", PlayerData[playerid][pBaygin]);
        cache_get_value_name_int(0, "BayginSure", PlayerData[playerid][pBayginSure]);
        cache_get_value_name_int(0, "Partner", PlayerData[playerid][pPartner]);
        cache_get_value_name_int(0, "Hediye", PlayerData[playerid][pHediye]);
        cache_get_value_name_int(0, "HediyeSaat", PlayerData[playerid][pHediyeSaat]);
        cache_get_value_name_int(0, "Youtuber", PlayerData[playerid][pYoutuber]);
        cache_get_value_name_int(0, "Oldurme", PlayerData[playerid][pOldurme]);
        cache_get_value_name_int(0, "Olme", PlayerData[playerid][pOlme]);
        cache_get_value_name_int(0, "TalepSayi", PlayerData[playerid][pTalepSayi]);
        cache_get_value_name_int(0, "CK", PlayerData[playerid][pCK]);
        cache_get_value_name_int(0, "portakaltohum", PlayerData[playerid][pTohumlar][0]);
        cache_get_value_name_int(0, "elmatohum", PlayerData[playerid][pTohumlar][1]);
        cache_get_value_name_int(0, "armuttohum", PlayerData[playerid][pTohumlar][2]);
        cache_get_value_name_int(0, "SilahAlmaSayisi", PlayerData[playerid][pSilahAlmaSayisi]);
        cache_get_value_name_int(0, "SilahAlma", PlayerData[playerid][pSilahAlma]);
        cache_get_value_name(0, "Ayarlar", string, 80);

        sscanf(string, "p<|>iiiiiiiiiiiiiii", PlayerData[playerid][pAyarlar][0], PlayerData[playerid][pAyarlar][1], PlayerData[playerid][pAyarlar][2], PlayerData[playerid][pAyarlar][3], PlayerData[playerid][pAyarlar][4], PlayerData[playerid][pAyarlar][5], PlayerData[playerid][pAyarlar][6],
	    PlayerData[playerid][pAyarlar][7], PlayerData[playerid][pAyarlar][8], PlayerData[playerid][pAyarlar][9], PlayerData[playerid][pAyarlar][10], PlayerData[playerid][pAyarlar][11], PlayerData[playerid][pAyarlar][12], PlayerData[playerid][pAyarlar][13], PlayerData[playerid][pAyarlar][14]);

	    cache_get_value_name(0, "ASlot1",string,45);
	    sscanf(string, "p<|>iiii", PlayerData[playerid][pASlot][0], PlayerData[playerid][pABone][0], PlayerData[playerid][pTSlot][0], PlayerData[playerid][pARenk][0]);

	    cache_get_value_name(0, "ASlot2",string,45);
	    sscanf(string, "p<|>iiii", PlayerData[playerid][pASlot][1], PlayerData[playerid][pABone][1], PlayerData[playerid][pTSlot][1], PlayerData[playerid][pARenk][1]);

	    cache_get_value_name(0, "ASlot3",string,45);
	    sscanf(string, "p<|>iiii", PlayerData[playerid][pASlot][2], PlayerData[playerid][pABone][2], PlayerData[playerid][pTSlot][2], PlayerData[playerid][pARenk][2]);

	    cache_get_value_name(0, "ASlot4",string,45);
	    sscanf(string, "p<|>iiii", PlayerData[playerid][pASlot][3], PlayerData[playerid][pABone][3], PlayerData[playerid][pTSlot][3], PlayerData[playerid][pARenk][3]);

	    cache_get_value_name(0, "ASlot5",string,45);
	    sscanf(string, "p<|>iiii", PlayerData[playerid][pASlot][4], PlayerData[playerid][pABone][4], PlayerData[playerid][pTSlot][4], PlayerData[playerid][pARenk][4]);

	    cache_get_value_name(0, "ASlot6",string,45);
	    sscanf(string, "p<|>iiii", PlayerData[playerid][pASlot][5], PlayerData[playerid][pABone][5], PlayerData[playerid][pTSlot][5], PlayerData[playerid][pARenk][5]);

	    cache_get_value_name(0, "ASlot7",string,45);
	    sscanf(string, "p<|>iiii", PlayerData[playerid][pASlot][6], PlayerData[playerid][pABone][6], PlayerData[playerid][pTSlot][6], PlayerData[playerid][pARenk][6]);

	    cache_get_value_name(0, "ASlot8",string,45);
	    sscanf(string, "p<|>iiii", PlayerData[playerid][pASlot][7], PlayerData[playerid][pABone][7], PlayerData[playerid][pTSlot][7], PlayerData[playerid][pARenk][7]);

	    cache_get_value_name(0, "ASlot9",string,45);
	    sscanf(string, "p<|>iiii", PlayerData[playerid][pASlot][8], PlayerData[playerid][pABone][8], PlayerData[playerid][pTSlot][8], PlayerData[playerid][pARenk][8]);

	    cache_get_value_name(0, "ASlot10",string,45);
	    sscanf(string, "p<|>iiii", PlayerData[playerid][pASlot][9], PlayerData[playerid][pABone][9], PlayerData[playerid][pTSlot][9], PlayerData[playerid][pARenk][9]);

	    cache_get_value_name(0, "ASlot1Pos", string, 100);
		sscanf(string, "p<|>fffffffff", AksesuarData[playerid][0][0], AksesuarData[playerid][0][1], AksesuarData[playerid][0][2], AksesuarData[playerid][0][3], AksesuarData[playerid][0][4], AksesuarData[playerid][0][5], AksesuarData[playerid][0][6], AksesuarData[playerid][0][7], AksesuarData[playerid][0][8]);

        cache_get_value_name(0, "ASlot2Pos", string, 100);
		sscanf(string, "p<|>fffffffff", AksesuarData[playerid][1][0], AksesuarData[playerid][1][1], AksesuarData[playerid][1][2], AksesuarData[playerid][1][3], AksesuarData[playerid][1][4], AksesuarData[playerid][1][5], AksesuarData[playerid][1][6], AksesuarData[playerid][1][7], AksesuarData[playerid][1][8]);

		cache_get_value_name(0, "ASlot3Pos", string, 100);
		sscanf(string, "p<|>fffffffff", AksesuarData[playerid][2][0], AksesuarData[playerid][2][1], AksesuarData[playerid][2][2], AksesuarData[playerid][2][3], AksesuarData[playerid][2][4], AksesuarData[playerid][2][5], AksesuarData[playerid][2][6], AksesuarData[playerid][2][7], AksesuarData[playerid][2][8]);

		cache_get_value_name(0, "ASlot4Pos", string, 100);
		sscanf(string, "p<|>fffffffff", AksesuarData[playerid][3][0], AksesuarData[playerid][3][1], AksesuarData[playerid][3][2], AksesuarData[playerid][3][3], AksesuarData[playerid][3][4], AksesuarData[playerid][3][5], AksesuarData[playerid][3][6], AksesuarData[playerid][3][7], AksesuarData[playerid][3][8]);

		cache_get_value_name(0, "ASlot5Pos", string, 100);
		sscanf(string, "p<|>fffffffff", AksesuarData[playerid][4][0], AksesuarData[playerid][4][1], AksesuarData[playerid][4][2], AksesuarData[playerid][4][3], AksesuarData[playerid][4][4], AksesuarData[playerid][4][5], AksesuarData[playerid][4][6], AksesuarData[playerid][4][7], AksesuarData[playerid][4][8]);

		cache_get_value_name(0, "ASlot6Pos", string, 100);
		sscanf(string, "p<|>fffffffff", AksesuarData[playerid][5][0], AksesuarData[playerid][5][1], AksesuarData[playerid][5][2], AksesuarData[playerid][5][3], AksesuarData[playerid][5][4], AksesuarData[playerid][5][5], AksesuarData[playerid][5][6], AksesuarData[playerid][5][7], AksesuarData[playerid][5][8]);

		cache_get_value_name(0, "ASlot7Pos", string, 100);
		sscanf(string, "p<|>fffffffff", AksesuarData[playerid][6][0], AksesuarData[playerid][6][1], AksesuarData[playerid][6][2], AksesuarData[playerid][6][3], AksesuarData[playerid][6][4], AksesuarData[playerid][6][5], AksesuarData[playerid][6][6], AksesuarData[playerid][6][7], AksesuarData[playerid][6][8]);

		cache_get_value_name(0, "ASlot8Pos", string, 100);
		sscanf(string, "p<|>fffffffff", AksesuarData[playerid][7][0], AksesuarData[playerid][7][1], AksesuarData[playerid][7][2], AksesuarData[playerid][7][3], AksesuarData[playerid][7][4], AksesuarData[playerid][7][5], AksesuarData[playerid][7][6], AksesuarData[playerid][7][7], AksesuarData[playerid][7][8]);

		cache_get_value_name(0, "ASlot9Pos", string, 100);
		sscanf(string, "p<|>fffffffff", AksesuarData[playerid][8][0], AksesuarData[playerid][8][1], AksesuarData[playerid][8][2], AksesuarData[playerid][8][3], AksesuarData[playerid][8][4], AksesuarData[playerid][8][5], AksesuarData[playerid][8][6], AksesuarData[playerid][8][7], AksesuarData[playerid][8][8]);

		cache_get_value_name(0, "ASlot10Pos", string, 100);
		sscanf(string, "p<|>fffffffff", AksesuarData[playerid][9][0], AksesuarData[playerid][9][1], AksesuarData[playerid][9][2], AksesuarData[playerid][9][3], AksesuarData[playerid][9][4], AksesuarData[playerid][9][5], AksesuarData[playerid][9][6], AksesuarData[playerid][9][7], AksesuarData[playerid][9][8]);

	    for (new i; i<14; i++)
     	{
     	    if (i<13)
     	    {
          		format(string, sizeof(string), "Silah%d", i + 1);
            	cache_get_value_name_int(0,string,PlayerData[playerid][pSilahlar][i]);

				format(string, sizeof(string), "Mermi%d", i + 1);
    			cache_get_value_name_int(0,string,PlayerData[playerid][pMermiler][i]);
     	    }
      	}

      	for (new j; j<10; j++)
      	{
      	    format(string,sizeof(string), "Balik%d",j+1);
      	    cache_get_value_name_int(0,string,PlayerData[playerid][pBalikID][j]);

      	    format(string,sizeof(string), "BalikGram%d",j+1);
      	    cache_get_value_name_int(0,string,PlayerData[playerid][pBalikGram][j]);

      	}

      	if (!PlayerData[playerid][pSkin])
      	{
	      	if (PlayerData[playerid][pCinsiyet] == 1 && PlayerData[playerid][pTen] == 1)
			{
		   		PlayerData[playerid][pSkin] = 101;
			}
			if (PlayerData[playerid][pCinsiyet] == 1 && PlayerData[playerid][pTen] == 2)
			{
				PlayerData[playerid][pSkin] = 184;
			}
			if (PlayerData[playerid][pCinsiyet] == 2 && PlayerData[playerid][pTen] == 1)
			{
		   		PlayerData[playerid][pSkin] = 211;
			}
			if (PlayerData[playerid][pCinsiyet] == 2 && PlayerData[playerid][pTen] == 2)
			{
		   		PlayerData[playerid][pSkin] = 12;
			}
		}

      	format(string, sizeof(string), "SELECT * FROM `tickets` WHERE `ID` = '%d'", PlayerData[playerid][pID]);
       	mysql_tquery(g_SQL, string, "TicketLoad", "d", playerid);

       	for (new i = 0; i < 10; i++)
    		PlayerData[playerid][pTSlot][i] = false;

       	SetSpawnInfo(playerid, 0, PlayerData[playerid][pSkin], PlayerData[playerid][pCikisPos][0], PlayerData[playerid][pCikisPos][1], PlayerData[playerid][pCikisPos][2], 0.0, 0, 0, 0, 0, 0, 0);
    	SetPlayerScore(playerid, PlayerData[playerid][pLevel]);
      	EkranTemizle(playerid);
      	SetPlayerColor(playerid, COLOR_WHITE);

		SetPVarInt(playerid, "GirisYapti", 1);
	    SetPVarInt(playerid, "Logged", 0);

		TextDrawHideForPlayer(playerid, GirisTD);
  		TogglePlayerSpectating(playerid, 0);
		SpawnPlayer(playerid);
   		ResetPlayerMoney(playerid);
   		GivePlayerMoney(playerid,PlayerData[playerid][pCash]);
   		SetWeapons(playerid);
   		SetPVarInt(playerid, "Logged", 1);

   		SetPlayerVirtualWorld(playerid, PlayerData[playerid][pCikisVw]);
   		SetPlayerInterior(playerid, PlayerData[playerid][pCikisInt]);

		NT_Timer[playerid] = SetTimerEx("NT_Update", 500, true, "d", playerid);

		for (new i; i < 10; i++)
		{
			PlayerTextDrawShow(playerid, NitroHUD[playerid][i]);
		}

		mysql_format(g_SQL, string, sizeof string, "UPDATE `oyuncular` SET `LastIP` = '%s',`SonGiris` = '%s', `Oyunda` = '1' WHERE `ID` = '%d'",GetIP(playerid),ReturnDate(),PlayerData[playerid][pID]);
	    mysql_query (g_SQL, string);

	    mysql_format(g_SQL, string, sizeof(string), "SELECT ID FROM oyuncular WHERE ID = '%d' AND discord_id != '0'", PlayerData[playerid][pID]);
	    mysql_tquery(g_SQL, string, "DiscordKontrol", "d", playerid);
	}
	return 1;
}

forward DiscordKontrol(playerid);
public DiscordKontrol(playerid)
{
	new rows = cache_num_rows();

	if(!rows)
	{
		SendClientMessage(playerid, COLOR_YELLOW, "* Discord hesabýnýz oyun hesabýnýz ile iliþkilendirilmemiþ. Discord hesabýnýzý iliþkilendirmek için /discord yazýnýz.");
	}

	return 1;
}
forward TicketLoad(playerid);
public TicketLoad(playerid)
{
	new rows = cache_num_rows();
	if (rows)
	{
	    new ticID;
		for (new i = 0; i < rows && i < MAX_PLAYER_TICKETS; i ++)
		{
		    cache_get_value_name_int(i, "ticketID", ticID);

		    TicketData[playerid][ticID][ticketExists] = true;
		    TicketData[playerid][ticID][ticketID] = ticID;

		    cache_get_value_name_int(i, "ticketFee", TicketData[playerid][ticID][ticketFee]);
		    cache_get_value_name(i, "ticketDate", TicketData[playerid][ticID][ticketDate], 36);
		    cache_get_value_name(i, "ticketReason", TicketData[playerid][ticID][ticketReason], 64);
		    cache_get_value_name(i, "Memur", TicketData[playerid][ticID][ticketMemur], 24);
		}
	}
	return 1;
}
forward Giris_Yap(playerid);
public Giris_Yap(playerid)
{
	new query[256], baslik[64];

	mysql_format(g_SQL, query, sizeof query, "SELECT * FROM `oyuncular` WHERE `Isim` = '%s'", ReturnName(playerid));
	mysql_query (g_SQL, query);

	new rows = cache_num_rows();

	if (!rows)
	{
     	DeletePVar(playerid,"hata");
		new string[280];
		format(string,sizeof(string),"{FFFFFF}Regular Roleplay'a hoþgeldin, {898989}%s.{FFFFFF}\n\nHey, seni biraz bekleteceðim ama... Oyuna devam etmeden önce roleplay terimleri ile ilgili bilgini birazcýk sýnayacaðým.",ReturnName(playerid,1),ReturnName(playerid,1));
		ShowPlayerDialog(playerid,1,DIALOG_STYLE_MSGBOX,"{808080}Regular Quiz System ",string,"Devam","Iptal");
  		MesajGonder(playerid, "{808080}[Regular Quiz]: {FFFFFF}Devam etmeden önce testi baþarýyla hata yapmadan tamamlaman gerekiyor.");
  	}
	if (rows)
	{
	    EkranTemizle(playerid);

	    format(baslik, sizeof baslik, "{ffffff}Doðrulama - %s", ReturnName(playerid, 0));
		format(query, sizeof query, "{FFFFFF}Regular Roleplay'a tekrardan hoþgeldin, {898989}%s.\n\n{FFFFFF}Bu hesabýn sana ait olduðunu duðrulayabilmemiz için lütfen\nþifrenini gir.",ReturnName(playerid,0),ReturnName(playerid,0));

		Dialog_Show(playerid, Giris, DIALOG_STYLE_PASSWORD, baslik, query, "Doðrula", "Iptal");
	}
	return 1;
}
forward PlantGrowth(id);
public PlantGrowth(id)
{
    new label_string[128];
    PlantData[id][plantGrowth] += RandomEx(3, 7);
	if (PlantData[id][plantGrowth] >= PLANT_MAX_GROWTH)
	{
	    PlantData[id][plantGrowth] = PLANT_MAX_GROWTH;

		KillTimer(PlantData[id][plantTimer]);

	    PlantData[id][plantTimer] = SetTimerEx("PlantRot", ROT_INTERVAL * 1000, false, "i", id);

	    new percentage = Plant_GrowthPercentage(id);
        format(label_string, sizeof(label_string), "Yetiþmiþ Uyuþturucu Tohumu (%d)\n\n{FFFFFF}Yerleþtiren: %s\nBüyüme: {%06x}%d%%\n\n{FFFFFF}/uyusturucu [topla]", id, SQLName(PlantData[id][plantedBy], 0), (percentage < 25) ? 0xE74C3CFF >>> 8 : 0x2ECC71FF >>> 8, percentage);
		UpdateDynamic3DTextLabelText(PlantData[id][plantLabel], 0xF1C40FFF, label_string);

		SetDynamicObjectMaterial(PlantData[id][plantObj], 2, 2, "plants_TABLETOP", "CJ_PLANT", 0xFFD35400);
		new owner_id = GetPlayerIDWithSQLID(PlantData[id][plantedBy]);
    	if (owner_id != -1) BilgiMesajGonder(owner_id, "Yerleþtirdiðiniz uyuþturucu tohumu yetiþti, çürümeden önce onu topla!");
	}
	else
	{
	    new percentage = Plant_GrowthPercentage(id);

		if (!PlantData[id][gotLeaves] && percentage >= 25)
	    {
	        SetDynamicObjectMaterial(PlantData[id][plantObj], 2, 2, "plants_TABLETOP", "CJ_PLANT", 0xFF2ECC71);
	        PlantData[id][gotLeaves] = true;
		}

	    format(label_string, sizeof(label_string), "Uyuþturucu Tohumu (%d)\n\n{FFFFFF}Yerleþtiren: %s\nBüyüme: {%06x}%d%%\n\n{FFFFFF}/uyusturucu [topla]", id, SQLName(PlantData[id][plantedBy], 0), (percentage < 25) ? 0xE74C3CFF >>> 8 : 0x2ECC71FF >>> 8, percentage);
		UpdateDynamic3DTextLabelText(PlantData[id][plantLabel], 0xF1C40FFF, label_string);
	}
	return 1;
}

forward PlantRot(id);
public PlantRot(id)
{
    new owner_id = GetPlayerIDWithSQLID(PlantData[id][plantedBy]);
    if (owner_id != -1) BilgiMesajGonder(owner_id, "Ektiðiniz uyuþturucu tohumu çürüdü.");

    Plant_Destroy(id);
	return 1;
}

forward RegenHealth(playerid, amount);
public RegenHealth(playerid, amount)
{
	amount--;

	new Float: zirh;
	GetPlayerArmour(playerid, zirh);

	if (zirh + 2.5 < 95.0) ZirhAyarla(playerid, zirh + 2.5);
	if (amount > 0) {
		#if defined USE_DRUNKLEVEL
	    SetPlayerDrunkLevel(playerid, 4999);
		#endif

		RegenTimer[playerid] = SetTimerEx("RegenHealth", 500, false, "ii", playerid, amount);
	}else{
	    #if defined USE_DRUNKLEVEL
	    SetPlayerDrunkLevel(playerid, 0);
		#endif

	    if (RegenTimer[playerid] != -1)
		{
		    KillTimer(RegenTimer[playerid]);
		    RegenTimer[playerid] = -1;
		}
	}

	return 1;
}

forward RemoveEffects(playerid);
public RemoveEffects(playerid)
{
	#if defined USE_DRUNKLEVEL
	SetPlayerDrunkLevel(playerid, 0);
	#endif

	SetPlayerWeather(playerid, 10);
	if (EffectTimer[playerid] != -1)
	{
	    KillTimer(EffectTimer[playerid]);
	    EffectTimer[playerid] = -1;
	}

	return 1;
}
forward LoadBankers();
public LoadBankers()
{
	new rows = cache_num_rows();

	if (rows)
	{
	    new id, label_string[80];
	    for (new i; i < rows; i++)
		{
		    cache_get_value_name_int(i, "ID", id);
		    cache_get_value_name_int(i, "Skin", BankerData[id][Skin]);
		    cache_get_value_name_float(i, "PosX", BankerData[id][bankerX]);
		    cache_get_value_name_float(i, "PosY", BankerData[id][bankerY]);
		    cache_get_value_name_float(i, "PosZ", BankerData[id][bankerZ]);
		    cache_get_value_name_float(i, "PosA", BankerData[id][bankerA]);
		    cache_get_value_name_int(i, "Virtual", BankerData[id][bankerVw]);

		    BankerData[id][bankerActorID] = CreateActor(BankerData[id][Skin], BankerData[id][bankerX], BankerData[id][bankerY], BankerData[id][bankerZ], BankerData[id][bankerA]);

			if (!IsValidActor(BankerData[id][bankerActorID]))
			{
				printf("  [Bank System] Couldn't create an actor for banker ID %d.", id);
			}
			else
			{
			    SetActorInvulnerable(BankerData[id][bankerActorID], true); // people may use a version where actors aren't invulnerable by default
			    SetActorVirtualWorld(BankerData[id][bankerActorID], BankerData[id][bankerVw]);
			}

			#if defined BANKER_USE_MAPICON
			BankerData[id][bankerIconID] = CreateDynamicMapIcon(BankerData[id][bankerX], BankerData[id][bankerY], BankerData[id][bankerZ], 58, 0, .streamdistance = BANKER_ICON_RANGE);
			#endif

			format(label_string, sizeof(label_string), "{F1C40F}[%d] FLEECA Banka Görevlisi\n\n{FFFFFF}[{808080}ALT{FFFFFF}]", id);
			BankerData[id][bankerLabel] = CreateDynamic3DTextLabel(label_string, 0x1ABC9CFF, BankerData[id][bankerX], BankerData[id][bankerY], BankerData[id][bankerZ] + 0.25, 5.0, .testlos = 1);

			Iter_Add(Bankers, id);
		}
	}

	printf("  [Bank System] Loaded %d bankers.", Iter_Count(Bankers));
	return 1;
}

forward LoadATMs();
public LoadATMs()
{
	new rows = cache_num_rows();
	if (rows)
	{
	    new id, label_string[64];
	    #if defined ROBBABLE_ATMS
		new dataArray[E_ATMDATA];
	    #endif

	    for (new i; i < rows; i++)
		{
		    cache_get_value_name_int(i, "ID", id);
	     	cache_get_value_name_float(i, "PosX", ATMData[id][atmX]);
	     	cache_get_value_name_float(i, "PosY", ATMData[id][atmY]);
	     	cache_get_value_name_float(i, "PosZ", ATMData[id][atmZ]);
	     	cache_get_value_name_float(i, "RotX", ATMData[id][atmRX]);
	     	cache_get_value_name_float(i, "RotY", ATMData[id][atmRY]);
	     	cache_get_value_name_float(i, "RotZ", ATMData[id][atmRZ]);

		    ATMData[id][atmObjID] = CreateDynamicObject(-2905, ATMData[id][atmX], ATMData[id][atmY], ATMData[id][atmZ], ATMData[id][atmRX], ATMData[id][atmRY], ATMData[id][atmRZ]);

			#if defined ROBBABLE_ATMS
		    if (IsValidDynamicObject(ATMData[id][atmObjID])) {
		        format(dataArray[IDString], 8, "atm_sys");
		        dataArray[refID] = id;

		        Streamer_SetArrayData(STREAMER_TYPE_OBJECT, ATMData[id][atmObjID], E_STREAMER_EXTRA_ID, dataArray);
		    }else{
				printf("  [Bank System] Couldn't create an ATM object for ATM ID %d.", id);
		    }
			#else
			if (!IsValidDynamicObject(ATMData[id][atmObjID])) printf("  [Bank System] Couldn't create an ATM object for ATM ID %d.", id);
			#endif

			#if defined ATM_USE_MAPICON
			ATMData[id][atmIconID] = CreateDynamicMapIcon(ATMData[id][atmX], ATMData[id][atmY], ATMData[id][atmZ], 52, 0, .streamdistance = ATM_ICON_RANGE);
			#endif

			format(label_string, sizeof(label_string), "{F1C40F}[%d] FLEECA ATM\n\n{FFFFFF}[{808080}ALT{FFFFFF}]", id);
			ATMData[id][atmLabel] = CreateDynamic3DTextLabel(label_string, 0x1ABC9CFF, ATMData[id][atmX], ATMData[id][atmY], ATMData[id][atmZ] + 0.99, 5.0, .testlos = 1);

			Iter_Add(ATMs, id);
		}
	}

    printf("  [Bank System] Loaded %d ATMs.", Iter_Count(ATMs));
	return 1;
}

forward OnBankAccountCreated(playerid, pass[]);
public OnBankAccountCreated(playerid, pass[])
{
	ParaVer(playerid, -ACCOUNT_PRICE);

	new id = cache_insert_id();
	MesajGonder(playerid, "Banka hesabýnýz oluþturuldu.");

	BilgiMesajGonder(playerid, "Hesap Numarasý: %d", id);
	BilgiMesajGonder(playerid, "Hesap Þifreniz: %s", pass);
	return 1;
}

forward OnBankAccountLogin(playerid, id);
public OnBankAccountLogin(playerid, id)
{
	if (cache_num_rows() > 0) {
	    new owner, last_access, ldate[24];
	    cache_get_value_name_int(0, "Owner", owner);
	    cache_get_value_name_int(0, "LastAccess", last_access);
	    cache_get_value_name(0, "Last", ldate);

	    BilgiMesajGonder(playerid, "Bu hesap %s adlý kiþiye kayýtlýdýr.", SQLName(owner));
	    BilgiMesajGonder(playerid, "Son Aktiflik: {808080}%s", (last_access == 0) ? ("Never") : ldate);

	    CurrentAccountID[playerid] = id;
	    Bank_ShowMenu(playerid);

	    new query[96];
	    mysql_format(g_SQL, query, sizeof(query), "UPDATE bank_accounts SET LastAccess=UNIX_TIMESTAMP() WHERE ID=%d && Disabled=0", id);
	    mysql_tquery(g_SQL, query);

	    Bank_SaveLog(playerid, TYPE_LOGIN, id, -1, 0);
	}else{
	    HataMesajGonder(playerid, "Yanlýþ þifre veya hesap numarasý girdiniz.");
	    Bank_ShowMenu(playerid);
	}

	return 1;
}

forward OnBankAccountDeposit(playerid, amount);
public OnBankAccountDeposit(playerid, amount)
{
	if (cache_affected_rows() > 0) {
	    MesajGonder(playerid, "Banka hesabýnýza {2ECC71}%s {FFFFFF}miktar para yatýrdýnýz.", FormatNumber(amount));

	    ParaVer(playerid, -amount);
	    Bank_SaveLog(playerid, TYPE_DEPOSIT, CurrentAccountID[playerid], -1, amount);
	}else{
	    HataMesajGonder(playerid, "Hata oluþtu.");
	}

	Bank_ShowMenu(playerid);
	return 1;
}

forward OnBankAccountWithdraw(playerid, amount);
public OnBankAccountWithdraw(playerid, amount)
{
	if (cache_affected_rows() > 0) {
	    MesajGonder(playerid, "Banka hesabýnýzdan {2ECC71}%s {FFFFFF}miktar para çektiniz.", FormatNumber(amount));

	    ParaVer(playerid, amount);
	    Bank_SaveLog(playerid, TYPE_WITHDRAW, CurrentAccountID[playerid], -1, amount);
	}else{
	    HataMesajGonder(playerid, "Hata oluþtu.");
	}

    Bank_ShowMenu(playerid);
	return 1;
}

forward OnBankAccountTransfer(playerid, id, amount);
public OnBankAccountTransfer(playerid, id, amount)
{
	if (cache_affected_rows() > 0) {
		new query[144];
		mysql_format(g_SQL, query, sizeof(query), "UPDATE bank_accounts SET Balance=Balance-%d WHERE ID=%d && Disabled=0", amount, CurrentAccountID[playerid]);
		mysql_tquery(g_SQL, query, "OnBankAccountTransferDone", "iii", playerid, id, amount);
	}else{
	    HataMesajGonder(playerid, "Transfer baþarýsýz, hatalý hesap numarasý girmiþ olabilirsiniz.");
	    Bank_ShowMenu(playerid);
	}

	return 1;
}

forward OnBankAccountTransferDone(playerid, id, amount);
public OnBankAccountTransferDone(playerid, id, amount)
{
	if (cache_affected_rows() > 0) {
	    MesajGonder(playerid, "{F1C40F}%d {FFFFFF}numaralý hesaba {2ECC71}%s {FFFFFF}miktar para transfer ettiniz.", id, FormatNumber(amount));

		Bank_SaveLog(playerid, TYPE_TRANSFER, CurrentAccountID[playerid], id, amount);
	}else{
	   HataMesajGonder(playerid, "Transfer baþarýsýz, hatalý hesap numarasý girmiþ olabilirsiniz.");

	}

    Bank_ShowMenu(playerid);
	return 1;
}

forward OnBankAccountPassChange(playerid, newpass[]);
public OnBankAccountPassChange(playerid, newpass[])
{
	if (cache_affected_rows() > 0) {
	    BilgiMesajGonder(playerid, "Þifre '%s' olarak deðiþtirildi.", newpass);

        Bank_SaveLog(playerid, TYPE_PASSCHANGE, CurrentAccountID[playerid], -1, 0);
	}else{
	    HataMesajGonder(playerid, "Þifre deðiþtirme baþarýsýz.");
	}

    Bank_ShowMenu(playerid);
	return 1;
}

forward OnBankAccountDeleted(playerid, id, amount);
public OnBankAccountDeleted(playerid, id, amount)
{
    if (cache_affected_rows() > 0) {
        ParaVer(playerid, amount);

        foreach (new i : Player)
        {
            if (i == playerid) continue;
            if (CurrentAccountID[i] == id) CurrentAccountID[i] = -1;
        }

	    BilgiMesajGonder(playerid, "Banka hesabýnýz silindi.");
	}else{
	    SendClientMessage(playerid, 0xE74C3CFF, "Hata oluþtu.");
	}

	CurrentAccountID[playerid] = -1;
    Bank_ShowMenu(playerid);
	return 1;
}
forward FillTrash(id);
public FillTrash(id)
{
	TrashData[id][TrashLevel]++;
	if(TrashData[id][TrashType] == TYPE_BIN && TrashData[id][TrashLevel] > 1) TrashData[id][TrashLevel] = 1;

	if(TrashData[id][TrashType] == TYPE_DUMPSTER) {
		if(TrashData[id][TrashLevel] == 1) TrashData[id][TrashTimer] = SetTimerEx("FillTrash", REFILL_TIME * 1000, false, "i", id);
		if(TrashData[id][TrashLevel] >= 2)
		{
			TrashData[id][TrashLevel] = 2;
			KillTimer(TrashData[id][TrashTimer]);
			TrashData[id][TrashTimer] = -1;
		}

		Streamer_SetIntData(STREAMER_TYPE_3D_TEXT_LABEL, TrashData[id][TrashLabel], E_STREAMER_COLOR, (TrashData[id][TrashLevel] == 1) ? 0xF39C12FF : 0x2ECC71FF);
		return 1;
	}

	Streamer_SetIntData(STREAMER_TYPE_3D_TEXT_LABEL, TrashData[id][TrashLabel], E_STREAMER_COLOR, 0x2ECC71FF);
	return 1;
}
forward CutTree(playerid);
public CutTree(playerid)
{
    if (CuttingTreeID[playerid] != -1)
	{
	    new id = CuttingTreeID[playerid], Float: value = GetPlayerProgressBarValue(playerid, CuttingBar[playerid]) + 1.0;

		if (value >= CUTTING_TIME) {
		    Player_ResetCutting(playerid);
			MoveDynamicObject(TreeData[id][treeObjID], TreeData[id][treeX], TreeData[id][treeY], TreeData[id][treeZ] + 0.03, 0.025, TreeData[id][treeRX], TreeData[id][treeRY] - 80.0, TreeData[id][treeRZ]);

			TreeData[id][treeLogs] = 5;
			TreeData[id][treeSeconds] = TREE_RESPAWN;
			Tree_UpdateLogLabel(id);
		}else{
		    SetPlayerProgressBarValue(playerid, CuttingBar[playerid], value);
		}
	}
	return 1;
}

forward RespawnTree(id);
public RespawnTree(id)
{
	new label[96];
	if (TreeData[id][treeSeconds] > 1) {
	    TreeData[id][treeSeconds]--;

	    format(label, sizeof(label), "Kesilmiþ Ýnek (%d)\n\n{FFFFFF}%s", id, ConvertToMinutes(TreeData[id][treeSeconds]));
		UpdateDynamic3DTextLabelText(TreeData[id][treeLabel], 0xE74C3CFF, label);
	}else if (TreeData[id][treeSeconds] == 1) {
	    KillTimer(TreeData[id][treeTimer]);

	    TreeData[id][treeLogs] = 0;
	    TreeData[id][treeSeconds] = 0;
	    TreeData[id][treeTimer] = -1;

	    SetDynamicObjectPos(TreeData[id][treeObjID], TreeData[id][treeX], TreeData[id][treeY], TreeData[id][treeZ]);
     	SetDynamicObjectRot(TreeData[id][treeObjID], TreeData[id][treeRX], TreeData[id][treeRY], TreeData[id][treeRZ]);

     	format(label, sizeof(label), "Kesilmiþ Ýnek (%d)\n\n{F1C40F}~k~~CONVERSATION_NO~ {FFFFFF}ile kesebilirsin.", id);
     	UpdateDynamic3DTextLabelText(TreeData[id][treeLabel], 0x2ECC71FF, label);
	}

	return 1;
}
stock Float:GetDistanceBetweenPoints(Float:x1, Float:y1, Float:z1, Float:x2, Float:y2, Float:z2)
{
    return VectorSize(x1-x2, y1-y2, z1-z2);
}
new cekilisSure = -1;
forward OnServerUpdate();
public OnServerUpdate()
{
    if (cekilisSure != -1)
    {
        if (cekilisSure == 0) foreach (new i : Player)
        {
            SendClientMessageEx(i, 0x01A9DBFF, "(( [Çekiliþ] Çekiliþi kazanan þanslý talihli %s oldu, kendisini tebrik ederiz! )) ", ReturnName(Iter_Random(Player), 0));
        }
        else if (cekilisSure > 0) foreach (new i : Player)
		{
            SendClientMessageEx(i, 0x01A9DBFF, "(( [Çekiliþ] Þanslý kiþinin seçilmesine son %d saniye kaldý. ))", cekilisSure);
		}
		cekilisSure -= 1;
	}

    if (GetServerBilgi("BitcoinUpdate") <= gettime())
	{
	    new sans = random(100)+1;
		new date = gettime()+7*86400;

		if (sans >= 15)
		{
			new artacak = RandomEx(50, 100);
			SetServerBilgi("BitcoinAlma", GetServerBilgi("BitcoinAlma")+artacak);
			SetServerBilgi("BitcoinSatma", GetServerBilgi("BitcoinAlma")+artacak);
		}

		if (sans <= 14)
		{
            new azalacak = RandomEx(50, 100);
			SetServerBilgi("BitcoinAlma", GetServerBilgi("BitcoinAlma")-azalacak);
			SetServerBilgi("BitcoinSatma", GetServerBilgi("BitcoinSatma")-azalacak);
		}

		SetServerBilgi("BitcoinUpdate", date);
	}
	return 1;
}

forward YatUpdate();
public YatUpdate()
{
	if (YatBilgi[yatKiralayan] != -1)
	{
	    if (YatBilgi[yatTeslimSure] > 0)
	    {
	        YatBilgi[yatTeslimSure]--;
         	new Float:x, Float:y, Float:z;
          	GetObjectPos(YatBilgi[yatObject],x,y,z);
           	new id = GetPlayerIDWithSQLID(YatBilgi[yatKiralayan]);
            if (GetDistanceBetweenPoints(x, y, z, 134.063171, -1829.491333, 4.759999) < 30.0)
            {
            	YatBilgi[yatKiralayan] = -1;
             	YatBilgi[yatKiraSure] = 0;
              	YatBilgi[yatOto] = 0;
               	YatBilgi[yatStep] = 0;
                YatBilgi[yatUyari] = 0;
                YatBilgi[yatTeslimSure] = 0;
                StopObject(YatBilgi[yatObject]);
                SetObjectPos(YatBilgi[yatObject], 134.063171, -1829.491333, 4.759999);
                SetObjectRot(YatBilgi[yatObject], 0.000000, 0.000000, 183.149398);
                if (id != -1 && PlayerData[id][pYatKontrol][0] == 1)
                {
                	new Float:yatX, Float:yatY, Float:yatZ;
                	PlayerData[id][pYatKontrol][0] = 0;
                	TogglePlayerSpectating(id, false);
                	GetObjectPos(YatBilgi[yatObject], yatX, yatY, yatZ);
                	SetPlayerPos(id, yatX, yatY, yatZ+3);
                	SetPlayerInterior(id, 0);
                	SetPlayerVirtualWorld(id, 0);
                	SetWeapons(id);
                }
            }
            else
            {
                if (YatBilgi[yatTeslimSure] <= 0)
                {
	             	YatBilgi[yatKiraSure] = 0;
	              	YatBilgi[yatOto] = 0;
	               	YatBilgi[yatStep] = 0;
	                YatBilgi[yatUyari] = 0;
	                YatBilgi[yatTeslimSure] = 0;
	                StopObject(YatBilgi[yatObject]);
	                SetObjectPos(YatBilgi[yatObject], 134.063171, -1829.491333, 4.759999);
	                SetObjectRot(YatBilgi[yatObject], 0.000000, 0.000000, 183.149398);
	                if (id != -1)
	                {
	                    ParaVer(id, -5000);
	                    if (PlayerData[id][pYatKontrol][0] == 1)
                		{
		                	new Float:yatX, Float:yatY, Float:yatZ;
		                	PlayerData[id][pYatKontrol][0] = 0;
		                	TogglePlayerSpectating(id, false);
		                	GetObjectPos(YatBilgi[yatObject], yatX, yatY, yatZ);
		                	SetPlayerPos(id, yatX, yatY, yatZ+3);
		                	SetPlayerInterior(id, 0);
		                	SetPlayerVirtualWorld(id, 0);
		                	SetWeapons(id);
                		}
	                    BilgiMesajGonder(id, "Yatý vaktinde teslim etmediðiniz için $5,000 para cezasýna çarptýrýldýnýz.");
	                }
	                else
	                {
	                    OfflineParaVer(YatBilgi[yatKiralayan], -5000);
	                    BildirimEkle(YatBilgi[yatKiralayan], "Yatýnýzýn kira süresi bittiði için ve yatý teslim etmediðiniz için $5,000 para cezasý kesildi.", "Yat Sahibi");
	                }
	                YatBilgi[yatKiralayan] = -1;
                }
            }
	    }
	    if (YatBilgi[yatKiraSure] > 0)
	    {
	        YatBilgi[yatKiraSure]--;
	        if (YatBilgi[yatKiraSure] == 600 && YatBilgi[yatUyari] == 0)
	        {
	            new id = GetPlayerIDWithSQLID(YatBilgi[yatKiralayan]);
	            if (id != -1)
	            {
	            	YatBilgi[yatUyari] = 1;
	            	callcmd::cpsifirla(id);
	            	BilgiMesajGonder(id, "Kira süresinin bitimine 10 dakika kaldý, kira süresini uzatmak istiyorsan (/yat) komutunu kullanabilirsin.");
	            	BilgiMesajGonder(id, "Kira süresi bittikten sonra 5 dakika içerisinde yatý teslim etmezsen $5,000 para cezasý kesilir.");
	            	SetPVarInt(id, "AraciniBuluyor", 1);
              		SetPlayerCheckpoint(id, 134.063171, -1829.491333, 4.759999, 7.0);
	            }
	        }
	        else if (YatBilgi[yatKiraSure] <= 0)
	        {
	            new Float:x, Float:y, Float:z;
	            GetObjectPos(YatBilgi[yatObject],x,y,z);
	            new id = GetPlayerIDWithSQLID(YatBilgi[yatKiralayan]);
	            if (GetDistanceBetweenPoints(x, y, z, 134.063171, -1829.491333, 4.759999) < 30.0)
	            {
	                YatBilgi[yatKiralayan] = -1;
	                YatBilgi[yatKiraSure] = 0;
	                YatBilgi[yatOto] = 0;
	                YatBilgi[yatStep] = 0;
	                YatBilgi[yatUyari] = 0;
	                YatBilgi[yatTeslimSure] = 0;
	                StopObject(YatBilgi[yatObject]);
	                SetObjectPos(YatBilgi[yatObject], 134.063171, -1829.491333, 4.759999);
	                SetObjectRot(YatBilgi[yatObject], 0.000000, 0.000000, 183.149398);
	                if (PlayerData[id][pYatKontrol][0] == 1)
	                {
	                    new Float:yatX, Float:yatY, Float:yatZ;
	                	PlayerData[id][pYatKontrol][0] = 0;
	                	TogglePlayerSpectating(id, false);
	                	GetObjectPos(YatBilgi[yatObject], yatX, yatY, yatZ);
	                	SetPlayerPos(id, yatX, yatY, yatZ+3);
	                	SetPlayerInterior(id, 0);
	                	SetPlayerVirtualWorld(id, 0);
	                	SetWeapons(id);
	                }
	            }
	            else
	            {
	                YatBilgi[yatTeslimSure] = 300;
	                if (id != -1)
	                {
	                    BilgiMesajGonder(id, "Yatýnýzýn kira süresi doldu, 5 dakika içerisinde teslim etmezsen $5,000 para cezasý kesilecek.");
	                }
	            }
	        }
	    }
	}
	return 1;
}
forward AracSuKontrol(playerid, vehicleid);
public AracSuKontrol(playerid, vehicleid)
{
if (IsPlayerInWater(playerid) && IsPlayerInVehicle(playerid))
{
Arac_Spawn(vehicleid);
}
return 1;
}

forward PetUpdate();
public PetUpdate()
{
	foreach (new i:Petler)
	{
	    if (PetBilgi[i][petDurum] == true)
	    {
	        new str[124];
	        if (PetBilgi[i][petRenk] == 1) format(str, sizeof(str), "{FFFFFF}%s (#%d)\n\n{AFAFAF}Pet Türü: %s\n{AFAFAF}Cinsiyet: %s\n{AFAFAF}Saðlýk: %.1f\nAçlýk: %d",PetBilgi[i][petAdi],i, PetTurIsim(PetBilgi[i][petTuru]), (PetBilgi[i][petCinsiyet] == 1) ? ("Erkek") : ("Kadýn"), FCNPC_GetHealth(PetBilgi[i][NPCID]), PetBilgi[i][petAclik]);
	        if (PetBilgi[i][petRenk] == 2) format(str, sizeof(str), "{0295f7}%s (#%d)\n\n{AFAFAF}Pet Türü: %s\n{AFAFAF}Cinsiyet: %s\n{AFAFAF}Saðlýk: %.1f\nAçlýk: %d",PetBilgi[i][petAdi],i, PetTurIsim(PetBilgi[i][petTuru]), (PetBilgi[i][petCinsiyet] == 1) ? ("Erkek") : ("Kadýn"), FCNPC_GetHealth(PetBilgi[i][NPCID]), PetBilgi[i][petAclik]);
	        if (PetBilgi[i][petRenk] == 3) format(str, sizeof(str), "{f70202}%s (#%d)\n\n{AFAFAF}Pet Türü: %s\n{AFAFAF}Cinsiyet: %s\n{AFAFAF}Saðlýk: %.1f\nAçlýk: %d",PetBilgi[i][petAdi],i, PetTurIsim(PetBilgi[i][petTuru]), (PetBilgi[i][petCinsiyet] == 1) ? ("Erkek") : ("Kadýn"), FCNPC_GetHealth(PetBilgi[i][NPCID]), PetBilgi[i][petAclik]);
			if (PetBilgi[i][petRenk] == 4) format(str, sizeof(str), "{f77002}%s (#%d)\n\n{AFAFAF}Pet Türü: %s\n{AFAFAF}Cinsiyet: %s\n{AFAFAF}Saðlýk: %.1f\nAçlýk: %d",PetBilgi[i][petAdi],i, PetTurIsim(PetBilgi[i][petTuru]), (PetBilgi[i][petCinsiyet] == 1) ? ("Erkek") : ("Kadýn"), FCNPC_GetHealth(PetBilgi[i][NPCID]), PetBilgi[i][petAclik]);
			if (PetBilgi[i][petRenk] == 5) format(str, sizeof(str), "{ffff00}%s (#%d)\n\n{AFAFAF}Pet Türü: %s\n{AFAFAF}Cinsiyet: %s\n{AFAFAF}Saðlýk: %.1f\nAçlýk: %d",PetBilgi[i][petAdi],i, PetTurIsim(PetBilgi[i][petTuru]), (PetBilgi[i][petCinsiyet] == 1) ? ("Erkek") : ("Kadýn"), FCNPC_GetHealth(PetBilgi[i][NPCID]), PetBilgi[i][petAclik]);
			if (PetBilgi[i][petRenk] == 6) format(str, sizeof(str), "{ee00ff}%s (#%d)\n{AFAFAF}Pet Türü: %s\n{AFAFAF}Cinsiyet: %s\n{AFAFAF}Saðlýk: %.1f\nAçlýk: %d",PetBilgi[i][petAdi],i, PetTurIsim(PetBilgi[i][petTuru]), (PetBilgi[i][petCinsiyet] == 1) ? ("Erkek") : ("Kadýn"), FCNPC_GetHealth(PetBilgi[i][NPCID]), PetBilgi[i][petAclik]);
			if (PetBilgi[i][petRenk] == 7) format(str, sizeof(str), "{2aff00}%s (#%d)\n\n{AFAFAF}Pet Türü: %s\n{AFAFAF}Cinsiyet: %s\n{AFAFAF}Saðlýk: %.1f\nAçlýk: %d",PetBilgi[i][petAdi],i, PetTurIsim(PetBilgi[i][petTuru]), (PetBilgi[i][petCinsiyet] == 1) ? ("Erkek") : ("Kadýn"), FCNPC_GetHealth(PetBilgi[i][NPCID]), PetBilgi[i][petAclik]);
			UpdateDynamic3DTextLabelText(PetBilgi[i][petText], -1, str);

			if (PetBilgi[i][petTakip] != -1 && OyundaDegil(PetBilgi[i][petTakip]) && !IsPlayerInWater(PetBilgi[i][petTakip]) && !IsPlayerInAnyVehicle(PetBilgi[i][petTakip]) && GetPlayerInterior(PetBilgi[i][petTakip]) == FCNPC_GetInterior(PetBilgi[i][NPCID]) && GetPlayerVirtualWorld(PetBilgi[i][petTakip]) == FCNPC_GetVirtualWorld(PetBilgi[i][NPCID]))
			{
			    new Float:pos[3];
			    FCNPC_GetPosition(PetBilgi[i][NPCID], pos[0], pos[1], pos[2]);
			    FCNPC_StopAttack(PetBilgi[i][NPCID]);
			    if (GetPlayerDistanceFromPoint(PetBilgi[i][petTakip], pos[0], pos[1], pos[2]) >= 20)
			    {
			        PetBilgi[i][petTakip] = -1;
			        PetBilgi[i][petSaldir] = -1;
			        FCNPC_Stop(PetBilgi[i][NPCID]);
			        FCNPC_StopAttack(PetBilgi[i][NPCID]);
			    }
			    if (GetPlayerDistanceFromPoint(PetBilgi[i][petTakip], pos[0], pos[1], pos[2]) >= 1 && GetPlayerDistanceFromPoint(PetBilgi[i][petTakip], pos[0], pos[1], pos[2]) <= 20)
			    {
			        FCNPC_StopAttack(PetBilgi[i][NPCID]);
					FCNPC_GoToPlayer(PetBilgi[i][NPCID], PetBilgi[i][petTakip]);
			    }
			    if (GetPlayerDistanceFromPoint(PetBilgi[i][petTakip], pos[0], pos[1], pos[2]) < 1 && PetBilgi[i][petSaldir] != -1)
			    {
			        FCNPC_MeleeAttack(PetBilgi[i][NPCID], -1, true);
				}

			}
			PetBilgi[i][petAcikma]++;
			if (PetBilgi[i][petAcikma] >= 360)
			{
			    PetBilgi[i][petAcikma] = 0;
			    PetBilgi[i][petAclik] -= 3;
			    if (PetBilgi[i][petAclik] < 0) PetBilgi[i][petAclik] = 0;
			}
	    }
	}
	return 1;
}
forward PetDelete(id);
public PetDelete(id)
{
	PetBilgi[id][petSaglik] = 100.0;
    FCNPC_Destroy(PetBilgi[id][NPCID]);
    PetBilgi[id][petTakip] = -1;
    PetBilgi[id][NPCID] = -1;
    PetBilgi[id][petDurum] = false;
    DestroyDynamic3DTextLabel(PetBilgi[id][petText]);
	return 1;
}
forward HoodlariYukle();
public HoodlariYukle()
{
	mysql_query(g_SQL, "SELECT * FROM `hood`");

	new rows = cache_num_rows();

	printf("» Toplam %d Hood yüklendi.", rows);

	if (rows)
	{
	    new hoID;
		for (new i; i<rows; i++)
		{
		    cache_get_value_name_int(i, "ID", hoID);

            Hood[hoID][hExists] = true;
            Hood[hoID][hID] = hoID;

			cache_get_value_name_float(i, "hoodX", Hood[hoID][hPos][0]);
		    cache_get_value_name_float(i, "hoodY", Hood[hoID][hPos][1]);
		    cache_get_value_name_float(i, "hoodZ", Hood[hoID][hPos][2]);
		    cache_get_value_name_int(i, "Birlik", Hood[hoID][hBirlik]);

		    Hood_Yenile(hoID);
		}
	}
	return 1;
}
forward TamirhaneleriYukle();
public TamirhaneleriYukle()
{
	mysql_query(g_SQL, "SELECT * FROM `tamirhaneler`");

	new rows = cache_num_rows();

	printf("» Toplam %d tamirhane yuklendi.", rows);

	if(rows)
	{
		new tid;

		for(new i = 0; i < rows; i++)
		{
			cache_get_value_name_int(i, "tamirID", tid);

			Tamirhane[tid][Tamirhane_ID] = tid;
			Tamirhane[tid][Tamirhane_Kontrol] = true;
			Tamirhane[tid][Tamirhane_Kullaniliyor] = false;

			cache_get_value_name_float(i, "tamirX", Tamirhane[tid][Tamirhane_Pos][0]);
			cache_get_value_name_float(i, "tamirY", Tamirhane[tid][Tamirhane_Pos][1]);
			cache_get_value_name_float(i, "tamirZ", Tamirhane[tid][Tamirhane_Pos][2]);
			cache_get_value_name_float(i, "tamirA", Tamirhane[tid][Tamirhane_Pos][3]);

			cache_get_value_name_int(i, "tamirVW", Tamirhane[tid][Tamirhane_World]);
			cache_get_value_name_int(i, "tamirInt", Tamirhane[tid][Tamirhane_Interior]);

			cache_get_value_name_float(i, "tamirIcX", Tamirhane[tid][Tamirhane_IcPos][0]);
			cache_get_value_name_float(i, "tamirIcY", Tamirhane[tid][Tamirhane_IcPos][1]);
			cache_get_value_name_float(i, "tamirIcZ", Tamirhane[tid][Tamirhane_IcPos][2]);
			cache_get_value_name_float(i, "tamirIcA", Tamirhane[tid][Tamirhane_Pos][4]);

			cache_get_value_name_int(i, "tamirIcVW", Tamirhane[tid][Tamirhane_IcWorld]);
			cache_get_value_name_int(i, "tamirIcInt", Tamirhane[tid][Tamirhane_IcInterior]);

			cache_get_value_name_int(i, "tamirVakit", Tamirhane[tid][Tamirhane_Vakit]);

			Tamirhane_Objeler(i);
		}
	}
	return 1;
}

forward PompalariYukle();
public PompalariYukle()
{
    mysql_query(g_SQL, "SELECT * FROM `pompalar`");

	new rows = cache_num_rows();

	printf("» Toplam %d benzin pompasi yuklendi.", rows);

	if(rows)
	{
	    new pompaid;
		for (new i = 0; i < rows; i++)
		{
			cache_get_value_name_int(i, "pompaID", pompaid);

            Pompa[pompaid][Pompa_Kontrol] = true;
			Pompa[pompaid][Pompa_ID] = pompaid;

			cache_get_value_name_float(i, "pompaX", Pompa[pompaid][Pompa_Pos][0]);
			cache_get_value_name_float(i, "pompaY", Pompa[pompaid][Pompa_Pos][1]);
			cache_get_value_name_float(i, "pompaZ", Pompa[pompaid][Pompa_Pos][2]);
			cache_get_value_name_float(i, "pompaRX", Pompa[pompaid][Pompa_Pos][3]);
			cache_get_value_name_float(i, "pompaRY", Pompa[pompaid][Pompa_Pos][4]);
			cache_get_value_name_float(i, "pompaRZ", Pompa[pompaid][Pompa_Pos][5]);
		}

		for(new i = 0; i < MAX_POMPA; i++)
		{
		    if(Pompa[i][Pompa_Kontrol])
	         	Pompa_Objeler(i);
		}
	}
	return 1;
}
forward AttachTrailer(vehicleid, playerid);
public AttachTrailer(vehicleid, playerid)
{

}

SirketVer(playerid, id)
{
    if (id != -1 && sirketData[id][sirketExists])
    {
        PlayerData[playerid][pSirket] = id;
        PlayerData[playerid][pSirketID] = sirketData[id][sirketID];
        PlayerData[playerid][pSirketRank] = -1;
    }
    return 1;
}
forward SirketYetkiVer(playerid); public SirketYetkiVer(playerid)
{
    new id = GetPVarInt(playerid, "KurulanSirketID");
    SirketVer(playerid, id);
    PlayerData[playerid][pSirketRank] = sirketData[id][sirketRank];
}
forward SirketOlusturuldu(sirketid);
public SirketOlusturuldu(sirketid)
{
    if (sirketid == -1 || !sirketData[sirketid][sirketExists])
        return 0;

    sirketData[sirketid][sirketID] = cache_insert_id();

    Sirket_Kaydet(sirketid);

    return 1;
}

forward DiscordPanel(playerid);
public DiscordPanel(playerid)
{
	new kod[64], discord_id[21];

	cache_get_value_index(0, 0, kod);
	cache_get_value_index(0, 1, discord_id);

	if(!strcmp(discord_id, "0", true))
	{
		format(kod, sizeof(kod), "AUTH-%d", RandomEx(10000000000, 999999999999));

		new query[55 + 90 + 11 + 1];

		mysql_format(g_SQL, query, sizeof(query), "UPDATE oyuncular SET discord_kod = '%e' WHERE ID = '%d'", kod, PlayerData[playerid][pID]);
		mysql_query(g_SQL, query);

		Dialog_Show(playerid, 0, DIALOG_STYLE_TABLIST, "{FFFFFF}Discord: {808080}Doðrula", "{ffffff}Discord Doðrulama Kodunuz: {808080}%s\n\n{FF0000}Dikkat: {ffffff}Bu ekraný her yenilediðinizde kod yenilenecektir.", "Kapat", "", kod);
		SunucuMesaji(playerid, "Doðrulama kodunuz: %s", kod);
	}
	else
	{
		new query[61 + 11 + 1];

		mysql_format(g_SQL, query, sizeof(query), "SELECT discord_id, discord_exp FROM oyuncular WHERE ID = '%d'", PlayerData[playerid][pID]);
		mysql_tquery(g_SQL, query, "DiscordPanelBilgi", "d", playerid);
	}

	return 1;
}

forward DiscordPanelBilgi(playerid);
public DiscordPanelBilgi(playerid)
{
	new rows = cache_num_rows();

	if(rows)
	{
		new discord_id[21];

		cache_get_value_index(0, 0, discord_id);

		new DCC_User:kullanici = DCC_FindUserById(discord_id);

		if(kullanici != DCC_INVALID_USER)
		{
			new aktifUye;

			DCC_GetGuildMemberCount(DCC_Guild:1, aktifUye);

			new kullanici_isim[DCC_USERNAME_SIZE];

			DCC_GetUserName(kullanici, kullanici_isim);

			new discord_exp;

			cache_get_value_index_int(0, 1, discord_exp);

			SetPVarInt(playerid, "discordExp", discord_exp);

			Dialog_Show(playerid, DiscordBilgileri, DIALOG_STYLE_TABLIST, "{FFFFFF}Discord: {808080}Bilgiler", "{ffffff}Hesap: {808080}%s\t\n{ffffff}Üye Sayýsý: {808080}%d kiþi\t\n{ffffff}Biriken EXP Miktarýnýz: {808080}%d {ffffff}(týklayarak 4/1 oranýnda üzerine ekle)\t\n{000000}.\n{000000}.\n{FF0000}Hesapla Ýliþkimi Kes", "Seç", "Kapat", kullanici_isim, aktifUye, discord_exp);
		}

		else
		{
			new query[74 + 11 + 1];

			mysql_format(g_SQL, query, sizeof(query), "UPDATE oyuncular SET discord_kod = 'Yok', discord_id = '0' WHERE ID = '%d'", PlayerData[playerid][pID]);
			mysql_query(g_SQL, query);

			SunucuMesaji(playerid, "Discord sunucusunda olmadýðýnýz için bilgileriniz sýfýrlanmýþtýr.");
		}
	}

	else HataMesajGonder(playerid, "Veriler alýnamadý.");
	return 1;
}

public DCC_OnMessageCreate(DCC_Message:message)
{
	new DCC_Channel:kanal, kanal_isim[128], mesaj[128], DCC_User:yazan;

	DCC_GetMessageContent(message, mesaj);
	DCC_GetMessageChannel(message, kanal);
	DCC_GetChannelName(kanal, kanal_isim);
	DCC_GetMessageAuthor(message, yazan);

	new yazan_isim[DCC_USERNAME_SIZE];

	DCC_GetUserName(yazan, yazan_isim);

	if(!strcmp(kanal_isim, "discord", true))
	{
		if(strfind(mesaj, "AUTH", true) != -1 || strfind(mesaj, "AUTH-", true) != -1)
		{
			new query[67 + 64 + 1];

			mysql_format(g_SQL, query, sizeof(query), "SELECT ID, discord_id, Isim FROM oyuncular WHERE discord_kod = '%e'", mesaj);
			mysql_tquery(g_SQL, query, "DiscordKodKontrol", "d", _:yazan);
		}

		else if(strcmp(yazan_isim, "Regular Roleplay", true)) DCC_DeleteMessage(message);
	}

	return 1;
}

forward DiscordKodKontrol(DCC_User:kullanici_id);
public DiscordKodKontrol(DCC_User:kullanici_id)
{
	new rows = cache_num_rows();

	if(rows)
	{
		new id, discord_id[21], isim[MAX_PLAYER_NAME];

		cache_get_value_index_int(0, 0, id);
		cache_get_value_index(0, 1, discord_id);
		cache_get_value_index(0, 2, isim);

		DogrulandiMesaj(isim);

		foreach(new i : Player)
		{
			if(PlayerData[i][pID] != id)
				continue;

			new hesap[DCC_USERNAME_SIZE];

			DCC_GetUserName(kullanici_id, hesap);

			SunucuMesaji(i, "Discord hesabýnýz \"%s\" olarak güncellendi.", hesap);
			break;
		}

		new kod[21];

		DCC_GetUserId(kullanici_id, kod);

		new query[54 + 21 + 11 + 1];

		mysql_format(g_SQL, query, sizeof(query), "UPDATE oyuncular SET discord_id = '%e' WHERE ID = '%d'", kod, id);
		mysql_query(g_SQL, query);
	}

	else HataliMesaj();

	return 1;
}
forward fss();
public fss()
{
	ilkarabalars = 1;
    new string[128];
    format(string,sizeof(string),"gmx");
    SendRconCommand(string);
}

forward DiscordExp();
public DiscordExp()
{
	new rows = cache_num_rows();

	if(rows)
	{
		new id, discord_id[21], DCC_User:kullanici, DCC_UserPresenceStatus:durum;

		for(new i = 0; i < rows; i++)
		{
			cache_get_value_index_int(i, 0, id);
			cache_get_value_index(i, 1, discord_id);

			kullanici = DCC_FindUserById(discord_id);

			DCC_GetGuildMemberStatus(DCC_Guild:1, kullanici, durum);

			if(_:durum != 0 && _:durum != 4)
			{
				DiscordEXPVer(id);
			}
		}
	}

	return 1;
}

public DCC_OnGuildMemberAdd(DCC_Guild:guild, DCC_User:user)
{
	DCC_AddGuildMemberRole(guild, user, DCC_FindRoleById("775430586050543626"));

	new mesaj[128], gelen[DCC_USERNAME_SIZE];

	DCC_GetUserName(user, gelen);

	format(mesaj, sizeof(mesaj), "**%s** sunucumuza giriþ yaptý, hoþgeldin!", gelen);

	DCMesaj("hos-geldiniz", trcar(mesaj));

	return 1;
}

///Stock Lar
stock LeaveTaxi(playerid, driverid)
{
    if (driverid != INVALID_PLAYER_ID && IsPlayerConnected(driverid))
    {
        ParaVer(playerid, -floatround(PlayerData[playerid][pTaksiUcret]));
        ParaVer(driverid, floatround(PlayerData[playerid][pTaksiUcret]));
		AracInfo[Car_GetID(GetPlayerVehicleID(driverid))][OturumKazanci] += floatround(PlayerData[playerid][pTaksiUcret]);
        SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s taksi þöförüne $%d verir.", ReturnName(playerid, 0), floatround(PlayerData[playerid][pTaksiUcret]));

        PlayerData[playerid][pTaksiUcret] = 0;
        PlayerData[playerid][pTaxiPlayer] = -1;
        PlayerData[playerid][pTaksiKabul] = -1;
        DisablePlayerCheckpoint(playerid);
        DisablePlayerCheckpoint(driverid);
        PlayerTextDrawHide(playerid, TaxiTD[playerid][0]);
        PlayerTextDrawHide(playerid, TaxiTD[playerid][1]);
        PlayerTextDrawHide(driverid, TaxiTD[driverid][0]);
        PlayerTextDrawHide(driverid, TaxiTD[driverid][1]);
    }
    return 1;
}
stock AksesuarTak(playerid, index)
{
	if (PlayerData[playerid][pARenk][index] == 0) return SetPlayerAttachedObject(playerid,index,PlayerData[playerid][pASlot][index],PlayerData[playerid][pABone][index],AksesuarData[playerid][index][0],AksesuarData[playerid][index][1],AksesuarData[playerid][index][2],AksesuarData[playerid][index][3],AksesuarData[playerid][index][4],AksesuarData[playerid][index][5],AksesuarData[playerid][index][6],AksesuarData[playerid][index][7],AksesuarData[playerid][index][8]);
	switch (PlayerData[playerid][pARenk][index])
	{
	    case 1: SetPlayerAttachedObject(playerid,index,PlayerData[playerid][pASlot][index],PlayerData[playerid][pABone][index],AksesuarData[playerid][index][0],AksesuarData[playerid][index][1],AksesuarData[playerid][index][2],AksesuarData[playerid][index][3],AksesuarData[playerid][index][4],AksesuarData[playerid][index][5],AksesuarData[playerid][index][6],AksesuarData[playerid][index][7],AksesuarData[playerid][index][8], RGBAToARGB(0x000000FF), RGBAToARGB(0x000000FF));
	    case 2: SetPlayerAttachedObject(playerid,index,PlayerData[playerid][pASlot][index],PlayerData[playerid][pABone][index],AksesuarData[playerid][index][0],AksesuarData[playerid][index][1],AksesuarData[playerid][index][2],AksesuarData[playerid][index][3],AksesuarData[playerid][index][4],AksesuarData[playerid][index][5],AksesuarData[playerid][index][6],AksesuarData[playerid][index][7],AksesuarData[playerid][index][8], RGBAToARGB(0xFF0000FF), RGBAToARGB(0xFF0000FF));
	    case 3: SetPlayerAttachedObject(playerid,index,PlayerData[playerid][pASlot][index],PlayerData[playerid][pABone][index],AksesuarData[playerid][index][0],AksesuarData[playerid][index][1],AksesuarData[playerid][index][2],AksesuarData[playerid][index][3],AksesuarData[playerid][index][4],AksesuarData[playerid][index][5],AksesuarData[playerid][index][6],AksesuarData[playerid][index][7],AksesuarData[playerid][index][8], RGBAToARGB(0x0000BBFF), RGBAToARGB(0x0000BBFF));
	    case 4: SetPlayerAttachedObject(playerid,index,PlayerData[playerid][pASlot][index],PlayerData[playerid][pABone][index],AksesuarData[playerid][index][0],AksesuarData[playerid][index][1],AksesuarData[playerid][index][2],AksesuarData[playerid][index][3],AksesuarData[playerid][index][4],AksesuarData[playerid][index][5],AksesuarData[playerid][index][6],AksesuarData[playerid][index][7],AksesuarData[playerid][index][8], RGBAToARGB(0xFF9900FF), RGBAToARGB(0xFF9900FF));
	    case 5: SetPlayerAttachedObject(playerid,index,PlayerData[playerid][pASlot][index],PlayerData[playerid][pABone][index],AksesuarData[playerid][index][0],AksesuarData[playerid][index][1],AksesuarData[playerid][index][2],AksesuarData[playerid][index][3],AksesuarData[playerid][index][4],AksesuarData[playerid][index][5],AksesuarData[playerid][index][6],AksesuarData[playerid][index][7],AksesuarData[playerid][index][8], RGBAToARGB(0xa126edFF), RGBAToARGB(0xa126edFF));
	    case 6: SetPlayerAttachedObject(playerid,index,PlayerData[playerid][pASlot][index],PlayerData[playerid][pABone][index],AksesuarData[playerid][index][0],AksesuarData[playerid][index][1],AksesuarData[playerid][index][2],AksesuarData[playerid][index][3],AksesuarData[playerid][index][4],AksesuarData[playerid][index][5],AksesuarData[playerid][index][6],AksesuarData[playerid][index][7],AksesuarData[playerid][index][8], RGBAToARGB(0xffff00FF), RGBAToARGB(0xffff00FF));
	    case 7: SetPlayerAttachedObject(playerid,index,PlayerData[playerid][pASlot][index],PlayerData[playerid][pABone][index],AksesuarData[playerid][index][0],AksesuarData[playerid][index][1],AksesuarData[playerid][index][2],AksesuarData[playerid][index][3],AksesuarData[playerid][index][4],AksesuarData[playerid][index][5],AksesuarData[playerid][index][6],AksesuarData[playerid][index][7],AksesuarData[playerid][index][8], RGBAToARGB(0x33AA33FF), RGBAToARGB(0x33AA33FF));
	}
	return 1;
}

stock SetVehicleSpeed(vehicleid, Float:speed)
{
	new Float:x1, Float:y1, Float:z1, Float:x2, Float:y2, Float:z2, Float:a;
	GetVehicleVelocity(vehicleid, x1, y1, z1);
	GetVehiclePos(vehicleid, x2, y2, z2);
	GetVehicleZAngle(vehicleid, a); a = 360 - a;
	x1 = (floatsin(a, degrees) * (speed/100) + floatcos(a, degrees) * 0 + x2) - x2;
	y1 = (floatcos(a, degrees) * (speed/100) + floatsin(a, degrees) * 0 + y2) - y2;
	SetVehicleVelocity(vehicleid, x1, y1, z1);
}

IRPC:VehicleDestroyed(playerid, BitStream:bs)
{
    new vehicleid;

    BS_ReadUint16(bs, vehicleid);

    if (GetVehicleModel(vehicleid) < 400)
    {
        return 0;
    }

    return OnVehicleRequestDeath(vehicleid, playerid);
}


stock fuckYou(playerid)
{
	AdminMessage(COLOR_LIGHTRED, "[Anti Cheat] %s (%d) adlý kiþi /.dcar Hilesi kullanýyor.", ReturnName(playerid, 0),playerid);
	Log_Write("logs/antihile.txt", "[%s] %s /.dcar hilesi kullanýyor olabilir. (Sebep: /.dcar Hilesi)", ReturnDate(), Player_GetName(playerid));
    return 1;
}

#if !defined IsNaN
    #define IsNaN(%0) ((%0) != (%0))
#endif

const UNOCCUPIED_SYNC = 209;

IPacket:UNOCCUPIED_SYNC(playerid, BitStream:bs)
{
    new unoccupiedData[PR_UnoccupiedSync];

    BS_IgnoreBits(bs, 8);
    BS_ReadUnoccupiedSync(bs, unoccupiedData);

    if (IsNaN(unoccupiedData[PR_roll][0]) ||
        IsNaN(unoccupiedData[PR_roll][1]) ||
        IsNaN(unoccupiedData[PR_roll][2]) ||
        IsNaN(unoccupiedData[PR_direction][0]) ||
        IsNaN(unoccupiedData[PR_direction][1]) ||
        IsNaN(unoccupiedData[PR_direction][2]) ||
        IsNaN(unoccupiedData[PR_position][0]) ||
        IsNaN(unoccupiedData[PR_position][1]) ||
        IsNaN(unoccupiedData[PR_position][2]) ||
        IsNaN(unoccupiedData[PR_angularVelocity][0]) ||
        IsNaN(unoccupiedData[PR_angularVelocity][1]) ||
        IsNaN(unoccupiedData[PR_angularVelocity][2]) ||
        IsNaN(unoccupiedData[PR_velocity][0]) ||
        IsNaN(unoccupiedData[PR_velocity][1]) ||
        IsNaN(unoccupiedData[PR_velocity][2]) ||
        (floatabs(unoccupiedData[PR_roll][0]) > 1.0) ||
        (floatabs(unoccupiedData[PR_roll][1]) > 1.0) ||
        (floatabs(unoccupiedData[PR_roll][2]) > 1.0) ||
        (floatabs(unoccupiedData[PR_direction][0]) > 1.0) ||
        (floatabs(unoccupiedData[PR_direction][1]) > 1.0) ||
        (floatabs(unoccupiedData[PR_direction][2]) > 1.0) ||
        (floatabs(unoccupiedData[PR_position][0]) > 20000.0) ||
        (floatabs(unoccupiedData[PR_position][1]) > 20000.0) ||
        (floatabs(unoccupiedData[PR_position][2]) > 20000.0) ||
        (floatabs(unoccupiedData[PR_angularVelocity][0]) > 1.0) ||
        (floatabs(unoccupiedData[PR_angularVelocity][1]) > 1.0) ||
        (floatabs(unoccupiedData[PR_angularVelocity][2]) > 1.0) ||
        (floatabs(unoccupiedData[PR_velocity][0]) > 100.0) ||
        (floatabs(unoccupiedData[PR_velocity][1]) > 100.0) ||
        (floatabs(unoccupiedData[PR_velocity][2]) > 100.0)
    ) {
        fuckYou2(playerid);
        return 0;
    }

    return 1;
}

stock fuckYou2(playerid)
{
	AdminMessage(COLOR_LIGHTRED, "[Anti Cheat] %s (%d) adlý kiþi Player Crasher Hilesi kullanýyor olabilir.", ReturnName(playerid, 0),playerid);
	Log_Write("logs/antihile.txt", "[%s] %s sistem tarafindan hile kullanýyor olabilir. (Sebep: Player Crasher Hilesi)", ReturnDate(), Player_GetName(playerid));
    return 1;
}
stock NPC_Nearest(playerid)
{
	for (new i; i<MAXIMUM_NPC; i++) if (NPCBilgi[i][npcExists] == true && GetPlayerDistanceFromPoint(playerid, NPCBilgi[i][npcPos][0], NPCBilgi[i][npcPos][1], NPCBilgi[i][npcPos][2]) < 4.0)
 	{
  		return i;
  	}
   	return -1;
}
stock GetPlayerWalkingStyle(playerid)
{
	return PlayerData[playerid][pAyarlar][9];
}
stock IsPlayerRunning(playerid)
{
    if (!IsPlayerConnected(playerid)) return 0;
    if (IsPlayerInAnyVehicle(playerid)) return 0;
    new keys, updown, leftright;
    GetPlayerKeys(playerid, keys, updown, leftright);
    if (keys & KEY_SPRINT) return 1;
    return 0;
}

stock IsPlayerAiming(playerid)
{
    new anim = GetPlayerAnimationIndex(playerid);
    if (((anim >= 1160) && (anim <= 1163)) || (anim == 1167) || (anim == 1365) ||
    (anim == 1643) || (anim == 1453) || (anim == 220)) return 1;
    return 0;
}

stock GetMoveDirectionFromKeys(ud, lr)
{
	new direction = 0;

    if (lr < 0)
	{
		if (ud < 0) 		direction = MOVE_FORWARD_LEFT; 	// Up & Left key pressed
		else if (ud > 0) direction = MOVE_BACK_LEFT; 	// Back & Left key pressed
		else            direction = MOVE_LEFT;          // Left key pressed
	}
	else if (lr > 0) 	// Right pressed
	{
		if (ud < 0)      direction = MOVE_FORWARD_RIGHT;  // Up & Right key pressed
		else if (ud > 0) direction = MOVE_BACK_RIGHT;     // Back & Right key pressed
		else			direction = MOVE_RIGHT;          // Right key pressed
	}
	else if (ud < 0) 	direction = MOVE_FORWARD; 	// Up key pressed
	else if (ud > 0) 	direction = MOVE_BACK;		// Down key pressed

	return direction;
}

stock YatSur(playerid)
{
	new Float:pos[3], Float:rot[3];
	GetObjectPos(YatBilgi[yatObject], pos[0], pos[1], pos[2]);
	GetObjectRot(YatBilgi[yatObject], rot[0], rot[1], rot[2]);

	switch (PlayerData[playerid][pYatKontrol][1])
	{
	    case MOVE_FORWARD:
	    {
	        pos[0] += (1 * floatsin(-rot[2], degrees));
			pos[1] += (1 * floatcos(-rot[2], degrees));
	        MoveObject(YatBilgi[yatObject], pos[0], pos[1], pos[2], 6, rot[0], rot[1], rot[2]);
	    }
	    case MOVE_BACK:
	    {
	        pos[0] += (1 * floatsin(-rot[2]+180, degrees));
			pos[1] += (1 * floatcos(-rot[2]+180, degrees));
	        MoveObject(YatBilgi[yatObject], pos[0], pos[1], pos[2], 6, rot[0], rot[1], rot[2]);
	    }
     	case MOVE_FORWARD_LEFT:
	    {
	        pos[0] += (1 * floatsin(-rot[2], degrees));
			pos[1] += (1 * floatcos(-rot[2], degrees));
			rot[2] += 0.5;
			MoveObject(YatBilgi[yatObject], pos[0], pos[1], pos[2], 6, rot[0], rot[1], rot[2]);
	    }
	    case MOVE_FORWARD_RIGHT:
	    {
	        pos[0] += (1 * floatsin(-rot[2], degrees));
			pos[1] += (1 * floatcos(-rot[2], degrees));
			rot[2] -= 0.5;
			MoveObject(YatBilgi[yatObject], pos[0], pos[1], pos[2], 6, rot[0], rot[1], rot[2]);
	    }
	    case MOVE_BACK_LEFT:
	    {
	        pos[0] += (1 * floatsin(-rot[2]+180, degrees));
			pos[1] += (1 * floatcos(-rot[2]+180, degrees));
			rot[2] -= 0.5;
	        MoveObject(YatBilgi[yatObject], pos[0], pos[1], pos[2], 6, rot[0], rot[1], rot[2]);
	    }
	    case MOVE_BACK_RIGHT:
	    {
	        pos[0] += (1 * floatsin(-rot[2]+180, degrees));
			pos[1] += (1 * floatcos(-rot[2]+180, degrees));
			rot[2] += 0.5;
	        MoveObject(YatBilgi[yatObject], pos[0], pos[1], pos[2], 6, rot[0], rot[1], rot[2]);
	    }
	}
	PlayerData[playerid][pYatKontrol][2] = GetTickCount();
	return 1;
}

stock IsAPlane(vehicleid)
{
	switch (GetVehicleModel(vehicleid)) {
		case 460, 464, 476, 511, 512, 513, 519, 520, 553, 577, 592, 593: return 1;
	}
	return 0;
}

Float:GetVehSpeed(vid)
{
    new Float:vx, Float:vy, Float:vz, Float:vel;
	vel = GetVehicleVelocity(vid, vx, vy, vz);
	vel = (floatsqroot(((vx*vx)+(vy*vy))+(vz*vz))* 181.5);
	return vel;
}
forward Float:AracCan(aracid);
stock Float:AracCan(aracid)
{
	new Float: aCani;
	GetVehicleHealth(aracid, aCani);
	return aCani;
}
stock HileKontrol(playerid)
{
	if (PlayerData[playerid][pAdmin] > 1) return false;
	if (!IsPlayerNearPNS(playerid) && IsPlayerInAnyVehicle(playerid) && AracCan(GetPlayerVehicleID(playerid)) > 999.9)
	{
	    AdminMessage(COLOR_LIGHTRED, "AdmLog: %s adlý oyuncu araç tamir hilesi kullanmaya çalýþtýðý için oyundan atýldý.", Player_GetName(playerid));
	    Log_Write("logs/antihile.log", "[%s] %s adlý oyuncu araç tamir hilesi kullanmaya çalýþtýðý için oyundan atýldý.", ReturnDate(), Player_GetName(playerid));
	    return Kick(playerid);
	}
	return 0;
}
stock PlayerHasTazer(playerid)
{
    return (GetPlayerWeapon(playerid) == 23 && PlayerData[playerid][pTazer]);
}

stock PlayerHasBeanbag(playerid)
{
    return (GetPlayerWeapon(playerid) == 25 && PlayerData[playerid][pBeanbag]);
}
stock LabelleriYukle()
{
	new yukle;
	for(new labelid = 0; labelid < MAX_LABEL; labelid++)
	{
		new File: jensenL = fopen(LabelDosya(labelid), io_read);
		if(jensenL)
		{
			new jstr[250];
			fread(jensenL, jstr);
			sscanf(jstr, "p<>>s[120]dddffff", Label[labelid][LabelAdi], Label[labelid][Renk], Label[labelid][VW], Label[labelid][Int], Label[labelid][Pos][0], Label[labelid][Pos][1], Label[labelid][Pos][2], Label[labelid][Mesafe]);
			Label[labelid][objeID] = CreateDynamicObject(1, Label[labelid][Pos][0], Label[labelid][Pos][1], Label[labelid][Pos][2], 0, 0, 0, Label[labelid][VW], Label[labelid][Int]);
			Label[labelid][ID] = CreateDynamic3DTextLabel(Label[labelid][LabelAdi], Label[labelid][Renk], Label[labelid][Pos][0], Label[labelid][Pos][1], Label[labelid][Pos][2], Label[labelid][Mesafe], INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, Label[labelid][VW], Label[labelid][Int], -1);
			yukle++;
			fclose(jensenL);
		}
	}
	if(yukle >= 1)
		printf(" [Sistem] Toplam y?klenen label: %d", yukle);
	else
		print(" [Sistem] Toplam y?klenen label: Yok");
	return 1;
}

stock LabelDosya(labelid)
{
	new jdosya[65];
	format(jdosya, sizeof(jdosya), "/Labeller/%d.cfg", labelid);
	return jdosya;
}

stock LabelGuncelle(labelid)
{
	if(!fexist(LabelDosya(labelid)))
	{
		fcreate(LabelDosya(labelid));
	}
	new jstr[250], File: jensenR = fopen(LabelDosya(labelid), io_write);
	format(jstr, sizeof(jstr), "%s>%d>%d>%d>%f>%f>%f>%f\r\n", Label[labelid][LabelAdi], Label[labelid][Renk], Label[labelid][VW], Label[labelid][Int], Label[labelid][Pos][0], Label[labelid][Pos][1], Label[labelid][Pos][2], Label[labelid][Mesafe]);
	fwrite(jensenR, jstr);
	return fclose(jensenR);
}

stock Oyuncuadi(playerid)
{
	new isim[MAX_PLAYER_NAME];
	GetPlayerName(playerid, isim, MAX_PLAYER_NAME);
	return isim;
}

stock BosLabelID()
{
	for(new labelid = 0; labelid < MAX_LABEL; labelid++)
	{
		if(!fexist(LabelDosya(labelid)))
		{
			return labelid;
		}
	}
	return -1;
}
stock AnimationCheck(playerid)
{
    return (GetPlayerState(playerid) == PLAYER_STATE_ONFOOT && !PlayerData[playerid][pBaygin] && !PlayerData[playerid][pKelepce] && !PlayerData[playerid][pSoklandi]  && !PlayerData[playerid][pYereYatirildi] && GetPVarInt(playerid, "IpBaglandi") == 0);
}

stock ShowCarColorList(playerid,dialogid,Caption[],Button1[],Button2[])
{
    new BigString[3098];
    for(new i = 0; i < sizeof(ColorList); i++)
	{
		format(BigString, sizeof(BigString), "%s%s", BigString, ColorList[i]);
	}
	ShowPlayerDialog(playerid,dialogid,DIALOG_STYLE_MSGBOX,Caption,BigString,Button1,Button2);
}

stock PlaySoundEx(soundid, Float:x, Float:y, Float:z, range)
{
        foreach (new i : Player)
        {
                if (!OyundaDegil(i)) continue;
                if (!IsPlayerInRangeOfPoint(i, range, x, y, z)) continue;
                PlayerPlaySound(i, soundid, 0, 0, 0);
        }
}
stock Ev_GetKeyCount(houseid)
{
	if (HouseInfo[houseid][evExists])
	{
	    new query[100];
	    format(query, sizeof(query), "SELECT null FROM `anahtarlar` WHERE `sqlid` = '%d' AND `tip` = '1'", HouseInfo[houseid][evID]);
	    new Cache:cachee = mysql_query(g_SQL, query);
	    new rows;
	    cache_get_row_count(rows);
	    cache_delete(cachee);
	    return rows;
	}
	return 0;
}

stock Arac_GetKeyCount(aracid)
{
	if (AracInfo[aracid][aracExists])
	{
	    new query[100];
	    format(query, sizeof(query), "SELECT null FROM `anahtarlar` WHERE `sqlid` = '%d' AND `tip` = '2'", AracInfo[aracid][aracID]);
	    new Cache:cachee = mysql_query(g_SQL, query);
	    new rows;
	    cache_get_row_count(rows);
	    cache_delete(cachee);
	    return rows;
	}
	return 0;
}

stock Arac_KeyDialog(playerid, aracid)
{
	if (AracInfo[aracid][aracExists])
	{
	    new query[100];
	    format(query, sizeof(query), "SELECT * FROM `anahtarlar` WHERE `sqlid` = '%d' AND `tip` = '2'", AracInfo[aracid][aracID]);
	    new Cache:cachee = mysql_query(g_SQL, query);
	    new rows;
	    cache_get_row_count(rows);
	    if (rows)
	    {
	        new psqlid, str[300];
	        for (new i; i<rows; i++)
	        {
	            cache_get_value_name_int(i, "playersqlid", psqlid);
	            format(str, sizeof(str), "%s{FFFFFF}%s\n", str, SQLName(psqlid, 0));
	            KeyListeleme[playerid][i] = psqlid;
	        }
	        cache_delete(cachee);
	        SetPVarInt(playerid, "KeyDeleteCarID", aracid);
	        Dialog_Show(playerid, AracAnahtarlar, DIALOG_STYLE_LIST, "{AA3333}Anahtarlar", str, "Sil", "Geri");
		}
		else
		{
		    DeletePVar(playerid, "KeyDeleteCarID");
		    callcmd::arac(playerid);
		}
	}
	return 1;
}

stock Ev_KeyDialog(playerid, houseid)
{
	if (HouseInfo[houseid][evExists])
	{
	    new query[100];
	    format(query, sizeof(query), "SELECT * FROM `anahtarlar` WHERE `sqlid` = '%d' AND `tip` = '1'", HouseInfo[houseid][evID]);
	    new Cache:cachee = mysql_query(g_SQL, query);
	    new rows;
	    cache_get_row_count(rows);
	    if (rows)
	    {
	        new psqlid, str[300];
	        for (new i; i < rows; i++)
	        {
	            cache_get_value_name_int(i, "playersqlid", psqlid);
	            format(str, sizeof(str), "%s{FFFFFF}%s\n", str, SQLName(psqlid, 0));
	            KeyListeleme[playerid][i] = psqlid;
	        }
	        cache_delete(cachee);
	        SetPVarInt(playerid, "KeyDeleteHouseID", houseid);
	        Dialog_Show(playerid, EvAnahtarlar, DIALOG_STYLE_LIST, "{AA3333}Anahtarlar", str, "Sil", "Geri");
		}
		else
		{
		    DeletePVar(playerid, "KeyDeleteHouseID");
		    callcmd::ev(playerid);
		}
	}
	return 1;
}

stock OyuncuAnahtarlar(playerid)
{
	new query[100];
	format(query, sizeof(query), "SELECT * FROM `anahtarlar` WHERE `playersqlid` = '%d'", PlayerData[playerid][pID]);
	new Cache:Radless = mysql_query(g_SQL, query);
	new rows;
	cache_get_row_count(rows);
	if (!rows) return HataMesajGonder(playerid, "Size verilmiþ hiç anahtar yok.");
	new str[2500], string[124], sqlid, givesqlid, tip, id;
	strcat(str, "{FF0000}Tip\t{FF0000}Ev Adý/Araç Model\n");
	for (new i; i<rows; i++)
	{
	    cache_get_value_name_int(i, "sqlid", sqlid);
	    cache_get_value_name_int(i, "givesqlid", givesqlid);
	    cache_get_value_name_int(i, "tip", tip);
	    if (tip == 1)
	    {
			id = Ev_GetID(sqlid);
	        format(string, sizeof(string), "{38c5f7}%s", HouseInfo[id][evIsim]);
		}
		else if (tip == 2)
		{
		    id = Car_GetID2(sqlid);
		    format(string, sizeof(string), "{38c5f7}%s", ReturnVehicleModelName(AracInfo[id][aracModel]));
		}
		KeyListeleme[playerid][i] = sqlid;
		KeyListelemeTip[playerid][i] = tip;
		format(string, sizeof(string), "{38c5f7}%s\t{38c5f7}%s\n",(tip == 1) ? ("Ev") : ("Araç"), string);
		strcat(str, string);
	}
	cache_delete(Radless);
	format(string, sizeof(string), "{B8860B}Anahtarlarýnýz (%d adet)", rows);
	Dialog_Show(playerid, OyuncuAnahtar, DIALOG_STYLE_TABLIST_HEADERS, string, str, "Sil", "Kapat");
	return 1;
}
stock MobilyaMenu(playerid, id)
{
	if (HouseInfo[id][evSahip] != PlayerData[playerid][pID] && HouseInfo[id][MobilyaYetki] != PlayerData[playerid][pID]) return HataMesajGonder(playerid, "Mobilya düzenleme yetkiniz bulunmamaktadýr.");
	new str[100];
   	SetPVarInt(playerid, "FurnitureHouse", id);
	format(str, sizeof(str), "{FFFFFF}Mobilyalar (%d/%d)", Ev_MobilyaSayisi(id), GetMaxFurniture(playerid, id));
	Dialog_Show(playerid, Mobilya, DIALOG_STYLE_LIST, str, "{FFFFFF}Mobilya Satýn Al (Liste)\n{FFFFFF}Mobilya Satýn Al (Obje ID)\n{FFFFFF}Mobilya Düzenle\n{FFFFFF}Mobilya Sat\n{FFFFFF}Mobilya Kopyala\n{FFFFFF}Mobilya Materyallerini Düzenle\n{FFFFFF}Son Eklenen Mobilyayý Sil\n{FFFFFF}Mobilya Yetkilendirme\n{FFFFFF}Kapýya Git\n{FF0000}Tüm Mobilyalarý Sat", "Seç", "Kapat");
	return 1;
}
stock GetMaxFurniture(playerid, evid)
{
	new evmax = HouseInfo[evid][evMaksMobilya];
	switch (PlayerData[playerid][pVip])
	{
	    case 1: evmax += 60;
	    case 2: evmax += 120;
	    case 3: evmax += 200;
	}
	return evmax;
}
stock NPC_Secenekler(playerid, id)
{
	new str[600];
	for (new i; i<MAX_SECENEK; i++)
	{
		format(str, sizeof(str), "%s{E74C3C}» {FFFFFF}Seçenek %d: %s\n{E74C3C}» {FFFFFF}Seçenek %d Cevap: %s\n", str, i, NPCSecenekler[id][i], i, NPCSecenekCevaplar[id][i]);
	}
	SetPVarInt(playerid, "npcid", id);
	Dialog_Show(playerid, Secenekler, DIALOG_STYLE_LIST, "Seçenekler", str, "Seç", "Kapat");
	return 1;
}

stock Soru_Sil(soruid)
{
    new query[124];
    format(query,sizeof(query), "DELETE FROM `sorular` WHERE `sid` = '%d'",SoruData[soruid][soruID]);
    mysql_query(g_SQL,query,false);
    SoruData[soruid][soruExists] = false;
    format(SoruData[soruid][Soru],50, "");
    format(SoruData[soruid][SoruCevap],128, "");
    SoruData[soruid][OkunmaSayisi] = 0;
    format(SoruData[soruid][EklenmeTarihi],25, "");
    format(SoruData[soruid][Ekleyen],24, "");
	return 1;
}

stock SoruSayisi()
{
    new sayi;
    for (new i; i<MAX_SORU; i++)
    {
        if (SoruData[i][soruExists])
        {
            sayi++;
        }
    }
    return sayi;
}

stock Soru_Ekle(Soruu[], sCevap[], EkleyenAdam[])
{
    if (SoruSayisi() >= MAX_SORU) return 1;
    for (new i; i<MAX_SORU; i++)
    {
        if (!SoruData[i][soruExists])
        {
            SoruData[i][soruExists] = true;
            format(SoruData[i][Soru],50,Soruu);
            format(SoruData[i][SoruCevap],128,sCevap);
            SoruData[i][OkunmaSayisi] = 0;
            format(SoruData[i][EklenmeTarihi],25,ReturnDate());
            format(SoruData[i][Ekleyen],24,EkleyenAdam);

            new query[500];

            SoruData[i][soruID] = i;

			mysql_format(g_SQL, query, sizeof(query), "INSERT INTO `sorular` (`sid`, `Soru`,`Cevap`,`Tarih`,`Ekleyen`) VALUES ('%d', '%s','%s','%s','%s')", i, SQL_ReturnEscaped(Soruu),SQL_ReturnEscaped(sCevap),ReturnDate(),EkleyenAdam);
            mysql_query (g_SQL, query);
            return i;
        }
    }
    return -1;

}

stock GetCarOwnerID(vehicleid)
{
	new id = Car_GetID(vehicleid);
	if (id == -1) return -1;
	return GetPlayerIDWithSQLID(AracInfo[id][aracSahip]);
}

stock Ekonomi_Menu(playerid)
{
    new str[550];
    strcat(str, "Ad\tDeðer\n");
    format(str, sizeof(str), "%s{FFFFFF}Sivil Maaþý\t{2ECC71}%s\n", str, FormatNumber(GetServerBilgi("SaatlikMaas")));
    format(str, sizeof(str), "%s{FFFFFF}Maaþ Vergi\t{2ECC71}%s\n", str, FormatNumber(GetServerBilgi("MaasVergi")));
    format(str, sizeof(str), "%s{FFFFFF}Giþe Ücreti\t{2ECC71}%s\n", str, FormatNumber(GetServerBilgi("GiseUcreti")));
    format(str, sizeof(str), "%s{FFFFFF}Benzin Fiyatý\t{2ECC71}%s\n", str, FormatNumber(GetServerBilgi("BenzinFiyat")));
    format(str, sizeof(str), "%s{FFFFFF}Tamirci Ücreti\t{2ECC71}%s", str, FormatNumber(GetServerBilgi("TamirciUcret")));
    Dialog_Show(playerid, Ekonomi, DIALOG_STYLE_TABLIST_HEADERS, "Ekonomi", str, "Ayarla", "Kapat");
	return 1;
}

GetMaksAmmo(silahid)
{
	new mermi = 0;
	switch (silahid)
	{
	    case 22: mermi = 102;
	    case 24: mermi = 42;
	    case 25: mermi = 30;
	    case 28: mermi = 200;
	    case 29: mermi = 150;
	    case 30, 31: mermi = 300;
	    case 33: mermi = 30;
	}
	return mermi;
}

stock GetMermiFiyat(silahid)
{
	new fiyat = 0;
	switch (silahid)
	{
	    case 22: fiyat = 2000;
	    case 24: fiyat = 2000;
	    case 25: fiyat = 2000;
	    case 28: fiyat = 2000;
	    case 29: fiyat = 2000;
	    case 30: fiyat = 2000;
	    case 33: fiyat = 2000;
	}
	return fiyat;
}

SilahAveraj(playerid)
{
	new averaj = 0;
	switch(PlayerData[playerid][pVip])
	{
	    case 0: averaj = 1;
	    case 1: averaj = 2;
	    case 2: averaj = 3;
	    case 3: averaj = 5;
	    default: averaj = 1;
	}
	return averaj;
}

SilahUretimSaat(playerid)
{
	new saat = 0;
	switch(PlayerData[playerid][pVip])
	{
		case 0: saat = 128;
		case 1: saat = 72;
		case 2: saat = 48;
		case 3: saat = 24;
		default: saat = 128;
	}
	return saat;
}

stock Arac_AnahtarVar(playerid, carid)
{
	if (AracInfo[carid][aracExists])
	{
	    new query[256];

	    mysql_format(g_SQL, query, sizeof(query), "SELECT null FROM `anahtarlar` WHERE `playersqlid` = '%d' AND `sqlid` = '%d' AND `tip` = '2'", PlayerData[playerid][pID], AracInfo[carid][aracID]);
	    mysql_query (g_SQL, query);

	 	new rows = cache_num_rows();

	    if (rows)
			return true;
	}
	return false;
}

stock Ev_AnahtarVar(playerid, evid)
{
	if (HouseInfo[evid][evExists])
	{
	    new query[124];
	    format(query, sizeof(query), "SELECT null FROM `anahtarlar` WHERE `playersqlid` = '%d' AND `sqlid` = '%d' AND `tip` = '1'", PlayerData[playerid][pID], HouseInfo[evid][evID]);
	    new Cache:Radless = mysql_query(g_SQL, query);
	    new rows;
	    cache_get_row_count(rows);
	    cache_delete(Radless);
	    if (rows) return 1;
	}
	return 0;
}

stock ProxDetector(Float:radi, playerid, string[], color)
{
    new Float:x,Float:y,Float:z;
    GetPlayerPos(playerid,x,y,z);
    foreach (new i: Player)
    {
        if (IsPlayerInRangeOfPoint(i,radi,x,y,z))
        {
            SendClientMessage(i,color,string);
        }
    }
}
ProxDetector2(Float:radi, playerid, string[], col1, col2, col3, col4, col5)
{
    new Float:pPositionX[3], Float:oPositionX[3];
    GetPlayerPos(playerid, pPositionX[0], pPositionX[1], pPositionX[2]);
    foreach (Player, i)
    {
        GetPlayerPos(i, oPositionX[0], oPositionX[1], oPositionX[2]);
        if (IsPlayerInRangeOfPoint(i, radi / 16, pPositionX[0], pPositionX[1], pPositionX[2])) { SendClientMessage(i, col1, string); }
        else if (IsPlayerInRangeOfPoint(i, radi / 8, pPositionX[0], pPositionX[1], pPositionX[2])) { SendClientMessage(i, col2, string); }
        else if (IsPlayerInRangeOfPoint(i, radi / 4, pPositionX[0], pPositionX[1], pPositionX[2])) { SendClientMessage(i, col3, string); }
        else if (IsPlayerInRangeOfPoint(i, radi / 2, pPositionX[0], pPositionX[1], pPositionX[2])) { SendClientMessage(i, col4, string); }
        else if (IsPlayerInRangeOfPoint(i, radi, pPositionX[0], pPositionX[1], pPositionX[2])) { SendClientMessage(i, col5, string); }
    }
    return 1;
}
Car_GetCount(playerid)
{
	new
		count = 0;

	for (new i = 0; i != MAX_ARAC; i ++)
	{
		if (AracInfo[i][aracExists] && AracInfo[i][aracSahip] == PlayerData[playerid][pID])
   		{
   		    count++;
		}
	}
	return count;
}

Isyeri_AracSil(bizid, modelid)
{
	static
	    query[128];
 	for (new i = 0; i != MAX_DEALERSHIP_CARS; i ++) if (DealershipCars[bizid][i][vehModel] == modelid)
	{
		    DealershipCars[bizid][i][vehModel] = 0;
		    DealershipCars[bizid][i][vehPrice] = 0;

		    format(query, sizeof(query), "DELETE FROM `galeriaraclar` WHERE `ID` = '%d' AND `vehID` = '%d'", Isyeri[bizid][isyeriID], DealershipCars[bizid][i][vehID]);
			mysql_query(g_SQL, query, false);

			return 1;
	}
	return 0;
}

stock HouseSelect(playerid)
{
	new str[300], string[100];
	strcat(str, "{FF0000}ID\t{FF0000}Ev Adý\t{FF0000}Kiyafet Sayisi\n");
	for (new i; i<MAX_EV; i++)
	{
	    if (HouseInfo[i][evExists])
	    {
	        if (HouseInfo[i][evSahip] == PlayerData[playerid][pID] || HouseInfo[i][evKiralayan] == PlayerData[playerid][pID])
	        {
	            format(string, sizeof(string), "{FFFFFF}%d\t{FFFFFF}%s\t{FFFFFF}%d/5", i, HouseInfo[i][evIsim], EvGetKiyafetCount(i));
	            strcat(str, string);
	        }
	    }
	}
	Dialog_Show(playerid, EvSelect, DIALOG_STYLE_TABLIST_HEADERS, "Ev Seç", str, "Seç", "Iptal");
	return 1;
}
stock EvGetKiyafetCount(houseid)
{
    if (!HouseInfo[houseid][evExists]) return 1;
	new count = 0;
	for (new i; i<5; i++)
	{
	    if (HouseInfo[houseid][evKiyafetler][i] > 0)
	    {
	        count++;
	    }
	}
	return count;
}
stock PMMessage(color, const str[], {Float,_}:...)
{
static
    args,
    start,
    end,
    string[144]
;
#emit LOAD.S.pri 8
#emit STOR.pri args

if (args > 8)
{
#emit ADDR.pri str
#emit STOR.pri start

    for (end = start + (args - 8); end > start; end -= 4)
{
        #emit LREF.pri end
        #emit PUSH.pri
}
#emit PUSH.S str
#emit PUSH.C 144
#emit PUSH.C string

#emit LOAD.S.pri 8
#emit ADD.C 4
#emit PUSH.pri

#emit SYSREQ.C format
#emit LCTRL 5
#emit SCTRL 4

        foreach (new i : Player)
{
if (PlayerData[i][pAdmin] >= 2 && PlayerData[i][PMKapali] == 0) {
  SendClientMessage(i, color, string);
}
}
return 1;
}
foreach (new i : Player)
{
if (PlayerData[i][pAdmin] >= 2 && PlayerData[i][PMKapali] == 0) {
SendClientMessage(i, color, str);
}
}
return 1;
}

public OnPlayerModelSelectionEx(playerid, response, extraid, modelid)
{
	if(response)
	{
		switch(extraid)
		{
			case SATILIK_ARACLAR:
			{
				GaleriAracDetaylari(playerid, modelid);
			}
		}
	}

	return 1;
}

stock GaleriAracDetaylari(playerid, modelid)
{
	new query[51 + 11 + 1];

	mysql_format(g_SQL, query, sizeof(query), "SELECT fiyat FROM satilikaraclar WHERE model = '%d'", modelid);
	mysql_tquery(g_SQL, query, "AracDetaylariGoruntule", "dd", playerid, modelid);

	return 1;
}

stock Jammer_Near(playerid)
{
    for (new i = 0; i != MAX_JAMMERS; i ++) if (JammerData[i][jammerExists] && IsPlayerInRangeOfPoint(playerid, JammerData[i][jammerMenzil], JammerData[i][jammerPos][0], JammerData[i][jammerPos][1], JammerData[i][jammerPos][2]))
	{
		return 1;
	}
	return 0;
}

IsPlayerHaveWeapon(playerid, weaponid)
{
	for (new i = 0; i < 13; i++)
	{
	    if (PlayerData[playerid][pSilahlar][i] == weaponid)
	        return true;
	}
	return false;
}

Vehicle_LogCount(vehicleid)
{
	if (GetVehicleModel(vehicleid) == 0) return 0;
	new count;

	for (new i; i < LOG_LIMIT; i++)
		if (IsValidDynamicObject(LogObjects[vehicleid][i])) count++;

	return count;
}

GetClosestLog(playerid, Float: range = 2.0)
{
	new id = -1, Float: dist = range, Float: tempdist, Float: pos[3];

	foreach (new i : Logs)
	{
		GetDynamicObjectPos(LogData[i][logObjID], pos[0], pos[1], pos[2]);
	    tempdist = GetPlayerDistanceFromPoint(playerid, pos[0], pos[1], pos[2]);

	    if (tempdist > range) continue;
		if (tempdist <= dist)
		{
			dist = tempdist;
			id = i;
		}
	}

	return id;
}

stock YukseltmeFiyat(seviye)
{
	new fiyat = 2500;

	if(seviye >= 1)
		fiyat = seviye * 2500;

	return fiyat;
}

stock Silahci_Goster(playerid)
{
    new str[1024];
    strcat(str, "{ffffff}Silah\t{ffffff}Ücret\t{ffffff}Parça\n");
    format(str, sizeof(str), "%sColt-45\t%s\t%s\n", str, FormatNumber(ColtFiyat), FormatNumber(ColtMat));
    format(str, sizeof(str), "%sDesert Eagle\t%s\t%s\n", str, FormatNumber(DeagleFiyat), FormatNumber(DeagleMat));
    format(str, sizeof(str), "%sShotgun\t%s\t%s\n", str, FormatNumber(ShotgunFiyat), FormatNumber(ShotgunMat));
    format(str, sizeof(str), "%sCuntgun\t%s\t%s\n", str, FormatNumber(CuntgunFiyat), FormatNumber(CuntgunMat));
    format(str, sizeof(str), "%sAK-47\t%s\t%s\n", str, FormatNumber(KelesFiyat), FormatNumber(KelesMat));
    Dialog_Show(playerid, SilahUretim, DIALOG_STYLE_TABLIST_HEADERS, "{DC2222}Silah Üretim:{ffffff} Menü", str, "Seç", "Kapat");
	return 1;
}

stock Mermici_Goster(playerid)
{
    new str[550];
    format(str, sizeof(str), "%sÞarjör Al\n", str);
    format(str, sizeof(str), "%sMermi Al\n", str);
    Dialog_Show(playerid, MermiSatinal, DIALOG_STYLE_TABLIST, "{DC2222}Mermi Alým:{ffffff} Menü", str, "Seç", "Kapat");
	return 1;
}

stock Parcaci_Goster(playerid)
{
    new str[550];
    format(str, sizeof(str), "%sGovde\tÜcret: %s\tParça: %d\n", str, FormatNumber(GovdePara), GovdeMat);
    format(str, sizeof(str), "%sNamlu\tÜcret: %s\tParça: %d\n", str, FormatNumber(NamluPara), NamluMat);
    format(str, sizeof(str), "%sKabza\tÜcret: %s\tParça: %d\n", str, FormatNumber(KabzaPara), KabzaMat);
    Dialog_Show(playerid, ParcaAl, DIALOG_STYLE_TABLIST, "{DC2222}Parça Alým:{ffffff} Menü", str, "Seç", "Kapat");
	return 1;
}
stock GetXYInFrontOfToll(objectid, &Float:x, &Float:y, Float:distance)
{
    new Float:rot[3];

    GetDynamicObjectPos(objectid, x, y, rot[0]);
    GetDynamicObjectRot(objectid, rot[0], rot[1], rot[2]);

	x += (distance * floatsin(-rot[2]+270, degrees));
    y += (distance * floatcos(-rot[2]+270, degrees));
}


// ------------------------ ADMIN KOMUTLARI ------------------------------------
stock SilahiVarmi(playerid)
{
	for (new i; i <13; i++)
	{
		if (PlayerData[playerid][pSilahlar][i] > 0)
		    return 1;
 	}
	return 0;
}

stock Envanter_Goster(playerid)
{
	new str[2500], esyasayisi;
	strcat(str, "{FFFFFF}Eþya Adý\t{FFFFFF}Miktar\n");
	if (PlayerData[playerid][pSu] > 0) format(str, sizeof(str), "%s{FFFFFF}Su\t{FFFFFF}%d adet\n", str, PlayerData[playerid][pSu]), esyasayisi++;
	if (PlayerData[playerid][pTelefon] != -1) format(str, sizeof(str), "%s{FFFFFF}Telefon\t{FFFFFF}1 adet\n", str), esyasayisi++;
	if (PlayerData[playerid][pRadyo] > 0) format(str, sizeof(str), "%s{FFFFFF}Portatif Radyo\t{FFFFFF}1 adet\n", str), esyasayisi++;
	if (PlayerData[playerid][pEhliyet] != 0) format(str, sizeof(str), "%s{FFFFFF}Sürücü lisansý\t{FFFFFF}1 adet\n", str), esyasayisi++;
	if (PlayerData[playerid][pMotorEhliyet] != 0) format(str, sizeof(str), "%s{FFFFFF}Motor lisansý\t{FFFFFF}1 adet\n", str), esyasayisi++;
	if (PlayerData[playerid][pEsyalar][0] > 0) format(str, sizeof(str), "%s{FFFFFF}Zar\t{FFFFFF}1 adet\n", str), esyasayisi++;
	if (PlayerData[playerid][pEsyalar][1] > 0) format(str, sizeof(str), "%s{FFFFFF}Sigara\t{FFFFFF}%d adet\n", str, PlayerData[playerid][pEsyalar][1]), esyasayisi++;
	if (PlayerData[playerid][pEsyalar][2] > 0) format(str, sizeof(str), "%s{FFFFFF}Ýp\t{FFFFFF}%d adet\n", str, PlayerData[playerid][pEsyalar][2]), esyasayisi++;
	if (PlayerData[playerid][pEsyalar][3] > 0) format(str, sizeof(str), "%s{FFFFFF}Göz Baðý\t{FFFFFF}%d adet\n", str, PlayerData[playerid][pEsyalar][3]), esyasayisi++;
	if (PlayerData[playerid][pEsyalar][4] > 0) format(str, sizeof(str), "%s{FFFFFF}Maske\t{FFFFFF}1 adet\n", str), esyasayisi++;
	if (PlayerData[playerid][pEsyalar][5] > 0) format(str, sizeof(str), "%s{FFFFFF}Benzin Bidonu\t{FFFFFF}%d adet\n", str, PlayerData[playerid][pEsyalar][5]), esyasayisi++;
	if (PlayerData[playerid][pEsyalar][6] > 0) format(str, sizeof(str), "%s{FFFFFF}Barbekü\t{FFFFFF}1 adet\n", str), esyasayisi++;
	if (PlayerData[playerid][pEsyalar][7] > 0) format(str, sizeof(str), "%s{FFFFFF}Köfte\t{FFFFFF}%d adet\n", str, PlayerData[playerid][pEsyalar][7]), esyasayisi++;
	if (PlayerData[playerid][pEsyalar][8] > 0) format(str, sizeof(str), "%s{FFFFFF}Tavuk Eti\t{FFFFFF}%d adet\n", str, PlayerData[playerid][pEsyalar][8]), esyasayisi++;
	if (PlayerData[playerid][pEsyalar][9] > 0) format(str, sizeof(str), "%s{FFFFFF}Dana Eti\t{FFFFFF}%d adet\n", str, PlayerData[playerid][pEsyalar][9]), esyasayisi++;
	if (PlayerData[playerid][pEsyalar][10] > 0) format(str, sizeof(str), "%s{FFFFFF}Tamir Kiti\t{FFFFFF}%d adet\n", str, PlayerData[playerid][pEsyalar][10]), esyasayisi++;
	if (PlayerData[playerid][pEsyalar][11] > 0) format(str, sizeof(str), "%s{FFFFFF}Portatif Çadýr\t{FFFFFF}1 adet\n", str), esyasayisi++;
	if (PlayerData[playerid][pEsyalar][12] > 0) format(str, sizeof(str), "%s{FFFFFF}Kamp Ateþi\t{FFFFFF}1 adet\n", str), esyasayisi++;
	if (PlayerData[playerid][pEsyalar][13] > 0) format(str, sizeof(str), "%s{FFFFFF}Þarjör\t{FFFFFF}1 adet\n", str), esyasayisi++;

	if(SilahiVarmi(playerid) == 1)
		format(str, sizeof(str), "%s{FFFFFF}Silah Envanteri", str);

	if (!esyasayisi && SilahiVarmi(playerid) == 0) return HataMesajGonder(playerid, "Envanteriniz boþ.");
	Dialog_Show(playerid, Envanter, DIALOG_STYLE_TABLIST_HEADERS, "{E74C3C}Envanter", str, "Seç", "Kapat");
	return 1;
}

stock AracKiraladi(playerid)
{
	for (new i; i < MAX_ARAC; i++)
	{
		if (AracInfo[i][aracExists] && AracInfo[i][aracTip] == 3 && AracInfo[i][aracKiralayan] == PlayerData[playerid][pID])
			return 1;
	}
	return 0;
}

stock Kiralik_Araci(playerid)
{
	for (new i = 0; i < MAX_ARAC; i++)
	{
	    if (AracInfo[i][aracExists])
	    {
	        if (AracInfo[i][aracTip] == 3 && AracInfo[i][aracKiralayan] == PlayerData[playerid][pID])
	            return AracInfo[i][aracID];
	    }
	}
	return -1;
}

stock Arsa_Sil(id)
{
	ArsaBilgi[id][arsaExists] = 0;
	ArsaBilgi[id][arsaSahip] = -1;
	ArsaBilgi[id][arsaTip] = 0;
	ArsaBilgi[id][arsaFiyat] = 0;
	ArsaBilgi[id][KiraSure] = 0;
	ArsaBilgi[id][arsaMaxTohum] = 0;
	ArsaBilgi[id][Metrekare] = 0;
	DestroyDynamicPickup(ArsaBilgi[id][arsaPickup]);
	DestroyDynamic3DTextLabel(ArsaBilgi[id][arsaLabel]);
	stmt_bind_value(RemoveArsa, 0, DB::TYPE_INTEGER, id);
	stmt_execute(RemoveArsa);
	for (new i; i<MAX_TOHUM; i++) if (Tohumlar[i][tohumArsa] == id)
	{
	    DestroyDynamicObject(Tohumlar[i][tohumObject]);
		DestroyDynamic3DTextLabel(Tohumlar[i][tohumLabel]);
		Tohumlar[i][tohumArsa] = -1;
  		Tohumlar[i][tohumTip] = 0;
  		Tohumlar[i][tohumBuyume] = 0;
    	Tohumlar[i][tohumPos][0] = Tohumlar[i][tohumPos][1] = Tohumlar[i][tohumPos][2] = 0.0;
	}
	return 1;
}
stock TohumUpdate(id)
{
	if (!IsValidDynamicObject(Tohumlar[id][tohumObject]))
	{
	    switch (Tohumlar[id][tohumBuyume])
	    {
	        case 0..19:
	        {
	            if (Tohumlar[id][tohumTip] != 4) Tohumlar[id][tohumObject] = CreateDynamicObject(19473, Tohumlar[id][tohumPos][0], Tohumlar[id][tohumPos][1], Tohumlar[id][tohumPos][2]-1, 0.0, 0.0, 0.0);
	            else Tohumlar[id][tohumObject] = CreateDynamicObject(2244, Tohumlar[id][tohumPos][0], Tohumlar[id][tohumPos][1], Tohumlar[id][tohumPos][2] - 0.70, 0.0, 0.0, 0.0);
	        }
	        case 20..39:
	        {
	            if (Tohumlar[id][tohumTip] != 4) Tohumlar[id][tohumObject] = CreateDynamicObject(681, Tohumlar[id][tohumPos][0], Tohumlar[id][tohumPos][1], Tohumlar[id][tohumPos][2]-1, 0.0, 0.0, 0.0);
	            else
	            {
	                Tohumlar[id][tohumObject] = CreateDynamicObject(2244, Tohumlar[id][tohumPos][0], Tohumlar[id][tohumPos][1], Tohumlar[id][tohumPos][2] - 0.70, 0.0, 0.0, 0.0);
	                SetDynamicObjectMaterial(Tohumlar[id][tohumObject], 2, 2, "plants_TABLETOP", "CJ_PLANT", 0xFF2ECC71);
	            }
	        }
	        case 40..60:
	        {
	            if (Tohumlar[id][tohumTip] != 4) Tohumlar[id][tohumObject] = CreateDynamicObject(737, Tohumlar[id][tohumPos][0], Tohumlar[id][tohumPos][1], Tohumlar[id][tohumPos][2]-1, 0.0, 0.0, 0.0);
	            else
	            {
	                Tohumlar[id][tohumObject] = CreateDynamicObject(2244, Tohumlar[id][tohumPos][0], Tohumlar[id][tohumPos][1], Tohumlar[id][tohumPos][2] - 0.70, 0.0, 0.0, 0.0);
	                SetDynamicObjectMaterial(Tohumlar[id][tohumObject], 2, 2, "plants_TABLETOP", "CJ_PLANT", 0xFFD35400);
	            }
	        }
	    }
	}
	new str[100], tohumtipi[15];
	switch (Tohumlar[id][tohumTip])
 	{
  		case 1: tohumtipi = "Domuz";
    	case 2: tohumtipi = "Ayý";
     	case 3: tohumtipi = "Kurt";
     	case 4: tohumtipi = "Uyuþturucu";
  	}
	if (!IsValidDynamic3DTextLabel(Tohumlar[id][tohumLabel]))
	{
	    if (Tohumlar[id][tohumBuyume] >= 60)
	    {
	        format(str, sizeof(str), "{BBFFEE}%s\n{BBFFEE}Kalan: Bitti\n{BBFFEE}%s Sayýsý: %d", tohumtipi, tohumtipi, Tohumlar[id][tohumSayi]);
	        Tohumlar[id][tohumLabel] = CreateDynamic3DTextLabel(str, -1, Tohumlar[id][tohumPos][0], Tohumlar[id][tohumPos][1], Tohumlar[id][tohumPos][2], 5.0);
	    }
	    else
	    {
	        format(str, sizeof(str), "{BBFFEE}%s\n{BBFFEE}Kalan: %d dakika", tohumtipi, 60-Tohumlar[id][tohumBuyume]);
	        Tohumlar[id][tohumLabel] = CreateDynamic3DTextLabel(str, -1, Tohumlar[id][tohumPos][0], Tohumlar[id][tohumPos][1], Tohumlar[id][tohumPos][2], 5.0);
	    }
	}
    if (Tohumlar[id][tohumBuyume] >= 60)
    {
    	format(str, sizeof(str), "{BBFFEE}%s\n{BBFFEE}Kalan: Bitti\n{BBFFEE}%s Sayýsý: %d", tohumtipi, tohumtipi, Tohumlar[id][tohumSayi]);
    }
    else
    {
    	format(str, sizeof(str), "{BBFFEE}%s\n{BBFFEE}Kalan: %d dakika", tohumtipi, 60-Tohumlar[id][tohumBuyume]);
    }
    UpdateDynamic3DTextLabelText(Tohumlar[id][tohumLabel], -1, str);
	return 1;
}
stock Arsa_TohumSayisi(id)
{
	new sayi;
	for (new i; i<MAX_TOHUM; i++) if (Tohumlar[i][tohumArsa] == id)
	{
	    sayi++;
	}
	return sayi;
}
stock TohumKontrol(playerid)
{
	for (new i; i<MAX_TOHUM; i++) if (Tohumlar[i][tohumArsa] != -1 && IsPlayerInRangeOfPoint(playerid, 2.0, Tohumlar[i][tohumPos][0], Tohumlar[i][tohumPos][1], Tohumlar[i][tohumPos][2]))
	{
	    return i;
	}
	return -1;
}
stock ArsaNearest(playerid)
{
	for (new i; i<MAX_ARSA; i++) if (ArsaBilgi[i][arsaExists] && IsPlayerInRangeOfPoint(playerid, ArsaBilgi[i][Metrekare], ArsaBilgi[i][arsaPos][0], ArsaBilgi[i][arsaPos][1], ArsaBilgi[i][arsaPos][2]))
	{
	    return i;
	}
	return -1;
}
stock Arsa_Inside(playerid)
{
	for (new i; i<MAX_ARSA; i++) if (ArsaBilgi[i][arsaExists] && IsPlayerInRangeOfPoint(playerid, 2.5, ArsaBilgi[i][arsaPos][0], ArsaBilgi[i][arsaPos][1], ArsaBilgi[i][arsaPos][2]))
	{
	    return i;
	}
	return -1;
}
stock Arsa_Olustur(playerid, tip, metrekare, fiyat, maxtohum)
{
	for (new i; i<MAX_ARSA; i++) if (!ArsaBilgi[i][arsaExists])
	{
	    ArsaBilgi[i][arsaExists] = 1;
	    ArsaBilgi[i][arsaSahip] = -1;
	    ArsaBilgi[i][arsaTip] = tip;
	    GetPlayerPos(playerid, ArsaBilgi[i][arsaPos][0], ArsaBilgi[i][arsaPos][1], ArsaBilgi[i][arsaPos][2]);
	    ArsaBilgi[i][arsaFiyat] = fiyat;
	    ArsaBilgi[i][arsaMaxTohum] = maxtohum;
	    ArsaBilgi[i][Metrekare] = metrekare;
	    ArsaBilgi[i][KiraSure] = 0;
	    stmt_bind_value(AddArsa, 0, DB::TYPE_INTEGER, i);
		stmt_bind_value(AddArsa, 1, DB::TYPE_INTEGER, -1);
	    stmt_bind_value(AddArsa, 2, DB::TYPE_FLOAT, ArsaBilgi[i][arsaPos][0]);
	    stmt_bind_value(AddArsa, 3, DB::TYPE_FLOAT, ArsaBilgi[i][arsaPos][1]);
	    stmt_bind_value(AddArsa, 4, DB::TYPE_FLOAT, ArsaBilgi[i][arsaPos][2]);
	    stmt_bind_value(AddArsa, 5, DB::TYPE_INTEGER, tip);
	    stmt_bind_value(AddArsa, 6, DB::TYPE_INTEGER, fiyat);
	    stmt_bind_value(AddArsa, 7, DB::TYPE_INTEGER, 0);
	    stmt_bind_value(AddArsa, 8, DB::TYPE_INTEGER, metrekare);
	    stmt_bind_value(AddArsa, 9, DB::TYPE_INTEGER, maxtohum);
		ArsaUpdate(i);
	    if (stmt_execute(AddArsa)) return i;
	    else return -1;

	}
	return -1;
}
stock Arsa_Kaydet(id)
{
	stmt_bind_value(UpdateArsa, 0, DB::TYPE_INTEGER, ArsaBilgi[id][arsaSahip]);
	stmt_bind_value(UpdateArsa, 1, DB::TYPE_FLOAT, ArsaBilgi[id][arsaPos][0]);
	stmt_bind_value(UpdateArsa, 2, DB::TYPE_FLOAT, ArsaBilgi[id][arsaPos][1]);
	stmt_bind_value(UpdateArsa, 3, DB::TYPE_FLOAT, ArsaBilgi[id][arsaPos][2]);
	stmt_bind_value(UpdateArsa, 4, DB::TYPE_INTEGER, ArsaBilgi[id][arsaTip]);
	stmt_bind_value(UpdateArsa, 5, DB::TYPE_INTEGER, ArsaBilgi[id][arsaFiyat]);
	stmt_bind_value(UpdateArsa, 6, DB::TYPE_INTEGER, ArsaBilgi[id][KiraSure]);
	stmt_bind_value(UpdateArsa, 7, DB::TYPE_INTEGER, ArsaBilgi[id][Metrekare]);
	stmt_bind_value(UpdateArsa, 8, DB::TYPE_INTEGER, ArsaBilgi[id][arsaMaxTohum]);
	stmt_bind_value(UpdateArsa, 9, DB::TYPE_INTEGER, id);
	stmt_execute(UpdateArsa);
	return 1;
}
stock ArsaUpdate(id)
{
	if (!IsValidDynamic3DTextLabel(ArsaBilgi[id][arsaLabel]))
	{
	    ArsaBilgi[id][arsaLabel] = CreateDynamic3DTextLabel("Çiftlik", -1, ArsaBilgi[id][arsaPos][0], ArsaBilgi[id][arsaPos][1], ArsaBilgi[id][arsaPos][2], ArsaBilgi[id][Metrekare], INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);
	}
	if (!IsValidDynamicPickup(ArsaBilgi[id][arsaPickup]))
	{
	    ArsaBilgi[id][arsaPickup] = CreateDynamicPickup(954, 23, ArsaBilgi[id][arsaPos][0], ArsaBilgi[id][arsaPos][1], ArsaBilgi[id][arsaPos][2]);
	}
	new str[185];
	if (ArsaBilgi[id][arsaSahip] == -1)
	{
	    if (ArsaBilgi[id][arsaTip] == 1)
	    {
	        format(str, sizeof(str), "{FFC100}Satýlýk Çiftlik\n[%d Dönüm Arsa]\n[/satinal]\n\n{C8C8C8}Çiftlik Sahibi: {FFFFFF}Yok\n{C8C8C8}Satýlýk Fiyatý: {FFFFFF}%s\n{C8C8C8}Hayvan Kapasitesi: {FFFFFF}%d", ArsaBilgi[id][Metrekare], FormatNumber(ArsaBilgi[id][arsaFiyat]), ArsaBilgi[id][arsaMaxTohum]);
	    }
	    else
	    {
	        format(str, sizeof(str), "{FFC100}Kiralýk Çiftlik\n[%d Dönüm Arsa]\n[/ciftkirala]\n\n{C8C8C8}Kiralayan: {FFFFFF}Yok\n{C8C8C8}Saatlik Fiyatý: {FFFFFF}%s\n{C8C8C8}Hayvan Kapasitesi: {FFFFFF}%d", ArsaBilgi[id][Metrekare], FormatNumber(ArsaBilgi[id][arsaFiyat]), ArsaBilgi[id][arsaMaxTohum]);
	    }
	}
	else
	{
	    if (ArsaBilgi[id][arsaTip] == 1)
	    {
	        format(str, sizeof(str), "{FFC100}Çiftlik\n[%d Dönüm Arsa]\n\n{C8C8C8}Sahip: {FFFFFF}%s\n{C8C8C8}Hayvan Kapasitesi: {FFFFFF}%d", ArsaBilgi[id][Metrekare], SQLName(ArsaBilgi[id][arsaSahip], 0), ArsaBilgi[id][arsaMaxTohum]);
	    }
	    else
	    {
	        new secs = ArsaBilgi[id][KiraSure] - gettime();
	    	new kalansaat = floatround(secs / 3600);
	        format(str, sizeof(str), "{FFC100}Kiralýk Çiftlik\n[%d Dönüm Arsa]\n\n{C8C8C8}Kiralayan: {FFFFFF}%s\n{C8C8C8}Kira Süresi: {FFFFFF}%d\n{C8C8C8}Hayvan Kapasitesi: {FFFFFF}%d", ArsaBilgi[id][Metrekare], SQLName(ArsaBilgi[id][arsaSahip], 0), kalansaat, ArsaBilgi[id][arsaMaxTohum]);
	    }
	}
	UpdateDynamic3DTextLabelText(ArsaBilgi[id][arsaLabel], -1, str);
	return 1;
}
stock SoruListele(playerid,anahtarkelime[])
{
	new str[2500],sayi;
	for (new i; i<MAX_SORU; i++)
	{
		if (SoruData[i][soruExists])
		{
			if (strfind(SoruData[i][Soru], anahtarkelime, true) != -1)
			{
				format(str,sizeof(str), "%s%s\n",str,SoruData[i][Soru]);
				SoruListeleme[playerid][sayi] = i;
				sayi++;
				if (sayi >= 45) break;
			}
		}
	}
	if (!sayi)
	{
	    HataMesajGonder(playerid, "Yazdýðýnýz anahtar kelimeye ait hiç soru bulunamadý.");
	    return Dialog_Show(playerid, SistemSoru, DIALOG_STYLE_INPUT, "Sisteme Sor", "{FFFFFF}Lütfen sorunuz hakkýnda bir anahtar kelime giriniz: \n\n{ff0000}NOT: {FFFFFF}Anahtar kelimesi 3 ile 20 karakter arasýnda olmalýdýr.", "Devam", "Kapat");
	}
	format(AnahtarKelime[playerid],20,anahtarkelime);
	Dialog_Show(playerid,Sorular,DIALOG_STYLE_LIST, "Sorular",str, "Görüntüle", "Geri");
	return 1;
}
stock SikcaSorulanSorular(playerid)
{
    new query[124],Cache:VeriCek;
    mysql_format(g_SQL, query, sizeof(query), "SELECT `Soru`,`sid` FROM `sorular` ORDER BY `OkunmaSayisi` DESC LIMIT 10");
    VeriCek = mysql_query(g_SQL, query);
    new rows = cache_num_rows();
    if (rows)
    {
        new list[1024],count = 1, sid, Question[50];
        for (new i = 0; i < rows; ++i)
        {
            cache_get_value_name(i, "Soru", Question, 50);
            cache_get_value_name_int(i, "sid", sid);
            SoruListeleme[playerid][count-1] = SoruIDBul(sid);
            format(list,sizeof(list), "%s{FF0000}%d){FFFFFF} %s\n", list, count, Question);
            count++;
        }
        Dialog_Show(playerid,top10soru,DIALOG_STYLE_LIST, "Sýkça Sorulan 10 Soru",list, "Görüntüle", "{FF0000}Kapat");
    }
    cache_delete(VeriCek);
    return 1;
}
stock SoruIDBul(questionid)
{
    for (new i; i<MAX_SORU; i++)
    {
        if (SoruData[i][soruExists] && SoruData[i][soruID] == questionid)
        {
            return i;
        }
    }
    return -1;
}
stock pbOdalari(playerid)
{
    new str[500], string[100], sayi = 0;
	strcat(str, "{FF0000}ID\t{FF0000}Ad\t{FF0000}Oyun Türü\t{FF0000}Maç Süresi\n");
	for (new i=0; i != MAX_ODA; i++) if (Paintball[i][odaExists])
	{
	    format(string, sizeof(string), "{58D67A}%d\t{58D67A}%s\t{58D67A}%s\t{58D67A}%d dk\n", i, Paintball[i][odaIsim], (Paintball[i][odaOyunTuru] == 1) ? ("TDM") : ("DM"), Paintball[i][odaSure]);
	    strcat(str, string);
	    sayi++;
	}
	if (sayi == 0) return HataMesajGonder(playerid, "Hiç oda yok.");
	format(string, sizeof(string), "{1DF21D}Odalar: %d", sayi);
	ShowPlayerDialog(playerid, DIALOG_KATIL, DIALOG_STYLE_TABLIST_HEADERS, string, str, "Katýl", "Iptal");
	return 1;
}

stock GiseKontrolu(playerid)
{
	new str[128];

	format(str, sizeof(str), "{FFFFFF}Giþeler: \t%s\n", (AcilDurumMu() == 1) ? ("{f72e2e}Kapalý") : ("{7bf72d}Açýk"));

	Dialog_Show(playerid, Giseler, DIALOG_STYLE_TABLIST, "Giþeler", str, "Seç", "Kapat");
	return 1;
}

stock AcilDurumMu()
{
	if (AcilDurum == 1)
	    return true;

	return false;
}

Toll_CloseToll(TollID)
{
    if (TollID == RichmanToll)
    {
        SetDynamicObjectRot(L_a_TollObject[0], 0.000000, -90.000000, 23.81982421875);
        SetDynamicObjectRot(L_a_TollObject[1], 0.000000, -90.000000, 214.37744140625);
    }
    else if (TollID == FlintToll)
    {
        SetDynamicObjectRot(L_a_TollObject[2], 0.000000, -90.000000, 270.67565917969);
        SetDynamicObjectRot(L_a_TollObject[3], 0.000000, -90.000000, 87.337799072266);
    }
    else if (TollID == LVToll)
    {
        SetDynamicObjectRot(L_a_TollObject[4], 0.000000, -90.000000, 348.10229492188);
        SetDynamicObjectRot(L_a_TollObject[5], 0.000000, -90.000000, 169.43664550781);
    }
    else if (TollID == BlueberryTollR)
    {
        SetDynamicObjectRot(L_a_TollObject[6], 0.00000, -90.00000, 35.00000);
        SetDynamicObjectRot(L_a_TollObject[7], 0.00000, -90.00000, 215.92000);
    }
    else if (TollID == BlueberryTollL)
    {
        SetDynamicObjectRot(L_a_TollObject[8], 0.00000, -90.00000, -14.94000);
        SetDynamicObjectRot(L_a_TollObject[9], 0.00000, -90.00000, -195.00000);
    }
    return 1;
}
stock GarajListele(playerid, id)
{
	new str[750], count;
	strcat(str, "ID\tTip\tPark Durumu\tAraç Limiti\n");
	for (new i; i<MAX_GARAGE; i++) if (GarageData[i][gExists] && GarageData[i][gSahip] == PlayerData[id][pID])
	{
	    count++;
	    format(str, sizeof(str), "%s{FFFFFF}%d\t{FFFFFF}%s\t%s\t{FFFFFF}%d\n", str, i, GarageData[i][gTip], (GarageData[id][gParkDurum]) ? ("{83e50b}Açýk") : ("{ff0000}Kapalý"), GarageData[id][gAracLimit]);
	}
	if (!count) return HataMesajGonder(playerid, "Hiç garaj yok.");
	Dialog_Show(playerid, Garajlarim, DIALOG_STYLE_TABLIST_HEADERS, "Garajlar", str, "Geri", "");
	return 1;
}
stock GateListele(playerid, id)
{
	new str[500], count;
	strcat(str, "ID\tAdres\n");
	for (new i; i<MAX_GATES; i++) if (GateData[i][gateExists] && GateData[i][gateOwner] == PlayerData[id][pID])
	{
	    count++;
	    format(str, sizeof(str), "%s%d\t%s, %s\n", str, i, GetLocation(GateData[i][gatePos][0], GateData[i][gatePos][1], GateData[i][gatePos][2]), GetCityName(GateData[i][gatePos][0], GateData[i][gatePos][1], GateData[i][gatePos][2]));
	}
	if (!count) return HataMesajGonder(playerid, "Hiç gate yok.");
	Dialog_Show(playerid, Evlerim, DIALOG_STYLE_TABLIST_HEADERS, "Gateleriniz", str, "Geri", "");
	return 1;
}
stock IsyeriListele(playerid, id)
{
	new str[500], count, tip[20];
	strcat(str, "ID\tAd\tAdres\tTip\n");
	for (new i; i<MAX_ISYERI; i++) if (Isyeri[i][isyeriExists] && Isyeri[i][isyeriSahip] == PlayerData[id][pID])
	{
	    count++;
	    switch (Isyeri[i][isyeriTip])
		{
		    case 1: tip = "Market";
		    case 2: tip = "Kiyafet Maðazasý";
		    case 3: tip = "Fast Food";
		    case 4: tip = "Araç Galerisi";
		    case 5: tip = "Elektronik";
		    case 6: tip = "Bar/Pub";
		    case 7: tip = "Kumarhane";
		}
	    format(str, sizeof(str), "%s%d\t%s\t%s, %s\t%s", str, i, Isyeri[i][isyeriName], GetLocation(Isyeri[i][isyeriPos][0], Isyeri[i][isyeriPos][1], Isyeri[i][isyeriPos][2]), GetCityName(Isyeri[i][isyeriPos][0], Isyeri[i][isyeriPos][1], Isyeri[i][isyeriPos][2]), tip);
	}
	if (!count) return HataMesajGonder(playerid, "Hiç iþyeri yok.");
	Dialog_Show(playerid, Evlerim, DIALOG_STYLE_TABLIST_HEADERS, "Ýþyerleriniz", str, "Geri", "");
	return 1;
}
stock EvListele(playerid, id)
{
	new str[1000], count;
	strcat(str, "ID\tAd\tAdres\n");
	for (new i; i<MAX_EV; i++) if (HouseInfo[i][evExists] && HouseInfo[i][evSahip] == PlayerData[id][pID])
	{
	    count++;
	    format(str, sizeof(str), "%s%d\t%s\t%s, %s\n", str, i, HouseInfo[i][evIsim], GetLocation(HouseInfo[i][evPos][0], HouseInfo[i][evPos][1], HouseInfo[i][evPos][2]), GetCityName(HouseInfo[i][evPos][0], HouseInfo[i][evPos][1], HouseInfo[i][evPos][2]));
	}
	if (!count) return HataMesajGonder(playerid, "Hiç ev yok.");
	Dialog_Show(playerid, Evlerim, DIALOG_STYLE_TABLIST_HEADERS, "Evleriniz", str, "Geri", "");
	return 1;
}

Yaris_ToplamKatilimci(yarisid)
{
	new sayi;
	foreach(new i : Player) {
	    if(PlayerData[i][pYaris] == yarisid) sayi++;
	}
	return sayi;
}

Obje_Olustur(playerid, modelid)
{
	new id = -1, Float:x, Float:y, Float:z, Float:ang;

	id = Iter_Free(Objeler);

	if (id != -1)
	{
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, ang);

		x += (2.5 * floatsin(ang, degrees));
		y += (2.5 * floatcos(ang, degrees));

		Obje[id][objeID] = id;
		Obje[id][objeModelID] = modelid;
		Obje[id][objeData] = CreateDynamicObject(modelid, x, y, z, 0.0, 0.0, ang, -1, -1, -1, STREAMER_OBJECT_SD, STREAMER_OBJECT_DD, -1, 0);

		SetPVarInt(playerid, "DuzenlenenObjeID", id);

		EditDynamicObject(playerid, Obje[id][objeData]);

		Iter_Add(Objeler, id);
		mysql_tquery(g_SQL, "INSERT INTO `objeler` (`objeModel`) VALUES(0)", "ObjeYaratildi", "d", id);
	}

	return id;
}

stock YetkinizYok(playerid) return HataMesaji(playerid, "Bu komutu kullanma yetkiniz yok!");
stock ParaYok(playerid) return HataMesaji(playerid, "Yeterli paranýz yok.");

Gise_Olustur(playerid)
{
	for (new i = 0; i < MAX_GISE; i++)
	{
	    if (!Gise[i][gs_Exists])
	    {
	        new Float:oPos[4];

	        GetPlayerPos(playerid, oPos[0], oPos[1], oPos[2]);
	        GetPlayerFacingAngle(playerid, oPos[3]);

	        Gise[i][gs_ID] = i;
	        Gise[i][gs_Exists] = true;

	        GetXYInFrontOfPlayer(playerid, oPos[0], oPos[1], 2.5);

			Gise[i][gs_GateObje] = CreateDynamicObject(966, oPos[0], oPos[1], oPos[2] - 0.940001, 0.0000000, 0.0000000, oPos[3]);

	        Gise[i][gs_GateBar][0] = oPos[0];
	        Gise[i][gs_GateBar][1] = oPos[1];
	        Gise[i][gs_GateBar][2] = oPos[2];
	        Gise[i][gs_GateBar][3] = 0.0;
	        Gise[i][gs_GateBar][4] = 0.0;
            Gise[i][gs_GateBar][5] = 0.0;

            SetPVarInt(playerid, "GiseGate", Gise[i][gs_ID]);

	        Gise[i][gs_Durum] = GISE_KAPALI;

	        BilgiMesajGonder(playerid, "Þimdi giþe gatesinin pozisyonunu ayarlayýn.");
	        EditDynamicObject(playerid, Gise[i][gs_GateObje]);
	        return i;
	    }
	}
	return -1;
}

Gise_Kaydet(id)
{
	new query[1024];

	mysql_format(g_SQL, query, sizeof query, "INSERT INTO `giseler` (`ID`, `GatePos`, `KapaliPos`, `AcikPos`) VALUES ('%d', '%f|%f|%f|%f|%f|%f', '%f|%f|%f|%f|%f|%f', '%f|%f|%f|%f|%f|%f')",
	Gise[id][gs_ID],

	Gise[id][gs_GateBar][0],
	Gise[id][gs_GateBar][1],
	Gise[id][gs_GateBar][2],
	Gise[id][gs_GateBar][3],
	Gise[id][gs_GateBar][4],
	Gise[id][gs_GateBar][5],

	Gise[id][gs_Kapali][0],
	Gise[id][gs_Kapali][1],
	Gise[id][gs_Kapali][2],
	Gise[id][gs_Kapali][3],
	Gise[id][gs_Kapali][4],
	Gise[id][gs_Kapali][5],

	Gise[id][gs_Acik][0],
	Gise[id][gs_Acik][1],
	Gise[id][gs_Acik][2],
	Gise[id][gs_Acik][3],
	Gise[id][gs_Acik][4],
	Gise[id][gs_Acik][5]
	);
	mysql_query (g_SQL, query);
	return true;
}

stock GetXYInFrontOfPlayer(playerid, &Float:x, &Float:y, Float:distance)
{
	new Float:a;
	GetPlayerPos(playerid, x, y, a);
	GetPlayerFacingAngle(playerid, a);
	if (GetPlayerVehicleID(playerid))
	{
	    GetVehicleZAngle(GetPlayerVehicleID(playerid), a);
	}
	x += (distance * floatsin(-a, degrees));
	y += (distance * floatcos(-a, degrees));
}

UyusturucuSaticisi_Guncelle(usID)
{
	new query[512];

	mysql_format(g_SQL, query, sizeof query, "UPDATE `uyusturucusaticilari` SET `Skin` = '%d' WHERE `ID` = '%d'", DealerData[usID][dealerSkin], DealerData[usID][dealerID]);
	mysql_query (g_SQL, query);

	mysql_format(g_SQL, query, sizeof query, "UPDATE `uyusturucusaticilari` SET `Uyusturucu` = '%d' WHERE `ID` = '%d'", DealerData[usID][dealerDrugs], DealerData[usID][dealerID]);
	mysql_query (g_SQL, query);

	mysql_format(g_SQL, query, sizeof query, "UPDATE `uyusturucusaticilari` SET `Pos` = '%f|%f|%f|%F' WHERE `ID` = '%d'", DealerData[usID][dealerX], DealerData[usID][dealerY], DealerData[usID][dealerZ], DealerData[usID][dealerA], DealerData[usID][dealerID]);
	mysql_query (g_SQL, query);

	mysql_format(g_SQL, query, sizeof query, "UPDATE `uyusturucusaticilari` SET `VirtualWorld` = '%d' WHERE `ID` = '%d'", DealerData[usID][dealerVw], DealerData[usID][dealerID]);
	mysql_query (g_SQL, query);

	return 1;
}

stock ParaDuzenle(playerid, amount)
{
	PlayerData[playerid][pCash] = 0;
	return ParaVer(playerid, amount);
}

// -----------------------------------------------------------------------------
// ----------------------------------- FUNCTIONS -------------------------------
stock ViewFactions(playerid)
{
	for (new i; i<MAX_BIRLIK; i++) if (Birlikler[i][birlikExists])
	{
	    Birlik_Kaydet(i);
	}

	new Cache:Radless = mysql_query(g_SQL, "SELECT * FROM `birlikler` ORDER BY `BirlikUyeSayisi` DESC LIMIT 10");
	new rows;
	cache_get_row_count(rows);
	if (rows)
	{
	    new str[1000], string[124], count, birlikname[32], tip, tipyazi[15], uyesayisi;
        strcat(str, "ID\tAd\tTip\tÜye Sayýsý\n");
        for (new i; i<rows; i++)
        {
            cache_get_value_name_int(i, "bid", count);
            cache_get_value_name(i, "bisim", birlikname, 32);
            cache_get_value_name_int(i, "btip", tip);
            cache_get_value_name_int(i, "BirlikUyeSayisi", uyesayisi);
            switch (tip)
     		{
	      		case 0: tipyazi = "Belirlenmiyor";
	      		case 1: tipyazi = "Çete";
	        	case 2: tipyazi = "Mafya";
	         	case 3: tipyazi = "Yayýn Ajansý";
	          	case 4: tipyazi = "Legal";
	           	default: tipyazi = "Özel Kurum";
      		}
	    	format(string, sizeof(string), "%d\t%s\t%s\t%d\n", count, birlikname, tipyazi, uyesayisi);
	    	strcat(str, string);
        }
        cache_delete(Radless);
        format(string, sizeof(string), "Birlikler (%d)", count);
        Dialog_Show(playerid, Birlikler, DIALOG_STYLE_TABLIST_HEADERS, string, str, "Kapat", "");
	}
	else
	{
		cache_delete(Radless);
		HataMesajGonder(playerid, "Hiç birlik yok.");
	}

	return 1;
}

stock SetPlayerToFacePlayer(playerid, targetid)
{
    new
        Float:x[2],
        Float:y[2],
        Float:z[2],
        Float:angle;

    GetPlayerPos(targetid, x[0], y[0], z[0]);
    GetPlayerPos(playerid, x[1], y[1], z[1]);

    angle = (180.0 - atan2(x[1] - x[0], y[1] - y[0]));
    SetPlayerFacingAngle(playerid, angle + (5.0 * -1));
}

stock ShowStats(playerid, id)
{
	if (!OyundaDegil(id)) return 1;
	new yseviye[40] = "Üye";
	new vip[20] = "Yok";
	new birlik[34] = "Yok";
	new rutbe[30] = "-";
	new partner[24] = "-";
	if (PlayerData[id][pAdmin] > 0)
	{
	    switch (PlayerData[id][pAdmin])
		{
  			case 1: yseviye = "{00592c}Game Admin{b9d3ee}";
	    	case 2: yseviye = "{a64814}Senior Admin{b9d3ee}";
		    case 3: yseviye = "{715426}High Senior Admin{b9d3ee}";
		    case 4: yseviye = "{ff0000}Lead Admin{b9d3ee}";
		    case 5: yseviye = "{ff0101}Management{b9d3ee}";
		    case 6: yseviye = "{ff0101}Management{b9d3ee}";
		    case 7: yseviye = "{588686}Developer{b9d3ee}";
		}
	}
	if (PlayerData[id][pHelper] > 0) format(yseviye, sizeof(yseviye), "Helper (%d){b9d3ee}", PlayerData[id][pHelper]);
	if (PlayerData[id][pVip] > 0) format(vip, sizeof(vip), "{%s}%s", GetVIPRenk(PlayerData[id][pVip]), GetVIPName(PlayerData[id][pVip]));
	if (PlayerData[id][pFaction] != -1 && Birlikler[PlayerData[id][pFaction]][birlikExists])
	{
	    format(birlik, sizeof(birlik), "%s (%d)", Birlikler[PlayerData[id][pFaction]][birlikAd], PlayerData[id][pFaction]);
	    format(rutbe, sizeof(rutbe), "%s", Birlik_GetRutbe(id));
	}
	if (PlayerData[id][pPartner] > 0) format(partner, sizeof(partner), "%s", SQLName(PlayerData[id][pPartner], 0));
	SendClientMessageEx(playerid, 0x66ED00AA, "{66ED00}//----------------------- %s (%d) -----------------------\\\\", ReturnName(id, 0), id);
	SendClientMessageEx(playerid, 0xF5F5F5AA, "[HESAP] SQLID: [%d] Seviye: [%d] Tecrübe: [%d/%d] Baþarý Puaný: [0]", PlayerData[id][pID], PlayerData[id][pLevel], PlayerData[id][pEXP],
	PlayerData[id][pLevel]*5);
	SendClientMessageEx(playerid, 0xB9D3EEAA , "[HESAP] Yönetici Seviyesi: [%s] V.I.P [%s{b9d3ee}] Bakiye: [%d] Baðýþçý: [Hayýr]", yseviye, vip, PlayerData[id][pBakiye], GetPlayerVirtualWorld(id), GetPlayerInterior(id));
	SendClientMessageEx(playerid, 0xF5F5F5AA, "[KARAKTER] Partner: [%s] Köken: [%s] Cinsiyet: [%s] Ten Rengi: [%s] Yaþ: [%d]",partner, PlayerData[id][pDogum], (PlayerData[id][pCinsiyet] == 1) ? ("Erkek") : ("Kadýn"), (PlayerData[id][pTen] == 1) ? ("Beyaz") : ("Siyah"),
	PlayerData[id][pYas]);
	SendClientMessageEx(playerid, 0xB9D3EEAA, "[KARAKTER] Birlik: [%s] Rütbe: [%s] Ýkinci Dil: [Seçilmedi]", birlik, rutbe);
	SendClientMessageEx(playerid, 0xF5F5F5AA, "[KARAKTER] Þirket: [Yok] Frekans: [%d] Slot: [0] Parça: [%d] Skin ID: [%d]", PlayerData[id][pFrekans], PlayerData[id][pMateryal], PlayerData[id][pSkin]);

	new silah_str[48];

	if(PlayerData[id][pSilahSuresi] > gettime())
	{
		new secs = PlayerData[id][pSilahSuresi] - gettime();

		new kalan_saat = floatround(secs / 3600);

		secs = secs - kalan_saat*3600;

		new kalan_dakika = floatround(secs / 60);

		secs = secs - kalan_dakika*60;

		format(silah_str, sizeof(silah_str), "%d saat, %d dakika, %d saniye", kalan_saat, kalan_dakika, secs);
	}else{
		format(silah_str, sizeof(silah_str), "Üretilebilir");
	}

 	SendClientMessageEx(playerid, 0xF5F5F5AA, "[KARAKTER] Kalan Silah Hakký: [%d] Silah Averajý: [%d] Kalan Silah Alma Süresi: [%s] ", PlayerData[id][pSilahHakki], SilahAveraj(id), silah_str);
	SendClientMessageEx(playerid, 0xB9D3EEAA, "[KARAKTER] Cüzdandaki Para: [%s] Çekilmemiþ Maaþ: [%s] Telefon: [%d] PayDay: [%d/60] Uyuþturucu: [%d gram]", FormatNumber(PlayerData[id][pCash]), FormatNumber(PlayerData[id][pMaas]),(PlayerData[id][pTelefon] == -1) ? (0) : (PlayerData[id][pTelefon]), floatround(PlayerData[id][pMaasSure]/60), PlayerDrugData[id][Drugs]);
	SendClientMessage(playerid, 0x66ED00AA, "{66FF00}------------------------------------------------------------------------------------");
	return 1;
}
stock FlipVehicle(vehicleid)
{
    new
        Float:fAngle;

    GetVehicleZAngle(vehicleid, fAngle);

    SetVehicleZAngle(vehicleid, fAngle);
    SetVehicleVelocity(vehicleid, 0.0, 0.0, 0.0);
    return 1;
}
stock SicilKontrol(playerid, id)
{
    new
        string[128];

    format(string, sizeof(string), "SELECT * FROM `oocsicil` WHERE `ID` = '%d'", PlayerData[id][pID]);
    mysql_tquery(g_SQL, string, "OnSicilView", "dd", playerid, id);
    return 1;
}
stock TalepListele(playerid)
{
	new str[3000], string[3000], count, ilgilenen[32];
	strcat(str, "ID\tÝçerik\tGönderen\tIlgilenen\n");

	for (new i; i<MAX_TALEP; i++) if (Talep[i][tExists] == true && IsPlayerConnected(Talep[i][tGonderen]))
	{
	    if (Talep[i][tIlgilenen] == -1) ilgilenen = " - ";
	    else format(ilgilenen, sizeof(ilgilenen), PlayerData[Talep[i][tIlgilenen]][pAdminName]);
	    count++;
	    format(string, sizeof(string), "{FFFFFF}%d\t{FFFFFF}%.24s\t{FFFFFF}%s (%d)\t{FFFFFF}%s\n", i, Talep[i][tIcerik], Player_GetName(Talep[i][tGonderen]), Talep[i][tGonderen], ilgilenen);
	    strcat(str, string);
	}

	if (!count) return Dialog_Show(playerid, TalepYok, DIALOG_STYLE_MSGBOX, "Destek Talepleri", "{FFFFFF}Hiç bekleyen rapor talebiniz yok.", "Yenile", "Kapat");
	format(string, sizeof(string), "Destek Talepleri (%d)", count);
	Dialog_Show(playerid, DestekTalepleri, DIALOG_STYLE_TABLIST_HEADERS, string, str, "Seç", "Kapat");
	return 1;
}

stock TalepIlgilen(playerid, id)
{
	if (PlayerData[playerid][pAdmin] > 0 || PlayerData[playerid][pHelper] > 0 || PlayerData[playerid][pForumGorevlisi] > 0 || PlayerData[playerid][pOyunGorevlisi] > 0)
	{
	    if (Talep[id][tExists] == false || (Talep[id][tIlgilenen] != -1 && Talep[id][tIlgilenen] != playerid)) return HataMesajGonder(playerid, "Rapor talebi silinmiþ veya baþkasý ilgileniyor...");

		new str[100];

		Talep[id][tIlgilenen] = playerid;
	    SetPVarInt(playerid, "TalepID", id);

		format(str, sizeof(str), "Talep #%d: %s (ID: %d)", id, Player_GetName(Talep[id][tGonderen]), Talep[id][tGonderen]);

		new string[128], anastring[400];

		if (strlen(Talep[id][tIcerik]) > 40)
			format(anastring, sizeof(anastring), "{808080}%.40s\n \n{808080}%s\n \n{FBF707}»{FFFFFF} Cevapla\n{FBF707}»{FFFFFF} Reddet\n{FBF707}»{FFFFFF} Foruma Yönlendir\n{FBF707}»{FFFFFF} Discorda Yönlendir\n{FBF707}»{FFFFFF} Uyar", Talep[id][tIcerik], Talep[id][tIcerik][40]);
		else
		    format(anastring, sizeof(anastring), "{808080}%s\n \n{808080}%s\n \n{FBF707}»{FFFFFF} Cevapla\n{FBF707}»{FFFFFF} Reddet\n{FBF707}»{FFFFFF} Foruma Yönlendir\n{FBF707}»{FFFFFF} Discorda Yönlendir\n{FBF707}»{FFFFFF} Uyar", Talep[id][tIcerik]);

		format(string, sizeof(string), "\n{2ECC71}» Ýncelemeye Al\n{E74C3C}» Ýncelendi ve Reddedildi");

		if(PlayerData[playerid][pAdmin] > 0)
			strcat(anastring, string);

	    Dialog_Show(playerid, TalepIncele, DIALOG_STYLE_LIST, str, anastring, "Seç", "Geri");
	}
	return 1;
}

stock Talep_GetCount(playerid)
{
	new count;
	for (new i; i<MAX_TALEP; i++) if (Talep[i][tExists] == true && Talep[i][tGonderen] == playerid)
	{
	    count++;
	}
	return count;
}
stock Talep_Add(playerid, icerik[])
{
	for (new i; i<MAX_TALEP; i++) if (Talep[i][tExists] == false)
	{
	    Talep[i][tExists] = true;
	    format(Talep[i][tIcerik], 128, icerik);
	    Talep[i][tGonderen] = playerid;
	    Talep[i][tIlgilenen] = -1;
	    return i;
	}
	return -1;
}
stock RemoveBan(ad[], ip[])
{
	new query[150];
	format(query, sizeof(query), "DELETE FROM `bans` WHERE `Ad` = '%s' OR `IP` = '%s'", ad, ip);
	mysql_query(g_SQL, query, false);
	if (strlen(ad) > 3)
	{
	    format(query, sizeof(query), "UPDATE `oyuncular` SET `Ban` = '0' WHERE `Isim` = '%s'", ad);
	    mysql_query(g_SQL, query, false);
	}
	return 1;
}
stock AddBan(bannedip[], bannedname[], hddserial[], bannedby[], gun, sebep[])
{
	new query[600];
	format(query, sizeof(query), "INSERT INTO `bans` (`IP`, `Ad`, `hddserial`, `Banlayan`, `Sure`, `Sebep`, `BanlanmaTarihi`) VALUES ('%s', '%s', '%s', '%s', '%d', '%s', '%s')", bannedip, bannedname, hddserial, bannedby, gun, sebep, ReturnDate());
	mysql_query(g_SQL, query, false);
	if (strlen(bannedname) > 3)
	{
	    format(query, sizeof(query), "UPDATE `oyuncular` SET `Ban` = '1' WHERE `Isim` = '%s'", bannedname);
	    mysql_query(g_SQL, query, false);
	}
	return 1;
}

stock ResetPlayer(playerid)
{
    if (HasTrash[playerid]) Trash_ResetPlayer(playerid);
    if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER && GetVehicleModel(GetPlayerVehicleID(playerid)) == 574)
    {
        SetVehicleToRespawn(GetPlayerVehicleID(playerid));
    }
	if (PetKontrol[playerid] != -1) callcmd::pet(playerid);
	foreach (new i:Petler) if (PetBilgi[i][petSahip] == PlayerData[playerid][pID] && PetBilgi[i][petDurum] == true)
	{
	    PetBilgi[i][petSaglik] = FCNPC_GetHealth(PetBilgi[i][NPCID]);
     	FCNPC_Destroy(PetBilgi[i][NPCID]);
      	PetBilgi[i][petTakip] = -1;
       	PetBilgi[i][NPCID] = -1;
        PetBilgi[i][petDurum] = false;
        DestroyDynamic3DTextLabel(PetBilgi[i][petText]);
        Pet_Kaydet(i);
	}
    Player_ResetCutting(playerid);
	Player_RemoveLog(playerid);
	EditingTreeID[playerid] = -1;
    if (RegenTimer[playerid] != -1)
	{
	    KillTimer(RegenTimer[playerid]);
	    RegenTimer[playerid] = -1;
	}
	foreach (new i : Player)
	{
	    if (PlayerDrugData[i][DrugsOfferedBy] == playerid)
	    {
	        PlayerDrugData[i][DrugsOfferedBy] = INVALID_PLAYER_ID;
	        ShowPlayerDialog(i, -1, DIALOG_STYLE_MSGBOX, "Title", "Content", "Button1", "Button2");
	    }
	}
	foreach (new i:Player) if (PlayerData[i][pAdmin] >= 1 && PlayerData[i][pSpecID] == playerid)
	{
	    IzlemeBitir(i);
	    GameTextForPlayer(i, "~r~Oyundan Cikti", 1000, 4);
	}
	RemoveEffects(playerid);
	Player_SaveDrugs(playerid);
    new id = CadirID(playerid);
   	if (id != -1)
   	{
   	    foreach (new i:Player) if (PlayerData[i][pCadir] == id)
        {
            PlayerData[i][pLegalTeleport] = gettime() + 2;
		    SetPlayerPos(i, CadirData[id][cadirPos][0], CadirData[id][cadirPos][1], CadirData[id][cadirPos][2]);
            SetPlayerInterior(i, 0);
            SetPlayerVirtualWorld(i, 0);
            PlayerData[i][pCadir] = -1;
        }
        Cadir_Sil(playerid);
  	}
  	PlayerData[playerid][pCadir] = -1;
    KumarReset(playerid, 1);
    KumarReset(GetPVarInt(playerid, "kumar_id"), 1);

	if (BalikTimer[playerid] != -1)
	{
	    KillTimer(BalikTimer[playerid]);
	    BalikTimer[playerid] = -1;
     	RemovePlayerAttachedObject(playerid, GetPVarInt(playerid, "OltaSlot"));
 		SetPVarInt(playerid, "OltaSlot", -1);
   		ClearAnimations(playerid);
   	}
   	if (PlayerData[playerid][pDestek] > 0)
   	{
   	    PlayerData[playerid][pDestek] = 0;
   	    DestekKapat(playerid, 1);
   	}
   	if (PlayerData[playerid][pBaygin] == 1)
   	{
   	    PlayerData[playerid][pBaygin] = 0;
    	PlayerData[playerid][pBayginSure] = 0;
    	CanAyarla(playerid, 100);
    	ClearAnimations(playerid);
   	}
   	if (PlayerData[playerid][pMangalKuruldu] == true)
   	{
   	    PlayerData[playerid][pMangalKuruldu] = false;
		DestroyDynamicObject(PlayerData[playerid][pMangalObject][0]);
		DestroyDynamicObject(PlayerData[playerid][pMangalObject][1]);
		DestroyDynamic3DTextLabel(PlayerData[playerid][MangalText]);
		PlayerData[playerid][pYemekPisiriliyor] = 0;
		PlayerData[playerid][pPisirilenYemek] = 0;

   	}
   	if (PlayerData[playerid][pKampAtesi] == true)
   	{
   	    PlayerData[playerid][pKampAtesi] = false;
        DestroyDynamicObject(PlayerData[playerid][pKampAtesiObject]);
        //MesajGonder(playerid, "Kamp Ateþi kaldýrýldý.");
  	}
   	PlayerData[playerid][yayinKonuk] = -1;
   	if (PlayerData[playerid][pAramada] != 0)
   	{
   		if (PlayerData[playerid][pAramada] == ARAMA_ARANIYOR)
   		{
   			//BilgiMesajGonder(PlayerData[playerid][pCallLine], "Gelen çaðrý reddedildi ((Oyundan çýktý))");
   			DeletePVar(playerid, "Arayan");
   			DeletePVar(PlayerData[playerid][pCallLine], "Arayan");
   			PlayerData[playerid][pAramada] = 0;
   			PlayerData[PlayerData[playerid][pCallLine]][pAramada] = 0;
   			PlayerData[PlayerData[playerid][pCallLine]][pCallLine] = 0;
   			PlayerData[playerid][pCallLine] = 0;
   		}
   		else if (PlayerData[playerid][pAramada] == ARAMA_ARIYOR)
   		{
   		    DeletePVar(playerid, "Arayan");
   			DeletePVar(PlayerData[playerid][pCallLine], "Arayan");
   			PlayerData[playerid][pAramada] = 0;
   			PlayerData[PlayerData[playerid][pCallLine]][pAramada] = 0;
   			PlayerData[PlayerData[playerid][pCallLine]][pCallLine] = 0;
   			PlayerData[playerid][pCallLine] = 0;
   		}
   		else if (PlayerData[playerid][pAramada] == ARAMA_KONUSUYOR)
   		{
   			//BilgiMesajGonder(PlayerData[playerid][pCallLine], "Konuþtuðunuz kiþi telefonu kapattý. (( Oyundan çýktý ))");
   			DeletePVar(playerid, "Arayan");
   			DeletePVar(PlayerData[playerid][pCallLine], "Arayan");
   			PlayerData[playerid][pAramada] = 0;
   			PlayerData[PlayerData[playerid][pCallLine]][pAramada] = 0;
   			PlayerData[PlayerData[playerid][pCallLine]][pCallLine] = 0;
   			PlayerData[playerid][pCallLine] = 0;
   		}
   	}
   	if (BoomboxData[playerid][boomboxPlaced])
		Boombox_Destroy(playerid);
	SetPlayerWantedLevel(playerid, 0);
	PlayerData[playerid][pAranma] = 0;
	PlayerData[playerid][pKelepce] = 0;
    PlayerData[playerid][pDragged] = 0;
	PlayerData[playerid][pDraggedBy] = INVALID_PLAYER_ID;
	KillTimer(PlayerData[playerid][pDragTimer]);
    SetPlayerCuffed(playerid, false);
    TogglePlayerControllable(playerid,true);
    SetPVarInt(playerid, "IpBaglandi", 0);
    SetPVarInt(playerid, "GozBaglandi", 0);
    TextDrawHideForPlayer(playerid, Karanlik);
    DisablePlayerCheckpoint(playerid);
    ShowPlayerDialog(playerid, -1, DIALOG_STYLE_MSGBOX, "", "", "", "");
	Fuel_ResetPlayer(playerid);
    return 1;
}
stock IzlemeBitir(playerid)
{
	TogglePlayerSpectating(playerid, false);
	PlayerData[playerid][pSpecID] = -1;
	SetWeapons(playerid);
    SetPlayerVirtualWorld(playerid, GetPVarInt(playerid, "specVw"));
    SetPlayerInterior(playerid, GetPVarInt(playerid, "specInterior"));
    SetPlayerPos(playerid, specPos[playerid][0], specPos[playerid][1], specPos[playerid][2]);
    return 1;
}

SendPlayerToPlayer(playerid, targetid)
{
    new
        Float:px,
        Float:py,
        Float:pz;

    GetPlayerPos(targetid, px, py, pz);

    if (IsPlayerInAnyVehicle(playerid))
    {
        SetVehiclePos(GetPlayerVehicleID(playerid), px, py + 2, pz);
        LinkVehicleToInteriorEx(GetPlayerVehicleID(playerid), GetPlayerInterior(targetid));
    }
    else
        SetPlayerPos(playerid, px + 1, py, pz);

    SetPlayerInterior(playerid, GetPlayerInterior(targetid));
    SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(targetid));

    PlayerData[playerid][pHouse] = PlayerData[targetid][pHouse];
    PlayerData[playerid][pIsyeri] = PlayerData[targetid][pIsyeri];
    PlayerData[playerid][pGarage] = PlayerData[targetid][pGarage];
    PlayerData[playerid][pCadir] = PlayerData[targetid][pCadir];
    return 1;
}
stock Hood_Sil(id)
{
    if (IsValidDynamic3DTextLabel(Hood[id][hLabel])) DestroyDynamic3DTextLabel(Hood[id][hLabel]);
	if (IsValidDynamicArea(Hood[id][hZone])) DestroyDynamicArea(Hood[id][hZone]);
	if (IsValidDynamicPickup(Hood[id][hPickup])) DestroyDynamicPickup(Hood[id][hPickup]);
	if (IsValidDynamicMapIcon(Hood[id][hMapIcon])) DestroyDynamicMapIcon(Hood[id][hMapIcon]);

	Hood[id][hExists] = false;
	Hood[id][hPos][0] = Hood[id][hPos][1] = Hood[id][hPos][2] = 0.0;
	Hood[id][hBirlik] = -1;
	new query[80];
	format(query, sizeof(query), "DELETE FROM `hood` WHERE `ID` = '%d'", Hood[id][hID]);
	mysql_query(g_SQL, query, false);
	Hood[id][hID] = 0;
	return 1;
}

stock Hood_Olustur(playerid, id)
{
	for (new i; i<MAX_HOOD; i++) if (Hood[i][hExists] == false)
	{
	    Hood[i][hExists] = true;
        Hood[i][hID] = i;

        Hood[i][hBirlik] = id;

	    GetPlayerPos(playerid, Hood[i][hPos][0],  Hood[i][hPos][1],  Hood[i][hPos][2]);

	    new query[256];
	    mysql_format(g_SQL, query, sizeof query, "INSERT INTO `hood` (`ID`, `hoodX`, `hoodY`, `hoodZ`, `Birlik`) VALUES ('%d', '%.2f', '%.2f', '%.2f', '%d')", Hood[i][hID], Hood[i][hPos][0],  Hood[i][hPos][1],  Hood[i][hPos][2], id);
	    mysql_query (g_SQL, query);

	    Hood_Yenile(i);
	    return i;
	}
	return -1;
}

stock TOGMenu(playerid)
{
	new str[400];
	format(str, sizeof(str), "{FFFFFF}Birlik & Telsiz Mesajlarý\t%s\n{FFFFFF}PM\t%s\n{FFFFFF}Yayýn & Reklam & Taksi\t%s\n{FFFFFF}Admin Ýþlemleri\t%s\n{FFFFFF}Otomatik Chat Animasyonu\t%s\nKarakter Ýsimleri\t%s\n", (PlayerData[playerid][pAyarlar][0] == 0) ? ("{7af442}Açýk") : ("{ff0000}Kapalý"), (PlayerData[playerid][pAyarlar][1] == 0) ? ("{7af442}Açýk") : ("{ff0000}Kapalý"),
    (PlayerData[playerid][pAyarlar][2] == 0) ? ("{7af442}Açýk") : ("{ff0000}Kapalý"), (PlayerData[playerid][pAyarlar][3] == 0) ? ("{7af442}Açýk") : ("{ff0000}Kapalý"), (PlayerData[playerid][pAyarlar][4] == 0) ? ("{7af442}Açýk") : ("{ff0000}Kapalý"), (PlayerData[playerid][pAyarlar][5] == 0) ? ("{7af442}Açýk") : ("{ff0000}Kapalý"));
	if (PlayerData[playerid][pAdmin] >= 1) format(str, sizeof(str), "%s{FFFFFF}Admin Chat\t%s\n{FFFFFF}Helper Chat\t%s\n{FFFFFF}Yetkili Bilgi Mesajlarý\t%s\n", str, (PlayerData[playerid][pAyarlar][6] == 0) ? ("{7af442}Açýk") : ("{ff0000}Kapalý"), (PlayerData[playerid][pAyarlar][7] == 0) ? ("{7af442}Açýk") : ("{ff0000}Kapalý"), (PlayerData[playerid][pAyarlar][8] == 0) ? ("{7af442}Açýk") : ("{ff0000}Kapalý"));
	Dialog_Show(playerid, TOG, DIALOG_STYLE_TABLIST, "TOG", str, "Deðiþtir", "Geri");
	return 1;
}

stock OzelModelListele(playerid)
{
	new query[124];
	format(query, sizeof(query), "SELECT * FROM `ozelmodel` WHERE `sqlid` = '%d'", PlayerData[playerid][pID]);
	new Cache:Radless = mysql_query(g_SQL, query);
	new rows;
	cache_get_row_count(rows);
	if (rows)
	{
	    new str[1000], skinid, sayi;
	    for (new i; i<rows; i++)
	    {
	        cache_get_value_name_int(i, "skinid", skinid);
	        OzelModelListeleme[playerid][sayi] = skinid;
	        sayi++;
	        format(str, sizeof(str), "%s%d\n", str, skinid);
	    }
	    cache_delete(Radless);
	    Dialog_Show(playerid, OzelModelListe, DIALOG_STYLE_PREVMODEL, "Ozel Modelleriniz", str, "Sec", "Kapat");
	}
	else
	{
	    cache_delete(Radless);
	    HataMesajGonder(playerid, "Hiç özel modeliniz yok.");
	}
	return 1;
}
stock VipMenu(playerid)
{
	if (PlayerData[playerid][pVip] < 1 || PlayerData[playerid][pVipSure] < gettime()) return 1;
	new str[250];
	format(str, sizeof(str), "{E74C3C}Paket Türü\t{%s}[%s]\n{E74C3C}Paket Bitiþ Tarihi\t{FFFFFF}[%s]\n{E74C3C}Paket Özellikleri\t{FFFFFF}[...]\n{E74C3C}V.I.P Rengi\t{FFFFFF}[%s{FFFFFF}]\n{E74C3C}Dövüþ Stili\t{FFFFFF}[%s]",
	GetVIPRenk(PlayerData[playerid][pVip]), GetVIPName(PlayerData[playerid][pVip]), convertDatex(PlayerData[playerid][pVipSure]),
	(PlayerData[playerid][pVipRenk] == 1) ? ("{74f442}Açýk") : ("{ef2f2f}Kapalý"), GetFightStyleName(GetPlayerFightingStyle(playerid)));
	Dialog_Show(playerid, VipMenu, DIALOG_STYLE_TABLIST, "{FFFFFF}V.I.P Menü", str, "Deðiþtir", "Kapat");
    return 1;
}
stock VipDolap(playerid)
{
    if (PlayerData[playerid][pVip] < 1 || PlayerData[playerid][pVipSure] < gettime()) return 1;
    Dialog_Show(playerid, VipDolap, DIALOG_STYLE_LIST, "{FFFFFF}VIP Dolap", "{E74C3C}V.I.P Can\t{2ECC71}Ucretsiz\n{E74C3C}V.I.P Zýrh\t{2ECC71}$2000\n{E74C3C}V.I.P Skinleri", "Seç", "Kapat");
    return 1;
}

/*stock IsVipSkin(skinid)
{
	for (new i; i<50; i++)
	{
	    if (VIPErkekSkinler[i] == skinid || VIPBayanSkinler[i] == skinid) return 1;
	}
	return 0;
}*/

stock GetVIPRenk(level)
{
	new renk[10];
	switch (level)
	{
	    case 1: renk = "ba079c";
	    case 2: renk = "ba079c";
	    case 3: renk = "ffeb0f";
	    default: renk = "FFFFFF";
	}
	return renk;
}

stock GetVIPName(level)
{
	new vipname[20] = "Bilinmiyor";
	switch (level)
	{
	    case 1: vipname = "Bronze VIP";
	    case 2: vipname = "Silver VIP";
	    case 3: vipname = "Gold VIP";
	    default: vipname = "Bilinmiyor";
	}
	return vipname;
}
stock SiparisListele(playerid)
{
	new query[150];
	format(query, sizeof(query), "SELECT * FROM `siparisler` ORDER BY tarih DESC LIMIT %d, 15", GetPVarInt(playerid, "Siparis")*15);
	new Cache:Radless = mysql_query(g_SQL, query);
	new rows;
	cache_get_row_count(rows);
	if (rows)
	{
	    new str[1500],siparisid, sqlid, sipariseden[24], urun[40], tarih[25];
	    strcat(str, "Sipariþ ID\tSipariþ Eden\tÜrün\tTarih\n");
	    for (new i; i<rows; i++)
	    {
	        cache_get_value_name_int(i, "ID", siparisid);
	        cache_get_value_name_int(i, "sqlid", sqlid);
	        cache_get_value_name(i, "urun", urun, 40);
	        cache_get_value_name(i, "sipariseden", sipariseden, 24);
	        cache_get_value_name(i, "tarih", tarih, 25);
	        format(str, sizeof(str), "%s{FFFFFF}%d\t{FFFFFF}%s(%d)\t{FFFFFF}%s\t{FFFFFF}%s\n", str, siparisid, sipariseden, sqlid,  urun, tarih);
	    }
	    if (rows > 15) strcat(str, "{AFAFAF}» Ileri\n{AFAFAF}» Geri");
	    Dialog_Show(playerid, Siparisler, DIALOG_STYLE_TABLIST_HEADERS, "{f23737}Sipariþler", str, "Sil", "Kapat");
	}
	else
	{
	    cache_delete(Radless);
	    if (GetPVarInt(playerid, "Siparis") == 0)
		{
		    HataMesajGonder(playerid, "Sipariþ yok.");
		}
		else
		{
		    SetPVarInt(playerid, "Siparis", GetPVarInt(playerid, "Siparis")-1);
		    SiparisListele(playerid);
		    HataMesajGonder(playerid, "Daha fazla sipariþ bulunamadý.");
		}
	}
	return 1;
}
stock OOCMarket_UrunAl(playerid, urunadi[])
{
	new fiyat, durum;
	GetUrunBilgi(urunadi, fiyat, durum);
	if (strfind(urunadi, "Ýsim/Cinsiyet Deðiþtirme", true) != -1)
	{
	    if (durum == 0) return HataMesajGonder(playerid, "Bu ürün yetkili tarafýndan pasife alýnmýþtýr.");
		if (PlayerData[playerid][pBakiye] < fiyat) return HataMesajGonder(playerid, "Yeterli bakiyeniz yok. (%d TL)", fiyat);
		SetPVarInt(playerid, "UrunFiyat", fiyat);
		Dialog_Show(playerid, oocmisimdegistir, DIALOG_STYLE_INPUT, "Ýsim Deðiþtir", "{ff0022}» {FFFFFF}Lütfen yeni isminizi girin (Ad_Soyad formatýnda olmalýdýr):\n{ff0022}Not: {FFFFFF}Ýsminizi deðiþtirdikten sonra IC siciliniz sýfýrlanýr.", "Devam", "Vazgeç");
	}
	if (strfind(urunadi, "Karakter Yapýlandýrma Paketi", true) != -1)
	{
	    if (durum == 0) return HataMesajGonder(playerid, "Bu ürün yetkili tarafýndan pasife alýnmýþtýr.");
		if (PlayerData[playerid][pBakiye] < fiyat) return HataMesajGonder(playerid, "Yeterli bakiyeniz yok. (%d TL)", fiyat);
		SetPVarInt(playerid, "UrunFiyat", fiyat);
		Dialog_Show(playerid, oocmyas, DIALOG_STYLE_INPUT, "Karakter Yapýlandýrma Paketi (Adým 1)", "{FFFFFF}Karakter Yapýlandýrma Paketi: {ffd000}Karakter Yaþý\n\n{FFFFFF}Lütfen karakterinizin yaþýný girin:", "Devam", "Vazgeç");
	}
	if (strfind(urunadi, "Soyadý Kilitleme", true) != -1)
	{
	    if (durum == 0) return HataMesajGonder(playerid, "Bu ürün yetkili tarafýndan pasife alýnmýþtýr.");
		if (PlayerData[playerid][pBakiye] < fiyat) return HataMesajGonder(playerid, "Yeterli bakiyeniz yok. (%d TL)", fiyat);
		if (SoyadKilitlimi(GetPlayerLastName(playerid, ReturnName(playerid), 1))) return HataMesajGonder(playerid, "Bu soyad zaten kilitlenmiþ.");
		SetPVarInt(playerid, "UrunFiyat", fiyat);
		Dialog_Show(playerid, SoyadKilitle, DIALOG_STYLE_MSGBOX, "Soyad Kilitle", "{a1ff00}%d TL {FFFFFF}ödeyerek kullandýðýnýz soyadý kilitlemek ister misiniz?", "Onayla", "Reddet", fiyat);
	}
	if (strfind(urunadi, "Özel Model", true) != -1)
	{
	    if (durum == 0) return HataMesajGonder(playerid, "Bu ürün yetkili tarafýndan pasife alýnmýþtýr.");
		if (PlayerData[playerid][pBakiye] < fiyat) return HataMesajGonder(playerid, "Yeterli bakiyeniz yok. (%d TL)", fiyat);
		SetPVarInt(playerid, "UrunFiyat", fiyat);
		Dialog_Show(playerid, OzelModel, DIALOG_STYLE_MSGBOX, "Özel Model", "{a1ff00}%d TL {FFFFFF} ödeyerek özel model satýn almak ister misiniz?", "Evet", "Hayýr", fiyat);
	}
	if (strfind(urunadi, "Özel Gate", true) != -1)
	{
	    if (durum == 0) return HataMesajGonder(playerid, "Bu ürün yetkili tarafýndan pasife alýnmýþtýr.");
		if (PlayerData[playerid][pBakiye] < fiyat) return HataMesajGonder(playerid, "Yeterli bakiyeniz yok. (%d TL)", fiyat);
		SetPVarInt(playerid, "UrunFiyat", fiyat);
		Dialog_Show(playerid, OzelGate, DIALOG_STYLE_MSGBOX, "Özel Gate", "{a1ff00}%d TL {FFFFFF} ödeyerek özel gate satýn almak ister misiniz?", "Evet", "Hayýr", fiyat);
	}
	if (strfind(urunadi, "Pet", true) != -1)
	{
	    if (durum == 0) return HataMesajGonder(playerid, "Bu ürün yetkili tarafýndan pasife alýnmýþtýr.");
		if (PlayerData[playerid][pBakiye] < fiyat) return HataMesajGonder(playerid, "Yeterli bakiyeniz yok. (%d TL)", fiyat);
		SetPVarInt(playerid, "UrunFiyat", fiyat);
		Dialog_Show(playerid, oocmpet, DIALOG_STYLE_MSGBOX, "Pet", "{a1ff00}%d TL {FFFFFF} ödeyerek pet satýn almak ister misiniz?", "Evet", "Hayýr", fiyat);
	}
	if (strfind(urunadi, "Bronze VIP", true) != -1)
	{
		if (PlayerData[playerid][pBakiye] < 15) return HataMesajGonder(playerid, "Yeterli bakiyeniz yok. (15 TL)");
		if (PlayerData[playerid][pVip] > 0) return HataMesajGonder(playerid, "Zaten VIP paketiniz var.");
		SetPVarInt(playerid, "UrunFiyat", 15);
		Dialog_Show(playerid, BronzVip, DIALOG_STYLE_MSGBOX, "Bronze VIP", "{a1ff00}15 TL {FFFFFF}ödeyerek Bronze VIP adlý ürünü satýn almak ister misiniz?", "Onayla", "Vazgeç");
	}
	if (strfind(urunadi, "Silver VIP", true) != -1)
	{
		if (PlayerData[playerid][pBakiye] < 25) return HataMesajGonder(playerid, "Yeterli bakiyeniz yok. (25 TL)");
		if (PlayerData[playerid][pVip] > 0) return HataMesajGonder(playerid, "Zaten VIP paketiniz var.");
		SetPVarInt(playerid, "UrunFiyat", 25);
		Dialog_Show(playerid, SilverVip, DIALOG_STYLE_MSGBOX, "Silver VIP", "{a1ff00}25 TL {FFFFFF}ödeyerek Silver VIP adlý ürünü satýn almak ister misiniz?", "Onayla", "Vazgeç");
	}
	if (strfind(urunadi, "Gold VIP", true) != -1)
	{
		if (PlayerData[playerid][pBakiye] < 35) return HataMesajGonder(playerid, "Yeterli bakiyeniz yok. (35 TL)", fiyat);
		if (PlayerData[playerid][pVip] > 0) return HataMesajGonder(playerid, "Zaten VIP paketiniz var.");
		SetPVarInt(playerid, "UrunFiyat", 40);
		Dialog_Show(playerid, GoldVip, DIALOG_STYLE_MSGBOX, "Gold VIP", "{a1ff00}40 TL {FFFFFF}ödeyerek Gold VIP adlý ürünü satýn almak ister misiniz?", "Onayla", "Vazgeç");
	}
	if (strfind(urunadi, "Özel Map", true) != -1)
	{
	    if (durum == 0) return HataMesajGonder(playerid, "Bu ürün yetkili tarafýndan pasife alýnmýþtýr.");
		if (PlayerData[playerid][pBakiye] < fiyat) return HataMesajGonder(playerid, "Yeterli bakiyeniz yok. (%d TL)", fiyat);
		SetPVarInt(playerid, "UrunFiyat", fiyat);
		Dialog_Show(playerid, OzelMap, DIALOG_STYLE_MSGBOX, "Özel Map", "{a1ff00}%d TL {FFFFFF} ödeyerek özel map satýn almak ister misiniz?", "Evet", "Hayýr", fiyat);
	}
	if (strfind(urunadi, "Özel Plaka", true) != -1)
	{
	    if (durum == 0) return HataMesajGonder(playerid, "Bu ürün yetkili tarafýndan pasife alýnmýþtýr.");
		if (PlayerData[playerid][pBakiye] < fiyat) return HataMesajGonder(playerid, "Yeterli bakiyeniz yok. (%d TL)", fiyat);
		if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return HataMesajGonder(playerid, "Özel plaka satýn almak için sürücü olmalýsýnýz!");
		SetPVarInt(playerid, "UrunFiyat", fiyat);
		Dialog_Show(playerid, OzelPlaka, DIALOG_STYLE_MSGBOX, "Özel Plaka", "{a1ff00}%d TL {FFFFFF} ödeyerek özel plaka satýn almak ister misiniz?", "Evet", "Hayýr", fiyat);
	}
	if (strfind(urunadi, "Özel Numara", true) != -1)
	{
	    if (durum == 0) return HataMesajGonder(playerid, "Bu ürün yetkili tarafýndan pasife alýnmýþtýr.");
		if (PlayerData[playerid][pBakiye] < fiyat) return HataMesajGonder(playerid, "Yeterli bakiyeniz yok. (%d TL)", fiyat);
		if (PlayerData[playerid][pTelefon] == -1) return HataMesajGonder(playerid, "Bu ürünü satýn almak için telefonunuz olmalýdýr.");
		SetPVarInt(playerid, "UrunFiyat", fiyat);
		Dialog_Show(playerid, OzelNumara, DIALOG_STYLE_INPUT, "Özel Numara", "{a1ff00}%d TL {FFFFFF}ödeyerek almak istediðiniz özel numarayý girin:", "Devam", "Vazgeç", fiyat);
	}
	if (strfind(urunadi, "EXP Boost", true) != -1)
	{
	    if (durum == 0) return HataMesajGonder(playerid, "Bu ürün yetkili tarafýndan pasife alýnmýþtýr.");
		if (PlayerData[playerid][pBakiye] < fiyat) return HataMesajGonder(playerid, "Yeterli bakiyeniz yok. (%d TL)", fiyat);
		if (PlayerData[playerid][pEXPBoost] > gettime()) return HataMesajGonder(playerid, "EXP Boost adlý ürününüz zaten bulunuyor.");
		SetPVarInt(playerid, "UrunFiyat", fiyat);
		Dialog_Show(playerid, EXPBoost, DIALOG_STYLE_MSGBOX, "EXP Boost", "{a1ff00}%d TL {FFFFFF}ödeyerek EXP Boost adlý ürünü satýn almak ister misiniz\n\n{FFFFFF}Her maaþ aldýðýnýzda 1 EXP daha fazla kazanacaksýnýz.", "Onayla", "Vazgeç", fiyat);
	}
	if (strfind(urunadi, "Garaj", true) != -1)
	{
	    if (durum == 0) return HataMesajGonder(playerid, "Bu ürün yetkili tarafýndan pasife alýnmýþtýr.");
		if (PlayerData[playerid][pBakiye] < fiyat) return HataMesajGonder(playerid, "Yeterli bakiyeniz yok. (%d TL)", fiyat);
		SetPVarInt(playerid, "UrunFiyat", fiyat);
		Dialog_Show(playerid, OzelGaraj, DIALOG_STYLE_MSGBOX, "Özel Garaj", "{a1ff00}%d TL {FFFFFF} ödeyerek özel garaj satýn almak ister misiniz?", "Evet", "Hayýr", fiyat);
	}
	if (strfind(urunadi, "Özel Ev Ýnterioru", true) != -1)
	{
	    if (durum == 0) return HataMesajGonder(playerid, "Bu ürün yetkili tarafýndan pasife alýnmýþtýr.");
		if (PlayerData[playerid][pBakiye] < fiyat) return HataMesajGonder(playerid, "Yeterli bakiyeniz yok. (%d TL)", fiyat);
		SetPVarInt(playerid, "UrunFiyat", fiyat);
		Dialog_Show(playerid, OzelEv, DIALOG_STYLE_MSGBOX, "Özel Ev Ýnterioru", "{a1ff00}%d TL {FFFFFF} ödeyerek özel ev interioru satýn almak ister misiniz?", "Evet", "Hayýr", fiyat);
	}
	if (strfind(urunadi, "Balýk Oraný Arttýrma", true) != -1)
	{
	    if (durum == 0) return HataMesajGonder(playerid, "Bu ürün yetkili tarafýndan pasife alýnmýþtýr.");
		if (PlayerData[playerid][pBakiye] < fiyat) return HataMesajGonder(playerid, "Yeterli bakiyeniz yok. (%d TL)", fiyat);
		if (PlayerData[playerid][pBalikOrani] > gettime()) return HataMesajGonder(playerid, "Balýk Oraný Arttýrma adlý ürününüz zaten bulunuyor.");
		SetPVarInt(playerid, "UrunFiyat", fiyat);
		Dialog_Show(playerid, BalikOrani, DIALOG_STYLE_MSGBOX, "Balýk Oraný Arttýrma", "{a1ff00}%d TL {FFFFFF} ödeyerek 'Balýk Oraný Arttýrma' satýn almak ister misiniz?", "Evet", "Hayýr", fiyat);
	}
	if (strfind(urunadi, "Araç Kilometre Sýfýrlama", true) != -1)
	{
	    if (durum == 0) return HataMesajGonder(playerid, "Bu ürün yetkili tarafýndan pasife alýnmýþtýr.");
		if (PlayerData[playerid][pBakiye] < fiyat) return HataMesajGonder(playerid, "Yeterli bakiyeniz yok. (%d TL)", fiyat);
		if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return HataMesajGonder(playerid, "Sürücü olmalýsýnýz!");
		SetPVarInt(playerid, "UrunFiyat", fiyat);
		Dialog_Show(playerid, KilometreSifirla, DIALOG_STYLE_MSGBOX, "Araç Kilometre Sýfýrlama", "{a1ff00}%d TL {FFFFFF} ödeyerek bulunduðunuz aracýn kilometresini sýfýrlamak ister misiniz?", "Evet", "Hayýr", fiyat);
	}
	if (strfind(urunadi, "Maske Kullaným Hakký", true) != -1)
	{
	    if (durum == 0) return HataMesajGonder(playerid, "Bu ürün yetkili tarafýndan pasife alýnmýþtýr.");
		if (PlayerData[playerid][pBakiye] < fiyat) return HataMesajGonder(playerid, "Yeterli bakiyeniz yok. (%d TL)", fiyat);
		if (PlayerData[playerid][pMaskeHakki] == 1) return HataMesajGonder(playerid, "Zaten maske kullaným hakkýnýz var.");
		SetPVarInt(playerid, "UrunFiyat", fiyat);
		Dialog_Show(playerid, MaskeHakki, DIALOG_STYLE_MSGBOX, "Maske Kullaným Hakký", "{a1ff00}%d TL {FFFFFF} ödeyerek Maske Kullaným Hakký adlý ürünü satýn almak istiyor musunuz?", "Evet", "Hayýr", fiyat);
	}
	return 1;
}
stock IsPlayerSpawnedEx(playerid)
{
    if (playerid < 0 || playerid >= MAX_PLAYERS)
        return 0;

    return (GetPlayerState(playerid) != PLAYER_STATE_SPECTATING && GetPlayerState(playerid) != PLAYER_STATE_NONE && GetPlayerState(playerid) != PLAYER_STATE_WASTED);
}
stock NumaraKontrol(numara)
{
	new query[100];
	format(query, sizeof(query), "SELECT null FROM `oyuncular` WHERE `Telefon` = '%d'", numara);
	new Cache:Radless = mysql_query(g_SQL, query);
	new rows;
	cache_get_row_count(rows);
	cache_delete(Radless);
	if (rows) return 1;
	return 0;
}
stock IC_Sicil_Reset(playerid)
{
	new query[124];
	format(query, sizeof(query), "DELETE FROM `icsicil` WHERE `playersqlid` = '%d'", PlayerData[playerid][pID]);
	mysql_query(g_SQL, query, false);
	return 1;
}
stock ChangeName(playerid, name[])
{
	new oldname[24];
	GetPlayerName(playerid, oldname, sizeof(oldname));
    SetPlayerName(playerid, name);
	new query[200];
    format(query, sizeof(query), "UPDATE `oyuncular` SET `Isim` = '%s' WHERE `Isim` = '%s'", name, oldname);
    mysql_query(g_SQL, query, false);
    format(query, sizeof(query), "UPDATE `siparisler` SET `sipariseden` = '%s' WHERE `sqlid` = '%d'", name, PlayerData[playerid][pID]);
    mysql_query(g_SQL, query, false);
    format(query, sizeof(query), "INSERT INTO namechanges (`sqlid`, `EskiAd`, `YeniAd`, `Tarih`) VALUES ('%d', '%s', '%s', '%s')", PlayerData[playerid][pID], oldname, name, ReturnDate());
    mysql_query(g_SQL, query, false);
    Log_Write("logs/namechange.log", "%s adli kisi karakter adini %s olarak degistirdi.",oldname, name);
    return 1;
}
stock IsimKontrol(ad[])
{
	foreach (new i:Player)
	{
	    if (strcmp(Player_GetName(i), ad, false) == 0) return 0;
	}
	new query[100];
	format(query, sizeof(query), "SELECT null FROM `oyuncular` WHERE `Isim` = '%s'", ad);
	mysql_query(g_SQL, query);
	new rows;
	cache_get_row_count(rows);
	if (rows) return 0;
	return 1;
}
stock GetUrunBilgi(urunadi[], &fiyat, &durum)
{
	new query[124];
	format(query, sizeof(query), "SELECT * FROM `oocmarket` WHERE `urunadi` = '%s'", urunadi);
	new Cache:Radless = mysql_query(g_SQL, query);
	new rows;
	cache_get_row_count(rows);
	if (rows)
	{
	    cache_get_value_name_int(0, "fiyat", fiyat);
	    cache_get_value_name_int(0, "durum", durum);
	}
	cache_delete(Radless);
	return 1;
}
stock Garaj_AracListesi(playerid, id)
{
	new str[1000], baslik[60], sayi;
	for (new i; i<MAX_ARAC; i++) if (AracInfo[i][aracExists] && AracInfo[i][aracGaraj] == id)
	{
	    ParkedilenAraclar[playerid][sayi] = i;
	    sayi++;
	    format(str, sizeof(str), "%s{FFFFFF}%s (ID: %d)\n", str, ReturnVehicleModelName(AracInfo[i][aracModel]), i);

	}
	if (sayi == 0) return HataMesajGonder(playerid, "Park edilmiþ araç yok.");
	format(baslik, sizeof(baslik), "Parkedilen Araçlar {f44242}(%d/%d)", sayi, GarageData[id][gAracLimit]);
	Dialog_Show(playerid, GarajAraclar, DIALOG_STYLE_LIST, baslik, str, "Garajdan At", "Geri");
	return 1;
}
stock KisiselCezalar(playerid)
{
	new str[1000], sayi = 0;
	strcat(str, "Ekleyen\tSebep\tMiktar\tTarih\n");
	for (new i; i<MAX_PLAYER_TICKETS; i++) if (TicketData[playerid][i][ticketExists])
	{
	    CezaListele[playerid][sayi] = i;
	    sayi++;
	    format(str, sizeof(str), "%s%s\t%.20s\t{04ff00}%s\t%s\n", str, TicketData[playerid][i][ticketMemur], TicketData[playerid][i][ticketReason], FormatNumber(TicketData[playerid][i][ticketFee]), TicketData[playerid][i][ticketDate]);
	}
	if (sayi == 0) return HataMesajGonder(playerid, "Cezanýz yok.");
	Dialog_Show(playerid, KisiselCezalar, DIALOG_STYLE_TABLIST_HEADERS, "{FFFFFF}Kiþisel Cezalar", str, "Öde", "Geri");
	return 1;
}
stock OyuncuSilahlar(playerid)
{
	new string[200],sayi = 0;
	strcat(string, "ID\t{FFFFFF}Silah Adý\t{FFFFFF}Mermi\n");
	new a;
	for (new i; i<13; i++) if (PlayerData[playerid][pSilahlar][i] > 0)
	{
	    sayi++;
	    GetPlayerWeaponData(playerid, i, a, PlayerData[playerid][pMermiler][i]);
	    format(string, sizeof(string), "%s{FFFFFF}%d\t{FFFFFF}%s\t{FFFFFF}%d\n", string, PlayerData[playerid][pSilahlar][i], ReturnWeaponName(PlayerData[playerid][pSilahlar][i]), PlayerData[playerid][pMermiler][i]);
	}
	if (sayi == 0) return HataMesajGonder(playerid, "Hiç silahýnýz yok.");
	Dialog_Show(playerid, Silahlarim, DIALOG_STYLE_TABLIST_HEADERS, "Silah Envanteri", string, "Seç", "Kapat");
	return 1;
}
stock EvSilahlar(playerid, id)
{
	new str[1000];
	for (new i; i<10; i++)
	{
	    if (HouseInfo[id][evSilahlar][i] > 0) format(str, sizeof(str), "%s%s\t%d mermi\n", str, ReturnWeaponName(HouseInfo[id][evSilahlar][i]), HouseInfo[id][evMermiler][i]);
	    else format(str, sizeof(str), "%sBoþ Slot\t \n", str);
	}

	Dialog_Show(playerid, EvSilahlar, DIALOG_STYLE_TABLIST, "{E74C3C}Ev: {FFFFFF}Silahlar", str, "Seç", "Geri");
	return 1;
}

stock AracSilahlar(playerid, id)
{
	new str[700];
	if (AracInfo[id][aracSilahlar][0] < 1) format(str, sizeof(str), "Boþ Slot\n");
	else format(str, sizeof(str), "%s\t%d\n", ReturnWeaponName(AracInfo[id][aracSilahlar][0]), AracInfo[id][aracMermiler][0]);
	if (AracInfo[id][aracSilahlar][1] < 1) format(str, sizeof(str), "%sBoþ Slot\n", str);
	else format(str, sizeof(str), "%s%s\t%d\n", str, ReturnWeaponName(AracInfo[id][aracSilahlar][1]), AracInfo[id][aracMermiler][1]);
	if (AracInfo[id][aracSilahlar][2] < 1) format(str, sizeof(str), "%sBoþ Slot\n", str);
	else format(str, sizeof(str), "%s%s\t%d\n", str, ReturnWeaponName(AracInfo[id][aracSilahlar][2]), AracInfo[id][aracMermiler][2]);
	if (AracInfo[id][aracSilahlar][3] < 1) format(str, sizeof(str), "%sBoþ Slot\n", str);
	else format(str, sizeof(str), "%s%s\t%d\n", str, ReturnWeaponName(AracInfo[id][aracSilahlar][3]), AracInfo[id][aracMermiler][3]);
	if (AracInfo[id][aracSilahlar][4] < 1) format(str, sizeof(str), "%sBoþ Slot\n", str);
	else format(str, sizeof(str), "%s%s\t%d\n", str, ReturnWeaponName(AracInfo[id][aracSilahlar][4]), AracInfo[id][aracMermiler][4]);

	if (GetFactionType(playerid) == BIRLIK_LSPD)
		strcat(str, "{ff1d00}» {FFFFFF}Silahlara El Koy");

	Dialog_Show(playerid, BagajSilahlar, DIALOG_STYLE_TABLIST, "{E74C3C}Bagaj: {FFFFFF}Silahlar", str, "Seç", "Geri");
	return 1;
}

stock DropSil(id)
{
	new query[100];
	format(query, sizeof(query), "DELETE FROM `droppedWeapons` WHERE `dID` = '%d'", DroppedWeapon[id][droppedID]);
	mysql_query(g_SQL, query, false);
	DroppedWeapon[id][droppedExists] = false;
 	DroppedWeapon[id][droppedPlayer] = -1;
  	DroppedWeapon[id][droppedPos][0] = 0;
   	DroppedWeapon[id][droppedPos][1] = 0;
    DroppedWeapon[id][droppedPos][2] = 0;
    DroppedWeapon[id][droppedWeapon] = 0;
    DroppedWeapon[id][droppedAmmo] = 0;
    DroppedWeapon[id][droppedInt] = 0;
    DroppedWeapon[id][droppedVw] = 0;
    DestroyDynamicObject(DroppedWeapon[id][droppedObject]);
    DestroyDynamic3DTextLabel(DroppedWeapon[id][droppedText]);
	return 1;
}
stock DropWeapon(sqlid, weaponid, ammo, Float:x, Float:y, Float:z, interior, world)
{
	new str[50], query[256];
	for (new i; i<MAX_DROPPED_WEAPONS; i++) if (!DroppedWeapon[i][droppedExists])
	{
	    DroppedWeapon[i][droppedExists] = true;
        DroppedWeapon[i][droppedID] = i;

	    DroppedWeapon[i][droppedPlayer] = sqlid;
	    DroppedWeapon[i][droppedPos][0] = x;
	    DroppedWeapon[i][droppedPos][1] = y;
	    DroppedWeapon[i][droppedPos][2] = z;
	    DroppedWeapon[i][droppedWeapon] = weaponid;
	    DroppedWeapon[i][droppedAmmo] = ammo;
	    DroppedWeapon[i][droppedInt] = interior;
	    DroppedWeapon[i][droppedVw] = world;
	    DroppedWeapon[i][droppedObject] = CreateDynamicObject(GetWeaponModel(DroppedWeapon[i][droppedWeapon]), DroppedWeapon[i][droppedPos][0], DroppedWeapon[i][droppedPos][1], DroppedWeapon[i][droppedPos][2], 93.7, 120.0, 120.0, DroppedWeapon[i][droppedInt], DroppedWeapon[i][droppedVw]);
        format(str, sizeof(str), "%s (Mermi: %d)", ReturnWeaponName(DroppedWeapon[i][droppedWeapon]), DroppedWeapon[i][droppedAmmo]);
        DroppedWeapon[i][droppedText] = CreateDynamic3DTextLabel(str, COLOR_LIGHTBLUE, DroppedWeapon[i][droppedPos][0], DroppedWeapon[i][droppedPos][1], DroppedWeapon[i][droppedPos][2], 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, DroppedWeapon[i][droppedVw], DroppedWeapon[i][droppedInt]);

        mysql_format(g_SQL, query, sizeof(query), "INSERT INTO `droppedWeapons` (`dID`, `dPlayer`, `dropX`, `dropY`, `dropZ`, `dInterior`, `dVw`, `dWeapon`, `dAmmo`) VALUES ('%d', '%d', '%.4f','%.4f','%.4f','%d', '%d', '%d', '%d')",
		i,
		sqlid,
        x,
        y,
        z,
        interior,
        world,
        weaponid,
        ammo);
        mysql_query(g_SQL, query);
        return i;
	}
	return -1;
}
GetWeaponMagazineAmmo(weaponid)
{
    switch (weaponid)
    {
        case 22: return 34;
        case 23: return 17;
        case 24: return 7;
        case 25: return 5;
        case 26: return 4;
        case 27: return 7;
        case 28: return 100;
        case 29: return 30;
        case 30: return 30;
        case 31: return 50;
        case 32: return 100;
        case 38: return 500;
    }
    return -1;
}
stock CadirID(playerid)
{
	for (new i; i<MAX_CADIR; i++) if (CadirData[i][cadirExists] == true && CadirData[i][cadirSahip] == playerid)
	{
	    return i;
	}
	return -1;
}
stock Cadir_Yakin(playerid)
{
	for (new i; i<MAX_CADIR; i++) if (CadirData[i][cadirExists] == true)
	{
	    if (IsPlayerInRangeOfPoint(playerid, 5.0, CadirData[i][cadirPos][0], CadirData[i][cadirPos][1], CadirData[i][cadirPos][2])) return i;
	}
	return -1;
}
stock Cadir_Sil(playerid)
{
	for (new i; i<MAX_CADIR; i++) if (CadirData[i][cadirExists] == true && CadirData[i][cadirSahip] == playerid)
	{
	    CadirData[i][cadirExists] = false;
	    CadirData[i][cadirSahip] = -1;
	    CadirData[i][cadirPos][0] = 0.0;
	    CadirData[i][cadirPos][1] = 0.0;
	    CadirData[i][cadirPos][2] = 0.0;
	    DestroyDynamicObject(CadirData[i][cadirObject]);
	    DestroyDynamic3DTextLabel(CadirData[i][cadirText]);
	    break;
	}
	return 1;
}
stock Cadir_Kur(playerid)
{
	for (new i; i<MAX_CADIR; i++) if (CadirData[i][cadirExists] == false)
	{
	    new Float:angle;
	    CadirData[i][cadirExists] = true;
	    CadirData[i][cadirSahip] = playerid;
	    GetPlayerPos(playerid, CadirData[i][cadirPos][0], CadirData[i][cadirPos][1], CadirData[i][cadirPos][2]);
	    GetPlayerFacingAngle(playerid, angle);
	    CadirData[i][cadirPos][0] += (5 * floatsin(-angle, degrees));
    	CadirData[i][cadirPos][1] += (5 * floatcos(-angle, degrees));
    	CadirData[i][cadirPos][2] -= 1.0;
        CadirData[i][cadirObject] = CreateDynamicObject(-2010, CadirData[i][cadirPos][0], CadirData[i][cadirPos][1], CadirData[i][cadirPos][2], 0.0, 0.0, 0.0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
		new str[80];
	    format(str, sizeof(str), "{808080}Çadýr ÝD (#%d)\n{808080}Sahip: %s", i, ReturnName(playerid, 0));
	    CadirData[i][cadirText] = CreateDynamic3DTextLabel(str, -1, CadirData[i][cadirPos][0], CadirData[i][cadirPos][1], CadirData[i][cadirPos][2], 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
	    return 1;
	}
	return 0;
}
stock IsPlayerInLosSantos(playerid)
{
    new Float:x,Float:y,Float:z;
    GetPlayerPos(playerid, x, y, z);
    if (x >= 44.60 && y >= -2892.90 && x <= 2997.00 && y <= -768.00) return 1;
    else return 0;
}

stock Reklam_Olustur(playerid, icerik[])
{
	for (new re; re<MAX_REKLAM; re++)
	{
	    if (!Reklamlar[re][reklamExists])
	    {
			Reklamlar[re][reklamExists] = 1;
	        format(Reklamlar[re][reklamIcerik], 128, icerik);
	        Reklamlar[re][ajansID] = GetPVarInt(playerid, "pAjansReklamID");
	        Reklamlar[re][reklamIletisim] = PlayerData[playerid][pTelefon];
	        Reklamlar[re][reklamGonderen] = PlayerData[playerid][pID];
	        Reklamlar[re][reklamUcret] = Birlikler[GetPVarInt(playerid, "pAjansReklamID")][ReklamUcreti];
	        return re;
	    }
	}
	return -1;
}
stock AjansListele(playerid)
{
	for (new i; i<MAX_BIRLIK; i++) if (Birlikler[i][birlikExists] && Birlikler[i][birlikTip] == BIRLIK_HABER)
	{
	    Birlik_Kaydet(i);
	}

	new str[1000], string[124];
    format(string, sizeof(string), "SELECT * FROM `birlikler` WHERE `btip` = '3' ORDER BY aktifdinleyici DESC LIMIT %d, 15", GetPVarInt(playerid, "AjansPage")*15);
    new Cache:Radless = mysql_query(g_SQL, string);
    new rows;
    cache_get_row_count(rows);
    if (rows)
    {
        new sqlid, pawnid, dinleyici, yayintipi, yayindurum, birlikad[32];
        if(GetPVarInt(playerid, "pAjansReklam") == 1)
        {
	        strcat(str, "{FFFFFF}Kanal Adý\t{FFFFFF}Reklam Durumu\t{FFFFFF}Reklam Ücreti\n");
	        for (new i; i<rows; i++)
	        {
	            cache_get_value_name_int(i, "bid", sqlid);
	            cache_get_value_name(i, "bisim", birlikad, 32);
	            pawnid = GetFactionByID(sqlid);
	            AjansListeleme[playerid][i] = pawnid;
	            format(string, sizeof(string), "{FFFFFF}%s\t%s\t{FFFFFF}$%d\n", birlikad, (Birlikler[pawnid][ReklamAlimi] >= 1) ? ("{2ECC71}Alýyor") : ("{ff0000}Almýyor"), Birlikler[pawnid][ReklamUcreti]);
	            strcat(str, string);
	        }
        }

        else
        {
	        strcat(str, "{FFFFFF}Kanal Adý\t{FFFFFF}Yayýn Durumu\t{FFFFFF}Yayýn Tipi\t{FFFFFF}Dinleyici\n");
	        for (new i; i<rows; i++)
	        {
	            cache_get_value_name_int(i, "bid", sqlid);
	            cache_get_value_name_int(i, "aktifdinleyici", dinleyici);
	            cache_get_value_name_int(i, "yayintipi", yayintipi);
	            cache_get_value_name_int(i, "yayindurum", yayindurum);
	            cache_get_value_name(i, "bisim", birlikad, 32);
	            pawnid = GetFactionByID(sqlid);
	            AjansListeleme[playerid][i] = pawnid;
	            format(string, sizeof(string), "{FFFFFF}%s\t%s\t{FFFFFF}%s\t{FFFFFF}%d\n", birlikad, (yayindurum == 1) ? ("{2ECC71}Açýk") : ("{ff0000}Kapalý"), (yayintipi == 0) ? ("Haber") : ("Müzik"), dinleyici);
	            strcat(str, string);
	        }
    	}
        if (rows > 15) strcat(str, "{AFAFAF}» Ileri\n{AFAFAF}» Geri");
        format(string, sizeof(string), "Yayýn Ajanslarý {AA3333}(Sayfa %d)", GetPVarInt(playerid, "AjansPage")+1);
        Dialog_Show(playerid, Dinle, DIALOG_STYLE_TABLIST_HEADERS, string, str, "Dinle", "Kapat");
	}
	cache_delete(Radless);
	return 1;
}


/*
	if (Birlikler[id][ReklamAlimi] != 1) return HataMesajGonder(playerid, "Bu ajans reklam almýyor.");
	if (Birlikler[id][ReklamUcreti] > PlayerData[playerid][pCash]) return HataMesajGonder(playerid, "Reklam ücretini karþýlamýyorsunuz.");
*/

stock IsNewsVehicle(vehicleid)
{
	switch (GetVehicleModel(vehicleid)) {
	    case 488, 582: return 1;
	}
	return 0;
}

KumarReset(playerid, kumar_mode = 0){
    if (kumar_mode == 0){
        SetPVarInt(playerid, "kumar_id", INVALID_PLAYER_ID);
        SetPVarInt(playerid, "kumar_para", 0);
        SetPVarInt(playerid, "kumar_para2", 0);
        SetPVarInt(playerid, "kumar_kimde", 0);
    }else{
        SetPVarInt(playerid, "kumar_id", INVALID_PLAYER_ID);
        SetPVarInt(playerid, "kumar_para", 0);
        SetPVarInt(playerid, "kumar_para2", 0);
        SetPVarInt(playerid, "kumar_kimde", 0);
        ShowPlayerDialog(playerid, -1, DIALOG_STYLE_MSGBOX, "", "", "", "");
    }
}
KumarDondurme(playerid)
{
    new sz[325];
    new id = GetPVarInt(playerid, "kumar_id");
    new bahis = GetPVarInt(playerid, "kumar_para");
    format(sz, sizeof(sz), "{808080}» Partner: {ffffff}%s\n", ReturnName(id, 0));
    format(sz, sizeof(sz), "%s{808080}» Bahis: {ffffff}%s (Deðiþtir)\n", sz, FormatNumber(bahis));
    format(sz, sizeof(sz), "%s{808080}» {ffffff}Döndür\n", sz);
    format(sz, sizeof(sz), "%s\t\n ", sz);
    format(sz, sizeof(sz), "%s\t\n ", sz);
		format(sz, sizeof(sz), "%s\t\n ", sz);
		format(sz, sizeof(sz), "%s\t\n ", sz);
		format(sz, sizeof(sz), "%s\t\n ", sz);
		format(sz, sizeof(sz), "%s\t\n ", sz);
		format(sz, sizeof(sz), "%s\t\n ", sz);
		format(sz, sizeof(sz), "%s\t\n ", sz);
		format(sz, sizeof(sz), "%s\t\n ", sz);
		format(sz, sizeof(sz), "%s\t\n ", sz);
		format(sz, sizeof(sz), "%s\t\n ", sz);
    format(sz, sizeof(sz), "%s{808080}» {ffffff}Düelloyu Bitir\n", sz);
    Dialog_Show(playerid, KumarDondurme, DIALOG_STYLE_LIST, "{808080}Zar Düellosu", sz, "Seç", "");
    return 1;
}

Fuel_ResetPlayer(playerid)
{
	if (UsingPumpID[playerid] != -1)
	{
    	Pompa[UsingPumpID[playerid]][Pompa_Kullaniliyor] = false;
		Pompa_Objeler(UsingPumpID[playerid], false);
	}

	if (RefuelTimer[playerid] != -1)
	{
	    KillTimer(RefuelTimer[playerid]);
	    RefuelTimer[playerid] = -1;

	    PlayerTextDrawHide(playerid, FuelText[playerid]);
	}

    UsingPumpID[playerid] = -1;
 	FuelBought[playerid] = 0.0;
	return 1;
}
stock PayDay(playerid)
{
    new maas = GetServerBilgi("SaatlikMaas");
    new vergi = GetServerBilgi("MaasVergi");
    new olusummaas;
    switch (GetFactionType(playerid))
    {
        case BIRLIK_LSPD, BIRLIK_FBI, BIRLIK_LSMD, BIRLIK_GOV:
        {
            switch (PlayerData[playerid][pFactionRutbe])
            {
                case 1..12:
                {
                    olusummaas = 50*PlayerData[playerid][pFactionRutbe] + 50;
                }
                case 13:
                {
                    olusummaas = 400;
                }
                case 14:
                {
                    olusummaas = 500;
                }
                case 15:
                {
                    olusummaas = 700;
                }
            }
        }
        case BIRLIK_LEGAL:
        {
            switch (PlayerData[playerid][pFactionRutbe])
            {
	            case 1..6: olusummaas = 15*PlayerData[playerid][pFactionRutbe] + 15;
	            case 7: olusummaas = 150;
	            case 8: olusummaas = 175;
	            case 9: olusummaas = 250;
	            case 10: olusummaas = 300;
	            case 11..14: olusummaas = 350;
	            case 15: olusummaas = 400;
            }
        }
	}
	new kiraid = EvKiraID(playerid);
	if (olusummaas > 0 && kiraid != -1)   /* 0xAA3A3AAA, "{AA3A3A}|{C8C8C8}*/
	{
		  SendClientMessageEx(playerid, 0xFF00FFFF, "{FF00FF}|{C8C8C8} Saatlik Maaþ: %s Vergiler: %s", FormatNumber(maas), FormatNumber(vergi));
	    SendClientMessageEx(playerid, 0xFF00FFFF, "{FF00FF}|{C8C8C8} Oluþum Maaþý: %s", FormatNumber(olusummaas));
	    SendClientMessageEx(playerid, 0xFF00FFFF, "{FF00FF}|{C8C8C8} Kira Ücreti: %s", FormatNumber(HouseInfo[kiraid][evKiraUcret]));
	    switch (PlayerData[playerid][pVip])
	    {
	        case 1: SendClientMessageEx(playerid, 0xFF00FFFF, "{FF00FF}|{C8C8C8} VIP Maaþý: $200");
	        case 2: SendClientMessageEx(playerid, 0xFF00FFFF, "{FF00FF}|{C8C8C8} VIP Maaþý: $400");
	        case 3: SendClientMessageEx(playerid, 0xFF00FFFF, "{FF00FF}|{C8C8C8} VIP Maaþý: $600");
	    }
	}
	else if (olusummaas > 0 && kiraid == -1)
	{
		  SendClientMessageEx(playerid, 0xFF00FFFF, "{FF00FF}|{C8C8C8} Saatlik Maaþ: %s Vergiler: %s", FormatNumber(maas), FormatNumber(vergi));
	    SendClientMessageEx(playerid, 0xFF00FFFF, "{FF00FF}|{C8C8C8} Oluþum Maaþý: %s", FormatNumber(olusummaas));
	    switch (PlayerData[playerid][pVip])
	    {
	        case 1: SendClientMessageEx(playerid, 0xFF00FFFF, "{FF00FF}|{C8C8C8} VIP Maaþý: $200");
	        case 2: SendClientMessageEx(playerid, 0xFF00FFFF, "{FF00FF}|{C8C8C8} VIP Maaþý: $400");
	        case 3: SendClientMessageEx(playerid, 0xFF00FFFF, "{FF00FF}|{C8C8C8} VIP Maaþý: $600");
	    }
	}
	else if (olusummaas <= 0 && kiraid != -1)
	{
		  SendClientMessageEx(playerid, 0xFF00FFFF, "{FF00FF}|{C8C8C8} Saatlik Maaþ: %s Vergiler: %s", FormatNumber(maas), FormatNumber(vergi));
	    SendClientMessageEx(playerid, 0xFF00FFFF, "{FF00FF}|{C8C8C8} Kira Ücreti: %s", FormatNumber(HouseInfo[kiraid][evKiraUcret]));
	    switch (PlayerData[playerid][pVip])
	    {
	        case 1: SendClientMessageEx(playerid, 0xFF00FFFF, "{FF00FF}|{C8C8C8} VIP Maaþý: $200");
	        case 2: SendClientMessageEx(playerid, 0xFF00FFFF, "{FF00FF}|{C8C8C8} VIP Maaþý: $400");
	        case 3: SendClientMessageEx(playerid, 0xFF00FFFF, "{FF00FF}|{C8C8C8} VIP Maaþý: $600");
	    }
	}
	else if (olusummaas <= 0 && kiraid == -1)
	{
		  SendClientMessageEx(playerid, 0xFF00FFFF, "{FF00FF}|{C8C8C8} Saatlik Maaþ: %s Vergiler: %s", FormatNumber(maas), FormatNumber(vergi));
	    switch (PlayerData[playerid][pVip])
	    {
	        case 1: SendClientMessageEx(playerid, 0xFF00FFFF, "{FF00FF}|{C8C8C8} VIP Maaþý: $200");
	        case 2: SendClientMessageEx(playerid, 0xFF00FFFF, "{FF00FF}|{C8C8C8} VIP Maaþý: $400");
	        case 3: SendClientMessageEx(playerid, 0xFF00FFFF, "{FF00FF}|{C8C8C8} VIP Maaþý: $600");
	    }
	}
	maas -= vergi;
	if (kiraid != -1 && HouseInfo[kiraid][evKiralik] == 1 && HouseInfo[kiraid][evKiralayan] == PlayerData[playerid][pID])
	{
	    if (maas+PlayerData[playerid][pMaas] < HouseInfo[kiraid][evKiraUcret])
	    {
	        HouseInfo[kiraid][evKiralayan] = -1;
	        Ev_Kaydet(kiraid);
	        Ev_Yenile(kiraid);
	        if (GetPlayerIDWithSQLID(HouseInfo[kiraid][evSahip]) != -1)
	        {
	            BilgiMesajGonder(playerid, "%s adlý kiþi kirayý ödemediði için evden otomatik olarak atýldý.",ReturnName(playerid, 0));
	        }
	        else
			{
			    new str[100];
			    format(str, sizeof(str), "%s adlý kiþi kirayý ödemediði için evden otomatik olarak atýldý.", ReturnName(playerid, 0));
			    BildirimEkle(HouseInfo[kiraid][evSahip], str, "Sistem");
			}
	    }
	    else
	    {
	        if (maas > HouseInfo[kiraid][evKiraUcret]) maas -= HouseInfo[kiraid][evKiraUcret];
	        else PlayerData[playerid][pMaas] -= HouseInfo[kiraid][evKiraUcret];
	        HouseInfo[kiraid][evCash] += HouseInfo[kiraid][evKiraUcret];
	        Ev_Kaydet(kiraid);
	    }
	}

	new sirketmaas;
	if(PlayerData[playerid][pSirket] != -1)
	{
		new sirketid = PlayerData[playerid][pSirket];
			sirketmaas = PlayerData[playerid][pSirketMaas];

		if(sirketData[sirketid][sirketKasa] > sirketmaas)
		{
			SendClientMessageEx(playerid, 0x00BD00AA, "{FF00FF}|{C8C8C8} Þirket maaþý: %s", FormatNumber(sirketmaas));
			PlayerData[playerid][pMaas] += sirketmaas;
			sirketData[sirketid][sirketKasa] -= sirketmaas;
			sirketData[sirketid][sirketCP]++;
			Sirket_Kaydet(sirketid);
		}
	}

	PlayerData[playerid][pMaas] += maas+olusummaas;
	new vipmaas;
	switch (PlayerData[playerid][pVip])
	{
	    case 1: PlayerData[playerid][pMaas] += 400, vipmaas = 400;
	    case 2: PlayerData[playerid][pMaas] += 650, vipmaas = 650;
	    case 3: PlayerData[playerid][pMaas] += 1000, vipmaas = 1000;
	}

	    SendClientMessageEx(playerid, 0x00BD00AA, "{FF00FF}|{C8C8C8} Þu anki maaþ hesabý: %s", FormatNumber(PlayerData[playerid][pMaas]));

	SendClientMessageEx(playerid, 0x00BD00AA, "{FF00FF}|{C8C8C8} Toplam eklenen maaþ: %s", FormatNumber(maas+olusummaas+vipmaas+sirketmaas));
//	if (PlayerData[playerid][pHediye] == 1) SendClientMessage(playerid, 0x00BD00AA, "Hediye alma zamanýnýz geldi!");
	return 1;
}
stock Boombox_SetURL(playerid, url[])
{
	if (BoomboxData[playerid][boomboxPlaced])
	{
	    strpack(BoomboxData[playerid][boomboxURL], url, 128 char);

		foreach (new i : Player) if (PlayerData[i][pMuzikKutusu] == playerid)
		{
 			StopAudioStreamForPlayer(i);
   			PlayAudioStreamForPlayer(i, url, BoomboxData[playerid][boomboxPos][0], BoomboxData[playerid][boomboxPos][1], BoomboxData[playerid][boomboxPos][2], 30.0, 1);
  		}
	}
	return 1;
}
stock Boombox_Destroy(playerid)
{
	if (BoomboxData[playerid][boomboxPlaced])
	{
		if (IsValidDynamicObject(BoomboxData[playerid][boomboxObject]))
		    DestroyDynamicObject(BoomboxData[playerid][boomboxObject]);

		if (IsValidDynamic3DTextLabel(BoomboxData[playerid][boomboxText3D]))
		    DestroyDynamic3DTextLabel(BoomboxData[playerid][boomboxText3D]);

		foreach (new i : Player) if (PlayerData[i][pMuzikKutusu] == playerid) {
		    StopAudioStreamForPlayer(i);
		}
        BoomboxData[playerid][boomboxPlaced] = false;
        BoomboxData[playerid][boomboxInterior] = 0;
        BoomboxData[playerid][boomboxWorld] = 0;
	}
	return 1;
}
stock Boombox_Nearest(playerid)
{
	foreach (new i : Player) if (BoomboxData[i][boomboxPlaced] && GetPlayerInterior(playerid) == BoomboxData[i][boomboxInterior] && GetPlayerVirtualWorld(playerid) == BoomboxData[i][boomboxWorld] && IsPlayerInRangeOfPoint(playerid, 30.0, BoomboxData[i][boomboxPos][0], BoomboxData[i][boomboxPos][1], BoomboxData[i][boomboxPos][2])) {
     	return i;
	}
	return INVALID_PLAYER_ID;
}
stock Boombox_Place(playerid)
{
	new
	    Float:angle;

	GetPlayerFacingAngle(playerid, angle);

	strpack(BoomboxData[playerid][boomboxURL], "", 128 char);
	GetPlayerPos(playerid, BoomboxData[playerid][boomboxPos][0], BoomboxData[playerid][boomboxPos][1], BoomboxData[playerid][boomboxPos][2]);

	BoomboxData[playerid][boomboxPlaced] = true;
	BoomboxData[playerid][boomboxInterior] = GetPlayerInterior(playerid);
	BoomboxData[playerid][boomboxWorld] = GetPlayerVirtualWorld(playerid);
	new string[512];
	format(string, sizeof(string), "[Boombox]\n\nOluþturan: %s.", ReturnName(playerid, 0));
    BoomboxData[playerid][boomboxObject] = CreateDynamicObject(2226, BoomboxData[playerid][boomboxPos][0], BoomboxData[playerid][boomboxPos][1], BoomboxData[playerid][boomboxPos][2] - 0.9, 0.0, 0.0, angle, BoomboxData[playerid][boomboxWorld], BoomboxData[playerid][boomboxInterior]);
    BoomboxData[playerid][boomboxText3D] = CreateDynamic3DTextLabel(string, 0x39D8EDFF, BoomboxData[playerid][boomboxPos][0], BoomboxData[playerid][boomboxPos][1], BoomboxData[playerid][boomboxPos][2] - 0.7, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, BoomboxData[playerid][boomboxWorld], BoomboxData[playerid][boomboxInterior]);

	return 1;
}
stock Lokasyon_Sil(id)
{
	new query[100];
	format(query, sizeof(query), "DELETE FROM `lokasyon` WHERE `ID` = '%d'", Lokasyon[id][ID]);
	mysql_query(g_SQL, query, false);
	Lokasyon[id][Exists] = false;
	format(Lokasyon[id][lokasyonAd], 30, "");
	Lokasyon[id][lokasyonPos][0] = 0.0;
	Lokasyon[id][lokasyonPos][1] = 0.0;
	Lokasyon[id][lokasyonPos][2] = 0.0;
	return 1;
}

stock Lokasyon_Ekle(ad[], Float:posX, Float:posY, Float:posZ)
{
	for (new i; i<MAX_LOKASYON; i++)
	{
	    if (Lokasyon[i][Exists] == false)
	    {
	        Lokasyon[i][Exists] = true;
			Lokasyon[i][ID] = i;

	        format(Lokasyon[i][lokasyonAd], 30, ad);
	        Lokasyon[i][lokasyonPos][0] = posX;
	        Lokasyon[i][lokasyonPos][1] = posY;
	        Lokasyon[i][lokasyonPos][2] = posZ;

	        new query[256];
			mysql_format(g_SQL, query, sizeof(query), "INSERT INTO `lokasyon` (`ID`, `Ad`, `posX`, `posY`, `posZ`) VALUES ('%d', '%s', '%f', '%f', '%f')", i, ad, posX, posY, posZ);
			mysql_query (g_SQL, query);
			return i;
	    }
	}
	return -1;
}

stock CagriKapat(playerid)
{
	new targetid = PlayerData[playerid][pCallLine];
	if (PlayerData[playerid][pAramada] == ARAMA_ARANIYOR)
	{
		BilgiMesajGonder(targetid, "Giden çaðrý reddedildi.");
		BilgiMesajGonder(playerid, "Gelen çaðrý reddedildi.");
		PlayerData[playerid][pAramada] = 0;
		PlayerData[targetid][pAramada] = 0;
		PlayerData[playerid][pCallLine] = -1;
		PlayerData[targetid][pCallLine] = -1;
		DeletePVar(playerid, "Arayan");
		DeletePVar(targetid, "Arayan");
	}
	else if (PlayerData[playerid][pAramada] == ARAMA_ARIYOR)
	{
		PlayerData[playerid][pAramada] = 0;
		PlayerData[targetid][pAramada] = 0;
		PlayerData[playerid][pCallLine] = -1;
		PlayerData[targetid][pCallLine] = -1;
		DeletePVar(playerid, "Arayan");
		DeletePVar(targetid, "Arayan");
		MesajGonder(playerid, "Çaðrý bitirildi.");
	}
	else if (PlayerData[playerid][pAramada] == ARAMA_KONUSUYOR)
	{
		MesajGonder(playerid, "Telefonu kapattýnýz.");
		MesajGonder(targetid, "Konuþtuðunuz kiþi telefonu kapattý.");
		PlayerData[playerid][pAramada] = 0;
		PlayerData[targetid][pAramada] = 0;
		PlayerData[playerid][pCallLine] = -1;
		PlayerData[targetid][pCallLine] = -1;
		DeletePVar(playerid, "Arayan");
		DeletePVar(targetid, "Arayan");
	}
	return 1;
}
SetFactionMarker(playerid, type, color)
{
    foreach (new i : Player) if (GetFactionType(i) == type) {
    	SetPlayerMarkerForPlayer(i, playerid, color);
	}
	return 1;
}
stock Telefon_Menu(playerid)
{
	new str[100];
	format(str, sizeof(str), "Telefon (#%d)", PlayerData[playerid][pTelefon]);
	Dialog_Show(playerid, TelefonMenu, DIALOG_STYLE_LIST, str, "{FFC100}» {FFFFFF}Numara Çevir\n{FFC100}» {FFFFFF}Kýsa Mesaj Yolla\n{000000}  \n{FFC100}» {FFFFFF}Rehber\n{FFC100}» {FFFFFF}Tarayýcý\n{FFC100}» {FFFFFF}LS Cell\n{FFC100}» {FFFFFF}Tarife Yükle\n{000000}  \n{FFC100}» {FFFFFF}Ayarlar\n{FFC100}» %s", "Seç", "Kapat", (PlayerData[playerid][pTelefonAyar][0] == 0) ? ("{FF0000}Telefonu Kapat") : ("{00FF00}Telefonu Aç"));
	return 1;
}
stock SatirDuzenle(str[])
{
    new a, b, x = strlen(str);
    for( ; a < x; ++a)
    {
        switch(str[a])
        {
            case '\n', '\t', '\f', '\r', ' ': continue;
            default: break;
        }
    }
    for(b = (x - 1); b > a; --b)
    {
        switch(str[b])
        {
            case '\n', '\t', '\f', '\r', ' ': continue;
            default: break;
        }
    }
    strmid(str, str, a, (b + 1), cellmax);
    return 1;
}
stock IP_AL(ip_adresi[])
{
 new
     ip_sayim = 0,
     i = 0, j = GetMaxPlayers(),
     ip_adres[32+1]
 ;
 for( ; i < j; i++)  if(IsPlayerConnected(i))
 {
            GetPlayerIp(i,ip_adres,32);
            if(!strcmp(ip_adres, ip_adresi)) ip_sayim++;
 }
 return ip_sayim;
}
stock FindBusiness(playerid, bizname[])
{
    new str[1000], string[124], sayi, tip[30];
	strcat(str, "ID\tAd\tÝþyeri Türü\tMesafe\n");
	for (new i; i<MAX_ISYERI; i++) if (Isyeri[i][isyeriExists])
	{
	    if (strfind(Isyeri[i][isyeriName], bizname, true) != -1)
	    {
	        switch (Isyeri[i][isyeriTip])
			{
			    case 1: tip = "Regmart";
			    case 2: tip = "Binco";
			    case 3: tip = "Restaurant";
			    case 4: tip = "Grotti";
			    case 5: tip = "Tekno Shop";
			    case 6: tip = "Club";
			    case 7: tip = "Kumarhane";
			    default: tip = "N/A";
			}
            format(string, sizeof(string), "{FFFFFF}%d\t{FFFFFF}%s\t{FFFFFF}%s\t{38c5f7}%.2f metre\n", i, Isyeri[i][isyeriName], tip, GetPlayerDistanceFromPoint(playerid, Isyeri[i][isyeriPos][0], Isyeri[i][isyeriPos][1], Isyeri[i][isyeriPos][2]));
            strcat(str, string);
            sayi++;
	    }
	}
	if (sayi == 0)
	{
	    HataMesajGonder(playerid, "Ýþyeri bulunamadý.");
	    return Dialog_Show(playerid, FindBiz, DIALOG_STYLE_INPUT, "Ýþyeri Bul", "{38c5f7}» {FFFFFF}Lütfen bulmak istediðiniz iþyerinin adýný girin:", "Devam", "Geri");
	}
	format(string, sizeof(string), "Bulunan Ýþyerleri (%d adet)", sayi);
	Dialog_Show(playerid, IsyeriBul, DIALOG_STYLE_TABLIST_HEADERS, string, str, "Ýþaretle", "Geri");
	return 1;
}
stock GlobalLokasyonlar(playerid)
{
	new str[1700], string[124], sayi;
	strcat(str, "ID\tAd\tMesafe\n");
	for (new i; i<MAX_LOKASYON; i++)
	{
	    if (Lokasyon[i][Exists] == true)
	    {
	        sayi++;
	        format(string, sizeof(string), "{FFFFFF}%d\t{FFFFFF}%s\t{38c5f7}%.2f metre\n", i, Lokasyon[i][lokasyonAd], GetPlayerDistanceFromPoint(playerid, Lokasyon[i][lokasyonPos][0],Lokasyon[i][lokasyonPos][1], Lokasyon[i][lokasyonPos][2]));
	        strcat(str, string);
	    }
	}
	if (sayi == 0) return HataMesajGonder(playerid, "Hiç lokasyon bulunamadý.");
	format(string, sizeof(string), "Global Lokasyonlar (%d konum)", sayi);
	Dialog_Show(playerid, GlobalLokasyonlar, DIALOG_STYLE_TABLIST_HEADERS, string, str, "Ýþaretle", "Geri");
	return 1;
}
Bitcoin_Menu(playerid)
{
	if (GetServerBilgi("BitcoinAlma") == 0 || GetServerBilgi("BitcoinSatma") == 0) return HataMesajGonder(playerid, "BitCoin sistemi devre dýþý.");
	new str[50];
	format(str, sizeof(str), "{FFFFFF}BitCoin Sayýnýz: {38c5f7}%d", PlayerData[playerid][pBitcoin]);
	Dialog_Show(playerid, BitCoin, DIALOG_STYLE_LIST, str, "{38c5f7}» {FFFFFF}BitCoin Al\t\t{38c5f7}%s\n{38c5f7}» {FFFFFF}BitCoin Sat\t\t{38c5f7}%s", "Seç", "Geri", FormatNumber(GetServerBilgi("BitcoinAlma")), FormatNumber(GetServerBilgi("BitcoinSatma")));
	return 1;
}

AracIlanlari(playerid, aracid)
{
    if (aracid < 411 || aracid > 611) return HataMesajGonder(playerid, "Böyle bir araç yok!");
    new str[1000], string[200], sayi;
    strcat(str, "{FFFFFF}ID\t{FFFFFF}Fiyat\t{FFFFFF}Kilometre\t{FFFFFF}Vergi\n");
	for (new i; i<MAX_ARAC; i++)
	{
	    if (AracInfo[i][aracExists] && AracInfo[i][aracModel] == aracid && AracInfo[i][aracSatilik] == 1 && AracInfo[i][aracTip] == 4)
	    {
	        sayi++;
	        format(string, sizeof(string), "{FFFFFF}%d\t{38c5f7}%s\t{FFFFFF}%.1f\t{38c5f7}%s\n",i, FormatNumber(AracInfo[i][aracFiyat]), AracInfo[i][aracKM], FormatNumber(AracInfo[i][aracVergi]));
	        strcat(str, string);
	    }
	}
	if (sayi == 0)
	{
	    HataMesajGonder(playerid, "Satýlýk araç bulunamadý.");
	    return Dialog_Show(playerid, AracIlanlari, DIALOG_STYLE_INPUT, "{FFFFFF}Tarayýcý ~ Araç Ýlanlarý", "{38c5f7}» {FFFFFF}Lütfen aratmak istediðiniz aracýn modelini veya adýný girin:", "Ara", "Geri");
	}
	format(string, sizeof(string), "Satýlýk Araçlar (%d)", sayi);
	Dialog_Show(playerid, SatilikAraclar, DIALOG_STYLE_TABLIST_HEADERS, string, str, "Ýþaretle", "Geri");
	return 1;
}
TelNo(playerid, targetid)
{
	new query[200], returnn[24] = "Bilinmeyen";
    if (!OyundaDegil(targetid)) return returnn;
    format(query, sizeof(query), "SELECT `Isim` FROM `rehber` WHERE `Numara` = '%d' AND `RehberNumara` = '%d'", PlayerData[playerid][pTelefon], PlayerData[targetid][pTelefon]);
    new Cache:cachee = mysql_query(g_SQL, query);
    new rows;
    cache_get_row_count(rows);
    if (rows)
    {
        new name[24];
        cache_get_value_name(0, "Isim", name, 24);
        format(returnn, sizeof(returnn), "%s", name);
    }
    else
    {
        format(returnn, sizeof(returnn), "%d", PlayerData[targetid][pTelefon]);
    }
    cache_delete(cachee);
	return returnn;
}
RehberdeVar(playerid, numara)
{
	new query[200];
	format(query, sizeof(query), "SELECT null FROM `rehber` WHERE `Numara` = '%d' AND `RehberNumara` = '%d'", PlayerData[playerid][pTelefon], numara);
	new Cache:cachee = mysql_query(g_SQL, query);
	new rows;
    cache_get_row_count(rows);
    cache_delete(cachee);
    if (rows) return 1;
    return 0;
}
GetNumberOwner(number)
{
	foreach (new i : Player) if (PlayerData[i][pTelefon] != -1 && PlayerData[i][pTelefon] == number) {
		return i;
	}
	return INVALID_PLAYER_ID;
}
GetVehicleModelIDFromName(vname[])
{
        for (new i = 0; i < 211; i++)
        {
                if ( strfind(VehicleNames[i], vname, true) != -1 )
                        return i + 400;
        }
        return -1;
}
stock Telefon_Rehber(playerid)
{
	if (PlayerData[playerid][pTelefon] == -1) return 1;
	new query[124], str[500];
	format(query, sizeof(query), "SELECT * FROM `rehber` WHERE `Numara` = '%d' ORDER BY `Numara` DESC LIMIT 15", PlayerData[playerid][pTelefon]);
	new Cache:cachee = mysql_query(g_SQL, query);
	new rows;
	cache_get_row_count(rows);
	if (rows)
	{
		new number, name[24], tarih[20];
		for (new i; i<rows; i++)
		{
			cache_get_value_name_int(i, "RehberNumara", number);
			cache_get_value_name(i, "Isim", name, 24);
			cache_get_value_name(i, "Tarih", tarih, 20);
			RehberListeleme[playerid][i] = number;
			format(str, sizeof(str), "%s{FFFFFF}%s (Numara: %d) - %s\n", str, name, number, tarih);

		}
		strcat(str, "{38c5f7}» {FFFFFF}Kiþi Ekle");
	}
	else
	{
		format(str, sizeof(str), "{38c5f7}» {FFFFFF}Kiþi Ekle");
	}
	SetPVarInt(playerid, "RehberSayi", rows);
	cache_delete(cachee);
	Dialog_Show(playerid, TelefonRehber, DIALOG_STYLE_LIST, "Rehber", str, "Seç", "Geri");
	return 1;
}

stock YaraliListesi(playerid)
{
	new str[500], string[200], sayi;
	strcat(str, "{FF8282}Ad\t{FF8282}Bölge\t{FF8282}Durum\n");
	foreach (new i:Player)
	{
	    if (PlayerData[i][pBaygin] == 1)
	    {
	        new Float:pos[3];
	        GetPlayerPosEx(i, pos[0], pos[1], pos[2]);
	        format(string, sizeof(string), "{FFFFFF}%s\t{FFFFFF}%s\t%s\n", ReturnName(i), GetLocation(pos[0], pos[1], pos[2]), (EMSAccepted(i) != INVALID_PLAYER_ID) ? ("{00FF6E}Kabul Edildi") : ("{FF0000}Bekliyor"));
	        strcat(str, string);
	        sayi++;
	    }
	}
	if (sayi == 0) return HataMesajGonder(playerid,  "Hiç yaralý yok.");
	format(string, sizeof(string), "Yaralýlar (%d)", sayi);
	Dialog_Show(playerid, Yaralilar, DIALOG_STYLE_TABLIST_HEADERS, string, str, "Kabul Et", "Kapat");
	return 1;
}

stock EMSAccepted(playerid)
{
	foreach (new i:Player)
	{
	    if (EMSKabul[i] == playerid && GetFactionType(i) == BIRLIK_LSMD)
	    {
	        return i;
	    }
	}
	return INVALID_PLAYER_ID;
}
stock SetPlayerLookAt(playerid, Float:X, Float:Y)
{
    new Float:Px, Float:Py, Float: Pa;
    GetPlayerPos(playerid, Px, Py, Pa);
    Pa = floatabs(atan((Y-Py)/(X-Px)));
    if (X <= Px && Y >= Py) Pa = floatsub(180, Pa);
    else if (X < Px && Y < Py) Pa = floatadd(Pa, 180);
    else if (X >= Px && Y <= Py) Pa = floatsub(360.0, Pa);
    Pa = floatsub(Pa, 90.0);
    if (Pa >= 360.0) Pa = floatsub(Pa, 360.0);
    SetPlayerFacingAngle(playerid, Pa);
}
ReturnHealth(playerid)
{
	static
	    Float:amount;

	GetPlayerHealth(playerid, amount);
	return floatround(amount, floatround_round);
}
ReturnArmour(playerid)
{
	static
	    Float:amount;

	GetPlayerArmour(playerid, amount);
	return floatround(amount, floatround_round);
}

stock GetAracVergi(aracmodel)
{
	if (aracmodel < 400 || aracmodel > 611) return 0;
	new Float:vergi = GetGaleriFiyat(aracmodel)/1000*0.3;
	return floatround(vergi);
}

stock GetAracMaksVergi(aracmodel)
{
	if (aracmodel < 400 || aracmodel > 611) return 0;
	new Float:vergi = GetGaleriFiyat(aracmodel) * 0.2;
	return floatround(vergi);
}

stock Car_LSPDTrunk(playerid, carid)
{
	new string[550];
	string[0] = EOS;

	strcat(string, "{1394BF}Ad\t{1394BF}Mermi\n");
	for (new i; i<5; i++)
	{
	    if (PolisAraci[carid][Silahlar][i] != 0 && PolisAraci[carid][Mermiler][i] != 0)
	    {
	        new silahadi[15];
	        GetWeaponName(PolisAraci[carid][Silahlar][i], silahadi, sizeof(silahadi));
	        format(string, sizeof(string), "%s{FFFFFF}%s\t{FFFFFF}%d\n",string,silahadi,PolisAraci[carid][Mermiler][i]);

		}
		else
		{
		    format(string, sizeof(string), "%s{FFFFFF}Boþ Silah Yuvasý\t{FFFFFF}0\n",string);
		}
	}
 	format(string, sizeof(string), "%s{FFFFFF}Aðrý Kesici (%d adet)\n",string, PolisAraci[carid][AgriKesici]);
	format(string, sizeof(string), "%s{FFFFFF}Çelik Yelek (%d adet)",string, PolisAraci[carid][CelikYelek]);
	SetPVarInt(playerid, "AracBagaj", carid);
	Dialog_Show(playerid, LSPDTrunk, DIALOG_STYLE_TABLIST_HEADERS, "{1394BF}LSPD ~ Bagaj", string, "Seç", "Kapat");
	return 1;
}
stock IsyeriMaksVergi(id)
{
	new maksvergi = 0;
	switch (Isyeri[id][isyeriTip])
	{
	    case 1: maksvergi = 75000;
	    case 2: maksvergi = 55000;
	    case 3: maksvergi = 49000;
	    case 4: maksvergi = 85000;
	    case 5: maksvergi = 60000;
	    case 6: maksvergi = 53000;
	    case 7: maksvergi = 155000;
	}
	return maksvergi;
}
stock GetIsyeriVergi(id)
{
	new vergi = 0;
	switch (Isyeri[id][isyeriTip])
	{
	    case 1: vergi = 80;
	    case 2: vergi = 65;
	    case 3: vergi = 50;
	    case 4: vergi = 100;
	    case 5: vergi = 75;
	    case 6: vergi = 60;
	    case 7: vergi = 200;
	}
	return vergi;
}
stock GetGaleriFiyat(amodel)
{
	new query[100];
	format(query, sizeof(query), "SELECT `fiyat` FROM `satilikaraclar` WHERE `model` = '%d'", amodel);
	new Cache:Radless = mysql_query(g_SQL, query);
	new rows;
	cache_get_row_count(rows);
	if (rows)
	{
		new fiyat = 0;
		cache_get_value_name_int(0, "fiyat", fiyat);
		cache_delete(Radless);
		return fiyat;
	}

	else return 0;

}
stock SetPlayerInPrison(playerid)
{
	SetPlayerPos(playerid, 1393.3469,960.4508,3016.7773);
	SetPlayerInterior(playerid, 2);
	SetPlayerVirtualWorld(playerid, 2);
	SetCameraBehindPlayer(playerid);
	return 1;
}
Arrest_Nearest(playerid)
{
    for (new i = 0; i != MAX_ARREST_POINTS; i ++) if (ArrestData[i][arrestExists] && IsPlayerInRangeOfPoint(playerid, 4.0, ArrestData[i][arrestPos][0], ArrestData[i][arrestPos][1], ArrestData[i][arrestPos][2]))
	{
		if (GetPlayerInterior(playerid) == ArrestData[i][arrestInterior] && GetPlayerVirtualWorld(playerid) == ArrestData[i][arrestWorld])
			return i;
	}
	return -1;
}
stock IsPlayerNearArrest(playerid)
{
	new
	    id = Arrest_Nearest(playerid);

	return (id != -1);
}
stock MenuMVB(playerid)
{
	if (GetFactionType(playerid) == BIRLIK_LSPD || GetFactionType(playerid) == BIRLIK_FBI)
	{
	    Dialog_Show(playerid, MenuMVB, DIALOG_STYLE_LIST, "{1394BF}Mobil Veritabaný", "{1394BF}» {FFFFFF}Kriminal Veritabaný\n{1394BF}» {FFFFFF}Plaka Ýnceleme\n{1394BF}» {FFFFFF}Telefon Sorgulat\n{1394BF}» {FFFFFF}Aranmalar\n{1394BF}» {FFFFFF}Ihbarlar\n{1394BF}» {FFFFFF}Dashcam Aç/Kapat\n{1394BF}» {FFFFFF}Gecikmiþ Vatandaþ Cezalarý", "Seç", "Kapat");
	}
}
stock CreateMDCTextdraws(vehicleid)
{
    carMDC[vehicleid][0] = TextDrawCreate(546.749938, 159.083328, "box");
	TextDrawLetterSize(carMDC[vehicleid][0], 0.000000, 5.830162);
	TextDrawTextSize(carMDC[vehicleid][0], 619.000000, 0.000000);
	TextDrawAlignment(carMDC[vehicleid][0], 1);
	TextDrawColor(carMDC[vehicleid][0], -1);
	TextDrawUseBox(carMDC[vehicleid][0], 1);
	TextDrawBoxColor(carMDC[vehicleid][0], 80);
	TextDrawSetShadow(carMDC[vehicleid][0], 0);
	TextDrawSetOutline(carMDC[vehicleid][0], 0);
	TextDrawBackgroundColor(carMDC[vehicleid][0], 255);
	TextDrawFont(carMDC[vehicleid][0], 1);
	TextDrawSetProportional(carMDC[vehicleid][0], 1);
	TextDrawSetShadow(carMDC[vehicleid][0], 0);

	carMDC[vehicleid][1] = TextDrawCreate(567.833374, 149.750045, "mdc");
	TextDrawLetterSize(carMDC[vehicleid][1], 0.400000, 1.600000);
	TextDrawAlignment(carMDC[vehicleid][1], 1);
	TextDrawColor(carMDC[vehicleid][1], -2147483393);
	TextDrawSetShadow(carMDC[vehicleid][1], 0);
	TextDrawSetOutline(carMDC[vehicleid][1], -2);
	TextDrawBackgroundColor(carMDC[vehicleid][1], 255);
	TextDrawFont(carMDC[vehicleid][1], 3);
	TextDrawSetProportional(carMDC[vehicleid][1], 1);
	TextDrawSetShadow(carMDC[vehicleid][1], 0);

	carMDC[vehicleid][2] = TextDrawCreate(550.497985, 168.416625, "~r~PLAKA: ~y~N/A");
	TextDrawLetterSize(carMDC[vehicleid][2], 0.276309, 1.179998);
	TextDrawAlignment(carMDC[vehicleid][2], 1);
	TextDrawColor(carMDC[vehicleid][2], -1);
	TextDrawSetShadow(carMDC[vehicleid][2], 0);
	TextDrawSetOutline(carMDC[vehicleid][2], -1);
	TextDrawBackgroundColor(carMDC[vehicleid][2], 255);
	TextDrawFont(carMDC[vehicleid][2], 1);
	TextDrawSetProportional(carMDC[vehicleid][2], 1);
	TextDrawSetShadow(carMDC[vehicleid][2], 0);

	carMDC[vehicleid][3] = TextDrawCreate(549.561096, 181.833236, "~r~MODEL: ~y~N/A");
	TextDrawLetterSize(carMDC[vehicleid][3], 0.276309, 1.179998);
	TextDrawAlignment(carMDC[vehicleid][3], 1);
	TextDrawColor(carMDC[vehicleid][3], -1);
	TextDrawSetShadow(carMDC[vehicleid][3], 0);
	TextDrawSetOutline(carMDC[vehicleid][3], -1);
	TextDrawBackgroundColor(carMDC[vehicleid][3], 255);
	TextDrawFont(carMDC[vehicleid][3], 1);
	TextDrawSetProportional(carMDC[vehicleid][3], 1);
	TextDrawSetShadow(carMDC[vehicleid][3], 0);

	carMDC[vehicleid][4] = TextDrawCreate(550.029541, 195.833236, "~r~HIZ: ~y~N/A");
	TextDrawLetterSize(carMDC[vehicleid][4], 0.276309, 1.179998);
	TextDrawAlignment(carMDC[vehicleid][4], 1);
	TextDrawColor(carMDC[vehicleid][4], -1);
	TextDrawSetShadow(carMDC[vehicleid][4], 0);
	TextDrawSetOutline(carMDC[vehicleid][4], -1);
	TextDrawBackgroundColor(carMDC[vehicleid][4], 255);
	TextDrawFont(carMDC[vehicleid][4], 1);
	TextDrawSetProportional(carMDC[vehicleid][4], 1);
	TextDrawSetShadow(carMDC[vehicleid][4], 0);
	return 1;
}

stock GetTicketCount(playerid)
{
	new sayi = 0;
	for (new i; i<MAX_PLAYER_TICKETS; i++) if (TicketData[playerid][i][ticketExists])
	{
	    sayi++;
	}
	return sayi;
}
stock SicilGoruntule(playerid, id)
{
	new query[124];
	format(query, sizeof(query), "SELECT * FROM `icsicil` WHERE `playersqlid` = '%d' ORDER BY tarih DESC LIMIT %d, 15", PlayerData[id][pID], GetPVarInt(playerid, "ListPage")*15);
	new Cache:Radless = mysql_query(g_SQL, query);
	new rows;
	cache_get_row_count(rows);
	if (rows)
	{
	    new str[1500], string[100], sebep[50], memuradi[24], tarih[22];
	    strcat(str, "{1394BF}Sebep\t{1394BF}Memur\t{1394BF}Tarih\n");
	    for (new i; i<rows; i++)
	    {
	        cache_get_value_name(i, "sebep", sebep, 50);
	        cache_get_value_name(i, "memuradi", memuradi, 24);
	        cache_get_value_name(i, "tarih", tarih, 22);
	        format(string, sizeof(string), "{FFFFFF}%s\t{FFFFFF}%s\t{FFFFFF}%s\n", sebep, memuradi, tarih);
	        strcat(str, string);
	    }
	    cache_delete(Radless);
	    format(string, sizeof(string), "%s Sicil (Sayfa %d)", ReturnName(GetPVarInt(playerid, "KriminalVeritabani")), GetPVarInt(playerid, "ListPage")+1);
	    Dialog_Show(playerid, SicilGoruntule, DIALOG_STYLE_TABLIST_HEADERS, string, str, "Sonraki Sayfa", "Geri");
	}
	else
	{
	    cache_delete(Radless);
	    HataMesajGonder(playerid, "Daha fazla sicil kaydý bulunamadý.");
	    return Dialog_Show(playerid, Kriminal, DIALOG_STYLE_LIST, "{1394BF}Mobil Veritabaný ~ Kriminal Veritabaný", "{1394BF}» {FFFFFF}Kimlik Bilgileri\n{1394BF}» {FFFFFF}Sicil Kaydý\n{1394BF}» {FFFFFF}Mülkler\n{1394BF}» {FFFFFF}Aranma Ekle\n{1394BF}» {FFFFFF}Aranma Sil\n{1394BF}» {FFFFFF}Ceza Yaz\n{1394BF}» {FFFFFF}Lokasyon Bul\n{1394BF}» {FFFFFF}Cezalar", "Seç", "Geri");
	}
	return 1;
}
stock ICSicil_GetCount(sqlid)
{
	new query[100];
	format(query, sizeof(query), "SELECT null FROM `icsicil` WHERE `playersqlid` = '%d'", sqlid);
	new Cache:Radless = mysql_query(g_SQL, query);
	new rows;
	cache_get_row_count(rows);
	cache_delete(Radless);
	return rows;
}
stock Sicil_Ekle(oyuncusqlid, memuradi[], sebep[])
{
	new query[275];
	format(query, sizeof(query), "INSERT INTO `icsicil` (`playersqlid`, `memuradi`, `sebep`, `tarih`) VALUES ('%d', '%s', '%s', '%s')", oyuncusqlid, memuradi, SQL_ReturnEscaped(sebep), ReturnDate());
	mysql_query(g_SQL, query, false);
	return 1;
}
stock CCTVMenu(playerid)
{
	new str[1000], string[100],sayi;
	strcat(str, "ID\tAd\n");
	foreach (new i:CCTVIter)
	{
 		sayi++;
   		format(string, sizeof(string), "{FFFFFF}%d\t{FFFFFF}%s\n",i, CCTVInfo[i][cctv_Name]);
     	strcat(str, string);
	}
	if (sayi == 0) return HataMesajGonder(playerid, "Hiç CCTV bulunamadý.");
	format(string, sizeof(string), "{00FF26}CCTV (Toplam %d/%d)", sayi, MAX_CCTV);
	Dialog_Show(playerid, CCTV, DIALOG_STYLE_TABLIST_HEADERS, string, str, "Ýzle", "Kapat");
	return 1;
}
PlayerViewCCTV(playerid, id)
{
	if (PlayerData[playerid][pCCTV] == -1)
	{
		new Float: x, Float: y, Float: z;

		GetPlayerPos(playerid, x, y, z);
		CCTV_oldSkin[playerid] = GetPlayerSkinEx(playerid);

		CCTV_oldX[playerid] = x;
		CCTV_oldY[playerid] = y;
		CCTV_oldZ[playerid] = z;
		CCTV_oldVW[playerid] = GetPlayerVirtualWorld(playerid);
		CCTV_oldInterior[playerid] = GetPlayerInterior(playerid);
	}
	SetPlayerVirtualWorld(playerid, CCTVInfo[id][cctv_VW]);
	SetPlayerInterior(playerid, CCTVInfo[id][cctv_Interior]);
	PlayerData[playerid][pCCTV] = id;
	TogglePlayerSpectating(playerid, 1);
	AttachCameraToObject(playerid, CCTVInfo[id][cctv_Object]);

	MesajGonder(playerid, "%s adlý bölgeyi izlemeye baþladýn, (/cctvcik) ile çýkabilirsiniz.", CCTVInfo[id][cctv_Name]);
	return 1;
}
PlayerCancelCCTV(playerid)
{
	TogglePlayerSpectating(playerid, 0);
	PlayerData[playerid][pCCTV] = -1;
	SetPlayerPos(playerid, CCTV_oldX[playerid], CCTV_oldY[playerid], CCTV_oldZ[playerid]);
	SetPlayerVirtualWorld(playerid, CCTV_oldVW[playerid]);
	SetPlayerInterior(playerid, CCTV_oldInterior[playerid]);
	SetPlayerSkin(playerid, CCTV_oldSkin[playerid]);
	ObjelerYukleniyor(playerid);
	SetWeapons(playerid);

	CCTV_oldX[playerid] = CCTV_oldY[playerid] = CCTV_oldZ[playerid] = 0.0;
	CCTV_oldVW[playerid] = CCTV_oldInterior[playerid] = CCTV_oldSkin[playerid] = -1;
	return 1;
}
stock GetClosestCar(iPlayer, iException = INVALID_VEHICLE_ID, Float: fRange = Float: 0x7F800000) {

	new
		iReturnID = -1,
		Float: fVehiclePos[4];

	for (new i = 1; i <= MAX_VEHICLES; ++i) if (GetVehicleModel(i) && i != iException) {
		GetVehiclePos(i, fVehiclePos[0], fVehiclePos[1], fVehiclePos[2]);
		if ((fVehiclePos[3] = GetPlayerDistanceFromPoint(iPlayer, fVehiclePos[0], fVehiclePos[1], fVehiclePos[2])) < fRange) {
			fRange = fVehiclePos[3];
			iReturnID = i;
		}
	}
	return iReturnID;
}
stock GetVehicleInfrontID (vehid)
{
    new Float: temp = 7.0;
        new j = 0;
        for (new i = 0; i < MAX_VEHICLES; i++)
        {
            new Float: a, Float: x1, Float: y1, Float: z1, Float: x2, Float: y2, Float: z2;
        GetVehiclePos (vehid, x1, y1, z1);
        GetVehicleZAngle (vehid, a);
                if (i != vehid)
                {
                        if (GetVehiclePos (i, x2, y2, z2))
                        {
                                new Float: distance = floatsqroot (floatpower ((x1 - x2), 2) + floatpower ((y1 - y2), 2) + floatpower ((z1 - z2), 2));
                                GetVehicleZAngle (vehid, a);

                                if (distance < 300.0)
                                {
                                x1 = x1 + (distance * floatsin(-a, degrees));
                                        y1 = y1 + (distance * floatcos(-a, degrees));

                                        distance = floatsqroot ((floatpower ((x1 - x2), 2)) + (floatpower ((y1 - y2), 2)));

                                        if (temp > distance)
                                        {
                                                temp = distance;
                                                j = i;
                                        }
                                }
                        }
                }
        }
        if (temp < 7.0) return j;
        return -1;
}
/*stock BirlikAdKisalt(bid)
{
	if (bid == -1) return 1;
	new kisaltma[30];
	format(kisaltma,sizeof(kisaltma), "%s",Birlikler[bid][birlikAd]);
	if (Birlikler[bid][birlikTip] == BIRLIK_LSPD) format(kisaltma,sizeof(kisaltma), "LSPD");
	if (Birlikler[bid][birlikTip] == BIRLIK_LSMD) format(kisaltma,sizeof(kisaltma), "LSMD");
	if (Birlikler[bid][birlikTip] == BIRLIK_FBI)  format(kisaltma,sizeof(kisaltma), "FBI");
	if (Birlikler[bid][birlikTip] == BIRLIK_DEVLET) format(kisaltma,sizeof(kisaltma), "GOV");
	return kisaltma;
}*/
stock GetVehicleMaxSeats(vehicleid)
{
	new deger;

	if(GetVehicleModel(vehicleid) == 599)
		deger = 4;

	else
	{
	    static const g_arrMaxSeats[] = {
			4, 2, 2, 2, 4, 4, 1, 2, 2, 4, 2, 2, 2, 4, 2, 2, 4, 2, 4, 2, 4, 4, 2, 2, 2, 1, 4, 4, 4, 2,
			1, 7, 1, 2, 2, 0, 2, 7, 4, 2, 4, 1, 2, 2, 2, 4, 1, 2, 1, 0, 0, 2, 1, 1, 1, 2, 2, 2, 4, 4,
			2, 2, 2, 2, 1, 1, 4, 4, 2, 2, 4, 2, 1, 1, 2, 2, 1, 2, 2, 4, 2, 1, 4, 3, 1, 1, 1, 4, 2, 2,
			4, 2, 4, 1, 2, 2, 2, 4, 4, 2, 2, 1, 2, 2, 2, 2, 2, 4, 2, 1, 1, 2, 1, 1, 2, 2, 4, 2, 2, 1,
			1, 2, 2, 2, 2, 2, 2, 2, 2, 4, 1, 1, 1, 2, 2, 2, 2, 7, 7, 1, 4, 2, 2, 2, 2, 2, 4, 4, 2, 2,
			4, 4, 2, 1, 2, 2, 2, 2, 2, 2, 4, 4, 2, 2, 1, 2, 4, 4, 1, 0, 0, 1, 1, 2, 1, 2, 2, 1, 2, 4,
			4, 2, 4, 1, 0, 4, 2, 2, 2, 2, 0, 0, 7, 2, 2, 1, 4, 4, 4, 2, 2, 2, 2, 2, 4, 2, 0, 0, 0, 4,
			0, 0
		};
		new
		    model = GetVehicleModel(vehicleid);

		if (400 <= model <= 611)
		    deger = g_arrMaxSeats[model - 400];
	}

	return deger;
}
stock GetAvailableSeat(vehicleid, start = 1)
{
	new seats = GetVehicleMaxSeats(vehicleid);

	for (new i = start; i < seats; i ++) if (!IsVehicleSeatUsed(vehicleid, i)) {
	    return i;
	}
	return -1;
}
stock IsVehicleSeatUsed(vehicleid, seat)
{
	foreach (new i : Player) if (IsPlayerInVehicle(i, vehicleid) && GetPlayerVehicleSeat(i) == seat) {
	    return 1;
	}
	return 0;
}
stock SendRadioMessage(frequency, color, const str[], {Float,_}:...)
{
	static
	    args,
	    start,
	    end,
	    string[144]
	;
	#emit LOAD.S.pri 8
	#emit STOR.pri args

	if (args > 12)
	{
		#emit ADDR.pri str
		#emit STOR.pri start

	    for (end = start + (args - 12); end > start; end -= 4)
		{
	        #emit LREF.pri end
	        #emit PUSH.pri
		}
		#emit PUSH.S str
		#emit PUSH.C 144
		#emit PUSH.C string
		#emit PUSH.C args

		#emit SYSREQ.C format
		#emit LCTRL 5
		#emit SCTRL 4

		foreach (new i : Player) if (PlayerData[i][pRadyo] == 1 && PlayerData[i][pFrekans] == frequency) {
		    SendClientMessage(i, color, string);
		}
		return 1;
	}
	foreach (new i : Player) if (PlayerData[i][pRadyo] == 1 && PlayerData[i][pFrekans] == frequency) {
 		SendClientMessage(i, color, str);
	}
	return 1;
}
stock SendBirlikMessageEx(type, color, const str[], {Float,_}:...)
{
	static
	    args,
	    start,
	    end,
	    string[144]
	;
	#emit LOAD.S.pri 8
	#emit STOR.pri args

	if (args > 12)
	{
		#emit ADDR.pri str
		#emit STOR.pri start

	    for (end = start + (args - 12); end > start; end -= 4)
		{
	        #emit LREF.pri end
	        #emit PUSH.pri
		}
		#emit PUSH.S str
		#emit PUSH.C 144
		#emit PUSH.C string
		#emit PUSH.C args

		#emit SYSREQ.C format
		#emit LCTRL 5
		#emit SCTRL 4

		foreach (new i : Player) if (PlayerData[i][pFaction] != -1 && GetFactionType(i) == type && PlayerData[i][pAyarlar][0] == 0) {
		    SendClientMessage(i, color, string);
		}
		return 1;
	}
	foreach (new i : Player) if (PlayerData[i][pFaction] != -1 && GetFactionType(i) == type && PlayerData[i][pAyarlar][0] == 0) {
 		SendClientMessage(i, color, str);
	}
	return 1;
}

CanAyarla(playerid, Float:amount)
{
	PlayerData[playerid][pHealth] = amount;
	SetPlayerHealth(playerid, amount);
    return 1;
}

ZirhAyarla(playerid, Float:amount)
{
	PlayerData[playerid][pArmour] = amount;
	SetPlayerArmour(playerid, amount);
    return 1;
}
SaveWeapons(playerid)
{
	if (pbOda[playerid] != -1 && !IsPlayerSpawned(playerid)) return 1;
	new a;
	for (new i; i<13; i++)
	{
	    GetPlayerWeaponData(playerid, i, a, PlayerData[playerid][pMermiler][i]);
	}
	return 1;
}

ResetWeapons(playerid)
{
	ResetPlayerWeapons(playerid);

	for (new i = 0; i < 13; i ++)
	{
		PlayerData[playerid][pSilahlar][i] = 0;
		PlayerData[playerid][pMermiler][i] = 0;
	}
	return 1;
}

stock PlayerHasWeapon(playerid, weaponid)
{
	new
	    weapon,
	    ammo;

	for (new i = 0; i < 13; i ++) if (PlayerData[playerid][pSilahlar][i] == weaponid) {
	    GetPlayerWeaponData(playerid, i, weapon, ammo);

	    if (weapon == weaponid) return 1;
	}
	return 0;
}
GiveWeaponToPlayer(playerid, weaponid, ammo)
{
	if (weaponid < 0 || weaponid > 46)
	    return 0;

	PlayerData[playerid][pSilahlar][g_aWeaponSlots[weaponid]] = weaponid;
	PlayerData[playerid][pMermiler][g_aWeaponSlots[weaponid]] += ammo;
	return GivePlayerWeapon(playerid, weaponid, ammo);
}
Entrance_Delete(entranceid)
{
    if (entranceid != -1 && EntranceData[entranceid][entranceExists])
    {
        new
            string[64];

        format(string, sizeof(string), "DELETE FROM `entrances` WHERE `entranceID` = '%d'", EntranceData[entranceid][entranceID]);
        mysql_tquery(g_SQL, string);

        if (IsValidDynamic3DTextLabel(EntranceData[entranceid][entranceText3D]))
            DestroyDynamic3DTextLabel(EntranceData[entranceid][entranceText3D]);

        if (IsValidDynamicPickup(EntranceData[entranceid][entrancePickup]))
            DestroyDynamicPickup(EntranceData[entranceid][entrancePickup]);

        if (IsValidDynamicMapIcon(EntranceData[entranceid][entranceMapIcon]))
            DestroyDynamicMapIcon(EntranceData[entranceid][entranceMapIcon]);


        EntranceData[entranceid][entranceExists] = false;
        EntranceData[entranceid][entranceID] = 0;
    }
    return 1;
}
stock IsVehicleBike(vehicleid)
{
	new Bike[] = { 509, 481, 510, 462, 448,522, 581, 521, 523, 463, 586, 468, 471 };

	for (new i = 0; i < sizeof(Bike); i++)
    {
        if (GetVehicleModel(vehicleid) == Bike[i]) return 1;
    }
	return 0;
}

stock IsWindowedVehicle(vehicleid)
{
	static const g_aWindowStatus[] = {
	    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	    1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1,
	    1, 0, 1, 1, 1, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 1, 0, 1, 1,
	    1, 0, 0, 0, 0, 0, 1, 1, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1,
	    1, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1,
	    1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	    1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 1, 0, 1, 1, 0, 0, 0, 0,
	    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	    1, 1, 1, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 1, 1, 1,
		1, 0, 1, 1, 0, 1, 0, 1, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 1, 1,
		1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 0, 0
	};
	new modelid = GetVehicleModel(vehicleid);

    if (modelid < 400 || modelid > 611)
        return 0;

    return (g_aWindowStatus[modelid - 400]);
}
stock ParkedilenAracSayisi(id)
{
	new sayi = 0;
	for (new i; i<MAX_ARAC; i++) if (AracInfo[i][aracExists] && AracInfo[i][aracGaraj] == id)
	{
	    sayi++;
	}
	return sayi;
}
stock AracModifiyeler(playerid, id)
{
	new str[600], sayi;
	strcat(str, "{FF0000}Paintjob Sil\n");
	for (new i; i<14; i++) if (AracInfo[id][aracMods][i] > 0)
	{
	    ModifiyeListeleme[playerid][sayi] = i;
	    sayi++;
	    format(str, sizeof(str), "%s(ID: %d) %s\n", str, AracInfo[id][aracMods][i], GetComponentName(AracInfo[id][aracMods][i]));
	}
	Dialog_Show(playerid, AracModifiyeler, DIALOG_STYLE_LIST, "{C9A527}Araç Modifiyeleri", str, "Kaldýr", "Kapat");
	return 1;
}
stock GetSQLPhoneNumber(sqlid)
{
	if (sqlid == -1) return 0;
	new id = GetPlayerIDWithSQLID(sqlid);
	if (OyundaDegil(id))
	{
	    if (PlayerData[id][pTelefon] == -1) return 0;
	    else return PlayerData[id][pTelefon];
	}
	else
	{
	    new query[120];
	    format(query, sizeof(query), "SELECT `Telefon` FROM `oyuncular` WHERE `ID` = '%d'", sqlid);
	    new Cache:Radless = mysql_query(g_SQL, query);
	    new rows;
	    cache_get_row_count(rows);
	    if (rows)
	    {
			new numara;
			cache_get_value_name_int(0, "Telefon", numara);
			cache_delete(Radless);
			if (numara == -1) return 0;
			else return numara;
	    }
	    cache_delete(Radless);
	}
	return 0;
}
stock Birlik_Sil(factionid)
{
	if (factionid != -1 && Birlikler[factionid][birlikExists])
	{
	    new
	        string[150];

		format(string, sizeof(string), "DELETE FROM `birlikler` WHERE `bid` = '%d'",Birlikler[factionid][birlikID]);
		mysql_query(g_SQL, string, false);

		format(string, sizeof(string), "UPDATE `oyuncular` SET `Birlik` = '-1',`BirlikRutbe` = '0',`BirlikDivizyon` = '0' WHERE `Birlik` = '%d'", factionid);
		mysql_query(g_SQL, string, false);

  foreach (new i : Player)
		{
			if (PlayerData[i][pFaction] == factionid) {
		    	PlayerData[i][pFaction] = -1;
		    	PlayerData[i][pFactionRutbe] = 0;
		    	PlayerData[i][pFactionDivizyon] = 0;
			}
		}
        if (IsValidDynamicPickup(Birlikler[factionid][reklamPickup])) DestroyDynamicPickup(Birlikler[factionid][reklamPickup]);
        if (IsValidDynamic3DTextLabel(Birlikler[factionid][reklamLabel])) DestroyDynamic3DTextLabel(Birlikler[factionid][reklamLabel]);
	    Birlikler[factionid][birlikExists] = false;
	    Birlikler[factionid][birlikTip] = 0;
	    Birlikler[factionid][birlikID] = 0;
	    Iter_Clear(CekilisKatilimcilar[factionid]);
	}
	return 1;
}
stock IsPlayerNearHood(playerid, vehicleid)
{
	static
		Float:fX,
		Float:fY,
		Float:fZ;

	GetVehicleHood(vehicleid, fX, fY, fZ);

	return (GetPlayerVirtualWorld(playerid) == GetVehicleVirtualWorld(vehicleid)) && IsPlayerInRangeOfPoint(playerid, 4.0, fX, fY, fZ);
}
stock GetHoodStatus(vehicleid)
{
	static
	    engine,
	    lights,
	    alarm,
	    doors,
	    bonnet,
	    boot,
	    objective;

	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

	if (bonnet != 1)
		return 0;

	return 1;
}
stock IsVehicleImpounded(vehicleid)
{
	new id = Car_GetID(vehicleid);
 	if (id != -1 && AracInfo[id][aracBaglandi] != 0 && AracInfo[id][aracBaglandi] > 0)
	    return 1;

	return 0;
}
stock GetVehicleHood(vehicleid, &Float:x, &Float:y, &Float:z)
{
    if (!GetVehicleModel(vehicleid) || vehicleid == INVALID_VEHICLE_ID)
	    return (x = 0.0, y = 0.0, z = 0.0), 0;

	static
	    Float:pos[7]
	;
	GetVehicleModelInfo(GetVehicleModel(vehicleid), VEHICLE_MODEL_INFO_SIZE, pos[0], pos[1], pos[2]);
	GetVehiclePos(vehicleid, pos[3], pos[4], pos[5]);
	GetVehicleZAngle(vehicleid, pos[6]);

	x = pos[3] + (floatsqroot(pos[1] + pos[1]) * floatsin(-pos[6], degrees));
	y = pos[4] + (floatsqroot(pos[1] + pos[1]) * floatcos(-pos[6], degrees));
 	z = pos[5];

	return 1;
}
stock SetHoodStatus(vehicleid, status)
{
	static
	    engine,
	    lights,
	    alarm,
	    doors,
	    bonnet,
	    boot,
	    objective;

	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
	return SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, status, boot, objective);
}
stock GetLightStatus(vehicleid)
{
	static
	    engine,
	    lights,
	    alarm,
	    doors,
	    bonnet,
	    boot,
	    objective;

	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

	if (lights != 1)
		return 0;

	return 1;
}
stock SetLightStatus(vehicleid, status)
{
	static
	    engine,
	    lights,
	    alarm,
	    doors,
	    bonnet,
	    boot,
	    objective;

	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
	return SetVehicleParamsEx(vehicleid, engine, status, alarm, doors, bonnet, boot, objective);
}
stock GetFactionType(playerid)
{
	if (PlayerData[playerid][pFaction] == -1)
	    return 0;

	return (Birlikler[PlayerData[playerid][pFaction]][birlikTip]);
}
Car_IsOwner(playerid, carid)
{
	if (!OyundaDegil(playerid))
	    return 0;

    if ((AracInfo[carid][aracExists] && AracInfo[carid][aracSahip] > 0) && AracInfo[carid][aracSahip] == PlayerData[playerid][pID])
		return 1;

	return 0;
}
Car_Birlik(playerid, carid)
{
    if (PlayerData[playerid][pFaction] == -1 || carid == -1) return 0;
    if (AracInfo[carid][aracFaction] == Birlikler[PlayerData[playerid][pFaction]][birlikID] && AracInfo[carid][aracFactionType] != BIRLIK_LSPD && AracInfo[carid][aracFactionType] != BIRLIK_LSMD && AracInfo[carid][aracFactionType] != BIRLIK_FBI)
		return 1;

	return 0;
}
stock IsDoorVehicle(vehicleid)
{
	switch (GetVehicleModel(vehicleid)) {
		case 400..424, 426..429, 431..440, 442..445, 451, 455, 456, 458, 459, 466, 467, 470, 474, 475:
		    return 1;

		case 477..480, 482, 483, 486, 489, 490..492, 494..496, 498..500, 502..508, 514..518, 524..529, 533..536:
		    return 1;

		case 540..547, 549..552, 554..562, 565..568, 573, 575, 576, 578..580, 582, 585, 587..589, 596..605, 609:
			return 1;
	}
	return 0;
}

Car_Nearest(playerid)
{
	static
	    Float:fX,
	    Float:fY,
	    Float:fZ;

	for (new i = 0; i != MAX_ARAC; i ++)
	{
		if (AracInfo[i][aracExists])
		{
			GetVehiclePos(AracInfo[i][aracVehicle], fX, fY, fZ);
			if (IsPlayerInRangeOfPoint(playerid, 4.0, fX, fY, fZ))
			{
			    return AracInfo[i][aracID];
			}
		}
	}
	return -1;
}

stock GetNearestVehicle(playerid)
{
	static
	    Float:fX,
	    Float:fY,
	    Float:fZ;

	for (new i = 1; i != MAX_VEHICLES; i ++) if (IsValidVehicle(i) && GetVehiclePos(i, fX, fY, fZ))
	{
	    if (IsPlayerInRangeOfPoint(playerid, 3.5, fX, fY, fZ)) return i;
	}
	return INVALID_VEHICLE_ID;
}
stock IsVehicleTowing(vehicleid)
{
	foreach (new i:Player)
	{
	    if (AracCekiyor[i] == vehicleid) return 1;
	}
	return 0;
}
stock GetLocation(Float:fX, Float:fY, Float:fZ)
{
	new
	    name[32] = "San Andreas";

	for (new i = 0; i != sizeof(g_arrZoneData); i ++) if ((fX >= g_arrZoneData[i][e_ZoneArea][0] && fX <= g_arrZoneData[i][e_ZoneArea][3]) && (fY >= g_arrZoneData[i][e_ZoneArea][1] && fY <= g_arrZoneData[i][e_ZoneArea][4]) && (fZ >= g_arrZoneData[i][e_ZoneArea][2] && fZ <= g_arrZoneData[i][e_ZoneArea][5])) {
    strunpack(name, g_arrZoneData[i][e_ZoneName]);

		break;
	}
	return name;
}
stock GetCityName(Float:fX, Float:fY, Float:fZ)
{
	new
	    name[32] = "San Andreas";

	for (new i = 356; i < sizeof(g_arrZoneData); i ++) if ((fX >= g_arrZoneData[i][e_ZoneArea][0] && fX <= g_arrZoneData[i][e_ZoneArea][3]) && (fY >= g_arrZoneData[i][e_ZoneArea][1] && fY <= g_arrZoneData[i][e_ZoneArea][4]) && (fZ >= g_arrZoneData[i][e_ZoneArea][2] && fZ <= g_arrZoneData[i][e_ZoneArea][5])) {
    strunpack(name, g_arrZoneData[i][e_ZoneName]);

		break;
	}
	return name;
}
stock Isyeri_Sil(bizid)
{
	if (bizid != -1 && Isyeri[bizid][isyeriExists])
	{
	    new
	        string[82];

		format(string, sizeof(string), "DELETE FROM `isyerleri` WHERE `ID` = '%d'", Isyeri[bizid][isyeriID]);
		mysql_query(g_SQL, string, false);

        if (IsValidDynamic3DTextLabel(Isyeri[bizid][bizText3D]))
		    DestroyDynamic3DTextLabel(Isyeri[bizid][bizText3D]);

		if (IsValidDynamicPickup(Isyeri[bizid][isyeriPickup]))
		    DestroyDynamicPickup(Isyeri[bizid][isyeriPickup]);

		Isyeri_AraclariSil(bizid);

	    Isyeri[bizid][isyeriExists] = false;
	    Isyeri[bizid][isyeriSahip] = -1;
	    Isyeri[bizid][isyeriID] = 0;
	}
	return 1;
}
stock Isyeri_AraclariSil(bizid)
{
	if (Isyeri[bizid][isyeriExists] && Isyeri[bizid][isyeriTip] == 4)
	{
	    static
	        string[50];

		for (new i = 0; i != MAX_DEALERSHIP_CARS; i ++)
		{
  			DealershipCars[bizid][i][vehModel] = 0;
    		DealershipCars[bizid][i][vehPrice] = 0;
		}
		format(string, sizeof(string), "DELETE FROM `galeriaraclar` WHERE `ID` = '%d'", Isyeri[bizid][isyeriID]);
		mysql_query(g_SQL, string, false);
	}
	return 1;
}
Isyeri_AracDuzenle(playerid, bizid)
{
	new string[2056];
	string[0] = 0;
    for (new i = 0; i != MAX_DEALERSHIP_CARS; i ++)
	{
		if (DealershipCars[bizid][i][vehModel]) {
			format(string, sizeof(string), "%s%d\t~g~%s\n", string, DealershipCars[bizid][i][vehModel], FormatNumber(DealershipCars[bizid][i][vehPrice]));
		}
	}
    ShowPlayerDialog(playerid, 58, DIALOG_STYLE_PREVMODEL, "Arac Sec", string, "Sec", "Iptal");
	return 1;
}

Isyeri_AracEkle(bizid, modelid, price)
{
	new query[256];

	for (new i = 0; i != MAX_DEALERSHIP_CARS; i ++) if (!DealershipCars[bizid][i][vehModel])
	{
	    DealershipCars[bizid][i][vehID] = i;
	    DealershipCars[bizid][i][vehModel] = modelid;
	    DealershipCars[bizid][i][vehPrice] = price;

	    mysql_format(g_SQL, query, sizeof query, "INSERT INTO `galeriaraclar` (`ID`, `vehID`, `vehModel`, `vehPrice`) VALUES ('%d', '%d', '%d', '%d')", Isyeri[bizid][isyeriID], DealershipCars[bizid][i][vehID], DealershipCars[bizid][i][vehModel], DealershipCars[bizid][i][vehPrice]);
	    mysql_query (g_SQL, query);

	    return DealershipCars[bizid][i][vehID];
	}
	return 0;
}
stock Isyeri_UrunFiyatDegistir(playerid,id)
{
	if (id == -1 || !Isyeri[id][isyeriExists]) return 0;

	new str[1000],string[550];
	strcat(str, "Ürün\tKalan\tFiyat\n");
	switch (Isyeri[id][isyeriTip])
	{
	    case 1:
	    {
	        format(string,sizeof(string), "Zar\t%d adet\t{2ECC71}%s\n",Isyeri[id][isyeriUrunSayisi][0],FormatNumber(Isyeri[id][isyeriFiyatlar][0]));
	        strcat(str,string);
	        format(string,sizeof(string), "Sigara\t%d adet\t{2ECC71}%s\n",Isyeri[id][isyeriUrunSayisi][1],FormatNumber(Isyeri[id][isyeriFiyatlar][1]));
	        strcat(str,string);
	        format(string,sizeof(string), "Ip\t%d adet\t{2ECC71}%s\n",Isyeri[id][isyeriUrunSayisi][2],FormatNumber(Isyeri[id][isyeriFiyatlar][2]));
	        strcat(str,string);
	        format(string,sizeof(string), "Göz Baðý\t%d adet\t{2ECC71}%s\n",Isyeri[id][isyeriUrunSayisi][3],FormatNumber(Isyeri[id][isyeriFiyatlar][3]));
	        strcat(str,string);
         format(string,sizeof(string), "Sprey\t%d adet\t{2ECC71}%s\n",Isyeri[id][isyeriUrunSayisi][4],FormatNumber(Isyeri[id][isyeriFiyatlar][4]));
	        strcat(str,string);
	        format(string,sizeof(string), "Gazoz\t%d adet\t{2ECC71}%s\n",Isyeri[id][isyeriUrunSayisi][5],FormatNumber(Isyeri[id][isyeriFiyatlar][5]));
	        strcat(str,string);
	        format(string,sizeof(string), "Beyzbol Sopasý\t%d adet\t{2ECC71}%s\n",Isyeri[id][isyeriUrunSayisi][6],FormatNumber(Isyeri[id][isyeriFiyatlar][6]));
	        strcat(str,string);
	        format(string,sizeof(string), "Maske\t%d adet\t{2ECC71}%s\n",Isyeri[id][isyeriUrunSayisi][7],FormatNumber(Isyeri[id][isyeriFiyatlar][7]));
	        strcat(str,string);
	        format(string,sizeof(string), "Benzin Kutusu\t%d adet\t{2ECC71}%s\n",Isyeri[id][isyeriUrunSayisi][8],FormatNumber(Isyeri[id][isyeriFiyatlar][8]));
	        strcat(str,string);
	        format(string,sizeof(string), "Barbekü\t%d adet\t{2ECC71}%s\n",Isyeri[id][isyeriUrunSayisi][9],FormatNumber(Isyeri[id][isyeriFiyatlar][9]));
	        strcat(str,string);
	        format(string,sizeof(string), "Köfte\t%d adet\t{2ECC71}%s\n",Isyeri[id][isyeriUrunSayisi][10],FormatNumber(Isyeri[id][isyeriFiyatlar][10]));
	        strcat(str,string);
	        format(string,sizeof(string), "Tavuk Eti\t%d adet\t{2ECC71}%s\n",Isyeri[id][isyeriUrunSayisi][11],FormatNumber(Isyeri[id][isyeriFiyatlar][11]));
	        strcat(str,string);
	        format(string,sizeof(string), "Dana Eti\t%d adet\t{2ECC71}%s\n",Isyeri[id][isyeriUrunSayisi][12],FormatNumber(Isyeri[id][isyeriFiyatlar][12]));
	        strcat(str,string);
	        format(string,sizeof(string), "Tamir kiti\t%d adet\t{2ECC71}%s\n",Isyeri[id][isyeriUrunSayisi][13],FormatNumber(Isyeri[id][isyeriFiyatlar][13]));
	        strcat(str,string);
	        format(string,sizeof(string), "Portatif Çadýr\t%d adet\t{2ECC71}%s\n",Isyeri[id][isyeriUrunSayisi][14],FormatNumber(Isyeri[id][isyeriFiyatlar][14]));
	        strcat(str,string);
	        format(string,sizeof(string), "Kamp Ateþi\t%d adet\t{2ECC71}%s\n",Isyeri[id][isyeriUrunSayisi][15],FormatNumber(Isyeri[id][isyeriFiyatlar][15]));
	        strcat(str,string);
	        /*format(string,sizeof(string), "Yan Keski\t%d adet\t{2ECC71}%s\n",Isyeri[id][isyeriUrunSayisi][16],FormatNumber(Isyeri[id][isyeriFiyatlar][16]));
	        strcat(str,string);*/
	    }
	    case 2:
	    {
	        format(string,sizeof(string), "Normal Kiyafetler\t%d adet\t{2ECC71}%s\n",Isyeri[id][isyeriUrunSayisi][0],FormatNumber(Isyeri[id][isyeriFiyatlar][0]));
	        strcat(str,string);
	        format(string,sizeof(string), "Özel Kiyafetler\t%d adet\t{2ECC71}%s\n",Isyeri[id][isyeriUrunSayisi][1],FormatNumber(Isyeri[id][isyeriFiyatlar][1]));
	        strcat(str,string);
	        format(string,sizeof(string), "Aksesuarlar\t%d adet\t{2ECC71}%s\n",Isyeri[id][isyeriUrunSayisi][2],FormatNumber(Isyeri[id][isyeriFiyatlar][2]));
	        strcat(str,string);
	    }
	    case 3:
	    {
	        format(string,sizeof(string), "Su\t%d adet\t{2ECC71}%s\n",Isyeri[id][isyeriUrunSayisi][0],FormatNumber(Isyeri[id][isyeriFiyatlar][0]));
	        strcat(str,string);
	        format(string,sizeof(string), "Kola\t%d adet\t{2ECC71}%s\n",Isyeri[id][isyeriUrunSayisi][1],FormatNumber(Isyeri[id][isyeriFiyatlar][1]));
	        strcat(str,string);
	        format(string,sizeof(string), "Salata\t%d adet\t{2ECC71}%s\n",Isyeri[id][isyeriUrunSayisi][2],FormatNumber(Isyeri[id][isyeriFiyatlar][2]));
	        strcat(str,string);
	        format(string,sizeof(string), "Tavuk\t%d adet\t{2ECC71}%s\n",Isyeri[id][isyeriUrunSayisi][3],FormatNumber(Isyeri[id][isyeriFiyatlar][3]));
	        strcat(str,string);
	        format(string,sizeof(string), "Patates Kýzartmasý\t%d adet\t{2ECC71}%s\n",Isyeri[id][isyeriUrunSayisi][4],FormatNumber(Isyeri[id][isyeriFiyatlar][4]));
	        strcat(str,string);
	        format(string,sizeof(string), "Hamburger\t%d adet\t{2ECC71}%s\n",Isyeri[id][isyeriUrunSayisi][5],FormatNumber(Isyeri[id][isyeriFiyatlar][5]));
	        strcat(str,string);
	    }
	    case 5:
	    {
	        format(string,sizeof(string), "Telefon\t%d adet\t{2ECC71}%s\n",Isyeri[id][isyeriUrunSayisi][0],FormatNumber(Isyeri[id][isyeriFiyatlar][0]));
	        strcat(str,string);
	        format(string,sizeof(string), "Portatif Radyo\t%d adet\t{2ECC71}%s\n",Isyeri[id][isyeriUrunSayisi][1],FormatNumber(Isyeri[id][isyeriFiyatlar][1]));
	        strcat(str,string);
	        format(string,sizeof(string), "Boombox\t%d adet\t{2ECC71}%s\n",Isyeri[id][isyeriUrunSayisi][2],FormatNumber(Isyeri[id][isyeriFiyatlar][2]));
	        strcat(str,string);
	        format(string,sizeof(string), "Kamera\t%d adet\t{2ECC71}%s\n",Isyeri[id][isyeriUrunSayisi][3],FormatNumber(Isyeri[id][isyeriFiyatlar][3]));
	        strcat(str,string);
	    }
	    case 6:
	    {
	        format(string,sizeof(string), "Bira\t%d adet\t{2ECC71}%s\n",Isyeri[id][isyeriUrunSayisi][0],FormatNumber(Isyeri[id][isyeriFiyatlar][0]));
	        strcat(str,string);
	        format(string,sizeof(string), "Viski\t%d adet\t{2ECC71}%s\n",Isyeri[id][isyeriUrunSayisi][1],FormatNumber(Isyeri[id][isyeriFiyatlar][1]));
	        strcat(str,string);
	        format(string,sizeof(string), "Tekila\t%d adet\t{2ECC71}%s\n",Isyeri[id][isyeriUrunSayisi][2],FormatNumber(Isyeri[id][isyeriFiyatlar][2]));
	        strcat(str,string);
	        format(string,sizeof(string), "Þarap\t%d adet\t{2ECC71}%s\n",Isyeri[id][isyeriUrunSayisi][3],FormatNumber(Isyeri[id][isyeriFiyatlar][3]));
	        strcat(str,string);
	        format(string,sizeof(string), "Votka\t%d adet\t{2ECC71}%s\n",Isyeri[id][isyeriUrunSayisi][4],FormatNumber(Isyeri[id][isyeriFiyatlar][4]));
	        strcat(str,string);
	        format(string,sizeof(string), "Þampanya\t%d adet\t{2ECC71}%s\n",Isyeri[id][isyeriUrunSayisi][5],FormatNumber(Isyeri[id][isyeriFiyatlar][5]));
	        strcat(str,string);
	    }
	}
	Dialog_Show(playerid,UrunFiyat,DIALOG_STYLE_TABLIST_HEADERS, "{2ECC71}Ýþyeri - Ürün Fiyat Deðiþtir",str, "Seç", "Geri");
	return 1;
}

stock Isyeri_UrunAl(playerid,id)
{
	if (id == -1 || !Isyeri[id][isyeriExists]) return 0;

	new str[1000],string[550];
	strcat(str, "Ürün\tKalan\tFiyat\n");
	switch (Isyeri[id][isyeriTip])
	{
	    case 1:
	    {
	        format(string,sizeof(string), "Zar\t%d adet\t{2ECC71}%s\n",Isyeri[id][isyeriUrunSayisi][0],FormatNumber(Isyeri[id][isyeriFiyatlar][0]));
	        strcat(str,string);
	        format(string,sizeof(string), "Sigara\t%d adet\t{2ECC71}%s\n",Isyeri[id][isyeriUrunSayisi][1],FormatNumber(Isyeri[id][isyeriFiyatlar][1]));
	        strcat(str,string);
	        format(string,sizeof(string), "Ip\t%d adet\t{2ECC71}%s\n",Isyeri[id][isyeriUrunSayisi][2],FormatNumber(Isyeri[id][isyeriFiyatlar][2]));
	        strcat(str,string);
	        format(string,sizeof(string), "Göz Baðý\t%d adet\t{2ECC71}%s\n",Isyeri[id][isyeriUrunSayisi][3],FormatNumber(Isyeri[id][isyeriFiyatlar][3]));
	        strcat(str,string);
	        format(string,sizeof(string), "Gazoz\t%d adet\t{2ECC71}%s\n",Isyeri[id][isyeriUrunSayisi][5],FormatNumber(Isyeri[id][isyeriFiyatlar][5]));
	        strcat(str,string);
	        format(string,sizeof(string), "Beyzbol Sopasý\t%d adet\t{2ECC71}%s\n",Isyeri[id][isyeriUrunSayisi][6],FormatNumber(Isyeri[id][isyeriFiyatlar][6]));
	        strcat(str,string);
	        format(string,sizeof(string), "Maske\t%d adet\t{2ECC71}%s\n",Isyeri[id][isyeriUrunSayisi][7],FormatNumber(Isyeri[id][isyeriFiyatlar][7]));
	        strcat(str,string);
	        format(string,sizeof(string), "Benzin Kutusu\t%d adet\t{2ECC71}%s\n",Isyeri[id][isyeriUrunSayisi][8],FormatNumber(Isyeri[id][isyeriFiyatlar][8]));
	        strcat(str,string);
	        format(string,sizeof(string), "Barbekü\t%d adet\t{2ECC71}%s\n",Isyeri[id][isyeriUrunSayisi][9],FormatNumber(Isyeri[id][isyeriFiyatlar][9]));
	        strcat(str,string);
	        format(string,sizeof(string), "Köfte\t%d adet\t{2ECC71}%s\n",Isyeri[id][isyeriUrunSayisi][10],FormatNumber(Isyeri[id][isyeriFiyatlar][10]));
	        strcat(str,string);
	        format(string,sizeof(string), "Tavuk Eti\t%d adet\t{2ECC71}%s\n",Isyeri[id][isyeriUrunSayisi][11],FormatNumber(Isyeri[id][isyeriFiyatlar][11]));
	        strcat(str,string);
	        format(string,sizeof(string), "Dana Eti\t%d adet\t{2ECC71}%s\n",Isyeri[id][isyeriUrunSayisi][12],FormatNumber(Isyeri[id][isyeriFiyatlar][12]));
	        strcat(str,string);
	        format(string,sizeof(string), "Tamir kiti\t%d adet\t{2ECC71}%s\n",Isyeri[id][isyeriUrunSayisi][13],FormatNumber(Isyeri[id][isyeriFiyatlar][13]));
	        strcat(str,string);
	        format(string,sizeof(string), "Portatif Çadýr\t%d adet\t{2ECC71}%s\n",Isyeri[id][isyeriUrunSayisi][14],FormatNumber(Isyeri[id][isyeriFiyatlar][14]));
	        strcat(str,string);
	        format(string,sizeof(string), "Kamp Ateþi\t%d adet\t{2ECC71}%s\n",Isyeri[id][isyeriUrunSayisi][15],FormatNumber(Isyeri[id][isyeriFiyatlar][15]));
	        strcat(str,string);
	        /*format(string,sizeof(string), "Yan Keski\t%d adet\t{2ECC71}%s\n",Isyeri[id][isyeriUrunSayisi][15],FormatNumber(Isyeri[id][isyeriFiyatlar][15]));
	        strcat(str,string);*/
	    }
	    case 2:
	    {
	        format(string,sizeof(string), "Normal Kiyafetler\t%d adet\t{2ECC71}%s\n",Isyeri[id][isyeriUrunSayisi][0],FormatNumber(Isyeri[id][isyeriFiyatlar][0]));
	        strcat(str,string);
	        format(string,sizeof(string), "Özel Kiyafetler\t%d adet\t{2ECC71}%s\n",Isyeri[id][isyeriUrunSayisi][1],FormatNumber(Isyeri[id][isyeriFiyatlar][1]));
	        strcat(str,string);
	        format(string,sizeof(string), "Aksesuarlar\t%d adet\t{2ECC71}%s\n",Isyeri[id][isyeriUrunSayisi][2],FormatNumber(Isyeri[id][isyeriFiyatlar][2]));
	        strcat(str,string);
	    }
	    case 3:
	    {
	        format(string,sizeof(string), "Su\t%d adet\t{2ECC71}%s\n",Isyeri[id][isyeriUrunSayisi][0],FormatNumber(Isyeri[id][isyeriFiyatlar][0]));
	        strcat(str,string);
	        format(string,sizeof(string), "Kola\t%d adet\t{2ECC71}%s\n",Isyeri[id][isyeriUrunSayisi][1],FormatNumber(Isyeri[id][isyeriFiyatlar][1]));
	        strcat(str,string);
	        format(string,sizeof(string), "Salata\t%d adet\t{2ECC71}%s\n",Isyeri[id][isyeriUrunSayisi][2],FormatNumber(Isyeri[id][isyeriFiyatlar][2]));
	        strcat(str,string);
	        format(string,sizeof(string), "Tavuk\t%d adet\t{2ECC71}%s\n",Isyeri[id][isyeriUrunSayisi][3],FormatNumber(Isyeri[id][isyeriFiyatlar][3]));
	        strcat(str,string);
	        format(string,sizeof(string), "Patates Kýzartmasý\t%d adet\t{2ECC71}%s\n",Isyeri[id][isyeriUrunSayisi][4],FormatNumber(Isyeri[id][isyeriFiyatlar][4]));
	        strcat(str,string);
	        format(string,sizeof(string), "Hamburger\t%d adet\t{2ECC71}%s\n",Isyeri[id][isyeriUrunSayisi][5],FormatNumber(Isyeri[id][isyeriFiyatlar][5]));
	        strcat(str,string);
	    }
	    case 5:
	    {
	        format(string,sizeof(string), "Telefon\t%d adet\t{2ECC71}%s\n",Isyeri[id][isyeriUrunSayisi][0],FormatNumber(Isyeri[id][isyeriFiyatlar][0]));
	        strcat(str,string);
	        format(string,sizeof(string), "Portatif Radyo\t%d adet\t{2ECC71}%s\n",Isyeri[id][isyeriUrunSayisi][1],FormatNumber(Isyeri[id][isyeriFiyatlar][1]));
	        strcat(str,string);
	        format(string,sizeof(string), "Boombox\t%d adet\t{2ECC71}%s\n",Isyeri[id][isyeriUrunSayisi][2],FormatNumber(Isyeri[id][isyeriFiyatlar][2]));
	        strcat(str,string);
	        format(string,sizeof(string), "Kamera\t%d adet\t{2ECC71}%s\n",Isyeri[id][isyeriUrunSayisi][3],FormatNumber(Isyeri[id][isyeriFiyatlar][3]));
	        strcat(str,string);
	    }
	    case 6:
	    {
	        format(string,sizeof(string), "Bira\t%d adet\t{2ECC71}%s\n",Isyeri[id][isyeriUrunSayisi][0],FormatNumber(Isyeri[id][isyeriFiyatlar][0]));
	        strcat(str,string);
	        format(string,sizeof(string), "Viski\t%d adet\t{2ECC71}%s\n",Isyeri[id][isyeriUrunSayisi][1],FormatNumber(Isyeri[id][isyeriFiyatlar][1]));
	        strcat(str,string);
	        format(string,sizeof(string), "Tekila\t%d adet\t{2ECC71}%s\n",Isyeri[id][isyeriUrunSayisi][2],FormatNumber(Isyeri[id][isyeriFiyatlar][2]));
	        strcat(str,string);
	        format(string,sizeof(string), "Þarap\t%d adet\t{2ECC71}%s\n",Isyeri[id][isyeriUrunSayisi][3],FormatNumber(Isyeri[id][isyeriFiyatlar][3]));
	        strcat(str,string);
	        format(string,sizeof(string), "Votka\t%d adet\t{2ECC71}%s\n",Isyeri[id][isyeriUrunSayisi][4],FormatNumber(Isyeri[id][isyeriFiyatlar][4]));
	        strcat(str,string);
	        format(string,sizeof(string), "Þampanya\t%d adet\t{2ECC71}%s\n",Isyeri[id][isyeriUrunSayisi][5],FormatNumber(Isyeri[id][isyeriFiyatlar][5]));
	        strcat(str,string);
	    }
	}
	Dialog_Show(playerid,UrunlerDialog,DIALOG_STYLE_TABLIST_HEADERS, "{2ECC71}Ýþyeri - Ürün Al",str, "Seç", "Geri");
	return 1;
}
stock GetUrunFiyat(id,urunid)
{
	return Isyeri[id][isyeriFiyatlar][urunid]/2;
}
Business_Inside(playerid, bool:option = false)
{
	if (PlayerData[playerid][pIsyeri] != -1)
	{
	    for (new i = 0; i != MAX_ISYERI; i ++)
	    {
			if (Isyeri[i][isyeriExists] && Isyeri[i][isyeriID] == PlayerData[playerid][pIsyeri] && GetPlayerInterior(playerid) == Isyeri[i][isyeriInterior] && GetPlayerVirtualWorld(playerid) > 0)
			{
			    if(!option)
			        return i;

				if(option)
				{
				    if(IsPlayerInRangeOfPoint(playerid, 2.5, Isyeri[i][isyeriInt][0], Isyeri[i][isyeriInt][1], Isyeri[i][isyeriInt][2]))
	  					return i;
				}
			}
		}
	}
	return -1;
}

stock Isyeri_Olustur(playerid,tip,fiyat)
{
    	static
	    Float:x,
	    Float:y,
	    Float:z,
		Float:angle;

	if (GetPlayerPos(playerid, x, y, z) && GetPlayerFacingAngle(playerid, angle))
	{
	    for (new i = 0; i != MAX_ISYERI; i ++)
	    {
			if (!Isyeri[i][isyeriExists])
			{
			    Isyeri[i][isyeriExists] = true;
			    Isyeri[i][isyeriID] = i;

			    Isyeri[i][isyeriSahip] = -1;
			    Isyeri[i][isyeriFiyat] = fiyat;
			    Isyeri[i][isyeriKendiFiyati] = fiyat;
			    Isyeri[i][isyeriTip] = tip;
			    Isyeri[i][isyeriGirisUcret] = 0;
			    format(Isyeri[i][isyeriName],32, "Adsýz Ýþyeri");
		     	format(Isyeri[i][isyeriMuzik],256, "");
		     	Isyeri[i][isyeriPos][0] = x;
		     	Isyeri[i][isyeriPos][1] = y;
		     	Isyeri[i][isyeriPos][2] = z;
		     	Isyeri[i][isyeriPos][3] = angle;
		     	Isyeri[i][isyeriSpawn][0] = x;
		     	Isyeri[i][isyeriSpawn][1] = y;
		     	Isyeri[i][isyeriSpawn][2] = z;
		     	Isyeri[i][isyeriSpawn][3] = angle;
		     	Isyeri[i][isyeriSatilik] = 0;
		     	Isyeri[i][isyeriVergiSure] = 0;

		     	switch (tip)
		     	{
		     		case 1: // Market
		     		{
		     		    Isyeri[i][isyeriInt][0] = -27.3074;
	                	Isyeri[i][isyeriInt][1] = -30.8741;
	                	Isyeri[i][isyeriInt][2] = 1003.5573;
	                	Isyeri[i][isyeriInt][3] = 0.0000;
						Isyeri[i][isyeriInterior] = 4;

						Isyeri[i][isyeriFiyatlar][0] = 5; // Zar
						Isyeri[i][isyeriFiyatlar][1] = 10; // Sigara
						Isyeri[i][isyeriFiyatlar][2] = 50; // Ip
						Isyeri[i][isyeriFiyatlar][3] = 50; // Goz bagi
						Isyeri[i][isyeriFiyatlar][4] = 60; // Sprey
						Isyeri[i][isyeriFiyatlar][5] = 5; // Gazoz
						Isyeri[i][isyeriFiyatlar][6] = 500; // Beyzbol Sopasi
						Isyeri[i][isyeriFiyatlar][7] = 500; // Maske
						Isyeri[i][isyeriFiyatlar][8] = 200; // Benzin Kutusu
						Isyeri[i][isyeriFiyatlar][9] = 1000; // Barbeku
						Isyeri[i][isyeriFiyatlar][10] = 20; // Köfte
						Isyeri[i][isyeriFiyatlar][11] = 25; // Tavuk Eti
						Isyeri[i][isyeriFiyatlar][12] = 30; // Dana Eti
						Isyeri[i][isyeriFiyatlar][13] = 200; // Tamir kiti
						Isyeri[i][isyeriFiyatlar][14] = 2000; // Çadýr
						Isyeri[i][isyeriFiyatlar][15] = 500; // Kamp atesi
						//Isyeri[i][isyeriFiyatlar][16] = 1000; // Yan keski

						Isyeri[i][isyeriUrunSayisi][0] = 5;
						Isyeri[i][isyeriUrunSayisi][1] = 5;
						Isyeri[i][isyeriUrunSayisi][2] = 5;
						Isyeri[i][isyeriUrunSayisi][3] = 5;
						Isyeri[i][isyeriUrunSayisi][4] = 5;
						Isyeri[i][isyeriUrunSayisi][5] = 5;
						Isyeri[i][isyeriUrunSayisi][6] = 5;
						Isyeri[i][isyeriUrunSayisi][7] = 5;
						Isyeri[i][isyeriUrunSayisi][8] = 5;
						Isyeri[i][isyeriUrunSayisi][9] = 5;
						Isyeri[i][isyeriUrunSayisi][10] = 5;
						Isyeri[i][isyeriUrunSayisi][11] = 5;
						Isyeri[i][isyeriUrunSayisi][12] = 5;
						Isyeri[i][isyeriUrunSayisi][13] = 5;
						Isyeri[i][isyeriUrunSayisi][14] = 5;
						Isyeri[i][isyeriUrunSayisi][15] = 5;
						Isyeri[i][isyeriUrunSayisi][16] = 5;
		     		}
		     		case 2: // Kiyafet Maðazasý
		     		{
		     		    Isyeri[i][isyeriInt][0] = 161.4801;
	                	Isyeri[i][isyeriInt][1] = -96.5368;
	                	Isyeri[i][isyeriInt][2] = 1001.8047;
	                	Isyeri[i][isyeriInt][3] = 0.0000;
						Isyeri[i][isyeriInterior] = 18;

						Isyeri[i][isyeriFiyatlar][0] = 100;
						Isyeri[i][isyeriFiyatlar][1] = 250;
						Isyeri[i][isyeriFiyatlar][2] = 50;

						Isyeri[i][isyeriUrunSayisi][0] = 5;
						Isyeri[i][isyeriUrunSayisi][1] = 5;
						Isyeri[i][isyeriUrunSayisi][2] = 5;
		     		}
		     		case 3: // Fast Food
		     		{
		     		    Isyeri[i][isyeriInt][0] = 363.3402; //
	                	Isyeri[i][isyeriInt][1] = -74.6679;
	                	Isyeri[i][isyeriInt][2] = 1001.5078;
	                	Isyeri[i][isyeriInt][3] = 315.0000;
						Isyeri[i][isyeriInterior] = 10;
						Isyeri[i][isyeriFiyatlar][0] = 3; // Su
						Isyeri[i][isyeriFiyatlar][1] = 8; // Kola
						Isyeri[i][isyeriFiyatlar][2] = 10; // Salata
						Isyeri[i][isyeriFiyatlar][3] = 12; // Tavuk
						Isyeri[i][isyeriFiyatlar][4] = 15; // Patates
						Isyeri[i][isyeriFiyatlar][5] = 20; // Hamburger

						Isyeri[i][isyeriUrunSayisi][0] = 5;
						Isyeri[i][isyeriUrunSayisi][1] = 5;
						Isyeri[i][isyeriUrunSayisi][2] = 5;
						Isyeri[i][isyeriUrunSayisi][3] = 5;
						Isyeri[i][isyeriUrunSayisi][4] = 5;
						Isyeri[i][isyeriUrunSayisi][5] = 5;
		     		}
		     		case 4: // Galeri
		     		{
		     		    Isyeri[i][isyeriInt][0] = 1494.5612;
		            	Isyeri[i][isyeriInt][1] = 1304.2061;
		            	Isyeri[i][isyeriInt][2] = 1093.2891;
		            	Isyeri[i][isyeriInt][3] = 0.0000;
						Isyeri[i][isyeriInterior] = 3;
		     		}
		     		case 5: // Elektronik
		     		{
		     		    Isyeri[i][isyeriInt][0] = 2310.3713;
	   					Isyeri[i][isyeriInt][1] = 997.7480;
				   		Isyeri[i][isyeriInt][2] = -53.9590;
	      				Isyeri[i][isyeriInt][3] = 271.6157;
						Isyeri[i][isyeriInterior] = 0;

						Isyeri[i][isyeriFiyatlar][0] = 500; // Telefon
						Isyeri[i][isyeriFiyatlar][1] = 200; // Portatif Radyo (TELSIZ)
						Isyeri[i][isyeriFiyatlar][2] = 1000; //  Boombox
						Isyeri[i][isyeriFiyatlar][3] = 50; // Kamera

						Isyeri[i][isyeriUrunSayisi][0] = 5;
						Isyeri[i][isyeriUrunSayisi][1] = 5;
						Isyeri[i][isyeriUrunSayisi][2] = 5;
						Isyeri[i][isyeriUrunSayisi][3] = 5;
		     		}
		     		case 6: // Bar/Pub
		     		{
		     		    Isyeri[i][isyeriInt][0] = 493.3361;
		   				Isyeri[i][isyeriInt][1] = -24.2685;
					   	Isyeri[i][isyeriInt][2] = 1000.6797;
		      			Isyeri[i][isyeriInt][3] = 3.3758;
						Isyeri[i][isyeriInterior] = 17;

						Isyeri[i][isyeriFiyatlar][0] = 10; // Bira
						Isyeri[i][isyeriFiyatlar][1] = 50; // Viski
						Isyeri[i][isyeriFiyatlar][2] = 15; // Tekila
						Isyeri[i][isyeriFiyatlar][3] = 30; // Þarap
						Isyeri[i][isyeriFiyatlar][4] = 50; // Votka
						Isyeri[i][isyeriFiyatlar][5] = 100; // Þampanya

						Isyeri[i][isyeriUrunSayisi][0] = 5;
						Isyeri[i][isyeriUrunSayisi][1] = 5;
						Isyeri[i][isyeriUrunSayisi][2] = 5;
						Isyeri[i][isyeriUrunSayisi][3] = 5;
						Isyeri[i][isyeriUrunSayisi][4] = 5;
						Isyeri[i][isyeriUrunSayisi][5] = 5;
		     		}
		     		case 7:
		     		{
			     		Isyeri[i][isyeriInt][0] = 1133.1000;
	  					Isyeri[i][isyeriInt][1] = -15.8102;
				   		Isyeri[i][isyeriInt][2] = 1000.6797;
	     				Isyeri[i][isyeriInt][3] = 3.0235;
	     				Isyeri[i][isyeriInterior] = 12;
		     		}
		 		}

		 		Isyeri[i][isyeriKilit] = 0;
   				Isyeri[i][isyeriKasa] = 0;

				new query[256];

				mysql_format(g_SQL, query, sizeof query, "INSERT INTO `isyerleri` (`ID`, `iSahip`) VALUES ('%d', '-1')", Isyeri[i][isyeriID]);
	     		mysql_query (g_SQL, query);

                Isyeri_Yenile(Isyeri[i][isyeriID]);
				Isyeri_Kaydet(Isyeri[i][isyeriID]);

				return Isyeri[i][isyeriID];
			}
	    }
	}
	return -1;
}

stock IsyerleriYukle()
{
	mysql_query(g_SQL, "SELECT * FROM `isyerleri`");

	new rows = cache_num_rows();
	printf("» Toplam %d iþ yeri yüklendi.", rows);

	if (rows)
	{
	    new isID, str[256];
		for (new i = 0; i < rows; i ++)
		{
		    cache_get_value_name_int(i, "ID", isID);

		    Isyeri[isID][isyeriExists] = true;
		    Isyeri[isID][isyeriID] = isID;

		    cache_get_value_name(i, "iIsim", Isyeri[isID][isyeriName],32);
		    cache_get_value_name(i, "iMessage", Isyeri[isID][isyeriMesaj],100);
		    cache_get_value_name_int(i, "iSahip", Isyeri[isID][isyeriSahip]);
		    cache_get_value_name_int(i, "iTip", Isyeri[isID][isyeriTip]);
		    cache_get_value_name_int(i, "iFiyat", Isyeri[isID][isyeriFiyat]);
		    cache_get_value_name_int(i, "iKendiFiyat", Isyeri[isID][isyeriKendiFiyati]);
		    cache_get_value_name_int(i, "iSatilik", Isyeri[isID][isyeriSatilik]);
		    cache_get_value_name_int(i, "iVergi", Isyeri[isID][isyeriVergi]);
		    cache_get_value_name_int(i, "iVergiSure", Isyeri[isID][isyeriVergiSure]);
		    cache_get_value_name_int(i, "iGirisUcret", Isyeri[isID][isyeriGirisUcret]);
		    cache_get_value_name(i, "iMuzik", Isyeri[isID][isyeriMuzik],256);
		    cache_get_value_name_float(i, "iPosX", Isyeri[isID][isyeriPos][0]);
		    cache_get_value_name_float(i, "iPosY", Isyeri[isID][isyeriPos][1]);
		    cache_get_value_name_float(i, "iPosZ", Isyeri[isID][isyeriPos][2]);
		    cache_get_value_name_float(i, "iPosA", Isyeri[isID][isyeriPos][3]);
		    cache_get_value_name_float(i, "iIntX", Isyeri[isID][isyeriInt][0]);
		    cache_get_value_name_float(i, "iIntY", Isyeri[isID][isyeriInt][1]);
		    cache_get_value_name_float(i, "iIntZ", Isyeri[isID][isyeriInt][2]);
		    cache_get_value_name_float(i, "iIntA", Isyeri[isID][isyeriInt][3]);
		    cache_get_value_name_float(i, "iSpawnX", Isyeri[isID][isyeriSpawn][0]);
		    cache_get_value_name_float(i, "iSpawnY", Isyeri[isID][isyeriSpawn][1]);
		    cache_get_value_name_float(i, "iSpawnZ", Isyeri[isID][isyeriSpawn][2]);
		    cache_get_value_name_float(i, "iSpawnA", Isyeri[isID][isyeriSpawn][3]);
		    cache_get_value_name_int(i, "iInterior", Isyeri[isID][isyeriInterior]);
		    cache_get_value_name_int(i, "iKilit", Isyeri[isID][isyeriKilit]);
		    cache_get_value_name_int(i, "iKasa", Isyeri[isID][isyeriKasa]);

		    for (new j = 0; j < 20; j ++)

			{
				format(str, 32, "iFiyat%d", j + 1);
				cache_get_value_name_int(i, str, Isyeri[isID][isyeriFiyatlar][j]);

				format(str,32, "iUrun%d",j+1);
				cache_get_value_name_int(i, str, Isyeri[isID][isyeriUrunSayisi][j]);
			}
		}

		for (new i; i < MAX_ISYERI; i++) if (Isyeri[i][isyeriExists])
		{
		    if (Isyeri[i][isyeriTip] == 4)
			{
				mysql_format(g_SQL, str, sizeof str, "SELECT * FROM `galeriaraclar` WHERE `ID` = '%d'", Isyeri[i][isyeriID]);
				mysql_tquery(g_SQL, str, "Business_LoadCars", "d", i);
			}
		    Isyeri_Yenile(Isyeri[i][isyeriID]);
		}
	}
}
stock Isyeri_Urun(playerid,bizid)
{
    if (bizid == -1 || !Isyeri[bizid][isyeriExists])
	    return 0;

	new str[850],string[400];
	strcat(str, "Ürün Adý\tFiyat\n");
	switch (Isyeri[bizid][isyeriTip])
	{
	    case 1:
	    {
	        format(string,sizeof(string), "Zar\t{2ECC71}%s\n",FormatNumber(Isyeri[bizid][isyeriFiyatlar][0]));
	        strcat(str,string);
	        format(string,sizeof(string), "Sigara\t{2ECC71}%s\n",FormatNumber(Isyeri[bizid][isyeriFiyatlar][1]));
	        strcat(str,string);
	        format(string,sizeof(string), "Ip\t{2ECC71}%s\n",FormatNumber(Isyeri[bizid][isyeriFiyatlar][2]));
	        strcat(str,string);
	        format(string,sizeof(string), "Göz Baðý\t{2ECC71}%s\n",FormatNumber(Isyeri[bizid][isyeriFiyatlar][3]));
	        strcat(str,string);
         format(string,sizeof(string), "Sprey\t{2ECC71}%s\n",FormatNumber(Isyeri[bizid][isyeriFiyatlar][4]));
	        strcat(str,string);
	        format(string,sizeof(string), "Gazoz\t{2ECC71}%s\n",FormatNumber(Isyeri[bizid][isyeriFiyatlar][5]));
	        strcat(str,string);
	        format(string,sizeof(string), "Beyzbol Sopasý\t{2ECC71}%s\n",FormatNumber(Isyeri[bizid][isyeriFiyatlar][6]));
	        strcat(str,string);
	        format(string,sizeof(string), "Maske\t{2ECC71}%s\n",FormatNumber(Isyeri[bizid][isyeriFiyatlar][7]));
	        strcat(str,string);
	        format(string,sizeof(string), "Benzin Kutusu\t{2ECC71}%s\n",FormatNumber(Isyeri[bizid][isyeriFiyatlar][8]));
	        strcat(str,string);
	        format(string,sizeof(string), "Barbekü\t{2ECC71}%s\n",FormatNumber(Isyeri[bizid][isyeriFiyatlar][9]));
	        strcat(str,string);
	        format(string,sizeof(string), "Köfte\t{2ECC71}%s\n",FormatNumber(Isyeri[bizid][isyeriFiyatlar][10]));
	        strcat(str,string);
	        format(string,sizeof(string), "Tavuk Eti\t{2ECC71}%s\n",FormatNumber(Isyeri[bizid][isyeriFiyatlar][11]));
	        strcat(str,string);
	        format(string,sizeof(string), "Dana Eti\t{2ECC71}%s\n",FormatNumber(Isyeri[bizid][isyeriFiyatlar][12]));
	        strcat(str,string);
            format(string,sizeof(string), "Tamir Kiti\t{2ECC71}%s\n",FormatNumber(Isyeri[bizid][isyeriFiyatlar][13]));
	        strcat(str,string);
	        format(string,sizeof(string), "Portatif Çadýr\t{2ECC71}%s\n",FormatNumber(Isyeri[bizid][isyeriFiyatlar][14]));
	        strcat(str,string);
	        format(string,sizeof(string), "Kamp Ateþi\t{2ECC71}%s\n",FormatNumber(Isyeri[bizid][isyeriFiyatlar][15]));
	        strcat(str,string);
	        /*format(string,sizeof(string), "Yan Keski\t{2ECC71}%s\n",FormatNumber(Isyeri[bizid][isyeriFiyatlar][16]));
	        strcat(str,string);*/
	    }
	    case 2:
	    {
	        format(string,sizeof(string), "Normal Kiyafetler\t{2ECC71}%s\n",FormatNumber(Isyeri[bizid][isyeriFiyatlar][0]));
	        strcat(str,string);
	        format(string,sizeof(string), "Özel Kiyafetler\t{2ECC71}%s\n",FormatNumber(Isyeri[bizid][isyeriFiyatlar][1]));
	        strcat(str,string);
	        format(string,sizeof(string), "Aksesuarlar\t{2ECC71}%s\n",FormatNumber(Isyeri[bizid][isyeriFiyatlar][2]));
	        strcat(str,string);
	    }
	    case 3:
	    {
	        format(string,sizeof(string), "Su\t{2ECC71}%s\n",FormatNumber(Isyeri[bizid][isyeriFiyatlar][0]));
	        strcat(str,string);
	        format(string,sizeof(string), "Kola\t{2ECC71}%s\n",FormatNumber(Isyeri[bizid][isyeriFiyatlar][1]));
	        strcat(str,string);
	        format(string,sizeof(string), "Salata\t{2ECC71}%s\n",FormatNumber(Isyeri[bizid][isyeriFiyatlar][2]));
	        strcat(str,string);
	        format(string,sizeof(string), "Tavuk\t{2ECC71}%s\n",FormatNumber(Isyeri[bizid][isyeriFiyatlar][3]));
	        strcat(str,string);
	        format(string,sizeof(string), "Patates Kýzartmasý\t{2ECC71}%s\n",FormatNumber(Isyeri[bizid][isyeriFiyatlar][4]));
	        strcat(str,string);
	        format(string,sizeof(string), "Hamburger\t{2ECC71}%s\n",FormatNumber(Isyeri[bizid][isyeriFiyatlar][5]));
	        strcat(str,string);
	    }
	    case 5:
	    {
	        format(string,sizeof(string), "Telefon\t{2ECC71}%s\n",FormatNumber(Isyeri[bizid][isyeriFiyatlar][0]));
	        strcat(str,string);
	        format(string,sizeof(string), "Dijital Kamera\t{2ECC71}%s\n",FormatNumber(Isyeri[bizid][isyeriFiyatlar][3]));
	        strcat(str,string);
	        format(string,sizeof(string), "Telsiz\t{2ECC71}%s\n",FormatNumber(Isyeri[bizid][isyeriFiyatlar][1]));
	        strcat(str,string);
	        format(string,sizeof(string), "Boombox\t{2ECC71}%s\n",FormatNumber(Isyeri[bizid][isyeriFiyatlar][2]));
	        strcat(str,string);
	    }
	    case 6:
	    {
	        format(string,sizeof(string), "Bira\t{2ECC71}%s\n",FormatNumber(Isyeri[bizid][isyeriFiyatlar][0]));
	        strcat(str,string);
	        format(string,sizeof(string), "Viski\t{2ECC71}%s\n",FormatNumber(Isyeri[bizid][isyeriFiyatlar][1]));
	        strcat(str,string);
	        format(string,sizeof(string), "Tekila\t{2ECC71}%s\n",FormatNumber(Isyeri[bizid][isyeriFiyatlar][2]));
	        strcat(str,string);
	        format(string,sizeof(string), "Þarap\t{2ECC71}%s\n",FormatNumber(Isyeri[bizid][isyeriFiyatlar][3]));
	        strcat(str,string);
	        format(string,sizeof(string), "Votka\t{2ECC71}%s\n",FormatNumber(Isyeri[bizid][isyeriFiyatlar][4]));
	        strcat(str,string);
	        format(string,sizeof(string), "Þampanya\t{2ECC71}%s\n",FormatNumber(Isyeri[bizid][isyeriFiyatlar][5]));
	        strcat(str,string);
	    }
	}
	Dialog_Show(playerid,IsyeriUrunAl,DIALOG_STYLE_TABLIST_HEADERS, "Ürün Satýn Al",str, "Satýn Al", "{FF6347}Kapat");
	return 1;
}
stock Isyeri_AracMenu(playerid,bizid)
{
    new string[2056];
	string[0] = 0;
    for (new i = 0; i != MAX_DEALERSHIP_CARS; i ++)
	{
		if (DealershipCars[bizid][i][vehModel]) {
			format(string, sizeof(string), "%s%d\t~g~%s\n", string, DealershipCars[bizid][i][vehModel], FormatNumber(DealershipCars[bizid][i][vehPrice]));
		}
	}
    ShowPlayerDialog(playerid, 59, DIALOG_STYLE_PREVMODEL, "Araclar", string, "Sec", "Iptal");
    return 1;
}
stock AksesuarlariGoster(playerid,satinal=0)
{
    new str[1000],string[300];
    strcat(str, "Slot ID\tDurum\tModel ID\n");

	for (new i; i < 10; i++)
	{
		if (PlayerData[playerid][pASlot][i] != 0)
	    {
			if (PlayerData[playerid][pTSlot][i])
                format(string, sizeof string, "{FFFFFF}%d\t{FF0000}Kullanýlýyor\t{FFFFFF}%d\n",i,PlayerData[playerid][pASlot][i]);

			if (!PlayerData[playerid][pTSlot][i])
                format(string, sizeof string, "{FFFFFF}%d\t{2ECC71}Kullanýlmýyor\t{FFFFFF}%d\n",i,PlayerData[playerid][pASlot][i]);
		}
	    else
	    {
	        format(string, sizeof string, "{FFFFFF}%d\t{2ECC71}Kullanýlmýyor\t{FFFFFF}-\n",i);
	    }
	    strcat(str,string);
	}

	if (satinal == 1) ShowPlayerDialog(playerid, 53, DIALOG_STYLE_TABLIST_HEADERS, "{FFFFFF}Aksesuar Slotlarý", str, "Seç", "{FF6347}Iptal");
	if (satinal == 0) ShowPlayerDialog(playerid, 56, DIALOG_STYLE_TABLIST_HEADERS, "{FFFFFF}Aksesuar Slotlarý", str, "Seç", "{FF6347}Iptal");
	if (satinal == 2) ShowPlayerDialog(playerid, 62, DIALOG_STYLE_TABLIST_HEADERS, "{FFFFFF}Aksesuar Slotlarý", str, "Seç", "{FF6347}Iptal");
    return 1;
}
stock SQL_AksesuarKaydet(playerid)
{
	if (GetPVarInt(playerid, "Logged") == 0) return 0;
	new
	    query[2224];
    	format(query, sizeof(query), "UPDATE `oyuncular` SET `ASlot1` = '%d|%d|%d|%d'",
        PlayerData[playerid][pASlot][0],
		PlayerData[playerid][pABone][0],
		PlayerData[playerid][pTSlot][0],
		PlayerData[playerid][pARenk][0]
	);
	format(query, sizeof(query), "%s, `ASlot2` = '%d|%d|%d|%d'",
		query,
        PlayerData[playerid][pASlot][1],
		PlayerData[playerid][pABone][1],
		PlayerData[playerid][pTSlot][1],
		PlayerData[playerid][pARenk][1]
	);
	format(query, sizeof(query), "%s, `ASlot3` = '%d|%d|%d|%d'",
		query,
        PlayerData[playerid][pASlot][2],
		PlayerData[playerid][pABone][2],
		PlayerData[playerid][pTSlot][2],
		PlayerData[playerid][pARenk][2]
	);
	format(query, sizeof(query), "%s, `ASlot4` = '%d|%d|%d|%d'",
		query,
        PlayerData[playerid][pASlot][3],
		PlayerData[playerid][pABone][3],
		PlayerData[playerid][pTSlot][3],
		PlayerData[playerid][pARenk][3]
	);
	format(query, sizeof(query), "%s, `ASlot5` = '%d|%d|%d|%d'",
		query,
        PlayerData[playerid][pASlot][4],
		PlayerData[playerid][pABone][4],
		PlayerData[playerid][pTSlot][4],
		PlayerData[playerid][pARenk][4]
	);
	format(query, sizeof(query), "%s, `ASlot6` = '%d|%d|%d|%d'",
		query,
        PlayerData[playerid][pASlot][5],
		PlayerData[playerid][pABone][5],
		PlayerData[playerid][pTSlot][5],
		PlayerData[playerid][pARenk][5]
	);
	format(query, sizeof(query), "%s, `ASlot7` = '%d|%d|%d|%d'",
		query,
        PlayerData[playerid][pASlot][6],
		PlayerData[playerid][pABone][6],
		PlayerData[playerid][pTSlot][6],
		PlayerData[playerid][pARenk][6]
	);
	format(query, sizeof(query), "%s, `ASlot8` = '%d|%d|%d|%d'",
		query,
        PlayerData[playerid][pASlot][7],
		PlayerData[playerid][pABone][7],
		PlayerData[playerid][pTSlot][7],
		PlayerData[playerid][pARenk][7]
	);
	format(query, sizeof(query), "%s, `ASlot9` = '%d|%d|%d|%d'",
		query,
        PlayerData[playerid][pASlot][8],
		PlayerData[playerid][pABone][8],
		PlayerData[playerid][pTSlot][8],
		PlayerData[playerid][pARenk][8]
	);
	format(query, sizeof(query), "%s, `ASlot10` = '%d|%d|%d|%d'",
		query,
        PlayerData[playerid][pASlot][9],
		PlayerData[playerid][pABone][9],
		PlayerData[playerid][pTSlot][9],
		PlayerData[playerid][pARenk][9]
	);

    format(query, sizeof(query), "%s, `ASlot1Pos` = '%.4f|%.4f|%.4f|%.4f|%.4f|%.4f|%.4f|%.4f|%.4f'",
		query,
		AksesuarData[playerid][0][0],
		AksesuarData[playerid][0][1],
        AksesuarData[playerid][0][2],
        AksesuarData[playerid][0][3],
        AksesuarData[playerid][0][4],
        AksesuarData[playerid][0][5],
        AksesuarData[playerid][0][6],
        AksesuarData[playerid][0][7],
		AksesuarData[playerid][0][8]
	);
    format(query, sizeof(query), "%s, `ASlot2Pos` = '%.4f|%.4f|%.4f|%.4f|%.4f|%.4f|%.4f|%.4f|%.4f'",
        query,
		AksesuarData[playerid][1][0],
        AksesuarData[playerid][1][1],
        AksesuarData[playerid][1][2],
        AksesuarData[playerid][1][3],
        AksesuarData[playerid][1][4],
        AksesuarData[playerid][1][5],
        AksesuarData[playerid][1][6],
        AksesuarData[playerid][1][7],
        AksesuarData[playerid][1][8]
	);
	format(query, sizeof(query), "%s, `ASlot3Pos` = '%.4f|%.4f|%.4f|%.4f|%.4f|%.4f|%.4f|%.4f|%.4f'",
	    query,
		AksesuarData[playerid][2][0],
        AksesuarData[playerid][2][1],
        AksesuarData[playerid][2][2],
        AksesuarData[playerid][2][3],
        AksesuarData[playerid][2][4],
        AksesuarData[playerid][2][5],
        AksesuarData[playerid][2][6],
        AksesuarData[playerid][2][7],
        AksesuarData[playerid][2][8]
	);
	format(query, sizeof(query), "%s, `ASlot4Pos` = '%.4f|%.4f|%.4f|%.4f|%.4f|%.4f|%.4f|%.4f|%.4f'",
	    query,
		AksesuarData[playerid][3][0],
        AksesuarData[playerid][3][1],
        AksesuarData[playerid][3][2],
        AksesuarData[playerid][3][3],
        AksesuarData[playerid][3][4],
        AksesuarData[playerid][3][5],
        AksesuarData[playerid][3][6],
        AksesuarData[playerid][3][7],
        AksesuarData[playerid][3][8],
        AksesuarData[playerid][3][9]
	);
	format(query, sizeof(query), "%s, `ASlot5Pos` = '%.4f|%.4f|%.4f|%.4f|%.4f|%.4f|%.4f|%.4f|%.4f'",
	    query,
		AksesuarData[playerid][4][0],
        AksesuarData[playerid][4][1],
        AksesuarData[playerid][4][2],
        AksesuarData[playerid][4][3],
        AksesuarData[playerid][4][4],
        AksesuarData[playerid][4][5],
        AksesuarData[playerid][4][6],
        AksesuarData[playerid][4][7],
        AksesuarData[playerid][4][8]
	);
	format(query, sizeof(query), "%s, `ASlot6Pos` = '%.4f|%.4f|%.4f|%.4f|%.4f|%.4f|%.4f|%.4f|%.4f'",
	    query,
		AksesuarData[playerid][5][0],
        AksesuarData[playerid][5][1],
        AksesuarData[playerid][5][2],
        AksesuarData[playerid][5][3],
        AksesuarData[playerid][5][4],
        AksesuarData[playerid][5][5],
        AksesuarData[playerid][5][6],
        AksesuarData[playerid][5][7],
        AksesuarData[playerid][5][8]
	);
	format(query, sizeof(query), "%s, `ASlot7Pos` = '%.4f|%.4f|%.4f|%.4f|%.4f|%.4f|%.4f|%.4f|%.4f'",
	    query,
		AksesuarData[playerid][6][0],
        AksesuarData[playerid][6][1],
        AksesuarData[playerid][6][2],
        AksesuarData[playerid][6][3],
        AksesuarData[playerid][6][4],
        AksesuarData[playerid][6][5],
        AksesuarData[playerid][6][6],
        AksesuarData[playerid][6][7],
        AksesuarData[playerid][6][8]
	);
	format(query, sizeof(query), "%s, `ASlot8Pos` = '%.4f|%.4f|%.4f|%.4f|%.4f|%.4f|%.4f|%.4f|%.4f'",
	    query,
		AksesuarData[playerid][7][0],
        AksesuarData[playerid][7][1],
        AksesuarData[playerid][7][2],
        AksesuarData[playerid][7][3],
        AksesuarData[playerid][7][4],
        AksesuarData[playerid][7][5],
        AksesuarData[playerid][7][6],
        AksesuarData[playerid][7][7],
        AksesuarData[playerid][7][8]
	);
	format(query, sizeof(query), "%s, `ASlot9Pos` = '%.4f|%.4f|%.4f|%.4f|%.4f|%.4f|%.4f|%.4f|%.4f'",
	    query,
		AksesuarData[playerid][8][0],
        AksesuarData[playerid][8][1],
        AksesuarData[playerid][8][2],
        AksesuarData[playerid][8][3],
        AksesuarData[playerid][8][4],
        AksesuarData[playerid][8][5],
        AksesuarData[playerid][8][6],
        AksesuarData[playerid][8][7],
        AksesuarData[playerid][8][8]
	);
	format(query, sizeof(query), "%s, `ASlot10Pos` = '%.4f|%.4f|%.4f|%.4f|%.4f|%.4f|%.4f|%.4f|%.4f' WHERE `ID` = '%d'",
	    query,
		AksesuarData[playerid][9][0],
        AksesuarData[playerid][9][1],
        AksesuarData[playerid][9][2],
        AksesuarData[playerid][9][3],
        AksesuarData[playerid][9][4],
        AksesuarData[playerid][9][5],
        AksesuarData[playerid][9][6],
        AksesuarData[playerid][9][7],
        AksesuarData[playerid][9][8],
        PlayerData[playerid][pID]
	);
	mysql_query(g_SQL,query, false);
	return 1;
}


stock AksesuarAyarla(playerid)
{
    for (new i = 0; i < 5; i ++)
	{
		if (!PlayerData[playerid][pTSlot][i])
		{
			RemovePlayerAttachedObject(playerid, i);
		}
		else
		{
		    AksesuarTak(playerid, i);
		}
	}
	return 1;
}

stock Isyeri_Yenile(id)
{
	if (id != -1 && Isyeri[id][isyeriExists])
	{
	    if (IsValidDynamic3DTextLabel(Isyeri[id][bizText3D]))
		    DestroyDynamic3DTextLabel(Isyeri[id][bizText3D]);

		if (IsValidDynamicPickup(Isyeri[id][isyeriPickup]))
		    DestroyDynamicPickup(Isyeri[id][isyeriPickup]);

		new string[500], durum[24], pickup, sahip[24], tip[30];

		if (!Isyeri[id][isyeriKilit]) durum = "{007fff}Açýk";
		else durum = "{FF0000}Kapalý";

		if (Isyeri[id][isyeriSahip] == -99)
		{
			    format(sahip, 24, "Devlet");
		} else format(sahip, 24, "%s", SQLName(Isyeri[id][isyeriSahip],0));

		switch (Isyeri[id][isyeriTip])
		{
		    case 1: pickup = 1239, tip = "Market";
		    case 2: pickup = 1239, tip = "Kiyafet Maðazasý";
		    case 3: pickup = 1239, tip = "Fast Food";
		    case 4: pickup = 1239, tip = "Galeri";
		    case 5: pickup = 1239, tip = "Elektronik Maðazasý";
		    case 6: pickup = 1239, tip = "Bar/Pub";
		    case 7: pickup = 1239, tip = "Kumarhane";
		    case 8: pickup = 1239, tip = "Diðer";
		}

  if (Isyeri[id][isyeriSahip] == -1)
		{
            format(string,sizeof(string), "{FF0000}Satýlýk Ýþyeri (ID: %d)\n\n{ffffff}Tip: {007fff}%s\n{00bf5f}%s\n{00bf5f}$0 {ffffff}kazanç / {00bf5f}$60 {ffffff}dakika.",id,tip,FormatNumber(Isyeri[id][isyeriFiyat]));
		    Isyeri[id][bizText3D] = CreateDynamic3DTextLabel(string,-1,Isyeri[id][isyeriPos][0],Isyeri[id][isyeriPos][1],Isyeri[id][isyeriPos][2],7.0,INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0,0,0);

			if (Isyeri[id][isyeriTip] != 1)
				Isyeri[id][isyeriPickup] = CreateDynamicPickup(pickup, 23,Isyeri[id][isyeriPos][0],Isyeri[id][isyeriPos][1],Isyeri[id][isyeriPos][2],0,0);

            if (Isyeri[id][isyeriTip] == 1)
				Isyeri[id][isyeriPickup] = CreateDynamicPickup(pickup, 23,Isyeri[id][isyeriPos][0],Isyeri[id][isyeriPos][1],Isyeri[id][isyeriPos][2]-0.0,0,0);
		}

		else if (Isyeri[id][isyeriSahip] != -1 && Isyeri[id][isyeriSatilik] == 0)
		{
		    format(string,sizeof(string), "{808080}Ýþyeri (ID: %d)\n\n{808080}[{ffffff}%s{808080}]",id,Isyeri[id][isyeriName],durum);
		    if (Isyeri[id][isyeriGirisUcret] > 0)
			{
			    new girisucret[150];
				format(girisucret, 150, "\n{ffffff}Giriþ: {00bf5f}%s", FormatNumber(Isyeri[id][isyeriGirisUcret]));
				strcat(string, girisucret);
			}
		    Isyeri[id][bizText3D] = CreateDynamic3DTextLabel(string,-1,Isyeri[id][isyeriPos][0],Isyeri[id][isyeriPos][1],Isyeri[id][isyeriPos][2],7.0,INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0,0,0);

            if (Isyeri[id][isyeriTip] != 1)
				Isyeri[id][isyeriPickup] = CreateDynamicPickup(pickup, 23,Isyeri[id][isyeriPos][0],Isyeri[id][isyeriPos][1],Isyeri[id][isyeriPos][2],0,0);

            if (Isyeri[id][isyeriTip] == 1)
                Isyeri[id][isyeriPickup] = CreateDynamicPickup(pickup, 23,Isyeri[id][isyeriPos][0],Isyeri[id][isyeriPos][1],Isyeri[id][isyeriPos][2],0,0);
		}
		else if (Isyeri[id][isyeriSahip] != -1 && Isyeri[id][isyeriSatilik] == 1)
		{
		    format(string,sizeof(string), "{A9C4E4}Ýþyeri Durumu: Satýlýk!\n{A9C4E4}Kapý Numarasý: %d\n{A9C4E4}Ücret: %s\n{A9C4E4}Tip: %s",id,FormatNumber(Isyeri[id][isyeriFiyat]), tip);
		    if (Isyeri[id][isyeriGirisUcret] > 0)
			{
			    new girisucret[150];
				format(girisucret, 150, "\n{A9C4E4}Giriþ Ücreti: {00bf5f}%s", FormatNumber(Isyeri[id][isyeriGirisUcret]));
				strcat(string, girisucret);
			}
		 	Isyeri[id][bizText3D] = CreateDynamic3DTextLabel(string,-1,Isyeri[id][isyeriPos][0],Isyeri[id][isyeriPos][1],Isyeri[id][isyeriPos][2],7.0,INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0,0,0);
		    Isyeri[id][isyeriPickup] = CreateDynamicPickup(pickup, 23,Isyeri[id][isyeriPos][0],Isyeri[id][isyeriPos][1],Isyeri[id][isyeriPos][2],0,0);
		}

	}
}
stock GetPlayerSkinEx(playerid)
{
	return (GetPlayerCustomSkin(playerid) >= 20001) ? (GetPlayerCustomSkin(playerid)) : (GetPlayerSkin(playerid));
}
stock Isyeri_Kaydet(id)
{
	static query[4000];
	format(query,sizeof(query), "UPDATE `isyerleri` SET `iIsim` = '%s',`iMessage` = '%s',`iSahip` = '%d',`iTip` = '%d',`iFiyat` = '%d',`iKendiFiyat` = '%d',`iSatilik` = '%d',`iVergi` = '%d', `iVergiSure` = '%d', `iGirisUcret` = '%d',`iMuzik` = '%s'",
	SQL_ReturnEscaped(Isyeri[id][isyeriName]),
	SQL_ReturnEscaped(Isyeri[id][isyeriMesaj]),
	Isyeri[id][isyeriSahip],
	Isyeri[id][isyeriTip],
	Isyeri[id][isyeriFiyat],
	Isyeri[id][isyeriKendiFiyati],
	Isyeri[id][isyeriSatilik],
	Isyeri[id][isyeriVergi],
	Isyeri[id][isyeriVergiSure],
	Isyeri[id][isyeriGirisUcret],
	SQL_ReturnEscaped(Isyeri[id][isyeriMuzik])
	);
	format(query,sizeof(query), "%s, `iPosX` = '%.4f',`iPosY` = '%.4f',`iPosZ` = '%.4f',`iPosA` = '%.4f',`iIntX` = '%.4f',`iIntY` = '%.4f',`iIntZ` = '%.4f',`iIntA` = '%.4f',`iSpawnX` = '%.4f',`iSpawnY` = '%.4f',`iSpawnZ` = '%.4f',`iSpawnA` = '%.4f'",
	query,
	Isyeri[id][isyeriPos][0],
	Isyeri[id][isyeriPos][1],
	Isyeri[id][isyeriPos][2],
	Isyeri[id][isyeriPos][3],
	Isyeri[id][isyeriInt][0],
	Isyeri[id][isyeriInt][1],
	Isyeri[id][isyeriInt][2],
	Isyeri[id][isyeriInt][3],
	Isyeri[id][isyeriSpawn][0],
	Isyeri[id][isyeriSpawn][1],
	Isyeri[id][isyeriSpawn][2],
	Isyeri[id][isyeriSpawn][3]
	);
	format(query,sizeof(query), "%s, `iInterior` = '%d',`iKilit` = '%d',`iKasa` = '%d',`iFiyat1` = '%d',`iFiyat2` = '%d',`iFiyat3` = '%d',`iFiyat4` = '%d',`iFiyat5` = '%d',`iFiyat6` = '%d',`iFiyat7` = '%d',`iFiyat8` = '%d',`iFiyat9` = '%d',`iFiyat10` = '%d'",
	query,
	Isyeri[id][isyeriInterior],
	Isyeri[id][isyeriKilit],
	Isyeri[id][isyeriKasa],
	Isyeri[id][isyeriFiyatlar][0],
	Isyeri[id][isyeriFiyatlar][1],
	Isyeri[id][isyeriFiyatlar][2],
	Isyeri[id][isyeriFiyatlar][3],
	Isyeri[id][isyeriFiyatlar][4],
	Isyeri[id][isyeriFiyatlar][5],
	Isyeri[id][isyeriFiyatlar][6],
	Isyeri[id][isyeriFiyatlar][7],
	Isyeri[id][isyeriFiyatlar][8],
	Isyeri[id][isyeriFiyatlar][9]
	);
	format(query,sizeof(query), "%s, `iFiyat11` = '%d',`iFiyat12` = '%d',`iFiyat13` = '%d',`iFiyat14` = '%d',`iFiyat15` = '%d',`iFiyat16` = '%d',`iFiyat17` = '%d',`iFiyat18` = '%d',`iFiyat19` = '%d',`iFiyat20` = '%d'",
	query,
	Isyeri[id][isyeriFiyatlar][10],
	Isyeri[id][isyeriFiyatlar][11],
	Isyeri[id][isyeriFiyatlar][12],
	Isyeri[id][isyeriFiyatlar][13],
	Isyeri[id][isyeriFiyatlar][14],
	Isyeri[id][isyeriFiyatlar][15],
	Isyeri[id][isyeriFiyatlar][16],
	Isyeri[id][isyeriFiyatlar][17],
	Isyeri[id][isyeriFiyatlar][18],
	Isyeri[id][isyeriFiyatlar][19]
	);
	format(query,sizeof(query), "%s, `iUrun1` = '%d',`iUrun2` = '%d',`iUrun3` = '%d',`iUrun4` = '%d',`iUrun5` = '%d',`iUrun6` = '%d',`iUrun7` = '%d',`iUrun8` = '%d',`iUrun9` = '%d',`iUrun10` = '%d',`iUrun11` = '%d',`iUrun12` = '%d',`iUrun13` = '%d',`iUrun14` = '%d',`iUrun15` = '%d',`iUrun16` = '%d',`iUrun17` = '%d',`iUrun18` = '%d',`iUrun19` = '%d',`iUrun20` = '%d' WHERE `ID` = '%d'",
	query,
	Isyeri[id][isyeriUrunSayisi][0],
	Isyeri[id][isyeriUrunSayisi][1],
	Isyeri[id][isyeriUrunSayisi][2],
	Isyeri[id][isyeriUrunSayisi][3],
	Isyeri[id][isyeriUrunSayisi][4],
	Isyeri[id][isyeriUrunSayisi][5],
	Isyeri[id][isyeriUrunSayisi][6],
	Isyeri[id][isyeriUrunSayisi][7],
	Isyeri[id][isyeriUrunSayisi][8],
	Isyeri[id][isyeriUrunSayisi][9],
	Isyeri[id][isyeriUrunSayisi][10],
	Isyeri[id][isyeriUrunSayisi][11],
	Isyeri[id][isyeriUrunSayisi][12],
	Isyeri[id][isyeriUrunSayisi][13],
	Isyeri[id][isyeriUrunSayisi][14],
	Isyeri[id][isyeriUrunSayisi][15],
	Isyeri[id][isyeriUrunSayisi][16],
	Isyeri[id][isyeriUrunSayisi][17],
	Isyeri[id][isyeriUrunSayisi][18],
	Isyeri[id][isyeriUrunSayisi][19],
	Isyeri[id][isyeriID]
	);
	mysql_query(g_SQL,query, false);
	return 1;
}
stock ClearPlayerAnim(playerid)
{
	new skin;
	skin = GetPlayerSkin(playerid);
	SetPlayerSkin(playerid, skin);
	return 1;
}
stock BildirimEkle(sqlid,mesaj[],gonderen[])
{
	new query[680];
	format(query,sizeof(query), "INSERT INTO `bildirimler` (`sqlid`,`Tarih`,`Mesaj`,`Gonderen`,`Durum`) VALUES ('%d','%s','%s','%s','0')",sqlid,ReturnDate(),mesaj,gonderen);
	mysql_query(g_SQL,query, false);
	return 1;
}
stock Bildirim_OkunmamisBildirimler(sqlid)
{
	new query[200];
	format(query,sizeof(query), "SELECT * FROM `bildirimler` WHERE `sqlid` = '%d' AND `Durum` = '0'",sqlid);
	new Cache:Radless = mysql_query(g_SQL,query);
	new rows;
	cache_get_row_count(rows);
	cache_delete(Radless);
	return rows;
}
stock Bildirim_SayiCek(sqlid)
{
	new query[200];
	format(query,sizeof(query), "SELECT * FROM `bildirimler` WHERE `sqlid` = '%d'",sqlid);
	new Cache:Radless = mysql_query(g_SQL,query);
	new rows;
	cache_get_row_count(rows);
	cache_delete(Radless);
	return rows;
}
stock Bildirim_Sil(bildirimid)
{
	new query[122];
	format(query,sizeof(query), "DELETE FROM `bildirimler` WHERE `id` = '%d'",bildirimid);
	mysql_query(g_SQL,query, false);
	return 1;
}
stock BildirimleriSil(sqlid)
{
	new query[150];
	format(query,sizeof(query), "DELETE FROM `bildirimler` WHERE `sqlid` = '%d'",sqlid);
	mysql_query(g_SQL,query, false);
	return 1;
}
Business_Nearest(playerid, Float:radius = 2.5)
{
    for (new i = 0; i != MAX_ISYERI; i ++) if (Isyeri[i][isyeriExists] && IsPlayerInRangeOfPoint(playerid, radius, Isyeri[i][isyeriPos][0], Isyeri[i][isyeriPos][1], Isyeri[i][isyeriPos][2]))
	{
			return i;
	}
	return -1;
}
stock BildirimlerDialog(playerid)
{
	if (!OyundaDegil(playerid)) return 1;
	new str[1024],string[500],query[200];
	strcat(str, "ID\tGönderen\tTarih\tDurum\n");
	if (Bildirim_OkunmamisBildirimler(PlayerData[playerid][pID]) > 0)
	{
		format(query,sizeof(query), "SELECT `id`,`Gonderen`,`Tarih` FROM `bildirimler` WHERE `sqlid` = '%d' AND `Durum` = '0'",PlayerData[playerid][pID]);
		mysql_query(g_SQL,query);
		new rows;
		cache_get_row_count(rows);
		new bid,gonderen[24],tarih[22];
		if (rows)
		{
			for (new i; i<rows; i++)
			{
				cache_get_value_name_int(i, "id",bid);
				cache_get_value_name(i, "Gonderen",gonderen,24);
				cache_get_value_name(i, "Tarih",tarih,22);
				format(string,sizeof(string), "%d\t%s\t%s\t{00FF00}|\n",bid,gonderen,tarih);
				strcat(str,string);
			}
			format(query,sizeof(query), "SELECT `id`,`Gonderen`,`Tarih` FROM `bildirimler` WHERE `sqlid` = '%d' AND `Durum` = '1'",PlayerData[playerid][pID]);
   			mysql_query(g_SQL,query);
			cache_get_row_count(rows);
			if (rows)
			{
			    for (new i; i<rows; i++)
			    {
			        cache_get_value_name_int(i, "id",bid);
					cache_get_value_name(i, "Gonderen",gonderen,24);
					cache_get_value_name(i, "Tarih",tarih,30);
					format(string,sizeof(string), "%d\t%s\t%s\t{FF0000}|\n",bid,gonderen,tarih);
					strcat(str,string);
			    }
			}
		}

	}
	else
	{
	    if (Bildirim_SayiCek(PlayerData[playerid][pID]) < 1) return HataMesajGonder(playerid, "Hiç bildiriminiz yok.");
	    new bid,gonderen[24],tarih[22];
	    format(query,sizeof(query), "SELECT `id`,`Gonderen`,`Tarih` FROM `bildirimler` WHERE `sqlid` = '%d' AND `Durum` = '1'",PlayerData[playerid][pID]);
		mysql_query(g_SQL,query);
		new rows;
		cache_get_row_count(rows);
		if (rows)
		{
  			for (new i; i<rows; i++)
	    	{
      			cache_get_value_name_int(i, "id",bid);
				cache_get_value_name(i, "Gonderen",gonderen,24);
				cache_get_value_name(i, "Tarih",tarih,22);
				format(string,sizeof(string), "%d\t%s\t%s\t{FF0000}|\n",bid,gonderen,tarih);
				strcat(str,string);
	    	}
		}
	}
	ShowPlayerDialog(playerid,BILDIRIM_DIALOG,DIALOG_STYLE_TABLIST_HEADERS, "Bildirimleriniz - %s", str, ReturnName(playerid, 0), "Görüntüle", "Kapat");
	return 1;
}
stock OlusumAksesuariSil(iTargetID)
{
	for (new iToyIter; iToyIter < 5; ++iToyIter) {
		for (new LoopRapist; LoopRapist < sizeof(AttachCops); ++LoopRapist) {
			if (AttachCops[LoopRapist][olusumamodel] == PlayerData[iTargetID][pASlot][iToyIter]) {
                RemovePlayerAttachedObject(iTargetID, iToyIter);
                PlayerData[iTargetID][pASlot][iToyIter] = 0;
				AksesuarAyarla(iTargetID);
			}
		}
	}
	BilgiMesajGonder(iTargetID, "Oluþuma ait olan tüm aksesuarlar kaldýrýldý.");
	return 1;
}
BirliktenAt(playerid)
{
	if (PlayerData[playerid][pFaction] == -1) return 1;
	if (Birlikler[PlayerData[playerid][pFaction]][birlikTip] != BIRLIK_CETE && Birlikler[PlayerData[playerid][pFaction]][birlikTip] != BIRLIK_MAFYA && Birlikler[PlayerData[playerid][pFaction]][birlikTip] != BIRLIK_LEGAL)
	{
	    SetPlayerSkin(playerid, PlayerData[playerid][pSkin]);
		SetPlayerColor(playerid, 0xFFFFFFFF);
		PlayerData[playerid][pOnDuty] = 0;
		PlayerData[playerid][pOnDutySkin] = 0;
		PlayerData[playerid][pTazer] = 0;
		PlayerData[playerid][pBeanbag] = 0;
		OlusumAksesuariSil(playerid);
		ResetWeapons(playerid);
	}
	Birlik_Kaydet(PlayerData[playerid][pFaction]);
    PlayerData[playerid][pFaction] = -1;
    PlayerData[playerid][pFactionRutbe] = 0;
    PlayerData[playerid][pFactionDivizyon] = 0;
   	for (new i = 0; i < MAX_ARAC; i ++) if (AracInfo[i][aracExists] && AracInfo[i][aracSahip] == PlayerData[playerid][pID])
	{
	    AracInfo[i][aracFactionType] = 0;
		AracInfo[i][aracFaction] = -1;
	}
	return 1;
}
Birlik_Update(factionid)
{
	if (factionid != -1 || Birlikler[factionid][birlikExists])
	{
	    foreach (new i : Player) if (PlayerData[i][pFaction] == factionid)
		{
			 	SetFactionColor(i);
		}
	}
	return 1;
}

SetFactionColor(playerid)
{
	new factionid = PlayerData[playerid][pFaction];

	if (factionid != -1)
	{
		SetPlayerColor(playerid, RemoveAlpha(Birlikler[factionid][birlikColor]));
	} else {
	    SetPlayerColor(playerid, 0xFFFFFF00);
	}
	return 0;
}

stock RemoveAlpha(color) {
    return (color & ~0xFF);
}

stock Birlik_Olustur(birlikisim[],tip)
{
    for (new i = 0; i != MAX_BIRLIK; i ++) if (!Birlikler[i][birlikExists])
    {
        Birlikler[i][birlikExists] = true;
        Birlikler[i][birlikID] = i;

        format(Birlikler[i][birlikAd], 32, birlikisim);
        Birlikler[i][birlikDuyuru][0] = '\0';
        if (tip != 3) Birlikler[i][birlikColor] = 0xFFFFFF00;
        else Birlikler[i][birlikColor] = 0x9ACD32FF;
        Birlikler[i][birlikTip] = tip;
        switch (tip)
        {
            case 1..4: Birlikler[i][birlikRutbeler] = 6;
            default: Birlikler[i][birlikRutbeler] = 12;
        }
        Birlikler[i][birlikKasaPara] = 0;
        Birlikler[i][birlikOnaylar][0] = 0;
        Birlikler[i][birlikOnaylar][1] = 0;
        Birlikler[i][birlikOnaylar][2] = 0;
        Birlikler[i][birlikOnaylar][3] = 0;
        Birlikler[i][birlikOnaylar][4] = 0;
        Birlikler[i][OOCDurum] = 1;

        Birlikler[i][birlikYetkilendirme][0] = Birlikler[i][birlikRutbeler]-1; // Üye Alma
        Birlikler[i][birlikYetkilendirme][1] = Birlikler[i][birlikRutbeler]-1; // Üye Atma
        Birlikler[i][birlikYetkilendirme][2] = Birlikler[i][birlikRutbeler]-2; // Rütbe Deðiþtirme
        Birlikler[i][birlikYetkilendirme][3] = Birlikler[i][birlikRutbeler]-2; // Divizyon Deðiþtirme
        Birlikler[i][birlikYetkilendirme][4] = Birlikler[i][birlikRutbeler]-3; // Araçlarý Spawnlama
        Birlikler[i][birlikYetkilendirme][5] = Birlikler[i][birlikRutbeler]-3; // Birlik OOC Chat Kapatma
        Birlikler[i][birlikYetkilendirme][6] = Birlikler[i][birlikRutbeler]; // Birlik Kasasýndan Para Alma
        Birlikler[i][birlikYetkilendirme][7] = 1; // Ajans Ayarlarý Seviyesi

        Birlikler[i][yayinDurum] = 1;
        Birlikler[i][yayinTipi] = 0;
        Birlikler[i][ReklamAlimi] = 0;
        Birlikler[i][ReklamUcreti] = 0;
        Birlikler[i][ReklamSayisi] = 0;
        Birlikler[i][CekilisBasladi] = false;
        Birlikler[i][cekilisOdul] = 0;
        Birlikler[i][reklamPos][0] = 0.0;
        Birlikler[i][reklamPos][1] = 0.0;
        Birlikler[i][reklamPos][2] = 0.0;
        if (IsValidDynamicPickup(Birlikler[i][reklamPickup])) DestroyDynamicPickup(Birlikler[i][reklamPickup]);
        if (IsValidDynamic3DTextLabel(Birlikler[i][reklamLabel])) DestroyDynamic3DTextLabel(Birlikler[i][reklamLabel]);
        for (new j = 0; j < 15; j ++)
        {
            if (j < 5)
            {
                format(BirlikDivizyon[i][j],20, "Birim %d",j+1);
            }
            format(BirlikRutbe[i][j],32, "Rutbe %d",j+1);
        }

        new query[256];

        mysql_format(g_SQL, query, sizeof query, "INSERT INTO `birlikler` (`bid`) VALUES ('%d')", Birlikler[i][birlikID]);
        mysql_query (g_SQL, query);

		Birlik_Kaydet(Birlikler[i][birlikID]);

		return Birlikler[i][birlikID];
    }
    return -1;
}

stock OyuncuBaliklari(playerid)
{
	new str[1000],string[228];
	strcat(str,"Balýk\tGram\tFiyat\n");
	new baliklar = 0;
	for(new i; i<10; i++)
	{
	    if(PlayerData[playerid][pBalikID][i] != -1)
	    {
	        format(string,sizeof(string),"{808080}%s\t{FFFFFF}%d\t{808080}%s\n",BalikTurleri[PlayerData[playerid][pBalikID][i]][TurAdi],PlayerData[playerid][pBalikGram][i],FormatNumber(floatround(PlayerData[playerid][pBalikGram][i] * BalikTurleri[PlayerData[playerid][pBalikID][i]][GramFiyat])));
	        strcat(str,string);
	        baliklar++;
	    }
	}
	strcat(str,"{FF0000}Hepsini Sat");
	if(baliklar < 1) return HataMesajGonder(playerid,"Hiç balýðýnýz yok.");
	format(string,sizeof(string),"{808080}Balýklarýnýz {FF0000}(%d/10)",baliklar);
	Dialog_Show(playerid,Baliklar,DIALOG_STYLE_TABLIST_HEADERS,string,str,"Sat","Kapat");
	return 1;
}

stock BalikToplamPara(playerid)
{
	new toplam = 0;
	for(new i; i<10; i++)
	{
	    if(PlayerData[playerid][pBalikID][i] != -1)
	    {
	        toplam += floatround(PlayerData[playerid][pBalikGram][i] * BalikTurleri[PlayerData[playerid][pBalikID][i]][GramFiyat]);
	    }
	}
	return toplam;
}
stock GetBalikIDWithName(name[])
{
	for(new i; i<sizeof(BalikTurleri); i++)
	{
	    if (!strcmp(name, BalikTurleri[i][TurAdi], true))
	    {
	        return i;
	    }
	}
	return -1;
}

stock BoyleBalikVar(playerid,id)
{
	for(new i; i<10; i++)
	{
	    if(PlayerData[playerid][pBalikID][i] == id)
	    {
	        return 1;
	    }
	}
	return 0;
}

stock GetFactionByID(sqlid)
{
	for (new i = 0; i != MAX_BIRLIK; i ++) if (Birlikler[i][birlikExists] && Birlikler[i][birlikID] == sqlid)
	    return i;

	return -1;
}

stock Ev_Sil(playerid, evid) // Deðiþti
{
    if (evid != -1 && HouseInfo[evid][evExists])
    {
        new sorgu[100];

		format(sorgu, sizeof(sorgu), "DELETE FROM `evler` WHERE `evid` = '%d'", HouseInfo[evid][evID]);
		mysql_query(g_SQL, sorgu, false);
		if (Ev_GetKeyCount(evid) > 0)
		{
			format(sorgu, sizeof(sorgu), "DELETE FROM `anahtarlar` WHERE `sqlid` = '%d' AND `tip` = '1'",HouseInfo[evid][evID]);
			mysql_query(g_SQL, sorgu, false);
		}
		if (IsValidDynamic3DTextLabel(HouseInfo[evid][houseText]))
		    DestroyDynamic3DTextLabel(HouseInfo[evid][houseText]);

		if (IsValidDynamicPickup(HouseInfo[evid][evPickup]))
		    DestroyDynamicPickup(HouseInfo[evid][evPickup]);

		if (HouseInfo[evid][evSahip] != -1)
		{
		    format(sorgu, sizeof(sorgu), "%s adlý yetkili tarafýndan eviniz silindi.", PlayerData[playerid][pAdminName]);
		    BildirimEkle(HouseInfo[evid][evSahip],sorgu, "Sistem");
		}
		HouseInfo[evid][evExists] = false;
		HouseInfo[evid][evSahip] = -1;
		HouseInfo[evid][evID] = 0;
		HouseInfo[evid][evKiralayan] = -1;
		House_RemoveFurniture(evid);
    }
}
stock AjansAyarlari(playerid)
{
	new id = PlayerData[playerid][pFaction];
    Dialog_Show(playerid, AjansAyarlari, DIALOG_STYLE_TABLIST, "{38c5f7}Ajans Ayarlarý", "{38c5f7}» {FFFFFF}Yayýn Durumunu Deðiþtir\t%s\n{38c5f7}» {FFFFFF}Dinleyici Sayýsý\t%d\n{38c5f7}» {FFFFFF}Yayýn Tipini Deðiþtir\t%s\n{38c5f7}» {FFFFFF}Reklam Alýmý\t%s\n{38c5f7}» {FFFFFF}Reklam Ücreti\t{38c5f7}%s\n{38c5f7}» {FFFFFF}Alýnan Reklam Sayýsý\t%d\n \n{38c5f7}» Çekiliþ \n", "Seç", "Geri",
	(Birlikler[id][yayinDurum] == 1) ? ("{38c5f7}Açýk") : ("{FF0000}Kapalý"), Dinleyici_Sayisi(id),(Birlikler[id][yayinTipi] == 0) ? ("Haber") : ("Müzik"), (Birlikler[id][ReklamAlimi] == 1) ? ("{38c5f7}Alýnýyor") : ("{FF0000}Alýnmýyor"), FormatNumber(Birlikler[id][ReklamUcreti]), Birlikler[id][ReklamSayisi]);
	return 1;
}
stock Dinleyici_Sayisi(birlikid)
{
	new sayi = 0;
	foreach (new i:Player)
	{
	    if (PlayerData[i][pDinle] == birlikid)
	    {
	        sayi++;
		}
	}
	return sayi;
}
stock Reklam_Nearest(playerid, Float:radius)
{
	for (new i; i<MAX_BIRLIK; i++) if (IsValidDynamicPickup(Birlikler[i][reklamPickup]) && IsPlayerInRangeOfPoint(playerid, radius, Birlikler[i][reklamPos][0], Birlikler[i][reklamPos][1], Birlikler[i][reklamPos][2]))
	{
	    return i;
	}
	return -1;
}

ResetWeapon(playerid, weaponid)
{
	ResetPlayerWeapons(playerid);

	for (new i = 0; i < 13; i ++) {
	    if (PlayerData[playerid][pSilahlar][i] != weaponid) {
	        GivePlayerWeapon(playerid, PlayerData[playerid][pSilahlar][i], PlayerData[playerid][pMermiler][i]);
		}
		else {
            PlayerData[playerid][pSilahlar][i] = 0;
            PlayerData[playerid][pMermiler][i] = 0;
	    }
	}
	return 1;
}
stock Birlik_OfflineUyeler(playerid,factionid)
{
	new query[128];
	format(query,sizeof(query), "SELECT * FROM `oyuncular` WHERE `Birlik` = '%d'",factionid);
	new Cache:Radless = mysql_query(g_SQL,query);
	new rows;
	cache_get_row_count(rows);
	if (!rows) return HataMesajGonder(playerid, "Çevrimdýþý üye bulunamadý.");
	new string[2000],name[24],rutbe,songiris[23],id,sayi;
	strcat(string, "ID\tAd\tRütbe\tSon Giriþ\n");
	for (new i = 0; i < rows; i ++)
	{
	    if (sayi < 75)
	    {
	        cache_get_value_name(i, "Isim",name,24);
	        new pid = GetPlayerID(name);
	        if (pid == -1)
	        {
	            sayi++;
	            cache_get_value_name_int(i, "ID",id);
	            cache_get_value_name_int(i, "BirlikRutbe",rutbe);
	            cache_get_value_name(i, "SonGiris",songiris,23);
	            format(string,sizeof(string), "%s{59DC1C}%d\t{59DC1C}%s\t{59DC1C}%s\t{59DC1C}%s\n",string,id,name,BirlikRutbe[factionid][rutbe-1],songiris);
	        }
		}
	}
	cache_delete(Radless);
	if (sayi == 0) return HataMesajGonder(playerid, "Hiç çevrimdýþý üye yok.");
	Dialog_Show(playerid, OfflineUyeler, DIALOG_STYLE_TABLIST_HEADERS, "{72C425}Çevrimdýþý Üyeler",string, "Ayarla", "{FF6347}Iptal");
	return 1;
}
GetVehicleDriver(vehicleid) {
	foreach (new i : Player) {
		if (GetPlayerState(i) == PLAYER_STATE_DRIVER && GetPlayerVehicleID(i) == vehicleid) return i;
	}
	return INVALID_PLAYER_ID;
}
Birlik_DivizyonlariGoster(playerid, factionid)
{
    if (factionid != -1 && Birlikler[factionid][birlikExists])
	{
		static
		    string[640];

		string[0] = 0;

		for (new i = 0; i < 5; i ++)
		    format(string, sizeof(string), "%s{72C425}%d: {FFFFFF}%s\n", string, i + 1, BirlikDivizyon[factionid][i]);

		PlayerData[playerid][pFactionEdit] = factionid;
		Dialog_Show(playerid, DivizyonDuzenle, DIALOG_STYLE_LIST, "{72C425}Divizyon Adlarýný Düzenle", string, "Düzenle", "{FF6347}Iptal");
	}
	return 1;
}
Birlik_RutbeleriGoster(playerid, factionid)
{
    if (factionid != -1 && Birlikler[factionid][birlikExists])
	{
		static
		    string[640];

		string[0] = 0;

		for (new i = 0; i < Birlikler[factionid][birlikRutbeler]; i ++)
		    format(string, sizeof(string), "%s{72C425}%d: {FFFFFF}%s\n", string, i + 1, BirlikRutbe[factionid][i]);

		PlayerData[playerid][pFactionEdit] = factionid;
		Dialog_Show(playerid, EditRanks, DIALOG_STYLE_LIST, "Rütbe Adlarýný Düzenle", string, "Düzenle", "{FF6347}Iptal");
	}
	return 1;
}
Birlik_DivizyonDegistir(playerid, factionid)
{
    if (factionid != -1 && Birlikler[factionid][birlikExists])
	{
		static
		    string[640];

		string[0] = 0;
		strcat(string, "Divizyondan Çýkar\n");
		for (new i = 0; i < 5; i ++)
		    format(string, sizeof(string), "%s{72C425}%d: {FFFFFF}%s\n", string, i + 1, BirlikDivizyon[factionid][i]);

		Dialog_Show(playerid, DivizyonSec, DIALOG_STYLE_LIST, "Divizyon Düzenleme", string, "Deðiþtir", "{FF6347}Iptal");
	}
	return 1;
}
IsPlayerNearWater(playerid)
{
	 /*new Float:angle;

	GetPlayerFacingAngle(playerid, angle);*/
	for(new i; i<sizeof(BalikciPoslar); i++)
	{
	    if(IsPlayerInRangeOfPoint(playerid,20.0,BalikciPoslar[i][0],BalikciPoslar[i][1],BalikciPoslar[i][2])) return 1;
	}
	return 0;
}

stock RutbeDegistirmeDialog(playerid,factionid)
{
    if (factionid != -1 && Birlikler[factionid][birlikExists])
    {
        static
		    string[640];

		string[0] = 0;
		for (new i = 0; i < Birlikler[factionid][birlikRutbeler]; i ++)
		{
		     format(string, sizeof(string), "%s{72C425}%d: {FFFFFF}%s\n", string, i + 1, BirlikRutbe[factionid][i]);
		}
		Dialog_Show(playerid, RutbeSec, DIALOG_STYLE_LIST, "Rütbe Düzenleme", string, "Deðiþtir", "{FF6347}Iptal");
    }
}
stock preloadanim_mine(playerid)
{
    PreloadAnimLib(playerid, "CARRY");
    PreloadAnimLib(playerid, "GHANDS");
    PreloadAnimLib(playerid, "BASEBALL");
	return 1;
}
stock PreloadAnimLib(playerid, animlib[])
{
	ApplyAnimation(playerid, animlib, "null", 0.0, 0, 0, 0, 0, 0);
	return 1;
}
strtok(const string[], &index)
{
	new length = strlen(string);
	while ((index < length) && (string[index] <= ' '))
	{
		index++;
	}

	new offset = index;
	new result[20];
	while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}
stock SendBirlikMessage(factionid, color, const str[], {Float,_}:...)
{
	static
	    args,
	    start,
	    end,
	    string[144]
	;
	#emit LOAD.S.pri 8
	#emit STOR.pri args

	if (args > 12)
	{
		#emit ADDR.pri str
		#emit STOR.pri start

	    for (end = start + (args - 12); end > start; end -= 4)
		{
	        #emit LREF.pri end
	        #emit PUSH.pri
		}
		#emit PUSH.S str
		#emit PUSH.C 144
		#emit PUSH.C string
		#emit PUSH.C args

		#emit SYSREQ.C format
		#emit LCTRL 5
		#emit SCTRL 4

		foreach (new i : Player) if (PlayerData[i][pFaction] == factionid && PlayerData[i][pAyarlar][0] == 0) {
		    SendClientMessage(i, color, string);
		}
		return 1;
	}
	foreach (new i : Player) if (PlayerData[i][pFaction] == factionid && PlayerData[i][pAyarlar][0] == 0) {
 		SendClientMessage(i, color, str);
	}
	return 1;
}
stock BirlikUyeSayisi(birlikid)
{
	new query[100],Cache: _query;
	format(query,sizeof(query), "SELECT null FROM `oyuncular` WHERE `Birlik` = '%d'",birlikid);
	_query = mysql_query(g_SQL,query);
	new rows;
	cache_get_row_count(rows);
	cache_delete(_query);
	return rows;
}
Birlik_GetName(playerid)
{
    new
		factionid = PlayerData[playerid][pFaction],
		name[32] = "Yok";

 	if (factionid == -1)
	    return name;

	format(name, 32, Birlikler[factionid][birlikAd]);
	return name;
}
Birlik_GetDivizyon(playerid)
{
    new
		factionid = PlayerData[playerid][pFaction],
		diviz[32] = "Yok";

 	if (factionid == -1)
	    return diviz;

    if (PlayerData[playerid][pFactionDivizyon] == 0)
	    return diviz;

	format(diviz, 32, BirlikDivizyon[factionid][PlayerData[playerid][pFactionDivizyon] - 1]);
	return diviz;
}
Birlik_GetRutbe(playerid)
{
    new
		factionid = PlayerData[playerid][pFaction],
		rank[32] = "Yok";

 	if (factionid == -1)
	    return rank;

	format(rank, 32, BirlikRutbe[factionid][PlayerData[playerid][pFactionRutbe] - 1]);
	return rank;
}

stock Birlik_Kaydet(bid)
{
	static query[2700];
	format(query,sizeof(query), "UPDATE `birlikler` SET `bisim` = '%s',`brenk` = '%d',`btip` = '%d',`bRutbeler` = '%d',`bduyuru` = '%s',`bkasacash` = '%d',`oocdurum` = '%d', `sistemselonay` = '%d', `silahonay` = '%d', `uyusturucuonay` = '%d', `graffitionay` = '%d', `hoodonay` = '%d'",
	SQL_ReturnEscaped(Birlikler[bid][birlikAd]),
	Birlikler[bid][birlikColor],
	Birlikler[bid][birlikTip],
	Birlikler[bid][birlikRutbeler],
	SQL_ReturnEscaped(Birlikler[bid][birlikDuyuru]),
	Birlikler[bid][birlikKasaPara],
	Birlikler[bid][OOCDurum],
	Birlikler[bid][birlikOnaylar][0],
	Birlikler[bid][birlikOnaylar][1],
	Birlikler[bid][birlikOnaylar][2],
	Birlikler[bid][birlikOnaylar][3],
	Birlikler[bid][birlikOnaylar][4]
	);
	format(query,sizeof(query), "%s, `byetki1` = '%d',`byetki2` = '%d',`byetki3` = '%d',`byetki4` = '%d',`byetki5` = '%d',`byetki6` = '%d',`byetki7` = '%d',`byetki8` = '%d',`bdivizyon1` = '%s',`bdivizyon2` = '%s',`bdivizyon3` = '%s',`bdivizyon4` = '%s',`bdivizyon5` = '%s'",
	query,
	Birlikler[bid][birlikYetkilendirme][0],
	Birlikler[bid][birlikYetkilendirme][1],
	Birlikler[bid][birlikYetkilendirme][2],
	Birlikler[bid][birlikYetkilendirme][3],
	Birlikler[bid][birlikYetkilendirme][4],
	Birlikler[bid][birlikYetkilendirme][5],
	Birlikler[bid][birlikYetkilendirme][6],
	Birlikler[bid][birlikYetkilendirme][7],
	SQL_ReturnEscaped(BirlikDivizyon[bid][0]),
	SQL_ReturnEscaped(BirlikDivizyon[bid][1]),
	SQL_ReturnEscaped(BirlikDivizyon[bid][2]),
	SQL_ReturnEscaped(BirlikDivizyon[bid][3]),
	SQL_ReturnEscaped(BirlikDivizyon[bid][4])
	);
	format(query, sizeof(query), "%s, `yayindurum` = '%d', `yayintipi` = '%d', `reklamalimi` = '%d', `reklamucreti` = '%d', `reklamsayisi` = '%d', `aktifdinleyici` = '%d', `BirlikUyeSayisi` = '%d', `reklamx` = '%f', `reklamy` = '%f', `reklamz` = '%f'",query,Birlikler[bid][yayinDurum], Birlikler[bid][yayinTipi],Birlikler[bid][ReklamAlimi],Birlikler[bid][ReklamUcreti], Birlikler[bid][ReklamSayisi], Dinleyici_Sayisi(bid), BirlikUyeSayisi(bid),
	Birlikler[bid][reklamPos][0], Birlikler[bid][reklamPos][1], Birlikler[bid][reklamPos][2]);
	format(query, sizeof(query), "%s, `brutbe1` = '%s', `brutbe2` = '%s', `brutbe3` = '%s', `brutbe4` = '%s', `brutbe5` = '%s', `brutbe6` = '%s', `brutbe7` = '%s', `brutbe8` = '%s', `brutbe9` = '%s', `brutbe10` = '%s', `brutbe11` = '%s', `brutbe12` = '%s', `brutbe13` = '%s', `brutbe14` = '%s', `brutbe15` = '%s' WHERE `bid` = '%d'",
	query,
	BirlikRutbe[bid][0],
 	BirlikRutbe[bid][1],
  	BirlikRutbe[bid][2],
   	BirlikRutbe[bid][3],
    BirlikRutbe[bid][4],
    BirlikRutbe[bid][5],
    BirlikRutbe[bid][6],
    BirlikRutbe[bid][7],
    BirlikRutbe[bid][8],
    BirlikRutbe[bid][9],
    BirlikRutbe[bid][10],
    BirlikRutbe[bid][11],
    BirlikRutbe[bid][12],
    BirlikRutbe[bid][13],
    BirlikRutbe[bid][14],
    Birlikler[bid][birlikID]
    );
    mysql_query(g_SQL,query, false);
    return 1;
}
stock House_RemoveFurniture(houseid)
{
	if (HouseInfo[houseid][evExists])
	{
	    static
	        string[64];

	    foreach (new i: Mobilyalar[houseid])
	    {
	        FurnitureData[houseid][i][furnitureModel] = 0;

	        DestroyDynamicObject(FurnitureData[houseid][i][furnitureObject]);

	        Iter_SafeRemove(Mobilyalar[houseid], i, i);
		}

		format(string, sizeof(string), "DELETE FROM `furniture` WHERE `ID` = '%d'", HouseInfo[houseid][evID]);
		mysql_query(g_SQL, string, false);
	}
	return 1;
}
stock Ev_GetID(house)
{
	for (new i; i<MAX_EV; i++) if (HouseInfo[i][evExists] && HouseInfo[i][evID] == house)
	{
	    return i;
	}
	return -1;
}

stock EvKiraID(playerid)
{
	for (new i; i < MAX_EV; i++) if (HouseInfo[i][evExists])
	{
	    if (HouseInfo[i][evKiralayan] == PlayerData[playerid][pID])
	    {
	        return i;
	    }
	}
	return -1;
}
stock OfflineParaVer(sqlid, para)
{
    new query[256];
    format(query, sizeof(query), "UPDATE `oyuncular` SET `Cash` = `Cash`+%d WHERE `ID` = '%d'", para, sqlid);
    mysql_query(g_SQL,query, false);
    return 1;
}
stock GetPlayerSQLIDWithName(name[])
{
	new query[150];
	format(query,sizeof(query), "SELECT `ID` FROM `oyuncular` WHERE `Isim` = '%s'",name);
	new Cache:Radless = mysql_query(g_SQL,query);
	new rows;
	cache_get_row_count(rows);
	if (rows)
	{
	    new id;
	    cache_get_value_name_int(0, "ID",id);
	    cache_delete(Radless);
	    return id;
	}
	cache_delete(Radless);
	return -1;
}
stock GetPlayerIDWithSQLID(sqlid)
{
	foreach (new i:Player)
	{
	    if (PlayerData[i][pID] == sqlid)
	    {
	        return i;
	    }
	}
	return -1;
}
stock Ev_GetWeaponCount(evid)
{
	new count = 0;
	if (evid != -1 && HouseInfo[evid][evExists])
	{
	    for (new i; i<10; i++)
	    {
	        if (HouseInfo[evid][evSilahlar][i] > 0)
	        {
	            count++;
	        }
	    }
	}
	return count;
}
stock Isyeri_GetCount(playerid)
{
	new
		count = 0;

	for (new i = 0; i != MAX_ISYERI; i ++)
	{
		if (Isyeri[i][isyeriExists] && Isyeri[i][isyeriSahip] == PlayerData[playerid][pID])
   		{
   		    count++;
		}
	}
	return count;
}
Ev_GetCount(playerid)
{
	new
		count = 0;

	for (new i = 0; i != MAX_EV; i ++)
	{
		if (HouseInfo[i][evExists] && HouseInfo[i][evSahip] == PlayerData[playerid][pID])
   		{
   		    count++;
		}
	}
	return count;
}

stock Ev_Olustur(Float:x,Float:y,Float:z,fiyat, interiorid, mobilya)
{
    for (new i = 0; i != MAX_EV; i ++)
    {
        if (!HouseInfo[i][evExists])
        {
            HouseInfo[i][evExists] = true;
            HouseInfo[i][evID] = i;

            HouseInfo[i][evSahip] = -1;
            HouseInfo[i][evFiyat] = fiyat;
            HouseInfo[i][evKendiFiyati] = fiyat;
            format(HouseInfo[i][evIsim], 30, "Satýlýk Mülk");
            HouseInfo[i][evSatilik] = 0;
            HouseInfo[i][evPos][0] = x;
            HouseInfo[i][evPos][1] = y;
            HouseInfo[i][evPos][2] = z;
            HouseInfo[i][evInterior] = interiorid;
            HouseInfo[i][evKilit] = 0;
            HouseInfo[i][evCash] = 0;
            HouseInfo[i][evVergi] = 0;
            HouseInfo[i][evVergiSure] = 0;
            HouseInfo[i][evKiralik] = 0;
            HouseInfo[i][evKiraUcret] = 0;
            HouseInfo[i][evKiralayan] = -1;
            HouseInfo[i][evUyusturucu] = 0;
            HouseInfo[i][evMaksMobilya] = mobilya;
            HouseInfo[i][MobilyaYetki] = -1;

			for (new j; j < 10; j++)
            {
                if (j < 5)
                {
                    HouseInfo[i][evKiyafetler][j] = 0;
                }
                HouseInfo[i][evSilahlar][j] = 0;
                HouseInfo[i][evMermiler][j] = 0;
            }

			new query[256];

			mysql_format(g_SQL, query, sizeof query, "INSERT INTO `evler` (`evid`, `evOwner`) VALUES ('%d', '-1')", HouseInfo[i][evID]);
			mysql_query (g_SQL, query);

            Ev_Yenile(HouseInfo[i][evID]);
            Ev_Kaydet(HouseInfo[i][evID]);
            return HouseInfo[i][evID];
        }
    }
    return -1;
}

stock trcar(car[]) {
  new tmp[300];
  set(tmp,car);
  tmp=strreplace("ð", "g",tmp);
  tmp=strreplace("|", "",tmp);
  tmp=strreplace("Ð", "G",tmp);
  tmp=strreplace("þ", "s",tmp);
  tmp=strreplace("Þ", "S",tmp);
  tmp=strreplace("ý", "i",tmp);
  tmp=strreplace("I", "I",tmp);
  tmp=strreplace("Ý", "I",tmp);
  tmp=strreplace("ö", "o",tmp);
  tmp=strreplace("Ö", "O",tmp);
  tmp=strreplace("ç", "c",tmp);
  tmp=strreplace("Ç", "C",tmp);
  tmp=strreplace("ü", "u",tmp);
  tmp=strreplace("Ü", "U",tmp);
  return tmp;
}
stock set(dest[],source[]) {
	new count = strlen(source);
	new i=0;
	for (i=0;i<count;i++) {
		dest[i]=source[i];
	}
	dest[count]=0;
}
stock strreplace(trg[],newstr[],src[]) {
    new f=0;
    new s1[256];
    new tmp[256];
    format(s1,sizeof(s1), "%s",src);
    f = strfind(s1,trg);
    tmp[0]=0;
    while (f>=0) {
        strcat(tmp,ret_memcpy(s1, 0, f));
        strcat(tmp,newstr);
        format(s1,sizeof(s1), "%s",ret_memcpy(s1, f+strlen(trg), strlen(s1)-f));
        f = strfind(s1,trg);
    }
    strcat(tmp,s1);
    return tmp;
}
ret_memcpy(source[],index=0,numbytes) {
	new tmp[256];
	new i=0;
	tmp[0]=0;
	if (index>=strlen(source)) return tmp;
	if (numbytes+index>=strlen(source)) numbytes=strlen(source)-index;
	if (numbytes<=0) return tmp;
	for (i=index;i<numbytes+index;i++) {
		tmp[i-index]=source[i];
		if (source[i]==0) return tmp;
	}
	tmp[numbytes]=0;
	return tmp;
}

stock IsSpeedoVehicle(vehicleid)
{
	if (GetVehicleModel(vehicleid) == 509 || GetVehicleModel(vehicleid) == 510 || GetVehicleModel(vehicleid) == 481 || !IsEngineVehicle(vehicleid)) {
	    return 0;
	}
	return 1;
}
stock GetWeapon(playerid)
{
	new weaponid = GetPlayerWeapon(playerid);

	if (1 <= weaponid <= 46 && PlayerData[playerid][pSilahlar][g_aWeaponSlots[weaponid]] == weaponid)
 		return weaponid;

	return 0;
}
stock GetWeaponModel(weaponid) {
    new const g_aWeaponModels[] = {
		0, 331, 333, 334, 335, 336, 337, 338, 339, 341, 321, 322, 323, 324,
		325, 326, 342, 343, 344, 0, 0, 0, 346, 347, 348, 349, 350, 351, 352,
		353, 355, 356, 372, 357, 358, 359, 360, 361, 362, 363, 364, 365, 366,
		367, 368, 368, 371
    };
    if (1 <= weaponid <= 46)
        return g_aWeaponModels[weaponid];

	return 0;
}
stock Garaj_Sil(id)
{
	if (id != -1 && GarageData[id][gExists] == true)
	{
	    new query[70];
	    format(query, sizeof(query), "DELETE FROM `garajlar` WHERE `ID` = '%d'", GarageData[id][gID]);
	    mysql_query(g_SQL, query, false);
	    for (new i; i<MAX_ARAC; i++) if (AracInfo[i][aracExists] && AracInfo[i][aracGaraj] == id)
	    {
	        AracInfo[i][aracGaraj] = -1;
	    }
	    DestroyDynamicPickup(GarageData[id][gPickup]);
	    DestroyDynamic3DTextLabel(GarageData[id][gText]);

	    GarageData[id][gExists] = false;
	    GarageData[id][gID] = 0;
	}
	return 1;
}
stock Gate_Sil(gateid)
{
	if (gateid != -1 && GateData[gateid][gateExists])
	{
		new
		    query[64];

		format(query, sizeof(query), "DELETE FROM `gates` WHERE `gateID` = '%d'", GateData[gateid][gateID]);
		mysql_tquery(g_SQL, query);

		if (IsValidDynamicObject(GateData[gateid][gateObject]))
		    DestroyDynamicObject(GateData[gateid][gateObject]);

		for (new i = 0; i != MAX_GATES; i ++) if (GateData[i][gateExists] && GateData[i][gateLinkID] == GateData[gateid][gateID]) {
		    GateData[i][gateLinkID] = -1;
		    Gate_Save(i);
		}
		if (GateData[gateid][gateOpened] && GateData[gateid][gateTime] > 0) {
		    KillTimer(GateData[gateid][gateTimer]);
		}
	    GateData[gateid][gateExists] = false;
	    GateData[gateid][gateID] = 0;
	    GateData[gateid][gateOpened] = 0;
	}
	return 1;
}
stock Gate_Operate(gateid)
{
	if (gateid != -1 && GateData[gateid][gateExists])
	{
	    new id = -1;
		new playerid;

		if (!GateData[gateid][gateOpened])
		{
		    GateData[gateid][gateOpened] = true;
		    PlayerPlaySound(playerid, 1137, 0.0, 0.0, 0.0);
		    MoveDynamicObject(GateData[gateid][gateObject], GateData[gateid][gateMove][0], GateData[gateid][gateMove][1], GateData[gateid][gateMove][2], GateData[gateid][gateSpeed], GateData[gateid][gateMove][3], GateData[gateid][gateMove][4], GateData[gateid][gateMove][5]);

            if (GateData[gateid][gateTime] > 0) {
				GateData[gateid][gateTimer] = SetTimerEx("CloseGate", GateData[gateid][gateTime], false, "ddfffffff", gateid, GateData[gateid][gateLinkID], GateData[gateid][gatePos][0], GateData[gateid][gatePos][1], GateData[gateid][gatePos][2], GateData[gateid][gateSpeed], GateData[gateid][gatePos][3], GateData[gateid][gatePos][4], GateData[gateid][gatePos][5]);
			}
			if (GateData[gateid][gateLinkID] != -1 && (id = GetGateByID(GateData[gateid][gateLinkID])) != -1)
			{
			    GateData[id][gateOpened] = true;
			    PlayerPlaySound(playerid, 1137, 0.0, 0.0, 0.0);
				MoveDynamicObject(GateData[id][gateObject], GateData[id][gateMove][0], GateData[id][gateMove][1], GateData[id][gateMove][2], GateData[id][gateSpeed], GateData[id][gateMove][3], GateData[id][gateMove][4], GateData[id][gateMove][5]);
			}
		}
		else if (GateData[gateid][gateOpened])
		{
		    GateData[gateid][gateOpened] = false;
		    PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
			MoveDynamicObject(GateData[gateid][gateObject], GateData[gateid][gatePos][0], GateData[gateid][gatePos][1], GateData[gateid][gatePos][2], GateData[gateid][gateSpeed], GateData[gateid][gatePos][3], GateData[gateid][gatePos][4], GateData[gateid][gatePos][5]);

            if (GateData[gateid][gateTime] > 0) {
				KillTimer(GateData[gateid][gateTimer]);
		    }
			if (GateData[gateid][gateLinkID] != -1 && (id = GetGateByID(GateData[gateid][gateLinkID])) != -1)
			{
			    GateData[id][gateOpened] = false;
				PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
			    MoveDynamicObject(GateData[id][gateObject], GateData[id][gatePos][0], GateData[id][gatePos][1], GateData[id][gatePos][2], GateData[id][gateSpeed], GateData[id][gatePos][3], GateData[id][gatePos][4], GateData[id][gatePos][5]);
			}
		}
	}
	return 1;
}
stock GetGateByID(sqlid)
{
	for (new i = 0; i != MAX_GATES; i ++) if (GateData[i][gateExists] && GateData[i][gateID] == sqlid)
	    return i;

	return -1;
}

Gate_Nearest(playerid)
{
    for (new i = 0; i != MAX_GATES; i ++) if (GateData[i][gateExists] && IsPlayerInRangeOfPoint(playerid, GateData[i][gateRadius], GateData[i][gatePos][0], GateData[i][gatePos][1], GateData[i][gatePos][2]))
	{
		if (GetPlayerInterior(playerid) == GateData[i][gateInterior] && GetPlayerVirtualWorld(playerid) == GateData[i][gateWorld])
			return i;
	}
	return -1;
}

ReturnVehicleModelName(model)
{
	new
	    name[32] = "None";

    if (model < 400 || model > 611)
	    return name;

	format(name, sizeof(name), g_arrVehicleNames[model - 400]);
	return name;
}
stock IsValidObjectModel(input) {

switch (input) {
case 615..661: {
return true;
}
case 664: {
return true;
}
case 669..698: {
return true;
}
case 700..792: {
return true;
}
case 800..906: {
return true;
}
case 910..964: {
return true;
}
case 966..998: {
return true;
}
case 1000..1193: {
return true;
}
case 1207..1325: {
return true;
}
case 1327..1572: {
return true;
}
case 1574..1698: {
return true;
}
case 1700..2882: {
return true;
}
case 2885..3135: {
return true;
}
case 3167..3175: {
return true;
}
case 3178: {
return true;
}
case 3187: {
return true;
}
case 3193: {
return true;
}
case 3214: {
return true;
}
case 3221: {
return true;
}
case 3241..3244: {
return true;
}
case 3246: {
return true;
}
case 3249..3250: {
return true;
}
case 3252..3253: {
return true;
}
case 3255..3265: {
return true;
}
case 3267..3347: {
return true;
}
case 3350..3415: {
return true;
}
case 3417..3428: {
return true;
}
case 3430..3609: {
return true;
}
case 3612..3783: {
return true;
}
case 3785..3869: {
return true;
}
case 3872..3882: {
return true;
}
case 3884..3888: {
return true;
}
case 3890..3973: {
return true;
}
case 3975..4541: {
return true;
}
case 4550..4762: {
return true;
}
case 4806..5084: {
return true;
}
case 5086..5089: {
return true;
}
case 5105..5375: {
return true;
}
case 5390..5682: {
return true;
}
case 5703..6010: {
return true;
}
case 6035..6253: {
return true;
}
case 6255..6257: {
return true;
}
case 6280..6347: {
return true;
}
case 6349..6525: {
return true;
}
case 6863..7392: {
return true;
}
case 7415..7973: {
return true;
}
case 7978..9193: {
return true;
}
case 9205..9267: {
return true;
}
case 9269..9478: {
return true;
}
case 9482..10310: {
return true;
}
case 10315..10744: {
return true;
}
case 10750..11417: {
return true;
}
case 11420..11753: {
return true;
}
case 12800..13563: {
return true;
}
case 13590..13667: {
return true;
}
case 13672..13890: {
return true;
}
case 14383..14528: {
return true;
}
case 14530..14554: {
return true;
}
case 14556: {
return true;
}
case 14558..14643: {
return true;
}
case 14650..14657: {
return true;
}
case 14660..14695: {
return true;
}
case 14699..14728: {
return true;
}
case 14735..14765: {
return true;
}
case 14770..14856: {
return true;
}
case 14858..14883: {
return true;
}
case 14885..14898: {
return true;
}
case 14900..14903: {
return true;
}
case 15025..15064: {
return true;
}
case 16000..16790: {
return true;
}
case 17000..17474: {
return true;
}
case 17500..17974: {
return true;
}
case 17976: {
return true;
}
case 17978: {
return true;
}
case 18000..18036: {
return true;
}
case 18038..18102: {
return true;
}
case 18104..18105: {
return true;
}
case 18109: {
return true;
}
case 18112: {
return true;
}
case 18200..18859: {
return true;
}
case 18862..19198: {
return true;
}
case 19200..19274: {
return true;
}
case 19277..19595: {
return true;
}
case 19597..19999: {
return true;
}
}

return false;

}

stock Gate_Create(Float:x,Float:y,Float:z,Float:angle,interior,world)
{
    for (new i = 0; i < MAX_GATES; i ++) if (!GateData[i][gateExists])
    {
   		GateData[i][gateExists] = true;
    	GateData[i][gateID] = i;

		GateData[i][gateModel] = 980;
		GateData[i][gateSpeed] = 3.0;
		GateData[i][gateRadius] = 5.0;
		GateData[i][gateOpened] = 0;
		GateData[i][gateTime] = 0;

		GateData[i][gatePos][0] = x + (3.0 * floatsin(-angle, degrees));
		GateData[i][gatePos][1] = y + (3.0 * floatcos(-angle, degrees));
		GateData[i][gatePos][2] = z;
		GateData[i][gatePos][3] = 0.0;
		GateData[i][gatePos][4] = 0.0;
		GateData[i][gatePos][5] = angle;

		GateData[i][gateMove][0] = x + (3.0 * floatsin(-angle, degrees));
		GateData[i][gateMove][1] = y + (3.0 * floatcos(-angle, degrees));
		GateData[i][gateMove][2] = z - 10.0;
		GateData[i][gateMove][3] = -1000.0;
		GateData[i][gateMove][4] = -1000.0;
		GateData[i][gateMove][5] = -1000.0;

		GateData[i][gateInterior] = interior;
  		GateData[i][gateWorld] = world;

		GateData[i][gateLinkID] = -1;
  		GateData[i][gateOwner] = -1;
  		GateData[i][gateFaction] = -1;
		GateData[i][gateVip] = 0;

		GateData[i][gatePass][0] = '\0';
  		GateData[i][gateObject] = CreateDynamicObject(GateData[i][gateModel], GateData[i][gatePos][0], GateData[i][gatePos][1], GateData[i][gatePos][2], GateData[i][gatePos][3], GateData[i][gatePos][4], GateData[i][gatePos][5], GateData[i][gateWorld], GateData[i][gateInterior]);

		new query[256];

		mysql_format(g_SQL, query, sizeof query, "INSERT INTO `gates` (`gateID`, `gateModel`) VALUES ('%d', '980')", GateData[i][gateID]);
		mysql_query (g_SQL, query);

		Gate_Save(GateData[i][gateID]);
		return i;
    }
    return -1;
}
stock Garage_Nearest(playerid)
{
	for (new i = 0; i != MAX_GARAGE; i++) if (GarageData[i][gExists] && IsPlayerInRangeOfPoint(playerid, 3.0, GarageData[i][gPos][0], GarageData[i][gPos][1], GarageData[i][gPos][2]))
	{
	    return i;
	}
	return -1;
}
stock Garage_Inside(playerid, bool:option = false)
{
	if (PlayerData[playerid][pGarage] != -1)
	{
	    for (new i = 0; i < MAX_GARAGE; i++) if (GarageData[i][gExists] && PlayerData[playerid][pGarage] == i)
	    {
	        if(!option)
	            return i;

			if(option)
			{
		        if(IsPlayerInRangeOfPoint(playerid, 3.0, GarageInteriors[GarageData[i][gInterior]][intX], GarageInteriors[GarageData[i][gInterior]][intY], GarageInteriors[GarageData[i][gInterior]][intZ]))
		        	return i;
			}
	    }
	}
	return -1;
}

stock House_Nearest(playerid)
{
    for (new i = 0; i != MAX_EV; i ++) if (HouseInfo[i][evExists] && GetPlayerVirtualWorld(playerid) == 0 && IsPlayerInRangeOfPoint(playerid, 2.5, HouseInfo[i][evPos][0], HouseInfo[i][evPos][1],HouseInfo[i][evPos][2]))
	{
			return i;
	}
	return -1;
}

stock House_Inside(playerid, bool:option = false)
{
	if (PlayerData[playerid][pHouse] != -1)
	{
	    for (new i = 0; i < MAX_EV; i ++)
	    {
			if (HouseInfo[i][evExists] && HouseInfo[i][evID] == PlayerData[playerid][pHouse] && GetPlayerInterior(playerid) == HouseInteriors[HouseInfo[i][evInterior]][intID] && GetPlayerVirtualWorld(playerid) > 0)
			{
			    if(!option)
			        return i;

				if(option)
				{
				    if(IsPlayerInRangeOfPoint(playerid, 2.5, HouseInteriors[HouseInfo[i][evInterior] ][intX], HouseInteriors[HouseInfo[i][evInterior] ][intY], HouseInteriors[HouseInfo[i][evInterior] ][intZ]))
			        	return i;
				}
			}
		}
	}
	return -1;
}
stock OzelKarakter(yazi[])
{
    for (new i = 0; i < strlen(yazi); i++)
	{
		switch (yazi[i])
		{
			case '!', '@', '#', '$','%','^','&','*','(',')','_','+','=','|','[',']','{','}','-','.','`','~','<','>','?',',','/': return 1;
			default: continue;
		}
	}
	return 0;
}
stock Obje_Kaydet(objeid)
{
	static query[1280];
	format(query, sizeof(query), "UPDATE `objeler` SET `objeModel` = '%d', `objeX` = '%.4f', `objeY` = '%.4f', `objeZ` = '%.4f', `objeRX` = '%.4f', `objeRY` = '%.4f', `objeRZ` = '%.4f', `objeData` = '%d' WHERE `objeID` = '%d'",
		Obje[objeid][objeModelID],
	    Obje[objeid][objePos][0],
	    Obje[objeid][objePos][1],
	    Obje[objeid][objePos][2],
	    Obje[objeid][objePos][3],
	    Obje[objeid][objePos][4],
	    Obje[objeid][objePos][5],
	    Obje[objeid][objeData],
	    Obje[objeid][objeID]
	);
	return mysql_tquery(g_SQL, query);
}

Gate_Save(gateid)
{
	new
	    query[1024];

	format(query, sizeof(query), "UPDATE `gates` SET `gateModel` = '%d', `gateSpeed` = '%.4f', `gateRadius` = '%.4f', `gateFaction` = '%d',  `gateTime` = '%d', `gateX` = '%.4f', `gateY` = '%.4f', `gateZ` = '%.4f', `gateRX` = '%.4f', `gateRY` = '%.4f', `gateRZ` = '%.4f', `gateInterior` = '%d', `gateWorld` = '%d', `gateMoveX` = '%.4f', `gateMoveY` = '%.4f', `gateMoveZ` = '%.4f', `gateMoveRX` = '%.4f', `gateMoveRY` = '%.4f', `gateMoveRZ` = '%.4f', `gateLinkID` = '%d'",
	    GateData[gateid][gateModel],
	    GateData[gateid][gateSpeed],
	    GateData[gateid][gateRadius],
	    GateData[gateid][gateFaction],
	    GateData[gateid][gateTime],
	    GateData[gateid][gatePos][0],
	    GateData[gateid][gatePos][1],
	    GateData[gateid][gatePos][2],
	    GateData[gateid][gatePos][3],
	    GateData[gateid][gatePos][4],
	    GateData[gateid][gatePos][5],
	    GateData[gateid][gateInterior],
	    GateData[gateid][gateWorld],
	    GateData[gateid][gateMove][0],
	    GateData[gateid][gateMove][1],
	    GateData[gateid][gateMove][2],
	    GateData[gateid][gateMove][3],
	    GateData[gateid][gateMove][4],
	    GateData[gateid][gateMove][5],
	    GateData[gateid][gateLinkID]
	);
	format(query, sizeof(query), "%s, `gateOwner` = '%d', `gatePass` = '%s' WHERE `gateID` = '%d'",
	    query,
	    GateData[gateid][gateOwner],
	    SQL_ReturnEscaped(GateData[gateid][gatePass]),
	    GateData[gateid][gateID]
	);
	 mysql_query(g_SQL, query, false);

	mysql_format(g_SQL, query, sizeof query, "UPDATE `gates` SET `VIP` = '%d' WHERE `gateID` = '%d'", GateData[gateid][gateVip], GateData[gateid][gateID]);
	mysql_query (g_SQL, query);
}

stock DestekGuncelle(playerid)
{
	if (PlayerData[playerid][pDestek] > 0)
	{
	    new Float:pos[3];
 		GetPlayerPos(playerid, pos[0], pos[1], pos[2]);

		foreach (new i : Player)
 		{
 		    if (GetFactionType(i) == BIRLIK_LSPD || GetFactionType(i) == BIRLIK_FBI)
 		    {
 		        if (i != playerid)
 		        {
 		        	callcmd::cpsifirla(i);
					SetPlayerCheckpoint(i, pos[0], pos[1], pos[2], 2.5);
 		            SetPlayerMarkerForPlayer(i, playerid, 0xFF0000FF);
 		        }
 		    }
 		}
	}
}

stock DestekKapat(playerid, calledbytimer)
{
	if (OyundaDegil(playerid))
	{
	    foreach (new i:Player)
	    {
	        if (GetFactionType(i) == BIRLIK_LSPD || GetFactionType(i) == BIRLIK_FBI)
	        {
	            SetPlayerMarkerForPlayer(i, playerid, COLOR_RADIO);
				DisablePlayerCheckpoint(i);
	        }
	    }
	    PlayerData[playerid][pDestek] = 0;
	    if (calledbytimer != 1) MesajGonder(playerid, "Destek isteði kapatýldý.");
	    else MesajGonder(playerid, "Destek isteði otomatik olarak kapatýldý.");
	}
}

stock ToplamOnlineOyuncu()
{
	return Iter_Count(Player);
}

stock getDate()
{
	new Tarih[3], m[256];
	getdate(Tarih[0], Tarih[1], Tarih[2]);

	format(m, sizeof m, "%d/%d/%d", Tarih[2], Tarih[1], Tarih[0]);
	return m;
}

stock getTime()
{
	new Saat[3], m[256];
	gettime(Saat[0], Saat[1], Saat[2]);

	format(m, sizeof m, "%02d:%02d", Saat[0], Saat[1]);
	return m;
}

StopLoopingAnim(playerid)
{
	PlayerData[playerid][pLoopAnim] = false;
    ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0, 1);
    ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0, 1);
    return 1;
}

stock GetElapsedTime(time, &hours, &minutes, &seconds)
{
	hours = 0;
	minutes = 0;
	seconds = 0;

	if (time >= 3600)
	{
		hours = (time / 3600);
		time -= (hours * 3600);
	}
	while (time >= 60)
	{
	    minutes++;
	    time -= 60;
	}
	return (seconds = time);
}

stock SQL_ReturnEscaped(const string[])
{
	new
	    entry[256];

	mysql_escape_string(string, entry, sizeof(entry) , g_SQL);
	return entry;
}

stock GetAdminRank(playerid)
{
	new rank[20];

	if(PlayerData[playerid][pAdmin] > 0)
	{
		switch (PlayerData[playerid][pAdmin])
		{
		    case 1: rank = "Game Admin";
		    case 2: rank = "Senior Admin";
		    case 3: rank = "High Senior Admin";
		    case 4: rank = "Lead Admin";
		    case 5: rank = "Management";
		    default: rank = "Yok";
		}
	}

	else if(PlayerData[playerid][pOyunGorevlisi] > 0)
		rank = "Oyun Görevlisi";

	else if(PlayerData[playerid][pForumGorevlisi] > 0)
		rank = "Forum Görevlisi";

	else rank = "Yok";

	return rank;
}
stock PanelUpdate()
{
	new Cache:Radless = mysql_query(g_SQL, "SELECT * FROM `panelislemleri`");
	new rows;
	cache_get_row_count(rows);
	if (rows)
	{
	    new uygulayan[24], sebep[50], oyuncuadi[24], sure, islemturu;
	    for (new i; i<rows; i++)
	    {
	        cache_get_value_name(i, "Uygulayan", uygulayan, 24);
	        cache_get_value_name(i, "Sebep", sebep, 50);
	        cache_get_value_name(i, "Oyuncu", oyuncuadi, 24);
	        cache_get_value_name_int(i, "Sure", sure);
	        cache_get_value_name_int(i, "islemturu", islemturu);
	        new id = GetPlayerID(oyuncuadi);
	        if (islemturu == 1)
	        {
				if (id != -1)
				{
				    new pip[20];
				    GetPlayerIp(id, pip, sizeof(pip));
				    foreach (new p: Player)
					{
				        new ipp[15];
				        GetPlayerIp(p, ipp, sizeof(ipp));
				        if (!strcmp(pip, ipp) && p != id)
				        {
				            Kick(p);
				        }
				    }
				    new suree[10];
				    if (sure == 0) suree = "Sýnýrsýz";
				    else format(suree, sizeof(suree), "%d gün", sure);
				    Dialog_Show(id, Banli, DIALOG_STYLE_MSGBOX, "Yasaklandýnýz!", "Hesabýnýz panelden yasaklanmýþtýr. Detaylar;\n\nKarakter Adý: %s\nSebep: %s\nYasaklayan: %s\nSüre: %s\nF8 tuþuna basýn ve bir ekran görüntüsü alýn, bu ekran görüntüsü ile forumumuzdan yasaklanmanýza itiraz edebilirsiniz.", "Kapat", "", Player_GetName(id), sebep, uygulayan, suree);
				    new query[300];
				    format(query, sizeof(query), "INSERT INTO `oocsicil` (`ID`, `Tarih`, `Sebep`, `Uygulayan`, `Tur`) VALUES('%d', '%s', '%s', '%s', '2')",  PlayerData[id][pID], ReturnDate(), sebep, uygulayan);
				    mysql_tquery(g_SQL, query);
				    foreach (new pl:Player) if (PlayerData[pl][pAyarlar][3] == 0)
				    {
				    	if (sure == 0) SendClientMessageEx(pl, COLOR_LIGHTRED, "(%s) - (( %s adlý oyuncu %s tarafýndan panelden %s sebebiyle sýnýrsýz yasaklandý. ))", ReturnDate(), ReturnName(id, 0),  uygulayan, sebep);
				    	else SendClientMessageEx(pl, COLOR_LIGHTRED, "(%s) - (( %s adlý oyuncu %s tarafýndan %s sebebiyle panelden %d gün yasaklandý. ))", ReturnDate(), ReturnName(id, 0),  uygulayan, sebep, sure);
				    }
				    Log_Write("logs/ban_log.txt", "[%s] %s, %s tarafindan panelden %d gun yasaklandi. sebep: %s.", ReturnDate(), ReturnName(id, 0), uygulayan, sure, sebep);
				    AddBan(pip, Player_GetName(id), "", uygulayan, (sure < 1) ? (0) : (gettime()+sure*86400), sebep);
    				Kick(id);
				}
				else
				{
				    new query[124];
    				format(query, sizeof(query), "SELECT * FROM `oyuncular` WHERE `Isim` = '%s'", oyuncuadi);
    				mysql_tquery(g_SQL, query, "OnPanelBanAccount", "ssis", uygulayan, oyuncuadi, sure, sebep);
				}
	        }
	        else if (islemturu == 2)
	        {
	            if (id != -1)
	            {
	                ResetPlayer(id);
				    ResetWeapons(id);
				    ClearAnimations(id);
					PlayerTextDrawShow(id, HapisTD[id]);
					SetPlayerPos(id, 197.6346, 175.3765, 1003.0234);
				    SetPlayerInterior(id, 3);

				    SetPlayerVirtualWorld(id, (id + 100));
				    SetPlayerFacingAngle(id, 0.0);

				    SetCameraBehindPlayer(id);
				    PlayerData[id][pHapisSure] = sure * 60;
				    format(PlayerData[id][pHapisSebep], 50, sebep);
				    format(PlayerData[id][pHapiseAtan], 24, uygulayan);
				    PlayerData[id][pHapis] = 0;
				    new query[500];
				    format(query, sizeof(query), "INSERT INTO `oocsicil` (`ID`, `Tarih`, `Sebep`, `Uygulayan`, `Tur`) VALUES('%d', '%s', '%s', '%s', '3')",  PlayerData[id][pID], ReturnDate(), sebep, uygulayan);
				    mysql_query(g_SQL, query, false);
				    BilgiMesajGonder(id, "%s adlý yetkili seni panelden %d dakika hapse attý. (%s).", uygulayan, sure, sebep);
					foreach (new pla:Player) if (PlayerData[pla][pAyarlar][3] == 0 || pla == id)
					{
				    	SendClientMessageEx(pla, COLOR_LIGHTRED, "(%s)  - (( %s adlý oyuncu %s tarafýndan %s sebebiyle panelden %d dakika cezalandýrýldý. ))", ReturnDate(), ReturnName(id, 0), uygulayan, sebep, sure);
				    }
				    Log_Write("logs/jail_log.txt", "[%s] %s adli yetkili %s adli oyuncuyu panelden %d dakika cezalandirdi,  sebep: %s.", ReturnDate(), uygulayan, ReturnName(id, 0), sure, sebep);
	            }
	            else
	            {
	                new query[800];
	                format(query, sizeof(query), "UPDATE `oyuncular` SET `HapisSure` = '%d', `HapisSebep` = '%s', `HapiseAtan` = '%s'", sure*60, sebep, uygulayan);
	    			for (new i; i<13; i++)
	    			{
	        			format(query, sizeof(query), "%s, `Silah%d` = '0', `Mermi%d` = '0'", query, i+1, i+1);
	    			}
	    			format(query, sizeof(query), "%s WHERE `Isim` = '%s'", query, oyuncuadi);
	    			mysql_query(g_SQL, query, false);
	    			format(query, sizeof(query), "INSERT INTO `oocsicil` (`ID`, `Tarih`, `Sebep`, `Uygulayan`, `Tur`) VALUES('%d', '%s', '%s', '%s', '3')",  GetPlayerSQLIDWithName(oyuncuadi), ReturnDate(), sebep, uygulayan);
   	 				mysql_query(g_SQL, query, false);
	            }
	        }
	    }
	}
	cache_delete(Radless);
	mysql_query(g_SQL, "TRUNCATE `panelislemleri`", false);
	return 1;
}
stock GetHouseVergi(id)
{
	new vergi;
	vergi = floatround(HouseInfo[id][evKendiFiyati]/1000*0.2);
	return vergi;
}
stock Ev_MaksVergi(id)
{
	new vergi;
	vergi = floatround(HouseInfo[id][evKendiFiyati]/3);
	return vergi;
}
stock AracVergiArttir(i)
{
    if (AracInfo[i][aracExists] && AracInfo[i][aracTip] == 4 && AracInfo[i][aracSahip] > 0)
    {
       if (AracInfo[i][aracVergi] < GetAracMaksVergi(AracInfo[i][aracModel]))
       {
            AracInfo[i][aracVergi] += GetAracVergi(AracInfo[i][aracModel]);
            Arac_Kaydet(i);
            if (AracInfo[i][aracVergi] >= GetAracMaksVergi(AracInfo[i][aracModel]))
            {
            	AracInfo[i][aracVergiSure] = gettime()+VERGI_GUN*86400;
             	if (GetPlayerIDWithSQLID(AracInfo[i][aracSahip]) != -1)
              	{
               		BilgiMesajGonder(GetPlayerIDWithSQLID(AracInfo[i][aracSahip]), "%s model aracýnýzýn vergisi doldu, %d gün içerisinde vergiyi ödemezseniz aracýnýz silinecek.", ReturnVehicleModelName(AracInfo[i][aracModel]), VERGI_GUN);
               	}
                else
                {
                	new str[100];
                 	format(str, sizeof(str), "%s model aracýnýzýn vergisi doldu, %d gün içerisinde vergiyi ödemezseniz aracýnýz silinecek.",ReturnVehicleModelName(AracInfo[i][aracModel]), VERGI_GUN);
                  	BildirimEkle(AracInfo[i][aracSahip], str, "Sistem");
				}
			}
        }
        if (AracInfo[i][aracVergi] >= GetAracMaksVergi(AracInfo[i][aracModel]) && AracInfo[i][aracVergiSure] != 0 && AracInfo[i][aracVergiSure] < gettime())
		{
		    new para = 0;
		    if (AracInfo[i][aracVergi] < GetGaleriFiyat(AracInfo[i][aracModel]))
		    {
				para = GetGaleriFiyat(AracInfo[i][aracModel]) - AracInfo[i][aracVergi];
		    }
		    if (GetPlayerIDWithSQLID(AracInfo[i][aracSahip]) != -1)
		    {
				if (para > 0)
				{
				    ParaVer(GetPlayerIDWithSQLID(AracInfo[i][aracSahip]), para);
				    BilgiMesajGonder(GetPlayerIDWithSQLID(AracInfo[i][aracSahip]), "%s model aracýnýzýn vergisini ödemediðiniz için araç silindi. Sistem size %s para iadesinde bulundu.", ReturnVehicleModelName(AracInfo[i][aracModel]), FormatNumber(para));
				}
		        else
		        {
		            BilgiMesajGonder(GetPlayerIDWithSQLID(AracInfo[i][aracSahip]), "%s model aracýnýzýn vergisini ödemediðiniz için araç silindi.", ReturnVehicleModelName(AracInfo[i][aracModel]));
		        }
		    }
		    else
		    {

		        new str[100];
		        if (para > 0) format(str, sizeof(str), "%s model aracýnýzýn vergisini ödemediðiniz için araç silindi. Sistem size %s para iadesinde bulundu.", ReturnVehicleModelName(AracInfo[i][aracModel]), FormatNumber(para));
		        else format(str, sizeof(str), "%s model aracýnýzýn vergisini ödemediðiniz için araç silindi.", ReturnVehicleModelName(AracInfo[i][aracModel]));
		        BildirimEkle(AracInfo[i][aracSahip], str, "Sistem");
		        OfflineParaVer(AracInfo[i][aracSahip], para);
		    }
		    Arac_Sil(i);
		}
    }
    return 1;
}

stock SetEngineStatus(vehicleid, status)
{
	static
	    engine,
	    lights,
	    alarm,
	    doors,
	    bonnet,
	    boot,
	    objective;

	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
	return SetVehicleParamsEx(vehicleid, status, lights, alarm, doors, bonnet, boot, objective);
}

stock GetEngineStatus(vehicleid)
{
	static
	    engine,
	    lights,
	    alarm,
	    doors,
	    bonnet,
	    boot,
	    objective;

	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

	if (engine != 1)
		return 0;

	return 1;
}
stock AracHasar(vehicleid)
{
	if (!IsValidVehicle(vehicleid))
	    return 0;

	static
	    Float:amount;

	GetVehicleHealth(vehicleid, amount);
	return floatround(amount, floatround_round);
}
stock IsEngineVehicle(vehicleid)
{
	static const g_aEngineStatus[] = {
	    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1,
	    1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	    1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	    1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	    1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1,
	    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	    1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	    1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 0, 1, 1, 0, 1, 1, 1, 1, 1,
	    1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 0, 0
	};
    new modelid = GetVehicleModel(vehicleid);

    if (modelid < 400 || modelid > 611)
        return 0;

    return (g_aEngineStatus[modelid - 400]);
}
stock Arac_Sil(carid)
{
    if (carid != -1 && AracInfo[carid][aracExists])
    {
        new query[100];
        format(query,sizeof(query), "DELETE FROM `araclar` WHERE `aracid` = '%d'",AracInfo[carid][aracID]);
        mysql_query(g_SQL,query, false);
        if (Arac_GetKeyCount(carid) > 0)
		{
			format(query, sizeof(query), "DELETE FROM `anahtarlar` WHERE `sqlid` = '%d' AND `tip` = '2'",AracInfo[carid][aracID]);
			mysql_query(g_SQL, query, false);
		}
        if (IsValidVehicle(AracInfo[carid][aracVehicle]))
			DestroyVehicle(AracInfo[carid][aracVehicle]);
		AracInfo[carid][aracExists] = false;
		AracInfo[carid][aracID] = 0;
		AracInfo[carid][aracSahip] = -1;
		AracInfo[carid][aracVehicle] = 0;
    }
}

stock Arac_Olustur(owner, modelid, interior, world, garaj, Float:x,Float:y,Float:z,Float:angle,color1,color2,tip,id)
{
     for (new i = 0; i != MAX_ARAC; i ++)
     {
   		if (!AracInfo[i][aracExists])
   		{
   		    if (color1 == -1)
   		        color1 = random(255);

			if (color2 == -1)
			    color2 = random(255);

			AracInfo[i][aracExists] = true;
			AracInfo[i][aracID] = i;

			AracInfo[i][aracModel] = modelid;
			AracInfo[i][aracSahip] = owner;
			AracInfo[i][aracPos][0] = x;
			AracInfo[i][aracPos][1] = y;
			AracInfo[i][aracPos][2] = z;
			AracInfo[i][aracPos][3] = angle;
			AracInfo[i][aracRenkler][0] = color1;
			AracInfo[i][aracRenkler][1] = color2;
			AracInfo[i][aracPaintjob] = -1;
			AracInfo[i][aracBaglandi] = 0;
			AracInfo[i][aracBaglandiCeza] = 0;
			AracInfo[i][aracTicket] = 0;
			AracInfo[i][aracTicketTime] = 0;
			AracInfo[i][aracKiralayan] = -1;
			AracInfo[i][aracKM] = 0.0;
			AracInfo[i][aracBenzin] = 100.0;
			AracInfo[i][aracTicket] = 0;
			AracInfo[i][aracTicketTime] = 0;
			AracInfo[i][aracElKonuldu] = 0;
			AracInfo[i][aracZirh] = 0;
			AracInfo[i][aracZirhVarMi] = 0;
			AracInfo[i][aracGaraj] = garaj;
			AracInfo[i][aracInterior] = interior;
			AracInfo[i][aracWorld] = world;
			AracInfo[i][aracVergi] = 0;
			AracInfo[i][aracVergiSure] = 0;
			AracInfo[i][TaksiPlaka] = 0;
			AracInfo[i][Taksimetre] = false;
			AracInfo[i][Taksimetre] = 0;
			AracInfo[i][OturumKazanci] = 0;
			AracInfo[i][aracUyusturucu] = 0;
			if (IsValidDynamic3DTextLabel(AracInfo[i][aracLabel]))
			{
			    UpdateDynamic3DTextLabelText(AracInfo[i][aracLabel], -1, " ");
			    DestroyDynamic3DTextLabel(AracInfo[i][aracLabel]);
			}
			switch (tip)
			{
			    case 1:
			    {
			        AracInfo[i][aracFaction] = id;
			        AracInfo[i][aracFactionType] = Birlikler[Birlik_GetID(id)][birlikTip];
			        AracInfo[i][aracKira] = -1;
			        AracInfo[i][aracFiyat] = 0;
			        AracInfo[i][aracSatilik] = 0;
			    }
			    case 2:
			    {
			        AracInfo[i][aracFaction] = -1;
			        AracInfo[i][aracKira] = -1;
			        AracInfo[i][aracSahip] = -1;
			        AracInfo[i][aracFiyat] = 0;
			        AracInfo[i][aracSatilik] = 0;
			    }
			    case 3:
			    {
			        AracInfo[i][aracKira] = id;
			        AracInfo[i][aracFaction] = -1;
			        AracInfo[i][aracFiyat] = 0;
			        AracInfo[i][aracSatilik] = 0;
			    }
			    case 4:
			    {
			        AracInfo[i][aracFiyat] = id;
			        AracInfo[i][aracKira] = -1;
			        AracInfo[i][aracFaction] = -1;
			        if (id > 0) AracInfo[i][aracSatilik] = 1;
			    }
			    case 5:
			    {
			        AracInfo[i][aracFaction] = -1;
			        AracInfo[i][aracKira] = -1;
			        AracInfo[i][aracSahip] = -1;
			        AracInfo[i][aracFiyat] = 0;
			        AracInfo[i][aracSatilik] = 0;
			    }
			    case 6:
			    {
			        AracInfo[i][aracFaction] = -1;
			        AracInfo[i][aracKira] = -1;
			        AracInfo[i][aracSahip] = -1;
			        AracInfo[i][aracFiyat] = 0;
			        AracInfo[i][aracSatilik] = 0;
			    }
			}
			AracInfo[i][aracTip] = tip;

			PlakaOlustur(AracInfo[i][aracID]);
			for (new j = 0; j < 14; j ++)
			{
                if (j < 5)
				{
                    AracInfo[i][aracSilahlar][j] = 0;
                    AracInfo[i][aracMermiler][j] = 0;
                }
                AracInfo[i][aracMods][j] = 0;
            }

            AracInfo[i][aracVehicle] = CreateVehicle(modelid, x, y, z, angle, color1, color2, -1);

            if(tip == 6)
                AracInfo[id][aracLabel] = CreateDynamic3DTextLabel("[KURS ARACI]", COLOR_RED, 0.0, 0.0, 1.0, 30.0, INVALID_PLAYER_ID, AracInfo[i][aracVehicle], 1);

			for (new ob; ob<5; ob++)
			{
	    		if (IsValidDynamicObject(AracTohumObjeler[AracInfo[i][aracVehicle]][ob])) DestroyDynamicObject(AracTohumObjeler[AracInfo[i][aracVehicle]][ob]);
			}

			AracTohumlar[AracInfo[i][aracVehicle]][0] = 0;
			AracTohumlar[AracInfo[i][aracVehicle]][1] = 0;
			AracTohumlar[AracInfo[i][aracVehicle]][2] = 0;

			Arac_Spawn(AracInfo[i][aracID], 1);

            new query[256];

            mysql_format(g_SQL, query, sizeof query, "INSERT INTO `araclar` (`aracid`, `aracmodel`) VALUES ('%d', '%d')", AracInfo[i][aracID], AracInfo[i][aracModel]);
            mysql_query (g_SQL, query);

            Arac_Kaydet(AracInfo[i][aracID]);
            return AracInfo[i][aracID];
   		}
     }
     return -1;
}
stock Birlik_GetID(bid)
{
	for (new i; i<MAX_BIRLIK; i++)
	{
	    if (Birlikler[i][birlikExists] && Birlikler[i][birlikID] == bid) return i;
	}
	return -1;
}

stock Arac_Kaydet(carid)
{
    static
	    query[5000];
	if (AracInfo[carid][aracVehicle] != INVALID_VEHICLE_ID)
	{
	    for (new i = 0; i < 14; i ++) {
			AracInfo[carid][aracMods][i] = GetVehicleComponentInSlot(AracInfo[carid][aracVehicle], i);
	    }
	}

	format(query, sizeof(query), "UPDATE `araclar` SET `aracmodel` = '%d', `aracowner` = '%d', `aracbenzin` = '%.2f', `aracPosX` = '%.4f', `aracPosY` = '%.4f', `aracPosZ` = '%.4f', `aracPosR` = '%.4f', `aracrenk1` = '%d', `aracrenk2` = '%d', `aracpaintjob` = '%d', `aracseviye` = '%d'",
	AracInfo[carid][aracModel],
	AracInfo[carid][aracSahip],
	AracInfo[carid][aracBenzin],
	AracInfo[carid][aracPos][0],
	AracInfo[carid][aracPos][1],
	AracInfo[carid][aracPos][2],
	AracInfo[carid][aracPos][3],
	AracInfo[carid][aracRenkler][0],
	AracInfo[carid][aracRenkler][1],
	AracInfo[carid][aracPaintjob],
	AracInfo[carid][aracSeviye]
	);

	format(query, sizeof(query), "%s, `aracbaglandiceza` = '%d', `aracMod1` = '%d', `aracMod2` = '%d', `aracMod3` = '%d', `aracMod4` = '%d', `aracMod5` = '%d', `aracMod6` = '%d', `aracMod7` = '%d', `aracMod8` = '%d', `aracMod9` = '%d', `aracMod10` = '%d', `aracMod11` = '%d', `aracMod12` = '%d', `aracMod13` = '%d', `aracMod14` = '%d',`aracVergi` = '%d', `VergiSure` = '%d',`aracsatilik` = '%d'",
	query,
	AracInfo[carid][aracBaglandiCeza],
	AracInfo[carid][aracMods][0],
	AracInfo[carid][aracMods][1],
	AracInfo[carid][aracMods][2],
	AracInfo[carid][aracMods][3],
	AracInfo[carid][aracMods][4],
	AracInfo[carid][aracMods][5],
	AracInfo[carid][aracMods][6],
	AracInfo[carid][aracMods][7],
	AracInfo[carid][aracMods][8],
	AracInfo[carid][aracMods][9],
	AracInfo[carid][aracMods][10],
	AracInfo[carid][aracMods][11],
	AracInfo[carid][aracMods][12],
	AracInfo[carid][aracMods][13],
	AracInfo[carid][aracVergi],
	AracInfo[carid][aracVergiSure],
	AracInfo[carid][aracSatilik]
	);
	format(query, sizeof(query), "%s, `aracBaglandi` = '%d', `Ceza` = '%d', `CezaSure` = '%d',  `aracfaction` = '%d',`aracfactiontype` = '%d', `aracSilah1` = '%d', `aracSilah2` = '%d', `aracSilah3` = '%d', `aracSilah4` = '%d', `aracSilah5` = '%d', `aracMermi1` = '%d', `aracMermi2` = '%d', `aracMermi3` = '%d', `aracMermi4` = '%d', `aracMermi5` = '%d', `arackira` = '%d', `aracfiyat` = '%d',`aractip` = '%d' ,`aracplaka` = '%s', `arackm` = '%.1f'",
	query,
	AracInfo[carid][aracBaglandi],
	AracInfo[carid][aracTicket],
	AracInfo[carid][aracTicketTime],
	AracInfo[carid][aracFaction],
	AracInfo[carid][aracFactionType],
	AracInfo[carid][aracSilahlar][0],
	AracInfo[carid][aracSilahlar][1],
	AracInfo[carid][aracSilahlar][2],
	AracInfo[carid][aracSilahlar][3],
	AracInfo[carid][aracSilahlar][4],
	AracInfo[carid][aracMermiler][0],
	AracInfo[carid][aracMermiler][1],
	AracInfo[carid][aracMermiler][2],
	AracInfo[carid][aracMermiler][3],
	AracInfo[carid][aracMermiler][4],
	AracInfo[carid][aracKira],
	AracInfo[carid][aracFiyat],
	AracInfo[carid][aracTip],
	AracInfo[carid][aracPlaka],
	AracInfo[carid][aracKM]
	);
	format(query, sizeof(query), "%s, `ElKonuldu` = '%d', `Zirh` = '%d', `ZirhVarMi` = '%d', `Garaj` = '%d', `Interior` = '%d', `World` = '%d', `TaksiPlaka` = '%d', `uyusturucu` = %d WHERE `aracid` = %d",
	query,
	AracInfo[carid][aracElKonuldu],
	AracInfo[carid][aracZirh],
	AracInfo[carid][aracZirhVarMi],
	AracInfo[carid][aracGaraj],
	AracInfo[carid][aracInterior],
	AracInfo[carid][aracWorld],
	AracInfo[carid][TaksiPlaka],
	AracInfo[carid][aracUyusturucu],
	AracInfo[carid][aracID]);

	mysql_query(g_SQL,query, false);

	mysql_format(g_SQL, query, sizeof query, "UPDATE `araclar` SET `aracpaintjob` = '%d' WHERE `aracid` = '%d'", AracInfo[carid][aracPaintjob], AracInfo[carid][aracID]);
	mysql_query (g_SQL, query);

	if(AracInfo[carid][aracTip] != 3)
	{
		mysql_format(g_SQL, query, sizeof query, "UPDATE `araclar` SET `arackilit` = '%d' WHERE `aracid` = '%d'", AracInfo[carid][aracKilit], AracInfo[carid][aracID]);
		mysql_query (g_SQL, query);
	}
	if(AracInfo[carid][aracTip] == 3)
	{
		mysql_format(g_SQL, query, sizeof query, "UPDATE `araclar` SET `arackilit` = '0' WHERE `aracid` = '%d'", AracInfo[carid][aracID]);
		mysql_query (g_SQL, query);
	}
	return 1;
}
stock SQLName(id, underscore = 1)
{
	new owner[MAX_PLAYER_NAME], query[512];
	mysql_format(g_SQL, query, sizeof(query), "SELECT `Isim` FROM `oyuncular` WHERE `ID` = '%d'", id);
 	new Cache:sqlname = mysql_query(g_SQL, query);
	new rows;
	cache_get_row_count(rows);
	if (rows) cache_get_value_name(0, "Isim", owner, 24);
	cache_delete(sqlname);
	if (!underscore) {
	    for (new i = 0, len = strlen(owner); i < len; i ++) {
	        if (owner[i] == '_') owner[i] = ' ';
		}
	}
	return owner;
}
stock Ev_Yenile(houseid)
{
    if (houseid != -1 && HouseInfo[houseid][evExists])
    {
        if (IsValidDynamic3DTextLabel(HouseInfo[houseid][houseText]))
            DestroyDynamic3DTextLabel(HouseInfo[houseid][houseText]);

        if (IsValidDynamicPickup(HouseInfo[houseid][evPickup]))
		    DestroyDynamicPickup(HouseInfo[houseid][evPickup]);

		new string[850];
		new durum[24];
		if (HouseInfo[houseid][evKilit] == 0) durum = "{08d342}Kilitli Deðil";
		else durum = "{FF0000}Sadece Sahibi";
		if (HouseInfo[houseid][evSahip] == -1 && HouseInfo[houseid][evKiralik] == 0 && HouseInfo[houseid][evSatilik] == 0)
		{
		    format(string,sizeof(string), "{FF9900}Satýlýk Mülk (ID: %d)\n\n{FFFFFF}Interior %d\n{2ECC71}%s\n{2ECC71}%s\n{FFFFFF}%d, %s, %s",
			houseid,HouseInfo[houseid][evInterior],FormatNumber(HouseInfo[houseid][evFiyat]),durum,houseid, GetLocation(HouseInfo[houseid][evPos][0], HouseInfo[houseid][evPos][1], HouseInfo[houseid][evPos][2]), GetCityName(HouseInfo[houseid][evPos][0], HouseInfo[houseid][evPos][1], HouseInfo[houseid][evPos][2]));
		    HouseInfo[houseid][houseText] = CreateDynamic3DTextLabel(string,-1,HouseInfo[houseid][evPos][0],HouseInfo[houseid][evPos][1],HouseInfo[houseid][evPos][2],5.0,INVALID_PLAYER_ID, INVALID_VEHICLE_ID,0,0);
		    HouseInfo[houseid][evPickup] = CreateDynamicPickup(1273,23,HouseInfo[houseid][evPos][0],HouseInfo[houseid][evPos][1],HouseInfo[houseid][evPos][2],0);
		    return 1;
		}
		if (HouseInfo[houseid][evSahip] == -1 && HouseInfo[houseid][evKiralik] == 1 && HouseInfo[houseid][evKiralayan] == -1 && HouseInfo[houseid][evSatilik] == 0)
		{
		    format(string,sizeof(string), "{FF9900}Kiralýk Mülk (ID: %d)\n\n{9F9F9F}%s\n{AFAFAF}Kira Ücret: {2ECC71}%s\n{AFAFAF}Durum: {2ECC71}%s\n{FFFFFF}%d, %s, %s",
			houseid,HouseInfo[houseid][evIsim],FormatNumber(HouseInfo[houseid][evKiraUcret]),durum, houseid, GetLocation(HouseInfo[houseid][evPos][0], HouseInfo[houseid][evPos][1], HouseInfo[houseid][evPos][2]), GetCityName(HouseInfo[houseid][evPos][0], HouseInfo[houseid][evPos][1], HouseInfo[houseid][evPos][2]));
		    HouseInfo[houseid][houseText] = CreateDynamic3DTextLabel(string,-1,HouseInfo[houseid][evPos][0],HouseInfo[houseid][evPos][1],HouseInfo[houseid][evPos][2],5.0,INVALID_PLAYER_ID, INVALID_VEHICLE_ID,0,0);
		    HouseInfo[houseid][evPickup] = CreateDynamicPickup(1273,23,HouseInfo[houseid][evPos][0],HouseInfo[houseid][evPos][1],HouseInfo[houseid][evPos][2],0);
		}
	 	if (HouseInfo[houseid][evSahip] == -1 && HouseInfo[houseid][evKiralik] == 1 && HouseInfo[houseid][evKiralayan] != -1 && HouseInfo[houseid][evSatilik] == 0)
		{
		    format(string,sizeof(string), "{FF9900}Kiralýk Mülk (ID: %d)\n\n{9F9F9F}%s\n{AFAFAF}Kiralayan: {2ECC71}%s\n{AFAFAF}Durum: {2ECC71}%s\n{FFFFFF}%d, %s, %s",
			houseid,HouseInfo[houseid][evIsim],SQLName(HouseInfo[houseid][evKiralayan],0),durum,houseid, GetLocation(HouseInfo[houseid][evPos][0], HouseInfo[houseid][evPos][1], HouseInfo[houseid][evPos][2]), GetCityName(HouseInfo[houseid][evPos][0], HouseInfo[houseid][evPos][1], HouseInfo[houseid][evPos][2]));
		    HouseInfo[houseid][houseText] = CreateDynamic3DTextLabel(string,-1,HouseInfo[houseid][evPos][0],HouseInfo[houseid][evPos][1],HouseInfo[houseid][evPos][2],5.0,INVALID_PLAYER_ID, INVALID_VEHICLE_ID,0,0);
		}
	 	if (HouseInfo[houseid][evSahip] != -1 && HouseInfo[houseid][evKiralik] == 1 && HouseInfo[houseid][evKiralayan] == -1 && HouseInfo[houseid][evSatilik] == 0)
		{
		    format(string,sizeof(string), "{FF9900}Kiralýk Ev (#%d)\n\n{9F9F9F}%s\n{AFAFAF}Sahip: {2ECC71}%s\n{AFAFAF}Durum: {2ECC71}%s\n{AFAFAF}Kira Ücret: {2ECC71}%s\n{FFFFFF}%d, %s, %s",
			houseid,HouseInfo[houseid][evIsim],SQLName(HouseInfo[houseid][evSahip],0),durum,FormatNumber(HouseInfo[houseid][evKiraUcret]),houseid, GetLocation(HouseInfo[houseid][evPos][0], HouseInfo[houseid][evPos][1], HouseInfo[houseid][evPos][2]), GetCityName(HouseInfo[houseid][evPos][0], HouseInfo[houseid][evPos][1], HouseInfo[houseid][evPos][2]));
		    HouseInfo[houseid][houseText] = CreateDynamic3DTextLabel(string,-1,HouseInfo[houseid][evPos][0],HouseInfo[houseid][evPos][1],HouseInfo[houseid][evPos][2],5.0,INVALID_PLAYER_ID, INVALID_VEHICLE_ID,0,0);
		    HouseInfo[houseid][evPickup] = CreateDynamicPickup(19522,23,HouseInfo[houseid][evPos][0],HouseInfo[houseid][evPos][1],HouseInfo[houseid][evPos][2],0);
		    return 1;
		}
	 	if (HouseInfo[houseid][evSahip] != -1 && HouseInfo[houseid][evKiralik] == 1 && HouseInfo[houseid][evKiralayan] != -1 && HouseInfo[houseid][evSatilik] == 0)
		{
		    format(string,sizeof(string), "{FF9900}Kiralýk Mülk (ID: %d)\n\n{9F9F9F}%s\n{AFAFAF}Sahip: {2ECC71}%s\n{AFAFAF}Durum: {2ECC71}%s\n{AFAFAF}Kiralayan: {2ECC71}%s\n{FFFFFF}%d, %s, %s",
			houseid,HouseInfo[houseid][evIsim],SQLName(HouseInfo[houseid][evSahip],0),durum,SQLName(HouseInfo[houseid][evKiralayan],0),houseid, GetLocation(HouseInfo[houseid][evPos][0], HouseInfo[houseid][evPos][1], HouseInfo[houseid][evPos][2]), GetCityName(HouseInfo[houseid][evPos][0], HouseInfo[houseid][evPos][1], HouseInfo[houseid][evPos][2]));
		    HouseInfo[houseid][houseText] = CreateDynamic3DTextLabel(string,-1,HouseInfo[houseid][evPos][0],HouseInfo[houseid][evPos][1],HouseInfo[houseid][evPos][2],5.0,INVALID_PLAYER_ID, INVALID_VEHICLE_ID,0,0);
		    HouseInfo[houseid][evPickup] = CreateDynamicPickup(19522,23,HouseInfo[houseid][evPos][0],HouseInfo[houseid][evPos][1],HouseInfo[houseid][evPos][2],0);
		    return 1;
		}
		if (HouseInfo[houseid][evSahip] != -1 && HouseInfo[houseid][evSatilik] == 1 && HouseInfo[houseid][evKiralik] == 0)
		{
		    format(string,sizeof(string), "{FF9900}Kiralýk Mülk (ID: %d)\n\n{9F9F9F}%s\n{AFAFAF}Sahip: {2ECC71}%s\n{AFAFAF}Durum: {2ECC71}%s\n{AFAFAF}Fiyat: {2ECC71}%s\n{FFFFFF}%d, %s, %s",
			houseid,HouseInfo[houseid][evIsim],SQLName(HouseInfo[houseid][evSahip],0),durum,FormatNumber(HouseInfo[houseid][evFiyat]),houseid, GetLocation(HouseInfo[houseid][evPos][0], HouseInfo[houseid][evPos][1], HouseInfo[houseid][evPos][2]), GetCityName(HouseInfo[houseid][evPos][0], HouseInfo[houseid][evPos][1], HouseInfo[houseid][evPos][2]));
		    HouseInfo[houseid][houseText] = CreateDynamic3DTextLabel(string,-1,HouseInfo[houseid][evPos][0],HouseInfo[houseid][evPos][1],HouseInfo[houseid][evPos][2],5.0,INVALID_PLAYER_ID, INVALID_VEHICLE_ID,0,0);
		    HouseInfo[houseid][evPickup] = CreateDynamicPickup(1273,23,HouseInfo[houseid][evPos][0],HouseInfo[houseid][evPos][1],HouseInfo[houseid][evPos][2],0);
		    return 1;
		}
		if (HouseInfo[houseid][evSahip] != -1 && HouseInfo[houseid][evKiralik] == 0 && HouseInfo[houseid][evSatilik] == 0)
		{
		    format(string,sizeof(string), "{FF9900}Mülk (ID: %d)\n{FFFFFF}%s\nInterior %d\n%s\n{FFFFFF}%d, %s, %s",
			houseid,HouseInfo[houseid][evIsim],HouseInfo[houseid][evInterior],durum,houseid, GetLocation(HouseInfo[houseid][evPos][0], HouseInfo[houseid][evPos][1], HouseInfo[houseid][evPos][2]), GetCityName(HouseInfo[houseid][evPos][0], HouseInfo[houseid][evPos][1], HouseInfo[houseid][evPos][2]));
		    HouseInfo[houseid][houseText] = CreateDynamic3DTextLabel(string,-1,HouseInfo[houseid][evPos][0],HouseInfo[houseid][evPos][1],HouseInfo[houseid][evPos][2],5.0,INVALID_PLAYER_ID, INVALID_VEHICLE_ID,0,0);
		    HouseInfo[houseid][evPickup] = CreateDynamicPickup(19522,23,HouseInfo[houseid][evPos][0],HouseInfo[houseid][evPos][1],HouseInfo[houseid][evPos][2],0);
		    return 1;
		}
    }
    return 1;
}
stock IsPlayerNearBoot(playerid, vehicleid)
{
	static
		Float:fX,
		Float:fY,
		Float:fZ;

	GetVehicleBoot(vehicleid, fX, fY, fZ);

	return (GetPlayerVirtualWorld(playerid) == GetVehicleVirtualWorld(vehicleid)) && IsPlayerInRangeOfPoint(playerid, 3.5, fX, fY, fZ);
}

stock Ev_Kaydet(ev)
{
	new query[1330];
	format(query, sizeof(query), "UPDATE `evler` SET `evOwner` = '%d',`evFiyat` = '%d',`evKendiFiyati` = '%d', `Vergi` = '%d', `VergiSure` = '%d',`evPosX` = '%.4f',`evPosY` = '%.4f',`evPosZ` = '%.4f', `evName`= '%s',`evInterior` = '%d', `MaksMobilya` = '%d'",
	HouseInfo[ev][evSahip],
	HouseInfo[ev][evFiyat],
	HouseInfo[ev][evKendiFiyati],
	HouseInfo[ev][evVergi],
	HouseInfo[ev][evVergiSure],
	HouseInfo[ev][evPos][0],
	HouseInfo[ev][evPos][1],
	HouseInfo[ev][evPos][2],
	SQL_ReturnEscaped(HouseInfo[ev][evIsim]),
	HouseInfo[ev][evInterior],
	HouseInfo[ev][evMaksMobilya]
	);
	format(query, sizeof(query), "%s, `evKilit` = '%d',`evPara` = '%d',`evSatilik` = '%d',`evKiralik` = '%d',`evKiraUcret` = '%d',`evKiralayan` = '%d', `Uyusturucu` = '%d', `evKiyafet1` = '%d',`evKiyafet2` = '%d',`evKiyafet3` = '%d',`evKiyafet4` = '%d',`evKiyafet5` = '%d'",
	query,
	HouseInfo[ev][evKilit],
	HouseInfo[ev][evCash],
	HouseInfo[ev][evSatilik],
	HouseInfo[ev][evKiralik],
	HouseInfo[ev][evKiraUcret],
	HouseInfo[ev][evKiralayan],
	HouseInfo[ev][evUyusturucu],
	HouseInfo[ev][evKiyafetler][0],
	HouseInfo[ev][evKiyafetler][1],
	HouseInfo[ev][evKiyafetler][2],
	HouseInfo[ev][evKiyafetler][3],
	HouseInfo[ev][evKiyafetler][4]
	);
 	format(query, sizeof(query), "%s, `evWeapon1` = '%d', `evWeapon2` = '%d', `evWeapon3` = '%d',`evWeapon4` = '%d',`evWeapon5` = '%d',`evWeapon6` = '%d',`evWeapon7` = '%d',`evWeapon8` = '%d',`evWeapon9` = '%d',`evWeapon10` = '%d'",
 	query,
 	HouseInfo[ev][evSilahlar][0],
 	HouseInfo[ev][evSilahlar][1],
 	HouseInfo[ev][evSilahlar][2],
 	HouseInfo[ev][evSilahlar][3],
 	HouseInfo[ev][evSilahlar][4],
 	HouseInfo[ev][evSilahlar][5],
 	HouseInfo[ev][evSilahlar][6],
 	HouseInfo[ev][evSilahlar][7],
 	HouseInfo[ev][evSilahlar][8],
 	HouseInfo[ev][evSilahlar][9]
	);
	format(query, sizeof(query), "%s, `MobilyaYetki` = '%d', `evAmmo1` = '%d', `evAmmo2` = '%d', `evAmmo3` = '%d',`evAmmo4` = '%d',`evAmmo5` = '%d',`evAmmo6` = '%d',`evAmmo7` = '%d',`evAmmo8` = '%d',`evAmmo9` = '%d',`evAmmo10` = '%d' WHERE `evid` = '%d'",
	query,
	HouseInfo[ev][MobilyaYetki],
	HouseInfo[ev][evMermiler][0],
	HouseInfo[ev][evMermiler][1],
	HouseInfo[ev][evMermiler][2],
	HouseInfo[ev][evMermiler][3],
	HouseInfo[ev][evMermiler][4],
	HouseInfo[ev][evMermiler][5],
	HouseInfo[ev][evMermiler][6],
	HouseInfo[ev][evMermiler][7],
	HouseInfo[ev][evMermiler][8],
	HouseInfo[ev][evMermiler][9],
	HouseInfo[ev][evID]
	);
	mysql_query(g_SQL,query, false);
	return 1;
}
stock Ev_MobilyaSayisi(evid)
{
	return Iter_Count(Mobilyalar[evid]);
}
Furniture_Refresh(furnitureid, houseid)
{
	if (furnitureid != -1)
	{
	    if (IsValidDynamicObject(FurnitureData[houseid][furnitureid][furnitureObject]))
	        DestroyDynamicObject(FurnitureData[houseid][furnitureid][furnitureObject]);

	    	FurnitureData[houseid][furnitureid][furnitureObject] = CreateDynamicObject(
			FurnitureData[houseid][furnitureid][furnitureModel],
			FurnitureData[houseid][furnitureid][furniturePos][0],
			FurnitureData[houseid][furnitureid][furniturePos][1],
			FurnitureData[houseid][furnitureid][furniturePos][2],
			FurnitureData[houseid][furnitureid][furnitureRot][0],
			FurnitureData[houseid][furnitureid][furnitureRot][1],
			FurnitureData[houseid][furnitureid][furnitureRot][2],
			HouseInfo[houseid][evID] + 1,
			HouseInteriors[HouseInfo[houseid][evInterior]][intID]
		);
		for (new i; i<5; i++) if (FurnitureData[houseid][furnitureid][furnitureMateryalDesen][i] > 0)
		{
		    SetDynamicObjectMaterial(FurnitureData[houseid][furnitureid][furnitureObject], i, Desenler[FurnitureData[houseid][furnitureid][furnitureMateryalDesen][i]-1][model_id], Desenler[FurnitureData[houseid][furnitureid][furnitureMateryalDesen][i]-1][txdname], Desenler[FurnitureData[houseid][furnitureid][furnitureMateryalDesen][i]-1][texturename], 0);
		}
	}
	return 1;
}
Furniture_Save(furnitureid, houseid)
{
	static
	    string[700];

	format(string, sizeof(string), "UPDATE `furniture` SET `furnitureModel` = '%d', `furnitureName` = '%s', `furnitureX` = '%.4f', `furnitureY` = '%.4f', `furnitureZ` = '%.4f', `furnitureRX` = '%.4f', `furnitureRY` = '%.4f', `furnitureRZ` = '%.4f',`furniturePrice` = '%d'",
	    FurnitureData[houseid][furnitureid][furnitureModel],
	    FurnitureData[houseid][furnitureid][furnitureName],
	    FurnitureData[houseid][furnitureid][furniturePos][0],
	    FurnitureData[houseid][furnitureid][furniturePos][1],
	    FurnitureData[houseid][furnitureid][furniturePos][2],
	    FurnitureData[houseid][furnitureid][furnitureRot][0],
	    FurnitureData[houseid][furnitureid][furnitureRot][1],
	    FurnitureData[houseid][furnitureid][furnitureRot][2],
	    FurnitureData[houseid][furnitureid][furniturePrice]
	);
	format(string, sizeof(string), "%s, `MateryalDesen1` = '%d', `MateryalDesen2` = '%d', `MateryalDesen3` = '%d', `MateryalDesen4` = '%d', `MateryalDesen5` = '%d' WHERE `ID` = '%d' AND `furnitureID` = '%d'",
	string,
	FurnitureData[houseid][furnitureid][furnitureMateryalDesen][0],
    FurnitureData[houseid][furnitureid][furnitureMateryalDesen][1],
    FurnitureData[houseid][furnitureid][furnitureMateryalDesen][2],
    FurnitureData[houseid][furnitureid][furnitureMateryalDesen][3],
    FurnitureData[houseid][furnitureid][furnitureMateryalDesen][4],
    HouseInfo[houseid][evID],
    FurnitureData[houseid][furnitureid][furnitureID]);

	mysql_query(g_SQL, string, false);
	return 1;
}

Furniture_Add(houseid, name[], modelid, Float:x, Float:y, Float:z, Float:rx = 0.0, Float:ry = 0.0, Float:rz = 0.0,price)
{
	new id;

 	if (houseid == -1 || !HouseInfo[houseid][evExists])
	    return 0;
	id = Iter_Free(Mobilyalar[houseid]);

	if (id != -1)
	{
	    FurnitureData[houseid][id][furnitureID] = id;

		format(FurnitureData[houseid][id][furnitureName], 32, name);

		FurnitureData[houseid][id][furnitureModel] = modelid;
	    FurnitureData[houseid][id][furniturePos][0] = x;
	    FurnitureData[houseid][id][furniturePos][1] = y;
	    FurnitureData[houseid][id][furniturePos][2] = z;
	    FurnitureData[houseid][id][furnitureRot][0] = rx;
	    FurnitureData[houseid][id][furnitureRot][1] = ry;
	    FurnitureData[houseid][id][furnitureRot][2] = rz;
		FurnitureData[houseid][id][furniturePrice] = price;
		FurnitureData[houseid][id][furnitureMateryalDesen][0] = 0;
		FurnitureData[houseid][id][furnitureMateryalDesen][1] = 0;
		FurnitureData[houseid][id][furnitureMateryalDesen][2] = 0;
		FurnitureData[houseid][id][furnitureMateryalDesen][3] = 0;
		FurnitureData[houseid][id][furnitureMateryalDesen][4] = 0;

	    Furniture_Refresh(id, houseid);

	    Iter_Add(Mobilyalar[houseid], id);

		new query[256];

		mysql_format(g_SQL, query, sizeof query, "INSERT INTO `furniture` (`ID`, `furnitureID`) VALUES ('%d', '%d')", HouseInfo[houseid][evID], FurnitureData[houseid][id][furnitureID]);
		mysql_query (g_SQL, query);

		Furniture_Save(FurnitureData[houseid][id][furnitureID], houseid);
		return FurnitureData[houseid][id][furnitureID];
	}
	return -1;
}

Furniture_Delete(furnitureid, houseid)
{
	static
	    string[72];

	if (furnitureid != -1)
	{
	    format(string, sizeof(string), "DELETE FROM `furniture` WHERE `ID` = '%d' AND `furnitureID` = '%d'", HouseInfo[houseid][evID], FurnitureData[houseid][furnitureid][furnitureID]);
		mysql_tquery(g_SQL, string);

		FurnitureData[houseid][furnitureid][furnitureModel] = 0;
		Iter_Remove(Mobilyalar[houseid], furnitureid);
		DestroyDynamicObject(FurnitureData[houseid][furnitureid][furnitureObject]);
	}
	return 1;
}

stock Lokasyon_Yukle()
{
    mysql_query(g_SQL, "SELECT * FROM `lokasyon`");

	new rows = cache_num_rows();
    printf("» Toplam %d Lokasyon yüklenmiþtir.", rows);

	if (rows)
	{
	    new lkID;
		for (new i = 0; i < rows; i ++) if (i < MAX_LOKASYON)
	    {
	        cache_get_value_name_int(i, "ID", lkID);

	        Lokasyon[lkID][Exists] = true;
	        Lokasyon[lkID][ID] = lkID;

	        cache_get_value_name(i, "Ad", Lokasyon[lkID][lokasyonAd], 30);
	        cache_get_value_name_float(i, "posX", Lokasyon[lkID][lokasyonPos][0]);
	        cache_get_value_name_float(i, "posY", Lokasyon[lkID][lokasyonPos][1]);
	        cache_get_value_name_float(i, "posZ", Lokasyon[lkID][lokasyonPos][2]);
	    }
	}
    return 1;
}

stock CCTV_Yukle()
{
    mysql_query(g_SQL, "SELECT * FROM `cctv`");

	new rows = cache_num_rows();
    printf("» Toplam %d CCTV yüklenmiþtir.", rows);

	if (rows)
	{
	    new ccID;
	    for (new i = 0; i < rows; i ++)
	    {
	        cache_get_value_name_int(i, "ID", ccID);

	        CCTVInfo[ccID][ID] = ccID;

	        cache_get_value_name(i, "cctv_name", CCTVInfo[ccID][cctv_Name], 30);
	        cache_get_value_name_float(i, "cctv_x", CCTVInfo[ccID][cctv_X]);
	        cache_get_value_name_float(i, "cctv_y", CCTVInfo[ccID][cctv_Y]);
	        cache_get_value_name_float(i, "cctv_z", CCTVInfo[ccID][cctv_Z]);
	        cache_get_value_name_float(i, "cctv_rot_x", CCTVInfo[ccID][cctv_rotX]);
	        cache_get_value_name_float(i, "cctv_rot_y", CCTVInfo[ccID][cctv_rotY]);
	        cache_get_value_name_float(i, "cctv_rot_z", CCTVInfo[ccID][cctv_rotZ]);
	        cache_get_value_name_int(i, "cctv_vw", CCTVInfo[ccID][cctv_VW]);
	        cache_get_value_name_int(i, "cctv_interior", CCTVInfo[ccID][cctv_Interior]);

	        CCTVInfo[ccID][cctv_Object] = CreateObject(1886, CCTVInfo[ccID][cctv_X], CCTVInfo[ccID][cctv_Y], CCTVInfo[ccID][cctv_Z], CCTVInfo[ccID][cctv_rotX], CCTVInfo[ccID][cctv_rotY], CCTVInfo[ccID][cctv_rotZ], 20.0);
	        Iter_Add(CCTVIter, ccID);
		}
	}
	return 1;
}

SaveCCTV(id)
{
	new query[512];
	mysql_format(g_SQL, query, sizeof query, "UPDATE `cctv` SET `cctv_name` = '%s', `cctv_x` = '%f', `cctv_y` = '%f', `cctv_z` = '%f', `cctv_rot_x` = '%f', `cctv_rot_y` = '%f', `cctv_rot_z` = '%f', `cctv_vw` = '%d', `cctv_interior` = '%d' WHERE `ID` = '%d'",
		CCTVInfo[id][cctv_Name],
		CCTVInfo[id][cctv_X],
		CCTVInfo[id][cctv_Y],
		CCTVInfo[id][cctv_Z],
		CCTVInfo[id][cctv_rotX],
		CCTVInfo[id][cctv_rotY],
		CCTVInfo[id][cctv_rotZ],
		CCTVInfo[id][cctv_VW],
		CCTVInfo[id][cctv_Interior],
		CCTVInfo[id][ID]);
	mysql_query(g_SQL, query);
	return 1;
}
CreateCCTV(playerid, name[])
{
	new id = Iter_Free(CCTVIter);
	if (id != -1)
	{
		new
			Float: x, Float: y, Float: z;
		GetPlayerPos(playerid, x, y, z);

        CCTVInfo[id][ID] = id;

		CCTVInfo[id][cctv_X] = x;
		CCTVInfo[id][cctv_Y] = y;
		CCTVInfo[id][cctv_Z] = z;

		CCTVInfo[id][cctv_rotX] = 0.0;
		CCTVInfo[id][cctv_rotY] = 0.0;
		CCTVInfo[id][cctv_rotZ] = 0.0;


		CCTVInfo[id][cctv_VW] = GetPlayerVirtualWorld(playerid);
		CCTVInfo[id][cctv_Interior] = GetPlayerInterior(playerid);
		strcpy(CCTVInfo[id][cctv_Name], name, 30);

		CCTVInfo[id][cctv_Object] = CreateObject(1886, CCTVInfo[id][cctv_X], CCTVInfo[id][cctv_Y], CCTVInfo[id][cctv_Z], CCTVInfo[id][cctv_rotX], CCTVInfo[id][cctv_rotY], CCTVInfo[id][cctv_rotZ], 20.0);

		Iter_Add(CCTVIter, id);

		new query[256];
        mysql_format(g_SQL, query, sizeof query, "INSERT INTO `cctv` (`ID`) VALUES ('%d')", CCTVInfo[id][ID]);
		mysql_tquery(g_SQL, query);

		SaveCCTV(id);
	}
	return id;
}

DeleteCCTV(playerid, id)
{
	if (!Iter_Contains(CCTVIter, id)) return HataMesajGonder(playerid, "Geçersiz ID girdiniz.");

	new
		query[128];
	mysql_format(g_SQL, query, sizeof query, "DELETE FROM `cctv` WHERE `ID` = '%d'", CCTVInfo[id][ID]);
	mysql_query(g_SQL, query);

	DestroyObject(CCTVInfo[id][cctv_Object]);

	CCTVInfo[id][cctv_X] = CCTVInfo[id][cctv_Y] = CCTVInfo[id][cctv_Z] =
	CCTVInfo[id][cctv_rotX] = CCTVInfo[id][cctv_rotY] = CCTVInfo[id][cctv_rotZ] = 0.0;

	CCTVInfo[id][cctv_VW] = CCTVInfo[id][cctv_Interior] = CCTVInfo[id][ID] = -1;

	Iter_Remove(CCTVIter, id);
	MesajGonder(playerid, "CCTV silindi, ID: %d", id);
	return 1;
}
EditCCTV(playerid, id)
{
	if (!Iter_Contains(CCTVIter, id)) return HataMesajGonder(playerid, "Geçersiz ID girdiniz.");
	if (CCTV_inEditing[playerid]) return HataMesajGonder(playerid, "Zaten CCTV düzenliyorsun.");
	CCTV_inEditing[playerid] = 1;
	CCTV_ID[playerid] = id;
	EditObject(playerid, CCTVInfo[id][cctv_Object]);

	MesajGonder(playerid, "CCTV düzenlemeye baþladýnýz, bitirdiðinizde kayýt simgesine basýn.");
	return 1;
}
CancelEditCCTV(playerid, id)
{
	CCTV_inEditing[playerid] = 0;
	CCTV_ID[playerid] = -1;
	SetObjectPos(CCTVInfo[id][cctv_Object], CCTVInfo[id][cctv_X], CCTVInfo[id][cctv_Y], CCTVInfo[id][cctv_Z]);
	SetObjectRot(CCTVInfo[id][cctv_Object], CCTVInfo[id][cctv_rotX], CCTVInfo[id][cctv_rotY], CCTVInfo[id][cctv_rotZ]);
	return 1;
}
ChangeCCTVName(playerid, id, name[])
{
	if (!Iter_Contains(CCTVIter, id)) return HataMesajGonder(playerid, "Geçersiz ID girdiniz.");
	strcpy(CCTVInfo[id][cctv_Name], name, 30);
	MesajGonder(playerid, "CCTV ismi deðiþtirildi. (ID: %d, Yeni isim: %s)", id, name);
	return 1;
}
MoveCCTV(playerid, id)
{
	if (!Iter_Contains(CCTVIter, id)) return SendClientMessage(playerid, 0xFF6347FF, "The ID of the typed CCTV is nonexistent. (Use Server ID)");
	new
		Float: x, Float: y, Float: z;
	GetPlayerPos(playerid, x, y, z);

	CCTVInfo[id][cctv_X] = x;
	CCTVInfo[id][cctv_Y] = y + 0.5;
	CCTVInfo[id][cctv_Z] = z;

	CCTVInfo[id][cctv_rotX] = 0.0;
	CCTVInfo[id][cctv_rotY] = 0.0;
	CCTVInfo[id][cctv_rotZ] = 0.0;

	CCTVInfo[id][cctv_VW] = GetPlayerVirtualWorld(playerid);
	CCTVInfo[id][cctv_Interior] = GetPlayerInterior(playerid);

	SetObjectPos(CCTVInfo[id][cctv_Object], CCTVInfo[id][cctv_X], CCTVInfo[id][cctv_Y], CCTVInfo[id][cctv_Z]);
	SetObjectRot(CCTVInfo[id][cctv_Object], CCTVInfo[id][cctv_rotX], CCTVInfo[id][cctv_rotY], CCTVInfo[id][cctv_rotZ]);

	SaveCCTV(id);
	return 1;
}

stock Arrest_Load()
{
	mysql_query(g_SQL, "SELECT * FROM `arrestpoints`");

	new rows = cache_num_rows();
	printf("» Toplam %d hapis noktasý yüklendi.", rows);
	if (rows)
	{
	    new arrID;
		for (new i = 0; i < rows; i ++) if (i < MAX_ARREST_POINTS)
		{
		    cache_get_value_name_int(i, "arrestID", arrID);

		    ArrestData[arrID][arrestExists] = true;
		    ArrestData[arrID][arrestID] = arrID;

		    cache_get_value_name_float(i, "arrestX", ArrestData[arrID][arrestPos][0]);
		    cache_get_value_name_float(i, "arrestY", ArrestData[arrID][arrestPos][1]);
		    cache_get_value_name_float(i, "arrestZ", ArrestData[arrID][arrestPos][2]);
		    cache_get_value_name_int(i, "arrestInterior", ArrestData[arrID][arrestInterior]);
		    cache_get_value_name_int(i, "arrestWorld", ArrestData[arrID][arrestWorld]);

		    Arrest_Refresh(arrID);
		}
	}
	return 1;
}

Arrest_Refresh(arrestid)
{
	if (arrestid != -1 && ArrestData[arrestid][arrestExists])
	{
	    static
	        string[64];

		if (IsValidDynamicPickup(ArrestData[arrestid][arrestPickup]))
		    DestroyDynamicPickup(ArrestData[arrestid][arrestPickup]);

		if (IsValidDynamic3DTextLabel(ArrestData[arrestid][arrestText3D]))
		    DestroyDynamic3DTextLabel(ArrestData[arrestid][arrestText3D]);

		format(string, sizeof(string), "Hapis Noktasý (ID: %d)\n{FFFFFF}/hapseat", arrestid);

		ArrestData[arrestid][arrestPickup] = CreateDynamicPickup(1247, 23, ArrestData[arrestid][arrestPos][0], ArrestData[arrestid][arrestPos][1], ArrestData[arrestid][arrestPos][2], ArrestData[arrestid][arrestWorld], ArrestData[arrestid][arrestInterior]);
  		ArrestData[arrestid][arrestText3D] = CreateDynamic3DTextLabel(string, COLOR_DARKBLUE, ArrestData[arrestid][arrestPos][0], ArrestData[arrestid][arrestPos][1], ArrestData[arrestid][arrestPos][2], 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, ArrestData[arrestid][arrestWorld], ArrestData[arrestid][arrestInterior]);
	}
	return 1;
}
Arrest_Delete(arrestid)
{
	if (arrestid != -1 && ArrestData[arrestid][arrestExists])
	{
	    static
	        string[64];

        if (IsValidDynamicPickup(ArrestData[arrestid][arrestPickup]))
		    DestroyDynamicPickup(ArrestData[arrestid][arrestPickup]);

		if (IsValidDynamic3DTextLabel(ArrestData[arrestid][arrestText3D]))
		    DestroyDynamic3DTextLabel(ArrestData[arrestid][arrestText3D]);

		format(string, sizeof(string), "DELETE FROM `arrestpoints` WHERE `arrestID` = '%d'", ArrestData[arrestid][arrestID]);
		mysql_query(g_SQL, string, false);

		ArrestData[arrestid][arrestExists] = false;
		ArrestData[arrestid][arrestID] = 0;
	}
	return 1;
}
Arrest_Create(Float:x, Float:y, Float:z, interior, world)
{
	for (new i = 0; i < MAX_ARREST_POINTS; i ++) if (!ArrestData[i][arrestExists])
	{
	    ArrestData[i][arrestExists] = true;
        ArrestData[i][arrestID] = i;

	    ArrestData[i][arrestPos][0] = x;
	    ArrestData[i][arrestPos][1] = y;
	    ArrestData[i][arrestPos][2] = z;
	    ArrestData[i][arrestInterior] = interior;
	    ArrestData[i][arrestWorld] = world;

		new query[256];

		mysql_format(g_SQL, query, sizeof query, "INSERT INTO `arrestpoints` (`arrestID`, `arrestInterior`) VALUES ('%d', '0')", i);
	    mysql_query(g_SQL, query);

		Arrest_Save(i);
		Arrest_Refresh(i);
		return i;
	}
	return -1;
}

Arrest_Save(arrestid)
{
	static
	    query[220];

	format(query, sizeof(query), "UPDATE `arrestpoints` SET `arrestX` = '%.4f', `arrestY` = '%.4f', `arrestZ` = '%.4f', `arrestInterior` = '%d', `arrestWorld` = '%d' WHERE `arrestID` = '%d'",
	    ArrestData[arrestid][arrestPos][0],
	    ArrestData[arrestid][arrestPos][1],
	    ArrestData[arrestid][arrestPos][2],
	    ArrestData[arrestid][arrestInterior],
	    ArrestData[arrestid][arrestWorld],
	    ArrestData[arrestid][arrestID]
	);
	mysql_query(g_SQL, query, false);
	return 1;
}

stock Arac_Spawn(carid, display = 0)
{
	new id = carid;
	new vehicle;

	if (AracInfo[id][aracExists])
	{
		if (IsValidDynamic3DTextLabel(AracInfo[id][aracLabel]))
		{
			UpdateDynamic3DTextLabelText(AracInfo[id][aracLabel], -1, " ");
			DestroyDynamic3DTextLabel(AracInfo[id][aracLabel]);
		}

	    if (IsValidVehicle(AracInfo[id][aracVehicle]))
	        DestroyVehicle(AracInfo[id][aracVehicle]);

		if (AracInfo[id][aracRenkler][0] == -1)
		    AracInfo[id][aracRenkler][0] = random(255);

        if (AracInfo[id][aracRenkler][1] == -1)
		    AracInfo[id][aracRenkler][1] = random(255);

		AracInfo[id][aracVehicle] = CreateVehicle(AracInfo[id][aracModel], AracInfo[id][aracPos][0], AracInfo[id][aracPos][1], AracInfo[id][aracPos][2], AracInfo[id][aracPos][3], AracInfo[id][aracRenkler][0], AracInfo[id][aracRenkler][1], -1);

		if(AracInfo[id][aracTip] == 6)
			AracInfo[id][aracLabel] = CreateDynamic3DTextLabel("[KURS ARACI]", COLOR_RED, 0.0, 0.0, 1.0, 30.0, INVALID_PLAYER_ID, AracInfo[id][aracVehicle], 1);

		vehicle = AracInfo[id][aracVehicle];

		CarLastPos[vehicle][0] = AracInfo[id][aracPos][0];
		CarLastPos[vehicle][1] = AracInfo[id][aracPos][1];
		CarLastPos[vehicle][2] = AracInfo[id][aracPos][2];

		TirYuk[vehicle] = 0;

		AracYuk[vehicle] = 0;
		AracCP[vehicle] = -1;

		CimentoGotur[vehicle] = 0;
		CimentoGetir[vehicle] = 0;
		CimentoGenel[vehicle] = 0;

		LoadedTrash[vehicle] = 0;
		vehRadar[vehicle] = false;

		for (new i = 0; i < 5; i++)
		    TextDrawDestroy(carMDC[vehicle][i]);

		vehRadarLimit[vehicle] = 100;
		KillTimer(timerMDC[vehicle]);

		AracInfo[id][aracDisplay] = true;

		if ((AracInfo[id][aracSahip] != -1) && (!display) && (AracInfo[id][aracKira] == -1) && (AracInfo[id][aracFaction] == -1) && (AracInfo[id][aracSatilik] == 0) && (AracInfo[id][aracTip] == 4) && (AracInfo[id][aracGaraj] == -1))
		{
		    AracInfo[id][aracDisplay] = false;
		    SetVehicleVirtualWorld(vehicle, 1000);
		}


		if (AracInfo[id][aracBaglandi] == 1)
		{
		    AracInfo[id][aracDisplay] = false;
			SetVehicleVirtualWorld(vehicle, 1000);
		}

/*		if ((AracInfo[id][aracTip] == 3) && (AracInfo[id][aracKira] > 0))
		{
		    SetVehicleParamsEx(vehicle, 0, 0, 0, 0, 0, 0, 0);
		    AracInfo[id][aracKilit] = false;
		    AracInfo[id][aracLabel] = CreateDynamic3DTextLabel("{808080}[Kiralýk Araç]", 0xFFFFFFFF, 0.0, -2.16, 0.0, 6.0, INVALID_PLAYER_ID, vehicle, 0, -1, -1, -1, STREAMER_3D_TEXT_LABEL_SD, -1, 0);
		}*/

		if ((AracInfo[id][aracTip] == 4) && (AracInfo[id][aracSatilik] == 1) && (AracInfo[id][aracKira] > 0))
		{
		    new string[128];
		    format(string, sizeof string, "{00FF00}.:SATILIK:.\n{00FF00}%s\n{00FF00}%d", FormatNumber(AracInfo[id][aracFiyat]), GetSQLPhoneNumber(AracInfo[id][aracSahip]));
		    AracInfo[id][aracLabel] = CreateDynamic3DTextLabel(string, -1,0.0, -2.5, 0.4, 30.0, INVALID_PLAYER_ID, vehicle, 1);
		}

		SetVehicleNumberPlate(AracInfo[id][aracVehicle], AracInfo[id][aracPlaka]);

		if (AracInfo[id][aracDisplay] == 1)
		{
		    SetVehicleVirtualWorld(vehicle, AracInfo[id][aracWorld]);
		    LinkVehicleToInteriorEx(vehicle, AracInfo[id][aracInterior]);
		}

		AracInfo[id][aracCamlar] = false;

		AracInfo[id][Taksimetre] = 0;
        AracInfo[id][OturumKazanci] = 0;

		DestroyDynamicObject(AracInfo[id][TaksiObje]);

		format(RadyoLink[vehicle], 128, "");

		if (AracInfo[id][aracVehicle] != INVALID_VEHICLE_ID)
		{
		    for (new i = 0; i < 5; i++)
				if (IsValidDynamicObject(AracTohumObjeler[vehicle][i]))
				    DestroyDynamicObject(AracTohumObjeler[vehicle][i]);

			AracTohumlar[vehicle][0] = 0;
			AracTohumlar[vehicle][1] = 0;
			AracTohumlar[vehicle][2] = 0;

			if (AracInfo[id][aracPaintjob] != -1)
			{
			    ChangeVehiclePaintjob(vehicle, AracInfo[id][aracPaintjob]);
			}

			if (AracInfo[id][aracKilit] == 1)
			{
				new engine, lights, alarm, doors, bonnet, boot, objective;

				GetVehicleParamsEx(vehicle, engine, lights, alarm, doors, bonnet, boot, objective);
			    SetVehicleParamsEx(vehicle, engine, lights, alarm, 1, bonnet, boot, objective);
			}

			if (AracInfo[id][aracSirenAcik] == true)
			{
			    AracInfo[id][aracSirenAcik] = false;
			    DestroyDynamicObject(AracInfo[id][SirenObject]);
			}

			if (AracInfo[id][aracRadar] == true)
			{
				AracInfo[id][aracRadar] = false;
			}

			if ((AracInfo[id][aracFactionType] == BIRLIK_LSPD) || (AracInfo[carid][aracFactionType] == BIRLIK_FBI))
			{
			    PolisAraci[vehicle][Silahlar][0] = 24; // Deagle
			    PolisAraci[vehicle][Mermiler][0] = 80; // Deagle Mermi

			    PolisAraci[vehicle][Silahlar][1] = 29; // MP5
			    PolisAraci[vehicle][Mermiler][1] = 200; // MP5 Mermi

			    PolisAraci[vehicle][Silahlar][2] = 31; // M4
			    PolisAraci[vehicle][Mermiler][2] = 280; // M4 Mermi

			    PolisAraci[vehicle][Silahlar][3] = 25; // Shotgun
			    PolisAraci[vehicle][Mermiler][3] = 100; // Shotgun Mermi

			    PolisAraci[vehicle][Silahlar][4] = 0; // Bos
			    PolisAraci[vehicle][Mermiler][4] = 0;

			    PolisAraci[vehicle][AgriKesici] = 2;
			    PolisAraci[vehicle][CelikYelek] = 2;

			    Beanbag[vehicle] = 1;

			    AracInfo[id][aracZirh] = 50;
			}

			for (new i = 0; i < 14; i ++)
			    if (AracInfo[carid][aracMods][i] > 0)
					AddVehicleComponent(AracInfo[carid][aracVehicle], AracInfo[carid][aracMods][i]);
		}
	}
}

stock Car_GetID2(sqlid)
{
	for (new i = 0; i != MAX_ARAC; i ++)
	{
		if (AracInfo[i][aracExists] && AracInfo[i][aracID] == sqlid)
	    	return i;
	}
	return -1;
}

stock Car_GetID(vehicleid)
{
	for (new i = 0; i != MAX_ARAC; i ++)
	{
		if (AracInfo[i][aracExists] && AracInfo[i][aracVehicle] == vehicleid)
	    	return AracInfo[i][aracID];
	}
	return -1;
}

stock PlakaOlustur(id)
{
    if (id != -1)
    {
        format(AracInfo[id][aracPlaka], 24, "%d %s%s%s %d%d", RandomEx(100,999), Harfler[random(sizeof(Harfler))], Harfler[random(sizeof(Harfler))], Harfler[random(sizeof(Harfler))], RandomEx(0,9), RandomEx(0,9));
        SetVehicleNumberPlate(AracInfo[id][aracVehicle], AracInfo[id][aracPlaka]);
    }
    return 1;
}

stock RandomEx(min, max)
	return random(max - min) + min;

stock IsValidVehicleModel(model)
{
	if (model >= 400 && model <= 611)
	{
		return true;
	}
	return false;
}
stock AractanIndir(playerid)
{
	new Float:pos[3];
	GetPlayerPos(playerid,pos[0],pos[1],pos[2]);
	SetPlayerPos(playerid,pos[0],pos[1],pos[2]);
	return 1;
}
stock Log_Write(const path[], const str[], {Float,_}:...)
{
	static
	    args,
	    start,
	    end,
	    File:file,
	    string[1024]
	;
	if ((start = strfind(path, "/")) != -1) {
	    strmid(string, path, 0, start + 1);

	    if (!fexist(string))
	        return printf("** Uyari: Dosya \"%s\" bulunmuyor.", string);
	}
	#emit LOAD.S.pri 8
	#emit STOR.pri args

	file = fopen(path, io_append);

	if (!file)
	    return 0;

	if (args > 8)
	{
		#emit ADDR.pri str
		#emit STOR.pri start

	    for (end = start + (args - 8); end > start; end -= 4)
		{
	        #emit LREF.pri end
	        #emit PUSH.pri
		}
		#emit PUSH.S str
		#emit PUSH.C 1024
		#emit PUSH.C string
		#emit PUSH.C args
		#emit SYSREQ.C format

		fwrite(file, string);
		fwrite(file, "\r\n");
		fclose(file);

		#emit LCTRL 5
		#emit SCTRL 4
		#emit RETN
	}
	fwrite(file, str);
	fwrite(file, "\r\n");
	fclose(file);

	return 1;
}

stock ParaVer(playerid,miktar,bildirim = 1)
{
	PlayerData[playerid][pCash] += miktar;
	GivePlayerMoney(playerid,miktar);
	new str[50];
	if (bildirim == 1 && miktar > -1)
	{
	    format(str,sizeof(str), "~g~$%d",miktar);
	    GameTextForPlayer(playerid,str,750,1);
	}
 	if (bildirim == 1 && miktar < 0)
 	{
 	    format(str,sizeof(str), "~r~$%d",miktar);
	    GameTextForPlayer(playerid,str,750,1);
 	}
	return 1;
}

stock FormatNumber(number, prefix[] = "$")
{
	static
		value[32],
		length;

	format(value, sizeof(value), "%d", (number < 0) ? (-number) : (number));

	if ((length = strlen(value)) > 3)
	{
		for (new i = length, l = 0; --i >= 0; l ++) {
		    if ((l > 0) && (l % 3 == 0)) strins(value, ",", i + 1);
		}
	}
	if (prefix[0] != 0)
	    strins(value, prefix, 0);

	if (number < 0)
		strins(value, "", 0);

	return value;
}

stock spamProtect(playerid, const szSpam[], iTime)
{
	static
		s_szPVar[32],
		s_iPVar
	;
	format(s_szPVar, sizeof(s_szPVar), "pv_iSpam_%s", szSpam);

	s_iPVar = GetPVarInt(playerid, s_szPVar);

	if ((GetTickCount() - s_iPVar) < iTime * 1000) {
		return 0;
	} else {
		SetPVarInt(playerid, s_szPVar, GetTickCount());
	}
	return 1;
}

stock GetPlayerID(name[])
{
	new pName[24];
	foreach (new i : Player)
	{
	    GetPlayerName(i, pName, sizeof pName);
		if (strfind(name, pName, true) != -1)
		{
			return i;
		}
	}
	return -1;
}

/*stock BankaBilgileriDialog(playerid)
{
	new string[128],string2[400];
	strcat(string2, "{FF0000}Ýþlem\t{FF0000}Miktar\n");
	format(string,sizeof(string), "{FF9900}Para Çek\t{38c5f7}%s\n",FormatNumber(PlayerData[playerid][pBankCash]));
	strcat(string2,string);
	format(string,sizeof(string), "{FF9900}Para Yatýr\t{38c5f7}%s\n",FormatNumber(PlayerData[playerid][pBankCash]));
	strcat(string2,string);
	format(string,sizeof(string), "{FF9900}Para Transfer\t{38c5f7}%s\n",FormatNumber(PlayerData[playerid][pBankCash]));
	strcat(string2,string);
	//strcat(string2, "{FF0000}Hesap Sil");
	ShowPlayerDialog(playerid,13,DIALOG_STYLE_TABLIST_HEADERS, "{FF9900}LOS SANTOS BANKA",string2, "Seç", "Kapat");
	return 1;
}*/
stock AdminMessage(color, const str[], {Float,_}:...)
{
	static
	    args,
	    start,
	    end,
	    string[144]
	;
	#emit LOAD.S.pri 8
	#emit STOR.pri args

	if (args > 8)
	{
		#emit ADDR.pri str
		#emit STOR.pri start

	    for (end = start + (args - 8); end > start; end -= 4)
		{
	        #emit LREF.pri end
	        #emit PUSH.pri
		}
		#emit PUSH.S str
		#emit PUSH.C 144
		#emit PUSH.C string

		#emit LOAD.S.pri 8
		#emit ADD.C 4
		#emit PUSH.pri

		#emit SYSREQ.C format
		#emit LCTRL 5
		#emit SCTRL 4

        foreach (new i : Player)
		{
			if (PlayerData[i][pAdmin] >= 1 && PlayerData[i][pAyarlar][8] == 0) {
  				SendClientMessage(i, color, string);
			}
		}
		return 1;
	}
 foreach (new i : Player)
	{
		if (PlayerData[i][pAdmin] >= 1 && PlayerData[i][pAyarlar][8] == 0) {
			SendClientMessage(i, color, str);
		}
	}
	return 1;
}
stock AdminHelperMessage(color, const str[], {Float,_}:...)
{
	static
	    args,
	    start,
	    end,
	    string[144]
	;
	#emit LOAD.S.pri 8
	#emit STOR.pri args

	if (args > 8)
	{
		#emit ADDR.pri str
		#emit STOR.pri start

	    for (end = start + (args - 8); end > start; end -= 4)
		{
	        #emit LREF.pri end
	        #emit PUSH.pri
		}
		#emit PUSH.S str
		#emit PUSH.C 144
		#emit PUSH.C string

		#emit LOAD.S.pri 8
		#emit ADD.C 4
		#emit PUSH.pri

		#emit SYSREQ.C format
		#emit LCTRL 5
		#emit SCTRL 4

        foreach (new i : Player)
		{
			if ((PlayerData[i][pAdmin] >= 1 || PlayerData[i][pHelper] >= 1) && PlayerData[i][pAyarlar][8] == 0 || PlayerData[i][pForumGorevlisi] >0 || PlayerData[i][pOyunGorevlisi]>0) {
  				SendClientMessage(i, color, string);
			}
		}
		return 1;
	}
 foreach (new i : Player)
	{
		if ((PlayerData[i][pAdmin] >= 1 || PlayerData[i][pHelper] >= 1) && PlayerData[i][pAyarlar][8] == 0) {
			SendClientMessage(i, color, str);
		}
	}
	return 1;
}

stock ObjelerYukleniyor(playerid)
{
	TogglePlayerControllable(playerid, false);
	Spawned[playerid] = 0;
	SetPVarInt(playerid, "KOSKorumasi", 1);
	TextDrawShowForPlayer(playerid, TDEditor_TD[1]);
    PlayerData[playerid][pLegalTeleport] = gettime() + 2;
	SetTimerEx("objyukleniyor",5000,false, "i",playerid);
	return 1;
}

stock infoYukleniyor(playerid)
{
    SetTimerEx("infoyukleniyor",2000,false,"i",playerid);
    TextDrawShowForPlayer(playerid, infohud);
    return 1;
}
stock Ev_MobilyaFiyat(house)
{
	new fiyat;
	foreach (new i: Mobilyalar[house])
	{
	    fiyat += floatround(FurnitureData[house][i][furniturePrice]/2);
	}
	return fiyat;
}

stock Garaj_Olustur(tip[], interior, Float:gX, Float:gY, Float:gZ, world)
{
	for (new i; i < MAX_GARAGE; i++) if (!GarageData[i][gExists])
	{
	    GarageData[i][gExists] = true;
	    GarageData[i][gID] = i;

	    GarageData[i][gKilit] = 1;
	    format(GarageData[i][gSifre], 30, "Yok");
	    GarageData[i][gBirlik] = -1;
	    GarageData[i][gSahip] = -1;
	    GarageData[i][gInterior] = interior;
	    GarageData[i][gPos][0] = gX;
	    GarageData[i][gPos][1] = gY;
	    GarageData[i][gPos][2] = gZ;
	    GarageData[i][gVw] = world;
	    GarageData[i][gParkDurum] = 1;
	    format(GarageData[i][gTip], 20, tip);
	    GarageData[i][gAracLimit] = 0;

		Garaj_Yenile(GarageData[i][gID]);

		new query[256];
		mysql_format(g_SQL, query, sizeof query, "INSERT INTO `garajlar` (`ID`, `Kilit`) VALUES ('%d', '1')", GarageData[i][gID]);
	    mysql_query (g_SQL, query);

		Garaj_Kaydet(GarageData[i][gID]);
		return GarageData[i][gID];
	}
	return -1;
}

Entrance_Inside(playerid)
{
	new vw;
	for (new i = 0; i != MAX_ENTRANCES; i ++)
	if (EntranceData[i][entranceExists] && GetPlayerInterior(playerid) == EntranceData[i][entranceInterior] && IsPlayerInRangeOfPoint(playerid, 2.5, EntranceData[i][entranceInt][0], EntranceData[i][entranceInt][1], EntranceData[i][entranceInt][2]))
	{
	    if (EntranceData[i][entranceInteriorVw] != -1)
			vw = EntranceData[i][entranceInteriorVw];
	    else
			vw = i+100;
	    if (EntranceData[i][entranceBaglanti] != -1)
			vw = EntranceData[i][entranceBaglanti]+23;

	    if (GetPlayerVirtualWorld(playerid) == vw) return i;
	}
    return -1;
}

Entrance_Nearest(playerid)
{
    for (new i = 0; i != MAX_ENTRANCES; i ++) if (EntranceData[i][entranceExists] && IsPlayerInRangeOfPoint(playerid, 2.5, EntranceData[i][entrancePos][0], EntranceData[i][entrancePos][1], EntranceData[i][entrancePos][2]))
    {
        if (GetPlayerInterior(playerid) == EntranceData[i][entranceExterior] && GetPlayerVirtualWorld(playerid) == EntranceData[i][entranceExteriorVW])
            return i;
    }
    return -1;
}
stock Garaj_Kaydet(id)
{
	new query[500];
	format(query, sizeof(query), "UPDATE `garajlar` SET `Kilit` = '%d', `Sifre` = '%s', `Sahip` = '%d', `Birlik` = '%d', `garageX` = '%.2f', `garageY` = '%.2f', `garageZ` = '%.2f', `VirtualWorld` = '%d'",
	GarageData[id][gKilit], GarageData[id][gSifre], GarageData[id][gSahip], GarageData[id][gBirlik], GarageData[id][gPos][0], GarageData[id][gPos][1], GarageData[id][gPos][2], GarageData[id][gVw]);
	format(query, sizeof(query), "%s, `parkdurum` = '%d', `interior` = '%d', `Tip` = '%s', `AracLimit` = '%d' WHERE `ID` = '%d'", query, GarageData[id][gParkDurum], GarageData[id][gInterior], GarageData[id][gTip], GarageData[id][gAracLimit], GarageData[id][gID]);
	mysql_query(g_SQL, query, false);
	return 1;
}
stock Garaj_Yenile(id)
{
    if (IsValidDynamic3DTextLabel(GarageData[id][gText]))
   	{
    	DestroyDynamic3DTextLabel(GarageData[id][gText]);
    }
    if (IsValidDynamicPickup(GarageData[id][gPickup]))
    {
    	DestroyDynamicPickup(GarageData[id][gPickup]);
    }

    new str[180], durum[30];
    if (GarageData[id][gKilit] == 1) durum = "{ff0000}Kilitli";
    else durum = "{1dff00}Açýk";
    if (strcmp(GarageData[id][gSifre], "Yok", true)) durum = "{ff0000}Þifreli";
    if (GarageData[id][gSahip] == -1 && GarageData[id][gBirlik] == -1)
    {
         format(str, sizeof(str), "{E74C3C}[Garaj]\n{E74C3C}Tip: {FFFFFF}%s\n{E74C3C}Sahip: {FFFFFF}Yok\n{E74C3C}Durum: %s\n{FFFFFF}%d, %s, %s", GarageData[id][gTip], (GarageData[id][gKilit] == 1) ? ("{ff0000}Kilitli") : ("{1dff00}Açýk"), id, GetLocation(GarageData[id][gPos][0], GarageData[id][gPos][1], GarageData[id][gPos][2]), GetCityName(GarageData[id][gPos][0], GarageData[id][gPos][1], GarageData[id][gPos][2]));
    }
    else if (GarageData[id][gSahip] != -1)
    {
        format(str, sizeof(str), "{E74C3C}[Garaj]\n{E74C3C}Tip: {FFFFFF}%s\n{E74C3C}Sahip: {FFFFFF}%s\n{E74C3C}Durum: %s\n{FFFFFF}%d, %s, %s", GarageData[id][gTip], SQLName(GarageData[id][gSahip], 0),(GarageData[id][gKilit] == 1) ? ("{ff0000}Kilitli") : ("{1dff00}Açýk"), id, GetLocation(GarageData[id][gPos][0], GarageData[id][gPos][1], GarageData[id][gPos][2]), GetCityName(GarageData[id][gPos][0], GarageData[id][gPos][1], GarageData[id][gPos][2]));
    }
    else if (GarageData[id][gBirlik] != -1)
    {
        format(str, sizeof(str), "{E74C3C}[Garaj]\n{E74C3C}Tip: {FFFFFF}%s\n{E74C3C}Sahip: {FFFFFF}%s\n{E74C3C}Durum: %s\n{FFFFFF}%d, %s, %s", GarageData[id][gTip], Birlikler[GarageData[id][gBirlik]][birlikAd],(GarageData[id][gKilit] == 1) ? ("{ff0000}Kilitli") : ("{1dff00}Açýk"), id, GetLocation(GarageData[id][gPos][0], GarageData[id][gPos][1], GarageData[id][gPos][2]), GetCityName(GarageData[id][gPos][0], GarageData[id][gPos][1], GarageData[id][gPos][2]));
    }
    GarageData[id][gText] = CreateDynamic3DTextLabel(str, -1, GarageData[id][gPos][0], GarageData[id][gPos][1], GarageData[id][gPos][2], 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, GarageData[id][gVw]);
    GarageData[id][gPickup] = CreateDynamicPickup(19133, 23, GarageData[id][gPos][0], GarageData[id][gPos][1], GarageData[id][gPos][2], GarageData[id][gVw]);
    return 1;
}

Entrance_Refresh(entranceid)
{
    if (entranceid != -1 && EntranceData[entranceid][entranceExists])
    {
        if (IsValidDynamic3DTextLabel(EntranceData[entranceid][entranceText3D]))
            DestroyDynamic3DTextLabel(EntranceData[entranceid][entranceText3D]);

        if (IsValidDynamicPickup(EntranceData[entranceid][entrancePickup]))
            DestroyDynamicPickup(EntranceData[entranceid][entrancePickup]);

        if (IsValidDynamicMapIcon(EntranceData[entranceid][entranceMapIcon]))
            DestroyDynamicMapIcon(EntranceData[entranceid][entranceMapIcon]);


		new str[124];
		format(str, sizeof(str), "%s\n\n%d, %s, %s", EntranceData[entranceid][entranceName], entranceid, GetLocation(EntranceData[entranceid][entrancePos][0], EntranceData[entranceid][entrancePos][1], EntranceData[entranceid][entrancePos][2]), GetCityName(EntranceData[entranceid][entrancePos][0], EntranceData[entranceid][entrancePos][1], EntranceData[entranceid][entrancePos][2]));
        EntranceData[entranceid][entranceText3D] = CreateDynamic3DTextLabel(str, 0xC17426FF, EntranceData[entranceid][entrancePos][0], EntranceData[entranceid][entrancePos][1], EntranceData[entranceid][entrancePos][2]+0.5, 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, EntranceData[entranceid][entranceExteriorVW], EntranceData[entranceid][entranceExterior]);
        EntranceData[entranceid][entrancePickup] = CreateDynamicPickup(EntranceData[entranceid][entrancepIcon], 23, EntranceData[entranceid][entrancePos][0], EntranceData[entranceid][entrancePos][1], EntranceData[entranceid][entrancePos][2] - 0.3, EntranceData[entranceid][entranceExteriorVW], EntranceData[entranceid][entranceExterior]);

        if (EntranceData[entranceid][entranceIcon] != 0)
            EntranceData[entranceid][entranceMapIcon] = CreateDynamicMapIcon(EntranceData[entranceid][entrancePos][0], EntranceData[entranceid][entrancePos][1], EntranceData[entranceid][entrancePos][2], EntranceData[entranceid][entranceIcon], 0, EntranceData[entranceid][entranceExteriorVW], EntranceData[entranceid][entranceExterior]);
    }
    return 1;
}

stock Entrance_Create(playerid, name[])
{
    static
        Float:x,
        Float:y,
        Float:z,
        Float:angle;

    if (GetPlayerPos(playerid, x, y, z) && GetPlayerFacingAngle(playerid, angle))
    {
        for (new i = 0; i != MAX_ENTRANCES; i ++)
        {
            if (!EntranceData[i][entranceExists])
            {
                EntranceData[i][entranceExists] = true;
                EntranceData[i][entranceID] = i;

                EntranceData[i][entranceIcon] = 0;
                EntranceData[i][entrancepIcon] = 19132;
                EntranceData[i][entranceLocked] = 0;

                format(EntranceData[i][entranceName], 32, name);
                EntranceData[i][entrancePass][0] = 0;

                EntranceData[i][entrancePos][0] = x;
                EntranceData[i][entrancePos][1] = y;
                EntranceData[i][entrancePos][2] = z;
                EntranceData[i][entrancePos][3] = angle;

                EntranceData[i][entranceInt][0] = x;
                EntranceData[i][entranceInt][1] = y;
                EntranceData[i][entranceInt][2] = z + 10000;
                EntranceData[i][entranceInt][3] = 0.0000;

                EntranceData[i][entranceInterior] = 0;
                EntranceData[i][entranceExterior] = GetPlayerInterior(playerid);
                EntranceData[i][entranceExteriorVW] = GetPlayerVirtualWorld(playerid);
				EntranceData[i][entranceInteriorVw] = -1;
				EntranceData[i][entranceBaglanti] = -1;

                new query[256];
                mysql_format(g_SQL, query, sizeof query, "INSERT INTO `entrances` (`entranceID`, `entranceLocked`, `entrancepIcon`) VALUES ('%d', '0', '19132')", EntranceData[i][entranceID]);
                mysql_query (g_SQL, query);

                Entrance_Refresh(EntranceData[i][entranceID]);
    			Entrance_Save(EntranceData[i][entranceID]);
				return EntranceData[i][entranceID];
            }
        }
    }
    return -1;
}

Entrance_Save(entranceid)
{
    static query[1100];

		format(query, sizeof(query), "UPDATE `entrances` SET `entranceName` = '%s', `entranceInteriorVw` = '%d', `entrancePass` = '%s', `entranceIcon` = '%d', `entranceLocked` = '%d', `entrancePosX` = '%.4f', `entrancePosY` = '%.4f', `entrancePosZ` = '%.4f', `entrancePosA` = '%.4f'",
        SQL_ReturnEscaped(EntranceData[entranceid][entranceName]),
        EntranceData[entranceid][entranceInteriorVw],
        SQL_ReturnEscaped(EntranceData[entranceid][entrancePass]),
        EntranceData[entranceid][entranceIcon],
        EntranceData[entranceid][entranceLocked],
        EntranceData[entranceid][entrancePos][0],
        EntranceData[entranceid][entrancePos][1],
        EntranceData[entranceid][entrancePos][2],
        EntranceData[entranceid][entrancePos][3]
    );

    format(query, sizeof(query), "%s, `entranceIntX` = '%.4f', `entranceIntY` = '%.4f', `entranceIntZ` = '%.4f', `entranceIntA` = '%.4f', `entranceInterior` = '%d', `entranceExterior` = '%d', `entranceExteriorVW` = '%d', `entranceBaglanti` = '%d', `evip` = '%d' WHERE `entranceID` = '%d'",
    query,
    EntranceData[entranceid][entranceInt][0],
   	EntranceData[entranceid][entranceInt][1],
    EntranceData[entranceid][entranceInt][2],
    EntranceData[entranceid][entranceInt][3],
    EntranceData[entranceid][entranceInterior],
    EntranceData[entranceid][entranceExterior],
    EntranceData[entranceid][entranceExteriorVW],
    EntranceData[entranceid][entranceBaglanti],
    EntranceData[entranceid][eVip],
    EntranceData[entranceid][entranceID]);

    mysql_tquery(g_SQL, query);

    mysql_format(g_SQL, query, sizeof query, "UPDATE `entrances` SET `entrancepIcon` = '%d' WHERE `entranceID` = '%d'", EntranceData[entranceid][entrancepIcon], EntranceData[entranceid][entranceID]);
	mysql_query (g_SQL, query);
	return 1;
}

NPC_Save(id)
{
	new query[1500];
	format(query, sizeof(query), "UPDATE `npcler` SET `npcAd` = '%s', `npcSkin` = '%d', `npcX` = '%.4f', `npcY` = '%.4f', `npcZ` = '%.4f', `npcA` = '%.4f', `npcVw` = '%d', `Secenek1` = '%s', `Secenek1Cevap` = '%s', `Secenek2` = '%s', `Secenek2Cevap` = '%s', `Secenek3` = '%s'",
	SQL_ReturnEscaped(NPCBilgi[id][npcAd]),
	NPCBilgi[id][npcSkin],
	NPCBilgi[id][npcPos][0],
	NPCBilgi[id][npcPos][1],
	NPCBilgi[id][npcPos][2],
	NPCBilgi[id][npcPos][3],
	NPCBilgi[id][npcVw],
	SQL_ReturnEscaped(NPCSecenekler[id][0]),
	SQL_ReturnEscaped(NPCSecenekCevaplar[id][0]),
	SQL_ReturnEscaped(NPCSecenekler[id][1]),
	SQL_ReturnEscaped(NPCSecenekCevaplar[id][1]),
	SQL_ReturnEscaped(NPCSecenekler[id][2]));
	format(query, sizeof(query), "%s, `Secenek3Cevap` = '%s', `Secenek4` = '%s', `Secenek4Cevap` = '%s', `Secenek5` = '%s', `Secenek5Cevap` = '%s' WHERE `npcID` = '%d'",
	query,
	SQL_ReturnEscaped(NPCSecenekCevaplar[id][2]),
	SQL_ReturnEscaped(NPCSecenekler[id][3]),
	SQL_ReturnEscaped(NPCSecenekCevaplar[id][3]),
	SQL_ReturnEscaped(NPCSecenekler[id][4]),
	SQL_ReturnEscaped(NPCSecenekCevaplar[id][4]),
	NPCBilgi[id][npcID]);
	mysql_query(g_SQL, query, false);
	return 1;
}

stock OyundaDegil(playerid)
{
	if (!IsPlayerConnected(playerid) || GetPVarInt(playerid, "Logged") == 0)
	{
	    return 0;
	}
	return 1;
}
stock SendNearbyMessage2(playerid, Float:radius, color, const str[], {Float,_}:...)
{
	static
	    args,
	    start,
	    end,
	    string[144]
	;
	#emit LOAD.S.pri 8
	#emit STOR.pri args

	if (args > 16)
	{
		#emit ADDR.pri str
		#emit STOR.pri start

	    for (end = start + (args - 16); end > start; end -= 4)
		{
	        #emit LREF.pri end
	        #emit PUSH.pri
		}
		#emit PUSH.S str
		#emit PUSH.C 144
		#emit PUSH.C string

		#emit LOAD.S.pri 8
		#emit CONST.alt 4
		#emit SUB
		#emit PUSH.pri

		#emit SYSREQ.C format
		#emit LCTRL 5
		#emit SCTRL 4

        foreach (new i : Player)
		{
			if (IsPlayerNearPlayer(i, playerid, radius) && i != playerid) {
  				SendClientMessage(i, color, string);
			}
		}
		return 1;
	}
 foreach (new i : Player)
	{
		if (IsPlayerNearPlayer(i, playerid, radius) && i != playerid) {
			SendClientMessage(i, color, str);
		}
	}
	return 1;
}
stock SendNearbyMessageEx(playerid, Float:radius, color, const str[], {Float,_}:...)
{
	static
	    args,
	    start,
	    end,
	    string[144]
	;
	#emit LOAD.S.pri 8
	#emit STOR.pri args

	if (args > 16)
	{
		#emit ADDR.pri str
		#emit STOR.pri start

	    for (end = start + (args - 16); end > start; end -= 4)
		{
	        #emit LREF.pri end
	        #emit PUSH.pri
		}
		#emit PUSH.S str
		#emit PUSH.C 144
		#emit PUSH.C string

		#emit LOAD.S.pri 8
		#emit CONST.alt 4
		#emit SUB
		#emit PUSH.pri

		#emit SYSREQ.C format
		#emit LCTRL 5
		#emit SCTRL 4

        foreach (new i : Player)
		{
			if (IsPlayerNearPlayer(i, playerid, radius)) {
  				SendClientMessage(i, color, string);
			}
		}
		return 1;
	}
 foreach (new i : Player)
	{
		if (IsPlayerNearPlayer(i, playerid, radius)) {
			SendClientMessage(i, color, str);
		}
	}
	return 1;
}
stock SendNearbyMessage(playerid, Float:radius, color, const str[], {Float,_}:...)
{
	static
	    args,
	    start,
	    end,
	    string[144]
	;
	#emit LOAD.S.pri 8
	#emit STOR.pri args

	if (args > 16)
	{
		#emit ADDR.pri str
		#emit STOR.pri start

	    for (end = start + (args - 16); end > start; end -= 4)
		{
	        #emit LREF.pri end
	        #emit PUSH.pri
		}
		#emit PUSH.S str
		#emit PUSH.C 144
		#emit PUSH.C string

		#emit LOAD.S.pri 8
		#emit CONST.alt 4
		#emit SUB
		#emit PUSH.pri

		#emit SYSREQ.C format
		#emit LCTRL 5
		#emit SCTRL 4

        foreach (new i : Player)
		{
			if (IsPlayerNearPlayer(i, playerid, radius)) {
  				SendClientMessage(i, color, string);
			}
		}
		return 1;
	}
 foreach (new i : Player)
	{
		if (IsPlayerNearPlayer(i, playerid, radius)) {
			SendClientMessage(i, color, str);
		}
	}
	return 1;
}
stock IsPlayerNearPlayer(playerid, targetid, Float:radius)
{
	static
		Float:fX,
		Float:fY,
		Float:fZ;

	GetPlayerPos(targetid, fX, fY, fZ);

	return (GetPlayerInterior(playerid) == GetPlayerInterior(targetid) && GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(targetid)) && IsPlayerInRangeOfPoint(playerid, radius, fX, fY, fZ);
}

stock Oyuncu_Kaydet(playerid, disconnect=1)
{
	if (GetPVarInt(playerid, "Logged") == 0)
		return 1;

	new query[6000];
	new Float:pos[3], birliksqlid;
	if (PlayerData[playerid][pFaction] == -1) birliksqlid = -1;
	else birliksqlid = Birlikler[PlayerData[playerid][pFaction]][birlikID];
	if (GetPVarInt(playerid, "inPaintball") == 0) GetPlayerPos(playerid,pos[0],pos[1],pos[2]);
	else
	{
	    pos[0] = 1170.9122;
	    pos[1] = -1489.6418;
	    pos[2] = 22.7551;
	    SetPlayerVirtualWorld(playerid, 0);
	    SetPlayerInterior(playerid, 0);
	}
	GetPlayerHealth(playerid,PlayerData[playerid][pHealth]);
	GetPlayerArmour(playerid,PlayerData[playerid][pArmour]);

	format(query, sizeof(query), "UPDATE `oyuncular` SET `Yas` = '%d', `Cinsiyet` = '%d', `DogumYeri` = '%s', `Skin` = '%d', `TenRengi` = '%d', `CikisInt` = '%d', `CikisX` = '%f', `CikisY` = '%f', `CikisZ` = '%f', `CikisWorld` = '%d', `AdminLevel` = '%d', `Helper` = '%d', `oyungorevlisi` = '%d', `forumgorevlisi` = '%d', `Cash` = '%d', `AdminName` = '%s', `Ehliyet` = '%d', `MotorEhliyet` = '%d'",
    PlayerData[playerid][pYas],
	PlayerData[playerid][pCinsiyet],
	PlayerData[playerid][pDogum],
	PlayerData[playerid][pSkin],
	PlayerData[playerid][pTen],
	GetPlayerInterior(playerid),
	pos[0],
	pos[1],
	pos[2],
	GetPlayerVirtualWorld(playerid),
	PlayerData[playerid][pAdmin],
	PlayerData[playerid][pHelper],
	PlayerData[playerid][pOyunGorevlisi],
	PlayerData[playerid][pForumGorevlisi],
	PlayerData[playerid][pCash],
	PlayerData[playerid][pAdminName],
	PlayerData[playerid][pEhliyet],
	PlayerData[playerid][pMotorEhliyet]);

	format(query, sizeof(query), "%s, `House` = '%d',`Business` = '%d',`Birlik` = '%d',`BirlikRutbe` = '%d',`BirlikDivizyon` = '%d', `Su` = '%d', `Health` = '%.4f', `Armour` = '%.4f',`OnDuty` = '%d',`OnDutySkin` = '%d', `Aranma` = '%d', `Hapis` = '%d', `HapisSure` = '%d', `HapisSebep` = '%s', `HapiseAtan` = '%s', `Telefon` = '%d'",
	query,
	PlayerData[playerid][pHouse],
	PlayerData[playerid][pIsyeri],
	PlayerData[playerid][pFaction],
	PlayerData[playerid][pFactionRutbe],
	PlayerData[playerid][pFactionDivizyon],
	PlayerData[playerid][pSu],
	PlayerData[playerid][pHealth],
	PlayerData[playerid][pArmour],
	PlayerData[playerid][pOnDuty],
	PlayerData[playerid][pOnDutySkin],
	PlayerData[playerid][pAranma],
 	PlayerData[playerid][pHapis],
 	PlayerData[playerid][pHapisSure],
 	PlayerData[playerid][pHapisSebep],
 	PlayerData[playerid][pHapiseAtan],
    PlayerData[playerid][pTelefon]);
    new a;
    for (new i = 0; i < 13; i ++) {
        if (i<10)
	    {
		    format(query,sizeof(query), "%s, `Balik%d` = '%d',`BalikGram%d` = '%d'",query, i+1,PlayerData[playerid][pBalikID][i],i+1,PlayerData[playerid][pBalikGram][i]);
	    }
	    GetPlayerWeaponData(playerid, i, a, PlayerData[playerid][pMermiler][i]);
	    format(query, sizeof(query), "%s, `Silah%d` = '%d', `Mermi%d` = '%d'", query, i + 1, PlayerData[playerid][pSilahlar][i], i + 1, PlayerData[playerid][pMermiler][i]);
	}

    format(query, sizeof(query), "%s, `Tarife` = '%d', `KalanDK` = '%d', `KalanSMS` = '%d', `KalanNet` = '%d', `TarifeSure` = '%d', `Bitcoin` = '%d', `Boombox` = '%d', `Radyo` = '%d', `Frekans` = '%d', `Materyal` = '%d', `SilahHakki` = '%d', `SilahSuresi` = '%d', `Level` = '%d', `EXP` = '%d', `MaasSure` = '%d', `OynamaSaati` = '%d', `Maas` = '%d', `Dinle` = '%d'",
    query,
    PlayerData[playerid][pTarife],
	PlayerData[playerid][pTarifeKalan][0],
	PlayerData[playerid][pTarifeKalan][1],
	PlayerData[playerid][pTarifeKalan][2],
	PlayerData[playerid][pTarifeSure],
	PlayerData[playerid][pBitcoin],
	PlayerData[playerid][pBoombox],
	PlayerData[playerid][pRadyo],
	PlayerData[playerid][pFrekans],
	PlayerData[playerid][pMateryal],
	PlayerData[playerid][pSilahHakki],
	PlayerData[playerid][pSilahSuresi],
	PlayerData[playerid][pLevel],
    PlayerData[playerid][pEXP],
	PlayerData[playerid][pMaasSure],
	PlayerData[playerid][pOynamaSaati],
	PlayerData[playerid][pMaas],
	PlayerData[playerid][pDinle]);

	format(query, sizeof(query), "%s, `Zar` = '%d', `Sigara` = '%d', `ip` = '%d',`GozBagi` = '%d', `Maske` = '%d', `BenzinKutusu` = '%d', `Barbeku` = '%d', `Kofte` = '%d', `Tavuk` = '%d', `Dana` = '%d', `TamirKiti` = '%d', `Cadir` = '%d', `KampAtes` = '%d', `Sarjor` = '%d', `YanKeski` = '%d', `SeferSayi` = '%d'",
	query,
	PlayerData[playerid][pEsyalar][0],
	PlayerData[playerid][pEsyalar][1],
	PlayerData[playerid][pEsyalar][2],
    PlayerData[playerid][pEsyalar][3],
    PlayerData[playerid][pEsyalar][4],
    PlayerData[playerid][pEsyalar][5],
    PlayerData[playerid][pEsyalar][6],
    PlayerData[playerid][pEsyalar][7],
    PlayerData[playerid][pEsyalar][8],
    PlayerData[playerid][pEsyalar][9],
    PlayerData[playerid][pEsyalar][10],
    PlayerData[playerid][pEsyalar][11],
    PlayerData[playerid][pEsyalar][12],
    PlayerData[playerid][pEsyalar][13],
    PlayerData[playerid][pEsyalar][14],
	PlayerData[playerid][pSeferSayi]);

    format(query, sizeof(query), "%s, `Bagimlilik` = '%d', `TasimacilikSeviye` = '%d', `TasimacilikSefer` = '%d', `Garage` = '%d', `Bakiye` = '%d', `EXPBoost` = '%d', `BalikOrani` = '%d', `Vip` = '%d', `VipSure` = '%d', `DovusStili` = '%d', `MaskeID` = '%d', `MaskeHakki` = '%d', `Ayarlar` = '%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d|%d'",
    query,
    PlayerData[playerid][pBagimlilik],
    PlayerData[playerid][pTasimacilikSeviye],
    PlayerData[playerid][pTasimacilikSefer],
    PlayerData[playerid][pGarage],
    PlayerData[playerid][pBakiye],
    PlayerData[playerid][pEXPBoost],
    PlayerData[playerid][pBalikOrani],
    PlayerData[playerid][pVip],
    PlayerData[playerid][pVipSure],
  	PlayerData[playerid][pDovusStili],
    PlayerData[playerid][pMaskeID],
    PlayerData[playerid][pMaskeHakki],
    PlayerData[playerid][pAyarlar][0],
    PlayerData[playerid][pAyarlar][1],
    PlayerData[playerid][pAyarlar][2],
    PlayerData[playerid][pAyarlar][3],
    PlayerData[playerid][pAyarlar][4],
    PlayerData[playerid][pAyarlar][5],
    PlayerData[playerid][pAyarlar][6],
    PlayerData[playerid][pAyarlar][7],
    PlayerData[playerid][pAyarlar][8],
    PlayerData[playerid][pAyarlar][9],
    PlayerData[playerid][pAyarlar][10],
    PlayerData[playerid][pAyarlar][11],
    PlayerData[playerid][pAyarlar][12],
    PlayerData[playerid][pAyarlar][13],
    PlayerData[playerid][pAyarlar][14]);

    format(query, sizeof(query), "%s, `BirlikSQLID` = '%d', `Baygin` = '%d', `BayginSure` = '%d', `Partner` = '%d', `hddserial` = '%s', `Hediye` = '%d', `HediyeSaat` = '%d', `Youtuber` = '%d', `Oyunda` = '%d', `Oldurme` = '%d', `Olme` = '%d', `TalepSayi` = '%d', `CK` = '%d', `Parca0` = '%d', `Parca1` = '%d', `Parca2` = '%d'",
    query,
	birliksqlid,
    PlayerData[playerid][pBaygin],
    PlayerData[playerid][pBayginSure],
    PlayerData[playerid][pPartner],
    PlayerData[playerid][pSerial],
    PlayerData[playerid][pHediye],
    PlayerData[playerid][pHediyeSaat],
    PlayerData[playerid][pYoutuber],
    disconnect,
    PlayerData[playerid][pOldurme],
    PlayerData[playerid][pOlme],
    PlayerData[playerid][pTalepSayi],
    PlayerData[playerid][pCK],
	PlayerData[playerid][pSilahParca][0],
	PlayerData[playerid][pSilahParca][1],
	PlayerData[playerid][pSilahParca][2]);

    format(query, sizeof(query), "%s, `portakaltohum` = '%d', `elmatohum` = '%d', `armuttohum` = '%d',`SilahAlmaSayisi` = '%d', `SilahAlma` = '%d', `Sirket` = '%d', `SirketID` = '%d', `SirketRank` = '%d', `SirketMaas` = '%d' WHERE `ID` = '%d'",
    query,
    PlayerData[playerid][pTohumlar][0],
	PlayerData[playerid][pTohumlar][1],
	PlayerData[playerid][pTohumlar][2],
	PlayerData[playerid][pSilahAlmaSayisi],
    PlayerData[playerid][pSilahAlma],
	PlayerData[playerid][pSirket],
	PlayerData[playerid][pSirketID],
	PlayerData[playerid][pSirketRank],
	PlayerData[playerid][pSirketMaas],
	PlayerData[playerid][pID]);

	mysql_tquery(g_SQL, query, "OyuncuKaydedildi", "d", playerid);

	mysql_format(g_SQL, query, sizeof query, "UPDATE `oyuncular` SET `Kelepce` = '%d' WHERE `ID` = '%d'", PlayerData[playerid][pKelepce], PlayerData[playerid][pID]);
	mysql_query (g_SQL, query);

/*	mysql_format(g_SQL, query, sizeof query, "UPDATE `oyuncular` SET `Meslek` = '%d' WHERE `ID` = '%d'", Meslek[playerid], PlayerData[playerid][pID]);
	mysql_query (g_SQL, query);

	mysql_format(g_SQL, query, sizeof query, "UPDATE `oyuncular` SET `Yemler` = '%d|%d|%d' WHERE `ID` = '%d'", PlayerData[playerid][pYemTurleri][KARIDES], PlayerData[playerid][pYemTurleri][SULUNES], PlayerData[playerid][pYemTurleri][EKMEK_KIRINTISI], PlayerData[playerid][pID]);
	mysql_query (g_SQL, query);*/
	return 1;
}
stock SoyadKilitlimi(soyad[])
{
    new query[125], Cache: owner_query;
    mysql_format(g_SQL, query, sizeof(query), "SELECT * FROM `kilitlisoyadlar` WHERE `Soyad` = '%s'", SQL_ReturnEscaped(soyad));
    owner_query = mysql_query(g_SQL, query);
    new rows;
    cache_get_row_count(rows);
    if (rows)
    {
        return 1;
    }
    cache_delete(owner_query);
    return 0;
}

stock SetWeapons(playerid)
{
	ResetPlayerWeapons(playerid);

	for (new i = 0; i < 13; i ++)
	{
		if (PlayerData[playerid][pSilahlar][i] > 0 && PlayerData[playerid][pMermiler][i] > 0)
		{
			GivePlayerWeapon(playerid, PlayerData[playerid][pSilahlar][i], PlayerData[playerid][pMermiler][i]);
			SetPlayerArmedWeapon(playerid, 0);
		}
	}
	return 1;
}

stock GetIP(playerid)
{
	new pip[16];
	GetPlayerIp(playerid, pip, sizeof(pip));
	return pip;
}
ReturnDate()
{
	static
	    date[36];

	getdate(date[2], date[1], date[0]);
	gettime(date[3], date[4], date[5]);

	format(date, sizeof(date), "%02d/%02d/%d, %02d:%02d", date[0], date[1], date[2], date[3], date[4]);
	return date;
}
IsNumeric(const str[])
{
	for (new i = 0, l = strlen(str); i != l; i ++)
	{
	    if (i == 0 && str[0] == '-')
			continue;

	    else if (str[i] < '0' || str[i] > '9')
			return 0;
	}
	return 1;
}

stock BilgiSifirla(playerid)
{
    PlayerData[playerid][pYaris] = -1;
    PlayerData[playerid][pYarisHazirliyormu] = -1;
	PlayerData[playerid][pID] = 0;
	PlayerData[playerid][pYas] = 0;
	PlayerData[playerid][pCinsiyet] = 0;
	Sandalye[playerid] = 0;
	PlayerData[playerid][pTen] = 0;
	PlayerData[playerid][pSkin] = 0;
	PlayerData[playerid][pAdmin] = 0;
	PlayerData[playerid][pHelper] = 0;
	PlayerData[playerid][pOyunGorevlisi] = 0;
	PlayerData[playerid][pForumGorevlisi] = 0;
	PlayerData[playerid][pCash] = 0;
	SandalyeObjem[playerid] = -1;
	PlayerData[playerid][pAdminDuty] = false;
	PlayerData[playerid][pHelperDuty] = 0;
	PlayerData[playerid][pCimentoTasiyor1] = 0;
	PlayerData[playerid][pCimentoTasiyor2] = 0;
	PlayerData[playerid][pEhliyet] = 0;
	PlayerData[playerid][pMotorEhliyet] = 0;
	PlayerData[playerid][pLastCar] = -1;
	PlayerData[playerid][pDuzenlenenPompa] = -1;
	PlayerData[playerid][pEditGate] = -1;
	PlayerData[playerid][pEditType] = 0;
	PlayerData[playerid][SonMesajGonderen] = -1;
	PlayerData[playerid][pHouse] = -1;
	PlayerData[playerid][pFaction] = -1;
	PlayerData[playerid][pFactionRutbe] = 0;
	PlayerData[playerid][pFactionDivizyon] = 0;
	PlayerData[playerid][pEditFurniture] = -1;
	PlayerData[playerid][pFactionDavet] = -1;
	PlayerData[playerid][pFactionDavetEden] = -1;
	PlayerData[playerid][pFactionEdit] = -1;
	PlayerData[playerid][pSelectedSlot] = -1;
	PlayerData[playerid][pSu] = 0;
	PlayerData[playerid][pHealth] = 100.0;
	PlayerData[playerid][pArmour] = 0.0;
	PlayerData[playerid][pOnDuty] = 0;
	PlayerData[playerid][pOnDutySkin] = 0;
	PlayerData[playerid][pTazer] = 0;
	PlayerData[playerid][pBeanbag] = 0;
	PlayerData[playerid][pSoklandi] = 0;
	PlayerData[playerid][pKelepce] = 0;
	PlayerData[playerid][pDestek] = 0;
	PlayerData[playerid][pCCTV] = -1;
	PlayerData[playerid][pYereYatirildi] = 0;
	PlayerData[playerid][pAranma] = 0;
	PlayerData[playerid][pHapis] = 0;
	PlayerData[playerid][pHapisSure] = 0;
	format(PlayerData[playerid][pHapisSebep], 50, "");
	format(PlayerData[playerid][pHapiseAtan], 24, "");
	PlayerData[playerid][pBaygin] = 0;
	PlayerData[playerid][pBayginSure] = 0;
	PlayerData[playerid][pLoopAnim] = false;
	PlayerData[playerid][pIyilestiriyor] = -1;
	PlayerData[playerid][pIyilestirmeSure] = 0;
	PlayerData[playerid][pTopallama] = false;
	PlayerData[playerid][pTopallamaSayac] = 0;
	PlayerData[playerid][pTelefon] = -1;
	PlayerData[playerid][pAramada] = 0;
	PlayerData[playerid][pCallLine] = -1;
	PlayerData[playerid][pTarife] = -1;
	PlayerData[playerid][pTarifeKalan][0] = 0;
	PlayerData[playerid][pTarifeKalan][1] = 0;
	PlayerData[playerid][pTarifeKalan][2] = 0;
	PlayerData[playerid][pTarifeSure] = 0;
	PlayerData[playerid][pKonusmaSure] = 0;
	format(PlayerData[playerid][pIhbar], 128, "");
	format(PlayerData[playerid][pBasariPBTarih], 25, "Yapýlmadý");
	format(PlayerData[playerid][pBasariEvTarih], 25, "Yapýlmadý");
	format(PlayerData[playerid][pBasariAracTarih], 25, "Yapýlmadý");
	format(PlayerData[playerid][pBasari5Tarih], 25, "Yapýlmadý");
	format(PlayerData[playerid][pBasari10Tarih], 25, "Yapýlmadý");
	PlayerData[playerid][pMateryal] = 0;
	PlayerData[playerid][pSilahHakki] = 0;
	PlayerData[playerid][pSilahSuresi] = 0;
	PlayerData[playerid][pSilahParca][0] = 0;
	PlayerData[playerid][pSilahParca][1] = 0;
	PlayerData[playerid][pSilahParca][2] = 0;
	PlayerData[playerid][pBasariPB] = 0;
	PlayerData[playerid][pBasari5] = 0;
	PlayerData[playerid][pBasari10] = 0;
	PlayerData[playerid][pBasariEv] = 0;
	PlayerData[playerid][pBasariArac] = 0;
	PlayerData[playerid][pBoombox] = 0;
	PlayerData[playerid][pIhbarSayac] = 0;
	PlayerData[playerid][pBitcoin] = 0;
	PlayerData[playerid][pGPS] = -1;
	PlayerData[playerid][pRadyo] = 0;
	PlayerData[playerid][pFrekans] = 0;
	PlayerData[playerid][pLevel] = 1;
	PlayerData[playerid][pEXP] = 0;
	PlayerData[playerid][pMaasSure] = 0;
	PlayerData[playerid][pMaas] = 0;
	PlayerData[playerid][pOynamaSaati] = 0;
	PlayerData[playerid][pMuzikKutusu] = INVALID_PLAYER_ID;
	PlayerData[playerid][pDinle] = -1;
	PlayerData[playerid][yayinKonuk] = -1;
	PlayerData[playerid][pMangalKuruldu] = false;
	PlayerData[playerid][pCadir] = -1;
	PlayerData[playerid][pSilahOffer] = -1;
	PlayerData[playerid][pSilahOfferID] = 0;
	PlayerData[playerid][pSilahOfferFiyat] = 0;
	DestroyDynamicObject(PlayerData[playerid][pMangalObject][0]);
	DestroyDynamicObject(PlayerData[playerid][pMangalObject][1]);
	PlayerData[playerid][pYemekPisiriliyor] = 0;
	PlayerData[playerid][pPisirilenYemek] = 0;
	PlayerData[playerid][pBagimlilik] = 0;
	PlayerData[playerid][pBagimlilikSayac][0] = PlayerData[playerid][pBagimlilikSayac][1] = 0;
	PlayerData[playerid][pTasimacilikSeviye] = PlayerData[playerid][pTasimacilikSefer] = 0;
	PlayerData[playerid][pGarage] = -1;
	PlayerData[playerid][pBakiye] = 0;
	PlayerData[playerid][pEXPBoost] = PlayerData[playerid][pBalikOrani] = 0;
	PlayerData[playerid][pVip] = PlayerData[playerid][pVipSure] = 0;
	PlayerData[playerid][pVipRenk] = 0;
	PlayerData[playerid][pDovusStili] = 4;
	PlayerData[playerid][pMaske] = false;
	PlayerData[playerid][pMaskeID] = 0;
	PlayerData[playerid][pMaskeHakki] = 0;
	PlayerData[playerid][pGraffiti] = 0;
	PlayerData[playerid][pSpecID] = -1;
	PlayerData[playerid][pNameChange][0] = '\0';
	PlayerData[playerid][pJetpack] = 0;
	PlayerData[playerid][pGOD] = false;
	PlayerData[playerid][pFriskOffer] = INVALID_PLAYER_ID;
	PlayerData[playerid][pShakeOffer] = INVALID_PLAYER_ID;
 	PlayerData[playerid][pShakeType] = 0;
 	PlayerData[playerid][pHUD] = true;
 	PlayerData[playerid][pStand] = false;
 	PlayerData[playerid][pPartner] = 0;
 	PlayerData[playerid][pPartnerTeklif] = INVALID_PLAYER_ID;
 	PlayerData[playerid][pShootedBody] = -1;
 	PlayerData[playerid][pLastShot] = INVALID_PLAYER_ID;
 	PlayerData[playerid][pTaxiCalled] = 0;
 	PlayerData[playerid][pTaksiKabul] = -1;
 	PlayerData[playerid][pTaxiDuty] = false;
 	PlayerData[playerid][pTaksiUcret] = 0;
 	PlayerData[playerid][pTaxiPlayer] = -1;
 	PlayerData[playerid][pSoyun] = false;
 	PlayerData[playerid][pHediye] = 0;
 	PlayerData[playerid][pHediyeSaat] = 0;
 	PlayerData[playerid][pYoutuber] = 0;
 	PlayerData[playerid][pYoutuberTag] = false;
 	PlayerData[playerid][pSelectType] = 0;
 	PlayerData[playerid][pOldurme] = 0;
 	PlayerData[playerid][pOlme] = 0;
 	PlayerData[playerid][pTalepSayi] = 0;
 	PlayerData[playerid][pYatKontrol][0] = 0;
    PlayerData[playerid][pCK] = 0;
 	PlayerData[playerid][pSilahAlmaSayisi] = 0;
	PlayerData[playerid][pSilahAlma] = 0;
	PlayerData[playerid][pLSPDUydu] = false;
 	TohumSayisi[playerid] = 0;
 	TohumTutuyor[playerid] = -1;
 	if (IsValidDynamicCP(TohumCP[playerid])) DestroyDynamicCP(TohumCP[playerid]);
 	SetPVarInt(playerid, "ssmod", 0);
 	TextDrawHideForPlayer(playerid, Karanlik);
 	DeletePVar(playerid, "AksesuarEdit");
 	SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL, 5);
 	SetPlayerSkillLevel(playerid, WEAPONSKILL_MICRO_UZI, 5);
 	SonMobilyaID[playerid] = -1;
 	SetPVarInt(playerid, "KOSKorumasi", 0);
 	DeletePVar(playerid, "OdadanAt");
 	pbOda[playerid] = -1;
 	pbTakim[playerid] = 0;
 	pbOldurme[playerid] = 0;
 	pbOlme[playerid] = 0;
	SetPVarInt(playerid, "GraffitiEdit", -1);
	DeletePVar(playerid, "HizAsimi");
	SetPVarInt(playerid, "AracSakliyor", -1);
	SetPVarInt(playerid, "pnsID", -1);
	CurrentAccountID[playerid] = -1;
	LogListType[playerid] = TYPE_NONE;
	LogListPage[playerid] = 0;
	EditingATMID[playerid] = -1;
	EditingCopObjectID[playerid] = -1;
	TextDrawHideForPlayer(playerid, Karanlik);
	SetPVarInt(playerid, "IpBaglandi", 0);
	SetPVarInt(playerid, "GozBaglandi", 0);
	SetPVarInt(playerid, "KonumKabul", -1);
	SetPVarInt(playerid, "IsyeriBuluyor", -1);
	EMSKabul[playerid] = INVALID_PLAYER_ID;
	SetPVarInt(playerid, "EvBuluyor", -1);
	SetPVarInt(playerid, "BinaBuluyor", -1);
	DeletePVar(playerid, "Arayan");
	DeletePVar(playerid, "MaasGeldi");
    DeletePVar(playerid, "MaasTimer");
    DeletePVar(playerid, "MaasKod");
	DeletePVar(playerid, "IlkBalik");
	DeletePVar(playerid, "AracaBindi");
	DeletePVar(playerid, "Iyilestiriliyor");
	PetKontrol[playerid] = -1;
	AracCekiyor[playerid] = INVALID_VEHICLE_ID;
	ResetPlayerDamages(playerid);
	CevapSifirla(playerid);
	SigaraDurum[playerid] = false;
	SetPVarInt(playerid, "kumar_id", INVALID_PLAYER_ID);
	if (PlayerData[playerid][pDragged])
	{
	    PlayerData[playerid][pDragged] = 0;
	    PlayerData[playerid][pDraggedBy] = INVALID_PLAYER_ID;
	    KillTimer(PlayerData[playerid][pDragTimer]);
	}
	foreach (new i:Player)
	{
	    if (PlayerData[i][pDraggedBy] == playerid) {
		    KillTimer(PlayerData[i][pDragTimer]);

		    PlayerData[i][pDragged] = 0;
            PlayerData[i][pDraggedBy] = INVALID_PLAYER_ID;
		}
	}
 	DestroyPlayerProgressBar(playerid, PlayerData[playerid][pDrinkBar]);
 	PlayerData[playerid][pDrinkBar] = INVALID_PLAYER_BAR_ID;
 	BalikTimer[playerid] = -1;
	for (new i; i<13; i++)
	{
	    if (i < 10)
	    {
		    PlayerData[playerid][pBalikID][i] = -1;
		    PlayerData[playerid][pBalikGram][i] = 0;
	    }
	    if (i < 5)
	    {
	    	PlayerData[playerid][pTelefonAyar][i] = 0;
	    }
	    PlayerData[playerid][pSilahlar][i] = 0;
	    PlayerData[playerid][pMermiler][i] = 0;
	    PlayerData[playerid][pEsyalar][i] = 0;
	    PlayerData[playerid][pAyarlar][i] = 0;
	}
	PlayerData[playerid][pAyarlar][14] = 0;
	PlayerData[playerid][pEsyalar][13] = 0;
	PlayerData[playerid][pEsyalar][14] = 0;
	PlayerData[playerid][pAyarlar][4] = 1;
	for (new j = 0; j < 10; j ++) {
			PlayerData[playerid][pARenk][j] = 0;
	    	AksesuarData[playerid][j][j] = 0.0;
	    	PlayerData[playerid][pASlot][j] = 0;
	    	PlayerData[playerid][pTSlot][j] = 0;
	    	PlayerData[playerid][pABone][j] = 0;
	    }
	for (new i = 0; i != MAX_PLAYER_TICKETS; i ++) {
        TicketData[playerid][i][ticketID] = 0;
        TicketData[playerid][i][ticketExists] = false;
        TicketData[playerid][i][ticketFee] = 0;
    }
    RemovePlayerAttachedObject(playerid,2);
    RemovePlayerAttachedObject(playerid,3);
    RemovePlayerAttachedObject(playerid,4);
    RemovePlayerAttachedObject(playerid,6);
	DeletePVar(playerid, "davet");
	SetPVarInt(playerid, "mobilyaid",-1);
	RemovePlayerAttachedObject(playerid,1);
	RemovePlayerAttachedObject(playerid,5);
	DeletePVar(playerid, "ehliyethata");
	DeletePVar(playerid, "ehliyetaliyor");
	DeletePVar(playerid, "ehliyetsinavinda");
	DeletePVar(playerid, "Logged");
	DeletePVar(playerid, "Kayit");
	DeletePVar(playerid, "hata");
	DeletePVar(playerid, "Sifre");
	DeletePVar(playerid, "Yas");
	DeletePVar(playerid, "dogum");
	DeletePVar(playerid, "Sex");

	KillTimer(PlayerData[playerid][Timer_Yuk]);
	PlayerData[playerid][Timer_Yuk] = -1;
	PlayerData[playerid][pEhliyetSinavinda] = 0;
	PlayerData[playerid][pEhliyetUyari] = 0;
	PlayerData[playerid][pSeferSayi] = 0;
	MeslekCP[playerid] = -1;
	CimentoCP[playerid] = -1;

	PlayerData[playerid][pSirketOffer] = -1;
    PlayerData[playerid][pSirketOffered] = -1;
    PlayerData[playerid][pSirket] = -1;
    PlayerData[playerid][pSirketID] = -1;
    PlayerData[playerid][pSirketRank] = -1;
    PlayerData[playerid][pSirketMaas] = -1;

	pCBugging[playerid] = false;
	return 1;
}
stock TurkceKarakter(yazi[])
{
	if (strfind(yazi, "þ", true) != -1) return 1;
	if (strfind(yazi, "Þ", true) != -1) return 1;
	if (strfind(yazi, "ç", true) != -1) return 1;
	if (strfind(yazi, "Ç", true) != -1) return 1;
	if (strfind(yazi, "ö", true) != -1) return 1;
	if (strfind(yazi, "Ö", true) != -1) return 1;
	if (strfind(yazi, "ð", true) != -1) return 1;
	if (strfind(yazi, "Ð", true) != -1) return 1;
	if (strfind(yazi, "ü", true) != -1) return 1;
	if (strfind(yazi, "Ü", true) != -1) return 1;
	return 0;
}

stock GetPlayerLastName(playerid, soyad[], nm = 0)
{
    new
        namestring[2][MAX_PLAYER_NAME];

    if (nm)
	{
        new name[MAX_PLAYER_NAME];

        GetPlayerName(playerid,name,MAX_PLAYER_NAME);
        split(name, namestring, '_');
    }
	else
	{
        split(soyad, namestring, '_');
    }
    return namestring[1];
}

stock split(const strsrc[], strdest[][], delimiter)
{
    new i, li;
    new aNum;
    new len;

    while (i <= strlen(strsrc))
    {
        if (strsrc[i] == delimiter || i == strlen(strsrc))
        {
            len = strmid(strdest[aNum], strsrc, li, i, 128);
            strdest[aNum][len] = 0;
            li = i+1;
            aNum++;
        }
        i++;
    }
    return 1;
}

stock IsValidRoleplayName(const name[])
{
	if (!name[0] || strfind(name, "_") == -1)
	    return 0;

	else for (new i = 0, len = strlen(name); i != len; i ++) {
	    if ((i == 0) && (name[i] < 'A' || name[i] > 'Z'))
	        return 0;

		else if ((i != 0 && i < len  && name[i] == '_') && (name[i + 1] < 'A' || name[i + 1] > 'Z'))
		    return 0;

		else if ((name[i] < 'A' || name[i] > 'Z') && (name[i] < 'a' || name[i] > 'z') && name[i] != '_' && name[i] != '.')
		    return 0;
	}
	return 1;
}

stock EkranTemizle(playerid)
{
	for (new i; i < 25; i++)
	{
	    SendClientMessage(playerid, 0xFFFFFFFF, "");
	}
	return 1;
}

ReturnName(playerid, underscore = 1, nt = -1)
{
	static
	    name[MAX_PLAYER_NAME + 1];

	GetPlayerName(playerid, name, sizeof(name));

	if (underscore != 1)
	{
	    for (new i = 0, len = strlen(name); i < len; i ++)
		{
	        if (name[i] == '_')
				name[i] = ' ';
		}
	}

	if (PetKontrol[playerid] != -1 && GetPVarInt(playerid, "Logged") == 1) format(name, sizeof(name), "%s", PetBilgi[PetKontrol[playerid]][petAdi]);

	if (PlayerData[playerid][pMaske] == true && PetKontrol[playerid] == -1 && nt == -1)
	    format(name, sizeof(name), "Gizli #%d", PlayerData[playerid][pMaskeID]);

	return name;
}
stock SendClientMessageToAllEx(color, const text[], {Float, _}:...)
{
    static
        args,
        str[512];

    /*
     *  Custom function that uses #emit to format variables into a string.
     *  This code is very fragile; touching any code here will cause crashing!
    */
    if ((args = numargs()) == 2)
    {
        SendClientMessageToAll(color, text);
    }
    else
    {
        while (--args >= 2)
        {
            #emit LCTRL 5
            #emit LOAD.alt args
            #emit SHL.C.alt 2
            #emit ADD.C 12
            #emit ADD
            #emit LOAD.I
            #emit PUSH.pri
        }
        #emit PUSH.S text
        #emit PUSH.C 144
        #emit PUSH.C str
        #emit LOAD.S.pri 8
        #emit ADD.C 4
        #emit PUSH.pri
        #emit SYSREQ.C format
        #emit LCTRL 5
        #emit SCTRL 4

        SendClientMessageToAll(color, str);

        #emit RETN
    }
    return 1;
}
stock SendVehicleMessage(except, vehicleid, color, const str[], {Float,_}:...)
{
	static
	    args,
	    start,
	    end,
	    string[144]
	;
	#emit LOAD.S.pri 8
	#emit STOR.pri args

	if (args > 12)
	{
		#emit ADDR.pri str
		#emit STOR.pri start

	    for (end = start + (args - 12); end > start; end -= 4)
		{
	        #emit LREF.pri end
	        #emit PUSH.pri
		}
		#emit PUSH.S str
		#emit PUSH.C 144
		#emit PUSH.C string
		#emit PUSH.C args

		#emit SYSREQ.C format
		#emit LCTRL 5
		#emit SCTRL 4

		foreach (new i : Player) if (GetPlayerVehicleID(i) == vehicleid && i != except ) {
		    SendClientMessage(i, color, string);
		}
		return 1;
	}
	foreach (new i : Player) if (GetPlayerVehicleID(i) == vehicleid && i != except) {
 		SendClientMessage(i, color, string);
	}
	return 1;
}
stock SendClientMessageEx(playerid, color, const text[], {Float, _}:...)
{
	static
	    args,
	    str[144];

	/*
     *  Custom function that uses #emit to format variables into a string.
     *  This code is very fragile; touching any code here will cause crashing!
	*/
	if ((args = numargs()) == 3)
	{
	    SendClientMessage(playerid, color, text);
	}
	else
	{
		while (--args >= 3)
		{
			#emit LCTRL 5
			#emit LOAD.alt args
			#emit SHL.C.alt 2
			#emit ADD.C 12
			#emit ADD
			#emit LOAD.I
			#emit PUSH.pri
		}
		#emit PUSH.S text
		#emit PUSH.C 144
		#emit PUSH.C str
		#emit PUSH.S 8
		#emit SYSREQ.C format
		#emit LCTRL 5
		#emit SCTRL 4

		SendClientMessage(playerid, color, str);

		#emit RETN
	}
	return 1;
}
stock SoruEkle(soru[], siklar[], cevap)
{
	format(Quiz[SonSoruID], 1024, "%s", soru);
	Cevaplar[SonSoruID] = cevap;
	format(Siklar[SonSoruID], 1024, "%s", siklar);
	SonSoruID++;
	return 1;
}

stock SoruSor(playerid)
{
	soru_al:
	new id = random(SonSoruID);

	if (SoruSoruldu[playerid][id]) goto soru_al;
	Dialog_Show(playerid, SoruCevapla, DIALOG_STYLE_LIST, Quiz[id], Siklar[id], "Seç", "");
	SoruID[playerid] = id;
	SoruSoruldu[playerid][id] = 1;
	return 1;
}

stock CevapSifirla(playerid)
{
    SoruID[playerid] = -1;
	CevaplananSoru[playerid] = 0;
	YanlisCevap[playerid] = 0;
	for (new i; i < MAX_QUIZ; i++) SoruSoruldu[playerid][i] = 0;
	return 1;
}
Fuel_InitPlayer(playerid)
{
	UsingPumpID[playerid] = -1;
	RefuelTimer[playerid] = -1;
	FuelBought[playerid] = 0;

	FuelText[playerid] = CreatePlayerTextDraw(playerid, 40.000000, 305.000000, "~b~~h~Dolduruluyor...~n~~n~~w~Fiyat: ~g~~h~$0 ~y~~h~(0 L)");
	PlayerTextDrawBackgroundColor(playerid, FuelText[playerid], 255);
	PlayerTextDrawFont(playerid, FuelText[playerid], 1);
	PlayerTextDrawLetterSize(playerid, FuelText[playerid], 0.240000, 1.100000);
	PlayerTextDrawColor(playerid, FuelText[playerid], -1);
	PlayerTextDrawSetOutline(playerid, FuelText[playerid], 1);
	PlayerTextDrawSetProportional(playerid, FuelText[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, FuelText[playerid], 0);
	return 1;
}

Vehicle_IsANoFuelVehicle(model)
{
	switch (model)
	{
		case 481, 509, 510: return 1;
		default: return 0;
	}
	return 0;
}

formatInt(intVariable, iThousandSeparator = ',', iCurrencyChar = '$')
{
    /*
		By Kar
		https://gist.github.com/Kar2k/bfb0eafb2caf71a1237b349684e091b9/8849dad7baa863afb1048f40badd103567c005a5#file-formatint-function
	*/
	static
		s_szReturn[ 32 ],
		s_szThousandSeparator[ 2 ] = { ' ', EOS },
		s_szCurrencyChar[ 2 ] = { ' ', EOS },
		s_iVariableLen,
		s_iChar,
		s_iSepPos,
		bool:s_isNegative
	;

	format( s_szReturn, sizeof( s_szReturn ), "%d", intVariable );

	if (s_szReturn[0] == '-')
		s_isNegative = true;
	else
		s_isNegative = false;

	s_iVariableLen = strlen( s_szReturn );

	if ( s_iVariableLen >= 4 && iThousandSeparator)
	{
		s_szThousandSeparator[ 0 ] = iThousandSeparator;

		s_iChar = s_iVariableLen;
		s_iSepPos = 0;

		while ( --s_iChar > _:s_isNegative )
		{
			if ( ++s_iSepPos == 3 )
			{
				strins( s_szReturn, s_szThousandSeparator, s_iChar );

				s_iSepPos = 0;
			}
		}
	}
	if (iCurrencyChar) {
		s_szCurrencyChar[ 0 ] = iCurrencyChar;
		strins( s_szReturn, s_szCurrencyChar, _:s_isNegative );
	}
	return s_szReturn;
}

GetClosestPlant(playerid, Float: range = 1.5)
{
	new id = -1, Float: dist = range, Float: tempdist;
	foreach (new i : Plants)
	{
	    tempdist = GetPlayerDistanceFromPoint(playerid, PlantData[i][plantX], PlantData[i][plantY], PlantData[i][plantZ]);

	    if (tempdist > range) continue;
		if (tempdist <= dist)
		{
			dist = tempdist;
			id = i;
		}
	}

	return id;
}

GetClosestDealer(playerid, Float: range = 2.0)
{
	new id = -1, Float: dist = range, Float: tempdist;

	foreach (new i : Dealers)
	{
	    tempdist = GetPlayerDistanceFromPoint(playerid, DealerData[i][dealerX], DealerData[i][dealerY], DealerData[i][dealerZ]);

	    if (tempdist > range) continue;
		if (tempdist <= dist)
		{
			dist = tempdist;
			id = i;
		}
	}
	return id;
}

GetClosestGraffiti(playerid, Float: range = 2.0)
{
	new id = -1, Float: dist = range, Float: tempdist;
	for (new i; i<MAX_GRAFFITI_POINTS; i++) if (GraffitiData[i][graffitiExists] == 1)
	{
	    tempdist = GetPlayerDistanceFromPoint(playerid, GraffitiData[i][graffitiPos][0], GraffitiData[i][graffitiPos][1], GraffitiData[i][graffitiPos][2]);

	    if (tempdist > range) continue;
		if (tempdist <= dist)
		{
			dist = tempdist;
			id = i;
		}
	}

	return id;
}
ShowDrugStats(playerid)
{
	new dialog[350];
	format(
		dialog,
		sizeof(dialog),
		"Baðýmlýlýk\t%s\n\
		Uyuþturucu\t%s gram\n\
		Tohum\t%s\n\
		Kullanýlan Uyuþturucu\t%s gram\n\
		Ekilen Tohum\t%s\n\
		Toplanan Tohum\t%s (%s gram)\n\
		Verilen Uyuþturucu\t%s gram\n\
		Alýnan Uyuþturucu\t%s gram\n\
		Satýn Alýnan Uyuþturucu\t%s gram {2ECC71}(%s)\n\
		Satýlan Uyuþturucu\t%s gram {2ECC71}(%s)\n\
		{FF0000}Ýstatistikleri Sýfýrla",
		(PlayerData[playerid][pBagimlilik] == 1) ? ("{2ECC71}Evet") : ("{FF0000}Hayýr"),
		formatInt(PlayerDrugData[playerid][Drugs], .iCurrencyChar = '\0'),
		formatInt(PlayerDrugData[playerid][Seeds], .iCurrencyChar = '\0'),
		formatInt(PlayerDrugData[playerid][TotalUsed], .iCurrencyChar = '\0'),
		formatInt(PlayerDrugData[playerid][TotalPlanted], .iCurrencyChar = '\0'),
		formatInt(PlayerDrugData[playerid][TotalHarvestedPlants], .iCurrencyChar = '\0'), formatInt(PlayerDrugData[playerid][TotalHarvestedGrams], .iCurrencyChar = '\0'),
		formatInt(PlayerDrugData[playerid][TotalGiven], .iCurrencyChar = '\0'),
		formatInt(PlayerDrugData[playerid][TotalReceived], .iCurrencyChar = '\0'),
		formatInt(PlayerDrugData[playerid][TotalBought], .iCurrencyChar = '\0'), formatInt(PlayerDrugData[playerid][TotalBoughtPrice]),
		formatInt(PlayerDrugData[playerid][TotalSold], .iCurrencyChar = '\0'), formatInt(PlayerDrugData[playerid][TotalSoldPrice])
	);

	ShowPlayerDialog(playerid, DIALOG_DRUG_STATS, DIALOG_STYLE_TABLIST, "Uyuþturucu Ýstatistikleri", dialog, "Seç", "Kapat");
	return 1;
}

ShowDealerMenu(playerid)
{
	new dialog[300], id = PlayerDrugData[playerid][DealerID];
	format(
		dialog,
		sizeof(dialog),
		"Ýþlem\tFiyat\tSizde Bulunan\n\
		{%06x}Uyuþturucu Tohumu Al\t{2ECC71}%s\t%s\n\
		{%06x}Uyuþturucu Satýn Al (%s gram satýcýda)\t{2ECC71}%s x gram\t%s gram\n\
		{%06x}Uyuþturucu Sat\t{2ECC71}%s x gram\t%s gram",
		(PlayerDrugData[playerid][Seeds] < SEED_LIMIT) ? 0xFFFFFFFF >>> 8 : 0xE74C3CFF >>> 8, formatInt(SEED_PRICE), formatInt(PlayerDrugData[playerid][Seeds], .iCurrencyChar = '\0'),
		(PlayerDrugData[playerid][Drugs] >= CARRY_LIMIT || DealerData[id][dealerDrugs] < 1) ? 0xE74C3CFF >>> 8 : 0xFFFFFFFF >>> 8, formatInt(DealerData[id][dealerDrugs], .iCurrencyChar = '\0'), formatInt(DRUG_BUY_PRICE), formatInt(PlayerDrugData[playerid][Drugs], .iCurrencyChar = '\0'),
		(PlayerDrugData[playerid][Drugs] > 0) ? 0xFFFFFFFF >>> 8 : 0xE74C3CFF >>> 8, formatInt(DRUG_SELL_PRICE), formatInt(PlayerDrugData[playerid][Drugs], .iCurrencyChar = '\0')
	);

	ShowPlayerDialog(playerid, DIALOG_DRUG_DEALER, DIALOG_STYLE_TABLIST_HEADERS, "Uyuþturucu Satýcýsý", dialog, "Seç", "Kapat");
	return 1;
}
Player_PlantCount(playerid)
{
	new count = 0, name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, MAX_PLAYER_NAME);
	foreach (new i : Plants) if (PlantData[i][plantedBy] == PlayerData[playerid][pID]) count++;
	return count;
}
Player_Init(playerid)
{
	new emptydata[E_PLAYER];
	PlayerDrugData[playerid] = emptydata;
	PlayerDrugData[playerid][DrugsOfferedBy] = INVALID_PLAYER_ID;
	RegenTimer[playerid] = EffectTimer[playerid] = -1;

	// load player
	new drugs, seeds, totalused, totalplanted, harvested[2], given, received, bought[2], sold[2];
	stmt_bind_value(LoadPlayer, 0, DB::TYPE_INT, PlayerData[playerid][pID]);
	stmt_bind_result_field(LoadPlayer, 0, DB::TYPE_INTEGER, drugs);
	stmt_bind_result_field(LoadPlayer, 1, DB::TYPE_INTEGER, seeds);
	stmt_bind_result_field(LoadPlayer, 2, DB::TYPE_INTEGER, totalused);
	stmt_bind_result_field(LoadPlayer, 3, DB::TYPE_INTEGER, totalplanted);
	stmt_bind_result_field(LoadPlayer, 4, DB::TYPE_INTEGER, harvested[0]);
    stmt_bind_result_field(LoadPlayer, 5, DB::TYPE_INTEGER, harvested[1]);
    stmt_bind_result_field(LoadPlayer, 6, DB::TYPE_INTEGER, given);
    stmt_bind_result_field(LoadPlayer, 7, DB::TYPE_INTEGER, received);
    stmt_bind_result_field(LoadPlayer, 8, DB::TYPE_INTEGER, bought[0]);
    stmt_bind_result_field(LoadPlayer, 9, DB::TYPE_INTEGER, bought[1]);
    stmt_bind_result_field(LoadPlayer, 10, DB::TYPE_INTEGER, sold[0]);
    stmt_bind_result_field(LoadPlayer, 11, DB::TYPE_INTEGER, sold[1]);

	if (stmt_execute(LoadPlayer))
	{
	    if (stmt_rows_left(LoadPlayer) > 0) {
	        stmt_fetch_row(LoadPlayer);

	        PlayerDrugData[playerid][Drugs] = drugs;
	        PlayerDrugData[playerid][Seeds] = seeds;
	        PlayerDrugData[playerid][TotalUsed] = totalused;
	        PlayerDrugData[playerid][TotalPlanted] = totalplanted;
	        PlayerDrugData[playerid][TotalHarvestedPlants] = harvested[0];
	        PlayerDrugData[playerid][TotalHarvestedGrams] = harvested[1];
	        PlayerDrugData[playerid][TotalGiven] = given;
	        PlayerDrugData[playerid][TotalReceived] = received;
	        PlayerDrugData[playerid][TotalBought] = bought[0];
	        PlayerDrugData[playerid][TotalBoughtPrice] = bought[1];
	        PlayerDrugData[playerid][TotalSold] = sold[0];
	        PlayerDrugData[playerid][TotalSoldPrice] = sold[1];
	    }else{
	        stmt_bind_value(InsertPlayer, 0, DB::TYPE_INT, PlayerData[playerid][pID]);
	        stmt_execute(InsertPlayer);
	    }
	}

	return 1;
}

Player_SaveDrugs(playerid)
{
    stmt_bind_value(SavePlayer, 0, DB::TYPE_INTEGER, PlayerDrugData[playerid][Drugs]);
	stmt_bind_value(SavePlayer, 1, DB::TYPE_INTEGER, PlayerDrugData[playerid][Seeds]);
	stmt_bind_value(SavePlayer, 2, DB::TYPE_INTEGER, PlayerDrugData[playerid][TotalUsed]);
	stmt_bind_value(SavePlayer, 3, DB::TYPE_INTEGER, PlayerDrugData[playerid][TotalPlanted]);
	stmt_bind_value(SavePlayer, 4, DB::TYPE_INTEGER, PlayerDrugData[playerid][TotalHarvestedPlants]);
	stmt_bind_value(SavePlayer, 5, DB::TYPE_INTEGER, PlayerDrugData[playerid][TotalHarvestedGrams]);
	stmt_bind_value(SavePlayer, 6, DB::TYPE_INTEGER, PlayerDrugData[playerid][TotalGiven]);
	stmt_bind_value(SavePlayer, 7, DB::TYPE_INTEGER, PlayerDrugData[playerid][TotalReceived]);
	stmt_bind_value(SavePlayer, 8, DB::TYPE_INTEGER, PlayerDrugData[playerid][TotalBought]);
	stmt_bind_value(SavePlayer, 9, DB::TYPE_INTEGER, PlayerDrugData[playerid][TotalBoughtPrice]);
	stmt_bind_value(SavePlayer, 10, DB::TYPE_INTEGER, PlayerDrugData[playerid][TotalSold]);
	stmt_bind_value(SavePlayer, 11, DB::TYPE_INTEGER, PlayerDrugData[playerid][TotalSoldPrice]);
	stmt_bind_value(SavePlayer, 12, DB::TYPE_INT, PlayerData[playerid][pID]);
	return stmt_execute(SavePlayer);
}

Player_GetName(playerid)
{
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, sizeof(name));
	return name;
}

Plant_GrowthPercentage(id)
{
	if (!Iter_Contains(Plants, id)) return 0;
	return (PlantData[id][plantGrowth] * 100) / PLANT_MAX_GROWTH;
}

Plant_Destroy(id)
{
	if (!Iter_Contains(Plants, id)) return 0;
	KillTimer(PlantData[id][plantTimer]);
	DestroyDynamicObject(PlantData[id][plantObj]);
	DestroyDynamic3DTextLabel(PlantData[id][plantLabel]);

	PlantData[id][plantObj] = PlantData[id][plantTimer] = -1;
	PlantData[id][plantLabel] = Text3D: -1;
	PlantData[id][gotLeaves] = false;

	Iter_Remove(Plants, id);
	return 1;
}

ConvertToMinutes(time)
{
    // http://forum.sa-mp.com/showpost.php?p=3223897&postcount=11
    new string[15];//-2000000000:00 could happen, so make the string 15 chars to avoid any errors
    format(string, sizeof(string), "%02d:%02d", time / 60, time % 60);
    return string;
}

IsPlayerNearBanker(playerid)
{
	foreach (new i : Bankers)
	{
	    if (IsPlayerInRangeOfPoint(playerid, 3.0, BankerData[i][bankerX], BankerData[i][bankerY], BankerData[i][bankerZ])) return 1;
	}

	return 0;
}

GetClosestATM(playerid, Float: range = 3.0)
{
	new id = -1, Float: dist = range, Float: tempdist;
	foreach (new i : ATMs)
	{
	    tempdist = GetPlayerDistanceFromPoint(playerid, ATMData[i][atmX], ATMData[i][atmY], ATMData[i][atmZ]);

	    if (tempdist > range) continue;
		if (tempdist <= dist)
		{
			dist = tempdist;
			id = i;
		}
	}

	return id;
}

Bank_SaveLog(playerid, type, accid, toaccid, amount)
{
	if (type == TYPE_NONE) return 1;
	new query[256];

	switch (type)
	{
	    case TYPE_LOGIN, TYPE_PASSCHANGE: mysql_format(g_SQL, query, sizeof(query), "INSERT INTO bank_logs SET AccountID=%d, Type=%d, Player='%e', Date=UNIX_TIMESTAMP()", accid, type, Player_GetName(playerid));
	    case TYPE_DEPOSIT, TYPE_WITHDRAW: mysql_format(g_SQL, query, sizeof(query), "INSERT INTO bank_logs SET AccountID=%d, Type=%d, Player='%e', Amount=%d, Date=UNIX_TIMESTAMP()", accid, type, Player_GetName(playerid), amount);
		case TYPE_TRANSFER: mysql_format(g_SQL, query, sizeof(query), "INSERT INTO bank_logs SET AccountID=%d, ToAccountID=%d, Type=%d, Player='%e', Amount=%d, Date=UNIX_TIMESTAMP()", accid, toaccid, type, Player_GetName(playerid), amount);
	}

	mysql_tquery(g_SQL, query);
	return 1;
}

Bank_ShowMenu(playerid)
{
	new string[500], using_atm = GetPVarInt(playerid, "usingATM");
	if (CurrentAccountID[playerid] == -1) {
		format(string, sizeof(string), "{808080} • {FFFFFF}{%06x}Hesap Oluþtur\t{2ECC71}%s\n{808080} • {FFFFFF}Benim Hesaplarým\t{808080}%d\n{808080} • {FFFFFF}Giriþ Yap", (using_atm ? 0xE74C3CFF >>> 8 : 0xFFFFFFFF >>> 8), (using_atm ? ("") : formatInt(ACCOUNT_PRICE)), Bank_AccountCount(playerid));
		ShowPlayerDialog(playerid, DIALOG_BANK_MENU_NOLOGIN, DIALOG_STYLE_TABLIST, "{808080}F{FFFFFF}L{808080}E{FFFFFF}E{808080}C{FFFFFF}A{808080} Bankasý: {FFFFFF}Menu", string, "Seç", "Kapat");
	}else{
	    new balance = Bank_GetBalance(CurrentAccountID[playerid]), menu_title[200];
		format(menu_title, sizeof(menu_title), "{808080}F{FFFFFF}L{808080}E{FFFFFF}E{808080}C{FFFFFF}A{808080} Bankasý: {FFFFFF}Menu [{808080}%d{FFFFFF}]", CurrentAccountID[playerid]);

	    format(
			string,
			sizeof(string),
			"{808080} • {FFFFFF}{%06x}Hesap Oluþtur\t{2ECC71}%s\n{808080} • {FFFFFF}Benim Hesaplarým\t{808080}%d\n{808080} • {FFFFFF}Para Yatýr\t{2ECC71}%s\n{808080} • {FFFFFF}Para Çek\t{2ECC71}%s\n{808080} • {FFFFFF}Para Transfer\t{2ECC71}%s\n{808080} • {FFFFFF}{%06x}Hesap Kayýtlarý\n{808080} • {FFFFFF}{%06x}Þifre Deðiþtir\n{808080} • {FFFFFF}{%06x}Hesap Sil\n{808080} • {FFFFFF}Çýkýþ Yap",
			(using_atm ? 0xE74C3CFF >>> 8 : 0xFFFFFFFF >>> 8),
			(using_atm ? ("") : formatInt(ACCOUNT_PRICE)),
			Bank_AccountCount(playerid),
			formatInt(GetPlayerMoney(playerid)),
			formatInt(balance),
			formatInt(balance),
			(using_atm ? 0xE74C3CFF >>> 8 : 0xFFFFFFFF >>> 8),
			(using_atm ? 0xE74C3CFF >>> 8 : 0xFFFFFFFF >>> 8),
			(using_atm ? 0xE74C3CFF >>> 8 : 0xFFFFFFFF >>> 8)
		);

		ShowPlayerDialog(playerid, DIALOG_BANK_MENU, DIALOG_STYLE_TABLIST, menu_title, string, "Seç", "Kapat");
	}

	DeletePVar(playerid, "bankLoginAccount");
	DeletePVar(playerid, "bankTransferAccount");
	return 1;
}

Bank_ShowLogMenu(playerid)
{
	LogListType[playerid] = TYPE_NONE;
	LogListPage[playerid] = 0;
	ShowPlayerDialog(playerid, DIALOG_BANK_LOGS, DIALOG_STYLE_LIST, "{808080}F{FFFFFF}L{808080}E{FFFFFF}E{808080}C{FFFFFF}A{808080} Bankasý: {FFFFFF}Kayýtlar", "{808080} • {FFFFFF}Yatýrýlan Para Kayýtlarý\n{808080} • {FFFFFF}Çekilen Para Kayýtlarý\n{808080} • {FFFFFF}Transfer Edilen Para Kayýtlarý\n{808080} • {FFFFFF}Giriþ Kayýtlarý\n{808080} • {FFFFFF}Þifre Deðiþtirme Kayýtlarý", "Seç", "Geri");
	return 1;
}
Bank_AccountCount(playerid)
{
	new query[144], Cache: find_accounts;
	mysql_format(g_SQL, query, sizeof(query), "SELECT null FROM bank_accounts WHERE Owner='%d' && Disabled=0", PlayerData[playerid][pID]);
	find_accounts = mysql_query(g_SQL, query);

	new count = cache_num_rows();
	cache_delete(find_accounts);
	return count;
}

Bank_GetBalance(accountid)
{
	new query[144], Cache: get_balance;
	mysql_format(g_SQL, query, sizeof(query), "SELECT Balance FROM bank_accounts WHERE ID=%d && Disabled=0", accountid);
	get_balance = mysql_query(g_SQL, query);

	new balance;
	cache_get_value_name_int(0, "Balance", balance);
	cache_delete(get_balance);
	return balance;
}

Bank_GetOwner(accountid)
{
	new query[144], owner, Cache: get_owner;
	mysql_format(g_SQL, query, sizeof(query), "SELECT Owner FROM bank_accounts WHERE ID=%d && Disabled=0", accountid);
	get_owner = mysql_query(g_SQL, query);

	cache_get_value_name_int(0, "Owner", owner);
	cache_delete(get_owner);
	return owner;
}

Bank_ListAccounts(playerid)
{
    new query[256], Cache: get_accounts;
    mysql_format(g_SQL, query, sizeof(query), "SELECT ID, Balance, LastAccess, FROM_UNIXTIME(CreatedOn, '%%d/%%m/%%Y %%H:%%i:%%s') AS Created, FROM_UNIXTIME(LastAccess, '%%d/%%m/%%Y %%H:%%i:%%s') AS Last FROM bank_accounts WHERE Owner='%d' && Disabled=0 ORDER BY CreatedOn DESC", PlayerData[playerid][pID]);
	get_accounts = mysql_query(g_SQL, query);
    new rows = cache_num_rows();

	if (rows) {
	    new string[1024], acc_id, balance, last_access, cdate[24], ldate[24];
    	format(string, sizeof(string), "ID\tDenge\tOluþturulma\tSon Giriþ\n");
	    for (new i; i < rows; ++i)
	    {
	        cache_get_value_name_int(i, "ID", acc_id);
	        cache_get_value_name_int(i, "Balance", balance);
	        cache_get_value_name_int(i, "LastAccess", last_access);
        	cache_get_value_name(i, "Created", cdate);
        	cache_get_value_name(i, "Last", ldate);

	        format(string, sizeof(string), "%s{FFFFFF}%d\t{2ECC71}%s\t{FFFFFF}%s\t%s\n", string, acc_id, formatInt(balance), cdate, (last_access == 0) ? ("Yok") : ldate);
	    }

		ShowPlayerDialog(playerid, DIALOG_BANK_ACCOUNTS, DIALOG_STYLE_TABLIST_HEADERS, "{808080}F{FFFFFF}L{808080}E{FFFFFF}E{808080}C{FFFFFF}A{808080} Bankasý: {FFFFFF}Hesaplarým", string, "Giriþ", "Geri");
	}else{
	    HataMesajGonder(playerid, "Hiç banka hesabýnýz yok.");
		Bank_ShowMenu(playerid);
	}

    cache_delete(get_accounts);
	return 1;
}

Bank_ShowLogs(playerid)
{
	new query[196], type = LogListType[playerid], Cache: bank_logs;
	mysql_format(g_SQL, query, sizeof(query), "SELECT *, FROM_UNIXTIME(Date, '%%d/%%m/%%Y %%H:%%i:%%s') as ActionDate FROM bank_logs WHERE AccountID=%d && Type=%d ORDER BY Date DESC LIMIT %d, 15", CurrentAccountID[playerid], type, LogListPage[playerid] * 15);
	bank_logs = mysql_query(g_SQL, query);

	new rows = cache_num_rows();
	if (rows) {
		new list[1512], title[96], name[MAX_PLAYER_NAME], date[24];
		switch (type)
		{
		    case TYPE_LOGIN:
			{
				format(list, sizeof(list), "By\tAction Date\n");
				format(title, sizeof(title), "{808080}F{FFFFFF}L{808080}E{FFFFFF}E{808080}C{FFFFFF}A{808080} Bankasý: {FFFFFF}Giriþ Kayýtlarý (Sayfa %d)", LogListPage[playerid] + 1);
			}

			case TYPE_DEPOSIT:
			{
				format(list, sizeof(list), "Yatýran\tMiktar\tTarih\n");
				format(title, sizeof(title), "{808080}F{FFFFFF}L{808080}E{FFFFFF}E{808080}C{FFFFFF}A{808080} Bankasý: {FFFFFF}Yatýrýlan Para Kayýtlarý (Sayfa %d)", LogListPage[playerid] + 1);
			}

			case TYPE_WITHDRAW:
			{
				format(list, sizeof(list), "Çeken\tMiktar\tTarih\n");
				format(title, sizeof(title), "{808080}F{FFFFFF}L{808080}E{FFFFFF}E{808080}C{FFFFFF}A{808080} Bankasý: {FFFFFF}Çekilen Para Kayýtlarý (Sayfa %d)", LogListPage[playerid] + 1);
			}

			case TYPE_TRANSFER:
			{
				format(list, sizeof(list), "Transfer Eden\tHesap Numarasý\tMiktar\tTarih\n");
				format(title, sizeof(title), "{808080}F{FFFFFF}L{808080}E{FFFFFF}E{808080}C{FFFFFF}A{808080} Bankasý: {FFFFFF}Transfer Edilen Para Kayýtlarý (Sayfa %d)", LogListPage[playerid] + 1);
			}

			case TYPE_PASSCHANGE:
			{
				format(list, sizeof(list), "Deðiþtiren\tTarih\n");
				format(title, sizeof(title), "{808080}F{FFFFFF}L{808080}E{FFFFFF}E{808080}C{FFFFFF}A{808080} Bankasý: {FFFFFF}Þifre Deðiþtirme Kayýtlarý (Sayfa %d)", LogListPage[playerid] + 1);
			}
		}

		new amount, to_acc_id;
	    for (new i; i < rows; ++i)
	    {
	        cache_get_value_name(i, "Player", name);
        	cache_get_value_name(i, "ActionDate", date);

            switch (type)
			{
			    case TYPE_LOGIN:
				{
					format(list, sizeof(list), "%s%s\t%s\n", list, name, date);
				}

				case TYPE_DEPOSIT:
				{
				    cache_get_value_name_int(i, "Amount", amount);
					format(list, sizeof(list), "%s%s\t{2ECC71}%s\t%s\n", list, name, formatInt(amount), date);
				}

				case TYPE_WITHDRAW:
				{
				    cache_get_value_name_int(i, "Amount", amount);
					format(list, sizeof(list), "%s%s\t{2ECC71}%s\t%s\n", list, name, formatInt(amount), date);
				}

				case TYPE_TRANSFER:
				{
				    cache_get_value_name_int(i, "ToAccountID", to_acc_id);
				    cache_get_value_name_int(i, "Amount", amount);

					format(list, sizeof(list), "%s%s\t%d\t{2ECC71}%s\t%s\n", list, name, to_acc_id, formatInt(amount), date);
				}

				case TYPE_PASSCHANGE:
				{
					format(list, sizeof(list), "%s%s\t%s\n", list, name, date);
				}
			}
	    }

		ShowPlayerDialog(playerid, DIALOG_BANK_LOG_PAGE, DIALOG_STYLE_TABLIST_HEADERS, title, list, "Sonraki", "Geri");
	}else{
		HataMesajGonder(playerid, "Daha fazla kayýt bulunamadý.");
		Bank_ShowLogMenu(playerid);
	}

	cache_delete(bank_logs);
	return 1;
}

Ticket_Add(suspectid, price, reason[], memur[])
{
    new
        string[1024];


    for (new i = 0; i != MAX_PLAYER_TICKETS; i ++)
    {
        if (!TicketData[suspectid][i][ticketExists])
        {
            TicketData[suspectid][i][ticketExists] = true;
            TicketData[suspectid][i][ticketFee] = price;
			format(TicketData[suspectid][i][ticketMemur], 24, memur);
            format(TicketData[suspectid][i][ticketDate], 36, ReturnDate());
            format(TicketData[suspectid][i][ticketReason], 64, reason);
            TicketData[suspectid][i][ticketID] = i;

            mysql_format(g_SQL, string, sizeof(string), "INSERT INTO `tickets` (`ticketID`, `ID`, `ticketFee`, `ticketDate`, `ticketReason`, `Memur`) VALUES ('%d', '%d', '%d', '%s', '%s', '%s')", i, PlayerData[suspectid][pID], price, TicketData[suspectid][i][ticketDate], SQL_ReturnEscaped(reason), memur);
            mysql_query (g_SQL, string);
            return i;
        }
    }
    return -1;
}

Ticket_Remove(playerid, ticketid)
{
    if (ticketid != -1 && TicketData[playerid][ticketid][ticketExists])
    {
        new
            string[100];

        format(string, sizeof(string), "DELETE FROM `tickets` WHERE `ID` = '%d' AND `ticketID` = '%d'", PlayerData[playerid][pID], TicketData[playerid][ticketid][ticketID]);
        mysql_tquery(g_SQL, string);

        TicketData[playerid][ticketid][ticketExists] = false;
        TicketData[playerid][ticketid][ticketID] = 0;
        TicketData[playerid][ticketid][ticketFee] = 0;
        format(TicketData[playerid][ticketid][ticketMemur], 24, "");
    }
    return 1;
}

stock GetFreeCopObjectID()
{
	new id = -1;
	for (new i; i < MAX_COP_OBJECTS; i++)
	{
	    if (!CopObjectData[i][ObjCreated])
	    {
	        id = i;
	        break;
	    }
	}

	return id;
}

stock GetPlayerSpeed(vid)
{
    new Float:vx, Float:vy, Float:vz, Float:vel;
	vel = GetVehicleVelocity(vid, vx, vy, vz);
	vel = (floatsqroot(((vx*vx)+(vy*vy))+(vz*vz))* 181.5);
	return floatround(vel);
}

stock GetPlayerSpeed2(playerid)
{
    new Float:ST[4];
    if(IsPlayerInAnyVehicle(playerid))
    GetVehicleVelocity(GetPlayerVehicleID(playerid),ST[0],ST[1],ST[2]);
    else GetPlayerVelocity(playerid,ST[0],ST[1],ST[2]);
    ST[3] = floatsqroot(floatpower(floatabs(ST[0]), 2.0) + floatpower(floatabs(ST[1]), 2.0) + floatpower(floatabs(ST[2]), 2.0)) * 179.28625;
    return floatround(ST[3]);
}

stock GetPlayerSpeed3(playerid)
{
    new Float:ST[4];
    if(IsPlayerInAnyVehicle(playerid))
    GetVehicleVelocity(GetPlayerVehicleID(playerid),ST[0],ST[1],ST[2]);
    else GetPlayerVelocity(playerid,ST[0],ST[1],ST[2]);
    ST[3] = floatsqroot(floatpower(floatabs(ST[0]), 2.0) + floatpower(floatabs(ST[1]), 2.0) + floatpower(floatabs(ST[2]), 2.0)) * 179.28625;
    return floatround(ST[3]);
}

stock InsertObjectToDB(id)
{
    stmt_bind_value(AddObject, 0, DB::TYPE_INTEGER, id);
	stmt_bind_value(AddObject, 1, DB::TYPE_STRING, format(CopObjectData[id][Owner],32,ReturnName(id, 0)));
	stmt_bind_value(AddObject, 2, DB::TYPE_INTEGER, CopObjectData[id][Type]);
	stmt_bind_value(AddObject, 3, DB::TYPE_INTEGER, CopObjectData[id][ObjData]);
    stmt_bind_value(AddObject, 4, DB::TYPE_INTEGER, CopObjectData[id][ObjModel]);
	stmt_bind_value(AddObject, 5, DB::TYPE_FLOAT, CopObjectData[id][ObjX]);
	stmt_bind_value(AddObject, 6, DB::TYPE_FLOAT, CopObjectData[id][ObjY]);
	stmt_bind_value(AddObject, 7, DB::TYPE_FLOAT, CopObjectData[id][ObjZ]);
	stmt_bind_value(AddObject, 8, DB::TYPE_FLOAT, CopObjectData[id][ObjRX]);
	stmt_bind_value(AddObject, 9, DB::TYPE_FLOAT, CopObjectData[id][ObjRY]);
	stmt_bind_value(AddObject, 10, DB::TYPE_FLOAT, CopObjectData[id][ObjRZ]);
	stmt_bind_value(AddObject, 11, DB::TYPE_INTEGER, CopObjectData[id][ObjInterior]);
	stmt_bind_value(AddObject, 12, DB::TYPE_INTEGER, CopObjectData[id][ObjVirtualWorld]);
	stmt_execute(AddObject);
	return 1;
}

stock SaveObjectToDB(id)
{
    stmt_bind_value(UpdateObject, 0, DB::TYPE_FLOAT, CopObjectData[id][ObjX]);
	stmt_bind_value(UpdateObject, 1, DB::TYPE_FLOAT, CopObjectData[id][ObjY]);
	stmt_bind_value(UpdateObject, 2, DB::TYPE_FLOAT, CopObjectData[id][ObjZ]);
	stmt_bind_value(UpdateObject, 3, DB::TYPE_FLOAT, CopObjectData[id][ObjRX]);
	stmt_bind_value(UpdateObject, 4, DB::TYPE_FLOAT, CopObjectData[id][ObjRY]);
	stmt_bind_value(UpdateObject, 5, DB::TYPE_FLOAT, CopObjectData[id][ObjRZ]);
	stmt_bind_value(UpdateObject, 6, DB::TYPE_INTEGER, id);
	stmt_execute(UpdateObject);
	return 1;
}
encode_tires(tire1, tire2, tire3, tire4) return tire1 | (tire2 << 1) | (tire3 << 2) | (tire4 << 3);
stock RemoveBuildings(playerid)
{
///**Bahama West Mamas**///
RemoveBuildingForPlayer(playerid, 5951, 958.820, -1359.867, 17.968, 0.250);
RemoveBuildingForPlayer(playerid, 6002, 931.226, -1357.328, 25.820, 0.250);
RemoveBuildingForPlayer(playerid, 6003, 954.687, -1305.773, 30.140, 0.250);
RemoveBuildingForPlayer(playerid, 1266, 932.585, -1363.515, 21.796, 0.250);
RemoveBuildingForPlayer(playerid, 1261, 958.335, -1377.320, 24.132, 0.250);
RemoveBuildingForPlayer(playerid, 1260, 932.585, -1363.515, 21.796, 0.250);
RemoveBuildingForPlayer(playerid, 5814, 931.226, -1357.328, 25.820, 0.250);
RemoveBuildingForPlayer(playerid, 1522, 929.328, -1352.171, 12.328, 0.250);
RemoveBuildingForPlayer(playerid, 1438, 981.875, -1385.992, 12.648, 0.250);
RemoveBuildingForPlayer(playerid, 1440, 948.765, -1381.164, 13.046, 0.250);
RemoveBuildingForPlayer(playerid, 1267, 958.335, -1377.320, 24.132, 0.250);
RemoveBuildingForPlayer(playerid, 5813, 958.820, -1359.867, 17.968, 0.250);
RemoveBuildingForPlayer(playerid, 1440, 957.968, -1336.453, 13.031, 0.250);
RemoveBuildingForPlayer(playerid, 5818, 954.687, -1305.773, 30.140, 0.250);

///**CHOPSHOP**///
RemoveBuildingForPlayer(playerid, 17722, 2411.164, -1402.882, 28.015, 0.250);
RemoveBuildingForPlayer(playerid, 3593, 2407.312, -1418.359, 23.687, 0.250);
RemoveBuildingForPlayer(playerid, 17636, 2411.164, -1402.882, 28.015, 0.250);

///**PD VW EXT**///
RemoveBuildingForPlayer(playerid, 5738, 1292.069, -1122.020, 37.406, 0.250);
RemoveBuildingForPlayer(playerid, 5842, 1292.069, -1122.020, 37.406, 0.250);
RemoveBuildingForPlayer(playerid, 717, 1322.270, -1134.229, 23.000, 0.250);
RemoveBuildingForPlayer(playerid, 727, 1327.979, -1124.339, 21.968, 0.250);
RemoveBuildingForPlayer(playerid, 727, 1319.689, -1112.910, 22.257, 0.250);

///**PD Trafic EXT**///
RemoveBuildingForPlayer(playerid, 6495, 343.125, -1340.382, 28.789, 0.250);
RemoveBuildingForPlayer(playerid, 1268, 311.953, -1383.148, 19.671, 0.250);
RemoveBuildingForPlayer(playerid, 1266, 326.296, -1365.375, 29.828, 0.250);
RemoveBuildingForPlayer(playerid, 1261, 359.062, -1351.687, 24.007, 0.250);
RemoveBuildingForPlayer(playerid, 1259, 311.953, -1383.148, 19.671, 0.250);
RemoveBuildingForPlayer(playerid, 1411, 315.343, -1379.257, 14.843, 0.250);
RemoveBuildingForPlayer(playerid, 1411, 320.054, -1377.062, 14.843, 0.250);
RemoveBuildingForPlayer(playerid, 1411, 324.765, -1374.867, 14.843, 0.250);
RemoveBuildingForPlayer(playerid, 1260, 326.296, -1365.382, 29.820, 0.250);
RemoveBuildingForPlayer(playerid, 6369, 343.125, -1340.382, 28.789, 0.250);
RemoveBuildingForPlayer(playerid, 1267, 359.062, -1351.687, 24.007, 0.250);
RemoveBuildingForPlayer(playerid, 6363, 428.101, -1348.812, 29.257, 0.250);
RemoveBuildingForPlayer(playerid, 6328, 294.976, -1366.739, 18.929, 0.250);
RemoveBuildingForPlayer(playerid, 6496, 294.976, -1366.739, 18.929, 0.250);
RemoveBuildingForPlayer(playerid, 1308, 326.960, -1375.800, 13.210, 0.250);

///**PD Harbor EXT**///
RemoveBuildingForPlayer(playerid, 3687, 2135.7422, -2186.4453, 15.6719, 0.25);
RemoveBuildingForPlayer(playerid, 3687, 2162.8516, -2159.7500, 15.6719, 0.25);
RemoveBuildingForPlayer(playerid, 3687, 2150.1953, -2172.3594, 15.6719, 0.25);
RemoveBuildingForPlayer(playerid, 1531, 2173.5938, -2165.1875, 15.3047, 0.25);
RemoveBuildingForPlayer(playerid, 3622, 2135.7422, -2186.4453, 15.6719, 0.25);
RemoveBuildingForPlayer(playerid, 3622, 2150.1953, -2172.3594, 15.6719, 0.25);
RemoveBuildingForPlayer(playerid, 3622, 2162.8516, -2159.7500, 15.6719, 0.25);
RemoveBuildingForPlayer(playerid, 1306, 2001.0234, -2119.9844, 19.7500, 0.25);
RemoveBuildingForPlayer(playerid, 5337, 1995.4375, -2066.1484, 18.5313, 0.25);

///**wellsfargoAPT**///
RemoveBuildingForPlayer(playerid, 4009, 1421.375, -1477.600, 42.202, 0.250);
RemoveBuildingForPlayer(playerid, 4221, 1406.709, -1499.562, 69.155, 0.250);
RemoveBuildingForPlayer(playerid, 4007, 1421.375, -1477.600, 42.202, 0.250);

///**Alhambra Houses**///
RemoveBuildingForPlayer(playerid, 5544, 1873.742, -1682.476, 34.796, 0.250);
RemoveBuildingForPlayer(playerid, 1524, 1837.664, -1640.382, 13.757, 0.250);
RemoveBuildingForPlayer(playerid, 620, 1855.718, -1741.539, 10.804, 0.250);
RemoveBuildingForPlayer(playerid, 620, 1879.507, -1741.484, 10.804, 0.250);
RemoveBuildingForPlayer(playerid, 620, 1908.218, -1741.484, 10.804, 0.250);
RemoveBuildingForPlayer(playerid, 712, 1929.578, -1736.906, 21.390, 0.250);
RemoveBuildingForPlayer(playerid, 620, 1931.039, -1726.328, 10.804, 0.250);
RemoveBuildingForPlayer(playerid, 620, 1832.382, -1694.312, 9.718, 0.250);
RemoveBuildingForPlayer(playerid, 1537, 1837.437, -1683.968, 12.304, 0.250);
RemoveBuildingForPlayer(playerid, 1533, 1837.437, -1683.953, 12.304, 0.250);
RemoveBuildingForPlayer(playerid, 1537, 1837.437, -1686.984, 12.312, 0.250);
RemoveBuildingForPlayer(playerid, 620, 1832.898, -1670.765, 9.718, 0.250);
RemoveBuildingForPlayer(playerid, 1533, 1837.437, -1677.921, 12.296, 0.250);
RemoveBuildingForPlayer(playerid, 1537, 1837.437, -1680.953, 12.296, 0.250);
RemoveBuildingForPlayer(playerid, 1533, 1837.437, -1680.937, 12.296, 0.250);
RemoveBuildingForPlayer(playerid, 5408, 1873.742, -1682.476, 34.796, 0.250);
RemoveBuildingForPlayer(playerid, 620, 1931.039, -1702.289, 10.804, 0.250);
RemoveBuildingForPlayer(playerid, 712, 1929.578, -1694.460, 21.390, 0.250);
RemoveBuildingForPlayer(playerid, 620, 1931.039, -1667.031, 10.804, 0.250);
RemoveBuildingForPlayer(playerid, 620, 1931.039, -1637.898, 10.804, 0.250);
RemoveBuildingForPlayer(playerid, 620, 1855.718, -1623.281, 10.804, 0.250);
RemoveBuildingForPlayer(playerid, 620, 1879.507, -1623.101, 10.804, 0.250);
RemoveBuildingForPlayer(playerid, 620, 1908.218, -1622.984, 10.804, 0.250);
RemoveBuildingForPlayer(playerid, 712, 1929.578, -1627.625, 21.390, 0.250);
RemoveBuildingForPlayer(playerid, 5536, 1866.328, -1789.781, 20.945, 0.250);
RemoveBuildingForPlayer(playerid, 5397, 1866.328, -1789.781, 20.945, 0.250);

///**LSPD HQ**///
RemoveBuildingForPlayer(playerid, 5930, 1134.250, -1338.078, 23.156, 0.250);
RemoveBuildingForPlayer(playerid, 5708, 1134.250, -1338.078, 23.156, 0.250);
RemoveBuildingForPlayer(playerid, 617, 1178.601, -1332.070, 12.890, 0.250);
RemoveBuildingForPlayer(playerid, 620, 1184.007, -1353.500, 12.578, 0.250);
RemoveBuildingForPlayer(playerid, 620, 1184.007, -1343.265, 12.578, 0.250);
RemoveBuildingForPlayer(playerid, 618, 1177.734, -1315.664, 13.296, 0.250);
RemoveBuildingForPlayer(playerid, 620, 1184.812, -1292.914, 12.578, 0.250);
RemoveBuildingForPlayer(playerid, 620, 1184.812, -1303.148, 12.578, 0.250);

///**Kereste Fabrikasý**///
RemoveBuildingForPlayer(playerid, 3295, 1099.117, -358.476, 77.617, 0.250);
RemoveBuildingForPlayer(playerid, 3347, 1114.296, -353.820, 72.796, 0.250);
RemoveBuildingForPlayer(playerid, 3347, 1107.593, -358.515, 72.796, 0.250);
RemoveBuildingForPlayer(playerid, 3376, 1070.476, -355.164, 77.335, 0.250);
RemoveBuildingForPlayer(playerid, 3404, 1019.382, -300.242, 72.984, 0.250);
RemoveBuildingForPlayer(playerid, 3404, 1045.562, -300.601, 72.984, 0.250);
		RemoveBuildingForPlayer(playerid, 3276, 1012.289, -282.539, 73.843, 0.250);
		RemoveBuildingForPlayer(playerid, 3276, 1023.421, -279.906, 73.843, 0.250);
		RemoveBuildingForPlayer(playerid, 1503, 1019.320, -282.789, 73.203, 0.250);
		RemoveBuildingForPlayer(playerid, 3276, 1047.312, -280.335, 73.843, 0.250);
		RemoveBuildingForPlayer(playerid, 3276, 1059.226, -281.265, 73.843, 0.250);
		RemoveBuildingForPlayer(playerid, 3276, 1082.992, -283.679, 73.843, 0.250);
		RemoveBuildingForPlayer(playerid, 13451, 1146.140, -369.132, 49.328, 0.250);
		RemoveBuildingForPlayer(playerid, 1308, 1042.132, -408.632, 63.015, 0.250);
		RemoveBuildingForPlayer(playerid, 3276, 1007.796, -385.007, 71.843, 0.250);
		RemoveBuildingForPlayer(playerid, 3276, 1042.968, -374.476, 72.890, 0.250);
		RemoveBuildingForPlayer(playerid, 3425, 1015.093, -361.101, 84.039, 0.250);
		RemoveBuildingForPlayer(playerid, 3276, 1007.671, -361.625, 73.843, 0.250);
		RemoveBuildingForPlayer(playerid, 1308, 1042.812, -368.195, 73.101, 0.250);
		RemoveBuildingForPlayer(playerid, 3276, 1007.625, -349.898, 73.843, 0.250);
		RemoveBuildingForPlayer(playerid, 3276, 1007.523, -326.445, 73.843, 0.250);
		RemoveBuildingForPlayer(playerid, 3276, 1007.476, -314.718, 73.843, 0.250);
		RemoveBuildingForPlayer(playerid, 3276, 1007.429, -302.992, 73.843, 0.250);
		RemoveBuildingForPlayer(playerid, 3276, 1007.382, -291.257, 73.843, 0.250);
		RemoveBuildingForPlayer(playerid, 3402, 1019.382, -300.242, 72.984, 0.250);
		RemoveBuildingForPlayer(playerid, 3276, 1083.664, -368.531, 73.843, 0.250);
		RemoveBuildingForPlayer(playerid, 3276, 1071.937, -368.515, 73.843, 0.250);
		RemoveBuildingForPlayer(playerid, 3276, 1060.210, -368.492, 73.843, 0.250);
		RemoveBuildingForPlayer(playerid, 3375, 1070.476, -355.164, 77.335, 0.250);
		RemoveBuildingForPlayer(playerid, 1308, 1094.414, -367.968, 72.898, 0.250);
		RemoveBuildingForPlayer(playerid, 1408, 1092.710, -327.062, 73.570, 0.250);
		RemoveBuildingForPlayer(playerid, 1408, 1095.398, -329.820, 73.507, 0.250);
		RemoveBuildingForPlayer(playerid, 700, 1095.382, -327.476, 73.179, 0.250);
		RemoveBuildingForPlayer(playerid, 1408, 1092.796, -321.484, 73.570, 0.250);
		RemoveBuildingForPlayer(playerid, 1408, 1092.906, -315.968, 73.570, 0.250);
		RemoveBuildingForPlayer(playerid, 1408, 1093.195, -299.296, 73.570, 0.250);
		RemoveBuildingForPlayer(playerid, 3402, 1045.562, -300.601, 72.984, 0.250);
		RemoveBuildingForPlayer(playerid, 13206, 1072.953, -289.179, 72.734, 0.250);
		RemoveBuildingForPlayer(playerid, 1408, 1093.304, -293.781, 73.570, 0.250);
		RemoveBuildingForPlayer(playerid, 1408, 1096.156, -291.265, 73.570, 0.250);
		RemoveBuildingForPlayer(playerid, 656, 1096.625, -294.414, 72.937, 0.250);
		RemoveBuildingForPlayer(playerid, 3286, 1099.117, -358.476, 77.617, 0.250);
		RemoveBuildingForPlayer(playerid, 3175, 1107.593, -358.515, 72.796, 0.250);
		RemoveBuildingForPlayer(playerid, 3276, 1107.117, -368.570, 73.843, 0.250);
		RemoveBuildingForPlayer(playerid, 3253, 1106.640, -319.875, 73.742, 0.250);
		RemoveBuildingForPlayer(playerid, 1408, 1106.492, -330.023, 73.507, 0.250);
		RemoveBuildingForPlayer(playerid, 1408, 1100.914, -329.929, 73.507, 0.250);
		RemoveBuildingForPlayer(playerid, 700, 1106.546, -328.164, 73.179, 0.250);
		RemoveBuildingForPlayer(playerid, 1308, 1101.289, -329.531, 72.898, 0.250);
		RemoveBuildingForPlayer(playerid, 3250, 1110.242, -298.945, 73.039, 0.250);
		RemoveBuildingForPlayer(playerid, 1408, 1101.671, -291.375, 73.570, 0.250);
		RemoveBuildingForPlayer(playerid, 1408, 1107.265, -291.460, 73.570, 0.250);
		RemoveBuildingForPlayer(playerid, 672, 1097.468, -314.210, 73.664, 0.250);
		RemoveBuildingForPlayer(playerid, 3175, 1114.296, -353.820, 72.796, 0.250);
		RemoveBuildingForPlayer(playerid, 1408, 1117.578, -330.210, 73.507, 0.250);
		RemoveBuildingForPlayer(playerid, 1408, 1112.000, -330.125, 73.507, 0.250);
		RemoveBuildingForPlayer(playerid, 656, 1116.445, -326.757, 72.937, 0.250);
		RemoveBuildingForPlayer(playerid, 1408, 1112.781, -291.570, 73.570, 0.250);
		RemoveBuildingForPlayer(playerid, 1408, 1118.375, -291.664, 73.570, 0.250);
		RemoveBuildingForPlayer(playerid, 1408, 1120.429, -327.765, 73.570, 0.250);
		RemoveBuildingForPlayer(playerid, 1408, 1121.023, -294.523, 73.570, 0.250);
		RemoveBuildingForPlayer(playerid, 1408, 1120.625, -316.734, 73.570, 0.250);
		RemoveBuildingForPlayer(playerid, 1408, 1120.929, -300.117, 73.570, 0.250);
		RemoveBuildingForPlayer(playerid, 1408, 1120.820, -305.632, 73.570, 0.250);
		RemoveBuildingForPlayer(playerid, 1408, 1120.734, -311.218, 73.570, 0.250);
		RemoveBuildingForPlayer(playerid, 1408, 1120.539, -322.250, 73.570, 0.250);
		RemoveBuildingForPlayer(playerid, 698, 1053.290, -378.671, 74.429, 0.250);
		RemoveBuildingForPlayer(playerid, 696, 1075.160, -391.507, 74.828, 0.250);
		RemoveBuildingForPlayer(playerid, 698, 1092.469, -383.617, 74.890, 0.250);

		///**PD ASU EXT**///
	RemoveBuildingForPlayer(playerid, 5137, 2005.250, -2137.459, 16.515, 0.250);
	RemoveBuildingForPlayer(playerid, 5195, 2005.250, -2137.459, 16.515, 0.250);

		///**Westmond**///
RemoveBuildingForPlayer(playerid, 5207, 2167.039, -1925.203, 15.828, 0.250);
RemoveBuildingForPlayer(playerid, 3744, 2159.828, -1930.632, 15.078, 0.250);
RemoveBuildingForPlayer(playerid, 3567, 2142.914, -1947.421, 13.265, 0.250);
RemoveBuildingForPlayer(playerid, 3574, 2159.828, -1930.632, 15.078, 0.250);
RemoveBuildingForPlayer(playerid, 5181, 2167.039, -1925.203, 15.828, 0.250);

///**FD Exterior**///
RemoveBuildingForPlayer(playerid, 4606, 1825.000, -1413.929, 12.554, 0.250);
RemoveBuildingForPlayer(playerid, 4594, 1825.000, -1413.929, 12.554, 0.250);

//Hapishane
RemoveBuildingForPlayer(playerid, 3259, 220.647, 1355.189, 9.585, 0.250);
RemoveBuildingForPlayer(playerid, 3424, 220.647, 1355.189, 9.585, 0.250);
RemoveBuildingForPlayer(playerid, 3255, 246.563, 1361.239, 9.687, 0.250);
RemoveBuildingForPlayer(playerid, 3291, 246.563, 1361.239, 9.687, 0.250);
RemoveBuildingForPlayer(playerid, 3257, 221.570, 1374.969, 9.585, 0.250);
RemoveBuildingForPlayer(playerid, 3288, 221.570, 1374.969, 9.585, 0.250);
RemoveBuildingForPlayer(playerid, 3258, 221.179, 1390.300, 9.585, 0.250);
RemoveBuildingForPlayer(playerid, 3289, 221.179, 1390.300, 9.585, 0.250);
RemoveBuildingForPlayer(playerid, 3259, 221.703, 1404.510, 9.585, 0.250);
RemoveBuildingForPlayer(playerid, 3424, 221.703, 1404.510, 9.585, 0.250);
RemoveBuildingForPlayer(playerid, 3257, 223.179, 1421.189, 9.585, 0.250);
RemoveBuildingForPlayer(playerid, 3288, 223.179, 1421.189, 9.585, 0.250);
RemoveBuildingForPlayer(playerid, 16086, 232.289, 1434.479, 13.500, 0.250);
RemoveBuildingForPlayer(playerid, 3258, 222.507, 1444.699, 9.585, 0.250);
RemoveBuildingForPlayer(playerid, 3289, 222.507, 1444.699, 9.585, 0.250);
RemoveBuildingForPlayer(playerid, 3256, 218.257, 1467.540, 9.585, 0.250);
RemoveBuildingForPlayer(playerid, 3290, 218.257, 1467.540, 9.585, 0.250);
RemoveBuildingForPlayer(playerid, 3255, 246.563, 1410.540, 9.687, 0.250);
RemoveBuildingForPlayer(playerid, 3291, 246.563, 1410.540, 9.687, 0.250);
RemoveBuildingForPlayer(playerid, 3255, 246.563, 1435.199, 9.687, 0.250);
RemoveBuildingForPlayer(playerid, 3291, 246.563, 1435.199, 9.687, 0.250);
RemoveBuildingForPlayer(playerid, 3675, 253.820, 1458.109, 10.117, 0.250);
RemoveBuildingForPlayer(playerid, 3675, 252.813, 1473.829, 11.406, 0.250);
RemoveBuildingForPlayer(playerid, 3675, 252.125, 1473.890, 16.296, 0.250);
RemoveBuildingForPlayer(playerid, 3675, 254.679, 1468.209, 18.296, 0.250);
RemoveBuildingForPlayer(playerid, 3675, 255.531, 1472.979, 19.757, 0.250);
RemoveBuildingForPlayer(playerid, 3675, 254.679, 1464.630, 22.468, 0.250);
RemoveBuildingForPlayer(playerid, 3675, 253.820, 1458.109, 23.781, 0.250);
RemoveBuildingForPlayer(playerid, 3675, 255.531, 1454.550, 19.148, 0.250);
RemoveBuildingForPlayer(playerid, 3675, 253.820, 1456.130, 16.296, 0.250);
RemoveBuildingForPlayer(playerid, 3675, 254.679, 1451.829, 27.492, 0.250);
RemoveBuildingForPlayer(playerid, 3673, 247.929, 1461.859, 33.414, 0.250);
RemoveBuildingForPlayer(playerid, 3682, 247.929, 1461.859, 33.414, 0.250);
RemoveBuildingForPlayer(playerid, 3674, 247.554, 1471.089, 35.898, 0.250);
RemoveBuildingForPlayer(playerid, 3259, 262.507, 1465.199, 9.585, 0.250);
RemoveBuildingForPlayer(playerid, 3424, 262.507, 1465.199, 9.585, 0.250);
RemoveBuildingForPlayer(playerid, 16091, 289.742, 1431.089, 5.273, 0.250);
RemoveBuildingForPlayer(playerid, 16090, 315.773, 1431.089, 5.273, 0.250);
RemoveBuildingForPlayer(playerid, 16089, 342.125, 1431.089, 5.273, 0.250);
RemoveBuildingForPlayer(playerid, 3255, 246.563, 1385.890, 9.687, 0.250);
RemoveBuildingForPlayer(playerid, 3291, 246.563, 1385.890, 9.687, 0.250);
RemoveBuildingForPlayer(playerid, 16087, 358.679, 1430.449, 11.617, 0.250);
RemoveBuildingForPlayer(playerid, 16088, 368.429, 1431.089, 5.273, 0.250);
RemoveBuildingForPlayer(playerid, 16092, 394.156, 1431.089, 5.273, 0.250);
RemoveBuildingForPlayer(playerid, 3258, 207.539, 1371.239, 9.585, 0.250);
RemoveBuildingForPlayer(playerid, 3289, 207.539, 1371.239, 9.585, 0.250);
RemoveBuildingForPlayer(playerid, 3256, 190.914, 1371.770, 9.585, 0.250);
RemoveBuildingForPlayer(playerid, 3290, 190.914, 1371.770, 9.585, 0.250);
RemoveBuildingForPlayer(playerid, 3636, 166.789, 1356.989, 17.093, 0.250);
RemoveBuildingForPlayer(playerid, 3683, 166.789, 1356.989, 17.093, 0.250);
RemoveBuildingForPlayer(playerid, 3636, 133.742, 1356.989, 17.093, 0.250);
RemoveBuildingForPlayer(playerid, 3683, 133.742, 1356.989, 17.093, 0.250);
RemoveBuildingForPlayer(playerid, 3636, 133.742, 1392.160, 17.093, 0.250);
RemoveBuildingForPlayer(playerid, 3683, 133.742, 1392.160, 17.093, 0.250);
RemoveBuildingForPlayer(playerid, 3636, 133.742, 1426.910, 17.093, 0.250);
RemoveBuildingForPlayer(playerid, 3683, 133.742, 1426.910, 17.093, 0.250);
RemoveBuildingForPlayer(playerid, 3636, 133.742, 1459.640, 17.093, 0.250);
RemoveBuildingForPlayer(playerid, 3683, 133.742, 1459.640, 17.093, 0.250);
RemoveBuildingForPlayer(playerid, 3636, 166.789, 1426.910, 17.093, 0.250);
RemoveBuildingForPlayer(playerid, 3683, 166.789, 1426.910, 17.093, 0.250);
RemoveBuildingForPlayer(playerid, 3636, 166.789, 1392.160, 17.093, 0.250);
RemoveBuildingForPlayer(playerid, 3683, 166.789, 1392.160, 17.093, 0.250);
RemoveBuildingForPlayer(playerid, 3258, 212.078, 1426.030, 9.585, 0.250);
RemoveBuildingForPlayer(playerid, 3289, 212.078, 1426.030, 9.585, 0.250);
RemoveBuildingForPlayer(playerid, 3259, 210.414, 1444.839, 9.585, 0.250);
RemoveBuildingForPlayer(playerid, 3424, 210.414, 1444.839, 9.585, 0.250);
RemoveBuildingForPlayer(playerid, 3258, 183.742, 1444.869, 9.585, 0.250);
RemoveBuildingForPlayer(playerid, 3289, 183.742, 1444.869, 9.585, 0.250);
RemoveBuildingForPlayer(playerid, 3675, 205.647, 1394.130, 10.117, 0.250);
RemoveBuildingForPlayer(playerid, 3675, 205.647, 1392.160, 16.296, 0.250);
RemoveBuildingForPlayer(playerid, 3675, 207.358, 1390.569, 19.148, 0.250);
RemoveBuildingForPlayer(playerid, 3675, 206.507, 1404.229, 18.296, 0.250);
RemoveBuildingForPlayer(playerid, 3675, 203.953, 1409.910, 16.296, 0.250);
RemoveBuildingForPlayer(playerid, 3675, 204.641, 1409.849, 11.406, 0.250);
RemoveBuildingForPlayer(playerid, 3675, 207.358, 1409.000, 19.757, 0.250);
RemoveBuildingForPlayer(playerid, 3675, 206.507, 1400.660, 22.468, 0.250);
RemoveBuildingForPlayer(playerid, 3675, 205.647, 1394.130, 23.781, 0.250);
RemoveBuildingForPlayer(playerid, 3675, 206.507, 1387.849, 27.492, 0.250);
RemoveBuildingForPlayer(playerid, 3674, 199.382, 1407.119, 35.898, 0.250);
RemoveBuildingForPlayer(playerid, 3673, 199.757, 1397.880, 33.414, 0.250);
RemoveBuildingForPlayer(playerid, 3682, 199.757, 1397.880, 33.414, 0.250);
RemoveBuildingForPlayer(playerid, 3675, 196.022, 1462.020, 10.117, 0.250);
RemoveBuildingForPlayer(playerid, 3675, 199.585, 1463.729, 19.148, 0.250);
RemoveBuildingForPlayer(playerid, 3675, 198.000, 1462.020, 16.296, 0.250);
RemoveBuildingForPlayer(playerid, 3675, 185.921, 1462.880, 18.296, 0.250);
RemoveBuildingForPlayer(playerid, 3675, 180.242, 1460.319, 16.296, 0.250);
RemoveBuildingForPlayer(playerid, 3675, 180.304, 1461.010, 11.406, 0.250);
RemoveBuildingForPlayer(playerid, 3675, 181.156, 1463.729, 19.757, 0.250);
RemoveBuildingForPlayer(playerid, 3675, 189.500, 1462.880, 22.468, 0.250);
RemoveBuildingForPlayer(playerid, 3675, 196.022, 1462.020, 23.781, 0.250);
RemoveBuildingForPlayer(playerid, 3675, 202.304, 1462.880, 27.492, 0.250);
RemoveBuildingForPlayer(playerid, 3673, 192.272, 1456.130, 33.414, 0.250);
RemoveBuildingForPlayer(playerid, 3682, 192.272, 1456.130, 33.414, 0.250);
RemoveBuildingForPlayer(playerid, 3674, 183.039, 1455.750, 35.898, 0.250);


//Elektronik EXT
RemoveBuildingForPlayer(playerid, 5059, 1841.109, -1856.050, 14.937, 0.250);
RemoveBuildingForPlayer(playerid, 5040, 1845.790, -1855.650, 15.984, 0.250);
RemoveBuildingForPlayer(playerid, 5041, 1845.790, -1855.650, 15.984, 0.250);

// Fakir Ev 2

RemoveBuildingForPlayer(playerid, 2251, 266.4531, 303.3672, 998.9844, 0.25);
RemoveBuildingForPlayer(playerid, 14867, 270.2813, 302.5547, 999.6797, 0.25);
RemoveBuildingForPlayer(playerid, 1720, 272.9063, 304.7891, 998.1641, 0.25);
RemoveBuildingForPlayer(playerid, 14870, 273.1641, 303.1719, 1000.9141, 0.25);
RemoveBuildingForPlayer(playerid, 2251, 273.9922, 303.3672, 998.9844, 0.25);
RemoveBuildingForPlayer(playerid, 14868, 274.1328, 304.5078, 1001.1953, 0.25);
RemoveBuildingForPlayer(playerid, 948, 266.5703, 306.4453, 998.1406, 0.25);
RemoveBuildingForPlayer(playerid, 14866, 270.1172, 307.6094, 998.7578, 0.25);
RemoveBuildingForPlayer(playerid, 14869, 273.8125, 305.0156, 998.9531, 0.25);

// Fakir Ev 3

RemoveBuildingForPlayer(playerid, 2865, 2499.5000, -1712.2188, 1014.8672, 0.25);
RemoveBuildingForPlayer(playerid, 2821, 2500.9297, -1710.3516, 1014.8516, 0.25);
RemoveBuildingForPlayer(playerid, 1509, 2501.1953, -1710.6953, 1015.0547, 0.25);
RemoveBuildingForPlayer(playerid, 2277, 2494.7578, -1705.3281, 1018.8984, 0.25);
RemoveBuildingForPlayer(playerid, 1512, 2500.8906, -1706.5703, 1015.0547, 0.25);
RemoveBuildingForPlayer(playerid, 1512, 2501.1172, -1705.4766, 1015.0547, 0.25);
RemoveBuildingForPlayer(playerid, 1509, 2501.1953, -1706.8594, 1015.0547, 0.25);
RemoveBuildingForPlayer(playerid, 1520, 2501.2969, -1707.2344, 1014.9141, 0.25);
RemoveBuildingForPlayer(playerid, 1520, 2501.2969, -1707.3594, 1014.9141, 0.25);
RemoveBuildingForPlayer(playerid, 2830, 2491.8359, -1702.9375, 1014.5703, 0.25);
RemoveBuildingForPlayer(playerid, 2306, 2491.8359, -1701.2813, 1017.3516, 0.25);
RemoveBuildingForPlayer(playerid, 1794, 2492.9688, -1701.8516, 1017.3672, 0.25);
RemoveBuildingForPlayer(playerid, 2306, 2494.0156, -1701.3125, 1017.3516, 0.25);
RemoveBuildingForPlayer(playerid, 2247, 2494.1172, -1700.3359, 1018.8203, 0.25);
RemoveBuildingForPlayer(playerid, 14478, 2494.4297, -1698.3359, 1014.0391, 0.25);
RemoveBuildingForPlayer(playerid, 1740, 2495.2891, -1704.4922, 1017.3672, 0.25);
RemoveBuildingForPlayer(playerid, 2816, 2494.8047, -1702.5156, 1018.0469, 0.25);
RemoveBuildingForPlayer(playerid, 2272, 2496.2188, -1702.5234, 1018.5859, 0.25);
RemoveBuildingForPlayer(playerid, 14477, 2501.0703, -1697.6172, 1016.1250, 0.25);
RemoveBuildingForPlayer(playerid, 14490, 2501.0703, -1697.6172, 1016.1250, 0.25);
RemoveBuildingForPlayer(playerid, 14491, 2501.0703, -1697.6172, 1016.1250, 0.25);
RemoveBuildingForPlayer(playerid, 2252, 2493.0469, -1697.1875, 1014.5703, 0.25);
RemoveBuildingForPlayer(playerid, 2827, 2497.6563, -1697.0703, 1014.7266, 0.25);
RemoveBuildingForPlayer(playerid, 14489, 2490.4453, -1694.8672, 1015.4609, 0.25);
RemoveBuildingForPlayer(playerid, 2028, 2491.3438, -1694.7656, 1013.8359, 0.25);

// Fakir Ev 4

RemoveBuildingForPlayer(playerid, 15028, 2263.1250, -1138.2422, 1049.8438, 0.25);
RemoveBuildingForPlayer(playerid, 15026, 2264.9063, -1137.7656, 1051.3594, 0.25);

// Fakir Ev 5

RemoveBuildingForPlayer(playerid, 15028, 2263.1250, -1138.2422, 1049.8438, 0.25);
RemoveBuildingForPlayer(playerid, 15026, 2264.9063, -1137.7656, 1051.3594, 0.25);
RemoveBuildingForPlayer(playerid, 15032, 2278.5547, -1136.6250, 1051.6328, 0.25);
RemoveBuildingForPlayer(playerid, 15036, 2278.5859, -1135.2266, 1051.0313, 0.25);
RemoveBuildingForPlayer(playerid, 15051, 2279.9375, -1135.8203, 1049.7656, 0.25);
RemoveBuildingForPlayer(playerid, 1764, 2286.1250, -1138.4766, 1049.8828, 0.25);
RemoveBuildingForPlayer(playerid, 15037, 2280.5703, -1137.7422, 1050.2188, 0.25);
RemoveBuildingForPlayer(playerid, 2099, 2281.1953, -1136.0156, 1049.8828, 0.25);

// Fakir Ev 6

RemoveBuildingForPlayer(playerid, 2046, 2806.2266, -1174.5703, 1026.3594, 0.25);
RemoveBuildingForPlayer(playerid, 2049, 2805.2109, -1173.4922, 1026.5234, 0.25);
RemoveBuildingForPlayer(playerid, 2241, 2805.6875, -1173.5156, 1025.0703, 0.25);
RemoveBuildingForPlayer(playerid, 2060, 2810.3047, -1172.8516, 1025.2109, 0.25);
RemoveBuildingForPlayer(playerid, 2060, 2810.3047, -1172.8516, 1025.0469, 0.25);
RemoveBuildingForPlayer(playerid, 2060, 2810.3047, -1172.8516, 1024.8750, 0.25);
RemoveBuildingForPlayer(playerid, 2060, 2810.3047, -1172.8516, 1024.7031, 0.25);
RemoveBuildingForPlayer(playerid, 2060, 2811.6016, -1172.8516, 1024.8750, 0.25);
RemoveBuildingForPlayer(playerid, 2060, 2811.6016, -1172.8516, 1024.7031, 0.25);
RemoveBuildingForPlayer(playerid, 2060, 2811.6016, -1172.8516, 1025.0469, 0.25);
RemoveBuildingForPlayer(playerid, 2060, 2811.6016, -1172.8516, 1025.2109, 0.25);
RemoveBuildingForPlayer(playerid, 2048, 2805.2109, -1172.0547, 1026.8906, 0.25);
RemoveBuildingForPlayer(playerid, 2055, 2805.1953, -1170.5391, 1026.5078, 0.25);
RemoveBuildingForPlayer(playerid, 2060, 2810.0234, -1171.2266, 1024.7031, 0.25);
RemoveBuildingForPlayer(playerid, 2064, 2810.8359, -1171.8984, 1025.2031, 0.25);
RemoveBuildingForPlayer(playerid, 2068, 2809.2031, -1169.3672, 1027.5313, 0.25);
RemoveBuildingForPlayer(playerid, 2069, 2806.3906, -1166.8203, 1024.6250, 0.25);
RemoveBuildingForPlayer(playerid, 1764, 2808.6563, -1166.9531, 1024.5703, 0.25);
RemoveBuildingForPlayer(playerid, 2100, 2805.5078, -1165.5625, 1024.5703, 0.25);
RemoveBuildingForPlayer(playerid, 2276, 2809.2109, -1165.2734, 1026.6875, 0.25);
RemoveBuildingForPlayer(playerid, 1821, 2810.5938, -1167.6172, 1024.5625, 0.25);
RemoveBuildingForPlayer(playerid, 2053, 2810.6094, -1167.5781, 1024.6328, 0.25);
RemoveBuildingForPlayer(playerid, 2058, 2809.6406, -1165.3359, 1024.5781, 0.25);
RemoveBuildingForPlayer(playerid, 2272, 2811.3438, -1165.2734, 1026.7891, 0.25);
RemoveBuildingForPlayer(playerid, 2297, 2811.0234, -1165.0625, 1024.5625, 0.25);
RemoveBuildingForPlayer(playerid, 1765, 2811.4766, -1168.4063, 1024.5625, 0.25);
RemoveBuildingForPlayer(playerid, 2241, 2811.6875, -1168.5078, 1028.6797, 0.25);
RemoveBuildingForPlayer(playerid, 2059, 2814.8359, -1173.4766, 1025.3594, 0.25);
RemoveBuildingForPlayer(playerid, 2116, 2814.3047, -1173.4219, 1024.5547, 0.25);
RemoveBuildingForPlayer(playerid, 2050, 2813.1250, -1173.3359, 1026.3359, 0.25);
RemoveBuildingForPlayer(playerid, 1736, 2812.8281, -1172.2969, 1027.0469, 0.25);
RemoveBuildingForPlayer(playerid, 2051, 2813.1250, -1171.2891, 1026.3359, 0.25);
RemoveBuildingForPlayer(playerid, 2121, 2813.9531, -1172.4609, 1025.0859, 0.25);
RemoveBuildingForPlayer(playerid, 2121, 2815.3828, -1172.4844, 1025.0859, 0.25);
RemoveBuildingForPlayer(playerid, 2275, 2812.6094, -1168.1094, 1026.4453, 0.25);
RemoveBuildingForPlayer(playerid, 2156, 2813.6484, -1167.0000, 1024.5703, 0.25);
RemoveBuildingForPlayer(playerid, 2255, 2814.5703, -1169.2891, 1029.9141, 0.25);
RemoveBuildingForPlayer(playerid, 2047, 2817.3125, -1170.9688, 1031.1719, 0.25);
RemoveBuildingForPlayer(playerid, 2160, 2815.8984, -1164.9063, 1024.5625, 0.25);
RemoveBuildingForPlayer(playerid, 2159, 2817.2656, -1164.9063, 1024.5625, 0.25);
RemoveBuildingForPlayer(playerid, 2157, 2818.7109, -1173.9531, 1024.5703, 0.25);
RemoveBuildingForPlayer(playerid, 2157, 2818.6406, -1164.9063, 1024.5625, 0.25);
RemoveBuildingForPlayer(playerid, 2300, 2818.6484, -1166.5078, 1028.1719, 0.25);
RemoveBuildingForPlayer(playerid, 2046, 2819.4453, -1174.0000, 1026.3594, 0.25);
RemoveBuildingForPlayer(playerid, 2091, 2819.8047, -1165.6641, 1028.1641, 0.25);
RemoveBuildingForPlayer(playerid, 2157, 2820.6328, -1167.3125, 1024.5703, 0.25);

// Fakir Ev 7

RemoveBuildingForPlayer(playerid, 2248, 2235.8281, -1081.6484, 1048.5781, 0.25);
RemoveBuildingForPlayer(playerid, 2248, 2239.2266, -1081.6484, 1048.5781, 0.25);
RemoveBuildingForPlayer(playerid, 1798, 2242.0469, -1078.4297, 1048.0547, 0.25);
RemoveBuildingForPlayer(playerid, 1798, 2244.5469, -1078.4297, 1048.0547, 0.25);
RemoveBuildingForPlayer(playerid, 2248, 2235.8281, -1070.2188, 1048.5781, 0.25);
RemoveBuildingForPlayer(playerid, 2523, 2236.0391, -1068.9063, 1048.0547, 0.25);
RemoveBuildingForPlayer(playerid, 2249, 2236.1406, -1064.1953, 1048.6641, 0.25);
RemoveBuildingForPlayer(playerid, 2264, 2239.0156, -1071.6094, 1050.0625, 0.25);
RemoveBuildingForPlayer(playerid, 15057, 2240.6016, -1072.7031, 1048.0391, 0.25);
RemoveBuildingForPlayer(playerid, 2270, 2238.9063, -1068.9844, 1050.0469, 0.25);
RemoveBuildingForPlayer(playerid, 2248, 2239.2188, -1070.2188, 1048.5781, 0.25);
RemoveBuildingForPlayer(playerid, 2280, 2240.3203, -1070.8906, 1050.2188, 0.25);
RemoveBuildingForPlayer(playerid, 1703, 2240.7344, -1069.5156, 1048.0156, 0.25);
RemoveBuildingForPlayer(playerid, 2526, 2237.2500, -1066.5391, 1048.0078, 0.25);
RemoveBuildingForPlayer(playerid, 2088, 2237.9063, -1064.2891, 1047.9766, 0.25);
RemoveBuildingForPlayer(playerid, 2528, 2238.8516, -1068.1563, 1048.0234, 0.25);
RemoveBuildingForPlayer(playerid, 2249, 2238.9531, -1064.8125, 1050.5625, 0.25);
RemoveBuildingForPlayer(playerid, 2269, 2240.3203, -1068.4453, 1050.1094, 0.25);
RemoveBuildingForPlayer(playerid, 2108, 2240.7734, -1066.3047, 1048.0234, 0.25);
RemoveBuildingForPlayer(playerid, 1741, 2241.3125, -1072.4688, 1048.0156, 0.25);
RemoveBuildingForPlayer(playerid, 2297, 2242.1719, -1066.2266, 1048.0156, 0.25);
RemoveBuildingForPlayer(playerid, 1822, 2243.3281, -1067.8281, 1048.0234, 0.25);
RemoveBuildingForPlayer(playerid, 1703, 2243.8203, -1073.1875, 1048.0156, 0.25);
RemoveBuildingForPlayer(playerid, 2271, 2245.3203, -1068.4453, 1050.1172, 0.25);
RemoveBuildingForPlayer(playerid, 1703, 2245.0313, -1067.6094, 1048.0156, 0.25);
RemoveBuildingForPlayer(playerid, 2108, 2244.7969, -1066.2734, 1048.0234, 0.25);

// Fakir Ev 8

RemoveBuildingForPlayer(playerid, 2158, 305.2188, 1120.2109, 1082.8359, 0.25);
RemoveBuildingForPlayer(playerid, 2330, 308.6953, 1120.8203, 1082.8672, 0.25);
RemoveBuildingForPlayer(playerid, 1802, 307.1875, 1121.8281, 1082.8828, 0.25);
RemoveBuildingForPlayer(playerid, 2846, 309.9844, 1121.4063, 1082.8906, 0.25);
RemoveBuildingForPlayer(playerid, 2840, 309.8125, 1123.4766, 1082.8750, 0.25);
RemoveBuildingForPlayer(playerid, 2855, 309.0391, 1124.5547, 1082.8828, 0.25);
RemoveBuildingForPlayer(playerid, 1720, 309.8594, 1124.5938, 1082.8906, 0.25);
RemoveBuildingForPlayer(playerid, 1750, 315.6797, 1116.6563, 1082.8750, 0.25);
RemoveBuildingForPlayer(playerid, 2867, 318.0703, 1122.9844, 1082.8828, 0.25);
RemoveBuildingForPlayer(playerid, 2858, 321.4141, 1122.4063, 1082.8984, 0.25);
RemoveBuildingForPlayer(playerid, 2855, 316.2578, 1124.5469, 1083.0156, 0.25);
RemoveBuildingForPlayer(playerid, 2855, 316.3359, 1124.5547, 1082.8828, 0.25);
RemoveBuildingForPlayer(playerid, 2855, 316.4688, 1125.0313, 1083.0156, 0.25);
RemoveBuildingForPlayer(playerid, 2855, 316.4688, 1125.0313, 1082.8828, 0.25);
RemoveBuildingForPlayer(playerid, 2855, 316.7266, 1124.5547, 1082.8828, 0.25);
RemoveBuildingForPlayer(playerid, 2855, 316.7266, 1124.5547, 1083.0156, 0.25);
RemoveBuildingForPlayer(playerid, 2852, 316.5469, 1124.7031, 1083.1563, 0.25);
RemoveBuildingForPlayer(playerid, 1728, 319.0469, 1124.3047, 1082.8828, 0.25);
RemoveBuildingForPlayer(playerid, 2262, 317.7266, 1124.8047, 1084.8594, 0.25);
RemoveBuildingForPlayer(playerid, 2844, 321.6406, 1127.9375, 1082.9531, 0.25);
RemoveBuildingForPlayer(playerid, 1793, 321.3828, 1128.4453, 1082.8828, 0.25);
RemoveBuildingForPlayer(playerid, 2859, 324.4453, 1118.9844, 1082.9063, 0.25);
RemoveBuildingForPlayer(playerid, 2860, 324.6094, 1120.7969, 1082.8906, 0.25);
RemoveBuildingForPlayer(playerid, 2103, 327.0391, 1116.9766, 1082.8750, 0.25);
RemoveBuildingForPlayer(playerid, 1710, 326.2109, 1121.2656, 1082.8984, 0.25);
RemoveBuildingForPlayer(playerid, 2147, 331.9922, 1118.8672, 1082.8594, 0.25);
RemoveBuildingForPlayer(playerid, 2338, 334.3906, 1118.8203, 1082.8438, 0.25);
RemoveBuildingForPlayer(playerid, 2337, 334.3906, 1119.8125, 1082.8438, 0.25);
RemoveBuildingForPlayer(playerid, 2170, 334.4531, 1121.8281, 1082.8516, 0.25);
RemoveBuildingForPlayer(playerid, 2116, 331.4922, 1122.5469, 1082.8750, 0.25);
RemoveBuildingForPlayer(playerid, 2857, 322.2422, 1123.7109, 1082.8750, 0.25);
RemoveBuildingForPlayer(playerid, 2295, 326.8438, 1124.4844, 1082.8594, 0.25);
RemoveBuildingForPlayer(playerid, 2336, 334.2500, 1123.8672, 1082.8438, 0.25);
RemoveBuildingForPlayer(playerid, 2335, 334.2422, 1124.8672, 1082.8438, 0.25);
RemoveBuildingForPlayer(playerid, 2334, 334.2422, 1125.8672, 1082.8438, 0.25);
RemoveBuildingForPlayer(playerid, 2852, 321.6719, 1130.3516, 1083.5547, 0.25);
RemoveBuildingForPlayer(playerid, 1728, 325.5078, 1130.8516, 1082.8750, 0.25);
RemoveBuildingForPlayer(playerid, 2819, 323.4453, 1131.1250, 1082.8984, 0.25);

// Fakir Ev 9

RemoveBuildingForPlayer(playerid, 16408, 418.2266, 2538.8516, 11.4297, 0.25);
RemoveBuildingForPlayer(playerid, 1810, 418.7344, 2538.7578, 8.9844, 0.25);
RemoveBuildingForPlayer(playerid, 2147, 413.9688, 2538.2188, 8.9844, 0.25);
RemoveBuildingForPlayer(playerid, 1748, 418.2734, 2541.0625, 9.7891, 0.25);
RemoveBuildingForPlayer(playerid, 1810, 417.6328, 2542.5000, 8.9844, 0.25);
RemoveBuildingForPlayer(playerid, 1812, 416.2422, 2540.3359, 8.9766, 0.25);
RemoveBuildingForPlayer(playerid, 2115, 418.6875, 2539.5938, 8.9922, 0.25);
RemoveBuildingForPlayer(playerid, 1810, 418.2031, 2539.9063, 8.9844, 0.25);
RemoveBuildingForPlayer(playerid, 1738, 420.1328, 2542.8750, 9.6328, 0.25);
RemoveBuildingForPlayer(playerid, 1763, 421.0781, 2540.8125, 8.9844, 0.25);

// Orta Ev 1

RemoveBuildingForPlayer(playerid, 1741, 2261.6953, -1223.0781, 1048.0156, 0.25);
RemoveBuildingForPlayer(playerid, 2088, 2258.1406, -1220.5859, 1048.0078, 0.25);
RemoveBuildingForPlayer(playerid, 2090, 2258.5938, -1221.5469, 1048.0625, 0.25);
RemoveBuildingForPlayer(playerid, 2249, 2251.3594, -1218.1797, 1048.6953, 0.25);
RemoveBuildingForPlayer(playerid, 2528, 2254.4063, -1218.2734, 1048.0234, 0.25);
RemoveBuildingForPlayer(playerid, 2121, 2250.3047, -1213.9375, 1048.5234, 0.25);
RemoveBuildingForPlayer(playerid, 2526, 2252.4297, -1215.4531, 1048.0391, 0.25);
RemoveBuildingForPlayer(playerid, 2523, 2254.1953, -1215.4531, 1048.0156, 0.25);
RemoveBuildingForPlayer(playerid, 2297, 2255.4219, -1213.5313, 1048.0156, 0.25);
RemoveBuildingForPlayer(playerid, 2248, 2262.3906, -1215.5469, 1048.6094, 0.25);
RemoveBuildingForPlayer(playerid, 1816, 2261.4141, -1213.4531, 1048.0078, 0.25);
RemoveBuildingForPlayer(playerid, 2249, 2247.2969, -1212.1641, 1049.6250, 0.25);
RemoveBuildingForPlayer(playerid, 2249, 2247.2969, -1208.8594, 1049.6250, 0.25);
RemoveBuildingForPlayer(playerid, 2109, 2250.2813, -1212.2500, 1048.4141, 0.25);
RemoveBuildingForPlayer(playerid, 2121, 2249.2344, -1211.4531, 1048.5234, 0.25);
RemoveBuildingForPlayer(playerid, 2121, 2250.3047, -1210.8984, 1048.5234, 0.25);
RemoveBuildingForPlayer(playerid, 2319, 2250.3438, -1206.9609, 1048.0078, 0.25);
RemoveBuildingForPlayer(playerid, 1760, 2261.4609, -1212.0625, 1048.0078, 0.25);
RemoveBuildingForPlayer(playerid, 2126, 2258.1094, -1210.3750, 1048.0156, 0.25);
RemoveBuildingForPlayer(playerid, 15044, 2255.0938, -1209.7813, 1048.0313, 0.25);
RemoveBuildingForPlayer(playerid, 2247, 2258.4766, -1209.7891, 1048.9922, 0.25);
RemoveBuildingForPlayer(playerid, 2099, 2262.8047, -1208.4922, 1048.0156, 0.25);
RemoveBuildingForPlayer(playerid, 2254, 2254.1172, -1206.5000, 1050.7578, 0.25);
RemoveBuildingForPlayer(playerid, 2240, 2254.6328, -1207.2734, 1048.5625, 0.25);
RemoveBuildingForPlayer(playerid, 2252, 2256.2109, -1206.1016, 1048.8281, 0.25);
RemoveBuildingForPlayer(playerid, 2235, 2256.2188, -1206.8594, 1048.0078, 0.25);
RemoveBuildingForPlayer(playerid, 1760, 2257.6172, -1207.7266, 1048.0078, 0.25);
RemoveBuildingForPlayer(playerid, 2235, 2261.4297, -1206.2031, 1048.0078, 0.25);
RemoveBuildingForPlayer(playerid, 2252, 2262.1172, -1206.1016, 1048.8281, 0.25);

// Orta Ev 2

RemoveBuildingForPlayer(playerid, 2241, 2194.5469, -1226.4844, 1048.5234, 0.25);
RemoveBuildingForPlayer(playerid, 2526, 2191.8750, -1225.3594, 1048.0391, 0.25);
RemoveBuildingForPlayer(playerid, 2523, 2191.8750, -1223.5938, 1048.0234, 0.25);
RemoveBuildingForPlayer(playerid, 2241, 2194.5469, -1221.7969, 1048.5234, 0.25);
RemoveBuildingForPlayer(playerid, 2528, 2194.6953, -1223.1172, 1048.0234, 0.25);
RemoveBuildingForPlayer(playerid, 2278, 2194.6406, -1221.5859, 1050.3203, 0.25);
RemoveBuildingForPlayer(playerid, 2095, 2186.2109, -1219.1563, 1048.0313, 0.25);
RemoveBuildingForPlayer(playerid, 2106, 2186.2500, -1220.3203, 1048.8750, 0.25);
RemoveBuildingForPlayer(playerid, 2106, 2189.5000, -1220.3203, 1048.8750, 0.25);
RemoveBuildingForPlayer(playerid, 2095, 2189.6250, -1219.1563, 1048.0313, 0.25);
RemoveBuildingForPlayer(playerid, 2108, 2192.0547, -1219.5234, 1048.0234, 0.25);
RemoveBuildingForPlayer(playerid, 2108, 2194.3359, -1219.5234, 1048.0234, 0.25);
RemoveBuildingForPlayer(playerid, 2280, 2196.8828, -1219.9688, 1050.1641, 0.25);
RemoveBuildingForPlayer(playerid, 2088, 2199.1875, -1219.0078, 1048.0156, 0.25);
RemoveBuildingForPlayer(playerid, 1717, 2187.2422, -1215.6719, 1048.0078, 0.25);
RemoveBuildingForPlayer(playerid, 2090, 2188.4453, -1217.1797, 1048.0078, 0.25);
RemoveBuildingForPlayer(playerid, 2088, 2188.4688, -1213.0234, 1048.0156, 0.25);
RemoveBuildingForPlayer(playerid, 2281, 2196.1484, -1214.6797, 1050.3125, 0.25);
RemoveBuildingForPlayer(playerid, 2298, 2197.2734, -1216.6250, 1048.0234, 0.25);
RemoveBuildingForPlayer(playerid, 2106, 2197.2500, -1212.8516, 1048.5469, 0.25);
RemoveBuildingForPlayer(playerid, 2259, 2198.5859, -1213.1484, 1050.2969, 0.25);
RemoveBuildingForPlayer(playerid, 2828, 2198.5391, -1212.8359, 1048.8203, 0.25);
RemoveBuildingForPlayer(playerid, 2106, 2199.9375, -1212.8516, 1048.5469, 0.25);
RemoveBuildingForPlayer(playerid, 2832, 2181.5000, -1206.5234, 1049.0625, 0.25);
RemoveBuildingForPlayer(playerid, 2134, 2181.6250, -1207.4219, 1048.0156, 0.25);
RemoveBuildingForPlayer(playerid, 2132, 2181.6328, -1205.4219, 1048.0156, 0.25);
RemoveBuildingForPlayer(playerid, 2339, 2181.6250, -1206.4219, 1048.0156, 0.25);
RemoveBuildingForPlayer(playerid, 2131, 2184.6250, -1207.8594, 1048.0156, 0.25);
RemoveBuildingForPlayer(playerid, 2121, 2183.5625, -1204.2344, 1048.5234, 0.25);
RemoveBuildingForPlayer(playerid, 2115, 2184.6641, -1204.1719, 1048.0313, 0.25);
RemoveBuildingForPlayer(playerid, 2299, 2187.6250, -1212.1563, 1048.0078, 0.25);
RemoveBuildingForPlayer(playerid, 2826, 2186.4531, -1210.5625, 1048.0313, 0.25);
RemoveBuildingForPlayer(playerid, 2106, 2185.7109, -1209.4063, 1048.7734, 0.25);
RemoveBuildingForPlayer(playerid, 2259, 2185.3984, -1209.9609, 1050.0859, 0.25);
RemoveBuildingForPlayer(playerid, 2328, 2186.4375, -1210.1719, 1048.0156, 0.25);
RemoveBuildingForPlayer(playerid, 2255, 2188.1563, -1209.1406, 1050.2422, 0.25);
RemoveBuildingForPlayer(playerid, 2121, 2185.8047, -1205.2656, 1048.5234, 0.25);
RemoveBuildingForPlayer(playerid, 2281, 2187.8516, -1207.1250, 1050.0703, 0.25);
RemoveBuildingForPlayer(playerid, 2069, 2188.2109, -1207.5703, 1048.0703, 0.25);
RemoveBuildingForPlayer(playerid, 2328, 2189.4531, -1210.1719, 1048.0156, 0.25);
RemoveBuildingForPlayer(playerid, 2280, 2189.8984, -1207.8438, 1050.1172, 0.25);
RemoveBuildingForPlayer(playerid, 2249, 2190.2188, -1209.3828, 1049.4453, 0.25);
RemoveBuildingForPlayer(playerid, 2108, 2192.0547, -1209.7109, 1048.0234, 0.25);
RemoveBuildingForPlayer(playerid, 2108, 2194.3359, -1209.7109, 1048.0234, 0.25);
RemoveBuildingForPlayer(playerid, 2826, 2190.5781, -1204.4297, 1048.0313, 0.25);
RemoveBuildingForPlayer(playerid, 1702, 2191.5781, -1206.9375, 1048.0391, 0.25);
RemoveBuildingForPlayer(playerid, 2857, 2193.0938, -1204.2813, 1048.5078, 0.25);
RemoveBuildingForPlayer(playerid, 1818, 2193.1250, -1205.1328, 1048.0078, 0.25);
RemoveBuildingForPlayer(playerid, 1702, 2196.1484, -1205.3828, 1048.0391, 0.25);
RemoveBuildingForPlayer(playerid, 2260, 2196.7188, -1206.4922, 1050.1641, 0.25);
RemoveBuildingForPlayer(playerid, 2831, 2181.5625, -1203.5000, 1049.0703, 0.25);
RemoveBuildingForPlayer(playerid, 2134, 2181.6250, -1203.4219, 1048.0156, 0.25);
RemoveBuildingForPlayer(playerid, 2141, 2181.6250, -1201.4219, 1048.0156, 0.25);
RemoveBuildingForPlayer(playerid, 2339, 2181.6250, -1202.4219, 1048.0156, 0.25);
RemoveBuildingForPlayer(playerid, 2831, 2184.6016, -1203.8906, 1048.8438, 0.25);
RemoveBuildingForPlayer(playerid, 2121, 2185.8047, -1202.6094, 1048.5234, 0.25);
RemoveBuildingForPlayer(playerid, 2121, 2183.3281, -1202.3750, 1048.5234, 0.25);
RemoveBuildingForPlayer(playerid, 2131, 2183.3750, -1200.8672, 1048.0156, 0.25);
RemoveBuildingForPlayer(playerid, 15043, 2189.1641, -1203.6484, 1048.0313, 0.25);
RemoveBuildingForPlayer(playerid, 1717, 2190.5469, -1201.5625, 1048.0078, 0.25);
RemoveBuildingForPlayer(playerid, 2244, 2188.0000, -1200.8516, 1048.2891, 0.25);
RemoveBuildingForPlayer(playerid, 2255, 2188.2656, -1200.8438, 1050.1797, 0.25);
RemoveBuildingForPlayer(playerid, 2126, 2192.4063, -1200.5234, 1048.0156, 0.25);
RemoveBuildingForPlayer(playerid, 2811, 2192.8359, -1200.0391, 1048.5391, 0.25);
RemoveBuildingForPlayer(playerid, 15040, 2193.2031, -1199.1094, 1050.1328, 0.25);
RemoveBuildingForPlayer(playerid, 2100, 2195.2500, -1200.4844, 1048.0234, 0.25);

// Orta Ev 3

RemoveBuildingForPlayer(playerid, 2077, 2357.5469, -1134.1875, 1050.7031, 0.25);
RemoveBuildingForPlayer(playerid, 2298, 2361.2969, -1134.1484, 1049.8594, 0.25);
RemoveBuildingForPlayer(playerid, 2141, 2367.5625, -1135.3906, 1049.8750, 0.25);
RemoveBuildingForPlayer(playerid, 2339, 2367.5625, -1134.3906, 1049.8750, 0.25);
RemoveBuildingForPlayer(playerid, 2134, 2367.5625, -1133.3906, 1049.8750, 0.25);
RemoveBuildingForPlayer(playerid, 2077, 2357.5469, -1131.5234, 1050.6875, 0.25);
RemoveBuildingForPlayer(playerid, 2271, 2357.8594, -1132.8828, 1051.2813, 0.25);
RemoveBuildingForPlayer(playerid, 2087, 2360.2969, -1129.9766, 1049.8750, 0.25);
RemoveBuildingForPlayer(playerid, 2103, 2360.8281, -1130.1406, 1051.0156, 0.25);
RemoveBuildingForPlayer(playerid, 2279, 2369.8125, -1135.4375, 1052.1094, 0.25);
RemoveBuildingForPlayer(playerid, 2125, 2370.5781, -1134.0313, 1050.1797, 0.25);
RemoveBuildingForPlayer(playerid, 2125, 2371.7500, -1133.5938, 1050.1797, 0.25);
RemoveBuildingForPlayer(playerid, 2278, 2372.1875, -1135.4297, 1052.1250, 0.25);
RemoveBuildingForPlayer(playerid, 2030, 2371.2266, -1132.9219, 1050.2734, 0.25);
RemoveBuildingForPlayer(playerid, 2812, 2371.2969, -1133.0156, 1050.6641, 0.25);
RemoveBuildingForPlayer(playerid, 2125, 2371.7500, -1131.8594, 1050.1797, 0.25);
RemoveBuildingForPlayer(playerid, 2125, 2370.5781, -1131.8594, 1050.1797, 0.25);
RemoveBuildingForPlayer(playerid, 2288, 2373.3828, -1130.4531, 1051.9844, 0.25);
RemoveBuildingForPlayer(playerid, 2141, 2374.5000, -1135.3906, 1049.8203, 0.25);
RemoveBuildingForPlayer(playerid, 2132, 2374.5000, -1131.3906, 1049.8203, 0.25);
RemoveBuildingForPlayer(playerid, 2339, 2374.5078, -1134.3828, 1049.8203, 0.25);
RemoveBuildingForPlayer(playerid, 2134, 2374.5078, -1133.3828, 1049.8203, 0.25);
RemoveBuildingForPlayer(playerid, 2339, 2374.5078, -1130.3828, 1049.8203, 0.25);
RemoveBuildingForPlayer(playerid, 2225, 2369.1797, -1125.8047, 1049.8672, 0.25);
RemoveBuildingForPlayer(playerid, 2260, 2369.7188, -1123.8594, 1052.0781, 0.25);
RemoveBuildingForPlayer(playerid, 2331, 2367.3672, -1123.1563, 1050.1172, 0.25);
RemoveBuildingForPlayer(playerid, 2302, 2364.5547, -1122.9688, 1049.8672, 0.25);
RemoveBuildingForPlayer(playerid, 2259, 2368.6094, -1122.5078, 1052.0469, 0.25);
RemoveBuildingForPlayer(playerid, 2333, 2367.5703, -1122.1484, 1049.8672, 0.25);
RemoveBuildingForPlayer(playerid, 2255, 2361.5703, -1122.1484, 1052.2109, 0.25);
RemoveBuildingForPlayer(playerid, 1734, 2364.8828, -1122.0469, 1053.8516, 0.25);
RemoveBuildingForPlayer(playerid, 2811, 2372.7031, -1128.9141, 1049.8203, 0.25);
RemoveBuildingForPlayer(playerid, 15061, 2371.6094, -1128.1875, 1051.8750, 0.25);
RemoveBuildingForPlayer(playerid, 15062, 2371.6094, -1128.1875, 1051.8750, 0.25);
RemoveBuildingForPlayer(playerid, 2868, 2370.1250, -1125.2344, 1049.8672, 0.25);
RemoveBuildingForPlayer(playerid, 1703, 2370.3906, -1124.4375, 1049.8438, 0.25);
RemoveBuildingForPlayer(playerid, 1822, 2372.0938, -1124.2188, 1049.8516, 0.25);
RemoveBuildingForPlayer(playerid, 2828, 2374.2578, -1129.2578, 1050.7891, 0.25);
RemoveBuildingForPlayer(playerid, 2084, 2374.4688, -1129.2109, 1049.8750, 0.25);
RemoveBuildingForPlayer(playerid, 1703, 2374.6797, -1122.5313, 1049.8438, 0.25);
RemoveBuildingForPlayer(playerid, 2281, 2375.6641, -1128.1016, 1051.8750, 0.25);
RemoveBuildingForPlayer(playerid, 2868, 2374.9766, -1125.2344, 1049.8672, 0.25);
RemoveBuildingForPlayer(playerid, 2280, 2375.6484, -1122.3828, 1051.9922, 0.25);
RemoveBuildingForPlayer(playerid, 2227, 2370.2344, -1120.5859, 1049.8750, 0.25);
RemoveBuildingForPlayer(playerid, 1742, 2366.6953, -1119.2500, 1049.8750, 0.25);
RemoveBuildingForPlayer(playerid, 1703, 2371.6016, -1121.5078, 1049.8438, 0.25);
RemoveBuildingForPlayer(playerid, 2227, 2375.5859, -1120.9922, 1049.8750, 0.25);

// Orta Ev 4

RemoveBuildingForPlayer(playerid, 2123, 2312.9609, -1145.0703, 1050.3203, 0.25);
RemoveBuildingForPlayer(playerid, 2123, 2314.2969, -1146.3125, 1050.3203, 0.25);
RemoveBuildingForPlayer(playerid, 2123, 2315.4219, -1145.0703, 1050.3203, 0.25);
RemoveBuildingForPlayer(playerid, 2086, 2314.2734, -1144.8984, 1050.0859, 0.25);
RemoveBuildingForPlayer(playerid, 2123, 2314.2969, -1143.6250, 1050.3203, 0.25);
RemoveBuildingForPlayer(playerid, 15045, 2324.4297, -1143.3125, 1049.6016, 0.25);
RemoveBuildingForPlayer(playerid, 2138, 2331.3359, -1144.0859, 1049.6953, 0.25);
RemoveBuildingForPlayer(playerid, 2138, 2335.3594, -1144.0703, 1049.6719, 0.25);
RemoveBuildingForPlayer(playerid, 2135, 2336.3516, -1144.0781, 1049.6719, 0.25);
RemoveBuildingForPlayer(playerid, 2305, 2337.3203, -1144.0781, 1049.6719, 0.25);
RemoveBuildingForPlayer(playerid, 2138, 2331.3359, -1143.1016, 1049.6953, 0.25);
RemoveBuildingForPlayer(playerid, 2138, 2337.3203, -1143.0938, 1049.6719, 0.25);
RemoveBuildingForPlayer(playerid, 1703, 2322.2266, -1142.4766, 1049.4766, 0.25);
RemoveBuildingForPlayer(playerid, 1822, 2323.9297, -1142.2578, 1049.4844, 0.25);
RemoveBuildingForPlayer(playerid, 1741, 2312.6484, -1140.7891, 1053.3750, 0.25);
RemoveBuildingForPlayer(playerid, 2138, 2331.3359, -1142.1094, 1049.6953, 0.25);
RemoveBuildingForPlayer(playerid, 2138, 2331.3359, -1141.1172, 1049.6953, 0.25);
RemoveBuildingForPlayer(playerid, 2079, 2334.4219, -1140.9688, 1050.3359, 0.25);
RemoveBuildingForPlayer(playerid, 1703, 2326.5234, -1140.5703, 1049.4766, 0.25);
RemoveBuildingForPlayer(playerid, 2138, 2337.3203, -1142.1094, 1049.6719, 0.25);
RemoveBuildingForPlayer(playerid, 2139, 2337.3125, -1141.1094, 1049.6641, 0.25);
RemoveBuildingForPlayer(playerid, 2088, 2338.4531, -1141.3672, 1053.2734, 0.25);
RemoveBuildingForPlayer(playerid, 2270, 2340.2734, -1141.7109, 1054.5391, 0.25);
RemoveBuildingForPlayer(playerid, 15050, 2330.3281, -1140.3047, 1051.9063, 0.25);
RemoveBuildingForPlayer(playerid, 2138, 2331.3359, -1140.1328, 1049.6953, 0.25);
RemoveBuildingForPlayer(playerid, 1703, 2323.4375, -1139.5469, 1049.4766, 0.25);
RemoveBuildingForPlayer(playerid, 2079, 2333.3281, -1139.8672, 1050.3359, 0.25);
RemoveBuildingForPlayer(playerid, 2115, 2334.4297, -1139.6250, 1049.7109, 0.25);
RemoveBuildingForPlayer(playerid, 15049, 2334.3281, -1139.5859, 1051.1953, 0.25);
RemoveBuildingForPlayer(playerid, 2079, 2335.3672, -1139.8750, 1050.3359, 0.25);
RemoveBuildingForPlayer(playerid, 2303, 2337.3281, -1140.1172, 1049.6719, 0.25);
RemoveBuildingForPlayer(playerid, 2090, 2309.5156, -1139.3438, 1053.4219, 0.25);
RemoveBuildingForPlayer(playerid, 2138, 2331.3359, -1139.1406, 1049.6953, 0.25);
RemoveBuildingForPlayer(playerid, 2079, 2333.3281, -1138.8281, 1050.3359, 0.25);
RemoveBuildingForPlayer(playerid, 2079, 2335.3672, -1138.8359, 1050.3359, 0.25);
RemoveBuildingForPlayer(playerid, 2298, 2336.5391, -1138.7891, 1053.2813, 0.25);
RemoveBuildingForPlayer(playerid, 2138, 2331.3359, -1138.1563, 1049.6953, 0.25);
RemoveBuildingForPlayer(playerid, 2136, 2337.3281, -1138.1328, 1049.6719, 0.25);
RemoveBuildingForPlayer(playerid, 2240, 2319.2500, -1137.8750, 1050.0156, 0.25);
RemoveBuildingForPlayer(playerid, 2240, 2329.5000, -1137.8750, 1050.0156, 0.25);
RemoveBuildingForPlayer(playerid, 2138, 2331.3359, -1137.1641, 1049.6953, 0.25);
RemoveBuildingForPlayer(playerid, 2079, 2334.4219, -1137.5859, 1050.3359, 0.25);
RemoveBuildingForPlayer(playerid, 2139, 2337.3125, -1137.1484, 1049.6641, 0.25);
RemoveBuildingForPlayer(playerid, 2088, 2310.6641, -1136.3047, 1053.3672, 0.25);
RemoveBuildingForPlayer(playerid, 2257, 2320.4141, -1134.6328, 1053.8281, 0.25);
RemoveBuildingForPlayer(playerid, 2138, 2331.3359, -1136.1719, 1049.6953, 0.25);
RemoveBuildingForPlayer(playerid, 2138, 2331.3359, -1135.1875, 1049.6953, 0.25);
RemoveBuildingForPlayer(playerid, 2254, 2328.1484, -1134.6172, 1054.0625, 0.25);
RemoveBuildingForPlayer(playerid, 2281, 2335.2656, -1136.4063, 1054.7266, 0.25);
RemoveBuildingForPlayer(playerid, 2106, 2336.5156, -1135.0156, 1053.8047, 0.25);
RemoveBuildingForPlayer(playerid, 2271, 2337.8047, -1135.3516, 1054.7031, 0.25);
RemoveBuildingForPlayer(playerid, 2138, 2337.3203, -1136.1641, 1049.6719, 0.25);
RemoveBuildingForPlayer(playerid, 2138, 2337.3203, -1135.1797, 1049.6719, 0.25);
RemoveBuildingForPlayer(playerid, 2106, 2339.2031, -1135.0156, 1053.8047, 0.25);

// Zengin Ev 1

RemoveBuildingForPlayer(playerid, 2123, 2312.9609, -1145.0703, 1050.3203, 0.25);
RemoveBuildingForPlayer(playerid, 2123, 2314.2969, -1146.3125, 1050.3203, 0.25);
RemoveBuildingForPlayer(playerid, 2123, 2315.4219, -1145.0703, 1050.3203, 0.25);
RemoveBuildingForPlayer(playerid, 2086, 2314.2734, -1144.8984, 1050.0859, 0.25);
RemoveBuildingForPlayer(playerid, 2123, 2314.2969, -1143.6250, 1050.3203, 0.25);
RemoveBuildingForPlayer(playerid, 15045, 2324.4297, -1143.3125, 1049.6016, 0.25);
RemoveBuildingForPlayer(playerid, 2138, 2331.3359, -1144.0859, 1049.6953, 0.25);
RemoveBuildingForPlayer(playerid, 2138, 2335.3594, -1144.0703, 1049.6719, 0.25);
RemoveBuildingForPlayer(playerid, 2135, 2336.3516, -1144.0781, 1049.6719, 0.25);
RemoveBuildingForPlayer(playerid, 2305, 2337.3203, -1144.0781, 1049.6719, 0.25);
RemoveBuildingForPlayer(playerid, 2138, 2331.3359, -1143.1016, 1049.6953, 0.25);
RemoveBuildingForPlayer(playerid, 2138, 2337.3203, -1143.0938, 1049.6719, 0.25);
RemoveBuildingForPlayer(playerid, 1703, 2322.2266, -1142.4766, 1049.4766, 0.25);
RemoveBuildingForPlayer(playerid, 1822, 2323.9297, -1142.2578, 1049.4844, 0.25);
RemoveBuildingForPlayer(playerid, 1741, 2312.6484, -1140.7891, 1053.3750, 0.25);
RemoveBuildingForPlayer(playerid, 2138, 2331.3359, -1142.1094, 1049.6953, 0.25);
RemoveBuildingForPlayer(playerid, 2138, 2331.3359, -1141.1172, 1049.6953, 0.25);
RemoveBuildingForPlayer(playerid, 2079, 2334.4219, -1140.9688, 1050.3359, 0.25);
RemoveBuildingForPlayer(playerid, 1703, 2326.5234, -1140.5703, 1049.4766, 0.25);
RemoveBuildingForPlayer(playerid, 2138, 2337.3203, -1142.1094, 1049.6719, 0.25);
RemoveBuildingForPlayer(playerid, 2139, 2337.3125, -1141.1094, 1049.6641, 0.25);
RemoveBuildingForPlayer(playerid, 2088, 2338.4531, -1141.3672, 1053.2734, 0.25);
RemoveBuildingForPlayer(playerid, 2270, 2340.2734, -1141.7109, 1054.5391, 0.25);
RemoveBuildingForPlayer(playerid, 15050, 2330.3281, -1140.3047, 1051.9063, 0.25);
RemoveBuildingForPlayer(playerid, 2138, 2331.3359, -1140.1328, 1049.6953, 0.25);
RemoveBuildingForPlayer(playerid, 1703, 2323.4375, -1139.5469, 1049.4766, 0.25);
RemoveBuildingForPlayer(playerid, 2079, 2333.3281, -1139.8672, 1050.3359, 0.25);
RemoveBuildingForPlayer(playerid, 2115, 2334.4297, -1139.6250, 1049.7109, 0.25);
RemoveBuildingForPlayer(playerid, 15049, 2334.3281, -1139.5859, 1051.1953, 0.25);
RemoveBuildingForPlayer(playerid, 2079, 2335.3672, -1139.8750, 1050.3359, 0.25);
RemoveBuildingForPlayer(playerid, 2303, 2337.3281, -1140.1172, 1049.6719, 0.25);
RemoveBuildingForPlayer(playerid, 2090, 2309.5156, -1139.3438, 1053.4219, 0.25);
RemoveBuildingForPlayer(playerid, 2138, 2331.3359, -1139.1406, 1049.6953, 0.25);
RemoveBuildingForPlayer(playerid, 2079, 2333.3281, -1138.8281, 1050.3359, 0.25);
RemoveBuildingForPlayer(playerid, 2079, 2335.3672, -1138.8359, 1050.3359, 0.25);
RemoveBuildingForPlayer(playerid, 2298, 2336.5391, -1138.7891, 1053.2813, 0.25);
RemoveBuildingForPlayer(playerid, 2138, 2331.3359, -1138.1563, 1049.6953, 0.25);
RemoveBuildingForPlayer(playerid, 2136, 2337.3281, -1138.1328, 1049.6719, 0.25);
RemoveBuildingForPlayer(playerid, 2240, 2319.2500, -1137.8750, 1050.0156, 0.25);
RemoveBuildingForPlayer(playerid, 2240, 2329.5000, -1137.8750, 1050.0156, 0.25);
RemoveBuildingForPlayer(playerid, 2138, 2331.3359, -1137.1641, 1049.6953, 0.25);
RemoveBuildingForPlayer(playerid, 2079, 2334.4219, -1137.5859, 1050.3359, 0.25);
RemoveBuildingForPlayer(playerid, 2139, 2337.3125, -1137.1484, 1049.6641, 0.25);
RemoveBuildingForPlayer(playerid, 2088, 2310.6641, -1136.3047, 1053.3672, 0.25);
RemoveBuildingForPlayer(playerid, 2257, 2320.4141, -1134.6328, 1053.8281, 0.25);
RemoveBuildingForPlayer(playerid, 2138, 2331.3359, -1136.1719, 1049.6953, 0.25);
RemoveBuildingForPlayer(playerid, 2138, 2331.3359, -1135.1875, 1049.6953, 0.25);
RemoveBuildingForPlayer(playerid, 2254, 2328.1484, -1134.6172, 1054.0625, 0.25);
RemoveBuildingForPlayer(playerid, 2281, 2335.2656, -1136.4063, 1054.7266, 0.25);
RemoveBuildingForPlayer(playerid, 2106, 2336.5156, -1135.0156, 1053.8047, 0.25);
RemoveBuildingForPlayer(playerid, 2271, 2337.8047, -1135.3516, 1054.7031, 0.25);
RemoveBuildingForPlayer(playerid, 2138, 2337.3203, -1136.1641, 1049.6719, 0.25);
RemoveBuildingForPlayer(playerid, 2138, 2337.3203, -1135.1797, 1049.6719, 0.25);
RemoveBuildingForPlayer(playerid, 2106, 2339.2031, -1135.0156, 1053.8047, 0.25);
RemoveBuildingForPlayer(playerid, 2259, 2316.3125, -1024.5156, 1051.3203, 0.25);
RemoveBuildingForPlayer(playerid, 2242, 2321.4609, -1019.7500, 1049.3672, 0.25);
RemoveBuildingForPlayer(playerid, 2078, 2318.2578, -1017.6016, 1049.1953, 0.25);
RemoveBuildingForPlayer(playerid, 2203, 2312.1641, -1014.5547, 1050.4219, 0.25);
RemoveBuildingForPlayer(playerid, 2139, 2312.3750, -1014.5547, 1049.1953, 0.25);
RemoveBuildingForPlayer(playerid, 2830, 2312.1406, -1013.6719, 1050.2578, 0.25);
RemoveBuildingForPlayer(playerid, 2139, 2312.3750, -1013.5625, 1049.1953, 0.25);
RemoveBuildingForPlayer(playerid, 2241, 2322.4453, -1026.4453, 1050.5000, 0.25);
RemoveBuildingForPlayer(playerid, 2244, 2322.3594, -1019.8906, 1049.4844, 0.25);
RemoveBuildingForPlayer(playerid, 2112, 2322.6563, -1026.4219, 1049.5938, 0.25);
RemoveBuildingForPlayer(playerid, 2105, 2323.0156, -1026.8594, 1050.4453, 0.25);
RemoveBuildingForPlayer(playerid, 2224, 2322.6953, -1019.0859, 1049.2031, 0.25);
RemoveBuildingForPlayer(playerid, 2281, 2324.3125, -1017.7969, 1051.2266, 0.25);
RemoveBuildingForPlayer(playerid, 2261, 2322.4609, -1015.4297, 1051.1563, 0.25);
RemoveBuildingForPlayer(playerid, 2165, 2323.3750, -1015.8984, 1053.7031, 0.25);
RemoveBuildingForPlayer(playerid, 1714, 2323.7500, -1014.8594, 1053.7109, 0.25);
RemoveBuildingForPlayer(playerid, 1755, 2325.2734, -1025.0625, 1049.1406, 0.25);
RemoveBuildingForPlayer(playerid, 2229, 2325.6406, -1017.2813, 1049.2031, 0.25);
RemoveBuildingForPlayer(playerid, 2107, 2326.0703, -1016.6719, 1050.6641, 0.25);
RemoveBuildingForPlayer(playerid, 2088, 2325.5313, -1015.0938, 1053.6953, 0.25);
RemoveBuildingForPlayer(playerid, 15060, 2326.6641, -1022.1953, 1049.2266, 0.25);
RemoveBuildingForPlayer(playerid, 2280, 2327.3125, -1017.7969, 1051.2109, 0.25);
RemoveBuildingForPlayer(playerid, 2104, 2327.1719, -1017.2109, 1049.2109, 0.25);
RemoveBuildingForPlayer(playerid, 2088, 2327.4766, -1015.0938, 1053.6953, 0.25);
RemoveBuildingForPlayer(playerid, 2139, 2312.3750, -1012.5703, 1049.1953, 0.25);
RemoveBuildingForPlayer(playerid, 2303, 2312.3594, -1011.5859, 1049.2031, 0.25);
RemoveBuildingForPlayer(playerid, 2079, 2313.8906, -1011.5781, 1049.8359, 0.25);
RemoveBuildingForPlayer(playerid, 2079, 2314.9844, -1012.6797, 1049.8359, 0.25);
RemoveBuildingForPlayer(playerid, 2115, 2314.9922, -1011.4063, 1049.2031, 0.25);
RemoveBuildingForPlayer(playerid, 2832, 2315.0547, -1011.2813, 1050.0000, 0.25);
RemoveBuildingForPlayer(playerid, 2079, 2315.9297, -1011.5859, 1049.8359, 0.25);
RemoveBuildingForPlayer(playerid, 2831, 2312.1875, -1010.6563, 1050.2656, 0.25);
RemoveBuildingForPlayer(playerid, 2136, 2312.3594, -1010.6094, 1049.2031, 0.25);
RemoveBuildingForPlayer(playerid, 2079, 2313.8906, -1010.5391, 1049.8359, 0.25);
RemoveBuildingForPlayer(playerid, 2079, 2315.9297, -1010.5469, 1049.8359, 0.25);
RemoveBuildingForPlayer(playerid, 2139, 2317.3438, -1009.5938, 1049.2031, 0.25);
RemoveBuildingForPlayer(playerid, 2079, 2314.9844, -1009.2969, 1049.8359, 0.25);
RemoveBuildingForPlayer(playerid, 1822, 2324.3359, -1012.2188, 1049.2109, 0.25);
RemoveBuildingForPlayer(playerid, 2333, 2323.4922, -1009.7266, 1053.7031, 0.25);
RemoveBuildingForPlayer(playerid, 2291, 2323.7891, -1009.5938, 1049.2109, 0.25);
RemoveBuildingForPlayer(playerid, 2291, 2324.7813, -1009.5938, 1049.2109, 0.25);
RemoveBuildingForPlayer(playerid, 2331, 2323.4453, -1009.2813, 1053.9531, 0.25);
RemoveBuildingForPlayer(playerid, 2298, 2325.0625, -1010.7188, 1053.7031, 0.25);
RemoveBuildingForPlayer(playerid, 2291, 2325.7813, -1009.5938, 1049.2109, 0.25);
RemoveBuildingForPlayer(playerid, 1822, 2326.6250, -1012.2188, 1049.2109, 0.25);
RemoveBuildingForPlayer(playerid, 2291, 2326.7734, -1009.5938, 1049.2109, 0.25);
RemoveBuildingForPlayer(playerid, 2138, 2312.3672, -1008.6094, 1049.2031, 0.25);
RemoveBuildingForPlayer(playerid, 2138, 2314.3281, -1007.6328, 1049.2031, 0.25);
RemoveBuildingForPlayer(playerid, 2305, 2312.3672, -1007.6250, 1049.2031, 0.25);
RemoveBuildingForPlayer(playerid, 2135, 2313.3359, -1007.6250, 1049.2031, 0.25);
RemoveBuildingForPlayer(playerid, 2139, 2317.3438, -1008.6016, 1049.2031, 0.25);
RemoveBuildingForPlayer(playerid, 1735, 2318.8047, -1007.9688, 1049.1953, 0.25);
RemoveBuildingForPlayer(playerid, 2139, 2317.3438, -1007.6094, 1049.2031, 0.25);
RemoveBuildingForPlayer(playerid, 2287, 2320.0547, -1007.2500, 1055.7578, 0.25);
RemoveBuildingForPlayer(playerid, 2194, 2322.3594, -1008.4453, 1054.9453, 0.25);
RemoveBuildingForPlayer(playerid, 2106, 2325.0391, -1006.9453, 1054.2266, 0.25);
RemoveBuildingForPlayer(playerid, 2528, 2321.2656, -1006.0313, 1053.7266, 0.25);
RemoveBuildingForPlayer(playerid, 2249, 2323.0156, -1005.8828, 1054.3984, 0.25);
RemoveBuildingForPlayer(playerid, 2526, 2318.3750, -1003.0703, 1053.7422, 0.25);
RemoveBuildingForPlayer(playerid, 2523, 2322.2500, -1003.0703, 1053.7188, 0.25);
RemoveBuildingForPlayer(playerid, 1760, 2327.8047, -1021.0313, 1049.1953, 0.25);
RemoveBuildingForPlayer(playerid, 2295, 2328.7891, -1015.8281, 1049.1953, 0.25);
RemoveBuildingForPlayer(playerid, 1739, 2328.8359, -1023.6016, 1050.1094, 0.25);
RemoveBuildingForPlayer(playerid, 1739, 2329.0469, -1022.6953, 1050.1094, 0.25);
RemoveBuildingForPlayer(playerid, 2229, 2329.0703, -1017.2813, 1049.2031, 0.25);
RemoveBuildingForPlayer(playerid, 2295, 2329.2578, -1015.8281, 1053.7891, 0.25);
RemoveBuildingForPlayer(playerid, 2291, 2327.7578, -1009.5938, 1049.2109, 0.25);
RemoveBuildingForPlayer(playerid, 2106, 2327.7266, -1006.9453, 1054.2266, 0.25);
RemoveBuildingForPlayer(playerid, 2291, 2329.1875, -1011.0078, 1049.2109, 0.25);
RemoveBuildingForPlayer(playerid, 2291, 2329.1875, -1011.9922, 1049.2109, 0.25);
RemoveBuildingForPlayer(playerid, 2291, 2329.1875, -1010.0234, 1049.2109, 0.25);
RemoveBuildingForPlayer(playerid, 2285, 2328.9766, -1007.6406, 1051.2266, 0.25);
RemoveBuildingForPlayer(playerid, 2869, 2329.2891, -1025.8672, 1049.2266, 0.25);
RemoveBuildingForPlayer(playerid, 2829, 2329.4688, -1023.6250, 1050.0078, 0.25);
RemoveBuildingForPlayer(playerid, 2868, 2329.7656, -1023.0156, 1050.0000, 0.25);
RemoveBuildingForPlayer(playerid, 2117, 2329.6953, -1022.5859, 1049.2031, 0.25);
RemoveBuildingForPlayer(playerid, 1739, 2330.3672, -1023.5156, 1050.1094, 0.25);
RemoveBuildingForPlayer(playerid, 1739, 2330.3672, -1022.6875, 1050.1094, 0.25);
RemoveBuildingForPlayer(playerid, 2243, 2329.2969, -1018.0313, 1049.3984, 0.25);
RemoveBuildingForPlayer(playerid, 2096, 2330.2266, -1012.9688, 1053.7109, 0.25);
RemoveBuildingForPlayer(playerid, 2240, 2330.7422, -1010.7813, 1054.2578, 0.25);
RemoveBuildingForPlayer(playerid, 2096, 2330.2266, -1009.1875, 1053.7109, 0.25);

RemoveBuildingForPlayer(playerid, 15039, 2232.340, -1106.739, 1049.750, 0.250);
RemoveBuildingForPlayer(playerid, 15038, 2235.290, -1108.130, 1051.270, 0.250);
return 1;
}

GetClosestTree(playerid, Float: range = 2.0)
{
	new id = -1, Float: dist = range, Float: tempdist;
	foreach (new i : Trees)
	{
	    tempdist = GetPlayerDistanceFromPoint(playerid, TreeData[i][treeX], TreeData[i][treeY], TreeData[i][treeZ]);

	    if (tempdist > range) continue;
		if (tempdist <= dist)
		{
			dist = tempdist;
			id = i;
		}
	}

	return id;
}

IsPlayerNearALogBuyer(playerid)
{
	foreach (new i : Buyers)
	{
	    if (IsPlayerInRangeOfPoint(playerid, 2.0, BuyerData[i][buyerX], BuyerData[i][buyerY], BuyerData[i][buyerZ])) return 1;
	}

	return 0;
}

Player_ResetCutting(playerid)
{
	if (!OyundaDegil(playerid) || CuttingTreeID[playerid] == -1) return 0;
	new id = CuttingTreeID[playerid];
	TreeData[id][treeGettingCut] = false;
	if (TreeData[id][treeSeconds] < 1) Streamer_SetIntData(STREAMER_TYPE_3D_TEXT_LABEL, TreeData[id][treeLabel], E_STREAMER_COLOR, 0x2ECC71FF);

	ClearAnimations(playerid);
    TogglePlayerControllable(playerid, 1);
    CuttingTreeID[playerid] = -1;

    if (CuttingTimer[playerid] != -1)
	{
	    KillTimer(CuttingTimer[playerid]);
		CuttingTimer[playerid] = -1;
	}

	SetPlayerProgressBarValue(playerid, CuttingBar[playerid], 0.0);
	HidePlayerProgressBar(playerid, CuttingBar[playerid]);
	return 1;
}

Player_GiveLog(playerid)
{
    if (!OyundaDegil(playerid)) return 0;
	CarryingLog[playerid] = true;
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
	SetPlayerAttachedObject(playerid, ATTACH_INDEX, 2804, 6, 0.077999, 0.043999, -0.170999, -13.799953, 79.70, 0.0);

	//SendClientMessage(playerid, 0x3498DBFF, ": {FFFFFF}You can press {F1C40F}~k~~CONVERSATION_NO~ {FFFFFF}to drop your log.");
	return 1;
}
Player_RemoveLog(playerid)
{
	if (!OyundaDegil(playerid) || !CarryingLog[playerid]) return 0;
	RemovePlayerAttachedObject(playerid, ATTACH_INDEX);
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
	CarryingLog[playerid] = false;
	return 1;
}
Tree_BeingEdited(id)
{
	if (!Iter_Contains(Trees, id)) return 0;
	foreach (new i : Player) if (EditingTreeID[i] == id) return 1;
	return 0;
}

Tree_UpdateLogLabel(id)
{
    if (!Iter_Contains(Trees, id)) return 0;
    new label[96];

    if (TreeData[id][treeLogs] > 0) {
	    format(label, sizeof(label), "Kesilmiþ Ýnek (%d)\n\n{FFFFFF}: {F1C40F}%d\n{F1C40F}/et eline al {FFFFFF}ile et alabilirsiniz.", id, TreeData[id][treeLogs]);
		UpdateDynamic3DTextLabelText(TreeData[id][treeLabel], 0xE74C3CFF, label);
	}else{
	    TreeData[id][treeTimer] = SetTimerEx("RespawnTree", 1000, true, "i", id);

	    format(label, sizeof(label), "Kesilmiþ Ýnek (%d)\n\n{FFFFFF}%s", id, ConvertToMinutes(TreeData[id][treeSeconds]));
		UpdateDynamic3DTextLabelText(TreeData[id][treeLabel], 0xE74C3CFF, label);
	}

	return 1;
}
Oduncu_InitPlayer(playerid)
{
    CuttingTreeID[playerid] = -1;
    CuttingTimer[playerid] = -1;
	CarryingLog[playerid] = false;
    EditingTreeID[playerid] = -1;

    CuttingBar[playerid] = CreatePlayerProgressBar(playerid, 498.0, 104.0, 113.0, 6.2, 0x61381BFF, CUTTING_TIME, 0);
    ApplyAnimation(playerid, "CHAINSAW", "null", 0.0, 0, 0, 0, 0, 0, 0);
    ApplyAnimation(playerid, "CARRY", "null", 0.0, 0, 0, 0, 0, 0, 0);
	return 1;
}

Vehicle_RemoveLogs(vehicleid)
{
    if (GetVehicleModel(vehicleid) == 0) return 0;
    for (new i; i < LOG_LIMIT; i++)
	{
	    if (IsValidDynamicObject(LogObjects[vehicleid][i]))
	    {
	        DestroyDynamicObject(LogObjects[vehicleid][i]);
	        LogObjects[vehicleid][i] = -1;
	    }
	}

	return 1;
}

Player_DropLog(playerid, death_drop = 0)
{
    if (!IsPlayerConnected(playerid) || !CarryingLog[playerid]) return 0;
    new id = Iter_Free(Logs);
    if (id != -1)
    {
        new Float: x, Float: y, Float: z, Float: a, label[256];
        GetPlayerPos(playerid, x, y, z);
        GetPlayerFacingAngle(playerid, a);
        GetPlayerName(playerid, LogData[id][logDroppedBy], MAX_PLAYER_NAME);

		if (!death_drop)
		{
		    x += (1.0 * floatsin(-a, degrees));
			y += (1.0 * floatcos(-a, degrees));

			ApplyAnimation(playerid, "CARRY", "putdwn05", 4.1, 0, 1, 1, 0, 0, 1);
		}

		LogData[id][logSeconds] = LOG_LIFETIME;
		LogData[id][logObjID] = CreateDynamicObject(2804, x, y, z - 0.9, 0.0, 0.0, a);

		format(label, sizeof(label), "Et (%d)\n\n{F1C40F}%s {FFFFFF}isimli oyuncu býraktý.\n{FFFFFF}%s\nEti almak için {F1C40F}/et yerden al {FFFFFF}yazabilirsin.", id, LogData[id][logDroppedBy], ConvertToMinutes(LOG_LIFETIME));
		LogData[id][logLabel] = CreateDynamic3DTextLabel(label, 0xF1C40FFF, x, y, z - 0.7, 5.0, .testlos = 1);

		LogData[id][logTimer] = SetTimerEx("RemoveLog", 1000, true, "i", id);
		Iter_Add(Logs, id);
    }

    Player_RemoveLog(playerid);
	return 1;
}

// http://forum.sa-mp.com/showpost.php?p=3117531&postcount=5
RGBAToARGB(rgba)
    return rgba >>> 8 | rgba << 24;

stock GetComponentPrice(componentid)
{
    static const ModifiyeFiyatlar[] = {
        400, 550, 200, 250, 100, 150, 80, 500, 200, 500,
        1000, 220, 250, 100, 400, 500, 200, 500, 350, 300,
        250, 200, 150, 350, 50, 1000, 480, 480, 770, 680,
        37, 370, 170, 120, 790, 150, 500, 690, 190, 390,
        500, 390, 1000, 500, 500, 510, 710, 670, 530, 810,
        620, 670, 530, 130, 210, 230, 520, 430, 620, 720,
        530, 180, 250, 430, 830, 850, 750, 250, 200, 550,
        450, 550, 450, 1000, 1030, 980, 1560, 1620, 1200, 1030,
        1000, 1230, 820, 1560, 1350, 770, 100, 1500, 150, 650,
        450, 100, 750, 350, 450, 350, 1000, 620, 1140, 1000,
        940, 780, 830, 3250, 1610, 1540, 780, 780, 780, 1610,
        1540, -1, -1, 3340, 3250, 2130, 2050, 2130, 780, 940,
        780, 940, 780, 860, 780, 1120, 3340, 3250, 3340, 1650,
        3380, 3290, 1590, 830, 800, 1500, 1000, 800, 580, 470,
        870, 980, 150, 150, 100, 100, 490, 600, 890, 1000,
        1090, 840, 910, 1200, 1030, 1030, 920, 930, 550, 1050,
        1050, 950, 650, 550, 450, 850, 950, 850, 950, 970,
        880, 990, 900, 950, 1000, 900, 1000, 900, 2050, 2150,
        2130, 2050, 2130, 2040, 2150, 2040, 2095, 2175, 2080, 2200,
        1200, 1040, 940, 1100
    };

    new comindex = componentid - 1000;

    if (!(0 <= comindex < sizeof(ModifiyeFiyatlar)))
        return -1;

    return ModifiyeFiyatlar[comindex];
}
stock GetComponentName(component) return ModName[component-1000];
stock Pet_Sil(id)
{
	new query[65];
	format(query, sizeof(query), "DELETE FROM `petler` WHERE `petid` = '%d'", PetBilgi[id][petID]);
	mysql_query(g_SQL, query, false);
	FCNPC_Destroy(PetBilgi[id][NPCID]);
 	DestroyDynamic3DTextLabel(PetBilgi[id][petText]);
	PetBilgi[id][petID] = 0;
	PetBilgi[id][NPCID] = -1;
	format(PetBilgi[id][petAdi], 24, "Yok");
	PetBilgi[id][petSahip] = -1;
	PetBilgi[id][petTuru] = 0;
	PetBilgi[id][petCinsiyet] = 0;
	PetBilgi[id][petRenk] = 0;
	PetBilgi[id][petAclik] = 0;
	PetBilgi[id][petSaglik] = 0.0;
	PetBilgi[id][petTakip] = -1;
	PetBilgi[id][petYarali] = 0;
	PetBilgi[id][petDurum] = false;
	PetBilgi[id][petSaldir] = -1;
	PetBilgi[id][petAcikma] = 0;
	Iter_Remove(Petler, id);
	return 1;
}
stock PetYakin(playerid, Float:radius)
{
	foreach (new i:Petler) if (PetBilgi[i][petDurum] == true)
	{
	    new Float:pos[3];
	    FCNPC_GetPosition(PetBilgi[i][NPCID], pos[0], pos[1], pos[2]);
	    if (IsPlayerInRangeOfPoint(playerid, radius, pos[0], pos[1], pos[2]) && PetBilgi[i][petSahip] == PlayerData[playerid][pID] && FCNPC_GetVirtualWorld(PetBilgi[i][NPCID]) == GetPlayerVirtualWorld(playerid))
	    {
	        return i;
	    }
	}
	return -1;
}
stock PetDialog(playerid, id)
{
	new str[750], string[124], petrenk[20], petrenkkod[10];
	switch (PetBilgi[id][petRenk])
	{
	    case 1: petrenk = "Beyaz", petrenkkod = "FFFFFF";
	    case 2: petrenk = "Mavi", petrenkkod = "0295f7";
	    case 3: petrenk = "Kýrmýzý", petrenkkod = "f70202";
	    case 4: petrenk = "Turuncu", petrenkkod = "f77002";
	    case 5: petrenk = "Sarý", petrenkkod = "ffff00";
	    case 6: petrenk = "Mor", petrenkkod = "ee00ff";
	    case 7: petrenk = "Yeþil", petrenkkod = "2aff00";
	}
	strcat(str, "Ýþlem\tDurum\n");
	format(string, sizeof(string), "{ff0050}» {FFFFFF}Pet Adý\t{AFAFAF}%s\n", PetBilgi[id][petAdi]);
	strcat(str, string);
	format(string, sizeof(string), "{ff0050}» {FFFFFF}Pet Ad Rengi\t{%s}%s\n", petrenkkod, petrenk);
	strcat(str, string);
	format(string, sizeof(string), "{ff0050}» {FFFFFF}Pet Türü\t{AFAFAF}%s\n", PetTurIsim(PetBilgi[id][petTuru]));
	strcat(str, string);
	format(string, sizeof(string), "{ff0050}» {FFFFFF}Pet Cinsiyeti\t{AFAFAF}%s\n", (PetBilgi[id][petCinsiyet] == 1) ? ("Erkek") : ("Kadýn"));
	strcat(str, string);
	format(string, sizeof(string), "{ff0050}» {FFFFFF}Pet Açlýk\t{AFAFAF}%d\n", PetBilgi[id][petAclik]);
	strcat(str, string);
	format(string, sizeof(string), "{ff0050}» {FFFFFF}Pet Saðlýk\t{AFAFAF}%.1f \n", FCNPC_GetHealth(PetBilgi[id][NPCID]));
	strcat(str, string);
	format(string, sizeof(string), "{AFAFAF}» {FFFFFF}Pet Moduna Geç\n");
	strcat(str, string);
	format(string, sizeof(string), "{AFAFAF}» {FFFFFF}Pet Takip Modu\t{AFAFAF}%s {AFAFAF}\n", (PetBilgi[id][petTakip] == -1) ? ("{ff0000}Kapalý") : ("{26ff00}Açýk"));
	strcat(str, string);
	format(string, sizeof(string), "{AFAFAF}» {FFFFFF}Peti Besle\n");
	strcat(str, string);
	format(string, sizeof(string), "{AFAFAF}» {FFFFFF}Peti Ýyileþtir\t{AFAFAF}{26ff00}$%d {AFAFAF}", floatround(100-FCNPC_GetHealth(PetBilgi[id][NPCID]))*3);
	strcat(str, string);

	format(string, sizeof(string), "{FFFFFF}%s'in Peti (ID: %d)", SQLName(PetBilgi[id][petSahip], 0), id);
	SetPVarInt(playerid, "PetID", id);
	ShowPlayerDialog(playerid, DIALOG_PET, DIALOG_STYLE_TABLIST_HEADERS, string, str, "Seç", "Kapat");
	return 1;
}

stock Pet_Olustur(sahip, turu, cinsiyet)
{
	for (new i; i < MAX_PET; i++)
	{
	    if (!Iter_Contains(Petler, i))
	    {
     		PetBilgi[i][petID] = i;
	        format(PetBilgi[i][petAdi], 24, "Yok");
	        PetBilgi[i][petSahip] = sahip;
	        PetBilgi[i][petTuru] = turu;
	        PetBilgi[i][petCinsiyet] = cinsiyet;
	        PetBilgi[i][petRenk] = 3;
	        PetBilgi[i][petAclik] = 100;
	        PetBilgi[i][petSaglik] = 100.0;
	        PetBilgi[i][petTakip] = -1;
	        PetBilgi[i][petDurum] = false;
	        PetBilgi[i][petSaldir] = -1;

	        Iter_Add(Petler, i);

			new query[256];
	        mysql_format(g_SQL, query, sizeof(query), "INSERT INTO `petler` (`petid`, `petadi`, `petsahip`, `petturu`, `petcinsiyet`, `petrenk`, `petaclik`, `petsaglik`) VALUES ('%d', 'Yok', '%d', '%d', '%d', '3', '100', '100.0')", PetBilgi[i][petID], sahip, turu, cinsiyet);
	        mysql_query (g_SQL, query);
	        return i;
	    }
	}
	return -1;
}

stock PetTurIsim(tur)
{
	new isim[20];
	isim = "Yok";
	switch (tur)
	{
	    case 1: isim = "Black Pitbull";
	    case 2: isim = "Boxer Dog";
	    case 3: isim = "Brown Pitbull";
	    case 4: isim = "Bull Terrier";
	    case 5: isim = "Dalmation";
	    case 6: isim = "Doberman";
	    case 7: isim = "European Shepherd";
	    case 8: isim = "German Shorthair";
	    case 9: isim = "Gray Pitbull";
	    case 10: isim = "Siberian Husky";
	    case 11: isim = "White Pitbull";
	}
	return isim;
}

stock PetTurSkin(tur)
{
	new skin;
	switch (tur)
	{
	    case 1: skin = 20001;
	    case 2: skin = 20002;
	    case 3: skin = 20003;
	    case 4: skin = 20004;
	    case 5: skin = 20005;
	    case 6: skin = 20006;
	    case 7: skin = 20007;
	    case 8: skin = 20008;
	    case 9: skin = 20009;
	    case 10: skin = 20010;
	    case 11: skin = 20011;
	    default: skin = 20001;
	}
	return skin;
}

stock PlayerInWater(playerid)
{
    new anim = GetPlayerAnimationIndex(playerid);
    if (((anim >=  1538) && (anim <= 1542)) || (anim == 1544) || (anim == 1250) || (anim == 1062)) return true;
	return false;
}
stock Pet_Kaydet(id)
{
	new query[1000];
	format(query, sizeof(query), "UPDATE `petler` SET `petadi` = '%s', `petsahip` = '%d', `petturu` = '%d', `petcinsiyet` = '%d', `petrenk` = '%d', `petaclik` = '%d', `petsaglik` = '%.1f', `petyarali` = '%d' WHERE `petid` = '%d'",
	PetBilgi[id][petAdi],
	PetBilgi[id][petSahip],
	PetBilgi[id][petTuru],
	PetBilgi[id][petCinsiyet],
	PetBilgi[id][petRenk],
	PetBilgi[id][petAclik],
	(PetBilgi[id][petDurum] == true) ? (FCNPC_GetHealth(PetBilgi[id][NPCID])) : (PetBilgi[id][petSaglik]),
	PetBilgi[id][petYarali],
	PetBilgi[id][petID]);
	mysql_query(g_SQL, query, false);
	return 1;
}

stock NPCYukle()
{
	mysql_query(g_SQL, "SELECT * FROM `npcler`");

	new rows = cache_num_rows();

	printf("» Toplam %d NPC yüklendi.", rows);

	if (rows)
	{
	    new npID;

		for (new i = 0; i < rows; i ++)
		{
		    cache_get_value_name_int(i, "npcID", npID);

		    NPCBilgi[npID][npcExists] = true;
		    NPCBilgi[npID][npcID] = npID;

		    cache_get_value_name(i, "npcAd", NPCBilgi[npID][npcAd], 24);
		    cache_get_value_name_int(i, "npcSkin", NPCBilgi[npID][npcSkin]);
		    cache_get_value_name_float(i, "npcX", NPCBilgi[npID][npcPos][0]);
		    cache_get_value_name_float(i, "npcY", NPCBilgi[npID][npcPos][1]);
		    cache_get_value_name_float(i, "npcZ", NPCBilgi[npID][npcPos][2]);
		    cache_get_value_name_float(i, "npcA", NPCBilgi[npID][npcPos][3]);
		    cache_get_value_name_int(i, "npcVw", NPCBilgi[npID][npcVw]);
		    cache_get_value_name(i, "Secenek1", NPCSecenekler[npID][0], 50);
		    cache_get_value_name(i, "Secenek1Cevap", NPCSecenekCevaplar[npID][0], 200);
		    cache_get_value_name(i, "Secenek2", NPCSecenekler[npID][1], 50);
		    cache_get_value_name(i, "Secenek2Cevap", NPCSecenekCevaplar[npID][1], 200);
		    cache_get_value_name(i, "Secenek3", NPCSecenekler[npID][2], 50);
		    cache_get_value_name(i, "Secenek3Cevap", NPCSecenekCevaplar[npID][2], 200);
		    cache_get_value_name(i, "Secenek4", NPCSecenekler[npID][3], 50);
		    cache_get_value_name(i, "Secenek4Cevap", NPCSecenekCevaplar[npID][3], 200);
		    cache_get_value_name(i, "Secenek5", NPCSecenekler[npID][4], 50);
		    cache_get_value_name(i, "Secenek5Cevap", NPCSecenekCevaplar[npID][4], 200);

		    NPC_Refresh(npID);
		}
	}
	return 1;
}

stock NPC_Refresh(id)
{
	if (id != -1 && NPCBilgi[id][npcExists])
	{
	    if (IsValidDynamic3DTextLabel(NPCBilgi[id][npcLabel])) DestroyDynamic3DTextLabel(NPCBilgi[id][npcLabel]);
	    if (IsValidDynamicActor(NPCBilgi[id][npcActor])) DestroyDynamicActor(NPCBilgi[id][npcActor]);
	    NPCBilgi[id][npcActor] = CreateDynamicActor(NPCBilgi[id][npcSkin], NPCBilgi[id][npcPos][0], NPCBilgi[id][npcPos][1], NPCBilgi[id][npcPos][2], NPCBilgi[id][npcPos][3], 1, 100, NPCBilgi[id][npcVw]);
	    new str[124];
	    format(str, sizeof(str), "{E74C3C}[%s] (#%d)\n{E74C3C}[ALT] {FFFFFF}- Etkileþim", NPCBilgi[id][npcAd], id);
	    NPCBilgi[id][npcLabel] = CreateDynamic3DTextLabel(str, -1, NPCBilgi[id][npcPos][0], NPCBilgi[id][npcPos][1], NPCBilgi[id][npcPos][2]+1.2, 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, NPCBilgi[id][npcVw]);
	}
	return 1;
}

stock GraffitiYukle()
{
    mysql_query(g_SQL, "SELECT * FROM `graffiti`");

    new rows = cache_num_rows();

	if (rows)
	{
	    new grafID;
	    for (new i = 0; i < rows; i ++) if (i < MAX_GRAFFITI_POINTS)
	    {
	        cache_get_value_name_int(i, "graffitiID", grafID);

            GraffitiData[grafID][graffitiExists] = 1;
            GraffitiData[grafID][graffitiID] = grafID;

			cache_get_value_name(i, "graffitiText", GraffitiData[grafID][graffitiText], 64);
	        cache_get_value_name(i, "graffitiFont", GraffitiData[grafID][graffitiFont], 64);
	        cache_get_value_name_float(i, "graffitiX", GraffitiData[grafID][graffitiPos][0]);
	        cache_get_value_name_float(i, "graffitiY", GraffitiData[grafID][graffitiPos][1]);
	        cache_get_value_name_float(i, "graffitiZ", GraffitiData[grafID][graffitiPos][2]);
	        cache_get_value_name_float(i, "graffitiRX", GraffitiData[grafID][graffitiPos][3]);
	        cache_get_value_name_float(i, "graffitiRY", GraffitiData[grafID][graffitiPos][4]);
	        cache_get_value_name_float(i, "graffitiRZ", GraffitiData[grafID][graffitiPos][5]);

	        Graffiti_Refresh(grafID);
	    }
	}

    return 1;
}

stock Graffiti_Refresh(id)
{
    if (id != -1 && GraffitiData[id][graffitiExists])
    {

        if (IsValidDynamicObject(GraffitiData[id][graffitiObject]))
            DestroyDynamicObject(GraffitiData[id][graffitiObject]);


        GraffitiData[id][graffitiObject] = CreateDynamicObject(19482, GraffitiData[id][graffitiPos][0], GraffitiData[id][graffitiPos][1], GraffitiData[id][graffitiPos][2], GraffitiData[id][graffitiPos][3], GraffitiData[id][graffitiPos][4], GraffitiData[id][graffitiPos][5]);
		SetDynamicObjectMaterialText(GraffitiData[id][graffitiObject], 0, GraffitiData[id][graffitiText], OBJECT_MATERIAL_SIZE_256x256, GraffitiData[id][graffitiFont], 24, 0, 0xFFFFFFFF, 0, 1);
    }
    return 1;
}
stock Graffiti_Save(id)
{
    new
        query[384];

    format(query, sizeof(query), "UPDATE `graffiti` SET `graffitiX` = '%.4f', `graffitiY` = '%.4f', `graffitiZ` = '%.4f', `graffitiRX` = '%.4f', `graffitiRY` = '%.4f', `graffitiRZ` = '%.4f', `graffitiText` = '%s', `graffitiFont` = '%s' WHERE `graffitiID` = '%d'",
        GraffitiData[id][graffitiPos][0],
        GraffitiData[id][graffitiPos][1],
        GraffitiData[id][graffitiPos][2],
        GraffitiData[id][graffitiPos][3],
        GraffitiData[id][graffitiPos][4],
        GraffitiData[id][graffitiPos][5],
        SQL_ReturnEscaped(GraffitiData[id][graffitiText]),
        SQL_ReturnEscaped(GraffitiData[id][graffitiFont]),
        GraffitiData[id][graffitiID]
    );
    mysql_tquery(g_SQL, query);
    return 1;
}

stock Graffiti_Create(Float:x, Float:y, Float:z)
{
    for (new i = 0; i < MAX_GRAFFITI_POINTS; i ++)
    {
        if (!GraffitiData[i][graffitiExists])
        {
            GraffitiData[i][graffitiExists] = 1;
            GraffitiData[i][graffitiID] = i;

            GraffitiData[i][graffitiPos][0] = x;
            GraffitiData[i][graffitiPos][1] = y;
            GraffitiData[i][graffitiPos][2] = z;
            GraffitiData[i][graffitiPos][3] = 0.0;
            GraffitiData[i][graffitiPos][4] = 0.0;
            GraffitiData[i][graffitiPos][5] = 0.0;

            format(GraffitiData[i][graffitiText], 32, "Graffiti");
            format(GraffitiData[i][graffitiFont], 32, "Arial");

            Graffiti_Refresh(i);

			new query[256];

			mysql_format(g_SQL, query, sizeof query, "INSERT INTO `graffiti` (`graffitiID`, `graffitiRX`) VALUES ('%d', '0.0')", i);
			mysql_query (g_SQL, query);

    		Graffiti_Save(i);
            return i;
        }
    }
    return -1;
}


stock Hood_Yenile(id)
{
	if (IsValidDynamic3DTextLabel(Hood[id][hLabel])) DestroyDynamic3DTextLabel(Hood[id][hLabel]);
	if (IsValidDynamicArea(Hood[id][hZone])) DestroyDynamicArea(Hood[id][hZone]);
	if (IsValidDynamicPickup(Hood[id][hPickup])) DestroyDynamicPickup(Hood[id][hPickup]);
	if (IsValidDynamicMapIcon(Hood[id][hMapIcon])) DestroyDynamicMapIcon(Hood[id][hMapIcon]);
	new str[124];
	format(str, sizeof(str), "Onaylý Hood (#%d)\n%s", id, Birlikler[Hood[id][hBirlik]][birlikAd]);
	Hood[id][hLabel] = CreateDynamic3DTextLabel(str, COLOR_RED, Hood[id][hPos][0], Hood[id][hPos][1], Hood[id][hPos][2], 10.0);
	Hood[id][hZone] = CreateDynamicRectangle(Hood[id][hPos][0]-45, Hood[id][hPos][1]-45, Hood[id][hPos][0]+45, Hood[id][hPos][1]+45, 0, 0);
	Hood[id][hPickup] = CreateDynamicPickup(1313, 23, Hood[id][hPos][0], Hood[id][hPos][1], Hood[id][hPos][2], 0, 0);
	Hood[id][hMapIcon] = CreateDynamicMapIcon(Hood[id][hPos][0], Hood[id][hPos][1], Hood[id][hPos][2], 23, 0, 0);
	return 1;
}
stock PetleriYukle()
{
	mysql_query(g_SQL, "SELECT * FROM `petler`");
	new rows = cache_num_rows();

	printf("» Toplam %d pet yüklendi.", rows);

	if (rows)
	{
	    new pPID;
		for (new i; i < rows; i++)
		{
		    cache_get_value_name_int(i, "petid", pPID);

		    PetBilgi[pPID][petID] = pPID;

		    cache_get_value_name(i, "petadi", PetBilgi[pPID][petAdi], 24);
		    cache_get_value_name_int(i, "petsahip", PetBilgi[pPID][petSahip]);
		    cache_get_value_name_int(i, "petturu", PetBilgi[pPID][petTuru]);
		    cache_get_value_name_int(i, "petcinsiyet", PetBilgi[pPID][petCinsiyet]);
		    cache_get_value_name_int(i, "petrenk", PetBilgi[pPID][petRenk]);
		    cache_get_value_name_int(i, "petaclik", PetBilgi[pPID][petAclik]);
		    cache_get_value_name_float(i, "petsaglik", PetBilgi[pPID][petSaglik]);
		    cache_get_value_name_int(i, "petyarali", PetBilgi[pPID][petYarali]);

			PetBilgi[pPID][petTakip] = -1;
		    PetBilgi[pPID][petDurum] = false;
		    Iter_Add(Petler, pPID);
		}
	}
	return 1;
}

stock GetPlayerPosEx(playerid, &Float:x, &Float:y, &Float:z)
{
	new id = Entrance_Inside(playerid);
	if (id != -1)
	{
	    x = EntranceData[id][entrancePos][0];
	    y = EntranceData[id][entrancePos][1];
	    z = EntranceData[id][entrancePos][2];
	    return 1;
	}
	id = House_Inside(playerid);
	if (id != -1)
	{
	    x = HouseInfo[id][evPos][0];
	    y = HouseInfo[id][evPos][1];
	    z = HouseInfo[id][evPos][2];
	    return 1;
	}
	id = Garage_Inside(playerid);
	if (id != -1)
	{
	    x = GarageData[id][gPos][0];
	    y = GarageData[id][gPos][1];
	    z = GarageData[id][gPos][2];
	    return 1;
	}
	id = Business_Inside(playerid);
	if (id != -1)
	{
	    x = Isyeri[id][isyeriPos][0];
	    y = Isyeri[id][isyeriPos][1];
	    z = Isyeri[id][isyeriPos][2];
	    return 1;
	}
	GetPlayerPos(playerid, x, y, z);
	return 1;
}

stock IsPlayerInWater(playerid)
{
        new Float:Z;
        GetPlayerPos(playerid,Z,Z,Z);
        if (Z < 0.7) switch (GetPlayerAnimationIndex(playerid)) { case 1543,1538,1539: return 1; }
        if (GetPlayerDistanceFromPoint(playerid,-965,2438,42) <= 700 && Z < 45)return 1;
        new Float:water_places[][] =
        {
                {25.0,  2313.0, -1417.0,        23.0},
                {15.0,  1280.0, -773.0,         1082.0},
                {15.0,  1279.0, -804.0,         86.0},
                {20.0,  1094.0, -674.0,         111.0},
                {26.0,  194.0,  -1232.0,        76.0},
                {25.0,  2583.0, 2385.0,         15.0},
                {25.0,  225.0,  -1187.0,        73.0},
                {50.0,  1973.0, -1198.0,        17.0}
        };
        for (new t=0; t < sizeof water_places; t++)
                if (GetPlayerDistanceFromPoint(playerid,water_places[t][1],water_places[t][2],water_places[t][3]) <= water_places[t][0]) return 1;
        return 0;
}
stock GetInitials(const string[])
{
    new
        ret[32],
        index = 0;

    for (new i = 0, l = strlen(string); i != l; i ++)
    {
        if (('A' <= string[i] <= 'Z') && (i == 0 || string[i - 1] == ' '))
            ret[index++] = string[i];
    }
    return ret;
}
stock convertDatex(timestamp, _form=0){

    new year=1970, day=0, month=0, hour=0, mins=0, sec=0;

    new days_of_month[12] = { 31,28,31,30,31,30,31,31,30,31,30,31 };

    new names_of_month[12][10] = {"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"};

    new returnstring[56];

    while (timestamp>31622400){

        timestamp -= 31536000;

        if ( ((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0) ) timestamp -= 86400;

        year++;

    }

    if ( ((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0) )

        days_of_month[1] = 29;

    else

        days_of_month[1] = 28;

    while (timestamp>86400){

        timestamp -= 86400, day++;

        if (day==days_of_month[month]) day=0, month++;

    }

    while (timestamp>60){

        timestamp -= 60, mins++;

        if ( mins == 60) mins=0, hour++;

    }

    sec=timestamp;

    switch ( _form ){

        case 1: format(returnstring,56, "%02d/%02d/%d %02d:%02d:%02d", day+1, month+1, year, hour, mins, sec);

        case 2: format(returnstring,56, "%s %02d, %d, %02d:%02d:%02d", names_of_month[month],day+1,year, hour, mins, sec);

        case 3: format(returnstring,56, "%d %c%c%c %d, %02d:%02d", day+1,names_of_month[month][0],names_of_month[month][1],names_of_month[month][2], year,hour,mins);

        default: format(returnstring,56, "%02d/%02d/%d %02d:%02d:%02d", day+1, month+1, year, hour, mins, sec);

    }

    return returnstring;

}
stock GetFightStyleName(styleid)
{
    new sname[12];
    sname = "Bilinmiyor";
    switch (styleid)
    {
        case 4: sname = "Normal";
        case 5: sname = "Boxing";
        case 6: sname = "Kung Fu";
        case 7: sname = "Knee Head";
        case 15: sname = "Grabkick";
        case 16: sname = "Elbow";
    }
    return sname;
}
stock Graffiti_Delete(id)
{
    if (id != -1 && GraffitiData[id][graffitiExists])
    {
        new
            string[64];

        if (IsValidDynamicObject(GraffitiData[id][graffitiObject]))
            DestroyDynamicObject(GraffitiData[id][graffitiObject]);

        format(string, sizeof(string), "DELETE FROM `graffiti` WHERE `graffitiID` = '%d'", GraffitiData[id][graffitiID]);
        mysql_tquery(g_SQL, string);

        GraffitiData[id][graffitiExists] = false;
        GraffitiData[id][graffitiText][0] = 0;
        GraffitiData[id][graffitiID] = 0;
    }
    return 1;
}
PaintballSpawn(playerid)
{
	new id = pbOda[playerid];
	if (Paintball[id][odaDurum] != ODA_BASLADI || Paintball[id][odaExists] == false || GetPVarInt(playerid, "OdadanAt") == 1)
	{
	    OdadanAt(playerid, 3);
	    DeletePVar(playerid, "OdadanAt");
	    return 1;
	}
	if (pbTakim[playerid] == 0 && Paintball[id][odaOyunTuru] == 1) return 1;
	if (Paintball[id][odaOyunTuru] == 2)
	{
	    switch (Paintball[id][odaArena])
	    {
	        case 1:
	        {
	            new rand = random(4);
	            switch (rand)
	            {
	                case 0:
	                {
	                    SetPlayerPos(playerid, 1059.3263,2081.4861,10.8203);
	                    SetPlayerFacingAngle(playerid, 322.0627);
	                    SetPlayerInterior(playerid, 0);
	                    SetPlayerVirtualWorld(playerid, id+10);
	                    SetPlayerTeam(playerid, NO_TEAM);
	                    SetPlayerHealth(playerid, 100);
	                    SetPlayerArmour(playerid, Paintball[id][odaZirh]);
	                    ResetPlayerWeapons(playerid);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][0], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][1], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][2], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][3], 1000);
	                    SetPlayerArmedWeapon(playerid, 0);
	                }
	                case 1:
	                {
	                    SetPlayerPos(playerid, 1068.1041,2130.2908,10.8203);
	                    SetPlayerFacingAngle(playerid, 176.9880);
	                    SetPlayerInterior(playerid, 0);
	                    SetPlayerVirtualWorld(playerid, id+10);
	                    SetPlayerTeam(playerid, NO_TEAM);
	                    SetPlayerHealth(playerid, 100);
	                    SetPlayerArmour(playerid, Paintball[id][odaZirh]);
	                    ResetPlayerWeapons(playerid);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][0], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][1], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][2], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][3], 1000);
	                    SetPlayerArmedWeapon(playerid, 0);
	                }
	                case 2:
	                {
	                    SetPlayerPos(playerid, 1087.8287,2078.1233,15.3504);
	                    SetPlayerFacingAngle(playerid, 30.0567);
	                    SetPlayerInterior(playerid, 0);
	                    SetPlayerVirtualWorld(playerid, id+10);
	                    SetPlayerTeam(playerid, NO_TEAM);
	                    SetPlayerHealth(playerid, 100);
	                    SetPlayerArmour(playerid, Paintball[id][odaZirh]);
	                    ResetPlayerWeapons(playerid);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][0], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][1], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][2], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][3], 1000);
	                    SetPlayerArmedWeapon(playerid, 0);
	                }
	                case 3:
	                {
	                    SetPlayerPos(playerid, 1086.3816,2118.1890,15.3504);
	                    SetPlayerFacingAngle(playerid, 111.5241);
	                    SetPlayerInterior(playerid, 0);
	                    SetPlayerVirtualWorld(playerid, id+10);
	                    SetPlayerTeam(playerid, NO_TEAM);
	                    SetPlayerHealth(playerid, 100);
	                    SetPlayerArmour(playerid, Paintball[id][odaZirh]);
	                    ResetPlayerWeapons(playerid);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][0], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][1], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][2], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][3], 1000);
	                    SetPlayerArmedWeapon(playerid, 0);
	                }
	            }
	        }
	        case 2:
	        {
	            new rand = random(5);
	            switch (rand)
	            {
	                case 0:
	                {
	                    SetPlayerPos(playerid, 1250.3260,-47.5597,1001.0268);
	                    SetPlayerFacingAngle(playerid, 304.2428);
	                    SetPlayerInterior(playerid, 18);
	                    SetPlayerVirtualWorld(playerid, id+10);
	                    SetPlayerTeam(playerid, NO_TEAM);
	                    SetPlayerHealth(playerid, 100);
	                    SetPlayerArmour(playerid, Paintball[id][odaZirh]);
	                    ResetPlayerWeapons(playerid);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][0], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][1], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][2], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][3], 1000);
	                    SetPlayerArmedWeapon(playerid, 0);
	                }
	                case 1:
	                {
	                    SetPlayerPos(playerid, 1286.4022,-64.8159,1002.4961);
	                    SetPlayerFacingAngle(playerid, 349.2183);
	                    SetPlayerInterior(playerid, 18);
	                    SetPlayerVirtualWorld(playerid, id+10);
	                    SetPlayerTeam(playerid, NO_TEAM);
	                    SetPlayerHealth(playerid, 100);
	                    SetPlayerArmour(playerid, Paintball[id][odaZirh]);
	                    ResetPlayerWeapons(playerid);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][0], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][1], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][2], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][3], 1000);
	                    SetPlayerArmedWeapon(playerid, 0);
	                    //if (Paintball[id][odaDurum] != ODA_BASLADI) TogglePlayerControllable(playerid, false);
	                }
	                case 3:
	                {
	                    SetPlayerPos(playerid, 1253.7115,-0.0914,1001.0323);
	                    SetPlayerFacingAngle(playerid, 214.8205);
	                    SetPlayerInterior(playerid, 18);
	                    SetPlayerVirtualWorld(playerid, id+10);
	                    SetPlayerTeam(playerid, NO_TEAM);
	                    SetPlayerHealth(playerid, 100);
	                    SetPlayerArmour(playerid, Paintball[id][odaZirh]);
	                    ResetPlayerWeapons(playerid);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][0], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][1], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][2], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][3], 1000);
	                    SetPlayerArmedWeapon(playerid, 0);
	                    //if (Paintball[id][odaDurum] != ODA_BASLADI) TogglePlayerControllable(playerid, false);
	                }
	                case 4:
	                {
	                    SetPlayerPos(playerid, 1308.4783,-45.9482,1001.0313);
	                    SetPlayerFacingAngle(playerid, 68.8058);
	                    SetPlayerInterior(playerid, 18);
	                    SetPlayerVirtualWorld(playerid, id+10);
	                    SetPlayerTeam(playerid, NO_TEAM);
	                    SetPlayerHealth(playerid, 100);
	                    SetPlayerArmour(playerid, Paintball[id][odaZirh]);
	                    ResetPlayerWeapons(playerid);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][0], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][1], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][2], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][3], 1000);
	                    SetPlayerArmedWeapon(playerid, 0);
	                    //if (Paintball[id][odaDurum] != ODA_BASLADI) TogglePlayerControllable(playerid, false);
					}
	            }
	        }
	        case 3:
	        {
	            new rand = random(6);
	            switch (rand)
	            {
	                case 0:
	                {
	                    SetPlayerPos(playerid, -975.1069,1061.2255,1345.6719);
	                    SetPlayerFacingAngle(playerid, 93.5594);
	                    SetPlayerInterior(playerid, 10);
	                    SetPlayerVirtualWorld(playerid, id+10);
	                    SetPlayerTeam(playerid, NO_TEAM);
	                    SetPlayerHealth(playerid, 100);
	                    SetPlayerArmour(playerid, Paintball[id][odaZirh]);
	                    ResetPlayerWeapons(playerid);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][0], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][1], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][2], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][3], 1000);
	                    SetPlayerArmedWeapon(playerid, 0);
	                    //if (Paintball[id][odaDurum] != ODA_BASLADI) TogglePlayerControllable(playerid, false);
					}
					case 1:
					{
					    SetPlayerPos(playerid, -1130.9933,1057.7678,1346.4141);
	                    SetPlayerFacingAngle(playerid, 269.3412);
	                    SetPlayerInterior(playerid, 10);
	                    SetPlayerVirtualWorld(playerid, id+10);
	                    SetPlayerTeam(playerid, NO_TEAM);
	                    SetPlayerHealth(playerid, 100);
	                    SetPlayerArmour(playerid, Paintball[id][odaZirh]);
	                    ResetPlayerWeapons(playerid);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][0], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][1], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][2], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][3], 1000);
	                    SetPlayerArmedWeapon(playerid, 0);
	                    //if (Paintball[id][odaDurum] != ODA_BASLADI) TogglePlayerControllable(playerid, false);
					}
					case 2:
					{
					    SetPlayerPos(playerid, -1084.8049,1042.5554,1343.4354);
	                    SetPlayerFacingAngle(playerid, 301.9282);
	                    SetPlayerInterior(playerid, 10);
	                    SetPlayerVirtualWorld(playerid, id+10);
	                    SetPlayerTeam(playerid, NO_TEAM);
	                    SetPlayerHealth(playerid, 100);
	                    SetPlayerArmour(playerid, Paintball[id][odaZirh]);
	                    ResetPlayerWeapons(playerid);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][0], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][1], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][2], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][3], 1000);
	                    SetPlayerArmedWeapon(playerid, 0);
	                    //if (Paintball[id][odaDurum] != ODA_BASLADI) TogglePlayerControllable(playerid, false);
					}
					case 3:
					{
					    SetPlayerPos(playerid, -1038.9807,1049.7030,1342.1497);
	                    SetPlayerFacingAngle(playerid, 294.7213);
	                    SetPlayerInterior(playerid, 10);
	                    SetPlayerVirtualWorld(playerid, id+10);
	                    SetPlayerTeam(playerid, NO_TEAM);
	                    SetPlayerHealth(playerid, 100);
	                    SetPlayerArmour(playerid, Paintball[id][odaZirh]);
	                    ResetPlayerWeapons(playerid);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][0], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][1], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][2], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][3], 1000);
	                    SetPlayerArmedWeapon(playerid, 0);
	                    //if (Paintball[id][odaDurum] != ODA_BASLADI) TogglePlayerControllable(playerid, false);
					}
					case 4:
					{
					    SetPlayerPos(playerid, -973.8306,1027.6724,1345.0436);
	                    SetPlayerFacingAngle(playerid, 355.1951);
	                    SetPlayerInterior(playerid, 10);
	                    SetPlayerVirtualWorld(playerid, id+10);
	                    SetPlayerTeam(playerid, NO_TEAM);
	                    SetPlayerHealth(playerid, 100);
	                    SetPlayerArmour(playerid, Paintball[id][odaZirh]);
	                    ResetPlayerWeapons(playerid);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][0], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][1], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][2], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][3], 1000);
	                    SetPlayerArmedWeapon(playerid, 0);
	                    //if (Paintball[id][odaDurum] != ODA_BASLADI) TogglePlayerControllable(playerid, false);
					}
					case 5:
					{
					    SetPlayerPos(playerid, -973.0900,1088.9197,1344.9883);
	                    SetPlayerFacingAngle(playerid, 86.3523);
	                    SetPlayerInterior(playerid, 10);
	                    SetPlayerVirtualWorld(playerid, id+10);
	                    SetPlayerTeam(playerid, NO_TEAM);
	                    SetPlayerHealth(playerid, 100);
	                    SetPlayerArmour(playerid, Paintball[id][odaZirh]);
	                    ResetPlayerWeapons(playerid);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][0], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][1], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][2], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][3], 1000);
	                    SetPlayerArmedWeapon(playerid, 0);
	                    //if (Paintball[id][odaDurum] != ODA_BASLADI) TogglePlayerControllable(playerid, false);
					}
				}
	        }
	        case 4:
	        {
	            new rand = random(6);
	            switch (rand)
	            {
	                case 0:
	                {
		                SetPlayerPos(playerid, 239.0441,143.9385,1003.0234);
	                 	SetPlayerFacingAngle(playerid, 357.3882);
	                  	SetPlayerInterior(playerid, 3);
	                   	SetPlayerVirtualWorld(playerid, id+10);
	                    SetPlayerTeam(playerid, NO_TEAM);
	                    SetPlayerHealth(playerid, 100);
	                    SetPlayerArmour(playerid, Paintball[id][odaZirh]);
	                    ResetPlayerWeapons(playerid);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][0], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][1], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][2], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][3], 1000);
	                    SetPlayerArmedWeapon(playerid, 0);
	                    //if (Paintball[id][odaDurum] != ODA_BASLADI) TogglePlayerControllable(playerid, false);
                    }
                    case 1:
                    {
                        SetPlayerPos(playerid, 300.0846,183.6274,1007.1719);
	                 	SetPlayerFacingAngle(playerid, 95.4391);
	                  	SetPlayerInterior(playerid, 3);
	                   	SetPlayerVirtualWorld(playerid, id+10);
	                    SetPlayerTeam(playerid, NO_TEAM);
	                    SetPlayerHealth(playerid, 100);
	                    SetPlayerArmour(playerid, Paintball[id][odaZirh]);
	                    ResetPlayerWeapons(playerid);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][0], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][1], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][2], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][3], 1000);
	                    SetPlayerArmedWeapon(playerid, 0);
	                    //if (Paintball[id][odaDurum] != ODA_BASLADI) TogglePlayerControllable(playerid, false);
                    }
                    case 2:
                    {
                        SetPlayerPos(playerid, 245.1610,185.1715,1008.1719);
	                 	SetPlayerFacingAngle(playerid, 321.9813);
	                  	SetPlayerInterior(playerid, 3);
	                   	SetPlayerVirtualWorld(playerid, id+10);
	                    SetPlayerTeam(playerid, NO_TEAM);
	                    SetPlayerHealth(playerid, 100);
	                    SetPlayerArmour(playerid, Paintball[id][odaZirh]);
	                    ResetPlayerWeapons(playerid);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][0], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][1], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][2], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][3], 1000);
	                    SetPlayerArmedWeapon(playerid, 0);
	                    //if (Paintball[id][odaDurum] != ODA_BASLADI) TogglePlayerControllable(playerid, false);
                    }
                    case 3:
                    {
                        SetPlayerPos(playerid, 208.3106,142.2589,1003.0234);
	                 	SetPlayerFacingAngle(playerid, 271.8475);
	                  	SetPlayerInterior(playerid, 3);
	                   	SetPlayerVirtualWorld(playerid, id+10);
	                    SetPlayerTeam(playerid, NO_TEAM);
	                    SetPlayerHealth(playerid, 100);
	                    SetPlayerArmour(playerid, Paintball[id][odaZirh]);
	                    ResetPlayerWeapons(playerid);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][0], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][1], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][2], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][3], 1000);
	                    SetPlayerArmedWeapon(playerid, 0);
	                    //if (Paintball[id][odaDurum] != ODA_BASLADI) TogglePlayerControllable(playerid, false);
                    }
                    case 4:
                    {
                        SetPlayerPos(playerid, 196.2699,179.3185,1003.0234);
	                 	SetPlayerFacingAngle(playerid, 250.2508);
	                  	SetPlayerInterior(playerid, 3);
	                   	SetPlayerVirtualWorld(playerid, id+10);
	                    SetPlayerTeam(playerid, NO_TEAM);
	                    SetPlayerHealth(playerid, 100);
	                    SetPlayerArmour(playerid, Paintball[id][odaZirh]);
	                    ResetPlayerWeapons(playerid);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][0], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][1], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][2], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][3], 1000);
	                    SetPlayerArmedWeapon(playerid, 0);
	                    //if (Paintball[id][odaDurum] != ODA_BASLADI) TogglePlayerControllable(playerid, false);
                    }
                    case 5:
                    {
                        SetPlayerPos(playerid, 230.5995,183.4883,1003.0313);
	                 	SetPlayerFacingAngle(playerid, 124.6263);
	                  	SetPlayerInterior(playerid, 3);
	                   	SetPlayerVirtualWorld(playerid, id+10);
	                    SetPlayerTeam(playerid, NO_TEAM);
	                    SetPlayerHealth(playerid, 100);
	                    SetPlayerArmour(playerid, Paintball[id][odaZirh]);
	                    ResetPlayerWeapons(playerid);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][0], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][1], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][2], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][3], 1000);
	                    SetPlayerArmedWeapon(playerid, 0);
	                    //if (Paintball[id][odaDurum] != ODA_BASLADI) TogglePlayerControllable(playerid, false);
                    }
	            }

	        }
	        case 5:
	        {
	            new rand = random(5);
	            switch (rand)
	            {
	                case 0:
	                {
	                    SetPlayerPos(playerid, 1058.8458,2081.5845,10.8203);
	                 	SetPlayerFacingAngle(playerid, 332.0316);
	                  	SetPlayerInterior(playerid, 0);
	                   	SetPlayerVirtualWorld(playerid, id+10);
	                    SetPlayerTeam(playerid, NO_TEAM);
	                    SetPlayerHealth(playerid, 100);
	                    SetPlayerArmour(playerid, Paintball[id][odaZirh]);
	                    ResetPlayerWeapons(playerid);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][0], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][1], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][2], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][3], 1000);
	                    SetPlayerArmedWeapon(playerid, 0);
	                    //if (Paintball[id][odaDurum] != ODA_BASLADI) TogglePlayerControllable(playerid, false);
	                }
	                case 1:
	                {
	                    SetPlayerPos(playerid, 1069.3534,2129.8914,10.8203);
	                 	SetPlayerFacingAngle(playerid, 172.2302);
	                  	SetPlayerInterior(playerid, 0);
	                   	SetPlayerVirtualWorld(playerid, id+10);
	                    SetPlayerTeam(playerid, NO_TEAM);
						SetPlayerHealth(playerid, 100);
	                    SetPlayerArmour(playerid, Paintball[id][odaZirh]);
	                    ResetPlayerWeapons(playerid);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][0], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][1], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][2], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][3], 1000);
	                    SetPlayerArmedWeapon(playerid, 0);
	                    //if (Paintball[id][odaDurum] != ODA_BASLADI) TogglePlayerControllable(playerid, false);
	                }
	                case 2:
					{
					    SetPlayerPos(playerid, 1087.8864,2079.1938,15.3504);
	                 	SetPlayerFacingAngle(playerid, 29.0823);
	                  	SetPlayerInterior(playerid, 0);
	                   	SetPlayerVirtualWorld(playerid, id+10);
	                    SetPlayerTeam(playerid, NO_TEAM);
	                    SetPlayerHealth(playerid, 100);
	                    SetPlayerArmour(playerid, Paintball[id][odaZirh]);
	                    ResetPlayerWeapons(playerid);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][0], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][1], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][2], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][3], 1000);
	                    SetPlayerArmedWeapon(playerid, 0);
	                    //if (Paintball[id][odaDurum] != ODA_BASLADI) TogglePlayerControllable(playerid, false);
					}
					case 3:
					{
					    SetPlayerPos(playerid, 1093.3832,2097.4788,10.8203);
	                 	SetPlayerFacingAngle(playerid, 87.9896);
	                  	SetPlayerInterior(playerid, 0);
	                   	SetPlayerVirtualWorld(playerid, id+10);
	                    SetPlayerTeam(playerid, NO_TEAM);
	                    SetPlayerHealth(playerid, 100);
	                    SetPlayerArmour(playerid, Paintball[id][odaZirh]);
	                    ResetPlayerWeapons(playerid);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][0], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][1], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][2], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][3], 1000);
	                    SetPlayerArmedWeapon(playerid, 0);
	                    //if (Paintball[id][odaDurum] != ODA_BASLADI) TogglePlayerControllable(playerid, false);
					}
					case 4:
					{
					    SetPlayerPos(playerid, 1065.2822,2111.1763,10.8203);
	                 	SetPlayerFacingAngle(playerid, 269.0746);
	                  	SetPlayerInterior(playerid, 0);
	                   	SetPlayerVirtualWorld(playerid, id+10);
	                    SetPlayerTeam(playerid, NO_TEAM);
	                    SetPlayerHealth(playerid, 100);
	                    SetPlayerArmour(playerid, Paintball[id][odaZirh]);
	                    ResetPlayerWeapons(playerid);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][0], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][1], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][2], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][3], 1000);
	                    SetPlayerArmedWeapon(playerid, 0);
	                    //if (Paintball[id][odaDurum] != ODA_BASLADI) TogglePlayerControllable(playerid, false);
					}
				}
	        }
	        case 6:
	        {
	            new rand = random(5);
	            switch (rand)
	            {
	                case 0:
	                {
	                    SetPlayerPos(playerid, 2543.4995,-1304.1349,1025.0703);
	                 	SetPlayerFacingAngle(playerid, 174.1336);
	                  	SetPlayerInterior(playerid, 2);
	                   	SetPlayerVirtualWorld(playerid, id+10);
	                    SetPlayerTeam(playerid, NO_TEAM);
	                    SetPlayerHealth(playerid, 100);
	                    SetPlayerArmour(playerid, Paintball[id][odaZirh]);
	                    ResetPlayerWeapons(playerid);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][0], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][1], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][2], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][3], 1000);
	                    SetPlayerArmedWeapon(playerid, 0);
	                    //if (Paintball[id][odaDurum] != ODA_BASLADI) TogglePlayerControllable(playerid, false);
	                }
	                case 1:
	                {
	                    SetPlayerPos(playerid, 2562.5330,-1296.9476,1031.4219);
	                 	SetPlayerFacingAngle(playerid, 84.4958);
	                  	SetPlayerInterior(playerid, 2);
	                   	SetPlayerVirtualWorld(playerid, id+10);
	                    SetPlayerTeam(playerid, NO_TEAM);
	                    SetPlayerHealth(playerid, 100);
	                    SetPlayerArmour(playerid, Paintball[id][odaZirh]);
	                    ResetPlayerWeapons(playerid);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][0], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][1], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][2], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][3], 1000);
	                    SetPlayerArmedWeapon(playerid, 0);
	                    //if (Paintball[id][odaDurum] != ODA_BASLADI) TogglePlayerControllable(playerid, false);
	                }
	                case 2:
	                {
	                    SetPlayerPos(playerid, 2574.8743,-1301.6804,1037.7734);
	                 	SetPlayerFacingAngle(playerid, 359.2685);
	                  	SetPlayerInterior(playerid, 2);
	                   	SetPlayerVirtualWorld(playerid, id+10);
	                    SetPlayerTeam(playerid, NO_TEAM);
	                    SetPlayerHealth(playerid, 100);
	                    SetPlayerArmour(playerid, Paintball[id][odaZirh]);
	                    ResetPlayerWeapons(playerid);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][0], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][1], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][2], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][3], 1000);
	                    SetPlayerArmedWeapon(playerid, 0);
	                    //if (Paintball[id][odaDurum] != ODA_BASLADI) TogglePlayerControllable(playerid, false);
	                }
	                case 3:
	                {
	                    SetPlayerPos(playerid, 2581.0449,-1285.3281,1044.1250);
	                 	SetPlayerFacingAngle(playerid, 171.9168);
	                  	SetPlayerInterior(playerid, 2);
	                   	SetPlayerVirtualWorld(playerid, id+10);
	                    SetPlayerTeam(playerid, NO_TEAM);
	                    SetPlayerHealth(playerid, 100);
	                    SetPlayerArmour(playerid, Paintball[id][odaZirh]);
	                    ResetPlayerWeapons(playerid);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][0], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][1], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][2], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][3], 1000);
	                    SetPlayerArmedWeapon(playerid, 0);
	                    //if (Paintball[id][odaDurum] != ODA_BASLADI) TogglePlayerControllable(playerid, false);
	                }
	                case 4:
	                {
	                    SetPlayerPos(playerid, 2529.1042,-1286.1699,1054.6406);
	                 	SetPlayerFacingAngle(playerid, 81.9662);
	                  	SetPlayerInterior(playerid, 2);
	                   	SetPlayerVirtualWorld(playerid, id+10);
	                    SetPlayerTeam(playerid, NO_TEAM);
	                    SetPlayerHealth(playerid, 100);
	                    SetPlayerArmour(playerid, Paintball[id][odaZirh]);
	                    ResetPlayerWeapons(playerid);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][0], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][1], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][2], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][3], 1000);
	                    SetPlayerArmedWeapon(playerid, 0);
	                    //if (Paintball[id][odaDurum] != ODA_BASLADI) TogglePlayerControllable(playerid, false);
	                }
				}
	        }
	        case 7:
	        {
	            new rand = random(7);
	            switch (rand)
	            {
	                case 0:
	                {
	                    SetPlayerPos(playerid, 2216.1829,-1149.5088,1025.7969);
	                 	SetPlayerFacingAngle(playerid, 300.7219);
	                  	SetPlayerInterior(playerid, 15);
	                   	SetPlayerVirtualWorld(playerid, id+10);
	                    SetPlayerTeam(playerid, NO_TEAM);
	                    SetPlayerHealth(playerid, 100);
	                    SetPlayerArmour(playerid, Paintball[id][odaZirh]);
	                    ResetPlayerWeapons(playerid);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][0], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][1], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][2], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][3], 1000);
	                    SetPlayerArmedWeapon(playerid, 0);
	                    //if (Paintball[id][odaDurum] != ODA_BASLADI) TogglePlayerControllable(playerid, false);
	                }
	                case 1:
	                {
	                    SetPlayerPos(playerid, 2240.9519,-1193.5115,1029.7969);
	                 	SetPlayerFacingAngle(playerid, 3.6791);
	                  	SetPlayerInterior(playerid, 15);
	                   	SetPlayerVirtualWorld(playerid, id+10);
	                    SetPlayerTeam(playerid, NO_TEAM);
	                    SetPlayerHealth(playerid, 100);
	                    SetPlayerArmour(playerid, Paintball[id][odaZirh]);
	                    ResetPlayerWeapons(playerid);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][0], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][1], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][2], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][3], 1000);
	                    SetPlayerArmedWeapon(playerid, 0);
	                    //if (Paintball[id][odaDurum] != ODA_BASLADI) TogglePlayerControllable(playerid, false);
	                }
	                case 2:
	                {
	                    SetPlayerPos(playerid, 2234.7319,-1159.3888,1029.7969);
	                 	SetPlayerFacingAngle(playerid, 270.6182);
	                  	SetPlayerInterior(playerid, 15);
	                   	SetPlayerVirtualWorld(playerid, id+10);
	                    SetPlayerTeam(playerid, NO_TEAM);
	                    SetPlayerHealth(playerid, 100);
	                    SetPlayerArmour(playerid, Paintball[id][odaZirh]);
	                    ResetPlayerWeapons(playerid);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][0], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][1], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][2], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][3], 1000);
	                    SetPlayerArmedWeapon(playerid, 0);
	                    //if (Paintball[id][odaDurum] != ODA_BASLADI) TogglePlayerControllable(playerid, false);
	                }
	                case 3:
	                {
	                    SetPlayerPos(playerid, 2234.0752,-1170.9261,1029.7969);
	                 	SetPlayerFacingAngle(playerid, 270.6182);
	                  	SetPlayerInterior(playerid, 15);
	                   	SetPlayerVirtualWorld(playerid, id+10);
	                    SetPlayerTeam(playerid, NO_TEAM);
	                    SetPlayerHealth(playerid, 100);
	                    SetPlayerArmour(playerid, Paintball[id][odaZirh]);
	                    ResetPlayerWeapons(playerid);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][0], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][1], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][2], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][3], 1000);
	                    SetPlayerArmedWeapon(playerid, 0);
	                    //if (Paintball[id][odaDurum] != ODA_BASLADI) TogglePlayerControllable(playerid, false);
	                }
	                case 4:
	                {
	                    SetPlayerPos(playerid, 2239.8977,-1188.0165,1033.7969);
	                 	SetPlayerFacingAngle(playerid, 258.4217);
	                  	SetPlayerInterior(playerid, 15);
	                   	SetPlayerVirtualWorld(playerid, id+10);
	                    SetPlayerTeam(playerid, NO_TEAM);
	                    SetPlayerHealth(playerid, 100);
	                    SetPlayerArmour(playerid, Paintball[id][odaZirh]);
	                    ResetPlayerWeapons(playerid);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][0], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][1], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][2], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][3], 1000);
	                    SetPlayerArmedWeapon(playerid, 0);
	                    //if (Paintball[id][odaDurum] != ODA_BASLADI) TogglePlayerControllable(playerid, false);
	                }
	                case 5:
	                {
	                    SetPlayerPos(playerid, 2225.8901,-1182.4353,1029.7969);
	                 	SetPlayerFacingAngle(playerid, 166.6141);
	                  	SetPlayerInterior(playerid, 15);
	                   	SetPlayerVirtualWorld(playerid, id+10);
	                    SetPlayerTeam(playerid, NO_TEAM);
	                    SetPlayerHealth(playerid, 100);
	                    SetPlayerArmour(playerid, Paintball[id][odaZirh]);
	                    ResetPlayerWeapons(playerid);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][0], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][1], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][2], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][3], 1000);
	                    SetPlayerArmedWeapon(playerid, 0);
	                    //if (Paintball[id][odaDurum] != ODA_BASLADI) TogglePlayerControllable(playerid, false);
	                }
	                case 6:
	                {
	                    SetPlayerPos(playerid, 2186.6885,-1182.1509,1033.7969);
	                 	SetPlayerFacingAngle(playerid, 201.6845);
	                  	SetPlayerInterior(playerid, 15);
	                   	SetPlayerVirtualWorld(playerid, id+10);
	                    SetPlayerTeam(playerid, NO_TEAM);
	                    SetPlayerHealth(playerid, 100);
	                    SetPlayerArmour(playerid, Paintball[id][odaZirh]);
	                    ResetPlayerWeapons(playerid);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][0], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][1], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][2], 1000);
	                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][3], 1000);
	                    SetPlayerArmedWeapon(playerid, 0);
	                    //if (Paintball[id][odaDurum] != ODA_BASLADI) TogglePlayerControllable(playerid, false);
	                }
				}
	        }
	    }
	}
	else
	{
	    switch (Paintball[id][odaArena])
	    {
	        case 1:
	        {
	            if (pbTakim[playerid] == 1)
	            {
	                SetPlayerPos(playerid, 1059.3263,2081.4861,10.8203);
                	SetPlayerFacingAngle(playerid, 322.0627);
                	SetPlayerInterior(playerid, 0);
                	SetPlayerVirtualWorld(playerid, id+10);
                 	SetPlayerTeam(playerid, 10);
                 	SetPlayerHealth(playerid, 100);
                  	SetPlayerArmour(playerid, Paintball[id][odaZirh]);
                  	ResetPlayerWeapons(playerid);
                   	GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][0], 1000);
                   	GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][1], 1000);
                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][2], 1000);
                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][3], 1000);
                    SetPlayerArmedWeapon(playerid, 0);
                    //if (Paintball[id][odaDurum] != ODA_BASLADI) TogglePlayerControllable(playerid, false);
	            }
	            else
	            {
	                SetPlayerPos(playerid, 1068.1041,2130.2908,10.8203);
                	SetPlayerFacingAngle(playerid, 176.9880);
                	SetPlayerInterior(playerid, 0);
                	SetPlayerVirtualWorld(playerid, id+10);
                 	SetPlayerTeam(playerid, 20);
                 	SetPlayerHealth(playerid, 100);
                  	SetPlayerArmour(playerid, Paintball[id][odaZirh]);
                  	ResetPlayerWeapons(playerid);
                   	GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][0], 1000);
                   	GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][1], 1000);
                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][2], 1000);
                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][3], 1000);
                    SetPlayerArmedWeapon(playerid, 0);
                    //if (Paintball[id][odaDurum] != ODA_BASLADI) TogglePlayerControllable(playerid, false);
	            }
	        }
	        case 2:
	        {
	            if (pbTakim[playerid] == 1)
	            {
	                SetPlayerPos(playerid, 1303.3241,0.8544,1001.0255);
                	SetPlayerFacingAngle(playerid, 131.1362);
                	SetPlayerInterior(playerid, 18);
                	SetPlayerVirtualWorld(playerid, id+10);
                 	SetPlayerTeam(playerid, 10);
                 	SetPlayerHealth(playerid, 100);
                  	SetPlayerArmour(playerid, Paintball[id][odaZirh]);
                  	ResetPlayerWeapons(playerid);
                   	GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][0], 1000);
                   	GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][1], 1000);
                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][2], 1000);
                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][3], 1000);
                    SetPlayerArmedWeapon(playerid, 0);
                    //if (Paintball[id][odaDurum] != ODA_BASLADI) TogglePlayerControllable(playerid, false);
	            }
	            else
	            {
	                SetPlayerPos(playerid, 1250.3260,-47.5597,1001.0268);
                	SetPlayerFacingAngle(playerid, 304.2428);
                	SetPlayerInterior(playerid, 18);
                	SetPlayerVirtualWorld(playerid, id+10);
                 	SetPlayerTeam(playerid, 20);
                 	SetPlayerHealth(playerid, 100);
                  	SetPlayerArmour(playerid, Paintball[id][odaZirh]);
                  	ResetPlayerWeapons(playerid);
                   	GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][0], 1000);
                   	GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][1], 1000);
                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][2], 1000);
                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][3], 1000);
                    SetPlayerArmedWeapon(playerid, 0);
                    //if (Paintball[id][odaDurum] != ODA_BASLADI) TogglePlayerControllable(playerid, false);
	            }
	        }
	        case 3:
	        {
	            if (pbTakim[playerid] == 1)
	            {
	                SetPlayerPos(playerid, -975.1069,1061.2255,1345.6719);
                	SetPlayerFacingAngle(playerid, 93.5594);
                	SetPlayerInterior(playerid, 10);
                	SetPlayerVirtualWorld(playerid, id+10);
                 	SetPlayerTeam(playerid, 10);
                 	SetPlayerHealth(playerid, 100);
                  	SetPlayerArmour(playerid, Paintball[id][odaZirh]);
                  	ResetPlayerWeapons(playerid);
                   	GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][0], 1000);
                   	GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][1], 1000);
                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][2], 1000);
                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][3], 1000);
                    SetPlayerArmedWeapon(playerid, 0);
                    //if (Paintball[id][odaDurum] != ODA_BASLADI) TogglePlayerControllable(playerid, false);
	            }
	            else
	            {
	                SetPlayerPos(playerid, -1130.9933,1057.7678,1346.4141);
                	SetPlayerFacingAngle(playerid, 269.3412);
                	SetPlayerInterior(playerid, 10);
                	SetPlayerVirtualWorld(playerid, id+10);
                 	SetPlayerTeam(playerid, 20);
                 	SetPlayerHealth(playerid, 100);
                  	SetPlayerArmour(playerid, Paintball[id][odaZirh]);
                  	ResetPlayerWeapons(playerid);
                   	GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][0], 1000);
                   	GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][1], 1000);
                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][2], 1000);
                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][3], 1000);
                    SetPlayerArmedWeapon(playerid, 0);
                    //if (Paintball[id][odaDurum] != ODA_BASLADI) TogglePlayerControllable(playerid, false);
	            }
	        }
	        case 4:
	        {
	            if (pbTakim[playerid] == 1)
	            {
	                SetPlayerPos(playerid, 239.0441,143.9385,1003.0234);
                	SetPlayerFacingAngle(playerid, 357.3882);
                	SetPlayerInterior(playerid, 3);
                	SetPlayerVirtualWorld(playerid, id+10);
                 	SetPlayerTeam(playerid, 10);
                 	SetPlayerHealth(playerid, 100);
                  	SetPlayerArmour(playerid, Paintball[id][odaZirh]);
                  	ResetPlayerWeapons(playerid);
                   	GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][0], 1000);
                   	GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][1], 1000);
                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][2], 1000);
                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][3], 1000);
                    SetPlayerArmedWeapon(playerid, 0);
                    //if (Paintball[id][odaDurum] != ODA_BASLADI) TogglePlayerControllable(playerid, false);
	            }
	            else
	            {
	                SetPlayerPos(playerid, 300.0846,183.6274,1007.1719);
                	SetPlayerFacingAngle(playerid, 95.4391);
                	SetPlayerInterior(playerid, 3);
                	SetPlayerVirtualWorld(playerid, id+10);
                 	SetPlayerTeam(playerid, 20);
                 	SetPlayerHealth(playerid, 100);
                  	SetPlayerArmour(playerid, Paintball[id][odaZirh]);
                  	ResetPlayerWeapons(playerid);
                   	GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][0], 1000);
                   	GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][1], 1000);
                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][2], 1000);
                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][3], 1000);
                    SetPlayerArmedWeapon(playerid, 0);
                    //if (Paintball[id][odaDurum] != ODA_BASLADI) TogglePlayerControllable(playerid, false);
	            }
	        }
	        case 5:
	        {
	            if (pbTakim[playerid] == 1)
	            {
	                SetPlayerPos(playerid, 1058.8458,2081.5845,10.8203);
                	SetPlayerFacingAngle(playerid, 332.0316);
                	SetPlayerInterior(playerid, 0);
                	SetPlayerVirtualWorld(playerid, id+10);
                 	SetPlayerTeam(playerid, 10);
                 	SetPlayerHealth(playerid, 100);
                  	SetPlayerArmour(playerid, Paintball[id][odaZirh]);
                  	ResetPlayerWeapons(playerid);
                   	GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][0], 1000);
                   	GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][1], 1000);
                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][2], 1000);
                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][3], 1000);
                    SetPlayerArmedWeapon(playerid, 0);
                    //if (Paintball[id][odaDurum] != ODA_BASLADI) TogglePlayerControllable(playerid, false);
	            }
	            else
	            {
	                SetPlayerPos(playerid, 1069.3534,2129.8914,10.8203);
                	SetPlayerFacingAngle(playerid, 172.2302);
                	SetPlayerInterior(playerid, 0);
                	SetPlayerVirtualWorld(playerid, id+10);
                 	SetPlayerTeam(playerid, 20);
                 	SetPlayerHealth(playerid, 100);
                  	SetPlayerArmour(playerid, Paintball[id][odaZirh]);
                  	ResetPlayerWeapons(playerid);
                   	GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][0], 1000);
                   	GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][1], 1000);
                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][2], 1000);
                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][3], 1000);
                    SetPlayerArmedWeapon(playerid, 0);
                    //if (Paintball[id][odaDurum] != ODA_BASLADI) TogglePlayerControllable(playerid, false);
	            }
	        }
	        case 6:
	        {
	            if (pbTakim[playerid] == 1)
	            {
	                SetPlayerPos(playerid, 2543.4995,-1304.1349,1025.0703);
                	SetPlayerFacingAngle(playerid, 174.1336);
                	SetPlayerInterior(playerid, 2);
                	SetPlayerVirtualWorld(playerid, id+10);
                 	SetPlayerTeam(playerid, 10);
                 	SetPlayerHealth(playerid, 100);
                  	SetPlayerArmour(playerid, Paintball[id][odaZirh]);
                  	ResetPlayerWeapons(playerid);
                   	GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][0], 1000);
                   	GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][1], 1000);
                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][2], 1000);
                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][3], 1000);
                    SetPlayerArmedWeapon(playerid, 0);
                    //if (Paintball[id][odaDurum] != ODA_BASLADI) TogglePlayerControllable(playerid, false);
	            }
	            else
	            {
	                SetPlayerPos(playerid, 2562.5330,-1296.9476,1031.4219);
                	SetPlayerFacingAngle(playerid, 84.4958);
                	SetPlayerInterior(playerid, 2);
                	SetPlayerVirtualWorld(playerid, id+10);
                 	SetPlayerTeam(playerid, 20);
                 	SetPlayerHealth(playerid, 100);
                  	SetPlayerArmour(playerid, Paintball[id][odaZirh]);
                  	ResetPlayerWeapons(playerid);
                   	GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][0], 1000);
                   	GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][1], 1000);
                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][2], 1000);
                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][3], 1000);
                    SetPlayerArmedWeapon(playerid, 0);
                    //if (Paintball[id][odaDurum] != ODA_BASLADI) TogglePlayerControllable(playerid, false);
	            }
	        }
	        case 7:
	        {
	            if (pbTakim[playerid] == 1)
	            {
	                SetPlayerPos(playerid, 2216.1829,-1149.5088,1025.7969);
                	SetPlayerFacingAngle(playerid, 300.7219);
                	SetPlayerInterior(playerid, 15);
                	SetPlayerVirtualWorld(playerid, id+10);
                 	SetPlayerTeam(playerid, 10);
                 	SetPlayerHealth(playerid, 100);
                  	SetPlayerArmour(playerid, Paintball[id][odaZirh]);
                  	ResetPlayerWeapons(playerid);
                   	GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][0], 1000);
                   	GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][1], 1000);
                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][2], 1000);
                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][3], 1000);
                    SetPlayerArmedWeapon(playerid, 0);
                    //if (Paintball[id][odaDurum] != ODA_BASLADI) TogglePlayerControllable(playerid, false);
	            }
	            else
	            {
	                SetPlayerPos(playerid, 2240.9519,-1193.5115,1029.7969);
                	SetPlayerFacingAngle(playerid, 3.6791);
                	SetPlayerInterior(playerid, 15);
                	SetPlayerVirtualWorld(playerid, id+10);
                 	SetPlayerTeam(playerid, 20);
                 	SetPlayerHealth(playerid, 100);
                  	SetPlayerArmour(playerid, Paintball[id][odaZirh]);
                  	ResetPlayerWeapons(playerid);
                   	GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][0], 1000);
                   	GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][1], 1000);
                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][2], 1000);
                    GivePlayerWeapon(playerid, Paintball[id][odaSilahlar][3], 1000);
                    SetPlayerArmedWeapon(playerid, 0);
                    //if (Paintball[id][odaDurum] != ODA_BASLADI) TogglePlayerControllable(playerid, false);
	            }
	        }
	    }
	}
	return 1;
}
TimeConvert(seconds, tarz=0, saat=0)
{
	new tmp[16];
 	new minutes = floatround(seconds/60);
	seconds -= minutes*60;
	if (minutes >= 60)
	{
	    saat++;
	}
  	if (tarz == 1)
  	{
   		format(tmp, sizeof(tmp), "%d:%02d", minutes, seconds);
   	} else {
   		format(tmp, sizeof(tmp), "%02d:%02d:%02d", saat, minutes, seconds);
   	}
   	return tmp;
}
KomutEkle(ad[], tanim[], katagori, olusum = -1)
{
	for (new i = 0; i != MAX_YARDIM_KOMUTLARI; i ++)
	{
 		if (!Komutlar[i][komutVarmi])
		{
		    Komutlar[i][komutVarmi] = true;
            Komutlar[i][komutKatagori] = katagori;
            Komutlar[i][komutOlusum] = olusum;

           	format(Komutlar[i][komutAd], 24, ad);
           	format(Komutlar[i][komutTanim], 256, tanim);

			return i;
		}
	}
	return -1;
}
KomutYukle()
{
	// -------------------------- Genel Komutlar ------------------------ //
	KomutEkle("/ayarlar", " {e0ddaf}Hesap ayarlarýna eriþme.", 0);
	KomutEkle("/mulklerim", " {e0ddaf}Karakterinize baðlý iþyerleri ve evleri listeler.", 0);
	KomutEkle("/karakter", " {e0ddaf}Karakterinizin bilgilerini görme.", 0);
	KomutEkle("/id", " {e0ddaf}Oyun adýna göre ID sorgulama.", 0);
	KomutEkle("/rapor", " {e0ddaf}Admin ve Helper ekibine sorunlarýnýzý iletebilirsiniz.", 0);
	KomutEkle("/admins", " {e0ddaf}Çevrimiçi adminleri listeler.", 0);
	KomutEkle("/helpers", " {e0ddaf}Çevrimiçi helperleri listeler.", 0);
	KomutEkle("/animasyonlar", " {e0ddaf}Sunucuya eklenmiþ animasyonlarý listeler.", 0);
	KomutEkle("/dinle", " {e0ddaf}Dinleyebileceðiniz yayýn organlarýný listeler.", 0);
	KomutEkle("/cpsifirla", " {e0ddaf}Checkpointlerinizi sýfýrlar.", 0);
	KomutEkle("/kabulet", " {e0ddaf}Gelen teklifleri kabul etme.", 0);
	KomutEkle("/birlikler", " {e0ddaf}Birlik sýralamasýný gösterir.", 0);
	KomutEkle("/birlikara", " {e0ddaf}Belirli isim aralýðýnda birlikleri listelersiniz.", 0);
	KomutEkle("/hud", " {e0ddaf}Ekrandaki göstergeleri kapatýr/açar.", 0);
	KomutEkle("/anahtarver", " {e0ddaf}Ev/Araç anahtarý verme.", 0);
	KomutEkle("/silahlarim", " {e0ddaf}Silah menüsünü açar. ", 0);
	KomutEkle("/aractanat", " {e0ddaf}Herhangi bir oyuncuyu aracýnýzdan atmayý saðlar.", 0);
	KomutEkle("/aracaat", " {e0ddaf}Kelepçelenmiþ veya elleri baðlanmýþ kiþiyi yakýnýnýzdaki araca atmayý saðlar.", 0);
    // -------------------------- Chat & Roleplay Komutlarý    ------------------------ //
	KomutEkle("/chatttemizle", " {e0ddaf}Chat ekranýný temizler.", 1);
	KomutEkle("/me", " {e0ddaf}Etkileþim komutu.", 1);
	KomutEkle("/do", " {e0ddaf}Etkileþim komutu.", 1);
	KomutEkle("/s(hout)", " {e0ddaf}Baðýrma.", 1);
	KomutEkle("/b", " {e0ddaf}Oyun dýþý kanal.", 1);
	KomutEkle("/pm", " {e0ddaf}Özel mesaj. (Private)", 1);
	KomutEkle("/p", " {e0ddaf}Son PM attýðýnýz kiþiye özel mesaj. (Private)", 1);
	KomutEkle("/w(hisper)", " {e0ddaf}Oyuncuya fýsýldama.", 1);
	KomutEkle("/c", " {e0ddaf}Sessiz konuþma.", 1);
	KomutEkle("/ame", " {e0ddaf}Etkileþim komutu (Karakter üstünde).", 1);
	KomutEkle("/ado", " {e0ddaf}Etkileþim komutu (Karakter üstünde).", 1);
    KomutEkle("/paraver", " {e0ddaf}Kiþiye para aktarma.", 1);
    KomutEkle("/dene", " {e0ddaf}Baþarýlý/Baþarýsýz olma þansý.", 1);
    KomutEkle("/tokalas", " {e0ddaf}Belirlediðiniz kiþiye tokalaþma isteði yollar.", 1);
    KomutEkle("/kimlikgoster", " {e0ddaf}Kimlik bilgilerinizi gösterme.", 1);
    KomutEkle("/lisansgoster", " {e0ddaf}Ehliyet/ruhsat durumunuzu gösterme.", 1);
    KomutEkle("/kapi", " {e0ddaf}Kapýlarý/gateleri açma.", 1);
    // -------------------------- TELEFON  ------------------------ //
    KomutEkle("/telefon", " {e0ddaf}Telefon menüsünü açar.", 3);
    KomutEkle("/ara", " {e0ddaf}Numara çevirme.", 3);
    KomutEkle("/sms", " {e0ddaf}SMS Gönderme.", 3);
    KomutEkle("/cagrikabul", " {e0ddaf}Gelen aramayý cevaplama.", 3);
    KomutEkle("/cagrikapat", " {e0ddaf}Aramayý sonlandýrma/Reddetme.", 3);
	// --------------------- Araç -------------------------------
    KomutEkle("/benzinkutusu", " {e0ddaf}Benzin kutusunu kullanma.", 4);
    KomutEkle("/motor", " {e0ddaf}Motoru açma/kapatma.", 4);
    KomutEkle("/kilit", " {e0ddaf}Kilidi açma/kapatma.", 4);
    KomutEkle("/bagaj", " {e0ddaf}Bagajý açma.", 4);
    KomutEkle("/araclarim", " {e0ddaf}Tüm araçlarýnýzý listeleme.", 4);
    KomutEkle("/arac", " {e0ddaf}Araç kontrol menüsü.", 4);
    KomutEkle("/acam", " {e0ddaf}Camlarý açma/kapatma.", 4);
    KomutEkle("/farlar", " {e0ddaf}Farlarý açma/kapatma.", 4);
    KomutEkle("/kaput", " {e0ddaf}Kaputu açma/kapatma.", 4);
    KomutEkle("/aractanat", " {e0ddaf} Herhangi bir oyuncuyu aracýnýzdan atmayý saðlar.", 4);
    // -------------------------- UYUÞTURUCU  ------------------------ //
	KomutEkle("/uyusturucu [kullan]", " {e0ddaf}Uyuþturucu kullanma.", 5);
	KomutEkle("/uyusturucu [ver]", " {e0ddaf}Belirlediðiniz kiþiye uyuþturucu verirsiniz.", 5);
	KomutEkle("/uyusturucu [sat]", " {e0ddaf}Belirlediðiniz kiþiye uyuþturucu satarsýnýz.", 5);
	KomutEkle("/uyusturucu [ek/topla]", " {e0ddaf}Tohum ekebilirsiniz ve toplayabilirsiniz.", 5);
	KomutEkle("/uyusturucu [bilgi]", " {e0ddaf}Uyuþturucu istatistiklerinizi gösterir.", 5);

    // -------------------------- BÝRLÝK  ------------------------ //
    KomutEkle("/birlikler", " {e0ddaf}Birlik sýralamasýný gösterir.", 6);
    KomutEkle("/birlikara", " {e0ddaf}Belirli isim aralýðýnda birlikleri listelersiniz.", 6);
    KomutEkle("/f(ac)", " {e0ddaf}Birlik içi sohbet.", 6);
    KomutEkle("/graffiti", " {e0ddaf}Graffiti onaylý birlikler için graffiti komutu.", 6);
    KomutEkle("/birlik", " {e0ddaf}Birlik menüsünü açar.", 6);

	// ------------------------ MESLEKLER -------------------------- //

	KomutEkle("/meslekler", " {e0ddaf}Meslekler hakkýnda yardým alma.", 7);

    /// -------------------------- POLÝS  ------------------------ //
	KomutEkle("/taser", " {e0ddaf}Elektroþok cihazý.", 6, BIRLIK_LSPD);
    KomutEkle("/kelepce", " {e0ddaf}Kiþiyi kelepçeler.", 6, BIRLIK_LSPD);
    KomutEkle("/kelepcecikar", " {e0ddaf}Kiþinin kelepçesini çözer.", 6, BIRLIK_LSPD);
    KomutEkle("/surukle", " {e0ddaf}Kiþiyi sürüklersiniz.", 6, BIRLIK_LSPD);
    KomutEkle("/mdc", " {e0ddaf}Mobil Bilgi Sistemini açar.", 6, BIRLIK_LSPD);
    KomutEkle("/hapseat", " {e0ddaf}Hapse atma.", 6, BIRLIK_LSPD);
    KomutEkle("/t", " {e0ddaf}Telsiz iletiþimi.", 6, BIRLIK_LSPD);
    KomutEkle("/d(ept)", " {e0ddaf}Departman telsizi.", 6, BIRLIK_LSPD);
    KomutEkle("/yt(yakýn telsiz)", " {e0ddaf}Yakýn telsiz.", 6, BIRLIK_LSPD);
    KomutEkle("/elkoy", " {e0ddaf}Uyuþturuculara ve silahlara el koyma.", 6, BIRLIK_LSPD);
    KomutEkle("/objekoy", " {e0ddaf}Obje koyma. (barikat, çivi vs.)", 6, BIRLIK_LSPD);
    KomutEkle("/objesil", " {e0ddaf}Obje silme.",6, BIRLIK_LSPD);
    KomutEkle("/objeduzenle", " {e0ddaf}Obje düzenleme.",6, BIRLIK_LSPD);
    KomutEkle("/aracibagla", " {e0ddaf}Çekilmiþ aracý baðlama.", 6, BIRLIK_LSPD);
    KomutEkle("/kapiyikir", " {e0ddaf}Ev/iþyeri kapýsý kýrma.", 6, BIRLIK_LSPD);
    KomutEkle("/siren", " {e0ddaf}Tepe sireni koyma.", 6, BIRLIK_LSPD);
    KomutEkle("/flasor", " {e0ddaf}Farlarý hýzlý açýp kapama.", 6, BIRLIK_LSPD);
    KomutEkle("/callsign", " {e0ddaf}Birim kodu koyma.", 6, BIRLIK_LSPD);
    KomutEkle("/rozetgoster", " {e0ddaf}Rozet gösterme komutu.", 6, BIRLIK_LSPD);
    KomutEkle("/destekistek", " {e0ddaf}Birimlere sinyal göndererek destek isteme.", 6, BIRLIK_LSPD);
    KomutEkle("/bagaj", " {e0ddaf}Birim araçlarýnda silah deposuna ulaþma.", 6, BIRLIK_LSPD);
    KomutEkle("/yereyatir", " {e0ddaf}Kiþiyi yere yatýrma.", 6, BIRLIK_LSPD);
	/// -------------------------- Yayýn Ajansý  ------------------------ //
	KomutEkle("/yayin", " {e0ddaf}Yayýndan konuþmanýzý saðlar.", 6, BIRLIK_HABER);
	KomutEkle("/yayinmuzik", " {e0ddaf}Yayýna müzik ekleme.", 6, BIRLIK_HABER);
	KomutEkle("/yayindavet", " {e0ddaf}Yayýna konuk alma/çýkarma.", 6, BIRLIK_HABER);
    KomutEkle("/rozetgoster", " {e0ddaf}Basýn kartýný gösterme komutu.", 6, BIRLIK_HABER);
    /// -------------------------- LSMD  ------------------------ //
	KomutEkle("/r(adio)", " {e0ddaf}Telsiz iletiþimi.", 6, BIRLIK_LSMD);
    KomutEkle("/d(ept)", " {e0ddaf}Departman telsizi.", 6, BIRLIK_LSMD);
    KomutEkle("/yaracaat", " {e0ddaf}Yaralýyý araca yükleme.", 6, BIRLIK_LSMD);
    KomutEkle("/yteslim", " {e0ddaf}Araca yüklenen yaralýyý teslim etme.", 6, BIRLIK_LSMD);
    KomutEkle("/rozetgoster", " {e0ddaf}Rozet gösterme komutu.", 6, BIRLIK_LSMD);
    KomutEkle("/megafon", " {e0ddaf}Araç megafonu/el megafonu.", 6, BIRLIK_LSMD);
    KomutEkle("/ytasi", " {e0ddaf}Kiþiyi sedye ile sürüklersiniz.", 6, BIRLIK_LSMD);
    /// -------------------------- Yapýmcýlar  ------------------------ //
    KomutEkle("2021", " Yapýmcýlar", 9);
    KomutEkle("Sawyer", " {e0ddaf}First Party Developer", 9);
    KomutEkle("RootCause", " {e0ddaf}Supporter", 9);
    KomutEkle("Destekte bulunan", " adý geçmeyen herkese teþekkürler.", 9);
	return 1;
}

stock GuvenliBolgedeyse(playerid)
{
	for (new i; i < sizeof(GuvenliBolge); ++i)
	{
		if (IsPlayerInDynamicArea(playerid, GuvenliBolge[i][Rectangle])) return 1;
	}
	return 0;
}

stock LinkVehicleToInteriorEx(vehicleid, interiorid)
{
	CarInterior[vehicleid] = interiorid;
	return LinkVehicleToInterior(vehicleid, interiorid);
}

static stock GetPosOffset(Float: p_p_x, Float: p_p_y, Float: p_p_z, Float: p_c_x, Float: p_c_y, Float: p_c_z, &Float:p_n_x, &Float:p_n_y, &Float: p_n_z)
{
	p_n_x = (p_p_x > p_c_x) ? (p_p_x - p_c_x) : (p_c_x - p_p_x);
	p_n_y = (p_p_y > p_c_y) ? (p_p_y - p_c_y) : (p_c_y - p_p_y);
	p_n_z = (p_p_z > p_c_z) ? (p_p_z - p_c_z) : (p_c_z - p_p_z);
	return true;
}
stock IsVehicleUpgradeCompatible(model,componentid) // by AirKite
{
	switch (model)
	{
		case 400:
		{
			switch (componentid)
			{
				case 1008: { return 1; }
				case 1009: { return 1; }
				case 1010: { return 1; }
				case 1013: { return 1; }
				case 1018: { return 1; }
				case 1019: { return 1; }
				case 1020: { return 1; }
				case 1021: { return 1; }
				case 1024: { return 1; }
				case 1025: { return 1; }
				case 1073: { return 1; }
				case 1074: { return 1; }
				case 1075: { return 1; }
				case 1076: { return 1; }
				case 1077: { return 1; }
				case 1078: { return 1; }
				case 1079: { return 1; }
				case 1080: { return 1; }
				case 1081: { return 1; }
				case 1082: { return 1; }
				case 1083: { return 1; }
				case 1084: { return 1; }
				case 1085: { return 1; }
				case 1087: { return 1; }
				case 1096: { return 1; }
				case 1097: { return 1; }
				case 1098: { return 1; }
			}
		}
		case 401:
		{
			switch (componentid)
			{
				case 1001: { return 1; }
				case 1003: { return 1; }
				case 1004: { return 1; }
				case 1005: { return 1; }
				case 1006: { return 1; }
				case 1007: { return 1; }
				case 1008: { return 1; }
				case 1009: { return 1; }
				case 1010: { return 1; }
				case 1013: { return 1; }
				case 1017: { return 1; }
				case 1019: { return 1; }
				case 1020: { return 1; }
				case 1025: { return 1; }
				case 1073: { return 1; }
				case 1074: { return 1; }
				case 1075: { return 1; }
				case 1076: { return 1; }
				case 1077: { return 1; }
				case 1078: { return 1; }
				case 1079: { return 1; }
				case 1080: { return 1; }
				case 1081: { return 1; }
				case 1082: { return 1; }
				case 1083: { return 1; }
				case 1084: { return 1; }
				case 1085: { return 1; }
				case 1087: { return 1; }
				case 1096: { return 1; }
				case 1097: { return 1; }
				case 1098: { return 1; }
				case 1142: { return 1; }
				case 1143: { return 1; }
				case 1144: { return 1; }
			}
		}
		case 404:
		{
			switch (componentid)
			{
				case 1000: { return 1; }
				case 1002: { return 1; }
				case 1007: { return 1; }
				case 1008: { return 1; }
				case 1009: { return 1; }
				case 1010: { return 1; }
				case 1013: { return 1; }
				case 1016: { return 1; }
				case 1017: { return 1; }
				case 1019: { return 1; }
				case 1020: { return 1; }
				case 1021: { return 1; }
				case 1025: { return 1; }
				case 1073: { return 1; }
				case 1074: { return 1; }
				case 1075: { return 1; }
				case 1076: { return 1; }
				case 1077: { return 1; }
				case 1078: { return 1; }
				case 1079: { return 1; }
				case 1080: { return 1; }
				case 1081: { return 1; }
				case 1082: { return 1; }
				case 1083: { return 1; }
				case 1084: { return 1; }
				case 1085: { return 1; }
				case 1087: { return 1; }
				case 1096: { return 1; }
				case 1097: { return 1; }
				case 1098: { return 1; }
			}
		}
		case 405:
		{
			switch (componentid)
			{
				case 1000: { return 1; }
				case 1001: { return 1; }
				case 1008: { return 1; }
				case 1009: { return 1; }
				case 1010: { return 1; }
				case 1014: { return 1; }
				case 1018: { return 1; }
				case 1019: { return 1; }
				case 1020: { return 1; }
				case 1021: { return 1; }
				case 1023: { return 1; }
				case 1025: { return 1; }
				case 1073: { return 1; }
				case 1074: { return 1; }
				case 1075: { return 1; }
				case 1076: { return 1; }
				case 1077: { return 1; }
				case 1078: { return 1; }
				case 1079: { return 1; }
				case 1080: { return 1; }
				case 1081: { return 1; }
				case 1082: { return 1; }
				case 1083: { return 1; }
				case 1084: { return 1; }
				case 1085: { return 1; }
				case 1087: { return 1; }
				case 1096: { return 1; }
				case 1097: { return 1; }
				case 1098: { return 1; }
			}
		}
		case 410:
		{
			switch (componentid)
			{
				case 1001: { return 1; }
				case 1003: { return 1; }
				case 1007: { return 1; }
				case 1008: { return 1; }
				case 1009: { return 1; }
				case 1010: { return 1; }
				case 1013: { return 1; }
				case 1017: { return 1; }
				case 1019: { return 1; }
				case 1020: { return 1; }
				case 1021: { return 1; }
				case 1023: { return 1; }
				case 1024: { return 1; }
				case 1025: { return 1; }
				case 1073: { return 1; }
				case 1074: { return 1; }
				case 1075: { return 1; }
				case 1076: { return 1; }
				case 1077: { return 1; }
				case 1078: { return 1; }
				case 1079: { return 1; }
				case 1080: { return 1; }
				case 1081: { return 1; }
				case 1082: { return 1; }
				case 1083: { return 1; }
				case 1084: { return 1; }
				case 1085: { return 1; }
				case 1087: { return 1; }
				case 1096: { return 1; }
				case 1097: { return 1; }
				case 1098: { return 1; }
			}
		}
		case 415:
		{
			switch (componentid)
			{
				case 1001: { return 1; }
				case 1003: { return 1; }
				case 1007: { return 1; }
				case 1008: { return 1; }
				case 1009: { return 1; }
				case 1010: { return 1; }
				case 1017: { return 1; }
				case 1018: { return 1; }
				case 1019: { return 1; }
				case 1023: { return 1; }
				case 1025: { return 1; }
				case 1073: { return 1; }
				case 1074: { return 1; }
				case 1075: { return 1; }
				case 1076: { return 1; }
				case 1077: { return 1; }
				case 1078: { return 1; }
				case 1079: { return 1; }
				case 1080: { return 1; }
				case 1081: { return 1; }
				case 1082: { return 1; }
				case 1083: { return 1; }
				case 1084: { return 1; }
				case 1085: { return 1; }
				case 1087: { return 1; }
				case 1096: { return 1; }
				case 1097: { return 1; }
				case 1098: { return 1; }
			}
		}
		case 418:
		{
			switch (componentid)
			{
				case 1002: { return 1; }
				case 1006: { return 1; }
				case 1008: { return 1; }
				case 1009: { return 1; }
				case 1010: { return 1; }
				case 1016: { return 1; }
				case 1020: { return 1; }
				case 1021: { return 1; }
				case 1025: { return 1; }
				case 1073: { return 1; }
				case 1074: { return 1; }
				case 1075: { return 1; }
				case 1076: { return 1; }
				case 1077: { return 1; }
				case 1078: { return 1; }
				case 1079: { return 1; }
				case 1080: { return 1; }
				case 1081: { return 1; }
				case 1082: { return 1; }
				case 1083: { return 1; }
				case 1084: { return 1; }
				case 1085: { return 1; }
				case 1087: { return 1; }
				case 1096: { return 1; }
				case 1097: { return 1; }
				case 1098: { return 1; }
			}
		}
		case 420:
		{
			switch (componentid)
			{
				case 1001: { return 1; }
				case 1003: { return 1; }
				case 1004: { return 1; }
				case 1005: { return 1; }
				case 1008: { return 1; }
				case 1009: { return 1; }
				case 1010: { return 1; }
				case 1019: { return 1; }
				case 1021: { return 1; }
				case 1025: { return 1; }
				case 1073: { return 1; }
				case 1074: { return 1; }
				case 1075: { return 1; }
				case 1076: { return 1; }
				case 1077: { return 1; }
				case 1078: { return 1; }
				case 1079: { return 1; }
				case 1080: { return 1; }
				case 1081: { return 1; }
				case 1082: { return 1; }
				case 1083: { return 1; }
				case 1084: { return 1; }
				case 1085: { return 1; }
				case 1087: { return 1; }
				case 1096: { return 1; }
				case 1097: { return 1; }
				case 1098: { return 1; }
			}
		}
		case 421:
		{
			switch (componentid)
			{
				case 1000: { return 1; }
				case 1008: { return 1; }
				case 1009: { return 1; }
				case 1010: { return 1; }
				case 1014: { return 1; }
				case 1016: { return 1; }
				case 1018: { return 1; }
				case 1019: { return 1; }
				case 1020: { return 1; }
				case 1021: { return 1; }
				case 1023: { return 1; }
				case 1025: { return 1; }
				case 1073: { return 1; }
				case 1074: { return 1; }
				case 1075: { return 1; }
				case 1076: { return 1; }
				case 1077: { return 1; }
				case 1078: { return 1; }
				case 1079: { return 1; }
				case 1080: { return 1; }
				case 1081: { return 1; }
				case 1082: { return 1; }
				case 1083: { return 1; }
				case 1084: { return 1; }
				case 1085: { return 1; }
				case 1087: { return 1; }
				case 1096: { return 1; }
				case 1097: { return 1; }
				case 1098: { return 1; }
			}
		}
		case 422:
		{
			switch (componentid)
			{
				case 1007: { return 1; }
				case 1008: { return 1; }
				case 1009: { return 1; }
				case 1010: { return 1; }
				case 1013: { return 1; }
				case 1017: { return 1; }
				case 1019: { return 1; }
				case 1020: { return 1; }
				case 1021: { return 1; }
				case 1025: { return 1; }
				case 1073: { return 1; }
				case 1074: { return 1; }
				case 1075: { return 1; }
				case 1076: { return 1; }
				case 1077: { return 1; }
				case 1078: { return 1; }
				case 1079: { return 1; }
				case 1080: { return 1; }
				case 1081: { return 1; }
				case 1082: { return 1; }
				case 1083: { return 1; }
				case 1084: { return 1; }
				case 1085: { return 1; }
				case 1087: { return 1; }
				case 1096: { return 1; }
				case 1097: { return 1; }
				case 1098: { return 1; }
			}
		}
		case 426:
		{
			switch (componentid)
			{
				case 1001: { return 1; }
				case 1003: { return 1; }
				case 1004: { return 1; }
				case 1005: { return 1; }
				case 1006: { return 1; }
				case 1008: { return 1; }
				case 1009: { return 1; }
				case 1010: { return 1; }
				case 1019: { return 1; }
				case 1021: { return 1; }
				case 1025: { return 1; }
				case 1073: { return 1; }
				case 1074: { return 1; }
				case 1075: { return 1; }
				case 1076: { return 1; }
				case 1077: { return 1; }
				case 1078: { return 1; }
				case 1079: { return 1; }
				case 1080: { return 1; }
				case 1081: { return 1; }
				case 1082: { return 1; }
				case 1083: { return 1; }
				case 1084: { return 1; }
				case 1085: { return 1; }
				case 1087: { return 1; }
				case 1096: { return 1; }
				case 1097: { return 1; }
				case 1098: { return 1; }
			}
		}
		case 436:
		{
			switch (componentid)
			{
				case 1001: { return 1; }
				case 1003: { return 1; }
				case 1006: { return 1; }
				case 1007: { return 1; }
				case 1008: { return 1; }
				case 1009: { return 1; }
				case 1010: { return 1; }
				case 1013: { return 1; }
				case 1017: { return 1; }
				case 1019: { return 1; }
				case 1020: { return 1; }
				case 1021: { return 1; }
				case 1022: { return 1; }
				case 1025: { return 1; }
				case 1073: { return 1; }
				case 1074: { return 1; }
				case 1075: { return 1; }
				case 1076: { return 1; }
				case 1077: { return 1; }
				case 1078: { return 1; }
				case 1079: { return 1; }
				case 1080: { return 1; }
				case 1081: { return 1; }
				case 1082: { return 1; }
				case 1083: { return 1; }
				case 1084: { return 1; }
				case 1085: { return 1; }
				case 1087: { return 1; }
				case 1096: { return 1; }
				case 1097: { return 1; }
				case 1098: { return 1; }
			}
		}
		case 439:
		{
			switch (componentid)
			{
				case 1001: { return 1; }
				case 1003: { return 1; }
				case 1007: { return 1; }
				case 1008: { return 1; }
				case 1009: { return 1; }
				case 1010: { return 1; }
				case 1013: { return 1; }
				case 1017: { return 1; }
				case 1023: { return 1; }
				case 1025: { return 1; }
				case 1073: { return 1; }
				case 1074: { return 1; }
				case 1075: { return 1; }
				case 1076: { return 1; }
				case 1077: { return 1; }
				case 1078: { return 1; }
				case 1079: { return 1; }
				case 1080: { return 1; }
				case 1081: { return 1; }
				case 1082: { return 1; }
				case 1083: { return 1; }
				case 1084: { return 1; }
				case 1085: { return 1; }
				case 1087: { return 1; }
				case 1096: { return 1; }
				case 1097: { return 1; }
				case 1098: { return 1; }
				case 1142: { return 1; }
				case 1143: { return 1; }
				case 1144: { return 1; }
				case 1145: { return 1; }
			}
		}
		case 477:
		{
			switch (componentid)
			{
				case 1006: { return 1; }
				case 1007: { return 1; }
				case 1008: { return 1; }
				case 1009: { return 1; }
				case 1010: { return 1; }
				case 1017: { return 1; }
				case 1018: { return 1; }
				case 1019: { return 1; }
				case 1020: { return 1; }
				case 1021: { return 1; }
				case 1025: { return 1; }
				case 1073: { return 1; }
				case 1074: { return 1; }
				case 1075: { return 1; }
				case 1076: { return 1; }
				case 1077: { return 1; }
				case 1078: { return 1; }
				case 1079: { return 1; }
				case 1080: { return 1; }
				case 1081: { return 1; }
				case 1082: { return 1; }
				case 1083: { return 1; }
				case 1084: { return 1; }
				case 1085: { return 1; }
				case 1087: { return 1; }
				case 1096: { return 1; }
				case 1097: { return 1; }
				case 1098: { return 1; }
			}
		}
		case 478:
		{
			switch (componentid)
			{
				case 1004: { return 1; }
				case 1005: { return 1; }
				case 1008: { return 1; }
				case 1009: { return 1; }
				case 1010: { return 1; }
				case 1012: { return 1; }
				case 1013: { return 1; }
				case 1020: { return 1; }
				case 1021: { return 1; }
				case 1022: { return 1; }
				case 1024: { return 1; }
				case 1025: { return 1; }
				case 1073: { return 1; }
				case 1074: { return 1; }
				case 1075: { return 1; }
				case 1076: { return 1; }
				case 1077: { return 1; }
				case 1078: { return 1; }
				case 1079: { return 1; }
				case 1080: { return 1; }
				case 1081: { return 1; }
				case 1082: { return 1; }
				case 1083: { return 1; }
				case 1084: { return 1; }
				case 1085: { return 1; }
				case 1087: { return 1; }
				case 1096: { return 1; }
				case 1097: { return 1; }
				case 1098: { return 1; }
			}
		}
		case 489:
		{
			switch (componentid)
			{
				case 1000: { return 1; }
				case 1002: { return 1; }
				case 1004: { return 1; }
				case 1005: { return 1; }
				case 1006: { return 1; }
				case 1008: { return 1; }
				case 1009: { return 1; }
				case 1010: { return 1; }
				case 1013: { return 1; }
				case 1016: { return 1; }
				case 1018: { return 1; }
				case 1019: { return 1; }
				case 1020: { return 1; }
				case 1024: { return 1; }
				case 1025: { return 1; }
				case 1073: { return 1; }
				case 1074: { return 1; }
				case 1075: { return 1; }
				case 1076: { return 1; }
				case 1077: { return 1; }
				case 1078: { return 1; }
				case 1079: { return 1; }
				case 1080: { return 1; }
				case 1081: { return 1; }
				case 1082: { return 1; }
				case 1083: { return 1; }
				case 1084: { return 1; }
				case 1085: { return 1; }
				case 1087: { return 1; }
				case 1096: { return 1; }
				case 1097: { return 1; }
				case 1098: { return 1; }
			}
		}
		case 491:
		{
			switch (componentid)
			{
				case 1003: { return 1; }
				case 1007: { return 1; }
				case 1008: { return 1; }
				case 1009: { return 1; }
				case 1010: { return 1; }
				case 1014: { return 1; }
				case 1017: { return 1; }
				case 1018: { return 1; }
				case 1019: { return 1; }
				case 1020: { return 1; }
				case 1021: { return 1; }
				case 1023: { return 1; }
				case 1025: { return 1; }
				case 1073: { return 1; }
				case 1074: { return 1; }
				case 1075: { return 1; }
				case 1076: { return 1; }
				case 1077: { return 1; }
				case 1078: { return 1; }
				case 1079: { return 1; }
				case 1080: { return 1; }
				case 1081: { return 1; }
				case 1082: { return 1; }
				case 1083: { return 1; }
				case 1084: { return 1; }
				case 1085: { return 1; }
				case 1087: { return 1; }
				case 1096: { return 1; }
				case 1097: { return 1; }
				case 1098: { return 1; }
				case 1142: { return 1; }
				case 1143: { return 1; }
				case 1144: { return 1; }
				case 1145: { return 1; }
			}
		}
		case 492:
		{
			switch (componentid)
			{
				case 1000: { return 1; }
				case 1004: { return 1; }
				case 1005: { return 1; }
				case 1006: { return 1; }
				case 1008: { return 1; }
				case 1009: { return 1; }
				case 1010: { return 1; }
				case 1016: { return 1; }
				case 1025: { return 1; }
				case 1073: { return 1; }
				case 1074: { return 1; }
				case 1075: { return 1; }
				case 1076: { return 1; }
				case 1077: { return 1; }
				case 1078: { return 1; }
				case 1079: { return 1; }
				case 1080: { return 1; }
				case 1081: { return 1; }
				case 1082: { return 1; }
				case 1083: { return 1; }
				case 1084: { return 1; }
				case 1085: { return 1; }
				case 1087: { return 1; }
				case 1096: { return 1; }
				case 1097: { return 1; }
				case 1098: { return 1; }
			}
		}
		case 496:
		{
			switch (componentid)
			{
				case 1001: { return 1; }
				case 1002: { return 1; }
				case 1003: { return 1; }
				case 1006: { return 1; }
				case 1007: { return 1; }
				case 1008: { return 1; }
				case 1009: { return 1; }
				case 1010: { return 1; }
				case 1011: { return 1; }
				case 1017: { return 1; }
				case 1019: { return 1; }
				case 1020: { return 1; }
				case 1023: { return 1; }
				case 1025: { return 1; }
				case 1073: { return 1; }
				case 1074: { return 1; }
				case 1075: { return 1; }
				case 1076: { return 1; }
				case 1077: { return 1; }
				case 1078: { return 1; }
				case 1079: { return 1; }
				case 1080: { return 1; }
				case 1081: { return 1; }
				case 1082: { return 1; }
				case 1083: { return 1; }
				case 1084: { return 1; }
				case 1085: { return 1; }
				case 1087: { return 1; }
				case 1096: { return 1; }
				case 1097: { return 1; }
				case 1098: { return 1; }
				case 1142: { return 1; }
				case 1143: { return 1; }
			}
		}
		case 500:
		{
			switch (componentid)
			{
				case 1008: { return 1; }
				case 1009: { return 1; }
				case 1010: { return 1; }
				case 1013: { return 1; }
				case 1019: { return 1; }
				case 1020: { return 1; }
				case 1021: { return 1; }
				case 1024: { return 1; }
				case 1025: { return 1; }
				case 1073: { return 1; }
				case 1074: { return 1; }
				case 1075: { return 1; }
				case 1076: { return 1; }
				case 1077: { return 1; }
				case 1078: { return 1; }
				case 1079: { return 1; }
				case 1080: { return 1; }
				case 1081: { return 1; }
				case 1082: { return 1; }
				case 1083: { return 1; }
				case 1084: { return 1; }
				case 1085: { return 1; }
				case 1087: { return 1; }
				case 1096: { return 1; }
				case 1097: { return 1; }
				case 1098: { return 1; }
			}
		}
		case 516:
		{
			switch (componentid)
			{
				case 1000: { return 1; }
				case 1002: { return 1; }
				case 1004: { return 1; }
				case 1007: { return 1; }
				case 1008: { return 1; }
				case 1009: { return 1; }
				case 1010: { return 1; }
				case 1015: { return 1; }
				case 1016: { return 1; }
				case 1017: { return 1; }
				case 1018: { return 1; }
				case 1019: { return 1; }
				case 1020: { return 1; }
				case 1021: { return 1; }
				case 1025: { return 1; }
				case 1073: { return 1; }
				case 1074: { return 1; }
				case 1075: { return 1; }
				case 1076: { return 1; }
				case 1077: { return 1; }
				case 1078: { return 1; }
				case 1079: { return 1; }
				case 1080: { return 1; }
				case 1081: { return 1; }
				case 1082: { return 1; }
				case 1083: { return 1; }
				case 1084: { return 1; }
				case 1085: { return 1; }
				case 1087: { return 1; }
				case 1096: { return 1; }
				case 1097: { return 1; }
				case 1098: { return 1; }
			}
		}
		case 517:
		{
			switch (componentid)
			{
				case 1002: { return 1; }
				case 1003: { return 1; }
				case 1007: { return 1; }
				case 1008: { return 1; }
				case 1009: { return 1; }
				case 1010: { return 1; }
				case 1016: { return 1; }
				case 1017: { return 1; }
				case 1018: { return 1; }
				case 1019: { return 1; }
				case 1020: { return 1; }
				case 1023: { return 1; }
				case 1025: { return 1; }
				case 1073: { return 1; }
				case 1074: { return 1; }
				case 1075: { return 1; }
				case 1076: { return 1; }
				case 1077: { return 1; }
				case 1078: { return 1; }
				case 1079: { return 1; }
				case 1080: { return 1; }
				case 1081: { return 1; }
				case 1082: { return 1; }
				case 1083: { return 1; }
				case 1084: { return 1; }
				case 1085: { return 1; }
				case 1087: { return 1; }
				case 1096: { return 1; }
				case 1097: { return 1; }
				case 1098: { return 1; }
				case 1142: { return 1; }
				case 1143: { return 1; }
				case 1144: { return 1; }
				case 1145: { return 1; }
			}
		}
		case 518:
		{
			switch (componentid)
			{
				case 1001: { return 1; }
				case 1003: { return 1; }
				case 1005: { return 1; }
				case 1006: { return 1; }
				case 1007: { return 1; }
				case 1008: { return 1; }
				case 1009: { return 1; }
				case 1010: { return 1; }
				case 1013: { return 1; }
				case 1017: { return 1; }
				case 1018: { return 1; }
				case 1020: { return 1; }
				case 1023: { return 1; }
				case 1025: { return 1; }
				case 1073: { return 1; }
				case 1074: { return 1; }
				case 1075: { return 1; }
				case 1076: { return 1; }
				case 1077: { return 1; }
				case 1078: { return 1; }
				case 1079: { return 1; }
				case 1080: { return 1; }
				case 1081: { return 1; }
				case 1082: { return 1; }
				case 1083: { return 1; }
				case 1084: { return 1; }
				case 1085: { return 1; }
				case 1087: { return 1; }
				case 1096: { return 1; }
				case 1097: { return 1; }
				case 1098: { return 1; }
				case 1142: { return 1; }
				case 1143: { return 1; }
				case 1144: { return 1; }
				case 1145: { return 1; }
			}
		}
		case 527:
		{
			switch (componentid)
			{
				case 1001: { return 1; }
				case 1007: { return 1; }
				case 1008: { return 1; }
				case 1009: { return 1; }
				case 1010: { return 1; }
				case 1014: { return 1; }
				case 1015: { return 1; }
				case 1017: { return 1; }
				case 1018: { return 1; }
				case 1020: { return 1; }
				case 1021: { return 1; }
				case 1025: { return 1; }
				case 1073: { return 1; }
				case 1074: { return 1; }
				case 1075: { return 1; }
				case 1076: { return 1; }
				case 1077: { return 1; }
				case 1078: { return 1; }
				case 1079: { return 1; }
				case 1080: { return 1; }
				case 1081: { return 1; }
				case 1082: { return 1; }
				case 1083: { return 1; }
				case 1084: { return 1; }
				case 1085: { return 1; }
				case 1087: { return 1; }
				case 1096: { return 1; }
				case 1097: { return 1; }
				case 1098: { return 1; }
			}
		}
		case 529:
		{
			switch (componentid)
			{
				case 1001: { return 1; }
				case 1003: { return 1; }
				case 1006: { return 1; }
				case 1007: { return 1; }
				case 1008: { return 1; }
				case 1009: { return 1; }
				case 1010: { return 1; }
				case 1011: { return 1; }
				case 1012: { return 1; }
				case 1017: { return 1; }
				case 1018: { return 1; }
				case 1019: { return 1; }
				case 1020: { return 1; }
				case 1023: { return 1; }
				case 1025: { return 1; }
				case 1073: { return 1; }
				case 1074: { return 1; }
				case 1075: { return 1; }
				case 1076: { return 1; }
				case 1077: { return 1; }
				case 1078: { return 1; }
				case 1079: { return 1; }
				case 1080: { return 1; }
				case 1081: { return 1; }
				case 1082: { return 1; }
				case 1083: { return 1; }
				case 1084: { return 1; }
				case 1085: { return 1; }
				case 1087: { return 1; }
				case 1096: { return 1; }
				case 1097: { return 1; }
				case 1098: { return 1; }
			}
		}
		case 534:
		{
			switch (componentid)
			{
				case 1008: { return 1; }
				case 1009: { return 1; }
				case 1010: { return 1; }
				case 1025: { return 1; }
				case 1073: { return 1; }
				case 1074: { return 1; }
				case 1075: { return 1; }
				case 1076: { return 1; }
				case 1077: { return 1; }
				case 1078: { return 1; }
				case 1079: { return 1; }
				case 1080: { return 1; }
				case 1081: { return 1; }
				case 1082: { return 1; }
				case 1083: { return 1; }
				case 1084: { return 1; }
				case 1085: { return 1; }
				case 1087: { return 1; }
				case 1096: { return 1; }
				case 1097: { return 1; }
				case 1098: { return 1; }
				case 1100: { return 1; }
				case 1101: { return 1; }
				case 1106: { return 1; }
				case 1122: { return 1; }
				case 1123: { return 1; }
				case 1124: { return 1; }
				case 1125: { return 1; }
				case 1126: { return 1; }
				case 1127: { return 1; }
				case 1178: { return 1; }
				case 1179: { return 1; }
				case 1180: { return 1; }
				case 1185: { return 1; }
			}
		}
		case 535:
		{
			switch (componentid)
			{
				case 1008: { return 1; }
				case 1009: { return 1; }
				case 1010: { return 1; }
				case 1025: { return 1; }
				case 1073: { return 1; }
				case 1074: { return 1; }
				case 1075: { return 1; }
				case 1076: { return 1; }
				case 1077: { return 1; }
				case 1078: { return 1; }
				case 1079: { return 1; }
				case 1080: { return 1; }
				case 1081: { return 1; }
				case 1082: { return 1; }
				case 1083: { return 1; }
				case 1084: { return 1; }
				case 1085: { return 1; }
				case 1087: { return 1; }
				case 1096: { return 1; }
				case 1097: { return 1; }
				case 1098: { return 1; }
				case 1109: { return 1; }
				case 1110: { return 1; }
				case 1113: { return 1; }
				case 1114: { return 1; }
				case 1115: { return 1; }
				case 1116: { return 1; }
				case 1117: { return 1; }
				case 1118: { return 1; }
				case 1119: { return 1; }
				case 1120: { return 1; }
				case 1121: { return 1; }
			}
		}
		case 536:
		{
			switch (componentid)
			{
				case 1008: { return 1; }
				case 1009: { return 1; }
				case 1010: { return 1; }
				case 1025: { return 1; }
				case 1073: { return 1; }
				case 1074: { return 1; }
				case 1075: { return 1; }
				case 1076: { return 1; }
				case 1077: { return 1; }
				case 1078: { return 1; }
				case 1079: { return 1; }
				case 1080: { return 1; }
				case 1081: { return 1; }
				case 1082: { return 1; }
				case 1083: { return 1; }
				case 1084: { return 1; }
				case 1085: { return 1; }
				case 1087: { return 1; }
				case 1096: { return 1; }
				case 1097: { return 1; }
				case 1098: { return 1; }
				case 1103: { return 1; }
				case 1104: { return 1; }
				case 1105: { return 1; }
				case 1107: { return 1; }
				case 1108: { return 1; }
				case 1128: { return 1; }
				case 1181: { return 1; }
				case 1182: { return 1; }
				case 1183: { return 1; }
				case 1184: { return 1; }
			}
		}
		case 540:
		{
			switch (componentid)
			{
				case 1001: { return 1; }
				case 1004: { return 1; }
				case 1006: { return 1; }
				case 1007: { return 1; }
				case 1008: { return 1; }
				case 1009: { return 1; }
				case 1010: { return 1; }
				case 1017: { return 1; }
				case 1018: { return 1; }
				case 1019: { return 1; }
				case 1020: { return 1; }
				case 1023: { return 1; }
				case 1024: { return 1; }
				case 1025: { return 1; }
				case 1073: { return 1; }
				case 1074: { return 1; }
				case 1075: { return 1; }
				case 1076: { return 1; }
				case 1077: { return 1; }
				case 1078: { return 1; }
				case 1079: { return 1; }
				case 1080: { return 1; }
				case 1081: { return 1; }
				case 1082: { return 1; }
				case 1083: { return 1; }
				case 1084: { return 1; }
				case 1085: { return 1; }
				case 1087: { return 1; }
				case 1096: { return 1; }
				case 1097: { return 1; }
				case 1098: { return 1; }
				case 1142: { return 1; }
				case 1143: { return 1; }
				case 1144: { return 1; }
				case 1145: { return 1; }
			}
		}
		case 542:
		{
			switch (componentid)
			{
				case 1008: { return 1; }
				case 1009: { return 1; }
				case 1010: { return 1; }
				case 1014: { return 1; }
				case 1015: { return 1; }
				case 1018: { return 1; }
				case 1019: { return 1; }
				case 1020: { return 1; }
				case 1021: { return 1; }
				case 1025: { return 1; }
				case 1073: { return 1; }
				case 1074: { return 1; }
				case 1075: { return 1; }
				case 1076: { return 1; }
				case 1077: { return 1; }
				case 1078: { return 1; }
				case 1079: { return 1; }
				case 1080: { return 1; }
				case 1081: { return 1; }
				case 1082: { return 1; }
				case 1083: { return 1; }
				case 1084: { return 1; }
				case 1085: { return 1; }
				case 1087: { return 1; }
				case 1096: { return 1; }
				case 1097: { return 1; }
				case 1098: { return 1; }
				case 1144: { return 1; }
				case 1145: { return 1; }
			}
		}
		case 546:
		{
			switch (componentid)
			{
				case 1001: { return 1; }
				case 1002: { return 1; }
				case 1004: { return 1; }
				case 1006: { return 1; }
				case 1007: { return 1; }
				case 1008: { return 1; }
				case 1009: { return 1; }
				case 1010: { return 1; }
				case 1017: { return 1; }
				case 1018: { return 1; }
				case 1019: { return 1; }
				case 1023: { return 1; }
				case 1024: { return 1; }
				case 1025: { return 1; }
				case 1073: { return 1; }
				case 1074: { return 1; }
				case 1075: { return 1; }
				case 1076: { return 1; }
				case 1077: { return 1; }
				case 1078: { return 1; }
				case 1079: { return 1; }
				case 1080: { return 1; }
				case 1081: { return 1; }
				case 1082: { return 1; }
				case 1083: { return 1; }
				case 1084: { return 1; }
				case 1085: { return 1; }
				case 1087: { return 1; }
				case 1096: { return 1; }
				case 1097: { return 1; }
				case 1098: { return 1; }
				case 1142: { return 1; }
				case 1143: { return 1; }
				case 1144: { return 1; }
				case 1145: { return 1; }
			}
		}
		case 547:
		{
			switch (componentid)
			{
				case 1000: { return 1; }
				case 1003: { return 1; }
				case 1008: { return 1; }
				case 1009: { return 1; }
				case 1010: { return 1; }
				case 1016: { return 1; }
				case 1018: { return 1; }
				case 1019: { return 1; }
				case 1020: { return 1; }
				case 1021: { return 1; }
				case 1025: { return 1; }
				case 1073: { return 1; }
				case 1074: { return 1; }
				case 1075: { return 1; }
				case 1076: { return 1; }
				case 1077: { return 1; }
				case 1078: { return 1; }
				case 1079: { return 1; }
				case 1080: { return 1; }
				case 1081: { return 1; }
				case 1082: { return 1; }
				case 1083: { return 1; }
				case 1084: { return 1; }
				case 1085: { return 1; }
				case 1087: { return 1; }
				case 1096: { return 1; }
				case 1097: { return 1; }
				case 1098: { return 1; }
				case 1142: { return 1; }
				case 1143: { return 1; }
			}
		}
		case 549:
		{
			switch (componentid)
			{
				case 1001: { return 1; }
				case 1003: { return 1; }
				case 1007: { return 1; }
				case 1008: { return 1; }
				case 1009: { return 1; }
				case 1010: { return 1; }
				case 1011: { return 1; }
				case 1012: { return 1; }
				case 1017: { return 1; }
				case 1018: { return 1; }
				case 1019: { return 1; }
				case 1020: { return 1; }
				case 1023: { return 1; }
				case 1025: { return 1; }
				case 1073: { return 1; }
				case 1074: { return 1; }
				case 1075: { return 1; }
				case 1076: { return 1; }
				case 1077: { return 1; }
				case 1078: { return 1; }
				case 1079: { return 1; }
				case 1080: { return 1; }
				case 1081: { return 1; }
				case 1082: { return 1; }
				case 1083: { return 1; }
				case 1084: { return 1; }
				case 1085: { return 1; }
				case 1087: { return 1; }
				case 1096: { return 1; }
				case 1097: { return 1; }
				case 1098: { return 1; }
				case 1142: { return 1; }
				case 1143: { return 1; }
				case 1144: { return 1; }
				case 1145: { return 1; }
			}
		}
		case 550:
		{
			switch (componentid)
			{
				case 1001: { return 1; }
				case 1003: { return 1; }
				case 1004: { return 1; }
				case 1005: { return 1; }
				case 1006: { return 1; }
				case 1008: { return 1; }
				case 1009: { return 1; }
				case 1010: { return 1; }
				case 1018: { return 1; }
				case 1019: { return 1; }
				case 1020: { return 1; }
				case 1023: { return 1; }
				case 1025: { return 1; }
				case 1073: { return 1; }
				case 1074: { return 1; }
				case 1075: { return 1; }
				case 1076: { return 1; }
				case 1077: { return 1; }
				case 1078: { return 1; }
				case 1079: { return 1; }
				case 1080: { return 1; }
				case 1081: { return 1; }
				case 1082: { return 1; }
				case 1083: { return 1; }
				case 1084: { return 1; }
				case 1085: { return 1; }
				case 1087: { return 1; }
				case 1096: { return 1; }
				case 1097: { return 1; }
				case 1098: { return 1; }
				case 1142: { return 1; }
				case 1143: { return 1; }
				case 1144: { return 1; }
				case 1145: { return 1; }
			}
		}
		case 551:
		{
			switch (componentid)
			{
				case 1002: { return 1; }
				case 1003: { return 1; }
				case 1005: { return 1; }
				case 1006: { return 1; }
				case 1008: { return 1; }
				case 1009: { return 1; }
				case 1010: { return 1; }
				case 1016: { return 1; }
				case 1018: { return 1; }
				case 1019: { return 1; }
				case 1020: { return 1; }
				case 1021: { return 1; }
				case 1023: { return 1; }
				case 1025: { return 1; }
				case 1073: { return 1; }
				case 1074: { return 1; }
				case 1075: { return 1; }
				case 1076: { return 1; }
				case 1077: { return 1; }
				case 1078: { return 1; }
				case 1079: { return 1; }
				case 1080: { return 1; }
				case 1081: { return 1; }
				case 1082: { return 1; }
				case 1083: { return 1; }
				case 1084: { return 1; }
				case 1085: { return 1; }
				case 1087: { return 1; }
				case 1096: { return 1; }
				case 1097: { return 1; }
				case 1098: { return 1; }
			}
		}
		case 558:
		{
			switch (componentid)
			{
				case 1008: { return 1; }
				case 1009: { return 1; }
				case 1010: { return 1; }
				case 1025: { return 1; }
				case 1073: { return 1; }
				case 1074: { return 1; }
				case 1075: { return 1; }
				case 1076: { return 1; }
				case 1077: { return 1; }
				case 1078: { return 1; }
				case 1079: { return 1; }
				case 1080: { return 1; }
				case 1081: { return 1; }
				case 1082: { return 1; }
				case 1083: { return 1; }
				case 1084: { return 1; }
				case 1085: { return 1; }
				case 1087: { return 1; }
				case 1088: { return 1; }
				case 1089: { return 1; }
				case 1090: { return 1; }
				case 1091: { return 1; }
				case 1092: { return 1; }
				case 1093: { return 1; }
				case 1094: { return 1; }
				case 1095: { return 1; }
				case 1096: { return 1; }
				case 1097: { return 1; }
				case 1098: { return 1; }
				case 1163: { return 1; }
				case 1164: { return 1; }
				case 1165: { return 1; }
				case 1166: { return 1; }
				case 1167: { return 1; }
				case 1168: { return 1; }
			}
		}
		case 559:
		{
			switch (componentid)
			{
				case 1008: { return 1; }
				case 1009: { return 1; }
				case 1010: { return 1; }
				case 1025: { return 1; }
				case 1065: { return 1; }
				case 1066: { return 1; }
				case 1067: { return 1; }
				case 1068: { return 1; }
				case 1069: { return 1; }
				case 1070: { return 1; }
				case 1071: { return 1; }
				case 1072: { return 1; }
				case 1073: { return 1; }
				case 1074: { return 1; }
				case 1075: { return 1; }
				case 1076: { return 1; }
				case 1077: { return 1; }
				case 1078: { return 1; }
				case 1079: { return 1; }
				case 1080: { return 1; }
				case 1081: { return 1; }
				case 1082: { return 1; }
				case 1083: { return 1; }
				case 1084: { return 1; }
				case 1085: { return 1; }
				case 1087: { return 1; }
				case 1096: { return 1; }
				case 1097: { return 1; }
				case 1098: { return 1; }
				case 1158: { return 1; }
				case 1159: { return 1; }
				case 1160: { return 1; }
				case 1161: { return 1; }
				case 1162: { return 1; }
				case 1173: { return 1; }
			}
		}
		case 560:
		{
			switch (componentid)
			{
				case 1008: { return 1; }
				case 1009: { return 1; }
				case 1010: { return 1; }
				case 1025: { return 1; }
				case 1026: { return 1; }
				case 1027: { return 1; }
				case 1028: { return 1; }
				case 1029: { return 1; }
				case 1030: { return 1; }
				case 1031: { return 1; }
				case 1032: { return 1; }
				case 1033: { return 1; }
				case 1073: { return 1; }
				case 1074: { return 1; }
				case 1075: { return 1; }
				case 1076: { return 1; }
				case 1077: { return 1; }
				case 1078: { return 1; }
				case 1079: { return 1; }
				case 1080: { return 1; }
				case 1081: { return 1; }
				case 1082: { return 1; }
				case 1083: { return 1; }
				case 1084: { return 1; }
				case 1085: { return 1; }
				case 1087: { return 1; }
				case 1096: { return 1; }
				case 1097: { return 1; }
				case 1098: { return 1; }
				case 1138: { return 1; }
				case 1139: { return 1; }
				case 1140: { return 1; }
				case 1141: { return 1; }
				case 1169: { return 1; }
				case 1170: { return 1; }
			}
		}
		case 561:
		{
			switch (componentid)
			{
				case 1008: { return 1; }
				case 1009: { return 1; }
				case 1010: { return 1; }
				case 1025: { return 1; }
				case 1055: { return 1; }
				case 1056: { return 1; }
				case 1057: { return 1; }
				case 1058: { return 1; }
				case 1059: { return 1; }
				case 1060: { return 1; }
				case 1061: { return 1; }
				case 1062: { return 1; }
				case 1063: { return 1; }
				case 1064: { return 1; }
				case 1073: { return 1; }
				case 1074: { return 1; }
				case 1075: { return 1; }
				case 1076: { return 1; }
				case 1077: { return 1; }
				case 1078: { return 1; }
				case 1079: { return 1; }
				case 1080: { return 1; }
				case 1081: { return 1; }
				case 1082: { return 1; }
				case 1083: { return 1; }
				case 1084: { return 1; }
				case 1085: { return 1; }
				case 1087: { return 1; }
				case 1096: { return 1; }
				case 1097: { return 1; }
				case 1098: { return 1; }
				case 1154: { return 1; }
				case 1155: { return 1; }
				case 1156: { return 1; }
				case 1157: { return 1; }
			}
		}
		case 562:
		{
			switch (componentid)
			{
				case 1008: { return 1; }
				case 1009: { return 1; }
				case 1010: { return 1; }
				case 1025: { return 1; }
				case 1034: { return 1; }
				case 1035: { return 1; }
				case 1036: { return 1; }
				case 1037: { return 1; }
				case 1038: { return 1; }
				case 1039: { return 1; }
				case 1040: { return 1; }
				case 1041: { return 1; }
				case 1073: { return 1; }
				case 1074: { return 1; }
				case 1075: { return 1; }
				case 1076: { return 1; }
				case 1077: { return 1; }
				case 1078: { return 1; }
				case 1079: { return 1; }
				case 1080: { return 1; }
				case 1081: { return 1; }
				case 1082: { return 1; }
				case 1083: { return 1; }
				case 1084: { return 1; }
				case 1085: { return 1; }
				case 1087: { return 1; }
				case 1096: { return 1; }
				case 1097: { return 1; }
				case 1098: { return 1; }
				case 1146: { return 1; }
				case 1147: { return 1; }
				case 1148: { return 1; }
				case 1149: { return 1; }
				case 1171: { return 1; }
				case 1172: { return 1; }
			}
		}
		case 565:
		{
			switch (componentid)
			{
				case 1008: { return 1; }
				case 1009: { return 1; }
				case 1010: { return 1; }
				case 1025: { return 1; }
				case 1045: { return 1; }
				case 1046: { return 1; }
				case 1047: { return 1; }
				case 1048: { return 1; }
				case 1049: { return 1; }
				case 1050: { return 1; }
				case 1051: { return 1; }
				case 1052: { return 1; }
				case 1053: { return 1; }
				case 1054: { return 1; }
				case 1073: { return 1; }
				case 1074: { return 1; }
				case 1075: { return 1; }
				case 1076: { return 1; }
				case 1077: { return 1; }
				case 1078: { return 1; }
				case 1079: { return 1; }
				case 1080: { return 1; }
				case 1081: { return 1; }
				case 1082: { return 1; }
				case 1083: { return 1; }
				case 1084: { return 1; }
				case 1085: { return 1; }
				case 1087: { return 1; }
				case 1096: { return 1; }
				case 1097: { return 1; }
				case 1098: { return 1; }
				case 1150: { return 1; }
				case 1151: { return 1; }
				case 1152: { return 1; }
				case 1153: { return 1; }
			}
		}
		case 567:
		{
			switch (componentid)
			{
				case 1008: { return 1; }
				case 1009: { return 1; }
				case 1010: { return 1; }
				case 1025: { return 1; }
				case 1073: { return 1; }
				case 1074: { return 1; }
				case 1075: { return 1; }
				case 1076: { return 1; }
				case 1077: { return 1; }
				case 1078: { return 1; }
				case 1079: { return 1; }
				case 1080: { return 1; }
				case 1081: { return 1; }
				case 1082: { return 1; }
				case 1083: { return 1; }
				case 1084: { return 1; }
				case 1085: { return 1; }
				case 1087: { return 1; }
				case 1096: { return 1; }
				case 1097: { return 1; }
				case 1098: { return 1; }
				case 1102: { return 1; }
				case 1129: { return 1; }
				case 1130: { return 1; }
				case 1131: { return 1; }
				case 1132: { return 1; }
				case 1133: { return 1; }
				case 1186: { return 1; }
				case 1187: { return 1; }
				case 1188: { return 1; }
				case 1189: { return 1; }
			}
		}
		case 575:
		{
			switch (componentid)
			{
				case 1008: { return 1; }
				case 1009: { return 1; }
				case 1010: { return 1; }
				case 1025: { return 1; }
				case 1042: { return 1; }
				case 1043: { return 1; }
				case 1044: { return 1; }
				case 1073: { return 1; }
				case 1074: { return 1; }
				case 1075: { return 1; }
				case 1076: { return 1; }
				case 1077: { return 1; }
				case 1078: { return 1; }
				case 1079: { return 1; }
				case 1080: { return 1; }
				case 1081: { return 1; }
				case 1082: { return 1; }
				case 1083: { return 1; }
				case 1084: { return 1; }
				case 1085: { return 1; }
				case 1087: { return 1; }
				case 1096: { return 1; }
				case 1097: { return 1; }
				case 1098: { return 1; }
				case 1099: { return 1; }
				case 1174: { return 1; }
				case 1175: { return 1; }
				case 1176: { return 1; }
				case 1177: { return 1; }
			}
		}
		case 576:
		{
			switch (componentid)
			{
				case 1008: { return 1; }
				case 1009: { return 1; }
				case 1010: { return 1; }
				case 1025: { return 1; }
				case 1073: { return 1; }
				case 1074: { return 1; }
				case 1075: { return 1; }
				case 1076: { return 1; }
				case 1077: { return 1; }
				case 1078: { return 1; }
				case 1079: { return 1; }
				case 1080: { return 1; }
				case 1081: { return 1; }
				case 1082: { return 1; }
				case 1083: { return 1; }
				case 1084: { return 1; }
				case 1085: { return 1; }
				case 1087: { return 1; }
				case 1096: { return 1; }
				case 1097: { return 1; }
				case 1098: { return 1; }
				case 1134: { return 1; }
				case 1135: { return 1; }
				case 1136: { return 1; }
				case 1137: { return 1; }
				case 1190: { return 1; }
				case 1191: { return 1; }
				case 1192: { return 1; }
				case 1193: { return 1; }
			}
		}
		case 580:
		{
			switch (componentid)
			{
				case 1001: { return 1; }
				case 1006: { return 1; }
				case 1007: { return 1; }
				case 1008: { return 1; }
				case 1009: { return 1; }
				case 1010: { return 1; }
				case 1017: { return 1; }
				case 1018: { return 1; }
				case 1020: { return 1; }
				case 1023: { return 1; }
				case 1025: { return 1; }
				case 1073: { return 1; }
				case 1074: { return 1; }
				case 1075: { return 1; }
				case 1076: { return 1; }
				case 1077: { return 1; }
				case 1078: { return 1; }
				case 1079: { return 1; }
				case 1080: { return 1; }
				case 1081: { return 1; }
				case 1082: { return 1; }
				case 1083: { return 1; }
				case 1084: { return 1; }
				case 1085: { return 1; }
				case 1087: { return 1; }
				case 1096: { return 1; }
				case 1097: { return 1; }
				case 1098: { return 1; }
			}
		}
		case 585:
		{
			switch (componentid)
			{
				case 1001: { return 1; }
				case 1003: { return 1; }
				case 1006: { return 1; }
				case 1007: { return 1; }
				case 1008: { return 1; }
				case 1009: { return 1; }
				case 1010: { return 1; }
				case 1013: { return 1; }
				case 1017: { return 1; }
				case 1018: { return 1; }
				case 1019: { return 1; }
				case 1020: { return 1; }
				case 1023: { return 1; }
				case 1025: { return 1; }
				case 1073: { return 1; }
				case 1074: { return 1; }
				case 1075: { return 1; }
				case 1076: { return 1; }
				case 1077: { return 1; }
				case 1078: { return 1; }
				case 1079: { return 1; }
				case 1080: { return 1; }
				case 1081: { return 1; }
				case 1082: { return 1; }
				case 1083: { return 1; }
				case 1084: { return 1; }
				case 1085: { return 1; }
				case 1087: { return 1; }
				case 1096: { return 1; }
				case 1097: { return 1; }
				case 1098: { return 1; }
				case 1142: { return 1; }
				case 1143: { return 1; }
				case 1144: { return 1; }
				case 1145: { return 1; }
			}
		}
		case 589:
		{
			switch (componentid)
			{
				case 1000: { return 1; }
				case 1004: { return 1; }
				case 1005: { return 1; }
				case 1006: { return 1; }
				case 1007: { return 1; }
				case 1008: { return 1; }
				case 1009: { return 1; }
				case 1010: { return 1; }
				case 1013: { return 1; }
				case 1016: { return 1; }
				case 1017: { return 1; }
				case 1018: { return 1; }
				case 1020: { return 1; }
				case 1024: { return 1; }
				case 1025: { return 1; }
				case 1073: { return 1; }
				case 1074: { return 1; }
				case 1075: { return 1; }
				case 1076: { return 1; }
				case 1077: { return 1; }
				case 1078: { return 1; }
				case 1079: { return 1; }
				case 1080: { return 1; }
				case 1081: { return 1; }
				case 1082: { return 1; }
				case 1083: { return 1; }
				case 1084: { return 1; }
				case 1085: { return 1; }
				case 1087: { return 1; }
				case 1096: { return 1; }
				case 1097: { return 1; }
				case 1098: { return 1; }
				case 1144: { return 1; }
				case 1145: { return 1; }
			}
		}
		case 600:
		{
			switch (componentid)
			{
				case 1004: { return 1; }
				case 1005: { return 1; }
				case 1006: { return 1; }
				case 1007: { return 1; }
				case 1008: { return 1; }
				case 1009: { return 1; }
				case 1010: { return 1; }
				case 1013: { return 1; }
				case 1017: { return 1; }
				case 1018: { return 1; }
				case 1020: { return 1; }
				case 1022: { return 1; }
				case 1025: { return 1; }
				case 1073: { return 1; }
				case 1074: { return 1; }
				case 1075: { return 1; }
				case 1076: { return 1; }
				case 1077: { return 1; }
				case 1078: { return 1; }
				case 1079: { return 1; }
				case 1080: { return 1; }
				case 1081: { return 1; }
				case 1082: { return 1; }
				case 1083: { return 1; }
				case 1084: { return 1; }
				case 1085: { return 1; }
				case 1087: { return 1; }
				case 1096: { return 1; }
				case 1097: { return 1; }
				case 1098: { return 1; }
			}
		}
		case 603:
		{
			switch (componentid)
			{
				case 1001: { return 1; }
				case 1006: { return 1; }
				case 1007: { return 1; }
				case 1008: { return 1; }
				case 1009: { return 1; }
				case 1010: { return 1; }
				case 1017: { return 1; }
				case 1018: { return 1; }
				case 1019: { return 1; }
				case 1020: { return 1; }
				case 1023: { return 1; }
				case 1024: { return 1; }
				case 1025: { return 1; }
				case 1073: { return 1; }
				case 1074: { return 1; }
				case 1075: { return 1; }
				case 1076: { return 1; }
				case 1077: { return 1; }
				case 1078: { return 1; }
				case 1079: { return 1; }
				case 1080: { return 1; }
				case 1081: { return 1; }
				case 1082: { return 1; }
				case 1083: { return 1; }
				case 1084: { return 1; }
				case 1085: { return 1; }
				case 1087: { return 1; }
				case 1096: { return 1; }
				case 1097: { return 1; }
				case 1098: { return 1; }
				case 1142: { return 1; }
				case 1143: { return 1; }
				case 1144: { return 1; }
				case 1145: { return 1; }
			}
		}
		case 402,403,406..409,411..414,416,419,423,424,427..429,431..435,437,438,440..445,448,450,451,455..459,461..463,466..468,470,471,474,475,479..486,490,494,495,498,499,502..510,514,515,521..526,528,530..533,541,552,543..545,554..557,566,568,578,571..574,579,581..584,586..588,591,594,596..599,601,602,604..611:
		{
			switch (componentid)
			{
				case 1008: { return 1; }
				case 1009: { return 1; }
				case 1010: { return 1; }
				case 1025: { return 1; }
				case 1073: { return 1; }
				case 1074: { return 1; }
				case 1075: { return 1; }
				case 1076: { return 1; }
				case 1077: { return 1; }
				case 1078: { return 1; }
				case 1079: { return 1; }
				case 1080: { return 1; }
				case 1081: { return 1; }
				case 1082: { return 1; }
				case 1083: { return 1; }
				case 1084: { return 1; }
				case 1085: { return 1; }
				case 1087: { return 1; }
				case 1096: { return 1; }
				case 1097: { return 1; }
				case 1098: { return 1; }
			}
		}
	}
	return 0;
}

Trash_InitPlayer(playerid)
{
    HasTrash[playerid] = false;
    TrashCP[playerid] = -1;

    for(new i; i < sizeof(FactoryData); i++)
	{
		TogglePlayerDynamicCP(playerid, FactoryData[i][FactoryCP], 0);
		FactoryIcons[playerid][i] = -1;
	}

	CapacityText[playerid] = CreatePlayerTextDraw(playerid, 32.000000, 290.000000, "Arac kapasitesi (0/10)");
	PlayerTextDrawBackgroundColor(playerid, CapacityText[playerid], 255);
	PlayerTextDrawFont(playerid, CapacityText[playerid], 1);
	PlayerTextDrawLetterSize(playerid, CapacityText[playerid], 0.200000, 1.000000);
	PlayerTextDrawColor(playerid, CapacityText[playerid], -1);
	PlayerTextDrawSetOutline(playerid, CapacityText[playerid], 1);
	PlayerTextDrawSetProportional(playerid, CapacityText[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, CapacityText[playerid], 0);

	CapacityBar[playerid] = CreatePlayerProgressBar(playerid, 30.000000, 304.000000, 118.500000, 6.199999, -1429936641, TRASH_LIMIT, 0);
	return 1;
}

Trash_ResetPlayer(playerid, removeUI = 0)
{
	if(IsPlayerAttachedObjectSlotUsed(playerid, ATTACHMENT_INDEX)) RemovePlayerAttachedObject(playerid, ATTACHMENT_INDEX);
	if(IsValidDynamicCP(TrashCP[playerid])) DestroyDynamicCP(TrashCP[playerid]);
	HasTrash[playerid] = false;
	TrashCP[playerid] = -1;

	if(removeUI)
	{
	    PlayerTextDrawDestroy(playerid, CapacityText[playerid]);
	    DestroyPlayerProgressBar(playerid, CapacityBar[playerid]);
	}

	return 1;
}

Trash_ShowCapacity(playerid)
{
    new vehicleid = GetPlayerVehicleID(playerid), capacity_string[32];
    format(capacity_string, sizeof(capacity_string), "Arac kapasitesi (%d/%d)", LoadedTrash[vehicleid], TRASH_LIMIT);
    PlayerTextDrawSetString(playerid, CapacityText[playerid], capacity_string);
    PlayerTextDrawShow(playerid, CapacityText[playerid]);

	SetPlayerProgressBarValue(playerid, CapacityBar[playerid], LoadedTrash[vehicleid]);
	ShowPlayerProgressBar(playerid, CapacityBar[playerid]);
	return 1;
}
stock UcakKontrol(aracid)
{
	switch(GetVehicleModel(aracid)) {
		case 592, 577, 511, 512, 593, 520, 553, 476, 519, 460, 513, 548, 425, 417, 487, 488, 497, 563, 447, 469: return 1;
	}
	return 0;
}

stock HelikopterKontrol(aracid)
{
	switch(GetVehicleModel(aracid)) {
		case 417, 425, 447, 465, 469, 487, 488, 497, 501, 548, 563: return 1;
	}
	return 0;
}

Trash_Closest(playerid)
{
	new closest_id = -1, Float: dist = 300.0, Float: tempdist;
    for(new i; i < sizeof(TrashData); i++)
	{
	    tempdist = GetPlayerDistanceFromPoint(playerid, TrashData[i][TrashX], TrashData[i][TrashY], TrashData[i][TrashZ]);
		if(tempdist > 300.0) continue;
		if(tempdist <= dist)
		{
		    dist = tempdist;
		    closest_id = i;
		}
	}

	return closest_id;
}

Trash_ClosestEx(playerid)
{
	new closest_id = -1, Float: dist = 5.0, Float: tempdist;
    for(new i; i < sizeof(TrashData); i++)
	{
	    tempdist = GetPlayerDistanceFromPoint(playerid, TrashData[i][TrashX], TrashData[i][TrashY], TrashData[i][TrashZ]);
		if(tempdist > 5.0) continue;
		if(tempdist <= dist)
		{
		    dist = tempdist;
		    closest_id = i;
		}
	}

	return closest_id;
}


Tamirhane_Objeler(id, bool:option=true)
{
	if(!Tamirhane[id][Tamirhane_Kontrol])
		return 1;

	if(IsValidDynamic3DTextLabel(Tamirhane[id][Tamirhane_Yazi]))
	{
		DestroyDynamic3DTextLabel(Tamirhane[id][Tamirhane_Yazi]);
		Tamirhane[id][Tamirhane_Yazi] = Text3D:INVALID_3DTEXT_ID;
	}

	if(option)
	{
		if(IsValidDynamicPickup(Tamirhane[id][Tamirhane_Pickup]))
			DestroyDynamicPickup(Tamirhane[id][Tamirhane_Pickup]);

		Tamirhane[id][Tamirhane_Pickup] = CreateDynamicPickup(19627, 23, Tamirhane[id][Tamirhane_Pos][0], Tamirhane[id][Tamirhane_Pos][1], Tamirhane[id][Tamirhane_Pos][2], Tamirhane[id][Tamirhane_World], Tamirhane[id][Tamirhane_Interior]);


		if(IsValidDynamicMapIcon(Tamirhane[id][Tamirhane_MapIcon]))
			DestroyDynamicMapIcon(Tamirhane[id][Tamirhane_MapIcon]);

		Tamirhane[id][Tamirhane_MapIcon] = CreateDynamicMapIcon(Tamirhane[id][Tamirhane_Pos][0], Tamirhane[id][Tamirhane_Pos][1], Tamirhane[id][Tamirhane_Pos][2], 63, -1);
	}

    new string[128];

	format(string, sizeof(string), "{808080}[Araç Tamir Noktasý]\n[%d] [Y tuþu tamir] {808080}\n/araczirhlat\n/aracyukselt\n/taksiplakasi", id);

	Tamirhane[id][Tamirhane_Yazi] = CreateDynamic3DTextLabel(string, -1, Tamirhane[id][Tamirhane_Pos][0], Tamirhane[id][Tamirhane_Pos][1], Tamirhane[id][Tamirhane_Pos][2], 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, -1,-1, STREAMER_3D_TEXT_LABEL_SD, -1, 0);
	return 1;
}

IsPlayerNearPNS(playerid)
{
	for(new i = 0; i < MAX_TAMIRHANE; i++)
	{
		if(IsPlayerInRangeOfPoint(playerid, 5.0, Tamirhane[i][Tamirhane_Pos][0], Tamirhane[i][Tamirhane_Pos][1], Tamirhane[i][Tamirhane_Pos][2]))
			return i;
	}
	return -1;
}

Tamirhane_Kaydet(id, bool:opsiyon=false)
{
	if(!Tamirhane[id][Tamirhane_Kontrol])
		return 1;

	new query[500];

	mysql_format(g_SQL, query, sizeof(query), "UPDATE tamirhaneler SET tamirX = '%0.2f', tamirY = '%0.2f', tamirZ = '%0.2f', tamirA = '%0.2f', tamirIcX = '%0.2f', tamirIcY = '%0.2f', tamirIcZ = '%0.2f', tamirIcA = '%0.2f', tamirVW = '%d', tamirInt = '%d', tamirIcVW = '%d', tamirIcInt = '%d', tamirVakit = '%d' WHERE tamirID = '%d'",
		Tamirhane[id][Tamirhane_Pos][0], Tamirhane[id][Tamirhane_Pos][1], Tamirhane[id][Tamirhane_Pos][2], Tamirhane[id][Tamirhane_Pos][3],
		Tamirhane[id][Tamirhane_IcPos][0], Tamirhane[id][Tamirhane_IcPos][1], Tamirhane[id][Tamirhane_IcPos][2], Tamirhane[id][Tamirhane_Pos][4],
		Tamirhane[id][Tamirhane_World], Tamirhane[id][Tamirhane_Interior],
		Tamirhane[id][Tamirhane_IcWorld], Tamirhane[id][Tamirhane_IcInterior],
		Tamirhane[id][Tamirhane_Vakit],
		Tamirhane[id][Tamirhane_ID]
	);

	mysql_tquery(g_SQL, query);

	if(opsiyon)
		Tamirhane_Objeler(id);
	return 1;
}

Pump_Closest(playerid, Float: range = 6.0)
{
	new id = -1;

	for(new i = 0; i < MAX_POMPA; i++)
	{
		if(Pompa[i][Pompa_Kontrol])
		{
			if(IsPlayerInRangeOfPoint(playerid, range, Pompa[i][Pompa_Pos][0], Pompa[i][Pompa_Pos][1], Pompa[i][Pompa_Pos][2]))
			{
				id = i;
				break;
			}
		}
	}
	return id;
}

Pompa_Objeler(id, bool:option=true)
{
	if(!Pompa[id][Pompa_Kontrol])
		return 1;

	if(IsValidDynamic3DTextLabel(Pompa[id][Pompa_Yazi]))
	{
		DestroyDynamic3DTextLabel(Pompa[id][Pompa_Yazi]);
		Pompa[id][Pompa_Yazi] = Text3D:INVALID_3DTEXT_ID;
	}

	if(option)
	{
		if(IsValidDynamicObject(Pompa[id][Pompa_Obje]))
		{
			DestroyDynamicObject(Pompa[id][Pompa_Obje]);
			Pompa[id][Pompa_Obje] = INVALID_OBJECT_ID;
		}

		Pompa[id][Pompa_Obje] = CreateDynamicObject(3465, Pompa[id][Pompa_Pos][0], Pompa[id][Pompa_Pos][1], Pompa[id][Pompa_Pos][2], Pompa[id][Pompa_Pos][3], Pompa[id][Pompa_Pos][4], Pompa[id][Pompa_Pos][5], -1, -1, -1, STREAMER_OBJECT_SD, STREAMER_OBJECT_DD, -1, 0);
	}

    new string[128];

	format(string, sizeof(string), "{808080}(%d) Yakýt Pompasý\n\n{2ECC71}%s / Litre\n%s/yakital", id, FormatNumber(GetServerBilgi("BenzinFiyat")), (Pompa[id][Pompa_Kullaniliyor] == 1) ? ("{E74C3C}") : ("{FFFFFF}"));

	Pompa[id][Pompa_Yazi] = CreateDynamic3DTextLabel(string, 0xFFFFFFFF, Pompa[id][Pompa_Pos][0], Pompa[id][Pompa_Pos][1], Pompa[id][Pompa_Pos][2], 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, -1,-1, STREAMER_3D_TEXT_LABEL_SD, -1, 0);
	return 1;
}

Pompa_Kaydet(id, bool:opsiyon=false)
{
	if(!Pompa[id][Pompa_Kontrol])
		return 1;

	new query[220];

	mysql_format(g_SQL, query, sizeof(query), "UPDATE pompalar SET pompaX = '%0.2f', pompaY = '%0.2f', pompaZ = '%0.2f', pompaRX = '%0.2f', pompaRY = '%0.2f', pompaRZ = '%0.2f' WHERE pompaID = '%d'",
		Pompa[id][Pompa_Pos][0], Pompa[id][Pompa_Pos][1], Pompa[id][Pompa_Pos][2],
		Pompa[id][Pompa_Pos][3], Pompa[id][Pompa_Pos][4], Pompa[id][Pompa_Pos][5],
		Pompa[id][Pompa_ID]
	);

	mysql_tquery(g_SQL, query);

	if(opsiyon)
		Pompa_Objeler(id);
	return 1;
}

Pompa_IDBul()
{
	for(new i = 0; i < MAX_POMPA; i++)
	{
		if(!Pompa[i][Pompa_Kontrol])
			return i;
	}
	return -1;
}

Pompa_Olustur(playerid)
{
	if(GetPlayerInterior(playerid) != 0 || GetPlayerVirtualWorld(playerid) != 0)
		return HataMesajGonder(playerid, "Interior veya virtual world deðeriniz 0'dan farklýyken bu fonksiyonu kullanamazsýnýz.");

	if(PlayerData[playerid][pDuzenlenenPompa] != -1)
		return HataMesajGonder(playerid, "Þu anda sistemde benzin pompasý düzenliyor olarak görünüyorsunuz.");

	new id = Pompa_IDBul();

	if(id == -1)
		return HataMesajGonder(playerid, "Daha fazla benzin pompasý oluþturulamaz, limite ulaþýlmýþ.");

	Pompa[id][Pompa_Kontrol] = true;
	Pompa[id][Pompa_Kullaniliyor] = false;

	new Float:x,
		Float:y,
		Float:z,
		Float:ang;

	GetPlayerPos(playerid, x, y, z);
	GetPlayerFacingAngle(playerid, ang);

	x += (2.5 * floatsin(-ang, degrees));
	y += (2.5 * floatcos(-ang, degrees));

	Pompa[id][Pompa_Pos][0] = x;
	Pompa[id][Pompa_Pos][1] = y;
	Pompa[id][Pompa_Pos][2] = z;
	Pompa[id][Pompa_Pos][3] = Pompa[id][Pompa_Pos][4] = 0.0;
	Pompa[id][Pompa_Pos][5] = ang;

	new query[250];

	mysql_format(g_SQL, query, sizeof(query),
		"INSERT INTO pompalar (`pompaX`, `pompaY`, `pompaZ`, `pompaRX`, `pompaRY`, `pompaRZ`, `pompaID`) VALUES ('%0.2f', '%0.2f', '%0.2f', '%0.2f', '%0.2f', '%0.2f', '%d')",
		Pompa[id][Pompa_Pos][0], Pompa[id][Pompa_Pos][1], Pompa[id][Pompa_Pos][2], Pompa[id][Pompa_Pos][3], Pompa[id][Pompa_Pos][4], Pompa[id][Pompa_Pos][5], id);

	mysql_query(g_SQL, query);

	Pompa[id][Pompa_ID] = id;

	Pompa_Kaydet(id, true);

	BilgiMesajGonder(playerid, "Benzin pompasý %d oluþturuldu.", id);

	format(query, sizeof(query), "%d", id);
	callcmd::pompaduzenle(playerid, query);
	return 1;
}

Tamirhane_IDBul()
{
	for(new i = 0; i < MAX_TAMIRHANE; i++)
	{
		if(!Tamirhane[i][Tamirhane_Kontrol])
			return i;
	}
	return -1;
}

Tamirhane_Olustur(playerid, saniye)
{
	new id = Tamirhane_IDBul();

	if(id == -1)
		return HataMesajGonder(playerid, "Daha fazla tamirhane oluþturulamaz, limite ulaþýlmýþ.");

	Tamirhane[id][Tamirhane_Kontrol] = true;
	Tamirhane[id][Tamirhane_Kullaniliyor] = 0;
	Tamirhane[id][Tamirhane_ID] = id;

	new Float:x, Float:y, Float:z, Float:ang;

	GetPlayerPos(playerid, x, y, z);
	GetPlayerFacingAngle(playerid, ang);

	Tamirhane[id][Tamirhane_Pos][0] = x;
	Tamirhane[id][Tamirhane_Pos][1] = y;
	Tamirhane[id][Tamirhane_Pos][2] = z;
	Tamirhane[id][Tamirhane_Pos][3] = ang;

	Tamirhane[id][Tamirhane_Interior] = GetPlayerInterior(playerid);
	Tamirhane[id][Tamirhane_World] = GetPlayerVirtualWorld(playerid);
	Tamirhane[id][Tamirhane_Vakit] = saniye;

	Tamirhane[id][Tamirhane_IcPos][0] = Tamirhane[id][Tamirhane_IcPos][1] = Tamirhane[id][Tamirhane_IcPos][2] = 0.0;
	Tamirhane[id][Tamirhane_IcWorld] = id + 5000;
	Tamirhane[id][Tamirhane_IcInterior] = 0;

	new query[400];

	mysql_format(g_SQL, query, sizeof(query),
		"INSERT INTO tamirhaneler (`tamirX`, `tamirY`, `tamirZ`, `tamirA`, `tamirIcX`, `tamirIcY`, `tamirIcZ`, `tamirID`, `tamirVakit`, `tamirVW`, `tamirInt`, `tamirIcVW`, `tamirIcInt`) VALUES ('%0.2f', '%0.2f', '%0.2f', '%0.2f', '0.0', '0.0', '0.0', '%d', '%d', '%d', '%d', '%d', '%d')",
		x, y, z, ang, id, saniye, Tamirhane[id][Tamirhane_World], Tamirhane[id][Tamirhane_Interior], Tamirhane[id][Tamirhane_IcWorld], Tamirhane[id][Tamirhane_IcInterior]);

	mysql_query(g_SQL, query);

	BilgiMesajGonder(playerid, "Tamirhane %d oluþturuldu. (Saniye: %d)", id, saniye);
	BilgiMesajGonder(playerid, "/tamirduzenle komutuyla iç pozisyonu ayarlamalýsýnýz.");

	Tamirhane_Kaydet(id, true);
	return 1;
}
stock SirketTipIsim(tipx)
{
	new tip[24];

	switch (tipx)
	{
        case 1: tip = "Oyun Stüdyosu";
        case 2: tip = "Film Stüdyosu";
    	case 3: tip = "Otomotiv";
    	default: tip = "Yok";
    }

	return tip;
}

//boþbir yere
stock sirketCEOListele(playerid, sirketid)
{
     new str[1000], string[124], sayi;
     strcat(str, "ID\tIsim\n");
     foreach(new i:Player)
     {
          if(PlayerData[i][pSirket] == sirketid)
          {

               format(string, sizeof(string), "%d\t%s\n", i, ReturnName(i, 0));
               strcat(str, string);
               sayi++;
          }
     }
     if(sayi == 0) return SendClientMessage(playerid, -1, "Þirkette aktif üye yok.");
     Dialog_Show(playerid, SirketUyeler, DIALOG_STYLE_TABLIST_HEADERS, "Þirket - Üyeler", str, "Yap.", "Iptal");
     return 1;
}
stock sirketPozisyonListele(playerid, sirketid)
{
     new str[1000], string[256];
     strcat(str, "Pozisyon\tMaaþ\tÇalýþan\n");
		for(new i; i < 20; i++)
		{
		format(string, sizeof(string), "%s\t{3A9F25}[$%d]{FFFFFF}\t%s\n", sirketPozisyonlar[sirketid][i],sirketMaaslar[sirketid][i],sirketCalisanlar[sirketid][i]);
		strcat(str, string);
		}
     Dialog_Show(playerid, PozisyonUyeler, DIALOG_STYLE_TABLIST_HEADERS, "Þirket - Üyeler", str, "Düzenle", "Iptal");
     return 1;
}
stock sirketUyeListele(playerid, sirketid)
{
     new str[1000], string[124], sayi;
     strcat(str, "ID\tIsim\n");
     foreach(new i:Player)
     {
          if(PlayerData[i][pSirket] == sirketid)
          {

               format(string, sizeof(string), "%d\t%s\n", i, ReturnName(i, 0));
               strcat(str, string);
               sayi++;
          }
     }
     if(sayi == 0) return SendClientMessage(playerid, -1, "Þirkette aktif üye yok.");
     Dialog_Show(playerid, PozisyonUyeler2, DIALOG_STYLE_TABLIST_HEADERS, "Þirket - Üyeler", str, "Yap.", "Iptal");
     return 1;
}
stock sirketGMListele(playerid, sirketid)
{
     new str[1000], string[124], sayi;
     strcat(str, "ID\tIsim\n");
     foreach(new i:Player)
     {
          if(PlayerData[i][pSirket] == sirketid)
          {

               format(string, sizeof(string), "%d\t%s\n", i, ReturnName(i, 0));
               strcat(str, string);
               sayi++;
          }
     }
     if(sayi == 0) return SendClientMessage(playerid, -1, "Þirkette aktif üye yok.");
     Dialog_Show(playerid, GMUyeler, DIALOG_STYLE_TABLIST_HEADERS, "Þirket - Üyeler", str, "Yap.", "Iptal");
     return 1;
}
//MySql sorgularýnýn oraya
Sirket_Sil(sirketid)
{
    if (sirketid != -1 && sirketData[sirketid][sirketExists])
    {
        new
            string[64];

        format(string, sizeof(string), "DELETE FROM `sirketler` WHERE `sirketID` = '%d'", sirketData[sirketid][sirketID]);
        mysql_tquery(g_SQL, string);

        format(string, sizeof(string), "UPDATE `oyuncular` SET `Sirket` = '-1' WHERE `Sirket` = '%d'", sirketData[sirketid][sirketID]);
        mysql_tquery(g_SQL, string);

  foreach (new i : Player)
        {
            if (PlayerData[i][pSirket] == sirketid) {
                PlayerData[i][pSirket] = -1;
                PlayerData[i][pSirketID] = -1;
                PlayerData[i][pSirketRank] = -1;
            }
        }

        sirketData[sirketid][sirketExists] = false;
        sirketData[sirketid][sirketTip] = 0;
        sirketData[sirketid][sirketID] = 0;
    }
    return 1;
}
Sirket_Kaydet(sirketid)
{
    static
        query[4000];

    	format(query, sizeof(query), "UPDATE `sirketler` SET `sirketAd` = '%s',`sirketTip` = '%d', `sirketRank` = '%d', `sirketSahip` = '%s',`sirketVergi` = '%d',`sirketVergiZaman` = '%d', `sirketKasa` = '%d', `sirketCP` = '%d',`sirketCPT` = '%d',`sirketCEO` = '%s',`sirketGM` = '%s',`sirketCalisanlar0` = '%s', `sirketCalisanlar1` = '%s', `sirketCalisanlar2` = '%s',`sirketCalisanlar3` = '%s',`sirketCalisanlar4` = '%s',`sirketCalisanlar5` = '%s',`sirketCalisanlar6` = '%s',`sirketCalisanlar7` = '%s',`sirketCalisanlar8` = '%s',`sirketCalisanlar9` = '%s',`sirketCalisanlar10` = '%s'",
		SQL_ReturnEscaped(sirketData[sirketid][sirketAd]),
		sirketData[sirketid][sirketTip],
        sirketData[sirketid][sirketRank],
        sirketData[sirketid][sirketSahip],
        sirketData[sirketid][sirketVergi],
        sirketData[sirketid][sirketVergiZaman],
        sirketData[sirketid][sirketKasa],
        sirketData[sirketid][sirketCP],
        sirketData[sirketid][sirketCPT],
        sirketData[sirketid][sirketCEO],
        sirketData[sirketid][sirketGM],
        sirketCalisanlar[sirketid][0],
        sirketCalisanlar[sirketid][1],
        sirketCalisanlar[sirketid][2],
        sirketCalisanlar[sirketid][3],
        sirketCalisanlar[sirketid][4],
        sirketCalisanlar[sirketid][5],
      	sirketCalisanlar[sirketid][6],
        sirketCalisanlar[sirketid][7],
        sirketCalisanlar[sirketid][8],
        sirketCalisanlar[sirketid][9],
        sirketCalisanlar[sirketid][10]
   		 );
	format(query, sizeof(query), "%s WHERE `sirketID` = '%d'",query,sirketData[sirketid][sirketID]);
    return mysql_tquery(g_SQL, query);
}

stock Sirket_Ad(playerid)
{
	new isim[32];

	isim = "Yok";

	new sirketid = PlayerData[playerid][pSirket];

	if(sirketid >= 0)
		format(isim, sizeof(isim), "%s", sirketData[sirketid][sirketAd]);

	return isim;
}

Sirket_Olustur(name[], type)
{
    for (new i = 0; i != MAX_SIRKET; i ++) if (!sirketData[i][sirketExists])
    {
        format(sirketData[i][sirketAd], 32, "%s", name);

        sirketData[i][sirketExists] = true;
        sirketData[i][sirketTip] = type;
        sirketData[i][sirketRank] = 5;
        sirketData[i][sirketCP] = 0;
        sirketData[i][sirketKasa] = 0;
        format(sirketData[i][sirketCEO], 24, "");
        format(sirketData[i][sirketGM], 24, "");

        if(sirketData[i][sirketTip] < 3)    {
        sirketData[i][sirketCPT] = 960;
        }
        if(sirketData[i][sirketTip] == 1)
        {
        sirketPozisyonlar[i][0] = "Yazýlým Müdürü";
        sirketPozisyonlar[i][1] = "Yazýlým Mühendisi";
        sirketPozisyonlar[i][2] = "Yazýlým Mühendisi";
        sirketPozisyonlar[i][3] = "Harita Tasarýmcýsý";
        sirketPozisyonlar[i][4] = "Harita Tasarýmcýsý";
        sirketPozisyonlar[i][5] = "Pazarlama Sorumlusu";
        sirketPozisyonlar[i][6] = "Animatör";
        sirketPozisyonlar[i][7] = "Animatör";
        sirketPozisyonlar[i][8] = "Animatör";
        sirketPozisyonlar[i][9] = "Editör";
        sirketPozisyonlar[i][10] = "Grafik Tasarýmcýsý";
       	sirketPozisyonlar[i][11] = "Senarist";
        sirketPozisyonlar[i][12] = "Yardýmcý Senarist";
        sirketPozisyonlar[i][13] = "Level Tasarýmcýsý";
        sirketPozisyonlar[i][14] = "Donaným Yöneticisi";
        sirketPozisyonlar[i][15] = "Biliþim Teknolojileri Uzmaný";
        sirketPozisyonlar[i][16] = "3D Modelleme Uzmaný";
        sirketPozisyonlar[i][17] = "3D Modelleme Uzmaný";
        sirketPozisyonlar[i][18] = "3D Modelleme Uzmaný";
        sirketPozisyonlar[i][19] = "3D Modelleme Uzmaný";
        sirketMaaslar[i][0] = 300;
        sirketMaaslar[i][1] = 300;
        sirketMaaslar[i][2] = 300;
        sirketMaaslar[i][3] = 300;
        sirketMaaslar[i][4] = 300;
        sirketMaaslar[i][5] = 300;
        sirketMaaslar[i][6] = 300;
        sirketMaaslar[i][7] = 300;
        sirketMaaslar[i][8] = 300;
        sirketMaaslar[i][9] = 300;
        sirketMaaslar[i][10] = 300;
       	sirketMaaslar[i][11] = 300;
        sirketMaaslar[i][12] =	300;
        sirketMaaslar[i][13] = 300;
        sirketMaaslar[i][14] = 300;
        sirketMaaslar[i][15] = 300;
        sirketMaaslar[i][16] = 300;
        sirketMaaslar[i][17] = 300;
        sirketMaaslar[i][18] = 300;
        sirketMaaslar[i][19] = 300;
        sirketCalisanlar[i][0] = "Yok";
        sirketCalisanlar[i][1] = "Yok";
        sirketCalisanlar[i][2] = "Yok";
        sirketCalisanlar[i][3] = "Yok";
        sirketCalisanlar[i][4] = "Yok";
        sirketCalisanlar[i][5] = "Yok";
        sirketCalisanlar[i][6] = "Yok";
        sirketCalisanlar[i][7] = "Yok";
        sirketCalisanlar[i][8] = "Yok";
        sirketCalisanlar[i][9] = "Yok";
        sirketCalisanlar[i][10] = "Yok";
       	sirketCalisanlar[i][11] = "Yok";
        sirketCalisanlar[i][12] = "Yok";
        sirketCalisanlar[i][13] = "Yok";
        sirketCalisanlar[i][14] = "Yok";
        sirketCalisanlar[i][15] = "Yok";
        sirketCalisanlar[i][16] = "Yok";
        sirketCalisanlar[i][17] = "Yok";
        sirketCalisanlar[i][18] = "Yok";
        sirketCalisanlar[i][19] = "Yok";
        }
        mysql_tquery(g_SQL, "INSERT INTO `sirketler` SET `sirketTip` = '5'", "SirketOlusturuldu", "d", i);
        return i;
    }
    return -1;
}

stock DogrulandiMesaj(const isim[])
{
	new DCC_Embed:ixd = DCC_CreateEmbed(), str[300], gonderen[64];

	format(gonderen, sizeof(gonderen), "**%s**", isim);

	DCC_SetEmbedColor(ixd, 3066993);

	format(str, sizeof(str), "Discord hesabiniz oyun hesabinizla baglandi! Her saat basi gelen EXP'yi almak icin /discord ekranini kullanin.");
	DCC_AddEmbedField(ixd, trcar(gonderen), trcar(str));
	DCC_SendChannelEmbedMessage(DCC_FindChannelByName(BOT_KANAL), ixd);

	return 1;
}

stock HataliMesaj()
{
	new DCC_Embed:ixd = DCC_CreateEmbed(), str[300];

	DCC_SetEmbedColor(ixd, 15158332);

	format(str, sizeof(str), "Gecersiz kod girisi yaptiniz.");
	DCC_AddEmbedField(ixd, "HATA", trcar(str));
	DCC_SendChannelEmbedMessage(DCC_FindChannelByName(BOT_KANAL), ixd);

	return 1;
}

stock DCMesaj(kanal[], const mesaj[])
{
    return DCC_SendChannelMessage(DCC_FindChannelByName(kanal), mesaj);
}

stock TSPanel(playerid)
{
	new id = TSC_GetClientIdByIpAddress(GetIP(playerid));

	if(id > 0)
	{
		SetPVarInt(playerid, "TS_Client", id);

		new str[256];

		format(str, sizeof(str), "Rahatsýz etmeyin modunu aktifleþtir\nRahatsýz etmeyin modunu kapat\n");

		if(PlayerData[playerid][pVip] > 0)
			format(str, sizeof(str), "%sVIP odasý oluþtur\n", str);



			format(str, sizeof(str), "%sBirlik odasý oluþtur\n", str);

		Dialog_Show(playerid, Teamspeak, DIALOG_STYLE_LIST, "Teamspeak", str, "Seç", "Kapat");
	}

	return 1;
}

stock trduzelt(mesaj[])
{
	new tmp[1024];
	format(tmp, sizeof(tmp), "%s", mesaj);

	strreplace(tmp, "ð","g");
	strreplace(tmp, "Ð","G");
	strreplace(tmp, "þ","s");
	strreplace(tmp, "Þ","S");
	strreplace(tmp, "ý","i");
	strreplace(tmp, "Ý","I");
	strreplace(tmp, "ö","o");
	strreplace(tmp, "Ö","O");
	strreplace(tmp, "ç","c");
	strreplace(tmp, "Ç","C");
	strreplace(tmp, "ü","u");
	strreplace(tmp, "Ü","U");

  	return tmp;
}

stock DiscordEXPVer(id)
{
	new query[59 + 11 + 11 + 1];

	format(query, sizeof(query), "UPDATE oyuncular SET discord_exp = discord_exp + 1 WHERE ID = '%d'", id);
	mysql_query(g_SQL, query, false);

	return 1;
}
HasarBolge(bolge)
{
	new string[24];
	switch (bolge)
	{
	    case 3: format(string, 24, "Karýn");
	    case 4: format(string, 24, "Çatal");
	    case 5: format(string, 24, "Sol El");
	    case 6: format(string, 24, "Sað El");
	    case 7: format(string, 24, "Sol Ayak");
	    case 8: format(string, 24, "Sað Ayak");
	    case 9: format(string, 24, "Kafa");
	}
	return string;
}
ResetPlayerDamages(playerid)
{
	for (new i; i<MAX_HASAR; i++)
	{
	    Hasarlar[playerid][i][hasarVarmi] = false;
	    Hasarlar[playerid][i][hasarBolge] = 0;
	    Hasarlar[playerid][i][hasarVeren] = -1;
     	Hasarlar[playerid][i][hasarDeger] = 0.0;
      	Hasarlar[playerid][i][hasarSilah] = 0;
	}
	return 1;
}
Hasar_Ekle(playerid, bodypart, Float:hasar, hasarveren, silahid)
{

	for (new i = 0; i != MAX_HASAR; i ++)
	{
	    if (!Hasarlar[playerid][i][hasarVarmi])
	    {
			Hasarlar[playerid][i][hasarVarmi] = true;
		    Hasarlar[playerid][i][hasarBolge] = bodypart;
		    Hasarlar[playerid][i][hasarVeren] = hasarveren;
            Hasarlar[playerid][i][hasarDeger] = hasar;
            Hasarlar[playerid][i][hasarSilah] = silahid;
			return i;
		}
	}
	return -1;
}

GetNearestCCTV(playerid)
{
	foreach (new i:CCTVIter)
	{
		if (IsPlayerInRangeOfPoint(playerid, 50.0, CCTVInfo[i][cctv_X],CCTVInfo[i][cctv_Y], CCTVInfo[i][cctv_Z]))
		{
			return i;
		}
	}
	return -1;
}

GetServerBilgi(str[])
{
	new query[150];

	format(query, sizeof(query), "SELECT `%s` FROM `server`", str);

	new Cache:cachee = mysql_query(g_SQL, query);

	new rows;

	cache_get_row_count(rows);

	if (!rows)
		return -1;

	new degisken;
	cache_get_value_name_int(0, str, degisken);

	cache_delete(cachee);
	return degisken;
}

SetServerBilgi(str[], deger)
{
	new query[150];
	format(query, sizeof(query), "UPDATE `server` SET `%s` = '%d'", str, deger);
	mysql_tquery(g_SQL, query);
	return 1;
}

SetServerBilgiStr(str[], yazi[])
{
	new query[200];
	format(query, sizeof(query), "UPDATE `server` SET `%s` = '%s'", str, yazi);
	mysql_tquery(g_SQL, query);
	return 1;
}

GetServerBilgiStr(str[])
{
	new query[300];
	format(query, sizeof(query), "SELECT `%s` FROM `server`", str);
	new Cache:cachee = mysql_query(g_SQL, query);
	new rows;
	cache_get_row_count(rows);
	new yazi[100];
	yazi = "Hata";
	if (rows)
	{
		cache_get_value_name(0, str, yazi, 100);
		cache_delete(cachee);
	}
	return yazi;
}

PlayerPlaySoundEx(playerid, sound)
{
	new
	    Float:x,
	    Float:y,
	    Float:z;

	GetPlayerPos(playerid, x, y, z);

	foreach (new i : Player) if (IsPlayerInRangeOfPoint(i, 20.0, x, y, z)) {
	    PlayerPlaySound(i, sound, x, y, z);
	}
	return 1;
}
IsPlayerInsideTaxi(playerid)
{
	new vehicleid = GetPlayerVehicleID(playerid);
	new id = Car_GetID(vehicleid);
	if (id == -1) return 0;
	new bool:musterivar, bool:taksicivar;
	if (GetVehicleModel(vehicleid) == 420 || AracInfo[id][TaksiPlaka] == 1)
	{
     	foreach (new i : Player)
		{
		    if (i != playerid && PlayerData[i][pTaxiDuty] == false && GetPlayerVehicleID(i) == vehicleid && GetPlayerVehicleSeat(i) != 0) musterivar = true;
			if ((i != playerid) && (PlayerData[i][pTaxiDuty] == true && GetPlayerState(i) == PLAYER_STATE_DRIVER) && GetPlayerVehicleID(i) == vehicleid) taksicivar = true;
		}
	}
	if (musterivar == false && taksicivar == true) return 1;
	else return 0;
}
// ************************************************************************************************************************************************************
// Kar Sistemi ( By ForumSA:MPliDayý )
// ************************************************************************************************************************************************************
CB:UpdateSnow(playerid)
{
	if(!snowOn{playerid}) return 0;
	new Float:pPos[3];
	GetPlayerPos(playerid, pPos[0], pPos[1], pPos[2]);
	for(new i = 0; i < MAX_SNOW_OBJECTS; i++) SetDynamicObjectPos(snowObject[playerid][i], pPos[0] + random(25), pPos[1] + random(25), pPos[2] - 5 + random(10));
	return 1;
}

stock CreateSnow(playerid)
{
	if(snowOn{playerid}) return 0;
	new Float:pPos[3];
	GetPlayerPos(playerid, pPos[0], pPos[1], pPos[2]);
	for(new i = 0; i < MAX_SNOW_OBJECTS; i++) snowObject[playerid][i] = CreateDynamicObject(18864, pPos[0] + random(25), pPos[1] + random (25), pPos[2] - 5 + random(10), random(280), random(280), 0, -1, -1, playerid);
	snowOn{playerid} = true;
	updateTimer{playerid} = SetTimerEx("UpdateSnow", UPDATE_INTERVAL, true, "i", playerid);
	return 1;
}

stock DeleteSnow(playerid)
{
	if(!snowOn{playerid}) return 0;
	for(new i = 0; i < MAX_SNOW_OBJECTS; i++) DestroyDynamicObject(snowObject[playerid][i]);
	KillTimer(updateTimer{playerid});
	snowOn{playerid} = false;
	return 1;
}
forward KodDogrulama(playerid);
public KodDogrulama(playerid)
{
	new koddogru[64];
	format(koddogru, RandomEx(100000, 999999));

	return 1;
}

//Fonksiyonlar
