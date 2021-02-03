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
		MesajGonder(playerid, "Kupon kodu oluþturuldu.");
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
		HataMesajGonder(playerid, "Böyle bir kod yok.");
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
    if (!OyundaDegil(id)) return HataMesajGonder(playerid, "Oyuncu giriþ yapmamýþ.");
    if (level < 0 || level > 5) return HataMesajGonder(playerid, "Level 0'dan küçük, 5'den fazla olamaz.");
    SendAdminAction(id, "%s Adlý yetkili tarafýndan %d seviye yetkili oldunuz.",PlayerData[playerid][pAdminName],level);
    SendAdminAction(playerid, "%s Adlý oyuncuyu %d seviye yetkili yaptýnýz.",ReturnName(id),level);
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
			SendAdminAction(oyuncuid, "%s, adlý yetkili tarafýndan oyun görevlisi yapýldýnýz.", ReturnName(playerid));
			SendAdminAction(playerid, "%s, kiþisini oyun görevlisi yaptýnýz.", ReturnName(oyuncuid));

			PlayerData[oyuncuid][pOyunGorevlisi] = 1;
		}

		default:
		{
			SendAdminAction(oyuncuid, "%s, adlý yetkili tarafýndan oyun görevlisi yetkiniz alýndý.", ReturnName(playerid));
			SendAdminAction(playerid, "%s, kiþisinin oyun görevlisi yetkisini aldýnýz.", ReturnName(oyuncuid));

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
   			SendAdminAction(oyuncuid, "%s, adlý yetkili tarafýndan forum görevlisi yapýldýnýz.", ReturnName(playerid));
			SendAdminAction(playerid, "%s, kiþisini forum görevlisi yaptýnýz.", ReturnName(oyuncuid));

			PlayerData[oyuncuid][pForumGorevlisi] = 1;
		}

		default:
		{
   			SendAdminAction(oyuncuid, "%s, adlý yetkili tarafýndan forum görevlisi yetkiniz alýndý.", ReturnName(playerid));
			SendAdminAction(playerid, "%s, kiþisinin forum görevlisi yetkisini aldýnýz.", ReturnName(oyuncuid));

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
    if (!OyundaDegil(id)) return HataMesajGonder(playerid, "Oyuncu giriþ yapmamýþ.");
    if (PlayerData[id][pYoutuber] == 0)
    {
        PlayerData[id][pYoutuber] = 1;
        MesajGonder(playerid, "%s adlý kiþiye Youtuber & Streamer yetkisi verdiniz.", Player_GetName(id));
        BilgiMesajGonder(id, "%s adlý yetkili size Youtuber & Streamer yetkisi verdi. (/ytag)", PlayerData[playerid][pAdminName]);
    }
    else
    {
        PlayerData[id][pYoutuber] = 0;
        PlayerData[id][pYoutuberTag] = false;
        MesajGonder(playerid, "%s adlý kiþinin Youtuber & Streamer yetkisini sildiniz.", Player_GetName(id));
        BilgiMesajGonder(id, "%s adlý yetkili tarafýndan Youtuber & Streamer yetkiniz silindi.", PlayerData[playerid][pAdminName]);
	}
	return 1;
}
CMD:sethelper(playerid,params[])
{
	new id,level;
	if (!OyundaDegil(playerid)) return 1;
    if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
    if (sscanf(params, "ui",id,level)) return KullanimMesajGonder(playerid, "/sethelper [ID/Isim] [Level]");
    if (!OyundaDegil(id)) return HataMesajGonder(playerid, "Oyuncu giriþ yapmamýþ.");
    if (level < 0 || level > 5) return HataMesajGonder(playerid, "Level 0'dan küçük, 5'den fazla olamaz.");
    SendAdminAction(id, "%s Adlý yetkili tarafýndan %d seviye helper oldunuz.",PlayerData[playerid][pAdminName],level);
    SendAdminAction(playerid, "%s Adlý oyuncuyu %d seviye helper yaptýnýz.",ReturnName(id),level);
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
        return HataMesajGonder(playerid, "Sunucu bina sýnýrýna ulaþmýþtýr.");

    MesajGonder(playerid, "Baþarýyla bina oluþturdun, ID: %d.", id);
    return 1;
}
CMD:ciftlikolustur(playerid, params[])
{
	new tip, metrekare, fiyat, maxtohum;
    if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
    if (sscanf(params, "iiii", tip, metrekare, fiyat, maxtohum)) return KullanimMesajGonder(playerid, "/ciftlikolustur [Tip 1 - Satýlýk 2 - Kiralýk] [Dönüm] [Fiyat] [Max Hayvan]");
    if (tip < 1 || tip > 2) return HataMesajGonder(playerid, "Geçersiz tip girdiniz, 1 veya 2 olmalýdýr.");
    if (metrekare < 10 || metrekare > 100) return HataMesajGonder(playerid, "Dönüm 10 ile 100 arasýnda olmalýdýr.");

    new id = Arsa_Olustur(playerid, tip, metrekare, fiyat, maxtohum);
    if (id == -1) return HataMesajGonder(playerid, "Sunucuda daha fazla çiftlik oluþturulamaz.");
    MesajGonder(playerid, "Çiftlik oluþturuldu, ID: %d.", id);
	return 1;
}
CMD:ciftliksil(playerid, params[])
{
    if (!OyundaDegil(playerid)) return 1;
    if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
    new id;
    if (sscanf(params, "i", id)) return KullanimMesajGonder(playerid, "/ciftliksil [ID]");
    if ((id < 0 || id >= MAX_ARSA) || !ArsaBilgi[id][arsaExists]) return HataMesajGonder(playerid, "Geçersiz ID.");
    Arsa_Sil(id);
    MesajGonder(playerid, "Çiftlik silindi");
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
    if ((id < 0 || id >= MAX_ARSA) || !ArsaBilgi[id][arsaExists]) return HataMesajGonder(playerid, "Geçersiz ID girdiniz.");
    if (!strcmp(type, "tip", true))
    {
        if (isnull(string)) return KullanimMesajGonder(playerid, "/ciftlikduzenle [ID] [tip] [1 - Satýlýk 2 - Kiralýk]");
        if (strval(string) < 1 || strval(string) > 2) return HataMesajGonder(playerid, "Geçersiz tip.");
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
        if (isnull(string)) return KullanimMesajGonder(playerid, "/ciftlikduzenle [ID] [metrekare] [Dönüm]");
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

        MesajGonder(playerid, "NPC Eklendi, (/npcduzenle) komutu ile düzenleyebilirsiniz. (ID: %d)", i);

        NPC_Refresh(i);
		NPC_Save(i);
		return 1;
    }
    HataMesajGonder(playerid, "Sunucu maksimum NPC limitine ulaþmýþtýr.");
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
    if ((id < 0 || id >= MAXIMUM_NPC) || !NPCBilgi[id][npcExists]) return HataMesajGonder(playerid, "Geçersiz ID girdiniz.");
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
        if (skin < 1 || skin > 311) return HataMesajGonder(playerid, "Geçersiz Skin ID.");
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
    if ((id < 0 || id >= MAXIMUM_NPC) || NPCBilgi[id][npcExists] == false) return HataMesajGonder(playerid, "Geçersiz ID.");
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
	if (PlayerData[playerid][pAdmin] < 1 && !PlayerData[playerid][pOyunGorevlisi]) return HataMesajGonder(playerid, "Bu komutu kullanmak için yetkiniz yok");
	if (PlayerData[playerid][pBaygin] == 1) return HataMesajGonder(playerid, "Bunu þu an yapamazsýnýz.");
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
        return HataMesajGonder(playerid, "Geçersiz ID girdiniz.");

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
            return KullanimMesajGonder(playerid, "/binaduzenle [id] [vw] [Vw] (-1 yazarsanýz otomatik virtual world ayarlanýr)");

        EntranceData[id][entranceInteriorVw] = vw;
        Entrance_Save(id);
	}
	if (!strcmp(type, "garajbaglanti", true))
	{
	    new garaj;
	    if (sscanf(string, "d", garaj))
            return KullanimMesajGonder(playerid, "/binaduzenle [id] [garajbaglanti] [Garaj ID] (-1 yazarsanýz hiçbir garaj ile baðlantýsý olmaz)");
        if ((garaj < 0 || garaj >= MAX_GARAGE) || !GarageData[garaj][gExists])
	    return HataMesajGonder(playerid, "Hatalý garaj ID girdiniz.");

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

        AdminMessage(COLOR_LIGHTRED, "*** %s adlý yetkili %d ID'li binanýn pozisyonunu deðiþtirdi.", PlayerData[playerid][pAdminName], id);
    }
    else if (!strcmp(type, "interior", true))
    {
        GetPlayerPos(playerid, EntranceData[id][entranceInt][0], EntranceData[id][entranceInt][1], EntranceData[id][entranceInt][2]);
        GetPlayerFacingAngle(playerid, EntranceData[id][entranceInt][3]);

        EntranceData[id][entranceInterior] = GetPlayerInterior(playerid);
        Entrance_Save(id);
        AdminMessage(COLOR_LIGHTRED, "*** %s adlý yetkili %d ID'li binanýn interiorunu deðiþtirdi.", PlayerData[playerid][pAdminName], id);
    }
    else if (!strcmp(type, "mapicon", true))
    {
        new icon;

        if (sscanf(string, "d", icon))
            return KullanimMesajGonder(playerid, "/binaduzenle [id] [mapicon] [map icon]");

        if (icon < 0 || icon > 63)
            return HataMesajGonder(playerid, "Geçersiz Map Icon ID.");

        EntranceData[id][entranceIcon] = icon;

        Entrance_Refresh(id);
        Entrance_Save(id);

        AdminMessage(COLOR_LIGHTRED, "*** %s adlý yetkili %d ID'li binanýn mapiconunu %d olarak ayarladý.", PlayerData[playerid][pAdminName], id, icon);
    }
    else if (!strcmp(type, "vip", true))
    {
        new i;

        if (sscanf(string, "d", i))
            return KullanimMesajGonder(playerid, "/binaduzenle [id] [vip] [0 özel deðil 1 özel]");

        EntranceData[id][eVip] = i;

        Entrance_Refresh(id);
        Entrance_Save(id);

        AdminMessage(COLOR_LIGHTRED, "*** %s adlý yetkili %d ID'li binanýn mapiconunu %d olarak ayarladý.", PlayerData[playerid][pAdminName], id, i);
    }
    else if (!strcmp(type, "sifre", true))
    {
        new password[32];

        if (sscanf(string, "s[32]", password))
            return KullanimMesajGonder(playerid, "/binaduzenle [id] [sifre] [Þifre] (Kapatmak için 'yok' yazýn)");

        if (!strcmp(password, "yok", true)) {
            EntranceData[id][entrancePass][0] = 0;
        }
        else {
            format(EntranceData[id][entrancePass], 32, password);
        }
        Entrance_Save(id);
        AdminMessage(COLOR_LIGHTRED, "*** %s adlý yetkili %d ID'li býnanýn þifresini deðiþtirdi.", PlayerData[playerid][pAdminName], id);
    }
    else if (!strcmp(type, "kilit", true))
    {
		if (EntranceData[id][entranceLocked] == 1)
		{
		    EntranceData[id][entranceLocked] = 0;
		    AdminMessage(COLOR_LIGHTRED, "*** %s adlý yetkili tarafýndan %d ID'li býnanýn kilidi açýldý.", PlayerData[playerid][pAdminName], id);
		}
		else
		{
		    EntranceData[id][entranceLocked] = 1;
		    AdminMessage(COLOR_LIGHTRED, "*** %s adlý yetkili tarafýndan %d ID'li bina kilitlendi.", PlayerData[playerid][pAdminName], id);
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

        AdminMessage(COLOR_LIGHTRED, "*** %s adlý yetkili %d ID'li binanýn ismini %s olarak ayarladý.", PlayerData[playerid][pAdminName], id, name);
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
        return HataMesajGonder(playerid, "Geçersiz ID girdiniz.");

    Entrance_Delete(id);
    MesajGonder(playerid, "Bina silindi, ID: %d", id);
    return 1;
}

CMD:a(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] < 1) return HataMesajGonder(playerid,"Bu komutu kullanmak için yetkiniz yok");

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
	if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Bu komutu kullanmak için yetkiniz yok");
	if (sscanf(params, "us[24]",id,name)) return KullanimMesajGonder(playerid, "/setstaffname [ID/Isim] [Isim]");
	if (!OyundaDegil(id)) return HataMesajGonder(playerid, "Oyuncu giriþ yapmamýþ.");
	if (strlen(name) < 3 || strlen(name) > 24) return HataMesajGonder(playerid, "Ýsim 3 ile 24 karakter arasýnda olmalýdýr.");
	if (TurkceKarakter(name)) return HataMesajGonder(playerid, "Ýsim özel karakterler ve türkçe karakterler içeremez.");
	format(PlayerData[id][pAdminName],24,name);

	SendAdminAction(playerid, "%s adlý oyuncunun yetkili adýný \"%s\" olarak ayarladýn.",ReturnName(id),name);

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
        MesajGonder(playerid,"Ýþbaþý yaptýnýz.");
    }
    else
    {
        PlayerTextDrawHide(playerid, adminduty[playerid]);
        PlayerData[playerid][pAdminDuty] = 0;
  //      PlayerData[playerid][pGOD] = false;
        SetPlayerHealth(playerid, 100);
        MesajGonder(playerid,"Ýþbaþýndan çýktýnýz.");
	}
	return 1;
}

CMD:apark(playerid, params[])
{
	new id, garajid;
    if (PlayerData[playerid][pAdmin] < 1) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
    if (sscanf(params, "ii", id, garajid)) return KullanimMesajGonder(playerid, "/apark [Araç ID] [Garaj ID] (garajda deðilse -1 yaz)");
	if (!IsValidVehicle(id)) return HataMesajGonder(playerid, "Geçersiz Araç ID.");
	new vehicleid = Car_GetID(id);
	if (vehicleid == -1) return HataMesajGonder(playerid, "Geçersiz Araç ID.");
 	GetVehiclePos(AracInfo[vehicleid][aracVehicle], AracInfo[vehicleid][aracPos][0],AracInfo[vehicleid][aracPos][1], AracInfo[vehicleid][aracPos][2]);
	GetVehicleZAngle(AracInfo[vehicleid][aracVehicle], AracInfo[vehicleid][aracPos][3]);
 	AracInfo[vehicleid][aracGaraj] = garajid;
	AracInfo[vehicleid][aracInterior] = CarInterior[id];
	AracInfo[vehicleid][aracWorld] = GetVehicleVirtualWorld(id);
 	Arac_Kaydet(vehicleid);

	Arac_Spawn(vehicleid);

	MesajGonder(playerid, "Araç park edildi.");
	return 1;
}
CMD:savepos(playerid, params[])
{
	if (!OyundaDegil(playerid)) return 1;
	if (PlayerData[playerid][pAdmin] < 1 && PlayerData[playerid][pHelper] < 1) return HataMesajGonder(playerid, "Bu komutu kullanmak için yetkiniz yok!");

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
	if (PlayerData[playerid][pAdmin] < 1 && PlayerData[playerid][pHelper] < 1) return HataMesajGonder(playerid, "Bu komutu kullanmak için yetkiniz yok!");
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
    BilgiMesajGonder(playerid, "Kayýtlý konuma döndünüz.");
}
else
{
    HataMesajGonder(playerid, "Herhangi bir kayýtlý konumunuz yok.");
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
        MesajGonder(playerid,"Ýþbaþý yaptýnýz.");
    }
    else
    {
        PlayerTextDrawHide(playerid, helperduty[playerid]);
        PlayerData[playerid][pHelperDuty] = 0;
        MesajGonder(playerid,"Ýþbaþýndan çýktýnýz.");
	}
	return 1;
}
CMD:saracekle(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] < 5)
        return 0;

    new model, fiyat;

    if(sscanf(params, "dd", model, fiyat))
        return KullanimMesaji(playerid, "/saracekle [araç modeli] [fiyat]");

    if(fiyat < 0)
        return HataMesajGonder(playerid, "Geçersiz fiyat girdiniz.");

    new query[57 + 11 + 11 + 1];

    mysql_format(g_SQL, query, sizeof(query), "INSERT INTO satilikaraclar SET model = '%d', fiyat = '%d'", model, fiyat);
    mysql_query(g_SQL, query);

    SunucuMesaji(playerid, "%d numaralý aracý $%d olarak galeriye eklediniz.", model, fiyat);

    return 1;
}
CMD:near(playerid, params[])
{
	static
	    id = -1;

    if (PlayerData[playerid][pAdmin] < 1)
	    return HataMesajGonder(playerid, "Yetkin yok!");

	if ((id = House_Nearest(playerid)) != -1)
	    MesajGonder(playerid, "Yakýnýndaki Ev ID: %d.", id);

    if ((id = Business_Nearest(playerid)) != -1)
	    MesajGonder(playerid, "Yakýnýndaki Ýþyeri ID: %d.", id);

    if ((id = Entrance_Nearest(playerid)) != -1)
	    MesajGonder(playerid, "Yakýnýndaki Bina ID: %d.", id);

    if ((id = Garage_Nearest(playerid)) != -1)
	    MesajGonder(playerid, "Yakýnýndaki Garaj ID: %d.", id);

    if ((id = Arrest_Nearest(playerid)) != -1)
	    MesajGonder(playerid, "Yakýnýndaki Hapishane Noktasý ID: %d.", id);

    if ((id = Gate_Nearest(playerid)) != -1)
	    MesajGonder(playerid, "Yakýnýndaki Gate ID: %d.", id);

	if ((id = NPC_Nearest(playerid)) != -1)
		MesajGonder(playerid, "Yakýnýndaki NPC ID: %d", id);

	if ((id = GetNearestCCTV(playerid)) != -1)
		MesajGonder(playerid, "Yakýnýndaki CCTV ID: %d", id);

	return 1;
}
CMD:askin(playerid)
{
	if (!OyundaDegil(playerid)) return 1;
	if (PlayerData[playerid][pAdmin] < 1) return HataMesajGonder(playerid, "Bu komutu kullanmak için yetkiniz yok!");
	if (PlayerData[playerid][pKelepce] > 0 || PlayerData[playerid][pHapisSure] > 0 || PlayerData[playerid][pSoklandi] > 0 || PlayerData[playerid][pYereYatirildi] > 0 || PlayerData[playerid][pBaygin] == 1 || PetKontrol[playerid] != -1 || pbOda[playerid] != -1)
 	return HataMesajGonder(playerid, "Þu an bu komutu kullanamazsýnýz.");
 	if (PlayerData[playerid][pAsoyun] == true)
 	{
 	    PlayerData[playerid][pAsoyun] = false;
 	    SetPlayerSkin(playerid, PlayerData[playerid][pSkin]);
 	}
 	else
 	{
 	    if (PlayerData[playerid][pCinsiyet] == 1) Dialog_Show(playerid, askin, DIALOG_STYLE_PREVMODEL, "Admin Skinleri - Erkek", "20012\n20013\n20014\n20015\n20016\n20017\n20018\n20019\n20020\n20021\n20022\n20023\n20024\n20025\n20026\n20027", "Sec", "Kapat");//erkek karkter
 	    else Dialog_Show(playerid, askin, DIALOG_STYLE_PREVMODEL, "Admin Skinleri - Kadýn", "20012\n20013\n20014\n20015\n20016\n20017\n20018\n20019\n20020\n20021\n20022\n20023\n20024\n20025\n20026\n20027", "Sec", "Kapat");//kadýn karakter

 	}
	return 1;
}
CMD:hskin1(playerid)
{
	if (!OyundaDegil(playerid)) return 1;
	if (PlayerData[playerid][pAdmin] < 1 && PlayerData[playerid][pHelper] < 1) return HataMesajGonder(playerid, "Bu komutu kullanmak için yetkiniz yok!");
	if (PlayerData[playerid][pKelepce] > 0 || PlayerData[playerid][pHapisSure] > 0 || PlayerData[playerid][pSoklandi] > 0 || PlayerData[playerid][pYereYatirildi] > 0 || PlayerData[playerid][pBaygin] == 1 || PetKontrol[playerid] != -1 || pbOda[playerid] != -1)
 	return HataMesajGonder(playerid, "Þu an bu komutu kullanamazsýnýz.");
 	if (PlayerData[playerid][pAsoyun] == true)
 	{
 	    PlayerData[playerid][pAsoyun] = false;
 	    SetPlayerSkin(playerid, PlayerData[playerid][pSkin]);
 	}
 	else
 	{
 	    if (PlayerData[playerid][pCinsiyet] == 1) Dialog_Show(playerid, hskin, DIALOG_STYLE_PREVMODEL, "Helper Skinleri - Erkek", "20014\n20012", "Sec", "Kapat");//erkek karkter
 	    else Dialog_Show(playerid, hskin, DIALOG_STYLE_PREVMODEL, "Helper Skinleri - Kadýn", "20014\n20012", "Sec", "Kapat");//kadýn karakter

 	}
	return 1;
}
CMD:hskin2(playerid)
{
	if (!OyundaDegil(playerid)) return 1;
	if (PlayerData[playerid][pAdmin] < 1 && PlayerData[playerid][pHelper] < 2) return HataMesajGonder(playerid, "Bu komutu kullanmak için yetkiniz yok!");
	if (PlayerData[playerid][pKelepce] > 0 || PlayerData[playerid][pHapisSure] > 0 || PlayerData[playerid][pSoklandi] > 0 || PlayerData[playerid][pYereYatirildi] > 0 || PlayerData[playerid][pBaygin] == 1 || PetKontrol[playerid] != -1 || pbOda[playerid] != -1)
 	return HataMesajGonder(playerid, "Þu an bu komutu kullanamazsýnýz.");
 	if (PlayerData[playerid][pAsoyun] == true)
 	{
 	    PlayerData[playerid][pAsoyun] = false;
 	    SetPlayerSkin(playerid, PlayerData[playerid][pSkin]);
 	}
 	else
 	{
 	    if (PlayerData[playerid][pCinsiyet] == 1) Dialog_Show(playerid, hskin, DIALOG_STYLE_PREVMODEL, "Helper Skinleri - Erkek", "20014\n20012\n20024\n20020", "Sec", "Kapat");//erkek karkter
 	    else Dialog_Show(playerid, hskin, DIALOG_STYLE_PREVMODEL, "Helper Skinleri - Kadýn", "20014\n20012\n20024\n20020", "Sec", "Kapat");//kadýn karakter

 	}
	return 1;
}
CMD:hskin3(playerid)
{
	if (!OyundaDegil(playerid)) return 1;
	if (PlayerData[playerid][pAdmin] < 1 && PlayerData[playerid][pHelper] < 3) return HataMesajGonder(playerid, "Bu komutu kullanmak için yetkiniz yok!");
	if (PlayerData[playerid][pKelepce] > 0 || PlayerData[playerid][pHapisSure] > 0 || PlayerData[playerid][pSoklandi] > 0 || PlayerData[playerid][pYereYatirildi] > 0 || PlayerData[playerid][pBaygin] == 1 || PetKontrol[playerid] != -1 || pbOda[playerid] != -1)
 	return HataMesajGonder(playerid, "Þu an bu komutu kullanamazsýnýz.");
 	if (PlayerData[playerid][pAsoyun] == true)
 	{
 	    PlayerData[playerid][pAsoyun] = false;
 	    SetPlayerSkin(playerid, PlayerData[playerid][pSkin]);
 	}
 	else
 	{
 	    if (PlayerData[playerid][pCinsiyet] == 1) Dialog_Show(playerid, hskin, DIALOG_STYLE_PREVMODEL, "Helper Skinleri - Erkek", "20014\n20012\n20024\n20020\n20023\n20022", "Sec", "Kapat");//erkek karkter
 	    else Dialog_Show(playerid, hskin, DIALOG_STYLE_PREVMODEL, "Helper Skinleri - Kadýn", "20014\n20012\n20024\n20020\n20023\n20022", "Sec", "Kapat");//kadýn karakter

 	}
	return 1;
}
CMD:hskin4(playerid)
{
	if (!OyundaDegil(playerid)) return 1;
	if (PlayerData[playerid][pAdmin] < 1 && PlayerData[playerid][pHelper] < 4) return HataMesajGonder(playerid, "Bu komutu kullanmak için yetkiniz yok!");
	if (PlayerData[playerid][pKelepce] > 0 || PlayerData[playerid][pHapisSure] > 0 || PlayerData[playerid][pSoklandi] > 0 || PlayerData[playerid][pYereYatirildi] > 0 || PlayerData[playerid][pBaygin] == 1 || PetKontrol[playerid] != -1 || pbOda[playerid] != -1)
 	return HataMesajGonder(playerid, "Þu an bu komutu kullanamazsýnýz.");
 	if (PlayerData[playerid][pAsoyun] == true)
 	{
 	    PlayerData[playerid][pAsoyun] = false;
 	    SetPlayerSkin(playerid, PlayerData[playerid][pSkin]);
 	}
 	else
 	{
 	    if (PlayerData[playerid][pCinsiyet] == 1) Dialog_Show(playerid, hskin, DIALOG_STYLE_PREVMODEL, "Helper Skinleri - Erkek", "20014\n20012\n20024\n20020\n20023\n20022\n20021\n20027", "Sec", "Kapat");//erkek karkter
 	    else Dialog_Show(playerid, hskin, DIALOG_STYLE_PREVMODEL, "Helper Skinleri - Kadýn", "20014\n20012\n20024\n20020\n20023\n20022\n20021\n20027", "Sec", "Kapat");//kadýn karakter

 	}
	return 1;
}
CMD:hskin5(playerid)
{
	if (!OyundaDegil(playerid)) return 1;
	if (PlayerData[playerid][pAdmin] < 1 && PlayerData[playerid][pHelper] < 5) return HataMesajGonder(playerid, "Bu komutu kullanmak için yetkiniz yok!");
	if (PlayerData[playerid][pKelepce] > 0 || PlayerData[playerid][pHapisSure] > 0 || PlayerData[playerid][pSoklandi] > 0 || PlayerData[playerid][pYereYatirildi] > 0 || PlayerData[playerid][pBaygin] == 1 || PetKontrol[playerid] != -1 || pbOda[playerid] != -1)
 	return HataMesajGonder(playerid, "Þu an bu komutu kullanamazsýnýz.");
 	if (PlayerData[playerid][pAsoyun] == true)
 	{
 	    PlayerData[playerid][pAsoyun] = false;
 	    SetPlayerSkin(playerid, PlayerData[playerid][pSkin]);
 	}
 	else
 	{
 	    if (PlayerData[playerid][pCinsiyet] == 1) Dialog_Show(playerid, hskin, DIALOG_STYLE_PREVMODEL, "Helper Skinleri - Erkek", "20014\n20012\n20024\n20020\n20023\n20022\n20021\n20027\n20026\n20025", "Sec", "Kapat");//erkek karkter
 	    else Dialog_Show(playerid, hskin, DIALOG_STYLE_PREVMODEL, "Helper Skinleri - Kadýn", "20014\n20012\n20024\n20020\n20023\n20022\n20021\n20027\n20026\n20025", "Sec", "Kapat");//kadýn karakter

 	}
	return 1;
}
CMD:pmspec(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 2) return HataMesajGonder(playerid, "Bu komutu kullanmak için yetkiniz yok!");
	if (isnull(params))
 	{
	 	BilgiMesajGonder(playerid, "/pmspec [aç/kapat]");
		return 1;
	}
	if (!strcmp(params, "aç", true))
	{
	PlayerData[playerid][PMKapali] = 0;
	MesajGonder(playerid, "PM Ýzleme Açýldý");
	}
	else if (!strcmp(params, "kapat", true))
	{
	PlayerData[playerid][PMKapali] = 1;
	MesajGonder(playerid, "PM Ýzleme kapatýldý");
 }
	return 1;
}
CMD:apm(playerid, params[])
{
    static
	    userid,
	    text[128];
	if (PlayerData[playerid][pAdmin] < 1) return HataMesajGonder(playerid, "Bu komutu kullanmak için yetkiniz yok!");
	if (sscanf(params, "us[128]", userid, text))
	    return BilgiMesajGonder(playerid, "/apm [ID/Isim] [mesaj]");

	if (!OyundaDegil(userid))
	    return HataMesajGonder(playerid, "Oyuncu oyunda deðil !");

	if (userid == playerid)
	    return HataMesajGonder(playerid, "Kendine özel mesaj yollayamazsýn.");

    PlayerData[playerid][pLastPM] = userid;
	if (IsPlayerPause(userid)) MesajGonder(playerid, "Bu oyuncu AFK, mesajýnýza yanýt veremeyebilir.");
	SendClientMessageEx(userid, COLOR_YELLOW, "[STAFF] «« %s (%d): %s", PlayerData[playerid][pAdminName], playerid, text);
	SendClientMessageEx(playerid, 0xdede02FF, "[STAFF] »» %s (%d): %s", ReturnName(userid, 0), userid, text);

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
	    return HataMesajGonder(playerid, "Belirttiðiniz kiþi baþvuru göndermemiþ.");

	AdminHelperMessage(COLOR_LIGHTRED, "AdmCmd: %s adlý yetkili %s adlý oyuncunun attýðý baþvurusunu kabul etti.", ReturnName(playerid, 0), ReturnName(userid, 0));
    AdminHelperMessage(COLOR_LIGHTRED, "AdmCmd: %s adlý helper %s adlý oyuncunun attýðý baþvurusunu onayladý.", ReturnName(playerid, 0), ReturnName(userid, 0));
 	PlayerData[userid][pBasvuru][0] = 0;
				SetPlayerPos(userid, 1328.0520,277.7649,19.6303);
		SetPlayerInterior(userid,0);
		MesajGonder(userid, "Baþvurunuz kabul edildi ve los Santos için iniþ saðlýyorsunuz, bekleyiniz..");
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
	    return HataMesajGonder(playerid, "Belirttiðiniz kiþi baþvuru göndermemiþ.");

	AdminHelperMessage(COLOR_LIGHTRED, "AdmCmd: %s adlý yetkili %s adlý oyuncunun reklamýný reddetdi.", ReturnName(playerid, 0), ReturnName(userid, 0));
    AdminHelperMessage(COLOR_LIGHTRED, "AdmCmd: %s adlý helper %s adlý oyuncunun reklamýný reddetdi.", ReturnName(playerid, 0), ReturnName(userid, 0));

	MesajGonder(userid, "%s attýðýnýz baþvuruyu uygun görmediði için reddetdi.", ReturnName(playerid, 0));
	PlayerData[userid][pBasvuru][0] = 0;
	return 1;
}
CMD:amotor(playerid)
{
    new vehicleid = GetPlayerVehicleID(playerid);
    new id = Car_GetID(vehicleid);

	if (PlayerData[playerid][pAdmin] < 1) return HataMesajGonder(playerid, "Bu komutu kullanmak için yetkiniz yok !");
    if (!IsEngineVehicle(vehicleid)) return HataMesajGonder(playerid, "Bu komutu sadece araçta kullanabilirsin.");
    if (PlayerData[playerid][pBaygin] == 1) return HataMesajGonder(playerid, "Bu komutu yaralýyken kullanamazsýn.");
   	if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return HataMesajGonder(playerid, "Sürücü deðilsin.");
   	if (AracInfo[id][aracBenzin] < 0.1) return HataMesajGonder(playerid, "Bu aracýn yakýtý bitmiþ.");
   	if (AracHasar(vehicleid) <= 300) return HataMesajGonder(playerid, "Bu araca çok fazla hasar verilmiþ, motor çalýþmýyor.");
   	if (UsingPumpID[playerid] != -1) return HataMesajGonder(playerid, "Þu an motoru çalýþtýramazsýnýz!");
   	    switch (GetEngineStatus(vehicleid))
   	    {
   	        case false:
   	        {
   	            AdminMessage(COLOR_LIGHTRED, "%s %s, admin komutu ile aracýn motorunu çalýþtýrdý.", GetAdminRank(playerid), PlayerData[playerid][pAdminName]);
   	            SetEngineStatus(vehicleid, true);
   	            Log_Write("logs/amotor.log", "[%s] %s %s, admin komutu ile aracýn motorunu çalýþtýrdý.", ReturnDate(), GetAdminRank(playerid), PlayerData[playerid][pAdminName]);
   	        }
   	        case true:
   	        {
            	SetEngineStatus(vehicleid, false);
				PlayerData[playerid][pLegalMotor] = 1;
                AdminMessage(COLOR_LIGHTRED, "%s %s, admin komutu ile aracýn motorunu kapattý.", GetAdminRank(playerid), PlayerData[playerid][pAdminName]);
   	            SetTimerEx("LegalEngine", 6500, false, "d", playerid);
   	            Log_Write("logs/amotor.log", "[%s] %s %s, admin komutu ile aracýn motorunu kapattý.", ReturnDate(), GetAdminRank(playerid), PlayerData[playerid][pAdminName]);
   	        }
   	    }
	return 1;
}
CMD:kapiyikir(playerid)
{
    if (!OyundaDegil(playerid)) return 1;
    if (PlayerData[playerid][pBaygin] == 1) return HataMesajGonder(playerid, "Bunu þu an yapamazsýnýz.");
    if (GetFactionType(playerid) != BIRLIK_LSPD && GetFactionType(playerid) != BIRLIK_FBI) return HataMesajGonder(playerid, "Devlet memuru deðilsin.");
    if (PlayerData[playerid][pKelepce] > 0 || PlayerData[playerid][pHapisSure] > 0 || PlayerData[playerid][pSoklandi] > 0 || PlayerData[playerid][pYereYatirildi] > 0 || PlayerData[playerid][pBaygin] == 1 || PetKontrol[playerid] != -1 || pbOda[playerid] != -1 || GetPVarInt(playerid, "IpBaglandi") == 1)
 	return HataMesajGonder(playerid, "Þu an bu komutu kullanamazsýnýz.");
    static id = -1;
    if ((id = House_Nearest(playerid)) != -1)
    {
		if (!HouseInfo[id][evKilit]) return HataMesajGonder(playerid, "Bu ev kilitli deðil.");

		ApplyAnimation(playerid, "POLICE", "Door_Kick", 4.0, 0, 0, 0, 0, 0);
		ApplyAnimation(playerid, "POLICE", "Door_Kick", 4.0, 0, 0, 0, 0, 0);
		SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s evin kapýsýna sert bir tekme atar ve kapý kýrýlýr.", ReturnName(playerid, 0));
		HouseInfo[id][evKilit] = 0;
		Ev_Yenile(id);

	}
	else if ((id = Business_Nearest(playerid)) != -1)
	{
	    if (Isyeri[id][isyeriKilit] == 0) return HataMesajGonder(playerid, "Bu iþyeri kilitli deðil.");
	    ApplyAnimation(playerid, "POLICE", "Door_Kick", 4.0, 0, 0, 0, 0, 0);
	    ApplyAnimation(playerid, "POLICE", "Door_Kick", 4.0, 0, 0, 0, 0, 0);
		SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s iþyerinin kapýsýna sert bir tekme atar ve kapý kýrýlýr.", ReturnName(playerid, 0));
		Isyeri[id][isyeriKilit] = 0;
		Isyeri_Yenile(id);
	}
	return 1;
}
CMD:admins(playerid)
{
    if (!OyundaDegil(playerid)) return 1;
    if (PlayerData[playerid][pAdmin] < 1) return HataMesajGonder(playerid, "Aktif yetkilileri görmeye yetkiniz yok.");
	new count = 0;
	SendClientMessage(playerid, COLOR_GREY, "-----------------------------------------------------------");
	foreach (new i : Player) if (PlayerData[i][pAdmin] > 0 || PlayerData[i][pOyunGorevlisi] > 0 || PlayerData[i][pForumGorevlisi] > 0)
	{
	    count++;
	    if (PlayerData[i][pAdminDuty])
	    {
	        SendClientMessageEx(playerid,COLOR_WHITE, "{808080}%s | %s | %s (Durum: {00FF00}•{808080})",ReturnName(playerid, 0),PlayerData[i][pAdminName],GetAdminRank(i));
	    }
	    else
	    {
	        SendClientMessageEx(playerid,COLOR_WHITE, "{808080}%s | %s | %s (Durum: {FF0000}•{808080})",ReturnName(playerid, 0),PlayerData[i][pAdminName],GetAdminRank(i));
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
        format(str, sizeof(str), "%s{BBFFEE}(Lv. %d) Helper %s (Durum: %s)\n", str, PlayerData[i][pHelper], PlayerData[i][pAdminName], (PlayerData[i][pHelperDuty] == 1) ? ("{00FF00}•{808080}") : ("{FF0000}•{808080}"));

    }
    if (count == 0) return HataMesajGonder(playerid, "Aktif helper yok.");
    Dialog_Show(playerid, Helpers, DIALOG_STYLE_MSGBOX, "Helperler", str, "Kapat", "");
	return 1;
}
CMD:15dk(playerid, params[])
{
if(PlayerData[playerid][pAdmin] > 5) return HataMesajGonder(playerid, "Yeterli yetkiniz yok.");
	ilkarabalars = 1;
	MesajGonder(playerid, "Ýlk 15 dakika aktif edildi.");
	foreach (new i : Player)
	{
	    SendClientMessageEx(i, 0x38AF9111, "|{C8C8C8} Sunucu yeni açýldý, ilk 15 dakika içerisinde aracýnýzý yanýnýza getirebilirsiniz.");
	}
return 1;
}

CMD:15dkkapa(playerid, params[])
{
if(PlayerData[playerid][pAdmin] > 5) return HataMesajGonder(playerid, "Yeterli yetkiniz yok.");
	ilkarabalars = 0;
	MesajGonder(playerid, "Sunucu yeni açýldý deaktif.");
	foreach (new i : Player)
	{
	    SendClientMessageEx(i, 0x38AF9111, "|{C8C8C8} 15 dakika doldu, artýk araçlarýnýzý bulmak zorundasýnýz.");
	}
return 1;
}
CMD:aracolustur(playerid,params[])
{
	new model,color1,color2,tip,id = -1, idx;
	if (PlayerData[playerid][pAdmin] < 3) return HataMesajGonder(playerid, "Bu komutu kullanmak için yetkiniz yok");
	if (sscanf(params, "iiiii",model,color1,color2,tip,idx))
	{
	    KullanimMesajGonder(playerid, "/aracolustur [Model ID] [Renk 1] [Renk 2] [Tip] [Faction ID/Kira Ucret/Fiyat]");
	    SendClientMessage(playerid,-1, "{00FF15}[TIP]: {FFFFFF}1: Birlik Aracý 2: Meslek Aracý 3: Kiralýk 4: Normal Araç 5: VIP Aracý 6: Ehliyet");
	    return 1;
 	}
 	if (!IsValidVehicleModel(model)) return HataMesajGonder(playerid, "Hatalý Model ID");
 	if (tip < 1 || tip > 6) return HataMesajGonder(playerid, "Tip 1 ile 6 arasýnda olmalýdýr.");

    static
    	Float:x,
		Float:y,
		Float:z,
		Float:angle;

    GetPlayerPos(playerid, x, y, z);
	GetPlayerFacingAngle(playerid, angle);

	id = Arac_Olustur(-1,model,GetPlayerInterior(playerid), GetPlayerVirtualWorld(playerid), Garage_Inside(playerid), x,y,z,angle,color1,color2,tip,idx);

	if (id == -1)
		return HataMesajGonder(playerid, "Sunucu maksimum araç sayýsýna ulaþmýþtýr.");

	AracInfo[id][aracDisplay] = true;

	SetVehicleVirtualWorld(AracInfo[id][aracVehicle], GetPlayerVirtualWorld(playerid));
	SetPlayerPos(playerid, x, y, z+2);

	MesajGonder(playerid, "Araç oluþturuldu, ID: %d.", AracInfo[id][aracVehicle]);
	return 1;
}

CMD:aracsil(playerid,params[])
{
	new id = 0;
	if (PlayerData[playerid][pAdmin] < 3) return HataMesajGonder(playerid, "Bu komutu kullanmak için yetkiniz yok");
	if (sscanf(params, "d", id))
 	{
	 	if (IsPlayerInAnyVehicle(playerid))
		 	id = GetPlayerVehicleID(playerid);

		else return KullanimMesajGonder(playerid, "/aracsil [Araç ID]");
	}
	if (!IsValidVehicle(id) || Car_GetID(id) == -1) return HataMesajGonder(playerid, "Hatalý Araç ID.");
	Arac_Sil(Car_GetID(id));
	MesajGonder(playerid, "Araç silindi, ID: %d.", id);
	return 1;
}
CMD:gateolustur(playerid)
{
	static id = -1;
	if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Bu komutu kullanmak için yetkiniz yok");
	new
	    Float:x,
	    Float:y,
	    Float:z,
	    Float:angle;
	  GetPlayerPos(playerid,x,y,z);
	  GetPlayerFacingAngle(playerid,angle);
	id = Gate_Create(x,y,z,angle,GetPlayerInterior(playerid),GetPlayerVirtualWorld(playerid));
	if (id == -1) return HataMesajGonder(playerid, "Sunucu maksimum gate limitine ulaþtý.");
	MesajGonder(playerid, "ID: %d | Gate oluþturuldu gate düzenlemek için (/gateduzenle [id] [parametre])",id);
	return 1;
}

CMD:gateduzenle(playerid, params[])
{
	static
	    id,
	    type[24],
	    string[128];

	if (PlayerData[playerid][pAdmin] < 4)
	    return HataMesajGonder(playerid, "Bu komutu kullanmak için yetkiniz yok");

	if (sscanf(params, "ds[24]S()[128]", id, type, string))
 	{
	 	KullanimMesajGonder(playerid, "/gateduzenle [ID] [Ýsim]");
	    SendClientMessage(playerid, COLOR_PINK, "[PARAMETRELER]:{FFFFFF} bolge, model, pos, hareket, speed, radius, zaman, sifre, linkid, faction, sahip, world, vip");
		return 1;
	}

	if ((id < 0 || id >= MAX_GATES) || !GateData[id][gateExists])
	    return HataMesajGonder(playerid, "Hatalý Gate ID girdiniz.");

	if (!strcmp(type, "vip", true))
	{
		static vipSeviyesi;

		if (sscanf(string, "d", vipSeviyesi))
		    return KullanimMesajGonder(playerid, "/gateduzenle [ID] [vip] [VIP Seviyesi]");

		if (vipSeviyesi < 0 || vipSeviyesi > 3)
		    return HataMesajGonder(playerid, "VIP Seviyesi minimum 0, maksimum 3 olmalýdýr.");

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
		    return KullanimMesajGonder(playerid, "/gateduzenle [ID] [hiz] [Hýz]");

		if (speed < 0.0 || speed > 20.0)
		    return HataMesajGonder(playerid, "Hýz 0 ile 20 arasýnda olmalýdýr.");

        GateData[id][gateSpeed] = speed;

		Gate_Save(id);
		return 1;
	}
 	else if (!strcmp(type, "sahip", true))
	{
	    static
	        sahip = -1;

		if (sscanf(string, "d", sahip))
		    return KullanimMesajGonder(playerid, "/gateduzenle [ID] [sahip] [sql id] (-1 kapatýr)");


        GateData[id][gateOwner] = sahip;
		Gate_Save(id);
        AdminMessage(COLOR_RED, "*** %s adlý yetkili tarafýndan %d ID'li gatenin sahibi SQL id %d olarak ayarlandý.", PlayerData[playerid][pAdminName], id, sahip);
		return 1;
	}
	else if (!strcmp(type, "radius", true))
	{
	    static
	        Float:radius;

		if (sscanf(string, "f", radius))
		    return KullanimMesajGonder(playerid, "/gateduzenle [ID] [radius] [Radius]");

		if (radius < 0.0 || radius > 20.0)
		    return HataMesajGonder(playerid, "Radius 0 ile 20 arasýnda olmalýdýr.");

        GateData[id][gateRadius] = radius;

		Gate_Save(id);
		return 1;
	}
	else if (!strcmp(type, "zaman", true))
	{
	    static
	        time;

		if (sscanf(string, "d", time))
		    return KullanimMesajGonder(playerid, "/gateduzenle [ID] [zaman] [Zaman] (0 kapatýr)");

		if (time < 0 || time > 60000)
		    return HataMesajGonder(playerid, "0 ile 60,000 ms arasýnda olmalýdýr.");

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
		    return HataMesajGonder(playerid, "Hatalý Obje ID.");

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
		BilgiMesajGonder(playerid, "%d ID'li gatenin pozisyonunu deðiþtiriyorsunuz.", id);
		return 1;
	}
	else if (!strcmp(type, "hareket", true))
	{
	   	EditDynamicObject(playerid, GateData[id][gateObject]);

		PlayerData[playerid][pEditGate] = id;
		PlayerData[playerid][pEditType] = 2;

		BilgiMesajGonder(playerid, "%d ID'li gatenin açýlýþ pozisyonunu deðiþtiriyorsunuz.", id);
		return 1;
	}
	else if (!strcmp(type, "linkid", true))
	{
	    static
	        linkid = -1;

		if (sscanf(string, "d", linkid))
		    return KullanimMesajGonder(playerid, "/gateduzenle [id] [linkid] [gate link] (-1 kapatýr)");

        if ((linkid < -1 || linkid >= MAX_GATES) || (linkid != -1 && !GateData[linkid][gateExists]))
	    	return HataMesajGonder(playerid, "Hatalý gate id.");

        GateData[id][gateLinkID] = (linkid == -1) ? (-1) : (GateData[linkid][gateID]);
		Gate_Save(id);

		return 1;
	}
	else if (!strcmp(type, "faction", true))
	{
	    static
	        factionid = -1;

		if (sscanf(string, "d", factionid))
		    return KullanimMesajGonder(playerid, "/gateduzenle [ID] [faction] [gate faction] (-1 kapatýr)");


        GateData[id][gateFaction] = factionid;
		Gate_Save(id);

		return 1;
	}
	else if (!strcmp(type, "sifre", true))
	{
	    static
	        pass[32];

		if (sscanf(string, "s[32]", pass))
		    return KullanimMesajGonder(playerid, "/gateduzenle [ID] [sifre] [gate þifre] ( 'yok' gate'yi þifresiz yapar)");

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
	    return HataMesajGonder(playerid, "Bu komutu kullanmak için yetkiniz yok");

	if (sscanf(params, "d", id))
	    return KullanimMesajGonder(playerid, "/gatesil [Gate ID]");

	if ((id < 0 || id >= MAX_GATES) || !GateData[id][gateExists])
	    return HataMesajGonder(playerid, "Hatalý gate ID girdiniz.");

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
	if (!(0 <= interiorid <= sizeof(GarageInteriors)-1)) return HataMesajGonder(playerid, "Geçersiz Interior ID girdiniz.");
	new Float:pos[3];
	GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
	new id = Garaj_Olustur(tip, interiorid, pos[0], pos[1], pos[2], GetPlayerVirtualWorld(playerid));
	if (id == -1) return HataMesajGonder(playerid, "Sunucu maksimum garaj limitine ulaþtý.");
	MesajGonder(playerid, "Garaj oluþturuldu, (/garajduzenle) komutu ile garajý düzenleyebilirsiniz. (ID: %d)", id);
	return 1;
}
CMD:garajsil(playerid, params[])
{
    if (PlayerData[playerid][pAdmin] < 4)
	    return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
	new id;
	if (sscanf(params, "i", id)) return KullanimMesajGonder(playerid, "/garajsil [ID]");
	if ((id < 0 || id >= MAX_GARAGE) || !GarageData[id][gExists])
	    return HataMesajGonder(playerid, "Hatalý garaj ID girdiniz.");

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
	    return HataMesajGonder(playerid, "Bu komutu kullanmak için yetkiniz yok");

	if (sscanf(params, "ds[24]S()[128]", id, type, string))
 	{
	 	KullanimMesajGonder(playerid, "/garajduzenle [ID] [Ýsim]");
	    SendClientMessage(playerid, COLOR_PINK, "[PARAMETRELER]:{FFFFFF} kilit, sifre, birlik, sahip, pos, interior, tip, araclimit");
		return 1;
	}
	if ((id < 0 || id >= MAX_GARAGE) || !GarageData[id][gExists])
	    return HataMesajGonder(playerid, "Hatalý Garaj ID girdiniz.");

	if (!strcmp(type, "kilit", true))
	{
	    if (GarageData[id][gKilit] == 1)
	    {
	        GarageData[id][gKilit] = 0;
	        //MesajGonder(playerid, "Garajýn kilidi açýldý.");
	        AdminMessage(COLOR_RED, "*** %s adlý yetkili tarafýndan Garaj ID %d kilidi açýldý.", PlayerData[playerid][pAdminName], id);
	    }
	    else
	    {
	        GarageData[id][gKilit] = 1;
	        //MesajGonder(playerid, "Garaj kilitlendi.");
	        AdminMessage(COLOR_RED, "*** %s adlý yetkili tarafýndan Garaj ID %d kilitlendi.", PlayerData[playerid][pAdminName], id);
	    }
	    Garaj_Kaydet(id);
	    Garaj_Yenile(id);
	}
 	else if (!strcmp(type, "sifre", true))
	{
	    static
	        pass[32];

		if (sscanf(string, "s[32]", pass))
		    return KullanimMesajGonder(playerid, "/garajduzenle [ID] [sifre] [garaj þifre] ( 'yok' yazarsanýz þifresiz yapar)");

		format(GarageData[id][gSifre], 30, pass);

        AdminMessage(COLOR_RED, "*** %s adlý yetkili tarafýndan Garaj ID %d þifresi deðiþtirildi.", PlayerData[playerid][pAdminName], id);
		Garaj_Kaydet(id);
		return 1;
	}
	else if (!strcmp(type, "birlik", true))
	{
	    static
	        factionid = -1;

		if (sscanf(string, "d", factionid))
		    return KullanimMesajGonder(playerid, "/garajduzenle [ID] [birlik] [birlik id] (-1 kapatýr)");

        AdminMessage(COLOR_RED, "*** %s adlý yetkili tarafýndan %d ID'li garajýn birliði %d ID'li birlik olarak ayarlandý.", PlayerData[playerid][pAdminName], id, factionid);
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
		    return KullanimMesajGonder(playerid, "/garajduzenle [ID] [sahip] [sql id] (-1 kapatýr)");


        GarageData[id][gSahip] = sahip;
        Garaj_Yenile(id);
		Garaj_Kaydet(id);
        AdminMessage(COLOR_RED, "*** %s adlý yetkili tarafýndan %d ID'li garajýn sahibi SQL id %d olarak ayarlandý.", PlayerData[playerid][pAdminName], id, sahip);
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
	 	AdminMessage(COLOR_RED, "*** %s adlý yetkili tarafýndan %d ID'li garajýn pozisyonu deðiþtirildi.", PlayerData[playerid][pAdminName], id);
	}
	else if (!strcmp(type, "interior", true))
	{
	    static
	        interior;

		if (sscanf(string, "d", interior))
		    return KullanimMesajGonder(playerid, "/garajduzenle [ID] [interior] [Interior ID]");


        GarageData[id][gInterior] = interior;
		Garaj_Kaydet(id);
        AdminMessage(COLOR_RED, "*** %s adlý yetkili tarafýndan %d ID'li garajýn interioru %d olarak deðiþtirildi.", PlayerData[playerid][pAdminName], id, interior);
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
        AdminMessage(COLOR_RED, " %s adlý yetkili tarafýndan %d ID'li garajýn tipi %s olarak deðiþtirildi.", PlayerData[playerid][pAdminName], id, tip);
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
        AdminMessage(COLOR_RED, " %s adlý yetkili tarafýndan %d ID'li garajýn araç limiti %d olarak deðiþtirildi.", PlayerData[playerid][pAdminName], id, limit);
		return 1;
	}
	return 1;
}

CMD:evolustur(playerid,params[])
{
	new fiyat, intid, mobilyasayisi;
	if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Bu komutu kullanmak için yetkiniz yok");
	if (sscanf(params, "iii",fiyat,intid, mobilyasayisi)) return KullanimMesajGonder(playerid, "/evolustur [Fiyat] [Interior ID] [Maks. Mobilya]");
	if (!(0 <= intid <= sizeof(HouseInteriors)-1)) return HataMesajGonder(playerid, "Yazdýðýnýz ID'de bir interior bulunmamaktadýr.");
	new id = -1;
	new Float:pos[3];
	GetPlayerPos(playerid,pos[0],pos[1],pos[2]);
	id = Ev_Olustur(pos[0],pos[1],pos[2],fiyat, intid, mobilyasayisi);
	if (id == -1) return HataMesajGonder(playerid, "Sunucu maksimum ev limitine ulaþtý.");
	MesajGonder(playerid, "Ev oluþturuldu, ID: %d",id);
	return 1;
}

CMD:evsil(playerid,params[])
{
	new id = 0;
	if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Bu komutu kullanmak için yetkiniz yok");
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

	if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Bu komutu kullanmak için yetkiniz yok");
	if (sscanf(params, "ds[32]S()", type, name, str))
	{
	    KullanimMesajGonder(playerid, "/birlikolustur [Tip] [Parametre]");
     	SendClientMessage(playerid, COLOR_PINK, "[TIP]:{FFFFFF}1: Yarýþ/Çete 2: Mafya 3: Yayýn Ajansý 4: Legal 5: LSPD 6: LSMD 7: FBI 8: GOV");
   		return 1;
	}
	if (type < 1 || type > 8) return HataMesajGonder(playerid, "Tip 1 ile 8 arasýnda olmalýdýr.");
	id = Birlik_Olustur(name, type);

	if (id == -1) return HataMesajGonder(playerid, "Sunucu maksimum birlik sayýsýna ulaþmýþtýr.");
	BilgiMesajGonder(playerid, "Birlik oluþturuldu, ID: %d",id);
	return 1;
}

CMD:birliksil(playerid, params[])
{
	static
	    id = 0;

    if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Bu komutu kullanmak için yetkiniz yok");

	if (sscanf(params, "d", id)) return KullanimMesajGonder(playerid, "/birliksil [Birlik ID]");

	if ((id < 0 || id >= MAX_BIRLIK) || !Birlikler[id][birlikExists])
	    return HataMesajGonder(playerid, "Geçersiz ID.");

	Birlik_Sil(id);
	MesajGonder(playerid, "Birlik ID %d silindi.", id);
	return 1;
}
CMD:birlikduzenle(playerid,params[])
{
    new id, type[24],string[128];
    if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Bu komutu kullanmak için yetkiniz yok");
    if (sscanf(params, "ds[24]S()[128]", id, type, string))
    {
        KullanimMesajGonder(playerid, "/birlikduzenle [ID] [Seçenek]");
       	SendClientMessage(playerid, COLOR_PINK, "[SEÇENEK]: {FFFFFF}isim, renk, tip, rutbe, maxrutbe, sistemselonay, silahonay, uyusturucuonay, graffitionay, hoodonay");
        return 1;
    }
    if ((id < 0 || id >= MAX_BIRLIK) || !Birlikler[id][birlikExists]) return HataMesajGonder(playerid, "Hatalý Birlik ID.");
    if (!strcmp(type, "isim", true))
    {
        new isim[32];
        if (sscanf(string, "s[32]", isim)) return KullanimMesajGonder(playerid, "/birlikduzenle [ID] [isim] [Yeni Isim]");
        format(Birlikler[id][birlikAd], 32, isim);
        Birlik_Kaydet(id);
        AdminMessage(COLOR_RED, " %s adlý yetkili tarafýndan %d ID'li birliðin ismi %s olarak deðiþtirildi.",ReturnName(playerid,0),id,isim);
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
		AdminMessage(COLOR_RED, " %s tarafýndan %d ID'li birliðin {%06x}rengi {AA3333}deðiþtirildi.", ReturnName(playerid, 0), id, color >>> 8);
	}
	else if (!strcmp(type, "tip", true))
	{
	    new typeint;
	    if (sscanf(string, "d", typeint))
	    {
	        KullanimMesajGonder(playerid, "/birlikduzenle [ID] [tip] [Tip]");
	        SendClientMessage(playerid, COLOR_PINK, "[TIP]:{FFFFFF}1: Yarýþ/Çete 2: Mafya 3: Yayýn Ajansý 4: Legal 5: LSPD 6: LSMD 7: FBI 8: GOV");
	        return 1;
	    }
	    if (typeint < 1 || typeint > 8) return HataMesajGonder(playerid, "Tip 1 ile 8 arasýnda olmalýdýr.");

	    Birlikler[id][birlikTip] = typeint;
	    Birlik_Kaydet(id);
	    AdminMessage(COLOR_RED, " %s adlý yetkili %d ID'li birliðin tipini deðiþtirdi.",ReturnName(playerid, 0), id);
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
		    return HataMesajGonder(playerid, "Rütbe 1'den küçük, 20'den büyük olamaz.");

	    Birlikler[id][birlikRutbeler] = ranks;

	    Birlik_Kaydet(id);
	}
	else if (!strcmp(type, "sistemselonay", true))
	{
	    if (Birlikler[id][birlikOnaylar][0])
	    {
	        Birlikler[id][birlikOnaylar][0] = 0;
			BilgiMesajGonder(playerid, "%s (ID: %d) adlý birliðin sistemsel onayýný sildiniz.", Birlikler[id][birlikAd], id);
			AdminMessage(COLOR_RED, " %s, %s (ID: %d) birliðinin sistemsel onayýný sildi.",PlayerData[playerid][pAdminName], Birlikler[id][birlikAd], id);
	    }
		else
		{
		    Birlikler[id][birlikOnaylar][0] = 1;
		    BilgiMesajGonder(playerid, "%s (ID: %d) adlý birliðe sistemsel onay verdiniz.", Birlikler[id][birlikAd], id);
		    AdminMessage(COLOR_RED, " %s, %s (ID: %d) birliðine sistemsel onay verdi.",PlayerData[playerid][pAdminName], Birlikler[id][birlikAd], id);
		}

	    Birlik_Kaydet(id);
	}
	else if (!strcmp(type, "silahonay", true))
	{
	    if (Birlikler[id][birlikOnaylar][1])
	    {
	        Birlikler[id][birlikOnaylar][1] = 0;
			BilgiMesajGonder(playerid, "%s (ID: %d) adlý birliðin silah onayýný sildiniz.", Birlikler[id][birlikAd], id);
			AdminMessage(COLOR_RED, " %s, %s (ID: %d) birliðinin silah onayýný sildi.",PlayerData[playerid][pAdminName], Birlikler[id][birlikAd], id);
	    }
		else
		{
		    Birlikler[id][birlikOnaylar][1] = 1;
		    BilgiMesajGonder(playerid, "%s (ID: %d) adlý birliðe silah onayý verdiniz.", Birlikler[id][birlikAd], id);
		    AdminMessage(COLOR_RED, " %s, %s (ID: %d) birliðine silah onayý verdi.",PlayerData[playerid][pAdminName], Birlikler[id][birlikAd], id);
		}

	    Birlik_Kaydet(id);
	}
	else if (!strcmp(type, "uyusturucuonay", true))
	{
	    if (Birlikler[id][birlikOnaylar][2])
	    {
	        Birlikler[id][birlikOnaylar][2] = 0;
			BilgiMesajGonder(playerid, "%s (ID: %d) adlý birliðin uyuþturucu onayýný sildiniz.", Birlikler[id][birlikAd], id);
			AdminMessage(COLOR_RED, " %s, %s (ID: %d) birliðinin uyuþturucu onayýný sildi.",PlayerData[playerid][pAdminName], Birlikler[id][birlikAd], id);
	    }
		else
		{
		    Birlikler[id][birlikOnaylar][2] = 1;
		    BilgiMesajGonder(playerid, "%s (ID: %d) adlý birliðe uyuþturucu onayý verdiniz.", Birlikler[id][birlikAd], id);
		    AdminMessage(COLOR_RED, " %s, %s (ID: %d) birliðine uyuþturucu onayý verdi.",PlayerData[playerid][pAdminName], Birlikler[id][birlikAd], id);
		}

	    Birlik_Kaydet(id);
	}
	else if (!strcmp(type, "graffitionay", true))
	{
	    if (Birlikler[id][birlikOnaylar][3])
	    {
	        Birlikler[id][birlikOnaylar][3] = 0;
			BilgiMesajGonder(playerid, "%s (ID: %d) adlý birliðin graffiti onayýný sildiniz.", Birlikler[id][birlikAd], id);
			AdminMessage(COLOR_RED, " %s, %s (ID: %d) birliðinin graffiti onayýný sildi.",PlayerData[playerid][pAdminName], Birlikler[id][birlikAd], id);
	    }
		else
		{
		    Birlikler[id][birlikOnaylar][3] = 1;
		    BilgiMesajGonder(playerid, "%s (ID: %d) adlý birliðe graffiti onayý verdiniz.", Birlikler[id][birlikAd], id);
		    AdminMessage(COLOR_RED, " %s, %s (ID: %d) birliðine graffiti onayý verdi.",PlayerData[playerid][pAdminName], Birlikler[id][birlikAd], id);
		}

	    Birlik_Kaydet(id);
	}
	else if (!strcmp(type, "hoodonay", true))
	{
	    if (Birlikler[id][birlikOnaylar][4])
	    {
	        Birlikler[id][birlikOnaylar][4] = 0;
			BilgiMesajGonder(playerid, "%s (ID: %d) adlý birliðin Hood onayýný sildiniz.", Birlikler[id][birlikAd], id);
			AdminMessage(COLOR_RED, " %s, %s (ID: %d) birliðinin Hood onayýný sildi.",PlayerData[playerid][pAdminName], Birlikler[id][birlikAd], id);
	    }
		else
		{
		    Birlikler[id][birlikOnaylar][4] = 1;
		    BilgiMesajGonder(playerid, "%s (ID: %d) adlý birliðe Hood onayý verdiniz.", Birlikler[id][birlikAd], id);
		    AdminMessage(COLOR_RED, " %s, %s (ID: %d) birliðine Hood onayý verdi.",PlayerData[playerid][pAdminName], Birlikler[id][birlikAd], id);
		}

	    Birlik_Kaydet(id);
	}
	return 1;
}
CMD:setleader(playerid,params[])
{
	new pid,id;
	if (PlayerData[playerid][pAdmin] < 3) return HataMesajGonder(playerid, "Bu komutu kullanamazsýn.");
	if (sscanf(params, "ui",pid,id)) return KullanimMesajGonder(playerid, "/setleader [ID/Isim] [Birlik ID] (-1 yazarsan liderlikten atýlýr)");
	if (!OyundaDegil(pid)) return HataMesajGonder(playerid, "Oyuncu oyunda deðil!");
	if ((id < -1 || id >= MAX_BIRLIK) || (id != -1 && !Birlikler[id][birlikExists])) return HataMesajGonder(playerid, "Hatalý Birlik ID.");
	if (id == -1)
	{
	    BirliktenAt(pid);
	    BilgiMesajGonder(playerid, "%s adlý oyuncuyu birlik liderliðinden attýnýz.", ReturnName(pid, 0));
    	BilgiMesajGonder(pid, "%s adlý yetkili sizi birlik liderliðinden attý.", ReturnName(playerid, 0));
    	Oyuncu_Kaydet(id);
	}
	else
	{
	    BirliktenAt(pid);
	    PlayerData[pid][pFaction] = id;
	    PlayerData[pid][pFactionRutbe] = Birlikler[id][birlikRutbeler];
	    PlayerData[pid][pFactionDivizyon] = 0;
	    BilgiMesajGonder(playerid, "%s adlý oyuncuyu \"%s\" adlý birliðin lideri yaptýnýz.", ReturnName(pid, 0),Birlikler[id][birlikAd]);
	    BilgiMesajGonder(pid, "%s adlý yetkili seni \"%s\" adlý birliðin lideri yaptý.", ReturnName(playerid, 0),Birlikler[id][birlikAd]);
	    Oyuncu_Kaydet(pid);
	}
	return 1;
}

CMD:isyeriolustur(playerid,params[])
{
	new tip,fiyat;
	if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Bu komutu kullanmak için yetkiniz yok");
	if (sscanf(params, "dd", tip, fiyat))
	{
		KullanimMesajGonder(playerid, "/isyeriolustur [Tip] [Fiyat]");
		SendClientMessage(playerid,-1, "{00FF15}[TIP]: {FFFFFF} 1: Market 2: Kiyafet Maðazasý 3: Fast Food 4: Galeri 5: Elektronik 6: Bar/Pub 7: Kumarhane 8: Diðer");
		return 1;
	}
	if (tip < 1 || tip > 8) return HataMesajGonder(playerid, "Geçersiz iþyeri tipi. 1 ile 8 arasýnda olmalýdýr.");

	new id;
	id = Isyeri_Olustur(playerid, tip, fiyat);

	if (id == -1)
		return HataMesajGonder(playerid, "Sunucu iþyeri sýnýrýna ulaþtý.");

	BilgiMesajGonder(playerid, "Ýþyeri oluþturuldu, ID: %d",id);
	return 1;
}

CMD:benzinlerifulle(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] >= 4) {

    for(new i=0;i<MAX_ARAC;i++) {
        AracInfo[i][aracBenzin] = 100;
    }

    new string[128];

    format(string, sizeof(string), "ADM: %s %s, tüm araçlarýn benzinini doldurdu.", GetAdminRank(playerid), PlayerData[playerid][pAdminName]);
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
	    return HataMesajGonder(playerid, "Bu komutu kullanamazsýn !");

	if (sscanf(params, "d", id))
	    return KullanimMesajGonder(playerid, "/isyerisil [Ýþyeri ID]");

	if ((id < 0 || id >= MAX_ISYERI) || !Isyeri[id][isyeriExists])
	    return HataMesajGonder(playerid, "Geçersiz iþyeri ID'sý.");

	Isyeri_Sil(id);
	BilgiMesajGonder(playerid, "Ýþyeri silindi, ID: %d.", id);
	return 1;
}
CMD:isyeriduzenle(playerid,params[])
{
	static id, type[24], string[128];
	if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Bu komutu kullanamazsýn !");
	if (sscanf(params, "ds[24]S()[128]", id, type, string))
 	{
	 	KullanimMesajGonder(playerid, "/isyeriduzenle [ID] [Ad]");
	    SendClientMessage(playerid, COLOR_PINK, "{00FF15}[ADLAR]: {FFFFFF} pozisyon, interior, fiyat, stok, tip, spawn, devlet");
		return 1;
	}
	if ((id < 0 || id >= MAX_ISYERI) || !Isyeri[id][isyeriExists])
	    return HataMesajGonder(playerid, "Geçersiz iþyeri ID'sý.");

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
		BilgiMesajGonder(playerid, "%d ID'li iþyerinin interioru þu an bulunduðunuz interior (ID: %d) olarak deðiþtirildi.",id,GetPlayerInterior(playerid));
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

		BilgiMesajGonder(playerid, "%d ID'li iþyerinin fiyatý {2ECC71}%s {FFFFFF}olarak deðiþtirildi.",id,FormatNumber(price));
	}
	else if (!strcmp(type, "stok", true))
	{
	    new urunid,amount;

	    if (sscanf(string, "dd",urunid,amount))
	        return KullanimMesajGonder(playerid, "/isyeriduzenle [ID] [stok] [Ürün ID] [Ürün Sayýsý]");

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
			SendClientMessage(playerid,-1, "{00FF15}[TIP]: {FFFFFF} 1: Market 2: Kiyafet Maðazasý 3: Fast Food 4: Galeri 5: Elektronik 6: Bar/Pub 7: Kumarhane");
			return 1;
	    }
	    if (typeint < 1 || typeint > 9)
			return HataMesajGonder(playerid, "Belirtilen tip 1 ve 7 arasýnda olmalýdýr.");

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
    		case 2: // Kiyafet Maðazasý
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
	        return HataMesajGonder(playerid, "Bu iþyeri tipi araç galerisi deðil!");

	    if (GetPlayerInterior(playerid) > 0 || GetPlayerVirtualWorld(playerid) > 0)
	        return HataMesajGonder(playerid, "Araç spawn noktasý sadece dýþarýda olabilir.");

	    GetPlayerPos(playerid, Isyeri[id][isyeriSpawn][0], Isyeri[id][isyeriSpawn][1], Isyeri[id][isyeriSpawn][2]);
		GetPlayerFacingAngle(playerid, Isyeri[id][isyeriSpawn][3]);

		Isyeri_Kaydet(id);
		BilgiMesajGonder(playerid, "%d ID'li iþyerinin araç spawn noktasý ayarlandý.",id);
	}
	else if (!strcmp(type, "devlet", true))
	{
	    if (Isyeri[id][isyeriSahip] == -99)
	    {
	        Isyeri[id][isyeriSahip] = -1;
	        Isyeri_Yenile(id);
	        Isyeri_Kaydet(id);
	        BilgiMesajGonder(playerid, "Ýþyeri artýk devletin deðil.");
	    }
	    else
		{
		    Isyeri[id][isyeriSahip] = -99;
		    Isyeri_Yenile(id);
	        Isyeri_Kaydet(id);
	        BilgiMesajGonder(playerid, "Ýþyeri artýk devletin.");
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
		return HataMesajGonder(playerid, "Obje oluþturulurken bir hata oluþtu, lütfen geliþtirici ile iletiþime geçiniz.");

	if (id != -1)
		BilgiMesajGonder(playerid, "Lütfen objenin pozisyonunu ayarlayýnýz.");

	return 1;
}
CMD:objekaldir(playerid, params[])
{
	if (PlayerData[playerid][pAdmin] < 4)
	    return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

	SetPVarInt(playerid, "ObjeKaldirma", 1);
	SelectObject(playerid);

	MesajGonder(playerid, "Lütfen kaldýrmak istediðiniz objeyi seçiniz.");
	return 1;
}

CMD:giseolustur(playerid, params[])
{
	new id = -1;

	if (PlayerData[playerid][pAdmin] < 4)
	    return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

	id = Gise_Olustur(playerid);

	if (id != -1)
	    BilgiMesajGonder(playerid, "ID: %d Giþe oluþturuldu.", id);

	if (id == -1)
	    BilgiMesajGonder(playerid, "Giþe oluþturulurken hata oluþtu, geliþtiriciye ulaþýn.");


	return 1;
}

CMD:gisesil(playerid, params[])
{
	new id, query[512];

	if (PlayerData[playerid][pAdmin] < 4)
	    return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

	if (sscanf(params, "d", id))
	    return KullanimMesajGonder(playerid, "/gisesil [Giþe ID]");

	if (!Gise[id][gs_Exists])
		return HataMesajGonder(playerid, "Giþe mevcut deðil.");

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

	BilgiMesajGonder(playerid, "ID: %d giþe baþarýyla silindi.", id);
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
	    return HataMesajGonder(playerid, "Sunucu maksimum hapis noktasýna ulaþtý.");

	MesajGonder(playerid, "Hapis noktasý oluþturuldu, ID: %d.", id);
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
	    return HataMesajGonder(playerid, "Hatalý ID girdiniz.");

	Arrest_Delete(id);
	MesajGonder(playerid, "Hapis noktasý silindi, ID: %d.", id);
	return 1;
}
CMD:createcctv(playerid, params[])
{
    if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Bu komuta yetkin yok!"); //ADMIN LEVEL HERE
    new
        name[30];
    if (sscanf(params, "s[30]", name)) return KullanimMesajGonder(playerid, "/createcctv [Ad]");
    new id = CreateCCTV(playerid, name);
    if (id == -1) return HataMesajGonder(playerid, "Daha fazla CCTV yaratamazsýn!");
    MesajGonder(playerid, "CCTV oluþturuldu, (/editcctv) komutu ile düzenleyebilirsiniz. (ID: %d)", id);
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
    if (sscanf(params, "ii", tip, deger)) return KullanimMesajGonder(playerid, "/setbitcoin [1 - Alma 2 - Satma] [Deðer]");
    if (tip <=0 || tip >= 3) return HataMesajGonder(playerid, "1 - Alma 2- Satma");
    switch (tip)
    {
        case 1:
        {
            SetServerBilgi("BitcoinAlma", deger);
            MesajGonder(playerid, "Bitcoin alma fiyatý %s olarak deðiþtirildi.", FormatNumber(deger));
        }
        case 2:
		{
		    SetServerBilgi("BitcoinSatma", deger);
		    MesajGonder(playerid, "Bitcoin satma fiyatý %s olarak deðiþtirildi.", FormatNumber(deger));
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
    if (strlen(name) > 30) return HataMesajGonder(playerid, "Lokasyon Adý 30 karakteri geçemez.");
    new Float:pos[3];
    GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
    new id = Lokasyon_Ekle(name, pos[0], pos[1], pos[2]);
    if (id == -1) return HataMesajGonder(playerid, "Sunucu maksimum lokasyon limitine ulaþtý.");
    else MesajGonder(playerid, "Lokasyon eklendi, ID: %d", id);
	return 1;
}
CMD:lokasyonsil(playerid, params[])
{
	new id;
    if (!OyundaDegil(playerid)) return 1;
    if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
    if (sscanf(params, "i", id)) return KullanimMesajGonder(playerid, "/lokasyonsil [ID]");
    if ((id < 0 || id >= MAX_LOKASYON) || !Lokasyon[id][Exists]) return HataMesajGonder(playerid, "Hatalý ID.");
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

		MesajGonder(playerid, "%s adlý kiþinin müzik kutusunu kaldýrdýn.", ReturnName(i, 0));
		return BilgiMesajGonder(i, "%s adlý yetkili tarafýndan müzik kutunuz kaldýrýldý.", ReturnName(playerid, 0));
	}
	HataMesajGonder(playerid, "Herhangi bir müzik kutusuna yakýn deðilsiniz!");
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
	    MesajGonder(playerid, "2x Balýk eventi aktif edildi.");

	    SendClientMessageToAllEx(COLOR_PINK, "2x Balýk eventi aktif edildi.");
	}
	else
	{
	    SetServerBilgi("2xBalik", 0);
	    MesajGonder(playerid, "2x Balýk eventi deaktif edildi.");

	    SendClientMessageToAllEx(COLOR_PINK, "2x Balýk eventi deaktif edildi.");
	}
	return 1;
}

CMD:aipcoz(playerid, params[])
{
	new id;
    if (PlayerData[playerid][pAdmin] < 1) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
    if (sscanf(params, "u", id)) return KullanimMesajGonder(playerid, "/aipcoz [ID/Isim]");
    if (!OyundaDegil(id)) return HataMesajGonder(playerid, "Oyuncu oyunda deðil.");
    if (GetPVarInt(id, "IpBaglandi") == 0) return HataMesajGonder(playerid, "Bu oyuncu baðlý deðil.");
    SetPVarInt(id, "IpBaglandi", 0);
    TogglePlayerControllable(id, true);
    SetPlayerSpecialAction(id, SPECIAL_ACTION_NONE);
    MesajGonder(id, "%s adlý yetkili tarafýndan ipleriniz çözüldü.", PlayerData[playerid][pAdminName]);
    MesajGonder(playerid, "%s adlý kiþinin iplerini çözdünüz.", ReturnName(id, 0));
	return 1;
}

CMD:akelepcecoz(playerid, params[])
{
    new userid;
    if (PlayerData[playerid][pAdmin] < 1) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
    if (sscanf(params, "u", userid)) return KullanimMesajGonder(playerid, "/akelepcecoz [ID/Isim]");
    if (!OyundaDegil(userid)) return HataMesajGonder(playerid, "Oyuncu oyunda deðil.");
    if (PlayerData[userid][pKelepce] == 0) return HataMesajGonder(playerid, "Bu oyuncu kelepçeli deðil.");
    PlayerData[userid][pKelepce] = 0;
    PlayerData[userid][pDragged] = 0;
	PlayerData[userid][pDraggedBy] = INVALID_PLAYER_ID;
	KillTimer(PlayerData[userid][pDragTimer]);
    SetPlayerCuffed(userid, false);
    TogglePlayerControllable(userid,true);
    MesajGonder(userid, "%s adlý yetkili tarafýndan kelepçeniz çýkarýldý.", PlayerData[playerid][pAdminName]);
    MesajGonder(playerid, "%s adlý kiþinin kelepçelerini çýkardýnýz.", ReturnName(userid, 0));
	return 1;
}

CMD:createdealer(playerid, params[])
{
	if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

	new skin;

	if (sscanf(params, "i", skin)) return KullanimMesajGonder(playerid, "/createdealer [skin id]");
	if (!(0 <= skin <= 311)) return HataMesajGonder(playerid, "Geçersiz Skin ID.");

	new id = Iter_Free(Dealers), query[512];
	if (id == -1)
		return HataMesajGonder(playerid, "Daha fazla uyuþturucu satýcýsý oluþturulamaz.");

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

	format(label, sizeof(label), "Uyuþturucu Satýcýsý (%d)\n\n{F1C40F}ALT {FFFFFF}tuþuna basarak etkileþime geçebilirsiniz.", id);

	DealerData[id][dealerLabel] = CreateDynamic3DTextLabel(label, 0xF1C40FFF, DealerData[id][dealerX], DealerData[id][dealerY], DealerData[id][dealerZ] + 0.25, 5.0, .testlos = 1);

	Iter_Add(Dealers, id);

	mysql_format(g_SQL, query, sizeof query, "INSERT INTO `uyusturucusaticilari` (`ID`, `Skin`, `Uyusturucu`, `Pos`, `VirtualWorld`) VALUES ('%d', '%d', '0', '%f|%f|%f|%f', '%d')", id, skin, DealerData[id][dealerX], DealerData[id][dealerY], DealerData[id][dealerZ], DealerData[id][dealerA], DealerData[id][dealerVw]);
	mysql_query (g_SQL, query);

	MesajGonder(playerid, "Uyuþturucu satýcýsý oluþturuldu, ID: %d.", id);
	SetPlayerPos(playerid, DealerData[id][dealerX] + (1.5 * floatsin(-DealerData[id][dealerA], degrees)), DealerData[id][dealerY] + (1.5 * floatcos(-DealerData[id][dealerA], degrees)), DealerData[id][dealerZ]);
	return 1;
}
CMD:setdealerskin(playerid, params[])
{
	if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
	if (isnull(params)) return KullanimMesajGonder(playerid, "/setdealerskin [dealer id] [skin id]");
	new id, skin;
	if (sscanf(params, "ii", id, skin)) return KullanimMesajGonder(playerid, "/setdealerskin [dealer id] [skin id]");
	if (!Iter_Contains(Dealers, id)) return HataMesajGonder(playerid, "Geçersiz ID.");
	if (!(0 <= skin <= 311)) return HataMesajGonder(playerid, "Geçersiz Skin ID.");

	DealerData[id][dealerSkin] = skin;
	DestroyActor(DealerData[id][dealerActorID]);
	DealerData[id][dealerActorID] = CreateActor(skin, DealerData[id][dealerX], DealerData[id][dealerY], DealerData[id][dealerZ], DealerData[id][dealerA]);
	SetActorInvulnerable(DealerData[id][dealerActorID], 1);
    SetActorVirtualWorld(DealerData[id][dealerActorID], DealerData[id][dealerVw]);

    UyusturucuSaticisi_Guncelle(id);

    MesajGonder(playerid, "Uyuþturucu satýcýsýnýn skini deðiþtirildi.");
	return 1;
}

CMD:setdealerpos(playerid, params[])
{
	if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
	new id;
	if (sscanf(params, "i", id)) return KullanimMesajGonder(playerid, "/setdealerpos [dealer id]");
	if (!Iter_Contains(Dealers, id)) return HataMesajGonder(playerid, "Geçersiz ID.");
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

	MesajGonder(playerid, "Uyuþturucu satýcýsýnýn pozisyonu deðiþtirildi.");
 	SetPlayerPos(playerid, DealerData[id][dealerX] + (1.5 * floatsin(-DealerData[id][dealerA], degrees)), DealerData[id][dealerY] + (1.5 * floatcos(-DealerData[id][dealerA], degrees)), DealerData[id][dealerZ]);
	return 1;
}

CMD:removedealer(playerid, params[])
{
	if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
	new id, query[256];

	if (sscanf(params, "i", id)) return HataMesajGonder(playerid, "/removedealer [dealer id]");
	if (!Iter_Contains(Dealers, id)) return HataMesajGonder(playerid, "Geçersiz ID.");

	DestroyActor(DealerData[id][dealerActorID]);
	DestroyDynamic3DTextLabel(DealerData[id][dealerLabel]);

	DealerData[id][dealerID] = -1;
	DealerData[id][dealerActorID] = -1;
	DealerData[id][dealerLabel] = Text3D: -1;
	Iter_Remove(Dealers, id);

	mysql_format(g_SQL, query, sizeof query, "DELETE FROM `uyusturucusaticilari` WHERE `ID` = '%d'", id);
	mysql_query (g_SQL, query);

    MesajGonder(playerid, "Uyuþturucu satýcýsý kaldýrýldý.");
	return 1;
}

CMD:revive(playerid, params[])
{
	new id;
    if (PlayerData[playerid][pAdmin] < 1 && PlayerData[playerid][pHelper] < 2 && !PlayerData[playerid][pOyunGorevlisi] && !PlayerData[playerid][pForumGorevlisi]) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
    if (sscanf(params, "u", id)) return KullanimMesajGonder(playerid, "/revive [ID/Isim]");
    if (!OyundaDegil(id)) return HataMesajGonder(playerid, "Oyuncu oyunda deðil.");
    if (PlayerData[id][pBaygin] == 0) return HataMesajGonder(playerid, "Oyuncu yaralý deðil.");
    if (IsPlayerDying(playerid)) return HataMesajGonder(playerid, "Biraz bekleyin.");
    ResetPlayerDamages(id);

    PlayerData[id][pBaygin] = 0;
    PlayerData[id][pBayginSure] = 0;

    PlayerData[id][pTopallama] = false;
    PlayerData[id][pTopallamaSayac] = 0;

    CanAyarla(id, 100);
    TogglePlayerControllable(id, true);
    ClearAnimations(id);
    MesajGonder(playerid, "%s adlý kiþiyi canlandýrdýnýz.", ReturnName(id, 0));
    MesajGonder(id, "%s adlý yetkili tarafýndan canlandýrýldýnýz.", PlayerData[playerid][pAdminName]);
    new rank[20];
	if (PlayerData[playerid][pHelper] > 0) format(rank, sizeof(rank), "(Lv. %d) Helper", PlayerData[playerid][pHelper]);
	else format(rank, sizeof(rank), "%s", GetAdminRank(playerid));

	AdminHelperMessage(COLOR_LIGHTRED, "ADM: %s %s, %s (%d) adlý oyuncuyu canlandýrdý.", rank, PlayerData[playerid][pAdminName], Player_GetName(id), id);
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
            MesajGonder(i, "%s adlý yetkili tarafýndan canlandýrýldýnýz.",PlayerData[playerid][pAdminName]);
        }
    }
    AdminMessage(COLOR_LIGHTRED, "(%s) - (( %s adlý yetkili tarafýndan bütün oyuncular canlandýrýldý. ))",ReturnDate(), PlayerData[playerid][pAdminName]);
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
    if (sscanf(params, "is[16]", id, password)) return KullanimMesajGonder(playerid, "/abankasifre [Hesap ID] [Þifre]");
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
	    SendClientMessage(playerid, 0xE88732FF, "TIP: {FFFFFF}0- Bütün | 1- Giriþler | 2- Yatýrýlan | 3- Çekilen | 4- Transfer | 5- Þifre Deðiþtirmeler");
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
	if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Bu komutu kullanmak için yetkiniz yok.");
	new id = Iter_Free(Bankers);
	if (id == -1) return HataMesajGonder(playerid, "Daha fazla oluþturulamaz.");
	new skin;
	if (sscanf(params, "i", skin)) return BilgiMesajGonder(playerid, "/createbanker [Skin ID]");
	if (!(0 <= skin <= 311)) return HataMesajGonder(playerid, "Geçersiz Skin ID.");
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
	format(label_string, sizeof(label_string), "{F1C40F}[%d] FLEECA Banka Görevlisi\n\n{FFFFFF}[{808080}ALT{FFFFFF}]", id);
	BankerData[id][bankerLabel] = CreateDynamic3DTextLabel(label_string, 0x1ABC9CFF, BankerData[id][bankerX], BankerData[id][bankerY], BankerData[id][bankerZ] + 0.25, 5.0, .testlos = 1);

	new query[225];
	mysql_format(g_SQL, query, sizeof(query), "INSERT INTO bankers (`ID`, `Skin`, `PosX`, `PosY`, `PosZ`, `PosA`, `Virtual`) VALUES ('%d', '%d', '%f', '%f', '%f', '%f', '%d')", id, skin, BankerData[id][bankerX], BankerData[id][bankerY], BankerData[id][bankerZ], BankerData[id][bankerA], GetPlayerVirtualWorld(playerid));
	mysql_tquery(g_SQL, query);

	Iter_Add(Bankers, id);
	return 1;
}

CMD:setbankerpos(playerid, params[])
{
    if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Bu komutu kullanmak için yetkiniz yok.");
	new id;
	if (sscanf(params, "i", id)) return BilgiMesajGonder(playerid, "/setbankerpos [ID]");
	if (!Iter_Contains(Bankers, id)) return HataMesajGonder(playerid, "Geçersiz ID.");
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
    if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Bu komutu kullanmak için yetkiniz yok.");
	new id, skin;
	if (sscanf(params, "ii", id, skin)) return BilgiMesajGonder(playerid, "/setbankerskin [ID] [Skin ID]");
	if (!Iter_Contains(Bankers, id)) return HataMesajGonder(playerid, "Geçersiz ID.");
	if (!(0 <= skin <= 311)) return HataMesajGonder(playerid, "Geçersiz Skin ID.");
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
    if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Bu komutu kullanmak için yetkiniz yok.");
	new id;
	if (sscanf(params, "i", id)) return BilgiMesajGonder(playerid, "/removebanker [ID]");
	if (!Iter_Contains(Bankers, id)) return HataMesajGonder(playerid, "Geçersiz ID.");
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
    if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Bu komutu kullanmak için yetkiniz yok.");
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
    if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Bu komutu kullanmak için yetkiniz yok.");
	new id;
	if (sscanf(params, "i", id)) return BilgiMesajGonder(playerid, "/editatm [ATM ID]");
	if (!Iter_Contains(ATMs, id)) return HataMesajGonder(playerid, "Geçersiz ID.");
	if (!IsPlayerInRangeOfPoint(playerid, 30.0, ATMData[id][atmX], ATMData[id][atmY], ATMData[id][atmZ])) return HataMesajGonder(playerid, "Editlemek istediðiniz ATM'ye yakýn deðilsiniz.");
	if (EditingATMID[playerid] != -1) return HataMesajGonder(playerid, "Zaten ATM editliyorsun.");
	EditingATMID[playerid] = id;
	EditDynamicObject(playerid, ATMData[id][atmObjID]);
	return 1;
}

CMD:removeatm(playerid, params[])
{
    if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Bu komutu kullanmak için yetkiniz yok.");
	new id;
	if (sscanf(params, "i", id)) return BilgiMesajGonder(playerid, "/removeatm [ID]");
	if (!Iter_Contains(ATMs, id)) return HataMesajGonder(playerid, "Geçersiz ATM id.");
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
	if (sscanf(params, "if", vid, fuel)) return KullanimMesajGonder(playerid, "/setfuel [Araç ID] [Yakýt]");
	if (!IsValidVehicle(vid)) return HataMesajGonder(playerid, "Böyle bir araç yok.");
	if (fuel > 100.0 || fuel < 0.1) return HataMesajGonder(playerid, "En fazla 100, en az 0 yakýt verebilirsiniz.");
	new arac = Car_GetID(vid);
	if (arac == -1) return HataMesajGonder(playerid, "Bu aracýn yakýtýný ayarlayamazsýnýz.");
	AracInfo[arac][aracBenzin] = fuel;
	MesajGonder(playerid, "%d ID'li aracýn yakýtý %.1f olarak deðiþtirildi.", vid, fuel);
	return 1;
}
CMD:gotoobject(playerid, params[])
{
	if (PlayerData[playerid][pAdmin] < 1) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
	if (isnull(params)) return KullanimMesajGonder(playerid, "/gotoobject [ID]");
	new id = strval(params[0]);
	if (!(0 <= id <= MAX_COP_OBJECTS - 1)) return HataMesajGonder(playerid, "Geçersiz ID girdiniz.");
	if (!CopObjectData[id][ObjCreated]) return HataMesajGonder(playerid, "Böyle bir obje yok.");
	Spawned[playerid] = 0;
	PlayerData[playerid][pLegalTeleport] = gettime() + 2;
	SetPlayerPos(playerid, CopObjectData[id][ObjX], CopObjectData[id][ObjY], CopObjectData[id][ObjZ] + 1.75);
	SetPlayerInterior(playerid, CopObjectData[id][ObjInterior]);
	SetPlayerVirtualWorld(playerid, CopObjectData[id][ObjVirtualWorld]);
	MesajGonder(playerid, "%d ID'li objeye ýþýnlandýnýz.", id);
	Spawned[playerid] = 1;
	return 1;
}
CMD:etolustur(playerid, params[])
{
	if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
	new id = Iter_Free(Trees);
	if (id == -1) return SendClientMessage(playerid, 0xE74C3CFF, "Daha fazla Et oluþturulamaz.");
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
	format(label, sizeof(label), "Kesilmiþ Ýnek (%d)\n\n{F1C40F}~k~~CONVERSATION_NO~ {FFFFFF}ile kesebilirsin.", id);
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

        MesajGonder(playerid, "Kesilmiþ Ýnek oluþturuldu, ID: %d", id);
	}

	return 1;
}

CMD:etduzenle(playerid, params[])
{
    if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
    if (EditingTreeID[playerid] != -1) return HataMesajGonder(playerid, "Zaten Et editliyorsun.");
	new id;
	if (sscanf(params, "i", id)) return KullanimMesajGonder(playerid, "/etduzenle [tree id]");
	if (!Iter_Contains(Trees, id)) return HataMesajGonder(playerid, "Geçersiz ID.");
	if (TreeData[id][treeGettingCut]) return HataMesajGonder(playerid, "Bu et kesildiði için düzenleyemezsiniz.");
	if (!IsPlayerInRangeOfPoint(playerid, 30.0, TreeData[id][treeX], TreeData[id][treeY], TreeData[id][treeZ])) return SendClientMessage(playerid, 0xE74C3CFF, "Düzenlemek istediðiniz ete yakýn deðilsiniz.");
	EditingTreeID[playerid] = id;
	EditDynamicObject(playerid, TreeData[id][treeObjID]);
	return 1;
}

CMD:etsil(playerid, params[])
{
    if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
	new id;
	if (sscanf(params, "i", id)) return KullanimMesajGonder(playerid, "/etsil [tree id]");
	if (!Iter_Contains(Trees, id)) return HataMesajGonder(playerid, "Geçersiz ID.");
	if (TreeData[id][treeGettingCut]) return HataMesajGonder(playerid, "Bu Et kesildiði için silemezsiniz.");
	if (Tree_BeingEdited(id)) return HataMesajGonder(playerid, "Bu Et düzenlendiði için silemezsiniz.");
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
	if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Bu komutu kullanmak için yetkiniz yok.");
	new skin;
	if (sscanf(params, "i", skin)) return BilgiMesajGonder(playerid, "/createbuyer [skin id]");
	if (!(0 <= skin <= 311)) return HataMesajGonder(playerid, "Geçersiz Skin ID.");
	new id = Iter_Free(Buyers);
	if (id == -1) return HataMesajGonder(playerid, "Daha fazla oluþturulamaz.");
	GetPlayerPos(playerid, BuyerData[id][buyerX], BuyerData[id][buyerY], BuyerData[id][buyerZ]);
	GetPlayerFacingAngle(playerid, BuyerData[id][buyerA]);

	BuyerData[id][buyerActorID] = CreateDynamicActor(skin, BuyerData[id][buyerX], BuyerData[id][buyerY], BuyerData[id][buyerZ], BuyerData[id][buyerA], 1);

	new label[300];
	format(label, sizeof(label), "{808080}Et Satýcýsý (%d)\n\n{FFFFFF}Testere almak için {F1C40F}/testere {FFFFFF}kullanabilirsiniz. {2ECC71}(%s)\n{FFFFFF}et satmak için {F1C40F}/et [sat] {FFFFFF}kullanabilirsin. {2ECC71}(%s).", id, FormatNumber(CSAW_PRICE), FormatNumber(LOG_PRICE));
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
	if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Bu komutu kullanmak için yetkiniz yok.");
	new id, skin;
	if (sscanf(params, "ii", id, skin)) return SendClientMessage(playerid, 0xE88732FF, "KULLANIM: {FFFFFF}/setbuyerskin [buyer id] [skin id]");
	if (!Iter_Contains(Buyers, id)) return SendClientMessage(playerid, 0xE74C3CFF, "HATA: {FFFFFF}Geçersiz ID.");
	if (!(0 <= skin <= 311)) return SendClientMessage(playerid, 0xE74C3CFF, "HATA: {FFFFFF}Geçersiz skin ID.");
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
	if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Bu komutu kullanmak için yetkiniz yok.");
	new id;
	if (sscanf(params, "i", id)) return SendClientMessage(playerid, 0xE88732FF, "KULLANIM: {FFFFFF}/setbuyerpos [buyer id]");
	if (!Iter_Contains(Buyers, id)) return SendClientMessage(playerid, 0xE74C3CFF, "HATA: {FFFFFF}Geçersiz ID.");
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
	if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Bu komutu kullanmak için yetkiniz yok.");
	new id;
	if (sscanf(params, "i", id)) return SendClientMessage(playerid, 0xE88732FF, "KULLANIM: {FFFFFF}/removebuyer [buyer id]");
	if (!Iter_Contains(Buyers, id)) return SendClientMessage(playerid, 0xE74C3CFF, "HATA: {FFFFFF}Geçersiz ID.");

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
	if (!OyundaDegil(id)) return HataMesajGonder(playerid, "Oyuncu oyunda deðil.");

	PlayerData[id][pBakiye] += bakiye;
	if (bakiye < 0)
	{
	    BilgiMesajGonder(playerid, "%s adlý kiþiden %d TL bakiyesini aldýn.", ReturnName(id, 0), bakiye);
    	BilgiMesajGonder(id, "%s adlý yetkili bakiyenizden %d TL sildi.", PlayerData[playerid][pAdminName], bakiye);
	}
	else
	{
	    MesajGonder(playerid, "%s adlý kiþiye %d TL bakiye verdiniz.", ReturnName(id, 0), bakiye);
    	MesajGonder(id, "%s adlý yetkili size %d TL bakiye verdi.", PlayerData[playerid][pAdminName], bakiye);
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
	if (sscanf(params, "uii", id, level, gun)) return KullanimMesajGonder(playerid, "/setvip [ID/Isim] [Level] [Gün]");
	if (!OyundaDegil(id)) return HataMesajGonder(playerid, "Oyuncu oyunda deðil.");
	if (level < 0 || level > 3) return HataMesajGonder(playerid, "Geçersiz level girdiniz.");
	if (gun < 0) return 1;
	if (level == 0)
	{
		PlayerData[id][pVip] = 0;
		PlayerData[id][pVipSure] = 0;
		PlayerData[id][pVipRenk] = 0;
		PlayerData[id][pDovusStili] = 4;
  		SetPlayerFightingStyle(id, FIGHT_STYLE_NORMAL);
		Oyuncu_Kaydet(id);
		BilgiMesajGonder(id, "%s adlý yetkili tarafýndan V.I.P paketiniz silindi.", PlayerData[playerid][pAdminName]);
		BilgiMesajGonder(playerid, "%s adlý kiþinin V.I.P paketini sildiniz.", ReturnName(id, 0));
	}
	else
	{
	    PlayerData[id][pVip] = level;
	    PlayerData[id][pVipSure] = gettime()+gun*86400;
	    BilgiMesajGonder(id, "%s adlý yetkili size %s paketini %d günlük verdi. (Bitiþ tarihi: %s)", PlayerData[playerid][pAdminName], GetVIPName(level), gun, convertDatex(PlayerData[id][pVipSure]));
	    BilgiMesajGonder(playerid, "%s adlý kiþiye %s paketini %d günlük verdiniz. (Bitiþ tarihi: %s)", ReturnName(id, 0), GetVIPName(level), gun, convertDatex(PlayerData[id][pVipSure]));
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
	if (sayi == 0) return HataMesajGonder(playerid, "Bulunamadý.");
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
    if (id == -1) return HataMesajGonder(playerid, "Hood oluþturulamadý.");
    MesajGonder(playerid, "Hood oluþturuldu, ID: %d", id);
	return 1;
}

CMD:hoodsil(playerid, params[])
{
	new id;
    if (PlayerData[playerid][pAdmin] < 3) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
    if (sscanf(params, "i", id)) return KullanimMesajGonder(playerid, "/hoodsil [ID]");
    if ((id < 0 || id >= MAX_HOOD) || Hood[id][hExists] == false) return HataMesajGonder(playerid, "Geçersiz ID girdiniz.");
    Hood_Sil(id);
    MesajGonder(playerid, "Hood silindi.");
	return 1;
}

CMD:graffitisil(playerid, params[])
{
	new id;
	if (PlayerData[playerid][pAdmin] < 3) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
	if (sscanf(params, "i", id)) return KullanimMesajGonder(playerid, "/graffitisil [ID] (-1 yazarsanýz yakýnýnýzdaki graffiti silinir)");
	if (id == -1)
	{
	    new yakinid = GetClosestGraffiti(playerid);
	    if (yakinid == -1) return HataMesajGonder(playerid, "Yakýnýnýzda graffiti yok.");
	    Graffiti_Delete(yakinid);
	    MesajGonder(playerid, "Graffiti silindi, ID: %d.", yakinid);
	}
	else
	{
	    if ((id < 0 || id >= MAX_GRAFFITI_POINTS) || !GraffitiData[id][graffitiExists]) return HataMesajGonder(playerid, "Geçersiz ID girdiniz.");
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
        return KullanimMesajGonder(playerid, "(/o)oc [Sunucu OOC Yazý]");
    if (strlen(params) > 64)
    {
        foreach (new i : Player)
		{
            SendClientMessageEx(i, 0xBC8A5AAA, "{bc8a5a}(( [Oyun Dýþý] %s: %.64s ))", PlayerData[playerid][pAdminName], params);
            SendClientMessageEx(i, 0xBC8A5AAA, "{bc8a5a}...%s ))", params[64]);
        }
    }
    else
    {
        foreach (new i : Player)
        {
            SendClientMessageEx(i, 0xBC8A5AAA, "{bc8a5a}(( [Oyun Dýþý] %s: %.64s ))",PlayerData[playerid][pAdminName], params);
        }
    }
    return 1;
}
CMD:songiris(playerid, params[])
{
	if (PlayerData[playerid][pAdmin] < 1) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

    if (isnull(params) || strlen(params) > 24)
        return KullanimMesajGonder(playerid, "/songiris [Kullanýcý Adý]");

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
        return HataMesajGonder(playerid, "Belirttiðiniz oyuncu oyunda deðil !");

    static
        Float:px,
        Float:py,
        Float:pz;

    GetPlayerPos(userid, px, py, pz);
    SetPlayerPos(userid, px, py, pz + 5);

    PlayerPlaySound(userid,1190,0.0,0.0,0.0);
	AdminMessage(COLOR_LIGHTRED, " %s adlý yetkili %s(%d) adlý oyuncuyu tokatladý.", PlayerData[playerid][pAdminName], ReturnName(userid, 0), userid);
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
        return HataMesajGonder(playerid, "Belirttiðiniz oyuncu oyunda deðil !");

    if (PlayerData[userid][pAdmin] > PlayerData[playerid][pAdmin])
        return HataMesajGonder(playerid, "Belirtilen oyuncu sizden yüksek yetkiye sahiptir.");

	new query[300];
    if (PlayerData[userid][pLevel] >= 1)
    {
        format(query, sizeof(query), "INSERT INTO `oocsicil` (`ID`, `Tarih`, `Sebep`, `Uygulayan`, `Tur`) VALUES('%d', '%s', '%s', '%s', '1')",  PlayerData[userid][pID], ReturnDate(), reason, PlayerData[playerid][pAdminName]);
        mysql_tquery(g_SQL, query);
    }
    foreach (new i:Player) if (PlayerData[i][pAyarlar][3] == 0 || i == userid)
    {
    	SendClientMessageEx(i, 0xC87C0000, "[Kick]{808080} %s, %s tarafýndan %s sebebiyle sunucudan atýldý. (%s)", ReturnName(userid, 0),  PlayerData[playerid][pAdminName], reason, ReturnDate());
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
        return HataMesajGonder(playerid, "Belirttiðiniz oyuncu oyunda deðil !");

    if (PlayerData[userid][pAdmin] > PlayerData[playerid][pAdmin])
        return HataMesajGonder(playerid, "Belirtilen oyuncu sizden yüksek yetkiye sahiptir.");

	new query[300];
    if (PlayerData[userid][pLevel] >= 1)
    {
        format(query, sizeof(query), "INSERT INTO `oocsicil` (`ID`, `Tarih`, `Sebep`, `Uygulayan`, `Tur`) VALUES('%d', '%s', '%s', '%s', '1')",  PlayerData[userid][pID], ReturnDate(), reason, PlayerData[playerid][pAdminName]);
        mysql_tquery(g_SQL, query);
    }
    SunucuMesaji(userid, "Sunucudan sessiz kicklendiniz.");
    AdminHelperMessage(COLOR_LIGHTRED, "ADM: (%s) %s %s, %s adlý oyuncuyu sunucudan sessiz þekilde kickledi, sebep: %s", ReturnDate(), GetAdminRank(playerid), PlayerData[playerid][pAdminName], ReturnName(userid, 0), reason);
    Log_Write("logs/kick_log.txt", "[%s] %s tarafindan %s sunucudan atildi. sebep: %s.", ReturnDate(), PlayerData[playerid][pAdminName], ReturnName(userid, 0), reason);
    Kick(userid);
    return 1;
}
CMD:kickall(playerid, params[])
{
    if (PlayerData[playerid][pAdmin] < 4)
        return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

    SendClientMessageToAllEx(COLOR_LIGHTRED, "ADM: (%s) %s %s, herkesi sunucudan attý.", ReturnDate(), GetAdminRank(playerid), PlayerData[playerid][pAdminName]);
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
        return HataMesajGonder(playerid, "Belirttiðiniz oyuncu oyunda deðil !");

    TogglePlayerControllable(userid, 0);
    MesajGonder(playerid, "%s adlý oyuncuyu dondurdunuz.", ReturnName(userid, 0));
    BilgiMesajGonder(userid, "%s adlý yetkili tarafýndan donduruldunuz.", PlayerData[playerid][pAdminName]);
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
        return HataMesajGonder(playerid, "Belirttiðiniz oyuncu oyunda deðil !");

    TogglePlayerControllable(userid, 1);
    MesajGonder(playerid, "%s adlý oyuncunun hareket edememe engelini kaldýrdýnýz.", ReturnName(userid, 0));
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
        return HataMesajGonder(playerid, "Belirttiðiniz oyuncu oyunda deðil !");


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
	AdminHelperMessage(COLOR_LIGHTRED, "ADM: %s %s, %s(%d) adlý oyuncuyu spawnladý.", rank, PlayerData[playerid][pAdminName], ReturnName(userid, 0), userid);
	MesajGonder(playerid, "%s adlý oyuncuyu spawnladýnýz.", ReturnName(userid, 0));
    BilgiMesajGonder(userid, "%s adlý yetkili sizi spawnladý.", PlayerData[playerid][pAdminName]);

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
        return HataMesajGonder(playerid, "Belirttiðiniz oyuncu oyunda deðil !");

    SetPlayerSkin(userid, skinid);
    PlayerData[userid][pSkin] = skinid;

    MesajGonder(playerid, "%s adlý oyuncunun kýyafetini ID %d olarak deðiþtirdiniz.", ReturnName(userid, 0), skinid);
    BilgiMesajGonder(userid, "%s adlý yetkili skininizi ID %d olarak deðiþtirdi.", PlayerData[playerid][pAdminName], skinid);

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
		SendClientMessage(playerid, COLOR_PINK, "[ÝSÝMLER]:{FFFFFF} ls, mulk, isyeri, bina, gate, interior, garaj, lv, sf");
		PlayerData[playerid][pLegalTeleport] = gettime() + 2;
		return 1;
	}

    if (id == INVALID_PLAYER_ID)
	{
	    if (sscanf(params, "s[24]S()[64]", type, string))
		{
		    KullanimMesajGonder(playerid, "/goto [oyuncu veya isim]");
			SendClientMessage(playerid, COLOR_PINK, "[ÝSÝMLER]:{FFFFFF} ls, ev, isyeri, bina, gate, interior, garaj, lv, sf");
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
	        return SunucuMesaji(playerid, "Los Santos'a ýþýnlandýn.");
		}
		else if (!strcmp(type, "mulk", true))
		{
		    if (sscanf(string, "d", id))
		        return KullanimMesajGonder(playerid, "/goto [ev] [ev ID]");

			if ((id < 0 || id >= MAX_EV) || !HouseInfo[id][evExists])
			    return HataMesajGonder(playerid, "Geçersiz ev ID'si.");
			Spawned[playerid] = 0;
		    SetPlayerPos(playerid, HouseInfo[id][evPos][0], HouseInfo[id][evPos][1], HouseInfo[id][evPos][2]);
		    SetPlayerInterior(playerid, 0);
		    SetPlayerVirtualWorld(playerid, 0);
		    PlayerData[playerid][pHouse] = -1;
	        PlayerData[playerid][pIsyeri] = -1;
	        PlayerData[playerid][pGarage] = -1;
            PlayerData[playerid][pCadir] = -1;
		    SunucuMesaji(playerid, "%d idli mülke gittin.", id);
			Spawned[playerid] = 1;
		    return 1;
		}
		else if (!strcmp(type, "isyeri", true))
		{
		    if (sscanf(string, "d", id))
		        return KullanimMesajGonder(playerid, "/goto [isyeri] [isyeri ID]");

			if ((id < 0 || id >= MAX_ISYERI) || !Isyeri[id][isyeriExists])
			    return HataMesajGonder(playerid, "Geçersiz iþyeri ID'si.");
			Spawned[playerid] = 0;
		    SetPlayerPos(playerid, Isyeri[id][isyeriPos][0], Isyeri[id][isyeriPos][1], Isyeri[id][isyeriPos][2]);
		    SetPlayerInterior(playerid, 0);
		    SetPlayerVirtualWorld(playerid, 0);
		    PlayerData[playerid][pHouse] = -1;
	        PlayerData[playerid][pIsyeri] = -1;
	        PlayerData[playerid][pGarage] = -1;
            PlayerData[playerid][pCadir] = -1;
//            AdminHelperMessage(COLOR_LIGHTRED, "ADM: %s %s, %d idli iþyerine ýþýnlandý." rank, PlayerData[playerid][pAdminName], id);
		    SunucuMesaji(playerid, "%d idli iþyerine gittin.", id);
			Spawned[playerid] = 1;
		    return 1;
		}
		else if (!strcmp(type, "bina", true))
		{
		    if (sscanf(string, "d", id))
		        return KullanimMesajGonder(playerid, "/goto [bina] [bina ID]");

			if ((id < 0 || id >= MAX_ENTRANCES) || !EntranceData[id][entranceExists])
			    return HataMesajGonder(playerid, "Geçersiz bir bina ID belirttiniz.");
			Spawned[playerid] = 0;
		    SetPlayerPos(playerid, EntranceData[id][entrancePos][0], EntranceData[id][entrancePos][1], EntranceData[id][entrancePos][2]);
		    SetPlayerInterior(playerid, EntranceData[id][entranceExterior]);

			SetPlayerVirtualWorld(playerid, EntranceData[id][entranceExteriorVW]);
			PlayerData[playerid][pHouse] = -1;
	        PlayerData[playerid][pIsyeri] = -1;
	        PlayerData[playerid][pGarage] = -1;
            PlayerData[playerid][pCadir] = -1;
		    SunucuMesaji(playerid, "%d idli binaya ýþýnaldý.", id);
			Spawned[playerid] = 1;
		    return 1;
		}
		else if (!strcmp(type, "gate", true))
		{
		    if (sscanf(string, "d", id))
		        return KullanimMesajGonder(playerid, "/goto [gate] [gate ID]");

			if ((id < 0 || id >= MAX_GATES) || !GateData[id][gateExists])
			    return HataMesajGonder(playerid, "Geçersiz bir kapý kimliði belirttiniz.");
			Spawned[playerid] = 0;
		    SetPlayerPos(playerid, GateData[id][gatePos][0] - (2.5 * floatsin(-GateData[id][gatePos][3], degrees)), GateData[id][gatePos][1] - (2.5 * floatcos(-GateData[id][gatePos][3], degrees)), GateData[id][gatePos][2]);
		    SetPlayerInterior(playerid, GateData[id][gateInterior]);

			SetPlayerVirtualWorld(playerid, GateData[id][gateWorld]);
			PlayerData[playerid][pHouse] = -1;
	        PlayerData[playerid][pIsyeri] = -1;
	        PlayerData[playerid][pGarage] = -1;
	        PlayerData[playerid][pCadir] = -1;
		    SunucuMesaji(playerid, "ID: %d numaralý gate'e gönderildin.", id);
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
		    Dialog_Show(playerid, TeleportInterior, DIALOG_STYLE_LIST, "Iþýnlan: Interior Listesi", str, "Seç", "Kapat");
		    return 1;
		}
		else if (!strcmp(type, "garaj", true))
		{
		    if (sscanf(string, "d", id))
		        return KullanimMesajGonder(playerid, "/goto [garaj] [garaj ID]");

			if ((id < 0 || id >= MAX_GARAGE) || GarageData[id][gExists] == false)
			    return HataMesajGonder(playerid, "Geçersiz ID girdiniz.");
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
		    return SunucuMesaji(playerid, "Las Venturas'a ýþýnlandýn.");
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
		    return SunucuMesaji(playerid, "Varsayýlan S.F. noktasýna gönderildin.");
		}
	    else return HataMesajGonder(playerid, "Belirttiðiniz oyuncu oyunda deðil !");
	}
	if (!OyundaDegil(id))
		return HataMesajGonder(playerid, "Bu kiþi giriþ yapmamýþ.");

	if(PlayerData[id][pAdmin] > PlayerData[playerid][pAdmin])
		return HataMesajGonder(playerid, "Kendinizden yüksek seviye yetkililere karþý bu komutu kullanamazsýnýz.");
	Spawned[playerid] = 0;
	SendPlayerToPlayer(playerid, id);
	MesajGonder(playerid, "%s (%d) adlý kiþinin yanýna ýþýnlandýnýz.", ReturnName(id, 0), id);
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
        return HataMesajGonder(playerid, "Belirttiðiniz oyuncu oyunda deðil !");

	if(PlayerData[userid][pAdmin] > PlayerData[playerid][pAdmin])
		return HataMesajGonder(playerid, "Kendinizden yüksek seviye yetkililere karþý bu komutu kullanamazsýnýz.");
	PlayerData[userid][pLegalTeleport] = gettime() + 2;
	Spawned[userid] = 0;
    SendPlayerToPlayer(userid, playerid);
    MesajGonder(playerid, "%s adlý oyuncuyu yanýna çektin.", ReturnName(userid, 0));
    BilgiMesajGonder(userid, "%s adlý yetkili seni yanýna çekti.", PlayerData[playerid][pAdminName]);
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
        return HataMesajGonder(playerid, "Belirttiðiniz oyuncu oyunda deðil!");

    if (PlayerData[userid][pAdmin] > 0)
    	return HataMesajGonder(playerid, "Adminleri yanýnýza çekemezsiniz.");

    new rank[20];
	if (PlayerData[playerid][pHelper] > 0) format(rank, sizeof(rank), "(Lv. %d) Helper", PlayerData[playerid][pHelper]);
	else format(rank, sizeof(rank), "%s", GetAdminRank(playerid));
    PlayerData[userid][pLegalTeleport] = gettime() + 2;
	Spawned[userid] = 0;
	SendPlayerToPlayer(userid, playerid);
    AdminHelperMessage(COLOR_LIGHTRED, "ADM: %s %s, %s(%d) adlý kiþiyi yanýna çekti", rank, PlayerData[playerid][pAdminName], ReturnName(userid, 0), userid);
    MesajGonder(playerid, "%s(ID: %d) adlý oyuncuyu yanýna çektin.", ReturnName(userid, 0), userid);
    BilgiMesajGonder(userid, "%s adlý yetkili seni yanýna çekti.", PlayerData[playerid][pAdminName]);
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
        return HataMesajGonder(playerid, "Belirttiðiniz oyuncu oyunda deðil !");

    if (PlayerData[userid][pAdmin] > PlayerData[playerid][pAdmin])
	    return HataMesajGonder(playerid, "Belirtilen oyuncu sizden yüksek yetkiye sahiptir.");

    new rank[20];
    if (PlayerData[playerid][pHelper] > 0) format(rank, sizeof(rank), "(Lv. %d) Helper", PlayerData[playerid][pHelper]);
	else format(rank, sizeof(rank), "%s", GetAdminRank(playerid));
    PlayerData[playerid][pLegalTeleport] = gettime() + 2;
	Spawned[playerid] = 0;
	SendPlayerToPlayer(playerid, userid);
	AdminHelperMessage(COLOR_LIGHTRED, "ADM: %s %s, %s(%d) adlý kiþinin yanýna ýþýnlandý.", rank, PlayerData[playerid][pAdminName], ReturnName(userid, 0), userid);
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
        return HataMesajGonder(playerid, "Belirttiðiniz oyuncu oyunda deðil !");

    SetPlayerInterior(userid, interior);

    MesajGonder(playerid, "%s adlý oyuncunun interiorunu (%d) olarak deðiþtirdin.", ReturnName(userid, 0), interior);
    return 1;
}
CMD:vwduzelt(playerid, params[])
{
	if(GetPlayerInterior(playerid) == 0 && GetPlayerVirtualWorld(playerid) > 0 && Entrance_Inside(playerid) == -1 && Business_Inside(playerid) == -1 && House_Inside(playerid) == -1)
	{
	    SetPlayerVirtualWorld(playerid, 0);
	    MesajGonder(playerid, "Virtual world sorununuz düzeltildi.");
	}
	else HataMesajGonder(playerid, "Virtual worldunuzda sorun yok ya da interiordasýnýz.");
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
        return HataMesajGonder(playerid, "Belirttiðiniz oyuncu oyunda deðil !");

    SetPlayerVirtualWorld(userid, world);

    MesajGonder(playerid, "%s adlý oyuncunun virtual worldunu (%d) olarak deðiþtirdin.", ReturnName(userid, 0), world);
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
        return HataMesajGonder(playerid, "Belirtilen kullanýcý(lar) baðlý deðildir.");

    SendPlayerToPlayer(userid, targetid);
    PlayerData[userid][pLegalTeleport] = gettime() + 2;
    PlayerData[targetid][pLegalTeleport] = gettime() + 2;
    MesajGonder(playerid, "%s adlý oyuncuyu %s adlý oyuncunun yanýna gönderdin.", ReturnName(userid, 0), ReturnName(targetid));
	BilgiMesajGonder(userid, "%s adlý yetkili seni %s adlý oyuncunun yanýna gönderdi.", PlayerData[playerid][pAdminName], ReturnName(targetid));
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
        return HataMesajGonder(playerid, "Belirttiðiniz oyuncu oyunda deðil !");

	new pip[15];
	GetPlayerIp(userid, pip, sizeof(pip));
    MesajGonder(playerid, "%s adlý oyuncunun IP adresi: %s", ReturnName(userid, 0), pip);
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
        return KullanimMesajGonder(playerid, "/sethp [id/isim] [deðer]");

    if (!OyundaDegil(userid))
        return HataMesajGonder(playerid, "Belirttiðiniz oyuncu oyunda deðil !");

    CanAyarla(userid, amount);
    MesajGonder(playerid, "%s adlý oyuncunun canýný %.2f olarak deðiþtirdin.", ReturnName(userid, 0), amount);
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
        return HataMesajGonder(playerid, "Belirttiðiniz oyuncu oyunda deðil !");

    ZirhAyarla(userid, amount);
    MesajGonder(playerid, "%s adlý oyuncunun zýrhýný %.2f olarak deðiþtirdin.", ReturnName(userid, 0), amount);
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
        return HataMesajGonder(playerid, "Belirttiðiniz oyuncu oyunda deðil !");

    ResetWeapons(userid);
    MesajGonder(playerid, "%s adlý oyuncunun silahlarýný sýfýrladýnýz.", ReturnName(userid, 0));
	BilgiMesajGonder(userid, "%s adlý yetkili tarafýndan silahlarýnýz sýfýrlandý.", PlayerData[playerid][pAdminName]);
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
        BilgiMesajGonder(playerid, "Bulunduðunuz araç tamir edildi.");
		AdminMessage(COLOR_LIGHTRED, "%s %s, admin komutu ile aracýný tamir etti.", GetAdminRank(playerid), PlayerData[playerid][pAdminName]);
   	    Log_Write("logs/atamir.log", "[%s] %s %s, admin komutu ile aracýný tamir etti.", ReturnDate(), GetAdminRank(playerid), PlayerData[playerid][pAdminName]);
    }
    else
    {
        if (sscanf(params, "d", vehicleid))
            return KullanimMesajGonder(playerid, "/atamir [araç ID]");

        else if (!IsValidVehicle(vehicleid))
            return HataMesajGonder(playerid, "Geçersiz bir araç ID'sý belirttiniz.");

        RepairVehicle(vehicleid);
        BilgiMesajGonder(playerid, "Araç ID: %d tamir edildi.  ", vehicleid);
    }
    return 1;
}

CMD:getcar(playerid, params[])
{
    new vehicleid;

    if (PlayerData[playerid][pAdmin] < 1 && PlayerData[playerid][pHelper] < 2 && !PlayerData[playerid][pOyunGorevlisi] && !PlayerData[playerid][pForumGorevlisi])
        return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

    if (sscanf(params, "d", vehicleid))
        return KullanimMesajGonder(playerid, "/getcar [Araç ID]");

    if (vehicleid < 1 || vehicleid > MAX_VEHICLES || !IsValidVehicle(vehicleid))
        return HataMesajGonder(playerid, "Geçersiz bir araç ID'sý belirttiniz.");

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
    AdminHelperMessage(COLOR_LIGHTRED, "ADM: %s %s, %s (%d) aracý yanýna çekti.", rank, PlayerData[playerid][pAdminName], ReturnVehicleModelName(GetVehicleModel(vehicleid)), vehicleid);
    return 1;
}


CMD:carto(playerid, params[])
{
    new vehicleid, userid;

    if (PlayerData[playerid][pAdmin] < 1)
        return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

    if (sscanf(params, "du", vehicleid, userid))
        return KullanimMesajGonder(playerid, "/carto [araç] [userid]");

    if (vehicleid < 1 || vehicleid > MAX_VEHICLES || !IsValidVehicle(vehicleid))
        return HataMesajGonder(playerid, "Geçersiz bir araç ID'sý belirttiniz.");

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
        return KullanimMesajGonder(playerid, "/entercar [araç id]");

    if (vehicleid < 1 || vehicleid > MAX_VEHICLES || !IsValidVehicle(vehicleid))
        return HataMesajGonder(playerid, "Geçersiz bir araç ID'sý belirttiniz.");

    seatid = GetAvailableSeat(vehicleid, 0);

    if (seatid == -1)
        return HataMesajGonder(playerid, "Araçta boþ koltuk yok.");
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
        return KullanimMesajGonder(playerid, "/gotocar [araç id]");

    if (vehicleid < 1 || vehicleid > MAX_VEHICLES || !IsValidVehicle(vehicleid))
        return HataMesajGonder(playerid, "Geçersiz bir araç ID'sý belirttiniz.");

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
	AdminHelperMessage(COLOR_LIGHTRED, "ADM: %s %s, %s (%d) model aracýn yanýna ýþýnlandý.", rank, PlayerData[playerid][pAdminName], ReturnVehicleModelName(GetVehicleModel(vehicleid)), vehicleid);
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
    AdminMessage(COLOR_LIGHTRED, "ADM: %s %s adlý admin tüm kiralýk araçlarý sýfýrladý.", GetAdminRank(playerid), PlayerData[playerid][pAdminName]);
    return 1;
}
CMD:respawncar(playerid, params[])
{
    new vehicleid;

    if (PlayerData[playerid][pAdmin] < 1 && PlayerData[playerid][pHelper] < 2 && !PlayerData[playerid][pOyunGorevlisi] && !PlayerData[playerid][pForumGorevlisi])
        return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

    if (sscanf(params, "d", vehicleid))
        return KullanimMesajGonder(playerid, "/respawncar [Araç ID]");

    if (vehicleid < 1 || vehicleid > MAX_VEHICLES || !IsValidVehicle(vehicleid))
        return HataMesajGonder(playerid, "Geçersiz bir araç ID'sý belirttiniz.");

	Arac_Spawn(Car_GetID(vehicleid));

 	new rank[20];
	if (PlayerData[playerid][pHelper] > 0) format(rank, sizeof(rank), "(Lv. %d) Helper", PlayerData[playerid][pHelper]);
	else format(rank, sizeof(rank), "%s", GetAdminRank(playerid));
	AdminHelperMessage(COLOR_LIGHTRED, "ADM: %s %s, %s (%d) model aracý spawnladý.", rank, PlayerData[playerid][pAdminName], ReturnVehicleModelName(GetVehicleModel(vehicleid)), vehicleid);
    BilgiMesajGonder(playerid, "%d idli aracý spawnladýn.", vehicleid);
	return 1;
}

CMD:respawncars(playerid, params[])
{
    if (PlayerData[playerid][pAdmin] < 1)
        return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

	new sure = 0;

	if (sscanf(params, "d", sure))
	    return KullanimMesajGonder(playerid, "/respawncars [Süre]");

	if (sure < 1)
	    return HataMesajGonder(playerid, "Süreyi en az 1 girebilirsin.");

	foreach (new i : Player)
	{
	    SendClientMessageEx(i, COLOR_LIGHTRED, "[!] %s isimli yetkili %d saniye sonra kullanýlmayan tüm araçlarý respawnlayacak!", PlayerData[playerid][pAdminName], sure);
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
		return HataMesajGonder(playerid, "Hiç meslek aracý yok.");

	MesajGonder(playerid, "Toplam %d meslek aracý respawn edildi.", count);
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
		return HataMesajGonder(playerid, "Hiç vip aracý yok.");

	MesajGonder(playerid, "Toplam %d vip aracý respawn edildi.", count);
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
        return HataMesajGonder(playerid, "Belirttiðiniz oyuncu oyunda deðil.");

    if (weaponid <= 0 || weaponid > 46 || (weaponid >= 19 && weaponid <= 21))
        return HataMesajGonder(playerid, "Geçersiz silah ID'sý.");

    GiveWeaponToPlayer(userid, weaponid, ammo);
    MesajGonder(playerid, "%s adlý oyuncuya %s (%d mermi) model silah verdin.", ReturnName(userid, 0), ReturnWeaponName(weaponid), ammo);
    BilgiMesajGonder(userid, "%s adlý yetkili sana %s (Mermi: %d) model silah verdi.", PlayerData[playerid][pAdminName], ReturnWeaponName(weaponid), ammo);
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
        return HataMesajGonder(playerid, "Belirttiðiniz oyuncu oyunda deðil !");

    if ((id < -1 || id >= MAX_BIRLIK) || (id != -1 && !Birlikler[id][birlikExists]))
        return HataMesajGonder(playerid, "Geçersiz birlik id.");

    if (id == -1)
    {
        BirliktenAt(userid);

        BilgiMesajGonder(playerid, "%s adlý kiþi birlikten çýkarýldý.", ReturnName(userid, 0));
        BilgiMesajGonder(userid, "%s adlý yetkili tarafýndan birlikten çýkarýldýnýz.", PlayerData[playerid][pAdminName]);
        Oyuncu_Kaydet(userid);
    }
    else
    {
        BirliktenAt(userid);
        PlayerData[userid][pFaction] = id;
	    PlayerData[userid][pFactionRutbe] = 1;
	    PlayerData[userid][pFactionDivizyon] = 0;

		Oyuncu_Kaydet(userid);
        MesajGonder(playerid, "%s adlý kiþiyi \"%s\" adlý birliðe aldýnýz.", ReturnName(userid, 0), Birlikler[id][birlikAd]);
        BilgiMesajGonder(userid, "%s adlý yetkili sizi \"%s\" adlý birliðe aldý.", PlayerData[playerid][pAdminName], Birlikler[id][birlikAd]);
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
        return HataMesajGonder(playerid, "Belirttiðiniz oyuncu oyunda deðil !");

    if ((factionid = PlayerData[userid][pFaction]) == -1)
        return HataMesajGonder(playerid, "Bu oyuncu herhangi bir birliðin üyesi deðil.");

    if (rank < 1 || rank > Birlikler[factionid][birlikRutbeler])
        return HataMesajGonder(playerid, "Geçersiz rütbe. Rütbe 1 ile %d arasýnda olmalýdýr.", Birlikler[factionid][birlikRutbeler]);

    PlayerData[userid][pFactionRutbe] = rank;

    MesajGonder(playerid, "%s adlý kiþinin rütbesi %d olarak deðiþtirildi.", ReturnName(userid, 0), rank);
    BilgiMesajGonder(userid, "%s adlý yetkili tarafýndan birlikteki rütbeniz %d olarak ayarlandý.", PlayerData[playerid][pAdminName], rank);

    return 1;
}
CMD:spec(playerid, params[])
{
	if (PlayerData[playerid][pAdmin] < 1 && PlayerData[playerid][pOyunGorevlisi] < 1) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
    new id;
    if (sscanf(params, "u", id)) return KullanimMesajGonder(playerid, "/spec [ID/Isim]");
    if (!OyundaDegil(id)) return HataMesajGonder(playerid, "Ýzlemek istediðin kiþi oyunda deðil.");
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
    MesajGonder(playerid, "Ýzlenen oyuncu : %s (Para %s, Can %d, Zýrh %d, Level %d)", ReturnName(id, 0), FormatNumber(PlayerData[id][pCash]), PlayerData[id][pHealth], PlayerData[id][pArmour], FormatNumber(PlayerData[id][pLevel]));
	MesajGonder(playerid, "/specoff ile çýkabilirsin.", ReturnName(id, 0));
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
	if (!OyundaDegil(userid)) return HataMesajGonder(playerid, "Oyuncu oyunda deðil.");
	if (sure < 1) return HataMesajGonder(playerid, "En az 1 dakika girmelisiniz.");
	if (PlayerData[userid][pHapisSure] > 0 && PlayerData[userid][pCK] == 1) return HataMesajGonder(playerid, "Bu karakter CK edilmiþ.");
	if(sure > 1000 && PlayerData[playerid][pForumGorevlisi] && !PlayerData[playerid][pOyunGorevlisi] && PlayerData[playerid][pAdmin] < 1) return HataMesajGonder(playerid, "Forum görevlileri en fazla 1000dk. hapise gönderebilir.");
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
		BilgiMesajGonder(userid, "%s adlý yetkili seni %d dakika hapse attý. (%s).", PlayerData[playerid][pAdminName], sure, sebep);

    if (playerid == INVALID_PLAYER_ID)
		BilgiMesajGonder(userid, "Sistem tarafýndan %d dakika hapse gönderildin. (%s).", sure, sebep);

	foreach (new i:Player) if (PlayerData[i][pAyarlar][3] == 0 || i == userid)
	{
	    if (playerid != INVALID_PLAYER_ID)
    		SendClientMessageEx(i, 0xC87C0000, "[Ceza]{808080} %s, %s tarafýndan %s sebebiyle %d dakika hapise gönderildi. (%s)", ReturnName(userid, 0), PlayerData[playerid][pAdminName], sebep, sure, ReturnDate());

		if (playerid == INVALID_PLAYER_ID)
            SendClientMessageEx(i, 0xC87C0000, "[Ceza]{808080} %s, Sistem tarafýndan %s sebebiyle %d dakika cezalandýrýldý. (%s)", ReturnName(userid, 0), sebep, sure, ReturnDate());
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
        return HataMesajGonder(playerid, "Belirttiðiniz oyuncu oyunda deðil !");

    if (!PlayerData[userid][pHapisSure])
        return HataMesajGonder(playerid, "Belirttiðiniz oyuncu hapiste deðil.");
    if (PlayerData[userid][pCK] == 1) return HataMesajGonder(playerid, "Bu karakter CK edilmiþ, hapisten çýkarýlamaz.");

    PlayerData[userid][pHapisSure] = 1;

    MesajGonder(playerid, "%s adlý oyuncuyu hapisten çýkarttýnýz.", ReturnName(userid, 0));
    BilgiMesajGonder(userid, "%s adlý yetkili sizi hapisten çýkarttý.", PlayerData[playerid][pAdminName]);

    Log_Write("logs/jail_log.txt", "[%s] %s adli yetkili %s adli oyuncuyu hapisten cikartti.", ReturnDate(), PlayerData[playerid][pAdminName], ReturnName(userid, 0));
    return 1;
}
CMD:ojail(playerid, params[])
{
	new ad[24], sure, sebep[50];
    if (PlayerData[playerid][pAdmin] < 1 && !PlayerData[playerid][pForumGorevlisi] && !PlayerData[playerid][pOyunGorevlisi])
        return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
    if (sscanf(params, "s[24]is[50]", ad, sure, sebep)) return KullanimMesajGonder(playerid, "/ojail [Karakter Adý] [Dakika] [Sebep]");
    if (sure < 1) return HataMesajGonder(playerid, "En az 1 dakika girmelisiniz.");
 	if(sure > 1000 && PlayerData[playerid][pForumGorevlisi] && !PlayerData[playerid][pOyunGorevlisi] && PlayerData[playerid][pAdmin] < 1) return HataMesajGonder(playerid, "Forum görevlileri en fazla 1000dk. hapise gönderebilir.");
    if (GetPlayerID(ad) != -1) return HataMesajGonder(playerid, "Bu oyuncu oyunda, /jail komutunu kullanýn.");
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
            format(bilgiler, sizeof(bilgiler), "%s - [ID: %d ] - [Hapis Süresi: %d saniye.]\n", ReturnName(i), i, PlayerData[i][pHapisSure]);
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
        return HataMesajGonder(playerid, "Belirttiðiniz oyuncu oyunda deðil !");

    ParaVer(userid, amount);
	MesajGonder(playerid, "%s adlý kiþiye %s miktar para verdiniz.", ReturnName(userid, 0), FormatNumber(amount));
	BilgiMesajGonder(userid, "%s adlý yetkili size %s miktar para verdi.",PlayerData[playerid][pAdminName], FormatNumber(amount));
    AdminMessage(COLOR_LIGHTRED, "ADM: %s, %s adlý kiþiye %s miktarda para verdi.", PlayerData[playerid][pAdminName], ReturnName(userid, 0), FormatNumber(amount));
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
        return HataMesajGonder(playerid, "Belirttiðiniz oyuncu oyunda deðil !");

	ParaDuzenle(userid, amount);
	SunucuMesaji(playerid, "%s adlý kiþinin parasýný %d olarak ayarladýnýz.", ReturnName(userid, 0), amount);
	AdminMessage(COLOR_LIGHTRED, "ADM: %s %s, %s adlý kiþinin parasýný %d olarak ayarladý.", GetAdminRank(playerid), PlayerData[playerid][pAdminName], ReturnName(userid, 0), amount);
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
    SendClientMessageToAllEx(COLOR_LIGHTRED, "ADM: %s sunucudaki 1 saatten fazla vakit geçirmiþ herkese bonus ikramiyede bulundu.", PlayerData[playerid][pAdminName]);
	return 1;
}

CMD:kills(playerid, params[])
{
	new id;
    if (PlayerData[playerid][pAdmin] < 1) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
    if (sscanf(params, "u", id)) return KullanimMesajGonder(playerid, "/kills [ID/Isim]");
    if (!OyundaDegil(id)) return HataMesajGonder(playerid, "Oyuncu oyunda deðil.");
    MesajGonder(playerid, "Öldürme: %d, Ölme: %d", PlayerData[id][pOldurme], PlayerData[id][pOlme]);
	return 1;
}

CMD:talepsayi(playerid, params[])
{
    new id;
    if (PlayerData[playerid][pAdmin] < 3) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
    if (sscanf(params, "u", id)) return KullanimMesajGonder(playerid, "/raporsayi [ID/Isim]");
    if (!OyundaDegil(id)) return HataMesajGonder(playerid, "Oyuncu oyunda deðil.");
    MesajGonder(playerid, "Talep Bakma Sayýsý: %d", PlayerData[id][pTalepSayi]);
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
	        format(str, sizeof(str), "%s{ffffff}Admin: (admin: %s) %s (id: %d) - duty: %s - talep: %d\n", str, GetAdminRank(i), PlayerData[i][pAdminName], i, (PlayerData[i][pAdminDuty] == 1) ? ("{02ef16}Müsait{ffffff}") : ("{ef0202}Meþgul{ffffff}"), PlayerData[i][pTalepSayi]);

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
	        format(str, sizeof(str), "%s{ffffff}Helper: (seviye: %d) %s (id: %d) - duty: %s - talep: %d\n", str, PlayerData[i][pHelper], PlayerData[i][pAdminName], i, (PlayerData[i][pHelperDuty] == 1) ? ("{02ef16}Müsait{ffffff}") : ("{ef0202}Meþgul{ffffff}"), PlayerData[i][pTalepSayi]);

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
    if (!OyundaDegil(id)) return HataMesajGonder(playerid, "Oyuncu oyunda deðil.");
	PlayerData[id][pEXP] += miktar;
	MesajGonder(id, "%s adlý yetkili size %d EXP verdi.", PlayerData[playerid][pAdminName], miktar);
	MesajGonder(playerid, "%s adlý oyuncuya %d EXP verdiniz.", ReturnName(id, 0), miktar);
	AdminMessage(COLOR_LIGHTRED, "ADM: %s, %s adlý kiþiye %d kadar exp verdi.", PlayerData[playerid][pAdminName], Player_GetName(id), miktar);
	if (PlayerData[id][pEXP] >= PlayerData[id][pLevel]*5)
	{
 		new kalanexp = 0;
   		if (PlayerData[id][pEXP] > PlayerData[id][pLevel]*5) kalanexp = PlayerData[id][pEXP] - PlayerData[id][pLevel]*5;
		PlayerData[id][pEXP] = kalanexp;
		PlayerData[id][pLevel]++;
		SetPlayerScore(id, PlayerData[id][pLevel]);
		MesajGonder(id, "Seviye atladýnýz!");
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
			MesajGonder(i, "Seviye atladýnýz.");
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
    SendClientMessageToAllEx(COLOR_LIGHTRED, "ADM: %s %s sunucuda 1 saat geçirmiþ herkese %d miktar exp daðýttý.", GetAdminRank(playerid), PlayerData[playerid][pAdminName], miktar);
	return 1;
}
CMD:ban(playerid, params[])
{
	new id, gun, sebep[50];
    if (PlayerData[playerid][pAdmin] < 1) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
    if (sscanf(params, "uis[50]", id, gun, sebep)) return KullanimMesajGonder(playerid, "/ban [ID/Isim] [Gün (0 yazarsanýz sýnýrsýz yasaklanýr)] [Sebep]");
    if (!OyundaDegil(id)) return HataMesajGonder(playerid, "Oyuncu giriþ yapmamýþ.");
    if (id == playerid) return HataMesajGonder(playerid, "Kendinizi yasaklayamazsýnýz.");
    if (PlayerData[id][pAdmin] > PlayerData[playerid][pAdmin]) return HataMesajGonder(playerid, "Belirtilen oyuncu sizden yüksek yetkiye sahiptir.");

    new pip[20];
    GetPlayerIp(id, pip, sizeof(pip));
    new sure[10];
    if (gun == 0) sure = "Sýnýrsýz";
    else format(sure, sizeof(sure), "%d gün", gun);
    Dialog_Show(id, Banli, DIALOG_STYLE_MSGBOX, "Yasaklandýnýz!", "Hesabýnýz bu sunucudan yasaklanmýþtýr. Detaylar;\n\nKarakter Adý: %s\nSebep: %s\nYasaklayan: %s\nSüre: %s\nF8 tuþuna basýn ve bir ekran görüntüsü alýn, bu ekran görüntüsü ile forumumuzdan yasaklanmanýza itiraz edebilirsiniz.", "Kapat", "", Player_GetName(id), sebep, PlayerData[playerid][pAdminName], sure);
    new query[350];
    format(query, sizeof(query), "INSERT INTO `oocsicil` (`ID`, `Tarih`, `Sebep`, `Uygulayan`, `Tur`) VALUES('%d', '%s', '%s', '%s', '2')",  PlayerData[id][pID], ReturnDate(), sebep, PlayerData[playerid][pAdminName]);
    mysql_tquery(g_SQL, query);
    foreach (new i:Player) if (PlayerData[i][pAyarlar][3] == 0 || i == id)
    {
    	if (gun == 0) SendClientMessageEx(i, 0xC87C0000, "[Yasaklama]{808080} %s adlý oyuncu %s tarafýndan %s sebebiyle sunucudan sýnýrsýz yasaklandý. (%s)", ReturnName(id, 0),  PlayerData[playerid][pAdminName], sebep, ReturnDate());
    	else SendClientMessageEx(i, 0xC87C0000, "[Yasaklama]{808080} %s, %s tarafýndan %s sebebiyle sunucudan %d gün yasaklandý. (%s)", ReturnName(id, 0),  PlayerData[playerid][pAdminName], sebep, gun, ReturnDate());
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
    if (sscanf(params, "s[30]is[50]", ip, gun, sebep)) return KullanimMesajGonder(playerid, "/banip [IP] [Gün (0 yazarsanýz sýnýrsýz yasaklanýr)][Sebep]");
    AddBan(ip, "Yok", "", PlayerData[playerid][pAdminName], (gun < 1) ? (0) : (gettime()+gun*86400), sebep);
    new sure[10];
    if (gun < 1) sure = "Sýnýrsýz";
    else format(sure, sizeof(sure), "%d gün", gun);
    AdminMessage(COLOR_LIGHTRED, "ADM: %s adlý admin %d ipsini %d gün banladý.", PlayerData[playerid][pAdminName], ip, sure);
	return 1;
}
CMD:oban(playerid, params[])
{
	new ad[24], gun, sebep[50];
    if (PlayerData[playerid][pAdmin] < 1) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
    if (sscanf(params, "s[24]is[50]", ad, gun, sebep)) return KullanimMesajGonder(playerid, "/oban [Karakter Adý] [Gün (0 yazarsanýz sýnýrsýz yasaklanýr)] [Sebep]");
    if (GetPlayerID(ad) != -1) return HataMesajGonder(playerid, "Bu oyuncu oyunda, /ban komutunu kullanýn.");
    new query[124];
    format(query, sizeof(query), "SELECT * FROM `oyuncular` WHERE `Isim` = '%s'", ad);
    mysql_tquery(g_SQL, query, "OnBanAccount", "isis", playerid, ad, gun, sebep);
	return 1;
}
/*CMD:ocban(playerid, params[])
{
	new ad[24], sebep[50];
    if (PlayerData[playerid][pAdmin] < 3) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
    if (sscanf(params, "s[24]s[50]", ad, sebep)) return KullanimMesajGonder(playerid, "/ocban [Karakter Adý] [Sebep]");
    if (GetPlayerID(ad) != -1) return HataMesajGonder(playerid, "Bu oyuncu oyunda, /cban komutunu kullanýn.");
    new query[124];
    format(query, sizeof(query), "SELECT * FROM `oyuncular` WHERE `Isim` = '%s'", ad);
    mysql_tquery(g_SQL, query, "OnCBanAccount", "iss", playerid, ad, sebep);
	return 1;
}*/
CMD:unban(playerid, params[])
{
	new ad[30];
    if (PlayerData[playerid][pAdmin] < 1) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
    if (sscanf(params, "s[30]", ad)) return KullanimMesajGonder(playerid, "/unban [Karakter Adý veya IP]");
    new query[124];
    format(query, sizeof(query), "SELECT null FROM `bans` WHERE `Ad` = '%s' OR `IP` = '%s'", ad, ad);
    mysql_tquery(g_SQL, query, "UnBan", "is", playerid, ad);
	return 1;
}
CMD:baninfo(playerid, params[])
{

    if (PlayerData[playerid][pAdmin] < 1) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
	if (isnull(params) || strlen(params) > 30) return KullanimMesajGonder(playerid, "/baninfo [Karakter Adý veya IP]");
	new query[124];
 	format(query, sizeof(query), "SELECT * FROM `bans` WHERE `Ad` = '%s' OR `IP` = '%s'", SQL_ReturnEscaped(params), SQL_ReturnEscaped(params));
  	mysql_tquery(g_SQL, query, "BanInfo", "ds", playerid, params);
    return 1;
}

CMD:h(playerid, params[])
{
    if (PlayerData[playerid][pAdmin] < 1 && PlayerData[playerid][pHelper] < 1 && !PlayerData[playerid][pForumGorevlisi] && !PlayerData[playerid][pOyunGorevlisi]) return HataMesajGonder(playerid, "Bu komutu kullanmak için yetkiniz yok !");
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
    Dialog_Show(playerid,SoruEkle,DIALOG_STYLE_INPUT, "Soru Ekle", "Lütfen ekleyeceðiniz sorunun sorusunu giriniz:\n\n{FF0000}NOT: en fazla 50 karakterden oluþabilir.", "Devam", "Kapat");
    return 1;
}
CMD:sorusil(playerid,params[])
{
    if (PlayerData[playerid][pAdmin] < 1 && PlayerData[playerid][pHelper] < 2) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
    new sid;
    if (sscanf(params, "i",sid))
    {
        KullanimMesajGonder(playerid, "/sorusil [Soru ID]");
        return HataMesajGonder(playerid, "Soru ID'si bulmak için /soruidbul komutunu kullanýn.");
    }
    if ((sid < 0 || sid >= MAX_SORU) || !SoruData[sid][soruExists]) return HataMesajGonder(playerid, "Soru ID'si bulunamadý.");
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
    if (!sayi) return HataMesajGonder(playerid, "Yazdýðýnýz anahtar kelimeye ait hiçbir soru bulunamadý.");
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
	    return HataMesajGonder(playerid, "Belirttiðiniz oyuncu oyunda deðil !");

	if (!strcmp(type, "yas", true))
	{
	    if (isnull(amount) || strval(amount) < 18 || strval(amount) > 80) return KullanimMesajGonder(playerid, "/setplayer [ID/Isim] [Yas] [Yaþ]");
	    PlayerData[userid][pYas] = strval(amount);
	    MesajGonder(playerid, "%s adlý kiþinin yaþýný %d olarak ayarladýn.", ReturnName(userid, 0), strval(amount));
	}
	else if (!strcmp(type, "cinsiyet", true))
	{
	    if (PlayerData[userid][pCinsiyet] == 1)
	    {
	        PlayerData[userid][pCinsiyet] = 2;
	        MesajGonder(playerid, "%s adlý kiþinin cinsiyetini Kadýn olarak deðiþtirdiniz.", ReturnName(userid, 0));
	    }
	    else
	    {
	        PlayerData[userid][pCinsiyet] = 1;
	        MesajGonder(playerid, "%s adlý kiþinin cinsiyetini Erkek olarak deðiþtirdiniz.", ReturnName(userid, 0));
	    }
	}
	else if (!strcmp(type, "dogumyeri", true))
	{
	    if (isnull(amount)) return HataMesajGonder(playerid, "Doðum yerini girmediniz.");
	    format(PlayerData[userid][pDogum], 30, amount);
	    MesajGonder(playerid, "%s adlý kiþinin doðum yerini '%s' olarak deðiþtirdiniz.", ReturnName(userid, 0), amount);
	}
	else if (!strcmp(type, "ten", true))
	{
	    if (PlayerData[userid][pTen] == 1)
	    {
	        PlayerData[userid][pTen] = 2;
	        MesajGonder(playerid, "%s adlý kiþinin ten rengini Siyah olarak deðiþtirdiniz.", ReturnName(userid, 0));
	    }
	    else
	    {
	        PlayerData[userid][pTen] = 1;
	        MesajGonder(playerid, "%s adlý kiþinin ten rengini Beyaz olarak deðiþtirdiniz.", ReturnName(userid, 0));
	    }
	}
	else if (!strcmp(type, "ehliyet", true))
	{
	    if (PlayerData[userid][pEhliyet] == 1)
	    {
	        PlayerData[userid][pEhliyet] = 0;
	        MesajGonder(playerid, "%s adlý kiþinin ehliyetini sildiniz.", ReturnName(userid, 0));
	    }
	    else
	    {
	        PlayerData[userid][pEhliyet] = 1;
	        MesajGonder(playerid, "%s adlý kiþiye ehliyet verdiniz.", ReturnName(userid, 0));
	    }
	}
	else if (!strcmp(type, "aranma", true))
	{
		if (isnull(amount) || strval(amount) < 0 || strval(amount) > 6) return KullanimMesajGonder(playerid, "/setplayer [ID/Isim] [Aranma] [Aranma Seviyesi 0-6]");
		PlayerData[userid][pAranma] = strval(amount);
		SetPlayerWantedLevel(userid, PlayerData[userid][pAranma]);
		MesajGonder(playerid, "%s adlý kiþinin aranma seviyesini %d olarak ayarladýnýz.", ReturnName(userid, 0), strval(amount));
	}
	else if (!strcmp(type, "bitcoin", true))
	{
		if (isnull(amount) || strval(amount) < 0 || strval(amount) > 1000) return KullanimMesajGonder(playerid, "/setplayer [ID/Isim] [Bitcoin] [Miktar]");
		PlayerData[userid][pBitcoin] = strval(amount);
		MesajGonder(playerid, "%s adlý kiþinin bitcoin miktarý %d olarak ayarlandý", ReturnName(userid, 0), strval(amount));
	}
	else if (!strcmp(type, "level", true))
	{
		if (isnull(amount)) return KullanimMesajGonder(playerid, "/setplayer [ID/Isim] [Level] [Level]");
		PlayerData[userid][pLevel] = strval(amount);
		SetPlayerScore(userid, PlayerData[userid][pLevel]);
		MesajGonder(playerid, "%s adlý kiþinin levelini %d olarak ayarlandýnýz", ReturnName(userid, 0), strval(amount));
	}
	else if (!strcmp(type, "oynamasaati", true))
	{
		if (isnull(amount)) return KullanimMesajGonder(playerid, "/setplayer [ID/Isim] [oynamasaati] [Saat]");
		PlayerData[userid][pOynamaSaati] = strval(amount);
		MesajGonder(playerid, "%s adlý kiþinin oynama saatini %d olarak ayarlandýnýz", ReturnName(userid, 0), strval(amount));
	}
	else if (!strcmp(type, "bagimlilik", true))
	{
		if (PlayerData[userid][pBagimlilik] == 0)
		{
		    PlayerData[userid][pBagimlilik] = 1;
		    PlayerData[userid][pBagimlilikSayac][1] = 0;
		    PlayerData[userid][pBagimlilikSayac][0] = 0;
		    MesajGonder(playerid, "%s adlý kiþiyi uyuþturucu baðýmlýsý yaptýnýz.", ReturnName(userid, 0));
		}
		else
		{
		    PlayerData[userid][pBagimlilik] = 0;
		    PlayerData[userid][pBagimlilikSayac][1] = 0;
		    PlayerData[userid][pBagimlilikSayac][0] = 0;
		    MesajGonder(playerid, "%s adlý kiþi artýk uyuþturucu baðýmlýsý deðil.", ReturnName(userid, 0));
		}
	}
	else if (!strcmp(type, "tasimacilikseviye", true))
	{
        if (isnull(amount)) return KullanimMesajGonder(playerid, "/setplayer [ID/Isim] [tasimacilikseviye] [Seviye 0-5]");
        if (strval(amount) < 0 || strval(amount) > 5) return HataMesajGonder(playerid, "Taþýmacýlýk seviyesi 0-5 arasýnda olmalýdýr.");
		PlayerData[userid][pTasimacilikSeviye] = strval(amount);
		MesajGonder(playerid, "%s adlý kiþinin taþýmacýlýk seviyesini %d olarak ayarlandýnýz", ReturnName(userid, 0), strval(amount));
	}
	else if (!strcmp(type, "tasimaciliksefer", true))
	{
        if (isnull(amount)) return KullanimMesajGonder(playerid, "/setplayer [ID/Isim] [tasimaciliksefer] [Sefer]");
		PlayerData[userid][pTasimacilikSefer] = strval(amount);
		MesajGonder(playerid, "%s adlý kiþinin taþýmacýlýk seferini %d olarak ayarlandýnýz", ReturnName(userid, 0), strval(amount));
	}
	else if (!strcmp(type, "dovusstili", true))
	{
        if (isnull(amount)) return KullanimMesajGonder(playerid, "/setplayer [ID/Isim] [dovusstili] [Stil]");
		PlayerData[userid][pDovusStili] = strval(amount);
		MesajGonder(playerid, "%s adlý kiþinin dövüþ stilini %s olarak ayarlandýnýz", ReturnName(userid, 0), GetFightStyleName(strval(amount)));
	}
	else if (!strcmp(type, "maskehakki", true))
	{
		if (PlayerData[userid][pMaskeHakki] == 0)
		{
		    PlayerData[userid][pMaskeHakki] = 1;
		    MesajGonder(playerid, "%s adlý kiþiye maske hakký verdiniz.", ReturnName(userid, 0));
		}
		else
		{
		    PlayerData[userid][pMaskeHakki] = 0;
		    MesajGonder(playerid, "%s adlý kiþinin maske hakkýný sildiniz.", ReturnName(userid, 0));
		}
	}
	else if (!strcmp(type, "materyal", true))
	{
		if (isnull(amount)) return KullanimMesajGonder(playerid, "/setplayer [ID/Isim] [materyal] [Miktar]");
		PlayerData[userid][pMateryal] = strval(amount);
		MesajGonder(playerid, "%s adlý kiþinin Parça miktarý %d olarak ayarlandý", ReturnName(userid, 0), strval(amount));
	//	AdminMessage(COLOR_LIGHTRED, "ADM: %s %s, %s (%d) adlý kiþinin materyalini %d olarak deðiþtirdi." GetAdminRank(playerid), PlayerData[playerid][pAdminName], ReturnName(userid, 0));
	}
	return 1;
}

CMD:aesyaver(playerid, params[])
{
	static userid;
	if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
	if (sscanf(params, "u", userid)) return KullanimMesajGonder(playerid, "/aesyaver [ID/Isim]");
	if (!OyundaDegil(userid)) return HataMesajGonder(playerid, "Oyuncu oyunda deðil.");
	SetPVarInt(playerid, "oyuncuID", userid);
	Dialog_Show(playerid, AEsyaVer, DIALOG_STYLE_LIST, "Eþya Ver", "Zar\nSigara\nÝp\nGöz Baðý\nMaske\nBenzin Kutusu\nBarbeku\nKöfte\nTavuk Eti\nDana Eti\nTamir Kiti\nPortatif Çadýr\nKamp Ateþi\nÞarjör", "Ver", "Kapat");
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
        return HataMesajGonder(playerid, "Belirttiðiniz oyuncu oyunda deðil !");

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
        return HataMesajGonder(playerid, "Oyuncu giriþ yapmamýþ.");

    SendClientMessage(playerid, COLOR_GREY, "-----------------------------------------------------------");
    SendClientMessageEx(playerid, COLOR_LIGHTRED, "%s'in Silahlarý:", ReturnName(userid, 0));
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
        MesajGonder(playerid, "Bulunduðunuz araç düzeltildi.");
		AdminMessage(COLOR_LIGHTRED, "%s %s, admin komutu ile aracýný çevirdi.", GetAdminRank(playerid), PlayerData[playerid][pAdminName]);
   	    Log_Write("logs/atamir.log", "[%s] %s %s, admin komutu ile aracýný çevirdi.", ReturnDate(), GetAdminRank(playerid), PlayerData[playerid][pAdminName]);

    }
    else
    {
        if (sscanf(params, "d", vehicleid))
            return KullanimMesajGonder(playerid, "/flipcar [araç ID]");

        else if (!IsValidVehicle(vehicleid))
            return HataMesajGonder(playerid, "Geçersiz bir araç ID'sý belirttiniz.");

        FlipVehicle(vehicleid);
        MesajGonder(playerid, "Araç ID %d düzeltildi.", vehicleid);
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
        return HataMesajGonder(playerid, "Geçersiz numara girdiniz.");

    if (GetNumberOwner(number) != INVALID_PLAYER_ID)
        return BilgiMesajGonder(playerid, "%d numaranýn sahibi %s adlý kiþidir.", number, ReturnName(GetNumberOwner(number), 0));

    HataMesajGonder(playerid, "Bu numaraya sahip oyuncu çevrimiçi deðil veya bu numaraya sahip kimse yok.");
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

    if (sscanf(params, "iii", carid, color1, color2)) return KullanimMesajGonder(playerid, "/arenk [Araç ID] [Renk 1] [Renk 2]");
    if (!IsValidVehicle(carid)) return HataMesajGonder(playerid, "Geçersiz araç id.");

    if (color1 < 0 || color1 > 255)
        return HataMesajGonder(playerid, "Renk 1, 0 ile 255 arasýnda olmalýdýr.");

    if (color2 < 0 || color2 > 255)
        return HataMesajGonder(playerid, "Renk 2, 0 ile 255 arasýnda olmalýdýr.");

	new id = Car_GetID(carid);
	if (id == -1) ChangeVehicleColor(carid, color1, color2);
	else
	{
	    AracInfo[id][aracRenkler][0] = color1;
	    AracInfo[id][aracRenkler][1] = color2;
	    ChangeVehicleColor(carid, color1, color2);
	    Arac_Kaydet(id);
	}

    MesajGonder(playerid, "Aracýn rengi deðiþtirildi.");
    return 1;
}

CMD:apaintjob(playerid, params[])
{
    static
        paintjobid, carid;

    if (PlayerData[playerid][pAdmin] < 3)
        return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

    if (sscanf(params, "ii", carid, paintjobid)) return KullanimMesajGonder(playerid, "/arenk [Araç ID] [Paintjob ID] (-1 kapatýr)");
    if (!IsValidVehicle(carid)) return HataMesajGonder(playerid, "Geçersiz araç id.");

    if (paintjobid < -1 || paintjobid > 5)
        return HataMesajGonder(playerid, "Geçersiz Paintjob ID. (0-5)");

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
    MesajGonder(playerid, "Paintjob deðiþtirildi.", paintjobid);
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
    MesajGonder(playerid, "Hava durumu %d olarak deðiþtirildi.", weatherid);
    AdminMessage(COLOR_LIGHTRED, "ADM: %s adlý yetkili hava durumunu deðiþtirdi. (ID: %d)", PlayerData[playerid][pAdminName], weatherid);
    return 1;
}

CMD:panel(playerid)
{
	if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
	if (sunucuKilitli) Dialog_Show(playerid, ServerPanel, DIALOG_STYLE_LIST, "Sunucu Paneli ", "Kilit Aç\nHostname Deðiþtir\nSorgu Çalýþtýr\nBakým Modu\nBaþvuru Durumu (%s)", "Seç", "Kapat", (GetServerBilgi("basvurudurum") == 1) ? ("{84f542}Açýk{FFFFFF}") : ("{ff1414}Kapalý{FFFFFF}"));
	else Dialog_Show(playerid, ServerPanel, DIALOG_STYLE_LIST, "Server Panel", "Kilitle\nHostname Deðiþtir\nSorgu Çalýþtýr\nBakým Modu\nBaþvuru Durumu (%s)", "Seç", "Kapat", (GetServerBilgi("basvurudurum") == 1) ? ("{84f542}Açýk{FFFFFF}") : ("{ff1414}Kapalý{FFFFFF}"));
	return 1;
}

CMD:evduzenle(playerid, params[])
{
    static id, type[24], string[128];
	if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Bu komutu kullanamazsýn !");
	if (sscanf(params, "ds[24]S()[128]", id, type, string))
 	{
	 	KullanimMesajGonder(playerid, "/evduzenle [ID] [Ad]");
	    SendClientMessage(playerid, COLOR_PINK, "{00FF15}[ADLAR]: {FFFFFF} sahip, sistemselfiyat, pozisyon, interior, kilit, maksmobilya, mobilyatemizle, kasatemizle");
		return 1;
	}
	if ((id < 0 || id >= MAX_EV) || !HouseInfo[id][evExists])
	    return HataMesajGonder(playerid, "Geçersiz ev ID'sý.");

    if (!strcmp(type, "sahip", true))
    {
        new sahipid;

	    if (sscanf(string, "d", sahipid))
	        return KullanimMesajGonder(playerid, "/evduzenle [ID] [sahip] [Sahip SQL ID] (-1 yazarsanýz sahipsiz olur)");

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
    if (!strcmp(type, "interior", true)) // Deðiþti
    {
        new interior;

	    if (sscanf(string, "d", interior))
	        return KullanimMesajGonder(playerid, "/evduzenle [ID] [interior] [Interior ID]");

	    if (!(0 <= interior <= sizeof(HouseInteriors)-1)) return HataMesajGonder(playerid, "Yazdýðýnýz ID'de bir interior bulunmamaktadýr.");

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
		MesajGonder(playerid, "Maksimum mobilya limiti %d olarak deðiþtirildi.", mobilya);
    }
    if (!strcmp(type, "mobilyatemizle", true)) // Deðiþti
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
        MesajGonder(playerid, "Kasadaki para, uyuþturucu ve silahlar silindi.");
    }
	return 1;
}

CMD:givenos(playerid, params[])
{
	new id;

	if (PlayerData[playerid][pAdmin] < 4)
	    return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

	if (sscanf(params, "d", id))
		return MesajGonder(playerid, "/givenos [Araç ID]");

	if (Car_GetID(id) == -1)
		return HataMesajGonder(playerid, "Geçersiz Araç ID'si girdiniz.");

	AddVehicleComponent(id, 1010);
	MesajGonder(playerid, "%d ID'li araca 10x nos eklenmiþtir.", id);
	return 1;
}

CMD:aracduzenle(playerid, params[])
{
    static vid, type[24], string[128];
	if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Bu komutu kullanamazsýn !");

	if (sscanf(params, "ds[24]S()[128]", vid, type, string))
	{
	    KullanimMesajGonder(playerid, "/aracduzenle [ID] [Ayar]");
	    SendClientMessage(playerid, COLOR_PINK, "{00FF15}[Ayarlar]: {FFFFFF}model, sahip, zirh, kilit, vergi, modifiyesil, taksiplaka, ceza, birlik, kira, satilik");
	    return SendClientMessage(playerid, COLOR_PINK, "{00FF15}[Ayarlar]: {FFFFFF}plaka, bagajtemizle, kilometre, benzin");
	}

	new id = Car_GetID(vid);
	if (id == -1)
		return HataMesajGonder(playerid, "Geçersiz Araç ID.");

	if (!strcmp(type, "benzin", true))
	{
		new Float:miktar;

		if (sscanf(string, "f", miktar))
			return KullanimMesajGonder(playerid, "/aracduzenle [ID] [benzin] [Miktar (0.0 - 100.0)]");

		if (miktar < 0.0 || miktar > 100.0)
			return HataMesajGonder(playerid, "Geçersiz miktar girdiniz.");

		AracInfo[id][aracBenzin] = miktar;
		Arac_Kaydet(id);

		MesajGonder(playerid, "Aracýn benzin miktarý ayarlandý.");
	}

	if (!strcmp(type, "model", true))
	{
	    new model;
	    if (sscanf(string, "d", model)) return KullanimMesajGonder(playerid, "/aracduzenle [ID] [model] [Model ID]");
	    if (!IsValidVehicleModel(model)) return HataMesajGonder(playerid, "Geçersiz Model ID girdiniz.");
	    AracInfo[id][aracModel] = model;
	    Arac_Kaydet(id);
	    Arac_Spawn(id, 1);
	    MesajGonder(playerid, "Aracýn modeli deðiþtirildi ve respawn edildi.");
	}
	else if (!strcmp(type, "sahip", true))
	{
	    new sahip;
	    if (sscanf(string, "d", sahip)) return KullanimMesajGonder(playerid, "/aracduzenle [ID] [sahip] [Sahip SQL ID]");
	    AracInfo[id][aracSahip] = sahip;
	    Arac_Kaydet(id);
	    MesajGonder(playerid, "Aracýn sahibi SQL ID %d olarak ayarlandý.", sahip);
	}
	else if (!strcmp(type, "zirh", true))
	{
	    new zirh;
	    if (sscanf(string, "d", zirh)) return KullanimMesajGonder(playerid, "/aracduzenle [ID] [zirh] [Zirh]");
	    AracInfo[id][aracZirh] = zirh;
	    AracInfo[id][aracZirhVarMi] = 1;
	    Arac_Kaydet(id);
	    MesajGonder(playerid, "Aracýn zýrhýný %d olarak ayarladýnýz.", zirh);
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
				MesajGonder(playerid, "Araç kilitlendi.");
			}
			else
			{
				AracInfo[id][aracKilit] = false;
				Arac_Kaydet(id);

				PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
				SetVehicleParamsEx(AracInfo[id][aracVehicle], engine, lights, alarm, 0, bonnet, boot, objective);
				MesajGonder(playerid, "Aracýn kilidi açýldý.");
			}
	}
	else if (!strcmp(type, "vergi", true))
	{
	    new vergi;
	    if (sscanf(string, "d", vergi)) return KullanimMesajGonder(playerid, "/aracduzenle [ID] [vergi] [Vergi]");
	    AracInfo[id][aracVergi] = vergi;
	    Arac_Kaydet(id);
	    MesajGonder(playerid, "Aracýn vergisini %s olarak ayarladýnýz.", FormatNumber(vergi));
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
	    MesajGonder(playerid, "Modifiyeler kaldýrýldý.");
	}
	else if (!strcmp(type, "taksiplaka", true))
	{
	    if (AracInfo[id][TaksiPlaka] == 0)
	    {
	        AracInfo[id][TaksiPlaka] = 1;
	        MesajGonder(playerid, "Araca taksi plakasý verdiniz.");
	    }
	    else
	    {
	        AracInfo[id][TaksiPlaka] = 0;
	        MesajGonder(playerid, "Aracýn taksi plakasý kaldýrýldý.");
	    }
	    Arac_Kaydet(id);
	}
	else if (!strcmp(type, "ceza", true))
	{
	    new ceza;
	    if (sscanf(string, "d", ceza)) return KullanimMesajGonder(playerid, "/aracduzenle [ID] [ceza] [Ceza]");
	    AracInfo[id][aracTicket] = ceza;
	    Arac_Kaydet(id);
	    MesajGonder(playerid, "Aracýn cezasýný %s olarak ayarladýnýz.", FormatNumber(ceza));
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
	    if (sscanf(string, "d", kirafiyat)) return KullanimMesajGonder(playerid, "/aracduzenle [ID] [kira] [Ücret]");

		MesajGonder(playerid, "Aracýn kira fiyatýný %d olarak ayarladýnýz.", FormatNumber(kirafiyat));

		AracInfo[id][aracKira] = kirafiyat;

     	Arac_Kaydet(id);
	}
	else if (!strcmp(type, "satilik", true))
	{
	    new fiyat;
	    if (sscanf(string, "d", fiyat)) return KullanimMesajGonder(playerid, "/aracduzenle [ID] [satilik] [Fiyat] (0 yazarsanýz satýlýk olmaz)");
	    if (fiyat <= 0)
	    {
	        AracInfo[id][aracSatilik] = 0;
	        AracInfo[id][aracFiyat] = 0;
	        Arac_Kaydet(id);
	        UpdateDynamic3DTextLabelText(AracInfo[id][aracLabel], -1, " ");
	        DestroyDynamic3DTextLabel(AracInfo[id][aracLabel]);
	        MesajGonder(playerid, "Araç artýk satýlýk deðil.");
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
	 	MesajGonder(playerid, "Aracýn plakasý deðiþtirildi.");
	}
	else if (!strcmp(type, "bagajtemizle", true))
	{
	    for (new i; i<5; i++) if (AracInfo[id][aracSilahlar][i] > 0)
	    {
	        AracInfo[id][aracSilahlar][i] = 0;
	        AracInfo[id][aracMermiler][i] = 0;
	    }
	    AracInfo[id][aracUyusturucu] = 0;
	    MesajGonder(playerid, "Aracýn bagajý temizlendi.");
	}
	else if (!strcmp(type, "kilometre", true))
	{
	    new Float:km;
	    if (sscanf(string, "f", km)) return KullanimMesajGonder(playerid, "/aracduzenle [ID] [kilometre] [Kilometre]");
	    AracInfo[id][aracKM] = km;
	    Arac_Kaydet(id);
	    MesajGonder(playerid, "Aracýn kilometresi %f olarak deðiþtirildi", km);
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
	    MesajGonder(playerid, "Godmode kapatýldý.");
	}
	else
	{
 		PlayerTextDrawShow(playerid, godduty[playerid]);
	    PlayerData[playerid][pGOD] = true;
	    MesajGonder(playerid, "Godmode açýldý.");
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
        return HataMesajGonder(playerid, "Respawn için yakýnýnýzda hiçbir araç bulunmamaktadýr.");

    MesajGonder(playerid, "Yakýnýnýzda bulunan %d adet araç respawn edilmiþtir.", count);
    return 1;
}

CMD:setname(playerid, params[])
{
	static userid, newname[24];
	if (PlayerData[playerid][pAdmin] < 3) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
	if (sscanf(params, "us[24]", userid, newname)) return KullanimMesajGonder(playerid, "/setname [id/isim] [yeni isim]");
	if (!OyundaDegil(userid)) return HataMesajGonder(playerid, "Bu oyuncu giriþ yapmamýþ.");
	if (!IsValidRoleplayName(newname)) return HataMesajGonder(playerid, "Geçersiz ad biçimi girdiniz.");
	if (!IsimKontrol(newname)) return HataMesajGonder(playerid, "Bu isim kullanýlýyor.");
	if (SoyadKilitlimi(GetPlayerLastName(playerid, newname, 0))) return HataMesajGonder(playerid, "Bu soyad kilitlenmiþ.");

	MesajGonder(playerid, "%s adlý kiþinin ismini %s olarak ayarladýnýz.", Player_GetName(userid), newname);
	ChangeName(userid, newname);
	return 1;
}
CMD:namechanges(playerid, params[])
{
	new id;
    if (PlayerData[playerid][pAdmin] < 2) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
    if (sscanf(params, "u", id)) return KullanimMesajGonder(playerid, "/namechanges [ID/Isim]");
    if (!OyundaDegil(id)) return HataMesajGonder(playerid, "Bu oyuncu giriþ yapmamýþ.");
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
	if (!OyundaDegil(id)) return HataMesajGonder(playerid, "Oyuncu giriþ yapmamýþ.");
	ShowStats(playerid, id);
	return 1;
}
CMD:ahelp(playerid)
{
    if (PlayerData[playerid][pAdmin] < 1 && !PlayerData[playerid][pOyunGorevlisi] && !PlayerData[playerid][pForumGorevlisi]) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

	new str[1024];

	if(PlayerData[playerid][pForumGorevlisi] >= 1) strcat(str, "[Forum Görevlisi]: /aduty, /skick, /kick, /jail, /savepos, /loadpos, /getcar, /gotocar, /respawncar, /spawnla, /go, /get, /ojail, /unjail, /askin\n");
	if(PlayerData[playerid][pOyunGorevlisi] >= 1) strcat(str, "[Oyun Görevlisi]: /aduty, /jail, /skick, /kick, /masked, /revive, /gotopos, /savepos, /loadpos, /getcar, /gotocar, /respawncar, /spawnla, /go, /get\n/spec /specoff, /ojail, /unjail, /askin");
	if (PlayerData[playerid][pAdmin] >= 1) strcat(str, "[Game Admin]: /gotopos, /aduty, /aipcoz, /akelepcecoz, /revive, /masked, /maskeidbul, /ss, /o, /songiris, /kick, /askin\n");
	if (PlayerData[playerid][pAdmin] >= 1) strcat(str, "[Game Admin]: /dondur, /coz, /spawnla, /goto, /gethere, /setinterior, /setvw, /sendto, /sethp, /atamir, /getcar, /askin\n");
	if (PlayerData[playerid][pAdmin] >= 1) strcat(str, "[Game Admin]: /carto, /entercar, /gotocar, /respawncar, /respawncars, /cc, /spec, /jail, /unjail, /askin\n");
	if (PlayerData[playerid][pAdmin] >= 1) strcat(str, "[Game Admin]: /ojail, /ban, /banip, /unban, /oban, /stats, /listguns, /flipcar, /tracenumber, /cban, /cunban, /askin\n");
    if (PlayerData[playerid][pAdmin] >= 2) strcat(str, "[Senior Admin]: /reviveall, /setskin, /ip, /setarmor, /respawnnear, /askin\n");
    if (PlayerData[playerid][pAdmin] >= 3) strcat(str, "[High Senior Admin]: /binaekle, /setleader, /siparisler, /resetweps, /asetfaction, /asetrank, /arenk, /apaintjob, /setname, /askin\n");
    if (PlayerData[playerid][pAdmin] >= 4) strcat(str, "[Lead Admin]: /sethelper, /setstaffname, /setvip, /ozelmodelver, /ozelmodelsil, /giveweapon, /aesyaver, /setweather, /evduzenle, /askin, /15dk, /15dkkapa\n");
    if (PlayerData[playerid][pAdmin] >= 5) strcat(str, "[Management]: /setadmin, /kickall, /givecash, /givecashall, /giveexp, /giveexpall, /setplayer, /panel, /dinamikyardim, /ogyap, /fgyap, /sirketsil, /askin, /15dk, /15dkkapa\n");

    Dialog_Show(playerid, 0, DIALOG_STYLE_MSGBOX, "Admin Komutlarý", str, "Kapat", "");

	return 1;
}
CMD:dinamikyardim(playerid)
{
    if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
    SendClientMessage(playerid, COLOR_CLIENT, "DÝNAMÝK:{FFFFFF} /binaekle, /binaduzenle, /binasil, /aracolustur, /aracsil, /gateolustur, /gateduzenle, /gatesil");
    SendClientMessage(playerid, COLOR_CLIENT, "DÝNAMÝK:{FFFFFF} /garajolustur, /garajsil, /garajduzenle, /evolustur, /evsil, /evduzenle, /birlikolustur, /birliksil");
    SendClientMessage(playerid, COLOR_CLIENT, "DÝNAMÝK:{FFFFFF} /birlikduzenle, /isyeriolustur, /isyeriduzenle, /isyerisil, /createarrest, /destroyarrest, /createcctv, /deletecctv");
    SendClientMessage(playerid, COLOR_CLIENT, "DÝNAMÝK:{FFFFFF} /lokasyonekle, /lokasyonsil, /createatm, /editatm, /removeatm, /hoodolustur, /hoodsil");
    SendClientMessage(playerid, COLOR_CLIENT, "DÝNAMÝK:{FFFFFF} /pompaolustur, /pompagit, /pompaduzenle, /pompasil");
    SendClientMessage(playerid, COLOR_CLIENT, "DÝNAMÝK:{FFFFFF} /tamirolustur, /tamirgit, /tamirduzenle, /tamirsil");
	return 1;
}
CMD:hhelp(playerid)
{
	if (PlayerData[playerid][pHelper] < 1) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
	SendClientMessage(playerid, 0xDDDDDDAA, "[Lv. 1 HELPER]: /h, /tal, /helperyardim, /hduty, /spawnla, /hskin");
	if (PlayerData[playerid][pHelper] >= 2) SendClientMessage(playerid, 0xDDDDDDAA, "[Lv. 2 HELPER]: /go, /get, /savepos, /loadpos, /revive, /getcar, /gotocar, /respawncar, /hskin2");
	if (PlayerData[playerid][pHelper] >= 3) SendClientMessage(playerid, 0xDDDDDDAA, "[Lv. 3 HELPER]: /tracenumber, /hskin3");
	if (PlayerData[playerid][pHelper] >= 4) SendClientMessage(playerid, 0xDDDDDDAA, "[Lv. 4 HELPER]: /kick, /slap, /hskin4");
	if (PlayerData[playerid][pHelper] >= 5) SendClientMessage(playerid, 0xDDDDDDAA, "[Lv. 5 HELPER]: Henüz yetkiniz yok.");
	return 1;
}
CMD:dashcamlimit(playerid, params[])
{
	new limit, vehicleid;
	vehicleid = GetPlayerVehicleID(playerid);
	if (GetFactionType(playerid) != BIRLIK_LSPD)
		return HataMesajGonder(playerid, "Devlet memuru deðilsiniz.");

    if (sscanf(params, "i", limit)) return KullanimMesajGonder(playerid, "/dashcamlimit [KM/H]");

	if (!IsPlayerInAnyVehicle(playerid)) return HataMesajGonder(playerid, "Bu komutu polis araçlarýnda kullanabilirsin.");
	if (vehRadar[vehicleid] == false) return HataMesajGonder(playerid, "Ýlk önce aracýn Dashcam'ý açýk olmalýdýr.");

    if (limit < 50 || limit > 250) return HataMesajGonder(playerid, "Limit en az 50, en fazla 250 olmalýdýr.");

    vehRadarLimit[vehicleid] = limit;
	MesajGonder(playerid, "Uyarýlacak hýz seviyesi %d KM/H olarak ayarlandý.", limit);
	return 1;
}
CMD:setactorvw(playerid, params[])
{
	new acid, vw;
	if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
	if (sscanf(params, "ii", acid, vw)) return KullanimMesajGonder(playerid, "/setactorvw [Actor ID] [Vw]");
	if (!IsValidActor(acid)) return HataMesajGonder(playerid, "Geçersiz ID girdiniz.");
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
    if (!OyundaDegil(id)) return HataMesajGonder(playerid, "Oyuncu oyunda deðil.");
    PlayerDrugData[id][Drugs] += miktar;
    MesajGonder(playerid, "%s adlý kiþiye %d miktar uyuþturucu verdiniz.", ReturnName(id, 0), miktar);
	return 1;
}
CMD:test(playerid, params[])
{
	SunucuMesaji(playerid, "Verileriniz kayýt edildi.");
	Oyuncu_Kaydet(playerid);
	return 1;
}
CMD:cekilisyap(playerid, params[])
{
	new cekilisSure = -1;
	if (PlayerData[playerid][pAdmin] < 4)
        return HataMesajGonder(playerid, "Bu komutu kullanmak için yetkiniz yok!");

	if (cekilisSure > -1)
	    return HataMesajGonder(playerid, "Hali hazýrda zaten bir çekiliþ mevcut.");

	new tmp;

	if (sscanf(params, "d", tmp))
	    return BilgiMesajGonder(playerid, "/cekilisyap [Süre]");

	if (!(3 <= tmp <= 10))
	    return HataMesajGonder(playerid, "Çekiliþ süresini en az 3, en fazla 10 yapabilirsiniz.");

	MesajGonder(playerid, "Baþarýlý bir þekilde çekiliþi baþlattýnýz.");
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
		return HataMesajGonder(playerid, "Geçersiz ID girdiniz.");

	if(Pompa[id][Pompa_Kullaniliyor])
		return HataMesajGonder(playerid, "Bu pompa þu anda kullanýlýyor, silinemez.");

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

	MesajGonder(playerid, "%d ID'li pompa baþarýyla silindi.", id);
	return 1;
}

CMD:pompagit(playerid, params[])
{
    if(PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

	new id;

	if(sscanf(params, "i", id))
		return KullanimMesaji(playerid, "/pompagit [id]");

	if(!Pompa[id][Pompa_Kontrol])
		return HataMesajGonder(playerid, "Geçersiz ID girdiniz.");

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
		return HataMesajGonder(playerid, "Geçersiz ID girdiniz.");

	if(Pompa[id][Pompa_Kullaniliyor])
		return HataMesajGonder(playerid, "Bu pompa þu anda kullanýlýyor, düzenlenemez.");

	if(PlayerData[playerid][pDuzenlenenPompa] != -1)
		return HataMesajGonder(playerid, "Þu anda sistemde benzin pompasý düzenliyor olarak görünüyorsunuz.");

	PlayerData[playerid][pDuzenlenenPompa] = id;
	EditDynamicObject(playerid, Pompa[id][Pompa_Obje]);

	MesajGonder(playerid, "Lütfen pompa objesinin pozisyonunu düzenleyiniz.");
	return 1;
}

CMD:tamirgit(playerid, params[])
{
	if(PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

	new id;

	if(sscanf(params, "i", id))
		return KullanimMesaji(playerid, "/tamirgit [id]");

	if(!Tamirhane[id][Tamirhane_Kontrol])
		return HataMesajGonder(playerid, "Geçersiz ID girdiniz.");

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
		return HataMesajGonder(playerid, "Geçersiz ID girdiniz.");

	if(Tamirhane[id][Tamirhane_Kullaniliyor] == 1)
		return HataMesajGonder(playerid, "Bu tamirhane þu anda kullanýlýyor, silinemez.");

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

	MesajGonder(playerid, "%d ID'li tamirhane baþarýyla silindi.", id);
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
		return HataMesajGonder(playerid, "Geçersiz ID girdiniz.");

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

		BilgiMesajGonder(playerid, "%d ID'sine tanýmlý tamirhanenin dýþ pozisyonu bulunduðunuz konuma getirildi.", id);
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

		BilgiMesajGonder(playerid, "%d ID'sine tanýmlý tamirhanenin iç pozisyonu bulunduðunuz konuma getirildi.", id);
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
			return HataMesaji(playerid, "Girilen saniye 1'den küçük olamaz.");

		Tamirhane[id][Tamirhane_Vakit] = id;
		BilgiMesajGonder(playerid, "%d ID'sine tanýmlý tamirhanenin iþlem saniyesi %d olarak deðiþtirildi.", id, vakit);

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
        return HataMesaji(playerid, "Bu komutu kullanmak için yetkiniz yok !");

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
		return YollaJensenMesaj2(playerid, "/lyarat [label adý]");
	if(!(1 <= strlen(labeladi) <= MAX_LABEL_ADI))
		return YollaJensenMesaj2(playerid, "Labellerin adý 1 ve "#MAX_LABEL_ADI" arasýnda olmalýdýr.");

	labelid = BosLabelID();
	if(labelid == -1)
		return YollaJensenMesaj2(playerid, "Label sýnýrýna ulaþtýnýz veya farklý bir sorun var.");

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
	format(mesaj, sizeof(mesaj), "Label yarattýn ID: %d - Label Adý: %s", labelid, labeladi);
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
		YollaJensenMesaj2(playerid, "/lduzenle [label ID] [seç] [miktar]");
		YollaJensenMesaj2(playerid, "SEÇ: labeladi - pos - mesafe - renk");
		return 1;
	}
	if(!(0 <= labelid <= MAX_LABEL))
		return YollaJensenMesaj2(playerid, "Label idleri 0-"#MAX_LABEL" arasýndadýr.");

	if(fexist(LabelDosya(labelid)))
	{
		if(strcmp(secim, "labeladi", true) == 0)
		{
			if(strval(miktar) == -1)
			{
				YollaJensenMesaj2(playerid, "/lduzenle [label ID] [seçim] [deðer]");
				YollaJensenMesaj2(playerid, "SEÇ: labeladi - pos - mesafe - renk");
				return 1;
			}
			if(!(1 <= strlen(miktar) <= MAX_LABEL_ADI))
				return YollaJensenMesaj(playerid, "Labellerin adý 1 ve "#MAX_LABEL_ADI" arasýnda olmalýdýr.");
			format(mesaj, sizeof(mesaj), "[LABEL] {FFFFFF}ID: %d - Labelin adýný %s yaptýn.", labelid, miktar);
			YollaJensenMesaj(playerid, mesaj);
			strcpy(Label[labelid][LabelAdi], miktar, 90);
			UpdateDynamic3DTextLabelText(Label[labelid][ID], Label[labelid][Renk], Label[labelid][LabelAdi]);
			LabelGuncelle(labelid);
		}
		if(strcmp(secim, "pos", true) == 0)
		{
			if(!IsPlayerInRangeOfPoint(playerid, 10, Label[labelid][Pos][0], Label[labelid][Pos][1], Label[labelid][Pos][2]))
				return YollaJensenMesaj2(playerid, "Labele yakýn deðilsin.");
			if(Label[labelid][Duzenleniyor] == 1)
				return YollaJensenMesaj2(playerid, "Bu label düzenleniyor.");

			DuzenleLabelID[playerid] = labelid;
			DuzenleLabel[playerid] = true;
			Label[labelid][Duzenleniyor] = 1;
			format(mesaj, sizeof(mesaj), "[LABEL] {FFFFFF}ID: %d - Labeli düzenledin.", labelid);
			YollaJensenMesaj(playerid, mesaj);
		   	EditDynamicObject(playerid, Label[labelid][objeID]);
		}
		if(strcmp(secim, "mesafe", true) == 0)
		{
			if(strval(miktar) == -1)
			{
				YollaJensenMesaj2(playerid, "/labelduzenle [label ID] [seçim] [deðer]");
				YollaJensenMesaj2(playerid, "[SE??M]: labeladi - pos - mesafe - renk");
				return 1;
			}
			if(!(1 <= strval(miktar) <= MAX_LABEL_MESAFE))
				return YollaJensenMesaj2(playerid, "Labellerin mesafesi 1.0 ve "#MAX_LABEL_MESAFE" arasýnda olmalýdýr.");
			Label[labelid][Mesafe] = floatstr(miktar);
			format(mesaj, sizeof(mesaj), "[LABEL] {FFFFFF}ID: %d - Labelin mesafesini %f yaptýn.", labelid, Label[labelid][Mesafe]);
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
				YollaJensenMesaj2(playerid, "/labelduzenle [label ID] [seçim] [deðer]");
				YollaJensenMesaj2(playerid, "[SEÇÝM]: labeladi - pos - mesafe - renk");
				return 1;
			}
			if(strlen(miktar) != 10)
				return YollaJensenMesaj2(playerid, "Labellerin rengi Bu Þekilde olmalýdýr: 0xFFFFFFFF");

			new cikti, renk[50];
			format(renk, sizeof(renk), "%s", miktar);
			sscanf(renk, "x", cikti);
			Label[labelid][Renk] = cikti;
			format(mesaj, sizeof(mesaj), "[LABEL] {FFFFFF}ID: %d - Label rengini %s yaptýn.", labelid, renk);
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
		return YollaJensenMesaj2(playerid, "Label idleri 0-"#MAX_LABEL" arasýndadýr.");

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
		return YollaJensenMesaj2(playerid, "Label idleri 0-"#MAX_LABEL" arasýndadýr.");

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
	YollaJensenMesaj2(playerid, "Yakýnýndaki labellerin listesi;");
	for(new labelid = 0; labelid < MAX_LABEL; labelid++)
	{
		if(Label[labelid][Pos][0] >= 1)
		{
	 		if(IsPlayerInRangeOfPoint(playerid, 20, Label[labelid][Pos][0], Label[labelid][Pos][1], Label[labelid][Pos][2]))
			{
				format(mesaj, sizeof(mesaj), "Label ID: %d - Label Adý: %s", labelid, Label[labelid][LabelAdi]);
				YollaJensenMesaj(playerid, mesaj);
			}
		}
	}
	return 1;
}
