enum pData
{
 	pID,
 	pYas,
 	pCinsiyet,
 	pDogum[30],
	pTen,
 	pSkin,
 	pCikisInt,
 	Float:pCikisPos[3],
 	pCikisVw,
 	pAdmin,
 	PMKapali,
 	pLastPM,
 	pHelper,
	pOyunGorevlisi,
 	pForumGorevlisi,
 	pCash,
	pAdminName[24],
 	pAdminDuty,
 	pHelperDuty,
	pEhliyet,
	pMotorEhliyet,
	pSeferSayi,
	pHouse,
	pFaction,
	pFactionRutbe,
	pFactionDivizyon,
	pBalikID[10],
	pBalikGram[10],
	pIsyeri,
	pGarage,
	pSu,
	pASlot[10],
	pTSlot[10],
	pABone[10],
	pARenk[10],
	Float:pHealth,
	Float:pArmour,
	pOnDuty,
	pOnDutySkin,
	pSilahlar[13],
	pMermiler[13],
	pAranma,
	pHapis,
	pHapisSure,
	pHapisSebep[50],
	pHapiseAtan[24],
	pTelefon,
	pTarife,
	pTarifeKalan[3],
	pTarifeSure,
	pBitcoin,
	pBoombox,
	pRadyo,
	pFrekans,
	pLevel,
	pEXP,
	pMaasSure,
	pOynamaSaati,
	pMaas,
	pDinle,
	pEsyalar[15],
	pTohumlar[3],
	pBagimlilik,
	pSilahAlmaSayisi,
	pSilahAlma,
    pTasimacilikSeviyess,
	pTasimacilikSeviye,
	pTasimacilikSefer,
	pBakiye,
	pEXPBoost,
	pBalikOrani,
	pYemTurleri[3],
	pVip,
	pVipSure,
	pDovusStili,
	pMaskeHakki,
	pMaskeID,
	pAyarlar[15],
	pPartner,
	pSerial[75],
	pHediye,
	pHediyeSaat,
	pYoutuber,
	bool:pYoutuberTag,
	pOldurme,
	pOlme,
	pTalepSayi,
	pCK,
	pMuted,
	pYatKontrol[5],
	pKelepceKir,
	pBeanbag,
	bool:pSoyun,
	bool:pAsoyun,
	pTaxiCalled,
	pTaksiKabul,
	bool:pTaxiDuty,
	Float:pTaksiUcret,
	pTaxiPlayer,
	pShootedBody,
	pLastShot,
	pPartnerTeklif,
	bool:pStand,
	pStandObject,
	Text3D:pStandText,
	bool:pHUD,
	pFriskOffer,
	pShakeOffer,
	pShakeType,
	bool:pGOD,
	pJetpack,
	pNameChange[24],
	pSpecID,
	pGraffiti,
	pGraffitiYazi[64],
	bool:pMaske,
	pVipRenk,
	pBagimlilikSayac[2],
	pSilahOffer,
	pSilahOfferID,
	pSilahOfferFiyat,
	pCadir,
	bool:pKampAtesi,
	pKampAtesiObject,
	bool:pMangalKuruldu,
	pMangalObject[2],
	pYemekPisiriliyor,
	pPisirilenYemek,
	Text3D:MangalText,
	yayinKonuk,
	pMuzikKutusu,
	pGPS,
	pTelefonAyar[6],
	pIhbar[128],
	pIhbarSayac,
	pAramada,
	pCallLine,
	pKonusmaSure,
	bool:pTopallama,
	pTopallamaSayac,
	pDuzenlenenPompa,
	pIyilestiriyor,
	pIyilestirmeSure,
	pBaygin,
	pBayginSure,
	bool:pLoopAnim,
	pDestek,
	pCCTV,
	pSoklandi,
	pYereYatirildi,
	pKelepce,
	pDragged,
	pDraggedBy,
	pDragTimer,
	pTazer,
	pLastCar,
	pEditGate,
	pEditType,
	pSelectType,
	pSelectFurniture,
	pEditFurniture,
	pMateryalDuzenle,
	pMateryalSlot,
	pFactionDavet,
	pFactionDavetEden,
	pFactionEdit,
	pSelectedSlot,
	pDrinking,
	PlayerBar:pDrinkBar,
	pCimentoTasiyor1,
	pCimentoTasiyor2,
	pSonBindigiArac,
	pBasari5,
	pBasari5Tarih[25],
	pBasari10,
	pBasari10Tarih[25],
	pBasariPB,
	pBasariPBTarih[25],
	pBasariArac,
	pBasariAracTarih[25],
	pBasariEv,
	pBasariEvTarih[25],
	bool:pLSPDUydu,
	pCamasirBasladi,
	pMateryal,
	pSilahHakki,
	pSilahSuresi,
	pSilahParca[3],
	Timer_Yuk,
	pEhliyetSinavinda,
    pEhliyetUyari,
	pAdvertise[128 char],
	pBasvuru[128 char],
    pSirketOffer,
    pSirketOffered,
    pSirket,
    pSirketID,
	SonMesajGonderen,
    pSirketRank,
    pSirketMaas,
	pLDavet,
	pTalepSure,
	pAirBreak,
	pYaris,
	pYarisAdim,
	pYarisHazirliyormu,
 	pLegalMotor,
 	pLegalTeleport,
 	pTeleport,
	pSpec,
	pLojistikFirma
}
new PlayerData[MAX_PLAYERS][pData];

enum yarisData {
	yarisID,
	yarisVarmi,
	yarisCountCP,
	yarisSiralama,
	yarisGeriSayim,
	Float:yarisCPx[64],
	Float:yarisCPy[64],
	Float:yarisCPz[64],
	yarisKurucu[24],
	yarisAd[24],
	yarisDurum,
	yarisKayit
};
new Yarislar[MAX_YARIS][yarisData];

new Float:gFerrisCageOffsets[10][3]=
{
	{0.0699,0.0600,-11.7500},
	{-6.9100,-0.0899,-9.5000},
	{11.1600,0.0000,-3.6300},
	{-11.1600,-0.0399,3.6499},
	{-6.9100,-0.0899,9.4799},
	{0.0699,0.0600,11.7500},
	{6.9599,0.0100,-9.5000},
	{-11.1600,-0.0399,-3.6300},
	{11.1600,0.0000,3.6499},
	{7.0399,-0.0200,9.3600}
};

new ColorList[][121] =
{
    "{000000}000 {F5F5F5}001 {2A77A1}002 {840410}003 {263739}004 {86446E}005 {D78E10}006 {4C75B7}007 {BDBEC6}008 {5E7072}009\n",
    "{46597A}010 {656A79}011 {5D7E8D}012 {58595A}013 {D6DAD6}014 {9CA1A3}015 {335F3F}016 {730E1A}017 {7B0A2A}018 {9F9D94}019\n",
    "{3B4E78}020 {732E3E}021 {691E3B}022 {96918C}023 {515459}024 {3F3E45}025 {A5A9A7}026 {635C5A}027 {3D4A68}028 {979592}029\n",
    "{421F21}030 {5F272B}031 {8494AB}032 {767B7C}033 {646464}034 {5A5752}035 {252527}036 {2D3A35}037 {93A396}038 {6D7A88}039\n",
    "{221918}040 {6F675F}041 {7C1C2A}042 {5F0A15}043 {193826}044 {5D1B20}045 {9D9872}046 {7A7560}047 {989586}048 {ADB0B0}049\n",
    "{848988}050 {304F45}051 {4D6268}052 {162248}053 {272F4B}054 {7D6256}055 {9EA4AB}056 {9C8D71}057 {6D1822}058 {4E6881}059\n",
    "{9C9C98}060 {917347}061 {661C26}062 {949D9F}063 {A4A7A5}064 {8E8C46}065 {341A1E}066 {6A7A8C}067 {AAAD8E}068 {AB988F}069\n",
    "{851F2E}070 {6F8297}071 {585853}072 {9AA790}073 {601A23}074 {20202C}075 {A4A096}076 {AA9D84}077 {78222B}078 {0E316D}079\n",
    "{722A3F}080 {7B715E}081 {741D28}082 {1E2E32}083 {4D322F}084 {7C1B44}085 {2E5B20}086 {395A83}087 {6D2837}088 {A7A28F}089\n",
    "{AFB1B1}090 {364155}091 {6D6C6E}092 {0F6A89}093 {204B6B}094 {2B3E57}095 {9B9F9D}096 {6C8495}097 {4D8495}098 {AE9B7F}099\n",
    "{406C8F}100 {1F253B}101 {AB9276}102 {134573}103 {96816C}104 {64686A}105 {105082}106 {A19983}107 {385694}108 {525661}109\n",
    "{7F6956}110 {8C929A}111 {596E87}112 {473532}113 {44624F}114 {730A27}115 {223457}116 {640D1B}117 {A3ADC6}118 {695853}119\n",
    "{9B8B80}120 {620B1C}121 {5B5D5E}122 {624428}123 {731827}124 {1B376D}125 {EC6AAE}126 {000000}127 {177517}128 {210606}129\n",
    "{125478}130 {452A0D}131 {571E1E}132 {010701}133 {25225A}134 {2C89AA}135 {8A4DBD}136 {35963A}137 {B7B7B7}138 {464C8D}139\n",
    "{84888C}140 {817867}141 {817A26}142 {6A506F}143 {583E6F}144 {8CB972}145 {824F78}146 {6D276A}147 {1E1D13}148 {1E1306}149\n",
    "{1F2518}150 {2C4531}151 {1E4C99}152 {2E5F43}153 {1E9948}154 {1E9999}155 {999976}156 {7C8499}157 {992E1E}158 {2C1E08}159\n",
    "{142407}160 {993E4D}161 {1E4C99}162 {198181}163 {1A292A}164 {16616F}165 {1B6687}166 {6C3F99}167 {481A0E}168 {7A7399}169\n",
    "{746D99}170 {53387E}171 {222407}172 {3E190C}173 {46210E}174 {991E1E}175 {8D4C8D}176 {805B80}177 {7B3E7E}178 {3C1737}179\n",
    "{733517}180 {781818}181 {83341A}182 {8E2F1C}183 {7E3E53}184 {7C6D7C}185 {020C02}186 {072407}187 {163012}188 {16301B}189\n",
    "{642B4F}190 {368452}191 {999590}192 {818D96}193 {99991E}194 {7F994C}195 {839292}196 {788222}197 {2B3C99}198 {3A3A0B}199\n",
    "{8A794E}200 {0E1F49}201 {15371C}202 {15273A}203 {375775}204 {060820}205 {071326}206 {20394B}207 {2C5089}208 {15426C}209\n",
    "{103250}210 {241663}211 {692015}212 {8C8D94}213 {516013}214 {090F02}215 {8C573A}216 {52888E}217 {995C52}218 {99581E}219\n",
    "{993A63}220 {998F4E}221 {99311E}222 {0D1842}223 {521E1E}224 {42420D}225 {4C991E}226 {082A1D}227 {96821D}228 {197F19}229\n",
    "{3B141F}230 {745217}231 {893F8D}232 {7E1A6C}233 {0B370B}234 {27450D}235 {071F24}236 {784573}237 {8A653A}238 {732617}239\n",
    "{319490}240 {56941D}241 {59163D}242 {1B8A2F}243 {38160B}244 {041804}245 {355D8E}246 {2E3F5B}247 {561A28}248 {4E0E27}249\n",
    "{706C67}250 {3B3E42}251 {2E2D33}252 {7B7E7D}253 {4A4442}254 {28344E}255\n"
};

enum Labeller
{
	Text3D: ID,
	objeID,
	LabelAdi[MAX_LABEL_ADI],
	Renk,
	VW,
	Int,
	Duzenleniyor,
	Float: Pos[3],
	Float: Mesafe
}
new Label[MAX_LABEL][Labeller];

enum YatData
{
	yatObject,
	yatSurObject,
	yatKiralayan,
	yatKiraSure,
	yatOto,
	yatStep,
	yatUyari,
	yatTeslimSure

}
new YatBilgi[YatData];

enum NPC
{
	npcID,
	bool:npcExists,
	npcAd[24],
	npcSkin,
	Float:npcPos[4],
	npcVw,
	npcActor,
	Text3D:npcLabel
}
new NPCBilgi[MAXIMUM_NPC][NPC];
new NPCSecenekler[MAXIMUM_NPC][MAX_SECENEK][50];
new NPCSecenekCevaplar[MAXIMUM_NPC][MAX_SECENEK][200];

enum SoruBilgi
{
    soruID,
    soruExists,
    Soru[50],
    SoruCevap[128],
    OkunmaSayisi,
    EklenmeTarihi[25],
    Ekleyen[24]
}
new SoruData[MAX_SORU][SoruBilgi];
new SoruListeleme[MAX_PLAYERS][45];
new AnahtarKelime[MAX_PLAYERS][20];

enum arsa
{
	arsaExists,
	arsaSahip,
	arsaTip,
	Float:arsaPos[3],
	arsaFiyat,
	KiraSure,
	arsaMaxTohum,
	Metrekare,
	arsaPickup,
	Text3D:arsaLabel
}
new ArsaBilgi[MAX_ARSA][arsa];

enum tohum
{
	tohumArsa,
	tohumTip,
	Float:tohumPos[3],
	tohumBuyume,
	tohumSayi,
	tohumObject,
	Text3D:tohumLabel
}
new Tohumlar[MAX_TOHUM][tohum];

new Float: TohumAttachOffsets[5][3] =
{
    {-0.500000, -0.899999, 0.000000},
    {0.100000, -0.899999, 0.000000},
    {0.599999, -0.900000, 0.000000},
    {-0.299999, -1.700000, 0.000000},
    {0.300000, -1.700000, 0.000000}
};
enum inventoryData {
	invExists,
	invID,
	invItem[64 char],
	invModel,
	invQuantity
};

enum PaintballDegiskenler
{
	bool:odaExists,
	odaIsim[30],
	odaSifre[30],
	odaSahip,
	odaTakim1Ad[20],
	odaTakim2Ad[20],
	odaSilahlar[4],
	odaZirh,
	odaSure,
	odaOyunTuru,
	odaArena,
	odaPuan[2],
	bool:TakimDengeleme,
	odaDurum,
	odaSayac
}
new Paintball[MAX_ODA][PaintballDegiskenler];
enum graffitiData {
    graffitiID,
    graffitiExists,
    Float:graffitiPos[6],
    graffitiObject,
    graffitiFont[64],
    graffitiText[64]
};
new GraffitiData[MAX_GRAFFITI_POINTS][graffitiData];
enum ticketData {
    ticketID,
    ticketExists,
    ticketFee,
    ticketMemur[24],
    ticketDate[36],
    ticketReason[64]
};
new TicketData[MAX_PLAYERS][MAX_PLAYER_TICKETS][ticketData];
enum droppedWeapons
{
	droppedID,
	bool:droppedExists,
	droppedPlayer,
	Float:droppedPos[3],
	droppedWeapon,
	droppedAmmo,
	droppedInt,
	droppedVw,
	droppedObject,
	Text3D:droppedText
}
new DroppedWeapon[MAX_DROPPED_WEAPONS][droppedWeapons];
enum cadirlar
{
	bool:cadirExists,
	cadirSahip,
	Float:cadirPos[3],
	cadirObject,
	Text3D:cadirText
}
new CadirData[MAX_CADIR][cadirlar];
enum reklam
{
	reklamExists,
	ajansID,
	reklamIletisim,
	reklamIcerik[128],
	reklamGonderen,
	reklamUcret

}
new Reklamlar[MAX_REKLAM][reklam];

enum e_GISE
{
	gs_ID,
	bool:gs_Exists,
	gs_Obje,
	gs_GateObje,
	gs_Durum,
	Float:gs_GateBar[6],
	Float:gs_Kapali[6],
	Float:gs_Acik[6],
	Text3D:gs_id,
	Text3D:gs_inf
};

new Gise[MAX_GISE][e_GISE];

/*============================================================================*/

enum hasarData
{
	bool:hasarVarmi,
	hasarBolge,
	Float:hasarDeger,
	hasarVeren,
	hasarSilah
};
new Hasarlar[MAX_PLAYERS][MAX_HASAR][hasarData];
enum entranceData {
    entranceID,
    entranceExists,
    entranceName[32],
    entrancePass[32],
    entranceIcon,
    entrancepIcon,
    entranceLocked,
    entranceInteriorVw,
    entranceBaglanti,
    Float:entrancePos[4],
    Float:entranceInt[4],
    entranceInterior,
    entranceExterior,
    entranceExteriorVW,
    entrancePickup,
    eVip,
    entranceMapIcon,
    Text3D:entranceText3D
};
new EntranceData[MAX_ENTRANCES][entranceData];

enum AracBilgi
{
	aracID,
	aracExists,
	aracModel,
	aracSahip,
	aracDisplay,
	Float:aracPos[4],
	aracInterior,
	aracWorld,
	aracRenkler[2],
	aracPaintjob,
	aracZirh,
	aracZirhVarMi,
	aracKilit,
	aracVergi,
	aracVergiSure,
	aracMods[14],
	aracGaraj,
	TaksiPlaka,
	aracBaglandi,
	aracBaglandiCeza,
	aracTicket,
	aracTicketTime,
	aracElKonuldu,
	aracFaction,
	aracFactionType,
	aracKira,
	aracKiralayan,
	aracTip,
	aracSatilik,
	aracPlaka[24],
	aracKiraZaman,
	aracSilahlar[5],
	aracMermiler[5],
	aracFiyat,
	aracUyusturucu,
	Float:aracKM,
	Float:aracBenzin,
	aracVehicle,
	Text3D:aracLabel,
	bool:aracCamlar,
	bool:aracSirenAcik,
    bool:elfreni,
	SirenObject,
	bool:aracRadar,
	TaksiObje,
	Taksimetre,
	OturumKazanci,
	aracSeviye
}
new AracInfo[MAX_ARAC][AracBilgi];

enum cruiser
{
	Silahlar[5],
	Mermiler[5],
	AgriKesici,
	CelikYelek
}
new PolisAraci[MAX_VEHICLES][cruiser];
enum gateData
{
	gateID,
	gateExists,
	gateOpened,
	gateModel,
	Float:gateSpeed,
	gateVip,
	Float:gateRadius,
	gateTime,
	Float:gatePos[6],
	gateInterior,
	gateOwner,
	gateBirlik,
	gateWorld,
	Float:gateMove[6],
	gateLinkID,
	gateFaction,
	gatePass[32],
	gateTimer,
	gateObject
};
new GateData[MAX_GATES][gateData];

enum dealershipCars {
	vehID,
	vehModel,
	vehPrice
};
new DealershipCars[MAX_ISYERI][MAX_DEALERSHIP_CARS][dealershipCars];

enum arrestPoints {
	arrestID,
	arrestExists,
	Float:arrestPos[3],
	arrestInterior,
	arrestWorld,
	Text3D:arrestText3D,
	arrestPickup
};
new ArrestData[MAX_ARREST_POINTS][arrestPoints];

enum E_CCTV_INFO
{
	ID,

	cctv_Name[30],
	Float: cctv_X,
	Float: cctv_Y,
	Float: cctv_Z,

	Float: cctv_rotX,
	Float: cctv_rotY,
	Float: cctv_rotZ,

	cctv_VW,
	cctv_Interior,
	cctvBildirim,
	cctv_Object
};
new CCTVInfo[MAX_CCTV][E_CCTV_INFO];
enum Lokasyonlar
{
	ID,
	bool:Exists,
	lokasyonAd[30],
	Float:lokasyonPos[3],
}
new Lokasyon[MAX_LOKASYON][Lokasyonlar];
enum boomboxData {
	boomboxPlaced,
	Float:boomboxPos[3],
	boomboxInterior,
	boomboxWorld,
	boomboxObject,
	boomboxURL[128 char],
	Text3D:boomboxText3D
};
new BoomboxData[MAX_PLAYERS][boomboxData];

enum garajlar
{
	gID,
	bool:gExists,
	gKilit,
	gSifre[30],
	gBirlik,
	gSahip,
	Float:gPos[3],
	gParkDurum,
	gVw,
	gInterior,
	gTip[20],
	gAracLimit,
	gPickup,
	Text3D:gText,
}
new GarageData[MAX_GARAGE][garajlar];

enum SirketData {
    sirketID,
    sirketExists,
    sirketAd[24],
    sirketTip,
    sirketVergiZaman,
    sirketVergi,
    sirketRank,
    sirketCP,
    sirketCEO[24],
    sirketGM[24],
    sirketCPT,
    sirketSahip[24],
    sirketKasa
}
new sirketData[MAX_ISYERI][SirketData];
