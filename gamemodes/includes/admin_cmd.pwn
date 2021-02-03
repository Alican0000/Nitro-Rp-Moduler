CMD:kodekle(playerid, params[])
{
    if (!OyundaDegil(playerid)) return 1;
    if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
	new kod[20], para;
	if (sscanf(params, "is[20]", para, kod)) return KullanimMesajGonder(playerid, "/kodekle [Para] [Kod]");
	new query[128];
	mysql_format(g_SQL, query, sizeof(query), "SELECT * FROM `kuponlar` WHERE `kod` = '%e'", kod);
	new Cache:Radless = mysql_query(g_SQL, query);
	if (cache_num_rows())
	{
		HataMesajGonder(playerid, "Bu kupon kodu zaten bulunuyor.");
	}
	else
	{
		mysql_format(g_SQL, query, sizeof(query), "INSERT INTO `kuponlar` (`kod`, `para`) VALUES ('%e', '%d')", kod, para);
		mysql_tquery(g_SQL, query);
		MesajGonder(playerid, "Kupon kodu olu�turuldu.");
	}
	cache_delete(Radless);
	return 1;
}
CMD:kodsil(playerid, params[])
{
    if (!OyundaDegil(playerid)) return 1;
    if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
	new kod[20];
	if (sscanf(params, "s[20]", kod)) return KullanimMesajGonder(playerid, "/kodsil [Kod]");
	new query[128];
	mysql_format(g_SQL, query, sizeof(query), "SELECT * FROM `kuponlar` WHERE `kod` = '%e'", kod);
	new Cache:Radless = mysql_query(g_SQL, query);
	if (cache_num_rows())
	{
		mysql_format(g_SQL, query, sizeof(query), "DELETE FROM `kuponlar` WHERE `kod` = '%e'", kod);
		mysql_tquery(g_SQL, query);
		MesajGonder(playerid, "Hediye kuponu silindi.");
	}else
	{
		HataMesajGonder(playerid, "B�yle bir kod yok.");
	}
	cache_delete(Radless);
	return 1;
}
CMD:setadmin(playerid,params[])
{
	new id,level;
	if (!OyundaDegil(playerid)) return 1;
    if (PlayerData[playerid][pAdmin] < 5) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
    if (sscanf(params, "ui",id,level)) return KullanimMesajGonder(playerid, "/setadmin [ID/Isim] [Level]");
    if (!OyundaDegil(id)) return HataMesajGonder(playerid, "Oyuncu giri� yapmam��.");
    if (level < 0 || level > 5) return HataMesajGonder(playerid, "Level 0'dan k���k, 5'den fazla olamaz.");
    SendAdminAction(id, "%s Adl� yetkili taraf�ndan %d seviye yetkili oldunuz.",PlayerData[playerid][pAdminName],level);
    SendAdminAction(playerid, "%s Adl� oyuncuyu %d seviye yetkili yapt�n�z.",ReturnName(id),level);
    if (level == 0)
    {
        if (PlayerData[id][pAdminDuty] == 1)
        {
            callcmd::aduty(id);
        }
	}
    PlayerData[id][pAdmin] = level;
    PlayerData[id][pHelper] = 0;
    Log_Write("logs/admin-log.log", "[%s] %s Adli Admin %s Adli oyuncuyu %d seviye yetkili yapti.",ReturnDate(),ReturnName(playerid),ReturnName(id),level);
	return 1;
}

CMD:ogyap(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 5)
		return HataMesajGonder(playerid, "Yeterli yetkiniz yok.");

	new oyuncuid;

	if(sscanf(params, "u", oyuncuid))
		return KullanimMesajGonder(playerid, "/ogyap [karakter id/isim]");

	switch(PlayerData[oyuncuid][pOyunGorevlisi])
	{
		case false:
		{
			SendAdminAction(oyuncuid, "%s, adl� yetkili taraf�ndan oyun g�revlisi yap�ld�n�z.", ReturnName(playerid));
			SendAdminAction(playerid, "%s, ki�isini oyun g�revlisi yapt�n�z.", ReturnName(oyuncuid));

			PlayerData[oyuncuid][pOyunGorevlisi] = 1;
		}

		default:
		{
			SendAdminAction(oyuncuid, "%s, adl� yetkili taraf�ndan oyun g�revlisi yetkiniz al�nd�.", ReturnName(playerid));
			SendAdminAction(playerid, "%s, ki�isinin oyun g�revlisi yetkisini ald�n�z.", ReturnName(oyuncuid));

			PlayerData[oyuncuid][pOyunGorevlisi] = 0;
		}
	}

	return 1;
}

CMD:fgyap(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 5)
		return HataMesajGonder(playerid, "Yeterli yetkiniz yok.");

	new oyuncuid;

	if(sscanf(params, "u", oyuncuid))
		return KullanimMesajGonder(playerid, "/fgyap [karakter id/isim]");

	switch(PlayerData[oyuncuid][pForumGorevlisi])
	{
		case false:
		{
   			SendAdminAction(oyuncuid, "%s, adl� yetkili taraf�ndan forum g�revlisi yap�ld�n�z.", ReturnName(playerid));
			SendAdminAction(playerid, "%s, ki�isini forum g�revlisi yapt�n�z.", ReturnName(oyuncuid));

			PlayerData[oyuncuid][pForumGorevlisi] = 1;
		}

		default:
		{
   			SendAdminAction(oyuncuid, "%s, adl� yetkili taraf�ndan forum g�revlisi yetkiniz al�nd�.", ReturnName(playerid));
			SendAdminAction(playerid, "%s, ki�isinin forum g�revlisi yetkisini ald�n�z.", ReturnName(oyuncuid));

			PlayerData[oyuncuid][pForumGorevlisi] = 0;
		}
	}

	return 1;
}

CMD:setyoutuber(playerid, params[])
{
	new id;
    if (!OyundaDegil(playerid)) return 1;
    if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
    if (sscanf(params, "u",id)) return KullanimMesajGonder(playerid, "/setyoutuber [ID/Isim]");
    if (!OyundaDegil(id)) return HataMesajGonder(playerid, "Oyuncu giri� yapmam��.");
    if (PlayerData[id][pYoutuber] == 0)
    {
        PlayerData[id][pYoutuber] = 1;
        MesajGonder(playerid, "%s adl� ki�iye Youtuber & Streamer yetkisi verdiniz.", Player_GetName(id));
        BilgiMesajGonder(id, "%s adl� yetkili size Youtuber & Streamer yetkisi verdi. (/ytag)", PlayerData[playerid][pAdminName]);
    }
    else
    {
        PlayerData[id][pYoutuber] = 0;
        PlayerData[id][pYoutuberTag] = false;
        MesajGonder(playerid, "%s adl� ki�inin Youtuber & Streamer yetkisini sildiniz.", Player_GetName(id));
        BilgiMesajGonder(id, "%s adl� yetkili taraf�ndan Youtuber & Streamer yetkiniz silindi.", PlayerData[playerid][pAdminName]);
	}
	return 1;
}
CMD:sethelper(playerid,params[])
{
	new id,level;
	if (!OyundaDegil(playerid)) return 1;
    if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
    if (sscanf(params, "ui",id,level)) return KullanimMesajGonder(playerid, "/sethelper [ID/Isim] [Level]");
    if (!OyundaDegil(id)) return HataMesajGonder(playerid, "Oyuncu giri� yapmam��.");
    if (level < 0 || level > 5) return HataMesajGonder(playerid, "Level 0'dan k���k, 5'den fazla olamaz.");
    SendAdminAction(id, "%s Adl� yetkili taraf�ndan %d seviye helper oldunuz.",PlayerData[playerid][pAdminName],level);
    SendAdminAction(playerid, "%s Adl� oyuncuyu %d seviye helper yapt�n�z.",ReturnName(id),level);
    if (level == 0)
    {
        if (PlayerData[id][pHelperDuty] == 1)
        {
            callcmd::hduty(id);
        }
	}
    PlayerData[id][pHelper] = level;
    PlayerData[id][pAdmin] = 0;
    Log_Write("logs/admin-log.log", "[%s] %s Adli Admin %s Adli oyuncuyu %d seviye helper yapti.",ReturnDate(),ReturnName(playerid),ReturnName(id),level);
	return 1;
}
CMD:binaekle(playerid, params[])
{
    if (PlayerData[playerid][pAdmin] < 3)
        return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

    if (isnull(params) || strlen(params) > 32)
        return KullanimMesajGonder(playerid, "/binaekle [ad]");

    new id = Entrance_Create(playerid, params);

    if (id == -1)
        return HataMesajGonder(playerid, "Sunucu bina s�n�r�na ula�m��t�r.");

    MesajGonder(playerid, "Ba�ar�yla bina olu�turdun, ID: %d.", id);
    return 1;
}
CMD:ciftlikolustur(playerid, params[])
{
	new tip, metrekare, fiyat, maxtohum;
    if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
    if (sscanf(params, "iiii", tip, metrekare, fiyat, maxtohum)) return KullanimMesajGonder(playerid, "/ciftlikolustur [Tip 1 - Sat�l�k 2 - Kiral�k] [D�n�m] [Fiyat] [Max Hayvan]");
    if (tip < 1 || tip > 2) return HataMesajGonder(playerid, "Ge�ersiz tip girdiniz, 1 veya 2 olmal�d�r.");
    if (metrekare < 10 || metrekare > 100) return HataMesajGonder(playerid, "D�n�m 10 ile 100 aras�nda olmal�d�r.");

    new id = Arsa_Olustur(playerid, tip, metrekare, fiyat, maxtohum);
    if (id == -1) return HataMesajGonder(playerid, "Sunucuda daha fazla �iftlik olu�turulamaz.");
    MesajGonder(playerid, "�iftlik olu�turuldu, ID: %d.", id);
	return 1;
}
CMD:ciftliksil(playerid, params[])
{
    if (!OyundaDegil(playerid)) return 1;
    if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
    new id;
    if (sscanf(params, "i", id)) return KullanimMesajGonder(playerid, "/ciftliksil [ID]");
    if ((id < 0 || id >= MAX_ARSA) || !ArsaBilgi[id][arsaExists]) return HataMesajGonder(playerid, "Ge�ersiz ID.");
    Arsa_Sil(id);
    MesajGonder(playerid, "�iftlik silindi");
	return 1;
}
CMD:ciftlikduzenle(playerid, params[])
{
    if (!OyundaDegil(playerid)) return 1;
    if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
    static
        id,
        type[24],
        string[128];

    if (sscanf(params, "ds[24]S()[128]", id, type, string))
    {
        KullanimMesajGonder(playerid, "/ciftlikduzenle [ID] [Ayar]");
        return SendClientMessage(playerid, COLOR_PINK, "[AYARLAR]: {FFFFFF}tip, pozisyon, fiyat, maxhayvan, donum");
    }
    if ((id < 0 || id >= MAX_ARSA) || !ArsaBilgi[id][arsaExists]) return HataMesajGonder(playerid, "Ge�ersiz ID girdiniz.");
    if (!strcmp(type, "tip", true))
    {
        if (isnull(string)) return KullanimMesajGonder(playerid, "/ciftlikduzenle [ID] [tip] [1 - Sat�l�k 2 - Kiral�k]");
        if (strval(string) < 1 || strval(string) > 2) return HataMesajGonder(playerid, "Ge�ersiz tip.");
        ArsaBilgi[id][arsaTip] = strval(string);
        Arsa_Kaydet(id);
        ArsaUpdate(id);
        return 1;
    }
    if (!strcmp(type, "pozisyon", true))
    {
        GetPlayerPos(playerid, ArsaBilgi[id][arsaPos][0], ArsaBilgi[id][arsaPos][1], ArsaBilgi[id][arsaPos][2]);
        Arsa_Kaydet(id);
        ArsaUpdate(id);
        return 1;
    }
    if (!strcmp(type, "fiyat", true))
    {
        if (isnull(string)) return KullanimMesajGonder(playerid, "/ciftlikduzenle [ID] [fiyat] [Fiyat]");
        ArsaBilgi[id][arsaFiyat] = strval(string);
        Arsa_Kaydet(id);
        ArsaUpdate(id);
        return 1;
    }
    if (!strcmp(type, "maxhayvan", true))
    {
        if (isnull(string)) return KullanimMesajGonder(playerid, "/ciftlikduzenle [ID] [maxhayvan] [Hayvan Kapasitesi]");
        ArsaBilgi[id][arsaMaxTohum] = strval(string);
        Arsa_Kaydet(id);
        ArsaUpdate(id);
        return 1;
    }
    if (!strcmp(type, "donum", true))
    {
        if (isnull(string)) return KullanimMesajGonder(playerid, "/ciftlikduzenle [ID] [metrekare] [D�n�m]");
        ArsaBilgi[id][Metrekare] = strval(string);
        Arsa_Kaydet(id);
        ArsaUpdate(id);
        return 1;
    }
	return 1;
}
CMD:npcekle(playerid)
{
    if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
    for (new i; i<MAXIMUM_NPC; i++) if (NPCBilgi[i][npcExists] == false)
    {
        NPCBilgi[i][npcExists] = true;
        NPCBilgi[i][npcID] = i;

        format(NPCBilgi[i][npcAd], 24, "Yok");

        NPCBilgi[i][npcSkin] = 1;

		GetPlayerPos(playerid, NPCBilgi[i][npcPos][0], NPCBilgi[i][npcPos][1], NPCBilgi[i][npcPos][2]);
        GetPlayerFacingAngle(playerid, NPCBilgi[i][npcPos][3]);

		NPCBilgi[i][npcVw] = GetPlayerVirtualWorld(playerid);

		NPCSecenekler[i][0] = "Yok";
		NPCSecenekler[i][1] = "Yok";
        NPCSecenekler[i][2] = "Yok";
        NPCSecenekler[i][3] = "Yok";
        NPCSecenekler[i][4] = "Yok";

		NPCSecenekCevaplar[i][0] = "Yok";
        NPCSecenekCevaplar[i][1] = "Yok";
        NPCSecenekCevaplar[i][2] = "Yok";
        NPCSecenekCevaplar[i][3] = "Yok";
        NPCSecenekCevaplar[i][4] = "Yok";

		new query[256];

		mysql_format(g_SQL, query, sizeof query, "INSERT INTO `npcler` (`npcID`) VALUES ('%d')", i);
		mysql_query (g_SQL, query);

        MesajGonder(playerid, "NPC Eklendi, (/npcduzenle) komutu ile d�zenleyebilirsiniz. (ID: %d)", i);

        NPC_Refresh(i);
		NPC_Save(i);
		return 1;
    }
    HataMesajGonder(playerid, "Sunucu maksimum NPC limitine ula�m��t�r.");
	return 1;
}
CMD:npcduzenle(playerid, params[])
{
    static
        id,
        type[24],
        string[128];

    if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
    if (sscanf(params, "ds[24]S()[128]", id, type, string))
    {
        KullanimMesajGonder(playerid, "/npcduzenle [ID] [Ayar]");
        return SendClientMessage(playerid, COLOR_PINK, "[AYARLAR]: {FFFFFF}ad, pozisyon, skin, secenekler");
    }
    if ((id < 0 || id >= MAXIMUM_NPC) || !NPCBilgi[id][npcExists]) return HataMesajGonder(playerid, "Ge�ersiz ID girdiniz.");
    if (!strcmp(type, "ad", true))
    {
        new name[32];

        if (sscanf(string, "s[32]", name))
            return KullanimMesajGonder(playerid, "/npcduzenle [id] [ad] [yeni ad]");

        format(NPCBilgi[id][npcAd], 24, name);

        NPC_Refresh(id);
        NPC_Save(id);
    }
    if (!strcmp(type, "pozisyon", true))
    {
        GetPlayerPos(playerid, NPCBilgi[id][npcPos][0], NPCBilgi[id][npcPos][1], NPCBilgi[id][npcPos][2]);
        GetPlayerFacingAngle(playerid, NPCBilgi[id][npcPos][3]);
        NPCBilgi[id][npcVw] = GetPlayerVirtualWorld(playerid);

        NPC_Refresh(id);
        NPC_Save(id);
    }
    if (!strcmp(type, "skin", true))
    {
        new skin;
        if (sscanf(string, "d", skin)) return KullanimMesajGonder(playerid, "/npcduzenle [id] [skin] [Skin ID]");
        if (skin < 1 || skin > 311) return HataMesajGonder(playerid, "Ge�ersiz Skin ID.");
        NPCBilgi[id][npcSkin] = skin;
        NPC_Refresh(id);
        NPC_Save(id);
    }
    if (!strcmp(type, "secenekler", true))
    {
        NPC_Secenekler(playerid, id);
    }
	return 1;
}
CMD:npcsil(playerid, params[])
{
	new id;
    if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
    if (sscanf(params, "i", id)) return KullanimMesajGonder(playerid, "/npcsil [ID]");
    if ((id < 0 || id >= MAXIMUM_NPC) || NPCBilgi[id][npcExists] == false) return HataMesajGonder(playerid, "Ge�ersiz ID.");
    DestroyDynamic3DTextLabel(NPCBilgi[id][npcLabel]);
    DestroyDynamicActor(NPCBilgi[id][npcActor]);
    new query[124];
    format(query, sizeof(query), "DELETE FROM `npcler` WHERE `npcID` = '%d'", NPCBilgi[id][npcID]);
    mysql_query(g_SQL, query, false);
    MesajGonder(playerid, "NPC Silindi, ID: %d", id);
	return 1;
}
CMD:gotopos(playerid,params[])
{
	new intid,Float:pos[3];
	if (!OyundaDegil(playerid)) return 1;
	if (PlayerData[playerid][pAdmin] < 1 && !PlayerData[playerid][pOyunGorevlisi]) return HataMesajGonder(playerid, "Bu komutu kullanmak i�in yetkiniz yok");
	if (PlayerData[playerid][pBaygin] == 1) return HataMesajGonder(playerid, "Bunu �u an yapamazs�n�z.");
	if (sscanf(params, "ifff",intid,pos[0],pos[1],pos[2])) return KullanimMesajGonder(playerid, "/gotopos [INT ID] [X] [Y] [Z]");
    PlayerData[playerid][pLegalTeleport] = gettime() + 2;
	Spawned[playerid] = 0;
	SetPlayerInterior(playerid,intid);
	SetPlayerPos(playerid,pos[0],pos[1],pos[2]);
	Spawned[playerid] = 1;
	return 1;
}
CMD:x(playerid, params[])
{
    new Float:posx, Float:posy, Float:posz, Float:npos;
    if (PlayerData[playerid][pAdmin] >= 1)
    {
        PlayerData[playerid][pLegalTeleport] = gettime() + 2;
		if (sscanf(params, "f", npos)) return KullanimMesajGonder(playerid, "/x [Kordinat]");
        GetPlayerPos(playerid, posx, posy, posz);
        SetPlayerPos(playerid, posx+npos, posy, posz);
        return 1;
    }
    else return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
}
CMD:y(playerid, params[])
{
    new Float:posx, Float:posy, Float:posz, Float:npos;
    if (PlayerData[playerid][pAdmin] >= 1)
    {
        PlayerData[playerid][pLegalTeleport] = gettime() + 2;
		if (sscanf(params, "f", npos)) return KullanimMesajGonder(playerid, "/y [Kordinat]");
        GetPlayerPos(playerid, posx, posy, posz);
        SetPlayerPos(playerid, posx, posy+npos, posz);
        return 1;
    }
    else return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
}
CMD:z(playerid, params[])
{
    new Float:posx, Float:posy, Float:posz, Float:npos;
    if (PlayerData[playerid][pAdmin] >= 1)
    {
        PlayerData[playerid][pLegalTeleport] = gettime() + 2;
   	    if (sscanf(params, "f", npos)) return KullanimMesajGonder(playerid, "/z [Kordinat]");
        GetPlayerPos(playerid, posx, posy, posz);
        SetPlayerPos(playerid, posx, posy, posz+npos);
        return 1;
    }
    else return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
}
CMD:binaduzenle(playerid, params[])
{
    static
        id,
        type[24],
        string[128];

    if (PlayerData[playerid][pAdmin] < 3)
        return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

    if (sscanf(params, "ds[24]S()[128]", id, type, string))
    {
        KullanimMesajGonder(playerid, "/binaduzenle [id] [Parametre]");
        SendClientMessage(playerid, COLOR_PINK, "[PARAMETRELER]:{FFFFFF} pozisyon, interior, sifre, isim, kilit, mapicon, icon, vw, garajbaglanti, vip");
        return 1;
    }
    if ((id < 0 || id >= MAX_ENTRANCES) || !EntranceData[id][entranceExists])
        return HataMesajGonder(playerid, "Ge�ersiz ID girdiniz.");

	if (!strcmp(type, "icon", true))
	{
	    new icon;

	    if (sscanf(string, "d", icon))
	        return KullanimMesajGonder(playerid, "/binaduzenle [id] [icon]");

	    EntranceData[id][entrancepIcon] = icon;

        Entrance_Refresh(id);
		Entrance_Save(id);
	}
	if (!strcmp(type, "vw", true))
	{
	    new vw;
	    if (sscanf(string, "d", vw))
            return KullanimMesajGonder(playerid, "/binaduzenle [id] [vw] [Vw] (-1 yazarsan�z otomatik virtual world ayarlan�r)");

        EntranceData[id][entranceInteriorVw] = vw;
        Entrance_Save(id);
	}
	if (!strcmp(type, "garajbaglanti", true))
	{
	    new garaj;
	    if (sscanf(string, "d", garaj))
            return KullanimMesajGonder(playerid, "/binaduzenle [id] [garajbaglanti] [Garaj ID] (-1 yazarsan�z hi�bir garaj ile ba�lant�s� olmaz)");
        if ((garaj < 0 || garaj >= MAX_GARAGE) || !GarageData[garaj][gExists])
	    return HataMesajGonder(playerid, "Hatal� garaj ID girdiniz.");

        EntranceData[id][entranceBaglanti] = garaj;
        Entrance_Save(id);
	}
    if (!strcmp(type, "pozisyon", true))
    {
        GetPlayerPos(playerid, EntranceData[id][entrancePos][0], EntranceData[id][entrancePos][1], EntranceData[id][entrancePos][2]);
        GetPlayerFacingAngle(playerid, EntranceData[id][entrancePos][3]);

        EntranceData[id][entranceExterior] = GetPlayerInterior(playerid);
        EntranceData[id][entranceExteriorVW] = GetPlayerVirtualWorld(playerid);

        Entrance_Refresh(id);
        Entrance_Save(id);

        AdminMessage(COLOR_LIGHTRED, "*** %s adl� yetkili %d ID'li binan�n pozisyonunu de�i�tirdi.", PlayerData[playerid][pAdminName], id);
    }
    else if (!strcmp(type, "interior", true))
    {
        GetPlayerPos(playerid, EntranceData[id][entranceInt][0], EntranceData[id][entranceInt][1], EntranceData[id][entranceInt][2]);
        GetPlayerFacingAngle(playerid, EntranceData[id][entranceInt][3]);

        EntranceData[id][entranceInterior] = GetPlayerInterior(playerid);
        Entrance_Save(id);
        AdminMessage(COLOR_LIGHTRED, "*** %s adl� yetkili %d ID'li binan�n interiorunu de�i�tirdi.", PlayerData[playerid][pAdminName], id);
    }
    else if (!strcmp(type, "mapicon", true))
    {
        new icon;

        if (sscanf(string, "d", icon))
            return KullanimMesajGonder(playerid, "/binaduzenle [id] [mapicon] [map icon]");

        if (icon < 0 || icon > 63)
            return HataMesajGonder(playerid, "Ge�ersiz Map Icon ID.");

        EntranceData[id][entranceIcon] = icon;

        Entrance_Refresh(id);
        Entrance_Save(id);

        AdminMessage(COLOR_LIGHTRED, "*** %s adl� yetkili %d ID'li binan�n mapiconunu %d olarak ayarlad�.", PlayerData[playerid][pAdminName], id, icon);
    }
    else if (!strcmp(type, "vip", true))
    {
        new i;

        if (sscanf(string, "d", i))
            return KullanimMesajGonder(playerid, "/binaduzenle [id] [vip] [0 �zel de�il 1 �zel]");

        EntranceData[id][eVip] = i;

        Entrance_Refresh(id);
        Entrance_Save(id);

        AdminMessage(COLOR_LIGHTRED, "*** %s adl� yetkili %d ID'li binan�n mapiconunu %d olarak ayarlad�.", PlayerData[playerid][pAdminName], id, i);
    }
    else if (!strcmp(type, "sifre", true))
    {
        new password[32];

        if (sscanf(string, "s[32]", password))
            return KullanimMesajGonder(playerid, "/binaduzenle [id] [sifre] [�ifre] (Kapatmak i�in 'yok' yaz�n)");

        if (!strcmp(password, "yok", true)) {
            EntranceData[id][entrancePass][0] = 0;
        }
        else {
            format(EntranceData[id][entrancePass], 32, password);
        }
        Entrance_Save(id);
        AdminMessage(COLOR_LIGHTRED, "*** %s adl� yetkili %d ID'li b�nan�n �ifresini de�i�tirdi.", PlayerData[playerid][pAdminName], id);
    }
    else if (!strcmp(type, "kilit", true))
    {
		if (EntranceData[id][entranceLocked] == 1)
		{
		    EntranceData[id][entranceLocked] = 0;
		    AdminMessage(COLOR_LIGHTRED, "*** %s adl� yetkili taraf�ndan %d ID'li b�nan�n kilidi a��ld�.", PlayerData[playerid][pAdminName], id);
		}
		else
		{
		    EntranceData[id][entranceLocked] = 1;
		    AdminMessage(COLOR_LIGHTRED, "*** %s adl� yetkili taraf�ndan %d ID'li bina kilitlendi.", PlayerData[playerid][pAdminName], id);
		}
        Entrance_Save(id);
    }
    else if (!strcmp(type, "isim", true))
    {
        new name[32];

        if (sscanf(string, "s[32]", name))
            return KullanimMesajGonder(playerid, "/binaduzenle [id] [isim] [yeni isim]");

        format(EntranceData[id][entranceName], 32, name);

        Entrance_Refresh(id);
        Entrance_Save(id);

        AdminMessage(COLOR_LIGHTRED, "*** %s adl� yetkili %d ID'li binan�n ismini %s olarak ayarlad�.", PlayerData[playerid][pAdminName], id, name);
    }
    return 1;
}
CMD:binasil(playerid, params[])
{
    static
        id = 0;

    if (PlayerData[playerid][pAdmin] < 3)
        return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

    if (sscanf(params, "d", id))
        return KullanimMesajGonder(playerid, "/binasil [bina id]");

    if ((id < 0 || id >= MAX_ENTRANCES) || !EntranceData[id][entranceExists])
        return HataMesajGonder(playerid, "Ge�ersiz ID girdiniz.");

    Entrance_Delete(id);
    MesajGonder(playerid, "Bina silindi, ID: %d", id);
    return 1;
}

CMD:a(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] < 1) return HataMesajGonder(playerid,"Bu komutu kullanmak i�in yetkiniz yok");

    if (isnull(params))
        return KullanimMesaji(playerid, "/a [Mesaj]");

    foreach(new i:Player) if(PlayerData[i][pAdmin] >= 1 && PlayerData[i][pAyarlar][6] == 0)
    {
        if(strlen(params) > 64)
        {
            SendClientMessageEx(i, COLOR_ADMINCHATT, "[aChat] %s %s: {FFFFFF}%.64s", GetAdminRank(playerid), PlayerData[playerid][pAdminName], params);
            SendClientMessageEx(i, COLOR_ADMINCHATT, "{FFFFFF}...%s", params[64]);
        }
        else
        {
            SendClientMessageEx(i, COLOR_ADMINCHATT, "[aChat] %s %s: {FFFFFF}%s ", GetAdminRank(playerid), PlayerData[playerid][pAdminName], params);
        }
    }
     Log_Write("logs/admin-log.log","[ADMIN CHAT] %s: %s",ReturnName(playerid, 0), trcar(params));
    return 1;
}
CMD:setstaffname(playerid,params[])
{
	new id,name[24];
	if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Bu komutu kullanmak i�in yetkiniz yok");
	if (sscanf(params, "us[24]",id,name)) return KullanimMesajGonder(playerid, "/setstaffname [ID/Isim] [Isim]");
	if (!OyundaDegil(id)) return HataMesajGonder(playerid, "Oyuncu giri� yapmam��.");
	if (strlen(name) < 3 || strlen(name) > 24) return HataMesajGonder(playerid, "�sim 3 ile 24 karakter aras�nda olmal�d�r.");
	if (TurkceKarakter(name)) return HataMesajGonder(playerid, "�sim �zel karakterler ve t�rk�e karakterler i�eremez.");
	format(PlayerData[id][pAdminName],24,name);

	SendAdminAction(playerid, "%s adl� oyuncunun yetkili ad�n� \"%s\" olarak ayarlad�n.",ReturnName(id),name);

	Log_Write("logs/admin-log.log", "[%s] %s Adli Admin %s Adli oyuncunun admin adini %s yapti.",ReturnDate(),ReturnName(playerid),ReturnName(id),name);
	return 1;
}

CMD:aduty(playerid)
{
    if (PlayerData[playerid][pAdmin] < 1 && !PlayerData[playerid][pOyunGorevlisi] && !PlayerData[playerid][pForumGorevlisi]) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
    if (!PlayerData[playerid][pAdminDuty])
    {
        PlayerTextDrawShow(playerid, adminduty[playerid]);
        PlayerData[playerid][pAdminDuty] = 1;
        MesajGonder(playerid,"��ba�� yapt�n�z.");
    }
    else
    {
        PlayerTextDrawHide(playerid, adminduty[playerid]);
        PlayerData[playerid][pAdminDuty] = 0;
  //      PlayerData[playerid][pGOD] = false;
        SetPlayerHealth(playerid, 100);
        MesajGonder(playerid,"��ba��ndan ��kt�n�z.");
	}
	return 1;
}

CMD:apark(playerid, params[])
{
	new id, garajid;
    if (PlayerData[playerid][pAdmin] < 1) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
    if (sscanf(params, "ii", id, garajid)) return KullanimMesajGonder(playerid, "/apark [Ara� ID] [Garaj ID] (garajda de�ilse -1 yaz)");
	if (!IsValidVehicle(id)) return HataMesajGonder(playerid, "Ge�ersiz Ara� ID.");
	new vehicleid = Car_GetID(id);
	if (vehicleid == -1) return HataMesajGonder(playerid, "Ge�ersiz Ara� ID.");
 	GetVehiclePos(AracInfo[vehicleid][aracVehicle], AracInfo[vehicleid][aracPos][0],AracInfo[vehicleid][aracPos][1], AracInfo[vehicleid][aracPos][2]);
	GetVehicleZAngle(AracInfo[vehicleid][aracVehicle], AracInfo[vehicleid][aracPos][3]);
 	AracInfo[vehicleid][aracGaraj] = garajid;
	AracInfo[vehicleid][aracInterior] = CarInterior[id];
	AracInfo[vehicleid][aracWorld] = GetVehicleVirtualWorld(id);
 	Arac_Kaydet(vehicleid);

	Arac_Spawn(vehicleid);

	MesajGonder(playerid, "Ara� park edildi.");
	return 1;
}
CMD:savepos(playerid, params[])
{
	if (!OyundaDegil(playerid)) return 1;
	if (PlayerData[playerid][pAdmin] < 1 && PlayerData[playerid][pHelper] < 1) return HataMesajGonder(playerid, "Bu komutu kullanmak i�in yetkiniz yok!");

if(IsPlayerInAnyVehicle(playerid))
{
new vehicleid = GetPlayerVehicleID(playerid);
GetVehiclePos(vehicleid, posX[playerid], posY[playerid], posZ[playerid]);
GetVehicleZAngle(vehicleid, posA[playerid]);
}
else
{
    GetPlayerPos(playerid, posX[playerid], posY[playerid], posZ[playerid]);
GetPlayerFacingAngle(playerid, posA[playerid]);
}
Interior[playerid] = GetPlayerInterior(playerid);
VirtualWorld[playerid] = GetPlayerVirtualWorld(playerid);
BilgiMesajGonder(playerid, "Pozisyonunuzu kaydettiniz.");
Saved[playerid] = 1;
return 1;
}

CMD:loadpos(playerid, params[])
{
	if (!OyundaDegil(playerid)) return 1;
	if (PlayerData[playerid][pAdmin] < 1 && PlayerData[playerid][pHelper] < 1) return HataMesajGonder(playerid, "Bu komutu kullanmak i�in yetkiniz yok!");
if(Saved[playerid] == 1)
{
if(IsPlayerInAnyVehicle(playerid))
{
new vehicleid = GetPlayerVehicleID(playerid);
	PlayerData[playerid][pLegalTeleport] = gettime() + 2;
    SetVehiclePos(vehicleid, posX[playerid], posY[playerid], posZ[playerid]);
SetVehicleZAngle(vehicleid, posA[playerid]);
LinkVehicleToInterior(vehicleid, Interior[playerid]);
SetVehicleVirtualWorld(vehicleid, VirtualWorld[playerid]);
}
else
{
	PlayerData[playerid][pLegalTeleport] = gettime() + 2;
    SetPlayerPos(playerid, posX[playerid], posY[playerid], posZ[playerid]);
    SetPlayerFacingAngle(playerid, posA[playerid]);
    SetPlayerInterior(playerid, Interior[playerid]);
    SetPlayerVirtualWorld(playerid, VirtualWorld[playerid]);
}
    BilgiMesajGonder(playerid, "Kay�tl� konuma d�nd�n�z.");
}
else
{
    HataMesajGonder(playerid, "Herhangi bir kay�tl� konumunuz yok.");
}
return 1;
}
CMD:hduty(playerid)
{
    if (PlayerData[playerid][pHelper] < 1) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
    if (!PlayerData[playerid][pHelperDuty])
    {
        PlayerTextDrawShow(playerid, helperduty[playerid]);
        PlayerData[playerid][pHelperDuty] = 1;
        MesajGonder(playerid,"��ba�� yapt�n�z.");
    }
    else
    {
        PlayerTextDrawHide(playerid, helperduty[playerid]);
        PlayerData[playerid][pHelperDuty] = 0;
        MesajGonder(playerid,"��ba��ndan ��kt�n�z.");
	}
	return 1;
}
CMD:saracekle(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] < 5)
        return 0;

    new model, fiyat;

    if(sscanf(params, "dd", model, fiyat))
        return KullanimMesaji(playerid, "/saracekle [ara� modeli] [fiyat]");

    if(fiyat < 0)
        return HataMesajGonder(playerid, "Ge�ersiz fiyat girdiniz.");

    new query[57 + 11 + 11 + 1];

    mysql_format(g_SQL, query, sizeof(query), "INSERT INTO satilikaraclar SET model = '%d', fiyat = '%d'", model, fiyat);
    mysql_query(g_SQL, query);

    SunucuMesaji(playerid, "%d numaral� arac� $%d olarak galeriye eklediniz.", model, fiyat);

    return 1;
}
CMD:near(playerid, params[])
{
	static
	    id = -1;

    if (PlayerData[playerid][pAdmin] < 1)
	    return HataMesajGonder(playerid, "Yetkin yok!");

	if ((id = House_Nearest(playerid)) != -1)
	    MesajGonder(playerid, "Yak�n�ndaki Ev ID: %d.", id);

    if ((id = Business_Nearest(playerid)) != -1)
	    MesajGonder(playerid, "Yak�n�ndaki ��yeri ID: %d.", id);

    if ((id = Entrance_Nearest(playerid)) != -1)
	    MesajGonder(playerid, "Yak�n�ndaki Bina ID: %d.", id);

    if ((id = Garage_Nearest(playerid)) != -1)
	    MesajGonder(playerid, "Yak�n�ndaki Garaj ID: %d.", id);

    if ((id = Arrest_Nearest(playerid)) != -1)
	    MesajGonder(playerid, "Yak�n�ndaki Hapishane Noktas� ID: %d.", id);

    if ((id = Gate_Nearest(playerid)) != -1)
	    MesajGonder(playerid, "Yak�n�ndaki Gate ID: %d.", id);

	if ((id = NPC_Nearest(playerid)) != -1)
		MesajGonder(playerid, "Yak�n�ndaki NPC ID: %d", id);

	if ((id = GetNearestCCTV(playerid)) != -1)
		MesajGonder(playerid, "Yak�n�ndaki CCTV ID: %d", id);

	return 1;
}
CMD:askin(playerid)
{
	if (!OyundaDegil(playerid)) return 1;
	if (PlayerData[playerid][pAdmin] < 1) return HataMesajGonder(playerid, "Bu komutu kullanmak i�in yetkiniz yok!");
	if (PlayerData[playerid][pKelepce] > 0 || PlayerData[playerid][pHapisSure] > 0 || PlayerData[playerid][pSoklandi] > 0 || PlayerData[playerid][pYereYatirildi] > 0 || PlayerData[playerid][pBaygin] == 1 || PetKontrol[playerid] != -1 || pbOda[playerid] != -1)
 	return HataMesajGonder(playerid, "�u an bu komutu kullanamazs�n�z.");
 	if (PlayerData[playerid][pAsoyun] == true)
 	{
 	    PlayerData[playerid][pAsoyun] = false;
 	    SetPlayerSkin(playerid, PlayerData[playerid][pSkin]);
 	}
 	else
 	{
 	    if (PlayerData[playerid][pCinsiyet] == 1) Dialog_Show(playerid, askin, DIALOG_STYLE_PREVMODEL, "Admin Skinleri - Erkek", "20012\n20013\n20014\n20015\n20016\n20017\n20018\n20019\n20020\n20021\n20022\n20023\n20024\n20025\n20026\n20027", "Sec", "Kapat");//erkek karkter
 	    else Dialog_Show(playerid, askin, DIALOG_STYLE_PREVMODEL, "Admin Skinleri - Kad�n", "20012\n20013\n20014\n20015\n20016\n20017\n20018\n20019\n20020\n20021\n20022\n20023\n20024\n20025\n20026\n20027", "Sec", "Kapat");//kad�n karakter

 	}
	return 1;
}
CMD:hskin1(playerid)
{
	if (!OyundaDegil(playerid)) return 1;
	if (PlayerData[playerid][pAdmin] < 1 && PlayerData[playerid][pHelper] < 1) return HataMesajGonder(playerid, "Bu komutu kullanmak i�in yetkiniz yok!");
	if (PlayerData[playerid][pKelepce] > 0 || PlayerData[playerid][pHapisSure] > 0 || PlayerData[playerid][pSoklandi] > 0 || PlayerData[playerid][pYereYatirildi] > 0 || PlayerData[playerid][pBaygin] == 1 || PetKontrol[playerid] != -1 || pbOda[playerid] != -1)
 	return HataMesajGonder(playerid, "�u an bu komutu kullanamazs�n�z.");
 	if (PlayerData[playerid][pAsoyun] == true)
 	{
 	    PlayerData[playerid][pAsoyun] = false;
 	    SetPlayerSkin(playerid, PlayerData[playerid][pSkin]);
 	}
 	else
 	{
 	    if (PlayerData[playerid][pCinsiyet] == 1) Dialog_Show(playerid, hskin, DIALOG_STYLE_PREVMODEL, "Helper Skinleri - Erkek", "20014\n20012", "Sec", "Kapat");//erkek karkter
 	    else Dialog_Show(playerid, hskin, DIALOG_STYLE_PREVMODEL, "Helper Skinleri - Kad�n", "20014\n20012", "Sec", "Kapat");//kad�n karakter

 	}
	return 1;
}
CMD:hskin2(playerid)
{
	if (!OyundaDegil(playerid)) return 1;
	if (PlayerData[playerid][pAdmin] < 1 && PlayerData[playerid][pHelper] < 2) return HataMesajGonder(playerid, "Bu komutu kullanmak i�in yetkiniz yok!");
	if (PlayerData[playerid][pKelepce] > 0 || PlayerData[playerid][pHapisSure] > 0 || PlayerData[playerid][pSoklandi] > 0 || PlayerData[playerid][pYereYatirildi] > 0 || PlayerData[playerid][pBaygin] == 1 || PetKontrol[playerid] != -1 || pbOda[playerid] != -1)
 	return HataMesajGonder(playerid, "�u an bu komutu kullanamazs�n�z.");
 	if (PlayerData[playerid][pAsoyun] == true)
 	{
 	    PlayerData[playerid][pAsoyun] = false;
 	    SetPlayerSkin(playerid, PlayerData[playerid][pSkin]);
 	}
 	else
 	{
 	    if (PlayerData[playerid][pCinsiyet] == 1) Dialog_Show(playerid, hskin, DIALOG_STYLE_PREVMODEL, "Helper Skinleri - Erkek", "20014\n20012\n20024\n20020", "Sec", "Kapat");//erkek karkter
 	    else Dialog_Show(playerid, hskin, DIALOG_STYLE_PREVMODEL, "Helper Skinleri - Kad�n", "20014\n20012\n20024\n20020", "Sec", "Kapat");//kad�n karakter

 	}
	return 1;
}
CMD:hskin3(playerid)
{
	if (!OyundaDegil(playerid)) return 1;
	if (PlayerData[playerid][pAdmin] < 1 && PlayerData[playerid][pHelper] < 3) return HataMesajGonder(playerid, "Bu komutu kullanmak i�in yetkiniz yok!");
	if (PlayerData[playerid][pKelepce] > 0 || PlayerData[playerid][pHapisSure] > 0 || PlayerData[playerid][pSoklandi] > 0 || PlayerData[playerid][pYereYatirildi] > 0 || PlayerData[playerid][pBaygin] == 1 || PetKontrol[playerid] != -1 || pbOda[playerid] != -1)
 	return HataMesajGonder(playerid, "�u an bu komutu kullanamazs�n�z.");
 	if (PlayerData[playerid][pAsoyun] == true)
 	{
 	    PlayerData[playerid][pAsoyun] = false;
 	    SetPlayerSkin(playerid, PlayerData[playerid][pSkin]);
 	}
 	else
 	{
 	    if (PlayerData[playerid][pCinsiyet] == 1) Dialog_Show(playerid, hskin, DIALOG_STYLE_PREVMODEL, "Helper Skinleri - Erkek", "20014\n20012\n20024\n20020\n20023\n20022", "Sec", "Kapat");//erkek karkter
 	    else Dialog_Show(playerid, hskin, DIALOG_STYLE_PREVMODEL, "Helper Skinleri - Kad�n", "20014\n20012\n20024\n20020\n20023\n20022", "Sec", "Kapat");//kad�n karakter

 	}
	return 1;
}
CMD:hskin4(playerid)
{
	if (!OyundaDegil(playerid)) return 1;
	if (PlayerData[playerid][pAdmin] < 1 && PlayerData[playerid][pHelper] < 4) return HataMesajGonder(playerid, "Bu komutu kullanmak i�in yetkiniz yok!");
	if (PlayerData[playerid][pKelepce] > 0 || PlayerData[playerid][pHapisSure] > 0 || PlayerData[playerid][pSoklandi] > 0 || PlayerData[playerid][pYereYatirildi] > 0 || PlayerData[playerid][pBaygin] == 1 || PetKontrol[playerid] != -1 || pbOda[playerid] != -1)
 	return HataMesajGonder(playerid, "�u an bu komutu kullanamazs�n�z.");
 	if (PlayerData[playerid][pAsoyun] == true)
 	{
 	    PlayerData[playerid][pAsoyun] = false;
 	    SetPlayerSkin(playerid, PlayerData[playerid][pSkin]);
 	}
 	else
 	{
 	    if (PlayerData[playerid][pCinsiyet] == 1) Dialog_Show(playerid, hskin, DIALOG_STYLE_PREVMODEL, "Helper Skinleri - Erkek", "20014\n20012\n20024\n20020\n20023\n20022\n20021\n20027", "Sec", "Kapat");//erkek karkter
 	    else Dialog_Show(playerid, hskin, DIALOG_STYLE_PREVMODEL, "Helper Skinleri - Kad�n", "20014\n20012\n20024\n20020\n20023\n20022\n20021\n20027", "Sec", "Kapat");//kad�n karakter

 	}
	return 1;
}
CMD:hskin5(playerid)
{
	if (!OyundaDegil(playerid)) return 1;
	if (PlayerData[playerid][pAdmin] < 1 && PlayerData[playerid][pHelper] < 5) return HataMesajGonder(playerid, "Bu komutu kullanmak i�in yetkiniz yok!");
	if (PlayerData[playerid][pKelepce] > 0 || PlayerData[playerid][pHapisSure] > 0 || PlayerData[playerid][pSoklandi] > 0 || PlayerData[playerid][pYereYatirildi] > 0 || PlayerData[playerid][pBaygin] == 1 || PetKontrol[playerid] != -1 || pbOda[playerid] != -1)
 	return HataMesajGonder(playerid, "�u an bu komutu kullanamazs�n�z.");
 	if (PlayerData[playerid][pAsoyun] == true)
 	{
 	    PlayerData[playerid][pAsoyun] = false;
 	    SetPlayerSkin(playerid, PlayerData[playerid][pSkin]);
 	}
 	else
 	{
 	    if (PlayerData[playerid][pCinsiyet] == 1) Dialog_Show(playerid, hskin, DIALOG_STYLE_PREVMODEL, "Helper Skinleri - Erkek", "20014\n20012\n20024\n20020\n20023\n20022\n20021\n20027\n20026\n20025", "Sec", "Kapat");//erkek karkter
 	    else Dialog_Show(playerid, hskin, DIALOG_STYLE_PREVMODEL, "Helper Skinleri - Kad�n", "20014\n20012\n20024\n20020\n20023\n20022\n20021\n20027\n20026\n20025", "Sec", "Kapat");//kad�n karakter

 	}
	return 1;
}
CMD:pmspec(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 2) return HataMesajGonder(playerid, "Bu komutu kullanmak i�in yetkiniz yok!");
	if (isnull(params))
 	{
	 	BilgiMesajGonder(playerid, "/pmspec [a�/kapat]");
		return 1;
	}
	if (!strcmp(params, "a�", true))
	{
	PlayerData[playerid][PMKapali] = 0;
	MesajGonder(playerid, "PM �zleme A��ld�");
	}
	else if (!strcmp(params, "kapat", true))
	{
	PlayerData[playerid][PMKapali] = 1;
	MesajGonder(playerid, "PM �zleme kapat�ld�");
 }
	return 1;
}
CMD:apm(playerid, params[])
{
    static
	    userid,
	    text[128];
	if (PlayerData[playerid][pAdmin] < 1) return HataMesajGonder(playerid, "Bu komutu kullanmak i�in yetkiniz yok!");
	if (sscanf(params, "us[128]", userid, text))
	    return BilgiMesajGonder(playerid, "/apm [ID/Isim] [mesaj]");

	if (!OyundaDegil(userid))
	    return HataMesajGonder(playerid, "Oyuncu oyunda de�il !");

	if (userid == playerid)
	    return HataMesajGonder(playerid, "Kendine �zel mesaj yollayamazs�n.");

    PlayerData[playerid][pLastPM] = userid;
	if (IsPlayerPause(userid)) MesajGonder(playerid, "Bu oyuncu AFK, mesaj�n�za yan�t veremeyebilir.");
	SendClientMessageEx(userid, COLOR_YELLOW, "[STAFF] �� %s (%d): %s", PlayerData[playerid][pAdminName], playerid, text);
	SendClientMessageEx(playerid, 0xdede02FF, "[STAFF] �� %s (%d): %s", ReturnName(userid, 0), userid, text);

	return 1;
}
CMD:onayla(playerid, params[])
{
	new userid;
	if (PlayerData[playerid][pHelper] < 1 && !PlayerData[playerid][pAdmin] && !IsPlayerAdmin(playerid))
	    return HataMesajGonder(playerid, "Yeterli yetkiniz yok.");

	if (sscanf(params, "d", userid))
	    return BilgiMesajGonder(playerid, "/onayla	[oyuncu id]");

    if (strlen(PlayerData[userid][pBasvuru]) <= 0)
	    return HataMesajGonder(playerid, "Belirtti�iniz ki�i ba�vuru g�ndermemi�.");

	AdminHelperMessage(COLOR_LIGHTRED, "AdmCmd: %s adl� yetkili %s adl� oyuncunun att��� ba�vurusunu kabul etti.", ReturnName(playerid, 0), ReturnName(userid, 0));
    AdminHelperMessage(COLOR_LIGHTRED, "AdmCmd: %s adl� helper %s adl� oyuncunun att��� ba�vurusunu onaylad�.", ReturnName(playerid, 0), ReturnName(userid, 0));
 	PlayerData[userid][pBasvuru][0] = 0;
				SetPlayerPos(userid, 1328.0520,277.7649,19.6303);
		SetPlayerInterior(userid,0);
		MesajGonder(userid, "Ba�vurunuz kabul edildi ve los Santos i�in ini� sa�l�yorsunuz, bekleyiniz..");
		SetTimerEx("inscription_StartIntro",100,0,"dd",userid,1);
		SetPlayerSkin(userid, PlayerData[userid][pSkin]);
		SetCameraBehindPlayer(userid);
		PlayerData[userid][pLevel] = 1;
		StopAudioStreamForPlayer(userid);
		SetPlayerScore(playerid, PlayerData[userid][pLevel]);
		PlayerData[userid][pHealth] = 100.0;
		PlayerData[userid][pArmour] = 0.0;
		SetPlayerHealth(userid,100.0);
		SetPlayerArmour(userid,0.0);
	return 1;
}
CMD:reddet(playerid, params[])
{
	new userid;
if (PlayerData[playerid][pHelper] < 1 && !PlayerData[playerid][pAdmin] && !IsPlayerAdmin(playerid))
	    return HataMesajGonder(playerid, "Yeterli yetkiniz yok.");

	if (sscanf(params, "d", userid))
	    return BilgiMesajGonder(playerid, "/reddet	[oyuncu id]");

    if (strlen(PlayerData[userid][pAdvertise]) <= 0)
	    return HataMesajGonder(playerid, "Belirtti�iniz ki�i ba�vuru g�ndermemi�.");

	AdminHelperMessage(COLOR_LIGHTRED, "AdmCmd: %s adl� yetkili %s adl� oyuncunun reklam�n� reddetdi.", ReturnName(playerid, 0), ReturnName(userid, 0));
    AdminHelperMessage(COLOR_LIGHTRED, "AdmCmd: %s adl� helper %s adl� oyuncunun reklam�n� reddetdi.", ReturnName(playerid, 0), ReturnName(userid, 0));

	MesajGonder(userid, "%s att���n�z ba�vuruyu uygun g�rmedi�i i�in reddetdi.", ReturnName(playerid, 0));
	PlayerData[userid][pBasvuru][0] = 0;
	return 1;
}
CMD:amotor(playerid)
{
    new vehicleid = GetPlayerVehicleID(playerid);
    new id = Car_GetID(vehicleid);

	if (PlayerData[playerid][pAdmin] < 1) return HataMesajGonder(playerid, "Bu komutu kullanmak i�in yetkiniz yok !");
    if (!IsEngineVehicle(vehicleid)) return HataMesajGonder(playerid, "Bu komutu sadece ara�ta kullanabilirsin.");
    if (PlayerData[playerid][pBaygin] == 1) return HataMesajGonder(playerid, "Bu komutu yaral�yken kullanamazs�n.");
   	if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return HataMesajGonder(playerid, "S�r�c� de�ilsin.");
   	if (AracInfo[id][aracBenzin] < 0.1) return HataMesajGonder(playerid, "Bu arac�n yak�t� bitmi�.");
   	if (AracHasar(vehicleid) <= 300) return HataMesajGonder(playerid, "Bu araca �ok fazla hasar verilmi�, motor �al��m�yor.");
   	if (UsingPumpID[playerid] != -1) return HataMesajGonder(playerid, "�u an motoru �al��t�ramazs�n�z!");
   	    switch (GetEngineStatus(vehicleid))
   	    {
   	        case false:
   	        {
   	            AdminMessage(COLOR_LIGHTRED, "%s %s, admin komutu ile arac�n motorunu �al��t�rd�.", GetAdminRank(playerid), PlayerData[playerid][pAdminName]);
   	            SetEngineStatus(vehicleid, true);
   	            Log_Write("logs/amotor.log", "[%s] %s %s, admin komutu ile arac�n motorunu �al��t�rd�.", ReturnDate(), GetAdminRank(playerid), PlayerData[playerid][pAdminName]);
   	        }
   	        case true:
   	        {
            	SetEngineStatus(vehicleid, false);
				PlayerData[playerid][pLegalMotor] = 1;
                AdminMessage(COLOR_LIGHTRED, "%s %s, admin komutu ile arac�n motorunu kapatt�.", GetAdminRank(playerid), PlayerData[playerid][pAdminName]);
   	            SetTimerEx("LegalEngine", 6500, false, "d", playerid);
   	            Log_Write("logs/amotor.log", "[%s] %s %s, admin komutu ile arac�n motorunu kapatt�.", ReturnDate(), GetAdminRank(playerid), PlayerData[playerid][pAdminName]);
   	        }
   	    }
	return 1;
}
CMD:kapiyikir(playerid)
{
    if (!OyundaDegil(playerid)) return 1;
    if (PlayerData[playerid][pBaygin] == 1) return HataMesajGonder(playerid, "Bunu �u an yapamazs�n�z.");
    if (GetFactionType(playerid) != BIRLIK_LSPD && GetFactionType(playerid) != BIRLIK_FBI) return HataMesajGonder(playerid, "Devlet memuru de�ilsin.");
    if (PlayerData[playerid][pKelepce] > 0 || PlayerData[playerid][pHapisSure] > 0 || PlayerData[playerid][pSoklandi] > 0 || PlayerData[playerid][pYereYatirildi] > 0 || PlayerData[playerid][pBaygin] == 1 || PetKontrol[playerid] != -1 || pbOda[playerid] != -1 || GetPVarInt(playerid, "IpBaglandi") == 1)
 	return HataMesajGonder(playerid, "�u an bu komutu kullanamazs�n�z.");
    static id = -1;
    if ((id = House_Nearest(playerid)) != -1)
    {
		if (!HouseInfo[id][evKilit]) return HataMesajGonder(playerid, "Bu ev kilitli de�il.");

		ApplyAnimation(playerid, "POLICE", "Door_Kick", 4.0, 0, 0, 0, 0, 0);
		ApplyAnimation(playerid, "POLICE", "Door_Kick", 4.0, 0, 0, 0, 0, 0);
		SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s evin kap�s�na sert bir tekme atar ve kap� k�r�l�r.", ReturnName(playerid, 0));
		HouseInfo[id][evKilit] = 0;
		Ev_Yenile(id);

	}
	else if ((id = Business_Nearest(playerid)) != -1)
	{
	    if (Isyeri[id][isyeriKilit] == 0) return HataMesajGonder(playerid, "Bu i�yeri kilitli de�il.");
	    ApplyAnimation(playerid, "POLICE", "Door_Kick", 4.0, 0, 0, 0, 0, 0);
	    ApplyAnimation(playerid, "POLICE", "Door_Kick", 4.0, 0, 0, 0, 0, 0);
		SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s i�yerinin kap�s�na sert bir tekme atar ve kap� k�r�l�r.", ReturnName(playerid, 0));
		Isyeri[id][isyeriKilit] = 0;
		Isyeri_Yenile(id);
	}
	return 1;
}
CMD:admins(playerid)
{
    if (!OyundaDegil(playerid)) return 1;
    if (PlayerData[playerid][pAdmin] < 1) return HataMesajGonder(playerid, "Aktif yetkilileri g�rmeye yetkiniz yok.");
	new count = 0;
	SendClientMessage(playerid, COLOR_GREY, "-----------------------------------------------------------");
	foreach (new i : Player) if (PlayerData[i][pAdmin] > 0 || PlayerData[i][pOyunGorevlisi] > 0 || PlayerData[i][pForumGorevlisi] > 0)
	{
	    count++;
	    if (PlayerData[i][pAdminDuty])
	    {
	        SendClientMessageEx(playerid,COLOR_WHITE, "{808080}%s | %s | %s (Durum: {00FF00}�{808080})",ReturnName(playerid, 0),PlayerData[i][pAdminName],GetAdminRank(i));
	    }
	    else
	    {
	        SendClientMessageEx(playerid,COLOR_WHITE, "{808080}%s | %s | %s (Durum: {FF0000}�{808080})",ReturnName(playerid, 0),PlayerData[i][pAdminName],GetAdminRank(i));
	    }
	}
	if (!count) SendClientMessage(playerid, COLOR_RED, "* Aktif yetkili yok.");
	SendClientMessage(playerid, COLOR_GREY, "-----------------------------------------------------------");
	return 1;
}
CMD:helpers(playerid)
{
    if (!OyundaDegil(playerid)) return 1;
    new count = 0, str[1000];
    foreach (new i:Player) if (PlayerData[i][pHelper] >= 1)
    {
        count++;
        format(str, sizeof(str), "%s{BBFFEE}(Lv. %d) Helper %s (Durum: %s)\n", str, PlayerData[i][pHelper], PlayerData[i][pAdminName], (PlayerData[i][pHelperDuty] == 1) ? ("{00FF00}�{808080}") : ("{FF0000}�{808080}"));

    }
    if (count == 0) return HataMesajGonder(playerid, "Aktif helper yok.");
    Dialog_Show(playerid, Helpers, DIALOG_STYLE_MSGBOX, "Helperler", str, "Kapat", "");
	return 1;
}
CMD:15dk(playerid, params[])
{
if(PlayerData[playerid][pAdmin] > 5) return HataMesajGonder(playerid, "Yeterli yetkiniz yok.");
	ilkarabalars = 1;
	MesajGonder(playerid, "�lk 15 dakika aktif edildi.");
	foreach (new i : Player)
	{
	    SendClientMessageEx(i, 0x38AF9111, "|{C8C8C8} Sunucu yeni a��ld�, ilk 15 dakika i�erisinde arac�n�z� yan�n�za getirebilirsiniz.");
	}
return 1;
}

CMD:15dkkapa(playerid, params[])
{
if(PlayerData[playerid][pAdmin] > 5) return HataMesajGonder(playerid, "Yeterli yetkiniz yok.");
	ilkarabalars = 0;
	MesajGonder(playerid, "Sunucu yeni a��ld� deaktif.");
	foreach (new i : Player)
	{
	    SendClientMessageEx(i, 0x38AF9111, "|{C8C8C8} 15 dakika doldu, art�k ara�lar�n�z� bulmak zorundas�n�z.");
	}
return 1;
}
CMD:aracolustur(playerid,params[])
{
	new model,color1,color2,tip,id = -1, idx;
	if (PlayerData[playerid][pAdmin] < 3) return HataMesajGonder(playerid, "Bu komutu kullanmak i�in yetkiniz yok");
	if (sscanf(params, "iiiii",model,color1,color2,tip,idx))
	{
	    KullanimMesajGonder(playerid, "/aracolustur [Model ID] [Renk 1] [Renk 2] [Tip] [Faction ID/Kira Ucret/Fiyat]");
	    SendClientMessage(playerid,-1, "{00FF15}[TIP]: {FFFFFF}1: Birlik Arac� 2: Meslek Arac� 3: Kiral�k 4: Normal Ara� 5: VIP Arac� 6: Ehliyet");
	    return 1;
 	}
 	if (!IsValidVehicleModel(model)) return HataMesajGonder(playerid, "Hatal� Model ID");
 	if (tip < 1 || tip > 6) return HataMesajGonder(playerid, "Tip 1 ile 6 aras�nda olmal�d�r.");

    static
    	Float:x,
		Float:y,
		Float:z,
		Float:angle;

    GetPlayerPos(playerid, x, y, z);
	GetPlayerFacingAngle(playerid, angle);

	id = Arac_Olustur(-1,model,GetPlayerInterior(playerid), GetPlayerVirtualWorld(playerid), Garage_Inside(playerid), x,y,z,angle,color1,color2,tip,idx);

	if (id == -1)
		return HataMesajGonder(playerid, "Sunucu maksimum ara� say�s�na ula�m��t�r.");

	AracInfo[id][aracDisplay] = true;

	SetVehicleVirtualWorld(AracInfo[id][aracVehicle], GetPlayerVirtualWorld(playerid));
	SetPlayerPos(playerid, x, y, z+2);

	MesajGonder(playerid, "Ara� olu�turuldu, ID: %d.", AracInfo[id][aracVehicle]);
	return 1;
}

CMD:aracsil(playerid,params[])
{
	new id = 0;
	if (PlayerData[playerid][pAdmin] < 3) return HataMesajGonder(playerid, "Bu komutu kullanmak i�in yetkiniz yok");
	if (sscanf(params, "d", id))
 	{
	 	if (IsPlayerInAnyVehicle(playerid))
		 	id = GetPlayerVehicleID(playerid);

		else return KullanimMesajGonder(playerid, "/aracsil [Ara� ID]");
	}
	if (!IsValidVehicle(id) || Car_GetID(id) == -1) return HataMesajGonder(playerid, "Hatal� Ara� ID.");
	Arac_Sil(Car_GetID(id));
	MesajGonder(playerid, "Ara� silindi, ID: %d.", id);
	return 1;
}
CMD:gateolustur(playerid)
{
	static id = -1;
	if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Bu komutu kullanmak i�in yetkiniz yok");
	new
	    Float:x,
	    Float:y,
	    Float:z,
	    Float:angle;
	  GetPlayerPos(playerid,x,y,z);
	  GetPlayerFacingAngle(playerid,angle);
	id = Gate_Create(x,y,z,angle,GetPlayerInterior(playerid),GetPlayerVirtualWorld(playerid));
	if (id == -1) return HataMesajGonder(playerid, "Sunucu maksimum gate limitine ula�t�.");
	MesajGonder(playerid, "ID: %d | Gate olu�turuldu gate d�zenlemek i�in (/gateduzenle [id] [parametre])",id);
	return 1;
}

CMD:gateduzenle(playerid, params[])
{
	static
	    id,
	    type[24],
	    string[128];

	if (PlayerData[playerid][pAdmin] < 4)
	    return HataMesajGonder(playerid, "Bu komutu kullanmak i�in yetkiniz yok");

	if (sscanf(params, "ds[24]S()[128]", id, type, string))
 	{
	 	KullanimMesajGonder(playerid, "/gateduzenle [ID] [�sim]");
	    SendClientMessage(playerid, COLOR_PINK, "[PARAMETRELER]:{FFFFFF} bolge, model, pos, hareket, speed, radius, zaman, sifre, linkid, faction, sahip, world, vip");
		return 1;
	}

	if ((id < 0 || id >= MAX_GATES) || !GateData[id][gateExists])
	    return HataMesajGonder(playerid, "Hatal� Gate ID girdiniz.");

	if (!strcmp(type, "vip", true))
	{
		static vipSeviyesi;

		if (sscanf(string, "d", vipSeviyesi))
		    return KullanimMesajGonder(playerid, "/gateduzenle [ID] [vip] [VIP Seviyesi]");

		if (vipSeviyesi < 0 || vipSeviyesi > 3)
		    return HataMesajGonder(playerid, "VIP Seviyesi minimum 0, maksimum 3 olmal�d�r.");

        GateData[id][gateVip] = vipSeviyesi;

		Gate_Save(id);
	    return 1;
	}

    if (!strcmp(type, "bolge", true))
	{
		static
		    Float:x,
		    Float:y,
		    Float:z,
		    Float:angle;

		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, angle);

		x += 3.0 * floatsin(-angle, degrees);
		y += 3.0 * floatcos(-angle, degrees);

		GateData[id][gatePos][0] = x;
		GateData[id][gatePos][1] = y;
		GateData[id][gatePos][2] = z;
		GateData[id][gatePos][3] = 0.0;
		GateData[id][gatePos][4] = 0.0;
		GateData[id][gatePos][5] = angle;

		SetDynamicObjectPos(GateData[id][gateObject], x, y, z);
		SetDynamicObjectRot(GateData[id][gateObject], 0.0, 0.0, angle);

		GateData[id][gateOpened] = false;

		Gate_Save(id);
		return 1;
	}
	else if (!strcmp(type, "speed", true))
	{
	    static
	        Float:speed;

		if (sscanf(string, "f", speed))
		    return KullanimMesajGonder(playerid, "/gateduzenle [ID] [hiz] [H�z]");

		if (speed < 0.0 || speed > 20.0)
		    return HataMesajGonder(playerid, "H�z 0 ile 20 aras�nda olmal�d�r.");

        GateData[id][gateSpeed] = speed;

		Gate_Save(id);
		return 1;
	}
 	else if (!strcmp(type, "sahip", true))
	{
	    static
	        sahip = -1;

		if (sscanf(string, "d", sahip))
		    return KullanimMesajGonder(playerid, "/gateduzenle [ID] [sahip] [sql id] (-1 kapat�r)");


        GateData[id][gateOwner] = sahip;
		Gate_Save(id);
        AdminMessage(COLOR_RED, "*** %s adl� yetkili taraf�ndan %d ID'li gatenin sahibi SQL id %d olarak ayarland�.", PlayerData[playerid][pAdminName], id, sahip);
		return 1;
	}
	else if (!strcmp(type, "radius", true))
	{
	    static
	        Float:radius;

		if (sscanf(string, "f", radius))
		    return KullanimMesajGonder(playerid, "/gateduzenle [ID] [radius] [Radius]");

		if (radius < 0.0 || radius > 20.0)
		    return HataMesajGonder(playerid, "Radius 0 ile 20 aras�nda olmal�d�r.");

        GateData[id][gateRadius] = radius;

		Gate_Save(id);
		return 1;
	}
	else if (!strcmp(type, "zaman", true))
	{
	    static
	        time;

		if (sscanf(string, "d", time))
		    return KullanimMesajGonder(playerid, "/gateduzenle [ID] [zaman] [Zaman] (0 kapat�r)");

		if (time < 0 || time > 60000)
		    return HataMesajGonder(playerid, "0 ile 60,000 ms aras�nda olmal�d�r.");

        GateData[id][gateTime] = time;

		Gate_Save(id);
		return 1;
	}
	else if (!strcmp(type, "model", true))
	{
	    static
	        model;

		if (sscanf(string, "d", model))
		    return KullanimMesajGonder(playerid, "/gateduzenle [ID] [model] [gate model]");

		if (!IsValidObjectModel(model))
		    return HataMesajGonder(playerid, "Hatal� Obje ID.");

        GateData[id][gateModel] = model;

		DestroyDynamicObject(GateData[id][gateObject]);
		GateData[id][gateObject] = CreateDynamicObject(GateData[id][gateModel], GateData[id][gatePos][0], GateData[id][gatePos][1], GateData[id][gatePos][2], GateData[id][gatePos][3], GateData[id][gatePos][4], GateData[id][gatePos][5], GateData[id][gateWorld], GateData[id][gateInterior]);

		Gate_Save(id);
		return 1;
	}
    else if (!strcmp(type, "pos", true))
	{
	   	EditDynamicObject(playerid, GateData[id][gateObject]);

		PlayerData[playerid][pEditGate] = id;
        PlayerData[playerid][pEditType] = 1;
		BilgiMesajGonder(playerid, "%d ID'li gatenin pozisyonunu de�i�tiriyorsunuz.", id);
		return 1;
	}
	else if (!strcmp(type, "hareket", true))
	{
	   	EditDynamicObject(playerid, GateData[id][gateObject]);

		PlayerData[playerid][pEditGate] = id;
		PlayerData[playerid][pEditType] = 2;

		BilgiMesajGonder(playerid, "%d ID'li gatenin a��l�� pozisyonunu de�i�tiriyorsunuz.", id);
		return 1;
	}
	else if (!strcmp(type, "linkid", true))
	{
	    static
	        linkid = -1;

		if (sscanf(string, "d", linkid))
		    return KullanimMesajGonder(playerid, "/gateduzenle [id] [linkid] [gate link] (-1 kapat�r)");

        if ((linkid < -1 || linkid >= MAX_GATES) || (linkid != -1 && !GateData[linkid][gateExists]))
	    	return HataMesajGonder(playerid, "Hatal� gate id.");

        GateData[id][gateLinkID] = (linkid == -1) ? (-1) : (GateData[linkid][gateID]);
		Gate_Save(id);

		return 1;
	}
	else if (!strcmp(type, "faction", true))
	{
	    static
	        factionid = -1;

		if (sscanf(string, "d", factionid))
		    return KullanimMesajGonder(playerid, "/gateduzenle [ID] [faction] [gate faction] (-1 kapat�r)");


        GateData[id][gateFaction] = factionid;
		Gate_Save(id);

		return 1;
	}
	else if (!strcmp(type, "sifre", true))
	{
	    static
	        pass[32];

		if (sscanf(string, "s[32]", pass))
		    return KullanimMesajGonder(playerid, "/gateduzenle [ID] [sifre] [gate �ifre] ( 'yok' gate'yi �ifresiz yapar)");

		if (!strcmp(pass, "yok", true))
			GateData[id][gatePass][0] = 0;

		else format(GateData[id][gatePass], 32, pass);

		Gate_Save(id);
		return 1;
	}
	else if (!strcmp(type, "world", true))
	{
	    GateData[id][gateWorld] = GetPlayerVirtualWorld(playerid);
	    DestroyDynamicObject(GateData[id][gateObject]);
		GateData[id][gateObject] = CreateDynamicObject(GateData[id][gateModel], GateData[id][gatePos][0], GateData[id][gatePos][1], GateData[id][gatePos][2], GateData[id][gatePos][3], GateData[id][gatePos][4], GateData[id][gatePos][5], GateData[id][gateWorld], GateData[id][gateInterior]);
	    Gate_Save(id);
	}
	return 1;
}
CMD:gatesil(playerid, params[])
{
	static
	    id = 0;

    if (PlayerData[playerid][pAdmin] < 4)
	    return HataMesajGonder(playerid, "Bu komutu kullanmak i�in yetkiniz yok");

	if (sscanf(params, "d", id))
	    return KullanimMesajGonder(playerid, "/gatesil [Gate ID]");

	if ((id < 0 || id >= MAX_GATES) || !GateData[id][gateExists])
	    return HataMesajGonder(playerid, "Hatal� gate ID girdiniz.");

	Gate_Sil(id);
	MesajGonder(playerid, "Gate silindi, ID: %d.", id);
	return 1;
}
CMD:garajolustur(playerid, params[])
{
	new tip[20], interiorid;
	if (PlayerData[playerid][pAdmin] < 4)
	    return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

	if (sscanf(params, "is[20]", interiorid, tip)) return KullanimMesajGonder(playerid, "/garajolustur [Interior ID] [Tip]");
	if (!(0 <= interiorid <= sizeof(GarageInteriors)-1)) return HataMesajGonder(playerid, "Ge�ersiz Interior ID girdiniz.");
	new Float:pos[3];
	GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
	new id = Garaj_Olustur(tip, interiorid, pos[0], pos[1], pos[2], GetPlayerVirtualWorld(playerid));
	if (id == -1) return HataMesajGonder(playerid, "Sunucu maksimum garaj limitine ula�t�.");
	MesajGonder(playerid, "Garaj olu�turuldu, (/garajduzenle) komutu ile garaj� d�zenleyebilirsiniz. (ID: %d)", id);
	return 1;
}
CMD:garajsil(playerid, params[])
{
    if (PlayerData[playerid][pAdmin] < 4)
	    return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
	new id;
	if (sscanf(params, "i", id)) return KullanimMesajGonder(playerid, "/garajsil [ID]");
	if ((id < 0 || id >= MAX_GARAGE) || !GarageData[id][gExists])
	    return HataMesajGonder(playerid, "Hatal� garaj ID girdiniz.");

	Garaj_Sil(id);
	MesajGonder(playerid, "Garaj silindi, ID: %d.", id);
	return 1;
}
CMD:garajduzenle(playerid, params[])
{
	static
		id,
		type[24],
		string[128];

    if (PlayerData[playerid][pAdmin] < 4)
	    return HataMesajGonder(playerid, "Bu komutu kullanmak i�in yetkiniz yok");

	if (sscanf(params, "ds[24]S()[128]", id, type, string))
 	{
	 	KullanimMesajGonder(playerid, "/garajduzenle [ID] [�sim]");
	    SendClientMessage(playerid, COLOR_PINK, "[PARAMETRELER]:{FFFFFF} kilit, sifre, birlik, sahip, pos, interior, tip, araclimit");
		return 1;
	}
	if ((id < 0 || id >= MAX_GARAGE) || !GarageData[id][gExists])
	    return HataMesajGonder(playerid, "Hatal� Garaj ID girdiniz.");

	if (!strcmp(type, "kilit", true))
	{
	    if (GarageData[id][gKilit] == 1)
	    {
	        GarageData[id][gKilit] = 0;
	        //MesajGonder(playerid, "Garaj�n kilidi a��ld�.");
	        AdminMessage(COLOR_RED, "*** %s adl� yetkili taraf�ndan Garaj ID %d kilidi a��ld�.", PlayerData[playerid][pAdminName], id);
	    }
	    else
	    {
	        GarageData[id][gKilit] = 1;
	        //MesajGonder(playerid, "Garaj kilitlendi.");
	        AdminMessage(COLOR_RED, "*** %s adl� yetkili taraf�ndan Garaj ID %d kilitlendi.", PlayerData[playerid][pAdminName], id);
	    }
	    Garaj_Kaydet(id);
	    Garaj_Yenile(id);
	}
 	else if (!strcmp(type, "sifre", true))
	{
	    static
	        pass[32];

		if (sscanf(string, "s[32]", pass))
		    return KullanimMesajGonder(playerid, "/garajduzenle [ID] [sifre] [garaj �ifre] ( 'yok' yazarsan�z �ifresiz yapar)");

		format(GarageData[id][gSifre], 30, pass);

        AdminMessage(COLOR_RED, "*** %s adl� yetkili taraf�ndan Garaj ID %d �ifresi de�i�tirildi.", PlayerData[playerid][pAdminName], id);
		Garaj_Kaydet(id);
		return 1;
	}
	else if (!strcmp(type, "birlik", true))
	{
	    static
	        factionid = -1;

		if (sscanf(string, "d", factionid))
		    return KullanimMesajGonder(playerid, "/garajduzenle [ID] [birlik] [birlik id] (-1 kapat�r)");

        AdminMessage(COLOR_RED, "*** %s adl� yetkili taraf�ndan %d ID'li garaj�n birli�i %d ID'li birlik olarak ayarland�.", PlayerData[playerid][pAdminName], id, factionid);
        GarageData[id][gBirlik] = factionid;
        Garaj_Yenile(id);
		Garaj_Kaydet(id);

		return 1;
	}
	else if (!strcmp(type, "sahip", true))
	{
	    static
	        sahip = -1;

		if (sscanf(string, "d", sahip))
		    return KullanimMesajGonder(playerid, "/garajduzenle [ID] [sahip] [sql id] (-1 kapat�r)");


        GarageData[id][gSahip] = sahip;
        Garaj_Yenile(id);
		Garaj_Kaydet(id);
        AdminMessage(COLOR_RED, "*** %s adl� yetkili taraf�ndan %d ID'li garaj�n sahibi SQL id %d olarak ayarland�.", PlayerData[playerid][pAdminName], id, sahip);
		return 1;
	}
	else if (!strcmp(type, "pos", true))
	{
	    static
		    Float:px,
		    Float:py,
		    Float:pz;

		GetPlayerPos(playerid, px, py, pz);

		GarageData[id][gPos][0] = px;
		GarageData[id][gPos][1] = py;
		GarageData[id][gPos][2] = pz;
		GarageData[id][gVw] = GetPlayerVirtualWorld(playerid);

		Garaj_Yenile(id);
		Garaj_Kaydet(id);
	 	AdminMessage(COLOR_RED, "*** %s adl� yetkili taraf�ndan %d ID'li garaj�n pozisyonu de�i�tirildi.", PlayerData[playerid][pAdminName], id);
	}
	else if (!strcmp(type, "interior", true))
	{
	    static
	        interior;

		if (sscanf(string, "d", interior))
		    return KullanimMesajGonder(playerid, "/garajduzenle [ID] [interior] [Interior ID]");


        GarageData[id][gInterior] = interior;
		Garaj_Kaydet(id);
        AdminMessage(COLOR_RED, "*** %s adl� yetkili taraf�ndan %d ID'li garaj�n interioru %d olarak de�i�tirildi.", PlayerData[playerid][pAdminName], id, interior);
		return 1;
	}
	else if (!strcmp(type, "tip", true))
	{
	    static
	        tip[20];

		if (sscanf(string, "s[20]", tip))
		    return KullanimMesajGonder(playerid, "/garajduzenle [ID] [Tip] [Tip]");


        format(GarageData[id][gTip], 20, tip);
        Garaj_Yenile(id);
		Garaj_Kaydet(id);
        AdminMessage(COLOR_RED, " %s adl� yetkili taraf�ndan %d ID'li garaj�n tipi %s olarak de�i�tirildi.", PlayerData[playerid][pAdminName], id, tip);
		return 1;
	}
	else if (!strcmp(type, "araclimit", true))
	{
	    static
	        limit;

		if (sscanf(string, "d", limit))
		    return KullanimMesajGonder(playerid, "/garajduzenle [ID] [araclimit] [Limit]");


        GarageData[id][gAracLimit] = limit;
        Garaj_Yenile(id);
		Garaj_Kaydet(id);
        AdminMessage(COLOR_RED, " %s adl� yetkili taraf�ndan %d ID'li garaj�n ara� limiti %d olarak de�i�tirildi.", PlayerData[playerid][pAdminName], id, limit);
		return 1;
	}
	return 1;
}

CMD:evolustur(playerid,params[])
{
	new fiyat, intid, mobilyasayisi;
	if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Bu komutu kullanmak i�in yetkiniz yok");
	if (sscanf(params, "iii",fiyat,intid, mobilyasayisi)) return KullanimMesajGonder(playerid, "/evolustur [Fiyat] [Interior ID] [Maks. Mobilya]");
	if (!(0 <= intid <= sizeof(HouseInteriors)-1)) return HataMesajGonder(playerid, "Yazd���n�z ID'de bir interior bulunmamaktad�r.");
	new id = -1;
	new Float:pos[3];
	GetPlayerPos(playerid,pos[0],pos[1],pos[2]);
	id = Ev_Olustur(pos[0],pos[1],pos[2],fiyat, intid, mobilyasayisi);
	if (id == -1) return HataMesajGonder(playerid, "Sunucu maksimum ev limitine ula�t�.");
	MesajGonder(playerid, "Ev olu�turuldu, ID: %d",id);
	return 1;
}

CMD:evsil(playerid,params[])
{
	new id = 0;
	if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Bu komutu kullanmak i�in yetkiniz yok");
	if (sscanf(params, "d", id)) return KullanimMesajGonder(playerid, "/evsil [Ev ID]");
	if ((id < 0 || id >= MAX_EV) || !HouseInfo[id][evExists]) return HataMesajGonder(playerid, "Bu ID'de bir ev bulunmuyor.");
	Ev_Sil(playerid, id);
	MesajGonder(playerid, "Ev silindi, ID: %d",id);
	return 1;
}

CMD:birlikolustur(playerid,params[])
{
	new
	    id = -1,
		type,
		name[32],
		str[50];

	if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Bu komutu kullanmak i�in yetkiniz yok");
	if (sscanf(params, "ds[32]S()", type, name, str))
	{
	    KullanimMesajGonder(playerid, "/birlikolustur [Tip] [Parametre]");
     	SendClientMessage(playerid, COLOR_PINK, "[TIP]:{FFFFFF}1: Yar��/�ete 2: Mafya 3: Yay�n Ajans� 4: Legal 5: LSPD 6: LSMD 7: FBI 8: GOV");
   		return 1;
	}
	if (type < 1 || type > 8) return HataMesajGonder(playerid, "Tip 1 ile 8 aras�nda olmal�d�r.");
	id = Birlik_Olustur(name, type);

	if (id == -1) return HataMesajGonder(playerid, "Sunucu maksimum birlik say�s�na ula�m��t�r.");
	BilgiMesajGonder(playerid, "Birlik olu�turuldu, ID: %d",id);
	return 1;
}

CMD:birliksil(playerid, params[])
{
	static
	    id = 0;

    if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Bu komutu kullanmak i�in yetkiniz yok");

	if (sscanf(params, "d", id)) return KullanimMesajGonder(playerid, "/birliksil [Birlik ID]");

	if ((id < 0 || id >= MAX_BIRLIK) || !Birlikler[id][birlikExists])
	    return HataMesajGonder(playerid, "Ge�ersiz ID.");

	Birlik_Sil(id);
	MesajGonder(playerid, "Birlik ID %d silindi.", id);
	return 1;
}
CMD:birlikduzenle(playerid,params[])
{
    new id, type[24],string[128];
    if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Bu komutu kullanmak i�in yetkiniz yok");
    if (sscanf(params, "ds[24]S()[128]", id, type, string))
    {
        KullanimMesajGonder(playerid, "/birlikduzenle [ID] [Se�enek]");
       	SendClientMessage(playerid, COLOR_PINK, "[SE�ENEK]: {FFFFFF}isim, renk, tip, rutbe, maxrutbe, sistemselonay, silahonay, uyusturucuonay, graffitionay, hoodonay");
        return 1;
    }
    if ((id < 0 || id >= MAX_BIRLIK) || !Birlikler[id][birlikExists]) return HataMesajGonder(playerid, "Hatal� Birlik ID.");
    if (!strcmp(type, "isim", true))
    {
        new isim[32];
        if (sscanf(string, "s[32]", isim)) return KullanimMesajGonder(playerid, "/birlikduzenle [ID] [isim] [Yeni Isim]");
        format(Birlikler[id][birlikAd], 32, isim);
        Birlik_Kaydet(id);
        AdminMessage(COLOR_RED, " %s adl� yetkili taraf�ndan %d ID'li birli�in ismi %s olarak de�i�tirildi.",ReturnName(playerid,0),id,isim);
        Log_Write("logs/birliklog.txt", "%s tarafindan %d ID'li birligin ismi %s olarak degistirildi",ReturnName(playerid,0),id,isim);
    }
    else if (!strcmp(type, "renk", true))
	{
	    new color;

	    if (sscanf(string, "h", color))
	        return KullanimMesajGonder(playerid, "/birlikduzenle [ID] [renk] [Hex Renk]");

	    Birlikler[id][birlikColor] = color;
	    Birlik_Update(id);

	    Birlik_Kaydet(id);
		AdminMessage(COLOR_RED, " %s taraf�ndan %d ID'li birli�in {%06x}rengi {AA3333}de�i�tirildi.", ReturnName(playerid, 0), id, color >>> 8);
	}
	else if (!strcmp(type, "tip", true))
	{
	    new typeint;
	    if (sscanf(string, "d", typeint))
	    {
	        KullanimMesajGonder(playerid, "/birlikduzenle [ID] [tip] [Tip]");
	        SendClientMessage(playerid, COLOR_PINK, "[TIP]:{FFFFFF}1: Yar��/�ete 2: Mafya 3: Yay�n Ajans� 4: Legal 5: LSPD 6: LSMD 7: FBI 8: GOV");
	        return 1;
	    }
	    if (typeint < 1 || typeint > 8) return HataMesajGonder(playerid, "Tip 1 ile 8 aras�nda olmal�d�r.");

	    Birlikler[id][birlikTip] = typeint;
	    Birlik_Kaydet(id);
	    AdminMessage(COLOR_RED, " %s adl� yetkili %d ID'li birli�in tipini de�i�tirdi.",ReturnName(playerid, 0), id);
	}
	else if (!strcmp(type, "rutbe", true))
	{
	    Birlik_RutbeleriGoster(playerid, id);
	}
	else if (!strcmp(type, "maxrutbe", true))
	{
	    new ranks;

	    if (sscanf(string, "d", ranks))
	        return KullanimMesajGonder(playerid, "/birlikduzenle [ID] [maxrutbe] [max rutbe]");

		if (ranks < 1 || ranks > 20)
		    return HataMesajGonder(playerid, "R�tbe 1'den k���k, 20'den b�y�k olamaz.");

	    Birlikler[id][birlikRutbeler] = ranks;

	    Birlik_Kaydet(id);
	}
	else if (!strcmp(type, "sistemselonay", true))
	{
	    if (Birlikler[id][birlikOnaylar][0])
	    {
	        Birlikler[id][birlikOnaylar][0] = 0;
			BilgiMesajGonder(playerid, "%s (ID: %d) adl� birli�in sistemsel onay�n� sildiniz.", Birlikler[id][birlikAd], id);
			AdminMessage(COLOR_RED, " %s, %s (ID: %d) birli�inin sistemsel onay�n� sildi.",PlayerData[playerid][pAdminName], Birlikler[id][birlikAd], id);
	    }
		else
		{
		    Birlikler[id][birlikOnaylar][0] = 1;
		    BilgiMesajGonder(playerid, "%s (ID: %d) adl� birli�e sistemsel onay verdiniz.", Birlikler[id][birlikAd], id);
		    AdminMessage(COLOR_RED, " %s, %s (ID: %d) birli�ine sistemsel onay verdi.",PlayerData[playerid][pAdminName], Birlikler[id][birlikAd], id);
		}

	    Birlik_Kaydet(id);
	}
	else if (!strcmp(type, "silahonay", true))
	{
	    if (Birlikler[id][birlikOnaylar][1])
	    {
	        Birlikler[id][birlikOnaylar][1] = 0;
			BilgiMesajGonder(playerid, "%s (ID: %d) adl� birli�in silah onay�n� sildiniz.", Birlikler[id][birlikAd], id);
			AdminMessage(COLOR_RED, " %s, %s (ID: %d) birli�inin silah onay�n� sildi.",PlayerData[playerid][pAdminName], Birlikler[id][birlikAd], id);
	    }
		else
		{
		    Birlikler[id][birlikOnaylar][1] = 1;
		    BilgiMesajGonder(playerid, "%s (ID: %d) adl� birli�e silah onay� verdiniz.", Birlikler[id][birlikAd], id);
		    AdminMessage(COLOR_RED, " %s, %s (ID: %d) birli�ine silah onay� verdi.",PlayerData[playerid][pAdminName], Birlikler[id][birlikAd], id);
		}

	    Birlik_Kaydet(id);
	}
	else if (!strcmp(type, "uyusturucuonay", true))
	{
	    if (Birlikler[id][birlikOnaylar][2])
	    {
	        Birlikler[id][birlikOnaylar][2] = 0;
			BilgiMesajGonder(playerid, "%s (ID: %d) adl� birli�in uyu�turucu onay�n� sildiniz.", Birlikler[id][birlikAd], id);
			AdminMessage(COLOR_RED, " %s, %s (ID: %d) birli�inin uyu�turucu onay�n� sildi.",PlayerData[playerid][pAdminName], Birlikler[id][birlikAd], id);
	    }
		else
		{
		    Birlikler[id][birlikOnaylar][2] = 1;
		    BilgiMesajGonder(playerid, "%s (ID: %d) adl� birli�e uyu�turucu onay� verdiniz.", Birlikler[id][birlikAd], id);
		    AdminMessage(COLOR_RED, " %s, %s (ID: %d) birli�ine uyu�turucu onay� verdi.",PlayerData[playerid][pAdminName], Birlikler[id][birlikAd], id);
		}

	    Birlik_Kaydet(id);
	}
	else if (!strcmp(type, "graffitionay", true))
	{
	    if (Birlikler[id][birlikOnaylar][3])
	    {
	        Birlikler[id][birlikOnaylar][3] = 0;
			BilgiMesajGonder(playerid, "%s (ID: %d) adl� birli�in graffiti onay�n� sildiniz.", Birlikler[id][birlikAd], id);
			AdminMessage(COLOR_RED, " %s, %s (ID: %d) birli�inin graffiti onay�n� sildi.",PlayerData[playerid][pAdminName], Birlikler[id][birlikAd], id);
	    }
		else
		{
		    Birlikler[id][birlikOnaylar][3] = 1;
		    BilgiMesajGonder(playerid, "%s (ID: %d) adl� birli�e graffiti onay� verdiniz.", Birlikler[id][birlikAd], id);
		    AdminMessage(COLOR_RED, " %s, %s (ID: %d) birli�ine graffiti onay� verdi.",PlayerData[playerid][pAdminName], Birlikler[id][birlikAd], id);
		}

	    Birlik_Kaydet(id);
	}
	else if (!strcmp(type, "hoodonay", true))
	{
	    if (Birlikler[id][birlikOnaylar][4])
	    {
	        Birlikler[id][birlikOnaylar][4] = 0;
			BilgiMesajGonder(playerid, "%s (ID: %d) adl� birli�in Hood onay�n� sildiniz.", Birlikler[id][birlikAd], id);
			AdminMessage(COLOR_RED, " %s, %s (ID: %d) birli�inin Hood onay�n� sildi.",PlayerData[playerid][pAdminName], Birlikler[id][birlikAd], id);
	    }
		else
		{
		    Birlikler[id][birlikOnaylar][4] = 1;
		    BilgiMesajGonder(playerid, "%s (ID: %d) adl� birli�e Hood onay� verdiniz.", Birlikler[id][birlikAd], id);
		    AdminMessage(COLOR_RED, " %s, %s (ID: %d) birli�ine Hood onay� verdi.",PlayerData[playerid][pAdminName], Birlikler[id][birlikAd], id);
		}

	    Birlik_Kaydet(id);
	}
	return 1;
}
CMD:setleader(playerid,params[])
{
	new pid,id;
	if (PlayerData[playerid][pAdmin] < 3) return HataMesajGonder(playerid, "Bu komutu kullanamazs�n.");
	if (sscanf(params, "ui",pid,id)) return KullanimMesajGonder(playerid, "/setleader [ID/Isim] [Birlik ID] (-1 yazarsan liderlikten at�l�r)");
	if (!OyundaDegil(pid)) return HataMesajGonder(playerid, "Oyuncu oyunda de�il!");
	if ((id < -1 || id >= MAX_BIRLIK) || (id != -1 && !Birlikler[id][birlikExists])) return HataMesajGonder(playerid, "Hatal� Birlik ID.");
	if (id == -1)
	{
	    BirliktenAt(pid);
	    BilgiMesajGonder(playerid, "%s adl� oyuncuyu birlik liderli�inden att�n�z.", ReturnName(pid, 0));
    	BilgiMesajGonder(pid, "%s adl� yetkili sizi birlik liderli�inden att�.", ReturnName(playerid, 0));
    	Oyuncu_Kaydet(id);
	}
	else
	{
	    BirliktenAt(pid);
	    PlayerData[pid][pFaction] = id;
	    PlayerData[pid][pFactionRutbe] = Birlikler[id][birlikRutbeler];
	    PlayerData[pid][pFactionDivizyon] = 0;
	    BilgiMesajGonder(playerid, "%s adl� oyuncuyu \"%s\" adl� birli�in lideri yapt�n�z.", ReturnName(pid, 0),Birlikler[id][birlikAd]);
	    BilgiMesajGonder(pid, "%s adl� yetkili seni \"%s\" adl� birli�in lideri yapt�.", ReturnName(playerid, 0),Birlikler[id][birlikAd]);
	    Oyuncu_Kaydet(pid);
	}
	return 1;
}

CMD:isyeriolustur(playerid,params[])
{
	new tip,fiyat;
	if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Bu komutu kullanmak i�in yetkiniz yok");
	if (sscanf(params, "dd", tip, fiyat))
	{
		KullanimMesajGonder(playerid, "/isyeriolustur [Tip] [Fiyat]");
		SendClientMessage(playerid,-1, "{00FF15}[TIP]: {FFFFFF} 1: Market 2: Kiyafet Ma�azas� 3: Fast Food 4: Galeri 5: Elektronik 6: Bar/Pub 7: Kumarhane 8: Di�er");
		return 1;
	}
	if (tip < 1 || tip > 8) return HataMesajGonder(playerid, "Ge�ersiz i�yeri tipi. 1 ile 8 aras�nda olmal�d�r.");

	new id;
	id = Isyeri_Olustur(playerid, tip, fiyat);

	if (id == -1)
		return HataMesajGonder(playerid, "Sunucu i�yeri s�n�r�na ula�t�.");

	BilgiMesajGonder(playerid, "��yeri olu�turuldu, ID: %d",id);
	return 1;
}

CMD:benzinlerifulle(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] >= 4) {

    for(new i=0;i<MAX_ARAC;i++) {
        AracInfo[i][aracBenzin] = 100;
    }

    new string[128];

    format(string, sizeof(string), "ADM: %s %s, t�m ara�lar�n benzinini doldurdu.", GetAdminRank(playerid), PlayerData[playerid][pAdminName]);
    SendClientMessageToAllEx(COLOR_LIGHTRED,string);
    }
    else
	{
		HataMesaji(playerid,"Yeterli yetkiniz yok.");

	}
    return 1;
}
CMD:isyerisil(playerid, params[])
{
	static
	    id = 0;

    if (PlayerData[playerid][pAdmin] < 4)
	    return HataMesajGonder(playerid, "Bu komutu kullanamazs�n !");

	if (sscanf(params, "d", id))
	    return KullanimMesajGonder(playerid, "/isyerisil [��yeri ID]");

	if ((id < 0 || id >= MAX_ISYERI) || !Isyeri[id][isyeriExists])
	    return HataMesajGonder(playerid, "Ge�ersiz i�yeri ID's�.");

	Isyeri_Sil(id);
	BilgiMesajGonder(playerid, "��yeri silindi, ID: %d.", id);
	return 1;
}
CMD:isyeriduzenle(playerid,params[])
{
	static id, type[24], string[128];
	if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Bu komutu kullanamazs�n !");
	if (sscanf(params, "ds[24]S()[128]", id, type, string))
 	{
	 	KullanimMesajGonder(playerid, "/isyeriduzenle [ID] [Ad]");
	    SendClientMessage(playerid, COLOR_PINK, "{00FF15}[ADLAR]: {FFFFFF} pozisyon, interior, fiyat, stok, tip, spawn, devlet");
		return 1;
	}
	if ((id < 0 || id >= MAX_ISYERI) || !Isyeri[id][isyeriExists])
	    return HataMesajGonder(playerid, "Ge�ersiz i�yeri ID's�.");

	if (!strcmp(type, "pozisyon", true))
	{
	    GetPlayerPos(playerid, Isyeri[id][isyeriPos][0], Isyeri[id][isyeriPos][1], Isyeri[id][isyeriPos][2]);
		GetPlayerFacingAngle(playerid, Isyeri[id][isyeriPos][3]);

		Isyeri_Yenile(id);
		Isyeri_Kaydet(id);
	}
	else if (!strcmp(type, "interior", true))
	{
	    GetPlayerPos(playerid, Isyeri[id][isyeriInt][0], Isyeri[id][isyeriInt][1], Isyeri[id][isyeriInt][2]);
		GetPlayerFacingAngle(playerid, Isyeri[id][isyeriInt][3]);

		Isyeri[id][isyeriInterior] = GetPlayerInterior(playerid);

        foreach (new i : Player)
		{
			if (PlayerData[i][pIsyeri] == Isyeri[id][isyeriID])
			{
				SetPlayerPos(i, Isyeri[id][isyeriInt][0], Isyeri[id][isyeriInt][1], Isyeri[id][isyeriInt][2]);
				SetPlayerFacingAngle(i, Isyeri[id][isyeriInt][3]);

				SetPlayerInterior(i, Isyeri[id][isyeriInterior]);
				SetCameraBehindPlayer(i);
			}
		}
		Isyeri_Kaydet(id);
		BilgiMesajGonder(playerid, "%d ID'li i�yerinin interioru �u an bulundu�unuz interior (ID: %d) olarak de�i�tirildi.",id,GetPlayerInterior(playerid));
	}
	else if (!strcmp(type, "fiyat", true))
	{
	    new price;

	    if (sscanf(string, "d", price))
	        return KullanimMesajGonder(playerid, "/isyeriduzenle [ID] [Fiyat] [Yeni Fiyat]");

	    Isyeri[id][isyeriFiyat] = price;
	    Isyeri[id][isyeriKendiFiyati] = price;

	    Isyeri_Yenile(id);
	    Isyeri_Kaydet(id);

		BilgiMesajGonder(playerid, "%d ID'li i�yerinin fiyat� {2ECC71}%s {FFFFFF}olarak de�i�tirildi.",id,FormatNumber(price));
	}
	else if (!strcmp(type, "stok", true))
	{
	    new urunid,amount;

	    if (sscanf(string, "dd",urunid,amount))
	        return KullanimMesajGonder(playerid, "/isyeriduzenle [ID] [stok] [�r�n ID] [�r�n Say�s�]");

	    Isyeri[id][isyeriUrunSayisi][urunid] = amount;

	    Isyeri_Yenile(id);
	    Isyeri_Kaydet(id);
	}
	else if (!strcmp(type, "tip", true))
	{
	    new typeint;

	    if (sscanf(string, "d", typeint))
	    {
	        KullanimMesajGonder(playerid, "/isyeriduzenle [ID] [Tip]");
			SendClientMessage(playerid,-1, "{00FF15}[TIP]: {FFFFFF} 1: Market 2: Kiyafet Ma�azas� 3: Fast Food 4: Galeri 5: Elektronik 6: Bar/Pub 7: Kumarhane");
			return 1;
	    }
	    if (typeint < 1 || typeint > 9)
			return HataMesajGonder(playerid, "Belirtilen tip 1 ve 7 aras�nda olmal�d�r.");

		Isyeri[id][isyeriTip] = typeint;

		switch (typeint)
 		{
 			case 1: // Market
  			{
		     		    Isyeri[id][isyeriInt][0] = -27.3074;
	                	Isyeri[id][isyeriInt][1] = -30.8741;
	                	Isyeri[id][isyeriInt][2] = 1003.5573;
	                	Isyeri[id][isyeriInt][3] = 0.0000;
						Isyeri[id][isyeriInterior] = 4;
    		}
    		case 2: // Kiyafet Ma�azas�
    		{
		     		    Isyeri[id][isyeriInt][0] = 161.4801;
	                	Isyeri[id][isyeriInt][1] = -96.5368;
	                	Isyeri[id][isyeriInt][2] = 1001.8047;
	                	Isyeri[id][isyeriInt][3] = 0.0000;
						Isyeri[id][isyeriInterior] = 18;
    		}
    		case 3: // Fast Food
    		{
		     		    Isyeri[id][isyeriInt][0] = 363.3402; //
	                	Isyeri[id][isyeriInt][1] = -74.6679;
	                	Isyeri[id][isyeriInt][2] = 1001.5078;
	                	Isyeri[id][isyeriInt][3] = 315.0000;
						Isyeri[id][isyeriInterior] = 10;
    		}
    		case 4: // Galeri
    		{
		     		    Isyeri[id][isyeriInt][0] = 1494.5612;
		            	Isyeri[id][isyeriInt][1] = 1304.2061;
		            	Isyeri[id][isyeriInt][2] = 1093.2891;
		            	Isyeri[id][isyeriInt][3] = 0.0000;
						Isyeri[id][isyeriInterior] = 3;
    		}
    		case 5: // Elektronik
    		{
		     		    Isyeri[id][isyeriInt][0] = 2310.3713;
	   					Isyeri[id][isyeriInt][1] = 997.7480;
				   		Isyeri[id][isyeriInt][2] = -53.9590;
	      				Isyeri[id][isyeriInt][3] = 271.6157;
						Isyeri[id][isyeriInterior] = 0;
    		}
    		case 6: // Bar/Pub
    		{
		     		    Isyeri[id][isyeriInt][0] = 2015.23;
		   				Isyeri[id][isyeriInt][1] = 1345.85;
					   	Isyeri[id][isyeriInt][2] = 107.48;
		      			Isyeri[id][isyeriInt][3] = 90.0000;
						Isyeri[id][isyeriInterior] = 1;
    		}
    		case 7:
    		{
			     		Isyeri[id][isyeriInt][0] = 1481.9872;
	  					Isyeri[id][isyeriInt][1] = 783.1984;
				   		Isyeri[id][isyeriInt][2] = -61.2514;
	     				Isyeri[id][isyeriInt][3] = 83.5277;
    	}	}
	}
	else if (!strcmp(type, "spawn", true))
	{
	    if (Isyeri[id][isyeriTip] != 4)
	        return HataMesajGonder(playerid, "Bu i�yeri tipi ara� galerisi de�il!");

	    if (GetPlayerInterior(playerid) > 0 || GetPlayerVirtualWorld(playerid) > 0)
	        return HataMesajGonder(playerid, "Ara� spawn noktas� sadece d��ar�da olabilir.");

	    GetPlayerPos(playerid, Isyeri[id][isyeriSpawn][0], Isyeri[id][isyeriSpawn][1], Isyeri[id][isyeriSpawn][2]);
		GetPlayerFacingAngle(playerid, Isyeri[id][isyeriSpawn][3]);

		Isyeri_Kaydet(id);
		BilgiMesajGonder(playerid, "%d ID'li i�yerinin ara� spawn noktas� ayarland�.",id);
	}
	else if (!strcmp(type, "devlet", true))
	{
	    if (Isyeri[id][isyeriSahip] == -99)
	    {
	        Isyeri[id][isyeriSahip] = -1;
	        Isyeri_Yenile(id);
	        Isyeri_Kaydet(id);
	        BilgiMesajGonder(playerid, "��yeri art�k devletin de�il.");
	    }
	    else
		{
		    Isyeri[id][isyeriSahip] = -99;
		    Isyeri_Yenile(id);
	        Isyeri_Kaydet(id);
	        BilgiMesajGonder(playerid, "��yeri art�k devletin.");
		}
	}
	return 1;
}

CMD:objeolustur(playerid, params[])
{
	new id, modelid;

	if (PlayerData[playerid][pAdmin] < 4)
	    return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

	if (sscanf(params, "d", modelid))
		return MesajGonder(playerid, "/objeolustur [Model ID]");

	id = Obje_Olustur(playerid, modelid);

	if (id == -1)
		return HataMesajGonder(playerid, "Obje olu�turulurken bir hata olu�tu, l�tfen geli�tirici ile ileti�ime ge�iniz.");

	if (id != -1)
		BilgiMesajGonder(playerid, "L�tfen objenin pozisyonunu ayarlay�n�z.");

	return 1;
}
CMD:objekaldir(playerid, params[])
{
	if (PlayerData[playerid][pAdmin] < 4)
	    return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

	SetPVarInt(playerid, "ObjeKaldirma", 1);
	SelectObject(playerid);

	MesajGonder(playerid, "L�tfen kald�rmak istedi�iniz objeyi se�iniz.");
	return 1;
}

CMD:giseolustur(playerid, params[])
{
	new id = -1;

	if (PlayerData[playerid][pAdmin] < 4)
	    return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

	id = Gise_Olustur(playerid);

	if (id != -1)
	    BilgiMesajGonder(playerid, "ID: %d Gi�e olu�turuldu.", id);

	if (id == -1)
	    BilgiMesajGonder(playerid, "Gi�e olu�turulurken hata olu�tu, geli�tiriciye ula��n.");


	return 1;
}

CMD:gisesil(playerid, params[])
{
	new id, query[512];

	if (PlayerData[playerid][pAdmin] < 4)
	    return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

	if (sscanf(params, "d", id))
	    return KullanimMesajGonder(playerid, "/gisesil [Gi�e ID]");

	if (!Gise[id][gs_Exists])
		return HataMesajGonder(playerid, "Gi�e mevcut de�il.");

	Gise[id][gs_ID] = -1;
	Gise[id][gs_Exists] = false;

	DestroyDynamicObject(Gise[id][gs_GateObje]);
	DestroyDynamicObject(Gise[id][gs_Obje]);

	DestroyDynamic3DTextLabel(Gise[id][gs_id]);
	DestroyDynamic3DTextLabel(Gise[id][gs_inf]);

	Gise[id][gs_GateBar][0] = 0.0;
	Gise[id][gs_GateBar][1] = 0.0;
	Gise[id][gs_GateBar][2] = 0.0;
	Gise[id][gs_GateBar][3] = 0.0;
	Gise[id][gs_GateBar][4] = 0.0;
	Gise[id][gs_GateBar][5] = 0.0;

	Gise[id][gs_Kapali][0] = 0.0;
	Gise[id][gs_Kapali][1] = 0.0;
	Gise[id][gs_Kapali][2] = 0.0;
	Gise[id][gs_Kapali][3] = 0.0;
	Gise[id][gs_Kapali][4] = 0.0;
	Gise[id][gs_Kapali][5] = 0.0;

	Gise[id][gs_Acik][0] = 0.0;
	Gise[id][gs_Acik][1] = 0.0;
	Gise[id][gs_Acik][2] = 0.0;
	Gise[id][gs_Acik][3] = 0.0;
	Gise[id][gs_Acik][4] = 0.0;
	Gise[id][gs_Acik][5] = 0.0;

	mysql_format(g_SQL, query, sizeof query, "DELETE FROM `giseler` WHERE `ID` = '%d'", id);
	mysql_query (g_SQL, query);

	BilgiMesajGonder(playerid, "ID: %d gi�e ba�ar�yla silindi.", id);
	return 1;
}
CMD:createarrest(playerid, params[])
{
	static
	    id = -1,
		Float:x,
		Float:y,
		Float:z;

	GetPlayerPos(playerid, x, y, z);

    if (PlayerData[playerid][pAdmin] < 4)
	    return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

	id = Arrest_Create(x, y, z, GetPlayerInterior(playerid), GetPlayerVirtualWorld(playerid));

	if (id == -1)
	    return HataMesajGonder(playerid, "Sunucu maksimum hapis noktas�na ula�t�.");

	MesajGonder(playerid, "Hapis noktas� olu�turuldu, ID: %d.", id);
	return 1;
}

CMD:destroyarrest(playerid, params[])
{
	static
	    id = 0;

    if (PlayerData[playerid][pAdmin] < 4)
	    return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

	if (sscanf(params, "d", id))
	    return KullanimMesajGonder(playerid, "/destroyarrest [ID]");

	if ((id < 0 || id >= MAX_ARREST_POINTS) || !ArrestData[id][arrestExists])
	    return HataMesajGonder(playerid, "Hatal� ID girdiniz.");

	Arrest_Delete(id);
	MesajGonder(playerid, "Hapis noktas� silindi, ID: %d.", id);
	return 1;
}
CMD:createcctv(playerid, params[])
{
    if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Bu komuta yetkin yok!"); //ADMIN LEVEL HERE
    new
        name[30];
    if (sscanf(params, "s[30]", name)) return KullanimMesajGonder(playerid, "/createcctv [Ad]");
    new id = CreateCCTV(playerid, name);
    if (id == -1) return HataMesajGonder(playerid, "Daha fazla CCTV yaratamazs�n!");
    MesajGonder(playerid, "CCTV olu�turuldu, (/editcctv) komutu ile d�zenleyebilirsiniz. (ID: %d)", id);
    return 1;
}
CMD:rangecctv(playerid, params[])
{
	if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Bu komuta yetkin yok!"); //ADMIN LEVEL HERE
	foreach (new i : CCTVIter)
	if (IsPlayerInRangeOfPoint(playerid, 10.0, CCTVInfo[i][cctv_X], CCTVInfo[i][cctv_Y], CCTVInfo[i][cctv_Z]))
	{
		SendClientMessageEx(playerid, -1, "ID: %d - Ad: %s", i, CCTVInfo[i][cctv_Name]);
	}
	return 1;
}


CMD:deletecctv(playerid, params[])
{
    if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Bu komuta yetkin yok!"); //ADMIN LEVEL HERE
    new id;
    if (sscanf(params, "d", id)) return KullanimMesajGonder(playerid, "/deletecctv [ID]");
    DeleteCCTV(playerid, id);
    return 1;
}

CMD:editcctv(playerid, params[])
{
    if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Bu komuta yetkin yok!"); //ADMIN LEVEL HERE
    new id;
    if (sscanf(params, "d", id)) return KullanimMesajGonder(playerid, "/editcctv [ID]");
    EditCCTV(playerid, id);
    return 1;
}
CMD:movecctv(playerid, params[])
{
    if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Bu komuta yetkin yok!"); //ADMIN LEVEL HERE
    new id;
    if (sscanf(params, "d", id)) return KullanimMesajGonder(playerid, "/movecctv [ID]");
    MoveCCTV(playerid, id);
    return 1;
}
CMD:renamecctv(playerid, params[])
{
    if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Bu komuta yetkin yok!"); //ADMIN LEVEL HERE
    new
        name[30], id;
    if (sscanf(params, "ds[30]", id, name)) return KullanimMesajGonder(playerid, "/renamecctv [ID] [isim]");
    ChangeCCTVName(playerid, id, name);
    return 1;
}

CMD:setbitcoin(playerid, params[])
{
	new tip, deger;
    if (!OyundaDegil(playerid)) return 1;
    if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
    if (sscanf(params, "ii", tip, deger)) return KullanimMesajGonder(playerid, "/setbitcoin [1 - Alma 2 - Satma] [De�er]");
    if (tip <=0 || tip >= 3) return HataMesajGonder(playerid, "1 - Alma 2- Satma");
    switch (tip)
    {
        case 1:
        {
            SetServerBilgi("BitcoinAlma", deger);
            MesajGonder(playerid, "Bitcoin alma fiyat� %s olarak de�i�tirildi.", FormatNumber(deger));
        }
        case 2:
		{
		    SetServerBilgi("BitcoinSatma", deger);
		    MesajGonder(playerid, "Bitcoin satma fiyat� %s olarak de�i�tirildi.", FormatNumber(deger));
		}
    }
	return 1;
}
CMD:lokasyonekle(playerid, params[])
{
	new name[30];
	if (!OyundaDegil(playerid)) return 1;
    if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
    if (sscanf(params, "s[30]", name)) return KullanimMesajGonder(playerid, "/lokasyonekle [Ad]");
    if (strlen(name) > 30) return HataMesajGonder(playerid, "Lokasyon Ad� 30 karakteri ge�emez.");
    new Float:pos[3];
    GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
    new id = Lokasyon_Ekle(name, pos[0], pos[1], pos[2]);
    if (id == -1) return HataMesajGonder(playerid, "Sunucu maksimum lokasyon limitine ula�t�.");
    else MesajGonder(playerid, "Lokasyon eklendi, ID: %d", id);
	return 1;
}
CMD:lokasyonsil(playerid, params[])
{
	new id;
    if (!OyundaDegil(playerid)) return 1;
    if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
    if (sscanf(params, "i", id)) return KullanimMesajGonder(playerid, "/lokasyonsil [ID]");
    if ((id < 0 || id >= MAX_LOKASYON) || !Lokasyon[id][Exists]) return HataMesajGonder(playerid, "Hatal� ID.");
    Lokasyon_Sil(id);
    MesajGonder(playerid, "Lokasyon silindi.");
	return 1;
}
CMD:destroyboombox(playerid, params[])
{
    if (PlayerData[playerid][pAdmin] < 1)
	    return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

	foreach (new i : Player) if (BoomboxData[i][boomboxPlaced] && IsPlayerInRangeOfPoint(playerid, 3.0, BoomboxData[i][boomboxPos][0], BoomboxData[i][boomboxPos][1], BoomboxData[i][boomboxPos][2])) {
		Boombox_Destroy(i);

		MesajGonder(playerid, "%s adl� ki�inin m�zik kutusunu kald�rd�n.", ReturnName(i, 0));
		return BilgiMesajGonder(i, "%s adl� yetkili taraf�ndan m�zik kutunuz kald�r�ld�.", ReturnName(playerid, 0));
	}
	HataMesajGonder(playerid, "Herhangi bir m�zik kutusuna yak�n de�ilsiniz!");
	return 1;
}

CMD:2xpayday(playerid)
{
	if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
	if (GetServerBilgi("2xpayday") == 0)
	{
	    SetServerBilgi("2xpayday", 1);
	    MesajGonder(playerid, "2x Payday aktif edildi.");
	}
	else
	{
	    SetServerBilgi("2xpayday", 0);
	    MesajGonder(playerid, "2x Payday deaktif edildi.");
	}
	return 1;
}

CMD:2xbalikeventi(playerid)
{
	if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
	if (GetServerBilgi("2xBalik") == 0)
	{
	    SetServerBilgi("2xBalik", 1);
	    MesajGonder(playerid, "2x Bal�k eventi aktif edildi.");

	    SendClientMessageToAllEx(COLOR_PINK, "2x Bal�k eventi aktif edildi.");
	}
	else
	{
	    SetServerBilgi("2xBalik", 0);
	    MesajGonder(playerid, "2x Bal�k eventi deaktif edildi.");

	    SendClientMessageToAllEx(COLOR_PINK, "2x Bal�k eventi deaktif edildi.");
	}
	return 1;
}

CMD:aipcoz(playerid, params[])
{
	new id;
    if (PlayerData[playerid][pAdmin] < 1) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
    if (sscanf(params, "u", id)) return KullanimMesajGonder(playerid, "/aipcoz [ID/Isim]");
    if (!OyundaDegil(id)) return HataMesajGonder(playerid, "Oyuncu oyunda de�il.");
    if (GetPVarInt(id, "IpBaglandi") == 0) return HataMesajGonder(playerid, "Bu oyuncu ba�l� de�il.");
    SetPVarInt(id, "IpBaglandi", 0);
    TogglePlayerControllable(id, true);
    SetPlayerSpecialAction(id, SPECIAL_ACTION_NONE);
    MesajGonder(id, "%s adl� yetkili taraf�ndan ipleriniz ��z�ld�.", PlayerData[playerid][pAdminName]);
    MesajGonder(playerid, "%s adl� ki�inin iplerini ��zd�n�z.", ReturnName(id, 0));
	return 1;
}

CMD:akelepcecoz(playerid, params[])
{
    new userid;
    if (PlayerData[playerid][pAdmin] < 1) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
    if (sscanf(params, "u", userid)) return KullanimMesajGonder(playerid, "/akelepcecoz [ID/Isim]");
    if (!OyundaDegil(userid)) return HataMesajGonder(playerid, "Oyuncu oyunda de�il.");
    if (PlayerData[userid][pKelepce] == 0) return HataMesajGonder(playerid, "Bu oyuncu kelep�eli de�il.");
    PlayerData[userid][pKelepce] = 0;
    PlayerData[userid][pDragged] = 0;
	PlayerData[userid][pDraggedBy] = INVALID_PLAYER_ID;
	KillTimer(PlayerData[userid][pDragTimer]);
    SetPlayerCuffed(userid, false);
    TogglePlayerControllable(userid,true);
    MesajGonder(userid, "%s adl� yetkili taraf�ndan kelep�eniz ��kar�ld�.", PlayerData[playerid][pAdminName]);
    MesajGonder(playerid, "%s adl� ki�inin kelep�elerini ��kard�n�z.", ReturnName(userid, 0));
	return 1;
}

CMD:createdealer(playerid, params[])
{
	if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

	new skin;

	if (sscanf(params, "i", skin)) return KullanimMesajGonder(playerid, "/createdealer [skin id]");
	if (!(0 <= skin <= 311)) return HataMesajGonder(playerid, "Ge�ersiz Skin ID.");

	new id = Iter_Free(Dealers), query[512];
	if (id == -1)
		return HataMesajGonder(playerid, "Daha fazla uyu�turucu sat�c�s� olu�turulamaz.");

	GetPlayerPos(playerid, DealerData[id][dealerX], DealerData[id][dealerY], DealerData[id][dealerZ]);
	GetPlayerFacingAngle(playerid, DealerData[id][dealerA]);

    DealerData[id][dealerID] = id;
	DealerData[id][dealerDrugs] = 0;
    DealerData[id][dealerSkin] = skin;
    DealerData[id][dealerVw] = GetPlayerVirtualWorld(playerid);
	DealerData[id][dealerActorID] = CreateActor(skin, DealerData[id][dealerX], DealerData[id][dealerY], DealerData[id][dealerZ], DealerData[id][dealerA]);
	SetActorInvulnerable(DealerData[id][dealerActorID], 1);
	SetActorVirtualWorld(DealerData[id][dealerActorID], GetPlayerVirtualWorld(playerid));

	new label[128];

	format(label, sizeof(label), "Uyu�turucu Sat�c�s� (%d)\n\n{F1C40F}ALT {FFFFFF}tu�una basarak etkile�ime ge�ebilirsiniz.", id);

	DealerData[id][dealerLabel] = CreateDynamic3DTextLabel(label, 0xF1C40FFF, DealerData[id][dealerX], DealerData[id][dealerY], DealerData[id][dealerZ] + 0.25, 5.0, .testlos = 1);

	Iter_Add(Dealers, id);

	mysql_format(g_SQL, query, sizeof query, "INSERT INTO `uyusturucusaticilari` (`ID`, `Skin`, `Uyusturucu`, `Pos`, `VirtualWorld`) VALUES ('%d', '%d', '0', '%f|%f|%f|%f', '%d')", id, skin, DealerData[id][dealerX], DealerData[id][dealerY], DealerData[id][dealerZ], DealerData[id][dealerA], DealerData[id][dealerVw]);
	mysql_query (g_SQL, query);

	MesajGonder(playerid, "Uyu�turucu sat�c�s� olu�turuldu, ID: %d.", id);
	SetPlayerPos(playerid, DealerData[id][dealerX] + (1.5 * floatsin(-DealerData[id][dealerA], degrees)), DealerData[id][dealerY] + (1.5 * floatcos(-DealerData[id][dealerA], degrees)), DealerData[id][dealerZ]);
	return 1;
}
CMD:setdealerskin(playerid, params[])
{
	if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
	if (isnull(params)) return KullanimMesajGonder(playerid, "/setdealerskin [dealer id] [skin id]");
	new id, skin;
	if (sscanf(params, "ii", id, skin)) return KullanimMesajGonder(playerid, "/setdealerskin [dealer id] [skin id]");
	if (!Iter_Contains(Dealers, id)) return HataMesajGonder(playerid, "Ge�ersiz ID.");
	if (!(0 <= skin <= 311)) return HataMesajGonder(playerid, "Ge�ersiz Skin ID.");

	DealerData[id][dealerSkin] = skin;
	DestroyActor(DealerData[id][dealerActorID]);
	DealerData[id][dealerActorID] = CreateActor(skin, DealerData[id][dealerX], DealerData[id][dealerY], DealerData[id][dealerZ], DealerData[id][dealerA]);
	SetActorInvulnerable(DealerData[id][dealerActorID], 1);
    SetActorVirtualWorld(DealerData[id][dealerActorID], DealerData[id][dealerVw]);

    UyusturucuSaticisi_Guncelle(id);

    MesajGonder(playerid, "Uyu�turucu sat�c�s�n�n skini de�i�tirildi.");
	return 1;
}

CMD:setdealerpos(playerid, params[])
{
	if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
	new id;
	if (sscanf(params, "i", id)) return KullanimMesajGonder(playerid, "/setdealerpos [dealer id]");
	if (!Iter_Contains(Dealers, id)) return HataMesajGonder(playerid, "Ge�ersiz ID.");
	GetPlayerPos(playerid, DealerData[id][dealerX], DealerData[id][dealerY], DealerData[id][dealerZ]);
	GetPlayerFacingAngle(playerid, DealerData[id][dealerA]);

	DestroyActor(DealerData[id][dealerActorID]);
	DealerData[id][dealerActorID] = CreateActor(DealerData[id][dealerSkin], DealerData[id][dealerX], DealerData[id][dealerY], DealerData[id][dealerZ], DealerData[id][dealerA]);
	SetActorInvulnerable(DealerData[id][dealerActorID], 1);
	DealerData[id][dealerVw] = GetPlayerVirtualWorld(playerid);
	SetActorVirtualWorld(DealerData[id][dealerActorID], DealerData[id][dealerVw]);
    Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, DealerData[id][dealerLabel], E_STREAMER_X, DealerData[id][dealerX]);
	Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, DealerData[id][dealerLabel], E_STREAMER_Y, DealerData[id][dealerY]);
	Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, DealerData[id][dealerLabel], E_STREAMER_Z, DealerData[id][dealerZ] + 0.25);

	UyusturucuSaticisi_Guncelle(id);

	MesajGonder(playerid, "Uyu�turucu sat�c�s�n�n pozisyonu de�i�tirildi.");
 	SetPlayerPos(playerid, DealerData[id][dealerX] + (1.5 * floatsin(-DealerData[id][dealerA], degrees)), DealerData[id][dealerY] + (1.5 * floatcos(-DealerData[id][dealerA], degrees)), DealerData[id][dealerZ]);
	return 1;
}

CMD:removedealer(playerid, params[])
{
	if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
	new id, query[256];

	if (sscanf(params, "i", id)) return HataMesajGonder(playerid, "/removedealer [dealer id]");
	if (!Iter_Contains(Dealers, id)) return HataMesajGonder(playerid, "Ge�ersiz ID.");

	DestroyActor(DealerData[id][dealerActorID]);
	DestroyDynamic3DTextLabel(DealerData[id][dealerLabel]);

	DealerData[id][dealerID] = -1;
	DealerData[id][dealerActorID] = -1;
	DealerData[id][dealerLabel] = Text3D: -1;
	Iter_Remove(Dealers, id);

	mysql_format(g_SQL, query, sizeof query, "DELETE FROM `uyusturucusaticilari` WHERE `ID` = '%d'", id);
	mysql_query (g_SQL, query);

    MesajGonder(playerid, "Uyu�turucu sat�c�s� kald�r�ld�.");
	return 1;
}

CMD:revive(playerid, params[])
{
	new id;
    if (PlayerData[playerid][pAdmin] < 1 && PlayerData[playerid][pHelper] < 2 && !PlayerData[playerid][pOyunGorevlisi] && !PlayerData[playerid][pForumGorevlisi]) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
    if (sscanf(params, "u", id)) return KullanimMesajGonder(playerid, "/revive [ID/Isim]");
    if (!OyundaDegil(id)) return HataMesajGonder(playerid, "Oyuncu oyunda de�il.");
    if (PlayerData[id][pBaygin] == 0) return HataMesajGonder(playerid, "Oyuncu yaral� de�il.");
    if (IsPlayerDying(playerid)) return HataMesajGonder(playerid, "Biraz bekleyin.");
    ResetPlayerDamages(id);

    PlayerData[id][pBaygin] = 0;
    PlayerData[id][pBayginSure] = 0;

    PlayerData[id][pTopallama] = false;
    PlayerData[id][pTopallamaSayac] = 0;

    CanAyarla(id, 100);
    TogglePlayerControllable(id, true);
    ClearAnimations(id);
    MesajGonder(playerid, "%s adl� ki�iyi canland�rd�n�z.", ReturnName(id, 0));
    MesajGonder(id, "%s adl� yetkili taraf�ndan canland�r�ld�n�z.", PlayerData[playerid][pAdminName]);
    new rank[20];
	if (PlayerData[playerid][pHelper] > 0) format(rank, sizeof(rank), "(Lv. %d) Helper", PlayerData[playerid][pHelper]);
	else format(rank, sizeof(rank), "%s", GetAdminRank(playerid));

	AdminHelperMessage(COLOR_LIGHTRED, "ADM: %s %s, %s (%d) adl� oyuncuyu canland�rd�.", rank, PlayerData[playerid][pAdminName], Player_GetName(id), id);
	return 1;
}

CMD:reviveall(playerid)
{
    if (PlayerData[playerid][pAdmin] < 2)
        return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

    foreach (new i : Player) {
        if (PlayerData[i][pBaygin] == 1)
        {
            SetCameraBehindPlayer(i);
            PlayerData[i][pBaygin] = 0;
			PlayerData[i][pBayginSure] = 0;
            ClearAnimations(i);
            TogglePlayerControllable(i, true);
            CanAyarla(i, 100);
            MesajGonder(i, "%s adl� yetkili taraf�ndan canland�r�ld�n�z.",PlayerData[playerid][pAdminName]);
        }
    }
    AdminMessage(COLOR_LIGHTRED, "(%s) - (( %s adl� yetkili taraf�ndan b�t�n oyuncular canland�r�ld�. ))",ReturnDate(), PlayerData[playerid][pAdminName]);
    return 1;
}
CMD:abankasahip(playerid, params[])
{
    if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
    new id, owner;
    if (sscanf(params, "ii", id, owner)) return KullanimMesajGonder(playerid, "/abankasahip [Hesap ID] [Yeni Sahip SQL ID]");
    new query[128];
    mysql_format(g_SQL, query, sizeof(query), "UPDATE bank_accounts SET Owner='%d' WHERE ID=%d", owner, id);
    mysql_tquery(g_SQL, query, "OnBankAccountAdminEdit", "i", playerid);
	return 1;
}

CMD:abankasifre(playerid, params[])
{
    if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
    new id, password[16];
    if (sscanf(params, "is[16]", id, password)) return KullanimMesajGonder(playerid, "/abankasifre [Hesap ID] [�ifre]");
    new query[128];
    mysql_format(g_SQL, query, sizeof(query), "UPDATE bank_accounts SET Password=md5('%e') WHERE ID=%d", password, id);
    mysql_tquery(g_SQL, query, "OnBankAccountAdminEdit", "i", playerid);
	return 1;
}

CMD:adengedegistir(playerid, params[])
{
    if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
    new id, balance;
    if (sscanf(params, "ii", id, balance)) return KullanimMesajGonder(playerid, "/adengedegistir [Hesap ID] [Para]");
    if (balance > ACCOUNT_LIMIT) return SendClientMessage(playerid, 0xE74C3CFF, "ERROR: {FFFFFF}Balance you specified exceeds account money limit.");
    new query[128];
    mysql_format(g_SQL, query, sizeof(query), "UPDATE bank_accounts SET Balance=%d WHERE ID=%d", balance, id);
    mysql_tquery(g_SQL, query, "OnBankAccountAdminEdit", "i", playerid);
	return 1;
}

CMD:abankaclearlogs(playerid, params[])
{
    if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
    new id, type;
    if (sscanf(params, "iI(0)", id, type))
	{
	    SendClientMessage(playerid, 0xE88732FF, "KULLANIM: {FFFFFF}/abankaclearlogs [Hesap ID] [Log Tipi]");
	    SendClientMessage(playerid, 0xE88732FF, "TIP: {FFFFFF}0- B�t�n | 1- Giri�ler | 2- Yat�r�lan | 3- �ekilen | 4- Transfer | 5- �ifre De�i�tirmeler");
		return 1;
	}

	new query[128];
	if (type > 0) {
	    mysql_format(g_SQL, query, sizeof(query), "DELETE FROM bank_logs WHERE AccountID=%d && Type=%d", id, type);
	}else{
	    mysql_format(g_SQL, query, sizeof(query), "DELETE FROM bank_logs WHERE AccountID=%d", id);
	}

    mysql_tquery(g_SQL, query, "OnBankAccountAdminEdit", "i", playerid);
	return 1;
}

CMD:abankahesapsil(playerid, params[])
{
    if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
    new id;
    if (sscanf(params, "i", id)) return SendClientMessage(playerid, 0xE88732FF, "KULLANIM: {FFFFFF}/abankahesapsil [Hesap ID]");
    foreach (new i : Player)
    {
        if (CurrentAccountID[i] == id) CurrentAccountID[i] = -1;
    }

    new query[128];
    mysql_format(g_SQL, query, sizeof(query), "UPDATE bank_accounts SET Disabled=1 WHERE ID=%d", id);
    mysql_tquery(g_SQL, query, "OnBankAccountAdminEdit", "i", playerid);
	return 1;
}

CMD:abankahesapkurtar(playerid, params[])
{
    if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
    new id;
    if (sscanf(params, "i", id)) return SendClientMessage(playerid, 0xE88732FF, "KULLANIM: {FFFFFF}/abankahesapkurtar [hesap id]");
    new query[128];
    mysql_format(g_SQL, query, sizeof(query), "UPDATE bank_accounts SET Disabled=0 WHERE ID=%d", id);
    mysql_tquery(g_SQL, query, "OnBankAccountAdminEdit", "i", playerid);
	return 1;
}

// Admin Commands for Bankers
CMD:createbanker(playerid, params[])
{
	if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Bu komutu kullanmak i�in yetkiniz yok.");
	new id = Iter_Free(Bankers);
	if (id == -1) return HataMesajGonder(playerid, "Daha fazla olu�turulamaz.");
	new skin;
	if (sscanf(params, "i", skin)) return BilgiMesajGonder(playerid, "/createbanker [Skin ID]");
	if (!(0 <= skin <= 311)) return HataMesajGonder(playerid, "Ge�ersiz Skin ID.");
	BankerData[id][Skin] = skin;
	GetPlayerPos(playerid, BankerData[id][bankerX], BankerData[id][bankerY], BankerData[id][bankerZ]);
	GetPlayerFacingAngle(playerid, BankerData[id][bankerA]);
	SetPlayerPos(playerid, BankerData[id][bankerX] + (1.0 * floatsin(-BankerData[id][bankerA], degrees)), BankerData[id][bankerY] + (1.0 * floatcos(-BankerData[id][bankerA], degrees)), BankerData[id][bankerZ]);

	BankerData[id][bankerActorID] = CreateActor(skin, BankerData[id][bankerX], BankerData[id][bankerY], BankerData[id][bankerZ], BankerData[id][bankerA]);
	if (IsValidActor(BankerData[id][bankerActorID])) SetActorInvulnerable(BankerData[id][bankerActorID], true);
	SetActorVirtualWorld(BankerData[id][bankerActorID], GetPlayerVirtualWorld(playerid));
	BankerData[id][bankerActorID] = GetPlayerVirtualWorld(playerid);

	#if defined BANKER_USE_MAPICON
	BankerData[id][bankerIconID] = CreateDynamicMapIcon(BankerData[id][bankerX], BankerData[id][bankerY], BankerData[id][bankerZ], 58, 0, .streamdistance = BANKER_ICON_RANGE);
	#endif

	new label_string[80];
	format(label_string, sizeof(label_string), "{F1C40F}[%d] FLEECA Banka G�revlisi\n\n{FFFFFF}[{808080}ALT{FFFFFF}]", id);
	BankerData[id][bankerLabel] = CreateDynamic3DTextLabel(label_string, 0x1ABC9CFF, BankerData[id][bankerX], BankerData[id][bankerY], BankerData[id][bankerZ] + 0.25, 5.0, .testlos = 1);

	new query[225];
	mysql_format(g_SQL, query, sizeof(query), "INSERT INTO bankers (`ID`, `Skin`, `PosX`, `PosY`, `PosZ`, `PosA`, `Virtual`) VALUES ('%d', '%d', '%f', '%f', '%f', '%f', '%d')", id, skin, BankerData[id][bankerX], BankerData[id][bankerY], BankerData[id][bankerZ], BankerData[id][bankerA], GetPlayerVirtualWorld(playerid));
	mysql_tquery(g_SQL, query);

	Iter_Add(Bankers, id);
	return 1;
}

CMD:setbankerpos(playerid, params[])
{
    if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Bu komutu kullanmak i�in yetkiniz yok.");
	new id;
	if (sscanf(params, "i", id)) return BilgiMesajGonder(playerid, "/setbankerpos [ID]");
	if (!Iter_Contains(Bankers, id)) return HataMesajGonder(playerid, "Ge�ersiz ID.");
	GetPlayerPos(playerid, BankerData[id][bankerX], BankerData[id][bankerY], BankerData[id][bankerZ]);
	GetPlayerFacingAngle(playerid, BankerData[id][bankerA]);

	DestroyActor(BankerData[id][bankerActorID]);
	BankerData[id][bankerActorID] = CreateActor(BankerData[id][Skin], BankerData[id][bankerX], BankerData[id][bankerY], BankerData[id][bankerZ], BankerData[id][bankerA]);
	if (IsValidActor(BankerData[id][bankerActorID])) SetActorInvulnerable(BankerData[id][bankerActorID], true);
    SetActorVirtualWorld(BankerData[id][bankerActorID], GetPlayerVirtualWorld(playerid));
	BankerData[id][bankerActorID] = GetPlayerVirtualWorld(playerid);
	#if defined BANKER_USE_MAPICON
	Streamer_SetFloatData(STREAMER_TYPE_MAP_ICON, BankerData[id][bankerIconID], E_STREAMER_X, BankerData[id][bankerX]);
	Streamer_SetFloatData(STREAMER_TYPE_MAP_ICON, BankerData[id][bankerIconID], E_STREAMER_Y, BankerData[id][bankerY]);
	Streamer_SetFloatData(STREAMER_TYPE_MAP_ICON, BankerData[id][bankerIconID], E_STREAMER_Z, BankerData[id][bankerZ]);
	#endif

	Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, BankerData[id][bankerLabel], E_STREAMER_X, BankerData[id][bankerX]);
	Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, BankerData[id][bankerLabel], E_STREAMER_Y, BankerData[id][bankerY]);
	Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, BankerData[id][bankerLabel], E_STREAMER_Z, BankerData[id][bankerZ]);

	SetPlayerPos(playerid, BankerData[id][bankerX] + (1.0 * floatsin(-BankerData[id][bankerA], degrees)), BankerData[id][bankerY] + (1.0 * floatcos(-BankerData[id][bankerA], degrees)), BankerData[id][bankerZ]);

	new query[144];
	mysql_format(g_SQL, query, sizeof(query), "UPDATE bankers SET PosX='%f', PosY='%f', PosZ='%f', PosA='%f', `Virtual` = '%d' WHERE ID=%d", BankerData[id][bankerX], BankerData[id][bankerY], BankerData[id][bankerZ], BankerData[id][bankerA], GetPlayerVirtualWorld(playerid),id);
	mysql_tquery(g_SQL, query);
	return 1;
}

CMD:setbankerskin(playerid, params[])
{
    if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Bu komutu kullanmak i�in yetkiniz yok.");
	new id, skin;
	if (sscanf(params, "ii", id, skin)) return BilgiMesajGonder(playerid, "/setbankerskin [ID] [Skin ID]");
	if (!Iter_Contains(Bankers, id)) return HataMesajGonder(playerid, "Ge�ersiz ID.");
	if (!(0 <= skin <= 311)) return HataMesajGonder(playerid, "Ge�ersiz Skin ID.");
	BankerData[id][Skin] = skin;

	if (IsValidActor(BankerData[id][bankerActorID])) DestroyActor(BankerData[id][bankerActorID]);
	BankerData[id][bankerActorID] = CreateActor(BankerData[id][Skin], BankerData[id][bankerX], BankerData[id][bankerY], BankerData[id][bankerZ], BankerData[id][bankerA]);
	if (IsValidActor(BankerData[id][bankerActorID])) SetActorInvulnerable(BankerData[id][bankerActorID], true);

	new query[48];
	mysql_format(g_SQL, query, sizeof(query), "UPDATE bankers SET Skin=%d WHERE ID=%d", BankerData[id][Skin], id);
	mysql_tquery(g_SQL, query);
	return 1;
}

CMD:removebanker(playerid, params[])
{
    if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Bu komutu kullanmak i�in yetkiniz yok.");
	new id;
	if (sscanf(params, "i", id)) return BilgiMesajGonder(playerid, "/removebanker [ID]");
	if (!Iter_Contains(Bankers, id)) return HataMesajGonder(playerid, "Ge�ersiz ID.");
	if (IsValidActor(BankerData[id][bankerActorID])) DestroyActor(BankerData[id][bankerActorID]);
	BankerData[id][bankerActorID] = -1;

	#if defined BANKER_USE_MAPICON
	if (IsValidDynamicMapIcon(BankerData[id][bankerIconID])) DestroyDynamicMapIcon(BankerData[id][bankerIconID]);
    BankerData[id][bankerIconID] = -1;
    #endif

    if (IsValidDynamic3DTextLabel(BankerData[id][bankerLabel])) DestroyDynamic3DTextLabel(BankerData[id][bankerLabel]);
    BankerData[id][bankerLabel] = Text3D: -1;

	Iter_Remove(Bankers, id);

	new query[48];
	mysql_format(g_SQL, query, sizeof(query), "DELETE FROM bankers WHERE ID=%d", id);
	mysql_tquery(g_SQL, query);
	return 1;
}


/*============================================================================*/


/*============================================================================*/

// Admin Commands for ATMs
CMD:createatm(playerid, params[])
{
    if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Bu komutu kullanmak i�in yetkiniz yok.");
	new id = Iter_Free(ATMs);
	if (id == -1) return SendClientMessage(playerid, 0xE74C3CFF, "ERROR: {FFFFFF}Can't create any more ATMs.");
	ATMData[id][atmRX] = ATMData[id][atmRY] = 0.0;

	#if defined ATM_USE_MAPICON
	ATMData[id][atmIconID] = CreateDynamicMapIcon(ATMData[id][atmX], ATMData[id][atmY], ATMData[id][atmZ], 52, 0, .streamdistance = ATM_ICON_RANGE);
	#endif

	GetPlayerPos(playerid, ATMData[id][atmX], ATMData[id][atmY], ATMData[id][atmZ]);
	GetPlayerFacingAngle(playerid, ATMData[id][atmRZ]);

	ATMData[id][atmX] += (2.0 * floatsin(-ATMData[id][atmRZ], degrees));
    ATMData[id][atmY] += (2.0 * floatcos(-ATMData[id][atmRZ], degrees));
    ATMData[id][atmZ] -= 0.3;

	ATMData[id][atmObjID] = CreateDynamicObject(-2905, ATMData[id][atmX], ATMData[id][atmY], ATMData[id][atmZ], ATMData[id][atmRX], ATMData[id][atmRY], ATMData[id][atmRZ]);

    if (IsValidDynamicObject(ATMData[id][atmObjID]))
    {
        #if defined ROBBABLE_ATMS
        new dataArray[E_ATMDATA];
        format(dataArray[IDString], 8, "atm_sys");
        dataArray[refID] = id;
        Streamer_SetArrayData(STREAMER_TYPE_OBJECT, ATMData[id][atmObjID], E_STREAMER_EXTRA_ID, dataArray);
		#endif

        EditingATMID[playerid] = id;
        EditDynamicObject(playerid, ATMData[id][atmObjID]);
    }

	#if defined ATM_USE_MAPICON
	ATMData[id][atmIconID] = CreateDynamicMapIcon(ATMData[id][atmX], ATMData[id][atmY], ATMData[id][atmZ], 52, 0, .streamdistance = ATM_ICON_RANGE);
	#endif

	new label_string[64];
	format(label_string, sizeof(label_string), "{F1C40F}[%d] FLEECA ATM\n\n{FFFFFF}[{808080}ALT{FFFFFF}]", id);
	ATMData[id][atmLabel] = CreateDynamic3DTextLabel(label_string, 0x1ABC9CFF, ATMData[id][atmX], ATMData[id][atmY], ATMData[id][atmZ] + 0.99, 5.0, .testlos = 1);

	new query[144];
	mysql_format(g_SQL, query, sizeof(query), "INSERT INTO bank_atms SET ID=%d, PosX='%f', PosY='%f', PosZ='%f', RotX='%f', RotY='%f', RotZ='%f'", id, ATMData[id][atmX], ATMData[id][atmY], ATMData[id][atmZ], ATMData[id][atmRX], ATMData[id][atmRY], ATMData[id][atmRZ]);
	mysql_tquery(g_SQL, query);

	Iter_Add(ATMs, id);
	return 1;
}

CMD:editatm(playerid, params[])
{
    if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Bu komutu kullanmak i�in yetkiniz yok.");
	new id;
	if (sscanf(params, "i", id)) return BilgiMesajGonder(playerid, "/editatm [ATM ID]");
	if (!Iter_Contains(ATMs, id)) return HataMesajGonder(playerid, "Ge�ersiz ID.");
	if (!IsPlayerInRangeOfPoint(playerid, 30.0, ATMData[id][atmX], ATMData[id][atmY], ATMData[id][atmZ])) return HataMesajGonder(playerid, "Editlemek istedi�iniz ATM'ye yak�n de�ilsiniz.");
	if (EditingATMID[playerid] != -1) return HataMesajGonder(playerid, "Zaten ATM editliyorsun.");
	EditingATMID[playerid] = id;
	EditDynamicObject(playerid, ATMData[id][atmObjID]);
	return 1;
}

CMD:removeatm(playerid, params[])
{
    if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Bu komutu kullanmak i�in yetkiniz yok.");
	new id;
	if (sscanf(params, "i", id)) return BilgiMesajGonder(playerid, "/removeatm [ID]");
	if (!Iter_Contains(ATMs, id)) return HataMesajGonder(playerid, "Ge�ersiz ATM id.");
	if (IsValidDynamicObject(ATMData[id][atmObjID])) DestroyDynamicObject(ATMData[id][atmObjID]);
	ATMData[id][atmObjID] = -1;

	#if defined ATM_USE_MAPICON
	if (IsValidDynamicMapIcon(ATMData[id][atmIconID])) DestroyDynamicMapIcon(ATMData[id][atmIconID]);
    ATMData[id][atmIconID] = -1;
    #endif

    if (IsValidDynamic3DTextLabel(ATMData[id][atmLabel])) DestroyDynamic3DTextLabel(ATMData[id][atmLabel]);
    ATMData[id][atmLabel] = Text3D: -1;

	#if defined ROBBABLE_ATMS
    if (ATMData[id][atmTimer] != -1) KillTimer(ATMData[id][atmTimer]);
    ATMData[id][atmTimer] = -1;

    if (IsValidDynamicPickup(ATMData[id][atmPickup])) DestroyDynamicPickup(ATMData[id][atmPickup]);
    ATMData[id][atmPickup] = -1;

    ATMData[id][atmHealth] = ATM_HEALTH;
	ATMData[id][atmRegen] = 0;
	#endif

	Iter_Remove(ATMs, id);

	new query[48];
	mysql_format(g_SQL, query, sizeof(query), "DELETE FROM bank_atms WHERE ID=%d", id);
	mysql_tquery(g_SQL, query);
	return 1;
}
CMD:setfuel(playerid, params[])
{
	new vid, Float:fuel;
	if (PlayerData[playerid][pAdmin] < 1) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
	if (sscanf(params, "if", vid, fuel)) return KullanimMesajGonder(playerid, "/setfuel [Ara� ID] [Yak�t]");
	if (!IsValidVehicle(vid)) return HataMesajGonder(playerid, "B�yle bir ara� yok.");
	if (fuel > 100.0 || fuel < 0.1) return HataMesajGonder(playerid, "En fazla 100, en az 0 yak�t verebilirsiniz.");
	new arac = Car_GetID(vid);
	if (arac == -1) return HataMesajGonder(playerid, "Bu arac�n yak�t�n� ayarlayamazs�n�z.");
	AracInfo[arac][aracBenzin] = fuel;
	MesajGonder(playerid, "%d ID'li arac�n yak�t� %.1f olarak de�i�tirildi.", vid, fuel);
	return 1;
}
CMD:gotoobject(playerid, params[])
{
	if (PlayerData[playerid][pAdmin] < 1) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
	if (isnull(params)) return KullanimMesajGonder(playerid, "/gotoobject [ID]");
	new id = strval(params[0]);
	if (!(0 <= id <= MAX_COP_OBJECTS - 1)) return HataMesajGonder(playerid, "Ge�ersiz ID girdiniz.");
	if (!CopObjectData[id][ObjCreated]) return HataMesajGonder(playerid, "B�yle bir obje yok.");
	Spawned[playerid] = 0;
	PlayerData[playerid][pLegalTeleport] = gettime() + 2;
	SetPlayerPos(playerid, CopObjectData[id][ObjX], CopObjectData[id][ObjY], CopObjectData[id][ObjZ] + 1.75);
	SetPlayerInterior(playerid, CopObjectData[id][ObjInterior]);
	SetPlayerVirtualWorld(playerid, CopObjectData[id][ObjVirtualWorld]);
	MesajGonder(playerid, "%d ID'li objeye ���nland�n�z.", id);
	Spawned[playerid] = 1;
	return 1;
}
CMD:etolustur(playerid, params[])
{
	if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
	new id = Iter_Free(Trees);
	if (id == -1) return SendClientMessage(playerid, 0xE74C3CFF, "Daha fazla Et olu�turulamaz.");
 	new Float: x, Float: y, Float: z, Float: a;
 	GetPlayerPos(playerid, x, y, z);
 	GetPlayerFacingAngle(playerid, a);
 	x += (3.0 * floatsin(-a, degrees));
	y += (3.0 * floatcos(-a, degrees));
	z -= 1.0;

	TreeData[id][treeX] = x;
	TreeData[id][treeY] = y;
	TreeData[id][treeZ] = z;
	TreeData[id][treeRX] = TreeData[id][treeRY] = TreeData[id][treeRZ] = 0.0;

	TreeData[id][treeObjID] = CreateDynamicObject(19833, TreeData[id][treeX], TreeData[id][treeY], TreeData[id][treeZ], TreeData[id][treeRX], TreeData[id][treeRY], TreeData[id][treeRZ]);

	new label[96];
	format(label, sizeof(label), "Kesilmi� �nek (%d)\n\n{F1C40F}~k~~CONVERSATION_NO~ {FFFFFF}ile kesebilirsin.", id);
	TreeData[id][treeLabel] = CreateDynamic3DTextLabel(label, 0x2ECC71FF, TreeData[id][treeX], TreeData[id][treeY], TreeData[id][treeZ] + 1.5, 5.0);
	Iter_Add(Trees, id);

	stmt_bind_value(AddTree, 0, DB::TYPE_INTEGER, id);
    stmt_bind_value(AddTree, 1, DB::TYPE_FLOAT, TreeData[id][treeX]);
    stmt_bind_value(AddTree, 2, DB::TYPE_FLOAT, TreeData[id][treeY]);
    stmt_bind_value(AddTree, 3, DB::TYPE_FLOAT, TreeData[id][treeZ]);
    stmt_bind_value(AddTree, 4, DB::TYPE_FLOAT, TreeData[id][treeRX]);
    stmt_bind_value(AddTree, 5, DB::TYPE_FLOAT, TreeData[id][treeRY]);
    stmt_bind_value(AddTree, 6, DB::TYPE_FLOAT, TreeData[id][treeRZ]);

    if (stmt_execute(AddTree))
    {
        EditingTreeID[playerid] = id;
        EditDynamicObject(playerid, TreeData[id][treeObjID]);

        MesajGonder(playerid, "Kesilmi� �nek olu�turuldu, ID: %d", id);
	}

	return 1;
}

CMD:etduzenle(playerid, params[])
{
    if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
    if (EditingTreeID[playerid] != -1) return HataMesajGonder(playerid, "Zaten Et editliyorsun.");
	new id;
	if (sscanf(params, "i", id)) return KullanimMesajGonder(playerid, "/etduzenle [tree id]");
	if (!Iter_Contains(Trees, id)) return HataMesajGonder(playerid, "Ge�ersiz ID.");
	if (TreeData[id][treeGettingCut]) return HataMesajGonder(playerid, "Bu et kesildi�i i�in d�zenleyemezsiniz.");
	if (!IsPlayerInRangeOfPoint(playerid, 30.0, TreeData[id][treeX], TreeData[id][treeY], TreeData[id][treeZ])) return SendClientMessage(playerid, 0xE74C3CFF, "D�zenlemek istedi�iniz ete yak�n de�ilsiniz.");
	EditingTreeID[playerid] = id;
	EditDynamicObject(playerid, TreeData[id][treeObjID]);
	return 1;
}

CMD:etsil(playerid, params[])
{
    if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
	new id;
	if (sscanf(params, "i", id)) return KullanimMesajGonder(playerid, "/etsil [tree id]");
	if (!Iter_Contains(Trees, id)) return HataMesajGonder(playerid, "Ge�ersiz ID.");
	if (TreeData[id][treeGettingCut]) return HataMesajGonder(playerid, "Bu Et kesildi�i i�in silemezsiniz.");
	if (Tree_BeingEdited(id)) return HataMesajGonder(playerid, "Bu Et d�zenlendi�i i�in silemezsiniz.");
	DestroyDynamicObject(TreeData[id][treeObjID]);
	DestroyDynamic3DTextLabel(TreeData[id][treeLabel]);
	if (TreeData[id][treeTimer] != -1) KillTimer(TreeData[id][treeTimer]);

	TreeData[id][treeLogs] = TreeData[id][treeSeconds] = 0;
	TreeData[id][treeObjID] = TreeData[id][treeTimer] = -1;
	TreeData[id][treeLabel] = Text3D: -1;
	Iter_Remove(Trees, id);

	stmt_bind_value(RemoveTree, 0, DB::TYPE_INTEGER, id);
	if (stmt_execute(RemoveTree)) MesajGonder(playerid, "Et silindi.");
	return 1;
}
CMD:createbuyer(playerid, params[])
{
	if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Bu komutu kullanmak i�in yetkiniz yok.");
	new skin;
	if (sscanf(params, "i", skin)) return BilgiMesajGonder(playerid, "/createbuyer [skin id]");
	if (!(0 <= skin <= 311)) return HataMesajGonder(playerid, "Ge�ersiz Skin ID.");
	new id = Iter_Free(Buyers);
	if (id == -1) return HataMesajGonder(playerid, "Daha fazla olu�turulamaz.");
	GetPlayerPos(playerid, BuyerData[id][buyerX], BuyerData[id][buyerY], BuyerData[id][buyerZ]);
	GetPlayerFacingAngle(playerid, BuyerData[id][buyerA]);

	BuyerData[id][buyerActorID] = CreateDynamicActor(skin, BuyerData[id][buyerX], BuyerData[id][buyerY], BuyerData[id][buyerZ], BuyerData[id][buyerA], 1);

	new label[300];
	format(label, sizeof(label), "{808080}Et Sat�c�s� (%d)\n\n{FFFFFF}Testere almak i�in {F1C40F}/testere {FFFFFF}kullanabilirsiniz. {2ECC71}(%s)\n{FFFFFF}et satmak i�in {F1C40F}/et [sat] {FFFFFF}kullanabilirsin. {2ECC71}(%s).", id, FormatNumber(CSAW_PRICE), FormatNumber(LOG_PRICE));
	BuyerData[id][buyerLabel] = CreateDynamic3DTextLabel(label, 0xF1C40FFF, BuyerData[id][buyerX], BuyerData[id][buyerY], BuyerData[id][buyerZ] + 0.25, 5.0, .testlos = 1);
	Iter_Add(Buyers, id);

	stmt_bind_value(AddBuyer, 0, DB::TYPE_INTEGER, id);
	stmt_bind_value(AddBuyer, 1, DB::TYPE_INTEGER, skin);
    stmt_bind_value(AddBuyer, 2, DB::TYPE_FLOAT, BuyerData[id][buyerX]);
    stmt_bind_value(AddBuyer, 3, DB::TYPE_FLOAT, BuyerData[id][buyerY]);
    stmt_bind_value(AddBuyer, 4, DB::TYPE_FLOAT, BuyerData[id][buyerZ]);
    stmt_bind_value(AddBuyer, 5, DB::TYPE_FLOAT, BuyerData[id][buyerA]);

    if (stmt_execute(AddBuyer))
	{
		SetPlayerPos(playerid, BuyerData[id][buyerX] + (1.5 * floatsin(-BuyerData[id][buyerA], degrees)), BuyerData[id][buyerY] + (1.5 * floatcos(-BuyerData[id][buyerA], degrees)), BuyerData[id][buyerZ]);
	}

	return 1;
}

CMD:setbuyerskin(playerid, params[])
{
	if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Bu komutu kullanmak i�in yetkiniz yok.");
	new id, skin;
	if (sscanf(params, "ii", id, skin)) return SendClientMessage(playerid, 0xE88732FF, "KULLANIM: {FFFFFF}/setbuyerskin [buyer id] [skin id]");
	if (!Iter_Contains(Buyers, id)) return SendClientMessage(playerid, 0xE74C3CFF, "HATA: {FFFFFF}Ge�ersiz ID.");
	if (!(0 <= skin <= 311)) return SendClientMessage(playerid, 0xE74C3CFF, "HATA: {FFFFFF}Ge�ersiz skin ID.");
	BuyerData[id][buyerSkin] = skin;

	DestroyDynamicActor(BuyerData[id][buyerActorID]);
	BuyerData[id][buyerActorID] = CreateDynamicActor(skin, BuyerData[id][buyerX], BuyerData[id][buyerY], BuyerData[id][buyerZ], BuyerData[id][buyerA], 1);

	stmt_bind_value(UpdateBuyer, 0, DB::TYPE_INTEGER, skin);
    stmt_bind_value(UpdateBuyer, 1, DB::TYPE_FLOAT, BuyerData[id][buyerX]);
    stmt_bind_value(UpdateBuyer, 2, DB::TYPE_FLOAT, BuyerData[id][buyerY]);
    stmt_bind_value(UpdateBuyer, 3, DB::TYPE_FLOAT, BuyerData[id][buyerZ]);
    stmt_bind_value(UpdateBuyer, 4, DB::TYPE_FLOAT, BuyerData[id][buyerA]);
    stmt_bind_value(UpdateBuyer, 5, DB::TYPE_INTEGER, id);

	return 1;
}

CMD:setbuyerpos(playerid, params[])
{
	if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Bu komutu kullanmak i�in yetkiniz yok.");
	new id;
	if (sscanf(params, "i", id)) return SendClientMessage(playerid, 0xE88732FF, "KULLANIM: {FFFFFF}/setbuyerpos [buyer id]");
	if (!Iter_Contains(Buyers, id)) return SendClientMessage(playerid, 0xE74C3CFF, "HATA: {FFFFFF}Ge�ersiz ID.");
	GetPlayerPos(playerid, BuyerData[id][buyerX], BuyerData[id][buyerY], BuyerData[id][buyerZ]);
	GetPlayerFacingAngle(playerid, BuyerData[id][buyerA]);

	DestroyDynamicActor(BuyerData[id][buyerActorID]);
	BuyerData[id][buyerActorID] = CreateDynamicActor(BuyerData[id][buyerSkin], BuyerData[id][buyerX], BuyerData[id][buyerY], BuyerData[id][buyerZ], BuyerData[id][buyerA], 1);

    Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, BuyerData[id][buyerLabel], E_STREAMER_X, BuyerData[id][buyerX]);
	Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, BuyerData[id][buyerLabel], E_STREAMER_Y, BuyerData[id][buyerY]);
	Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, BuyerData[id][buyerLabel], E_STREAMER_Z, BuyerData[id][buyerZ] + 0.25);

	stmt_bind_value(UpdateBuyer, 0, DB::TYPE_INTEGER, BuyerData[id][buyerSkin]);
    stmt_bind_value(UpdateBuyer, 1, DB::TYPE_FLOAT, BuyerData[id][buyerX]);
    stmt_bind_value(UpdateBuyer, 2, DB::TYPE_FLOAT, BuyerData[id][buyerY]);
    stmt_bind_value(UpdateBuyer, 3, DB::TYPE_FLOAT, BuyerData[id][buyerZ]);
    stmt_bind_value(UpdateBuyer, 4, DB::TYPE_FLOAT, BuyerData[id][buyerA]);
    stmt_bind_value(UpdateBuyer, 5, DB::TYPE_INTEGER, id);

    if (stmt_execute(UpdateBuyer))
	{
        SetPlayerPos(playerid, BuyerData[id][buyerX] + (1.5 * floatsin(-BuyerData[id][buyerA], degrees)), BuyerData[id][buyerY] + (1.5 * floatcos(-BuyerData[id][buyerA], degrees)), BuyerData[id][buyerZ]);
	}

	return 1;
}

CMD:removebuyer(playerid, params[])
{
	if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Bu komutu kullanmak i�in yetkiniz yok.");
	new id;
	if (sscanf(params, "i", id)) return SendClientMessage(playerid, 0xE88732FF, "KULLANIM: {FFFFFF}/removebuyer [buyer id]");
	if (!Iter_Contains(Buyers, id)) return SendClientMessage(playerid, 0xE74C3CFF, "HATA: {FFFFFF}Ge�ersiz ID.");

	DestroyDynamicActor(BuyerData[id][buyerActorID]);
	DestroyDynamic3DTextLabel(BuyerData[id][buyerLabel]);

	BuyerData[id][buyerActorID] = -1;
	BuyerData[id][buyerLabel] = Text3D: -1;
	Iter_Remove(Buyers, id);

	stmt_bind_value(RemoveBuyer, 0, DB::TYPE_INTEGER, id);
	return 1;
}

CMD:bakiyever(playerid, params[])
{
	new id, bakiye;
	if (PlayerData[playerid][pAdmin] < 5) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
	if (sscanf(params, "ui", id, bakiye)) return KullanimMesajGonder(playerid, "/bakiyever [ID/Isim] [Miktar]");
	if (bakiye == 0) return 1;
	if (!OyundaDegil(id)) return HataMesajGonder(playerid, "Oyuncu oyunda de�il.");

	PlayerData[id][pBakiye] += bakiye;
	if (bakiye < 0)
	{
	    BilgiMesajGonder(playerid, "%s adl� ki�iden %d TL bakiyesini ald�n.", ReturnName(id, 0), bakiye);
    	BilgiMesajGonder(id, "%s adl� yetkili bakiyenizden %d TL sildi.", PlayerData[playerid][pAdminName], bakiye);
	}
	else
	{
	    MesajGonder(playerid, "%s adl� ki�iye %d TL bakiye verdiniz.", ReturnName(id, 0), bakiye);
    	MesajGonder(id, "%s adl� yetkili size %d TL bakiye verdi.", PlayerData[playerid][pAdminName], bakiye);
	}
	return 1;
}

CMD:siparisler(playerid)
{
    if (!OyundaDegil(playerid)) return 1;
	if (PlayerData[playerid][pAdmin] < 3) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
	SetPVarInt(playerid, "Siparis", 0);
	SiparisListele(playerid);
	return 1;
}

CMD:setvip(playerid, params[])
{
	new id, level, gun;
	if (!OyundaDegil(playerid)) return 1;
	if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
	if (sscanf(params, "uii", id, level, gun)) return KullanimMesajGonder(playerid, "/setvip [ID/Isim] [Level] [G�n]");
	if (!OyundaDegil(id)) return HataMesajGonder(playerid, "Oyuncu oyunda de�il.");
	if (level < 0 || level > 3) return HataMesajGonder(playerid, "Ge�ersiz level girdiniz.");
	if (gun < 0) return 1;
	if (level == 0)
	{
		PlayerData[id][pVip] = 0;
		PlayerData[id][pVipSure] = 0;
		PlayerData[id][pVipRenk] = 0;
		PlayerData[id][pDovusStili] = 4;
  		SetPlayerFightingStyle(id, FIGHT_STYLE_NORMAL);
		Oyuncu_Kaydet(id);
		BilgiMesajGonder(id, "%s adl� yetkili taraf�ndan V.I.P paketiniz silindi.", PlayerData[playerid][pAdminName]);
		BilgiMesajGonder(playerid, "%s adl� ki�inin V.I.P paketini sildiniz.", ReturnName(id, 0));
	}
	else
	{
	    PlayerData[id][pVip] = level;
	    PlayerData[id][pVipSure] = gettime()+gun*86400;
	    BilgiMesajGonder(id, "%s adl� yetkili size %s paketini %d g�nl�k verdi. (Biti� tarihi: %s)", PlayerData[playerid][pAdminName], GetVIPName(level), gun, convertDatex(PlayerData[id][pVipSure]));
	    BilgiMesajGonder(playerid, "%s adl� ki�iye %s paketini %d g�nl�k verdiniz. (Biti� tarihi: %s)", ReturnName(id, 0), GetVIPName(level), gun, convertDatex(PlayerData[id][pVipSure]));
		PlayerData[id][pSilahHakki] = SilahAveraj(playerid);
		PlayerData[id][pSilahSuresi] = 0;

		Oyuncu_Kaydet(id);
	}
	Log_Write("logs/admin.log", "%s adli admin %s adli kisiye %d gunluk level %d vip verdi.",PlayerData[playerid][pAdminName], ReturnName(id, 0), gun, level);
	return 1;
}
CMD:masked(playerid)
{
    if (PlayerData[playerid][pAdmin] < 1 && !PlayerData[playerid][pOyunGorevlisi])
        return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

    static
        name[24];

    SendClientMessage(playerid, COLOR_GREY, "-----------------------------------------------------------");

    foreach (new i : Player) if (PlayerData[i][pMaske] == true) {
	GetPlayerName(i, name, sizeof(name));

        SendClientMessageEx(playerid, COLOR_WHITE, "* %s (#%d)", name, PlayerData[i][pMaskeID]);
    }
    SendClientMessage(playerid, COLOR_GREY, "-----------------------------------------------------------");
    return 1;
}
CMD:maskeidbul(playerid, params[])
{
	new maskid;
	if (PlayerData[playerid][pAdmin] < 1) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
	if (sscanf(params, "i", maskid)) return KullanimMesajGonder(playerid, "/maskeidbul [Maske ID]");
	new name[24], sayi;
	foreach (new i:Player) if (PlayerData[i][pMaskeID] == maskid)
	{
	    GetPlayerName(i, name, sizeof(name));
	    sayi++;
	    SendClientMessageEx(playerid, COLOR_WHITE, "* %s (ID: %d)", name, i);
	}
	if (sayi == 0) return HataMesajGonder(playerid, "Bulunamad�.");
	return 1;
}
CMD:ozelmodelver(playerid, params[])
{
	new sqlid, skinid;
    if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
    if (sscanf(params, "ii", sqlid, skinid)) return KullanimMesajGonder(playerid, "/ozelmodelver [SQL ID] [Skin ID]");
    new query[124];
    format(query, sizeof(query), "SELECT null FROM `ozelmodel` WHERE `sqlid` = '%d' AND `skinid` = '%d'", sqlid, skinid);
    mysql_tquery(g_SQL, query, "OzelModelVer", "iii", playerid, sqlid, skinid);
	return 1;
}
CMD:ozelmodelsil(playerid, params[])
{
    new sqlid, skinid;
    if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
    if (sscanf(params, "ii", sqlid, skinid)) return KullanimMesajGonder(playerid, "/ozelmodelsil [SQL ID] [Skin ID]");
    new query[124];
    format(query, sizeof(query), "SELECT null FROM `ozelmodel` WHERE `sqlid` = '%d' AND `skinid` = '%d'", sqlid, skinid);
    mysql_tquery(g_SQL, query, "OzelModelSil", "iii", playerid, sqlid, skinid);
	return 1;
}

CMD:hoodolustur(playerid, params[])
{
	new birlikid;
    if (PlayerData[playerid][pAdmin] < 3) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
    if (sscanf(params, "i", birlikid)) return KullanimMesajGonder(playerid, "/hoodolustur [Birlik ID]");
    new id = Hood_Olustur(playerid, birlikid);
    if (id == -1) return HataMesajGonder(playerid, "Hood olu�turulamad�.");
    MesajGonder(playerid, "Hood olu�turuldu, ID: %d", id);
	return 1;
}

CMD:hoodsil(playerid, params[])
{
	new id;
    if (PlayerData[playerid][pAdmin] < 3) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
    if (sscanf(params, "i", id)) return KullanimMesajGonder(playerid, "/hoodsil [ID]");
    if ((id < 0 || id >= MAX_HOOD) || Hood[id][hExists] == false) return HataMesajGonder(playerid, "Ge�ersiz ID girdiniz.");
    Hood_Sil(id);
    MesajGonder(playerid, "Hood silindi.");
	return 1;
}

CMD:graffitisil(playerid, params[])
{
	new id;
	if (PlayerData[playerid][pAdmin] < 3) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
	if (sscanf(params, "i", id)) return KullanimMesajGonder(playerid, "/graffitisil [ID] (-1 yazarsan�z yak�n�n�zdaki graffiti silinir)");
	if (id == -1)
	{
	    new yakinid = GetClosestGraffiti(playerid);
	    if (yakinid == -1) return HataMesajGonder(playerid, "Yak�n�n�zda graffiti yok.");
	    Graffiti_Delete(yakinid);
	    MesajGonder(playerid, "Graffiti silindi, ID: %d.", yakinid);
	}
	else
	{
	    if ((id < 0 || id >= MAX_GRAFFITI_POINTS) || !GraffitiData[id][graffitiExists]) return HataMesajGonder(playerid, "Ge�ersiz ID girdiniz.");
	    Graffiti_Delete(id);
	    MesajGonder(playerid, "Graffiti silindi, ID: %d.", id);
	}
	return 1;
}
CMD:ss(playerid, params[])
{
    if (PlayerData[playerid][pAdmin] < 1)
        return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

    if (isnull(params))
        return KullanimMesajGonder(playerid, "/ss [IC]");

    if (strlen(params) > 64)
    {
        foreach (new i : Player) if (OyundaDegil(i)) {
            SendClientMessageEx(i, 0xAAC4E5FF, "(( [Sokaktan Sesler]: %.64s", params);
            SendClientMessageEx(i, 0xAAC4E5FF, "...%s ))", params[64]);
        }
    }
    else
    {
        foreach (new i : Player) if (OyundaDegil(i)) {
            SendClientMessageEx(i, 0xAAC4E5FF, "(( [Sokaktan Sesler]: %s ))", params);
        }
    }

	new str[300];

	format(str, sizeof(str), "**((** [Sokaktan Sesler]: *%s* **))**", params);

	DCMesaj(SS_KANALI, trcar(str));

    return 1;
}

CMD:ooc(playerid, params[])
{
    if (PlayerData[playerid][pAdmin] < 1)
        return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

    if (isnull(params))
        return KullanimMesajGonder(playerid, "(/o)oc [Sunucu OOC Yaz�]");
    if (strlen(params) > 64)
    {
        foreach (new i : Player)
		{
            SendClientMessageEx(i, 0xBC8A5AAA, "{bc8a5a}(( [Oyun D���] %s: %.64s ))", PlayerData[playerid][pAdminName], params);
            SendClientMessageEx(i, 0xBC8A5AAA, "{bc8a5a}...%s ))", params[64]);
        }
    }
    else
    {
        foreach (new i : Player)
        {
            SendClientMessageEx(i, 0xBC8A5AAA, "{bc8a5a}(( [Oyun D���] %s: %.64s ))",PlayerData[playerid][pAdminName], params);
        }
    }
    return 1;
}
CMD:songiris(playerid, params[])
{
	if (PlayerData[playerid][pAdmin] < 1) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

    if (isnull(params) || strlen(params) > 24)
        return KullanimMesajGonder(playerid, "/songiris [Kullan�c� Ad�]");

    static
        query[128];

    format(query, sizeof(query), "SELECT `SonGiris`, `LastIP` FROM `oyuncular` WHERE `Isim` = '%s'", SQL_ReturnEscaped(params));
    mysql_tquery(g_SQL, query, "OnLoginDate", "ds", playerid, params);

    return 1;
}
CMD:slap(playerid, params[])
{
    static
        userid;

    if (PlayerData[playerid][pAdmin] < 1 && PlayerData[playerid][pHelper] < 3)
        return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

    if (sscanf(params, "u", userid))
        return KullanimMesajGonder(playerid, "/slap [ID/Isim]");

    if (!OyundaDegil(userid))
        return HataMesajGonder(playerid, "Belirtti�iniz oyuncu oyunda de�il !");

    static
        Float:px,
        Float:py,
        Float:pz;

    GetPlayerPos(userid, px, py, pz);
    SetPlayerPos(userid, px, py, pz + 5);

    PlayerPlaySound(userid,1190,0.0,0.0,0.0);
	AdminMessage(COLOR_LIGHTRED, " %s adl� yetkili %s(%d) adl� oyuncuyu tokatlad�.", PlayerData[playerid][pAdminName], ReturnName(userid, 0), userid);
    return 1;
}
CMD:kick(playerid, params[])
{
    static
        userid,
        reason[128];
        //query[512];

    if (PlayerData[playerid][pAdmin] < 1 && PlayerData[playerid][pHelper] < 4 && !PlayerData[playerid][pForumGorevlisi] && !PlayerData[playerid][pOyunGorevlisi])
        return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

    if (sscanf(params, "us[128]", userid, reason))
        return KullanimMesajGonder(playerid, "/kick [ID/Isim] [Sebep]");

    if (!IsPlayerConnected(userid))
        return HataMesajGonder(playerid, "Belirtti�iniz oyuncu oyunda de�il !");

    if (PlayerData[userid][pAdmin] > PlayerData[playerid][pAdmin])
        return HataMesajGonder(playerid, "Belirtilen oyuncu sizden y�ksek yetkiye sahiptir.");

	new query[300];
    if (PlayerData[userid][pLevel] >= 1)
    {
        format(query, sizeof(query), "INSERT INTO `oocsicil` (`ID`, `Tarih`, `Sebep`, `Uygulayan`, `Tur`) VALUES('%d', '%s', '%s', '%s', '1')",  PlayerData[userid][pID], ReturnDate(), reason, PlayerData[playerid][pAdminName]);
        mysql_tquery(g_SQL, query);
    }
    foreach (new i:Player) if (PlayerData[i][pAyarlar][3] == 0 || i == userid)
    {
    	SendClientMessageEx(i, 0xC87C0000, "[Kick]{808080} %s, %s taraf�ndan %s sebebiyle sunucudan at�ld�. (%s)", ReturnName(userid, 0),  PlayerData[playerid][pAdminName], reason, ReturnDate());
    }
    Log_Write("logs/kick_log.txt", "[%s] %s tarafindan %s sunucudan atildi. sebep: %s.", ReturnDate(), PlayerData[playerid][pAdminName], ReturnName(userid, 0), reason);
    Kick(userid);
    return 1;
}
CMD:skick(playerid, params[])
{
    static
        userid,
        reason[128];
        //query[512];

    if (PlayerData[playerid][pAdmin] < 1 && PlayerData[playerid][pHelper] < 4 && !PlayerData[playerid][pForumGorevlisi] && !PlayerData[playerid][pOyunGorevlisi])
        return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

    if (sscanf(params, "us[128]", userid, reason))
        return KullanimMesajGonder(playerid, "/kick [ID/Isim] [Sebep]");

    if (!IsPlayerConnected(userid))
        return HataMesajGonder(playerid, "Belirtti�iniz oyuncu oyunda de�il !");

    if (PlayerData[userid][pAdmin] > PlayerData[playerid][pAdmin])
        return HataMesajGonder(playerid, "Belirtilen oyuncu sizden y�ksek yetkiye sahiptir.");

	new query[300];
    if (PlayerData[userid][pLevel] >= 1)
    {
        format(query, sizeof(query), "INSERT INTO `oocsicil` (`ID`, `Tarih`, `Sebep`, `Uygulayan`, `Tur`) VALUES('%d', '%s', '%s', '%s', '1')",  PlayerData[userid][pID], ReturnDate(), reason, PlayerData[playerid][pAdminName]);
        mysql_tquery(g_SQL, query);
    }
    SunucuMesaji(userid, "Sunucudan sessiz kicklendiniz.");
    AdminHelperMessage(COLOR_LIGHTRED, "ADM: (%s) %s %s, %s adl� oyuncuyu sunucudan sessiz �ekilde kickledi, sebep: %s", ReturnDate(), GetAdminRank(playerid), PlayerData[playerid][pAdminName], ReturnName(userid, 0), reason);
    Log_Write("logs/kick_log.txt", "[%s] %s tarafindan %s sunucudan atildi. sebep: %s.", ReturnDate(), PlayerData[playerid][pAdminName], ReturnName(userid, 0), reason);
    Kick(userid);
    return 1;
}
CMD:kickall(playerid, params[])
{
    if (PlayerData[playerid][pAdmin] < 4)
        return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

    SendClientMessageToAllEx(COLOR_LIGHTRED, "ADM: (%s) %s %s, herkesi sunucudan att�.", ReturnDate(), GetAdminRank(playerid), PlayerData[playerid][pAdminName]);
    foreach (new i : Player)
    {
        if (!IsPlayerNPC(i) && i != playerid)
		{
		    Kick(i);
		}
    }
    return 1;
}
CMD:dondur(playerid, params[])
{
    static
        userid;

    if (PlayerData[playerid][pAdmin] < 1)
        return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

    if (sscanf(params, "u", userid))
        return KullanimMesajGonder(playerid, "/dondur [id/isim]");

    if (!OyundaDegil(userid))
        return HataMesajGonder(playerid, "Belirtti�iniz oyuncu oyunda de�il !");

    TogglePlayerControllable(userid, 0);
    MesajGonder(playerid, "%s adl� oyuncuyu dondurdunuz.", ReturnName(userid, 0));
    BilgiMesajGonder(userid, "%s adl� yetkili taraf�ndan donduruldunuz.", PlayerData[playerid][pAdminName]);
    return 1;
}

CMD:coz(playerid, params[])
{
    static
        userid;

    if (PlayerData[playerid][pAdmin] < 1)
        return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

    if (sscanf(params, "u", userid))
        return KullanimMesajGonder(playerid, "/coz [id/isim]");

    if (!IsPlayerConnected(userid))
        return HataMesajGonder(playerid, "Belirtti�iniz oyuncu oyunda de�il !");

    TogglePlayerControllable(userid, 1);
    MesajGonder(playerid, "%s adl� oyuncunun hareket edememe engelini kald�rd�n�z.", ReturnName(userid, 0));
    return 1;
}
CMD:level1(playerid, params[])
{
    if (PlayerData[playerid][pAdmin] < 1) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
    new string[1024];
    foreach (new i : Player)
    {
        if (PlayerData[i][pLevel] == 1 && OyundaDegil(i))
        {
            new bilgiler[256];
            format(bilgiler, sizeof(bilgiler), "%s - [ID: %d ]\n", ReturnName(i), i);
            strcat(string, bilgiler);
        }
    }
    Dialog_Show(playerid, Level1ler, DIALOG_STYLE_LIST, "Acemi Oyuncular", string, "Tamam", "");
    return 1;
}

CMD:spawnla(playerid, params[])
{
    static
        userid;

	new rank[20];
	if(PlayerData[playerid][pHelper] > 0) format(rank, sizeof(rank), "(Lv. %d) Helper", PlayerData[playerid][pHelper]);
   	else format(rank, sizeof(rank), "%s", GetAdminRank(playerid));

    if (PlayerData[playerid][pAdmin] < 1 && PlayerData[playerid][pHelper] < 1 && !PlayerData[playerid][pOyunGorevlisi] && !PlayerData[playerid][pForumGorevlisi])
        return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

    if (sscanf(params, "u", userid))
        return KullanimMesajGonder(playerid, "/spawnla [id/isim]");

    if (!OyundaDegil(userid) || IsPlayerNPC(userid))
        return HataMesajGonder(playerid, "Belirtti�iniz oyuncu oyunda de�il !");


    if (GetPlayerState(userid) == 2)
    {
        new tmpcar = GetPlayerVehicleID(playerid);
        SetVehiclePos(tmpcar, 1529.6,-1691.2,13.3);
        LinkVehicleToInteriorEx(tmpcar, 0);
        SetPlayerVirtualWorld(userid, 0);
    }
    else
    {
        SetPlayerPos(userid, 397.2073,-1540.4087,32.3874);
		Spawned[userid] = 0;
		SetPlayerVirtualWorld(userid, 0);
    }
    SetPlayerInterior(userid, 0);
	AdminHelperMessage(COLOR_LIGHTRED, "ADM: %s %s, %s(%d) adl� oyuncuyu spawnlad�.", rank, PlayerData[playerid][pAdminName], ReturnName(userid, 0), userid);
	MesajGonder(playerid, "%s adl� oyuncuyu spawnlad�n�z.", ReturnName(userid, 0));
    BilgiMesajGonder(userid, "%s adl� yetkili sizi spawnlad�.", PlayerData[playerid][pAdminName]);

	Spawned[userid] = 1;
    PlayerData[userid][pHouse] = -1;
    PlayerData[userid][pIsyeri] = -1;
    PlayerData[userid][pGarage] = -1;
    PlayerData[userid][pCadir] = -1;
    return 1;
}

CMD:setskin(playerid, params[])
{
    static
        userid,
        skinid;

    if (PlayerData[playerid][pAdmin] < 2)
        return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

    if (sscanf(params, "ud", userid, skinid))
        return KullanimMesajGonder(playerid, "/setskin [id/isim] [skin id]");

    if (!OyundaDegil(userid))
        return HataMesajGonder(playerid, "Belirtti�iniz oyuncu oyunda de�il !");

    SetPlayerSkin(userid, skinid);
    PlayerData[userid][pSkin] = skinid;

    MesajGonder(playerid, "%s adl� oyuncunun k�yafetini ID %d olarak de�i�tirdiniz.", ReturnName(userid, 0), skinid);
    BilgiMesajGonder(userid, "%s adl� yetkili skininizi ID %d olarak de�i�tirdi.", PlayerData[playerid][pAdminName], skinid);

    return 1;
}
CMD:goto(playerid, params[])
{
	static
	    id,
	    type[24],
		string[64];

    if (PlayerData[playerid][pAdmin] < 1 && PlayerData[playerid][pHelper] < 2 && !PlayerData[playerid][pOyunGorevlisi] && !PlayerData[playerid][pForumGorevlisi])
        return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");


	if (sscanf(params, "u", id))
 	{
	 	KullanimMesajGonder(playerid, "/goto [oyuncu veya isim]");
		SendClientMessage(playerid, COLOR_PINK, "[�S�MLER]:{FFFFFF} ls, mulk, isyeri, bina, gate, interior, garaj, lv, sf");
		PlayerData[playerid][pLegalTeleport] = gettime() + 2;
		return 1;
	}

    if (id == INVALID_PLAYER_ID)
	{
	    if (sscanf(params, "s[24]S()[64]", type, string))
		{
		    KullanimMesajGonder(playerid, "/goto [oyuncu veya isim]");
			SendClientMessage(playerid, COLOR_PINK, "[�S�MLER]:{FFFFFF} ls, ev, isyeri, bina, gate, interior, garaj, lv, sf");
			PlayerData[playerid][pLegalTeleport] = gettime() + 2;
			return 1;
	    }
	    if (!strcmp(type, "ls", true))
		{
		    PlayerData[playerid][pLegalTeleport] = gettime() + 2;
			Spawned[playerid] = 0;
	        SetPlayerPos(playerid, 1529.6,-1691.2,13.3);
	        SetPlayerInterior(playerid, 0);
	        SetPlayerVirtualWorld(playerid, 0);

			PlayerData[playerid][pHouse] = -1;
	        PlayerData[playerid][pIsyeri] = -1;
	        PlayerData[playerid][pGarage] = -1;
			PlayerData[playerid][pCadir] = -1;
			Spawned[playerid] = 1;
	        return SunucuMesaji(playerid, "Los Santos'a ���nland�n.");
		}
		else if (!strcmp(type, "mulk", true))
		{
		    if (sscanf(string, "d", id))
		        return KullanimMesajGonder(playerid, "/goto [ev] [ev ID]");

			if ((id < 0 || id >= MAX_EV) || !HouseInfo[id][evExists])
			    return HataMesajGonder(playerid, "Ge�ersiz ev ID'si.");
			Spawned[playerid] = 0;
		    SetPlayerPos(playerid, HouseInfo[id][evPos][0], HouseInfo[id][evPos][1], HouseInfo[id][evPos][2]);
		    SetPlayerInterior(playerid, 0);
		    SetPlayerVirtualWorld(playerid, 0);
		    PlayerData[playerid][pHouse] = -1;
	        PlayerData[playerid][pIsyeri] = -1;
	        PlayerData[playerid][pGarage] = -1;
            PlayerData[playerid][pCadir] = -1;
		    SunucuMesaji(playerid, "%d idli m�lke gittin.", id);
			Spawned[playerid] = 1;
		    return 1;
		}
		else if (!strcmp(type, "isyeri", true))
		{
		    if (sscanf(string, "d", id))
		        return KullanimMesajGonder(playerid, "/goto [isyeri] [isyeri ID]");

			if ((id < 0 || id >= MAX_ISYERI) || !Isyeri[id][isyeriExists])
			    return HataMesajGonder(playerid, "Ge�ersiz i�yeri ID'si.");
			Spawned[playerid] = 0;
		    SetPlayerPos(playerid, Isyeri[id][isyeriPos][0], Isyeri[id][isyeriPos][1], Isyeri[id][isyeriPos][2]);
		    SetPlayerInterior(playerid, 0);
		    SetPlayerVirtualWorld(playerid, 0);
		    PlayerData[playerid][pHouse] = -1;
	        PlayerData[playerid][pIsyeri] = -1;
	        PlayerData[playerid][pGarage] = -1;
            PlayerData[playerid][pCadir] = -1;
//            AdminHelperMessage(COLOR_LIGHTRED, "ADM: %s %s, %d idli i�yerine ���nland�." rank, PlayerData[playerid][pAdminName], id);
		    SunucuMesaji(playerid, "%d idli i�yerine gittin.", id);
			Spawned[playerid] = 1;
		    return 1;
		}
		else if (!strcmp(type, "bina", true))
		{
		    if (sscanf(string, "d", id))
		        return KullanimMesajGonder(playerid, "/goto [bina] [bina ID]");

			if ((id < 0 || id >= MAX_ENTRANCES) || !EntranceData[id][entranceExists])
			    return HataMesajGonder(playerid, "Ge�ersiz bir bina ID belirttiniz.");
			Spawned[playerid] = 0;
		    SetPlayerPos(playerid, EntranceData[id][entrancePos][0], EntranceData[id][entrancePos][1], EntranceData[id][entrancePos][2]);
		    SetPlayerInterior(playerid, EntranceData[id][entranceExterior]);

			SetPlayerVirtualWorld(playerid, EntranceData[id][entranceExteriorVW]);
			PlayerData[playerid][pHouse] = -1;
	        PlayerData[playerid][pIsyeri] = -1;
	        PlayerData[playerid][pGarage] = -1;
            PlayerData[playerid][pCadir] = -1;
		    SunucuMesaji(playerid, "%d idli binaya ���nald�.", id);
			Spawned[playerid] = 1;
		    return 1;
		}
		else if (!strcmp(type, "gate", true))
		{
		    if (sscanf(string, "d", id))
		        return KullanimMesajGonder(playerid, "/goto [gate] [gate ID]");

			if ((id < 0 || id >= MAX_GATES) || !GateData[id][gateExists])
			    return HataMesajGonder(playerid, "Ge�ersiz bir kap� kimli�i belirttiniz.");
			Spawned[playerid] = 0;
		    SetPlayerPos(playerid, GateData[id][gatePos][0] - (2.5 * floatsin(-GateData[id][gatePos][3], degrees)), GateData[id][gatePos][1] - (2.5 * floatcos(-GateData[id][gatePos][3], degrees)), GateData[id][gatePos][2]);
		    SetPlayerInterior(playerid, GateData[id][gateInterior]);

			SetPlayerVirtualWorld(playerid, GateData[id][gateWorld]);
			PlayerData[playerid][pHouse] = -1;
	        PlayerData[playerid][pIsyeri] = -1;
	        PlayerData[playerid][pGarage] = -1;
	        PlayerData[playerid][pCadir] = -1;
		    SunucuMesaji(playerid, "ID: %d numaral� gate'e g�nderildin.", id);
			Spawned[playerid] = 1;
		    return 1;
		}
		else if (!strcmp(type, "interior", true))
		{
		    static
		        str[1536];

			str[0] = '\0';

			for (new i = 0; i < sizeof(g_arrInteriorData); i ++) {
			    strcat(str, g_arrInteriorData[i][e_InteriorName]);
			    strcat(str, "\n");
		    }
		    Dialog_Show(playerid, TeleportInterior, DIALOG_STYLE_LIST, "I��nlan: Interior Listesi", str, "Se�", "Kapat");
		    return 1;
		}
		else if (!strcmp(type, "garaj", true))
		{
		    if (sscanf(string, "d", id))
		        return KullanimMesajGonder(playerid, "/goto [garaj] [garaj ID]");

			if ((id < 0 || id >= MAX_GARAGE) || GarageData[id][gExists] == false)
			    return HataMesajGonder(playerid, "Ge�ersiz ID girdiniz.");
			Spawned[playerid] = 0;
			SetPlayerPos(playerid, GarageData[id][gPos][0], GarageData[id][gPos][1], GarageData[id][gPos][2]);
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			PlayerData[playerid][pHouse] = -1;
	        PlayerData[playerid][pIsyeri] = -1;
	        PlayerData[playerid][pGarage] = -1;
			PlayerData[playerid][pCadir] = -1;
			Spawned[playerid] = 1;
			return 1;
  		}
		if (!strcmp(type, "lv", true)) {
			Spawned[playerid] = 0;
		    SetPlayerPos(playerid, 1699.2,1435.1,10.7);
	        SetPlayerInterior(playerid, 0);
	        SetPlayerVirtualWorld(playerid, 0);
	        PlayerData[playerid][pHouse] = -1;
	        PlayerData[playerid][pIsyeri] = -1;
	        PlayerData[playerid][pGarage] = -1;
			PlayerData[playerid][pCadir] = -1;
			Spawned[playerid] = 1;
		    return SunucuMesaji(playerid, "Las Venturas'a ���nland�n.");
		}
		if (!strcmp(type, "sf", true)) {
			Spawned[playerid] = 0;
	        SetPlayerPos(playerid, -1417.0,-295.8,14.1);
	        SetPlayerInterior(playerid, 0);
	        SetPlayerVirtualWorld(playerid, 0);
	        PlayerData[playerid][pHouse] = -1;
	        PlayerData[playerid][pIsyeri] = -1;
	        PlayerData[playerid][pGarage] = -1;
			PlayerData[playerid][pCadir] = -1;
			Spawned[playerid] = 1;
		    return SunucuMesaji(playerid, "Varsay�lan S.F. noktas�na g�nderildin.");
		}
	    else return HataMesajGonder(playerid, "Belirtti�iniz oyuncu oyunda de�il !");
	}
	if (!OyundaDegil(id))
		return HataMesajGonder(playerid, "Bu ki�i giri� yapmam��.");

	if(PlayerData[id][pAdmin] > PlayerData[playerid][pAdmin])
		return HataMesajGonder(playerid, "Kendinizden y�ksek seviye yetkililere kar�� bu komutu kullanamazs�n�z.");
	Spawned[playerid] = 0;
	SendPlayerToPlayer(playerid, id);
	MesajGonder(playerid, "%s (%d) adl� ki�inin yan�na ���nland�n�z.", ReturnName(id, 0), id);
	Spawned[playerid] = 1;
	return 1;
}
CMD:gethere(playerid, params[])
{
    static
        userid;

    if (PlayerData[playerid][pAdmin] < 1)
        return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

    if (sscanf(params, "u", userid))
        return KullanimMesajGonder(playerid, "/gethere [id/isim]");

    if (!OyundaDegil(userid) || IsPlayerNPC(userid))
        return HataMesajGonder(playerid, "Belirtti�iniz oyuncu oyunda de�il !");

	if(PlayerData[userid][pAdmin] > PlayerData[playerid][pAdmin])
		return HataMesajGonder(playerid, "Kendinizden y�ksek seviye yetkililere kar�� bu komutu kullanamazs�n�z.");
	PlayerData[userid][pLegalTeleport] = gettime() + 2;
	Spawned[userid] = 0;
    SendPlayerToPlayer(userid, playerid);
    MesajGonder(playerid, "%s adl� oyuncuyu yan�na �ektin.", ReturnName(userid, 0));
    BilgiMesajGonder(userid, "%s adl� yetkili seni yan�na �ekti.", PlayerData[playerid][pAdminName]);
	Spawned[userid] = 1;
    return 1;
}

CMD:get(playerid, params[])
{
    static
        userid;

    if (PlayerData[playerid][pHelper] < 2 && !PlayerData[playerid][pForumGorevlisi] && !PlayerData[playerid][pOyunGorevlisi])
        return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

    if (sscanf(params, "u", userid))
        return KullanimMesajGonder(playerid, "/get [id/isim]");

    if (!OyundaDegil(userid) || IsPlayerNPC(userid))
        return HataMesajGonder(playerid, "Belirtti�iniz oyuncu oyunda de�il!");

    if (PlayerData[userid][pAdmin] > 0)
    	return HataMesajGonder(playerid, "Adminleri yan�n�za �ekemezsiniz.");

    new rank[20];
	if (PlayerData[playerid][pHelper] > 0) format(rank, sizeof(rank), "(Lv. %d) Helper", PlayerData[playerid][pHelper]);
	else format(rank, sizeof(rank), "%s", GetAdminRank(playerid));
    PlayerData[userid][pLegalTeleport] = gettime() + 2;
	Spawned[userid] = 0;
	SendPlayerToPlayer(userid, playerid);
    AdminHelperMessage(COLOR_LIGHTRED, "ADM: %s %s, %s(%d) adl� ki�iyi yan�na �ekti", rank, PlayerData[playerid][pAdminName], ReturnName(userid, 0), userid);
    MesajGonder(playerid, "%s(ID: %d) adl� oyuncuyu yan�na �ektin.", ReturnName(userid, 0), userid);
    BilgiMesajGonder(userid, "%s adl� yetkili seni yan�na �ekti.", PlayerData[playerid][pAdminName]);
	Spawned[userid] = 1;
	return 1;
}

CMD:go(playerid, params[])
{
	static
	    userid;

	if (PlayerData[playerid][pHelper] < 2 && !PlayerData[playerid][pForumGorevlisi] && !PlayerData[playerid][pOyunGorevlisi])
	    return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

 	if (sscanf(params, "u", userid))
	    return KullanimMesaji(playerid, "/go [playerid]");

    if (!OyundaDegil(userid) || IsPlayerNPC(userid))
        return HataMesajGonder(playerid, "Belirtti�iniz oyuncu oyunda de�il !");

    if (PlayerData[userid][pAdmin] > PlayerData[playerid][pAdmin])
	    return HataMesajGonder(playerid, "Belirtilen oyuncu sizden y�ksek yetkiye sahiptir.");

    new rank[20];
    if (PlayerData[playerid][pHelper] > 0) format(rank, sizeof(rank), "(Lv. %d) Helper", PlayerData[playerid][pHelper]);
	else format(rank, sizeof(rank), "%s", GetAdminRank(playerid));
    PlayerData[playerid][pLegalTeleport] = gettime() + 2;
	Spawned[playerid] = 0;
	SendPlayerToPlayer(playerid, userid);
	AdminHelperMessage(COLOR_LIGHTRED, "ADM: %s %s, %s(%d) adl� ki�inin yan�na ���nland�.", rank, PlayerData[playerid][pAdminName], ReturnName(userid, 0), userid);
	Spawned[playerid] = 1;
	return 1;
}
CMD:setinterior(playerid, params[])
{
    static
        userid,
        interior;

    if (PlayerData[playerid][pAdmin] < 1)
        return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

    if (sscanf(params, "ud", userid, interior))
        return KullanimMesajGonder(playerid, "/setinterior [id/isim] [interior]");

    if (!OyundaDegil(userid) || IsPlayerNPC(userid))
        return HataMesajGonder(playerid, "Belirtti�iniz oyuncu oyunda de�il !");

    SetPlayerInterior(userid, interior);

    MesajGonder(playerid, "%s adl� oyuncunun interiorunu (%d) olarak de�i�tirdin.", ReturnName(userid, 0), interior);
    return 1;
}
CMD:vwduzelt(playerid, params[])
{
	if(GetPlayerInterior(playerid) == 0 && GetPlayerVirtualWorld(playerid) > 0 && Entrance_Inside(playerid) == -1 && Business_Inside(playerid) == -1 && House_Inside(playerid) == -1)
	{
	    SetPlayerVirtualWorld(playerid, 0);
	    MesajGonder(playerid, "Virtual world sorununuz d�zeltildi.");
	}
	else HataMesajGonder(playerid, "Virtual worldunuzda sorun yok ya da interiordas�n�z.");
    return 1;
}
CMD:setvw(playerid, params[])
{
    static
        userid,
        world;

    if (PlayerData[playerid][pAdmin] < 1)
        return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

    if (sscanf(params, "ud", userid, world))
        return KullanimMesajGonder(playerid, "/setvw [id/isim] [world]");

    if (!OyundaDegil(userid) || IsPlayerNPC(userid))
        return HataMesajGonder(playerid, "Belirtti�iniz oyuncu oyunda de�il !");

    SetPlayerVirtualWorld(userid, world);

    MesajGonder(playerid, "%s adl� oyuncunun virtual worldunu (%d) olarak de�i�tirdin.", ReturnName(userid, 0), world);
    return 1;
}
CMD:sendto(playerid, params[])
{
    static
        userid,
        targetid;

    if (PlayerData[playerid][pAdmin] < 1 && PlayerData[playerid][pHelper] < 3)
        return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

    if (sscanf(params, "uu", userid, targetid) )
        return KullanimMesajGonder(playerid, "/sendto [id/isim] [id/isim]");

    if (!OyundaDegil(userid) || targetid == INVALID_PLAYER_ID || IsPlayerNPC(userid))
        return HataMesajGonder(playerid, "Belirtilen kullan�c�(lar) ba�l� de�ildir.");

    SendPlayerToPlayer(userid, targetid);
    PlayerData[userid][pLegalTeleport] = gettime() + 2;
    PlayerData[targetid][pLegalTeleport] = gettime() + 2;
    MesajGonder(playerid, "%s adl� oyuncuyu %s adl� oyuncunun yan�na g�nderdin.", ReturnName(userid, 0), ReturnName(targetid));
	BilgiMesajGonder(userid, "%s adl� yetkili seni %s adl� oyuncunun yan�na g�nderdi.", PlayerData[playerid][pAdminName], ReturnName(targetid));
    return 1;
}
CMD:ip(playerid, params[])
{
    static
        userid;

    if (PlayerData[playerid][pAdmin] < 2)
        return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

    if (sscanf(params, "u", userid))
        return KullanimMesajGonder(playerid, "/ip [id/isim]");

    if (!IsPlayerConnected(userid))
        return HataMesajGonder(playerid, "Belirtti�iniz oyuncu oyunda de�il !");

	new pip[15];
	GetPlayerIp(userid, pip, sizeof(pip));
    MesajGonder(playerid, "%s adl� oyuncunun IP adresi: %s", ReturnName(userid, 0), pip);
    return 1;
}
CMD:sethp(playerid, params[])
{
    static
        userid,
        Float:amount;

    if (PlayerData[playerid][pAdmin] < 1)
        return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

    if (sscanf(params, "uf", userid, amount))
        return KullanimMesajGonder(playerid, "/sethp [id/isim] [de�er]");

    if (!OyundaDegil(userid))
        return HataMesajGonder(playerid, "Belirtti�iniz oyuncu oyunda de�il !");

    CanAyarla(userid, amount);
    MesajGonder(playerid, "%s adl� oyuncunun can�n� %.2f olarak de�i�tirdin.", ReturnName(userid, 0), amount);
    return 1;
}

CMD:setarmor(playerid, params[])
{
    static
        userid,
        Float:amount;

    if (PlayerData[playerid][pAdmin] < 2)
        return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

    if (sscanf(params, "uf", userid, amount))
        return KullanimMesajGonder(playerid, "/armor [id/isim] [amount]");

    if (!OyundaDegil(userid))
        return HataMesajGonder(playerid, "Belirtti�iniz oyuncu oyunda de�il !");

    ZirhAyarla(userid, amount);
    MesajGonder(playerid, "%s adl� oyuncunun z�rh�n� %.2f olarak de�i�tirdin.", ReturnName(userid, 0), amount);
    return 1;
}
CMD:resetweps(playerid, params[])
{
    static
        userid;

    if (PlayerData[playerid][pAdmin] < 3)
        return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

    if (sscanf(params, "u", userid))
        return KullanimMesajGonder(playerid, "/resetweps [id/isim]");

    if (!OyundaDegil(userid))
        return HataMesajGonder(playerid, "Belirtti�iniz oyuncu oyunda de�il !");

    ResetWeapons(userid);
    MesajGonder(playerid, "%s adl� oyuncunun silahlar�n� s�f�rlad�n�z.", ReturnName(userid, 0));
	BilgiMesajGonder(userid, "%s adl� yetkili taraf�ndan silahlar�n�z s�f�rland�.", PlayerData[playerid][pAdminName]);
    return 1;
}

CMD:atamir(playerid, params[])
{
    new vehicleid = GetPlayerVehicleID(playerid);

    if (PlayerData[playerid][pAdmin] < 1)
        return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

    if (vehicleid > 0 && isnull(params))
    {
        RepairVehicle(vehicleid);
        BilgiMesajGonder(playerid, "Bulundu�unuz ara� tamir edildi.");
		AdminMessage(COLOR_LIGHTRED, "%s %s, admin komutu ile arac�n� tamir etti.", GetAdminRank(playerid), PlayerData[playerid][pAdminName]);
   	    Log_Write("logs/atamir.log", "[%s] %s %s, admin komutu ile arac�n� tamir etti.", ReturnDate(), GetAdminRank(playerid), PlayerData[playerid][pAdminName]);
    }
    else
    {
        if (sscanf(params, "d", vehicleid))
            return KullanimMesajGonder(playerid, "/atamir [ara� ID]");

        else if (!IsValidVehicle(vehicleid))
            return HataMesajGonder(playerid, "Ge�ersiz bir ara� ID's� belirttiniz.");

        RepairVehicle(vehicleid);
        BilgiMesajGonder(playerid, "Ara� ID: %d tamir edildi.  ", vehicleid);
    }
    return 1;
}

CMD:getcar(playerid, params[])
{
    new vehicleid;

    if (PlayerData[playerid][pAdmin] < 1 && PlayerData[playerid][pHelper] < 2 && !PlayerData[playerid][pOyunGorevlisi] && !PlayerData[playerid][pForumGorevlisi])
        return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

    if (sscanf(params, "d", vehicleid))
        return KullanimMesajGonder(playerid, "/getcar [Ara� ID]");

    if (vehicleid < 1 || vehicleid > MAX_VEHICLES || !IsValidVehicle(vehicleid))
        return HataMesajGonder(playerid, "Ge�ersiz bir ara� ID's� belirttiniz.");

    static
        Float:px,
        Float:py,
        Float:pz;

    GetPlayerPos(playerid, px, py, pz);
    SetVehiclePos(vehicleid, px + 2, py - 2, pz);

    SetVehicleVirtualWorld(vehicleid, GetPlayerVirtualWorld(playerid));
    LinkVehicleToInteriorEx(vehicleid, GetPlayerInterior(playerid));
    new rank[20];
	if (PlayerData[playerid][pHelper] > 0) format(rank, sizeof(rank), "(Lv. %d) Helper", PlayerData[playerid][pHelper]);
	else format(rank, sizeof(rank), "%s", GetAdminRank(playerid));
    AdminHelperMessage(COLOR_LIGHTRED, "ADM: %s %s, %s (%d) arac� yan�na �ekti.", rank, PlayerData[playerid][pAdminName], ReturnVehicleModelName(GetVehicleModel(vehicleid)), vehicleid);
    return 1;
}


CMD:carto(playerid, params[])
{
    new vehicleid, userid;

    if (PlayerData[playerid][pAdmin] < 1)
        return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

    if (sscanf(params, "du", vehicleid, userid))
        return KullanimMesajGonder(playerid, "/carto [ara�] [userid]");

    if (vehicleid < 1 || vehicleid > MAX_VEHICLES || !IsValidVehicle(vehicleid))
        return HataMesajGonder(playerid, "Ge�ersiz bir ara� ID's� belirttiniz.");

    static
        Float:px,
        Float:py,
        Float:pz;

    GetPlayerPos(userid, px, py, pz);
    SetVehiclePos(vehicleid, px + 2, py - 2, pz);

    SetVehicleVirtualWorld(vehicleid, GetPlayerVirtualWorld(userid));
    LinkVehicleToInteriorEx(vehicleid, GetPlayerInterior(userid));

    return 1;
}
CMD:entercar(playerid, params[])
{
    new vehicleid, seatid;

    if (PlayerData[playerid][pAdmin] < 1)
        return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

    if (sscanf(params, "d", vehicleid))
        return KullanimMesajGonder(playerid, "/entercar [ara� id]");

    if (vehicleid < 1 || vehicleid > MAX_VEHICLES || !IsValidVehicle(vehicleid))
        return HataMesajGonder(playerid, "Ge�ersiz bir ara� ID's� belirttiniz.");

    seatid = GetAvailableSeat(vehicleid, 0);

    if (seatid == -1)
        return HataMesajGonder(playerid, "Ara�ta bo� koltuk yok.");
	Spawned[playerid] = 0;
    PlayerData[playerid][pLegalTeleport] = gettime() + 2;
	PutPlayerInVehicle(playerid, vehicleid, seatid);
	Spawned[playerid] = 1;
	return 1;
}

CMD:gotocar(playerid, params[])
{
    new vehicleid;

    if (PlayerData[playerid][pAdmin] < 1 && PlayerData[playerid][pHelper] < 2 && !PlayerData[playerid][pOyunGorevlisi] && !PlayerData[playerid][pForumGorevlisi])
        return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

    if (sscanf(params, "d", vehicleid))
        return KullanimMesajGonder(playerid, "/gotocar [ara� id]");

    if (vehicleid < 1 || vehicleid > MAX_VEHICLES || !IsValidVehicle(vehicleid))
        return HataMesajGonder(playerid, "Ge�ersiz bir ara� ID's� belirttiniz.");

    static
        Float:px,
        Float:py,
        Float:pz;
	Spawned[playerid] = 0;
    PlayerData[playerid][pLegalTeleport] = gettime() + 2;
	GetVehiclePos(vehicleid, px, py, pz);
    SetPlayerPos(playerid, px, py - 2, pz + 2);
    new rank[20];
	if (PlayerData[playerid][pHelper] > 0) format(rank, sizeof(rank), "(Lv. %d) Helper", PlayerData[playerid][pHelper]);
	else format(rank, sizeof(rank), "%s", GetAdminRank(playerid));
	AdminHelperMessage(COLOR_LIGHTRED, "ADM: %s %s, %s (%d) model arac�n yan�na ���nland�.", rank, PlayerData[playerid][pAdminName], ReturnVehicleModelName(GetVehicleModel(vehicleid)), vehicleid);
	Spawned[playerid] = 1;
	return 1;
}
CMD:akirasifirla(playerid, params[])
{
    if (PlayerData[playerid][pAdmin] < 4)
        return HataMesaji(playerid, "Yeterli yetkiniz yok!");

     for (new i = 0; i != MAX_ARAC; i ++) if(AracInfo[i][aracKira] == 1)
     {
        AracInfo[i][aracKiralayan] = -1;
        AracInfo[i][aracKiraZaman] = 1;
        AracInfo[i][aracKilit] = false;
        new real = Car_GetID(i);
        Arac_Spawn(real);
        Arac_Kaydet(i);
    }
    AdminMessage(COLOR_LIGHTRED, "ADM: %s %s adl� admin t�m kiral�k ara�lar� s�f�rlad�.", GetAdminRank(playerid), PlayerData[playerid][pAdminName]);
    return 1;
}
CMD:respawncar(playerid, params[])
{
    new vehicleid;

    if (PlayerData[playerid][pAdmin] < 1 && PlayerData[playerid][pHelper] < 2 && !PlayerData[playerid][pOyunGorevlisi] && !PlayerData[playerid][pForumGorevlisi])
        return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

    if (sscanf(params, "d", vehicleid))
        return KullanimMesajGonder(playerid, "/respawncar [Ara� ID]");

    if (vehicleid < 1 || vehicleid > MAX_VEHICLES || !IsValidVehicle(vehicleid))
        return HataMesajGonder(playerid, "Ge�ersiz bir ara� ID's� belirttiniz.");

	Arac_Spawn(Car_GetID(vehicleid));

 	new rank[20];
	if (PlayerData[playerid][pHelper] > 0) format(rank, sizeof(rank), "(Lv. %d) Helper", PlayerData[playerid][pHelper]);
	else format(rank, sizeof(rank), "%s", GetAdminRank(playerid));
	AdminHelperMessage(COLOR_LIGHTRED, "ADM: %s %s, %s (%d) model arac� spawnlad�.", rank, PlayerData[playerid][pAdminName], ReturnVehicleModelName(GetVehicleModel(vehicleid)), vehicleid);
    BilgiMesajGonder(playerid, "%d idli arac� spawnlad�n.", vehicleid);
	return 1;
}

CMD:respawncars(playerid, params[])
{
    if (PlayerData[playerid][pAdmin] < 1)
        return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

	new sure = 0;

	if (sscanf(params, "d", sure))
	    return KullanimMesajGonder(playerid, "/respawncars [S�re]");

	if (sure < 1)
	    return HataMesajGonder(playerid, "S�reyi en az 1 girebilirsin.");

	foreach (new i : Player)
	{
	    SendClientMessageEx(i, COLOR_LIGHTRED, "[!] %s isimli yetkili %d saniye sonra kullan�lmayan t�m ara�lar� respawnlayacak!", PlayerData[playerid][pAdminName], sure);
	}

	SetTimerEx("AraclariSpawnla", sure*1000, false, "d", playerid);
    return 1;
}
CMD:maspawn(playerid)
{
    if (PlayerData[playerid][pAdmin] < 1)
        return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

    new count;

	for (new i = 0; i < MAX_ARAC; i++)
    {
		if (AracInfo[i][aracExists] && AracInfo[i][aracTip] == 2 && GetVehicleDriver(AracInfo[i][aracVehicle]) != -1)
		{
			Arac_Spawn(i);
	        count++;
		}
	}

    if (!count)
		return HataMesajGonder(playerid, "Hi� meslek arac� yok.");

	MesajGonder(playerid, "Toplam %d meslek arac� respawn edildi.", count);
	return 1;
}
CMD:vaspawn(playerid)
{
    if (PlayerData[playerid][pAdmin] < 1)
        return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

    new count;

	for (new i = 0; i < MAX_ARAC; i++)
    {
		if (AracInfo[i][aracExists] && AracInfo[i][aracTip] == 5 && GetVehicleDriver(AracInfo[i][aracVehicle]) != -1)
		{
			Arac_Spawn(i);
	        count++;
		}
	}

    if (!count)
		return HataMesajGonder(playerid, "Hi� vip arac� yok.");

	MesajGonder(playerid, "Toplam %d vip arac� respawn edildi.", count);
	return 1;
}

CMD:giveweapon(playerid, params[])
{
    static
        userid,
        weaponid,
        ammo;

    if (PlayerData[playerid][pAdmin] < 4)
        return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

    if (sscanf(params, "udI(500)", userid, weaponid, ammo))
        return KullanimMesajGonder(playerid, "/giveweapon [id/isim] [silahid] [mermi]");

    if (!OyundaDegil(userid))
        return HataMesajGonder(playerid, "Belirtti�iniz oyuncu oyunda de�il.");

    if (weaponid <= 0 || weaponid > 46 || (weaponid >= 19 && weaponid <= 21))
        return HataMesajGonder(playerid, "Ge�ersiz silah ID's�.");

    GiveWeaponToPlayer(userid, weaponid, ammo);
    MesajGonder(playerid, "%s adl� oyuncuya %s (%d mermi) model silah verdin.", ReturnName(userid, 0), ReturnWeaponName(weaponid), ammo);
    BilgiMesajGonder(userid, "%s adl� yetkili sana %s (Mermi: %d) model silah verdi.", PlayerData[playerid][pAdminName], ReturnWeaponName(weaponid), ammo);
    return 1;
}

CMD:cc(playerid, params[])
{
    if (PlayerData[playerid][pAdmin] < 2)
        return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

    for (new i = 0; i < 100; i ++) {
        SendClientMessageToAll(-1, "");
    }
    return 1;
}
CMD:asetfaction(playerid, params[])
{
    static
        userid,
        id;

    if (PlayerData[playerid][pAdmin] < 3)
        return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

    if (sscanf(params, "ud", userid, id))
        return KullanimMesajGonder(playerid, "/asetfaction [id/isim] [faction id] (-1 atar)");

    if (!OyundaDegil(userid))
        return HataMesajGonder(playerid, "Belirtti�iniz oyuncu oyunda de�il !");

    if ((id < -1 || id >= MAX_BIRLIK) || (id != -1 && !Birlikler[id][birlikExists]))
        return HataMesajGonder(playerid, "Ge�ersiz birlik id.");

    if (id == -1)
    {
        BirliktenAt(userid);

        BilgiMesajGonder(playerid, "%s adl� ki�i birlikten ��kar�ld�.", ReturnName(userid, 0));
        BilgiMesajGonder(userid, "%s adl� yetkili taraf�ndan birlikten ��kar�ld�n�z.", PlayerData[playerid][pAdminName]);
        Oyuncu_Kaydet(userid);
    }
    else
    {
        BirliktenAt(userid);
        PlayerData[userid][pFaction] = id;
	    PlayerData[userid][pFactionRutbe] = 1;
	    PlayerData[userid][pFactionDivizyon] = 0;

		Oyuncu_Kaydet(userid);
        MesajGonder(playerid, "%s adl� ki�iyi \"%s\" adl� birli�e ald�n�z.", ReturnName(userid, 0), Birlikler[id][birlikAd]);
        BilgiMesajGonder(userid, "%s adl� yetkili sizi \"%s\" adl� birli�e ald�.", PlayerData[playerid][pAdminName], Birlikler[id][birlikAd]);
    }
    return 1;
}

CMD:asetrank(playerid, params[])
{
    static
        userid,
        rank,
        factionid;

    if (PlayerData[playerid][pAdmin] < 3)
        return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

    if (sscanf(params, "ud", userid, rank))
        return KullanimMesajGonder(playerid, "/asetrank [id/isim] [rutbe id]");

    if (!OyundaDegil(userid))
        return HataMesajGonder(playerid, "Belirtti�iniz oyuncu oyunda de�il !");

    if ((factionid = PlayerData[userid][pFaction]) == -1)
        return HataMesajGonder(playerid, "Bu oyuncu herhangi bir birli�in �yesi de�il.");

    if (rank < 1 || rank > Birlikler[factionid][birlikRutbeler])
        return HataMesajGonder(playerid, "Ge�ersiz r�tbe. R�tbe 1 ile %d aras�nda olmal�d�r.", Birlikler[factionid][birlikRutbeler]);

    PlayerData[userid][pFactionRutbe] = rank;

    MesajGonder(playerid, "%s adl� ki�inin r�tbesi %d olarak de�i�tirildi.", ReturnName(userid, 0), rank);
    BilgiMesajGonder(userid, "%s adl� yetkili taraf�ndan birlikteki r�tbeniz %d olarak ayarland�.", PlayerData[playerid][pAdminName], rank);

    return 1;
}
CMD:spec(playerid, params[])
{
	if (PlayerData[playerid][pAdmin] < 1 && PlayerData[playerid][pOyunGorevlisi] < 1) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
    new id;
    if (sscanf(params, "u", id)) return KullanimMesajGonder(playerid, "/spec [ID/Isim]");
    if (!OyundaDegil(id)) return HataMesajGonder(playerid, "�zlemek istedi�in ki�i oyunda de�il.");
    if (id == playerid) return HataMesajGonder(playerid, "Kendini izleyemezsin.");
    PlayerData[playerid][pSpecID] = id;
    if (GetPlayerState(playerid) != PLAYER_STATE_SPECTATING)
    {
        GetPlayerPos(playerid, specPos[playerid][0], specPos[playerid][1], specPos[playerid][2]);
        SetPVarInt(playerid, "specVw", GetPlayerVirtualWorld(playerid));
        SetPVarInt(playerid, "specInterior", GetPlayerInterior(playerid));
    }
    SetPlayerInterior(playerid, GetPlayerInterior(id));
    SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(id));
    TogglePlayerSpectating(playerid, true);
    if (IsPlayerInAnyVehicle(id))
    {
        PlayerSpectateVehicle(playerid, GetPlayerVehicleID(id));
    }
    else
    {
        PlayerSpectatePlayer(playerid, id);
    }
    MesajGonder(playerid, "�zlenen oyuncu : %s (Para %s, Can %d, Z�rh %d, Level %d)", ReturnName(id, 0), FormatNumber(PlayerData[id][pCash]), PlayerData[id][pHealth], PlayerData[id][pArmour], FormatNumber(PlayerData[id][pLevel]));
	MesajGonder(playerid, "/specoff ile ��kabilirsin.", ReturnName(id, 0));
	return 1;
}
CMD:specoff(playerid, params[])
{
    if (PlayerData[playerid][pAdmin] < 1 && PlayerData[playerid][pOyunGorevlisi] < 1)
        return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

    IzlemeBitir(playerid);
    return 1;
}

CMD:jail(playerid, params[])
{
	static userid, sure, sebep[50];

	if (playerid != INVALID_PLAYER_ID)
	{
		if (PlayerData[playerid][pAdmin] < 1 && PlayerData[playerid][pHelper] < 5 && !PlayerData[playerid][pForumGorevlisi] && !PlayerData[playerid][pOyunGorevlisi]) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
	}

	if (sscanf(params, "uds[50]", userid, sure, sebep)) return KullanimMesajGonder(playerid, "/jail [id/isim] [dakika] [sebep]");
	if (!OyundaDegil(userid)) return HataMesajGonder(playerid, "Oyuncu oyunda de�il.");
	if (sure < 1) return HataMesajGonder(playerid, "En az 1 dakika girmelisiniz.");
	if (PlayerData[userid][pHapisSure] > 0 && PlayerData[userid][pCK] == 1) return HataMesajGonder(playerid, "Bu karakter CK edilmi�.");
	if(sure > 1000 && PlayerData[playerid][pForumGorevlisi] && !PlayerData[playerid][pOyunGorevlisi] && PlayerData[playerid][pAdmin] < 1) return HataMesajGonder(playerid, "Forum g�revlileri en fazla 1000dk. hapise g�nderebilir.");
    ResetPlayer(userid);
    ResetWeapons(userid);
    ClearAnimations(userid);
	PlayerTextDrawShow(userid, HapisTD[userid]);
	SetPlayerPos(userid, 1393.3469,960.4508,3016.7773);

	SetPlayerInPrison(userid);
    SetPlayerFacingAngle(userid, 0.0);

    SetCameraBehindPlayer(userid);
    PlayerData[userid][pHapisSure] = sure * 60;
    format(PlayerData[userid][pHapisSebep], 50, sebep);

	if (playerid != INVALID_PLAYER_ID)
		format(PlayerData[userid][pHapiseAtan], 24, PlayerData[playerid][pAdminName]);

	if (playerid == INVALID_PLAYER_ID)
        format(PlayerData[userid][pHapiseAtan], 24, "Sistem");

	PlayerData[userid][pHapis] = 0;

    new query[500];

	if (playerid != INVALID_PLAYER_ID)
    	mysql_format(g_SQL, query, sizeof(query), "INSERT INTO `oocsicil` (`ID`, `Tarih`, `Sebep`, `Uygulayan`, `Tur`) VALUES('%d', '%s', '%s', '%s', '3')",  PlayerData[userid][pID], ReturnDate(), sebep, PlayerData[playerid][pAdminName]);

    if (playerid == INVALID_PLAYER_ID)
    	mysql_format(g_SQL, query, sizeof(query), "INSERT INTO `oocsicil` (`ID`, `Tarih`, `Sebep`, `Uygulayan`, `Tur`) VALUES('%d', '%s', '%s', '%s', '3')",  PlayerData[userid][pID], ReturnDate(), sebep, "Sistem");

	mysql_query (g_SQL, query);

	if (playerid != INVALID_PLAYER_ID)
		BilgiMesajGonder(userid, "%s adl� yetkili seni %d dakika hapse att�. (%s).", PlayerData[playerid][pAdminName], sure, sebep);

    if (playerid == INVALID_PLAYER_ID)
		BilgiMesajGonder(userid, "Sistem taraf�ndan %d dakika hapse g�nderildin. (%s).", sure, sebep);

	foreach (new i:Player) if (PlayerData[i][pAyarlar][3] == 0 || i == userid)
	{
	    if (playerid != INVALID_PLAYER_ID)
    		SendClientMessageEx(i, 0xC87C0000, "[Ceza]{808080} %s, %s taraf�ndan %s sebebiyle %d dakika hapise g�nderildi. (%s)", ReturnName(userid, 0), PlayerData[playerid][pAdminName], sebep, sure, ReturnDate());

		if (playerid == INVALID_PLAYER_ID)
            SendClientMessageEx(i, 0xC87C0000, "[Ceza]{808080} %s, Sistem taraf�ndan %s sebebiyle %d dakika cezaland�r�ld�. (%s)", ReturnName(userid, 0), sebep, sure, ReturnDate());
	}

    Log_Write("logs/jail_log.txt", "[%s] %s adli yetkili %s adli oyuncuyu %d dakika cezalandirdi,  sebep: %s.", ReturnDate(), PlayerData[playerid][pAdminName], ReturnName(userid, 0), sure, sebep);
	return 1;
}

CMD:unjail(playerid, params[])
{
    static
        userid;

    if (PlayerData[playerid][pAdmin] < 1 && PlayerData[playerid][pHelper] < 5 && !PlayerData[playerid][pForumGorevlisi] && !PlayerData[playerid][pOyunGorevlisi])
        return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

    if (sscanf(params, "u", userid))
        return KullanimMesajGonder(playerid, "/unjail [id/isim]");

    if (!OyundaDegil(userid))
        return HataMesajGonder(playerid, "Belirtti�iniz oyuncu oyunda de�il !");

    if (!PlayerData[userid][pHapisSure])
        return HataMesajGonder(playerid, "Belirtti�iniz oyuncu hapiste de�il.");
    if (PlayerData[userid][pCK] == 1) return HataMesajGonder(playerid, "Bu karakter CK edilmi�, hapisten ��kar�lamaz.");

    PlayerData[userid][pHapisSure] = 1;

    MesajGonder(playerid, "%s adl� oyuncuyu hapisten ��kartt�n�z.", ReturnName(userid, 0));
    BilgiMesajGonder(userid, "%s adl� yetkili sizi hapisten ��kartt�.", PlayerData[playerid][pAdminName]);

    Log_Write("logs/jail_log.txt", "[%s] %s adli yetkili %s adli oyuncuyu hapisten cikartti.", ReturnDate(), PlayerData[playerid][pAdminName], ReturnName(userid, 0));
    return 1;
}
CMD:ojail(playerid, params[])
{
	new ad[24], sure, sebep[50];
    if (PlayerData[playerid][pAdmin] < 1 && !PlayerData[playerid][pForumGorevlisi] && !PlayerData[playerid][pOyunGorevlisi])
        return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
    if (sscanf(params, "s[24]is[50]", ad, sure, sebep)) return KullanimMesajGonder(playerid, "/ojail [Karakter Ad�] [Dakika] [Sebep]");
    if (sure < 1) return HataMesajGonder(playerid, "En az 1 dakika girmelisiniz.");
 	if(sure > 1000 && PlayerData[playerid][pForumGorevlisi] && !PlayerData[playerid][pOyunGorevlisi] && PlayerData[playerid][pAdmin] < 1) return HataMesajGonder(playerid, "Forum g�revlileri en fazla 1000dk. hapise g�nderebilir.");
    if (GetPlayerID(ad) != -1) return HataMesajGonder(playerid, "Bu oyuncu oyunda, /jail komutunu kullan�n.");
    new query[124];
    format(query, sizeof(query), "SELECT * FROM `oyuncular` WHERE `Isim` = '%s'", ad);
    mysql_tquery(g_SQL, query, "OnJailAccount", "isis", playerid, ad, sure, sebep);
	return 1;
}
CMD:jailed(playerid)
{
    if (PlayerData[playerid][pAdmin] < 1) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
    new string[600];
 foreach (new i : Player)
    {
        if (PlayerData[i][pHapisSure] > 1)
        {
            new bilgiler[256];
            format(bilgiler, sizeof(bilgiler), "%s - [ID: %d ] - [Hapis S�resi: %d saniye.]\n", ReturnName(i), i, PlayerData[i][pHapisSure]);
            strcat(string, bilgiler);
        }
    }
    Dialog_Show(playerid, Hapistekiler, DIALOG_STYLE_LIST, "Hapistekiler", string, "Tamam", "");
    return 1;
}

CMD:givecash(playerid, params[])
{
    static
        userid,
        amount;

    if (PlayerData[playerid][pAdmin] < 4)
        return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

    if (sscanf(params, "ud", userid, amount))
        return KullanimMesajGonder(playerid, "/givecash [id/isim] [miktar]");

    if (!OyundaDegil(userid))
        return HataMesajGonder(playerid, "Belirtti�iniz oyuncu oyunda de�il !");

    ParaVer(userid, amount);
	MesajGonder(playerid, "%s adl� ki�iye %s miktar para verdiniz.", ReturnName(userid, 0), FormatNumber(amount));
	BilgiMesajGonder(userid, "%s adl� yetkili size %s miktar para verdi.",PlayerData[playerid][pAdminName], FormatNumber(amount));
    AdminMessage(COLOR_LIGHTRED, "ADM: %s, %s adl� ki�iye %s miktarda para verdi.", PlayerData[playerid][pAdminName], ReturnName(userid, 0), FormatNumber(amount));
    Log_Write("logs/admin.log", "[%s] %s adli yetkili %s adli kisiye %s miktar para verdi.", ReturnDate(), PlayerData[playerid][pAdminName], ReturnName(userid, 0), FormatNumber(amount));

    return 1;
}
CMD:setcash(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 5) return HataMesaji(playerid, "Yeterli yetkiniz yok.");

    static
        userid,
        amount;

    if (sscanf(params, "ud", userid, amount))
        return KullanimMesajGonder(playerid, "/setcash [id/isim] [miktar]");

    if (!OyundaDegil(userid))
        return HataMesajGonder(playerid, "Belirtti�iniz oyuncu oyunda de�il !");

	ParaDuzenle(userid, amount);
	SunucuMesaji(playerid, "%s adl� ki�inin paras�n� %d olarak ayarlad�n�z.", ReturnName(userid, 0), amount);
	AdminMessage(COLOR_LIGHTRED, "ADM: %s %s, %s adl� ki�inin paras�n� %d olarak ayarlad�.", GetAdminRank(playerid), PlayerData[playerid][pAdminName], ReturnName(userid, 0), amount);
	return 1;
}
CMD:givecashall(playerid, params[])
{
	new miktar;
    if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
    if (sscanf(params, "i", miktar)) return KullanimMesajGonder(playerid, "/givecashall [Miktar]");
    foreach (new i:Player) if (OyundaDegil(i))
    {
        ParaVer(i, miktar);
    }
    SendClientMessageToAllEx(COLOR_LIGHTRED, "ADM: %s sunucudaki 1 saatten fazla vakit ge�irmi� herkese bonus ikramiyede bulundu.", PlayerData[playerid][pAdminName]);
	return 1;
}

CMD:kills(playerid, params[])
{
	new id;
    if (PlayerData[playerid][pAdmin] < 1) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
    if (sscanf(params, "u", id)) return KullanimMesajGonder(playerid, "/kills [ID/Isim]");
    if (!OyundaDegil(id)) return HataMesajGonder(playerid, "Oyuncu oyunda de�il.");
    MesajGonder(playerid, "�ld�rme: %d, �lme: %d", PlayerData[id][pOldurme], PlayerData[id][pOlme]);
	return 1;
}

CMD:talepsayi(playerid, params[])
{
    new id;
    if (PlayerData[playerid][pAdmin] < 3) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
    if (sscanf(params, "u", id)) return KullanimMesajGonder(playerid, "/raporsayi [ID/Isim]");
    if (!OyundaDegil(id)) return HataMesajGonder(playerid, "Oyuncu oyunda de�il.");
    MesajGonder(playerid, "Talep Bakma Say�s�: %d", PlayerData[id][pTalepSayi]);
	return 1;
}
CMD:raporkontrol(playerid, params[])
{
	if (PlayerData[playerid][pAdmin] < 4) return YetkinizYok(playerid);
    if (!OyundaDegil(playerid)) return 1;
    if (isnull(params)) return KullanimMesaji(playerid, "/raporkontrol <admin/helper>");

	if (!strcmp(params, "admin", true))
	{
	    new count = 0, str[1000];
	    foreach (new i:Player) if (PlayerData[i][pAdmin] >= 1)
	    {
	        count++;
	        format(str, sizeof(str), "%s{ffffff}Admin: (admin: %s) %s (id: %d) - duty: %s - talep: %d\n", str, GetAdminRank(i), PlayerData[i][pAdminName], i, (PlayerData[i][pAdminDuty] == 1) ? ("{02ef16}M�sait{ffffff}") : ("{ef0202}Me�gul{ffffff}"), PlayerData[i][pTalepSayi]);

	    }
	    if (count == 0) return HataMesajGonder(playerid, "Aktif admin yok.");
	    Dialog_Show(playerid, AdminTalKontrol, DIALOG_STYLE_MSGBOX, "Admin Talpeleri", str, "Kapat", "");
	}
	if (!strcmp(params, "helper", true))
	{
	    new count = 0, str[1000];
	    foreach (new i:Player) if (PlayerData[i][pHelper] >= 1)
	    {
	        count++;
	        format(str, sizeof(str), "%s{ffffff}Helper: (seviye: %d) %s (id: %d) - duty: %s - talep: %d\n", str, PlayerData[i][pHelper], PlayerData[i][pAdminName], i, (PlayerData[i][pHelperDuty] == 1) ? ("{02ef16}M�sait{ffffff}") : ("{ef0202}Me�gul{ffffff}"), PlayerData[i][pTalepSayi]);

	    }
	    if (count == 0) return HataMesajGonder(playerid, "Aktif helper yok.");
	    Dialog_Show(playerid, HelperTalKontrol, DIALOG_STYLE_MSGBOX, "Helper Talpeleri", str, "Kapat", "");
	}
	return 1;
}

CMD:giveexp(playerid, params[])
{
	new id, miktar;
    if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
    if (sscanf(params, "ui", id, miktar)) return KullanimMesajGonder(playerid, "/giveexp [ID/Isim] [Miktar]");
    if (!OyundaDegil(id)) return HataMesajGonder(playerid, "Oyuncu oyunda de�il.");
	PlayerData[id][pEXP] += miktar;
	MesajGonder(id, "%s adl� yetkili size %d EXP verdi.", PlayerData[playerid][pAdminName], miktar);
	MesajGonder(playerid, "%s adl� oyuncuya %d EXP verdiniz.", ReturnName(id, 0), miktar);
	AdminMessage(COLOR_LIGHTRED, "ADM: %s, %s adl� ki�iye %d kadar exp verdi.", PlayerData[playerid][pAdminName], Player_GetName(id), miktar);
	if (PlayerData[id][pEXP] >= PlayerData[id][pLevel]*5)
	{
 		new kalanexp = 0;
   		if (PlayerData[id][pEXP] > PlayerData[id][pLevel]*5) kalanexp = PlayerData[id][pEXP] - PlayerData[id][pLevel]*5;
		PlayerData[id][pEXP] = kalanexp;
		PlayerData[id][pLevel]++;
		SetPlayerScore(id, PlayerData[id][pLevel]);
		MesajGonder(id, "Seviye atlad�n�z!");
		if(PlayerData[id][pLevel] == 5){
			format(PlayerData[id][pBasari5Tarih],25,ReturnDate());
			PlayerData[id][pBasari5] = 1;
		}
		if(PlayerData[id][pLevel] == 10){
			format(PlayerData[id][pBasari10Tarih],25,ReturnDate());
			PlayerData[id][pBasari10] = 1;
		}
	}
	return 1;
}
CMD:giveexpall(playerid, params[])
{
	new miktar;
    if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
    if (sscanf(params, "i", miktar)) return KullanimMesajGonder(playerid, "/giveexpall [Miktar]");
    foreach (new i:Player) if (OyundaDegil(i))
    {
        PlayerData[i][pEXP] += miktar;
		if (PlayerData[i][pEXP] >= PlayerData[i][pLevel]*5)
		{
			new kalanexp = 0;
   			if (PlayerData[i][pEXP] > PlayerData[i][pLevel]*5) kalanexp = PlayerData[i][pEXP] - PlayerData[i][pLevel]*5;
			PlayerData[i][pEXP] = kalanexp;
			PlayerData[i][pLevel]++;
			SetPlayerScore(i, PlayerData[i][pLevel]);
			MesajGonder(i, "Seviye atlad�n�z.");
			if(PlayerData[i][pLevel] == 5){
			format(PlayerData[i][pBasari5Tarih],25,ReturnDate());
			PlayerData[i][pBasari5] = 1;
			}
			if(PlayerData[i][pLevel] == 10){
				format(PlayerData[i][pBasari10Tarih],25,ReturnDate());
				PlayerData[i][pBasari10] = 1;
			}
		}
    }
    SendClientMessageToAllEx(COLOR_LIGHTRED, "ADM: %s %s sunucuda 1 saat ge�irmi� herkese %d miktar exp da��tt�.", GetAdminRank(playerid), PlayerData[playerid][pAdminName], miktar);
	return 1;
}
CMD:ban(playerid, params[])
{
	new id, gun, sebep[50];
    if (PlayerData[playerid][pAdmin] < 1) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
    if (sscanf(params, "uis[50]", id, gun, sebep)) return KullanimMesajGonder(playerid, "/ban [ID/Isim] [G�n (0 yazarsan�z s�n�rs�z yasaklan�r)] [Sebep]");
    if (!OyundaDegil(id)) return HataMesajGonder(playerid, "Oyuncu giri� yapmam��.");
    if (id == playerid) return HataMesajGonder(playerid, "Kendinizi yasaklayamazs�n�z.");
    if (PlayerData[id][pAdmin] > PlayerData[playerid][pAdmin]) return HataMesajGonder(playerid, "Belirtilen oyuncu sizden y�ksek yetkiye sahiptir.");

    new pip[20];
    GetPlayerIp(id, pip, sizeof(pip));
    new sure[10];
    if (gun == 0) sure = "S�n�rs�z";
    else format(sure, sizeof(sure), "%d g�n", gun);
    Dialog_Show(id, Banli, DIALOG_STYLE_MSGBOX, "Yasakland�n�z!", "Hesab�n�z bu sunucudan yasaklanm��t�r. Detaylar;\n\nKarakter Ad�: %s\nSebep: %s\nYasaklayan: %s\nS�re: %s\nF8 tu�una bas�n ve bir ekran g�r�nt�s� al�n, bu ekran g�r�nt�s� ile forumumuzdan yasaklanman�za itiraz edebilirsiniz.", "Kapat", "", Player_GetName(id), sebep, PlayerData[playerid][pAdminName], sure);
    new query[350];
    format(query, sizeof(query), "INSERT INTO `oocsicil` (`ID`, `Tarih`, `Sebep`, `Uygulayan`, `Tur`) VALUES('%d', '%s', '%s', '%s', '2')",  PlayerData[id][pID], ReturnDate(), sebep, PlayerData[playerid][pAdminName]);
    mysql_tquery(g_SQL, query);
    foreach (new i:Player) if (PlayerData[i][pAyarlar][3] == 0 || i == id)
    {
    	if (gun == 0) SendClientMessageEx(i, 0xC87C0000, "[Yasaklama]{808080} %s adl� oyuncu %s taraf�ndan %s sebebiyle sunucudan s�n�rs�z yasakland�. (%s)", ReturnName(id, 0),  PlayerData[playerid][pAdminName], sebep, ReturnDate());
    	else SendClientMessageEx(i, 0xC87C0000, "[Yasaklama]{808080} %s, %s taraf�ndan %s sebebiyle sunucudan %d g�n yasakland�. (%s)", ReturnName(id, 0),  PlayerData[playerid][pAdminName], sebep, gun, ReturnDate());
	}
    Log_Write("logs/ban_log.txt", "[%s] %s,  %s tarafindan %d gun yasaklandi. sebep: %s.", ReturnDate(), ReturnName(id, 0), PlayerData[playerid][pAdminName], gun, sebep);
    new suree;
    if (gun < 1) suree = 0;
    else suree = gettime()+gun*86400;
    AddBan(pip, Player_GetName(id), "", PlayerData[playerid][pAdminName], suree, sebep);
    Kick(id);
	return 1;
}

CMD:banip(playerid, params[])
{
	new ip[30], gun, sebep[50];
    if (PlayerData[playerid][pAdmin] < 1) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
    if (sscanf(params, "s[30]is[50]", ip, gun, sebep)) return KullanimMesajGonder(playerid, "/banip [IP] [G�n (0 yazarsan�z s�n�rs�z yasaklan�r)][Sebep]");
    AddBan(ip, "Yok", "", PlayerData[playerid][pAdminName], (gun < 1) ? (0) : (gettime()+gun*86400), sebep);
    new sure[10];
    if (gun < 1) sure = "S�n�rs�z";
    else format(sure, sizeof(sure), "%d g�n", gun);
    AdminMessage(COLOR_LIGHTRED, "ADM: %s adl� admin %d ipsini %d g�n banlad�.", PlayerData[playerid][pAdminName], ip, sure);
	return 1;
}
CMD:oban(playerid, params[])
{
	new ad[24], gun, sebep[50];
    if (PlayerData[playerid][pAdmin] < 1) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
    if (sscanf(params, "s[24]is[50]", ad, gun, sebep)) return KullanimMesajGonder(playerid, "/oban [Karakter Ad�] [G�n (0 yazarsan�z s�n�rs�z yasaklan�r)] [Sebep]");
    if (GetPlayerID(ad) != -1) return HataMesajGonder(playerid, "Bu oyuncu oyunda, /ban komutunu kullan�n.");
    new query[124];
    format(query, sizeof(query), "SELECT * FROM `oyuncular` WHERE `Isim` = '%s'", ad);
    mysql_tquery(g_SQL, query, "OnBanAccount", "isis", playerid, ad, gun, sebep);
	return 1;
}
/*CMD:ocban(playerid, params[])
{
	new ad[24], sebep[50];
    if (PlayerData[playerid][pAdmin] < 3) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
    if (sscanf(params, "s[24]s[50]", ad, sebep)) return KullanimMesajGonder(playerid, "/ocban [Karakter Ad�] [Sebep]");
    if (GetPlayerID(ad) != -1) return HataMesajGonder(playerid, "Bu oyuncu oyunda, /cban komutunu kullan�n.");
    new query[124];
    format(query, sizeof(query), "SELECT * FROM `oyuncular` WHERE `Isim` = '%s'", ad);
    mysql_tquery(g_SQL, query, "OnCBanAccount", "iss", playerid, ad, sebep);
	return 1;
}*/
CMD:unban(playerid, params[])
{
	new ad[30];
    if (PlayerData[playerid][pAdmin] < 1) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
    if (sscanf(params, "s[30]", ad)) return KullanimMesajGonder(playerid, "/unban [Karakter Ad� veya IP]");
    new query[124];
    format(query, sizeof(query), "SELECT null FROM `bans` WHERE `Ad` = '%s' OR `IP` = '%s'", ad, ad);
    mysql_tquery(g_SQL, query, "UnBan", "is", playerid, ad);
	return 1;
}
CMD:baninfo(playerid, params[])
{

    if (PlayerData[playerid][pAdmin] < 1) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
	if (isnull(params) || strlen(params) > 30) return KullanimMesajGonder(playerid, "/baninfo [Karakter Ad� veya IP]");
	new query[124];
 	format(query, sizeof(query), "SELECT * FROM `bans` WHERE `Ad` = '%s' OR `IP` = '%s'", SQL_ReturnEscaped(params), SQL_ReturnEscaped(params));
  	mysql_tquery(g_SQL, query, "BanInfo", "ds", playerid, params);
    return 1;
}

CMD:h(playerid, params[])
{
    if (PlayerData[playerid][pAdmin] < 1 && PlayerData[playerid][pHelper] < 1 && !PlayerData[playerid][pForumGorevlisi] && !PlayerData[playerid][pOyunGorevlisi]) return HataMesajGonder(playerid, "Bu komutu kullanmak i�in yetkiniz yok !");
    if(isnull(params)) return KullanimMesaji(playerid, "/h [Mesaj]");
    foreach(new i:Player) if((PlayerData[i][pAdmin] >= 1 || PlayerData[i][pHelper] >= 1) || PlayerData[i][pForumGorevlisi] >0 || PlayerData[i][pOyunGorevlisi] >0 && PlayerData[i][pAyarlar][7] == 0)
    {
        if(strlen(params) > 64)
        {
            if(PlayerData[playerid][pHelper] > 0) SendClientMessageEx(i, COLOR_LIGHTRED, "[hChat] (Lv. %d) Helper %s(%d): %.64s", PlayerData[playerid][pHelper], PlayerData[playerid][pAdminName], playerid, params);
            else SendClientMessageEx(i, COLOR_LIGHTRED, "[hChat] %s %s(%d): %.64s", GetAdminRank(playerid), PlayerData[playerid][pAdminName], playerid, params);
            SendClientMessageEx(i, COLOR_LIGHTRED, "%s", params[64]);
        }
        else
        {
            if(PlayerData[playerid][pHelper] > 0) SendClientMessageEx(i, COLOR_LIGHTRED, "[hChat] (Lv. %d) Helper %s(%d): %s", PlayerData[playerid][pHelper], PlayerData[playerid][pAdminName], playerid, params);
            else SendClientMessageEx(i, COLOR_LIGHTRED, "[hChat] %s %s(%d): %s", GetAdminRank(playerid), PlayerData[playerid][pAdminName], playerid, params);
        }
    }
    return 1;
}

CMD:soruekle(playerid)
{
    if (PlayerData[playerid][pAdmin] < 1 && PlayerData[playerid][pHelper] < 2) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
    if (SoruSayisi() >= MAX_SORU) return HataMesajGonder(playerid, "Daha fazla soru ekleyemezsiniz.");
    Dialog_Show(playerid,SoruEkle,DIALOG_STYLE_INPUT, "Soru Ekle", "L�tfen ekleyece�iniz sorunun sorusunu giriniz:\n\n{FF0000}NOT: en fazla 50 karakterden olu�abilir.", "Devam", "Kapat");
    return 1;
}
CMD:sorusil(playerid,params[])
{
    if (PlayerData[playerid][pAdmin] < 1 && PlayerData[playerid][pHelper] < 2) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
    new sid;
    if (sscanf(params, "i",sid))
    {
        KullanimMesajGonder(playerid, "/sorusil [Soru ID]");
        return HataMesajGonder(playerid, "Soru ID'si bulmak i�in /soruidbul komutunu kullan�n.");
    }
    if ((sid < 0 || sid >= MAX_SORU) || !SoruData[sid][soruExists]) return HataMesajGonder(playerid, "Soru ID'si bulunamad�.");
    Soru_Sil(sid);
    MesajGonder(playerid, "Soru silindi.");
    return 1;
}
CMD:soruidbul(playerid,params[])
{
    new soruu[50];
    if (PlayerData[playerid][pAdmin] < 1 && PlayerData[playerid][pHelper] < 2) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
    if (sscanf(params, "s[50]",soruu)) return KullanimMesajGonder(playerid, "/soruidbul [Soru]");
    if (strlen(soruu) < 3 || strlen(soruu) > 50) return HataMesajGonder(playerid, "Soru 3 ile 50 karakter arasinda olmalidir.");
    new str[50],sayi;
    for (new i; i<MAX_SORU; i++)
    {
        if (SoruData[i][soruExists])
        {
            if (strfind(SoruData[i][Soru], soruu, true) != -1)
            {
                format(str,sizeof(str), "ID: %d | SQL ID: %d",i,SoruData[i][soruID]);
                SendClientMessage(playerid,0x00FFBFFF,str);
                sayi++;
            }
        }
    }
    if (!sayi) return HataMesajGonder(playerid, "Yazd���n�z anahtar kelimeye ait hi�bir soru bulunamad�.");
    return 1;
}

CMD:tal(playerid)
{
	if (PlayerData[playerid][pAdmin] < 1 && PlayerData[playerid][pHelper] < 1 && PlayerData[playerid][pForumGorevlisi] < 1 && PlayerData[playerid][pOyunGorevlisi] < 1) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
	TalepListele(playerid);
	return 1;
}

CMD:setplayer(playerid, params[])
{
    static
	    userid,
	    type[18],
	    amount[32];

	if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
	if (sscanf(params, "us[18]S()[32]", userid, type, amount))
	{
	    KullanimMesajGonder(playerid, "/setplayer [ID/Isim] [Adlar]");
	    SendClientMessage(playerid, COLOR_PINK, "[ADLAR]:{FFFFFF} yas, cinsiyet, dogumyeri, ten, ehliyet, aranma, bitcoin, level, oynamasaati");
		SendClientMessage(playerid, COLOR_PINK, "[ADLAR]:{FFFFFF} bagimlilik, tasimacilikseviye, tasimaciliksefer, dovusstili, maskehakki, materyal");
		return 1;
	}
	if (!OyundaDegil(userid))
	    return HataMesajGonder(playerid, "Belirtti�iniz oyuncu oyunda de�il !");

	if (!strcmp(type, "yas", true))
	{
	    if (isnull(amount) || strval(amount) < 18 || strval(amount) > 80) return KullanimMesajGonder(playerid, "/setplayer [ID/Isim] [Yas] [Ya�]");
	    PlayerData[userid][pYas] = strval(amount);
	    MesajGonder(playerid, "%s adl� ki�inin ya��n� %d olarak ayarlad�n.", ReturnName(userid, 0), strval(amount));
	}
	else if (!strcmp(type, "cinsiyet", true))
	{
	    if (PlayerData[userid][pCinsiyet] == 1)
	    {
	        PlayerData[userid][pCinsiyet] = 2;
	        MesajGonder(playerid, "%s adl� ki�inin cinsiyetini Kad�n olarak de�i�tirdiniz.", ReturnName(userid, 0));
	    }
	    else
	    {
	        PlayerData[userid][pCinsiyet] = 1;
	        MesajGonder(playerid, "%s adl� ki�inin cinsiyetini Erkek olarak de�i�tirdiniz.", ReturnName(userid, 0));
	    }
	}
	else if (!strcmp(type, "dogumyeri", true))
	{
	    if (isnull(amount)) return HataMesajGonder(playerid, "Do�um yerini girmediniz.");
	    format(PlayerData[userid][pDogum], 30, amount);
	    MesajGonder(playerid, "%s adl� ki�inin do�um yerini '%s' olarak de�i�tirdiniz.", ReturnName(userid, 0), amount);
	}
	else if (!strcmp(type, "ten", true))
	{
	    if (PlayerData[userid][pTen] == 1)
	    {
	        PlayerData[userid][pTen] = 2;
	        MesajGonder(playerid, "%s adl� ki�inin ten rengini Siyah olarak de�i�tirdiniz.", ReturnName(userid, 0));
	    }
	    else
	    {
	        PlayerData[userid][pTen] = 1;
	        MesajGonder(playerid, "%s adl� ki�inin ten rengini Beyaz olarak de�i�tirdiniz.", ReturnName(userid, 0));
	    }
	}
	else if (!strcmp(type, "ehliyet", true))
	{
	    if (PlayerData[userid][pEhliyet] == 1)
	    {
	        PlayerData[userid][pEhliyet] = 0;
	        MesajGonder(playerid, "%s adl� ki�inin ehliyetini sildiniz.", ReturnName(userid, 0));
	    }
	    else
	    {
	        PlayerData[userid][pEhliyet] = 1;
	        MesajGonder(playerid, "%s adl� ki�iye ehliyet verdiniz.", ReturnName(userid, 0));
	    }
	}
	else if (!strcmp(type, "aranma", true))
	{
		if (isnull(amount) || strval(amount) < 0 || strval(amount) > 6) return KullanimMesajGonder(playerid, "/setplayer [ID/Isim] [Aranma] [Aranma Seviyesi 0-6]");
		PlayerData[userid][pAranma] = strval(amount);
		SetPlayerWantedLevel(userid, PlayerData[userid][pAranma]);
		MesajGonder(playerid, "%s adl� ki�inin aranma seviyesini %d olarak ayarlad�n�z.", ReturnName(userid, 0), strval(amount));
	}
	else if (!strcmp(type, "bitcoin", true))
	{
		if (isnull(amount) || strval(amount) < 0 || strval(amount) > 1000) return KullanimMesajGonder(playerid, "/setplayer [ID/Isim] [Bitcoin] [Miktar]");
		PlayerData[userid][pBitcoin] = strval(amount);
		MesajGonder(playerid, "%s adl� ki�inin bitcoin miktar� %d olarak ayarland�", ReturnName(userid, 0), strval(amount));
	}
	else if (!strcmp(type, "level", true))
	{
		if (isnull(amount)) return KullanimMesajGonder(playerid, "/setplayer [ID/Isim] [Level] [Level]");
		PlayerData[userid][pLevel] = strval(amount);
		SetPlayerScore(userid, PlayerData[userid][pLevel]);
		MesajGonder(playerid, "%s adl� ki�inin levelini %d olarak ayarland�n�z", ReturnName(userid, 0), strval(amount));
	}
	else if (!strcmp(type, "oynamasaati", true))
	{
		if (isnull(amount)) return KullanimMesajGonder(playerid, "/setplayer [ID/Isim] [oynamasaati] [Saat]");
		PlayerData[userid][pOynamaSaati] = strval(amount);
		MesajGonder(playerid, "%s adl� ki�inin oynama saatini %d olarak ayarland�n�z", ReturnName(userid, 0), strval(amount));
	}
	else if (!strcmp(type, "bagimlilik", true))
	{
		if (PlayerData[userid][pBagimlilik] == 0)
		{
		    PlayerData[userid][pBagimlilik] = 1;
		    PlayerData[userid][pBagimlilikSayac][1] = 0;
		    PlayerData[userid][pBagimlilikSayac][0] = 0;
		    MesajGonder(playerid, "%s adl� ki�iyi uyu�turucu ba��ml�s� yapt�n�z.", ReturnName(userid, 0));
		}
		else
		{
		    PlayerData[userid][pBagimlilik] = 0;
		    PlayerData[userid][pBagimlilikSayac][1] = 0;
		    PlayerData[userid][pBagimlilikSayac][0] = 0;
		    MesajGonder(playerid, "%s adl� ki�i art�k uyu�turucu ba��ml�s� de�il.", ReturnName(userid, 0));
		}
	}
	else if (!strcmp(type, "tasimacilikseviye", true))
	{
        if (isnull(amount)) return KullanimMesajGonder(playerid, "/setplayer [ID/Isim] [tasimacilikseviye] [Seviye 0-5]");
        if (strval(amount) < 0 || strval(amount) > 5) return HataMesajGonder(playerid, "Ta��mac�l�k seviyesi 0-5 aras�nda olmal�d�r.");
		PlayerData[userid][pTasimacilikSeviye] = strval(amount);
		MesajGonder(playerid, "%s adl� ki�inin ta��mac�l�k seviyesini %d olarak ayarland�n�z", ReturnName(userid, 0), strval(amount));
	}
	else if (!strcmp(type, "tasimaciliksefer", true))
	{
        if (isnull(amount)) return KullanimMesajGonder(playerid, "/setplayer [ID/Isim] [tasimaciliksefer] [Sefer]");
		PlayerData[userid][pTasimacilikSefer] = strval(amount);
		MesajGonder(playerid, "%s adl� ki�inin ta��mac�l�k seferini %d olarak ayarland�n�z", ReturnName(userid, 0), strval(amount));
	}
	else if (!strcmp(type, "dovusstili", true))
	{
        if (isnull(amount)) return KullanimMesajGonder(playerid, "/setplayer [ID/Isim] [dovusstili] [Stil]");
		PlayerData[userid][pDovusStili] = strval(amount);
		MesajGonder(playerid, "%s adl� ki�inin d�v�� stilini %s olarak ayarland�n�z", ReturnName(userid, 0), GetFightStyleName(strval(amount)));
	}
	else if (!strcmp(type, "maskehakki", true))
	{
		if (PlayerData[userid][pMaskeHakki] == 0)
		{
		    PlayerData[userid][pMaskeHakki] = 1;
		    MesajGonder(playerid, "%s adl� ki�iye maske hakk� verdiniz.", ReturnName(userid, 0));
		}
		else
		{
		    PlayerData[userid][pMaskeHakki] = 0;
		    MesajGonder(playerid, "%s adl� ki�inin maske hakk�n� sildiniz.", ReturnName(userid, 0));
		}
	}
	else if (!strcmp(type, "materyal", true))
	{
		if (isnull(amount)) return KullanimMesajGonder(playerid, "/setplayer [ID/Isim] [materyal] [Miktar]");
		PlayerData[userid][pMateryal] = strval(amount);
		MesajGonder(playerid, "%s adl� ki�inin Par�a miktar� %d olarak ayarland�", ReturnName(userid, 0), strval(amount));
	//	AdminMessage(COLOR_LIGHTRED, "ADM: %s %s, %s (%d) adl� ki�inin materyalini %d olarak de�i�tirdi." GetAdminRank(playerid), PlayerData[playerid][pAdminName], ReturnName(userid, 0));
	}
	return 1;
}

CMD:aesyaver(playerid, params[])
{
	static userid;
	if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
	if (sscanf(params, "u", userid)) return KullanimMesajGonder(playerid, "/aesyaver [ID/Isim]");
	if (!OyundaDegil(userid)) return HataMesajGonder(playerid, "Oyuncu oyunda de�il.");
	SetPVarInt(playerid, "oyuncuID", userid);
	Dialog_Show(playerid, AEsyaVer, DIALOG_STYLE_LIST, "E�ya Ver", "Zar\nSigara\n�p\nG�z Ba��\nMaske\nBenzin Kutusu\nBarbeku\nK�fte\nTavuk Eti\nDana Eti\nTamir Kiti\nPortatif �ad�r\nKamp Ate�i\n�arj�r", "Ver", "Kapat");
	return 1;
}

CMD:sicilkontrol(playerid, params[])
{
    static
        userid;

    if (PlayerData[playerid][pAdmin] < 1)
        return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

    if (sscanf(params, "u", userid))
        return KullanimMesajGonder(playerid, "/sicilkontrol [id/isim]");

    if (!OyundaDegil(userid))
        return HataMesajGonder(playerid, "Belirtti�iniz oyuncu oyunda de�il !");

    SicilKontrol(playerid, userid);
    return 1;
}

CMD:listguns(playerid, params[])
{
    new userid;

    if (PlayerData[playerid][pAdmin] < 1)
        return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

    if (sscanf(params, "u", userid))
        return KullanimMesajGonder(playerid, "/listguns [id/isim]");

    if (!OyundaDegil(userid))
        return HataMesajGonder(playerid, "Oyuncu giri� yapmam��.");

    SendClientMessage(playerid, COLOR_GREY, "-----------------------------------------------------------");
    SendClientMessageEx(playerid, COLOR_LIGHTRED, "%s'in Silahlar�:", ReturnName(userid, 0));
	new a;
    for (new i; i<13; i++) if (PlayerData[userid][pSilahlar][i] > 0)
	{
	    GetPlayerWeaponData(userid, i, a, PlayerData[userid][pMermiler][i]);
	    SendClientMessageEx(playerid, COLOR_WHITE, "* %s (%d mermi)", ReturnWeaponName(PlayerData[userid][pSilahlar][i]), PlayerData[userid][pMermiler][i]);
	}
    SendClientMessage(playerid, COLOR_GREY, "-----------------------------------------------------------");
    return 1;
}
CMD:flipcar(playerid, params[])
{
    new vehicleid = GetPlayerVehicleID(playerid);

    if (PlayerData[playerid][pAdmin] < 1)
        return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

    if (vehicleid > 0 && isnull(params))
    {
        FlipVehicle(vehicleid);
        MesajGonder(playerid, "Bulundu�unuz ara� d�zeltildi.");
		AdminMessage(COLOR_LIGHTRED, "%s %s, admin komutu ile arac�n� �evirdi.", GetAdminRank(playerid), PlayerData[playerid][pAdminName]);
   	    Log_Write("logs/atamir.log", "[%s] %s %s, admin komutu ile arac�n� �evirdi.", ReturnDate(), GetAdminRank(playerid), PlayerData[playerid][pAdminName]);

    }
    else
    {
        if (sscanf(params, "d", vehicleid))
            return KullanimMesajGonder(playerid, "/flipcar [ara� ID]");

        else if (!IsValidVehicle(vehicleid))
            return HataMesajGonder(playerid, "Ge�ersiz bir ara� ID's� belirttiniz.");

        FlipVehicle(vehicleid);
        MesajGonder(playerid, "Ara� ID %d d�zeltildi.", vehicleid);
    }
    return 1;
}
CMD:tracenumber(playerid, params[])
{
    new number;

    if (PlayerData[playerid][pAdmin] < 1 && PlayerData[playerid][pHelper] < 3)
        return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

    if (sscanf(params, "d", number))
        return KullanimMesajGonder(playerid, "/tracenumber [numara]");

    if (number == 0)
        return HataMesajGonder(playerid, "Ge�ersiz numara girdiniz.");

    if (GetNumberOwner(number) != INVALID_PLAYER_ID)
        return BilgiMesajGonder(playerid, "%d numaran�n sahibi %s adl� ki�idir.", number, ReturnName(GetNumberOwner(number), 0));

    HataMesajGonder(playerid, "Bu numaraya sahip oyuncu �evrimi�i de�il veya bu numaraya sahip kimse yok.");
    return 1;
}

CMD:arenk(playerid, params[])
{
    static
        color1,
        color2,
        carid;

    if (PlayerData[playerid][pAdmin] < 1)
        return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

    if (sscanf(params, "iii", carid, color1, color2)) return KullanimMesajGonder(playerid, "/arenk [Ara� ID] [Renk 1] [Renk 2]");
    if (!IsValidVehicle(carid)) return HataMesajGonder(playerid, "Ge�ersiz ara� id.");

    if (color1 < 0 || color1 > 255)
        return HataMesajGonder(playerid, "Renk 1, 0 ile 255 aras�nda olmal�d�r.");

    if (color2 < 0 || color2 > 255)
        return HataMesajGonder(playerid, "Renk 2, 0 ile 255 aras�nda olmal�d�r.");

	new id = Car_GetID(carid);
	if (id == -1) ChangeVehicleColor(carid, color1, color2);
	else
	{
	    AracInfo[id][aracRenkler][0] = color1;
	    AracInfo[id][aracRenkler][1] = color2;
	    ChangeVehicleColor(carid, color1, color2);
	    Arac_Kaydet(id);
	}

    MesajGonder(playerid, "Arac�n rengi de�i�tirildi.");
    return 1;
}

CMD:apaintjob(playerid, params[])
{
    static
        paintjobid, carid;

    if (PlayerData[playerid][pAdmin] < 3)
        return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

    if (sscanf(params, "ii", carid, paintjobid)) return KullanimMesajGonder(playerid, "/arenk [Ara� ID] [Paintjob ID] (-1 kapat�r)");
    if (!IsValidVehicle(carid)) return HataMesajGonder(playerid, "Ge�ersiz ara� id.");

    if (paintjobid < -1 || paintjobid > 5)
        return HataMesajGonder(playerid, "Ge�ersiz Paintjob ID. (0-5)");

    if (paintjobid == -1)
        paintjobid = 6;

    new id = Car_GetID(carid);
    if (id == -1) ChangeVehiclePaintjob(carid, paintjobid);
    else
    {
        AracInfo[id][aracPaintjob] = paintjobid;
        ChangeVehiclePaintjob(carid, paintjobid);
        Arac_Kaydet(id);
    }
    MesajGonder(playerid, "Paintjob de�i�tirildi.", paintjobid);
    return 1;
}
CMD:jetpack(playerid, params[])
{

    if (PlayerData[playerid][pAdmin] < 1)
        return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

	PlayerData[playerid][pJetpack] = 1;
 	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USEJETPACK);
    return 1;
}

CMD:setweather(playerid, params[])
{
    new weatherid;

    if (PlayerData[playerid][pAdmin] < 4)
        return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

    if (sscanf(params, "d", weatherid))
        return KullanimMesajGonder(playerid, "/setweather [weather ID]");

    SetWeather(weatherid);
    MesajGonder(playerid, "Hava durumu %d olarak de�i�tirildi.", weatherid);
    AdminMessage(COLOR_LIGHTRED, "ADM: %s adl� yetkili hava durumunu de�i�tirdi. (ID: %d)", PlayerData[playerid][pAdminName], weatherid);
    return 1;
}

CMD:panel(playerid)
{
	if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
	if (sunucuKilitli) Dialog_Show(playerid, ServerPanel, DIALOG_STYLE_LIST, "Sunucu Paneli ", "Kilit A�\nHostname De�i�tir\nSorgu �al��t�r\nBak�m Modu\nBa�vuru Durumu (%s)", "Se�", "Kapat", (GetServerBilgi("basvurudurum") == 1) ? ("{84f542}A��k{FFFFFF}") : ("{ff1414}Kapal�{FFFFFF}"));
	else Dialog_Show(playerid, ServerPanel, DIALOG_STYLE_LIST, "Server Panel", "Kilitle\nHostname De�i�tir\nSorgu �al��t�r\nBak�m Modu\nBa�vuru Durumu (%s)", "Se�", "Kapat", (GetServerBilgi("basvurudurum") == 1) ? ("{84f542}A��k{FFFFFF}") : ("{ff1414}Kapal�{FFFFFF}"));
	return 1;
}

CMD:evduzenle(playerid, params[])
{
    static id, type[24], string[128];
	if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Bu komutu kullanamazs�n !");
	if (sscanf(params, "ds[24]S()[128]", id, type, string))
 	{
	 	KullanimMesajGonder(playerid, "/evduzenle [ID] [Ad]");
	    SendClientMessage(playerid, COLOR_PINK, "{00FF15}[ADLAR]: {FFFFFF} sahip, sistemselfiyat, pozisyon, interior, kilit, maksmobilya, mobilyatemizle, kasatemizle");
		return 1;
	}
	if ((id < 0 || id >= MAX_EV) || !HouseInfo[id][evExists])
	    return HataMesajGonder(playerid, "Ge�ersiz ev ID's�.");

    if (!strcmp(type, "sahip", true))
    {
        new sahipid;

	    if (sscanf(string, "d", sahipid))
	        return KullanimMesajGonder(playerid, "/evduzenle [ID] [sahip] [Sahip SQL ID] (-1 yazarsan�z sahipsiz olur)");

		HouseInfo[id][evSahip] = sahipid;
		Ev_Yenile(id);
		Ev_Kaydet(id);
    }
    if (!strcmp(type, "sistemselfiyat", true))
    {
        new fiyat;

	    if (sscanf(string, "d", fiyat))
	        return KullanimMesajGonder(playerid, "/evduzenle [ID] [sistemselfiyat] [Fiyat]");

		HouseInfo[id][evKendiFiyati] = fiyat;
		if (!HouseInfo[id][evSatilik]) HouseInfo[id][evFiyat] = fiyat;
		Ev_Yenile(id);
		Ev_Kaydet(id);
    }
    if (!strcmp(type, "pozisyon", true))
    {
        GetPlayerPos(playerid, HouseInfo[id][evPos][0], HouseInfo[id][evPos][1], HouseInfo[id][evPos][2]);
		Ev_Yenile(id);
		Ev_Kaydet(id);
    }
    if (!strcmp(type, "interior", true)) // De�i�ti
    {
        new interior;

	    if (sscanf(string, "d", interior))
	        return KullanimMesajGonder(playerid, "/evduzenle [ID] [interior] [Interior ID]");

	    if (!(0 <= interior <= sizeof(HouseInteriors)-1)) return HataMesajGonder(playerid, "Yazd���n�z ID'de bir interior bulunmamaktad�r.");

	    HouseInfo[id][evInterior] = interior;
	    foreach (new i:Player)
	    {
	        if (PlayerData[i][pHouse] == HouseInfo[id][evID])
	        {
	            SetPlayerInterior(playerid, HouseInteriors[ HouseInfo[id][evInterior] ][intID]);
  				SetPlayerPos(playerid, HouseInteriors[HouseInfo[id][evInterior] ][intX], HouseInteriors[ HouseInfo[id][evInterior] ][intY], HouseInteriors[ HouseInfo[id][evInterior] ][intZ]);
          		ObjelerYukleniyor(i);
	        }
	    }
	    Ev_Kaydet(id);
	    House_RemoveFurniture(id);
    }
    if (!strcmp(type, "kilit", true))
    {
        if (HouseInfo[id][evKilit] == 1) HouseInfo[id][evKilit] = 0;
        else HouseInfo[id][evKilit] = 1;
        Ev_Yenile(id);
        Ev_Kaydet(id);
    }
    if (!strcmp(type, "maksmobilya", true))
    {
        new mobilya;

	    if (sscanf(string, "d", mobilya))
	        return KullanimMesajGonder(playerid, "/evduzenle [ID] [maksmobilya] [Mobilya Limiti]");

		HouseInfo[id][evMaksMobilya] = mobilya;
		Ev_Kaydet(id);
		MesajGonder(playerid, "Maksimum mobilya limiti %d olarak de�i�tirildi.", mobilya);
    }
    if (!strcmp(type, "mobilyatemizle", true)) // De�i�ti
    {
        MesajGonder(playerid, "Mobilyalar silindi.");
        House_RemoveFurniture(id);
    }
    if (!strcmp(type, "kasatemizle", true))
    {
        HouseInfo[id][evCash] = 0;
        HouseInfo[id][evUyusturucu] = 0;
        for (new i; i<10; i++)
        {
            HouseInfo[id][evSilahlar][i] = 0;
            HouseInfo[id][evMermiler][i] = 0;
        }
        Ev_Kaydet(id);
        MesajGonder(playerid, "Kasadaki para, uyu�turucu ve silahlar silindi.");
    }
	return 1;
}

CMD:givenos(playerid, params[])
{
	new id;

	if (PlayerData[playerid][pAdmin] < 4)
	    return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

	if (sscanf(params, "d", id))
		return MesajGonder(playerid, "/givenos [Ara� ID]");

	if (Car_GetID(id) == -1)
		return HataMesajGonder(playerid, "Ge�ersiz Ara� ID'si girdiniz.");

	AddVehicleComponent(id, 1010);
	MesajGonder(playerid, "%d ID'li araca 10x nos eklenmi�tir.", id);
	return 1;
}

CMD:aracduzenle(playerid, params[])
{
    static vid, type[24], string[128];
	if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Bu komutu kullanamazs�n !");

	if (sscanf(params, "ds[24]S()[128]", vid, type, string))
	{
	    KullanimMesajGonder(playerid, "/aracduzenle [ID] [Ayar]");
	    SendClientMessage(playerid, COLOR_PINK, "{00FF15}[Ayarlar]: {FFFFFF}model, sahip, zirh, kilit, vergi, modifiyesil, taksiplaka, ceza, birlik, kira, satilik");
	    return SendClientMessage(playerid, COLOR_PINK, "{00FF15}[Ayarlar]: {FFFFFF}plaka, bagajtemizle, kilometre, benzin");
	}

	new id = Car_GetID(vid);
	if (id == -1)
		return HataMesajGonder(playerid, "Ge�ersiz Ara� ID.");

	if (!strcmp(type, "benzin", true))
	{
		new Float:miktar;

		if (sscanf(string, "f", miktar))
			return KullanimMesajGonder(playerid, "/aracduzenle [ID] [benzin] [Miktar (0.0 - 100.0)]");

		if (miktar < 0.0 || miktar > 100.0)
			return HataMesajGonder(playerid, "Ge�ersiz miktar girdiniz.");

		AracInfo[id][aracBenzin] = miktar;
		Arac_Kaydet(id);

		MesajGonder(playerid, "Arac�n benzin miktar� ayarland�.");
	}

	if (!strcmp(type, "model", true))
	{
	    new model;
	    if (sscanf(string, "d", model)) return KullanimMesajGonder(playerid, "/aracduzenle [ID] [model] [Model ID]");
	    if (!IsValidVehicleModel(model)) return HataMesajGonder(playerid, "Ge�ersiz Model ID girdiniz.");
	    AracInfo[id][aracModel] = model;
	    Arac_Kaydet(id);
	    Arac_Spawn(id, 1);
	    MesajGonder(playerid, "Arac�n modeli de�i�tirildi ve respawn edildi.");
	}
	else if (!strcmp(type, "sahip", true))
	{
	    new sahip;
	    if (sscanf(string, "d", sahip)) return KullanimMesajGonder(playerid, "/aracduzenle [ID] [sahip] [Sahip SQL ID]");
	    AracInfo[id][aracSahip] = sahip;
	    Arac_Kaydet(id);
	    MesajGonder(playerid, "Arac�n sahibi SQL ID %d olarak ayarland�.", sahip);
	}
	else if (!strcmp(type, "zirh", true))
	{
	    new zirh;
	    if (sscanf(string, "d", zirh)) return KullanimMesajGonder(playerid, "/aracduzenle [ID] [zirh] [Zirh]");
	    AracInfo[id][aracZirh] = zirh;
	    AracInfo[id][aracZirhVarMi] = 1;
	    Arac_Kaydet(id);
	    MesajGonder(playerid, "Arac�n z�rh�n� %d olarak ayarlad�n�z.", zirh);
	}
	else if (!strcmp(type, "kilit", true))
	{
	    static
	        engine,
	        lights,
	        alarm,
	        doors,
	        bonnet,
	        boot,
	        objective;

	    	GetVehicleParamsEx(AracInfo[id][aracVehicle], engine, lights, alarm, doors, bonnet, boot, objective);
			if (!AracInfo[id][aracKilit])
			{
				AracInfo[id][aracKilit] = true;
				Arac_Kaydet(id);

				PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);

				SetVehicleParamsEx(AracInfo[id][aracVehicle], engine, lights, alarm, 1, bonnet, boot, objective);
				MesajGonder(playerid, "Ara� kilitlendi.");
			}
			else
			{
				AracInfo[id][aracKilit] = false;
				Arac_Kaydet(id);

				PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
				SetVehicleParamsEx(AracInfo[id][aracVehicle], engine, lights, alarm, 0, bonnet, boot, objective);
				MesajGonder(playerid, "Arac�n kilidi a��ld�.");
			}
	}
	else if (!strcmp(type, "vergi", true))
	{
	    new vergi;
	    if (sscanf(string, "d", vergi)) return KullanimMesajGonder(playerid, "/aracduzenle [ID] [vergi] [Vergi]");
	    AracInfo[id][aracVergi] = vergi;
	    Arac_Kaydet(id);
	    MesajGonder(playerid, "Arac�n vergisini %s olarak ayarlad�n�z.", FormatNumber(vergi));
	}
	else if (!strcmp(type, "modifiyesil", true))
	{
	    for (new i; i<14; i++) if (AracInfo[id][aracMods][i] > 0)
	    {
	        RemoveVehicleComponent(AracInfo[id][aracVehicle], AracInfo[id][aracMods][id]);
	        AracInfo[id][aracMods][id] = 0;
	    }
	    AracInfo[id][aracPaintjob] = -1;
	    ChangeVehiclePaintjob(AracInfo[id][aracVehicle], 3);
	    Arac_Kaydet(id);
	    MesajGonder(playerid, "Modifiyeler kald�r�ld�.");
	}
	else if (!strcmp(type, "taksiplaka", true))
	{
	    if (AracInfo[id][TaksiPlaka] == 0)
	    {
	        AracInfo[id][TaksiPlaka] = 1;
	        MesajGonder(playerid, "Araca taksi plakas� verdiniz.");
	    }
	    else
	    {
	        AracInfo[id][TaksiPlaka] = 0;
	        MesajGonder(playerid, "Arac�n taksi plakas� kald�r�ld�.");
	    }
	    Arac_Kaydet(id);
	}
	else if (!strcmp(type, "ceza", true))
	{
	    new ceza;
	    if (sscanf(string, "d", ceza)) return KullanimMesajGonder(playerid, "/aracduzenle [ID] [ceza] [Ceza]");
	    AracInfo[id][aracTicket] = ceza;
	    Arac_Kaydet(id);
	    MesajGonder(playerid, "Arac�n cezas�n� %s olarak ayarlad�n�z.", FormatNumber(ceza));
	}
	else if (!strcmp(type, "birlik", true))
	{
	    new birlikid;
	    if (sscanf(string, "d", birlikid)) return KullanimMesajGonder(playerid, "/aracduzenle [ID] [birlik] [Birlik ID (sql)]");
	    AracInfo[id][aracFaction] = birlikid;
     	AracInfo[id][aracFactionType] = Birlikler[Birlik_GetID(birlikid)][birlikTip];
     	Arac_Kaydet(id);
	}
	else if (!strcmp(type, "kira", true))
	{
	    new kirafiyat;
	    if (sscanf(string, "d", kirafiyat)) return KullanimMesajGonder(playerid, "/aracduzenle [ID] [kira] [�cret]");

		MesajGonder(playerid, "Arac�n kira fiyat�n� %d olarak ayarlad�n�z.", FormatNumber(kirafiyat));

		AracInfo[id][aracKira] = kirafiyat;

     	Arac_Kaydet(id);
	}
	else if (!strcmp(type, "satilik", true))
	{
	    new fiyat;
	    if (sscanf(string, "d", fiyat)) return KullanimMesajGonder(playerid, "/aracduzenle [ID] [satilik] [Fiyat] (0 yazarsan�z sat�l�k olmaz)");
	    if (fiyat <= 0)
	    {
	        AracInfo[id][aracSatilik] = 0;
	        AracInfo[id][aracFiyat] = 0;
	        Arac_Kaydet(id);
	        UpdateDynamic3DTextLabelText(AracInfo[id][aracLabel], -1, " ");
	        DestroyDynamic3DTextLabel(AracInfo[id][aracLabel]);
	        MesajGonder(playerid, "Ara� art�k sat�l�k de�il.");
	    }
	    else
	    {
	        UpdateDynamic3DTextLabelText(AracInfo[id][aracLabel], -1, " ");
	        DestroyDynamic3DTextLabel(AracInfo[id][aracLabel]);
	        AracInfo[id][aracSatilik] = 1;
	        AracInfo[id][aracFiyat] = fiyat;
	        Arac_Kaydet(id);
	        new str[120];
		    format(str,sizeof(str), "{2ECC71}SATILIK\n{2ECC71}Fiyat: %s\n{2ECC71}%d",FormatNumber(AracInfo[id][aracFiyat]), GetSQLPhoneNumber(AracInfo[id][aracSahip]));
		    AracInfo[id][aracLabel] = CreateDynamic3DTextLabel(str,-1, 0.0, -2.5, 0.4,30.0,INVALID_PLAYER_ID,AracInfo[id][aracVehicle], 1);
	    }
	}
	else if (!strcmp(type, "plaka", true))
	{
	    new plaka[24];
	    if (sscanf(string, "s[24]", plaka)) return KullanimMesajGonder(playerid, "/aracduzenle [ID] [plaka] [Plaka]");
	 	format(AracInfo[id][aracPlaka], 24, plaka);
	 	SetVehicleNumberPlate(AracInfo[id][aracPlaka], plaka);
	 	MesajGonder(playerid, "Arac�n plakas� de�i�tirildi.");
	}
	else if (!strcmp(type, "bagajtemizle", true))
	{
	    for (new i; i<5; i++) if (AracInfo[id][aracSilahlar][i] > 0)
	    {
	        AracInfo[id][aracSilahlar][i] = 0;
	        AracInfo[id][aracMermiler][i] = 0;
	    }
	    AracInfo[id][aracUyusturucu] = 0;
	    MesajGonder(playerid, "Arac�n bagaj� temizlendi.");
	}
	else if (!strcmp(type, "kilometre", true))
	{
	    new Float:km;
	    if (sscanf(string, "f", km)) return KullanimMesajGonder(playerid, "/aracduzenle [ID] [kilometre] [Kilometre]");
	    AracInfo[id][aracKM] = km;
	    Arac_Kaydet(id);
	    MesajGonder(playerid, "Arac�n kilometresi %f olarak de�i�tirildi", km);
	}
	return 1;
}
CMD:god(playerid, params[])
{
	if (PlayerData[playerid][pAdmin] < 1) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
	if (PlayerData[playerid][pGOD] == true)
	{
		PlayerTextDrawHide(playerid, godduty[playerid]);
	    PlayerData[playerid][pGOD] = false;
	    MesajGonder(playerid, "Godmode kapat�ld�.");
	}
	else
	{
 		PlayerTextDrawShow(playerid, godduty[playerid]);
	    PlayerData[playerid][pGOD] = true;
	    MesajGonder(playerid, "Godmode a��ld�.");
	}
	return 1;
}

CMD:respawnnear(playerid, params[])
{
    if (PlayerData[playerid][pAdmin] < 2)
        return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

    new count;

    for (new i = 0; i < MAX_ARAC; i++)
    {
        static Float:fX, Float:fY, Float:fZ;

        if (AracInfo[i][aracExists] && IsValidVehicle(AracInfo[i][aracVehicle]) && GetVehicleDriver(AracInfo[i][aracVehicle]) == INVALID_PLAYER_ID)
        {
            GetVehiclePos(AracInfo[i][aracVehicle], fX, fY, fZ);

            if (IsPlayerInRangeOfPoint(playerid, 50.0, fX, fY, fZ))
            {
                Arac_Spawn(i);
                count++;
            }
        }
    }
    if (!count)
        return HataMesajGonder(playerid, "Respawn i�in yak�n�n�zda hi�bir ara� bulunmamaktad�r.");

    MesajGonder(playerid, "Yak�n�n�zda bulunan %d adet ara� respawn edilmi�tir.", count);
    return 1;
}

CMD:setname(playerid, params[])
{
	static userid, newname[24];
	if (PlayerData[playerid][pAdmin] < 3) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
	if (sscanf(params, "us[24]", userid, newname)) return KullanimMesajGonder(playerid, "/setname [id/isim] [yeni isim]");
	if (!OyundaDegil(userid)) return HataMesajGonder(playerid, "Bu oyuncu giri� yapmam��.");
	if (!IsValidRoleplayName(newname)) return HataMesajGonder(playerid, "Ge�ersiz ad bi�imi girdiniz.");
	if (!IsimKontrol(newname)) return HataMesajGonder(playerid, "Bu isim kullan�l�yor.");
	if (SoyadKilitlimi(GetPlayerLastName(playerid, newname, 0))) return HataMesajGonder(playerid, "Bu soyad kilitlenmi�.");

	MesajGonder(playerid, "%s adl� ki�inin ismini %s olarak ayarlad�n�z.", Player_GetName(userid), newname);
	ChangeName(userid, newname);
	return 1;
}
CMD:namechanges(playerid, params[])
{
	new id;
    if (PlayerData[playerid][pAdmin] < 2) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
    if (sscanf(params, "u", id)) return KullanimMesajGonder(playerid, "/namechanges [ID/Isim]");
    if (!OyundaDegil(id)) return HataMesajGonder(playerid, "Bu oyuncu giri� yapmam��.");
    new query[124];
    format(query, sizeof(query), "SELECT * FROM `namechanges` WHERE `sqlid` = '%d'", PlayerData[id][pID]);
    mysql_tquery(g_SQL, query, "NameChanges", "di", playerid, id);
	return 1;
}
CMD:stats(playerid, params[])
{
	new id;
	if (PlayerData[playerid][pAdmin] < 1) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
	if (sscanf(params, "u", id)) return KullanimMesajGonder(playerid, "/stats [ID/Isim]");
	if (!OyundaDegil(id)) return HataMesajGonder(playerid, "Oyuncu giri� yapmam��.");
	ShowStats(playerid, id);
	return 1;
}
CMD:ahelp(playerid)
{
    if (PlayerData[playerid][pAdmin] < 1 && !PlayerData[playerid][pOyunGorevlisi] && !PlayerData[playerid][pForumGorevlisi]) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

	new str[1024];

	if(PlayerData[playerid][pForumGorevlisi] >= 1) strcat(str, "[Forum G�revlisi]: /aduty, /skick, /kick, /jail, /savepos, /loadpos, /getcar, /gotocar, /respawncar, /spawnla, /go, /get, /ojail, /unjail, /askin\n");
	if(PlayerData[playerid][pOyunGorevlisi] >= 1) strcat(str, "[Oyun G�revlisi]: /aduty, /jail, /skick, /kick, /masked, /revive, /gotopos, /savepos, /loadpos, /getcar, /gotocar, /respawncar, /spawnla, /go, /get\n/spec /specoff, /ojail, /unjail, /askin");
	if (PlayerData[playerid][pAdmin] >= 1) strcat(str, "[Game Admin]: /gotopos, /aduty, /aipcoz, /akelepcecoz, /revive, /masked, /maskeidbul, /ss, /o, /songiris, /kick, /askin\n");
	if (PlayerData[playerid][pAdmin] >= 1) strcat(str, "[Game Admin]: /dondur, /coz, /spawnla, /goto, /gethere, /setinterior, /setvw, /sendto, /sethp, /atamir, /getcar, /askin\n");
	if (PlayerData[playerid][pAdmin] >= 1) strcat(str, "[Game Admin]: /carto, /entercar, /gotocar, /respawncar, /respawncars, /cc, /spec, /jail, /unjail, /askin\n");
	if (PlayerData[playerid][pAdmin] >= 1) strcat(str, "[Game Admin]: /ojail, /ban, /banip, /unban, /oban, /stats, /listguns, /flipcar, /tracenumber, /cban, /cunban, /askin\n");
    if (PlayerData[playerid][pAdmin] >= 2) strcat(str, "[Senior Admin]: /reviveall, /setskin, /ip, /setarmor, /respawnnear, /askin\n");
    if (PlayerData[playerid][pAdmin] >= 3) strcat(str, "[High Senior Admin]: /binaekle, /setleader, /siparisler, /resetweps, /asetfaction, /asetrank, /arenk, /apaintjob, /setname, /askin\n");
    if (PlayerData[playerid][pAdmin] >= 4) strcat(str, "[Lead Admin]: /sethelper, /setstaffname, /setvip, /ozelmodelver, /ozelmodelsil, /giveweapon, /aesyaver, /setweather, /evduzenle, /askin, /15dk, /15dkkapa\n");
    if (PlayerData[playerid][pAdmin] >= 5) strcat(str, "[Management]: /setadmin, /kickall, /givecash, /givecashall, /giveexp, /giveexpall, /setplayer, /panel, /dinamikyardim, /ogyap, /fgyap, /sirketsil, /askin, /15dk, /15dkkapa\n");

    Dialog_Show(playerid, 0, DIALOG_STYLE_MSGBOX, "Admin Komutlar�", str, "Kapat", "");

	return 1;
}
CMD:dinamikyardim(playerid)
{
    if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
    SendClientMessage(playerid, COLOR_CLIENT, "D�NAM�K:{FFFFFF} /binaekle, /binaduzenle, /binasil, /aracolustur, /aracsil, /gateolustur, /gateduzenle, /gatesil");
    SendClientMessage(playerid, COLOR_CLIENT, "D�NAM�K:{FFFFFF} /garajolustur, /garajsil, /garajduzenle, /evolustur, /evsil, /evduzenle, /birlikolustur, /birliksil");
    SendClientMessage(playerid, COLOR_CLIENT, "D�NAM�K:{FFFFFF} /birlikduzenle, /isyeriolustur, /isyeriduzenle, /isyerisil, /createarrest, /destroyarrest, /createcctv, /deletecctv");
    SendClientMessage(playerid, COLOR_CLIENT, "D�NAM�K:{FFFFFF} /lokasyonekle, /lokasyonsil, /createatm, /editatm, /removeatm, /hoodolustur, /hoodsil");
    SendClientMessage(playerid, COLOR_CLIENT, "D�NAM�K:{FFFFFF} /pompaolustur, /pompagit, /pompaduzenle, /pompasil");
    SendClientMessage(playerid, COLOR_CLIENT, "D�NAM�K:{FFFFFF} /tamirolustur, /tamirgit, /tamirduzenle, /tamirsil");
	return 1;
}
CMD:hhelp(playerid)
{
	if (PlayerData[playerid][pHelper] < 1) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
	SendClientMessage(playerid, 0xDDDDDDAA, "[Lv. 1 HELPER]: /h, /tal, /helperyardim, /hduty, /spawnla, /hskin");
	if (PlayerData[playerid][pHelper] >= 2) SendClientMessage(playerid, 0xDDDDDDAA, "[Lv. 2 HELPER]: /go, /get, /savepos, /loadpos, /revive, /getcar, /gotocar, /respawncar, /hskin2");
	if (PlayerData[playerid][pHelper] >= 3) SendClientMessage(playerid, 0xDDDDDDAA, "[Lv. 3 HELPER]: /tracenumber, /hskin3");
	if (PlayerData[playerid][pHelper] >= 4) SendClientMessage(playerid, 0xDDDDDDAA, "[Lv. 4 HELPER]: /kick, /slap, /hskin4");
	if (PlayerData[playerid][pHelper] >= 5) SendClientMessage(playerid, 0xDDDDDDAA, "[Lv. 5 HELPER]: Hen�z yetkiniz yok.");
	return 1;
}
CMD:dashcamlimit(playerid, params[])
{
	new limit, vehicleid;
	vehicleid = GetPlayerVehicleID(playerid);
	if (GetFactionType(playerid) != BIRLIK_LSPD)
		return HataMesajGonder(playerid, "Devlet memuru de�ilsiniz.");

    if (sscanf(params, "i", limit)) return KullanimMesajGonder(playerid, "/dashcamlimit [KM/H]");

	if (!IsPlayerInAnyVehicle(playerid)) return HataMesajGonder(playerid, "Bu komutu polis ara�lar�nda kullanabilirsin.");
	if (vehRadar[vehicleid] == false) return HataMesajGonder(playerid, "�lk �nce arac�n Dashcam'� a��k olmal�d�r.");

    if (limit < 50 || limit > 250) return HataMesajGonder(playerid, "Limit en az 50, en fazla 250 olmal�d�r.");

    vehRadarLimit[vehicleid] = limit;
	MesajGonder(playerid, "Uyar�lacak h�z seviyesi %d KM/H olarak ayarland�.", limit);
	return 1;
}
CMD:setactorvw(playerid, params[])
{
	new acid, vw;
	if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
	if (sscanf(params, "ii", acid, vw)) return KullanimMesajGonder(playerid, "/setactorvw [Actor ID] [Vw]");
	if (!IsValidActor(acid)) return HataMesajGonder(playerid, "Ge�ersiz ID girdiniz.");
	SetActorVirtualWorld(acid, vw);
	return 1;
}
CMD:payday(playerid)
{
    if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
    foreach (new i: Player)
    {
        if (PlayerData[i][pMaasSure] < 3600 && PlayerData[i][pHapisSure] < 2) PlayerData[i][pMaasSure] = 3599;
    }
    AdminMessage(COLOR_LIGHTRED, "ADM: %s %s, payday verdi.", GetAdminRank(playerid), PlayerData[playerid][pAdminName]);
	return 1;
}
CMD:givedrug(playerid, params[])
{
	new id, miktar;
    if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
    if (sscanf(params, "ui", id, miktar)) return KullanimMesajGonder(playerid, "/givedrug [ID/Isim] [Miktar]");
    if (!OyundaDegil(id)) return HataMesajGonder(playerid, "Oyuncu oyunda de�il.");
    PlayerDrugData[id][Drugs] += miktar;
    MesajGonder(playerid, "%s adl� ki�iye %d miktar uyu�turucu verdiniz.", ReturnName(id, 0), miktar);
	return 1;
}
CMD:test(playerid, params[])
{
	SunucuMesaji(playerid, "Verileriniz kay�t edildi.");
	Oyuncu_Kaydet(playerid);
	return 1;
}
CMD:cekilisyap(playerid, params[])
{
	new cekilisSure = -1;
	if (PlayerData[playerid][pAdmin] < 4)
        return HataMesajGonder(playerid, "Bu komutu kullanmak i�in yetkiniz yok!");

	if (cekilisSure > -1)
	    return HataMesajGonder(playerid, "Hali haz�rda zaten bir �ekili� mevcut.");

	new tmp;

	if (sscanf(params, "d", tmp))
	    return BilgiMesajGonder(playerid, "/cekilisyap [S�re]");

	if (!(3 <= tmp <= 10))
	    return HataMesajGonder(playerid, "�ekili� s�resini en az 3, en fazla 10 yapabilirsiniz.");

	MesajGonder(playerid, "Ba�ar�l� bir �ekilde �ekili�i ba�latt�n�z.");
	cekilisSure = tmp;
	return 1;
}
CMD:pompaolustur(playerid)
{
    if(PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

	Pompa_Olustur(playerid);
	return 1;
}

CMD:pompasil(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

	new id;

	if(sscanf(params, "i", id))
		return KullanimMesaji(playerid, "/pompasil [id]");

	if(!Pompa[id][Pompa_Kontrol])
		return HataMesajGonder(playerid, "Ge�ersiz ID girdiniz.");

	if(Pompa[id][Pompa_Kullaniliyor])
		return HataMesajGonder(playerid, "Bu pompa �u anda kullan�l�yor, silinemez.");

	new query[64];

	mysql_format(g_SQL, query, sizeof query, "DELETE FROM `pompalar` WHERE `pompaID` = '%d'", Pompa[id][Pompa_ID]);
	mysql_tquery(g_SQL, query);

	if(IsValidDynamic3DTextLabel(Pompa[id][Pompa_Yazi]))
	{
		DestroyDynamic3DTextLabel(Pompa[id][Pompa_Yazi]);
		Pompa[id][Pompa_Yazi] = Text3D:INVALID_3DTEXT_ID;
	}
	if(IsValidDynamicObject(Pompa[id][Pompa_Obje]))
	{
		DestroyDynamicObject(Pompa[id][Pompa_Obje]);
		Pompa[id][Pompa_Obje] = INVALID_OBJECT_ID;
	}

	Pompa[id][Pompa_Kontrol] = false;

	MesajGonder(playerid, "%d ID'li pompa ba�ar�yla silindi.", id);
	return 1;
}

CMD:pompagit(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

	new id;

	if(sscanf(params, "i", id))
		return KullanimMesaji(playerid, "/pompagit [id]");

	if(!Pompa[id][Pompa_Kontrol])
		return HataMesajGonder(playerid, "Ge�ersiz ID girdiniz.");

	SetPlayerPos(playerid, Pompa[id][Pompa_Pos][0], Pompa[id][Pompa_Pos][1], Pompa[id][Pompa_Pos][2]);
	SetPlayerInterior(playerid, 0);
	SetPlayerVirtualWorld(playerid, 0);
	return 1;
}

CMD:pompaduzenle(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

	new id;

	if(sscanf(params, "i", id))
		return KullanimMesaji(playerid, "/pompaduzenle [id]");

	if(!Pompa[id][Pompa_Kontrol])
		return HataMesajGonder(playerid, "Ge�ersiz ID girdiniz.");

	if(Pompa[id][Pompa_Kullaniliyor])
		return HataMesajGonder(playerid, "Bu pompa �u anda kullan�l�yor, d�zenlenemez.");

	if(PlayerData[playerid][pDuzenlenenPompa] != -1)
		return HataMesajGonder(playerid, "�u anda sistemde benzin pompas� d�zenliyor olarak g�r�n�yorsunuz.");

	PlayerData[playerid][pDuzenlenenPompa] = id;
	EditDynamicObject(playerid, Pompa[id][Pompa_Obje]);

	MesajGonder(playerid, "L�tfen pompa objesinin pozisyonunu d�zenleyiniz.");
	return 1;
}

CMD:tamirgit(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

	new id;

	if(sscanf(params, "i", id))
		return KullanimMesaji(playerid, "/tamirgit [id]");

	if(!Tamirhane[id][Tamirhane_Kontrol])
		return HataMesajGonder(playerid, "Ge�ersiz ID girdiniz.");

	SetPlayerPos(playerid, Tamirhane[id][Tamirhane_Pos][0], Tamirhane[id][Tamirhane_Pos][1], Tamirhane[id][Tamirhane_Pos][2]);
	SetPlayerFacingAngle(playerid, Tamirhane[id][Tamirhane_Pos][3]);

	SetPlayerInterior(playerid, Tamirhane[id][Tamirhane_Interior]);
	SetPlayerVirtualWorld(playerid, Tamirhane[id][Tamirhane_World]);
	return 1;
}

CMD:tamirsil(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

	new id;

	if(sscanf(params, "i", id))
		return KullanimMesaji(playerid, "/tamirsil [id]");

	if(!Tamirhane[id][Tamirhane_Kontrol])
		return HataMesajGonder(playerid, "Ge�ersiz ID girdiniz.");

	if(Tamirhane[id][Tamirhane_Kullaniliyor] == 1)
		return HataMesajGonder(playerid, "Bu tamirhane �u anda kullan�l�yor, silinemez.");

	new query[64];

	mysql_format(g_SQL, query, sizeof query, "DELETE FROM `tamirhaneler` WHERE `tamirID` = '%d'", Tamirhane[id][Tamirhane_ID]);
	mysql_tquery(g_SQL, query);

	if(IsValidDynamic3DTextLabel(Tamirhane[id][Tamirhane_Yazi]))
	{
		DestroyDynamic3DTextLabel(Tamirhane[id][Tamirhane_Yazi]);
		Tamirhane[id][Tamirhane_Yazi] = Text3D:INVALID_3DTEXT_ID;
	}

	if(IsValidDynamicPickup(Tamirhane[id][Tamirhane_Pickup]))
		DestroyDynamicPickup(Tamirhane[id][Tamirhane_Pickup]);

	if(IsValidDynamicMapIcon(Tamirhane[id][Tamirhane_MapIcon]))
		DestroyDynamicMapIcon(Tamirhane[id][Tamirhane_MapIcon]);

	Tamirhane[id][Tamirhane_Kontrol] = false;

	MesajGonder(playerid, "%d ID'li tamirhane ba�ar�yla silindi.", id);
	return 1;
}

CMD:tamirduzenle(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

	new id, operation[15], str[50];
	if(sscanf(params, "ds[15]S()[50]", id, operation, str))
	{
		KullanimMesaji(playerid, "/tamirduzenle [id] [parametre]");
		SendClientMessage(playerid, -1, "PARAMETRELER: dispos | icpos | vakit");
		return 1;
	}

	if(!Tamirhane[id][Tamirhane_Kontrol])
		return HataMesajGonder(playerid, "Ge�ersiz ID girdiniz.");

	if(!strcmp(operation, "dispos", true))
	{
		new Float:x, Float:y, Float:z, Float:ang;

		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, ang);

		Tamirhane[id][Tamirhane_Pos][0] = x;
		Tamirhane[id][Tamirhane_Pos][1] = y;
		Tamirhane[id][Tamirhane_Pos][2] = z;
		Tamirhane[id][Tamirhane_Pos][3] = ang;

		Tamirhane[id][Tamirhane_Interior] = GetPlayerInterior(playerid);
		Tamirhane[id][Tamirhane_World] = GetPlayerVirtualWorld(playerid);

		BilgiMesajGonder(playerid, "%d ID'sine tan�ml� tamirhanenin d�� pozisyonu bulundu�unuz konuma getirildi.", id);
		Tamirhane_Kaydet(id, true);
		return 1;
	}
	else if(!strcmp(operation, "icpos", true))
	{
		new Float:x, Float:y, Float:z, Float:ang;

		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, ang);

		Tamirhane[id][Tamirhane_IcPos][0] = x;
		Tamirhane[id][Tamirhane_IcPos][1] = y;
		Tamirhane[id][Tamirhane_IcPos][2] = z;
		Tamirhane[id][Tamirhane_Pos][4] = ang;

		Tamirhane[id][Tamirhane_IcInterior] = GetPlayerInterior(playerid);

		BilgiMesajGonder(playerid, "%d ID'sine tan�ml� tamirhanenin i� pozisyonu bulundu�unuz konuma getirildi.", id);
		Tamirhane_Kaydet(id);
		return 1;
	}
	else if(!strcmp(operation, "vakit", true))
	{
		new vakit;

		if(sscanf(str, "i", vakit))
		{
			KullanimMesaji(playerid, "/tamirduzenle [%d] [vakit(saniye)]", id);
			return 1;
		}

		if(vakit < 1)
			return HataMesaji(playerid, "Girilen saniye 1'den k���k olamaz.");

		Tamirhane[id][Tamirhane_Vakit] = id;
		BilgiMesajGonder(playerid, "%d ID'sine tan�ml� tamirhanenin i�lem saniyesi %d olarak de�i�tirildi.", id, vakit);

		Tamirhane_Kaydet(id);
		return 1;
	}

	callcmd::tamirduzenle(playerid, "");
	return 1;
}

CMD:tamirolustur(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

	new saniye;

	if(sscanf(params, "i", saniye))
		return KullanimMesaji(playerid, "/tamirolustur [tamir saniyesi]");

	Tamirhane_Olustur(playerid, saniye);
	return 1;
}
CMD:sirketsil(playerid, params[])
{
    static
        id = 0;

    if (PlayerData[playerid][pAdmin] < 4)
        return HataMesaji(playerid, "Bu komutu kullanmak i�in yetkiniz yok !");

    if (sscanf(params, "d", id))
        return KullanimMesaji(playerid, "/sirketsil [sirket id]");

    if ((id < 0 || id >= MAX_SIRKET) || !sirketData[id][sirketExists])
        return HataMesaji(playerid, "You have specified an invalid sirket ID.");

    Sirket_Sil(id);
    SunucuMesaji(playerid, "You have successfully destroyed sirket ID: %d.", id);
    return 1;
}
CMD:lyarat(playerid, params[])
{
    if (PlayerData[playerid][pAdmin] < 1) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

	new labeladi[90], mesaj[100], labelid;
	if(sscanf(params, "s[90]", labeladi))
		return YollaJensenMesaj2(playerid, "/lyarat [label ad�]");
	if(!(1 <= strlen(labeladi) <= MAX_LABEL_ADI))
		return YollaJensenMesaj2(playerid, "Labellerin ad� 1 ve "#MAX_LABEL_ADI" aras�nda olmal�d�r.");

	labelid = BosLabelID();
	if(labelid == -1)
		return YollaJensenMesaj2(playerid, "Label s�n�r�na ula�t�n�z veya farkl� bir sorun var.");

	GetPlayerPos(playerid, Label[labelid][Pos][0], Label[labelid][Pos][1], Label[labelid][Pos][2]);

	DuzenleLabelID[playerid] = labelid;
	DuzenleLabel[playerid] = true;

	Label[labelid][Duzenleniyor] = 1;
	Label[labelid][VW] = GetPlayerVirtualWorld(playerid);
	Label[labelid][Int] = GetPlayerInterior(playerid);
	Label[labelid][Mesafe] = 20.0;
	Label[labelid][Renk] = 0xFFFFFFFF;
	strcpy(Label[labelid][LabelAdi], labeladi, 90);
	Label[labelid][objeID] = CreateDynamicObject(19475, Label[labelid][Pos][0]+1.0, Label[labelid][Pos][1]-1.0, Label[labelid][Pos][2], 0.0, 0.0, 0.0, Label[labelid][VW], Label[labelid][Int]);
	Label[labelid][ID] = CreateDynamic3DTextLabel(Label[labelid][LabelAdi], Label[labelid][Renk], Label[labelid][Pos][0]+1.0, Label[labelid][Pos][1]-1.0, Label[labelid][Pos][2], Label[labelid][Mesafe], INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, Label[labelid][VW], Label[labelid][Int], -1);
	format(mesaj, sizeof(mesaj), "Label yaratt�n ID: %d - Label Ad�: %s", labelid, labeladi);
	YollaJensenMesaj(playerid, mesaj);
	LabelYarat(labelid, labeladi, Label[labelid][Renk], Label[labelid][VW], Label[labelid][Int], Label[labelid][Pos][0], Label[labelid][Pos][1], Label[labelid][Pos][2], Label[labelid][Mesafe]);
	EditDynamicObject(playerid, Label[labelid][objeID]);
	return 1;
}

CMD:lduzenle(playerid, params[])
{
    if (PlayerData[playerid][pAdmin] < 1) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

	new labelid, secim[25], miktar[90], mesaj[150];
	if(sscanf(params, "ds[25]S(-1)[90]", labelid, secim, miktar))
	{
		YollaJensenMesaj2(playerid, "/lduzenle [label ID] [se�] [miktar]");
		YollaJensenMesaj2(playerid, "SE�: labeladi - pos - mesafe - renk");
		return 1;
	}
	if(!(0 <= labelid <= MAX_LABEL))
		return YollaJensenMesaj2(playerid, "Label idleri 0-"#MAX_LABEL" aras�ndad�r.");

	if(fexist(LabelDosya(labelid)))
	{
		if(strcmp(secim, "labeladi", true) == 0)
		{
			if(strval(miktar) == -1)
			{
				YollaJensenMesaj2(playerid, "/lduzenle [label ID] [se�im] [de�er]");
				YollaJensenMesaj2(playerid, "SE�: labeladi - pos - mesafe - renk");
				return 1;
			}
			if(!(1 <= strlen(miktar) <= MAX_LABEL_ADI))
				return YollaJensenMesaj(playerid, "Labellerin ad� 1 ve "#MAX_LABEL_ADI" aras�nda olmal�d�r.");
			format(mesaj, sizeof(mesaj), "[LABEL] {FFFFFF}ID: %d - Labelin ad�n� %s yapt�n.", labelid, miktar);
			YollaJensenMesaj(playerid, mesaj);
			strcpy(Label[labelid][LabelAdi], miktar, 90);
			UpdateDynamic3DTextLabelText(Label[labelid][ID], Label[labelid][Renk], Label[labelid][LabelAdi]);
			LabelGuncelle(labelid);
		}
		if(strcmp(secim, "pos", true) == 0)
		{
			if(!IsPlayerInRangeOfPoint(playerid, 10, Label[labelid][Pos][0], Label[labelid][Pos][1], Label[labelid][Pos][2]))
				return YollaJensenMesaj2(playerid, "Labele yak�n de�ilsin.");
			if(Label[labelid][Duzenleniyor] == 1)
				return YollaJensenMesaj2(playerid, "Bu label d�zenleniyor.");

			DuzenleLabelID[playerid] = labelid;
			DuzenleLabel[playerid] = true;
			Label[labelid][Duzenleniyor] = 1;
			format(mesaj, sizeof(mesaj), "[LABEL] {FFFFFF}ID: %d - Labeli d�zenledin.", labelid);
			YollaJensenMesaj(playerid, mesaj);
		   	EditDynamicObject(playerid, Label[labelid][objeID]);
		}
		if(strcmp(secim, "mesafe", true) == 0)
		{
			if(strval(miktar) == -1)
			{
				YollaJensenMesaj2(playerid, "/labelduzenle [label ID] [se�im] [de�er]");
				YollaJensenMesaj2(playerid, "[SE??M]: labeladi - pos - mesafe - renk");
				return 1;
			}
			if(!(1 <= strval(miktar) <= MAX_LABEL_MESAFE))
				return YollaJensenMesaj2(playerid, "Labellerin mesafesi 1.0 ve "#MAX_LABEL_MESAFE" aras�nda olmal�d�r.");
			Label[labelid][Mesafe] = floatstr(miktar);
			format(mesaj, sizeof(mesaj), "[LABEL] {FFFFFF}ID: %d - Labelin mesafesini %f yapt�n.", labelid, Label[labelid][Mesafe]);
			YollaJensenMesaj(playerid, mesaj);
			if(IsValidDynamic3DTextLabel(Label[labelid][ID]))
				DestroyDynamic3DTextLabel(Label[labelid][ID]);
			Label[labelid][ID] = CreateDynamic3DTextLabel(Label[labelid][LabelAdi], Label[labelid][Renk], Label[labelid][Pos][0], Label[labelid][Pos][1], Label[labelid][Pos][2], Label[labelid][Mesafe], INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, Label[labelid][VW], Label[labelid][Int], -1);
			LabelGuncelle(labelid);
		}
		if(strcmp(secim, "renk", true) == 0)
		{
			if(strval(miktar) == -1)
			{
				YollaJensenMesaj2(playerid, "/labelduzenle [label ID] [se�im] [de�er]");
				YollaJensenMesaj2(playerid, "[SE��M]: labeladi - pos - mesafe - renk");
				return 1;
			}
			if(strlen(miktar) != 10)
				return YollaJensenMesaj2(playerid, "Labellerin rengi Bu �ekilde olmal�d�r: 0xFFFFFFFF");

			new cikti, renk[50];
			format(renk, sizeof(renk), "%s", miktar);
			sscanf(renk, "x", cikti);
			Label[labelid][Renk] = cikti;
			format(mesaj, sizeof(mesaj), "[LABEL] {FFFFFF}ID: %d - Label rengini %s yapt�n.", labelid, renk);
			YollaJensenMesaj(playerid, mesaj);
			UpdateDynamic3DTextLabelText(Label[labelid][ID], Label[labelid][Renk], Label[labelid][LabelAdi]);
			LabelGuncelle(labelid);
		}
	}
	else
	{
		format(mesaj, sizeof(mesaj), "[LABEL] {FFFFFF}%d idli label yok.", labelid);
		YollaJensenMesaj(playerid, mesaj);
	}
	return 1;
}

CMD:lsil(playerid, params[])
{
    if (PlayerData[playerid][pAdmin] < 1) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

	new labelid, mesaj[150];
	if(sscanf(params, "d", labelid))
		return YollaJensenMesaj2(playerid, "/lsil [label ID]");

	if(!(0 <= labelid <= MAX_LABEL))
		return YollaJensenMesaj2(playerid, "Label idleri 0-"#MAX_LABEL" aras�ndad�r.");

	if(fexist(LabelDosya(labelid)))
	{
		DestroyDynamicObject(Label[labelid][objeID]);
		DestroyDynamic3DTextLabel(Label[labelid][ID]);
		Label[labelid][ID] = Text3D: INVALID_3DTEXT_ID;
		Label[labelid][Pos][0] = Label[labelid][Pos][1] = Label[labelid][Pos][2] = 0.0;
		strcpy(Label[labelid][LabelAdi], "-", MAX_LABEL_ADI);
		format(mesaj, sizeof(mesaj), "[LABEL] {FFFFFF}%d idli labeli sildin.", labelid);
		YollaJensenMesaj(playerid, mesaj);
		fremove(LabelDosya(labelid));
	}
	else
	{
		format(mesaj, sizeof(mesaj), "[LABEL] {FFFFFF}%d idli label yok.", labelid);
		YollaJensenMesaj(playerid, mesaj);
	}
	return 1;
}

CMD:lgit(playerid, params[])
{
    if (PlayerData[playerid][pAdmin] < 1) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

	new labelid, mesaj[150];
	if(sscanf(params, "d", labelid))
		return YollaJensenMesaj2(playerid, "/lgit [label ID]");

	if(!(0 <= labelid <= MAX_LABEL))
		return YollaJensenMesaj2(playerid, "Label idleri 0-"#MAX_LABEL" aras�ndad�r.");

	if(fexist(LabelDosya(labelid)))
	{
		SetPlayerPos(playerid, Label[labelid][Pos][0], Label[labelid][Pos][1], Label[labelid][Pos][2]+0.5);
		SetPlayerInterior(playerid, Label[labelid][Int]);
		SetPlayerVirtualWorld(playerid, Label[labelid][VW]);
		format(mesaj, sizeof(mesaj), "[LABEL] {FFFFFF}%d idli labele Gittin.", labelid);
		YollaJensenMesaj(playerid, mesaj);
	}
	else
	{
		format(mesaj, sizeof(mesaj), "[LABEL] {FFFFFF}%d idli label yok.", labelid);
		YollaJensenMesaj(playerid, mesaj);
	}
	return 1;
}

CMD:lyakin(playerid, params[])
{
    if (PlayerData[playerid][pAdmin] < 1) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

	new mesaj[150];
	YollaJensenMesaj2(playerid, "Yak�n�ndaki labellerin listesi;");
	for(new labelid = 0; labelid < MAX_LABEL; labelid++)
	{
		if(Label[labelid][Pos][0] >= 1)
		{
	 		if(IsPlayerInRangeOfPoint(playerid, 20, Label[labelid][Pos][0], Label[labelid][Pos][1], Label[labelid][Pos][2]))
			{
				format(mesaj, sizeof(mesaj), "Label ID: %d - Label Ad�: %s", labelid, Label[labelid][LabelAdi]);
				YollaJensenMesaj(playerid, mesaj);
			}
		}
	}
	return 1;
}
