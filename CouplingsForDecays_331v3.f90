! -----------------------------------------------------------------------------  
! This file was automatically created by SARAH version 4.14.3 
! SARAH References: arXiv:0806.0538, 0909.2863, 1002.0840, 1207.0906, 1309.7223  
! (c) Florian Staub, 2013  
! ------------------------------------------------------------------------------  
! File created at 16:50 on 3.7.2020   
! ----------------------------------------------------------------------  
 
 
Module CouplingsForDecays_331v3
 
Use Control 
Use Settings 
Use Model_Data_331v3 
Use Couplings_331v3 
Use LoopCouplings_331v3 
Use Tadpoles_331v3 
 Use TreeLevelMasses_331v3 
Use Mathematics, Only: CompareMatrices, Adjungate 
 
Use StandardModel 
Contains 
 
 
 
Subroutine CouplingsFor_Fu_decays_2B(m_in,i1,MAhinput,MAh2input,MDpminput,            & 
& MDpm2input,MFdinput,MFd2input,MFeinput,MFe2input,MFuinput,MFu2input,Mhhinput,          & 
& Mhh2input,MHpminput,MHpm2input,MVWpinput,MVWp2input,MVXpinput,MVXp2input,              & 
& MVZinput,MVZ2input,MVZpinput,MVZp2input,TWinput,Udinput,Ueinput,Uuinput,               & 
& Vdinput,Veinput,Vuinput,ZAinput,ZHinput,ZPinput,ZWinput,zyinput,ZZinput,               & 
& g1input,g2input,g3input,l1input,l12input,l13input,l12tinput,l13tinput,l2input,         & 
& l23input,l23tinput,l3input,hll1input,hdp11input,hd1input,hdtp11input,hdt1input,        & 
& hup11input,hUp1input,hdp1input,hd2input,hdtp1input,hdt2input,hup21input,               & 
& hUp2input,hd3input,hdt3input,hu11input,h12input,hU1input,hU2input,ftriinput,           & 
& mu12input,mu22input,mu32input,Vninput,v1input,v2input,cplcFuFuAhL,cplcFuFuAhR,         & 
& cplcFuFuDpmL,cplcFuFuDpmR,cplcFuFdVWpL,cplcFuFdVWpR,cplcFuFdVXpL,cplcFuFdVXpR,         & 
& cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFuhhL,cplcFuFuhhR,cplcFuFuVZL,cplcFuFuVZR,           & 
& cplcFuFuVZpL,cplcFuFuVZpR,cplcFuFucDpmL,cplcFuFucDpmR,deltaM)

Implicit None 

Real(dp), Intent(in) :: m_in 
Real(dp), Intent(in) :: deltaM 
Integer, Intent(in) :: i1 
Real(dp),Intent(in) :: g1input,g2input,g3input,ftriinput,mu12input,mu22input,mu32input,Vninput,              & 
& v1input,v2input

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

Real(dp) :: g1,g2,g3,ftri,mu12,mu22,mu32,Vn,v1,v2

Complex(dp) :: l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,hll1(3,3),hdp11(3),hd1(3),hdtp11(2),              & 
& hdt1(2),hup11(3),hUp1,hdp1(3),hd2(3),hdtp1(2),hdt2(2),hup21(3),hUp2,hd3(3),            & 
& hdt3(2),hu11(3),h12(3),hU1,hU2

Complex(dp),Intent(out) :: cplcFuFuAhL(4,4,3),cplcFuFuAhR(4,4,3),cplcFuFuDpmL(4,4,2),cplcFuFuDpmR(4,4,2),        & 
& cplcFuFdVWpL(4,5),cplcFuFdVWpR(4,5),cplcFuFdVXpL(4,5),cplcFuFdVXpR(4,5),               & 
& cplcFuFdcHpmL(4,5,4),cplcFuFdcHpmR(4,5,4),cplcFuFuhhL(4,4,3),cplcFuFuhhR(4,4,3),       & 
& cplcFuFuVZL(4,4),cplcFuFuVZR(4,4),cplcFuFuVZpL(4,4),cplcFuFuVZpR(4,4),cplcFuFucDpmL(4,4,2),& 
& cplcFuFucDpmR(4,4,2)

Integer :: i2, i3, gt1, gt2, gt3, kont 
Real(dp) :: MAh(3),MAh2(3),MDpm(2),MDpm2(2),MFd(5),MFd2(5),MFe(3),MFe2(3),MFu(4),MFu2(4),         & 
& Mhh(3),Mhh2(3),MHpm(4),MHpm2(4),MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,TW

Complex(dp) :: Ud(5,5),Ue(3,3),Uu(4,4),Vd(5,5),Ve(3,3),Vu(4,4),ZA(3,3),ZH(3,3),ZP(4,4),              & 
& ZW(4,4),zy(2,2),ZZ(3,3)

Real(dp) :: gSM(11), sinW2, dt, tz, Qin 
Iname = Iname + 1 
NameOfUnit(Iname) = 'Couplings_Fu_2B'
 
sinW2=1._dp-mW2/mZ2 
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
Qin=sqrt(getRenormalizationScale()) 
Call SolveTadpoleEquations(g1,g2,g3,l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,              & 
& hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,hUp2,hd3,              & 
& hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,Vn,v1,v2,(/ ZeroC, ZeroC, ZeroC /))

! --- Calculate running tree-level masses for loop induced couplings and Quark mixing matrices --- 
Call TreeMasses(MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,MFe2,MFu,MFu2,Mhh,Mhh2,              & 
& MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,TW,Ud,Ue,Uu,Vd,Ve,Vu,             & 
& ZA,ZH,ZP,ZW,zy,ZZ,Vn,v1,v2,g1,g2,g3,l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,               & 
& hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,hUp2,hd3,              & 
& hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,.True.,kont)

If (ExternalZfactors) Then 
! --- Use the 1-loop mixing matrices calculated at M_SUSY in the vertices --- 
ZA = ZAinput 
ZH = ZHinput 
ZP = ZPinput 
ZW = ZWinput 
zy = zyinput 
ZZ = ZZinput 
End if 
If (PoleMassesInLoops) Then 
! --- Use the pole masses --- 
MAh = MAhinput 
MAh2 = MAh2input 
MDpm = MDpminput 
MDpm2 = MDpm2input 
MFd = MFdinput 
MFd2 = MFd2input 
MFe = MFeinput 
MFe2 = MFe2input 
MFu = MFuinput 
MFu2 = MFu2input 
Mhh = Mhhinput 
Mhh2 = Mhh2input 
MHpm = MHpminput 
MHpm2 = MHpm2input 
MVWp = MVWpinput 
MVWp2 = MVWp2input 
MVXp = MVXpinput 
MVXp2 = MVXp2input 
MVZ = MVZinput 
MVZ2 = MVZ2input 
MVZp = MVZpinput 
MVZp2 = MVZp2input 
End if 
cplcFuFuAhL = 0._dp 
cplcFuFuAhR = 0._dp 
Do gt1 = 1, 4
 Do gt2 = 1, 4
  Do gt3 = 1, 3
Call CouplingcFuFuAhT(gt1,gt2,gt3,hup11,hUp1,hup21,hUp2,hu11,h12,hU1,hU2,             & 
& ZA,Vu,Uu,cplcFuFuAhL(gt1,gt2,gt3),cplcFuFuAhR(gt1,gt2,gt3))

  End Do 
 End Do 
End Do 


cplcFuFuDpmL = 0._dp 
cplcFuFuDpmR = 0._dp 
Do gt1 = 1, 4
 Do gt2 = 1, 4
  Do gt3 = 1, 2
Call CouplingcFuFuDpmT(gt1,gt2,gt3,hu11,h12,hU1,hU2,zy,Vu,Uu,cplcFuFuDpmL(gt1,gt2,gt3)& 
& ,cplcFuFuDpmR(gt1,gt2,gt3))

  End Do 
 End Do 
End Do 


cplcFuFdcHpmL = 0._dp 
cplcFuFdcHpmR = 0._dp 
Do gt1 = 1, 4
 Do gt2 = 1, 5
  Do gt3 = 1, 4
Call CouplingcFuFdcHpmT(gt1,gt2,gt3,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,            & 
& hd2,hdtp1,hdt2,hup21,hUp2,hd3,hdt3,hu11,h12,hU1,hU2,ZP,Vd,Ud,Vu,Uu,cplcFuFdcHpmL(gt1,gt2,gt3)& 
& ,cplcFuFdcHpmR(gt1,gt2,gt3))

  End Do 
 End Do 
End Do 


cplcFuFuhhL = 0._dp 
cplcFuFuhhR = 0._dp 
Do gt1 = 1, 4
 Do gt2 = 1, 4
  Do gt3 = 1, 3
Call CouplingcFuFuhhT(gt1,gt2,gt3,hup11,hUp1,hup21,hUp2,hu11,h12,hU1,hU2,             & 
& ZH,Vu,Uu,cplcFuFuhhL(gt1,gt2,gt3),cplcFuFuhhR(gt1,gt2,gt3))

  End Do 
 End Do 
End Do 


cplcFuFucDpmL = 0._dp 
cplcFuFucDpmR = 0._dp 
Do gt1 = 1, 4
 Do gt2 = 1, 4
  Do gt3 = 1, 2
Call CouplingcFuFucDpmT(gt1,gt2,gt3,hu11,h12,hU1,hU2,zy,Vu,Uu,cplcFuFucDpmL(gt1,gt2,gt3)& 
& ,cplcFuFucDpmR(gt1,gt2,gt3))

  End Do 
 End Do 
End Do 


cplcFuFdVWpL = 0._dp 
cplcFuFdVWpR = 0._dp 
Do gt1 = 1, 4
 Do gt2 = 1, 5
Call CouplingcFuFdVWpT(gt1,gt2,g2,Vd,Vu,cplcFuFdVWpL(gt1,gt2),cplcFuFdVWpR(gt1,gt2))

 End Do 
End Do 


cplcFuFdVXpL = 0._dp 
cplcFuFdVXpR = 0._dp 
Do gt1 = 1, 4
 Do gt2 = 1, 5
Call CouplingcFuFdVXpT(gt1,gt2,g2,Vd,Vu,cplcFuFdVXpL(gt1,gt2),cplcFuFdVXpR(gt1,gt2))

 End Do 
End Do 


cplcFuFuVZL = 0._dp 
cplcFuFuVZR = 0._dp 
Do gt1 = 1, 4
 Do gt2 = 1, 4
Call CouplingcFuFuVZT(gt1,gt2,g1,g2,ZZ,Vu,Uu,cplcFuFuVZL(gt1,gt2),cplcFuFuVZR(gt1,gt2))

 End Do 
End Do 


cplcFuFuVZpL = 0._dp 
cplcFuFuVZpR = 0._dp 
Do gt1 = 1, 4
 Do gt2 = 1, 4
Call CouplingcFuFuVZpT(gt1,gt2,g1,g2,ZZ,Vu,Uu,cplcFuFuVZpL(gt1,gt2),cplcFuFuVZpR(gt1,gt2))

 End Do 
End Do 


Iname = Iname - 1 
 
End subroutine CouplingsFor_Fu_decays_2B
 
Subroutine CouplingsFor_Fe_decays_2B(m_in,i1,MAhinput,MAh2input,MDpminput,            & 
& MDpm2input,MFdinput,MFd2input,MFeinput,MFe2input,MFuinput,MFu2input,Mhhinput,          & 
& Mhh2input,MHpminput,MHpm2input,MVWpinput,MVWp2input,MVXpinput,MVXp2input,              & 
& MVZinput,MVZ2input,MVZpinput,MVZp2input,TWinput,Udinput,Ueinput,Uuinput,               & 
& Vdinput,Veinput,Vuinput,ZAinput,ZHinput,ZPinput,ZWinput,zyinput,ZZinput,               & 
& g1input,g2input,g3input,l1input,l12input,l13input,l12tinput,l13tinput,l2input,         & 
& l23input,l23tinput,l3input,hll1input,hdp11input,hd1input,hdtp11input,hdt1input,        & 
& hup11input,hUp1input,hdp1input,hd2input,hdtp1input,hdt2input,hup21input,               & 
& hUp2input,hd3input,hdt3input,hu11input,h12input,hU1input,hU2input,ftriinput,           & 
& mu12input,mu22input,mu32input,Vninput,v1input,v2input,cplcFeFeAhL,cplcFeFeAhR,         & 
& cplcFeFehhL,cplcFeFehhR,cplcFeFeVZL,cplcFeFeVZR,cplcFeFeVZpL,cplcFeFeVZpR,             & 
& cplcFeFv1HpmL,cplcFeFv1HpmR,cplcFeFv1cVWpL,cplcFeFv1cVWpR,cplcFecFv1HpmL,              & 
& cplcFecFv1HpmR,deltaM)

Implicit None 

Real(dp), Intent(in) :: m_in 
Real(dp), Intent(in) :: deltaM 
Integer, Intent(in) :: i1 
Real(dp),Intent(in) :: g1input,g2input,g3input,ftriinput,mu12input,mu22input,mu32input,Vninput,              & 
& v1input,v2input

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

Real(dp) :: g1,g2,g3,ftri,mu12,mu22,mu32,Vn,v1,v2

Complex(dp) :: l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,hll1(3,3),hdp11(3),hd1(3),hdtp11(2),              & 
& hdt1(2),hup11(3),hUp1,hdp1(3),hd2(3),hdtp1(2),hdt2(2),hup21(3),hUp2,hd3(3),            & 
& hdt3(2),hu11(3),h12(3),hU1,hU2

Complex(dp),Intent(out) :: cplcFeFeAhL(3,3,3),cplcFeFeAhR(3,3,3),cplcFeFehhL(3,3,3),cplcFeFehhR(3,3,3),          & 
& cplcFeFeVZL(3,3),cplcFeFeVZR(3,3),cplcFeFeVZpL(3,3),cplcFeFeVZpR(3,3),cplcFeFv1HpmL(3,3,4),& 
& cplcFeFv1HpmR(3,3,4),cplcFeFv1cVWpL(3,3),cplcFeFv1cVWpR(3,3),cplcFecFv1HpmL(3,3,4),    & 
& cplcFecFv1HpmR(3,3,4)

Integer :: i2, i3, gt1, gt2, gt3, kont 
Real(dp) :: MAh(3),MAh2(3),MDpm(2),MDpm2(2),MFd(5),MFd2(5),MFe(3),MFe2(3),MFu(4),MFu2(4),         & 
& Mhh(3),Mhh2(3),MHpm(4),MHpm2(4),MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,TW

Complex(dp) :: Ud(5,5),Ue(3,3),Uu(4,4),Vd(5,5),Ve(3,3),Vu(4,4),ZA(3,3),ZH(3,3),ZP(4,4),              & 
& ZW(4,4),zy(2,2),ZZ(3,3)

Real(dp) :: gSM(11), sinW2, dt, tz, Qin 
Iname = Iname + 1 
NameOfUnit(Iname) = 'Couplings_Fe_2B'
 
sinW2=1._dp-mW2/mZ2 
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
Qin=sqrt(getRenormalizationScale()) 
Call SolveTadpoleEquations(g1,g2,g3,l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,              & 
& hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,hUp2,hd3,              & 
& hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,Vn,v1,v2,(/ ZeroC, ZeroC, ZeroC /))

! --- Calculate running tree-level masses for loop induced couplings and Quark mixing matrices --- 
Call TreeMasses(MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,MFe2,MFu,MFu2,Mhh,Mhh2,              & 
& MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,TW,Ud,Ue,Uu,Vd,Ve,Vu,             & 
& ZA,ZH,ZP,ZW,zy,ZZ,Vn,v1,v2,g1,g2,g3,l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,               & 
& hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,hUp2,hd3,              & 
& hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,.True.,kont)

If (ExternalZfactors) Then 
! --- Use the 1-loop mixing matrices calculated at M_SUSY in the vertices --- 
ZA = ZAinput 
ZH = ZHinput 
ZP = ZPinput 
ZW = ZWinput 
zy = zyinput 
ZZ = ZZinput 
End if 
If (PoleMassesInLoops) Then 
! --- Use the pole masses --- 
MAh = MAhinput 
MAh2 = MAh2input 
MDpm = MDpminput 
MDpm2 = MDpm2input 
MFd = MFdinput 
MFd2 = MFd2input 
MFe = MFeinput 
MFe2 = MFe2input 
MFu = MFuinput 
MFu2 = MFu2input 
Mhh = Mhhinput 
Mhh2 = Mhh2input 
MHpm = MHpminput 
MHpm2 = MHpm2input 
MVWp = MVWpinput 
MVWp2 = MVWp2input 
MVXp = MVXpinput 
MVXp2 = MVXp2input 
MVZ = MVZinput 
MVZ2 = MVZ2input 
MVZp = MVZpinput 
MVZp2 = MVZp2input 
End if 
cplcFeFeAhL = 0._dp 
cplcFeFeAhR = 0._dp 
Do gt1 = 1, 3
 Do gt2 = 1, 3
  Do gt3 = 1, 3
Call CouplingcFeFeAhT(gt1,gt2,gt3,hll1,ZA,Ve,Ue,cplcFeFeAhL(gt1,gt2,gt3)              & 
& ,cplcFeFeAhR(gt1,gt2,gt3))

  End Do 
 End Do 
End Do 


cplcFeFehhL = 0._dp 
cplcFeFehhR = 0._dp 
Do gt1 = 1, 3
 Do gt2 = 1, 3
  Do gt3 = 1, 3
Call CouplingcFeFehhT(gt1,gt2,gt3,hll1,ZH,Ve,Ue,cplcFeFehhL(gt1,gt2,gt3)              & 
& ,cplcFeFehhR(gt1,gt2,gt3))

  End Do 
 End Do 
End Do 


cplcFeFv1HpmL = 0._dp 
cplcFeFv1HpmR = 0._dp 
Do gt1 = 1, 3
 Do gt2 = 1, 3
  Do gt3 = 1, 4
Call CouplingcFeFv1HpmT(gt1,gt2,gt3,hll1,ZP,Ue,cplcFeFv1HpmL(gt1,gt2,gt3)             & 
& ,cplcFeFv1HpmR(gt1,gt2,gt3))

  End Do 
 End Do 
End Do 


cplcFecFv1HpmL = 0._dp 
cplcFecFv1HpmR = 0._dp 
Do gt1 = 1, 3
 Do gt2 = 1, 3
  Do gt3 = 1, 4
Call CouplingcFecFv1HpmT(gt1,gt2,gt3,h12l,ZP,Ve,cplcFecFv1HpmL(gt1,gt2,gt3)           & 
& ,cplcFecFv1HpmR(gt1,gt2,gt3))

  End Do 
 End Do 
End Do 


cplcFeFeVZL = 0._dp 
cplcFeFeVZR = 0._dp 
Do gt1 = 1, 3
 Do gt2 = 1, 3
Call CouplingcFeFeVZT(gt1,gt2,g1,g2,ZZ,cplcFeFeVZL(gt1,gt2),cplcFeFeVZR(gt1,gt2))

 End Do 
End Do 


cplcFeFeVZpL = 0._dp 
cplcFeFeVZpR = 0._dp 
Do gt1 = 1, 3
 Do gt2 = 1, 3
Call CouplingcFeFeVZpT(gt1,gt2,g1,g2,ZZ,cplcFeFeVZpL(gt1,gt2),cplcFeFeVZpR(gt1,gt2))

 End Do 
End Do 


cplcFeFv1cVWpL = 0._dp 
cplcFeFv1cVWpR = 0._dp 
Do gt1 = 1, 3
 Do gt2 = 1, 3
Call CouplingcFeFv1cVWpT(gt1,gt2,g2,Ve,cplcFeFv1cVWpL(gt1,gt2),cplcFeFv1cVWpR(gt1,gt2))

 End Do 
End Do 


Iname = Iname - 1 
 
End subroutine CouplingsFor_Fe_decays_2B
 
Subroutine CouplingsFor_Fd_decays_2B(m_in,i1,MAhinput,MAh2input,MDpminput,            & 
& MDpm2input,MFdinput,MFd2input,MFeinput,MFe2input,MFuinput,MFu2input,Mhhinput,          & 
& Mhh2input,MHpminput,MHpm2input,MVWpinput,MVWp2input,MVXpinput,MVXp2input,              & 
& MVZinput,MVZ2input,MVZpinput,MVZp2input,TWinput,Udinput,Ueinput,Uuinput,               & 
& Vdinput,Veinput,Vuinput,ZAinput,ZHinput,ZPinput,ZWinput,zyinput,ZZinput,               & 
& g1input,g2input,g3input,l1input,l12input,l13input,l12tinput,l13tinput,l2input,         & 
& l23input,l23tinput,l3input,hll1input,hdp11input,hd1input,hdtp11input,hdt1input,        & 
& hup11input,hUp1input,hdp1input,hd2input,hdtp1input,hdt2input,hup21input,               & 
& hUp2input,hd3input,hdt3input,hu11input,h12input,hU1input,hU2input,ftriinput,           & 
& mu12input,mu22input,mu32input,Vninput,v1input,v2input,cplcFdFdAhL,cplcFdFdAhR,         & 
& cplcFdFdDpmL,cplcFdFdDpmR,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdVZL,cplcFdFdVZR,             & 
& cplcFdFdVZpL,cplcFdFdVZpR,cplcFdFdcDpmL,cplcFdFdcDpmR,cplcFdFuHpmL,cplcFdFuHpmR,       & 
& cplcFdFucVWpL,cplcFdFucVWpR,cplcFdFucVXpL,cplcFdFucVXpR,deltaM)

Implicit None 

Real(dp), Intent(in) :: m_in 
Real(dp), Intent(in) :: deltaM 
Integer, Intent(in) :: i1 
Real(dp),Intent(in) :: g1input,g2input,g3input,ftriinput,mu12input,mu22input,mu32input,Vninput,              & 
& v1input,v2input

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

Real(dp) :: g1,g2,g3,ftri,mu12,mu22,mu32,Vn,v1,v2

Complex(dp) :: l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,hll1(3,3),hdp11(3),hd1(3),hdtp11(2),              & 
& hdt1(2),hup11(3),hUp1,hdp1(3),hd2(3),hdtp1(2),hdt2(2),hup21(3),hUp2,hd3(3),            & 
& hdt3(2),hu11(3),h12(3),hU1,hU2

Complex(dp),Intent(out) :: cplcFdFdAhL(5,5,3),cplcFdFdAhR(5,5,3),cplcFdFdDpmL(5,5,2),cplcFdFdDpmR(5,5,2),        & 
& cplcFdFdhhL(5,5,3),cplcFdFdhhR(5,5,3),cplcFdFdVZL(5,5),cplcFdFdVZR(5,5),               & 
& cplcFdFdVZpL(5,5),cplcFdFdVZpR(5,5),cplcFdFdcDpmL(5,5,2),cplcFdFdcDpmR(5,5,2),         & 
& cplcFdFuHpmL(5,4,4),cplcFdFuHpmR(5,4,4),cplcFdFucVWpL(5,4),cplcFdFucVWpR(5,4),         & 
& cplcFdFucVXpL(5,4),cplcFdFucVXpR(5,4)

Integer :: i2, i3, gt1, gt2, gt3, kont 
Real(dp) :: MAh(3),MAh2(3),MDpm(2),MDpm2(2),MFd(5),MFd2(5),MFe(3),MFe2(3),MFu(4),MFu2(4),         & 
& Mhh(3),Mhh2(3),MHpm(4),MHpm2(4),MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,TW

Complex(dp) :: Ud(5,5),Ue(3,3),Uu(4,4),Vd(5,5),Ve(3,3),Vu(4,4),ZA(3,3),ZH(3,3),ZP(4,4),              & 
& ZW(4,4),zy(2,2),ZZ(3,3)

Real(dp) :: gSM(11), sinW2, dt, tz, Qin 
Iname = Iname + 1 
NameOfUnit(Iname) = 'Couplings_Fd_2B'
 
sinW2=1._dp-mW2/mZ2 
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
Qin=sqrt(getRenormalizationScale()) 
Call SolveTadpoleEquations(g1,g2,g3,l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,              & 
& hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,hUp2,hd3,              & 
& hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,Vn,v1,v2,(/ ZeroC, ZeroC, ZeroC /))

! --- Calculate running tree-level masses for loop induced couplings and Quark mixing matrices --- 
Call TreeMasses(MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,MFe2,MFu,MFu2,Mhh,Mhh2,              & 
& MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,TW,Ud,Ue,Uu,Vd,Ve,Vu,             & 
& ZA,ZH,ZP,ZW,zy,ZZ,Vn,v1,v2,g1,g2,g3,l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,               & 
& hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,hUp2,hd3,              & 
& hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,.True.,kont)

If (ExternalZfactors) Then 
! --- Use the 1-loop mixing matrices calculated at M_SUSY in the vertices --- 
ZA = ZAinput 
ZH = ZHinput 
ZP = ZPinput 
ZW = ZWinput 
zy = zyinput 
ZZ = ZZinput 
End if 
If (PoleMassesInLoops) Then 
! --- Use the pole masses --- 
MAh = MAhinput 
MAh2 = MAh2input 
MDpm = MDpminput 
MDpm2 = MDpm2input 
MFd = MFdinput 
MFd2 = MFd2input 
MFe = MFeinput 
MFe2 = MFe2input 
MFu = MFuinput 
MFu2 = MFu2input 
Mhh = Mhhinput 
Mhh2 = Mhh2input 
MHpm = MHpminput 
MHpm2 = MHpm2input 
MVWp = MVWpinput 
MVWp2 = MVWp2input 
MVXp = MVXpinput 
MVXp2 = MVXp2input 
MVZ = MVZinput 
MVZ2 = MVZ2input 
MVZp = MVZpinput 
MVZp2 = MVZp2input 
End if 
cplcFdFdAhL = 0._dp 
cplcFdFdAhR = 0._dp 
Do gt1 = 1, 5
 Do gt2 = 1, 5
  Do gt3 = 1, 3
Call CouplingcFdFdAhT(gt1,gt2,gt3,hdp11,hd1,hdtp11,hdt1,hdp1,hd2,hdtp1,               & 
& hdt2,hd3,hdt3,ZA,Vd,Ud,cplcFdFdAhL(gt1,gt2,gt3),cplcFdFdAhR(gt1,gt2,gt3))

  End Do 
 End Do 
End Do 


cplcFdFdDpmL = 0._dp 
cplcFdFdDpmR = 0._dp 
Do gt1 = 1, 5
 Do gt2 = 1, 5
  Do gt3 = 1, 2
Call CouplingcFdFdDpmT(gt1,gt2,gt3,hdp11,hd1,hdtp11,hdt1,hdp1,hd2,hdtp1,              & 
& hdt2,zy,Vd,Ud,cplcFdFdDpmL(gt1,gt2,gt3),cplcFdFdDpmR(gt1,gt2,gt3))

  End Do 
 End Do 
End Do 


cplcFdFdhhL = 0._dp 
cplcFdFdhhR = 0._dp 
Do gt1 = 1, 5
 Do gt2 = 1, 5
  Do gt3 = 1, 3
Call CouplingcFdFdhhT(gt1,gt2,gt3,hdp11,hd1,hdtp11,hdt1,hdp1,hd2,hdtp1,               & 
& hdt2,hd3,hdt3,ZH,Vd,Ud,cplcFdFdhhL(gt1,gt2,gt3),cplcFdFdhhR(gt1,gt2,gt3))

  End Do 
 End Do 
End Do 


cplcFdFdcDpmL = 0._dp 
cplcFdFdcDpmR = 0._dp 
Do gt1 = 1, 5
 Do gt2 = 1, 5
  Do gt3 = 1, 2
Call CouplingcFdFdcDpmT(gt1,gt2,gt3,hdp11,hd1,hdtp11,hdt1,hdp1,hd2,hdtp1,             & 
& hdt2,zy,Vd,Ud,cplcFdFdcDpmL(gt1,gt2,gt3),cplcFdFdcDpmR(gt1,gt2,gt3))

  End Do 
 End Do 
End Do 


cplcFdFuHpmL = 0._dp 
cplcFdFuHpmR = 0._dp 
Do gt1 = 1, 5
 Do gt2 = 1, 4
  Do gt3 = 1, 4
Call CouplingcFdFuHpmT(gt1,gt2,gt3,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,             & 
& hd2,hdtp1,hdt2,hup21,hUp2,hd3,hdt3,hu11,h12,hU1,hU2,ZP,Vd,Ud,Vu,Uu,cplcFdFuHpmL(gt1,gt2,gt3)& 
& ,cplcFdFuHpmR(gt1,gt2,gt3))

  End Do 
 End Do 
End Do 


cplcFdFdVZL = 0._dp 
cplcFdFdVZR = 0._dp 
Do gt1 = 1, 5
 Do gt2 = 1, 5
Call CouplingcFdFdVZT(gt1,gt2,g1,g2,ZZ,Vd,cplcFdFdVZL(gt1,gt2),cplcFdFdVZR(gt1,gt2))

 End Do 
End Do 


cplcFdFdVZpL = 0._dp 
cplcFdFdVZpR = 0._dp 
Do gt1 = 1, 5
 Do gt2 = 1, 5
Call CouplingcFdFdVZpT(gt1,gt2,g1,g2,ZZ,Vd,cplcFdFdVZpL(gt1,gt2),cplcFdFdVZpR(gt1,gt2))

 End Do 
End Do 


cplcFdFucVWpL = 0._dp 
cplcFdFucVWpR = 0._dp 
Do gt1 = 1, 5
 Do gt2 = 1, 4
Call CouplingcFdFucVWpT(gt1,gt2,g2,Vd,Vu,cplcFdFucVWpL(gt1,gt2),cplcFdFucVWpR(gt1,gt2))

 End Do 
End Do 


cplcFdFucVXpL = 0._dp 
cplcFdFucVXpR = 0._dp 
Do gt1 = 1, 5
 Do gt2 = 1, 4
Call CouplingcFdFucVXpT(gt1,gt2,g2,Vd,Vu,cplcFdFucVXpL(gt1,gt2),cplcFdFucVXpR(gt1,gt2))

 End Do 
End Do 


Iname = Iname - 1 
 
End subroutine CouplingsFor_Fd_decays_2B
 
Subroutine CouplingsFor_hh_decays_2B(m_in,i1,MAhinput,MAh2input,MDpminput,            & 
& MDpm2input,MFdinput,MFd2input,MFeinput,MFe2input,MFuinput,MFu2input,Mhhinput,          & 
& Mhh2input,MHpminput,MHpm2input,MVWpinput,MVWp2input,MVXpinput,MVXp2input,              & 
& MVZinput,MVZ2input,MVZpinput,MVZp2input,TWinput,Udinput,Ueinput,Uuinput,               & 
& Vdinput,Veinput,Vuinput,ZAinput,ZHinput,ZPinput,ZWinput,zyinput,ZZinput,               & 
& g1input,g2input,g3input,l1input,l12input,l13input,l12tinput,l13tinput,l2input,         & 
& l23input,l23tinput,l3input,hll1input,hdp11input,hd1input,hdtp11input,hdt1input,        & 
& hup11input,hUp1input,hdp1input,hd2input,hdtp1input,hdt2input,hup21input,               & 
& hUp2input,hd3input,hdt3input,hu11input,h12input,hU1input,hU2input,ftriinput,           & 
& mu12input,mu22input,mu32input,Vninput,v1input,v2input,cplHiggsPP,cplHiggsGG,           & 
& cplHiggsZZvirt,cplHiggsWWvirt,cplAhAhhh,cplAhhhhh,cplAhhhVZ,cplAhhhVZp,cplDpmhhcDpm,   & 
& cplcFdFdhhL,cplcFdFdhhR,cplcFeFehhL,cplcFeFehhR,cplcFuFuhhL,cplcFuFuhhR,               & 
& cplhhhhhh,cplhhHpmVWp,cplhhHpmVXp,cplhhHpmcHpm,cplhhcVWpVWp,cplhhcVXpVXp,              & 
& cplhhVZVZ,cplhhVZVZp,cplhhVZpVZp,deltaM)

Implicit None 

Real(dp), Intent(in) :: m_in 
Real(dp), Intent(in) :: deltaM 
Integer, Intent(in) :: i1 
Real(dp),Intent(in) :: g1input,g2input,g3input,ftriinput,mu12input,mu22input,mu32input,Vninput,              & 
& v1input,v2input

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

Real(dp) :: g1,g2,g3,ftri,mu12,mu22,mu32,Vn,v1,v2

Complex(dp) :: l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,hll1(3,3),hdp11(3),hd1(3),hdtp11(2),              & 
& hdt1(2),hup11(3),hUp1,hdp1(3),hd2(3),hdtp1(2),hdt2(2),hup21(3),hUp2,hd3(3),            & 
& hdt3(2),hu11(3),h12(3),hU1,hU2

Complex(dp),Intent(out) :: cplHiggsPP(3),cplHiggsGG(3),cplHiggsZZvirt(3),cplHiggsWWvirt(3),cplAhAhhh(3,3,3),     & 
& cplAhhhhh(3,3,3),cplAhhhVZ(3,3),cplAhhhVZp(3,3),cplDpmhhcDpm(2,3,2),cplcFdFdhhL(5,5,3),& 
& cplcFdFdhhR(5,5,3),cplcFeFehhL(3,3,3),cplcFeFehhR(3,3,3),cplcFuFuhhL(4,4,3),           & 
& cplcFuFuhhR(4,4,3),cplhhhhhh(3,3,3),cplhhHpmVWp(3,4),cplhhHpmVXp(3,4),cplhhHpmcHpm(3,4,4),& 
& cplhhcVWpVWp(3),cplhhcVXpVXp(3),cplhhVZVZ(3),cplhhVZVZp(3),cplhhVZpVZp(3)

Integer :: i2, i3, gt1, gt2, gt3, kont 
Real(dp) :: MAh(3),MAh2(3),MDpm(2),MDpm2(2),MFd(5),MFd2(5),MFe(3),MFe2(3),MFu(4),MFu2(4),         & 
& Mhh(3),Mhh2(3),MHpm(4),MHpm2(4),MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,TW

Complex(dp) :: Ud(5,5),Ue(3,3),Uu(4,4),Vd(5,5),Ve(3,3),Vu(4,4),ZA(3,3),ZH(3,3),ZP(4,4),              & 
& ZW(4,4),zy(2,2),ZZ(3,3)

Complex(dp) :: ratDpm(2),ratFd(5),ratFe(3),ratFu(4),ratHpm(4),ratVWp,ratVXp

Complex(dp) :: ratPDpm(2),ratPFd(5),ratPFe(3),ratPFu(4),ratPHpm(4),ratPVWp,ratPVXp

Complex(dp) :: coup 
Real(dp) :: vev, gNLO, NLOqcd, NNLOqcd, NNNLOqcd, AlphaSQ, AlphaSQhlf 
Real(dp) :: g1SM,g2SM,g3SM,vSM
Complex(dp) ::YuSM(3,3),YdSM(3,3),YeSM(3,3)
Real(dp) :: gSM(11), sinW2, dt, tz, Qin 
Iname = Iname + 1 
NameOfUnit(Iname) = 'Couplings_hh_2B'
 
sinW2=1._dp-mW2/mZ2 
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
Qin=sqrt(getRenormalizationScale()) 
! Run always SM gauge couplings if present 
  Qin=sqrt(getRenormalizationScale()) 
  Call RunSMohdm(m_in,deltaM,g1SM,g2SM,g3SM,YuSM,YdSM,YeSM,vSM) 
   ! SM pole masses needed for diphoton/digluon rate 
   ! But only top and W play a role. 
   vSM=1/Sqrt((G_F*Sqrt(2._dp))) ! On-Shell VEV needed for loop 
   YuSM(3,3)=sqrt(2._dp)*mf_u(3)/vSM  ! On-Shell top needed in loop 
   ! Other running values kept to get H->ff correct 
Call SetMatchingConditions(g1SM,g2SM,g3SM,YuSM,YdSM,YeSM,vSM,Vn,v1,v2,g1,             & 
& g2,g3,l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,hll1,hdp11,hd1,hdtp11,hdt1,hup11,            & 
& hUp1,hdp1,hd2,hdtp1,hdt2,hup21,hUp2,hd3,hdt3,hu11,h12,hU1,hU2,ftri,mu12,               & 
& mu22,mu32,.False.)

AlphaSQhlf=g3**2/(4._dp*Pi) 
AlphaSQ=g3**2/(4._dp*Pi) 
Call SolveTadpoleEquations(g1,g2,g3,l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,              & 
& hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,hUp2,hd3,              & 
& hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,Vn,v1,v2,(/ ZeroC, ZeroC, ZeroC /))

! --- Calculate running tree-level masses for loop induced couplings and Quark mixing matrices --- 
Call TreeMasses(MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,MFe2,MFu,MFu2,Mhh,Mhh2,              & 
& MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,TW,Ud,Ue,Uu,Vd,Ve,Vu,             & 
& ZA,ZH,ZP,ZW,zy,ZZ,Vn,v1,v2,g1,g2,g3,l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,               & 
& hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,hUp2,hd3,              & 
& hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,.True.,kont)

If (ExternalZfactors) Then 
! --- Use the 1-loop mixing matrices calculated at M_SUSY in the vertices --- 
ZA = ZAinput 
ZH = ZHinput 
ZP = ZPinput 
ZW = ZWinput 
zy = zyinput 
ZZ = ZZinput 
End if 
cplAhAhhh = 0._dp 
Do gt1 = 1, 3
 Do gt2 = 1, 3
  Do gt3 = 1, 3
Call CouplingAhAhhhT(gt1,gt2,gt3,ftri,l1,l12,l13,l2,l23,l3,Vn,v1,v2,ZH,               & 
& ZA,cplAhAhhh(gt1,gt2,gt3))

  End Do 
 End Do 
End Do 


cplAhhhhh = 0._dp 
Do gt1 = 1, 3
 Do gt2 = 1, 3
  Do gt3 = 1, 3
Call CouplingAhhhhhT(gt1,gt2,gt3,ftri,ZH,ZA,cplAhhhhh(gt1,gt2,gt3))

  End Do 
 End Do 
End Do 


cplDpmhhcDpm = 0._dp 
Do gt1 = 1, 2
 Do gt2 = 1, 3
  Do gt3 = 1, 2
Call CouplingDpmhhcDpmT(gt1,gt2,gt3,ftri,l1,l12,l13,l12t,l2,l23,Vn,v1,v2,             & 
& ZH,zy,cplDpmhhcDpm(gt1,gt2,gt3))

  End Do 
 End Do 
End Do 


cplhhhhhh = 0._dp 
Do gt1 = 1, 3
 Do gt2 = 1, 3
  Do gt3 = 1, 3
Call CouplinghhhhhhT(gt1,gt2,gt3,ftri,l1,l12,l13,l2,l23,l3,Vn,v1,v2,ZH,               & 
& cplhhhhhh(gt1,gt2,gt3))

  End Do 
 End Do 
End Do 


cplhhHpmcHpm = 0._dp 
Do gt1 = 1, 3
 Do gt2 = 1, 4
  Do gt3 = 1, 4
Call CouplinghhHpmcHpmT(gt1,gt2,gt3,ftri,l1,l12,l13,l13t,l2,l23,l23t,l3,              & 
& Vn,v1,v2,ZH,ZP,cplhhHpmcHpm(gt1,gt2,gt3))

  End Do 
 End Do 
End Do 


cplAhhhVZ = 0._dp 
Do gt1 = 1, 3
 Do gt2 = 1, 3
Call CouplingAhhhVZT(gt1,gt2,g1,g2,ZZ,ZH,ZA,cplAhhhVZ(gt1,gt2))

 End Do 
End Do 


cplAhhhVZp = 0._dp 
Do gt1 = 1, 3
 Do gt2 = 1, 3
Call CouplingAhhhVZpT(gt1,gt2,g1,g2,ZZ,ZH,ZA,cplAhhhVZp(gt1,gt2))

 End Do 
End Do 


cplhhHpmVWp = 0._dp 
Do gt1 = 1, 3
 Do gt2 = 1, 4
Call CouplinghhHpmVWpT(gt1,gt2,g2,ZH,ZP,cplhhHpmVWp(gt1,gt2))

 End Do 
End Do 


cplhhHpmVXp = 0._dp 
Do gt1 = 1, 3
 Do gt2 = 1, 4
Call CouplinghhHpmVXpT(gt1,gt2,g2,ZH,ZP,cplhhHpmVXp(gt1,gt2))

 End Do 
End Do 


cplhhcVWpVWp = 0._dp 
Do gt1 = 1, 3
Call CouplinghhcVWpVWpT(gt1,g2,v1,v2,ZH,cplhhcVWpVWp(gt1))

End Do 


cplhhcVXpVXp = 0._dp 
Do gt1 = 1, 3
Call CouplinghhcVXpVXpT(gt1,g2,Vn,v2,ZH,cplhhcVXpVXp(gt1))

End Do 


cplhhVZVZ = 0._dp 
Do gt1 = 1, 3
Call CouplinghhVZVZT(gt1,g1,g2,Vn,v1,v2,ZZ,ZH,cplhhVZVZ(gt1))

End Do 


cplhhVZVZp = 0._dp 
Do gt1 = 1, 3
Call CouplinghhVZVZpT(gt1,g1,g2,Vn,v1,v2,ZZ,ZH,cplhhVZVZp(gt1))

End Do 


cplhhVZpVZp = 0._dp 
Do gt1 = 1, 3
Call CouplinghhVZpVZpT(gt1,g1,g2,Vn,v1,v2,ZZ,ZH,cplhhVZpVZp(gt1))

End Do 


cplcFdFdhhL = 0._dp 
cplcFdFdhhR = 0._dp 
Do gt1 = 1, 5
 Do gt2 = 1, 5
  Do gt3 = 1, 3
Call CouplingcFdFdhhT(gt1,gt2,gt3,hdp11,hd1,hdtp11,hdt1,hdp1,hd2,hdtp1,               & 
& hdt2,hd3,hdt3,ZH,Vd,Ud,cplcFdFdhhL(gt1,gt2,gt3),cplcFdFdhhR(gt1,gt2,gt3))

  End Do 
 End Do 
End Do 


cplcFeFehhL = 0._dp 
cplcFeFehhR = 0._dp 
Do gt1 = 1, 3
 Do gt2 = 1, 3
  Do gt3 = 1, 3
Call CouplingcFeFehhT(gt1,gt2,gt3,hll1,ZH,Ve,Ue,cplcFeFehhL(gt1,gt2,gt3)              & 
& ,cplcFeFehhR(gt1,gt2,gt3))

  End Do 
 End Do 
End Do 


cplcFuFuhhL = 0._dp 
cplcFuFuhhR = 0._dp 
Do gt1 = 1, 4
 Do gt2 = 1, 4
  Do gt3 = 1, 3
Call CouplingcFuFuhhT(gt1,gt2,gt3,hup11,hUp1,hup21,hUp2,hu11,h12,hU1,hU2,             & 
& ZH,Vu,Uu,cplcFuFuhhL(gt1,gt2,gt3),cplcFuFuhhR(gt1,gt2,gt3))

  End Do 
 End Do 
End Do 


vev=1/Sqrt((G_F*Sqrt(2._dp)))
cplHiggsWWvirt = cplhhcVWpVWp/vev 
cplHiggsZZvirt = cplhhVZVZ*Sqrt(7._dp/12._dp-10._dp/9._dp*Sin(TW)**2+40._dp/27._dp*Sin(TW)**4)/vev 
 

!----------------------------------------------------
! Coupling ratios for HiggsBounds 
!----------------------------------------------------
 
Do i2=1, 5
rHB_S_S_Fd(i1,i2) = Abs((cplcFdFdhhL(i2,i2,i1)+cplcFdFdhhR(i2,i2,i1))*vev/(2._dp*MFd(i2))) 
rHB_S_P_Fd(i1,i2) = Abs((cplcFdFdhhL(i2,i2,i1)-cplcFdFdhhR(i2,i2,i1))*vev/(2._dp*MFd(i2))) 
End Do 
Do i2=1, 3
rHB_S_S_Fe(i1,i2) = Abs((cplcFeFehhL(i2,i2,i1)+cplcFeFehhR(i2,i2,i1))*vev/(2._dp*MFe(i2))) 
rHB_S_P_Fe(i1,i2) = Abs((cplcFeFehhL(i2,i2,i1)-cplcFeFehhR(i2,i2,i1))*vev/(2._dp*MFe(i2))) 
End Do 
Do i2=1, 4
rHB_S_S_Fu(i1,i2) = Abs((cplcFuFuhhL(i2,i2,i1)+cplcFuFuhhR(i2,i2,i1))*vev/(2._dp*MFu(i2))) 
rHB_S_P_Fu(i1,i2) = Abs((cplcFuFuhhL(i2,i2,i1)-cplcFuFuhhR(i2,i2,i1))*vev/(2._dp*MFu(i2))) 
End Do 
rHB_S_VWp(i1) = Abs(-0.5_dp*cplhhcVWpVWp(i1)*vev/MVWp2) 
rHB_S_VZ(i1) = Abs(-0.5_dp*cplhhVZVZ(i1)*vev/MVZ2) 
If (PoleMassesInLoops) Then 
! --- Use the pole masses --- 
MAh = MAhinput 
MAh2 = MAh2input 
MDpm = MDpminput 
MDpm2 = MDpm2input 
MFd = MFdinput 
MFd2 = MFd2input 
MFe = MFeinput 
MFe2 = MFe2input 
MFu = MFuinput 
MFu2 = MFu2input 
Mhh = Mhhinput 
Mhh2 = Mhh2input 
MHpm = MHpminput 
MHpm2 = MHpm2input 
MVWp = MVWpinput 
MVWp2 = MVWp2input 
MVXp = MVXpinput 
MVXp2 = MVXp2input 
MVZ = MVZinput 
MVZ2 = MVZ2input 
MVZp = MVZpinput 
MVZp2 = MVZp2input 
End if 
!----------------------------------------------------
! Scalar Higgs coupling ratios 
!----------------------------------------------------
 
Do i2=1, 2
ratDpm(i2) = 0.5_dp*cplDpmhhcDpm(i2,i1,i2)*vev/MDpm2(i2) 
End Do 
Do i2=1, 5
ratFd(i2) = cplcFdFdhhL(i2,i2,i1)*1._dp*vev/MFd(i2) 
End Do 
Do i2=1, 3
ratFe(i2) = cplcFeFehhL(i2,i2,i1)*1._dp*vev/MFe(i2) 
End Do 
Do i2=1, 4
ratFu(i2) = cplcFuFuhhL(i2,i2,i1)*1._dp*vev/MFu(i2) 
End Do 
Do i2=1, 4
ratHpm(i2) = 0.5_dp*cplhhHpmcHpm(i1,i2,i2)*vev/MHpm2(i2) 
End Do 
ratVWp = -0.5_dp*cplhhcVWpVWp(i1)*vev/MVWp2 
ratVXp = -0.5_dp*cplhhcVXpVXp(i1)*vev/MVXp2 
If (HigherOrderDiboson) Then 
  gNLO = Sqrt(AlphaSQhlf*4._dp*Pi) 
Else  
  gNLO = -1._dp 
End if 
Call CoupHiggsToPhoton(m_in,i1,ratDpm,ratFd,ratFe,ratFu,ratHpm,ratVWp,ratVXp,         & 
& MDpm,MFd,MFe,MFu,MHpm,MVWp,MVXp,gNLO,coup)

cplHiggsPP(i1) = coup*Alpha 
CoupHPP(i1) = coup 
Call CoupHiggsToPhotonSM(m_in,MDpm,MFd,MFe,MFu,MHpm,MVWp,MVXp,gNLO,coup)

ratioPP(i1) = Abs(cplHiggsPP(i1)/(coup*Alpha)) 
  gNLO = -1._dp 
Call CoupHiggsToGluon(m_in,i1,ratFd,ratFu,MFd,MFu,gNLO,coup)

cplHiggsGG(i1) = coup*AlphaSQ 
CoupHGG(i1) = coup 
Call CoupHiggsToGluonSM(m_in,MFd,MFu,gNLO,coup)

If (HigherOrderDiboson) Then 
  NLOqcd = 12._dp*oo48pi2*(95._dp/4._dp - 7._dp/6._dp*NFlav(m_in))*g3**2 
  NNLOqcd = 0.0005785973353112832_dp*(410.52103034222284_dp - 52.326413200014684_dp*NFlav(m_in)+NFlav(m_in)**2 & 
 & +(2.6337085360233763_dp +0.7392866066030529_dp *NFlav(m_in))*Log(m_in**2/mf_u(3)**2))*g3**4 
  NNNLOqcd = 0.00017781840290519607_dp*(42.74607514668917_dp + 11.191050460173795_dp*Log(m_in**2/mf_u(3)**2) + Log(m_in**2/mf_u(3)**2)**2)*g3**6 
Else 
  NLOqcd = 0._dp 
  NNLOqcd = 0._dp 
  NNNLOqcd = 0._dp 
End if 
coup = coup*Sqrt(1._dp + NLOqcd+NNLOqcd+NNNLOqcd) 
cplHiggsGG(i1) = cplHiggsGG(i1)*Sqrt(1._dp + NLOqcd+NNLOqcd+NNNLOqcd) 
CoupHGG(i1)=cplHiggsGG(i1) 
ratioGG(i1) = Abs(cplHiggsGG(i1)/(coup*AlphaSQ)) 
If (i1.eq.1) Then 
CPL_A_H_Z = Abs(cplAhhhVZ**2/(g2**2/(cos(TW)**2*4._dp)))
CPL_H_H_Z = 0._dp 
End if 
cplAhAhhh = 0._dp 
Do gt1 = 1, 3
 Do gt2 = 1, 3
  Do gt3 = 1, 3
Call CouplingAhAhhhT(gt1,gt2,gt3,ftri,l1,l12,l13,l2,l23,l3,Vn,v1,v2,ZH,               & 
& ZA,cplAhAhhh(gt1,gt2,gt3))

  End Do 
 End Do 
End Do 


cplAhhhhh = 0._dp 
Do gt1 = 1, 3
 Do gt2 = 1, 3
  Do gt3 = 1, 3
Call CouplingAhhhhhT(gt1,gt2,gt3,ftri,ZH,ZA,cplAhhhhh(gt1,gt2,gt3))

  End Do 
 End Do 
End Do 


cplDpmhhcDpm = 0._dp 
Do gt1 = 1, 2
 Do gt2 = 1, 3
  Do gt3 = 1, 2
Call CouplingDpmhhcDpmT(gt1,gt2,gt3,ftri,l1,l12,l13,l12t,l2,l23,Vn,v1,v2,             & 
& ZH,zy,cplDpmhhcDpm(gt1,gt2,gt3))

  End Do 
 End Do 
End Do 


cplhhhhhh = 0._dp 
Do gt1 = 1, 3
 Do gt2 = 1, 3
  Do gt3 = 1, 3
Call CouplinghhhhhhT(gt1,gt2,gt3,ftri,l1,l12,l13,l2,l23,l3,Vn,v1,v2,ZH,               & 
& cplhhhhhh(gt1,gt2,gt3))

  End Do 
 End Do 
End Do 


cplhhHpmcHpm = 0._dp 
Do gt1 = 1, 3
 Do gt2 = 1, 4
  Do gt3 = 1, 4
Call CouplinghhHpmcHpmT(gt1,gt2,gt3,ftri,l1,l12,l13,l13t,l2,l23,l23t,l3,              & 
& Vn,v1,v2,ZH,ZP,cplhhHpmcHpm(gt1,gt2,gt3))

  End Do 
 End Do 
End Do 


cplAhhhVZ = 0._dp 
Do gt1 = 1, 3
 Do gt2 = 1, 3
Call CouplingAhhhVZT(gt1,gt2,g1,g2,ZZ,ZH,ZA,cplAhhhVZ(gt1,gt2))

 End Do 
End Do 


cplAhhhVZp = 0._dp 
Do gt1 = 1, 3
 Do gt2 = 1, 3
Call CouplingAhhhVZpT(gt1,gt2,g1,g2,ZZ,ZH,ZA,cplAhhhVZp(gt1,gt2))

 End Do 
End Do 


cplhhHpmVWp = 0._dp 
Do gt1 = 1, 3
 Do gt2 = 1, 4
Call CouplinghhHpmVWpT(gt1,gt2,g2,ZH,ZP,cplhhHpmVWp(gt1,gt2))

 End Do 
End Do 


cplhhHpmVXp = 0._dp 
Do gt1 = 1, 3
 Do gt2 = 1, 4
Call CouplinghhHpmVXpT(gt1,gt2,g2,ZH,ZP,cplhhHpmVXp(gt1,gt2))

 End Do 
End Do 


cplhhcVWpVWp = 0._dp 
Do gt1 = 1, 3
Call CouplinghhcVWpVWpT(gt1,g2,v1,v2,ZH,cplhhcVWpVWp(gt1))

End Do 


cplhhcVXpVXp = 0._dp 
Do gt1 = 1, 3
Call CouplinghhcVXpVXpT(gt1,g2,Vn,v2,ZH,cplhhcVXpVXp(gt1))

End Do 


cplhhVZVZ = 0._dp 
Do gt1 = 1, 3
Call CouplinghhVZVZT(gt1,g1,g2,Vn,v1,v2,ZZ,ZH,cplhhVZVZ(gt1))

End Do 


cplhhVZVZp = 0._dp 
Do gt1 = 1, 3
Call CouplinghhVZVZpT(gt1,g1,g2,Vn,v1,v2,ZZ,ZH,cplhhVZVZp(gt1))

End Do 


cplhhVZpVZp = 0._dp 
Do gt1 = 1, 3
Call CouplinghhVZpVZpT(gt1,g1,g2,Vn,v1,v2,ZZ,ZH,cplhhVZpVZp(gt1))

End Do 


cplcFdFdhhL = 0._dp 
cplcFdFdhhR = 0._dp 
Do gt1 = 1, 5
 Do gt2 = 1, 5
  Do gt3 = 1, 3
Call CouplingcFdFdhhT(gt1,gt2,gt3,hdp11,hd1,hdtp11,hdt1,hdp1,hd2,hdtp1,               & 
& hdt2,hd3,hdt3,ZH,Vd,Ud,cplcFdFdhhL(gt1,gt2,gt3),cplcFdFdhhR(gt1,gt2,gt3))

  End Do 
 End Do 
End Do 


cplcFeFehhL = 0._dp 
cplcFeFehhR = 0._dp 
Do gt1 = 1, 3
 Do gt2 = 1, 3
  Do gt3 = 1, 3
Call CouplingcFeFehhT(gt1,gt2,gt3,hll1,ZH,Ve,Ue,cplcFeFehhL(gt1,gt2,gt3)              & 
& ,cplcFeFehhR(gt1,gt2,gt3))

  End Do 
 End Do 
End Do 


cplcFuFuhhL = 0._dp 
cplcFuFuhhR = 0._dp 
Do gt1 = 1, 4
 Do gt2 = 1, 4
  Do gt3 = 1, 3
Call CouplingcFuFuhhT(gt1,gt2,gt3,hup11,hUp1,hup21,hUp2,hu11,h12,hU1,hU2,             & 
& ZH,Vu,Uu,cplcFuFuhhL(gt1,gt2,gt3),cplcFuFuhhR(gt1,gt2,gt3))

  End Do 
 End Do 
End Do 


Iname = Iname - 1 
 
End subroutine CouplingsFor_hh_decays_2B
 
Subroutine CouplingsFor_Ah_decays_2B(m_in,i1,MAhinput,MAh2input,MDpminput,            & 
& MDpm2input,MFdinput,MFd2input,MFeinput,MFe2input,MFuinput,MFu2input,Mhhinput,          & 
& Mhh2input,MHpminput,MHpm2input,MVWpinput,MVWp2input,MVXpinput,MVXp2input,              & 
& MVZinput,MVZ2input,MVZpinput,MVZp2input,TWinput,Udinput,Ueinput,Uuinput,               & 
& Vdinput,Veinput,Vuinput,ZAinput,ZHinput,ZPinput,ZWinput,zyinput,ZZinput,               & 
& g1input,g2input,g3input,l1input,l12input,l13input,l12tinput,l13tinput,l2input,         & 
& l23input,l23tinput,l3input,hll1input,hdp11input,hd1input,hdtp11input,hdt1input,        & 
& hup11input,hUp1input,hdp1input,hd2input,hdtp1input,hdt2input,hup21input,               & 
& hUp2input,hd3input,hdt3input,hu11input,h12input,hU1input,hU2input,ftriinput,           & 
& mu12input,mu22input,mu32input,Vninput,v1input,v2input,cplPseudoHiggsPP,cplPseudoHiggsGG,& 
& cplAhAhAh,cplAhAhhh,cplAhDpmcDpm,cplcFdFdAhL,cplcFdFdAhR,cplcFeFeAhL,cplcFeFeAhR,      & 
& cplcFuFuAhL,cplcFuFuAhR,cplAhhhhh,cplAhhhVZ,cplAhhhVZp,cplAhHpmVWp,cplAhHpmVXp,        & 
& cplAhHpmcHpm,deltaM)

Implicit None 

Real(dp), Intent(in) :: m_in 
Real(dp), Intent(in) :: deltaM 
Integer, Intent(in) :: i1 
Real(dp),Intent(in) :: g1input,g2input,g3input,ftriinput,mu12input,mu22input,mu32input,Vninput,              & 
& v1input,v2input

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

Real(dp) :: g1,g2,g3,ftri,mu12,mu22,mu32,Vn,v1,v2

Complex(dp) :: l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,hll1(3,3),hdp11(3),hd1(3),hdtp11(2),              & 
& hdt1(2),hup11(3),hUp1,hdp1(3),hd2(3),hdtp1(2),hdt2(2),hup21(3),hUp2,hd3(3),            & 
& hdt3(2),hu11(3),h12(3),hU1,hU2

Complex(dp),Intent(out) :: cplPseudoHiggsPP(3),cplPseudoHiggsGG(3),cplAhAhAh(3,3,3),cplAhAhhh(3,3,3),            & 
& cplAhDpmcDpm(3,2,2),cplcFdFdAhL(5,5,3),cplcFdFdAhR(5,5,3),cplcFeFeAhL(3,3,3),          & 
& cplcFeFeAhR(3,3,3),cplcFuFuAhL(4,4,3),cplcFuFuAhR(4,4,3),cplAhhhhh(3,3,3),             & 
& cplAhhhVZ(3,3),cplAhhhVZp(3,3),cplAhHpmVWp(3,4),cplAhHpmVXp(3,4),cplAhHpmcHpm(3,4,4)

Integer :: i2, i3, gt1, gt2, gt3, kont 
Real(dp) :: MAh(3),MAh2(3),MDpm(2),MDpm2(2),MFd(5),MFd2(5),MFe(3),MFe2(3),MFu(4),MFu2(4),         & 
& Mhh(3),Mhh2(3),MHpm(4),MHpm2(4),MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,TW

Complex(dp) :: Ud(5,5),Ue(3,3),Uu(4,4),Vd(5,5),Ve(3,3),Vu(4,4),ZA(3,3),ZH(3,3),ZP(4,4),              & 
& ZW(4,4),zy(2,2),ZZ(3,3)

Complex(dp) :: ratDpm(2),ratFd(5),ratFe(3),ratFu(4),ratHpm(4),ratVWp,ratVXp

Complex(dp) :: ratPDpm(2),ratPFd(5),ratPFe(3),ratPFu(4),ratPHpm(4),ratPVWp,ratPVXp

Complex(dp) :: coup 
Real(dp) :: vev, gNLO, NLOqcd, NNLOqcd, NNNLOqcd, AlphaSQ, AlphaSQhlf 
Real(dp) :: g1SM,g2SM,g3SM,vSM
Complex(dp) ::YuSM(3,3),YdSM(3,3),YeSM(3,3)
Real(dp) :: gSM(11), sinW2, dt, tz, Qin 
Iname = Iname + 1 
NameOfUnit(Iname) = 'Couplings_Ah_2B'
 
sinW2=1._dp-mW2/mZ2 
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
Qin=sqrt(getRenormalizationScale()) 
! Run always SM gauge couplings if present 
  Qin=sqrt(getRenormalizationScale()) 
  Call RunSMohdm(m_in,deltaM,g1SM,g2SM,g3SM,YuSM,YdSM,YeSM,vSM) 
   ! SM pole masses needed for diphoton/digluon rate 
   ! But only top and W play a role. 
   vSM=1/Sqrt((G_F*Sqrt(2._dp))) ! On-Shell VEV needed for loop 
   YuSM(3,3)=sqrt(2._dp)*mf_u(3)/vSM  ! On-Shell top needed in loop 
   ! Other running values kept to get H->ff correct 
Call SetMatchingConditions(g1SM,g2SM,g3SM,YuSM,YdSM,YeSM,vSM,Vn,v1,v2,g1,             & 
& g2,g3,l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,hll1,hdp11,hd1,hdtp11,hdt1,hup11,            & 
& hUp1,hdp1,hd2,hdtp1,hdt2,hup21,hUp2,hd3,hdt3,hu11,h12,hU1,hU2,ftri,mu12,               & 
& mu22,mu32,.False.)

AlphaSQhlf=g3**2/(4._dp*Pi) 
AlphaSQ=g3**2/(4._dp*Pi) 
Call SolveTadpoleEquations(g1,g2,g3,l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,              & 
& hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,hUp2,hd3,              & 
& hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,Vn,v1,v2,(/ ZeroC, ZeroC, ZeroC /))

! --- Calculate running tree-level masses for loop induced couplings and Quark mixing matrices --- 
Call TreeMasses(MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,MFe2,MFu,MFu2,Mhh,Mhh2,              & 
& MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,TW,Ud,Ue,Uu,Vd,Ve,Vu,             & 
& ZA,ZH,ZP,ZW,zy,ZZ,Vn,v1,v2,g1,g2,g3,l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,               & 
& hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,hUp2,hd3,              & 
& hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,.True.,kont)

If (ExternalZfactors) Then 
! --- Use the 1-loop mixing matrices calculated at M_SUSY in the vertices --- 
ZA = ZAinput 
ZH = ZHinput 
ZP = ZPinput 
ZW = ZWinput 
zy = zyinput 
ZZ = ZZinput 
End if 
cplAhAhAh = 0._dp 
Do gt1 = 1, 3
 Do gt2 = 1, 3
  Do gt3 = 1, 3
Call CouplingAhAhAhT(gt1,gt2,gt3,ftri,ZA,cplAhAhAh(gt1,gt2,gt3))

  End Do 
 End Do 
End Do 


cplAhAhhh = 0._dp 
Do gt1 = 1, 3
 Do gt2 = 1, 3
  Do gt3 = 1, 3
Call CouplingAhAhhhT(gt1,gt2,gt3,ftri,l1,l12,l13,l2,l23,l3,Vn,v1,v2,ZH,               & 
& ZA,cplAhAhhh(gt1,gt2,gt3))

  End Do 
 End Do 
End Do 


cplAhDpmcDpm = 0._dp 
Do gt1 = 1, 3
 Do gt2 = 1, 2
  Do gt3 = 1, 2
Call CouplingAhDpmcDpmT(gt1,gt2,gt3,ftri,l12t,Vn,v1,ZA,zy,cplAhDpmcDpm(gt1,gt2,gt3))

  End Do 
 End Do 
End Do 


cplAhhhhh = 0._dp 
Do gt1 = 1, 3
 Do gt2 = 1, 3
  Do gt3 = 1, 3
Call CouplingAhhhhhT(gt1,gt2,gt3,ftri,ZH,ZA,cplAhhhhh(gt1,gt2,gt3))

  End Do 
 End Do 
End Do 


cplAhHpmcHpm = 0._dp 
Do gt1 = 1, 3
 Do gt2 = 1, 4
  Do gt3 = 1, 4
Call CouplingAhHpmcHpmT(gt1,gt2,gt3,ftri,l13t,l23t,Vn,v1,v2,ZA,ZP,cplAhHpmcHpm(gt1,gt2,gt3))

  End Do 
 End Do 
End Do 


cplAhhhVZ = 0._dp 
Do gt1 = 1, 3
 Do gt2 = 1, 3
Call CouplingAhhhVZT(gt1,gt2,g1,g2,ZZ,ZH,ZA,cplAhhhVZ(gt1,gt2))

 End Do 
End Do 


cplAhhhVZp = 0._dp 
Do gt1 = 1, 3
 Do gt2 = 1, 3
Call CouplingAhhhVZpT(gt1,gt2,g1,g2,ZZ,ZH,ZA,cplAhhhVZp(gt1,gt2))

 End Do 
End Do 


cplAhHpmVWp = 0._dp 
Do gt1 = 1, 3
 Do gt2 = 1, 4
Call CouplingAhHpmVWpT(gt1,gt2,g2,ZA,ZP,cplAhHpmVWp(gt1,gt2))

 End Do 
End Do 


cplAhHpmVXp = 0._dp 
Do gt1 = 1, 3
 Do gt2 = 1, 4
Call CouplingAhHpmVXpT(gt1,gt2,g2,ZA,ZP,cplAhHpmVXp(gt1,gt2))

 End Do 
End Do 


cplcFdFdAhL = 0._dp 
cplcFdFdAhR = 0._dp 
Do gt1 = 1, 5
 Do gt2 = 1, 5
  Do gt3 = 1, 3
Call CouplingcFdFdAhT(gt1,gt2,gt3,hdp11,hd1,hdtp11,hdt1,hdp1,hd2,hdtp1,               & 
& hdt2,hd3,hdt3,ZA,Vd,Ud,cplcFdFdAhL(gt1,gt2,gt3),cplcFdFdAhR(gt1,gt2,gt3))

  End Do 
 End Do 
End Do 


cplcFeFeAhL = 0._dp 
cplcFeFeAhR = 0._dp 
Do gt1 = 1, 3
 Do gt2 = 1, 3
  Do gt3 = 1, 3
Call CouplingcFeFeAhT(gt1,gt2,gt3,hll1,ZA,Ve,Ue,cplcFeFeAhL(gt1,gt2,gt3)              & 
& ,cplcFeFeAhR(gt1,gt2,gt3))

  End Do 
 End Do 
End Do 


cplcFuFuAhL = 0._dp 
cplcFuFuAhR = 0._dp 
Do gt1 = 1, 4
 Do gt2 = 1, 4
  Do gt3 = 1, 3
Call CouplingcFuFuAhT(gt1,gt2,gt3,hup11,hUp1,hup21,hUp2,hu11,h12,hU1,hU2,             & 
& ZA,Vu,Uu,cplcFuFuAhL(gt1,gt2,gt3),cplcFuFuAhR(gt1,gt2,gt3))

  End Do 
 End Do 
End Do 


vev=1/Sqrt((G_F*Sqrt(2._dp)))
!----------------------------------------------------
! Coupling ratios for HiggsBounds 
!----------------------------------------------------
 
Do i2=1, 5
rHB_P_S_Fd(i1,i2) = 1._dp*Abs((cplcFdFdAhL(i2,i2,i1)+cplcFdFdAhR(i2,i2,i1))*vev/(2._dp*MFd(i2))) 
rHB_P_P_Fd(i1,i2) = 1._dp*Abs((cplcFdFdAhL(i2,i2,i1)-cplcFdFdAhR(i2,i2,i1))*vev/(2._dp*MFd(i2))) 
End Do 
Do i2=1, 3
rHB_P_S_Fe(i1,i2) = 1._dp*Abs((cplcFeFeAhL(i2,i2,i1)+cplcFeFeAhR(i2,i2,i1))*vev/(2._dp*MFe(i2))) 
rHB_P_P_Fe(i1,i2) = 1._dp*Abs((cplcFeFeAhL(i2,i2,i1)-cplcFeFeAhR(i2,i2,i1))*vev/(2._dp*MFe(i2))) 
End Do 
Do i2=1, 4
rHB_P_S_Fu(i1,i2) = 1._dp*Abs((cplcFuFuAhL(i2,i2,i1)+cplcFuFuAhR(i2,i2,i1))*vev/(2._dp*MFu(i2))) 
rHB_P_P_Fu(i1,i2) = 1._dp*Abs((cplcFuFuAhL(i2,i2,i1)-cplcFuFuAhR(i2,i2,i1))*vev/(2._dp*MFu(i2))) 
End Do 
If (PoleMassesInLoops) Then 
! --- Use the pole masses --- 
MAh = MAhinput 
MAh2 = MAh2input 
MDpm = MDpminput 
MDpm2 = MDpm2input 
MFd = MFdinput 
MFd2 = MFd2input 
MFe = MFeinput 
MFe2 = MFe2input 
MFu = MFuinput 
MFu2 = MFu2input 
Mhh = Mhhinput 
Mhh2 = Mhh2input 
MHpm = MHpminput 
MHpm2 = MHpm2input 
MVWp = MVWpinput 
MVWp2 = MVWp2input 
MVXp = MVXpinput 
MVXp2 = MVXp2input 
MVZ = MVZinput 
MVZ2 = MVZ2input 
MVZp = MVZpinput 
MVZp2 = MVZp2input 
End if 
!----------------------------------------------------
! Pseudo Scalar Higgs coupling ratios 
!----------------------------------------------------
 
Do i2=1, 2
ratPDpm(i2) = 0.5_dp*cplAhDpmcDpm(i1,i2,i2)*vev/MDpm2(i2) 
End Do 
Do i2=1, 5
ratPFd(i2) = cplcFdFdAhL(i2,i2,i1)*1._dp*vev/MFd(i2) 
End Do 
Do i2=1, 3
ratPFe(i2) = cplcFeFeAhL(i2,i2,i1)*1._dp*vev/MFe(i2) 
End Do 
Do i2=1, 4
ratPFu(i2) = cplcFuFuAhL(i2,i2,i1)*1._dp*vev/MFu(i2) 
End Do 
Do i2=1, 4
ratPHpm(i2) = 0.5_dp*cplAhHpmcHpm(i1,i2,i2)*vev/MHpm2(i2) 
End Do 
ratPVWp = 0._dp 
ratPVXp = 0._dp 
If (HigherOrderDiboson) Then 
  gNLO = g3 
Else  
  gNLO = -1._dp 
End if 
Call CoupPseudoHiggsToPhoton(m_in,i1,ratPDpm,ratPFd,ratPFe,ratPFu,ratPHpm,            & 
& ratPVWp,ratPVXp,MDpm,MFd,MFe,MFu,MHpm,MVWp,MVXp,gNLO,coup)

cplPseudoHiggsPP(i1) = 2._dp*coup*Alpha 
CoupAPP(i1) = 2._dp*coup 
Call CoupHiggsToPhotonSM(m_in,MDpm,MFd,MFe,MFu,MHpm,MVWp,MVXp,gNLO,coup)

ratioPPP(i1) = Abs(cplPseudoHiggsPP(i1)/(coup*oo4pi*(1._dp-mW2/mZ2)*g2**2)) 
  gNLO = -1._dp 
Call CoupPseudoHiggsToGluon(m_in,i1,ratPFd,ratPFu,MFd,MFu,gNLO,coup)

If (HigherOrderDiboson) Then 
  NLOqcd = 12._dp*oo48pi2*(97._dp/4._dp - 7._dp/6._dp*NFlav(m_in))*g3**2 
  NNLOqcd = (171.544_dp +  5._dp*Log(m_in**2/mf_u(3)**2))*g3**4/(4._dp*Pi**2)**2 
  NNNLOqcd = 0._dp 
Else 
  NLOqcd = 0._dp 
  NNLOqcd = 0._dp 
  NNNLOqcd = 0._dp 
End if 
cplPseudoHiggsGG(i1) = 2._dp*coup*AlphaSQ*Sqrt(1._dp + NLOqcd+NNLOqcd+NNNLOqcd) 
CoupAGG(i1) = 2._dp*coup*AlphaSQ*Sqrt(1._dp + NLOqcd+NNLOqcd+NNNLOqcd) 
Call CoupHiggsToGluonSM(m_in,MFd,MFu,gNLO,coup)

coup = coup*Sqrt(1._dp + NLOqcd+NNLOqcd+NNNLOqcd) 
ratioPGG(i1) = Abs(cplPseudoHiggsGG(i1)/(coup*AlphaSQ)) 

If (i1.eq.3) Then 
CPL_A_A_Z = 0._dp 
End if 
cplAhAhAh = 0._dp 
Do gt1 = 1, 3
 Do gt2 = 1, 3
  Do gt3 = 1, 3
Call CouplingAhAhAhT(gt1,gt2,gt3,ftri,ZA,cplAhAhAh(gt1,gt2,gt3))

  End Do 
 End Do 
End Do 


cplAhAhhh = 0._dp 
Do gt1 = 1, 3
 Do gt2 = 1, 3
  Do gt3 = 1, 3
Call CouplingAhAhhhT(gt1,gt2,gt3,ftri,l1,l12,l13,l2,l23,l3,Vn,v1,v2,ZH,               & 
& ZA,cplAhAhhh(gt1,gt2,gt3))

  End Do 
 End Do 
End Do 


cplAhDpmcDpm = 0._dp 
Do gt1 = 1, 3
 Do gt2 = 1, 2
  Do gt3 = 1, 2
Call CouplingAhDpmcDpmT(gt1,gt2,gt3,ftri,l12t,Vn,v1,ZA,zy,cplAhDpmcDpm(gt1,gt2,gt3))

  End Do 
 End Do 
End Do 


cplAhhhhh = 0._dp 
Do gt1 = 1, 3
 Do gt2 = 1, 3
  Do gt3 = 1, 3
Call CouplingAhhhhhT(gt1,gt2,gt3,ftri,ZH,ZA,cplAhhhhh(gt1,gt2,gt3))

  End Do 
 End Do 
End Do 


cplAhHpmcHpm = 0._dp 
Do gt1 = 1, 3
 Do gt2 = 1, 4
  Do gt3 = 1, 4
Call CouplingAhHpmcHpmT(gt1,gt2,gt3,ftri,l13t,l23t,Vn,v1,v2,ZA,ZP,cplAhHpmcHpm(gt1,gt2,gt3))

  End Do 
 End Do 
End Do 


cplAhhhVZ = 0._dp 
Do gt1 = 1, 3
 Do gt2 = 1, 3
Call CouplingAhhhVZT(gt1,gt2,g1,g2,ZZ,ZH,ZA,cplAhhhVZ(gt1,gt2))

 End Do 
End Do 


cplAhhhVZp = 0._dp 
Do gt1 = 1, 3
 Do gt2 = 1, 3
Call CouplingAhhhVZpT(gt1,gt2,g1,g2,ZZ,ZH,ZA,cplAhhhVZp(gt1,gt2))

 End Do 
End Do 


cplAhHpmVWp = 0._dp 
Do gt1 = 1, 3
 Do gt2 = 1, 4
Call CouplingAhHpmVWpT(gt1,gt2,g2,ZA,ZP,cplAhHpmVWp(gt1,gt2))

 End Do 
End Do 


cplAhHpmVXp = 0._dp 
Do gt1 = 1, 3
 Do gt2 = 1, 4
Call CouplingAhHpmVXpT(gt1,gt2,g2,ZA,ZP,cplAhHpmVXp(gt1,gt2))

 End Do 
End Do 


cplcFdFdAhL = 0._dp 
cplcFdFdAhR = 0._dp 
Do gt1 = 1, 5
 Do gt2 = 1, 5
  Do gt3 = 1, 3
Call CouplingcFdFdAhT(gt1,gt2,gt3,hdp11,hd1,hdtp11,hdt1,hdp1,hd2,hdtp1,               & 
& hdt2,hd3,hdt3,ZA,Vd,Ud,cplcFdFdAhL(gt1,gt2,gt3),cplcFdFdAhR(gt1,gt2,gt3))

  End Do 
 End Do 
End Do 


cplcFeFeAhL = 0._dp 
cplcFeFeAhR = 0._dp 
Do gt1 = 1, 3
 Do gt2 = 1, 3
  Do gt3 = 1, 3
Call CouplingcFeFeAhT(gt1,gt2,gt3,hll1,ZA,Ve,Ue,cplcFeFeAhL(gt1,gt2,gt3)              & 
& ,cplcFeFeAhR(gt1,gt2,gt3))

  End Do 
 End Do 
End Do 


cplcFuFuAhL = 0._dp 
cplcFuFuAhR = 0._dp 
Do gt1 = 1, 4
 Do gt2 = 1, 4
  Do gt3 = 1, 3
Call CouplingcFuFuAhT(gt1,gt2,gt3,hup11,hUp1,hup21,hUp2,hu11,h12,hU1,hU2,             & 
& ZA,Vu,Uu,cplcFuFuAhL(gt1,gt2,gt3),cplcFuFuAhR(gt1,gt2,gt3))

  End Do 
 End Do 
End Do 


Iname = Iname - 1 
 
End subroutine CouplingsFor_Ah_decays_2B
 
Subroutine CouplingsFor_Hpm_decays_2B(m_in,i1,MAhinput,MAh2input,MDpminput,           & 
& MDpm2input,MFdinput,MFd2input,MFeinput,MFe2input,MFuinput,MFu2input,Mhhinput,          & 
& Mhh2input,MHpminput,MHpm2input,MVWpinput,MVWp2input,MVXpinput,MVXp2input,              & 
& MVZinput,MVZ2input,MVZpinput,MVZp2input,TWinput,Udinput,Ueinput,Uuinput,               & 
& Vdinput,Veinput,Vuinput,ZAinput,ZHinput,ZPinput,ZWinput,zyinput,ZZinput,               & 
& g1input,g2input,g3input,l1input,l12input,l13input,l12tinput,l13tinput,l2input,         & 
& l23input,l23tinput,l3input,hll1input,hdp11input,hd1input,hdtp11input,hdt1input,        & 
& hup11input,hUp1input,hdp1input,hd2input,hdtp1input,hdt2input,hup21input,               & 
& hUp2input,hd3input,hdt3input,hu11input,h12input,hU1input,hU2input,ftriinput,           & 
& mu12input,mu22input,mu32input,Vninput,v1input,v2input,cplAhHpmcHpm,cplAhcHpmcVWp,      & 
& cplAhcHpmcVXp,cplDpmHpmcHpm,cplDpmcHpmcVWp,cplcFuFdcHpmL,cplcFuFdcHpmR,cplFeFv1cHpmL,  & 
& cplFeFv1cHpmR,cplcFv1FecHpmL,cplcFv1FecHpmR,cplhhHpmcHpm,cplhhcHpmcVWp,cplhhcHpmcVXp,  & 
& cplHpmcHpmVZ,cplHpmcHpmVZp,cplHpmcDpmcHpm,cplcHpmcVWpVZ,cplcHpmcVXpVZ,cplcHpmcVWpVZp,  & 
& cplcHpmcVXpVZp,cplcDpmcHpmcVXp,deltaM)

Implicit None 

Real(dp), Intent(in) :: m_in 
Real(dp), Intent(in) :: deltaM 
Integer, Intent(in) :: i1 
Real(dp),Intent(in) :: g1input,g2input,g3input,ftriinput,mu12input,mu22input,mu32input,Vninput,              & 
& v1input,v2input

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

Real(dp) :: g1,g2,g3,ftri,mu12,mu22,mu32,Vn,v1,v2

Complex(dp) :: l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,hll1(3,3),hdp11(3),hd1(3),hdtp11(2),              & 
& hdt1(2),hup11(3),hUp1,hdp1(3),hd2(3),hdtp1(2),hdt2(2),hup21(3),hUp2,hd3(3),            & 
& hdt3(2),hu11(3),h12(3),hU1,hU2

Complex(dp),Intent(out) :: cplAhHpmcHpm(3,4,4),cplAhcHpmcVWp(3,4),cplAhcHpmcVXp(3,4),cplDpmHpmcHpm(2,4,4),       & 
& cplDpmcHpmcVWp(2,4),cplcFuFdcHpmL(4,5,4),cplcFuFdcHpmR(4,5,4),cplFeFv1cHpmL(3,3,4),    & 
& cplFeFv1cHpmR(3,3,4),cplcFv1FecHpmL(3,3,4),cplcFv1FecHpmR(3,3,4),cplhhHpmcHpm(3,4,4),  & 
& cplhhcHpmcVWp(3,4),cplhhcHpmcVXp(3,4),cplHpmcHpmVZ(4,4),cplHpmcHpmVZp(4,4),            & 
& cplHpmcDpmcHpm(4,2,4),cplcHpmcVWpVZ(4),cplcHpmcVXpVZ(4),cplcHpmcVWpVZp(4),             & 
& cplcHpmcVXpVZp(4),cplcDpmcHpmcVXp(2,4)

Integer :: i2, i3, gt1, gt2, gt3, kont 
Real(dp) :: MAh(3),MAh2(3),MDpm(2),MDpm2(2),MFd(5),MFd2(5),MFe(3),MFe2(3),MFu(4),MFu2(4),         & 
& Mhh(3),Mhh2(3),MHpm(4),MHpm2(4),MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,TW

Complex(dp) :: Ud(5,5),Ue(3,3),Uu(4,4),Vd(5,5),Ve(3,3),Vu(4,4),ZA(3,3),ZH(3,3),ZP(4,4),              & 
& ZW(4,4),zy(2,2),ZZ(3,3)

Real(dp) :: gSM(11), sinW2, dt, tz, Qin 
Iname = Iname + 1 
NameOfUnit(Iname) = 'Couplings_Hpm_2B'
 
sinW2=1._dp-mW2/mZ2 
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
Qin=sqrt(getRenormalizationScale()) 
Call SolveTadpoleEquations(g1,g2,g3,l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,              & 
& hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,hUp2,hd3,              & 
& hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,Vn,v1,v2,(/ ZeroC, ZeroC, ZeroC /))

! --- Calculate running tree-level masses for loop induced couplings and Quark mixing matrices --- 
Call TreeMasses(MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,MFe2,MFu,MFu2,Mhh,Mhh2,              & 
& MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,TW,Ud,Ue,Uu,Vd,Ve,Vu,             & 
& ZA,ZH,ZP,ZW,zy,ZZ,Vn,v1,v2,g1,g2,g3,l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,               & 
& hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,hUp2,hd3,              & 
& hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,.True.,kont)

If (ExternalZfactors) Then 
! --- Use the 1-loop mixing matrices calculated at M_SUSY in the vertices --- 
ZA = ZAinput 
ZH = ZHinput 
ZP = ZPinput 
ZW = ZWinput 
zy = zyinput 
ZZ = ZZinput 
End if 
If (PoleMassesInLoops) Then 
! --- Use the pole masses --- 
MAh = MAhinput 
MAh2 = MAh2input 
MDpm = MDpminput 
MDpm2 = MDpm2input 
MFd = MFdinput 
MFd2 = MFd2input 
MFe = MFeinput 
MFe2 = MFe2input 
MFu = MFuinput 
MFu2 = MFu2input 
Mhh = Mhhinput 
Mhh2 = Mhh2input 
MHpm = MHpminput 
MHpm2 = MHpm2input 
MVWp = MVWpinput 
MVWp2 = MVWp2input 
MVXp = MVXpinput 
MVXp2 = MVXp2input 
MVZ = MVZinput 
MVZ2 = MVZ2input 
MVZp = MVZpinput 
MVZp2 = MVZp2input 
End if 
cplAhHpmcHpm = 0._dp 
Do gt1 = 1, 3
 Do gt2 = 1, 4
  Do gt3 = 1, 4
Call CouplingAhHpmcHpmT(gt1,gt2,gt3,ftri,l13t,l23t,Vn,v1,v2,ZA,ZP,cplAhHpmcHpm(gt1,gt2,gt3))

  End Do 
 End Do 
End Do 


cplDpmHpmcHpm = 0._dp 
Do gt1 = 1, 2
 Do gt2 = 1, 4
  Do gt3 = 1, 4
Call CouplingDpmHpmcHpmT(gt1,gt2,gt3,ftri,l12t,l13t,l23t,Vn,v1,v2,ZP,zy,              & 
& cplDpmHpmcHpm(gt1,gt2,gt3))

  End Do 
 End Do 
End Do 


cplhhHpmcHpm = 0._dp 
Do gt1 = 1, 3
 Do gt2 = 1, 4
  Do gt3 = 1, 4
Call CouplinghhHpmcHpmT(gt1,gt2,gt3,ftri,l1,l12,l13,l13t,l2,l23,l23t,l3,              & 
& Vn,v1,v2,ZH,ZP,cplhhHpmcHpm(gt1,gt2,gt3))

  End Do 
 End Do 
End Do 


cplHpmcDpmcHpm = 0._dp 
Do gt1 = 1, 4
 Do gt2 = 1, 2
  Do gt3 = 1, 4
Call CouplingHpmcDpmcHpmT(gt1,gt2,gt3,ftri,l12t,l13t,l23t,Vn,v1,v2,ZP,zy,             & 
& cplHpmcDpmcHpm(gt1,gt2,gt3))

  End Do 
 End Do 
End Do 


cplAhcHpmcVWp = 0._dp 
Do gt1 = 1, 3
 Do gt2 = 1, 4
Call CouplingAhcHpmcVWpT(gt1,gt2,g2,ZA,ZP,cplAhcHpmcVWp(gt1,gt2))

 End Do 
End Do 


cplAhcHpmcVXp = 0._dp 
Do gt1 = 1, 3
 Do gt2 = 1, 4
Call CouplingAhcHpmcVXpT(gt1,gt2,g2,ZA,ZP,cplAhcHpmcVXp(gt1,gt2))

 End Do 
End Do 


cplDpmcHpmcVWp = 0._dp 
Do gt1 = 1, 2
 Do gt2 = 1, 4
Call CouplingDpmcHpmcVWpT(gt1,gt2,g2,ZP,zy,cplDpmcHpmcVWp(gt1,gt2))

 End Do 
End Do 


cplhhcHpmcVWp = 0._dp 
Do gt1 = 1, 3
 Do gt2 = 1, 4
Call CouplinghhcHpmcVWpT(gt1,gt2,g2,ZH,ZP,cplhhcHpmcVWp(gt1,gt2))

 End Do 
End Do 


cplhhcHpmcVXp = 0._dp 
Do gt1 = 1, 3
 Do gt2 = 1, 4
Call CouplinghhcHpmcVXpT(gt1,gt2,g2,ZH,ZP,cplhhcHpmcVXp(gt1,gt2))

 End Do 
End Do 


cplHpmcHpmVZ = 0._dp 
Do gt1 = 1, 4
 Do gt2 = 1, 4
Call CouplingHpmcHpmVZT(gt1,gt2,g1,g2,ZZ,ZP,cplHpmcHpmVZ(gt1,gt2))

 End Do 
End Do 


cplHpmcHpmVZp = 0._dp 
Do gt1 = 1, 4
 Do gt2 = 1, 4
Call CouplingHpmcHpmVZpT(gt1,gt2,g1,g2,ZZ,ZP,cplHpmcHpmVZp(gt1,gt2))

 End Do 
End Do 


cplcDpmcHpmcVXp = 0._dp 
Do gt1 = 1, 2
 Do gt2 = 1, 4
Call CouplingcDpmcHpmcVXpT(gt1,gt2,g2,ZP,zy,cplcDpmcHpmcVXp(gt1,gt2))

 End Do 
End Do 


cplcHpmcVWpVZ = 0._dp 
Do gt1 = 1, 4
Call CouplingcHpmcVWpVZT(gt1,g1,g2,v1,v2,ZZ,ZP,cplcHpmcVWpVZ(gt1))

End Do 


cplcHpmcVXpVZ = 0._dp 
Do gt1 = 1, 4
Call CouplingcHpmcVXpVZT(gt1,g1,g2,Vn,v2,ZZ,ZP,cplcHpmcVXpVZ(gt1))

End Do 


cplcHpmcVWpVZp = 0._dp 
Do gt1 = 1, 4
Call CouplingcHpmcVWpVZpT(gt1,g1,g2,v1,v2,ZZ,ZP,cplcHpmcVWpVZp(gt1))

End Do 


cplcHpmcVXpVZp = 0._dp 
Do gt1 = 1, 4
Call CouplingcHpmcVXpVZpT(gt1,g1,g2,Vn,v2,ZZ,ZP,cplcHpmcVXpVZp(gt1))

End Do 


cplcFuFdcHpmL = 0._dp 
cplcFuFdcHpmR = 0._dp 
Do gt1 = 1, 4
 Do gt2 = 1, 5
  Do gt3 = 1, 4
Call CouplingcFuFdcHpmT(gt1,gt2,gt3,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,            & 
& hd2,hdtp1,hdt2,hup21,hUp2,hd3,hdt3,hu11,h12,hU1,hU2,ZP,Vd,Ud,Vu,Uu,cplcFuFdcHpmL(gt1,gt2,gt3)& 
& ,cplcFuFdcHpmR(gt1,gt2,gt3))

  End Do 
 End Do 
End Do 


cplFeFv1cHpmL = 0._dp 
cplFeFv1cHpmR = 0._dp 
Do gt1 = 1, 3
 Do gt2 = 1, 3
  Do gt3 = 1, 4
Call CouplingFeFv1cHpmT(gt1,gt2,gt3,h12l,ZP,Ve,cplFeFv1cHpmL(gt1,gt2,gt3)             & 
& ,cplFeFv1cHpmR(gt1,gt2,gt3))

  End Do 
 End Do 
End Do 


cplcFv1FecHpmL = 0._dp 
cplcFv1FecHpmR = 0._dp 
Do gt1 = 1, 3
 Do gt2 = 1, 3
  Do gt3 = 1, 4
Call CouplingcFv1FecHpmT(gt1,gt2,gt3,hll1,ZP,Ue,cplcFv1FecHpmL(gt1,gt2,gt3)           & 
& ,cplcFv1FecHpmR(gt1,gt2,gt3))

  End Do 
 End Do 
End Do 


Iname = Iname - 1 
 
End subroutine CouplingsFor_Hpm_decays_2B
 
Subroutine CouplingsFor_Dpm_decays_2B(m_in,i1,MAhinput,MAh2input,MDpminput,           & 
& MDpm2input,MFdinput,MFd2input,MFeinput,MFe2input,MFuinput,MFu2input,Mhhinput,          & 
& Mhh2input,MHpminput,MHpm2input,MVWpinput,MVWp2input,MVXpinput,MVXp2input,              & 
& MVZinput,MVZ2input,MVZpinput,MVZp2input,TWinput,Udinput,Ueinput,Uuinput,               & 
& Vdinput,Veinput,Vuinput,ZAinput,ZHinput,ZPinput,ZWinput,zyinput,ZZinput,               & 
& g1input,g2input,g3input,l1input,l12input,l13input,l12tinput,l13tinput,l2input,         & 
& l23input,l23tinput,l3input,hll1input,hdp11input,hd1input,hdtp11input,hdt1input,        & 
& hup11input,hUp1input,hdp1input,hd2input,hdtp1input,hdt2input,hup21input,               & 
& hUp2input,hd3input,hdt3input,hu11input,h12input,hU1input,hU2input,ftriinput,           & 
& mu12input,mu22input,mu32input,Vninput,v1input,v2input,cplAhDpmcDpm,cplDpmhhcDpm,       & 
& cplDpmcDpmVZ,cplDpmcDpmVZp,cplcFdFdcDpmL,cplcFdFdcDpmR,cplcFuFucDpmL,cplcFuFucDpmR,    & 
& cplHpmcDpmVWp,cplHpmcDpmcHpm,cplcDpmcVXpVWp,cplcDpmcHpmcVXp,deltaM)

Implicit None 

Real(dp), Intent(in) :: m_in 
Real(dp), Intent(in) :: deltaM 
Integer, Intent(in) :: i1 
Real(dp),Intent(in) :: g1input,g2input,g3input,ftriinput,mu12input,mu22input,mu32input,Vninput,              & 
& v1input,v2input

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

Real(dp) :: g1,g2,g3,ftri,mu12,mu22,mu32,Vn,v1,v2

Complex(dp) :: l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,hll1(3,3),hdp11(3),hd1(3),hdtp11(2),              & 
& hdt1(2),hup11(3),hUp1,hdp1(3),hd2(3),hdtp1(2),hdt2(2),hup21(3),hUp2,hd3(3),            & 
& hdt3(2),hu11(3),h12(3),hU1,hU2

Complex(dp),Intent(out) :: cplAhDpmcDpm(3,2,2),cplDpmhhcDpm(2,3,2),cplDpmcDpmVZ(2,2),cplDpmcDpmVZp(2,2),         & 
& cplcFdFdcDpmL(5,5,2),cplcFdFdcDpmR(5,5,2),cplcFuFucDpmL(4,4,2),cplcFuFucDpmR(4,4,2),   & 
& cplHpmcDpmVWp(4,2),cplHpmcDpmcHpm(4,2,4),cplcDpmcVXpVWp(2),cplcDpmcHpmcVXp(2,4)

Integer :: i2, i3, gt1, gt2, gt3, kont 
Real(dp) :: MAh(3),MAh2(3),MDpm(2),MDpm2(2),MFd(5),MFd2(5),MFe(3),MFe2(3),MFu(4),MFu2(4),         & 
& Mhh(3),Mhh2(3),MHpm(4),MHpm2(4),MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,TW

Complex(dp) :: Ud(5,5),Ue(3,3),Uu(4,4),Vd(5,5),Ve(3,3),Vu(4,4),ZA(3,3),ZH(3,3),ZP(4,4),              & 
& ZW(4,4),zy(2,2),ZZ(3,3)

Real(dp) :: gSM(11), sinW2, dt, tz, Qin 
Iname = Iname + 1 
NameOfUnit(Iname) = 'Couplings_Dpm_2B'
 
sinW2=1._dp-mW2/mZ2 
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
Qin=sqrt(getRenormalizationScale()) 
Call SolveTadpoleEquations(g1,g2,g3,l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,              & 
& hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,hUp2,hd3,              & 
& hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,Vn,v1,v2,(/ ZeroC, ZeroC, ZeroC /))

! --- Calculate running tree-level masses for loop induced couplings and Quark mixing matrices --- 
Call TreeMasses(MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,MFe2,MFu,MFu2,Mhh,Mhh2,              & 
& MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,TW,Ud,Ue,Uu,Vd,Ve,Vu,             & 
& ZA,ZH,ZP,ZW,zy,ZZ,Vn,v1,v2,g1,g2,g3,l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,               & 
& hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,hUp2,hd3,              & 
& hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,.True.,kont)

If (ExternalZfactors) Then 
! --- Use the 1-loop mixing matrices calculated at M_SUSY in the vertices --- 
ZA = ZAinput 
ZH = ZHinput 
ZP = ZPinput 
ZW = ZWinput 
zy = zyinput 
ZZ = ZZinput 
End if 
If (PoleMassesInLoops) Then 
! --- Use the pole masses --- 
MAh = MAhinput 
MAh2 = MAh2input 
MDpm = MDpminput 
MDpm2 = MDpm2input 
MFd = MFdinput 
MFd2 = MFd2input 
MFe = MFeinput 
MFe2 = MFe2input 
MFu = MFuinput 
MFu2 = MFu2input 
Mhh = Mhhinput 
Mhh2 = Mhh2input 
MHpm = MHpminput 
MHpm2 = MHpm2input 
MVWp = MVWpinput 
MVWp2 = MVWp2input 
MVXp = MVXpinput 
MVXp2 = MVXp2input 
MVZ = MVZinput 
MVZ2 = MVZ2input 
MVZp = MVZpinput 
MVZp2 = MVZp2input 
End if 
cplAhDpmcDpm = 0._dp 
Do gt1 = 1, 3
 Do gt2 = 1, 2
  Do gt3 = 1, 2
Call CouplingAhDpmcDpmT(gt1,gt2,gt3,ftri,l12t,Vn,v1,ZA,zy,cplAhDpmcDpm(gt1,gt2,gt3))

  End Do 
 End Do 
End Do 


cplDpmhhcDpm = 0._dp 
Do gt1 = 1, 2
 Do gt2 = 1, 3
  Do gt3 = 1, 2
Call CouplingDpmhhcDpmT(gt1,gt2,gt3,ftri,l1,l12,l13,l12t,l2,l23,Vn,v1,v2,             & 
& ZH,zy,cplDpmhhcDpm(gt1,gt2,gt3))

  End Do 
 End Do 
End Do 


cplHpmcDpmcHpm = 0._dp 
Do gt1 = 1, 4
 Do gt2 = 1, 2
  Do gt3 = 1, 4
Call CouplingHpmcDpmcHpmT(gt1,gt2,gt3,ftri,l12t,l13t,l23t,Vn,v1,v2,ZP,zy,             & 
& cplHpmcDpmcHpm(gt1,gt2,gt3))

  End Do 
 End Do 
End Do 


cplDpmcDpmVZ = 0._dp 
Do gt1 = 1, 2
 Do gt2 = 1, 2
Call CouplingDpmcDpmVZT(gt1,gt2,g1,g2,ZZ,zy,cplDpmcDpmVZ(gt1,gt2))

 End Do 
End Do 


cplDpmcDpmVZp = 0._dp 
Do gt1 = 1, 2
 Do gt2 = 1, 2
Call CouplingDpmcDpmVZpT(gt1,gt2,g1,g2,ZZ,zy,cplDpmcDpmVZp(gt1,gt2))

 End Do 
End Do 


cplHpmcDpmVWp = 0._dp 
Do gt1 = 1, 4
 Do gt2 = 1, 2
Call CouplingHpmcDpmVWpT(gt1,gt2,g2,ZP,zy,cplHpmcDpmVWp(gt1,gt2))

 End Do 
End Do 


cplcDpmcHpmcVXp = 0._dp 
Do gt1 = 1, 2
 Do gt2 = 1, 4
Call CouplingcDpmcHpmcVXpT(gt1,gt2,g2,ZP,zy,cplcDpmcHpmcVXp(gt1,gt2))

 End Do 
End Do 


cplcDpmcVXpVWp = 0._dp 
Do gt1 = 1, 2
Call CouplingcDpmcVXpVWpT(gt1,g2,Vn,v1,zy,cplcDpmcVXpVWp(gt1))

End Do 


cplcFdFdcDpmL = 0._dp 
cplcFdFdcDpmR = 0._dp 
Do gt1 = 1, 5
 Do gt2 = 1, 5
  Do gt3 = 1, 2
Call CouplingcFdFdcDpmT(gt1,gt2,gt3,hdp11,hd1,hdtp11,hdt1,hdp1,hd2,hdtp1,             & 
& hdt2,zy,Vd,Ud,cplcFdFdcDpmL(gt1,gt2,gt3),cplcFdFdcDpmR(gt1,gt2,gt3))

  End Do 
 End Do 
End Do 


cplcFuFucDpmL = 0._dp 
cplcFuFucDpmR = 0._dp 
Do gt1 = 1, 4
 Do gt2 = 1, 4
  Do gt3 = 1, 2
Call CouplingcFuFucDpmT(gt1,gt2,gt3,hu11,h12,hU1,hU2,zy,Vu,Uu,cplcFuFucDpmL(gt1,gt2,gt3)& 
& ,cplcFuFucDpmR(gt1,gt2,gt3))

  End Do 
 End Do 
End Do 


Iname = Iname - 1 
 
End subroutine CouplingsFor_Dpm_decays_2B
 
Subroutine CouplingsFor_VZ_decays_2B(m_in,i1,MAhinput,MAh2input,MDpminput,            & 
& MDpm2input,MFdinput,MFd2input,MFeinput,MFe2input,MFuinput,MFu2input,Mhhinput,          & 
& Mhh2input,MHpminput,MHpm2input,MVWpinput,MVWp2input,MVXpinput,MVXp2input,              & 
& MVZinput,MVZ2input,MVZpinput,MVZp2input,TWinput,Udinput,Ueinput,Uuinput,               & 
& Vdinput,Veinput,Vuinput,ZAinput,ZHinput,ZPinput,ZWinput,zyinput,ZZinput,               & 
& g1input,g2input,g3input,l1input,l12input,l13input,l12tinput,l13tinput,l2input,         & 
& l23input,l23tinput,l3input,hll1input,hdp11input,hd1input,hdtp11input,hdt1input,        & 
& hup11input,hUp1input,hdp1input,hd2input,hdtp1input,hdt2input,hup21input,               & 
& hUp2input,hd3input,hdt3input,hu11input,h12input,hU1input,hU2input,ftriinput,           & 
& mu12input,mu22input,mu32input,Vninput,v1input,v2input,cplAhhhVZ,cplDpmcDpmVZ,          & 
& cplcFdFdVZL,cplcFdFdVZR,cplcFeFeVZL,cplcFeFeVZR,cplcFuFuVZL,cplcFuFuVZR,               & 
& cplcFv1Fv1VZL,cplcFv1Fv1VZR,cplhhVZVZ,cplhhVZVZp,cplHpmVWpVZ,cplHpmVXpVZ,              & 
& cplHpmcHpmVZ,cplcVWpVWpVZ,cplcVXpVXpVZ,deltaM)

Implicit None 

Real(dp), Intent(in) :: m_in 
Real(dp), Intent(in) :: deltaM 
Integer, Intent(in) :: i1 
Real(dp),Intent(in) :: g1input,g2input,g3input,ftriinput,mu12input,mu22input,mu32input,Vninput,              & 
& v1input,v2input

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

Real(dp) :: g1,g2,g3,ftri,mu12,mu22,mu32,Vn,v1,v2

Complex(dp) :: l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,hll1(3,3),hdp11(3),hd1(3),hdtp11(2),              & 
& hdt1(2),hup11(3),hUp1,hdp1(3),hd2(3),hdtp1(2),hdt2(2),hup21(3),hUp2,hd3(3),            & 
& hdt3(2),hu11(3),h12(3),hU1,hU2

Complex(dp),Intent(out) :: cplAhhhVZ(3,3),cplDpmcDpmVZ(2,2),cplcFdFdVZL(5,5),cplcFdFdVZR(5,5),cplcFeFeVZL(3,3),  & 
& cplcFeFeVZR(3,3),cplcFuFuVZL(4,4),cplcFuFuVZR(4,4),cplcFv1Fv1VZL(3,3),cplcFv1Fv1VZR(3,3),& 
& cplhhVZVZ(3),cplhhVZVZp(3),cplHpmVWpVZ(4),cplHpmVXpVZ(4),cplHpmcHpmVZ(4,4),            & 
& cplcVWpVWpVZ,cplcVXpVXpVZ

Integer :: i2, i3, gt1, gt2, gt3, kont 
Real(dp) :: MAh(3),MAh2(3),MDpm(2),MDpm2(2),MFd(5),MFd2(5),MFe(3),MFe2(3),MFu(4),MFu2(4),         & 
& Mhh(3),Mhh2(3),MHpm(4),MHpm2(4),MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,TW

Complex(dp) :: Ud(5,5),Ue(3,3),Uu(4,4),Vd(5,5),Ve(3,3),Vu(4,4),ZA(3,3),ZH(3,3),ZP(4,4),              & 
& ZW(4,4),zy(2,2),ZZ(3,3)

Real(dp) :: gSM(11), sinW2, dt, tz, Qin 
Iname = Iname + 1 
NameOfUnit(Iname) = 'Couplings_VZ_2B'
 
sinW2=1._dp-mW2/mZ2 
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
Qin=sqrt(getRenormalizationScale()) 
Call SolveTadpoleEquations(g1,g2,g3,l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,              & 
& hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,hUp2,hd3,              & 
& hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,Vn,v1,v2,(/ ZeroC, ZeroC, ZeroC /))

! --- Calculate running tree-level masses for loop induced couplings and Quark mixing matrices --- 
Call TreeMasses(MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,MFe2,MFu,MFu2,Mhh,Mhh2,              & 
& MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,TW,Ud,Ue,Uu,Vd,Ve,Vu,             & 
& ZA,ZH,ZP,ZW,zy,ZZ,Vn,v1,v2,g1,g2,g3,l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,               & 
& hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,hUp2,hd3,              & 
& hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,.True.,kont)

If (ExternalZfactors) Then 
! --- Use the 1-loop mixing matrices calculated at M_SUSY in the vertices --- 
ZA = ZAinput 
ZH = ZHinput 
ZP = ZPinput 
ZW = ZWinput 
zy = zyinput 
ZZ = ZZinput 
End if 
If (PoleMassesInLoops) Then 
! --- Use the pole masses --- 
MAh = MAhinput 
MAh2 = MAh2input 
MDpm = MDpminput 
MDpm2 = MDpm2input 
MFd = MFdinput 
MFd2 = MFd2input 
MFe = MFeinput 
MFe2 = MFe2input 
MFu = MFuinput 
MFu2 = MFu2input 
Mhh = Mhhinput 
Mhh2 = Mhh2input 
MHpm = MHpminput 
MHpm2 = MHpm2input 
MVWp = MVWpinput 
MVWp2 = MVWp2input 
MVXp = MVXpinput 
MVXp2 = MVXp2input 
MVZ = MVZinput 
MVZ2 = MVZ2input 
MVZp = MVZpinput 
MVZp2 = MVZp2input 
End if 
cplAhhhVZ = 0._dp 
Do gt1 = 1, 3
 Do gt2 = 1, 3
Call CouplingAhhhVZT(gt1,gt2,g1,g2,ZZ,ZH,ZA,cplAhhhVZ(gt1,gt2))

 End Do 
End Do 


cplDpmcDpmVZ = 0._dp 
Do gt1 = 1, 2
 Do gt2 = 1, 2
Call CouplingDpmcDpmVZT(gt1,gt2,g1,g2,ZZ,zy,cplDpmcDpmVZ(gt1,gt2))

 End Do 
End Do 


cplHpmcHpmVZ = 0._dp 
Do gt1 = 1, 4
 Do gt2 = 1, 4
Call CouplingHpmcHpmVZT(gt1,gt2,g1,g2,ZZ,ZP,cplHpmcHpmVZ(gt1,gt2))

 End Do 
End Do 


cplhhVZVZ = 0._dp 
Do gt1 = 1, 3
Call CouplinghhVZVZT(gt1,g1,g2,Vn,v1,v2,ZZ,ZH,cplhhVZVZ(gt1))

End Do 


cplhhVZVZp = 0._dp 
Do gt1 = 1, 3
Call CouplinghhVZVZpT(gt1,g1,g2,Vn,v1,v2,ZZ,ZH,cplhhVZVZp(gt1))

End Do 


cplHpmVWpVZ = 0._dp 
Do gt1 = 1, 4
Call CouplingHpmVWpVZT(gt1,g1,g2,v1,v2,ZZ,ZP,cplHpmVWpVZ(gt1))

End Do 


cplHpmVXpVZ = 0._dp 
Do gt1 = 1, 4
Call CouplingHpmVXpVZT(gt1,g1,g2,Vn,v2,ZZ,ZP,cplHpmVXpVZ(gt1))

End Do 


cplcVWpVWpVZ = 0._dp 
Call CouplingcVWpVWpVZT(g2,ZZ,cplcVWpVWpVZ)



cplcVXpVXpVZ = 0._dp 
Call CouplingcVXpVXpVZT(g2,ZZ,cplcVXpVXpVZ)



cplcFdFdVZL = 0._dp 
cplcFdFdVZR = 0._dp 
Do gt1 = 1, 5
 Do gt2 = 1, 5
Call CouplingcFdFdVZT(gt1,gt2,g1,g2,ZZ,Vd,cplcFdFdVZL(gt1,gt2),cplcFdFdVZR(gt1,gt2))

 End Do 
End Do 


cplcFeFeVZL = 0._dp 
cplcFeFeVZR = 0._dp 
Do gt1 = 1, 3
 Do gt2 = 1, 3
Call CouplingcFeFeVZT(gt1,gt2,g1,g2,ZZ,cplcFeFeVZL(gt1,gt2),cplcFeFeVZR(gt1,gt2))

 End Do 
End Do 


cplcFuFuVZL = 0._dp 
cplcFuFuVZR = 0._dp 
Do gt1 = 1, 4
 Do gt2 = 1, 4
Call CouplingcFuFuVZT(gt1,gt2,g1,g2,ZZ,Vu,Uu,cplcFuFuVZL(gt1,gt2),cplcFuFuVZR(gt1,gt2))

 End Do 
End Do 


cplcFv1Fv1VZL = 0._dp 
cplcFv1Fv1VZR = 0._dp 
Do gt1 = 1, 3
 Do gt2 = 1, 3
Call CouplingcFv1Fv1VZT(gt1,gt2,g2,ZZ,cplcFv1Fv1VZL(gt1,gt2),cplcFv1Fv1VZR(gt1,gt2))

 End Do 
End Do 


Iname = Iname - 1 
 
End subroutine CouplingsFor_VZ_decays_2B
 
Subroutine CouplingsFor_VZp_decays_2B(m_in,i1,MAhinput,MAh2input,MDpminput,           & 
& MDpm2input,MFdinput,MFd2input,MFeinput,MFe2input,MFuinput,MFu2input,Mhhinput,          & 
& Mhh2input,MHpminput,MHpm2input,MVWpinput,MVWp2input,MVXpinput,MVXp2input,              & 
& MVZinput,MVZ2input,MVZpinput,MVZp2input,TWinput,Udinput,Ueinput,Uuinput,               & 
& Vdinput,Veinput,Vuinput,ZAinput,ZHinput,ZPinput,ZWinput,zyinput,ZZinput,               & 
& g1input,g2input,g3input,l1input,l12input,l13input,l12tinput,l13tinput,l2input,         & 
& l23input,l23tinput,l3input,hll1input,hdp11input,hd1input,hdtp11input,hdt1input,        & 
& hup11input,hUp1input,hdp1input,hd2input,hdtp1input,hdt2input,hup21input,               & 
& hUp2input,hd3input,hdt3input,hu11input,h12input,hU1input,hU2input,ftriinput,           & 
& mu12input,mu22input,mu32input,Vninput,v1input,v2input,cplAhhhVZp,cplDpmcDpmVZp,        & 
& cplcFdFdVZpL,cplcFdFdVZpR,cplcFeFeVZpL,cplcFeFeVZpR,cplcFuFuVZpL,cplcFuFuVZpR,         & 
& cplcFv1Fv1VZpL,cplcFv1Fv1VZpR,cplhhVZVZp,cplhhVZpVZp,cplHpmVWpVZp,cplHpmVXpVZp,        & 
& cplHpmcHpmVZp,cplcVWpVWpVZp,cplcVXpVXpVZp,deltaM)

Implicit None 

Real(dp), Intent(in) :: m_in 
Real(dp), Intent(in) :: deltaM 
Integer, Intent(in) :: i1 
Real(dp),Intent(in) :: g1input,g2input,g3input,ftriinput,mu12input,mu22input,mu32input,Vninput,              & 
& v1input,v2input

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

Real(dp) :: g1,g2,g3,ftri,mu12,mu22,mu32,Vn,v1,v2

Complex(dp) :: l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,hll1(3,3),hdp11(3),hd1(3),hdtp11(2),              & 
& hdt1(2),hup11(3),hUp1,hdp1(3),hd2(3),hdtp1(2),hdt2(2),hup21(3),hUp2,hd3(3),            & 
& hdt3(2),hu11(3),h12(3),hU1,hU2

Complex(dp),Intent(out) :: cplAhhhVZp(3,3),cplDpmcDpmVZp(2,2),cplcFdFdVZpL(5,5),cplcFdFdVZpR(5,5),               & 
& cplcFeFeVZpL(3,3),cplcFeFeVZpR(3,3),cplcFuFuVZpL(4,4),cplcFuFuVZpR(4,4),               & 
& cplcFv1Fv1VZpL(3,3),cplcFv1Fv1VZpR(3,3),cplhhVZVZp(3),cplhhVZpVZp(3),cplHpmVWpVZp(4),  & 
& cplHpmVXpVZp(4),cplHpmcHpmVZp(4,4),cplcVWpVWpVZp,cplcVXpVXpVZp

Integer :: i2, i3, gt1, gt2, gt3, kont 
Real(dp) :: MAh(3),MAh2(3),MDpm(2),MDpm2(2),MFd(5),MFd2(5),MFe(3),MFe2(3),MFu(4),MFu2(4),         & 
& Mhh(3),Mhh2(3),MHpm(4),MHpm2(4),MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,TW

Complex(dp) :: Ud(5,5),Ue(3,3),Uu(4,4),Vd(5,5),Ve(3,3),Vu(4,4),ZA(3,3),ZH(3,3),ZP(4,4),              & 
& ZW(4,4),zy(2,2),ZZ(3,3)

Real(dp) :: gSM(11), sinW2, dt, tz, Qin 
Iname = Iname + 1 
NameOfUnit(Iname) = 'Couplings_VZp_2B'
 
sinW2=1._dp-mW2/mZ2 
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
Qin=sqrt(getRenormalizationScale()) 
Call SolveTadpoleEquations(g1,g2,g3,l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,              & 
& hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,hUp2,hd3,              & 
& hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,Vn,v1,v2,(/ ZeroC, ZeroC, ZeroC /))

! --- Calculate running tree-level masses for loop induced couplings and Quark mixing matrices --- 
Call TreeMasses(MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,MFe2,MFu,MFu2,Mhh,Mhh2,              & 
& MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,TW,Ud,Ue,Uu,Vd,Ve,Vu,             & 
& ZA,ZH,ZP,ZW,zy,ZZ,Vn,v1,v2,g1,g2,g3,l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,               & 
& hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,hUp2,hd3,              & 
& hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,.True.,kont)

If (ExternalZfactors) Then 
! --- Use the 1-loop mixing matrices calculated at M_SUSY in the vertices --- 
ZA = ZAinput 
ZH = ZHinput 
ZP = ZPinput 
ZW = ZWinput 
zy = zyinput 
ZZ = ZZinput 
End if 
If (PoleMassesInLoops) Then 
! --- Use the pole masses --- 
MAh = MAhinput 
MAh2 = MAh2input 
MDpm = MDpminput 
MDpm2 = MDpm2input 
MFd = MFdinput 
MFd2 = MFd2input 
MFe = MFeinput 
MFe2 = MFe2input 
MFu = MFuinput 
MFu2 = MFu2input 
Mhh = Mhhinput 
Mhh2 = Mhh2input 
MHpm = MHpminput 
MHpm2 = MHpm2input 
MVWp = MVWpinput 
MVWp2 = MVWp2input 
MVXp = MVXpinput 
MVXp2 = MVXp2input 
MVZ = MVZinput 
MVZ2 = MVZ2input 
MVZp = MVZpinput 
MVZp2 = MVZp2input 
End if 
cplAhhhVZp = 0._dp 
Do gt1 = 1, 3
 Do gt2 = 1, 3
Call CouplingAhhhVZpT(gt1,gt2,g1,g2,ZZ,ZH,ZA,cplAhhhVZp(gt1,gt2))

 End Do 
End Do 


cplDpmcDpmVZp = 0._dp 
Do gt1 = 1, 2
 Do gt2 = 1, 2
Call CouplingDpmcDpmVZpT(gt1,gt2,g1,g2,ZZ,zy,cplDpmcDpmVZp(gt1,gt2))

 End Do 
End Do 


cplHpmcHpmVZp = 0._dp 
Do gt1 = 1, 4
 Do gt2 = 1, 4
Call CouplingHpmcHpmVZpT(gt1,gt2,g1,g2,ZZ,ZP,cplHpmcHpmVZp(gt1,gt2))

 End Do 
End Do 


cplhhVZVZp = 0._dp 
Do gt1 = 1, 3
Call CouplinghhVZVZpT(gt1,g1,g2,Vn,v1,v2,ZZ,ZH,cplhhVZVZp(gt1))

End Do 


cplhhVZpVZp = 0._dp 
Do gt1 = 1, 3
Call CouplinghhVZpVZpT(gt1,g1,g2,Vn,v1,v2,ZZ,ZH,cplhhVZpVZp(gt1))

End Do 


cplHpmVWpVZp = 0._dp 
Do gt1 = 1, 4
Call CouplingHpmVWpVZpT(gt1,g1,g2,v1,v2,ZZ,ZP,cplHpmVWpVZp(gt1))

End Do 


cplHpmVXpVZp = 0._dp 
Do gt1 = 1, 4
Call CouplingHpmVXpVZpT(gt1,g1,g2,Vn,v2,ZZ,ZP,cplHpmVXpVZp(gt1))

End Do 


cplcVWpVWpVZp = 0._dp 
Call CouplingcVWpVWpVZpT(g2,ZZ,cplcVWpVWpVZp)



cplcVXpVXpVZp = 0._dp 
Call CouplingcVXpVXpVZpT(g2,ZZ,cplcVXpVXpVZp)



cplcFdFdVZpL = 0._dp 
cplcFdFdVZpR = 0._dp 
Do gt1 = 1, 5
 Do gt2 = 1, 5
Call CouplingcFdFdVZpT(gt1,gt2,g1,g2,ZZ,Vd,cplcFdFdVZpL(gt1,gt2),cplcFdFdVZpR(gt1,gt2))

 End Do 
End Do 


cplcFeFeVZpL = 0._dp 
cplcFeFeVZpR = 0._dp 
Do gt1 = 1, 3
 Do gt2 = 1, 3
Call CouplingcFeFeVZpT(gt1,gt2,g1,g2,ZZ,cplcFeFeVZpL(gt1,gt2),cplcFeFeVZpR(gt1,gt2))

 End Do 
End Do 


cplcFuFuVZpL = 0._dp 
cplcFuFuVZpR = 0._dp 
Do gt1 = 1, 4
 Do gt2 = 1, 4
Call CouplingcFuFuVZpT(gt1,gt2,g1,g2,ZZ,Vu,Uu,cplcFuFuVZpL(gt1,gt2),cplcFuFuVZpR(gt1,gt2))

 End Do 
End Do 


cplcFv1Fv1VZpL = 0._dp 
cplcFv1Fv1VZpR = 0._dp 
Do gt1 = 1, 3
 Do gt2 = 1, 3
Call CouplingcFv1Fv1VZpT(gt1,gt2,g2,ZZ,cplcFv1Fv1VZpL(gt1,gt2),cplcFv1Fv1VZpR(gt1,gt2))

 End Do 
End Do 


Iname = Iname - 1 
 
End subroutine CouplingsFor_VZp_decays_2B
 
Subroutine CouplingsFor_VXp_decays_2B(m_in,i1,MAhinput,MAh2input,MDpminput,           & 
& MDpm2input,MFdinput,MFd2input,MFeinput,MFe2input,MFuinput,MFu2input,Mhhinput,          & 
& Mhh2input,MHpminput,MHpm2input,MVWpinput,MVWp2input,MVXpinput,MVXp2input,              & 
& MVZinput,MVZ2input,MVZpinput,MVZp2input,TWinput,Udinput,Ueinput,Uuinput,               & 
& Vdinput,Veinput,Vuinput,ZAinput,ZHinput,ZPinput,ZWinput,zyinput,ZZinput,               & 
& g1input,g2input,g3input,l1input,l12input,l13input,l12tinput,l13tinput,l2input,         & 
& l23input,l23tinput,l3input,hll1input,hdp11input,hd1input,hdtp11input,hdt1input,        & 
& hup11input,hUp1input,hdp1input,hd2input,hdtp1input,hdt2input,hup21input,               & 
& hUp2input,hd3input,hdt3input,hu11input,h12input,hU1input,hU2input,ftriinput,           & 
& mu12input,mu22input,mu32input,Vninput,v1input,v2input,cplAhcHpmcVXp,cplcFdFucVXpL,     & 
& cplcFdFucVXpR,cplhhcVXpVXp,cplhhcHpmcVXp,cplcDpmcVXpVWp,cplcVXpVXpVZ,cplcVXpVXpVZp,    & 
& cplcHpmcVXpVZ,cplcHpmcVXpVZp,cplcDpmcHpmcVXp,deltaM)

Implicit None 

Real(dp), Intent(in) :: m_in 
Real(dp), Intent(in) :: deltaM 
Integer, Intent(in) :: i1 
Real(dp),Intent(in) :: g1input,g2input,g3input,ftriinput,mu12input,mu22input,mu32input,Vninput,              & 
& v1input,v2input

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

Real(dp) :: g1,g2,g3,ftri,mu12,mu22,mu32,Vn,v1,v2

Complex(dp) :: l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,hll1(3,3),hdp11(3),hd1(3),hdtp11(2),              & 
& hdt1(2),hup11(3),hUp1,hdp1(3),hd2(3),hdtp1(2),hdt2(2),hup21(3),hUp2,hd3(3),            & 
& hdt3(2),hu11(3),h12(3),hU1,hU2

Complex(dp),Intent(out) :: cplAhcHpmcVXp(3,4),cplcFdFucVXpL(5,4),cplcFdFucVXpR(5,4),cplhhcVXpVXp(3),             & 
& cplhhcHpmcVXp(3,4),cplcDpmcVXpVWp(2),cplcVXpVXpVZ,cplcVXpVXpVZp,cplcHpmcVXpVZ(4),      & 
& cplcHpmcVXpVZp(4),cplcDpmcHpmcVXp(2,4)

Integer :: i2, i3, gt1, gt2, gt3, kont 
Real(dp) :: MAh(3),MAh2(3),MDpm(2),MDpm2(2),MFd(5),MFd2(5),MFe(3),MFe2(3),MFu(4),MFu2(4),         & 
& Mhh(3),Mhh2(3),MHpm(4),MHpm2(4),MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,TW

Complex(dp) :: Ud(5,5),Ue(3,3),Uu(4,4),Vd(5,5),Ve(3,3),Vu(4,4),ZA(3,3),ZH(3,3),ZP(4,4),              & 
& ZW(4,4),zy(2,2),ZZ(3,3)

Real(dp) :: gSM(11), sinW2, dt, tz, Qin 
Iname = Iname + 1 
NameOfUnit(Iname) = 'Couplings_VXp_2B'
 
sinW2=1._dp-mW2/mZ2 
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
Qin=sqrt(getRenormalizationScale()) 
Call SolveTadpoleEquations(g1,g2,g3,l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,              & 
& hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,hUp2,hd3,              & 
& hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,Vn,v1,v2,(/ ZeroC, ZeroC, ZeroC /))

! --- Calculate running tree-level masses for loop induced couplings and Quark mixing matrices --- 
Call TreeMasses(MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,MFe2,MFu,MFu2,Mhh,Mhh2,              & 
& MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,TW,Ud,Ue,Uu,Vd,Ve,Vu,             & 
& ZA,ZH,ZP,ZW,zy,ZZ,Vn,v1,v2,g1,g2,g3,l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,               & 
& hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,hUp2,hd3,              & 
& hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,.True.,kont)

If (ExternalZfactors) Then 
! --- Use the 1-loop mixing matrices calculated at M_SUSY in the vertices --- 
ZA = ZAinput 
ZH = ZHinput 
ZP = ZPinput 
ZW = ZWinput 
zy = zyinput 
ZZ = ZZinput 
End if 
If (PoleMassesInLoops) Then 
! --- Use the pole masses --- 
MAh = MAhinput 
MAh2 = MAh2input 
MDpm = MDpminput 
MDpm2 = MDpm2input 
MFd = MFdinput 
MFd2 = MFd2input 
MFe = MFeinput 
MFe2 = MFe2input 
MFu = MFuinput 
MFu2 = MFu2input 
Mhh = Mhhinput 
Mhh2 = Mhh2input 
MHpm = MHpminput 
MHpm2 = MHpm2input 
MVWp = MVWpinput 
MVWp2 = MVWp2input 
MVXp = MVXpinput 
MVXp2 = MVXp2input 
MVZ = MVZinput 
MVZ2 = MVZ2input 
MVZp = MVZpinput 
MVZp2 = MVZp2input 
End if 
cplAhcHpmcVXp = 0._dp 
Do gt1 = 1, 3
 Do gt2 = 1, 4
Call CouplingAhcHpmcVXpT(gt1,gt2,g2,ZA,ZP,cplAhcHpmcVXp(gt1,gt2))

 End Do 
End Do 


cplhhcHpmcVXp = 0._dp 
Do gt1 = 1, 3
 Do gt2 = 1, 4
Call CouplinghhcHpmcVXpT(gt1,gt2,g2,ZH,ZP,cplhhcHpmcVXp(gt1,gt2))

 End Do 
End Do 


cplcDpmcHpmcVXp = 0._dp 
Do gt1 = 1, 2
 Do gt2 = 1, 4
Call CouplingcDpmcHpmcVXpT(gt1,gt2,g2,ZP,zy,cplcDpmcHpmcVXp(gt1,gt2))

 End Do 
End Do 


cplhhcVXpVXp = 0._dp 
Do gt1 = 1, 3
Call CouplinghhcVXpVXpT(gt1,g2,Vn,v2,ZH,cplhhcVXpVXp(gt1))

End Do 


cplcDpmcVXpVWp = 0._dp 
Do gt1 = 1, 2
Call CouplingcDpmcVXpVWpT(gt1,g2,Vn,v1,zy,cplcDpmcVXpVWp(gt1))

End Do 


cplcHpmcVXpVZ = 0._dp 
Do gt1 = 1, 4
Call CouplingcHpmcVXpVZT(gt1,g1,g2,Vn,v2,ZZ,ZP,cplcHpmcVXpVZ(gt1))

End Do 


cplcHpmcVXpVZp = 0._dp 
Do gt1 = 1, 4
Call CouplingcHpmcVXpVZpT(gt1,g1,g2,Vn,v2,ZZ,ZP,cplcHpmcVXpVZp(gt1))

End Do 


cplcVXpVXpVZ = 0._dp 
Call CouplingcVXpVXpVZT(g2,ZZ,cplcVXpVXpVZ)



cplcVXpVXpVZp = 0._dp 
Call CouplingcVXpVXpVZpT(g2,ZZ,cplcVXpVXpVZp)



cplcFdFucVXpL = 0._dp 
cplcFdFucVXpR = 0._dp 
Do gt1 = 1, 5
 Do gt2 = 1, 4
Call CouplingcFdFucVXpT(gt1,gt2,g2,Vd,Vu,cplcFdFucVXpL(gt1,gt2),cplcFdFucVXpR(gt1,gt2))

 End Do 
End Do 


Iname = Iname - 1 
 
End subroutine CouplingsFor_VXp_decays_2B
 
Function NFlav(m_in) 
Implicit None 
Real(dp), Intent(in) :: m_in 
Real(dp) :: NFlav 
If (m_in.lt.mf_d(3)) Then 
  NFlav = 4._dp 
Else If (m_in.lt.mf_u(3)) Then 
  NFlav = 5._dp 
Else 
  NFlav = 6._dp 
End if 
End Function

Subroutine RunSM(scale_out,deltaM,tb,g1,g2,g3,Yu, Yd, Ye, vd, vu) 
Implicit None
Real(dp), Intent(in) :: scale_out,deltaM, tb
Real(dp), Intent(out) :: g1, g2, g3, vd, vu
Complex(dp), Intent(out) :: Yu(3,3), Yd(3,3), Ye(3,3)
Real(dp) :: dt, gSM(14), gSM2(2), gSM3(3), mtopMS,  sinw2, vev, tz, alphaStop 
Integer :: kont

RunningTopMZ = .false.

Yd = 0._dp
Ye = 0._dp
Yu = 0._dp

If (.not.RunningTopMZ) Then

! Calculating alpha_S(m_top)
gSM2(1)=sqrt(Alpha_mZ*4*Pi) 
gSM2(2)=sqrt(AlphaS_mZ*4*Pi) 


tz=Log(sqrt(mz2)/mf_u(3)) 
dt=tz/50._dp 
Call odeint(gSM2,2,tz,0._dp,deltaM,dt,0._dp,RGEAlphaS,kont)



alphaStop = gSM2(2)**2/4._dp/Pi



! m_top^pole to m_top^MS(m_top) 

mtopMS = mf_u(3)*(1._dp - 4._dp/3._dp*alphaStop/Pi)


! Running m_top^MS(m_top) to M_Z 

gSM3(1)=gSM2(1) 
gSM3(2)=gSM2(2)
gSM3(3)=mtopMS

tz=Log(sqrt(mz2)/mf_u(3)) 
dt=tz/50._dp 
Call odeint(gSM3,3,0._dp,tz,deltaM,dt,0._dp,RGEtop,kont)


mf_u_mz_running = gSM3(3)


RunningTopMZ = .True.

End if

! Starting values at MZ

gSM(1)=sqrt(Alpha_mZ*4*Pi) 
gSM(2)=sqrt(AlphaS_mZ*4*Pi) 
gSM(3)= 0.486E-03_dp ! mf_l_mz(1) 
gSM(4)= 0.10272 !mf_l_mz(2) 
gSM(5)= 1.74624 !mf_l_mz(3) 
gSM(6)= 1.27E-03_dp ! mf_u_mz(1) 
gSM(7)= 0.619  ! mf_u_mz(2) 
gSM(8)= mf_u_mz_running ! m_top 
gSM(9)= 2.9E-03_dp !mf_d_mz(1) 
gSM(10)= 0.055 !mf_d_mz(2) 
gSM(11)= 2.85 ! mf_d_mz(3) 
 

! To get the running sin(w2) 
SinW2 = 0.22290_dp
gSM(12) = 5._dp/3._dp*Alpha_MZ/(1-sinW2)
gSM(13) = Alpha_MZ/Sinw2
gSM(14) = AlphaS_mZ

  nUp =2._dp 
  nDown =3._dp 
  nLep =3._dp 
 

If (scale_out.gt.sqrt(mz2)) Then

 ! From M_Z to Min(M_top,scale_out) 
 If (scale_out.gt.mf_u(3)) Then 
  tz=Log(sqrt(mz2)/mf_u(3)) 
  dt=tz/50._dp 
 Else 
  tz=Log(sqrt(mz2)/scale_out) 
  dt=tz/50._dp 
 End if 

  Call odeint(gSM,14,tz,0._dp,deltaM,dt,0._dp,rge11,kont)


 ! From M_top to M_SUSY if M_top < M_SUSY 
 If (scale_out.gt.mf_u(3)) Then 
  tz=Log(mf_u(3)/scale_out) 
  dt=tz/50._dp 
  nUp =3._dp 
  Call odeint(gSM,14,tz,0._dp,deltaM,dt,0._dp,rge11,kont)
 End if 
Else

 ! From M_Z down to scale_out
  tz=Log(scale_out/sqrt(mz2)) 
  dt=tz/50._dp 
  Call odeint(gSM,14,0._dp,tz,deltaM,dt,0._dp,rge11_SMa,kont)

End if

! Calculating Couplings 

 sinW2=1._dp-mW2/mZ2 
 vev=Sqrt(mZ2*(1._dp-sinW2)*SinW2/(gSM(1)**2/4._dp))
 vd=vev/Sqrt(1._dp+tb**2)
 vu=tb*vd
 
Yd(1,1) =gSM(9)*sqrt(2._dp)/vd 
Yd(2,2) =gSM(10)*sqrt(2._dp)/vd 
Yd(3,3) =gSM(11)*sqrt(2._dp)/vd 
Ye(1,1) =gSM(3)*sqrt(2._dp)/vd 
Ye(2,2)=gSM(4)*sqrt(2._dp)/vd 
Ye(3,3)=gSM(5)*sqrt(2._dp)/vd 
Yu(1,1)=gSM(6)*sqrt(2._dp)/vu 
Yu(2,2)=gSM(7)*sqrt(2._dp)/vu 
Yu(3,3)=gSM(8)*sqrt(2._dp)/vu 


g3 =gSM(2) 
g3running=gSM(2) 

g1 = sqrt(gSM(12)*4._dp*Pi*3._dp/5._dp)
g2 = sqrt(gSM(13)*4._dp*Pi)
! g3 = sqrt(gSM(3)*4._dp*Pi)

sinw2 = g1**2/(g1**2 + g2**2)

!g2=gSM(1)/sqrt(sinW2) 
!g1 = g2*Sqrt(sinW2/(1._dp-sinW2)) 

If (GenerationMixing) Then 

If (YukawaScheme.Eq.1) Then ! CKM into Yu
 If (TransposedYukawa) Then ! check, if superpotential is Yu Hu u q  or Yu Hu q u
   Yu= Matmul(Transpose(CKM),Transpose(Yu))
 Else 
   Yu=Transpose(Matmul(Transpose(CKM),Transpose(Yu)))
 End if 

Else ! CKM into Yd 
 
 If (TransposedYukawa) Then ! 
  Yd= Matmul(Conjg(CKM),Transpose(Yd))
 Else 
  Yd=Transpose(Matmul(Conjg(CKM),Transpose(Yd)))
 End if 

End if ! Yukawa scheme
End If ! Generatoin mixing


End Subroutine RunSM


Subroutine RunSMohdm(scale_out,deltaM,g1,g2,g3,Yu, Yd, Ye, v) 
Implicit None
Real(dp), Intent(in) :: scale_out,deltaM
Real(dp), Intent(out) :: g1, g2, g3, v
Complex(dp), Intent(out) :: Yu(3,3), Yd(3,3), Ye(3,3)
Real(dp) :: dt, gSM(14), gSM2(2), gSM3(3), mtopMS,  sinw2, vev, tz, alphaStop 
Integer :: kont

Yd = 0._dp
Ye = 0._dp
Yu = 0._dp

If (.not.RunningTopMZ) Then

! Calculating alpha_S(m_top)
gSM2(1)=sqrt(Alpha_mZ*4*Pi) 
gSM2(2)=sqrt(AlphaS_mZ*4*Pi) 


tz=Log(sqrt(mz2)/mf_u(3)) 
dt=tz/50._dp 
Call odeint(gSM2,2,tz,0._dp,deltaM,dt,0._dp,RGEAlphaS,kont)



alphaStop = gSM2(2)**2/4._dp/Pi



! m_top^pole to m_top^MS(m_top) 

mtopMS = mf_u(3)*(1._dp - 4._dp/3._dp*alphaStop/Pi)


! Running m_top^MS(m_top) to M_Z 

gSM3(1)=gSM2(1) 
gSM3(2)=gSM2(2)
gSM3(3)=mtopMS

tz=Log(sqrt(mz2)/mf_u(3)) 
dt=tz/50._dp 
Call odeint(gSM3,3,0._dp,tz,deltaM,dt,0._dp,RGEtop,kont)


mf_u_mz_running = gSM3(3)


RunningTopMZ = .True.

End if

! Starting values at MZ

gSM(1)=sqrt(Alpha_mZ*4*Pi) 
gSM(2)=sqrt(AlphaS_mZ*4*Pi) 
gSM(3)= 0.486E-03_dp ! mf_l_mz(1) 
gSM(4)= 0.10272 !mf_l_mz(2) 
gSM(5)= 1.74624 !mf_l_mz(3) 
gSM(6)= 1.27E-03_dp ! mf_u_mz(1) 
gSM(7)= 0.619  ! mf_u_mz(2) 
gSM(8)= mf_u_mz_running ! m_top 
gSM(9)= 2.9E-03_dp !mf_d_mz(1) 
gSM(10)= 0.055 !mf_d_mz(2) 
gSM(11)= 2.85 ! mf_d_mz(3) 
 

! To get the running sin(w2) 
SinW2 = 0.22290_dp
gSM(12) = 5._dp/3._dp*Alpha_MZ/(1-sinW2)
gSM(13) = Alpha_MZ/Sinw2
gSM(14) = AlphaS_mZ

  nUp =2._dp 
  nDown =3._dp 
  nLep =3._dp 
 

If (scale_out.gt.sqrt(mz2)) Then

 ! From M_Z to Min(M_top,scale_out) 
 If (scale_out.gt.mf_u(3)) Then 
  tz=Log(sqrt(mz2)/mf_u(3)) 
  dt=tz/50._dp 
 Else 
  tz=Log(sqrt(mz2)/scale_out) 
  dt=tz/50._dp 
 End if 

  Call odeint(gSM,14,tz,0._dp,deltaM,dt,0._dp,rge11,kont)


 ! From M_top to M_SUSY if M_top < M_SUSY 
 If (scale_out.gt.mf_u(3)) Then 
  tz=Log(mf_u(3)/scale_out) 
  dt=tz/50._dp 
  nUp =3._dp 
  Call odeint(gSM,14,tz,0._dp,deltaM,dt,0._dp,rge11,kont)
 End if 
Else

 ! From M_Z down to scale_out
  If (abs(scale_out - sqrt(mz2)).gt.1.0E-3_dp) Then 
   tz=Log(scale_out/sqrt(mz2)) 
   dt=tz/50._dp 
   Call odeint(gSM,14,0._dp,tz,deltaM,dt,0._dp,rge11_SMa,kont)
  End if
End if

! Calculating Couplings 

 sinW2=1._dp-mW2/mZ2 
 vev=Sqrt(mZ2*(1._dp-sinW2)*SinW2/(gSM(1)**2/4._dp))
 v = vev
 
Yd(1,1) =gSM(9)*sqrt(2._dp)/v 
Yd(2,2) =gSM(10)*sqrt(2._dp)/v 
Yd(3,3) =gSM(11)*sqrt(2._dp)/v 
Ye(1,1) =gSM(3)*sqrt(2._dp)/v 
Ye(2,2)=gSM(4)*sqrt(2._dp)/v 
Ye(3,3)=gSM(5)*sqrt(2._dp)/v 
Yu(1,1)=gSM(6)*sqrt(2._dp)/v 
Yu(2,2)=gSM(7)*sqrt(2._dp)/v 
Yu(3,3)=gSM(8)*sqrt(2._dp)/v 


g3 =gSM(2) 
g3running=gSM(2) 

g1 = sqrt(gSM(12)*4._dp*Pi*3._dp/5._dp)
g2 = sqrt(gSM(13)*4._dp*Pi)
! g3 = sqrt(gSM(3)*4._dp*Pi)

sinw2 = g1**2/(g1**2 + g2**2)

g2=gSM(1)/sqrt(sinW2) 
g1 = g2*Sqrt(sinW2/(1._dp-sinW2)) 

If (GenerationMixing) Then 

If (YukawaScheme.Eq.1) Then ! CKM into Yu
 If (TransposedYukawa) Then ! check, if superpotential is Yu Hu u q  or Yu Hu q u
   Yu= Matmul(Transpose(CKM),Transpose(Yu))
 Else 
   Yu=Transpose(Matmul(Transpose(CKM),Transpose(Yu)))
 End if 

Else ! CKM into Yd 
 
 If (TransposedYukawa) Then ! 
  Yd= Matmul(Conjg(CKM),Transpose(Yd))
 Else 
  Yd=Transpose(Matmul(Conjg(CKM),Transpose(Yd)))
 End if 

End if ! Yukawa scheme
End If ! Generation mixing



End Subroutine RunSMohdm

Subroutine RunSMgauge(scale_out,deltaM,g1,g2,g3) 
Implicit None
Real(dp), Intent(in) :: scale_out,deltaM
Real(dp), Intent(out) :: g1, g2, g3
Complex(dp) :: Yu(3,3), Yd(3,3), Ye(3,3)
Real(dp) :: v, dt, gSM(14), gSM2(2), gSM3(3), mtopMS,  sinw2, vev, tz, alphaStop 
Integer :: kont

Yd = 0._dp
Ye = 0._dp
Yu = 0._dp

RunningTopMZ = .false.

If (.not.RunningTopMZ) Then

! Calculating alpha_S(m_top)
gSM2(1)=sqrt(Alpha_mZ*4*Pi) 
gSM2(2)=sqrt(AlphaS_mZ*4*Pi) 


tz=Log(sqrt(mz2)/mf_u(3)) 
dt=tz/50._dp 
Call odeint(gSM2,2,tz,0._dp,deltaM,dt,0._dp,RGEAlphaS,kont)



alphaStop = gSM2(2)**2/4._dp/Pi



! m_top^pole to m_top^MS(m_top) 

mtopMS = mf_u(3)*(1._dp - 4._dp/3._dp*alphaStop/Pi)


! Running m_top^MS(m_top) to M_Z 

gSM3(1)=gSM2(1) 
gSM3(2)=gSM2(2)
gSM3(3)=mtopMS

tz=Log(sqrt(mz2)/mf_u(3)) 
dt=tz/50._dp 
Call odeint(gSM3,3,0._dp,tz,deltaM,dt,0._dp,RGEtop,kont)


mf_u_mz_running = gSM3(3)


RunningTopMZ = .True.

End if

! Starting values at MZ

gSM(1)=sqrt(Alpha_mZ*4*Pi) 
gSM(2)=sqrt(AlphaS_mZ*4*Pi) 
gSM(3)= 0.486E-03_dp ! mf_l_mz(1) 
gSM(4)= 0.10272 !mf_l_mz(2) 
gSM(5)= 1.74624 !mf_l_mz(3) 
gSM(6)= 1.27E-03_dp ! mf_u_mz(1) 
gSM(7)= 0.619  ! mf_u_mz(2) 
gSM(8)= mf_u_mz_running ! m_top 
gSM(9)= 2.9E-03_dp !mf_d_mz(1) 
gSM(10)= 0.055 !mf_d_mz(2) 
gSM(11)= 2.85 ! mf_d_mz(3) 
 

! To get the running sin(w2) 
SinW2 = 0.22290_dp
gSM(12) = 5._dp/3._dp*Alpha_MZ/(1-sinW2)
gSM(13) = Alpha_MZ/Sinw2
gSM(14) = AlphaS_mZ

  nUp =2._dp 
  nDown =3._dp 
  nLep =3._dp 
 

If (scale_out.gt.sqrt(mz2)) Then

 ! From M_Z to Min(M_top,scale_out) 
 If (scale_out.gt.mf_u(3)) Then 
  tz=Log(sqrt(mz2)/mf_u(3)) 
  dt=tz/50._dp 
 Else 
  tz=Log(sqrt(mz2)/scale_out) 
  dt=tz/50._dp 
 End if 

  Call odeint(gSM,14,tz,0._dp,deltaM,dt,0._dp,rge11,kont)


 ! From M_top to M_SUSY if M_top < M_SUSY 
 If (scale_out.gt.mf_u(3)) Then 
  tz=Log(mf_u(3)/scale_out) 
  dt=tz/50._dp 
  nUp =3._dp 
  Call odeint(gSM,14,tz,0._dp,deltaM,dt,0._dp,rge11,kont)
 End if 
Else

 ! From M_Z down to scale_out
  tz=Log(scale_out/sqrt(mz2)) 
  dt=tz/50._dp 
  Call odeint(gSM,14,0._dp,tz,deltaM,dt,0._dp,rge11_SMa,kont)

End if

! Calculating Couplings 

 sinW2=1._dp-mW2/mZ2 
 vev=Sqrt(mZ2*(1._dp-sinW2)*SinW2/(gSM(1)**2/4._dp))
 v = vev
 
Yd(1,1) =gSM(9)*sqrt(2._dp)/v 
Yd(2,2) =gSM(10)*sqrt(2._dp)/v 
Yd(3,3) =gSM(11)*sqrt(2._dp)/v 
Ye(1,1) =gSM(3)*sqrt(2._dp)/v 
Ye(2,2)=gSM(4)*sqrt(2._dp)/v 
Ye(3,3)=gSM(5)*sqrt(2._dp)/v 
Yu(1,1)=gSM(6)*sqrt(2._dp)/v 
Yu(2,2)=gSM(7)*sqrt(2._dp)/v 
Yu(3,3)=gSM(8)*sqrt(2._dp)/v 


g3 =gSM(2) 
g3running=gSM(2) 

g1 = sqrt(gSM(12)*4._dp*Pi*3._dp/5._dp)
g2 = sqrt(gSM(13)*4._dp*Pi)
! g3 = sqrt(gSM(3)*4._dp*Pi)

sinw2 = g1**2/(g1**2 + g2**2)

g2=gSM(1)/sqrt(sinW2) 
g1 = g2*Sqrt(sinW2/(1._dp-sinW2)) 

If (GenerationMixing) Then 
If (TransposedYukawa) Then ! check, if superpotential is Yu Hu u q  or Yu Hu q u
 Yu= Matmul(Transpose(CKM),Transpose(Yu))
Else 
 Yu=Transpose(Matmul(Transpose(CKM),Transpose(Yu)))
End if 
End If


End Subroutine RunSMgauge
End Module CouplingsForDecays_331v3
