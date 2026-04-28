include $(GNUSTEP_MAKEFILES)/common.make

PACKAGE_NAME = Mixer
VERSION = 0.7
APP_NAME = Mixer
Mixer_MAIN_MODEL_FILE = Mixer.gorm
Mixer_APPLICATION_ICON = Mixer.tiff

Mixer_OBJC_FILES = \
main.m \
AppController.m

Mixer_RESOURCE_FILES = \
Mixer.gorm \
Mixer.tiff 

# GNUSTEP_TARGET_OS is defined to `linux-gnueabi' on armel and
# `linux-gnuspep' on powerpcspe.
ifneq (,$(findstring linux-gnu,$(GNUSTEP_TARGET_OS)))
ADDITIONAL_GUI_LIBS = -lasound
endif

include $(GNUSTEP_MAKEFILES)/application.make

