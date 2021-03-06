###############################################################################
# Makefile :: Builds complete AiR-BOOT; all supported Languages and Platforms #
###############################################################################
# rousseau@ecomstation.com
#

# This is the Master Makefile and it builds the whole AiR-BOOT she-bang:
# - The AiR-BOOT Loader Code for all supported languages.
# - The MBR Protection Image that get's embedded in the loader.
# - The FIXCODE program that embeds the MBR Protection Image.
# - The Installers for all supported platforms.
# - The SET(A)BOOT program for all supported platforms. (currently only OS/2)


# Note:
# AiR-BOOT and it's helpers are relatively small to build.
# So, although Makefiles are being used to build the lot, there is no explicit
# separation between assembling/compiling from source or just only linking.
# In fact, because of multiple languages for the Loader and cross-platform
# support for the Helpers, any target will almost always be built from source
# everytime.

# Also:
# While WMake does it's job, running it on Linux requires a bit of extra effort
# with regard to case sensitivity, directory separators, escape characters
# and other platform differences.
# This is handled in MAKEFILE.MIF.



# 							DEFINITIONS AND STUFF
# _____________________________________________________________________________

# This one is defined in the Environment so that all 'called' WMake invocations
# can adjust their behavior when they are invoked from this Master.
# When invoked from this Master, it is assumed the user/developer
# 'just-wants-to-have-all-the-stuff-built', so some messages are suppressed and
# some stuff is overridden.
# Building from this Master is how AiR-BOOT is built when released.
# It will force JWasm as the assembler and force DEBUG_LEVEL to 0.
# Also, targets are distributed to the RELEASE directory.
# Usage of lower level Makefiles directly is considered 'development'.
%MASTER=TRUE

# Include a Master Makefile with several cross-platform definitions and macros.
# This is used to compensate for the differences between the target platforms.
!include	INCLUDE/MAKEFILE.MIF


# These are the Build Directories (Components) that produce
# one or more targets. WMake is invoked from this Master Makefile in each of
# this directories to produce the corresponding component.
# Note that the %MASTER Environment variable above is passed
# to influence build behavior of the individual Makefiles.
# The order of these Build Directories matters !
#
# - MBR-PROT		; MBR Protection Image later to be embedded.
# - INTERNAL		; FIXBOOT program to embed the Protection Image.
# - BOOTCODE		; AiR-BOOT Boot Manager itself.
# - INSTALL/C		; Installer for multiple platforms.
# - INSTALL/DOS		; Old DOS installer -- will be removed when converted to C.
# - SETABOOT		; SETABOOT Manager for OS/2 -- other platforms not yet.
#
COMPONENTS=&
	BOOTCODE$(DS)MBR-PROT&
	TOOLS$(DS)INTERNAL&
	BOOTCODE&
	INSTALL$(DS)C&
	INSTALL$(DS)DOS&
	TOOLS$(DS)OS2$(DS)SETABOOT&




# 								MAIN ACTIONS
# _____________________________________________________________________________


# -----------------------------------------------------------------------------
# MAIN :-)
# -----------------------------------------------------------------------------
# Unless another target is specified, a 'build' is the default action.
# Using wmake build would be equivalent.
# -----------------------------------------------------------------------------
all:	.SYMBOLIC Makefile.bu
	@%MAKE build



# -----------------------------------------------------------------------------
# BUILD EVERYTHING
# -----------------------------------------------------------------------------
# Here we iterate over all AiR-BOOT components that have a Makefile.
# To be able to influence the 'action' we pass that using the Environment.
# In this case we are 'building'.
# Note that we don't use %ACTION=, because that would be evaluated by WMake
# when parsing the Makefile. It needs to be a command related to the target.
# -----------------------------------------------------------------------------
build:	.SYMBOLIC
	@SET ACTION=BUILD
	@for %%i in ($(COMPONENTS)) do @$(MAKE) -h %%i
	@echo.
	@echo ** Success !! **
	@echo All AiR-BOOT stuff has been built.
	@echo Look in the RELEASE directory for the distribution files
	@echo for each platform.
	@echo The PACKAGES directory contains packages for each supported
	@echo platform.
	@echo.


# -----------------------------------------------------------------------------
# CLEANUP EVERYTHING
# -----------------------------------------------------------------------------
# Here we iterate over all AiR-BOOT components that have a Makefile.
# To be able to influence the 'action' we pass that using the Environment.
# In this case we are 'cleaning'.
# Note that we don't use %ACTION=, because that would be evaluated by WMake
# when parsing the Makefile. It needs to be a command related to the target.
# -----------------------------------------------------------------------------
clean:	.SYMBOLIC
	@SET ACTION=CLEAN
	@for %%i in ($(COMPONENTS)) do @$(MAKE) -h %%i
	@echo.
	@echo Done.
	@echo.


# -----------------------------------------------------------------------------
# SHOW HELP ON USING THIS MAKEFILE
# -----------------------------------------------------------------------------
help:	.SYMBOLIC
	@echo.
	@echo		The following actions are available:
	@echo		wmake 		to build all targets and all languages
	@echo		wmake dev	to build a develoopment target
	@echo		wmake [LANG]	to build EN,DE,NL,FR,IT or RU versions
	@echo		wmake list	to show the list of buildable targets
	@echo		wmake clean 	to remove almost all generated files
	@echo		wmake rmbin 	to remove all residual BIN files
	@echo		wmake rebuild	to rebuild all targets
	@echo		wmake dist	to populate the dist directories
	@echo		wmake help 	for this information
	@echo.







# -----------------------------------------------------------------------------
# CHECK FOR MAKEFILE CHANGES
# -----------------------------------------------------------------------------
# Create a backup of the Makefile when it is modified.
# This also forces a rebuild of all targets.
# -----------------------------------------------------------------------------
Makefile.bu:	Makefile
	@echo.
	@echo Makefile modified, forcing rebuild of all targets !
	@echo.
	@%MAKE clean
	@$(CP) Makefile Makefile.bu > $(NULDEV)



# 								GENERIC HANDLERS
# _____________________________________________________________________________


# -----------------------------------------------------------------------------
# ACTION HANDLER FOR BUILD DIRECTORIES
# -----------------------------------------------------------------------------
# This is the generic handler.
# The action to undertake is set in the Environment.
# It functions like a "switch".
# -----------------------------------------------------------------------------
$(COMPONENTS):	.SYMBOLIC
	@echo.
	@echo.
	@echo.
!if "$(%ACTION)"=="BUILD"
	@echo @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	@echo @@ BUILDING $@
	@echo @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	@echo.
	@cd $@
	@$(MAKE) -h
!elseif "$(%ACTION)"=="CLEAN"
	@echo @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	@echo @@ CLEANING $@
	@echo @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	@echo.
	@cd $@
	@$(MAKE) -h clean
!else
	@echo.
	@echo !! Undefined Action !!
	@echo.
!endif


