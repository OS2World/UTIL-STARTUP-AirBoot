; AiR-BOOT (c) Copyright 1998-2008 M. Kiewitz
;
; This file is part of AiR-BOOT
;
; AiR-BOOT is free software: you can redistribute it and/or modify it under
;  the terms of the GNU General Public License as published by the Free
;  Software Foundation, either version 3 of the License, or (at your option)
;  any later version.
;
; AiR-BOOT is distributed in the hope that it will be useful, but WITHOUT ANY
;  WARRANTY: without even the implied warranty of MERCHANTABILITY or FITNESS
;  FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
;  details.
;
; You should have received a copy of the GNU General Public License along with
;  AiR-BOOT. If not, see <http://www.gnu.org/licenses/>.
;
;---------------------------------------------------------------------------
;                                          AiR-BOOT SETUP / ALL SETUP MENUS
; v046 - Swedish - by Bj�rn S�derstr�m
;---------------------------------------------------------------------------

; Main Setup - Items - Max Length: 33
;----------------------------------|-------------------------------|--------
TXT_SETUP_PartitionSetup       db 'SETUP AV PARTITIONER', 0
TXT_SETUP_BasicOptions         db 'GRUNDL�GGANDE OPTIONER', 0
TXT_SETUP_AdvOptions           db 'AVANCERADE OPTIONER', 0
TXT_SETUP_ExtOptions           db 'UT�KADE BOOTNINGSOPTIONER', 0
TXT_SETUP_DefMasterPwd         db 'DEFINIERA MASTER L�SENORD', 0
TXT_SETUP_DefBootPwd           db 'DEFINIERA BOOT L�SENORD', 0
TXT_SETUP_SaveAndExit          db 'SPARA & AVSLUTA SETUP', 0
TXT_SETUP_JustExit             db 'AVSLUTA UTAN ATT SPARA', 0

; The Letters for all flags in Partition Setup
TXT_SETUP_FlagLetterBootable   equ 'B'
TXT_SETUP_FlagLetterVIBR       equ 'V'
TXT_SETUP_FlagLetterHide       equ 'H'
TXT_SETUP_FlagLetterDrvLetter  equ 'L'
TXT_SETUP_FlagLetterExtMShack  equ 'P'

TXT_SETUP_LetterYes            equ 'J'
TXT_SETUP_LetterYes2           equ 'Z'
TXT_SETUP_LetterNo             equ 'N'

; Basic Options - Items - Max Length: 23
;----------------------------------|---------------------|------------------
TXT_SETUP_DefaultSelection     db 'Standard Partition', 0
TXT_SETUP_TimedBoot            db 'Tidstyrd Bootning', 0
TXT_SETUP_TimedBootDelay       db 'TidsBoot F�rdr�j (sek)', 0
TXT_SETUP_TimedKeyHandling     db 'Tids Tangenthantering', 0
TXT_SETUP_BootLastIfTimed      db 'Boota fr.Senast Om Tids', 0
TXT_SETUP_RememberLastBoot     db 'Kom Ih�g Senaste Boot', 0
TXT_SETUP_RememberTimedBoot    db 'Kom Ih�g Tids Boot', 0
TXT_SETUP_IncludeFloppy        db 'Inkludera Diskettenhet', 0
TXT_SETUP_ShowLVMDriveLetters  db 'Show LVM Drive Letters',0
TXT_SETUP_MbrProtection        db 'MBR Skydd', 0
TXT_SETUP_IgnoreMbrWrites      db '-> Ignorera MBR Skriv', 0
TXT_SETUP_MakeSounds           db 'Anv�nd Ljud', 0
TXT_SETUP_CooperBars           db 'Cooper Bars', 0

; Advanced Options - Items - Max Length: 23
;----------------------------------|---------------------|------------------
TXT_SETUP_BootMenu             db 'Bootning Meny', 0
TXT_SETUP_PartAutoDetect       db 'Partition Autouppt�ck', 0
TXT_SETUP_SecurityOptions      db '-> S�kerhet Opt. <-', 0
TXT_SETUP_PasswordedSetup      db 'L�senskyddad Setup', 0
TXT_SETUP_PasswordedSystem     db 'L�senskyddat System', 0
TXT_SETUP_PasswordedChangeBoot db 'L�senskyddad Boot�ndr.', 0
TXT_SETUP_GetFloppyName        db 'H�mta Diskettnamn', 0
TXT_SETUP_GetFloppyName2Sec    db '-> H�mta Var 2 Sekund', 0
TXT_SETUP_VirusDetect          db 'Virus Uppt�ckt', 0
TXT_SETUP_StealthDetect        db 'Stealth Uppt�ckt', 0
TXT_SETUP_VIBRdetect           db 'VIBR Uppt�ckt', 0
TXT_SETUP_ContinueBIOSboot     db 'Forts�tt BIOS Boot Sekv', 0

; Extended Options - Items - Max Length: 23
;----------------------------------|---------------------|------------------
; [Linux support removed since v1.02]
;TXT_SETUP_LinuxKernelPart      db 'Linux Kernel Partition', 0
;TXT_SETUP_LinuxDefaultKernel   db 'Linux Standard K�rna', 0
;TXT_SETUP_LinuxRootPart        db 'Linux Root Partition', 0
; This here may be larger than 23 chars...
;TXT_SETUP_DefLinuxCmd          db 'DEFINIERA KOMMANDORAD F�R LINUX', 0
TXT_SETUP_IgnoreLVM            db 'Ignore LVM information', 0
; ###
;~ TXT_SETUP_ForceLBAUsage        db 'Forc BIOS-LBA Anv�ndn.', 0
TXT_SETUP_ExtPartMShack        db 'Ext-Part MS Workaround', 0

; DYNAMIC LENGTH, maximum 11 chars excluding ending zero
;----------------------------------|---------|------------------------------
TXT_SETUP_MAGIC_Enabled        db 'Aktiverad', 0
TXT_SETUP_MAGIC_Disabled       db 'Avaktiverad', 0
TXT_SETUP_MAGIC_Detailed       db 'Detaljerad', 0
TXT_SETUP_MAGIC_NoBootable     db 'Ej Bootbar', 0
; [Linux support removed since v1.02]
;TXT_SETUP_MAGIC_NoLinux        db 'Ej Linux', 0
TXT_SETUP_MAGIC_DoNothing      db 'G�r Inget', 0
TXT_SETUP_MAGIC_ResetTime      db '�terst. Tid', 0
TXT_SETUP_MAGIC_StopTime       db 'Stopp Tid', 0
TXT_SETUP_MAGIC_CDROM          db 'CD-ROM', 0
TXT_SETUP_MAGIC_Network        db 'N�tverk', 0
TXT_SETUP_MAGIC_ZIPLS          db 'ZIP/LS120', 0
; Max Length: 10 (used in Hide-Configuration as well)
;----------------------------------|--------|-------------------------------
TXT_SETUP_MAGIC_Hidden         db 'Dold', 0
TXT_SETUP_MAGIC_Unhidden       db 'Ej Dold', 0
; Max Length: 10 ("C:" will be appended afterwards)
;----------------------------------|--------|-------------------------------
TXT_SETUP_MAGIC_Set            db 's�tt ', 0

; Setup Control Help - Max Length: 33
;----------------------------------|-------------------------------|--------
TXT_SETUPHELP_Main             db 24,32,25,32,26,32,27,' : V�lj Aktion', 0
                               db               'Enter   : V�lj Aktion', 0
                               db               'F10 : Spara&Avsluta Setup', 0
                               db               'Esc : L�mna Setup', 0

TXT_SETUPHELP_SubMenu          db 24,32,25,32,26,32,27,' : V�lj Post', 0
                               db               'PgUp/Dn : �ndra Post', 0
                               db               'F1  : Visa hj�lp f�r post', 0
                               db               'Esc : �terv�nd till huvud-menyn', 0

TXT_SETUPHELP_PartSetup        db 24,32,25,32,26,32,27,' : V�lj partition', 0
                               db               'Enter   : Editera etikett', 0
                               db               'F1  : Flagga (tryck tg f�r v�xl)', 0
                               db               'Esc : �terv�nd till huvud-menyn', 0

; HELP FOR EVERY MENU-ITEM, Maximum Length = 22 chars PER line. Maximum 5 lines

                                  ;1234567890123456789012
;----------------------------------|--------------------|-------------------
TXT_SETUPHELP_PartitionSetup   db 'G�r dina partitioner', 0
                               db 'bootningsbara, �ndra', 0
                               db 'deras namn, definiera', 0
                               db 'g�mma och mycket', 0
                               db 'annat.', 0
                               db 0
TXT_SETUPHELP_BasicOptions     db 'Dessa optioner �r f�r', 0
                               db 'oerfarna anv�ndare.', 0
TXT_SETUPHELP_AdvOptions       db 'Dessa �r f�r', 0
                               db 'avancerade anv�ndare.', 0
                               db 'Om du inte vet vad de', 0
                               db 'g�r, l�mna som de �r.', 0
                               db 0
TXT_SETUPHELP_ExtOptions       db 'Ut�kade optioner f�r', 0
                               db 'specifika OS.', 0
                               db 0
TXT_SETUPHELP_DefMasterPwd     db 'Definiera ett', 0
                               db 'l�senord f�r access', 0
                               db 'till setup och', 0
                               db 'system.', 0
                               db 0
TXT_SETUPHELP_DefBootPwd       db 'Definiera ett', 0
                               db 'l�senord f�r access', 0
                               db 'till system.',0
                               db 0
TXT_SETUPHELP_SaveAndExit      db 'Kommer att fors�tta', 0
                               db 'bootprocessen och', 0
                               db 'spara de aktuella', 0
                               db 'optionerna.',0
                               db 0
TXT_SETUPHELP_JustExit         db 'Kommer att fors�tta', 0
                               db 'men ignorerar alla', 0
                               db '�ndringar som gjorts', 0
                               db 'till optionerna.',0
                               db 0

TXT_SETUPHELP_InPartitionSetup db 'B - Bootningbar', 0
                               db 'V - VIBR-Uppt�ckt', 0
                               db 'H - Dolt St�d', 0
                               db 'L - Partition Bokstav', 0
                               db 'P - Ext-Part MS invent', 0
                               db 0

TXT_SETUPHELP_HideSetup        db 'V�lj status f�r', 0
                               db 'vilka partitioner', 0
                               db 'som skall d�ljas,', 0
                               db 'n�r den aktuellt valda', 0
                               db 'partitionen bootas.', 0
                               db 0

; Basic Options - Help
;----------------------------------|--------------------|-------------------
TXT_SETUPHELP_DefaultSelection db 'Changes your default', 0
                               db 'selection. It can be', 0
                               db 'used on Timed Boot.', 0
                               db 0
; ####
TXT_SETUPHELP_DefaultPart      db '�ndrar din standard', 0
                               db 'partition. Den kan', 0
                               db 'anv�ndas vid Tidstyrd', 0
                               db 'Bootning.', 0
                               db 0
TXT_SETUPHELP_TimedBoot        db 'AiR-BOOT kommer att', 0
                               db 'forts�tta automatiskt', 0
                               db 'efter en specificerad', 0
                               db 'f�rdr�jning.', 0
                               db 0
TXT_SETUPHELP_TimedBootDelay   db 'Den omn�mnda', 0
                               db 'f�rdr�jningen f�r.', 0
                               db 'Tidsstyrd Bootning.', 0
                               db 0
TXT_SETUPHELP_TimedKeyHandling db 'Om du trycker en', 0
                               db 'tangent i Bootmenyn', 0
                               db 'n�r du anv�nder Tids', 0
                               db 'Boot, vad skall', 0
                               db 'AiR-BOOT g�ra?',0
                               db 0
TXT_SETUPHELP_BootLastIfTimed  db 'AiR-BOOT kommer att', 0
                               db 'anv�nda sist-bootade', 0
                               db 'part. med TidsBoot.', 0
                               db 'Annars kommer den', 0
                               db 'att anv�nda standard', 0
			                   db 0
TXT_SETUPHELP_RememberLastBoot db 'AiR-BOOT kommer att', 0
                               db 'h�lla meny-raden p�', 0
                               db 'sist bootade', 0
                               db 'partionen vid start.', 0
                               db 0
TXT_SETUPHELP_RememberTimeBoot db 'Liksom den senaste', 0
                               db 'optionen, kommer', 0
                               db 'AiR-BOOT att h�lla', 0
                               db 'raden ocks� f�r', 0
                               db 'Tidsstyrd Bootning.', 0
			                   db 0
TXT_SETUPHELP_IncludeFloppy    db 'AiR-BOOT kommer att', 0
                               db 'till�ta booting', 0
                               db 'fr�n A: via menyn.', 0
                               db 0
TXT_SETUPHELP_ShowLVMDriveLetters   db 'AiR-BOOT will show', 0
                                    db 'LVM Drive Letters', 0
                                    db 'in the menu.', 0
                                    db 0
TXT_SETUPHELP_MbrProtection    db 'Skydda din MBR via', 0
                               db 'resident kod. Beh�ver', 0
                               db '1 KByte av bas-minne', 0
                               db 'Kan vara inkompatibelt', 0
                               db 'med vissa OS.', 0
			                   db 0
TXT_SETUPHELP_IgnoreMbrWrites  db 'Om det �r aktiverat,', 0
                               db 'kommer all skrivning', 0
                               db 'att ignoreras, annars', 0
                               db 'kommer systemet att', 0
                               db '"krascha".', 0
                               db 0
TXT_SETUPHELP_MakeSounds       db 'AiR-BOOT kan f�s att', 0
                               db 'utf�ra ljud med din', 0
                               db 'interna h�gtalare.', 0
                               db 0
TXT_SETUPHELP_CooperBars       db 'Kommer att utf�ra', 0
                               db 'snygga effekter', 0
                               db 'under bootning.', 0
                               db 0

; Advanced Options - Help
;----------------------------------|--------------------|-------------------
TXT_SETUPHELP_BootMenu         db 'Avaktiverad visar den', 0
                               db 'inte menyn och bootar', 0
                               db 'standard partion', 0
                               db 'direkt. Detaljerad', 0
                               db 'visar mer information.', 0
                               db 0
TXT_SETUPHELP_PartAutoDetect   db 'Om AiR-BOOT hittar nya', 0
                               db 'partitioner, kommer', 0
                               db 'den att g�ra dom', 0
                               db 'bootningsbara.', 0
                               db 0
TXT_SETUPHELP_PasswordedSetup  db 'N�r du kommer till den', 0
                               db 'h�r setupen, kommer du', 0
                               db 'att bli tillfr�gad om', 0
                               db 'ett l�senord.', 0
                               db 0
TXT_SETUPHELP_PasswordedSystem db 'N�r du bootar din', 0
                               db 'dator, kommer du att', 0
                               db 'bli tillfr�gad om det.', 0
                               db 0
TXT_SETUPHELP_PasswordedBoot   db 'N�r Tidstyrd Bootning', 0
                               db 'inte anv�nds kommer du', 0
                               db 'att bli tillfr�gad.', 0
                               db 0
TXT_SETUPHELP_GetFloppyName    db 'N�r du visar diskett', 0
                               db 'i boot-menyn, kommer', 0
                               db 'AiR-BOOT att h�mta', 0
                               db 'diskettnamnet.', 0
                               db 0
TXT_SETUPHELP_GetFloppyName2Sec db 'Som till�gg kommer', 0
                               db 'den att uppdatera', 0
                               db 'diskettnamnet', 0
                               db 'varannan sekund.', 0
                               db 0
TXT_SETUPHELP_VirusDetect      db 'Kommer att uppt�cka', 0
                               db 'normala virus (enkla).', 0
                               db 0
TXT_SETUPHELP_StealthDetect    db 'Kommer att uppt�cka', 0
                               db 'Stealth virus.', 0
                               db 0
TXT_SETUPHELP_VIBRdetect       db 'Kommer att uppt�cka', 0
                               db 'VIBR. VIBR st�r f�r', 0
                               db 'Virus-In-Boot-Record.', 0
                               db 0
TXT_SETUPHELP_ContinueBIOSboot db 'Om aktiverad, kommer', 0
                               db 'den h�r optionen att', 0
                               db 'returnera kontrollen', 0
                               db 'till BIOS f�r det.', 0
                               db 'spec. devicet.', 0
                               db 0

; Extended Options - Help
;----------------------------------|--------------------|-------------------
; [Linux support removed since v1.02]
;TXT_SETUPHELP_LinuxKernelPart  db 'Definierar FAT-16', 0
;                               db 'partition som', 0
;                               db 'inneh�ller dina', 0
;                               db 'Linux k�rnor.', 0
;                               db 0
;TXT_SETUPHELP_LinuxDefaultKrnl db 'Definiera din', 0
;                               db 'standardk�rnas', 0
;                               db 'filnamn.', 0
;                               db 0
;TXT_SETUPHELP_LinuxRootPart    db '�ndrar din Linux', 0
;                               db 'root partition.', 0
;                               db 0
;TXT_SETUPHELP_DefLinuxCmd:     db 'Definierar kommando', 0
;                               db 'rad f�r Linux, om', 0
;                               db 'tillg�ngligt.', 0
;                               db 0
TXT_SETUPHELP_IgnoreLVM        db 'If activated, AiR-BOOT', 0
                               db 'won''t even look for', 0
                               db 'LVM information.', 0
                               db 0
; ###
;~ TXT_SETUPHELP_ForceLBAUsage    db 'Forc. anv�ndning av', 0
                               ;~ db 'BIOS LBA APIs', 0
                               ;~ db 'ist�llet f�r mixad anv.', 0
                               ;~ db 'av CHS och LBA.', 0
                               ;~ db 0
TXT_SETUPHELP_ExtPartMShack    db 'Aktiverar dyn. �ndring', 0
                               db 'av den ut�kade part.,', 0
                               db 'skriv id f�r standard', 0
                               db 'eller MS-uppfinnade.', 0
                               db '(definierad av P-flag)', 0
                               db 0

; Maximum 26 chars (should not be reached)
;----------------------------------|------------------------|---------------
TXT_SETUPHELP_Base             db ' HJ�LP ', 0
TXT_SETUPHELP_Enter            db '<ENTER>', 0

; Maximum 60 chars (should not be reached)
;----------------------------------|----------------------------------------------------------|
TXT_SETUP_PasswordOld          db 'Gammalt L�senord:', 0
TXT_SETUP_PasswordDefine       db 'Definiera L�senord:', 0
TXT_SETUP_PasswordVerify       db 'Verifiera L�senord:', 0
TXT_SETUP_PasswordIncorrect    db 'Gammalt L�senord Inte Korrekt, Ledsen', 0
TXT_SETUP_PasswordMismatch     db 'Matchar Inte, Gammalt L�senord Beh�lls', 0
TXT_SETUP_PasswordDisabled     db 'Inget L�senord -> Skydd Avaktiverat', 0
TXT_SETUP_PasswordMatched      db '** Matchar, Nytt L�senord Satt **', 0

; Maximum 60 chars (should not be reached anyway)
;----------------------------------|----------------------------------------------------------|
TXT_SETUP_SaveAndExitNow       db 'SPARA & AVSLUTA NU', 0
TXT_SETUP_QuitWithoutSaveNow   db 'AVSLUTA UTAN ATT SPARA', 0
; Must be shorter than SaveAndExitNow / QuitWithoutSaveNow
;----------------------------------|----------------------------------------------------------|
TXT_SETUP_AreYouSure1          db '�R DU S�KER?', 0
TXT_SETUP_AreYouSure2          db '(J/N)', 0

; Maximum 60 chars (should not be reached)
;----------------------------------|----------------------------------------------------------|
; [Linux support removed since v1.02]
;TXT_SETUP_EnterLinuxCmdLine    db 'Var v�nlig ange/modifiera din Linux kommando-rad:', 0
;TXT_SETUP_NoLinuxInstalled     db 'Du har inte Linux installerat', 0
TXT_SETUP_NoLDLpartition       db 'Den valda partitionen �r inte varken HPFS/FAT16/JFS', 0

; Maximum 34 chars (should not be reached)
;----------------------------------|--------------------------------|-------
TXT_SETUP_HideFeature          db 'D�lj Funktion', 0
;----------------------------------|---------------------|------------------
TXT_SETUP_HideFeature2         db 'Status vid bootning ', 0

; Drive-Letter Menu Header - Max Length: 19 chars
;----------------------------------|-----------------|----------------------
TXT_SETUP_DriveLetter          db 'Partition Bokstav', 0

; Drive-Letter Keys - Max Length: 19 chars
;----------------------------------|-----------------|----------------------
TXT_SETUPHELP_DriveLetter      db 'Tryck C-Z', 0

; Colors for special words hard-coded. Keep all 0s.
;TXT_SETUP_LowerMessage         db 'Detta program �r ',0,'fritt',0,' f�r icke-kommersiell privat anv�ndning.',0
;                               db 'Du f�r ',0,'INTE',0,' distribuera/anv�nda AiR-BOOT i ',0,'-N�GON-',0,' form,',0
;                               db 'om du erh�ller pengar f�r den distribuerade produkten eller servicen.',0
;                               db 'Om du vill anv�nda AiR-BOOT i ',0,'andra sammanhang',0,', ',0,'f�rinstallera',0,' eller',0
;                               db 'distribuera',0,' den, var v�nlig och kontakta mig via e-mail: ',0,'kiewitz@netlabs.org',0,' !',0
