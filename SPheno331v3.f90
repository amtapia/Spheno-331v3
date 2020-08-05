! -----------------------------------------------------------------------------  
! This file was automatically created by SARAH version 4.14.3 
! SARAH References: arXiv:0806.0538, 0909.2863, 1002.0840, 1207.0906, 1309.7223  
! (c) Florian Staub, 2013  
! ------------------------------------------------------------------------------  
! File created at 16:50 on 3.7.2020   
! ----------------------------------------------------------------------  
 
 
Program SPheno331v3 
 
Use Control
Use InputOutput_331v3
Use LoopFunctions
Use Settings
Use LowEnergy_331v3
Use Mathematics
Use Model_Data_331v3
Use Tadpoles_331v3 
 !Use StandardModel
Use Boundaries_331v3
 Use HiggsCS_331v3
Use TreeLevelMasses_331v3
Use LoopMasses_331v3
 
Use BranchingRatios_331v3
 
Implicit None
 
Real(dp) :: epsI=0.00001_dp, deltaM = 0.000001_dp 
Real(dp) :: mGut = -1._dp, ratioWoM = 0._dp
Integer :: kont, n_tot 
 
Integer,Parameter :: p_max=100
Real(dp) :: Ecms(p_max),Pm(p_max),Pp(p_max), dt, tz, Qin, gSM(11) 
Real(dp) :: vev, sinw2
Complex(dp) :: YdSM(3,3), YuSM(3,3), YeSM(3,3)
Real(dp) :: vSM, g1SM, g2SM, g3SM
Integer :: i1 
Logical :: ISR(p_max)=.False.
Logical :: CalcTBD
Real(dp) :: Tpar,Spar,Upar,ae,amu,atau,EDMe,EDMmu,EDMtau,dRho,BrBsGamma,ratioBsGamma,             & 
& BrDmunu,ratioDmunu,BrDsmunu,ratioDsmunu,BrDstaunu,ratioDstaunu,BrBmunu,ratioBmunu,     & 
& BrBtaunu,ratioBtaunu,BrKmunu,ratioKmunu,RK,RKSM,muEgamma,tauEgamma,tauMuGamma,         & 
& CRmuEAl,CRmuETi,CRmuESr,CRmuESb,CRmuEAu,CRmuEPb,BRmuTo3e,BRtauTo3e,BRtauTo3mu,         & 
& BRtauToemumu,BRtauTomuee,BRtauToemumu2,BRtauTomuee2,BrZtoMuE,BrZtoTauE,BrZtoTauMu,     & 
& BrhtoMuE,BrhtoTauE,BrhtoTauMu,DeltaMBs,ratioDeltaMBs,DeltaMBq,ratioDeltaMBq,           & 
& BrTautoEPi,BrTautoEEta,BrTautoEEtap,BrTautoMuPi,BrTautoMuEta,BrTautoMuEtap,            & 
& BrB0dEE,ratioB0dEE,BrB0sEE,ratioB0sEE,BrB0dMuMu,ratioB0dMuMu,BrB0sMuMu,ratioB0sMuMu,   & 
& BrB0dTauTau,ratioB0dTauTau,BrB0sTauTau,ratioB0sTauTau,BrBtoSEE,ratioBtoSEE,            & 
& BrBtoSMuMu,ratioBtoSMuMu,BrBtoKee,ratioBtoKee,BrBtoKmumu,ratioBtoKmumu,BrBtoSnunu,     & 
& ratioBtoSnunu,BrBtoDnunu,ratioBtoDnunu,BrKptoPipnunu,ratioKptoPipnunu,BrKltoPinunu,    & 
& ratioKltoPinunu,BrK0eMu,ratioK0eMu,DelMK,ratioDelMK,epsK,ratioepsK

Tpar = 0._dp 
Spar = 0._dp 
Upar = 0._dp 
ae = 0._dp 
amu = 0._dp 
atau = 0._dp 
EDMe = 0._dp 
EDMmu = 0._dp 
EDMtau = 0._dp 
dRho = 0._dp 
BrBsGamma = 0._dp 
ratioBsGamma = 0._dp 
BrDmunu = 0._dp 
ratioDmunu = 0._dp 
BrDsmunu = 0._dp 
ratioDsmunu = 0._dp 
BrDstaunu = 0._dp 
ratioDstaunu = 0._dp 
BrBmunu = 0._dp 
ratioBmunu = 0._dp 
BrBtaunu = 0._dp 
ratioBtaunu = 0._dp 
BrKmunu = 0._dp 
ratioKmunu = 0._dp 
RK = 0._dp 
RKSM = 0._dp 
muEgamma = 0._dp 
tauEgamma = 0._dp 
tauMuGamma = 0._dp 
CRmuEAl = 0._dp 
CRmuETi = 0._dp 
CRmuESr = 0._dp 
CRmuESb = 0._dp 
CRmuEAu = 0._dp 
CRmuEPb = 0._dp 
BRmuTo3e = 0._dp 
BRtauTo3e = 0._dp 
BRtauTo3mu = 0._dp 
BRtauToemumu = 0._dp 
BRtauTomuee = 0._dp 
BRtauToemumu2 = 0._dp 
BRtauTomuee2 = 0._dp 
BrZtoMuE = 0._dp 
BrZtoTauE = 0._dp 
BrZtoTauMu = 0._dp 
BrhtoMuE = 0._dp 
BrhtoTauE = 0._dp 
BrhtoTauMu = 0._dp 
DeltaMBs = 0._dp 
ratioDeltaMBs = 0._dp 
DeltaMBq = 0._dp 
ratioDeltaMBq = 0._dp 
BrTautoEPi = 0._dp 
BrTautoEEta = 0._dp 
BrTautoEEtap = 0._dp 
BrTautoMuPi = 0._dp 
BrTautoMuEta = 0._dp 
BrTautoMuEtap = 0._dp 
BrB0dEE = 0._dp 
ratioB0dEE = 0._dp 
BrB0sEE = 0._dp 
ratioB0sEE = 0._dp 
BrB0dMuMu = 0._dp 
ratioB0dMuMu = 0._dp 
BrB0sMuMu = 0._dp 
ratioB0sMuMu = 0._dp 
BrB0dTauTau = 0._dp 
ratioB0dTauTau = 0._dp 
BrB0sTauTau = 0._dp 
ratioB0sTauTau = 0._dp 
BrBtoSEE = 0._dp 
ratioBtoSEE = 0._dp 
BrBtoSMuMu = 0._dp 
ratioBtoSMuMu = 0._dp 
BrBtoKee = 0._dp 
ratioBtoKee = 0._dp 
BrBtoKmumu = 0._dp 
ratioBtoKmumu = 0._dp 
BrBtoSnunu = 0._dp 
ratioBtoSnunu = 0._dp 
BrBtoDnunu = 0._dp 
ratioBtoDnunu = 0._dp 
BrKptoPipnunu = 0._dp 
ratioKptoPipnunu = 0._dp 
BrKltoPinunu = 0._dp 
ratioKltoPinunu = 0._dp 
BrK0eMu = 0._dp 
ratioK0eMu = 0._dp 
DelMK = 0._dp 
ratioDelMK = 0._dp 
epsK = 0._dp 
ratioepsK = 0._dp 
Call get_command_argument(1,inputFileName)
If (len_trim(inputFileName)==0) Then
  inputFileName="LesHouches.in.331v3"
Else
  inputFileName=trim(inputFileName)
End if
Call get_command_argument(2,outputFileName)
If (len_trim(outputFileName)==0) Then
  outputFileName="SPheno.spc.331v3"
Else
  outputFileName=trim(outputFileName)
End if 
g1SM = 0._dp 
g2SM = 0._dp 
g3SM = 0._dp 
vSM = 0._dp 
YdSM = 0._dp 
YeSM = 0._dp 
YuSM = 0._dp 
Call Set_All_Parameters_0() 
 
Qin = SetRenormalizationScale(1.6E2_dp**2)  
kont = 0 
delta_Mass = 0.0001_dp 
CalcTBD = .false. 
Call ReadingData(kont) 
 
 HighScaleModel = "LOW" 
If ((MatchingOrder.lt.-1).or.(MatchingOrder.gt.2)) Then 
  If (HighScaleModel.Eq."LOW") Then 
    If (.not.CalculateOneLoopMasses) Then 
       MatchingOrder = -1 
    Else 
       MatchingOrder =  2 
    End if 
   Else 
       MatchingOrder =  2 
   End If 
End If 
Select Case(MatchingOrder) 
 Case(0) 
   OneLoopMatching = .false. 
   TwoLoopMatching = .false. 
   GuessTwoLoopMatchingBSM = .false. 
 Case(1) 
   OneLoopMatching = .true. 
   TwoLoopMatching = .false. 
   GuessTwoLoopMatchingBSM = .false. 
 Case(2) 
   OneLoopMatching = .true. 
   TwoLoopMatching = .true. 
   GuessTwoLoopMatchingBSM = .true. 
End Select 
If (MatchingOrder.eq.-1) Then 
 ! Setting values 
 Vn = VnIN 
 v1 = v1IN 
 v2 = v2IN 
 g1 = g1IN 
 g2 = g2IN 
 g3 = g3IN 
 l1 = l1IN 
 l12 = l12IN 
 l13 = l13IN 
 l12t = l12tIN 
 l13t = l13tIN 
 l2 = l2IN 
 l23 = l23IN 
 l23t = l23tIN 
 l3 = l3IN 
 hll1 = hll1IN 
 hdp11 = hdp11IN 
 hd1 = hd1IN 
 hdtp11 = hdtp11IN 
 hdt1 = hdt1IN 
 hup11 = hup11IN 
 hUp1 = hUp1IN 
 hdp1 = hdp1IN 
 hd2 = hd2IN 
 hdtp1 = hdtp1IN 
 hdt2 = hdt2IN 
 hup21 = hup21IN 
 hUp2 = hUp2IN 
 hd3 = hd3IN 
 hdt3 = hdt3IN 
 hu11 = hu11IN 
 h12 = h12IN 
 hU1 = hU1IN 
 hU2 = hU2IN 
 ftri = ftriIN 
 mu12 = mu12IN 
 mu22 = mu22IN 
 mu32 = mu32IN 
 l1 = Lambda1IN
l2 = Lambda2IN
l3 = Lambda3IN
l12 = Lambda12IN
l13 = Lambda13IN
l23 = Lambda23IN
l12t = Lambda12TIN
l13t = Lambda13TIN
l23t = Lambda23TIN
ftri = fInput
Vn = VnIN
v1 = v1IN

 
 ! Setting VEVs used for low energy constraints 
 VnMZ = Vn 
 v1MZ = v1 
 v2MZ = v2 
    sinW2=1._dp-mW2/mZ2 
   vSM=1/Sqrt((G_F*Sqrt(2._dp)))
   g1SM=sqrt(4*Pi*Alpha_MZ/(1-sinW2)) 
   g2SM=sqrt(4*Pi*Alpha_MZ/Sinw2 ) 
   g3SM=sqrt(AlphaS_MZ*4*Pi) 
   Do i1=1,3 
      YuSM(i1,i1)=sqrt(2._dp)*mf_u(i1)/vSM 
      YeSM(i1,i1)=sqrt(2._dp)*mf_l(i1)/vSM 
      YdSM(i1,i1)=sqrt(2._dp)*mf_d(i1)/vSM 
    End Do 
    If (GenerationMixing) YuSM = Matmul(Transpose(CKM),YuSM) 


! Transpose Yukawas to fit SPheno conventions 
YuSM= Transpose(YuSM) 
YdSM= Transpose(YdSM)
YeSM= Transpose(YeSM)

 ! Setting Boundary conditions 
 Call SetMatchingConditions(g1SM,g2SM,g3SM,YuSM,YdSM,YeSM,vSM,Vn,v1,v2,g1,             & 
& g2,g3,l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,hll1,hdp11,hd1,hdtp11,hdt1,hup11,            & 
& hUp1,hdp1,hd2,hdtp1,hdt2,hup21,hUp2,hd3,hdt3,hu11,h12,hU1,hU2,ftri,mu12,               & 
& mu22,mu32,.False.)

l1 = Lambda1IN
l2 = Lambda2IN
l3 = Lambda3IN
l12 = Lambda12IN
l13 = Lambda13IN
l23 = Lambda23IN
l12t = Lambda12TIN
l13t = Lambda13TIN
l23t = Lambda23TIN
ftri = fInput
Vn = VnIN
v1 = v1IN
Call SolveTadpoleEquations(g1,g2,g3,l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,              & 
& hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,hUp2,hd3,              & 
& hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,Vn,v1,v2,(/ ZeroC, ZeroC, ZeroC /))

Call OneLoopMasses(MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,MFe2,MFu,MFu2,Mhh,Mhh2,           & 
& MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,TW,Ud,Ue,Uu,Vd,Ve,Vu,             & 
& ZA,ZH,ZP,ZW,zy,ZZ,Vn,v1,v2,g1,g2,g3,l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,               & 
& hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,hUp2,hd3,              & 
& hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,kont)


 If (SignOfMassChanged) Then  
 If (.Not.IgnoreNegativeMasses) Then 
  Write(*,*) " Stopping calculation because of negative mass squared." 
  Call TerminateProgram 
 Else 
  SignOfMassChanged= .False. 
  kont=0  
 End If 
End If 
If (SignOfMuChanged) Then 
 If (.Not.IgnoreMuSignFlip) Then 
  Write(*,*) " Stopping calculation because of negative mass squared in tadpoles." 
  Call TerminateProgram 
 Else 
  SignOfMuChanged= .False. 
  kont=0 
 End If 
End If 

Else 
   If (GetMassUncertainty) Then 
   ! Uncertainty from Y_top 
 If ((CalculateOneLoopMasses).and.(CalculateTwoLoopHiggsMasses)) Then 
OneLoopMatching = .true. 
TwoLoopMatching = .false. 
GuessTwoLoopMatchingBSM = .True. 
Elseif ((CalculateOneLoopMasses).and.(.not.CalculateTwoLoopHiggsMasses)) Then  
OneLoopMatching = .true. 
TwoLoopMatching = .false. 
GuessTwoLoopMatchingBSM = .false. 
Else  
OneLoopMatching = .true. 
TwoLoopMatching = .false. 
GuessTwoLoopMatchingBSM = .false. 
End if 
Call CalculateSpectrum(n_run,delta_mass,WriteOut,kont,MAh,MAh2,MDpm,MDpm2,            & 
& MFd,MFd2,MFe,MFe2,MFu,MFu2,Mhh,Mhh2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,MVZ,              & 
& MVZ2,MVZp,MVZp2,TW,Ud,Ue,Uu,Vd,Ve,Vu,ZA,ZH,ZP,ZW,zy,ZZ,Vn,v1,v2,g1,g2,g3,              & 
& l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,             & 
& hdp1,hd2,hdtp1,hdt2,hup21,hUp2,hd3,hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,               & 
& mu32,mGUT)

n_tot =1
mass_uncertainty_Yt(n_tot:n_tot+2) = Mhh! difference will be taken later 
n_tot = n_tot + 3 
mass_uncertainty_Yt(n_tot:n_tot+2) = MAh! difference will be taken later 
n_tot = n_tot + 3 
mass_uncertainty_Yt(n_tot:n_tot+3) = MHpm! difference will be taken later 
n_tot = n_tot + 4 
mass_uncertainty_Yt(n_tot:n_tot+1) = MDpm! difference will be taken later 
If ((CalculateOneLoopMasses).and.(CalculateTwoLoopHiggsMasses)) Then 
OneLoopMatching = .true. 
TwoLoopMatching = .true. 
GuessTwoLoopMatchingBSM = .false. 
Elseif ((CalculateOneLoopMasses).and.(.not.CalculateTwoLoopHiggsMasses)) Then  
OneLoopMatching = .false. 
TwoLoopMatching = .false. 
GuessTwoLoopMatchingBSM = .false. 
Else  
OneLoopMatching = .false. 
TwoLoopMatching = .false. 
GuessTwoLoopMatchingBSM = .false. 
End if 
  End if 
 Call CalculateSpectrum(n_run,delta_mass,WriteOut,kont,MAh,MAh2,MDpm,MDpm2,            & 
& MFd,MFd2,MFe,MFe2,MFu,MFu2,Mhh,Mhh2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,MVZ,              & 
& MVZ2,MVZp,MVZp2,TW,Ud,Ue,Uu,Vd,Ve,Vu,ZA,ZH,ZP,ZW,zy,ZZ,Vn,v1,v2,g1,g2,g3,              & 
& l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,             & 
& hdp1,hd2,hdtp1,hdt2,hup21,hUp2,hd3,hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,               & 
& mu32,mGUT)

  If (GetMassUncertainty) Then 
 Call GetScaleUncertainty(delta_mass,WriteOut,kont,MAh,MAh2,MDpm,MDpm2,MFd,            & 
& MFd2,MFe,MFe2,MFu,MFu2,Mhh,Mhh2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,             & 
& MVZp,MVZp2,TW,Ud,Ue,Uu,Vd,Ve,Vu,ZA,ZH,ZP,ZW,zy,ZZ,Vn,v1,v2,g1,g2,g3,l1,l12,            & 
& l13,l12t,l13t,l2,l23,l23t,l3,hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,               & 
& hd2,hdtp1,hdt2,hup21,hUp2,hd3,hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,               & 
& mass_uncertainty_Q)

  End if 
 End If 
 ! Save correct Higgs masses for calculation of L -> 3 L' 
MhhL = Mhh
Mhh2L = MhhL**2 
MAhL = MAh
MAh2L = MAhL**2 
 
TW = ACos(Abs(ZZ(1,1)))
If ((L_BR).And.(kont.Eq.0)) Then 
 Call CalculateBR(CalcTBD,ratioWoM,epsI,deltaM,kont,MAh,MAh2,MDpm,MDpm2,               & 
& MFd,MFd2,MFe,MFe2,MFu,MFu2,Mhh,Mhh2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,MVZ,              & 
& MVZ2,MVZp,MVZp2,TW,Ud,Ue,Uu,Vd,Ve,Vu,ZA,ZH,ZP,ZW,zy,ZZ,Vn,v1,v2,g1,g2,g3,              & 
& l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,             & 
& hdp1,hd2,hdtp1,hdt2,hup21,hUp2,hd3,hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,               & 
& mu32,gPFu,gTFu,BRFu,gPFe,gTFe,BRFe,gPFd,gTFd,BRFd,gPhh,gThh,BRhh,gPAh,gTAh,            & 
& BRAh,gPHpm,gTHpm,BRHpm,gPDpm,gTDpm,BRDpm,gPVZ,gTVZ,BRVZ,gPVZp,gTVZp,BRVZp,             & 
& gPVXp,gTVXp,BRVXp)

Call HiggsCrossSections(Mhh,ratioGG,ratioPP,rHB_S_VWp,rHB_S_VZ,rHB_S_S_Fu(:,3)        & 
& ,CS_Higgs_LHC,kont)

Call HiggsCrossSections(MAh,ratioPGG,ratioPPP,0._dp*rHB_S_VWp,0._dp*rHB_S_VZ,         & 
& rHB_P_S_Fu(:,3),CS_PHiggs_LHC,kont)

End If 
 
 If (CalculateLowEnergy) then 
Call CalculateLowEnergyConstraints(g1,g2,g3,l1,l12,l13,l12t,l13t,l2,l23,              & 
& l23t,l3,hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,               & 
& hUp2,hd3,hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,Vn,v1,v2,Tpar,Spar,Upar,            & 
& ae,amu,atau,EDMe,EDMmu,EDMtau,dRho,BrBsGamma,ratioBsGamma,BrDmunu,ratioDmunu,          & 
& BrDsmunu,ratioDsmunu,BrDstaunu,ratioDstaunu,BrBmunu,ratioBmunu,BrBtaunu,               & 
& ratioBtaunu,BrKmunu,ratioKmunu,RK,RKSM,muEgamma,tauEgamma,tauMuGamma,CRmuEAl,          & 
& CRmuETi,CRmuESr,CRmuESb,CRmuEAu,CRmuEPb,BRmuTo3e,BRtauTo3e,BRtauTo3mu,BRtauToemumu,    & 
& BRtauTomuee,BRtauToemumu2,BRtauTomuee2,BrZtoMuE,BrZtoTauE,BrZtoTauMu,BrhtoMuE,         & 
& BrhtoTauE,BrhtoTauMu,DeltaMBs,ratioDeltaMBs,DeltaMBq,ratioDeltaMBq,BrTautoEPi,         & 
& BrTautoEEta,BrTautoEEtap,BrTautoMuPi,BrTautoMuEta,BrTautoMuEtap,BrB0dEE,               & 
& ratioB0dEE,BrB0sEE,ratioB0sEE,BrB0dMuMu,ratioB0dMuMu,BrB0sMuMu,ratioB0sMuMu,           & 
& BrB0dTauTau,ratioB0dTauTau,BrB0sTauTau,ratioB0sTauTau,BrBtoSEE,ratioBtoSEE,            & 
& BrBtoSMuMu,ratioBtoSMuMu,BrBtoKee,ratioBtoKee,BrBtoKmumu,ratioBtoKmumu,BrBtoSnunu,     & 
& ratioBtoSnunu,BrBtoDnunu,ratioBtoDnunu,BrKptoPipnunu,ratioKptoPipnunu,BrKltoPinunu,    & 
& ratioKltoPinunu,BrK0eMu,ratioK0eMu,DelMK,ratioDelMK,epsK,ratioepsK)

MVZ = mz 
MVZ2 = mz2 
MVWp = mW 
MVWp2 = mW2 
If (WriteParametersAtQ) Then 
Call TreeMasses(MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,MFe2,MFu,MFu2,Mhh,Mhh2,              & 
& MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,TW,Ud,Ue,Uu,Vd,Ve,Vu,             & 
& ZA,ZH,ZP,ZW,zy,ZZ,Vn,v1,v2,g1,g2,g3,l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,               & 
& hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,hUp2,hd3,              & 
& hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,GenerationMixing,kont)

End If 
 
End if 
 
If ((FoundIterativeSolution).or.(WriteOutputForNonConvergence)) Then 
If (OutputForMO) Then 
Call RunningFermionMasses(MFe,MFe2,MFd,MFd2,MFu,MFu2,Vn,v1,v2,g1,g2,g3,               & 
& l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,             & 
& hdp1,hd2,hdtp1,hdt2,hup21,hUp2,hd3,hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,               & 
& mu32,kont)

End if 
Write(*,*) "Writing output files" 
Call LesHouches_Out(67,11,kont,MGUT,Tpar,Spar,Upar,ae,amu,atau,EDMe,EDMmu,            & 
& EDMtau,dRho,BrBsGamma,ratioBsGamma,BrDmunu,ratioDmunu,BrDsmunu,ratioDsmunu,            & 
& BrDstaunu,ratioDstaunu,BrBmunu,ratioBmunu,BrBtaunu,ratioBtaunu,BrKmunu,ratioKmunu,     & 
& RK,RKSM,muEgamma,tauEgamma,tauMuGamma,CRmuEAl,CRmuETi,CRmuESr,CRmuESb,CRmuEAu,         & 
& CRmuEPb,BRmuTo3e,BRtauTo3e,BRtauTo3mu,BRtauToemumu,BRtauTomuee,BRtauToemumu2,          & 
& BRtauTomuee2,BrZtoMuE,BrZtoTauE,BrZtoTauMu,BrhtoMuE,BrhtoTauE,BrhtoTauMu,              & 
& DeltaMBs,ratioDeltaMBs,DeltaMBq,ratioDeltaMBq,BrTautoEPi,BrTautoEEta,BrTautoEEtap,     & 
& BrTautoMuPi,BrTautoMuEta,BrTautoMuEtap,BrB0dEE,ratioB0dEE,BrB0sEE,ratioB0sEE,          & 
& BrB0dMuMu,ratioB0dMuMu,BrB0sMuMu,ratioB0sMuMu,BrB0dTauTau,ratioB0dTauTau,              & 
& BrB0sTauTau,ratioB0sTauTau,BrBtoSEE,ratioBtoSEE,BrBtoSMuMu,ratioBtoSMuMu,              & 
& BrBtoKee,ratioBtoKee,BrBtoKmumu,ratioBtoKmumu,BrBtoSnunu,ratioBtoSnunu,BrBtoDnunu,     & 
& ratioBtoDnunu,BrKptoPipnunu,ratioKptoPipnunu,BrKltoPinunu,ratioKltoPinunu,             & 
& BrK0eMu,ratioK0eMu,DelMK,ratioDelMK,epsK,ratioepsK,GenerationMixing)

End if 
Write(*,*) "Finished!" 
Contains 
 
Subroutine CalculateSpectrum(n_run,delta,WriteOut,kont,MAh,MAh2,MDpm,MDpm2,           & 
& MFd,MFd2,MFe,MFe2,MFu,MFu2,Mhh,Mhh2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,MVZ,              & 
& MVZ2,MVZp,MVZp2,TW,Ud,Ue,Uu,Vd,Ve,Vu,ZA,ZH,ZP,ZW,zy,ZZ,Vn,v1,v2,g1,g2,g3,              & 
& l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,             & 
& hdp1,hd2,hdtp1,hdt2,hup21,hUp2,hd3,hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,               & 
& mu32,mGUT)

Implicit None 
Integer, Intent(in) :: n_run 
Integer, Intent(inout) :: kont 
Logical, Intent(in) :: WriteOut 
Real(dp), Intent(in) :: delta 
Real(dp), Intent(inout) :: mGUT 
Real(dp),Intent(inout) :: g1,g2,g3,ftri,mu12,mu22,mu32

Complex(dp),Intent(inout) :: l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,hll1(3,3),hdp11(3),hd1(3),hdtp11(2),              & 
& hdt1(2),hup11(3),hUp1,hdp1(3),hd2(3),hdtp1(2),hdt2(2),hup21(3),hUp2,hd3(3),            & 
& hdt3(2),hu11(3),h12(3),hU1,hU2

Real(dp),Intent(inout) :: MAh(3),MAh2(3),MDpm(2),MDpm2(2),MFd(5),MFd2(5),MFe(3),MFe2(3),MFu(4),MFu2(4),         & 
& Mhh(3),Mhh2(3),MHpm(4),MHpm2(4),MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,TW

Complex(dp),Intent(inout) :: Ud(5,5),Ue(3,3),Uu(4,4),Vd(5,5),Ve(3,3),Vu(4,4),ZA(3,3),ZH(3,3),ZP(4,4),              & 
& ZW(4,4),zy(2,2),ZZ(3,3)

Real(dp),Intent(inout) :: Vn,v1,v2

kont = 0 
Call FirstGuess(MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,MFe2,MFu,MFu2,Mhh,Mhh2,              & 
& MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,TW,Ud,Ue,Uu,Vd,Ve,Vu,             & 
& ZA,ZH,ZP,ZW,zy,ZZ,Vn,v1,v2,g1,g2,g3,l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,               & 
& hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,hUp2,hd3,              & 
& hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,kont)

!If (kont.ne.0) Call TerminateProgram 
 
If (SPA_Convention) Call SetRGEScale(1.e3_dp**2) 
 
If (.Not.UseFixedScale) Then 
 Call SetRGEScale(160._dp**2) 
End If
Call Match_and_Run(delta,MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,MFe2,MFu,MFu2,              & 
& Mhh,Mhh2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,TW,Ud,Ue,Uu,             & 
& Vd,Ve,Vu,ZA,ZH,ZP,ZW,zy,ZZ,g1,g2,g3,l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,               & 
& hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,hUp2,hd3,              & 
& hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,mGut,kont,WriteOut,n_run)

If (kont.ne.0) Then 
 Write(*,*) "Error appeared in calculation of masses "
 
 Call TerminateProgram 
End If 
 
End Subroutine CalculateSpectrum 
 

 
Subroutine ReadingData(kont)
Implicit None
Integer,Intent(out)::kont
Logical::file_exists
kont=-123456
Inquire(file=inputFileName,exist=file_exists)
If (file_exists) Then
kont=1
Call LesHouches_Input(kont,Ecms,Pm,Pp,ISR,F_GMSB)
LesHouches_Format= .True.
Else
Write(*,*)&
& "File ",inputFileName," does not exist"
Call TerminateProgram
End If
End Subroutine ReadingData

 
Subroutine GetScaleUncertainty(delta,WriteOut,kont,MAhinput,MAh2input,MDpminput,      & 
& MDpm2input,MFdinput,MFd2input,MFeinput,MFe2input,MFuinput,MFu2input,Mhhinput,          & 
& Mhh2input,MHpminput,MHpm2input,MVWpinput,MVWp2input,MVXpinput,MVXp2input,              & 
& MVZinput,MVZ2input,MVZpinput,MVZp2input,TWinput,Udinput,Ueinput,Uuinput,               & 
& Vdinput,Veinput,Vuinput,ZAinput,ZHinput,ZPinput,ZWinput,zyinput,ZZinput,               & 
& Vninput,v1input,v2input,g1input,g2input,g3input,l1input,l12input,l13input,             & 
& l12tinput,l13tinput,l2input,l23input,l23tinput,l3input,hll1input,hdp11input,           & 
& hd1input,hdtp11input,hdt1input,hup11input,hUp1input,hdp1input,hd2input,hdtp1input,     & 
& hdt2input,hup21input,hUp2input,hd3input,hdt3input,hu11input,h12input,hU1input,         & 
& hU2input,ftriinput,mu12input,mu22input,mu32input,mass_Qerror)

Implicit None 
Integer, Intent(inout) :: kont 
Logical, Intent(in) :: WriteOut 
Real(dp), Intent(in) :: delta 
Real(dp) :: mass_in(24), mass_new(24) 
Real(dp), Intent(out) :: mass_Qerror(24) 
Real(dp) :: gD(128), Q, Qsave, Qstep, Qt, g_SM(62), mh_SM 
Integer :: i1, i2, iupdown, ntot 
Real(dp),Intent(in) :: g1input,g2input,g3input,ftriinput,mu12input,mu22input,mu32input

Complex(dp),Intent(in) :: l1input,l12input,l13input,l12tinput,l13tinput,l2input,l23input,l23tinput,             & 
& l3input,hll1input(3,3),hdp11input(3),hd1input(3),hdtp11input(2),hdt1input(2),          & 
& hup11input(3),hUp1input,hdp1input(3),hd2input(3),hdtp1input(2),hdt2input(2),           & 
& hup21input(3),hUp2input,hd3input(3),hdt3input(2),hu11input(3),h12input(3),             & 
& hU1input,hU2input

Real(dp),Intent(in) :: MAhinput(3),MAh2input(3),MDpminput(2),MDpm2input(2),MFdinput(5),MFd2input(5),         & 
& MFeinput(3),MFe2input(3),MFuinput(4),MFu2input(4),Mhhinput(3),Mhh2input(3),            & 
& MHpminput(4),MHpm2input(4),MVWpinput,MVWp2input,MVXpinput,MVXp2input,MVZinput,         & 
& MVZ2input,MVZpinput,MVZp2input,TWinput

Complex(dp),Intent(in) :: Udinput(5,5),Ueinput(3,3),Uuinput(4,4),Vdinput(5,5),Veinput(3,3),Vuinput(4,4),        & 
& ZAinput(3,3),ZHinput(3,3),ZPinput(4,4),ZWinput(4,4),zyinput(2,2),ZZinput(3,3)

Real(dp),Intent(in) :: Vninput,v1input,v2input

Real(dp) :: g1,g2,g3,ftri,mu12,mu22,mu32

Complex(dp) :: l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,hll1(3,3),hdp11(3),hd1(3),hdtp11(2),              & 
& hdt1(2),hup11(3),hUp1,hdp1(3),hd2(3),hdtp1(2),hdt2(2),hup21(3),hUp2,hd3(3),            & 
& hdt3(2),hu11(3),h12(3),hU1,hU2

Real(dp) :: MAh(3),MAh2(3),MDpm(2),MDpm2(2),MFd(5),MFd2(5),MFe(3),MFe2(3),MFu(4),MFu2(4),         & 
& Mhh(3),Mhh2(3),MHpm(4),MHpm2(4),MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,TW

Complex(dp) :: Ud(5,5),Ue(3,3),Uu(4,4),Vd(5,5),Ve(3,3),Vu(4,4),ZA(3,3),ZH(3,3),ZP(4,4),              & 
& ZW(4,4),zy(2,2),ZZ(3,3)

Real(dp) :: Vn,v1,v2

kont = 0 
Write(*,*) "Check scale uncertainty" 
n_tot =1
mass_in(n_tot:n_tot+2) = Mhhinput
n_tot = n_tot + 3 
mass_in(n_tot:n_tot+2) = MAhinput
n_tot = n_tot + 3 
mass_in(n_tot:n_tot+3) = MHpminput
n_tot = n_tot + 4 
mass_in(n_tot:n_tot+1) = MDpminput
mass_Qerror = 0._dp 
Qsave=sqrt(getRenormalizationScale()) 
Do iupdown=1,2 
If (iupdown.eq.1) Then 
  Qstep=Qsave/7._dp 
Else 
  Qstep=-0.5_dp*Qsave/7._dp 
End if 
Do i1=1,7 
Q=Qsave+i1*Qstep 
Qt = SetRenormalizationScale(Q**2) 
g1 = g1input
g2 = g2input
g3 = g3input
l1 = l1input
l12 = l12input
l13 = l13input
l12t = l12tinput
l13t = l13tinput
l2 = l2input
l23 = l23input
l23t = l23tinput
l3 = l3input
hll1 = hll1input
hdp11 = hdp11input
hd1 = hd1input
hdtp11 = hdtp11input
hdt1 = hdt1input
hup11 = hup11input
hUp1 = hUp1input
hdp1 = hdp1input
hd2 = hd2input
hdtp1 = hdtp1input
hdt2 = hdt2input
hup21 = hup21input
hUp2 = hUp2input
hd3 = hd3input
hdt3 = hdt3input
hu11 = hu11input
h12 = h12input
hU1 = hU1input
hU2 = hU2input
ftri = ftriinput
mu12 = mu12input
mu22 = mu22input
mu32 = mu32input
Vn = Vninput
v1 = v1input
v2 = v2input

 
 ! --- GUT normalize gauge couplings --- 
g1 = 1*g1 
! ----------------------- 
 
Call ParametersToG128(g1,g2,g3,l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,hll1,              & 
& hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,hUp2,hd3,hdt3,              & 
& hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,Vn,v1,v2,gD)

If (iupdown.eq.1) Then 
 tz=Log(Q/Qsave)
 dt=-tz/50._dp
 Call odeint(gD,128,0._dp,tz,0.1_dp*delta,dt,0._dp,rge128,kont)
Else 
 tz=-Log(Q/Qsave)
 dt=tz/50._dp
 Call odeint(gD,128,tz,0._dp,0.1_dp*delta,dt,0._dp,rge128,kont)
End if 
Call GToParameters128(gD,g1,g2,g3,l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,hll1,           & 
& hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,hUp2,hd3,hdt3,              & 
& hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,Vn,v1,v2)


 
 ! --- Remove GUT-normalization of gauge couplings --- 
g1 = 1*g1 
! ----------------------- 
 
Call SolveTadpoleEquations(g1,g2,g3,l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,              & 
& hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,hUp2,hd3,              & 
& hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,Vn,v1,v2,(/ ZeroC, ZeroC, ZeroC /))

Call OneLoopMasses(MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,MFe2,MFu,MFu2,Mhh,Mhh2,           & 
& MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,TW,Ud,Ue,Uu,Vd,Ve,Vu,             & 
& ZA,ZH,ZP,ZW,zy,ZZ,Vn,v1,v2,g1,g2,g3,l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,               & 
& hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,hUp2,hd3,              & 
& hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,kont)

If (((Calculate_mh_within_SM).and.(Mhh(2).gt.300._dp)).OR.(Force_mh_within_SM))Then
g_SM=g_SM_save 
tz=0.5_dp*Log(mZ2/Q**2)
dt=tz/100._dp
g_SM(1)=Sqrt(5._dp/3._dp)*g_SM(1) 
Call odeint(g_SM,62,tz,0._dp,delta,dt,0._dp,rge62_SM,kont) 
g_SM(1)=Sqrt(3._dp/5._dp)*g_SM(1) 
Call Get_mh_pole_SM(g_SM,Q**2,delta,Mhh2(1),mh_SM)
Mhh2(1) = mh_SM**2 
Mhh(1) = mh_SM 
End if
n_tot =1
mass_new(n_tot:n_tot+2) = Mhh
n_tot = n_tot + 3 
mass_new(n_tot:n_tot+2) = MAh
n_tot = n_tot + 3 
mass_new(n_tot:n_tot+3) = MHpm
n_tot = n_tot + 4 
mass_new(n_tot:n_tot+1) = MDpm
  Do i2=1,24 
    If (Abs(mass_new(i2)-mass_in(i2)).gt.mass_Qerror(i2)) mass_Qerror(i2) = Abs(mass_new(i2)-mass_in(i2)) 
  End Do 
End Do 
End Do 
  Do i2=1,24  
    mass_uncertainty_Yt(i2) = Abs(mass_uncertainty_Yt(i2)-mass_in(i2)) 
  End Do 
If (kont.ne.0) Then 
 Write(*,*) "Error appeared in check of scale uncertainty "
 
 Call TerminateProgram 
End If 
 
Qt = SetRenormalizationScale(Qsave**2) 
End Subroutine GetScaleUncertainty 
 

 
End Program SPheno331v3 
