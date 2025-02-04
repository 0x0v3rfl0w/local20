
/obj/item/encryptionkey
	name = "Standard Encryption Key"
	desc = "An encyption key for a radio headset. Contains cypherkeys."
	icon = 'icons/obj/radio.dmi'
	icon_state = "cypherkey"
	item_state = ""
	w_class = WEIGHT_CLASS_TINY
	origin_tech = "engineering=2;bluespace=1"
	var/translate_binary = FALSE
	var/translate_hive = FALSE
	var/syndie = FALSE
	var/change_voice = FALSE
	var/list/channels = list()


/obj/item/encryptionkey/attackby(obj/item/W as obj, mob/user as mob, params)

/obj/item/encryptionkey/syndicate
	name = "syndicate encryption key"
	icon_state = "syn_cypherkey"
	channels = list("Syndicate" = 1)
	origin_tech = "syndicate=1;engineering=3;bluespace=2"
	syndie = TRUE //Signifies that it de-crypts Syndicate transmissions
	change_voice = TRUE
	var/fake_name = "Agent ALERT_A_CODER"
	var/static/list/fakename_list

/obj/item/encryptionkey/syndicate/Initialize()
	if(!LAZYLEN(fakename_list))
		fakename_list = GLOB.html_colors.Copy()
	. = ..()
	if(change_voice)
		fake_name = "Agent [pick_n_take(fakename_list)]"

/obj/item/encryptionkey/syndicate/nukeops
	change_voice = FALSE

/obj/item/encryptionkey/syndicate/taipan
	change_voice = FALSE
	icon_state = "taipan_cypherkey"
	channels = list("SyndTaipan" = 1)

/obj/item/encryptionkey/syndicate/taipan/borg
	change_voice = FALSE
	icon_state = "taipan_cypherkey"
	channels = list("SyndTaipan" = 1, "Syndicate" = 1)
/obj/item/encryptionkey/syndicate/taipan/tcomms_agent
	icon_state = "ofcom_cypherkey"
	channels = list("SyndTaipan" = 1, "Syndicate" = 1, "Common" = 1)

/obj/item/encryptionkey/syndteam
	name = "syndicate encryption key"
	icon_state = "syn_cypherkey"
	channels = list("SyndTeam" = 1, "Syndicate" = 1)
	origin_tech = "syndicate=4"
	syndie = TRUE //Signifies that it de-crypts Syndicate transmissions

/obj/item/encryptionkey/soviet
	name = "\improper Soviet encryption key"
	desc = "An encryption key for a radio headset. To access the Soviet military channel, use :'."
	icon_state = "sov_cypherkey"
	channels = list("Soviet" = 1)

/obj/item/encryptionkey/binary
	name = "binary translator key"
	desc = "An encryption key for a radio headset. To access the binary channel, use :+."
	icon_state = "bin_cypherkey"
	translate_binary = TRUE
	origin_tech = "syndicate=1;engineering=4;bluespace=3"

/obj/item/encryptionkey/headset_sec
	name = "Security Radio Encryption Key"
	icon_state = "sec_cypherkey"
	channels = list("Security" = 1)

/obj/item/encryptionkey/headset_iaa
	name = "Internal Affairs Radio Encryption Key"
	icon_state = "sec_cypherkey"
	channels = list("Security" = 1, "Procedure" = 1)

/obj/item/encryptionkey/headset_eng
	name = "Engineering Radio Encryption Key"
	icon_state = "eng_cypherkey"
	channels = list("Engineering" = 1)

/obj/item/encryptionkey/headset_rob
	name = "Robotics Radio Encryption Key"
	icon_state = "rob_cypherkey"
	channels = list("Engineering" = 1, "Science" = 1)

/obj/item/encryptionkey/headset_med
	name = "Medical Radio Encryption Key"
	icon_state = "med_cypherkey"
	channels = list("Medical" = 1)

/obj/item/encryptionkey/headset_sci
	name = "Science Radio Encryption Key"
	icon_state = "sci_cypherkey"
	channels = list("Science" = 1)

/obj/item/encryptionkey/headset_medsci
	name = "Medical Research Radio Encryption Key"
	icon_state = "medsci_cypherkey"
	channels = list("Medical" = 1, "Science" = 1)

/obj/item/encryptionkey/headset_medsec
	name = "Medical Security Radio Encryption Key"
	icon_state = "sec_cypherkey"
	channels = list("Security" = 1, "Medical" = 1)

/obj/item/encryptionkey/headset_com
	name = "Command Radio Encryption Key"
	icon_state = "com_cypherkey"
	channels = list("Command" = 1)

/obj/item/encryptionkey/heads/captain
	name = "Captain's Encryption Key"
	icon_state = "cap_cypherkey"
	channels = list("Command" = 1, "Security" = 1, "Engineering" = 0, "Science" = 0, "Medical" = 0, "Supply" = 0, "Service" = 0, "Procedure" = 1)

/obj/item/encryptionkey/heads/rd
	name = "Research Director's Encryption Key"
	icon_state = "rd_cypherkey"
	channels = list("Science" = 1, "Command" = 1)

/obj/item/encryptionkey/heads/hos
	name = "Head of Security's Encryption Key"
	icon_state = "hos_cypherkey"
	channels = list("Security" = 1, "Command" = 1)

/obj/item/encryptionkey/heads/ce
	name = "Chief Engineer's Encryption Key"
	icon_state = "ce_cypherkey"
	channels = list("Engineering" = 1, "Command" = 1)

/obj/item/encryptionkey/heads/cmo
	name = "Chief Medical Officer's Encryption Key"
	icon_state = "cmo_cypherkey"
	channels = list("Medical" = 1, "Command" = 1)

/obj/item/encryptionkey/heads/hop
	name = "Head of Personnel's Encryption Key"
	icon_state = "hop_cypherkey"
	channels = list("Supply" = 1, "Service" = 1, "Security" = 0, "Command" = 1)

/obj/item/encryptionkey/heads/ntrep
	name = "Nanotrasen Representative's Encryption Key"
	icon_state = "com_cypherkey"
	channels = list("Command" = 1, "Security" = 0, "Engineering" = 0, "Science" = 0, "Medical" = 0, "Supply" = 0, "Service" = 0, "Procedure" = 1)

/obj/item/encryptionkey/heads/magistrate
	name = "Magistrate's Encryption Key"
	icon_state = "com_cypherkey"
	channels = list("Command" = 1, "Security" = 1, "Procedure" = 1)

/obj/item/encryptionkey/heads/blueshield
	name = "Blueshield's Encryption Key"
	icon_state = "com_cypherkey"
	channels = list("Command" = 1)

/*
/obj/item/encryptionkey/headset_mine
	name = "Mining Radio Encryption Key"
	icon_state = "mine_cypherkey"
	channels = list("Mining" = 1)

/obj/item/encryptionkey/heads/qm
	name = "Quartermaster's Encryption Key"
	icon_state = "qm_cypherkey"
	channels = list("Cargo" = 1, "Mining" = 1)
*/
/obj/item/encryptionkey/headset_cargo
	name = "Supply Radio Encryption Key"
	icon_state = "cargo_cypherkey"
	channels = list("Supply" = 1)

/obj/item/encryptionkey/headset_service
	name = "Service Radio Encryption Key"
	icon_state = "srv_cypherkey"
	channels = list("Service" = 1)

/obj/item/encryptionkey/ert
	name = "Nanotrasen ERT Radio Encryption Key"
	channels = list("Response Team" = 1, "Science" = 1, "Command" = 1, "Medical" = 1, "Engineering" = 1, "Security" = 1, "Supply" = 1, "Service" = 1, "Procedure" = 1)

/obj/item/encryptionkey/centcom
	name = "Centcom Radio Encryption Key"
	channels = list("Response Team" = 1, "Special Ops" = 1, "Science" = 1, "Command" = 1, "Medical" = 1, "Engineering" = 1, "Security" = 1, "Supply" = 1, "Service" = 1, "Procedure" = 1)

/obj/item/encryptionkey/heads/ai_integrated //ported from bay, this goes 'inside' the AI.
	name = "AI Integrated Encryption Key"
	desc = "Integrated encryption key"
	icon_state = "cap_cypherkey"
	channels = list("Command" = 1, "Security" = 1, "Engineering" = 1, "Science" = 1, "Medical" = 1, "Supply" = 1, "Service" = 1, "AI Private" = 1, "Procedure" = 1)

/obj/item/encryptionkey/admin //totally shitspawn
	name = "Admin Radio Encryption Key"
	channels = list("Common" = 1, "Science" = 1, "Command" = 1, "Medical" = 1, "Engineering" = 1, "Security" = 1, "Supply" = 1, "Service" = 1, "Procedure" = 1, "AI Private" = 1, "Syndicate" = 1, \
		"Response Team" = 1, "Special Ops" = 1, "SyndTaipan" = 1, "SyndTeam" = 1, "Soviet" = 1, "Medical(I)" = 1, "Security(I)" = 1, "Spy Spider" = 1, "Spider Clan" = 1, "Alpha wave" = 1, "Beta wave" = 1, "Gamma wave" = 1)

/obj/item/encryptionkey/event_1
	name = "Encryption key"
	desc = "An encryption key for a radio headset. To access special radio channel, use :q."
	icon_state = "sov_cypherkey"
	channels = list("Alpha wave" = 1)

/obj/item/encryptionkey/event_2
	name = "Encryption key"
	desc = "An encryption key for a radio headset. To access special radio channel, use :vi."
	icon_state = "sov_cypherkey"
	channels = list("Beta wave" = 1)

/obj/item/encryptionkey/event_3
	name = "Encryption key"
	desc = "An encryption key for a radio headset. To access special radio channel, use :y."
	icon_state = "sov_cypherkey"
	channels = list("Gamma wave" = 1)

