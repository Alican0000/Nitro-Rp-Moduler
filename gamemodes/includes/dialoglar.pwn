Dialog:Teamspeak(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new id = TSC_GetClientIdByIpAddress(GetIP(playerid));

		if(id < 1)
			return HataMesajGonder(playerid, "Teamspeak3 sunucusunda deðilsiniz.");

		if(strfind(inputtext, "Rahatsýz etmeyin modunu aktifleþtir", true) != -1)
		{
			TSC_AddClientToServerGroup(id, 88);
		}

		else if(strfind(inputtext, "Rahatsýz etmeyin modunu kapat", true) != -1)
		{
			TSC_RemoveClientFromServerGroup(id, 88);
		}

		else if(strfind(inputtext, "VIP odasý oluþtur", true) != -1)
		{
			new isim[90];

			format(isim, sizeof(isim), "(%d) %s", PlayerData[playerid][pID], ReturnName(playerid, 0));

			new channelid = TSC_GetChannelIdByName(isim);

			if(TSC_IsValidChannel(channelid))
				return HataMesajGonder(playerid, "Zaten bir kanalýnýz var.");

			TSC_CreateChannel(isim, PERMANENT);

			SetTimerEx("TS_GrupGonderVIP", 1000, false, "dd", playerid, 5);

			SunucuMesaji(playerid, "VIP kanalýnýz oluþturuldu.");
		}

		else if(strfind(inputtext, "Birlik odasý oluþtur", true) != -1)
		{
			new isim[90];

			format(isim, sizeof(isim), "(%d) %s", Birlikler[PlayerData[playerid][pFaction]][birlikID], Birlikler[PlayerData[playerid][pFaction]][birlikAd]);

			new channelid = TSC_GetChannelIdByName(isim);

			if(TSC_IsValidChannel(channelid))
				return HataMesajGonder(playerid, "Birliðinizin zaten bir kanalý var.");

			TSC_CreateChannel(isim, PERMANENT);

			SetTimerEx("TS_GrupGonderBirlik", 1000, false, "dd", playerid, 5);

			SunucuMesaji(playerid, "Birlik kanalýnýz oluþturuldu.");
		}
	}

	return 1;
}
Dialog:CimentoIn1(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    SunucuMesaji(playerid, "Araçtan inmekten vazgeçtiniz.");
	}
	if (!response)
	{
		HataMesaji(playerid, "Çimento mesleðiniz iptal edildi.");
		RemovePlayerFromVehicle(playerid);
		PlayerData[playerid][pCimentoTasiyor1] = 0;
	}
}

Dialog:DriftAlan(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    switch (listitem)
	    {
	        case 0:
	        {
	            SetPVarInt(playerid, "AraciniBuluyor", 1);
	            SetPlayerCheckpoint(playerid, -302.4889,1526.6858,75.3594, 5.0);
	            MesajGonder(playerid, "Drift alaný haritada iþaretlendi.");
	        }
	        case 1:
	        {
	            SetPVarInt(playerid, "AraciniBuluyor", 1);
	            SetPlayerCheckpoint(playerid, 2326.6311,1395.1903,42.5474, 5.0);
	            MesajGonder(playerid, "Drift alaný haritada iþaretlendi.");
	        }
	        case 2:
	        {
	            SetPVarInt(playerid, "AraciniBuluyor", 1);
	            SetPlayerCheckpoint(playerid, 1260.6547,-2038.4677,59.1394, 5.0);
	            MesajGonder(playerid, "Drift alaný haritada iþaretlendi.");
	        }
	        case 3:
	        {
	            SetPVarInt(playerid, "AraciniBuluyor", 1);
	            SetPlayerCheckpoint(playerid, 2227.0222,1969.2128,31.5067, 5.0);
	            MesajGonder(playerid, "Drift alaný haritada iþaretlendi.");
	        }
	    }
	}
	return 1;
}
Dialog:TaksiPlaka(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return 1;
	    if (PlayerData[playerid][pCash] < 23652) return HataMesajGonder(playerid, "Yeterli paranýz yok.");
	    new id = Car_GetID(GetPlayerVehicleID(playerid));
	    if (id == -1) return 1;
	    ParaVer(playerid, -23652);
	    AracInfo[id][TaksiPlaka] = 1;
	    Arac_Kaydet(id);
	    MesajGonder(playerid, "Araca taksi plakasý taktýnýz. (/taksi)");
	}
	return 1;
}
Dialog:AracZirhlat(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return 1;
	    if (PlayerData[playerid][pCash] < 38984) return HataMesajGonder(playerid, "Yeterli paranýz yok.");

		new id = Car_GetID(GetPlayerVehicleID(playerid));

		if (id == -1) return 1;
	    if(AracInfo[id][aracZirhVarMi] == 1)
	        return HataMesajGonder(playerid, "Bu araçta zaten zýrh var, zýrh saðlýðýný tamir ederek yenileyebilirsiniz.");

	    ParaVer(playerid, -38984);
	    AracInfo[id][aracZirhVarMi] = 1;
	    AracInfo[id][aracZirh] += 50;
	    Arac_Kaydet(id);
	    MesajGonder(playerid, "Araç zýrhlandýrýldý.");
	}
	return 1;
}
Dialog:Ciftci(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    switch (listitem)
	    {
	        case 0:
	        {
	            if (PlayerData[playerid][pCash] < 20) return HataMesajGonder(playerid, "Yeterlý paranýz bulunmamaktadýr.");
	            if (PlayerData[playerid][pTohumlar][0] >= 5) return HataMesajGonder(playerid, "En fazla 5 adet Domuz yavrusu taþýyabilirsiniz.");
	            ParaVer(playerid, -20);
	            PlayerData[playerid][pTohumlar][0]++;
	            MesajGonder(playerid, "Domuz yavrusu satýn aldýnýz.");
	        }
	        case 1:
	        {
	            if (PlayerData[playerid][pCash] < 25) return HataMesajGonder(playerid, "Yeterlý paranýz bulunmamaktadýr.");
	            if (PlayerData[playerid][pTohumlar][1] >= 5) return HataMesajGonder(playerid, "En fazla 5 adet Ayý yavrusu taþýyabilirsiniz.");
	            ParaVer(playerid, -25);
	            PlayerData[playerid][pTohumlar][1]++;
	            MesajGonder(playerid, "Ayý yavrusu satýn aldýnýz.");
	        }
	        case 2:
	        {
	            if (PlayerData[playerid][pCash] < 30) return HataMesajGonder(playerid, "Yeterlý paranýz bulunmamaktadýr.");
	            if (PlayerData[playerid][pTohumlar][2] >= 5) return HataMesajGonder(playerid, "En fazla 5 adet Kurt yavrusu taþýyabilirsiniz.");
	            ParaVer(playerid, -30);
	            PlayerData[playerid][pTohumlar][2]++;
	            MesajGonder(playerid, "Kurt yavrusu satýn aldýnýz.");
	        }
	        case 3:
	        {
	        	new vehicleid = PlayerData[playerid][pLastCar];
	    		if (GetVehicleModel(vehicleid) != 422) return HataMesajGonder(playerid, "Son bindiðiniz araç Bobcat olmalýdýr.");
				new Float:x, Float:y, Float:z;
				GetVehiclePos(vehicleid, x, y, z);
				if (GetPlayerDistanceFromPoint(playerid, x, y, z) >= 5.0) return HataMesajGonder(playerid, "Aracýnýza çok uzaksýnýz.");
	            if (AracTohumlar[vehicleid][0] <= 0 && AracTohumlar[vehicleid][1] <= 0 && AracTohumlar[vehicleid][2] <= 0) return HataMesajGonder(playerid, "Araçta hiç meyve yok.");
	            new fiyat;
	            fiyat = AracTohumlar[vehicleid][0] * 10;
	            fiyat += AracTohumlar[vehicleid][1] * 12;
	            fiyat += AracTohumlar[vehicleid][2] * 15;
	            for (new i; i<5; i++)
	            {
	                if (IsValidDynamicObject(AracTohumObjeler[vehicleid][i]))
	                {
	                    DestroyDynamicObject(AracTohumObjeler[vehicleid][i]);
	                }
	            }
	            AracTohumlar[vehicleid][0] = 0;
	            AracTohumlar[vehicleid][1] = 0;
	            AracTohumlar[vehicleid][2] = 0;
	            ParaVer(playerid, fiyat);
	            MesajGonder(playerid, "Et ve Kürkleri satarak {2ECC71}%s {FFFFFF}kazandýnýz.", FormatNumber(fiyat));
	        }
	    }
	}
	return 1;
}
Dialog:SoruEkle(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (isnull(inputtext)) return Dialog_Show(playerid,SoruEkle,DIALOG_STYLE_INPUT, "Soru Ekle", "{FFFFFF}Lütfen ekleyeceðiniz sorunun sorusunu giriniz:\n\n{FF0000}NOT: en fazla 50 karakterden oluþabilir.", "Devam", "Kapat");
	    if (strlen(inputtext) >= 50) return Dialog_Show(playerid,SoruEkle,DIALOG_STYLE_INPUT, "Soru Ekle", "{FFFFFF}Lütfen ekleyeceðiniz sorunun sorusunu giriniz:\n\n{FF0000}NOT: en fazla 50 karakterden oluþabilir.", "Devam", "Kapat");
	    SetPVarString(playerid, "Soru",inputtext);
	    Dialog_Show(playerid, SoruCevap, DIALOG_STYLE_INPUT, "Soru Ekle", "{FFFFFF}Lütfen sorunun cevabýný yazýnýz:\n\n{FF0000}NOT: en fazla 128 karakterden oluþabilir.", "Devam", "Kapat");
	}
	return 1;
}
Dialog:SoruCevap(playerid, response, listitem, inputtext[])
{
    if (response)
    {
        if (isnull(inputtext)) return Dialog_Show(playerid, SoruCevap, DIALOG_STYLE_INPUT, "Soru Ekle", "{FFFFFF}Lütfen sorunun cevabýný yazýnýz:\n\n{FF0000}NOT: en fazla 128 karakterden oluþabilir.", "Devam", "Kapat");
        if (strlen(inputtext) >= 128) return Dialog_Show(playerid, SoruCevap, DIALOG_STYLE_INPUT, "Soru Ekle", "{FFFFFF}Lütfen sorunun cevabýný yazýnýz:\n\n{FF0000}NOT: en fazla 128 karakterden oluþabilir.", "Devam", "Kapat");
        new soru[50];
        GetPVarString(playerid, "Soru",soru,sizeof(soru));
        new id = Soru_Ekle(soru ,inputtext, PlayerData[playerid][pAdminName]);
        if (id == -1) return HataMesajGonder(playerid, "Soru eklenemedi.");
        else MesajGonder(playerid, "Soru eklenmiþtir, ID: %d.", id);
        DeletePVar(playerid, "Soru");
    }
	return 1;
}
Dialog:AksesuarRenk(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    new slot = GetPVarInt(playerid, "AttachmentIndexSel");
	    if (listitem >= 0 && listitem <= 6)
	    {
	        PlayerData[playerid][pARenk][slot] = listitem+1;
	    }
	    else
	    {
	        PlayerData[playerid][pARenk][slot] = 0;
	    }
	    SQL_AksesuarKaydet(playerid);
	    AksesuarTak(playerid, slot);
	}
	return 1;
}
Dialog:Secenekler(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    switch (listitem)
	    {
	        case 0:
	        {
	            SetPVarInt(playerid, "SecenekID", 0);
	            SetPVarInt(playerid, "SecenekTur", 1);
	        }
	        case 1:
	        {
	            SetPVarInt(playerid, "SecenekID", 0);
	            SetPVarInt(playerid, "SecenekTur", 2);
	        }
	        case 2:
	        {
	            SetPVarInt(playerid, "SecenekID", 1);
	            SetPVarInt(playerid, "SecenekTur", 1);
	        }
	        case 3:
	        {
	            SetPVarInt(playerid, "SecenekID", 1);
	            SetPVarInt(playerid, "SecenekTur", 2);
	        }
	        case 4:
	        {
	            SetPVarInt(playerid, "SecenekID", 2);
	            SetPVarInt(playerid, "SecenekTur", 1);
	        }
	        case 5:
	        {
	            SetPVarInt(playerid, "SecenekID", 2);
	            SetPVarInt(playerid, "SecenekTur", 2);
	        }
	        case 6:
	        {
	            SetPVarInt(playerid, "SecenekID", 3);
	            SetPVarInt(playerid, "SecenekTur", 1);
	        }
	        case 7:
	        {
	            SetPVarInt(playerid, "SecenekID", 3);
	            SetPVarInt(playerid, "SecenekTur", 2);
	        }
	        case 8:
	        {
	            SetPVarInt(playerid, "SecenekID", 4);
	            SetPVarInt(playerid, "SecenekTur", 1);
	        }
	        case 9:
	        {
	            SetPVarInt(playerid, "SecenekID", 4);
	            SetPVarInt(playerid, "SecenekTur", 2);
	        }
	    }
	    Dialog_Show(playerid, Secenek, DIALOG_STYLE_INPUT, "Seçenek Düzenle", "{FFFFFF}Lütfen yazýyý girin:", "Ayarla", "Kapat");
	}
	return 1;
}
Dialog:NPCEtkilesim(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    new id = GetPVarInt(playerid, "NPCEtkilesimID");
	    if (id != -1)
	    {
	        SendClientMessageEx(playerid, -1, "{E74C3C}%s: {FFFFFF}%s", ReturnName(playerid, 0), NPCSecenekler[id][listitem]);
	        SendClientMessageEx(playerid, -1, "{E74C3C}%s: {FFFFFF}%s", NPCBilgi[id][npcAd], NPCSecenekCevaplar[id][listitem]);
	        SetPVarInt(playerid, "NPCEtkilesimID", -1);
	    }
	}
	return 1;
}
Dialog:AracRadyo(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return 1;
	    switch (listitem)
	    {
	        case 0:
	        {
	            new str[300];
	            for (new i; i<sizeof(Radyolar); i++)
	            {
	                format(str, sizeof(str), "%s{FFFFFF}%s\n", str, Radyolar[i][radyoAd]);
	            }
	            Dialog_Show(playerid, RadyoSec, DIALOG_STYLE_LIST, "Radyo Kanallarý", str, "Seç", "Geri");
	        }
	        case 1:
	        {
	            Dialog_Show(playerid, URLGir, DIALOG_STYLE_INPUT, "URL Gir", "Lütfen müziðin MP3 linkini girin.", "Aç", "Geri");
	        }
	        case 2:
	        {
	            StopAudioStreamForPlayer(playerid);
	            format(RadyoLink[GetPlayerVehicleID(playerid)], 128, "");
	            foreach (new i:Player) if (GetPlayerVehicleID(i) == GetPlayerVehicleID(playerid) && i != playerid)
	    		{
	        		StopAudioStreamForPlayer(i);
	    		}
	        }
		}
	}
	return 1;
}
Dialog:URLGir(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return 1;
	    if (isnull(inputtext)) return Dialog_Show(playerid, URLGir, DIALOG_STYLE_INPUT, "URL Gir", "Lütfen müziðin MP3 linkini girin.", "Aç", "Geri");
	    StopAudioStreamForPlayer(playerid);
	    PlayAudioStreamForPlayer(playerid, inputtext);
	    format(RadyoLink[GetPlayerVehicleID(playerid)], 128, inputtext);
	    foreach (new i:Player) if (GetPlayerVehicleID(i) == GetPlayerVehicleID(playerid) && i != playerid)
	    {
	        StopAudioStreamForPlayer(i);
	        PlayAudioStreamForPlayer(i, inputtext);
	    }
	}
	return 1;
}
Dialog:RadyoSec(playerid, response, listitem, inputtext[])
{
	if (!response) return callcmd::radyo(playerid);
	if (response)
	{
	    if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return 1;
	    StopAudioStreamForPlayer(playerid);
	    PlayAudioStreamForPlayer(playerid, Radyolar[listitem][radyoLink]);
	    format(RadyoLink[GetPlayerVehicleID(playerid)], 128, Radyolar[listitem][radyoLink]);
	    foreach (new i:Player) if (GetPlayerVehicleID(i) == GetPlayerVehicleID(playerid) && i != playerid)
	    {
	        StopAudioStreamForPlayer(i);
	        PlayAudioStreamForPlayer(i, Radyolar[listitem][radyoLink]);
	    }
	}
	return 1;
}
Dialog:Secenek(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (isnull(inputtext)) return Dialog_Show(playerid, Secenek, DIALOG_STYLE_INPUT, "Seçenek Düzenle", "{FFFFFF}Lütfen yazýyý girin:", "Ayarla", "Kapat");
	    if (strlen(inputtext) > 126)
	    {
	        HataMesajGonder(playerid, "Yazý çok uzun, en fazla 126 karakter girebilirsiniz.");
	        return Dialog_Show(playerid, Secenek, DIALOG_STYLE_INPUT, "Seçenek Düzenle", "{FFFFFF}Lütfen yazýyý girin:", "Ayarla", "Kapat");
	    }
	    if (GetPVarInt(playerid, "SecenekTur") == 1)
	    {
	        format(NPCSecenekler[GetPVarInt(playerid, "npcid")][GetPVarInt(playerid, "SecenekID")], 50, inputtext);
	        NPC_Secenekler(playerid, GetPVarInt(playerid, "npcid"));
	    }
	    else
	    {
	        format(NPCSecenekCevaplar[GetPVarInt(playerid, "npcid")][GetPVarInt(playerid, "SecenekID")], 200, inputtext);
	        NPC_Secenekler(playerid, GetPVarInt(playerid, "npcid"));
	    }
	}
	return 1;
}

Dialog:YatKirala(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (YatBilgi[yatKiralayan] != -1) return HataMesajGonder(playerid, "Oops! yat kiralanmýþ.");
	    if (PlayerData[playerid][pCash] < 10000) return HataMesajGonder(playerid, "Yeterli paranýz yok.");
	    ParaVer(playerid, -10000);
	    YatBilgi[yatKiralayan] = PlayerData[playerid][pID];
	    YatBilgi[yatKiraSure] = 3600;
	    SendClientMessageEx(playerid, -1, "{E74C3C}Yat Sahibi: {FFFFFF}Yatý kiraladýnýz, iyi eðlenceler.");
	}
	return 1;
}
Dialog:Ekonomi(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    switch (listitem)
	    {
	        case 0: Dialog_Show(playerid, SivilMaaslari, DIALOG_STYLE_INPUT, "Sivil Maaþý", "Lütfen yeni bir sivil maaþý girin:", "Ayarla", "Geri");
	        case 1: Dialog_Show(playerid, MaasVergi, DIALOG_STYLE_INPUT, "Maaþ Vergi", "Lütfen yeni maaþ vergisi girin:", "Ayarla", "Geri");
	        case 2: Dialog_Show(playerid, GiseUcreti, DIALOG_STYLE_INPUT, "Giþe Ücreti", "Lütfen yeni giþe ücreti girin:", "Ayarla", "Geri");
	        case 3: Dialog_Show(playerid, BenzinFiyat, DIALOG_STYLE_INPUT, "Benzin Fiyatý", "Lütfen yeni benzin fiyatý girin:", "Ayarla", "Geri");
	        case 4: Dialog_Show(playerid, TamirciUcret, DIALOG_STYLE_INPUT, "Tamirci Ücreti", "Lütfen tamirci ücretini girin:", "Ayarla", "Geri");
	    }
	}
	return 1;
}

Dialog:SivilMaaslari(playerid, response, listitem, inputtext[])
{
	if (!response) return Ekonomi_Menu(playerid);
	if (response)
	{
	    if (isnull(inputtext)) return Dialog_Show(playerid, SivilMaaslari, DIALOG_STYLE_INPUT, "Sivil Maaþý", "Lütfen yeni bir sivil maaþý girin:", "Ayarla", "Geri");
	    if (!IsNumeric(inputtext)) return Dialog_Show(playerid, SivilMaaslari, DIALOG_STYLE_INPUT, "Sivil Maaþý", "Lütfen yeni bir sivil maaþý girin:", "Ayarla", "Geri");
	    if (strval(inputtext) < 1) return Dialog_Show(playerid, SivilMaaslari, DIALOG_STYLE_INPUT, "Sivil Maaþý", "Lütfen yeni bir sivil maaþý girin:", "Ayarla", "Geri");

		SetServerBilgi("SaatlikMaas", strval(inputtext));
		MesajGonder(playerid, "Sivil maaþlarý %s olarak ayarlandý.", FormatNumber(strval(inputtext)));
		Ekonomi_Menu(playerid);
	}
	return 1;
}

Dialog:MaasVergi(playerid, response, listitem, inputtext[])
{
	if (!response) return Ekonomi_Menu(playerid);
	if (response)
	{
	    if (isnull(inputtext)) return Dialog_Show(playerid, MaasVergi, DIALOG_STYLE_INPUT, "Maaþ Vergi", "Lütfen yeni maaþ vergisi girin:", "Ayarla", "Geri");
	    if (!IsNumeric(inputtext)) return Dialog_Show(playerid, MaasVergi, DIALOG_STYLE_INPUT, "Maaþ Vergi", "Lütfen yeni maaþ vergisi girin:", "Ayarla", "Geri");
	    if (strval(inputtext) < 0) return Dialog_Show(playerid, MaasVergi, DIALOG_STYLE_INPUT, "Maaþ Vergi", "Lütfen yeni maaþ vergisi girin:", "Ayarla", "Geri");

		SetServerBilgi("MaasVergi", strval(inputtext));
		MesajGonder(playerid, "Maaþ Vergisi %s olarak ayarlandý.", FormatNumber(strval(inputtext)));
		Ekonomi_Menu(playerid);
	}
	return 1;
}

Dialog:GiseUcreti(playerid, response, listitem, inputtext[])
{
	if (!response) return Ekonomi_Menu(playerid);
	if (response)
	{
	    if (isnull(inputtext)) return Dialog_Show(playerid, GiseUcreti, DIALOG_STYLE_INPUT, "Giþe Ücreti", "Lütfen yeni giþe ücreti girin:", "Ayarla", "Geri");
	    if (!IsNumeric(inputtext)) return Dialog_Show(playerid, GiseUcreti, DIALOG_STYLE_INPUT, "Giþe Ücreti", "Lütfen yeni giþe ücreti girin:", "Ayarla", "Geri");
	    if (strval(inputtext) < 0) return Dialog_Show(playerid, GiseUcreti, DIALOG_STYLE_INPUT, "Giþe Ücreti", "Lütfen yeni giþe ücreti girin:", "Ayarla", "Geri");

		SetServerBilgi("GiseUcreti", strval(inputtext));
		MesajGonder(playerid, "Giþe Ücreti %s olarak ayarlandý.", FormatNumber(strval(inputtext)));
		Ekonomi_Menu(playerid);
	}
	return 1;
}

Dialog:BenzinFiyat(playerid, response, listitem, inputtext[])
{
	if (!response) return Ekonomi_Menu(playerid);
	if (response)
	{
	    if (isnull(inputtext)) return Dialog_Show(playerid, BenzinFiyat, DIALOG_STYLE_INPUT, "Benzin Fiyatý", "Lütfen yeni benzin fiyatý girin:", "Ayarla", "Geri");
	    if (!IsNumeric(inputtext)) return Dialog_Show(playerid, BenzinFiyat, DIALOG_STYLE_INPUT, "Benzin Fiyatý", "Lütfen yeni benzin fiyatý girin:", "Ayarla", "Geri");
	    if (strval(inputtext) < 1) return Dialog_Show(playerid, BenzinFiyat, DIALOG_STYLE_INPUT, "Benzin Fiyatý", "Lütfen yeni benzin fiyatý girin:", "Ayarla", "Geri");

		SetServerBilgi("BenzinFiyat", strval(inputtext));

		MesajGonder(playerid, "Benzin Fiyatý %s olarak ayarlandý.", FormatNumber(strval(inputtext)));

		for(new i = 0; i < MAX_POMPA; i++)
		{
			if(Pompa[i][Pompa_Kontrol])
				Pompa_Objeler(i, false);
		}

		Ekonomi_Menu(playerid);
	}
	return 1;
}

Dialog:TamirciUcret(playerid, response, listitem, inputtext[])
{
	if (!response) return Ekonomi_Menu(playerid);
	if (response)
	{
	    if (isnull(inputtext)) return Dialog_Show(playerid, TamirciUcret, DIALOG_STYLE_INPUT, "Tamirci Ücreti", "Lütfen tamirci ücretini girin:", "Ayarla", "Geri");
	    if (!IsNumeric(inputtext)) return Dialog_Show(playerid, TamirciUcret, DIALOG_STYLE_INPUT, "Tamirci Ücreti", "Lütfen tamirci ücretini girin:", "Ayarla", "Geri");
	    if (strval(inputtext) < 0) return Dialog_Show(playerid, TamirciUcret, DIALOG_STYLE_INPUT, "Tamirci Ücreti", "Lütfen tamirci ücretini girin:", "Ayarla", "Geri");

		SetServerBilgi("TamirciUcret", strval(inputtext));
		MesajGonder(playerid, "Tamirci Ücreti %s olarak ayarlandý.", FormatNumber(strval(inputtext)));
		Ekonomi_Menu(playerid);
	}
	return 1;
}

Dialog:Materyal(playerid, response, listitem, inputtext[])
{
	if (!response)
	{
	    PlayerData[playerid][pMateryalDuzenle] = -1;
	    PlayerData[playerid][pMateryalSlot] = 0;
	    MobilyaMenu(playerid, GetPVarInt(playerid, "FurnitureHouse"));
	}
	else
	{
	    if (listitem == 5)
	    {
			new id = PlayerData[playerid][pMateryalDuzenle];
			for (new i; i<5; i++) FurnitureData[GetPVarInt(playerid, "FurnitureHouse")][id][furnitureMateryalDesen][i] = 0;
			Furniture_Refresh(id, GetPVarInt(playerid, "FurnitureHouse"));
			Furniture_Save(id, GetPVarInt(playerid, "FurnitureHouse"));
			Streamer_Update(playerid, STREAMER_TYPE_OBJECT);
			MesajGonder(playerid, "Materyal slotlarý temizlendi.");
			Dialog_Show(playerid, Materyal, DIALOG_STYLE_LIST, "Materyal Slotlarý", "{FFFFFF}Materyal Slotu 1\n{FFFFFF}Materyal Slotu 2\n{FFFFFF}Materyal Slotu 3\n{FFFFFF}Materyal Slotu 4\n{FFFFFF}Materyal Slotu 5\n{E74C3C}Tüm Materyal Slotlarýný Temizle", "Seç", "Kapat");
			return 1;
	    }
	    PlayerData[playerid][pMateryalSlot] = listitem;
	    Dialog_Show(playerid, MateryalDuzenle, DIALOG_STYLE_LIST, "Materyal Düzenle", "{FFFFFF}Desen Deðiþtir\n{E74C3C}Bu Materyal Slotunu Temizle", "Seç", "Kapat");
 	}
	return 1;
}
Dialog:MateryalDuzenle(playerid, response, listitem, inputtext[])
{
	if (!response) return Dialog_Show(playerid, Materyal, DIALOG_STYLE_LIST, "Materyal Slotlarý", "{FFFFFF}Materyal Slotu 1\n{FFFFFF}Materyal Slotu 2\n{FFFFFF}Materyal Slotu 3\n{FFFFFF}Materyal Slotu 4\n{FFFFFF}Materyal Slotu 5\n{E74C3C}Tüm Materyal Slotlarýný Temizle", "Seç", "Kapat");
	if (response)
	{
	    if (listitem == 0)
	    {
		    new str[300];
		    for (new i; i<sizeof(Desenler); i++)
		    {
		        format(str, sizeof(str), "%s{FFFFFF}Desen %d\n", str, i);
		    }
		    Dialog_Show(playerid, Desenler, DIALOG_STYLE_LIST, "Desenler", str, "Seç", "Geri");
	    }
	    if (listitem == 1)
	    {
	        FurnitureData[GetPVarInt(playerid, "FurnitureHouse")][PlayerData[playerid][pMateryalDuzenle]][furnitureMateryalDesen][PlayerData[playerid][pMateryalSlot]] = 0;
	        Furniture_Refresh(PlayerData[playerid][pMateryalDuzenle], GetPVarInt(playerid, "FurnitureHouse"));
	        Furniture_Save(PlayerData[playerid][pMateryalDuzenle], GetPVarInt(playerid, "FurnitureHouse"));
	        Dialog_Show(playerid, MateryalDuzenle, DIALOG_STYLE_LIST, "Materyal Düzenle", "{FFFFFF}Desen Deðiþtir\n{E74C3C}Bu Materyal Slotunu Temizle", "Seç", "Kapat");
	    }
	}
	return 1;
}
Dialog:Desenler(playerid, response, listitem, inputtext[])
{
	if (!response) return Dialog_Show(playerid, MateryalDuzenle, DIALOG_STYLE_LIST, "Materyal Düzenle", "{FFFFFF}Desen Deðiþtir\n{E74C3C}Bu Materyal Slotunu Temizle", "Seç", "Kapat");
	if (response)
	{
	    new furid = PlayerData[playerid][pMateryalDuzenle];
	    new slot = PlayerData[playerid][pMateryalSlot];
	    FurnitureData[GetPVarInt(playerid, "FurnitureHouse")][furid][furnitureMateryalDesen][slot] = listitem+1;
	    SetDynamicObjectMaterial(FurnitureData[GetPVarInt(playerid, "FurnitureHouse")][furid][furnitureObject], slot, Desenler[listitem][model_id], Desenler[listitem][txdname], Desenler[listitem][texturename], 0);
	    Furniture_Save(furid, GetPVarInt(playerid, "FurnitureHouse"));
	    new str[300];
	    for (new i; i<sizeof(Desenler); i++)
	    {
	        format(str, sizeof(str), "%s{FFFFFF}Desen %d\n", str, i);
	    }
	    Dialog_Show(playerid, Desenler, DIALOG_STYLE_LIST, "Desenler", str, "Seç", "Geri");
	}
	return 1;
}
Dialog:MobilyaKopyala(playerid, response, listitem, inputtext[])
{
	if (!response)
	{
	    PlayerData[playerid][pSelectFurniture] = 0;
	    PlayerData[playerid][pSelectType] = 0;
	    SetPVarInt(playerid, "MobilyaKopyala", -1);
	    MobilyaMenu(playerid, GetPVarInt(playerid, "FurnitureHouse"));
	}
	else
	{
	    new id = GetPVarInt(playerid, "MobilyaKopyala");
		static Float:pos[6];

		GetDynamicObjectPos(FurnitureData[GetPVarInt(playerid, "FurnitureHouse")][id][furnitureObject], pos[0], pos[1], pos[2]);
		GetDynamicObjectRot(FurnitureData[GetPVarInt(playerid, "FurnitureHouse")][id][furnitureObject], pos[3], pos[4], pos[5]);

		new fur = Furniture_Add(GetPVarInt(playerid, "FurnitureHouse"),FurnitureData[GetPVarInt(playerid, "FurnitureHouse")][id][furnitureName],FurnitureData[GetPVarInt(playerid, "FurnitureHouse")][id][furnitureModel], pos[0], pos[1], pos[2], pos[3], pos[4], pos[5], FurnitureData[GetPVarInt(playerid, "FurnitureHouse")][id][furniturePrice]);
		if (fur == -1) return HataMesajGonder(playerid, "Sunucu maksimum mobilya limitine ulaþmýþtýr.");
		SonMobilyaID[playerid] = fur;
		for (new i; i<5; i++)
		{
		    FurnitureData[GetPVarInt(playerid, "FurnitureHouse")][fur][furnitureMateryalDesen][i] = FurnitureData[GetPVarInt(playerid, "FurnitureHouse")][id][furnitureMateryalDesen][i];
		}
		Furniture_Refresh(fur, GetPVarInt(playerid, "FurnitureHouse"));
		ParaVer(playerid,-FurnitureData[GetPVarInt(playerid, "FurnitureHouse")][id][furniturePrice]);
		PlayerData[playerid][pEditFurniture] = fur;
		PlayerData[playerid][pSelectFurniture] = 0;
	    PlayerData[playerid][pSelectType] = 0;
	    SetPVarInt(playerid, "MobilyaKopyala", -1);
		EditDynamicObject(playerid, FurnitureData[GetPVarInt(playerid, "FurnitureHouse")][fur][furnitureObject]);
		MesajGonder(playerid, "%s adlý mobilya %s karþýlýðýnda kopyalandý.",FurnitureData[GetPVarInt(playerid, "FurnitureHouse")][id][furnitureName], FormatNumber(FurnitureData[GetPVarInt(playerid, "FurnitureHouse")][id][furniturePrice]));
	}
	return 1;
}
Dialog:MobilyaSatinAl(playerid, response, listitem, inputtext[])
{
	if (!response) return MobilyaMenu(playerid, GetPVarInt(playerid, "FurnitureHouse"));
	if (response)
	{
	    if (isnull(inputtext)) return Dialog_Show(playerid, MobilyaSatinAl, DIALOG_STYLE_INPUT, "Obje ID", "Lütfen satýn almak istediðiniz objenin modelini girin:", "Al", "Geri");
	    if (!IsNumeric(inputtext)) return Dialog_Show(playerid, MobilyaSatinAl, DIALOG_STYLE_INPUT, "Obje ID", "Lütfen satýn almak istediðiniz objenin modelini girin:", "Al", "Geri");
	    if (!IsValidObjectModel(strval(inputtext)))
	    {
	        HataMesajGonder(playerid, "Geçersiz Obje ID.");
	        return Dialog_Show(playerid, MobilyaSatinAl, DIALOG_STYLE_INPUT, "Obje ID", "Lütfen satýn almak istediðiniz objenin modelini girin:", "Al", "Geri");
	    }
	    if (strval(inputtext) >= 4000)
	    {
	        HataMesajGonder(playerid, "Bu obje alýnamaz.");
	        return Dialog_Show(playerid, MobilyaSatinAl, DIALOG_STYLE_INPUT, "Obje ID", "Lütfen satýn almak istediðiniz objenin modelini girin:", "Al", "Geri");
	    }
	    static
		    Float:x,
		    Float:y,
		    Float:z,
		    Float:angle;

			GetPlayerPos(playerid, x, y, z);
   			GetPlayerFacingAngle(playerid, angle);

			x += 5.0 * floatsin(-angle, degrees);
   			y += 5.0 * floatcos(-angle, degrees);
    		new fur = Furniture_Add(GetPVarInt(playerid, "FurnitureHouse"), "Yok", strval(inputtext) ,x, y, z, 0.0, 0.0, angle,100);
    		if (fur == -1) return HataMesajGonder(playerid, "Sunucu maksimum mobilya limitine ulaþmýþtýr.");
    		SonMobilyaID[playerid] = fur;
    		ParaVer(playerid,-100);
    		PlayerData[playerid][pEditFurniture] = fur;
    		EditDynamicObject(playerid, FurnitureData[GetPVarInt(playerid, "FurnitureHouse")][fur][furnitureObject]);
    		MesajGonder(playerid, "$100 karþýlýðýnda mobilya satýn aldýnýz. Lütfen mobilyanýn yerini ayarlayýn ve kayýt tuþuna basýn.");
	}
	return 1;
}
Dialog:Mobilya(playerid, response, listitem, inputtext[])
{
	if (!response) return SetPVarInt(playerid, "FurnitureHouse", -1);
	if (response)
	{
	    new id = GetPVarInt(playerid, "FurnitureHouse");
	    switch (listitem)
	    {
	        case 0:
	        {
			    new str[1200];
		   		if (Ev_MobilyaSayisi(id) >= GetMaxFurniture(playerid, id)) return HataMesajGonder(playerid, "Bu eve daha fazla mobilya alýnamaz.");
		   		for (new i = 0; i < sizeof(g_aFurnitureTypes); i ++)
		     	{
		      		format(str,sizeof(str), "%s{FFFFFF}%s\n",str,g_aFurnitureTypes[i]);
		      	}
				Dialog_Show(playerid,MobilyaTipleri,DIALOG_STYLE_LIST, "Mobilyalar",str, "Seç", "Kapat");
	        }
	        case 1:
	        {
	            if (Ev_MobilyaSayisi(id) >= GetMaxFurniture(playerid, id)) return HataMesajGonder(playerid, "Bu eve daha fazla mobilya alýnamaz.");
	            Dialog_Show(playerid, MobilyaSatinAl, DIALOG_STYLE_INPUT, "Obje ID", "Lütfen satýn almak istediðiniz objenin modelini girin:", "Al", "Geri");
	        }
	        case 2:
	        {
	            PlayerData[playerid][pSelectFurniture] = 1;
	            PlayerData[playerid][pSelectType] = 1;
	            SelectObject(playerid);
	            MesajGonder(playerid, "Lütfen düzenlemek istediðiniz mobilyaya týklayýn.");
	        }
	        case 3:
	        {
	            PlayerData[playerid][pSelectFurniture] = 1;
	            PlayerData[playerid][pSelectType] = 2;
	            SelectObject(playerid);
	            MesajGonder(playerid, "Lütfen satmak istediðiniz mobilyaya týklayýn.");
	        }
	        case 4:
	        {
	            if (Ev_MobilyaSayisi(id) >= GetMaxFurniture(playerid, id)) return HataMesajGonder(playerid, "Bu eve daha fazla mobilya alýnamaz.");
	            PlayerData[playerid][pSelectFurniture] = 1;
	            PlayerData[playerid][pSelectType] = 3;
	            SelectObject(playerid);
	            MesajGonder(playerid, "Lütfen kopyalamak istediðiniz mobilyaya týklayýn.");
	        }
	        case 5:
	        {
	            PlayerData[playerid][pSelectFurniture] = 1;
	            PlayerData[playerid][pSelectType] = 4;
	            SelectObject(playerid);
	            MesajGonder(playerid, "Lütfen materyallerini düzenlemek istediðiniz mobilyaya týklayýn.");
	        }
	        case 6:
	        {
	            new furid = SonMobilyaID[playerid];
	            if (furid == -1) return HataMesajGonder(playerid, "Son eklediðiniz mobilya yok.");
	            if (!Iter_Contains(Mobilyalar[GetPVarInt(playerid, "FurnitureHouse")], furid))
	            {
	                HataMesajGonder(playerid, "Son eklediðiniz mobilya yok.");
	                return MobilyaMenu(playerid, GetPVarInt(playerid, "FurnitureHouse"));
	            }
	            Furniture_Delete(furid, GetPVarInt(playerid, "FurnitureHouse"));
	            SonMobilyaID[playerid] = -1;
	            MesajGonder(playerid, "Son eklediðiniz mobilya silindi.");
	            MobilyaMenu(playerid, GetPVarInt(playerid, "FurnitureHouse"));
	        }
	        case 7:
	        {
	            new hid = House_Inside(playerid);
	            if (hid == -1) return SetPVarInt(playerid, "FurnitureHouse", -1);
	            if (HouseInfo[hid][evSahip] != PlayerData[playerid][pID])
	            {
	                HataMesajGonder(playerid, "Mobilya düzenleme yetkisini sadece ev sahibi verebilir.");
	                return MobilyaMenu(playerid, GetPVarInt(playerid, "FurnitureHouse"));
	            }
	            Dialog_Show(playerid, MobilyaYetkilendirme, DIALOG_STYLE_INPUT, "Mobilya Yetkilendirme", "{FFFFFF}Lütfen mobilya düzenleme yetkisi vereceðiniz kiþinin ID'sini girin (-1 yazarsanýz yetkiler silinir)", "Tamam", "Geri");
	        }
	        case 8:
	        {
	            new hid = House_Inside(playerid);
	            if (hid == -1) return SetPVarInt(playerid, "FurnitureHouse", -1);
	            SetPlayerInterior(playerid, HouseInteriors[ HouseInfo[hid][evInterior] ][intID]);
  				SetPlayerPos(playerid, HouseInteriors[HouseInfo[hid][evInterior] ][intX], HouseInteriors[ HouseInfo[hid][evInterior] ][intY], HouseInteriors[ HouseInfo[hid][evInterior] ][intZ]);
          		SetPlayerVirtualWorld(playerid,HouseInfo[hid][evID]+1);
            	SetPVarInt(playerid, "FurnitureHouse", -1);
	        }
	        case 9:
	        {
             	new hid = GetPVarInt(playerid, "FurnitureHouse");
	            if (hid == -1) return 1;
	            if (HouseInfo[hid][evSahip] != PlayerData[playerid][pID]) return HataMesajGonder(playerid, "Tüm mobilyalarý sadece ev sahibi satabilir.");
	            if (Ev_MobilyaSayisi(hid) <= 0) return HataMesajGonder(playerid, "Hiç mobilya yok.");
	            Dialog_Show(playerid, MobilyalariSat, DIALOG_STYLE_MSGBOX, "Mobilyalarý Sat", "{FFFFFF}%d adet mobilyayý {2ECC71}%s {FFFFFF}karþýlýðýnda satmak istiyor musunuz?", "Sat", "Iptal", Ev_MobilyaSayisi(hid), FormatNumber(Ev_MobilyaFiyat(hid)));
	        }
	    }
	}
	return 1;
}

// Deðiþti
Dialog:MobilyalariSat(playerid, response, listitem, inputtext[])
{
	if (!response) return MobilyaMenu(playerid, GetPVarInt(playerid, "FurnitureHouse"));
	if (response)
	{
	    new id = GetPVarInt(playerid, "FurnitureHouse");
	    ParaVer(playerid, Ev_MobilyaFiyat(id));
	    MesajGonder(playerid, "Mobilyalar satýldý. (%s)", FormatNumber(Ev_MobilyaFiyat(id)));
	    SetPVarInt(playerid, "FurnitureHouse", -1);
	    House_RemoveFurniture(id);
	}
	return 1;
}
//
Dialog:MobilyaYetkilendirme(playerid, response, listitem, inputtext[])
{
	if (!response) return MobilyaMenu(playerid, GetPVarInt(playerid, "FurnitureHouse"));
	if (response)
	{
	    new evid = House_Inside(playerid);
	    if (isnull(inputtext)) return Dialog_Show(playerid, MobilyaYetkilendirme, DIALOG_STYLE_INPUT, "Mobilya Yetkilendirme", "{FFFFFF}Lütfen mobilya düzenleme yetkisi vereceðiniz kiþinin ID'sini girin (-1 yazarsanýz yetkiler silinir)", "Tamam", "Geri");
	    if (!IsNumeric(inputtext)) return Dialog_Show(playerid, MobilyaYetkilendirme, DIALOG_STYLE_INPUT, "Mobilya Yetkilendirme", "{FFFFFF}Lütfen mobilya düzenleme yetkisi vereceðiniz kiþinin ID'sini girin (-1 yazarsanýz yetkiler silinir)", "Tamam", "Geri");
	    new oyuncuid = strval(inputtext);
	    if (oyuncuid >= 0 && !OyundaDegil(oyuncuid))
		{
		    HataMesajGonder(playerid, "Geçersiz ID girdiniz.");
		    return Dialog_Show(playerid, MobilyaYetkilendirme, DIALOG_STYLE_INPUT, "Mobilya Yetkilendirme", "{FFFFFF}Lütfen mobilya düzenleme yetkisi vereceðiniz kiþinin ID'sini girin (-1 yazarsanýz yetkiler silinir)", "Tamam", "Geri");
		}
		if (oyuncuid >= 0 && !IsPlayerNearPlayer(playerid, oyuncuid, 15.0))
		{
		    HataMesajGonder(playerid, "Kiþiye yeterince yakýn deðilsiniz.");
		    return Dialog_Show(playerid, MobilyaYetkilendirme, DIALOG_STYLE_INPUT, "Mobilya Yetkilendirme", "{FFFFFF}Lütfen mobilya düzenleme yetkisi vereceðiniz kiþinin ID'sini girin (-1 yazarsanýz yetkiler silinir)", "Tamam", "Geri");
		}
	    if (oyuncuid == playerid)
	    {
	        HataMesajGonder(playerid, "Kendi ID'ni yazamazsýn.");
	        return Dialog_Show(playerid, MobilyaYetkilendirme, DIALOG_STYLE_INPUT, "Mobilya Yetkilendirme", "{FFFFFF}Lütfen mobilya düzenleme yetkisi vereceðiniz kiþinin ID'sini girin (-1 yazarsanýz yetkiler silinir)", "Tamam", "Geri");
	    }
	    if (oyuncuid == -1)
	    {
	        HouseInfo[evid][MobilyaYetki] = -1;
	        MesajGonder(playerid, "Mobilya yetkisi kaldýrýldý.");
	        MobilyaMenu(playerid, evid);
	    }
	    else
	    {
		 	HouseInfo[evid][MobilyaYetki] = PlayerData[oyuncuid][pID];
		 	MesajGonder(playerid, "%s adlý kiþiye mobilya düzenleme yetkisi verdiniz.", ReturnName(oyuncuid, 0));
		 	MobilyaMenu(playerid, evid);
	    }
	}
	return 1;
}
Dialog:BakimModu(playerid, response, listitem, inputtext[])
{
	if (!response) return Kick(playerid);
	if (response)
	{
	    if (isnull(inputtext)) return Dialog_Show(playerid, BakimModu, DIALOG_STYLE_INPUT, "Bakým", "Sunucumuz bakým modundadýr, giriþ yapmak için bakým þifresini girin:", "Gir", "Kapat");
	    if (strcmp(inputtext, GetServerBilgiStr("bakimSifre"), false) == 0)
	    {
	        TextDrawShowForPlayer(playerid, GirisTD);
			SetTimerEx("Giris_Yap",2500,false, "i",playerid);
	    }
	    else
	    {
	        HataMesajGonder(playerid, "Geçersiz þifre.");
	        return Dialog_Show(playerid, BakimModu, DIALOG_STYLE_INPUT, "Bakým", "Sunucumuz bakým modundadýr, giriþ yapmak için bakým þifresini girin:", "Gir", "Kapat");
	    }
	}
	return 1;
}
Dialog:SilahTuccari(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (listitem == 0)
	    {
	        new string[500];
	        for (new i; i<sizeof(SilahFiyatlar); i++)
	        {
	            format(string, sizeof(string), "%s{AFAFAF}» {FFFFFF}%s\t{33AA33}%s\n", string, SilahFiyatlar[i][silahAdi], FormatNumber(SilahFiyatlar[i][silahFiyat]));
			}
			Dialog_Show(playerid, Silahlar, DIALOG_STYLE_TABLIST, "Silahlar", string, "Satýn Al", "Geri");
		}
		if (listitem == 1)
		{
		    if (!GetWeapon(playerid)) return HataMesajGonder(playerid, "Elinizde silah yok.");
		    if (GetWeapon(playerid) <= 18 || GetWeapon(playerid) == 23 || GetWeapon(playerid) == 26 || GetWeapon(playerid) == 27 || GetWeapon(playerid) == 32 || GetWeapon(playerid) >= 34 ) return HataMesajGonder(playerid, "Elinizde bulunan silaha mermi satmýyoruz.");
		    if (GetMermiFiyat(GetWeapon(playerid)) > PlayerData[playerid][pCash]) return HataMesajGonder(playerid, "Mermi satýn almak için yeterli paranýz yok. (%s)", FormatNumber(GetMermiFiyat(GetWeapon(playerid))));
		    Dialog_Show(playerid, MermiAl, DIALOG_STYLE_MSGBOX, "Mermi Al", "{f44242}%s {FFFFFF}model silaha mermi almak için {0ef416}%s {FFFFFF}ödemelisin. Almak ister misin?", "Evet", "Hayýr", ReturnWeaponName(GetWeapon(playerid)), FormatNumber(GetMermiFiyat(GetWeapon(playerid))));
		}
		if (listitem == 2)
		{
			if (PlayerData[playerid][pEsyalar][13] >= 1) return HataMesajGonder(playerid, "Üzerinizde en fazla 1 þarjör bulundurabilirsiniz.");
			if (PlayerData[playerid][pCash] < 500) return HataMesajGonder(playerid, "Yeterli paranýz yok. ($500)");
			PlayerData[playerid][pEsyalar][13]++;
			ParaVer(playerid, -500);
			MesajGonder(playerid, "Þarjör satýn alýndý, (/silahlarim) komutu ile silahýnýza þarjör takabilirsiniz.");
		}
	}
	return 1;
}
Dialog:MermiAl(playerid, response, listitem, inputtext[])
{
	if(response)
	{
	    if (!GetWeapon(playerid)) return HataMesajGonder(playerid, "Elinizde silah yok.");
	    if (GetWeapon(playerid) <= 18 || GetWeapon(playerid) == 23 || GetWeapon(playerid) == 26 || GetWeapon(playerid) == 27 || GetWeapon(playerid) == 32 || GetWeapon(playerid) >= 34 ) return HataMesajGonder(playerid, "Elinizde bulunan silaha mermi satmýyoruz.");
		if (GetMermiFiyat(GetWeapon(playerid)) > PlayerData[playerid][pCash]) return HataMesajGonder(playerid, "Mermi satýn almak için yeterli paranýz yok. (%s)", FormatNumber(GetMermiFiyat(GetWeapon(playerid))));

	    new silahid = GetWeapon(playerid);

	    ResetWeapon(playerid, silahid);
	    GiveWeaponToPlayer(playerid, silahid, GetMaksAmmo(silahid));
	    ParaVer(playerid, -GetMermiFiyat(GetWeapon(playerid)));
	}
	return 1;
}

Dialog:Silahlar(playerid, response, listitem, inputtext[])
{
	if (!response) return Dialog_Show(playerid, SilahTuccari, DIALOG_STYLE_LIST, "Silah/Mermi Tüccarý", "{AFAFAF}» {FFFFFF}Silah Satýn Al\n{AFAFAF}» {FFFFFF}Mermi Satýn Al\n{AFAFAF}» {FFFFFF}Þarjör Satýn Al", "Seç", "Kapat");
	if (response)
	{
	    new id = PlayerData[playerid][pFaction];
	    if (id == -1 || Birlikler[id][birlikOnaylar][1] == 0) return HataMesajGonder(playerid, "Silah onaylý bir birliðin üyesi deðilsiniz.");
	    if (PlayerData[playerid][pLevel] < 7) return HataMesajGonder(playerid, "En az 7 seviye olmalýsýnýz.");
	    if (PlayerData[playerid][pSilahAlmaSayisi] >= 2 && PlayerData[playerid][pSilahAlma] >= gettime()) return HataMesajGonder(playerid, "24 saatte en fazla 2 silah alabilirsiniz.");
	    if (PlayerData[playerid][pCash] < SilahFiyatlar[listitem][silahFiyat]) return HataMesajGonder(playerid, "Bu silahý satýn alabilmek için yeterli paranýz yok.");
	    if (PlayerHasWeapon(playerid, SilahFiyatlar[listitem][silahID])) return HataMesajGonder(playerid, "Zaten bu silaha sahipsiniz.");
	    if (PlayerData[playerid][pSilahlar][g_aWeaponSlots[SilahFiyatlar[listitem][silahID]]] != 0) return HataMesajGonder(playerid, "Bu silah türü sizde bulunuyor.");
	    PlayerData[playerid][pSilahAlmaSayisi]++;
	    if (PlayerData[playerid][pSilahAlmaSayisi] >= 2) PlayerData[playerid][pSilahAlma] = gettime()+1*86400;
	    ParaVer(playerid, -SilahFiyatlar[listitem][silahFiyat]);
	    GiveWeaponToPlayer(playerid, SilahFiyatlar[listitem][silahID], SilahFiyatlar[listitem][silahMermi]);
	}
	return 1;
}
Dialog:BarbekuYemek(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (isnull(inputtext)) return Dialog_Show(playerid, BarbekuYemek, DIALOG_STYLE_INPUT, "Barbekü", "{ff0000}» {FFFFFF}Yemeði vermek istediðiniz oyuncunun ID'sini girin (Kendi ID'nizi yazarsanýz siz yersiniz ID: %d):", "Ver", "Kapat", playerid);
	    if (!IsNumeric(inputtext)) return Dialog_Show(playerid, BarbekuYemek, DIALOG_STYLE_INPUT, "Barbekü", "{ff0000}» {FFFFFF}Yemeði vermek istediðiniz oyuncunun ID'sini girin (Kendi ID'nizi yazarsanýz siz yersiniz ID: %d):", "Ver", "Kapat", playerid);
	    new id = strval(inputtext);
	    if (!OyundaDegil(id))
	    {
	        HataMesajGonder(playerid, "Oyuncu oyunda deðil.");
	        return Dialog_Show(playerid, BarbekuYemek, DIALOG_STYLE_INPUT, "Barbekü", "{ff0000}» {FFFFFF}Yemeði vermek istediðiniz oyuncunun ID'sini girin (Kendi ID'nizi yazarsanýz siz yersiniz ID: %d):", "Ver", "Kapat", playerid);
	    }
	    if (!IsPlayerNearPlayer(playerid, id, 5.0))
	    {
	        HataMesajGonder(playerid, "Kiþiye yeterince yakýn deðilsiniz.");
	        return Dialog_Show(playerid, BarbekuYemek, DIALOG_STYLE_INPUT, "Barbekü", "{ff0000}» {FFFFFF}Yemeði vermek istediðiniz oyuncunun ID'sini girin (Kendi ID'nizi yazarsanýz siz yersiniz ID: %d):", "Ver", "Kapat", playerid);
	    }
	    new yemekid = GetPVarInt(playerid, "PisirilenYemek");
	    ApplyAnimation(id, "FOOD", "EAT_Burger",4.1,0,1,1,0,0);
	    ApplyAnimation(id, "FOOD", "EAT_Burger",4.1,0,1,1,0,0);
		if (id == playerid)
		{
		    MesajGonder(id, "Barbekü de piþirdiðiniz yemeði yediniz.");
		    if (yemekid == 1) SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "* %s barbekü de piþirdiði Köfteyi yemeye baþlar.", ReturnName(playerid, 0));
		    if (yemekid == 2) SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "* %s barbekü de piþirdiði Tavuk etini yemeye baþlar.", ReturnName(playerid, 0));
		    if (yemekid == 3) SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "* %s barbekü de piþirdiði Dana etini yemeye baþlar.", ReturnName(playerid, 0));
		}
		else
		{
		    if (yemekid == 1) SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "* %s barbekü de piþirdiði Köfteyi %s adlý kiþiye verir.", ReturnName(playerid, 0), ReturnName(id, 0));
		    if (yemekid == 2) SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "* %s barbekü de piþirdiði Tavuk etini %s adlý kiþiye verir.", ReturnName(playerid, 0), ReturnName(id, 0));
		    if (yemekid == 3) SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "* %s barbekü de piþirdiði Dana etini %s adlý kiþiye verir.", ReturnName(playerid, 0), ReturnName(id, 0));
		}
		DeletePVar(playerid, "PisirilenYemek");
	}
	return 1;
}
Dialog:BarbekuPisir(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    switch (listitem)
	    {
	        case 0:
	        {
	            if (PlayerData[playerid][pEsyalar][7] <= 0) return HataMesajGonder(playerid, "Hiç köfteniz yok.");
	            PlayerData[playerid][pEsyalar][7]--;
	            PlayerData[playerid][pYemekPisiriliyor] = 15;
	            PlayerData[playerid][pPisirilenYemek] = 1;

	            MesajGonder(playerid, "Köfte 15 saniye sonra piþecek.");
	        }
	        case 1:
	        {
	            if (PlayerData[playerid][pEsyalar][8] <= 0) return HataMesajGonder(playerid, "Hiç tavuk etiniz yok.");
	            PlayerData[playerid][pEsyalar][8]--;
	            PlayerData[playerid][pYemekPisiriliyor] = 15;
	            PlayerData[playerid][pPisirilenYemek] = 2;

	            MesajGonder(playerid, "Tavuk eti 15 saniye sonra piþecek.");
	        }
	        case 2:
	        {
	            if (PlayerData[playerid][pEsyalar][9] <= 0) return HataMesajGonder(playerid, "Hiç dana etiniz yok.");
	            PlayerData[playerid][pEsyalar][9]--;
	            PlayerData[playerid][pYemekPisiriliyor] = 15;
	            PlayerData[playerid][pPisirilenYemek] = 3;

	            MesajGonder(playerid, "Dana eti 15 saniye sonra piþecek.");
	        }
	    }
	}
	return 1;
}

Dialog:Yaralilar(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    new id = GetPlayerID(inputtext);

		if (id != -1 && PlayerData[id][pBaygin] == 1)
	    {
	        if (EMSAccepted(id) != INVALID_PLAYER_ID) return HataMesajGonder(playerid, "Bu kiþinin çaðrýsý %s tarafýndan kabul edildi.", ReturnName(EMSAccepted(id), 0));
	        new Float:pos[3];
	        GetPlayerPosEx(id, pos[0], pos[1], pos[2]);
	        DisablePlayerCheckpoint(playerid);
	        callcmd::cpsifirla(playerid);

	        SetPlayerCheckpoint(playerid, pos[0], pos[1], pos[2], 7.0);
	        EMSKabul[playerid] = id;
	        MesajGonder(playerid, "%s adlý kiþinin yeri haritada iþaretlendi.", ReturnName(id, 0));

			MesajGonder(id, "%s adlý kiþi ambulans çaðrýný kabul etti.", ReturnName(playerid, 0));
	    }
	}
	return 1;
}

Dialog:OyuncuAnahtar(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    SetPVarInt(playerid, "KeyDeleteSqlID", KeyListeleme[playerid][listitem]);
	    SetPVarInt(playerid, "KeyDeleteTip", KeyListelemeTip[playerid][listitem]);
	    Dialog_Show(playerid, AnahtarSilOnay, DIALOG_STYLE_MSGBOX, "Anahtar Sil - Onay", "{FFFFFF}Seçtiðiniz anahtar {FF0000}silinecek{FFFFFF}, onaylýyor musunuz?", "Onayla", "Iptal");
	}
	return 1;
}
Dialog:AnahtarSilOnay(playerid, response, listitem, inputtext[])
{
	if (!response)
	{
	    DeletePVar(playerid, "KeyDeleteSqlID");
	    DeletePVar(playerid, "KeyDeleteTip");
	    callcmd::anahtarlarim(playerid);
	}
	else
	{
	    new query[124];
	    format(query, sizeof(query), "DELETE FROM `anahtarlar` WHERE `playersqlid` = '%d' AND `sqlid` = '%d' AND `tip` = '%d'", PlayerData[playerid][pID],GetPVarInt(playerid, "KeyDeleteSqlID"),GetPVarInt(playerid, "KeyDeleteTip"));
	    mysql_query(g_SQL, query, false);
	    MesajGonder(playerid, "Anahtar baþarýyla silindi.");
	    DeletePVar(playerid, "KeyDeleteSqlID");
	    DeletePVar(playerid, "KeyDeleteTip");
	    callcmd::anahtarlarim(playerid);

	}
	return 1;
}
Dialog:AracAnahtarlar(playerid, response, listitem, inputtext[])
{
	if (!response) return callcmd::arac(playerid);
	if (response)
	{
	    if (listitem > MAX_CAR_KEYS) return callcmd::arac(playerid);
	    new query[150];
	    format(query, sizeof(query), "DELETE FROM `anahtarlar` WHERE `playersqlid` = '%d' AND `sqlid` = '%d' AND `tip` = '2'", KeyListeleme[playerid][listitem], AracInfo[GetPVarInt(playerid, "KeyDeleteCarID")][aracID]);
	    mysql_query(g_SQL, query, false);
	    foreach (new i:Player)
	    {
	        if (PlayerData[i][pID] == KeyListeleme[playerid][listitem])
	        {
	            SunucuMesaji(i, "%s adlý kiþi tarafýndan %s model aracýn anahtarý geri alýndý.", ReturnName(playerid, 0), ReturnVehicleModelName(AracInfo[ GetPVarInt(playerid, "KeyDeleteCarID")][aracModel]));
	        }
	    }
	    MesajGonder(playerid, "%s adlý kiþinin anahtarý geri alýndý.", SQLName(KeyListeleme[playerid][listitem], 0));
	    Arac_KeyDialog(playerid, GetPVarInt(playerid, "KeyDeleteCarID"));
	}
	return 1;
}
Dialog:EvAnahtarlar(playerid, response, listitem, inputtext[])
{
	if (!response) return callcmd::ev(playerid);
	if (response)
	{
	    if (listitem > MAX_HOUSE_KEYS) return callcmd::ev(playerid);
	    new query[150];
	    format(query, sizeof(query), "DELETE FROM `anahtarlar` WHERE `playersqlid` = '%d' AND `sqlid` = '%d' AND `tip` = '1'", KeyListeleme[playerid][listitem], HouseInfo[GetPVarInt(playerid, "KeyDeleteHouseID")][evID]);
	    mysql_query(g_SQL, query, false);
	    foreach (new i:Player)
	    {
	        if (PlayerData[i][pID] == KeyListeleme[playerid][listitem])
	        {
	            //Iter_Remove(EvAnahtarlar[i], GetPVarInt(playerid, "KeyDeleteHouseID"));
	            SunucuMesaji(i, "%s adlý kiþi tarafýndan %d ID'li evin anahtarý geri alýndý.", ReturnName(playerid, 0), GetPVarInt(playerid, "KeyDeleteHouseID"));
	        }
	    }
	    MesajGonder(playerid, "%s adlý kiþinin anahtarý geri alýndý.", SQLName(KeyListeleme[playerid][listitem], 0));
	    Ev_KeyDialog(playerid, GetPVarInt(playerid, "KeyDeleteHouseID"));
	}
	return 1;
}
Dialog:AnahtarVer(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    new str[1000], string[124],sayi = 0;
	    if (listitem == 0)
	    {
	        strcat(str, "{C8C8C8}ID\t{C8C8C8}Ev Adý\n");
			for (new i; i<MAX_EV; i++)
			{
			    if (HouseInfo[i][evExists])
			    {
			        if (HouseInfo[i][evSahip] == PlayerData[playerid][pID])
			        {
			            sayi++;
			            format(string, sizeof(string), "{FFFFFF}%d\t{FFFFFF}%s\n", i, HouseInfo[i][evIsim]);
			            strcat(str, string);
			        }
			    }
			}
   			if (sayi == 0) return HataMesajGonder(playerid, "Hiç eviniz yok.");
			Dialog_Show(playerid, SelectHouse, DIALOG_STYLE_TABLIST_HEADERS, "{FFC100}Evleriniz", str, "Seç", "Geri");
	    }
	    if (listitem == 1)
	    {
	        strcat(str, "{C8C8C8}ID\t{C8C8C8}Model\t{C8C8C8}Plaka\n");
	        for (new i; i<MAX_ARAC; i++)
	        {
	            if (AracInfo[i][aracExists])
	            {
	                if (AracInfo[i][aracSahip] == PlayerData[playerid][pID])
	                {
	                    sayi++;
	                    format(string, sizeof(string), "{FFFFFF}%d\t{FFFFFF}%s\t{FFFFFF}%s\n", i, ReturnVehicleModelName(AracInfo[i][aracModel]), AracInfo[i][aracPlaka]);
	                    strcat(str, string);
	                }
	            }
	        }
	        if (sayi == 0) return HataMesajGonder(playerid, "Hiç aracýnýz yok.");
	        Dialog_Show(playerid, SelectCar, DIALOG_STYLE_TABLIST_HEADERS, "{FFC100}Araçlarýnýz", str, "Seç", "Geri");
	    }
	}
	return 1;
}
Dialog:SelectCar(playerid, response, listitem, inputtext[])
{
	if (!response) return callcmd::anahtarver(playerid);
	if (response)
	{
	    new carid = strval(inputtext);
	    if (AracInfo[carid][aracExists])
	    {
	        if (AracInfo[carid][aracModel] == 509) return HataMesajGonder(playerid, "Bu aracýn anahtarýný veremezsiniz.");
   			if (Arac_GetKeyCount(carid) >= MAX_CAR_KEYS) return HataMesajGonder(playerid, "Maksimum %d anahtar verebilirsiniz.", MAX_CAR_KEYS);
	        SetPVarInt(playerid, "GiveKeyCarID", carid);
	        Dialog_Show(playerid, EnterPlayerID2, DIALOG_STYLE_INPUT, "Oyuncu ID", "{FFFFFF}Lütfen anahtarý vermek istediðiniz oyuncunun ID'sini girin:", "Ver", "Kapat");
	    }
	}
	return 1;
}
Dialog:SelectHouse(playerid, response, listitem, inputtext[])
{
	if (!response) return callcmd::anahtarver(playerid);
	if (response)
	{
	    new evid = strval(inputtext);
	    if (HouseInfo[evid][evExists])
	    {
   			if (Ev_GetKeyCount(evid) >= MAX_HOUSE_KEYS) return HataMesajGonder(playerid, "Maksimum %d anahtar verebilirsiniz.", MAX_HOUSE_KEYS);
	        SetPVarInt(playerid, "GiveKeyHouseID", evid);
	        Dialog_Show(playerid, EnterPlayerID, DIALOG_STYLE_INPUT, "Oyuncu ID", "{FFFFFF}Lütfen anahtarý vermek istediðiniz oyuncunun ID'sini girin:", "Ver", "Kapat");
	    }
	}
	return 1;
}
Dialog:EnterPlayerID(playerid, response, listitem, inputtext[])
{
	if (!response) return DeletePVar(playerid, "GiveKeyHouseID");
	if (response)
	{
	    if (isnull(inputtext)) return Dialog_Show(playerid, EnterPlayerID, DIALOG_STYLE_INPUT, "Oyuncu ID", "{FFFFFF}Lütfen anahtarý vermek istediðiniz oyuncunun ID'sini girin:", "Ver", "Kapat");
	    if (!IsNumeric(inputtext)) return Dialog_Show(playerid, EnterPlayerID, DIALOG_STYLE_INPUT, "Oyuncu ID", "{FFFFFF}Lütfen anahtarý vermek istediðiniz oyuncunun ID'sini girin:", "Ver", "Kapat");
	    if (!OyundaDegil(strval(inputtext)))
	    {
	        HataMesajGonder(playerid, "Oyuncu oyunda deðil.");
	        return Dialog_Show(playerid, EnterPlayerID, DIALOG_STYLE_INPUT, "Oyuncu ID", "{FFFFFF}Lütfen anahtarý vermek istediðiniz oyuncunun ID'sini girin:", "Ver", "Kapat");
		}
		if (strval(inputtext) == playerid)
		{
		    HataMesajGonder(playerid, "Kendi kendine anahtar veremezsiniz.");
		    return Dialog_Show(playerid, EnterPlayerID, DIALOG_STYLE_INPUT, "Oyuncu ID", "{FFFFFF}Lütfen anahtarý vermek istediðiniz oyuncunun ID'sini girin:", "Ver", "Kapat");
		}
		if (!IsPlayerNearPlayer(playerid, strval(inputtext), 5.0))
		{
		    HataMesajGonder(playerid, "Kiþiye yeterince yakýn deðilsiniz.");
		    return Dialog_Show(playerid, EnterPlayerID, DIALOG_STYLE_INPUT, "Oyuncu ID", "{FFFFFF}Lütfen anahtarý vermek istediðiniz oyuncunun ID'sini girin:", "Ver", "Kapat");
		}
		if (HouseInfo[GetPVarInt(playerid, "GiveKeyHouseID")][evKiralayan] == PlayerData[strval(inputtext)][pID])
		{
		    HataMesajGonder(playerid, "Evinizi kiralayan kiþiye anahtar veremezsiniz.");
		    return Dialog_Show(playerid, EnterPlayerID, DIALOG_STYLE_INPUT, "Oyuncu ID", "{FFFFFF}Lütfen anahtarý vermek istediðiniz oyuncunun ID'sini girin:", "Ver", "Kapat");
		}
		if (Ev_AnahtarVar(strval(inputtext),GetPVarInt(playerid, "GiveKeyHouseID")))
		{
		    HataMesajGonder(playerid, "Bu evin anahtarý zaten kiþide var.");
		    return Dialog_Show(playerid, EnterPlayerID, DIALOG_STYLE_INPUT, "Oyuncu ID", "{FFFFFF}Lütfen anahtarý vermek istediðiniz oyuncunun ID'sini girin:", "Ver", "Kapat");
		}
		new query[250];
		format(query, sizeof(query), "INSERT INTO `anahtarlar` (`playersqlid`, `givesqlid`, `sqlid`, `tip`) VALUES ('%d', '%d', '%d', '1')",PlayerData[strval(inputtext)][pID], PlayerData[playerid][pID], HouseInfo[GetPVarInt(playerid, "GiveKeyHouseID")][evID]);
		mysql_query(g_SQL, query, false);
		MesajGonder(strval(inputtext), "%s adlý kiþi size %d ID'li evin anahtarýný verdi. (/anahtarlarim)", ReturnName(playerid, 0), GetPVarInt(playerid, "GiveKeyHouseID"));
		MesajGonder(playerid, "%s adlý kiþiye evin anahtarý verildi.",ReturnName(strval(inputtext), 0));
		DeletePVar(playerid, "GiveKeyHouseID");
	}
	return 1;
}
Dialog:EnterPlayerID2(playerid, response, listitem, inputtext[])
{
	if (!response) return DeletePVar(playerid, "GiveKeyCarID");
	if (response)
	{
	    if (isnull(inputtext)) return Dialog_Show(playerid, EnterPlayerID2, DIALOG_STYLE_INPUT, "Oyuncu ID", "{FFFFFF}Lütfen anahtarý vermek istediðiniz oyuncunun ID'sini girin:", "Ver", "Kapat");
	    if (!IsNumeric(inputtext)) return Dialog_Show(playerid, EnterPlayerID2, DIALOG_STYLE_INPUT, "Oyuncu ID", "{FFFFFF}Lütfen anahtarý vermek istediðiniz oyuncunun ID'sini girin:", "Ver", "Kapat");
	    if (!OyundaDegil(strval(inputtext)))
	    {
	        HataMesajGonder(playerid, "Oyuncu oyunda deðil.");
	        return Dialog_Show(playerid, EnterPlayerID2, DIALOG_STYLE_INPUT, "Oyuncu ID", "{FFFFFF}Lütfen anahtarý vermek istediðiniz oyuncunun ID'sini girin:", "Ver", "Kapat");
		}
		if (strval(inputtext) == playerid)
		{
		    HataMesajGonder(playerid, "Kendi kendine anahtar veremezsiniz.");
		    return Dialog_Show(playerid, EnterPlayerID2, DIALOG_STYLE_INPUT, "Oyuncu ID", "{FFFFFF}Lütfen anahtarý vermek istediðiniz oyuncunun ID'sini girin:", "Ver", "Kapat");
		}
		if (!IsPlayerNearPlayer(playerid, strval(inputtext), 5.0))
		{
		    HataMesajGonder(playerid, "Kiþiye yeterince yakýn deðilsiniz.");
		    return Dialog_Show(playerid, EnterPlayerID2, DIALOG_STYLE_INPUT, "Oyuncu ID", "{FFFFFF}Lütfen anahtarý vermek istediðiniz oyuncunun ID'sini girin:", "Ver", "Kapat");
		}
		if (Arac_AnahtarVar(strval(inputtext),GetPVarInt(playerid, "GiveKeyCarID")))
		{
		    HataMesajGonder(playerid, "Bu aracýn anahtarý zaten kiþide var.");
		    return Dialog_Show(playerid, EnterPlayerID2, DIALOG_STYLE_INPUT, "Oyuncu ID", "{FFFFFF}Lütfen anahtarý vermek istediðiniz oyuncunun ID'sini girin:", "Ver", "Kapat");
		}
		new query[250];
		format(query, sizeof(query), "INSERT INTO `anahtarlar` (`playersqlid`, `givesqlid`, `sqlid`, `tip`) VALUES ('%d', '%d', '%d', '2')",PlayerData[strval(inputtext)][pID], PlayerData[playerid][pID], AracInfo[GetPVarInt(playerid, "GiveKeyCarID")][aracID]);
		mysql_query(g_SQL, query, false);
		MesajGonder(strval(inputtext), "%s adlý kiþi size %s model aracýn anahtarýný verdi. (/anahtarlarim)", ReturnName(playerid, 0), ReturnVehicleModelName(AracInfo[GetPVarInt(playerid, "GiveKeyCarID")][aracModel]));
		MesajGonder(playerid, "%s adlý kiþiye aracýn anahtarý verildi.",ReturnName(strval(inputtext), 0));
		DeletePVar(playerid, "GiveKeyCarID");
	}
	return 1;
}
Dialog:Renk1(playerid, response, listitem, inputtext[])
{
	if (!response) return DeletePVar(playerid, "AracSatinAl");
	if (response)
	{
	    if (isnull(inputtext)) return Dialog_Show(playerid, Renk1, DIALOG_STYLE_INPUT, "Araç Renk 1", "{FFFFFF}Lütfen aracýn 1. rengini girin:\n\n{FF0000}NOT: {FFFFFF}Renk 0-255 arasýnda olmalýdýr.", "Devam", "Iptal");
		if (!IsNumeric(inputtext)) return Dialog_Show(playerid, Renk1, DIALOG_STYLE_INPUT, "Araç Renk 1", "{FFFFFF}Lütfen aracýn 1. rengini girin:\n\n{FF0000}NOT: {FFFFFF}Renk 0-255 arasýnda olmalýdýr.", "Devam", "Iptal");
		if (strval(inputtext) < 0 || strval(inputtext) > 255) return Dialog_Show(playerid, Renk1, DIALOG_STYLE_INPUT, "Araç Renk 1", "{FFFFFF}Lütfen aracýn 1. rengini girin:\n\n{FF0000}NOT: {FFFFFF}Renk 0-255 arasýnda olmalýdýr.", "Devam", "Iptal");
		SetPVarInt(playerid, "aracrenk1", strval(inputtext));
		Dialog_Show(playerid, Renk2, DIALOG_STYLE_INPUT, "Araç Renk 2", "{FFFFFF}Lütfen aracýn 2. rengini girin:\n\n{FF0000}NOT: {FFFFFF}Renk 0-255 arasýnda olmalýdýr.", "Devam", "Iptal");
	}
	return 1;
}
Dialog:Renk2(playerid, response, listitem, inputtext[])
{
	if (!response)
	{
	    DeletePVar(playerid, "AracSatinAl");
	    DeletePVar(playerid, "aracrenk1");
	}
	if (response)
	{
	    if (isnull(inputtext)) return Dialog_Show(playerid, Renk2, DIALOG_STYLE_INPUT, "Araç Renk 2", "{FFFFFF}Lütfen aracýn 2. rengini girin:\n\n{FF0000}NOT: {FFFFFF}Renk 0-255 arasýnda olmalýdýr.", "Devam", "Iptal");
		if (!IsNumeric(inputtext)) return Dialog_Show(playerid, Renk2, DIALOG_STYLE_INPUT, "Araç Renk 2", "{FFFFFF}Lütfen aracýn 2. rengini girin:\n\n{FF0000}NOT: {FFFFFF}Renk 0-255 arasýnda olmalýdýr.", "Devam", "Iptal");
		if (strval(inputtext) < 0 || strval(inputtext) > 255) return Dialog_Show(playerid, Renk2, DIALOG_STYLE_INPUT, "Araç Renk 2", "{FFFFFF}Lütfen aracýn 2. rengini girin:\n\n{FF0000}NOT: {FFFFFF}Renk 0-255 arasýnda olmalýdýr.", "Devam", "Iptal");
		new
			bizid = Business_Inside(playerid),
			carid = GetPVarInt(playerid, "AracSatinAl"),
			price = DealershipCars[bizid][carid][vehPrice];

			if (bizid != -1 && Isyeri[bizid][isyeriExists] && Isyeri[bizid][isyeriTip] == 4)
			{
			    if (PlayerData[playerid][pCash] < price) return HataMesajGonder(playerid, "Yeterli paranýz yok.");
				new maksarac = MAX_OWNABLE_CARS;
		 		switch (PlayerData[playerid][pVip])
				{
    				case 1: maksarac += 2;
				    case 2: maksarac += 4;
				    case 3: maksarac += 6;
				}
				if (Car_GetCount(playerid) >= maksarac) return HataMesajGonder(playerid, "En fazla %d araç sahibi olabilirsin.",maksarac);
				switch (DealershipCars[bizid][carid][vehModel])
				{
				    case 471, 495, 509:
				    {
				        if (PlayerData[playerid][pVip] < 2) return HataMesajGonder(playerid, "Bu aracý satýn alabilmek için Silver VIP ve üstü olmalýsýnýz.");
				    }
					case 502, 503, 494, 434, 504:
					{
					    if (PlayerData[playerid][pVip] < 3) return HataMesajGonder(playerid, "Bu aracý satýn alabilmek için Gold VIP olmalýsýnýz.");
					}
				}
			    new id = Arac_Olustur(PlayerData[playerid][pID], DealershipCars[bizid][carid][vehModel], 0, 0, -1, Isyeri[bizid][isyeriSpawn][0],Isyeri[bizid][isyeriSpawn][1],Isyeri[bizid][isyeriSpawn][2],Isyeri[bizid][isyeriSpawn][3],GetPVarInt(playerid, "aracrenk1"),strval(inputtext),4,0);
			    if (id != -1)
			    {
			        Isyeri[bizid][isyeriKasa] += price;
			        Isyeri_Kaydet(bizid);
			        ParaVer(playerid, -price);
			        MesajGonder(playerid, "Tebrikler, %s miktar para karþýlýðýnda araç satýn aldýnýz. Aracýnýz Grotti Maðzasýna park edildi.",FormatNumber(price));
		        	Log_Write("logs/arac-log.txt", "[%s] %s adli oyuncu %s model araci %s karsiliginda satin aldi.", ReturnDate(), ReturnName(playerid, 0), ReturnVehicleModelName(DealershipCars[bizid][carid][vehModel]), FormatNumber(price));
			    }
			    DeletePVar(playerid, "AracSatinAl");
			    DeletePVar(playerid, "aracrenk1");
			}

	}
	return 1;
}
Dialog:AracSil(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    new id = -1;
        if ((id = (Business_Inside(playerid) == -1) ? (Business_Nearest(playerid)) : (Business_Inside(playerid))) != -1)
        {
		    new model = DealershipCars[id][GetPVarInt(playerid, "AracDuzenleID")][vehModel];
		    Isyeri_AracSil(id, model);

			SunucuMesaji(playerid, "Galeriden '%s' adlý araç silindi.", ReturnVehicleModelName(model));
			DeletePVar(playerid, "AracDuzenle");
			DeletePVar(playerid, "AracDuzenleID");
		}
	}
	return 1;
}
Dialog:AracFiyatDegistir(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    new id = -1;
	    if ((id = (Business_Inside(playerid) == -1) ? (Business_Nearest(playerid)) : (Business_Inside(playerid))) != -1)
	    {
		    if (isnull(inputtext)) return Dialog_Show(playerid,AracFiyatDegistir,DIALOG_STYLE_INPUT, "{2ECC71}Araç Fiyat Deðiþtir", "Lütfen seçtiðiniz araç için yeni bir fiyat girin:", "Deðiþtir", "Kapat");
		    if (!IsNumeric(inputtext)) return Dialog_Show(playerid,AracFiyatDegistir,DIALOG_STYLE_INPUT, "{2ECC71}Araç Fiyat Deðiþtir", "Lütfen seçtiðiniz araç için yeni bir fiyat girin:", "Deðiþtir", "Kapat");
		    new
				    string[128];

				DealershipCars[id][GetPVarInt(playerid, "AracDuzenleID")][vehPrice] = strval(inputtext);

				format(string, sizeof(string), "UPDATE `galeriaraclar` SET `vehPrice` = '%d' WHERE `ID` = '%d' AND `vehID` = '%d'", strval(inputtext), Isyeri[id][isyeriID], DealershipCars[id][GetPVarInt(playerid, "AracDuzenleID")][vehID]);
				mysql_query(g_SQL,string, false);

				SunucuMesaji(playerid, "'%s' model aracýn fiyatý {2ECC71}%s {FFFFFF}olarak deðiþtirildi.",ReturnVehicleModelName(DealershipCars[id][GetPVarInt(playerid, "AracDuzenleID")][vehModel]),FormatNumber(strval(inputtext)));
				DeletePVar(playerid, "AracDuzenle");
				DeletePVar(playerid, "AracDuzenleID");
		}
	}
	return 1;
}
Dialog:KiyafetAl(playerid, response, listitem, inputtext[])
{
	if (!response)
	{
	    PlayerData[playerid][pSkin] = GetPVarInt(playerid, "AlinanSkin");
   		SetPlayerSkin(playerid, GetPVarInt(playerid, "AlinanSkin"));

		SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s adlý kiþi %s ödeyerek bir kýyafet aldý.", ReturnName(playerid, 0), FormatNumber(GetPVarInt(playerid, "KiyafetPrice")));
		DeletePVar(playerid, "AlinanSkin");
		DeletePVar(playerid, "KiyafetPrice");
	}
	if (response)
	{
		HouseSelect(playerid);
	}
	return 1;
}
Dialog:EvSelect(playerid, response, listitem, inputtext[])
{
	if (!response)
	{
	    PlayerData[playerid][pSkin] = GetPVarInt(playerid, "AlinanSkin");
   		SetPlayerSkin(playerid, GetPVarInt(playerid, "AlinanSkin"));

		SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s adlý kiþi %s ödeyerek bir kýyafet aldý.", ReturnName(playerid, 0), FormatNumber(GetPVarInt(playerid, "kýyafetPrice")));
		DeletePVar(playerid, "AlinanSkin");
		DeletePVar(playerid, "KiyafetPrice");
	}
	if (response)
	{
	    new houseid = strval(inputtext);
	    if (HouseInfo[houseid][evExists])
	    {
	        if (EvGetKiyafetCount(houseid) >= 5)
	        {
	            HataMesajGonder(playerid, "Bu evin gardolabýnda boþ yer yok.");
	            HouseSelect(playerid);
			}
			else
			{
			    for (new i; i<5; i++)
			    {
			        if (HouseInfo[houseid][evKiyafetler][i] < 1)
			        {
			            HouseInfo[houseid][evKiyafetler][i] = GetPVarInt(playerid, "AlinanSkin");
			            DeletePVar(playerid, "AlinanSkin");
			            DeletePVar(playerid, "KiyafetPrice");
			            MesajGonder(playerid, "kýyafet evinize eklendi.");
			            break;
			        }
			    }
			}
	    }
	}
	return 1;
}
Dialog:Basvuru2(playerid, response, listitem, params[])
{
	if(response)
	{
	    if(isnull(params)) return Dialog_Show(playerid, Basvuru2, DIALOG_STYLE_INPUT, "{42f445}Baþvuru Onayý", "Sunucumuzda oynamak için baþvuru vurmanýz gerek, baþvurunuzu onaylýyormusunuz?", "Gönder", "Kapat");
	    MesajGonder(playerid, "Attýðýnýz baþvuru iþleme alýndý, aktif yetkililer onayladýðýnda oynamaya baþlayacaksýnýz.");
	    strpack(PlayerData[playerid][pBasvuru], params, 1024 char);
		foreach (new i : Player)
			if (PlayerData[i][pAdmin] > 0) {
			SendClientMessageEx(i, COLOR_CLIENT, "[Yeni Baþvuru]: %s (ID: %d) Baþvuru Onayý: %s (Admin: /onayla & /reddet)", ReturnName(playerid, 0), playerid, params);
  			new name[MAX_PLAYER_NAME + 1];
		    GetPlayerName(playerid, name, sizeof name);
		}
	}
	return 1;
}
Dialog:Gasp(playerid, response, listitem, inputtext[])
{
if (!response) return HataMesajGonder(benigaspeden[playerid], "%s adlý oyuncu gasp isteðinizi reddetti.", ReturnName(playerid));
if (response)
{
	new userid;
       ParaVer(playerid, -1000);
       ParaVer(benigaspeden[playerid], 1000);
       if (!response) return HataMesajGonder(benigaspeden[playerid], "%s adlý oyuncu gaspý kabul etti.", ReturnName(playerid));
   	   SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s' üzerinden $1000 miktarýnda para gasp etti..", ReturnName(playerid, 0), ReturnName(userid, 0));
}
return 1;
}
Dialog:AracDetaylari(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new modelid = GetPVarInt(playerid, "aracModel");

		if(strfind(inputtext, "Renk 1", true) != -1)
		{
			Dialog_Show(playerid, AracDetaylariRenk1, DIALOG_STYLE_INPUT, "Araç Renk 1", "Aracýn birincil renk kodunu belirleyiniz.", "Belirle", "Geri");
  }

		else if(strfind(inputtext, "Renk 2", true) != -1)
		{
			Dialog_Show(playerid, AracDetaylariRenk2, DIALOG_STYLE_INPUT, "Araç Renk 2", "Aracýn ikincil renk kodunu belirleyiniz.", "Belirle", "Geri");
		}

		else if(strfind(inputtext, "Satýn Al", true) != -1)
		{
			Dialog_Show(playerid, AracSatinAlOnay, DIALOG_STYLE_MSGBOX, "Satýn Al", "%s model aracý $%d karþýlýðýnda satýn almak istediðinize emin misiniz?", "Evet", "Geri", ReturnVehicleModelName(modelid), GetPVarInt(playerid, "aracFiyat"));
		}

		else GaleriAracDetaylari(playerid, modelid);
	}

	return 1;
}

Dialog:AracSatinAlOnay(playerid, response, listitem, inputtext[])
{
	new modelid = GetPVarInt(playerid, "aracModel");

	if(response)
	{
		if(GetPVarInt(playerid, "aracFiyat") > PlayerData[playerid][pCash])
			return HataMesajGonder(playerid, "Araç ücretini karþýlayamýyorsunuz.");

		switch(modelid)
		{
			case 471, 495, 509: if (PlayerData[playerid][pVip] < 2) return HataMesajGonder(playerid, "Bu aracý satýn alabilmek için Silver VIP ve üstü olmalýsýnýz.");
			case 502, 503, 494, 434, 504: if (PlayerData[playerid][pVip] < 3) return HataMesajGonder(playerid, "Bu aracý satýn alabilmek için Gold VIP olmalýsýnýz.");
		}

		new maksarac = MAX_OWNABLE_CARS;

		switch(PlayerData[playerid][pVip])
		{
			case 1: maksarac += 2;
			case 2: maksarac += 4;
			case 3: maksarac += 6;
		}

		if(Car_GetCount(playerid) >= maksarac)
			return HataMesajGonder(playerid, "En fazla %d araç sahibi olabilirsin.", maksarac);

		new interior, world, Float:x, Float:y, Float:z, Float:a;

		interior = GetPlayerInterior(playerid);
		world = GetPlayerVirtualWorld(playerid);

		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, a);

		new id = Arac_Olustur(PlayerData[playerid][pID], modelid, interior, world, -1, 560.9611, -1284.3834, 17.0848, a, GetPVarInt(playerid, "aracRenk1"), GetPVarInt(playerid, "aracRenk2"), 4, 0);

		if(id != -1)
		{
			AracInfo[id][aracSahip] = PlayerData[playerid][pID];
			AracInfo[id][aracTip] = 4;
			//PutPlayerInVehicle(playerid, AracInfo[id][aracVehicle], 0);
			new price = GetPVarInt(playerid, "aracFiyat");

			SetPVarInt(playerid, "AracSakliyor", id);
			ParaVer(playerid, -price);
			MesajGonder(playerid, "Tebrikler, %s miktar para karþýlýðýnda araç satýn aldýnýz.",FormatNumber(price));
		    Log_Write("logs/arac-log.txt", "[%s] %s adli oyuncu %s model araci %s karsiliginda satin aldi.", ReturnDate(), ReturnName(playerid, 0), ReturnVehicleModelName(modelid), FormatNumber(price));
		}
	}

	else GaleriAracDetaylari(playerid, modelid);

	return 1;
}

Dialog:AracDetaylariRenk1(playerid, response, listitem, inputtext[])
{
	new modelid = GetPVarInt(playerid, "aracModel");

	if(response)
	{
		new renk;

		if(sscanf(inputtext, "d", renk))
			return Dialog_Show(playerid, AracDetaylariRenk1, DIALOG_STYLE_INPUT, "Araç Renk 1", "Aracýn birincil renk kodunu belirleyiniz.", "Belirle", "Geri");

		if(renk < 0 || renk > 255)
			return Dialog_Show(playerid, AracDetaylariRenk1, DIALOG_STYLE_INPUT, "Araç Renk 1", "Aracýn birincil renk kodunu belirleyiniz.", "Belirle", "Geri");

		SetPVarInt(playerid, "aracRenk1", renk);
		GaleriAracDetaylari(playerid, modelid);
	}

	else GaleriAracDetaylari(playerid, modelid);

	return 1;
}

Dialog:AracDetaylariRenk2(playerid, response, listitem, inputtext[])
{
	new modelid = GetPVarInt(playerid, "aracModel");

	if(response)
	{
		new renk;

		if(sscanf(inputtext, "d", renk))
			return Dialog_Show(playerid, AracDetaylariRenk2, DIALOG_STYLE_INPUT, "Araç Renk 2", "Aracýn ikincil renk kodunu belirleyiniz.", "Belirle", "Geri");

		if(renk < 0 || renk > 255)
			return Dialog_Show(playerid, AracDetaylariRenk2, DIALOG_STYLE_INPUT, "Araç Renk 2", "Aracýn ikincil renk kodunu belirleyiniz.", "Belirle", "Geri");

		SetPVarInt(playerid, "aracRenk2", renk);
		GaleriAracDetaylari(playerid, modelid);
	}

	else GaleriAracDetaylari(playerid, modelid);

	return 1;
}
Dialog:IP_ISTEK(playerid, response, listitem, inputtext[])
{
	if (!response)
	{
        new id = GetPVarInt(playerid, "ipIstek");

		MesajGonder(id, "%s adlý kiþi ip baðlama isteðinizi reddetti.", ReturnName(playerid, 0));
		MesajGonder(playerid, "%s adlý kiþinin ip baðlama isteðini reddettiniz.", ReturnName(id, 0));
	}
	if (response)
	{
	    new id = GetPVarInt(playerid, "ipIstek");

		MesajGonder(id, "%s adlý kiþi ip baðlama isteðinizi kabul etti.", ReturnName(playerid, 0));
		MesajGonder(playerid, "%s adlý kiþinin ip baðlama isteðini kabul ettiniz.", ReturnName(id, 0));

		SetPVarInt(playerid, "IpBaglandi", 1);

	  	TogglePlayerControllable(playerid, false);
	   	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CUFFED);

	    SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s, %s'ý ip ile baðlar.", ReturnName(id, 0),  ReturnName(playerid, 0));

	   	MesajGonder(id, "%s adlý kiþiyi ip ile baðladýnýz. (/ipcoz ile çözebilirsiniz)", ReturnName(playerid, 0));
	    SunucuMesaji(playerid, "%s adlý kiþi tarafýndan baðlandýnýz, korku rolü yapmaktan kaçýnmayýn!", ReturnName(id, 0));
	}
	return 1;
}

Dialog:GOZ_ISTEK(playerid, response, listitem, inputtext[])
{
	if (!response)
	{
		new id = GetPVarInt(playerid, "gozIstek");

		MesajGonder(id, "%s adlý kiþi göz baðlama isteðinizi reddetti.", ReturnName(playerid, 0));
		MesajGonder(playerid, "%s adlý kiþinin göz baðlama isteðini reddettiniz.", ReturnName(id, 0));
	}
	if (response)
	{
        new id = GetPVarInt(playerid, "gozIstek");

        SetPVarInt(playerid, "GozBaglandi", 1);
        TextDrawShowForPlayer(playerid, Karanlik);

		MesajGonder(id, "%s adlý kiþi göz baðlama isteðinizi kabul etti.", ReturnName(playerid, 0));
		MesajGonder(playerid, "%s adlý kiþinin göz baðlama isteðini kabul ettiniz.", ReturnName(id, 0));

		MesajGonder(id, "%s adlý kiþinin gözlerini baðladýnýz. (/gozbagicoz ile çözebilirsiniz)", ReturnName(playerid, 0));
    	SunucuMesaji(playerid, "%s adlý kiþi tarafýndan gözleriniz baðlandý, rolsel olarak hiçbir þey göremiyorsunuz.", ReturnName(id, 0));
	}
	return 1;
}
Dialog:AracYukselt(playerid, response, listitem, inputtext[])
{
	if(response)
	{
	    if (IsPlayerNearPNS(playerid) == -1) return HataMesaji(playerid, "Tamirhane noktasýna yakýn deðilsiniz.");
	    if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return HataMesajGonder(playerid, "Þöför olmalýsýnýz.");
	    new id = Car_GetID(GetPlayerVehicleID(playerid));

	    new fiyat = YukseltmeFiyat(AracInfo[id][aracSeviye] + 1);

	    if(fiyat > PlayerData[playerid][pCash])
	    	return HataMesajGonder(playerid, "Yeterli paranýz yok.");

	    AracInfo[id][aracSeviye]++;
	    ParaVer(playerid, -fiyat);

	    SunucuMesaji(playerid, "Aracýnýza seviye yükseltmesi eklediniz.");
	}

	return 1;
}
Dialog:SilahUretim(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (listitem == 0)
	    {
	        if (PlayerData[playerid][pCash] < ColtFiyat) return HataMesaji(playerid, "Yeterli paranýz yok.");
	        if (PlayerData[playerid][pMateryal] < ColtMat) return HataMesaji(playerid, "Yeterli Parçanýz yok.");
		    new str[2048];
		    format(str, sizeof(str), "%s{DC2222}Silah Ýsmi:\t \t{ffffff}Colt-45\t \n", str);
		    format(str, sizeof(str), "%s{DC2222}Gereken Parça:\t \t{ffffff}%s\t \n", str, FormatNumber(ColtMat));
		    format(str, sizeof(str), "%s{DC2222}Gereken Ücret:\t \t{ffffff}%s\t \n", str, FormatNumber(ColtFiyat));
		    format(str, sizeof(str), "%s{DC2222}Gereken Gövde Parçasý:\t \t{ffffff}%d\t \n", str, ColtGovde);
		    format(str, sizeof(str), "%s{DC2222}Gereken Namlu Parçasý:\t \t{ffffff}%d\t \n", str, ColtNamlu);
		    format(str, sizeof(str), "%s{DC2222}Gereken Kabza Parçasý:\t \t{ffffff}%d\t \n", str, ColtKabza);
		    format(str, sizeof(str), "%s \n", str);
		    format(str, sizeof(str), "%s \n", str);
		    format(str, sizeof(str), "%s \n", str);
			format(str, sizeof(str), "%s{DC2222}Silah Üretimini Kabul Ediyorsanýz Týklayýn\n", str);
		    Dialog_Show(playerid, SilahColt, DIALOG_STYLE_TABLIST, "{DC2222}Silah Üretim:{ffffff} Colt-45", str, "Onayla", "Çýk");
		}
		if (listitem == 1)
		{
	        if (PlayerData[playerid][pCash] < DeagleFiyat) return HataMesaji(playerid, "Yeterli paranýz yok.");
	        if (PlayerData[playerid][pMateryal] < DeagleMat) return HataMesaji(playerid, "Yeterli Parçanýz yok.");
		    new str[2048];
		    format(str, sizeof(str), "%s{DC2222}Silah Ýsmi:\t \t{ffffff}Desert Eagle\t \n", str);
		    format(str, sizeof(str), "%s{DC2222}Gereken Parça:\t \t{ffffff}%s\t \n", str, FormatNumber(DeagleMat));
		    format(str, sizeof(str), "%s{DC2222}Gereken Ücret:\t \t{ffffff}%s\t \n", str, FormatNumber(DeagleFiyat));
		    format(str, sizeof(str), "%s{DC2222}Gereken Gövde Parçasý:\t \t{ffffff}%d\t \n", str, DeagleGovde);
		    format(str, sizeof(str), "%s{DC2222}Gereken Namlu Parçasý:\t \t{ffffff}%d\t \n", str, DeagleNamlu);
		    format(str, sizeof(str), "%s{DC2222}Gereken Kabza Parçasý:\t \t{ffffff}%d\t \n", str, DeagleKabza);
		    format(str, sizeof(str), "%s \n", str);
		    format(str, sizeof(str), "%s \n", str);
		    format(str, sizeof(str), "%s \n", str);
			format(str, sizeof(str), "%s{DC2222}Silah Üretimini Kabul Ediyorsanýz Týklayýn\n", str);
		    Dialog_Show(playerid, SilahDeagle, DIALOG_STYLE_TABLIST, "{DC2222}Silah Üretim:{ffffff} Desert Eagle", str, "Onayla", "Çýk");
		}
		if (listitem == 2)
		{
	        if (PlayerData[playerid][pCash] < ShotgunFiyat) return HataMesaji(playerid, "Yeterli paranýz yok.");
	        if (PlayerData[playerid][pMateryal] < ShotgunMat) return HataMesaji(playerid, "Yeterli Parçanýz yok.");
		    new str[2048];
		    format(str, sizeof(str), "%s{DC2222}Silah Ýsmi:\t \t{ffffff}Shotgun\t \n", str);
		    format(str, sizeof(str), "%s{DC2222}Gereken Parça:\t \t{ffffff}%s\t \n", str, FormatNumber(ShotgunMat));
		    format(str, sizeof(str), "%s{DC2222}Gereken Ücret:\t \t{ffffff}%s\t \n", str, FormatNumber(ShotgunFiyat));
		    format(str, sizeof(str), "%s{DC2222}Gereken Gövde Parçasý:\t \t{ffffff}%d\t \n", str, ShotgunGovde);
		    format(str, sizeof(str), "%s{DC2222}Gereken Namlu Parçasý:\t \t{ffffff}%d\t \n", str, ShotgunNamlu);
		    format(str, sizeof(str), "%s{DC2222}Gereken Kabza Parçasý:\t \t{ffffff}%d\t \n", str, ShotgunKabza);
		    format(str, sizeof(str), "%s \n", str);
		    format(str, sizeof(str), "%s \n", str);
		    format(str, sizeof(str), "%s \n", str);
			format(str, sizeof(str), "%s{DC2222}Silah Üretimini Kabul Ediyorsanýz Týklayýn\n", str);
		    Dialog_Show(playerid, SilahShotgun, DIALOG_STYLE_TABLIST, "{DC2222}Silah Üretim:{ffffff} Shotgun", str, "Onayla", "Çýk");
		}
		if (listitem == 3)
		{
	        if (PlayerData[playerid][pCash] < CuntgunFiyat) return HataMesaji(playerid, "Yeterli paranýz yok.");
	        if (PlayerData[playerid][pMateryal] < CuntgunMat) return HataMesaji(playerid, "Yeterli Parçanýz yok.");
		    new str[2048];
		    format(str, sizeof(str), "%s{DC2222}Silah Ýsmi:\t \t{ffffff}Cuntgun\t \n", str);
		    format(str, sizeof(str), "%s{DC2222}Gereken Parça:\t \t{ffffff}%s\t \n", str, FormatNumber(CuntgunMat));
		    format(str, sizeof(str), "%s{DC2222}Gereken Ücret:\t \t{ffffff}%s\t \n", str, FormatNumber(CuntgunFiyat));
		    format(str, sizeof(str), "%s{DC2222}Gereken Gövde Parçasý:\t \t{ffffff}%d\t \n", str, CuntgunGovde);
		    format(str, sizeof(str), "%s{DC2222}Gereken Namlu Parçasý:\t \t{ffffff}%d\t \n", str, CuntgunGovde);
		    format(str, sizeof(str), "%s{DC2222}Gereken Kabza Parçasý:\t \t{ffffff}%d\t \n", str, CuntgunKabza);
		    format(str, sizeof(str), "%s \n", str);
		    format(str, sizeof(str), "%s \n", str);
		    format(str, sizeof(str), "%s \n", str);
			format(str, sizeof(str), "%s{DC2222}Silah Üretimini Kabul Ediyorsanýz Týklayýn\n", str);
		    Dialog_Show(playerid, SilahCuntgun, DIALOG_STYLE_TABLIST, "{DC2222}Silah Üretim:{ffffff} Cuntgun", str, "Onayla", "Çýk");
		}
		if (listitem == 4)
		{
	        if (PlayerData[playerid][pCash] < KelesFiyat) return HataMesaji(playerid, "Yeterli paranýz yok.");
	        if (PlayerData[playerid][pMateryal] < KelesMat) return HataMesaji(playerid, "Yeterli Parçanýz yok.");
		    new str[2048];
		    format(str, sizeof(str), "%s{DC2222}Silah Ýsmi:\t \t{ffffff}AK-47\t \n", str);
		    format(str, sizeof(str), "%s{DC2222}Gereken Parça:\t \t{ffffff}%s\t \n", str, FormatNumber(KelesMat));
		    format(str, sizeof(str), "%s{DC2222}Gereken Ücret:\t \t{ffffff}%s\t \n", str, FormatNumber(KelesFiyat));
		    format(str, sizeof(str), "%s{DC2222}Gereken Gövde Parçasý:\t \t{ffffff}%d\t \n", str, KelesGovde);
		    format(str, sizeof(str), "%s{DC2222}Gereken Namlu Parçasý:\t \t{ffffff}%d\t \n", str, KelesNamlu);
		    format(str, sizeof(str), "%s{DC2222}Gereken Kabza Parçasý:\t \t{ffffff}%d\t \n", str, KelesKabza);
		    format(str, sizeof(str), "%s \n", str);
		    format(str, sizeof(str), "%s \n", str);
		    format(str, sizeof(str), "%s \n", str);
			format(str, sizeof(str), "%s{DC2222}Silah Üretimini Kabul Ediyorsanýz Týklayýn\n", str);
		    Dialog_Show(playerid, SilahKeles, DIALOG_STYLE_TABLIST, "{DC2222}Silah Üretim:{ffffff} AK-47", str, "Onayla", "Çýk");
		}
	}
	return 1;
}
Dialog:SilahColt(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (PlayerData[playerid][pCash] < ColtFiyat) return HataMesaji(playerid, "Yeterli paranýz yok.");
	    if (PlayerData[playerid][pMateryal] < ColtMat) return HataMesaji(playerid, "Yeterli Parçanýz yok.");
	    if (PlayerData[playerid][pSilahParca][0] < ColtGovde) return HataMesaji(playerid, "Yeterli gövde parçanýz yok.");
	    if (PlayerData[playerid][pSilahParca][1] < ColtNamlu) return HataMesaji(playerid, "Yeterli namlu parçanýz yok.");
	    if (PlayerData[playerid][pSilahParca][2] < ColtKabza) return HataMesaji(playerid, "Yeterli kabza parçanýz yok.");
	    PlayerData[playerid][pMateryal] -= ColtMat;
	    ParaVer(playerid, -ColtFiyat);
	    PlayerData[playerid][pSilahParca][0] -= ColtGovde;
	    PlayerData[playerid][pSilahParca][1] -= ColtNamlu;
	    PlayerData[playerid][pSilahParca][2] -= ColtKabza;

	    GiveWeaponToPlayer(playerid, 22, GetMaksAmmo(22));
	    SunucuMesaji(playerid, "Colt-45 marka silahý ürettin.");
	    AdminMessage(COLOR_LIGHTRED, "ADM: %s (%d) adlý kiþi Colt-45 üretti.", ReturnName(playerid, 0), playerid);

	    PlayerData[playerid][pSilahHakki]--;

	    if(PlayerData[playerid][pSilahHakki] < 0)
	    	PlayerData[playerid][pSilahHakki] = 0;

	    if(PlayerData[playerid][pSilahHakki] == 0)
	    {
	    	PlayerData[playerid][pSilahSuresi] = gettime() + SilahUretimSaat(playerid)*3600;
	    	BilgiMesajGonder(playerid, "Silah üretme hakkýnýz bitti. %d saat sonra tekrar yapabileceksiniz. (/karakter)", SilahUretimSaat(playerid));
	    }
	}
	return 1;
}
Dialog:SilahDeagle(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (PlayerData[playerid][pCash] < DeagleFiyat) return HataMesaji(playerid, "Yeterli paranýz yok.");
	    if (PlayerData[playerid][pMateryal] < DeagleMat) return HataMesaji(playerid, "Yeterli Parçanýz yok.");
	    if (PlayerData[playerid][pSilahParca][0] < DeagleGovde) return HataMesaji(playerid, "Yeterli gövde parçanýz yok.");
	    if (PlayerData[playerid][pSilahParca][1] < DeagleNamlu) return HataMesaji(playerid, "Yeterli namlu parçanýz yok.");
	    if (PlayerData[playerid][pSilahParca][2] < DeagleKabza) return HataMesaji(playerid, "Yeterli kabza parçanýz yok.");
	    PlayerData[playerid][pMateryal] -= DeagleMat;
	    ParaVer(playerid, -DeagleFiyat);
	    PlayerData[playerid][pSilahParca][0] -= DeagleGovde;
	    PlayerData[playerid][pSilahParca][1] -= DeagleNamlu;
	    PlayerData[playerid][pSilahParca][2] -= DeagleKabza;

	    GiveWeaponToPlayer(playerid, 24, GetMaksAmmo(24));
	    SunucuMesaji(playerid, "Desert Eagle marka silahý ürettin.");
	    AdminMessage(COLOR_LIGHTRED, "ADM: %s (%d) adlý kiþi Desert Eagle üretti.", ReturnName(playerid, 0), playerid);

	    PlayerData[playerid][pSilahHakki]--;

	    if(PlayerData[playerid][pSilahHakki] < 0)
	    	PlayerData[playerid][pSilahHakki] = 0;

	    if(PlayerData[playerid][pSilahHakki] == 0)
	    {
	    	PlayerData[playerid][pSilahSuresi] = gettime() + SilahUretimSaat(playerid)*3600;
	    	BilgiMesajGonder(playerid, "Silah üretme hakkýnýz bitti. %d saat sonra tekrar yapabileceksiniz. (/karakter)", SilahUretimSaat(playerid));
	    }
	}
	return 1;
}
Dialog:SilahShotgun(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (PlayerData[playerid][pCash] < ShotgunFiyat) return HataMesaji(playerid, "Yeterli paranýz yok.");
	    if (PlayerData[playerid][pMateryal] < ShotgunMat) return HataMesaji(playerid, "Yeterli Parçanýz yok.");
	    if (PlayerData[playerid][pSilahParca][0] < ShotgunGovde) return HataMesaji(playerid, "Yeterli gövde parçanýz yok.");
	    if (PlayerData[playerid][pSilahParca][1] < ShotgunNamlu) return HataMesaji(playerid, "Yeterli namlu parçanýz yok.");
	    if (PlayerData[playerid][pSilahParca][2] < ShotgunKabza) return HataMesaji(playerid, "Yeterli kabza parçanýz yok.");
	    PlayerData[playerid][pMateryal] -= ShotgunMat;
	    ParaVer(playerid, -ShotgunFiyat);
	    PlayerData[playerid][pSilahParca][0] -= ShotgunGovde;
	    PlayerData[playerid][pSilahParca][1] -= ShotgunNamlu;
	    PlayerData[playerid][pSilahParca][2] -= ShotgunKabza;

	    GiveWeaponToPlayer(playerid, 25, GetMaksAmmo(25));
	    SunucuMesaji(playerid, "Shotgun marka silahý ürettin.");
	    AdminMessage(COLOR_LIGHTRED, "ADM: %s (%d) adlý kiþi Shotgun üretti.", ReturnName(playerid, 0), playerid);

	    PlayerData[playerid][pSilahHakki]--;

	    if(PlayerData[playerid][pSilahHakki] < 0)
	    	PlayerData[playerid][pSilahHakki] = 0;

	    if(PlayerData[playerid][pSilahHakki] == 0)
	    {
	    	PlayerData[playerid][pSilahSuresi] = gettime() + SilahUretimSaat(playerid)*3600;
	    	BilgiMesajGonder(playerid, "Silah üretme hakkýnýz bitti. %d saat sonra tekrar yapabileceksiniz. (/karakter)", SilahUretimSaat(playerid));
	    }
	}
	return 1;
}
Dialog:SilahCuntgun(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (PlayerData[playerid][pCash] < CuntgunFiyat) return HataMesaji(playerid, "Yeterli paranýz yok.");
	    if (PlayerData[playerid][pMateryal] < CuntgunMat) return HataMesaji(playerid, "Yeterli Parçanýz yok.");
	    if (PlayerData[playerid][pSilahParca][0] < CuntgunGovde) return HataMesaji(playerid, "Yeterli gövde parçanýz yok.");
	    if (PlayerData[playerid][pSilahParca][1] < CuntgunNamlu) return HataMesaji(playerid, "Yeterli namlu parçanýz yok.");
	    if (PlayerData[playerid][pSilahParca][2] < CuntgunKabza) return HataMesaji(playerid, "Yeterli kabza parçanýz yok.");
	    PlayerData[playerid][pMateryal] -= CuntgunMat;
	    ParaVer(playerid, -CuntgunFiyat);
	    PlayerData[playerid][pSilahParca][0] -= CuntgunGovde;
	    PlayerData[playerid][pSilahParca][1] -= CuntgunNamlu;
	    PlayerData[playerid][pSilahParca][2] -= CuntgunKabza;

	    GiveWeaponToPlayer(playerid, 33, GetMaksAmmo(33));
	    SunucuMesaji(playerid, "Cuntgun marka silahý ürettin.");
	    AdminMessage(COLOR_LIGHTRED, "ADM: %s (%d) adlý kiþi Cuntgun üretti.", ReturnName(playerid, 0), playerid);

	    PlayerData[playerid][pSilahHakki]--;

	    if(PlayerData[playerid][pSilahHakki] < 0)
	    	PlayerData[playerid][pSilahHakki] = 0;

	    if(PlayerData[playerid][pSilahHakki] == 0)
	    {
	    	PlayerData[playerid][pSilahSuresi] = gettime() + SilahUretimSaat(playerid)*3600;
	    	BilgiMesajGonder(playerid, "Silah üretme hakkýnýz bitti. %d saat sonra tekrar yapabileceksiniz. (/karakter)", SilahUretimSaat(playerid));
	    }
	}
	return 1;
}
Dialog:SilahKeles(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (PlayerData[playerid][pCash] < KelesFiyat) return HataMesaji(playerid, "Yeterli paranýz yok.");
	    if (PlayerData[playerid][pMateryal] < KelesMat) return HataMesaji(playerid, "Yeterli Parçanýz yok.");
	    if (PlayerData[playerid][pSilahParca][0] < KelesGovde) return HataMesaji(playerid, "Yeterli gövde parçanýz yok.");
	    if (PlayerData[playerid][pSilahParca][1] < KelesNamlu) return HataMesaji(playerid, "Yeterli namlu parçanýz yok.");
	    if (PlayerData[playerid][pSilahParca][2] < KelesKabza) return HataMesaji(playerid, "Yeterli kabza parçanýz yok.");
	    PlayerData[playerid][pMateryal] -= KelesMat;
	    ParaVer(playerid, -KelesFiyat);
	    PlayerData[playerid][pSilahParca][0] -= KelesGovde;
	    PlayerData[playerid][pSilahParca][1] -= KelesNamlu;
	    PlayerData[playerid][pSilahParca][2] -= KelesKabza;

	    GiveWeaponToPlayer(playerid, 30, GetMaksAmmo(30));
	    SunucuMesaji(playerid, "AK-47 marka silahý ürettin.");
	    AdminMessage(COLOR_LIGHTRED, "ADM: %s (%d) adlý kiþi AK-47 üretti.", ReturnName(playerid, 0), playerid);

	    PlayerData[playerid][pSilahHakki]--;

	    if(PlayerData[playerid][pSilahHakki] < 0)
	    	PlayerData[playerid][pSilahHakki] = 0;

	    if(PlayerData[playerid][pSilahHakki] == 0)
	    {
	    	PlayerData[playerid][pSilahSuresi] = gettime() + SilahUretimSaat(playerid)*3600;
	    	BilgiMesajGonder(playerid, "Silah üretme hakkýnýz bitti. %d saat sonra tekrar yapabileceksiniz. (/karakter)", SilahUretimSaat(playerid));
	    }
	}
	return 1;
}

Dialog:ParcaAl(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (listitem == 0)
	    {
	        if (PlayerData[playerid][pCash] < GovdePara) return HataMesaji(playerid, "Yeterli paranýz yok");
	        if (PlayerData[playerid][pMateryal] < GovdeMat) return HataMesaji(playerid, "Yeterli Parçanýz yok");
	        ParaVer(playerid, -GovdePara);
	        PlayerData[playerid][pMateryal] -= GovdeMat;
	        PlayerData[playerid][pSilahParca][0] += 1;
	        SunucuMesaji(playerid, "Baþarýyla 1 adet gövde parçasý aldýnýz.");
		}
		if (listitem == 1)
		{
	        if (PlayerData[playerid][pCash] < NamluPara) return HataMesaji(playerid, "Yeterli paranýz yok");
	        if (PlayerData[playerid][pMateryal] < NamluMat) return HataMesaji(playerid, "Yeterli Parçanýz yok");
	        ParaVer(playerid, -NamluPara);
	        PlayerData[playerid][pMateryal] -= NamluMat;
	        PlayerData[playerid][pSilahParca][1] += 1;
	        SunucuMesaji(playerid, "Baþarýyla 1 adet namlu parçasý aldýnýz.");
		}
		if (listitem == 2)
		{
	        if (PlayerData[playerid][pCash] < KabzaPara) return HataMesaji(playerid, "Yeterli paranýz yok");
	        if (PlayerData[playerid][pMateryal] < KabzaMat) return HataMesaji(playerid, "Yeterli Parçanýz yok");
	        ParaVer(playerid, -KabzaPara);
	        PlayerData[playerid][pMateryal] -= KabzaMat;
	        PlayerData[playerid][pSilahParca][2] += 1;
	        SunucuMesaji(playerid, "Baþarýyla 1 adet kabza parçasý aldýnýz.");
		}
	}
	return 1;
}
Dialog:MermiSatinal(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (listitem == 0)
	    {
			if (PlayerData[playerid][pEsyalar][13] >= 1) return HataMesajGonder(playerid, "Üzerinizde en fazla 1 þarjör bulundurabilirsiniz.");
			if (PlayerData[playerid][pCash] < 500) return HataMesajGonder(playerid, "Yeterli paranýz yok. ($500)");
			PlayerData[playerid][pEsyalar][13]++;
			ParaVer(playerid, -500);
			MesajGonder(playerid, "Þarjör satýn aldýnýz.");
		}
		if (listitem == 1)
		{
		    if (!GetWeapon(playerid)) return HataMesajGonder(playerid, "Elinizde silah yok.");
		    if (GetWeapon(playerid) <= 18 || GetWeapon(playerid) == 23 || GetWeapon(playerid) == 26 || GetWeapon(playerid) == 27 || GetWeapon(playerid) == 32 || GetWeapon(playerid) >= 34 ) return HataMesajGonder(playerid, "Bu silaha mermi satýlmamakta.");
		    if (GetMermiFiyat(GetWeapon(playerid)) > PlayerData[playerid][pCash]) return HataMesajGonder(playerid, "Yeterli paranýz yok. (%s)", FormatNumber(GetMermiFiyat(GetWeapon(playerid))));
		    Dialog_Show(playerid, MermiAl, DIALOG_STYLE_MSGBOX, "{DC2222}Mermi Alým:{FFFF00} Satýn Alma Onayý", "Elinizde bulunan silaha mermi almak üzeresiniz, bu iþlem %s miktar paraya maal olacaktýr. Kabul ediyor musunuz?", "Evet", "Hayýr", FormatNumber(GetMermiFiyat(GetWeapon(playerid))));

		}
	}
	return 1;
}
Dialog:MesleklerMenu(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    switch (listitem)
	    {
			case 0:
	        {
                Dialog_Show(playerid, CopcuMeslek, DIALOG_STYLE_TABLIST, "{FFD800}Meslekler:{ffffff} Hurdacýlýk", "Bilgi Al\nKonumu Ýþaretle", "Seç", "Kapat");
	        }
	        case 1:
	        {
                Dialog_Show(playerid, CimentoMeslek, DIALOG_STYLE_TABLIST, "{FFD800}Meslekler:{ffffff} Çimento Taþýmacýlýðý", "Bilgi Al\nKonumu Ýþaretle", "Seç", "Kapat");
	        }
	        case 2:
	        {
	        	Dialog_Show(playerid, TirMeslek, DIALOG_STYLE_TABLIST, "{FFD800}Meslekler:{ffffff} Týrcýlýk", "Bilgi Al\nKonumu Ýþaretle", "Seç", "Kapat");
	        }
	        case 3:
	        {
	        	Dialog_Show(playerid, Balikcilik, DIALOG_STYLE_TABLIST, "{FFD800}Meslekler:{ffffff} Balýkçýlýk", "Bilgi Al\nKonumu Ýþaretle", "Seç", "Kapat");
	        }
	        case 4:
	        {
	        	Dialog_Show(playerid, Kasapcilik, DIALOG_STYLE_TABLIST, "{FFD800}Meslekler:{ffffff} Kasapçýlýk", "Bilgi Al\nKonumu Ýþaretle", "Seç", "Kapat");
	        }
		}
	}
	return 1;
}
Dialog:CopcuMeslek(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    switch (listitem)
	    {
	        case 0:
            {
          		 Dialog_Show(playerid, CopcuBilgi, DIALOG_STYLE_MSGBOX, "{FFD800}Meslekler:{ffffff} Hurdacýlýk Mesleði Bilgisi", "{FFD800}Hurdacýlýk Mesleði:{ffffff}\
				 Hurda aracýna binip, Hurda kutularýn yanýna giderek içersindeki hurdalarý toplayarak para kazanabilirsiniz. Þahsi ARAÇLA YAPILMAZ\n \n{FFD800}Komutlar:{ffffff} /hurdabul, /hurdatopla\n\
				 \n \n \n{ff0000}NOT:{ffffff} Aracýnýzýn içini fulledikten sonra Hurda fabrikasýna teslim ederek paranýzý alabilirsiniz.", "Seç", "Kapat");
 			}
 			case 1:
            {
            	callcmd::cpsifirla(playerid);

            	MeslekCP[playerid] = SetPlayerCheckpoint(playerid, CopcuX, CopcuY, CopcuZ, 5.0);
                SunucuMesaji(playerid, "Meslek noktasý haritanýzda iþaretlendi.");
            }
    	}
	}
	return 1;
}
Dialog:CimentoMeslek(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    switch (listitem)
	    {
	        case 0:
            {
       		 Dialog_Show(playerid, CimentoBilgi, DIALOG_STYLE_MSGBOX, "{FFD800}Meslekler:{ffffff} Çimento Taþýmacýsý Bilgisi", "{FFD800}Çimento Taþýmacýsý Mesleði:{ffffff}\
				 Çimento aracýna binerek meslek baþlama noktasýndan çimentonuzu yükler, paranýzý almak için geri dönersiniz. Þahsi ARAÇLA YAPILMAZ\n \n{FFD800}Komutlar:{ffffff} /cimento, /cimento yukle\n\
				 \n \n \n{ff0000}NOT:{ffffff} Eðer araçtan inerseniz aracýnýz ile meslek noktasýna ýþýnlanýrsýnýz.", "Seç", "Kapat");
 			}
 			case 1:
            {
            	callcmd::cpsifirla(playerid);

            	MeslekCP[playerid] = SetPlayerCheckpoint(playerid, CimentoX, CimentoY, CimentoZ, 5.0);
                SunucuMesaji(playerid, "Meslek noktasý haritanýzda iþaretlendi.");
            }
    	}
	}
	return 1;
}
Dialog:Balikcilik(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    switch (listitem)
	    {
	        case 0:
	        {
	            Dialog_Show(playerid, KamyoncuBilgi, DIALOG_STYLE_MSGBOX, "{FFD800}Meslekler:{ffffff}Balýkçýlýk Mesleði Bilgisi", "{FFD800}Balýkçýlýk Mesleði:{ffffff}\
				 Balýkçýlýk baþlama bölgesinde /baliktut ile balýk tutarsýnýz NPC ile satabilirsiniz.\n \n{FFD800}Komutlar:{ffffff} /baliktut\n\
				 \n ", "Seç", "Kapat");
	        }
	        case 1:
	        {
	        	callcmd::cpsifirla(playerid);

                MeslekCP[playerid] = SetPlayerCheckpoint(playerid, BalikciX, BalikciY, BalikciZ, 5.0);
                SunucuMesaji(playerid, "Meslek noktasý haritanýzda iþaretlendi.");
	        }
	    }
	}
	return 1;
}
Dialog:Kasapcilik(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    switch (listitem)
	    {
	        case 0:
	        {
	            Dialog_Show(playerid, KasapBilgi, DIALOG_STYLE_MSGBOX, "{FFD800}Meslekler:{ffffff}Balýkçýlýk Mesleði Bilgisi", "{FFD800}Kasapçýlýk Mesleði:{ffffff}\
				 Kasapçýlýk baþlama bölgesinde /et ile komutlara bakabilirsiniz /testere ile satýnalabilirsiniz.\n \n{FFD800}Komutlar:{ffffff} /et [PARAMETRELER], /testere, /testeresat\n\
				 \n ", "Seç", "Kapat");
	        }
	        case 1:
	        {
	        	callcmd::cpsifirla(playerid);

                MeslekCP[playerid] = SetPlayerCheckpoint(playerid, KasapX, KasapY, KasapZ, 5.0);
                SunucuMesaji(playerid, "Meslek noktasý haritanýzda iþaretlendi.");
	        }
	    }
	}
	return 1;
}
Dialog:Envanter(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		if(strfind(inputtext, "Silah Envanteri", true) != -1)
		{
			OyuncuSilahlar(playerid);
		}else{
		    new baslik[60];
		    format(EsyaAdi[playerid], 30, inputtext);
		    format(baslik, sizeof(baslik), "{E74C3C}Eþya: {FFFFFF}%s", inputtext);
		    Dialog_Show(playerid, EnvanterEtkilesim, DIALOG_STYLE_LIST, baslik, "{AFAFAF}» {FFFFFF}Eþyayý Kullan\n{AFAFAF}» {FFFFFF}Eþyayý Baþkasýna Ver", "Seç", "Geri");
		}
	}
	return 1;
}
Dialog:EnvanterEtkilesim(playerid, response, listitem, inputtext[])
{
	if (!response) return Envanter_Goster(playerid);
	if (response)
	{
	    if (listitem == 0)
	    {
	        if (strcmp(EsyaAdi[playerid], "Su", true) == 0)
	        {
	            callcmd::su(playerid);
	        }
	        else if (strcmp(EsyaAdi[playerid], "Telefon", true) == 0)
	        {
	            callcmd::telefon(playerid);
	        }
	        else if (strcmp(EsyaAdi[playerid], "Portatif Radyo", true) == 0)
	        {
	            callcmd::pr(playerid, "");
	        }
	        else if (strcmp(EsyaAdi[playerid], "Zar", true) == 0)
	        {
	            callcmd::zarat(playerid);
	        }
	        else if (strcmp(EsyaAdi[playerid], "Sigara", true) == 0)
	        {
	            callcmd::sigara(playerid);
	        }
	        else if (strcmp(EsyaAdi[playerid], "Ýp", true) == 0)
	        {
	            callcmd::ipbagla(playerid, "");
	        }
	        else if (strcmp(EsyaAdi[playerid], "Göz Baðý", true) == 0)
	        {
	            callcmd::gozbagla(playerid, "");
	        }
	        else if (strcmp(EsyaAdi[playerid], "Maske", true) == 0)
	        {
	            callcmd::maske(playerid);
	        }
	        else if (strcmp(EsyaAdi[playerid], "Benzin Bidonu", true) == 0)
	        {
	            callcmd::benzinkutusu(playerid);
	        }
	        else if (strcmp(EsyaAdi[playerid], "Barbekü", true) == 0)
	        {
	            callcmd::barbeku(playerid, "koy");
	        }
	        else if (strcmp(EsyaAdi[playerid], "Tamir Kiti", true) == 0)
	        {
	            callcmd::tamirkiti(playerid);
	        }
	        else if (strcmp(EsyaAdi[playerid], "Portatif Çadýr", true) == 0)
	        {
	            callcmd::cadir(playerid, "koy");
	        }
	        else if (strcmp(EsyaAdi[playerid], "Kamp Ateþi", true) == 0)
	        {
	            callcmd::kampatesi(playerid);
	        }
	        else if (strcmp(EsyaAdi[playerid], "Þarjör", true) == 0)
	        {
	            OyuncuSilahlar(playerid);
	        }
	        else if (strcmp(EsyaAdi[playerid], "Sürücü lisansý", true) == 0)
	        {
	            callcmd::envanter(playerid);
	        }
	        else if (strcmp(EsyaAdi[playerid], "Motor lisansý", true) == 0)
	        {
	            callcmd::envanter(playerid);
	        }
	    }
		if (listitem == 1)
		{
		    if (strcmp(EsyaAdi[playerid], "Telefon", true) == 0 || strcmp(EsyaAdi[playerid], "Portatif Radyo", true) == 0 || strcmp(EsyaAdi[playerid], "Sürücü lisansý", true) == 0 || strcmp(EsyaAdi[playerid], "Motor lisansý", true) == 0) return HataMesajGonder(playerid, "Bu eþya baþkasýna verilemez.");
		    Dialog_Show(playerid, EsyaVerID, DIALOG_STYLE_INPUT, "Eþya Ver", "{FFFFFF}Lütfen eþyayý vermek istediðiniz oyuncunun ID'sini girin:", "Devam", "Kapat");
		}
		if (listitem == 15)
		{
			OyuncuSilahlar(playerid);
		}
	}
	return 1;
}
Dialog:EsyaVer(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    new id = GetPVarInt(playerid, "EsyaVerID");
	    if (!OyundaDegil(id) || !IsPlayerNearPlayer(playerid, id, 5.0)) return 1;
	    if (isnull(inputtext)) return Dialog_Show(playerid, EsyaVer, DIALOG_STYLE_INPUT, "Eþya Ver", "{FFFFFF}Lütfen vermek istediðiniz miktarý girin:", "Ver", "Kapat");
	    if (!IsNumeric(inputtext)) return Dialog_Show(playerid, EsyaVer, DIALOG_STYLE_INPUT, "Eþya Ver", "{FFFFFF}Lütfen vermek istediðiniz miktarý girin:", "Ver", "Kapat");
	    if (strval(inputtext) < 1 || strval(inputtext) > 5)
	    {
	        HataMesajGonder(playerid, "En az 1, en fazla 5 girebilirsiniz.");
	        return Dialog_Show(playerid, EsyaVer, DIALOG_STYLE_INPUT, "Eþya Ver", "{FFFFFF}Lütfen vermek istediðiniz miktarý girin:", "Ver", "Kapat");
	    }
	    new miktar = strval(inputtext);
	    if (strcmp(EsyaAdi[playerid], "Su", true) == 0)
	    {
	        if (miktar > PlayerData[playerid][pSu])
	        {
	            HataMesajGonder(playerid, "Envanterinizde o kadar su yok.");
	            return Dialog_Show(playerid, EsyaVer, DIALOG_STYLE_INPUT, "Eþya Ver", "{FFFFFF}Lütfen vermek istediðiniz miktarý girin:", "Ver", "Kapat");
	        }
	        if (PlayerData[id][pSu] + miktar > 5)
	        {
	            HataMesajGonder(playerid, "Kiþi envanterinde en fazla 5 su taþýyabilir.");
	            return Dialog_Show(playerid, EsyaVer, DIALOG_STYLE_INPUT, "Eþya Ver", "{FFFFFF}Lütfen vermek istediðiniz miktarý girin:", "Ver", "Kapat");
	        }
	        PlayerData[playerid][pSu] -= miktar;
	        PlayerData[id][pSu] += miktar;
	        SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "* %s %s adlý kiþiye %d su verir.", ReturnName(playerid, 0), ReturnName(id, 0), miktar);
	        MesajGonder(playerid, "%s adlý kiþiye %d su verdiniz.", ReturnName(id, 0), miktar);
	        MesajGonder(id, "%s adlý kiþi size %d su verdi.", ReturnName(playerid, 0), miktar);
	    }
	    else if (strcmp(EsyaAdi[playerid], "Zar", true) == 0)
	    {
	        if (miktar > PlayerData[playerid][pEsyalar][0])
	        {
	            HataMesajGonder(playerid, "O kadar zarýnýz yok.");
	            return Dialog_Show(playerid, EsyaVer, DIALOG_STYLE_INPUT, "Eþya Ver", "{FFFFFF}Lütfen vermek istediðiniz miktarý girin:", "Ver", "Kapat");
	        }
	        new idd[3];
	        format(idd, sizeof(idd), "%d", id);
	        callcmd::zarver(playerid, idd);
	    }
	    else if (strcmp(EsyaAdi[playerid], "Sigara", true) == 0)
	    {
	        if (miktar > PlayerData[playerid][pEsyalar][1])
	        {
	            HataMesajGonder(playerid, "Envanterinizde o kadar sigara yok.");
	            return Dialog_Show(playerid, EsyaVer, DIALOG_STYLE_INPUT, "Eþya Ver", "{FFFFFF}Lütfen vermek istediðiniz miktarý girin:", "Ver", "Kapat");
	        }
	        if (PlayerData[id][pEsyalar][1] + miktar > 5)
	        {
	            HataMesajGonder(playerid, "Kiþi envanterinde en fazla 5 sigara taþýyabilir.");
	            return Dialog_Show(playerid, EsyaVer, DIALOG_STYLE_INPUT, "Eþya Ver", "{FFFFFF}Lütfen vermek istediðiniz miktarý girin:", "Ver", "Kapat");
	        }
	        PlayerData[playerid][pEsyalar][1] -= miktar;
	        PlayerData[id][pEsyalar][1] += miktar;
	        SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "* %s %s adlý kiþiye %d sigara verir.", ReturnName(playerid, 0), ReturnName(id, 0), miktar);
	        MesajGonder(playerid, "%s adlý kiþiye %d sigara verdiniz.", ReturnName(id, 0), miktar);
	        MesajGonder(id, "%s adlý kiþi size %d sigara verdi.", ReturnName(playerid, 0), miktar);
	    }
	    else if (strcmp(EsyaAdi[playerid], "Ýp", true) == 0)
	    {
	        if (miktar > PlayerData[playerid][pEsyalar][2])
	        {
	            HataMesajGonder(playerid, "Envanterinizde o kadar ip yok.");
	            return Dialog_Show(playerid, EsyaVer, DIALOG_STYLE_INPUT, "Eþya Ver", "{FFFFFF}Lütfen vermek istediðiniz miktarý girin:", "Ver", "Kapat");
	        }
	        if (PlayerData[id][pEsyalar][2] + miktar > 2)
	        {
	            HataMesajGonder(playerid, "Kiþi envanterinde en fazla 2 ip taþýyabilir.");
	            return Dialog_Show(playerid, EsyaVer, DIALOG_STYLE_INPUT, "Eþya Ver", "{FFFFFF}Lütfen vermek istediðiniz miktarý girin:", "Ver", "Kapat");
	        }
	        PlayerData[playerid][pEsyalar][2] -= miktar;
	        PlayerData[id][pEsyalar][2] += miktar;
	        SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "* %s %s adlý kiþiye %d ip verir.", ReturnName(playerid, 0), ReturnName(id, 0), miktar);
	        MesajGonder(playerid, "%s adlý kiþiye %d ip verdiniz.", ReturnName(id, 0), miktar);
	        MesajGonder(id, "%s adlý kiþi size %d ip verdi.", ReturnName(playerid, 0), miktar);
	    }
	    else if (strcmp(EsyaAdi[playerid], "Göz Baðý", true) == 0)
	    {
	        if (miktar > PlayerData[playerid][pEsyalar][3])
	        {
	            HataMesajGonder(playerid, "Envanterinizde o kadar göz baðý yok.");
	            return Dialog_Show(playerid, EsyaVer, DIALOG_STYLE_INPUT, "Eþya Ver", "{FFFFFF}Lütfen vermek istediðiniz miktarý girin:", "Ver", "Kapat");
	        }
	        if (PlayerData[id][pEsyalar][3] + miktar > 2)
	        {
	            HataMesajGonder(playerid, "Kiþi envanterinde en fazla 2 göz baðý taþýyabilir.");
	            return Dialog_Show(playerid, EsyaVer, DIALOG_STYLE_INPUT, "Eþya Ver", "{FFFFFF}Lütfen vermek istediðiniz miktarý girin:", "Ver", "Kapat");
	        }
	        PlayerData[playerid][pEsyalar][3] -= miktar;
	        PlayerData[id][pEsyalar][3] += miktar;
	        SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "* %s %s adlý kiþiye %d göz baðý verir.", ReturnName(playerid, 0), ReturnName(id, 0), miktar);
	        MesajGonder(playerid, "%s adlý kiþiye %d göz baðý verdiniz.", ReturnName(id, 0), miktar);
	        MesajGonder(id, "%s adlý kiþi size %d göz baðý verdi.", ReturnName(playerid, 0), miktar);
	    }
	    else if (strcmp(EsyaAdi[playerid], "Maske", true) == 0)
	    {
	        if (miktar > PlayerData[playerid][pEsyalar][4])
	        {
	            HataMesajGonder(playerid, "Envanterinizde o kadar maske yok.");
	            return Dialog_Show(playerid, EsyaVer, DIALOG_STYLE_INPUT, "Eþya Ver", "{FFFFFF}Lütfen vermek istediðiniz miktarý girin:", "Ver", "Kapat");
	        }
	        if (PlayerData[id][pEsyalar][4] != 0)
	        {
	            HataMesajGonder(playerid, "Bu kiþinin zaten maskesi var.");
	            return Dialog_Show(playerid, EsyaVer, DIALOG_STYLE_INPUT, "Eþya Ver", "{FFFFFF}Lütfen vermek istediðiniz miktarý girin:", "Ver", "Kapat");
	        }
	        PlayerData[playerid][pEsyalar][4] = 0;
	        PlayerData[id][pEsyalar][3] = 1;
	        SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "* %s %s adlý kiþiye maske verir.", ReturnName(playerid, 0), ReturnName(id, 0));
	        MesajGonder(playerid, "%s adlý kiþiye maske verdiniz.", ReturnName(id, 0));
	        MesajGonder(id, "%s adlý kiþi size maske verdi.", ReturnName(playerid, 0));
	    }
	    else if (strcmp(EsyaAdi[playerid], "Benzin Bidonu", true) == 0)
	    {
	        if (miktar > PlayerData[playerid][pEsyalar][5])
	        {
	            HataMesajGonder(playerid, "Envanterinizde o kadar benzin bidonu yok.");
	            return Dialog_Show(playerid, EsyaVer, DIALOG_STYLE_INPUT, "Eþya Ver", "{FFFFFF}Lütfen vermek istediðiniz miktarý girin:", "Ver", "Kapat");
	        }
	        if (PlayerData[id][pEsyalar][5] + miktar > 3)
	        {
	            HataMesajGonder(playerid, "Kiþi envanterinde en fazla 3 benzin bidonu taþýyabilir.");
	            return Dialog_Show(playerid, EsyaVer, DIALOG_STYLE_INPUT, "Eþya Ver", "{FFFFFF}Lütfen vermek istediðiniz miktarý girin:", "Ver", "Kapat");
	        }
	        PlayerData[playerid][pEsyalar][5] -= miktar;
	        PlayerData[id][pEsyalar][5] += miktar;
	        SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "* %s %s adlý kiþiye %d benzin bidonu verir.", ReturnName(playerid, 0), ReturnName(id, 0), miktar);
	        MesajGonder(playerid, "%s adlý kiþiye %d benzin bidonu verdiniz.", ReturnName(id, 0), miktar);
	        MesajGonder(id, "%s adlý kiþi size %d benzin bidonu verdi.", ReturnName(playerid, 0), miktar);
	    }
	    else if (strcmp(EsyaAdi[playerid], "Barbekü", true) == 0)
	    {
	        if (miktar > PlayerData[playerid][pEsyalar][6])
	        {
	            HataMesajGonder(playerid, "Envanterinizde o kadar barbekü yok.");
	            return Dialog_Show(playerid, EsyaVer, DIALOG_STYLE_INPUT, "Eþya Ver", "{FFFFFF}Lütfen vermek istediðiniz miktarý girin:", "Ver", "Kapat");
	        }
	        if (PlayerData[id][pEsyalar][6] != 0)
	        {
	            HataMesajGonder(playerid, "Bu kiþinin zaten barbekü adlý eþyasý var.");
	            return Dialog_Show(playerid, EsyaVer, DIALOG_STYLE_INPUT, "Eþya Ver", "{FFFFFF}Lütfen vermek istediðiniz miktarý girin:", "Ver", "Kapat");
	        }
	        PlayerData[playerid][pEsyalar][6] = 0;
	        PlayerData[id][pEsyalar][6] = 1;
	        SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "* %s %s adlý kiþiye barbekü verir.", ReturnName(playerid, 0), ReturnName(id, 0));
	        MesajGonder(playerid, "%s adlý kiþiye barbekü verdiniz.", ReturnName(id, 0));
	        MesajGonder(id, "%s adlý kiþi size barbekü verdi.", ReturnName(playerid, 0));
	    }
	    else if (strcmp(EsyaAdi[playerid], "Barbekü", true) == 0)
	    {
	        if (miktar > PlayerData[playerid][pEsyalar][6])
	        {
	            HataMesajGonder(playerid, "Envanterinizde o kadar barbekü yok.");
	            return Dialog_Show(playerid, EsyaVer, DIALOG_STYLE_INPUT, "Eþya Ver", "{FFFFFF}Lütfen vermek istediðiniz miktarý girin:", "Ver", "Kapat");
	        }
	        if (PlayerData[id][pEsyalar][6] != 0)
	        {
	            HataMesajGonder(playerid, "Bu kiþinin zaten barbekü adlý eþyasý var.");
	            return Dialog_Show(playerid, EsyaVer, DIALOG_STYLE_INPUT, "Eþya Ver", "{FFFFFF}Lütfen vermek istediðiniz miktarý girin:", "Ver", "Kapat");
	        }
	        PlayerData[playerid][pEsyalar][6] = 0;
	        PlayerData[id][pEsyalar][6] = 1;
	        SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "* %s %s adlý kiþiye barbekü verir.", ReturnName(playerid, 0), ReturnName(id, 0));
	        MesajGonder(playerid, "%s adlý kiþiye barbekü verdiniz.", ReturnName(id, 0));
	        MesajGonder(id, "%s adlý kiþi size barbekü verdi.", ReturnName(playerid, 0));
	    }
	    else if (strcmp(EsyaAdi[playerid], "Köfte", true) == 0)
	    {
	        if (miktar > PlayerData[playerid][pEsyalar][7])
	        {
	            HataMesajGonder(playerid, "Envanterinizde o kadar köfte yok.");
	            return Dialog_Show(playerid, EsyaVer, DIALOG_STYLE_INPUT, "Eþya Ver", "{FFFFFF}Lütfen vermek istediðiniz miktarý girin:", "Ver", "Kapat");
	        }
	        if (PlayerData[id][pEsyalar][7] + miktar > 5)
	        {
	            HataMesajGonder(playerid, "Kiþi envanterinde en fazla 5 köfte taþýyabilir.");
	            return Dialog_Show(playerid, EsyaVer, DIALOG_STYLE_INPUT, "Eþya Ver", "{FFFFFF}Lütfen vermek istediðiniz miktarý girin:", "Ver", "Kapat");
	        }
	        PlayerData[playerid][pEsyalar][7] -= miktar;
	        PlayerData[id][pEsyalar][7] += miktar;
	        SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "* %s %s adlý kiþiye %d köfte verir.", ReturnName(playerid, 0), ReturnName(id, 0), miktar);
	        MesajGonder(playerid, "%s adlý kiþiye %d köfte verdiniz.", ReturnName(id, 0), miktar);
	        MesajGonder(id, "%s adlý kiþi size %d köfte verdi.", ReturnName(playerid, 0), miktar);
	    }
	    else if (strcmp(EsyaAdi[playerid], "Tavuk Eti", true) == 0)
	    {
	        if (miktar > PlayerData[playerid][pEsyalar][8])
	        {
	            HataMesajGonder(playerid, "Envanterinizde o kadar tavuk eti yok.");
	            return Dialog_Show(playerid, EsyaVer, DIALOG_STYLE_INPUT, "Eþya Ver", "{FFFFFF}Lütfen vermek istediðiniz miktarý girin:", "Ver", "Kapat");
	        }
	        if (PlayerData[id][pEsyalar][8] + miktar > 5)
	        {
	            HataMesajGonder(playerid, "Kiþi envanterinde en fazla 5 tavuk eti taþýyabilir.");
	            return Dialog_Show(playerid, EsyaVer, DIALOG_STYLE_INPUT, "Eþya Ver", "{FFFFFF}Lütfen vermek istediðiniz miktarý girin:", "Ver", "Kapat");
	        }
	        PlayerData[playerid][pEsyalar][8] -= miktar;
	        PlayerData[id][pEsyalar][8] += miktar;
	        SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "* %s %s adlý kiþiye %d tavuk eti verir.", ReturnName(playerid, 0), ReturnName(id, 0), miktar);
	        MesajGonder(playerid, "%s adlý kiþiye %d tavuk eti verdiniz.", ReturnName(id, 0), miktar);
	        MesajGonder(id, "%s adlý kiþi size %d tavuk eti verdi.", ReturnName(playerid, 0), miktar);
	    }
	    else if (strcmp(EsyaAdi[playerid], "Dana Eti", true) == 0)
	    {
	        if (miktar > PlayerData[playerid][pEsyalar][9])
	        {
	            HataMesajGonder(playerid, "Envanterinizde o kadar dana eti yok.");
	            return Dialog_Show(playerid, EsyaVer, DIALOG_STYLE_INPUT, "Eþya Ver", "{FFFFFF}Lütfen vermek istediðiniz miktarý girin:", "Ver", "Kapat");
	        }
	        if (PlayerData[id][pEsyalar][9] + miktar > 5)
	        {
	            HataMesajGonder(playerid, "Kiþi envanterinde en fazla 5 dana eti taþýyabilir.");
	            return Dialog_Show(playerid, EsyaVer, DIALOG_STYLE_INPUT, "Eþya Ver", "{FFFFFF}Lütfen vermek istediðiniz miktarý girin:", "Ver", "Kapat");
	        }
	        PlayerData[playerid][pEsyalar][9] -= miktar;
	        PlayerData[id][pEsyalar][9] += miktar;
	        SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "* %s %s adlý kiþiye %d dana eti verir.", ReturnName(playerid, 0), ReturnName(id, 0), miktar);
	        MesajGonder(playerid, "%s adlý kiþiye %d dana eti verdiniz.", ReturnName(id, 0), miktar);
	        MesajGonder(id, "%s adlý kiþi size %d dana eti verdi.", ReturnName(playerid, 0), miktar);
	    }
	    else if (strcmp(EsyaAdi[playerid], "Tamir Kiti", true) == 0)
	    {
	        if (miktar > PlayerData[playerid][pEsyalar][10])
	        {
	            HataMesajGonder(playerid, "Envanterinizde o kadar tamir kiti yok.");
	            return Dialog_Show(playerid, EsyaVer, DIALOG_STYLE_INPUT, "Eþya Ver", "{FFFFFF}Lütfen vermek istediðiniz miktarý girin:", "Ver", "Kapat");
	        }
	        if (PlayerData[id][pEsyalar][10] + miktar > 3)
	        {
	            HataMesajGonder(playerid, "Kiþi envanterinde en fazla 3 tamir kiti taþýyabilir.");
	            return Dialog_Show(playerid, EsyaVer, DIALOG_STYLE_INPUT, "Eþya Ver", "{FFFFFF}Lütfen vermek istediðiniz miktarý girin:", "Ver", "Kapat");
	        }
	        PlayerData[playerid][pEsyalar][10] -= miktar;
	        PlayerData[id][pEsyalar][10] += miktar;
	        SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "* %s %s adlý kiþiye %d tamir kiti verir.", ReturnName(playerid, 0), ReturnName(id, 0), miktar);
	        MesajGonder(playerid, "%s adlý kiþiye %d tamir kiti verdiniz.", ReturnName(id, 0), miktar);
	        MesajGonder(id, "%s adlý kiþi size %d tamir kiti verdi.", ReturnName(playerid, 0), miktar);
	    }
	    else if (strcmp(EsyaAdi[playerid], "Portatif Çadýr", true) == 0)
	    {
	        if (miktar > PlayerData[playerid][pEsyalar][11])
	        {
	            HataMesajGonder(playerid, "Envanterinizde o kadar portatif çadýr yok.");
	            return Dialog_Show(playerid, EsyaVer, DIALOG_STYLE_INPUT, "Eþya Ver", "{FFFFFF}Lütfen vermek istediðiniz miktarý girin:", "Ver", "Kapat");
	        }
	        if (PlayerData[id][pEsyalar][11] + miktar > 1)
	        {
	            HataMesajGonder(playerid, "Kiþi envanterinde en fazla 1 portatif çadýr taþýyabilir.");
	            return Dialog_Show(playerid, EsyaVer, DIALOG_STYLE_INPUT, "Eþya Ver", "{FFFFFF}Lütfen vermek istediðiniz miktarý girin:", "Ver", "Kapat");
	        }
	        PlayerData[playerid][pEsyalar][11] -= miktar;
	        PlayerData[id][pEsyalar][11] += miktar;
	        SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "* %s %s adlý kiþiye Portatif çadýr verir.", ReturnName(playerid, 0), ReturnName(id, 0));
	        MesajGonder(playerid, "%s adlý kiþiye Portatif Çadýr verdiniz.", ReturnName(id, 0));
	        MesajGonder(id, "%s adlý kiþi size Portatif Çadýr verdi.", ReturnName(playerid, 0));
	    }
	    else if (strcmp(EsyaAdi[playerid], "Kamp Ateþi", true) == 0)
	    {
	        if (miktar > PlayerData[playerid][pEsyalar][12])
	        {
	            HataMesajGonder(playerid, "Envanterinizde o kadar kamp ateþi yok.");
	            return Dialog_Show(playerid, EsyaVer, DIALOG_STYLE_INPUT, "Eþya Ver", "{FFFFFF}Lütfen vermek istediðiniz miktarý girin:", "Ver", "Kapat");
	        }
	        if (PlayerData[id][pEsyalar][12] + miktar > 1)
	        {
	            HataMesajGonder(playerid, "Kiþi envanterinde en fazla 1 kamp ateþi taþýyabilir.");
	            return Dialog_Show(playerid, EsyaVer, DIALOG_STYLE_INPUT, "Eþya Ver", "{FFFFFF}Lütfen vermek istediðiniz miktarý girin:", "Ver", "Kapat");
	        }
	        PlayerData[playerid][pEsyalar][12] -= miktar;
	        PlayerData[id][pEsyalar][12] += miktar;
	        SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "* %s %s adlý kiþiye Kamp Ateþi verir.", ReturnName(playerid, 0), ReturnName(id, 0));
	        MesajGonder(playerid, "%s adlý kiþiye kamp ateþi verdiniz.", ReturnName(id, 0));
	        MesajGonder(id, "%s adlý kiþi size kamp ateþi verdi.", ReturnName(playerid, 0));
	    }
	    else if (strcmp(EsyaAdi[playerid], "Þarjör", true) == 0)
	    {
	        if (miktar > PlayerData[playerid][pEsyalar][13])
	        {
	            HataMesajGonder(playerid, "Envanterinizde o kadar þarjör yok.");
	            return Dialog_Show(playerid, EsyaVer, DIALOG_STYLE_INPUT, "Eþya Ver", "{FFFFFF}Lütfen vermek istediðiniz miktarý girin:", "Ver", "Kapat");
	        }
	        if (PlayerData[id][pEsyalar][13] + miktar > 1)
	        {
	            HataMesajGonder(playerid, "Kiþi envanterinde en fazla 1 þarjör taþýyabilir.");
	            return Dialog_Show(playerid, EsyaVer, DIALOG_STYLE_INPUT, "Eþya Ver", "{FFFFFF}Lütfen vermek istediðiniz miktarý girin:", "Ver", "Kapat");
	        }
	        new idd[3];
	        format(idd, sizeof(idd), "%d", id);
	        callcmd::sarjorver(playerid, idd);
	    }
	    /*else if (strcmp(EsyaAdi[playerid], "Yan Keski", true) == 0)
	    {
	        if (miktar > PlayerData[playerid][pEsyalar][14])
	        {
	            HataMesajGonder(playerid, "Envanterinizde o kadar yan keski yok.");
	            return Dialog_Show(playerid, EsyaVer, DIALOG_STYLE_INPUT, "Eþya Ver", "{FFFFFF}Lütfen vermek istediðiniz miktarý girin:", "Ver", "Kapat");
	        }
	        if (PlayerData[id][pEsyalar][14] + miktar > 1)
	        {
	            HataMesajGonder(playerid, "Kiþi envanterinde en fazla 1 yan keski taþýyabilir.");
	            return Dialog_Show(playerid, EsyaVer, DIALOG_STYLE_INPUT, "Eþya Ver", "{FFFFFF}Lütfen vermek istediðiniz miktarý girin:", "Ver", "Kapat");
	        }
	        PlayerData[playerid][pEsyalar][14] = 0;
	        PlayerData[id][pEsyalar][14] = 1;
	        SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "* %s %s adlý kiþiye Yan Keski verir.", ReturnName(playerid, 0), ReturnName(id, 0));
	        MesajGonder(playerid, "%s adlý kiþiye yan keski verdiniz.", ReturnName(id, 0));
	        MesajGonder(id, "%s adlý kiþi size yan keski verdi.", ReturnName(playerid, 0));
	    }*/
	}
	return 1;
}
Dialog:EsyaVerID(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (isnull(inputtext)) return Dialog_Show(playerid, EsyaVerID, DIALOG_STYLE_INPUT, "Eþya Ver", "{FFFFFF}Lütfen eþyayý vermek istediðiniz oyuncunun ID'sini girin:", "Devam", "Kapat");
	    if (!IsNumeric(inputtext)) return Dialog_Show(playerid, EsyaVerID, DIALOG_STYLE_INPUT, "Eþya Ver", "{FFFFFF}Lütfen eþyayý vermek istediðiniz oyuncunun ID'sini girin:", "Devam", "Kapat");
	    new id = strval(inputtext);
	    if (!OyundaDegil(id))
	    {
	        HataMesajGonder(playerid, "Geçersiz ID girdiniz.");
	        return Dialog_Show(playerid, EsyaVerID, DIALOG_STYLE_INPUT, "Eþya Ver", "{FFFFFF}Lütfen eþyayý vermek istediðiniz oyuncunun ID'sini girin:", "Devam", "Kapat");
	    }
	    if (!IsPlayerNearPlayer(playerid, id, 5.0))
	    {
	        HataMesajGonder(playerid, "Kiþiye yeterince yakýn deðilsiniz.");
	        return Dialog_Show(playerid, EsyaVerID, DIALOG_STYLE_INPUT, "Eþya Ver", "{FFFFFF}Lütfen eþyayý vermek istediðiniz oyuncunun ID'sini girin:", "Devam", "Kapat");
	    }
	    if (id == playerid)
	    {
	        HataMesajGonder(playerid, "Kendi kendinize eþya veremezsiniz.");
	        return Dialog_Show(playerid, EsyaVerID, DIALOG_STYLE_INPUT, "Eþya Ver", "{FFFFFF}Lütfen eþyayý vermek istediðiniz oyuncunun ID'sini girin:", "Devam", "Kapat");
	    }
	    SetPVarInt(playerid, "EsyaVerID", id);
	    Dialog_Show(playerid, EsyaVer, DIALOG_STYLE_INPUT, "Eþya Ver", "{FFFFFF}Lütfen vermek istediðiniz miktarý girin:", "Ver", "Kapat");
	}
	return 1;
}
Dialog:Kupon(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (isnull(inputtext)) return Dialog_Show(playerid, Kupon, DIALOG_STYLE_INPUT, "Kupon Kodu", "{FFFFFF}Lütfen kupon kodunu aþaðýya yazýn:", "Devam", "Kapat");
	    new query[128];
		mysql_format(g_SQL, query, sizeof(query), "SELECT * FROM `kuponlar` WHERE `kod` = '%e'", inputtext);
		new Cache:Radless = mysql_query(g_SQL, query);
		if (cache_num_rows())
		{
			new para;
			cache_get_value_name_int(0, "para", para);

			ParaVer(playerid, para);
			mysql_format(g_SQL, query, sizeof(query), "DELETE FROM `kuponlar` WHERE `kod` = '%e'", inputtext);
			mysql_tquery(g_SQL, query);
			MesajGonder(playerid, "Kupon kodunu kullanarak %s kazandýnýz.", FormatNumber(para));
			AdminMessage(COLOR_LIGHTRED, "*** %s adlý kiþi '%s' kupon kodunu kullanarak %s kazandý.", Player_GetName(playerid), inputtext, FormatNumber(para));
		}
		else
		{
			HataMesajGonder(playerid, "Geçersiz kupon kodu girdiniz.");
		}
		cache_delete(Radless);
	}
	return 1;
}
Dialog:ckonay(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    ResetPlayer(playerid);
    	ResetWeapons(playerid);
    	ClearAnimations(playerid);
		PlayerTextDrawShow(playerid, HapisTD[playerid]);
		SetPlayerPos(playerid, 197.6346, 175.3765, 1003.0234);
    	SetPlayerInterior(playerid, 3);

    	SetPlayerVirtualWorld(playerid, (playerid + 100));
    	SetPlayerFacingAngle(playerid, 0.0);

    	SetCameraBehindPlayer(playerid);
    	PlayerData[playerid][pCK] = 1;
    	PlayerData[playerid][pHapisSure] = 9999999 * 60;
    	format(PlayerData[playerid][pHapisSebep], 50, "CK");
    	format(PlayerData[playerid][pHapiseAtan], 24, "Sistem");
    	PlayerData[playerid][pHapis] = 0;
    	MesajGonder(playerid, "Karakteriniz CK edildi.");
    	Oyuncu_Kaydet(playerid);
	}
	return 1;
}

Dialog:Yat(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (YatBilgi[yatKiralayan] != PlayerData[playerid][pID]) return 1;
	    switch (listitem)
	    {
	        case 0:
	        {
	            if (YatBilgi[yatOto] == 1) return HataMesajGonder(playerid, "Oto pilot özelliði açýk olduðu için bunu yapamazsýnýz.");
	            if (PlayerData[playerid][pYatKontrol][0] == 0)
	            {
        			TogglePlayerSpectating(playerid, true);
        			AttachCameraToObject(playerid, YatBilgi[yatSurObject]);
        			PlayerData[playerid][pYatKontrol][0] = 1;
        			PlayerData[playerid][pYatKontrol][1] = 0;
        			PlayerData[playerid][pYatKontrol][2] = 0;
        			PlayerData[playerid][pYatKontrol][3] = 0;
        			PlayerData[playerid][pYatKontrol][4] = 0;
	            }
	            else
	            {
	                new Float:yatX, Float:yatY, Float:yatZ;
	                PlayerData[playerid][pYatKontrol][0] = 0;
	                TogglePlayerSpectating(playerid, false);
	                GetObjectPos(YatBilgi[yatObject], yatX, yatY, yatZ);
	                SetPlayerPos(playerid, yatX, yatY, yatZ+3);
	                SetPlayerInterior(playerid, 0);
	                SetPlayerVirtualWorld(playerid, 0);
	                SetWeapons(playerid);
	            }
	        }
	        case 1:
	        {
	            Dialog_Show(playerid, YatMuzik, DIALOG_STYLE_INPUT, "Yat Müzik", "Lütfen açmak istediðiniz müziðin linkini girin:", "Aç", "Kapat");
	        }
	        case 2:
	        {
	            if (PlayerData[playerid][pYatKontrol][0] == 1) return HataMesajGonder(playerid, "Yatý kontrol ederken bunu yapamazsýnýz!");
	            if (YatBilgi[yatOto] == 0)
	            {
	                YatBilgi[yatOto] = 1;
	                MoveObject(YatBilgi[yatObject], YatRota[YatBilgi[yatStep]][0], YatRota[YatBilgi[yatStep]][1], YatRota[YatBilgi[yatStep]][2], 5, YatRota[YatBilgi[yatStep]][3], YatRota[YatBilgi[yatStep]][4], YatRota[YatBilgi[yatStep]][5]);
	            }
	            else
	            {
	                StopObject(YatBilgi[yatObject]);
	                YatBilgi[yatOto] = 0;
	            }
	        }
	        case 3:
	        {
	            Dialog_Show(playerid, KiraUzat, DIALOG_STYLE_MSGBOX, "Kira Süresi Uzatma", "{2ECC71}$10,000 {FFFFFF}miktar para ödeyerek kira süresini 1 saat uzatmak istediðinize emin misiniz?", "Evet", "Hayýr");
	        }
	    }
	}
	return 1;
}
Dialog:KiraUzat(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (PlayerData[playerid][pCash] < 10000) return HataMesajGonder(playerid, "Yeterli paranýz yok.");
	    YatBilgi[yatKiraSure] += 3600;
	    YatBilgi[yatUyari] = 0;
	    YatBilgi[yatTeslimSure] = 0;
	    ParaVer(playerid, -10000);
	    MesajGonder(playerid, "Kira süresi 1 saat uzatýldý.");
	}
	return 1;
}
Dialog:YatMuzik(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (isnull(inputtext)) return Dialog_Show(playerid, YatMuzik, DIALOG_STYLE_INPUT, "Yat Müzik", "Lütfen açmak istediðiniz müziðin linkini girin:", "Aç", "Kapat");

		new Float:yatX, Float:yatY, Float:yatZ;
	    GetObjectPos(YatBilgi[yatObject], yatX, yatY, yatZ);

	    foreach (new i:Player) if (IsPlayerInRangeOfPoint(playerid, 20.0, yatX, yatY, yatZ))
	    {
	        StopAudioStreamForPlayer(i);
	        PlayAudioStreamForPlayer(i, inputtext);
	    }
	}
	return 1;
}

Dialog:Soyun(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    switch (listitem)
	    {
	        case 0:
	        {
	            if (PlayerData[playerid][pCinsiyet] == 1) SetPlayerSkin(playerid, 18);
	            else SetPlayerSkin(playerid, 20286);
	        }
	        case 1:
	        {
	            if (PlayerData[playerid][pCinsiyet] == 1) SetPlayerSkin(playerid, 45);
	            else SetPlayerSkin(playerid, 20287);
	        }
	        case 2:
	        {
	            if (PlayerData[playerid][pCinsiyet] == 1) SetPlayerSkin(playerid, 97);
	            else SetPlayerSkin(playerid, 20288);
	        }
			case 3:
			{
			    if (PlayerData[playerid][pCinsiyet] == 1) SetPlayerSkin(playerid, 154);
	            else SetPlayerSkin(playerid, 20289);
			}
			case 4:
			{
			    if (PlayerData[playerid][pCinsiyet] == 1) SetPlayerSkin(playerid, 20283);
	            else SetPlayerSkin(playerid, 20290);
			}
			case 5:
			{
			    if (PlayerData[playerid][pCinsiyet] == 1) SetPlayerSkin(playerid, 20284);
	            else SetPlayerSkin(playerid, 20291);
			}
			case 6:
			{
			    if (PlayerData[playerid][pCinsiyet] == 1) SetPlayerSkin(playerid, 20285);
	            else SetPlayerSkin(playerid, 20292);
			}
		}
	    PlayerData[playerid][pSoyun] = true;
	    SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "* %s kýyafetlerini soyunur.", ReturnName(playerid, 0));
	}
	return 1;
}
Dialog:SistemSoru(playerid, response, listitem, inputtext[])
{
	if (!response) return callcmd::yardim(playerid);
	if (response)
	{
	    if (isnull(inputtext)) return Dialog_Show(playerid, SistemSoru, DIALOG_STYLE_INPUT, "Sisteme Sor", "{FFFFFF}Lütfen sorunuz hakkýnda bir anahtar kelime giriniz: \n\n{ff0000}NOT: {FFFFFF}Anahtar kelimesi 3 ile 20 karakter arasýnda olmalýdýr.", "Devam", "Kapat");
	    if (strlen(inputtext) < 3 || strlen(inputtext) > 20) return Dialog_Show(playerid, SistemSoru, DIALOG_STYLE_INPUT, "Sisteme Sor", "{FFFFFF}Lütfen sorunuz hakkýnda bir anahtar kelime giriniz: \n\n{ff0000}NOT: {FFFFFF}Anahtar kelimesi 3 ile 20 karakter arasýnda olmalýdýr.", "Devam", "Kapat");
	    SoruListele(playerid,inputtext);
	}
	return 1;
}
Dialog:Sorular(playerid, response, listitem, inputtext[])
{
	if (!response) return callcmd::yardim(playerid), format(AnahtarKelime[playerid],20, "");
	if (response)
	{
	    new soruid = SoruListeleme[playerid][listitem];
     	if (SoruData[soruid][soruExists])
      	{
      	    SoruData[soruid][OkunmaSayisi]++;
       		new str[300];
         	format(str,sizeof(str), "%s\n\n{00FFBF}Ekleyen: %s | Tarih: %s | Okunma Sayýsý: %d",SoruData[soruid][SoruCevap],SoruData[soruid][Ekleyen],SoruData[soruid][EklenmeTarihi],SoruData[soruid][OkunmaSayisi]);
          	Dialog_Show(playerid,SoruGoster,DIALOG_STYLE_MSGBOX, "Soru",str, "Kapat", "Geri");
            new query[124];
            format(query,sizeof(query), "UPDATE `sorular` SET `OkunmaSayisi` = '%d' WHERE `sid` = '%d'",SoruData[soruid][OkunmaSayisi],SoruData[soruid][soruID]);
            mysql_tquery(g_SQL,query);
       	}
	}
	return 1;
}
Dialog:SoruGoster(playerid, response, listitem, inputtext[])
{
	if (!response) return SoruListele(playerid,AnahtarKelime[playerid]);
	format(AnahtarKelime[playerid],20, "");
	return 1;
}
Dialog:top10soru(playerid, response, listitem, inputtext[])
{
	if (!response) return callcmd::yardim(playerid);
	if (response)
 	{
  		new soruuid = SoruListeleme[playerid][listitem];
    	if (SoruData[soruuid][soruExists])
     	{
     	    SoruData[soruuid][OkunmaSayisi]++;
      		new str[300];
        	format(str,sizeof(str), "%s\n\n{00FFBF}Ekleyen: %s | Tarih: %s | Okunma Sayýsý: %d",SoruData[soruuid][SoruCevap],SoruData[soruuid][Ekleyen],SoruData[soruuid][EklenmeTarihi],SoruData[soruuid][OkunmaSayisi]);
         	Dialog_Show(playerid,top10soru2,DIALOG_STYLE_MSGBOX, "Soru",str, "Kapat", "Geri");
           	new query[124];
            format(query,sizeof(query), "UPDATE `sorular` SET `OkunmaSayisi` = '%d' WHERE `sid` = '%d'",SoruData[soruuid][OkunmaSayisi],SoruData[soruuid][soruID]);
            mysql_query(g_SQL,query, false);
      	}
  	}
	return 1;
}
Dialog:top10soru2(playerid, response, listitem, inputtext[])
{
	if (!response) return SikcaSorulanSorular(playerid);
	return 1;
}
Dialog:Yardim(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    new string[2056], baslik[50];
		format(baslik, sizeof(baslik), "Regular Roleplay - %s", inputtext);

		for (new i = 0; i != MAX_YARDIM_KOMUTLARI; i ++)
		{
	 		if (Komutlar[i][komutVarmi] && Komutlar[i][komutKatagori] == listitem && Komutlar[i][komutOlusum] == -1)
			{
				new komutstr[512];
				format(komutstr, sizeof(komutstr), "{808080} • {FFFFFF}{808080}[{FFFFFF}%s{808080}]{FFFFFF} {FFFFFF}%s\n", Komutlar[i][komutAd], Komutlar[i][komutTanim]);
				strcat(string, komutstr);
			}
		}
		Dialog_Show(playerid, YardimGeriTusu, DIALOG_STYLE_MSGBOX, baslik, string, "Tamam", "Geri");
	}
	return 1;
}
Dialog:YardimGeriTusu(playerid, response, listitem, inputtext[])
{
	if (!response) callcmd::yardim(playerid);
	return 1;
}
Dialog:ModifiyeGarajlari(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    switch (listitem)
	    {
	        case 0:
	        {
	        	callcmd::cpsifirla(playerid);
	            SetPVarInt(playerid, "AraciniBuluyor", 1);
	            SetPlayerCheckpoint(playerid, 1041.0259,-1029.3878,32.1016, 5.0);
	            MesajGonder(playerid, "Modifiye garajý haritada iþaretlendi.");
	        }
	        case 1:
	        {
	        	callcmd::cpsifirla(playerid);
	            SetPVarInt(playerid, "AraciniBuluyor", 1);
	            SetPlayerCheckpoint(playerid, 2644.9888,-2034.6790,13.5540, 5.0);
	            MesajGonder(playerid, "Modifiye garajý haritada iþaretlendi.");
	        }
	        case 2:
	        {
	        	callcmd::cpsifirla(playerid);
	            SetPVarInt(playerid, "AraciniBuluyor", 1);
	            SetPlayerCheckpoint(playerid, -2712.9658,216.7289,4.2473, 5.0);
	            MesajGonder(playerid, "Modifiye garajý haritada iþaretlendi.");
	        }
	    }
	}
	return 1;
}
Dialog:TaksiMenu(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    new vehicleid = GetPlayerVehicleID(playerid);
	    new id = Car_GetID(vehicleid);
	    if (id == -1) return 1;
	    switch (listitem)
	    {
	        case 0, 2: callcmd::taksi(playerid);
	        case 1:
	        {
	            if (PlayerData[playerid][pTaxiDuty] == false)
	            {
	                PlayerData[playerid][pTaxiDuty] = true;
	                AracInfo[id][Taksimetre] = 30;
	                AracInfo[id][OturumKazanci] = 0;
	                foreach (new i:Player) if (PlayerData[i][pAyarlar][2] == 0)
	                {
	                    SendClientMessageEx(i, 0x42f445FF, "LS TAXI: %s plakalý taksi iþbaþý yaptý, '/ara 333' kullanarak taksi çaðýrabilirsin.", AracInfo[id][aracPlaka]);
	                }
	            }
	            else
	            {
	                PlayerTextDrawHide(playerid, TaxiTD[playerid][0]);
	                PlayerTextDrawHide(playerid, TaxiTD[playerid][1]);
	                foreach (new i: Player)
	                {
	                    if (IsPlayerInsideTaxi(i) && PlayerData[i][pTaxiPlayer] == playerid)
	                    {
							LeaveTaxi(i, playerid);

	                    }
	                }
	                PlayerData[playerid][pTaxiDuty] = false;
	                AracInfo[id][Taksimetre] = 30;
	                AracInfo[id][OturumKazanci] = 0;
	            }
	            callcmd::taksi(playerid);
	        }
	        case 3:
	        {
	            AracInfo[id][OturumKazanci] = 0;
	            callcmd::taksi(playerid);
	        }
	        case 4:
	        {
	            Dialog_Show(playerid, TaksimetreUcret, DIALOG_STYLE_INPUT, "Taksimetre Ücreti", "{FFFFFF}Lütfen yeni bir taksimetre ücretini girin:\n\n{f44542}NOT: {FFFFFF}En az $10, en fazla $300 girebilirsiniz.", "Deðiþtir", "Geri");
	        }
	        case 5:
	        {
	            if (IsValidDynamicObject(AracInfo[id][TaksiObje]))
	            {
	                DestroyDynamicObject(AracInfo[id][TaksiObje]);
	                callcmd::taksi(playerid);
	            }
	            else
	            {
					Dialog_Show(playerid, TaksiObje, DIALOG_STYLE_PREVMODEL, "Taksi Objeleri", "19308\n19309\n19310\n19311", "Sec", "Geri");
	            }
	        }
	        case 6:
	        {
	            if (PlayerData[playerid][pTaxiDuty] == false) return HataMesajGonder(playerid, "Taksimetre kapalý olduðu için taksi taleplerine bakamazsýnýz.");
	            new str[1000], count;
	            strcat(str, "#\tVatandaþ\tYer\n");
	            new Float:pos[3];
	            foreach (new i:Player) if (PlayerData[i][pTaxiCalled] == 1)
	            {
	                GetPlayerPosEx(i, pos[0], pos[1], pos[2]);
	                format(str, sizeof(str), "%s{FFFFFF}%d\t{FFFFFF}%s\t{FFFFFF}%s\n", str, i, ReturnName(i, 0), GetLocation(pos[0], pos[1], pos[2]));
	                count++;
	            }
	            if (count == 0) return HataMesajGonder(playerid, "Aktif taksi çaðrýsý bulunmuyor.");
	            Dialog_Show(playerid, TaksiTalepleri, DIALOG_STYLE_TABLIST_HEADERS, "Taksi Çaðrýlarý", str, "Kabul et", "Kapat");
	        }
	    }
	    if (listitem == 0 || listitem == 2) return callcmd::taksi(playerid);

	}
	return 1;
}
Dialog:TaksiTalepleri(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    new id = strval(inputtext);
	    if (PlayerData[playerid][pTaksiKabul] != -1) return HataMesajGonder(playerid, "Zaten birisinin taksi çaðrýsýný kabul etmiþsin. (/cpsifirla)");
	    if (PlayerData[id][pTaxiCalled] == 0) return HataMesajGonder(playerid, "Bu oyuncunun çaðrýsý baþka bir taksi þoförü tarafýndan kabul edildi.");
	    if (PlayerData[id][pTaxiCalled] == 1 && OyundaDegil(id))
	    {
	    	callcmd::cpsifirla(playerid);

	        PlayerData[id][pTaxiCalled] = 0;
	        PlayerData[playerid][pTaksiKabul] = id;
	        MesajGonder(id, "%s adlý taksici çaðrýnýzý kabul etti, sabit kalmaya çalýþýn birazdan burada olur.", ReturnName(playerid, 0));
	        MesajGonder(playerid, "%s adlý kiþinin taksi çaðrýsýný kabul ettiniz, kiþinin yeri haritada iþaretlendi.", ReturnName(id, 0));
	        new Float:pos[3];
	        GetPlayerPosEx(id, pos[0], pos[1], pos[2]);
	        SetPlayerCheckpoint(playerid, pos[0], pos[1], pos[2], 5.0);
	    }
	}
	return 1;
}
Dialog:TaksiObje(playerid, response, listitem, inputtext[])
{
	if (!response) return callcmd::taksi(playerid);
	if (response)
	{
	    new vehicleid = GetPlayerVehicleID(playerid);
	    new id = Car_GetID(vehicleid);
	    if (id == -1) return 1;
		new Float:pos[3];
		GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
		AracInfo[id][TaksiObje] = CreateDynamicObject(19308+listitem, pos[0], pos[1], pos[2], 0.0, 0.0, 0.0);

		SetPVarInt(playerid, "TaksiObje", 1);
		EditDynamicObject(playerid, AracInfo[id][TaksiObje]);
	}
	return 1;
}
Dialog:TaksimetreUcret(playerid, response, listitem, inputtext[])
{
	if (!response) return callcmd::taksi(playerid);
	if (response)
	{
	    new id = Car_GetID(GetPlayerVehicleID(playerid));
	    if (id == -1) return 1;
	    if (isnull(inputtext)) return Dialog_Show(playerid, TaksimetreUcret, DIALOG_STYLE_INPUT, "Taksimetre Ücreti", "{FFFFFF}Lütfen yeni bir taksimetre ücretini girin:\n\n{f44542}NOT: {FFFFFF}En az $10, en fazla $300 girebilirsiniz.", "Deðiþtir", "Geri");
	    if (!IsNumeric(inputtext)) return Dialog_Show(playerid, TaksimetreUcret, DIALOG_STYLE_INPUT, "Taksimetre Ücreti", "{FFFFFF}Lütfen yeni bir taksimetre ücretini girin:\n\n{f44542}NOT: {FFFFFF}En az $10, en fazla $300 girebilirsiniz.", "Deðiþtir", "Geri");
	    if (strval(inputtext) < 10 || strval(inputtext) > 300) return Dialog_Show(playerid, TaksimetreUcret, DIALOG_STYLE_INPUT, "Taksimetre Ücreti", "{FFFFFF}Lütfen yeni bir taksimetre ücretini girin:\n\n{f44542}NOT: {FFFFFF}En az $10, en fazla $300 girebilirsiniz.", "Deðiþtir", "Geri");
	    AracInfo[id][Taksimetre] = strval(inputtext);
	    callcmd::taksi(playerid);
	}
	return 1;
}
Dialog:TaksiPlakasi(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	    {
	        new vehicleid = GetPlayerVehicleID(playerid);
    		new id = Car_GetID(vehicleid);
    		if (!IsEngineVehicle(vehicleid) || IsVehicleBike(vehicleid) || id == -1 || GetVehicleMaxSeats(vehicleid) < 4 || AracInfo[id][aracTip] != 4 || GetVehicleModel(vehicleid) == 420) return HataMesajGonder(playerid, "Bu araca taksi plakasý alýnamaz.");
    		if (PlayerData[playerid][pCash] < 32000) return HataMesajGonder(playerid, "Yeterli paranýz yok. ($32,000)");
    		AracInfo[id][TaksiPlaka] = 1;
    		Arac_Kaydet(id);
    		MesajGonder(playerid, "{2ECC71}$32,000 {FFFFFF}ödeyerek aracýnýza taksi plakasý taktýrdýnýz. (/taksi)");
	    }
	}
	return 1;
}
Dialog:Paintball(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (listitem == 0)
	    {
	        if (OdasiVarmi(playerid) != -1) return HataMesajGonder(playerid, "Paintball odanýz varken baþka odaya katýlamazsýnýz.");
			pbOdalari(playerid);
	    }
	    if (listitem == 1)
	    {
	        if (OdasiVarmi(playerid) != -1) return HataMesajGonder(playerid, "Zaten odanýz var, (/pboda) ile oda ayarlarýna eriþebilirsiniz.");
			if (PlayerData[playerid][pCash] < ODA_PARA) return HataMesajGonder(playerid, "Oda kurmak için yeterli paranýz yok.");
			for (new i=0; i != MAX_ODA; i++) if (!Paintball[i][odaExists])
			{
			    Paintball[i][odaExists] = true;
			    format(Paintball[i][odaIsim], 30, "Adsýz Oda");
			    format(Paintball[i][odaSifre], 30, "");
			    Paintball[i][odaSahip] = playerid;
			    format(Paintball[i][odaTakim1Ad], 20, "Takým 1");
			    format(Paintball[i][odaTakim2Ad], 20, "Takým 2");
			    Paintball[i][odaSilahlar][0] = 24;
			    Paintball[i][odaSilahlar][1] = 25;
			    Paintball[i][odaSilahlar][2] = 29;
			    Paintball[i][odaSilahlar][3] = 31;
			    Paintball[i][odaZirh] = 100;
			    Paintball[i][odaSure] = 5;
			    Paintball[i][odaSayac] = Paintball[i][odaSure]*60;
			    Paintball[i][odaOyunTuru] = 1;
			    Paintball[i][odaArena] = 1;
			    Paintball[i][odaPuan][0] = 0;
			    Paintball[i][odaPuan][1] = 0;
			    Paintball[i][TakimDengeleme] = true;
			    Paintball[i][odaDurum] = ODA_BEKLEME;
			    pbOda[playerid] = i;
			    break;
			}
			new str[100];
			if (pbOda[playerid] == -1) format(str, sizeof(str), "{FF0000}» {FFFFFF}Sunucuda en fazla %d Paintball odasý oluþturulabilir.", MAX_ODA);
			else format(str, sizeof(str), "{00FF11}» {FFFFFF}Odanýz baþarýyla oluþturuldu (ID: %d), (/pboda) ile odanýzý düzenleyebilirsiniz.", pbOda[playerid]), ParaVer(playerid, -ODA_PARA);
			SendClientMessage(playerid, -1, str);
	    }
	}
	return 1;
}
Dialog:Giseler(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    switch (listitem)
	    {
	        case 0:
	        {
	            if (!AcilDurumMu())
	            {
		            AcilDurum = 1;

		            SendBirlikMessageEx(BIRLIK_LSPD, COLOR_DEPARTMENT, "* DEPARTMAN: Memur %s tarafýndan bütün giþeler kilitlendi.", ReturnName(playerid, 0));
		            SendBirlikMessageEx(BIRLIK_FBI, COLOR_DEPARTMENT, "* DEPARTMAN: Memur %s tarafýndan bütün giþeler kilitlendi.", ReturnName(playerid, 0));
	            }
	            else
	            {
	                AcilDurum = 0;

		            SendBirlikMessageEx(BIRLIK_LSPD, COLOR_DEPARTMENT, "* DEPARTMAN: Memur %s tarafýndan bütün giþeler açýldý.", ReturnName(playerid, 0));
		            SendBirlikMessageEx(BIRLIK_FBI, COLOR_DEPARTMENT, "* DEPARTMAN: Memur %s tarafýndan bütün giþeler açýldý.", ReturnName(playerid, 0));
	            }
	        }
	    }
	    GiseKontrolu(playerid);
	}
	return 1;
}
Dialog:Standlar(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    new Float:pos[4], str[100];
     	GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
     	GetPlayerFacingAngle(playerid, pos[3]);
      	pos[0] += (2 * floatsin(-pos[3], degrees));
   		pos[1] += (2 * floatcos(-pos[3], degrees));
	    switch (listitem)
	    {
	        case 0:
	        {
	            PlayerData[playerid][pStand] = true;
	            PlayerData[playerid][pStandObject] = CreateDynamicObject(1341, pos[0], pos[1], pos[2], 0.0, 0.0, 0.0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
				format(str, sizeof(str), "{a4f237}Stand\n{FFFFFF}Sahip: %s", ReturnName(playerid, 0));
				PlayerData[playerid][pStandText] = CreateDynamic3DTextLabel(str, -1, pos[0], pos[1], pos[2]+1.5, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
				MesajGonder(playerid, "Stand koydunuz, (/stand) komutunu kullanarak kaldýrabilirsiniz.");
	        }
	        case 1:
	        {
	            PlayerData[playerid][pStand] = true;
	            PlayerData[playerid][pStandObject] = CreateDynamicObject(1342, pos[0], pos[1], pos[2], 0.0, 0.0, 0.0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
				format(str, sizeof(str), "{a4f237}Stand\n{FFFFFF}Yerleþtiren: %s", ReturnName(playerid, 0));
				PlayerData[playerid][pStandText] = CreateDynamic3DTextLabel(str, -1, pos[0], pos[1], pos[2]+1.5, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
				MesajGonder(playerid, "Stand koydunuz, (/stand) komutunu kullanarak kaldýrabilirsiniz.");
	        }
	        case 2:
	        {
	            PlayerData[playerid][pStand] = true;
	            PlayerData[playerid][pStandObject] = CreateDynamicObject(1340, pos[0], pos[1], pos[2], 0.0, 0.0, 0.0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
				format(str, sizeof(str), "{a4f237}Stand\n{FFFFFF}Yerleþtiren: %s", ReturnName(playerid, 0));
				PlayerData[playerid][pStandText] = CreateDynamic3DTextLabel(str, -1, pos[0], pos[1], pos[2]+1.5, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
				MesajGonder(playerid, "Stand koydunuz, (/stand) komutunu kullanarak kaldýrabilirsiniz.");
	        }
	    }
	}
	return 1;
}
Dialog:Mulklerim(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    switch (listitem)
	    {
	        case 0:
	        {
	            callcmd::araclarim(playerid);
	        }
	        case 1:
	        {
	            EvListele(playerid, playerid);
	        }
	        case 2:
	        {
	            IsyeriListele(playerid, playerid);
	        }
	        case 3:
	        {
	            GateListele(playerid, playerid);
	        }
	        case 4:
	        {
	            callcmd::petlerim(playerid);
	        }
	        case 5:
	        {
	            GarajListele(playerid, playerid);
	        }
	    }
	}
	return 1;
}
Dialog:Evlerim(playerid, response, listitem, inputtext[])
{
	if (response) return callcmd::mulklerim(playerid);
	return 1;
}

Dialog:YarisDuzenle(playerid, response, listitem, inputtext[])
{
	if(response)
	{
	    new id = PlayerData[playerid][pYarisHazirliyormu];
		switch(listitem)
		{
		    case 0:
			{
			    new Float:pos[3];
			    GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
                Yarislar[id][yarisCPx][Yarislar[id][yarisCountCP]+1] = pos[0];
                Yarislar[id][yarisCPy][Yarislar[id][yarisCountCP]+1] = pos[1];
                Yarislar[id][yarisCPz][Yarislar[id][yarisCountCP]+1] = pos[2];
                Yarislar[id][yarisCountCP]++;
                MesajGonder(playerid, "Checkpoint eklendi, þu anki checkpoint sayýsý: %d", Yarislar[id][yarisCountCP]);
			}
			case 1:
			{

                Yarislar[id][yarisCPx][Yarislar[id][yarisCountCP]] = 0.0;
                Yarislar[id][yarisCPy][Yarislar[id][yarisCountCP]] = 0.0;
                Yarislar[id][yarisCPz][Yarislar[id][yarisCountCP]] = 0.0;
                Yarislar[id][yarisCountCP]--;
                MesajGonder(playerid, "Son checkpoint kaldýrýldý, þu anki checkpoint sayýsý: %d", Yarislar[id][yarisCountCP]);
			}
			case 2:
			{
			    if(Yarislar[id][yarisDurum] == 1) return HataMesajGonder(playerid, "Yarýþ zaten baþlatýlmýþ.");
		    	if(Yaris_ToplamKatilimci(id) < 1) return HataMesajGonder(playerid, "Yarýþý baþlatmak için en az iki katýlýmcý gereklidir.");
				MesajGonder(playerid, "Yarýþ az sonra baþlayacak!");
			    CallLocalFunction("YarisBaslat", "d", id);
			}
			case 3:
			{
			    if(Yarislar[id][yarisDurum] == 0) return HataMesajGonder(playerid, "Yarýþ zaten baþlatýlmamýþ.");
		    	MesajGonder(playerid, "Yarýþ durduruldu.");
                foreach(new i : Player) {
				    if(PlayerData[i][pYaris] == id) DisablePlayerRaceCheckpoint(i);
				}
				Yarislar[id][yarisGeriSayim] = 3;
	            Yarislar[id][yarisSiralama] = 0;
				Yarislar[id][yarisDurum] = 0;
			}
			case 4:
			{
		    	Dialog_Show(playerid, YarisKaydet, DIALOG_STYLE_INPUT, "{33CC33}Yarýþ Kaydetme", "Yarýþ checkpointlerini kaydetmek istediðiniz kodu girin (örnek: benimmapim);", "Kaydet", "{FF6347}Iptal");
			}
			case 5:
			{
		    	Dialog_Show(playerid, YarisYukle, DIALOG_STYLE_INPUT, "{33CC33}Yarýþ Yükleme", "Yarýþ checkpointlerini yüklemek istediðiniz kodu girin (örnek: benimmapim);", "Yükle", "{FF6347}Iptal");
			}
			case 7:
			{
                PlayerData[playerid][pYarisHazirliyormu] = -1;
			    Yarislar[id][yarisVarmi] = false;
	            Yarislar[id][yarisKayit] = false;
	            Yarislar[id][yarisGeriSayim] = 3;
	            Yarislar[id][yarisCountCP] = 0;
	            Yarislar[id][yarisSiralama] = 0;
	            Yarislar[id][yarisDurum] = 0;
	            for(new j=1; j < 64; j++)   {
	                Yarislar[id][yarisCPx][j] = 0.0;
	                Yarislar[id][yarisCPy][j] = 0.0;
	                Yarislar[id][yarisCPz][j] = 0.0;
				}
				foreach(new i : Player) {
				    if(PlayerData[i][pYaris] == id) DisablePlayerRaceCheckpoint(i);
				    PlayerData[i][pYaris] = -1;
				}
				MesajGonder(playerid, "Yarýþ bitirildi/iptal edildi.");
			}
			case 6:
			{
				Dialog_Show(playerid, YarisDavet, DIALOG_STYLE_INPUT, "{33CC33}Yarýþ Davet", "Yarýþa davet etmek istediðiniz kiþinin ID'sýný giriniz;", "Davet", "{FF6347}Iptal");
			}
		}
	}
	return 1;
}


Dialog:YarisDavet(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new userid = strval(inputtext);
		if(userid == playerid) return HataMesajGonder(playerid, "Kendini davet edemezsin.");
		if(!IsPlayerConnected(userid))
			return HataMesajGonder(playerid, "Geçersiz ID girdiniz.");

		if(PlayerData[userid][pYaris] != -1 || PlayerData[userid][pYarisHazirliyormu] != -1)
 			return HataMesajGonder(playerid, "Kiþi þu anda baþka yarýþta.");

 		SetPVarInt(playerid, "DavetEdildigiYaris", PlayerData[playerid][pYarisHazirliyormu]);
 		SetPVarInt(playerid, "YarisaDavetEden", playerid);
		callcmd::yaris(playerid, "\1");
		Dialog_Show(userid, YarisDavetOnay, DIALOG_STYLE_MSGBOX, "{33CC33}Gelen Yarýþ Daveti", "{FFFFFF}%s seni '%s' adlý yarýþa davet ediyor, onaylýyor musun?", "Kabul", "{FF6347}Red", ReturnName(playerid, 0), Yarislar[PlayerData[playerid][pYarisHazirliyormu]][yarisAd]);
		MesajGonder(playerid, "%s yarýþa davet edildi.", ReturnName(userid, 0));
	}
	return 1;
}

Dialog:YarisDavetOnay(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new yarisid = GetPVarInt(playerid, "DavetEdildigiYaris"), daveteden = GetPVarInt(playerid, "YarisaDavetEden");

		if(!IsPlayerConnected(daveteden))
			return HataMesajGonder(playerid, "Sizi davet eden kiþi oyundan çýkmýþ.");

		PlayerData[playerid][pYaris] = yarisid;
        MesajGonder(playerid, "Yarýþa katýldýn.");
		MesajGonder(daveteden, "%s yarýþçý davetini kabul etti.", ReturnName(playerid, 0));
	}
	return 1;
}

Dialog:YarisOlustur(playerid, response, listitem, inputtext[])
{
	if(response)
	{
	    for (new i = 0; i < MAX_YARIS; i ++) if (!Yarislar[i][yarisVarmi])
		{
		    PlayerData[playerid][pYarisHazirliyormu] = i;
        	PlayerData[playerid][pYaris] = i;
		    Yarislar[i][yarisVarmi] = true;
            Yarislar[i][yarisKayit] = false;
            Yarislar[i][yarisGeriSayim] = 3;
            Yarislar[i][yarisSiralama] = 0;
            Yarislar[i][yarisCountCP] = 0;
            for(new j=1; j < 64; j++)   {
                Yarislar[i][yarisCPx][j] = 0.0;
                Yarislar[i][yarisCPy][j] = 0.0;
                Yarislar[i][yarisCPz][j] = 0.0;
			}

            format(Yarislar[i][yarisAd], 24, inputtext);
            format(Yarislar[i][yarisKurucu], 24, "%s", ReturnName(playerid));
            MesajGonder(playerid, "%s adlý yarýþ oluþturuldu, /yarisduzenle ile yarýþý düzenleyebilirsiniz.", inputtext);
			break;
		}
	}
	return 1;
}
Dialog:ServerPanel(playerid, response, listitem, inputtext[])
{
	if (PlayerData[playerid][pAdmin] < 4) return 0;
	if (response)
	{
	    switch (listitem)
	    {
	        case 0:
	        {
		        if (sunucuKilitli)
	         	{
	          		sunucuKilitli = false;

					SendRconCommand("password 0");
	    			AdminMessage(COLOR_LIGHTRED, "[Bilgi]: {FFFFFF}%s sunucunun kilidini kaldýrdý.", PlayerData[playerid][pAdminName]);
				}
	   			else Dialog_Show(playerid, LockServer, DIALOG_STYLE_INPUT, "Kilitle", "Lütfen sunucuya koymak istediðiniz þifreyi girin:", "Kilitle", "Geri");
   			}
   			case 1:
   			{
   			    Dialog_Show(playerid, SetHostname, DIALOG_STYLE_INPUT, "Hostname Deðiþtir", "Lütfen hostname girin:", "Tamam", "<< Geri");
   			}
   			case 2:
   			{
   			    Dialog_Show(playerid, ExecuteQuery, DIALOG_STYLE_INPUT, "Sorgu Çalýþtýr", "Lütfen çalýþtýrmak istediðiniz sorguyu girin:", "Çalýþtýr", "Geri");
   			}
   			case 3:
   			{
   			    if (GetServerBilgi("bakimModu") == 1)
   			    {
   			        SetServerBilgi("bakimModu", 0);
   			        SendClientMessageToAllEx(COLOR_LIGHTRED, "[Bilgi]: {FFFFFF}%s adlý yetkili tarafýndan bakým modu kapatýldý.", PlayerData[playerid][pAdminName]);
   			    }
   			    else
   			    {
   			        Dialog_Show(playerid, BakimSifre, DIALOG_STYLE_INPUT, "Bakým Modu", "Sunucuyu bakýma almak için þifre belirlemelisiniz:", "Bakýma Al", "Kapat");
   			    }
   			}
   			case 4:
   			{
   			    if (GetServerBilgi("basvurudurum") == 1)
   			    {
   			        SetServerBilgi("basvurudurum", 0);
   			        MesajGonder(playerid, "Karakter baþvurularý kapatýldý.");
   			    }
   			    else
   			    {
   			        SetServerBilgi("basvurudurum", 1);
   			        MesajGonder(playerid, "Karakter baþvurularý açýlmýþtýr.");
   			    }
   			}
	    }
	}
	return 1;
}
Dialog:BakimSifre(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (isnull(inputtext)) return Dialog_Show(playerid, BakimSifre, DIALOG_STYLE_INPUT, "Bakým Modu", "Sunucuyu bakýma almak için þifre belirlemelisiniz:", "Bakýma Al", "Kapat");
	    SetServerBilgi("bakimModu", 1);
	    SetServerBilgiStr("bakimSifre", inputtext);
     	AdminHelperMessage(COLOR_LIGHTRED, "[Bilgi]: {FFFFFF}%s adlý yetkili sunucuyu bakým moduna aldý.", PlayerData[playerid][pAdminName]);
	}
	return 1;
}
Dialog:ExecuteQuery(playerid, response, listitem, inputtext[])
{
    if (PlayerData[playerid][pAdmin] < 4)
        return 0;

    if (response)
    {
        if (isnull(inputtext))
            return Dialog_Show(playerid, ExecuteQuery, DIALOG_STYLE_INPUT, "Sorgu Çalýþtýr", "Lütfen çalýþtýrmak istediðiniz sorguyu girin:", "Çalýþtýr", "Geri");

        if (strfind(inputtext, "DELETE", true) != -1 || strfind(inputtext, "DROP", true) != -1)
            return Dialog_Show(playerid, ExecuteQuery, DIALOG_STYLE_INPUT, "Sorgu Çalýþtýr", "HATA: DROP ve DELETE sorgularýný çalýþtýramazsýnýz!\nLütfen çalýþtýrmak istediðiniz sorguyu girin:", "Çalýþtýr", "Geri");

        mysql_tquery(g_SQL, inputtext, "OnQueryExecute", "ds", playerid, inputtext);
    }
    else callcmd::panel(playerid);
    return 1;
}
Dialog:SetHostname(playerid, response, listitem, inputtext[])
{
    if (PlayerData[playerid][pAdmin] < 4)
        return 0;

    if (response)
    {
        if (isnull(inputtext))
            return Dialog_Show(playerid, SetHostname, DIALOG_STYLE_INPUT, "Hostname Deðiþtir", "Lütfen hostname girin:", "Tamam", "<< Geri");

        static
            str[128];

        format(str, sizeof(str), "hostname %s", inputtext);

        SendRconCommand(str);
        AdminMessage(COLOR_LIGHTRED, "[Bilgi]: {FFFFFF}%s sunucu adýný \"%s\" olarak deðiþtirdi.", PlayerData[playerid][pAdminName], inputtext);
    }
    else callcmd::panel(playerid);
    return 1;
}
Dialog:LockServer(playerid, response, listitem, inputtext[])
{
    if (PlayerData[playerid][pAdmin] < 4)
        return 0;

    if (response)
    {
        if (isnull(inputtext) || !strcmp(inputtext, "0"))
            return Dialog_Show(playerid, LockServer, DIALOG_STYLE_INPUT, "Kilitle", "Lütfen sunucuya koymak istediðiniz þifreyi girin:", "Kilitle", "Geri");

        if (strlen(inputtext) > 32)
            return Dialog_Show(playerid, LockServer, DIALOG_STYLE_INPUT, "Kilitle", "Lütfen sunucuya koymak istediðiniz þifreyi girin:", "Kilitle", "Geri");

        static
            str[48];

        format(str, sizeof(str), "password %s", inputtext);
        sunucuKilitli = true;

        SendRconCommand(str);
        AdminMessage(COLOR_LIGHTRED, "[Bilgi]: {FFFFFF}%s tarafýndan sunucu kilitlendi.", PlayerData[playerid][pAdminName]);
    }
    else callcmd::panel(playerid);
    return 1;
}
Dialog:nrn(playerid, response, listitem, inputtext[]) {
    if (response)
    {
        if (isnull(inputtext)) return Dialog_Show(playerid, nrn, DIALOG_STYLE_INPUT, "Ýsim Deðiþtirme Talebi", "Lütfen boþ býrakmayýn!\nLütfen yeni isim girin.\n - Ad_Soyad tarzýnda olmalý.\n - Yabancý ad soyad olmalý.\n - Ünlü adý olmamalý.", "Deðiþtir", "Iptal");
	    if (strlen(inputtext) <= 3)
	    {
	        HataMesajGonder(playerid, "Çok kýsa bir ad girdiniz.");
	        return Dialog_Show(playerid, nrn, DIALOG_STYLE_INPUT, "Ýsim Deðiþtirme Talebi", "Çok kýsa bir ad girdiniz!\nLütfen yeni isim girin.\n - Ad_Soyad tarzýnda olmalý.\n - Yabancý ad soyad olmalý.\n - Ünlü adý olmamalý.", "Deðiþtir", "Iptal");
	    }
	    if (!IsValidRoleplayName(inputtext))
	    {
	        HataMesajGonder(playerid, "Ýsminiz Ad_Soyad formatýnda olmalýdýr. (Örnek: Sawyer_Ford)");
	        return Dialog_Show(playerid, nrn, DIALOG_STYLE_INPUT, "Ýsim Deðiþtirme Talebi", "Ýsminiz Ad_Soyad formatýnda olmalýdýr.\nLütfen yeni isim girin.\n - Ad_Soyad tarzýnda olmalý.\n - Yabancý ad soyad olmalý.\n - Ünlü adý olmamalý.", "Deðiþtir", "Iptal");
	    }
	    if (SoyadKilitlimi(GetPlayerLastName(playerid, inputtext, 0)))
	    {
	        HataMesajGonder(playerid, "Yazdýðýnýz soyad kilitlenmiþ.");
	        return Dialog_Show(playerid, nrn, DIALOG_STYLE_INPUT, "Ýsim Deðiþtirme Talebi", "Bu soyadý kullanamazsýnýz, kilitlenmiþ!\nLütfen yeni isim girin.\n - Ad_Soyad tarzýnda olmalý.\n - Yabancý ad soyad olmalý.\n - Ünlü adý olmamalý.", "Deðiþtir", "Iptal");
	    }
	    if (!IsimKontrol(inputtext))
	    {
	        HataMesajGonder(playerid, "Bu isim baþkasý tarafýndan kullanýlmaktadýr.");
	        return Dialog_Show(playerid, nrn, DIALOG_STYLE_INPUT, "Ýsim Deðiþtirme Talebi", "Bu isim kullanýlýyor.\nLütfen yeni isim girin.\n - Ad_Soyad tarzýnda olmalý.\n - Yabancý ad soyad olmalý.\n - Ünlü adý olmamalý.", "Deðiþtir", "Iptal");
	    }
	    format(PlayerData[playerid][pNameChange], 24, inputtext);
	    AdminMessage(COLOR_GREEN, "[Bilgi]: {FFFFFF}%s (%d) isim deðiþtirme talep ediyor, Yeni isim: %s (\"/an\" ya da \"/dn\").", Player_GetName(playerid),playerid, inputtext);
    	MesajGonder(playerid, "Ýsim deðiþtirme talebiniz yetkililere iletildi, lütfen bekleyiniz.");
    }
    else Dialog_Show(playerid, nrn, DIALOG_STYLE_INPUT, "Ýsim Deðiþtirme Talebi", "Lütfen boþ býrakmayýn!\nLütfen yeni isim girin.\n - Ad_Soyad tarzýnda olmalý.\n - Yabancý ad soyad olmalý.\n - Ünlü adý olmamalý.", "Deðiþtir", "Iptal");
    return 1;
}
Dialog:AEsyaVer(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    new id = GetPVarInt(playerid, "oyuncuID");
	    if (!OyundaDegil(id)) return HataMesajGonder(playerid, "Oyuncu çýkmýþ.");
	    PlayerData[id][pEsyalar][listitem]++;
	    MesajGonder(playerid, "%s adlý kiþiye %s adlý eþyayý verdiniz.", ReturnName(id, 0), inputtext);
	}
	return 1;
}
Dialog:TalepIncele(playerid, response, listitem, inputtext[])
{
	new id = GetPVarInt(playerid, "TalepID");
	if (!response)
	{
		Talep[id][tIlgilenen] = -1;
		DeletePVar(playerid, "TalepID");
		return TalepListele(playerid);
	}
	else
	{
	    if (Talep[id][tExists] == false || Talep[id][tIlgilenen] != playerid) return HataMesajGonder(playerid, "Bu rapor talebi silindi veya baþkasý ilgileniyor.");
	    if (strfind(inputtext, "Cevapla", true) != -1)
	    {
	        Dialog_Show(playerid, TalepCevapla, DIALOG_STYLE_INPUT, "Talep Cevapla", "%s\n \n \nLütfen bu rapor talebine vermek istediðiniz cevabý yazýn:", "Cevapla", "Geri", Talep[id][tIcerik]);
	        return 1;
	    }
	    new rank[20];
    	if (PlayerData[playerid][pHelper] > 0) format(rank, sizeof(rank), "(Lv. %d) Helper", PlayerData[playerid][pHelper]);
    	else format(rank, sizeof(rank), "%s", GetAdminRank(playerid));
	    if (strfind(inputtext, "Reddet", true) != -1)
	    {
	        PlayerData[playerid][pTalepSayi]++;
	        BilgiMesajGonder(Talep[id][tGonderen], "%s %s tarafýndan rapor talebiniz silindi.", rank, PlayerData[playerid][pAdminName]);
	        AdminHelperMessage(COLOR_LIGHTRED, "ADM: %s %s, %s adlý oyuncunun talebini sildi.", rank, PlayerData[playerid][pAdminName], Player_GetName(Talep[id][tGonderen]));
	        Talep[id][tExists] = false;
	    	Talep[id][tGonderen] = -1;
	    	Talep[id][tIlgilenen] = -1;
	    	format(Talep[id][tIcerik], 128, "");
	    	return 1;
	    }
	    if (strfind(inputtext, "Foruma Yönlendir", true) != -1)
	    {
	        PlayerData[playerid][pTalepSayi]++;
	        PlayerPlaySound(Talep[id][tGonderen], 1085, 0.0, 0.0, 0.0);
	        SendClientMessageEx(Talep[id][tGonderen], COLOR_YELLOW, "[CEVAP] %s %s: Merhabalar, rapor talebinizin cevabýný forum sitemizden bulabilirsiniz. (www.regular-roleplay.com)", rank, PlayerData[playerid][pAdminName]);
	        AdminHelperMessage(COLOR_LIGHTRED, "ADM: %s %s, %s adlý kiþinin rapor talebini foruma yönlendirdi.", rank, PlayerData[playerid][pAdminName], Player_GetName(Talep[id][tGonderen]));
	        Talep[id][tExists] = false;
	    	Talep[id][tGonderen] = -1;
	    	Talep[id][tIlgilenen] = -1;
	    	format(Talep[id][tIcerik], 128, "");
	    	return 1;
	    }
	    	    if (strfind(inputtext, "Discorda Yönlendir", true) != -1)
	    {
	        PlayerData[playerid][pTalepSayi]++;
	        PlayerPlaySound(Talep[id][tGonderen], 1085, 0.0, 0.0, 0.0);
	        SendClientMessageEx(Talep[id][tGonderen], COLOR_YELLOW, "[CEVAP] %s %s: Merhabalar, destek talebinizin cevabýný discord adresimizden bulabilirsiniz.", rank, PlayerData[playerid][pAdminName]);
	        SendClientMessageEx(Talep[id][tGonderen], COLOR_YELLOW, "[CEVAP] Lütfen discordumuzu ziyaret ediniz. https://discord.gg/Eklenicek");
	        AdminHelperMessage(COLOR_LIGHTRED, "AdmLog: %s %s, %s adlý kiþinin rapor talebini discorda yönlendirdi.", rank, PlayerData[playerid][pAdminName], Player_GetName(Talep[id][tGonderen]));
	        Log_Write("logs/DCyonlendir.log", "[%s] %s %s, %s adlý kiþinin rapor talebini discorda yönlendirdi. Ýçerik: %s", ReturnDate(), rank, PlayerData[playerid][pAdminName], Player_GetName(Talep[id][tGonderen]), Talep[id][tIcerik]);
	        Talep[id][tExists] = false;
	    	Talep[id][tGonderen] = -1;
	    	Talep[id][tIlgilenen] = -1;
	    	format(Talep[id][tIcerik], 128, "");
	    	return 1;
	    }
		if (strfind(inputtext, "Uyar", true) != -1)
	    {
		 new userid;
            PlayerData[userid][pTalepSure] = 1;
		    MesajGonder(playerid, "%s adlý kiþi uyardýnýz.", ReturnName(userid, 0));
	        SendClientMessageEx(Talep[id][tGonderen], COLOR_LIGHTRED, "%s %s adlý yetkili sizi uyardý, tekrarý halinde cezalandýrýlacaksýnýz.", rank, PlayerData[playerid][pAdminName]);
	        AdminHelperMessage(COLOR_LIGHTRED, "AdmLog: %s %s, %s adlý kiþiyi uyardý.", rank, PlayerData[playerid][pAdminName], Player_GetName(Talep[id][tGonderen]));
	        Log_Write("logs/talepuyarý.log", "[%s] %s %s, %s adlý kiþiyi uyardý. Ýçerik: %s", ReturnDate(), rank, PlayerData[playerid][pAdminName], Player_GetName(Talep[id][tGonderen]), Talep[id][tIcerik]);
	        Talep[id][tExists] = false;
	    	Talep[id][tGonderen] = -1;
	    	Talep[id][tIlgilenen] = -1;
	    	format(Talep[id][tIcerik], 128, "");
	    	return 1;
	    }
	    if (strfind(inputtext, "Ýncelemeye Al", true) != -1)
	    {
	        if(PlayerData[playerid][pAdmin] < 1 || PlayerData[playerid][pOyunGorevlisi] > 0) return HataMesajGonder(playerid, "Bunu kullanamazsýnýz.");
	        PlayerData[playerid][pTalepSayi]++;
	        PlayerPlaySound(Talep[id][tGonderen], 1085, 0.0, 0.0, 0.0);
	        SendClientMessageEx(Talep[id][tGonderen], COLOR_YELLOW, "[CEVAP] %s %s: Merhabalar, rapor talebinizi þu anda incelemekteyim. Lütfen sabýrlý ve anlayýþlý olun.", rank, PlayerData[playerid][pAdminName]);
	        AdminHelperMessage(COLOR_LIGHTRED, "ADM: %s %s, %s adlý kiþinin rapor talebini incelemeye aldý.", rank, PlayerData[playerid][pAdminName], Player_GetName(Talep[id][tGonderen]));
	        Talep[id][tExists] = false;
	    	Talep[id][tGonderen] = -1;
	    	Talep[id][tIlgilenen] = -1;
	    	format(Talep[id][tIcerik], 128, "");
	    	return 1;
	    }
	    if (strfind(inputtext, "Ýncelendi ve Reddedildi", true) != -1)
	    {
	        if(PlayerData[playerid][pAdmin] < 1 || PlayerData[playerid][pOyunGorevlisi] > 0) return HataMesajGonder(playerid, "Bunu kullanamazsýnýz.");
	        PlayerData[playerid][pTalepSayi]++;
	        PlayerPlaySound(Talep[id][tGonderen], 1085, 0.0, 0.0, 0.0);
	        SendClientMessageEx(Talep[id][tGonderen], COLOR_YELLOW, "[CEVAP] %s %s: Merhabalar, rapor talebiniz incelendi ve reddedildi.", rank, PlayerData[playerid][pAdminName]);
	        AdminHelperMessage(COLOR_LIGHTRED, "ADM: %s %s, %s adlý kiþinin rapor talebini inceledi ve reddetti.", rank, PlayerData[playerid][pAdminName], Player_GetName(Talep[id][tGonderen]));
	        Talep[id][tExists] = false;
	    	Talep[id][tGonderen] = -1;
	    	Talep[id][tIlgilenen] = -1;
	    	format(Talep[id][tIcerik], 128, "");
	    	return 1;
	    }
	    TalepIlgilen(playerid, id);
	}
	return 1;
}

Dialog:TalepCevapla(playerid, response, listitem, inputtext[])
{
	new id = GetPVarInt(playerid, "TalepID");
	if (!response)
	{
		TalepIlgilen(playerid, id);
	}
	else
	{
	    if (Talep[id][tExists] == false) return HataMesajGonder(playerid, "Rapor talebi silinmiþ.");
	    if (isnull(inputtext)) return Dialog_Show(playerid, TalepCevapla, DIALOG_STYLE_INPUT, "Talep Cevapla", "%s\n\nLütfen bu rapor talebine vermek istediðiniz cevabý yazýn:", "Cevapla", "Geri", Talep[id][tIcerik]);
	    new rank[20];
	    if (PlayerData[playerid][pHelper] > 0) format(rank, sizeof(rank), "(Lv. %d) Helper", PlayerData[playerid][pHelper]);
	    else format(rank, sizeof(rank), "%s", GetAdminRank(playerid));
	    PlayerData[playerid][pTalepSayi]++;
	    PlayerPlaySound(Talep[id][tGonderen], 1085, 0.0, 0.0, 0.0);
	    if (strlen(inputtext) > 64)
	    {
	        SendClientMessageEx(Talep[id][tGonderen], COLOR_YELLOW, "[CEVAP] %s %s: %.64s", rank, PlayerData[playerid][pAdminName], inputtext);
	        SendClientMessageEx(Talep[id][tGonderen], COLOR_YELLOW, "...%s", inputtext[64]);
	    }
	    else
	    {
	        SendClientMessageEx(Talep[id][tGonderen], COLOR_YELLOW, "[CEVAP] %s %s: %s", rank, PlayerData[playerid][pAdminName], inputtext);
	    }
	    AdminHelperMessage(COLOR_LIGHTRED, "ADM: %s %s, %s(ID: %d) adlý kiþinin soru talebini cevapladý.", rank, PlayerData[playerid][pAdminName], Player_GetName(Talep[id][tGonderen]), Talep[id][tGonderen]);
	    Talep[id][tExists] = false;
	    Talep[id][tGonderen] = -1;
	    Talep[id][tIlgilenen] = -1;
	    format(Talep[id][tIcerik], 128, "");
	}
	return 1;
}

Dialog:TalepYok(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (PlayerData[playerid][pAdmin] > 0 || PlayerData[playerid][pHelper] > 0 || PlayerData[playerid][pForumGorevlisi] > 0 || PlayerData[playerid][pOyunGorevlisi] > 0) return TalepListele(playerid);
	}
	return 1;
}

Dialog:DestekTalepleri(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    new id = strval(inputtext);
	    if (Talep[id][tExists] == false || !IsPlayerConnected(Talep[id][tGonderen]))
	    {
	        HataMesajGonder(playerid, "Bu soru talebi silindi veya sonuçlandý.");
	        return TalepListele(playerid);
	    }
	    if (Talep[id][tIlgilenen] != -1 && IsPlayerConnected(Talep[id][tIlgilenen]))
	    {
	        HataMesajGonder(playerid, "Bu soru talebi ile baþkasý ilgilenmekte.");
	        return TalepListele(playerid);
	    }
	    TalepIlgilen(playerid, id);
	}
	return 1;
}
Dialog:Graffiti(playerid, response, listitem, inputtext[])
{
	if (!response) return PlayerData[playerid][pGraffiti] = 0;
	if (response)
	{
	    if (isnull(inputtext)) return Dialog_Show(playerid, Graffiti, DIALOG_STYLE_INPUT, "Graffiti ~ Yazý", "{FFFFFF}Lütfen graffiti yazýsýný girin.\n{FFFFFF}Yazý içerisinde #renk ile renklendirme yapabilirsiniz. (#kirmizi, #mavi vs.)\n{ff0000}Not: {FFFFFF}Yazý 64 karakteri geçemez.", "Devam", "Kapat");
	    if (strlen(inputtext) < 3 || strlen(inputtext) > 64)
	    {
	        HataMesajGonder(playerid, "Yazý 3 ile 64 karakter arasýnda olmalýdýr.");
	        return Dialog_Show(playerid, Graffiti, DIALOG_STYLE_INPUT, "Graffiti ~ Yazý", "{FFFFFF}Lütfen graffiti yazýsýný girin.\n{FFFFFF}Yazý içerisinde #renk ile renklendirme yapabilirsiniz. (#kirmizi, #mavi vs.)\n{ff0000}Not: {FFFFFF}Yazý 64 karakteri geçemez.", "Devam", "Kapat");
	    }
	    new tmp[300];

		set(tmp, inputtext);
	    tmp = strreplace("#kirmizi", "{f9071f}", tmp);
	    tmp = strreplace("#mavi", "{0000FF}", tmp);
	    tmp = strreplace("#sari", "{FFFF00}", tmp);
	    tmp = strreplace("#yesil", "{00FF00}", tmp);
	    tmp = strreplace("#beyaz", "{FFFFFF}", tmp);
	    tmp = strreplace("#turuncu", "{FF8000}", tmp);

	    format(PlayerData[playerid][pGraffitiYazi], 64, tmp);
	    Dialog_Show(playerid, GraffitiFont, DIALOG_STYLE_INPUT, "Graffiti Fontu", "Lütfen font yazýn:", "Tamam", "Iptal");
	}
	return 1;
}

Dialog:GraffitiFont(playerid, response, listitem, inputtext[])
{
	if (!response) return Dialog_Show(playerid, Graffiti, DIALOG_STYLE_INPUT, "Graffiti ~ Yazý", "{FFFFFF}Lütfen graffiti yazýsýný girin.\n{FFFFFF}Yazý içerisinde #renk ile renklendirme yapabilirsiniz. (#kirmizi, #mavi vs.)\n{ff0000}Not: {FFFFFF}Yazý 64 karakteri geçemez.", "Devam", "Kapat");
	if (response)
	{
	    new Float:pos[3];
	    GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
	    new id = Graffiti_Create(pos[0], pos[1], pos[2]);
	    if (id == -1) return HataMesajGonder(playerid, "Graffiti oluþturulamadý.");
	    format(GraffitiData[id][graffitiText], 64, PlayerData[playerid][pGraffitiYazi]);
	    format(GraffitiData[id][graffitiFont], 64, inputtext);

	    Graffiti_Refresh(id);
	    Graffiti_Save(id);
	    SetPVarInt(playerid, "GraffitiEdit", id);
	    EditDynamicObject(playerid, GraffitiData[id][graffitiObject]);

	}
	return 1;
}
Dialog:TeleportInterior(playerid, response, listitem, inputtext[])
{
    if (response)
    {
        SetPlayerInterior(playerid, g_arrInteriorData[listitem][e_InteriorID]);
        SetPlayerPos(playerid, g_arrInteriorData[listitem][e_InteriorX], g_arrInteriorData[listitem][e_InteriorY], g_arrInteriorData[listitem][e_InteriorZ]);
        SetPlayerVirtualWorld(playerid, 0);
        PlayerData[playerid][pHouse] = -1;
       	PlayerData[playerid][pIsyeri] = -1;
        PlayerData[playerid][pGarage] = -1;
        PlayerData[playerid][pCadir] = -1;
    }
    return 1;
}
Dialog:AyarlarGiris(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (isnull(inputtext)) return callcmd::ayarlar(playerid);
	    new query[300];
	    format(query, sizeof(query), "SELECT null FROM `oyuncular` WHERE `Isim` = '%s' AND `Sifre` = md5('%s')", Player_GetName(playerid), inputtext);
	    new Cache:Radless = mysql_query(g_SQL, query);
	    new rows;
	    cache_get_row_count(rows);
	    if (!rows)
	    {
	        cache_delete(Radless);
	        HataMesajGonder(playerid, "Yanlýþ þifre girdiniz.");
	        return callcmd::ayarlar(playerid);
	    }
	    Dialog_Show(playerid, Ayarlar, DIALOG_STYLE_LIST, "{FFFFFF}Hesap Ayarlarý", "{FFFFFF}Þifre Deðiþtir\n{FFFFFF}TOG\n{FFFFFF}Yürüyüþ Stili\n{FFFFFF}Bildirimler", "Seç", "Kapat");
	}
	return 1;
}
Dialog:TOG(playerid, response, listitem, inputtext[])
{
	if (!response) return Dialog_Show(playerid, Ayarlar, DIALOG_STYLE_LIST, "{FFFFFF}Hesap Ayarlarý", "{FFFFFF}Þifre Deðiþtir\n{FFFFFF}TOG\n{FFFFFF}Yürüyüþ Stili\n{FFFFFF}Bildirimler", "Seç", "Kapat");
	if (response)
	{
	    if (PlayerData[playerid][pAyarlar][listitem] == 0)
	    {
	        PlayerData[playerid][pAyarlar][listitem] = 1;
	    }
	    else
	    {
	        PlayerData[playerid][pAyarlar][listitem] = 0;
	    }
	    if (PlayerData[playerid][pAyarlar][5] == 1)
	    {
	        foreach (new i:Player)
	        {
	            Streamer_RemoveArrayData(STREAMER_TYPE_3D_TEXT_LABEL, NameTag[i], E_STREAMER_PLAYER_ID, playerid);
	        }
	    }
	    else
	    {
	        foreach (new i:Player)
	        {
	            Streamer_AppendArrayData(STREAMER_TYPE_3D_TEXT_LABEL, NameTag[i], E_STREAMER_PLAYER_ID, playerid);
	        }
	    }
	    TOGMenu(playerid);
	}
	return 1;
}
Dialog:Ayarlar(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (listitem == 0)
	    {
	        Dialog_Show(playerid, SifreDegistir, DIALOG_STYLE_INPUT, "Yeni Þifre", "Lütfen yeni þifrenizi girin:", "Deðiþtir", "Geri");
	    }
		if (listitem == 1)
		{
		    TOGMenu(playerid);
		}
		if (listitem == 2)
		{
		    Dialog_Show(playerid, YuruyusStili, DIALOG_STYLE_LIST, "Yürüyüþ Stili", "Normal\nLow Walk\nGangsta\nGangsta2\nOld Walk\nOld Walk2\nNormal Walk2\nFemale Walk\nFemale Walk2\nWhore Walk\nFemale Walk3\nDrunk Walk\nBlind Walk\nNormal", "Seç", "Geri");
		}
		if (listitem == 3)
		{
			BildirimlerDialog(playerid);
		}
	}
	return 1;
}
Dialog:YuruyusStili(playerid, response, listitem, inputtext[])
{
	if (!response) return Dialog_Show(playerid, Ayarlar, DIALOG_STYLE_LIST, "{FFFFFF}Hesap Ayarlarý", "{FFFFFF}Þifre Deðiþtir\n{FFFFFF}TOG\n{FFFFFF}Yürüyüþ Stili", "Seç", "Kapat");
	if (response)
	{
	    PlayerData[playerid][pAyarlar][9] = listitem+1;
	    MesajGonder(playerid, "Yürüyüþ stiliniz deðiþtirildi.");
	}
	return 1;
}
Dialog:SifreDegistir(playerid, response, listitem, inputtext[])
{
	if (!response) return Dialog_Show(playerid, Ayarlar, DIALOG_STYLE_LIST, "{FFFFFF}Hesap Ayarlarý", "{FFFFFF}Þifre Deðiþtir\n{FFFFFF}TOG\n{FFFFFF}Yürüyüþ Stili", "Seç", "Kapat");
	if (response)
	{
	    if (isnull(inputtext)) return Dialog_Show(playerid, SifreDegistir, DIALOG_STYLE_INPUT, "Yeni Þifre", "Lütfen yeni þifrenizi girin:", "Deðiþtir", "Geri");
	    if (strlen(inputtext) < 6 || strlen(inputtext) > 30)
     	{
      		HataMesajGonder(playerid, "Þifreniz 6 ile 30 karakter arasýnda olmalýdýr.");
			return Dialog_Show(playerid, SifreDegistir, DIALOG_STYLE_INPUT, "Yeni Þifre", "Lütfen yeni þifrenizi girin:", "Deðiþtir", "Geri");
		}
		if (TurkceKarakter(inputtext))
		{
            HataMesajGonder(playerid, "Þifreniz Türkçe karakter içeremez.");
			return Dialog_Show(playerid, SifreDegistir, DIALOG_STYLE_INPUT, "Yeni Þifre", "Lütfen yeni þifrenizi girin:", "Deðiþtir", "Geri");
		}
		if (OzelKarakter(inputtext))
		{
            HataMesajGonder(playerid, "Þifreniz özel karakter içeremez.");
			return Dialog_Show(playerid, SifreDegistir, DIALOG_STYLE_INPUT, "Yeni Þifre", "Lütfen yeni þifrenizi girin:", "Deðiþtir", "Geri");
		}
		new query[300];
		Log_Write("logs/sifreler.log", "%s [ %s ] Þifresini Deðiþtirdi!", inputtext, ReturnName(playerid, 0));
		format(query, sizeof(query), "UPDATE `oyuncular` SET `Sifre` = md5('%s') WHERE `Isim` = '%s'", inputtext, Player_GetName(playerid));
		mysql_query(g_SQL, query, false);
		MesajGonder(playerid, "Þifreniz deðiþtirildi.");
	}
	return 1;
}
Dialog:OzelModelListe(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    new skin = OzelModelListeleme[playerid][listitem];
	    PlayerData[playerid][pSkin] = skin;
	    SetPlayerSkin(playerid, skin);
	}
	return 1;
}
Dialog:VipDolap(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (listitem == 0)
	    {
	        if (ReturnHealth(playerid) >= 100) return HataMesajGonder(playerid, "Zaten canýnýz full.");

	        CanAyarla(playerid, 100.0);
	    }
	    if (listitem == 1)
	    {
	        if (ReturnArmour(playerid) >= 100) return HataMesajGonder(playerid, "Zaten zýrhýnýz full.");
	        if (PlayerData[playerid][pCash] < 2000) return HataMesajGonder(playerid, "Yeterli paranýz yok.");
	        ZirhAyarla(playerid, 100.0);
	        ParaVer(playerid, -2000);
	    }
	    if (listitem == 3)
	    {
         new skinid;
			for (new i; i<50; i++)
			{
	   			if (VIPErkekSkinler[i] == skinid || VIPBayanSkinler[i] == skinid) return 1;
			}
	    }

	}
	return 1;
}
Dialog:VIPSkinler(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (PlayerData[playerid][pCinsiyet] == 1)
	    {
			PlayerData[playerid][pSkin] = VIPErkekSkinler[listitem];
			SetPlayerSkin(playerid, PlayerData[playerid][pSkin]);
		}
		else
		{
		    PlayerData[playerid][pSkin] = VIPBayanSkinler[listitem];
			SetPlayerSkin(playerid, PlayerData[playerid][pSkin]);
		}
	}
	return 1;
}
Dialog:VipMenu(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (listitem == 0 || listitem == 1) return callcmd::vipmenu(playerid);
	    if (listitem == 2)
	    {
	        new str[3000];
	        switch (PlayerData[playerid][pVip])
	        {
	            case 1:
	            {
	                strcat(str, "{FFFFFF}V.I.P rengini aktif edebilir.\n");
	                strcat(str, "{FFFFFF}V.I.P menüsünden (/vipmenu) dövüþ stilini deðiþtirebilir. Paketi son erdiðinde dövüþ stili normale döner.\n");
	                strcat(str, "{FFFFFF}V.I.P dolabýndan belirli ücret karþýlýðýnda canýný ve zýrhýný doldurabilir. (/vipdolap)\n");
	                strcat(str, "{FFFFFF}V.I.P dolabýndaki kýyafetlerden yararlanabilir.\n");
	                strcat(str, "{FFFFFF}Telefonda rehbere numara kaydetme limiti 25'e yükselir.\n");
	                strcat(str, "{FFFFFF}Sahip olabileceði araç limiti 7'e yükselir.\n");
	                strcat(str, "{FFFFFF}Sahip olabileceði ev limiti 6'ya yükselir.\n");
	                strcat(str, "{FFFFFF}Galeriden bisiklet alabilir.\n");
	                strcat(str, "{FFFFFF}Saatlik maaþlarda ekstra olarak 2 EXP alýr.\n");
	                strcat(str, "{FFFFFF}Saatlik maaþlarda ekstra olarak $200 alýr.\n");
	                strcat(str, "{FFFFFF}VIP olduðu süre boyunca mobilya hakký +60 artar.\n");
	                strcat(str, "{FFFFFF}Forum ve Discordda donator tagý verilir.\n");
	            }
	            case 2:
	            {
	                strcat(str, "{FFFFFF}V.I.P rengini aktif edebilir.\n");
	                strcat(str, "{FFFFFF}V.I.P menüsünden (/vipmenu) dövüþ stilini deðiþtirebilir. Paketi son erdiðinde dövüþ stili normale döner.\n");
	                strcat(str, "{FFFFFF}V.I.P dolabýndan belirli ücret karþýlýðýnda canýný ve zýrhýný doldurabilir. (/vipdolap)\n");
	                strcat(str, "{FFFFFF}V.I.P dolabýndaki kýyafetlerden yararlanabilir.\n");
	                strcat(str, "{FFFFFF}Telefonda rehbere numara kaydetme limiti 35'e yükselir.\n");
	                strcat(str, "{FFFFFF}Sahip olabileceði araç limiti 9'a yükselir.\n");
	                strcat(str, "{FFFFFF}Sahip olabileceði ev limiti 8'e yükselir.\n");
	                strcat(str, "{FFFFFF}Grottiden bisiklet alabilir.\n");
	                strcat(str, "{FFFFFF}Saatlik maaþlarda ekstra olarak 4 EXP alýr.\n");
	                strcat(str, "{FFFFFF}Saatlik maaþlarda ekstra olarak $400 alýr.\n");
	                strcat(str, "{FFFFFF}VIP olduðu süre boyunca mobilya hakký +120 artar.\n");
	                strcat(str, "{FFFFFF}Forum ve Discordda donator tagý verilir.\n");
	                strcat(str, "{FFFFFF}VIP olduðu süre boyunca maske hakký olmadan maske takabilir.\n");
	                strcat(str, "{FFFFFF}Grottiden VIP araçlarý alabilir. (Quad, Sandking)\n");
	            }
	            case 3:
	            {
	                strcat(str, "{FFFFFF}V.I.P rengini aktif edebilir.\n");
	                strcat(str, "{FFFFFF}V.I.P menüsünden (/vipmenu) dövüþ stilini deðiþtirebilir. Paketi son erdiðinde dövüþ stili normale döner.\n");
	                strcat(str, "{FFFFFF}V.I.P dolabýndan belirli ücret karþýlýðýnda canýný ve zýrhýný doldurabilir. (/vipdolap)\n");
	                strcat(str, "{FFFFFF}V.I.P dolabýndaki kýyafetlerden yararlanabilir.\n");
	                strcat(str, "{FFFFFF}Telefonda rehbere numara kaydetme limiti 40'a yükselir.\n");
	                strcat(str, "{FFFFFF}Sahip olabileceði araç limiti 11'e yükselir.\n");
	                strcat(str, "{FFFFFF}Sahip olabileceði ev limiti 10'a yükselir.\n");
	                strcat(str, "{FFFFFF}Grottiden bisiklet alabilir.\n");
	                strcat(str, "{FFFFFF}Saatlik maaþlarda ekstra olarak 6 EXP alýr.\n");
	                strcat(str, "{FFFFFF}Saatlik maaþlarda ekstra olarak $600 alýr.\n");
	                strcat(str, "{FFFFFF}VIP olduðu süre boyunca mobilya hakký +200 artar.\n");
	                strcat(str, "{FFFFFF}Forum ve Discordda donator tagý verilir.\n");
	                strcat(str, "{FFFFFF}VIP olduðu süre boyunca maske hakký olmadan maske takabilir.\n");
	                strcat(str, "{FFFFFF}Grottiden VIP araçlarý alabilir. (Hotring racer, hotknife, bloodring)\n");
	            }

	        }
	        Dialog_Show(playerid, PaketOzellikleri, DIALOG_STYLE_MSGBOX, "Paket Özellikleri", str, "Geri", "");
	    }
	    if (listitem == 3)
	    {
	        if (PlayerData[playerid][pVipRenk] == 0)
	        {
	            PlayerData[playerid][pVipRenk] = 1;
	            MesajGonder(playerid, "V.I.P rengi aktif edildi.");
	            VipMenu(playerid);
	        }
			else
			{
			    PlayerData[playerid][pVipRenk] = 0;
			    MesajGonder(playerid, "V.I.P rengi kapatýldý.");
			    VipMenu(playerid);
			}
		}
		if (listitem == 4)
		{
		    Dialog_Show(playerid, FightStyle, DIALOG_STYLE_LIST, "Dövüþ Stilleri", "Normal\nBoxing\nKungfu\nKneehead\nGrab Kick\nElbow", "Seç", "Geri");
		}
	}
	return 1;
}

Dialog:PaketOzellikleri(playerid, response, listitem, inputtext[])
{
	if (response) return VipMenu(playerid);
	return 1;
}
Dialog:FightStyle(playerid, response, listitem, inputtext[])
{
	if (!response) return VipMenu(playerid);
	if (response)
	{
	    switch (listitem)
	    {
	        case 0:
	        {
	            PlayerData[playerid][pDovusStili] = FIGHT_STYLE_NORMAL;
	            SetPlayerFightingStyle(playerid, FIGHT_STYLE_NORMAL);

	        }
	        case 1:
	        {
	            PlayerData[playerid][pDovusStili] = FIGHT_STYLE_BOXING;
	            SetPlayerFightingStyle(playerid, FIGHT_STYLE_BOXING);
	        }
	        case 2:
	        {
	            PlayerData[playerid][pDovusStili] = FIGHT_STYLE_KUNGFU;
	            SetPlayerFightingStyle(playerid, FIGHT_STYLE_KUNGFU);
	        }
	        case 3:
	        {
	            PlayerData[playerid][pDovusStili] = FIGHT_STYLE_KNEEHEAD;
	            SetPlayerFightingStyle(playerid, FIGHT_STYLE_KNEEHEAD);
	        }
	        case 4:
	        {
	            PlayerData[playerid][pDovusStili] = FIGHT_STYLE_GRABKICK;
	            SetPlayerFightingStyle(playerid, FIGHT_STYLE_GRABKICK);
	        }
	        case 5:
	        {
	            PlayerData[playerid][pDovusStili] = FIGHT_STYLE_ELBOW;
	            SetPlayerFightingStyle(playerid, FIGHT_STYLE_ELBOW);
	        }
	    }
	    MesajGonder(playerid, "Dövüþ stiliniz deðiþtirildi. (Aim + Enter)");
	}
	return 1;
}
Dialog:Siparisler(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (strfind(inputtext, "Ileri", true) != -1)
        {
            SetPVarInt(playerid, "Siparis", GetPVarInt(playerid, "Siparis")+1);
            SiparisListele(playerid);
            return 1;
        }
        if (strfind(inputtext, "Geri", true) != -1)
        {
            if (GetPVarInt(playerid, "Siparis") < 1)
            {
                SiparisListele(playerid);
                HataMesajGonder(playerid, "Zaten ilk sayfadasýnýz!");
            }
            else
            {
                SetPVarInt(playerid, "Siparis", GetPVarInt(playerid, "Siparis")-1);
                SiparisListele(playerid);
            }
            return 1;
        }
	    new sid = strval(inputtext);
	    if (sid < 1) return 1;
	    new query[80];
	    format(query, sizeof(query), "DELETE FROM `siparisler` WHERE `ID` = '%d'", sid);
	    mysql_query(g_SQL, query, false);
	    MesajGonder(playerid, "Sipariþ silindi.");
	    SiparisListele(playerid);
	}
	return 1;
}
Dialog:oocm(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (strfind(inputtext, "Bakiye Gönder", true) != -1)
	    {
	        if (PlayerData[playerid][pBakiye] <= 0)
	        {
	            HataMesajGonder(playerid, "Bakiyeniz yok.");
	            return callcmd::oocmarket(playerid);
			}
			Dialog_Show(playerid, BakiyeGonderID, DIALOG_STYLE_INPUT, "Bakiye Gönder", "{ff0022}» {FFFFFF}Lütfen Bakiye göndermek istediðiniz oyuncunun ID'sini girin:", "Devam", "Geri");
			return 1;
	    }
	    if (strfind(inputtext, "Düzenle", true) != -1)
	    {
	        if (PlayerData[playerid][pAdmin] < 4) return 1;
	        Dialog_Show(playerid, UrunDuzenle, DIALOG_STYLE_LIST, "Düzenle", "{FFFFFF}Ürün Ekle\n{FFFFFF}Ürün Sil\n{FFFFFF}Ürün Fiyat Düzenle\nÜrün Pasifleþtir/Aktifleþtir", "Seç", "Kapat");
	        return 1;
	    }
	    if (strlen(inputtext) > 0)
	    {
	        OOCMarket_UrunAl(playerid, inputtext);
		}
	}
	return 1;
}
Dialog:MaskeHakki(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (PlayerData[playerid][pBakiye] >= GetPVarInt(playerid, "UrunFiyat"))
	    {
	        PlayerData[playerid][pBakiye] -= GetPVarInt(playerid, "UrunFiyat");
	        PlayerData[playerid][pMaskeHakki] = 1;
	        Oyuncu_Kaydet(playerid);
	        MesajGonder(playerid, "%d TL ödeyerek Maske Kullaným Hakký satýn aldýnýz.", GetPVarInt(playerid, "UrunFiyat"));
	        Log_Write("logs/oocmarket.log", "[%s] %s adli kisi ooc marketden maske kullanim hakki adli urunu satin aldi.",ReturnDate(),ReturnName(playerid));
	        DeletePVar(playerid, "UrunFiyat");
	    }
	}
	return 1;
}
Dialog:BronzVip(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (PlayerData[playerid][pBakiye] >= GetPVarInt(playerid, "UrunFiyat"))
	    {
	        PlayerData[playerid][pVip] = 1;
	        PlayerData[playerid][pVipSure] = gettime()+30*86400;
	        PlayerData[playerid][pBakiye] -= GetPVarInt(playerid, "UrunFiyat");
	        Oyuncu_Kaydet(playerid);
	        MesajGonder(playerid, "%d TL ödeyerek Bronze VIP satýn aldýnýz. (/vipmenu)", GetPVarInt(playerid, "UrunFiyat"));
	        Log_Write("logs/oocmarket.log", "[%s] %s adli kisi ooc marketden bronze vip adli urunu satin aldi.",ReturnDate(),ReturnName(playerid));
	        DeletePVar(playerid, "UrunFiyat");

			PlayerData[playerid][pSilahHakki] = SilahAveraj(playerid);
			PlayerData[playerid][pSilahSuresi] = 0;
	    }
	}
	return 1;
}
Dialog:SilverVip(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (PlayerData[playerid][pBakiye] >= GetPVarInt(playerid, "UrunFiyat"))
	    {
	        PlayerData[playerid][pVip] = 2;
	        PlayerData[playerid][pVipSure] = gettime()+30*86400;
	        PlayerData[playerid][pBakiye] -= GetPVarInt(playerid, "UrunFiyat");
	        Oyuncu_Kaydet(playerid);
	        MesajGonder(playerid, "%d TL ödeyerek Silver VIP satýn aldýnýz. (/vipmenu)", GetPVarInt(playerid, "UrunFiyat"));
	        Log_Write("logs/oocmarket.log", "[%s] %s adli kisi ooc marketden silver vip adli urunu satin aldi.",ReturnDate(),ReturnName(playerid));
	        DeletePVar(playerid, "UrunFiyat");

			PlayerData[playerid][pSilahHakki] = SilahAveraj(playerid);
			PlayerData[playerid][pSilahSuresi] = 0;
	    }
	}
	return 1;
}

Dialog:GoldVip(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (PlayerData[playerid][pBakiye] >= GetPVarInt(playerid, "UrunFiyat"))
	    {
	        PlayerData[playerid][pVip] = 3;
	        PlayerData[playerid][pVipSure] = gettime()+30*86400;
	        PlayerData[playerid][pBakiye] -= GetPVarInt(playerid, "UrunFiyat");
	        Oyuncu_Kaydet(playerid);
	        MesajGonder(playerid, "%d TL ödeyerek Gold VIP satýn aldýnýz. (/vipmenu)", GetPVarInt(playerid, "UrunFiyat"));
	        Log_Write("logs/oocmarket.log", "[%s] %s adli kisi ooc marketden Gold VIP adli urunu satin aldi.",ReturnDate(),ReturnName(playerid));
	        DeletePVar(playerid, "UrunFiyat");

			PlayerData[playerid][pSilahHakki] = SilahAveraj(playerid);
			PlayerData[playerid][pSilahSuresi] = 0;
	    }
	}
	return 1;
}

Dialog:KilometreSifirla(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (PlayerData[playerid][pBakiye] >= GetPVarInt(playerid, "UrunFiyat") && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	    {
	        new id = Car_GetID(GetPlayerVehicleID(playerid));
	        if (id == -1 || AracInfo[id][aracTip] != 4) return HataMesajGonder(playerid, "Bu aracýn kilometresini sýfýrlayamazsýn!");
	        AracInfo[id][aracKM] = 0.0;
	        PlayerData[playerid][pBakiye] -= GetPVarInt(playerid, "UrunFiyat");
	        Arac_Kaydet(id);
	        Oyuncu_Kaydet(id);
	        MesajGonder(playerid, "%d TL ödeyerek bulunduðunuz aracýn kilometresini sýfýrladýnýz.",GetPVarInt(playerid, "UrunFiyat"));
	        Log_Write("logs/oocmarket.log", "[%s] %s adli kisi ooc marketden arac kilometre sifirlama adli urunu satin aldi.",ReturnDate(), ReturnName(playerid));
	        DeletePVar(playerid, "UrunFiyat");
	    }
	}
	return 1;
}
Dialog:BalikOrani(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (PlayerData[playerid][pBakiye] >= GetPVarInt(playerid, "UrunFiyat"))
	    {
	        PlayerData[playerid][pBalikOrani] = gettime()+30*86400;
	        PlayerData[playerid][pBakiye] -= GetPVarInt(playerid, "UrunFiyat");
	        MesajGonder(playerid, "%d TL ödeyerek Balýk Oraný Arttýrma adlý ürünü satýn aldýnýz.", GetPVarInt(playerid, "UrunFiyat"));
	        Oyuncu_Kaydet(playerid);
	        Log_Write("logs/oocmarket.log", "%s adli kisi ooc marketden balik orani arttirma adli urunu satin aldi.",ReturnName(playerid));
	        DeletePVar(playerid, "UrunFiyat");
	    }
	}
	return 1;
}
Dialog:OzelEv(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (PlayerData[playerid][pBakiye] >= GetPVarInt(playerid, "UrunFiyat"))
	    {
	        PlayerData[playerid][pBakiye] -= GetPVarInt(playerid, "UrunFiyat");
	        new query[250];
	        format(query, sizeof(query), "INSERT INTO `siparisler` (`sqlid`, `sipariseden`, `urun`, `tarih`) VALUES ('%d', '%s', 'Kisisel Ev Interioru', '%s')", PlayerData[playerid][pID], Player_GetName(playerid),ReturnDate());
	        mysql_query(g_SQL, query, false);
	        Oyuncu_Kaydet(playerid);
	        MesajGonder(playerid, "%d TL ödeyerek Özel Ev Ýnterioru satýn aldýnýz, F8 tuþuna basarak SS alýn ve forumumuzdan ticket açýn. (www.regular-roleplay.com)",GetPVarInt(playerid, "UrunFiyat"));
	        Log_Write("logs/oocmarket.log", "%s adli kisi ooc marketden Özel Ev Ýnterioru adli urunu satin aldi.",ReturnName(playerid));
	        DeletePVar(playerid, "UrunFiyat");
	    }
	}
	return 1;
}
Dialog:OzelGaraj(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (PlayerData[playerid][pBakiye] >= GetPVarInt(playerid, "UrunFiyat"))
	    {
	        PlayerData[playerid][pBakiye] -= GetPVarInt(playerid, "UrunFiyat");
	        new query[250];
	        format(query, sizeof(query), "INSERT INTO `siparisler` (`sqlid`, `sipariseden`, `urun`, `tarih`) VALUES ('%d', '%s', 'Kisisel Garaj', '%s')", PlayerData[playerid][pID], Player_GetName(playerid),ReturnDate());
	        mysql_query(g_SQL, query, false);
	        Oyuncu_Kaydet(playerid);
	        MesajGonder(playerid, "%d TL ödeyerek özel garaj satýn aldýnýz, F8 tuþuna basarak SS alýn ve forumumuzdan ticket açýn. (www.regular-roleplay.com)",GetPVarInt(playerid, "UrunFiyat"));
	        Log_Write("logs/oocmarket.log", "%s adli kisi ooc marketden Özel Garaj adli urunu satin aldi.",ReturnName(playerid));
	        DeletePVar(playerid, "UrunFiyat");
	    }
	}
	return 1;
}
Dialog:EXPBoost(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (PlayerData[playerid][pBakiye] >= GetPVarInt(playerid, "UrunFiyat"))
	    {
	        PlayerData[playerid][pEXPBoost] = gettime()+30*86400;
	        PlayerData[playerid][pBakiye] -= GetPVarInt(playerid, "UrunFiyat");
	        MesajGonder(playerid, "%d TL ödeyerek EXP Boost adlý ürünü satýn aldýnýz. Her maaþ aldýðýnýzda 1 EXP daha fazla kazanacaksýnýz!", GetPVarInt(playerid, "UrunFiyat"));
	        Oyuncu_Kaydet(playerid);
	        Log_Write("logs/oocmarket.log", "[%s] %s adli kisi ooc marketden EXP boost adli urunu satin aldi.",ReturnDate(), ReturnName(playerid));
	        DeletePVar(playerid, "UrunFiyat");
	    }
	}
	return 1;
}

Dialog:OzelNumara(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (PlayerData[playerid][pBakiye] >= GetPVarInt(playerid, "UrunFiyat"))
	    {
			if (isnull(inputtext)) return Dialog_Show(playerid, OzelNumara, DIALOG_STYLE_INPUT, "Özel Numara", "{a1ff00}%d TL {FFFFFF}ödeyerek almak istediðiniz özel numarayý girin:", "Devam", "Vazgeç", GetPVarInt(playerid, "UrunFiyat"));
			if (!IsNumeric(inputtext)) return Dialog_Show(playerid, OzelNumara, DIALOG_STYLE_INPUT, "Özel Numara", "{a1ff00}%d TL {FFFFFF}ödeyerek almak istediðiniz özel numarayý girin:", "Devam", "Vazgeç", GetPVarInt(playerid, "UrunFiyat"));

			if (strval(inputtext) < 10000)
			{
			    HataMesajGonder(playerid, "Geçersiz numara girdiniz, minimum 10000 maksimum 99999 girebilirsiniz.");
			    return Dialog_Show(playerid, OzelNumara, DIALOG_STYLE_INPUT, "Özel Numara", "{a1ff00}%d TL {FFFFFF}ödeyerek almak istediðiniz özel numarayý girin:", "Devam", "Vazgeç", GetPVarInt(playerid, "UrunFiyat"));
			}

			if (strval(inputtext) > 99999)
			{
			    HataMesajGonder(playerid, "Geçersiz numara girdiniz, minimum 10000 maksimum 99999 girebilirsiniz.");
			    return Dialog_Show(playerid, OzelNumara, DIALOG_STYLE_INPUT, "Özel Numara", "{a1ff00}%d TL {FFFFFF}ödeyerek almak istediðiniz özel numarayý girin:", "Devam", "Vazgeç", GetPVarInt(playerid, "UrunFiyat"));
			}

			if (NumaraKontrol(strval(inputtext)))
			{
			    HataMesajGonder(playerid, "Bu numara baþkasý tarafýndan kullanýlýyor.");
			    return Dialog_Show(playerid, OzelNumara, DIALOG_STYLE_INPUT, "Özel Numara", "{a1ff00}%d TL {FFFFFF}ödeyerek almak istediðiniz özel numarayý girin:", "Devam", "Vazgeç", GetPVarInt(playerid, "UrunFiyat"));
			}

			if (strval(inputtext) == 911 || strval(inputtext) == 555 || strval(inputtext) == 333)
			{
			    HataMesajGonder(playerid, "Bu numarayý kullanamazsýnýz.");
			    return Dialog_Show(playerid, OzelNumara, DIALOG_STYLE_INPUT, "Özel Numara", "{a1ff00}%d TL {FFFFFF}ödeyerek almak istediðiniz özel numarayý girin:", "Devam", "Vazgeç", GetPVarInt(playerid, "UrunFiyat"));
			}

			PlayerData[playerid][pTelefon] = strval(inputtext);
			PlayerData[playerid][pBakiye] -= GetPVarInt(playerid, "UrunFiyat");
			MesajGonder(playerid, "%d TL ödeyerek telefon numaranýzý %d yaptýnýz.", GetPVarInt(playerid, "UrunFiyat"), strval(inputtext));
			Oyuncu_Kaydet(playerid);
			Log_Write("logs/oocmarket.log", "[%s] %s adli kisi ooc marketden Özel Numara adli urunu satin aldi.",ReturnDate(), ReturnName(playerid));
			DeletePVar(playerid, "UrunFiyat");
	    }
	}
	return 1;
}

Dialog:OzelPlaka(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (PlayerData[playerid][pBakiye] >= GetPVarInt(playerid, "UrunFiyat") && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	    {
	    	Dialog_Show(playerid, OzelPlakaYaz, DIALOG_STYLE_INPUT, "Özel Plaka", "{a1ff00}%s {FFFFFF}model aracýnýza bir özel plaka girin:", "Devam", "Kapat", ReturnVehicleModelName(GetVehicleModel(GetPlayerVehicleID(playerid))));
	    }
	}
	return 1;
}
Dialog:OzelPlakaYaz(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (PlayerData[playerid][pBakiye] >= GetPVarInt(playerid, "UrunFiyat") && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	    {
	        if (isnull(inputtext)) return Dialog_Show(playerid, OzelPlakaYaz, DIALOG_STYLE_INPUT, "Özel Plaka", "{a1ff00}%s {FFFFFF}model aracýnýza bir özel plaka girin:", "Devam", "Kapat", ReturnVehicleModelName(GetVehicleModel(GetPlayerVehicleID(playerid))));
	        if (strlen(inputtext) < 2 || strlen(inputtext) > 24)
	        {
	            HataMesajGonder(playerid, "Plaka minimum 2, maksimum 24 karakterden oluþmalýdýr.");
	            return Dialog_Show(playerid, OzelPlakaYaz, DIALOG_STYLE_INPUT, "Özel Plaka", "{a1ff00}%s {FFFFFF}model aracýnýza bir özel plaka girin:", "Devam", "Kapat", ReturnVehicleModelName(GetVehicleModel(GetPlayerVehicleID(playerid))));
	        }
	        if (TurkceKarakter(inputtext) || OzelKarakter(inputtext))
	        {
	            HataMesajGonder(playerid, "Plaka türkçe veya özel karakter içeremez.");
	            return Dialog_Show(playerid, OzelPlakaYaz, DIALOG_STYLE_INPUT, "Özel Plaka", "{a1ff00}%s {FFFFFF}model aracýnýza bir özel plaka girin:", "Devam", "Kapat", ReturnVehicleModelName(GetVehicleModel(GetPlayerVehicleID(playerid))));
	        }
	        new vehicleid = GetPlayerVehicleID(playerid);
	        new id = Car_GetID(vehicleid);
	        if (id == -1 || AracInfo[id][aracTip] != 4) return HataMesajGonder(playerid, "Bu araca özel plaka takamazsýn.");
	        format(AracInfo[id][aracPlaka], 24, inputtext);
	        SetVehicleNumberPlate(vehicleid, inputtext);
	        PlayerData[playerid][pBakiye] -= GetPVarInt(playerid, "UrunFiyat");
	        Oyuncu_Kaydet(playerid);
	        MesajGonder(playerid, "%d TL ödeyerek aracýn plakasýný '%s' yaptýnýz.", GetPVarInt(playerid, "UrunFiyat"), inputtext);
	        Log_Write("logs/oocmarket.log", "%s adli kisi ooc marketden Ozel Plaka adli urunu satin aldi.",ReturnName(playerid));
	        DeletePVar(playerid, "UrunFiyat");
	    }
	}
	return 1;
}
Dialog:OzelMap(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (PlayerData[playerid][pBakiye] >= GetPVarInt(playerid, "UrunFiyat"))
	    {
	        PlayerData[playerid][pBakiye] -= GetPVarInt(playerid, "UrunFiyat");
	        new query[250];
	        format(query, sizeof(query), "INSERT INTO `siparisler` (`sqlid`, `sipariseden`, `urun`, `tarih`) VALUES ('%d', '%s', 'Kisisel Map', '%s')", PlayerData[playerid][pID], Player_GetName(playerid),ReturnDate());
	        mysql_query(g_SQL, query, false);
	        Oyuncu_Kaydet(playerid);
	        MesajGonder(playerid, "%d TL ödeyerek Özel Map satýn aldýnýz, F8 tuþuna basarak SS alýn ve forumumuzdan ticket açýn. (www.regular-roleplay.com)",GetPVarInt(playerid, "UrunFiyat"));
	        Log_Write("logs/oocmarket.log", "%s adli kisi ooc marketden Kisisel Map adli urunu satin aldi.",ReturnName(playerid));
	        DeletePVar(playerid, "UrunFiyat");
	    }
	}
	return 1;
}
Dialog:oocmpet(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (PlayerData[playerid][pBakiye] >= GetPVarInt(playerid, "UrunFiyat"))
	    {
	        new id = Pet_Olustur(PlayerData[playerid][pID], 1, 1);
			if (id == -1) return HataMesajGonder(playerid, "Pet satýn alýnamadý, geliþtirici ekibiyle iletiþime geçiniz.");
	        PlayerData[playerid][pBakiye] -= GetPVarInt(playerid, "UrunFiyat");
	        Oyuncu_Kaydet(playerid);
	        MesajGonder(playerid, "%d TL ödeyerek Pet satýn aldýnýz. (/petlerim)", GetPVarInt(playerid, "UrunFiyat"));
	        Log_Write("logs/oocmarket.log", "%s adli kisi ooc marketden Pet adli urunu satin aldi.",ReturnName(playerid));
	        DeletePVar(playerid, "UrunFiyat");
	    }
	}
	return 1;
}
Dialog:OzelGate(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (PlayerData[playerid][pBakiye] >= GetPVarInt(playerid, "UrunFiyat"))
	    {
	        PlayerData[playerid][pBakiye] -= GetPVarInt(playerid, "UrunFiyat");
	        new query[250];
	        format(query, sizeof(query), "INSERT INTO `siparisler` (`sqlid`, `sipariseden`, `urun`, `tarih`) VALUES ('%d', '%s', 'Kisisel Gate', '%s')", PlayerData[playerid][pID], Player_GetName(playerid),ReturnDate());
	        mysql_query(g_SQL, query, false);
	        Oyuncu_Kaydet(playerid);
	        MesajGonder(playerid, "%d TL ödeyerek Özel Gate satýn aldýnýz, F8 tuþuna basarak SS alýn ve forumumuzdan ticket açýn. (www.regular-roleplay.com)",GetPVarInt(playerid, "UrunFiyat"));
	        Log_Write("logs/oocmarket.log", "%s adli kisi ooc marketden Özel Gate adli urunu satin aldi.",ReturnName(playerid));
	        DeletePVar(playerid, "UrunFiyat");
	    }
	}
	return 1;
}
Dialog:OzelModel(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (PlayerData[playerid][pBakiye] >= GetPVarInt(playerid, "UrunFiyat"))
	    {
	        PlayerData[playerid][pBakiye] -= GetPVarInt(playerid, "UrunFiyat");
	        new query[250];
	        format(query, sizeof(query), "INSERT INTO `siparisler` (`sqlid`, `sipariseden`, `urun`, `tarih`) VALUES ('%d', '%s', 'Ozel Model', '%s')", PlayerData[playerid][pID], Player_GetName(playerid),ReturnDate());
	        mysql_query(g_SQL, query, false);
	        Oyuncu_Kaydet(playerid);
	        MesajGonder(playerid, "%d TL ödeyerek Özel kýyafet satýn aldýnýz, F8 tuþuna basarak SS alýn ve forumumuzdan ticket açýn. (www.regular-roleplay.com)",GetPVarInt(playerid, "UrunFiyat"));
	        Log_Write("logs/oocmarket.log", "%s adli kisi ooc marketden Özel kýyafet adli urunu satin aldi.",ReturnName(playerid));
	        DeletePVar(playerid, "UrunFiyat");
	    }
	}
	return 1;
}
Dialog:SoyadKilitle(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    new query[150];
	    format(query, sizeof(query), "INSERT INTO `kilitlisoyadlar` (`Soyad`, `Kilitleyen`, `Tarih`) VALUES ('%s', '%s', '%s')", GetPlayerLastName(playerid, ReturnName(playerid), 1), ReturnName(playerid), ReturnDate());
	    mysql_query(g_SQL, query, false);
	    PlayerData[playerid][pBakiye] -= GetPVarInt(playerid, "UrunFiyat");
		MesajGonder(playerid, "%d TL ödeyerek soyadýnýzý kilitlediniz.", GetPVarInt(playerid, "UrunFiyat"));
		Log_Write("logs/oocmarket.log", "%s adli kisi ooc marketden Soyadi kilitleme adli urunu satin aldi.",ReturnName(playerid));
		DeletePVar(playerid, "UrunFiyat");
	}
	return 1;
}
Dialog:oocmyas(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (isnull(inputtext)) return Dialog_Show(playerid, oocmyas, DIALOG_STYLE_INPUT, "Karakter Yapýlandýrma Paketi (Adým 1)", "{FFFFFF}Karakter Yapýlandýrma Paketi: {ffd000}Karakter Yaþý\n\n{FFFFFF}Lütfen karakterinizin yaþýný girin:", "Devam", "Vazgeç");
	    if (!IsNumeric(inputtext)) return Dialog_Show(playerid, oocmyas, DIALOG_STYLE_INPUT, "Karakter Yapýlandýrma Paketi (Adým 1)", "{FFFFFF}Karakter Yapýlandýrma Paketi: {ffd000}Karakter Yaþý\n\n{FFFFFF}Lütfen karakterinizin yaþýný girin:", "Devam", "Vazgeç");
	    if (strval(inputtext) < 18 || strval(inputtext) > 80)
	    {
	        HataMesajGonder(playerid, "Minimum 18, maksimum 80 yaþ girebilirsiniz!");
	        return Dialog_Show(playerid, oocmyas, DIALOG_STYLE_INPUT, "Karakter Yapýlandýrma Paketi (Adým 1)", "{FFFFFF}Karakter Yapýlandýrma Paketi: {ffd000}Karakter Yaþý\n\n{FFFFFF}Lütfen karakterinizin yaþýný girin:", "Devam", "Vazgeç");
	    }
	    SetPVarInt(playerid, "KarakterYas", strval(inputtext));
	    Dialog_Show(playerid, oocmdogumyeri, DIALOG_STYLE_INPUT, "Karakter Yapýlandýrma Paketi (Adým 2)", "{FFFFFF}Karakter Yapýlandýrma Paketi: {ffd000}Doðum Yeri\n\n{FFFFFF}Lütfen karakterinizin doðum yerini girin:", "Devam", "Geri");
	}
	return 1;
}
Dialog:oocmdogumyeri(playerid, response, listitem, inputtext[])
{
	if (!response) return Dialog_Show(playerid, oocmyas, DIALOG_STYLE_INPUT, "Karakter Yapýlandýrma Paketi (Adým 1)", "{FFFFFF}Karakter Yapýlandýrma Paketi: {ffd000}Karakter Yaþý\n\n{FFFFFF}Lütfen karakterinizin yaþýný girin:", "Devam", "Vazgeç");
	if (response)
	{
	    if (isnull(inputtext)) return Dialog_Show(playerid, oocmdogumyeri, DIALOG_STYLE_INPUT, "Karakter Yapýlandýrma Paketi (Adým 2)", "{FFFFFF}Karakter Yapýlandýrma Paketi: {ffd000}Doðum Yeri\n\n{FFFFFF}Lütfen karakterinizin doðum yerini girin:", "Devam", "Geri");
	    if (strlen(inputtext) < 3 || strlen(inputtext) > 30)
	    {
	        HataMesajGonder(playerid, "Doðum yeri çok kýsa veya çok uzun.");
	        return Dialog_Show(playerid, oocmdogumyeri, DIALOG_STYLE_INPUT, "Karakter Yapýlandýrma Paketi (Adým 2)", "{FFFFFF}Karakter Yapýlandýrma Paketi: {ffd000}Doðum Yeri\n\n{FFFFFF}Lütfen karakterinizin doðum yerini girin:", "Devam", "Geri");
	    }
	    SetPVarString(playerid, "DogumYeri", inputtext);
	    Dialog_Show(playerid, oocmtenrengi, DIALOG_STYLE_LIST, "Karakter Yapýlandýrma Paketi (Adým 3)", "Beyaz\nSiyah", "Bitir", "Geri");
	}
	return 1;
}
Dialog:oocmtenrengi(playerid, response, listitem, inputtext[])
{
	if (!response) return Dialog_Show(playerid, oocmdogumyeri, DIALOG_STYLE_INPUT, "Karakter Yapýlandýrma Paketi (Adým 2)", "{FFFFFF}Karakter Yapýlandýrma Paketi: {ffd000}Doðum Yeri\n\nLütfen karakterinizin doðum yerini girin:", "Devam", "Geri");
	if (response)
	{
	    if (PlayerData[playerid][pBakiye] >= GetPVarInt(playerid, "UrunFiyat"))
	    {
	    	new yas = GetPVarInt(playerid, "KarakterYas");
	    	new dogum[30];
	    	GetPVarString(playerid, "DogumYeri", dogum, sizeof(dogum));

	    	PlayerData[playerid][pYas] = yas;
	    	format(PlayerData[playerid][pDogum], 30, dogum);
	    	PlayerData[playerid][pTen] = listitem+1;
	    	PlayerData[playerid][pBakiye] -= GetPVarInt(playerid, "UrunFiyat");
			MesajGonder(playerid, "%d TL ödeyerek karakterinizi baþarýyla yapýlandýrdýnýz.", GetPVarInt(playerid, "UrunFiyat"));
			Log_Write("logs/oocmarket.log", "%s adli kisi ooc marketden Karakter yapilandirma adli urunu satin aldi.",ReturnName(playerid));
			DeletePVar(playerid, "UrunFiyat");
			DeletePVar(playerid, "DogumYeri");
			DeletePVar(playerid, "KarakterYas");
	    	Oyuncu_Kaydet(playerid);
	    }
	}
	return 1;
}
Dialog:oocmisimdegistir(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (isnull(inputtext)) return Dialog_Show(playerid, oocmisimdegistir, DIALOG_STYLE_INPUT, "Ýsim Deðiþtir", "{ff0022}» {FFFFFF}Lütfen yeni isminizi girin (Ad_Soyad formatýnda olmalýdýr):\n{ff0022}Not: {FFFFFF}Ýsminizi deðiþtirdikten sonra IC siciliniz sýfýrlanýr.", "Devam", "Vazgeç");
	    if (strlen(inputtext) <= 3)
	    {
	        HataMesajGonder(playerid, "Çok kýsa bir ad girdiniz.");
	        return Dialog_Show(playerid, oocmisimdegistir, DIALOG_STYLE_INPUT, "Ýsim Deðiþtir", "{ff0022}» {FFFFFF}Lütfen yeni isminizi girin (Ad_Soyad formatýnda olmalýdýr):\n{ff0022}Not: {FFFFFF}Ýsminizi deðiþtirdikten sonra IC siciliniz sýfýrlanýr.", "Devam", "Vazgeç");
	    }
	    if (!IsValidRoleplayName(inputtext))
	    {
	        HataMesajGonder(playerid, "Ýsminiz Ad_Soyad formatýnda olmalýdýr. (Örnek: Danny_Ruswell)");
	        return Dialog_Show(playerid, oocmisimdegistir, DIALOG_STYLE_INPUT, "Ýsim Deðiþtir", "{ff0022}» {FFFFFF}Lütfen yeni isminizi girin (Ad_Soyad formatýnda olmalýdýr):\n{ff0022}Not: {FFFFFF}Ýsminizi deðiþtirdikten sonra IC siciliniz sýfýrlanýr.", "Devam", "Vazgeç");
	    }
	    if (SoyadKilitlimi(GetPlayerLastName(playerid, inputtext, 0)))
	    {
	        HataMesajGonder(playerid, "Yazdýðýnýz soyad kilitlenmiþ.");
	        return Dialog_Show(playerid, oocmisimdegistir, DIALOG_STYLE_INPUT, "Ýsim Deðiþtir", "{ff0022}» {FFFFFF}Lütfen yeni isminizi girin (Ad_Soyad formatýnda olmalýdýr):\n{ff0022}Not: {FFFFFF}Ýsminizi deðiþtirdikten sonra IC siciliniz sýfýrlanýr.", "Devam", "Vazgeç");
	    }
	    if (!IsimKontrol(inputtext))
	    {
	        HataMesajGonder(playerid, "Bu isim baþkasý tarafýndan kullanýlmaktadýr.");
	        return Dialog_Show(playerid, oocmisimdegistir, DIALOG_STYLE_INPUT, "Ýsim Deðiþtir", "{ff0022}» {FFFFFF}Lütfen yeni isminizi girin (Ad_Soyad formatýnda olmalýdýr):\n{ff0022}Not: {FFFFFF}Ýsminizi deðiþtirdikten sonra IC siciliniz sýfýrlanýr.", "Devam", "Vazgeç");
	    }
	    SetPVarString(playerid, "IsimChange", inputtext);
	    Dialog_Show(playerid, oocmcinsiyetdegistir, DIALOG_STYLE_LIST, "Cinsiyet Deðiþtir", "Erkek\nKadýn", "Devam", "Geri");
	}
	return 1;
}
Dialog:oocmcinsiyetdegistir(playerid, response, listitem, inputtext[])
{
	if (!response)
	{
	    DeletePVar(playerid, "IsimChange");
	    Dialog_Show(playerid, oocmisimdegistir, DIALOG_STYLE_INPUT, "Ýsim Deðiþtir", "{ff0022}» {FFFFFF}Lütfen yeni isminizi girin (Ad_Soyad formatýnda olmalýdýr):\n{ff0022}Not: {FFFFFF}Ýsminizi deðiþtirdikten sonra IC siciliniz sýfýrlanýr.", "Devam", "Vazgeç");
	}
	else
	{
	    new ad[24];
	    GetPVarString(playerid, "IsimChange", ad, sizeof(ad));
	    if ((PlayerData[playerid][pHapisSure] > 0 && PlayerData[playerid][pCK] == 1 && strcmp(ad, Player_GetName(playerid), false) != 0) || PlayerData[playerid][pHapis] == 1 && PlayerData[playerid][pHapisSure] > 50)
	    {
	        PlayerData[playerid][pCK] = 0;
	        format(PlayerData[playerid][pHapisSebep], 50, "");
	        PlayerData[playerid][pHapisSure] = 1;
	    }
	    PlayerData[playerid][pCinsiyet] = listitem+1;
	    ChangeName(playerid, ad);
	    PlayerData[playerid][pBakiye] -= GetPVarInt(playerid, "UrunFiyat");
	    IC_Sicil_Reset(playerid);
	    PlayerData[playerid][pAranma] = 0;
	    SetPlayerWantedLevel(playerid, 0);
	    DeletePVar(playerid, "IsimChange");
	    MesajGonder(playerid, "%d TL ödeyerek karakter adýnýz baþarýyla '%s' olarak deðiþtirildi.", GetPVarInt(playerid, "UrunFiyat"), ad);
	    DeletePVar(playerid, "UrunFiyat");
	    Oyuncu_Kaydet(playerid);
	}
	return 1;
}
Dialog:UrunDuzenle(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (listitem == 0)
	    {
	        if (PlayerData[playerid][pAdmin] < 4) return 1;
	        Dialog_Show(playerid, UrunEkle, DIALOG_STYLE_INPUT, "Ürün Ekle - Ad", "{ff0022}» {FFFFFF}Lütfen eklemek istediðiniz ürünün adýný girin:", "Devam", "Geri");
		}
		if (listitem == 1)
		{
		    if (PlayerData[playerid][pAdmin] < 4) return 1;
		    Dialog_Show(playerid, UrunSil, DIALOG_STYLE_INPUT, "Ürün Sil", "{ff0022}» {FFFFFF}Lütfen silmek istediðiniz ürünün tam adýný girin:", "Devam", "Geri");
		}
		if (listitem == 2)
		{
		    if (PlayerData[playerid][pAdmin] < 4) return 1;
		    Dialog_Show(playerid, FiyatDegistir, DIALOG_STYLE_INPUT, "Ürün Fiyat Deðiþtir", "{ff0022}» {FFFFFF}Lütfen fýyatýný deðiþtirmek istediðiniz ürünün tam adýný girin:", "Devam", "Geri");
		}
		if (listitem == 3)
		{
		    if (PlayerData[playerid][pAdmin] < 4) return 1;
		    Dialog_Show(playerid, UrunDurum, DIALOG_STYLE_INPUT, "Ürün Pasifleþtir/Aktifleþtir", "{ff0022}» {FFFFFF}Lütfen ürünün tam adýný girin:", "Devam", "Geri");
		}
	}
	return 1;
}
Dialog:UrunDurum(playerid, response, listitem, inputtext[])
{
	if (!response) return Dialog_Show(playerid, UrunDuzenle, DIALOG_STYLE_LIST, "Düzenle", "{FFFFFF}Ürün Ekle\n{FFFFFF}Ürün Sil\n{FFFFFF}Ürün Fiyat Düzenle\nÜrün Pasifleþtir/Aktifleþtir", "Seç", "Kapat");
	if (response)
	{
	    if (isnull(inputtext)) return Dialog_Show(playerid, UrunDurum, DIALOG_STYLE_INPUT, "Ürün Pasifleþtir/Aktifleþtir", "{ff0022}» {FFFFFF}Lütfen ürünün tam adýný girin:", "Devam", "Geri");
	    SetPVarString(playerid, "UrunAd", inputtext);
	    Dialog_Show(playerid, UrunPasifAktif, DIALOG_STYLE_MSGBOX, "Ürün Pasifleþtir/Aktifleþtir", "Bu ürüne ne yapmak istersiniz?", "Aktifleþtir", "Pasifleþtir");
	}
	return 1;
}
Dialog:UrunPasifAktif (playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    new urunad[40];
	    GetPVarString(playerid, "UrunAd", urunad, sizeof(urunad));
	    new query[124];
	    format(query, sizeof(query), "UPDATE `oocmarket` SET `durum` = '1' WHERE `urunadi` = '%s'", urunad);
	    mysql_query(g_SQL, query, false);
	}
	else
	{
	    new urunad[40];
	    GetPVarString(playerid, "UrunAd", urunad, sizeof(urunad));
	    new query[124];
	    format(query, sizeof(query), "UPDATE `oocmarket` SET `durum` = '0' WHERE `urunadi` = '%s'", urunad);
	    mysql_query(g_SQL, query, false);
	}
	return 1;
}
Dialog:FiyatDegistir(playerid, response, listitem, inputtext[])
{
	if (!response) return Dialog_Show(playerid, UrunDuzenle, DIALOG_STYLE_LIST, "Düzenle", "{FFFFFF}Ürün Ekle\n{FFFFFF}Ürün Sil\n{FFFFFF}Ürün Fiyat Düzenle\nÜrün Pasifleþtir/Aktifleþtir", "Seç", "Kapat");
	if (response)
	{
	    if (isnull(inputtext)) return Dialog_Show(playerid, FiyatDegistir, DIALOG_STYLE_INPUT, "Ürün Fiyat Deðiþtir", "{ff0022}» {FFFFFF}Lütfen fýyatýný deðiþtirmek istediðiniz ürünün tam adýný girin:", "Devam", "Geri");
	    SetPVarString(playerid, "FiyatDegistir", inputtext);
	    Dialog_Show(playerid, UrunFiyatDegistir, DIALOG_STYLE_INPUT, "Ürün Fiyat Deðiþtir", "Fiyat girin:", "Deðiþtir", "Kapat");
	}
	return 1;
}
Dialog:UrunFiyatDegistir(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (isnull(inputtext)) return Dialog_Show(playerid, UrunFiyatDegistir, DIALOG_STYLE_INPUT, "Ürün Fiyat Deðiþtir", "Fiyat girin:", "Deðiþtir", "Kapat");
	    if (!IsNumeric(inputtext)) return Dialog_Show(playerid, UrunFiyatDegistir, DIALOG_STYLE_INPUT, "Ürün Fiyat Deðiþtir", "Fiyat girin:", "Deðiþtir", "Kapat");
	    new urunad[40];
	    GetPVarString(playerid, "FiyatDegistir", urunad, sizeof(urunad));
	    new query[150];
	    format(query, sizeof(query), "UPDATE `oocmarket` SET `fiyat` = '%d' WHERE `urunadi` = '%s'", strval(inputtext), urunad);
	    mysql_query(g_SQL, query, false);
	}
	return 1;
}
Dialog:UrunSil(playerid, response, listitem, inputtext[])
{
	if (!response) return Dialog_Show(playerid, UrunDuzenle, DIALOG_STYLE_LIST, "Düzenle", "{FFFFFF}Ürün Ekle\n{FFFFFF}Ürün Sil\n{FFFFFF}Ürün Fiyat Düzenle\nÜrün Pasifleþtir/Aktifleþtir", "Seç", "Kapat");
	if (response)
	{
	    if (isnull(inputtext)) return Dialog_Show(playerid, UrunSil, DIALOG_STYLE_INPUT, "Ürün Sil", "{ff0022}» {FFFFFF}Lütfen silmek istediðiniz ürünün tam adýný girin:", "Devam", "Geri");
	    new query[100];
	    format(query, sizeof(query), "DELETE FROM `oocmarket` WHERE `urunadi` = '%s'", inputtext);
	    mysql_query(g_SQL, query, false);
	    SunucuMesaji(playerid, "%s adlý ürün silindi.", inputtext);
	}
	return 1;
}
Dialog:UrunEkle(playerid, response, listitem, inputtext[])
{
	if (!response) return Dialog_Show(playerid, UrunDuzenle, DIALOG_STYLE_LIST, "Düzenle", "{FFFFFF}Ürün Ekle\n{FFFFFF}Ürün Sil\n{FFFFFF}Ürün Fiyat Düzenle\nÜrün Pasifleþtir/Aktifleþtir", "Seç", "Kapat");
	if (response)
	{
	    if (isnull(inputtext)) return Dialog_Show(playerid, UrunEkle, DIALOG_STYLE_INPUT, "Ürün Ekle - Ad", "{ff0022}» {FFFFFF}Lütfen eklemek istediðiniz ürünün adýný girin:", "Devam", "Geri");
	    SetPVarString(playerid, "UrunAd", inputtext);
	    Dialog_Show(playerid, UrunEkleFiyat, DIALOG_STYLE_INPUT, "Ürün Ekle - Fiyat", "{ff0022}» {FFFFFF}Lütfen ürünün fiyatýný girin:", "Ekle", "Kapat");
	}
	return 1;
}
Dialog:UrunEkleFiyat(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (isnull(inputtext)) return Dialog_Show(playerid, UrunEkleFiyat, DIALOG_STYLE_INPUT, "Ürün Ekle - Fiyat", "ff0022}» {FFFFFF}Lütfen ürünün fiyatýný girin:", "Ekle", "Kapat");
	    if (!IsNumeric(inputtext)) return Dialog_Show(playerid, UrunEkleFiyat, DIALOG_STYLE_INPUT, "Ürün Ekle - Fiyat", "ff0022}» {FFFFFF}Lütfen ürünün fiyatýný girin:", "Ekle", "Kapat");
	    new query[250], ad[40];
	    GetPVarString(playerid, "UrunAd", ad, sizeof(ad));
	    format(query, sizeof(query), "INSERT INTO `oocmarket` (`urunadi`, `fiyat`, `durum`) VALUES ('%s', '%d', '1')", ad, strval(inputtext));
	    mysql_query(g_SQL, query, false);
	    MesajGonder(playerid, "%s adlý ürün eklenmiþtir.", ad);
	}
	return 1;
}
Dialog:BakiyeGonderID(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (isnull(inputtext)) return Dialog_Show(playerid, BakiyeGonderID, DIALOG_STYLE_INPUT, "Bakiye Gönder", "{ff0022}» {FFFFFF}Lütfen Bakiye göndermek istediðiniz oyuncunun ID'sini girin:", "Devam", "Geri");
	    if (!IsNumeric(inputtext)) return Dialog_Show(playerid, BakiyeGonderID, DIALOG_STYLE_INPUT, "Bakiye Gönder", "{ff0022}» {FFFFFF}Lütfen Bakiye göndermek istediðiniz oyuncunun ID'sini girin:", "Devam", "Geri");
	    new id = strval(inputtext);
	    if (!IsPlayerConnected(id))
	    {
	        HataMesajGonder(playerid, "Oyuncu oyunda deðil.");
	        return Dialog_Show(playerid, BakiyeGonderID, DIALOG_STYLE_INPUT, "Bakiye Gönder", "{ff0022}» {FFFFFF}Lütfen Bakiye göndermek istediðiniz oyuncunun ID'sini girin:", "Devam", "Geri");
	    }
	    if (id == playerid)
	    {
	        HataMesajGonder(playerid, "Kendinize bakiye gönderemezsiniz.");
	        return Dialog_Show(playerid, BakiyeGonderID, DIALOG_STYLE_INPUT, "Bakiye Gönder", "{ff0022}» {FFFFFF}Lütfen Bakiye göndermek istediðiniz oyuncunun ID'sini girin:", "Devam", "Geri");
	    }
	    SetPVarInt(playerid, "BakiyeID", id);
	    Dialog_Show(playerid, BakiyeGonder, DIALOG_STYLE_INPUT, "Bakiye Gönder", "{ff0022}» {FFFFFF}Lütfen göndermek istediðiniz bakiye miktarýný girin:", "Gönder", "Geri");
	}
	return 1;
}
Dialog:BakiyeGonder(playerid, response, listitem, inputtext[])
{
	if (!response) return Dialog_Show(playerid, BakiyeGonderID, DIALOG_STYLE_INPUT, "Bakiye Gönder", "{ff0022}» {FFFFFF}Lütfen Bakiye göndermek istediðiniz oyuncunun ID'sini girin:", "Devam", "Geri");
	if (response)
	{
	    if (isnull(inputtext)) return Dialog_Show(playerid, BakiyeGonder, DIALOG_STYLE_INPUT, "Bakiye Gönder", "{ff0022}» {FFFFFF}Lütfen göndermek istediðiniz bakiye miktarýný girin:", "Gönder", "Geri");
	    if (!IsNumeric(inputtext)) return Dialog_Show(playerid, BakiyeGonder, DIALOG_STYLE_INPUT, "Bakiye Gönder", "{ff0022}» {FFFFFF}Lütfen göndermek istediðiniz bakiye miktarýný girin:", "Gönder", "Geri");
	    if (strval(inputtext) <= 0 || strval(inputtext) > 100)
	    {
	        HataMesajGonder(playerid, "Minimum 1, maksimum 100 TL gönderebilirsiniz!");
	        return Dialog_Show(playerid, BakiyeGonder, DIALOG_STYLE_INPUT, "Bakiye Gönder", "{ff0022}» {FFFFFF}Lütfen göndermek istediðiniz bakiye miktarýný girin:", "Gönder", "Geri");
		}
		if (PlayerData[playerid][pBakiye] < strval(inputtext))
		{
		    HataMesajGonder(playerid, "O kadar bakiyeniz yok!");
		    return Dialog_Show(playerid, BakiyeGonder, DIALOG_STYLE_INPUT, "Bakiye Gönder", "{ff0022}» {FFFFFF}Lütfen göndermek istediðiniz bakiye miktarýný girin:", "Gönder", "Geri");
		}
		new id = GetPVarInt(playerid, "BakiyeID");
		if (!OyundaDegil(id))
		{
		    HataMesajGonder(playerid, "Bakiye göndereceðiniz kiþi oyundan çýktý.");
		    return 1;
		}
		PlayerData[playerid][pBakiye] -= strval(inputtext);
		PlayerData[id][pBakiye] += strval(inputtext);
		MesajGonder(playerid, "%s(%d) adlý kiþiye %d TL bakiye gönderdiniz.", ReturnName(id, 0), id, strval(inputtext));
		MesajGonder(id, "%s(%d) adlý kiþi size %d TL bakiye gönderdi.", ReturnName(playerid, 0), playerid, strval(inputtext));
		DeletePVar(playerid, "BakiyeID");
	}
	return 1;
}
Dialog:GarajGiris(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    new id = GetPVarInt(playerid, "Garaj");
	    if (GarageData[id][gExists])
	    {
	        if (isnull(inputtext)) return Dialog_Show(playerid, GarajGiris, DIALOG_STYLE_INPUT, "Garaj Þifre", "Bu garaj þifreli, lütfen þifreyi giriniz:", "Tamam", "Kapat");
	        if (!strcmp(GarageData[id][gSifre], inputtext, false))
	        {
	            if (!IsPlayerInAnyVehicle(playerid))
             	{
              		SetPlayerPos(playerid,GarageInteriors[GarageData[id][gInterior]][intX],GarageInteriors[GarageData[id][gInterior]][intY],GarageInteriors[GarageData[id][gInterior]][intZ]);
                	SetPlayerInterior(playerid,GarageInteriors[GarageData[id][gInterior]][intID]);
                 	SetPlayerVirtualWorld(playerid, id+23);
                  	SetPlayerFacingAngle(playerid,GarageInteriors[GarageData[id][gInterior]][intA]);
                   	SetCameraBehindPlayer(playerid);
                   	PlayerData[playerid][pGarage] = id;
              	}
              	if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
              	{
              	    new vehicleid = GetPlayerVehicleID(playerid);
              	    SetVehiclePos(vehicleid, GarageInteriors[GarageData[id][gInterior]][intX],GarageInteriors[GarageData[id][gInterior]][intY],GarageInteriors[GarageData[id][gInterior]][intZ]);
              	    SetVehicleVirtualWorld(vehicleid, id+23);
              	    LinkVehicleToInteriorEx(vehicleid, GarageInteriors[GarageData[id][gInterior]][intID]);
              	    SetVehicleZAngle(vehicleid, GarageInteriors[GarageData[id][gInterior]][intA]);
              	    SetPlayerPos(playerid,GarageInteriors[GarageData[id][gInterior]][intX],GarageInteriors[GarageData[id][gInterior]][intY],GarageInteriors[GarageData[id][gInterior]][intZ]);
                	SetPlayerInterior(playerid,GarageInteriors[GarageData[id][gInterior]][intID]);
                 	SetPlayerVirtualWorld(playerid, id+23);
                  	SetPlayerFacingAngle(playerid,GarageInteriors[GarageData[id][gInterior]][intA]);
                   	SetCameraBehindPlayer(playerid);
              	    PutPlayerInVehicle(playerid, vehicleid, 0);
              	    ObjelerYukleniyor(playerid);
              	    PlayerData[playerid][pGarage] = id;
              	    foreach (new i:Player)
              	    {
              	        if (IsPlayerInVehicle(i, vehicleid) && GetPlayerVehicleSeat(i) != 128 && GetPlayerVehicleSeat(i) != 0)
						{
						    SetPlayerPos(i,GarageInteriors[GarageData[id][gInterior]][intX],GarageInteriors[GarageData[id][gInterior]][intY],GarageInteriors[GarageData[id][gInterior]][intZ]);
                			SetPlayerInterior(i,GarageInteriors[GarageData[id][gInterior]][intID]);
                 			SetPlayerVirtualWorld(i, id+23);
                  			SetPlayerFacingAngle(i,GarageInteriors[GarageData[id][gInterior]][intA]);
                   			SetCameraBehindPlayer(i);
                   			PutPlayerInVehicle(i, vehicleid, GetPlayerVehicleSeat(i));
                   			ObjelerYukleniyor(i);
                   			PlayerData[i][pGarage] = id;
              	        }
              	    }
              	}
              	DeletePVar(playerid, "Garaj");
	        }
	        else
	        {
	            HataMesajGonder(playerid, "Hatalý þifre girdiniz!");
	            return Dialog_Show(playerid, GarajGiris, DIALOG_STYLE_INPUT, "Garaj Þifre", "Bu garaj þifreli, lütfen þifreyi giriniz:", "Tamam", "Kapat");
	        }
	    }
	}
	return 1;
}
Dialog:GarajAyarlar(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    new id = GetPVarInt(playerid, "GarajID");
	    if (listitem == 0)
	    {
	        if (GarageData[id][gKilit] == 1) GarageData[id][gKilit] = 0;
	        else GarageData[id][gKilit] = 1;

	        Garaj_Yenile(id);
	        Garaj_Kaydet(id);
	        callcmd::garaj(playerid);
	    }
	    if (listitem == 1)
	    {
	        Dialog_Show(playerid, GarajSifre, DIALOG_STYLE_INPUT, "Garaj ~ Þifre", "{FFFFFF}Lütfen garajýnýz için bir þifre belirleyin:\n\n{ff0000}NOT: {FFFFFF}Þifre yerine 'Yok' (týrnaksýz) yazarsanýz garaj þifresiz olur.", "Deðiþtir", "Geri");
	    }
	    if (listitem == 2)
	    {
	        if (GarageData[id][gParkDurum] == 1) GarageData[id][gParkDurum] = 0;
	        else GarageData[id][gParkDurum] = 1;

	        Garaj_Yenile(id);
	        Garaj_Kaydet(id);
	        callcmd::garaj(playerid);
	    }
	    if (listitem == 3)
	    {
	        Garaj_AracListesi(playerid, id);
		}
	}
	return 1;
}
Dialog:GarajAraclar(playerid, response, listitem, inputtext[])
{
	if (!response) return callcmd::garaj(playerid);
	if (response)
	{
	    new aracid = ParkedilenAraclar[playerid][listitem];
	    new garajid = GetPVarInt(playerid, "GarajID");
	    if (AracInfo[aracid][aracExists] && AracInfo[aracid][aracGaraj] == garajid)
	    {
	        SetVehiclePos(AracInfo[aracid][aracVehicle], GarageData[garajid][gPos][0]+1, GarageData[garajid][gPos][1]+1, GarageData[garajid][gPos][2]);
	        LinkVehicleToInteriorEx(AracInfo[aracid][aracVehicle], 0);
	        SetVehicleVirtualWorld(AracInfo[aracid][aracVehicle], GarageData[garajid][gVw]);
	        AracInfo[aracid][aracPos][0] = GarageData[garajid][gPos][0]+1;
	        AracInfo[aracid][aracPos][1] = GarageData[garajid][gPos][1]+1;
	        AracInfo[aracid][aracPos][2] = GarageData[garajid][gPos][2]+1;
	        AracInfo[aracid][aracGaraj] = -1;
	        AracInfo[aracid][aracInterior] = 0;
	        AracInfo[aracid][aracWorld] = GarageData[garajid][gVw];
	        MesajGonder(playerid, "%s model araç garajdan atýldý.", ReturnVehicleModelName(AracInfo[aracid][aracModel]));
	        Garaj_AracListesi(playerid, garajid);
	    }
	}
	return 1;
}
Dialog:GarajSifre(playerid, response, listitem, inputtext[])
{
	if (!response) return callcmd::garaj(playerid);
	if (response)
	{
	    if (isnull(inputtext)) return Dialog_Show(playerid, GarajSifre, DIALOG_STYLE_INPUT, "Garaj ~ Þifre", "{FFFFFF}Lütfen garajýnýz için bir þifre belirleyin:\n\n{ff0000}NOT: {FFFFFF}Þifre yerine 'Yok' (týrnaksýz) yazarsanýz garaj þifresiz olur.", "Deðiþtir", "Geri");
	    if (strlen(inputtext) > 30) return Dialog_Show(playerid, GarajSifre, DIALOG_STYLE_INPUT, "Garaj ~ Þifre", "{FFFFFF}Lütfen garajýnýz için bir þifre belirleyin:\n\n{ff0000}NOT: {FFFFFF}Þifre yerine 'Yok' (týrnaksýz) yazarsanýz garaj þifresiz olur.", "Deðiþtir", "Geri");

	    format(GarageData[GetPVarInt(playerid, "GarajID")][gSifre], 30, inputtext);
	    Garaj_Kaydet(GetPVarInt(playerid, "GarajID"));
	    callcmd::garaj(playerid);
	}
	return 1;
}
Dialog:LSPD(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    switch (listitem)
	    {
	        case 0:
	        {
	            KisiselCezalar(playerid);
	        }
	        case 1:
	        {
	            Dialog_Show(playerid, AracCezaPlaka, DIALOG_STYLE_INPUT, "{FFFFFF}Araç Cezalarý", "Lütfen cezasýný ödemek istediðiniz aracýn plakasýný girin:", "Devam", "Kapat");
	        }
	        case 2:
	        {
	            new str[1000], sayi;
	            format(str, sizeof(str), "ID\tAraç Model\tCeza\n");
	            for (new i; i<MAX_ARAC; i++) if (AracInfo[i][aracExists] && AracInfo[i][aracSahip] == PlayerData[playerid][pID] && AracInfo[i][aracBaglandi] == 1)
	            {
	                sayi++;
	                format(str, sizeof(str), "%s%d\t%s\t{04ff00}%s\n", str, i, ReturnVehicleModelName(AracInfo[i][aracModel]), FormatNumber(AracInfo[i][aracBaglandiCeza]));
	            }
	            if (sayi == 0) return HataMesajGonder(playerid, "Haczedilen aracýnýz yok.");
	            Dialog_Show(playerid, HaczedilenAraclar, DIALOG_STYLE_TABLIST_HEADERS, "{FFFFFF}Haczedilen Araçlarým", str, "Serbest Býrak", "Kapat");
	        }
	        case 3:
	        {
	            Dialog_Show(playerid, KefaletOde, DIALOG_STYLE_INPUT, "{FFFFFF}Kefalet Öde", "Lütfen kefaletini ödemek istediðiniz kiþinin ID'sini girin:", "Devam", "Kapat");
	        }
	        case 4:
	        {
	            if (!spamProtect(playerid, "MemurCagir", 60)) return HataMesajGonder(playerid, "Tekrar memur çaðýrmak için 1 dakika beklemelisiniz.");
	        	SendBirlikMessageEx(BIRLIK_LSPD, COLOR_DEPARTMENT, "** DEPARTMAN: %s adlý kiþi lobiye Memur talep ediyor.", ReturnName(playerid, 0));
	        	MesajGonder(playerid, "Memur çaðýrdýnýz.");
	        }
		}
	}
	return 1;
}

Dialog:Destek(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    switch (listitem)
	    {
	        case 0:
	        {
				if(gettime() - GetPVarInt(playerid, "BugSuresi") < 300)
					return HataMesajGonder(playerid, "Beþ dakika aralýklarla bug kurtarý kullanabilirsiniz.");
                static
	    		Float:x,
	    		Float:y,
	    		Float:z;
  			  GetPlayerPos(playerid, x, y, z);
	          SetPVarInt(playerid, "BugSuresi", gettime());
			  //PlayerData[playerid][pLegalTeleport] = gettime() + 2;
		   	  SetPlayerPos(playerid, x, y, z + 5);
      		  MesajGonder(playerid, "Kendinizi bugtan kurtardýnýz, eðer bugtan kurtulmadýysanýz bug talebi gönderebilirsiniz.");
  			  AdminMessage(COLOR_LIGHTRED, "Adm: %s  Bug kurtar sisemi ile kendini bugtan kurtardý.", ReturnName(playerid, 0));
	        }
	        case 1:
	        {
				if (GetPlayerInterior(playerid) == 0 && GetPlayerVirtualWorld(playerid) == 0) return HataMesajGonder(playerid, "Ýnterior dedektörü bug tespit edemedi, bugdaysanýz talep atabilirsiniz.");
				new hid = House_Inside(playerid);
	            if (hid == -1) return SetPVarInt(playerid, "FurnitureHouse", -1);
	            SetPlayerInterior(playerid, HouseInteriors[ HouseInfo[hid][evInterior] ][intID]);
  				SetPlayerPos(playerid, HouseInteriors[HouseInfo[hid][evInterior] ][intX], HouseInteriors[ HouseInfo[hid][evInterior] ][intY], HouseInteriors[ HouseInfo[hid][evInterior] ][intZ]);
          		SetPlayerVirtualWorld(playerid,HouseInfo[hid][evID]+1);
            	SetPVarInt(playerid, "FurnitureHouse", -1);
				MesajGonder(playerid, "Kendinizi interior dedektor ile kurtardýnýz, eðer bugtan kurtulmadýysanýz bug talebi gönderebilirsiniz.");
  			    AdminMessage(COLOR_LIGHTRED, "Adm: %s  interior dedektor ile sisemi ile kendini bugtan kurtardý.", ReturnName(playerid, 0));

				new hid2 = Entrance_Inside(playerid);
				SetPlayerInterior(playerid, EntranceData[hid2][entranceInterior]);
  				SetPlayerPos(playerid, EntranceData[hid2][entranceInterior], EntranceData[hid][entranceInterior], EntranceData[hid][entranceInterior]);
          		SetPlayerVirtualWorld(playerid,EntranceData[hid2][entranceInteriorVw]+1);
			}
			case 2:
	        {
				Dialog_Show(playerid, Destek2, DIALOG_STYLE_INPUT, "Soru Sor", "Lütfen destek ekibine iletilecek sorunuzu yazýn:", "Gönder", "Kapat");
			}
	        case 3:
	        {
             if (!OyundaDegil(playerid)) return 1;
    			if (Talep_GetCount(playerid) <= 0) return HataMesajGonder(playerid, "Destek talebiniz yok.");
    			for (new i; i<MAX_TALEP; i++) if (Talep[i][tExists] == true && Talep[i][tGonderen] == playerid)
  				{
  	    		Talep[i][tExists] = false;
  	    		format(Talep[i][tIcerik], 128, "");
  	    		Talep[i][tGonderen] = -1;
  	    		Talep[i][tIlgilenen] = -1;
  				}
			MesajGonder(playerid, "Destek talebiniz silindi.");
	        }
	    }
	}
	return 1;
}
Dialog:Destek2(playerid, response, listitem, inputtext[])
{
	if (response)

	if(gettime() - GetPVarInt(playerid, "DestekSuresi") < 120)
		return HataMesajGonder(playerid, "Ýki dakika aralýklarla destek mesajý gönderebilirsiniz.");

    if (!OyundaDegil(playerid)) return 1;
    if (Talep_GetCount(playerid) >= 1) return HataMesajGonder(playerid, "Bakýlmasý beklenen 1 adet destek talebiniz var daha fazla destek yollayamazsýnýz!");

    new talepid = -1;
	if ((talepid = Talep_Add(playerid, inputtext)) != -1)
    {
    	SetPVarInt(playerid, "DestekSuresi", gettime());

    	foreach (new i : Player)
        {
            if (PlayerData[i][pAdmin] > 0 || PlayerData[i][pHelper] > 0 || PlayerData[i][pForumGorevlisi] > 0 || PlayerData[i][pOyunGorevlisi] > 0)
			{
			    if (strlen(inputtext) > 64)
			    {
                	SendClientMessageEx(i, 0xCD3232AA, "(Destek %d) %s (%d): %.64s", talepid, ReturnName(playerid, 0), playerid, inputtext);
                	SendClientMessageEx(i, 0xCD3232AA, "%s", inputtext[64]);
                }
                else
                {
                    SendClientMessageEx(i, 0xCD3232AA, "(Destek %d) %s (%d): %s", talepid, ReturnName(playerid), playerid, inputtext);
                }
            }
        }
        MesajGonder(playerid, "Destek talebiniz iletildi, ilgili yetkililer en kýsa sürede talebinize yanýt verecektir bu süre içerisinde sabýrla bekleyin.", talepid+1);
    }
    else
    {
        HataMesajGonder(playerid, "Destek talebi listesi dolu destek göndermek için lütfen biraz bekleyiniz.");
	}
	return 1;
}

Dialog:AracCezaPlaka(playerid, response, listitem, inputtext[])
{
	if (response)
	{
    	if (isnull(inputtext)) return Dialog_Show(playerid, AracCezaPlaka, DIALOG_STYLE_INPUT, "{FFFFFF}Araç Cezalarý", "Lütfen cezasýný ödemek istediðiniz aracýn plakasýný girin:", "Devam", "Kapat");
	    new id = -1;
	    for (new i; i != MAX_ARAC; i++)
	    {
	        if (AracInfo[i][aracExists] && AracInfo[i][aracTip] == 4 && AracInfo[i][aracSahip] > 0)
	        {
	            if (strcmp(AracInfo[i][aracPlaka], inputtext, false) == 0)
	            {
	                id = i;
	                break;
				}
			}
		}
		if (id == -1)
		{
		    HataMesajGonder(playerid, "Geçersiz plaka girdiniz.");
		    return Dialog_Show(playerid, AracCezaPlaka, DIALOG_STYLE_INPUT, "{FFFFFF}Araç Cezalarý", "Lütfen cezasýný ödemek istediðiniz aracýn plakasýný girin:", "Devam", "Kapat");
		}
		if (AracInfo[id][aracTicket] == 0)
		{
		    HataMesajGonder(playerid, "Bu aracýn cezasý yok.");
		    return Dialog_Show(playerid, AracCezaPlaka, DIALOG_STYLE_INPUT, "{FFFFFF}Araç Cezalarý", "Lütfen cezasýný ödemek istediðiniz aracýn plakasýný girin:", "Devam", "Kapat");
		}
		SetPVarInt(playerid, "TicketID", id);
		Dialog_Show(playerid, AracCezaOde, DIALOG_STYLE_MSGBOX, "Araç Ceza Öde", "{FFFFFF}Bu aracýn {04ff00}%s {FFFFFF}cezasý bulunmaktadýr. Ödemek istiyor musunuz?", "Öde", "Iptal", FormatNumber(AracInfo[id][aracTicket]));
	}
	return 1;
}
Dialog:AracCezaOde(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    new id = GetPVarInt(playerid, "TicketID");
	    if (AracInfo[id][aracTicket] > PlayerData[playerid][pCash]) return HataMesajGonder(playerid, "Yeterli paranýz yok.");
	    ParaVer(playerid, -AracInfo[id][aracTicket]);
	    MesajGonder(playerid, "Aracýn %s miktar cezasýný ödediniz.", FormatNumber(AracInfo[id][aracTicket]));
	    AracInfo[id][aracTicket] = 0;
	    AracInfo[id][aracTicketTime] = 0;
	    AracInfo[id][aracElKonuldu] = 0;
	    Arac_Kaydet(id);
	    DeletePVar(playerid, "TicketID");
	}
	return 1;
}
Dialog:KefaletOde(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (isnull(inputtext) || !IsNumeric(inputtext) || playerid == strval(inputtext)) return Dialog_Show(playerid, KefaletOde, DIALOG_STYLE_INPUT, "{FFFFFF}Kefalet Öde", "Lütfen kefaletini ödemek istediðiniz kiþinin ID'sini girin:", "Devam", "Kapat");
	    new id = strval(inputtext);
	    if (!OyundaDegil(id))
	    {
	        HataMesajGonder(playerid, "Oyuncu oyunda deðil.");
	        return Dialog_Show(playerid, KefaletOde, DIALOG_STYLE_INPUT, "{FFFFFF}Kefalet Öde", "Lütfen kefaletini ödemek istediðiniz kiþinin ID'sini girin:", "Devam", "Kapat");
	    }
	    if (PlayerData[id][pHapis] == 0 || PlayerData[id][pHapisSure]/60 < 3)
	    {
	        HataMesajGonder(playerid, "Bu oyuncu IC hapiste deðil veya hapisten çýkmasýna az kalmýþ.");
	        return Dialog_Show(playerid, KefaletOde, DIALOG_STYLE_INPUT, "{FFFFFF}Kefalet Öde", "Lütfen kefaletini ödemek istediðiniz kiþinin ID'sini girin:", "Devam", "Kapat");
	    }
	    SetPVarInt(playerid, "KefaletID", strval(inputtext));
	    Dialog_Show(playerid, KefaletOde2, DIALOG_STYLE_MSGBOX, "{FFFFFF}Kefalet Öde", "{FFFFFF}%s adlý kiþiyi hapisten çýkarmak istiyorsanýz {04ff00}$%d {FFFFFF}ödemelisiniz. Kabul ediyor musunuz?", "Evet", "Hayýr", ReturnName(id, 0), floatround(PlayerData[id][pHapisSure]/60*500));
	}
	return 1;
}
Dialog:KefaletOde2(playerid, response, listitem, inputtext[])
{
	if (!response) return DeletePVar(playerid, "KefaletID");
	if (response)
	{
	    new id = GetPVarInt(playerid, "KefaletID");
	    if (!OyundaDegil(id)) return HataMesajGonder(playerid, "Oyuncu oyunda deðil.");
	    if (PlayerData[id][pHapis] == 0 || PlayerData[id][pHapisSure]/60 < 3) return HataMesajGonder(playerid, "Bu oyuncu IC hapiste deðil veya hapisten çýkmasýna az kalmýþ.");
	    if (PlayerData[playerid][pCash] < floatround(PlayerData[id][pHapisSure]/60*500)) return HataMesajGonder(playerid, "Yeterli paranýz yok.");
	    new miktar = floatround(PlayerData[id][pHapisSure]/60*500);
	    ParaVer(playerid, -miktar);
	    MesajGonder(playerid, "%s adlý kiþiyi {04ff00}%s {FFFFFF} kefalet ödeyerek çýkardýnýz.", ReturnName(id, 0), FormatNumber(miktar));
	    MesajGonder(id, "%s adlý kiþi {04ff00}%s {FFFFFF}kefalet ödeyerek sizi hapisten çýkardý.", ReturnName(playerid, 0), FormatNumber(miktar));
	    PlayerData[id][pHapis] = 0;
	    PlayerData[id][pHapisSure] = 0;
		SetPlayerPos(id, 1464.9292,-1690.9778,-70.0371);
  		SetPlayerInterior(id, 0);
    	SetPlayerVirtualWorld(id, 0);
     	SetCameraBehindPlayer(id);
      	ObjelerYukleniyor(id);
  		PlayerTextDrawHide(id, HapisTD[id]);

	}
	return 1;
}
Dialog:HaczedilenAraclar(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    new id = strval(inputtext);
	    if (AracInfo[id][aracExists] && AracInfo[id][aracSahip] == PlayerData[playerid][pID] && AracInfo[id][aracBaglandi] == 1)
	    {
	        if (AracInfo[id][aracBaglandiCeza] > PlayerData[playerid][pCash]) return HataMesajGonder(playerid, "Yeterli paranýz yok.");

	        ParaVer(playerid, -AracInfo[id][aracBaglandiCeza]);

			MesajGonder(playerid, "%s model aracýnýzý {04ff00}%s {FFFFFF}ödeyerek serbest býraktýnýz. (/araclarim)",ReturnVehicleModelName(AracInfo[id][aracModel]), FormatNumber(AracInfo[id][aracBaglandiCeza]));
			MesajGonder(playerid, "Aracýnýz LSPD binasýnýn önünde park edildi. (\"/aracimibul\")");

			AracInfo[id][aracPos][0] = 1511.8376;
            AracInfo[id][aracPos][1] = -1661.9646;
            AracInfo[id][aracPos][2] = 13.4252;
            AracInfo[id][aracPos][3] = 269.9812;

			AracInfo[id][aracBaglandi] = 0;
	        AracInfo[id][aracBaglandiCeza] = 0;

			Arac_Kaydet(id);
			Arac_Spawn(id, 1);
	    }
	}
	return 1;
}
Dialog:KisiselCezalar(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    new id = CezaListele[playerid][listitem];
	    if (TicketData[playerid][id][ticketExists])
	    {
	        if (TicketData[playerid][id][ticketFee] > PlayerData[playerid][pCash]) return HataMesajGonder(playerid, "Bu cezayý ödemek için yeterli paranýz yok.");
	        ParaVer(playerid, -TicketData[playerid][id][ticketFee]);
	        MesajGonder(playerid, "{04ff00}%s {FFFFFF}miktar cezayý ödediniz.", FormatNumber(TicketData[playerid][id][ticketFee]));
	        Ticket_Remove(playerid, id);
	    }
	}
	return 1;
}
Dialog:HukumetBinasi(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (listitem == 0)
	    {
	        Dialog_Show(playerid, AracVergi, DIALOG_STYLE_INPUT, "Araç Plaka", "{E74C3C}» {FFFFFF}Lütfen vergisini ödemek istediðiniz aracýn plakasýný girin:", "Devam", "Geri");
	    }
	    if (listitem == 1)
	    {
	        Dialog_Show(playerid, IsyeriVergi, DIALOG_STYLE_INPUT, "Ýþyeri ID", "{E74C3C}» {FFFFFF}Lütfen vergisini ödemek istediðiniz iþyerinin ID'sini girin:", "Devam", "Geri");
	    }
	    if (listitem == 2)
	    {
	        Dialog_Show(playerid, EvVergi, DIALOG_STYLE_INPUT, "Ev ID", "{E74C3C}» {FFFFFF}Lütfen vergisini ödemek istediðiniz evin ID'sini girin:", "Devam", "Geri");
	    }
	    if (listitem == 3)
	    {
			if (PlayerData[playerid][pPartner] < 1) return HataMesajGonder(playerid, "Evli deðilsiniz.");
			if (PlayerData[playerid][pCash] < 1500) return HataMesajGonder(playerid, "Boþanmak için yeterli paranýz yok. ($1,500)");
			Dialog_Show(playerid, Bosanma, DIALOG_STYLE_MSGBOX, "Boþanma", "{E74C3C}» {FFFFFF}$1,500 ödeyerek eþinizden boþanmayý onaylýyor musunuz?", "Evet", "Hayýr");
	    }
	    if (listitem == 4)
	    {
	        if (PlayerData[playerid][pMaas] < 1) return HataMesajGonder(playerid, "Maaþýnýz yok.");
	        Dialog_Show(playerid, MaasCek, DIALOG_STYLE_INPUT, "Maaþ Çek", "{E74C3C}» {FFFFFF}Lütfen çekmek istediðiniz maaþ miktarýný girin:", "Çek", "Geri");
	    }
	}
	return 1;
}
Dialog:Bosanma(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (PlayerData[playerid][pPartner] > 0 && PlayerData[playerid][pCash] >= 1500)
	    {
	        new query[100];
	        ParaVer(playerid, -1500);
	        PlayerData[playerid][pPartner] = 0;
	        format(query, sizeof(query), "UPDATE `oyuncular` SET `Partner` = '0' WHERE `Partner` = '%d'", PlayerData[playerid][pID]);
	        mysql_query(g_SQL, query, false);
	        foreach (new i : Player) if (PlayerData[i][pPartner] == PlayerData[playerid][pID])
	        {
            	PlayerData[i][pPartner] = 0;
            }
            MesajGonder(playerid, "$1,500 ödeyerek eþinizden boþandýnýz.");
	    }
	}
	return 1;
}
Dialog:MaasCek(playerid, response, listitem, inputtext[])
{
	if (!response) return Dialog_Show(playerid, HukumetBinasi, DIALOG_STYLE_LIST, "{FFFFFF}Hükümet Binasý", "{FFFFFF}Araç Vergisi Sorgula\n{FFFFFF}Ýþyeri Vergisi Sorgula\n{FFFFFF}Ev Vergisi Sorgula\n{FFFFFF}Boþanma Ýþlemleri\n{FFFFFF}Maaþ Çek {00ff15}(%s)", "Seç", "Kapat", FormatNumber(PlayerData[playerid][pMaas]));
	if (response)
	{
	    if (isnull(inputtext) || !IsNumeric(inputtext)) return Dialog_Show(playerid, MaasCek, DIALOG_STYLE_INPUT, "Maaþ Çek", "{E74C3C}» {FFFFFF}Lütfen çekmek istediðiniz maaþ miktarýný girin:", "Çek", "Geri");
	    if (strval(inputtext) < 1) return Dialog_Show(playerid, MaasCek, DIALOG_STYLE_INPUT, "Maaþ Çek", "{E74C3C}» {FFFFFF}Lütfen çekmek istediðiniz maaþ miktarýný girin:", "Çek", "Geri");
	    if (strval(inputtext) > PlayerData[playerid][pMaas])
	    {
	        HataMesajGonder(playerid, "O kadar maaþýnýz yok.");
	        return Dialog_Show(playerid, MaasCek, DIALOG_STYLE_INPUT, "Maaþ Çek", "{E74C3C}» {FFFFFF}Lütfen çekmek istediðiniz maaþ miktarýný girin:", "Çek", "Geri");
	    }
	    PlayerData[playerid][pMaas] -= strval(inputtext);
	    ParaVer(playerid, strval(inputtext));
	    MesajGonder(playerid, "Maaþýnýzdan {04ff00}%s {FFFFFF}miktar para çektiniz.", FormatNumber(strval(inputtext)));
	}
	return 1;
}
Dialog:EvVergi(playerid, response, listitem, inputtext[])
{
	if (!response) return Dialog_Show(playerid, HukumetBinasi, DIALOG_STYLE_LIST, "{FFFFFF}Hükümet Binasý", "{FFFFFF}Araç Vergisi Sorgula\n{FFFFFF}Ýþyeri Vergisi Sorgula\n{FFFFFF}Ev Vergisi Sorgula\n{FFFFFF}Boþanma Ýþlemleri\n{FFFFFF}Maaþ Çek {00ff15}(%s)", "Seç", "Kapat", FormatNumber(PlayerData[playerid][pMaas]));
	if (response)
	{
	    if (isnull(inputtext) || !IsNumeric(inputtext)) return Dialog_Show(playerid, EvVergi, DIALOG_STYLE_INPUT, "Ev ID", "{E74C3C}» {FFFFFF}Lütfen vergisini ödemek istediðiniz evin ID'sini girin:", "Devam", "Geri");
	    if ((strval(inputtext) < 0 || strval(inputtext) >= MAX_EV) || !HouseInfo[strval(inputtext)][evExists])
	    {
	        HataMesajGonder(playerid, "Hatalý ev ID'si girdiniz.");
	        return Dialog_Show(playerid, EvVergi, DIALOG_STYLE_INPUT, "Ev ID", "{E74C3C}» {FFFFFF}Lütfen vergisini ödemek istediðiniz evin ID'sini girin:", "Devam", "Geri");
	    }
	    if (HouseInfo[strval(inputtext)][evVergi] < 1)
	    {
	        HataMesajGonder(playerid, "Bu evin vergisi yok.");
            return Dialog_Show(playerid, EvVergi, DIALOG_STYLE_INPUT, "Ev ID", "{E74C3C}» {FFFFFF}Lütfen vergisini ödemek istediðiniz evin ID'sini girin:", "Devam", "Geri");
	    }
	    SetPVarInt(playerid, "evID", strval(inputtext));
	    Dialog_Show(playerid, EvVergiOde, DIALOG_STYLE_MSGBOX, "Ev Vergi Öde", "{FFFFFF}'%s' adlý evin {04ff00}%s {FFFFFF}vergisi bulunmaktadýr. Ödemek istiyor musunuz?", "Öde", "Geri", HouseInfo[strval(inputtext)][evIsim], FormatNumber(HouseInfo[strval(inputtext)][evVergi]));
	}
	return 1;
}
Dialog:EvVergiOde(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    new id = GetPVarInt(playerid, "evID");
	    if (HouseInfo[id][evVergi] > PlayerData[playerid][pCash]) return HataMesajGonder(playerid, "Yeterli paranýz yok.");
	    ParaVer(playerid, -HouseInfo[id][evVergi]);
	    MesajGonder(playerid, "%s adlý evin {04ff00}%s {FFFFFF}miktar vergisini ödediniz.", HouseInfo[id][evIsim], FormatNumber(HouseInfo[id][evVergi]));
	    HouseInfo[id][evVergi] = 0;
	    HouseInfo[id][evVergiSure] = 0;
	    Ev_Kaydet(id);
	    DeletePVar(playerid, "evID");
	}
	return 1;
}
Dialog:IsyeriVergi(playerid, response, listitem, inputtext[])
{
	if (!response) return Dialog_Show(playerid, HukumetBinasi, DIALOG_STYLE_LIST, "{FFFFFF}Hükümet Binasý", "{FFFFFF}Araç Vergisi Sorgula\n{FFFFFF}Ýþyeri Vergisi Sorgula\n{FFFFFF}Ev Vergisi Sorgula\n{FFFFFF}Boþanma Ýþlemleri\n{FFFFFF}Maaþ Çek {00ff15}(%s)", "Seç", "Kapat", FormatNumber(PlayerData[playerid][pMaas]));
	if (response)
	{
	    if (isnull(inputtext) || !IsNumeric(inputtext)) return Dialog_Show(playerid, IsyeriVergi, DIALOG_STYLE_INPUT, "Ýþyeri ID", "{E74C3C}» {FFFFFF}Lütfen vergisini ödemek istediðiniz iþyerinin ID'sini girin:", "Devam", "Geri");
	    if ((strval(inputtext) < 0 || strval(inputtext) >= MAX_ISYERI) || !Isyeri[strval(inputtext)][isyeriExists])
	    {
	        HataMesajGonder(playerid, "Hatalý iþyeri ID'si girdiniz.");
	        return Dialog_Show(playerid, IsyeriVergi, DIALOG_STYLE_INPUT, "Ýþyeri ID", "{E74C3C}» {FFFFFF}Lütfen vergisini ödemek istediðiniz iþyerinin ID'sini girin:", "Devam", "Geri");
	    }
	    if (Isyeri[strval(inputtext)][isyeriVergi] < 1)
	    {
	        HataMesajGonder(playerid, "Bu iþyerinin vergisi yok.");
            return Dialog_Show(playerid, IsyeriVergi, DIALOG_STYLE_INPUT, "Ýþyeri ID", "{E74C3C}» {FFFFFF}Lütfen vergisini ödemek istediðiniz iþyerinin ID'sini girin:", "Devam", "Geri");
	    }
	    SetPVarInt(playerid, "IsyeriID", strval(inputtext));
	    Dialog_Show(playerid, IsyeriVergiOde, DIALOG_STYLE_MSGBOX, "Ýþyeri Vergi Öde", "{FFFFFF}'%s' adlý iþyerinin {04ff00}%s {FFFFFF}vergisi bulunmaktadýr. Ödemek istiyor musunuz?", "Öde", "Geri", Isyeri[strval(inputtext)][isyeriName], FormatNumber(Isyeri[strval(inputtext)][isyeriVergi]));
	}
	return 1;
}
Dialog:IsyeriVergiOde(playerid, response, listitem, inputtext[])
{
	//if (!response) return Dialog_Show(playerid, IsyeriVergi, DIALOG_STYLE_INPUT, "Ýþyeri ID", "{E74C3C}» {FFFFFF}Lütfen vergisini ödemek istediðiniz iþyerinin ID'sini girin:", "Devam", "Geri");
	if (response)
	{
	    new id = GetPVarInt(playerid, "IsyeriID");
	    if (Isyeri[id][isyeriVergi] > PlayerData[playerid][pCash]) return HataMesajGonder(playerid, "Yeterli paranýz yok.");
	    ParaVer(playerid, -Isyeri[id][isyeriVergi]);
	    MesajGonder(playerid, "%s adlý iþyerinin {04ff00}%s {FFFFFF}miktar vergisini ödediniz.", Isyeri[id][isyeriName], FormatNumber(Isyeri[id][isyeriVergi]));
	    Isyeri[id][isyeriVergi] = 0;
	    Isyeri[id][isyeriVergiSure] = 0;
	    Isyeri_Kaydet(id);
	    DeletePVar(playerid, "IsyeriID");
	}
	return 1;
}
Dialog:AracVergi(playerid, response, listitem, inputtext[])
{
	if (!response) return Dialog_Show(playerid, HukumetBinasi, DIALOG_STYLE_LIST, "{FFFFFF}Hükümet Binasý", "{FFFFFF}Araç Vergisi Sorgula\n{FFFFFF}Ýþyeri Vergisi Sorgula\n{FFFFFF}Ev Vergisi Sorgula\n{FFFFFF}Boþanma Ýþlemleri\n{FFFFFF}Maaþ Çek {00ff15}(%s)", "Seç", "Kapat", FormatNumber(PlayerData[playerid][pMaas]));
	if (response)
	{
	    if (isnull(inputtext)) return Dialog_Show(playerid, AracVergi, DIALOG_STYLE_INPUT, "Araç Plaka", "{E74C3C}» {FFFFFF}Lütfen vergisini ödemek istediðiniz aracýn plakasýný girin:", "Devam", "Geri");
	    new id = -1;
	    for (new i; i < MAX_ARAC; i++)
	    {
	        if (AracInfo[i][aracExists] && AracInfo[i][aracTip] == 4 && AracInfo[i][aracSahip] > 0)
	        {
	            if (strcmp(AracInfo[i][aracPlaka], inputtext, false) == 0)
	            {
	                id = i;
	                break;
				}
			}
		}
		if (id == -1)
		{
		    HataMesajGonder(playerid, "Geçersiz plaka girdiniz.");
		    return Dialog_Show(playerid, AracVergi, DIALOG_STYLE_INPUT, "Araç Plaka", "{E74C3C}» {FFFFFF}Lütfen vergisini ödemek istediðiniz aracýn plakasýný girin:", "Devam", "Geri");
		}
		if (AracInfo[id][aracVergi] == 0)
		{
		    HataMesajGonder(playerid, "Bu aracýn vergisi yok.");
		    return Dialog_Show(playerid, AracVergi, DIALOG_STYLE_INPUT, "Araç Plaka", "{E74C3C}» {FFFFFF}Lütfen vergisini ödemek istediðiniz aracýn plakasýný girin:", "Devam", "Geri");
		}
		SetPVarInt(playerid, "VergiID", id);
		Dialog_Show(playerid, AracVergiOde, DIALOG_STYLE_MSGBOX, "Araç Vergi Öde", "{FFFFFF}Bu aracýn {04ff00}%s {FFFFFF}vergisi bulunmaktadýr. Ödemek istiyor musunuz?", "Öde", "Iptal", FormatNumber(AracInfo[id][aracVergi]));
	}
	return 1;
}
Dialog:AracVergiOde(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    new id = GetPVarInt(playerid, "VergiID");
	    if (AracInfo[id][aracVergi] > PlayerData[playerid][pCash]) return HataMesajGonder(playerid, "Yeterli paranýz yok.");
	    ParaVer(playerid, -AracInfo[id][aracVergi]);
	    MesajGonder(playerid, "Aracýn %s miktar vergisini ödediniz.", FormatNumber(AracInfo[id][aracVergi]));
	    AracInfo[id][aracVergi] = 0;
	    AracInfo[id][aracVergiSure] = 0;
	    Arac_Kaydet(id);
	    DeletePVar(playerid, "VergiID");
	}
	return 1;
}
Dialog:Bagaj(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (listitem == 0)
	    {
	        if (GetFactionType(playerid) != BIRLIK_LSPD) Dialog_Show(playerid, BagajUyusturucular, DIALOG_STYLE_LIST, "{E74C3C}Bagaj: {FFFFFF}Uyuþturucular", "{FFFFFF}Uyuþturucu Koy\t{53f442}%d gram üzerinizde\n{FFFFFF}Uyuþturucu Al\t{ff0000}%d gram bagajda", "Seç", "Geri", PlayerDrugData[playerid][Drugs], AracInfo[GetPVarInt(playerid, "AracBagaj")][aracUyusturucu]);
	        else Dialog_Show(playerid, BagajUyusturucular, DIALOG_STYLE_LIST, "{E74C3C}Bagaj: {FFFFFF}Uyuþturucular", "{FFFFFF}Uyuþturucu Koy\t{53f442}%d gram üzerinizde\n{FFFFFF}Uyuþturucu Al\t{ff0000}%d gram bagajda\n{FFFFFF}Uyuþturuculara El Koy", "Seç", "Geri", PlayerDrugData[playerid][Drugs], AracInfo[GetPVarInt(playerid, "AracBagaj")][aracUyusturucu]);
	    }
	    if (listitem == 1)
	    {
	        AracSilahlar(playerid, GetPVarInt(playerid, "AracBagaj"));
		}
	}
	return 1;
}
Dialog:BagajUyusturucular(playerid, response, listitem, inputtext[])
{
	if (!response) return callcmd::bagaj(playerid);
	if (response)
	{
	    if (listitem == 0)
	    {
	        if (PlayerDrugData[playerid][Drugs] < 1)
	        {
	            HataMesajGonder(playerid, "Üzerinizde hiç uyuþturucu yok.");
	            if (GetFactionType(playerid) != BIRLIK_LSPD) Dialog_Show(playerid, BagajUyusturucular, DIALOG_STYLE_LIST, "{E74C3C}Bagaj: {FFFFFF}Uyuþturucular", "{FFFFFF}Uyuþturucu Koy\t{53f442}%d gram üzerinizde\n{FFFFFF}Uyuþturucu Al\t{ff0000}%d gram bagajda", "Seç", "Geri", PlayerDrugData[playerid][Drugs], AracInfo[GetPVarInt(playerid, "AracBagaj")][aracUyusturucu]);
	        	else Dialog_Show(playerid, BagajUyusturucular, DIALOG_STYLE_LIST, "{E74C3C}Bagaj: {FFFFFF}Uyuþturucular", "{FFFFFF}Uyuþturucu Koy\t{53f442}%d gram üzerinizde\n{FFFFFF}Uyuþturucu Al\t{ff0000}%d gram bagajda\n{FFFFFF}Uyuþturuculara El Koy", "Seç", "Geri", PlayerDrugData[playerid][Drugs], AracInfo[GetPVarInt(playerid, "AracBagaj")][aracUyusturucu]);
	        	return 1;
	        }
	        Dialog_Show(playerid, UyusturucuKoy, DIALOG_STYLE_INPUT, "{E74C3C}Bagaj: {FFFFFF}Uyuþturucu Koy", "{E74C3C}» {FFFFFF}Lütfen araca koymak istediðiniz uyuþturucu miktarýný girin:", "Koy", "Geri");
		}
		if (listitem == 1)
		{
		    if (AracInfo[GetPVarInt(playerid, "AracBagaj")][aracUyusturucu] < 1)
		    {
		        HataMesajGonder(playerid, "Aracýn bagajýnda hiç uyuþturucu yok.");
		        if (GetFactionType(playerid) != BIRLIK_LSPD) Dialog_Show(playerid, BagajUyusturucular, DIALOG_STYLE_LIST, "{E74C3C}Bagaj: {FFFFFF}Uyuþturucular", "{FFFFFF}Uyuþturucu Koy\t{53f442}%d gram üzerinizde\n{FFFFFF}Uyuþturucu Al\t{ff0000}%d gram bagajda", "Seç", "Geri", PlayerDrugData[playerid][Drugs], AracInfo[GetPVarInt(playerid, "AracBagaj")][aracUyusturucu]);
	        	else Dialog_Show(playerid, BagajUyusturucular, DIALOG_STYLE_LIST, "{E74C3C}Bagaj: {FFFFFF}Uyuþturucular", "{FFFFFF}Uyuþturucu Koy\t{53f442}%d gram üzerinizde\n{FFFFFF}Uyuþturucu Al\t{ff0000}%d gram bagajda\n{FFFFFF}Uyuþturuculara El Koy", "Seç", "Geri", PlayerDrugData[playerid][Drugs], AracInfo[GetPVarInt(playerid, "AracBagaj")][aracUyusturucu]);
	        	return 1;
		    }
		    Dialog_Show(playerid, UyusturucuAl, DIALOG_STYLE_INPUT, "{E74C3C}Bagaj: {FFFFFF}Uyuþturucu Al", "{E74C3C}» {FFFFFF}Lütfen aracýn bagajýndan almak istediðiniz uyuþturucu miktarýný girin:", "Al", "Geri");
		}
		if (listitem == 2)
		{
		    if (AracInfo[GetPVarInt(playerid, "AracBagaj")][aracUyusturucu] < 1)
		    {
		        HataMesajGonder(playerid, "Aracýn bagajýnda hiç uyuþturucu yok.");
		        if (GetFactionType(playerid) != BIRLIK_LSPD) Dialog_Show(playerid, BagajUyusturucular, DIALOG_STYLE_LIST, "{E74C3C}Bagaj: {FFFFFF}Uyuþturucular", "{FFFFFF}Uyuþturucu Koy\t{53f442}%d gram üzerinizde\n{FFFFFF}Uyuþturucu Al\t{ff0000}%d gram bagajda", "Seç", "Geri", PlayerDrugData[playerid][Drugs], AracInfo[GetPVarInt(playerid, "AracBagaj")][aracUyusturucu]);
	        	else Dialog_Show(playerid, BagajUyusturucular, DIALOG_STYLE_LIST, "{E74C3C}Bagaj: {FFFFFF}Uyuþturucular", "{FFFFFF}Uyuþturucu Koy\t{53f442}%d gram üzerinizde\n{FFFFFF}Uyuþturucu Al\t{ff0000}%d gram bagajda\n{FFFFFF}Uyuþturuculara El Koy", "Seç", "Geri", PlayerDrugData[playerid][Drugs], AracInfo[GetPVarInt(playerid, "AracBagaj")][aracUyusturucu]);
	        	return 1;
		    }
		    AracInfo[GetPVarInt(playerid, "AracBagaj")][aracUyusturucu] = 0;
		    Arac_Kaydet(GetPVarInt(playerid, "AracBagaj"));
		    MesajGonder(playerid, "Aracýn bagajýnda bulunan uyuþturuculara el koydunuz.");
		}
	}
	return 1;
}
Dialog:EvUyusturucuKoy(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    new evid = House_Inside(playerid);
	    if (evid == -1) return 1;
	    if (isnull(inputtext) || !IsNumeric(inputtext)) return Dialog_Show(playerid, EvUyusturucuKoy, DIALOG_STYLE_INPUT, "Uyuþturucu Koy", "{FFFFFF}Lütfen evinize koymak istediðiniz uyuþturucu miktarýný girin:", "Koy", "Kapat");
	    if (strval(inputtext) > PlayerDrugData[playerid][Drugs])
	    {
	        HataMesajGonder(playerid, "Üzerinizde o kadar uyuþturucu yok.");
	        return Dialog_Show(playerid, EvUyusturucuKoy, DIALOG_STYLE_INPUT, "Uyuþturucu Koy", "{FFFFFF}Lütfen evinize koymak istediðiniz uyuþturucu miktarýný girin:", "Koy", "Kapat");
	    }
	    HouseInfo[evid][evUyusturucu] += strval(inputtext);
	    PlayerDrugData[playerid][Drugs] -= strval(inputtext);
	    MesajGonder(playerid, "Evinizin kasasýna %d gram uyuþturucu koydunuz.", strval(inputtext));
	    Ev_Kaydet(evid);
	}
	return 1;
}
Dialog:EvUyusturucuAl(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    new id = House_Inside(playerid);
	    if (id == -1) return 1;
	    if (isnull(inputtext) || !IsNumeric(inputtext)) return Dialog_Show(playerid, EvUyusturucuAl, DIALOG_STYLE_INPUT, "Uyuþturucu Al", "{FFFFFF}Lütfen evinizin kasasýndan almak istediðiniz uyuþturucu miktarýný girin:", "Al", "Kapat");
	    if (strval(inputtext) > HouseInfo[id][evUyusturucu])
	    {
	        HataMesajGonder(playerid, "Evinizin kasasýnda o kadar uyuþturucu yok.");
	        return Dialog_Show(playerid, EvUyusturucuAl, DIALOG_STYLE_INPUT, "Uyuþturucu Al", "{FFFFFF}Lütfen evinizin kasasýndan almak istediðiniz uyuþturucu miktarýný girin:", "Al", "Kapat");
	    }
	    HouseInfo[id][evUyusturucu] -= strval(inputtext);
	    PlayerDrugData[playerid][Drugs] += strval(inputtext);
	    MesajGonder(playerid, "Evinizin kasasýndan %d gram uyuþturucu aldýnýz.", strval(inputtext));
	    Ev_Kaydet(id);
	}
	return 1;
}
Dialog:UyusturucuAl(playerid, response, listitem, inputtext[])
{
	if (!response)
	{
	    if (GetFactionType(playerid) != BIRLIK_LSPD) Dialog_Show(playerid, BagajUyusturucular, DIALOG_STYLE_LIST, "{E74C3C}Bagaj: {FFFFFF}Uyuþturucular", "{FFFFFF}Uyuþturucu Koy\t{53f442}%d gram üzerinizde\n{FFFFFF}Uyuþturucu Al\t{ff0000}%d gram bagajda", "Seç", "Geri", PlayerDrugData[playerid][Drugs], AracInfo[GetPVarInt(playerid, "AracBagaj")][aracUyusturucu]);
    	else Dialog_Show(playerid, BagajUyusturucular, DIALOG_STYLE_LIST, "{E74C3C}Bagaj: {FFFFFF}Uyuþturucular", "{FFFFFF}Uyuþturucu Koy\t{53f442}%d gram üzerinizde\n{FFFFFF}Uyuþturucu Al\t{ff0000}%d gram bagajda\n{FFFFFF}Uyuþturuculara El Koy", "Seç", "Geri", PlayerDrugData[playerid][Drugs], AracInfo[GetPVarInt(playerid, "AracBagaj")][aracUyusturucu]);
	}
	else
	{
	    if (isnull(inputtext)) return Dialog_Show(playerid, UyusturucuAl, DIALOG_STYLE_INPUT, "{E74C3C}Bagaj: {FFFFFF}Uyuþturucu Al", "{E74C3C}» {FFFFFF}Lütfen aracýn bagajýndan almak istediðiniz uyuþturucu miktarýný girin:", "Al", "Geri");
	    if (!IsNumeric(inputtext)) return Dialog_Show(playerid, UyusturucuAl, DIALOG_STYLE_INPUT, "{E74C3C}Bagaj: {FFFFFF}Uyuþturucu Al", "{E74C3C}» {FFFFFF}Lütfen aracýn bagajýndan almak istediðiniz uyuþturucu miktarýný girin:", "Al", "Geri");
	    if (strval(inputtext) < 1)
	    {
	        HataMesajGonder(playerid, "Geçersiz miktar girdiniz.");
	        return Dialog_Show(playerid, UyusturucuAl, DIALOG_STYLE_INPUT, "{E74C3C}Bagaj: {FFFFFF}Uyuþturucu Al", "{E74C3C}» {FFFFFF}Lütfen aracýn bagajýndan almak istediðiniz uyuþturucu miktarýný girin:", "Al", "Geri");
	    }
	    if (AracInfo[GetPVarInt(playerid, "AracBagaj")][aracUyusturucu] < strval(inputtext))
	    {
	        HataMesajGonder(playerid, "Bagajda o kadar uyuþturucu yok.");
	        return Dialog_Show(playerid, UyusturucuAl, DIALOG_STYLE_INPUT, "{E74C3C}Bagaj: {FFFFFF}Uyuþturucu Al", "{E74C3C}» {FFFFFF}Lütfen aracýn bagajýndan almak istediðiniz uyuþturucu miktarýný girin:", "Al", "Geri");
	    }
	    if (PlayerDrugData[playerid][Drugs] + strval(inputtext) > CARRY_LIMIT)
	    {
	        HataMesajGonder(playerid, "Üzerinizde en fazla %d gram uyuþturucu taþýyabilirsiniz.", CARRY_LIMIT);
	        return Dialog_Show(playerid, UyusturucuAl, DIALOG_STYLE_INPUT, "{E74C3C}Bagaj: {FFFFFF}Uyuþturucu Al", "{E74C3C}» {FFFFFF}Lütfen aracýn bagajýndan almak istediðiniz uyuþturucu miktarýný girin:", "Al", "Geri");
	    }
	    AracInfo[GetPVarInt(playerid, "AracBagaj")][aracUyusturucu] -= strval(inputtext);
	    PlayerDrugData[playerid][Drugs] += strval(inputtext);
	    MesajGonder(playerid, "Bagajdan %d gram uyuþturucu aldýnýz.", strval(inputtext));
	    if (GetFactionType(playerid) != BIRLIK_LSPD) Dialog_Show(playerid, BagajUyusturucular, DIALOG_STYLE_LIST, "{E74C3C}Bagaj: {FFFFFF}Uyuþturucular", "{FFFFFF}Uyuþturucu Koy\t{53f442}%d gram üzerinizde\n{FFFFFF}Uyuþturucu Al\t{ff0000}%d gram bagajda", "Seç", "Geri", PlayerDrugData[playerid][Drugs], AracInfo[GetPVarInt(playerid, "AracBagaj")][aracUyusturucu]);
    	else Dialog_Show(playerid, BagajUyusturucular, DIALOG_STYLE_LIST, "{E74C3C}Bagaj: {FFFFFF}Uyuþturucular", "{FFFFFF}Uyuþturucu Koy\t{53f442}%d gram üzerinizde\n{FFFFFF}Uyuþturucu Al\t{ff0000}%d gram bagajda\n{FFFFFF}Uyuþturuculara El Koy", "Seç", "Geri", PlayerDrugData[playerid][Drugs], AracInfo[GetPVarInt(playerid, "AracBagaj")][aracUyusturucu]);
    	Arac_Kaydet(GetPVarInt(playerid, "AracBagaj"));
	}
	return 1;
}
Dialog:UyusturucuKoy(playerid, response, listitem, inputtext[])
{
	if (!response)
	{
	    if (GetFactionType(playerid) != BIRLIK_LSPD) Dialog_Show(playerid, BagajUyusturucular, DIALOG_STYLE_LIST, "{E74C3C}Bagaj: {FFFFFF}Uyuþturucular", "{FFFFFF}Uyuþturucu Koy\t{53f442}%d gram üzerinizde\n{FFFFFF}Uyuþturucu Al\t{ff0000}%d gram bagajda", "Seç", "Geri", PlayerDrugData[playerid][Drugs], AracInfo[GetPVarInt(playerid, "AracBagaj")][aracUyusturucu]);
    	else Dialog_Show(playerid, BagajUyusturucular, DIALOG_STYLE_LIST, "{E74C3C}Bagaj: {FFFFFF}Uyuþturucular", "{FFFFFF}Uyuþturucu Koy\t{53f442}%d gram üzerinizde\n{FFFFFF}Uyuþturucu Al\t{ff0000}%d gram bagajda\n{FFFFFF}Uyuþturuculara El Koy", "Seç", "Geri", PlayerDrugData[playerid][Drugs], AracInfo[GetPVarInt(playerid, "AracBagaj")][aracUyusturucu]);
	}
	else
	{
	    if (isnull(inputtext)) return Dialog_Show(playerid, UyusturucuKoy, DIALOG_STYLE_INPUT, "{E74C3C}Bagaj: {FFFFFF}Uyuþturucu Koy", "{E74C3C}» {FFFFFF}Lütfen araca koymak istediðiniz uyuþturucu miktarýný girin:", "Koy", "Geri");
	    if (!IsNumeric(inputtext)) return Dialog_Show(playerid, UyusturucuKoy, DIALOG_STYLE_INPUT, "{E74C3C}Bagaj: {FFFFFF}Uyuþturucu Koy", "{E74C3C}» {FFFFFF}Lütfen araca koymak istediðiniz uyuþturucu miktarýný girin:", "Koy", "Geri");
	    if (strval(inputtext) < 1 || strval(inputtext) > 300)
	    {
	        HataMesajGonder(playerid, "Geçersiz miktar girdiniz. (1-300 arasýnda olmalýdýr)");
	        return Dialog_Show(playerid, UyusturucuKoy, DIALOG_STYLE_INPUT, "{E74C3C}Bagaj: {FFFFFF}Uyuþturucu Koy", "{E74C3C}» {FFFFFF}Lütfen araca koymak istediðiniz uyuþturucu miktarýný girin:", "Koy", "Geri");
	    }
	    if (PlayerDrugData[playerid][Drugs] < strval(inputtext))
	    {
	        HataMesajGonder(playerid, "Üzerinizde o kadar uyuþturucu yok.");
	        return Dialog_Show(playerid, UyusturucuKoy, DIALOG_STYLE_INPUT, "{E74C3C}Bagaj: {FFFFFF}Uyuþturucu Koy", "{E74C3C}» {FFFFFF}Lütfen araca koymak istediðiniz uyuþturucu miktarýný girin:", "Koy", "Geri");
	    }
	    if (IsVehicleBike(AracInfo[GetPVarInt(playerid, "AracBagaj")][aracVehicle]) && AracInfo[GetPVarInt(playerid, "AracBagaj")][aracUyusturucu] + strval(inputtext) >= 50)
	    {
	        HataMesajGonder(playerid, "Motor tipi araçlara en fazla 50 gram uyuþturucu koyabilirsiniz.");
	        return Dialog_Show(playerid, UyusturucuKoy, DIALOG_STYLE_INPUT, "{E74C3C}Bagaj: {FFFFFF}Uyuþturucu Koy", "{E74C3C}» {FFFFFF}Lütfen araca koymak istediðiniz uyuþturucu miktarýný girin:", "Koy", "Geri");
	    }
	    if (AracInfo[GetPVarInt(playerid, "AracBagaj")][aracUyusturucu] + strval(inputtext) >= 100)
	    {
	        HataMesajGonder(playerid, "Aracýn bagajýnda maksimum 100 gram uyuþturucu olabilir.");
	        return Dialog_Show(playerid, UyusturucuKoy, DIALOG_STYLE_INPUT, "{E74C3C}Bagaj: {FFFFFF}Uyuþturucu Koy", "{E74C3C}» {FFFFFF}Lütfen araca koymak istediðiniz uyuþturucu miktarýný girin:", "Koy", "Geri");
		}
	    PlayerDrugData[playerid][Drugs] -= strval(inputtext);
	    AracInfo[GetPVarInt(playerid, "AracBagaj")][aracUyusturucu] += strval(inputtext);
	    MesajGonder(playerid, "%d gram uyuþturucuyu aracýn bagajýna koydunuz.", strval(inputtext));
	    if (GetFactionType(playerid) != BIRLIK_LSPD) Dialog_Show(playerid, BagajUyusturucular, DIALOG_STYLE_LIST, "{E74C3C}Bagaj: {FFFFFF}Uyuþturucular", "{FFFFFF}Uyuþturucu Koy\t{53f442}%d gram üzerinizde\n{FFFFFF}Uyuþturucu Al\t{ff0000}%d gram bagajda", "Seç", "Geri", PlayerDrugData[playerid][Drugs], AracInfo[GetPVarInt(playerid, "AracBagaj")][aracUyusturucu]);
    	else Dialog_Show(playerid, BagajUyusturucular, DIALOG_STYLE_LIST, "{E74C3C}Bagaj: {FFFFFF}Uyuþturucular", "{FFFFFF}Uyuþturucu Koy\t{53f442}%d gram üzerinizde\n{FFFFFF}Uyuþturucu Al\t{ff0000}%d gram bagajda\n{FFFFFF}Uyuþturuculara El Koy", "Seç", "Geri", PlayerDrugData[playerid][Drugs], AracInfo[GetPVarInt(playerid, "AracBagaj")][aracUyusturucu]);
    	Arac_Kaydet(GetPVarInt(playerid, "AracBagaj"));
	}
	return 1;
}
Dialog:Silahlarim(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (GetFactionType(playerid) == BIRLIK_LSPD || GetFactionType(playerid) == BIRLIK_LSMD || GetFactionType(playerid) == BIRLIK_FBI) return HataMesajGonder(playerid, "Bu bölüme eriþim izniniz yok. (LSPD ve LSMD üyeleri için engellendi.)");
		if (PlayerData[playerid][pLevel] < 5) return HataMesajGonder(playerid, "Bu bölüme eriþim izniniz yok. (En az 5 level olmalýsýnýz.)");

		new silahid = strval(inputtext);
	    if (silahid > 0)
	    {
	        SetPVarInt(playerid, "SilahID", silahid);
	        new str[50];
	        format(str, sizeof(str), "Silah: {ff8300}%s (ID: %d, Mermi: %d)", ReturnWeaponName(silahid), silahid, PlayerData[playerid][pMermiler][g_aWeaponSlots[silahid]]);
	        Dialog_Show(playerid, Silahlarim2, DIALOG_STYLE_LIST, str, "{FFFFFF}Þarjör Tak\n{FFFFFF}Silahý Baþkasýna Ver\n{FFFFFF}Silahý Sat", "Seç", "Geri");
	    }
	}
	return 1;
}
Dialog:Silahlarim2(playerid, response, listitem, inputtext[])
{
	if (!response) return OyuncuSilahlar(playerid);
	if (response)
	{
	    new sid = GetPVarInt(playerid, "SilahID");
	    switch (listitem)
	    {
	        case 0:
	        {
	            if (PlayerData[playerid][pMermiler][g_aWeaponSlots[sid]] > 0) return HataMesajGonder(playerid, "Sadece mermisi bitmiþ silahlara þarjör takabilirsiniz.");
	            if (PlayerData[playerid][pEsyalar][13] < 1) return HataMesajGonder(playerid, "Þarjörünüz yok.");
	            //if (PlayerData[playerid][pSilahlar][g_aWeaponSlots[sid]] != sid) return HataMesajGonder(playerid, "Bu silah türü sizde var.");
	            PlayerData[playerid][pEsyalar][13]--;
	            GiveWeaponToPlayer(playerid, sid, GetWeaponMagazineAmmo(sid));
	            switch (sid)
	            {
	                case 22:
	                {
	                    ApplyAnimation(playerid, "COLT45", "colt45_reload", 4.1, 0, 1, 1, 0, 2000, 1);
	                    ApplyAnimation(playerid, "COLT45", "colt45_reload", 4.1, 0, 1, 1, 0, 2000, 1);
	                }
	                case 24:
	                {
	                    ApplyAnimation(playerid, "SILENCED", "Silence_reload", 4.1, 0, 1, 1, 0, 2000, 1);
	                    ApplyAnimation(playerid, "SILENCED", "Silence_reload", 4.1, 0, 1, 1, 0, 2000, 1);
	                }
	                case 28:
	                {
	                    ApplyAnimation(playerid, "UZI", "UZI_reload", 4.1, 0, 1, 1, 0, 2000, 1);
	                    ApplyAnimation(playerid, "UZI", "UZI_reload", 4.1, 0, 1, 1, 0, 2000, 1);
	                }
	                case 29:
	                {
	                    ApplyAnimation(playerid, "TEC", "TEC_reload", 4.1, 0, 1, 1, 0, 2000, 1);
	                    ApplyAnimation(playerid, "TEC", "TEC_reload", 4.1, 0, 1, 1, 0, 2000, 1);
	                }
	                case 30, 31:
	                {
	                    ApplyAnimation(playerid, "BUDDY", "buddy_reload", 4.1, 0, 1, 1, 0, 2000, 1);
	                    ApplyAnimation(playerid, "BUDDY", "buddy_reload", 4.1, 0, 1, 1, 0, 2000, 1);
	                }
	            }
	        }
	        case 1:
	        {
	            if (IsPlayerInAnyVehicle(playerid)) return HataMesajGonder(playerid, "Araç içerisinde bunu yapamazsýnýz.");
	            Dialog_Show(playerid, SilahVer, DIALOG_STYLE_INPUT, "Oyuncu ID", "{ff1d00}» {FFFFFF}Lütfen silahý vermek istediðiniz kiþinin ID'sini girin:", "SVer", "Kapat");
	        }
	        case 2:
			{
			    if (IsPlayerInAnyVehicle(playerid)) return HataMesajGonder(playerid, "Araç içerisinde bunu yapamazsýnýz.");
			    Dialog_Show(playerid, SilahSat, DIALOG_STYLE_INPUT, "Oyuncu ID", "{ff1d00}» {FFFFFF}Lütfen silahý satmak istediðiniz kiþinin ID'sini girin:", "Sat", "Kapat");
			}
/*			case 3:
			{
			    if (IsPlayerInAnyVehicle(playerid)) return HataMesajGonder(playerid, "Araç içerisinde bunu yapamazsýnýz.");
			    new Float:pos[3];
			    GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
			    DropWeapon(PlayerData[playerid][pID], GetPVarInt(playerid, "SilahID"), PlayerData[playerid][pMermiler][g_aWeaponSlots[GetPVarInt(playerid, "SilahID")]], pos[0], pos[1], pos[2]-0.9, GetPlayerInterior(playerid), GetPlayerVirtualWorld(playerid));
			    ResetWeapon(playerid, GetPVarInt(playerid, "SilahID"));
			    SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "* %s adlý kiþi %s model silahýný yere atar.", ReturnName(playerid, 0), ReturnWeaponName(GetPVarInt(playerid, "SilahID")));
			}*/
	    }
	}
	return 1;
}
Dialog:BagajSilahlar(playerid, response, listitem, inputtext[])
{
	if (!response) return callcmd::bagaj(playerid);
	if (response)
	{
	    if (listitem == 5)
	    {
	        for (new i; i<5; i++)
	        {
	            AracInfo[GetPVarInt(playerid, "AracBagaj")][aracSilahlar][i] = 0;
	            AracInfo[GetPVarInt(playerid, "AracBagaj")][aracMermiler][i] = 0;
	        }
	        BilgiMesajGonder(playerid, "Araçta bulunan bütün silahlara el koydunuz.");
	        AracSilahlar(playerid, GetPVarInt(playerid, "AracBagaj"));
	        Arac_Kaydet(GetPVarInt(playerid, "AracBagaj"));
	        return 1;
		}
		if (GetFactionType(playerid) == BIRLIK_LSPD) return HataMesajGonder(playerid, "Polisler bunu yapamaz.");
		if (!Car_IsOwner(playerid, GetPVarInt(playerid, "AracBagaj"))) return HataMesajGonder(playerid, "Bu aracýn sahibi deðilsiniz.");
 		if (AracInfo[GetPVarInt(playerid, "AracBagaj")][aracSilahlar][listitem] < 1)
   		{
     		if (!GetWeapon(playerid))
       		{
         		HataMesajGonder(playerid, "Slot boþ, bu slota silah koymak için elinize silah almalýsýnýz.");
           		return AracSilahlar(playerid, GetPVarInt(playerid, "AracBagaj"));
         	}
          	new silahid = GetWeapon(playerid);
           	new ammo = GetPlayerAmmo(playerid);
            AracInfo[GetPVarInt(playerid, "AracBagaj")][aracSilahlar][listitem] = silahid;
            AracInfo[GetPVarInt(playerid, "AracBagaj")][aracMermiler][listitem] = ammo;
            ResetWeapon(playerid, silahid);
            SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "* %s adlý kiþi %s model silahýný aracýn bagajýna koyar.", ReturnName(playerid, 0), ReturnWeaponName(silahid));
            AracSilahlar(playerid, GetPVarInt(playerid, "AracBagaj"));
            Arac_Kaydet(GetPVarInt(playerid, "AracBagaj"));
		}
		else
		{
  			if (PlayerHasWeapon(playerid, AracInfo[GetPVarInt(playerid, "AracBagaj")][aracSilahlar][listitem]) || PlayerData[playerid][pSilahlar][g_aWeaponSlots[AracInfo[GetPVarInt(playerid, "AracBagaj")][aracSilahlar][listitem]]] > 0)
  			{
  			    HataMesajGonder(playerid, "Bu silaha sahipsiniz veya bu tür silahýnýz var.");
  			    return AracSilahlar(playerid, GetPVarInt(playerid, "AracBagaj"));
  			}
  			GiveWeaponToPlayer(playerid, AracInfo[GetPVarInt(playerid, "AracBagaj")][aracSilahlar][listitem], AracInfo[GetPVarInt(playerid, "AracBagaj")][aracMermiler][listitem]);
  			SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "* %s adlý kiþi %s model silahýný aracýn bagajýndan alýr.", ReturnName(playerid, 0), ReturnWeaponName(AracInfo[GetPVarInt(playerid, "AracBagaj")][aracSilahlar][listitem]));
  			AracInfo[GetPVarInt(playerid, "AracBagaj")][aracSilahlar][listitem] = 0;
  			AracInfo[GetPVarInt(playerid, "AracBagaj")][aracMermiler][listitem] = 0;
  			AracSilahlar(playerid, GetPVarInt(playerid, "AracBagaj"));
  			Arac_Kaydet(GetPVarInt(playerid, "AracBagaj"));
		}
	}
	return 1;
}
Dialog:EvSilahlar(playerid, response, listitem, inputtext[])
{
	if (!response) return callcmd::ev(playerid);
	if (response)
	{
	    new id = House_Inside(playerid);
	    if (id == -1) return 1;
 		if (HouseInfo[id][evSilahlar][listitem] < 1)
   		{
     		if (!GetWeapon(playerid))
       		{
         		HataMesajGonder(playerid, "Slot boþ, bu slota silah koymak için elinize silah almalýsýnýz.");
           		return EvSilahlar(playerid, id);
         	}
          	new silahid = GetWeapon(playerid);
           	new ammo = GetPlayerAmmo(playerid);
            HouseInfo[id][evSilahlar][listitem] = silahid;
            HouseInfo[id][evMermiler][listitem] = ammo;
            ResetWeapon(playerid, silahid);
            EvSilahlar(playerid, id);
            Ev_Kaydet(id);
		}
		else
		{
  			if (PlayerHasWeapon(playerid, HouseInfo[id][evSilahlar][listitem]) || PlayerData[playerid][pSilahlar][g_aWeaponSlots[HouseInfo[id][evSilahlar][listitem]]] > 0)
  			{
  			    HataMesajGonder(playerid, "Bu silaha sahipsiniz veya bu tür silahýnýz var.");
  			    return EvSilahlar(playerid, id);
  			}
  			GiveWeaponToPlayer(playerid, HouseInfo[id][evSilahlar][listitem], HouseInfo[id][evMermiler][listitem]);
  			HouseInfo[id][evSilahlar][listitem] = 0;
  			HouseInfo[id][evMermiler][listitem] = 0;
  			EvSilahlar(playerid, id);
  			Ev_Kaydet(id);
		}
	}
	return 1;
}
Dialog:SilahSat(playerid, response, listitem, inputtext[])
{
	if (response)
	{
     	if (isnull(inputtext)) return Dialog_Show(playerid, SilahSat, DIALOG_STYLE_INPUT, "Oyuncu ID", "{ff1d00}» {FFFFFF}Lütfen silahý satmak istediðiniz kiþinin ID'sini girin:", "Sat", "Kapat");
	    if (!IsNumeric(inputtext)) return Dialog_Show(playerid, SilahSat, DIALOG_STYLE_INPUT, "Oyuncu ID", "{ff1d00}» {FFFFFF}Lütfen silahý satmak istediðiniz kiþinin ID'sini girin:", "Sat", "Kapat");
	    new id = strval(inputtext);
	    new sid = GetPVarInt(playerid, "SilahID");
	    if (!OyundaDegil(id))
	    {
	        HataMesajGonder(playerid, "Oyuncu oyunda deðil.");
	        return Dialog_Show(playerid, SilahSat, DIALOG_STYLE_INPUT, "Oyuncu ID", "{ff1d00}» {FFFFFF}Lütfen silahý satmak istediðiniz kiþinin ID'sini girin:", "Sat", "Kapat");
	    }
	    if (!IsPlayerNearPlayer(playerid, id, 4.0))
	    {
	        HataMesajGonder(playerid, "Kiþiye yeterince yakýn deðilsiniz.");
	        return Dialog_Show(playerid, SilahSat, DIALOG_STYLE_INPUT, "Oyuncu ID", "{ff1d00}» {FFFFFF}Lütfen silahý satmak istediðiniz kiþinin ID'sini girin:", "Sat", "Kapat");
	    }
	    if (id == playerid)
	    {
	        HataMesajGonder(playerid, "Kendine silah satamazsýn.");
	        return Dialog_Show(playerid, SilahSat, DIALOG_STYLE_INPUT, "Oyuncu ID", "{ff1d00}» {FFFFFF}Lütfen silahý satmak istediðiniz kiþinin ID'sini girin:", "Sat", "Kapat");
	    }
	    if (PlayerData[id][pLevel] < 5)
			return HataMesajGonder(playerid, "Silah satma engellendi. (Karþý taraf en az 5 level olmalý.)");
	    if (PlayerData[id][pSilahOffer] != -1)
	    {
	        HataMesajGonder(playerid, "Bu oyuncuya zaten silah verme/satma isteði gönderilmiþ.");
	        return Dialog_Show(playerid, SilahSat, DIALOG_STYLE_INPUT, "Oyuncu ID", "{ff1d00}» {FFFFFF}Lütfen silahý satmak istediðiniz kiþinin ID'sini girin:", "Sat", "Kapat");
		}
	    if (PlayerHasWeapon(id, sid) || PlayerData[id][pSilahlar][g_aWeaponSlots[sid]] != 0)
	    {
	        HataMesajGonder(playerid, "Kiþi bu silaha sahip veya ayný tür silahý var.");
	        return Dialog_Show(playerid, SilahSat, DIALOG_STYLE_INPUT, "Oyuncu ID", "{ff1d00}» {FFFFFF}Lütfen silahý satmak istediðiniz kiþinin ID'sini girin:", "Sat", "Kapat");
	    }
	    SetPVarInt(playerid, "SilahSatID", id);
	    Dialog_Show(playerid, SilahSat2, DIALOG_STYLE_INPUT, "Fiyat", "{ff1d00}» {FFFFFF}Lütfen silahý satmak istediðiniz fiyatý girin:", "Sat", "Geri");
	}
	return 1;
}
Dialog:SilahSat2(playerid, response, listitem, inputtext[])
{
	if (!response) return Dialog_Show(playerid, SilahSat2, DIALOG_STYLE_INPUT, "Fiyat", "{ff1d00}» {FFFFFF}Lütfen silahý satmak istediðiniz fiyatý girin:", "Sat", "Geri");
	if (response)
	{
	    new id = GetPVarInt(playerid, "SilahSatID");
	    if (!OyundaDegil(id))
	    {
	        HataMesajGonder(playerid, "Oyuncu oyundan çýktý.");
	        return 1;
	        //return Dialog_Show(playerid, SilahSat, DIALOG_STYLE_INPUT, "Oyuncu ID", "{ff1d00}» {FFFFFF}Lütfen silahý satmak istediðiniz kiþinin ID'sini girin:", "Sat", "Kapat");
	    }
	    if (!IsPlayerNearPlayer(playerid, id, 4.0))
	    {
	        HataMesajGonder(playerid, "Kiþi sizden uzaklaþtý.");
	        return 1;
	        //return Dialog_Show(playerid, SilahSat, DIALOG_STYLE_INPUT, "Oyuncu ID", "{ff1d00}» {FFFFFF}Lütfen silahý satmak istediðiniz kiþinin ID'sini girin:", "Sat", "Kapat");
	    }
	    if (PlayerData[id][pSilahOffer] != -1)
	    {
	        HataMesajGonder(playerid, "Bu oyuncuya baþkasý tarafýndan silah verme/satma isteði gönderildi.");
	        return 1;
	        //return Dialog_Show(playerid, SilahSat, DIALOG_STYLE_INPUT, "Oyuncu ID", "{ff1d00}» {FFFFFF}Lütfen silahý satmak istediðiniz kiþinin ID'sini girin:", "Sat", "Kapat");
		}
	    if (PlayerHasWeapon(id, GetPVarInt(playerid, "SilahID")) || PlayerData[id][pSilahlar][g_aWeaponSlots[GetPVarInt(playerid, "SilahID")]] != 0)
	    {
	        HataMesajGonder(playerid, "Kiþi bu silaha sahip veya ayný tür silahý var.");
	        return 1;
	        //return Dialog_Show(playerid, SilahSat, DIALOG_STYLE_INPUT, "Oyuncu ID", "{ff1d00}» {FFFFFF}Lütfen silahý satmak istediðiniz kiþinin ID'sini girin:", "Sat", "Kapat");
	    }
	    if (isnull(inputtext)) return Dialog_Show(playerid, SilahSat2, DIALOG_STYLE_INPUT, "Fiyat", "{ff1d00}» {FFFFFF}Lütfen silahý satmak istediðiniz fiyatý girin:", "Sat", "Geri");
	    if (!IsNumeric(inputtext)) return Dialog_Show(playerid, SilahSat2, DIALOG_STYLE_INPUT, "Fiyat", "{ff1d00}» {FFFFFF}Lütfen silahý satmak istediðiniz fiyatý girin:", "Sat", "Geri");
	    if (strval(inputtext) <= 0 || strval(inputtext) >= 250000)
	    {
	        HataMesajGonder(playerid, "Geçersiz fiyat girdiniz. ($1-250000 arasý deðer girilmelidir.)");
	        return Dialog_Show(playerid, SilahSat2, DIALOG_STYLE_INPUT, "Fiyat", "{ff1d00}» {FFFFFF}Lütfen silahý satmak istediðiniz fiyatý girin:", "Sat", "Geri");
	    }
	    if(strval(inputtext) > PlayerData[playerid][pCash])
	    {
	    	HataMesajGonder(playerid, "Kiþinin üzerinde bu kadar para yok!");
	    	return Dialog_Show(playerid, SilahSat2, DIALOG_STYLE_INPUT, "Fiyat", "{ff1d00}» {FFFFFF}Lütfen silahý satmak istediðiniz fiyatý girin:", "Sat", "Geri");
	    }

	    PlayerData[id][pSilahOffer] = playerid;
	    PlayerData[id][pSilahOfferID] = GetPVarInt(playerid, "SilahID");
	    PlayerData[id][pSilahOfferFiyat] = strval(inputtext);
	    Dialog_Show(id, SilahSatmaIstek, DIALOG_STYLE_MSGBOX, "Silah Satma Ýsteði", "{AFAFAF}%s adlý kiþi sana {ff005d}%s (Mermi: %d) {FFFFFF}silahýný {04ff00}%s {FFFFFF}fiyatýna satmak istiyor. Kabul ediyor musun?", "Evet", "Hayýr", ReturnName(playerid, 0), ReturnWeaponName(GetPVarInt(playerid, "SilahID")), PlayerData[playerid][pMermiler][g_aWeaponSlots[GetPVarInt(playerid, "SilahID")]], FormatNumber(strval(inputtext)));

	}
	return 1;
}
Dialog:SilahSatmaIstek(playerid, response, listitem, inputtext[])
{
    new id = PlayerData[playerid][pSilahOffer];
	new sid = PlayerData[playerid][pSilahOfferID];
	new fiyat = PlayerData[playerid][pSilahOfferFiyat];
	if (id == -1) return 1;
	if (!response)
	{
	    BilgiMesajGonder(id, "Silah satma isteðiniz reddedildi.");
	    PlayerData[playerid][pSilahOffer] = -1;
	    PlayerData[playerid][pSilahOfferID] = 0;
		PlayerData[playerid][pSilahOfferFiyat] = 0;
	}
	else
	{
	    if (!OyundaDegil(id) || !IsPlayerNearPlayer(playerid, id, 5.0))
	    {
	        PlayerData[playerid][pSilahOffer] = -1;
	        PlayerData[playerid][pSilahOfferID] = 0;
	        PlayerData[playerid][pSilahOfferFiyat] = 0;
	        return HataMesajGonder(playerid, "Oyuncu oyunda deðil veya sizden uzaklaþtý.");
	    }
	    if (!PlayerHasWeapon(id, sid))
	    {
	        PlayerData[playerid][pSilahOffer] = -1;
	        PlayerData[playerid][pSilahOfferID] = -1;
	        PlayerData[playerid][pSilahOfferFiyat] = 0;
	        return HataMesajGonder(playerid, "Oyuncu artýk bu silaha sahip deðil.");
	    }
	    if (PlayerData[playerid][pCash] < fiyat)
	    {
	    	PlayerData[playerid][pSilahOffer] = -1;
	    	PlayerData[playerid][pSilahOfferID] = 0;
   		    PlayerData[playerid][pSilahOfferFiyat] = 0;
		    return HataMesajGonder(playerid, "Bu silahý almak için yeterli paranýz yok!");
		}
		ParaVer(playerid, -fiyat);
	    ParaVer(id, fiyat);
	    GiveWeaponToPlayer(playerid, sid, PlayerData[id][pMermiler][g_aWeaponSlots[sid]]);
	    if (PlayerData[id][pMermiler][g_aWeaponSlots[sid]] > 0) ResetWeapon(id, sid);
	    else PlayerData[id][pSilahlar][g_aWeaponSlots[sid]] = 0;
	    MesajGonder(id, "%s model silahýnýzý %s adlý kiþiye %s fiyatýna sattýnýz.", ReturnWeaponName(sid), ReturnName(playerid, 0), FormatNumber(fiyat));
	    MesajGonder(playerid, "%s adlý kiþi size %s model silahýný %s fiyatýna sattý. (silahýn mermisi yoksa envantere eklenir)", ReturnName(id, 0),ReturnWeaponName(sid), FormatNumber(fiyat));
	    SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "* %s adlý kiþi %s adlý kiþiye %s model silahýný %s fiyatýna satar.", ReturnName(id, 0), ReturnName(playerid, 0), ReturnWeaponName(sid), FormatNumber(fiyat));
	    PlayerData[playerid][pSilahOffer] = -1;
	    PlayerData[playerid][pSilahOfferID] = 0;
	    PlayerData[playerid][pSilahOfferFiyat] = 0;
	}
	return 1;
}
Dialog:SilahVer(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (isnull(inputtext)) return Dialog_Show(playerid, SilahVer, DIALOG_STYLE_INPUT, "Oyuncu ID", "{ff1d00}» {FFFFFF}Lütfen silahý vermek istediðiniz kiþinin ID'sini girin:", "Ver", "Kapat");
	    if (!IsNumeric(inputtext)) return Dialog_Show(playerid, SilahVer, DIALOG_STYLE_INPUT, "Oyuncu ID", "{ff1d00}» {FFFFFF}Lütfen silahý vermek istediðiniz kiþinin ID'sini girin:", "Ver", "Kapat");
	    new id = strval(inputtext);
	    new sid = GetPVarInt(playerid, "SilahID");
	    if (!OyundaDegil(id))
	    {
	        HataMesajGonder(playerid, "Oyuncu oyunda deðil.");
	        return Dialog_Show(playerid, SilahVer, DIALOG_STYLE_INPUT, "Oyuncu ID", "{ff1d00}» {FFFFFF}Lütfen silahý vermek istediðiniz kiþinin ID'sini girin:", "Ver", "Kapat");
	    }
	    if (!IsPlayerNearPlayer(playerid, id, 4.0))
	    {
	        HataMesajGonder(playerid, "Kiþiye yeterince yakýn deðilsiniz.");
	        return Dialog_Show(playerid, SilahVer, DIALOG_STYLE_INPUT, "Oyuncu ID", "{ff1d00}» {FFFFFF}Lütfen silahý vermek istediðiniz kiþinin ID'sini girin:", "Ver", "Kapat");
	    }
	    if (id == playerid)
	    {
	        HataMesajGonder(playerid, "Kendine silah veremezsin.");
	        return Dialog_Show(playerid, SilahVer, DIALOG_STYLE_INPUT, "Oyuncu ID", "{ff1d00}» {FFFFFF}Lütfen silahý vermek istediðiniz kiþinin ID'sini girin:", "Ver", "Kapat");
	    }
	    if (PlayerData[id][pSilahOffer] != -1)
	    {
	        HataMesajGonder(playerid, "Bu oyuncuya zaten silah verme isteði gönderilmiþ.");
	        return Dialog_Show(playerid, SilahVer, DIALOG_STYLE_INPUT, "Oyuncu ID", "{ff1d00}» {FFFFFF}Lütfen silahý vermek istediðiniz kiþinin ID'sini girin:", "Ver", "Kapat");
		}
	    if (PlayerHasWeapon(id, sid) || PlayerData[id][pSilahlar][g_aWeaponSlots[sid]] != 0)
	    {
	        HataMesajGonder(playerid, "Kiþi bu silaha sahip veya ayný tür silahý var.");
	        return Dialog_Show(playerid, SilahVer, DIALOG_STYLE_INPUT, "Oyuncu ID", "{ff1d00}» {FFFFFF}Lütfen silahý vermek istediðiniz kiþinin ID'sini girin:", "Ver", "Kapat");
	    }
	    PlayerData[id][pSilahOffer] = playerid;
	    PlayerData[id][pSilahOfferID] = sid;
	    Dialog_Show(id, SilahIstek, DIALOG_STYLE_MSGBOX, "Silah Verme Ýsteði", "{AFAFAF}%s adlý kiþi sana {ff005d}%s (Mermi: %d) {FFFFFF}silahýný vermek istiyor. Kabul ediyor musun?", "Evet", "Hayýr", ReturnName(playerid, 0), ReturnWeaponName(sid), PlayerData[playerid][pMermiler][g_aWeaponSlots[GetPVarInt(playerid, "SilahID")]]);
	    MesajGonder(playerid, "Silah verme isteði gönderildi, kiþinin yanýtýný bekleyin.");
	}
	return 1;
}
Dialog:SilahIstek(playerid, response, listitem, inputtext[])
{
	new id = PlayerData[playerid][pSilahOffer];
	new sid = PlayerData[playerid][pSilahOfferID];
	if (id == -1) return 1;
	if (!response)
	{
	    BilgiMesajGonder(id, "Silah verme isteðiniz reddedildi.");
	    PlayerData[playerid][pSilahOffer] = -1;
	    PlayerData[playerid][pSilahOfferID] = 0;
	}
	else
	{
	    if (!OyundaDegil(id) || !IsPlayerNearPlayer(playerid, id, 5.0))
	    {
	        PlayerData[playerid][pSilahOffer] = -1;
	        PlayerData[playerid][pSilahOfferID] = 0;
	        return HataMesajGonder(playerid, "Oyuncu oyunda deðil veya sizden uzaklaþtý.");
	    }
	    if (!PlayerHasWeapon(id, sid))
	    {
	        PlayerData[playerid][pSilahOffer] = -1;
	        PlayerData[playerid][pSilahOfferID] = 0;
	        return HataMesajGonder(playerid, "Oyuncu artýk bu silaha sahip deðil.");
	    }
	    GiveWeaponToPlayer(playerid, sid, PlayerData[id][pMermiler][g_aWeaponSlots[sid]]);
	    if (PlayerData[id][pMermiler][g_aWeaponSlots[sid]] > 0) ResetWeapon(id, sid);
	    else PlayerData[id][pSilahlar][g_aWeaponSlots[sid]] = 0;
	    MesajGonder(id, "%s model silahýnýzý %s adlý kiþiye verdiniz.", ReturnWeaponName(sid), ReturnName(playerid, 0));
	    MesajGonder(playerid, "%s adlý kiþi size %s model silahýný verdi. (silahýn mermisi yoksa envantere eklenir)", ReturnName(id, 0),ReturnWeaponName(sid));
	    SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "* %s adlý kiþi %s adlý kiþiye %s model silahýný verir.", ReturnName(id, 0), ReturnName(playerid, 0), ReturnWeaponName(sid));
	    PlayerData[playerid][pSilahOffer] = -1;
	    PlayerData[playerid][pSilahOfferID] = 0;
	}
	return 1;
}
Dialog:Reklamlar(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    new id = strval(inputtext);
	    if (Reklamlar[id][reklamExists])
	    {
	        SetPVarInt(playerid, "reklamID", id);
	        Dialog_Show(playerid, ReklamSonuclandir, DIALOG_STYLE_LIST, "{FFFFFF}Reklam", "{{2ECC71}Onayla\n{E74C3C}Reddet", "Seç", "Geri");
	    }
	}
	return 1;
}
Dialog:ReklamSonuclandir(playerid, response, listitem, inputtext[])
{
	if (!response) return callcmd::rek(playerid);
	if (response)
	{
	    new id = GetPVarInt(playerid, "reklamID");
	    if (Reklamlar[id][reklamExists])
	    {
	        new oyuncuid = GetPlayerIDWithSQLID(Reklamlar[id][reklamGonderen]);
	        if (listitem == 0)
	        {

	            if (oyuncuid != -1)
	            {
	                ParaVer(oyuncuid, -Reklamlar[id][reklamUcret]);
	                MesajGonder(oyuncuid, "Reklamýnýz onaylandý ve yayýnlandý.");
	            }
	            else
	            {
	                OfflineParaVer(Reklamlar[id][reklamGonderen], -Reklamlar[id][reklamUcret]);
	                BildirimEkle(Reklamlar[id][reklamGonderen], "Reklamýnýz onaylandý ve yayýnlandý.", "Sistem");
	            }
	            if (strlen(Reklamlar[id][reklamIcerik]) > 64)
			    {
                    foreach (new i : Player) if (PlayerData[i][pAyarlar][2] == 0)
                    {
                        SendClientMessageEx(i, 0xFF00FF00, "{00FF00}[%s]: {00FF00}%.64s", Birlikler[Reklamlar[id][ajansID]][birlikAd], Reklamlar[id][reklamIcerik]);
                        SendClientMessageEx(i, 0xFF00FF00, "{00FF00}...%s {00FF00}(Ýletiþim: %d)", Reklamlar[id][reklamIcerik][64], (Reklamlar[id][reklamIletisim] == -1) ? (0) : (Reklamlar[id][reklamIletisim]));
                    }
			    }
			    else
			    {
			        foreach (new i : Player) if (PlayerData[i][pAyarlar][2] == 0)
			        {
			            SendClientMessageEx(i, 0xFF00FF00, "{00FF00}[%s]: {00FF00}%s {00FF00}(Ýletiþim: %d)", Birlikler[Reklamlar[id][ajansID]][birlikAd], Reklamlar[id][reklamIcerik], (Reklamlar[id][reklamIletisim] == -1) ? (0) : (Reklamlar[id][reklamIletisim]));
			        }
			    }

			    new DCC_Embed:ixd = DCC_CreateEmbed();

			    DCC_SetEmbedColor(ixd, 3066993);
			    DCC_SetEmbedDescription(ixd, trcar(Birlikler[Reklamlar[id][ajansID]][birlikAd]));

			    new iletisim[32];

			    format(iletisim, sizeof(iletisim), "Iletisim: %d", Reklamlar[id][reklamIletisim]);

			    DCC_AddEmbedField(ixd, trcar(Reklamlar[id][reklamIcerik]), trcar(iletisim));

			    DCC_SendChannelEmbedMessage(DCC_FindChannelByName(REKLAM_KANALI), ixd);

			    Birlikler[Reklamlar[id][ajansID]][ReklamSayisi]++;
			    Birlikler[Reklamlar[id][ajansID]][birlikKasaPara] += Reklamlar[id][reklamUcret];
			    Reklamlar[id][reklamExists] = 0;
			    format(Reklamlar[id][reklamIcerik], 128, "");
			    Reklamlar[id][reklamIletisim] = -1;
			    Reklamlar[id][ajansID] = -1;
			    Reklamlar[id][reklamGonderen] = -1;

			    MesajGonder(playerid, "Reklam onaylanmýþtýr.");
			    AdminHelperMessage(COLOR_LIGHTRED, "ADM: %s, bir adet reklam onayladý.", PlayerData[playerid][pAdminName]);
			    callcmd::rek(playerid);
	        }
	        if (listitem == 1)
	        {
	            if (oyuncuid != -1) BilgiMesajGonder(playerid, "Reklamýnýz onaylanmadý.");
	            else BildirimEkle(Reklamlar[id][reklamGonderen], "Reklamýnýz onaylanmadý.", "Sistem");
	            AdminHelperMessage(COLOR_LIGHTRED, "ADM: %s, bir adet reklam reddetti.", PlayerData[playerid][pAdminName]);
	            Reklamlar[id][reklamExists] = 0;
			    format(Reklamlar[id][reklamIcerik], 128, "");
			    Reklamlar[id][reklamIletisim] = -1;
			    Reklamlar[id][ajansID] = -1;
			    Reklamlar[id][reklamGonderen] = -1;
			    MesajGonder(playerid, "Reklam reddedildi.");
			    callcmd::rek(playerid);
	        }
	    }
	}
	return 1;
}
Dialog:Dinle(playerid, response, listitem, inputtext[])
{
	if (response)
	{
        if (strfind(inputtext, "Ileri", true) != -1)
        {
            SetPVarInt(playerid, "AjansPage", GetPVarInt(playerid, "AjansPage")+1);
            AjansListele(playerid);
            return 1;
        }
        if (strfind(inputtext, "Geri", true) != -1)
        {
            if (GetPVarInt(playerid, "AjansPage") < 1)
            {
                AjansListele(playerid);
                HataMesajGonder(playerid, "Zaten ilk sayfadasýnýz!");
            }
            else
            {
                SetPVarInt(playerid, "AjansPage", GetPVarInt(playerid, "AjansPage")-1);
                AjansListele(playerid);
            }
            return 1;
        }
        new id = AjansListeleme[playerid][listitem];
        if (Birlikler[id][birlikExists] && Birlikler[id][birlikTip] == BIRLIK_HABER)
        {
        	if(GetPVarInt(playerid, "pAjansReklam") == 1)
        	{
				if(PlayerData[playerid][pCash] < Birlikler[id][ReklamUcreti])
				{
					DeletePVar(playerid, "pAjansReklam"), DeletePVar(playerid, "pAjansReklamID");
					return HataMesaji(playerid, "Reklam ücreti $%d karþýlayamýyorsunuz.", Birlikler[id][ReklamUcreti]);
				}

        		SetPVarInt(playerid, "pAjansReklamID", id);
        		Dialog_Show(playerid, AjansReklamVer, DIALOG_STYLE_INPUT, "Reklam Ver", "%s ajansýnda $%d karþýlýðýnda reklam verebilirsiniz. Reklam metnini giriniz.", "Gönder", "Kapat", Birlikler[id][birlikAd], Birlikler[id][ReklamUcreti]);
        	}

        	else
        	{
            	PlayerData[playerid][pDinle] = id;
            	MesajGonder(playerid, "Artýk %s adlý ajansýn yayýnýný dinliyorsunuz.", Birlikler[id][birlikAd]);
            	Birlik_Kaydet(id);
        	}
        }
	}
	return 1;
}

Dialog:AjansReklamVer(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new id = GetPVarInt(playerid, "pAjansReklamID");

		if(Birlikler[id][ReklamAlimi] < 1)
		{
			DeletePVar(playerid, "pAjansReklam"), DeletePVar(playerid, "pAjansReklamID");
			return HataMesaji(playerid, "Bu ajans reklam almýyor.");
		}

		if(Birlikler[id][ReklamUcreti] < 1)
		{
			DeletePVar(playerid, "pAjansReklam"), DeletePVar(playerid, "pAjansReklamID");
			return HataMesaji(playerid, "Bu ajansýn reklam fiyatý ayarlanmamýþ.");
		}

		if(PlayerData[playerid][pCash] < Birlikler[id][ReklamUcreti])
		{
			DeletePVar(playerid, "pAjansReklam"), DeletePVar(playerid, "pAjansReklamID");
			return HataMesaji(playerid, "Reklam ücreti $%d karþýlayamýyorsunuz.", Birlikler[id][ReklamUcreti]);
		}

		new metin[125];

		if(sscanf(inputtext, "s[125]", metin))
			return Dialog_Show(playerid, AjansReklamVer, DIALOG_STYLE_INPUT, "Reklam Ver", "%s ajansýnda $%d karþýlýðýnda reklam verebilirsiniz. Reklam metnini giriniz.", "Gönder", "Kapat", Birlikler[id][birlikAd], Birlikler[id][ReklamUcreti]);

		if(strlen(metin) < 5 || strlen(metin) > 125)
			return Dialog_Show(playerid, AjansReklamVer, DIALOG_STYLE_INPUT, "Reklam Ver", "%s ajansýnda $%d karþýlýðýnda reklam verebilirsiniz. Reklam metnini giriniz.", "Gönder", "Kapat", Birlikler[id][birlikAd], Birlikler[id][ReklamUcreti]);

		new reklamid = Reklam_Olustur(playerid, metin);

		if(reklamid == -1)
			return HataMesajGonder(playerid, "Reklam gönderilemedi. Lütfen daha sonra tekrar deneyin.");

		MesajGonder(playerid, "Reklamýnýz iþleme alýndý, yetkililerin onaylamasýný bekleyiniz.");
		AdminHelperMessage(COLOR_LIGHTRED, "Yeni bekleyen reklamlar var. (/rek)");

		DeletePVar(playerid, "pAjansReklam"), DeletePVar(playerid, "pAjansReklamID");
	}

	else
	{
		DeletePVar(playerid, "pAjansReklam"), DeletePVar(playerid, "pAjansReklamID");
	}

	return 1;
}
Dialog:askin(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    switch (listitem)
	    {
	        case 0:
	        {
	            if (PlayerData[playerid][pCinsiyet] == 1) SetPlayerSkin(playerid, 20012);
	            else SetPlayerSkin(playerid, 20012);
	        }
	        case 1:
	        {
	            if (PlayerData[playerid][pCinsiyet] == 1) SetPlayerSkin(playerid, 20013);
	            else SetPlayerSkin(playerid, 20013);
	        }
	        case 2:
	        {
	            if (PlayerData[playerid][pCinsiyet] == 1) SetPlayerSkin(playerid, 20014);
	            else SetPlayerSkin(playerid, 20014);
	        }
			case 3:
			{
			    if (PlayerData[playerid][pCinsiyet] == 1) SetPlayerSkin(playerid, 154);
	            else SetPlayerSkin(playerid, 20015);
			}
			case 4:
			{
			    if (PlayerData[playerid][pCinsiyet] == 1) SetPlayerSkin(playerid, 20016);
	            else SetPlayerSkin(playerid, 20016);
			}
			case 5:
			{
			    if (PlayerData[playerid][pCinsiyet] == 1) SetPlayerSkin(playerid, 20017);
	            else SetPlayerSkin(playerid, 20017);
			}
			case 6:
			{
			    if (PlayerData[playerid][pCinsiyet] == 1) SetPlayerSkin(playerid, 20018);
	            else SetPlayerSkin(playerid, 20018);
			}
			case 7:
			{
			    if (PlayerData[playerid][pCinsiyet] == 1) SetPlayerSkin(playerid, 20019);
	            else SetPlayerSkin(playerid, 20019);
			}
			case 8:
			{
			    if (PlayerData[playerid][pCinsiyet] == 1) SetPlayerSkin(playerid, 20020);
	            else SetPlayerSkin(playerid, 20020);
			}
			case 9:
			{
			    if (PlayerData[playerid][pCinsiyet] == 1) SetPlayerSkin(playerid, 20021);
	            else SetPlayerSkin(playerid, 20021);
			}
			case 10:
			{
			    if (PlayerData[playerid][pCinsiyet] == 1) SetPlayerSkin(playerid, 20022);
	            else SetPlayerSkin(playerid, 20022);
			}
			case 11:
			{
			    if (PlayerData[playerid][pCinsiyet] == 1) SetPlayerSkin(playerid, 20023);
	            else SetPlayerSkin(playerid, 20023);
			}
			case 12:
			{
			    if (PlayerData[playerid][pCinsiyet] == 1) SetPlayerSkin(playerid, 20024);
	            else SetPlayerSkin(playerid, 20024);
			}
			case 13:
			{
			    if (PlayerData[playerid][pCinsiyet] == 1) SetPlayerSkin(playerid, 20025);
	            else SetPlayerSkin(playerid, 20025);
			}
			case 14:
			{
			    if (PlayerData[playerid][pCinsiyet] == 1) SetPlayerSkin(playerid, 20026);
	            else SetPlayerSkin(playerid, 20026);
			}
			case 15:
			{
			    if (PlayerData[playerid][pCinsiyet] == 1) SetPlayerSkin(playerid, 20027);
	            else SetPlayerSkin(playerid, 20027);
			}
	    }
	    PlayerData[playerid][pAsoyun] = true;
	}
	return 1;
}
Dialog:hskin(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    switch (listitem)
	    {
	        case 0:
	        {
	            if (PlayerData[playerid][pCinsiyet] == 1) SetPlayerSkin(playerid, 20014);
	            else SetPlayerSkin(playerid, 20014);
	        }
	        case 1:
	        {
	            if (PlayerData[playerid][pCinsiyet] == 1) SetPlayerSkin(playerid, 20012);
	            else SetPlayerSkin(playerid, 20012);
	        }
	        case 2:
	        {
	            if (PlayerData[playerid][pCinsiyet] == 1) SetPlayerSkin(playerid, 20024);
	            else SetPlayerSkin(playerid, 20024);
	        }
			case 3:
			{
			    if (PlayerData[playerid][pCinsiyet] == 1) SetPlayerSkin(playerid, 20020);
	            else SetPlayerSkin(playerid, 20020);
			}
			case 4:
			{
			    if (PlayerData[playerid][pCinsiyet] == 1) SetPlayerSkin(playerid, 20023);
	            else SetPlayerSkin(playerid, 20023);
			}
			case 5:
			{
			    if (PlayerData[playerid][pCinsiyet] == 1) SetPlayerSkin(playerid, 20022);
	            else SetPlayerSkin(playerid, 20022);
			}
			case 6:
			{
			    if (PlayerData[playerid][pCinsiyet] == 1) SetPlayerSkin(playerid, 20021);
	            else SetPlayerSkin(playerid, 20018);
			}
			case 7:
			{
			    if (PlayerData[playerid][pCinsiyet] == 1) SetPlayerSkin(playerid, 20027);
	            else SetPlayerSkin(playerid, 20019);
			}
			case 8:
			{
			    if (PlayerData[playerid][pCinsiyet] == 1) SetPlayerSkin(playerid, 20026);
	            else SetPlayerSkin(playerid, 20020);
			}
			case 9:
			{
			    if (PlayerData[playerid][pCinsiyet] == 1) SetPlayerSkin(playerid, 20025);
	            else SetPlayerSkin(playerid, 20021);
			}
	    }
	    PlayerData[playerid][pAsoyun] = true;
	}
	return 1;
}
Dialog:Kumarhane(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (listitem == 0)
	    {
	    	if (PlayerData[playerid][pCash] < 100) return HataMesajGonder(playerid, "Yeterli paranýz bulunmuyor!");
	    	Dialog_Show(playerid, TekCiftBahis, DIALOG_STYLE_INPUT, "{808080}Kumarhane - {808080}Tek/Çift", "{808080}» {FFFFFF}Lütfen oynamak istediðiniz bahis miktarýný girin ($100 ile $1500 arasýnda olmalýdýr)", "Devam", "Geri");
	    }
	    if (listitem == 1)
	    {
	        if (PlayerData[playerid][pCash] < 100) return HataMesajGonder(playerid, "Yeterli paranýz bulunmuyor!");
	        Dialog_Show(playerid, SupremeNumber, DIALOG_STYLE_INPUT, "{808080}Kumarhane - {808080}Supreme Number", "{808080}» {FFFFFF}Lütfen oynamak istediðiniz bahis miktarýný girin ($100 ile $1500 arasýnda olmalýdýr)", "Devam", "Geri");
	    }
	    if (listitem == 2)
	    {
	        if (PlayerData[playerid][pCash] < 100) return HataMesajGonder(playerid, "Yeterli paranýz bulunmuyor!");
					if (!PlayerData[playerid][pEsyalar][0]) return HataMesajGonder(playerid, "Üzerinizde zar bulunmuyor, marketten zar alabilirsiniz.");
					Dialog_Show(playerid, ZarDuellosu, DIALOG_STYLE_INPUT, "{808080}Kumarhane - {808080}Zar Düellosu", "Lütfen oynamak istediðiniz bahis miktarýný girin:\n\n{808080}Uyarý: {FFFFFF}En az $100, en fazla $50,000 bahis oynayabilirsiniz.", "Devam", "Kapat");
	    }
	}
	return 1;
}
Dialog:ZarDuellosu(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (isnull(inputtext)) return Dialog_Show(playerid, ZarDuellosu, DIALOG_STYLE_INPUT, "{808080}Kumarhane - {808080}Zar Düellosu", "Lütfen oynamak istediðiniz bahis miktarýný girin:\n\n{808080}Uyarý: {FFFFFF}En az $100, en fazla $50,000 bahis oynayabilirsiniz.", "Devam", "Kapat");
	    if (!IsNumeric(inputtext)) return Dialog_Show(playerid, ZarDuellosu, DIALOG_STYLE_INPUT, "{808080}Kumarhane - {808080}Zar Düellosu", "Lütfen oynamak istediðiniz bahis miktarýný girin:\n\n{808080}Uyarý: {FFFFFF}En az $100, en fazla $50,000 bahis oynayabilirsiniz.", "Devam", "Kapat");
	    if (strval(inputtext) < 100 || strval(inputtext) > 50000) return Dialog_Show(playerid, ZarDuellosu, DIALOG_STYLE_INPUT, "{808080}Kumarhane - {808080}Zar Düellosu", "Lütfen oynamak istediðiniz bahis miktarýný girin:\n\n{808080}Uyarý: {FFFFFF}En az $100, en fazla $10,000 bahis oynayabilirsiniz.", "Devam", "Kapat");
	    if (strval(inputtext) > PlayerData[playerid][pCash])
	    {
	        HataMesajGonder(playerid, "O kadar paranýz yok.");
	        return Dialog_Show(playerid, ZarDuellosu, DIALOG_STYLE_INPUT, "{808080}Kumarhane - {808080}Zar Düellosu", "Lütfen oynamak istediðiniz bahis miktarýný girin:\n\n{808080}Uyarý: {FFFFFF}En az $100, en fazla $50,000 bahis oynayabilirsiniz.", "Devam", "Kapat");
	    }
	    SetPVarInt(playerid, "kumar_para", strval(inputtext));
	    Dialog_Show(playerid, ZarDuellosu2, DIALOG_STYLE_INPUT, "{808080}Kumarhane - {808080}Zar Düellosu", "Lütfen düello yapmak istediðiniz kiþinin ID'sini girin:", "Devam", "Geri");
	}
	return 1;
}
Dialog:ZarDuellosu2(playerid, response, listitem, inputtext[])
{
	if (!response) return Dialog_Show(playerid, ZarDuellosu, DIALOG_STYLE_INPUT, "{808080}Kumarhane - {808080}Zar Düellosu", "Lütfen oynamak istediðiniz bahis miktarýný girin:\n\n{808080}Uyarý: {FFFFFF}En az $100, en fazla $10,000 bahis oynayabilirsiniz.", "Devam", "Kapat");
	if (response)
	{
	    if (isnull(inputtext) || !IsNumeric(inputtext)) return Dialog_Show(playerid, ZarDuellosu2, DIALOG_STYLE_INPUT, "{808080}Kumarhane - {808080}Zar Düellosu", "Lütfen düello yapmak istediðiniz kiþinin ID'sini girin:", "Devam", "Geri");
	    new id = strval(inputtext);
	    if (!OyundaDegil(id))
	    {
	        return Dialog_Show(playerid, ZarDuellosu2, DIALOG_STYLE_INPUT, "{808080}Kumarhane - {808080}Zar Düellosu", "Lütfen düello yapmak istediðiniz kiþinin ID'sini girin:", "Devam", "Geri");
	    }
	    if (playerid == id)
	    {
	        HataMesajGonder(playerid, "Kendi ID'ni yazamazsýn!");
	        return Dialog_Show(playerid, ZarDuellosu2, DIALOG_STYLE_INPUT, "{808080}Kumarhane - {808080}Zar Düellosu", "Lütfen düello yapmak istediðiniz kiþinin ID'sini girin:", "Devam", "Geri");
	    }
	    if (!IsPlayerNearPlayer(playerid, id, 20.0))
	    {
	        HataMesajGonder(playerid, "Kiþiye yeterince yakýn deðilsiniz.");
	        return Dialog_Show(playerid, ZarDuellosu2, DIALOG_STYLE_INPUT, "{808080}Kumarhane - {808080}Zar Düellosu", "Lütfen düello yapmak istediðiniz kiþinin ID'sini girin:", "Devam", "Geri");
	    }
	    if(PlayerData[id][pLevel] < 2)
	    {
	        HataMesajGonder(playerid, "Kumar oynamak için en az 2 seviye olmalý.");
	        return Dialog_Show(playerid, ZarDuellosu2, DIALOG_STYLE_INPUT, "{808080}Kumarhane - {808080}Zar Düellosu", "Lütfen düello yapmak istediðiniz kiþinin ID'sini girin:", "Devam", "Geri");
	    }
	    if (IsPlayerPause(id))
	    {
	        HataMesajGonder(playerid, "Bu oyuncu AFK, zar düellosu yollayamazsýnýz.");
	        return Dialog_Show(playerid, ZarDuellosu2, DIALOG_STYLE_INPUT, "{808080}Kumarhane - {808080}Zar Düellosu", "Lütfen düello yapmak istediðiniz kiþinin ID'sini girin:", "Devam", "Geri");
	    }
	    if (GetPVarInt(id, "kumar_id") != INVALID_PLAYER_ID)
	    {
	        HataMesajGonder(playerid, "Bu kiþi þuanda baþkasýyla düello yapýyor.");
	        return Dialog_Show(playerid, ZarDuellosu2, DIALOG_STYLE_INPUT, "{808080}Kumarhane - {808080}Zar Düellosu", "Lütfen düello yapmak istediðiniz kiþinin ID'sini girin:", "Devam", "Geri");
	    }
	    new bahis = GetPVarInt(playerid, "kumar_para");
	    if (PlayerData[id][pCash] < bahis)
	    {
	        HataMesajGonder(playerid, "Bu kiþinin yeterli parasý yok.");
	        return Dialog_Show(playerid, ZarDuellosu2, DIALOG_STYLE_INPUT, "{808080}Kumarhane - {808080}Zar Düellosu", "Lütfen düello yapmak istediðiniz kiþinin ID'sini girin:", "Devam", "Geri");
	    }
	    SetPVarInt(id, "kumar_para", bahis);
     	new para = GetPVarInt(playerid, "kumar_para");
      	SetPVarInt(playerid, "kumar_id", id);
       	SetPVarInt(id, "kumar_id", playerid);
       	MesajGonder(playerid, "%s kiþisine düello daveti gönderildi, yanýtýný bekleyin.", ReturnName(id, 0));
       	Dialog_Show(id, DuelloDavet, DIALOG_STYLE_MSGBOX, "Düello Daveti", "{ffffff}%s, {2ecc71}%s {ffffff}miktarýnda bahisle sizi zar düellosuna davet ediyor. Kabul ediyor musunuz?", "Evet", "Hayýr", ReturnName(playerid, 0), FormatNumber(para));
	}
	return 1;
}
Dialog:DuelloDavet(playerid, response, listitem, inputtext[])
{
    if (!response)
   	{
  		new id = GetPVarInt(playerid, "kumar_id");
    	BilgiMesajGonder(id, "%s düello davetinizi reddetti.", ReturnName(playerid, 0));
       	SetPVarInt(id, "kumar_id", INVALID_PLAYER_ID);
        SetPVarInt(playerid, "kumar_id", INVALID_PLAYER_ID);
    }
    if (response)
    {
    	new id = GetPVarInt(playerid, "kumar_id");
     	MesajGonder(id, "%s zar düellosunu kabul etti.", ReturnName(playerid, 0));
       	SetPVarInt(playerid, "kumar_kimde", 0);
        SetPVarInt(id, "kumar_kimde", 1);
        KumarDondurme(playerid);
        KumarDondurme(id);
    }
	return 1;
}
Dialog:SupremeNumber(playerid, response, listitem, inputtext[])
{
	if (!response) return callcmd::kumar(playerid);
	if (response)
	{
	    if (isnull(inputtext)) return Dialog_Show(playerid, SupremeNumber, DIALOG_STYLE_INPUT, "{808080}Kumarhane - {808080}Supreme Number", "{808080}» {FFFFFF}Lütfen oynamak istediðiniz bahis miktarýný girin ($100 ile $1500 arasýnda olmalýdýr)", "Devam", "Geri");
	    if (strval(inputtext) < 100 || strval(inputtext) > 1500) return Dialog_Show(playerid, SupremeNumber, DIALOG_STYLE_INPUT, "{808080}Kumarhane - {808080}Supreme Number", "{808080}» {FFFFFF}Lütfen oynamak istediðiniz bahis miktarýný girin ($100 ile $1500 arasýnda olmalýdýr)", "Devam", "Geri");
	    if (PlayerData[playerid][pCash] < strval(inputtext))
	    {
	        HataMesajGonder(playerid, "Yazdýðýnýz bahis kadar paranýz yok!");
	        return Dialog_Show(playerid, SupremeNumber, DIALOG_STYLE_INPUT, "{808080}Kumarhane - {808080}Supreme Number", "{808080}» {FFFFFF}Lütfen oynamak istediðiniz bahis miktarýný girin ($100 ile $1500 arasýnda olmalýdýr)", "Devam", "Geri");
	    }
	    new sayi = RandomEx(1,7);
		new oyuncusayi = RandomEx(1,7);
		new id = Business_Inside(playerid);
  		if (id == -1 || Isyeri[id][isyeriTip] != 7) return 1;
		if (sayi == oyuncusayi)
		{
  			SendClientMessage(playerid, -1, "{528b8b}-------------------------------------------------------------------------");
			SendClientMessageEx(playerid, -1, "{FFFFFF}Kurpiyer bir zar attý ve {808080}%d {FFFFFF}geldi.", sayi);
			SendClientMessageEx(playerid, -1, "{FFFFFF}Siz bir zar attýnýz ve {808080}%d {FFFFFF}geldi.", oyuncusayi);
			SendClientMessage(playerid, -1, "{FFFFFF}Hiç bir kazanan olmadý!");
			SendClientMessage(playerid,-1, "{528b8b}-------------------------------------------------------------------------");
		}
		else if (sayi > oyuncusayi)
		{
		    SendClientMessage(playerid, -1, "{528b8b}-------------------------------------------------------------------------");
			SendClientMessageEx(playerid, -1, "{FFFFFF}Kurpiyer bir zar attý ve {808080}%d {FFFFFF}geldi.", sayi);
			SendClientMessageEx(playerid, -1, "{FFFFFF}Siz bir zar attýnýz ve {808080}%d {FFFFFF}geldi.", oyuncusayi);
			SendClientMessageEx(playerid, -1, "{FFFFFF}Üzgünüz, {808080}%s {FFFFFF}kaybettiniz.", FormatNumber(strval(inputtext)));
			SendClientMessage(playerid, -1, "{528b8b}-------------------------------------------------------------------------");
			ParaVer(playerid, -strval(inputtext));
			Isyeri[id][isyeriKasa] += strval(inputtext);
			Isyeri_Kaydet(id);
		}
		else
		{
		    SendClientMessage(playerid, -1, "{528b8b}-------------------------------------------------------------------------");
			SendClientMessageEx(playerid, -1, "{FFFFFF}Kurpiyer bir zar attý ve {808080}%d {FFFFFF}geldi.", sayi);
			SendClientMessageEx(playerid, -1, "{FFFFFF}Siz bir zar attýnýz ve {808080}%d {FFFFFF}geldi.", oyuncusayi);
			SendClientMessageEx(playerid, -1, "Tebrikler, {808080}%s {FFFFFF}kazandýnýz!", FormatNumber(strval(inputtext)*2));
			SendClientMessage(playerid,-1, "{528b8b}-------------------------------------------------------------------------");
			ParaVer(playerid, strval(inputtext));
			Isyeri[id][isyeriKasa] -= strval(inputtext);
			Isyeri_Kaydet(id);
		}
	}
	return 1;
}
Dialog:TekCiftBahis(playerid, response, listitem, inputtext[])
{
	if (!response) return callcmd::kumar(playerid);
	if (response)
	{
	    if (isnull(inputtext)) return Dialog_Show(playerid, TekCiftBahis, DIALOG_STYLE_INPUT, "{808080}Kumarhane - {808080}Tek/Çift", "{808080}» {FFFFFF}Lütfen oynamak istediðiniz bahis miktarýný girin ($100 ile $1500 arasýnda olmalýdýr)", "Devam", "Geri");
	    if (strval(inputtext) < 100 || strval(inputtext) > 1500) return Dialog_Show(playerid, TekCiftBahis, DIALOG_STYLE_INPUT, "{808080}Kumarhane - {808080}Tek/Çift", "{808080}» {FFFFFF}Lütfen oynamak istediðiniz bahis miktarýný girin ($100 ile $1500 arasýnda olmalýdýr)", "Devam", "Geri");
	    if (PlayerData[playerid][pCash] < strval(inputtext))
	    {
	        HataMesajGonder(playerid, "Yazdýðýnýz bahis kadar paranýz yok!");
	        return Dialog_Show(playerid, TekCiftBahis, DIALOG_STYLE_INPUT, "{808080}Kumarhane - {808080}Tek/Çift", "{808080}» {FFFFFF}Lütfen oynamak istediðiniz bahis miktarýný girin ($100 ile $1500 arasýnda olmalýdýr)", "Devam", "Geri");
	    }
	    SetPVarInt(playerid, "BahisPara", strval(inputtext));
	    Dialog_Show(playerid, TekCift, DIALOG_STYLE_LIST, "{808080}Kumarhane - {808080}Tek/Çift", "{FFFFFF}Tek\n{FFFFFF}Çift", "Seç", "Geri");
	}
	return 1;
}
Dialog:TekCift(playerid, response, listitem, inputtext[])
{
	if (!response)
	{
	    DeletePVar(playerid, "BahisPara");
	    Dialog_Show(playerid, TekCiftBahis, DIALOG_STYLE_INPUT, "{808080}Kumarhane - {808080}Tek/Çift", "{808080}» {FFFFFF}Lütfen oynamak istediðiniz bahis miktarýný girin ($100 ile $1500 arasýnda olmalýdýr)", "Devam", "Geri");
	    return 1;
	}
	else
	{
	    if (listitem == 0)
	    {
	        new sayi = RandomEx(1,7);
	        new id = Business_Inside(playerid);
	        if (id == -1 || Isyeri[id][isyeriTip] != 7) return 1;
	        if (sayi == 1 || sayi == 3 || sayi == 5)
	        {
	            ParaVer(playerid, GetPVarInt(playerid, "BahisPara"));
				SendClientMessage(playerid,-1, "{528b8b}-------------------------------------------------------------------------");
				SendClientMessageEx(playerid, -1, "{FFFFFF}Kurpiyer bir zar attý ve {808080}%d {FFFFFF}geldi. Tebrikler {808080}%s {FFFFFF}kazandýnýz!", sayi, FormatNumber(GetPVarInt(playerid, "BahisPara")*2));
				SendClientMessage(playerid,-1, "{528b8b}-------------------------------------------------------------------------");
				Isyeri[id][isyeriKasa] -= GetPVarInt(playerid, "BahisPara");
				Isyeri_Kaydet(id);
				DeletePVar(playerid, "BahisPara");
	        }
	        else
	        {
	            ParaVer(playerid, -GetPVarInt(playerid, "BahisPara"));
				SendClientMessage(playerid,-1, "{528b8b}-------------------------------------------------------------------------");
				SendClientMessageEx(playerid, -1, "{FFFFFF}Kurpiyer bir zar attý ve {808080}%d {FFFFFF}geldi. Üzgünüz, {808080}%s {FFFFFF}kaybettiniz!", sayi, FormatNumber(GetPVarInt(playerid, "BahisPara")));
				SendClientMessage(playerid,-1, "{528b8b}-------------------------------------------------------------------------");
				Isyeri[id][isyeriKasa] += GetPVarInt(playerid, "BahisPara");
				Isyeri_Kaydet(id);
				DeletePVar(playerid, "BahisPara");
	        }

	    }
	    if (listitem == 1)
	    {
	        new sayi = RandomEx(1,7);
	        new id = Business_Inside(playerid);
	        if (id == -1 || Isyeri[id][isyeriTip] != 7) return 1;
	        if (sayi == 2 || sayi == 4 || sayi == 6)
	        {
	            ParaVer(playerid, GetPVarInt(playerid, "BahisPara"));
				SendClientMessage(playerid,-1, "{528b8b}-------------------------------------------------------------------------");
				SendClientMessageEx(playerid, -1, "{FFFFFF}Kurpiyer bir zar attý ve {808080}%d {FFFFFF}geldi. Tebrikler {808080}%s {FFFFFF}kazandýnýz!", sayi, FormatNumber(GetPVarInt(playerid, "BahisPara")*2));
				SendClientMessage(playerid,-1, "{528b8b}-------------------------------------------------------------------------");
				Isyeri[id][isyeriKasa] -= GetPVarInt(playerid, "BahisPara");
				Isyeri_Kaydet(id);
				DeletePVar(playerid, "BahisPara");
	        }
	        else
	        {
	            ParaVer(playerid, -GetPVarInt(playerid, "BahisPara"));
				SendClientMessage(playerid,-1, "{528b8b}-------------------------------------------------------------------------");
				SendClientMessageEx(playerid, -1, "{FFFFFF}Kurpiyer bir zar attý ve {808080}%d {FFFFFF}geldi. Üzgünüz, {808080}%s {FFFFFF}kaybettiniz!", sayi, FormatNumber(GetPVarInt(playerid, "BahisPara")));
				SendClientMessage(playerid,-1, "{528b8b}-------------------------------------------------------------------------");
				Isyeri[id][isyeriKasa] += GetPVarInt(playerid, "BahisPara");
				Isyeri_Kaydet(id);
				DeletePVar(playerid, "BahisPara");
	        }
	    }
	}
	return 1;
}
Dialog:KumarDondurme(playerid, response, listitem, inputtext[])
{
	if (!response) return KumarDondurme(playerid);
	if (response)
	{
	    switch (listitem)
	    {
	        case 0, 3, 4: KumarDondurme(playerid);
	        case 1: Dialog_Show(playerid, BahisDegistir, DIALOG_STYLE_INPUT, "{808080}Bahis Deðiþtir", "Lütfen deðiþtirmek istediðiniz bahis tutarýný girin.\n\nUyarý: En az $100 en fazla $10,000 girebilirsin.", "Deðiþtir", "Iptal");
	        case 2:
         	{
                    new durum = GetPVarInt(playerid, "kumar_kimde");
                    if (!durum) {
                        KumarDondurme(playerid);
                        HataMesajGonder(playerid, "Oyun sýrasý sizde deðil.");
                        return 1;
                    }
                    if (durum){
                        new
                            ben[3],
                            karsi[3],
                            sz[300],
                            id = GetPVarInt(playerid, "kumar_id"),
                            bahis = GetPVarInt(playerid, "kumar_para")
                        ;

                        if (PlayerData[playerid][pCash] < bahis)
                        {
                            BilgiMesajGonder(playerid, "Yeterli paranýz kalmadýðý için zar düellosu sonlandýrýldý.");
                            BilgiMesajGonder(id, "Karþý tarafýn yeterli parasý kalmadýðý için zar düellosu sonlandýrýldý.");
                            KumarReset(playerid, 1);
                            KumarReset(id, 1);
                            return 1;
                        }

                        if (PlayerData[id][pCash] < bahis)
                        {
                            BilgiMesajGonder(id, "Yeterli paranýz kalmadýðý için zar düellosu sonlandýrýldý.");
                            BilgiMesajGonder(playerid, "Karþý tarafýn yeterli parasý kalmadýðý için zar düellosu sonlandýrýldý.");
                            KumarReset(playerid, 1);
                            KumarReset(id, 1);
                            return 1;
                        }

                        SetPVarInt(playerid, "kumar_kimde", 0);
                        SetPVarInt(id, "kumar_kimde", 1);

                        ben[0] = ZAR_NXR();
                        ben[1] = ZAR_NXR();
                        ben[2] = ben[0] + ben[1];

                        karsi[0] = ZAR_NXR();
                        karsi[1] = ZAR_NXR();
                        karsi[2] = karsi[0] + karsi[1];

						SendClientMessage(playerid, 0xFFFFFF, "");
                        SendClientMessage(playerid, 0xFFFFFF, "");
                        SendClientMessage(playerid, 0xFFFFFF, "");
                        SendClientMessage(playerid, 0xFFFFFF, "");
                        SendClientMessage(playerid, 0xFFFFFF, "");

                        SendClientMessage(id, 0xFFFFFF, "");
                        SendClientMessage(id, 0xFFFFFF, "");
                        SendClientMessage(id, 0xFFFFFF, "");
                        SendClientMessage(id, 0xFFFFFF, "");
                        SendClientMessage(id, 0xFFFFFF, "");

                        SendClientMessage(playerid, 0x6a89ccff, "--------------------------------------------");
                        SendClientMessage(id, 0x6a89ccff, "--------------------------------------------");
                        format(sz, sizeof(sz), "%s, (1. Zar: %d), (2. Zar: %d), (Toplam: %d)", ReturnName(playerid, 0), ben[0], ben[1], ben[2]);
                        SendClientMessage(playerid, 0x6a89ccff, sz);
                        SendClientMessage(id, 0x6a89ccff, sz);

                        format(sz, sizeof(sz), "%s, (1. Zar: %d), (2. Zar: %d), (Toplam: %d)", ReturnName(id, 0), karsi[0], karsi[1], karsi[2]);
                        SendClientMessage(playerid, 0x6a89ccff, sz);
                        SendClientMessage(id, 0x6a89ccff, sz);

                        if (ben[2] > karsi[2]){
                            format(sz, sizeof(sz), "Bu roundu %s (%s) kazandý !", ReturnName(playerid, 0), FormatNumber(bahis));
                            ParaVer(playerid, bahis);
                            ParaVer(id, -bahis);
                        }
                        if (karsi[2] > ben[2]){
                            format(sz, sizeof(sz), "Bu roundu %s (%s) kazandý !", ReturnName(id, 0), FormatNumber(bahis));
                            ParaVer(playerid, -bahis);
                            ParaVer(id, bahis);
                        }
                        if (ben[2] == karsi[2]){
                            format(sz, sizeof(sz), "Bu roundu kimse kazanamadý !");
                        }
                        SendClientMessage(playerid, 0x6a89ccff, sz);
                        SendClientMessage(id, 0x6a89ccff, sz);

                        SendClientMessage(playerid, 0x6a89ccff, "--------------------------------------------");
                        SendClientMessage(id, 0x6a89ccff, "--------------------------------------------");

                        KumarDondurme(playerid);
                        KumarDondurme(id);
			}

		}
		case 5:
   			{
      			//new sz[300];
         		new id = GetPVarInt(playerid, "kumar_id");
           		MesajGonder(id, "%s zar düellosunu bitirdi.", ReturnName(playerid, 0));
				MesajGonder(playerid, "Zar düellosunu bitirdiniz.");
				ShowPlayerDialog(id, -1, DIALOG_STYLE_MSGBOX, "", "", "", "");
    			ShowPlayerDialog(playerid, -1, DIALOG_STYLE_MSGBOX, "", "", "", "");
       			KumarReset(playerid, 1);
          		KumarReset(id, 1);
      		}
	    }
	}
	return 1;
}
Dialog:BahisDegistir(playerid, response, listitem, inputtext[])
{
    if (!response) return KumarDondurme(playerid);
    if (response)
    {
        if (isnull(inputtext) || !IsNumeric(inputtext) || strval(inputtext) < 100 || strval(inputtext) > 10000) return Dialog_Show(playerid, BahisDegistir, DIALOG_STYLE_INPUT, "{808080}Bahis Deðiþtir", "Lütfen deðiþtirmek istediðiniz bahis tutarýný girin.\n\nUyarý: En az $100 en fazla $10,000 girebilirsin.", "Deðiþtir", "Iptal");
        if (strval(inputtext) > PlayerData[playerid][pCash])
        {
            HataMesajGonder(playerid, "O kadar paranýz yok.");
            return Dialog_Show(playerid, BahisDegistir, DIALOG_STYLE_INPUT, "{808080}Bahis Deðiþtir", "Lütfen deðiþtirmek istediðiniz bahis tutarýný girin.\n\nUyarý: En az $100 en fazla $10,000 girebilirsin.", "Deðiþtir", "Iptal");
        }
       	new id = GetPVarInt(playerid, "kumar_id");
		if (strval(inputtext) > PlayerData[id][pCash])
		{
		    HataMesajGonder(playerid, "Karþýdaki kiþinin o kadar parasý yok.");
		    return Dialog_Show(playerid, BahisDegistir, DIALOG_STYLE_INPUT, "{808080}Bahis Deðiþtir", "Lütfen deðiþtirmek istediðiniz bahis tutarýný girin.\n\nUyarý: En az $100 en fazla $10,000 girebilirsin.", "Deðiþtir", "Iptal");
		}
		SetPVarInt(playerid, "kumar_para2", strval(inputtext));
		MesajGonder(playerid, "%s adlý kiþiye bahis deðiþtirme teklifi gönderildi.", ReturnName(id, 0));
		Dialog_Show(id, BahisDegistir2, DIALOG_STYLE_MSGBOX, "{808080}Bahis Deðiþtirme", "{ffffff}%s, bahis tutarýný {2ecc71}$%s {ffffff}olarak güncellemek istiyor.", "Kabul Et", "Reddet", ReturnName(playerid, 0), FormatNumber(strval(inputtext)));
    }
	return 1;
}
Dialog:BahisDegistir2(playerid, response, listitem, inputtext[])
{
	if (!response)
	{
	    //new sz[128];
     	new id = GetPVarInt(playerid, "kumar_id");
      	SetPVarInt(playerid, "kumar_para2", 0);
       	SetPVarInt(id, "kumar_para2", 0);
       	BilgiMesajGonder(id, "%s, göndermiþ olduðunuz bahis tutarýný kabul etmedi.", ReturnName(playerid, 0));
        KumarDondurme(playerid);
        KumarDondurme(id);
	}
	if (response)
	{
	    new id = GetPVarInt(playerid, "kumar_id");
     	new bahis = GetPVarInt(id, "kumar_para2");
      	SetPVarInt(playerid, "kumar_para2", 0);
       	SetPVarInt(id, "kumar_para2", 0);
       	SetPVarInt(playerid, "kumar_para", bahis);
        SetPVarInt(id, "kumar_para", bahis);
        MesajGonder(id, "%s, göndermiþ olduðunuz bahis tutarýný kabul etti.", ReturnName(playerid, 0));
        KumarDondurme(playerid);
        KumarDondurme(id);
	}
	return 1;
}
Dialog:HizmetSecin(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		SetPVarInt(playerid, "Hizmet", listitem+1);
		Dialog_Show(playerid, Aciklama, DIALOG_STYLE_INPUT, "Operatör ~ Açýklama", "Lütfen olay hakkýnda kýsa bir açýklama yazýn:", "Gönder", "Kapat");
	}
	return 1;
}
Dialog:Aciklama(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (isnull(inputtext)) return Dialog_Show(playerid, Aciklama, DIALOG_STYLE_INPUT, "Operatör ~ Açýklama", "Lütfen olay hakkýnda kýsa bir açýklama yazýn:", "Gönder", "Kapat");
	    if (GetPVarInt(playerid, "Hizmet") == 1)
	    {
	        new Float:pos[3];
	        format(PlayerData[playerid][pIhbar], 128, inputtext);
	        PlayerData[playerid][pIhbarSayac] = 300;
	        SetFactionMarker(playerid, BIRLIK_LSPD, 0x00D700FF);
	    	SetFactionMarker(playerid, BIRLIK_FBI, 0x00D700FF);
	    	GetPlayerPosEx(playerid, pos[0], pos[1], pos[2]);
	    	SendBirlikMessageEx(BIRLIK_LSPD, COLOR_RADIO, "** (Radyo) 911 ÇAÐRISI: %s (Yer: %s - Tel No: %d)", ReturnName(playerid, 0), GetLocation(pos[0], pos[1], pos[2]), PlayerData[playerid][pTelefon]);
	    	SendBirlikMessageEx(BIRLIK_LSPD, COLOR_RADIO, "** (Radyo) Açýklama: %s", inputtext);
	    	SendBirlikMessageEx(BIRLIK_FBI, COLOR_RADIO, "** (Radyo) 911 ÇAÐRISI: %s (Yer: %s - Tel No: %d)", ReturnName(playerid, 0), GetLocation(pos[0], pos[1], pos[2]), PlayerData[playerid][pTelefon]);
	    	SendBirlikMessageEx(BIRLIK_FBI, COLOR_RADIO, "** (Radyo) Açýklama: %s", inputtext);
	    	MesajGonder(playerid, "Tüm birimler bilgilendirildi, teþekkürler.");
	    	DeletePVar(playerid, "Hizmet");
	    }
	    else if (GetPVarInt(playerid, "Hizmet") == 2)
	    {
	        new Float:pos[3];
	        GetPlayerPosEx(playerid, pos[0], pos[1], pos[2]);
	        SendBirlikMessageEx(BIRLIK_LSMD, 0xFF8282FF, "** 911 ÇAÐRISI: %s (Yer: %s - Tel No: %d)", ReturnName(playerid, 0), GetLocation(pos[0], pos[1], pos[2]), PlayerData[playerid][pTelefon]);
	        SendBirlikMessageEx(BIRLIK_LSMD, 0xFF8282FF, "** AÇIKLAMA: %s", inputtext);
	        SetFactionMarker(playerid, BIRLIK_LSMD, 0xFF8282FF);
	        MesajGonder(playerid, "Tüm saðlýk birimleri bilgilendirildi, teþekkürler.");
	    }
	    DeletePVar(playerid, "Hizmet");
	}
	return 1;
}
Dialog:TelefonMenu(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    switch (listitem)
	    {
	        case 0: // Arama
	        {
	            if (PlayerData[playerid][pTelefonAyar][0] == 1) return HataMesajGonder(playerid, "Telefonunuz kapalý.");
	            if (PlayerData[playerid][pAramada] != 0) return HataMesajGonder(playerid, "Þu an aramada olduðunuz için kimseyi arayamazsýnýz.");
	            Dialog_Show(playerid, Arama, DIALOG_STYLE_INPUT, "Arama", "{ffffff}Aramak istediðiniz numarayý girin:\n\n{ffffff}Acildurum hattý 911, taksi hattý 333. ", "Ara", "Geri");
	        }
	        case 1: // SMS Yolla
	        {
	        	if (PlayerData[playerid][pTelefonAyar][0] == 1) return HataMesajGonder(playerid, "Telefonunuz kapalý.");
	        	if (PlayerData[playerid][pTarife] == -1 || PlayerData[playerid][pTarifeKalan][1] == 0) return HataMesajGonder(playerid, "Tarifeniz yok veya sms hakkýnýz bitmiþ.");
	        	Dialog_Show(playerid, SMSGonder, DIALOG_STYLE_INPUT, "SMS Yolla", "{ffffff}SMS yollamak istediðiniz numarayý girin:", "Devam", "Geri");
	        }
					case 2: // Boþ
					{
						HataMesajGonder(playerid, "Hatalý tuþlama yaptýnýz.");
						return Telefon_Menu(playerid);
					}
					case 3: // Rehber
	        {
	        	if (PlayerData[playerid][pTelefonAyar][0] == 1) return HataMesajGonder(playerid, "Telefonunuz kapalý.");
	            Telefon_Rehber(playerid);
	        }
	        case 4: // Tarayici
	        {
	            if (PlayerData[playerid][pTelefonAyar][0] == 1) return HataMesajGonder(playerid, "Telefonunuz kapalý.");
	        	if (PlayerData[playerid][pTarife] == -1 || PlayerData[playerid][pTarifeKalan][2] <= 2) return HataMesajGonder(playerid, "Akitf tarifeniz bulunmuyor, telefonunuzdan tarife alabilirsiniz.");
	        	PlayerData[playerid][pTarifeKalan][2] -= 3;
	        	Dialog_Show(playerid, Tarayici, DIALOG_STYLE_LIST, "Tarayýcý", "{FFC100}» {FFFFFF}Araç Ýlanlarý\n{FFC100}» {FFFFFF}BitCoin\n{FFC100}» {FFFFFF}Müzik Çalar\n{FFC100}» {FFFFFF}Konum Gönder\n{FFC100}» {FFFFFF}Galeri\n{FFC100}» {FFFFFF}Araç Getirme Servisi\n{FFC100}» {FFFFFF}Deep Web", "Seç", "Kapat");
	        }
	        case 5: // Tarifem
	        {
	        	if (PlayerData[playerid][pTarife] == -1)
	        	{
	        		HataMesajGonder(playerid, "Akitf tarifeniz bulunmuyor, telefonunuzdan tarife alabilirsiniz.");
	        		return Telefon_Menu(playerid);
	        	}
	        	Dialog_Show(playerid, Tarifem, DIALOG_STYLE_LIST, "Tarife", "{FFC100}» {FFFFFF}Tarifeniz:\t\t{FFFFFF}%s\n{FFC100}» {FFFFFF}Kalan Dakika:\t\t{FFFFFF}%d/%d\n{FFC100}» {FFFFFF}Kalan SMS:\t\t{FFFFFF}%d/%d\n{FFC100}» {FFFFFF}Kalan Internet:\t{FFFFFF}%d/%d\n\n{FFC100}» {FFFFFF}Tarifeyi Ýptal Et", "Seç", "Kapat",
	        	Tarifeler[PlayerData[playerid][pTarife]][TarifeAdi], PlayerData[playerid][pTarifeKalan][0], Tarifeler[PlayerData[playerid][pTarife]][TarifeDakika],  PlayerData[playerid][pTarifeKalan][1], Tarifeler[PlayerData[playerid][pTarife]][TarifeSMS], PlayerData[playerid][pTarifeKalan][2],  Tarifeler[PlayerData[playerid][pTarife]][TarifeNet]);
			}
			case 6: // Tarife yukle
			{
				new string[500];
				strcat(string, "Tarife/Fiyat\tDakika\tSMS\tÝnternet\n");
				strcat(string, "{ffffff}Þip Þak Tarife {33CC66}$250\t{ffffff}10 Dakika\t10 SMS\t50 MB\n");
				strcat(string, "{ffffff}Ýdeal Tarife {33CC66}$1000\t{ffffff}50 Dakika\t75 SMS\t250 MB\n");
				strcat(string, "{ffffff}Mükemmel Tarife {33CC66}$1500\t{ffffff}100 Dakika\t120 SMS\t560 MB\n");
				strcat(string, "{ffffff}Doyumsuz Tarife {33CC66}$3000\t{ffffff}250 Dakika\t300 SMS\t1024 MB\n");
				Dialog_Show(playerid, Tarifeler, DIALOG_STYLE_TABLIST_HEADERS, "{ffffff}Tarife Yükle", string, "Seç", "{FF6347}Kapat");
			}
			case 7: // Boþ
			{
				HataMesajGonder(playerid, "Hatalý tuþlama yaptýnýz.");
				return Telefon_Menu(playerid);
			}
			case 8: // Ayarlar
			{
				if (PlayerData[playerid][pTelefonAyar][0] == 1) return HataMesajGonder(playerid, "Telefonunuz kapali.");
	            Dialog_Show(playerid, TelefonAyarlar, DIALOG_STYLE_LIST, "Ayarlar", "{FFC100}» {FFFFFF}Titreþim:\t\t%s\n{FFC100}» {FFFFFF}Hoparlör:\t\t%s\n{FFC100}» {FFFFFF}Bilinmeyen Numara Engeli:\t%s\n{FFC100}» {FFFFFF}SMS Engeli:\t\t%s\n{FFC100}» {FFFFFF}Arama Engeli:\t\t%s", "Seç", "Geri",(PlayerData[playerid][pTelefonAyar][1] == 0) ? ("{F22C2C}Kapalý") : ("{2CF26B}Açýk"),
				(PlayerData[playerid][pTelefonAyar][2] == 0) ? ("{F22C2C}Kapalý") : ("{2CF26B}Açýk"),  (PlayerData[playerid][pTelefonAyar][3] == 0) ? ("{F22C2C}Kapalý") : ("{2CF26B}Açýk"),  (PlayerData[playerid][pTelefonAyar][4] == 0) ? ("{F22C2C}Kapalý") : ("{2CF26B}Açýk"), (PlayerData[playerid][pTelefonAyar][5] == 0) ? ("{F22C2C}Kapalý") : ("{2CF26B}Açýk"));
			}
			case 9: // u Kapat
			{
			    if (PlayerData[playerid][pTelefonAyar][0] == 0)
			    {
			        PlayerData[playerid][pTelefonAyar][0] = 1;
			        SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s iþaret parmaðýný  kapatma düðmesine doðru götürür ve u kapatýr.", ReturnName(playerid, 0));
			        if (PlayerData[playerid][pAramada] != 0) CagriKapat(playerid);
			    }
			    else
			    {
			        PlayerData[playerid][pTelefonAyar][0] = 0;
			        SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s iþaret parmaðýný  açma düðmesine doðru götürür ve u açar.", ReturnName(playerid, 0));
			    }
			}
	    }
	}
	return 1;
}
Dialog:Tarayici(playerid, response, listitem, inputtext[])
{
	if (!response) return Telefon_Menu(playerid);
	if (response)
	{
	    if (listitem == 0)
	    {
	        if (PlayerData[playerid][pTarife] == -1 || PlayerData[playerid][pTarifeKalan][2] < 2) return HataMesajGonder(playerid, "Tarifeniz yok veya internet paketiniz yetmiyor tarife satýn almak için elektronik maðzasýndaki tarifeciden alabilirsiniz.");
	        PlayerData[playerid][pTarifeKalan][2] -= 2;
	        Dialog_Show(playerid, AracIlanlari, DIALOG_STYLE_INPUT, "{FFFFFF}Araç Ýlanlarý", "{FFC100}» {FFFFFF}Lütfen aratmak istediðiniz aracýn modelini veya adýný girin:", "Ara", "Geri");
	    }
	    if (listitem == 1)
	    {
            if (PlayerData[playerid][pTarife] == -1 || PlayerData[playerid][pTarifeKalan][2] < 2) return HataMesajGonder(playerid, "Tarifeniz yok veya internet paketiniz yetmiyor tarife satýn almak için elektronik maðzasýndaki tarifeciden alabilirsiniz.");
            PlayerData[playerid][pTarifeKalan][2] -= 2;
	        HataMesajGonder(playerid, "Sistem þuanlýk pasif durumdadýr.");
//            Bitcoin_Menu(playerid);
	    }
	    if (listitem == 2)
	    {
	        if (PlayerData[playerid][pTarife] == -1 || PlayerData[playerid][pTarifeKalan][2] < 10) return HataMesajGonder(playerid, "Tarifeniz yok veya internet paketiniz yetmiyor tarife satýn almak için elektronik maðzasýndaki tarifeciden alabilirsiniz.");
	        Dialog_Show(playerid, MuzikCalar, DIALOG_STYLE_INPUT, "Müzik Çalar", "{FFC100}» {FFFFFF}Lütfen oynatmak istediðiniz müziðin .mp3 uzantýlý linkini girin:", "Oynat", "Geri");
	    }
	    if (listitem == 3)
	    {
	        if (PlayerData[playerid][pTarife] == -1 || PlayerData[playerid][pTarifeKalan][2] < 5) return HataMesajGonder(playerid, "Tarifeniz yok veya internet paketiniz yetmiyor tarife satýn almak için elektronik maðzasýndaki tarifeciden alabilirsiniz.");
	        Dialog_Show(playerid, KonumGonder, DIALOG_STYLE_INPUT, "Konum Gönder", "{FFC100}» {FFFFFF}Konum göndermek istediðiniz numarayý girin:", "Gönder", "Geri");
		}
	 	if (listitem == 4)
	    {
	        if (PlayerData[playerid][pTarife] == -1 || PlayerData[playerid][pTarifeKalan][2] < 5) return HataMesajGonder(playerid, "Tarifeniz yok veya internet paketiniz yetmiyor tarife satýn almak için elektronik maðzasýndaki tarifeciden alabilirsiniz.");
	        mysql_tquery(g_SQL, "SELECT model FROM satilikaraclar", "SatilikAraclar", "d", playerid);
	    }
  	 	if (listitem == 5)
	    {
	        if (PlayerData[playerid][pTarife] == -1 || PlayerData[playerid][pTarifeKalan][2] < 5) return HataMesajGonder(playerid, "Tarifeniz yok veya internet paketiniz yetmiyor tarife satýn almak için elektronik maðzasýndaki tarifeciden alabilirsiniz.");
    		new vehicleid;
			new string[1000],count;
			strcat(string, "ID\tModel\tPlaka\tDurum\n");
			for (new i = 0; i < MAX_ARAC; i ++) if (AracInfo[i][aracExists] && AracInfo[i][aracSahip] == PlayerData[playerid][pID])
			{
				format(string, sizeof(string), "%s%d\t%s\t%s\t%s\n",string, AracInfo[i][aracVehicle], ReturnVehicleModelName(AracInfo[i][aracModel]),AracInfo[i][aracPlaka],(AracInfo[i][aracDisplay]) ? ("{2ECC71}Aktif") : ("{FF0000}Pasif"));
	    		count++;
			}
			if (!count) return HataMesajGonder(playerid, "Sahip olduðunuz araç yok.");

			Dialog_Show(playerid, AracServis, DIALOG_STYLE_TABLIST_HEADERS,  "{808080}Araç Getirme Servisi ($3000)", string, "Deðiþtir", "Kapat");
	    }
		if (listitem == 6)
	    {
	        if (PlayerData[playerid][pTarife] == -1 || PlayerData[playerid][pTarifeKalan][2] < 5) return HataMesajGonder(playerid, "Tarifeniz yok veya internet paketiniz yetmiyor tarife satýn almak için elektronik maðzasýndaki tarifeciden alabilirsiniz.");
    		        Dialog_Show(playerid, DeepWeb, DIALOG_STYLE_LIST, "Deep Web - [#DARK WEB ÝD GELÝCEK]", "{FFC100}» Silah{FFFFFF}\n{FFC100}» Uyuþturucu{FFFFFF}\n{FFC100}» Eskort{FFFFFF}\n{FFC100}» Kredi Kartý{FFFFFF}", "Gir", "Geri");
	    }
	}
	return 1;
}
Dialog:DeepWeb(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (listitem == 0)
	    {

		}
	    if (listitem == 1)
	    {

		}
	    if (listitem == 2)
	    {

		}
	    if (listitem == 3)
	    {
			if (PlayerData[playerid][pCash] < 2000) return HataMesajGonder(playerid, "Yeterli paranýz yok. ($1000)");
			ParaVer(playerid, -2000);

			ParaVer(playerid = RandomEx(500, 5000));
			MesajGonder(playerid, "Deep Webden Satýn aldýðýn Çalýntý Kredi Kartýndan %d Para çektin.");
		}
	}
	return 1;
}
Dialog:BirlikPara(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (listitem == 0)
	    {
				if (PlayerData[playerid][pCash] < 50000) return HataMesajGonder(playerid, "Yeterli paranýz yok. ($50,000)");
		        new bid = Birlik_Olustur(BirlikAdi[playerid],listitem+1);
		        if (bid == -1) return HataMesajGonder(playerid, "Yarýþ/Çete Türü Birlik oluþturulamadý, lütfen geliþtirici ekibiyle iletiþime geçin.");
		        ParaVer(playerid, -50000);
		        MesajGonder(playerid, "Baþarý ile '%s' adlý birlik oluþturuldu, /birlik komutuyla birlik ayarlarýna eriþebilirsiniz.",BirlikAdi[playerid]);
		        PlayerData[playerid][pFaction] = bid;
		        PlayerData[playerid][pFactionRutbe] = Birlikler[bid][birlikRutbeler];
		        PlayerData[playerid][pFactionDivizyon] = 0;
		        Log_Write("logs/birliklog.txt", "%s(%d) Adli oyuncu %s isimli birlik olusturdu.",ReturnName(playerid),playerid,BirlikAdi[playerid]);
		        Oyuncu_Kaydet(playerid);
		}
	    if (listitem == 1)
	    {
				if (PlayerData[playerid][pCash] < 30000) return HataMesajGonder(playerid, "Yeterli paranýz yok. ($30,000)");
		        new bid = Birlik_Olustur(BirlikAdi[playerid],listitem+1);
		        if (bid == -1) return HataMesajGonder(playerid, "Mafya Türü Birlik oluþturulamadý, lütfen geliþtirici ekibiyle iletiþime geçin.");
		        ParaVer(playerid, -30000);
		        MesajGonder(playerid, "Baþarý ile '%s' adlý birlik oluþturuldu, /birlik komutuyla birlik ayarlarýna eriþebilirsiniz.",BirlikAdi[playerid]);
		        PlayerData[playerid][pFaction] = bid;
		        PlayerData[playerid][pFactionRutbe] = Birlikler[bid][birlikRutbeler];
		        PlayerData[playerid][pFactionDivizyon] = 0;
		        Log_Write("logs/birliklog.txt", "%s(%d) Adli oyuncu %s isimli birlik olusturdu.",ReturnName(playerid),playerid,BirlikAdi[playerid]);
		        Oyuncu_Kaydet(playerid);
	    }
	    if (listitem == 2)
	    {
				if (PlayerData[playerid][pCash] < 150000) return HataMesajGonder(playerid, "Yeterli paranýz yok. ($150,000)");
		        new bid = Birlik_Olustur(BirlikAdi[playerid],listitem+1);
		        if (bid == -1) return HataMesajGonder(playerid, "Yayýn Türü Birlik oluþturulamadý, lütfen geliþtirici ekibiyle iletiþime geçin.");
		        ParaVer(playerid, -150000);
		        MesajGonder(playerid, "Baþarý ile '%s' adlý birlik oluþturuldu, /birlik komutuyla birlik ayarlarýna eriþebilirsiniz.",BirlikAdi[playerid]);
		        PlayerData[playerid][pFaction] = bid;
		        PlayerData[playerid][pFactionRutbe] = Birlikler[bid][birlikRutbeler];
		        PlayerData[playerid][pFactionDivizyon] = 0;
		        Log_Write("logs/birliklog.txt", "%s(%d) Adli oyuncu %s isimli birlik olusturdu.",ReturnName(playerid),playerid,BirlikAdi[playerid]);
		        Oyuncu_Kaydet(playerid);
	    }
	    if (listitem == 3)
	    {
				if (PlayerData[playerid][pCash] < 50000) return HataMesajGonder(playerid, "Yeterli paranýz yok. ($50,000)");
		        new bid = Birlik_Olustur(BirlikAdi[playerid],listitem+1);
		        if (bid == -1) return HataMesajGonder(playerid, "Legal Türü Birlik oluþturulamadý, lütfen geliþtirici ekibiyle iletiþime geçin.");
		        ParaVer(playerid, -50000);
		        MesajGonder(playerid, "Baþarý ile '%s' adlý birlik oluþturuldu, /birlik komutuyla birlik ayarlarýna eriþebilirsiniz.",BirlikAdi[playerid]);
		        PlayerData[playerid][pFaction] = bid;
		        PlayerData[playerid][pFactionRutbe] = Birlikler[bid][birlikRutbeler];
		        PlayerData[playerid][pFactionDivizyon] = 0;
		        Log_Write("logs/birliklog.txt", "%s(%d) Adli oyuncu %s isimli birlik olusturdu.",ReturnName(playerid),playerid,BirlikAdi[playerid]);
		        Oyuncu_Kaydet(playerid);
	    }
	}
	return 1;
}
Dialog:GPS2(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    switch (listitem)
	    {
	        case 0:
	        {
	            if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return 1;
	            GlobalLokasyonlar(playerid);
	        }
	        case 1:
	        {
	            if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return 1;
	            Dialog_Show(playerid, FindHouse, DIALOG_STYLE_INPUT, "Ev Bul", "{38c5f7}» {FFFFFF}Lütfen bulmak istediðiniz evin ID'sini girin:", "Devam", "Geri");
	        }
	        case 2:
	        {
	            if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return 1;
	            Dialog_Show(playerid, FindBiz, DIALOG_STYLE_INPUT, "Ýþyeri Bul", "{38c5f7}» {FFFFFF}Lütfen bulmak istediðiniz iþyerinin adýný girin:", "Devam", "Geri");
			}
			case 3:
			{
			    if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return 1;
			    Dialog_Show(playerid, FindEntrance, DIALOG_STYLE_INPUT, "Bina Bul", "{38c5f7}» {FFFFFF}Lütfen bulmak istediðiniz binanýn numarasýný girin:", "Bul", "Geri");
			}
	    }
	}
	return 1;
}
Dialog:GPS(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    switch (listitem)
	    {
	        case 0:
	        {
	            if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return 1;
	            GlobalLokasyonlar(playerid);
	        }
	        case 1:
	        {
	            if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return 1;
	            Dialog_Show(playerid, FindHouse, DIALOG_STYLE_INPUT, "Ev Bul", "{38c5f7}» {FFFFFF}Lütfen bulmak istediðiniz evin ID'sini girin:", "Devam", "Geri");
	        }
	        case 2:
	        {
	            if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return 1;
	            Dialog_Show(playerid, FindBiz, DIALOG_STYLE_INPUT, "Ýþyeri Bul", "{38c5f7}» {FFFFFF}Lütfen bulmak istediðiniz iþyerinin adýný girin:", "Devam", "Geri");
			}
			case 3:
			{
			    if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return 1;
			    Dialog_Show(playerid, FindEntrance, DIALOG_STYLE_INPUT, "Bina Bul", "{38c5f7}» {FFFFFF}Lütfen bulmak istediðiniz binanýn numarasýný girin:", "Bul", "Geri");
			}
	    }
	}
	return 1;
}
Dialog:FindEntrance(playerid, response, listitem, inputtext[])
{
	if (!response) return Dialog_Show(playerid, GPS, DIALOG_STYLE_LIST, "GPS", "{38c5f7}» {FFFFFF}Global Lokasyonlar\n{38c5f7}» {FFFFFF}Ev Bul\n{38c5f7}» {FFFFFF}Ýþyeri Bul\n{38c5f7}» {FFFFFF}Bina Bul\n{38c5f7}» {FFFFFF}Konum Gönder", "Seç", "Geri");
	if (response)
	{
	    if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return 1;
	    if (isnull(inputtext)) return Dialog_Show(playerid, FindEntrance, DIALOG_STYLE_INPUT, "Bina Bul", "{38c5f7}» {FFFFFF}Lütfen bulmak istediðiniz binanýn numarasýný girin:", "Bul", "Geri");
	    if (!IsNumeric(inputtext)) return Dialog_Show(playerid, FindEntrance, DIALOG_STYLE_INPUT, "Bina Bul", "{38c5f7}» {FFFFFF}Lütfen bulmak istediðiniz binanýn numarasýný girin:", "Bul", "Geri");
	    new id = strval(inputtext);
	    if ((id < 0 || id >= MAX_ENTRANCES) || !EntranceData[id][entranceExists])
	    {
	        HataMesajGonder(playerid, "Geçersiz bina numarasý girdiniz.");
	        return Dialog_Show(playerid, FindEntrance, DIALOG_STYLE_INPUT, "Bina Bul", "{38c5f7}» {FFFFFF}Lütfen bulmak istediðiniz binanýn numarasýný girin:", "Bul", "Geri");
	    }
     	if (PlayerData[playerid][pGPS] != -1 || GetPVarInt(playerid, "IsyeriBuluyor") != -1 || GetPVarInt(playerid, "EvBuluyor") != -1)
      	{
       		SetPVarInt(playerid, "IsyeriBuluyor", -1);
       		SetPVarInt(playerid, "EvBuluyor", -1);
         	PlayerData[playerid][pGPS] = -1;
          	DisablePlayerCheckpoint(playerid);
       	}
       	callcmd::cpsifirla(playerid);

        SetPVarInt(playerid, "BinaBuluyor", id);
        PlayerTextDrawShow(playerid, MesafeTD[playerid]);
        SetPlayerCheckpoint(playerid, EntranceData[id][entrancePos][0], EntranceData[id][entrancePos][1], EntranceData[id][entrancePos][2], 4.0);
        MesajGonder(playerid, "'%s' adlý bina haritada iþaretlenmiþtir.", EntranceData[id][entranceName]);
	}
	return 1;
}
Dialog:KonumGonder(playerid, response, listitem, inputtext[])
{
	if (!response) return Dialog_Show(playerid, Tarayici, DIALOG_STYLE_LIST, " ~ Tarayýcý", "{FFC100}» {FFFFFF}Araç Ýlanlarý\n{FFC100}» {FFFFFF}BitCoin\n{FFC100}» {FFFFFF}Müzik Çalar\n{FFC100}» {FFFFFF}Konum Gönder", "Seç", "Kapat");
	if (response)
	{
	    if (isnull(inputtext)) return Dialog_Show(playerid, KonumGonder, DIALOG_STYLE_INPUT, "Konum Gönder", "{38c5f7}» {FFFFFF}Konum göndermek istediðiniz numarayý girin:", "Gönder", "Geri");
	    if (!IsNumeric(inputtext)) return Dialog_Show(playerid, KonumGonder, DIALOG_STYLE_INPUT, "Konum Gönder", "{38c5f7}» {FFFFFF}Konum göndermek istediðiniz numarayý girin:", "Gönder", "Geri");
	    new targetid = GetNumberOwner(strval(inputtext));
	    if (targetid == INVALID_PLAYER_ID || targetid == playerid || PlayerData[targetid][pBaygin] > 0 || PlayerData[targetid][pKelepce] > 0 || PlayerData[targetid][pHapisSure] > 0 || PlayerData[targetid][pTelefonAyar][0] == 1)
	    {
	        HataMesajGonder(playerid, "Geçersiz numara girdiniz veya kiþi müsait deðil.");
	        return Dialog_Show(playerid, KonumGonder, DIALOG_STYLE_INPUT, "Konum Gönder", "{38c5f7}» {FFFFFF}Konum göndermek istediðiniz numarayý girin:", "Gönder", "Geri");
	    }
	    if (!spamProtect(playerid, "KonumGonder", 60)) return HataMesajGonder(playerid, "Tekrar konum göndermek için 1 dakika beklemelisiniz.");
	    PlayerData[playerid][pTarifeKalan][2] -= 15;
	    SetPVarInt(targetid, "KonumKabul", playerid);
	    MesajGonder(playerid, "%d numaralý telefona konumunuz gönderildi, sabit kalmaya çalýþýn.", strval(inputtext));
	    BilgiMesajGonder(targetid, "%d numaralý telefon size konumunu gönderdi, (\"/kabulet konum\") ile kabul edebilirsiniz.", PlayerData[playerid][pTelefon]);
	}
	return 1;
}
Dialog:FindBiz(playerid, response, listitem, inputtext[])
{
	if (!response) return Dialog_Show(playerid, GPS, DIALOG_STYLE_LIST, "GPS", "{38c5f7}» {FFFFFF}Global Lokasyonlar\n{38c5f7}» {FFFFFF}Ev Bul\n{38c5f7}» {FFFFFF}Ýþyeri Bul\n{38c5f7}» {FFFFFF}Bina Bul", "Seç", "Geri");
	if (response)
	{
	    if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return 1;
	    if (isnull(inputtext)) return Dialog_Show(playerid, FindBiz, DIALOG_STYLE_INPUT, "Ýþyeri Bul", "{38c5f7}» {FFFFFF}Lütfen bulmak istediðiniz iþyerinin adýný girin:", "Devam", "Geri");
	    FindBusiness(playerid, inputtext);
	}
	return 1;
}
Dialog:FindHouse(playerid, response, listitem, inputtext[])
{
	if (!response) return Dialog_Show(playerid, GPS, DIALOG_STYLE_LIST, "GPS", "{38c5f7}» {FFFFFF}Global Lokasyonlar\n{38c5f7}» {FFFFFF}Ev Bul\n{38c5f7}» {FFFFFF}Ýþyeri Bul\n{38c5f7}» {FFFFFF}Bina Bul", "Seç", "Geri");
	if (response)
	{
	    if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return 1;
	    if (isnull(inputtext)) return Dialog_Show(playerid, FindHouse, DIALOG_STYLE_INPUT, "Ev Bul", "{38c5f7}» {FFFFFF}Lütfen bulmak istediðiniz evin ID'sini girin:", "Devam", "Geri");
	    if (!IsNumeric(inputtext)) return Dialog_Show(playerid, FindHouse, DIALOG_STYLE_INPUT, "Ev Bul", "{38c5f7}» {FFFFFF}Lütfen bulmak istediðiniz evin ID'sini girin:", "Devam", "Geri");
	    new id = strval(inputtext);
	    if ((id < 0 || id >= MAX_EV) || !HouseInfo[id][evExists])
	    {
	        HataMesajGonder(playerid, "Bu ID'de bir ev bulunmuyor.");
	        return Dialog_Show(playerid, FindHouse, DIALOG_STYLE_INPUT, "Ev Bul", "{38c5f7}» {FFFFFF}Lütfen bulmak istediðiniz evin ID'sini girin:", "Devam", "Geri");
	    }
     	if (PlayerData[playerid][pGPS] != -1 || GetPVarInt(playerid, "IsyeriBuluyor") != -1 || GetPVarInt(playerid, "BinaBuluyor") != -1)
      	{
       		SetPVarInt(playerid, "IsyeriBuluyor", -1);
       		SetPVarInt(playerid, "BinaBuluyor", -1);
         	PlayerData[playerid][pGPS] = -1;
          	DisablePlayerCheckpoint(playerid);
       	}
       	callcmd::cpsifirla(playerid);

        SetPVarInt(playerid, "EvBuluyor", id);
        PlayerTextDrawShow(playerid, MesafeTD[playerid]);
        SetPlayerCheckpoint(playerid, HouseInfo[id][evPos][0], HouseInfo[id][evPos][1], HouseInfo[id][evPos][2], 4.0);
        MesajGonder(playerid, "Ev haritada iþaretlendi.");
	}
	return 1;
}
Dialog:GlobalLokasyonlar(playerid, response, listitem, inputtext[])
{
	if (!response) return Dialog_Show(playerid, GPS, DIALOG_STYLE_LIST, "GPS", "{38c5f7}» {FFFFFF}Global Lokasyonlar\n{38c5f7}» {FFFFFF}Ev Bul\n{38c5f7}» {FFFFFF}Ýþyeri Bul\n{38c5f7}» {FFFFFF}Bina Bul", "Seç", "Geri");
	if (response)
	{
	    new id = strval(inputtext);
	    if (Lokasyon[id][Exists] == true)
	    {
	        if (GetPVarInt(playerid, "EvBuluyor") != -1 || GetPVarInt(playerid, "IsyeriBuluyor") != -1 || GetPVarInt(playerid, "BinaBuluyor") != -1)
	        {
	            SetPVarInt(playerid, "IsyeriBuluyor", -1);
	            SetPVarInt(playerid, "EvBuluyor", -1);
	            SetPVarInt(playerid, "BinaBuluyor", -1);
	            DisablePlayerCheckpoint(playerid);
	        }
	        callcmd::cpsifirla(playerid);

	        PlayerData[playerid][pGPS] = id;
	        PlayerTextDrawShow(playerid, MesafeTD[playerid]);
	        SetPlayerCheckpoint(playerid, Lokasyon[id][lokasyonPos][0], Lokasyon[id][lokasyonPos][1], Lokasyon[id][lokasyonPos][2], 3.0);
	        MesajGonder(playerid, "'%s' adlý yer haritada iþaretlendi.", Lokasyon[id][lokasyonAd]);
	    }
	}
	return 1;
}
Dialog:EvBul(playerid, response, listitem, inputtext[])
{
	if (!response) return Dialog_Show(playerid, GPS, DIALOG_STYLE_LIST, "GPS", "{FFC100}» {FFFFFF}Global Lokasyonlar\n{FFC100}» {FFFFFF}Ev Bul\n{FFC100}» {FFFFFF}Ýþyeri Bul\n{FFC100}» {FFFFFF}Bina Bul", "Seç", "Geri");
	if (response)
	{
	    new id = strval(inputtext);
	    if (HouseInfo[id][evExists])
	    {
	        if (PlayerData[playerid][pGPS] != -1 || GetPVarInt(playerid, "IsyeriBuluyor") != -1 || GetPVarInt(playerid, "BinaBuluyor") != -1)
	        {
	            SetPVarInt(playerid, "IsyeriBuluyor", -1);
	            SetPVarInt(playerid, "BinaBuluyor", -1);
	            PlayerData[playerid][pGPS] = -1;
	            DisablePlayerCheckpoint(playerid);
	        }
	        callcmd::cpsifirla(playerid);

	        SetPVarInt(playerid, "EvBuluyor", id);
	        PlayerTextDrawShow(playerid, MesafeTD[playerid]);
	        SetPlayerCheckpoint(playerid, HouseInfo[id][evPos][0], HouseInfo[id][evPos][1], HouseInfo[id][evPos][2], 4.0);
	        MesajGonder(playerid, "Ev haritada iþaretlendi.");
	    }
	}
	return 1;
}
Dialog:IsyeriBul(playerid, response, listitem, inputtext[])
{
	if (!response) return Dialog_Show(playerid, GPS, DIALOG_STYLE_LIST, "GPS", "{FFC100}» {FFFFFF}Global Lokasyonlar\n{FFC100}» {FFFFFF}Ev Bul\n{FFC100}» {FFFFFF}Ýþyeri Bul\n{38c5f7}» {FFFFFF}Bina Bul", "Seç", "Geri");
	if (response)
	{
	    new id = strval(inputtext);
	    if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return 1;
	    if (Isyeri[id][isyeriExists])
	    {
	        if (PlayerData[playerid][pGPS] != -1 || GetPVarInt(playerid, "EvBuluyor") != -1 || GetPVarInt(playerid, "BinaBuluyor") != -1)
	        {
	            SetPVarInt(playerid, "EvBuluyor", -1);
	            SetPVarInt(playerid, "BinaBuluyor", -1);
	            PlayerData[playerid][pGPS] = -1;
	            DisablePlayerCheckpoint(playerid);
	        }
	        callcmd::cpsifirla(playerid);

	        SetPVarInt(playerid, "IsyeriBuluyor", id);
	        PlayerTextDrawShow(playerid, MesafeTD[playerid]);
	        SetPlayerCheckpoint(playerid, Isyeri[id][isyeriPos][0], Isyeri[id][isyeriPos][1], Isyeri[id][isyeriPos][2], 4.0);
	        MesajGonder(playerid, "Ýþyeri haritada iþaretlendi.");
	    }
	}
	return 1;
}
Dialog:MuzikCalar(playerid, response, listitem, inputtext[])
{
	if (!response) return Dialog_Show(playerid, Tarayici, DIALOG_STYLE_LIST, "Telefon ~ Tarayýcý", "{FFC100}» {FFFFFF}Araç Ýlanlarý\n{FFC100}» {FFFFFF}BitCoin\n{FFC100}» {FFFFFF}Müzik Çalar\n{FFC100}» {FFFFFF}Konum Gönder", "Seç", "Kapat");
	if (response)
	{
	    if (isnull(inputtext) || strlen(inputtext) < 5) return Dialog_Show(playerid, MuzikCalar, DIALOG_STYLE_INPUT, "Tarayýcý ~ Müzik Çalar", "{FFC100}» {FFFFFF}Lütfen oynatmak istediðiniz müziðin .mp3 uzantýlý linkini girin:", "Oynat", "Geri");
	    PlayAudioStreamForPlayer(playerid, inputtext);
	    PlayerData[playerid][pTarifeKalan][2] -= 10;
	}
	return 1;
}
Dialog:BitCoin(playerid, response, listitem, inputtext[])
{
	if (!response) return Dialog_Show(playerid, Tarayici, DIALOG_STYLE_LIST, "Telefon ~ Tarayýcý", "{FFC100}» {FFFFFF}Araç Ýlanlarý\n{FFC100}» {FFFFFF}BitCoin\n{FFC100}» {FFFFFF}Müzik Çalar\n{FFC100}» {FFFFFF}Konum Gönder", "Seç", "Kapat");
	if (response)
	{
	    if (listitem == 0)
	    {
	        Dialog_Show(playerid, BitcoinAl, DIALOG_STYLE_INPUT, "{FFFFFF}BitCoin Alma", "{FFC100}» {FFFFFF}Lütfen almak istediðiniz BitCoin sayýsýný girin:", "Al", "Geri");
	    }
	    if (listitem == 1)
	    {
	        Dialog_Show(playerid, BitcoinSat, DIALOG_STYLE_INPUT, "{FFFFFF}BitCoin Sat", "{FFC100}» {FFFFFF}Lütfen satmak istediðiniz BitCoin sayýsýný girin:", "Sat", "Geri");
	    }
	}
	return 1;
}
Dialog:BitcoinSat(playerid, response, listitem, inputtext[])
{
	if (!response) return Bitcoin_Menu(playerid);
	if (response)
	{
        if (isnull(inputtext)) return Dialog_Show(playerid, BitcoinSat, DIALOG_STYLE_INPUT, "{FFFFFF}BitCoin Sat", "{FFC100}» {FFFFFF}Lütfen satmak istediðiniz BitCoin sayýsýný girin:", "Sat", "Geri");
        if (!IsNumeric(inputtext)) return Dialog_Show(playerid, BitcoinSat, DIALOG_STYLE_INPUT, "{FFFFFF}BitCoin Sat", "{FFC100}» {FFFFFF}Lütfen satmak istediðiniz BitCoin sayýsýný girin:", "Sat", "Geri");
        if (strval(inputtext) <= 0) return Dialog_Show(playerid, BitcoinSat, DIALOG_STYLE_INPUT, "{FFFFFF}BitCoin Sat", "{FFC100}» {FFFFFF}Lütfen satmak istediðiniz BitCoin sayýsýný girin:", "Sat", "Geri");
        if (PlayerData[playerid][pBitcoin] < strval(inputtext))
        {
            HataMesajGonder(playerid, "O kadar BitCoin'iniz bulunmuyor.");
            return Dialog_Show(playerid, BitcoinSat, DIALOG_STYLE_INPUT, "{FFFFFF}BitCoin Sat", "{FFC100}» {FFFFFF}Lütfen satmak istediðiniz BitCoin sayýsýný girin:", "Sat", "Geri");
        }
        PlayerData[playerid][pBitcoin] -= strval(inputtext);
        ParaVer(playerid, strval(inputtext)*GetServerBilgi("BitcoinSatma"));
        PlayerData[playerid][pTarifeKalan][2] -= RandomEx(3, 9);
	    if (PlayerData[playerid][pTarifeKalan][2] < 0) PlayerData[playerid][pTarifeKalan][2] = 0;
	    Oyuncu_Kaydet(playerid);
	    MesajGonder(playerid, "{FFC100}%d {FFFFFF}BitCoin {FFC100}%s {FFFFFF}karþýlýðýnda satýldý.",strval(inputtext), FormatNumber(strval(inputtext)*GetServerBilgi("BitcoinSatma")));
	}
	return 1;
}
Dialog:BitcoinAl(playerid, response, listitem, inputtext[])
{
	if (!response) return Bitcoin_Menu(playerid);
	if (response)
	{
	    if (isnull(inputtext)) return Dialog_Show(playerid, BitcoinAl, DIALOG_STYLE_INPUT, "{FFFFFF}BitCoin Alma", "{FFC100}» {FFFFFF}Lütfen almak istediðiniz BitCoin sayýsýný girin:", "Al", "Geri");
	    if (!IsNumeric(inputtext)) return Dialog_Show(playerid, BitcoinAl, DIALOG_STYLE_INPUT, "{FFFFFF}BitCoin Alma", "{FFC100}» {FFFFFF}Lütfen almak istediðiniz BitCoin sayýsýný girin:", "Al", "Geri");
	    if (strval(inputtext) <= 0 || strval(inputtext) >= 1001)
	    {
	        HataMesajGonder(playerid, "BitCoin sayýsý 1 ile 1000 arasýnda olmalýdýr.");
	        return Dialog_Show(playerid, BitcoinAl, DIALOG_STYLE_INPUT, "{FFFFFF}BitCoin Alma", "{FFC100}» {FFFFFF}Lütfen almak istediðiniz BitCoin sayýsýný girin:", "Al", "Geri");
	    }
	    if (PlayerData[playerid][pCash] < strval(inputtext)*GetServerBilgi("BitcoinAlma"))
	    {
	        HataMesajGonder(playerid, "Yeterli paranýz yok.");
	        return Dialog_Show(playerid, BitcoinAl, DIALOG_STYLE_INPUT, "{FFFFFF}BitCoin Alma", "{FFC100}» {FFFFFF}Lütfen almak istediðiniz BitCoin sayýsýný girin:", "Al", "Geri");
	    }
	    PlayerData[playerid][pTarifeKalan][2] -= RandomEx(5, 12);
	    if (PlayerData[playerid][pTarifeKalan][2] < 0) PlayerData[playerid][pTarifeKalan][2] = 0;
	    ParaVer(playerid, -strval(inputtext)*GetServerBilgi("BitcoinAlma"));
	    PlayerData[playerid][pBitcoin] += strval(inputtext);
	    Oyuncu_Kaydet(playerid);
	    MesajGonder(playerid, "{FFC100}%s {FFFFFF}ödeyerek {FFC100}%d {FFFFFF}BitCoin satýn aldýnýz.", FormatNumber(strval(inputtext)*GetServerBilgi("BitcoinAlma")), strval(inputtext));
	}
	return 1;
}
Dialog:AracIlanlari(playerid, response, listitem, inputtext[])
{
	if (!response) return Telefon_Menu(playerid);
	if (response)
	{
	    if (PlayerData[playerid][pTarife] == -1 || PlayerData[playerid][pTarifeKalan][2] <= 2) return HataMesajGonder(playerid, "Tarifeniz yok veya internet paketiniz yetmiyor.");
	    if (isnull(inputtext)) return Dialog_Show(playerid, AracIlanlari, DIALOG_STYLE_INPUT, "{FFFFFF}Araç Ýlanlarý", "{38c5f7}» {FFFFFF}Lütfen aratmak istediðiniz aracýn modelini veya adýný girin:", "Ara", "Geri");
		new veh = GetVehicleModelIDFromName(inputtext);
		if (veh != -1)
		{
  			PlayerData[playerid][pTarifeKalan][2] -= 3;
		    AracIlanlari(playerid, veh);
		    return 1;
		}
		if (strval(inputtext) >= 411 && strval(inputtext) <= 611)
		{
		    PlayerData[playerid][pTarifeKalan][2] -= 3;
		    AracIlanlari(playerid, strval(inputtext));
		    return 1;
		}
		HataMesajGonder(playerid, "Aradýðýnýz kriterlerde araç bulunamadý.");
		Dialog_Show(playerid, AracIlanlari, DIALOG_STYLE_INPUT, "{FFFFFF}Araç Ýlanlarý", "{FFC100}» {FFFFFF}Lütfen aratmak istediðiniz aracýn modelini veya adýný girin:", "Ara", "Geri");
	}
	return 1;
}
Dialog:SatilikAraclar(playerid, response, listitem, inputtext[])
{
	if (!response) return Dialog_Show(playerid, AracIlanlari, DIALOG_STYLE_INPUT, "{FFFFFF}Araç Ýlanlarý", "{FFC100}» {FFFFFF}Lütfen aratmak istediðiniz aracýn modelini veya adýný girin:", "Ara", "Geri");
	if (response)
	{
	    if (PlayerData[playerid][pTarifeKalan][2] < 3) return HataMesajGonder(playerid, "Tarifeniz yok veya internet paketiniz yetmiyor.");
	    new id = strval(inputtext);
	    if (AracInfo[id][aracExists])
	    {
	        if (AracInfo[id][aracDisplay] == 0)
	        {
	            HataMesajGonder(playerid, "Aracýn yeri tespit edilemedi.");
	            return AracIlanlari(playerid, AracInfo[id][aracModel]);
	        }
	        if (GetVehicleVirtualWorld(AracInfo[id][aracVehicle]) != GetPlayerVirtualWorld(playerid))
	        {
	            HataMesajGonder(playerid, "Aracýn yeri tespit edilemedi.");
	            return AracIlanlari(playerid, AracInfo[id][aracModel]);
	        }
	        callcmd::cpsifirla(playerid);

	        new Float:pos[3];
	        GetVehiclePos(AracInfo[id][aracVehicle], pos[0], pos[1], pos[2]);
	        SetPVarInt(playerid, "AraciniBuluyor", 1);
	        SetPlayerCheckpoint(playerid, pos[0], pos[1], pos[2], 5.0);
	        MesajGonder(playerid, "Aracýn yeri haritada iþaretlendi.");
	        PlayerData[playerid][pTarifeKalan][2] -= 3;
	    }
	}
	return 1;
}
Dialog:Tarifem(playerid, response, listitem, inputtext[])
{
	if (!response) return Telefon_Menu(playerid);
	if (response)
	{
		if (listitem == 4)
		{
			PlayerData[playerid][pTarife] = -1;
			PlayerData[playerid][pTarifeKalan][0] = 0;
			PlayerData[playerid][pTarifeKalan][1] = 0;
			PlayerData[playerid][pTarifeKalan][2] = 0;
			PlayerData[playerid][pTarifeSure] = 0;
			Oyuncu_Kaydet(playerid);
			MesajGonder(playerid, "Tarifeniz iptal edildi.");
			Telefon_Menu(playerid);
		}
	}
	return 1;
}
Dialog:SMSGonder(playerid, response, listitem, inputtext[])
{
	if (!response) return Telefon_Menu(playerid);
	if (response)
	{
		if (isnull(inputtext)) return Dialog_Show(playerid, SMSGonder, DIALOG_STYLE_INPUT, "SMS Yolla", "Lütfen SMS yollamak istediðiniz numarayý girin:", "Devam", "Geri");
		if (!IsNumeric(inputtext)) return Dialog_Show(playerid, SMSGonder, DIALOG_STYLE_INPUT, "SMS Yolla", "Lütfen SMS yollamak istediðiniz numarayý girin:", "Devam", "Geri");
		if (strval(inputtext) == 911 || strval(inputtext) == 121 || strval(inputtext) == 555)
		{
			HataMesajGonder(playerid, "Bu numaraya SMS gönderemezsiniz.");
			return Dialog_Show(playerid, SMSGonder, DIALOG_STYLE_INPUT, "SMS Yolla", "Lütfen SMS yollamak istediðiniz numarayý girin:", "Devam", "Geri");
		}
		new targetid = GetNumberOwner(strval(inputtext));
		if (targetid == INVALID_PLAYER_ID || targetid == playerid || Jammer_Near(targetid) == 1)
		{
			HataMesajGonder(playerid, "Geçersiz numara girdiniz.");
			return Dialog_Show(playerid, SMSGonder, DIALOG_STYLE_INPUT, "SMS Yolla", "Lütfen SMS yollamak istediðiniz numarayý girin:", "Devam", "Geri");
		}
		if (PlayerData[targetid][pTelefonAyar][0] == 1 || PlayerData[targetid][pTelefonAyar][4] == 1)
		{
			HataMesajGonder(playerid, "Bu numara SMS alýmlarýný kapatmýþ.");
			return Dialog_Show(playerid, SMSGonder, DIALOG_STYLE_INPUT, "SMS Yolla", "Lütfen SMS yollamak istediðiniz numarayý girin:", "Devam", "Geri");
		}
		SetPVarInt(playerid, "SMSNumara", strval(inputtext));
		Dialog_Show(playerid, SMSGonder2, DIALOG_STYLE_INPUT, "SMS Yolla", "Lütfen göndermek istediðiniz mesajý girin:", "Gönder", "Kapat");
		/*SendClientMessageEx(targetid, COLOR_YELLOW, "[SMS]: %s - %s", text, TelNo(targetid, playerid));
		SendClientMessageEx(playerid, COLOR_YELLOW, "[SMS]: %s - %s", text, TelNo(targetid, playerid));

        PlayerPlaySoundEx(targetid, 21001);*/
	}
	return 1;
}
Dialog:SMSGonder2(playerid, response, listitem, inputtext[])
{
	if (!response)
	{
		DeletePVar(playerid, "SMSNumara");
		Dialog_Show(playerid, SMSGonder, DIALOG_STYLE_INPUT, "SMS Yolla", "Lütfen SMS yollamak istediðiniz numarayý girin:", "Devam", "Geri");
	}
	if (response)
	{
		if (isnull(inputtext)) return Dialog_Show(playerid, SMSGonder2, DIALOG_STYLE_INPUT, "SMS Yolla", "Lütfen göndermek istediðiniz mesajý girin:", "Gönder", "Kapat");
		if (strlen(inputtext) < 3 || strlen(inputtext) > 128)
		{
			HataMesajGonder(playerid, "Mesaj uzunluðu 3 ile 128 karakter arasýnda olmalýdýr.");
			return Dialog_Show(playerid, SMSGonder2, DIALOG_STYLE_INPUT, "SMS Yolla", "Lütfen göndermek istediðiniz mesajý girin:", "Gönder", "Kapat");
		}
		new targetid = GetNumberOwner(GetPVarInt(playerid, "SMSNumara"));
		if (targetid == INVALID_PLAYER_ID)
		{
			HataMesajGonder(playerid, "Geçersiz numara girdiniz.");
			DeletePVar(playerid, "SMSNumara");
			return 1;
		}
		if (PlayerData[targetid][pTelefonAyar][0] == 1 || PlayerData[targetid][pTelefonAyar][4] == 1)
		{
			HataMesajGonder(playerid, "Bu numara SMS alýmlarýný kapatmýþ.");
			DeletePVar(playerid, "SMSNumara");
			return 1;
		}
		PlayerData[playerid][pTarifeKalan][1]--;
		DeletePVar(playerid, "SMSNumara");
		SendClientMessageEx(targetid, COLOR_YELLOW, "[SMS]: %s - %s", inputtext, TelNo(targetid, playerid));
		SendClientMessageEx(playerid, COLOR_YELLOW, "[SMS]: %s - %s", inputtext, ReturnName(playerid, 0));

        PlayerPlaySoundEx(targetid, 21001);

	}
	return 1;
}
Dialog:Arama(playerid, response, listitem, inputtext[])
{
	if (!response) return Telefon_Menu(playerid);
	if (response)
	{
	    if (PlayerData[playerid][pAramada] != 0) return HataMesajGonder(playerid, "Þu an aramada olduðunuz için kimseyi arayamazsýnýz.");
	    if (isnull(inputtext)) return Dialog_Show(playerid, Arama, DIALOG_STYLE_INPUT, "Arama", "Lütfen aramak istediðiniz numarayý girin:\n\n{38c5f7}Acil durum hattý 911, taksi hattý 333.", "Ara", "Geri");
	    if (!IsNumeric(inputtext)) return Dialog_Show(playerid, Arama, DIALOG_STYLE_INPUT, "Arama", "Lütfen aramak istediðiniz numarayý girin:\n\n{38c5f7}Acil durum hattý 911, taksi hattý 333.", "Ara", "Geri");
	    if (strval(inputtext) == PlayerData[playerid][pTelefon])
	    {
	        HataMesajGonder(playerid, "Kendinizi aramayazsýnýz.");
	        return Dialog_Show(playerid, Arama, DIALOG_STYLE_INPUT, "Arama", "Lütfen aramak istediðiniz numarayý girin:\n\n{38c5f7}Acil durum hattý 911, taksi hattý 333. ", "Ara", "Geri");
	    }
	    if (strval(inputtext) == 555)
	    {
	    	new string[750], sayi;
	    	for (new i; i<sizeof(Tarifeler); i++)
	    	{
	    		sayi++;
	    		format(string, sizeof(string), "%s{FFFFFF}%s {FFC100}(%s){FFFFFF} - %d dakika / %d SMS / %d MB\n", string, Tarifeler[i][TarifeAdi], FormatNumber(Tarifeler[i][TarifeFiyat]), Tarifeler[i][TarifeDakika], Tarifeler[i][TarifeSMS], Tarifeler[i][TarifeNet]);
	    	}
	    	if (sayi == 0) return HataMesajGonder(playerid, "Hiç tarife yok.");
	    	Dialog_Show(playerid, Tarifeler, DIALOG_STYLE_LIST, "Tarifeci", string, "Seç", "Kapat");
	    	return 1;
	    }
	    if (strval(inputtext) == 911)
	    {
	        if (!spamProtect(playerid, "AcilDurum", 120)) return HataMesajGonder(playerid, "Tekrar ihbar vermek için 2 dakika beklemelisiniz.");
	        Dialog_Show(playerid, HizmetSecin, DIALOG_STYLE_LIST, "{FFFFFF}Operatör ~ Hizmet Seçin:", "{9189EF}Los Santos Polis Departmaný\n{FF8282}Los Santos Medical Department", "Seç", "Kapat");
	        return 1;
	    }
	    if (strval(inputtext) == 333)
    	{
	        PlayerData[playerid][pTaxiCalled] = 1;
	        PlayerPlaySound(playerid, 3600, 0.0, 0.0, 0.0);
	        SendNearbyMessage(playerid, 30.0, 0xFFC10000, "** %s {ffffff}telefonunda bir kaç numara tuþlar.", ReturnName(playerid, 0));
	        MesajGonder(playerid, "Taksi çaðýrdýnýz, lütfen bekleyin...");
	        new Float:pos[3];
	        GetPlayerPosEx(playerid, pos[0], pos[1], pos[2]);
	        foreach (new i:Player) if (GetPlayerState(i) == PLAYER_STATE_DRIVER && PlayerData[i][pTaxiDuty] == true)
	        {
	            SendClientMessageEx(i, 0x42f445FF, "%s adlý kiþi %s bölgesine taksi talep ediyor.", ReturnName(playerid, 0), GetLocation(pos[0], pos[1], pos[2]));
	        }
	        return 1;
    	}
	    if (PlayerData[playerid][pTarife] == -1 || PlayerData[playerid][pTarifeKalan][0] == 0)
		{
		    HataMesajGonder(playerid, "Tarifeniz yok veya tarifenizde dakika kalmamýþ.");
		    return Dialog_Show(playerid, Arama, DIALOG_STYLE_INPUT, "Arama", "Lütfen aramak istediðiniz numarayý girin:\n\n{38c5f7}911 - Acil Durum | 333 - Taksi ", "Ara", "Geri");
		}
	    new targetid = GetNumberOwner(strval(inputtext));
	    if (targetid == INVALID_PLAYER_ID || targetid == playerid || PlayerData[targetid][pBaygin] > 0 || PlayerData[targetid][pKelepce] > 0 || PlayerData[targetid][pHapisSure] > 0 || PlayerData[targetid][pTelefonAyar][0] == 1 || PlayerData[targetid][pTelefonAyar][5] == 1 || Jammer_Near(targetid) == 1) return HataMesajGonder(playerid, "Aradýðýnýz numaraya þu anda ulaþýlamýyor, lütfen daha sonra tekrar deneyiniz.");
	    if (PlayerData[targetid][pAramada] != 0) return HataMesajGonder(playerid, "Meþgül tonu aldýn...");
	    if (PlayerData[targetid][pTelefonAyar][3] == 1 && !RehberdeVar(targetid, PlayerData[playerid][pTelefon])) return HataMesajGonder(playerid, "Bu numara bilinmeyen numaralarý engellemiþ.");
	    PlayerData[playerid][pAramada] = ARAMA_ARIYOR;
	    PlayerData[targetid][pAramada] = ARAMA_ARANIYOR;
	    PlayerData[playerid][pCallLine] = targetid;
	    PlayerData[targetid][pCallLine] = playerid;
	    SetPVarInt(playerid, "Arayan", 1);
	    MesajGonder(playerid, "Numara aranýyor, lütfen cevap vermesini bekleyin. /cagrikapat ile çaðrýyý bitirebilirsiniz.");
	    SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s telefonunda bir kaç numara tuþlar.", ReturnName(playerid, 0));
	    BilgiMesajGonder(targetid, "Gelen Arama: %s  - /cagrikabul ile çaðrýyý kabul edebilir, /cagrikapat ile çaðrýyý kapatabilirsiniz.", TelNo(targetid, playerid));
	    PlayerPlaySound(playerid, 3600, 0.0, 0.0, 0.0);
	    if (PlayerData[targetid][pTelefonAyar][1]) SendNearbyMessage(targetid, 30.0, COLOR_CYAN, "** Telefonu titremektedir. (( %s ))", ReturnName(targetid, 0));
	    else
		{
			SendNearbyMessage(targetid, 30.0, COLOR_CYAN, "** Telefon çalmaktadýr. (( %s ))", ReturnName(targetid, 0));
            PlayerPlaySoundEx(targetid, 23000);
		}
	}
	return 1;
}
Dialog:Tarifeler(playerid, response, listitem, inputtext[])
{
	if (!response) return Telefon_Menu(playerid);
	if (response)
	{
		if (PlayerData[playerid][pTarife] != -1) return HataMesajGonder(playerid, "Zaten tarifeniz var, mevcut tarifenizi iptal etmelisiniz.");
		if (PlayerData[playerid][pCash] < Tarifeler[listitem][TarifeFiyat]) return HataMesajGonder(playerid, "Bu tarifeyi almak için yeterli paranýz yok.");
		ParaVer(playerid, -Tarifeler[listitem][TarifeFiyat]);
		PlayerData[playerid][pTarife] = listitem;
		PlayerData[playerid][pTarifeKalan][0] = Tarifeler[listitem][TarifeDakika];
		PlayerData[playerid][pTarifeKalan][1] = Tarifeler[listitem][TarifeSMS];
		PlayerData[playerid][pTarifeKalan][2] = Tarifeler[listitem][TarifeNet];
		PlayerData[playerid][pTarifeSure] = gettime()+7*86400;
		Oyuncu_Kaydet(playerid);
		MesajGonder(playerid, "{DB0000}%s {FFFFFF}adlý tarifeyi satýn aldýnýz, 1 ay boyunca kullanabilirsiniz.", Tarifeler[listitem][TarifeAdi]);
	}
	return 1;
}
Dialog:TelefonRehber(playerid, response, listitem, inputtext[])
{
	if (!response) return Telefon_Menu(playerid), DeletePVar(playerid, "RehberSayi");
	if (response)
	{
		if (listitem == GetPVarInt(playerid, "RehberSayi"))
		{
            new rehbersayi = 15;
		    switch (PlayerData[playerid][pVip])
		    {
		        case 1: rehbersayi += 10;
		        case 2: rehbersayi += 20;
		        case 3: rehbersayi += 25;
		    }
			if (GetPVarInt(playerid, "RehberSayi") >= rehbersayi)
			{
				Telefon_Rehber(playerid);
				return HataMesajGonder(playerid, "Telefon rehberine en fazla %d kiþi ekleyebilirsiniz.", rehbersayi);
			}
			else
			{
				Dialog_Show(playerid, RehberEkle, DIALOG_STYLE_INPUT, "Kiþi Ekle", "{FFFFFF}Lütfen rehberinize eklemek istediðiniz numarayý girin:", "Devam", "Geri");
			}
		}
		else
		{
			new number = RehberListeleme[playerid][listitem];
			if (number != 0)
			{
				SetPVarInt(playerid, "RehberNumber", number);
				Dialog_Show(playerid, RehberAyar, DIALOG_STYLE_LIST, "Rehber", "{FFC100}» {FFFFFF}Ara\n{38c5f7}» {FFFFFF}SMS Yolla\n{38c5f7}» {FFFFFF}Sil", "Seç", "Geri");
			}
		}
	}
	return 1;
}
Dialog:RehberAyar(playerid, response, listitem, inputtext[])
{
	if (!response) Telefon_Rehber(playerid);
	if (response)
	{
		if (listitem == 0)
		{
			new targetid = GetNumberOwner(GetPVarInt(playerid, "RehberNumber"));
			if (PlayerData[playerid][pAramada] != 0) return HataMesajGonder(playerid, "Þu an aramada olduðunuz için kimseyi arayamazsýnýz.");
			if (targetid == INVALID_PLAYER_ID || /*targetid == playerid ||*/ PlayerData[targetid][pBaygin] > 0 || PlayerData[targetid][pKelepce] > 0 || PlayerData[targetid][pHapisSure] > 0 || PlayerData[targetid][pTelefonAyar][0] == 1 || PlayerData[targetid][pTelefonAyar][5] == 1 || Jammer_Near(targetid) == 1)
			{
				Telefon_Rehber(playerid);
				return HataMesajGonder(playerid, "Aradýðýnýz numaraya þu anda ulaþýlamýyor, lütfen daha sonra tekrar deneyiniz.");
			}
			if (PlayerData[playerid][pTarife] == -1 || PlayerData[playerid][pTarifeKalan][0] == 0)
			{
			    HataMesajGonder(playerid, "Tarifeniz yok veya tarifenizde dakika kalmamýþ, Elektronik maðzasýndan satýn alabilirsiniz.");
			    return Telefon_Rehber(playerid);
			}
			if (PlayerData[targetid][pAramada] != 0)
			{
				Telefon_Rehber(playerid);
				return HataMesajGonder(playerid, "Mesgul tonu aldýn...");
			}
			PlayerData[playerid][pAramada] = ARAMA_ARIYOR;
		    PlayerData[targetid][pAramada] = ARAMA_ARANIYOR;
		    PlayerData[playerid][pCallLine] = targetid;
		    PlayerData[targetid][pCallLine] = playerid;
		    SetPVarInt(playerid, "Arayan", 1);
		    SetPVarInt(targetid, "Arayan", 0);
		    MesajGonder(playerid, "Numara aranýyor, lütfen cevap vermesini bekleyin. /cagrikapat ile çaðrýyý bitirebilirsiniz.");
		    SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s telefonunda bir kaç numara tuþlar.", ReturnName(playerid, 0));
		    BilgiMesajGonder(targetid, "Gelen Arama: %s  - /cagrikabul ile çaðrýyý kabul edebilir, /cagrikapat ile çaðrýyý kapatabilirsiniz.", TelNo(targetid, playerid));
		    PlayerPlaySound(playerid, 3600, 0.0, 0.0, 0.0);
		    if (PlayerData[targetid][pTelefonAyar][1]) SendNearbyMessage(targetid, 30.0, COLOR_CYAN, "** Telefonu titremektedir. (( %s ))", ReturnName(targetid, 0));
		    else
			{
				SendNearbyMessage(targetid, 30.0, COLOR_CYAN, "** Telefon çalmaktadýr. (( %s ))", ReturnName(targetid, 0));
	            PlayerPlaySoundEx(targetid, 23000);
			}
			DeletePVar(playerid, "RehberSayi");
			DeletePVar(playerid, "RehberNumber");

		}
		if (listitem == 1)
		{
		    if (PlayerData[playerid][pTarife] == -1 || PlayerData[playerid][pTarifeKalan][1] == 0)
	 		{
	 		    HataMesajGonder(playerid, "Tarifeniz yok veya sms hakkýnýz bitmiþ.");
			 	return Telefon_Rehber(playerid);
	 		}
			new targetid = GetNumberOwner(GetPVarInt(playerid, "RehberNumber"));
			if (targetid == INVALID_PLAYER_ID || targetid == playerid || Jammer_Near(targetid) == 1)
			{
				HataMesajGonder(playerid, "Bu numaraya þu anda ulaþýlamýyor.");
				Telefon_Rehber(playerid);
				return 1;
			}
			if (PlayerData[targetid][pTelefonAyar][0] == 1 || PlayerData[targetid][pTelefonAyar][4] == 1)
			{
				HataMesajGonder(playerid, "Bu numara sms almýyor.");
				return Telefon_Rehber(playerid);
			}
			SetPVarInt(playerid, "SMSNumara", GetPVarInt(playerid, "RehberNumber"));
			Dialog_Show(playerid, SMSGonder2, DIALOG_STYLE_INPUT, "Telefon ~ SMS Gönder", "Lütfen göndermek istediðiniz mesajý girin:", "Gönder", "Kapat");
		}
		if (listitem == 2)
		{
			new query[124];
			format(query, sizeof(query), "DELETE FROM `rehber` WHERE `Numara` = '%d' AND `RehberNumara` = '%d'", PlayerData[playerid][pTelefon], GetPVarInt(playerid, "RehberNumber"));
			mysql_query(g_SQL, query, false);
			DeletePVar(playerid, "RehberNumber");
			Telefon_Rehber(playerid);
		}
	}
	return 1;
}
Dialog:RehberEkle(playerid, response, listitem, inputtext[])
{
	if (!response) return Telefon_Rehber(playerid);
	if (response)
	{
		if (isnull(inputtext)) return Dialog_Show(playerid, RehberEkle, DIALOG_STYLE_INPUT, "Kiþi Ekle", "{FFFFFF}Lütfen rehberinize eklemek istediðiniz numarayý girin:", "Devam", "Geri");
		if (!IsNumeric(inputtext)) return Dialog_Show(playerid, RehberEkle, DIALOG_STYLE_INPUT, "Kiþi Ekle", "{FFFFFF}Lütfen rehberinize eklemek istediðiniz numarayý girin:", "Devam", "Geri");
		if (strval(inputtext) == 911 || strval(inputtext) == 121 || strval(inputtext) == 555) return Dialog_Show(playerid, RehberEkle, DIALOG_STYLE_INPUT, "Kiþi Ekle", "{FFFFFF}Lütfen rehberinize eklemek istediðiniz numarayý girin:", "Devam", "Geri");
		if (RehberdeVar(playerid, strval(inputtext))) return Dialog_Show(playerid, RehberEkle, DIALOG_STYLE_INPUT, "Kiþi Ekle", "{FFFFFF}Lütfen rehberinize eklemek istediðiniz numarayý girin:", "Devam", "Geri");
		if (strval(inputtext) == PlayerData[playerid][pTelefon])
		{
		    HataMesajGonder(playerid, "Kendi numaranýzý ekleyemezsiniz.");
		    return Dialog_Show(playerid, RehberEkle, DIALOG_STYLE_INPUT, "Kiþi Ekle", "{FFFFFF}Lütfen rehberinize eklemek istediðiniz numarayý girin:", "Devam", "Geri");
		}
		SetPVarInt(playerid, "RehberNumara", strval(inputtext));
		Dialog_Show(playerid, RehberEkleAd, DIALOG_STYLE_INPUT, "Kiþi Ekle", "{FFFFFF}Lütfen kiþinin ismini girin:", "Devam", "Geri");
	}
	return 1;
}
Dialog:RehberEkleAd(playerid, response, listitem, inputtext[])
{
	if (!response) return Dialog_Show(playerid, RehberEkle, DIALOG_STYLE_INPUT, "Kiþi Ekle", "{FFFFFF}Lütfen rehberinize eklemek istediðiniz numarayý girin:", "Devam", "Geri");
	if (response)
	{
		if (isnull(inputtext)) return Dialog_Show(playerid, RehberEkleAd, DIALOG_STYLE_INPUT, "Kiþi Ekle", "{FFFFFF}Lütfen kiþinin ismini girin:", "Devam", "Geri");
		new query[300];
		format(query, sizeof(query), "INSERT INTO `rehber` (`Numara`, `RehberNumara`, `Isim`, `Tarih`) VALUES ('%d', '%d', '%s', '%s')", PlayerData[playerid][pTelefon],GetPVarInt(playerid, "RehberNumara"), SQL_ReturnEscaped(inputtext), ReturnDate());
		mysql_query(g_SQL, query, false);
		DeletePVar(playerid, "RehberNumara");
		MesajGonder(playerid, "Rehberinize '%s' adli kiþi eklenmiþtir.", inputtext);
		Telefon_Rehber(playerid);
	}
	return 1;
}
Dialog:TelefonAyarlar(playerid, response, listitem, inputtext[])
{
	if (!response) return Telefon_Menu(playerid);
	if (response)
	{
	    switch (listitem)
	    {
	        case 0:
	        {
	            if (PlayerData[playerid][pTelefonAyar][1] == 0) PlayerData[playerid][pTelefonAyar][1] = 1;
	            else PlayerData[playerid][pTelefonAyar][1] = 0;
	            Dialog_Show(playerid, TelefonAyarlar, DIALOG_STYLE_LIST, "Telefon ~ Ayarlar", "{38c5f7}» {FFFFFF}Titreþim:\t\t%s\n{38c5f7}» {FFFFFF}Hoparlör:\t\t%s\n{38c5f7}» {FFFFFF}Bilinmeyen Numara Engeli:\t%s\n{38c5f7}» {FFFFFF}SMS Engeli:\t\t%s\n{38c5f7}» {FFFFFF}Arama Engeli:\t\t%s", "Seç", "Geri",(PlayerData[playerid][pTelefonAyar][1] == 0) ? ("{F22C2C}Kapalý") : ("{2CF26B}Açýk"),
				(PlayerData[playerid][pTelefonAyar][2] == 0) ? ("{F22C2C}Kapalý") : ("{2CF26B}Açýk"),  (PlayerData[playerid][pTelefonAyar][3] == 0) ? ("{F22C2C}Kapalý") : ("{2CF26B}Açýk"),  (PlayerData[playerid][pTelefonAyar][4] == 0) ? ("{F22C2C}Kapalý") : ("{2CF26B}Açýk"), (PlayerData[playerid][pTelefonAyar][5] == 0) ? ("{F22C2C}Kapalý") : ("{2CF26B}Açýk"));
	        }
	        case 1:
	        {
	            if (PlayerData[playerid][pTelefonAyar][2] == 0) PlayerData[playerid][pTelefonAyar][2] = 1;
	            else PlayerData[playerid][pTelefonAyar][2] = 0;
	            Dialog_Show(playerid, TelefonAyarlar, DIALOG_STYLE_LIST, "Telefon ~ Ayarlar", "{38c5f7}» {FFFFFF}Titreþim:\t\t%s\n{38c5f7}» {FFFFFF}Hoparlör:\t\t%s\n{38c5f7}» {FFFFFF}Bilinmeyen Numara Engeli:\t%s\n{38c5f7}» {FFFFFF}SMS Engeli:\t\t%s\n{38c5f7}» {FFFFFF}Arama Engeli:\t\t%s", "Seç", "Geri",(PlayerData[playerid][pTelefonAyar][1] == 0) ? ("{F22C2C}Kapalý") : ("{2CF26B}Açýk"),
				(PlayerData[playerid][pTelefonAyar][2] == 0) ? ("{F22C2C}Kapalý") : ("{2CF26B}Açýk"),  (PlayerData[playerid][pTelefonAyar][3] == 0) ? ("{F22C2C}Kapalý") : ("{2CF26B}Açýk"),  (PlayerData[playerid][pTelefonAyar][4] == 0) ? ("{F22C2C}Kapalý") : ("{2CF26B}Açýk"), (PlayerData[playerid][pTelefonAyar][5] == 0) ? ("{F22C2C}Kapalý") : ("{2CF26B}Açýk"));
	        }
	        case 2:
	        {
	            if (PlayerData[playerid][pTelefonAyar][3] == 0) PlayerData[playerid][pTelefonAyar][3] = 1;
	            else PlayerData[playerid][pTelefonAyar][3] = 0;
	            Dialog_Show(playerid, TelefonAyarlar, DIALOG_STYLE_LIST, "Telefon ~ Ayarlar", "{38c5f7}» {FFFFFF}Titreþim:\t\t%s\n{38c5f7}» {FFFFFF}Hoparlör:\t\t%s\n{38c5f7}» {FFFFFF}Bilinmeyen Numara Engeli:\t%s\n{38c5f7}» {FFFFFF}SMS Engeli:\t\t%s\n{38c5f7}» {FFFFFF}Arama Engeli:\t\t%s", "Seç", "Geri",(PlayerData[playerid][pTelefonAyar][1] == 0) ? ("{F22C2C}Kapalý") : ("{2CF26B}Açýk"),
				(PlayerData[playerid][pTelefonAyar][2] == 0) ? ("{F22C2C}Kapalý") : ("{2CF26B}Açýk"),  (PlayerData[playerid][pTelefonAyar][3] == 0) ? ("{F22C2C}Kapalý") : ("{2CF26B}Açýk"),  (PlayerData[playerid][pTelefonAyar][4] == 0) ? ("{F22C2C}Kapalý") : ("{2CF26B}Açýk"), (PlayerData[playerid][pTelefonAyar][5] == 0) ? ("{F22C2C}Kapalý") : ("{2CF26B}Açýk"));
	        }
	        case 3:
	        {
	            if (PlayerData[playerid][pTelefonAyar][4] == 0) PlayerData[playerid][pTelefonAyar][4] = 1;
	            else PlayerData[playerid][pTelefonAyar][4] = 0;
	            Dialog_Show(playerid, TelefonAyarlar, DIALOG_STYLE_LIST, "Telefon ~ Ayarlar", "{38c5f7}» {FFFFFF}Titreþim:\t\t%s\n{38c5f7}» {FFFFFF}Hoparlör:\t\t%s\n{38c5f7}» {FFFFFF}Bilinmeyen Numara Engeli:\t%s\n{38c5f7}» {FFFFFF}SMS Engeli:\t\t%s\n{38c5f7}» {FFFFFF}Arama Engeli:\t\t%s", "Seç", "Geri",(PlayerData[playerid][pTelefonAyar][1] == 0) ? ("{F22C2C}Kapalý") : ("{2CF26B}Açýk"),
				(PlayerData[playerid][pTelefonAyar][2] == 0) ? ("{F22C2C}Kapalý") : ("{2CF26B}Açýk"),  (PlayerData[playerid][pTelefonAyar][3] == 0) ? ("{F22C2C}Kapalý") : ("{2CF26B}Açýk"),  (PlayerData[playerid][pTelefonAyar][4] == 0) ? ("{F22C2C}Kapalý") : ("{2CF26B}Açýk"), (PlayerData[playerid][pTelefonAyar][5] == 0) ? ("{F22C2C}Kapalý") : ("{2CF26B}Açýk"));
	        }
	        case 4:
	        {
	            if (PlayerData[playerid][pTelefonAyar][5] == 0) PlayerData[playerid][pTelefonAyar][5] = 1;
	            else PlayerData[playerid][pTelefonAyar][5] = 0;
	            Dialog_Show(playerid, TelefonAyarlar, DIALOG_STYLE_LIST, "Telefon ~ Ayarlar", "{38c5f7}» {FFFFFF}Titreþim:\t\t%s\n{38c5f7}» {FFFFFF}Hoparlör:\t\t%s\n{38c5f7}» {FFFFFF}Bilinmeyen Numara Engeli:\t%s\n{38c5f7}» {FFFFFF}SMS Engeli:\t\t%s\n{38c5f7}» {FFFFFF}Arama Engeli:\t\t%s", "Seç", "Geri",(PlayerData[playerid][pTelefonAyar][1] == 0) ? ("{F22C2C}Kapalý") : ("{2CF26B}Açýk"),
				(PlayerData[playerid][pTelefonAyar][2] == 0) ? ("{F22C2C}Kapalý") : ("{2CF26B}Açýk"),  (PlayerData[playerid][pTelefonAyar][3] == 0) ? ("{F22C2C}Kapalý") : ("{2CF26B}Açýk"),  (PlayerData[playerid][pTelefonAyar][4] == 0) ? ("{F22C2C}Kapalý") : ("{2CF26B}Açýk"), (PlayerData[playerid][pTelefonAyar][5] == 0) ? ("{F22C2C}Kapalý") : ("{2CF26B}Açýk"));
	        }
	    }
	}
	return 1;
}
Dialog:LSMDLobi(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (listitem == 0)
	    {
	        if (ReturnHealth(playerid) >= 90 && PlayerData[playerid][pTopallama] == false) return HataMesajGonder(playerid, "Tedavi olmaya ihtiyacýnýz yok.");
	        CanAyarla(playerid, 100);
	        PlayerData[playerid][pTopallama] = false;
	        PlayerData[playerid][pTopallamaSayac] = 0;
	        MesajGonder(playerid, "Tedavi edildiniz.");
	    }
	    if (listitem == 1)
	    {
	        if (!spamProtect(playerid, "DoktorCagir", 60)) return HataMesajGonder(playerid, "Tekrar doktor çaðýrmak için 1 dakika beklemelisiniz.");
	        SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s masada bulunan zile basar ve doktor çaðýrýr.", ReturnName(playerid, 0));
	        SendBirlikMessageEx(BIRLIK_LSMD, 0xFF8282AA, "%s adlý kiþi lobiye Doktor talep ediyor.", ReturnName(playerid, 0));
	    }
	    if (listitem == 2)
	    {
	        if (PlayerData[playerid][pBagimlilik] == 0) return HataMesajGonder(playerid, "Uyuþturucu baðýmlýsý deðilsiniz.");
	        PlayerData[playerid][pBagimlilik] = 0;
	        PlayerData[playerid][pBagimlilikSayac][0] = 0;
	        PlayerData[playerid][pBagimlilikSayac][1] = 0;
	        MesajGonder(playerid, "Uyuþturucu baðýmlýlýðýndan kurtuldunuz.");
		}
	}
	return 1;
}
Dialog:LSPDTrunk(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    new vehicleid = GetPVarInt(playerid, "AracBagaj");
	    if (strfind(inputtext, "Aðrý Kesici", true) != -1)
	    {
	        if (PolisAraci[vehicleid][AgriKesici] > 0)
	        {
	            PolisAraci[vehicleid][AgriKesici]--;
	            CanAyarla(playerid, 100.0);
	            SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s araçtan aðrý kesici alýr ve yutar.", ReturnName(playerid, 0));
			}
			else
			{
			    HataMesajGonder(playerid, "Bagajda hiç aðrý kesici kalmamýþ.");
			}
			return 1;
		}
		if (strfind(inputtext, "Çelik Yelek", true) != -1)
		{
		    if (PolisAraci[vehicleid][CelikYelek] > 0)
		    {
		        PolisAraci[vehicleid][CelikYelek]--;
		        ZirhAyarla(playerid, 100.0);
		        SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s araçtan çelik yelek alýr ve giyer.", ReturnName(playerid, 0));
			}
			else
			{
			    HataMesajGonder(playerid, "Bagajda hiç çelik yelek kalmamýþ.");
			}
			return 1;
		}
		new silahad[15];
		if (PolisAraci[vehicleid][Silahlar][listitem] == 0)
		{
		    if (!GetWeapon(playerid))
		    {
		        HataMesajGonder(playerid, "Elinizde silah yok!");
		        return Car_LSPDTrunk(playerid, vehicleid);
		    }
		    if (GetWeapon(playerid) == 23 && PlayerData[playerid][pTazer])
		    {
		        HataMesajGonder(playerid, "Bagaja Tazer koyamazsýnýz!");
		        return Car_LSPDTrunk(playerid, vehicleid);
		    }
		    if (GetWeapon(playerid) == 25 && PlayerData[playerid][pBeanbag])
		    {
		        HataMesajGonder(playerid, "Bagaja Beanbag koyamazsýnýz!");
		        return Car_LSPDTrunk(playerid, vehicleid);
		    }
		    if (GetPlayerAmmo(playerid) < 2)
		    {
		        HataMesajGonder(playerid, "Mermisi bitmiþ bir silahý bagaja koyamazsýnýz!");
		        return Car_LSPDTrunk(playerid, vehicleid);
		    }
		    PolisAraci[vehicleid][Silahlar][listitem] = GetWeapon(playerid);
		    PolisAraci[vehicleid][Mermiler][listitem] = GetPlayerAmmo(playerid);
		    ResetWeapon(playerid, GetWeapon(playerid));
		    GetWeaponName(PolisAraci[vehicleid][Silahlar][listitem], silahad, sizeof(silahad));
		    SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s '%s' model silahý aracýn bagajýna koyar.", ReturnName(playerid, 0), silahad);
		}
		else
		{
		    if (PlayerHasWeapon(playerid, PolisAraci[vehicleid][Silahlar][listitem]))
		    {
		        HataMesajGonder(playerid, "Bu silaha zaten sahipsin!");
		        return Car_LSPDTrunk(playerid, vehicleid);
		    }
		    GiveWeaponToPlayer(playerid,PolisAraci[vehicleid][Silahlar][listitem], PolisAraci[vehicleid][Mermiler][listitem]);
		    GetWeaponName(PolisAraci[vehicleid][Silahlar][listitem], silahad, sizeof(silahad));
		    SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s polis aracýnýn bagajýndan '%s' model silahý alýr.", ReturnName(playerid, 0), silahad);
		    PolisAraci[vehicleid][Silahlar][listitem] = 0;
		    PolisAraci[vehicleid][Mermiler][listitem] = 0;

		}
	}
	return 1;
}
Dialog:MenuMVB(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		switch (listitem)
		{
		    case 0: // Kriminal Veritabaný
		    {
				Dialog_Show(playerid, MVBIDYaz, DIALOG_STYLE_INPUT, "{1394BF}Mobil Veritabaný ~ Kriminal Veritabaný", "Lütfen incelemek istediðiniz kiþinin ID'sini girin:", "Devam", "Geri");
		    }
		    case 1: // Plaka Inceleme
		    {
				Dialog_Show(playerid, PlakaGir, DIALOG_STYLE_INPUT, "{1394BF}Mobil Veritabaný ~ Plaka Incele", "{FFFFFF}Lütfen incelemek istediðiniz plakayý girin:", "Devam", "Geri");
		    }
		    case 2: // Telefon Sorgulat
		    {
				Dialog_Show(playerid, TelefonSorgulat, DIALOG_STYLE_INPUT, "{1394BF}Mobil Veritabaný ~ Telefon Sorgulat", "{FFFFFF}Lütfen sorgulatmak istediðiniz telefon numarasýný girin:", "Devam", "Geri");
		    }
		    case 3: // Aranmalar
		    {
		        new str[500], string[100],sayi;
		        strcat(str, "{1394BF}ID\t{1394BF}Ad/Soyad\t{1394BF}Aranma Seviyesi\n");
		        foreach (new i:Player)
		        {
		            if (PlayerData[i][pAranma] > 0)
		            {
		                sayi++;
		                format(string, sizeof(string), "{FFFFFF}%d\t{FFFFFF}%s\t{FFFFFF}%d", i, ReturnName(i, 0), PlayerData[i][pAranma]);
		                strcat(str, string);
		            }
		        }
		        if (sayi == 0) return HataMesajGonder(playerid, "Arananlar listesi boþ.");
		        format(string, sizeof(string), "{1394BF}Mobil Veritabaný - Arananlar: %d", sayi);
		        Dialog_Show(playerid, Arananlar, DIALOG_STYLE_TABLIST_HEADERS, string, str, "Geri", "");
		    }
		    case 4: // Ihbarlar
		    {
		        new string[1024], sayi;
			 	foreach (new i : Player)
				{
				    if (strlen(PlayerData[i][pIhbar]) > 0)
					{
			 			format(string, sizeof(string), "%s[Tel No: %d] %s: %s\n", string, PlayerData[i][pTelefon], ReturnName(i, 0), PlayerData[i][pIhbar]);
					    sayi++;
					}
				}
				if (sayi == 0) return HataMesajGonder(playerid, "Hiç ihbar yok.");
				Dialog_Show(playerid, Ihbarlar, DIALOG_STYLE_MSGBOX, "Ýhbarlar", string, "Tamam", "");
		    }
		    case 5: // Dashcam
		    {
		        if (IsPlayerInAnyVehicle(playerid))
		        {
		            new vehicleid = GetPlayerVehicleID(playerid);
	    			if (vehRadar[vehicleid] == true)
    				{
    				    for (new i; i<5; i++) TextDrawDestroy(carMDC[vehicleid][i]);
      					vehRadar[vehicleid] = false;
      					vehRadarLimit[vehicleid] = 100;
	        			KillTimer(timerMDC[vehicleid]);
	        			MesajGonder(playerid, "Dashcam kapandý.");
						for (new i; i < 5; i++) TextDrawHideForPlayer(playerid, carMDC[GetPlayerVehicleID(playerid)][i]);
	    			}
	    			else
    				{
    				    CreateMDCTextdraws(vehicleid);
				    	vehRadar[vehicleid] = true;
      					vehRadarLimit[vehicleid] = 100;
            			timerMDC[vehicleid] = SetTimerEx ("RadarGuncelle", 100, 1, "d", vehicleid);
           				MesajGonder(playerid, "Dashcam açýldý.");
					}
		        }
		    }
		}
	}
	return 1;
}
Dialog:TelefonSorgulat(playerid, response, listitem, inputtext[])
{
	if (!response) return callcmd::mdc(playerid);
	if (response)
	{
	    if (isnull(inputtext) || !IsNumeric(inputtext)) return Dialog_Show(playerid, TelefonSorgulat, DIALOG_STYLE_INPUT, "{1394BF}Mobil Veritabaný ~ Telefon Sorgulat", "{FFFFFF}Lütfen sorgulatmak istediðiniz telefon numarasýný girin:", "Devam", "Geri");
	    new oyuncuid = -1;
	    foreach (new i:Player)
	    {
	        if (PlayerData[i][pTelefon] == strval(inputtext))
	        {
	            oyuncuid = i;
	            break;
	        }
	    }
	    if (oyuncuid == -1)
	    {
	        HataMesajGonder(playerid, "Girdiðiniz numara bulunamadý.");
	        return Dialog_Show(playerid, TelefonSorgulat, DIALOG_STYLE_INPUT, "{1394BF}Mobil Veritabaný ~ Telefon Sorgulat", "{FFFFFF}Lütfen sorgulatmak istediðiniz telefon numarasýný girin:", "Devam", "Geri");
	    }
	    Dialog_Show(playerid, TelefonSorgulat2, DIALOG_STYLE_MSGBOX, "Telefon Sorgulatma Sonuçlarý", "{AFAFAF}Ad Soyad: {FFFFFF}%s (%d)\n{AFAFAF}Yaþ: {FFFFFF}%d\n{AFAFAF}Doðum Yeri: {FFFFFF}%s\n{AFAFAF}Cinsiyet: {FFFFFF}%s", "Tamam", "Geri",ReturnName(oyuncuid, 0), oyuncuid, PlayerData[oyuncuid][pYas], PlayerData[oyuncuid][pDogum], (PlayerData[oyuncuid][pCinsiyet] == 1) ? ("Bay") : ("Bayan"));
	}
	return 1;
}
Dialog:TelefonSorgulat2(playerid, response, listitem, inputtext[])
{
	if (!response || response) return Dialog_Show(playerid, TelefonSorgulat, DIALOG_STYLE_INPUT, "{1394BF}Mobil Veritabaný ~ Telefon Sorgulat", "{FFFFFF}Lütfen sorgulatmak istediðiniz telefon numarasýný girin:", "Devam", "Geri");
	return 1;
}
Dialog:Ihbarlar(playerid, response, listitem, inputtext[])
{
	if (response) return callcmd::mdc(playerid);
	return 1;
}
Dialog:Arananlar(playerid, response, listitem, inputtext[])
{
	if (response) return callcmd::mdc(playerid);
	return 1;
}

Dialog:MVBIDYaz(playerid, response, listitem, inputtext[])
{
	if (!response) return callcmd::mdc(playerid);
	if (response)
	{
	    if (isnull(inputtext)) return Dialog_Show(playerid, MVBIDYaz, DIALOG_STYLE_INPUT, "{1394BF}Mobil Veritabaný ~ Kriminal Veritabaný", "Lütfen incelemek istediðiniz kiþinin ID'sini girin:", "Devam", "Geri");
	    if (!IsNumeric(inputtext)) return Dialog_Show(playerid, MVBIDYaz, DIALOG_STYLE_INPUT, "{1394BF}Mobil Veritabaný ~ Kriminal Veritabaný", "Lütfen incelemek istediðiniz kiþinin ID'sini girin:", "Devam", "Geri");
	    if (!OyundaDegil(strval(inputtext)))
	    {
	        HataMesajGonder(playerid, "Böyle bir kiþi yok!");
	        return Dialog_Show(playerid, MVBIDYaz, DIALOG_STYLE_INPUT, "{1394BF}Mobil Veritabaný ~ Kriminal Veritabaný", "Lütfen incelemek istediðiniz kiþinin ID'sini girin:", "Devam", "Geri");
	    }
	    SetPVarInt(playerid, "KriminalVeritabani", strval(inputtext));
	    Dialog_Show(playerid, Kriminal, DIALOG_STYLE_LIST, "{1394BF}Mobil Veritabaný ~ Kriminal Veritabaný", "{1394BF}» {FFFFFF}Kimlik Bilgileri\n{1394BF}» {FFFFFF}Sicil Kaydý\n{1394BF}» {FFFFFF}Mülkler\n{1394BF}» {FFFFFF}Aranma Ekle\n{1394BF}» {FFFFFF}Aranma Sil\n{1394BF}» {FFFFFF}Ceza Yaz\n{1394BF}» {FFFFFF}Lokasyon Bul\n{1394BF}» {FFFFFF}Cezalar", "Seç", "Geri");
	}
	return 1;
}
Dialog:Kriminal(playerid, response, listitem, inputtext[])
{
	if (!response)
	{
	    DeletePVar(playerid, "KriminalVeritabani");
	    callcmd::mdc(playerid);
	}
	else
	{
	    new hedefid = GetPVarInt(playerid, "KriminalVeritabani");
	    if (listitem == 0)
	    {
	        if (!OyundaDegil(hedefid)) return HataMesajGonder(playerid, "Kiþi oyundan çýkmýþ.");
	        new str[750], string[100];
	        format(string, sizeof(string), "{FFFFFF}Ad Soyad: {9189EF}%s (%d)\n", ReturnName(hedefid, 0), hedefid);
	        strcat(str, string);
	        format(string, sizeof(string), "{FFFFFF}Cinsiyet: {9189EF}%s\n", (PlayerData[hedefid][pCinsiyet] == 1) ? ("Erkek") : ("Kadýn"));
	        strcat(str, string);
	        format(string, sizeof(string), "{FFFFFF}Yaþ: {9189EF}%d\n", PlayerData[hedefid][pYas]);
	        strcat(str, string);
	        format(string, sizeof(string), "{FFFFFF}Doðum Yeri: {9189EF}%s\n", PlayerData[hedefid][pDogum]);
	        strcat(str, string);
	        format(string, sizeof(string), "{FFFFFF}Ten Rengi: {9189EF}%s\n", (PlayerData[hedefid][pTen] == 1) ? ("Beyaz") : ("Siyah"));
	        strcat(str, string);
	        format(string, sizeof(string), "{FFFFFF}Partner: {9189EF}Yok\n");
	        strcat(str, string);
	        if (PlayerData[hedefid][pTelefon] == -1) format(string, sizeof(string), "{FFFFFF}Telefon: {9189EF}Yok\n");
	        else format(string, sizeof(string), "{FFFFFF}Telefon: {9189EF}%d\n", PlayerData[hedefid][pTelefon]);
	        strcat(str, string);
	        format(string, sizeof(string), "{FFFFFF}Ehliyet: {9189EF}%s\n", (PlayerData[hedefid][pEhliyet] == 1) ? ("Var") : ("Yok"));
	        strcat(str, string);
	        format(string, sizeof(string), "{FFFFFF}Motor ehliyeti: {9189EF}%s\n", (PlayerData[hedefid][pMotorEhliyet] == 1) ? ("Var") : ("Yok"));
	        strcat(str, string);
	        format(string, sizeof(string), "{FFFFFF}Aranma: {9189EF}%s\n", (PlayerData[hedefid][pAranma] > 0) ? ("Evet") : ("Hayýr"));
	        strcat(str, string);

	        Dialog_Show(playerid, KimlikBilgileri, DIALOG_STYLE_LIST, "{1394BF}Mobil Veritabaný ~ Kimlik Bilgileri", str, "Geri", "");
	    }
	    if (listitem == 1) // Sicil Kaydi
	    {
	        if (!OyundaDegil(hedefid)) return HataMesajGonder(playerid, "Kiþi oyundan çýkmýþ.");
	        if (ICSicil_GetCount(PlayerData[hedefid][pID]) < 1)
	        {
	            HataMesajGonder(playerid, "Bu oyuncunun hiç sicil kaydý yok.");
	            return Dialog_Show(playerid, Kriminal, DIALOG_STYLE_LIST, "{1394BF}Mobil Veritabaný ~ Kriminal Veritabaný", "{1394BF}» {FFFFFF}Kimlik Bilgileri\n{1394BF}» {FFFFFF}Sicil Kaydý\n{1394BF}» {FFFFFF}Mülkler\n{1394BF}» {FFFFFF}Aranma Ekle\n{1394BF}» {FFFFFF}Aranma Sil\n{1394BF}» {FFFFFF}Ceza Yaz\n{1394BF}» {FFFFFF}Lokasyon Bul\n{1394BF}» {FFFFFF}Cezalar", "Seç", "Geri");
	        }
	        SetPVarInt(playerid, "ListPage", 0);
	        SicilGoruntule(playerid, hedefid);
	    }
	    if (listitem == 2) // Mulkler
	    {
	        if (!OyundaDegil(hedefid)) return HataMesajGonder(playerid, "Kiþi oyundan çýkmýþ.");
	        Dialog_Show(playerid, Mulkler, DIALOG_STYLE_LIST, "{1394BF}Mobil Veritabaný ~ Mülkler", "{1394BF}» {FFFFFF}Evler\n{1394BF}» {FFFFFF}Araçlar\n{1394BF}» {FFFFFF}Ýþyerleri\n{1394BF}» {FFFFFF}Gateler", "Seç", "Kapat");
	    }
	    if (listitem == 3) // Aranma Ekle
	    {
	        if (!OyundaDegil(hedefid)) return HataMesajGonder(playerid, "Kiþi oyundan çýkmýþ.");
	        if (PlayerData[hedefid][pAranma] >=6)
	        {
	            HataMesajGonder(playerid, "Bir kiþiye en fazla 6 suç eklenebilir.");
	            return Dialog_Show(playerid, Kriminal, DIALOG_STYLE_LIST, "{1394BF}Mobil Veritabaný ~ Kriminal Veritabaný", "{1394BF}» {FFFFFF}Kimlik Bilgileri\n{1394BF}» {FFFFFF}Sicil Kaydý\n{1394BF}» {FFFFFF}Mülkler\n{1394BF}» {FFFFFF}Aranma Ekle\n{1394BF}» {FFFFFF}Aranma Sil\n{1394BF}» {FFFFFF}Ceza Yaz\n{1394BF}» {FFFFFF}Lokasyon Bul\n{1394BF}» {FFFFFF}Cezalar", "Seç", "Geri");
	        }
	        Dialog_Show(playerid, AranmaEkle, DIALOG_STYLE_INPUT, "{1394BF}Mobil Veritabaný ~ Aranma Ekle", "{FFFFFF}Lütfen kiþiye eklemek istediðiniz suçu girin:", "Ekle", "Geri");
	    }
	    if (listitem == 4) // Aranma Sil
	    {
	        if (!OyundaDegil(hedefid)) return HataMesajGonder(playerid, "Kiþi oyundan çýkmýþ.");
	        if (PlayerData[hedefid][pAranma] < 1)
	        {
	            HataMesajGonder(playerid, "Bu kiþinin zaten aranmasý yok.");
	            return Dialog_Show(playerid, Kriminal, DIALOG_STYLE_LIST, "{1394BF}Mobil Veritabaný ~ Kriminal Veritabaný", "{1394BF}» {FFFFFF}Kimlik Bilgileri\n{1394BF}» {FFFFFF}Sicil Kaydý\n{1394BF}» {FFFFFF}Mülkler\n{1394BF}» {FFFFFF}Aranma Ekle\n{1394BF}» {FFFFFF}Aranma Sil\n{1394BF}» {FFFFFF}Ceza Yaz\n{1394BF}» {FFFFFF}Lokasyon Bul\n{1394BF}» {FFFFFF}Cezalar", "Seç", "Geri");
	        }
	        PlayerData[hedefid][pAranma] = 0;
	        SetPlayerWantedLevel(hedefid, 0);
	        SendBirlikMessage(PlayerData[playerid][pFaction], COLOR_DEPARTMENT, "** DEPARTMAN: %s %s, %s adlý kiþinin aranmalarýný temizledi.",Birlik_GetRutbe(playerid), ReturnName(playerid, 0), ReturnName(hedefid, 0));
	        MesajGonder(hedefid, "%s adlý memur tarafýndan aranmalarýnýz temizlendi.", ReturnName(playerid, 0));
	    }
		if (listitem == 5) // Ceza Yaz
		{
		    if (!OyundaDegil(hedefid)) return HataMesajGonder(playerid, "Kiþi oyundan çýkmýþ.");
		    Dialog_Show(playerid, CezaYaz, DIALOG_STYLE_INPUT, "{1394BF}Mobil Veritabaný ~ Ceza Yaz", "Lütfen ceza sebebini girin:", "Devam", "Geri");
		}
		if (listitem == 6) // Lokasyon Bul
		{
            if (!OyundaDegil(hedefid)) return HataMesajGonder(playerid, "Kiþi oyundan çýkmýþ.");
            if (PlayerData[hedefid][pTelefon] == -1 || PlayerData[hedefid][pTelefonAyar][0] == 1)
            {
                HataMesajGonder(playerid, "Kiþinin telefonu yok veya telefonunu kapatmýþ.");
                return Dialog_Show(playerid, Kriminal, DIALOG_STYLE_LIST, "{1394BF}Mobil Veritabaný ~ Kriminal Veritabaný", "{1394BF}» {FFFFFF}Kimlik Bilgileri\n{1394BF}» {FFFFFF}Sicil Kaydý\n{1394BF}» {FFFFFF}Mülkler\n{1394BF}» {FFFFFF}Aranma Ekle\n{1394BF}» {FFFFFF}Aranma Sil\n{1394BF}» {FFFFFF}Ceza Yaz\n{1394BF}» {FFFFFF}Lokasyon Bul\n{1394BF}» {FFFFFF}Cezalar", "Seç", "Geri");
            }
            if (!spamProtect(playerid, "LokasyonBul", 20))
            {
                HataMesajGonder(playerid, "Tekrar lokasyon bulmak için biraz bekleyin.");
                Dialog_Show(playerid, Kriminal, DIALOG_STYLE_LIST, "{1394BF}Mobil Veritabaný ~ Kriminal Veritabaný", "{1394BF}» {FFFFFF}Kimlik Bilgileri\n{1394BF}» {FFFFFF}Sicil Kaydý\n{1394BF}» {FFFFFF}Mülkler\n{1394BF}» {FFFFFF}Aranma Ekle\n{1394BF}» {FFFFFF}Aranma Sil\n{1394BF}» {FFFFFF}Ceza Yaz\n{1394BF}» {FFFFFF}Lokasyon Bul\n{1394BF}» {FFFFFF}Cezalar", "Seç", "Geri");
                return 1;
            }
            new Float:pos[3];
            GetPlayerPosEx(hedefid, pos[0], pos[1], pos[2]);
            callcmd::cpsifirla(playerid);

            SetPlayerCheckpoint(playerid, pos[0], pos[1], pos[2], 5.0);
            SetTimerEx("IsaretSil", 10000, false, "i", playerid);
            MesajGonder(playerid, "%s adlý kiþi en son %s bölgesinde görüldü, 10 saniye sonra iþaret kaybolacak.", ReturnName(hedefid, 0), GetLocation(pos[0], pos[1], pos[2]));
		}
		if (listitem == 7) // Cezalar
		{
		    if (!OyundaDegil(hedefid)) return HataMesajGonder(playerid, "Kiþi oyundan çýkmýþ.");
		    new str[1000], string[100], sayi;
		    strcat(str, "Memur\tSebep\tMiktar\tTarih\n");
		    for (new i; i<MAX_PLAYER_TICKETS; i++) if (TicketData[hedefid][i][ticketExists])
		    {
		        format(string, sizeof(string), "%s\t%s\t{2aff00}%.20s\t{FFFFFF}%s\n", TicketData[hedefid][i][ticketMemur], TicketData[hedefid][i][ticketReason], FormatNumber(TicketData[hedefid][i][ticketFee]),TicketData[hedefid][i][ticketDate]);
		        strcat(str, string);
		        sayi++;
		    }
		    if (sayi == 0)
		    {
		        HataMesajGonder(playerid, "Bu kiþiye ait ceza bulunamadý.");
		        return Dialog_Show(playerid, Kriminal, DIALOG_STYLE_LIST, "{1394BF}Mobil Veritabaný ~ Kriminal Veritabaný", "{1394BF}» {FFFFFF}Kimlik Bilgileri\n{1394BF}» {FFFFFF}Sicil Kaydý\n{1394BF}» {FFFFFF}Mülkler\n{1394BF}» {FFFFFF}Aranma Ekle\n{1394BF}» {FFFFFF}Aranma Sil\n{1394BF}» {FFFFFF}Ceza Yaz\n{1394BF}» {FFFFFF}Lokasyon Bul\n{1394BF}» {FFFFFF}Cezalar", "Seç", "Geri");
		    }
		    format(string, sizeof(string), "{FFFFFF}%s Cezalarý (%d adet)", ReturnName(hedefid, 0), sayi);
		    Dialog_Show(playerid, Cezalar, DIALOG_STYLE_TABLIST_HEADERS, string, str, "Geri", "");
		}
	}
	return 1;
}
Dialog:Cezalar(playerid, response, listitem, inputtext[])
{
	if (response) return Dialog_Show(playerid, Kriminal, DIALOG_STYLE_LIST, "{1394BF}Mobil Veritabaný ~ Kriminal Veritabaný", "{1394BF}» {FFFFFF}Kimlik Bilgileri\n{1394BF}» {FFFFFF}Sicil Kaydý\n{1394BF}» {FFFFFF}Mülkler\n{1394BF}» {FFFFFF}Aranma Ekle\n{1394BF}» {FFFFFF}Aranma Sil\n{1394BF}» {FFFFFF}Ceza Yaz\n{1394BF}» {FFFFFF}Lokasyon Bul\n{1394BF}» {FFFFFF}Cezalar", "Seç", "Geri");
	return 1;
}

Dialog:CezaYaz(playerid, response, listitem, inputtext[])
{
	if (!response) return Dialog_Show(playerid, Kriminal, DIALOG_STYLE_LIST, "{1394BF}Mobil Veritabaný ~ Kriminal Veritabaný", "{1394BF}» {FFFFFF}Kimlik Bilgileri\n{1394BF}» {FFFFFF}Sicil Kaydý\n{1394BF}» {FFFFFF}Mülkler\n{1394BF}» {FFFFFF}Aranma Ekle\n{1394BF}» {FFFFFF}Aranma Sil\n{1394BF}» {FFFFFF}Ceza Yaz\n{1394BF}» {FFFFFF}Lokasyon Bul\n{1394BF}» {FFFFFF}Cezalar", "Seç", "Geri");
	if (response)
	{
	    if (isnull(inputtext) || strlen(inputtext) < 3) return Dialog_Show(playerid, CezaYaz, DIALOG_STYLE_INPUT, "{1394BF}Mobil Veritabaný ~ Ceza Yaz", "Lütfen ceza sebebini girin:", "Devam", "Geri");
	    if (strlen(inputtext) > 64)
	    {
	        HataMesajGonder(playerid, "Ceza sebebi 64 karakteri geçemez.");
	        return Dialog_Show(playerid, CezaYaz, DIALOG_STYLE_INPUT, "{1394BF}Mobil Veritabaný ~ Ceza Yaz", "Lütfen ceza sebebini girin:", "Devam", "Geri");
	    }
	    SetPVarString(playerid, "CezaSebebi", inputtext);
	    Dialog_Show(playerid, CezaYaz2, DIALOG_STYLE_INPUT, "{1394BF}Mobil Veritabaný ~ Ceza Yaz", "Lütfen ceza miktarýný girin:", "Devam", "Geri");
	}
	return 1;
}

Dialog:CezaYaz2(playerid, response, listitem, inputtext[])
{
	if (!response)
	{
	    DeletePVar(playerid, "CezaSebebi");
	    return Dialog_Show(playerid, CezaYaz, DIALOG_STYLE_INPUT, "{1394BF}Mobil Veritabaný ~ Ceza Yaz", "Lütfen ceza sebebini girin:", "Devam", "Geri");
	}
	else
	{
	    if (!OyundaDegil(GetPVarInt(playerid, "KriminalVeritabani"))) return HataMesajGonder(playerid, "Kiþi oyundan çýkmýþ.");
	    if (isnull(inputtext) || !IsNumeric(inputtext)) return Dialog_Show(playerid, CezaYaz2, DIALOG_STYLE_INPUT, "{1394BF}Mobil Veritabaný ~ Ceza Yaz", "Lütfen ceza miktarýný girin:", "Devam", "Geri");
	    if (strval(inputtext) <= 5 || strval(inputtext) > 5000)
	    {
	        HataMesajGonder(playerid, "Geçersiz miktar girdiniz, $10 ile $5000 arasýnda olmalýdýr.");
	        return Dialog_Show(playerid, CezaYaz2, DIALOG_STYLE_INPUT, "{1394BF}Mobil Veritabaný ~ Ceza Yaz", "Lütfen ceza miktarýný girin:", "Devam", "Geri");
	    }
	    new sebep[64], miktar = strval(inputtext);
	    GetPVarString(playerid, "CezaSebebi", sebep, sizeof(sebep));
	    new id = Ticket_Add(GetPVarInt(playerid, "KriminalVeritabani"), miktar, sebep, ReturnName(playerid, 0));
	    if (id != -1)
	    {
	        MesajGonder(playerid, "%s adlý kiþiye %s sebebiyle %s para cezasý yazdýnýz.", ReturnName(GetPVarInt(playerid, "KriminalVeritabani"), 0), sebep, FormatNumber(miktar));
	        BilgiMesajGonder(GetPVarInt(playerid, "KriminalVeritabani"), "Memur %s, %s sebebiyle size %s para cezasý yazdý.", ReturnName(playerid, 0), sebep, FormatNumber(miktar));
	        BilgiMesajGonder(GetPVarInt(playerid, "KriminalVeritabani"), "Cezayý ödeyene kadar devlet hizmetlerinden yararlanamayacaksýnýz. (PD binasýndan ödeyebilirsiniz)", ReturnName(playerid, 0), sebep, FormatNumber(miktar));
	        SendBirlikMessage(PlayerData[playerid][pFaction], COLOR_DEPARTMENT, "** DEPARTMAN: %s %s, %s adlý kiþiye %s sebebiyle %s para cezasý yazdý.", Birlik_GetRutbe(playerid), ReturnName(playerid, 0), ReturnName(GetPVarInt(playerid, "KriminalVeritabani"), 0), sebep, FormatNumber(miktar));
	    }
	    else
	    {
	        HataMesajGonder(playerid, "Bu oyuncunun zaten ödenmemiþ %d cezasý var.", MAX_PLAYER_TICKETS);
	    }
	}
	return 1;
}
Dialog:AranmaEkle(playerid, response, listitem, inputtext[])
{
	if (!response) return Dialog_Show(playerid, Kriminal, DIALOG_STYLE_LIST, "{1394BF}Mobil Veritabaný ~ Kriminal Veritabaný", "{1394BF}» {FFFFFF}Kimlik Bilgileri\n{1394BF}» {FFFFFF}Sicil Kaydý\n{1394BF}» {FFFFFF}Mülkler\n{1394BF}» {FFFFFF}Aranma Ekle\n{1394BF}» {FFFFFF}Aranma Sil\n{1394BF}» {FFFFFF}Ceza Yaz\n{1394BF}» {FFFFFF}Lokasyon Bul\n{1394BF}» {FFFFFF}Cezalar", "Seç", "Geri");
	if (response)
	{
	    new hedefid = GetPVarInt(playerid, "KriminalVeritabani");
	    if (!OyundaDegil(hedefid)) return HataMesajGonder(playerid, "Kiþi oyundan çýkmýþ.");
	    if (isnull(inputtext)) return Dialog_Show(playerid, AranmaEkle, DIALOG_STYLE_INPUT, "{1394BF}Mobil Veritabaný ~ Aranma Ekle", "{FFFFFF}Lütfen kiþiye eklemek istediðiniz suçu girin:", "Ekle", "Geri");
	    if (strlen(inputtext) < 3) return Dialog_Show(playerid, AranmaEkle, DIALOG_STYLE_INPUT, "{1394BF}Mobil Veritabaný ~ Aranma Ekle", "{FFFFFF}Lütfen kiþiye eklemek istediðiniz suçu girin:", "Ekle", "Geri");
	    PlayerData[hedefid][pAranma]++;
	    SetPlayerWantedLevel(hedefid,PlayerData[hedefid][pAranma]);
	    SendBirlikMessage(PlayerData[playerid][pFaction], COLOR_DEPARTMENT, "** DEPARTMAN: %s %s, %s adlý kiþiye %s sebebiyle aranma ekledi.", Birlik_GetRutbe(playerid), ReturnName(playerid, 0), ReturnName(hedefid, 0), inputtext);
	    BilgiMesajGonder(hedefid, "%s adlý memur size %s sebebiyle aranma ekledi. (Suç seviyeniz: %d)", ReturnName(playerid, 0), inputtext, PlayerData[hedefid][pAranma]);
	    Sicil_Ekle(PlayerData[hedefid][pID], ReturnName(playerid, 0), inputtext);
	    Dialog_Show(playerid, Kriminal, DIALOG_STYLE_LIST, "{1394BF}Mobil Veritabaný ~ Kriminal Veritabaný", "{1394BF}» {FFFFFF}Kimlik Bilgileri\n{1394BF}» {FFFFFF}Sicil Kaydý\n{1394BF}» {FFFFFF}Mülkler\n{1394BF}» {FFFFFF}Aranma Ekle\n{1394BF}» {FFFFFF}Aranma Sil\n{1394BF}» {FFFFFF}Ceza Yaz\n{1394BF}» {FFFFFF}Lokasyon Bul\n{1394BF}» {FFFFFF}Cezalar", "Seç", "Geri");
	}
	return 1;
}
Dialog:SicilGoruntule(playerid, response, listitem, inputtext[])
{
	if (!response)
	{
	    SetPVarInt(playerid, "ListPage", GetPVarInt(playerid, "ListPage")-1);
	    if (GetPVarInt(playerid, "ListPage") < 0)
	    {
	        DeletePVar(playerid, "ListPage");
	        Dialog_Show(playerid, Kriminal, DIALOG_STYLE_LIST, "{1394BF}Mobil Veritabaný ~ Kriminal Veritabaný", "{1394BF}» {FFFFFF}Kimlik Bilgileri\n{1394BF}» {FFFFFF}Sicil Kaydý\n{1394BF}» {FFFFFF}Mülkler\n{1394BF}» {FFFFFF}Aranma Ekle\n{1394BF}» {FFFFFF}Aranma Sil\n{1394BF}» {FFFFFF}Ceza Yaz\n{1394BF}» {FFFFFF}Lokasyon Bul\n{1394BF}» {FFFFFF}Cezalar", "Seç", "Geri");
	        return 1;
	    }

	}
	else SetPVarInt(playerid, "ListPage", GetPVarInt(playerid, "ListPage")+1);

	SicilGoruntule(playerid, GetPVarInt(playerid, "KriminalVeritabani"));
	return 1;
}
Dialog:Mulkler(playerid, response, listitem, inputtext[])
{
	if (!response) return Dialog_Show(playerid, Kriminal, DIALOG_STYLE_LIST, "{1394BF}Mobil Veritabaný ~ Kriminal Veritabaný", "{1394BF}» {FFFFFF}Kimlik Bilgileri\n{1394BF}» {FFFFFF}Sicil Kaydý\n{1394BF}» {FFFFFF}Mülkler\n{1394BF}» {FFFFFF}Aranma Ekle\n{1394BF}» {FFFFFF}Aranma Sil\n{1394BF}» {FFFFFF}Ceza Yaz\n{1394BF}» {FFFFFF}Lokasyon Bul\n{1394BF}» {FFFFFF}Cezalar", "Seç", "Geri");
	if (response)
	{
	    new str[500], string[100];
	    new id = GetPVarInt(playerid, "KriminalVeritabani");
	    if (!OyundaDegil(id)) return HataMesajGonder(playerid, "Kiþi oyundan çýkmýþ.");
	    if (listitem == 0)
	    {
	        if (Ev_GetCount(id) < 1)
	        {
	            HataMesajGonder(playerid, "Bu kiþiye ait ev bulunamadý.");
	            return Dialog_Show(playerid, Mulkler, DIALOG_STYLE_LIST, "{1394BF}Mobil Veritabaný ~ Mülkler", "{1394BF}» {FFFFFF}Evler\n{1394BF}» {FFFFFF}Araçlar\n{1394BF}» {FFFFFF}Ýþyerleri\n{1394BF}» {FFFFFF}Gateler", "Seç", "Kapat");
	        }
	        strcat(str, "{1394BF}ID\t{1394BF}Ev Adý\t{1394BF}Adres\n");
	        for (new i; i<MAX_EV; i++) if (HouseInfo[i][evExists] && HouseInfo[i][evSahip] == PlayerData[id][pID])
	        {
	            format(string, sizeof(string), "{FFFFFF}%d\t{FFFFFF}%s\t{FFFFFF}%d, %s, %s\n", i, HouseInfo[i][evIsim], i, GetLocation(HouseInfo[i][evPos][0], HouseInfo[i][evPos][1], HouseInfo[i][evPos][2]), GetCityName(HouseInfo[i][evPos][0], HouseInfo[i][evPos][1], HouseInfo[i][evPos][2]));
	            strcat(str, string);
	        }
	        format(string, sizeof(string), "%s'in Evleri (%d adet)", ReturnName(id, 0), Ev_GetCount(id));
	        Dialog_Show(playerid, Evler, DIALOG_STYLE_TABLIST_HEADERS, string, str, "Ýþaretle", "Geri");
	    }
	    if (listitem == 1)
	    {
	        if (Car_GetCount(id) < 1)
	        {
	            HataMesajGonder(playerid, "Bu kiþiye ait araç bulunamadý.");
	            return Dialog_Show(playerid, Mulkler, DIALOG_STYLE_LIST, "{1394BF}Mobil Veritabaný ~ Mülkler", "{1394BF}» {FFFFFF}Evler\n{1394BF}» {FFFFFF}Araçlar\n{1394BF}» {FFFFFF}Ýþyerleri\n{1394BF}» {FFFFFF}Gateler", "Seç", "Kapat");
	        }
	        strcat(str, "{1394BF}Model\t{1394BF}Plaka\t{1394BF}Durum\n");
	        for (new i; i<MAX_ARAC; i++) if (AracInfo[i][aracExists] && AracInfo[i][aracSahip] == PlayerData[id][pID])
	        {
				format(string, sizeof(string), "{FFFFFF}%s\t{FFFFFF}%s\t{FFFFFF}%s\n",ReturnVehicleModelName(AracInfo[i][aracModel]), AracInfo[i][aracPlaka], (AracInfo[i][aracDisplay]) ? ("{2ECC71}Aktif") : ("{FF0000}Pasif"));
				strcat(str, string);
	        }
	        format(string, sizeof(string), "%s'in Araçlarý (%d adet)", ReturnName(id, 0), Car_GetCount(id));
	        Dialog_Show(playerid, Araclar, DIALOG_STYLE_TABLIST_HEADERS, string, str, "Geri", "");
	    }
	    if (listitem == 2)
	    {
	        if (Isyeri_GetCount(id) < 1)
	        {
	            HataMesajGonder(playerid, "Bu kiþiye ait iþyeri bulunamadý.");
	            return Dialog_Show(playerid, Mulkler, DIALOG_STYLE_LIST, "{1394BF}Mobil Veritabaný ~ Mülkler", "{1394BF}» {FFFFFF}Evler\n{1394BF}» {FFFFFF}Araçlar\n{1394BF}» {FFFFFF}Ýþyerleri\n{1394BF}» {FFFFFF}Gateler", "Seç", "Kapat");
	        }
	        strcat(str, "{1394BF}ID\t{1394BF}Ýþyeri Adý\t{1394BF}Adres\n");
	        for (new i; i<MAX_ISYERI; i++) if (Isyeri[i][isyeriExists] && Isyeri[i][isyeriSahip] == PlayerData[id][pID])
	        {
	            format(string, sizeof(string), "{FFFFFF}%d\t{FFFFFF}%s\t{FFFFFF}%s\n", i, Isyeri[i][isyeriName], GetLocation(Isyeri[i][isyeriPos][0],Isyeri[i][isyeriPos][1], Isyeri[i][isyeriPos][2]));
	            strcat(str, string);
	        }
	        format(string, sizeof(string), "%s'in Ýþyerleri (%d adet)", ReturnName(id, 0), Isyeri_GetCount(id));
	        Dialog_Show(playerid, Isyerler, DIALOG_STYLE_TABLIST_HEADERS, string, str, "Ýþaretle", "Geri");
	    }
	    if (listitem == 3)
	    {
	        new sayi;
	        strcat(str, "{1394BF}ID\t{1394BF}Model ID\t{1394BF}Adres\n");
	        for (new i; i<MAX_GATES; i++) if (GateData[i][gateExists] && GateData[i][gateOwner] == PlayerData[id][pID])
	        {
	            sayi++;
	            format(string, sizeof(string), "{FFFFFF}%d\t{FFFFFF}%d\t{FFFFFF}%s\n", i, GateData[i][gateModel], GetLocation(GateData[i][gatePos][0], GateData[i][gatePos][1], GateData[i][gatePos][2]));
	            strcat(str, string);
	        }
	        if (sayi == 0) return HataMesajGonder(playerid, "Bu kiþiye ait gate bulunmuyor.");
	        format(string, sizeof(string), "%s'in Gateleri (%d adet)", ReturnName(id, 0), sayi);
	        Dialog_Show(playerid, Gateler, DIALOG_STYLE_TABLIST_HEADERS, string, str, "Geri", "");
	    }
	}
	return 1;
}
Dialog:Gateler(playerid, response, listitem, inputtext[])
{
	if (response) return Dialog_Show(playerid, Mulkler, DIALOG_STYLE_LIST, "{1394BF}Mobil Veritabaný ~ Mülkler", "{1394BF}» {FFFFFF}Evler\n{1394BF}» {FFFFFF}Araçlar\n{1394BF}» {FFFFFF}Ýþyerleri\n{1394BF}» {FFFFFF}Gateler", "Seç", "Kapat");
	return 1;
}
Dialog:Araclar(playerid, response, listitem, inputtext[])
{
	if (response) return Dialog_Show(playerid, Mulkler, DIALOG_STYLE_LIST, "{1394BF}Mobil Veritabaný ~ Mülkler", "{1394BF}» {FFFFFF}Evler\n{1394BF}» {FFFFFF}Araçlar\n{1394BF}» {FFFFFF}Ýþyerleri\n{1394BF}» {FFFFFF}Gateler", "Seç", "Kapat");
	return 1;
}
Dialog:Isyerler(playerid, response, listitem, inputtext[])
{
	if (!response) return Dialog_Show(playerid, Mulkler, DIALOG_STYLE_LIST, "{1394BF}Mobil Veritabaný ~ Mülkler", "{1394BF}» {FFFFFF}Evler\n{1394BF}» {FFFFFF}Araçlar\n{1394BF}» {FFFFFF}Ýþyerleri\n{1394BF}» {FFFFFF}Gateler", "Seç", "Kapat");
	if (response)
	{
	    new isid = strval(inputtext);
	    if (Isyeri[isid][isyeriExists])
	    {
	    	callcmd::cpsifirla(playerid);
	        SetPVarInt(playerid, "AraciniBuluyor", 1);
	        DeletePVar(playerid, "KriminalVeritabani");
	        SetPlayerCheckpoint(playerid, Isyeri[isid][isyeriPos][0],Isyeri[isid][isyeriPos][1], Isyeri[isid][isyeriPos][2], 5.0);
	        MesajGonder(playerid, "Ýþyeri haritada iþaretlendi.");
	    }
	}
	return 1;
}
Dialog:Evler(playerid, response, listitem, inputtext[])
{
	if (!response) return Dialog_Show(playerid, Mulkler, DIALOG_STYLE_LIST, "{1394BF}Mobil Veritabaný ~ Mülkler", "{1394BF}» {FFFFFF}Evler\n{1394BF}» {FFFFFF}Araçlar\n{1394BF}» {FFFFFF}Ýþyerleri\n{1394BF}» {FFFFFF}Gateler", "Seç", "Kapat");
	if (response)
	{
	    new evid = strval(inputtext);
	    if (HouseInfo[evid][evExists])
	    {
	    	callcmd::cpsifirla(playerid);
	        SetPVarInt(playerid, "AraciniBuluyor", 1);
	        DeletePVar(playerid, "KriminalVeritabani");
	        SetPlayerCheckpoint(playerid, HouseInfo[evid][evPos][0],HouseInfo[evid][evPos][1], HouseInfo[evid][evPos][2], 5.0);
	        MesajGonder(playerid, "Ev haritada iþaretlendi.");
	    }
	}
	return 1;
}
Dialog:KimlikBilgileri(playerid, response, listitem, inputtext[])
{
	if (response) return Dialog_Show(playerid, Kriminal, DIALOG_STYLE_LIST, "{1394BF}Mobil Veritabaný ~ Kriminal Veritabaný", "{1394BF}» {FFFFFF}Kimlik Bilgileri\n{1394BF}» {FFFFFF}Sicil Kaydý\n{1394BF}» {FFFFFF}Mülkler\n{1394BF}» {FFFFFF}Aranma Ekle\n{1394BF}» {FFFFFF}Aranma Sil\n{1394BF}» {FFFFFF}Ceza Yaz\n{1394BF}» {FFFFFF}Lokasyon Bul\n{1394BF}» {FFFFFF}Cezalar", "Seç", "Geri");
	return 1;
}
Dialog:PlakaGir(playerid, response, listitem, inputtext[])
{
	if (!response) return callcmd::mdc(playerid);
	if (response)
	{
	    if (isnull(inputtext)) return Dialog_Show(playerid, PlakaGir, DIALOG_STYLE_INPUT, "{1394BF}Mobil Veritabaný ~ Plaka Incele", "{FFFFFF}Lütfen incelemek istediðiniz plakayý girin:", "Devam", "Geri");
	    new bulundu = -1;
	    for (new i; i<MAX_ARAC; i++) if (AracInfo[i][aracExists])
	    {
	        if (strcmp(inputtext, AracInfo[i][aracPlaka], false) == 0)
	        {
	            bulundu = i;
	            break;
	        }
	    }
	    if (bulundu == -1)
	    {
	        HataMesajGonder(playerid, "Geçersiz plaka girdiniz.");
	        return Dialog_Show(playerid, PlakaGir, DIALOG_STYLE_INPUT, "{1394BF}Mobil Veritabaný ~ Plaka Incele", "{FFFFFF}Lütfen incelemek istediðiniz plakayý girin:", "Devam", "Geri");
	    }
	    else
	    {
	        SetPVarInt(playerid, "PlakaInceleID", bulundu);
	        Dialog_Show(playerid, PlakaIncele, DIALOG_STYLE_LIST, "{1394BF}Mobil Veritabaný ~ Plaka Incele", "{1394BF}» {FFFFFF}Araç Bilgileri\n{1394BF}» {FFFFFF}Araca Ceza Yaz\n{1394BF}» {FFFFFF}Lokasyon Bul", "Seç", "Geri");
	    }
	}
	return 1;
}
Dialog:PlakaIncele(playerid, response, listitem, inputtext[])
{
	if (!response)
	{
	    DeletePVar(playerid, "PlakaInceleID");
	    callcmd::mdc(playerid);
	}
	else
	{
	    new id = GetPVarInt(playerid, "PlakaInceleID");
	    if (listitem == 0)
	    {
	        new str[500], string[100], factname[30];
	        format(string, sizeof(string), "{FFFFFF}Sahip: {9189EF}%s\n", (AracInfo[id][aracSahip] == -1) ? ("Yok") : SQLName(AracInfo[id][aracSahip], 0));
	        strcat(str, string);
	        format(string, sizeof(string), "{FFFFFF}Model: {9189EF}%s\n", ReturnVehicleModelName(AracInfo[id][aracModel]));
	        strcat(str, string);
         	format(string, sizeof(string), "{FFFFFF}Plaka: {9189EF}%s\n", AracInfo[id][aracPlaka]);
	        strcat(str, string);
	        if (AracInfo[id][aracFaction] == -1) format(factname, sizeof(factname), "Yok");
	        else format(factname, sizeof(factname), "%s", Birlikler[GetFactionByID(AracInfo[id][aracFaction])][birlikAd]);
	        format(string, sizeof(string), "{FFFFFF}Birlik/Kurum: {9189EF}%s\n", factname);
	        strcat(str, string);
	        format(string, sizeof(string), "{FFFFFF}Vergi: {9189EF}%s/%s\n",FormatNumber(AracInfo[id][aracVergi]), FormatNumber(GetAracMaksVergi(AracInfo[id][aracModel])));
	        strcat(str, string);
	        format(string, sizeof(string), "{FFFFFF}Ceza: {9189EF}%s",FormatNumber(AracInfo[id][aracTicket]));
	        strcat(str, string);

	        Dialog_Show(playerid, MVBAracBilgileri, DIALOG_STYLE_LIST, "{1394BF}Mobil Veritabaný ~ Araç Bilgileri", str, "Geri", "");
	    }
	    if (listitem == 1)
	    {
	        if (AracInfo[id][aracTip] != 4)
	        {
	            HataMesajGonder(playerid, "Bu araca ceza yazamazsýn.");
	            return Dialog_Show(playerid, PlakaIncele, DIALOG_STYLE_LIST, "{1394BF}Mobil Veritabaný ~ Plaka Incele", "{1394BF}» {FFFFFF}Araç Bilgileri\n{1394BF}» {FFFFFF}Araca Ceza Yaz\n{1394BF}» {FFFFFF}Lokasyon Bul", "Seç", "Geri");
	        }
	        Dialog_Show(playerid, AracCeza, DIALOG_STYLE_INPUT, "{1394BF}Mobil Veritabaný ~ Araç Ceza Yaz", "Lütfen ceza miktarýný girin:", "Ceza Kes", "Geri");
	    }
	    if (listitem == 2)
	    {
	        new Float:pos[3];
	        if (IsValidVehicle(AracInfo[id][aracVehicle]) && AracInfo[id][aracDisplay] == 1)
	        {
	            GetVehiclePos(AracInfo[id][aracVehicle], pos[0], pos[1], pos[2]);
	            MesajGonder(playerid, "Araçtan alýnan son sinyal: %s", GetLocation(pos[0], pos[1], pos[2]));
	        }
	        else HataMesajGonder(playerid, "Araçtan sinyal alýnamadý.");
	    }
	}
	return 1;
}
Dialog:AracCeza(playerid, response, listitem, inputtext[])
{
	if (!response) return Dialog_Show(playerid, PlakaIncele, DIALOG_STYLE_LIST, "{1394BF}Mobil Veritabaný ~ Plaka Incele", "{1394BF}» {FFFFFF}Araç Bilgileri\n{1394BF}» {FFFFFF}Araca Ceza Yaz\n{1394BF}» {FFFFFF}Lokasyon Bul", "Seç", "Geri");
	if (response)
	{
	    if (isnull(inputtext)) return Dialog_Show(playerid, AracCeza, DIALOG_STYLE_INPUT, "{1394BF}Mobil Veritabaný ~ Araç Ceza Yaz", "Lütfen ceza miktarýný girin:", "Ceza Kes", "Geri");
	    if (!IsNumeric(inputtext)) return Dialog_Show(playerid, AracCeza, DIALOG_STYLE_INPUT, "{1394BF}Mobil Veritabaný ~ Araç Ceza Yaz", "Lütfen ceza miktarýný girin:", "Ceza Kes", "Geri");
	    if (strval(inputtext) < 50 || strval(inputtext) > 10000)
	    {
	        HataMesajGonder(playerid, "Ceza miktarý $50 ile $10,000 arasýnda olmalýdýr.");
	        return Dialog_Show(playerid, AracCeza, DIALOG_STYLE_INPUT, "{1394BF}Mobil Veritabaný ~ Araç Ceza Yaz", "Lütfen ceza miktarýný girin:", "Ceza Kes", "Geri");
	    }
	    new id = GetPVarInt(playerid, "PlakaInceleID");
		if (AracInfo[id][aracModel] == 509) return HataMesajGonder(playerid, "Bu araca ceza yazamazsýn!");
	    AracInfo[id][aracTicket] += strval(inputtext);
	    if (AracInfo[id][aracTicketTime] < gettime()) AracInfo[id][aracTicketTime] = gettime()+3*86400;
	    SendBirlikMessage(PlayerData[playerid][pFaction], COLOR_DEPARTMENT, "** DEPARTMAN: %s %s, %s plakalý araca %s miktar ceza kesti.", Birlik_GetRutbe(playerid), ReturnName(playerid, 0), AracInfo[id][aracPlaka], FormatNumber(strval(inputtext)));
	    if (AracInfo[id][aracSahip] != -1)
	    {
	        if (GetPlayerIDWithSQLID(AracInfo[id][aracSahip]) != -1)
	        {
	            BilgiMesajGonder(GetPlayerIDWithSQLID(AracInfo[id][aracSahip]), "%s adlý memur %s model aracýnýza %s miktar ceza kesti.", ReturnName(playerid, 0), ReturnVehicleModelName(AracInfo[id][aracModel]), FormatNumber(strval(inputtext)));
	            BilgiMesajGonder(GetPlayerIDWithSQLID(AracInfo[id][aracSahip]), "Cezayý 72 saat içerisinde ödemezseniz aracýnýza devlet tarafýndan el koyulacak.");
	        }
	        else
	        {
	            new str[80];
	            format(str, sizeof(str), "%s adlý memur %s model aracýnýza %s ceza kesti.", ReturnName(playerid, 0), ReturnVehicleModelName(AracInfo[id][aracModel]), FormatNumber(strval(inputtext)));
	            BildirimEkle(AracInfo[id][aracSahip], str, "LSPD");
	        }
	    }
	}
	return 1;
}
Dialog:MVBAracBilgileri(playerid, response, listitem, inputtext[])
{
	if (response) return Dialog_Show(playerid, PlakaIncele, DIALOG_STYLE_LIST, "{1394BF}Mobil Veritabaný ~ Plaka Incele", "{1394BF}» {FFFFFF}Araç Bilgileri\n{1394BF}» {FFFFFF}Araca Ceza Yaz\n{1394BF}» {FFFFFF}Lokasyon Bul", "Seç", "Geri");
	return 1;
}
Dialog:CCTV(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		new cid = strval(inputtext);
		if (Iter_Contains(CCTVIter, cid))
		{
			PlayerViewCCTV(playerid, cid);
		}
	}
	return 1;
}
Dialog:LSMDDolap(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (GetFactionType(playerid) != BIRLIK_LSMD) return 1;
	    if (listitem == 0)
	    {
	        if (!PlayerData[playerid][pOnDuty])
	        {
	            PlayerData[playerid][pOnDuty] = true;
                SetFactionColor(playerid);
                SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s dolabý açar ve ekipmanlarýný alýr.", ReturnName(playerid, 0));
	        }
	        else
	        {
	            PlayerData[playerid][pOnDuty] = false;
                SetPlayerColor(playerid, 0xFFFFFFFF);
                SetPlayerSkin(playerid, PlayerData[playerid][pSkin]);
                ResetWeapons(playerid);
                SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s dolabý açar ve ekipmanlarýný dolaba býrakýr.", ReturnName(playerid, 0));
	        }
	    }
	    if (listitem == 1)
	    {
	        new yazi[200];
	        for (new i; i<sizeof(DoktorSkinler); i++)
         	{
          		format(yazi,sizeof(yazi), "%s%d\n",yazi,DoktorSkinler[i]);
          	}
            ShowPlayerDialog(playerid, 69, DIALOG_STYLE_PREVMODEL, "Kýyafetler",yazi, "Sec", "Iptal");
	    }
	    if (listitem == 2)
	    {
	        Dialog_Show(playerid, LSMDEkipmanlar, DIALOG_STYLE_LIST, "{FF8282}Ekipmanlar", "{FF8282}» {FFFFFF}Sprey\n{FF8282}» {FFFFFF}Yangýn Söndürücü\n{FF8282}» {FFFFFF}Aðrý Kesici", "Seç", "Kapat");
		}
	}
	return 1;
}
Dialog:LSMDEkipmanlar(playerid, response, listitem, inputtext[])
{
	if (!response) return callcmd::dolap(playerid);
	if (response)
	{
	    if (listitem == 0)
	    {
	        if (PlayerHasWeapon(playerid, 41))
	        {
	            HataMesajGonder(playerid, "Zaten spreyiniz var!");
	            return Dialog_Show(playerid, LSMDEkipmanlar, DIALOG_STYLE_LIST, "{FF8282}Ekipmanlar", "{FF8282}» {FFFFFF}Sprey\n{FF8282}» {FFFFFF}Yangýn Söndürücü\n{FF8282}» {FFFFFF}Aðrý Kesici", "Seç", "Kapat");
	        }
	        GiveWeaponToPlayer(playerid, 41, 1000);
	        Dialog_Show(playerid, LSMDEkipmanlar, DIALOG_STYLE_LIST, "{FF8282}Ekipmanlar", "{FF8282}» {FFFFFF}Sprey\n{FF8282}» {FFFFFF}Yangýn Söndürücü\n{FF8282}» {FFFFFF}Aðrý Kesici", "Seç", "Kapat");
	    }
	    if (listitem == 1)
	    {
	        if (PlayerHasWeapon(playerid, 42))
	        {
	            HataMesajGonder(playerid, "Zaten yangýn söndürücünüz var!");
	            return Dialog_Show(playerid, LSMDEkipmanlar, DIALOG_STYLE_LIST, "{FF8282}Ekipmanlar", "{FF8282}» {FFFFFF}Sprey\n{FF8282}» {FFFFFF}Yangýn Söndürücü\n{FF8282}» {FFFFFF}Aðrý Kesici", "Seç", "Kapat");
	        }
	        GiveWeaponToPlayer(playerid, 42, 1000);
         	Dialog_Show(playerid, LSMDEkipmanlar, DIALOG_STYLE_LIST, "{FF8282}Ekipmanlar", "{FF8282}» {FFFFFF}Sprey\n{FF8282}» {FFFFFF}Yangýn Söndürücü\n{FF8282}» {FFFFFF}Aðrý Kesici", "Seç", "Kapat");
		}
		if (listitem == 2)
		{
		    CanAyarla(playerid,100.0);
	        SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s dolaptan aðrý kesici alýr ve içer.", ReturnName(playerid, 0));
		}
	}
	return 1;
}
Dialog:LSPDDolap(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (PlayerData[playerid][pFaction] == -1) return 1;
	    if (listitem == 0)
	    {
            if (!PlayerData[playerid][pOnDuty])
            {
                PlayerData[playerid][pOnDuty] = true;
                SetFactionColor(playerid);
                SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s dolabý açar ve ekipmanlarýný alýr.", ReturnName(playerid, 0));
            }
            else
            {
                PlayerData[playerid][pOnDuty] = false;
                SetPlayerColor(playerid, 0xFFFFFFFF);
                SetPlayerSkin(playerid, PlayerData[playerid][pSkin]);
                SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s dolabý açar ve ekipmanlarýný dolaba býrakýr.", ReturnName(playerid, 0));
            }
	    }
	    if (listitem == 1)
	    {
	        new yazi[500];
	        for (new i; i<sizeof(PolisSkinler); i++)
         	{
          		format(yazi,sizeof(yazi), "%s%d\n",yazi,PolisSkinler[i]);
          	}
            ShowPlayerDialog(playerid, 61, DIALOG_STYLE_PREVMODEL, "Polis kýyafetler",yazi, "Sec", "Iptal");
	    }
	    if (listitem == 2)
	    {

	        Dialog_Show(playerid,LSPDEkipmanlar,DIALOG_STYLE_LIST, "{1394BF}Ekipmanlar", "{1394BF}» {FFFFFF}Devriye Ekipmanlarý\n{1394BF}» {FFFFFF}Özel Ekipmanlar\n{1394BF}» {FFFFFF}Aksesuarlar\n{1394BF}» {FFFFFF}Aðrý Kesici\n{1394BF}» {FFFFFF}Çelik Yelek", "Seç", "Kapat");
	    }
	    if (listitem == 3)
	    {
	        ResetWeapons(playerid);
	    }
	}
	return 1;
}
Dialog:LSPDEkipmanlar(playerid, response, listitem, inputtext[])
{
	if (!response) return callcmd::dolap(playerid);
	if (response)
	{
	    if (listitem == 0)
	    {
	        Dialog_Show(playerid,DevriyeEkipmanlari,DIALOG_STYLE_LIST, "{1394BF}Devriye Ekipmanlari", "{1394BF}» {FFFFFF}Deagle\n{1394BF}» {FFFFFF}Sprey\n{1394BF}» {FFFFFF}Jop", "Seç", "Geri");
	    }
	    if (listitem == 1)
	    {
	        Dialog_Show(playerid,OzelEkipmanlar,DIALOG_STYLE_LIST, "{1394BF}Özel Ekipmanlar", "{1394BF}» {FFFFFF}M4\n{1394BF}» {FFFFFF}MP5\n{1394BF}» {FFFFFF}Shotgun\n{1394BF}» {FFFFFF}Göz Yaþartýcý Gaz", "Seç", "Geri");
	    }
	    if (listitem == 2) // Aksesuarlar
	    {
	        AksesuarlariGoster(playerid,2);
	    }
	    if (listitem == 3)
	    {
	        CanAyarla(playerid,100.0);
	        SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s dolaptan aðrý kesici alýr ve içer.", ReturnName(playerid, 0));
	    }
	    if (listitem == 4)
	    {
	        ZirhAyarla(playerid,100.0);
	        SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s dolaptan çelik yelek alýr ve giyer.", ReturnName(playerid, 0));
	    }
	}
	return 1;
}
Dialog:DevriyeEkipmanlari(playerid, response, listitem, inputtext[])
{
	if (!response) return Dialog_Show(playerid,LSPDEkipmanlar,DIALOG_STYLE_LIST, "{1394BF}Ekipmanlar", "{1394BF}» {FFFFFF}Devriye Ekipmanlarý\n{1394BF}» {FFFFFF}Özel Ekipmanlar\n{1394BF}» {FFFFFF}Aksesuarlar\n{1394BF}» {FFFFFF}Aðrý Kesici\n{1394BF}» {FFFFFF}Çelik Yelek", "Seç", "Kapat");
	if (response)
	{
	    if (listitem == 0)
	    {
		    if (PlayerHasWeapon(playerid, 24)) return HataMesajGonder(playerid, "Zaten bu silaha sahipsin.");
		    if (PlayerData[playerid][pSilahlar][g_aWeaponSlots[24]] != 0) return HataMesajGonder(playerid, "Bu silah türü sizde var.");
		    GiveWeaponToPlayer(playerid, 24, 110);
		    Dialog_Show(playerid,DevriyeEkipmanlari,DIALOG_STYLE_LIST, "{1394BF}Devriye Ekipmanlari", "{1394BF}» {FFFFFF}Deagle\n{1394BF}» {FFFFFF}Sprey\n{1394BF}» {FFFFFF}Jop", "Seç", "Geri");
	    }
	    if (listitem == 1)
	    {
	        if (PlayerHasWeapon(playerid, 41)) return HataMesajGonder(playerid, "Zaten bu silaha sahipsin.");
	        if (PlayerData[playerid][pSilahlar][g_aWeaponSlots[41]] != 0) return HataMesajGonder(playerid, "Bu silah türü sizde var.");
	        GiveWeaponToPlayer(playerid, 41, 1000);
	        Dialog_Show(playerid,DevriyeEkipmanlari,DIALOG_STYLE_LIST, "{1394BF}Devriye Ekipmanlari", "{1394BF}» {FFFFFF}Deagle\n{1394BF}» {FFFFFF}Sprey\n{1394BF}» {FFFFFF}Jop", "Seç", "Geri");
	    }
	    if (listitem == 2)
	    {
	        if (PlayerHasWeapon(playerid, 3)) return HataMesajGonder(playerid, "Zaten bu silaha sahipsin.");
	        if (PlayerData[playerid][pSilahlar][g_aWeaponSlots[3]] != 0) return HataMesajGonder(playerid, "Bu silah türü sizde var.");
	        GiveWeaponToPlayer(playerid, 3, 1);
	        Dialog_Show(playerid,DevriyeEkipmanlari,DIALOG_STYLE_LIST, "{1394BF}Devriye Ekipmanlari", "{1394BF}» {FFFFFF}Deagle\n{1394BF}» {FFFFFF}Sprey\n{1394BF}» {FFFFFF}Jop", "Seç", "Geri");
	    }
	}
	return 1;
}
Dialog:OzelEkipmanlar(playerid, response, listitem, inputtext[])
{
	if (!response) return Dialog_Show(playerid,LSPDEkipmanlar,DIALOG_STYLE_LIST, "{1394BF}Ekipmanlar", "{1394BF}» {FFFFFF}Devriye Ekipmanlarý\n{1394BF}» {FFFFFF}Özel Ekipmanlar\n{1394BF}» {FFFFFF}Aksesuarlar\n{1394BF}» {FFFFFF}Aðrý Kesici\n{1394BF}» {FFFFFF}Çelik Yelek", "Seç", "Kapat");
	if (response)
	{
	    if (listitem == 0)
	    {
		    if (PlayerHasWeapon(playerid, 31)) return HataMesajGonder(playerid, "Zaten bu silaha sahipsin.");
		    if (PlayerData[playerid][pSilahlar][g_aWeaponSlots[31]] != 0) return HataMesajGonder(playerid, "Bu silah türü sizde var.");
		    GiveWeaponToPlayer(playerid, 31, 1000);
		    Dialog_Show(playerid,OzelEkipmanlar,DIALOG_STYLE_LIST, "{1394BF}Özel Ekipmanlar", "{1394BF}» {FFFFFF}M4\n{1394BF}» {FFFFFF}MP5\n{1394BF}» {FFFFFF}Shotgun\n{1394BF}» {FFFFFF}Göz Yaþartýcý Gaz", "Seç", "Geri");
	    }
	    if (listitem == 1)
	    {
	        if (PlayerHasWeapon(playerid, 29)) return HataMesajGonder(playerid, "Zaten bu silaha sahipsin.");
	        if (PlayerData[playerid][pSilahlar][g_aWeaponSlots[29]] != 0) return HataMesajGonder(playerid, "Bu silah türü sizde var.");
	        GiveWeaponToPlayer(playerid, 29, 1000);
	        Dialog_Show(playerid,OzelEkipmanlar,DIALOG_STYLE_LIST, "{1394BF}Özel Ekipmanlar", "{1394BF}» {FFFFFF}M4\n{1394BF}» {FFFFFF}MP5\n{1394BF}» {FFFFFF}Shotgun\n{1394BF}» {FFFFFF}Göz Yaþartýcý Gaz", "Seç", "Geri");
	    }
	    if (listitem == 2)
	    {
	        if (PlayerHasWeapon(playerid, 25)) return HataMesajGonder(playerid, "Zaten bu silaha sahipsin.");
	        if (PlayerData[playerid][pSilahlar][g_aWeaponSlots[25]] != 0) return HataMesajGonder(playerid, "Bu silah türü sizde var.");
	        GiveWeaponToPlayer(playerid, 25, 150);
	        Dialog_Show(playerid,OzelEkipmanlar,DIALOG_STYLE_LIST, "{1394BF}Özel Ekipmanlar", "{1394BF}» {FFFFFF}M4\n{1394BF}» {FFFFFF}MP5\n{1394BF}» {FFFFFF}Shotgun\n{1394BF}» {FFFFFF}Göz Yaþartýcý Gaz", "Seç", "Geri");
	    }
	    if (listitem == 3)
	    {
	        if (PlayerHasWeapon(playerid, 17)) return HataMesajGonder(playerid, "Zaten bu silaha sahipsin.");
	        if (PlayerData[playerid][pSilahlar][g_aWeaponSlots[17]] != 0) return HataMesajGonder(playerid, "Bu silah türü sizde var.");
	        GiveWeaponToPlayer(playerid, 17, 50);
	        Dialog_Show(playerid,OzelEkipmanlar,DIALOG_STYLE_LIST, "{1394BF}Özel Ekipmanlar", "{1394BF}» {FFFFFF}M4\n{1394BF}» {FFFFFF}MP5\n{1394BF}» {FFFFFF}Shotgun\n{1394BF}» {FFFFFF}Göz Yaþartýcý Gaz", "Seç", "Geri");
	    }
	}
	return 1;
}
Dialog:AracAlimOnay(playerid, response, listitem, inputtext[])
{
	if (!response) return RemovePlayerFromVehicle(playerid);
	if (response)
	{
	    new id = Car_GetID(GetPlayerVehicleID(playerid));
	    if (Car_GetCount(playerid) >= MAX_OWNABLE_CARS) return HataMesajGonder(playerid, "En fazla %d araca sahip olabilirsiniz.",MAX_OWNABLE_CARS);
	    if (AracInfo[id][aracFiyat] <=0) return 1;
	    if (AracInfo[id][aracSahip] == PlayerData[playerid][pID]) return 1;
	    if (PlayerData[playerid][pCash] < AracInfo[id][aracFiyat]) return HataMesajGonder(playerid, "Yeterli paranýz yok.");
	    ParaVer(playerid,-AracInfo[id][aracFiyat]);
	    if (AracInfo[id][aracSahip] != -1)
	    {
		    if (GetPlayerIDWithSQLID(AracInfo[id][aracSahip]) != -1)
		    {
		        ParaVer(GetPlayerIDWithSQLID(AracInfo[id][aracSahip]),AracInfo[id][aracFiyat]);
		        MesajGonder(GetPlayerIDWithSQLID(AracInfo[id][aracSahip]), "%s adlý kiþi aracýnýzý {48FF00}%s {FFFFFF}ödeyerek satýn aldý.",ReturnName(playerid,0),FormatNumber(AracInfo[id][aracFiyat]));
		    }
		    else
		    {
		        OfflineParaVer(AracInfo[id][aracSahip],AracInfo[id][aracFiyat]);
		        new str[100];
		        format(str,sizeof(str), "%s adlý kiþi aracýnýzý %s ödeyerek satýn aldý.",ReturnName(playerid,0),FormatNumber(AracInfo[id][aracFiyat]));
		        BildirimEkle(AracInfo[id][aracSahip],str, "Sistem");
		    }
	    }
	    if (Arac_GetKeyCount(id) > 0)
		{
		    new query[60];
			format(query, sizeof(query), "DELETE FROM `anahtarlar` WHERE `sqlid` = '%d' AND `tip` = '2'",AracInfo[id][aracID]);
			mysql_query(g_SQL, query, false);
		}
		MesajGonder(playerid, "'%s' model aracý {48FF00}%s {FFFFFF}ödeyerek satýn aldýnýz.",ReturnVehicleModelName(GetVehicleModel(GetPlayerVehicleID(playerid))),FormatNumber(AracInfo[id][aracFiyat]));
	    AracInfo[id][aracSahip] = PlayerData[playerid][pID];
	    AracInfo[id][aracFiyat] = 0;
	    AracInfo[id][aracSatilik] = 0;
	    UpdateDynamic3DTextLabelText(AracInfo[id][aracLabel], -1, " ");
	    DestroyDynamic3DTextLabel(AracInfo[id][aracLabel]);
	    Arac_Kaydet(id);
	}
	return 1;
}
Dialog:AracAyarlari(playerid, response, listitem, inputtext[])
{
	if (!response) return DeletePVar(playerid, "CarID");
	if (response)
	{
	    new id = GetPVarInt(playerid, "CarID");
	    if (strfind(inputtext, "Araç Bilgileri", true) != -1)
	    {
		    new string[650];
		    format(string,sizeof(string), "{C2A2DA}Araç ID: {FFFFFF}%d\n{C2A2DA}Araç Vergi: {FFFFFF}%s/%s\n{C2A2DA}Araç Plaka: {FFFFFF}%s\n{C2A2DA}Araç Kilometre: {FFFFFF}%.1f\n{C2A2DA}Araç Benzin: {FFFFFF}%.2f\n{C2A2DA}Zýrh: %s\n{C2A2DA}Taksi Plakasý: %s\n{C2A2DA}Galeri Fiyatý: {2ECC71}%s",
			id,FormatNumber(AracInfo[id][aracVergi]),FormatNumber(GetAracMaksVergi(AracInfo[id][aracModel])), AracInfo[id][aracPlaka],AracInfo[id][aracKM],AracInfo[id][aracBenzin], (AracInfo[id][aracZirhVarMi] > 0) ? ("{7df442}Var") : ("{ff0000}Yok"), (AracInfo[id][TaksiPlaka] == 1) ? ("{7df442}Var") : ("{ff0000}Yok"),FormatNumber(GetGaleriFiyat(AracInfo[id][aracModel])));
		    Dialog_Show(playerid,AracBilgileri,DIALOG_STYLE_MSGBOX, "Araç Bilgileri",string, "Tamam", "Geri");
	    }
	    if (strfind(inputtext, "Motor", true) != -1)
	    {
	        callcmd::motor(playerid);
	        callcmd::arac(playerid);
		}
		if (strfind(inputtext, "Kilit", true) != -1)
	    {
	        callcmd::kilit(playerid);
	        callcmd::arac(playerid);
		}
		if (strfind(inputtext, "Farlar", true) != -1)
	    {
	        callcmd::farlar(playerid);
	        callcmd::arac(playerid);
		}
		if (strfind(inputtext, "Camlar", true) != -1)
	    {
	        callcmd::camlar(playerid);
	        callcmd::arac(playerid);
		}
		if (strfind(inputtext, "Kaput", true) != -1)
	    {
	        callcmd::kaput(playerid);
	        callcmd::arac(playerid);
		}
		if (strfind(inputtext, "Bagaj", true) != -1)
	    {
	        callcmd::bagaj(playerid);
		}
	    if (strfind(inputtext, "Birlik aracý yap/çýkart", true) != -1)
	    {
    		 if (AracInfo[id][aracFaction] == -1)
	         {

			    if (PlayerData[playerid][pFaction] == -1) return HataMesajGonder(playerid, "Birliðiniz yok.");
	            if (GetFactionType(playerid) != BIRLIK_CETE && GetFactionType(playerid) != BIRLIK_MAFYA && GetFactionType(playerid) != BIRLIK_HABER && GetFactionType(playerid) != BIRLIK_LEGAL) return HataMesajGonder(playerid, "Bu birliðe araç ekleyemezsiniz.");
				AracInfo[id][aracFactionType] = GetFactionType(playerid);
				AracInfo[id][aracFaction] = Birlikler[PlayerData[playerid][pFaction]][birlikID];
	            MesajGonder(playerid, "Aracýnýzý artýk birliðinizin üyeleri kullanabilecek.");
	            Arac_Kaydet(id);
				callcmd::arac(playerid);
			 }
			 else
			 {
			   	AracInfo[id][aracFactionType] = 0;
				AracInfo[id][aracFaction] = -1;
			    MesajGonder(playerid, "Aracýnýzý artýk birliðinizin üyeleri kullanamayacak.");
			    Arac_Kaydet(id);
			    callcmd::arac(playerid);
			 }
	    }
		if (strfind(inputtext, "Aracý Sat", true) != -1)
		{
		    Dialog_Show(playerid,AracSat,DIALOG_STYLE_INPUT, "{FFFFFF}Araç Sat", "Lutfen aracýn satýþ fiyatýný yazýn.\n\n{FF0000}NOT: {FFFFFF}0 yazarsanýz aracýnýz artýk satýlýk olmaz.", "Tamam", "Geri");
		}
		if (strfind(inputtext, "Anahtarlar", true) != -1)
		{
		    if (Arac_GetKeyCount(id) < 1)
		    {
		        callcmd::arac(playerid);
		        return HataMesajGonder(playerid, "Bu aracýn anahtarý kimseye verilmemiþ, /anahtarver ile verebilirsiniz.");
		    }
		    Arac_KeyDialog(playerid, id);
		}
		if (strfind(inputtext, "Modifiye Kontrolü", true) != -1)
		{
		    SetPVarInt(playerid, "ModifiyeID", id);
		    AracModifiyeler(playerid, id);
		}
	}
	return 1;
}
Dialog:AracModifiyeler(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    new aracid = GetPVarInt(playerid, "ModifiyeID");
	    if (listitem == 0)
	    {
	        if (AracInfo[aracid][aracPaintjob] == -1)
	        {
	            HataMesajGonder(playerid, "Paintjob yok.");
	            return AracModifiyeler(playerid, aracid);
	        }
	        AracInfo[aracid][aracPaintjob] = -1;
	        ChangeVehiclePaintjob(AracInfo[aracid][aracVehicle], 3);
	        MesajGonder(playerid, "Paintjob kaldýrýldý.");
	        AracModifiyeler(playerid, aracid);
	        return 1;
	    }
	    new id = ModifiyeListeleme[playerid][listitem-1];
	    if (AracInfo[aracid][aracMods][id] > 0)
	    {
	        RemoveVehicleComponent(AracInfo[aracid][aracVehicle], AracInfo[aracid][aracMods][id]);
	        AracInfo[aracid][aracMods][id] = 0;
	        AracModifiyeler(playerid, aracid);
	        MesajGonder(playerid, "Modifiye kaldýrýldý.");
	    }
	}
	return 1;
}
Dialog:AracSat(playerid, response, listitem, inputtext[])
{
	if (!response) return callcmd::arac(playerid);
	if (response)
	{
	    new id = GetPVarInt(playerid, "CarID");
	    if (!IsNumeric(inputtext)) return Dialog_Show(playerid,AracSat,DIALOG_STYLE_INPUT, "{FFFFFF}Araç Sat", "Lutfen aracýn satýþ fiyatýný yazýn.\n\n{FF0000}NOT: {FFFFFF}0 yazarsanýz aracýnýz artýk satýlýk olmaz.", "Tamam", "Geri");
	    if (strval(inputtext) < 0)
	    {
	        HataMesajGonder(playerid, "Geçersiz sayý girdiniz.");
	        return Dialog_Show(playerid,AracSat,DIALOG_STYLE_INPUT, "{FFFFFF}Araç Sat", "Lutfen aracýn satýþ fiyatýný yazýn.\n\n{FF0000}NOT: {FFFFFF}0 yazarsanýz aracýnýz artýk satýlýk olmaz.", "Tamam", "Geri");
	    }
	    if (strval(inputtext) <= 0)
	    {
	        AracInfo[id][aracSatilik] = 0;
	        AracInfo[id][aracFiyat] = 0;
	        Arac_Kaydet(id);
	        UpdateDynamic3DTextLabelText(AracInfo[id][aracLabel], -1, " ");
	        DestroyDynamic3DTextLabel(AracInfo[id][aracLabel]);
	        //Arac_Spawn(id);
	        BilgiMesajGonder(playerid, "Araç artýk satýlýk deðil.");
	    }
	    else
	    {
	        UpdateDynamic3DTextLabelText(AracInfo[id][aracLabel], -1, " ");
	        DestroyDynamic3DTextLabel(AracInfo[id][aracLabel]);
	        AracInfo[id][aracSatilik] = 1;
	        AracInfo[id][aracFiyat] = strval(inputtext);
	        Arac_Kaydet(id);
	        new str[120];

		    format(str,sizeof(str), "{00FF00}.:SATILIK:.\n{00FF00}Fiyat: %s\n{00FF00}%d",FormatNumber(AracInfo[id][aracFiyat]), (PlayerData[playerid][pTelefon] == -1) ? (0) : (PlayerData[playerid][pTelefon]));
		    AracInfo[id][aracLabel] = CreateDynamic3DTextLabel(str,-1, 0.0, -2.5, 0.4,30.0,INVALID_PLAYER_ID,AracInfo[id][aracVehicle], 1);

		    MesajGonder(playerid, "Aracýnýz satýlýða çýkarýldý. (Fiyat: %s)", FormatNumber(AracInfo[id][aracFiyat]));
	    }
	}
	return 1;
}
Dialog:AracBilgileri(playerid, response, listitem, inputtext[])
{
	if (!response || response) return callcmd::arac(playerid);
	return 1;
}
Dialog:AracServis(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    new notreal[128], idx;
		notreal = strtok(inputtext, idx);
		new vehicleid = strval(notreal), carid = Car_GetID(vehicleid);
		if (!AracInfo[carid][aracDisplay]) return HataMesajGonder(playerid, "Bu araç pasif durumda. (/araclarim)");
		if (PlayerData[playerid][pCash] < 1000) return HataMesajGonder(playerid, "Yeterli paranýz yok. ($3000)");
		SetTimerEx("AracServis2",3500,false, "i",playerid);

		new Float:x,Float:y,Float:z;
		static
	 		Float:px,
	 		Float:py,
    		Float:pz;

		GetPlayerPos(playerid, px, py, pz);
	 	SetVehiclePos(vehicleid, px + 3, py - 3, pz);
	 	SetVehicleVirtualWorld(vehicleid, GetPlayerVirtualWorld(playerid));
	 	LinkVehicleToInteriorEx(vehicleid, GetPlayerInterior(playerid));
		GetVehiclePos(vehicleid,x,y,z);
		callcmd::cpsifirla(playerid);
		ParaVer(playerid, -3000);
	 	BilgiMesajGonder(playerid, "Aracýnýzý servis görevlisi þu noktaya býraktý: %s ",GetLocation(x,y,z));
	}
	return 1;
}
Dialog:AracimiBul(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    new notreal[128], idx;
		notreal = strtok(inputtext, idx);
		new vehicleid = strval(notreal), carid = Car_GetID(vehicleid);
		if (!AracInfo[carid][aracDisplay]) return HataMesajGonder(playerid, "Bu araç pasif durumda. (/araclarim)");
		new Float:x,Float:y,Float:z;
		GetVehiclePos(vehicleid,x,y,z);
		callcmd::cpsifirla(playerid);
	 	SetPlayerCheckpoint(playerid, x, y, z, 5.0);
	 	BilgiMesajGonder(playerid, "Aracýnýzýn son görüldüðü yer: %s (haritada iþaretlendi)",GetLocation(x,y,z));
	 	SetPVarInt(playerid, "AraciniBuluyor",1);
	}
	return 1;
}
Dialog:Araclarim(playerid, response, listitem, inputtext[]) {
	if (response)
	{
	    new notreal[128], idx;
		notreal = strtok(inputtext, idx);
		new vehicleid = strval(notreal), carid = Car_GetID(vehicleid);

		if (AracInfo[carid][aracDisplay])
		{
		    if (AracInfo[carid][aracGaraj] != -1) return HataMesajGonder(playerid, "Garajdaki araçlarý saklayamazsýn.");
			if (!IsPlayerInVehicle(playerid, AracInfo[carid][aracVehicle])) return HataMesajGonder(playerid, "Aracýnýzda deðilsiniz.");
			callcmd::cpsifirla(playerid);
			SetPlayerCheckpoint(playerid, AracInfo[carid][aracPos][0], AracInfo[carid][aracPos][1], AracInfo[carid][aracPos][2], 5.0);
			MesajGonder(playerid, "Park alaný haritada iþaretlendi.");
			SetPVarInt(playerid, "AracSakliyor", carid);
			}
		    if(ilkarabalars == 1)
		    {
			  	static
				    Float:x,
				    Float:y,
				    Float:z;

				GetPlayerPos(playerid, x, y, z);
				SetVehiclePos(AracInfo[carid][aracVehicle], x + 2, y - 2, z);

			 	SetVehicleVirtualWorld(AracInfo[carid][aracVehicle], GetPlayerVirtualWorld(playerid));
				LinkVehicleToInterior(AracInfo[carid][aracVehicle], GetPlayerInterior(playerid));
			    AracInfo[carid][aracDisplay] = 1;
				MesajGonder(playerid, "Araç baþarýyla yanýnýza iþýnlandý.");
		}
		else
		{
		    if (AracInfo[carid][aracBaglandi] == 1) return HataMesajGonder(playerid, "Aracýnýz baðlanmýþ.");
			if (AracInfo[carid][aracElKonuldu] == 1) return HataMesajGonder(playerid, "Aracýnýza el koyulmuþ.");
		    AracInfo[carid][aracDisplay] = true;
		    MesajGonder(playerid, "Aracýnýz en son park ettiðiniz yere spawn edildi. (/aracimibul)");
      		SetVehicleVirtualWorld(vehicleid, AracInfo[carid][aracWorld]);
		    LinkVehicleToInteriorEx(vehicleid, AracInfo[carid][aracInterior]);
		}
	}
	return 1;
}
Dialog:IsyeriDialog(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    new id = GetPVarInt(playerid, "IsyeriID");
	    if (strfind(inputtext, "Kilit Durumu", true) != -1)
	    {
	        if (Isyeri[id][isyeriSahip] != PlayerData[playerid][pID] && (PlayerData[playerid][pAdmin] < 2 || PlayerData[playerid][pAdminDuty] != 1)) return 1;
	        if (!Isyeri[id][isyeriKilit])
	        {
	            Isyeri[id][isyeriKilit] = true;
	            callcmd::isyeri(playerid);
	            Isyeri_Yenile(id);
	            Isyeri_Kaydet(id);
	        }
	        else
	        {
	            Isyeri[id][isyeriKilit] = false;
	            callcmd::isyeri(playerid);
	            Isyeri_Yenile(id);
	            Isyeri_Kaydet(id);
	        }
	    }
	    if (strfind(inputtext, "Ýþyeri Adý", true) != -1)
	    {
	        if (Isyeri[id][isyeriSahip] != PlayerData[playerid][pID] && (PlayerData[playerid][pAdmin] < 2 || PlayerData[playerid][pAdminDuty] != 1)) return 1;
	        Dialog_Show(playerid,IsyeriAdDuzenleme,DIALOG_STYLE_INPUT, "{2ECC71}Ýþyeri - Ad Düzenleme", "Lütfen bu iþyeri için yeni bir ad girin;\nÞu anki ad: %s", "Deðiþtir", "Geri",Isyeri[id][isyeriName]);
		}
		if (strfind(inputtext, "Giriþ Ücreti", true) != -1)
		{
		    if (Isyeri[id][isyeriSahip] != PlayerData[playerid][pID] && (PlayerData[playerid][pAdmin] < 2 || PlayerData[playerid][pAdminDuty] != 1)) return 1;
		    Dialog_Show(playerid,IsyeriUcretDuzenleme,DIALOG_STYLE_INPUT, "{2ECC71}Ýþyeri - Giriþ Ücreti", "{FFFFFF}Lütfen iþyeriniz için yeni bir giriþ ücreti belirleyin;\n{FFFFFF}Þu anki ücret: {FF9900}%s", "Deðiþtir", "Geri",FormatNumber(Isyeri[id][isyeriGirisUcret]));
		}
		if (strfind(inputtext, "Ýþyeri Kasasý", true) != -1)
		{
		    if (Isyeri[id][isyeriSahip] != PlayerData[playerid][pID] && (PlayerData[playerid][pAdmin] < 2 || PlayerData[playerid][pAdminDuty] != 1)) return 1;
		    Dialog_Show(playerid,IsyeriKasa,DIALOG_STYLE_LIST, "{2ECC71}Ýþyeri - Kasa", "Para Al\nPara Koy", "Seç", "Geri");
		}
		if (strfind(inputtext, "Satýlýða Çýkar",true) != -1)
		{
		    if (Isyeri[id][isyeriSahip] != PlayerData[playerid][pID] && (PlayerData[playerid][pAdmin] < 2 || PlayerData[playerid][pAdminDuty] != 1)) return 1;
		    Dialog_Show(playerid,IsyeriSatilik,DIALOG_STYLE_LIST, "{2ECC71}Ýþyeri - Satýlýða Çýkar", "Satýlýða Çýkar\nSisteme Sat {2ECC71}(%s)\nÝþyerini Satmaktan Vazgeç", "Seç", "Geri",FormatNumber(Isyeri[id][isyeriKendiFiyati]/2));
		}
		if (strfind(inputtext, "Giriþ Mesajý",true) != -1)
		{
		    if (Isyeri[id][isyeriSahip] != PlayerData[playerid][pID] && (PlayerData[playerid][pAdmin] < 2 || PlayerData[playerid][pAdminDuty] != 1)) return 1;
		    Dialog_Show(playerid,IsyeriMesaj,DIALOG_STYLE_INPUT, "{2ECC71}Ýþyeri - Giriþ Mesajý", "{FFFFFF}Lütfen iþyeri giriþ mesajý yazýn ('yok' yazarsanýz iþyeri mesajý kaldýrýlýr.)", "Deðiþtir", "Geri");
		}
		if (strfind(inputtext, "Müzik Aç/Kapat", true) != -1)
		{
		    if (Isyeri[id][isyeriSahip] != PlayerData[playerid][pID] && (PlayerData[playerid][pAdmin] < 2 || PlayerData[playerid][pAdminDuty] != 1)) return 1;
		    Dialog_Show(playerid,IsyeriMuzik,DIALOG_STYLE_INPUT, "{2ECC71}Ýþyeri - Müzik", "{FFFFFF}Lütfen müziðin URL adresini girin ('yok' yazarak müziði kapatabilirsiniz.)\n{FFFFFF}Þu anki URL: %s", "Deðiþtir", "Geri",Isyeri[id][isyeriMuzik]);
		}
		if (strfind(inputtext, "Ürün Al",true) != -1)
		{
		    if (Isyeri[id][isyeriSahip] != PlayerData[playerid][pID] && (PlayerData[playerid][pAdmin] < 2 || PlayerData[playerid][pAdminDuty] != 1)) return 1;
		    Isyeri_UrunAl(playerid,id);
		}
		if (strfind(inputtext, "Araç Ekle",true) != -1)
		{
		    if (Isyeri[id][isyeriSahip] != PlayerData[playerid][pID] && (PlayerData[playerid][pAdmin] < 2 || PlayerData[playerid][pAdminDuty] != 1)) return 1;
		    Dialog_Show(playerid,AracEkle,DIALOG_STYLE_INPUT, "{2ECC71}Araç Ekle", "Lütfen iþyerine eklemek istediðiniz aracýn adýný veya modelini girin:", "Devam", "Kapat");
		}
		if (strfind(inputtext, "Araç Düzenle",true) != -1)
		{
		    if (Isyeri[id][isyeriSahip] != PlayerData[playerid][pID] && (PlayerData[playerid][pAdmin] < 2 || PlayerData[playerid][pAdminDuty] != 1)) return 1;
		    Dialog_Show(playerid,AracDuzenle,DIALOG_STYLE_LIST, "{2ECC71}Araç Düzenle", "{FFFFFF}Araç Fiyat Deðiþtir\n{FFFFFF}Araç Sil", "Seç", "Geri");
		}
		if (strfind(inputtext, "Ürün Fiyatlarýný Deðiþtir",true) != -1)
		{
		    HataMesajGonder(playerid, "Bu sistem pasif.");
		    /*if (Isyeri[id][isyeriSahip] != PlayerData[playerid][pID] && (PlayerData[playerid][pAdmin] < 2 || PlayerData[playerid][pAdminDuty] != 1)) return 1;
		    Isyeri_UrunFiyatDegistir(playerid,id);*/
		}
	}
	return 1;
}
Dialog:AracDuzenle(playerid, response, listitem, inputtext[])
{
	if (!response) return callcmd::isyeri(playerid);
	if (response)
	{
	    new id;
	    if ((id = (Business_Inside(playerid) == -1) ? (Business_Nearest(playerid)) : (Business_Inside(playerid))) != -1)
	    {
		    if (listitem == 0)
		    {
		    	SetPVarInt(playerid, "AracDuzenle",1);
		        Isyeri_AracDuzenle(playerid,id);
		    }
		    if (listitem == 1)
		    {
		        SetPVarInt(playerid, "AracDuzenle",2);
		        Isyeri_AracDuzenle(playerid,id);
		    }
	    }
	}
	return 1;
}
Dialog:AracEkle(playerid, response, listitem, inputtext[])
{
	if (!response) return callcmd::isyeri(playerid);
	if (response)
	{
	    new id = -1;
	    if ((id = (Business_Inside(playerid) == -1) ? (Business_Nearest(playerid)) : (Business_Inside(playerid))) != -1)
	    {
	        if (Isyeri[id][isyeriTip] != 4 || !Isyeri[id][isyeriExists]) return 1;
	        if (isnull(inputtext)) return Dialog_Show(playerid,AracEkle,DIALOG_STYLE_INPUT, "{2ECC71}Araç Ekle", "Lütfen iþyerine eklemek istediðiniz aracýn adýný veya modelini girin:", "Devam", "Kapat");
	        new model = GetVehicleModelByName(inputtext);
	        if (!model)
	        {
	            HataMesajGonder(playerid, "Geçersiz araç modeli girdiniz.");
	            return Dialog_Show(playerid,AracEkle,DIALOG_STYLE_INPUT, "{2ECC71}Araç Ekle", "Lütfen iþyerine eklemek istediðiniz aracýn adýný veya modelini girin:", "Devam", "Kapat");
	        }
	        for (new i = 0; i != MAX_DEALERSHIP_CARS; i ++)
	        {
	            if (DealershipCars[id][i][vehModel] == model)
	            {
	                HataMesajGonder(playerid, "Bu araç zaten bu galeride satýlýyor.");
	                return Dialog_Show(playerid,AracEkle,DIALOG_STYLE_INPUT, "{2ECC71}Araç Ekle", "Lütfen iþyerine eklemek istediðiniz aracýn adýný veya modelini girin:", "Devam", "Kapat");
	            }
	        }
	        SetPVarInt(playerid, "AracEkleModel",model);
	        Dialog_Show(playerid,AracEkleFiyat,DIALOG_STYLE_INPUT, "{2ECC71}Araç Fiyat", "Lütfen '%s' model araç için bir fiyat girin:", "Ekle", "Geri",ReturnVehicleModelName(model));
	    }
	}
	return 1;
}
Dialog:AracEkleFiyat(playerid, response, listitem, inputtext[])
{
	if (!response) return Dialog_Show(playerid,AracEkle,DIALOG_STYLE_INPUT, "{2ECC71}Araç Ekle", "Lütfen iþyerine eklemek istediðiniz aracýn adýný veya modelini girin:", "Devam", "Kapat"),DeletePVar(playerid, "AracEkleModel");
	if (response)
	{
	    new id = -1;
	    if ((id = (Business_Inside(playerid) == -1) ? (Business_Nearest(playerid)) : (Business_Inside(playerid))) != -1)
	    {
	        if (Isyeri[id][isyeriTip] != 4 || !Isyeri[id][isyeriExists]) return 1;
	        if (isnull(inputtext) || strval(inputtext) < 1)
	        {
	            HataMesajGonder(playerid, "Geçersiz fiyat.");
	            return Dialog_Show(playerid,AracEkleFiyat,DIALOG_STYLE_INPUT, "{2ECC71}Araç Fiyat", "Lütfen '%s' model araç için bir fiyat girin:", "Ekle", "Geri",ReturnVehicleModelName(GetPVarInt(playerid, "AracEkleModel")));
	        }
	        Isyeri_AracEkle(id,GetPVarInt(playerid, "AracEkleModel"),strval(inputtext));
	        BilgiMesajGonder(playerid, "Galerinize '%s' adlý araç eklendi.",ReturnVehicleModelName(GetPVarInt(playerid, "AracEkleModel")));
	    }
	}
	return 1;
}
Dialog:UrunFiyat(playerid, response, listitem, inputtext[])
{
	if (!response) return callcmd::isyeri(playerid);
	if (response)
	{
	     new id = GetPVarInt(playerid, "IsyeriID");
 		 SetPVarInt(playerid, "SectigiUrun",listitem);
 		 Dialog_Show(playerid,UrunFiyatDegistirme,DIALOG_STYLE_INPUT, "{2ECC71}Ýþyeri - Ürün Fiyat Deðiþtir", "{FFFFFF}Lütfen bu ürün için yeni bir fiyat girin;\n{FFFFFF}Þu anki fiyat: %s", "Deðiþtir", "Geri",FormatNumber(Isyeri[id][isyeriFiyatlar][listitem]));
	}
	return 1;
}
Dialog:UrunlerDialog(playerid, response, listitem, inputtext[])
{
	if (!response) return callcmd::isyeri(playerid);
	if (response)
	{
		    new id = GetPVarInt(playerid, "IsyeriID");

		    if(Isyeri[id][isyeriTip] == 1 && listitem >= 4)
		    	SetPVarInt(playerid, "SectigiUrun", listitem + 1);

		    else SetPVarInt(playerid, "SectigiUrun",listitem);

		    Dialog_Show(playerid,UrunAl,DIALOG_STYLE_INPUT, "{2ECC71}Ýþyeri - Ürün Al", "{FFFFFF}Seçtiðiniz üründen kaç adet almak istiyorsunuz? {2ECC71}(1 adet = %s)", "Al", "Geri",FormatNumber(GetUrunFiyat(id,listitem)));
	}
	return 1;
}
Dialog:UrunFiyatDegistirme(playerid, response, listitem, inputtext[])
{
    if (!response) return Isyeri_UrunFiyatDegistir(playerid,GetPVarInt(playerid, "IsyeriID"));
    if (response)
    {
        new id = GetPVarInt(playerid, "IsyeriID");
	    new urun = GetPVarInt(playerid, "SectigiUrun");
	    if (isnull(inputtext)) return Dialog_Show(playerid,UrunFiyatDegistirme,DIALOG_STYLE_INPUT, "{2ECC71}Ýþyeri - Ürün Fiyat Deðiþtir", "{FFFFFF}Lütfen bu ürün için yeni bir fiyat girin;\n{FFFFFF}Þu anki fiyat: %s", "Deðiþtir", "Geri",FormatNumber(Isyeri[id][isyeriFiyatlar][urun]));
	    if (!IsNumeric(inputtext)) return Dialog_Show(playerid,UrunFiyatDegistirme,DIALOG_STYLE_INPUT, "{2ECC71}Ýþyeri - Ürün Fiyat Deðiþtir", "{FFFFFF}Lütfen bu ürün için yeni bir fiyat girin;\n{FFFFFF}Þu anki fiyat: %s", "Deðiþtir", "Geri",FormatNumber(Isyeri[id][isyeriFiyatlar][urun]));
	    if (strval(inputtext) < 1 || strval(inputtext) > 100000)
	    {
	        HataMesajGonder(playerid, "En az $1, en fazla $100,000 girebilirsiniz.");
	        return Dialog_Show(playerid,UrunFiyatDegistirme,DIALOG_STYLE_INPUT, "{2ECC71}Ýþyeri - Ürün Fiyat Deðiþtir", "{FFFFFF}Lütfen bu ürün için yeni bir fiyat girin;\n{FFFFFF}Þu anki fiyat: %s", "Deðiþtir", "Geri",FormatNumber(Isyeri[id][isyeriFiyatlar][urun]));
	    }
	    Isyeri[id][isyeriFiyatlar][urun] = strval(inputtext);
	    Isyeri_Kaydet(id);

	    BilgiMesajGonder(playerid, "Ürün fiyatý {2ECC71}%s {FFFFFF}olarak deðiþtirildi.",FormatNumber(strval(inputtext)));
	    Isyeri_UrunFiyatDegistir(playerid,id);
    }
	return 1;
}
Dialog:UrunAl(playerid, response, listitem, inputtext[])
{
	if (!response) return Isyeri_UrunAl(playerid,GetPVarInt(playerid, "IsyeriID"));
	if (response)
	{
	    new id = GetPVarInt(playerid, "IsyeriID");
	    new urun = GetPVarInt(playerid, "SectigiUrun");
	    if (isnull(inputtext)) return Dialog_Show(playerid,UrunAl,DIALOG_STYLE_INPUT, "{2ECC71}Ýþyeri - Ürün Al", "{FFFFFF}Seçtiðiniz üründen kaç adet almak istiyorsunuz? {2ECC71}(1 adet = %s)", "Al", "Geri",FormatNumber(GetUrunFiyat(id,urun)));
	    if (!IsNumeric(inputtext)) return Dialog_Show(playerid,UrunAl,DIALOG_STYLE_INPUT, "{2ECC71}Ýþyeri - Ürün Al", "{FFFFFF}Seçtiðiniz üründen kaç adet almak istiyorsunuz? {2ECC71}(1 adet = %s)", "Al", "Geri",FormatNumber(GetUrunFiyat(id,urun)));
	    if (strval(inputtext) < 1 || strval(inputtext)+Isyeri[id][isyeriUrunSayisi][urun] > 1000)
	    {
	        HataMesajGonder(playerid, "Adet 1'den küçük, veya 1000'den fazla olmamalý.");
	        return Dialog_Show(playerid,UrunAl,DIALOG_STYLE_INPUT, "{2ECC71}Ýþyeri - Ürün Al", "{FFFFFF}Seçtiðiniz üründen kaç adet almak istiyorsunuz? {2ECC71}(1 adet = %s)", "Al", "Geri",FormatNumber(GetUrunFiyat(id,urun)));
	    }
	    if (Isyeri[id][isyeriKasa] < strval(inputtext)*GetUrunFiyat(id,urun))
	    {
	        HataMesajGonder(playerid, "Ýþyeri kasasýnda yeterli para yok.");
	        return Dialog_Show(playerid,UrunAl,DIALOG_STYLE_INPUT, "{2ECC71}Ýþyeri - Ürün Al", "{FFFFFF}Seçtiðiniz üründen kaç adet almak istiyorsunuz? {2ECC71}(1 adet = %s)", "Al", "Geri",FormatNumber(GetUrunFiyat(id,urun)));
	    }
	    Isyeri[id][isyeriUrunSayisi][urun] += strval(inputtext);
	    Isyeri[id][isyeriKasa] -= strval(inputtext)*GetUrunFiyat(id,urun);
	    BilgiMesajGonder(playerid, "%d adet ürün {2ECC71}%s {FFFFFF}karþýlýðýnda satýn alýndý.",strval(inputtext),FormatNumber(strval(inputtext)*GetUrunFiyat(id,urun)));
	    Isyeri_UrunAl(playerid,id);
	}
	return 1;
}
Dialog:IsyeriMuzik(playerid, response, listitem, inputtext[])
{
	if (!response) return callcmd::isyeri(playerid);
	if (response)
	{
	    new id = GetPVarInt(playerid, "IsyeriID");
	    if (!strcmp(inputtext, "yok", true))
	    {
	        Isyeri[id][isyeriMuzik][0] = '\0';
	        Isyeri_Kaydet(id);
	        foreach (new i : Player)
			{
				if (PlayerData[i][pIsyeri] == Isyeri[id][isyeriID])
				{
					StopAudioStreamForPlayer(i);
				}
			}
			BilgiMesajGonder(playerid, "Ýþyeri müziði kaldýrýldý.");
	    }
	    else
	    {
	        format(Isyeri[id][isyeriMuzik], 256, inputtext);
            foreach (new i : Player)
			{
				if (PlayerData[i][pIsyeri] == Isyeri[id][isyeriID])
				{
					PlayAudioStreamForPlayer(i, inputtext);
				}
			}
			Isyeri_Kaydet(id);
	    }
	    callcmd::isyeri(playerid);
	}
	return 1;
}
Dialog:IsyeriMesaj(playerid, response, listitem, inputtext[])
{
	if (!response) return callcmd::isyeri(playerid);
	if (response)
	{
	    new id = GetPVarInt(playerid, "IsyeriID");
	    if (!strcmp(inputtext, "yok", true))
		{
		    Isyeri[id][isyeriMesaj][0] = '\0';
			Isyeri_Kaydet(id);
			BilgiMesajGonder(playerid, "Ýþyeri mesajý kaldýrýldý.");
		}
		else
		{
			format(Isyeri[id][isyeriMesaj], 100, inputtext);

			Isyeri_Kaydet(id);
		}
        callcmd::isyeri(playerid);

	}
	return 1;
}
Dialog:IsyeriSatilik(playerid, response, listitem, inputtext[])
{
	if (!response) return callcmd::isyeri(playerid);
	if (response)
	{
	    new id = GetPVarInt(playerid, "IsyeriID");
	    if (listitem == 0)
	    {
	        Dialog_Show(playerid,IsyeriSatiligaCikar,DIALOG_STYLE_INPUT, "{2ECC71}Ýþyeri - Satýlýða Çýkar", "Ýþyerinizi kaç dolara satýlýða çýkarmak istiyorsunuz?:", "Tamam", "Geri");
	    }
	    if (listitem == 1)
	    {
	        if (Isyeri[id][isyeriSatilik] == 1) return HataMesajGonder(playerid, "Ýþyeriniz satýlýk.");
	        new fiyat = floatround(Isyeri[id][isyeriKendiFiyati]/2);
	        Dialog_Show(playerid,IsyeriSistemeSat,DIALOG_STYLE_MSGBOX, "{2ECC71}Ýþyeri - Sisteme Sat", "Ýþyerinizi %s karþýlýðýnda sisteme satmak istediðinize emin misiniz?\n{FF0000}UYARI: Kasadaki paralarý almayý unutmayýn!", "Sat", "Geri",FormatNumber(fiyat));
	    }
	    if (listitem == 2)
	    {
	        if (Isyeri[id][isyeriSatilik] == 0)
	        {
	            Dialog_Show(playerid,IsyeriSatilik,DIALOG_STYLE_LIST, "{2ECC71}Ýþyeri - Satýlýða Çýkar", "{2ECC71}Satýlýða Çýkar\n{2ECC71}Sisteme Sat {FF0000}(%s)\n{2ECC71}Ýþyerini Satmaktan Vazgeç", "Seç", "Geri",FormatNumber(Isyeri[id][isyeriKendiFiyati]/2));
				return HataMesajGonder(playerid, "Ýþyeriniz satýlýk deðil.");
			}
			Isyeri[id][isyeriSatilik] = 0;
			Isyeri[id][isyeriFiyat] = Isyeri[id][isyeriKendiFiyati];
			Isyeri_Yenile(id);
			Isyeri_Kaydet(id);
			callcmd::isyeri(playerid);
	    }
	}
	return 1;
}
Dialog:IsyeriSatiligaCikar(playerid, response, listitem, inputtext[])
{
    new id = GetPVarInt(playerid, "IsyeriID");
	if (!response) return Dialog_Show(playerid,IsyeriSatilik,DIALOG_STYLE_LIST, "{2ECC71}Ýþyeri - Satýlýða Çýkar", "Satýlýða Çýkar\nSisteme Sat {FF0000}(%s)\nÝþyerini Satmaktan Vazgeç", "Seç", "Geri",FormatNumber(Isyeri[id][isyeriKendiFiyati]/2));
	if (response)
	{
	    if (isnull(inputtext)) return Dialog_Show(playerid,IsyeriSatiligaCikar,DIALOG_STYLE_INPUT, "{2ECC71}Ýþyeri - Satýlýða Çýkar", "Ýþyerinizi kaç dolara satýlýða çýkarmak istiyorsunuz?:", "Tamam", "Geri");
	    if (!IsNumeric(inputtext)) return Dialog_Show(playerid,IsyeriSatiligaCikar,DIALOG_STYLE_INPUT, "{2ECC71}Ýþyeri - Satýlýða Çýkar", "Ýþyerinizi kaç dolara satýlýða çýkarmak istiyorsunuz?:", "Tamam", "Geri");
	    if (strval(inputtext) < 1)
	    {
	        HataMesajGonder(playerid, "Geçersiz fiyat girdiniz.");
	        return Dialog_Show(playerid,IsyeriSatiligaCikar,DIALOG_STYLE_INPUT, "{2ECC71}Ýþyeri - Satýlýða Çýkar", "Ýþyerinizi kaç dolara satýlýða çýkarmak istiyorsunuz?:", "Tamam", "Geri");
		}
		Isyeri[id][isyeriSatilik] = 1;
		Isyeri[id][isyeriFiyat] = strval(inputtext);
		Isyeri_Yenile(id);
		Isyeri_Kaydet(id);
		callcmd::isyeri(playerid);
	}
	return 1;
}
Dialog:IsyeriSistemeSat(playerid, response, listitem, inputtext[])
{
	new id = GetPVarInt(playerid, "IsyeriID");
	if (!response) return Dialog_Show(playerid,IsyeriSatilik,DIALOG_STYLE_LIST, "{2ECC71}Ýþyeri - Satýlýða Çýkar", "Satýlýða Çýkar\nSisteme Sat {FF0000}(%s)\nÝþyerini Satmaktan Vazgeç", "Seç", "Geri",FormatNumber(Isyeri[id][isyeriKendiFiyati]/2));
	if (response)
	{
	    Isyeri[id][isyeriSahip] = -1;
	    format(Isyeri[id][isyeriName],32, "Adsýz Ýþyeri");
	    format(Isyeri[id][isyeriMuzik],256, "");
	    Isyeri[id][isyeriSatilik] = 0;
	    Isyeri[id][isyeriKilit] = 0;
	    Isyeri[id][isyeriKasa] = 0;
	    ParaVer(playerid,Isyeri[id][isyeriKendiFiyati]/2);
	    BilgiMesajGonder(playerid, "Ýþyeriniz {2ECC71}%s {FFFFFF}miktar para karþýlýðýnda satýldý.",FormatNumber(Isyeri[id][isyeriKendiFiyati]/2));
	    Isyeri[id][isyeriFiyat] = Isyeri[id][isyeriKendiFiyati];
	    Isyeri_Yenile(id);
	    Isyeri_Kaydet(id);
	}
	return 1;
}
Dialog:IsyeriKasa(playerid, response, listitem, inputtext[])
{
	if (!response) return callcmd::isyeri(playerid);
	if (response)
	{
	    if (listitem == 0)
	    {
	        new id = GetPVarInt(playerid, "IsyeriID");
			Dialog_Show(playerid,IsyeriKasaParaAl,DIALOG_STYLE_INPUT, "{2ECC71}Ýþyeri - Para Al", "{FFFFFF}Lütfen iþyeri kasasýndan almak istediðiniz para miktarýný girin;\n{FFFFFF}Kasadaki para miktarý: {2ECC71}%s ", "Al", "Geri",FormatNumber(Isyeri[id][isyeriKasa]));
		}
		if (listitem == 1)
		{
		    Dialog_Show(playerid,IsyeriKasaParaKoy,DIALOG_STYLE_INPUT, "{2ECC71}Ýþyeri - Para Koy", "{FFFFFF}Lütfen iþyeri kasasýna koymak istediðiniz para miktarýný girin;", "Koy", "Geri");
		}
	}
	return 1;
}
Dialog:IsyeriKasaParaAl(playerid, response, listitem, inputtext[])
{
    if (!response) return Dialog_Show(playerid,IsyeriKasa,DIALOG_STYLE_LIST, "{2ECC71}Ýþyeri - Kasa", "{2ECC71}Para Al\n{2ECC71}Para Koy", "Seç", "Geri");
    if (response)
    {
        new id = GetPVarInt(playerid, "IsyeriID");
        if (isnull(inputtext)) return Dialog_Show(playerid,IsyeriKasaParaAl,DIALOG_STYLE_INPUT, "{2ECC71}Ýþyeri - Para Al", "{FFFFFF}Lütfen iþyeri kasasýndan almak istediðiniz para miktarýný girin;\n{FFFFFF}Kasadaki para miktarý: {2ECC71}%s ", "Al", "Geri",FormatNumber(Isyeri[id][isyeriKasa]));
        if (!IsNumeric(inputtext)) return Dialog_Show(playerid,IsyeriKasaParaAl,DIALOG_STYLE_INPUT, "{2ECC71}Ýþyeri - Para Al", "{FFFFFF}Lütfen iþyeri kasasýndan almak istediðiniz para miktarýný girin;\n{FFFFFF}Kasadaki para miktarý: {2ECC71}%s ", "Al", "Geri",FormatNumber(Isyeri[id][isyeriKasa]));
        if (strval(inputtext) < 1)
        {
            HataMesajGonder(playerid, "Geçersiz miktar!");
            return Dialog_Show(playerid,IsyeriKasaParaAl,DIALOG_STYLE_INPUT, "{2ECC71}Ýþyeri - Para Al", "{FFFFFF}Lütfen iþyeri kasasýndan almak istediðiniz para miktarýný girin;\n{FFFFFF}Kasadaki para miktarý: {2ECC71}%s ", "Al", "Geri",FormatNumber(Isyeri[id][isyeriKasa]));
        }
        if (strval(inputtext) > Isyeri[id][isyeriKasa])
        {
            HataMesajGonder(playerid, "Ýþyeri kasasýnda yeterli para yok.");
            return Dialog_Show(playerid,IsyeriKasaParaAl,DIALOG_STYLE_INPUT, "{2ECC71}Ýþyeri - Para Al", "{FFFFFF}Lütfen iþyeri kasasýndan almak istediðiniz para miktarýný girin;\n{FFFFFF}Kasadaki para miktarý: {2ECC71}%s ", "Al", "Geri",FormatNumber(Isyeri[id][isyeriKasa]));
        }
        Isyeri[id][isyeriKasa] -= strval(inputtext);
        ParaVer(playerid,strval(inputtext));
        Isyeri_Kaydet(id);
        BilgiMesajGonder(playerid, "{FFFFFF}Ýþyeri kasasýndan {2ECC71}%s {FFFFFF}miktar para aldýnýz.",FormatNumber(strval(inputtext)));
        Dialog_Show(playerid,IsyeriKasa,DIALOG_STYLE_LIST, "{2ECC71}Ýþyeri - Kasa", "{2ECC71}Para Al\n{2ECC71}Para Koy", "Seç", "Geri");
    }
	return 1;
}
Dialog:IsyeriKasaParaKoy(playerid, response, listitem, inputtext[])
{
    if (!response) return Dialog_Show(playerid,IsyeriKasa,DIALOG_STYLE_LIST, "{2ECC71}Ýþyeri - Kasa", "{2ECC71}Para Al\n{2ECC71}Para Koy", "Seç", "Geri");
    if (response)
    {
        new id = GetPVarInt(playerid, "IsyeriID");
        if (isnull(inputtext)) return Dialog_Show(playerid,IsyeriKasaParaKoy,DIALOG_STYLE_INPUT, "{2ECC71}Ýþyeri - Para Koy", "{FFFFFF}Lütfen iþyeri kasasýna koymak istediðiniz para miktarýný girin;", "Koy", "Geri");
        if (!IsNumeric(inputtext)) return Dialog_Show(playerid,IsyeriKasaParaKoy,DIALOG_STYLE_INPUT, "{2ECC71}Ýþyeri - Para Koy", "{FFFFFF}Lütfen iþyeri kasasýna koymak istediðiniz para miktarýný girin;", "Koy", "Geri");
        if (strval(inputtext) < 1)
        {
            HataMesajGonder(playerid, "Geçersiz miktar!");
            return Dialog_Show(playerid,IsyeriKasaParaKoy,DIALOG_STYLE_INPUT, "{2ECC71}Ýþyeri - Para Koy", "{FFFFFF}Lütfen iþyeri kasasýna koymak istediðiniz para miktarýný girin;", "Koy", "Geri");
		}
		if (strval(inputtext) > PlayerData[playerid][pCash])
		{
		    HataMesajGonder(playerid, "Üzerinizde yeterli para yok.");
		    return Dialog_Show(playerid,IsyeriKasaParaKoy,DIALOG_STYLE_INPUT, "{2ECC71}Ýþyeri - Para Koy", "{FFFFFF}Lütfen iþyeri kasasýna koymak istediðiniz para miktarýný girin;", "Koy", "Geri");
		}
		Isyeri[id][isyeriKasa] += strval(inputtext);
		ParaVer(playerid,-strval(inputtext));
        Isyeri_Kaydet(id);
        BilgiMesajGonder(playerid, "{FFFFFF}Ýþyeri kasasýna {2ECC71}%s {FFFFFF}miktar para koydunuz.",FormatNumber(strval(inputtext)));
        Dialog_Show(playerid,IsyeriKasa,DIALOG_STYLE_LIST, "{2ECC71}Ýþyeri - Kasa", "{2ECC71}Para Al\n{2ECC71}Para Koy", "Seç", "Geri");
	}
	return 1;
}
Dialog:IsyeriUcretDuzenleme(playerid, response, listitem, inputtext[])
{
    if (!response) return callcmd::isyeri(playerid);
    if (response)
    {
        new id = GetPVarInt(playerid, "IsyeriID");
        if (isnull(inputtext))
	    {
	        HataMesajGonder(playerid, "Ýþyeri ücreti boþ býrakýlamaz. Eðer giriþ ücreti almasýný istemiyorsan '0' yaz.");
	        return Dialog_Show(playerid,IsyeriUcretDuzenleme,DIALOG_STYLE_INPUT, "{2ECC71}Ýþyeri - Giriþ Ücreti", "{FFFFFF}Lütfen iþyeriniz için yeni bir giriþ ücreti belirleyin;\n{FFFFFF}Þu anki ücret: {FF9900}%s", "Deðiþtir", "Geri",FormatNumber(Isyeri[id][isyeriGirisUcret]));
	    }
	    if (!IsNumeric(inputtext)) return Dialog_Show(playerid,IsyeriUcretDuzenleme,DIALOG_STYLE_INPUT, "{2ECC71}Ýþyeri - Giriþ Ücreti", "{FFFFFF}Lütfen iþyeriniz için yeni bir giriþ ücreti belirleyin;\n{FFFFFF}Þu anki ücret: {FF9900}%s", "Deðiþtir", "Geri",FormatNumber(Isyeri[id][isyeriGirisUcret]));
	    if (strval(inputtext) < 0 || strval(inputtext) > 500)
	    {
	        HataMesajGonder(playerid, "Ýþyeri giriþ ücreti 0'dan düþük, 500'den büyük olamaz.");
	        return Dialog_Show(playerid,IsyeriUcretDuzenleme,DIALOG_STYLE_INPUT, "{2ECC71}Ýþyeri - Giriþ Ücreti", "{FFFFFF}Lütfen iþyeriniz için yeni bir giriþ ücreti belirleyin;\n{FFFFFF}Þu anki ücret: {FF9900}%s", "Deðiþtir", "Geri",FormatNumber(Isyeri[id][isyeriGirisUcret]));
	    }
	    Isyeri[id][isyeriGirisUcret] = strval(inputtext);
	    callcmd::isyeri(playerid);
	    Isyeri_Yenile(id);
	    Isyeri_Kaydet(id);
    }
	return 1;
}
Dialog:IsyeriAdDuzenleme(playerid, response, listitem, inputtext[])
{
	if (!response) return callcmd::isyeri(playerid);
	if (response)
	{
	    new id = GetPVarInt(playerid, "IsyeriID");
	    if (isnull(inputtext))
	    {
	        HataMesajGonder(playerid, "Ýþyeri adý boþ býrakýlamaz!");
	        return Dialog_Show(playerid,IsyeriAdDuzenleme,DIALOG_STYLE_INPUT, "{2ECC71}Ýþyeri - Ad Düzenleme", "Lütfen bu iþyeri için yeni bir ad girin;\nÞu anki ad: %s", "Deðiþtir", "Geri",Isyeri[id][isyeriName]);
	    }
	    if (strlen(inputtext) > 32)
	    {
	        HataMesajGonder(playerid, "Ýþyeri adý 32 karakterden uzun olamaz!");
	        return Dialog_Show(playerid,IsyeriAdDuzenleme,DIALOG_STYLE_INPUT, "{2ECC71}Ýþyeri - Ad Düzenleme", "Lütfen bu iþyeri için yeni bir ad girin;\nÞu anki ad: %s", "Deðiþtir", "Geri",Isyeri[id][isyeriName]);
	    }
	    format(Isyeri[id][isyeriName], 32, inputtext);
	    Isyeri_Yenile(id);
	    Isyeri_Kaydet(id);
	    callcmd::isyeri(playerid);
	}
	return 1;
}
Dialog:IsyeriUrunAl(playerid, response, listitem, inputtext[])
{
    static
	    bizid = -1,
		price;

	if ((bizid = Business_Inside(playerid)) != -1 && response)
	{
	    price = Isyeri[bizid][isyeriFiyatlar][listitem];

	   if (PlayerData[playerid][pCash] < price) return HataMesajGonder(playerid, "Bu ürünü almak için yeterli paranýz yok.");
	    if (Isyeri[bizid][isyeriUrunSayisi][listitem] <= 0) return HataMesajGonder(playerid, "Bu ürün bitmiþ.");
	    if (Isyeri[bizid][isyeriTip] == 2)
	    {
	        switch (listitem)
	        {
	            case 0:
	            {
					new yazi[1000];
					switch (PlayerData[playerid][pCinsiyet])
					{
                        case 1:
                        {
                            for (new i; i<sizeof(g_aMaleSkins); i++)
                            {
                                if (g_aMaleSkins[i] == 0) continue;
                                format(yazi,sizeof(yazi), "%s%d\n",yazi,g_aMaleSkins[i]);
                            }
                            ShowPlayerDialog(playerid, 51, DIALOG_STYLE_PREVMODEL, "Kýyafetler",yazi, "Sec", "Iptal");
                        }

						case 2:
						{
						    for (new i; i<sizeof(g_aFemaleSkins); i++)
                            {
                                format(yazi,sizeof(yazi), "%s%d\n",yazi,g_aFemaleSkins[i]);
                            }
                            ShowPlayerDialog(playerid, 51, DIALOG_STYLE_PREVMODEL, "Kýyafetler",yazi, "Sec", "Iptal");
						}
                    }
	            }
	            case 1:
	            {
	                new yazi[1000];
	                switch (PlayerData[playerid][pCinsiyet])
	                {
	                    case 1:
	                    {
	                        for (new i; i<sizeof(OzelErkekKiyafetler); i++)
                            {
                                if (OzelErkekKiyafetler[i] == 0) continue;
                                format(yazi,sizeof(yazi), "%s%d\n",yazi,OzelErkekKiyafetler[i]);
                            }
                            ShowPlayerDialog(playerid, 52, DIALOG_STYLE_PREVMODEL, "Kýyafetler",yazi, "Sec", "Iptal");
	                    }
	                    case 2:
	                    {
	                        for (new i; i<sizeof(OzelBayanKiyafetler); i++)
                            {
                                if (OzelBayanKiyafetler[i] == 0) continue;
                                format(yazi,sizeof(yazi), "%s%d\n",yazi,OzelBayanKiyafetler[i]);
                            }
                            ShowPlayerDialog(playerid, 52, DIALOG_STYLE_PREVMODEL, "Kýyafetler",yazi, "Sec", "Iptal");
	                    }
	                }
	            }
	            case 2:
	            {
	                AksesuarlariGoster(playerid,1);
	            }
	        }
	    }
	    if (Isyeri[bizid][isyeriTip] == 3)
	    {
	        switch (listitem)
	        {
	            case 0:
	            {
					if (PlayerData[playerid][pSu] >= 5) return HataMesajGonder(playerid, "Daha fazla su alamazsýn.");

					ParaVer(playerid, -price);
					SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s cüzdanýndan %s çýkarýr ve kasiyere doðru uzatarak 'Su' satýn alýr.", ReturnName(playerid, 0), FormatNumber(price));
					PlayerData[playerid][pSu]++;
					MesajGonder(playerid, "Bir adet su satýn aldýnýz. Suyunuzu istediðiniz zaman içebilirsiniz. {2ECC71}(/su)");
					if (Isyeri[bizid][isyeriSahip] != -99 && Isyeri[bizid][isyeriSahip] != -1) Isyeri[bizid][isyeriUrunSayisi][listitem]--;
					Isyeri[bizid][isyeriKasa] += price;

					Isyeri_Kaydet(bizid);
				}
				case 1:
				{
                    if (ReturnHealth(playerid) <= 95) { SetPlayerHealth(playerid, ReturnHealth(playerid) + 5); }

					ParaVer(playerid, -price);
					SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s cüzdanýndan %s çýkarýr ve kasiyere doðru uzatarak 'Kola' satýn alýr.", ReturnName(playerid, 0), FormatNumber(price));
					if (Isyeri[bizid][isyeriSahip] != -99 && Isyeri[bizid][isyeriSahip] != -1) Isyeri[bizid][isyeriUrunSayisi][listitem]--;
					Isyeri[bizid][isyeriKasa] += price;

					Isyeri_Kaydet(bizid);
				}
				case 2:
				{
				    if (ReturnHealth(playerid) <= 90) { SetPlayerHealth(playerid, ReturnHealth(playerid) + 10); }
					ParaVer(playerid, -price);
					SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s cüzdanýndan %s çýkarýr ve kasiyere doðru uzatarak 'Salata' satýn alýr.", ReturnName(playerid, 0), FormatNumber(price));

					if (Isyeri[bizid][isyeriSahip] != -99 && Isyeri[bizid][isyeriSahip] != -1) Isyeri[bizid][isyeriUrunSayisi][listitem]--;
					Isyeri[bizid][isyeriKasa] += price;

					Isyeri_Kaydet(bizid);
				}
				case 3:
				{
				    if (ReturnHealth(playerid) <= 85) { SetPlayerHealth(playerid, ReturnHealth(playerid) + 15); }
					ParaVer(playerid, -price);
					SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s cüzdanýndan %s çýkarýr ve kasiyere doðru uzatarak 'Tavuk Nuggets' satýn alýr.", ReturnName(playerid, 0), FormatNumber(price));

					if (Isyeri[bizid][isyeriSahip] != -99 && Isyeri[bizid][isyeriSahip] != -1) Isyeri[bizid][isyeriUrunSayisi][listitem]--;
					Isyeri[bizid][isyeriKasa] += price;

					Isyeri_Kaydet(bizid);
				}
				case 4:
				{
				    if (ReturnHealth(playerid) <= 80) { SetPlayerHealth(playerid, ReturnHealth(playerid) + 20); }
					ParaVer(playerid, -price);
					SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s cüzdanýndan %s çýkarýr ve kasiyere doðru uzatarak 'Patates Kýzartmasý' satýn alýr.", ReturnName(playerid, 0), FormatNumber(price));

					if (Isyeri[bizid][isyeriSahip] != -99 && Isyeri[bizid][isyeriSahip] != -1) Isyeri[bizid][isyeriUrunSayisi][listitem]--;
					Isyeri[bizid][isyeriKasa] += price;

					Isyeri_Kaydet(bizid);
				}
				case 5:
				{
				    if (ReturnHealth(playerid) <= 75) { SetPlayerHealth(playerid, ReturnHealth(playerid) + 25); }
					ParaVer(playerid, -price);
					SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s cüzdanýndan %s çýkarýr ve kasiyere doðru uzatarak 'Hamburger' satýn alýr.", ReturnName(playerid, 0), FormatNumber(price));

					if (Isyeri[bizid][isyeriSahip] != -99 && Isyeri[bizid][isyeriSahip] != -1) Isyeri[bizid][isyeriUrunSayisi][listitem]--;
					Isyeri[bizid][isyeriKasa] += price;

					Isyeri_Kaydet(bizid);
				}
	        }
	    }
	    if (Isyeri[bizid][isyeriTip] == 5)
	        {
	            switch (listitem)
	            {
	                case 0:
	                {
	                    if (PlayerData[playerid][pTelefon] != -1)
							return HataMesajGonder(playerid, "Zaten telefonunuz var.");

	                    PlayerData[playerid][pTelefon] = RandomEx(1000000, 9999999);
	                    ParaVer(playerid, -price);

	                    SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s cüzdanýndan %s çýkarýr ve kasiyere doðru uzatarak Telefon satýn alýr.", ReturnName(playerid, 0), FormatNumber(price));
	                    MesajGonder(playerid, "Telefon satýn alýndý. Numaranýz: %d", PlayerData[playerid][pTelefon]);
	                    MesajGonder(playerid, "Tarife satýn almak isterseniz  Elektronik maðzasýndan satýn alabilirsiniz.");
	                    if (Isyeri[bizid][isyeriSahip] != -99 && Isyeri[bizid][isyeriSahip] != -1) Isyeri[bizid][isyeriUrunSayisi][listitem]--;
	                    Isyeri[bizid][isyeriKasa] += price;
	                    Isyeri_Kaydet(bizid);
	                }
	                case 2:
					{
					    if (PlayerData[playerid][pRadyo] != 0) return HataMesajGonder(playerid, "Zaten portatif radyonuz var.");
					    PlayerData[playerid][pRadyo] = 1;
					    PlayerData[playerid][pFrekans] = 0;
					    ParaVer(playerid, -price);
					    SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s cüzdanýndan %s çýkarýr ve kasiyere doðru uzatarak Portatif Radyo satýn alýr.", ReturnName(playerid, 0), FormatNumber(price));
					    MesajGonder(playerid, "Portatif Radyo satýn alýndý. /frekans ile frekansýnýzý ayarlayabilirsiniz. /pr ile konuþabilirsiniz.");
					    if (Isyeri[bizid][isyeriSahip] != -99 && Isyeri[bizid][isyeriSahip] != -1) Isyeri[bizid][isyeriUrunSayisi][listitem]--;
	                    Isyeri[bizid][isyeriKasa] += price;
	                    Isyeri_Kaydet(bizid);
	                }
	                case 3:
	                {
	                    if (PlayerData[playerid][pBoombox] != 0) return HataMesajGonder(playerid, "Zaten Boombox satýn almýþsýnýz.");
	                    PlayerData[playerid][pBoombox] = 1;
	                    ParaVer(playerid, -price);
	                    SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s cüzdanýndan %s çýkarýr ve kasiyere doðru uzatarak Boombox satýn alýr.", ReturnName(playerid, 0), FormatNumber(price));
	                    MesajGonder(playerid, "Boombox satýn aldýnýz. (/boombox)");
	                    if (Isyeri[bizid][isyeriSahip] != -99 && Isyeri[bizid][isyeriSahip] != -1) Isyeri[bizid][isyeriUrunSayisi][listitem]--;
	                    Isyeri[bizid][isyeriKasa] += price;
	                    Isyeri_Kaydet(bizid);
	                }
	                case 1:
	                {
	                    if (PlayerHasWeapon(playerid, 43)) return HataMesajGonder(playerid, "Zaten kameranýz var.");
	                    GiveWeaponToPlayer(playerid, 43, 50);
	                    ParaVer(playerid, -price);
	                    SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s cüzdanýndan %s çýkarýr ve kasiyere doðru uzatarak Kamera satýn alýr.", ReturnName(playerid, 0), FormatNumber(price));
	                    MesajGonder(playerid, "Kamera satýn aldýnýz.");
	                    if (Isyeri[bizid][isyeriSahip] != -99 && Isyeri[bizid][isyeriSahip] != -1) Isyeri[bizid][isyeriUrunSayisi][listitem]--;
	                    Isyeri[bizid][isyeriKasa] += price;
	                    Isyeri_Kaydet(bizid);

	                }
	            }
			}
			if (Isyeri[bizid][isyeriTip] == 1)
			{
			    switch (listitem)
			    {
			        case 0:
			        {
			            if (PlayerData[playerid][pEsyalar][0] != 0) return HataMesajGonder(playerid, "Zaten zarýnýz var.");

			            PlayerData[playerid][pEsyalar][0] = 1;
			            ParaVer(playerid, -price);
			            SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s cüzdanýndan %s çýkarýr ve kasiyere doðru uzatarak Zar satýn alýr.", ReturnName(playerid, 0), FormatNumber(price));
			            MesajGonder(playerid, "Zar satýn aldýnýz. (/zarat, /zarver, /zarcift)");
			            if (Isyeri[bizid][isyeriSahip] != -99 && Isyeri[bizid][isyeriSahip] != -1) Isyeri[bizid][isyeriUrunSayisi][listitem]--;
	                    Isyeri[bizid][isyeriKasa] += price;
	                    Isyeri_Kaydet(bizid);
			        }
			        case 1:
			        {
			            if (PlayerData[playerid][pEsyalar][1] != 0) return HataMesajGonder(playerid, "Zaten sigaranýz var.");

			            PlayerData[playerid][pEsyalar][1] += 5;
			            ParaVer(playerid, -price);
			            SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s cüzdanýndan %s çýkarýr ve kasiyere doðru uzatarak Sigara satýn alýr.", ReturnName(playerid, 0), FormatNumber(price));
			            MesajGonder(playerid, "5 adet sigara satýn aldýnýz. (/sigara)");
			            if (Isyeri[bizid][isyeriSahip] != -99 && Isyeri[bizid][isyeriSahip] != -1)
			            {
			                Isyeri[bizid][isyeriUrunSayisi][listitem]--;
		                    Isyeri[bizid][isyeriKasa] += price;
		                    Isyeri_Kaydet(bizid);
	                    }
			        }
			        case 2:
			        {
                        if (PlayerData[playerid][pLevel] < 5) return HataMesajGonder(playerid, "Bu ürünü satýn alabilmek için en az 5 seviye olmalýsýnýz.");
			            if (PlayerData[playerid][pEsyalar][2] >= 2) return HataMesajGonder(playerid, "En fazla 2 ip satýn alabilirsin.");

			            PlayerData[playerid][pEsyalar][2]++;
			            ParaVer(playerid, -price);
			            SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s cüzdanýndan %s çýkarýr ve kasiyere doðru uzatarak ip satýn alýr.", ReturnName(playerid, 0), FormatNumber(price));
			            MesajGonder(playerid, "Bir adet ip satýn aldýnýz. (/ipbagla)");
			            if (Isyeri[bizid][isyeriSahip] != -99 && Isyeri[bizid][isyeriSahip] != -1)
			            {
			                Isyeri[bizid][isyeriUrunSayisi][listitem]--;
		                    Isyeri[bizid][isyeriKasa] += price;
		                    Isyeri_Kaydet(bizid);
	                    }
			        }
			        case 3:
			        {
						if (PlayerData[playerid][pLevel] < 5) return HataMesajGonder(playerid, "Bu ürünü satýn alabilmek için en az 5 seviye olmalýsýnýz.");
			            if (PlayerData[playerid][pEsyalar][3] >= 2) return HataMesajGonder(playerid, "En fazla 2 göz baðý satýn alabilirsin.");

			            PlayerData[playerid][pEsyalar][3]++;
			            ParaVer(playerid, -price);
			            SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s cüzdanýndan %s çýkarýr ve kasiyere doðru uzatarak göz baðý satýn alýr.", ReturnName(playerid, 0), FormatNumber(price));
			            MesajGonder(playerid, "Bir adet göz baðý satýn aldýnýz. (/gozbagla)");
			            if (Isyeri[bizid][isyeriSahip] != -99 && Isyeri[bizid][isyeriSahip] != -1)
			            {
			                Isyeri[bizid][isyeriUrunSayisi][listitem]--;
		                    Isyeri[bizid][isyeriKasa] += price;
		                    Isyeri_Kaydet(bizid);
	                    }
			        }
			        case 5:
			        {
			            CanAyarla(playerid, ReturnHealth(playerid)+20);
			            ParaVer(playerid, -price);
			            SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s cüzdanýndan %s çýkarýr ve kasiyere doðru uzatarak Gazoz satýn alýr.", ReturnName(playerid, 0), FormatNumber(price));
			            MesajGonder(playerid, "Gazoz satýn aldýnýz. (+20 can)");
			            if (Isyeri[bizid][isyeriSahip] != -99 && Isyeri[bizid][isyeriSahip] != -1)
			            {
			                Isyeri[bizid][isyeriUrunSayisi][listitem]--;
		                    Isyeri[bizid][isyeriKasa] += price;
		                    Isyeri_Kaydet(bizid);
	                    }
			        }
			        case 6:
			        {
			            if (PlayerHasWeapon(playerid, 5)) return HataMesajGonder(playerid, "Zaten Beyzbol sopanýz bulunmakta.");

			            GiveWeaponToPlayer(playerid, 5, 1);
			            ParaVer(playerid, -price);
			            SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s cüzdanýndan %s çýkarýr ve kasiyere doðru uzatarak Beyzbol Sopasý satýn alýr.", ReturnName(playerid, 0), FormatNumber(price));
			            MesajGonder(playerid, "Beyzbol Sopasý satýn aldýnýz.");
			            if (Isyeri[bizid][isyeriSahip] != -99 && Isyeri[bizid][isyeriSahip] != -1)
			            {
			                Isyeri[bizid][isyeriUrunSayisi][listitem]--;
		                    Isyeri[bizid][isyeriKasa] += price;
		                    Isyeri_Kaydet(bizid);
	                    }
			        }
			        case 7:
			        {
			            if (PlayerData[playerid][pEsyalar][4] != 0) return HataMesajGonder(playerid, "Zaten maskeniz bulunmakta.");

			            PlayerData[playerid][pEsyalar][4] = 1;
			            ParaVer(playerid, -price);
			            SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s cüzdanýndan %s çýkarýr ve kasiyere doðru uzatarak Maske satýn alýr.", ReturnName(playerid, 0), FormatNumber(price));
			            MesajGonder(playerid, "Maske satýn aldýnýz. (/maske)");
			            BilgiMesajGonder(playerid, "Maskeyi kullanabilmek için maske kullaným hakkýnýz olmalýdýr. (/oocmarket)");
			            if (Isyeri[bizid][isyeriSahip] != -99 && Isyeri[bizid][isyeriSahip] != -1)
			            {
			                Isyeri[bizid][isyeriUrunSayisi][listitem]--;
		                    Isyeri[bizid][isyeriKasa] += price;
		                    Isyeri_Kaydet(bizid);
	                    }
			        }
			        case 8:
			        {
			            if (PlayerData[playerid][pEsyalar][5] >= 3) return HataMesajGonder(playerid, "En fazla 3 benzin bidonu alabilirsiniz.");

			            PlayerData[playerid][pEsyalar][5]++;
			            ParaVer(playerid, -price);
			            SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s cüzdanýndan %s çýkarýr ve kasiyere doðru uzatarak Benzin Bidonu satýn alýr.", ReturnName(playerid, 0), FormatNumber(price));
			            MesajGonder(playerid, "Benzin Kutusu satýn aldýnýz. (/benzinkutusu)");
			            if (Isyeri[bizid][isyeriSahip] != -99 && Isyeri[bizid][isyeriSahip] != -1)
			            {
			                Isyeri[bizid][isyeriUrunSayisi][listitem]--;
		                    Isyeri[bizid][isyeriKasa] += price;
		                    Isyeri_Kaydet(bizid);
	                    }
			        }
			        case 9:
			        {
			            if (PlayerData[playerid][pEsyalar][6] != 0) return HataMesajGonder(playerid, "Zaten Barbekünüz bulunmakta.");

			            PlayerData[playerid][pEsyalar][6] = 1;
			            ParaVer(playerid, -price);
			            SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s cüzdanýndan %s çýkarýr ve kasiyere doðru uzatarak Barbekü satýn alýr.", ReturnName(playerid, 0), FormatNumber(price));
			            MesajGonder(playerid, "Barbekü satýn aldýnýz. (/barbeku)");
			            if (Isyeri[bizid][isyeriSahip] != -99 && Isyeri[bizid][isyeriSahip] != -1)
			            {
			                Isyeri[bizid][isyeriUrunSayisi][listitem]--;
		                    Isyeri[bizid][isyeriKasa] += price;
		                    Isyeri_Kaydet(bizid);
	                    }
			        }
			        case 10:
			        {
			            if (PlayerData[playerid][pEsyalar][7] >= 5) return HataMesajGonder(playerid, "En fazla 5 köfte satýn alabilirsiniz.");

			            PlayerData[playerid][pEsyalar][7]++;
			            ParaVer(playerid, -price);
			            SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s cüzdanýndan %s çýkarýr ve kasiyere doðru uzatarak Köfte satýn alýr.", ReturnName(playerid, 0), FormatNumber(price));
			            MesajGonder(playerid, "Köfte satýn aldýnýz.");
			            if (Isyeri[bizid][isyeriSahip] != -99 && Isyeri[bizid][isyeriSahip] != -1)
			            {
			                Isyeri[bizid][isyeriUrunSayisi][listitem]--;
		                    Isyeri[bizid][isyeriKasa] += price;
		                    Isyeri_Kaydet(bizid);
	                    }
			        }
			        case 11:
			        {
			            if (PlayerData[playerid][pEsyalar][8] >= 5) return HataMesajGonder(playerid, "En fazla 5 Tavuk eti satýn alabilirsiniz.");

			            PlayerData[playerid][pEsyalar][8]++;
			            ParaVer(playerid, -price);
			            SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s cüzdanýndan %s çýkarýr ve kasiyere doðru uzatarak Tavuk eti satýn alýr.", ReturnName(playerid, 0), FormatNumber(price));
			            MesajGonder(playerid, "Tavuk eti satýn aldýnýz.");
			            if (Isyeri[bizid][isyeriSahip] != -99 && Isyeri[bizid][isyeriSahip] != -1)
			            {
			                Isyeri[bizid][isyeriUrunSayisi][listitem]--;
		                    Isyeri[bizid][isyeriKasa] += price;
		                    Isyeri_Kaydet(bizid);
	                    }
					}
					case 12:
					{
					    if (PlayerData[playerid][pEsyalar][9] >= 5) return HataMesajGonder(playerid, "En fazla 5 Dana eti satýn alabilirsiniz.");

			            PlayerData[playerid][pEsyalar][9]++;
			            ParaVer(playerid, -price);
			            SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s cüzdanýndan %s çýkarýr ve kasiyere doðru uzatarak Dana eti satýn alýr.", ReturnName(playerid, 0), FormatNumber(price));
			            MesajGonder(playerid, "Dana eti satýn aldýnýz.");
			            if (Isyeri[bizid][isyeriSahip] != -99 && Isyeri[bizid][isyeriSahip] != -1)
			            {
			                Isyeri[bizid][isyeriUrunSayisi][listitem]--;
		                    Isyeri[bizid][isyeriKasa] += price;
		                    Isyeri_Kaydet(bizid);
	                    }
					}
					case 13:
					{
					    if (PlayerData[playerid][pEsyalar][10] >= 3) return HataMesajGonder(playerid, "En fazla 3 Tamir kiti satýn alabilirsiniz.");

					    PlayerData[playerid][pEsyalar][10]++;
			            ParaVer(playerid, -price);
			            SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s cüzdanýndan %s çýkarýr ve kasiyere doðru uzatarak Tamir Kiti satýn alýr.", ReturnName(playerid, 0), FormatNumber(price));
			            MesajGonder(playerid, "Tamir kiti satýn aldýnýz.");
			            if (Isyeri[bizid][isyeriSahip] != -99 && Isyeri[bizid][isyeriSahip] != -1)
			            {
			                Isyeri[bizid][isyeriUrunSayisi][listitem]--;
		                    Isyeri[bizid][isyeriKasa] += price;
		                    Isyeri_Kaydet(bizid);
	                    }
					}
					case 14:
					{
					    if (PlayerData[playerid][pEsyalar][11] != 0) return HataMesajGonder(playerid, "Zaten Portatif Çadýrýnýz var.");

			            PlayerData[playerid][pEsyalar][11] = 1;
			            ParaVer(playerid, -price);
			            SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s cüzdanýndan %s çýkarýr ve kasiyere doðru uzatarak Portatif Çadýr satýn alýr.", ReturnName(playerid, 0), FormatNumber(price));
			            MesajGonder(playerid, "Portatif Çadýr satýn aldýnýz. (/cadir)");
			            if (Isyeri[bizid][isyeriSahip] != -99 && Isyeri[bizid][isyeriSahip] != -1)
			            {
			                Isyeri[bizid][isyeriUrunSayisi][listitem]--;
		                    Isyeri[bizid][isyeriKasa] += price;
		                    Isyeri_Kaydet(bizid);
	                    }
					}
					case 15:
					{
					    if (PlayerData[playerid][pEsyalar][12] != 0) return HataMesajGonder(playerid, "Zaten kamp ateþiniz var.");

			            PlayerData[playerid][pEsyalar][12] = 1;
			            ParaVer(playerid, -price);
			            SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s cüzdanýndan %s çýkarýr ve kasiyere doðru uzatarak Kamp Ateþi satýn alýr.", ReturnName(playerid, 0), FormatNumber(price));
			            MesajGonder(playerid, "Kamp Ateþi satýn aldýnýz. (/kampatesi)");
			            if (Isyeri[bizid][isyeriSahip] != -99 && Isyeri[bizid][isyeriSahip] != -1)
			            {
			                Isyeri[bizid][isyeriUrunSayisi][listitem]--;
		                    Isyeri[bizid][isyeriKasa] += price;
		                    Isyeri_Kaydet(bizid);
	                    }
					}
					/*case 16:
					{
					    if (PlayerData[playerid][pEsyalar][14] != 0) return HataMesajGonder(playerid, "Zaten yan keskiniz var.");

			            PlayerData[playerid][pEsyalar][14] = 1;
			            ParaVer(playerid, -price);
			            SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s cüzdanýndan %s çýkarýr ve kasiyere doðru uzatarak yan keski satýn alýr.", ReturnName(playerid, 0), FormatNumber(price));
			            MesajGonder(playerid, "Yan keski satýn aldýnýz.");
			            if (Isyeri[bizid][isyeriSahip] != -99 && Isyeri[bizid][isyeriSahip] != -1)
			            {
			                Isyeri[bizid][isyeriUrunSayisi][listitem]--;
		                    Isyeri[bizid][isyeriKasa] += price;
		                    Isyeri_Kaydet(bizid);
	                    }
					}*/
			    }
			}
			if (Isyeri[bizid][isyeriTip] == 6)
			{
			    switch (listitem)
			    {
				    case 0:
					{
					    SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DRINK_BEER);

						ParaVer(playerid, -price);
	    				SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s barmene %s ödedi ve bir bardak Bira aldý.", ReturnName(playerid, 0), FormatNumber(price));
	    				if (Isyeri[bizid][isyeriSahip] != -99 && Isyeri[bizid][isyeriSahip] != -1)
			            {
			                Isyeri[bizid][isyeriUrunSayisi][listitem]--;
		                    Isyeri[bizid][isyeriKasa] += price;
		                    Isyeri_Kaydet(bizid);
	                    }
					}
					case 1:
					{
					    SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DRINK_WINE);

                    	ParaVer(playerid, -price);
                    	SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s barmene %s ödedi ve bir bardak Viski aldý.", ReturnName(playerid, 0), FormatNumber(price));
                    	if (Isyeri[bizid][isyeriSahip] != -99 && Isyeri[bizid][isyeriSahip] != -1)
			            {
			                Isyeri[bizid][isyeriUrunSayisi][listitem]--;
		                    Isyeri[bizid][isyeriKasa] += price;
		                    Isyeri_Kaydet(bizid);
	                    }
					}
					case 2:
					{
					    SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DRINK_WINE);

                    	ParaVer(playerid, -price);
                    	SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s barmene %s ödedi ve bir bardak Tekila aldý.", ReturnName(playerid, 0), FormatNumber(price));
                    	if (Isyeri[bizid][isyeriSahip] != -99 && Isyeri[bizid][isyeriSahip] != -1)
			            {
			                Isyeri[bizid][isyeriUrunSayisi][listitem]--;
		                    Isyeri[bizid][isyeriKasa] += price;
		                    Isyeri_Kaydet(bizid);
	                    }
					}
					case 3:
					{
					    SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DRINK_WINE);

                    	ParaVer(playerid, -price);
                    	SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s barmene %s ödedi ve bir bardak Þarap aldý.", ReturnName(playerid, 0), FormatNumber(price));
                    	if (Isyeri[bizid][isyeriSahip] != -99 && Isyeri[bizid][isyeriSahip] != -1)
			            {
			                Isyeri[bizid][isyeriUrunSayisi][listitem]--;
		                    Isyeri[bizid][isyeriKasa] += price;
		                    Isyeri_Kaydet(bizid);
	                    }
					}
					case 4:
					{
					    SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DRINK_WINE);

                    	ParaVer(playerid, -price);
                    	SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s barmene %s ödedi ve bir bardak Votka aldý.", ReturnName(playerid, 0), FormatNumber(price));
                    	if (Isyeri[bizid][isyeriSahip] != -99 && Isyeri[bizid][isyeriSahip] != -1)
			            {
			                Isyeri[bizid][isyeriUrunSayisi][listitem]--;
		                    Isyeri[bizid][isyeriKasa] += price;
		                    Isyeri_Kaydet(bizid);
	                    }
					}
					case 5:
					{
					    SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DRINK_WINE);

                    	ParaVer(playerid, -price);
                    	SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s barmene %s ödedi ve bir bardak Þampanya aldý.", ReturnName(playerid, 0), FormatNumber(price));
                    	if (Isyeri[bizid][isyeriSahip] != -99 && Isyeri[bizid][isyeriSahip] != -1)
			            {
			                Isyeri[bizid][isyeriUrunSayisi][listitem]--;
		                    Isyeri[bizid][isyeriKasa] += price;
		                    Isyeri_Kaydet(bizid);
	                    }
					}
    			}
			}

	}
	return 1;
}
Dialog:Baliklar(playerid, response, listitem, inputtext[])
{
	if(response)
	{
	    if(strfind(inputtext, "Hepsini Sat", true) != -1)
	    {
	        Dialog_Show(playerid,HepsiniSat,DIALOG_STYLE_MSGBOX,"{808080}» {FFFFFF}Balýk Satma","Tüm balýklarý {808080}%s {FFFFFF}karþýlýðýnda satmak istediðinize emin misiniz?","Sat","Geri",FormatNumber(BalikToplamPara(playerid)));
	    }
	    else
	    {
	        new id = GetBalikIDWithName(inputtext);
	        if(id != -1)
	        {
	            SetPVarInt(playerid,"BalikID",id);
	            Dialog_Show(playerid,BalikSat,DIALOG_STYLE_MSGBOX,"{808080}» {FFFFFF}Balýk Satma","{808080}%s {FFFFFF}adlý balýðý satmak istediðine emin misin?","Sat","Geri",BalikTurleri[id][TurAdi]);
	        }
	    }
	}
	return 1;
}
Dialog:BalikSat(playerid, response, listitem, inputtext[])
{
	if(!response) return OyuncuBaliklari(playerid);
	if(response)
	{
	    new id = GetPVarInt(playerid,"BalikID");
	    new balikid = -1;
	    for(new i; i<10; i++)
	    {
	        if(PlayerData[playerid][pBalikID][i] == id)
	        {
				balikid = i;
				break;
	        }
	    }
	    if(balikid != -1)
	    {
	        ParaVer(playerid,floatround(PlayerData[playerid][pBalikGram][balikid] * BalikTurleri[PlayerData[playerid][pBalikID][balikid]][GramFiyat]));
	        MesajGonder(playerid,"Balýk satýldý. {808080}(%s)",FormatNumber(floatround(PlayerData[playerid][pBalikGram][balikid] * BalikTurleri[PlayerData[playerid][pBalikID][balikid]][GramFiyat])));
	        PlayerData[playerid][pBalikID][balikid] = -1;
	        PlayerData[playerid][pBalikGram][balikid] = 0;
	    }
	}
	return 1;
}
Dialog:HepsiniSat(playerid, response, listitem, inputtext[])
{
	if(!response) return OyuncuBaliklari(playerid);
	if(response)
	{
	    ParaVer(playerid,BalikToplamPara(playerid));
	    MesajGonder(playerid,"Tüm balýklar satýldý. {808080}(%s)",FormatNumber(BalikToplamPara(playerid)));
	    for(new i; i<10; i++)
	    {
	        PlayerData[playerid][pBalikID][i] = -1;
	        PlayerData[playerid][pBalikGram][i] = 0;
	    }
	}
	return 1;
}
Dialog:BirlikDialog(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    new factionid = PlayerData[playerid][pFaction];
	    if (listitem == 0)
	    {
	        if (factionid == -1) return HataMesajGonder(playerid, "Bir birliðiniz yok.");
	        new str[1024],string[300],sayi;
	        strcat(str, "ID\tAd\tRütbe\tDivizyon\n");
	        foreach (new i:Player) if (PlayerData[i][pFaction] == factionid)
	        {
	            format(string,sizeof(string), "%d\t%s\t%s\t%s\n",i,ReturnName(i,0),Birlik_GetRutbe(i),Birlik_GetDivizyon(i));
	            strcat(str,string);
	            sayi++;
	        }
	        if (sayi == 0)
	        {
	            HataMesajGonder(playerid, "Aktif birlik üyesi bulunmamaktadýr.");
	            callcmd::birlik(playerid);
	        }
	        Dialog_Show(playerid, BirlikGeriTusu, DIALOG_STYLE_TABLIST_HEADERS, "Çevrimiçi Üyeler", str, "Tamam", "Geri");
	    }
	    if (listitem == 1)
	    {
	        if (factionid == -1) return HataMesajGonder(playerid, "Bir birliðiniz yok.");
	        new str[1000],string[224],durum[30];
	        format(string,sizeof(string), "Birlik Adý: {FFF5EE}%s\n",Birlikler[factionid][birlikAd]);
	        strcat(str,string);
	        switch (Birlikler[factionid][birlikTip])
	        {
	            case 0: durum = "Belirlenmiyor";
	            case 1: durum = "Çete";
	            case 2: durum = "Mafya";
	            case 3: durum = "Yayýn Ajansý";
	            case 4: durum = "Legal";
	            default: durum = "Özel Kurum";
	        }
	        format(string,sizeof(string), "{FFFFFF}Birlik Tipi: {FFF5EE}%s{FFFFFF}\n",durum);
	        strcat(str,string);
         	format(string,sizeof(string), "Sistemsel Onay: %s{FFFFFF}\n",(Birlikler[factionid][birlikOnaylar][0] == 1) ? ("{21ff00}Var") : ("{ff0000}Yok"));
         	strcat(str,string);
         	format(string,sizeof(string), "Silah Onayý: %s{FFFFFF}\n",(Birlikler[factionid][birlikOnaylar][1] == 1) ? ("{21ff00}Var") : ("{ff0000}Yok"));
         	strcat(str,string);
         	format(string,sizeof(string), "Uyuþturucu Onayý: %s{FFFFFF}\n",(Birlikler[factionid][birlikOnaylar][2] == 1) ? ("{21ff00}Var") : ("{ff0000}Yok"));
         	strcat(str,string);
         	format(string,sizeof(string), "Graffiti Onayý: %s{FFFFFF}\n",(Birlikler[factionid][birlikOnaylar][3] == 1) ? ("{21ff00}Var") : ("{ff0000}Yok"));
         	strcat(str,string);
         	format(string,sizeof(string), "Hood Onayý: %s{FFFFFF}\n",(Birlikler[factionid][birlikOnaylar][4] == 1) ? ("{21ff00}Var") : ("{ff0000}Yok"));
         	strcat(str,string);
	        format(string,sizeof(string), "Birlik Üye Sayýsý: {FFF5EE}%d{FFFFFF}\n",BirlikUyeSayisi(factionid));
	        strcat(str,string);
	        format(string,sizeof(string), "Toplam Rütbe Sayýsý: {FFF5EE}%d{FFFFFF}\n",Birlikler[factionid][birlikRutbeler]);
	        strcat(str,string);
	        if (Birlikler[factionid][OOCDurum] == 1) durum = "{38c5f7}Açýk";
			else durum = "{AA3333}Kapalý";
		 	format(string,sizeof(string), "OOC Chat Durum: %s\n",durum);
	        strcat(str,string);
	        format(string,sizeof(string), "{FFFFFF}Birlik Duyurusu: {FFF5EE}%s{FFFFFF}\n",Birlikler[factionid][birlikDuyuru]);
	        strcat(str,string);
	        Dialog_Show(playerid, BirlikGeriTusu, DIALOG_STYLE_MSGBOX, "{808080}Birlik Bilgileri", str, "Tamam", "Geri");
	    }
	    if (listitem == 2) // Birlikten Çýkma
	    {
	        Dialog_Show(playerid,BirliktenCik,DIALOG_STYLE_MSGBOX, "{808080}Birlikten Çýk", "{FFFFFF}Gerçekten de birlikten çýkmak istediðinize emin misiniz?\n {FF0000}NOT:{808080}(Eðer devlet gibi özel kurum üyesi iseniz cezalandýrýlabilirsiniz habersiz çýkmak yasaktýr.)", "Evet", "Hayýr");
	    }
        if (strfind(inputtext, "Birlik Kasa", true) != -1)
        {
            if (factionid == -1) return HataMesajGonder(playerid, "Bir birliðiniz yok.");
            if (Birlikler[factionid][birlikTip] != BIRLIK_CETE && Birlikler[factionid][birlikTip] != BIRLIK_MAFYA  && Birlikler[factionid][birlikTip] != BIRLIK_LEGAL && Birlikler[factionid][birlikTip] != BIRLIK_HABER) return HataMesajGonder(playerid, "Bu birlik türü kasa kullanamaz.");
            Dialog_Show(playerid,birlikKasa,DIALOG_STYLE_LIST, "Birlik Kasasý", "{2ECC71}Kasadan Al\n{2ECC71}Kasaya Koy", "Seç", "Geri");
        }
        if (strfind(inputtext, "Üye Al", true) != -1)
        {
            if (PlayerData[playerid][pFaction] == -1) return HataMesajGonder(playerid, "Bir birlik üyesi deðilsiniz.");
            if (GetPVarInt(playerid, "davet") == 0)
            {
            	BilgiMesajGonder(playerid, "Birliðe davet etmek istediðiniz oyuncuya TAB'dan (skor tablosu) üstüne iki kez týkla!");
            	BilgiMesajGonder(playerid, "Birliðe davet modunu kapatmak için /birlik » Üye Al (Birisini davet ettiðinizde oto kapatýlýr.)");
            	SetPVarInt(playerid, "davet",1);
            }
            else
            {
                DeletePVar(playerid, "davet");
                MesajGonder(playerid, "Davet etme modu kapatýlmýþtýr.");
            }
        }
        if (strfind(inputtext, "Üye At", true) != -1)
        {
            if (PlayerData[playerid][pFaction] == -1) return HataMesajGonder(playerid, "Bir birlik üyesi deðilsiniz.");
            Dialog_Show(playerid,BirliktenAt,DIALOG_STYLE_INPUT, "{808080}Üye At", "{FFFFFF}Lütfen birlikten atmak istediðiniz kiþinin ID'sini girin.", "Devam", "Geri");
        }
        if (strfind(inputtext, "Çevrimdýþý Üyeler", true) != -1)
        {
            if (PlayerData[playerid][pFaction] == -1) return HataMesajGonder(playerid, "Bir birlik üyesi deðilsiniz.");
            Birlik_OfflineUyeler(playerid,factionid);
        }
        if (strfind(inputtext, "Üye Rütbe Deðiþtir", true) != -1)
        {
            if (PlayerData[playerid][pFaction] == -1) return HataMesajGonder(playerid, "Bir birlik üyesi deðilsiniz.");
           	new str[1024],string[300],sayi;
           	strcat(str, "ID\tAd\tRütbe\tDivizyon\n");
            foreach (new i:Player) if (PlayerData[i][pFaction] == factionid)
	        {
	            format(string,sizeof(string), "{59DC1C}%d\t{59DC1C}%s\t{59DC1C}%s\t{59DC1C}%s\n",i,ReturnName(i,0),Birlik_GetRutbe(i),Birlik_GetDivizyon(i));
	            strcat(str,string);
	            sayi++;
	        }
	        Dialog_Show(playerid, RutbeDegistir, DIALOG_STYLE_TABLIST_HEADERS, "{808080} Rütbe Deðiþtir", str, "Deðiþtir", "{FF6347}Iptal");
	        if (sayi == 0) HataMesajGonder(playerid, "Aktif birlik üyesi bulunmamaktadýr."),callcmd::birlik(playerid);
        }
        if (strfind(inputtext, "Üye Divizyon Deðiþtir", true) != -1)
        {
        	DeletePVar(playerid, "OffDiviz");
            if (PlayerData[playerid][pFaction] == -1) return HataMesajGonder(playerid, "Bir birlik üyesi deðilsiniz.");
            new str[1024],string[300],sayi;
           	strcat(str, "ID\tAd\tRütbe\tDivizyon\n");
            foreach (new i:Player) if (PlayerData[i][pFaction] == factionid)
	        {
	            format(string,sizeof(string), "%d\t%s\t%s\t%s\n",i,ReturnName(i,0),Birlik_GetRutbe(i),Birlik_GetDivizyon(i));
	            strcat(str,string);
	            sayi++;
	        }
	        Dialog_Show(playerid,DivizyonDegistir,DIALOG_STYLE_TABLIST_HEADERS, "{808080}Divizyon Deðiþtir",str, "Deðiþtir", "{FF6347}Iptal");
	        if (sayi == 0) HataMesajGonder(playerid, "Aktif birlik üyesi bulunmamaktadýr."),callcmd::birlik(playerid);
        }
        if (strfind(inputtext, "Rütbe Adlarýný Düzenle", true) != -1)
        {
            if (PlayerData[playerid][pFaction] == -1) return HataMesajGonder(playerid, "Bir birlik üyesi deðilsiniz.");
            Birlik_RutbeleriGoster(playerid,PlayerData[playerid][pFaction]);
        }
        if (strfind(inputtext, "Divizyon Adlarýný Düzenle", true) != -1)
        {
            if (PlayerData[playerid][pFaction] == -1) return HataMesajGonder(playerid, "Bir birlik üyesi deðilsiniz.");
            Birlik_DivizyonlariGoster(playerid,PlayerData[playerid][pFaction]);
        }
  /*      if(strfind(inputtext, "Birlik Araçlarýný Spawnla", true) != -1) // Modun Ýçinde Arat Bunun Parantezinin için þu þekilde olacak
		{
			if(PlayerData[playerid][pFaction] == -1) return HataMesajGonder(playerid,"Bir birlik üyesi deðilsiniz.");

			Dialog_Show(playerid, BirlikAracSpawnTip, DIALOG_STYLE_LIST, "{FFFFFF}Birlik Araç Spawn Tercih", "{FFFFFF}> Araçlarý Listele\n{FFFFFF}> Bütün Araçlarý Spawnla", "{FFFFFF}Seç", "{FFFFFF}Kapat");
		}*/
		   if (strfind(inputtext, "Birlik Araçlarýný Spawnla", true) != -1)
        {
            if (PlayerData[playerid][pFaction] == -1) return HataMesajGonder(playerid, "Bir birlik üyesi deðilsiniz.");
			new sayi = 0;

            for (new i = 0; i < MAX_ARAC; i++)
            {
                if (AracInfo[i][aracExists] && IsValidVehicle(AracInfo[i][aracVehicle]) && GetVehicleDriver(AracInfo[i][aracVehicle]) == INVALID_PLAYER_ID && AracInfo[i][aracFaction] == Birlikler[PlayerData[playerid][pFaction]][birlikID])
                {
                    Arac_Spawn(i);

                    DestroyDynamic3DTextLabel(Vehicle3DText[AracInfo[i][aracVehicle]]);
				 	VehicleCallSign[AracInfo[i][aracVehicle]] = 0;
				  	format(VehicleText[AracInfo[i][aracVehicle]], 24, "");

					sayi++;
				}
            }

			if (!sayi)
				return HataMesajGonder(playerid, "Birliðe ait araç yok.");

			BilgiMesajGonder(playerid, "%d adet birlik aracý respawn edildi.",sayi);
        }
        if (strfind(inputtext, "Birlik OOC Chat", true) != -1)
        {
            if (PlayerData[playerid][pFaction] == -1) return HataMesajGonder(playerid, "Bir birlik üyesi deðilsiniz.");
            if (Birlikler[factionid][OOCDurum] == 1)
            {
                Birlikler[factionid][OOCDurum] = 0;
                Birlik_Kaydet(factionid);
                callcmd::birlik(playerid);
                MesajGonder(playerid, "Birlik OOC Chat kapatýldý.");
            }
            else
            {
                Birlikler[factionid][OOCDurum] = 1;
                Birlik_Kaydet(factionid);
                callcmd::birlik(playerid);
                MesajGonder(playerid, "Birlik OOC Chat açýldý.");
            }
        }
        if (strfind(inputtext, "Rütbe Yetkilendirmeleri", true) != -1)
        {
			if (PlayerData[playerid][pFaction] == -1) return HataMesajGonder(playerid, "Bir birlik üyesi deðilsiniz.");
			Dialog_Show(playerid,RutbeYetkilendirme,DIALOG_STYLE_LIST, "{808080} Rütbe Yetkilendirmeleri", "{59DC1C}Üye Alma Seviyesi\n{59DC1C}Üye Atma Seviyesi\n{59DC1C}Rütbe Deðiþtirme Seviyesi\n{59DC1C}Divizyon Deðiþtirme Seviyesi\n{59DC1C}Araçlarý Spawnlama Seviyesi\n{59DC1C}OOC Chat Kapat/Aç Seviyesi\n{59DC1C}Birlik Kasasýndan Para Alma\n{59DC1C}Ajans Ayarlarý Seviyesi", "Seç", "Geri");
        }
        if (strfind(inputtext, "Maksimum Rütbe", true) != -1)
        {
            if (PlayerData[playerid][pFaction] == -1) return HataMesajGonder(playerid, "Bir birlik üyesi deðilsiniz.");
            Dialog_Show(playerid, MaksRutbe, DIALOG_STYLE_INPUT, "{808080}Maksimum Rütbe Deðiþtir", "Rütbe sayýsý: %d\n\nMaksimum rütbe sayýsýný girin:", "Ayarla", "Geri", Birlikler[factionid][birlikRutbeler]);
        }
        if (strfind(inputtext, "Birlik Duyurusu Deðiþtir", true) != -1)
        {
            if (PlayerData[playerid][pFaction] == -1) return HataMesajGonder(playerid, "Bir birlik üyesi deðilsiniz.");
            Dialog_Show(playerid, BirlikDuyuruChange, DIALOG_STYLE_INPUT, "{808080}Birlik Duyurusunu Deðiþtir", "Lütfen yeni bir birlik duyurusu giriniz:\nÞu anki duyuru: %s", "Deðiþtir", "Geri",Birlikler[factionid][birlikDuyuru]);
        }
        if (strfind(inputtext, "Ajans Ayarlarý", true) != -1)
        {
            if (PlayerData[playerid][pFaction] == -1) return HataMesajGonder(playerid, "Bir birlik üyesi deðilsiniz.");
            AjansAyarlari(playerid);
        }
	}
	return 1;
}


Dialog:BirlikAracSpawnTip(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		new sayi = 0, str[2048];
		switch (listitem)
		{
			case 0:
			{
				strcat(str, "{FFFFFF}Araç ID\t{FFFFFF}Araç Model\n");

				for (new i = 0; i < MAX_ARAC; i++) if (AracInfo[i][aracExists] && AracInfo[i][aracTip] == 1 && GetVehicleDriver(AracInfo[i][aracVehicle]) == INVALID_PLAYER_ID && AracInfo[i][aracFaction] == Birlikler[PlayerData[playerid][pFaction]][birlikID])
				{
					format(str, sizeof str, "%s{FFFFFF}%d\t{FFFFFF}%s\n", str, AracInfo[i][aracVehicle], ReturnVehicleModelName(GetVehicleModel(AracInfo[i][aracVehicle])));
					sayi++;
				}

				if(!sayi) return HataMesajGonder(playerid,"Birliðe ait araç yok.");
				else
				{
					Dialog_Show(playerid, BirlikAracListe, DIALOG_STYLE_TABLIST_HEADERS, "{FFFFFF}Birlik Araç Listesi", str, "{FFFFFF}Spawnla", "{FFFFFF}Iptal");
				}
			}
			case 1:
			{
				for (new i = 0; i < MAX_ARAC; i++) if (AracInfo[i][aracExists] && AracInfo[i][aracTip] == 1 && GetVehicleDriver(AracInfo[i][aracVehicle]) == INVALID_PLAYER_ID && AracInfo[i][aracFaction] == Birlikler[PlayerData[playerid][pFaction]][birlikID])
				{
					DestroyDynamic3DTextLabel(Vehicle3DText[AracInfo[i][aracVehicle]]);
					VehicleCallSign[AracInfo[i][aracVehicle]] = 0;
					format(VehicleText[i], 24, "");
					Arac_Spawn(AracInfo[i][aracVehicle]);
					sayi++;
				}

				if (!sayi) return HataMesajGonder(playerid, "Birliðe ait araç yok.");
				else return BilgiMesajGonder(playerid, "%d adet birlik aracý respawn edildi.", sayi);
			}
		}
	}
	return true;
}

Dialog:BirlikAracListe(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		new id = 0, aidsi = -1;

		for (new i = 0; i < MAX_ARAC; i++) if (AracInfo[i][aracExists] && AracInfo[i][aracTip] == 1 && GetVehicleDriver(AracInfo[i][aracVehicle]) == INVALID_PLAYER_ID && AracInfo[i][aracFaction] == Birlikler[PlayerData[playerid][pFaction]][birlikID])
		{
			if (listitem == id)
			{
				aidsi = i;
				break;
			}
			else id++;
		}

		if (aidsi != -1)
		{
			DestroyDynamic3DTextLabel(Vehicle3DText[AracInfo[aidsi][aracVehicle]]);
			VehicleCallSign[AracInfo[aidsi][aracVehicle]] = 0;
			format(VehicleText[aidsi], 24, "");
			Arac_Spawn(AracInfo[aidsi][aracVehicle]);

			BilgiMesajGonder(playerid, "%d id araç respawn edildi.", AracInfo[aidsi][aracVehicle]);
		}
		else return HataMesajGonder(playerid, "Seçilen araç bulunamadý.");
	}
	return true;
}
Dialog:MaksRutbe(playerid, response, listitem, inputtext[])
{
	if (!response) return callcmd::birlik(playerid);
	if (response)
	{
	    if (isnull(inputtext)) return Dialog_Show(playerid, MaksRutbe, DIALOG_STYLE_INPUT, "{72C425}Maksimum Rütbe Deðiþtir", "Rütbe sayýsý: %d\n\nMaksimum rütbe sayýsýný girin:", "Ayarla", "Geri", Birlikler[PlayerData[playerid][pFaction]][birlikRutbeler]);
	    if (!IsNumeric(inputtext)) return Dialog_Show(playerid, MaksRutbe, DIALOG_STYLE_INPUT, "{72C425}Maksimum Rütbe Deðiþtir", "Rütbe sayýsý: %d\n\nMaksimum rütbe sayýsýný girin:", "Ayarla", "Geri", Birlikler[PlayerData[playerid][pFaction]][birlikRutbeler]);
	    if (strval(inputtext) < 4 || strval(inputtext) > 15)
	    {
	        HataMesajGonder(playerid, "Minimum 3, maksimum 15 girebilirsiniz.");
	        return Dialog_Show(playerid, MaksRutbe, DIALOG_STYLE_INPUT, "{72C425}Maksimum Rütbe Deðiþtir", "Rütbe sayýsý: %d\n\nMaksimum rütbe sayýsýný girin:", "Ayarla", "Geri", Birlikler[PlayerData[playerid][pFaction]][birlikRutbeler]);
	    }
	    Birlikler[PlayerData[playerid][pFaction]][birlikRutbeler] = strval(inputtext);
	    PlayerData[playerid][pFactionRutbe] = strval(inputtext);
	    MesajGonder(playerid, "Maksimum Rütbe sayýsý %d olarak deðiþtirildi.", strval(inputtext));
	}
	return 1;
}
Dialog:AjansAyarlari(playerid, response, listitem, inputtext[])
{
	if (!response) return callcmd::birlik(playerid);
	if (response)
	{
	    switch (listitem)
	    {
	        case 0:
	        {
	            if (Birlikler[PlayerData[playerid][pFaction]][yayinDurum] == 1) Birlikler[PlayerData[playerid][pFaction]][yayinDurum] = 0;
	            else Birlikler[PlayerData[playerid][pFaction]][yayinDurum] = 1;
	            AjansAyarlari(playerid);
	            Birlik_Kaydet(PlayerData[playerid][pFaction]);
	        }
	        case 2:
	        {
	            if (Birlikler[PlayerData[playerid][pFaction]][yayinTipi] == 1) Birlikler[PlayerData[playerid][pFaction]][yayinTipi] = 0;
	            else Birlikler[PlayerData[playerid][pFaction]][yayinTipi] = 1;
	            AjansAyarlari(playerid);
	            Birlik_Kaydet(PlayerData[playerid][pFaction]);
	        }
	        case 3:
	        {
	            if (Birlikler[PlayerData[playerid][pFaction]][ReklamAlimi] == 1) Birlikler[PlayerData[playerid][pFaction]][ReklamAlimi] = 0;
	            else Birlikler[PlayerData[playerid][pFaction]][ReklamAlimi] = 1;
	            AjansAyarlari(playerid);
	            Birlik_Kaydet(PlayerData[playerid][pFaction]);
	        }
	        case 4:
	        {
	            Dialog_Show(playerid, ReklamUcreti, DIALOG_STYLE_INPUT, "{38c5f7}Reklam Ücreti", "Lütfen yeni bir reklam ücreti girin:", "Devam", "Geri");
	        }
	        case 7:
	        {
	            Dialog_Show(playerid, Cekilis, DIALOG_STYLE_TABLIST, "{38c5f7}Çekiliþ", "{FF0000}» {FFFFFF}Çekiliþ Durumu\t%s\n{FF0000}» {FFFFFF}Çekiliþ Ödül\t{38c5f7}%s\n{FF0000}» {FFFFFF}Katýlýmcý Sayýsý\t%d\n{38c5f7}» {FFFFFF}Çekiliþi Bitir", "Seç", "Geri",
	            (Birlikler[PlayerData[playerid][pFaction]][CekilisBasladi] == false) ? ("{ff0000}Kapalý") : ("{00ff2a}Açýk"), FormatNumber(Birlikler[PlayerData[playerid][pFaction]][cekilisOdul]), Iter_Count(CekilisKatilimcilar[PlayerData[playerid][pFaction]]));
	        }
	    }
	}
	return 1;
}
Dialog:Cekilis(playerid, response, listitem, inputtext[])
{
	if (!response) return AjansAyarlari(playerid);
	if (response)
	{
	    switch (listitem)
	    {
	        case 0:
	        {
	            if (Birlikler[PlayerData[playerid][pFaction]][CekilisBasladi] == false)
	            {
	                Dialog_Show(playerid, CekilisBaslat, DIALOG_STYLE_INPUT, "{38c5f7}Çekiliþ Baþlat", "Lütfen çekiliþ ödülünü girin ($5,000 ile &200,000 arasýnda olmalýdýr):", "Baþlat", "Kapat");
	            }
	            else
	            {
	                Birlikler[PlayerData[playerid][pFaction]][CekilisBasladi] = false;
	                Iter_Clear(CekilisKatilimcilar[PlayerData[playerid][pFaction]]);
	                Birlikler[PlayerData[playerid][pFaction]][cekilisOdul] = 0;
	                Dialog_Show(playerid, Cekilis, DIALOG_STYLE_TABLIST, "{38c5f7}Çekiliþ", "{FF0000}» {FFFFFF}Çekiliþ Durumu\t%s\n{FF0000}» {FFFFFF}Çekiliþ Ödül\t{38c5f7}%s\n{FF0000}» {FFFFFF}Katýlýmcý Sayýsý\t%d\n{38c5f7}» {FFFFFF}Çekiliþi Bitir", "Seç", "Geri",
                    (Birlikler[PlayerData[playerid][pFaction]][CekilisBasladi] == false) ? ("{ff0000}Kapalý") : ("{00ff2a}Açýk"), FormatNumber(Birlikler[PlayerData[playerid][pFaction]][cekilisOdul]), Iter_Count(CekilisKatilimcilar[PlayerData[playerid][pFaction]]));
	            }
	        }
	        case 1:
	        {
	            Dialog_Show(playerid, CekilisOdul, DIALOG_STYLE_INPUT, "{38c5f7}Çekiliþ Ödül", "Lütfen çekiliþ ödülünü girin ($5,000 ile &200,000 arasýnda olmalýdýr):", "Deðiþtir", "Geri");
	        }
	        case 3:
	        {
                if (Birlikler[PlayerData[playerid][pFaction]][CekilisBasladi] == false) return HataMesajGonder(playerid, "Çekiliþ baþlatýlmamýþ.");
                if (Birlikler[PlayerData[playerid][pFaction]][cekilisOdul] < 5000 || Birlikler[PlayerData[playerid][pFaction]][birlikKasaPara] < Birlikler[PlayerData[playerid][pFaction]][cekilisOdul])
                {
                    HataMesajGonder(playerid, "Çekiliþ ödülü $5,000'den az veya birlik kasasýnda yeterli para yok.");
                    Dialog_Show(playerid, Cekilis, DIALOG_STYLE_TABLIST, "{38c5f7}Çekiliþ", "{FF0000}» {FFFFFF}Çekiliþ Durumu\t%s\n{FF0000}» {FFFFFF}Çekiliþ Ödül\t{38c5f7}%s\n{FF0000}» {FFFFFF}Katýlýmcý Sayýsý\t%d\n{38c5f7}» {FFFFFF}Çekiliþi Bitir", "Seç", "Geri",
                    (Birlikler[PlayerData[playerid][pFaction]][CekilisBasladi] == false) ? ("{ff0000}Kapalý") : ("{00ff2a}Açýk"), FormatNumber(Birlikler[PlayerData[playerid][pFaction]][cekilisOdul]), Iter_Count(CekilisKatilimcilar[PlayerData[playerid][pFaction]]));
                    return 1;
                }
                /*if (Iter_Count(CekilisKatilimcilar[PlayerData[playerid][pFaction]]) < 10)
                {
                    HataMesajGonder(playerid, "En az 10 kiþi katýlmadan çekiliþ sonuçlanamaz.");
                    Dialog_Show(playerid, Cekilis, DIALOG_STYLE_TABLIST, "{38c5f7}Çekiliþ", "{FF0000}» {FFFFFF}Çekiliþ Durumu\t%s\n{FF0000}» {FFFFFF}Çekiliþ Ödül\t{38c5f7}%s\n{FF0000}» {FFFFFF}Katýlýmcý Sayýsý\t%d\n{38c5f7}» {FFFFFF}Çekiliþi Bitir", "Seç", "Geri",
                    (Birlikler[PlayerData[playerid][pFaction]][CekilisBasladi] == false) ? ("{ff0000}Kapalý") : ("{00ff2a}Açýk"), FormatNumber(Birlikler[PlayerData[playerid][pFaction]][cekilisOdul]), Iter_Count(CekilisKatilimcilar[PlayerData[playerid][pFaction]]));
                    return 1;
                }*/
                new sqlid = Iter_Random(CekilisKatilimcilar[PlayerData[playerid][pFaction]]);
                new oyuncuID = GetPlayerIDWithSQLID(sqlid);
                if (oyuncuID != -1 && OyundaDegil(oyuncuID))
                {
                    ParaVer(oyuncuID, Birlikler[PlayerData[playerid][pFaction]][cekilisOdul]);
                    MesajGonder(oyuncuID, "%s adlý yayýn ajansýnýn yaptýðý %s deðerindeki çekiliþi kazandýnýz!", Birlikler[PlayerData[playerid][pFaction]][birlikAd], FormatNumber(Birlikler[PlayerData[playerid][pFaction]][cekilisOdul]));
                }
                else
                {
                    new str[100];
                    format(str, sizeof(str), "%s adlý yayýn ajansýnýn yaptýðý %s deðerindeki çekiliþi kazandýnýz!",Birlikler[PlayerData[playerid][pFaction]][birlikAd], FormatNumber(Birlikler[PlayerData[playerid][pFaction]][cekilisOdul]));
                    BildirimEkle(sqlid, str, "Sistem");
                    OfflineParaVer(sqlid, Birlikler[PlayerData[playerid][pFaction]][cekilisOdul]);
                }
                foreach (new i:Player) if ((PlayerData[i][pDinle] == PlayerData[playerid][pFaction] || i == playerid) && PlayerData[i][pAyarlar][2] == 0)
    			{
        			SendClientMessageEx(i, 0x42f445FF, "[%s] %s, %s deðerindeki çekiliþi kazandý!", Birlikler[PlayerData[playerid][pFaction]][birlikAd], SQLName(sqlid, 0), FormatNumber(Birlikler[PlayerData[playerid][pFaction]][cekilisOdul]));
    			}
                Birlikler[PlayerData[playerid][pFaction]][birlikKasaPara] -= Birlikler[PlayerData[playerid][pFaction]][cekilisOdul];
                Birlikler[PlayerData[playerid][pFaction]][CekilisBasladi] = false;
                Birlikler[PlayerData[playerid][pFaction]][cekilisOdul] = 0;
                Iter_Clear(CekilisKatilimcilar[PlayerData[playerid][pFaction]]);
	        }
	    }
	}
	return 1;
}
Dialog:CekilisOdul(playerid, response, listitem, inputtext[])
{
	if (!response)
	{
	    Dialog_Show(playerid, Cekilis, DIALOG_STYLE_TABLIST, "{38c5f7}Çekiliþ", "{FF0000}» {FFFFFF}Çekiliþ Durumu\t%s\n{FF0000}» {FFFFFF}Çekiliþ Ödül\t{38c5f7}%s\n{FF0000}» {FFFFFF}Katýlýmcý Sayýsý\t%d\n{38c5f7}» {FFFFFF}Çekiliþi Bitir", "Seç", "Geri",
        (Birlikler[PlayerData[playerid][pFaction]][CekilisBasladi] == false) ? ("{ff0000}Kapalý") : ("{00ff2a}Açýk"), FormatNumber(Birlikler[PlayerData[playerid][pFaction]][cekilisOdul]), Iter_Count(CekilisKatilimcilar[PlayerData[playerid][pFaction]]));
	}
	if (response)
	{
	    if (isnull(inputtext)) return Dialog_Show(playerid, CekilisOdul, DIALOG_STYLE_INPUT, "{38c5f7}Çekiliþ Ödül", "Lütfen çekiliþ ödülünü girin ($5,000 ile &200,000 arasýnda olmalýdýr):", "Deðiþtir", "Geri");
	    if (!IsNumeric(inputtext)) return Dialog_Show(playerid, CekilisOdul, DIALOG_STYLE_INPUT, "{38c5f7}Çekiliþ Ödül", "Lütfen çekiliþ ödülünü girin ($5,000 ile &200,000 arasýnda olmalýdýr):", "Deðiþtir", "Geri");
	    if (strval(inputtext) < 5000 || strval(inputtext) > 200000) return Dialog_Show(playerid, CekilisOdul, DIALOG_STYLE_INPUT, "{38c5f7}Çekiliþ Ödül", "Lütfen çekiliþ ödülünü girin ($5,000 ile &200,000 arasýnda olmalýdýr):", "Deðiþtir", "Geri");
	    if (Birlikler[PlayerData[playerid][pFaction]][birlikKasaPara] < strval(inputtext))
	    {
            HataMesajGonder(playerid, "Birlik kasasýnda o kadar para yok!");
            return Dialog_Show(playerid, CekilisOdul, DIALOG_STYLE_INPUT, "{38c5f7}Çekiliþ Ödül", "Lütfen çekiliþ ödülünü girin ($5,000 ile &200,000 arasýnda olmalýdýr):", "Deðiþtir", "Geri");
	    }
	    Birlikler[PlayerData[playerid][pFaction]][cekilisOdul] = strval(inputtext);
	    Dialog_Show(playerid, Cekilis, DIALOG_STYLE_TABLIST, "{38c5f7}Çekiliþ", "{FF0000}» {FFFFFF}Çekiliþ Durumu\t%s\n{FF0000}» {FFFFFF}Çekiliþ Ödül\t{38c5f7}%s\n{FF0000}» {FFFFFF}Katýlýmcý Sayýsý\t%d\n{38c5f7}» {FFFFFF}Çekiliþi Bitir", "Seç", "Geri",
        (Birlikler[PlayerData[playerid][pFaction]][CekilisBasladi] == false) ? ("{ff0000}Kapalý") : ("{00ff2a}Açýk"), FormatNumber(Birlikler[PlayerData[playerid][pFaction]][cekilisOdul]), Iter_Count(CekilisKatilimcilar[PlayerData[playerid][pFaction]]));
	}
	return 1;
}
Dialog:CekilisBaslat(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (isnull(inputtext)) return Dialog_Show(playerid, CekilisBaslat, DIALOG_STYLE_INPUT, "{38c5f7}Çekiliþ Baþlat", "Lütfen çekiliþ ödülünü girin ($5,000 ile &200,000 arasýnda olmalýdýr):", "Baþlat", "Kapat");
	    if (!IsNumeric(inputtext)) return Dialog_Show(playerid, CekilisBaslat, DIALOG_STYLE_INPUT, "{38c5f7}Çekiliþ Baþlat", "Lütfen çekiliþ ödülünü girin ($5,000 ile &200,000 arasýnda olmalýdýr):", "Baþlat", "Kapat");
	    if (strval(inputtext) < 5000 || strval(inputtext) > 200000) return Dialog_Show(playerid, CekilisBaslat, DIALOG_STYLE_INPUT, "{38c5f7}Çekiliþ Baþlat", "Lütfen çekiliþ ödülünü girin ($5,000 ile &200,000 arasýnda olmalýdýr):", "Baþlat", "Kapat");
	    if (Birlikler[PlayerData[playerid][pFaction]][birlikKasaPara] < strval(inputtext))
	    {
	        HataMesajGonder(playerid, "Birlik kasasýnda o kadar para yok!");
	        return Dialog_Show(playerid, CekilisBaslat, DIALOG_STYLE_INPUT, "{38c5f7}Çekiliþ Baþlat", "Lütfen çekiliþ ödülünü girin ($5,000 ile &200,000 arasýnda olmalýdýr):", "Baþlat", "Kapat");
	    }
	    Birlikler[PlayerData[playerid][pFaction]][CekilisBasladi] = true;
        Iter_Clear(CekilisKatilimcilar[PlayerData[playerid][pFaction]]);
        Birlikler[PlayerData[playerid][pFaction]][cekilisOdul] = strval(inputtext);
        foreach (new i:Player) if ((PlayerData[i][pDinle] == PlayerData[playerid][pFaction] || i == playerid) && PlayerData[i][pAyarlar][2] == 0)
    	{
        	SendClientMessageEx(i, 0x42f445FF, "[%s] %s %s deðerinde çekiliþ baþlattý. (/cekiliskatil)", Birlikler[PlayerData[playerid][pFaction]][birlikAd], ReturnName(playerid, 0), FormatNumber(strval(inputtext)));
    	}
    	MesajGonder(playerid, "Çekiliþ baþlatýldý, çekiliþ ayarlarýndan \"Çekiliþi Bitir\" seçeneðine týklayarak çekiliþi sonuçlandýrabilirsiniz.");
	}
	return 1;
}
Dialog:ReklamUcreti(playerid, response, listitem, inputtext[])
{
	if (!response) return AjansAyarlari(playerid);
	if (response)
	{
	    if (isnull(inputtext)) return Dialog_Show(playerid, ReklamUcreti, DIALOG_STYLE_INPUT, "{38c5f7}Reklam Ücreti", "Lütfen yeni bir reklam ücreti girin:", "Devam", "Geri");
	    if (!IsNumeric(inputtext)) return Dialog_Show(playerid, ReklamUcreti, DIALOG_STYLE_INPUT, "{38c5f7}Reklam Ücreti", "Lütfen yeni bir reklam ücreti girin:", "Devam", "Geri");
	    if (strval(inputtext) <= 0 || strval(inputtext) >= 500)
	    {
	        HataMesajGonder(playerid, "Geçersiz fiyat girdiniz. ($1-500) arasý deðer girilmelidir.)");
	        return Dialog_Show(playerid, ReklamUcreti, DIALOG_STYLE_INPUT, "{38c5f7}Reklam Ücreti", "Lütfen yeni bir reklam ücreti girin:\n{FF0000}(Lütfen mantýklý bir rakam girin)", "Sat", "Geri");
	    }
	    Birlikler[PlayerData[playerid][pFaction]][ReklamUcreti] = strval(inputtext);
	    if (IsValidDynamicPickup(Birlikler[PlayerData[playerid][pFaction]][reklamPickup])) DestroyDynamicPickup(Birlikler[PlayerData[playerid][pFaction]][reklamPickup]);
     	if (IsValidDynamic3DTextLabel(Birlikler[PlayerData[playerid][pFaction]][reklamLabel])) DestroyDynamic3DTextLabel(Birlikler[PlayerData[playerid][pFaction]][reklamLabel]);
      	Birlikler[PlayerData[playerid][pFaction]][reklamPickup] = CreateDynamicPickup(1239, 23, Birlikler[PlayerData[playerid][pFaction]][reklamPos][0], Birlikler[PlayerData[playerid][pFaction]][reklamPos][1], Birlikler[PlayerData[playerid][pFaction]][reklamPos][2]);
       	new str[124];
        format(str, sizeof(str), "{E74C3C}[Reklam Noktasý]\n{E74C3C}Ajans: {FFFFFF}%s\n{E74C3C}Ücret: {FFFFFF}%s\n{E74C3C}(/reklamver)", Birlikler[PlayerData[playerid][pFaction]][birlikAd], FormatNumber(Birlikler[PlayerData[playerid][pFaction]][ReklamUcreti]));
        Birlikler[PlayerData[playerid][pFaction]][reklamLabel] = CreateDynamic3DTextLabel(str, -1, Birlikler[PlayerData[playerid][pFaction]][reklamPos][0], Birlikler[PlayerData[playerid][pFaction]][reklamPos][1], Birlikler[PlayerData[playerid][pFaction]][reklamPos][2], 10.0);
	    Birlik_Kaydet(PlayerData[playerid][pFaction]);
	    AjansAyarlari(playerid);
	}
	return 1;
}
Dialog:BirliktenAt(playerid, response, listitem, inputtext[])
{
	if (!response) return callcmd::birlik(playerid);
	if (response)
	{
	    if (isnull(inputtext)) return Dialog_Show(playerid,BirliktenAt,DIALOG_STYLE_INPUT, "{72C425}Üye At", "{FFFFFF}Lütfen birlikten atmak istediðiniz kiþinin ID'sini girin.", "Devam", "Geri");
		if (!IsNumeric(inputtext)) return Dialog_Show(playerid,BirliktenAt,DIALOG_STYLE_INPUT, "{72C425}Üye At", "{FFFFFF}Lütfen birlikten atmak istediðiniz kiþinin ID'sini girin.", "Devam", "Geri");
		if (!OyundaDegil(strval(inputtext)))
		{
		    HataMesajGonder(playerid, "Böyle bir kiþi yok.");
		    return Dialog_Show(playerid,BirliktenAt,DIALOG_STYLE_INPUT, "{72C425}Üye At", "{FFFFFF}Lütfen birlikten atmak istediðiniz kiþinin ID'sini girin.", "Devam", "Geri");
		}
		new targetid = strval(inputtext);
		if (PlayerData[playerid][pFaction] != PlayerData[targetid][pFaction])
		{
		    HataMesajGonder(playerid, "Bu kiþi sizin birliðinizden deðil.");
		    return Dialog_Show(playerid,BirliktenAt,DIALOG_STYLE_INPUT, "{72C425}Üye At", "{FFFFFF}Lütfen birlikten atmak istediðiniz kiþinin ID'sini girin.", "Devam", "Geri");
		}
		if (targetid == playerid)
		{
		    HataMesajGonder(playerid, "Kendi kendini birlikten atamazsýn.");
		    return 1;
		}
		if (GetFactionType(targetid) == BIRLIK_LSPD || GetFactionType(targetid) == BIRLIK_FBI)
		{
		    ZirhAyarla(targetid,0);
		    ResetWeapons(targetid);
		}
		SendBirlikMessage(PlayerData[playerid][pFaction],-1, "{ff7c4d}BÝRLÝK: {FFFFFF}%s adlý kiþi, %s adlý kiþiyi birlikten attý.",ReturnName(playerid,0),ReturnName(pID,0));
		BirliktenAt(targetid);
		Oyuncu_Kaydet(targetid);
	}
	return 1;
}
Dialog:OfflineUyeler(playerid, response, listitem, inputtext[])
{
	if (!response) return callcmd::birlik(playerid);
	if (response)
	{
	    new notreal[128],idx;
	    notreal = strtok(inputtext,idx);
	    SetPVarInt(playerid, "OfflineSQLID",strval(notreal));
	    if (Birlikler[PlayerData[playerid][pFaction]][birlikTip] >= 1 && Birlikler[PlayerData[playerid][pFaction]][birlikTip] <= 3 && Birlikler[PlayerData[playerid][pFaction]][birlikTip] != 4)
	    {
	        Dialog_Show(playerid,OfflineUyeDuzenle,DIALOG_STYLE_LIST, "{72C425}Üye Ýþlem", "{ED4D18}» Birlikten At\n{ED4D18}» Rütbe Deðiþtir", "Seç", "Geri");
	    }
	    else
	    {
	        Dialog_Show(playerid,OfflineUyeDuzenle,DIALOG_STYLE_LIST, "{72C425}Üye Ýþlem", "{ED4D18}» Birlikten At\n{ED4D18}» Rütbe Deðiþtir\n{ED4D18}» Divizyon Deðiþtir", "Seç", "Geri");
	    }
	}
	return 1;
}
Dialog:OfflineUyeDuzenle(playerid, response, listitem, inputtext[])
{
	if (!response) return Birlik_OfflineUyeler(playerid,PlayerData[playerid][pFaction]);
	if (response)
	{
	    new sqlid = GetPVarInt(playerid, "OfflineSQLID");
     	if (listitem == 0)
     	{
     	    new query[300];
     	    format(query,sizeof(query), "UPDATE `oyuncular` SET `Birlik` = '-1',`BirlikRutbe` = '0',`BirlikDivizyon` = '0' WHERE `ID` = '%d'",sqlid);
     	    mysql_query(g_SQL,query, false);
     	    format(query,sizeof(query), "%s tarafýndan birlikten atýldýn.",ReturnName(playerid,0));
     	    BildirimEkle(sqlid,query, "Birlik");
	     	SendBirlikMessage(PlayerData[playerid][pFaction],-1, "{ff7c4d}BÝRLÝK: {FFFFFF}%s adlý kiþi, %s tarafýndan birlikten atýldý.",SQLName(sqlid,0),ReturnName(playerid,0));
			Birlik_OfflineUyeler(playerid,PlayerData[playerid][pFaction]);
			return 1;
 		}
 		if (listitem == 1)
 		{
 		    SetPVarInt(playerid, "OffRank",1);
 		    RutbeDegistirmeDialog(playerid,PlayerData[playerid][pFaction]);
 		    return 1;
 		}
 		if (listitem == 2)
 		{
 		    SetPVarInt(playerid, "OffDiviz",1);
 		    Birlik_DivizyonDegistir(playerid,PlayerData[playerid][pFaction]);
 		}
	}
	return 1;
}
Dialog:RutbeYetkilendirme(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    new factionid = PlayerData[playerid][pFaction];
	    if (listitem == 0) // Üye Alma
	    {
	        Dialog_Show(playerid,UAS,DIALOG_STYLE_INPUT, "{72C425}Üye Alma Seviyesi", "{FFFFFF}Birliðinizde hangi seviyenin üye alabileceðini girin;\nÞu Anki Seviye: {72C425}%d", "Deðiþtir", "Geri",Birlikler[factionid][birlikYetkilendirme][0]);
	    }
	    if (listitem == 1) // Üye Atma
	    {
	        Dialog_Show(playerid,BUAS,DIALOG_STYLE_INPUT, "{72C425}Üye Atma Seviyesi", "{FFFFFF}Birliðinizde hangi seviyenin üye atabileceðini girin;\nÞu Anki Seviye: {72C425}%d", "Deðiþtir", "Geri",Birlikler[factionid][birlikYetkilendirme][1]);
	    }
	    if (listitem == 2) // Rütbe Deðiþtirme
	    {
	        Dialog_Show(playerid,RDS,DIALOG_STYLE_INPUT, "{72C425}Rütbe Deðiþtirme Seviyesi", "{FFFFFF}Birliðinizde hangi seviyenin rütbe deðiþtirebileceðini girin;\nÞu Anki Seviye: {72C425}%d", "Deðiþtir", "Geri",Birlikler[factionid][birlikYetkilendirme][2]);
	    }
	    if (listitem == 3) // Divizyon Deðiþtirme Seviyesi
	    {
	        Dialog_Show(playerid,DDS,DIALOG_STYLE_INPUT, "{72C425}Divizyon Deðiþtirme Seviyesi", "{FFFFFF}Birliðinizde hangi seviyenin divizyon deðiþtirebileceðini girin;\nÞu Anki Seviye: {72C425}%d", "Deðiþtir", "Geri",Birlikler[factionid][birlikYetkilendirme][3]);
	    }
	    if (listitem == 4) // Araçlarý Spawnlama
	    {
	        Dialog_Show(playerid,ASS,DIALOG_STYLE_INPUT, "{72C425}Araçlarý Spawnlama Seviyesi", "{FFFFFF}Birliðinizde hangi seviyenin birlik araçlarýný spawnlayabileceðini girin;\nÞu Anki Seviye: {72C425}%d", "Deðiþtir", "Geri",Birlikler[factionid][birlikYetkilendirme][4]);
	    }
	    if (listitem == 5) // OOC Chat Kapatma Seviyesi
	    {
	        Dialog_Show(playerid,OCKS,DIALOG_STYLE_INPUT, "{72C425}OOC Chat Kapatma Seviyesi", "{FFFFFF}Birliðinizde hangi seviyenin OOC Chat Kapatabileceðini girin;\nÞu Anki Seviye: {72C425}%d", "Deðiþtir", "Geri",Birlikler[factionid][birlikYetkilendirme][5]);
	    }
	    if (listitem == 6) // Birlik Kasasýndan Para Alma
	    {
	        Dialog_Show(playerid,BKPA,DIALOG_STYLE_INPUT, "{72C425}Birlik Kasasýndan Para Alma", "{FFFFFF}Birliðinizde hangi seviyenin Birlik Kasasýndan Para Alabileceðini girin;\nÞu Anki Seviye: {72C425}%d", "Deðiþtir", "Geri",Birlikler[factionid][birlikYetkilendirme][6]);
	    }
	    if (listitem == 7) // Ajans Ayarlari
	    {
	        Dialog_Show(playerid, AjansAyarlariSeviye, DIALOG_STYLE_INPUT, "{72C425}Ajans Ayarlarý Seviyesi", "{FFFFFF}Birliðinizde hangi seviyenin Ajans ayarlarýna eriþebileceðini girin;\nÞu Anki Seviye: {72C425}%d", "Deðiþtir", "Geri",Birlikler[factionid][birlikYetkilendirme][7]);
	    }
	}
	if (!response) return callcmd::birlik(playerid);
	return 1;
}
Dialog:UAS(playerid, response, listitem, inputtext[])
{
	if (!response) return Dialog_Show(playerid,RutbeYetkilendirme,DIALOG_STYLE_LIST, "{72C425} Rütbe Yetkilendirmeleri", "{59DC1C}Üye Alma Seviyesi\n{59DC1C}Üye Atma Seviyesi\n{59DC1C}Rütbe Deðiþtirme Seviyesi\n{59DC1C}Divizyon Deðiþtirme Seviyesi\n{59DC1C}Araçlarý Spawnlama Seviyesi\n{59DC1C}OOC Chat Kapat/Aç Seviyesi\n{59DC1C}Birlik Kasasýndan Para Alma\n{59DC1C}Ajans Ayarlarý Seviyesi", "Seç", "Geri");
	if (response)
	{
	    new factionid = PlayerData[playerid][pFaction];
	    if (isnull(inputtext)) return Dialog_Show(playerid,UAS,DIALOG_STYLE_INPUT, "{72C425}Üye Alma Seviyesi", "{FFFFFF}Birliðinizde hangi seviyenin üye alabileceðini girin;\nÞu Anki Seviye: {72C425}%d", "Deðiþtir", "Geri",Birlikler[factionid][birlikYetkilendirme][0]);
	    if (!IsNumeric(inputtext)) return Dialog_Show(playerid,UAS,DIALOG_STYLE_INPUT, "{72C425}Üye Alma Seviyesi", "{FFFFFF}Birliðinizde hangi seviyenin üye alabileceðini girin;\nÞu Anki Seviye: {72C425}%d", "Deðiþtir", "Geri",Birlikler[factionid][birlikYetkilendirme][0]);
	    if (strval(inputtext) > Birlikler[PlayerData[playerid][pFaction]][birlikRutbeler]) return Dialog_Show(playerid,UAS,DIALOG_STYLE_INPUT, "{72C425}Üye Alma Seviyesi", "{FFFFFF}Birliðinizde hangi seviyenin üye alabileceðini girin;\nÞu Anki Seviye: {72C425}%d", "Deðiþtir", "Geri",Birlikler[factionid][birlikYetkilendirme][0]);
	    Birlikler[PlayerData[playerid][pFaction]][birlikYetkilendirme][0] = strval(inputtext);
	    Birlik_Kaydet(PlayerData[playerid][pFaction]);
	    BilgiMesajGonder(playerid, "Üye Alma seviyesi {72C425}%d {FFFFFF}olarak deðiþtirildi.",strval(inputtext));
	    Dialog_Show(playerid,RutbeYetkilendirme,DIALOG_STYLE_LIST, "{72C425} Rütbe Yetkilendirmeleri", "{59DC1C}Üye Alma Seviyesi\n{59DC1C}Üye Atma Seviyesi\n{59DC1C}Rütbe Deðiþtirme Seviyesi\n{59DC1C}Divizyon Deðiþtirme Seviyesi\n{59DC1C}Araçlarý Spawnlama Seviyesi\n{59DC1C}OOC Chat Kapat/Aç Seviyesi\n{59DC1C}Birlik Kasasýndan Para Alma\n{59DC1C}Ajans Ayarlarý Seviyesi", "Seç", "Geri");

	}
	return 1;
}
Dialog:BUAS(playerid, response, listitem, inputtext[])
{
    if (!response) return Dialog_Show(playerid,RutbeYetkilendirme,DIALOG_STYLE_LIST, "{72C425} Rütbe Yetkilendirmeleri", "{59DC1C}Üye Alma Seviyesi\n{59DC1C}Üye Atma Seviyesi\n{59DC1C}Rütbe Deðiþtirme Seviyesi\n{59DC1C}Divizyon Deðiþtirme Seviyesi\n{59DC1C}Araçlarý Spawnlama Seviyesi\n{59DC1C}OOC Chat Kapat/Aç Seviyesi\n{59DC1C}Birlik Kasasýndan Para Alma\n{59DC1C}Ajans Ayarlarý Seviyesi", "Seç", "Geri");
    if (response)
    {
        new factionid = PlayerData[playerid][pFaction];
		if (isnull(inputtext)) return Dialog_Show(playerid,BUAS,DIALOG_STYLE_INPUT, "{72C425}Üye Atma Seviyesi", "{FFFFFF}Birliðinizde hangi seviyenin üye atabileceðini girin;\nÞu Anki Seviye: {72C425}%d", "Deðiþtir", "Geri",Birlikler[factionid][birlikYetkilendirme][1]);
	 	if (!IsNumeric(inputtext)) return Dialog_Show(playerid,BUAS,DIALOG_STYLE_INPUT, "{72C425}Üye Atma Seviyesi", "{FFFFFF}Birliðinizde hangi seviyenin üye atabileceðini girin;\nÞu Anki Seviye: {72C425}%d", "Deðiþtir", "Geri",Birlikler[factionid][birlikYetkilendirme][1]);
	 	if (strval(inputtext) > Birlikler[PlayerData[playerid][pFaction]][birlikRutbeler]) return Dialog_Show(playerid,BUAS,DIALOG_STYLE_INPUT, "{72C425}Üye Atma Seviyesi", "{FFFFFF}Birliðinizde hangi seviyenin üye atabileceðini girin;\nÞu Anki Seviye: {72C425}%d", "Deðiþtir", "Geri",Birlikler[factionid][birlikYetkilendirme][1]);
	 	Birlikler[PlayerData[playerid][pFaction]][birlikYetkilendirme][1] = strval(inputtext);
	    Birlik_Kaydet(PlayerData[playerid][pFaction]);
	    BilgiMesajGonder(playerid, "Üye Atma seviyesi {72C425}%d {FFFFFF}olarak deðiþtirildi.",strval(inputtext));
	    Dialog_Show(playerid,RutbeYetkilendirme,DIALOG_STYLE_LIST, "{72C425} Rütbe Yetkilendirmeleri", "{59DC1C}Üye Alma Seviyesi\n{59DC1C}Üye Atma Seviyesi\n{59DC1C}Rütbe Deðiþtirme Seviyesi\n{59DC1C}Divizyon Deðiþtirme Seviyesi\n{59DC1C}Araçlarý Spawnlama Seviyesi\n{59DC1C}OOC Chat Kapat/Aç Seviyesi\n{59DC1C}Birlik Kasasýndan Para Alma\n{59DC1C}Ajans Ayarlarý Seviyesi", "Seç", "Geri");
    }
	return 1;
}
Dialog:RDS(playerid, response, listitem, inputtext[])
{
    if (!response) return Dialog_Show(playerid,RutbeYetkilendirme,DIALOG_STYLE_LIST, "{72C425} Rütbe Yetkilendirmeleri", "{59DC1C}Üye Alma Seviyesi\n{59DC1C}Üye Atma Seviyesi\n{59DC1C}Rütbe Deðiþtirme Seviyesi\n{59DC1C}Divizyon Deðiþtirme Seviyesi\n{59DC1C}Araçlarý Spawnlama Seviyesi\n{59DC1C}OOC Chat Kapat/Aç Seviyesi\n{59DC1C}Birlik Kasasýndan Para Alma\n{59DC1C}Ajans Ayarlarý Seviyesi", "Seç", "Geri");
    if (response)
    {
        new factionid = PlayerData[playerid][pFaction];
		if (isnull(inputtext)) return Dialog_Show(playerid,RDS,DIALOG_STYLE_INPUT, "{72C425}Rütbe Deðiþtirme Seviyesi", "{FFFFFF}Birliðinizde hangi seviyenin rütbe deðiþtirebileceðini girin;\nÞu Anki Seviye: {72C425}%d", "Deðiþtir", "Geri",Birlikler[factionid][birlikYetkilendirme][2]);
	 	if (!IsNumeric(inputtext)) return Dialog_Show(playerid,RDS,DIALOG_STYLE_INPUT, "{72C425}Rütbe Deðiþtirme Seviyesi", "{FFFFFF}Birliðinizde hangi seviyenin rütbe deðiþtirebileceðini girin;\nÞu Anki Seviye: {72C425}%d", "Deðiþtir", "Geri",Birlikler[factionid][birlikYetkilendirme][2]);
	 	if (strval(inputtext) > Birlikler[PlayerData[playerid][pFaction]][birlikRutbeler]) return Dialog_Show(playerid,RDS,DIALOG_STYLE_INPUT, "{72C425}Rütbe Deðiþtirme Seviyesi", "{FFFFFF}Birliðinizde hangi seviyenin rütbe deðiþtirebileceðini girin;\nÞu Anki Seviye: {72C425}%d", "Deðiþtir", "Geri",Birlikler[factionid][birlikYetkilendirme][2]);
	 	Birlikler[PlayerData[playerid][pFaction]][birlikYetkilendirme][2] = strval(inputtext);
	    Birlik_Kaydet(PlayerData[playerid][pFaction]);
	    BilgiMesajGonder(playerid, "Rütbe Deðiþtirme Seviyesi {72C425}%d {FFFFFF}olarak deðiþtirildi.",strval(inputtext));
	    Dialog_Show(playerid,RutbeYetkilendirme,DIALOG_STYLE_LIST, "{72C425} Rütbe Yetkilendirmeleri", "{59DC1C}Üye Alma Seviyesi\n{59DC1C}Üye Atma Seviyesi\n{59DC1C}Rütbe Deðiþtirme Seviyesi\n{59DC1C}Divizyon Deðiþtirme Seviyesi\n{59DC1C}Araçlarý Spawnlama Seviyesi\n{59DC1C}OOC Chat Kapat/Aç Seviyesi\n{59DC1C}Birlik Kasasýndan Para Alma\n{59DC1C}Ajans Ayarlarý Seviyesi", "Seç", "Geri");
    }
	return 1;
}
Dialog:DDS(playerid, response, listitem, inputtext[])
{
    if (!response) return  Dialog_Show(playerid,RutbeYetkilendirme,DIALOG_STYLE_LIST, "{72C425} Rütbe Yetkilendirmeleri", "{59DC1C}Üye Alma Seviyesi\n{59DC1C}Üye Atma Seviyesi\n{59DC1C}Rütbe Deðiþtirme Seviyesi\n{59DC1C}Divizyon Deðiþtirme Seviyesi\n{59DC1C}Araçlarý Spawnlama Seviyesi\n{59DC1C}OOC Chat Kapat/Aç Seviyesi\n{59DC1C}Birlik Kasasýndan Para Alma\n{59DC1C}Ajans Ayarlarý Seviyesi", "Seç", "Geri");
    if (response)
    {
        new factionid = PlayerData[playerid][pFaction];
		if (isnull(inputtext)) return  Dialog_Show(playerid,DDS,DIALOG_STYLE_INPUT, "{72C425}Divizyon Deðiþtirme Seviyesi", "{FFFFFF}Birliðinizde hangi seviyenin divizyon deðiþtirebileceðini girin;\nÞu Anki Seviye: {72C425}%d", "Deðiþtir", "Geri",Birlikler[factionid][birlikYetkilendirme][3]);
	 	if (!IsNumeric(inputtext))  return Dialog_Show(playerid,DDS,DIALOG_STYLE_INPUT, "{72C425}Divizyon Deðiþtirme Seviyesi", "{FFFFFF}Birliðinizde hangi seviyenin divizyon deðiþtirebileceðini girin;\nÞu Anki Seviye: {72C425}%d", "Deðiþtir", "Geri",Birlikler[factionid][birlikYetkilendirme][3]);
	 	if (strval(inputtext) > Birlikler[PlayerData[playerid][pFaction]][birlikRutbeler]) return  Dialog_Show(playerid,DDS,DIALOG_STYLE_INPUT, "{72C425}Divizyon Deðiþtirme Seviyesi", "{FFFFFF}Birliðinizde hangi seviyenin divizyon deðiþtirebileceðini girin;\nÞu Anki Seviye: {72C425}%d", "Deðiþtir", "Geri",Birlikler[factionid][birlikYetkilendirme][3]);
	 	Birlikler[PlayerData[playerid][pFaction]][birlikYetkilendirme][3] = strval(inputtext);
	    Birlik_Kaydet(PlayerData[playerid][pFaction]);
	    BilgiMesajGonder(playerid, "Divizyon Deðiþtirme Seviyesi {72C425}%d {FFFFFF}olarak deðiþtirildi.",strval(inputtext));
	    Dialog_Show(playerid,RutbeYetkilendirme,DIALOG_STYLE_LIST, "{72C425} Rütbe Yetkilendirmeleri", "{59DC1C}Üye Alma Seviyesi\n{59DC1C}Üye Atma Seviyesi\n{59DC1C}Rütbe Deðiþtirme Seviyesi\n{59DC1C}Divizyon Deðiþtirme Seviyesi\n{59DC1C}Araçlarý Spawnlama Seviyesi\n{59DC1C}OOC Chat Kapat/Aç Seviyesi\n{59DC1C}Birlik Kasasýndan Para Alma\n{59DC1C}Ajans Ayarlarý Seviyesi", "Seç", "Geri");
    }
	return 1;
}
Dialog:ASS(playerid, response, listitem, inputtext[])
{
    if (!response) return Dialog_Show(playerid,RutbeYetkilendirme,DIALOG_STYLE_LIST, "{72C425} Rütbe Yetkilendirmeleri", "{59DC1C}Üye Alma Seviyesi\n{59DC1C}Üye Atma Seviyesi\n{59DC1C}Rütbe Deðiþtirme Seviyesi\n{59DC1C}Divizyon Deðiþtirme Seviyesi\n{59DC1C}Araçlarý Spawnlama Seviyesi\n{59DC1C}OOC Chat Kapat/Aç Seviyesi\n{59DC1C}Birlik Kasasýndan Para Alma\n{59DC1C}Ajans Ayarlarý Seviyesi", "Seç", "Geri");
    if (response)
    {
        new factionid = PlayerData[playerid][pFaction];
		if (isnull(inputtext)) return  Dialog_Show(playerid,ASS,DIALOG_STYLE_INPUT, "{72C425}Araçlarý Spawnlama Seviyesi", "{FFFFFF}Birliðinizde hangi seviyenin birlik araçlarýný spawnlayabileceðini girin;\nÞu Anki Seviye: {72C425}%d", "Deðiþtir", "Geri",Birlikler[factionid][birlikYetkilendirme][4]);
	 	if (!IsNumeric(inputtext))  return Dialog_Show(playerid,ASS,DIALOG_STYLE_INPUT, "{72C425}Araçlarý Spawnlama Seviyesi", "{FFFFFF}Birliðinizde hangi seviyenin birlik araçlarýný spawnlayabileceðini girin;\nÞu Anki Seviye: {72C425}%d", "Deðiþtir", "Geri",Birlikler[factionid][birlikYetkilendirme][4]);
	 	if (strval(inputtext) > Birlikler[PlayerData[playerid][pFaction]][birlikRutbeler]) return  Dialog_Show(playerid,ASS,DIALOG_STYLE_INPUT, "{72C425}Araçlarý Spawnlama Seviyesi", "{FFFFFF}Birliðinizde hangi seviyenin birlik araçlarýný spawnlayabileceðini girin;\nÞu Anki Seviye: {72C425}%d", "Deðiþtir", "Geri",Birlikler[factionid][birlikYetkilendirme][4]);
	 	Birlikler[PlayerData[playerid][pFaction]][birlikYetkilendirme][4] = strval(inputtext);
	    Birlik_Kaydet(PlayerData[playerid][pFaction]);
	    BilgiMesajGonder(playerid, "Araçlarý Spawnlama Seviyesi {72C425}%d {FFFFFF}olarak deðiþtirildi.",strval(inputtext));
	    Dialog_Show(playerid,RutbeYetkilendirme,DIALOG_STYLE_LIST, "{72C425} Rütbe Yetkilendirmeleri", "{59DC1C}Üye Alma Seviyesi\n{59DC1C}Üye Atma Seviyesi\n{59DC1C}Rütbe Deðiþtirme Seviyesi\n{59DC1C}Divizyon Deðiþtirme Seviyesi\n{59DC1C}Araçlarý Spawnlama Seviyesi\n{59DC1C}OOC Chat Kapat/Aç Seviyesi\n{59DC1C}Birlik Kasasýndan Para Alma\n{59DC1C}Ajans Ayarlarý Seviyesi", "Seç", "Geri");
    }
	return 1;
}
Dialog:OCKS(playerid, response, listitem, inputtext[])
{
    if (!response) return Dialog_Show(playerid,RutbeYetkilendirme,DIALOG_STYLE_LIST, "{72C425} Rütbe Yetkilendirmeleri", "{59DC1C}Üye Alma Seviyesi\n{59DC1C}Üye Atma Seviyesi\n{59DC1C}Rütbe Deðiþtirme Seviyesi\n{59DC1C}Divizyon Deðiþtirme Seviyesi\n{59DC1C}Araçlarý Spawnlama Seviyesi\n{59DC1C}OOC Chat Kapat/Aç Seviyesi\n{59DC1C}Birlik Kasasýndan Para Alma\n{59DC1C}Ajans Ayarlarý Seviyesi", "Seç", "Geri");
    if (response)
    {
        new factionid = PlayerData[playerid][pFaction];
		if (isnull(inputtext)) return  Dialog_Show(playerid,OCKS,DIALOG_STYLE_INPUT, "{72C425}OOC Chat Kapatma Seviyesi", "{FFFFFF}Birliðinizde hangi seviyenin OOC Chat Kapatabileceðini girin;\nÞu Anki Seviye: {72C425}%d", "Deðiþtir", "Geri",Birlikler[factionid][birlikYetkilendirme][5]);
	 	if (!IsNumeric(inputtext))  return Dialog_Show(playerid,OCKS,DIALOG_STYLE_INPUT, "{72C425}OOC Chat Kapatma Seviyesi", "{FFFFFF}Birliðinizde hangi seviyenin OOC Chat Kapatabileceðini girin;\nÞu Anki Seviye: {72C425}%d", "Deðiþtir", "Geri",Birlikler[factionid][birlikYetkilendirme][5]);
	 	if (strval(inputtext) > Birlikler[PlayerData[playerid][pFaction]][birlikRutbeler]) return  Dialog_Show(playerid,OCKS,DIALOG_STYLE_INPUT, "{72C425}OOC Chat Kapatma Seviyesi", "{FFFFFF}Birliðinizde hangi seviyenin OOC Chat Kapatabileceðini girin;\nÞu Anki Seviye: {72C425}%d", "Deðiþtir", "Geri",Birlikler[factionid][birlikYetkilendirme][5]);
	 	Birlikler[PlayerData[playerid][pFaction]][birlikYetkilendirme][5] = strval(inputtext);
	    Birlik_Kaydet(PlayerData[playerid][pFaction]);
	    BilgiMesajGonder(playerid, "OOC Chat Kapatma Seviyesi {72C425}%d {FFFFFF}olarak deðiþtirildi.",strval(inputtext));
	    Dialog_Show(playerid,RutbeYetkilendirme,DIALOG_STYLE_LIST, "{72C425} Rütbe Yetkilendirmeleri", "{59DC1C}Üye Alma Seviyesi\n{59DC1C}Üye Atma Seviyesi\n{59DC1C}Rütbe Deðiþtirme Seviyesi\n{59DC1C}Divizyon Deðiþtirme Seviyesi\n{59DC1C}Araçlarý Spawnlama Seviyesi\n{59DC1C}OOC Chat Kapat/Aç Seviyesi\n{59DC1C}Birlik Kasasýndan Para Alma\n{59DC1C}Ajans Ayarlarý Seviyesi", "Seç", "Geri");
    }
	return 1;
}
Dialog:BKPA(playerid, response, listitem, inputtext[])
{
    if (!response) return Dialog_Show(playerid,RutbeYetkilendirme,DIALOG_STYLE_LIST, "{72C425} Rütbe Yetkilendirmeleri", "{59DC1C}Üye Alma Seviyesi\n{59DC1C}Üye Atma Seviyesi\n{59DC1C}Rütbe Deðiþtirme Seviyesi\n{59DC1C}Divizyon Deðiþtirme Seviyesi\n{59DC1C}Araçlarý Spawnlama Seviyesi\n{59DC1C}OOC Chat Kapat/Aç Seviyesi\n{59DC1C}Birlik Kasasýndan Para Alma\n{59DC1C}Ajans Ayarlarý Seviyesi", "Seç", "Geri");
    if (response)
    {
        new factionid = PlayerData[playerid][pFaction];
		if (isnull(inputtext)) return  Dialog_Show(playerid,BKPA,DIALOG_STYLE_INPUT, "{72C425}Birlik Kasasýndan Para Alma", "{FFFFFF}Birliðinizde hangi seviyenin Birlik Kasasýndan Para Alabileceðini girin;\nÞu Anki Seviye: {72C425}%d", "Deðiþtir", "Geri",Birlikler[factionid][birlikYetkilendirme][6]);
	 	if (!IsNumeric(inputtext))  return Dialog_Show(playerid,BKPA,DIALOG_STYLE_INPUT, "{72C425}Birlik Kasasýndan Para Alma", "{FFFFFF}Birliðinizde hangi seviyenin Birlik Kasasýndan Para Alabileceðini girin;\nÞu Anki Seviye: {72C425}%d", "Deðiþtir", "Geri",Birlikler[factionid][birlikYetkilendirme][6]);
	 	if (strval(inputtext) > Birlikler[PlayerData[playerid][pFaction]][birlikRutbeler]) return  Dialog_Show(playerid,BKPA,DIALOG_STYLE_INPUT, "{72C425}Birlik Kasasýndan Para Alma", "{FFFFFF}Birliðinizde hangi seviyenin Birlik Kasasýndan Para Alabileceðini girin;\nÞu Anki Seviye: {72C425}%d", "Deðiþtir", "Geri",Birlikler[factionid][birlikYetkilendirme][6]);
	 	Birlikler[PlayerData[playerid][pFaction]][birlikYetkilendirme][6] = strval(inputtext);
	    Birlik_Kaydet(PlayerData[playerid][pFaction]);
	    BilgiMesajGonder(playerid, "Birlik Kasasýndan Para Alma Seviyesi {72C425}%d {FFFFFF}olarak deðiþtirildi.",strval(inputtext));
	    Dialog_Show(playerid,RutbeYetkilendirme,DIALOG_STYLE_LIST, "{72C425} Rütbe Yetkilendirmeleri", "{59DC1C}Üye Alma Seviyesi\n{59DC1C}Üye Atma Seviyesi\n{59DC1C}Rütbe Deðiþtirme Seviyesi\n{59DC1C}Divizyon Deðiþtirme Seviyesi\n{59DC1C}Araçlarý Spawnlama Seviyesi\n{59DC1C}OOC Chat Kapat/Aç Seviyesi\n{59DC1C}Birlik Kasasýndan Para Alma\n{59DC1C}Ajans Ayarlarý Seviyesi", "Seç", "Geri");
    }
	return 1;
}
Dialog:AjansAyarlariSeviye(playerid, response, listitem, inputtext[])
{
    if (!response) return Dialog_Show(playerid,RutbeYetkilendirme,DIALOG_STYLE_LIST, "{72C425} Rütbe Yetkilendirmeleri", "{59DC1C}Üye Alma Seviyesi\n{59DC1C}Üye Atma Seviyesi\n{59DC1C}Rütbe Deðiþtirme Seviyesi\n{59DC1C}Divizyon Deðiþtirme Seviyesi\n{59DC1C}Araçlarý Spawnlama Seviyesi\n{59DC1C}OOC Chat Kapat/Aç Seviyesi\n{59DC1C}Birlik Kasasýndan Para Alma\n{59DC1C}Ajans Ayarlarý Seviyesi", "Seç", "Geri");
    if (response)
    {
        new factionid = PlayerData[playerid][pFaction];
		if (isnull(inputtext)) return  Dialog_Show(playerid, AjansAyarlariSeviye, DIALOG_STYLE_INPUT, "{72C425}Ajans Ayarlarý Seviyesi", "{FFFFFF}Birliðinizde hangi seviyenin Ajans ayarlarýna eriþebileceðini girin;\nÞu Anki Seviye: {72C425}%d", "Deðiþtir", "Geri",Birlikler[factionid][birlikYetkilendirme][7]);
	 	if (!IsNumeric(inputtext))  return Dialog_Show(playerid, AjansAyarlariSeviye, DIALOG_STYLE_INPUT, "{72C425}Ajans Ayarlarý Seviyesi", "{FFFFFF}Birliðinizde hangi seviyenin Ajans ayarlarýna eriþebileceðini girin;\nÞu Anki Seviye: {72C425}%d", "Deðiþtir", "Geri",Birlikler[factionid][birlikYetkilendirme][7]);
	 	if (strval(inputtext) > Birlikler[PlayerData[playerid][pFaction]][birlikRutbeler]) return  Dialog_Show(playerid, AjansAyarlariSeviye, DIALOG_STYLE_INPUT, "{72C425}Ajans Ayarlarý Seviyesi", "{FFFFFF}Birliðinizde hangi seviyenin Ajans ayarlarýna eriþebileceðini girin;\nÞu Anki Seviye: {72C425}%d", "Deðiþtir", "Geri",Birlikler[factionid][birlikYetkilendirme][7]);
	 	Birlikler[PlayerData[playerid][pFaction]][birlikYetkilendirme][7] = strval(inputtext);
	    Birlik_Kaydet(PlayerData[playerid][pFaction]);
	    BilgiMesajGonder(playerid, "Ajans ayarlarý seviyesi {72C425}%d {FFFFFF}olarak deðiþtirildi.",strval(inputtext));
	    Dialog_Show(playerid,RutbeYetkilendirme,DIALOG_STYLE_LIST, "{72C425} Rütbe Yetkilendirmeleri", "{59DC1C}Üye Alma Seviyesi\n{59DC1C}Üye Atma Seviyesi\n{59DC1C}Rütbe Deðiþtirme Seviyesi\n{59DC1C}Divizyon Deðiþtirme Seviyesi\n{59DC1C}Araçlarý Spawnlama Seviyesi\n{59DC1C}OOC Chat Kapat/Aç Seviyesi\n{59DC1C}Birlik Kasasýndan Para Alma\n{59DC1C}Ajans Ayarlarý Seviyesi", "Seç", "Geri");
    }
	return 1;
}
Dialog:EditRanks(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (!Birlikler[PlayerData[playerid][pFactionEdit]][birlikExists])
			return 0;

		PlayerData[playerid][pSelectedSlot] = listitem;
		Dialog_Show(playerid, SetRankName, DIALOG_STYLE_INPUT, "Rütbe Düzenle", "%d. Rütbe için lütfen yeni bir ad girin:\nÞu anki ad: %s", "Tamam", "{FF6347}Iptal", PlayerData[playerid][pSelectedSlot] + 1, BirlikRutbe[PlayerData[playerid][pFactionEdit]][PlayerData[playerid][pSelectedSlot]]);
	}
	if (!response)
	{
	    PlayerData[playerid][pFactionEdit] = -1;
	    PlayerData[playerid][pSelectedSlot] = -1;
	    callcmd::birlik(playerid);

	}
	return 1;
}
Dialog:DivizyonDuzenle(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (!Birlikler[PlayerData[playerid][pFactionEdit]][birlikExists])
			return 0;

		PlayerData[playerid][pSelectedSlot] = listitem;
		Dialog_Show(playerid, DivizyonAdiDuzenle, DIALOG_STYLE_INPUT, "Divizyon Düzenle", "%d. Divizyon için lütfen yeni bir ad girin:\nÞu anki ad: %s", "Tamam", "{FF6347}Iptal", PlayerData[playerid][pSelectedSlot]+1, BirlikDivizyon[PlayerData[playerid][pFactionEdit]][PlayerData[playerid][pSelectedSlot]]);
	}
	return 1;
}
Dialog:DivizyonAdiDuzenle(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (isnull(inputtext))
			return Dialog_Show(playerid, DivizyonAdiDuzenle, DIALOG_STYLE_INPUT, "Divizyon Düzenle", "%d. Divizyon için lütfen yeni bir ad girin:\nÞu anki ad: %s", "Tamam", "{FF6347}Iptal", PlayerData[playerid][pSelectedSlot]+1, BirlikDivizyon[PlayerData[playerid][pFactionEdit]][PlayerData[playerid][pSelectedSlot]]);

	    if (strlen(inputtext) > 20)
	        return Dialog_Show(playerid, DivizyonAdiDuzenle, DIALOG_STYLE_INPUT, "Divizyon Düzenle", "{FF0000}HATA: en fazla 20 karakterden oluþabilir.\n%d. Divizyon için lütfen yeni bir ad girin:\nÞu anki ad: %s", "Tamam", "{FF6347}Iptal", PlayerData[playerid][pSelectedSlot]+1, BirlikDivizyon[PlayerData[playerid][pFactionEdit]][PlayerData[playerid][pSelectedSlot]]);

		format(BirlikDivizyon[PlayerData[playerid][pFactionEdit]][PlayerData[playerid][pSelectedSlot]], 20, inputtext);
		Birlik_Kaydet(PlayerData[playerid][pFactionEdit]);

		Birlik_DivizyonlariGoster(playerid, PlayerData[playerid][pFactionEdit]);
		BilgiMesajGonder(playerid, "%d. divizyon adý \"%s\" olarak deðiþtirildi.", PlayerData[playerid][pSelectedSlot] + 1, inputtext);
	}
	else Birlik_DivizyonlariGoster(playerid, PlayerData[playerid][pFactionEdit]);
	return 1;
}
Dialog:SetRankName(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (isnull(inputtext))
			return Dialog_Show(playerid, SetRankName, DIALOG_STYLE_INPUT, "Rütbe Düzenle", "%d. Rütbe için lütfen yeni bir ad girin:\nÞu anki ad: %s", "Tamam", "{FF6347}Iptal", PlayerData[playerid][pSelectedSlot] + 1, BirlikRutbe[PlayerData[playerid][pFactionEdit]][PlayerData[playerid][pSelectedSlot]]);

	    if (strlen(inputtext) > 32)
	        return Dialog_Show(playerid, SetRankName, DIALOG_STYLE_INPUT, "Rütbe Düzenle", "%d. Rütbe için lütfen yeni bir ad girin:\nÞu anki ad: %s", "Tamam", "{FF6347}Iptal", PlayerData[playerid][pSelectedSlot] + 1, BirlikRutbe[PlayerData[playerid][pFactionEdit]][PlayerData[playerid][pSelectedSlot]]);

		format(BirlikRutbe[PlayerData[playerid][pFactionEdit]][PlayerData[playerid][pSelectedSlot]], 32, inputtext);
		Birlik_Kaydet(PlayerData[playerid][pFactionEdit]);

		Birlik_RutbeleriGoster(playerid, PlayerData[playerid][pFactionEdit]);
		BilgiMesajGonder(playerid, "%d. rütbenin adý \"%s\" olarak deðiþtirildi.", PlayerData[playerid][pSelectedSlot] + 1, inputtext);
	}
	else Birlik_RutbeleriGoster(playerid, PlayerData[playerid][pFactionEdit]);
	return 1;
}
Dialog:RutbeDegistir(playerid, response, listitem, inputtext[])
{
	if (!response) return callcmd::birlik(playerid);
	if (response)
	{
	    new userid, notreal[128], idx;
		notreal = strtok(inputtext, idx);
		userid = strval(notreal);
		SetPVarInt(playerid, "RutbeChange",userid);
		//if (userid == playerid) return HataMesajGonder(playerid, "Kendi rütbeni deðiþtiremezsin.");
		if (PlayerData[userid][pFactionRutbe] > PlayerData[playerid][pFactionRutbe]) return HataMesajGonder(playerid, "Kendinden yüksek rütbeli kiþinin rütbesini deðiþtiremezsin.");
		SetPVarInt(playerid, "OffRank",0);
		RutbeDegistirmeDialog(playerid,PlayerData[playerid][pFaction]);
	}
	return 1;
}
Dialog:DivizyonDegistir(playerid, response, listitem, inputtext[])
{
    if (response)
	{
		new userid, notreal[128], idx;
		notreal = strtok(inputtext, idx);
		userid = strval(notreal);
		SetPVarInt(playerid, "DivizyonChange", userid);
		Birlik_DivizyonDegistir(playerid, PlayerData[playerid][pFaction]);
 	}
	return 1;
}
Dialog:DivizyonSec(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    if (!Birlikler[PlayerData[playerid][pFaction]][birlikExists])
				return 0;
	    if (GetPVarInt(playerid, "OffDiviz") == 1)
	    {
	        new sqlid = GetPVarInt(playerid, "OfflineSQLID"), query[256];
            if (listitem == 0)
			{
			    format(query, sizeof(query), "UPDATE `oyuncular` SET `BirlikDivizyon` = '0' WHERE `ID` = '%d'", sqlid);
				mysql_query(g_SQL, query, false);
			    BilgiMesajGonder(playerid, "%s adlý oyuncuyu divizyonundan çýkardýnýz. ", SQLName(sqlid));
			    DeletePVar(playerid, "OffDiviz");
			    DeletePVar(playerid, "OfflineSQLID");
			    return 1;
			}


	    	format(query, sizeof(query), "UPDATE `oyuncular` SET `BirlikDivizyon` = '%d' WHERE `ID` = '%d'", listitem, sqlid);
			mysql_query(g_SQL, query, false);

	        callcmd::birlik(playerid);
		    BilgiMesajGonder(playerid, "%s adlý oyuncunun divizyonunu %s olarak deðiþtirdin. ", SQLName(sqlid), BirlikDivizyon[PlayerData[playerid][pFaction]][(listitem+1) - 1]);
		    DeletePVar(playerid, "OffDiviz");
		    DeletePVar(playerid, "OfflineSQLID");
		}
		else {

	        new userid = GetPVarInt(playerid, "DivizyonChange");
			if (listitem == 0)
			{
			    PlayerData[userid][pFactionDivizyon] = 0;
			    BilgiMesajGonder(playerid, "%s adlý oyuncuyu divizyondan çýkardýnýz. ", ReturnName(userid, 0));
		    	BilgiMesajGonder(userid, "%s tarafýndan divizyonunuzdan çýkarýldýnýz.", ReturnName(playerid, 0));
		    	DeletePVar(playerid, "OffDiviz");
			    DeletePVar(playerid, "DivizyonChange");
			    return 1;
			}

			if (PlayerData[userid][pFaction] != PlayerData[playerid][pFaction])
			    return HataMesajGonder(playerid, "Bu oyuncu senin birliðinde deðil.");

			PlayerData[userid][pFactionDivizyon] = listitem;
	        callcmd::birlik(playerid);
		    BilgiMesajGonder(playerid, "%s adlý oyuncunun divizyonunu %s olarak deðiþtirdin. ", ReturnName(userid, 0), Birlik_GetDivizyon(userid));
		    BilgiMesajGonder(userid, "%s adlý kiþi divizyonunu %s olarak deðiþtirdi.", ReturnName(playerid, 0), Birlik_GetDivizyon(userid));
		    DeletePVar(playerid, "OffDiviz");
		    DeletePVar(playerid, "DivizyonChange");
		}
	}
	return 1;
}
Dialog:RutbeSec(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    new bid = PlayerData[playerid][pFaction];
	    if (bid == -1) return 1;
	    if (!Birlikler[bid][birlikExists]) return 0;
	    if (GetPVarInt(playerid, "OffRank") == 1)
	    {
	        new sqlid = GetPVarInt(playerid, "OfflineSQLID"), query[256];
	        format(query,sizeof(query), "UPDATE `oyuncular` SET `BirlikRutbe` = '%d' WHERE `ID` = '%d'",listitem+1,sqlid);
	        mysql_query(g_SQL,query, false);
	        BilgiMesajGonder(playerid, "%s adlý kiþinin rütbesi %s olarak deðiþtirildi.",SQLName(sqlid,0),BirlikRutbe[PlayerData[playerid][pFaction]][(listitem+1) - 1]);
	        DeletePVar(playerid, "OffRank");
	        callcmd::birlik(playerid);
	    }
	    else
	    {
	        new id = GetPVarInt(playerid, "RutbeChange");
	        if (!OyundaDegil(id))
	        {
	            HataMesajGonder(playerid, "Böyle bir oyuncu yok.");
	            DeletePVar(playerid, "RutbeChange");
	            callcmd::birlik(playerid);
	            return 1;
	        }
	        if (PlayerData[id][pFaction] != PlayerData[playerid][pFaction])
	        {
	            HataMesajGonder(playerid, "Bu oyuncu bu birlikte deðil.");
	            DeletePVar(playerid, "RutbeChange");
	            callcmd::birlik(playerid);
	            return 1;
	        }
	        PlayerData[id][pFactionRutbe] = listitem+1;
	        callcmd::birlik(playerid);
	        BilgiMesajGonder(id, "%s tarafýndan rütbeniz %s olarak ayarlandý.",ReturnName(playerid,0),Birlik_GetRutbe(id));
	        BilgiMesajGonder(playerid, "%s adlý kiþinin rütbesi %s olarak ayarlandý.",ReturnName(id,0),Birlik_GetRutbe(id));
	        DeletePVar(playerid, "RutbeChange");
	    }
	}
	return 1;
}
Dialog:BirlikDuyuruChange(playerid, response, listitem, inputtext[])
{
	if (!response) return callcmd::birlik(playerid);
	if (response)
	{
	    new id = PlayerData[playerid][pFaction];
	    if (isnull(inputtext))
	    {
	        Birlikler[id][birlikDuyuru][0] = '\0';

			Birlik_Kaydet(id);
			MesajGonder(playerid, "Birlik duyurusu kaldýrýldý.");
	    }
	    else
	    {
	        format(Birlikler[id][birlikDuyuru], 128, inputtext);

			Birlik_Kaydet(id);
			MesajGonder(playerid, "Birlik duyurusu deðiþtirildi.");
	    }
	}
	return 1;
}
Dialog:birlikKasa(playerid, response, listitem, inputtext[])
{
	if (!response) return callcmd::birlik(playerid);
	if (response)
	{
	    if (listitem == 0)
	    {
	        if (PlayerData[playerid][pFaction] == -1) return HataMesajGonder(playerid, "Bir birliðiniz yok.");
	        if (PlayerData[playerid][pFactionRutbe] < Birlikler[PlayerData[playerid][pFaction]][birlikYetkilendirme][6])
	        {
	            HataMesajGonder(playerid, "Kasadan Para almak için yeterli yetkiniz yok.");
	            return callcmd::birlik(playerid);
	        }
	        Dialog_Show(playerid,birlikKasaParaAl,DIALOG_STYLE_INPUT, "Birlik Kasasý - Para Al", "{FFFFFF}Birlik kasasýnda {2ECC71}%s {FFFFFF}miktar para bulunmaktadýr.\n{FFFFFF}Lütfen kasadan almak istediðiniz para miktarýný girin:", "Devam", "Geri",FormatNumber(Birlikler[PlayerData[playerid][pFaction]][birlikKasaPara]));
	    }
	    if (listitem == 1)
	    {
	        if (PlayerData[playerid][pFaction] == -1) return HataMesajGonder(playerid, "Bir birliðiniz yok.");
	        Dialog_Show(playerid,birlikKasaParaKoy,DIALOG_STYLE_INPUT, "Birlik Kasasý - Para Koy", "{FFFFFF}Lütfen birlik kasasýna koymak istediðiniz para miktarýný bakiyenize uygun olarak giriniz:", "Devam", "Geri");
	    }
	}
	return 1;
}
Dialog:birlikKasaParaAl(playerid, response, listitem, inputtext[])
{
    if (!response) return Dialog_Show(playerid,birlikKasa,DIALOG_STYLE_LIST, "Birlik Kasasý", "{2ECC71}Kasadan Al\n{2ECC71}Kasaya Koy", "Seç", "Geri");
    if (response)
    {
        if (PlayerData[playerid][pFaction] == -1) return HataMesajGonder(playerid, "Bir birliðiniz yok.");
        if (isnull(inputtext)) return Dialog_Show(playerid,birlikKasaParaAl,DIALOG_STYLE_INPUT, "Birlik Kasasý - Para Al", "{FFFFFF}Birlik kasasýnda {2ECC71}%s {FFFFFF}miktar para bulunmaktadýr.\n{FFFFFF}Lütfen kasadan almak istediðiniz para miktarýný girin:", "Devam", "Geri",FormatNumber(Birlikler[PlayerData[playerid][pFaction]][birlikKasaPara]));
        if (!IsNumeric(inputtext)) return Dialog_Show(playerid,birlikKasaParaAl,DIALOG_STYLE_INPUT, "Birlik Kasasý - Para Al", "{FFFFFF}Birlik kasasýnda {2ECC71}%s {FFFFFF}miktar para bulunmaktadýr.\n{FFFFFF}Lütfen kasadan almak istediðiniz para miktarýný girin:", "Devam", "Geri",FormatNumber(Birlikler[PlayerData[playerid][pFaction]][birlikKasaPara]));
        if (strval(inputtext) <= 0)
        {
            HataMesajGonder(playerid, "Geçersiz miktar girdiniz.");
            return Dialog_Show(playerid,birlikKasaParaAl,DIALOG_STYLE_INPUT, "Birlik Kasasý - Para Al", "{FFFFFF}Birlik kasasýnda {2ECC71}%s {FFFFFF}miktar para bulunmaktadýr.\n{FFFFFF}Lütfen kasadan almak istediðiniz para miktarýný girin:", "Devam", "Geri",FormatNumber(Birlikler[PlayerData[playerid][pFaction]][birlikKasaPara]));
        }
        if (strval(inputtext) > Birlikler[PlayerData[playerid][pFaction]][birlikKasaPara])
        {
            HataMesajGonder(playerid, "Birlik kasasýnda yeterli para yok.");
            return Dialog_Show(playerid,birlikKasaParaAl,DIALOG_STYLE_INPUT, "Birlik Kasasý - Para Al", "{FFFFFF}Birlik kasasýnda {2ECC71}%s {FFFFFF}miktar para bulunmaktadýr.\n{FFFFFF}Lütfen kasadan almak istediðiniz para miktarýný girin:", "Devam", "Geri",FormatNumber(Birlikler[PlayerData[playerid][pFaction]][birlikKasaPara]));
        }
        Birlikler[PlayerData[playerid][pFaction]][birlikKasaPara] -= strval(inputtext);
        ParaVer(playerid,strval(inputtext));
        SendBirlikMessage(PlayerData[playerid][pFaction],-1, "{ff7c4d}BÝRLÝK: {FFFFFF}%s Adlý birlik üyesi birlik kasasýndan {2ECC71}%s {FFFFFF}miktar para aldý.",ReturnName(playerid,0),FormatNumber(strval(inputtext)));
        Dialog_Show(playerid,birlikKasa,DIALOG_STYLE_LIST, "Birlik Kasasý", "{2ECC71}Kasadan Al\n{2ECC71}Kasaya Koy", "Seç", "Geri");
        Birlik_Kaydet(PlayerData[playerid][pFaction]);
    }
    return 1;
}
Dialog:birlikKasaParaKoy(playerid, response, listitem, inputtext[])
{
     if (!response) return Dialog_Show(playerid,birlikKasa,DIALOG_STYLE_LIST, "Birlik Kasasý", "{2ECC71}Kasadan Al\n{2ECC71}Kasaya Koy", "Seç", "Geri");
     if (response)
     {
        if (PlayerData[playerid][pFaction] == -1) return HataMesajGonder(playerid, "Bir birliðiniz yok.");
        if (isnull(inputtext)) return Dialog_Show(playerid,birlikKasaParaKoy,DIALOG_STYLE_INPUT, "Birlik Kasasý - Para Koy", "{FFFFFF}Lütfen birlik kasasýna koymak istediðiniz para miktarýný bakiyenize uygun olarak giriniz:", "Devam", "Geri");
        if (!IsNumeric(inputtext)) return Dialog_Show(playerid,birlikKasaParaKoy,DIALOG_STYLE_INPUT, "Birlik Kasasý - Para Koy", "{FFFFFF}Lütfen birlik kasasýna koymak istediðiniz para miktarýný bakiyenize uygun olarak giriniz:", "Devam", "Geri");
        if (strval(inputtext) <= 0)
        {
            HataMesajGonder(playerid, "Geçersiz miktar girdiniz.");
            return Dialog_Show(playerid,birlikKasaParaKoy,DIALOG_STYLE_INPUT, "Birlik Kasasý - Para Koy", "{FFFFFF}Lütfen birlik kasasýna koymak istediðiniz para miktarýný bakiyenize uygun olarak giriniz:", "Devam", "Geri");
        }
        if (strval(inputtext) > PlayerData[playerid][pCash])
        {
            HataMesajGonder(playerid, "Üzerinizde yeterli para yok.");
            return Dialog_Show(playerid,birlikKasaParaKoy,DIALOG_STYLE_INPUT, "Birlik Kasasý - Para Koy", "{FFFFFF}Lütfen birlik kasasýna koymak istediðiniz para miktarýný bakiyenize uygun olarak giriniz:", "Devam", "Geri");

        }
        Birlikler[PlayerData[playerid][pFaction]][birlikKasaPara] += strval(inputtext);
        ParaVer(playerid,-strval(inputtext));
        SendBirlikMessage(PlayerData[playerid][pFaction],-1, "{ff7c4d}BÝRLÝK: {FFFFFF}%s Adlý birlik üyesi birlik kasasýna {2ECC71}%s {FFFFFF}miktar para koydu.",ReturnName(playerid,0),FormatNumber(strval(inputtext)));
        Dialog_Show(playerid,birlikKasa,DIALOG_STYLE_LIST, "Birlik Kasasý", "{2ECC71}Kasadan Al\n{2ECC71}Kasaya Koy", "Seç", "Geri");
        Birlik_Kaydet(PlayerData[playerid][pFaction]);
     }
     return 1;
}
Dialog:BirlikDaveti(playerid, response, listitem, inputtext[])
{
	if (response)
	{
	    new
	        id = PlayerData[playerid][pFactionDavetEden],
	        factionid = PlayerData[playerid][pFactionDavet];

		PlayerData[playerid][pFaction] = factionid;
		PlayerData[playerid][pFactionRutbe] = 1;
		PlayerData[playerid][pFactionDivizyon] = 0;
		SendBirlikMessage(factionid,-1, "{ff7c4d}BÝRLÝK: {FFFFFF}%s adlý kiþi, %s adlý kiþiyi birliðe aldý.",ReturnName(id,0),ReturnName(playerid,0));
		PlayerData[playerid][pFactionDavetEden] = -1;
		PlayerData[playerid][pFactionDavet] = -1;
		Birlik_Kaydet(factionid);
		Oyuncu_Kaydet(playerid);
	}
	else
	{
	    BilgiMesajGonder(PlayerData[playerid][pFactionDavetEden], "%s adlý kiþi gönderdiðiniz birlik davetini reddetdi.",ReturnName(playerid,0));
	    PlayerData[playerid][pFactionDavetEden] = -1;
     	PlayerData[playerid][pFactionDavet] = -1;
	}
}
Dialog:BirlikGeriTusu(playerid, response, listitem, inputtext[]) {

	if (!response) return callcmd::birlik(playerid);
	return 1;
}
Dialog:Yas(playerid, response, listitem, inputtext[])
{
	if(!response)
	    return Kick(playerid);
	if(response)
	{
        if (!IsNumeric(inputtext) || strval(inputtext) < 18 || strval(inputtext) > 80)
        {
         	return Dialog_Show(playerid, Yas, DIALOG_STYLE_INPUT, "{C3C3C3}Yaþýnýz", "{FFFFFF}Lütfen karakterinizin yaþýný girin.\n{FFFFFF}Yaþýnýz 18 ile 80 yaþ arasýnda olmalýdýr.", "Devam", "Iptal");
        }
        PlayerData[playerid][pYas] = strval(inputtext);
        new str[400];
        format(str, sizeof(str), "Karakter Oluþturma: {ffffff}Yaþýnýzý %s olarak belirlediniz, devam edebilirsiniz.", PlayerData[playerid][pYas]);
		SendClientMessage(playerid, COLOR_KOlustur, str);
        Dialog_Show(playerid, Cinsiyet, DIALOG_STYLE_MSGBOX, "{C3C3C3}Cinsiyet", "{FFFFFF}Lütfen karakterinizin cinsiyetini belirleyin.", "Erkek", "Kadýn");
	}
	return 1;
}

Dialog:Cinsiyet(playerid, response, listitem, inputtext[])
{
	if(!response)
	{
	    PlayerData[playerid][pCinsiyet] = 2;
	}
	if(response)
	{
	    PlayerData[playerid][pCinsiyet] = 1;
	}
	new str[2048];
    format(str, sizeof(str), "Karakter Oluþturma: {ffffff}Cinsiyetinizi %s olarak belirlediniz, devam edebilirsiniz.", (PlayerData[playerid][pCinsiyet] == 2) ? ("Bayan") : ("Erkek"));
	SendClientMessage(playerid, COLOR_KOlustur, str);
	if(response || !response)
	{
	   // new str[1024];
	    for (new i = 0; i < sizeof DogumYeri; i++)
     	{
      		format(str, sizeof str, "%s{FFFFFF}%s\n", str, DogumYeri[i]);
        }
        Dialog_Show(playerid, DogumYeri, DIALOG_STYLE_LIST, "{C3C3C3}Doðum Yeri", str, "Devam", "Kapat");
	}
	return 1;
}

Dialog:DogumYeri(playerid, response, listitem, inputtext[])
{
	if(!response)
	    return Kick(playerid);
	if(response)
	{
	    format(PlayerData[playerid][pDogum], 30, "%s", DogumYeri[listitem]);
 	  	new str[400];
    	format(str, sizeof(str), "Karakter Oluþturma: {ffffff}Cinsiyetinizi %s olarak belirlediniz, devam edebilirsiniz.", PlayerData[playerid][pDogum]);
		SendClientMessage(playerid, COLOR_KOlustur, str);
	    Dialog_Show(playerid, TenRengi, DIALOG_STYLE_LIST, "{C3C3C3}Ten Rengi", "{FFFFFF}Beyaz\nSiyah", "Devam", "Iptal");
	}
	return 1;
}

Dialog:TenRengi(playerid, response, listitem, inputtext[])
{
    if(!response)
	    return Kick(playerid);
	if(response)
	{
		if(listitem == 0)
		    PlayerData[playerid][pTen] = 1;

		if(listitem == 1)
		    PlayerData[playerid][pTen] = 2;

        TextDrawHideForPlayer(playerid, GirisTD);
        PlayerData[playerid][pCash] = 500;

        SetPVarInt(playerid, "Kayit", 1);

		SetSpawnInfo(playerid, NO_TEAM, (PlayerData[playerid][pCinsiyet] == 1) ? (184) : (12), 1809.3955, -1864.9241, 13.5828, 0.0, 0, 0, 0, 0, 0, 0);
		SpawnPlayer(playerid);
	}
	return 1;
}
Dialog:Giris(playerid, response, listitem, inputtext[])
{
	if(!response)
	    Kick(playerid);

	if(response)
	{
	    new str[512], baslik[64];

		if (!strlen(inputtext))
  		{
  		    format(baslik, sizeof baslik, "{ffffff}Doðrulama - %s", ReturnName(playerid, 0));
    		format(str, sizeof str, "{FFFFFF}Regular Roleplay'a tekrardan hoþgeldin, {898989}%s.\n\n{FFFFFF}Bu hesabýn sana ait olduðunu duðrulayabilmemiz için lütfen\nþifrenini gir.",ReturnName(playerid,0),ReturnName(playerid,0));
   			return Dialog_Show(playerid, Giris, DIALOG_STYLE_PASSWORD, baslik, str, "Doðrula", "Iptal");
		}
		format(str, sizeof str, "SELECT * FROM `oyuncular` WHERE `Isim` = '%s' AND `Sifre` = md5('%s')", ReturnName(playerid), inputtext);
		mysql_tquery(g_SQL, str, "Login", "d", playerid);
	}
	return 1;
}
Dialog:SoruCevapla(playerid, response, listitem, inputtext[]) {

	if (!response) return Kick(playerid);

	if (listitem != Cevaplar[SoruID[playerid]])
	{
		YanlisCevap[playerid]++;
	}
	CevaplananSoru[playerid]++;
	if (CevaplananSoru[playerid] < SonSoruID) SoruSor(playerid);
	else {
	    if (YanlisCevap[playerid] >= 1)
	    {
	        HataMesajGonder(playerid, "Sorulara yanlýþ cevap verdiniz, daha sonra tekrar deneyin.");
	        return Kick(playerid);
	    }
	    MesajGonder(playerid, "Sorulara doðru cevap verdiniz, artýk karakter oluþturabilirsiniz.");

		DeletePVar(playerid, "hata");
		CevapSifirla(playerid);
		new string[280];
		format(string,sizeof(string), "{FFFFFF}Sunucumuza hoþ geldin {C3C3C3}%s, {FFFFFF}karakter oluþturmak için þifrenizi girmelisiniz.\n\n{C3C3C3}Karakter Adý: {C3C3C3}%s\n\nÞifrenizi girin:",ReturnName(playerid,1),ReturnName(playerid,1));
		ShowPlayerDialog(playerid,6,DIALOG_STYLE_INPUT, "{C3C3C3}Kayýt",string, "Devam", "Iptal");
	}

	return 1;
}
Dialog:DIALOG_EHLIYET(playerid, response, listitem, inputtext[])
{
	if(!response)
		return 1;

	switch(listitem)
	{
		case 0:
		{
			if(PlayerData[playerid][pEhliyet] == 1)
				return HataMesajGonder(playerid, "Zaten sürücü lisansýna sahipsiniz.");

			if(PlayerData[playerid][pCash] < EHLIYET_SURUCU)
				return HataMesajGonder(playerid, "Yeterli paranýz yok.");

			ParaVer(playerid, -EHLIYET_SURUCU);
			PlayerData[playerid][pEhliyetSinavinda] = 2;
		}
		case 1:
		{
			if(PlayerData[playerid][pEhliyet] == 2)
				return HataMesajGonder(playerid, "Zaten motor lisansýna sahipsiniz.");

			if(PlayerData[playerid][pCash] < EHLIYET_MOTOR)
				return HataMesajGonder(playerid, "Yeterli paranýz yok.");

			ParaVer(playerid, -EHLIYET_SURUCU);
			PlayerData[playerid][pEhliyetSinavinda] = 1;
		}
	}

	BilgiMesajGonder(playerid, "Sýnav baþladý, bir sürücü kursu aracýna binin ve motoru çalýþtýrýn. (/motor)");
	return 1;
}
Dialog:YonetimKurulu(playerid,response,listitem,inputtext[]) {
    if(response)
    {
        if(listitem == 0)
        {
            Dialog_Show(playerid, YonetimCEO, DIALOG_STYLE_LIST, "Þirket Yönetim Kurulu - Yönetim", "Pozisyona üye ata.\nPozisyondaki üyeyi çýkar.", "Seç", "Çýk");
        }
        if(listitem == 1)
        {
            Dialog_Show(playerid, YonetimGM, DIALOG_STYLE_LIST, "Þirket Yönetim Kurulu - Yönetim", "Pozisyona üye ata.\nPozisyondaki üyeyi çýkar.", "Seç", "Çýk");
        }
    }
    return 1;
}
Dialog:YonetimGM(playerid,response,listitem,inputtext[])  {
    if(response)
    {
        if(listitem == 0)
        {
        	new sirketid = PlayerData[playerid][pSirket];
            sirketGMListele(playerid,sirketid);
        }
        if(listitem == 1)
        {
        	new sirketid = PlayerData[playerid][pSirket];
            format(sirketData[sirketid][sirketGM], 24, "");
        }
    }
    return 1;
}
Dialog:YonetimCEO(playerid,response,listitem,inputtext[])  {
    if(response)
    {
        if(listitem == 0)
        {
        	new sirketid = PlayerData[playerid][pSirket];
            sirketCEOListele(playerid,sirketid);
        }
        if(listitem == 1)
        {
        	new sirketid = PlayerData[playerid][pSirket];
            format(sirketData[sirketid][sirketCEO], 24, "");
        }
    }
    return 1;
}
Dialog:GMUyeler(playerid,response,listitem,inputtext[])
{
	if(response)
    {
    new sirketid = PlayerData[playerid][pSirket];
    new yeniceo = strval(inputtext);
     if(!strcmp(ReturnName(yeniceo,0), sirketData[sirketid][sirketCEO]))
    {
    format(sirketData[sirketid][sirketCEO], 24, "");
    format(sirketData[sirketid][sirketGM], 24, "%s", ReturnName(yeniceo,0));
    Sirket_Kaydet(sirketid);
    } else {
    format(sirketData[sirketid][sirketGM], 24, "%s", ReturnName(yeniceo,0));
    Sirket_Kaydet(sirketid);
    }
    }
    if(!response)
    {
    }
    return 1;
}
Dialog:PozisyonUyeler3(playerid,response,listitem,inputtext[])
{
    new sirketid = PlayerData[playerid][pSirket];

	if(!strcmp(ReturnName(playerid, 0), sirketData[sirketid][sirketSahip], true))
	{
	if(listitem == 0)
    {
    sirketUyeListele(playerid , sirketid);
    }
    if(listitem == 1)
    {
    Dialog_Show(playerid, PozisyonMaas, DIALOG_STYLE_INPUT, "Pozisyon Maaþ Düzenleme - Menü", "*** Bu pozisyonun yeni maaþ deðerini giriniz;", "Gir", "Iptal");
    }
	}
    return 1;
}
Dialog:SirketUyeler(playerid,response,listitem,inputtext[])
{
	if(response)
    {
	new sirketid = PlayerData[playerid][pSirket];
    new yeniceo = strval(inputtext);
    if(!strcmp(ReturnName(yeniceo,0), sirketData[sirketid][sirketGM]))
    {
    format(sirketData[sirketid][sirketGM], 24, "");
    format(sirketData[sirketid][sirketCEO], 24, "%s", ReturnName(yeniceo,0));
    Sirket_Kaydet(sirketid);
    } else {
    format(sirketData[sirketid][sirketCEO], 24, "%s", ReturnName(yeniceo,0));
    Sirket_Kaydet(sirketid);
    }
    }
    if(!response)
    {
    }
    return 1;
}
Dialog:PozisyonUyeler(playerid,response,listitem,inputtext[])
{
	if(response)
    {
    SetPVarInt(playerid, "SecilenPoz", listitem);
    Dialog_Show(playerid, PozisyonUyeler3, DIALOG_STYLE_LIST, "Þirket Yönetim Kurulu - Yönetim", "Pozisyona üye ata.\nPozisyon maaþýný düzenle.", "Seç", "Çýk");
    }
    if(!response)
    {
    }
    return 1;
}
Dialog:PozisyonUyeler2(playerid,response,listitem,inputtext[])
{
	if(response)
    {
    new secilenkisi = strval(inputtext);
    new sirketid = PlayerData[playerid][pSirket];

    new secilenkisirank = PlayerData[secilenkisi][pSirketRank];
    if(secilenkisirank >= 0)
    {
    	format(sirketCalisanlar[sirketid][secilenkisirank], 24, "");
    }

	if(strcmp(sirketCalisanlar[sirketid][GetPVarInt(playerid, "SecilenPoz")], sirketData[sirketid][sirketCEO], true) == 0)
	{
	format(sirketData[sirketid][sirketCEO], 24, "");
    format(sirketCalisanlar[sirketid][GetPVarInt(playerid, "SecilenPoz")], 24, "%s", ReturnName(secilenkisi,0));
    new yenipara = sirketMaaslar[sirketid][GetPVarInt(playerid, "SecilenPoz")];
    PlayerData[secilenkisi][pSirketMaas] = yenipara;
    PlayerData[secilenkisi][pSirketRank] = GetPVarInt(playerid, "SecilenPoz");
    Sirket_Kaydet(sirketid);
    }
    else
    {
    sirketCalisanlar[sirketid][GetPVarInt(playerid, "SecilenPoz")] = ReturnName(secilenkisi,0);
    Sirket_Kaydet(sirketid);
    }
    }
    return 1;
}
Dialog:PozisyonMaas(playerid, response, listitem, inputtext[]) {

    if(response)
    {
    	new maas;

    	if(sscanf(inputtext, "d", maas))
    		return HataMesaji(playerid, "Geçersiz maaþ miktarý girdiniz.");

    	if(maas < 50 || maas > 1000)
    		return HataMesaji(playerid, "Maaþ en az $50, en fazla $100 olabilir.");

    	new sirketid = PlayerData[playerid][pSirket];
		sirketMaaslar[sirketid][GetPVarInt(playerid, "SecilenPoz")] = maas;

		foreach(new i : Player)
		{
			if(PlayerData[i][pSirket] != sirketid)
				continue;

			if(PlayerData[i][pSirketRank] != GetPVarInt(playerid, "SecilenPos"))
				continue;

			PlayerData[i][pSirketMaas] = maas;
		}
    }
    return 1;
}
Dialog:SirketAyril(playerid,response,listitem,inputtext[])
{
    if(response)
    {
        if (PlayerData[playerid][pSirket] == -1) return HataMesaji(playerid, "Herhangi bir þirket üyesi deðilsin.");
        PlayerData[playerid][pSirket] = -1;
        SendClientMessage(playerid,-1,"Þirketten ayrýldýnýz!");
    }
    return 1;
}
Dialog:SirketDaveti(playerid, response, listitem, inputtext[]) {

    if(response)
    {
        new
            targetid = PlayerData[playerid][pSirketOffer],
            sirketid = PlayerData[playerid][pSirketOffered];

        SirketVer(playerid, sirketid);
        PlayerData[playerid][pSirketRank] = 1;

        SunucuMesaji(playerid, "\"%s\" adlý þirkete katýldýn.", Sirket_Ad(targetid));
        SunucuMesaji(targetid, "%s adlý oyuncu \"%s\" þirketine katýldý.", ReturnName(playerid, 0), Sirket_Ad(targetid));
        PlayerData[playerid][pSirket] = PlayerData[targetid][pSirket];

        PlayerData[playerid][pSirketOffer] = INVALID_PLAYER_ID;
        PlayerData[playerid][pSirketOffered] = -1;
    }
    return 1;
}
Dialog:SirketKur(playerid, response, listitem, inputtext[]) {

    if(response)
    {
        if(PlayerData[playerid][pLevel] < SIRKET_KURMA_SEVIYESI || PlayerData[playerid][pCash] < SIRKET_KURMA_PARASI) return HataMesaji(playerid, "Þirket kurma gereksinimlerine uymuyorsunuz.");
        if(isnull(inputtext)) return HataMesaji(playerid, "Geçersiz birlik adý girdiniz.");
        if(strlen(inputtext) < 4) return HataMesaji(playerid, "Þirket Adý 4 karakterden kýsa olamaz.");
        if(strlen(inputtext) > 24) return HataMesaji(playerid, "Þirket adý 24 karakterden uzun olamaz.");
        format(SirketAdi[playerid], 24, "%s",inputtext);
        Dialog_Show(playerid, SirketTipiSec, DIALOG_STYLE_LIST, "{FFFFFF}Þirket Tipini Seçiniz:", "{FFFFFF}Oyun($250.000)\n{FFFFFF}Film($350.000)\n{FFFFFF}Otomotiv($450.000)", "Seç", "Iptal");
    }
    return 1;
}
Dialog:SirketTipiSec(playerid, response, listitem, inputtext[]) {

    if(response)
    {
        if (!strcmp(inputtext, "Oyun($250.000)"))
        {
            if(GetPlayerMoney(playerid) > 249999)
            {

               	new sirketid = Sirket_Olustur(SirketAdi[playerid], listitem+1);
                SetPVarInt(playerid, "KurulanSirketID", sirketid);
                SunucuMesaji(playerid, "'%s' adlý þirket kuruldu, þirket menüsüne eriþim için /sirket komutunu kullanabilirsin.", SirketAdi[playerid]);
                format(sirketData[sirketid][sirketSahip], 24, "%s", ReturnName(playerid, 0));
                ParaVer(playerid, -250000);
                sirketData[sirketid][sirketVergi] = 150000;
                sirketData[sirketid][sirketVergiZaman] = 1296000;
                PlayerData[playerid][pSirket] = sirketid;
                SetTimerEx("SirketYetkiVer", 2000, false, "d", playerid);
            }
            else if(GetPlayerMoney(playerid) < 250000) {
                HataMesaji(playerid, "Yeterli paranýz yok. {2ECC71}($250.000)");
            }
        }
        else {
			  new sirketid = Sirket_Olustur(SirketAdi[playerid], listitem+1);
            SunucuMesaji(playerid, "'%s' adlý þirket kuruldu, þirket menüsüne eriþim için /sirket komutunu kullanabilirsin.", SirketAdi[playerid]);
            ParaVer(playerid, -SIRKET_KURMA_PARASI);
            SetPVarInt(playerid, "KurulanSirketID", sirketid);
            SetTimerEx("SirketYetkiVer", 2000, false, "d", playerid);
        }
    }
    return 1;
}
Dialog:Sirket(playerid, response, listitem, inputtext[])
{
    if(response)
    {
    	new sirketid = PlayerData[playerid][pSirket];
  		if(!strcmp(ReturnName(playerid, 0), sirketData[sirketid][sirketSahip]))
		{
        if(strfind(inputtext, "Yönetim Kurulu", true) != -1)
        {
            new string[256];
            new mtring[256];
            if(strcmp(sirketData[sirketid][sirketCEO], "NULL",  true) == 0)
            format(mtring, sizeof(mtring), "[CEO]\tYok\n");
            else
            format(mtring, sizeof(mtring), "[CEO]\t%s\n", sirketData[sirketid][sirketCEO]);

            if(strcmp(sirketData[sirketid][sirketGM], "NULL",  true) == 0)
            format(string, sizeof(string), "[Genel Müdür]\tYok\n");
            else
            format(string, sizeof(string), "[Genel Müdür]\t%s\n", sirketData[sirketid][sirketGM]);

            format(string, sizeof(string), "Pozisyon\tPozisyondaki kiþi\n%s%s", mtring, string);
           Dialog_Show(playerid, YonetimKurulu, DIALOG_STYLE_TABLIST_HEADERS, "Yönetim Kurulu", string, "Seç", "Iptal");
        }
    	}
        if(!strcmp(ReturnName(playerid, 0), sirketData[sirketid][sirketSahip]) && strfind(inputtext, "Þirket Kasasý", true) != -1)
        {
        	Dialog_Show(playerid, SirketKasa, DIALOG_STYLE_LIST, "Þirket Kasasý", "Kasaya para koy\nKasadan para çek ($%d)\n", "Seç", "Kapat", sirketData[sirketid][sirketKasa]);
        }

  		if(!strcmp(ReturnName(playerid, 0), sirketData[sirketid][sirketSahip]))
		{
        if(strfind(inputtext, "Þirketten Ayrýl", true) != -1)
        {
            Dialog_Show(playerid, SirketAyril, DIALOG_STYLE_MSGBOX, "{72C425}Þirketten Ayrýlma", "Þirketten ayrýlmak istiyor musun?", "Evet", "Hayýr");
        }
        }
  		if(!strcmp(ReturnName(playerid, 0), sirketData[sirketid][sirketSahip]) || !strcmp(ReturnName(playerid, 0), sirketData[sirketid][sirketCEO]) || !strcmp(ReturnName(playerid, 0), sirketData[sirketid][sirketGM]))
		{
        if(strfind(inputtext, "Çalýþanlar", true) != -1)
        {
			sirketPozisyonListele(playerid,sirketid);

        }
    	}
        if(strfind(inputtext, "Çalýþan Al", true) != -1)
        {
                SunucuMesaji(playerid, "Davet modu aktif, TAB'dan (skor tablosu) þirketine davet etmek istediðin oyuncunun üstüne týkla!");
                SetPVarInt(playerid, "SDM", 1);
        }
    }
    return 1;
}

Dialog:SirketKasa(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new sirketid = PlayerData[playerid][pSirket];

		if(!strcmp(ReturnName(playerid, 0), sirketData[sirketid][sirketSahip]))
		{
			if(strfind(inputtext, "Kasaya para koy", true) != -1)
				Dialog_Show(playerid, SirketKasaKoy, DIALOG_STYLE_INPUT, "Þirket Kasasý", "Þirket kasasýna koymak istediðiniz miktarý giriniz.", "Ekle", "Kapat");

			if(strfind(inputtext, "Kasadan para çek", true) != -1)
				Dialog_Show(playerid, SirketKasaCek, DIALOG_STYLE_INPUT, "Þirket Kasasý", "Þirket kasasýndan çekmek istediðiniz miktarý giriniz.", "Çek", "Kapat");
		}
	}

	return 1;
}

Dialog:SirketKasaKoy(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new sirketid = PlayerData[playerid][pSirket];

		if(!strcmp(ReturnName(playerid, 0), sirketData[sirketid][sirketSahip]))
		{
			new deger;

			if(sscanf(inputtext, "d", deger))
				return Dialog_Show(playerid, SirketKasaKoy, DIALOG_STYLE_INPUT, "Þirket Kasasý", "Þirket kasasýna koymak istediðiniz miktarý giriniz.", "Ekle", "Kapat");

			if(deger < 1)
				return Dialog_Show(playerid, SirketKasaKoy, DIALOG_STYLE_INPUT, "Þirket Kasasý", "Þirket kasasýna koymak istediðiniz miktarý giriniz.", "Ekle", "Kapat");

			if(deger > PlayerData[playerid][pCash])
				return Dialog_Show(playerid, SirketKasaKoy, DIALOG_STYLE_INPUT, "Þirket Kasasý", "Þirket kasasýna koymak istediðiniz miktarý giriniz.", "Ekle", "Kapat"), HataMesajGonder(playerid, "Üzerinizde yeterli para yok.");

			sirketData[sirketid][sirketKasa] += deger;
			ParaVer(playerid, -deger);

			Sirket_Kaydet(sirketid);

			SunucuMesaji(playerid, "Þirket kasasýna $%d koydunuz.", deger);
		}
	}

	return 1;
}

Dialog:SirketKasaCek(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new sirketid = PlayerData[playerid][pSirket];

		if(!strcmp(ReturnName(playerid, 0), sirketData[sirketid][sirketSahip]))
		{
			new deger;

			if(sscanf(inputtext, "d", deger))
				return Dialog_Show(playerid, SirketKasaCek, DIALOG_STYLE_INPUT, "Þirket Kasasý", "Þirket kasasýndan çekmek istediðiniz miktarý giriniz.", "Çek", "Kapat");

			if(deger < 1)
				return Dialog_Show(playerid, SirketKasaCek, DIALOG_STYLE_INPUT, "Þirket Kasasý", "Þirket kasasýndan çekmek istediðiniz miktarý giriniz.", "Çek", "Kapat");

			if(deger > sirketData[sirketid][sirketKasa])
				return Dialog_Show(playerid, SirketKasaCek, DIALOG_STYLE_INPUT, "Þirket Kasasý", "Þirket kasasýndan çekmek istediðiniz miktarý giriniz.", "Çek", "Kapat"), HataMesajGonder(playerid, "Þirket kasasýnda yeterli para yok.");

			sirketData[sirketid][sirketKasa] -= deger;
			ParaVer(playerid, deger);

			Sirket_Kaydet(sirketid);

			SunucuMesaji(playerid, "Þirket kasasýndan $%d çektiniz.", deger);
		}
	}

	return 1;
}
Dialog:DiscordBilgileri(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		if(strfind(inputtext, "Biriken Exp Miktarýnýz", true) != -1)
		{
			new discord_exp = GetPVarInt(playerid, "discordExp");

			if(discord_exp % 4 != 0)
				return HataMesajGonder(playerid, "Henüz discord explerinizi alamazsýnýz. (almak için 4 ve katý sayýlar olmasý gerekiyor.)");

			new exp_miktar = discord_exp / 4;

			PlayerData[playerid][pEXP] += exp_miktar;
			SunucuMesaji(playerid, "%d discord exp karþýlýðýnda karakterinize %d exp verildi.", discord_exp, exp_miktar);

	        if (PlayerData[playerid][pEXP] >= PlayerData[playerid][pLevel]*5)
			{
			    new kalanexp = 0;

			    if (PlayerData[playerid][pEXP] > PlayerData[playerid][pLevel]*5)
			    {
			        kalanexp = PlayerData[playerid][pEXP] - PlayerData[playerid][pLevel]*5;
			    }

			    PlayerData[playerid][pEXP] = kalanexp;
				PlayerData[playerid][pLevel]++;

				SunucuMesaji(playerid, "Discord expleriniz sayesinde seviye atladýnýz.");
			}

			new query[54 + 11 + 1];

			mysql_format(g_SQL, query, sizeof(query), "UPDATE oyuncular SET discord_exp = '0' WHERE ID = '%d'", PlayerData[playerid][pID]);
			mysql_query(g_SQL, query);
		}

		else if(strfind(inputtext, "Hesapla Ýliþkimi Kes", true) != -1)
		{
			new query[53 + 11 + 1];

			mysql_format(g_SQL, query, sizeof(query), "UPDATE oyuncular SET discord_id = '0' WHERE ID = '%d'", PlayerData[playerid][pID]);
			mysql_tquery(g_SQL, query);

			SunucuMesaji(playerid, "Baðlanmýþ discord hesabýyla iliþiðiniz kesilmiþtir. EXP miktarýnýz saklý kalacaktýr.");
		}

		else callcmd::discord(playerid);
	}

	return 1;
}
