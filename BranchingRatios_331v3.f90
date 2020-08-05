! -----------------------------------------------------------------------------  
! This file was automatically created by SARAH version 4.14.3 
! SARAH References: arXiv:0806.0538, 0909.2863, 1002.0840, 1207.0906, 1309.7223  
! (c) Florian Staub, 2013  
! ------------------------------------------------------------------------------  
! File created at 16:44 on 3.7.2020   
! ----------------------------------------------------------------------  
 
 
Module BranchingRatios_331v3 
 
Use Control 
Use Settings 
Use Couplings_331v3 
Use Model_Data_331v3 
Use LoopCouplings_331v3 
Use TreeLevelDecays_331v3 


 Contains 
 
Subroutine CalculateBR(CTBD,fac3,epsI,deltaM,kont,MAh,MAh2,MDpm,MDpm2,MFd,            & 
& MFd2,MFe,MFe2,MFu,MFu2,Mhh,Mhh2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,             & 
& MVZp,MVZp2,TW,Ud,Ue,Uu,Vd,Ve,Vu,ZA,ZH,ZP,ZW,zy,ZZ,Vn,v1,v2,g1,g2,g3,l1,l12,            & 
& l13,l12t,l13t,l2,l23,l23t,l3,hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,               & 
& hd2,hdtp1,hdt2,hup21,hUp2,hd3,hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,               & 
& gPFu,gTFu,BRFu,gPFe,gTFe,BRFe,gPFd,gTFd,BRFd,gPhh,gThh,BRhh,gPAh,gTAh,BRAh,            & 
& gPHpm,gTHpm,BRHpm,gPDpm,gTDpm,BRDpm,gPVZ,gTVZ,BRVZ,gPVZp,gTVZp,BRVZp,gPVXp,            & 
& gTVXp,BRVXp)

Real(dp), Intent(in) :: epsI, deltaM, fac3 
Integer, Intent(inout) :: kont 
Logical, Intent(in) :: CTBD 
Real(dp),Intent(inout) :: g1,g2,g3,ftri,mu12,mu22,mu32

Complex(dp),Intent(inout) :: l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,hll1(3,3),hdp11(3),hd1(3),hdtp11(2),              & 
& hdt1(2),hup11(3),hUp1,hdp1(3),hd2(3),hdtp1(2),hdt2(2),hup21(3),hUp2,hd3(3),            & 
& hdt3(2),hu11(3),h12(3),hU1,hU2

Real(dp),Intent(in) :: MAh(3),MAh2(3),MDpm(2),MDpm2(2),MFd(5),MFd2(5),MFe(3),MFe2(3),MFu(4),MFu2(4),         & 
& Mhh(3),Mhh2(3),MHpm(4),MHpm2(4),MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,TW

Complex(dp),Intent(in) :: Ud(5,5),Ue(3,3),Uu(4,4),Vd(5,5),Ve(3,3),Vu(4,4),ZA(3,3),ZH(3,3),ZP(4,4),              & 
& ZW(4,4),zy(2,2),ZZ(3,3)

Real(dp),Intent(inout) :: Vn,v1,v2

Real(dp),Intent(inout) :: gPFu(4,60),gTFu(4),BRFu(4,60),gPFe(3,33),gTFe(3),BRFe(3,33),gPFd(5,66),               & 
& gTFd(5),BRFd(5,66),gPhh(3,83),gThh(3),BRhh(3,83),gPAh(3,80),gTAh(3),BRAh(3,80),        & 
& gPHpm(4,74),gTHpm(4),BRHpm(4,74),gPDpm(2,62),gTDpm(2),BRDpm(2,62),gPVZ(1,82),          & 
& gTVZ,BRVZ(1,82),gPVZp(1,82),gTVZp,BRVZp(1,82),gPVXp(1,43),gTVXp,BRVXp(1,43)

Complex(dp) :: cplHiggsPP(3),cplHiggsGG(3),cplPseudoHiggsPP(3),cplPseudoHiggsGG(3),cplHiggsZZvirt(3),& 
& cplHiggsWWvirt(3)

Complex(dp) :: coup 
Real(dp) :: vev 
Real(dp) :: gTVWp

Iname = Iname + 1 
NameOfUnit(Iname) = 'CalculateBR'
 
Write(*,*) "Calculating branching ratios and decay widths" 
gTVWp = gamW 
gTVZ = gamZ 
gPFu = 0._dp 
gTFu = 0._dp 
BRFu = 0._dp 
Call FuTwoBodyDecay(-1,DeltaM,MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,MFe2,MFu,              & 
& MFu2,Mhh,Mhh2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,TW,Ud,              & 
& Ue,Uu,Vd,Ve,Vu,ZA,ZH,ZP,ZW,zy,ZZ,g1,g2,g3,l1,l12,l13,l12t,l13t,l2,l23,l23t,            & 
& l3,hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,hUp2,               & 
& hd3,hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,Vn,v1,v2,gPFu,gTFu,BRFu)

Do i1=1,4
gTFu(i1) =Sum(gPFu(i1,:)) 
If (gTFu(i1).Gt.0._dp) BRFu(i1,: ) =gPFu(i1,:)/gTFu(i1) 
End Do 
 

gPFe = 0._dp 
gTFe = 0._dp 
BRFe = 0._dp 
Call FeTwoBodyDecay(-1,DeltaM,MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,MFe2,MFu,              & 
& MFu2,Mhh,Mhh2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,TW,Ud,              & 
& Ue,Uu,Vd,Ve,Vu,ZA,ZH,ZP,ZW,zy,ZZ,g1,g2,g3,l1,l12,l13,l12t,l13t,l2,l23,l23t,            & 
& l3,hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,hUp2,               & 
& hd3,hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,Vn,v1,v2,gPFe,gTFe,BRFe)

Do i1=1,3
gTFe(i1) =Sum(gPFe(i1,:)) 
If (gTFe(i1).Gt.0._dp) BRFe(i1,: ) =gPFe(i1,:)/gTFe(i1) 
End Do 
 

gPFd = 0._dp 
gTFd = 0._dp 
BRFd = 0._dp 
Call FdTwoBodyDecay(-1,DeltaM,MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,MFe2,MFu,              & 
& MFu2,Mhh,Mhh2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,TW,Ud,              & 
& Ue,Uu,Vd,Ve,Vu,ZA,ZH,ZP,ZW,zy,ZZ,g1,g2,g3,l1,l12,l13,l12t,l13t,l2,l23,l23t,            & 
& l3,hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,hUp2,               & 
& hd3,hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,Vn,v1,v2,gPFd,gTFd,BRFd)

Do i1=1,5
gTFd(i1) =Sum(gPFd(i1,:)) 
If (gTFd(i1).Gt.0._dp) BRFd(i1,: ) =gPFd(i1,:)/gTFd(i1) 
End Do 
 

gPhh = 0._dp 
gThh = 0._dp 
BRhh = 0._dp 
Call hhTwoBodyDecay(-1,DeltaM,MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,MFe2,MFu,              & 
& MFu2,Mhh,Mhh2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,TW,Ud,              & 
& Ue,Uu,Vd,Ve,Vu,ZA,ZH,ZP,ZW,zy,ZZ,g1,g2,g3,l1,l12,l13,l12t,l13t,l2,l23,l23t,            & 
& l3,hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,hUp2,               & 
& hd3,hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,Vn,v1,v2,gPhh,gThh,BRhh)

Do i1=1,3
gThh(i1) =Sum(gPhh(i1,:)) 
If (gThh(i1).Gt.0._dp) BRhh(i1,: ) =gPhh(i1,:)/gThh(i1) 
End Do 
 

gPAh = 0._dp 
gTAh = 0._dp 
BRAh = 0._dp 
Call AhTwoBodyDecay(-1,DeltaM,MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,MFe2,MFu,              & 
& MFu2,Mhh,Mhh2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,TW,Ud,              & 
& Ue,Uu,Vd,Ve,Vu,ZA,ZH,ZP,ZW,zy,ZZ,g1,g2,g3,l1,l12,l13,l12t,l13t,l2,l23,l23t,            & 
& l3,hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,hUp2,               & 
& hd3,hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,Vn,v1,v2,gPAh,gTAh,BRAh)

Do i1=1,3
gTAh(i1) =Sum(gPAh(i1,:)) 
If (gTAh(i1).Gt.0._dp) BRAh(i1,: ) =gPAh(i1,:)/gTAh(i1) 
End Do 
 

! Set Goldstone Widhts 
gTAh(1)=gTVZ
gTAh(2)=gTVZp


gPHpm = 0._dp 
gTHpm = 0._dp 
BRHpm = 0._dp 
Call HpmTwoBodyDecay(-1,DeltaM,MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,MFe2,MFu,             & 
& MFu2,Mhh,Mhh2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,TW,Ud,              & 
& Ue,Uu,Vd,Ve,Vu,ZA,ZH,ZP,ZW,zy,ZZ,g1,g2,g3,l1,l12,l13,l12t,l13t,l2,l23,l23t,            & 
& l3,hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,hUp2,               & 
& hd3,hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,Vn,v1,v2,gPHpm,gTHpm,BRHpm)

Do i1=1,4
gTHpm(i1) =Sum(gPHpm(i1,:)) 
If (gTHpm(i1).Gt.0._dp) BRHpm(i1,: ) =gPHpm(i1,:)/gTHpm(i1) 
End Do 
 

! Set Goldstone Widhts 
gTHpm(1)=gTVWp
gTHpm(2)=gTVXp


gPDpm = 0._dp 
gTDpm = 0._dp 
BRDpm = 0._dp 
Call DpmTwoBodyDecay(-1,DeltaM,MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,MFe2,MFu,             & 
& MFu2,Mhh,Mhh2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,TW,Ud,              & 
& Ue,Uu,Vd,Ve,Vu,ZA,ZH,ZP,ZW,zy,ZZ,g1,g2,g3,l1,l12,l13,l12t,l13t,l2,l23,l23t,            & 
& l3,hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,hUp2,               & 
& hd3,hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,Vn,v1,v2,gPDpm,gTDpm,BRDpm)

Do i1=1,2
gTDpm(i1) =Sum(gPDpm(i1,:)) 
If (gTDpm(i1).Gt.0._dp) BRDpm(i1,: ) =gPDpm(i1,:)/gTDpm(i1) 
End Do 
 

gPVZ = 0._dp 
gTVZ = 0._dp 
BRVZ = 0._dp 
Call VZTwoBodyDecay(-1,DeltaM,MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,MFe2,MFu,              & 
& MFu2,Mhh,Mhh2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,TW,Ud,              & 
& Ue,Uu,Vd,Ve,Vu,ZA,ZH,ZP,ZW,zy,ZZ,g1,g2,g3,l1,l12,l13,l12t,l13t,l2,l23,l23t,            & 
& l3,hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,hUp2,               & 
& hd3,hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,Vn,v1,v2,gPVZ,gTVZ,BRVZ)

Do i1=1,1
gTVZ =Sum(gPVZ(i1,:)) 
If (gTVZ.Gt.0._dp) BRVZ(i1,: ) =gPVZ(i1,:)/gTVZ 
End Do 
 

! Set Goldstone Widhts 
gTAh(1)=gTVZ


gPVZp = 0._dp 
gTVZp = 0._dp 
BRVZp = 0._dp 
Call VZpTwoBodyDecay(-1,DeltaM,MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,MFe2,MFu,             & 
& MFu2,Mhh,Mhh2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,TW,Ud,              & 
& Ue,Uu,Vd,Ve,Vu,ZA,ZH,ZP,ZW,zy,ZZ,g1,g2,g3,l1,l12,l13,l12t,l13t,l2,l23,l23t,            & 
& l3,hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,hUp2,               & 
& hd3,hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,Vn,v1,v2,gPVZp,gTVZp,BRVZp)

Do i1=1,1
gTVZp =Sum(gPVZp(i1,:)) 
If (gTVZp.Gt.0._dp) BRVZp(i1,: ) =gPVZp(i1,:)/gTVZp 
End Do 
 

! Set Goldstone Widhts 
gTAh(2)=gTVZp


gPVXp = 0._dp 
gTVXp = 0._dp 
BRVXp = 0._dp 
Call VXpTwoBodyDecay(-1,DeltaM,MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,MFe2,MFu,             & 
& MFu2,Mhh,Mhh2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,TW,Ud,              & 
& Ue,Uu,Vd,Ve,Vu,ZA,ZH,ZP,ZW,zy,ZZ,g1,g2,g3,l1,l12,l13,l12t,l13t,l2,l23,l23t,            & 
& l3,hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,hUp2,               & 
& hd3,hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,Vn,v1,v2,gPVXp,gTVXp,BRVXp)

Do i1=1,1
gTVXp =Sum(gPVXp(i1,:)) 
If (gTVXp.Gt.0._dp) BRVXp(i1,: ) =gPVXp(i1,:)/gTVXp 
End Do 
 

! Set Goldstone Widhts 
gTHpm(2)=gTVXp


! No 3-body decays for Fu  
! No 3-body decays for Fe  
! No 3-body decays for Fd  
! No 3-body decays for hh  
! No 3-body decays for Ah  
! No 3-body decays for Hpm  
! No 3-body decays for Dpm  
! No 3-body decays for VZ  
! No 3-body decays for VZp  
! No 3-body decays for VXp  
Iname = Iname - 1 
 
End Subroutine CalculateBR 
End Module BranchingRatios_331v3 
 