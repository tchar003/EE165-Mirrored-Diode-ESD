#--------- the device part is started. ---------------------------#
#--------           UCR EE165 Lab2             -------------------#
#-----------------------------------------------------------------#
Device DIODE{

File {
  # input files
     Grid    = "diode_msh.tdr"

  # output files
    Plot    = "diode18_des.tdr"
    Current = "diode18_des.plt"

}


Electrode {
   { name="pplus1"    voltage=0.0 }
   { name="pplus2"    voltage=0.0 }
   { name="pplus3"    voltage=0.0 }
   { name="pplus4"    voltage=0.0 }


   { name="nplus1"     voltage=0.0 }
   { name="nplus2"     voltage=0.0 }
   { name="nplus3"     voltage=0.0 }
   { name="nplus4"     voltage=0.0 }

   { name="substrate"  voltage=0.0 }
}

Thermode {
   { name="pplus1"    temperature=300 surfaceResistance=1e-6}
   { name="pplus2"    temperature=300 surfaceResistance=1e-6}
   { name="pplus3"    temperature=300 surfaceResistance=1e-6}
   { name="pplus4"    temperature=300 surfaceResistance=1e-6}

   { name="nplus1"     temperature=300 surfaceResistance=1e-6}
   { name="nplus2"     temperature=300 surfaceResistance=1e-6}
   { name="nplus3"     temperature=300 surfaceResistance=1e-6}
   { name="nplus4"     temperature=300 surfaceResistance=1e-6}

   { name="substrate"  temperature=300 surfaceResistance=1e-6}
}


Physics(MaterialInterface="Oxide/Silicon") {charge(surfconc=5e10)}


Physics {
    AreaFactor=5
    Recombination(SRH(DopingDep TempDep) Auger Avalanche(Eparallel))
    Mobility(DopingDep HighFieldSaturation Enormal)
    EffectiveIntrinsicDensity(oldSlotboom)
    Thermodynamic
    AnalTEP 
}
}
#---------------------------------------------------------------#
#--------- the device part is ended. ---------------------------#

#--------- System starts ---------------------------------------#
#---------------------------------------------------------------#

System{
Electrical (A B 0)
Thermal (TP1 TP2 TP3 TP4 TN1 TN2 TN3 TN4 TSUB)

DIODE  diode ( "nplus1"=0 "nplus2"=0 "nplus3"=0 "nplus4"=0 "substrate"=0
               "pplus1"=A "pplus2"=A "pplus3"=A "pplus4"=A
               
               "pplus1"=TP1 "pplus2"=TP2 "pplus3"=TP3 "pplus4"=TP4 "substrate"=TSUB 
               "nplus1"=TN1 "nplus2"=TN2 "nplus3"=TN3 "nplus4"=TN4
              )
set (TP1=300 TP2=300 TP3=300 TP4=300 TN1=300 TN2=300 TN3=300 TN4=300 TSUB=300 )                  
Isource_pset I1(0 B) {pwl=(0          1e-15
                           10e-9      1.33
                           50e-9      1.04
                           150e-9     5.43e-1
                           450e-9     7.24e-2
                           1e-6    0  )}
        #---- hbm  --------#
Resistor_pset R1(B A) {resistance=1e-9}
plot "diode.plt" (time() v(A)  i(A B))
}
#----------------------------------------------------------------#

File{
     current="HBM"
     output="HBM"
}

plot {
    eDensity hDensity
    eCurrent/Vector hCurrent/Vector totalCurrent/Vector
    ElectricField/Vector
    eTemperature hTemperature Temperature
    LatticeTemperature
    eQuasiFermi hQuasiFermi
    Potential Doping SpaceCharge
    SRH Auger Avalanche
    eMobility hMobility
    DonorConcentration AcceptorConcentration
    EffectiveIntrinsicDensity
    Doping
}


Math {
   Derivatives
   Avalderivative
   NoCheckTransientError
   NewDiscretization
   RelErrControl
   ErrEff(Electron) = 1e+10
   ErrEff(Hole) = 1e+10
   Digits=5
   Method=Blocked
   Submethod=Pardiso
   NoAutomaticCircuitContact
   Transient=BE
   Notdamped=50
   Iterations=10
   BreakCriteria{ LatticeTemperature (Maxval = 1688)}
}

solve {
     Poisson
     Coupled { Poisson Electron Hole Contact Circuit }   
     Coupled { Poisson Electron Hole Temperature }   
     Transient ( InitialStep=5e-12 MaxStep=5e-5 Increment=1.2  
                 InitialTime=0     FinalTime=450e-9
                 plot { range=(0, 20e-9) intervals=10}  )
               { Coupled { diode.Poisson diode.Electron diode.Hole diode.Temperature diode.contact circuit} }

      }
