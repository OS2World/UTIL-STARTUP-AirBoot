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
;                                                          AiR-BOOT / DEBUG
;---------------------------------------------------------------------------


; -----------------------
; Rousseau: # DEBUG.ASM #
; -----------------------
; This module contains functions for debugging AiR-BOOT.
; It is only included in debug builds and the codesize of AiR-BOOT increases
; in that case. To compensate for that, the FX code is disabled when debugging
; is active. Also, most of the debug-routines can selectively be disabled
; by commenting-out the define above it.



IFDEF   MODULE_NAMES
DB 'DEBUG',0
ENDIF

;
; Display a number that was put on the stack.
; Used to track code-flow.
;
dbp     db  '>---------->> DebugProbe: ',0
DEBUG_Probe     Proc
        push    bp
        mov     bp,sp
        pushf
        pusha

        mov     si,offset [dbp]         ; Default probe-text.
        call    AuxIO_Print
        mov     ax,[bp+04]              ; Get probe-number from stack.
        call    AuxIO_TeletypeHexWord
        call    AuxIO_TeletypeNL

        ; Also display registers.
        popa
        pusha
        call    DEBUG_DumpRegisters

        popa
        popf
        pop     bp
        ret     2
DEBUG_Probe     Endp



;
; Show help on keys.
;
dbh     db  10,'h=HELP, d=DRIVE-LETTERS, g=GEO, i=IPT, r=RESTART, v=VOL-LETTERS, x=XREF',10,10,0
DEBUG_ShowHelp      Proc
        pushf
        pusha
        mov     si, offset dbh
        call    AuxIO_Print
        popa
        popf
        ret
DEBUG_ShowHelp      EndP


;
; Call list for debug hot-keys.
;
dbg_call_list:
        db      'd'
        dw      offset  DEBUG_DumpDriveLetters
        db      'g'
        dw      offset  DEBUG_DumpGeo
        db      'h'
        dw      offset  DEBUG_ShowHelp
        db      'i'
        dw      offset  DEBUG_DumpIPT
        db      'r'
        dw      offset  AirbootRestart
        db      'v'
        dw      offset  DEBUG_DumpVolumeLetters
        db      'x'
        dw      offset  DEBUG_DumpPartitionXref
        db      'R'
        dw      offset  AirbootRestart
        db      0

;
; Handle keypresses when the main menu is active.
;
DEBUG_HandleKeypress    Proc
        pushf
        pusha

        ; Save hot-key
        mov     dl,al

        ; Check for digit.
        cmp     al,'0'
        jb      DEBUG_HandleKeypress_exit
        cmp     al,'9'
        ja      DEBUG_HandleKeypress_try_alpha
        ; It was a digit.
        jmp     DEBUG_HandleKeypress_check_it

        ; Check for alpha.
    DEBUG_HandleKeypress_try_alpha:
        ; Force upper-case.
        and     al,11011111b
        cmp     al,'A'
        jb      DEBUG_HandleKeypress_exit
        cmp     al,'Z'
        ja      DEBUG_HandleKeypress_exit
        ; It was an alpha.
        jmp     DEBUG_HandleKeypress_check_it


        ; Check if the key is a hot-key.
    DEBUG_HandleKeypress_check_it:
        cld
        mov     si,offset dbg_call_list

        ; Loop over jump-list.
    DEBUG_HandleKeypress_next_entry:

        ; Load the hot-key.
        lodsb
        ; No hot-key (not implemented) if end-of-list.
        test    al,al
        jz      DEBUG_HandleKeypress_ni

        ; Compare hot-key and iterate if not the same.
        cmp     dl,al
        lodsw
        jne     DEBUG_HandleKeypress_next_entry

        ; Entry found, call corresponding routine.
        mov     bx,ax
        call    bx

        ; Done.
        jmp     DEBUG_HandleKeypress_exit

        ; Call not-assigned routine.
    DEBUG_HandleKeypress_ni:
        call    DEBUG_NotAssigned
        jmp     DEBUG_HandleKeypress_exit

        ; Return to caller.
    DEBUG_HandleKeypress_exit:
        popa
        popf
        ret
DEBUG_HandleKeypress    Endp



;
; Show not assigned message.
;
dbg_na  db  'This key is not assigned, press ''h'' for Help.',10,0
DEBUG_NotAssigned       Proc
        pushf
        pusha
        mov     si,offset dbg_na
        call    AuxIO_Print
        popa
        popf
        ret
DEBUG_NotAssigned       Endp



;
; Dump information before the menu is displayed.
;
DEBUG_Dump1     Proc  Near
        pushf
        pusha

        ; Hello message
        mov     si, offset AuxIOHello
        call    AuxIO_Print

        ; Build Info
        ;~ mov     si, offset BUILD_DATE
        ;~ call    AuxIO_Print
        call    AuxIO_PrintBuildInfo

        ; Start new line
        call    AuxIO_TeletypeNL
        ;~ call    AuxIO_TeletypeNL

        ;~ call    DEBUG_DumpHidePartTables
        ;~ call    DEBUG_CheckMath
        ;~ call    DEBUG_DumpGeo
        ;~ call    DEBUG_CheckBitFields

        popa
        popf
        ret
DEBUG_Dump1     EndP


;
; Check the simple 32-bit math functions.
;
;~ __CHECK_MATH__  EQU
DEBUG_CheckMath Proc    Near
    IFDEF   __CHECK_MATH__
        pushf
        pusha

        ; Msg check math-module
        mov     si,offset db_checkmath
        call    AuxIO_Print

        ; Output hex-word
        mov     ax,0BABEh
        call    AuxIO_TeletypeHexWord

        mov     al,' '
        call    AuxIO_Teletype
        mov     al,'*'
        call    AuxIO_Teletype
        mov     al,' '
        call    AuxIO_Teletype

        ; Output hex-word
        mov     ax,0BABEh
        call    AuxIO_TeletypeHexWord

        mov     al,' '
        call    AuxIO_Teletype
        mov     al,'='
        call    AuxIO_Teletype
        mov     al,' '
        call    AuxIO_Teletype

        mov     ax,0BABEh
        mul     ax
        call    AuxIO_TeletypeHexDWord

        ; Start new line
        call    AuxIO_TeletypeNL

        ; Output hex-dword
        mov     dx,0DEADh
        mov     ax,0FACEh
        call    AuxIO_TeletypeHexDWord

        mov     al,' '
        call    AuxIO_Teletype
        mov     al,'*'
        call    AuxIO_Teletype
        mov     al,' '
        call     AuxIO_Teletype

        ; Output hex-dword
        mov     dx,0DEADh
        mov     ax,0FACEh
        call    AuxIO_TeletypeHexDWord

        mov     al,' '
        call    AuxIO_Teletype
        mov     al,'='
        call    AuxIO_Teletype
        mov     al,' '
        call    AuxIO_Teletype

        mov     bx,0DEADh
        mov     cx,0FACEh
        mov     dx,0DEADh
        mov     ax,0FACEh
        call    MATH_Mul32
        call    AuxIO_TeletypeHexQWord

        call    AuxIO_TeletypeNL
        call    AuxIO_TeletypeNL

        popa
        popf
    ENDIF
        ret
DEBUG_CheckMath EndP


;
; Dump the geometry.
;
__DUMP_GEO__    EQU
DEBUG_DumpGeo   Proc
    IFDEF   __DUMP_GEO__
        pushf
        pusha

        ; BIOS cyls
        mov     dx,word ptr [BIOS_Cyls+02]
        mov     ax,word ptr [BIOS_Cyls+00]
        call    AuxIO_TeletypeHexDWord
        call    AuxIO_TeletypeNL

        ; BIOS heads
        mov     dx,word ptr [BIOS_Heads+02]
        mov     ax,word ptr [BIOS_Heads+00]
        call    AuxIO_TeletypeHexDWord
        call    AuxIO_TeletypeNL

        ; BIOS secs
        mov     dx,word ptr [BIOS_Secs+02]
        mov     ax,word ptr [BIOS_Secs+00]
        call    AuxIO_TeletypeHexDWord
        call    AuxIO_TeletypeNL

        ; Bytes per sector
        mov     ax,[BIOS_Bytes]
        call    AuxIO_TeletypeHexWord
        call    AuxIO_TeletypeNL

        ; Total secs
        mov     bx, word ptr [BIOS_TotalSecs+06]
        mov     cx, word ptr [BIOS_TotalSecs+04]
        mov     dx, word ptr [BIOS_TotalSecs+02]
        mov     ax, word ptr [BIOS_TotalSecs+00]
        call    AuxIO_TeletypeHexDWord
        call    AuxIO_TeletypeNL

        ; CHS to LBA
        mov     dx,1
        mov     ax,29e5h
        mov     bx,23h
        mov     cx,9h
        call    CONV_CHS2LBA
        call     AuxIO_TeletypeHexDWord
        call     AuxIO_TeletypeNL

        popa
        popf
    ENDIF

        ret
DEBUG_DumpGeo   Endp


;
; Dump the internal partition table.
;
__DUMP_IPT__    EQU
DEBUG_DumpIPT   Proc
    IFDEF   __DUMP_IPT__
        pushf
        pusha

        call    AuxIO_TeletypeNL

        mov     si,offset [BIOScontIPTentry]
        ;~ mov     si,offset [PartitionTable]
        call    AuxIO_DumpSector

        popa
        popf
    ENDIF
        ret
DEBUG_DumpIPT   EndP


;
; Dump the new  partitions table.
;
;~ __DUMP_NPT__    EQU
DEBUG_DumpNewPartTable  Proc
    IFDEF   __DUMP_NPT__
        pushf
        pusha

        call    AuxIO_TeletypeNL

        mov     si,offset [NewPartTable]
        call    AuxIO_DumpSector

        popa
        popf
    ENDIF
        ret
DEBUG_DumpNewPartTable  EndP


;
; Dump the partition pointers table.
;
;~ __DUMP_PP__     EQU
DEBUG_DumpPartitionPointers     Proc
    IFDEF   __DUMP_PP__
        pushf
        pusha

        call    AuxIO_TeletypeNL

        mov     si,offset [PartitionPointers]
        mov     cx,7

    DEBUG_DumpPartitionPointers_next:
        call    AuxIO_DumpParagraph
        add     si,16
        call    AuxIO_TeletypeNL
        loop    DEBUG_DumpPartitionPointers_next

        popa
        popf
    ENDIF
        ret
DEBUG_DumpPartitionPointers     EndP


;
; Dump the partition x-ref table.
;
__DUMP_PX__     EQU
DEBUG_DumpPartitionXref     Proc
    IFDEF   __DUMP_PX__
        pushf
        pusha

        mov     si, offset [xrt]
        call    AuxIO_Print
        ;~ call    AuxIO_TeletypeNL

        mov     si,offset [PartitionXref]
        mov     cx,3

    DEBUG_DumpPartitionXref_next:
        call    AuxIO_DumpParagraph
        add     si,16
        call    AuxIO_TeletypeNL
        loop    DEBUG_DumpPartitionXref_next

        popa
        popf
    ENDIF
        ret
DEBUG_DumpPartitionXref     EndP


;
; Dump the dl-feature drive-letters.
;
__DUMP_DL__     EQU
DEBUG_DumpDriveLetters      Proc
    IFDEF   __DUMP_DL__
        pushf
        pusha

        mov     si, offset [ddl]
        call    AuxIO_Print

        ; Dump the old drive-letters as set with the dl-feature.
        mov     si,offset [DriveLetters]
        mov     cx,3
    DEBUG_DumpDriveLetters_next_1:
        call    AuxIO_DumpParagraph
        add     si,16
        call    AuxIO_TeletypeNL
        loop    DEBUG_DumpDriveLetters_next_1

        ; Dump the new drive-letters as composed when scanning partitions
        ; and partitions were added or removed.
        mov     si,offset [NewDriveLetters]
        mov     cx,3
    DEBUG_DumpDriveLetters_next_2:
        call    AuxIO_DumpParagraph
        add     si,16
        call    AuxIO_TeletypeNL
        loop    DEBUG_DumpDriveLetters_next_2

        popa
        popf
    ENDIF
        ret
DEBUG_DumpDriveLetters      EndP


;
; Dump the lvm volume drive-letters.
;
__DUMP_VL__     EQU
DEBUG_DumpVolumeLetters     Proc
    IFDEF   __DUMP_VL__
        pushf
        pusha

        mov     si, offset [dvl]
        call    AuxIO_Print

        mov     si,offset [PartitionVolumeLetters]
        mov     cx,3

    DEBUG_DumpVolumeLetters_next:
        call    AuxIO_DumpParagraph
        add     si,16
        call    AuxIO_TeletypeNL
        loop    DEBUG_DumpVolumeLetters_next

        popa
        popf
    ENDIF
        ret
DEBUG_DumpVolumeLetters     EndP




;
; Dump the registers.
;
__DUMP_REG__    EQU
IFDEF   __DUMP_REG__
regAX   db  'AX:',0
regBX   db  ' BX:',0
regCX   db  ' CX:',0
regDX   db  ' DX:',0
regSI   db  ' SI:',0
regDI   db  ' DI:',0

regBP   db  'CS:',0
regSP   db  ' DS:',0
regCS   db  ' ES:',0
regSS   db  ' SS:',0
regDS   db  ' SP:',0
regES   db  ' BP:',0

;~ regFS   db  'FS:',0
;~ regGS   db  ' GS:',0
ENDIF
DEBUG_DumpRegisters     Proc
    IFDEF   __DUMP_REG__
        pushf
        pusha

        push    si
        mov     si, offset regAX
        call    AuxIO_Print
        call    AuxIO_TeletypeHexWord
        ;~ call    AuxIO_TeletypeNL

        call    AuxIO_Print
        mov     ax,bx
        call    AuxIO_TeletypeHexWord
        ;~ call    AuxIO_TeletypeNL

        call    AuxIO_Print
        mov     ax,cx
        call    AuxIO_TeletypeHexWord
        ;~ call    AuxIO_TeletypeNL

        call    AuxIO_Print
        mov     ax,dx
        call    AuxIO_TeletypeHexWord
        ;~ call    AuxIO_TeletypeNL

        call    AuxIO_Print
        pop     ax
        call    AuxIO_TeletypeHexWord
        ;~ call    AuxIO_TeletypeNL

        call    AuxIO_Print
        mov     ax,di
        call    AuxIO_TeletypeHexWord
        call    AuxIO_TeletypeNL



        call    AuxIO_Print
        mov     ax,cs
        call    AuxIO_TeletypeHexWord
        ;~ call    AuxIO_TeletypeNL

        call    AuxIO_Print
        mov     ax,ds
        call    AuxIO_TeletypeHexWord
        ;~ call    AuxIO_TeletypeNL

        call    AuxIO_Print
        mov     ax,es
        call    AuxIO_TeletypeHexWord
        ;~ call    AuxIO_TeletypeNL

        call    AuxIO_Print
        mov     ax,ss
        call    AuxIO_TeletypeHexWord
        ;~ call    AuxIO_TeletypeNL

        call    AuxIO_Print
        mov     ax,sp
        call    AuxIO_TeletypeHexWord
        ;~ call    AuxIO_TeletypeNL

        call    AuxIO_Print
        mov     ax,bp
        call    AuxIO_TeletypeHexWord
        call    AuxIO_TeletypeNL

        ;~ call    AuxIO_Print
        ;~ mov     ax,fs
        ;~ call    AuxIO_TeletypeHexWord
        ;~ call    AuxIO_TeletypeNL

        ;~ call    AuxIO_Print
        ;~ mov     ax,gs
        ;~ call    AuxIO_TeletypeHexWord
        ;~ call    AuxIO_TeletypeNL

        call    AuxIO_TeletypeNL

        popa
        popf
    ENDIF
        ret
DEBUG_DumpRegisters     EndP


;
; Dump CHS values.
;
__DUMP_CHS__    EQU
DEBUG_DumpCHS   Proc    Near
    IFDEF   __DUMP_CHS__
        pushf
        pusha
        mov     al,'C'
        call    AuxIO_Teletype
        mov     al,':'
        call    AuxIO_Teletype
        mov     ah,cl
        shr     ah,6
        mov     al,ch
        call    AuxIO_TeletypeHexWord
        mov     al,' '
        call    AuxIO_Teletype
        mov     al,'H'
        call    AuxIO_Teletype
        mov     al,':'
        call    AuxIO_Teletype
        mov     al,dh
        call    AuxIO_TeletypeHexByte
        mov     al,' '
        call    AuxIO_Teletype
        mov     al,'S'
        call    AuxIO_Teletype
        mov     al,':'
        call    AuxIO_Teletype
        mov     al,cl
        and     al,00111111b
        call    AuxIO_TeletypeHexByte
        call    AuxIO_TeletypeNL
        popa
        popf
    ENDIF
        ret
DEBUG_DumpCHS   EndP


;
; Dump BSS.
;
;~ __DUMP_BSS__    EQU
DEBUG_DumpBSSSectors    Proc    Near
    IFDEF   __DUMP_BSS__
        pushf
        pusha

        mov     si, offset [PartitionSector]
        call    AuxIO_DumpSector
        call    AuxIO_TeletypeNL

        mov     si, offset [PBRSector]
        call    AuxIO_DumpSector
        call    AuxIO_TeletypeNL

        mov     si, offset [LVMSector]
        call    AuxIO_DumpSector
        call    AuxIO_TeletypeNL

        mov     si, offset [TmpSector]
        call    AuxIO_DumpSector
        call    AuxIO_TeletypeNL

        mov     si, offset [NewPartTable]
        call    AuxIO_DumpSector
        call    AuxIO_TeletypeNL
        call    AuxIO_TeletypeNL

        popa
        popf
    ENDIF
        ret
DEBUG_DumpBSSSectors    EndP


;
; Dump 6-bit packed hide partition table.
;
;~ __DUMP_HPT__    EQU
DEBUG_DumpHidePartTables    Proc    Near
    IFDEF   __DUMP_HPT__
        pushf
        pusha

        mov     cx,3
        mov     si, offset [HidePartitionTable]
    again1:
        call    AuxIO_DumpSector
        add     si,512
        loop    again1
        call    AuxIO_TeletypeNL

        mov     cx,3
        mov     si, offset [PartitionXref]
    again2:
        call    AuxIO_DumpParagraph
        call    AuxIO_TeletypeNL
        add     si,16
        loop    again2
        call    AuxIO_TeletypeNL

        mov     cx,3
        mov     si, offset [NewHidePartTable]
    again3:
        call    AuxIO_DumpSector
        add     si,512
        loop    again3
        call    AuxIO_TeletypeNL

        popa
        popf
    ENDIF
        ret
DEBUG_DumpHidePartTables    EndP


;
; Check the bitfield routines.
;
;~ __CBF__     EQU
DEBUG_CheckBitFields    Proc
    IFDEF   __CBF__
        pushf
        pusha

        mov     bx,offset [ott]

        mov     al,0
        mov     dl,0
        mov     dh,6
    DEBUG_CheckBitFields_next_write:
        call    CONV_SetBitfieldValue
        inc     al
        inc     dl
        jnz     DEBUG_CheckBitFields_next_write

        mov     dl,0
        mov     dh,6
    DEBUG_CheckBitFields_next_read:
        mov     al,dl
        call    AuxIO_TeletypeHexByte
        mov     al,':'
        call    AuxIO_Teletype
        call    CONV_GetBitfieldValue
        call    AuxIO_TeletypeHexWord
        call    AuxIO_TeletypeNL
        inc     dl
        jnz     DEBUG_CheckBitFields_next_read

        popa
        popf
    ENDIF
        ret
DEBUG_CheckBitFields    EndP




;
; Dump information before the partition is booted.
;
;~ __DMP2__    EQU
DEBUG_Dump2     Proc  Near
    IFDEF   __DMP2__
        pushf
        pusha

        call    AuxIO_TeletypeNL
        call    AuxIO_TeletypeNL

        mov     si,offset db_config
        call    AuxIO_Print

        mov     si,offset db_cfgparts
        call    AuxIO_Print
        mov     al,[CFG_Partitions]
        call    AuxIO_TeletypeHexByte
        call    AuxIO_TeletypeNL

        mov     si,offset db_cfgpartdef
        call    AuxIO_Print
        mov     al,[CFG_PartDefault]
        call    AuxIO_TeletypeHexByte
        call    AuxIO_TeletypeNL

        mov     si,offset db_cfgpartlast
        call    AuxIO_Print
        mov     al,[CFG_PartLast]
        call    AuxIO_TeletypeHexByte
        call    AuxIO_TeletypeNL
        call    AuxIO_TeletypeNL

        mov     si,offset db_vars
        call    AuxIO_Print

        mov     si,offset db_newpart
        call    AuxIO_Print
        mov     si,offset NewPartTable
        call    AuxIO_DumpSector
        call    AuxIO_TeletypeNL
        add     si,512
        call    AuxIO_DumpSector
        call    AuxIO_TeletypeNL
        call    AuxIO_TeletypeNL

        mov     si,offset db_newhide
        call    AuxIO_Print
        mov     si,offset NewHidePartTable
        call    AuxIO_DumpSector
        call    AuxIO_TeletypeNL
        add     si,512
        call    AuxIO_DumpSector
        call    AuxIO_TeletypeNL
        call    AuxIO_TeletypeNL

        mov     si,offset db_dletters
        call    AuxIO_Print
        mov     si,offset NewDriveLetters
        call    AuxIO_DumpParagraph
        call    AuxIO_TeletypeNL
        add     si,16
        call    AuxIO_DumpParagraph
        call    AuxIO_TeletypeNL
        call    AuxIO_TeletypeNL

        mov     si,offset db_tmpec
        call    AuxIO_Print
        mov     si,offset TmpSector
        call    AuxIO_DumpSector
        call    AuxIO_TeletypeNL
        call    AuxIO_TeletypeNL

        mov     si,offset db_partsec
        call    AuxIO_Print
        mov     si,offset PartitionSector
        call    AuxIO_DumpSector
        call    AuxIO_TeletypeNL
        call    AuxIO_TeletypeNL

        popa
        popf
    ENDIF
        ret
DEBUG_Dump2     EndP



xrt     db  10,'XrefTable:',10,0
ddl     db  10,'Driveletters:',10,0
dvl     db  10,'VolumeLetters:',10,0
dlra    db  10,'LVM_DoLetterReassignment: ',0
ptetb   db  10,'Partition Table Entry to boot',10,0
bios_reg    db  10,'Registers passed by BIOS:',10,0
;~ diopmbr db  10,'DriveIO_ProtectMBR',10,0
dioss   db  10,'DriveIO_SaveSector',10,0


;~ db_mbr              db "## MBR ##",10,0
;~ db_masterlvm        db "## MLVMR ##",10,0

;~ db_checkmath        db "## CHK MATH ##",10,0


;~ db_config           db '## CFG (DMP2) ##',10,0
;~ db_cfgparts         db 'CFG_Partitions:',0
;~ db_cfgpartdef       db 'CFG_PartDefault:',0
;~ db_cfgpartlast      db 'CFG_PartLast:',0


;~ db_vars             db '## VARS ##',10,0
;~ db_partsec          db 'PartitionSector:',10,0
;~ db_lvmsec           db 'LVMSector :',10,0
;~ db_tmpec            db 'TmpSector :',10,0

;~ db_newpart          db 'NewPartTable :',10,0
;~ db_newhide          db 'NewHideTable:',10,0
;~ db_dletters         db 'NewDriveLetters:',10,0

;~ db_partsize         db 'PartitionSizeTable:',10,0
;~ db_partpoint        db 'PartitionPointers:',10,0
;~ db_partpointcnt     db 'PartitionPointerCount:',0
;~ db_partxref         db 'PartitionXref:',10,0
;~ db_partvoldl        db 'PartitionVolumeLetters:',10,0

;~ db_totaldisks       db 'TotalHarddiscs:',0
;~ db_lbaswitchtab     db 'LBASwitchTable:',10,0
;~ db_newparts         db 'NewPartitions:',0

;~ db_exabspos         db 'ExtendedAbsPos:',0
;~ db_exabsposset      db 'ExtendedAbsPosSet:',0

;~ db_curpartloc       db 'CurPartition_Location:',0
;~ db_curiox           db 'CurIO_UseExtension:',0

;~ db_curlvmsec        db 'Current LVM Sector:',0


;~ drive                   db 'drive                    : ',0
;~ before_lvm_adjust       db 'before lvm adjust        : ',0
;~ after_lvm_adjust        db 'after lvm adjust         : ',0
;~ before_lvm_adjust_log   db 'before lvm logical adjust: ',0
;~ after_lvm_adjust_log    db 'after lvm logical adjust : ',0
;~ spt_used                db 'spt used                 : ',0
