#---------------------------------------------------------------------------------#
#-----  The 1.8V Nw/P-plus diode Structure for CSMC 0.18um RF CMOS process -------#
#-----  Using GSMC 0.18um RF CMOS process as reference ---------------------------#
#--------------           UCR EE165 Lab1 Modified By Cheng           -------------#
#---------------------------------------------------------------------------------#

implant tables=Taurus


machine clear
mgoals on

# STI #
set y0          0
set y1          $y0+0.43

# PPlus #
set y11   $y1+0.1
set y12   $y11+0.22
set y13   $y12+0.28
set y14   $y13+0.22

# STI #
set y2    $y1+0.92
set y3    $y2+0.52

# NPlus #
set y31   $y3+0.1
set y32   $y31+0.22
set y33   $y32+0.28
set y34   $y33+0.22

# STI #
set y4    $y3+0.92
set y5    $y4+0.43

# NPlus 2 
set y51	  $y5+0.1
set y52	  $y51+0.22
set y53   $y52+0.28
set y54   $y53+0.22

#STI#
set y6    $y5+0.92
set y7    $y6+0.52

# PPlus 2 #
set y71   $y7+0.1
set y72   $y71+0.22
set y73   $y72+0.28
set y74   $y73+0.22

# STI #
set y8    $y7+0.92
set ye	  $y8+0.12

set sim_left 0
set sim_right $ye
set sim_bottom 20
set sim_top 0


## -----------------------------------##
## --------  LIGAMENT OUTPUT  --------##
## -----------------------------------##
## ------- user defined grid ---------##
## -----------------------------------##

line y loc=$sim_left  spa=0.5     tag=left
line y loc=$sim_right spa=0.5     tag=right

line x loc=$sim_top   spa=0.5      tag=top
line x loc=$y1-0.1	  spa=0.01
line x loc=$y2+0.1 	  spa=0.01
line x loc=6.0	      spa=1.0
line x loc=$sim_bottom spa=10.0  tag=bottom

region silicon xlo=top xhi=bottom ylo=left yhi=right

#--------------------------------------#
#---------      WAFER START    --------# 
#--------------------------------------#
init resistivity=10  field=Boron  wafer.orient=100

#--------------------------------------# 
#---------PAD OXIDE LPSO900110D--------#
#--------------------------------------#
deposit material = {Oxide} type = anisotropic  rate = {1.0} time=0.0110

struct tdr=001-pad-oxide

#--------------------------------------# 
#---------LPSIN NIT7551650     --------# 
#--------------------------------------#
deposit material = {Nitride} type = anisotropic  rate = {1.0} time=0.1650

struct tdr=002-nitride

#--------------------------------------#
#---------STI PHOTO MASK       --------# 
#--------------------------------------# 
mask name=mask_AA_1  left=$y0 right=$y1 negative
mask name=mask_AA_2  left=$y2 right=$y3 negative
mask name=mask_AA_3  left=$y4 right=$y5 negative
mask name=mask_AA_4  left=$y6 right=$y7 negative
mask name=mask_AA_5  left=$y8 right=$ye negative

deposit  photoresist anisotropic thickness=5<um> 
etch     photoresist anisotropic thickness=5<um> mask=mask_AA_1
etch     photoresist anisotropic thickness=5<um> mask=mask_AA_2
etch     photoresist anisotropic thickness=5<um> mask=mask_AA_3
etch     photoresist anisotropic thickness=5<um> mask=mask_AA_4
etch     photoresist anisotropic thickness=5<um> mask=mask_AA_5


struct tdr=003-aa-photo

#--------------------------------------# 
#---------     STI ETCH        --------# 
#--------------------------------------# 
etch material = {Nitride} type=anisotropic rate = {10.0} time=1 
etch material = {Oxide}   type=anisotropic rate = {10.0} time=1
etch material = {Silicon} type=anisotropic rate = {0.3690} time=1 

struct tdr=004-aa-etch

#--------------------------------------#
#--------- STI LINER OXIDE PRECLEAN  --#
#--------------------------------------# 
etch material = {Photoresist} type=anisotropic rate = {10.0} time=1 

struct tdr=005-sti-pad-ox-preclean

#--------------------------------------# 
#---------STI LINER OXIDE LOX100200DA--# 
#--------------------------------------#
deposit material = {Oxide} type = isotropic  rate = {1.0} time=0.02
struct tdr=006-sti-liner-oxide

#--------------------------------------# 
#---------STI HDP OXIDE  STNH-50-6200--# 
#--------------------------------------# 
deposit material = {Oxide} type = isotropic  rate = {1.0} time=0.62
struct tdr=007-sti-hdp-oxide-deposition

#--------------------------------------# 
#---------        STI CMP            --#
#--------------------------------------# 
etch type=cmp coord=0.0 material=all
struct tdr=008-sti-cmp

#--------------------------------------# 
#--------- SAC OXIDATION LPSO900110D --# 
#--------------------------------------#
deposit material = {Oxide} type = anisotropic  rate = {1.0} time=0.0110
struct tdr=009-sac-oxidation


#--------------------------------------# 
#---------         NW PHOTO          --# 
#--------------------------------------# 
mask name=mask_NW  left=$y0 right=$ye negative

deposit  photoresist anisotropic thickness=5<um> 
etch     photoresist anisotropic thickness=5<um> mask=mask_NW

struct tdr=010-nw-photo

#--------------------------------------# 
#---------         NW IMP            --# 
#--------- P440K15E3 ------------------#
#--------- P140K50E2 ------------------#
#--------- A130K105E3 -----------------#
#--------------------------------------# 
implant Phosphorus dose=1.5E13  energy=440 tilt=0 
implant Phosphorus dose=5.0e12  energy=140 tilt=0 
implant Arsenic    dose=1.05e13 energy=130 tilt=0 
struct tdr=011-nw-implant


#--------------------------------------# 
#---------WELL ANNEAL  A1000C10S     --#
#--------------------------------------#
diffuse time=10<s> temp=1000
struct tdr=012-well-anneal
temp_ramp clear

#--------------------------------------# 
#---------   SAC OXIDE ETCH          --#
#--------------------------------------#
etch material = {Oxide} type=anisotropic rate = {0.0150} time=1
struct tdr=013-sac-oxide-etch

deposit material = {Oxide} type = anisotropic  rate = {1.0} time=0.0105
struct tdr=014-spacer-etch-barrier-oxide

#--------------------------------------#
#---------      NPLUS PHOTO          --# 
#--------------------------------------# 
mask     name=mask_nplus left=$y3 right=$y4 negative
mask     name=mask_nplus2 left=$y5 right=$y6 negative

deposit  photoresist  thickness=15<um> anisotropic
etch     photoresist  thickness=15<um> anisotropic mask=mask_nplus
etch     photoresist  thickness=15<um> anisotropic mask=mask_nplus2

struct tdr=015-nplus-photo

#--------------------------------------# 
#---------      NPLUS IMPLANT        --# 
#--------- A060K50E5       ------------#
#--------- P035K15E4 ------------------#
#--------------------------------------# 
implant Arsenic    info=2 dose=5.0e15  energy=60  tilt=0  
implant Phosphorus info=2 dose=1.5E14  energy=35  tilt=0
strip Photoresist 

struct tdr=016-nplus-implant

#--------------------------------------# 
#------- RTA-NPLUS-1025C  A1025C20S  --# 
#--------------------------------------# 
diffuse time=20<s> temp=1025 
temp_ramp clear

struct tdr=017-rta-nplus

#--------------------------------------# 
#---------      PPLUS PHOTO          --# 
#--------------------------------------#
mask     name=mask_pplus_1 left=$y1 right=$y2 negative
mask     name=mask_pplus_2 left=$y7 right=$y8 negative

deposit  photoresist  thickness=15<um> anisotropic 
etch     photoresist  thickness=15<um> anisotropic mask=mask_pplus_1
etch     photoresist  thickness=15<um> anisotropic mask=mask_pplus_2

struct tdr=018-pplus-photo

#--------------------------------------# 
#---------      PPLUS IMPLANT        --# 
#--------- B005K24E5       ------------#
#--------- B015K30E3 ------------------#
#--------------------------------------# 
implant Boron    dose=2.4e15  energy=5   tilt=0  
implant Boron    dose=3.0E13  energy=15  tilt=0
strip Photoresist 

struct tdr=019-pplus-implant

#--------------------------------------# 
#---------  SAB OXIDE DEP FLOX-200   --# 
#--------------------------------------# 
deposit material = {Oxide} type = anisotropic  rate = {1.0} time=0.0200
struct tdr=020-sab-oxide

#--------------------------------------# 
#--------- RTA-S/D-1015C  A1015C10S   --# 
#--------------------------------------# 
diffuse time=10<s> temp=1015 
temp_ramp clear

struct tdr=021-rta-sd

#--------------------------------------# 
#---------  SAB OXIDE ETCH   <25A    --# 
#--------------------------------------# 
etch material = {Oxide} type=anisotropic rate = {0.0500} time=1 
struct tdr=022-sab-oxide-etch

struct tdr=023-pre-contact

#--------------------------------------# 
#--------- CONTACT DEFINITION   -------# 
#--------------------------------------# 

contact  box xlo=-0.2  ylo=$y11  xhi=0.2 yhi=$y12   name=pplus1   Silicon
contact  box xlo=-0.2  ylo=$y13  xhi=0.2 yhi=$y14   name=pplus2   Silicon
contact  box xlo=-0.2  ylo=$y71  xhi=0.2 yhi=$y72   name=pplus3   Silicon
contact  box xlo=-0.2  ylo=$y73  xhi=0.2 yhi=$y74   name=pplus4   Silicon



contact  box xlo=-0.2  ylo=$y31  xhi=0.2 yhi=$y32   name=nplus1   Silicon
contact  box xlo=-0.2  ylo=$y33  xhi=0.2 yhi=$y34   name=nplus2   Silicon
contact  box xlo=-0.2  ylo=$y51  xhi=0.2 yhi=$y52   name=nplus3   Silicon
contact  box xlo=-0.2  ylo=$y53  xhi=0.2 yhi=$y54   name=nplus4   Silicon


contact  box xlo=19.9  ylo=$y0   xhi=20.1 yhi=$ye   name=substrate Silicon

struct tdr=024-contact-done
struct smesh=diode
