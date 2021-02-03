CMD:o(playerid, params[])
	return callcmd::ooc(playerid, params);

CMD:duyuru(playerid, params[])
	return callcmd::ooc(playerid, params);

CMD:f(playerid, params[])
	return callcmd::fac(playerid, params);

CMD:s(playerid, params[])
	return callcmd::shout(playerid, params);

CMD:vakit(playerid, params[])
	return callcmd::zaman(playerid, params);

CMD:tarih(playerid, params[])
	return callcmd::zaman(playerid, params);

CMD:saat(playerid, params[])
	return callcmd::zaman(playerid, params);

CMD:m(playerid, params[])
	return callcmd::megafon(playerid, params);

CMD:d(playerid, params[])
	return callcmd::dept(playerid, params);

CMD:clearchat(playerid, params[])
	return callcmd::chattemizle(playerid, params);

CMD:l(playerid, params[])
	return callcmd::low(playerid, params);

CMD:yap(playerid, params[])
return callcmd::do(playerid, params);

CMD:rapor(playerid, params[])
	return callcmd::destek(playerid, params);

CMD:sorusor(playerid, params[])
	return callcmd::destek(playerid, params);

CMD:w(playerid, params[])
	return callcmd::whisper(playerid, params);

CMD:me(playerid, params[])
{
    if (PlayerData[playerid][pCCTV] != -1) return HataMesajGonder(playerid, "Þu an bu komutu kullanamazsýn.");
	if (GetPVarInt(playerid, "Logged") == 0) return HataMesajGonder(playerid, "Þu an komut kullanamazsýn.");
	if (isnull(params))
	    return KullanimMesajGonder(playerid, "/me [emote]");

	new action[256];
    strdel(action, 0, 256);
	strcat(action, params);

    if (strfind(action, "\"", true, 1) != -1)
	{
			new ilkdenden = strfind(action, "\"", true, 1);
			new sonrakidenden = strfind(action, "\"", true, ilkdenden+1);
			strins(action, "{FFFFFF}", ilkdenden);
			strins(action, "{C2A2DA}", sonrakidenden+9);
	}

	Log_Write("logs/emote.log", "%s %s",ReturnName(playerid, 0), trcar(action));

	if (strlen(action) > 120)
	{
 	    SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "* %s %.120s", ReturnName(playerid, 0), action); // ciyan
	    SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "...%s", action[120]);
	}
	else
	{
	    SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "* %s %s", ReturnName(playerid, 0), action);
	}
	return 1;
}
CMD:do(playerid, params[])
{
    if (PlayerData[playerid][pCCTV] != -1) return HataMesajGonder(playerid, "Þu an bu komutu kullanamazsýn.");
    if (GetPVarInt(playerid, "Logged") == 0) return HataMesajGonder(playerid, "Þu an komut kullanamazsýn.");
	if (isnull(params))
	    return KullanimMesajGonder(playerid, "/do [durum]");
    Log_Write("logs/emote.log", "%s (( %s ))",trcar(params),ReturnName(playerid, 0));
	if (strlen(params) > 120) {
	    SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "* %.120s", params);
	    SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "...%s (( %s ))", params[120], ReturnName(playerid, 0));
	}
	else {
	    SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "* %s (( %s ))", params, ReturnName(playerid, 0));
	}
	return 1;
}

CMD:dene(playerid, params[])
{
    if (PlayerData[playerid][pCCTV] != -1) return HataMesajGonder(playerid, "Þu an bu komutu kullanamazsýn.");
	new gelensayi = RandomEx(1, 3), str[24];

	if (gelensayi == 1) format(str, sizeof(str), "{00FF00}Baþarýlý");
	else if (gelensayi == 2) format(str, sizeof(str), "{FF0000} Baþarýsýz");
	SendNearbyMessage(playerid, 30.0, 0xFFFFFFFF, "* %s. (( %s ))", str, ReturnName(playerid, 0));
	return 1;
}

CMD:ame(playerid, params[])
{
    static
        string[128];
    if (PlayerData[playerid][pCCTV] != -1) return HataMesajGonder(playerid, "Þu an bu komutu kullanamazsýn.");
    if (isnull(params))
        return KullanimMesajGonder(playerid, "/ame [hareket]");

    format(string, sizeof(string), "* %s %s", ReturnName(playerid, 0), params);
    SetPlayerChatBubble(playerid, string, COLOR_CYAN, 30.0, 10000);

    SendClientMessageEx(playerid, COLOR_CYAN, "* %s %s", ReturnName(playerid, 0), params);
    return 1;
}

CMD:ado(playerid, params[])
{
    static
        string[128];
    if (PlayerData[playerid][pCCTV] != -1) return HataMesajGonder(playerid, "Þu an bu komutu kullanamazsýn.");
    if (isnull(params))
        return KullanimMesajGonder(playerid, "/ado [durum]");

    format(string, sizeof(string), "* %s (( %s ))", params, ReturnName(playerid, 0));
    SetPlayerChatBubble(playerid, string, COLOR_GREEN, 30.0, 10000);

    SendClientMessageEx(playerid, COLOR_GREEN, "* %s (( %s ))", params, ReturnName(playerid, 0));
    return 1;
}

CMD:shout(playerid, params[])
{
    if (GetPVarInt(playerid, "Logged") == 0) return HataMesajGonder(playerid, "Þu an komut kullanamazsýn.");
    if (PlayerData[playerid][pCCTV] != -1) return HataMesajGonder(playerid, "Þu an bu komutu kullanamazsýn.");
	if (isnull(params))
	    return KullanimMesajGonder(playerid, "(/s)hout <mesaj>");
    Log_Write("logs/chat.log", "%s (baðýrýr): %s",ReturnName(playerid, 0), trcar(params));
	if (strlen(params) > 64) {
	    SendNearbyMessage(playerid, 30.0, COLOR_WHITE, "%s (baðýrýr): %.64s", ReturnName(playerid, 0), params);
	    SendNearbyMessage(playerid, 30.0, COLOR_WHITE, "...%s", params[64]);

	}
	else {
	    SendNearbyMessage(playerid, 30.0, COLOR_WHITE, "%s (baðýrýr): %s", ReturnName(playerid, 0), params);
	}

	static id = -1;
	if ((id = House_Nearest(playerid)) != -1)
 	{
		foreach (new i:Player) if (House_Inside(i) == id)
		{
		    SendClientMessageEx(i, -1, "{FFFFFF}(dýþardan ses) %s (baðýrýr): %s!", ReturnName(playerid, 0), params);
		}
	}
	return 1;
}
CMD:low(playerid, params[])
{

    if (GetPVarInt(playerid, "Logged") == 0) return HataMesajGonder(playerid, "Þu an komut kullanamazsýn.");
    if (PlayerData[playerid][pCCTV] != -1) return HataMesajGonder(playerid, "Þu an bu komutu kullanamazsýn.");
	if (isnull(params))
	    return KullanimMesajGonder(playerid, "(/l)ow <mesaj>");
     Log_Write("logs/chat.log", "%s Sessizce: %s",ReturnName(playerid, 0), trcar(params));
	if (strlen(params) > 64) {
	    SendNearbyMessage(playerid, 5.0, COLOR_WHITE, "%s (sessizce): %.64s", ReturnName(playerid, 0), params);
	    SendNearbyMessage(playerid, 5.0, COLOR_WHITE, "...%s", params[64]);
	}
	else {
	    SendNearbyMessage(playerid, 5.0, COLOR_WHITE, "%s (sessizce): %s", ReturnName(playerid, 0), params);
	}
	return 1;
}

CMD:b(playerid, params[])
{
    if (GetPVarInt(playerid, "Logged") == 0) return HataMesajGonder(playerid, "Þu an komut kullanamazsýn.");
    if (PlayerData[playerid][pCCTV] != -1) return HataMesajGonder(playerid, "Þu an bu komutu kullanamazsýn.");

	if (isnull(params))
	    return KullanimMesajGonder(playerid, "/b <mesaj>");

	Log_Write("logs/chat.log", "OOC: %s: %s",ReturnName(playerid, 0), trcar(params));
	if (strlen(params) > 64)
	{
		if (PlayerData[playerid][pAdminDuty] == 1 && PlayerData[playerid][pAdmin] >= 1)
		{
		    SendNearbyMessageEx(playerid, 20.0, 0x80808080, "{F20000} %s %s{F3F3F3}: {F3F3F3}(( %.64s", GetAdminRank(playerid), PlayerData[playerid][pAdminName], params);
		    SendNearbyMessageEx(playerid, 20.0, 0x80808080, "...%s {F3F3F3}))", params[64]);
	    }
/*        else if (PlayerData[playerid][pHelperDuty] == 1 && PlayerData[playerid][pHelper] >= 1)
	    {
	        SendNearbyMessageEx(playerid, 20.0, 0x80808080, "{e4b400}%s: {FFFFFF}(( %.64s", PlayerData[playerid][pAdminName], params);
		    SendNearbyMessageEx(playerid, 20.0, 0x80808080, "...%s ))", params[64]);
	    }*/
	    else
		{
		    if (PlayerData[playerid][pMaske] == false)
		    {
			    SendNearbyMessageEx(playerid, 20.0, 0x80808080, "{808080}(%d) %s: (( %.64s", playerid, ReturnName(playerid, 0), params);
			    SendNearbyMessageEx(playerid, 20.0, 0x80808080, "...%s ))", params[64]);
		    }
		    else
		    {
		        SendNearbyMessageEx(playerid, 20.0, 0x80808080, "{808080}(%d) %s: (( %.64s", playerid, ReturnName(playerid, 0), params);
			    SendNearbyMessageEx(playerid, 20.0, 0x80808080, "...%s ))", params[64]);
		    }
		}
	}
	else
	{
	    if (PlayerData[playerid][pAdminDuty] == 1 && PlayerData[playerid][pAdmin] >= 1)
	    {
	    	SendNearbyMessageEx(playerid, 20.0, 0x80808080, "{F20000} %s %s{F3F3F3}: {F3F3F3}(( %s ))", GetAdminRank(playerid), PlayerData[playerid][pAdminName], params);
	    }
/*	    else if (PlayerData[playerid][pHelperDuty] == 1 && PlayerData[playerid][pHelper] >= 1)
	    {
	    	SendNearbyMessageEx(playerid, 20.0, 0x80808080, "{e4b400}%s: {FFFFFF}(( %s ))", PlayerData[playerid][pAdminName], params);
	    }*/
	    else
	    {
            if (PlayerData[playerid][pMaske] == false) SendNearbyMessageEx(playerid, 20.0, 0x80808080, "(%d) %s: (( %s ))", playerid, ReturnName(playerid, 0), params);
            else SendNearbyMessageEx(playerid, 20.0, 0x80808080, "(%d) %s: (( %s ))", playerid, ReturnName(playerid, 0), params);
	    }
	}
	return 1;
}
CMD:whisper(playerid, params[])
{
    if (GetPVarInt(playerid, "Logged") == 0) return HataMesajGonder(playerid, "Þu an komut kullanamazsýn.");
    if (PlayerData[playerid][pCCTV] != -1) return HataMesajGonder(playerid, "Þu an bu komutu kullanamazsýn.");
	new userid, text[128];

    if (sscanf(params, "us[128]", userid, text))
	    return KullanimMesajGonder(playerid, "/(w)hisper [ID/Isim] [Mesaj]");

	if (!OyundaDegil(userid) || !IsPlayerNearPlayer(playerid, userid, 5.0))
	    return HataMesajGonder(playerid, "Oyuncu oyunda deðil veya oyuncuya yakýn deðilsin.");

	if (userid == playerid)
		return HataMesajGonder(playerid, "Kendine fýsýldayamazsýn.");

	if (GetPlayerState(userid) == PLAYER_STATE_SPECTATING)
	    return HataMesajGonder(playerid, "Oyuncu oyunda deðil veya oyuncuya yakýn deðilsin.");

    if (strlen(text) > 64) {
        if (PlayerData[playerid][pMaske] == false)
        {
		    SendClientMessageEx(userid, 0xFFC10000, "** %s fýsýldadý (%d): %.64s", ReturnName(playerid, 0), playerid, text);
		    SendClientMessageEx(userid, 0xFFC10000, "...%s **", text[64]);
			if (PlayerData[userid][pMaske] == false)
			{
			    SendClientMessageEx(playerid, 0xFFC10000, "** %s'a fýsýldadýn (%d): %.64s", ReturnName(userid, 0), userid, text);
			    SendClientMessageEx(playerid, 0xFFC10000, "...%s **", text[64]);
		    }
		    else
		    {
		        SendClientMessageEx(playerid, 0xFFC10000, "** %s'a fýsýldadýn: %.64s", ReturnName(userid, 0), text);
			    SendClientMessageEx(playerid, 0xFFC10000, "...%s **", text[64]);
		    }
	    }
	    else
	    {
            SendClientMessageEx(userid, 0xFFC10000, "** %s fýsýldadý: %.64s", ReturnName(playerid, 0), text);
		    SendClientMessageEx(userid, 0xFFC10000, "...%s **", text[64]);

		    if (PlayerData[userid][pMaske] == false)
			{
			    SendClientMessageEx(playerid, 0xFFC10000, "** %s'a fýsýldadýn (%d): %.64s", ReturnName(userid, 0), userid, text);
			    SendClientMessageEx(playerid, 0xFFC10000, "...%s **", text[64]);
		    }
		    else
		    {
		        SendClientMessageEx(playerid, 0xFFC10000, "** %s'a fýsýldadýn: %.64s", ReturnName(userid, 0), text);
			    SendClientMessageEx(playerid, 0xFFC10000, "...%s **", text[64]);
		    }
	    }
	}
	else {
	    if (PlayerData[playerid][pMaske] == false)
	    {
	    	SendClientMessageEx(userid, 0xFFC10000, "** %s fýsýldadý (%d): %s **", ReturnName(playerid, 0), playerid, text);
	    	SendClientMessageEx(playerid, 0xFFC10000, "** %s'a fýsýldadýn (%d): %s **", ReturnName(userid, 0), userid, text);
	    }
	    else
	    {
	        SendClientMessageEx(userid, 0xFFC10000, "** %s fýsýldadý: %s **", ReturnName(playerid, 0), text);
	    	SendClientMessageEx(playerid, 0xFFC10000, "** %s'a fýsýldadýn: %s **", ReturnName(userid, 0), text);
	    }
	}
	SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s, %s'ýn kulaðýna yaklaþýr ve fýsýldar.", ReturnName(playerid, 0), ReturnName(userid, 0));
	return 1;
}
CMD:pm(playerid, params[])
{
	static
	    userid,
	    text[128];

	if (sscanf(params, "us[128]", userid, text))
	    return BilgiMesajGonder(playerid, "/pm [ID/Isim] [mesaj]");

	if (PlayerData[playerid][pAyarlar][1] == 1)
	    return HataMesajGonder(playerid, "PM alýmlarýný açmalýsýnýz. (/ayarlar)");

	if (!OyundaDegil(userid))
	    return HataMesajGonder(playerid, "Oyuncu oyunda deðil !");

	if (userid == playerid)
	    return HataMesajGonder(playerid, "Kendine özel mesaj yollayamazsýn.");

    if (PlayerData[userid][pAyarlar][1] == 1)
	    return HataMesajGonder(playerid, "Bu kiþi özel mesaj alýmlarýný kapatmýþ.");

	PlayerData[userid][SonMesajGonderen] = playerid;
	if (IsPlayerPause(userid)) BilgiMesajGonder(playerid, "Bu oyuncu AFK, mesajýnýza yanýt veremeyebilir.");
//	GameTextForPlayer(userid, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~y~Yeni mesaj!", 3000, 3);
	PlayerPlaySound(userid, 1085, 0.0, 0.0, 0.0);
	SendClientMessageEx(userid, 0xBF00FFFF, "[PM] «« %s (%d): %s", ReturnName(playerid, 0), playerid, text);
	SendClientMessageEx(playerid, 0x66038888, "[PM] »» %s (%d): %s", ReturnName(userid, 0), userid, text);

    PMMessage(0x3EAFC1AA, "[PM] %s (%d) >> %s (%d): %s", ReturnName(playerid, 0), playerid, ReturnName(userid, 0), userid, text);
	Log_Write("logs/pm-log.txt", "[%s] %s >>> %s Mesaj: %s",ReturnDate(),ReturnName(playerid),ReturnName(userid),trcar(text));
	return 1;
}
CMD:basvuru(playerid, params[])
{
if (!IsPlayerInRangeOfPoint(playerid, 3.0, 780.6000,-5.8963,1028.7196)) return HataMesajGonder(playerid, "Baþvuru yapma noktasýnda deðilsiniz.");
	Dialog_Show(playerid, Basvuru2, DIALOG_STYLE_INPUT, "{42f445}Baþvuru Onayý", "Sunucumuzda oynamak için baþvuru vurmanýz gerek, baþvurunuzu onaylýyormusunuz?", "Gönder", "Kapat");
return 1;
}
CMD:mic(playerid,params[])
{
	return callcmd::mikrofon(playerid,params);
}

CMD:mikrofon(playerid, params[])
{
	new id = Business_Inside(playerid);
    if (id == -1 || Isyeri[id][isyeriSahip] == PlayerData[playerid][pID]) return HataMesajGonder(playerid, "Ýþyerinde deðil veya iþyerinin sahibi deðilsiniz.");

	if (!strlen(params) || isnull(params))
	    return BilgiMesajGonder(playerid,"/mikrofon [Mesaj]");

	if (strlen(params) > 75)
		return HataMesajGonder(playerid, "Mesaj 75 karakter uzunluðunu geçemez.");

	new str[250];

	if (IsPlayerInAnyVehicle(playerid))
    {
	    HataMesajGonder(playerid, "Þu anda bu komutu kullanamazsýnýz.");
    }
    else
    {
        format(str, sizeof(str), "** [MIKROFON] %s: %s ***", ReturnName(playerid, 0), params);
	    ProxDetector(15.0, playerid, str, COLOR_YELLOW);
    }
    return 1;
}

CMD:motor(playerid)
{
    new vehicleid = GetPlayerVehicleID(playerid);
    new id = Car_GetID(vehicleid);

    if (!IsEngineVehicle(vehicleid)) return HataMesajGonder(playerid, "Bu komutu sadece araçta kullanabilirsin.");
   	if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return HataMesajGonder(playerid, "Sürücü deðilsin.");
   	if (AracInfo[id][aracBenzin] < 0.1) return HataMesajGonder(playerid, "Bu aracýn yakýtý bitmiþ.");
   	if (AracHasar(vehicleid) <= 300) return HataMesajGonder(playerid, "Bu araca çok fazla hasar verilmiþ, motor çalýþmýyor.");
   	if (UsingPumpID[playerid] != -1) return HataMesajGonder(playerid, "Þu an motoru çalýþtýramazsýnýz!");

   	if(AracInfo[id][aracTip] == 6 && PlayerData[playerid][pEhliyetSinavinda] == 0) return HataMesajGonder(playerid, "Bu aracý kullanamazsýnýz. (Þu anda ehliyet sýnavýnda deðilsiniz.)");
   	if(AracInfo[id][aracTip] == 6 && PlayerData[playerid][pEhliyetSinavinda] == 1 && GetVehicleModel(vehicleid) != 462) return HataMesajGonder(playerid, "Bu aracý kullanamazsýnýz. (Motor ehliyeti için Faggio'ya binmelisiniz.)");
   	if(AracInfo[id][aracTip] == 6 && PlayerData[playerid][pEhliyetSinavinda] == 2 && GetVehicleModel(vehicleid) != 405) return HataMesajGonder(playerid, "Bu aracý kullanamazsýnýz. (Sürücü ehliyeti için Sentinel'e binmelisiniz.)");

   	if (Car_IsOwner(playerid, id) || Car_Birlik(playerid, id) ||  AracInfo[id][aracTip] == 2 || AracInfo[id][aracKiralayan] == PlayerData[playerid][pID] || Arac_AnahtarVar(playerid, id) || (PlayerData[playerid][pFaction] != -1 && GetFactionType(playerid) != BIRLIK_CETE && GetFactionType(playerid) != BIRLIK_MAFYA && GetFactionType(playerid) != BIRLIK_LEGAL && AracInfo[id][aracFactionType] == GetFactionType(playerid)) || (AracInfo[id][aracTip] == 5 && PlayerData[playerid][pVip] > 0) || (AracInfo[id][aracTip] == 6 && PlayerData[playerid][pEhliyetSinavinda] != 0))
   	{
   	    switch (GetEngineStatus(vehicleid))
   	    {
   	        case false:
   	        {
   	            SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s anahtarý aracýn kontaðýna sokar ve çevirerek çalýþmasýný bekler.", ReturnName(playerid, 0));
   				infoYukleniyor(playerid);
				GameTextForPlayer(playerid, "~g~Motor Acildi", 3000, 4);

				SetTimerEx("MotorCalistir", floatround(AracInfo[id][aracKM]*3), false, "ud", playerid, vehicleid);

   	            if(AracInfo[id][aracTip] == 6)
   	            {
   	            	if(EhliyetAracCP[vehicleid] == 0)
   	            	{
   	            		callcmd::cpsifirla(playerid);

						AracCP[vehicleid] = 0;
						EhliyetAracCP[vehicleid] = 1;

						SetPlayerCheckpoint(playerid, EhliyetCP[0][0], EhliyetCP[0][1], EhliyetCP[0][2], 5.0);
						BilgiMesajGonder(playerid, "Sürüþ testi baþladý, checkpointleri takip edin.");
						BilgiMesajGonder(playerid, "Hýz limiti 90 olarak belirlenmiþtir, sýnýrý aþmayýn!");
						SetPlayerCheckpoint(playerid, EhliyetCP[0][0], EhliyetCP[0][1], EhliyetCP[0][2], 5.0);
   	            	}
   	            }
   	        }
   	        case true:
   	        {
            	SetEngineStatus(vehicleid, false);
            	SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s aracýn anahtarýný çevirerek motoru kapatýr.", ReturnName(playerid, 0));
				PlayerData[playerid][pLegalMotor] = 1;
                SetTimerEx("LegalEngine", 6500, false, "d", playerid);
				GameTextForPlayer(playerid, "~r~Motor Kapatildi", 3000, 4);
   				infoYukleniyor(playerid);
			}
   	    }
   	}
   	else
   	{
   	    HataMesajGonder(playerid, "Bu aracýn anahtarý sizde bulunmuyor.");
   	}
	return 1;
}
CMD:farlar(playerid)
{


    if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
	    return HataMesajGonder(playerid, "Sürücü deðilsin.");


	new vehicleid = GetPlayerVehicleID(playerid);

	if (!IsEngineVehicle(vehicleid))
		return HataMesajGonder(playerid, "Bu aracýn farlarý yok.");

	switch (GetLightStatus(vehicleid))
	{
	    case false:
	    {
	        SetLightStatus(vehicleid, true);
			infoYukleniyor(playerid);
	        MesajGonder(playerid, "Aracýn farlarý açýldý.");
			GameTextForPlayer(playerid, "~g~Farlar Acildi", 3000, 4);
		}
		case true:
		{
		    SetLightStatus(vehicleid, false);
			infoYukleniyor(playerid);
			GameTextForPlayer(playerid, "~r~Farlar Kapatildi", 3000, 4);
		    MesajGonder(playerid, "Aracýn farlarý kapatýldý.");
		}
	}
	return 1;
}

CMD:hayvan(playerid, params[])
{
    if (PlayerData[playerid][pKelepce] > 0 || PlayerData[playerid][pHapisSure] > 0 || PlayerData[playerid][pSoklandi] > 0 || PlayerData[playerid][pYereYatirildi] > 0 || PlayerData[playerid][pBaygin] == 1 || PetKontrol[playerid] != -1 || pbOda[playerid] != -1 || GetPVarInt(playerid, "IpBaglandi") == 1)
 	return HataMesajGonder(playerid, "Þu an bu komutu kullanamazsýnýz.");
	new id = ArsaNearest(playerid);
	if (id == -1) return HataMesajGonder(playerid, "Herhangi bir çiftliðe yakýn deðilsiniz.");
	if (ArsaBilgi[id][arsaSahip] != PlayerData[playerid][pID]) return HataMesajGonder(playerid, "Çiftliðin sahibi siz deðilsiniz.");
	new ayar[10], str[10];
	if (sscanf(params, "s[10]S()[10]", ayar, str)) return BilgiMesajGonder(playerid, "/hayvan [koy/kes]");
	if (!strcmp(ayar, "koy", true))
	{
	    new tohumid;
	    if (sscanf(str, "d", tohumid)) return BilgiMesajGonder(playerid, "/hayvan [koy] [1 - Domuz 2 - Ayý 3 - Kurt]");
	    if (tohumid < 1 || tohumid > 3) return HataMesajGonder(playerid, "Geçersiz hayvan tipi. [1 - Domuz 2 - Ayý 3 - Kurt]");
		if (PlayerData[playerid][pTohumlar][tohumid-1] <= 0) return HataMesajGonder(playerid, "Tohumunuz yok.");
		if (TohumKontrol(playerid) != -1) return HataMesajGonder(playerid, "Baþka bir hayvana yakýnsýnýz.");
		if (Arsa_TohumSayisi(id) >= ArsaBilgi[id][arsaMaxTohum]) return HataMesajGonder(playerid, "Bu arsaya daha fazla hayvan koyamazsýnýz.");
		new bool:tohumekildi;
		for (new i; i<MAX_TOHUM; i++) if (Tohumlar[i][tohumArsa] == -1)
		{
		    Tohumlar[i][tohumArsa] = id;
		    Tohumlar[i][tohumTip] = tohumid;
		    Tohumlar[i][tohumBuyume] = 0;
		    Tohumlar[i][tohumSayi] = 0;
		    GetPlayerPos(playerid, Tohumlar[i][tohumPos][0], Tohumlar[i][tohumPos][1], Tohumlar[i][tohumPos][2]);
		    TohumUpdate(i);
		    tohumekildi = true;
		    break;
		}
		if (tohumekildi == false) return HataMesajGonder(playerid, "Hayvan koyma baþarýsýz.");
		PlayerData[playerid][pTohumlar][tohumid-1]--;
		MesajGonder(playerid, "Hayvaný koydunuz, 1 saat sonra kesebilirsiniz.");
	}
	if (!strcmp(ayar, "kes", true))
	{
	    new arsaid = ArsaNearest(playerid);
		if (arsaid == -1) return HataMesajGonder(playerid, "Herhangi bir çiftliðe yakýn deðilsiniz.");
		if (ArsaBilgi[arsaid][arsaSahip] != PlayerData[playerid][pID]) return HataMesajGonder(playerid, "Bu çiftliðin sahibi deðilsiniz.");
		new tid = TohumKontrol(playerid);
	    if (tid == -1) return HataMesajGonder(playerid, "Herhangi bir hayvana yakýn deðilsiniz.");
	    if (Tohumlar[tid][tohumBuyume] < 60) return HataMesajGonder(playerid, "Yeterince büyümemiþ.");
	    if (TohumTutuyor[playerid] != -1) return HataMesajGonder(playerid, "Elinizde et ve kürk dolu kasa bulunduðu için hayvan kesemezsiniz.");
	    new vehicleid = PlayerData[playerid][pLastCar];
		if (GetVehicleModel(vehicleid) != 422) return HataMesajGonder(playerid, "Son bindiðiniz araç Bobcat olmalýdýr.");
		new Float:x, Float:y, Float:z;
		GetVehicleBoot(vehicleid, x, y, z);
		if (GetPlayerDistanceFromPoint(playerid, x, y, z) >= 20.0) return HataMesajGonder(playerid, "Aracýnýza çok uzaksýnýz.");
	    TohumTutuyor[playerid] = Tohumlar[tid][tohumTip]-1;
	    TohumSayisi[playerid] = Tohumlar[tid][tohumSayi];
	    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
		SetPlayerAttachedObject(playerid, 4, 19636, 1, 0.058999, 0.428999, 0.000000, 92.900001, 88.399978, 1.699999, 1.000000, 1.000000, 1.000000);
		DestroyDynamicObject(Tohumlar[tid][tohumObject]);
		DestroyDynamic3DTextLabel(Tohumlar[tid][tohumLabel]);
		TohumCP[playerid] = CreateDynamicCP(x, y, z, 2.0, .playerid = playerid);
		Tohumlar[tid][tohumArsa] = -1;
	    Tohumlar[tid][tohumTip] = 0;
	    Tohumlar[tid][tohumBuyume] = 0;
	    Tohumlar[tid][tohumPos][0] = Tohumlar[tid][tohumPos][1] = Tohumlar[tid][tohumPos][2] = 0.0;

	}
	return 1;
}

CMD:gasp(playerid, params[])
{
	new userid;
	if (sscanf(params, "u", userid)) return KullanimMesajGonder(playerid, "/gasp [ID/Isim]");
	if (userid == playerid) return HataMesajGonder(playerid, "Kendinizi gasp edemezsin!");
	if (!IsPlayerNearPlayer(playerid, userid, 5.0)) return HataMesajGonder(playerid, "Kiþiye yakýn deðilsiniz.");
	if (PlayerData[playerid][pLevel] < 10) return HataMesajGonder(playerid, "10 level ve üzeri olman gerekiyor.");
    if (PlayerData[playerid][pHediye] != 1) return HataMesajGonder(playerid, "Gasp etmek için %d PayDay daha almalýsýnýz.", 5-PlayerData[playerid][pHediyeSaat]);
	new gereklipara;
    gereklipara = 5000;
    if (PlayerData[userid][pCash] < gereklipara) return HataMesajGonder(playerid, "Bu oyuncuda minimum gasp ücreti bulunmuyor. (%s) ", FormatNumber(gereklipara));
    if (PlayerData[userid][pLevel] < 3) return HataMesajGonder(playerid, "Bu oyuncu 3 Level altýnda gasp edilemez.");
	benigaspeden[userid] = playerid;
	HataMesajGonder(playerid, "%s adlý oyuncuya gasp isteði gönderildi.", ReturnName(userid));
	Dialog_Show(userid, Gasp, DIALOG_STYLE_MSGBOX, "Regular Rolepaly - Gasp Sistemi", "{808080} %s {FFFFFF}sizi {FFFFFF}gasp etmek istiyor kabul ediyor musunuz?\n Evet derseniz {2ECC71}5000${FFFFFF} karþý tarafa gider, lütfen role uyum saðlayýn\n{808080}(Eðer rolsüz bir þekilde gasp etmeye çalýþýlýyorsa Reddetme hakkýnýz var).", "Evet", "Hayýr", ReturnName(playerid, 0));
	return 1;
}
CMD:kaput(playerid)
{
	if (IsPlayerInAnyVehicle(playerid)) return HataMesajGonder(playerid, "Araçta bu komutu kullanamazsýn.");
	for (new i = 1; i != MAX_VEHICLES; i ++) if (IsValidVehicle(i) && IsPlayerNearHood(playerid, i))
	{
	    if (!IsDoorVehicle(i))
	        return HataMesajGonder(playerid, "Bu aracýn kaputu yok.");

	    if (!GetHoodStatus(i))
		{
	        SetHoodStatus(i, true);

	        SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s elini kaputun altýna sokar ve mandalý çekerek kaputu açar.", ReturnName(playerid, 0));
		}
		else
		{
			SetHoodStatus(i, false);

	        SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s elini kaputun üzerine koyar ve kaputu kapatýr. ", ReturnName(playerid, 0));
		}
	    return 1;
	}
	HataMesajGonder(playerid, "Kaputunu açabileceðin araca yakýn deðilsin.");
	return 1;
}

CMD:camlar(playerid)
{
	if (!IsPlayerInAnyVehicle(playerid)) return HataMesajGonder(playerid, "Araçta olmalýsýnýz.");
	new vehicleid = GetPlayerVehicleID(playerid);

	if (!IsWindowedVehicle(vehicleid))
		return HataMesajGonder(playerid, "Bu aracýn camý yok!");
	new carid = Car_GetID(vehicleid);
	switch (AracInfo[carid][aracCamlar])
	{
	    case true:
	    {
         	AracInfo[carid][aracCamlar] = false;
	        SetVehicleParamsCarWindows(vehicleid, 1, 1, 1, 1);
			infoYukleniyor(playerid);
		    SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s aracýn cam kapatma düðmesine basar ve camý kapatýr.", ReturnName(playerid, 0));
			GameTextForPlayer(playerid, "~r~Camlar Kapatildi", 3000, 4);
		}
		case false:
		{
		    AracInfo[carid][aracCamlar] = true;
		    SetVehicleParamsCarWindows(vehicleid, 0, 0, 0, 0);
			infoYukleniyor(playerid);
			GameTextForPlayer(playerid, "~g~Camlar Açýldý", 3000, 4);
		    SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s aracýn cam açma düðmesine basar ve camý açar.", ReturnName(playerid, 0));
		}
	}
	return 1;
}

CMD:bagaj(playerid)
{
	new
	    id = -1;

	if ((id = Car_Nearest(playerid)) != -1)
	{
	    if (PlayerData[playerid][pKelepce] > 0 || PlayerData[playerid][pHapisSure] > 0 || PlayerData[playerid][pSoklandi] > 0 || PlayerData[playerid][pYereYatirildi] > 0 || PlayerData[playerid][pBaygin] == 1 || PetKontrol[playerid] != -1 || pbOda[playerid] != -1 || GetPVarInt(playerid, "IpBaglandi") == 1)
 		return HataMesajGonder(playerid, "Þu an bu komutu kullanamazsýnýz.");
	    if (IsVehicleImpounded(AracInfo[id][aracVehicle]))
	        return HataMesajGonder(playerid, "Bu araç baðlanmýþ.");

	    if (IsPlayerInAnyVehicle(playerid))
	        return HataMesajGonder(playerid, "Önce araçtan inmen gereklidir.");

		if (GetPlayerState(playerid) != PLAYER_STATE_ONFOOT)
		    return HataMesajGonder(playerid, "Bu komutu sadece ayakta kullanabilirsiniz.");

		if (PlayerData[playerid][pBaygin] == 1) return HataMesajGonder(playerid, "Bunu þu an yapamazsýnýz.");
		if (!IsPlayerNearBoot(playerid, AracInfo[id][aracVehicle])) return HataMesajGonder(playerid, "Herhangi bir aracýn bagajýna yakýn deðilsiniz.");

		if (!IsDoorVehicle(AracInfo[id][aracVehicle]))
		    return HataMesajGonder(playerid, "Bu aracýn bagajý yok.");

		if (AracInfo[id][aracKilit])
		    return HataMesajGonder(playerid, "Bu araç kilitli.");

		if ((GetFactionType(playerid) == BIRLIK_LSPD || GetFactionType(playerid) == BIRLIK_FBI) && (AracInfo[id][aracFactionType] == BIRLIK_LSPD || AracInfo[id][aracFactionType] == BIRLIK_FBI))
  		{
       		Car_LSPDTrunk(playerid, AracInfo[id][aracVehicle]);
       		return 1;
       	}

		if ( Car_IsOwner(playerid, id) && (GetFactionType(playerid) == BIRLIK_LSPD || GetFactionType(playerid) == BIRLIK_FBI)) return HataMesajGonder(playerid, "Polisler bagaj özelliðini kullanamaz.");
	 	else if (Car_IsOwner(playerid, id) || ( !Car_IsOwner(playerid, id) && GetFactionType(playerid) == BIRLIK_LSPD))
	 	{
	 	    SetPVarInt(playerid, "AracBagaj", id);
	 	    Dialog_Show(playerid, Bagaj, DIALOG_STYLE_LIST, "Bagaj", "{FFFFFF}Uyuþturucular\n{FFFFFF}Silahlar", "Seç", "Kapat");
	 	}
	 	else HataMesajGonder(playerid, "Bu aracýn sahibi deðilsin.");
	}
	else HataMesajGonder(playerid, "Herhangi bir aracýn bagajýna yakýn deðilsiniz.");
	return 1;
}

CMD:akirala(playerid)
{
    new vehicleid = GetPlayerVehicleID(playerid);
    new id = Car_GetID(vehicleid);

    if (!OyundaDegil(playerid)) return 1;
    if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return HataMesajGonder(playerid, "Kiralýk araçta deðilsin.");

    if (AracInfo[id][aracKira] < 1) return HataMesajGonder(playerid, "Bu araç kiralýk deðil.");

	if (AracInfo[id][aracKiralayan] != -1 && AracInfo[id][aracKiralayan] != PlayerData[playerid][pID])
		return HataMesajGonder(playerid, "Bu araç baþkasý tarafýndan kiralanmýþ.");

	if (Kiralik_Araci(playerid) != AracInfo[id][aracID] && AracKiraladi(playerid))
		return HataMesajGonder(playerid, "Zaten kiraladýðýnýz araç var.");

	if (AracInfo[id][aracKira] > PlayerData[playerid][pCash]) return HataMesajGonder(playerid, "Yeterli paranýz yok.");

	if (Kiralik_Araci(playerid) == AracInfo[id][aracID] && AracInfo[id][aracKiraZaman] > 5)
		return HataMesajGonder(playerid, "Aracýn kira süresini sadece 5 dakika altý kaldýðýnda uzatabilirsin.");

    if (Kiralik_Araci(playerid) != AracInfo[id][aracID])
		MesajGonder(playerid, "Araç 60 dakikalýðýna kiralandý.");

    if (Kiralik_Araci(playerid) == AracInfo[id][aracID])
        MesajGonder(playerid, "Araç kira süresi 60 dakikalýðýna uzatýldý.");

    if (Kiralik_Araci(playerid) != AracInfo[id][aracID])
    	AracInfo[id][aracKiraZaman] = 60;

    if (Kiralik_Araci(playerid) == AracInfo[id][aracID])
    	AracInfo[id][aracKiraZaman] += 60;

	AracInfo[id][aracKiralayan] = PlayerData[playerid][pID];

	ParaVer(playerid, -AracInfo[id][aracKira]);
	return 1;
}

CMD:gate(playerid)
{
    new id = Gate_Nearest(playerid);
	if (id != -1)
    {
            if (PlayerData[playerid][pKelepce] > 0 || PlayerData[playerid][pHapisSure] > 0 || PlayerData[playerid][pSoklandi] > 0 || PlayerData[playerid][pYereYatirildi] > 0 || PlayerData[playerid][pBaygin] == 1 || PetKontrol[playerid] != -1 || pbOda[playerid] != -1 || GetPVarInt(playerid, "IpBaglandi") == 1)
 				return HataMesajGonder(playerid, "Þu an bu komutu kullanamazsýnýz.");

            if (GateData[id][gateFaction] != -1 && PlayerData[playerid][pFaction] != GetFactionByID(GateData[id][gateFaction]))
				return HataMesajGonder(playerid, "Bu kapýyý açamazsýn.");

			if (GateData[id][gateVip] != 0 && PlayerData[playerid][pVip] < GateData[id][gateVip])
                return HataMesajGonder(playerid, "Bu gate sadece viplere özeldir.");

			if (strlen(GateData[id][gatePass]))
	        {
	            PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
				ShowPlayerDialog(playerid,30,DIALOG_STYLE_INPUT, "{C8C8C8}Bu Gate Þifreli?", "Bu gate için þifre belirlenmiþ, lütfen þifreyi giriniz:", "Aç", "Kapat");
			}
	        else
	        {
				Gate_Operate(id);
	        }
    }
	return 1;
}
CMD:satinal(playerid)
{
    static
		id = -1;
    if (!OyundaDegil(playerid)) return 1;
	if ((id = House_Nearest(playerid)) != -1)
	{
	    if (PlayerData[playerid][pKelepce] > 0 || PlayerData[playerid][pHapisSure] > 0 || PlayerData[playerid][pSoklandi] > 0 || PlayerData[playerid][pYereYatirildi] > 0 || PlayerData[playerid][pBaygin] == 1 || PetKontrol[playerid] != -1 || pbOda[playerid] != -1 || GetPVarInt(playerid, "IpBaglandi") == 1)
 		return HataMesajGonder(playerid, "Þu an bu komutu kullanamazsýnýz.");
	    new maksev = 4;
	    switch (PlayerData[playerid][pVip])
	    {
	        case 1: maksev += 2;
	        case 2: maksev += 4;
	        case 3: maksev += 6;
	    }
	    if (Ev_GetCount(playerid) >= maksev) return HataMesajGonder(playerid, "En fazla %d eviniz olabilir.", maksev);
	    if (HouseInfo[id][evSahip] != -1 && HouseInfo[id][evSatilik] == 0) return HataMesajGonder(playerid, "Bu evin zaten sahibi var.");
	    if (HouseInfo[id][evSahip] == PlayerData[playerid][pID]) return HataMesajGonder(playerid, "Bu evin sahibi sensin.");
	    if (HouseInfo[id][evKiralik] == 1) return HataMesajGonder(playerid, "Bu ev kiralýk, kiralamak için /evkirala komutunu kullanýnýz.");
	    if (PlayerData[playerid][pCash] < HouseInfo[id][evFiyat]) return HataMesajGonder(playerid, "Yeterli paranýz yok.");
	    if (HouseInfo[id][evSahip] != -1)
	    {
	        if (GetPlayerIDWithSQLID(HouseInfo[id][evSahip]) != -1)
	        {
	            new pid = GetPlayerIDWithSQLID(HouseInfo[id][evSahip]);
	            ParaVer(pid,HouseInfo[id][evFiyat]);
	            MesajGonder(pid, "%s adlý kiþi evinizi {2ECC71}%s {FFFFFF}karþýlýðýnda satýn aldý.",ReturnName(playerid,0),FormatNumber(HouseInfo[id][evFiyat]));
	        }
	        else
	        {
                new str[100];
	            format(str,sizeof(str), "%s adlý kiþi evinizi %s karþýlýðýnda satýn aldý.",ReturnName(playerid,0),FormatNumber(HouseInfo[id][evFiyat]));
	            BildirimEkle(HouseInfo[id][evSahip],str, "Sistem");
	            OfflineParaVer(HouseInfo[id][evSahip],HouseInfo[id][evFiyat]);
	        }
	    }
	    if (Ev_GetKeyCount(id) > 0)
		{
		    new query[100];
			format(query, sizeof(query), "DELETE FROM `anahtarlar` WHERE `sqlid` = '%d' AND `tip` = '1'",HouseInfo[id][evID]);
			mysql_query(g_SQL, query, false);
		}
	    HouseInfo[id][evSahip] = PlayerData[playerid][pID];
	    HouseInfo[id][evSatilik] = 0;
	    HouseInfo[id][evKiralik] = 0;
	    HouseInfo[id][evKiralayan] = -1;
	    HouseInfo[id][evKiraUcret] = 0;
	    HouseInfo[id][MobilyaYetki] = -1;
	    Ev_Yenile(id);
	    Ev_Kaydet(id);
	    HouseInfo[id][evCash] = 0;
	    HouseInfo[id][evUyusturucu] = 0;
	    for (new i = 0; i != 10; i++)
		{
		    if (i < 5)
		    {
		        HouseInfo[id][evKiyafetler][i] = -1;
		    }
		    HouseInfo[id][evSilahlar][i] = 0;
		    HouseInfo[id][evMermiler][i] = 0;
		}
		ParaVer(playerid,-HouseInfo[id][evFiyat]);
		MesajGonder(playerid, "Bu evi {2ECC71}%s {FFFFFF}karþýlýðýnda satýn aldýnýz.",FormatNumber(HouseInfo[id][evFiyat]));
		Log_Write("logs/evlog.txt", "%s(%d) Adli oyuncu %d ID'li evi %d karsiliginda satin aldi.",ReturnName(playerid),playerid,HouseInfo[id][evID],HouseInfo[id][evFiyat]);
		HouseInfo[id][evFiyat] = HouseInfo[id][evKendiFiyati];
		if(PlayerData[playerid][pBasariEv] == 1)
		{
		    PlayerData[playerid][pBasariEv] = 1;
		    format(PlayerData[playerid][pBasariEvTarih],25,ReturnDate());
		    SunucuMesaji(playerid, "Ýlk ev baþarýmýný kazandýnýz.");
		}
	}
	else if ((id = Business_Nearest(playerid)) != -1)
	{
		if(Isyeri[id][isyeriTip] == 4)
			return Isyeri_AracMenu(playerid, id);

	    if (PlayerData[playerid][pBaygin] == 1) return HataMesajGonder(playerid, "Bunu þu an yapamazsýnýz.");
	    new maksisyeri = 3;
	    switch (PlayerData[playerid][pVip])
	    {
	        case 1: maksisyeri += 2;
	        case 2: maksisyeri += 4;
	        case 3: maksisyeri += 6;
	    }
	    if (Isyeri_GetCount(playerid) >= maksisyeri) return HataMesajGonder(playerid, "En fazla %d iþyeriniz olabilir.", maksisyeri);
	    if ((Isyeri[id][isyeriSahip] > 0 || Isyeri[id][isyeriSahip] == -99) && Isyeri[id][isyeriSatilik] == 0) return HataMesajGonder(playerid, "Bu iþyerin sahibi var.");
	    if (Isyeri[id][isyeriSahip] == PlayerData[playerid][pID]) return HataMesajGonder(playerid, "Bu iþyerin sahibi sensin.");
	    if (Isyeri[id][isyeriFiyat] > PlayerData[playerid][pCash]) return HataMesajGonder(playerid, "Yeterli paranýz yok.");
	    if (Isyeri[id][isyeriSahip] > 0 && Isyeri[id][isyeriSatilik] == 1 && Isyeri[id][isyeriSahip] != -99)
	    {
	        if (GetPlayerIDWithSQLID(Isyeri[id][isyeriSahip]) != -1)
	        {
	            ParaVer(GetPlayerIDWithSQLID(Isyeri[id][isyeriSahip]),Isyeri[id][isyeriFiyat]);
	            MesajGonder(GetPlayerIDWithSQLID(Isyeri[id][isyeriSahip]), "%s adlý kiþi iþyerinizi {2ECC71}%s {FFFFFF}karþýlýðýnda satýn aldý.",ReturnName(playerid,0),FormatNumber(Isyeri[id][isyeriFiyat]));
	        }
	        else
	        {
	            new str[100];
	            format(str,sizeof(str), "%s adlý kiþi iþyerinizi %s karþýlýðýnda satýn aldý.",ReturnName(playerid,0),FormatNumber(Isyeri[id][isyeriFiyat]));
	            BildirimEkle(Isyeri[id][isyeriSahip],str, "Sistem");
	            OfflineParaVer(Isyeri[id][isyeriSahip],Isyeri[id][isyeriFiyat]);
	        }
		}
		ParaVer(playerid,-Isyeri[id][isyeriFiyat]);
		MesajGonder(playerid, "Bu iþyerini {2ECC71}%s {FFFFFF}karþýlýðýnda satýn aldýnýz. (/isyeri)",FormatNumber(Isyeri[id][isyeriFiyat]));
		Isyeri[id][isyeriSahip] = PlayerData[playerid][pID];
		Isyeri[id][isyeriKasa] = 0;
		Isyeri[id][isyeriSatilik] = 0;
		Isyeri[id][isyeriFiyat] = Isyeri[id][isyeriKendiFiyati];
		Isyeri_Kaydet(id);
		Isyeri_Yenile(id);
	}
	else if ((id = Business_Inside(playerid)) != -1)
	{
	    if (PlayerData[playerid][pBaygin] == 1) return HataMesajGonder(playerid, "Bunu þu an yapamazsýnýz.");
	    if (Isyeri[id][isyeriKilit] != 0)
		    return HataMesajGonder(playerid, "Bu iþyeri kilitli!");
	    if (Isyeri[id][isyeriTip] == 4) {
		    Isyeri_AracMenu(playerid, id);
		} else {
			Isyeri_Urun(playerid, id);
		}
	}
	else if ((id = Arsa_Inside(playerid)) != -1)
	{
	    if (PlayerData[playerid][pBaygin] == 1) return HataMesajGonder(playerid, "Bunu þu an yapamazsýnýz.");
	    if (ArsaBilgi[id][arsaSahip] != -1) return HataMesajGonder(playerid, "Bu çiftlik satýlýk deðil.");
	    if (ArsaBilgi[id][arsaTip] != 1) return HataMesajGonder(playerid, "Bu çiftliði kiralamak için (/ciftlikkirala) komutunu kullanmalýsýnýz.");
	    if (ArsaBilgi[id][arsaFiyat] > PlayerData[playerid][pCash]) return HataMesajGonder(playerid, "Yeterli paranýz yok.");
	    ParaVer(playerid, -ArsaBilgi[id][arsaFiyat]);
	    ArsaBilgi[id][arsaSahip] = PlayerData[playerid][pID];
	    Arsa_Kaydet(id);
	    ArsaUpdate(id);
	    MesajGonder(playerid, "Çiftlik satýn alýndý, (/hayvan) komutu ile çiftliðe hayvan alabilir ve kesebilirsiniz.");
	}
	return 1;
}

CMD:ciftlikkirala(playerid, params[])
{
    if (!OyundaDegil(playerid)) return 1;
    new id = Arsa_Inside(playerid);
    new kacsaat;
    if (id == -1) return HataMesajGonder(playerid, "Herhangi bir çiftliðe yakýn deðilsiniz.");
    if (ArsaBilgi[id][arsaTip] != 2) return HataMesajGonder(playerid, "Bu çiftlik kiralýk deðil.");
    if (ArsaBilgi[id][arsaSahip] != -1) return HataMesajGonder(playerid, "Bu çiftlik baþkasý tarafýndan kiralanmýþ.");
    if (sscanf(params, "i", kacsaat)) return KullanimMesajGonder(playerid, "/ciftlikkirala [Saat] (1 saat = %s)", FormatNumber(ArsaBilgi[id][arsaFiyat]));
    if (kacsaat < 1 || kacsaat > 7) return HataMesajGonder(playerid, "En az 1, en fazla 7 saat girebilirsiniz.");
    if (PlayerData[playerid][pCash] < ArsaBilgi[id][arsaFiyat] * kacsaat) return HataMesajGonder(playerid, "Üzerinizde kirayý karþýlayacak paranýz yok. (%s)", FormatNumber(ArsaBilgi[id][arsaFiyat] * kacsaat));
    ParaVer(playerid, -ArsaBilgi[id][arsaFiyat] * kacsaat);
    ArsaBilgi[id][arsaSahip] = PlayerData[playerid][pID];
    ArsaBilgi[id][KiraSure] = gettime() + kacsaat*3600;
    Arsa_Kaydet(id);
    ArsaUpdate(id);
    MesajGonder(playerid, "Çiftlik %d saatliðine kiralandý, (/hayvan) komutu ile çiftliðe hayvan alabilir ve kesebilirsiniz.", kacsaat);
	return 1;
}

CMD:ev(playerid)
{
    static id = -1;
    if (PlayerData[playerid][pKelepce] > 0 || PlayerData[playerid][pHapisSure] > 0 || PlayerData[playerid][pSoklandi] > 0 || PlayerData[playerid][pYereYatirildi] > 0 || PlayerData[playerid][pBaygin] == 1 || PetKontrol[playerid] != -1 || pbOda[playerid] != -1 || GetPVarInt(playerid, "IpBaglandi") == 1)
 	return HataMesajGonder(playerid, "Þu an bu komutu kullanamazsýnýz.");
	if (!IsPlayerInAnyVehicle(playerid) && (id = (House_Inside(playerid) == -1) ? (House_Nearest(playerid)) : (House_Inside(playerid))) != -1)
	{
	    new string[1124], string2[400], durum[24],durum2[22],durum3[22];

	    if (HouseInfo[id][evSahip] == PlayerData[playerid][pID])
	    {
	        strcat(string, "Ýþlem\tDurum\n");
	        if (HouseInfo[id][evKilit] == 1) durum = "{FF0000}Kilitli";
	        else durum = "{2ECC71}Açýk";
	        if (HouseInfo[id][evKiralik] == 1) durum2 = "{2ECC71}Kiralýk";
	        else durum2 = "{FF0000}Kiralýk deðil";
	        if (HouseInfo[id][evSatilik] == 1) durum3 = "{2ECC71}Satýlýk";
	        else durum3 = "{FF0000}Satýlýk deðil";
	        format(string2, sizeof(string2), "Kilit Durumu\t%s\n",durum);
	        strcat(string,string2);
	        format(string2, sizeof(string2), "Ýsmi\t%s\n", HouseInfo[id][evIsim]);
	        strcat(string, string2);
	        format(string2, sizeof(string2), "Kasa\t{2ECC71}%s\n",FormatNumber(HouseInfo[id][evCash]));
	        strcat(string,string2);
	        format(string2, sizeof(string2), "Gardolap\t{2ECC71}-\n" );
	        strcat(string,string2);
	        format(string2, sizeof(string2), "Dekorasyon\t{2ECC71}-\n");
	        strcat(string,string2);
	        format(string2, sizeof(string2), "Kiralýk Yap\t{2ECC71}%s\n", durum2);
	        strcat(string,string2);
	        format(string2, sizeof(string2), "Kira Ücreti\t{2ECC71}%s\n", FormatNumber(HouseInfo[id][evKiraUcret]));
	        strcat(string,string2);
	        format(string2, sizeof(string2), "Satýlýða Çýkar\t{2ECC71}%s\n",durum3);
	        strcat(string,string2);
	        format(string2, sizeof(string2), "Kiracýyý Çýkar\t{2ECC71}%s\n", SQLName(HouseInfo[id][evKiralayan],0));
	        strcat(string,string2);
	        format(string2, sizeof(string2), "Anahtarlar\t%d\n",Ev_GetKeyCount(id));
	        strcat(string,string2);
	        ShowPlayerDialog(playerid,31,DIALOG_STYLE_TABLIST_HEADERS, "Ev Ayarlarý",string, "Ayarla", "Kapat");
	    }

		if (HouseInfo[id][evSahip] != PlayerData[playerid][pID] && HouseInfo[id][evKiralayan] == PlayerData[playerid][pID])
	    {
	         strcat(string, "Ýþlem\tDurum\n");
	         if (HouseInfo[id][evKilit] == 1) durum = "{FF0000}Kilitli";
    	     else durum = "{2ECC71}Açýk";
    	     format(string2, sizeof(string2), "Kilit Durumu\t%s{FFFFFF}\n",durum);
	         strcat(string,string2);
	         format(string2, sizeof(string2), "Gardolap\n");
	         strcat(string,string2);
	         format(string2, sizeof(string2), "Kiracýlýktan Çýk\t{FFFFFF}\n");
	         strcat(string,string2);
	         ShowPlayerDialog(playerid,39,DIALOG_STYLE_TABLIST_HEADERS, "Ev Ayarlarý",string, "Ayarla", "Kapat");
	    }

		if (HouseInfo[id][evSahip] != PlayerData[playerid][pID] && HouseInfo[id][evKiralayan] != PlayerData[playerid][pID] && Ev_AnahtarVar(playerid, id))
	    {
	         strcat(string, "Ýþlem\tDurum\n");
	         if (HouseInfo[id][evKilit] == 1) durum = "{FF0000}Kilitli";
    	     else durum = "{2ECC71}Açýk";
    	     format(string2, sizeof(string2), "Kilit Durumu\t%s{FFFFFF}\n",durum);
	         strcat(string,string2);
	         ShowPlayerDialog(playerid,65,DIALOG_STYLE_TABLIST_HEADERS, "Ev Ayarlarý",string, "Ayarla", "Kapat");
		}
	}
	return 1;
}

CMD:mobilya(playerid)
{
    if (!OyundaDegil(playerid)) return 1;
    new id = House_Inside(playerid);
    if (id == -1) return HataMesajGonder(playerid, "Herhangi bir evin içerisinde deðilsiniz!");
    if (HouseInfo[id][evSahip] != PlayerData[playerid][pID] && HouseInfo[id][MobilyaYetki] != PlayerData[playerid][pID]) return HataMesajGonder(playerid, "Mobilya düzenleme yetkiniz bulunmamaktadýr.");
    if (PlayerData[playerid][pKelepce] > 0 || PlayerData[playerid][pHapisSure] > 0 || PlayerData[playerid][pSoklandi] > 0 || PlayerData[playerid][pYereYatirildi] > 0 || PlayerData[playerid][pBaygin] == 1 || PetKontrol[playerid] != -1 || pbOda[playerid] != -1 || GetPVarInt(playerid, "IpBaglandi") == 1)
 	return HataMesajGonder(playerid, "Þu an bu komutu kullanamazsýnýz.");
    MobilyaMenu(playerid, id);
	return 1;
}

CMD:zilcal(playerid)
{
	if (!OyundaDegil(playerid)) return 1;
	if (PlayerData[playerid][pBaygin] == 1) return HataMesajGonder(playerid, "Bunu þu an yapamazsýnýz.");
	new id = House_Nearest(playerid);
	if (id == -1) return HataMesajGonder(playerid, "Herhangi bir eve yakýn deðilsiniz.");
	if (PlayerData[playerid][pKelepce] > 0 || PlayerData[playerid][pHapisSure] > 0 || PlayerData[playerid][pSoklandi] > 0 || PlayerData[playerid][pYereYatirildi] > 0 || PlayerData[playerid][pBaygin] == 1 || PetKontrol[playerid] != -1 || pbOda[playerid] != -1 || GetPVarInt(playerid, "IpBaglandi") == 1)
 	return HataMesajGonder(playerid, "Þu an bu komutu kullanamazsýnýz.");
	if (!spamProtect(playerid, "ZilCal", 10)) return HataMesajGonder(playerid, "Tekrar zil çalmak için 10 saniye beklemelisiniz.");

	foreach (new i : Player) if (House_Inside(i) == id)
	{
	    SendClientMessage(i, COLOR_AQUA, "** Evin zili çalýyor...");
	    PlayerPlaySound(i, 20801, 0, 0, 0);
	}
	PlayerPlaySoundEx(playerid, 20801);
	SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s evin zilini çalar.", ReturnName(playerid, 0));
	return 1;
}
CMD:evkirala(playerid)
{
    static
		id = -1;

	if ((id = House_Nearest(playerid)) != -1)
	{
	    if (PlayerData[playerid][pBaygin] == 1) return HataMesajGonder(playerid, "Bunu þu an yapamazsýnýz.");
	    if (EvKiraID(playerid) != -1) return HataMesajGonder(playerid, "Zaten kiralýk bir eviniz var.");
	    if (Ev_GetCount(playerid) > 0) return HataMesajGonder(playerid, "Eviniz varken ev kiralayamazsýnýz.");
	    if (HouseInfo[id][evKiralik] == 0) return HataMesajGonder(playerid, "Bu ev kiralýk deðil.");
	    if (HouseInfo[id][evKiralayan] != -1) return HataMesajGonder(playerid, "Bu ev zaten kiralanmýþ.");
	    if (HouseInfo[id][evSahip] == PlayerData[playerid][pID]) return HataMesajGonder(playerid, "Kendi evinizi kiralayamazsýnýz.");
	    if (HouseInfo[id][evKiraUcret] > PlayerData[playerid][pCash]) return HataMesajGonder(playerid, "Yeterli paranýz yok.");
	    HouseInfo[id][evKiralayan] = PlayerData[playerid][pID];
	    HouseInfo[id][evCash] += HouseInfo[id][evKiraUcret];
	    ParaVer(playerid,-HouseInfo[id][evKiraUcret]);
	    Ev_Kaydet(id);
	    Ev_Yenile(id);
	    MesajGonder(playerid, "Ev %s miktar paraya kiralandý. Artýk her maaþ aldýðýnýzda kirayý ödemek zorundasýnýz.",FormatNumber(HouseInfo[id][evKiraUcret]));
	    MesajGonder(playerid, "Eðer kirayý ödeyemezseniz evden otomatik olarak atýlacaksýnýz. /ev yazarak ev ayarlarýna eriþebilirsiniz.");
	    Log_Write("logs/evlog.txt", "%s(%d) Adli oyuncu %d ID'li evi %d karsiliginda kiraladi.",ReturnName(playerid),playerid,HouseInfo[id][evID],HouseInfo[id][evKiraUcret]);
	}
	return 1;
}

CMD:birlikkur(playerid)
{
	if (!OyundaDegil(playerid)) return 1;
	if (PlayerData[playerid][pBaygin] == 1) return HataMesajGonder(playerid, "Bunu þu an yapamazsýnýz.");
	if (PlayerData[playerid][pFaction] != -1) return HataMesajGonder(playerid, "Zaten bir birliðiniz var.");
	if (PlayerData[playerid][pLevel] < 5) return HataMesajGonder(playerid, "Birlik kurmak için en az 5 seviye olmalýsýnýz.");
	ShowPlayerDialog(playerid,47,DIALOG_STYLE_INPUT, "Birlik Kur", "{FFFFFF}Lütfen kurmak istediðiniz birliðin ismini girin:\n", "Kur", "Kapat");
	return 1;
}

CMD:birlik(playerid)
{
	new bid = PlayerData[playerid][pFaction];
	new rutbe = PlayerData[playerid][pFactionRutbe];
	if (bid == -1) return HataMesajGonder(playerid, "Bir birlik üyesi deðilsiniz.");
	new str[1000],string[250],durum[24];
	strcat(str, "Ýþlem\tDurum\n");
	new uyeler;

	foreach (new i : Player)
	{
	    if (bid == PlayerData[i][pFaction]) uyeler++;
	}

	if (Birlikler[bid][OOCDurum] == 1) durum = "{00FF00}Açýk";
	else durum = "{FF0000}Kapalý";

	format(string,sizeof(string), "{808080}» {F0F8FF}Çevrimiçi Üyeler\t{FF9900}%d\n",uyeler);
	strcat(str,string);
	format(string,sizeof(string), "{808080}» {F0F8FF}Birlik Bilgileri\n");
	strcat(str,string);
	format(string,sizeof(string), "{808080}» {F0F8FF}Birlikten Çýk\n");
	strcat(str,string);

	if (Birlikler[bid][birlikTip] >= 1 && Birlikler[bid][birlikTip] <= 4)
	{
	    format(string,sizeof(string), "{808080}» {F0F8FF}Birlik Kasa\t{FF9900}%s\n",FormatNumber(Birlikler[bid][birlikKasaPara]));
		strcat(str,string);
	}

	if (PlayerData[playerid][pFactionRutbe] == Birlikler[PlayerData[playerid][pFaction]][birlikRutbeler] || Birlikler[bid][birlikYetkilendirme][0] < rutbe)
	{
	    format(string,sizeof(string), "{808080}» {F0F8FF}Üye Al\n");
		strcat(str,string);
	}

	if (Birlikler[bid][birlikYetkilendirme][1] <= rutbe)
	{
	    format(string,sizeof(string), "{808080}» {F0F8FF}Üye At\n");
		strcat(str,string);
	}

	if (PlayerData[playerid][pFactionRutbe] > Birlikler[PlayerData[playerid][pFaction]][birlikRutbeler] - 1)
	{
	    format(string,sizeof(string), "{808080}» {F0F8FF}Çevrimdýþý Üyeler\n");
		strcat(str,string);
	}

	if (Birlikler[PlayerData[playerid][pFaction]][birlikYetkilendirme][2] <= rutbe)
	{
	    format(string,sizeof(string), "{808080}» {F0F8FF}Üye Rütbe Deðiþtir\n");
		strcat(str,string);
	}

	if (Birlikler[PlayerData[playerid][pFaction]][birlikYetkilendirme][3] <= rutbe && Birlikler[bid][birlikTip] != 1 && Birlikler[bid][birlikTip] != 2 && Birlikler[bid][birlikTip] != 3)
	{
	    format(string,sizeof(string), "{808080}» {F0F8FF}Üye Divizyon Deðiþtir\n");
		strcat(str,string);
	}

	if (PlayerData[playerid][pFactionRutbe] > Birlikler[PlayerData[playerid][pFaction]][birlikRutbeler] - 1)
	{
	    format(string,sizeof(string), "{808080}» {F0F8FF}Rütbe Adlarýný Düzenle\n");
		strcat(str,string);
	}

	if (PlayerData[playerid][pFactionRutbe] > Birlikler[PlayerData[playerid][pFaction]][birlikRutbeler] - 1 && Birlikler[bid][birlikTip] != 1 && Birlikler[bid][birlikTip] != 2 && Birlikler[bid][birlikTip] != 3)
	{
	    format(string,sizeof(string), "{808080}» {F0F8FF}Divizyon Adlarýný Düzenle\n");
		strcat(str,string);
	}

	if (PlayerData[playerid][pFactionRutbe] >= Birlikler[PlayerData[playerid][pFaction]][birlikRutbeler] - 3)
	{
	    format(string, sizeof(string), "{808080}» {F0F8FF}Birlik Araçlarýný Spawnla\n");
		strcat(str, string);
	}

	if (Birlikler[bid][birlikYetkilendirme][5] <= rutbe)
	{
	    format(string,sizeof(string), "{808080}» {F0F8FF}Birlik OOC Chat\t%s\n",durum);
		strcat(str,string);
	}

	if (PlayerData[playerid][pFactionRutbe] > Birlikler[PlayerData[playerid][pFaction]][birlikRutbeler]-1)
	{
	    format(string,sizeof(string), "{808080}» {F0F8FF}Rütbe Yetkilendirmeleri\n");
		strcat(str,string);
	}

	if (PlayerData[playerid][pFactionRutbe] > Birlikler[PlayerData[playerid][pFaction]][birlikRutbeler]-1)
	{
	    format(string, sizeof(string), "{808080}» {F0F8FF}Maksimum Rütbe Deðiþtir\n");
	    strcat(str, string);
	}

	if (Birlikler[bid][birlikTip] == BIRLIK_HABER && Birlikler[bid][birlikYetkilendirme][7] <= rutbe)
	{
	    format(string, sizeof(string), "{808080}» {F0F8FF}Ajans Ayarlarý\n");
	    strcat(str, string);
	}

	if (PlayerData[playerid][pFactionRutbe] > Birlikler[PlayerData[playerid][pFaction]][birlikRutbeler] - 1)
	{
	    format(string,sizeof(string), "{808080}» {F0F8FF}Birlik Duyurusu Deðiþtir\n");
		strcat(str,string);
	}

	Dialog_Show(playerid, BirlikDialog, DIALOG_STYLE_TABLIST_HEADERS, "Birlik", str, "Seç", "Iptal");
	return 1;
}
CMD:masatemizle(playerid)
{
	if(!OyundaDegil(playerid)) return 1;
    if (!IsPlayerInRangeOfPoint(playerid, 5.0, 1358.4689,959.9874,3016.7773)) return HataMesajGonder(playerid, "Herhangi bir Masaya yakýn deðilsiniz.");
    if (PlayerData[playerid][pCamasirBasladi] == 1) return HataMesajGonder(playerid, "Elinde zaten çöp var, atman gerek!");
    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
    PlayerData[playerid][pCamasirBasladi] = 1;
    SetPlayerAttachedObject(playerid, 9, 2845, 2, -0.289999, 0.179999, 0.256999, 0.000000, 93.800010, 0.000000, 0.492000, 0.498999, 1.000000);
    BilgiMesajGonder(playerid, "Masaçöpat ikonuna gidip /masacopat kullanmalýsýn!");
	return 1;
}

CMD:masacopat(playerid)
{
	if(!OyundaDegil(playerid)) return 1;
    if (!IsPlayerInRangeOfPoint(playerid, 5.0, 1389.6093,966.2722,3016.7773)) return HataMesajGonder(playerid, "Masa temizleme konumunda deðilsin!");
    if (PlayerData[playerid][pCamasirBasladi] == 0) return HataMesajGonder(playerid, "Elinde çöp yok!");
    RemovePlayerAttachedObject(playerid, 9);
    PlayerData[playerid][pCamasirBasladi] = 0;
    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
    ClearAnimations(playerid);
    ParaVer(playerid, 25);
    BilgiMesajGonder(playerid, "Çöpleri Attýn ve $25 elde ettin!");
	return 1;
}

CMD:baliktut(playerid)
{
	if(!OyundaDegil(playerid)) return 1;
	if(PlayerData[playerid][pKelepce] > 0 || PlayerData[playerid][pHapisSure] > 0 || PlayerData[playerid][pSoklandi] > 0 || PlayerData[playerid][pYereYatirildi] > 0 || PlayerData[playerid][pBaygin] == 1 || PetKontrol[playerid] != -1 || pbOda[playerid] != -1 || GetPVarInt(playerid, "IpBaglandi") == 1)
 	return HataMesajGonder(playerid, "Þu an bu komutu kullanamazsýnýz.");
	if(BalikTimer[playerid] != -1) return HataMesajGonder(playerid,"Zaten balýk tutuyorsun.");
	new slot = -1;
	for(new i; i<10; i++)
	{
	    if(PlayerData[playerid][pBalikID][i] == -1)
	    {
	        slot = i;
	        break;
	    }
	}
	if(slot == -1) return HataMesajGonder(playerid,"En fazla 10 adet balýk tutabilirsin.");
	if(!IsPlayerNearWater(playerid)) return HataMesajGonder(playerid,"Balýkçý Ýskelesinde deðilsin.");
	if(!spamProtect(playerid,"BalikTut",5)) return HataMesajGonder(playerid,"Tekrar balýk tutmak için biraz beklemelisiniz.");
	SetPlayerArmedWeapon(playerid, 0);
	ClearAnimations(playerid);
	if(GetPVarInt(playerid, "IlkBalik") == 0)
	{
	    SetPVarInt(playerid, "IlkBalik", 1);
	    TogglePlayerControllable(playerid, false);
		ApplyAnimation(playerid, "SAMP", "FishingIdle", 4.1, 0, 1, 1, 1, 0);
	}
	else
	{
	    ApplyAnimation(playerid, "SAMP", "FishingIdle", 4.1, 0, 1, 1, 1, 0);
	}
	SetPVarInt(playerid, "OltaSlot", -1);
	for(new i; i < MAX_PLAYER_ATTACHED_OBJECTS; ++i)
	{
 		if(IsPlayerAttachedObjectSlotUsed(playerid, i)) continue;
  		SetPlayerAttachedObject(playerid, i, 18632, 6, 0.091496, 0.019614, 0.000000, 185.619995, 354.958374, 0.000000);
		SetPVarInt(playerid, "OltaSlot", i);
  		break;
	}
 	SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "* %s oltayý denize doðru sallar.", ReturnName(playerid, 0));
 	BalikTimer[playerid] = SetTimerEx("BalikTutma",RandomEx(2000, 6000),false,"i",playerid);
	return 1;
}

CMD:pos(playerid, params[])
{
    new Float: playerx;
	new Float: playery;
	new Float: playerz;
	GetPlayerPos(playerid, playerx, playery, playerz);
	MesajGonder(playerid, "X: %d, Y: %d, Z: %d", playerx, playery, playerz);
	return 1;
}
CMD:isyeri(playerid)
{
	if (!OyundaDegil(playerid)) return 1;
	if (PlayerData[playerid][pKelepce] > 0 || PlayerData[playerid][pHapisSure] > 0 || PlayerData[playerid][pSoklandi] > 0 || PlayerData[playerid][pYereYatirildi] > 0 || PlayerData[playerid][pBaygin] == 1 || PetKontrol[playerid] != -1 || pbOda[playerid] != -1 || GetPVarInt(playerid, "IpBaglandi") == 1)
 	return HataMesajGonder(playerid, "Þu an bu komutu kullanamazsýnýz.");
	static id = -1;
	if (!IsPlayerInAnyVehicle(playerid) && (id = (Business_Inside(playerid) == -1) ? (Business_Nearest(playerid)) : (Business_Inside(playerid))) != -1)
	{
	    if (Isyeri[id][isyeriVergiSure] != 0 && Isyeri[id][isyeriVergi] >= IsyeriMaksVergi(id) && (PlayerData[playerid][pAdmin] < 2 || PlayerData[playerid][pAdminDuty] == 0)) return HataMesajGonder(playerid, "Bu iþyerinin vergisi ödenmediði için devlet tarafýndan kapatýlmýþ.");
	    new str[1000],string[500],durum[24],baslik[124];
	    if (Isyeri[id][isyeriSahip] == PlayerData[playerid][pID] || (PlayerData[playerid][pAdmin] >= 2 && PlayerData[playerid][pAdminDuty]== 1))
	    {
	        SetPVarInt(playerid, "IsyeriID",id);
	        strcat(str, "Ýþlem\tDurum\n");
	        if (Isyeri[id][isyeriKilit]) durum = "{FF0000}Kilitli";
	        else durum = "{2ECC71}Açýk";
	        format(string,sizeof(string), "Kilit Durumu\t%s\n",durum);
	        strcat(str,string);
	        format(string,sizeof(string), "Ýþyeri Kasasý\t{AFAFAF}%s\n",FormatNumber(Isyeri[id][isyeriKasa]));
	        strcat(str,string);
	        if (Isyeri[id][isyeriTip] != 4)
	        {
	            if (Isyeri[id][isyeriTip] != 7)
	            {
			        format(string,sizeof(string), "Ürün Al\n");
			        strcat(str,string);
		        }
	        }
	        else
	        {
	            if (Isyeri[id][isyeriTip] != 7)
	            {
		            format(string,sizeof(string), "Araç Ekle\n");
			        strcat(str,string);
		        }
	        }
	        format(string,sizeof(string), "Ýþyeri Adý\t{AFAFAF}%s\n",Isyeri[id][isyeriName]);
	        strcat(str,string);
	        format(string,sizeof(string), "Giriþ Ücreti\t{AFAFAF}%s\n",FormatNumber(Isyeri[id][isyeriGirisUcret]));
	        strcat(str,string);
	        format(string,sizeof(string), "Giriþ Mesajý\t{AFAFAF}%s\n",Isyeri[id][isyeriMesaj]);
	        strcat(str,string);
	        if (Isyeri[id][isyeriSatilik] == 1) durum = "{FF0000}Satýlýk";
	        else durum = "{2ECC71}Satýlýk Deðil";
	        format(string,sizeof(string), "Satýlýða Çýkar\t%s\n",durum);
	        strcat(str,string);
	        if (Isyeri[id][isyeriTip] == 6)
	        {
	            if (strlen(Isyeri[id][isyeriMuzik]) > 0) durum = "{2ECC71}Açýk";
	            else durum = "{FF0000}Kapalý";
	            format(string,sizeof(string), "Müzik Aç/Kapat\t%s\n",durum);
	        	strcat(str,string);
	        }
	        if (Isyeri[id][isyeriTip] != 4)
	        {
	            if (Isyeri[id][isyeriTip] != 7)
	            {
			        format(string,sizeof(string), "Ürün Fiyatlarýný Deðiþtir\n");
			        strcat(str,string);
		        }
	        }
	        else
	        {
	            if (Isyeri[id][isyeriTip] != 7)
	            {
		            format(string,sizeof(string), "Araç Düzenle\n");
			        strcat(str,string);
		        }
	        }
	        format(baslik,sizeof(baslik), "{E42020}Ýþyeri {FFFFFF}-{E42020} Vergi: %s/%s {FFFFFF}- {E42020}Saatlik Vergi: %s",FormatNumber(Isyeri[id][isyeriVergi]), FormatNumber(IsyeriMaksVergi(id)), FormatNumber(GetIsyeriVergi(id)));
			Dialog_Show(playerid,IsyeriDialog,DIALOG_STYLE_TABLIST_HEADERS,baslik,str, "Seç", "Kapat");
		}
		else return HataMesajGonder(playerid, "Ýþyerinize yakýn deðilsiniz.");
	}
	else return HataMesajGonder(playerid, "Ýþyerinize yakýn deðilsiniz.");
	return 1;
}

CMD:su(playerid)
{
	if (!OyundaDegil(playerid)) return 1;
	if (IsPlayerInAnyVehicle(playerid)) return HataMesajGonder(playerid, "Araçta bu iþlemi yapamazsýn.");
	if (PlayerData[playerid][pKelepce] > 0 || PlayerData[playerid][pHapisSure] > 0 || PlayerData[playerid][pSoklandi] > 0 || PlayerData[playerid][pYereYatirildi] > 0 || PlayerData[playerid][pBaygin] == 1 || PetKontrol[playerid] != -1 || pbOda[playerid] != -1 || GetPVarInt(playerid, "IpBaglandi") == 1)
 	return HataMesajGonder(playerid, "Þu an bu komutu kullanamazsýnýz.");
	if (PlayerData[playerid][pKelepce] == 1 || PlayerData[playerid][pSoklandi] > 0 || PlayerData[playerid][pYereYatirildi] > 0) return HataMesajGonder(playerid, "Þuan bunu yapamazsýn.");
	if (PlayerData[playerid][pSu] <= 0) return HataMesajGonder(playerid, "Hiç suyunuz yok.");
	if (PlayerData[playerid][pDrinking] == 1) return HataMesajGonder(playerid, "Zaten içecek içiyorsun.");
	PlayerData[playerid][pSu]--;
	PlayerData[playerid][pDrinking] = 1;
	PlayerData[playerid][pDrinkBar] = CreatePlayerProgressBar(playerid, 572.00, 440.00, 56.50, 3.20, -1429936641, 100.0);
	ShowPlayerProgressBar(playerid, PlayerData[playerid][pDrinkBar]);
 	SetPlayerProgressBarValue(playerid, PlayerData[playerid][pDrinkBar], 0);

 	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_SPRUNK);
 	SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s su þiþesini alýr ve açar.", ReturnName(playerid, 0));
 	MesajGonder(playerid, "Suyu içmek için {FF0000}'LMB' {FFFFFF}tuþuna basýnýz.");
	return 1;
}

CMD:aksesuar(playerid)
{
	if (!OyundaDegil(playerid)) return 1;

	if (PlayerData[playerid][pKelepce] > 0 || PlayerData[playerid][pHapisSure] > 0 || PlayerData[playerid][pSoklandi] > 0 || PlayerData[playerid][pYereYatirildi] > 0 || PlayerData[playerid][pBaygin] == 1 || PetKontrol[playerid] != -1 || pbOda[playerid] != -1 || GetPVarInt(playerid, "IpBaglandi") == 1)
 		return HataMesajGonder(playerid, "Þu an bu komutu kullanamazsýnýz.");

	AksesuarlariGoster(playerid, 0);
	return 1;
}
CMD:park(playerid, params[])
{
	if(GuvenliBolgedeyse(playerid)) return HataMesajGonder(playerid, "Güvenli bölgede aracýnýzý park edemezsiniz!");

    if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return HataMesajGonder(playerid, "Sürücü deðilsin.");

    new vehicleid = GetPlayerVehicleID(playerid);

    new Float:health;
	GetVehicleHealth(vehicleid, health);

	if (health < 500) return HataMesajGonder(playerid, "Araç hasarlý olduðu için aracý park edemiyorsunuz.");

 	if ((vehicleid = Car_GetID(vehicleid)) != -1 && Car_IsOwner(playerid, vehicleid))
 	{
  		new garajid = Garage_Inside(playerid);
 	    if (PlayerData[playerid][pCash] < 100) return HataMesajGonder(playerid, "Aracýnýzý park etmek için $100 gerekli.");
 	    if (garajid != -1 && ParkedilenAracSayisi(garajid) >= GarageData[garajid][gAracLimit]) return HataMesajGonder(playerid, "Bu garaja daha fazla araç park edilemez.");
 	    if (garajid != -1 && GarageData[garajid][gParkDurum] == 0) return HataMesajGonder(playerid, "Bu garaja araç park edilmesi yasak.");
 	    if (!spamProtect(playerid, "ParkEtme", 160)) return HataMesajGonder(playerid, "Aracýnýzý 2 dakikada bir parkedebilirsiniz!");

 	    ParaVer(playerid,-100);
 		    static
				g_arrSeatData[10] = {INVALID_PLAYER_ID, ...},
				g_arrDamage[4],
				seatid;

			GetVehicleDamageStatus(AracInfo[vehicleid][aracVehicle], g_arrDamage[0], g_arrDamage[1], g_arrDamage[2], g_arrDamage[3]);
			GetVehicleHealth(AracInfo[vehicleid][aracVehicle], health);

			foreach (new i : Player) if (IsPlayerInVehicle(i, AracInfo[vehicleid][aracVehicle])) {
		    seatid = GetPlayerVehicleSeat(i);

		    g_arrSeatData[seatid] = i;
			}
			GetVehiclePos(AracInfo[vehicleid][aracVehicle], AracInfo[vehicleid][aracPos][0],AracInfo[vehicleid][aracPos][1], AracInfo[vehicleid][aracPos][2]);
			GetVehicleZAngle(AracInfo[vehicleid][aracVehicle], AracInfo[vehicleid][aracPos][3]);

			if (garajid != -1) AracInfo[vehicleid][aracGaraj] = garajid;
			else AracInfo[vehicleid][aracGaraj] = -1;
			AracInfo[vehicleid][aracInterior] = GetPlayerInterior(playerid);
			AracInfo[vehicleid][aracWorld] = GetPlayerVirtualWorld(playerid);

			Arac_Kaydet(vehicleid);
			Arac_Spawn(vehicleid);
	        SetPlayerArmedWeapon(playerid, 0);

			SunucuMesaji(playerid, "Araç baþarýyla bulunduðunuz yere park edildi.");

	        UpdateVehicleDamageStatus(AracInfo[vehicleid][aracVehicle], g_arrDamage[0], g_arrDamage[1], g_arrDamage[2], g_arrDamage[3]);
			SetVehicleHealth(GetPlayerVehicleID(playerid), health);
			AracInfo[vehicleid][aracDisplay] = true;
	        SetVehicleVirtualWorld(AracInfo[vehicleid][aracVehicle], GetPlayerVirtualWorld(playerid));

			for (new i = 0; i < sizeof(g_arrSeatData); i ++) if (g_arrSeatData[i] != INVALID_PLAYER_ID) {
				PutPlayerInVehicle(g_arrSeatData[i], AracInfo[vehicleid][aracVehicle], i);

				g_arrSeatData[i] = INVALID_PLAYER_ID;
			}
	}
	return 1;
}
CMD:basari(playerid, params[]) return BasariMenu(playerid);
stock BasariMenu(playerid)
{
    new str[4000];
    strcat(str, "Baþarý Ismi\tÖdülü\tDurum\tTarih\n");
    format(str, sizeof(str), "%s{FFFFFF}Ýlk Paintball\t$250\t%s\t%s\n", str, (PlayerData[playerid][pBasariPB] == 1) ? ("{00DA00}Yapýldý") : ("{E81717}Yapýlmadý"), PlayerData[playerid][pBasariPBTarih]);
    format(str, sizeof(str), "%s{FFFFFF}Ýlk Ev\t$2500\t%s\t%s\n", str, (PlayerData[playerid][pBasariEv] == 1) ? ("{00DA00}Yapýldý") : ("{E81717}Yapýlmadý"), PlayerData[playerid][pBasariEvTarih]);
    format(str, sizeof(str), "%s{FFFFFF}Ýlk Araç\t$1000\t%s\t%s\n", str, (PlayerData[playerid][pBasariArac] == 1) ? ("{00DA00}Yapýldý") : ("{E81717}Yapýlmadý"), PlayerData[playerid][pBasariAracTarih]);
    format(str, sizeof(str), "%s{FFFFFF}Seviye 5 Ol\t$2500\t%s\t%s\n", str, (PlayerData[playerid][pBasari5] == 1) ? ("{00DA00}Yapýldý") : ("{E81717}Yapýlmadý"), PlayerData[playerid][pBasari5Tarih]);
    format(str, sizeof(str), "%s{FFFFFF}Seviye 10 Ol\t$5000\t%s\t%s\n", str, (PlayerData[playerid][pBasari10] == 1) ? ("{00DA00}Yapýldý") : ("{E81717}Yapýlmadý"), PlayerData[playerid][pBasari10Tarih]);
    Dialog_Show(playerid, basarimenu, DIALOG_STYLE_TABLIST_HEADERS, "Baþarý Menüsü", str, "Seç", "Kapat");
	return 1;
}
CMD:araclarim(playerid)
{
	new string[1000],count;
	strcat(string, "ID\tModel\tPlaka\tDurum\n");
	for (new i = 0; i < MAX_ARAC; i ++) if (AracInfo[i][aracExists] && AracInfo[i][aracSahip] == PlayerData[playerid][pID])
	{
	    format(string, sizeof(string), "%s%d\t%s\t%s\t%s\n",string, AracInfo[i][aracVehicle], ReturnVehicleModelName(AracInfo[i][aracModel]),AracInfo[i][aracPlaka],(AracInfo[i][aracDisplay]) ? ("{2ECC71}Aktif") : ("{FF0000}Pasif"));
	    count++;
	}
	if (!count) return HataMesajGonder(playerid, "Sahip olduðunuz araç yok.");

	Dialog_Show(playerid, Araclarim, DIALOG_STYLE_TABLIST_HEADERS,  "{808080}Araçlarýnýz", string, "Deðiþtir", "Kapat");
	return 1;
}
CMD:aracimibul(playerid)
{
    new string[1000],count;
	strcat(string, "ID\tModel\tLokasyon\tDurum\n");
	new Float:vX,Float:vY,Float:vZ;
	for (new i = 0; i < MAX_ARAC; i ++) if (AracInfo[i][aracExists] && AracInfo[i][aracSahip] == PlayerData[playerid][pID])
	{
	    GetVehiclePos(AracInfo[i][aracVehicle],vX,vY,vZ);
	    format(string, sizeof(string), "%s%d\t%s\t%s\t%s\n",string, AracInfo[i][aracVehicle], ReturnVehicleModelName(AracInfo[i][aracModel]),GetLocation(vX,vY,vZ),(AracInfo[i][aracDisplay]) ? ("{2ECC71}Aktif") : ("{FF0000}Pasif"));
	    count++;
	}
	if (!count) return HataMesajGonder(playerid, "Sahip olduðunuz araç yok.");

	Dialog_Show(playerid, AracimiBul, DIALOG_STYLE_TABLIST_HEADERS,  "{808080}Araç Bul", string, "Deðiþtir", "Kapat");
	return 1;
}
CMD:kilit(playerid)
{
    new
	   id = -1;

    if ((id = Car_Nearest(playerid)) != -1)
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
        if (PlayerData[playerid][pKelepce] > 0 || PlayerData[playerid][pHapisSure] > 0 || PlayerData[playerid][pSoklandi] > 0 || PlayerData[playerid][pYereYatirildi] > 0 || PlayerData[playerid][pBaygin] == 1 || PetKontrol[playerid] != -1 || pbOda[playerid] != -1 || GetPVarInt(playerid, "IpBaglandi") == 1)
 		return HataMesajGonder(playerid, "Þu an bu komutu kullanamazsýnýz.");
     	if (AracInfo[id][aracSahip] == PlayerData[playerid][pID] || (AracInfo[id][aracTip] == 2) || (AracInfo[id][aracTip] == 5 && PlayerData[playerid][pVip] > 0) || Car_Birlik(playerid,id) || Arac_AnahtarVar(playerid, id) || AracInfo[id][aracKiralayan] == PlayerData[playerid][pID] || (PlayerData[playerid][pFaction] != -1 && GetFactionType(playerid) != BIRLIK_CETE && GetFactionType(playerid) != BIRLIK_MAFYA &&  GetFactionType(playerid) != BIRLIK_LEGAL && AracInfo[id][aracFactionType] == GetFactionType(playerid)))
	    {
			if (!AracInfo[id][aracKilit])
			{
				AracInfo[id][aracKilit] = true;
				Arac_Kaydet(id);

				PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);

				SetVehicleParamsEx(AracInfo[id][aracVehicle], engine, lights, alarm, 1, bonnet, boot, objective);
				SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s '%s' model aracý kilitler.", ReturnName(playerid, 0), ReturnVehicleModelName(AracInfo[id][aracModel]));
   				infoYukleniyor(playerid);
				GameTextForPlayer(playerid, "~r~Kilit Kapatildi", 3000, 4);
			}
			else
			{
				AracInfo[id][aracKilit] = false;
				Arac_Kaydet(id);

  				PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
 				SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s '%s' model aracýn kilidini açar.", ReturnName(playerid, 0), ReturnVehicleModelName(AracInfo[id][aracModel]));
   				infoYukleniyor(playerid);
				GameTextForPlayer(playerid, "~g~Kilit Acildi", 3000, 4);
				SetVehicleParamsEx(AracInfo[id][aracVehicle], engine, lights, alarm, 0, bonnet, boot, objective);
			}
		}
		else HataMesajGonder(playerid, "Bu aracý kilitleyemezsin/açamazsýn !");
	}
	else HataMesajGonder(playerid, "Herhangi bir araca yakýn deðilsin.");
	return 1;
}

CMD:radyo(playerid)
{
    if (!OyundaDegil(playerid)) return 1;
    if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return HataMesajGonder(playerid, "Sürücü deðilsiniz.");
    Dialog_Show(playerid, AracRadyo, DIALOG_STYLE_LIST, "Araç Radyo", "{FFFFFF}Radyo Kanallarý\n{FFFFFF}URL Gir\n{fc4817}Radyoyu Durdur", "Seç", "Kapat");
	return 1;
}
CMD:arac(playerid)
{
	if(!OyundaDegil(playerid)) return 1;
	new str[1000],string[500],durum[40];
	if(IsPlayerInAnyVehicle(playerid))
	{
	    new vehicleid = GetPlayerVehicleID(playerid);
	    new id = Car_GetID(vehicleid);
	    static
	        engine,
	        lights,
	        alarm,
	        doors,
	        bonnet,
	        boot,
	        objective;

	    GetVehicleParamsEx(AracInfo[id][aracVehicle], engine, lights, alarm, doors, bonnet, boot, objective);
	    SetPVarInt(playerid,"CarID",id);
	    if(AracInfo[id][aracSahip] == PlayerData[playerid][pID])
	    {
	        strcat(str,"{FFFFFF}Ýþlem Adý\t{FFFFFF}Durum\n");
	        if(AracInfo[id][aracModel] == 509)
			{
			    strcat(str,"{FFFFFF}Parket\n");
			    Dialog_Show(playerid,AracAyarlari,DIALOG_STYLE_TABLIST_HEADERS,"{feda21}ARAÇ",str,"Seç","Kapat");
			    return 1;
			}
		    if(!AracInfo[id][aracVehicle]) durum = "[Plaka, KM...]";
			else durum = "[Plaka, KM...]";
			format(string, sizeof(string), "{FFFFFF}Araç Bilgileri\t%s\n", durum);
		    strcat(str, string);
			if(!GetEngineStatus(AracInfo[id][aracVehicle])) durum = "[{E74C3C}Kapalý{FFFFFF}]";
			else durum = "[{2ECC71}Açýk{FFFFFF}]";
			format(string, sizeof(string), "{FFFFFF}Motor\t%s\n", durum);
			strcat(str, string);
			if(!AracInfo[id][aracKilit]) durum = "[{2ECC71}Açýk{FFFFFF}]";
			else durum = "[{E74C3C}Kapalý{FFFFFF}]";
			format(string, sizeof(string), "{FFFFFF}Kilit\t%s\n", durum);
			strcat(str, string);
			if(!GetLightStatus(AracInfo[id][aracVehicle])) durum = "[{E74C3C}Kapalý{FFFFFF}]";
			else durum = "[{2ECC71}Açýk{FFFFFF}]";
			format(string, sizeof(string), "{FFFFFF}Farlar\t%s\n", durum);
			strcat(str, string);
			/*if(!GetHoodStatus(AracInfo[id][aracVehicle])) durum = "[{E74C3C}Kapalý{FFFFFF}]";
			else durum = "[{2ECC71}Açýk{FFFFFF}]";
			format(string, sizeof(string), "{FFFFFF}Kaput\t%s\n", durum);
			strcat(str, string);*/
			if(AracInfo[id][aracCamlar] == false) durum = "[{E74C3C}Kapalý{FFFFFF}]";
			else durum = "[{2ECC71}Açýk{FFFFFF}]";
			format(string, sizeof(string), "{FFFFFF}Camlar\t%s\n", durum);
			strcat(str, string);
			if(AracInfo[id][aracFaction] == -1) durum = "[{E74C3C}Hayýr{FFFFFF}]";
			else durum = "[{2ECC71}Evet{FFFFFF}]";
			format(string,sizeof(string),"{FFFFFF}Birlik aracý yap/çýkart\t%s\n",durum);
			strcat(str,string);
			strcat(str,"{FFFFFF}Parket\n");
			if(AracInfo[id][aracSatilik] == 1) durum = "[{2ECC71}Evet{FFFFFF}]";
			else durum = "[{E74C3C}Hayýr{FFFFFF}]";
			format(string,sizeof(string),"{FFFFFF}Aracý Sat\t%s\n",durum);
			strcat(str,string);
			format(string,sizeof(string),"{FFFFFF}Anahtarlar\t%d\n",Arac_GetKeyCount(id));
			strcat(str,string);
			strcat(str, "{FFFFFF}Modifiye Kontrolü");
			Dialog_Show(playerid,AracAyarlari,DIALOG_STYLE_TABLIST_HEADERS,"{feda21}ARAÇ",str,"Seç","Kapat");
		    return 1;
			}

    		strcat(str,"{E74C3C}Ýþlem Adý\t{E74C3C}Durum\n");
	        if(AracInfo[id][aracModel] == 509)
			{
			    strcat(str,"{E74C3C}Parket\n");
			    Dialog_Show(playerid,AracAyarlari,DIALOG_STYLE_TABLIST_HEADERS,"{feda21}ARAÇ",str,"Seç","Kapat");
			    return 1;
			}
		    if(!AracInfo[id][aracVehicle]) durum = "[Plaka, KM...]";
			else durum = "[Plaka, KM...]";
			format(string, sizeof(string), "{E74C3C}Araç Bilgileri\t%s\n", durum);
		    strcat(str, string);
			if(!GetEngineStatus(AracInfo[id][aracVehicle])) durum = "[{E74C3C}Kapalý{FFFFFF}]";
			else durum = "[{2ECC71}Açýk{FFFFFF}]";
			format(string, sizeof(string), "{E74C3C}Motor\t%s\n", durum);
			strcat(str, string);
			if(!AracInfo[id][aracKilit]) durum = "[{E74C3C}Kapalý{FFFFFF}]";
			else durum = "[{2ECC71}Açýk{FFFFFF}]";
			format(string, sizeof(string), "{E74C3C}Kilit\t%s\n", durum);
			strcat(str, string);
			if(!GetLightStatus(AracInfo[id][aracVehicle])) durum = "[{E74C3C}Kapalý{FFFFFF}]";
			else durum = "[{2ECC71}Açýk{FFFFFF}]";
			format(string, sizeof(string), "{E74C3C}Farlar\t%s\n", durum);
			strcat(str, string);
			if(!GetHoodStatus(AracInfo[id][aracVehicle])) durum = "[{E74C3C}Kapalý{FFFFFF}]";
			else durum = "[{2ECC71}Açýk{FFFFFF}]";
			format(string, sizeof(string), "{E74C3C}Kaput\t%s\n", durum);
			strcat(str, string);
			if(AracInfo[id][aracCamlar] == false) durum = "[{E74C3C}Kapalý{FFFFFF}]";
			else durum = "[{2ECC71}Açýk{FFFFFF}]";
			format(string, sizeof(string), "{E74C3C}Camlar\t%s\n", durum);
			strcat(str, string);
			strcat(str,"{E74C3C}Kaza Kayýtlarý\n");
		    //strcat(str,"{E74C3C}Birlik aracý yap/çýkart\n");
		    strcat(str,"{E74C3C}Parket\n");
			strcat(str,"{E74C3C}Araci Sat\n");
			format(string,sizeof(string),"{E74C3C}Anahtarlar\t%d\n",Arac_GetKeyCount(id));
			strcat(str, "{E74C3C}Modifiye Kontrolu");
			Dialog_Show(playerid,AracAyarlari,DIALOG_STYLE_TABLIST_HEADERS,"{feda21}ARAÇ",str,"Seç","Kapat");
	}
	return 1;
}
CMD:anahtarver(playerid)
{
	if (!OyundaDegil(playerid)) return 1;
	if (PlayerData[playerid][pKelepce] > 0 || PlayerData[playerid][pHapisSure] > 0 || PlayerData[playerid][pSoklandi] > 0 || PlayerData[playerid][pYereYatirildi] > 0 || PlayerData[playerid][pBaygin] == 1 || PetKontrol[playerid] != -1 || pbOda[playerid] != -1 || GetPVarInt(playerid, "IpBaglandi") == 1)
 	return HataMesajGonder(playerid, "Þu an bu komutu kullanamazsýnýz.");
	Dialog_Show(playerid, AnahtarVer, DIALOG_STYLE_LIST, "{38c5f7}Anahtar Ver", "{FFFFFF}Ev\n{FFFFFF}Araç", "Seç", "Kapat");
	return 1;
}

CMD:anahtarlarim(playerid)
{
    if (!OyundaDegil(playerid)) return 1;
    if (PlayerData[playerid][pKelepce] > 0 || PlayerData[playerid][pHapisSure] > 0 || PlayerData[playerid][pSoklandi] > 0 || PlayerData[playerid][pYereYatirildi] > 0 || PlayerData[playerid][pBaygin] == 1 || PetKontrol[playerid] != -1 || pbOda[playerid] != -1)
 	return HataMesajGonder(playerid, "Þu an bu komutu kullanamazsýnýz.");
    OyuncuAnahtarlar(playerid);
	return 1;
}

CMD:dolap(playerid)
{
	if (!OyundaDegil(playerid)) return 1;
	if (PlayerData[playerid][pKelepce] > 0 || PlayerData[playerid][pHapisSure] > 0 || PlayerData[playerid][pSoklandi] > 0 || PlayerData[playerid][pYereYatirildi] > 0 || PlayerData[playerid][pBaygin] == 1 || PetKontrol[playerid] != -1 || pbOda[playerid] != -1 || GetPVarInt(playerid, "IpBaglandi") == 1)
 	return HataMesajGonder(playerid, "Þu an bu komutu kullanamazsýnýz.");
	if (PlayerData[playerid][pFaction] == -1) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

	if (IsPlayerInRangeOfPoint(playerid, 2.5, 370.9414,1257.8363,3013.5627) && (GetFactionType(playerid) == BIRLIK_LSPD || GetFactionType(playerid) == BIRLIK_FBI))
	{
	    Dialog_Show(playerid,LSPDDolap,DIALOG_STYLE_LIST, "{1394BF}LSPD Dolap", "{1394BF}» {FFFFFF}Ýþbaþý\n{1394BF}» {FFFFFF}Üniformalar\n{1394BF}» {FFFFFF}Ekipmanlar\n{1394BF}» {FFFFFF}Silah Sýfýrla", "Seç", "Kapat");
	}
	else if (IsPlayerInRangeOfPoint(playerid, 2.5, 1160.1326,-1329.4207,1019.4266) && GetFactionType(playerid) == BIRLIK_LSMD)
	{
	    Dialog_Show(playerid, LSMDDolap, DIALOG_STYLE_LIST, "{FF8282}LSMD Dolap", "{FF8282}» {FFFFFF}Ýþbaþý\n{FF8282}» {FFFFFF}Üniformalar\n{FF8282}» {FFFFFF}Ekipmanlar", "Seç", "Kapat");
	}
	return 1;
}

CMD:uydu(playerid, params[])
{
	if (!OyundaDegil(playerid)) return 1;
	if (PlayerData[playerid][pKelepce] > 0 || PlayerData[playerid][pHapisSure] > 0 || PlayerData[playerid][pSoklandi] > 0 || PlayerData[playerid][pYereYatirildi] > 0 || PlayerData[playerid][pBaygin] == 1 || PetKontrol[playerid] != -1 || pbOda[playerid] != -1 || GetPVarInt(playerid, "IpBaglandi") == 1)
 		return HataMesajGonder(playerid, "Þu an bu komutu kullanamazsýnýz.");
 	if (GetFactionType(playerid) != BIRLIK_LSPD && GetFactionType(playerid) != BIRLIK_FBI && PlayerData[playerid][pAdmin] < 1) return YetkinizYok(playerid);

 	if (PlayerData[playerid][pLSPDUydu] == false)
 	{
		if(!IsPlayerInRangeOfPoint(playerid, 5.0, 371.1805,1273.5314,3013.5627))
	 		return HataMesajGonder(playerid, "Bu bölgede uydu moduna geçemezsiniz.");

	 	SetPVarInt(playerid, "uyduInterior", GetPlayerInterior(playerid));
	 	SetPVarInt(playerid, "uyduWorld", GetPlayerVirtualWorld(playerid));
 	    GetPlayerPos(playerid, uyduX, uyduY, uyduZ);
 	    PlayerData[playerid][pLSPDUydu] = true;
 	    SunucuMesaji(playerid, "Uydu modu açýldý, haritadan bir bölge iþaretleyiniz.");
 	}
 	else
 	{
 		SetCameraBehindPlayer(playerid);
 	    SetPlayerPos(playerid, uyduX, uyduY, uyduZ);
 	    SetPlayerInterior(playerid, GetPVarInt(playerid, "uyduInterior"));
 	    SetPlayerVirtualWorld(playerid, GetPVarInt(playerid, "uyduWorld"));
 	    PlayerData[playerid][pLSPDUydu] = false;
 	    DeletePVar(playerid, "uyduInterior");
 	    DeletePVar(playerid, "uyduWorld");
 	    SunucuMesaji(playerid, "Uydu modu kapatýldý.");
 	    TogglePlayerControllable(playerid,1);
 	}
	return 1;
}

CMD:fac(playerid,params[])
{
    new factionid = PlayerData[playerid][pFaction];

 	if (factionid == -1) return HataMesajGonder(playerid, "Herhangi bir birlik üyesi deðilsin.");
 	if (Birlikler[factionid][OOCDurum] == 0) return HataMesajGonder(playerid, "Birlik yetkilisi tarafýndan birlik chat devre dýþý býrakýlmýþ.");
 	if (isnull(params)) return KullanimMesajGonder(playerid, "(/f)action [Mesaj]");
 	SendBirlikMessage(factionid, 0x60FFFFAA, "{60ffff}(( %s %s: %s ))",Birlik_GetRutbe(playerid),ReturnName(playerid,0),params);
 	Log_Write("logs/birlik_chat.txt", "[%s] %s %s: %s", ReturnDate(),Birlik_GetRutbe(playerid),ReturnName(playerid),params);
	return 1;
}

CMD:taser(playerid)
{
	if (!OyundaDegil(playerid) || GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return HataMesajGonder(playerid, "Þuanda bu komutu kullanamazsýnýz.");
	if (GetFactionType(playerid) != BIRLIK_LSPD && GetFactionType(playerid) != BIRLIK_FBI) return HataMesajGonder(playerid, "Devlet memuru deðilsin.");
	if (PlayerData[playerid][pKelepce] > 0 || PlayerData[playerid][pHapisSure] > 0 || PlayerData[playerid][pSoklandi] > 0 || PlayerData[playerid][pYereYatirildi] > 0 || PlayerData[playerid][pBaygin] == 1 || PetKontrol[playerid] != -1 || pbOda[playerid] != -1 || GetPVarInt(playerid, "IpBaglandi") == 1)
 		return HataMesajGonder(playerid, "Þu an bu komutu kullanamazsýnýz.");

	if (!PlayerData[playerid][pTazer])
	{
	    PlayerData[playerid][pTazer] = 1;
        GetPlayerWeaponData(playerid, 2, PlayerData[playerid][pSilahlar][2], PlayerData[playerid][pMermiler][2]);

		GivePlayerWeapon(playerid, 23, 20000);
	    SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s kýlýfýný açar ve þok tabancasýný eline alýr.", ReturnName(playerid, 0));
	}
	else
	{
	    PlayerData[playerid][pTazer] = 0;
		SetWeapons(playerid);

		SetPlayerArmedWeapon(playerid, PlayerData[playerid][pSilahlar][2]);
	    SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s þok tabancasýný kýlýfýna koyar ve kýlýfý kapatýr.", ReturnName(playerid, 0));
	}
	return 1;
}
CMD:jammer(playerid, params[])
{
	if (GetFactionType(playerid) != BIRLIK_LSPD && GetFactionType(playerid) != BIRLIK_FBI)
		return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

	if (isnull(params))
 	{
	 	KullanimMesajGonder(playerid, "/jammer [ayar]");
  		SendClientMessage(playerid, 0xFFFF00FF, "[AYARLAR]:{FFFFFF} koy, kaldir, hepsinikaldir");
		return 1;
	}
	static
        Float:fX,
        Float:fY,
        Float:fZ,
        Float:fA;

    GetPlayerPos(playerid, fX, fY, fZ);
    GetPlayerFacingAngle(playerid, fA);

	if (!strcmp(params, "koy", true))
	{
	    if (IsPlayerInAnyVehicle(playerid))
	        return HataMesajGonder(playerid, "Araçta bunu yapamazsýnýz!");

	    for (new i = 0; i != MAX_JAMMERS; i ++) if (!JammerData[i][jammerExists])
	    {
			JammerData[i][jammerExists] = true;

			JammerData[i][jammerPos][0] = fX;
			JammerData[i][jammerPos][1] = fY;
			JammerData[i][jammerPos][2] = fZ;
			JammerData[i][jammerMenzil] = 70;

			new string[256];
			format(string, sizeof(string), "{E74C3C}[Jammer]\n{E74C3C}Yerleþtiren: {FFFFFF}%s\n{E74C3C}Menzil: {FFFFFF}%d m", ReturnName(playerid, 0), JammerData[i][jammerMenzil]);
			JammerData[i][jammerText3D] = CreateDynamic3DTextLabel(string, 0x2641FEFF, JammerData[i][jammerPos][0] + 0.5, JammerData[i][jammerPos][1] + 0.5, JammerData[i][jammerPos][2] - 0.5, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0, 0);

			JammerData[i][jammerObject] = CreateDynamicObject(363, fX+0.5, fY+0.5, fZ-0.5, 0.0, 0.0, fA);

			SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s yere bir jammer yerleþtirir.", ReturnName(playerid, 0));
			SendBirlikMessage(PlayerData[playerid][pFaction], COLOR_DEPARTMENT, "** DEPARTMAN: %s bir jammer yerleþtirdi. (Bölge: %s)", ReturnName(playerid, 0), GetLocation(fX, fY, fZ));

			return 1;
		}
		HataMesajGonder(playerid, "Sunucu maksimum jammer sayýsýna ulaþtý.");
	}
	else if (!strcmp(params, "kaldir", true))
	{
        for (new i = 0; i != MAX_JAMMERS; i ++) if (JammerData[i][jammerExists] && IsPlayerInRangeOfPoint(playerid, 3.0, JammerData[i][jammerPos][0], JammerData[i][jammerPos][1], JammerData[i][jammerPos][2]))
	    {
			JammerData[i][jammerExists] = 0;

			DestroyDynamicObject(JammerData[i][jammerObject]);
			DestroyDynamic3DTextLabel(JammerData[i][jammerText3D]);
			JammerData[i][jammerMenzil] = 0;

			SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s jammerý yerinden kaldýrýr.", ReturnName(playerid, 0));
			SendBirlikMessage(PlayerData[playerid][pFaction], COLOR_DEPARTMENT, "** DEPARTMAN: %s bir jammeri kaldýrdý. (Bölge: %s)", ReturnName(playerid, 0), GetLocation(fX, fY, fZ));
			return 1;
		}
		HataMesajGonder(playerid, "Yakýnýnýzda jammer yok.");
	}
	else if (!strcmp(params, "hepsinikaldir", true))
	{
		for (new i = 0; i != MAX_JAMMERS; i ++) if (JammerData[i][jammerExists])
		{
			JammerData[i][jammerExists] = 0;

			DestroyDynamicObject(JammerData[i][jammerObject]);
			DestroyDynamic3DTextLabel(JammerData[i][jammerText3D]);
		}
		SendBirlikMessage(PlayerData[playerid][pFaction], COLOR_DEPARTMENT, "** DEPARTMAN: %s tüm jammerleri kaldýrdý.", ReturnName(playerid, 0));
	}
	return 1;
}

CMD:drone(playerid, params[])
{
	if (GetFactionType(playerid) != BIRLIK_LSPD && GetFactionType(playerid) != BIRLIK_FBI)
		return HataMesajGonder(playerid, "Devlet memuru deðilsin.");

	ShowModelSelectionMenu(playerid, DroneList, "Drones", 0x393939BB, 0x3498DBBB);

	return 1;
}

CMD:dronecik(playerid)
{
	if (GetFactionType(playerid) != BIRLIK_LSPD && GetFactionType(playerid) != BIRLIK_FBI)
		return HataMesajGonder(playerid, "Devlet memuru deðilsin.");

	if(!IsValidVehicle(DroneCar[playerid]))
		return HataMesaji(playerid, "Þu anda zaten bir drone içerisinde deðilsiniz.");

	DestroyVehicle(DroneCar[playerid]);
	DroneCar[playerid] = 0;
	SunucuMesaji(playerid, "Droneden çýktýnýz.");

	return 1;
}

CMD:iha(playerid, params[])
{
	SunucuMesaji(playerid, "Sistemde açýk bulunduðu için kýsa süreliðine pasiftir.");
/*	if (GetFactionType(playerid) != BIRLIK_LSPD && GetFactionType(playerid) != BIRLIK_FBI)
		return HataMesajGonder(playerid, "Devlet memuru deðilsin.");

	ShowModelSelectionMenu(playerid, UcakList, "Drones2", 0x393939BB, 0x3498DBBB);
*/
	return 1;
}

CMD:ihacik(playerid)
{
	SunucuMesaji(playerid, "Sistemde açýk bulunduðu için kýsa süreliðine pasiftir.");
/*	if (GetFactionType(playerid) != BIRLIK_LSPD && GetFactionType(playerid) != BIRLIK_FBI)
		return HataMesajGonder(playerid, "Devlet memuru deðilsin.");

	if(!IsValidVehicle(DroneCar2[playerid]))
		return HataMesaji(playerid, "Þu anda zaten bir Ý.H.A içerisinde deðilsiniz.");

	DestroyVehicle(DroneCar2[playerid]);
	DroneCar2[playerid] = 0;
	SunucuMesaji(playerid, "Ý.H.A çýktýnýz.");
*/
	return 1;
}

CMD:kelepce(playerid, params[])
{
    new
	    userid;

	if (GetFactionType(playerid) != BIRLIK_LSPD && GetFactionType(playerid) != BIRLIK_FBI)
		return HataMesajGonder(playerid, "Devlet memuru deðilsin.");

    if (PlayerData[playerid][pKelepce] > 0 || PlayerData[playerid][pHapisSure] > 0 || PlayerData[playerid][pSoklandi] > 0 || PlayerData[playerid][pYereYatirildi] > 0 || PlayerData[playerid][pBaygin] == 1 || PetKontrol[playerid] != -1 || pbOda[playerid] != -1 || GetPVarInt(playerid, "IpBaglandi") == 1)
 		return HataMesajGonder(playerid, "Þu an bu komutu kullanamazsýnýz.");

	if (sscanf(params, "u", userid))
	    return KullanimMesajGonder(playerid, "/kelepce [ID/Isim]");

	if (!OyundaDegil(userid))
	    return HataMesajGonder(playerid, "Belirttiðiniz oyuncu oyunda deðil.");

    if (userid == playerid)
	    return HataMesajGonder(playerid, "Kendinizi kelepçeleyemezsiniz.");

	if (!IsPlayerNearPlayer(playerid, userid, 5.0))
	    return HataMesajGonder(playerid, "Kiþiye yakýn deðilsiniz.");

    if (!PlayerData[userid][pSoklandi] && GetPlayerSpecialAction(userid) != SPECIAL_ACTION_HANDSUP && !PlayerData[userid][pYereYatirildi])
	    return HataMesajGonder(playerid, "Oyuncu etkisiz halde veya ellerini kaldýrmýþ olmalýdýr.");

	if (GetPlayerState(userid) != PLAYER_STATE_ONFOOT)
	    return HataMesajGonder(playerid, "Kiþi ayakta olmalýdýr.");

    if (PlayerData[userid][pKelepce])
        return HataMesajGonder(playerid, "Kiþi zaten kelepçelenmiþ durumda.");

 		if (PlayerData[userid][pDrinking])
	    {
   			SetPlayerSpecialAction(userid, SPECIAL_ACTION_NONE);
			DestroyPlayerProgressBar(userid, PlayerData[userid][pDrinkBar]);
			PlayerData[userid][pDrinking] = 0;
	    }
		PlayerData[userid][pSoklandi] = 0;
		ClearAnimations(userid);
		SetPlayerArmedWeapon(userid,0);
	    PlayerData[userid][pKelepce] = 1;
	    SetPlayerCuffed(userid, true);
		TogglePlayerControllable(userid, true);
		SendClientMessageEx(userid,COLOR_LIGHTBLUE, "%s adlý memur tarafýndan kelepçelendiniz.",ReturnName(playerid,0));

	    SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s kelepçelerini kavrar ve %s adlý kiþinin bileklerine geçirerek kelepçeler.", ReturnName(playerid, 0), ReturnName(userid, 0));
    return 1;
}

CMD:kelepcecikar(playerid, params[])
{
    new
	    userid;

    if (GetFactionType(playerid) != BIRLIK_LSPD && GetFactionType(playerid) != BIRLIK_FBI)
		return HataMesajGonder(playerid, "Devlet memuru deðilsin.");

    if (PlayerData[playerid][pKelepce] > 0 || PlayerData[playerid][pHapisSure] > 0 || PlayerData[playerid][pSoklandi] > 0 || PlayerData[playerid][pYereYatirildi] > 0 || PlayerData[playerid][pBaygin] == 1 || PetKontrol[playerid] != -1 || pbOda[playerid] != -1 || GetPVarInt(playerid, "IpBaglandi") == 1)
 	return HataMesajGonder(playerid, "Þu an bu komutu kullanamazsýnýz.");

	if (sscanf(params, "u", userid))
	    return KullanimMesajGonder(playerid, "/kelepcecikar [ID/Ýsim]");

	if (!OyundaDegil(userid))
	    return HataMesajGonder(playerid, "Belirttiðiniz oyuncu oyunda deðil.");

    if (userid == playerid)
	    return HataMesajGonder(playerid, "Kendi kelepçeni çözemezsin.");

    if (!IsPlayerNearPlayer(playerid, userid, 5.0))
	    return HataMesajGonder(playerid, "Kiþiye yakýn deðilsiniz.");

    if (!PlayerData[userid][pKelepce])
        return HataMesajGonder(playerid, "Oyuncu kelepçeli deðil.");

    PlayerData[userid][pKelepce] = 0;
    PlayerData[userid][pDragged] = 0;
	PlayerData[userid][pDraggedBy] = INVALID_PLAYER_ID;
	KillTimer(PlayerData[userid][pDragTimer]);
    SetPlayerCuffed(userid, false);
    TogglePlayerControllable(userid,true);

    SendClientMessageEx(userid,COLOR_LIGHTBLUE, " %s adlý memur tarafýndan kelepçeniz çýkarýldý.",ReturnName(playerid,0));

    SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s adlý memur %s adlý kiþinin kelepçelerini çýkarýr.", ReturnName(playerid, 0), ReturnName(userid, 0));
    return 1;
}

CMD:ytasi(playerid, params[])
{
	new
	    userid, Float:oPos[4];

	if (GetFactionType(playerid) != BIRLIK_LSMD)
		return HataMesajGonder(playerid, "LSMD Memuru deðilsin.");

    if (PlayerData[playerid][pKelepce] > 0 || PlayerData[playerid][pHapisSure] > 0 || PlayerData[playerid][pSoklandi] > 0 || PlayerData[playerid][pYereYatirildi] > 0 || PetKontrol[playerid] != -1 || pbOda[playerid] != -1 || GetPVarInt(playerid, "IpBaglandi") == 1)
 	return HataMesajGonder(playerid, "Þu an bu komutu kullanamazsýnýz.");

    if (sscanf(params, "u", userid))
	    return KullanimMesajGonder(playerid, "/ytasi [ID/Isim]");

	if (!OyundaDegil(userid))
	    return HataMesajGonder(playerid, "Belirttiðiniz oyuncu oyunda deðil.");

    if (userid == playerid)
	    return HataMesajGonder(playerid, "Kendinizi sürükleyemezsiniz.");

	if (!IsPlayerNearPlayer(playerid, userid, 5.0))
	    return HataMesajGonder(playerid, "Kiþiye yakýn deðilsiniz.");

    if (!PlayerData[userid][pBaygin])
        return HataMesajGonder(playerid, "Kiþi baygýn veya yaralý deðil.");

	if (PlayerData[userid][pDragged])
	{
	    PlayerData[userid][pDragged] = 0;
	    PlayerData[userid][pDraggedBy] = INVALID_PLAYER_ID;

	    KillTimer(PlayerData[userid][pDragTimer]);
	    DestroyDynamicObject(Sedye[playerid]);

	    SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s, %s adlý kiþiyi sedye ile itmeyi býrakýr.", ReturnName(playerid, 0), ReturnName(userid, 0));
	}
	else
	{
	    GetPlayerPos(userid, oPos[0], oPos[1], oPos[2]);
	    GetPlayerFacingAngle(playerid, oPos[3]);

	    if (IsValidDynamicObject(Sedye[playerid]))
	    	DestroyDynamicObject(Sedye[playerid]);

		Sedye[playerid] = CreateDynamicObject(2146, oPos[0], oPos[1], oPos[2] - 0.5, 0.0000000, 0.0000000, oPos[3], -1, -1, -1, STREAMER_OBJECT_SD, 25.0, -1, 0);

		SetPlayerPos(userid, oPos[0], oPos[1], oPos[2] + 1.5000);

	    PlayerData[userid][pDragged] = 1;
	    PlayerData[userid][pDraggedBy] = playerid;

		ApplyAnimation(userid, "SWAT", "gnstwall_injurd", 4.1, true, false, false, false, 0, false);

	    PlayerData[userid][pDragTimer] = SetTimerEx("MDDragUpdate", 1600, true, "dd", playerid, userid);
	    SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s, %s adlý kiþiyi sedye ile taþýmaya baþlar.", ReturnName(playerid, 0), ReturnName(userid, 0));
	}
	return 1;
}

CMD:yaracaat(playerid, params[])
{
    if (!OyundaDegil(playerid)) return 1;
    if (GetFactionType(playerid) != BIRLIK_LSMD) return HataMesajGonder(playerid, "LSMD üyesi deðilsiniz.");
    if (IsPlayerInAnyVehicle(playerid)) return HataMesajGonder(playerid, "Araçtan inmelisiniz.");

    new id, seatid;

    if (sscanf(params, "u", id)) return KullanimMesajGonder(playerid, "/yaracaat [ID/Isim]");
    if (!OyundaDegil(id) || !IsPlayerNearPlayer(playerid, id, 5.0)) return HataMesajGonder(playerid, "Böyle bir oyuncu yok veya kiþiye yeterince yakýn deðilsiniz.");
    if (id == playerid) return HataMesajGonder(playerid, "Kendinizi araca atamazsýnýz.");
    if (IsPlayerInAnyVehicle(id)) return HataMesajGonder(playerid, "Bu oyuncu zaten araçta.");
    if (PlayerData[id][pBaygin] != 1) return HataMesajGonder(playerid, "Bu oyuncu yaralý deðil!");

    for (new i = 0; i != MAX_VEHICLES; i ++) if (IsPlayerNearBoot(playerid, i) && (GetVehicleModel(i) == 416 || GetVehicleModel(i) == 487))
    {
        seatid = GetAvailableSeat(i, 2);

	    if (seatid == -1)
	        return HataMesajGonder(playerid, "Araçta boþ yer yok.");

		KillTimer(PlayerData[id][pDragTimer]);

		if (IsValidDynamicObject(Sedye[playerid]))
			DestroyDynamicObject(Sedye[playerid]);

	    ClearAnimations(id);
	    StopLoopingAnim(id);
	    CanAyarla(id, 100);
	    SetPVarInt(id, "AracaBindi", 1);
	    SetPVarInt(id, "CPsineGelindi", 0);
	    PutPlayerInVehicle(id, i, seatid);
	    SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s, %s adlý kiþiyi sedyeye yerleþtirir ve emniyet kemerini baðlayarak araca bindirir.", ReturnName(playerid, 0), ReturnName(id, 0));
	    TogglePlayerControllable(id, false);
	    return 1;
    }

    HataMesajGonder(playerid, "Herhangi bir ambulans aracýna yakýn deðilsiniz.");
	return 1;
}
CMD:surukle(playerid, params[])
{
	new
	    userid;
    if (PlayerData[playerid][pKelepce] > 0 || PlayerData[playerid][pHapisSure] > 0 || PlayerData[playerid][pSoklandi] > 0 || PlayerData[playerid][pYereYatirildi] > 0 || PlayerData[playerid][pBaygin] == 1 || PetKontrol[playerid] != -1 || pbOda[playerid] != -1 || GetPVarInt(playerid, "IpBaglandi") == 1)
 	return HataMesajGonder(playerid, "Þu an bu komutu kullanamazsýnýz.");

    if (sscanf(params, "u", userid))
	    return KullanimMesajGonder(playerid, "/surukle [ID/Isim]");

	if (!OyundaDegil(userid))
	    return HataMesajGonder(playerid, "Belirttiðiniz oyuncu oyunda deðil.");

    if (userid == playerid)
	    return HataMesajGonder(playerid, "Kendinizi sürükleyemezsiniz.");

	if (!IsPlayerNearPlayer(playerid, userid, 5.0))
	    return HataMesajGonder(playerid, "Kiþiye yakýn deðilsiniz.");

    if (!PlayerData[userid][pKelepce] && !PlayerData[userid][pSoklandi] && GetPVarInt(userid, "IpBaglandi") == 0)
        return HataMesajGonder(playerid, "Kiþi kelepçeli ya da þok etkisinde deðil.");

	if (PlayerData[userid][pDragged])
	{
	    PlayerData[userid][pDragged] = 0;
	    PlayerData[userid][pDraggedBy] = INVALID_PLAYER_ID;

	    KillTimer(PlayerData[userid][pDragTimer]);
	    SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s, %s adlý kiþiyi sürüklemeyi býrakýr.", ReturnName(playerid, 0), ReturnName(userid, 0));
	}
	else
	{
	    PlayerData[userid][pDragged] = 1;
	    PlayerData[userid][pDraggedBy] = playerid;

	    PlayerData[userid][pDragTimer] = SetTimerEx("DragUpdate", 200, true, "dd", playerid, userid);
	    SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s, %s adlý kiþiyi sürüklemeye baþlar.", ReturnName(playerid, 0), ReturnName(userid, 0));
	}
	return 1;
}

CMD:sm(playerid)
{
	if (GetFactionType(playerid) != BIRLIK_LSPD && GetFactionType(playerid) != BIRLIK_FBI) return HataMesajGonder(playerid, "Devlet memuru deðilsin.");
	ShowPlayerDialog(playerid, 66, DIALOG_STYLE_LIST, "{8D8DFF}Sesli Megafon", "{FFFFFF}Teslim ol, etrafýn sarýldý!\n{FFFFFF}Burada olduðunu biliyoruz!\n{FFFFFF}Hey Sen! Polis, dur!\n{FFFFFF}Los Santos Polis Departmaný, olduðun yerde kal!\n{FFFFFF}Dur! yoksa ateþ açacaðýz!\n{FFFFFF}Hadi! Hadi! Hadi!\n{FFFFFF}Polis, kýpýrdama!\n{FFFFFF}Ellerin baþýnýn üstüne araçtan in!", "Seç", "Kapat");
	return 1;
}
CMD:megafon(playerid, params[])
{
	if (GetFactionType(playerid) != BIRLIK_LSPD && GetFactionType(playerid) != BIRLIK_FBI && GetFactionType(playerid) != BIRLIK_LSMD)
		return HataMesajGonder(playerid, "Bu komutu kullanamazsin.");

	if (!strlen(params) || isnull(params))
	    return KullanimMesajGonder(playerid,"(/m)egafon [Mesaj]");

	if (strlen(params) > 75)
		return HataMesajGonder(playerid, "Mesaj 75 karakter uzunluðunu geçemez.");

	new str[250];

	if (IsPlayerInAnyVehicle(playerid))
    {
	    format(str, sizeof(str), "** [ARAÇ MEGAFON] %s: %s ***", ReturnName(playerid, 0), params);
	    ProxDetector(15.0, playerid, str, COLOR_YELLOW);
    }
    else
    {
        format(str, sizeof(str), "** [EL MEGAFON] %s: %s ***", ReturnName(playerid, 0), params);
	    ProxDetector(15.0, playerid, str, COLOR_YELLOW);
    }
    return 1;
}

CMD:t(playerid,params[])
{
	if (GetFactionType(playerid) != BIRLIK_LSPD && GetFactionType(playerid) != BIRLIK_LSMD && GetFactionType(playerid) != BIRLIK_FBI && GetFactionType(playerid) != BIRLIK_GOV)
	    return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
    if (PlayerData[playerid][pKelepce] > 0 || PlayerData[playerid][pHapisSure] > 0 || PlayerData[playerid][pSoklandi] > 0 || PlayerData[playerid][pYereYatirildi] > 0 || PlayerData[playerid][pBaygin] == 1 || PetKontrol[playerid] != -1 || pbOda[playerid] != -1 || GetPVarInt(playerid, "IpBaglandi") == 1)
 	return HataMesajGonder(playerid, "Þu an bu komutu kullanamazsýnýz.");

	if (isnull(params))
	    return KullanimMesajGonder(playerid, "(/t)elsiz [Mesaj]");

	static string[250];

	if (strlen(params) > 64)
	{
	    if (GetFactionType(playerid) == BIRLIK_LSPD)
	    {
		    format(string,sizeof(string), "** [CH: 911 S: 1] %s %s: %.64s",Birlik_GetRutbe(playerid),ReturnName(playerid,0), params);
		    SendBirlikMessage(PlayerData[playerid][pFaction], 0xE0BA91FF, string);
		    format(string, sizeof(string), "...%s **", params[64]);
		    SendBirlikMessage(PlayerData[playerid][pFaction], 0xE0BA91FF, string);
	    }
	    if (GetFactionType(playerid) == BIRLIK_LSMD)
	    {
	        format(string,sizeof(string), "** (Telsiz) %s %s: %.64s",Birlik_GetRutbe(playerid),ReturnName(playerid,0), params);
		    SendBirlikMessage(PlayerData[playerid][pFaction], 0xE0BA91FF, string);
		    format(string, sizeof(string), "...%s **", params[64]);
		    SendBirlikMessage(PlayerData[playerid][pFaction], 0xE0BA91FF, string);
	    }
	    if (GetFactionType(playerid) == BIRLIK_GOV)
	    {
	       	format(string,sizeof(string), "** (Telsiz) %s %s: %.64s",Birlik_GetRutbe(playerid),ReturnName(playerid,0), params);
		    SendBirlikMessage(PlayerData[playerid][pFaction], 0xE0BA91FF, string);
		    format(string, sizeof(string), "...%s **", params[64]);
		    SendBirlikMessage(PlayerData[playerid][pFaction], 0xE0BA91FF, string);
	    }

	}
	else
	{
	    if (GetFactionType(playerid) == BIRLIK_LSPD)
	    {
		    format(string,sizeof(string), "** [CH: 911 S: 1] %s %s: %s",Birlik_GetRutbe(playerid),ReturnName(playerid,0),params);
		    SendBirlikMessage(PlayerData[playerid][pFaction], 0xE0BA91FF, string);
	    }
		if (GetFactionType(playerid) == BIRLIK_LSMD)
		{
		    format(string,sizeof(string), "** (Telsiz) %s %s: %s",Birlik_GetRutbe(playerid),ReturnName(playerid,0), params);
		    SendBirlikMessage(PlayerData[playerid][pFaction], 0xE0BA91FF, string);
		}
		if (GetFactionType(playerid) == BIRLIK_GOV)
		{
		    format(string,sizeof(string), "** (Telsiz) %s %s: %s",Birlik_GetRutbe(playerid),ReturnName(playerid,0),params);
		    SendBirlikMessage(PlayerData[playerid][pFaction], 0xE0BA91FF, string);
		}
	}

	format(string, sizeof string, "%s telsizinin mandalýna basarak konuþur.", ReturnName(playerid, 0));
	SetPlayerChatBubble(playerid, string, COLOR_CYAN, 25.0, 5000);
	return 1;
}

CMD:op(playerid, params[])
{
    if (GetFactionType(playerid) != BIRLIK_LSPD && GetFactionType(playerid) != BIRLIK_FBI && GetFactionType(playerid) != BIRLIK_LSMD)
	    return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
	if (Birlikler[PlayerData[playerid][pFaction]][birlikRutbeler]-3 > PlayerData[playerid][pFactionRutbe]) return HataMesajGonder(playerid, "Bu komutu kullanmak için yeterli rütbede deðilsiniz.");
	if (isnull(params)) return KullanimMesajGonder(playerid, "/op [Mesaj]");
	new str[224];
	if (strlen(params) > 64)
	{
	    format(str, sizeof(str), "** (Operatör) %.64s", params);
	    SendBirlikMessage(PlayerData[playerid][pFaction], COLOR_RADIO, str);
	    format(str, sizeof(str), "...%s **", params[64]);
	}
	else
	{
	    format(str, sizeof(str), "** (Operatör) %s", params);
	    SendBirlikMessage(PlayerData[playerid][pFaction], COLOR_RADIO, str);
	}
	return 1;
}

CMD:yt(playerid, params[])
{
    if (GetFactionType(playerid) != BIRLIK_LSPD && GetFactionType(playerid) != BIRLIK_FBI && GetFactionType(playerid) != BIRLIK_LSMD)
		return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

    if (PlayerData[playerid][pKelepce] > 0 || PlayerData[playerid][pHapisSure] > 0 || PlayerData[playerid][pSoklandi] > 0 || PlayerData[playerid][pYereYatirildi] > 0 || PlayerData[playerid][pBaygin] == 1 || PetKontrol[playerid] != -1 || pbOda[playerid] != -1 || GetPVarInt(playerid, "IpBaglandi") == 1)
 	return HataMesajGonder(playerid, "Þu an bu komutu kullanamazsýnýz.");
	if (isnull(params))
	    return KullanimMesajGonder(playerid, "/yt [Mesaj]");

	new Float:ppos[3], string[250];
	GetPlayerPos(playerid, ppos[0], ppos[1], ppos[2]);

	foreach (new i: Player)
	{
	    if (IsPlayerInRangeOfPoint(i, 35.0, ppos[0], ppos[1], ppos[2]) && (GetFactionType(i) == BIRLIK_LSPD || GetFactionType(i) == BIRLIK_FBI || GetFactionType(i) == BIRLIK_LSMD) )
		{
		    if(GetFactionType(i) != BIRLIK_LSPD)
		    	format(string, sizeof(string), "** (Yakýn Telsiz) %s %s: %s **", Birlik_GetRutbe(playerid), ReturnName(playerid, 0), params);

            if(GetFactionType(i) == BIRLIK_LSPD)
		    	format(string, sizeof(string), "** [CH: 911 S: YT] %s %s: %s **", Birlik_GetRutbe(playerid), ReturnName(playerid, 0), params);

			SendClientMessage(i, 0xE28B2CFF, string);
		}
	}
	return 1;
}
CMD:callsign(playerid, params[])
{
	new vehicleid = GetPlayerVehicleID(playerid), id = Car_GetID(vehicleid);

	new string[32];
	if (!IsPlayerInAnyVehicle(playerid)) return HataMesajGonder(playerid, "Bu komutu kullanmak için aracýn içinde olmanýz gerekmektedir.");

	if (GetFactionType(playerid) != BIRLIK_LSPD && GetFactionType(playerid) != BIRLIK_FBI && GetFactionType(playerid) != BIRLIK_LSMD )
		return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

	if (AracInfo[id][aracFactionType] != BIRLIK_LSMD && AracInfo[id][aracFactionType] != BIRLIK_FBI && AracInfo[id][aracFactionType] != BIRLIK_LSPD)
	    return HataMesajGonder(playerid, "Bu araç callsign koymak için uygun deðil.");

	if (VehicleCallSign[GetPlayerVehicleID(playerid)] == 1)
	{
 		DestroyDynamic3DTextLabel(Vehicle3DText[vehicleid]);
	    VehicleCallSign[vehicleid] = 0;
	    format(VehicleText[vehicleid], 24, "");
	    SunucuMesaji(playerid, "Callsign kaldýrýldý.");
	    return 1;
	}
	if (sscanf(params, "s[32]",string)) return KullanimMesaji(playerid, "/callsign [Birim Kodu]");
	if (VehicleCallSign[GetPlayerVehicleID(playerid)] == 0)
	{
	    format(VehicleText[vehicleid], 24, string);
 		Vehicle3DText[vehicleid] = CreateDynamic3DTextLabelEx(string, COLOR_WHITE, 0.0, -2.8, 0.0, 10.0, INVALID_PLAYER_ID, vehicleid, 1);
		VehicleCallSign[vehicleid] = 1;
	}
	return 1;
}
CMD:birimler(playerid)
{
    if (GetFactionType(playerid) != BIRLIK_LSPD && GetFactionType(playerid) != BIRLIK_FBI &&  GetFactionType(playerid) != BIRLIK_LSMD)
		return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

	new string[1024], sayi, durum[256];
    for (new i = 1; i != MAX_VEHICLES; i ++) if (VehicleCallSign[i] == 1)
	{
	    format(durum, sizeof(durum), "Araç ID %d - •  %s - %s\n", i, VehicleText[i], ReturnVehicleModelName(GetVehicleModel(i)));
		strcat(string, durum);
		sayi++;
	}
	if (sayi == 0) return HataMesajGonder(playerid, "Aktif birim yok.");
	Dialog_Show(playerid, birimler, DIALOG_STYLE_LIST, "Birimler", string, "Tamam", "");
	return 1;
}

CMD:dept(playerid, params[])
{
	if (GetFactionType(playerid) != BIRLIK_LSPD && GetFactionType(playerid) != BIRLIK_FBI &&  GetFactionType(playerid) != BIRLIK_LSMD)
	    return HataMesajGonder(playerid, "Bu komutu kullanamazsin.");

    if (PlayerData[playerid][pKelepce] > 0 || PlayerData[playerid][pHapisSure] > 0 || PlayerData[playerid][pSoklandi] > 0 || PlayerData[playerid][pYereYatirildi] > 0 || PlayerData[playerid][pBaygin] == 1 || PetKontrol[playerid] != -1 || pbOda[playerid] != -1 || GetPVarInt(playerid, "IpBaglandi") == 1)
 		return HataMesajGonder(playerid, "Þu an bu komutu kullanamazsýnýz.");

	if (isnull(params))
	    return KullanimMesajGonder(playerid, "(/d)ept [Mesaj]");

	for (new i = 0; i != MAX_BIRLIK; i ++)
	{
		if (Birlikler[i][birlikTip] == BIRLIK_LSPD || Birlikler[i][birlikTip] == BIRLIK_FBI || Birlikler[i][birlikTip] == BIRLIK_LSMD || Birlikler[i][birlikTip] == BIRLIK_GOV)
			SendBirlikMessage(i, COLOR_DEPARTMENT, "[%s] %s %s: %s", /*GetInitials(Birlikler[i][birlikAd]), */Birlikler[PlayerData[playerid][pFaction]][birlikAd], Birlik_GetRutbe(playerid), ReturnName(playerid, 0), params);
	}

	new string[128];

	format(string, sizeof string, "%s telsizinin mandalýna basarak konuþur.", ReturnName(playerid, 0));
	SetPlayerChatBubble(playerid, string, COLOR_CYAN, 25.0, 5000);

	Log_Write("logs/birlik_chat.txt", "[departman][%s] %s %s: %s", ReturnDate(), Birlik_GetRutbe(playerid), ReturnName(playerid, 0), params);
	return 1;
}

CMD:aracaat(playerid, params[])
{
	new
		userid,
		vehicleid = GetNearestVehicle(playerid);

    if (PlayerData[playerid][pKelepce] > 0 || PlayerData[playerid][pHapisSure] > 0 || PlayerData[playerid][pSoklandi] > 0 || PlayerData[playerid][pYereYatirildi] > 0 || PlayerData[playerid][pBaygin] == 1 || PetKontrol[playerid] != -1 || pbOda[playerid] != -1 || GetPVarInt(playerid, "IpBaglandi") == 1)
 	return HataMesajGonder(playerid, "Þu an bu komutu kullanamazsýnýz.");

	if (sscanf(params, "u", userid))
	    return KullanimMesajGonder(playerid, "/aracaat [ID/Isim]");

	if (!OyundaDegil(userid))
	    return HataMesajGonder(playerid, "Belirttiðiniz oyuncu oyunda deðil.");

    if (userid == playerid)
	    return HataMesajGonder(playerid, "Kendini araca atamazsýn.");

    if (!IsPlayerNearPlayer(playerid, userid, 5.0))
	    return HataMesajGonder(playerid, "Kiþiye yakýn deðilsiniz.");

    if (!PlayerData[userid][pKelepce] && GetPVarInt(userid, "IpBaglandi") == 0)
        return HataMesajGonder(playerid, "Kiþi þu anda kelepçeli veya baðlý deðil.");

	if (vehicleid == INVALID_VEHICLE_ID)
	    return HataMesajGonder(playerid, "Herhangi bir aracýn yakýnýnda deðilsin.");

	if (GetVehicleMaxSeats(vehicleid) < 2)
  	    return HataMesajGonder(playerid, "Bu araç dolu.");

	if (IsPlayerInVehicle(userid, vehicleid))
	{
		if (PlayerData[userid][pKelepce] != 1) TogglePlayerControllable(userid, 0);
		else TogglePlayerControllable(userid, 1);
		RemovePlayerFromVehicle(userid);
		SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s aracýn kapýsýný açar ve %s'ý araçtan indirir .", ReturnName(playerid, 0), ReturnName(userid, 0));
	}
	else
	{
	    if (PlayerData[userid][pBaygin] == 1)
	    {
	        PlayerData[userid][pBaygin] = 0;
	        PlayerData[userid][pBayginSure] = 0;
	        ClearAnimations(userid);
	        StopLoopingAnim(userid);
	    }
		new seatid = GetAvailableSeat(vehicleid, 2);

		if (seatid == -1)
		    return HataMesajGonder(playerid, "Boþ koltuk yok.");

		TogglePlayerControllable(userid, 0);

		PlayerData[userid][pDragged] = 0;
		PlayerData[userid][pDraggedBy] = INVALID_PLAYER_ID;
		KillTimer(PlayerData[userid][pDragTimer]);
		ClearAnimations(userid);
		PutPlayerInVehicle(userid, vehicleid, seatid);
		if (PlayerData[userid][pKelepce] == 1) TogglePlayerControllable(userid, false);
		SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s kapýyý açar ve %s'ý koltuða oturtur.", ReturnName(playerid, 0), ReturnName(userid, 0));
	}
	return 1;
}
CMD:aracicek(playerid, params[]) {
    if (PlayerData[playerid][pKelepce] > 0 || PlayerData[playerid][pHapisSure] > 0 || PlayerData[playerid][pSoklandi] > 0 || PlayerData[playerid][pYereYatirildi] > 0 || PlayerData[playerid][pBaygin] == 1 || PetKontrol[playerid] != -1 || pbOda[playerid] != -1)
 	return HataMesajGonder(playerid, "Þu an bu komutu kullanamazsýnýz.");

 	if (GetFactionType(playerid) == BIRLIK_LSPD || GetFactionType(playerid) == BIRLIK_FBI)
 	{
   		if (IsPlayerInAnyVehicle(playerid))
     	{
			new
				carid = GetPlayerVehicleID(playerid);

			if (GetVehicleModel(carid) == 525)
			{
   				new
					closestcar = GetClosestCar(playerid, carid);

				foreach (new i:Player) {
					if (AracCekiyor[i] == closestcar || (GetPlayerVehicleID(i) == closestcar && GetPlayerState(i) == 2)) return HataMesajGonder(playerid, "Ayný anda 2 aracý birden çekemezsin.");
				}
				new Float:VehiclePos[3];
				GetVehiclePos(closestcar,VehiclePos[0],VehiclePos[1],VehiclePos[2]);
       			if (GetPlayerDistanceFromPoint(playerid,VehiclePos[0],VehiclePos[1],VehiclePos[2]) <= 8 && !IsTrailerAttachedToVehicle(carid) && GetVehicleModel(closestcar) != 509) {
					MesajGonder(playerid, "Þuanda '%s' model aracý çekiyorsunuz.",ReturnVehicleModelName(GetVehicleModel(closestcar)));
					AttachTrailerToVehicle(closestcar,carid);
					AracCekiyor[playerid] = closestcar;
					return 1;
     			}
			}
			else HataMesajGonder(playerid, "Çekici aracýnda deðilsiniz.");
   		}
     	else HataMesajGonder(playerid, "Çekici aracýnda deðilsiniz.");
	}
   	else HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
   	return 1;
}
CMD:aracicekmeyibirak(playerid, params[])
{
    if (PlayerData[playerid][pKelepce] > 0 || PlayerData[playerid][pHapisSure] > 0 || PlayerData[playerid][pSoklandi] > 0 || PlayerData[playerid][pYereYatirildi] > 0 || PlayerData[playerid][pBaygin] == 1 || PetKontrol[playerid] != -1 || pbOda[playerid] != -1)
 	return HataMesajGonder(playerid, "Þu an bu komutu kullanamazsýnýz.");
	if (GetFactionType(playerid) == BIRLIK_LSPD || GetFactionType(playerid) == BIRLIK_FBI)
  	{
   		if (IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
     	{
      		MesajGonder(playerid, "Aracý çekmeyi býraktýn.");
			AracCekiyor[playerid] = INVALID_VEHICLE_ID;
			DetachTrailerFromVehicle(GetPlayerVehicleID(playerid));
     	}
      	else
       	{
        	HataMesajGonder(playerid, "Þuanda herhangi bir aracý çekmiyorsun.");
        }
  	}
   	else
	{
 		HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
	}
	return 1;
}

CMD:ekonomi(playerid)
{
	if(GetFactionType(playerid) != BIRLIK_GOV)
		return HataMesajGonder(playerid, "Bu komutu kullanmak için yetkiniz yok!");
	if(PlayerData[playerid][pFactionRutbe] != Birlikler[PlayerData[playerid][pFaction]][birlikRutbeler])
		return HataMesajGonder(playerid, "Rütbeniz yeterli deðil.");

	Ekonomi_Menu(playerid);
	return 1;
}

CMD:gov(playerid, params[])
{
    if (GetFactionType(playerid) != BIRLIK_GOV && GetFactionType(playerid) != BIRLIK_LSPD && GetFactionType(playerid) != BIRLIK_LSMD && GetFactionType(playerid) != BIRLIK_FBI) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
	if (isnull(params)) return KullanimMesajGonder(playerid, "/gov [Duyuru]");
	if (strlen(params) > 64)
	{
	    if (GetFactionType(playerid) == BIRLIK_GOV)
	    {
	        SendClientMessageToAllEx(0xAFAFAFFF, "[GOV] %s %s: {FFFFFF}%.64s", Birlik_GetRutbe(playerid), ReturnName(playerid, 0), params);
	        SendClientMessageToAllEx(0xFFFFFFFF, "...%s", params[64]);
	    }
	    if (GetFactionType(playerid) == BIRLIK_LSPD)
	    {
	        SendClientMessageToAllEx(0x8D8DFFFF, "[LSPD] %s %s: {FFFFFF}%.64s", Birlik_GetRutbe(playerid), ReturnName(playerid, 0), params);
	        SendClientMessageToAllEx(0xFFFFFFFF, "...%s", params[64]);
	    }
	    if (GetFactionType(playerid) == BIRLIK_FBI)
	    {
	        SendClientMessageToAllEx(0x8D8DFFFF, "[FBI] %s %s: {FFFFFF}%.64s", Birlik_GetRutbe(playerid), ReturnName(playerid, 0), params);
	        SendClientMessageToAllEx(0xFFFFFFFF, "...%s", params[64]);
	    }
	    if (GetFactionType(playerid) == BIRLIK_LSMD)
	    {
	        SendClientMessageToAllEx(0xFF8282FF, "[LSFD] %s %s: {FFFFFF}%.64s", Birlik_GetRutbe(playerid), ReturnName(playerid, 0), params);
	        SendClientMessageToAllEx(0xFFFFFFFF, "...%s", params[64]);
	    }

	}
	else
	{
	    if (GetFactionType(playerid) == BIRLIK_GOV)
	    {
	        SendClientMessageToAllEx(0xAFAFAFFF, "[GOV] %s %s: {FFFFFF}%s", Birlik_GetRutbe(playerid), ReturnName(playerid, 0), params);
	    }
	    if (GetFactionType(playerid) == BIRLIK_LSPD)
	    {
	        SendClientMessageToAllEx(0x8D8DFFFF, "[LSPD] %s %s: {FFFFFF}%s", Birlik_GetRutbe(playerid), ReturnName(playerid, 0), params);
	    }
	    if (GetFactionType(playerid) == BIRLIK_FBI)
	    {
	        SendClientMessageToAllEx(0x8D8DFFFF, "[FBI] %s %s: {FFFFFF}%s", Birlik_GetRutbe(playerid), ReturnName(playerid, 0), params);
	    }
	    if (GetFactionType(playerid) == BIRLIK_LSMD)
	    {
	        SendClientMessageToAllEx(0xFF8282FF, "[LSFD] %s %s: {FFFFFF}%s", Birlik_GetRutbe(playerid), ReturnName(playerid, 0), params);
	    }
	}
	return 1;
}
CMD:rozet(playerid, params[])
{

	if (GetFactionType(playerid) != BIRLIK_LSPD && GetFactionType(playerid) != BIRLIK_FBI && GetFactionType(playerid) != BIRLIK_LSMD && GetFactionType(playerid) != BIRLIK_HABER && GetFactionType(playerid) != BIRLIK_GOV)
		return HataMesajGonder(playerid, "Bu komutu kullanamazsýnýz.");
    if (PlayerData[playerid][pKelepce] > 0 || PlayerData[playerid][pHapisSure] > 0 || PlayerData[playerid][pSoklandi] > 0 || PlayerData[playerid][pYereYatirildi] > 0 || PlayerData[playerid][pBaygin] == 1 || PetKontrol[playerid] != -1 || pbOda[playerid] != -1 || GetPVarInt(playerid, "IpBaglandi") == 1)
 	return HataMesajGonder(playerid, "Þu an bu komutu kullanamazsýnýz.");

	if (PlayerData[playerid][pOnDuty])
	{
	    PlayerData[playerid][pOnDuty] = false;
	    SetPlayerColor(playerid, 0xFFFFFFFF);
		MesajGonder(playerid, "Rozetiniz gizlendi. /rozet komutunu kullanarak rozetinizi tekrar açabilirsiniz.");
	}
	else
	{
	    SetFactionColor(playerid);
	    PlayerData[playerid][pOnDuty] = true;
	    MesajGonder(playerid, "Rozet gösterildi.");
	}

    return 1;
}
CMD:kimlikgoster(playerid,params[])
{
    if (PlayerData[playerid][pKelepce] > 0 || PlayerData[playerid][pHapisSure] > 0 || PlayerData[playerid][pSoklandi] > 0 || PlayerData[playerid][pYereYatirildi] > 0 || PlayerData[playerid][pBaygin] == 1 || PetKontrol[playerid] != -1 || pbOda[playerid] != -1 || GetPVarInt(playerid, "IpBaglandi") == 1)
 	return HataMesajGonder(playerid, "Þu an bu komutu kullanamazsýnýz.");
 	static userid;
 	if (sscanf(params, "u", userid)) return KullanimMesajGonder(playerid, "/kimlikgoster [ID/Isim]");
 	if (!OyundaDegil(userid) || !IsPlayerNearPlayer(playerid, userid, 5.0)) return HataMesajGonder(playerid, "Oyuncu giriþ yapmamýþ veya oyuncuya yakýn deðilsin.");
	SendClientMessage(userid, COLOR_GREY, "-----------------------------------------------------------");
	SendClientMessageEx(userid, -1, "{FFFFFF}» Ad - Soyad: {C2A2DA}%s",ReturnName(playerid));
	SendClientMessageEx(userid, -1, "{FFFFFF}» Yaþ: {C2A2DA}%d",PlayerData[playerid][pYas]);
	SendClientMessageEx(userid, -1, "{FFFFFF}» Cinsiyet: {C2A2DA}%s",(PlayerData[playerid][pCinsiyet] == 2) ? ("Bayan") : ("Erkek"));
	SendClientMessageEx(userid, -1, "{FFFFFF}» Doðum Yeri: {C2A2DA}%s",PlayerData[playerid][pDogum]);
	SendClientMessageEx(userid, -1, "{FFFFFF}» Ten Rengi: {C2A2DA}%s",(PlayerData[playerid][pTen] == 1) ? ("Beyaz") : ("Siyah"));
	SendClientMessage(userid, COLOR_GREY, "-----------------------------------------------------------");
	SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s kimliðini çýkarýr ve %s'e gösterir.", ReturnName(playerid, 0), ReturnName(userid, 0));
	return 1;
}
CMD:rozetgoster(playerid,params[])
{
    if (PlayerData[playerid][pKelepce] > 0 || PlayerData[playerid][pHapisSure] > 0 || PlayerData[playerid][pSoklandi] > 0 || PlayerData[playerid][pYereYatirildi] > 0 || PlayerData[playerid][pBaygin] == 1 || PetKontrol[playerid] != -1 || pbOda[playerid] != -1 || GetPVarInt(playerid, "IpBaglandi") == 1)
 	return HataMesajGonder(playerid, "Þu an bu komutu kullanamazsýnýz.");

    if (GetFactionType(playerid) != BIRLIK_LSPD && GetFactionType(playerid) != BIRLIK_FBI && GetFactionType(playerid) != BIRLIK_LSMD && GetFactionType(playerid) != BIRLIK_HABER && GetFactionType(playerid) != BIRLIK_GOV) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
    static
	    userid;

	if (sscanf(params, "u", userid))
	    return KullanimMesajGonder(playerid, "/rozetgoster [ID/Ýsim]");

	if (!OyundaDegil(userid) || !IsPlayerNearPlayer(playerid, userid, 5.0))
	    return HataMesajGonder(playerid, "Oyuncu giriþ yapmamýþ veya oyuncuya yakýn deðilsin.");

	SendClientMessage(userid, COLOR_GREY, "-----------------------------------------------------------");
	SendClientMessageEx(userid, -1, "{FFFFFF}» Ad/Soyad: {C2A2DA}%s",ReturnName(playerid));
	SendClientMessageEx(userid, -1, "{FFFFFF}» Yaþ: {C2A2DA}%d",PlayerData[playerid][pYas]);
	SendClientMessageEx(userid, -1, "{FFFFFF}» Cinsiyet: {C2A2DA}%s",(PlayerData[playerid][pCinsiyet] == 2) ? ("Bayan") : ("Erkek"));
	SendClientMessageEx(userid, -1, "{FFFFFF}» Doðum Yeri: {C2A2DA}%s",PlayerData[playerid][pDogum]);
	SendClientMessageEx(userid, -1, "{FFFFFF}» Kurum: {C2A2DA}%s",Birlikler[PlayerData[playerid][pFaction]][birlikAd]);
	SendClientMessageEx(userid, -1, "{FFFFFF}» Rütbe: {C2A2DA}%s",Birlik_GetRutbe(playerid));
	SendClientMessage(userid, COLOR_GREY, "-----------------------------------------------------------");

	SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s rozetini çýkartýr ve %s'e gösterir.", ReturnName(playerid, 0), ReturnName(userid, 0));
	return 1;
}
CMD:aracibagla(playerid, params[])
{
	new ceza;
    if (GetFactionType(playerid) != BIRLIK_LSPD) return HataMesajGonder(playerid, "Devlet memuru deðilsin.");
    if (!IsPlayerInRangeOfPoint(playerid, 5.0, 1600.2130, -1609.2825, 13.4653)) return HataMesajGonder(playerid, "Araç baðlama yerine yakýn deðilsiniz.");
    if (sscanf(params, "i", ceza)) return KullanimMesajGonder(playerid, "/aracibagla [Ceza]");
    if (ceza < 50 || ceza > 3000) return HataMesajGonder(playerid, "En az $50, en fazla $3000 girebilirsiniz.");
    if (IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)) && AracCekiyor[playerid] != INVALID_VEHICLE_ID && GetVehicleModel(GetPlayerVehicleID(playerid)) == 525)
    {
        new aid = Car_GetID(AracCekiyor[playerid]);

        if (AracInfo[aid][aracExists] && AracInfo[aid][aracModel] != 509)
        {
            AracInfo[aid][aracBaglandi] = 1;
            AracInfo[aid][aracBaglandiCeza] = ceza;
            AracInfo[aid][aracDisplay] = false;
            Arac_Kaydet(aid);
            DetachTrailerFromVehicle(GetPlayerVehicleID(playerid));

			Arac_Spawn(aid);

            AracCekiyor[playerid] = INVALID_VEHICLE_ID;
            if (AracInfo[aid][aracSahip] != -1)
            {
                if (GetPlayerIDWithSQLID(AracInfo[aid][aracSahip]) != -1)
                {
                    SunucuMesaji(GetPlayerIDWithSQLID(AracInfo[aid][aracSahip]), "'%s' model aracýnýz %s adlý memur tarafýndan baðlandý. (Ceza: %s)", ReturnVehicleModelName(AracInfo[aid][aracModel]), ReturnName(playerid, 0), FormatNumber(ceza));
                    SendBirlikMessage(PlayerData[playerid][pFaction], COLOR_DEPARTMENT, "** DEPARTMAN: %s model araç %s adlý memur tarafýndan baðlandý. (Ceza: %s)", ReturnVehicleModelName(AracInfo[aid][aracModel]), ReturnName(playerid, 0),FormatNumber(ceza));
                }
                else
                {
                    new str[50];
                    format(str, sizeof(str), "%s model aracýnýz %s adlý memur tarafýndan baðlandý.",ReturnVehicleModelName(AracInfo[aid][aracModel]), ReturnName(playerid, 0));
                    BildirimEkle(AracInfo[aid][aracSahip], str, "LSPD");
                    SendBirlikMessage(PlayerData[playerid][pFaction], COLOR_DEPARTMENT, "** DEPARTMAN: %s model araç %s adlý memur tarafýndan baðlandý. (Ceza: %s)", ReturnVehicleModelName(AracInfo[aid][aracModel]), ReturnName(playerid, 0),FormatNumber(ceza));
                }
            }
            MesajGonder(playerid, "Araç baðlandý.");
        }
	}
	return 1;
}
CMD:flasor(playerid, params[])
{
    if (GetFactionType(playerid) != BIRLIK_LSPD && GetFactionType(playerid) != BIRLIK_LSMD)
        return HataMesajGonder(playerid, "Bu komutu kullanamazsýnýz.");

    new vehicleid = GetPlayerVehicleID(playerid);

    if (!IsPlayerInAnyVehicle(playerid))
        return HataMesajGonder(playerid, "Bir aracýn içinde olmalýsýn.");

    switch (Flasher[vehicleid])
    {
        case 0:
        {
            Flasher[vehicleid] = 1;
        }
        case 1:
        {
            Flasher[vehicleid] = 0;
        }
    }
    return 1;
}
CMD:siren(playerid, params[])
{
	if (GetFactionType(playerid) != BIRLIK_LSPD && GetFactionType(playerid) != BIRLIK_FBI && GetFactionType(playerid) != BIRLIK_LSMD)
	    return HataMesajGonder(playerid, "Devlet memuru deðilsin.");

	new vehicleid = GetPlayerVehicleID(playerid);

	if (!IsPlayerInAnyVehicle(playerid))
	    return HataMesajGonder(playerid, "Herhangi bir araçta deðilsin.");

	new id = Car_GetID(vehicleid);
	if (id == -1) return HataMesajGonder(playerid, "Bu araca siren objesi takýlamaz.");

	switch (AracInfo[id][aracSirenAcik])
	{
	    case false:
	    {
			static
        		Float:fSize[3],
        		Float:fSeat[3];

		    GetVehicleModelInfo(GetVehicleModel(vehicleid), VEHICLE_MODEL_INFO_SIZE, fSize[0], fSize[1], fSize[2]); // need height (z)
    		GetVehicleModelInfo(GetVehicleModel(vehicleid), VEHICLE_MODEL_INFO_FRONTSEAT, fSeat[0], fSeat[1], fSeat[2]); // need pos (x, y)

            AracInfo[id][aracSirenAcik] = true;
			AracInfo[id][SirenObject] = CreateDynamicObject(18646, 0.0, 0.0, 1000.0, 0.0, 0.0, 0.0);

		    AttachDynamicObjectToVehicle(AracInfo[id][SirenObject], vehicleid, -fSeat[0], fSeat[1], fSize[2] / 2.0, 0.0, 0.0, 0.0);
			MesajGonder(playerid, "Araca siren objesi takýldý.");
		}
		case 1:
		{
		    AracInfo[id][aracSirenAcik] = false;

			DestroyDynamicObject(AracInfo[id][SirenObject]);
			MesajGonder(playerid, "Siren objesi silindi.");
		}
	}
	return 1;
}

CMD:destekiste(playerid)
{
	if (!OyundaDegil(playerid)) return 1;
	if (GetFactionType(playerid) != BIRLIK_LSPD && GetFactionType(playerid) != BIRLIK_FBI && GetFactionType(playerid) != BIRLIK_LSMD) return HataMesajGonder(playerid, "Devlet memuru deðilsiniz.");
	if (PlayerData[playerid][pKelepce] > 0 || PlayerData[playerid][pHapisSure] > 0 || PlayerData[playerid][pSoklandi] > 0 || PlayerData[playerid][pYereYatirildi] > 0 || PlayerData[playerid][pBaygin] == 1 || PetKontrol[playerid] != -1 || pbOda[playerid] != -1 || GetPVarInt(playerid, "IpBaglandi") == 1)
 	return HataMesajGonder(playerid, "Þu an bu komutu kullanamazsýnýz.");
	if (PlayerData[playerid][pDestek] > 0) return HataMesajGonder(playerid, "Zaten destek isteðiniz var, /destekkapat ile kapatabilirsiniz.");

	new Float:pos[3];

	GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
	PlayerData[playerid][pDestek] = 180;

	SendBirlikMessageEx(GetFactionType(playerid), COLOR_DEPARTMENT, "** DEPARTMAN: %s adlý memur %s bölgesine destek istiyor.", ReturnName(playerid, 0), GetLocation(pos[0], pos[1], pos[2]));
	SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s telsizin acil durum butonuna basar ve destek ister.", ReturnName(playerid, 0));
	MesajGonder(playerid, "Destek istediniz, desteði kapatmak için /destekkapat komutunu kullanabilirsiniz.");
	return 1;
}

CMD:destekkapat(playerid)
{
    if (!OyundaDegil(playerid)) return 1;
	if (GetFactionType(playerid) != BIRLIK_LSPD && GetFactionType(playerid) != BIRLIK_FBI && GetFactionType(playerid) != BIRLIK_LSMD) return HataMesajGonder(playerid, "Devlet memuru deðilsiniz.");
	if (PlayerData[playerid][pDestek] < 1) return HataMesajGonder(playerid, "Destek isteðiniz yok.");
	DestekKapat(playerid, 0);
	return 1;
}
CMD:cctv(playerid)
{
    if (!OyundaDegil(playerid)) return 1;
    if (PlayerData[playerid][pKelepce] > 0 || PlayerData[playerid][pHapisSure] > 0 || PlayerData[playerid][pSoklandi] > 0 || PlayerData[playerid][pYereYatirildi] > 0 || PlayerData[playerid][pBaygin] == 1 || PetKontrol[playerid] != -1 || pbOda[playerid] != -1)
 	return HataMesajGonder(playerid, "Þu an bu komutu kullanamazsýnýz.");
    if (GetFactionType(playerid) != BIRLIK_LSPD && GetFactionType(playerid) != BIRLIK_FBI) return HataMesajGonder(playerid, "Devlet memuru deðilsiniz.");
	if (!IsPlayerInRangeOfPoint(playerid, 5.0, 388.3456,1273.0104,3013.5627) && PlayerData[playerid][pCCTV] == -1) return HataMesajGonder(playerid, "CCTV izleme noktasýnda deðilsin.");
    CCTVMenu(playerid);
	return 1;
}

CMD:cctvcik(playerid)
{
    if (!OyundaDegil(playerid)) return 1;
    if (PlayerData[playerid][pCCTV] == -1) return HataMesajGonder(playerid, "CCTV izlemiyorsunuz.");
    PlayerCancelCCTV(playerid);
	return 1;
}

CMD:yereyatir(playerid, params[])
{
	new hedefid;
    if (!OyundaDegil(playerid)) return 1;
    if (GetFactionType(playerid) != BIRLIK_LSPD && GetFactionType(playerid) != BIRLIK_FBI) return HataMesajGonder(playerid, "Devlet memuru deðilsiniz.");
    if (GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return HataMesajGonder(playerid, "Araçta bu komutu kullanamazsýnýz.");
    if (PlayerData[playerid][pKelepce] > 0 || PlayerData[playerid][pYereYatirildi] > 0 || PlayerData[playerid][pBaygin] == 1 || PlayerData[playerid][pHapisSure] > 0 || GetPVarInt(playerid, "IpBaglandi") == 1) return HataMesajGonder(playerid, "Þu an bu komutu kullanamazsýnýz.");
    if (sscanf(params, "u", hedefid)) return KullanimMesajGonder(playerid, "/yereyatir [ID/Isim]");
    if (!OyundaDegil(hedefid)) return HataMesajGonder(playerid, "Oyuncu giriþ yapmamýþ.");
    if (hedefid == playerid) return HataMesajGonder(playerid, "Kendi kendini yere yatýramazsýn.");
    if (!IsPlayerNearPlayer(playerid, hedefid, 2.0) || GetPlayerState(hedefid) == PLAYER_STATE_SPECTATING) return HataMesajGonder(playerid, "Kiþiye yeterince yakýn deðilsiniz.");
    if (GetPlayerState(hedefid) != PLAYER_STATE_ONFOOT) return HataMesajGonder(playerid, "Araçta olan bir kiþiyi yere yatýramazsýnýz.");
    if (PlayerData[hedefid][pKelepce] > 0 || PlayerData[hedefid][pHapisSure] > 0 || PlayerData[hedefid][pSoklandi] > 0 || PlayerData[hedefid][pYereYatirildi] > 0 || PlayerData[hedefid][pBaygin] == 1 || PetKontrol[hedefid] != -1 || pbOda[hedefid] != -1)
 	return HataMesajGonder(playerid, "Bu kiþiyi yere yatýramazsýnýz.");

    PlayerData[hedefid][pYereYatirildi] = 12;
    ApplyAnimation(hedefid, "CRACK", "crckdeth4", 4.0, 0, 0, 0, 1, 0, 1);
    TogglePlayerControllable(hedefid, 0);
    SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s %s'in üzerine atlar ve yere yatýrýr.", ReturnName(playerid, 0), ReturnName(hedefid, 0));
	return 1;
}

CMD:mdc(playerid)
{
    if (!OyundaDegil(playerid)) return 1;
    if (GetFactionType(playerid) != BIRLIK_LSPD && GetFactionType(playerid) != BIRLIK_FBI) return HataMesajGonder(playerid, "Devlet memuru deðilsiniz.");
    if (!IsPlayerInAnyVehicle(playerid)) return HataMesajGonder(playerid, "Polis aracýnýn içerisinde olmalýsýnýz.");
    new id = Car_GetID(GetPlayerVehicleID(playerid));
    if (AracInfo[id][aracFactionType] != BIRLIK_LSPD && AracInfo[id][aracFactionType] != BIRLIK_FBI) return HataMesajGonder(playerid, "Polis aracýnýn içerisinde olmalýsýnýz.");

    MenuMVB(playerid);
	return 1;
}

CMD:hapseat(playerid, params[])
{
    if (!OyundaDegil(playerid)) return 1;
    if (GetFactionType(playerid) != BIRLIK_LSPD && GetFactionType(playerid) != BIRLIK_FBI) return HataMesajGonder(playerid, "Devlet memuru deðilsiniz.");
    if (!IsPlayerNearArrest(playerid)) return HataMesajGonder(playerid, "Hapse atma noktasýnda deðilsiniz.");
    new userid, time;
    if (sscanf(params, "ui", userid, time)) return KullanimMesajGonder(playerid, "/hapseat [ID/Isim] [Dakika]");
    if (!OyundaDegil(userid)) return HataMesajGonder(playerid, "Oyuncu oyunda deðil.");
    if (!IsPlayerNearPlayer(playerid, userid, 4.0) || GetPlayerState(userid) == PLAYER_STATE_SPECTATING) return HataMesajGonder(playerid, "Kiþiye yeterince yakýn deðilsiniz.");
    if (time < 2 || time > 500) return HataMesajGonder(playerid, "Dakika 2 ve 500 arasýnda olmalýdýr.");
    if (PlayerData[userid][pAranma] < 1) return HataMesajGonder(playerid, "Bu kiþinin aranmasý yok.");

    PlayerData[userid][pHapis] = 1;
    PlayerData[userid][pHapisSure] = time*60;

	if (PlayerData[userid][pDragged])
	{
	    PlayerData[userid][pDragged] = 0;
		PlayerData[userid][pDraggedBy] = INVALID_PLAYER_ID;
		KillTimer(PlayerData[userid][pDragTimer]);
	}

	SetPlayerInPrison(userid);
	ResetWeapons(userid);
	PlayerData[userid][pKelepce] = 0;
	SetPlayerCuffed(userid, false);
	TogglePlayerControllable(userid, true);
	PlayerData[userid][pAranma] = 0;
	SetPlayerWantedLevel(userid, 0);
	DisablePlayerCheckpoint(userid);
	PlayerTextDrawShow(userid, HapisTD[playerid]);
	SetPlayerSpecialAction(userid, SPECIAL_ACTION_NONE);
	SendBirlikMessage(PlayerData[playerid][pFaction], COLOR_DEPARTMENT, "** DEPARTMAN: %s %s, %s adlý kiþiyi %d gün ((Dakika)) hapse attý.", Birlik_GetRutbe(playerid), ReturnName(playerid, 0), ReturnName(userid, 0), time);
	MesajGonder(userid, "%s adlý memur tarafýndan %d dakika hapse atýldýnýz.", ReturnName(playerid, 0), time);
	return 1;
}

CMD:hasarlar(playerid, params[])
{
	static
	    userid, hasarsayi;

	if (sscanf(params, "u", userid))
	    return KullanimMesajGonder(playerid, "/hasarlar [ID/Isim]");

	if (!OyundaDegil(userid))
	    return HataMesajGonder(playerid, "Böyle bir oyuncu yok!");

	if (!IsPlayerNearPlayer(playerid, userid, 5.0))
	    return HataMesajGonder(playerid, "Kiþiye yeterince yakýn deðilsiniz.");

    if (!PlayerData[userid][pBaygin])
	    return HataMesajGonder(playerid, "Bu oyuncu yaralý deðil!");

    static
		string[MAX_HASAR * 60];

	string[0] = 0;

	strcat(string, "Hasar\tBölge\tHasar Veren\tSilah\n");
	for (new i = 0; i < MAX_HASAR; i ++)
	{
		if (Hasarlar[userid][i][hasarVarmi]) {
			format(string, sizeof(string), "%s%.2f\t%s\t%s\t%s\n", string, Hasarlar[userid][i][hasarDeger], HasarBolge(Hasarlar[userid][i][hasarBolge]), (!IsPlayerConnected(Hasarlar[userid][i][hasarVeren])) ? ("Yok") : (ReturnName(Hasarlar[userid][i][hasarVeren], 0)), ReturnWeaponName(Hasarlar[userid][i][hasarSilah]));
			hasarsayi++;
		}
	}
	if (hasarsayi == 0) return HataMesajGonder(playerid, "Hiç hasarý yok.");
	Dialog_Show(playerid, Hasarlar, DIALOG_STYLE_TABLIST_HEADERS, ReturnName(userid, 0), string, "Tamam", "{FF6347}Iptal");
	return 1;
}
CMD:iyilestir(playerid, params[])
{
	new id;
	if (!OyundaDegil(playerid)) return 1;
	if (GetFactionType(playerid) != BIRLIK_LSMD) return HataMesajGonder(playerid, "LSMD üyesi deðilsiniz.");
	if (PlayerData[playerid][pIyilestiriyor] != -1) return HataMesajGonder(playerid, "Zaten þuanda birisini tedavi ediyorsun.");
	if (PlayerData[playerid][pBaygin] > 0 || PlayerData[playerid][pKelepce] > 0 || PlayerData[playerid][pDrinking] > 0 || PlayerData[playerid][pHapisSure] > 0 || IsPlayerInAnyVehicle(playerid) || GetPVarInt(playerid, "IpBaglandi") == 1) return HataMesajGonder(playerid, "Þu an bunu yapamazsýnýz.");
	if (sscanf(params, "u", id)) return KullanimMesajGonder(playerid, "/iyilestir [ID/Isim]");
	if (!OyundaDegil(id)) return HataMesajGonder(playerid, "Böyle bir oyuncu yok!");
	if (!IsPlayerNearPlayer(playerid, id, 2.5)) return HataMesajGonder(playerid, "Kiþiye yeterince yakýn deðilsiniz.");
	if (id == playerid) return HataMesajGonder(playerid, "Kendini iyileþtiremezsin.");
	if (PlayerData[id][pBaygin] != 1) return HataMesajGonder(playerid, "Bu oyuncu yaralý deðil!");
	if (GetPVarInt(id, "Iyilestiriliyor") == 1) return HataMesajGonder(playerid, "Bu oyuncu zaten iyileþtiriliyor.");
	PlayerData[playerid][pIyilestiriyor] = id;
	PlayerData[playerid][pIyilestirmeSure] = 0;
	PlayerData[playerid][pLoopAnim] = true;
	SetPVarInt(id, "Iyilestiriliyor", 1);
	SetPlayerArmedWeapon(playerid, 0);
	new Float:pos[3];
	GetPlayerPos(id, pos[0], pos[1], pos[2]);
	SetPlayerLookAt(playerid, pos[0], pos[1]);
	TogglePlayerControllable(playerid, false);
	ApplyAnimation(playerid, "BOMBER", "BOM_Plant_Loop", 4.1, 1, 1, 1, 0, 0, 1);
	ApplyAnimation(playerid, "BOMBER", "BOM_Plant_Loop", 4.1, 1, 1, 1, 0, 0, 1);
	MesajGonder(playerid, "%s adlý kiþiyi tedavi ediyorsun, 15 saniye sonra bitecek.", ReturnName(id, 0));
	return 1;
}

CMD:ambulanscagir(playerid, params[])
{
	if (PlayerData[playerid][pBaygin] != 1)
		return HataMesajGonder(playerid, "Bu komutu sadece yaralýlar kullanabilir.");

	new bildirimCount = 0;

	foreach (new i : Player)
	{
	    if (GetFactionType(i) == BIRLIK_LSMD)
	    {
	        SendClientMessageEx(i, 0xFF8282FF, "%s isimli oyuncu yaralý, /yaralilar komutu ile oyuncuyu kabul edebilirsin.", ReturnName(playerid, 0));
			bildirimCount++;
		}
	}

	if (bildirimCount != 0)
		MesajGonder(playerid, "Aktif LSMD üyelerine bildirim gönerildi.");

	if (bildirimCount == 0)
		HataMesajGonder(playerid, "Aktif LSMD üyesi bulunamadý.");

	return 1;
}

CMD:yaralilar(playerid)
{
    if (!OyundaDegil(playerid)) return 1;
    if (GetFactionType(playerid) != BIRLIK_LSMD) return HataMesajGonder(playerid, "LSMD üyesi deðilsiniz.");
   	if (PlayerData[playerid][pBaygin] > 0 || PlayerData[playerid][pHapisSure] > 0) return HataMesajGonder(playerid, "Bunu þu an yapamazsýn.");
    YaraliListesi(playerid);
	return 1;
}


CMD:yteslim(playerid, params[])
{
    if (!OyundaDegil(playerid)) return 1;
    if (GetFactionType(playerid) != BIRLIK_LSMD) return HataMesajGonder(playerid, "LSMD üyesi deðilsiniz.");
    if (!IsPlayerInAnyVehicle(playerid)) return HataMesajGonder(playerid, "Araçta olmalýsýnýz.");
    if (!IsPlayerInRangeOfPoint(playerid, 7.0, 1142.4302,-1330.7209,13.5374)) return HataMesajGonder(playerid, "Yaralý teslim noktasýna yakýn deðilsiniz.");
    new userid;
    if (sscanf(params, "u", userid)) return KullanimMesajGonder(playerid, "/yteslim [ID/Isim]");
	if (!OyundaDegil(userid) || !IsPlayerInVehicle(playerid, GetPlayerVehicleID(playerid))) return HataMesajGonder(playerid, "Bu oyuncu sizin aracýnýzda deðil veya baðlantýsý kesildi.");
	if (userid == playerid) return HataMesajGonder(playerid, "Hastaneye kendinizi teslim edemezsiniz.");
	if (PlayerData[userid][pBaygin] != 1) return HataMesajGonder(playerid, "Bu oyuncu aðýr yaralý deðil.");

 	PlayerData[userid][pBaygin] = 0;
  	PlayerData[userid][pBayginSure] = 0;
  	PlayerData[userid][pTopallama] = false;
  	PlayerData[userid][pTopallamaSayac] = 0;

  	SetPVarInt(userid, "AracaBindi", 0);
   	SetPlayerPos(userid, 1173.6667,-1322.4286,15.1954);
    SetPlayerInterior(userid, 0);
    SetPlayerVirtualWorld(userid, 0);
    SetPlayerFacingAngle(userid, 267.3835);
    TogglePlayerControllable(userid, true);
    CanAyarla(userid, 100);
    ClearAnimations(userid);
    StopLoopingAnim(userid);
    ResetPlayerDamages(userid);

	if (GetFactionType(userid) == BIRLIK_LSPD || GetFactionType(userid) == BIRLIK_LSMD || GetFactionType(userid) == BIRLIK_FBI)
	{
 		SendClientMessage(userid, 0xFF8282AA, "Hastane masraflarý devlet tarafýndan ödendi, iyi günler.");
   		if (PlayerData[userid][pAranma] > 0)
    	{
     		SendBirlikMessageEx(BIRLIK_LSPD, COLOR_DEPARTMENT, "** DEPARTMAN: All Saints Hastanesi %s adlý kiþiyi aranan olarak bildirdi.",ReturnName(userid,0));
       		SendBirlikMessageEx(BIRLIK_FBI, COLOR_DEPARTMENT, "** DEPARTMAN: All Saints Hastanesi %s adlý kiþiyi aranan olarak bildirdi.",ReturnName(userid,0));
	    }
	}
	else
	{
 		ParaVer(userid, -150);
   		SendClientMessage(userid, 0xFF8282AA, "Hastane masraflarý için $150 ödediniz, iyi günler.");

		//ResetWeapons(userid);

		if (PlayerData[userid][pAranma] > 0)
	    {
     		SendBirlikMessageEx(BIRLIK_LSPD, COLOR_DEPARTMENT, "** DEPARTMAN: All Saints Hastanesi %s adlý kiþiyi aranan olarak bildirdi.",ReturnName(userid,0));
       		SendBirlikMessageEx(BIRLIK_FBI, COLOR_DEPARTMENT, "** DEPARTMAN: All Saints Hastanesi %s adlý kiþiyi aranan olarak bildirdi.",ReturnName(userid,0));
	    }
	}
	EMSKabul[playerid] = INVALID_PLAYER_ID;
	ParaVer(playerid, 750);
	MesajGonder(playerid, "Yaralý teslim edildi, $750 kazandýnýz.");
	return 1;
}
CMD:lsmdlobi(playerid)
{
    if (!OyundaDegil(playerid)) return 1;
    if (GetFactionType(playerid) == BIRLIK_LSMD) return HataMesajGonder(playerid, "LSMD üyeleri bu komutu kullanamaz.");
    if (!IsPlayerInRangeOfPoint(playerid, 3.5, 1152.2201,-1305.1233,1019.4307)) return HataMesajGonder(playerid, "LSMD lobide deðilsiniz.");
    Dialog_Show(playerid, LSMDLobi, DIALOG_STYLE_LIST, "LSMD Lobi", "{FF8282}» {FFFFFF}Tedavi Ol\n{FF8282}» {FFFFFF}Doktor Çaðýr\n{FF8282}» {FFFFFF}Baðýmlýlýktan Kurtul", "Seç", "Kapat");
	return 1;
}
CMD:telefon(playerid)
{
	if (Jammer_Near(playerid)) return HataMesajGonder(playerid, "Sinyal yok.");
	if (PlayerData[playerid][pTelefon] == -1) return HataMesajGonder(playerid, "Telefonunuz yok.");
	if (PlayerData[playerid][pBaygin] > 0 || PlayerData[playerid][pKelepce] > 0 || PlayerData[playerid][pDrinking] > 0 || PlayerData[playerid][pHapisSure] > 0 || pbOda[playerid] != -1 || PlayerData[playerid][pSoklandi] > 0 || PetKontrol[playerid] != -1 || GetPVarInt(playerid, "IpBaglandi") == 1) return HataMesajGonder(playerid, "Telefonunuzu þu an kullanamazsýnýz.");
	Telefon_Menu(playerid);
	return 1;
}
CMD:cagrikabul(playerid)
{
	if (PlayerData[playerid][pTelefon] == -1) return HataMesajGonder(playerid, "Telefonunuz yok.");
	if (PlayerData[playerid][pAramada] != ARAMA_ARANIYOR) return HataMesajGonder(playerid, "Gelen çaðrý yok.");
	if (PlayerData[playerid][pBaygin] > 0 || PlayerData[playerid][pKelepce] > 0 || PlayerData[playerid][pDrinking] > 0 || PlayerData[playerid][pHapisSure] > 0 || pbOda[playerid] != -1 || PetKontrol[playerid] != -1 || GetPVarInt(playerid, "IpBaglandi") == 1) return HataMesajGonder(playerid, "Bunu þu an yapamazsýnýz.");
	if (!OyundaDegil(PlayerData[playerid][pCallLine]))
	{
		PlayerData[playerid][pAramada] = 0;
		PlayerData[playerid][pCallLine] = -1;
		SunucuMesaji(playerid, "Baðlantý kesildi.");
		return 1;
	}
	new target = PlayerData[playerid][pCallLine];
	PlayerData[playerid][pAramada] = ARAMA_KONUSUYOR;
	PlayerData[target][pAramada] = ARAMA_KONUSUYOR;
	MesajGonder(target, "Alýcý telefonu açtý, /cagrikapat ile çaðrýyý istediðiniz zaman sonlandýrabilirsiniz.");
	MesajGonder(playerid, "Telefonu açtýn, /cagrikapat ile çaðrýyý istediðiniz zaman sonlandýrabilirsiniz.");
	return 1;
}
CMD:cagrikapat(playerid)
{
	if (PlayerData[playerid][pTelefon] == -1) return HataMesajGonder(playerid, "Telefonunuz yok.");
	if (PlayerData[playerid][pAramada] == 0) return HataMesajGonder(playerid, "Herhangi bir aramada deðilsiniz.");
	CagriKapat(playerid);
	return 1;
}
CMD:frekans(playerid, params[])
{
	new frekans;
    if (!OyundaDegil(playerid)) return 1;
    if (PlayerData[playerid][pRadyo] != 1) return HataMesajGonder(playerid, "Portatif Radyonuz yok.");
    if (PlayerData[playerid][pBaygin] > 0 || PlayerData[playerid][pKelepce] > 0 || PlayerData[playerid][pHapisSure] > 0 || GetPVarInt(playerid, "IpBaglandi") == 1) return HataMesajGonder(playerid, "Bunu þu an yapamazsýnýz.");
    if (sscanf(params, "i", frekans)) return KullanimMesajGonder(playerid, "/frekans [Frekans] (0 yazarsanýz kapatýlýr)");
    if (frekans > 9999999 || frekans < -9999999) return HataMesajGonder(playerid, "Frekans -9999999 ile 9999999 arasýnda olmalý!");
    PlayerData[playerid][pFrekans] = frekans;
    MesajGonder(playerid, "Portatif Radyo frekansýnýzý %d kHz olarak ayarladýnýz.", frekans);
	return 1;
}

CMD:pr(playerid, params[])
{
    if (!OyundaDegil(playerid)) return 1;
    if (PlayerData[playerid][pRadyo] != 1) return HataMesajGonder(playerid, "Portatif Radyonuz yok.");
    if (PlayerData[playerid][pBaygin] > 0 || PlayerData[playerid][pKelepce] > 0 || PlayerData[playerid][pHapisSure] > 0 || GetPVarInt(playerid, "IpBaglandi") == 1) return HataMesajGonder(playerid, "Bunu þu an yapamazsýnýz.");
    if (PlayerData[playerid][pFrekans] == 0) return HataMesajGonder(playerid, "Frekansýnýz henüz ayarlanmamýþ, /frekans ile ayarlayabilirsiniz.");
    if (isnull(params)) return KullanimMesajGonder(playerid, "/pr [Mesaj]");

	new str[155], string[128];

    format(str, sizeof(str), "** (Portatif Radyo) %s: %s",ReturnName(playerid, 0), params);
    SendRadioMessage(PlayerData[playerid][pFrekans], 0x25E84fFF, str);

    format(string, sizeof string, "%s telsizinin mandalýna basarak konuþur.", ReturnName(playerid, 0));
	SetPlayerChatBubble(playerid, string, COLOR_CYAN, 25.0, 5000);
	return 1;
}

CMD:boombox(playerid, params[])
{
    if (!OyundaDegil(playerid)) return 1;
    if (PlayerData[playerid][pBoombox] != 1) return HataMesajGonder(playerid, "Müzik kutunuz yok!");
    if (PlayerData[playerid][pBaygin] > 0 || PlayerData[playerid][pKelepce] > 0 || PlayerData[playerid][pHapisSure] > 0 || GetPVarInt(playerid, "IpBaglandi") == 1) return HataMesajGonder(playerid, "Bunu þu an yapamazsýnýz.");
    new type[24], string[128];
    if (sscanf(params, "s[24]S()[128]", type, string))
	{
	    KullanimMesajGonder(playerid, "/boombox [Parametre]");
	    SendClientMessage(playerid, COLOR_YELLOW, "[PARAMETRELER]:{FFFFFF} koy, al, url");
	    return 1;
	}
	if (!strcmp(type, "koy", true))
	{
	    if (BoomboxData[playerid][boomboxPlaced])
	        return HataMesajGonder(playerid, "Zaten bir Boombox koymuþsun.");

		if (Boombox_Nearest(playerid) != INVALID_PLAYER_ID)
		    return HataMesajGonder(playerid, "Yakýnlarda müzik kutusu var, baþka bir yer seç.");

		if (IsPlayerInAnyVehicle(playerid))
		    return HataMesajGonder(playerid, "Bu komutu araçta kullanamazsýn.");

		if (GetPlayerInterior(playerid) > 0 || GetPlayerVirtualWorld(playerid) > 0) return HataMesajGonder(playerid, "Ýnterior içerisine boombox koyamazsýn.");
		Boombox_Place(playerid);

		SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s bir müzik kutusu alýr ve yere koyar.", ReturnName(playerid, 0));
		MesajGonder(playerid, "Müzik kutusunu koydun. (/boombox)");
	}
	else if (!strcmp(type, "al", true))
	{
	    if (!BoomboxData[playerid][boomboxPlaced])
	        return HataMesajGonder(playerid, "Boombox koymamýþsýnýz!");

		if (!IsPlayerInRangeOfPoint(playerid, 3.0, BoomboxData[playerid][boomboxPos][0], BoomboxData[playerid][boomboxPos][1], BoomboxData[playerid][boomboxPos][2]))
		    return HataMesajGonder(playerid, "Müzik kutusunun yakýnýnda olmalýsýnýz!");

		Boombox_Destroy(playerid);
		SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s müzik kutusunu yerden alýr.", ReturnName(playerid, 0));
	}
	else if (!strcmp(type, "url", true))
	{
	    if (sscanf(string, "s[128]", string))
	        return KullanimMesajGonder(playerid, "/boombox [url] [müzik url]");

        if (!BoomboxData[playerid][boomboxPlaced])
	        return HataMesajGonder(playerid, "Müzik kutusu koymamýþsýn.");

		if (!IsPlayerInRangeOfPoint(playerid, 3.0, BoomboxData[playerid][boomboxPos][0], BoomboxData[playerid][boomboxPos][1], BoomboxData[playerid][boomboxPos][2]))
		    return HataMesajGonder(playerid, "Müzik kutusunun yanýnda olmalýsýn.");

		Boombox_SetURL(playerid, string);
		SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s müzik kutusunu baþka bir radyo istasyonuna çevirir.", ReturnName(playerid, 0));
	}
	return 1;
}
CMD:yakital(playerid)
{
    if (!OyundaDegil(playerid)) return 1;
    new id = Pump_Closest(playerid);
    if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return HataMesajGonder(playerid, "Sürücü deðilsiniz!");
    if (UsingPumpID[playerid] != -1) return HataMesajGonder(playerid, "Zaten yakýt alýyorsunuz, /yakitiptal ile iptal edebilirsiniz.");
    if (id == -1) return HataMesajGonder(playerid, "Yakýt alma noktasýna yakýn deðilsiniz!");
    new vehicleid = GetPlayerVehicleID(playerid), vehid = Car_GetID(vehicleid);
    if (vehid == -1 || Vehicle_IsANoFuelVehicle(AracInfo[vehid][aracModel]) || AracInfo[vehid][aracBenzin] > 99.0) return HataMesajGonder(playerid, "Bu aracýn yakýta ihtiyacý yok!");
    if (Pompa[id][Pompa_Kullaniliyor]) return HataMesajGonder(playerid, "Bu gaz pompasý baþkasý tarafýndan kullanýlýyor, biraz bekleyiniz.");
    if (GetEngineStatus(vehicleid) == 1) return HataMesajGonder(playerid, "Aracýn motorunu kapatmalýsýnýz. (/motor)");
    if (PlayerData[playerid][pCash] < GetServerBilgi("BenzinFiyat")) return HataMesajGonder(playerid, "Yeterli paranýz yok!");

	UsingPumpID[playerid] = id;
    Pompa[id][Pompa_Kullaniliyor] = true;
	Pompa_Objeler(id, false);

	PlayerTextDrawSetString(playerid, FuelText[playerid], "~b~~h~Dolduruluyor...~n~~n~~w~Fiyat: ~g~~h~$0 ~y~~h~(0 L)");
	PlayerTextDrawShow(playerid, FuelText[playerid]);
	RefuelTimer[playerid] = SetTimerEx("Refuel", 500, true, "ii", playerid, vehid);

	MesajGonder(playerid, "Yakýt dolduruluyor, /yakitiptal ile iptal edebilirsiniz!");
	return 1;
}
CMD:yakitiptal(playerid)
{
	if (!OyundaDegil(playerid)) return 1;
	if (UsingPumpID[playerid] == -1) return HataMesajGonder(playerid, "Yakýt doldurmuyorsun!");
	Fuel_ResetPlayer(playerid);
	return 1;
}
CMD:kumar(playerid)
{
    if (!OyundaDegil(playerid)) return 1;
    new id = Business_Inside(playerid);
    if (id == -1 || Isyeri[id][isyeriTip] != 7) return HataMesajGonder(playerid, "Kumarhane tipi iþyerinde deðilsiniz.");
    if (PlayerData[playerid][pLevel] < 2) return HataMesajGonder(playerid, "Kumar oynamak için en az 2 seviye olmalýsýnýz.");
    Dialog_Show(playerid, Kumarhane, DIALOG_STYLE_LIST, "{808080}Kumarhane", "{808080}» {FFFFFF}Singlepair (Tek/Çift)\n{808080}» {FFFFFF}SupremeNumber\n{808080}» {FFFFFF}Zar Düellosu", "Seç", "Kapat");
	return 1;
}
CMD:dinle(playerid)
{
	if (!OyundaDegil(playerid)) return 1;
	SetPVarInt(playerid, "AjansPage", 0);
	AjansListele(playerid);
	return 1;
}
CMD:yayin(playerid, params[])
{
	if (GetFactionType(playerid) != BIRLIK_HABER) return HataMesajGonder(playerid, "Yayýn ajansýna üye deðilsiniz.");
	if (Birlikler[PlayerData[playerid][pFaction]][yayinDurum] == 0) return HataMesajGonder(playerid, "Yayýn ajansýnýzýn yayýn durumu kapalý olduðu için yayýn yapamazsýnýz.");
	if (!IsNewsVehicle(GetPlayerVehicleID(playerid))) return HataMesajGonder(playerid, "Haber tipi bir araçta deðilsiniz.");
	if (isnull(params)) return KullanimMesajGonder(playerid, "/yayin [Yazý]");
	if (strlen(params) > 64)
	{
	    foreach (new i : Player) if ((PlayerData[i][pDinle] == PlayerData[playerid][pFaction] || i == playerid) && PlayerData[i][pAyarlar][2] == 0)
	    {
	        SendClientMessageEx(i, 0x42f445FF, "[%s] %s: %.64s", Birlikler[PlayerData[playerid][pFaction]][birlikAd], ReturnName(playerid, 0), params);
		    SendClientMessageEx(i, 0x42f445FF, "...%s", params[64]);
	    }
	}
	else
	{
	    foreach (new i : Player) if ((PlayerData[i][pDinle] == PlayerData[playerid][pFaction] || i == playerid) && PlayerData[i][pAyarlar][2] == 0)
	    {
	        SendClientMessageEx(i, 0x42f445FF, "[%s] %s: %s", Birlikler[PlayerData[playerid][pFaction]][birlikAd], ReturnName(playerid, 0), params);
	    }
	}
	return 1;
}
CMD:yayinmuzik(playerid, params[])
{
    if (GetFactionType(playerid) != BIRLIK_HABER) return HataMesajGonder(playerid, "Yayýn ajansýna üye deðilsiniz.");
    if (Birlikler[PlayerData[playerid][pFaction]][yayinDurum] == 0) return HataMesajGonder(playerid, "Yayýn ajansýnýzýn yayýn durumu kapalý olduðu için yayýn yapamazsýnýz. (/birlik)");
    if (Birlikler[PlayerData[playerid][pFaction]][yayinTipi] == 0) return HataMesajGonder(playerid, "Yayýn tipi haber olduðu için müzik açamazsýnýz. (/birlik)");
    if (!IsNewsVehicle(GetPlayerVehicleID(playerid))) return HataMesajGonder(playerid, "Haber tipi bir araçta deðilsiniz.");
    if (isnull(params)) return KullanimMesajGonder(playerid, "/yayinmuzik [URL]");
    foreach (new i:Player) if ((PlayerData[i][pDinle] == PlayerData[playerid][pFaction] || i == playerid) && PlayerData[i][pAyarlar][2] == 0)
    {
        StopAudioStreamForPlayer(i);
        PlayAudioStreamForPlayer(i, params);
        SendClientMessageEx(i, 0x42f445FF, "[%s] %s yayýn müziðini deðiþtirdi.", Birlikler[PlayerData[playerid][pFaction]][birlikAd], ReturnName(playerid, 0));
    }
	return 1;
}
CMD:cekiliskatil(playerid)
{
	if (PlayerData[playerid][pDinle] == -1) return HataMesajGonder(playerid, "Herhangi bir yayýný dinlemiyorsunuz. (/dinle)");
	if (Birlikler[PlayerData[playerid][pDinle]][birlikExists] == 0 || Birlikler[PlayerData[playerid][pDinle]][birlikTip] != BIRLIK_HABER || Birlikler[PlayerData[playerid][pDinle]][CekilisBasladi] == false) return HataMesajGonder(playerid, "Dinlediðiniz yayýn ajansý çekiliþ baþlatmamýþ.");
	if (Iter_Contains(CekilisKatilimcilar[PlayerData[playerid][pDinle]], PlayerData[playerid][pID])) return HataMesajGonder(playerid, "Zaten bu çekiliþe katýlmýþsýnýz!");
	if (Iter_Count(CekilisKatilimcilar[PlayerData[playerid][pDinle]]) >= 300) return HataMesajGonder(playerid, "Çekiliþ katýlým limiti doldu.");
	Iter_Add(CekilisKatilimcilar[PlayerData[playerid][pDinle]], PlayerData[playerid][pID]);
	MesajGonder(playerid, "Çekiliþe katýldýnýz.");
	return 1;
}
CMD:reklamver(playerid)
{
	if (!OyundaDegil(playerid)) return 1;
	if (PlayerData[playerid][pTelefon] == -1) return HataMesajGonder(playerid, "Telefonunuz yok.");
	if(!IsPlayerInRangeOfPoint(playerid, 5.0, 1128.8870, -1488.9548, 22.7614))
        return HataMesajGonder(playerid, "Reklam verme alanýnda deðilsiniz.");

	SetPVarInt(playerid, "pAjansReklam", 1);
	AjansListele(playerid);
	return 1;
}
CMD:rek(playerid)
{
    if (!OyundaDegil(playerid)) return 1;

	if (PlayerData[playerid][pAdmin] < 1 && PlayerData[playerid][pHelper] < 3 && !PlayerData[playerid][pOyunGorevlisi] && !PlayerData[playerid][pForumGorevlisi]) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");

	new string[1700], sayi;
	strcat(string, "{FFFFFF}ID\t{FFFFFF}Gönderen\t{FFFFFF}Ýçerik\t{FFFFFF}Ýletiþim\n");
	for (new i; i<MAX_REKLAM; i++) if (Reklamlar[i][reklamExists])
	{
	    sayi++;
	    format(string, sizeof(string), "%s%d\t%s\t%.40s\t%d\n", string, i, SQLName(Reklamlar[i][reklamGonderen], 0), Reklamlar[i][reklamIcerik], Reklamlar[i][reklamIletisim]);
	}
	if (!sayi) return HataMesajGonder(playerid, "Hiç bekleyen reklam yok.");
	Dialog_Show(playerid, Reklamlar, DIALOG_STYLE_TABLIST_HEADERS, "{42f445}Bekleyen Reklamlar", string, "Seç", "Kapat");
	return 1;
}

CMD:yayindavet(playerid, params[])
{
    if (!OyundaDegil(playerid)) return 1;
    if (GetFactionType(playerid) != BIRLIK_HABER) return HataMesajGonder(playerid, "Yayýn ajansýna üye deðilsiniz.");
    if (Birlikler[PlayerData[playerid][pFaction]][yayinDurum] == 0) return HataMesajGonder(playerid, "Yayýn ajansýnýzýn yayýn durumu kapalý.");
    if (!IsNewsVehicle(GetPlayerVehicleID(playerid))) return HataMesajGonder(playerid, "Haber tipi bir araçta deðilsiniz.");
    new id;
    if (sscanf(params, "u", id)) return KullanimMesajGonder(playerid, "/yayindavet [ID/Isim]");
    if (!OyundaDegil(id) || !IsPlayerNearPlayer(playerid, id, 5.0)) return HataMesajGonder(playerid, "Oyuncu oyunda deðil veya kiþiye yeterince yakýn deðilsiniz.");
    if (GetPlayerVehicleID(id) != GetPlayerVehicleID(playerid)) return HataMesajGonder(playerid, "Kiþi aracýnýzda deðil.");
    if (id == playerid) return HataMesajGonder(playerid, "Kendi ID'ni yazamazsýn!");
    if (PlayerData[id][yayinKonuk] != -1)
    {
        PlayerData[id][yayinKonuk] = -1;
        SunucuMesaji(id, "%s tarafýndan yayýndan çýkarýldýn.", ReturnName(playerid, 0));
        MesajGonder(playerid, "%s adlý kiþiyi yayýndan çýkarttýnýz.", ReturnName(id, 0));
    }
    else
    {
        PlayerData[id][yayinKonuk] = playerid;
        SunucuMesaji(id, "%s adlý kiþi seni yayýna konuk olarak ekledi.", ReturnName(playerid, 0));
        MesajGonder(playerid, "%s adlý kiþiyi yayýna konuk olarak eklediniz, /yayindavet komutunu kullanarak yayýndan çýkarabilirsiniz.", ReturnName(id, 0));
    }
	return 1;
}

CMD:zarat(playerid)
{
    if (!PlayerData[playerid][pEsyalar][0])
        return HataMesajGonder(playerid, "Zarýn yok.");

	new gelensayi = RandomEx(1, 7);

	SendNearbyMessage(playerid, 30.0, COLOR_YELLOW, "* Zar attý ve '%d' geldi. (( %s ))", gelensayi, ReturnName(playerid, 0));
	return 1;
}

CMD:zarcift(playerid)
{
    if (!PlayerData[playerid][pEsyalar][0])
        return HataMesajGonder(playerid, "Zarýn yok.");

	new gelensayi = RandomEx(1, 7);
	new gelensayi2 = RandomEx(1, 7);

	SendNearbyMessage(playerid, 30.0, COLOR_YELLOW, "* 1. zarý attý ve '%d' geldi. (( %s ))", gelensayi, ReturnName(playerid, 0));
	SendNearbyMessage(playerid, 30.0, COLOR_YELLOW, "* 2. zarý attý ve '%d' geldi. (( %s ))", gelensayi2, ReturnName(playerid, 0));
	return 1;
}
CMD:zaman(playerid, params[])
{
	static
	    string[128],
		month[12],
		date[6];

	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
       	ApplyAnimation(playerid, "COP_AMBIENT", "Coplook_watch",4.1,0,0,0,0,0);
	}

	getdate(date[2], date[1], date[0]);
	gettime(date[3], date[4], date[5]);

	switch (date[1]) {
	    case 1: month = "Ocak";
	    case 2: month = "Subat";
	    case 3: month = "Mart";
	    case 4: month = "Nisan";
	    case 5: month = "Mayis";
	    case 6: month = "Haziran";
	    case 7: month = "Temmuz";
	    case 8: month = "Agustos";
	    case 9: month = "Eylul";
	    case 10: month = "Aralýk";
	    case 11: month = "Kasým";
	    case 12: month = "Aralýk";
	}
	format(string, sizeof(string), "~g~%s %02d %d~n~~r~%02d:%02d:%02d", month, date[0], date[2], date[3], date[4], date[5]);
	GameTextForPlayer(playerid, string, 6000, 1);

	return 1;
}
CMD:zarver(playerid, params[])
{
	new id;
    if (!PlayerData[playerid][pEsyalar][0]) return HataMesajGonder(playerid, "Zarýn yok.");
    if (sscanf(params, "u", id)) return KullanimMesajGonder(playerid, "/zarver [ID/Isim]");
    if (!OyundaDegil(id) || !IsPlayerNearPlayer(playerid, id, 5.0)) return HataMesajGonder(playerid, "Kiþi oyunda deðil veya yeterince yakýn deðilsiniz.");
    if (id == playerid) return HataMesajGonder(playerid, "Kendine zar veremezsin.");
    if (PlayerData[id][pEsyalar][0] != 0) return HataMesajGonder(playerid, "Bu oyuncunun zaten zarý bulunmakta.");

    PlayerData[id][pEsyalar][0] = 1;
    PlayerData[playerid][pEsyalar][0] = 0;

    SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s, %s adlý kiþiye zar verir.", ReturnName(playerid, 0), ReturnName(id, 0));
	return 1;
}
CMD:sigara(playerid)
{

	if (PlayerData[playerid][pEsyalar][1] <= 0)
        return HataMesajGonder(playerid, "Sigaran yok.");

	if (!SigaraDurum[playerid])
	{
	    MesajGonder(playerid, "Tekrar (/sigara) komutunu kullanarak sigarayý býrakabilirsiniz.");
		SetPlayerSpecialAction(playerid,SPECIAL_ACTION_SMOKE_CIGGY);
        SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "* %s sigarayý dudaklarýnýn arasýna yerleþtirir ve ateþler. ", ReturnName(playerid, 0));
        SigaraDurum[playerid] = true;
        PlayerData[playerid][pEsyalar][1]--;
	}
	else if (SigaraDurum[playerid])
	{
        SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "* %s sigarayý dudaklarýnýn arasýndan alýr ve yere atar. ", ReturnName(playerid, 0));
        SigaraDurum[playerid] = false;
	}
	return 1;
}
CMD:ipbagla(playerid, params[])
{
	new id;
    if (!OyundaDegil(playerid)) return 1;
    if (PlayerData[playerid][pLevel] < 5) return HataMesajGonder(playerid, "Bu iþlemi gerçekleþtirmek için en az 5 seviye olmalýsýnýz.");
    if (PlayerData[playerid][pEsyalar][2] <= 0) return HataMesajGonder(playerid, "Ýpiniz yok.");
	if (!IsPlayerInAnyVehicle(playerid)) return HataMesajGonder(playerid, "Bu iþlemi gerçekleþtirmek için araçta olmalýsýnýz.");
	if (sscanf(params, "u", id)) return KullanimMesajGonder(playerid, "/ipbagla [ID/Isim]");
	if (!OyundaDegil(id) || !IsPlayerNearPlayer(playerid, id, 5.0)) return HataMesajGonder(playerid, "Kiþi oyunda deðil veya yeterince yakýn deðilsiniz.");
	if (GetPlayerVehicleID(id) != GetPlayerVehicleID(playerid)) return HataMesajGonder(playerid, "Bu oyuncu aracýnýzda deðil.");
	if (id == playerid) return HataMesajGonder(playerid, "Kendi kendini baðlayamazsýn.");
	if (GetPVarInt(id, "IpBaglandi") == 1) return HataMesajGonder(playerid, "Bu oyuncu zaten baðlý.");

	new dialog[256];
    MesajGonder(playerid, "%s isimli oyuncuya ip baðlama isteði gönderdiniz.", ReturnName(id, 0));

	SetPVarInt(id, "ipIstek", playerid);
	format(dialog, sizeof dialog, "%s adlý kiþi ip baðlama isteði gönderdi, kabul ediyor musunuz?", ReturnName(playerid, 0));
	Dialog_Show(id, IP_ISTEK, DIALOG_STYLE_MSGBOX, "Ýp Baðlama", dialog, "Kabul Et", "Reddet");
	return 1;
}
CMD:ipcoz(playerid, params[])
{
    new id;
    if (!OyundaDegil(playerid)) return 1;
    if (GetPVarInt(playerid, "IpBaglandi") == 1 || GetPVarInt(playerid, "GozBaglandi") == 1 || PlayerData[playerid][pKelepce] > 0 || PlayerData[playerid][pYereYatirildi] > 0 || PlayerData[playerid][pBaygin] == 1 || PlayerData[playerid][pSoklandi] > 0) return HataMesajGonder(playerid, "Bunu þu an yapamazsýnýz.");
    if (sscanf(params, "u", id)) return HataMesajGonder(playerid, "/ipcoz [ID/Isim]");
    if (!OyundaDegil(id) || !IsPlayerNearPlayer(playerid, id, 5.0)) return HataMesajGonder(playerid, "Kiþi oyunda deðil veya yeterince yakýn deðilsiniz.");
    if (id == playerid) return HataMesajGonder(playerid, "Kendi ipini çözemezsin.");
    if (GetPVarInt(id, "IpBaglandi") == 0) return HataMesajGonder(playerid, "Bu oyuncu baðlanmamýþ.");
	if (PlayerData[id][pDraggedBy] == playerid)
	    return HataMesajGonder(playerid, "Bu oyuncuyu sürüklemeyi býrakmadan ipini çözemezsin.");

    SetPVarInt(id, "IpBaglandi", 0);

    TogglePlayerControllable(id, true);
    SetPlayerSpecialAction(id, SPECIAL_ACTION_NONE);
    MesajGonder(id, "%s adlý kiþi tarafýndan ipleriniz çözüldü.", ReturnName(playerid, 0));
    MesajGonder(playerid, "%s adlý kiþinin iplerini çözdünüz.", ReturnName(id, 0));
	return 1;
}

CMD:gozbagla(playerid, params[])
{
    new id;
    if (!OyundaDegil(playerid)) return 1;
    if (PlayerData[playerid][pLevel] < 5) return HataMesajGonder(playerid, "Bu iþlemi gerçekleþtirmek için en az 5 seviye olmalýsýnýz.");
    if (PlayerData[playerid][pEsyalar][3] <= 0) return HataMesajGonder(playerid, "Göz baðýnýz yok.");
	if (!IsPlayerInAnyVehicle(playerid)) return HataMesajGonder(playerid, "Bu iþlemi gerçekleþtirmek için araçta olmalýsýnýz.");
	if (sscanf(params, "u", id)) return KullanimMesajGonder(playerid, "/gozbagla [ID/Isim]");
	if (!OyundaDegil(id) || !IsPlayerNearPlayer(playerid, id, 5.0)) return HataMesajGonder(playerid, "Kiþi oyunda deðil veya yeterince yakýn deðilsiniz.");
	if (GetPlayerVehicleID(id) != GetPlayerVehicleID(playerid)) return HataMesajGonder(playerid, "Bu oyuncu aracýnýzda deðil.");
	if (id == playerid) return HataMesajGonder(playerid, "Kendi kendini baðlayamazsýn.");
	if (GetPVarInt(id, "GozBaglandi") == 1) return HataMesajGonder(playerid, "Bu oyuncunun gözleri zaten baðlý.");

	new dialog[256];
	MesajGonder(playerid, "%s isimli oyuncuya göz baðlama isteði gönderdiniz.", ReturnName(id, 0));

	SetPVarInt(id, "gozIstek", playerid);

	format(dialog, sizeof dialog, "%s adlý kiþi göz baðlama isteði gönderdi, kabul ediyor musunuz?", ReturnName(playerid, 0));
	Dialog_Show(id, GOZ_ISTEK, DIALOG_STYLE_MSGBOX, "Göz Baðlama", dialog, "Kabul Et", "Reddet");
	return 1;
}
CMD:gozbagicoz(playerid, params[])
{
    new id;
    if (!OyundaDegil(playerid)) return 1;
    if (GetPVarInt(playerid, "IpBaglandi") == 1 || GetPVarInt(playerid, "GozBaglandi") == 1 || PlayerData[playerid][pKelepce] > 0 || PlayerData[playerid][pYereYatirildi] > 0 || PlayerData[playerid][pBaygin] == 1 || PlayerData[playerid][pSoklandi] > 0) return HataMesajGonder(playerid, "Bunu þu an yapamazsýnýz.");
    if (sscanf(params, "u", id)) return HataMesajGonder(playerid, "/gozbagicoz [ID/Isim]");
    if (!OyundaDegil(id) || !IsPlayerNearPlayer(playerid, id, 5.0)) return HataMesajGonder(playerid, "Kiþi oyunda deðil veya yeterince yakýn deðilsiniz.");
    if (id == playerid) return HataMesajGonder(playerid, "Kendi göz baðýný çözemezsin.");
    if (GetPVarInt(id, "GozBaglandi") == 0) return HataMesajGonder(playerid, "Bu oyuncunun gözleri baðlanmamýþ.");
    SetPVarInt(id, "GozBaglandi", 0);
    MesajGonder(playerid, "%s adlý kiþinin göz baðýný çözdünüz.", ReturnName(id, 0));
    MesajGonder(id, "%s adlý kiþi tarafýndan göz baðýnýz çözüldü.", ReturnName(playerid, 0));

    TextDrawHideForPlayer(id, Karanlik);
	return 1;
}

CMD:benzinkutusu(playerid)
{
    new vehicleid = GetNearestVehicle(playerid);
	new id = Car_GetID(vehicleid);
    if (IsPlayerInAnyVehicle(playerid) || vehicleid == INVALID_VEHICLE_ID)
        return HataMesajGonder(playerid, "Herhangi bir aracýn yanýnda deðilsin.");

    if (PlayerData[playerid][pEsyalar][5] <= 0)
        return HataMesajGonder(playerid, "Benzin bidonunuz yok.");

    if (GetEngineStatus(vehicleid))
        return HataMesajGonder(playerid, "Önce motoru kapatman gereklidir.");

    if (id == -1 || AracInfo[id][aracBenzin] >= 70 || Vehicle_IsANoFuelVehicle(AracInfo[id][aracModel]))
        return HataMesajGonder(playerid, "Bu aracýn yakýta ihtiyacý yok.");

    if (GetPVarInt(playerid, "BenzinDolduruyor") == 1)
        return HataMesajGonder(playerid, "Zaten yakýt kutusunu kullanýyorsunuz.");

    SetPVarInt(playerid, "BenzinDolduruyor", 1);
    TogglePlayerControllable(playerid, false);

    PlayerData[playerid][pEsyalar][5]--;

    GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~r~Benzin Araca Dolduruluyor...", 5200, 3);
    SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s yakýt kutusunu açar ve araca doldurmaya baþlar.", ReturnName(playerid, 0));
    SetTimerEx("RefillUpdate", 5000, false, "dd", playerid, id);
	return 1;
}

CMD:barbeku(playerid, params[])
{
	if (!OyundaDegil(playerid)) return 1;
	if (PlayerData[playerid][pEsyalar][6] != 1) return HataMesajGonder(playerid, "Barbekünüz bulunmuyor.");
	if (PlayerData[playerid][pKelepce] > 0 || PlayerData[playerid][pHapisSure] > 0 || PlayerData[playerid][pSoklandi] > 0 || PlayerData[playerid][pYereYatirildi] > 0 || PlayerData[playerid][pBaygin] == 1 || PetKontrol[playerid] != -1 || pbOda[playerid] != -1 || IsPlayerInAnyVehicle(playerid))
 	return HataMesajGonder(playerid, "Þu an bu komutu kullanamazsýnýz.");
    new type[24], string[128];
    if (sscanf(params, "s[24]S()[128]", type, string))
	{
	    KullanimMesajGonder(playerid, "/barbeku [Parametre]");
	    SendClientMessage(playerid, COLOR_YELLOW, "[PARAMETRELER]:{FFFFFF} koy, al, pisir");
	    return 1;
	}
	if (!strcmp(type, "koy", true))
	{
	    if (PlayerData[playerid][pMangalKuruldu] == true) return HataMesajGonder(playerid, "Zaten barbekü kurmuþsunuz.");
	    new Float:pos[3];
	    GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
	    PlayerData[playerid][pMangalKuruldu] = true;
	    PlayerData[playerid][pYemekPisiriliyor] = 0;
	    PlayerData[playerid][pPisirilenYemek] = 0;

	    PlayerData[playerid][pMangalObject][0] = CreateDynamicObject(19831, pos[0], pos[1]+1, pos[2]-1, 0.0, 0.0, 0.0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
	    PlayerData[playerid][pMangalObject][1] = CreateDynamicObject(18688, pos[0], pos[1]+1, pos[2]-2, 0.0, 0.0, 0.0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));

	    new str[100];
	    format(str, sizeof(str), "{FF9900}[Barbekü]\n\n{FFFFFF}Oluþturan: %s", ReturnName(playerid, 0));
	    PlayerData[playerid][MangalText] = CreateDynamic3DTextLabel(str, -1, pos[0], pos[1]+1, pos[2], 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));

	    MesajGonder(playerid, "Barbekü baþarýyla kuruldu.");
	}
	if (!strcmp(type, "al", true))
	{
	    if (PlayerData[playerid][pMangalKuruldu] == false) return HataMesajGonder(playerid, "Barbekü kurmamýþsýnýz.");
	    new Float:pos[3];
        GetDynamicObjectPos(PlayerData[playerid][pMangalObject][0], pos[0], pos[1], pos[2]);
        if (!IsPlayerInRangeOfPoint(playerid, 5.0, pos[0], pos[1], pos[2])) return HataMesajGonder(playerid, "Yakýn deðilsiniz!");
	    PlayerData[playerid][pMangalKuruldu] = false;
	    PlayerData[playerid][pYemekPisiriliyor] = 0;
	    PlayerData[playerid][pPisirilenYemek] = 0;

	    DestroyDynamicObject(PlayerData[playerid][pMangalObject][0]);
	    DestroyDynamicObject(PlayerData[playerid][pMangalObject][1]);

	    DestroyDynamic3DTextLabel(PlayerData[playerid][MangalText]);

	    MesajGonder(playerid, "Barbekü kaldýrýldý.");
	}
	if (!strcmp(type, "pisir", true))
	{
	    if (PlayerData[playerid][pMangalKuruldu] == false) return HataMesajGonder(playerid, "Barbekü kurmamýþsýnýz.");
	    if (PlayerData[playerid][pPisirilenYemek] > 0) return HataMesajGonder(playerid, "Zaten yemek piþiriyorsunuz.");
	    new Float:pos[3];
	    GetDynamicObjectPos(PlayerData[playerid][pMangalObject][0], pos[0], pos[1], pos[2]);
	    if (!IsPlayerInRangeOfPoint(playerid, 5.0, pos[0], pos[1], pos[2])) return HataMesajGonder(playerid, "Barbekünüzün yakýnýnda deðilsiniz.");

	    Dialog_Show(playerid, BarbekuPisir, DIALOG_STYLE_LIST, "Et seçin:", "{FFFFFF}Köfte (%d adet)\n{FFFFFF}Tavuk Eti (%d adet)\n{FFFFFF}Dana Eti (%d adet)", "Piþir", "Kapat", PlayerData[playerid][pEsyalar][7], PlayerData[playerid][pEsyalar][8], PlayerData[playerid][pEsyalar][9]);
	}
	return 1;
}
CMD:cadir(playerid, params[])
{
    if (!OyundaDegil(playerid)) return 1;
	if (PlayerData[playerid][pEsyalar][11] != 1) return HataMesajGonder(playerid, "Çadýrýnýz yok.");
	if (PlayerData[playerid][pKelepce] > 0 || PlayerData[playerid][pHapisSure] > 0 || PlayerData[playerid][pSoklandi] > 0 || PlayerData[playerid][pYereYatirildi] > 0 || PlayerData[playerid][pBaygin] == 1 || PetKontrol[playerid] != -1 || pbOda[playerid] != -1 || GetPVarInt(playerid, "IpBaglandi") == 1)
 	return HataMesajGonder(playerid, "Þu an bu komutu kullanamazsýnýz.");
	new type[24], string[128];
    if (sscanf(params, "s[24]S()[128]", type, string))
	{
	    KullanimMesajGonder(playerid, "/cadir [Parametre]");
	    SendClientMessage(playerid, COLOR_YELLOW, "[PARAMETRELER]:{FFFFFF} koy, duzenle, al");
	    return 1;
	}
	if (!strcmp(type, "koy", true))
	{
	    if (CadirID(playerid) != -1) return HataMesajGonder(playerid, "Zaten çadýr kurmuþsunuz!");
	    if (GetPlayerInterior(playerid) > 0 || GetPlayerVirtualWorld(playerid) > 0) return HataMesajGonder(playerid, "Ýnterior içerisine çadýr koyamazsýnýz.");
	    if (IsPlayerInLosSantos(playerid)) return HataMesajGonder(playerid, "Çadýr koymak için þehrin dýþýnda olmalýsýnýz. (Dað tarzý yerler)");
	    new sonuc = Cadir_Kur(playerid);
	    if (sonuc != 1) return HataMesajGonder(playerid, "Sunucuda daha fazla çadýr oluþturulamaz.");
	    MesajGonder(playerid, "Çadýr oluþturuldu.");
	}
	if (!strcmp(type, "al", true))
	{
	    new id = CadirID(playerid);
        if (id == -1) return HataMesajGonder(playerid, "Çadýr kurmamýþsýnýz!");
        if (!IsPlayerInRangeOfPoint(playerid, 5.0, CadirData[id][cadirPos][0], CadirData[id][cadirPos][1], CadirData[id][cadirPos][2])) return HataMesajGonder(playerid, "Çadýra yakýn deðilsiniz!");
        foreach (new i:Player) if (PlayerData[i][pCadir] == id)
        {
            SetPlayerPos(i, CadirData[id][cadirPos][0], CadirData[id][cadirPos][1], CadirData[id][cadirPos][2]);
            SetPlayerInterior(i, 0);
            SetPlayerVirtualWorld(i, 0);
            PlayerData[i][pCadir] = -1;
        }
        Cadir_Sil(playerid);
        MesajGonder(playerid, "Çadýrýnýzý topladýnýz.");
	}
	if (!strcmp(type, "duzenle", true))
	{
	    new id = CadirID(playerid);
        if (id == -1) return HataMesajGonder(playerid, "Çadýr kurmamýþsýnýz!");
        if (!IsPlayerInRangeOfPoint(playerid, 5.0, CadirData[id][cadirPos][0], CadirData[id][cadirPos][1], CadirData[id][cadirPos][2])) return HataMesajGonder(playerid, "Çadýra yakýn deðilsiniz!");
        foreach (new i:Player) if (PlayerData[i][pCadir] == id)
        {
            SetPlayerPos(i, CadirData[id][cadirPos][0], CadirData[id][cadirPos][1], CadirData[id][cadirPos][2]);
			EditDynamicObject (playerid, CadirData[i][cadirPos]);
        }
        Cadir_Kur(playerid);
        MesajGonder(playerid, "Çadýrýnýzý düzenlediniz.");
	}
	return 1;
}
/*CMD:cadirgir(playerid)
{
	if (!OyundaDegil(playerid)) return 1;
	new id = Cadir_Yakin(playerid);
	if (id == -1) return HataMesajGonder(playerid, "Herhangi bir çadýra yakýn deðilsiniz.");
	if (PlayerData[playerid][pKelepce] > 0 || PlayerData[playerid][pHapisSure] > 0 || PlayerData[playerid][pSoklandi] > 0 || PlayerData[playerid][pYereYatirildi] > 0 || PlayerData[playerid][pBaygin] == 1 || PetKontrol[playerid] != -1 || pbOda[playerid] != -1 || GetPVarInt(playerid, "IpBaglandi") == 1)
 	return HataMesajGonder(playerid, "Þu an bu komutu kullanamazsýnýz.");

	SetPlayerPos(playerid, -94.3539,-28.7902,1017.2929);
	SetPlayerInterior(playerid, 0);
	SetPlayerVirtualWorld(playerid, id+65);
	ObjelerYukleniyor(playerid);
	PlayerData[playerid][pCadir] = id;
	MesajGonder(playerid, "Çadýra girdiniz, (/cadircik) ile çýkabilirsiniz.");
	return 1;
}
CMD:cadircik(playerid)
{
    if (!OyundaDegil(playerid)) return 1;
    if (PlayerData[playerid][pCadir] == -1) return HataMesajGonder(playerid, "Herhangi bir çadýrýn içerisinde deðilsiniz!");
    if (PlayerData[playerid][pKelepce] > 0 || PlayerData[playerid][pHapisSure] > 0 || PlayerData[playerid][pSoklandi] > 0 || PlayerData[playerid][pYereYatirildi] > 0 || PlayerData[playerid][pBaygin] == 1 || PetKontrol[playerid] != -1 || pbOda[playerid] != -1 || GetPVarInt(playerid, "IpBaglandi") == 1)
 	return HataMesajGonder(playerid, "Þu an bu komutu kullanamazsýnýz.");
    new id = PlayerData[playerid][pCadir];
    SetPlayerPos(playerid, CadirData[id][cadirPos][0]+2, CadirData[id][cadirPos][1]+2, CadirData[id][cadirPos][2]);
    SetPlayerInterior(playerid, 0);
    SetPlayerVirtualWorld(playerid, 0);
    ObjelerYukleniyor(playerid);
    PlayerData[playerid][pCadir] = -1;
	return 1;
}*/

CMD:tamirkiti(playerid)
{
	if (PlayerData[playerid][pEsyalar][10] <= 0)
	    return HataMesajGonder(playerid, "Hiç tamir kitiniz yok.");

	if (IsPlayerInAnyVehicle(playerid))
	    return HataMesajGonder(playerid, "Aracýn içinde tamir edemezsin.");

	if (GetPVarInt(playerid, "TamirEdiyor") == 1)
	    return HataMesajGonder(playerid, "Zaten tamir ediyorsun!");

	for (new i = 1; i != MAX_VEHICLES; i ++) if (IsValidVehicle(i) && IsPlayerNearHood(playerid, i))
	{
	    if (!IsEngineVehicle(i))
	        return HataMesajGonder(playerid, "Bu aracý tamir edemezsin.");

	    if (!GetHoodStatus(i))
	        return HataMesajGonder(playerid, "Tamir etmek için aracýn kaputu açýk olmalý.");

		PlayerData[playerid][pEsyalar][10]--;
		ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 0, 0, 0, 0, 0, 1);
		ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 0, 0, 0, 0, 0, 1);

        SetPVarInt(playerid, "TamirEdiyor", 1);
        SetTimerEx("RepairCar", 20000, false, "dd", playerid, i);

        SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s aracý tamir etmeye baþlar.", ReturnName(playerid, 0));
		GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~g~Tamir ediliyor...~w~ Bekleyiniz...", 5500, 3);
		return 1;
	}
	HataMesajGonder(playerid, "Aracýn kaputuna yakýn deðilsin.");
	return 1;
}
CMD:kampatesi(playerid)
{
    if (!OyundaDegil(playerid)) return 1;
    if (PlayerData[playerid][pKelepce] > 0 || PlayerData[playerid][pHapisSure] > 0 || PlayerData[playerid][pSoklandi] > 0 || PlayerData[playerid][pYereYatirildi] > 0 || PlayerData[playerid][pBaygin] == 1 || PetKontrol[playerid] != -1 || pbOda[playerid] != -1 || GetPVarInt(playerid, "IpBaglandi") == 1)
 	return HataMesajGonder(playerid, "Þu an bu komutu kullanamazsýnýz.");

    if (PlayerData[playerid][pKampAtesi] == false)
    {
        new Float:pos[3];
        GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
        PlayerData[playerid][pKampAtesi] = true;
        PlayerData[playerid][pKampAtesiObject] = CreateDynamicObject(19632, pos[0], pos[1], pos[2]-1, 0.0, 0.0, 0.0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
        MesajGonder(playerid, "Kamp Ateþi kuruldu, tekrar (/kampatesi) komutunu kullanarak kaldýrabilirsiniz.");
    }
    else
    {
        new Float:pos[3];
        GetDynamicObjectPos(PlayerData[playerid][pKampAtesiObject], pos[0], pos[1], pos[2]);
        if (!IsPlayerInRangeOfPoint(playerid, 3.0, pos[0], pos[1], pos[2])) return HataMesajGonder(playerid, "Kamp ateþine yakýn deðilsiniz!");
        PlayerData[playerid][pKampAtesi] = false;
        DestroyDynamicObject(PlayerData[playerid][pKampAtesiObject]);
        MesajGonder(playerid, "Kamp Ateþi kaldýrýldý.");
    }
	return 1;
}

CMD:silahial(playerid)
{
    if (!OyundaDegil(playerid)) return 1;
    if (PlayerData[playerid][pKelepce] > 0 || PlayerData[playerid][pHapisSure] > 0 || PlayerData[playerid][pSoklandi] > 0 || PlayerData[playerid][pYereYatirildi] > 0 || PlayerData[playerid][pBaygin] == 1 || PetKontrol[playerid] != -1 || pbOda[playerid] != -1 || GetPVarInt(playerid, "IpBaglandi") == 1)
 	return HataMesajGonder(playerid, "Þu an bu komutu kullanamazsýnýz.");

 	if (PlayerData[playerid][pLevel] < 7) return HataMesaji(playerid, "En az 7 seviye olmalýsýnýz.");

    new id = -1;
    for (new i; i<MAX_DROPPED_WEAPONS; i++) if (DroppedWeapon[i][droppedExists] == true && IsPlayerInRangeOfPoint(playerid, 3.0, DroppedWeapon[i][droppedPos][0], DroppedWeapon[i][droppedPos][1], DroppedWeapon[i][droppedPos][2]))
    {
        id = i;
        break;
    }
    if (id == -1) return HataMesajGonder(playerid, "Yakýnýnýzda hiç yere atýlmýþ silah yok.");
	if (GetFactionType(playerid) != BIRLIK_LSPD && (PlayerHasWeapon(playerid, DroppedWeapon[id][droppedWeapon]) || PlayerData[playerid][pSilahlar][g_aWeaponSlots[DroppedWeapon[id][droppedWeapon]]] > 0)) return HataMesajGonder(playerid, "Bu silaha sahipsiniz veya bu tür silahýnýz var.");

	SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s adlý kiþi %s model silahý yerden alýr.", ReturnName(playerid, 0), ReturnWeaponName(DroppedWeapon[id][droppedWeapon]));
	if (GetFactionType(playerid) != BIRLIK_LSPD)
	{
	 	GiveWeaponToPlayer(playerid, DroppedWeapon[id][droppedWeapon],  DroppedWeapon[id][droppedAmmo]);
	  	DropSil(id);
  	}
  	else
  	{
  	    DropSil(id);
  	}
	return 1;
}

CMD:sarjorver(playerid, params[])
{
	new id;
    if (!OyundaDegil(playerid)) return 1;
    if (PlayerData[playerid][pKelepce] > 0 || PlayerData[playerid][pHapisSure] > 0 || PlayerData[playerid][pSoklandi] > 0 || PlayerData[playerid][pYereYatirildi] > 0 || PlayerData[playerid][pBaygin] == 1 || PetKontrol[playerid] != -1 || pbOda[playerid] != -1 || GetPVarInt(playerid, "IpBaglandi") == 1)
 	return HataMesajGonder(playerid, "Þu an bu komutu kullanamazsýnýz.");

	if(PlayerData[playerid][pLevel] < 7)
	    return HataMesajGonder(playerid, "En az 7 seviye olmalýsýnýz.");

	if (GetFactionType(playerid) == BIRLIK_LSPD || GetFactionType(playerid) == BIRLIK_LSMD || GetFactionType(playerid) == BIRLIK_FBI) return HataMesajGonder(playerid, "Bu oluþum türü þarjör veremez.");
    if (PlayerData[playerid][pEsyalar] <= 0) return HataMesajGonder(playerid, "Hiç þarjörünüz yok.");
    if (sscanf(params, "u", id)) return KullanimMesajGonder(playerid, "/sarjorver [ID/Isim]");
    if (!OyundaDegil(id)) return HataMesajGonder(playerid, "Oyuncu oyunda deðil.");
    if (!IsPlayerNearPlayer(playerid, id, 5.0)) return HataMesajGonder(playerid, "Kiþiye yeterince yakýn deðilsiniz.");
    if (id == playerid) return HataMesajGonder(playerid, "Kendine þarjör veremezsin!");
    if (PlayerData[id][pEsyalar][13] > 0) return HataMesajGonder(playerid, "Bu oyuncunun zaten þarjörü var.");
 	if(PlayerData[id][pLevel] < 7)
	    return HataMesajGonder(playerid, "Karþýdaki kiþi en az 7 seviye olmalý.");

    PlayerData[id][pEsyalar][13]++;
    PlayerData[playerid][pEsyalar][13]--;
    MesajGonder(playerid, "%s adlý kiþiye þarjör verdiniz.", ReturnName(id, 0));
    MesajGonder(id, "%s adlý kiþi sana þarjör verdi.", ReturnName(playerid, 0));
	return 1;
}

CMD:uyusturucu(playerid, params[])
{
    if (IsPlayerInAnyVehicle(playerid)) return HataMesajGonder(playerid, "Araçta bu komutu kullanamazsýnýz.");
    if (isnull(params)) return KullanimMesajGonder(playerid, "/uyusturucu [kullan/ver/sat/bilgi/ek/topla]");

    if (!strcmp(params, "kullan", true)) {
    if (!OyundaDegil(playerid)) return 1;
	if (PlayerDrugData[playerid][DrugsCooldown] > gettime()) return HataMesajGonder(playerid, "Tekrar uyuþturucu kullanmak için biraz bekleyin.");
	new amount;
	if (sscanf(params, "i", amount)) return KullanimMesajGonder(playerid, "/uyusturucu [kullan] [Gram]");
	if (!(0 < amount <= 10)) return HataMesajGonder(playerid, "En az 1, en fazla 10 gram kullanabilirsiniz.");
	if (amount > PlayerDrugData[playerid][Drugs]) return HataMesajGonder(playerid,  "O kadar uyuþturucunuz yok.");
	PlayerDrugData[playerid][DrugsCooldown] = gettime() + (10 * amount);
	PlayerDrugData[playerid][Drugs] -= amount;
	PlayerDrugData[playerid][TotalUsed] += amount;
	if (PlayerDrugData[playerid][TotalUsed] >= 6 && PlayerData[playerid][pBagimlilik] == 0) PlayerData[playerid][pBagimlilik] = 1;
	PlayerData[playerid][pBagimlilikSayac][0] = -750;
	PlayerData[playerid][pBagimlilikSayac][1] = 0;
	SetPlayerWeather(playerid, 234);
	RegenTimer[playerid] = SetTimerEx("RegenHealth", 500, false, "ii", playerid, (3 * amount));
	EffectTimer[playerid] = SetTimerEx("RemoveEffects", (2 * amount) * 1000, false, "i", playerid);
	MesajGonder(playerid, "%d gram uyuþturucu kullandýnýz.", amount);
	SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "* %s adlý kiþi %d gram uyuþturucu çeker.", ReturnName(playerid, 0), amount);
    }
	else if (!strcmp(params, "ver"))
	{
    if (!OyundaDegil(playerid)) return 1;
	new id, amount;
    if (sscanf(params, "ui", id, amount)) return KullanimMesajGonder(playerid, "/uyusturucu [ver] [ID/Isim] [Gram]");
    if (id == playerid) return HataMesajGonder(playerid, "Kendine uyuþturucu veremezsin.");
    if (!OyundaDegil(id)) return HataMesajGonder(playerid, "Oyuncu oyunda deðil.");
	if (!IsPlayerNearPlayer(playerid, id, 5.0)) return HataMesajGonder(playerid, "Kiþiye yeterince yakýn deðilsiniz.");
    if (!(0 < amount <= 50)) return HataMesajGonder(playerid, "En az 1, en fazla 50 gram verebilirsiniz.");
    if (amount > PlayerDrugData[playerid][Drugs]) return HataMesajGonder(playerid, "O kadar uyuþturucunuz yok.");
    if (PlayerDrugData[id][Drugs] + amount > CARRY_LIMIT) amount = CARRY_LIMIT - PlayerDrugData[id][Drugs];
    PlayerDrugData[playerid][Drugs] -= amount;
    PlayerDrugData[playerid][TotalGiven] += amount;

	PlayerDrugData[id][Drugs] += amount;
    PlayerDrugData[id][TotalReceived] += amount;
	MesajGonder(playerid, "%s adlý kiþiye %d gram uyuþturucu verdiniz.", ReturnName(id, 0), amount);
	MesajGonder(id, "%s adlý kiþi size %d gram uyuþturucu verdi.", ReturnName(playerid, 0), amount);
	}
	else if (!strcmp(params, "sat"))
	{
    if (!OyundaDegil(playerid)) return 1;
    if (PlayerDrugData[playerid][Drugs] < 1) return HataMesajGonder(playerid, "Üzerinizde uyuþturucu yok.");
	new id, price, gram;
    if (sscanf(params, "uii", id, gram, price)) return KullanimMesajGonder(playerid, "/uyusturucu [sat] [ID/Isim] [Gram] [Fiyat]");
    if (id == playerid) return HataMesajGonder(playerid, "Kendine uyuþturucu satamazsýn.");
    if (!OyundaDegil(id)) return HataMesajGonder(playerid, "Oyuncu oyunda deðil.");
    if (!IsPlayerNearPlayer(playerid, id, 5.0)) return HataMesajGonder(playerid, "Kiþiye yeterince yakýn deðilsiniz.");
	if (IsPlayerConnected(PlayerDrugData[id][DrugsOfferedBy])) return HataMesajGonder(playerid, "Bu kiþiye zaten uyuþturucu satma isteði gönderilmiþ.");
    if (!(0 < price <= 5000)) return HataMesajGonder(playerid, "Fiyat en az 1, en fazla $7,500 olmalýdýr.");
    if (gram > PlayerDrugData[playerid][Drugs]) return HataMesajGonder(playerid, "O kadar uyuþturucunuz yok.");
    if (PlayerDrugData[id][Drugs] >= CARRY_LIMIT) return HataMesajGonder(playerid, "Bu kiþi daha fazla uyuþturucu taþýyamaz.");
    if (PlayerDrugData[id][DrugsOfferCooldown] > gettime()) return HataMesajGonder(playerid, "Bu kiþiye uyuþturucu satmak için biraz bekleyin.");
    PlayerDrugData[id][DrugsOfferedBy] = playerid;
    PlayerDrugData[id][DrugsOfferedPrice] = price;
    PlayerDrugData[id][DrugsOfferedGram] = gram;
	PlayerDrugData[id][DrugsOfferCooldown] = gettime() + OFFER_COOLDOWN;

    new string[172];
    format(string, sizeof(string), "{FFFFFF}%s sana %d gram uyuþturucu satmak istiyor.\nFiyat: {2ECC71}%s\n\nSatýn almak ister misiniz?", ReturnName(playerid, 0), gram, FormatNumber(price));
    ShowPlayerDialog(id, DIALOG_DRUG_OFFER, DIALOG_STYLE_INPUT, "Uyuþturucu Satma Ýsteði", string, "Evet", "Hayýr");

    MesajGonder(playerid, "%s adlý kiþiye uyuþturucu satma isteði gönderildi...", ReturnName(id, 0));
	}
	else if (!strcmp(params, "bilgi"))
	{
    ShowDrugStats(playerid);
 	}
		if (!strcmp(params, "ek", true)) {
        /* -- planting -- */
        if (PlayerDrugData[playerid][Seeds] < 1) return HataMesajGonder(playerid, "Uyuþturucu tohumunuz yok.");
        if (Player_PlantCount(playerid) >= PLAYER_LIMIT) return HataMesajGonder(playerid, "En fazla %d tohum ekebilirsiniz.", PLAYER_LIMIT);
        if (GetClosestPlant(playerid) != -1) return HataMesajGonder(playerid, "Yakýnlarda zaten ekilmiþ uyuþturucu tohumu var.");
        new id = Iter_Free(Plants);
        if (id == -1) return HataMesajGonder(playerid, "Uyuþturucu tohumu oluþturulamadý, daha sonra tekrar deneyin.");
        PlantData[id][plantedBy] = PlayerData[playerid][pID];
        GetPlayerPos(playerid, PlantData[id][plantX], PlantData[id][plantY], PlantData[id][plantZ]);

        PlantData[id][plantGrowth] = 0;
        PlantData[id][plantObj] = CreateDynamicObject(19473, PlantData[id][plantX], PlantData[id][plantY], PlantData[id][plantZ] - 0.70, 0.0, 0.0, 0.0);
        SetDynamicObjectMaterial(PlantData[id][plantObj], 2, 19478, "signsurf", "sign", 0xFFFFFFFF);

        new label_string[128];
        format(label_string, sizeof(label_string), "Uyuþturucu Tohumu (%d)\n\n{FFFFFF}Yerleþtiren: %s\nBüyüme: {E74C3C}0%%\n\n{FFFFFF}/uyusturucu topla", id, SQLName(PlantData[id][plantedBy], 0));
        PlantData[id][plantLabel] = CreateDynamic3DTextLabel(label_string, 0xF1C40FFF, PlantData[id][plantX], PlantData[id][plantY], PlantData[id][plantZ], 5.0);

        PlantData[id][plantTimer] = SetTimerEx("PlantGrowth", GROWTH_INTERVAL * 1000, true, "i", id);
        Iter_Add(Plants, id);

        PlayerDrugData[playerid][Seeds]--;
        PlayerDrugData[playerid][TotalPlanted]++;
        /* -- planting -- */
    }
	else if (!strcmp(params, "topla"))
	{
        /* -- harvesting -- */
        if (PlayerDrugData[playerid][Drugs] >= CARRY_LIMIT) return HataMesajGonder(playerid, "Daha fazla uyuþturucu taþýyamazsýnýz.");
        new id = GetClosestPlant(playerid);
        if (id == -1) return SendClientMessage(playerid, 0xE74C3CFF, "Herhangi bir uyuþturucu tohumuna yakýn deðilsiniz.");
        if (!PlantData[id][gotLeaves]) return HataMesajGonder(playerid, "Bu uyuþturucu tohumu büyümemiþ.");
        new harvested = PlantData[id][plantGrowth];
        if (PlayerDrugData[playerid][Drugs] + harvested > CARRY_LIMIT) harvested = CARRY_LIMIT - PlayerDrugData[playerid][Drugs];
        MesajGonder(playerid, "Uyuþturucu tohumundan %d gram uyuþturucu elde ettiniz.", harvested);

        PlayerDrugData[playerid][Drugs] += harvested;
        PlayerDrugData[playerid][TotalHarvestedPlants]++;
        PlayerDrugData[playerid][TotalHarvestedGrams] += harvested;

        new owner_id = GetPlayerIDWithSQLID(PlantData[id][plantedBy]);
        if (owner_id != -1 && owner_id != PlayerData[playerid][pID]) SunucuMesaji(owner_id, "Uyuþturucu tohumunuz baþkasý tarafýndan toplandý!");

        Plant_Destroy(id);
	}
	else
	{
        KullanimMesajGonder(playerid, "/uyusturucu [kullan/ver/sat/bilgi/ek/topla]");
    }
	return 1;
}

CMD:lspdobjekoy(playerid, params[])
{
    if (IsPlayerInAnyVehicle(playerid)) return HataMesajGonder(playerid, "Araçta bu komutu kullanamazsýnýz.");
    if (!OyundaDegil(playerid)) return 1;
 	if (GetFactionType(playerid) != BIRLIK_LSPD && GetFactionType(playerid) != BIRLIK_FBI && GetFactionType(playerid) != BIRLIK_LSMD) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
 	if (IsPlayerInAnyVehicle(playerid)) return HataMesajGonder(playerid, "Araçta bu komutu kullanamazsýnýz.");
 	if (isnull(params)) return KullanimMesajGonder(playerid, "/lspdobjekoy");
	if (PlayerData[playerid][pKelepce] > 0 || PlayerData[playerid][pHapisSure] > 0 || PlayerData[playerid][pSoklandi] > 0 || PlayerData[playerid][pYereYatirildi] > 0 || PlayerData[playerid][pBaygin] == 1 || PetKontrol[playerid] != -1 || pbOda[playerid] != -1 || GetPVarInt(playerid, "IpBaglandi") == 1)
 	return HataMesajGonder(playerid, "Þu an bu komutu kullanamazsýnýz.");
 	ShowPlayerDialog(playerid, COPOBJECTS_DIALOG, DIALOG_STYLE_LIST, "LSPD Obje Kategorileri", "Barikatlar\nTabelalar\nOlay Yeri Þeridi\nÇivi\nHýz Kamerasý", "Seç", "Kapat");
	return 1;
}
CMD:lspdobjeduzenle(playerid, params[])
{
	if (IsPlayerInAnyVehicle(playerid)) return HataMesajGonder(playerid, "Araçta bu komutu kullanamazsýnýz.");
	if (PlayerData[playerid][pAdmin] < 1 && GetFactionType(playerid) != BIRLIK_LSPD && GetFactionType(playerid) != BIRLIK_FBI && GetFactionType(playerid) != BIRLIK_LSMD) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
	if (EditingCopObjectID[playerid] != -1) return HataMesajGonder(playerid, "Zaten obje editliyorsunuz.");
	if (PlayerData[playerid][pKelepce] > 0 || PlayerData[playerid][pHapisSure] > 0 || PlayerData[playerid][pSoklandi] > 0 || PlayerData[playerid][pYereYatirildi] > 0 || PlayerData[playerid][pBaygin] == 1 || PetKontrol[playerid] != -1 || pbOda[playerid] != -1 || GetPVarInt(playerid, "IpBaglandi") == 1)
 	return HataMesajGonder(playerid, "Þu an bu komutu kullanamazsýnýz.");
	if (isnull(params)) return KullanimMesajGonder(playerid, "/lspdobjeduzenle [id]");
	new id = strval(params[0]);
	if (!(0 <= id <= MAX_COP_OBJECTS - 1)) return HataMesajGonder(playerid, "Geçersiz ID girdiniz.");
	if (!CopObjectData[id][ObjCreated]) return HataMesajGonder(playerid, "Böyle bir obje yok.");
	if (!IsPlayerInRangeOfPoint(playerid, 16.0, CopObjectData[id][ObjX], CopObjectData[id][ObjY], CopObjectData[id][ObjZ])) return HataMesajGonder(playerid, "Düzenlemek istediðiniz objeye yakýn deðilsiniz.");
    EditingCopObjectID[playerid] = id;
	EditDynamicObject(playerid, CopObjectData[id][ObjID]);
	return 1;
}
CMD:lspdobjesil(playerid, params[])
{
    if (IsPlayerInAnyVehicle(playerid)) return HataMesajGonder(playerid, "Araçta bu komutu kullanamazsýnýz.");
    if (PlayerData[playerid][pAdmin] < 1 && GetFactionType(playerid) != BIRLIK_LSPD && GetFactionType(playerid) != BIRLIK_FBI && GetFactionType(playerid) != BIRLIK_LSMD) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
	if (isnull(params)) return KullanimMesajGonder(playerid, "/lspdobjesil [ID]");
	if (PlayerData[playerid][pKelepce] > 0 || PlayerData[playerid][pHapisSure] > 0 || PlayerData[playerid][pSoklandi] > 0 || PlayerData[playerid][pYereYatirildi] > 0 || PlayerData[playerid][pBaygin] == 1 || PetKontrol[playerid] != -1 || pbOda[playerid] != -1 || GetPVarInt(playerid, "IpBaglandi") == 1)
 	return HataMesajGonder(playerid, "Þu an bu komutu kullanamazsýnýz.");
	new id = strval(params[0]);
	if (!(0 <= id <= MAX_COP_OBJECTS - 1)) return HataMesajGonder(playerid, "Geçersiz ID girdiniz.");
	if (!CopObjectData[id][ObjCreated]) return HataMesajGonder(playerid, "Böyle bir obje yok.");
	if (EditingCopObjectID[playerid] == id) return HataMesajGonder(playerid, "Düzenlediðiniz objeyi silemezsiniz.");
	CopObjectData[id][ObjCreated] = false;
	DestroyDynamicObject(CopObjectData[id][ObjID]);
	DestroyDynamic3DTextLabel(CopObjectData[id][ObjLabel]);
	if (IsValidDynamicArea(CopObjectData[id][ObjArea])) DestroyDynamicArea(CopObjectData[id][ObjArea]);
	CopObjectData[id][ObjID] = -1;
	CopObjectData[id][ObjLabel] = Text3D: -1;
	CopObjectData[id][ObjArea] = -1;
	stmt_bind_value(RemoveObject, 0, DB::TYPE_INTEGER, id);
	stmt_execute(RemoveObject);
	MesajGonder(playerid, "Obje silindi.");
	return 1;
}
CMD:elkoy(playerid, params[])
{
	new id, isim[20];
	if (!OyundaDegil(playerid)) return 1;
	if (GetFactionType(playerid) != BIRLIK_LSPD && GetFactionType(playerid) != BIRLIK_FBI) return HataMesajGonder(playerid, "Devlet memuru deðilsiniz.");
	if (PlayerData[playerid][pKelepce] > 0 || PlayerData[playerid][pHapisSure] > 0 || PlayerData[playerid][pSoklandi] > 0 || PlayerData[playerid][pYereYatirildi] > 0 || PlayerData[playerid][pBaygin] == 1 || PetKontrol[playerid] != -1 || pbOda[playerid] != -1 || GetPVarInt(playerid, "IpBaglandi") == 1)
 	return HataMesajGonder(playerid, "Þu an bu komutu kullanamazsýnýz.");
	if (sscanf(params, "us[20]", id, isim))
	{
		KullanimMesajGonder(playerid, "/elkoy [ID/Isim] [Parametre]");
	    return SendClientMessage(playerid, COLOR_YELLOW, "[PARAMETRELER]:{FFFFFF} silah, uyusturucu, ehliyet");
	}
	if (!OyundaDegil(id)) return HataMesajGonder(playerid, "Oyuncu oyunda deðil.");
	if (!IsPlayerNearPlayer(playerid, id, 3.0)) return HataMesajGonder(playerid, "Kiþiye yeterince yakýn deðilsiniz.");
	if (id == playerid) return HataMesajGonder(playerid, "Kendi ID'ni yazamazsýn!");
	if (GetPlayerSpecialAction(id) != SPECIAL_ACTION_HANDSUP && PlayerData[id][pKelepce] == 0 && PlayerData[id][pYereYatirildi] < 1 && PlayerData[id][pSoklandi] < 1) return HataMesajGonder(playerid, "Bu kiþinin elleri havada deðil veya etkisiz hale getirilmemiþ.");
	if (!strcmp(isim, "silah", true))
	{
		ResetWeapons(id);
		MesajGonder(playerid, "%s adlý kiþinin üzerindeki silahlara el koydunuz.", ReturnName(id, 0));
		SunucuMesaji(id, "%s adlý memur tarafýndan silahlarýnýza el koyuldu.", ReturnName(playerid, 0));
		SendBirlikMessageEx(BIRLIK_LSPD, COLOR_DEPARTMENT, "** DEPARTMAN: %s %s, %s adlý kiþinin üzerindeki silahlara el koydu.", Birlik_GetRutbe(playerid), ReturnName(playerid, 0), ReturnName(id, 0));
	}
	if (!strcmp(isim, "uyusturucu", true))
	{
	    if (PlayerDrugData[id][Drugs] < 1) return HataMesajGonder(playerid, "Bu oyuncunun üzerinde uyuþturucu yok.");
	    MesajGonder(playerid, "%s adlý kiþinin üzerinde bulunan uyuþturuculara el koydunuz. (%d gram uyuþturucu, %d tohum)", ReturnName(id, 0), PlayerDrugData[id][Drugs], PlayerDrugData[id][Seeds]);
	    SunucuMesaji(id, "%s adlý memur tarafýndan üzerinizdeki uyuþturuculara el koyuldu.", ReturnName(playerid, 0));
	    SendBirlikMessageEx(BIRLIK_LSPD, COLOR_DEPARTMENT, "** DEPARTMAN: %s %s, %s adlý kiþinin üzerindeki uyuþturuculara el koydu.", Birlik_GetRutbe(playerid), ReturnName(playerid, 0), ReturnName(id, 0));
	    PlayerDrugData[id][Drugs] = 0;
	    PlayerDrugData[id][Seeds] = 0;
	}
    if (!strcmp(isim, "ehliyet", true))
    {
        if (PlayerData[id][pEhliyet] != 1) return HataMesajGonder(playerid, "Bu oyuncunun ehliyeti yok.");
        PlayerData[id][pEhliyet] = 0;
        MesajGonder(playerid, "%s adlý kiþinin ehliyetine el koydunuz.", ReturnName(id, 0));
		SunucuMesaji(id, "%s adlý memur tarafýndan ehliyetinize el koyuldu.", ReturnName(playerid, 0));
		SendBirlikMessageEx(BIRLIK_LSPD, COLOR_DEPARTMENT, "** DEPARTMAN: %s %s, %s adlý kiþinin ehliyetine el koydu.", Birlik_GetRutbe(playerid), ReturnName(playerid, 0), ReturnName(id, 0));
    }
	return 1;
}


CMD:testere(playerid, params[])
{
    if (!OyundaDegil(playerid)) return 1;

 	if(PlayerData[playerid][pLevel] < 5)
		return HataMesajGonder(playerid, "Testere alabilmek için 5 level olmalýsýnýz.");

    if (IsPlayerInAnyVehicle(playerid)) return HataMesajGonder(playerid, "Araçta bu komutu kullanamazsýnýz.");
    if (!IsPlayerNearALogBuyer(playerid)) return HataMesajGonder(playerid, "Etçiye yakýn deðilsiniz.");
	if (GetPlayerMoney(playerid) < CSAW_PRICE) return HataMesajGonder(playerid, "Yeterli paranýz yok. ($%d)", CSAW_PRICE);
    if (IsPlayerHaveWeapon(playerid, WEAPON_CHAINSAW))
	    return HataMesajGonder(playerid, "Zaten testeren var.");

    ParaVer(playerid, -CSAW_PRICE);
    GiveWeaponToPlayer(playerid, WEAPON_CHAINSAW, 1);

	MesajGonder(playerid, "{2ECC71}$%d {FFFFFF}ödeyerek testere satýn aldýnýz.", CSAW_PRICE);
	return 1;
}
CMD:testeresat(playerid, params[])
{
    if (!OyundaDegil(playerid)) return 1;

    if (IsPlayerInAnyVehicle(playerid)) return HataMesajGonder(playerid, "Araçta bu komutu kullanamazsýnýz.");
    if (!IsPlayerNearALogBuyer(playerid)) return HataMesajGonder(playerid, "Etçiye yakýn deðilsiniz.");

 	if(PlayerData[playerid][pLevel] < 5)
		return HataMesajGonder(playerid, "Testere Satabilmeniz için 5 level olmalýsýnýz.");

	if (!IsPlayerHaveWeapon(playerid, WEAPON_CHAINSAW))
	    return HataMesajGonder(playerid, "Üzerinde testere yok.");

    ParaVer(playerid, CFSAW_PRICE);
    ResetWeapon(playerid, WEAPON_CHAINSAW);
	MesajGonder(playerid, "{2ECC71}$%d {FFFFFF}karþýlýðýnda testerini sattýn.", CFSAW_PRICE);
	return 1;
}
CMD:sistemler(playerid, params[])
{
MesajGonder(playerid, "Tüm sistemler, Sawyer tarafýnca yapýlmýþtýr ve tüm haklara sahiptir.");
new string[1024];
	strcat(string, "{FF2424}• {FFFFFF}Sistem Adý\tYazýlma Tarihi\tKullaným\n");
	strcat(string, "{FF2424}• {FFFFFF}Kasapçýlýk Mesleði\t{2ECC71}24.10.2020\t{E74C3C}/meslekler{FFFFFF}\n");
	strcat(string, "{FF2424}• {FFFFFF}Hurdacýlýk Mesleði\t{2ECC71}29.10.2020\t{E74C3C}/meslekler{FFFFFF}\n");
	strcat(string, "{FF2424}• {FFFFFF}Týrcýlýk Mesleði(Kaldýrýldý)\t{2ECC71}09.07.2020\t{E74C3C}/meslekler{FFFFFF}\n");
	strcat(string, "{FF2424}• {FFFFFF}Çimento Mesleði\t{2ECC71}03.05.2020\t{E74C3C}/meslekler{FFFFFF}\n");
	strcat(string, "{FF2424}• {FFFFFF}15 DK Araç Çekme\t{2ECC71}21.11.2020\t{E74C3C}/araclarim{FFFFFF}\n");
	strcat(string, "{FF2424}• {FFFFFF}Sandalye Sistemi\t{2ECC71}24.11.2020\t{E74C3C}/sandalye [1-2]{FFFFFF}\n");
	strcat(string, "{FF2424}• {FFFFFF}Gasp Sistemi\t{2ECC71}12.11.2020\t{E74C3C}/gasp [id]{FFFFFF}\n");
	strcat(string, "{FF2424}• {FFFFFF}Lojistik Sistemi(Kaldýrýldý)\t{2ECC71}25.11.2020\t{E74C3C}/lojistik{FFFFFF}\n");
	strcat(string, "{FF2424}• {FFFFFF}Ý.H.A Sistemi\t{2ECC71}21.11.2020\t{E74C3C}/iha (LSPD){FFFFFF}\n");
	strcat(string, "{FF2424}• {FFFFFF}Sex Sistemi\t{2ECC71}16.11.2020\t{E74C3C}/sex [1-7]{FFFFFF}\n");
	strcat(string, "{FF2424}• {FFFFFF}Masa Sistemi\t{2ECC71}18.11.2020\t{E74C3C}/masakur, /masakaldir{FFFFFF}\n");
	strcat(string, "{FF2424}• {FFFFFF}Yarýþ Sistemi\t{2ECC71}30.11.2020\t{E74C3C}/yaris{FFFFFF}\n");
	strcat(string, "{FF2424}• {FFFFFF}Label Sistemi\t{2ECC71}4.12.2020\t{E74C3C}/labelyarat{FFFFFF}\n");
	strcat(string, "{FF2424}• {FFFFFF}Araç Getirme Sistemi\t{2ECC71}1.12.2020\t{E74C3C}/telefon|Tarayýcý|Araç Getirme{FFFFFF}\n");
	strcat(string, "{FF2424}• {FFFFFF}Araç Satýnalma Sistemi\t{2ECC71}1.12.2020\t{E74C3C}/telefon|Tarayýcý|Araç Galerisi{FFFFFF}\n");
	strcat(string, "{FF2424}• {FFFFFF}Birlik Sistemi\t{2ECC71}1.10.2020\t{E74C3C}/birlikkur{FFFFFF}\n");
	strcat(string, "{FF2424}• {FFFFFF}TeamSpeak 3 Sistemi\t{2ECC71}1.10.2020\t{E74C3C}/ts3{FFFFFF}\n");
	strcat(string, "{FF2424}• {FFFFFF}Discord Sistemi\t{2ECC71}5.11.2020\t{E74C3C}/discord{FFFFFF}\n");
	strcat(string, "{FF2424}• {FFFFFF}DeepWeb Sistemi\t{2ECC71}1.10.2020\t{E74C3C}/telefon|Tarayýcý|DeepWeb{FFFFFF}\n");
	strcat(string, "{FF2424}• {FFFFFF}Parça Sistemi\t{2ECC71}1.10.2020\t{E74C3C}/karakter | [Parça]{FFFFFF}\n");
	strcat(string, "{FF2424}• {FFFFFF}Devamý Eklenicektir..\t{2ECC71}00.00.0000\t{FFFFFF}\n");

    Dialog_Show(playerid, Yazilan, DIALOG_STYLE_MSGBOX, "Sistemler by Regular Roleplay", string, "Tamam", "");
    return 1;
}

CMD:et(playerid, params[])
{
    if (!OyundaDegil(playerid)) return 1;

 	if(PlayerData[playerid][pLevel] < 5)
		return HataMesajGonder(playerid, "Bu mesleði yapabilmeniz için 5 level olmalýsýnýz.");

    if (isnull(params)) return BilgiMesajGonder(playerid, "/et [baþla/götür/eline al/yerden al/araçtan al/araca yükle/sat/iptal]");

	if (strcmp(params, "baþla", false) == 0)
	{
	    SetPVarInt(playerid, "OdunYolu", 1);
	    SetPlayerCheckpoint(playerid, 786.4388, -238.4743, 15.7449, 5.0);

	    BilgiMesajGonder(playerid, "inek bölgesi haritanýza iþaretlenmiþtir.");
	}

	if (strcmp(params, "götür", false) == 0)
	{
		SetPVarInt(playerid, "OdunGotur", 1);
        SetPlayerCheckpoint(playerid, 1024.3746,-316.5940,73.9889, 5.0);

        BilgiMesajGonder(playerid, "Etleri haritanýzda iþaretlenen yere götürüp Etçi'ye satabilirsiniz.");
	}

	if (strcmp(params, "araca yükle", false) == 0)
	{
	    if (!CarryingLog[playerid])
 			return HataMesajGonder(playerid, "Et taþýmýyorsunuz.");

		new id = GetNearestVehicle(playerid);

		if (GetVehicleModel(id) != 422)
			return HataMesajGonder(playerid, "Etleri yükleyebilmek için \"Bobcat\" model bir aracýn yakýnýnda olmalýsýn.");

		new Float: x, Float: y, Float: z;
    	GetVehicleBoot(id, x, y, z);

    	if (!IsPlayerInRangeOfPoint(playerid, 3.0, x, y, z))
			return HataMesajGonder(playerid, "Bobcat model aracýn arkasýnda olmalýsýn.");

		if (Vehicle_LogCount(id) >= LOG_LIMIT)
			return HataMesajGonder(playerid, "Araca daha fazla Et yüklemeyezsin.");


    	for (new i; i < LOG_LIMIT; i++)
    	{
    	    if (!IsValidDynamicObject(LogObjects[id][i]))
    	    {
    	        LogObjects[id][i] = CreateDynamicObject(2804, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
    			AttachDynamicObjectToVehicle(LogObjects[id][i], id, LogAttachOffsets[i][0], LogAttachOffsets[i][1], LogAttachOffsets[i][2], 0.0, 0.0, LogAttachOffsets[i][3]);
    			break;
    	    }
    	}


    	Streamer_Update(playerid);
    	Player_RemoveLog(playerid);
    	MesajGonder(playerid, "Araca Et koyuldu.");

    	if (Vehicle_LogCount(id) == LOG_LIMIT)
    	{
	    	BilgiMesajGonder(playerid, "Bu aracýn et alma limiti doldu, \"/et götür\" yazarak etleri götürüp satabilirsiniz.");
    	}
	}

    if (!strcmp(params, "eline al"))
	{
		if (CarryingLog[playerid]) return HataMesajGonder(playerid, "Zaten et taþýyorsunuz.");
        new id = GetClosestTree(playerid);
        if (id == -1) return HataMesajGonder(playerid, "Ete yakýn deðilsiniz.");
        if (TreeData[id][treeSeconds] < 1) return HataMesajGonder(playerid, "Bu et kesilmemiþ.");
        if (TreeData[id][treeLogs] < 1) return HataMesajGonder(playerid, "Bu ette et kalmamýþ.");
        TreeData[id][treeLogs]--;
        Tree_UpdateLogLabel(id);

        Player_GiveLog(playerid);
        MesajGonder(playerid, "Et alýndý.");
    }
	if (!strcmp(params, "yerden al"))
	{
        if (CarryingLog[playerid]) return HataMesajGonder(playerid, "Zaten et taþýyorsunuz.");
		new id = GetClosestLog(playerid);
		if (id == -1) return HataMesajGonder(playerid, "Yakýnýnda yerde olan bir et bulunamadý.");
		LogData[id][logSeconds] = 1;
		RemoveLog(id);

		Player_GiveLog(playerid);
		MesajGonder(playerid, "Yerdeki et aldýn.");
    }

    if (!strcmp(params, "araçtan al"))
    {
        if (CarryingLog[playerid]) return HataMesajGonder(playerid, "Zaten et taþýyorsunuz.");
        new id = GetNearestVehicle(playerid);

  		if (GetVehicleModel(id) != 422)
			return HataMesajGonder(playerid, "etleri alabilmek için aracýn arkasýnda olmalýsýn.");

		new Float: x, Float: y, Float: z;
    	GetVehicleBoot(id, x, y, z);

    	if (!IsPlayerInRangeOfPoint(playerid, 3.0, x, y, z))
			return HataMesajGonder(playerid, "Bobcat model aracýn arkasýnda olmalýsýn.");

		if (Vehicle_LogCount(id) < 1) return HataMesajGonder(playerid, "Araçta et yok.");

		for (new i = (LOG_LIMIT - 1); i >= 0; i--)
    	{
    	    if (IsValidDynamicObject(LogObjects[id][i]))
    	    {
    	        DestroyDynamicObject(LogObjects[id][i]);
    	        LogObjects[id][i] = -1;
    			break;
    	    }
    	}

    	Streamer_Update(playerid);
    	Player_GiveLog(playerid);
        MesajGonder(playerid, "ET alýndý.");
    }
    if (!strcmp(params, "sat"))
	{
        if (!CarryingLog[playerid]) return HataMesajGonder(playerid, "Et taþýmýyorsun.");
		if (!IsPlayerNearALogBuyer(playerid)) return HataMesajGonder(playerid, "Etçinin yakýnýnda deðilsin.");
		Player_RemoveLog(playerid);
		ParaVer(playerid, LOG_PRICE);

		MesajGonder(playerid, "Et satýldý, alýnan; $%d", LOG_PRICE);
    }
    if (!strcmp(params, "iptal"))
	{
        if (!CarryingLog[playerid]) return HataMesajGonder(playerid, "Et taþýmýyorsun.");
		Player_RemoveLog(playerid);

		MesajGonder(playerid, "Et iptal edildi ve elinizden silindi.");
    }
	return 1;
}

CMD:hurdabul(playerid)
{
	if (!OyundaDegil(playerid)) return 1;

	new id = Trash_Closest(playerid);
	if (id == -1) return HataMesajGonder(playerid, "Yakýnýnýzda hiç hurda kutusu bulunamadý.");

	callcmd::cpsifirla(playerid);

	SetPlayerCheckpoint(playerid, TrashData[id][TrashX], TrashData[id][TrashY], TrashData[id][TrashZ], 5.0);
	MesajGonder(playerid, "Hurda kutusu haritada iþaretlendi.");
	return 1;
}

CMD:hurdatopla(playerid, params[])
{
	if(IsPlayerInAnyVehicle(playerid)) return HataMesaji(playerid, "Bu komutu araçta kullanamazsýnýz.");
	new vehicleid = GetPVarInt(playerid, "LastVehicleID");
	if(GetVehicleModel(vehicleid) != 498) return HataMesaji(playerid, "Son bindiðiniz araç Boxville aracý olmalýdýr.");
    if(HasTrash[playerid]) return HataMesaji(playerid, "Zaten Hurda taþýyorsunuz.");
	new id = Trash_ClosestEx(playerid);
	if(id == -1) return HataMesaji(playerid, "Yakýnýnýzda hurda kutusu yok.");
	if(TrashData[id][TrashLevel] < 1) return HataMesaji(playerid, "Bu hurda kutusu boþ.");
    new Float: x, Float: y, Float: z;
    GetVehicleBoot(vehicleid, x, y, z);
    if(GetPlayerDistanceFromPoint(playerid, x, y, z) >= 30.0) return HataMesaji(playerid, "Yakýnýzda hurda aracý yok.");
	TrashData[id][TrashLevel]--;
	KillTimer(TrashData[id][TrashTimer]);
    TrashData[id][TrashTimer] = SetTimerEx("FillTrash", REFILL_TIME * 1000, false, "i", id);
	TrashCP[playerid] = CreateDynamicCP(x, y, z, 3.0, .playerid = playerid);
	HasTrash[playerid] = true;
	ApplyAnimation(playerid, "CARRY", "liftup105", 4.1, 0, 0, 0, 0, 0);
	SetPlayerAttachedObject(playerid, ATTACHMENT_INDEX, 1220, 6, 0.222, 0.024, 0.128, 1.90, -90.0, 0.0, 0.5,0.5, 0.5);
	Streamer_SetIntData(STREAMER_TYPE_3D_TEXT_LABEL, TrashData[id][TrashLabel], E_STREAMER_COLOR, (TrashData[id][TrashLevel] == 0) ? 0xE74C3CFF : 0xF39C12FF);
	SunucuMesaji(playerid, "Belirtilen tuþa basarak hurdayý araca býrakýn. hurdayý býrakmak için; ~k~~CONVERSATION_NO~");
	return 1;
}
CMD:cimentosat(playerid)
{
	 new para;
	 if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return HataMesajGonder(playerid, "Çimento satmak için þöför olmalýsýnýz.");
	 if(GetVehicleModel(GetPlayerVehicleID(playerid)) != 524 && GetVehicleModel(GetPlayerVehicleID(playerid)) != 520) return HataMesajGonder(playerid, "Bu araç Çimento taþýmacýlýðý için uygun deðil.");
	 if(!IsPlayerInRangeOfPoint(playerid, 5.0, -65.8820,-1120.6984,1.0781)) return HataMesajGonder(playerid, "Çimento satma noktasýna yakýn deðilsiniz.");
	 if(AracYuk[GetPlayerVehicleID(playerid)] == 0) return HataMesajGonder(playerid, "Bu araçta Çimento yok.");
	 switch(PlayerData[playerid][pTasimacilikSeviyess])
	 {
	 case 0: para = 500;
	 }
     PlayerData[playerid][pMateryal] += 50;
	 DisablePlayerCheckpoint(playerid);
	 AracYuk[GetPlayerVehicleID(playerid)] = 0;
	 AracCP[GetPlayerVehicleID(playerid)] = -1;
	 ParaVer(playerid, para);
	 MesajGonder(playerid, "Çimento teslim edildi, {2ECC71}%s {FFFFFF}Ve {2ECC71}50 {FFFFFF}Parça aldýnýz.", FormatNumber(para));
	 return 1;
}

CMD:cimentoyukle(playerid)
{
	if(!OyundaDegil(playerid)) return 1;
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return HataMesajGonder(playerid, "Çimento almak için þöför olmalýsýnýz.");
	if(GetVehicleModel(GetPlayerVehicleID(playerid)) != 524 && GetVehicleModel(GetPlayerVehicleID(playerid)) != 520) return HataMesajGonder(playerid, "Bu araç Çimento taþýmacýlýðý için uygun deðil.");
	if(!IsPlayerInRangeOfPoint(playerid, 5.0, 2151.6274,-2149.4639,13.5469)) return HataMesajGonder(playerid, "Çimento alma noktasýna yakýn deðilsiniz.");
	if(AracYuk[GetPlayerVehicleID(playerid)] == 1) return HataMesajGonder(playerid, "Bu araca zaten Çimento alýnmýþ.");
	AracYuk[GetPlayerVehicleID(playerid)] = 1;
	AracCP[GetPlayerVehicleID(playerid)] = 0;
	SetPlayerCheckpoint(playerid, CimentoCheckpoint[0][0],CimentoCheckpoint[0][1],CimentoCheckpoint[0][2], 5.0);
	MesajGonder(playerid, "Çimento yüklendi, Haritada'ki Belirtilen Noktaya Teslim Et.");
	return 1;
}

CMD:aracyukselt(playerid)
{
	if(IsVehicleBike(GetPlayerVehicleID(playerid))) return HataMesajGonder(playerid, "Bisiklet/Motor tarzý Taþýtlarýn seviyesini yükseltemezsiniz.");
    if (IsPlayerNearPNS(playerid) == -1) return HataMesaji(playerid, "Tamirhane noktasýna yakýn deðilsiniz.");
    if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return HataMesajGonder(playerid, "Þöför olmalýsýnýz.");
    new id = Car_GetID(GetPlayerVehicleID(playerid));
    if(AracInfo[id][aracSeviye] >= 5) return HataMesajGonder(playerid, "Bu araç zaten son seviye yükseltmeye sahip.");
    Dialog_Show(playerid, AracYukselt, DIALOG_STYLE_MSGBOX, "Araç Yükselt", "%s model aracýnýzý $%d karþýlýðýnda %d. seviyeye yükseltmek ister misiniz?", "Evet", "Hayýr", ReturnVehicleModelName(GetVehicleModel(GetPlayerVehicleID(playerid))), YukseltmeFiyat(AracInfo[id][aracSeviye] + 1), AracInfo[id][aracSeviye] + 1);
	return 1;
}

CMD:araczirhlat(playerid)
{
    if (!OyundaDegil(playerid)) return 1;
    if (IsPlayerNearPNS(playerid) == -1) return HataMesaji(playerid, "Tamirhane noktasýna yakýn deðilsiniz.");
    if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return HataMesajGonder(playerid, "Þöför olmalýsýnýz.");
    new id = Car_GetID(GetPlayerVehicleID(playerid));
    if (id == -1 || AracInfo[id][aracTip] != 4 || AracInfo[id][aracSahip] <= 0 || AracInfo[id][aracModel] == 509) return HataMesajGonder(playerid, "Bu araca zýrh takýlamaz.");
    if (AracInfo[id][aracZirh] >= 50 || AracInfo[id][aracZirhVarMi] == 1) return HataMesajGonder(playerid, "Bu araç zaten zýrhlý.");
    Dialog_Show(playerid, AracZirhlat, DIALOG_STYLE_MSGBOX, "Araç Zýrhlat", "{2ECC71}$38,984 {FFFFFF}ödeyerek aracýnýzý zýrhlatmak istediðinize emin misiniz?", "Zýrhlat", "Kapat");
	return 1;
}
CMD:taksiplakasi(playerid)
{
    if (!OyundaDegil(playerid)) return 1;
    if (IsPlayerNearPNS(playerid) == -1) return HataMesaji(playerid, "Tamirhane noktasýna yakýn deðilsiniz.");
    if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return HataMesajGonder(playerid, "Þöför olmalýsýnýz.");
    new vehicleid = GetPlayerVehicleID(playerid);
    new id = Car_GetID(vehicleid);
    if (id == -1 || AracInfo[id][aracTip] != 4 || AracInfo[id][aracSahip] <= 0 || !IsEngineVehicle(vehicleid) || IsVehicleBike(vehicleid) || GetVehicleMaxSeats(vehicleid) < 4) return HataMesajGonder(playerid, "Bu araca taksi plakasý takýlamaz.");
    if (AracInfo[id][TaksiPlaka] == 1) return HataMesajGonder(playerid, "Bu aracýn zaten taksi plakasý var.");
    Dialog_Show(playerid, TaksiPlaka, DIALOG_STYLE_MSGBOX, "Taksi Plakasý", "{2ECC71}$23,652 {FFFFFF}ödeyerek aracýnýza taksi plakasý taktýrmak istediðinize emin misiniz?", "Evet", "Hayýr");
	return 1;
}

CMD:garaj(playerid)
{
    if (!OyundaDegil(playerid)) return 1;
    new id = (Garage_Nearest(playerid) != -1) ? (Garage_Nearest(playerid)) : (Garage_Inside(playerid));
    if (id == -1) return HataMesajGonder(playerid, "Herhangi bir garaja yakýn veya içerisinde deðilsiniz!");
    if (GarageData[id][gSahip] != PlayerData[playerid][pID] && PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Bu garajýn sahibi deðilsin!");
   	new str[250], sifre[30];
    if (strcmp(GarageData[id][gSifre], "Yok", true) == 0) sifre = "-";
    else format(sifre, sizeof(sifre), GarageData[id][gSifre]);
    SetPVarInt(playerid, "GarajID", id);
    strcat(str, "Ýþlem\tDurum\n");
    format(str, sizeof(str), "%s{FFFFFF}Garaj Kilit Durumu\t%s\n{FFFFFF}Garaj Þifre\t{e5d60b}%s\n{FFFFFF}Garaj Park Durumu\t%s\n{FFFFFF}Park Edilen Araçlar",
	str, (GarageData[id][gKilit] == 1) ? ("{ff0000}Kilitli") : ("{83e50b}Açýk"), sifre, (GarageData[id][gParkDurum]) ? ("{83e50b}Açýk") : ("{ff0000}Kapalý"));
    Dialog_Show(playerid, GarajAyarlar, DIALOG_STYLE_TABLIST_HEADERS, "Garaj", str, "Seç", "Kapat");
	return 1;
}
CMD:petlerim(playerid)
{
	new string[500],sayi;
	strcat(string, "ID\tPet Adý\tDurum\n");
	foreach (new i: Petler)
	{
	    if (PetBilgi[i][petSahip] == PlayerData[playerid][pID])
	    {
	        format(string, sizeof(string), "%s%d\t%s\t%s\n",string,i,PetBilgi[i][petAdi], (PetBilgi[i][petDurum] == false) ? ("{ff0000}Gizli") : ("{00ff33}Aktif"));
	        sayi++;
	    }
	}
	if (sayi == 0) return HataMesajGonder(playerid, "Hiç petiniz yok.");
	ShowPlayerDialog(playerid, DIALOG_PETLERIM, DIALOG_STYLE_TABLIST_HEADERS, "Petleriniz", string, "Deðiþtir", "Kapat");
	return 1;
}
CMD:pet(playerid)
{
    if (PetKontrol[playerid] != -1)
	{
	    new Float:pos[4], Float:can;
	    GetPlayerHealth(playerid, can);
	    GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
	    GetPlayerFacingAngle(playerid, pos[3]);
	    FCNPC_SetPosition(PetBilgi[PetKontrol[playerid]][NPCID], pos[0], pos[1], pos[2]);
        FCNPC_SetAngle(PetBilgi[PetKontrol[playerid]][NPCID], pos[3]);
	    FCNPC_SetVirtualWorld(PetBilgi[PetKontrol[playerid]][NPCID], GetPlayerVirtualWorld(playerid));
	    FCNPC_SetInterior(PetBilgi[PetKontrol[playerid]][NPCID], GetPlayerInterior(playerid));
	    FCNPC_SetHealth(PetBilgi[PetKontrol[playerid]][NPCID], can);
	    FCNPC_SetInvulnerable(PetBilgi[PetKontrol[playerid]][NPCID], true);
	    SetPlayerSkin(playerid, GetPVarInt(playerid, "LastSkin"));
	    SetPlayerPos(playerid, LastPos[playerid][0], LastPos[playerid][1], LastPos[playerid][2]);
	    SetPlayerInterior(playerid, GetPVarInt(playerid, "LastInterior"));
	    SetPlayerVirtualWorld(playerid, GetPVarInt(playerid, "LastVw"));
	    SetPlayerHealth(playerid, GetPVarFloat(playerid, "LastHealth"));
	    SetPlayerArmour(playerid, GetPVarFloat(playerid, "LastArmour"));

	    DeletePVar(playerid, "LastSkin");
	    LastPos[playerid][0] = 0.0;
	    LastPos[playerid][1] = 0.0;
	    LastPos[playerid][2] = 0.0;
	    DeletePVar(playerid, "LastInterior");
	    DeletePVar(playerid, "LastVw");
	    DeletePVar(playerid, "LastHealth");
	    DeletePVar(playerid, "LastArmour");
        PetKontrol[playerid] = -1;
	    return 1;
	}
	if (PlayerData[playerid][pKelepce] > 0 || PlayerData[playerid][pHapisSure] > 0 || PlayerData[playerid][pSoklandi] > 0 || PlayerData[playerid][pYereYatirildi] > 0 || PlayerData[playerid][pBaygin] == 1 || pbOda[playerid] != -1)
 	return HataMesajGonder(playerid, "Þu an bu komutu kullanamazsýnýz.");
	new id = PetYakin(playerid, 7.0);
	if (id == -1) return HataMesajGonder(playerid, "Yakýnýnýzda sahip olduðunuz pet yok.");
	PetDialog(playerid, id);
	return 1;
}
CMD:petolustur(playerid, params[])
{
	new petsahip, petturu, petcinsiyet;
	if (PlayerData[playerid][pAdmin] < 3) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
	if (sscanf(params, "uii", petsahip, petturu, petcinsiyet)) return KullanimMesajGonder(playerid, "/petolustur [Sahip] [Pet Türü 1-11] [Pet Cinsiyet 1- Erkek 2- Kadýn]");
	if (!OyundaDegil(petsahip)) return HataMesajGonder(playerid, "Oyuncu oyunda deðil.");
	if (petturu > 11) return HataMesajGonder(playerid, "Geçersiz pet türü.");
	if (petcinsiyet > 2) return HataMesajGonder(playerid, "Cinsiyet 1 veya 2 olmalýdýr. 1- erkek 2- kadýn");
	new id = Pet_Olustur(PlayerData[petsahip][pID], petturu, petcinsiyet);
	if (id == -1) return HataMesajGonder(playerid, "Pet oluþturulamadý.");
	MesajGonder(playerid, "Pet oluþturuldu. ID: %d", id);
	return 1;
}
CMD:petsil(playerid, params[])
{
	new id;
    if (PlayerData[playerid][pAdmin] < 3) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
    if (sscanf(params, "i", id)) return KullanimMesajGonder(playerid, "/petsil [ID]");
    if (!Iter_Contains(Petler, id)) return HataMesajGonder(playerid, "Geçersiz ID girdiniz.");

    Pet_Sil(id);
    MesajGonder(playerid, "Pet silindi.");
	return 1;
}
CMD:petgizle(playerid, params[])
{
    new id;
    if (PlayerData[playerid][pAdmin] < 1) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
    if (sscanf(params, "i", id)) return KullanimMesajGonder(playerid, "/petgizle [ID]");
    if (!Iter_Contains(Petler, id)) return HataMesajGonder(playerid, "Geçersiz ID girdiniz.");
    if (PetBilgi[id][petDurum] == false) return HataMesajGonder(playerid, "Bu pet zaten gizlenmiþ.");
    PetBilgi[id][petSaglik] = FCNPC_GetHealth(PetBilgi[id][NPCID]);
   	FCNPC_Destroy(PetBilgi[id][NPCID]);
    PetBilgi[id][petTakip] = -1;
    PetBilgi[id][NPCID] = -1;
    PetBilgi[id][petDurum] = false;
    DestroyDynamic3DTextLabel(PetBilgi[id][petText]);
	return 1;
}
CMD:oocmarket(playerid)
{
	if (!OyundaDegil(playerid)) return 1;
    mysql_tquery(g_SQL, "SELECT * FROM `oocmarket`", "OOCMarket", "d", playerid);
    HataMesajGonder(playerid, "Þuan web sitemizde Paywant ödeme sistemi bulunmadýðý için para yatýrma iþlemlerinizi Discord üzerinden Sawyer#6969 yaptýrabilrisiniz Çok yakýnda Paywant getirilecektir");
	return 1;
}
CMD:vipmenu(playerid)
{
    if (!OyundaDegil(playerid)) return 1;
    if (PlayerData[playerid][pVip] < 1) return HataMesajGonder(playerid, "V.I.P deðilsiniz. (/oocmarket)");
    HataMesajGonder(playerid, "Þuan web sitemizde Paywant ödeme sistemi bulunmadýðý için para yatýrma iþlemlerinizi Discord üzerinden Sawyer#6969 yaptýrabilrisiniz Çok yakýnda Paywant getirilecektir");
    VipMenu(playerid);
	return 1;
}
CMD:vipdolap(playerid)
{
    if (!OyundaDegil(playerid)) return 1;
    if (PlayerData[playerid][pVip] < 1) return HataMesajGonder(playerid, "V.I.P deðilsiniz. (/oocmarket)");
    if (IsPlayerInRangeOfPoint(playerid, 50.0, 2384.5806,2148.4338,1001.0859) || IsPlayerInRangeOfPoint(playerid, 50, 2384.5806,2148.4338,1001.0859))
    {
        VipDolap(playerid);
    }
    else HataMesajGonder(playerid, "VIP Lounge'da deðilsin!");
	return 1;
}
CMD:maske(playerid)
{
    if (!OyundaDegil(playerid)) return 1;
    if (PlayerData[playerid][pKelepce] > 0 || PlayerData[playerid][pHapisSure] > 0 || PlayerData[playerid][pSoklandi] > 0 || PlayerData[playerid][pYereYatirildi] > 0 || PlayerData[playerid][pBaygin] == 1 || PetKontrol[playerid] != -1 || pbOda[playerid] != -1 || GetPVarInt(playerid, "IpBaglandi") == 1)
 	return HataMesajGonder(playerid, "Þu an bu komutu kullanamazsýnýz.");
    if (PlayerData[playerid][pMaskeHakki] == 0 && PlayerData[playerid][pVip] < 2) return HataMesajGonder(playerid, "Maske kullaným hakkýnýz veya Silver VIP paketiniz yok. (/oocmarket)");
    if (PlayerData[playerid][pEsyalar][4] == 0) return HataMesajGonder(playerid, "Maskeniz yok.");
    if (PlayerData[playerid][pMaske] == false)
    {
        if (!PlayerData[playerid][pMaskeID])
			PlayerData[playerid][pMaskeID] = random(90000) + 10000;

		PlayerData[playerid][pMaske] = true;
        SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s maskeyi yüzüne takar.", ReturnName(playerid, 0, -1));
    }
    else
    {
        SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s yüzündeki maskeyi çýkartýr.", ReturnName(playerid, 0, -1));
        PlayerData[playerid][pMaske] = false;
    }
	return 1;
}
CMD:ozelmodel(playerid)
{
    if (!OyundaDegil(playerid)) return 1;
    if (PlayerData[playerid][pKelepce] > 0 || PlayerData[playerid][pHapisSure] > 0 || PlayerData[playerid][pSoklandi] > 0 || PlayerData[playerid][pYereYatirildi] > 0 || PlayerData[playerid][pBaygin] == 1 || PetKontrol[playerid] != -1 || pbOda[playerid] != -1 || GetPVarInt(playerid, "IpBaglandi") == 1)
 	return HataMesajGonder(playerid, "Þu an bu komutu kullanamazsýnýz.");
    OzelModelListele(playerid);
	return 1;
}
CMD:ayarlar(playerid)
{
    if (!OyundaDegil(playerid)) return 1;
    Dialog_Show(playerid, AyarlarGiris, DIALOG_STYLE_PASSWORD, "Ayarlar", "{FFFFFF}Ayarlar bölümüne eriþmek için karakterinizin þifresini girmelisiniz:", "Devam", "Kapat");
	return 1;
}

CMD:graffiti(playerid, params[])
{
    if (!OyundaDegil(playerid)) return 1;
    if (IsPlayerInAnyVehicle(playerid)) return HataMesajGonder(playerid, "Araçta bu komutu kullanamazsýnýz!");
    if (PlayerData[playerid][pFaction] == -1 || Birlikler[PlayerData[playerid][pFaction]][birlikOnaylar][3] == 0) return HataMesajGonder(playerid, "Graffiti onaylý bir birliðin üyesi deðilsiniz.");

    if (GetPlayerInterior(playerid) > 0 || GetPlayerVirtualWorld(playerid) > 0)
        return HataMesajGonder(playerid, "Ýnterior içerisine graffiti oluþturamazsýn!");

    if (PlayerData[playerid][pGraffiti] == 1) return HataMesajGonder(playerid, "Zaten graffiti oluþturuyorsun!");

    PlayerData[playerid][pGraffiti] = 1;
    Dialog_Show(playerid, Graffiti, DIALOG_STYLE_INPUT, "Graffiti ~ Yazý", "{FFFFFF}Lütfen graffiti yazýsýný girin.\n{FFFFFF}Yazý içerisinde #renk ile renklendirme yapabilirsiniz. (#kirmizi, #mavi vs.)\n{ff0000}Not: {FFFFFF}Yazý 64 karakteri geçemez.", "Devam", "Kapat");
    return 1;
}

CMD:chattemizle(playerid, params[])
{
    for (new i = 0; i < 50; i ++) {
        SendClientMessage(playerid, -1, "");
    }
    return 1;
}
CMD:id(playerid, params[])
{
    if (!OyundaDegil(playerid)) return 1;
    if (isnull(params))
        return KullanimMesajGonder(playerid, "/id [ID/Isim]");

    if (strlen(params) < 3)
        return HataMesajGonder(playerid, "En az 3 karakter belirtmelisiniz.");

    new count;
 	foreach (new i : Player)
    {
        if (strfind(ReturnName(i), params, true) != -1)
        {
            SendClientMessageEx(playerid, COLOR_WHITE, "** %s - ID: %d", ReturnName(i), i);
            count++;
        }
    }
    if (!count)
        return HataMesajGonder(playerid, "Bu kriterlerde hiçbir oyuncu bulunamadý: \"%s\".", params);

    return 1;
}

CMD:destek(playerid, params[]) // stock çekilecek
{
    Dialog_Show(playerid, Destek, DIALOG_STYLE_LIST, "{808080}Yardým Paneli", "{00FF00}•{FFFFFF} Bug kurtar\n{00FF00}•{FFFFFF} Ýnterior dedektör\n{00FF00}•{FFFFFF} Soru/Bug talebi\n{FF0000}•{FFFFFF} Talep iptal", "Seç", "Kapat");
    return 1;
}

CMD:pdyardim(playerid)
{
	if (GetFactionType(playerid) != BIRLIK_LSPD)
	    return HataMesajGonder(playerid, "Devlet memuru deðilsin.");

	SendClientMessage(playerid, 0x8D8DFFFF, "[LSPD] {FFFFFF}/t /d /f /(m)egafon /sm /mdc /aracaat /hapseat /rozetgoster");
	SendClientMessage(playerid, 0x8D8DFFFF, "[LSPD] {FFFFFF}/ustunuara /gov /kapiyikir /rozet /op /yt /elkoy /surukle /jammer /dashcamlimit");
	SendClientMessage(playerid, 0x8D8DFFFF, "[LSPD] {FFFFFF}/taser /aracicek /aracicekmeyibirak /aracibagla /cctv /cctvcik /birimler");
	SendClientMessage(playerid, 0x8D8DFFFF, "[LSPD] {FFFFFF}/dolap /siren /objekoy /objesil /objeduzenle /destekiste /destekkapat");
	SendClientMessage(playerid, 0x8D8DFFFF, "[LSPD] {FFFFFF}/flasor /siren /yereyatir /bagaj /kelepce /kelepcecikar /callsign /uydu /drone /iha");
	return 1;
}

CMD:karakter(playerid)
{
	if (!OyundaDegil(playerid)) return 1;
	ShowStats(playerid, playerid);
	return 1;
}

CMD:masakur(playerid, params[])
{
	new
	    userid, Float:oPos[4];

	new obje = 1825;
	if(IsValidDynamicObject(SandalyeObjem[playerid])) return HataMesajGonder(playerid, "Zaten bir adet masa sandalye kurmuþsunuz, daha fazla kuramazsýnýz. (/masakaldir).");
	GetPlayerPos(playerid, oPos[0], oPos[1], oPos[2]);
	SandalyeObjem[playerid] = CreateDynamicObject(obje, oPos[0], oPos[1], oPos[2] - 1.0, 0.0, 0.0, 0.0 - 1.5);
	SunucuMesaji(playerid, "Bulunduðunuz bölgeye masa sandalye kurdunuz, kaldýrmak için (/masakaldir).");
	return 1;
}

CMD:masakaldir(playerid, params[])
{
	if(!IsValidDynamicObject(SandalyeObjem[playerid])) return HataMesajGonder(playerid, "Kurmuþ olduðunuz masa sandalye bulunamadý. Kurmak için (/masakur).");
	DestroyDynamicObject(SandalyeObjem[playerid]);
	SunucuMesaji(playerid, "Kurduðunuz sandalye kaldýrýldý, tekrar kurmak için (/masakur).");
	return 1;
}

CMD:paraver(playerid, params[])
{
    static
        userid,
        amount;

    if (!OyundaDegil(playerid)) return 1;

    if (sscanf(params, "ud", userid, amount))
        return KullanimMesajGonder(playerid, "/paraver [id/isim] [miktar]");

    if (!OyundaDegil(userid) || !IsPlayerNearPlayer(playerid, userid, 5.0))
        return HataMesajGonder(playerid, "Oyuncu oyunda deðil veya sana yeterince yakýn deðil.");

    if (GetPlayerState(userid) == PLAYER_STATE_SPECTATING)
        return HataMesajGonder(playerid, "Oyuncu oyunda deðil veya sana uzak.");

    if (userid == playerid)
        return HataMesajGonder(playerid, "Kendine para veremezsin.");

    if (amount < 1)
        return HataMesajGonder(playerid, "En az $1 verebilirsin.");

    if (amount > 100 && PlayerData[playerid][pOynamaSaati] < 5)
        return HataMesajGonder(playerid, "Para verebilmek için 5 saat oynamalýsýn.");

	if (PlayerData[playerid][pLevel] < 2) return HataMesajGonder(playerid, "2 level ve üzeri olman gerekiyor.");

    if (amount > PlayerData[playerid][pCash])
        return HataMesajGonder(playerid, "Bu kadar paran yok.");

    ParaVer(playerid, -amount);
    ParaVer(userid, amount);

    SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s cebinden $%d para çýkartýr ve %s adlý kiþiye verir.", ReturnName(playerid, 0), amount, ReturnName(userid, 0));
    Log_Write("logs/pay_log.txt", "[%s] %s (%s), %s miktar parayi %s (%s) adli kisiye verir.", ReturnDate(), ReturnName(playerid), GetIP(playerid),amount, Player_GetName(userid), GetIP(userid));
    return 1;
}

CMD:harita(playerid)
{
	if (!OyundaDegil(playerid)) return 1;
	Dialog_Show(playerid, GPS, DIALOG_STYLE_LIST,  "Harita", "{38c5f7}» {FFFFFF}Global Lokasyonlar\n{38c5f7}» {FFFFFF}Ev Bul\n{38c5f7}» {FFFFFF}Ýþyeri Bul\n{38c5f7}» {FFFFFF}Bina Bul", "Seç", "Geri");
	return 1;
}

CMD:gps(playerid)
{
	if (!OyundaDegil(playerid)) return 1;
	if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return HataMesajGonder(playerid, "Sürücü olmalýsýnýz.");
	Dialog_Show(playerid, GPS, DIALOG_STYLE_LIST, "Küresel Konumlama Sistemi", "{FFFFFF}Global Lokasyonlar\nEv Bul\nÝþyeri Bul\nBina Bul", "Seç", "Geri");
	return 1;
}

CMD:cpsifirla(playerid)
{
    if (!OyundaDegil(playerid)) return 1;
	if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER && (AracYuk[GetPlayerVehicleID(playerid)] == 1)) return HataMesajGonder(playerid, "Bunu þu an yapamazsýnýz.");
	PlayerData[playerid][pTaksiKabul] = -1;
	DisablePlayerCheckpoint(playerid);

	AracYuk[GetPlayerVehicleID(playerid)] = 0;
	AracCP[GetPlayerVehicleID(playerid)] = -1;

	EMSKabul[playerid] = INVALID_PLAYER_ID;

	SetPVarInt(playerid, "EvBuluyor", -1);
	SetPVarInt(playerid, "IsyeriBuluyor", -1);
	SetPVarInt(playerid, "BinaBuluyor", -1);

	PlayerData[playerid][pGPS] = -1;

	DeletePVar(playerid, "AraciniBuluyor");
	SetPVarInt(playerid, "AracSakliyor", -1);

	PlayerTextDrawHide(playerid, MesafeTD[playerid]);

	MeslekCP[playerid] = -1;

	DisablePlayerCheckpoint(playerid);
	return 1;
}
CMD:ustunuara(playerid, params[])
{
    static
        userid;

    if (!OyundaDegil(playerid)) return 1;

    if (sscanf(params, "u", userid))
        return KullanimMesajGonder(playerid, "/ustunuara [id/isim]");

    if (!OyundaDegil(userid) || !IsPlayerNearPlayer(playerid, userid, 6.0))
        return HataMesajGonder(playerid, "Belirtilen oyuncu aktif deðil ya da size yakýn deðil.");

    if (userid == playerid)
        return HataMesajGonder(playerid, "Kendi üstünü arayamazsýn.");

    PlayerData[userid][pFriskOffer] = playerid;

    MesajGonder(userid, "%s üstünü aramak istiyor. (\"/kabulet arama\").", ReturnName(playerid, 0));
    MesajGonder(playerid, "%s adlý oyuncuya üstünü arama isteði gönderildi.", ReturnName(userid, 0));
    return 1;
}
CMD:tokalas(playerid, params[])
{
    static
        userid,
        type;

    if (!OyundaDegil(playerid)) return 1;

    if (PlayerData[playerid][pKelepce] > 0 || PlayerData[playerid][pHapisSure] > 0 || PlayerData[playerid][pSoklandi] > 0 || PlayerData[playerid][pYereYatirildi] > 0 || PlayerData[playerid][pBaygin] == 1 || PetKontrol[playerid] != -1 || pbOda[playerid] != -1 || GetPVarInt(playerid, "IpBaglandi") == 1)
 	return HataMesajGonder(playerid, "Þu an bu komutu kullanamazsýnýz.");

    if (sscanf(params, "ud", userid, type))
        return KullanimMesajGonder(playerid, "/tokalas [id/isim] [tip]");

    if (!IsPlayerConnected(userid) || !IsPlayerNearPlayer(playerid, userid, 6.0))
        return HataMesajGonder(playerid, "Belirtilen oyuncu oyunda deðil veya size yakýn deðil.");

    if (userid == playerid)
        return HataMesajGonder(playerid, "Kendi elinle tokalaþamazsýn.");

    if (PlayerData[userid][pKelepce] > 0 || PlayerData[userid][pHapisSure] > 0 || PlayerData[userid][pSoklandi] > 0 || PlayerData[userid][pYereYatirildi] > 0 || PlayerData[userid][pBaygin] == 1 || PetKontrol[userid] != -1 || pbOda[userid] != -1 || GetPVarInt(userid, "IpBaglandi") == 1)
 	return HataMesajGonder(playerid, "Bu kiþi ile tokalaþamazsýn!");

    if (type < 1 || type > 6)
        return HataMesajGonder(playerid, "Tip 1-6 arasýnda olmasý gerekir.");

    PlayerData[userid][pShakeOffer] = playerid;
    PlayerData[userid][pShakeType] = type;

    MesajGonder(userid, "%s seninle tokalaþmak istiyor. (\"/kabulet tokalasma\").", ReturnName(playerid, 0));
    MesajGonder(playerid, "%s adlý oyuncuya tokalaþma isteði yolladýn.", ReturnName(userid, 0));
    return 1;
}
CMD:sex(playerid, params[])
{
    static
        userid,
        type;

    if (!OyundaDegil(playerid)) return 1;

    if (PlayerData[playerid][pKelepce] > 0 || PlayerData[playerid][pHapisSure] > 0 || PlayerData[playerid][pSoklandi] > 0 || PlayerData[playerid][pYereYatirildi] > 0 || PlayerData[playerid][pBaygin] == 1 || PetKontrol[playerid] != -1 || pbOda[playerid] != -1 || GetPVarInt(playerid, "IpBaglandi") == 1)
 	return HataMesajGonder(playerid, "Þu an bu komutu kullanamazsýnýz.");

    if (sscanf(params, "ud", userid, type))
        return KullanimMesajGonder(playerid, "/sex [id/isim] [tip]");

    if (!IsPlayerConnected(userid) || !IsPlayerNearPlayer(playerid, userid, 6.0))
        return HataMesajGonder(playerid, "Belirtilen oyuncu oyunda deðil veya size yakýn deðil.");

    if (userid == playerid)
        return HataMesajGonder(playerid, "Kendinle Sex yapamazsýn.");

    if (PlayerData[userid][pKelepce] > 0 || PlayerData[userid][pHapisSure] > 0 || PlayerData[userid][pSoklandi] > 0 || PlayerData[userid][pYereYatirildi] > 0 || PlayerData[userid][pBaygin] == 1 || PetKontrol[userid] != -1 || pbOda[userid] != -1 || GetPVarInt(userid, "IpBaglandi") == 1)
 	return HataMesajGonder(playerid, "Bu kiþi ile sex yapamazsýn!");

    if (type < 1 || type > 6)
        return HataMesajGonder(playerid, "Tip 1-6 arasýnda olmasý gerekir.");

    PlayerData[userid][pShakeOffer] = playerid;
    PlayerData[userid][pShakeType] = type;

    MesajGonder(userid, "%s seninle sex yapmak istiyor. (\"/kabulet sex\").", ReturnName(playerid, 0));
    MesajGonder(playerid, "%s adlý oyuncuya sex isteði yolladýn.", ReturnName(userid, 0));
    return 1;
}
CMD:kabulet(playerid, params[])
{
 	if (isnull(params))
    {
        KullanimMesajGonder(playerid, "/kabulet [adlar]");
        SendClientMessage(playerid, COLOR_YELLOW, "[ADLAR]:{FFFFFF} arama, tokalasma, sex, evlilik, konum, sirket");
        return 1;
    }

    if (!strcmp(params, "konum", true) && GetPVarInt(playerid, "KonumKabul") != -1 && IsPlayerConnected(GetPVarInt(playerid, "KonumKabul")))
    {
    	new Float:pos[3];
    	GetPlayerPosEx(GetPVarInt(playerid, "KonumKabul"), pos[0], pos[1], pos[2]);

    	callcmd::cpsifirla(playerid);
    	SetPlayerCheckpoint(playerid, pos[0], pos[1], pos[2], 3.0);
   	 	MesajGonder(playerid, "Kiþinin konumu haritada iþaretlendi.");
    	SetPVarInt(playerid, "KonumKabul", -1);
    	SetPVarInt(playerid, "AraciniBuluyor", 1);
    }
	if (!strcmp(params, "sirket", true) && PlayerData[playerid][pSirketOffer] != INVALID_PLAYER_ID)
	{
		new
	    	targetid = PlayerData[playerid][pSirketOffer],
	        factionid = PlayerData[playerid][pSirketOffered];

		SirketVer(playerid, factionid);
	    PlayerData[playerid][pSirketRank] = 1;

	    SunucuMesaji(targetid, "%s adlý kiþi þirket davetini kabul etti.\"%s\".", ReturnName(playerid, 0), Sirket_Ad(playerid));
	    SunucuMesaji(playerid, "%s adlý kiþi seni þirkete aldý. \"%s\".", ReturnName(targetid, 0), Sirket_Ad(playerid));

	    PlayerData[targetid][pSirketOffer] = INVALID_PLAYER_ID;
	    PlayerData[playerid][pSirketOffered] = -1;
	}
    if (!strcmp(params, "arama", true) && PlayerData[playerid][pFriskOffer] != INVALID_PLAYER_ID)
    {
         new
            targetid = PlayerData[playerid][pFriskOffer];

        if (!IsPlayerNearPlayer(playerid, targetid, 6.0))
            return HataMesajGonder(playerid, "Oyuncuya yakýn deðilsin.");

        SendClientMessage(targetid, -1, "{AFAFAF}-------------------------------");
        SendClientMessageEx(targetid, COLOR_WHITE, "Para: {2ECC71}%s", FormatNumber(PlayerData[playerid][pCash]));
        if (PlayerDrugData[playerid][Drugs] > 0) SendClientMessageEx(targetid, COLOR_WHITE, "Uyuþturucu: %d gram", PlayerDrugData[playerid][Drugs]);
        if (PlayerDrugData[playerid][Seeds] > 0) SendClientMessageEx(targetid, COLOR_WHITE, "Uyuþturucu Tohumu: %d adet", PlayerDrugData[playerid][Seeds]);
        if (PlayerData[playerid][pRadyo] > 0) SendClientMessageEx(targetid, COLOR_WHITE, "Portatif Radyo (frekans #%d khZ)", PlayerData[playerid][pFrekans]);
        if (PlayerData[playerid][pEhliyet] == 1) SendClientMessage(targetid, COLOR_WHITE, "Ehliyet.");
        new a;
		for (new i; i<13; i++) if (PlayerData[playerid][pSilahlar][i] > 0)
		{
	    	GetPlayerWeaponData(playerid, i, a, PlayerData[playerid][pMermiler][i]);
	    	SendClientMessageEx(targetid, COLOR_WHITE, "%s (%d mermi)", ReturnWeaponName(PlayerData[playerid][pSilahlar][i]), PlayerData[playerid][pMermiler][i]);
		}
		SendClientMessage(targetid, -1, "{AFAFAF}-------------------------------");
		SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s ellerini %s adlý kiþinin üzerinde gezdirir.", ReturnName(targetid, 0), ReturnName(playerid, 0));
        PlayerData[playerid][pFriskOffer] = INVALID_PLAYER_ID;
    }
    else if (!strcmp(params, "tokalasma", true) && PlayerData[playerid][pShakeOffer] != INVALID_PLAYER_ID)
    {
        new
            targetid = PlayerData[playerid][pShakeOffer],
            type = PlayerData[playerid][pShakeType];

        if (!IsPlayerNearPlayer(playerid, targetid, 6.0))
            return HataMesajGonder(playerid, "Oyuncuya yakýn deðilsin.");

        SetPlayerToFacePlayer(playerid, targetid);
        SetPlayerToFacePlayer(targetid, playerid);

        PlayerData[playerid][pShakeOffer] = INVALID_PLAYER_ID;
        PlayerData[playerid][pShakeType] = 0;

        switch (type)
        {
            case 1:
            {
                ApplyAnimation(playerid, "GANGS", "hndshkaa", 4.0, 0, 0, 0, 0, 0, 1);
                ApplyAnimation(targetid, "GANGS", "hndshkaa", 4.0, 0, 0, 0, 0, 0, 1);
            }
            case 2:
            {
                ApplyAnimation(playerid, "GANGS", "hndshkba", 4.0, 0, 0, 0, 0, 0, 1);
                ApplyAnimation(targetid, "GANGS", "hndshkba", 4.0, 0, 0, 0, 0, 0, 1);
            }
            case 3:
            {
                ApplyAnimation(playerid, "GANGS", "hndshkda", 4.0, 0, 0, 0, 0, 0, 1);
                ApplyAnimation(targetid, "GANGS", "hndshkda", 4.0, 0, 0, 0, 0, 0, 1);
            }
            case 4:
            {
                ApplyAnimation(playerid, "GANGS", "hndshkea", 4.0, 0, 0, 0, 0, 0, 1);
                ApplyAnimation(targetid, "GANGS", "hndshkea", 4.0, 0, 0, 0, 0, 0, 1);
            }
            case 5:
            {
                ApplyAnimation(playerid, "GANGS", "hndshkfa", 4.0, 0, 0, 0, 0, 0, 1);
                ApplyAnimation(targetid, "GANGS", "hndshkfa", 4.0, 0, 0, 0, 0, 0, 1);
            }
            case 6:
            {
                ApplyAnimation(playerid, "GANGS", "prtial_hndshk_biz_01", 4.0, 0, 0, 0, 0, 0, 1);
                ApplyAnimation(targetid, "GANGS", "prtial_hndshk_biz_01", 4.0, 0, 0, 0, 0, 0, 1);
            }
        }
        MesajGonder(playerid, "%s adlý kiþinin tokalaþma isteðini kabul ettiniz.", ReturnName(targetid, 0));
        MesajGonder(targetid, "%s tokalaþma isteðinizi kabul etti.", ReturnName(playerid, 0));
    }
    else if (!strcmp(params, "sex", true) && PlayerData[playerid][pShakeOffer] != INVALID_PLAYER_ID)
    {
        new
            targetid = PlayerData[playerid][pShakeOffer],
            type = PlayerData[playerid][pShakeType];

        if (!IsPlayerNearPlayer(playerid, targetid, 6.0))
            return HataMesajGonder(playerid, "Oyuncuya yakýn deðilsin.");

        SetPlayerToFacePlayer(playerid, targetid);
        SetPlayerToFacePlayer(targetid, playerid);

        PlayerData[playerid][pShakeOffer] = INVALID_PLAYER_ID;
        PlayerData[playerid][pShakeType] = 0;

        switch (type)
        {
            case 1:
            {
                ApplyAnimation(playerid, "SWEET", "Sweet_injuredloop", 4.0, 1, 0, 0, 0, 0, 1);
                ApplyAnimation(targetid, "CAR", "Fixn_Car_Loop", 4.1, 1, 0, 0, 0, 0, 1);
            }
            case 2:
            {
               // ApplyAnimation(playerid, "GANGS", "hndshkba", 4.0, 0, 0, 0, 0, 0, 1);
               // ApplyAnimation(targetid, "GANGS", "hndshkba", 4.0, 0, 0, 0, 0, 0, 1);
            }
            case 3:
            {
               // ApplyAnimation(playerid, "GANGS", "hndshkda", 4.0, 0, 0, 0, 0, 0, 1);
               // ApplyAnimation(targetid, "GANGS", "hndshkda", 4.0, 0, 0, 0, 0, 0, 1);
            }
            case 4:
            {
               // ApplyAnimation(playerid, "GANGS", "hndshkea", 4.0, 0, 0, 0, 0, 0, 1);
               // ApplyAnimation(targetid, "GANGS", "hndshkea", 4.0, 0, 0, 0, 0, 0, 1);
            }
            case 5:
            {
              //  ApplyAnimation(playerid, "GANGS", "hndshkfa", 4.0, 0, 0, 0, 0, 0, 1);
              //  ApplyAnimation(targetid, "GANGS", "hndshkfa", 4.0, 0, 0, 0, 0, 0, 1);
            }
            case 6:
            {
               // ApplyAnimation(playerid, "GANGS", "prtial_hndshk_biz_01", 4.0, 0, 0, 0, 0, 0, 1);
               // ApplyAnimation(targetid, "GANGS", "prtial_hndshk_biz_01", 4.0, 0, 0, 0, 0, 0, 1);
            }
        }
        MesajGonder(playerid, "%s adlý kiþinin sex isteðini kabul ettiniz.", ReturnName(targetid, 0));
        MesajGonder(targetid, "%s sex isteðinizi kabul etti.", ReturnName(playerid, 0));
    }
    else if (!strcmp(params, "evlilik", true) && PlayerData[playerid][pPartnerTeklif] != INVALID_PLAYER_ID)
    {
        new
            partnerid = PlayerData[playerid][pPartnerTeklif];

        if (!IsPlayerNearPlayer(playerid, partnerid, 6.0))
            return HataMesajGonder(playerid, "Oyuncuya yakýn deðilsin.");

        if (PlayerData[playerid][pPartner] != 0 || PlayerData[partnerid][pPartner] != 0 )
            return HataMesajGonder(playerid, "Evlilik için iki çiftinde partneri olmamasý gereklidir.");

        PlayerData[playerid][pPartner] = PlayerData[partnerid][pID];
        PlayerData[partnerid][pPartner] = PlayerData[playerid][pID];

        SendClientMessageToAllEx(0x42f445FF, "KÝLÝSE: %s ile %s evlendi!", ReturnName(partnerid, 0), ReturnName(playerid, 0));
        Log_Write("logs/evlilik_log.txt", "[%s] %s, %s ile evlendi.", ReturnDate(), ReturnName(playerid, 0), ReturnName(partnerid , 0));

        PlayerData[playerid][pPartnerTeklif] = INVALID_PLAYER_ID;
    }
    return 1;
}

CMD:birlikler(playerid)
{
    if (!OyundaDegil(playerid)) return 1;
    ViewFactions(playerid);
	return 1;
}

CMD:birlikara(playerid, params[])
{
	if (!OyundaDegil(playerid)) return 1;
	if (isnull(params)) return KullanimMesajGonder(playerid, "/birlikara [Ad]");
	if (strlen(params) < 3) return HataMesajGonder(playerid, "En az üç harf girmelisiniz.");
	new tip[15], count;

	for (new i; i<MAX_BIRLIK; i++) if (Birlikler[i][birlikExists] == 1 && strfind(Birlikler[i][birlikAd], params, true) != -1)
	{
	    switch (Birlikler[i][birlikTip])
     	{
      		case 0: tip = "Belirlenmiyor";
      		case 1: tip = "Çete";
        	case 2: tip = "Mafya";
         	case 3: tip = "Yayýn Ajansý";
          	case 4: tip = "Legal";
           	default: tip = "Özel Kurum";
      	}
      	count++;
	    SendClientMessageEx(playerid, COLOR_WHITE, "%s (ID: %d | SQL ID: %d | Tip: %s | Üye Sayýsý: %d)", Birlikler[i][birlikAd], i, Birlikler[i][birlikID], tip, BirlikUyeSayisi(i));
	}
 	if (!count) return HataMesajGonder(playerid, "Hiç birlik bulunamadý.");
	return 1;
}

CMD:hud(playerid)
{
    if (!OyundaDegil(playerid)) return 1;
    if (PlayerData[playerid][pHUD] == true)
    {
        PlayerData[playerid][pHUD] = false;

        for (new i; i < 8; i++)
            PlayerTextDrawHide(playerid, NitroHUD[playerid][i]);

    }
    else
    {
        PlayerData[playerid][pHUD] = true;

        for (new i; i < 8; i++)
            PlayerTextDrawShow(playerid, NitroHUD[playerid][i]);
    }
	return 1;
}

CMD:ssmod(playerid)
{
    if (!OyundaDegil(playerid)) return 1;
    if (GetPVarInt(playerid, "ssmod") == 0)
	{
	    for (new i; i < 8; i++)
        {
            PlayerTextDrawHide(playerid, NitroHUD[playerid][i]);
        }
	    SetPVarInt(playerid, "ssmod", 1);
	    TextDrawShowForPlayer(playerid, Karanlik);
	}
	else
	{
	    for (new i; i < 8; i++)
        {
            PlayerTextDrawShow(playerid, NitroHUD[playerid][i]);
        }
	    DeletePVar(playerid, "ssmod");
     	TextDrawHideForPlayer(playerid, Karanlik);
	}
	return 1;
}
CMD:mulklerim(playerid)
{
    if (!OyundaDegil(playerid)) return 1;
    Dialog_Show(playerid, Mulklerim, DIALOG_STYLE_LIST, "{0000BB}» {FFFFFF}Mülkleriniz", "{FFFFFF}Araçlar\n{FFFFFF}Evler\n{FFFFFF}Ýþyerleri\n{FFFFFF}Gateler\n{FFFFFF}Petler\n{FFFFFF}Garajlar", "Seç", "Kapat");
	return 1;
}
CMD:stand(playerid, params[])
{
	new opsiyon[10];
    if (!OyundaDegil(playerid)) return 1;
    if (PlayerData[playerid][pKelepce] > 0 || PlayerData[playerid][pHapisSure] > 0 || PlayerData[playerid][pSoklandi] > 0 || PlayerData[playerid][pYereYatirildi] > 0 || PlayerData[playerid][pBaygin] == 1 || PetKontrol[playerid] != -1 || pbOda[playerid] != -1 || GetPVarInt(playerid, "IpBaglandi") == 1)
 	return HataMesajGonder(playerid, "Þu an bu komutu kullanamazsýnýz.");
    if (sscanf(params, "s[10]", opsiyon)) return KullanimMesajGonder(playerid, "/stand [koy/al]");
    if (strcmp(opsiyon, "koy", true) == 0)
    {
        if (PlayerData[playerid][pStand] == true) return HataMesajGonder(playerid, "Zaten stand koymuþsunuz!");
        if (GetPlayerInterior(playerid) > 0 || GetPlayerVirtualWorld(playerid) > 0) return HataMesajGonder(playerid, "Ýnterior içerisine stand koyamazsýnýz.");
        Dialog_Show(playerid, Standlar, DIALOG_STYLE_PREVMODEL, "Stand", "1341\n1342\n1340", "Sec", "Kapat");
    }
    else if (strcmp(opsiyon, "al", true) == 0)
    {
        if (PlayerData[playerid][pStand] == false) return HataMesajGonder(playerid, "Zaten stand koymamýþsýnýz!");
        new Float:objectPos[3];
        GetDynamicObjectPos(PlayerData[playerid][pStandObject], objectPos[0], objectPos[1], objectPos[2]);
        if (!IsPlayerInRangeOfPoint(playerid, 5.0, objectPos[0], objectPos[1], objectPos[2])) return HataMesajGonder(playerid, "Standýnýzýn yakýnýnda deðilsiniz.");
        PlayerData[playerid][pStand] = false;
        DestroyDynamicObject(PlayerData[playerid][pStandObject]);
        DestroyDynamic3DTextLabel(PlayerData[playerid][pStandText]);
    }
	return 1;
}
CMD:gise(playerid, params[])
{
    new id = Gise_Kontrol(playerid);

	if (id == -1 && strcmp(params, "ben", true) != 0)
	    return HataMesajGonder(playerid, "Herhangi bir giþenin yakýnýnda deðilsiniz.");

	if (PlayerData[playerid][pCash] < GetServerBilgi("GiseUcreti"))
	    return HataMesajGonder(playerid, "Paranýz yetersiz. {00FF00}%s", FormatNumber(GetServerBilgi("GiseUcreti")));

	if (AcilDurum == 1)
	    return HataMesajGonder(playerid, "Giþeler þu anda LSPD tarafýndan devre dýþý býrakýlmýþtýr.");

	if (Gise[id][gs_Durum] == GISE_KAPALI)
	{
		Gise[id][gs_Durum] = GISE_ACIK;

		BilgiMesajGonder(playerid, "Giþe açýldýktan sonra 5 saniye içinde kapanacaktýr.");

		ParaVer(playerid, -GetServerBilgi("GiseUcreti"));
		MoveDynamicObject(Gise[id][gs_Obje], Gise[id][gs_Acik][0], Gise[id][gs_Acik][1], Gise[id][gs_Acik][2], 5.0,  Gise[id][gs_Acik][3], Gise[id][gs_Acik][4], Gise[id][gs_Acik][5]);
	}
	return 1;
}
CMD:giseler(playerid)
{
    if (!OyundaDegil(playerid)) return 1;
    if (GetFactionType(playerid) != BIRLIK_LSPD && GetFactionType(playerid) != BIRLIK_FBI && PlayerData[playerid][pAdmin] < 1) return HataMesajGonder(playerid, "Devlet memuru deðilsiniz.");
    GiseKontrolu(playerid);
	return 1;
}
CMD:paintball(playerid)
{
	HataMesajGonder(playerid, "Paintball kýsa süreliðine kapalýdýr, ilginiz için teþekkür ederiz.");
	return 1;
}
/*CMD:paintball(playerid)
{
    if (!OyundaDegil(playerid)) return 1;
    if (!IsPlayerInRangeOfPoint(playerid, 5.0, 1170.9122,-1489.6418,22.7551)) return HataMesajGonder(playerid, "Paintball noktasýnda deðilsiniz.");
    Dialog_Show(playerid, Paintball, DIALOG_STYLE_LIST, "Paintball", "{AFAFAF}» {FFFFFF}Odaya Gir\n{AFAFAF}» {FFFFFF}Oda Kirala {2ECC71}(%s)", "Seç", "Kapat", FormatNumber(ODA_PARA));
	return 1;
}*/
CMD:pbcik(playerid)
{
    if (!OyundaDegil(playerid)) return 1;
    new id = OdasiVarmi(playerid);
    if (id != -1) return HataMesajGonder(playerid, "Oda size ait olduðu için çýkamazsýnýz. Çýkmak için odayý silmelisiniz.");
    if (pbOda[playerid] == -1) return HataMesajGonder(playerid, "Paintball'da deðilsiniz.");
    if (IsPlayerDying(playerid)) return HataMesajGonder(playerid, "Spawn olmadan bu komutu kullanamazsýnýz.");
    OdadanAt(playerid, 0);
	return 1;
}
CMD:pboda(playerid)
{
    if (!OyundaDegil(playerid)) return 1;
	new id = OdasiVarmi(playerid);
	if (id == -1) return HataMesajGonder(playerid, "Oda kiralamamýþsýnýz.");
	if (!IsPlayerInRangeOfPoint(playerid, 5.0, 1170.9122,-1489.6418,22.7551) && Paintball[pbOda[playerid]][odaDurum] != ODA_BASLADI) return HataMesajGonder(playerid, "Paintball noktasýnda deðilsiniz.");
	if (id != -1 && pbOda[playerid] == id)
	{
	    OdaAyarlari(playerid, id);
	}
	return 1;
}
CMD:evlen(playerid, params[])
{
    if (!OyundaDegil(playerid)) return 1;
    if (!IsPlayerInRangeOfPoint(playerid, 3.0, -787.6846,829.3535,3019.1287))
        return HataMesajGonder(playerid, "Evlenmek için kilisede olmalýsýn.");

    static
        userid;

    if (sscanf(params, "u", userid))
        return KullanimMesajGonder(playerid, "/evlen [id/isim]");

    if (!IsPlayerConnected(userid) || !IsPlayerNearPlayer(playerid, userid, 5.0))
        return HataMesajGonder(playerid, "Oyuncu oyunda deðil veya sana yakýn deðil.");

    if (userid == playerid)
        return HataMesajGonder(playerid, "Kendinle evlenemezsin.");

    if (PlayerData[userid][pCinsiyet] == PlayerData[playerid][pCinsiyet]) return HataMesajGonder(playerid, "Seninle ayný cinsiyette olan biri ile evlenemezsin.");

    if (PlayerData[playerid][pPartner] != 0 || PlayerData[userid][pPartner] != 0 )
        return HataMesajGonder(playerid, "Evlilik için iki çiftinde partneri olmamasý gereklidir.");

    PlayerData[userid][pPartnerTeklif] = playerid;
    MesajGonder(playerid, "%s'a evlenme teklifi yolladýn, partnerinizin yanýtýný bekleyin.", ReturnName(userid, 0));
    MesajGonder(userid, "%s sana evlenme teklifi yolladý. (/kabulet evlilik)", ReturnName(playerid, 0));

    return 1;
}
CMD:taksi(playerid)
{
    if (!OyundaDegil(playerid)) return 1;
    if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return HataMesajGonder(playerid, "Þöför olmalýsýnýz.");
    new vehicleid = GetPlayerVehicleID(playerid);
    new id = Car_GetID(vehicleid);
    if (id == -1 || AracInfo[id][aracTip] != 4 || (AracInfo[id][TaksiPlaka] == 0 && GetVehicleModel(vehicleid) != 420)) return HataMesajGonder(playerid, "Bu araç taksi aracý deðil.");
    if (IsValidDynamicObject(AracInfo[id][TaksiObje]))
    {
        Dialog_Show(playerid, TaksiMenu, DIALOG_STYLE_TABLIST, "Taksi Paneli", "{AFAFAF}» {FF9900}Taksi Modeli\t{FFFFFF}%s\n{AFAFAF}» {FF9900}Taksimetre\t%s\n{AFAFAF}» {FF9900}Oturum Kazancý\t{2ECC71}%s\n{AFAFAF}» {FFFFFF}Oturum Kazancýný Sýfýrla\n\
        {AFAFAF}» {FFFFFF}Taksimetre Ücretini Deðiþtir\t{2ECC71}%s\n{AFAFAF}» {FFFFFF}Taksi Objesini Kaldýr\n{AFAFAF}» {FFFFFF}Taksi Talepleri",
		"Seç", "Kapat", ReturnVehicleModelName(GetVehicleModel(vehicleid)), (PlayerData[playerid][pTaxiDuty] == false) ? ("{f44542}Kapalý") : ("{42f445}Açýk"),
        FormatNumber(AracInfo[id][OturumKazanci]), FormatNumber(AracInfo[id][Taksimetre]));

    }
    else
    {
        Dialog_Show(playerid, TaksiMenu, DIALOG_STYLE_TABLIST, "Taksi Paneli", "{AFAFAF}» {FF9900}Taksi Modeli\t{FFFFFF}%s\n{AFAFAF}» {FF9900}Taksimetre\t%s\n{AFAFAF}» {FF9900}Oturum Kazancý\t{2ECC71}%s\n{AFAFAF}» {FFFFFF}Oturum Kazancýný Sýfýrla\n\
        {AFAFAF}» {FFFFFF}Taksimetre Ücretini Deðiþtir\t{2ECC71}%s\n{AFAFAF}» {FFFFFF}Taksi Objesini Yerleþtir\n{AFAFAF}» {FFFFFF}Taksi Talepleri",
		"Seç", "Kapat", ReturnVehicleModelName(GetVehicleModel(vehicleid)), (PlayerData[playerid][pTaxiDuty] == false) ? ("{f44542}Kapalý") : ("{42f445}Açýk"),
        FormatNumber(AracInfo[id][OturumKazanci]), FormatNumber(AracInfo[id][Taksimetre]));
    }
	return 1;
}
CMD:taksiiptal(playerid, params[])
{
    if (PlayerData[playerid][pTaxiDuty] == false) return HataMesajGonder(playerid, "Taksi aracýnda olup iþbaþý yapmalýsýnýz.");

	if (PlayerData[playerid][pTaksiKabul] == -1) return HataMesajGonder(playerid, "Taksi kabul etmemiþsin.");

	BilgiMesajGonder(PlayerData[playerid][pTaksiKabul], "%s adlý taksi þöförü gelmekten vazgeçti tekrardan taksi çaðýrabilirsin.", ReturnName(playerid, 0));
	PlayerData[playerid][pTaksiKabul] = -1;
	DisablePlayerCheckpoint(playerid);
	return 1;
}
CMD:ara(playerid, params[])
{
	new number;
    if (!OyundaDegil(playerid)) return 1;
    if (PlayerData[playerid][pKelepce] > 0 || PlayerData[playerid][pHapisSure] > 0 || PlayerData[playerid][pSoklandi] > 0 || PlayerData[playerid][pYereYatirildi] > 0 || PlayerData[playerid][pBaygin] == 1 || PetKontrol[playerid] != -1 || pbOda[playerid] != -1 || GetPVarInt(playerid, "IpBaglandi") == 1)
 	return HataMesajGonder(playerid, "Þu an bu komutu kullanamazsýnýz.");
    if (PlayerData[playerid][pTelefon] == -1) return HataMesajGonder(playerid, "Telefonunuz yok.");
    if (PlayerData[playerid][pTelefonAyar][0] == 1) return HataMesajGonder(playerid, "Telefonunuz kapalý.");
    if (PlayerData[playerid][pAramada] != 0) return HataMesajGonder(playerid, "Þu an aramada olduðunuz için kimseyi arayamazsýnýz.");
    if (sscanf(params, "i", number)) return KullanimMesajGonder(playerid, "/ara [numara] (911 - Acil durum, 333 - Taksi)");
    if (number == PlayerData[playerid][pTelefon]) return HataMesajGonder(playerid, "Kendinizi arayamazsýnýz.");
    if (number == 911)
    {
        if (!spamProtect(playerid, "AcilDurum", 120)) return HataMesajGonder(playerid, "Tekrar ihbar vermek için 2 dakika beklemelisiniz.");
        Dialog_Show(playerid, HizmetSecin, DIALOG_STYLE_LIST, "{FFFFFF}Operatör ~ Hizmet Seçin:", "{9189EF}Los Santos Polis Departmaný\n{FF8282}Los Santos Fire Department", "Seç", "Kapat");
        return 1;
    }
/*    if (number == 555)
    {
        new string[750], sayi;
   		for (new i; i<sizeof(Tarifeler); i++)
    	{
	    		sayi++;
	    		format(string, sizeof(string), "%s{FFFFFF}%s {38c5f7}(%s){FFFFFF} - %d dakika / %d SMS / %d MB\n", string, Tarifeler[i][TarifeAdi], FormatNumber(Tarifeler[i][TarifeFiyat]), Tarifeler[i][TarifeDakika], Tarifeler[i][TarifeSMS], Tarifeler[i][TarifeNet]);
    	}
    	if (sayi == 0) return HataMesajGonder(playerid, "Hiç tarife yok.");
    	Dialog_Show(playerid, Tarifeler, DIALOG_STYLE_LIST, "Tarifeci", string, "Seç", "Kapat");
    	return 1;
    }*/
    if (number == 333)
    {
        PlayerData[playerid][pTaxiCalled] = 1;
        PlayerPlaySound(playerid, 3600, 0.0, 0.0, 0.0);
        SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s telefonunda bir kaç numara tuþlar.", ReturnName(playerid, 0));
        MesajGonder(playerid, "Taksi çaðýrdýnýz, lütfen bekleyin...");
        new Float:pos[3];
        GetPlayerPosEx(playerid, pos[0], pos[1], pos[2]);
        foreach (new i:Player) if (GetPlayerState(i) == PLAYER_STATE_DRIVER && PlayerData[i][pTaxiDuty] == true)
        {
            SendClientMessageEx(i, 0x42f445FF, "%s adlý kiþi %s bölgesine taksi talep ediyor.", ReturnName(playerid, 0), GetLocation(pos[0], pos[1], pos[2]));
        }
        return 1;
    }
    if (PlayerData[playerid][pTarife] == -1 || PlayerData[playerid][pTarifeKalan][0] == 0) return HataMesajGonder(playerid, "Tarifeniz yok veya tarifenizde dakika kalmamýþ.");
    new targetid = GetNumberOwner(number);
    if (targetid == INVALID_PLAYER_ID || targetid == playerid || PlayerData[targetid][pBaygin] > 0 || PlayerData[targetid][pKelepce] > 0 || PlayerData[targetid][pHapisSure] > 0 || PlayerData[targetid][pTelefonAyar][0] == 1 || PlayerData[targetid][pTelefonAyar][5] == 1 || Jammer_Near(targetid) == 1) return HataMesajGonder(playerid, "Aradýðýnýz numaraya þu anda ulaþýlamýyor, lütfen daha sonra tekrar deneyiniz.");
    if (PlayerData[targetid][pAramada] != 0) return HataMesajGonder(playerid, "Mesgul tonu aldýn...");
    if (PlayerData[targetid][pTelefonAyar][3] == 1 && !RehberdeVar(targetid, PlayerData[playerid][pTelefon])) return HataMesajGonder(playerid, "Bu numara bilinmeyen numaralarý engellemiþ.");
    PlayerData[playerid][pAramada] = ARAMA_ARIYOR;
    PlayerData[targetid][pAramada] = ARAMA_ARANIYOR;
    PlayerData[playerid][pCallLine] = targetid;
    PlayerData[targetid][pCallLine] = playerid;
    SetPVarInt(playerid, "Arayan", 1);
    MesajGonder(playerid, "Numara aranýyor, lütfen cevap vermesini bekleyin. /cagrikapat ile çaðrýyý bitirebilirsiniz.");
    SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s telefonunda bir kaç numara tuþlar.", ReturnName(playerid, 0));
    BilgiMesajGonder(targetid, "[Telefon]: %s  - /cagrikabul ile çaðrýyý kabul edebilir, /cagrikapat ile çaðrýyý kapatabilirsiniz.", TelNo(targetid, playerid));
    PlayerPlaySound(playerid, 3600, 0.0, 0.0, 0.0);
    if (PlayerData[targetid][pTelefonAyar][1]) SendNearbyMessage(targetid, 30.0, COLOR_CYAN, "** Telefonu titremektedir. (( %s ))", ReturnName(targetid, 0));
    else
	{
		SendNearbyMessage(targetid, 30.0, COLOR_CYAN, "** Telefon çalmaktadýr. (( %s ))", ReturnName(targetid, 0));
  		PlayerPlaySoundEx(targetid, 23000);
	}
	return 1;
}
CMD:sms(playerid, params[])
{
    new number, mesaj[100];
    if (!OyundaDegil(playerid)) return 1;
    if (PlayerData[playerid][pTelefon] == -1) return HataMesajGonder(playerid, "Telefonunuz yok.");
    if (PlayerData[playerid][pKelepce] > 0 || PlayerData[playerid][pHapisSure] > 0 || PlayerData[playerid][pSoklandi] > 0 || PlayerData[playerid][pYereYatirildi] > 0 || PlayerData[playerid][pBaygin] == 1 || PetKontrol[playerid] != -1 || pbOda[playerid] != -1 || GetPVarInt(playerid, "IpBaglandi") == 1)
 	return HataMesajGonder(playerid, "Þu an bu komutu kullanamazsýnýz.");
    if (PlayerData[playerid][pTelefonAyar][0] == 1) return HataMesajGonder(playerid, "Telefonunuz kapalý.");
    if (PlayerData[playerid][pTarife] == -1 || PlayerData[playerid][pTarifeKalan][1] == 0) return HataMesajGonder(playerid, "Tarifeniz yok veya SMS hakkýnýz bitmiþ.");
    if (sscanf(params, "is[100]", number, mesaj)) return KullanimMesajGonder(playerid, "/sms [numara] [mesaj]");
    if (number == 911 || number == 121 || number == 555) return HataMesajGonder(playerid, "Bu numaraya SMS gönderemezsiniz.");
    new targetid = GetNumberOwner(number);
    if (targetid == INVALID_PLAYER_ID || targetid == playerid || Jammer_Near(targetid) == 1) return HataMesajGonder(playerid, "Geçersiz numara girdiniz.");
    if (PlayerData[targetid][pTelefonAyar][0] == 1 || PlayerData[targetid][pTelefonAyar][4] == 1) return HataMesajGonder(playerid, "Bu numara SMS alýmlarýný kapatmýþ.");
    PlayerData[playerid][pTarifeKalan][1]--;
	SendClientMessageEx(targetid, 0xFFC10000, "[SMS]«« %s: {FFFFFF}%s", TelNo(targetid, playerid), mesaj);
	SendClientMessageEx(playerid, 0xFFC10000, "[SMS]»» %s: {FFFFFF}%s", ReturnName(playerid, 0), mesaj);

	PlayerPlaySoundEx(targetid, 21001);
	return 1;
}
CMD:eskortnumarasi(playerid, params[])
{
    HataMesajGonder(playerid, "{FF00D4}0537 685 64 54{ffffff} güle güle kullan, bol bol sik Watsapptan Nude foto at.");
	return 1;
}
CMD:animasyonlar(playerid, params[])
{
    Dialog_Show(playerid, YOUR_DIALOGID, DIALOG_STYLE_TABLIST_HEADERS, "Animasyon Listesi",
    "Komut\tAçýklama\n\
    /handsup\tKarakteriniz ellerini yukarý kaldýrýr.\n\
	/sarhos\tKarakteriniz sarhoþ gibi yürür.\n\
	/bomb\tKarakteriniz bomba yerleþtirir.\n\
	/rob\tKarakteriniz silah uzatýr.\n\
	/laugh\tKarakteriniz gülmeye baþlar.\n\
	/lookout\tKarakteriniz bir eþyaya bakar.\n\
	/robman\tKarakteriniz soygun yapmak için silahýný uzatýr.\n\
	/crossarms\tKarakteriniz ellerini baðlar.\n\
	/sit\tKarakteriniz oturur.\n\
	/siteat\tKarakteriniz otururken yemek yer.\n\
	/hide\tKarakteriniz çömelerek kafasýný korur.\n\
	/vomit\tKarakteriniz kusar.\n\
	/eat\tKarakteriniz yemek yer.\n\
	/wave\tKarakteriniz el sallar.\n\
	/slapass\tKarakteriniz eli ile yanýndakine vurur.\n\
	/deal\tKarakteriniz cebinden telefon çýkartýr.\n\
	/taichi\tKarakteriniz dövüþ hareketleri yapar.\n\
	/crack\tKarakteriniz uyuþturucu krizine girer.\n\
	/smoke\tKarakteriniz sigara içer.\n\
	/chat\tKarakteriniz konuþmaya baþlar.\n\
	/dance\tKarakteriniz dans etmeye baþlar.\n\
	/fucku\tKarakteriniz elini havaya kaldýrýr.\n\
	/drinkwater\tKarakteriniz su içer.\n\
	/pedmove\tKarakteriniz koþmaya baþlar.\n\
	/bat\tKarakteriniz el ve kafa hareketleri yapar.\n\
	/checktime\tKarakteriniz saatini kontrol eder.\n\
	/sleep\tKarakteriniz uyur.\n\
	/blob\tKarakteriniz yerde yaralý þekilde yatar.\n\
	/opendoor\tKarakteriniz kapý açar.\n\
	/wavedown\tKarakteriniz elini masaya koyar.\n\
	/reload\tKarakteriniz silahýný doldurur.\n\
	/cpr\tKarakteriniz kalp masajý yapar.\n\
	/dive\tKarakteriniz yan tarafýna atlar.\n\
	/showoff\tKarakteriniz el hareketleri yapar.\n\
	/box\tKarakteriniz box yapar.\n\
	/tag\tKarakteriniz el baðlama ve sprey animasyonu yapar.\n\
	/goggles\tKarakteriniz gözlük takar.\n\
	/cry\tKarakteriniz aðlamaya baþlar.\n\
	/dj\tKarakteriniz dj hareketleri yapar.\n\
	/cheer\tKarakteriniz baðýrmaya baþlar	.\n\
	/throw\tKarakteriniz elindeki cismi fýrlatýr.\n\
	/robbed\tKarakteriniz soyulma animasyonu yapar.\n\
	/hurt\tKarakteriniz yaralanýr.\n\
	/nobreath\tKarakteriniz nefessiz kalýr.\n\
	/bar\tKarakteriniz bar animasyonu yapar.\n\
	/getjiggy\tKarakteriniz dans ve sallanma hareketleri yapar.\n\
	/fallover\tKarakteriniz düþme hareketleri yapar.\n\
	/rap\tKarakteriniz rap yapar.\n\
	/piss\tKarakteriniz iþemeye baþlar.\n\
	/salute\tKarakteriniz elini havaya kaldýrýr.\n\
	/crabs\tKarakteriniz kaþýnmaya baþlar.\n\
	/washhands\tKarakteriniz ellerini yýkar.\n\
	/signal\tKarakteriniz git ve gel hareketleri yapar.\n\
	/stop\tKarakteriniz dur hareketi yapar.\n\
	/gesture\tKarakteriniz çeþitli el, kol animasyonlarý yapar.\n\
	/jerkoff\tKarakteriniz mastürbasyon yapar ve boþalýr.\n\
	/idles\tKarakteriniz olduðu yerde sallanýr.\n\
	/lowrider\tKarakteriniz lowrider türü araçlarda çeþitli hareketler yapar.\n\
	/carchat\tKarakteriniz araç içinde konuþur.\n\
	/blowjob\tKarakteriniz sex animasyonlarý yapar.\n\
	/spank\tKarakteriniz eðilme ve yatma animasyonlarý yapar.\n\
	/sunbathe\tKarakteriniz yere uzanýr.\n\
	/kiss\tKarakteriniz öpüþmeye baþlar.\n\
	/snatch\tKarakteriniz saða veya sola elini savurur.\n\
	/sneak\tKarakteriniz eðilerek yürümeye baþlar.\n\
	/copa\tKarakteriniz çeþitli animasyonlar gerçekleþtirir.\n\
	/sexy\tKarakteriniz striptiz yapar.\n\
	/misc\tKarakteriniz çeþitli animasyonlar gerçekleþtirir.\n\
	/bodypush\tKarakteriniz karþýsýndaki kiþiyi iter.\n\
	/lowbodypush\tKarakteriniz karþýsýndakini omzu ile iter.\n\
	/headbutt\tKarakteriniz kafa atar.\n\
	/airkick\tKarakteriniz uçan tekme atar.\n\
	/doorkick\tKarakteriniz kapýya tekme atar.\n\
	/leftslap\tKarakteriniz tokat atar.\n\
	/elbow\tKarakteriniz dirsek atar.\n\
	/coprun\tKarakteriniz polis gibi koþmaya baþlar.\n\
	/lean\tKarakteriniz yaslanýr.\n\
    /wank\tKarakteriniz mastürbasyon yapmaya baþlar.",
    "Tamam", "Ýptal");
    return 1;
}
CMD:pedmove(playerid, params[])
{
	if (!AnimationCheck(playerid)) return HataMesajGonder(playerid, "Þu anda animasyon gerçekleþtirilemiyor.");
	if (IsPlayerInAnyVehicle(playerid)) return HataMesajGonder(playerid, "Araçta bunu yapamazsýnýz.");
 	switch (strval(params))
  	{
        case 1: PlayAnimEx(playerid, "PED", "JOG_femaleA", 4.0, 1, 1, 1, 1, 1, 1);
        case 2: PlayAnimEx(playerid, "PED", "JOG_maleA", 4.0, 1, 1, 1, 1, 1, 1);
        case 3: PlayAnimEx(playerid, "PED", "WOMAN_walkfatold", 4.0, 1, 1, 1, 1, 1, 1);
        case 4: PlayAnimEx(playerid, "PED", "run_fat", 4.0, 1, 1, 1, 1, 1, 1);
        case 5: PlayAnimEx(playerid, "PED", "run_fatold", 4.0, 1, 1, 1, 1, 1, 1);
        case 6: PlayAnimEx(playerid, "PED", "run_old", 4.0, 1, 1, 1, 1, 1, 1);
        case 7: PlayAnimEx(playerid, "PED", "Run_Wuzi", 4.0, 1, 1, 1, 1, 1, 1);
        case 8: PlayAnimEx(playerid, "PED", "swat_run", 4.0, 1, 1, 1, 1, 1, 1);
        case 9: PlayAnimEx(playerid, "PED", "WALK_fat", 4.0, 1, 1, 1, 1, 1, 1);
        case 10: PlayAnimEx(playerid, "PED", "WALK_fatold", 4.0, 1, 1, 1, 1, 1, 1);
        case 11: PlayAnimEx(playerid, "PED", "WALK_gang1", 4.0, 1, 1, 1, 1, 1, 1);
        case 12: PlayAnimEx(playerid, "PED", "WALK_gang2", 4.0, 1, 1, 1, 1, 1, 1);
        case 13: PlayAnimEx(playerid, "PED", "WALK_old", 4.0, 1, 1, 1, 1, 1, 1);
        case 14: PlayAnimEx(playerid, "PED", "WALK_shuffle", 4.0, 1, 1, 1, 1, 1, 1);
        case 15: PlayAnimEx(playerid, "PED", "woman_run", 4.0, 1, 1, 1, 1, 1, 1);
        case 16: PlayAnimEx(playerid, "PED", "WOMAN_runbusy", 4.0, 1, 1, 1, 1, 1, 1);
        case 17: PlayAnimEx(playerid, "PED", "WOMAN_runfatold", 4.0, 1, 1, 1, 1, 1, 1);
        case 18: PlayAnimEx(playerid, "PED", "woman_runpanic", 4.0, 1, 1, 1, 1, 1, 1);
        case 19: PlayAnimEx(playerid, "PED", "WOMAN_runsexy", 4.0, 1, 1, 1, 1, 1, 1);
        case 20: PlayAnimEx(playerid, "PED", "WOMAN_walkbusy", 4.0, 1, 1, 1, 1, 1, 1);
        case 21: PlayAnimEx(playerid, "PED", "WOMAN_walkfatold", 4.0, 1, 1, 1, 1, 1, 1);
        case 22: PlayAnimEx(playerid, "PED", "WOMAN_walknorm", 4.0, 1, 1, 1, 1, 1, 1);
        case 23: PlayAnimEx(playerid, "PED", "WOMAN_walkold", 4.0, 1, 1, 1, 1, 1, 1);
        case 24: PlayAnimEx(playerid, "PED", "WOMAN_walkpro", 4.0, 1, 1, 1, 1, 1, 1);
        case 25: PlayAnimEx(playerid, "PED", "WOMAN_walksexy", 4.0, 1, 1, 1, 1, 1, 1);
        case 26: PlayAnimEx(playerid, "PED", "WOMAN_walkshop", 4.0, 1, 1, 1, 1, 1, 1);
        default: KullanimMesajGonder(playerid, "/pedmove [1-26]");
   }
   return 1;
}
CMD:doorkick(playerid, params[])
{
	if (!AnimationCheck(playerid)) return HataMesajGonder(playerid, "Þu anda animasyon gerçekleþtirilemiyor.");
	if (IsPlayerInAnyVehicle(playerid)) return HataMesajGonder(playerid, "Araçta bunu yapamazsýnýz.");
    ApplyAnimation(playerid, "POLICE", "Door_Kick",4.0,0,0,0,0,0);
    return 1;
}
CMD:airkick(playerid, params[])
{
	if (!AnimationCheck(playerid)) return HataMesajGonder(playerid, "Þu anda animasyon gerçekleþtirilemiyor.");
	if (IsPlayerInAnyVehicle(playerid)) return HataMesajGonder(playerid, "Araçta bunu yapamazsýnýz.");
    ApplyAnimation(playerid, "FIGHT_C", "FightC_M",4.0,0,0,0,0,0);
    return 1;
}
CMD:bodypush(playerid, params[])
{
    if (!AnimationCheck(playerid))
        return HataMesajGonder(playerid, "Þu anda animasyon gerçekleþtirilemiyor.");

    if (IsPlayerInAnyVehicle(playerid)) return 1;
    if (GetPlayerAnimationIndex(playerid) != 0) ClearAnimations(playerid);
    ApplyAnimation(playerid, "GANGS", "shake_cara",4.0,0,0,0,0,0);
    return 1;
}

CMD:lowbodypush(playerid, params[])
{
    if (!AnimationCheck(playerid))
        return HataMesajGonder(playerid, "Þu anda animasyon gerçekleþtirilemiyor.");

    if (IsPlayerInAnyVehicle(playerid)) return 1;
    if (GetPlayerAnimationIndex(playerid) != 0) ClearAnimations(playerid);
    ApplyAnimation(playerid, "GANGS", "shake_carSH",4.0,0,0,0,0,0);
    return 1;
}

CMD:headbutt(playerid, params[])
{
    if (!AnimationCheck(playerid))
        return HataMesajGonder(playerid, "Þu anda animasyon gerçekleþtirilemiyor.");

    if (IsPlayerInAnyVehicle(playerid)) return 1;
    if (GetPlayerAnimationIndex(playerid) != 0) ClearAnimations(playerid);
    ApplyAnimation(playerid, "WAYFARER", "WF_Fwd",4.0,0,0,0,0,0);
    return 1;
}

CMD:air_Kick(playerid, params[])
{
    if (!AnimationCheck(playerid))
        return HataMesajGonder(playerid, "Þu anda animasyon gerçekleþtirilemiyor.");

    if (IsPlayerInAnyVehicle(playerid)) return 1;
    if (GetPlayerAnimationIndex(playerid) != 0) ClearAnimations(playerid);
    ApplyAnimation(playerid, "FIGHT_C", "FightC_M",4.0,0,1,1,0,0);
    return 1;
}

CMD:door_Kick(playerid, params[])
{
    if (!AnimationCheck(playerid))
        return HataMesajGonder(playerid, "Þu anda animasyon gerçekleþtirilemiyor.");

    if (IsPlayerInAnyVehicle(playerid)) return 1;
    if (GetPlayerAnimationIndex(playerid) != 0) ClearAnimations(playerid);
    ApplyAnimation(playerid, "POLICE", "Door_Kick",4.0,0,0,0,0,0);
    return 1;
}

CMD:leftslap(playerid, params[])
{
    if (!AnimationCheck(playerid))
        return HataMesajGonder(playerid, "Þu anda animasyon gerçekleþtirilemiyor.");

    if (IsPlayerInAnyVehicle(playerid)) return 1;
    if (GetPlayerAnimationIndex(playerid) != 0) ClearAnimations(playerid);
    ApplyAnimation(playerid, "PED", "BIKE_elbowL",4.0,0,0,0,0,0);
    return 1;
}

CMD:elbow(playerid, params[])
{
    if (!AnimationCheck(playerid))
        return HataMesajGonder(playerid, "Þu anda animasyon gerçekleþtirilemiyor.");

    if (IsPlayerInAnyVehicle(playerid)) return 1;
    if (GetPlayerAnimationIndex(playerid) != 0) ClearAnimations(playerid);
    ApplyAnimation(playerid, "FIGHT_D", "FightD_3",4.0,0,1,1,0,0);
    return 1;
}

CMD:coprun(playerid, params[])
{
    if (!AnimationCheck(playerid))
        return HataMesajGonder(playerid, "Þu anda animasyon gerçekleþtirilemiyor.");

    if (IsPlayerInAnyVehicle(playerid)) return 1;
    if (GetPlayerAnimationIndex(playerid) != 0) ClearAnimations(playerid);
    ApplyAnimation(playerid, "SWORD", "sword_block",50.0,0,1,1,1,1);
    return 1;
}

CMD:handsup(playerid, params[])
{
    if (!AnimationCheck(playerid))
        return HataMesajGonder(playerid, "Þu anda animasyon gerçekleþtirilemiyor.");

    if (IsPlayerInAnyVehicle(playerid)) return 1;
    if (GetPlayerAnimationIndex(playerid) != 0) ClearAnimations(playerid);
    SetPlayerSpecialAction(playerid,SPECIAL_ACTION_HANDSUP);
    return 1;
}

CMD:piss(playerid, params[])
{
    if (!AnimationCheck(playerid))
        return HataMesajGonder(playerid, "Þu anda animasyon gerçekleþtirilemiyor.");

    if (IsPlayerInAnyVehicle(playerid)) return 1;
    if (GetPlayerAnimationIndex(playerid) != 0) ClearAnimations(playerid);
    SetPlayerSpecialAction(playerid, 68);
    return 1;
}

CMD:sneak(playerid, params[])
{
    if (!AnimationCheck(playerid))
        return HataMesajGonder(playerid, "Þu anda animasyon gerçekleþtirilemiyor.");

    if (IsPlayerInAnyVehicle(playerid)) return 1;
    PlayAnimEx(playerid, "PED", "Player_Sneak", 4.1, 1, 1, 1, 1, 1, 1);
    return 1;
}

CMD:sarhos(playerid, params[])
{
    if (!AnimationCheck(playerid))
        return HataMesajGonder(playerid, "Þu anda animasyon gerçekleþtirilemiyor.");

    if (IsPlayerInAnyVehicle(playerid)) return 1;
    PlayAnimEx(playerid, "PED", "WALK_DRUNK", 4.0, 1, 1, 1, 1, 1, 1);
    return 1;
}

CMD:bomb(playerid, params[])
{
    if (!AnimationCheck(playerid))
        return HataMesajGonder(playerid, "Þu anda animasyon gerçekleþtirilemiyor.");

    if (IsPlayerInAnyVehicle(playerid)) return 1;
    PlayAnim(playerid, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 0, 1);
    return 1;
}

CMD:rob(playerid, params[])
{
    if (!AnimationCheck(playerid))
        return HataMesajGonder(playerid, "Þu anda animasyon gerçekleþtirilemiyor.");

    if (IsPlayerInAnyVehicle(playerid)) return 1;
    PlayAnimEx(playerid, "ped", "ARRESTgun", 4.0, 0, 1, 1, 1, 1, 1);
    return 1;
}

CMD:laugh(playerid, params[])
{
    if (!AnimationCheck(playerid))
        return HataMesajGonder(playerid, "Þu anda animasyon gerçekleþtirilemiyor.");

    if (IsPlayerInAnyVehicle(playerid)) return 1;
    PlayAnimEx(playerid, "RAPPING", "Laugh_01", 4.0, 1, 0, 0, 0, 0, 1);
    return 1;
}

CMD:lookout(playerid, params[])
{
    if (!AnimationCheck(playerid))
        return HataMesajGonder(playerid, "Þu anda animasyon gerçekleþtirilemiyor.");

    if (IsPlayerInAnyVehicle(playerid)) return 1;
    PlayAnim(playerid, "SHOP", "ROB_Shifty", 4.0, 0, 0, 0, 0, 0, 1);
    return 1;
}

CMD:robman(playerid, params[])
{
    if (!AnimationCheck(playerid))
        return HataMesajGonder(playerid, "Þu anda animasyon gerçekleþtirilemiyor.");

    if (IsPlayerInAnyVehicle(playerid)) return 1;
    PlayAnimEx(playerid, "SHOP", "ROB_Loop_Threat", 4.0, 1, 0, 0, 0, 0, 1);
    return 1;
}

CMD:hide(playerid, params[])
{
    if (!AnimationCheck(playerid))
        return HataMesajGonder(playerid, "Þu anda animasyon gerçekleþtirilemiyor.");

    if (IsPlayerInAnyVehicle(playerid)) return 1;
    PlayAnimEx(playerid, "ped", "cower", 3.0, 1, 0, 0, 0, 0, 1);
    return 1;
}

CMD:vomit(playerid, params[])
{
    if (!AnimationCheck(playerid))
        return HataMesajGonder(playerid, "Þu anda animasyon gerçekleþtirilemiyor.");

    if (IsPlayerInAnyVehicle(playerid)) return 1;
    PlayAnimEx(playerid, "FOOD", "EAT_Vomit_P", 3.0, 1, 0, 0, 0, 0, 1);
    return 1;
}

CMD:eat(playerid, params[])
{
    if (!AnimationCheck(playerid))
        return HataMesajGonder(playerid, "Þu anda animasyon gerçekleþtirilemiyor.");

    if (IsPlayerInAnyVehicle(playerid)) return 1;
    PlayAnimEx(playerid, "FOOD", "EAT_Burger", 3.0, 1, 0, 0, 0, 0, 1);
    return 1;
}

CMD:slapass(playerid, params[])
{
    if (!AnimationCheck(playerid))
        return HataMesajGonder(playerid, "Þu anda animasyon gerçekleþtirilemiyor.");

    if (IsPlayerInAnyVehicle(playerid)) return 1;
    PlayAnim(playerid, "SWEET", "sweet_ass_slap", 4.0, 0, 0, 0, 0, 0, 1);
    return 1;
}

CMD:crack(playerid, params[])
{
    if (!AnimationCheck(playerid))
        return HataMesajGonder(playerid, "Þu anda animasyon gerçekleþtirilemiyor.");

    if (IsPlayerInAnyVehicle(playerid)) return 1;
    PlayAnimEx(playerid, "CRACK", "crckdeth2", 4.0, 1, 0, 0, 0, 0, 1);
    return 1;
}

CMD:fucku(playerid, params[])
{
    if (!AnimationCheck(playerid))
        return HataMesajGonder(playerid, "Þu anda animasyon gerçekleþtirilemiyor.");

    if (IsPlayerInAnyVehicle(playerid)) return 1;
    PlayAnim(playerid, "PED", "fucku", 4.0, 0, 0, 0, 0, 0, 1);
    return 1;
}

CMD:taichi(playerid, params[])
{
    if (!AnimationCheck(playerid))
        return HataMesajGonder(playerid, "Þu anda animasyon gerçekleþtirilemiyor.");
    if (IsPlayerInAnyVehicle(playerid)) return 1;
    PlayAnimEx(playerid, "PARK", "Tai_Chi_Loop", 4.0, 1, 0, 0, 0, 0, 1);
    return 1;
}

CMD:drinkwater(playerid, params[])
{
    if (!AnimationCheck(playerid))
        return HataMesajGonder(playerid, "Þu anda animasyon gerçekleþtirilemiyor.");

    if (IsPlayerInAnyVehicle(playerid)) return 1;
    PlayAnimEx(playerid, "BAR", "dnk_stndF_loop", 4.0, 1, 0, 0, 0, 0, 1);
    return 1;
}

CMD:checktime(playerid, params[])
{
    if (!AnimationCheck(playerid)) return HataMesajGonder(playerid, "Þu anda animasyon gerçekleþtirilemiyor.");

    if (IsPlayerInAnyVehicle(playerid)) return 1;
    PlayAnim(playerid, "COP_AMBIENT", "Coplook_watch", 4.0, 0, 0, 0, 0, 0, 1);
    return 1;
}

CMD:sleep(playerid, params[])
{
    if (!AnimationCheck(playerid)) return HataMesajGonder(playerid, "Þu anda animasyon gerçekleþtirilemiyor.");
    if (IsPlayerInAnyVehicle(playerid)) return 1;
    PlayAnimEx(playerid, "CRACK", "crckdeth4", 4.0, 0, 1, 1, 1, 0, 1);
    return 1;
}

CMD:blob(playerid, params[])
{
    if (!AnimationCheck(playerid)) return HataMesajGonder(playerid, "Þu anda animasyon gerçekleþtirilemiyor.");
    if (IsPlayerInAnyVehicle(playerid)) return 1;
    PlayAnimEx(playerid, "CRACK", "crckidle1", 4.0, 0, 1, 1, 1, 0, 1);
    return 1;
}

CMD:opendoor(playerid, params[])
{
    if (!AnimationCheck(playerid)) return HataMesajGonder(playerid, "Þu anda animasyon gerçekleþtirilemiyor.");
    if (IsPlayerInAnyVehicle(playerid)) return 1;
    PlayAnim(playerid, "AIRPORT", "thrw_barl_thrw", 4.0, 0, 0, 0, 0, 0, 1);
    return 1;
}

CMD:wavedown(playerid, params[])
{
    if (!AnimationCheck(playerid)) return HataMesajGonder(playerid, "Þu anda animasyon gerçekleþtirilemiyor.");
    if (IsPlayerInAnyVehicle(playerid)) return 1;
    PlayAnim(playerid, "BD_FIRE", "BD_Panic_01", 4.0, 0, 0, 0, 0, 0, 1);
    return 1;
}

CMD:cpr(playerid, params[])
{
    if (!AnimationCheck(playerid)) return HataMesajGonder(playerid, "Þu anda animasyon gerçekleþtirilemiyor.");
    if (IsPlayerInAnyVehicle(playerid)) return 1;
    PlayAnim(playerid, "MEDIC", "CPR", 4.0, 0, 0, 0, 0, 0, 1);
    return 1;
}

CMD:dive(playerid, params[])
{
    if (!AnimationCheck(playerid)) return HataMesajGonder(playerid, "Þu anda animasyon gerçekleþtirilemiyor.");
    if (IsPlayerInAnyVehicle(playerid)) return 1;
    PlayAnimEx(playerid, "DODGE", "Crush_Jump", 4.0, 0, 1, 1, 1, 0, 1);
    return 1;
}

CMD:showoff(playerid, params[])
{
    if (!AnimationCheck(playerid)) return HataMesajGonder(playerid, "Þu anda animasyon gerçekleþtirilemiyor.");
    if (IsPlayerInAnyVehicle(playerid)) return 1;
    PlayAnimEx(playerid, "Freeweights", "gym_free_celebrate", 4.0, 1, 0, 0, 0, 0, 1);
    return 1;
}

CMD:goggles(playerid, params[])
{
    if (!AnimationCheck(playerid)) return HataMesajGonder(playerid, "Þu anda animasyon gerçekleþtirilemiyor.");
    if (IsPlayerInAnyVehicle(playerid)) return 1;
    PlayAnim(playerid, "goggles", "goggles_put_on", 4.0, 0, 0, 0, 0, 0, 1);
    return 1;
}

CMD:cry(playerid, params[])
{
    if (!AnimationCheck(playerid)) return HataMesajGonder(playerid, "Þu anda animasyon gerçekleþtirilemiyor.");
    if (IsPlayerInAnyVehicle(playerid)) return 1;
    PlayAnimEx(playerid, "GRAVEYARD", "mrnF_loop", 4.0, 1, 0, 0, 0, 0, 1);
    return 1;
}

CMD:throw(playerid, params[])
{
    if (!AnimationCheck(playerid)) return HataMesajGonder(playerid, "Þu anda animasyon gerçekleþtirilemiyor.");
    if (IsPlayerInAnyVehicle(playerid)) return 1;
    PlayAnim(playerid, "GRENADE", "WEAPON_throw", 4.0, 0, 0, 0, 0, 0, 1);
    return 1;
}

CMD:robbed(playerid, params[])
{
    if (!AnimationCheck(playerid)) return HataMesajGonder(playerid, "Þu anda animasyon gerçekleþtirilemiyor.");
    if (IsPlayerInAnyVehicle(playerid)) return 1;
    PlayAnimEx(playerid, "SHOP", "SHP_Rob_GiveCash", 4.0, 1, 0, 0, 0, 0, 1);
    return 1;
}

CMD:hurt(playerid, params[])
{
    if (!AnimationCheck(playerid)) return HataMesajGonder(playerid, "Þu anda animasyon gerçekleþtirilemiyor.");
    if (IsPlayerInAnyVehicle(playerid)) return 1;
    PlayAnimEx(playerid, "SWAT", "gnstwall_injurd", 4.0, 1, 0, 0, 0, 0, 1);
    return 1;
}

CMD:box(playerid, params[])
{
    if (!AnimationCheck(playerid)) return HataMesajGonder(playerid, "Þu anda animasyon gerçekleþtirilemiyor.");
    if (IsPlayerInAnyVehicle(playerid)) return 1;
    PlayAnimEx(playerid, "GYMNASIUM", "GYMshadowbox", 4.0, 1, 0, 0, 0, 0, 1);
    return 1;
}

CMD:washhands(playerid, params[])
{
    if (!AnimationCheck(playerid)) return HataMesajGonder(playerid, "Þu anda animasyon gerçekleþtirilemiyor.");
    if (IsPlayerInAnyVehicle(playerid)) return 1;
    PlayAnimEx(playerid, "BD_FIRE", "wash_up", 4.0, 1, 0, 0, 0, 0, 1);
    return 1;
}

CMD:crabs(playerid, params[])
{
    if (!AnimationCheck(playerid)) return HataMesajGonder(playerid, "Þu anda animasyon gerçekleþtirilemiyor.");
    if (IsPlayerInAnyVehicle(playerid)) return 1;
    PlayAnimEx(playerid, "MISC", "Scratchballs_01", 4.0, 1, 0, 0, 0, 0, 1);
    return 1;
}

CMD:salute(playerid, params[])
{
    if (!AnimationCheck(playerid)) return HataMesajGonder(playerid, "Þu anda animasyon gerçekleþtirilemiyor.");
    if (IsPlayerInAnyVehicle(playerid)) return 1;
    PlayAnimEx(playerid, "ON_LOOKERS", "Pointup_loop", 4.0, 1, 0, 0, 0, 0, 1);
    return 1;
}

CMD:jerkoff(playerid, params[])
{
    if (!AnimationCheck(playerid)) return HataMesajGonder(playerid, "Þu anda animasyon gerçekleþtirilemiyor.");
    if (IsPlayerInAnyVehicle(playerid)) return 1;
    PlayAnimEx(playerid, "PAULNMAC", "wank_out", 4.0, 1, 0, 0, 0, 0, 1);
    return 1;
}

CMD:stop(playerid, params[])
{
    if (!AnimationCheck(playerid)) return HataMesajGonder(playerid, "Þu anda animasyon gerçekleþtirilemiyor.");
    if (IsPlayerInAnyVehicle(playerid)) return 1;
    PlayAnimEx(playerid, "PED", "endchat_01", 4.0, 1, 0, 0, 0, 0, 1);
    return 1;
}

CMD:rap(playerid, params[])
{
    if (!AnimationCheck(playerid)) return HataMesajGonder(playerid, "Þu anda animasyon gerçekleþtirilemiyor.");
    if (IsPlayerInAnyVehicle(playerid)) return 1;
    switch (strval(params))
    {
        case 1: PlayAnimEx(playerid, "RAPPING", "RAP_A_Loop", 4.0, 1, 0, 0, 0, 0, 1);
        case 2: PlayAnimEx(playerid, "RAPPING", "RAP_B_Loop", 4.0, 1, 0, 0, 0, 0, 1);
        case 3: PlayAnimEx(playerid, "RAPPING", "RAP_C_Loop", 4.0, 1, 0, 0, 0, 0, 1);
        default: KullanimMesajGonder(playerid, "/rap [1-3]");
    }
    return 1;
}

CMD:wank(playerid, params[])
{
    if (!AnimationCheck(playerid)) return HataMesajGonder(playerid, "Þu anda animasyon gerçekleþtirilemiyor.");
    if (IsPlayerInAnyVehicle(playerid)) return 1;
    switch (strval(params))
    {
        case 1: PlayAnimEx(playerid, "PAULNMAC", "wank_in", 4.0, 1, 0, 0, 0, 0, 1);
        case 2: PlayAnimEx(playerid, "PAULNMAC", "wank_loop", 4.0, 1, 0, 0, 0, 0, 1);
        case 3: PlayAnimEx(playerid, "PAULNMAC", "wank_out", 4.0, 1, 0, 0, 0, 0, 1);
        default: KullanimMesajGonder(playerid, "/wank [1-3]");
    }
    return 1;
}

CMD:chat(playerid, params[])
{
    if (!AnimationCheck(playerid)) return HataMesajGonder(playerid, "Þu anda animasyon gerçekleþtirilemiyor.");
    if (IsPlayerInAnyVehicle(playerid)) return 1;
    switch (strval(params))
    {
        case 1: PlayAnimEx(playerid, "PED", "IDLE_CHAT", 4.0, 1, 0, 0, 0, 0, 1);
        case 2: PlayAnimEx(playerid, "GANGS", "prtial_gngtlkA", 4.0, 1, 0, 0, 0, 0, 1);
        case 3: PlayAnimEx(playerid, "GANGS", "prtial_gngtlkB", 4.0, 1, 0, 0, 0, 0, 1);
        case 4: PlayAnimEx(playerid, "GANGS", "prtial_gngtlkE", 4.0, 1, 0, 0, 0, 0, 1);
        case 5: PlayAnimEx(playerid, "GANGS", "prtial_gngtlkF", 4.0, 1, 0, 0, 0, 0, 1);
        case 6: PlayAnimEx(playerid, "GANGS", "prtial_gngtlkG", 4.0, 1, 0, 0, 0, 0, 1);
        case 7: PlayAnimEx(playerid, "GANGS", "prtial_gngtlkH", 4.0, 1, 0, 0, 0, 0, 1);
        default: KullanimMesajGonder(playerid, "/chat [1-7]");
    }
    return 1;
}

CMD:sit(playerid, params[])
{
    if (!AnimationCheck(playerid)) return HataMesajGonder(playerid, "Þu anda animasyon gerçekleþtirilemiyor.");
    if (IsPlayerInAnyVehicle(playerid)) return 1;
    switch (strval(params))
    {
        case 1: PlayAnimEx(playerid, "Attractors", "Stepsit_in", 4.0, 0, 0, 0, 1, 0, 1);
        case 2: PlayAnimEx(playerid, "CRIB", "PED_Console_Loop", 4.0, 1, 0, 0, 0, 0, 1);
        case 3: PlayAnimEx(playerid, "INT_HOUSE", "LOU_In", 4.0, 0, 0, 0, 1, 1, 1);
        case 4: PlayAnimEx(playerid, "MISC", "SEAT_LR", 4.0, 1, 0, 0, 0, 0, 1);
        case 5: PlayAnimEx(playerid, "MISC", "Seat_talk_01", 4.0, 1, 0, 0, 0, 0, 1);
        case 6: PlayAnimEx(playerid, "MISC", "Seat_talk_02", 4.0, 1, 0, 0, 0, 0, 1);
        case 7: PlayAnimEx(playerid, "ped", "SEAT_down", 4.0, 0, 0, 0, 1, 1, 1);
        default: KullanimMesajGonder(playerid, "/sit [1-7]");
    }
    return 1;
}

CMD:bat(playerid, params[])
{
    if (!AnimationCheck(playerid)) return HataMesajGonder(playerid, "Þu anda animasyon gerçekleþtirilemiyor.");
    if (IsPlayerInAnyVehicle(playerid)) return 1;
    switch (strval(params))
    {
        case 1: PlayAnimEx(playerid, "BASEBALL", "Bat_IDLE",4.1, 0, 1, 1, 1, 1, 1);
        case 2: PlayAnimEx(playerid, "CRACK", "Bbalbat_Idle_01", 4.0, 1, 0, 0, 0, 0, 1);
        case 3: PlayAnimEx(playerid, "CRACK", "Bbalbat_Idle_02", 4.0, 1, 0, 0, 0, 0, 1);
        default: KullanimMesajGonder(playerid, "/bat [1-3]");
    }
    return 1;
}

CMD:lean(playerid, params[])
{
    if (!AnimationCheck(playerid)) return HataMesajGonder(playerid, "Þu anda animasyon gerçekleþtirilemiyor.");
    if (IsPlayerInAnyVehicle(playerid)) return 1;
    switch (strval(params))
    {
        case 1: PlayAnimEx(playerid, "GANGS", "leanIDLE", 4.0, 0, 0, 0, 1, 0, 1);
        case 2: PlayAnimEx(playerid, "MISC", "Plyrlean_loop", 4.0, 0, 0, 0, 1, 0, 1);
        default: KullanimMesajGonder(playerid, "/lean [1-2]");
    }
    return 1;
}

CMD:gesture(playerid, params[])
{
    if (!AnimationCheck(playerid)) return HataMesajGonder(playerid, "Þu anda animasyon gerçekleþtirilemiyor.");
    if (IsPlayerInAnyVehicle(playerid)) return 1;
    switch (strval(params))
    {
    case 1: PlayAnim(playerid, "GHANDS", "gsign1", 4.0, 0, 0, 0, 0, 0, 1);
    case 2: PlayAnim(playerid, "GHANDS", "gsign1LH", 4.0, 0, 0, 0, 0, 0, 1);
    case 3: PlayAnim(playerid, "GHANDS", "gsign2", 4.0, 0, 0, 0, 0, 0, 1);
    case 4: PlayAnim(playerid, "GHANDS", "gsign2LH", 4.0, 0, 0, 0, 0, 0, 1);
    case 5: PlayAnim(playerid, "GHANDS", "gsign3", 4.0, 0, 0, 0, 0, 0, 1);
    case 6: PlayAnim(playerid, "GHANDS", "gsign3LH", 4.0, 0, 0, 0, 0, 0, 1);
    case 7: PlayAnim(playerid, "GHANDS", "gsign4", 4.0, 0, 0, 0, 0, 0, 1);
    case 8: PlayAnim(playerid, "GHANDS", "gsign4LH", 4.0, 0, 0, 0, 0, 0, 1);
    case 9: PlayAnim(playerid, "GHANDS", "gsign5", 4.0, 0, 0, 0, 0, 0, 1);
    case 10: PlayAnim(playerid, "GHANDS", "gsign5", 4.0, 0, 0, 0, 0, 0, 1);
    case 11: PlayAnim(playerid, "GHANDS", "gsign5LH", 4.0, 0, 0, 0, 0, 0, 1);
    case 12: PlayAnim(playerid, "GANGS", "Invite_No", 4.0, 0, 0, 0, 0, 0, 1);
    case 13: PlayAnim(playerid, "GANGS", "Invite_Yes", 4.0, 0, 0, 0, 0, 0, 1);
    case 14: PlayAnim(playerid, "GANGS", "prtial_gngtlkD", 4.0, 0, 0, 0, 0, 0, 1);
    case 15: PlayAnim(playerid, "GANGS", "smkcig_prtl", 4.0, 0, 0, 0, 0, 0, 1);
    default: KullanimMesajGonder(playerid, "/gesture [1-15]");
    }
    return 1;
}

CMD:lay(playerid, params[])
{
    if (!AnimationCheck(playerid)) return HataMesajGonder(playerid, "Þu anda animasyon gerçekleþtirilemiyor.");
    if (IsPlayerInAnyVehicle(playerid)) return 1;
    switch (strval(params))
    {
    case 1: PlayAnimEx(playerid, "BEACH", "bather", 4.0, 1, 0, 0, 0, 0, 1);
    case 2: PlayAnimEx(playerid, "BEACH", "Lay_Bac_Loop", 4.0, 1, 0, 0, 0, 0, 1);
    case 3: PlayAnimEx(playerid, "BEACH", "SitnWait_loop_W", 4.0, 1, 0, 0, 0, 0, 1);
    case 4: PlayAnimEx(playerid, "BEACH", "bather", 4.0, 1, 0, 0, 0, 0, 1);
    case 5: PlayAnimEx(playerid, "BEACH", "Lay_Bac_Loop", 4.0, 1, 0, 0, 0, 0, 1);
    case 6: PlayAnimEx(playerid, "BEACH", "ParkSit_W_loop", 4.0, 1, 0, 0, 0, 0, 1);
    case 7: PlayAnimEx(playerid, "BEACH", "SitnWait_loop_W", 4.0, 1, 0, 0, 0, 0, 1);
    case 8: PlayAnimEx(playerid, "BEACH", "ParkSit_M_loop", 4.0, 1, 0, 0, 0, 0, 1);
    default: KullanimMesajGonder(playerid, "/lay [1-8]");
    }
    return 1;
}

CMD:wave(playerid, params[])
{
    if (!AnimationCheck(playerid)) return HataMesajGonder(playerid, "Þu anda animasyon gerçekleþtirilemiyor.");
    if (IsPlayerInAnyVehicle(playerid)) return 1;
    switch (strval(params))
    {
    case 1: PlayAnimEx(playerid, "ON_LOOKERS", "wave_loop", 4.0, 1, 0, 0, 0, 0, 1);
    case 2: PlayAnimEx(playerid, "KISSING", "gfwave2", 4.0, 1, 0, 0, 0, 0, 1);
    case 3: PlayAnimEx(playerid, "PED", "endchat_03", 4.0, 1, 0, 0, 0, 0, 1);
    default: KullanimMesajGonder(playerid, "/wave [1-3]");
    }
    return 1;
}

CMD:signal(playerid, params[])
{
    if (!AnimationCheck(playerid)) return HataMesajGonder(playerid, "Þu anda animasyon gerçekleþtirilemiyor.");
    if (IsPlayerInAnyVehicle(playerid)) return 1;
    switch (strval(params))
    {
    case 1: PlayAnimEx(playerid, "POLICE", "CopTraf_Come", 4.0, 1, 0, 0, 0, 0, 1);
    case 2: PlayAnimEx(playerid, "POLICE", "CopTraf_Stop", 4.0, 1, 0, 0, 0, 0, 1);
    default: KullanimMesajGonder(playerid, "/signal [1-2]");
    }
    return 1;
}

CMD:nobreath(playerid, params[])
{
    if (!AnimationCheck(playerid)) return HataMesajGonder(playerid, "Þu anda animasyon gerçekleþtirilemiyor.");
    if (IsPlayerInAnyVehicle(playerid)) return 1;
    switch (strval(params))
    {
    case 1: PlayAnimEx(playerid, "SWEET", "Sweet_injuredloop", 4.0, 1, 0, 0, 0, 0, 1);
    case 2: PlayAnimEx(playerid, "PED", "IDLE_tired", 4.0, 1, 0, 0, 0, 0, 1);
    case 3: PlayAnimEx(playerid, "FAT", "IDLE_tired", 4.0, 1, 0, 0, 0, 0, 1);
    default: KullanimMesajGonder(playerid, "/nobreath [1-3]");
    }
    return 1;
}

CMD:fallover(playerid, params[])
{
    if (!AnimationCheck(playerid)) return HataMesajGonder(playerid, "Þu anda animasyon gerçekleþtirilemiyor.");
    if (IsPlayerInAnyVehicle(playerid)) return 1;
    switch (strval(params))
    {
    case 1: PlayAnimEx(playerid, "KNIFE", "KILL_Knife_Ped_Die", 4.0, 0, 1, 1, 1, 0, 1);
    case 2: PlayAnimEx(playerid, "PED", "KO_shot_face", 4.0, 0, 1, 1, 1, 0, 1);
    case 3: PlayAnimEx(playerid, "PED", "KO_shot_stom", 4.0, 0, 1, 1, 1, 0, 1);
    case 4: PlayAnimEx(playerid, "PED", "BIKE_fallR", 4.1, 0, 1, 1, 1, 0, 1);
    case 5: PlayAnimEx(playerid, "PED", "BIKE_fall_off", 4.1, 0, 1, 1, 1, 0, 1);
    default: KullanimMesajGonder(playerid, "/fallover [1-5]");
    }
    return 1;
}

CMD:myskin(playerid, params[])
{
    if (!AnimationCheck(playerid)) return HataMesajGonder(playerid, "Þu anda animasyon gerçekleþtirilemiyor.");
    if (IsPlayerInAnyVehicle(playerid)) return 1;
    switch (strval(params))
    {
    case 1: SetPlayerSkin(playerid,101);
    case 2: PlayAnimEx(playerid, "PED", "JOG_maleA", 4.0, 1, 1, 1, 1, 1, 1);
    case 3: PlayAnimEx(playerid, "PED", "WOMAN_walkfatold", 4.0, 1, 1, 1, 1, 1, 1);
    case 4: PlayAnimEx(playerid, "PED", "run_fat", 4.0, 1, 1, 1, 1, 1, 1);
    case 5: PlayAnimEx(playerid, "PED", "run_fatold", 4.0, 1, 1, 1, 1, 1, 1);
    case 6: PlayAnimEx(playerid, "PED", "run_old", 4.0, 1, 1, 1, 1, 1, 1);
    case 7: PlayAnimEx(playerid, "PED", "Run_Wuzi", 4.0, 1, 1, 1, 1, 1, 1);
    case 8: PlayAnimEx(playerid, "PED", "swat_run", 4.0, 1, 1, 1, 1, 1, 1);
    case 9: PlayAnimEx(playerid, "PED", "WALK_fat", 4.0, 1, 1, 1, 1, 1, 1);
    case 10: PlayAnimEx(playerid, "PED", "WALK_fatold", 4.0, 1, 1, 1, 1, 1, 1);
    case 11: PlayAnimEx(playerid, "PED", "WALK_gang1", 4.0, 1, 1, 1, 1, 1, 1);
    case 12: PlayAnimEx(playerid, "PED", "WALK_gang2", 4.0, 1, 1, 1, 1, 1, 1);
    case 13: PlayAnimEx(playerid, "PED", "WALK_old", 4.0, 1, 1, 1, 1, 1, 1);
    case 14: PlayAnimEx(playerid, "PED", "WALK_shuffle", 4.0, 1, 1, 1, 1, 1, 1);
    case 15: PlayAnimEx(playerid, "PED", "woman_run", 4.0, 1, 1, 1, 1, 1, 1);
    case 16: PlayAnimEx(playerid, "PED", "WOMAN_runbusy", 4.0, 1, 1, 1, 1, 1, 1);
    case 17: PlayAnimEx(playerid, "PED", "WOMAN_runfatold", 4.0, 1, 1, 1, 1, 1, 1);
    case 18: PlayAnimEx(playerid, "PED", "woman_runpanic", 4.0, 1, 1, 1, 1, 1, 1);
    case 19: PlayAnimEx(playerid, "PED", "WOMAN_runsexy", 4.0, 1, 1, 1, 1, 1, 1);
    case 20: PlayAnimEx(playerid, "PED", "WOMAN_walkbusy", 4.0, 1, 1, 1, 1, 1, 1);
    case 21: PlayAnimEx(playerid, "PED", "WOMAN_walkfatold", 4.0, 1, 1, 1, 1, 1, 1);
    case 22: PlayAnimEx(playerid, "PED", "WOMAN_walknorm", 4.0, 1, 1, 1, 1, 1, 1);
    case 23: PlayAnimEx(playerid, "PED", "WOMAN_walkold", 4.0, 1, 1, 1, 1, 1, 1);
    case 24: PlayAnimEx(playerid, "PED", "WOMAN_walkpro", 4.0, 1, 1, 1, 1, 1, 1);
    case 25: PlayAnimEx(playerid, "PED", "WOMAN_walksexy", 4.0, 1, 1, 1, 1, 1, 1);
    case 26: PlayAnimEx(playerid, "PED", "WOMAN_walkshop", 4.0, 1, 1, 1, 1, 1, 1);
    default: KullanimMesajGonder(playerid, "/pedmove [1-26]");
    }
    return 1;
}

CMD:getjiggy(playerid, params[])
{
    if (!AnimationCheck(playerid)) return HataMesajGonder(playerid, "Þu anda animasyon gerçekleþtirilemiyor.");
    if (IsPlayerInAnyVehicle(playerid)) return 1;
    switch (strval(params))
    {
    case 1: PlayAnimEx(playerid, "DANCING", "DAN_Down_A", 4.0, 1, 0, 0, 0, 0, 1);
    case 2: PlayAnimEx(playerid, "DANCING", "DAN_Left_A", 4.0, 1, 0, 0, 0, 0, 1);
    case 3: PlayAnimEx(playerid, "DANCING", "DAN_Loop_A", 4.0, 1, 0, 0, 0, 0, 1);
    case 4: PlayAnimEx(playerid, "DANCING", "DAN_Right_A", 4.0, 1, 0, 0, 0, 0, 1);
    case 5: PlayAnimEx(playerid, "DANCING", "DAN_Up_A", 4.0, 1, 0, 0, 0, 0, 1);
    case 6: PlayAnimEx(playerid, "DANCING", "dnce_M_a", 4.0, 1, 0, 0, 0, 0, 1);
    case 7: PlayAnimEx(playerid, "DANCING", "dnce_M_b", 4.0, 1, 0, 0, 0, 0, 1);
    case 8: PlayAnimEx(playerid, "DANCING", "dnce_M_c", 4.0, 1, 0, 0, 0, 0, 1);
    case 9: PlayAnimEx(playerid, "DANCING", "dnce_M_c", 4.0, 1, 0, 0, 0, 0, 1);
    case 10: PlayAnimEx(playerid, "DANCING", "dnce_M_d", 4.0, 1, 0, 0, 0, 0, 1);
    default: KullanimMesajGonder(playerid, "/getjiggy [1-10]");
    }
    return 1;
}

CMD:stripclub(playerid, params[])
{
    if (!AnimationCheck(playerid)) return HataMesajGonder(playerid, "Þu anda animasyon gerçekleþtirilemiyor.");
    if (IsPlayerInAnyVehicle(playerid)) return 1;
    switch (strval(params))
    {
    case 1: PlayAnimEx(playerid, "STRIP", "PLY_CASH", 4.0, 1, 0, 0, 0, 0, 1);
    case 2: PlayAnimEx(playerid, "STRIP", "PUN_CASH", 4.0, 1, 0, 0, 0, 0, 1);
    default: KullanimMesajGonder(playerid, "/stripclub [1-2]");
    }
    return 1;
}

CMD:smoke(playerid, params[])
{
    if (!AnimationCheck(playerid)) return HataMesajGonder(playerid, "Þu anda animasyon gerçekleþtirilemiyor.");
    if (IsPlayerInAnyVehicle(playerid)) return 1;
    switch (strval(params))
    {
    case 1: PlayAnim(playerid, "SMOKING", "M_smk_in", 4.0, 0, 0, 0, 0, 0, 1);
    case 2: PlayAnimEx(playerid, "SMOKING", "M_smklean_loop", 4.0, 1, 0, 0, 0, 0, 1);
    default: KullanimMesajGonder(playerid, "/smoke [1-2]");
    }
    return 1;
}

CMD:dj(playerid, params[])
{
    if (!AnimationCheck(playerid)) return HataMesajGonder(playerid, "Þu anda animasyon gerçekleþtirilemiyor.");
    if (IsPlayerInAnyVehicle(playerid)) return 1;
    switch (strval(params))
    {
        case 1: PlayAnimEx(playerid, "SCRATCHING", "scdldlp", 4.0, 1, 0, 0, 0, 0, 1);
        case 2: PlayAnimEx(playerid, "SCRATCHING", "scdlulp", 4.0, 1, 0, 0, 0, 0, 1);
        case 3: PlayAnimEx(playerid, "SCRATCHING", "scdrdlp", 4.0, 1, 0, 0, 0, 0, 1);
        case 4: PlayAnimEx(playerid, "SCRATCHING", "scdrulp", 4.0, 1, 0, 0, 0, 0, 1);
        default: KullanimMesajGonder(playerid, "/dj [1-4]");
    }
    return 1;
}

CMD:reload(playerid, params[])
{
    if (!AnimationCheck(playerid)) return HataMesajGonder(playerid, "Þu anda animasyon gerçekleþtirilemiyor.");
    if (IsPlayerInAnyVehicle(playerid)) return 1;
    switch (strval(params))
    {
    case 1: PlayAnim(playerid, "BUDDY", "buddy_reload", 4.0, 0, 0, 0, 0, 0, 1);
    case 2: PlayAnim(playerid, "PYTHON", "python_reload", 4.0, 0, 0, 0, 0, 0, 1);
    default: KullanimMesajGonder(playerid, "/reload [1-2]");
    }
    return 1;
}

CMD:tag(playerid, params[])
{
    if (!AnimationCheck(playerid)) return HataMesajGonder(playerid, "Þu anda animasyon gerçekleþtirilemiyor.");
    if (IsPlayerInAnyVehicle(playerid)) return 1;
    switch (strval(params))
    {
    case 1: PlayAnimEx(playerid, "GRAFFITI", "graffiti_Chkout", 4.0, 1, 0, 0, 0, 0, 1);
    case 2: PlayAnimEx(playerid, "GRAFFITI", "spraycan_fire", 4.0, 1, 0, 0, 0, 0, 1);
    default: KullanimMesajGonder(playerid, "/tag [1-2]");
    }
    return 1;
}

CMD:deal(playerid, params[])
{
    if (!AnimationCheck(playerid)) return HataMesajGonder(playerid, "Þu anda animasyon gerçekleþtirilemiyor.");
    if (IsPlayerInAnyVehicle(playerid)) return 1;
    switch (strval(params))
    {
    case 1: PlayAnimEx(playerid, "DEALER", "DEALER_DEAL", 4.0, 1, 0, 0, 0, 0, 1);
    case 2: PlayAnimEx(playerid, "DEALER", "shop_pay", 4.0, 1, 0, 0, 0, 0, 1);
    default: KullanimMesajGonder(playerid, "/deal [1-2]");
    }
    return 1;
}

CMD:crossarms(playerid, params[])
{
    if (!AnimationCheck(playerid)) return HataMesajGonder(playerid, "Þu anda animasyon gerçekleþtirilemiyor.");
    if (IsPlayerInAnyVehicle(playerid)) return 1;
    switch (strval(params))
    {
        case 1: PlayAnimEx(playerid, "COP_AMBIENT", "Coplook_loop", 4.0, 0, 1, 1, 1, -1, 1);
        case 2: PlayAnimEx(playerid, "DEALER", "DEALER_IDLE", 4.0, 1, 0, 0, 0, 0, 1);
        case 3: PlayAnimEx(playerid, "GRAVEYARD", "mrnM_loop", 4.0, 1, 0, 0, 0, 0, 1);
        case 4: PlayAnimEx(playerid, "GRAVEYARD", "prst_loopa", 4.0, 1, 0, 0, 0, 0, 1);
        case 5: PlayAnimEx(playerid, "DEALER", "DEALER_IDLE_01", 4.0, 1, 0, 0, 0, 0, 1);
        default: KullanimMesajGonder(playerid, "/crossarms [1-5]");
    }
    return 1;
}

CMD:cheer(playerid, params[])
{
    if (!AnimationCheck(playerid)) return HataMesajGonder(playerid, "Þu anda animasyon gerçekleþtirilemiyor.");
    if (IsPlayerInAnyVehicle(playerid)) return 1;
    switch (strval(params))
    {
    case 1: PlayAnimEx(playerid, "ON_LOOKERS", "shout_01", 4.0, 1, 0, 0, 0, 0, 1);
    case 2: PlayAnimEx(playerid, "ON_LOOKERS", "shout_02", 4.0, 1, 0, 0, 0, 0, 1);
    case 3: PlayAnimEx(playerid, "ON_LOOKERS", "shout_in", 4.0, 1, 0, 0, 0, 0, 1);
    case 4: PlayAnimEx(playerid, "RIOT", "RIOT_ANGRY_B", 4.0, 1, 0, 0, 0, 0, 1);
    case 5: PlayAnimEx(playerid, "RIOT", "RIOT_CHANT", 4.0, 1, 0, 0, 0, 0, 1);
    case 6: PlayAnimEx(playerid, "RIOT", "RIOT_shout", 4.0, 1, 0, 0, 0, 0, 1);
    case 7: PlayAnimEx(playerid, "STRIP", "PUN_HOLLER", 4.0, 1, 0, 0, 0, 0, 1);
    case 8: PlayAnimEx(playerid, "OTB", "wtchrace_win", 4.0, 1, 0, 0, 0, 0, 1);
    default: KullanimMesajGonder(playerid, "/cheer [1-8]");
    }
    return 1;
}

CMD:siteat(playerid, params[])
{
    if (!AnimationCheck(playerid)) return HataMesajGonder(playerid, "Þu anda animasyon gerçekleþtirilemiyor.");
    if (IsPlayerInAnyVehicle(playerid)) return 1;
    switch (strval(params))
    {
    case 1: PlayAnimEx(playerid, "FOOD", "FF_Sit_Eat3", 4.0, 1, 0, 0, 0, 0, 1);
    case 2: PlayAnimEx(playerid, "FOOD", "FF_Sit_Eat2", 4.0, 1, 0, 0, 0, 0, 1);
    default: KullanimMesajGonder(playerid, "/siteat [1-2]");
    }
    return 1;
}

CMD:bar(playerid, params[])
{
    if (!AnimationCheck(playerid)) return HataMesajGonder(playerid, "Þu anda animasyon gerçekleþtirilemiyor.");
    if (IsPlayerInAnyVehicle(playerid)) return 1;
    switch (strval(params))
    {
    case 1: PlayAnim(playerid, "BAR", "Barcustom_get", 4.0, 0, 1, 0, 0, 0, 1);
    case 2: PlayAnim(playerid, "BAR", "Barserve_bottle", 4.0, 0, 0, 0, 0, 0, 1);
    case 3: PlayAnim(playerid, "BAR", "Barserve_give", 4.0, 0, 0, 0, 0, 0, 1);
    case 4: PlayAnim(playerid, "BAR", "dnk_stndM_loop", 4.0, 0, 0, 0, 0, 0, 1);
    case 5: PlayAnimEx(playerid, "BAR", "BARman_idle", 4.0, 1, 0, 0, 0, 0, 1);
    default: KullanimMesajGonder(playerid, "/bar [1-5]");
    }
    return 1;
}

CMD:dance(playerid, params[])
{
    if (!AnimationCheck(playerid)) return HataMesajGonder(playerid, "Þu anda animasyon gerçekleþtirilemiyor.");
    if (IsPlayerInAnyVehicle(playerid)) return 1;
    if (GetPlayerAnimationIndex(playerid) != 0) ClearAnimations(playerid);

    switch (strval(params))
    {
        case 1: SetPlayerSpecialAction(playerid, 5);
        case 2: SetPlayerSpecialAction(playerid, 6);
        case 3: SetPlayerSpecialAction(playerid, 7);
        case 4: SetPlayerSpecialAction(playerid, 8);
        default: KullanimMesajGonder(playerid, "/dance [1-4]");
    }
    return 1;
}

CMD:spank(playerid, params[])
{
    if (!AnimationCheck(playerid)) return HataMesajGonder(playerid, "Þu anda animasyon gerçekleþtirilemiyor.");
    if (IsPlayerInAnyVehicle(playerid)) return 1;
    switch (strval(params))
    {
        case 1: PlayAnimEx(playerid, "SNM", "SPANKINGW", 4.1, 1, 0, 0, 0, 0, 1);
        case 2: PlayAnimEx(playerid, "SNM", "SPANKINGP", 4.1, 1, 0, 0, 0, 0, 1);
        case 3: PlayAnimEx(playerid, "SNM", "SPANKEDW", 4.1, 1, 0, 0, 0, 0, 1);
        case 4: PlayAnimEx(playerid, "SNM", "SPANKEDP", 4.1, 1, 0, 0, 0, 0, 1);
        default: KullanimMesajGonder(playerid, "/spank [1-4]");
    }
    return 1;
}

CMD:sexy(playerid, params[])
{
    if (!AnimationCheck(playerid)) return HataMesajGonder(playerid, "Þu anda animasyon gerçekleþtirilemiyor.");
    if (IsPlayerInAnyVehicle(playerid)) return 1;
    switch (strval(params))
    {
    case 1: PlayAnimEx(playerid, "STRIP", "strip_E", 4.1, 1, 0, 0, 0, 0, 1);
    case 2: PlayAnimEx(playerid, "STRIP", "strip_G", 4.1, 1, 0, 0, 0, 0, 1);
    case 3: PlayAnim(playerid, "STRIP", "STR_A2B", 4.1, 0, 0, 0, 0, 0, 1);
    case 4: PlayAnimEx(playerid, "STRIP", "STR_Loop_A", 4.1, 1, 0, 0, 0, 0, 1);
    case 5: PlayAnimEx(playerid, "STRIP", "STR_Loop_B", 4.1, 1, 0, 0, 0, 0, 1);
    case 6: PlayAnimEx(playerid, "STRIP", "STR_Loop_C", 4.1, 1, 0, 0, 0, 0, 1);
    default: KullanimMesajGonder(playerid, "/sexy [1-6]");
    }
    return 1;
}

CMD:holdup(playerid, params[])
{
    if (!AnimationCheck(playerid)) return HataMesajGonder(playerid, "Þu anda animasyon gerçekleþtirilemiyor.");
    if (IsPlayerInAnyVehicle(playerid)) return 1;
    switch (strval(params))
    {
    case 1: PlayAnimEx(playerid, "POOL", "POOL_ChalkCue", 4.1, 0, 1, 1, 1, 1, 1);
    case 2: PlayAnimEx(playerid, "POOL", "POOL_Idle_Stance", 4.1, 0, 1, 1, 1, 1, 1);
    default: KullanimMesajGonder(playerid, "/holdup [1-2]");
    }
    return 1;
}

CMD:stickjup(playerid, params[])
{
    if (!AnimationCheck(playerid)) return HataMesajGonder(playerid, "Þu anda animasyon gerçekleþtirilemiyor.");
    PlayAnimEx(playerid, "POOL", "POOL_Idle_Stance", 4.1, 0, 1, 1, 1, 1, 1);
    return 1;
}

CMD:copa(playerid, params[])
{
    if (!AnimationCheck(playerid)) return HataMesajGonder(playerid, "Þu anda animasyon gerçekleþtirilemiyor.");
    if (IsPlayerInAnyVehicle(playerid)) return 1;
    switch (strval(params))
    {
    case 1: PlayAnim(playerid, "POLICE", "CopTraf_Away", 4.1, 0, 0, 0, 0, 0, 1);
    case 2: PlayAnim(playerid, "POLICE", "CopTraf_Come", 4.1, 0, 0, 0, 0, 0, 1);
    case 3: PlayAnim(playerid, "POLICE", "CopTraf_Left", 4.1, 0, 0, 0, 0, 0, 1);
    case 4: PlayAnim(playerid, "POLICE", "CopTraf_Stop", 4.1, 0, 0, 0, 0, 0, 1);
    case 5: PlayAnimEx(playerid, "POLICE", "Cop_move_FWD", 4.1, 1, 1, 1, 1, 1, 1);
    case 6: PlayAnimEx(playerid, "POLICE", "crm_drgbst_01", 4.1, 0, 0, 0, 1, 5000, 1);
    case 7: PlayAnim(playerid, "POLICE", "Door_Kick", 4.1, 0, 1, 1, 1, 1, 1);
    case 8: PlayAnim(playerid, "POLICE", "plc_drgbst_01", 4.1, 0, 0, 0, 0, 5000, 1);
    case 9: PlayAnim(playerid, "POLICE", "plc_drgbst_02", 4.1, 0, 0, 0, 0, 0, 1);
    default: KullanimMesajGonder(playerid, "/copa [1-9]");
    }
    return 1;
}

CMD:misc(playerid, params[])
{
    if (!AnimationCheck(playerid)) return HataMesajGonder(playerid, "Þu anda animasyon gerçekleþtirilemiyor.");
    if (IsPlayerInAnyVehicle(playerid)) return 1;
    switch (strval(params))
    {
    case 1: PlayAnimEx(playerid, "CAR", "Fixn_Car_Loop", 4.1, 1, 0, 0, 0, 0, 1);
    case 2: PlayAnim(playerid, "CAR", "flag_drop", 4.1, 0, 0, 0, 0, 0, 1);
    case 3: PlayAnim(playerid, "PED", "bomber", 4.1, 0, 0, 0, 0, 0, 1);
    default: KullanimMesajGonder(playerid, "/misc [1-3]");
    }
    return 1;
}

CMD:snatch(playerid, params[])
{
    if (!AnimationCheck(playerid)) return HataMesajGonder(playerid, "Þu anda animasyon gerçekleþtirilemiyor.");
    if (IsPlayerInAnyVehicle(playerid)) return 1;
    switch (strval(params))
    {
    case 1: PlayAnim(playerid, "PED", "BIKE_elbowL", 4.1, 0, 0, 0, 0, 0, 1);
    case 2: PlayAnim(playerid, "PED", "BIKE_elbowR", 4.1, 0, 0, 0, 0, 0, 1);
    default: KullanimMesajGonder(playerid, "/snatch [1-2]");
    }
    return 1;
}

CMD:blowjob(playerid, params[])
{
    if (!AnimationCheck(playerid)) return HataMesajGonder(playerid, "Þu anda animasyon gerçekleþtirilemiyor.");
    if (IsPlayerInAnyVehicle(playerid)) return 1;
    switch (strval(params))
    {
    case 1: PlayAnimEx(playerid, "BLOWJOBZ", "BJ_COUCH_LOOP_P", 4.1, 1, 0, 0, 0, 0, 1);
    case 2: PlayAnimEx(playerid, "BLOWJOBZ", "BJ_STAND_LOOP_P", 4.1, 1, 0, 0, 0, 0, 1);
    default: KullanimMesajGonder(playerid, "/blowjob [1-2]");
    }
    return 1;
}

CMD:kiss(playerid, params[])
{
    if (!AnimationCheck(playerid)) return HataMesajGonder(playerid, "Þu anda animasyon gerçekleþtirilemiyor.");
    if (IsPlayerInAnyVehicle(playerid)) return 1;
    switch (strval(params))
    {
    case 1: PlayAnim(playerid, "KISSING", "Playa_Kiss_01", 4.1, 0, 0, 0, 0, 0, 1);
    case 2: PlayAnim(playerid, "KISSING", "Playa_Kiss_02", 4.1, 0, 0, 0, 0, 0, 1);
    case 3: PlayAnim(playerid, "KISSING", "Playa_Kiss_03", 4.1, 0, 0, 0, 0, 0, 1);
    case 4: PlayAnim(playerid, "KISSING", "Grlfrd_Kiss_01", 4.1, 0, 0, 0, 0, 0, 1);
    case 5: PlayAnim(playerid, "KISSING", "Grlfrd_Kiss_02", 4.1, 0, 0, 0, 0, 0, 1);
    case 6: PlayAnim(playerid, "KISSING", "Grlfrd_Kiss_03", 4.1, 0, 0, 0, 0, 0, 1);
    default: KullanimMesajGonder(playerid, "/kiss [1-6]");
    }
    return 1;
}

CMD:idles(playerid, params[])
{
    if (!AnimationCheck(playerid)) return HataMesajGonder(playerid, "Þu anda animasyon gerçekleþtirilemiyor.");
    if (IsPlayerInAnyVehicle(playerid)) return 1;
    switch (strval(params))
    {
    case 1: PlayAnimEx(playerid, "PLAYIDLES", "shift", 4.1, 1, 1, 1, 1, 1, 1);
    case 2: PlayAnimEx(playerid, "PLAYIDLES", "shldr", 4.1, 1, 1, 1, 1, 1, 1);
    case 3: PlayAnimEx(playerid, "PLAYIDLES", "stretch", 4.1, 1, 1, 1, 1, 1, 1);
    case 4: PlayAnimEx(playerid, "PLAYIDLES", "strleg", 4.1, 1, 1, 1, 1, 1, 1);
    case 5: PlayAnimEx(playerid, "PLAYIDLES", "time", 4.1, 1, 1, 1, 1, 1, 1);
    case 6: PlayAnimEx(playerid, "COP_AMBIENT", "Copbrowse_loop", 4.1, 1, 0, 0, 0, 0, 1);
    case 7: PlayAnimEx(playerid, "COP_AMBIENT", "Coplook_loop", 4.1, 1, 0, 0, 0, 0, 1);
    case 8: PlayAnimEx(playerid, "COP_AMBIENT", "Coplook_shake", 4.1, 1, 0, 0, 0, 0, 1);
    case 9: PlayAnimEx(playerid, "COP_AMBIENT", "Coplook_think", 4.1, 1, 0, 0, 0, 0, 1);
    case 10: PlayAnimEx(playerid, "COP_AMBIENT", "Coplook_watch", 4.1, 1, 0, 0, 0, 0, 1);
    case 11: PlayAnimEx(playerid, "PED", "roadcross", 4.1, 1, 0, 0, 0, 0, 1);
    case 12: PlayAnimEx(playerid, "PED", "roadcross_female", 4.1, 1, 0, 0, 0, 0, 1);
    case 13: PlayAnimEx(playerid, "PED", "roadcross_gang", 4.1, 1, 0, 0, 0, 0, 1);
    case 14: PlayAnimEx(playerid, "PED", "roadcross_old", 4.1, 1, 0, 0, 0, 0, 1);
    case 15: PlayAnimEx(playerid, "PED", "woman_idlestance", 4.1, 1, 0, 0, 0, 0, 1);
    default: KullanimMesajGonder(playerid, "/idles [1-15]");
    }
    return 1;
}

CMD:sunbathe(playerid, params[])
{
    if (!AnimationCheck(playerid)) return HataMesajGonder(playerid, "Þu anda animasyon gerçekleþtirilemiyor.");
    if (IsPlayerInAnyVehicle(playerid)) return 1;
    switch (strval(params))
    {
    case 1: PlayAnimEx(playerid, "SUNBATHE", "batherdown", 4.1, 0, 1, 1, 1, 1, 1);
    case 2: PlayAnimEx(playerid, "SUNBATHE", "batherup", 4.1, 0, 1, 1, 1, 1, 1);
    case 3: PlayAnimEx(playerid, "SUNBATHE", "Lay_Bac_in", 4.1, 0, 1, 1, 1, 1, 1);
    case 4: PlayAnimEx(playerid, "SUNBATHE", "Lay_Bac_out", 4.1, 0, 1, 1, 1, 1, 1);
    case 5: PlayAnimEx(playerid, "SUNBATHE", "ParkSit_M_IdleA", 4.1, 0, 1, 1, 1, 1, 1);
    case 6: PlayAnimEx(playerid, "SUNBATHE", "ParkSit_M_IdleB", 4.1, 0, 1, 1, 1, 1, 1);
    case 7: PlayAnimEx(playerid, "SUNBATHE", "ParkSit_M_IdleC", 4.1, 0, 1, 1, 1, 1, 1);
    case 8: PlayAnimEx(playerid, "SUNBATHE", "ParkSit_M_in", 4.1, 0, 1, 1, 1, 1, 1);
    case 9: PlayAnimEx(playerid, "SUNBATHE", "ParkSit_M_out", 4.1, 0, 1, 1, 1, 1, 1);
    case 10: PlayAnimEx(playerid, "SUNBATHE", "ParkSit_W_idleA", 4.1, 0, 1, 1, 1, 1, 1);
    case 11: PlayAnimEx(playerid, "SUNBATHE", "ParkSit_W_idleB", 4.1, 0, 1, 1, 1, 1, 1);
    case 12: PlayAnimEx(playerid, "SUNBATHE", "ParkSit_W_idleC", 4.1, 0, 1, 1, 1, 1, 1);
    case 13: PlayAnimEx(playerid, "SUNBATHE", "ParkSit_W_in", 4.1, 0, 1, 1, 1, 1, 1);
    case 14: PlayAnimEx(playerid, "SUNBATHE", "ParkSit_W_out", 4.1, 0, 1, 1, 1, 1, 1);
    case 15: PlayAnimEx(playerid, "SUNBATHE", "SBATHE_F_LieB2Sit", 4.1, 0, 1, 1, 1, 1, 1);
    case 16: PlayAnimEx(playerid, "SUNBATHE", "SBATHE_F_Out", 4.1, 0, 1, 1, 1, 1, 1);
    case 17: PlayAnimEx(playerid, "SUNBATHE", "SitnWait_in_W", 4.1, 0, 1, 1, 1, 1, 1);
    case 18: PlayAnimEx(playerid, "SUNBATHE", "SitnWait_out_W", 4.1, 0, 1, 1, 1, 1, 1);
    default: KullanimMesajGonder(playerid, "/sunbathe [1-18]");
    }
    return 1;
}

CMD:lowrider(playerid, params[])
{
    if (!AnimationCheck(playerid) && GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return HataMesajGonder(playerid, "Þu anda animasyon gerçekleþtirilemiyor.");
    if (!IsPlayerInAnyVehicle(playerid)) return 1;
    if (IsCLowrider(GetPlayerVehicleID(playerid)))
    {
        switch (strval(params))
        {
	        case 1: PlayAnim(playerid, "LOWRIDER", "lrgirl_bdbnce", 4.1, 0, 1, 1, 1, 1, 1);
	        case 2: PlayAnim(playerid, "LOWRIDER", "lrgirl_hair", 4.1, 0, 1, 1, 1, 1, 1);
	        case 3: PlayAnim(playerid, "LOWRIDER", "lrgirl_hurry", 4.1, 0, 1, 1, 1, 1, 1);
	        case 4: PlayAnim(playerid, "LOWRIDER", "lrgirl_idleloop", 4.1, 0, 1, 1, 1, 1, 1);
	        case 5: PlayAnim(playerid, "LOWRIDER", "lrgirl_idle_to_l0", 4.1, 0, 1, 1, 1, 1, 1);
	        case 6: PlayAnim(playerid, "LOWRIDER", "lrgirl_l0_bnce", 4.1, 0, 1, 1, 1, 1, 1);
	        case 7: PlayAnim(playerid, "LOWRIDER", "lrgirl_l0_loop", 4.1, 0, 1, 1, 1, 1, 1);
	        case 8: PlayAnim(playerid, "LOWRIDER", "lrgirl_l0_to_l1", 4.1, 0, 1, 1, 1, 1, 1);
	        case 9: PlayAnim(playerid, "LOWRIDER", "lrgirl_l12_to_l0", 4.1, 0, 1, 1, 1, 1, 1);
	        case 10: PlayAnim(playerid, "LOWRIDER", "lrgirl_l1_bnce", 4.1, 0, 1, 1, 1, 1, 1);
	        case 11: PlayAnim(playerid, "LOWRIDER", "lrgirl_l1_loop", 4.1, 0, 1, 1, 1, 1, 1);
	        case 12: PlayAnim(playerid, "LOWRIDER", "lrgirl_l1_to_l2", 4.1, 0, 1, 1, 1, 1, 1);
	        case 13: PlayAnim(playerid, "LOWRIDER", "lrgirl_l2_bnce", 4.1, 0, 1, 1, 1, 1, 1);
	        case 14: PlayAnim(playerid, "LOWRIDER", "lrgirl_l2_loop", 4.1, 0, 1, 1, 1, 1, 1);
	        case 15: PlayAnim(playerid, "LOWRIDER", "lrgirl_l2_to_l3", 4.1, 0, 1, 1, 1, 1, 1);
	        case 16: PlayAnim(playerid, "LOWRIDER", "lrgirl_l345_to_l1", 4.1, 0, 1, 1, 1, 1, 1);
	        case 17: PlayAnim(playerid, "LOWRIDER", "lrgirl_l3_bnce", 4.1, 0, 1, 1, 1, 1, 1);
	        case 18: PlayAnim(playerid, "LOWRIDER", "lrgirl_l3_loop", 4.1, 0, 1, 1, 1, 1, 1);
	        case 19: PlayAnim(playerid, "LOWRIDER", "lrgirl_l3_to_l4", 4.1, 0, 1, 1, 1, 1, 1);
	        case 20: PlayAnim(playerid, "LOWRIDER", "lrgirl_l4_bnce", 4.1, 0, 1, 1, 1, 1, 1);
	        case 21: PlayAnim(playerid, "LOWRIDER", "lrgirl_l4_loop", 4.1, 0, 1, 1, 1, 1, 1);
	        case 22: PlayAnim(playerid, "LOWRIDER", "lrgirl_l4_to_l5", 4.1, 0, 1, 1, 1, 1, 1);
	        case 23: PlayAnim(playerid, "LOWRIDER", "lrgirl_l5_bnce", 4.1, 0, 1, 1, 1, 1, 1);
	        case 24: PlayAnim(playerid, "LOWRIDER", "lrgirl_l5_loop", 4.1, 0, 1, 1, 1, 1, 1);
	        case 25: PlayAnim(playerid, "LOWRIDER", "prtial_gngtlkB", 4.1, 0, 1, 1, 1, 1, 1);
	        case 26: PlayAnim(playerid, "LOWRIDER", "prtial_gngtlkC", 4.1, 0, 1, 1, 1, 1, 1);
	        case 27: PlayAnim(playerid, "LOWRIDER", "prtial_gngtlkD", 4.1, 0, 1, 1, 1, 1, 1);
	        case 28: PlayAnim(playerid, "LOWRIDER", "prtial_gngtlkE", 4.1, 0, 1, 1, 1, 1, 1);
	        case 29: PlayAnim(playerid, "LOWRIDER", "prtial_gngtlkF", 4.1, 0, 1, 1, 1, 1, 1);
	        case 30: PlayAnim(playerid, "LOWRIDER", "prtial_gngtlkG", 4.1, 0, 1, 1, 1, 1, 1);
	        case 31: PlayAnim(playerid, "LOWRIDER", "prtial_gngtlkH", 4.1, 0, 1, 1, 1, 1, 1);
	        default: KullanimMesajGonder(playerid, "/lowrider [1-31]");
        }
    }
    else
    {
        HataMesajGonder(playerid, "Bu animasyonu kullanabilmek için lowrider aracýnda olmanýz gerekmektedir.");
    }
    return 1;
}

CMD:carchat(playerid, params[])
{
    if (!AnimationCheck(playerid) && GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return HataMesajGonder(playerid, "Þu anda animasyon gerçekleþtirilemiyor.");
    if (!IsPlayerInAnyVehicle(playerid)) return 1;
    switch (strval(params))
    {
	    case 1: PlayAnim(playerid, "CAR_CHAT", "carfone_in", 4.1, 0, 1, 1, 1, 1, 1);
	    case 2: PlayAnim(playerid, "CAR_CHAT", "carfone_loopA", 4.1, 0, 1, 1, 1, 1, 1);
	    case 3: PlayAnim(playerid, "CAR_CHAT", "carfone_loopA_to_B", 4.1, 0, 1, 1, 1, 1, 1);
	    case 4: PlayAnim(playerid, "CAR_CHAT", "carfone_loopB", 4.1, 0, 1, 1, 1, 1, 1);
	    case 5: PlayAnim(playerid, "CAR_CHAT", "carfone_loopB_to_A", 4.1, 0, 1, 1, 1, 1, 1);
	    case 6: PlayAnim(playerid, "CAR_CHAT", "carfone_out", 4.1, 0, 1, 1, 1, 1, 1);
	    case 7: PlayAnim(playerid, "CAR_CHAT", "CAR_Sc1_BL", 4.1, 0, 1, 1, 1, 1, 1);
	    case 8: PlayAnim(playerid, "CAR_CHAT", "CAR_Sc1_BR", 4.1, 0, 1, 1, 1, 1, 1);
	    case 9: PlayAnim(playerid, "CAR_CHAT", "CAR_Sc1_FL", 4.1, 0, 1, 1, 1, 1, 1);
	    case 10: PlayAnim(playerid, "CAR_CHAT", "CAR_Sc1_FR", 4.1, 0, 1, 1, 1, 1, 1);
	    case 11: PlayAnim(playerid, "CAR_CHAT", "CAR_Sc2_FL", 4.1, 0, 1, 1, 1, 1, 1);
	    case 12: PlayAnim(playerid, "CAR_CHAT", "CAR_Sc3_BR", 4.1, 0, 1, 1, 1, 1, 1);
	    case 13: PlayAnim(playerid, "CAR_CHAT", "CAR_Sc3_FL", 4.1, 0, 1, 1, 1, 1, 1);
	    case 14: PlayAnim(playerid, "CAR_CHAT", "CAR_Sc3_FR", 4.1, 0, 1, 1, 1, 1, 1);
	    case 15: PlayAnim(playerid, "CAR_CHAT", "CAR_Sc4_BL", 4.1, 0, 1, 1, 1, 1, 1);
	    case 16: PlayAnim(playerid, "CAR_CHAT", "CAR_Sc4_BR", 4.1, 0, 1, 1, 1, 1, 1);
	    case 17: PlayAnim(playerid, "CAR_CHAT", "CAR_Sc4_FL", 4.1, 0, 1, 1, 1, 1, 1);
	    case 18: PlayAnim(playerid, "CAR_CHAT", "CAR_Sc4_FR", 4.1, 0, 1, 1, 1, 1, 1);
	    case 19: PlayAnim(playerid, "CAR", "Sit_relaxed", 4.1, 0, 1, 1, 1, 1, 1);
	    default: KullanimMesajGonder(playerid, "/carchat [1-19]");
    }
    return 1;
}

CMD:meslekler(playerid)
{
	Dialog_Show(playerid, MesleklerMenu, DIALOG_STYLE_TABLIST_HEADERS, "{FFD800}Meslekler:{ffffff} Menü", "Meslek\tMeslek Noktasý\nHurdacýlýk {2ECC71}(1 Level){FF0000}(YENÝ!){FFFFFF}\t%s\nÇimento Taþýmacýsý {2ECC71}(1 Level){FFFFFF}\t%s\nBalýkçýlýk {2ECC71}(1 Level){FFFFFF}\t%s\nKasapçýlýk {2ECC71}(5 Level){FF0000}(YENÝ!){FFFFFF}\t%s\n", "Seç", "Kapat",
		GetLocation(CopcuX, CopcuY, CopcuZ),
		GetLocation(CimentoX, CimentoY, CimentoZ),
		GetLocation(BalikciX, BalikciY, BalikciZ),
		GetLocation(KasapX, KasapY, KasapZ));
	return 1;
}
CMD:modifiyegarajlari(playerid)
{
    if (!OyundaDegil(playerid)) return 1;
    Dialog_Show(playerid, ModifiyeGarajlari, DIALOG_STYLE_LIST, "Modifiye Garajlarý", "{FFFFFF}LS Temple Transfender\n{FFFFFF}LS Willowfield Lowrider Transfender\n{FFFFFF}SF Wheel Arch Angels", "Seç", "Kapat");
	return 1;
}
CMD:yardim(playerid)
{
	new str[550];
	strcat(str, "{808080} • {FFFFFF}Genel Komutlar\n");
	strcat(str, "{808080} • {FFFFFF}Chat & Roleplay Komutlarý\n");
	strcat(str, " \n");
	strcat(str, "{808080} • {FFFFFF}Telefon\n");
	strcat(str, "{808080} • {FFFFFF}Araç\n");
	strcat(str, "{808080} • {FFFFFF}Uyuþturucu\n");
	strcat(str, "{808080} • {FFFFFF}Birlik\n");
	strcat(str, "{808080} • {FFFFFF}Meslekler\n");
	strcat(str, " \n");
	strcat(str, "{808080} • {FFFFFF}Yapýmcýlar\n");
	Dialog_Show(playerid, Yardim, DIALOG_STYLE_LIST, "{FFFFFF}Yardým: Kategoriler", str, "Seç", "{FF6347}Kapat");
	return 1;
}
CMD:soyun(playerid)
{
	if (!OyundaDegil(playerid)) return 1;
	if (PlayerData[playerid][pKelepce] > 0 || PlayerData[playerid][pHapisSure] > 0 || PlayerData[playerid][pSoklandi] > 0 || PlayerData[playerid][pYereYatirildi] > 0 || PlayerData[playerid][pBaygin] == 1 || PetKontrol[playerid] != -1 || pbOda[playerid] != -1)
 	return HataMesajGonder(playerid, "Þu an bu komutu kullanamazsýnýz.");
 	if (PlayerData[playerid][pSoyun] == true)
 	{
 	    PlayerData[playerid][pSoyun] = false;
 	    SetPlayerSkin(playerid, PlayerData[playerid][pSkin]);
 	    SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "* %s kiyafetlerini giyinir.", ReturnName(playerid, 0));
 	}
 	else
 	{
 	    if (PlayerData[playerid][pCinsiyet] == 1) Dialog_Show(playerid, Soyun, DIALOG_STYLE_PREVMODEL, "Skinler", "18\n45\n97\n154\n20283\n20284\n20285", "Sec", "Kapat");
 	    else Dialog_Show(playerid, Soyun, DIALOG_STYLE_PREVMODEL, "Skinler", "20286\n20287\n20288\n20289\n20290\n20291\n20292", "Sec", "Kapat");

 	}
	return 1;
}
CMD:aractanat(playerid, params[])
{
	new id;
    if (!OyundaDegil(playerid)) return 1;
    if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return HataMesajGonder(playerid, "Sürücü olmalýsýnýz!");
    if (PlayerData[playerid][pKelepce] > 0 || PlayerData[playerid][pHapisSure] > 0 || PlayerData[playerid][pSoklandi] > 0 || PlayerData[playerid][pYereYatirildi] > 0 || PlayerData[playerid][pBaygin] == 1 || PetKontrol[playerid] != -1 || pbOda[playerid] != -1)
 	return HataMesajGonder(playerid, "Þu an bu komutu kullanamazsýnýz.");
 	if (sscanf(params, "u", id)) return KullanimMesajGonder(playerid, "/aractanat [ID/Isim]");
 	if (!OyundaDegil(id)) return HataMesajGonder(playerid, "Geçersiz ID girdiniz.");
	if (GetPlayerVehicleID(id) != GetPlayerVehicleID(playerid)) return HataMesajGonder(playerid, "Bu kiþi aracýnýzda deðil.");
	if (id == playerid) return HataMesajGonder(playerid, "Kendinizi araçtan atamazsýnýz.");
	RemovePlayerFromVehicle(id);
	if (PlayerData[id][pKelepce] == 1) TogglePlayerControllable(id, true);
	SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "* %s %s adlý kiþiyi araçtan atar.", ReturnName(playerid, 0), ReturnName(id, 0));
	return 1;
}
CMD:yduty(playerid)
{
    if (!OyundaDegil(playerid)) return 1;
    if (PlayerData[playerid][pYoutuber] != 1) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
    if (PlayerData[playerid][pYoutuberTag] == false)
    {
        PlayerData[playerid][pYoutuberTag] = true;
        MesajGonder(playerid, "Youtuber & Streamer tagý açýldý.");
    }
    else
    {
        PlayerData[playerid][pYoutuberTag] = false;
        MesajGonder(playerid, "Youtuber & Streamer tagý kapatýldý.");
    }
	return 1;
}
CMD:beanbag(playerid)
{
    if (!OyundaDegil(playerid)) return 1;
    if (GetFactionType(playerid) != BIRLIK_LSPD) return HataMesajGonder(playerid, "Devlet memuru deðilsin.");
    if (!IsPlayerInAnyVehicle(playerid)) return HataMesajGonder(playerid, "Polis aracýnda deðilsin!");
    new vehicleid = GetPlayerVehicleID(playerid);
    new id = Car_GetID(vehicleid);
    if (id == -1 || AracInfo[id][aracFactionType] != BIRLIK_LSPD) return HataMesajGonder(playerid, "Polis aracýnda deðilsin!");
    if (!PlayerData[playerid][pBeanbag])
    {
        if (Beanbag[vehicleid] != 1) return HataMesajGonder(playerid, "Bu araçta Beanbag yok.");
        PlayerData[playerid][pBeanbag] = 1;
        SaveWeapons(playerid);
        Beanbag[vehicleid] = 0;
        GivePlayerWeapon(playerid, 25, 100);
        SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s aracýn orta panelinden beanbag tüfeðini eline alýr.", ReturnName(playerid, 0));
    }
    else
    {
        if (Beanbag[vehicleid] != 0) return HataMesajGonder(playerid, "Bu araçta zaten Beanbag var.");
        ResetPlayerWeapons(playerid);
        PlayerData[playerid][pBeanbag] = 0;
        SetWeapons(playerid);
        Beanbag[vehicleid] = 1;
        SetPlayerArmedWeapon(playerid, 0);
       	SendNearbyMessage(playerid, 30.0, COLOR_CYAN, "** %s beanbag tüfeðini aracýn orta paneline yerleþtirir.", ReturnName(playerid, 0));
    }
	return 1;
}

CMD:ck(playerid, response, listitem, inputtext[])
{
    if (!OyundaDegil(playerid)) return 1;
    if (PlayerData[playerid][pHapisSure] > 0 && PlayerData[playerid][pCK] == 1) return HataMesajGonder(playerid, "Karakteriniz zaten CK edilmiþ.");
	Dialog_Show(playerid, ckonay, DIALOG_STYLE_INPUT, "Character Kill", "{FFFFFF}Karakteriniz sýnýrsýz hapise girecektir tek çýkýþ yolu (OOC) Marketten isim deðiþtirme hakký almaktýr. (Onaylýyorsanýz Aþaðýdaki kodu kuyucuða yazýn: {BF00FF}%s{FFFFFF})  ", "Onayla", "Kapat");

	return 1;
}

CMD:ckunjail(playerid, params[])
{
	new id;
	if (PlayerData[playerid][pAdmin] < 4) return HataMesajGonder(playerid, "Yeterli yetkiniz yok!");
	if (sscanf(params, "u", id)) return KullanimMesajGonder(playerid, "/ckunjail [ID/Isim]");
	if (!OyundaDegil(id)) return HataMesajGonder(playerid, "Oyuncu oyunda deðil.");
	if (PlayerData[id][pCK] == 0) return HataMesajGonder(playerid, "Bu karakter CK edilmemiþ.");
	format(PlayerData[id][pHapisSebep], 50, "");
	PlayerData[id][pCK] = 0;
	PlayerData[id][pHapisSure] = 1;

    MesajGonder(playerid, "%s adlý oyuncuyu hapisten çýkarttýnýz.", ReturnName(id, 0));
    BilgiMesajGonder(id, "%s adlý yetkili sizi hapisten çýkarttý.", PlayerData[playerid][pAdminName]);

    Log_Write("logs/jail_log.txt", "[%s] %s adli yetkili %s adli oyuncuyu hapisten cikartti. (CK unjail)", ReturnDate(), PlayerData[playerid][pAdminName], ReturnName(id, 0));
	return 1;
}

CMD:kupon(playerid)
{
    if (!OyundaDegil(playerid)) return 1;
    Dialog_Show(playerid, Kupon, DIALOG_STYLE_INPUT, "Kupon Kodu", "{FFFFFF}Lütfen kupon kodunu aþaðýya yazýn:", "Devam", "Kapat");
	return 1;
}

CMD:envanter(playerid)
{
    if (!OyundaDegil(playerid)) return 1;
    if (PlayerData[playerid][pBaygin] > 0 || PlayerData[playerid][pKelepce] > 0 || PlayerData[playerid][pHapisSure] > 0 || pbOda[playerid] != -1 || PlayerData[playerid][pSoklandi] > 0 || PetKontrol[playerid] != -1 || GetPVarInt(playerid, "IpBaglandi") == 1) return HataMesajGonder(playerid, "Envanterinizi þu an açamazsýnýz.");
    Envanter_Goster(playerid);
	return 1;
}
/*
CMD:hediyeal(playerid)
{
    if (!OyundaDegil(playerid)) return 1;
	if(!IsPlayerInRangeOfPoint(playerid, 10.0, 404.7805,-1532.1631,32.3734))
		return HataMesajGonder(playerid, "Bu bölgede hediye alamazsýnýz.");
	if (PlayerData[playerid][pHediye] != 1) return HataMesajGonder(playerid, "Hediye almak için %d maaþ daha almalýsýnýz.", 5-PlayerData[playerid][pHediyeSaat]);
    PlayerData[playerid][pHediye] = 0;
    PlayerData[playerid][pHediyeSaat] = 0;
    new rastpara = RandomEx(500, 5000);
    ParaVer(playerid, rastpara);
    MesajGonder(playerid, "Hediye alma hakkýnýzý kullandýnýz ve {2ECC71}%s {FFFFFF}kazandýnýz.", FormatNumber(rastpara));
	return 1;
}*/
CMD:yarisolustur(playerid, params[])
{
    if(PlayerData[playerid][pYarisHazirliyormu] != -1) return HataMesajGonder(playerid, "Zaten bir yarýþ hazýrlýyorsun.");

    if (GetFactionType(playerid) != BIRLIK_CETE)
	    return HataMesajGonder(playerid, "Yarýþ tipi onaylý bir birliðin üyesi deðilsin.");

    Dialog_Show(playerid, YarisOlustur, DIALOG_STYLE_INPUT, "Yarýþ Oluþtur", "{FFFFFF}Oluþturmak istediðin yarýþýn adýný giriniz:", "Tamam", "{FF6347}Iptal");
	return 1;
}

CMD:yarisayril(playerid, params[])
{
    if(PlayerData[playerid][pYaris] == -1) return HataMesajGonder(playerid, "Herhangi bir yarýþta deðilsin.");
    if(PlayerData[playerid][pYarisHazirliyormu] != -1) return HataMesajGonder(playerid, "Yarýþ editörü iken yarýþtan ayrýlamazsýn.");

	PlayerData[playerid][pYaris] = -1;
	MesajGonder(playerid, "Yarýþtan ayrýldýnýz.");
	return 1;
}

CMD:yariscilar(playerid, params[])
{
    if(PlayerData[playerid][pYaris] == -1) return HataMesajGonder(playerid, "Herhangi bir yarýþta deðilsin.");

	new string[1024], sayi, durum[256];
    foreach(new i : Player)
	{
	    if(PlayerData[i][pYaris] == PlayerData[playerid][pYaris])
		{
		    format(durum, sizeof(durum), "• %s (%d)", ReturnName(i, 0), i);
			strcat(string, durum);
			sayi++;
		}
	}
	if(sayi == 0) return HataMesajGonder(playerid, "Hiç katýlýmcý yok.");
	Dialog_Show(playerid, birimler, DIALOG_STYLE_LIST, "Yarýþçýlar", string, "Tamam", "");
	return 1;
}

CMD:yaris(playerid, params[])
{
    if(PlayerData[playerid][pYarisHazirliyormu] == -1) return HataMesajGonder(playerid, "Þu anda bir yarýþ hazýrlamýyorsun.");

    if (GetFactionType(playerid) != BIRLIK_CETE)
	    return HataMesajGonder(playerid, "Yarýþ/Çete tipi bir birliðin üyesi deðilsin.");

  	new string[1024];
	strcat(string, "Ýþlem Adý\tDurum\n");
	strcat(string, "{228B22}Yeni Checkpoint Ekle\n");
	strcat(string, "{F0CC00}Son Checkpointi Sil\n");
	strcat(string, "{F0CC00}Yarýþý Baþlat\n");
	strcat(string, "{F0CC00}Yarýþý Durdur\n");
	strcat(string, "{F0CC00}Yarýþý Kaydet\n");
	strcat(string, "{F0CC00}Hazýr Yarýþ Yükle\n");
	strcat(string, "{F0CC00}Yarýþa Davet Et\n");
	strcat(string, "{8B0000}Yarýþý Sonlandýr & Ýptal Et\n");
	/*
	if(YayinVeri[YayinDurum]) format(pmdurumu, 24, "{228B22}Açýk");
 	else format(pmdurumu, 24, "{8B0000}Kapalý");
	format(toplamoyuncu, sizeof(toplamoyuncu), "Yayýný Baþlat/Durdur\t%s\n", pmdurumu);
	strcat(string, toplamoyuncu);
	strcat(string, "Kameranýn Yerini Deðiþtir\n");
	strcat(string, "Kameranýn Baktýðý Yeri Deðiþtir\n");
	strcat(string, "Altyazý Deðiþtir\n");
	strcat(string, "Ekstra Metini Deðiþtir\n");
	strcat(string, "Yayýn Adýný Deðiþtir\n");
 	if(strlen(YayinVeri[YayinURL]) > 0) format(pmdurumu, 24, "{228B22}Açýk");
 	else format(pmdurumu, 24, "{8B0000}Kapalý");
	format(toplamoyuncu, sizeof(toplamoyuncu), "Müzik Deðiþtir\t%s\n", pmdurumu);
	strcat(string, toplamoyuncu);*/
	Dialog_Show(playerid, YarisDuzenle, DIALOG_STYLE_TABLIST_HEADERS, "{33CC33}Yarýþ Menü", string, "Tamam", "{FF6347}Kapat");
	return 1;
}
CMD:gir(playerid)
{
	new id = Entrance_Nearest(playerid);

	if (id != -1)
    {
    	if (PlayerData[playerid][pBaygin] == 1) return HataMesajGonder(playerid, "Yaralý olduðunuz için binaya giremezsiniz!");
        if (EntranceData[id][entranceLocked]) return HataMesajGonder(playerid, "Bu bina kilitli.");
		if (strfind(EntranceData[id][entranceName], "VIP", true) != -1 && PlayerData[playerid][pVip] < 1) return HataMesajGonder(playerid, "Buraya girmek için vip olmalýsýnýz. (/oocmarket)");
		if (!strlen(EntranceData[id][entrancePass]))
		{
	   		SetPlayerPos(playerid, EntranceData[id][entranceInt][0], EntranceData[id][entranceInt][1], EntranceData[id][entranceInt][2]);
			SetPlayerFacingAngle(playerid, EntranceData[id][entranceInt][3]);

			if (EntranceData[id][entranceInteriorVw] != -1)
				SetPlayerVirtualWorld(playerid, EntranceData[id][entranceInteriorVw]);
	        else
				SetPlayerVirtualWorld(playerid, id+100);

			if(EntranceData[id][entranceBaglanti] != -1)
			{
				SetPlayerVirtualWorld(playerid, EntranceData[id][entranceBaglanti]+23);
    			SetPlayerInterior(playerid, 0);
				PlayerData[playerid][pGarage] = EntranceData[id][entranceBaglanti];
			}else{
				SetPlayerInterior(playerid, EntranceData[id][entranceInterior]);
			}
				SetCameraBehindPlayer(playerid);
				ObjelerYukleniyor(playerid);
			}else{
			    SetPVarInt(playerid, "binaid", id);
			    ShowPlayerDialog(playerid, 22, DIALOG_STYLE_INPUT, "Bina Þifre", "Bu bina için þifre belirlenmiþ, lütfen þifreyi girin:", "Devam", "Kapat");
		}
		return 1;
	}
	id = House_Nearest(playerid);
	if (id != -1)
    {
    	if (PlayerData[playerid][pBaygin] == 1) return HataMesajGonder(playerid, "Yaralý olduðunuz için eve giremezsiniz.");
   		if (HouseInfo[id][evKilit] == 1) return HataMesajGonder(playerid, "Bu ev kilitlenmiþ.");
   		if (HouseInfo[id][evSahip] > 0) SendClientMessageEx(playerid, -1, "{FFFFFF}Bu evin sahibi {AFAFAF}%s.", SQLName(HouseInfo[id][evSahip], 0));

		SendClientMessageEx(playerid, -1, "{FFC100}[EV] {FFFFFF}Satýn Alýnan Fiyat: {AFAFAF}%s {FFFFFF}Toplam Vergi Miktarý: {AFAFAF}%s/%s {FFFFFF}Saatlik Vergi Miktarý: {AFAFAF}%s", FormatNumber(HouseInfo[id][evKendiFiyati]), FormatNumber(HouseInfo[id][evVergi]), FormatNumber(Ev_MaksVergi(id)), FormatNumber(GetHouseVergi(id)), FormatNumber(GetHouseVergi(id)));
		SetPlayerInterior(playerid, HouseInteriors[ HouseInfo[id][evInterior] ][intID]);
		SetPlayerPos(playerid, HouseInteriors[HouseInfo[id][evInterior] ][intX], HouseInteriors[ HouseInfo[id][evInterior] ][intY], HouseInteriors[ HouseInfo[id][evInterior] ][intZ]);
        SetPlayerVirtualWorld(playerid,HouseInfo[id][evID]+1);

		ObjelerYukleniyor(playerid);
        SetCameraBehindPlayer(playerid);
        PlayerData[playerid][pHouse] = HouseInfo[id][evID];

        return 1;
    }

    id = Business_Nearest(playerid);
    if (id != -1)
    {
    	if (PlayerData[playerid][pBaygin] == 1) return HataMesajGonder(playerid, "Yaralý olduðunuz için iþyerine giremezsiniz.");
        if (Isyeri[id][isyeriKilit]) return HataMesajGonder(playerid, "Bu iþyeri kilitli.");
        if (Isyeri[id][isyeriGirisUcret] > 0 && Isyeri[id][isyeriSahip] != PlayerData[playerid][pID])
        {
        	if (PlayerData[playerid][pCash] < Isyeri[id][isyeriGirisUcret]) return HataMesajGonder(playerid, "Giriþ Ücretini ödemek için yeterli paranýz bulunmuyor.");

			Isyeri[id][isyeriKasa] += Isyeri[id][isyeriGirisUcret];
            ParaVer(playerid,-Isyeri[id][isyeriGirisUcret]);
		}

		if (Isyeri[id][isyeriTip] == 6 && strlen(Isyeri[id][isyeriMuzik]) > 0)
			PlayAudioStreamForPlayer(playerid, Isyeri[id][isyeriMuzik]);

		SetPlayerPos(playerid,Isyeri[id][isyeriInt][0],Isyeri[id][isyeriInt][1],Isyeri[id][isyeriInt][2]);
		SetPlayerFacingAngle(playerid,Isyeri[id][isyeriInt][3]);
		SetPlayerInterior(playerid,Isyeri[id][isyeriInterior]);
		SetPlayerVirtualWorld(playerid,Isyeri[id][isyeriID]+1);

		SetCameraBehindPlayer(playerid);
		PlayerData[playerid][pIsyeri] = Isyeri[id][isyeriID];
		ObjelerYukleniyor(playerid);

		if (Isyeri[id][isyeriTip] != 7)
            SendClientMessage(playerid, 0xFFC10000, "[Ýþyeri]: {C8C8C8}Ýþyerine hoþgeldiniz."),
			SendClientMessage(playerid, 0xFFC10000, "[Ýþyeri]: {C8C8C8}Bu iþyerinde {808080}/satinal {C8C8C8}komutunu kullanabilirsiniz.");
	     	else
			SendClientMessage(playerid, 0xFFC10000, "[Ýþyeri]: {C8C8C8}Kumar oynamak için {808080}/kumar {C8C8C8}komutunu kullanabilirsiniz.");
		if (strlen(Isyeri[id][isyeriMesaj]) && strcmp(Isyeri[id][isyeriMesaj], "Yok", true))
	  		SendClientMessage(playerid, 0x1394BFFF, Isyeri[id][isyeriMesaj]);
		return 1;
	}

	id = Garage_Nearest(playerid);
	if (id != -1)
	{
		if (PlayerData[playerid][pBaygin] == 1)
			return HataMesajGonder(playerid, "Yaralý olduðunuz için garaja giremezsiniz.");

		if (GarageData[id][gKilit] == 1)
			return HataMesajGonder(playerid, "Garaj kilitli.");

		if (GarageData[id][gBirlik] != -1 && PlayerData[playerid][pFaction] != GarageData[id][gBirlik])
			return HataMesajGonder(playerid, "Bu garaj birliðe özeldir.");

		if (!strcmp(GarageData[id][gSifre], "Yok", true))
        {
  	    	if (!IsPlayerInAnyVehicle(playerid))
            {
            	SetPlayerPos(playerid,GarageInteriors[GarageData[id][gInterior]][intX],GarageInteriors[GarageData[id][gInterior]][intY],GarageInteriors[GarageData[id][gInterior]][intZ]);
            	SetPlayerInterior(playerid,GarageInteriors[GarageData[id][gInterior]][intID]);
            	SetPlayerVirtualWorld(playerid, id+23);
				ObjelerYukleniyor(playerid);
   				SetPlayerFacingAngle(playerid,GarageInteriors[GarageData[id][gInterior]][intA]);
                SetCameraBehindPlayer(playerid);
                PlayerData[playerid][pGarage] = id;
            }

			if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
            {
            	new vehicleid = GetPlayerVehicleID(playerid);

				SetVehiclePos(vehicleid, GarageInteriors[GarageData[id][gInterior]][intX],GarageInteriors[GarageData[id][gInterior]][intY],GarageInteriors[GarageData[id][gInterior]][intZ]+1);
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
        }else{
       		SetPVarInt(playerid, "Garaj", id);
            Dialog_Show(playerid, GarajGiris, DIALOG_STYLE_INPUT, "Garaj Þifre", "Bu garaj þifreli, lütfen þifreyi giriniz:", "Tamam", "Kapat");
        }

        return 1;
	}
	return 1;
}

CMD:cik(playerid)
{
	new id = Entrance_Inside(playerid);

	if (id != -1)
	{
		if (PlayerData[playerid][pBaygin] == 1) return HataMesajGonder(playerid, "Yaralý olduðunuz için binadan çýkamazsýnýz.");
		if (EntranceData[id][entranceLocked]) return HataMesajGonder(playerid, "Bu bina kilitli.");
		if(EntranceData[id][eVip] > 0 && PlayerData[playerid][pAdmin] < EntranceData[id][eVip]) return HataMesaji(playerid, "Bu kapý viplere özeldir.");

		SetPlayerPos(playerid, EntranceData[id][entrancePos][0], EntranceData[id][entrancePos][1], EntranceData[id][entrancePos][2]);
		SetPlayerFacingAngle(playerid, EntranceData[id][entrancePos][3]);
		PlayerData[playerid][pGarage] = -1;
        SetPlayerInterior(playerid, EntranceData[id][entranceExterior]);
        SetPlayerVirtualWorld(playerid, EntranceData[id][entranceExteriorVW]);
		ObjelerYukleniyor(playerid);
        SetCameraBehindPlayer(playerid);
        return 1;
	}

	id = House_Inside(playerid, true);

    if (id != -1)
   	{
   		if (PlayerData[playerid][pBaygin] == 1) return HataMesajGonder(playerid, "Yaralý olduðunuz için evden çýkamazsýnýz.");
     	if (HouseInfo[id][evKilit] == 1) return HataMesajGonder(playerid, "Bu ev kilitlenmiþ.");

		SetPlayerPos(playerid,HouseInfo[id][evPos][0],HouseInfo[id][evPos][1],HouseInfo[id][evPos][2]);
        SetPlayerInterior(playerid,0);
        SetPlayerVirtualWorld(playerid,0);

		ObjelerYukleniyor(playerid);
        SetCameraBehindPlayer(playerid);
        PlayerData[playerid][pHouse] = -1;
        SonMobilyaID[playerid] = -1;
        return 1;
    }

    id = Garage_Inside(playerid, true);

	if (id != -1)
	{
		if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			new vehicleid = GetPlayerVehicleID(playerid);

			SetVehiclePos(vehicleid, GarageData[id][gPos][0], GarageData[id][gPos][1], GarageData[id][gPos][2]);
	    	SetVehicleVirtualWorld(vehicleid, GarageData[id][gVw]);
	    	LinkVehicleToInteriorEx(vehicleid, 0);
	      	SetPlayerInterior(playerid, 0);
	       	SetPlayerVirtualWorld(playerid, GarageData[id][gVw]);
	    	ObjelerYukleniyor(playerid);
	    	PlayerData[playerid][pGarage] = -1;

	    	foreach (new i:Player)
	    	{
		    	if (IsPlayerInVehicle(i, vehicleid) && GetPlayerVehicleSeat(i) != 128 && GetPlayerVehicleSeat(i) != 0)
	 	        {
	           		SetPlayerPos(i,GarageData[id][gPos][0], GarageData[id][gPos][1], GarageData[id][gPos][2]);
	           		SetPlayerInterior(i, 0);
	           		SetPlayerVirtualWorld(i, GarageData[id][gVw]);
	           		SetCameraBehindPlayer(i);
	           		PutPlayerInVehicle(i, vehicleid, GetPlayerVehicleSeat(i));
	           		ObjelerYukleniyor(i);
	    	    }
			}
    	}else{
         	SetPlayerPos(playerid, GarageData[id][gPos][0], GarageData[id][gPos][1], GarageData[id][gPos][2]);
	      	SetPlayerInterior(playerid, 0);
	       	SetPlayerVirtualWorld(playerid, GarageData[id][gVw]);
	        SetCameraBehindPlayer(playerid);
	        ObjelerYukleniyor(playerid);
	        PlayerData[playerid][pGarage] = -1;
    	}
	    return 1;
	}

	id = Business_Inside(playerid, true);

	if (id != -1)
	{
		if (PlayerData[playerid][pBaygin] == 1) return HataMesajGonder(playerid, "Yaralý olduðunuz için iþ yerinden çýkamazsýnýz.");

		SetPlayerPos(playerid, Isyeri[id][isyeriPos][0], Isyeri[id][isyeriPos][1], Isyeri[id][isyeriPos][2]);
		SetPlayerFacingAngle(playerid, Isyeri[id][isyeriPos][3] - 180.0);
		SetPlayerInterior(playerid, 0);
		SetPlayerVirtualWorld(playerid, 0);

		ObjelerYukleniyor(playerid);

		if (Isyeri[id][isyeriTip] == 6)
			StopAudioStreamForPlayer(playerid);

		SetCameraBehindPlayer(playerid);
		PlayerData[playerid][pIsyeri] = -1;

		return 1;
	}
	return 1;
}
CMD:lisansgoster(playerid, params[])
{
	new oyuncuid;

	if(sscanf(params, "u", oyuncuid)) return KullanimMesaji(playerid, "/lisansgoster [id/isim]");
	if(!IsPlayerConnected(oyuncuid)) return HataMesaji(playerid, "Girilen kiþi oyunda deðil.");
	if(!OyundaDegil(oyuncuid) || !IsPlayerNearPlayer(playerid, oyuncuid, 5.0)) return HataMesajGonder(playerid, "Oyuncu giriþ yapmamýþ veya oyuncuya yakýn deðilsin.");

	new slisans[4],
		mlisans[4],
		string[100];

	if(PlayerData[playerid][pEhliyet] == 0)
		format(slisans, sizeof(slisans), "Yok");
	else
		format(slisans, sizeof(slisans), "Var");

	if(PlayerData[playerid][pMotorEhliyet] == 0)
		format(mlisans, sizeof(slisans), "Yok");
	else
		format(mlisans, sizeof(slisans), "Var");

	SendClientMessageEx(oyuncuid, COLOR_GREEN, "__________________[%s Lisanslarý]__________________", ReturnName(playerid, 0));
	SendClientMessageEx(oyuncuid, COLOR_WHITE, "Araç lisansý: [%s] | Motor lisansý: [%s]", slisans, mlisans);

	if(oyuncuid != playerid)
	{
		format(string, sizeof(string), "lisanslarýný çýkartýr ve %s adlý kiþiye gösterir.", ReturnName(oyuncuid, 0));
		callcmd::me(playerid, string);
	}
	else callcmd::me(playerid, "lisanslarýný cüzdanýndan çýkartýr ve inceler.");
	return 1;
}

CMD:ehliyetal(playerid)
{
	if(PlayerData[playerid][pEhliyetSinavinda] != 0)
		return HataMesajGonder(playerid, "Þu anda zaten sýnavda görünüyorsunuz, bir sorun oluþtuðunu düþünüyorsanýz relog atýn.");

	if(!IsPlayerInRangeOfPoint(playerid, 3.0, -2031.5973,-117.1739,1035.1719))
		return HataMesajGonder(playerid, "Ehliyet alma noktasýnda deðilsiniz.");

	Dialog_Show(playerid, DIALOG_EHLIYET, DIALOG_STYLE_LIST, "Sürücü Sýnavý:", "Sürücü lisansý sýnavý [$%d]\nMotorlu taþýt lisansý [$%d]", "Sýnava baþla", "Ýptal", EHLIYET_SURUCU, EHLIYET_MOTOR);
	return 1;
}
CMD:vipyardim(playerid)
{
	if (PlayerData[playerid][pVip] < 1)
		return HataMesajGonder(playerid, "Bu komut VIP özeldir.");

	BilgiMesajGonder(playerid, "VIP yardým: /vipmenu, /vipdolap");
	return 1;
}
CMD:sirketkur(playerid)
{
	HataMesajGonder(playerid, "Þirket sistemi kýsa süreliðine kapalýdýr, ilginiz için teþekkür ederiz.");
	return 1;
}
/* CMD:sirketkur(playerid,params[])
{
    new sirketid = PlayerData[playerid][pSirket];
    if(sirketid != -1) return HataMesaji(playerid, "Þu anda zaten bir þirkettesin");
    Dialog_Show(playerid, SirketKur, DIALOG_STYLE_INPUT, "> Þirket Kurma Menüsü", "*** Þirket Kurma Þartlarý\n\n? En az 5 seviye olmanýz gerekmektedir.\n? $15.500'e sahip olmanýz gerekmektedir.\n\nEðer bu þartlara uyuyorsan þirketinin adýný gir;", "Kur", "Iptal");
    return 1;
}
CMD:sirket(playerid, params[])
{
    new sirketid = PlayerData[playerid][pSirket];

    if (sirketid == -1) return HataMesaji(playerid, "Þu anda hiçbir bir þirkete üye deðilsin.");
    new
                hours,
                minutes,
                seconds;

    new string[1500], toplamoyuncu[1024];
    strcat(string, "Ýþlev\t#\n");
    new toplamsayi;
    foreach(new i : Player)
    {
        if(sirketid == PlayerData[i][pSirket]) toplamsayi++;
    }
    new tip[64];
        switch (sirketData[sirketid][sirketTip]) {
            case 1: tip = "Oyun Stüdyosu";
            case 2: tip = "Film Stüdyosu";
            case 3: tip = "Otomotiv";
        }
    format(toplamoyuncu, sizeof(toplamoyuncu), "{EEDD82}»{FFFFFF} Þirket Tipi\t{FFFFFF}%s {EEDD82}\n", tip);
    strcat(string, toplamoyuncu);
    format(toplamoyuncu, sizeof(toplamoyuncu), "{EEDD82}»{FFFFFF} Þirket Yönetim Kurulu Baþkaný\t{22AF1D}%s {FFFFFF}\n", sirketData[sirketid][sirketSahip]);
    strcat(string, toplamoyuncu);
    GetElapsedTime(sirketData[sirketid][sirketVergiZaman], hours, minutes, seconds);
    format(toplamoyuncu, sizeof(toplamoyuncu), "{EEDD82}»{FFFFFF} Gelecek Vergi\t{EEDD82}{FFFFFF}%02d saat %02d dakika{22AF1D}(%s)\n", hours, minutes, FormatNumber(sirketData[sirketid][sirketVergi]));
    strcat(string, toplamoyuncu);
    format(toplamoyuncu, sizeof(toplamoyuncu), "{EEDD82}»{FFFFFF} Þirket Çalýþma Potansiyeli\t{EEDD82}{FFFFFF}%d/%d saat\n", sirketData[sirketid][sirketCP],sirketData[sirketid][sirketCPT]);
    strcat(string, toplamoyuncu);
    format(toplamoyuncu, sizeof(toplamoyuncu), "{EEDD82}»{FFFFFF} Çalýþanlar\n");
    strcat(string, toplamoyuncu);
    if(!strcmp(ReturnName(playerid, 0), sirketData[sirketid][sirketSahip]))
    {
    format(toplamoyuncu, sizeof(toplamoyuncu), "{EEDD82}»{FFFFFF} Çalýþan Al\n");
    strcat(string, toplamoyuncu);
    }
    format(toplamoyuncu, sizeof(toplamoyuncu), "{EEDD82}»{FFFFFF} Yönetim Kurulu\n");
    strcat(string, toplamoyuncu);
    format(toplamoyuncu, sizeof(toplamoyuncu), "{EEDD82}»{FFFFFF} Þirket Kasasý\n");
    strcat(string, toplamoyuncu);
    if(strcmp(ReturnName(playerid, 0), sirketData[sirketid][sirketSahip]))
    {
    format(toplamoyuncu, sizeof(toplamoyuncu), "{EEDD82}»{FFFFFF} Þirketten Ayrýl\n");
    strcat(string, toplamoyuncu);
    }
    format(toplamoyuncu, sizeof(toplamoyuncu), "{EEDD82}» Þirket {FFFFFF}%s(#%d)", sirketData[sirketid][sirketAd],sirketData[sirketid][sirketID]);
    Dialog_Show(playerid, Sirket, DIALOG_STYLE_TABLIST_HEADERS, toplamoyuncu, string, "Seç", "Iptal");
    return 1;
}*/
CMD:sirketler(playerid)
{
	new str[1024];

	str = "Þirket\tTip\tKasa\n";

	new bool:bulundu = false;

	for(new i = 0; i != MAX_ISYERI; i++)
	{
		if(sirketData[i][sirketExists] < 1)
			continue;

		if(!bulundu) bulundu = true;

		format(str, sizeof(str), "%s%s\t%s\t$%d\n", str, sirketData[i][sirketAd], SirketTipIsim(sirketData[i][sirketTip]), sirketData[i][sirketKasa]);
	}

	if(!bulundu)
		return HataMesajGonder(playerid, "Listelenebilecek þirket bulunamadý.");

	Dialog_Show(playerid, 0, DIALOG_STYLE_TABLIST_HEADERS, "Þirketler", str, "Kapat", "");

	return 1;
}
CMD:discord(playerid)
{
	new query[61 + 11 + 1];

	mysql_format(g_SQL, query, sizeof(query), "SELECT discord_kod, discord_id FROM oyuncular WHERE ID = '%d'", PlayerData[playerid][pID]);
	mysql_tquery(g_SQL, query, "DiscordPanel", "d", playerid);

	return 1;
}
CMD:renkler(playerid, params[])
{
	ShowCarColorList(playerid,0,"Araç Renkleri","Kapat","");
	return 1;
}

CMD:hizlimiti(playerid, args[])
{
	new Float:hizdeger;

	if (!IsPlayerInAnyVehicle(playerid))
	    return HataMesajGonder(playerid, "Bu komutu sadece araçta kullanabilirsiniz.");

	if (sscanf(args, "f", hizdeger))
	    return KullanimMesaji(playerid, "/hizlimiti [Limit] (0.0 limiti kapatýr)");

	if (hizdeger < 0.0)
	    return HataMesajGonder(playerid, "Hýz deðerini 0 dan düþük giremezsiniz.");

    g_fSpeedCap[ playerid ][ GetPlayerVehicleID(playerid) ] = hizdeger;

	BilgiMesajGonder(playerid, "Hýz limiti %0.4f olarak ayarlanmýþtýr.", g_fSpeedCap[ playerid ][ GetPlayerVehicleID(playerid) ] );
	return true;
}

CMD:ts3(playerid)
{
	new id = TSC_GetClientIdByIpAddress(GetIP(playerid));

	if(id < 1)
		return HataMesajGonder(playerid, "Teamspeak3 sunucusunda deðilsiniz.");

	TSPanel(playerid);

	return 1;
}
CMD:kelepcekirdir(playerid, params[])
{
	if (!IsPlayerInRangeOfPoint(playerid, 1.5, 2260.6985, 63.2624, 26.4844))
		return HataMesajGonder(playerid, "Bu komutu kullanabilmek için kelepçecinin yanýnda olmalýsýn.");

    if (!PlayerData[playerid][pKelepce])
        return HataMesajGonder(playerid, "Zaten kelepçeli deðilsin.");

	if (PlayerData[playerid][pCash] < 2500)
	    return HataMesajGonder(playerid, "Kelepçeni kýrdýrmak için $2500 paran olmasý gerekiyor.");

	GameTextForPlayer(playerid, "~w~Kelepce Kiriliyor~n~~r~120", 2000, 4);

    TogglePlayerControllable(playerid, false);

	KelepceSure[playerid]  = 120;
	KelepceTimer[playerid] = SetTimerEx("KelepceKiriliyor", 1000, true, "d", playerid);
	return 1;
}
CMD:kar(playerid, params[])
{
	if(snowOn{playerid})
	{
	    DeleteSnow(playerid);
	    SendClientMessage(playerid, 0x00FF00AA, "* Artýk kar görmüyorsunuz.");
	}
	else
	{
	    CreateSnow(playerid);
	    SendClientMessage(playerid, 0x00FF00AA, "* Kendinize kar yaðdýrmaya baþladýnýz!");
	}
	return 1;
}
CMD:karac(playerid, params[])
{
    ploop(i) //This is included in my FS! It's the '#define ploop(%0)' thing.
    {
        if(snowOn{i}) continue;
        CreateSnow(i);
    }
    return 1;
}
CMD:karkapat(playerid, params[])
{
    ploop(i)
    {
        if(!snowOn{i}) continue;
        DeleteSnow(i);
    }
    return 1;
}
