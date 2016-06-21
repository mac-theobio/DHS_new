# DHS_new
### Hooks for the editor to set the default target
current: target

target pngtarget pdftarget vtarget acrtarget: bigtest.Rout 

##################################################################

# make files

Sources = Makefile .gitignore README.md stuff.mk LICENSE.md
include stuff.mk
# include $(ms)/perl.def

##################################################################

## Content

Sources += $(wildcard *.R)

damico.R:

test.Rout: passwords.csv test.R
bigtest.Rout: passwords.csv bigtest.R

######################################################################

### Makestuff

## Change this name to download a new version of the makestuff directory
# Makefile: start.makestuff

-include $(ms)/git.mk
-include $(ms)/visual.mk

-include $(ms)/wrapR.mk
# -include $(ms)/oldlatex.mk
