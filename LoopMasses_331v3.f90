! -----------------------------------------------------------------------------  
! This file was automatically created by SARAH version 4.14.3 
! SARAH References: arXiv:0806.0538, 0909.2863, 1002.0840, 1207.0906, 1309.7223  
! (c) Florian Staub, 2013  
! ------------------------------------------------------------------------------  
! File created at 16:43 on 3.7.2020   
! ----------------------------------------------------------------------  
 
 
Module LoopMasses_331v3 
 
Use Control 
Use Settings 
Use Couplings_331v3 
Use LoopFunctions 
Use AddLoopFunctions 
Use Mathematics 
Use MathematicsQP 
Use Model_Data_331v3 
Use StandardModel 
Use Tadpoles_331v3 
 Use Pole2L_331v3 
 Use TreeLevelMasses_331v3 
 
Real(dp), Private :: Mhh_1L(3), Mhh2_1L(3)  
Complex(dp), Private :: ZH_1L(3,3)  
Real(dp), Private :: MAh_1L(3), MAh2_1L(3)  
Complex(dp), Private :: ZA_1L(3,3)  
Real(dp), Private :: MHpm_1L(4), MHpm2_1L(4)  
Complex(dp), Private :: ZP_1L(4,4)  
Real(dp), Private :: MDpm_1L(2), MDpm2_1L(2)  
Complex(dp), Private :: zy_1L(2,2)  
Real(dp), Private :: MFd_1L(5), MFd2_1L(5)  
Complex(dp), Private :: Vd_1L(5,5),Ud_1L(5,5)
Real(dp), Private :: MFu_1L(4), MFu2_1L(4)  
Complex(dp), Private :: Vu_1L(4,4),Uu_1L(4,4)
Real(dp), Private :: MVZ_1L, MVZ2_1L  
Real(dp), Private :: MVZp_1L, MVZp2_1L  
Real(dp), Private :: MVWp_1L, MVWp2_1L  
Real(dp), Private :: MVXp_1L, MVXp2_1L  
Real(dp) :: pi2A0  
Real(dp) :: ti_ep2L(3)  
Real(dp) :: pi_ep2L(3,3)
Real(dp) :: Pi2S_EffPot(3,3)
Real(dp) :: PiP2S_EffPot(3,3)
Contains 
 
Subroutine OneLoopMasses(MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,MFe2,MFu,MFu2,              & 
& Mhh,Mhh2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,TW,Ud,Ue,Uu,             & 
& Vd,Ve,Vu,ZA,ZH,ZP,ZW,zy,ZZ,Vn,v1,v2,g1,g2,g3,l1,l12,l13,l12t,l13t,l2,l23,              & 
& l23t,l3,hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,               & 
& hUp2,hd3,hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,kont)

Implicit None 
Real(dp),Intent(inout) :: g1,g2,g3,ftri,mu12,mu22,mu32

Complex(dp),Intent(inout) :: l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,hll1(3,3),hdp11(3),hd1(3),hdtp11(2),              & 
& hdt1(2),hup11(3),hUp1,hdp1(3),hd2(3),hdtp1(2),hdt2(2),hup21(3),hUp2,hd3(3),            & 
& hdt3(2),hu11(3),h12(3),hU1,hU2

Real(dp),Intent(inout) :: MAh(3),MAh2(3),MDpm(2),MDpm2(2),MFd(5),MFd2(5),MFe(3),MFe2(3),MFu(4),MFu2(4),         & 
& Mhh(3),Mhh2(3),MHpm(4),MHpm2(4),MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,TW

Complex(dp),Intent(inout) :: Ud(5,5),Ue(3,3),Uu(4,4),Vd(5,5),Ve(3,3),Vu(4,4),ZA(3,3),ZH(3,3),ZP(4,4),              & 
& ZW(4,4),zy(2,2),ZZ(3,3)

Real(dp),Intent(inout) :: Vn,v1,v2

Complex(dp) :: cplAhAhcVWpVWp(3,3),cplAhAhcVXpVXp(3,3),cplAhAhUDpmcUDpm(3,3,2,2),cplAhAhUhh(3,3,3),  & 
& cplAhAhUhhUhh(3,3,3,3),cplAhAhUHpmcUHpm(3,3,4,4),cplAhAhVPVP(3,3),cplAhAhVPVZ(3,3),    & 
& cplAhAhVPVZp(3,3),cplAhAhVZpVZp(3,3),cplAhAhVZVZ(3,3),cplAhAhVZVZp(3,3),               & 
& cplAhcHpmcVWp(3,4),cplAhcHpmcVXp(3,4),cplAhcUHpmcVWp(3,4),cplAhcUHpmcVXp(3,4),         & 
& cplAhDpmcUDpm(3,2,2),cplAhhhVP(3,3),cplAhhhVZ(3,3),cplAhhhVZp(3,3),cplAhHpmcUHpm(3,4,4),& 
& cplAhHpmVWp(3,4),cplAhUhhhh(3,3,3),cplAhUhhVP(3,3),cplAhUhhVZ(3,3),cplAhUhhVZp(3,3),   & 
& cplcDpmcHpmcVXp(2,4),cplcDpmcUHpmcVXp(2,4),cplcDpmcVXpVWp(2),cplcFdFdcUDpmL(5,5,2),    & 
& cplcFdFdcUDpmR(5,5,2),cplcFdFdUAhL(5,5,3),cplcFdFdUAhR(5,5,3),cplcFdFdUhhL(5,5,3),     & 
& cplcFdFdUhhR(5,5,3),cplcFdFdVGL(5,5),cplcFdFdVGR(5,5),cplcFdFdVPL(5,5),cplcFdFdVPR(5,5),& 
& cplcFdFdVZL(5,5),cplcFdFdVZpL(5,5),cplcFdFdVZpR(5,5),cplcFdFdVZR(5,5),cplcFdFucVWpL(5,4),& 
& cplcFdFucVWpR(5,4),cplcFdFucVXpL(5,4),cplcFdFucVXpR(5,4),cplcFecUFv1HpmL(3,3,4),       & 
& cplcFecUFv1HpmR(3,3,4),cplcFeFeUAhL(3,3,3),cplcFeFeUAhR(3,3,3),cplcFeFeUhhL(3,3,3),    & 
& cplcFeFeUhhR(3,3,3),cplcFeFeVPL(3,3),cplcFeFeVPR(3,3),cplcFeFeVZL(3,3),cplcFeFeVZpL(3,3),& 
& cplcFeFeVZpR(3,3),cplcFeFeVZR(3,3),cplcFeFv1cVWpL(3,3),cplcFeFv1cVWpR(3,3),            & 
& cplcFuFdcUHpmL(4,5,4),cplcFuFdcUHpmR(4,5,4),cplcFuFdVWpL(4,5),cplcFuFdVWpR(4,5),       & 
& cplcFuFucUDpmL(4,4,2),cplcFuFucUDpmR(4,4,2),cplcFuFuUAhL(4,4,3),cplcFuFuUAhR(4,4,3),   & 
& cplcFuFuUhhL(4,4,3),cplcFuFuUhhR(4,4,3),cplcFuFuVGL(4,4),cplcFuFuVGR(4,4),             & 
& cplcFuFuVPL(4,4),cplcFuFuVPR(4,4),cplcFuFuVZL(4,4),cplcFuFuVZpL(4,4),cplcFuFuVZpR(4,4),& 
& cplcFuFuVZR(4,4),cplcFv1FecUHpmL(3,3,4),cplcFv1FecUHpmR(3,3,4),cplcFv1Fv1VPL(3,3),     & 
& cplcFv1Fv1VPR(3,3),cplcFv1Fv1VZL(3,3),cplcFv1Fv1VZpL(3,3),cplcFv1Fv1VZpR(3,3),         & 
& cplcFv1Fv1VZR(3,3),cplcgAgWpcVWp,cplcgAgXp1cVXp,cplcgGgGVG,cplcgWCgAcVWp,              & 
& cplcgWCgWCUAh(3),cplcgWCgWCUhh(3),cplcgWCgWCVP,cplcgWCgWCVZ,cplcgWCgWCVZp,             & 
& cplcgWCgXp2cUDpm(2),cplcgWCgZcVWp,cplcgWCgZpcVWp,cplcgWCgZpUHpm(4),cplcgWCgZUHpm(4),   & 
& cplcgWpgWpUAh(3),cplcgWpgWpUhh(3),cplcgWpgWpVP,cplcgWpgWpVZ,cplcgWpgWpVZp,             & 
& cplcgWpgXp1UDpm(2),cplcgWpgZcUHpm(4),cplcgWpgZpcUHpm(4),cplcgXp1gWpcUDpm(2),           & 
& cplcgXp1gXp1UAh(3),cplcgXp1gXp1Uhh(3),cplcgXp1gXp1VP,cplcgXp1gXp1VZ,cplcgXp1gXp1VZp,   & 
& cplcgXp1gZcUHpm(4),cplcgXp1gZpcUHpm(4),cplcgXp2gAcVXp,cplcgXp2gWCUDpm(2),              & 
& cplcgXp2gXp2UAh(3),cplcgXp2gXp2Uhh(3),cplcgXp2gXp2VP,cplcgXp2gXp2VZ,cplcgXp2gXp2VZp,   & 
& cplcgXp2gZcVXp,cplcgXp2gZpcVXp,cplcgXp2gZpUHpm(4),cplcgXp2gZUHpm(4),cplcgZgWCcUHpm(4), & 
& cplcgZgWpcVWp,cplcgZgWpUHpm(4),cplcgZgXp1cVXp,cplcgZgXp1UHpm(4),cplcgZgXp2cUHpm(4),    & 
& cplcgZgZpUhh(3),cplcgZgZUhh(3),cplcgZpgWCcUHpm(4),cplcgZpgWpcVWp,cplcgZpgWpUHpm(4),    & 
& cplcgZpgXp1cVXp,cplcgZpgXp1UHpm(4),cplcgZpgXp2cUHpm(4),cplcgZpgZpUhh(3),               & 
& cplcgZpgZUhh(3),cplcHpmcVWpVP(4),cplcHpmcVWpVZ(4),cplcHpmcVWpVZp(4),cplcHpmcVXpVP(4),  & 
& cplcHpmcVXpVZ(4),cplcHpmcVXpVZp(4),cplcUDpmcHpmcVXp(2,4),cplcUDpmcVXpVWp(2),           & 
& cplcUFdFdAhL(5,5,3),cplcUFdFdAhR(5,5,3),cplcUFdFdDpmL(5,5,2),cplcUFdFdDpmR(5,5,2),     & 
& cplcUFdFdhhL(5,5,3),cplcUFdFdhhR(5,5,3),cplcUFdFdVGL(5,5),cplcUFdFdVGR(5,5),           & 
& cplcUFdFdVPL(5,5),cplcUFdFdVPR(5,5),cplcUFdFdVZL(5,5),cplcUFdFdVZpL(5,5)

Complex(dp) :: cplcUFdFdVZpR(5,5),cplcUFdFdVZR(5,5),cplcUFdFucVWpL(5,4),cplcUFdFucVWpR(5,4),          & 
& cplcUFdFucVXpL(5,4),cplcUFdFucVXpR(5,4),cplcUFdFuHpmL(5,4,4),cplcUFdFuHpmR(5,4,4),     & 
& cplcUFecFv1HpmL(3,3,4),cplcUFecFv1HpmR(3,3,4),cplcUFeFeAhL(3,3,3),cplcUFeFeAhR(3,3,3), & 
& cplcUFeFehhL(3,3,3),cplcUFeFehhR(3,3,3),cplcUFeFeVPL(3,3),cplcUFeFeVPR(3,3),           & 
& cplcUFeFeVZL(3,3),cplcUFeFeVZpL(3,3),cplcUFeFeVZpR(3,3),cplcUFeFeVZR(3,3),             & 
& cplcUFeFv1cVWpL(3,3),cplcUFeFv1cVWpR(3,3),cplcUFeFv1HpmL(3,3,4),cplcUFeFv1HpmR(3,3,4), & 
& cplcUFuFdcHpmL(4,5,4),cplcUFuFdcHpmR(4,5,4),cplcUFuFdVWpL(4,5),cplcUFuFdVWpR(4,5),     & 
& cplcUFuFdVXpL(4,5),cplcUFuFdVXpR(4,5),cplcUFuFuAhL(4,4,3),cplcUFuFuAhR(4,4,3),         & 
& cplcUFuFuDpmL(4,4,2),cplcUFuFuDpmR(4,4,2),cplcUFuFuhhL(4,4,3),cplcUFuFuhhR(4,4,3),     & 
& cplcUFuFuVGL(4,4),cplcUFuFuVGR(4,4),cplcUFuFuVPL(4,4),cplcUFuFuVPR(4,4),               & 
& cplcUFuFuVZL(4,4),cplcUFuFuVZpL(4,4),cplcUFuFuVZpR(4,4),cplcUFuFuVZR(4,4),             & 
& cplcUFv1FecHpmL(3,3,4),cplcUFv1FecHpmR(3,3,4),cplcUFv1FeVWpL(3,3),cplcUFv1FeVWpR(3,3), & 
& cplcUFv1Fv1VPL(3,3),cplcUFv1Fv1VPR(3,3),cplcUFv1Fv1VZL(3,3),cplcUFv1Fv1VZpL(3,3),      & 
& cplcUFv1Fv1VZpR(3,3),cplcUFv1Fv1VZR(3,3),cplcUHpmcVWpVP(4),cplcUHpmcVWpVZ(4),          & 
& cplcUHpmcVWpVZp(4),cplcUHpmcVXpVP(4),cplcUHpmcVXpVZ(4),cplcUHpmcVXpVZp(4),             & 
& cplcVWpcVWpVWpVWp1,cplcVWpcVWpVWpVWp2,cplcVWpcVWpVWpVWp3,cplcVWpcVXpVWpVXp1,           & 
& cplcVWpcVXpVWpVXp2,cplcVWpcVXpVWpVXp3,cplcVWpVPVPVWp1,cplcVWpVPVPVWp2,cplcVWpVPVPVWp3, & 
& cplcVWpVPVWp,cplcVWpVPVWpVZ1,cplcVWpVPVWpVZ2,cplcVWpVPVWpVZ3,cplcVWpVPVWpVZp1,         & 
& cplcVWpVPVWpVZp2,cplcVWpVPVWpVZp3,cplcVWpVWpVZ,cplcVWpVWpVZp,cplcVWpVWpVZpVZp1,        & 
& cplcVWpVWpVZpVZp2,cplcVWpVWpVZpVZp3,cplcVWpVWpVZVZ1,cplcVWpVWpVZVZ2,cplcVWpVWpVZVZ3,   & 
& cplcVWpVWpVZVZp1,cplcVWpVWpVZVZp2,cplcVWpVWpVZVZp3,cplcVXpcVXpVXpVXp1,cplcVXpcVXpVXpVXp2,& 
& cplcVXpcVXpVXpVXp3,cplcVXpVPVPVXp1,cplcVXpVPVPVXp2,cplcVXpVPVPVXp3,cplcVXpVPVXp,       & 
& cplcVXpVPVXpVZ1,cplcVXpVPVXpVZ2,cplcVXpVPVXpVZ3,cplcVXpVPVXpVZp1,cplcVXpVPVXpVZp2,     & 
& cplcVXpVPVXpVZp3,cplcVXpVXpVZ,cplcVXpVXpVZp,cplcVXpVXpVZpVZp1,cplcVXpVXpVZpVZp2,       & 
& cplcVXpVXpVZpVZp3,cplcVXpVXpVZVZ1,cplcVXpVXpVZVZ2,cplcVXpVXpVZVZ3,cplcVXpVXpVZVZp1,    & 
& cplcVXpVXpVZVZp2,cplcVXpVXpVZVZp3,cplDpmcDpmcVWpVWp(2,2),cplDpmcDpmcVXpVXp(2,2),       & 
& cplDpmcDpmVP(2,2),cplDpmcDpmVPVP(2,2),cplDpmcDpmVPVZ(2,2),cplDpmcDpmVPVZp(2,2),        & 
& cplDpmcDpmVZ(2,2),cplDpmcDpmVZp(2,2),cplDpmcDpmVZpVZp(2,2),cplDpmcDpmVZVZ(2,2),        & 
& cplDpmcDpmVZVZp(2,2),cplDpmcHpmcVWp(2,4),cplDpmcUDpmVP(2,2),cplDpmcUDpmVZ(2,2),        & 
& cplDpmcUDpmVZp(2,2),cplDpmcUHpmcVWp(2,4),cplDpmcVWpVXp(2),cplDpmhhcUDpm(2,3,2),        & 
& cplDpmHpmcUHpm(2,4,4),cplDpmUhhcDpm(2,3,2),cplDpmUhhUhhcDpm(2,3,3,2),cplDpmUHpmcDpmcUHpm(2,4,2,4),& 
& cplFeFv1cUHpmL(3,3,4),cplFeFv1cUHpmR(3,3,4),cplhhcHpmcVWp(3,4),cplhhcHpmcVXp(3,4),     & 
& cplhhcUHpmcVWp(3,4),cplhhcUHpmcVXp(3,4),cplhhcVWpVWp(3),cplhhcVXpVXp(3),               & 
& cplhhhhcVWpVWp(3,3),cplhhhhcVXpVXp(3,3),cplhhhhUHpmcUHpm(3,3,4,4),cplhhhhVPVP(3,3),    & 
& cplhhhhVPVZ(3,3),cplhhhhVPVZp(3,3),cplhhhhVZpVZp(3,3),cplhhhhVZVZ(3,3),cplhhhhVZVZp(3,3),& 
& cplhhHpmcUHpm(3,4,4),cplhhHpmVWp(3,4),cplhhVPVZ(3),cplhhVPVZp(3),cplhhVZpVZp(3),       & 
& cplhhVZVZ(3),cplhhVZVZp(3),cplHpmcHpmcVWpVWp(4,4),cplHpmcHpmcVXpVWp(4,4)

Complex(dp) :: cplHpmcHpmcVXpVXp(4,4),cplHpmcHpmVP(4,4),cplHpmcHpmVPVP(4,4),cplHpmcHpmVPVZ(4,4),      & 
& cplHpmcHpmVPVZp(4,4),cplHpmcHpmVZ(4,4),cplHpmcHpmVZp(4,4),cplHpmcHpmVZpVZp(4,4),       & 
& cplHpmcHpmVZVZ(4,4),cplHpmcHpmVZVZp(4,4),cplHpmcUDpmcHpm(4,2,4),cplHpmcUDpmVWp(4,2),   & 
& cplHpmcUHpmVP(4,4),cplHpmcUHpmVZ(4,4),cplHpmcUHpmVZp(4,4),cplHpmVPVWp(4),              & 
& cplHpmVPVXp(4),cplHpmVWpVZ(4),cplHpmVWpVZp(4),cplHpmVXpVZ(4),cplHpmVXpVZp(4),          & 
& cplUAhAhAh(3,3,3),cplUAhAhhh(3,3,3),cplUAhDpmcDpm(3,2,2),cplUAhhhhh(3,3,3),            & 
& cplUAhhhVP(3,3),cplUAhhhVZ(3,3),cplUAhhhVZp(3,3),cplUAhHpmcHpm(3,4,4),cplUAhHpmVWp(3,4),& 
& cplUAhHpmVXp(3,4),cplUAhUAhAhAh(3,3,3,3),cplUAhUAhcVWpVWp(3,3),cplUAhUAhcVXpVXp(3,3),  & 
& cplUAhUAhDpmcDpm(3,3,2,2),cplUAhUAhhhhh(3,3,3,3),cplUAhUAhHpmcHpm(3,3,4,4),            & 
& cplUAhUAhVPVP(3,3),cplUAhUAhVZpVZp(3,3),cplUAhUAhVZVZ(3,3),cplUDpmcUDpmcVWpVWp(2,2),   & 
& cplUDpmcUDpmcVXpVXp(2,2),cplUDpmcUDpmVPVP(2,2),cplUDpmcUDpmVZpVZp(2,2),cplUDpmcUDpmVZVZ(2,2),& 
& cplUDpmDpmcUDpmcDpm(2,2,2,2),cplUDpmhhhhcUDpm(2,3,3,2),cplUDpmHpmcUDpmcHpm(2,4,2,4),   & 
& cplUhhcVWpVWp(3),cplUhhcVXpVXp(3),cplUhhhhhh(3,3,3),cplUhhHpmcHpm(3,4,4),              & 
& cplUhhHpmVWp(3,4),cplUhhHpmVXp(3,4),cplUhhUhhcVWpVWp(3,3),cplUhhUhhcVXpVXp(3,3),       & 
& cplUhhUhhhhhh(3,3,3,3),cplUhhUhhHpmcHpm(3,3,4,4),cplUhhUhhVPVP(3,3),cplUhhUhhVZpVZp(3,3),& 
& cplUhhUhhVZVZ(3,3),cplUhhVPVZ(3),cplUhhVPVZp(3),cplUhhVZpVZp(3),cplUhhVZVZ(3),         & 
& cplUhhVZVZp(3),cplUHpmcUHpmcVWpVWp(4,4),cplUHpmcUHpmcVXpVXp(4,4),cplUHpmcUHpmVPVP(4,4),& 
& cplUHpmcUHpmVZpVZp(4,4),cplUHpmcUHpmVZVZ(4,4),cplUHpmHpmcUHpmcHpm(4,4,4,4),            & 
& cplVGVGVG,cplVGVGVGVG1,cplVGVGVGVG2,cplVGVGVGVG3

Integer , Intent(inout):: kont 
Integer :: i1,i2,i3,i4,j1, j2, j3, j4, il, i_count, ierr 
Integer :: i2L, iFin 
Logical :: Convergence2L 
Real(dp) :: Pi2S_EffPot_save(3,3), diff(3,3)
Complex(dp) :: Tad1Loop(3), dmz2  
Real(dp) :: comp(3), tanbQ, vev2, vSM
Iname = Iname + 1 
NameOfUnit(Iname) = 'OneLoopMasses' 
 
kont = 0 
 
! Set Gauge fixing parameters 
RXi= RXiNew 
RXiG = RXi 
RXiP = RXi 
RXiWp = RXi 
RXiXp = RXi 
RXiZ = RXi 
RXiZp = RXi 

 ! Running angles 

 
Call TreeMasses(MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,MFe2,MFu,MFu2,Mhh,Mhh2,              & 
& MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,TW,Ud,Ue,Uu,Vd,Ve,Vu,             & 
& ZA,ZH,ZP,ZW,zy,ZZ,Vn,v1,v2,g1,g2,g3,l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,               & 
& hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,hUp2,hd3,              & 
& hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,GenerationMixing,kont)

mu12Tree  = mu12
mu22Tree  = mu22
mu32Tree  = mu32

 
 If (CalculateOneLoopMasses) Then 
 
If ((DecoupleAtRenScale).and.(Abs(1._dp-RXiNew).lt.0.01_dp)) Then 
vSM=vSM_Q 
v2=vSM 
Else 
Call CouplingsForVectorBosons(g1,g2,ZZ,ZH,ZA,zy,Vd,Vu,Uu,Vn,v1,v2,ZP,Ve,              & 
& cplAhhhVP,cplDpmcDpmVP,cplcFdFdVPL,cplcFdFdVPR,cplcFeFeVPL,cplcFeFeVPR,cplcFuFuVPL,    & 
& cplcFuFuVPR,cplcFv1Fv1VPL,cplcFv1Fv1VPR,cplcgWpgWpVP,cplcgWCgWCVP,cplcgXp1gXp1VP,      & 
& cplcgXp2gXp2VP,cplhhVPVZ,cplhhVPVZp,cplHpmcHpmVP,cplHpmVPVWp,cplHpmVPVXp,              & 
& cplcVWpVPVWp,cplcVXpVPVXp,cplAhAhVPVP,cplDpmcDpmVPVP,cplhhhhVPVP,cplHpmcHpmVPVP,       & 
& cplcVWpVPVPVWp1,cplcVWpVPVPVWp2,cplcVWpVPVPVWp3,cplcVXpVPVPVXp1,cplcVXpVPVPVXp2,       & 
& cplcVXpVPVPVXp3,cplAhhhVZ,cplDpmcDpmVZ,cplcFdFdVZL,cplcFdFdVZR,cplcFeFeVZL,            & 
& cplcFeFeVZR,cplcFuFuVZL,cplcFuFuVZR,cplcFv1Fv1VZL,cplcFv1Fv1VZR,cplcgWpgWpVZ,          & 
& cplcgWCgWCVZ,cplcgXp1gXp1VZ,cplcgXp2gXp2VZ,cplhhVZVZ,cplhhVZVZp,cplHpmcHpmVZ,          & 
& cplHpmVWpVZ,cplHpmVXpVZ,cplcVWpVWpVZ,cplcVXpVXpVZ,cplAhAhVZVZ,cplDpmcDpmVZVZ,          & 
& cplhhhhVZVZ,cplHpmcHpmVZVZ,cplcVWpVWpVZVZ1,cplcVWpVWpVZVZ2,cplcVWpVWpVZVZ3,            & 
& cplcVXpVXpVZVZ1,cplcVXpVXpVZVZ2,cplcVXpVXpVZVZ3,cplHpmVWpVZp,cplcVWpVWpVZp,            & 
& cplcVWpVWpVZpVZp1,cplcVWpVWpVZpVZp2,cplcVWpVWpVZpVZp3,cplAhcHpmcVWp,cplDpmcHpmcVWp,    & 
& cplDpmcVWpVXp,cplcFdFucVWpL,cplcFdFucVWpR,cplcFeFv1cVWpL,cplcFeFv1cVWpR,               & 
& cplcgWCgAcVWp,cplcgAgWpcVWp,cplcgZgWpcVWp,cplcgZpgWpcVWp,cplcgWCgZcVWp,cplcgWCgZpcVWp, & 
& cplhhcHpmcVWp,cplhhcVWpVWp,cplcHpmcVWpVP,cplcHpmcVWpVZ,cplcHpmcVWpVZp,cplAhAhcVWpVWp,  & 
& cplDpmcDpmcVWpVWp,cplhhhhcVWpVWp,cplHpmcHpmcVWpVWp,cplcVWpcVWpVWpVWp1,cplcVWpcVWpVWpVWp2,& 
& cplcVWpcVWpVWpVWp3,cplcVWpcVXpVWpVXp1,cplcVWpcVXpVWpVXp2,cplcVWpcVXpVWpVXp3,           & 
& cplcHpmcVXpVP,cplcDpmcVXpVWp,cplcHpmcVXpVZ,cplAhAhVPVZ,cplDpmcDpmVPVZ,cplhhhhVPVZ,     & 
& cplHpmcHpmVPVZ,cplcVWpVPVWpVZ1,cplcVWpVPVWpVZ2,cplcVWpVPVWpVZ3,cplcVXpVPVXpVZ1,        & 
& cplcVXpVPVXpVZ2,cplcVXpVPVXpVZ3,cplAhAhVPVZp,cplDpmcDpmVPVZp,cplhhhhVPVZp,             & 
& cplHpmcHpmVPVZp,cplcVWpVPVWpVZp1,cplcVWpVPVWpVZp2,cplcVWpVPVWpVZp3,cplcVXpVPVXpVZp1,   & 
& cplcVXpVPVXpVZp2,cplcVXpVPVXpVZp3,cplAhAhVZVZp,cplDpmcDpmVZVZp,cplhhhhVZVZp,           & 
& cplHpmcHpmVZVZp,cplcVWpVWpVZVZp1,cplcVWpVWpVZVZp2,cplcVWpVWpVZVZp3,cplcVXpVXpVZVZp1,   & 
& cplcVXpVXpVZVZp2,cplcVXpVXpVZVZp3,cplAhHpmVWp,cplcFuFdVWpL,cplcFuFdVWpR,               & 
& cplhhHpmVWp,cplHpmcHpmcVXpVWp)

End if 
Call SolveTadpoleEquations(g1,g2,g3,l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,              & 
& hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,hUp2,hd3,              & 
& hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,Vn,v1,v2,(/ ZeroC, ZeroC, ZeroC /))

Call TreeMasses(MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,MFe2,MFu,MFu2,Mhh,Mhh2,              & 
& MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,TW,Ud,Ue,Uu,Vd,Ve,Vu,             & 
& ZA,ZH,ZP,ZW,zy,ZZ,Vn,v1,v2,g1,g2,g3,l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,               & 
& hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,hUp2,hd3,              & 
& hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,GenerationMixing,kont)

Call CouplingsForLoopMasses(ftri,l1,l12,l13,l2,l23,l3,Vn,v1,v2,ZA,ZH,g1,              & 
& g2,ZZ,l12t,zy,hdp11,hd1,hdtp11,hdt1,hdp1,hd2,hdtp1,hdt2,hd3,hdt3,Vd,Ud,hll1,           & 
& Ve,Ue,hup11,hUp1,hup21,hUp2,hu11,h12,hU1,hU2,Vu,Uu,l13t,l23t,ZP,h12l,g3,               & 
& cplAhAhUhh,cplAhUhhhh,cplAhUhhVP,cplAhUhhVZ,cplAhUhhVZp,cplDpmUhhcDpm,cplcFdFdUhhL,    & 
& cplcFdFdUhhR,cplcFeFeUhhL,cplcFeFeUhhR,cplcFuFuUhhL,cplcFuFuUhhR,cplcgWpgWpUhh,        & 
& cplcgWCgWCUhh,cplcgXp1gXp1Uhh,cplcgXp2gXp2Uhh,cplcgZgZUhh,cplcgZpgZUhh,cplcgZgZpUhh,   & 
& cplcgZpgZpUhh,cplUhhhhhh,cplUhhHpmcHpm,cplUhhHpmVWp,cplUhhHpmVXp,cplUhhVPVZ,           & 
& cplUhhVPVZp,cplUhhcVWpVWp,cplUhhcVXpVXp,cplUhhVZVZ,cplUhhVZVZp,cplUhhVZpVZp,           & 
& cplAhAhUhhUhh,cplDpmUhhUhhcDpm,cplUhhUhhhhhh,cplUhhUhhHpmcHpm,cplUhhUhhVPVP,           & 
& cplUhhUhhcVWpVWp,cplUhhUhhcVXpVXp,cplUhhUhhVZVZ,cplUhhUhhVZpVZp,cplUAhAhAh,            & 
& cplUAhAhhh,cplUAhDpmcDpm,cplcFdFdUAhL,cplcFdFdUAhR,cplcFeFeUAhL,cplcFeFeUAhR,          & 
& cplcFuFuUAhL,cplcFuFuUAhR,cplcgWpgWpUAh,cplcgWCgWCUAh,cplcgXp1gXp1UAh,cplcgXp2gXp2UAh, & 
& cplUAhhhhh,cplUAhhhVP,cplUAhhhVZ,cplUAhhhVZp,cplUAhHpmcHpm,cplUAhHpmVWp,               & 
& cplUAhHpmVXp,cplUAhUAhAhAh,cplUAhUAhDpmcDpm,cplUAhUAhhhhh,cplUAhUAhHpmcHpm,            & 
& cplUAhUAhVPVP,cplUAhUAhcVWpVWp,cplUAhUAhcVXpVXp,cplUAhUAhVZVZ,cplUAhUAhVZpVZp,         & 
& cplAhcUHpmcVWp,cplAhcUHpmcVXp,cplAhHpmcUHpm,cplDpmcUHpmcVWp,cplDpmHpmcUHpm,            & 
& cplcFuFdcUHpmL,cplcFuFdcUHpmR,cplcFv1FecUHpmL,cplcFv1FecUHpmR,cplFeFv1cUHpmL,          & 
& cplFeFv1cUHpmR,cplcgZgWCcUHpm,cplcgWCgZUHpm,cplcgZpgWCcUHpm,cplcgWCgZpUHpm,            & 
& cplcgZgXp2cUHpm,cplcgXp2gZUHpm,cplcgZpgXp2cUHpm,cplcgXp2gZpUHpm,cplcgWpgZcUHpm,        & 
& cplcgZgWpUHpm,cplcgXp1gZcUHpm,cplcgZgXp1UHpm,cplcgWpgZpcUHpm,cplcgZpgWpUHpm,           & 
& cplcgXp1gZpcUHpm,cplcgZpgXp1UHpm,cplhhcUHpmcVWp,cplhhcUHpmcVXp,cplhhHpmcUHpm,          & 
& cplHpmcUHpmVP,cplHpmcUHpmVZ,cplHpmcUHpmVZp,cplcUHpmcVWpVP,cplcUHpmcVXpVP,              & 
& cplcUHpmcVWpVZ,cplcUHpmcVXpVZ,cplcUHpmcVWpVZp,cplcUHpmcVXpVZp,cplcDpmcUHpmcVXp,        & 
& cplAhAhUHpmcUHpm,cplDpmUHpmcDpmcUHpm,cplhhhhUHpmcUHpm,cplUHpmHpmcUHpmcHpm,             & 
& cplUHpmcUHpmVPVP,cplUHpmcUHpmcVWpVWp,cplUHpmcUHpmcVXpVXp,cplUHpmcUHpmVZVZ,             & 
& cplUHpmcUHpmVZpVZp,cplAhDpmcUDpm,cplDpmhhcUDpm,cplDpmcUDpmVP,cplDpmcUDpmVZ,            & 
& cplDpmcUDpmVZp,cplcFdFdcUDpmL,cplcFdFdcUDpmR,cplcFuFucUDpmL,cplcFuFucUDpmR,            & 
& cplcgXp1gWpcUDpm,cplcgWpgXp1UDpm,cplcgWCgXp2cUDpm,cplcgXp2gWCUDpm,cplHpmcUDpmcHpm,     & 
& cplHpmcUDpmVWp,cplcUDpmcVXpVWp,cplcUDpmcHpmcVXp,cplAhAhUDpmcUDpm,cplUDpmDpmcUDpmcDpm,  & 
& cplUDpmhhhhcUDpm,cplUDpmHpmcUDpmcHpm,cplUDpmcUDpmVPVP,cplUDpmcUDpmcVWpVWp,             & 
& cplUDpmcUDpmcVXpVXp,cplUDpmcUDpmVZVZ,cplUDpmcUDpmVZpVZp,cplcUFdFdAhL,cplcUFdFdAhR,     & 
& cplcUFdFdDpmL,cplcUFdFdDpmR,cplcUFdFdhhL,cplcUFdFdhhR,cplcUFdFdVGL,cplcUFdFdVGR,       & 
& cplcUFdFdVPL,cplcUFdFdVPR,cplcUFdFdVZL,cplcUFdFdVZR,cplcUFdFdVZpL,cplcUFdFdVZpR,       & 
& cplcUFdFucVWpL,cplcUFdFucVWpR,cplcUFdFucVXpL,cplcUFdFucVXpR,cplcUFdFuHpmL,             & 
& cplcUFdFuHpmR,cplcUFuFuAhL,cplcUFuFuAhR,cplcUFuFuDpmL,cplcUFuFuDpmR,cplcUFuFdcHpmL,    & 
& cplcUFuFdcHpmR,cplcUFuFdVWpL,cplcUFuFdVWpR,cplcUFuFdVXpL,cplcUFuFdVXpR,cplcUFuFuhhL,   & 
& cplcUFuFuhhR,cplcUFuFuVGL,cplcUFuFuVGR,cplcUFuFuVPL,cplcUFuFuVPR,cplcUFuFuVZL,         & 
& cplcUFuFuVZR,cplcUFuFuVZpL,cplcUFuFuVZpR,cplcUFeFeAhL,cplcUFeFeAhR,cplcUFeFehhL,       & 
& cplcUFeFehhR,cplcUFeFeVPL,cplcUFeFeVPR,cplcUFeFeVZL,cplcUFeFeVZR,cplcUFeFeVZpL,        & 
& cplcUFeFeVZpR,cplcUFeFv1cVWpL,cplcUFeFv1cVWpR,cplcUFeFv1HpmL,cplcUFeFv1HpmR,           & 
& cplcUFecFv1HpmL,cplcUFecFv1HpmR,cplcUFv1FecHpmL,cplcUFv1FecHpmR,cplcUFv1FeVWpL,        & 
& cplcUFv1FeVWpR,cplcUFv1Fv1VPL,cplcUFv1Fv1VPR,cplcUFv1Fv1VZL,cplcUFv1Fv1VZR,            & 
& cplcUFv1Fv1VZpL,cplcUFv1Fv1VZpR,cplcFecUFv1HpmL,cplcFecUFv1HpmR,cplcFdFdVGL,           & 
& cplcFdFdVGR,cplcFuFuVGL,cplcFuFuVGR,cplcgGgGVG,cplVGVGVG,cplVGVGVGVG1,cplVGVGVGVG2,    & 
& cplVGVGVGVG3,cplAhhhVP,cplDpmcDpmVP,cplcFdFdVPL,cplcFdFdVPR,cplcFeFeVPL,               & 
& cplcFeFeVPR,cplcFuFuVPL,cplcFuFuVPR,cplcFv1Fv1VPL,cplcFv1Fv1VPR,cplcgWpgWpVP,          & 
& cplcgWCgWCVP,cplcgXp1gXp1VP,cplcgXp2gXp2VP,cplhhVPVZ,cplhhVPVZp,cplHpmcHpmVP,          & 
& cplHpmVPVWp,cplHpmVPVXp,cplcVWpVPVWp,cplcVXpVPVXp,cplAhAhVPVP,cplDpmcDpmVPVP,          & 
& cplhhhhVPVP,cplHpmcHpmVPVP,cplcVWpVPVPVWp1,cplcVWpVPVPVWp2,cplcVWpVPVPVWp3,            & 
& cplcVXpVPVPVXp1,cplcVXpVPVPVXp2,cplcVXpVPVPVXp3,cplAhhhVZ,cplDpmcDpmVZ,cplcFdFdVZL,    & 
& cplcFdFdVZR,cplcFeFeVZL,cplcFeFeVZR,cplcFuFuVZL,cplcFuFuVZR,cplcFv1Fv1VZL,             & 
& cplcFv1Fv1VZR,cplcgWpgWpVZ,cplcgWCgWCVZ,cplcgXp1gXp1VZ,cplcgXp2gXp2VZ,cplhhVZVZ,       & 
& cplhhVZVZp,cplHpmcHpmVZ,cplHpmVWpVZ,cplHpmVXpVZ,cplcVWpVWpVZ,cplcVXpVXpVZ,             & 
& cplAhAhVZVZ,cplDpmcDpmVZVZ,cplhhhhVZVZ,cplHpmcHpmVZVZ,cplcVWpVWpVZVZ1,cplcVWpVWpVZVZ2, & 
& cplcVWpVWpVZVZ3,cplcVXpVXpVZVZ1,cplcVXpVXpVZVZ2,cplcVXpVXpVZVZ3,cplAhhhVZp,            & 
& cplDpmcDpmVZp,cplcFdFdVZpL,cplcFdFdVZpR,cplcFeFeVZpL,cplcFeFeVZpR,cplcFuFuVZpL,        & 
& cplcFuFuVZpR,cplcFv1Fv1VZpL,cplcFv1Fv1VZpR,cplcgWpgWpVZp,cplcgWCgWCVZp,cplcgXp1gXp1VZp,& 
& cplcgXp2gXp2VZp,cplhhVZpVZp,cplHpmcHpmVZp,cplHpmVWpVZp,cplHpmVXpVZp,cplcVWpVWpVZp,     & 
& cplcVXpVXpVZp,cplAhAhVZpVZp,cplDpmcDpmVZpVZp,cplhhhhVZpVZp,cplHpmcHpmVZpVZp,           & 
& cplcVWpVWpVZpVZp1,cplcVWpVWpVZpVZp2,cplcVWpVWpVZpVZp3,cplcVXpVXpVZpVZp1,               & 
& cplcVXpVXpVZpVZp2,cplcVXpVXpVZpVZp3,cplAhcHpmcVWp,cplDpmcHpmcVWp,cplDpmcVWpVXp,        & 
& cplcFdFucVWpL,cplcFdFucVWpR,cplcFeFv1cVWpL,cplcFeFv1cVWpR,cplcgWCgAcVWp,               & 
& cplcgAgWpcVWp,cplcgZgWpcVWp,cplcgZpgWpcVWp,cplcgWCgZcVWp,cplcgWCgZpcVWp,               & 
& cplhhcHpmcVWp,cplhhcVWpVWp,cplcHpmcVWpVP,cplcHpmcVWpVZ,cplcHpmcVWpVZp,cplAhAhcVWpVWp,  & 
& cplDpmcDpmcVWpVWp,cplhhhhcVWpVWp,cplHpmcHpmcVWpVWp,cplcVWpcVWpVWpVWp1,cplcVWpcVWpVWpVWp2,& 
& cplcVWpcVWpVWpVWp3,cplcVWpcVXpVWpVXp1,cplcVWpcVXpVWpVXp2,cplcVWpcVXpVWpVXp3,           & 
& cplAhcHpmcVXp,cplcFdFucVXpL,cplcFdFucVXpR,cplcgXp2gAcVXp,cplcgAgXp1cVXp,               & 
& cplcgZgXp1cVXp,cplcgZpgXp1cVXp,cplcgXp2gZcVXp,cplcgXp2gZpcVXp,cplhhcHpmcVXp,           & 
& cplhhcVXpVXp,cplcHpmcVXpVP,cplcDpmcVXpVWp,cplcHpmcVXpVZ,cplcHpmcVXpVZp,cplcDpmcHpmcVXp,& 
& cplAhAhcVXpVXp,cplDpmcDpmcVXpVXp,cplhhhhcVXpVXp,cplHpmcHpmcVXpVXp,cplcVXpcVXpVXpVXp1,  & 
& cplcVXpcVXpVXpVXp2,cplcVXpcVXpVXpVXp3,cplAhAhVPVZ,cplDpmcDpmVPVZ,cplhhhhVPVZ,          & 
& cplHpmcHpmVPVZ,cplcVWpVPVWpVZ1,cplcVWpVPVWpVZ2,cplcVWpVPVWpVZ3,cplcVXpVPVXpVZ1,        & 
& cplcVXpVPVXpVZ2,cplcVXpVPVXpVZ3,cplAhAhVPVZp,cplDpmcDpmVPVZp,cplhhhhVPVZp,             & 
& cplHpmcHpmVPVZp,cplcVWpVPVWpVZp1,cplcVWpVPVWpVZp2,cplcVWpVPVWpVZp3,cplcVXpVPVXpVZp1,   & 
& cplcVXpVPVXpVZp2,cplcVXpVPVXpVZp3,cplAhAhVZVZp,cplDpmcDpmVZVZp,cplhhhhVZVZp,           & 
& cplHpmcHpmVZVZp,cplcVWpVWpVZVZp1,cplcVWpVWpVZVZp2,cplcVWpVWpVZVZp3,cplcVXpVXpVZVZp1,   & 
& cplcVXpVXpVZVZp2,cplcVXpVXpVZVZp3,cplAhHpmVWp,cplcFuFdVWpL,cplcFuFdVWpR,               & 
& cplhhHpmVWp,cplHpmcHpmcVXpVWp)

Call OneLoopTadpoleshh(Vn,v1,v2,MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,MFe2,MFu,            & 
& MFu2,Mhh,Mhh2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,cplAhAhUhh,         & 
& cplDpmUhhcDpm,cplcFdFdUhhL,cplcFdFdUhhR,cplcFeFeUhhL,cplcFeFeUhhR,cplcFuFuUhhL,        & 
& cplcFuFuUhhR,cplcgWpgWpUhh,cplcgWCgWCUhh,cplcgXp1gXp1Uhh,cplcgXp2gXp2Uhh,              & 
& cplcgZgZUhh,cplcgZpgZpUhh,cplUhhhhhh,cplUhhHpmcHpm,cplUhhcVWpVWp,cplUhhcVXpVXp,        & 
& cplUhhVZVZ,cplUhhVZpVZp,Tad1Loop(1:3))

mu12Tree  = mu12
mu22Tree  = mu22
mu32Tree  = mu32
If (CalculateTwoLoopHiggsMasses) Then 
    If(GaugelessLimit) Then 
  VnFix = 0._dp 
  v1Fix = 0._dp 
  v2Fix = 0._dp 
   g1_saveEP =g1
   g1 = 0._dp 
   g2_saveEP =g2
   g2 = 0._dp 
     Else 
  VnFix = Vn 
  v1Fix = v1 
  v2Fix = v2 
     End if 

SELECT CASE (TwoLoopMethod) 
CASE ( 1 , 2 ) 


 CASE ( 3 ) ! Diagrammatic method 
  ! Make sure that there are no exactly degenerated masses! 
   hll1_saveEP =hll1
   where (aint(Abs(hll1)).eq.hll1) hll1=hll1*(1 + 1*1.0E-12_dp)

If (NewGBC) Then 
Call CalculatePi2S(125._dp**2,Vn,v1,v2,g1,g2,g3,l1,l12,l13,l12t,l13t,l2,              & 
& l23,l23t,l3,hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,           & 
& hUp2,hd3,hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,kont,ti_ep2L,Pi2S_EffPot,           & 
& PiP2S_EffPot)

Else 
Call CalculatePi2S(0._dp,Vn,v1,v2,g1,g2,g3,l1,l12,l13,l12t,l13t,l2,l23,               & 
& l23t,l3,hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,               & 
& hUp2,hd3,hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,kont,ti_ep2L,Pi2S_EffPot,           & 
& PiP2S_EffPot)

End if 
   hll1 =hll1_saveEP 


 CASE ( 8 , 9 ) ! Hard-coded routines 
  
 END SELECT
 
   If(GaugelessLimit) Then 
   g1 =g1_saveEP 
   g2 =g2_saveEP 
   End if 

Else ! Two loop turned off 
Pi2S_EffPot = 0._dp 

Pi2A0 = 0._dp 

ti_ep2L = 0._dp 

End if 
Call SolveTadpoleEquations(g1,g2,g3,l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,              & 
& hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,hUp2,hd3,              & 
& hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,Vn,v1,v2,Tad1Loop)

mu121L = mu12
mu221L = mu22
mu321L = mu32
Tad1Loop(1:3) = Tad1Loop(1:3) - ti_ep2L 
Call SolveTadpoleEquations(g1,g2,g3,l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,              & 
& hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,hUp2,hd3,              & 
& hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,Vn,v1,v2,Tad1Loop)

mu122L = mu12
mu222L = mu22
mu322L = mu32
Call OneLoophh(mu122L,mu222L,mu322L,ftri,l1,l12,l13,l2,l23,l3,Vn,v1,v2,               & 
& MAh,MAh2,Mhh,Mhh2,MVZ,MVZ2,MVZp,MVZp2,MDpm,MDpm2,MFd,MFd2,MFe,MFe2,MFu,MFu2,           & 
& MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,cplAhAhUhh,cplAhUhhhh,cplAhUhhVP,cplAhUhhVZ,          & 
& cplAhUhhVZp,cplDpmUhhcDpm,cplcFdFdUhhL,cplcFdFdUhhR,cplcFeFeUhhL,cplcFeFeUhhR,         & 
& cplcFuFuUhhL,cplcFuFuUhhR,cplcgWpgWpUhh,cplcgWCgWCUhh,cplcgXp1gXp1Uhh,cplcgXp2gXp2Uhh, & 
& cplcgZgZUhh,cplcgZpgZUhh,cplcgZgZpUhh,cplcgZpgZpUhh,cplUhhhhhh,cplUhhHpmcHpm,          & 
& cplUhhHpmVWp,cplUhhHpmVXp,cplUhhVPVZ,cplUhhVPVZp,cplUhhcVWpVWp,cplUhhcVXpVXp,          & 
& cplUhhVZVZ,cplUhhVZVZp,cplUhhVZpVZp,cplAhAhUhhUhh,cplDpmUhhUhhcDpm,cplUhhUhhhhhh,      & 
& cplUhhUhhHpmcHpm,cplUhhUhhVPVP,cplUhhUhhcVWpVWp,cplUhhUhhcVXpVXp,cplUhhUhhVZVZ,        & 
& cplUhhUhhVZpVZp,0.1_dp*delta_mass,Mhh_1L,Mhh2_1L,ZH_1L,kont)

If (TwoLoopMethod.gt.2) Then 
Call OneLoopAh(g1,g2,mu122L,mu222L,mu322L,ftri,l1,l12,l13,l2,l23,l3,Vn,               & 
& v1,v2,ZZ,MAh,MAh2,Mhh,Mhh2,MDpm,MDpm2,MFd,MFd2,MFe,MFe2,MFu,MFu2,MVZ,MVZ2,             & 
& MVZp,MVZp2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,cplUAhAhAh,cplUAhAhhh,cplUAhDpmcDpm,       & 
& cplcFdFdUAhL,cplcFdFdUAhR,cplcFeFeUAhL,cplcFeFeUAhR,cplcFuFuUAhL,cplcFuFuUAhR,         & 
& cplcgWpgWpUAh,cplcgWCgWCUAh,cplcgXp1gXp1UAh,cplcgXp2gXp2UAh,cplUAhhhhh,cplUAhhhVP,     & 
& cplUAhhhVZ,cplUAhhhVZp,cplUAhHpmcHpm,cplUAhHpmVWp,cplUAhHpmVXp,cplUAhUAhAhAh,          & 
& cplUAhUAhDpmcDpm,cplUAhUAhhhhh,cplUAhUAhHpmcHpm,cplUAhUAhVPVP,cplUAhUAhcVWpVWp,        & 
& cplUAhUAhcVXpVXp,cplUAhUAhVZVZ,cplUAhUAhVZpVZp,0.1_dp*delta_mass,MAh_1L,               & 
& MAh2_1L,ZA_1L,kont)

Else 
Call OneLoopAh(g1,g2,mu121L,mu221L,mu321L,ftri,l1,l12,l13,l2,l23,l3,Vn,               & 
& v1,v2,ZZ,MAh,MAh2,Mhh,Mhh2,MDpm,MDpm2,MFd,MFd2,MFe,MFe2,MFu,MFu2,MVZ,MVZ2,             & 
& MVZp,MVZp2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,cplUAhAhAh,cplUAhAhhh,cplUAhDpmcDpm,       & 
& cplcFdFdUAhL,cplcFdFdUAhR,cplcFeFeUAhL,cplcFeFeUAhR,cplcFuFuUAhL,cplcFuFuUAhR,         & 
& cplcgWpgWpUAh,cplcgWCgWCUAh,cplcgXp1gXp1UAh,cplcgXp2gXp2UAh,cplUAhhhhh,cplUAhhhVP,     & 
& cplUAhhhVZ,cplUAhhhVZp,cplUAhHpmcHpm,cplUAhHpmVWp,cplUAhHpmVXp,cplUAhUAhAhAh,          & 
& cplUAhUAhDpmcDpm,cplUAhUAhhhhh,cplUAhUAhHpmcHpm,cplUAhUAhVPVP,cplUAhUAhcVWpVWp,        & 
& cplUAhUAhcVXpVXp,cplUAhUAhVZVZ,cplUAhUAhVZpVZp,0.1_dp*delta_mass,MAh_1L,               & 
& MAh2_1L,ZA_1L,kont)

End if 
Call OneLoopHpm(g2,mu121L,mu221L,mu321L,ftri,l1,l12,l13,l13t,l2,l23,l23t,             & 
& l3,Vn,v1,v2,MVWp,MVWp2,MAh,MAh2,MVXp,MVXp2,MHpm,MHpm2,MDpm,MDpm2,MFu,MFu2,             & 
& MFd,MFd2,MFe,MFe2,Mhh,Mhh2,MVZ,MVZ2,MVZp,MVZp2,cplAhcUHpmcVWp,cplAhcUHpmcVXp,          & 
& cplAhHpmcUHpm,cplDpmcUHpmcVWp,cplDpmHpmcUHpm,cplcFuFdcUHpmL,cplcFuFdcUHpmR,            & 
& cplcFv1FecUHpmL,cplcFv1FecUHpmR,cplFeFv1cUHpmL,cplFeFv1cUHpmR,cplcgZgWCcUHpm,          & 
& cplcgWCgZUHpm,cplcgZpgWCcUHpm,cplcgWCgZpUHpm,cplcgZgXp2cUHpm,cplcgXp2gZUHpm,           & 
& cplcgZpgXp2cUHpm,cplcgXp2gZpUHpm,cplcgWpgZcUHpm,cplcgZgWpUHpm,cplcgXp1gZcUHpm,         & 
& cplcgZgXp1UHpm,cplcgWpgZpcUHpm,cplcgZpgWpUHpm,cplcgXp1gZpcUHpm,cplcgZpgXp1UHpm,        & 
& cplhhcUHpmcVWp,cplhhcUHpmcVXp,cplhhHpmcUHpm,cplHpmcUHpmVP,cplHpmcUHpmVZ,               & 
& cplHpmcUHpmVZp,cplcUHpmcVWpVP,cplcUHpmcVXpVP,cplcUHpmcVWpVZ,cplcUHpmcVXpVZ,            & 
& cplcUHpmcVWpVZp,cplcUHpmcVXpVZp,cplcDpmcUHpmcVXp,cplAhAhUHpmcUHpm,cplDpmUHpmcDpmcUHpm, & 
& cplhhhhUHpmcUHpm,cplUHpmHpmcUHpmcHpm,cplUHpmcUHpmVPVP,cplUHpmcUHpmcVWpVWp,             & 
& cplUHpmcUHpmcVXpVXp,cplUHpmcUHpmVZVZ,cplUHpmcUHpmVZpVZp,0.1_dp*delta_mass,             & 
& MHpm_1L,MHpm2_1L,ZP_1L,kont)

Call OneLoopDpm(mu121L,mu221L,ftri,l1,l12,l13,l12t,l2,l23,Vn,v1,v2,MDpm,              & 
& MDpm2,MAh,MAh2,Mhh,Mhh2,MVZ,MVZ2,MVZp,MVZp2,MFd,MFd2,MFu,MFu2,MHpm,MHpm2,              & 
& MVWp,MVWp2,MVXp,MVXp2,cplAhDpmcUDpm,cplDpmhhcUDpm,cplDpmcUDpmVP,cplDpmcUDpmVZ,         & 
& cplDpmcUDpmVZp,cplcFdFdcUDpmL,cplcFdFdcUDpmR,cplcFuFucUDpmL,cplcFuFucUDpmR,            & 
& cplcgXp1gWpcUDpm,cplcgWpgXp1UDpm,cplcgWCgXp2cUDpm,cplcgXp2gWCUDpm,cplHpmcUDpmcHpm,     & 
& cplHpmcUDpmVWp,cplcUDpmcVXpVWp,cplcUDpmcHpmcVXp,cplAhAhUDpmcUDpm,cplUDpmDpmcUDpmcDpm,  & 
& cplUDpmhhhhcUDpm,cplUDpmHpmcUDpmcHpm,cplUDpmcUDpmVPVP,cplUDpmcUDpmcVWpVWp,             & 
& cplUDpmcUDpmcVXpVXp,cplUDpmcUDpmVZVZ,cplUDpmcUDpmVZpVZp,0.1_dp*delta_mass,             & 
& MDpm_1L,MDpm2_1L,zy_1L,kont)

Call OneLoopFd(hdp11,hd1,hdtp11,hdt1,hdp1,hd2,hdtp1,hdt2,hd3,hdt3,Vn,v1,              & 
& v2,MFd,MFd2,MAh,MAh2,MDpm,MDpm2,Mhh,Mhh2,MVZ,MVZ2,MVZp,MVZp2,MVWp,MVWp2,               & 
& MFu,MFu2,MVXp,MVXp2,MHpm,MHpm2,cplcUFdFdAhL,cplcUFdFdAhR,cplcUFdFdDpmL,cplcUFdFdDpmR,  & 
& cplcUFdFdhhL,cplcUFdFdhhR,cplcUFdFdVGL,cplcUFdFdVGR,cplcUFdFdVPL,cplcUFdFdVPR,         & 
& cplcUFdFdVZL,cplcUFdFdVZR,cplcUFdFdVZpL,cplcUFdFdVZpR,cplcUFdFucVWpL,cplcUFdFucVWpR,   & 
& cplcUFdFucVXpL,cplcUFdFucVXpR,cplcUFdFuHpmL,cplcUFdFuHpmR,0.1_dp*delta_mass,           & 
& MFd_1L,MFd2_1L,Vd_1L,Ud_1L,kont)

Call OneLoopFu(hup11,hUp1,hup21,hUp2,hu11,h12,hU1,hU2,Vn,v1,v2,MFu,MFu2,              & 
& MAh,MAh2,MDpm,MDpm2,MHpm,MHpm2,MFd,MFd2,MVWp,MVWp2,MVXp,MVXp2,Mhh,Mhh2,MVZ,            & 
& MVZ2,MVZp,MVZp2,cplcUFuFuAhL,cplcUFuFuAhR,cplcUFuFuDpmL,cplcUFuFuDpmR,cplcUFuFdcHpmL,  & 
& cplcUFuFdcHpmR,cplcUFuFdVWpL,cplcUFuFdVWpR,cplcUFuFdVXpL,cplcUFuFdVXpR,cplcUFuFuhhL,   & 
& cplcUFuFuhhR,cplcUFuFuVGL,cplcUFuFuVGR,cplcUFuFuVPL,cplcUFuFuVPR,cplcUFuFuVZL,         & 
& cplcUFuFuVZR,cplcUFuFuVZpL,cplcUFuFuVZpR,0.1_dp*delta_mass,MFu_1L,MFu2_1L,             & 
& Vu_1L,Uu_1L,kont)

Call OneLoopVZp(g1,g2,Vn,v1,v2,ZZ,Mhh,Mhh2,MAh,MAh2,MDpm,MDpm2,MFd,MFd2,              & 
& MFe,MFe2,MFu,MFu2,MVZ,MVZ2,MVZp,MVZp2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,cplAhhhVZp,     & 
& cplDpmcDpmVZp,cplcFdFdVZpL,cplcFdFdVZpR,cplcFeFeVZpL,cplcFeFeVZpR,cplcFuFuVZpL,        & 
& cplcFuFuVZpR,cplcFv1Fv1VZpL,cplcFv1Fv1VZpR,cplcgWpgWpVZp,cplcgWCgWCVZp,cplcgXp1gXp1VZp,& 
& cplcgXp2gXp2VZp,cplhhVPVZp,cplhhVZVZp,cplhhVZpVZp,cplHpmcHpmVZp,cplHpmVWpVZp,          & 
& cplHpmVXpVZp,cplcVWpVWpVZp,cplcVXpVXpVZp,cplAhAhVZpVZp,cplDpmcDpmVZpVZp,               & 
& cplhhhhVZpVZp,cplHpmcHpmVZpVZp,cplcVWpVWpVZpVZp1,cplcVWpVWpVZpVZp2,cplcVWpVWpVZpVZp3,  & 
& cplcVXpVXpVZpVZp1,cplcVXpVXpVZpVZp2,cplcVXpVXpVZpVZp3,0.1_dp*delta_mass,               & 
& MVZp_1L,MVZp2_1L,kont)

Call OneLoopVXp(g2,Vn,v2,MHpm,MHpm2,MAh,MAh2,MFd,MFd2,MFu,MFu2,Mhh,Mhh2,              & 
& MVXp,MVXp2,MDpm,MDpm2,MVWp,MVWp2,MVZ,MVZ2,MVZp,MVZp2,cplAhcHpmcVXp,cplcFdFucVXpL,      & 
& cplcFdFucVXpR,cplcgXp2gAcVXp,cplcgAgXp1cVXp,cplcgZgXp1cVXp,cplcgZpgXp1cVXp,            & 
& cplcgXp2gZcVXp,cplcgXp2gZpcVXp,cplhhcHpmcVXp,cplhhcVXpVXp,cplcHpmcVXpVP,               & 
& cplcVXpVPVXp,cplcDpmcVXpVWp,cplcVXpVXpVZ,cplcVXpVXpVZp,cplcHpmcVXpVZ,cplcHpmcVXpVZp,   & 
& cplcDpmcHpmcVXp,cplAhAhcVXpVXp,cplDpmcDpmcVXpVXp,cplhhhhcVXpVXp,cplHpmcHpmcVXpVXp,     & 
& cplcVXpVPVPVXp3,cplcVXpVPVPVXp1,cplcVXpVPVPVXp2,cplcVWpcVXpVWpVXp2,cplcVWpcVXpVWpVXp3, & 
& cplcVWpcVXpVWpVXp1,cplcVXpcVXpVXpVXp2,cplcVXpcVXpVXpVXp3,cplcVXpcVXpVXpVXp1,           & 
& cplcVXpVXpVZVZ1,cplcVXpVXpVZVZ2,cplcVXpVXpVZVZ3,cplcVXpVXpVZpVZp1,cplcVXpVXpVZpVZp2,   & 
& cplcVXpVXpVZpVZp3,0.1_dp*delta_mass,MVXp_1L,MVXp2_1L,kont)

Mhh = Mhh_1L 
Mhh2 = Mhh2_1L 
ZH = ZH_1L 
MAh = MAh_1L 
MAh2 = MAh2_1L 
ZA = ZA_1L 
MHpm = MHpm_1L 
MHpm2 = MHpm2_1L 
ZP = ZP_1L 
MDpm = MDpm_1L 
MDpm2 = MDpm2_1L 
zy = zy_1L 
MFd = MFd_1L 
MFd2 = MFd2_1L 
Vd = Vd_1L 
Ud = Ud_1L 
MFu = MFu_1L 
MFu2 = MFu2_1L 
Vu = Vu_1L 
Uu = Uu_1L 
MVZp = MVZp_1L 
MVZp2 = MVZp2_1L 
MVXp = MVXp_1L 
MVXp2 = MVXp2_1L 
End If 
 
Call SortGoldstones(MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,MFe2,MFu,MFu2,Mhh,               & 
& Mhh2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,TW,Ud,Ue,Uu,Vd,              & 
& Ve,Vu,ZA,ZH,ZP,ZW,zy,ZZ,kont)

! Set pole masses 
MVWp = mW 
MVWp2 = mW2 
MVZ = mZ 
MVZ2 = mZ2 
MFe(1:3) = mf_l 
MFe2(1:3) = mf_l**2 
!MFu(1:3) = mf_u 
!MFu2(1:3) = mf_u**2 
!MFd(1:3) = mf_d 
!MFd2(1:3) = mf_d**2 
! Shift Everything to t'Hooft Gauge
RXi=  1._dp 
RXiG = 1._dp 
RXiP = 1._dp 
RXiWp = 1._dp 
RXiXp = 1._dp 
RXiZ = 1._dp 
RXiZp = 1._dp 
MAh(1)=MVZ
MAh2(1)=MVZ2
MAh(2)=MVZp
MAh2(2)=MVZp2
MHpm(1)=MVWp
MHpm2(1)=MVWp2
MHpm(2)=MVXp
MHpm2(2)=MVXp2
mf_u2 = mf_u**2 
mf_d2 = mf_d**2 
mf_l2 = mf_l**2 
 

 If (WriteTreeLevelTadpoleSolutions) Then 
! Saving tree-level parameters for output
mu12  = mu12Tree 
mu22  = mu22Tree 
mu32  = mu32Tree 
End if 


Iname = Iname -1 
End Subroutine OneLoopMasses 
 
Subroutine OneLoopTadpoleshh(Vn,v1,v2,MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,               & 
& MFe2,MFu,MFu2,Mhh,Mhh2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,           & 
& cplAhAhUhh,cplDpmUhhcDpm,cplcFdFdUhhL,cplcFdFdUhhR,cplcFeFeUhhL,cplcFeFeUhhR,          & 
& cplcFuFuUhhL,cplcFuFuUhhR,cplcgWpgWpUhh,cplcgWCgWCUhh,cplcgXp1gXp1Uhh,cplcgXp2gXp2Uhh, & 
& cplcgZgZUhh,cplcgZpgZpUhh,cplUhhhhhh,cplUhhHpmcHpm,cplUhhcVWpVWp,cplUhhcVXpVXp,        & 
& cplUhhVZVZ,cplUhhVZpVZp,tadpoles)

Implicit None 
Real(dp), Intent(in) :: MAh(3),MAh2(3),MDpm(2),MDpm2(2),MFd(5),MFd2(5),MFe(3),MFe2(3),MFu(4),MFu2(4),         & 
& Mhh(3),Mhh2(3),MHpm(4),MHpm2(4),MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2

Complex(dp), Intent(in) :: cplAhAhUhh(3,3,3),cplDpmUhhcDpm(2,3,2),cplcFdFdUhhL(5,5,3),cplcFdFdUhhR(5,5,3),       & 
& cplcFeFeUhhL(3,3,3),cplcFeFeUhhR(3,3,3),cplcFuFuUhhL(4,4,3),cplcFuFuUhhR(4,4,3),       & 
& cplcgWpgWpUhh(3),cplcgWCgWCUhh(3),cplcgXp1gXp1Uhh(3),cplcgXp2gXp2Uhh(3),               & 
& cplcgZgZUhh(3),cplcgZpgZpUhh(3),cplUhhhhhh(3,3,3),cplUhhHpmcHpm(3,4,4),cplUhhcVWpVWp(3),& 
& cplUhhcVXpVXp(3),cplUhhVZVZ(3),cplUhhVZpVZp(3)

Real(dp), Intent(in) :: Vn,v1,v2

Integer :: i1,i2, gO1, gO2 
Complex(dp) :: coupL, coupR, coup, temp, res, A0m, sumI(3)  
Real(dp) :: m1 
Complex(dp), Intent(out) :: tadpoles(3) 
Iname = Iname + 1 
NameOfUnit(Iname) = 'OneLoopTadpoleshh'
 
tadpoles = 0._dp 
 
!------------------------ 
! Ah 
!------------------------ 
Do i1 = 1, 3
 A0m = SA_A0(MAh2(i1)) 
  Do gO1 = 1, 3
   coup = cplAhAhUhh(i1,i1,gO1)
   sumI(gO1) = -coup*A0m 
  End Do 
 
tadpoles =  tadpoles + 1._dp/2._dp*sumI 
End Do 
 !------------------------ 
! conj[Dpm] 
!------------------------ 
Do i1 = 1, 2
 A0m = SA_A0(MDpm2(i1)) 
  Do gO1 = 1, 3
   coup = cplDpmUhhcDpm(i1,gO1,i1)
   sumI(gO1) = -coup*A0m 
  End Do 
 
tadpoles =  tadpoles + 1._dp*sumI 
End Do 
 !------------------------ 
! bar[Fd] 
!------------------------ 
Do i1 = 1, 5
 A0m = 2._dp*MFd(i1)*SA_A0(MFd2(i1)) 
  Do gO1 = 1, 3
   coupL = cplcFdFdUhhL(i1,i1,gO1)
   coupR = cplcFdFdUhhR(i1,i1,gO1)
   sumI(gO1) = (coupL+coupR)*A0m 
  End Do 
 
tadpoles =  tadpoles + 3._dp*sumI 
End Do 
 !------------------------ 
! bar[Fe] 
!------------------------ 
Do i1 = 1, 3
 A0m = 2._dp*MFe(i1)*SA_A0(MFe2(i1)) 
  Do gO1 = 1, 3
   coupL = cplcFeFeUhhL(i1,i1,gO1)
   coupR = cplcFeFeUhhR(i1,i1,gO1)
   sumI(gO1) = (coupL+coupR)*A0m 
  End Do 
 
tadpoles =  tadpoles + 1._dp*sumI 
End Do 
 !------------------------ 
! bar[Fu] 
!------------------------ 
Do i1 = 1, 4
 A0m = 2._dp*MFu(i1)*SA_A0(MFu2(i1)) 
  Do gO1 = 1, 3
   coupL = cplcFuFuUhhL(i1,i1,gO1)
   coupR = cplcFuFuUhhR(i1,i1,gO1)
   sumI(gO1) = (coupL+coupR)*A0m 
  End Do 
 
tadpoles =  tadpoles + 3._dp*sumI 
End Do 
 !------------------------ 
! bar[gWp] 
!------------------------ 
A0m = 1._dp*SA_A0(MVWp2*RXi) 
  Do gO1 = 1, 3
    coup = cplcgWpgWpUhh(gO1)
    sumI(gO1) = coup*A0m 
  End Do 
 
tadpoles =  tadpoles + 1._dp*sumI 
!------------------------ 
! bar[gWpC] 
!------------------------ 
A0m = 1._dp*SA_A0(MVWp2*RXi) 
  Do gO1 = 1, 3
    coup = cplcgWCgWCUhh(gO1)
    sumI(gO1) = coup*A0m 
  End Do 
 
tadpoles =  tadpoles + 1._dp*sumI 
!------------------------ 
! bar[gXp] 
!------------------------ 
A0m = 1._dp*SA_A0(MVXp2*RXi) 
  Do gO1 = 1, 3
    coup = cplcgXp1gXp1Uhh(gO1)
    sumI(gO1) = coup*A0m 
  End Do 
 
tadpoles =  tadpoles + 1._dp*sumI 
!------------------------ 
! bar[gXpC] 
!------------------------ 
A0m = 1._dp*SA_A0(MVXp2*RXi) 
  Do gO1 = 1, 3
    coup = cplcgXp2gXp2Uhh(gO1)
    sumI(gO1) = coup*A0m 
  End Do 
 
tadpoles =  tadpoles + 1._dp*sumI 
!------------------------ 
! bar[gZ] 
!------------------------ 
A0m = 1._dp*SA_A0(MVZ2*RXi) 
  Do gO1 = 1, 3
    coup = cplcgZgZUhh(gO1)
    sumI(gO1) = coup*A0m 
  End Do 
 
tadpoles =  tadpoles + 1._dp*sumI 
!------------------------ 
! bar[gZp] 
!------------------------ 
A0m = 1._dp*SA_A0(MVZp2*RXi) 
  Do gO1 = 1, 3
    coup = cplcgZpgZpUhh(gO1)
    sumI(gO1) = coup*A0m 
  End Do 
 
tadpoles =  tadpoles + 1._dp*sumI 
!------------------------ 
! hh 
!------------------------ 
Do i1 = 1, 3
 A0m = SA_A0(Mhh2(i1)) 
  Do gO1 = 1, 3
   coup = cplUhhhhhh(gO1,i1,i1)
   sumI(gO1) = -coup*A0m 
  End Do 
 
tadpoles =  tadpoles + 1._dp/2._dp*sumI 
End Do 
 !------------------------ 
! conj[Hpm] 
!------------------------ 
Do i1 = 1, 4
 A0m = SA_A0(MHpm2(i1)) 
  Do gO1 = 1, 3
   coup = cplUhhHpmcHpm(gO1,i1,i1)
   sumI(gO1) = -coup*A0m 
  End Do 
 
tadpoles =  tadpoles + 1._dp*sumI 
End Do 
 !------------------------ 
! conj[VWp] 
!------------------------ 
A0m = 3._dp*SA_A0(MVWp2)+RXi*SA_A0(MVWp2*RXi) - 2._dp*MVWp2*rMS 
  Do gO1 = 1, 3
    coup = cplUhhcVWpVWp(gO1)
    sumI(gO1) = coup*A0m 
  End Do 
 
tadpoles =  tadpoles + 1._dp*sumI 
!------------------------ 
! conj[VXp] 
!------------------------ 
A0m = 3._dp*SA_A0(MVXp2)+RXi*SA_A0(MVXp2*RXi) - 2._dp*MVXp2*rMS 
  Do gO1 = 1, 3
    coup = cplUhhcVXpVXp(gO1)
    sumI(gO1) = coup*A0m 
  End Do 
 
tadpoles =  tadpoles + 1._dp*sumI 
!------------------------ 
! VZ 
!------------------------ 
A0m = 3._dp*SA_A0(MVZ2)+RXi*SA_A0(MVZ2*RXi) - 2._dp*MVZ2*rMS 
  Do gO1 = 1, 3
    coup = cplUhhVZVZ(gO1)
    sumI(gO1) = coup*A0m 
  End Do 
 
tadpoles =  tadpoles + 1._dp/2._dp*sumI 
!------------------------ 
! VZp 
!------------------------ 
A0m = 3._dp*SA_A0(MVZp2)+RXi*SA_A0(MVZp2*RXi) - 2._dp*MVZp2*rMS 
  Do gO1 = 1, 3
    coup = cplUhhVZpVZp(gO1)
    sumI(gO1) = coup*A0m 
  End Do 
 
tadpoles =  tadpoles + 1._dp/2._dp*sumI 



tadpoles = oo16pi2*tadpoles 
Iname = Iname - 1 
End Subroutine OneLoopTadpoleshh 
 
Subroutine OneLoophh(mu12,mu22,mu32,ftri,l1,l12,l13,l2,l23,l3,Vn,v1,v2,               & 
& MAh,MAh2,Mhh,Mhh2,MVZ,MVZ2,MVZp,MVZp2,MDpm,MDpm2,MFd,MFd2,MFe,MFe2,MFu,MFu2,           & 
& MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,cplAhAhUhh,cplAhUhhhh,cplAhUhhVP,cplAhUhhVZ,          & 
& cplAhUhhVZp,cplDpmUhhcDpm,cplcFdFdUhhL,cplcFdFdUhhR,cplcFeFeUhhL,cplcFeFeUhhR,         & 
& cplcFuFuUhhL,cplcFuFuUhhR,cplcgWpgWpUhh,cplcgWCgWCUhh,cplcgXp1gXp1Uhh,cplcgXp2gXp2Uhh, & 
& cplcgZgZUhh,cplcgZpgZUhh,cplcgZgZpUhh,cplcgZpgZpUhh,cplUhhhhhh,cplUhhHpmcHpm,          & 
& cplUhhHpmVWp,cplUhhHpmVXp,cplUhhVPVZ,cplUhhVPVZp,cplUhhcVWpVWp,cplUhhcVXpVXp,          & 
& cplUhhVZVZ,cplUhhVZVZp,cplUhhVZpVZp,cplAhAhUhhUhh,cplDpmUhhUhhcDpm,cplUhhUhhhhhh,      & 
& cplUhhUhhHpmcHpm,cplUhhUhhVPVP,cplUhhUhhcVWpVWp,cplUhhUhhcVXpVXp,cplUhhUhhVZVZ,        & 
& cplUhhUhhVZpVZp,delta,mass,mass2,RS,kont)

Implicit None 
Real(dp), Intent(in) :: MAh(3),MAh2(3),Mhh(3),Mhh2(3),MVZ,MVZ2,MVZp,MVZp2,MDpm(2),MDpm2(2),MFd(5),            & 
& MFd2(5),MFe(3),MFe2(3),MFu(4),MFu2(4),MHpm(4),MHpm2(4),MVWp,MVWp2,MVXp,MVXp2

Real(dp), Intent(in) :: mu12,mu22,mu32,ftri,Vn,v1,v2

Complex(dp), Intent(in) :: l1,l12,l13,l2,l23,l3

Complex(dp), Intent(in) :: cplAhAhUhh(3,3,3),cplAhUhhhh(3,3,3),cplAhUhhVP(3,3),cplAhUhhVZ(3,3),cplAhUhhVZp(3,3), & 
& cplDpmUhhcDpm(2,3,2),cplcFdFdUhhL(5,5,3),cplcFdFdUhhR(5,5,3),cplcFeFeUhhL(3,3,3),      & 
& cplcFeFeUhhR(3,3,3),cplcFuFuUhhL(4,4,3),cplcFuFuUhhR(4,4,3),cplcgWpgWpUhh(3),          & 
& cplcgWCgWCUhh(3),cplcgXp1gXp1Uhh(3),cplcgXp2gXp2Uhh(3),cplcgZgZUhh(3),cplcgZpgZUhh(3), & 
& cplcgZgZpUhh(3),cplcgZpgZpUhh(3),cplUhhhhhh(3,3,3),cplUhhHpmcHpm(3,4,4),               & 
& cplUhhHpmVWp(3,4),cplUhhHpmVXp(3,4),cplUhhVPVZ(3),cplUhhVPVZp(3),cplUhhcVWpVWp(3),     & 
& cplUhhcVXpVXp(3),cplUhhVZVZ(3),cplUhhVZVZp(3),cplUhhVZpVZp(3),cplAhAhUhhUhh(3,3,3,3),  & 
& cplDpmUhhUhhcDpm(2,3,3,2),cplUhhUhhhhhh(3,3,3,3),cplUhhUhhHpmcHpm(3,3,4,4),            & 
& cplUhhUhhVPVP(3,3),cplUhhUhhcVWpVWp(3,3),cplUhhUhhcVXpVXp(3,3),cplUhhUhhVZVZ(3,3),     & 
& cplUhhUhhVZpVZp(3,3)

Complex(dp) :: mat2a(3,3), mat2(3,3),  PiSf(3,3,3)
Integer , Intent(inout):: kont 
Integer :: i1,i2,i3,i4,j1,j2,j3,j4,il,i_count, ierr 
Real(dp), Intent(in) :: delta 
Real(dp) :: mi2(3), test_m2(3),p2, test(3) 
Real(dp), Intent(out) :: mass(3), mass2(3) 
Complex(dp), Intent(out) ::  RS(3,3) 
Iname = Iname + 1 
NameOfUnit(Iname) = 'OneLoophh'
 
mat2a(1,1) = 0._dp 
mat2a(1,1) = mat2a(1,1)-1._dp*(mu12)
mat2a(1,1) = mat2a(1,1)+3*l1*Vn**2
mat2a(1,1) = mat2a(1,1)+l12*v1**2
mat2a(1,1) = mat2a(1,1)+l13*v2**2
mat2a(1,2) = 0._dp 
mat2a(1,2) = mat2a(1,2)+2*l12*Vn*v1
mat2a(1,2) = mat2a(1,2)-((ftri*v2)/sqrt(2._dp))
mat2a(1,3) = 0._dp 
mat2a(1,3) = mat2a(1,3)-((ftri*v1)/sqrt(2._dp))
mat2a(1,3) = mat2a(1,3)+2*l13*Vn*v2
mat2a(2,2) = 0._dp 
mat2a(2,2) = mat2a(2,2)+mu22
mat2a(2,2) = mat2a(2,2)+l12*Vn**2
mat2a(2,2) = mat2a(2,2)+3*l2*v1**2
mat2a(2,2) = mat2a(2,2)+l23*v2**2
mat2a(2,3) = 0._dp 
mat2a(2,3) = mat2a(2,3)-((ftri*Vn)/sqrt(2._dp))
mat2a(2,3) = mat2a(2,3)+2*l23*v1*v2
mat2a(3,3) = 0._dp 
mat2a(3,3) = mat2a(3,3)+mu32
mat2a(3,3) = mat2a(3,3)+l13*Vn**2
mat2a(3,3) = mat2a(3,3)+l23*v1**2
mat2a(3,3) = mat2a(3,3)+2*l3*v2**2

 
 Do i1=2,3
  Do i2 = 1, i1-1 
  mat2a(i1,i2) = (mat2a(i2,i1)) 
  End do 
End do 

 
! Rotation matrix for p2=0 
PiSf(1,:,:) = ZeroC 
p2 = 0._dp 
Call Pi1Loophh(p2,MAh,MAh2,Mhh,Mhh2,MVZ,MVZ2,MVZp,MVZp2,MDpm,MDpm2,MFd,               & 
& MFd2,MFe,MFe2,MFu,MFu2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,cplAhAhUhh,cplAhUhhhh,         & 
& cplAhUhhVP,cplAhUhhVZ,cplAhUhhVZp,cplDpmUhhcDpm,cplcFdFdUhhL,cplcFdFdUhhR,             & 
& cplcFeFeUhhL,cplcFeFeUhhR,cplcFuFuUhhL,cplcFuFuUhhR,cplcgWpgWpUhh,cplcgWCgWCUhh,       & 
& cplcgXp1gXp1Uhh,cplcgXp2gXp2Uhh,cplcgZgZUhh,cplcgZpgZUhh,cplcgZgZpUhh,cplcgZpgZpUhh,   & 
& cplUhhhhhh,cplUhhHpmcHpm,cplUhhHpmVWp,cplUhhHpmVXp,cplUhhVPVZ,cplUhhVPVZp,             & 
& cplUhhcVWpVWp,cplUhhcVXpVXp,cplUhhVZVZ,cplUhhVZVZp,cplUhhVZpVZp,cplAhAhUhhUhh,         & 
& cplDpmUhhUhhcDpm,cplUhhUhhhhhh,cplUhhUhhHpmcHpm,cplUhhUhhVPVP,cplUhhUhhcVWpVWp,        & 
& cplUhhUhhcVXpVXp,cplUhhUhhVZVZ,cplUhhUhhVZpVZp,kont,PiSf(1,:,:))

PiSf(1,:,:) = PiSf(1,:,:) - Pi2S_EffPot 
mat2 = mat2a - Real(PiSf(1,:,:),dp) 
Call Chop(mat2) 
Call Eigensystem(mat2,mi2,RS,kont,test) 
ZHOS_0 = RS 
 
 
! Now with momenta 
Do i1=1,3
PiSf(i1,:,:) = ZeroC 
p2 = Mhh2(i1)
Call Pi1Loophh(p2,MAh,MAh2,Mhh,Mhh2,MVZ,MVZ2,MVZp,MVZp2,MDpm,MDpm2,MFd,               & 
& MFd2,MFe,MFe2,MFu,MFu2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,cplAhAhUhh,cplAhUhhhh,         & 
& cplAhUhhVP,cplAhUhhVZ,cplAhUhhVZp,cplDpmUhhcDpm,cplcFdFdUhhL,cplcFdFdUhhR,             & 
& cplcFeFeUhhL,cplcFeFeUhhR,cplcFuFuUhhL,cplcFuFuUhhR,cplcgWpgWpUhh,cplcgWCgWCUhh,       & 
& cplcgXp1gXp1Uhh,cplcgXp2gXp2Uhh,cplcgZgZUhh,cplcgZpgZUhh,cplcgZgZpUhh,cplcgZpgZpUhh,   & 
& cplUhhhhhh,cplUhhHpmcHpm,cplUhhHpmVWp,cplUhhHpmVXp,cplUhhVPVZ,cplUhhVPVZp,             & 
& cplUhhcVWpVWp,cplUhhcVXpVXp,cplUhhVZVZ,cplUhhVZVZp,cplUhhVZpVZp,cplAhAhUhhUhh,         & 
& cplDpmUhhUhhcDpm,cplUhhUhhhhhh,cplUhhUhhHpmcHpm,cplUhhUhhVPVP,cplUhhUhhcVWpVWp,        & 
& cplUhhUhhcVXpVXp,cplUhhUhhVZVZ,cplUhhUhhVZpVZp,kont,PiSf(i1,:,:))

End Do 
Do i1=3,1,-1 
PiSf(i1,:,:) = PiSf(i1,:,:) - Pi2S_EffPot 
mat2 = mat2a - Real(PiSf(i1,:,:),dp) 
Call Chop(mat2) 
Call Eigensystem(mat2,mi2,RS,kont,test) 
If ((kont.Eq.-8).Or.(kont.Eq.-9)) Then 
  Write(ErrCan,*) "Possible numerical problem in "//NameOfUnit(Iname) 
  Write(*,*) "Possible numerical problem in "//NameOfUnit(Iname) 
  If (ErrorLevel.Eq.2) Call TerminateProgram 
  kont = 0 
End If 
If ((kont.Ne.0).And.(ErrorLevel.Ge.0)) Then 
  Write(ErrCan,*) "Diagonalization did not work in routine "//NameOfUnit(Iname) 
  Write(*,*) "Diagonalization did not work in routine "//NameOfUnit(Iname) 
  If (ErrorLevel.Eq.2) Call TerminateProgram 
End If 
mass2(i1) = mi2(i1) 
End do 
 
Do i1=1,3
  If (Abs(mass2(i1)).Le.MaxMassNumericalZero**2) mass2(i1) = 0._dp 
  If (mass2(i1).Ge.0._dp) Then 
    mass(i1) = Sqrt(mass2(i1)) 
  Else 
   If (ErrorLevel.Ge.0) Then 
     Write(*,*) 'Warning from routine '//NameOfUnit(Iname) 
     Write(*,*) 'in the calculation of the masses' 
     Write(*,*) 'occurred a negative mass squared!' 
   Call TerminateProgram 
   End If 
   kont = -301 
   mass(i1) = 0._dp 
  End If 
End Do 
 
i_count = 0 
Do  
i_count = i_count + 1 
test_m2 = mass2 
Do i1=1,3
PiSf(i1,:,:) = ZeroC 
p2 =  mass2(i1) 
Call Pi1Loophh(p2,MAh,MAh2,Mhh,Mhh2,MVZ,MVZ2,MVZp,MVZp2,MDpm,MDpm2,MFd,               & 
& MFd2,MFe,MFe2,MFu,MFu2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,cplAhAhUhh,cplAhUhhhh,         & 
& cplAhUhhVP,cplAhUhhVZ,cplAhUhhVZp,cplDpmUhhcDpm,cplcFdFdUhhL,cplcFdFdUhhR,             & 
& cplcFeFeUhhL,cplcFeFeUhhR,cplcFuFuUhhL,cplcFuFuUhhR,cplcgWpgWpUhh,cplcgWCgWCUhh,       & 
& cplcgXp1gXp1Uhh,cplcgXp2gXp2Uhh,cplcgZgZUhh,cplcgZpgZUhh,cplcgZgZpUhh,cplcgZpgZpUhh,   & 
& cplUhhhhhh,cplUhhHpmcHpm,cplUhhHpmVWp,cplUhhHpmVXp,cplUhhVPVZ,cplUhhVPVZp,             & 
& cplUhhcVWpVWp,cplUhhcVXpVXp,cplUhhVZVZ,cplUhhVZVZp,cplUhhVZpVZp,cplAhAhUhhUhh,         & 
& cplDpmUhhUhhcDpm,cplUhhUhhhhhh,cplUhhUhhHpmcHpm,cplUhhUhhVPVP,cplUhhUhhcVWpVWp,        & 
& cplUhhUhhcVXpVXp,cplUhhUhhVZVZ,cplUhhUhhVZpVZp,kont,PiSf(i1,:,:))

End Do 
Do i1=3,1,-1 
PiSf(i1,:,:) = PiSf(i1,:,:) - Pi2S_EffPot 
mat2 = mat2a - Real(PiSf(i1,:,:),dp) 
Call Chop(mat2) 
Call Eigensystem(mat2,mi2,RS,kont,test) 
ZHOS_p2(i1,:) = RS(i1,:) 
 If ((kont.Eq.-8).Or.(kont.Eq.-9)) Then 
  Write(ErrCan,*) "Possible numerical problem in "//NameOfUnit(Iname) 
  Write(*,*) "Possible numerical problem in "//NameOfUnit(Iname) 
  If (ErrorLevel.Eq.2) Call TerminateProgram 
  kont = 0 
End If 
If ((kont.Ne.0).And.(ErrorLevel.Ge.0)) Then 
  Write(ErrCan,*) "Diagonalization did not work in routine "//NameOfUnit(Iname) 
  Write(*,*) "Diagonalization did not work in routine "//NameOfUnit(Iname) 
  If (ErrorLevel.Eq.2) Call TerminateProgram 
End If 
mass2(i1) = mi2(i1) 
End do 
Do i1=1,3
 If (Abs(mass2(i1)).Le.MaxMassNumericalZero**2) mass2(i1) = 0._dp 
 If (test_m2(i1).Ne.0._dp) Then 
    test_m2(i1) = Abs(test_m2(i1) - mass2(i1)) / test_m2(i1) 
 Else 
    test_m2(i1) = Abs(mass2(i1)) 
 End If 
 If (Abs(mass2(i1)).lt.1.0E-30_dp) test_m2(i1) = 0._dp 
 If (mass2(i1).Ge.0._dp) Then 
    mass(i1) = sqrt(mass2(i1)) 
  Else 
     Write(*,*) 'Warning from routine '//NameOfUnit(Iname) 
     Write(*,*) 'in the calculation of the masses occurred a negative mass squared!' 
     Write(*,*) 'generation: ',i1 
     Write(*,*) 'mass: ',mass2(i1) 
   SignOfMassChanged = .True. 
   mass(i1) = 0._dp 
  End If 
End Do 
 
If (Maxval(test_m2).LT.0.1_dp*delta) Exit 
If (i_count.Gt.30) Then 
  Write(*,*) "Problem in "//NameOfUnit(Iname), test_m2, mass2 
  kont = -510 
  Call AddError(510) 
 Exit 
End If 
End Do 
 
 
Iname = Iname -1 
End Subroutine OneLoophh
 
 
Subroutine Pi1Loophh(p2,MAh,MAh2,Mhh,Mhh2,MVZ,MVZ2,MVZp,MVZp2,MDpm,MDpm2,             & 
& MFd,MFd2,MFe,MFe2,MFu,MFu2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,cplAhAhUhh,cplAhUhhhh,     & 
& cplAhUhhVP,cplAhUhhVZ,cplAhUhhVZp,cplDpmUhhcDpm,cplcFdFdUhhL,cplcFdFdUhhR,             & 
& cplcFeFeUhhL,cplcFeFeUhhR,cplcFuFuUhhL,cplcFuFuUhhR,cplcgWpgWpUhh,cplcgWCgWCUhh,       & 
& cplcgXp1gXp1Uhh,cplcgXp2gXp2Uhh,cplcgZgZUhh,cplcgZpgZUhh,cplcgZgZpUhh,cplcgZpgZpUhh,   & 
& cplUhhhhhh,cplUhhHpmcHpm,cplUhhHpmVWp,cplUhhHpmVXp,cplUhhVPVZ,cplUhhVPVZp,             & 
& cplUhhcVWpVWp,cplUhhcVXpVXp,cplUhhVZVZ,cplUhhVZVZp,cplUhhVZpVZp,cplAhAhUhhUhh,         & 
& cplDpmUhhUhhcDpm,cplUhhUhhhhhh,cplUhhUhhHpmcHpm,cplUhhUhhVPVP,cplUhhUhhcVWpVWp,        & 
& cplUhhUhhcVXpVXp,cplUhhUhhVZVZ,cplUhhUhhVZpVZp,kont,res)

Implicit None 
Real(dp), Intent(in) :: MAh(3),MAh2(3),Mhh(3),Mhh2(3),MVZ,MVZ2,MVZp,MVZp2,MDpm(2),MDpm2(2),MFd(5),            & 
& MFd2(5),MFe(3),MFe2(3),MFu(4),MFu2(4),MHpm(4),MHpm2(4),MVWp,MVWp2,MVXp,MVXp2

Complex(dp), Intent(in) :: cplAhAhUhh(3,3,3),cplAhUhhhh(3,3,3),cplAhUhhVP(3,3),cplAhUhhVZ(3,3),cplAhUhhVZp(3,3), & 
& cplDpmUhhcDpm(2,3,2),cplcFdFdUhhL(5,5,3),cplcFdFdUhhR(5,5,3),cplcFeFeUhhL(3,3,3),      & 
& cplcFeFeUhhR(3,3,3),cplcFuFuUhhL(4,4,3),cplcFuFuUhhR(4,4,3),cplcgWpgWpUhh(3),          & 
& cplcgWCgWCUhh(3),cplcgXp1gXp1Uhh(3),cplcgXp2gXp2Uhh(3),cplcgZgZUhh(3),cplcgZpgZUhh(3), & 
& cplcgZgZpUhh(3),cplcgZpgZpUhh(3),cplUhhhhhh(3,3,3),cplUhhHpmcHpm(3,4,4),               & 
& cplUhhHpmVWp(3,4),cplUhhHpmVXp(3,4),cplUhhVPVZ(3),cplUhhVPVZp(3),cplUhhcVWpVWp(3),     & 
& cplUhhcVXpVXp(3),cplUhhVZVZ(3),cplUhhVZVZp(3),cplUhhVZpVZp(3),cplAhAhUhhUhh(3,3,3,3),  & 
& cplDpmUhhUhhcDpm(2,3,3,2),cplUhhUhhhhhh(3,3,3,3),cplUhhUhhHpmcHpm(3,3,4,4),            & 
& cplUhhUhhVPVP(3,3),cplUhhUhhcVWpVWp(3,3),cplUhhUhhcVXpVXp(3,3),cplUhhUhhVZVZ(3,3),     & 
& cplUhhUhhVZpVZp(3,3)

Integer, Intent(inout) :: kont 
Real(dp) :: B0m2, F0m2, G0m2,B1m2, m1, m2 
Real(dp), Intent(in) :: p2 
Complex(dp) :: A0m2 
Complex(dp), Intent(inout) :: res(3,3) 
Complex(dp) :: coupL1, coupR1, coupL2,coupR2, coup1,coup2,temp, sumI(3,3) 
Integer :: i1,i2,i3,i4,j1,j2,j3,j4, gO1, gO2, ierr 
 
 
res = 0._dp 
 
!------------------------ 
! Ah, Ah 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 3
       Do i2 = 1, 3
 B0m2 = Real(SA_B0(p2,MAh2(i1),MAh2(i2)),dp) 
Do gO1 = 1, 3
  Do gO2 = gO1, 3
coup1 = cplAhAhUhh(i1,i2,gO1)
coup2 = Conjg(cplAhAhUhh(i1,i2,gO2))
    SumI(gO1,gO2) = coup1*coup2*B0m2 
   End Do 
End Do 
res = res +1._dp/2._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! hh, Ah 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 3
       Do i2 = 1, 3
 B0m2 = Real(SA_B0(p2,Mhh2(i1),MAh2(i2)),dp) 
Do gO1 = 1, 3
  Do gO2 = gO1, 3
coup1 = cplAhUhhhh(i2,gO1,i1)
coup2 = Conjg(cplAhUhhhh(i2,gO2,i1))
    SumI(gO1,gO2) = coup1*coup2*B0m2 
   End Do 
End Do 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! VP, Ah 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 3
 F0m2 = FloopRXi(p2,MAh2(i2),0._dp) 
Do gO1 = 1, 3
  Do gO2 = gO1, 3
coup1 = cplAhUhhVP(i2,gO1)
coup2 =  Conjg(cplAhUhhVP(i2,gO2))
    SumI(gO1,gO2) = coup1*coup2*F0m2 
   End Do 
End Do 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! VZ, Ah 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 3
 F0m2 = FloopRXi(p2,MAh2(i2),MVZ2) 
Do gO1 = 1, 3
  Do gO2 = gO1, 3
coup1 = cplAhUhhVZ(i2,gO1)
coup2 =  Conjg(cplAhUhhVZ(i2,gO2))
    SumI(gO1,gO2) = coup1*coup2*F0m2 
   End Do 
End Do 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! VZp, Ah 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 3
 F0m2 = FloopRXi(p2,MAh2(i2),MVZp2) 
Do gO1 = 1, 3
  Do gO2 = gO1, 3
coup1 = cplAhUhhVZp(i2,gO1)
coup2 =  Conjg(cplAhUhhVZp(i2,gO2))
    SumI(gO1,gO2) = coup1*coup2*F0m2 
   End Do 
End Do 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! conj[Dpm], Dpm 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 2
       Do i2 = 1, 2
 B0m2 = Real(SA_B0(p2,MDpm2(i1),MDpm2(i2)),dp) 
Do gO1 = 1, 3
  Do gO2 = gO1, 3
coup1 = cplDpmUhhcDpm(i2,gO1,i1)
coup2 = Conjg(cplDpmUhhcDpm(i2,gO2,i1))
    SumI(gO1,gO2) = coup1*coup2*B0m2 
   End Do 
End Do 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[Fd], Fd 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 5
       Do i2 = 1, 5
 G0m2 = Real(SA_Gloop(p2,MFd2(i1),MFd2(i2)),dp) 
B0m2 = -2._dp*MFd(i1)*MFd(i2)*Real(SA_B0(p2,MFd2(i1),MFd2(i2)),dp) 
Do gO1 = 1, 3
  Do gO2 = gO1, 3
coupL1 = cplcFdFdUhhL(i1,i2,gO1)
coupR1 = cplcFdFdUhhR(i1,i2,gO1)
coupL2 =  Conjg(cplcFdFdUhhL(i1,i2,gO2))
coupR2 =  Conjg(cplcFdFdUhhR(i1,i2,gO2))
    SumI(gO1,gO2) = (coupL1*coupL2+coupR1*coupR2)*G0m2 & 
                & + (coupL1*coupR2+coupR1*coupL2)*B0m2 
   End Do 
End Do 
res = res +3._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[Fe], Fe 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 3
       Do i2 = 1, 3
 G0m2 = Real(SA_Gloop(p2,MFe2(i1),MFe2(i2)),dp) 
B0m2 = -2._dp*MFe(i1)*MFe(i2)*Real(SA_B0(p2,MFe2(i1),MFe2(i2)),dp) 
Do gO1 = 1, 3
  Do gO2 = gO1, 3
coupL1 = cplcFeFeUhhL(i1,i2,gO1)
coupR1 = cplcFeFeUhhR(i1,i2,gO1)
coupL2 =  Conjg(cplcFeFeUhhL(i1,i2,gO2))
coupR2 =  Conjg(cplcFeFeUhhR(i1,i2,gO2))
    SumI(gO1,gO2) = (coupL1*coupL2+coupR1*coupR2)*G0m2 & 
                & + (coupL1*coupR2+coupR1*coupL2)*B0m2 
   End Do 
End Do 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[Fu], Fu 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
       Do i2 = 1, 4
 G0m2 = Real(SA_Gloop(p2,MFu2(i1),MFu2(i2)),dp) 
B0m2 = -2._dp*MFu(i1)*MFu(i2)*Real(SA_B0(p2,MFu2(i1),MFu2(i2)),dp) 
Do gO1 = 1, 3
  Do gO2 = gO1, 3
coupL1 = cplcFuFuUhhL(i1,i2,gO1)
coupR1 = cplcFuFuUhhR(i1,i2,gO1)
coupL2 =  Conjg(cplcFuFuUhhL(i1,i2,gO2))
coupR2 =  Conjg(cplcFuFuUhhR(i1,i2,gO2))
    SumI(gO1,gO2) = (coupL1*coupL2+coupR1*coupR2)*G0m2 & 
                & + (coupL1*coupR2+coupR1*coupL2)*B0m2 
   End Do 
End Do 
res = res +3._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[gWp], gWp 
!------------------------ 
sumI = 0._dp 
 
F0m2 = -Real(SA_B0(p2,MVWp2*RXi,MVWp2*RXi),dp) 
 Do gO1 = 1, 3
  Do gO2 = gO1, 3
coup1 = cplcgWpgWpUhh(gO1)
coup2 =  cplcgWpgWpUhh(gO2) 
    SumI(gO1,gO2) = coup1*coup2*F0m2 
   End Do 
End Do 
res = res +1._dp* SumI  
!------------------------ 
! bar[gWpC], gWpC 
!------------------------ 
sumI = 0._dp 
 
F0m2 = -Real(SA_B0(p2,MVWp2*RXi,MVWp2*RXi),dp) 
 Do gO1 = 1, 3
  Do gO2 = gO1, 3
coup1 = cplcgWCgWCUhh(gO1)
coup2 =  cplcgWCgWCUhh(gO2) 
    SumI(gO1,gO2) = coup1*coup2*F0m2 
   End Do 
End Do 
res = res +1._dp* SumI  
!------------------------ 
! bar[gXp], gXp 
!------------------------ 
sumI = 0._dp 
 
F0m2 = -Real(SA_B0(p2,MVXp2*RXi,MVXp2*RXi),dp) 
 Do gO1 = 1, 3
  Do gO2 = gO1, 3
coup1 = cplcgXp1gXp1Uhh(gO1)
coup2 =  cplcgXp1gXp1Uhh(gO2) 
    SumI(gO1,gO2) = coup1*coup2*F0m2 
   End Do 
End Do 
res = res +1._dp* SumI  
!------------------------ 
! bar[gXpC], gXpC 
!------------------------ 
sumI = 0._dp 
 
F0m2 = -Real(SA_B0(p2,MVXp2*RXi,MVXp2*RXi),dp) 
 Do gO1 = 1, 3
  Do gO2 = gO1, 3
coup1 = cplcgXp2gXp2Uhh(gO1)
coup2 =  cplcgXp2gXp2Uhh(gO2) 
    SumI(gO1,gO2) = coup1*coup2*F0m2 
   End Do 
End Do 
res = res +1._dp* SumI  
!------------------------ 
! bar[gZ], gZ 
!------------------------ 
sumI = 0._dp 
 
F0m2 = -Real(SA_B0(p2,MVZ2*RXi,MVZ2*RXi),dp) 
 Do gO1 = 1, 3
  Do gO2 = gO1, 3
coup1 = cplcgZgZUhh(gO1)
coup2 =  cplcgZgZUhh(gO2) 
    SumI(gO1,gO2) = coup1*coup2*F0m2 
   End Do 
End Do 
res = res +1._dp* SumI  
!------------------------ 
! bar[gZp], gZ 
!------------------------ 
sumI = 0._dp 
 
F0m2 = -Real(SA_B0(p2,MVZ2*RXi,MVZp2*RXi),dp) 
 Do gO1 = 1, 3
  Do gO2 = gO1, 3
coup1 = cplcgZpgZUhh(gO1)
coup2 =  cplcgZgZpUhh(gO2) 
    SumI(gO1,gO2) = coup1*coup2*F0m2 
   End Do 
End Do 
res = res +2._dp* SumI  
!------------------------ 
! bar[gZp], gZp 
!------------------------ 
sumI = 0._dp 
 
F0m2 = -Real(SA_B0(p2,MVZp2*RXi,MVZp2*RXi),dp) 
 Do gO1 = 1, 3
  Do gO2 = gO1, 3
coup1 = cplcgZpgZpUhh(gO1)
coup2 =  cplcgZpgZpUhh(gO2) 
    SumI(gO1,gO2) = coup1*coup2*F0m2 
   End Do 
End Do 
res = res +1._dp* SumI  
!------------------------ 
! hh, hh 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 3
       Do i2 = 1, 3
 B0m2 = Real(SA_B0(p2,Mhh2(i1),Mhh2(i2)),dp) 
Do gO1 = 1, 3
  Do gO2 = gO1, 3
coup1 = cplUhhhhhh(gO1,i1,i2)
coup2 = Conjg(cplUhhhhhh(gO2,i1,i2))
    SumI(gO1,gO2) = coup1*coup2*B0m2 
   End Do 
End Do 
res = res +1._dp/2._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! conj[Hpm], Hpm 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
       Do i2 = 1, 4
 B0m2 = Real(SA_B0(p2,MHpm2(i1),MHpm2(i2)),dp) 
Do gO1 = 1, 3
  Do gO2 = gO1, 3
coup1 = cplUhhHpmcHpm(gO1,i2,i1)
coup2 = Conjg(cplUhhHpmcHpm(gO2,i2,i1))
    SumI(gO1,gO2) = coup1*coup2*B0m2 
   End Do 
End Do 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! VWp, Hpm 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 F0m2 = FloopRXi(p2,MHpm2(i2),MVWp2) 
Do gO1 = 1, 3
  Do gO2 = gO1, 3
coup1 = cplUhhHpmVWp(gO1,i2)
coup2 =  Conjg(cplUhhHpmVWp(gO2,i2))
    SumI(gO1,gO2) = coup1*coup2*F0m2 
   End Do 
End Do 
res = res +2._dp* SumI  
    End Do 
 !------------------------ 
! VXp, Hpm 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 F0m2 = FloopRXi(p2,MHpm2(i2),MVXp2) 
Do gO1 = 1, 3
  Do gO2 = gO1, 3
coup1 = cplUhhHpmVXp(gO1,i2)
coup2 =  Conjg(cplUhhHpmVXp(gO2,i2))
    SumI(gO1,gO2) = coup1*coup2*F0m2 
   End Do 
End Do 
res = res +2._dp* SumI  
    End Do 
 !------------------------ 
! VZ, VP 
!------------------------ 
sumI = 0._dp 
 
F0m2 = Real(SVVloop(p2,0._dp,MVZ2),dp)   
 Do gO1 = 1, 3
  Do gO2 = gO1, 3
coup1 = cplUhhVPVZ(gO1)
coup2 =  Conjg(cplUhhVPVZ(gO2)) 
    SumI(gO1,gO2) = coup1*coup2*F0m2 
   End Do 
End Do 
res = res +1._dp* SumI  
!------------------------ 
! VZp, VP 
!------------------------ 
sumI = 0._dp 
 
F0m2 = Real(SVVloop(p2,0._dp,MVZp2),dp)   
 Do gO1 = 1, 3
  Do gO2 = gO1, 3
coup1 = cplUhhVPVZp(gO1)
coup2 =  Conjg(cplUhhVPVZp(gO2)) 
    SumI(gO1,gO2) = coup1*coup2*F0m2 
   End Do 
End Do 
res = res +1._dp* SumI  
!------------------------ 
! conj[VWp], VWp 
!------------------------ 
sumI = 0._dp 
 
F0m2 = Real(SVVloop(p2,MVWp2,MVWp2),dp)   
 Do gO1 = 1, 3
  Do gO2 = gO1, 3
coup1 = cplUhhcVWpVWp(gO1)
coup2 =  Conjg(cplUhhcVWpVWp(gO2)) 
    SumI(gO1,gO2) = coup1*coup2*F0m2 
   End Do 
End Do 
res = res +1._dp* SumI  
!------------------------ 
! conj[VXp], VXp 
!------------------------ 
sumI = 0._dp 
 
F0m2 = Real(SVVloop(p2,MVXp2,MVXp2),dp)   
 Do gO1 = 1, 3
  Do gO2 = gO1, 3
coup1 = cplUhhcVXpVXp(gO1)
coup2 =  Conjg(cplUhhcVXpVXp(gO2)) 
    SumI(gO1,gO2) = coup1*coup2*F0m2 
   End Do 
End Do 
res = res +1._dp* SumI  
!------------------------ 
! VZ, VZ 
!------------------------ 
sumI = 0._dp 
 
F0m2 = Real(SVVloop(p2,MVZ2,MVZ2),dp)   
 Do gO1 = 1, 3
  Do gO2 = gO1, 3
coup1 = cplUhhVZVZ(gO1)
coup2 =  Conjg(cplUhhVZVZ(gO2)) 
    SumI(gO1,gO2) = coup1*coup2*F0m2 
   End Do 
End Do 
res = res +1._dp/2._dp* SumI  
!------------------------ 
! VZp, VZ 
!------------------------ 
sumI = 0._dp 
 
F0m2 = Real(SVVloop(p2,MVZ2,MVZp2),dp)   
 Do gO1 = 1, 3
  Do gO2 = gO1, 3
coup1 = cplUhhVZVZp(gO1)
coup2 =  Conjg(cplUhhVZVZp(gO2)) 
    SumI(gO1,gO2) = coup1*coup2*F0m2 
   End Do 
End Do 
res = res +1._dp* SumI  
!------------------------ 
! VZp, VZp 
!------------------------ 
sumI = 0._dp 
 
F0m2 = Real(SVVloop(p2,MVZp2,MVZp2),dp)   
 Do gO1 = 1, 3
  Do gO2 = gO1, 3
coup1 = cplUhhVZpVZp(gO1)
coup2 =  Conjg(cplUhhVZpVZp(gO2)) 
    SumI(gO1,gO2) = coup1*coup2*F0m2 
   End Do 
End Do 
res = res +1._dp/2._dp* SumI  
!------------------------ 
! Ah, Ah 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 3
 A0m2 = SA_A0(MAh2(i1)) 
Do gO1 = 1, 3
  Do gO2 = gO1, 3
coup1 = cplAhAhUhhUhh(i1,i1,gO1,gO2)
    SumI(gO1,gO2) = -coup1*A0m2 
   End Do 
End Do 
res = res +1._dp/2._dp* SumI  
      End Do 
 !------------------------ 
! conj[Dpm], Dpm 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 2
 A0m2 = SA_A0(MDpm2(i1)) 
Do gO1 = 1, 3
  Do gO2 = gO1, 3
coup1 = cplDpmUhhUhhcDpm(i1,gO1,gO2,i1)
    SumI(gO1,gO2) = -coup1*A0m2 
   End Do 
End Do 
res = res +1._dp* SumI  
      End Do 
 !------------------------ 
! hh, hh 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 3
 A0m2 = SA_A0(Mhh2(i1)) 
Do gO1 = 1, 3
  Do gO2 = gO1, 3
coup1 = cplUhhUhhhhhh(gO1,gO2,i1,i1)
    SumI(gO1,gO2) = -coup1*A0m2 
   End Do 
End Do 
res = res +1._dp/2._dp* SumI  
      End Do 
 !------------------------ 
! conj[Hpm], Hpm 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
 A0m2 = SA_A0(MHpm2(i1)) 
Do gO1 = 1, 3
  Do gO2 = gO1, 3
coup1 = cplUhhUhhHpmcHpm(gO1,gO2,i1,i1)
    SumI(gO1,gO2) = -coup1*A0m2 
   End Do 
End Do 
res = res +1._dp* SumI  
      End Do 
 !------------------------ 
! VP, VP 
!------------------------ 
sumI = 0._dp 
 
!------------------------ 
! conj[VWp], VWp 
!------------------------ 
sumI = 0._dp 
 
A0m2 = 0.75_dp*SA_A0(MVWp2) + 0.25_dp*RXi*SA_A0(MVWp2*RXi) - 0.5_dp*MVWp2*rMS 
Do gO1 = 1, 3
  Do gO2 = gO1, 3
coup1 = cplUhhUhhcVWpVWp(gO1,gO2)
    SumI(gO1,gO2) = coup1*A0m2 
   End Do 
End Do 
res = res +4._dp* SumI  
!------------------------ 
! conj[VXp], VXp 
!------------------------ 
sumI = 0._dp 
 
A0m2 = 0.75_dp*SA_A0(MVXp2) + 0.25_dp*RXi*SA_A0(MVXp2*RXi) - 0.5_dp*MVXp2*rMS 
Do gO1 = 1, 3
  Do gO2 = gO1, 3
coup1 = cplUhhUhhcVXpVXp(gO1,gO2)
    SumI(gO1,gO2) = coup1*A0m2 
   End Do 
End Do 
res = res +4._dp* SumI  
!------------------------ 
! VZ, VZ 
!------------------------ 
sumI = 0._dp 
 
A0m2 = 0.75_dp*SA_A0(MVZ2) + 0.25_dp*RXi*SA_A0(MVZ2*RXi) - 0.5_dp*MVZ2*rMS 
Do gO1 = 1, 3
  Do gO2 = gO1, 3
coup1 = cplUhhUhhVZVZ(gO1,gO2)
    SumI(gO1,gO2) = coup1*A0m2 
   End Do 
End Do 
res = res +2._dp* SumI  
!------------------------ 
! VZp, VZp 
!------------------------ 
sumI = 0._dp 
 
A0m2 = 0.75_dp*SA_A0(MVZp2) + 0.25_dp*RXi*SA_A0(MVZp2*RXi) - 0.5_dp*MVZp2*rMS 
Do gO1 = 1, 3
  Do gO2 = gO1, 3
coup1 = cplUhhUhhVZpVZp(gO1,gO2)
    SumI(gO1,gO2) = coup1*A0m2 
   End Do 
End Do 
res = res +2._dp* SumI  


Do gO2 = 1, 3
  Do gO1 = gO2+1, 3
     res(gO1,gO2) = (res(gO2,gO1))  
   End Do 
End Do 
 
res = oo16pi2*res 
 
End Subroutine Pi1Loophh 
 
Subroutine OneLoopAh(g1,g2,mu12,mu22,mu32,ftri,l1,l12,l13,l2,l23,l3,Vn,               & 
& v1,v2,ZZ,MAh,MAh2,Mhh,Mhh2,MDpm,MDpm2,MFd,MFd2,MFe,MFe2,MFu,MFu2,MVZ,MVZ2,             & 
& MVZp,MVZp2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,cplUAhAhAh,cplUAhAhhh,cplUAhDpmcDpm,       & 
& cplcFdFdUAhL,cplcFdFdUAhR,cplcFeFeUAhL,cplcFeFeUAhR,cplcFuFuUAhL,cplcFuFuUAhR,         & 
& cplcgWpgWpUAh,cplcgWCgWCUAh,cplcgXp1gXp1UAh,cplcgXp2gXp2UAh,cplUAhhhhh,cplUAhhhVP,     & 
& cplUAhhhVZ,cplUAhhhVZp,cplUAhHpmcHpm,cplUAhHpmVWp,cplUAhHpmVXp,cplUAhUAhAhAh,          & 
& cplUAhUAhDpmcDpm,cplUAhUAhhhhh,cplUAhUAhHpmcHpm,cplUAhUAhVPVP,cplUAhUAhcVWpVWp,        & 
& cplUAhUAhcVXpVXp,cplUAhUAhVZVZ,cplUAhUAhVZpVZp,delta,mass,mass2,RS,kont)

Implicit None 
Real(dp), Intent(in) :: MAh(3),MAh2(3),Mhh(3),Mhh2(3),MDpm(2),MDpm2(2),MFd(5),MFd2(5),MFe(3),MFe2(3),         & 
& MFu(4),MFu2(4),MVZ,MVZ2,MVZp,MVZp2,MHpm(4),MHpm2(4),MVWp,MVWp2,MVXp,MVXp2

Real(dp), Intent(in) :: g1,g2,mu12,mu22,mu32,ftri,Vn,v1,v2

Complex(dp), Intent(in) :: l1,l12,l13,l2,l23,l3,ZZ(3,3)

Complex(dp), Intent(in) :: cplUAhAhAh(3,3,3),cplUAhAhhh(3,3,3),cplUAhDpmcDpm(3,2,2),cplcFdFdUAhL(5,5,3),         & 
& cplcFdFdUAhR(5,5,3),cplcFeFeUAhL(3,3,3),cplcFeFeUAhR(3,3,3),cplcFuFuUAhL(4,4,3),       & 
& cplcFuFuUAhR(4,4,3),cplcgWpgWpUAh(3),cplcgWCgWCUAh(3),cplcgXp1gXp1UAh(3),              & 
& cplcgXp2gXp2UAh(3),cplUAhhhhh(3,3,3),cplUAhhhVP(3,3),cplUAhhhVZ(3,3),cplUAhhhVZp(3,3), & 
& cplUAhHpmcHpm(3,4,4),cplUAhHpmVWp(3,4),cplUAhHpmVXp(3,4),cplUAhUAhAhAh(3,3,3,3),       & 
& cplUAhUAhDpmcDpm(3,3,2,2),cplUAhUAhhhhh(3,3,3,3),cplUAhUAhHpmcHpm(3,3,4,4),            & 
& cplUAhUAhVPVP(3,3),cplUAhUAhcVWpVWp(3,3),cplUAhUAhcVXpVXp(3,3),cplUAhUAhVZVZ(3,3),     & 
& cplUAhUAhVZpVZp(3,3)

Complex(dp) :: mat2a(3,3), mat2(3,3),  PiSf(3,3,3)
Integer , Intent(inout):: kont 
Integer :: i1,i2,i3,i4,j1,j2,j3,j4,il,i_count, ierr 
Real(dp), Intent(in) :: delta 
Real(dp) :: mi2(3), test_m2(3),p2, test(3) 
Real(dp), Intent(out) :: mass(3), mass2(3) 
Complex(dp), Intent(out) ::  RS(3,3) 
Iname = Iname + 1 
NameOfUnit(Iname) = 'OneLoopAh'
 
mat2a(1,1) = 0._dp 
mat2a(1,1) = mat2a(1,1)-1._dp*(mu12)
mat2a(1,1) = mat2a(1,1)+l1*Vn**2
mat2a(1,1) = mat2a(1,1)+l12*v1**2
mat2a(1,1) = mat2a(1,1)+l13*v2**2
mat2a(1,1) = mat2a(1,1)+(2*g1**2*Vn**2*Conjg(ZZ(1,2))*RXiZ*ZZ(1,2))/9._dp
mat2a(1,1) = mat2a(1,1)+(2*g1*g2*Vn**2*Conjg(ZZ(2,2))*RXiZ*ZZ(1,2))/(3._dp*sqrt(3._dp))
mat2a(1,1) = mat2a(1,1)+(2*g1**2*Vn**2*Conjg(ZZ(1,3))*RXiZp*ZZ(1,3))/9._dp
mat2a(1,1) = mat2a(1,1)+(2*g1*g2*Vn**2*Conjg(ZZ(2,3))*RXiZp*ZZ(1,3))/(3._dp*sqrt(3._dp))
mat2a(1,1) = mat2a(1,1)+(2*g1*g2*Vn**2*Conjg(ZZ(1,2))*RXiZ*ZZ(2,2))/(3._dp*sqrt(3._dp))
mat2a(1,1) = mat2a(1,1)+(2*g2**2*Vn**2*Conjg(ZZ(2,2))*RXiZ*ZZ(2,2))/3._dp
mat2a(1,1) = mat2a(1,1)+(2*g1*g2*Vn**2*Conjg(ZZ(1,3))*RXiZp*ZZ(2,3))/(3._dp*sqrt(3._dp))
mat2a(1,1) = mat2a(1,1)+(2*g2**2*Vn**2*Conjg(ZZ(2,3))*RXiZp*ZZ(2,3))/3._dp
mat2a(1,2) = 0._dp 
mat2a(1,2) = mat2a(1,2)+(ftri*v2)/sqrt(2._dp)
mat2a(1,2) = mat2a(1,2)+(2*g1**2*Vn*v1*Conjg(ZZ(1,2))*RXiZ*ZZ(1,2))/9._dp
mat2a(1,2) = mat2a(1,2)+(g1*g2*Vn*v1*Conjg(ZZ(2,2))*RXiZ*ZZ(1,2))/(6._dp*sqrt(3._dp))
mat2a(1,2) = mat2a(1,2)+(g1*g2*Vn*v1*Conjg(ZZ(3,2))*RXiZ*ZZ(1,2))/6._dp
mat2a(1,2) = mat2a(1,2)+(2*g1**2*Vn*v1*Conjg(ZZ(1,3))*RXiZp*ZZ(1,3))/9._dp
mat2a(1,2) = mat2a(1,2)+(g1*g2*Vn*v1*Conjg(ZZ(2,3))*RXiZp*ZZ(1,3))/(6._dp*sqrt(3._dp))
mat2a(1,2) = mat2a(1,2)+(g1*g2*Vn*v1*Conjg(ZZ(3,3))*RXiZp*ZZ(1,3))/6._dp
mat2a(1,2) = mat2a(1,2)+(g1*g2*Vn*v1*Conjg(ZZ(1,2))*RXiZ*ZZ(2,2))/(6._dp*sqrt(3._dp))
mat2a(1,2) = mat2a(1,2)-(g2**2*Vn*v1*Conjg(ZZ(2,2))*RXiZ*ZZ(2,2))/3._dp
mat2a(1,2) = mat2a(1,2)+(g2**2*Vn*v1*Conjg(ZZ(3,2))*RXiZ*ZZ(2,2))/(2._dp*sqrt(3._dp))
mat2a(1,2) = mat2a(1,2)+(g1*g2*Vn*v1*Conjg(ZZ(1,3))*RXiZp*ZZ(2,3))/(6._dp*sqrt(3._dp))
mat2a(1,2) = mat2a(1,2)-(g2**2*Vn*v1*Conjg(ZZ(2,3))*RXiZp*ZZ(2,3))/3._dp
mat2a(1,2) = mat2a(1,2)+(g2**2*Vn*v1*Conjg(ZZ(3,3))*RXiZp*ZZ(2,3))/(2._dp*sqrt(3._dp))
mat2a(1,2) = mat2a(1,2)+(g1*g2*Vn*v1*Conjg(ZZ(1,2))*RXiZ*ZZ(3,2))/6._dp
mat2a(1,2) = mat2a(1,2)+(g2**2*Vn*v1*Conjg(ZZ(2,2))*RXiZ*ZZ(3,2))/(2._dp*sqrt(3._dp))
mat2a(1,2) = mat2a(1,2)+(g1*g2*Vn*v1*Conjg(ZZ(1,3))*RXiZp*ZZ(3,3))/6._dp
mat2a(1,2) = mat2a(1,2)+(g2**2*Vn*v1*Conjg(ZZ(2,3))*RXiZp*ZZ(3,3))/(2._dp*sqrt(3._dp))
mat2a(1,3) = 0._dp 
mat2a(1,3) = mat2a(1,3)+(ftri*v1)/sqrt(2._dp)
mat2a(1,3) = mat2a(1,3)+(-4*g1**2*Vn*v2*Conjg(ZZ(1,2))*RXiZ*ZZ(1,2))/9._dp
mat2a(1,3) = mat2a(1,3)+(-5*g1*g2*Vn*v2*Conjg(ZZ(2,2))*RXiZ*ZZ(1,2))/(6._dp*sqrt(3._dp))
mat2a(1,3) = mat2a(1,3)-(g1*g2*Vn*v2*Conjg(ZZ(3,2))*RXiZ*ZZ(1,2))/6._dp
mat2a(1,3) = mat2a(1,3)+(-4*g1**2*Vn*v2*Conjg(ZZ(1,3))*RXiZp*ZZ(1,3))/9._dp
mat2a(1,3) = mat2a(1,3)+(-5*g1*g2*Vn*v2*Conjg(ZZ(2,3))*RXiZp*ZZ(1,3))/(6._dp*sqrt(3._dp))
mat2a(1,3) = mat2a(1,3)-(g1*g2*Vn*v2*Conjg(ZZ(3,3))*RXiZp*ZZ(1,3))/6._dp
mat2a(1,3) = mat2a(1,3)+(-5*g1*g2*Vn*v2*Conjg(ZZ(1,2))*RXiZ*ZZ(2,2))/(6._dp*sqrt(3._dp))
mat2a(1,3) = mat2a(1,3)-(g2**2*Vn*v2*Conjg(ZZ(2,2))*RXiZ*ZZ(2,2))/3._dp
mat2a(1,3) = mat2a(1,3)-(g2**2*Vn*v2*Conjg(ZZ(3,2))*RXiZ*ZZ(2,2))/(2._dp*sqrt(3._dp))
mat2a(1,3) = mat2a(1,3)+(-5*g1*g2*Vn*v2*Conjg(ZZ(1,3))*RXiZp*ZZ(2,3))/(6._dp*sqrt(3._dp))
mat2a(1,3) = mat2a(1,3)-(g2**2*Vn*v2*Conjg(ZZ(2,3))*RXiZp*ZZ(2,3))/3._dp
mat2a(1,3) = mat2a(1,3)-(g2**2*Vn*v2*Conjg(ZZ(3,3))*RXiZp*ZZ(2,3))/(2._dp*sqrt(3._dp))
mat2a(1,3) = mat2a(1,3)-(g1*g2*Vn*v2*Conjg(ZZ(1,2))*RXiZ*ZZ(3,2))/6._dp
mat2a(1,3) = mat2a(1,3)-(g2**2*Vn*v2*Conjg(ZZ(2,2))*RXiZ*ZZ(3,2))/(2._dp*sqrt(3._dp))
mat2a(1,3) = mat2a(1,3)-(g1*g2*Vn*v2*Conjg(ZZ(1,3))*RXiZp*ZZ(3,3))/6._dp
mat2a(1,3) = mat2a(1,3)-(g2**2*Vn*v2*Conjg(ZZ(2,3))*RXiZp*ZZ(3,3))/(2._dp*sqrt(3._dp))
mat2a(2,2) = 0._dp 
mat2a(2,2) = mat2a(2,2)+mu22
mat2a(2,2) = mat2a(2,2)+l12*Vn**2
mat2a(2,2) = mat2a(2,2)+l2*v1**2
mat2a(2,2) = mat2a(2,2)+l23*v2**2
mat2a(2,2) = mat2a(2,2)+(2*g1**2*v1**2*Conjg(ZZ(1,2))*RXiZ*ZZ(1,2))/9._dp
mat2a(2,2) = mat2a(2,2)-(g1*g2*v1**2*Conjg(ZZ(2,2))*RXiZ*ZZ(1,2))/(3._dp*sqrt(3._dp))
mat2a(2,2) = mat2a(2,2)+(g1*g2*v1**2*Conjg(ZZ(3,2))*RXiZ*ZZ(1,2))/3._dp
mat2a(2,2) = mat2a(2,2)+(2*g1**2*v1**2*Conjg(ZZ(1,3))*RXiZp*ZZ(1,3))/9._dp
mat2a(2,2) = mat2a(2,2)-(g1*g2*v1**2*Conjg(ZZ(2,3))*RXiZp*ZZ(1,3))/(3._dp*sqrt(3._dp))
mat2a(2,2) = mat2a(2,2)+(g1*g2*v1**2*Conjg(ZZ(3,3))*RXiZp*ZZ(1,3))/3._dp
mat2a(2,2) = mat2a(2,2)-(g1*g2*v1**2*Conjg(ZZ(1,2))*RXiZ*ZZ(2,2))/(3._dp*sqrt(3._dp))
mat2a(2,2) = mat2a(2,2)+(g2**2*v1**2*Conjg(ZZ(2,2))*RXiZ*ZZ(2,2))/6._dp
mat2a(2,2) = mat2a(2,2)-(g2**2*v1**2*Conjg(ZZ(3,2))*RXiZ*ZZ(2,2))/(2._dp*sqrt(3._dp))
mat2a(2,2) = mat2a(2,2)-(g1*g2*v1**2*Conjg(ZZ(1,3))*RXiZp*ZZ(2,3))/(3._dp*sqrt(3._dp))
mat2a(2,2) = mat2a(2,2)+(g2**2*v1**2*Conjg(ZZ(2,3))*RXiZp*ZZ(2,3))/6._dp
mat2a(2,2) = mat2a(2,2)-(g2**2*v1**2*Conjg(ZZ(3,3))*RXiZp*ZZ(2,3))/(2._dp*sqrt(3._dp))
mat2a(2,2) = mat2a(2,2)+(g1*g2*v1**2*Conjg(ZZ(1,2))*RXiZ*ZZ(3,2))/3._dp
mat2a(2,2) = mat2a(2,2)-(g2**2*v1**2*Conjg(ZZ(2,2))*RXiZ*ZZ(3,2))/(2._dp*sqrt(3._dp))
mat2a(2,2) = mat2a(2,2)+(g2**2*v1**2*Conjg(ZZ(3,2))*RXiZ*ZZ(3,2))/2._dp
mat2a(2,2) = mat2a(2,2)+(g1*g2*v1**2*Conjg(ZZ(1,3))*RXiZp*ZZ(3,3))/3._dp
mat2a(2,2) = mat2a(2,2)-(g2**2*v1**2*Conjg(ZZ(2,3))*RXiZp*ZZ(3,3))/(2._dp*sqrt(3._dp))
mat2a(2,2) = mat2a(2,2)+(g2**2*v1**2*Conjg(ZZ(3,3))*RXiZp*ZZ(3,3))/2._dp
mat2a(2,3) = 0._dp 
mat2a(2,3) = mat2a(2,3)+(ftri*Vn)/sqrt(2._dp)
mat2a(2,3) = mat2a(2,3)+(-4*g1**2*v1*v2*Conjg(ZZ(1,2))*RXiZ*ZZ(1,2))/9._dp
mat2a(2,3) = mat2a(2,3)+(g1*g2*v1*v2*Conjg(ZZ(2,2))*RXiZ*ZZ(1,2))/(6._dp*sqrt(3._dp))
mat2a(2,3) = mat2a(2,3)-(g1*g2*v1*v2*Conjg(ZZ(3,2))*RXiZ*ZZ(1,2))/2._dp
mat2a(2,3) = mat2a(2,3)+(-4*g1**2*v1*v2*Conjg(ZZ(1,3))*RXiZp*ZZ(1,3))/9._dp
mat2a(2,3) = mat2a(2,3)+(g1*g2*v1*v2*Conjg(ZZ(2,3))*RXiZp*ZZ(1,3))/(6._dp*sqrt(3._dp))
mat2a(2,3) = mat2a(2,3)-(g1*g2*v1*v2*Conjg(ZZ(3,3))*RXiZp*ZZ(1,3))/2._dp
mat2a(2,3) = mat2a(2,3)+(g1*g2*v1*v2*Conjg(ZZ(1,2))*RXiZ*ZZ(2,2))/(6._dp*sqrt(3._dp))
mat2a(2,3) = mat2a(2,3)+(g2**2*v1*v2*Conjg(ZZ(2,2))*RXiZ*ZZ(2,2))/6._dp
mat2a(2,3) = mat2a(2,3)+(g1*g2*v1*v2*Conjg(ZZ(1,3))*RXiZp*ZZ(2,3))/(6._dp*sqrt(3._dp))
mat2a(2,3) = mat2a(2,3)+(g2**2*v1*v2*Conjg(ZZ(2,3))*RXiZp*ZZ(2,3))/6._dp
mat2a(2,3) = mat2a(2,3)-(g1*g2*v1*v2*Conjg(ZZ(1,2))*RXiZ*ZZ(3,2))/2._dp
mat2a(2,3) = mat2a(2,3)-(g2**2*v1*v2*Conjg(ZZ(3,2))*RXiZ*ZZ(3,2))/2._dp
mat2a(2,3) = mat2a(2,3)-(g1*g2*v1*v2*Conjg(ZZ(1,3))*RXiZp*ZZ(3,3))/2._dp
mat2a(2,3) = mat2a(2,3)-(g2**2*v1*v2*Conjg(ZZ(3,3))*RXiZp*ZZ(3,3))/2._dp
mat2a(3,3) = 0._dp 
mat2a(3,3) = mat2a(3,3)+mu32
mat2a(3,3) = mat2a(3,3)+l13*Vn**2
mat2a(3,3) = mat2a(3,3)+l23*v1**2
mat2a(3,3) = mat2a(3,3)+(2*l3*v2**2)/3._dp
mat2a(3,3) = mat2a(3,3)+(8*g1**2*v2**2*Conjg(ZZ(1,2))*RXiZ*ZZ(1,2))/9._dp
mat2a(3,3) = mat2a(3,3)+(2*g1*g2*v2**2*Conjg(ZZ(2,2))*RXiZ*ZZ(1,2))/(3._dp*sqrt(3._dp))
mat2a(3,3) = mat2a(3,3)+(2*g1*g2*v2**2*Conjg(ZZ(3,2))*RXiZ*ZZ(1,2))/3._dp
mat2a(3,3) = mat2a(3,3)+(8*g1**2*v2**2*Conjg(ZZ(1,3))*RXiZp*ZZ(1,3))/9._dp
mat2a(3,3) = mat2a(3,3)+(2*g1*g2*v2**2*Conjg(ZZ(2,3))*RXiZp*ZZ(1,3))/(3._dp*sqrt(3._dp))
mat2a(3,3) = mat2a(3,3)+(2*g1*g2*v2**2*Conjg(ZZ(3,3))*RXiZp*ZZ(1,3))/3._dp
mat2a(3,3) = mat2a(3,3)+(2*g1*g2*v2**2*Conjg(ZZ(1,2))*RXiZ*ZZ(2,2))/(3._dp*sqrt(3._dp))
mat2a(3,3) = mat2a(3,3)+(g2**2*v2**2*Conjg(ZZ(2,2))*RXiZ*ZZ(2,2))/6._dp
mat2a(3,3) = mat2a(3,3)+(g2**2*v2**2*Conjg(ZZ(3,2))*RXiZ*ZZ(2,2))/(2._dp*sqrt(3._dp))
mat2a(3,3) = mat2a(3,3)+(2*g1*g2*v2**2*Conjg(ZZ(1,3))*RXiZp*ZZ(2,3))/(3._dp*sqrt(3._dp))
mat2a(3,3) = mat2a(3,3)+(g2**2*v2**2*Conjg(ZZ(2,3))*RXiZp*ZZ(2,3))/6._dp
mat2a(3,3) = mat2a(3,3)+(g2**2*v2**2*Conjg(ZZ(3,3))*RXiZp*ZZ(2,3))/(2._dp*sqrt(3._dp))
mat2a(3,3) = mat2a(3,3)+(2*g1*g2*v2**2*Conjg(ZZ(1,2))*RXiZ*ZZ(3,2))/3._dp
mat2a(3,3) = mat2a(3,3)+(g2**2*v2**2*Conjg(ZZ(2,2))*RXiZ*ZZ(3,2))/(2._dp*sqrt(3._dp))
mat2a(3,3) = mat2a(3,3)+(g2**2*v2**2*Conjg(ZZ(3,2))*RXiZ*ZZ(3,2))/2._dp
mat2a(3,3) = mat2a(3,3)+(2*g1*g2*v2**2*Conjg(ZZ(1,3))*RXiZp*ZZ(3,3))/3._dp
mat2a(3,3) = mat2a(3,3)+(g2**2*v2**2*Conjg(ZZ(2,3))*RXiZp*ZZ(3,3))/(2._dp*sqrt(3._dp))
mat2a(3,3) = mat2a(3,3)+(g2**2*v2**2*Conjg(ZZ(3,3))*RXiZp*ZZ(3,3))/2._dp

 
 Do i1=2,3
  Do i2 = 1, i1-1 
  mat2a(i1,i2) = (mat2a(i2,i1)) 
  End do 
End do 

 
! Rotation matrix for p2=0 
PiSf(1,:,:) = ZeroC 
p2 = 0._dp 
If (i1.eq.1) p2 = 0._dp 
If (i1.eq.2) p2 = 0._dp 
Call Pi1LoopAh(p2,MAh,MAh2,Mhh,Mhh2,MDpm,MDpm2,MFd,MFd2,MFe,MFe2,MFu,MFu2,            & 
& MVZ,MVZ2,MVZp,MVZp2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,cplUAhAhAh,cplUAhAhhh,            & 
& cplUAhDpmcDpm,cplcFdFdUAhL,cplcFdFdUAhR,cplcFeFeUAhL,cplcFeFeUAhR,cplcFuFuUAhL,        & 
& cplcFuFuUAhR,cplcgWpgWpUAh,cplcgWCgWCUAh,cplcgXp1gXp1UAh,cplcgXp2gXp2UAh,              & 
& cplUAhhhhh,cplUAhhhVP,cplUAhhhVZ,cplUAhhhVZp,cplUAhHpmcHpm,cplUAhHpmVWp,               & 
& cplUAhHpmVXp,cplUAhUAhAhAh,cplUAhUAhDpmcDpm,cplUAhUAhhhhh,cplUAhUAhHpmcHpm,            & 
& cplUAhUAhVPVP,cplUAhUAhcVWpVWp,cplUAhUAhcVXpVXp,cplUAhUAhVZVZ,cplUAhUAhVZpVZp,         & 
& kont,PiSf(1,:,:))

PiSf(1,:,:) = PiSf(1,:,:) - PiP2S_EffPot 
mat2 = mat2a - Real(PiSf(1,:,:),dp) 
Call Chop(mat2) 
Call Eigensystem(mat2,mi2,RS,kont,test) 
ZAOS_0 = RS 
 
 
! Now with momenta 
Do i1=1,3
PiSf(i1,:,:) = ZeroC 
p2 = MAh2(i1)
If (i1.eq.1) p2 = 0._dp 
If (i1.eq.2) p2 = 0._dp 
Call Pi1LoopAh(p2,MAh,MAh2,Mhh,Mhh2,MDpm,MDpm2,MFd,MFd2,MFe,MFe2,MFu,MFu2,            & 
& MVZ,MVZ2,MVZp,MVZp2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,cplUAhAhAh,cplUAhAhhh,            & 
& cplUAhDpmcDpm,cplcFdFdUAhL,cplcFdFdUAhR,cplcFeFeUAhL,cplcFeFeUAhR,cplcFuFuUAhL,        & 
& cplcFuFuUAhR,cplcgWpgWpUAh,cplcgWCgWCUAh,cplcgXp1gXp1UAh,cplcgXp2gXp2UAh,              & 
& cplUAhhhhh,cplUAhhhVP,cplUAhhhVZ,cplUAhhhVZp,cplUAhHpmcHpm,cplUAhHpmVWp,               & 
& cplUAhHpmVXp,cplUAhUAhAhAh,cplUAhUAhDpmcDpm,cplUAhUAhhhhh,cplUAhUAhHpmcHpm,            & 
& cplUAhUAhVPVP,cplUAhUAhcVWpVWp,cplUAhUAhcVXpVXp,cplUAhUAhVZVZ,cplUAhUAhVZpVZp,         & 
& kont,PiSf(i1,:,:))

End Do 
Do i1=3,1,-1 
PiSf(i1,:,:) = PiSf(i1,:,:) - PiP2S_EffPot 
mat2 = mat2a - Real(PiSf(i1,:,:),dp) 
Call Chop(mat2) 
Call Eigensystem(mat2,mi2,RS,kont,test) 
If ((kont.Eq.-8).Or.(kont.Eq.-9)) Then 
  Write(ErrCan,*) "Possible numerical problem in "//NameOfUnit(Iname) 
  Write(*,*) "Possible numerical problem in "//NameOfUnit(Iname) 
  If (ErrorLevel.Eq.2) Call TerminateProgram 
  kont = 0 
End If 
If ((kont.Ne.0).And.(ErrorLevel.Ge.0)) Then 
  Write(ErrCan,*) "Diagonalization did not work in routine "//NameOfUnit(Iname) 
  Write(*,*) "Diagonalization did not work in routine "//NameOfUnit(Iname) 
  If (ErrorLevel.Eq.2) Call TerminateProgram 
End If 
mass2(i1) = mi2(i1) 
End do 
 
Do i1=1,3
  If (Abs(mass2(i1)).Le.MaxMassNumericalZero**2) mass2(i1) = 0._dp 
  If (mass2(i1).Ge.0._dp) Then 
    mass(i1) = Sqrt(mass2(i1)) 
  Else 
   If (ErrorLevel.Ge.0) Then 
   If ((i1.Gt.1).or.(Abs(mass2(i1)).gt.MaxVal(Abs(mass2)))) Then 
     Write(*,*) 'Warning from routine '//NameOfUnit(Iname) 
     Write(*,*) 'in the calculation of the masses' 
     Write(*,*) 'occurred a negative mass squared!' 
   Call TerminateProgram 
   End If 
   End If 
   kont = -301 
   mass(i1) = 0._dp 
  End If 
End Do 
 
i_count = 0 
Do  
i_count = i_count + 1 
test_m2 = mass2 
Do i1=1,3
PiSf(i1,:,:) = ZeroC 
p2 =  mass2(i1) 
If (i1.eq.1) p2 = 0._dp 
If (i1.eq.2) p2 = 0._dp 
Call Pi1LoopAh(p2,MAh,MAh2,Mhh,Mhh2,MDpm,MDpm2,MFd,MFd2,MFe,MFe2,MFu,MFu2,            & 
& MVZ,MVZ2,MVZp,MVZp2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,cplUAhAhAh,cplUAhAhhh,            & 
& cplUAhDpmcDpm,cplcFdFdUAhL,cplcFdFdUAhR,cplcFeFeUAhL,cplcFeFeUAhR,cplcFuFuUAhL,        & 
& cplcFuFuUAhR,cplcgWpgWpUAh,cplcgWCgWCUAh,cplcgXp1gXp1UAh,cplcgXp2gXp2UAh,              & 
& cplUAhhhhh,cplUAhhhVP,cplUAhhhVZ,cplUAhhhVZp,cplUAhHpmcHpm,cplUAhHpmVWp,               & 
& cplUAhHpmVXp,cplUAhUAhAhAh,cplUAhUAhDpmcDpm,cplUAhUAhhhhh,cplUAhUAhHpmcHpm,            & 
& cplUAhUAhVPVP,cplUAhUAhcVWpVWp,cplUAhUAhcVXpVXp,cplUAhUAhVZVZ,cplUAhUAhVZpVZp,         & 
& kont,PiSf(i1,:,:))

End Do 
Do i1=3,1,-1 
PiSf(i1,:,:) = PiSf(i1,:,:) - PiP2S_EffPot 
mat2 = mat2a - Real(PiSf(i1,:,:),dp) 
Call Chop(mat2) 
Call Eigensystem(mat2,mi2,RS,kont,test) 
ZAOS_p2(i1,:) = RS(i1,:) 
 If ((kont.Eq.-8).Or.(kont.Eq.-9)) Then 
  Write(ErrCan,*) "Possible numerical problem in "//NameOfUnit(Iname) 
  Write(*,*) "Possible numerical problem in "//NameOfUnit(Iname) 
  If (ErrorLevel.Eq.2) Call TerminateProgram 
  kont = 0 
End If 
If ((kont.Ne.0).And.(ErrorLevel.Ge.0)) Then 
  Write(ErrCan,*) "Diagonalization did not work in routine "//NameOfUnit(Iname) 
  Write(*,*) "Diagonalization did not work in routine "//NameOfUnit(Iname) 
  If (ErrorLevel.Eq.2) Call TerminateProgram 
End If 
mass2(i1) = mi2(i1) 
End do 
Do i1=1,3
 If (Abs(mass2(i1)).Le.MaxMassNumericalZero**2) mass2(i1) = 0._dp 
 If (test_m2(i1).Ne.0._dp) Then 
    test_m2(i1) = Abs(test_m2(i1) - mass2(i1)) / test_m2(i1) 
 Else 
    test_m2(i1) = Abs(mass2(i1)) 
 End If 
 If (Abs(mass2(i1)).lt.1.0E-30_dp) test_m2(i1) = 0._dp 
 If (mass2(i1).Ge.0._dp) Then 
    mass(i1) = sqrt(mass2(i1)) 
  Else 
     Write(*,*) 'Warning from routine '//NameOfUnit(Iname) 
     Write(*,*) 'in the calculation of the masses occurred a negative mass squared!' 
     Write(*,*) 'generation: ',i1 
     Write(*,*) 'mass: ',mass2(i1) 
   SignOfMassChanged = .True. 
   mass(i1) = 0._dp 
  End If 
End Do 
 
If (Maxval(test_m2).LT.0.1_dp*delta) Exit 
If (i_count.Gt.30) Then 
  Write(*,*) "Problem in "//NameOfUnit(Iname), test_m2, mass2 
  kont = -510 
  Call AddError(510) 
 Exit 
End If 
End Do 
 
 
Iname = Iname -1 
End Subroutine OneLoopAh
 
 
Subroutine Pi1LoopAh(p2,MAh,MAh2,Mhh,Mhh2,MDpm,MDpm2,MFd,MFd2,MFe,MFe2,               & 
& MFu,MFu2,MVZ,MVZ2,MVZp,MVZp2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,cplUAhAhAh,              & 
& cplUAhAhhh,cplUAhDpmcDpm,cplcFdFdUAhL,cplcFdFdUAhR,cplcFeFeUAhL,cplcFeFeUAhR,          & 
& cplcFuFuUAhL,cplcFuFuUAhR,cplcgWpgWpUAh,cplcgWCgWCUAh,cplcgXp1gXp1UAh,cplcgXp2gXp2UAh, & 
& cplUAhhhhh,cplUAhhhVP,cplUAhhhVZ,cplUAhhhVZp,cplUAhHpmcHpm,cplUAhHpmVWp,               & 
& cplUAhHpmVXp,cplUAhUAhAhAh,cplUAhUAhDpmcDpm,cplUAhUAhhhhh,cplUAhUAhHpmcHpm,            & 
& cplUAhUAhVPVP,cplUAhUAhcVWpVWp,cplUAhUAhcVXpVXp,cplUAhUAhVZVZ,cplUAhUAhVZpVZp,kont,res)

Implicit None 
Real(dp), Intent(in) :: MAh(3),MAh2(3),Mhh(3),Mhh2(3),MDpm(2),MDpm2(2),MFd(5),MFd2(5),MFe(3),MFe2(3),         & 
& MFu(4),MFu2(4),MVZ,MVZ2,MVZp,MVZp2,MHpm(4),MHpm2(4),MVWp,MVWp2,MVXp,MVXp2

Complex(dp), Intent(in) :: cplUAhAhAh(3,3,3),cplUAhAhhh(3,3,3),cplUAhDpmcDpm(3,2,2),cplcFdFdUAhL(5,5,3),         & 
& cplcFdFdUAhR(5,5,3),cplcFeFeUAhL(3,3,3),cplcFeFeUAhR(3,3,3),cplcFuFuUAhL(4,4,3),       & 
& cplcFuFuUAhR(4,4,3),cplcgWpgWpUAh(3),cplcgWCgWCUAh(3),cplcgXp1gXp1UAh(3),              & 
& cplcgXp2gXp2UAh(3),cplUAhhhhh(3,3,3),cplUAhhhVP(3,3),cplUAhhhVZ(3,3),cplUAhhhVZp(3,3), & 
& cplUAhHpmcHpm(3,4,4),cplUAhHpmVWp(3,4),cplUAhHpmVXp(3,4),cplUAhUAhAhAh(3,3,3,3),       & 
& cplUAhUAhDpmcDpm(3,3,2,2),cplUAhUAhhhhh(3,3,3,3),cplUAhUAhHpmcHpm(3,3,4,4),            & 
& cplUAhUAhVPVP(3,3),cplUAhUAhcVWpVWp(3,3),cplUAhUAhcVXpVXp(3,3),cplUAhUAhVZVZ(3,3),     & 
& cplUAhUAhVZpVZp(3,3)

Integer, Intent(inout) :: kont 
Real(dp) :: B0m2, F0m2, G0m2,B1m2, m1, m2 
Real(dp), Intent(in) :: p2 
Complex(dp) :: A0m2 
Complex(dp), Intent(inout) :: res(3,3) 
Complex(dp) :: coupL1, coupR1, coupL2,coupR2, coup1,coup2,temp, sumI(3,3) 
Integer :: i1,i2,i3,i4,j1,j2,j3,j4, gO1, gO2, ierr 
 
 
res = 0._dp 
 
!------------------------ 
! Ah, Ah 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 3
       Do i2 = 1, 3
 B0m2 = Real(SA_B0(p2,MAh2(i1),MAh2(i2)),dp) 
Do gO1 = 1, 3
  Do gO2 = gO1, 3
coup1 = cplUAhAhAh(gO1,i1,i2)
coup2 = Conjg(cplUAhAhAh(gO2,i1,i2))
    SumI(gO1,gO2) = coup1*coup2*B0m2 
   End Do 
End Do 
res = res +1._dp/2._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! hh, Ah 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 3
       Do i2 = 1, 3
 B0m2 = Real(SA_B0(p2,Mhh2(i1),MAh2(i2)),dp) 
Do gO1 = 1, 3
  Do gO2 = gO1, 3
coup1 = cplUAhAhhh(gO1,i2,i1)
coup2 = Conjg(cplUAhAhhh(gO2,i2,i1))
    SumI(gO1,gO2) = coup1*coup2*B0m2 
   End Do 
End Do 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! conj[Dpm], Dpm 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 2
       Do i2 = 1, 2
 B0m2 = Real(SA_B0(p2,MDpm2(i1),MDpm2(i2)),dp) 
Do gO1 = 1, 3
  Do gO2 = gO1, 3
coup1 = cplUAhDpmcDpm(gO1,i2,i1)
coup2 = Conjg(cplUAhDpmcDpm(gO2,i2,i1))
    SumI(gO1,gO2) = coup1*coup2*B0m2 
   End Do 
End Do 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[Fd], Fd 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 5
       Do i2 = 1, 5
 G0m2 = Real(SA_Gloop(p2,MFd2(i1),MFd2(i2)),dp) 
B0m2 = -2._dp*MFd(i1)*MFd(i2)*Real(SA_B0(p2,MFd2(i1),MFd2(i2)),dp) 
Do gO1 = 1, 3
  Do gO2 = gO1, 3
coupL1 = cplcFdFdUAhL(i1,i2,gO1)
coupR1 = cplcFdFdUAhR(i1,i2,gO1)
coupL2 =  Conjg(cplcFdFdUAhL(i1,i2,gO2))
coupR2 =  Conjg(cplcFdFdUAhR(i1,i2,gO2))
    SumI(gO1,gO2) = (coupL1*coupL2+coupR1*coupR2)*G0m2 & 
                & + (coupL1*coupR2+coupR1*coupL2)*B0m2 
   End Do 
End Do 
res = res +3._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[Fe], Fe 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 3
       Do i2 = 1, 3
 G0m2 = Real(SA_Gloop(p2,MFe2(i1),MFe2(i2)),dp) 
B0m2 = -2._dp*MFe(i1)*MFe(i2)*Real(SA_B0(p2,MFe2(i1),MFe2(i2)),dp) 
Do gO1 = 1, 3
  Do gO2 = gO1, 3
coupL1 = cplcFeFeUAhL(i1,i2,gO1)
coupR1 = cplcFeFeUAhR(i1,i2,gO1)
coupL2 =  Conjg(cplcFeFeUAhL(i1,i2,gO2))
coupR2 =  Conjg(cplcFeFeUAhR(i1,i2,gO2))
    SumI(gO1,gO2) = (coupL1*coupL2+coupR1*coupR2)*G0m2 & 
                & + (coupL1*coupR2+coupR1*coupL2)*B0m2 
   End Do 
End Do 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[Fu], Fu 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
       Do i2 = 1, 4
 G0m2 = Real(SA_Gloop(p2,MFu2(i1),MFu2(i2)),dp) 
B0m2 = -2._dp*MFu(i1)*MFu(i2)*Real(SA_B0(p2,MFu2(i1),MFu2(i2)),dp) 
Do gO1 = 1, 3
  Do gO2 = gO1, 3
coupL1 = cplcFuFuUAhL(i1,i2,gO1)
coupR1 = cplcFuFuUAhR(i1,i2,gO1)
coupL2 =  Conjg(cplcFuFuUAhL(i1,i2,gO2))
coupR2 =  Conjg(cplcFuFuUAhR(i1,i2,gO2))
    SumI(gO1,gO2) = (coupL1*coupL2+coupR1*coupR2)*G0m2 & 
                & + (coupL1*coupR2+coupR1*coupL2)*B0m2 
   End Do 
End Do 
res = res +3._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[gWp], gWp 
!------------------------ 
sumI = 0._dp 
 
F0m2 = -Real(SA_B0(p2,MVWp2*RXi,MVWp2*RXi),dp) 
 Do gO1 = 1, 3
  Do gO2 = gO1, 3
coup1 = cplcgWpgWpUAh(gO1)
coup2 =  cplcgWpgWpUAh(gO2) 
    SumI(gO1,gO2) = coup1*coup2*F0m2 
   End Do 
End Do 
res = res +1._dp* SumI  
!------------------------ 
! bar[gWpC], gWpC 
!------------------------ 
sumI = 0._dp 
 
F0m2 = -Real(SA_B0(p2,MVWp2*RXi,MVWp2*RXi),dp) 
 Do gO1 = 1, 3
  Do gO2 = gO1, 3
coup1 = cplcgWCgWCUAh(gO1)
coup2 =  cplcgWCgWCUAh(gO2) 
    SumI(gO1,gO2) = coup1*coup2*F0m2 
   End Do 
End Do 
res = res +1._dp* SumI  
!------------------------ 
! bar[gXp], gXp 
!------------------------ 
sumI = 0._dp 
 
F0m2 = -Real(SA_B0(p2,MVXp2*RXi,MVXp2*RXi),dp) 
 Do gO1 = 1, 3
  Do gO2 = gO1, 3
coup1 = cplcgXp1gXp1UAh(gO1)
coup2 =  cplcgXp1gXp1UAh(gO2) 
    SumI(gO1,gO2) = coup1*coup2*F0m2 
   End Do 
End Do 
res = res +1._dp* SumI  
!------------------------ 
! bar[gXpC], gXpC 
!------------------------ 
sumI = 0._dp 
 
F0m2 = -Real(SA_B0(p2,MVXp2*RXi,MVXp2*RXi),dp) 
 Do gO1 = 1, 3
  Do gO2 = gO1, 3
coup1 = cplcgXp2gXp2UAh(gO1)
coup2 =  cplcgXp2gXp2UAh(gO2) 
    SumI(gO1,gO2) = coup1*coup2*F0m2 
   End Do 
End Do 
res = res +1._dp* SumI  
!------------------------ 
! hh, hh 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 3
       Do i2 = 1, 3
 B0m2 = Real(SA_B0(p2,Mhh2(i1),Mhh2(i2)),dp) 
Do gO1 = 1, 3
  Do gO2 = gO1, 3
coup1 = cplUAhhhhh(gO1,i1,i2)
coup2 = Conjg(cplUAhhhhh(gO2,i1,i2))
    SumI(gO1,gO2) = coup1*coup2*B0m2 
   End Do 
End Do 
res = res +1._dp/2._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! VP, hh 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 3
 F0m2 = FloopRXi(p2,Mhh2(i2),0._dp) 
Do gO1 = 1, 3
  Do gO2 = gO1, 3
coup1 = cplUAhhhVP(gO1,i2)
coup2 =  Conjg(cplUAhhhVP(gO2,i2))
    SumI(gO1,gO2) = coup1*coup2*F0m2 
   End Do 
End Do 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! VZ, hh 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 3
 F0m2 = FloopRXi(p2,Mhh2(i2),MVZ2) 
Do gO1 = 1, 3
  Do gO2 = gO1, 3
coup1 = cplUAhhhVZ(gO1,i2)
coup2 =  Conjg(cplUAhhhVZ(gO2,i2))
    SumI(gO1,gO2) = coup1*coup2*F0m2 
   End Do 
End Do 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! VZp, hh 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 3
 F0m2 = FloopRXi(p2,Mhh2(i2),MVZp2) 
Do gO1 = 1, 3
  Do gO2 = gO1, 3
coup1 = cplUAhhhVZp(gO1,i2)
coup2 =  Conjg(cplUAhhhVZp(gO2,i2))
    SumI(gO1,gO2) = coup1*coup2*F0m2 
   End Do 
End Do 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! conj[Hpm], Hpm 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
       Do i2 = 1, 4
 B0m2 = Real(SA_B0(p2,MHpm2(i1),MHpm2(i2)),dp) 
Do gO1 = 1, 3
  Do gO2 = gO1, 3
coup1 = cplUAhHpmcHpm(gO1,i2,i1)
coup2 = Conjg(cplUAhHpmcHpm(gO2,i2,i1))
    SumI(gO1,gO2) = coup1*coup2*B0m2 
   End Do 
End Do 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! VWp, Hpm 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 F0m2 = FloopRXi(p2,MHpm2(i2),MVWp2) 
Do gO1 = 1, 3
  Do gO2 = gO1, 3
coup1 = cplUAhHpmVWp(gO1,i2)
coup2 =  Conjg(cplUAhHpmVWp(gO2,i2))
    SumI(gO1,gO2) = coup1*coup2*F0m2 
   End Do 
End Do 
res = res +2._dp* SumI  
    End Do 
 !------------------------ 
! VXp, Hpm 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 F0m2 = FloopRXi(p2,MHpm2(i2),MVXp2) 
Do gO1 = 1, 3
  Do gO2 = gO1, 3
coup1 = cplUAhHpmVXp(gO1,i2)
coup2 =  Conjg(cplUAhHpmVXp(gO2,i2))
    SumI(gO1,gO2) = coup1*coup2*F0m2 
   End Do 
End Do 
res = res +2._dp* SumI  
    End Do 
 !------------------------ 
! Ah, Ah 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 3
 A0m2 = SA_A0(MAh2(i1)) 
Do gO1 = 1, 3
  Do gO2 = gO1, 3
coup1 = cplUAhUAhAhAh(gO1,gO2,i1,i1)
    SumI(gO1,gO2) = -coup1*A0m2 
   End Do 
End Do 
res = res +1._dp/2._dp* SumI  
      End Do 
 !------------------------ 
! conj[Dpm], Dpm 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 2
 A0m2 = SA_A0(MDpm2(i1)) 
Do gO1 = 1, 3
  Do gO2 = gO1, 3
coup1 = cplUAhUAhDpmcDpm(gO1,gO2,i1,i1)
    SumI(gO1,gO2) = -coup1*A0m2 
   End Do 
End Do 
res = res +1._dp* SumI  
      End Do 
 !------------------------ 
! hh, hh 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 3
 A0m2 = SA_A0(Mhh2(i1)) 
Do gO1 = 1, 3
  Do gO2 = gO1, 3
coup1 = cplUAhUAhhhhh(gO1,gO2,i1,i1)
    SumI(gO1,gO2) = -coup1*A0m2 
   End Do 
End Do 
res = res +1._dp/2._dp* SumI  
      End Do 
 !------------------------ 
! conj[Hpm], Hpm 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
 A0m2 = SA_A0(MHpm2(i1)) 
Do gO1 = 1, 3
  Do gO2 = gO1, 3
coup1 = cplUAhUAhHpmcHpm(gO1,gO2,i1,i1)
    SumI(gO1,gO2) = -coup1*A0m2 
   End Do 
End Do 
res = res +1._dp* SumI  
      End Do 
 !------------------------ 
! VP, VP 
!------------------------ 
sumI = 0._dp 
 
!------------------------ 
! conj[VWp], VWp 
!------------------------ 
sumI = 0._dp 
 
A0m2 = 0.75_dp*SA_A0(MVWp2) + 0.25_dp*RXi*SA_A0(MVWp2*RXi) - 0.5_dp*MVWp2*rMS 
Do gO1 = 1, 3
  Do gO2 = gO1, 3
coup1 = cplUAhUAhcVWpVWp(gO1,gO2)
    SumI(gO1,gO2) = coup1*A0m2 
   End Do 
End Do 
res = res +4._dp* SumI  
!------------------------ 
! conj[VXp], VXp 
!------------------------ 
sumI = 0._dp 
 
A0m2 = 0.75_dp*SA_A0(MVXp2) + 0.25_dp*RXi*SA_A0(MVXp2*RXi) - 0.5_dp*MVXp2*rMS 
Do gO1 = 1, 3
  Do gO2 = gO1, 3
coup1 = cplUAhUAhcVXpVXp(gO1,gO2)
    SumI(gO1,gO2) = coup1*A0m2 
   End Do 
End Do 
res = res +4._dp* SumI  
!------------------------ 
! VZ, VZ 
!------------------------ 
sumI = 0._dp 
 
A0m2 = 0.75_dp*SA_A0(MVZ2) + 0.25_dp*RXi*SA_A0(MVZ2*RXi) - 0.5_dp*MVZ2*rMS 
Do gO1 = 1, 3
  Do gO2 = gO1, 3
coup1 = cplUAhUAhVZVZ(gO1,gO2)
    SumI(gO1,gO2) = coup1*A0m2 
   End Do 
End Do 
res = res +2._dp* SumI  
!------------------------ 
! VZp, VZp 
!------------------------ 
sumI = 0._dp 
 
A0m2 = 0.75_dp*SA_A0(MVZp2) + 0.25_dp*RXi*SA_A0(MVZp2*RXi) - 0.5_dp*MVZp2*rMS 
Do gO1 = 1, 3
  Do gO2 = gO1, 3
coup1 = cplUAhUAhVZpVZp(gO1,gO2)
    SumI(gO1,gO2) = coup1*A0m2 
   End Do 
End Do 
res = res +2._dp* SumI  


Do gO2 = 1, 3
  Do gO1 = gO2+1, 3
     res(gO1,gO2) = (res(gO2,gO1))  
   End Do 
End Do 
 
res = oo16pi2*res 
 
End Subroutine Pi1LoopAh 
 
Subroutine OneLoopHpm(g2,mu12,mu22,mu32,ftri,l1,l12,l13,l13t,l2,l23,l23t,             & 
& l3,Vn,v1,v2,MVWp,MVWp2,MAh,MAh2,MVXp,MVXp2,MHpm,MHpm2,MDpm,MDpm2,MFu,MFu2,             & 
& MFd,MFd2,MFe,MFe2,Mhh,Mhh2,MVZ,MVZ2,MVZp,MVZp2,cplAhcUHpmcVWp,cplAhcUHpmcVXp,          & 
& cplAhHpmcUHpm,cplDpmcUHpmcVWp,cplDpmHpmcUHpm,cplcFuFdcUHpmL,cplcFuFdcUHpmR,            & 
& cplcFv1FecUHpmL,cplcFv1FecUHpmR,cplFeFv1cUHpmL,cplFeFv1cUHpmR,cplcgZgWCcUHpm,          & 
& cplcgWCgZUHpm,cplcgZpgWCcUHpm,cplcgWCgZpUHpm,cplcgZgXp2cUHpm,cplcgXp2gZUHpm,           & 
& cplcgZpgXp2cUHpm,cplcgXp2gZpUHpm,cplcgWpgZcUHpm,cplcgZgWpUHpm,cplcgXp1gZcUHpm,         & 
& cplcgZgXp1UHpm,cplcgWpgZpcUHpm,cplcgZpgWpUHpm,cplcgXp1gZpcUHpm,cplcgZpgXp1UHpm,        & 
& cplhhcUHpmcVWp,cplhhcUHpmcVXp,cplhhHpmcUHpm,cplHpmcUHpmVP,cplHpmcUHpmVZ,               & 
& cplHpmcUHpmVZp,cplcUHpmcVWpVP,cplcUHpmcVXpVP,cplcUHpmcVWpVZ,cplcUHpmcVXpVZ,            & 
& cplcUHpmcVWpVZp,cplcUHpmcVXpVZp,cplcDpmcUHpmcVXp,cplAhAhUHpmcUHpm,cplDpmUHpmcDpmcUHpm, & 
& cplhhhhUHpmcUHpm,cplUHpmHpmcUHpmcHpm,cplUHpmcUHpmVPVP,cplUHpmcUHpmcVWpVWp,             & 
& cplUHpmcUHpmcVXpVXp,cplUHpmcUHpmVZVZ,cplUHpmcUHpmVZpVZp,delta,mass,mass2,RS,kont)

Implicit None 
Real(dp), Intent(in) :: MVWp,MVWp2,MAh(3),MAh2(3),MVXp,MVXp2,MHpm(4),MHpm2(4),MDpm(2),MDpm2(2),               & 
& MFu(4),MFu2(4),MFd(5),MFd2(5),MFe(3),MFe2(3),Mhh(3),Mhh2(3),MVZ,MVZ2,MVZp,MVZp2

Real(dp), Intent(in) :: g2,mu12,mu22,mu32,ftri,Vn,v1,v2

Complex(dp), Intent(in) :: l1,l12,l13,l13t,l2,l23,l23t,l3

Complex(dp), Intent(in) :: cplAhcUHpmcVWp(3,4),cplAhcUHpmcVXp(3,4),cplAhHpmcUHpm(3,4,4),cplDpmcUHpmcVWp(2,4),    & 
& cplDpmHpmcUHpm(2,4,4),cplcFuFdcUHpmL(4,5,4),cplcFuFdcUHpmR(4,5,4),cplcFv1FecUHpmL(3,3,4),& 
& cplcFv1FecUHpmR(3,3,4),cplFeFv1cUHpmL(3,3,4),cplFeFv1cUHpmR(3,3,4),cplcgZgWCcUHpm(4),  & 
& cplcgWCgZUHpm(4),cplcgZpgWCcUHpm(4),cplcgWCgZpUHpm(4),cplcgZgXp2cUHpm(4),              & 
& cplcgXp2gZUHpm(4),cplcgZpgXp2cUHpm(4),cplcgXp2gZpUHpm(4),cplcgWpgZcUHpm(4),            & 
& cplcgZgWpUHpm(4),cplcgXp1gZcUHpm(4),cplcgZgXp1UHpm(4),cplcgWpgZpcUHpm(4),              & 
& cplcgZpgWpUHpm(4),cplcgXp1gZpcUHpm(4),cplcgZpgXp1UHpm(4),cplhhcUHpmcVWp(3,4),          & 
& cplhhcUHpmcVXp(3,4),cplhhHpmcUHpm(3,4,4),cplHpmcUHpmVP(4,4),cplHpmcUHpmVZ(4,4),        & 
& cplHpmcUHpmVZp(4,4),cplcUHpmcVWpVP(4),cplcUHpmcVXpVP(4),cplcUHpmcVWpVZ(4),             & 
& cplcUHpmcVXpVZ(4),cplcUHpmcVWpVZp(4),cplcUHpmcVXpVZp(4),cplcDpmcUHpmcVXp(2,4),         & 
& cplAhAhUHpmcUHpm(3,3,4,4),cplDpmUHpmcDpmcUHpm(2,4,2,4),cplhhhhUHpmcUHpm(3,3,4,4),      & 
& cplUHpmHpmcUHpmcHpm(4,4,4,4),cplUHpmcUHpmVPVP(4,4),cplUHpmcUHpmcVWpVWp(4,4),           & 
& cplUHpmcUHpmcVXpVXp(4,4),cplUHpmcUHpmVZVZ(4,4),cplUHpmcUHpmVZpVZp(4,4)

Complex(dp) :: mat2a(4,4), mat2(4,4),  PiSf(4,4,4)
Integer , Intent(inout):: kont 
Integer :: i1,i2,i3,i4,j1,j2,j3,j4,il,i_count, ierr 
Real(dp), Intent(in) :: delta 
Real(dp) :: mi2(4), test_m2(4),p2, test(4) 
Real(dp), Intent(out) :: mass(4), mass2(4) 
Complex(dp), Intent(out) ::  RS(4,4) 
Iname = Iname + 1 
NameOfUnit(Iname) = 'OneLoopHpm'
 
mat2a(1,1) = 0._dp 
mat2a(1,1) = mat2a(1,1)-1._dp*(mu12)
mat2a(1,1) = mat2a(1,1)+l1*Vn**2
mat2a(1,1) = mat2a(1,1)+l12*v1**2
mat2a(1,1) = mat2a(1,1)+l13*v2**2
mat2a(1,1) = mat2a(1,1)+l13t*v2**2
mat2a(1,1) = mat2a(1,1)+(g2**2*Vn**2*RXiXp)/2._dp
mat2a(1,2) = 0._dp 
mat2a(1,3) = 0._dp 
mat2a(1,4) = 0._dp 
mat2a(1,4) = mat2a(1,4)+sqrt(2._dp)*ftri*v1
mat2a(1,4) = mat2a(1,4)+l13t*Vn*v2
mat2a(1,4) = mat2a(1,4)-(g2**2*Vn*v2*RXiXp)/2._dp
mat2a(2,2) = 0._dp 
mat2a(2,2) = mat2a(2,2)+mu22
mat2a(2,2) = mat2a(2,2)+l12*Vn**2
mat2a(2,2) = mat2a(2,2)+l2*v1**2
mat2a(2,2) = mat2a(2,2)+l23*v2**2
mat2a(2,2) = mat2a(2,2)+l23t*v2**2
mat2a(2,2) = mat2a(2,2)+(g2**2*v1**2*RXiWp)/2._dp
mat2a(2,3) = 0._dp 
mat2a(2,3) = mat2a(2,3)+sqrt(2._dp)*ftri*Vn
mat2a(2,3) = mat2a(2,3)+l23t*v1*v2
mat2a(2,3) = mat2a(2,3)-(g2**2*v1*v2*RXiWp)/2._dp
mat2a(2,4) = 0._dp 
mat2a(3,3) = 0._dp 
mat2a(3,3) = mat2a(3,3)+mu32
mat2a(3,3) = mat2a(3,3)+l13*Vn**2
mat2a(3,3) = mat2a(3,3)+l23*v1**2
mat2a(3,3) = mat2a(3,3)+l23t*v1**2
mat2a(3,3) = mat2a(3,3)+(2*l3*v2**2)/3._dp
mat2a(3,3) = mat2a(3,3)+(g2**2*v2**2*RXiWp)/2._dp
mat2a(3,4) = 0._dp 
mat2a(4,4) = 0._dp 
mat2a(4,4) = mat2a(4,4)+mu32
mat2a(4,4) = mat2a(4,4)+l13*Vn**2
mat2a(4,4) = mat2a(4,4)+l13t*Vn**2
mat2a(4,4) = mat2a(4,4)+l23*v1**2
mat2a(4,4) = mat2a(4,4)+(2*l3*v2**2)/3._dp
mat2a(4,4) = mat2a(4,4)+(g2**2*v2**2*RXiXp)/2._dp

 
 Do i1=2,4
  Do i2 = 1, i1-1 
  mat2a(i1,i2) = Conjg(mat2a(i2,i1)) 
  End do 
End do 

 
! Rotation matrix for p2=0 
PiSf(1,:,:) = ZeroC 
p2 = 0._dp 
If (i1.eq.1) p2 = 0._dp 
If (i1.eq.2) p2 = 0._dp 
Call Pi1LoopHpm(p2,MVWp,MVWp2,MAh,MAh2,MVXp,MVXp2,MHpm,MHpm2,MDpm,MDpm2,              & 
& MFu,MFu2,MFd,MFd2,MFe,MFe2,Mhh,Mhh2,MVZ,MVZ2,MVZp,MVZp2,cplAhcUHpmcVWp,cplAhcUHpmcVXp, & 
& cplAhHpmcUHpm,cplDpmcUHpmcVWp,cplDpmHpmcUHpm,cplcFuFdcUHpmL,cplcFuFdcUHpmR,            & 
& cplcFv1FecUHpmL,cplcFv1FecUHpmR,cplFeFv1cUHpmL,cplFeFv1cUHpmR,cplcgZgWCcUHpm,          & 
& cplcgWCgZUHpm,cplcgZpgWCcUHpm,cplcgWCgZpUHpm,cplcgZgXp2cUHpm,cplcgXp2gZUHpm,           & 
& cplcgZpgXp2cUHpm,cplcgXp2gZpUHpm,cplcgWpgZcUHpm,cplcgZgWpUHpm,cplcgXp1gZcUHpm,         & 
& cplcgZgXp1UHpm,cplcgWpgZpcUHpm,cplcgZpgWpUHpm,cplcgXp1gZpcUHpm,cplcgZpgXp1UHpm,        & 
& cplhhcUHpmcVWp,cplhhcUHpmcVXp,cplhhHpmcUHpm,cplHpmcUHpmVP,cplHpmcUHpmVZ,               & 
& cplHpmcUHpmVZp,cplcUHpmcVWpVP,cplcUHpmcVXpVP,cplcUHpmcVWpVZ,cplcUHpmcVXpVZ,            & 
& cplcUHpmcVWpVZp,cplcUHpmcVXpVZp,cplcDpmcUHpmcVXp,cplAhAhUHpmcUHpm,cplDpmUHpmcDpmcUHpm, & 
& cplhhhhUHpmcUHpm,cplUHpmHpmcUHpmcHpm,cplUHpmcUHpmVPVP,cplUHpmcUHpmcVWpVWp,             & 
& cplUHpmcUHpmcVXpVXp,cplUHpmcUHpmVZVZ,cplUHpmcUHpmVZpVZp,kont,PiSf(1,:,:))

mat2 = mat2a - Real(PiSf(1,:,:),dp) 
Call Chop(mat2) 
Call Eigensystem(mat2,mi2,RS,kont,test) 
ZPOS_0 = RS 
 
 
! Now with momenta 
Do i1=1,4
PiSf(i1,:,:) = ZeroC 
p2 = MHpm2(i1)
If (i1.eq.1) p2 = 0._dp 
If (i1.eq.2) p2 = 0._dp 
Call Pi1LoopHpm(p2,MVWp,MVWp2,MAh,MAh2,MVXp,MVXp2,MHpm,MHpm2,MDpm,MDpm2,              & 
& MFu,MFu2,MFd,MFd2,MFe,MFe2,Mhh,Mhh2,MVZ,MVZ2,MVZp,MVZp2,cplAhcUHpmcVWp,cplAhcUHpmcVXp, & 
& cplAhHpmcUHpm,cplDpmcUHpmcVWp,cplDpmHpmcUHpm,cplcFuFdcUHpmL,cplcFuFdcUHpmR,            & 
& cplcFv1FecUHpmL,cplcFv1FecUHpmR,cplFeFv1cUHpmL,cplFeFv1cUHpmR,cplcgZgWCcUHpm,          & 
& cplcgWCgZUHpm,cplcgZpgWCcUHpm,cplcgWCgZpUHpm,cplcgZgXp2cUHpm,cplcgXp2gZUHpm,           & 
& cplcgZpgXp2cUHpm,cplcgXp2gZpUHpm,cplcgWpgZcUHpm,cplcgZgWpUHpm,cplcgXp1gZcUHpm,         & 
& cplcgZgXp1UHpm,cplcgWpgZpcUHpm,cplcgZpgWpUHpm,cplcgXp1gZpcUHpm,cplcgZpgXp1UHpm,        & 
& cplhhcUHpmcVWp,cplhhcUHpmcVXp,cplhhHpmcUHpm,cplHpmcUHpmVP,cplHpmcUHpmVZ,               & 
& cplHpmcUHpmVZp,cplcUHpmcVWpVP,cplcUHpmcVXpVP,cplcUHpmcVWpVZ,cplcUHpmcVXpVZ,            & 
& cplcUHpmcVWpVZp,cplcUHpmcVXpVZp,cplcDpmcUHpmcVXp,cplAhAhUHpmcUHpm,cplDpmUHpmcDpmcUHpm, & 
& cplhhhhUHpmcUHpm,cplUHpmHpmcUHpmcHpm,cplUHpmcUHpmVPVP,cplUHpmcUHpmcVWpVWp,             & 
& cplUHpmcUHpmcVXpVXp,cplUHpmcUHpmVZVZ,cplUHpmcUHpmVZpVZp,kont,PiSf(i1,:,:))

End Do 
Do i1=4,1,-1 
mat2 = mat2a - Real(PiSf(i1,:,:),dp) 
Call Chop(mat2) 
Call Eigensystem(mat2,mi2,RS,kont,test) 
If ((kont.Eq.-8).Or.(kont.Eq.-9)) Then 
  Write(ErrCan,*) "Possible numerical problem in "//NameOfUnit(Iname) 
  Write(*,*) "Possible numerical problem in "//NameOfUnit(Iname) 
  If (ErrorLevel.Eq.2) Call TerminateProgram 
  kont = 0 
End If 
If ((kont.Ne.0).And.(ErrorLevel.Ge.0)) Then 
  Write(ErrCan,*) "Diagonalization did not work in routine "//NameOfUnit(Iname) 
  Write(*,*) "Diagonalization did not work in routine "//NameOfUnit(Iname) 
  If (ErrorLevel.Eq.2) Call TerminateProgram 
End If 
mass2(i1) = mi2(i1) 
End do 
 
Do i1=1,4
  If (Abs(mass2(i1)).Le.MaxMassNumericalZero**2) mass2(i1) = 0._dp 
  If (mass2(i1).Ge.0._dp) Then 
    mass(i1) = Sqrt(mass2(i1)) 
  Else 
   If (ErrorLevel.Ge.0) Then 
   If ((i1.Gt.1).or.(Abs(mass2(i1)).gt.MaxVal(Abs(mass2)))) Then 
     Write(*,*) 'Warning from routine '//NameOfUnit(Iname) 
     Write(*,*) 'in the calculation of the masses' 
     Write(*,*) 'occurred a negative mass squared!' 
   Call TerminateProgram 
   End If 
   End If 
   kont = -301 
   mass(i1) = 0._dp 
  End If 
End Do 
 
i_count = 0 
Do  
i_count = i_count + 1 
test_m2 = mass2 
Do i1=1,4
PiSf(i1,:,:) = ZeroC 
p2 =  mass2(i1) 
If (i1.eq.1) p2 = 0._dp 
If (i1.eq.2) p2 = 0._dp 
Call Pi1LoopHpm(p2,MVWp,MVWp2,MAh,MAh2,MVXp,MVXp2,MHpm,MHpm2,MDpm,MDpm2,              & 
& MFu,MFu2,MFd,MFd2,MFe,MFe2,Mhh,Mhh2,MVZ,MVZ2,MVZp,MVZp2,cplAhcUHpmcVWp,cplAhcUHpmcVXp, & 
& cplAhHpmcUHpm,cplDpmcUHpmcVWp,cplDpmHpmcUHpm,cplcFuFdcUHpmL,cplcFuFdcUHpmR,            & 
& cplcFv1FecUHpmL,cplcFv1FecUHpmR,cplFeFv1cUHpmL,cplFeFv1cUHpmR,cplcgZgWCcUHpm,          & 
& cplcgWCgZUHpm,cplcgZpgWCcUHpm,cplcgWCgZpUHpm,cplcgZgXp2cUHpm,cplcgXp2gZUHpm,           & 
& cplcgZpgXp2cUHpm,cplcgXp2gZpUHpm,cplcgWpgZcUHpm,cplcgZgWpUHpm,cplcgXp1gZcUHpm,         & 
& cplcgZgXp1UHpm,cplcgWpgZpcUHpm,cplcgZpgWpUHpm,cplcgXp1gZpcUHpm,cplcgZpgXp1UHpm,        & 
& cplhhcUHpmcVWp,cplhhcUHpmcVXp,cplhhHpmcUHpm,cplHpmcUHpmVP,cplHpmcUHpmVZ,               & 
& cplHpmcUHpmVZp,cplcUHpmcVWpVP,cplcUHpmcVXpVP,cplcUHpmcVWpVZ,cplcUHpmcVXpVZ,            & 
& cplcUHpmcVWpVZp,cplcUHpmcVXpVZp,cplcDpmcUHpmcVXp,cplAhAhUHpmcUHpm,cplDpmUHpmcDpmcUHpm, & 
& cplhhhhUHpmcUHpm,cplUHpmHpmcUHpmcHpm,cplUHpmcUHpmVPVP,cplUHpmcUHpmcVWpVWp,             & 
& cplUHpmcUHpmcVXpVXp,cplUHpmcUHpmVZVZ,cplUHpmcUHpmVZpVZp,kont,PiSf(i1,:,:))

End Do 
Do i1=4,1,-1 
mat2 = mat2a - Real(PiSf(i1,:,:),dp) 
Call Chop(mat2) 
Call Eigensystem(mat2,mi2,RS,kont,test) 
ZPOS_p2(i1,:) = RS(i1,:) 
 If ((kont.Eq.-8).Or.(kont.Eq.-9)) Then 
  Write(ErrCan,*) "Possible numerical problem in "//NameOfUnit(Iname) 
  Write(*,*) "Possible numerical problem in "//NameOfUnit(Iname) 
  If (ErrorLevel.Eq.2) Call TerminateProgram 
  kont = 0 
End If 
If ((kont.Ne.0).And.(ErrorLevel.Ge.0)) Then 
  Write(ErrCan,*) "Diagonalization did not work in routine "//NameOfUnit(Iname) 
  Write(*,*) "Diagonalization did not work in routine "//NameOfUnit(Iname) 
  If (ErrorLevel.Eq.2) Call TerminateProgram 
End If 
mass2(i1) = mi2(i1) 
End do 
Do i1=1,4
 If (Abs(mass2(i1)).Le.MaxMassNumericalZero**2) mass2(i1) = 0._dp 
 If (test_m2(i1).Ne.0._dp) Then 
    test_m2(i1) = Abs(test_m2(i1) - mass2(i1)) / test_m2(i1) 
 Else 
    test_m2(i1) = Abs(mass2(i1)) 
 End If 
 If (Abs(mass2(i1)).lt.1.0E-30_dp) test_m2(i1) = 0._dp 
 If (mass2(i1).Ge.0._dp) Then 
    mass(i1) = sqrt(mass2(i1)) 
  Else 
     Write(*,*) 'Warning from routine '//NameOfUnit(Iname) 
     Write(*,*) 'in the calculation of the masses occurred a negative mass squared!' 
     Write(*,*) 'generation: ',i1 
     Write(*,*) 'mass: ',mass2(i1) 
   SignOfMassChanged = .True. 
   mass(i1) = 0._dp 
  End If 
End Do 
 
If (Maxval(test_m2).LT.0.1_dp*delta) Exit 
If (i_count.Gt.30) Then 
  Write(*,*) "Problem in "//NameOfUnit(Iname), test_m2, mass2 
  kont = -510 
  Call AddError(510) 
 Exit 
End If 
End Do 
 
 
Iname = Iname -1 
End Subroutine OneLoopHpm
 
 
Subroutine Pi1LoopHpm(p2,MVWp,MVWp2,MAh,MAh2,MVXp,MVXp2,MHpm,MHpm2,MDpm,              & 
& MDpm2,MFu,MFu2,MFd,MFd2,MFe,MFe2,Mhh,Mhh2,MVZ,MVZ2,MVZp,MVZp2,cplAhcUHpmcVWp,          & 
& cplAhcUHpmcVXp,cplAhHpmcUHpm,cplDpmcUHpmcVWp,cplDpmHpmcUHpm,cplcFuFdcUHpmL,            & 
& cplcFuFdcUHpmR,cplcFv1FecUHpmL,cplcFv1FecUHpmR,cplFeFv1cUHpmL,cplFeFv1cUHpmR,          & 
& cplcgZgWCcUHpm,cplcgWCgZUHpm,cplcgZpgWCcUHpm,cplcgWCgZpUHpm,cplcgZgXp2cUHpm,           & 
& cplcgXp2gZUHpm,cplcgZpgXp2cUHpm,cplcgXp2gZpUHpm,cplcgWpgZcUHpm,cplcgZgWpUHpm,          & 
& cplcgXp1gZcUHpm,cplcgZgXp1UHpm,cplcgWpgZpcUHpm,cplcgZpgWpUHpm,cplcgXp1gZpcUHpm,        & 
& cplcgZpgXp1UHpm,cplhhcUHpmcVWp,cplhhcUHpmcVXp,cplhhHpmcUHpm,cplHpmcUHpmVP,             & 
& cplHpmcUHpmVZ,cplHpmcUHpmVZp,cplcUHpmcVWpVP,cplcUHpmcVXpVP,cplcUHpmcVWpVZ,             & 
& cplcUHpmcVXpVZ,cplcUHpmcVWpVZp,cplcUHpmcVXpVZp,cplcDpmcUHpmcVXp,cplAhAhUHpmcUHpm,      & 
& cplDpmUHpmcDpmcUHpm,cplhhhhUHpmcUHpm,cplUHpmHpmcUHpmcHpm,cplUHpmcUHpmVPVP,             & 
& cplUHpmcUHpmcVWpVWp,cplUHpmcUHpmcVXpVXp,cplUHpmcUHpmVZVZ,cplUHpmcUHpmVZpVZp,kont,res)

Implicit None 
Real(dp), Intent(in) :: MVWp,MVWp2,MAh(3),MAh2(3),MVXp,MVXp2,MHpm(4),MHpm2(4),MDpm(2),MDpm2(2),               & 
& MFu(4),MFu2(4),MFd(5),MFd2(5),MFe(3),MFe2(3),Mhh(3),Mhh2(3),MVZ,MVZ2,MVZp,MVZp2

Complex(dp), Intent(in) :: cplAhcUHpmcVWp(3,4),cplAhcUHpmcVXp(3,4),cplAhHpmcUHpm(3,4,4),cplDpmcUHpmcVWp(2,4),    & 
& cplDpmHpmcUHpm(2,4,4),cplcFuFdcUHpmL(4,5,4),cplcFuFdcUHpmR(4,5,4),cplcFv1FecUHpmL(3,3,4),& 
& cplcFv1FecUHpmR(3,3,4),cplFeFv1cUHpmL(3,3,4),cplFeFv1cUHpmR(3,3,4),cplcgZgWCcUHpm(4),  & 
& cplcgWCgZUHpm(4),cplcgZpgWCcUHpm(4),cplcgWCgZpUHpm(4),cplcgZgXp2cUHpm(4),              & 
& cplcgXp2gZUHpm(4),cplcgZpgXp2cUHpm(4),cplcgXp2gZpUHpm(4),cplcgWpgZcUHpm(4),            & 
& cplcgZgWpUHpm(4),cplcgXp1gZcUHpm(4),cplcgZgXp1UHpm(4),cplcgWpgZpcUHpm(4),              & 
& cplcgZpgWpUHpm(4),cplcgXp1gZpcUHpm(4),cplcgZpgXp1UHpm(4),cplhhcUHpmcVWp(3,4),          & 
& cplhhcUHpmcVXp(3,4),cplhhHpmcUHpm(3,4,4),cplHpmcUHpmVP(4,4),cplHpmcUHpmVZ(4,4),        & 
& cplHpmcUHpmVZp(4,4),cplcUHpmcVWpVP(4),cplcUHpmcVXpVP(4),cplcUHpmcVWpVZ(4),             & 
& cplcUHpmcVXpVZ(4),cplcUHpmcVWpVZp(4),cplcUHpmcVXpVZp(4),cplcDpmcUHpmcVXp(2,4),         & 
& cplAhAhUHpmcUHpm(3,3,4,4),cplDpmUHpmcDpmcUHpm(2,4,2,4),cplhhhhUHpmcUHpm(3,3,4,4),      & 
& cplUHpmHpmcUHpmcHpm(4,4,4,4),cplUHpmcUHpmVPVP(4,4),cplUHpmcUHpmcVWpVWp(4,4),           & 
& cplUHpmcUHpmcVXpVXp(4,4),cplUHpmcUHpmVZVZ(4,4),cplUHpmcUHpmVZpVZp(4,4)

Integer, Intent(inout) :: kont 
Real(dp) :: B0m2, F0m2, G0m2,B1m2, m1, m2 
Real(dp), Intent(in) :: p2 
Complex(dp) :: A0m2 
Complex(dp), Intent(inout) :: res(4,4) 
Complex(dp) :: coupL1, coupR1, coupL2,coupR2, coup1,coup2,temp, sumI(4,4) 
Integer :: i1,i2,i3,i4,j1,j2,j3,j4, gO1, gO2, ierr 
 
 
res = 0._dp 
 
!------------------------ 
! conj[VWp], Ah 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 3
 F0m2 = FloopRXi(p2,MAh2(i2),MVWp2) 
Do gO1 = 1, 4
  Do gO2 = gO1, 4
coup1 = cplAhcUHpmcVWp(i2,gO1)
coup2 =  Conjg(cplAhcUHpmcVWp(i2,gO2))
    SumI(gO1,gO2) = coup1*coup2*F0m2 
   End Do 
End Do 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! conj[VXp], Ah 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 3
 F0m2 = FloopRXi(p2,MAh2(i2),MVXp2) 
Do gO1 = 1, 4
  Do gO2 = gO1, 4
coup1 = cplAhcUHpmcVXp(i2,gO1)
coup2 =  Conjg(cplAhcUHpmcVXp(i2,gO2))
    SumI(gO1,gO2) = coup1*coup2*F0m2 
   End Do 
End Do 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! Hpm, Ah 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
       Do i2 = 1, 3
 B0m2 = Real(SA_B0(p2,MHpm2(i1),MAh2(i2)),dp) 
Do gO1 = 1, 4
  Do gO2 = gO1, 4
coup1 = cplAhHpmcUHpm(i2,i1,gO1)
coup2 = Conjg(cplAhHpmcUHpm(i2,i1,gO2))
    SumI(gO1,gO2) = coup1*coup2*B0m2 
   End Do 
End Do 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! conj[VWp], Dpm 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 2
 F0m2 = FloopRXi(p2,MDpm2(i2),MVWp2) 
Do gO1 = 1, 4
  Do gO2 = gO1, 4
coup1 = cplDpmcUHpmcVWp(i2,gO1)
coup2 =  Conjg(cplDpmcUHpmcVWp(i2,gO2))
    SumI(gO1,gO2) = coup1*coup2*F0m2 
   End Do 
End Do 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! Hpm, Dpm 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
       Do i2 = 1, 2
 B0m2 = Real(SA_B0(p2,MHpm2(i1),MDpm2(i2)),dp) 
Do gO1 = 1, 4
  Do gO2 = gO1, 4
coup1 = cplDpmHpmcUHpm(i2,i1,gO1)
coup2 = Conjg(cplDpmHpmcUHpm(i2,i1,gO2))
    SumI(gO1,gO2) = coup1*coup2*B0m2 
   End Do 
End Do 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[Fu], Fd 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
       Do i2 = 1, 5
 G0m2 = Real(SA_Gloop(p2,MFu2(i1),MFd2(i2)),dp) 
B0m2 = -2._dp*MFu(i1)*MFd(i2)*Real(SA_B0(p2,MFu2(i1),MFd2(i2)),dp) 
Do gO1 = 1, 4
  Do gO2 = gO1, 4
coupL1 = cplcFuFdcUHpmL(i1,i2,gO1)
coupR1 = cplcFuFdcUHpmR(i1,i2,gO1)
coupL2 =  Conjg(cplcFuFdcUHpmL(i1,i2,gO2))
coupR2 =  Conjg(cplcFuFdcUHpmR(i1,i2,gO2))
    SumI(gO1,gO2) = (coupL1*coupL2+coupR1*coupR2)*G0m2 & 
                & + (coupL1*coupR2+coupR1*coupL2)*B0m2 
   End Do 
End Do 
res = res +3._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[Fv1], Fe 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 3
       Do i2 = 1, 3
 G0m2 = Real(SA_Gloop(p2,0._dp,MFe2(i2)),dp) 
B0m2 = -2._dp*0._dp*MFe(i2)*Real(SA_B0(p2,0._dp,MFe2(i2)),dp) 
Do gO1 = 1, 4
  Do gO2 = gO1, 4
coupL1 = cplcFv1FecUHpmL(i1,i2,gO1)
coupR1 = cplcFv1FecUHpmR(i1,i2,gO1)
coupL2 =  Conjg(cplcFv1FecUHpmL(i1,i2,gO2))
coupR2 =  Conjg(cplcFv1FecUHpmR(i1,i2,gO2))
    SumI(gO1,gO2) = (coupL1*coupL2+coupR1*coupR2)*G0m2 & 
                & + (coupL1*coupR2+coupR1*coupL2)*B0m2 
   End Do 
End Do 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! Fv1, Fe 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 3
       Do i2 = 1, 3
 G0m2 = Real(SA_Gloop(p2,0._dp,MFe2(i2)),dp) 
B0m2 = -2._dp*0._dp*MFe(i2)*Real(SA_B0(p2,0._dp,MFe2(i2)),dp) 
Do gO1 = 1, 4
  Do gO2 = gO1, 4
coupL1 = cplFeFv1cUHpmL(i2,i1,gO1)
coupR1 = cplFeFv1cUHpmR(i2,i1,gO1)
coupL2 =  Conjg(cplFeFv1cUHpmL(i2,i1,gO2))
coupR2 =  Conjg(cplFeFv1cUHpmR(i2,i1,gO2))
    SumI(gO1,gO2) = (coupL1*coupL2+coupR1*coupR2)*G0m2 & 
                & + (coupL1*coupR2+coupR1*coupL2)*B0m2 
   End Do 
End Do 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[gZ], gWpC 
!------------------------ 
sumI = 0._dp 
 
F0m2 = -Real(SA_B0(p2,MVWp2*RXi,MVZ2*RXi),dp) 
 Do gO1 = 1, 4
  Do gO2 = gO1, 4
coup1 = cplcgZgWCcUHpm(gO1)
coup2 =  cplcgWCgZUHpm(gO2) 
    SumI(gO1,gO2) = coup1*coup2*F0m2 
   End Do 
End Do 
res = res +1._dp* SumI  
!------------------------ 
! bar[gZp], gWpC 
!------------------------ 
sumI = 0._dp 
 
F0m2 = -Real(SA_B0(p2,MVWp2*RXi,MVZp2*RXi),dp) 
 Do gO1 = 1, 4
  Do gO2 = gO1, 4
coup1 = cplcgZpgWCcUHpm(gO1)
coup2 =  cplcgWCgZpUHpm(gO2) 
    SumI(gO1,gO2) = coup1*coup2*F0m2 
   End Do 
End Do 
res = res +1._dp* SumI  
!------------------------ 
! bar[gZ], gXpC 
!------------------------ 
sumI = 0._dp 
 
F0m2 = -Real(SA_B0(p2,MVXp2*RXi,MVZ2*RXi),dp) 
 Do gO1 = 1, 4
  Do gO2 = gO1, 4
coup1 = cplcgZgXp2cUHpm(gO1)
coup2 =  cplcgXp2gZUHpm(gO2) 
    SumI(gO1,gO2) = coup1*coup2*F0m2 
   End Do 
End Do 
res = res +1._dp* SumI  
!------------------------ 
! bar[gZp], gXpC 
!------------------------ 
sumI = 0._dp 
 
F0m2 = -Real(SA_B0(p2,MVXp2*RXi,MVZp2*RXi),dp) 
 Do gO1 = 1, 4
  Do gO2 = gO1, 4
coup1 = cplcgZpgXp2cUHpm(gO1)
coup2 =  cplcgXp2gZpUHpm(gO2) 
    SumI(gO1,gO2) = coup1*coup2*F0m2 
   End Do 
End Do 
res = res +1._dp* SumI  
!------------------------ 
! bar[gWp], gZ 
!------------------------ 
sumI = 0._dp 
 
F0m2 = -Real(SA_B0(p2,MVZ2*RXi,MVWp2*RXi),dp) 
 Do gO1 = 1, 4
  Do gO2 = gO1, 4
coup1 = cplcgWpgZcUHpm(gO1)
coup2 =  cplcgZgWpUHpm(gO2) 
    SumI(gO1,gO2) = coup1*coup2*F0m2 
   End Do 
End Do 
res = res +1._dp* SumI  
!------------------------ 
! bar[gXp], gZ 
!------------------------ 
sumI = 0._dp 
 
F0m2 = -Real(SA_B0(p2,MVZ2*RXi,MVXp2*RXi),dp) 
 Do gO1 = 1, 4
  Do gO2 = gO1, 4
coup1 = cplcgXp1gZcUHpm(gO1)
coup2 =  cplcgZgXp1UHpm(gO2) 
    SumI(gO1,gO2) = coup1*coup2*F0m2 
   End Do 
End Do 
res = res +1._dp* SumI  
!------------------------ 
! bar[gWp], gZp 
!------------------------ 
sumI = 0._dp 
 
F0m2 = -Real(SA_B0(p2,MVZp2*RXi,MVWp2*RXi),dp) 
 Do gO1 = 1, 4
  Do gO2 = gO1, 4
coup1 = cplcgWpgZpcUHpm(gO1)
coup2 =  cplcgZpgWpUHpm(gO2) 
    SumI(gO1,gO2) = coup1*coup2*F0m2 
   End Do 
End Do 
res = res +1._dp* SumI  
!------------------------ 
! bar[gXp], gZp 
!------------------------ 
sumI = 0._dp 
 
F0m2 = -Real(SA_B0(p2,MVZp2*RXi,MVXp2*RXi),dp) 
 Do gO1 = 1, 4
  Do gO2 = gO1, 4
coup1 = cplcgXp1gZpcUHpm(gO1)
coup2 =  cplcgZpgXp1UHpm(gO2) 
    SumI(gO1,gO2) = coup1*coup2*F0m2 
   End Do 
End Do 
res = res +1._dp* SumI  
!------------------------ 
! conj[VWp], hh 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 3
 F0m2 = FloopRXi(p2,Mhh2(i2),MVWp2) 
Do gO1 = 1, 4
  Do gO2 = gO1, 4
coup1 = cplhhcUHpmcVWp(i2,gO1)
coup2 =  Conjg(cplhhcUHpmcVWp(i2,gO2))
    SumI(gO1,gO2) = coup1*coup2*F0m2 
   End Do 
End Do 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! conj[VXp], hh 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 3
 F0m2 = FloopRXi(p2,Mhh2(i2),MVXp2) 
Do gO1 = 1, 4
  Do gO2 = gO1, 4
coup1 = cplhhcUHpmcVXp(i2,gO1)
coup2 =  Conjg(cplhhcUHpmcVXp(i2,gO2))
    SumI(gO1,gO2) = coup1*coup2*F0m2 
   End Do 
End Do 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! Hpm, hh 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
       Do i2 = 1, 3
 B0m2 = Real(SA_B0(p2,MHpm2(i1),Mhh2(i2)),dp) 
Do gO1 = 1, 4
  Do gO2 = gO1, 4
coup1 = cplhhHpmcUHpm(i2,i1,gO1)
coup2 = Conjg(cplhhHpmcUHpm(i2,i1,gO2))
    SumI(gO1,gO2) = coup1*coup2*B0m2 
   End Do 
End Do 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! VP, Hpm 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 F0m2 = FloopRXi(p2,MHpm2(i2),0._dp) 
Do gO1 = 1, 4
  Do gO2 = gO1, 4
coup1 = cplHpmcUHpmVP(i2,gO1)
coup2 =  Conjg(cplHpmcUHpmVP(i2,gO2))
    SumI(gO1,gO2) = coup1*coup2*F0m2 
   End Do 
End Do 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! VZ, Hpm 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 F0m2 = FloopRXi(p2,MHpm2(i2),MVZ2) 
Do gO1 = 1, 4
  Do gO2 = gO1, 4
coup1 = cplHpmcUHpmVZ(i2,gO1)
coup2 =  Conjg(cplHpmcUHpmVZ(i2,gO2))
    SumI(gO1,gO2) = coup1*coup2*F0m2 
   End Do 
End Do 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! VZp, Hpm 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 F0m2 = FloopRXi(p2,MHpm2(i2),MVZp2) 
Do gO1 = 1, 4
  Do gO2 = gO1, 4
coup1 = cplHpmcUHpmVZp(i2,gO1)
coup2 =  Conjg(cplHpmcUHpmVZp(i2,gO2))
    SumI(gO1,gO2) = coup1*coup2*F0m2 
   End Do 
End Do 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! conj[VWp], VP 
!------------------------ 
sumI = 0._dp 
 
F0m2 = Real(SVVloop(p2,0._dp,MVWp2),dp)   
 Do gO1 = 1, 4
  Do gO2 = gO1, 4
coup1 = cplcUHpmcVWpVP(gO1)
coup2 =  Conjg(cplcUHpmcVWpVP(gO2)) 
    SumI(gO1,gO2) = coup1*coup2*F0m2 
   End Do 
End Do 
res = res +1._dp* SumI  
!------------------------ 
! conj[VXp], VP 
!------------------------ 
sumI = 0._dp 
 
F0m2 = Real(SVVloop(p2,0._dp,MVXp2),dp)   
 Do gO1 = 1, 4
  Do gO2 = gO1, 4
coup1 = cplcUHpmcVXpVP(gO1)
coup2 =  Conjg(cplcUHpmcVXpVP(gO2)) 
    SumI(gO1,gO2) = coup1*coup2*F0m2 
   End Do 
End Do 
res = res +1._dp* SumI  
!------------------------ 
! conj[VWp], VZ 
!------------------------ 
sumI = 0._dp 
 
F0m2 = Real(SVVloop(p2,MVZ2,MVWp2),dp)   
 Do gO1 = 1, 4
  Do gO2 = gO1, 4
coup1 = cplcUHpmcVWpVZ(gO1)
coup2 =  Conjg(cplcUHpmcVWpVZ(gO2)) 
    SumI(gO1,gO2) = coup1*coup2*F0m2 
   End Do 
End Do 
res = res +1._dp* SumI  
!------------------------ 
! conj[VXp], VZ 
!------------------------ 
sumI = 0._dp 
 
F0m2 = Real(SVVloop(p2,MVZ2,MVXp2),dp)   
 Do gO1 = 1, 4
  Do gO2 = gO1, 4
coup1 = cplcUHpmcVXpVZ(gO1)
coup2 =  Conjg(cplcUHpmcVXpVZ(gO2)) 
    SumI(gO1,gO2) = coup1*coup2*F0m2 
   End Do 
End Do 
res = res +1._dp* SumI  
!------------------------ 
! conj[VWp], VZp 
!------------------------ 
sumI = 0._dp 
 
F0m2 = Real(SVVloop(p2,MVZp2,MVWp2),dp)   
 Do gO1 = 1, 4
  Do gO2 = gO1, 4
coup1 = cplcUHpmcVWpVZp(gO1)
coup2 =  Conjg(cplcUHpmcVWpVZp(gO2)) 
    SumI(gO1,gO2) = coup1*coup2*F0m2 
   End Do 
End Do 
res = res +1._dp* SumI  
!------------------------ 
! conj[VXp], VZp 
!------------------------ 
sumI = 0._dp 
 
F0m2 = Real(SVVloop(p2,MVZp2,MVXp2),dp)   
 Do gO1 = 1, 4
  Do gO2 = gO1, 4
coup1 = cplcUHpmcVXpVZp(gO1)
coup2 =  Conjg(cplcUHpmcVXpVZp(gO2)) 
    SumI(gO1,gO2) = coup1*coup2*F0m2 
   End Do 
End Do 
res = res +1._dp* SumI  
!------------------------ 
! conj[VXp], conj[Dpm] 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 2
 F0m2 = FloopRXi(p2,MDpm2(i2),MVXp2) 
Do gO1 = 1, 4
  Do gO2 = gO1, 4
coup1 = cplcDpmcUHpmcVXp(i2,gO1)
coup2 =  Conjg(cplcDpmcUHpmcVXp(i2,gO2))
    SumI(gO1,gO2) = coup1*coup2*F0m2 
   End Do 
End Do 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! Ah, Ah 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 3
 A0m2 = SA_A0(MAh2(i1)) 
Do gO1 = 1, 4
  Do gO2 = gO1, 4
coup1 = cplAhAhUHpmcUHpm(i1,i1,gO2,gO1)
    SumI(gO1,gO2) = -coup1*A0m2 
   End Do 
End Do 
res = res +1._dp/2._dp* SumI  
      End Do 
 !------------------------ 
! conj[Dpm], Dpm 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 2
 A0m2 = SA_A0(MDpm2(i1)) 
Do gO1 = 1, 4
  Do gO2 = gO1, 4
coup1 = cplDpmUHpmcDpmcUHpm(i1,gO2,i1,gO1)
    SumI(gO1,gO2) = -coup1*A0m2 
   End Do 
End Do 
res = res +1._dp* SumI  
      End Do 
 !------------------------ 
! hh, hh 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 3
 A0m2 = SA_A0(Mhh2(i1)) 
Do gO1 = 1, 4
  Do gO2 = gO1, 4
coup1 = cplhhhhUHpmcUHpm(i1,i1,gO2,gO1)
    SumI(gO1,gO2) = -coup1*A0m2 
   End Do 
End Do 
res = res +1._dp/2._dp* SumI  
      End Do 
 !------------------------ 
! conj[Hpm], Hpm 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
 A0m2 = SA_A0(MHpm2(i1)) 
Do gO1 = 1, 4
  Do gO2 = gO1, 4
coup1 = cplUHpmHpmcUHpmcHpm(gO2,i1,gO1,i1)
    SumI(gO1,gO2) = -coup1*A0m2 
   End Do 
End Do 
res = res +1._dp* SumI  
      End Do 
 !------------------------ 
! VP, VP 
!------------------------ 
sumI = 0._dp 
 
!------------------------ 
! conj[VWp], VWp 
!------------------------ 
sumI = 0._dp 
 
A0m2 = 0.75_dp*SA_A0(MVWp2) + 0.25_dp*RXi*SA_A0(MVWp2*RXi) - 0.5_dp*MVWp2*rMS 
Do gO1 = 1, 4
  Do gO2 = gO1, 4
coup1 = cplUHpmcUHpmcVWpVWp(gO2,gO1)
    SumI(gO1,gO2) = coup1*A0m2 
   End Do 
End Do 
res = res +4._dp* SumI  
!------------------------ 
! conj[VXp], VXp 
!------------------------ 
sumI = 0._dp 
 
A0m2 = 0.75_dp*SA_A0(MVXp2) + 0.25_dp*RXi*SA_A0(MVXp2*RXi) - 0.5_dp*MVXp2*rMS 
Do gO1 = 1, 4
  Do gO2 = gO1, 4
coup1 = cplUHpmcUHpmcVXpVXp(gO2,gO1)
    SumI(gO1,gO2) = coup1*A0m2 
   End Do 
End Do 
res = res +4._dp* SumI  
!------------------------ 
! VZ, VZ 
!------------------------ 
sumI = 0._dp 
 
A0m2 = 0.75_dp*SA_A0(MVZ2) + 0.25_dp*RXi*SA_A0(MVZ2*RXi) - 0.5_dp*MVZ2*rMS 
Do gO1 = 1, 4
  Do gO2 = gO1, 4
coup1 = cplUHpmcUHpmVZVZ(gO2,gO1)
    SumI(gO1,gO2) = coup1*A0m2 
   End Do 
End Do 
res = res +2._dp* SumI  
!------------------------ 
! VZp, VZp 
!------------------------ 
sumI = 0._dp 
 
A0m2 = 0.75_dp*SA_A0(MVZp2) + 0.25_dp*RXi*SA_A0(MVZp2*RXi) - 0.5_dp*MVZp2*rMS 
Do gO1 = 1, 4
  Do gO2 = gO1, 4
coup1 = cplUHpmcUHpmVZpVZp(gO2,gO1)
    SumI(gO1,gO2) = coup1*A0m2 
   End Do 
End Do 
res = res +2._dp* SumI  


Do gO2 = 1, 4
  Do gO1 = gO2+1, 4
     res(gO1,gO2) = Conjg(res(gO2,gO1))  
   End Do 
End Do 
 
res = oo16pi2*res 
 
End Subroutine Pi1LoopHpm 
 
Subroutine OneLoopDpm(mu12,mu22,ftri,l1,l12,l13,l12t,l2,l23,Vn,v1,v2,MDpm,            & 
& MDpm2,MAh,MAh2,Mhh,Mhh2,MVZ,MVZ2,MVZp,MVZp2,MFd,MFd2,MFu,MFu2,MHpm,MHpm2,              & 
& MVWp,MVWp2,MVXp,MVXp2,cplAhDpmcUDpm,cplDpmhhcUDpm,cplDpmcUDpmVP,cplDpmcUDpmVZ,         & 
& cplDpmcUDpmVZp,cplcFdFdcUDpmL,cplcFdFdcUDpmR,cplcFuFucUDpmL,cplcFuFucUDpmR,            & 
& cplcgXp1gWpcUDpm,cplcgWpgXp1UDpm,cplcgWCgXp2cUDpm,cplcgXp2gWCUDpm,cplHpmcUDpmcHpm,     & 
& cplHpmcUDpmVWp,cplcUDpmcVXpVWp,cplcUDpmcHpmcVXp,cplAhAhUDpmcUDpm,cplUDpmDpmcUDpmcDpm,  & 
& cplUDpmhhhhcUDpm,cplUDpmHpmcUDpmcHpm,cplUDpmcUDpmVPVP,cplUDpmcUDpmcVWpVWp,             & 
& cplUDpmcUDpmcVXpVXp,cplUDpmcUDpmVZVZ,cplUDpmcUDpmVZpVZp,delta,mass,mass2,RS,kont)

Implicit None 
Real(dp), Intent(in) :: MDpm(2),MDpm2(2),MAh(3),MAh2(3),Mhh(3),Mhh2(3),MVZ,MVZ2,MVZp,MVZp2,MFd(5),            & 
& MFd2(5),MFu(4),MFu2(4),MHpm(4),MHpm2(4),MVWp,MVWp2,MVXp,MVXp2

Real(dp), Intent(in) :: mu12,mu22,ftri,Vn,v1,v2

Complex(dp), Intent(in) :: l1,l12,l13,l12t,l2,l23

Complex(dp), Intent(in) :: cplAhDpmcUDpm(3,2,2),cplDpmhhcUDpm(2,3,2),cplDpmcUDpmVP(2,2),cplDpmcUDpmVZ(2,2),      & 
& cplDpmcUDpmVZp(2,2),cplcFdFdcUDpmL(5,5,2),cplcFdFdcUDpmR(5,5,2),cplcFuFucUDpmL(4,4,2), & 
& cplcFuFucUDpmR(4,4,2),cplcgXp1gWpcUDpm(2),cplcgWpgXp1UDpm(2),cplcgWCgXp2cUDpm(2),      & 
& cplcgXp2gWCUDpm(2),cplHpmcUDpmcHpm(4,2,4),cplHpmcUDpmVWp(4,2),cplcUDpmcVXpVWp(2),      & 
& cplcUDpmcHpmcVXp(2,4),cplAhAhUDpmcUDpm(3,3,2,2),cplUDpmDpmcUDpmcDpm(2,2,2,2),          & 
& cplUDpmhhhhcUDpm(2,3,3,2),cplUDpmHpmcUDpmcHpm(2,4,2,4),cplUDpmcUDpmVPVP(2,2),          & 
& cplUDpmcUDpmcVWpVWp(2,2),cplUDpmcUDpmcVXpVXp(2,2),cplUDpmcUDpmVZVZ(2,2),               & 
& cplUDpmcUDpmVZpVZp(2,2)

Complex(dp) :: mat2a(2,2), mat2(2,2),  PiSf(2,2,2)
Integer , Intent(inout):: kont 
Integer :: i1,i2,i3,i4,j1,j2,j3,j4,il,i_count, ierr 
Real(dp), Intent(in) :: delta 
Real(dp) :: mi2(2), test_m2(2),p2, test(2) 
Real(dp), Intent(out) :: mass(2), mass2(2) 
Complex(dp), Intent(out) ::  RS(2,2) 
Iname = Iname + 1 
NameOfUnit(Iname) = 'OneLoopDpm'
 
mat2a(1,1) = 0._dp 
mat2a(1,1) = mat2a(1,1)-1._dp*(mu12)
mat2a(1,1) = mat2a(1,1)+l1*Vn**2
mat2a(1,1) = mat2a(1,1)+l12*v1**2
mat2a(1,1) = mat2a(1,1)+l12t*v1**2
mat2a(1,1) = mat2a(1,1)+l13*v2**2
mat2a(1,2) = 0._dp 
mat2a(1,2) = mat2a(1,2)+l12t*Vn*v1
mat2a(1,2) = mat2a(1,2)+sqrt(2._dp)*ftri*v2
mat2a(2,2) = 0._dp 
mat2a(2,2) = mat2a(2,2)+mu22
mat2a(2,2) = mat2a(2,2)+l12*Vn**2
mat2a(2,2) = mat2a(2,2)+l12t*Vn**2
mat2a(2,2) = mat2a(2,2)+l2*v1**2
mat2a(2,2) = mat2a(2,2)+l23*v2**2

 
 Do i1=2,2
  Do i2 = 1, i1-1 
  mat2a(i1,i2) = Conjg(mat2a(i2,i1)) 
  End do 
End do 

 
! Rotation matrix for p2=0 
PiSf(1,:,:) = ZeroC 
p2 = 0._dp 
Call Pi1LoopDpm(p2,MDpm,MDpm2,MAh,MAh2,Mhh,Mhh2,MVZ,MVZ2,MVZp,MVZp2,MFd,              & 
& MFd2,MFu,MFu2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,cplAhDpmcUDpm,cplDpmhhcUDpm,            & 
& cplDpmcUDpmVP,cplDpmcUDpmVZ,cplDpmcUDpmVZp,cplcFdFdcUDpmL,cplcFdFdcUDpmR,              & 
& cplcFuFucUDpmL,cplcFuFucUDpmR,cplcgXp1gWpcUDpm,cplcgWpgXp1UDpm,cplcgWCgXp2cUDpm,       & 
& cplcgXp2gWCUDpm,cplHpmcUDpmcHpm,cplHpmcUDpmVWp,cplcUDpmcVXpVWp,cplcUDpmcHpmcVXp,       & 
& cplAhAhUDpmcUDpm,cplUDpmDpmcUDpmcDpm,cplUDpmhhhhcUDpm,cplUDpmHpmcUDpmcHpm,             & 
& cplUDpmcUDpmVPVP,cplUDpmcUDpmcVWpVWp,cplUDpmcUDpmcVXpVXp,cplUDpmcUDpmVZVZ,             & 
& cplUDpmcUDpmVZpVZp,kont,PiSf(1,:,:))

mat2 = mat2a - Real(PiSf(1,:,:),dp) 
Call Chop(mat2) 
Call Eigensystem(mat2,mi2,RS,kont,test) 
zyOS_0 = RS 
 
 
! Now with momenta 
Do i1=1,2
PiSf(i1,:,:) = ZeroC 
p2 = MDpm2(i1)
Call Pi1LoopDpm(p2,MDpm,MDpm2,MAh,MAh2,Mhh,Mhh2,MVZ,MVZ2,MVZp,MVZp2,MFd,              & 
& MFd2,MFu,MFu2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,cplAhDpmcUDpm,cplDpmhhcUDpm,            & 
& cplDpmcUDpmVP,cplDpmcUDpmVZ,cplDpmcUDpmVZp,cplcFdFdcUDpmL,cplcFdFdcUDpmR,              & 
& cplcFuFucUDpmL,cplcFuFucUDpmR,cplcgXp1gWpcUDpm,cplcgWpgXp1UDpm,cplcgWCgXp2cUDpm,       & 
& cplcgXp2gWCUDpm,cplHpmcUDpmcHpm,cplHpmcUDpmVWp,cplcUDpmcVXpVWp,cplcUDpmcHpmcVXp,       & 
& cplAhAhUDpmcUDpm,cplUDpmDpmcUDpmcDpm,cplUDpmhhhhcUDpm,cplUDpmHpmcUDpmcHpm,             & 
& cplUDpmcUDpmVPVP,cplUDpmcUDpmcVWpVWp,cplUDpmcUDpmcVXpVXp,cplUDpmcUDpmVZVZ,             & 
& cplUDpmcUDpmVZpVZp,kont,PiSf(i1,:,:))

End Do 
Do i1=2,1,-1 
mat2 = mat2a - Real(PiSf(i1,:,:),dp) 
Call Chop(mat2) 
Call Eigensystem(mat2,mi2,RS,kont,test) 
If ((kont.Eq.-8).Or.(kont.Eq.-9)) Then 
  Write(ErrCan,*) "Possible numerical problem in "//NameOfUnit(Iname) 
  Write(*,*) "Possible numerical problem in "//NameOfUnit(Iname) 
  If (ErrorLevel.Eq.2) Call TerminateProgram 
  kont = 0 
End If 
If ((kont.Ne.0).And.(ErrorLevel.Ge.0)) Then 
  Write(ErrCan,*) "Diagonalization did not work in routine "//NameOfUnit(Iname) 
  Write(*,*) "Diagonalization did not work in routine "//NameOfUnit(Iname) 
  If (ErrorLevel.Eq.2) Call TerminateProgram 
End If 
mass2(i1) = mi2(i1) 
End do 
 
Do i1=1,2
  If (Abs(mass2(i1)).Le.MaxMassNumericalZero**2) mass2(i1) = 0._dp 
  If (mass2(i1).Ge.0._dp) Then 
    mass(i1) = Sqrt(mass2(i1)) 
  Else 
   If (ErrorLevel.Ge.0) Then 
     Write(*,*) 'Warning from routine '//NameOfUnit(Iname) 
     Write(*,*) 'in the calculation of the masses' 
     Write(*,*) 'occurred a negative mass squared!' 
   Call TerminateProgram 
   End If 
   kont = -301 
   mass(i1) = 0._dp 
  End If 
End Do 
 
i_count = 0 
Do  
i_count = i_count + 1 
test_m2 = mass2 
Do i1=1,2
PiSf(i1,:,:) = ZeroC 
p2 =  mass2(i1) 
Call Pi1LoopDpm(p2,MDpm,MDpm2,MAh,MAh2,Mhh,Mhh2,MVZ,MVZ2,MVZp,MVZp2,MFd,              & 
& MFd2,MFu,MFu2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,cplAhDpmcUDpm,cplDpmhhcUDpm,            & 
& cplDpmcUDpmVP,cplDpmcUDpmVZ,cplDpmcUDpmVZp,cplcFdFdcUDpmL,cplcFdFdcUDpmR,              & 
& cplcFuFucUDpmL,cplcFuFucUDpmR,cplcgXp1gWpcUDpm,cplcgWpgXp1UDpm,cplcgWCgXp2cUDpm,       & 
& cplcgXp2gWCUDpm,cplHpmcUDpmcHpm,cplHpmcUDpmVWp,cplcUDpmcVXpVWp,cplcUDpmcHpmcVXp,       & 
& cplAhAhUDpmcUDpm,cplUDpmDpmcUDpmcDpm,cplUDpmhhhhcUDpm,cplUDpmHpmcUDpmcHpm,             & 
& cplUDpmcUDpmVPVP,cplUDpmcUDpmcVWpVWp,cplUDpmcUDpmcVXpVXp,cplUDpmcUDpmVZVZ,             & 
& cplUDpmcUDpmVZpVZp,kont,PiSf(i1,:,:))

End Do 
Do i1=2,1,-1 
mat2 = mat2a - Real(PiSf(i1,:,:),dp) 
Call Chop(mat2) 
Call Eigensystem(mat2,mi2,RS,kont,test) 
zyOS_p2(i1,:) = RS(i1,:) 
 If ((kont.Eq.-8).Or.(kont.Eq.-9)) Then 
  Write(ErrCan,*) "Possible numerical problem in "//NameOfUnit(Iname) 
  Write(*,*) "Possible numerical problem in "//NameOfUnit(Iname) 
  If (ErrorLevel.Eq.2) Call TerminateProgram 
  kont = 0 
End If 
If ((kont.Ne.0).And.(ErrorLevel.Ge.0)) Then 
  Write(ErrCan,*) "Diagonalization did not work in routine "//NameOfUnit(Iname) 
  Write(*,*) "Diagonalization did not work in routine "//NameOfUnit(Iname) 
  If (ErrorLevel.Eq.2) Call TerminateProgram 
End If 
mass2(i1) = mi2(i1) 
End do 
Do i1=1,2
 If (Abs(mass2(i1)).Le.MaxMassNumericalZero**2) mass2(i1) = 0._dp 
 If (test_m2(i1).Ne.0._dp) Then 
    test_m2(i1) = Abs(test_m2(i1) - mass2(i1)) / test_m2(i1) 
 Else 
    test_m2(i1) = Abs(mass2(i1)) 
 End If 
 If (Abs(mass2(i1)).lt.1.0E-30_dp) test_m2(i1) = 0._dp 
 If (mass2(i1).Ge.0._dp) Then 
    mass(i1) = sqrt(mass2(i1)) 
  Else 
     Write(*,*) 'Warning from routine '//NameOfUnit(Iname) 
     Write(*,*) 'in the calculation of the masses occurred a negative mass squared!' 
     Write(*,*) 'generation: ',i1 
     Write(*,*) 'mass: ',mass2(i1) 
   SignOfMassChanged = .True. 
   mass(i1) = 0._dp 
  End If 
End Do 
 
If (Maxval(test_m2).LT.0.1_dp*delta) Exit 
If (i_count.Gt.30) Then 
  Write(*,*) "Problem in "//NameOfUnit(Iname), test_m2, mass2 
  kont = -510 
  Call AddError(510) 
 Exit 
End If 
End Do 
 
 
Iname = Iname -1 
End Subroutine OneLoopDpm
 
 
Subroutine Pi1LoopDpm(p2,MDpm,MDpm2,MAh,MAh2,Mhh,Mhh2,MVZ,MVZ2,MVZp,MVZp2,            & 
& MFd,MFd2,MFu,MFu2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,cplAhDpmcUDpm,cplDpmhhcUDpm,        & 
& cplDpmcUDpmVP,cplDpmcUDpmVZ,cplDpmcUDpmVZp,cplcFdFdcUDpmL,cplcFdFdcUDpmR,              & 
& cplcFuFucUDpmL,cplcFuFucUDpmR,cplcgXp1gWpcUDpm,cplcgWpgXp1UDpm,cplcgWCgXp2cUDpm,       & 
& cplcgXp2gWCUDpm,cplHpmcUDpmcHpm,cplHpmcUDpmVWp,cplcUDpmcVXpVWp,cplcUDpmcHpmcVXp,       & 
& cplAhAhUDpmcUDpm,cplUDpmDpmcUDpmcDpm,cplUDpmhhhhcUDpm,cplUDpmHpmcUDpmcHpm,             & 
& cplUDpmcUDpmVPVP,cplUDpmcUDpmcVWpVWp,cplUDpmcUDpmcVXpVXp,cplUDpmcUDpmVZVZ,             & 
& cplUDpmcUDpmVZpVZp,kont,res)

Implicit None 
Real(dp), Intent(in) :: MDpm(2),MDpm2(2),MAh(3),MAh2(3),Mhh(3),Mhh2(3),MVZ,MVZ2,MVZp,MVZp2,MFd(5),            & 
& MFd2(5),MFu(4),MFu2(4),MHpm(4),MHpm2(4),MVWp,MVWp2,MVXp,MVXp2

Complex(dp), Intent(in) :: cplAhDpmcUDpm(3,2,2),cplDpmhhcUDpm(2,3,2),cplDpmcUDpmVP(2,2),cplDpmcUDpmVZ(2,2),      & 
& cplDpmcUDpmVZp(2,2),cplcFdFdcUDpmL(5,5,2),cplcFdFdcUDpmR(5,5,2),cplcFuFucUDpmL(4,4,2), & 
& cplcFuFucUDpmR(4,4,2),cplcgXp1gWpcUDpm(2),cplcgWpgXp1UDpm(2),cplcgWCgXp2cUDpm(2),      & 
& cplcgXp2gWCUDpm(2),cplHpmcUDpmcHpm(4,2,4),cplHpmcUDpmVWp(4,2),cplcUDpmcVXpVWp(2),      & 
& cplcUDpmcHpmcVXp(2,4),cplAhAhUDpmcUDpm(3,3,2,2),cplUDpmDpmcUDpmcDpm(2,2,2,2),          & 
& cplUDpmhhhhcUDpm(2,3,3,2),cplUDpmHpmcUDpmcHpm(2,4,2,4),cplUDpmcUDpmVPVP(2,2),          & 
& cplUDpmcUDpmcVWpVWp(2,2),cplUDpmcUDpmcVXpVXp(2,2),cplUDpmcUDpmVZVZ(2,2),               & 
& cplUDpmcUDpmVZpVZp(2,2)

Integer, Intent(inout) :: kont 
Real(dp) :: B0m2, F0m2, G0m2,B1m2, m1, m2 
Real(dp), Intent(in) :: p2 
Complex(dp) :: A0m2 
Complex(dp), Intent(inout) :: res(2,2) 
Complex(dp) :: coupL1, coupR1, coupL2,coupR2, coup1,coup2,temp, sumI(2,2) 
Integer :: i1,i2,i3,i4,j1,j2,j3,j4, gO1, gO2, ierr 
 
 
res = 0._dp 
 
!------------------------ 
! Dpm, Ah 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 2
       Do i2 = 1, 3
 B0m2 = Real(SA_B0(p2,MDpm2(i1),MAh2(i2)),dp) 
Do gO1 = 1, 2
  Do gO2 = gO1, 2
coup1 = cplAhDpmcUDpm(i2,i1,gO1)
coup2 = Conjg(cplAhDpmcUDpm(i2,i1,gO2))
    SumI(gO1,gO2) = coup1*coup2*B0m2 
   End Do 
End Do 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! hh, Dpm 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 3
       Do i2 = 1, 2
 B0m2 = Real(SA_B0(p2,Mhh2(i1),MDpm2(i2)),dp) 
Do gO1 = 1, 2
  Do gO2 = gO1, 2
coup1 = cplDpmhhcUDpm(i2,i1,gO1)
coup2 = Conjg(cplDpmhhcUDpm(i2,i1,gO2))
    SumI(gO1,gO2) = coup1*coup2*B0m2 
   End Do 
End Do 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! VP, Dpm 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 2
 F0m2 = FloopRXi(p2,MDpm2(i2),0._dp) 
Do gO1 = 1, 2
  Do gO2 = gO1, 2
coup1 = cplDpmcUDpmVP(i2,gO1)
coup2 =  Conjg(cplDpmcUDpmVP(i2,gO2))
    SumI(gO1,gO2) = coup1*coup2*F0m2 
   End Do 
End Do 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! VZ, Dpm 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 2
 F0m2 = FloopRXi(p2,MDpm2(i2),MVZ2) 
Do gO1 = 1, 2
  Do gO2 = gO1, 2
coup1 = cplDpmcUDpmVZ(i2,gO1)
coup2 =  Conjg(cplDpmcUDpmVZ(i2,gO2))
    SumI(gO1,gO2) = coup1*coup2*F0m2 
   End Do 
End Do 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! VZp, Dpm 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 2
 F0m2 = FloopRXi(p2,MDpm2(i2),MVZp2) 
Do gO1 = 1, 2
  Do gO2 = gO1, 2
coup1 = cplDpmcUDpmVZp(i2,gO1)
coup2 =  Conjg(cplDpmcUDpmVZp(i2,gO2))
    SumI(gO1,gO2) = coup1*coup2*F0m2 
   End Do 
End Do 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! bar[Fd], Fd 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 5
       Do i2 = 1, 5
 G0m2 = Real(SA_Gloop(p2,MFd2(i1),MFd2(i2)),dp) 
B0m2 = -2._dp*MFd(i1)*MFd(i2)*Real(SA_B0(p2,MFd2(i1),MFd2(i2)),dp) 
Do gO1 = 1, 2
  Do gO2 = gO1, 2
coupL1 = cplcFdFdcUDpmL(i1,i2,gO1)
coupR1 = cplcFdFdcUDpmR(i1,i2,gO1)
coupL2 =  Conjg(cplcFdFdcUDpmL(i1,i2,gO2))
coupR2 =  Conjg(cplcFdFdcUDpmR(i1,i2,gO2))
    SumI(gO1,gO2) = (coupL1*coupL2+coupR1*coupR2)*G0m2 & 
                & + (coupL1*coupR2+coupR1*coupL2)*B0m2 
   End Do 
End Do 
res = res +3._dp/2._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[Fu], Fu 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
       Do i2 = 1, 4
 G0m2 = Real(SA_Gloop(p2,MFu2(i1),MFu2(i2)),dp) 
B0m2 = -2._dp*MFu(i1)*MFu(i2)*Real(SA_B0(p2,MFu2(i1),MFu2(i2)),dp) 
Do gO1 = 1, 2
  Do gO2 = gO1, 2
coupL1 = cplcFuFucUDpmL(i1,i2,gO1)
coupR1 = cplcFuFucUDpmR(i1,i2,gO1)
coupL2 =  Conjg(cplcFuFucUDpmL(i1,i2,gO2))
coupR2 =  Conjg(cplcFuFucUDpmR(i1,i2,gO2))
    SumI(gO1,gO2) = (coupL1*coupL2+coupR1*coupR2)*G0m2 & 
                & + (coupL1*coupR2+coupR1*coupL2)*B0m2 
   End Do 
End Do 
res = res +3._dp/2._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[gXp], gWp 
!------------------------ 
sumI = 0._dp 
 
F0m2 = -Real(SA_B0(p2,MVWp2*RXi,MVXp2*RXi),dp) 
 Do gO1 = 1, 2
  Do gO2 = gO1, 2
coup1 = cplcgXp1gWpcUDpm(gO1)
coup2 =  cplcgWpgXp1UDpm(gO2) 
    SumI(gO1,gO2) = coup1*coup2*F0m2 
   End Do 
End Do 
res = res +1._dp* SumI  
!------------------------ 
! bar[gWpC], gXpC 
!------------------------ 
sumI = 0._dp 
 
F0m2 = -Real(SA_B0(p2,MVXp2*RXi,MVWp2*RXi),dp) 
 Do gO1 = 1, 2
  Do gO2 = gO1, 2
coup1 = cplcgWCgXp2cUDpm(gO1)
coup2 =  cplcgXp2gWCUDpm(gO2) 
    SumI(gO1,gO2) = coup1*coup2*F0m2 
   End Do 
End Do 
res = res +1._dp* SumI  
!------------------------ 
! conj[Hpm], Hpm 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
       Do i2 = 1, 4
 B0m2 = Real(SA_B0(p2,MHpm2(i1),MHpm2(i2)),dp) 
Do gO1 = 1, 2
  Do gO2 = gO1, 2
coup1 = cplHpmcUDpmcHpm(i2,gO1,i1)
coup2 = Conjg(cplHpmcUDpmcHpm(i2,gO2,i1))
    SumI(gO1,gO2) = coup1*coup2*B0m2 
   End Do 
End Do 
res = res +1._dp/2._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! VWp, Hpm 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 F0m2 = FloopRXi(p2,MHpm2(i2),MVWp2) 
Do gO1 = 1, 2
  Do gO2 = gO1, 2
coup1 = cplHpmcUDpmVWp(i2,gO1)
coup2 =  Conjg(cplHpmcUDpmVWp(i2,gO2))
    SumI(gO1,gO2) = coup1*coup2*F0m2 
   End Do 
End Do 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! conj[VXp], VWp 
!------------------------ 
sumI = 0._dp 
 
F0m2 = Real(SVVloop(p2,MVWp2,MVXp2),dp)   
 Do gO1 = 1, 2
  Do gO2 = gO1, 2
coup1 = cplcUDpmcVXpVWp(gO1)
coup2 =  Conjg(cplcUDpmcVXpVWp(gO2)) 
    SumI(gO1,gO2) = coup1*coup2*F0m2 
   End Do 
End Do 
res = res +1._dp* SumI  
!------------------------ 
! conj[VXp], conj[Hpm] 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 F0m2 = FloopRXi(p2,MHpm2(i2),MVXp2) 
Do gO1 = 1, 2
  Do gO2 = gO1, 2
coup1 = cplcUDpmcHpmcVXp(gO1,i2)
coup2 =  Conjg(cplcUDpmcHpmcVXp(gO2,i2))
    SumI(gO1,gO2) = coup1*coup2*F0m2 
   End Do 
End Do 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! Ah, Ah 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 3
 A0m2 = SA_A0(MAh2(i1)) 
Do gO1 = 1, 2
  Do gO2 = gO1, 2
coup1 = cplAhAhUDpmcUDpm(i1,i1,gO2,gO1)
    SumI(gO1,gO2) = -coup1*A0m2 
   End Do 
End Do 
res = res +1._dp/2._dp* SumI  
      End Do 
 !------------------------ 
! conj[Dpm], Dpm 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 2
 A0m2 = SA_A0(MDpm2(i1)) 
Do gO1 = 1, 2
  Do gO2 = gO1, 2
coup1 = cplUDpmDpmcUDpmcDpm(gO2,i1,gO1,i1)
    SumI(gO1,gO2) = -coup1*A0m2 
   End Do 
End Do 
res = res +1._dp* SumI  
      End Do 
 !------------------------ 
! hh, hh 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 3
 A0m2 = SA_A0(Mhh2(i1)) 
Do gO1 = 1, 2
  Do gO2 = gO1, 2
coup1 = cplUDpmhhhhcUDpm(gO2,i1,i1,gO1)
    SumI(gO1,gO2) = -coup1*A0m2 
   End Do 
End Do 
res = res +1._dp/2._dp* SumI  
      End Do 
 !------------------------ 
! conj[Hpm], Hpm 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
 A0m2 = SA_A0(MHpm2(i1)) 
Do gO1 = 1, 2
  Do gO2 = gO1, 2
coup1 = cplUDpmHpmcUDpmcHpm(gO2,i1,gO1,i1)
    SumI(gO1,gO2) = -coup1*A0m2 
   End Do 
End Do 
res = res +1._dp* SumI  
      End Do 
 !------------------------ 
! VP, VP 
!------------------------ 
sumI = 0._dp 
 
!------------------------ 
! conj[VWp], VWp 
!------------------------ 
sumI = 0._dp 
 
A0m2 = 0.75_dp*SA_A0(MVWp2) + 0.25_dp*RXi*SA_A0(MVWp2*RXi) - 0.5_dp*MVWp2*rMS 
Do gO1 = 1, 2
  Do gO2 = gO1, 2
coup1 = cplUDpmcUDpmcVWpVWp(gO2,gO1)
    SumI(gO1,gO2) = coup1*A0m2 
   End Do 
End Do 
res = res +4._dp* SumI  
!------------------------ 
! conj[VXp], VXp 
!------------------------ 
sumI = 0._dp 
 
A0m2 = 0.75_dp*SA_A0(MVXp2) + 0.25_dp*RXi*SA_A0(MVXp2*RXi) - 0.5_dp*MVXp2*rMS 
Do gO1 = 1, 2
  Do gO2 = gO1, 2
coup1 = cplUDpmcUDpmcVXpVXp(gO2,gO1)
    SumI(gO1,gO2) = coup1*A0m2 
   End Do 
End Do 
res = res +4._dp* SumI  
!------------------------ 
! VZ, VZ 
!------------------------ 
sumI = 0._dp 
 
A0m2 = 0.75_dp*SA_A0(MVZ2) + 0.25_dp*RXi*SA_A0(MVZ2*RXi) - 0.5_dp*MVZ2*rMS 
Do gO1 = 1, 2
  Do gO2 = gO1, 2
coup1 = cplUDpmcUDpmVZVZ(gO2,gO1)
    SumI(gO1,gO2) = coup1*A0m2 
   End Do 
End Do 
res = res +2._dp* SumI  
!------------------------ 
! VZp, VZp 
!------------------------ 
sumI = 0._dp 
 
A0m2 = 0.75_dp*SA_A0(MVZp2) + 0.25_dp*RXi*SA_A0(MVZp2*RXi) - 0.5_dp*MVZp2*rMS 
Do gO1 = 1, 2
  Do gO2 = gO1, 2
coup1 = cplUDpmcUDpmVZpVZp(gO2,gO1)
    SumI(gO1,gO2) = coup1*A0m2 
   End Do 
End Do 
res = res +2._dp* SumI  


Do gO2 = 1, 2
  Do gO1 = gO2+1, 2
     res(gO1,gO2) = Conjg(res(gO2,gO1))  
   End Do 
End Do 
 
res = oo16pi2*res 
 
End Subroutine Pi1LoopDpm 
 
Subroutine OneLoopFd(hdp11,hd1,hdtp11,hdt1,hdp1,hd2,hdtp1,hdt2,hd3,hdt3,              & 
& Vn,v1,v2,MFd,MFd2,MAh,MAh2,MDpm,MDpm2,Mhh,Mhh2,MVZ,MVZ2,MVZp,MVZp2,MVWp,               & 
& MVWp2,MFu,MFu2,MVXp,MVXp2,MHpm,MHpm2,cplcUFdFdAhL,cplcUFdFdAhR,cplcUFdFdDpmL,          & 
& cplcUFdFdDpmR,cplcUFdFdhhL,cplcUFdFdhhR,cplcUFdFdVGL,cplcUFdFdVGR,cplcUFdFdVPL,        & 
& cplcUFdFdVPR,cplcUFdFdVZL,cplcUFdFdVZR,cplcUFdFdVZpL,cplcUFdFdVZpR,cplcUFdFucVWpL,     & 
& cplcUFdFucVWpR,cplcUFdFucVXpL,cplcUFdFucVXpR,cplcUFdFuHpmL,cplcUFdFuHpmR,              & 
& delta,MFd_1L,MFd2_1L,Vd_1L,Ud_1L,ierr)

Implicit None 
Real(dp), Intent(in) :: MFd(5),MFd2(5),MAh(3),MAh2(3),MDpm(2),MDpm2(2),Mhh(3),Mhh2(3),MVZ,MVZ2,               & 
& MVZp,MVZp2,MVWp,MVWp2,MFu(4),MFu2(4),MVXp,MVXp2,MHpm(4),MHpm2(4)

Real(dp), Intent(in) :: Vn,v1,v2

Complex(dp), Intent(in) :: hdp11(3),hd1(3),hdtp11(2),hdt1(2),hdp1(3),hd2(3),hdtp1(2),hdt2(2),hd3(3),hdt3(2)

Complex(dp), Intent(in) :: cplcUFdFdAhL(5,5,3),cplcUFdFdAhR(5,5,3),cplcUFdFdDpmL(5,5,2),cplcUFdFdDpmR(5,5,2),    & 
& cplcUFdFdhhL(5,5,3),cplcUFdFdhhR(5,5,3),cplcUFdFdVGL(5,5),cplcUFdFdVGR(5,5),           & 
& cplcUFdFdVPL(5,5),cplcUFdFdVPR(5,5),cplcUFdFdVZL(5,5),cplcUFdFdVZR(5,5),               & 
& cplcUFdFdVZpL(5,5),cplcUFdFdVZpR(5,5),cplcUFdFucVWpL(5,4),cplcUFdFucVWpR(5,4),         & 
& cplcUFdFucVXpL(5,4),cplcUFdFucVXpR(5,4),cplcUFdFuHpmL(5,4,4),cplcUFdFuHpmR(5,4,4)

Complex(dp) :: mat1a(5,5), mat1(5,5) 
Integer , Intent(inout):: ierr 
Integer :: i1,i2,i3,i4,j1,j2,j3,j4,il,i_count 
Real(dp), Intent(in) :: delta 
Real(dp) :: mi2(5), test_m2(5), p2 
Real(dp), Intent(out) :: MFd_1L(5),MFd2_1L(5) 
 Complex(dp), Intent(out) :: Vd_1L(5,5), Ud_1L(5,5) 
 
 Real(dp) :: MFd_t(5),MFd2_t(5) 
 Complex(dp) :: Vd_t(5,5), Ud_t(5,5), sigL(5,5), sigR(5,5), sigSL(5,5), sigSR(5,5) 
 
 Complex(dp) :: mat(5,5)=0._dp, mat2(5,5)=0._dp, phaseM 

Complex(dp) :: Vd2(5,5), Ud2(5,5) 
 
 Real(dp) :: Vd1(5,5), Ud1(5,5), test(2) 
 
 Iname = Iname + 1 
NameOfUnit(Iname) = 'OneLoopMFd'
 
mat1a(1,1) = 0._dp 
mat1a(1,1) = mat1a(1,1)+v1*hd1(1)
mat1a(1,2) = 0._dp 
mat1a(1,2) = mat1a(1,2)+v1*hd1(2)
mat1a(1,3) = 0._dp 
mat1a(1,3) = mat1a(1,3)+v1*hd1(3)
mat1a(1,4) = 0._dp 
mat1a(1,4) = mat1a(1,4)+v1*hdt1(1)
mat1a(1,5) = 0._dp 
mat1a(1,5) = mat1a(1,5)+v1*hdt1(2)
mat1a(2,1) = 0._dp 
mat1a(2,1) = mat1a(2,1)+v1*hd2(1)
mat1a(2,2) = 0._dp 
mat1a(2,2) = mat1a(2,2)+v1*hd2(2)
mat1a(2,3) = 0._dp 
mat1a(2,3) = mat1a(2,3)+v1*hd2(3)
mat1a(2,4) = 0._dp 
mat1a(2,4) = mat1a(2,4)+v1*hdt2(1)
mat1a(2,5) = 0._dp 
mat1a(2,5) = mat1a(2,5)+v1*hdt2(2)
mat1a(3,1) = 0._dp 
mat1a(3,1) = mat1a(3,1)+v2*hd3(1)
mat1a(3,2) = 0._dp 
mat1a(3,2) = mat1a(3,2)+v2*hd3(2)
mat1a(3,3) = 0._dp 
mat1a(3,3) = mat1a(3,3)+v2*hd3(3)
mat1a(3,4) = 0._dp 
mat1a(3,4) = mat1a(3,4)+v2*hdt3(1)
mat1a(3,5) = 0._dp 
mat1a(3,5) = mat1a(3,5)+v2*hdt3(2)
mat1a(4,1) = 0._dp 
mat1a(4,1) = mat1a(4,1)+Vn*hdp11(1)
mat1a(4,2) = 0._dp 
mat1a(4,2) = mat1a(4,2)+Vn*hdp11(2)
mat1a(4,3) = 0._dp 
mat1a(4,3) = mat1a(4,3)+Vn*hdp11(3)
mat1a(4,4) = 0._dp 
mat1a(4,4) = mat1a(4,4)+Vn*hdtp11(1)
mat1a(4,5) = 0._dp 
mat1a(4,5) = mat1a(4,5)+Vn*hdtp11(2)
mat1a(5,1) = 0._dp 
mat1a(5,1) = mat1a(5,1)+Vn*hdp1(1)
mat1a(5,2) = 0._dp 
mat1a(5,2) = mat1a(5,2)+Vn*hdp1(2)
mat1a(5,3) = 0._dp 
mat1a(5,3) = mat1a(5,3)+Vn*hdp1(3)
mat1a(5,4) = 0._dp 
mat1a(5,4) = mat1a(5,4)+Vn*hdtp1(1)
mat1a(5,5) = 0._dp 
mat1a(5,5) = mat1a(5,5)+Vn*hdtp1(2)

 
 !---------------------------------------- 
! Rotation matrix for p2=0 
!----------------------------------------- 
 
sigL=0._dp 
sigR=0._dp 
sigSL=0._dp 
sigSR=0._dp 
p2 = 0._dp 
Call Sigma1LoopFd(p2,MFd,MFd2,MAh,MAh2,MDpm,MDpm2,Mhh,Mhh2,MVZ,MVZ2,MVZp,             & 
& MVZp2,MVWp,MVWp2,MFu,MFu2,MVXp,MVXp2,MHpm,MHpm2,cplcUFdFdAhL,cplcUFdFdAhR,             & 
& cplcUFdFdDpmL,cplcUFdFdDpmR,cplcUFdFdhhL,cplcUFdFdhhR,cplcUFdFdVGL,cplcUFdFdVGR,       & 
& cplcUFdFdVPL,cplcUFdFdVPR,cplcUFdFdVZL,cplcUFdFdVZR,cplcUFdFdVZpL,cplcUFdFdVZpR,       & 
& cplcUFdFucVWpL,cplcUFdFucVWpR,cplcUFdFucVXpL,cplcUFdFucVXpR,cplcUFdFuHpmL,             & 
& cplcUFdFuHpmR,sigL,sigR,sigSL,sigSR)

mat1 = mat1a - SigSL - 0.5_dp*(MatMul(SigR,mat1a) + MatMul(mat1a,SigL)) 
 
mat2 = Matmul(Transpose(Conjg(mat1)),mat1) 
If (ForceRealMatrices) mat2 = Real(mat2,dp) 
If (Maxval(Abs(Aimag(mat2))).Eq.0._dp) Then 
Call EigenSystem(Real(mat2,dp),MFd2_t,Ud1,ierr,test) 
Ud2 = Ud1 
Else 
Call EigenSystem(mat2,MFd2_t,Ud2,ierr,test) 
 End If 
 
UdOS_0 = Ud2 
 mat2 = Matmul(mat1,Transpose(Conjg(mat1))) 
If (ForceRealMatrices) mat2 = Real(mat2,dp) 
If (Maxval(Abs(Aimag(mat2))).Eq.0._dp) Then 
Call EigenSystem(Real(mat2,dp),MFd2_t,Vd1,ierr,test) 
 
 
Vd2 = Vd1 
Else 
Call EigenSystem(mat2,MFd2_t,Vd2,ierr,test) 
 
 
End If 
Vd2 = Conjg(Vd2) 
VdOS_0 = Vd2 
 
!---------------------------------------- 
! Now, with momenta
!----------------------------------------- 
 
Do il=5,1,-1
sigL=0._dp 
sigR=0._dp 
sigSL=0._dp 
sigSR=0._dp 
p2 = MFd2(il) 
Call Sigma1LoopFd(p2,MFd,MFd2,MAh,MAh2,MDpm,MDpm2,Mhh,Mhh2,MVZ,MVZ2,MVZp,             & 
& MVZp2,MVWp,MVWp2,MFu,MFu2,MVXp,MVXp2,MHpm,MHpm2,cplcUFdFdAhL,cplcUFdFdAhR,             & 
& cplcUFdFdDpmL,cplcUFdFdDpmR,cplcUFdFdhhL,cplcUFdFdhhR,cplcUFdFdVGL,cplcUFdFdVGR,       & 
& cplcUFdFdVPL,cplcUFdFdVPR,cplcUFdFdVZL,cplcUFdFdVZR,cplcUFdFdVZpL,cplcUFdFdVZpR,       & 
& cplcUFdFucVWpL,cplcUFdFucVWpR,cplcUFdFucVXpL,cplcUFdFucVXpR,cplcUFdFuHpmL,             & 
& cplcUFdFuHpmR,sigL,sigR,sigSL,sigSR)

mat1 = mat1a - SigSL - 0.5_dp*(MatMul(SigR,mat1a) + MatMul(mat1a,SigL)) 
 
mat2 = Matmul(Transpose(Conjg(mat1)),mat1) 
If (ForceRealMatrices) mat2 = Real(mat2,dp) 
If (Maxval(Abs(Aimag(mat2))).Eq.0._dp) Then 
Call EigenSystem(Real(mat2,dp),MFd2_t,Ud1,ierr,test) 
Ud2 = Ud1 
Else 
Call EigenSystem(mat2,MFd2_t,Ud2,ierr,test) 
 End If 
 
If ((ierr.Eq.-8).Or.(ierr.Eq.-9)) Then 
  Write(ErrCan,*) "Possible numerical problem in "//NameOfUnit(Iname) 
  Write(*,*) "Possible numerical problem in "//NameOfUnit(Iname) 
  If (ErrorLevel.Eq.2) Call TerminateProgram 
  ierr = 0 
End If 
 
!---------------------------------------- 
! Redoing Calculation using redefined p2 
!----------------------------------------- 
 
i_count = 0 
p2_loop: Do  
i_count = i_count + 1 
sigL=0._dp 
sigR=0._dp 
sigSL=0._dp 
sigSR=0._dp 
p2 = MFd2_t(iL)
Call Sigma1LoopFd(p2,MFd,MFd2,MAh,MAh2,MDpm,MDpm2,Mhh,Mhh2,MVZ,MVZ2,MVZp,             & 
& MVZp2,MVWp,MVWp2,MFu,MFu2,MVXp,MVXp2,MHpm,MHpm2,cplcUFdFdAhL,cplcUFdFdAhR,             & 
& cplcUFdFdDpmL,cplcUFdFdDpmR,cplcUFdFdhhL,cplcUFdFdhhR,cplcUFdFdVGL,cplcUFdFdVGR,       & 
& cplcUFdFdVPL,cplcUFdFdVPR,cplcUFdFdVZL,cplcUFdFdVZR,cplcUFdFdVZpL,cplcUFdFdVZpR,       & 
& cplcUFdFucVWpL,cplcUFdFucVWpR,cplcUFdFucVXpL,cplcUFdFucVXpR,cplcUFdFuHpmL,             & 
& cplcUFdFuHpmR,sigL,sigR,sigSL,sigSR)

mat1 = mat1a - SigSL - 0.5_dp*(MatMul(SigR,mat1a) + MatMul(mat1a,SigL)) 
 
mat2 = Matmul(Transpose(Conjg(mat1)),mat1) 
If (ForceRealMatrices) mat2 = Real(mat2,dp) 
If (Maxval(Abs(Aimag(mat2))).Eq.0._dp) Then 
Call EigenSystem(Real(mat2,dp),MFd2_t,Ud1,ierr,test) 
Ud2 = Ud1 
Else 
Call EigenSystem(mat2,MFd2_t,Ud2,ierr,test) 
 End If 
 
If ((ierr.Eq.-8).Or.(ierr.Eq.-9)) Then 
  Write(ErrCan,*) "Possible numerical problem in "//NameOfUnit(Iname) 
  Write(*,*) "Possible numerical problem in "//NameOfUnit(Iname) 
  If (ErrorLevel.Eq.2) Call TerminateProgram 
  ierr = 0 
End If 
 
MFd2_1L(il) = MFd2_t(il) 
MFd_1L(il) = Sqrt(MFd2_1L(il)) 
 
If (p2.Ne.0._dp) Then 
  test(1) = Abs(MFd2_1L(il)-p2)/p2
Else 
  test(2) = Abs(MFd2_1L(il))
End If 
If (Abs(MFd2_1L(il)).lt.1.0E-30_dp) Exit p2_loop 
If (test(1).lt.0.1_dp*delta) Exit p2_loop 
If(i_count.gt.30) then 
  Write(ErrCan,*) "Possible numerical problem in "//NameOfUnit(Iname) 
  Exit p2_loop 
End if
End Do p2_loop 
mat2 = Matmul(mat1,Transpose(Conjg(mat1))) 
If (ForceRealMatrices) mat2 = Real(mat2,dp) 
If (Maxval(Abs(Aimag(mat2))).Eq.0._dp) Then 
Call EigenSystem(Real(mat2,dp),MFd2_t,Vd1,ierr,test) 
 
 
Vd2 = Vd1 
Else 
Call EigenSystem(mat2,MFd2_t,Vd2,ierr,test) 
 
 
End If 
Vd2 = Conjg(Vd2) 
 
If ((ierr.Eq.-8).Or.(ierr.Eq.-9)) Then 
  Write(ErrCan,*) "Possible numerical problem in "//NameOfUnit(Iname) 
  Write(*,*) "Possible numerical problem in "//NameOfUnit(Iname) 
  If (ErrorLevel.Eq.2) Call TerminateProgram 
  ierr = 0 
End If 
 
mat2 = Matmul(Matmul( Conjg(Vd2),mat1),Transpose( Conjg(Ud2))) 
Do i1=1,5
If (Abs(mat2(i1,i1)).gt.0._dp) Then 
phaseM = mat2(i1,i1) / Abs(mat2(i1,i1)) 
Ud2(i1,:) = phaseM *Ud2(i1,:) 
 End if 
End Do 
 
VdOS_p2(il,:) = Vd2(il,:) 
 UdOS_p2(il,:) = Ud2(il,:) 
 Vd_1L = Vd2 
 Ud_1L = Ud2 
 End Do  
 
Iname = Iname -1 
End Subroutine OneLoopFd
 
 
Subroutine Sigma1LoopFd(p2,MFd,MFd2,MAh,MAh2,MDpm,MDpm2,Mhh,Mhh2,MVZ,MVZ2,            & 
& MVZp,MVZp2,MVWp,MVWp2,MFu,MFu2,MVXp,MVXp2,MHpm,MHpm2,cplcUFdFdAhL,cplcUFdFdAhR,        & 
& cplcUFdFdDpmL,cplcUFdFdDpmR,cplcUFdFdhhL,cplcUFdFdhhR,cplcUFdFdVGL,cplcUFdFdVGR,       & 
& cplcUFdFdVPL,cplcUFdFdVPR,cplcUFdFdVZL,cplcUFdFdVZR,cplcUFdFdVZpL,cplcUFdFdVZpR,       & 
& cplcUFdFucVWpL,cplcUFdFucVWpR,cplcUFdFucVXpL,cplcUFdFucVXpR,cplcUFdFuHpmL,             & 
& cplcUFdFuHpmR,sigL,sigR,sigSL,sigSR)

Implicit None 
Real(dp), Intent(in) :: MFd(5),MFd2(5),MAh(3),MAh2(3),MDpm(2),MDpm2(2),Mhh(3),Mhh2(3),MVZ,MVZ2,               & 
& MVZp,MVZp2,MVWp,MVWp2,MFu(4),MFu2(4),MVXp,MVXp2,MHpm(4),MHpm2(4)

Complex(dp), Intent(in) :: cplcUFdFdAhL(5,5,3),cplcUFdFdAhR(5,5,3),cplcUFdFdDpmL(5,5,2),cplcUFdFdDpmR(5,5,2),    & 
& cplcUFdFdhhL(5,5,3),cplcUFdFdhhR(5,5,3),cplcUFdFdVGL(5,5),cplcUFdFdVGR(5,5),           & 
& cplcUFdFdVPL(5,5),cplcUFdFdVPR(5,5),cplcUFdFdVZL(5,5),cplcUFdFdVZR(5,5),               & 
& cplcUFdFdVZpL(5,5),cplcUFdFdVZpR(5,5),cplcUFdFucVWpL(5,4),cplcUFdFucVWpR(5,4),         & 
& cplcUFdFucVXpL(5,4),cplcUFdFucVXpR(5,4),cplcUFdFuHpmL(5,4,4),cplcUFdFuHpmR(5,4,4)

Complex(dp), Intent(out) :: SigL(5,5),SigR(5,5), SigSL(5,5), SigSR(5,5) 
Complex(dp) :: coupL1, coupR1, coupL2,coupR2, coup1,coup2,temp, sumL(5,5), sumR(5,5), sumSL(5,5), sumSR(5,5) 
Real(dp) :: B0m2, F0m2, G0m2,B1m2, m1, m2 
Real(dp), Intent(in) :: p2 
Complex(dp) :: A0m2 
Integer :: i1,i2,i3,i4, gO1, gO2, ierr 
 
 
SigL = Cmplx(0._dp,0._dp,dp) 
SigR = Cmplx(0._dp,0._dp,dp) 
SigSL = Cmplx(0._dp,0._dp,dp) 
 SigSR = Cmplx(0._dp,0._dp,dp) 
 
!------------------------ 
! Fd, Ah 
!------------------------ 
    Do i1 = 1, 5
       Do i2 = 1, 3
 SumSL = 0._dp 
SumSR = 0._dp 
sumR = 0._dp 
sumL = 0._dp 
Do gO1 = 1, 5
  Do gO2 = 1, 5
B1m2 = -Real(SA_B1(p2,MFd2(i1),MAh2(i2)),dp) 
B0m2 = MFd(i1)*Real(SA_B0(p2,MFd2(i1),MAh2(i2)),dp) 
coupL1 = cplcUFdFdAhL(gO1,i1,i2)
coupR1 = cplcUFdFdAhR(gO1,i1,i2)
coupL2 =  Conjg(cplcUFdFdAhL(gO2,i1,i2))
coupR2 =  Conjg(cplcUFdFdAhR(gO2,i1,i2))
SumSL(gO1,gO2) = coupR1*coupL2*B0m2 
SumSR(gO1,gO2) = coupL1*coupR2*B0m2 
sumR(gO1,gO2) = coupR1*coupR2*B1m2 
sumL(gO1,gO2) = coupL1*coupL2*B1m2 
   End Do 
End Do 
SigL = SigL +1._dp* sumL
SigR = SigR +1._dp* sumR 
SigSL = SigSL +1._dp* sumSL 
SigSR = SigSR +1._dp* sumSR 
      End Do 
     End Do 
 !------------------------ 
! Fd, Dpm 
!------------------------ 
    Do i1 = 1, 5
       Do i2 = 1, 2
 SumSL = 0._dp 
SumSR = 0._dp 
sumR = 0._dp 
sumL = 0._dp 
Do gO1 = 1, 5
  Do gO2 = 1, 5
B1m2 = -Real(SA_B1(p2,MFd2(i1),MDpm2(i2)),dp) 
B0m2 = MFd(i1)*Real(SA_B0(p2,MFd2(i1),MDpm2(i2)),dp) 
coupL1 = cplcUFdFdDpmL(gO1,i1,i2)
coupR1 = cplcUFdFdDpmR(gO1,i1,i2)
coupL2 =  Conjg(cplcUFdFdDpmL(gO2,i1,i2))
coupR2 =  Conjg(cplcUFdFdDpmR(gO2,i1,i2))
SumSL(gO1,gO2) = coupR1*coupL2*B0m2 
SumSR(gO1,gO2) = coupL1*coupR2*B0m2 
sumR(gO1,gO2) = coupR1*coupR2*B1m2 
sumL(gO1,gO2) = coupL1*coupL2*B1m2 
   End Do 
End Do 
SigL = SigL +1._dp* sumL
SigR = SigR +1._dp* sumR 
SigSL = SigSL +1._dp* sumSL 
SigSR = SigSR +1._dp* sumSR 
      End Do 
     End Do 
 !------------------------ 
! hh, Fd 
!------------------------ 
    Do i1 = 1, 3
       Do i2 = 1, 5
 SumSL = 0._dp 
SumSR = 0._dp 
sumR = 0._dp 
sumL = 0._dp 
Do gO1 = 1, 5
  Do gO2 = 1, 5
B1m2 = -Real(SA_B1(p2,MFd2(i2),Mhh2(i1)),dp) 
B0m2 = MFd(i2)*Real(SA_B0(p2,MFd2(i2),Mhh2(i1)),dp) 
coupL1 = cplcUFdFdhhL(gO1,i2,i1)
coupR1 = cplcUFdFdhhR(gO1,i2,i1)
coupL2 =  Conjg(cplcUFdFdhhL(gO2,i2,i1))
coupR2 =  Conjg(cplcUFdFdhhR(gO2,i2,i1))
SumSL(gO1,gO2) = coupR1*coupL2*B0m2 
SumSR(gO1,gO2) = coupL1*coupR2*B0m2 
sumR(gO1,gO2) = coupR1*coupR2*B1m2 
sumL(gO1,gO2) = coupL1*coupL2*B1m2 
   End Do 
End Do 
SigL = SigL +1._dp* sumL
SigR = SigR +1._dp* sumR 
SigSL = SigSL +1._dp* sumSL 
SigSR = SigSR +1._dp* sumSR 
      End Do 
     End Do 
 !------------------------ 
! VG, Fd 
!------------------------ 
      Do i2 = 1, 5
 SumSL = 0._dp 
SumSR = 0._dp 
sumR = 0._dp 
sumL = 0._dp 
Do gO1 = 1, 5
  Do gO2 = 1, 5
B1m2 = -2._dp*Real(SA_B1(p2,MFd2(i2),0._dp)+ 0.5_dp*rMS,dp) 
B0m2 = -4._dp*MFd(i2)*Real(SA_B0(p2,MFd2(i2),0._dp)-0.5_dp*rMS,dp) 
coupL1 = cplcUFdFdVGL(gO1,i2)
coupR1 = cplcUFdFdVGR(gO1,i2)
coupL2 =  Conjg(cplcUFdFdVGL(gO2,i2))
coupR2 =  Conjg(cplcUFdFdVGR(gO2,i2))
SumSL(gO1,gO2) = coupL1*coupR2*B0m2 
SumSR(gO1,gO2) = coupR1*coupL2*B0m2 
sumR(gO1,gO2) = coupL1*coupL2*B1m2 
sumL(gO1,gO2) = coupR1*coupR2*B1m2 
   End Do 
End Do 
SigL = SigL +4._dp/3._dp* sumL
SigR = SigR +4._dp/3._dp* sumR 
SigSL = SigSL +4._dp/3._dp* sumSL 
SigSR = SigSR +4._dp/3._dp* sumSR 
    End Do 
 !------------------------ 
! VP, Fd 
!------------------------ 
      Do i2 = 1, 5
 SumSL = 0._dp 
SumSR = 0._dp 
sumR = 0._dp 
sumL = 0._dp 
Do gO1 = 1, 5
  Do gO2 = 1, 5
B1m2 = -2._dp*Real(SA_B1(p2,MFd2(i2),0._dp)+ 0.5_dp*rMS,dp) 
B0m2 = -4._dp*MFd(i2)*Real(SA_B0(p2,MFd2(i2),0._dp)-0.5_dp*rMS,dp) 
coupL1 = cplcUFdFdVPL(gO1,i2)
coupR1 = cplcUFdFdVPR(gO1,i2)
coupL2 =  Conjg(cplcUFdFdVPL(gO2,i2))
coupR2 =  Conjg(cplcUFdFdVPR(gO2,i2))
SumSL(gO1,gO2) = coupL1*coupR2*B0m2 
SumSR(gO1,gO2) = coupR1*coupL2*B0m2 
sumR(gO1,gO2) = coupL1*coupL2*B1m2 
sumL(gO1,gO2) = coupR1*coupR2*B1m2 
   End Do 
End Do 
SigL = SigL +1._dp* sumL
SigR = SigR +1._dp* sumR 
SigSL = SigSL +1._dp* sumSL 
SigSR = SigSR +1._dp* sumSR 
    End Do 
 !------------------------ 
! VZ, Fd 
!------------------------ 
      Do i2 = 1, 5
 SumSL = 0._dp 
SumSR = 0._dp 
sumR = 0._dp 
sumL = 0._dp 
Do gO1 = 1, 5
  Do gO2 = 1, 5
B1m2 = -2._dp*Real(SA_B1(p2,MFd2(i2),MVZ2)+ 0.5_dp*rMS,dp) 
B0m2 = -4._dp*MFd(i2)*Real(SA_B0(p2,MFd2(i2),MVZ2)-0.5_dp*rMS,dp) 
coupL1 = cplcUFdFdVZL(gO1,i2)
coupR1 = cplcUFdFdVZR(gO1,i2)
coupL2 =  Conjg(cplcUFdFdVZL(gO2,i2))
coupR2 =  Conjg(cplcUFdFdVZR(gO2,i2))
SumSL(gO1,gO2) = coupL1*coupR2*B0m2 
SumSR(gO1,gO2) = coupR1*coupL2*B0m2 
sumR(gO1,gO2) = coupL1*coupL2*B1m2 
sumL(gO1,gO2) = coupR1*coupR2*B1m2 
   End Do 
End Do 
SigL = SigL +1._dp* sumL
SigR = SigR +1._dp* sumR 
SigSL = SigSL +1._dp* sumSL 
SigSR = SigSR +1._dp* sumSR 
    End Do 
 !------------------------ 
! VZp, Fd 
!------------------------ 
      Do i2 = 1, 5
 SumSL = 0._dp 
SumSR = 0._dp 
sumR = 0._dp 
sumL = 0._dp 
Do gO1 = 1, 5
  Do gO2 = 1, 5
B1m2 = -2._dp*Real(SA_B1(p2,MFd2(i2),MVZp2)+ 0.5_dp*rMS,dp) 
B0m2 = -4._dp*MFd(i2)*Real(SA_B0(p2,MFd2(i2),MVZp2)-0.5_dp*rMS,dp) 
coupL1 = cplcUFdFdVZpL(gO1,i2)
coupR1 = cplcUFdFdVZpR(gO1,i2)
coupL2 =  Conjg(cplcUFdFdVZpL(gO2,i2))
coupR2 =  Conjg(cplcUFdFdVZpR(gO2,i2))
SumSL(gO1,gO2) = coupL1*coupR2*B0m2 
SumSR(gO1,gO2) = coupR1*coupL2*B0m2 
sumR(gO1,gO2) = coupL1*coupL2*B1m2 
sumL(gO1,gO2) = coupR1*coupR2*B1m2 
   End Do 
End Do 
SigL = SigL +1._dp* sumL
SigR = SigR +1._dp* sumR 
SigSL = SigSL +1._dp* sumSL 
SigSR = SigSR +1._dp* sumSR 
    End Do 
 !------------------------ 
! conj[VWp], Fu 
!------------------------ 
      Do i2 = 1, 4
 SumSL = 0._dp 
SumSR = 0._dp 
sumR = 0._dp 
sumL = 0._dp 
Do gO1 = 1, 5
  Do gO2 = 1, 5
B1m2 = -2._dp*Real(SA_B1(p2,MFu2(i2),MVWp2)+ 0.5_dp*rMS,dp) 
B0m2 = -4._dp*MFu(i2)*Real(SA_B0(p2,MFu2(i2),MVWp2)-0.5_dp*rMS,dp) 
coupL1 = cplcUFdFucVWpL(gO1,i2)
coupR1 = cplcUFdFucVWpR(gO1,i2)
coupL2 =  Conjg(cplcUFdFucVWpL(gO2,i2))
coupR2 =  Conjg(cplcUFdFucVWpR(gO2,i2))
SumSL(gO1,gO2) = coupL1*coupR2*B0m2 
SumSR(gO1,gO2) = coupR1*coupL2*B0m2 
sumR(gO1,gO2) = coupL1*coupL2*B1m2 
sumL(gO1,gO2) = coupR1*coupR2*B1m2 
   End Do 
End Do 
SigL = SigL +1._dp* sumL
SigR = SigR +1._dp* sumR 
SigSL = SigSL +1._dp* sumSL 
SigSR = SigSR +1._dp* sumSR 
    End Do 
 !------------------------ 
! conj[VXp], Fu 
!------------------------ 
      Do i2 = 1, 4
 SumSL = 0._dp 
SumSR = 0._dp 
sumR = 0._dp 
sumL = 0._dp 
Do gO1 = 1, 5
  Do gO2 = 1, 5
B1m2 = -2._dp*Real(SA_B1(p2,MFu2(i2),MVXp2)+ 0.5_dp*rMS,dp) 
B0m2 = -4._dp*MFu(i2)*Real(SA_B0(p2,MFu2(i2),MVXp2)-0.5_dp*rMS,dp) 
coupL1 = cplcUFdFucVXpL(gO1,i2)
coupR1 = cplcUFdFucVXpR(gO1,i2)
coupL2 =  Conjg(cplcUFdFucVXpL(gO2,i2))
coupR2 =  Conjg(cplcUFdFucVXpR(gO2,i2))
SumSL(gO1,gO2) = coupL1*coupR2*B0m2 
SumSR(gO1,gO2) = coupR1*coupL2*B0m2 
sumR(gO1,gO2) = coupL1*coupL2*B1m2 
sumL(gO1,gO2) = coupR1*coupR2*B1m2 
   End Do 
End Do 
SigL = SigL +1._dp* sumL
SigR = SigR +1._dp* sumR 
SigSL = SigSL +1._dp* sumSL 
SigSR = SigSR +1._dp* sumSR 
    End Do 
 !------------------------ 
! Hpm, Fu 
!------------------------ 
    Do i1 = 1, 4
       Do i2 = 1, 4
 SumSL = 0._dp 
SumSR = 0._dp 
sumR = 0._dp 
sumL = 0._dp 
Do gO1 = 1, 5
  Do gO2 = 1, 5
B1m2 = -Real(SA_B1(p2,MFu2(i2),MHpm2(i1)),dp) 
B0m2 = MFu(i2)*Real(SA_B0(p2,MFu2(i2),MHpm2(i1)),dp) 
coupL1 = cplcUFdFuHpmL(gO1,i2,i1)
coupR1 = cplcUFdFuHpmR(gO1,i2,i1)
coupL2 =  Conjg(cplcUFdFuHpmL(gO2,i2,i1))
coupR2 =  Conjg(cplcUFdFuHpmR(gO2,i2,i1))
SumSL(gO1,gO2) = coupR1*coupL2*B0m2 
SumSR(gO1,gO2) = coupL1*coupR2*B0m2 
sumR(gO1,gO2) = coupR1*coupR2*B1m2 
sumL(gO1,gO2) = coupL1*coupL2*B1m2 
   End Do 
End Do 
SigL = SigL +1._dp* sumL
SigR = SigR +1._dp* sumR 
SigSL = SigSL +1._dp* sumSL 
SigSR = SigSR +1._dp* sumSR 
      End Do 
     End Do 
 SigL = oo16pi2*SigL 
SigR = oo16pi2*SigR 
SigSL = oo16pi2*SigSL 
SigSR = oo16pi2*SigSR 
 
End Subroutine Sigma1LoopFd 
 
Subroutine OneLoopFu(hup11,hUp1,hup21,hUp2,hu11,h12,hU1,hU2,Vn,v1,v2,MFu,             & 
& MFu2,MAh,MAh2,MDpm,MDpm2,MHpm,MHpm2,MFd,MFd2,MVWp,MVWp2,MVXp,MVXp2,Mhh,Mhh2,           & 
& MVZ,MVZ2,MVZp,MVZp2,cplcUFuFuAhL,cplcUFuFuAhR,cplcUFuFuDpmL,cplcUFuFuDpmR,             & 
& cplcUFuFdcHpmL,cplcUFuFdcHpmR,cplcUFuFdVWpL,cplcUFuFdVWpR,cplcUFuFdVXpL,               & 
& cplcUFuFdVXpR,cplcUFuFuhhL,cplcUFuFuhhR,cplcUFuFuVGL,cplcUFuFuVGR,cplcUFuFuVPL,        & 
& cplcUFuFuVPR,cplcUFuFuVZL,cplcUFuFuVZR,cplcUFuFuVZpL,cplcUFuFuVZpR,delta,              & 
& MFu_1L,MFu2_1L,Vu_1L,Uu_1L,ierr)

Implicit None 
Real(dp), Intent(in) :: MFu(4),MFu2(4),MAh(3),MAh2(3),MDpm(2),MDpm2(2),MHpm(4),MHpm2(4),MFd(5),               & 
& MFd2(5),MVWp,MVWp2,MVXp,MVXp2,Mhh(3),Mhh2(3),MVZ,MVZ2,MVZp,MVZp2

Real(dp), Intent(in) :: Vn,v1,v2

Complex(dp), Intent(in) :: hup11(3),hUp1,hup21(3),hUp2,hu11(3),h12(3),hU1,hU2

Complex(dp), Intent(in) :: cplcUFuFuAhL(4,4,3),cplcUFuFuAhR(4,4,3),cplcUFuFuDpmL(4,4,2),cplcUFuFuDpmR(4,4,2),    & 
& cplcUFuFdcHpmL(4,5,4),cplcUFuFdcHpmR(4,5,4),cplcUFuFdVWpL(4,5),cplcUFuFdVWpR(4,5),     & 
& cplcUFuFdVXpL(4,5),cplcUFuFdVXpR(4,5),cplcUFuFuhhL(4,4,3),cplcUFuFuhhR(4,4,3),         & 
& cplcUFuFuVGL(4,4),cplcUFuFuVGR(4,4),cplcUFuFuVPL(4,4),cplcUFuFuVPR(4,4),               & 
& cplcUFuFuVZL(4,4),cplcUFuFuVZR(4,4),cplcUFuFuVZpL(4,4),cplcUFuFuVZpR(4,4)

Complex(dp) :: mat1a(4,4), mat1(4,4) 
Integer , Intent(inout):: ierr 
Integer :: i1,i2,i3,i4,j1,j2,j3,j4,il,i_count 
Real(dp), Intent(in) :: delta 
Real(dp) :: mi2(4), test_m2(4), p2 
Real(dp), Intent(out) :: MFu_1L(4),MFu2_1L(4) 
 Complex(dp), Intent(out) :: Vu_1L(4,4), Uu_1L(4,4) 
 
 Real(dp) :: MFu_t(4),MFu2_t(4) 
 Complex(dp) :: Vu_t(4,4), Uu_t(4,4), sigL(4,4), sigR(4,4), sigSL(4,4), sigSR(4,4) 
 
 Complex(dp) :: mat(4,4)=0._dp, mat2(4,4)=0._dp, phaseM 

Complex(dp) :: Vu2(4,4), Uu2(4,4) 
 
 Real(dp) :: Vu1(4,4), Uu1(4,4), test(2) 
 
 Iname = Iname + 1 
NameOfUnit(Iname) = 'OneLoopMFu'
 
mat1a(1,1) = 0._dp 
mat1a(1,1) = mat1a(1,1)+v2*hup11(1)
mat1a(1,2) = 0._dp 
mat1a(1,2) = mat1a(1,2)+v2*hup11(2)
mat1a(1,3) = 0._dp 
mat1a(1,3) = mat1a(1,3)+v2*hup11(3)
mat1a(1,4) = 0._dp 
mat1a(1,4) = mat1a(1,4)+hUp1*v2
mat1a(2,1) = 0._dp 
mat1a(2,1) = mat1a(2,1)+v2*hup21(1)
mat1a(2,2) = 0._dp 
mat1a(2,2) = mat1a(2,2)+v2*hup21(2)
mat1a(2,3) = 0._dp 
mat1a(2,3) = mat1a(2,3)+v2*hup21(3)
mat1a(2,4) = 0._dp 
mat1a(2,4) = mat1a(2,4)+hUp2*v2
mat1a(3,1) = 0._dp 
mat1a(3,1) = mat1a(3,1)+v1*h12(1)
mat1a(3,2) = 0._dp 
mat1a(3,2) = mat1a(3,2)+v1*h12(2)
mat1a(3,3) = 0._dp 
mat1a(3,3) = mat1a(3,3)+v1*h12(3)
mat1a(3,4) = 0._dp 
mat1a(3,4) = mat1a(3,4)+hU2*v1
mat1a(4,1) = 0._dp 
mat1a(4,1) = mat1a(4,1)+Vn*hu11(1)
mat1a(4,2) = 0._dp 
mat1a(4,2) = mat1a(4,2)+Vn*hu11(2)
mat1a(4,3) = 0._dp 
mat1a(4,3) = mat1a(4,3)+Vn*hu11(3)
mat1a(4,4) = 0._dp 
mat1a(4,4) = mat1a(4,4)+hU1*Vn

 
 !---------------------------------------- 
! Rotation matrix for p2=0 
!----------------------------------------- 
 
sigL=0._dp 
sigR=0._dp 
sigSL=0._dp 
sigSR=0._dp 
p2 = 0._dp 
Call Sigma1LoopFu(p2,MFu,MFu2,MAh,MAh2,MDpm,MDpm2,MHpm,MHpm2,MFd,MFd2,MVWp,           & 
& MVWp2,MVXp,MVXp2,Mhh,Mhh2,MVZ,MVZ2,MVZp,MVZp2,cplcUFuFuAhL,cplcUFuFuAhR,               & 
& cplcUFuFuDpmL,cplcUFuFuDpmR,cplcUFuFdcHpmL,cplcUFuFdcHpmR,cplcUFuFdVWpL,               & 
& cplcUFuFdVWpR,cplcUFuFdVXpL,cplcUFuFdVXpR,cplcUFuFuhhL,cplcUFuFuhhR,cplcUFuFuVGL,      & 
& cplcUFuFuVGR,cplcUFuFuVPL,cplcUFuFuVPR,cplcUFuFuVZL,cplcUFuFuVZR,cplcUFuFuVZpL,        & 
& cplcUFuFuVZpR,sigL,sigR,sigSL,sigSR)

mat1 = mat1a - SigSL - 0.5_dp*(MatMul(SigR,mat1a) + MatMul(mat1a,SigL)) 
 
mat2 = Matmul(Transpose(Conjg(mat1)),mat1) 
If (ForceRealMatrices) mat2 = Real(mat2,dp) 
If (Maxval(Abs(Aimag(mat2))).Eq.0._dp) Then 
Call EigenSystem(Real(mat2,dp),MFu2_t,Uu1,ierr,test) 
Uu2 = Uu1 
Else 
Call EigenSystem(mat2,MFu2_t,Uu2,ierr,test) 
 End If 
 
UuOS_0 = Uu2 
 mat2 = Matmul(mat1,Transpose(Conjg(mat1))) 
If (ForceRealMatrices) mat2 = Real(mat2,dp) 
If (Maxval(Abs(Aimag(mat2))).Eq.0._dp) Then 
Call EigenSystem(Real(mat2,dp),MFu2_t,Vu1,ierr,test) 
 
 
Vu2 = Vu1 
Else 
Call EigenSystem(mat2,MFu2_t,Vu2,ierr,test) 
 
 
End If 
Vu2 = Conjg(Vu2) 
VuOS_0 = Vu2 
 
!---------------------------------------- 
! Now, with momenta
!----------------------------------------- 
 
Do il=4,1,-1
sigL=0._dp 
sigR=0._dp 
sigSL=0._dp 
sigSR=0._dp 
p2 = MFu2(il) 
Call Sigma1LoopFu(p2,MFu,MFu2,MAh,MAh2,MDpm,MDpm2,MHpm,MHpm2,MFd,MFd2,MVWp,           & 
& MVWp2,MVXp,MVXp2,Mhh,Mhh2,MVZ,MVZ2,MVZp,MVZp2,cplcUFuFuAhL,cplcUFuFuAhR,               & 
& cplcUFuFuDpmL,cplcUFuFuDpmR,cplcUFuFdcHpmL,cplcUFuFdcHpmR,cplcUFuFdVWpL,               & 
& cplcUFuFdVWpR,cplcUFuFdVXpL,cplcUFuFdVXpR,cplcUFuFuhhL,cplcUFuFuhhR,cplcUFuFuVGL,      & 
& cplcUFuFuVGR,cplcUFuFuVPL,cplcUFuFuVPR,cplcUFuFuVZL,cplcUFuFuVZR,cplcUFuFuVZpL,        & 
& cplcUFuFuVZpR,sigL,sigR,sigSL,sigSR)

mat1 = mat1a - SigSL - 0.5_dp*(MatMul(SigR,mat1a) + MatMul(mat1a,SigL)) 
 
mat2 = Matmul(Transpose(Conjg(mat1)),mat1) 
If (ForceRealMatrices) mat2 = Real(mat2,dp) 
If (Maxval(Abs(Aimag(mat2))).Eq.0._dp) Then 
Call EigenSystem(Real(mat2,dp),MFu2_t,Uu1,ierr,test) 
Uu2 = Uu1 
Else 
Call EigenSystem(mat2,MFu2_t,Uu2,ierr,test) 
 End If 
 
If ((ierr.Eq.-8).Or.(ierr.Eq.-9)) Then 
  Write(ErrCan,*) "Possible numerical problem in "//NameOfUnit(Iname) 
  Write(*,*) "Possible numerical problem in "//NameOfUnit(Iname) 
  If (ErrorLevel.Eq.2) Call TerminateProgram 
  ierr = 0 
End If 
 
!---------------------------------------- 
! Redoing Calculation using redefined p2 
!----------------------------------------- 
 
i_count = 0 
p2_loop: Do  
i_count = i_count + 1 
sigL=0._dp 
sigR=0._dp 
sigSL=0._dp 
sigSR=0._dp 
p2 = MFu2_t(iL)
Call Sigma1LoopFu(p2,MFu,MFu2,MAh,MAh2,MDpm,MDpm2,MHpm,MHpm2,MFd,MFd2,MVWp,           & 
& MVWp2,MVXp,MVXp2,Mhh,Mhh2,MVZ,MVZ2,MVZp,MVZp2,cplcUFuFuAhL,cplcUFuFuAhR,               & 
& cplcUFuFuDpmL,cplcUFuFuDpmR,cplcUFuFdcHpmL,cplcUFuFdcHpmR,cplcUFuFdVWpL,               & 
& cplcUFuFdVWpR,cplcUFuFdVXpL,cplcUFuFdVXpR,cplcUFuFuhhL,cplcUFuFuhhR,cplcUFuFuVGL,      & 
& cplcUFuFuVGR,cplcUFuFuVPL,cplcUFuFuVPR,cplcUFuFuVZL,cplcUFuFuVZR,cplcUFuFuVZpL,        & 
& cplcUFuFuVZpR,sigL,sigR,sigSL,sigSR)

mat1 = mat1a - SigSL - 0.5_dp*(MatMul(SigR,mat1a) + MatMul(mat1a,SigL)) 
 
mat2 = Matmul(Transpose(Conjg(mat1)),mat1) 
If (ForceRealMatrices) mat2 = Real(mat2,dp) 
If (Maxval(Abs(Aimag(mat2))).Eq.0._dp) Then 
Call EigenSystem(Real(mat2,dp),MFu2_t,Uu1,ierr,test) 
Uu2 = Uu1 
Else 
Call EigenSystem(mat2,MFu2_t,Uu2,ierr,test) 
 End If 
 
If ((ierr.Eq.-8).Or.(ierr.Eq.-9)) Then 
  Write(ErrCan,*) "Possible numerical problem in "//NameOfUnit(Iname) 
  Write(*,*) "Possible numerical problem in "//NameOfUnit(Iname) 
  If (ErrorLevel.Eq.2) Call TerminateProgram 
  ierr = 0 
End If 
 
MFu2_1L(il) = MFu2_t(il) 
MFu_1L(il) = Sqrt(MFu2_1L(il)) 
 
If (p2.Ne.0._dp) Then 
  test(1) = Abs(MFu2_1L(il)-p2)/p2
Else 
  test(2) = Abs(MFu2_1L(il))
End If 
If (Abs(MFu2_1L(il)).lt.1.0E-30_dp) Exit p2_loop 
If (test(1).lt.0.1_dp*delta) Exit p2_loop 
If(i_count.gt.30) then 
  Write(ErrCan,*) "Possible numerical problem in "//NameOfUnit(Iname) 
  Exit p2_loop 
End if
End Do p2_loop 
mat2 = Matmul(mat1,Transpose(Conjg(mat1))) 
If (ForceRealMatrices) mat2 = Real(mat2,dp) 
If (Maxval(Abs(Aimag(mat2))).Eq.0._dp) Then 
Call EigenSystem(Real(mat2,dp),MFu2_t,Vu1,ierr,test) 
 
 
Vu2 = Vu1 
Else 
Call EigenSystem(mat2,MFu2_t,Vu2,ierr,test) 
 
 
End If 
Vu2 = Conjg(Vu2) 
 
If ((ierr.Eq.-8).Or.(ierr.Eq.-9)) Then 
  Write(ErrCan,*) "Possible numerical problem in "//NameOfUnit(Iname) 
  Write(*,*) "Possible numerical problem in "//NameOfUnit(Iname) 
  If (ErrorLevel.Eq.2) Call TerminateProgram 
  ierr = 0 
End If 
 
mat2 = Matmul(Matmul( Conjg(Vu2),mat1),Transpose( Conjg(Uu2))) 
Do i1=1,4
If (Abs(mat2(i1,i1)).gt.0._dp) Then 
phaseM = mat2(i1,i1) / Abs(mat2(i1,i1)) 
Uu2(i1,:) = phaseM *Uu2(i1,:) 
 End if 
End Do 
 
VuOS_p2(il,:) = Vu2(il,:) 
 UuOS_p2(il,:) = Uu2(il,:) 
 Vu_1L = Vu2 
 Uu_1L = Uu2 
 End Do  
 
Iname = Iname -1 
End Subroutine OneLoopFu
 
 
Subroutine Sigma1LoopFu(p2,MFu,MFu2,MAh,MAh2,MDpm,MDpm2,MHpm,MHpm2,MFd,               & 
& MFd2,MVWp,MVWp2,MVXp,MVXp2,Mhh,Mhh2,MVZ,MVZ2,MVZp,MVZp2,cplcUFuFuAhL,cplcUFuFuAhR,     & 
& cplcUFuFuDpmL,cplcUFuFuDpmR,cplcUFuFdcHpmL,cplcUFuFdcHpmR,cplcUFuFdVWpL,               & 
& cplcUFuFdVWpR,cplcUFuFdVXpL,cplcUFuFdVXpR,cplcUFuFuhhL,cplcUFuFuhhR,cplcUFuFuVGL,      & 
& cplcUFuFuVGR,cplcUFuFuVPL,cplcUFuFuVPR,cplcUFuFuVZL,cplcUFuFuVZR,cplcUFuFuVZpL,        & 
& cplcUFuFuVZpR,sigL,sigR,sigSL,sigSR)

Implicit None 
Real(dp), Intent(in) :: MFu(4),MFu2(4),MAh(3),MAh2(3),MDpm(2),MDpm2(2),MHpm(4),MHpm2(4),MFd(5),               & 
& MFd2(5),MVWp,MVWp2,MVXp,MVXp2,Mhh(3),Mhh2(3),MVZ,MVZ2,MVZp,MVZp2

Complex(dp), Intent(in) :: cplcUFuFuAhL(4,4,3),cplcUFuFuAhR(4,4,3),cplcUFuFuDpmL(4,4,2),cplcUFuFuDpmR(4,4,2),    & 
& cplcUFuFdcHpmL(4,5,4),cplcUFuFdcHpmR(4,5,4),cplcUFuFdVWpL(4,5),cplcUFuFdVWpR(4,5),     & 
& cplcUFuFdVXpL(4,5),cplcUFuFdVXpR(4,5),cplcUFuFuhhL(4,4,3),cplcUFuFuhhR(4,4,3),         & 
& cplcUFuFuVGL(4,4),cplcUFuFuVGR(4,4),cplcUFuFuVPL(4,4),cplcUFuFuVPR(4,4),               & 
& cplcUFuFuVZL(4,4),cplcUFuFuVZR(4,4),cplcUFuFuVZpL(4,4),cplcUFuFuVZpR(4,4)

Complex(dp), Intent(out) :: SigL(4,4),SigR(4,4), SigSL(4,4), SigSR(4,4) 
Complex(dp) :: coupL1, coupR1, coupL2,coupR2, coup1,coup2,temp, sumL(4,4), sumR(4,4), sumSL(4,4), sumSR(4,4) 
Real(dp) :: B0m2, F0m2, G0m2,B1m2, m1, m2 
Real(dp), Intent(in) :: p2 
Complex(dp) :: A0m2 
Integer :: i1,i2,i3,i4, gO1, gO2, ierr 
 
 
SigL = Cmplx(0._dp,0._dp,dp) 
SigR = Cmplx(0._dp,0._dp,dp) 
SigSL = Cmplx(0._dp,0._dp,dp) 
 SigSR = Cmplx(0._dp,0._dp,dp) 
 
!------------------------ 
! Fu, Ah 
!------------------------ 
    Do i1 = 1, 4
       Do i2 = 1, 3
 SumSL = 0._dp 
SumSR = 0._dp 
sumR = 0._dp 
sumL = 0._dp 
Do gO1 = 1, 4
  Do gO2 = 1, 4
B1m2 = -Real(SA_B1(p2,MFu2(i1),MAh2(i2)),dp) 
B0m2 = MFu(i1)*Real(SA_B0(p2,MFu2(i1),MAh2(i2)),dp) 
coupL1 = cplcUFuFuAhL(gO1,i1,i2)
coupR1 = cplcUFuFuAhR(gO1,i1,i2)
coupL2 =  Conjg(cplcUFuFuAhL(gO2,i1,i2))
coupR2 =  Conjg(cplcUFuFuAhR(gO2,i1,i2))
SumSL(gO1,gO2) = coupR1*coupL2*B0m2 
SumSR(gO1,gO2) = coupL1*coupR2*B0m2 
sumR(gO1,gO2) = coupR1*coupR2*B1m2 
sumL(gO1,gO2) = coupL1*coupL2*B1m2 
   End Do 
End Do 
SigL = SigL +1._dp* sumL
SigR = SigR +1._dp* sumR 
SigSL = SigSL +1._dp* sumSL 
SigSR = SigSR +1._dp* sumSR 
      End Do 
     End Do 
 !------------------------ 
! Fu, Dpm 
!------------------------ 
    Do i1 = 1, 4
       Do i2 = 1, 2
 SumSL = 0._dp 
SumSR = 0._dp 
sumR = 0._dp 
sumL = 0._dp 
Do gO1 = 1, 4
  Do gO2 = 1, 4
B1m2 = -Real(SA_B1(p2,MFu2(i1),MDpm2(i2)),dp) 
B0m2 = MFu(i1)*Real(SA_B0(p2,MFu2(i1),MDpm2(i2)),dp) 
coupL1 = cplcUFuFuDpmL(gO1,i1,i2)
coupR1 = cplcUFuFuDpmR(gO1,i1,i2)
coupL2 =  Conjg(cplcUFuFuDpmL(gO2,i1,i2))
coupR2 =  Conjg(cplcUFuFuDpmR(gO2,i1,i2))
SumSL(gO1,gO2) = coupR1*coupL2*B0m2 
SumSR(gO1,gO2) = coupL1*coupR2*B0m2 
sumR(gO1,gO2) = coupR1*coupR2*B1m2 
sumL(gO1,gO2) = coupL1*coupL2*B1m2 
   End Do 
End Do 
SigL = SigL +1._dp* sumL
SigR = SigR +1._dp* sumR 
SigSL = SigSL +1._dp* sumSL 
SigSR = SigSR +1._dp* sumSR 
      End Do 
     End Do 
 !------------------------ 
! conj[Hpm], Fd 
!------------------------ 
    Do i1 = 1, 4
       Do i2 = 1, 5
 SumSL = 0._dp 
SumSR = 0._dp 
sumR = 0._dp 
sumL = 0._dp 
Do gO1 = 1, 4
  Do gO2 = 1, 4
B1m2 = -Real(SA_B1(p2,MFd2(i2),MHpm2(i1)),dp) 
B0m2 = MFd(i2)*Real(SA_B0(p2,MFd2(i2),MHpm2(i1)),dp) 
coupL1 = cplcUFuFdcHpmL(gO1,i2,i1)
coupR1 = cplcUFuFdcHpmR(gO1,i2,i1)
coupL2 =  Conjg(cplcUFuFdcHpmL(gO2,i2,i1))
coupR2 =  Conjg(cplcUFuFdcHpmR(gO2,i2,i1))
SumSL(gO1,gO2) = coupR1*coupL2*B0m2 
SumSR(gO1,gO2) = coupL1*coupR2*B0m2 
sumR(gO1,gO2) = coupR1*coupR2*B1m2 
sumL(gO1,gO2) = coupL1*coupL2*B1m2 
   End Do 
End Do 
SigL = SigL +1._dp* sumL
SigR = SigR +1._dp* sumR 
SigSL = SigSL +1._dp* sumSL 
SigSR = SigSR +1._dp* sumSR 
      End Do 
     End Do 
 !------------------------ 
! VWp, Fd 
!------------------------ 
      Do i2 = 1, 5
 SumSL = 0._dp 
SumSR = 0._dp 
sumR = 0._dp 
sumL = 0._dp 
Do gO1 = 1, 4
  Do gO2 = 1, 4
B1m2 = -2._dp*Real(SA_B1(p2,MFd2(i2),MVWp2)+ 0.5_dp*rMS,dp) 
B0m2 = -4._dp*MFd(i2)*Real(SA_B0(p2,MFd2(i2),MVWp2)-0.5_dp*rMS,dp) 
coupL1 = cplcUFuFdVWpL(gO1,i2)
coupR1 = cplcUFuFdVWpR(gO1,i2)
coupL2 =  Conjg(cplcUFuFdVWpL(gO2,i2))
coupR2 =  Conjg(cplcUFuFdVWpR(gO2,i2))
SumSL(gO1,gO2) = coupL1*coupR2*B0m2 
SumSR(gO1,gO2) = coupR1*coupL2*B0m2 
sumR(gO1,gO2) = coupL1*coupL2*B1m2 
sumL(gO1,gO2) = coupR1*coupR2*B1m2 
   End Do 
End Do 
SigL = SigL +1._dp* sumL
SigR = SigR +1._dp* sumR 
SigSL = SigSL +1._dp* sumSL 
SigSR = SigSR +1._dp* sumSR 
    End Do 
 !------------------------ 
! VXp, Fd 
!------------------------ 
      Do i2 = 1, 5
 SumSL = 0._dp 
SumSR = 0._dp 
sumR = 0._dp 
sumL = 0._dp 
Do gO1 = 1, 4
  Do gO2 = 1, 4
B1m2 = -2._dp*Real(SA_B1(p2,MFd2(i2),MVXp2)+ 0.5_dp*rMS,dp) 
B0m2 = -4._dp*MFd(i2)*Real(SA_B0(p2,MFd2(i2),MVXp2)-0.5_dp*rMS,dp) 
coupL1 = cplcUFuFdVXpL(gO1,i2)
coupR1 = cplcUFuFdVXpR(gO1,i2)
coupL2 =  Conjg(cplcUFuFdVXpL(gO2,i2))
coupR2 =  Conjg(cplcUFuFdVXpR(gO2,i2))
SumSL(gO1,gO2) = coupL1*coupR2*B0m2 
SumSR(gO1,gO2) = coupR1*coupL2*B0m2 
sumR(gO1,gO2) = coupL1*coupL2*B1m2 
sumL(gO1,gO2) = coupR1*coupR2*B1m2 
   End Do 
End Do 
SigL = SigL +1._dp* sumL
SigR = SigR +1._dp* sumR 
SigSL = SigSL +1._dp* sumSL 
SigSR = SigSR +1._dp* sumSR 
    End Do 
 !------------------------ 
! hh, Fu 
!------------------------ 
    Do i1 = 1, 3
       Do i2 = 1, 4
 SumSL = 0._dp 
SumSR = 0._dp 
sumR = 0._dp 
sumL = 0._dp 
Do gO1 = 1, 4
  Do gO2 = 1, 4
B1m2 = -Real(SA_B1(p2,MFu2(i2),Mhh2(i1)),dp) 
B0m2 = MFu(i2)*Real(SA_B0(p2,MFu2(i2),Mhh2(i1)),dp) 
coupL1 = cplcUFuFuhhL(gO1,i2,i1)
coupR1 = cplcUFuFuhhR(gO1,i2,i1)
coupL2 =  Conjg(cplcUFuFuhhL(gO2,i2,i1))
coupR2 =  Conjg(cplcUFuFuhhR(gO2,i2,i1))
SumSL(gO1,gO2) = coupR1*coupL2*B0m2 
SumSR(gO1,gO2) = coupL1*coupR2*B0m2 
sumR(gO1,gO2) = coupR1*coupR2*B1m2 
sumL(gO1,gO2) = coupL1*coupL2*B1m2 
   End Do 
End Do 
SigL = SigL +1._dp* sumL
SigR = SigR +1._dp* sumR 
SigSL = SigSL +1._dp* sumSL 
SigSR = SigSR +1._dp* sumSR 
      End Do 
     End Do 
 !------------------------ 
! VG, Fu 
!------------------------ 
      Do i2 = 1, 4
 SumSL = 0._dp 
SumSR = 0._dp 
sumR = 0._dp 
sumL = 0._dp 
Do gO1 = 1, 4
  Do gO2 = 1, 4
B1m2 = -2._dp*Real(SA_B1(p2,MFu2(i2),0._dp)+ 0.5_dp*rMS,dp) 
B0m2 = -4._dp*MFu(i2)*Real(SA_B0(p2,MFu2(i2),0._dp)-0.5_dp*rMS,dp) 
coupL1 = cplcUFuFuVGL(gO1,i2)
coupR1 = cplcUFuFuVGR(gO1,i2)
coupL2 =  Conjg(cplcUFuFuVGL(gO2,i2))
coupR2 =  Conjg(cplcUFuFuVGR(gO2,i2))
SumSL(gO1,gO2) = coupL1*coupR2*B0m2 
SumSR(gO1,gO2) = coupR1*coupL2*B0m2 
sumR(gO1,gO2) = coupL1*coupL2*B1m2 
sumL(gO1,gO2) = coupR1*coupR2*B1m2 
   End Do 
End Do 
SigL = SigL +4._dp/3._dp* sumL
SigR = SigR +4._dp/3._dp* sumR 
SigSL = SigSL +4._dp/3._dp* sumSL 
SigSR = SigSR +4._dp/3._dp* sumSR 
    End Do 
 !------------------------ 
! VP, Fu 
!------------------------ 
      Do i2 = 1, 4
 SumSL = 0._dp 
SumSR = 0._dp 
sumR = 0._dp 
sumL = 0._dp 
Do gO1 = 1, 4
  Do gO2 = 1, 4
B1m2 = -2._dp*Real(SA_B1(p2,MFu2(i2),0._dp)+ 0.5_dp*rMS,dp) 
B0m2 = -4._dp*MFu(i2)*Real(SA_B0(p2,MFu2(i2),0._dp)-0.5_dp*rMS,dp) 
coupL1 = cplcUFuFuVPL(gO1,i2)
coupR1 = cplcUFuFuVPR(gO1,i2)
coupL2 =  Conjg(cplcUFuFuVPL(gO2,i2))
coupR2 =  Conjg(cplcUFuFuVPR(gO2,i2))
SumSL(gO1,gO2) = coupL1*coupR2*B0m2 
SumSR(gO1,gO2) = coupR1*coupL2*B0m2 
sumR(gO1,gO2) = coupL1*coupL2*B1m2 
sumL(gO1,gO2) = coupR1*coupR2*B1m2 
   End Do 
End Do 
SigL = SigL +1._dp* sumL
SigR = SigR +1._dp* sumR 
SigSL = SigSL +1._dp* sumSL 
SigSR = SigSR +1._dp* sumSR 
    End Do 
 !------------------------ 
! VZ, Fu 
!------------------------ 
      Do i2 = 1, 4
 SumSL = 0._dp 
SumSR = 0._dp 
sumR = 0._dp 
sumL = 0._dp 
Do gO1 = 1, 4
  Do gO2 = 1, 4
B1m2 = -2._dp*Real(SA_B1(p2,MFu2(i2),MVZ2)+ 0.5_dp*rMS,dp) 
B0m2 = -4._dp*MFu(i2)*Real(SA_B0(p2,MFu2(i2),MVZ2)-0.5_dp*rMS,dp) 
coupL1 = cplcUFuFuVZL(gO1,i2)
coupR1 = cplcUFuFuVZR(gO1,i2)
coupL2 =  Conjg(cplcUFuFuVZL(gO2,i2))
coupR2 =  Conjg(cplcUFuFuVZR(gO2,i2))
SumSL(gO1,gO2) = coupL1*coupR2*B0m2 
SumSR(gO1,gO2) = coupR1*coupL2*B0m2 
sumR(gO1,gO2) = coupL1*coupL2*B1m2 
sumL(gO1,gO2) = coupR1*coupR2*B1m2 
   End Do 
End Do 
SigL = SigL +1._dp* sumL
SigR = SigR +1._dp* sumR 
SigSL = SigSL +1._dp* sumSL 
SigSR = SigSR +1._dp* sumSR 
    End Do 
 !------------------------ 
! VZp, Fu 
!------------------------ 
      Do i2 = 1, 4
 SumSL = 0._dp 
SumSR = 0._dp 
sumR = 0._dp 
sumL = 0._dp 
Do gO1 = 1, 4
  Do gO2 = 1, 4
B1m2 = -2._dp*Real(SA_B1(p2,MFu2(i2),MVZp2)+ 0.5_dp*rMS,dp) 
B0m2 = -4._dp*MFu(i2)*Real(SA_B0(p2,MFu2(i2),MVZp2)-0.5_dp*rMS,dp) 
coupL1 = cplcUFuFuVZpL(gO1,i2)
coupR1 = cplcUFuFuVZpR(gO1,i2)
coupL2 =  Conjg(cplcUFuFuVZpL(gO2,i2))
coupR2 =  Conjg(cplcUFuFuVZpR(gO2,i2))
SumSL(gO1,gO2) = coupL1*coupR2*B0m2 
SumSR(gO1,gO2) = coupR1*coupL2*B0m2 
sumR(gO1,gO2) = coupL1*coupL2*B1m2 
sumL(gO1,gO2) = coupR1*coupR2*B1m2 
   End Do 
End Do 
SigL = SigL +1._dp* sumL
SigR = SigR +1._dp* sumR 
SigSL = SigSL +1._dp* sumSL 
SigSR = SigSR +1._dp* sumSR 
    End Do 
 SigL = oo16pi2*SigL 
SigR = oo16pi2*SigR 
SigSL = oo16pi2*SigSL 
SigSR = oo16pi2*SigSR 
 
End Subroutine Sigma1LoopFu 
 
Subroutine OneLoopFe(hll1,v2,MFe,MFe2,MAh,MAh2,Mhh,Mhh2,MVZ,MVZ2,MVZp,MVZp2,          & 
& MVWp,MVWp2,MHpm,MHpm2,cplcUFeFeAhL,cplcUFeFeAhR,cplcUFeFehhL,cplcUFeFehhR,             & 
& cplcUFeFeVPL,cplcUFeFeVPR,cplcUFeFeVZL,cplcUFeFeVZR,cplcUFeFeVZpL,cplcUFeFeVZpR,       & 
& cplcUFeFv1cVWpL,cplcUFeFv1cVWpR,cplcUFeFv1HpmL,cplcUFeFv1HpmR,cplcUFecFv1HpmL,         & 
& cplcUFecFv1HpmR,delta,MFe_1L,MFe2_1L,Ve_1L,Ue_1L,ierr)

Implicit None 
Real(dp), Intent(in) :: MFe(3),MFe2(3),MAh(3),MAh2(3),Mhh(3),Mhh2(3),MVZ,MVZ2,MVZp,MVZp2,MVWp,MVWp2,          & 
& MHpm(4),MHpm2(4)

Real(dp), Intent(in) :: v2

Complex(dp), Intent(in) :: hll1(3,3)

Complex(dp), Intent(in) :: cplcUFeFeAhL(3,3,3),cplcUFeFeAhR(3,3,3),cplcUFeFehhL(3,3,3),cplcUFeFehhR(3,3,3),      & 
& cplcUFeFeVPL(3,3),cplcUFeFeVPR(3,3),cplcUFeFeVZL(3,3),cplcUFeFeVZR(3,3),               & 
& cplcUFeFeVZpL(3,3),cplcUFeFeVZpR(3,3),cplcUFeFv1cVWpL(3,3),cplcUFeFv1cVWpR(3,3),       & 
& cplcUFeFv1HpmL(3,3,4),cplcUFeFv1HpmR(3,3,4),cplcUFecFv1HpmL(3,3,4),cplcUFecFv1HpmR(3,3,4)

Complex(dp) :: mat1a(3,3), mat1(3,3) 
Integer , Intent(inout):: ierr 
Integer :: i1,i2,i3,i4,j1,j2,j3,j4,il,i_count 
Real(dp), Intent(in) :: delta 
Real(dp) :: mi2(3), test_m2(3), p2 
Real(dp), Intent(out) :: MFe_1L(3),MFe2_1L(3) 
 Complex(dp), Intent(out) :: Ve_1L(3,3), Ue_1L(3,3) 
 
 Real(dp) :: MFe_t(3),MFe2_t(3) 
 Complex(dp) :: Ve_t(3,3), Ue_t(3,3), sigL(3,3), sigR(3,3), sigSL(3,3), sigSR(3,3) 
 
 Complex(dp) :: mat(3,3)=0._dp, mat2(3,3)=0._dp, phaseM 

Complex(dp) :: Ve2(3,3), Ue2(3,3) 
 
 Real(dp) :: Ve1(3,3), Ue1(3,3), test(2) 
 
 Iname = Iname + 1 
NameOfUnit(Iname) = 'OneLoopMFe'
 
mat1a(1,1) = 0._dp 
mat1a(1,1) = mat1a(1,1)+v2*hll1(1,1)
mat1a(1,2) = 0._dp 
mat1a(1,2) = mat1a(1,2)+v2*hll1(1,2)
mat1a(1,3) = 0._dp 
mat1a(1,3) = mat1a(1,3)+v2*hll1(1,3)
mat1a(2,1) = 0._dp 
mat1a(2,1) = mat1a(2,1)+v2*hll1(2,1)
mat1a(2,2) = 0._dp 
mat1a(2,2) = mat1a(2,2)+v2*hll1(2,2)
mat1a(2,3) = 0._dp 
mat1a(2,3) = mat1a(2,3)+v2*hll1(2,3)
mat1a(3,1) = 0._dp 
mat1a(3,1) = mat1a(3,1)+v2*hll1(3,1)
mat1a(3,2) = 0._dp 
mat1a(3,2) = mat1a(3,2)+v2*hll1(3,2)
mat1a(3,3) = 0._dp 
mat1a(3,3) = mat1a(3,3)+v2*hll1(3,3)

 
 !---------------------------------------- 
! Rotation matrix for p2=0 
!----------------------------------------- 
 
sigL=0._dp 
sigR=0._dp 
sigSL=0._dp 
sigSR=0._dp 
p2 = 0._dp 
Call Sigma1LoopFe(p2,MFe,MFe2,MAh,MAh2,Mhh,Mhh2,MVZ,MVZ2,MVZp,MVZp2,MVWp,             & 
& MVWp2,MHpm,MHpm2,cplcUFeFeAhL,cplcUFeFeAhR,cplcUFeFehhL,cplcUFeFehhR,cplcUFeFeVPL,     & 
& cplcUFeFeVPR,cplcUFeFeVZL,cplcUFeFeVZR,cplcUFeFeVZpL,cplcUFeFeVZpR,cplcUFeFv1cVWpL,    & 
& cplcUFeFv1cVWpR,cplcUFeFv1HpmL,cplcUFeFv1HpmR,cplcUFecFv1HpmL,cplcUFecFv1HpmR,         & 
& sigL,sigR,sigSL,sigSR)

mat1 = mat1a - SigSL - 0.5_dp*(MatMul(SigR,mat1a) + MatMul(mat1a,SigL)) 
 
mat2 = Matmul(Transpose(Conjg(mat1)),mat1) 
If (ForceRealMatrices) mat2 = Real(mat2,dp) 
If (Maxval(Abs(Aimag(mat2))).Eq.0._dp) Then 
Call EigenSystem(Real(mat2,dp),MFe2_t,Ue1,ierr,test) 
Ue2 = Ue1 
Else 
Call EigenSystem(mat2,MFe2_t,Ue2,ierr,test) 
 End If 
 
UeOS_0 = Ue2 
 mat2 = Matmul(mat1,Transpose(Conjg(mat1))) 
If (ForceRealMatrices) mat2 = Real(mat2,dp) 
If (Maxval(Abs(Aimag(mat2))).Eq.0._dp) Then 
Call EigenSystem(Real(mat2,dp),MFe2_t,Ve1,ierr,test) 
 
 
Ve2 = Ve1 
Else 
Call EigenSystem(mat2,MFe2_t,Ve2,ierr,test) 
 
 
End If 
Ve2 = Conjg(Ve2) 
VeOS_0 = Ve2 
 
!---------------------------------------- 
! Now, with momenta
!----------------------------------------- 
 
Do il=3,1,-1
sigL=0._dp 
sigR=0._dp 
sigSL=0._dp 
sigSR=0._dp 
p2 = MFe2(il) 
Call Sigma1LoopFe(p2,MFe,MFe2,MAh,MAh2,Mhh,Mhh2,MVZ,MVZ2,MVZp,MVZp2,MVWp,             & 
& MVWp2,MHpm,MHpm2,cplcUFeFeAhL,cplcUFeFeAhR,cplcUFeFehhL,cplcUFeFehhR,cplcUFeFeVPL,     & 
& cplcUFeFeVPR,cplcUFeFeVZL,cplcUFeFeVZR,cplcUFeFeVZpL,cplcUFeFeVZpR,cplcUFeFv1cVWpL,    & 
& cplcUFeFv1cVWpR,cplcUFeFv1HpmL,cplcUFeFv1HpmR,cplcUFecFv1HpmL,cplcUFecFv1HpmR,         & 
& sigL,sigR,sigSL,sigSR)

mat1 = mat1a - SigSL - 0.5_dp*(MatMul(SigR,mat1a) + MatMul(mat1a,SigL)) 
 
mat2 = Matmul(Transpose(Conjg(mat1)),mat1) 
If (ForceRealMatrices) mat2 = Real(mat2,dp) 
If (Maxval(Abs(Aimag(mat2))).Eq.0._dp) Then 
Call EigenSystem(Real(mat2,dp),MFe2_t,Ue1,ierr,test) 
Ue2 = Ue1 
Else 
Call EigenSystem(mat2,MFe2_t,Ue2,ierr,test) 
 End If 
 
If ((ierr.Eq.-8).Or.(ierr.Eq.-9)) Then 
  Write(ErrCan,*) "Possible numerical problem in "//NameOfUnit(Iname) 
  Write(*,*) "Possible numerical problem in "//NameOfUnit(Iname) 
  If (ErrorLevel.Eq.2) Call TerminateProgram 
  ierr = 0 
End If 
 
!---------------------------------------- 
! Redoing Calculation using redefined p2 
!----------------------------------------- 
 
i_count = 0 
p2_loop: Do  
i_count = i_count + 1 
sigL=0._dp 
sigR=0._dp 
sigSL=0._dp 
sigSR=0._dp 
p2 = MFe2_t(iL)
Call Sigma1LoopFe(p2,MFe,MFe2,MAh,MAh2,Mhh,Mhh2,MVZ,MVZ2,MVZp,MVZp2,MVWp,             & 
& MVWp2,MHpm,MHpm2,cplcUFeFeAhL,cplcUFeFeAhR,cplcUFeFehhL,cplcUFeFehhR,cplcUFeFeVPL,     & 
& cplcUFeFeVPR,cplcUFeFeVZL,cplcUFeFeVZR,cplcUFeFeVZpL,cplcUFeFeVZpR,cplcUFeFv1cVWpL,    & 
& cplcUFeFv1cVWpR,cplcUFeFv1HpmL,cplcUFeFv1HpmR,cplcUFecFv1HpmL,cplcUFecFv1HpmR,         & 
& sigL,sigR,sigSL,sigSR)

mat1 = mat1a - SigSL - 0.5_dp*(MatMul(SigR,mat1a) + MatMul(mat1a,SigL)) 
 
mat2 = Matmul(Transpose(Conjg(mat1)),mat1) 
If (ForceRealMatrices) mat2 = Real(mat2,dp) 
If (Maxval(Abs(Aimag(mat2))).Eq.0._dp) Then 
Call EigenSystem(Real(mat2,dp),MFe2_t,Ue1,ierr,test) 
Ue2 = Ue1 
Else 
Call EigenSystem(mat2,MFe2_t,Ue2,ierr,test) 
 End If 
 
If ((ierr.Eq.-8).Or.(ierr.Eq.-9)) Then 
  Write(ErrCan,*) "Possible numerical problem in "//NameOfUnit(Iname) 
  Write(*,*) "Possible numerical problem in "//NameOfUnit(Iname) 
  If (ErrorLevel.Eq.2) Call TerminateProgram 
  ierr = 0 
End If 
 
MFe2_1L(il) = MFe2_t(il) 
MFe_1L(il) = Sqrt(MFe2_1L(il)) 
 
If (p2.Ne.0._dp) Then 
  test(1) = Abs(MFe2_1L(il)-p2)/p2
Else 
  test(2) = Abs(MFe2_1L(il))
End If 
If (Abs(MFe2_1L(il)).lt.1.0E-30_dp) Exit p2_loop 
If (test(1).lt.0.1_dp*delta) Exit p2_loop 
If(i_count.gt.30) then 
  Write(ErrCan,*) "Possible numerical problem in "//NameOfUnit(Iname) 
  Exit p2_loop 
End if
End Do p2_loop 
mat2 = Matmul(mat1,Transpose(Conjg(mat1))) 
If (ForceRealMatrices) mat2 = Real(mat2,dp) 
If (Maxval(Abs(Aimag(mat2))).Eq.0._dp) Then 
Call EigenSystem(Real(mat2,dp),MFe2_t,Ve1,ierr,test) 
 
 
Ve2 = Ve1 
Else 
Call EigenSystem(mat2,MFe2_t,Ve2,ierr,test) 
 
 
End If 
Ve2 = Conjg(Ve2) 
 
If ((ierr.Eq.-8).Or.(ierr.Eq.-9)) Then 
  Write(ErrCan,*) "Possible numerical problem in "//NameOfUnit(Iname) 
  Write(*,*) "Possible numerical problem in "//NameOfUnit(Iname) 
  If (ErrorLevel.Eq.2) Call TerminateProgram 
  ierr = 0 
End If 
 
mat2 = Matmul(Matmul( Conjg(Ve2),mat1),Transpose( Conjg(Ue2))) 
Do i1=1,3
If (Abs(mat2(i1,i1)).gt.0._dp) Then 
phaseM = mat2(i1,i1) / Abs(mat2(i1,i1)) 
Ue2(i1,:) = phaseM *Ue2(i1,:) 
 End if 
End Do 
 
VeOS_p2(il,:) = Ve2(il,:) 
 UeOS_p2(il,:) = Ue2(il,:) 
 Ve_1L = Ve2 
 Ue_1L = Ue2 
 End Do  
 
Iname = Iname -1 
End Subroutine OneLoopFe
 
 
Subroutine Sigma1LoopFe(p2,MFe,MFe2,MAh,MAh2,Mhh,Mhh2,MVZ,MVZ2,MVZp,MVZp2,            & 
& MVWp,MVWp2,MHpm,MHpm2,cplcUFeFeAhL,cplcUFeFeAhR,cplcUFeFehhL,cplcUFeFehhR,             & 
& cplcUFeFeVPL,cplcUFeFeVPR,cplcUFeFeVZL,cplcUFeFeVZR,cplcUFeFeVZpL,cplcUFeFeVZpR,       & 
& cplcUFeFv1cVWpL,cplcUFeFv1cVWpR,cplcUFeFv1HpmL,cplcUFeFv1HpmR,cplcUFecFv1HpmL,         & 
& cplcUFecFv1HpmR,sigL,sigR,sigSL,sigSR)

Implicit None 
Real(dp), Intent(in) :: MFe(3),MFe2(3),MAh(3),MAh2(3),Mhh(3),Mhh2(3),MVZ,MVZ2,MVZp,MVZp2,MVWp,MVWp2,          & 
& MHpm(4),MHpm2(4)

Complex(dp), Intent(in) :: cplcUFeFeAhL(3,3,3),cplcUFeFeAhR(3,3,3),cplcUFeFehhL(3,3,3),cplcUFeFehhR(3,3,3),      & 
& cplcUFeFeVPL(3,3),cplcUFeFeVPR(3,3),cplcUFeFeVZL(3,3),cplcUFeFeVZR(3,3),               & 
& cplcUFeFeVZpL(3,3),cplcUFeFeVZpR(3,3),cplcUFeFv1cVWpL(3,3),cplcUFeFv1cVWpR(3,3),       & 
& cplcUFeFv1HpmL(3,3,4),cplcUFeFv1HpmR(3,3,4),cplcUFecFv1HpmL(3,3,4),cplcUFecFv1HpmR(3,3,4)

Complex(dp), Intent(out) :: SigL(3,3),SigR(3,3), SigSL(3,3), SigSR(3,3) 
Complex(dp) :: coupL1, coupR1, coupL2,coupR2, coup1,coup2,temp, sumL(3,3), sumR(3,3), sumSL(3,3), sumSR(3,3) 
Real(dp) :: B0m2, F0m2, G0m2,B1m2, m1, m2 
Real(dp), Intent(in) :: p2 
Complex(dp) :: A0m2 
Integer :: i1,i2,i3,i4, gO1, gO2, ierr 
 
 
SigL = Cmplx(0._dp,0._dp,dp) 
SigR = Cmplx(0._dp,0._dp,dp) 
SigSL = Cmplx(0._dp,0._dp,dp) 
 SigSR = Cmplx(0._dp,0._dp,dp) 
 
!------------------------ 
! Fe, Ah 
!------------------------ 
    Do i1 = 1, 3
       Do i2 = 1, 3
 SumSL = 0._dp 
SumSR = 0._dp 
sumR = 0._dp 
sumL = 0._dp 
Do gO1 = 1, 3
  Do gO2 = 1, 3
B1m2 = -Real(SA_B1(p2,MFe2(i1),MAh2(i2)),dp) 
B0m2 = MFe(i1)*Real(SA_B0(p2,MFe2(i1),MAh2(i2)),dp) 
coupL1 = cplcUFeFeAhL(gO1,i1,i2)
coupR1 = cplcUFeFeAhR(gO1,i1,i2)
coupL2 =  Conjg(cplcUFeFeAhL(gO2,i1,i2))
coupR2 =  Conjg(cplcUFeFeAhR(gO2,i1,i2))
SumSL(gO1,gO2) = coupR1*coupL2*B0m2 
SumSR(gO1,gO2) = coupL1*coupR2*B0m2 
sumR(gO1,gO2) = coupR1*coupR2*B1m2 
sumL(gO1,gO2) = coupL1*coupL2*B1m2 
   End Do 
End Do 
SigL = SigL +1._dp* sumL
SigR = SigR +1._dp* sumR 
SigSL = SigSL +1._dp* sumSL 
SigSR = SigSR +1._dp* sumSR 
      End Do 
     End Do 
 !------------------------ 
! hh, Fe 
!------------------------ 
    Do i1 = 1, 3
       Do i2 = 1, 3
 SumSL = 0._dp 
SumSR = 0._dp 
sumR = 0._dp 
sumL = 0._dp 
Do gO1 = 1, 3
  Do gO2 = 1, 3
B1m2 = -Real(SA_B1(p2,MFe2(i2),Mhh2(i1)),dp) 
B0m2 = MFe(i2)*Real(SA_B0(p2,MFe2(i2),Mhh2(i1)),dp) 
coupL1 = cplcUFeFehhL(gO1,i2,i1)
coupR1 = cplcUFeFehhR(gO1,i2,i1)
coupL2 =  Conjg(cplcUFeFehhL(gO2,i2,i1))
coupR2 =  Conjg(cplcUFeFehhR(gO2,i2,i1))
SumSL(gO1,gO2) = coupR1*coupL2*B0m2 
SumSR(gO1,gO2) = coupL1*coupR2*B0m2 
sumR(gO1,gO2) = coupR1*coupR2*B1m2 
sumL(gO1,gO2) = coupL1*coupL2*B1m2 
   End Do 
End Do 
SigL = SigL +1._dp* sumL
SigR = SigR +1._dp* sumR 
SigSL = SigSL +1._dp* sumSL 
SigSR = SigSR +1._dp* sumSR 
      End Do 
     End Do 
 !------------------------ 
! VP, Fe 
!------------------------ 
      Do i2 = 1, 3
 SumSL = 0._dp 
SumSR = 0._dp 
sumR = 0._dp 
sumL = 0._dp 
Do gO1 = 1, 3
  Do gO2 = 1, 3
B1m2 = -2._dp*Real(SA_B1(p2,MFe2(i2),0._dp)+ 0.5_dp*rMS,dp) 
B0m2 = -4._dp*MFe(i2)*Real(SA_B0(p2,MFe2(i2),0._dp)-0.5_dp*rMS,dp) 
coupL1 = cplcUFeFeVPL(gO1,i2)
coupR1 = cplcUFeFeVPR(gO1,i2)
coupL2 =  Conjg(cplcUFeFeVPL(gO2,i2))
coupR2 =  Conjg(cplcUFeFeVPR(gO2,i2))
SumSL(gO1,gO2) = coupL1*coupR2*B0m2 
SumSR(gO1,gO2) = coupR1*coupL2*B0m2 
sumR(gO1,gO2) = coupL1*coupL2*B1m2 
sumL(gO1,gO2) = coupR1*coupR2*B1m2 
   End Do 
End Do 
SigL = SigL +1._dp* sumL
SigR = SigR +1._dp* sumR 
SigSL = SigSL +1._dp* sumSL 
SigSR = SigSR +1._dp* sumSR 
    End Do 
 !------------------------ 
! VZ, Fe 
!------------------------ 
      Do i2 = 1, 3
 SumSL = 0._dp 
SumSR = 0._dp 
sumR = 0._dp 
sumL = 0._dp 
Do gO1 = 1, 3
  Do gO2 = 1, 3
B1m2 = -2._dp*Real(SA_B1(p2,MFe2(i2),MVZ2)+ 0.5_dp*rMS,dp) 
B0m2 = -4._dp*MFe(i2)*Real(SA_B0(p2,MFe2(i2),MVZ2)-0.5_dp*rMS,dp) 
coupL1 = cplcUFeFeVZL(gO1,i2)
coupR1 = cplcUFeFeVZR(gO1,i2)
coupL2 =  Conjg(cplcUFeFeVZL(gO2,i2))
coupR2 =  Conjg(cplcUFeFeVZR(gO2,i2))
SumSL(gO1,gO2) = coupL1*coupR2*B0m2 
SumSR(gO1,gO2) = coupR1*coupL2*B0m2 
sumR(gO1,gO2) = coupL1*coupL2*B1m2 
sumL(gO1,gO2) = coupR1*coupR2*B1m2 
   End Do 
End Do 
SigL = SigL +1._dp* sumL
SigR = SigR +1._dp* sumR 
SigSL = SigSL +1._dp* sumSL 
SigSR = SigSR +1._dp* sumSR 
    End Do 
 !------------------------ 
! VZp, Fe 
!------------------------ 
      Do i2 = 1, 3
 SumSL = 0._dp 
SumSR = 0._dp 
sumR = 0._dp 
sumL = 0._dp 
Do gO1 = 1, 3
  Do gO2 = 1, 3
B1m2 = -2._dp*Real(SA_B1(p2,MFe2(i2),MVZp2)+ 0.5_dp*rMS,dp) 
B0m2 = -4._dp*MFe(i2)*Real(SA_B0(p2,MFe2(i2),MVZp2)-0.5_dp*rMS,dp) 
coupL1 = cplcUFeFeVZpL(gO1,i2)
coupR1 = cplcUFeFeVZpR(gO1,i2)
coupL2 =  Conjg(cplcUFeFeVZpL(gO2,i2))
coupR2 =  Conjg(cplcUFeFeVZpR(gO2,i2))
SumSL(gO1,gO2) = coupL1*coupR2*B0m2 
SumSR(gO1,gO2) = coupR1*coupL2*B0m2 
sumR(gO1,gO2) = coupL1*coupL2*B1m2 
sumL(gO1,gO2) = coupR1*coupR2*B1m2 
   End Do 
End Do 
SigL = SigL +1._dp* sumL
SigR = SigR +1._dp* sumR 
SigSL = SigSL +1._dp* sumSL 
SigSR = SigSR +1._dp* sumSR 
    End Do 
 !------------------------ 
! conj[VWp], Fv1 
!------------------------ 
      Do i2 = 1, 3
 SumSL = 0._dp 
SumSR = 0._dp 
sumR = 0._dp 
sumL = 0._dp 
Do gO1 = 1, 3
  Do gO2 = 1, 3
B1m2 = -2._dp*Real(SA_B1(p2,0._dp,MVWp2)+ 0.5_dp*rMS,dp) 
B0m2 = -4._dp*0._dp*Real(SA_B0(p2,0._dp,MVWp2)-0.5_dp*rMS,dp) 
coupL1 = cplcUFeFv1cVWpL(gO1,i2)
coupR1 = cplcUFeFv1cVWpR(gO1,i2)
coupL2 =  Conjg(cplcUFeFv1cVWpL(gO2,i2))
coupR2 =  Conjg(cplcUFeFv1cVWpR(gO2,i2))
SumSL(gO1,gO2) = coupL1*coupR2*B0m2 
SumSR(gO1,gO2) = coupR1*coupL2*B0m2 
sumR(gO1,gO2) = coupL1*coupL2*B1m2 
sumL(gO1,gO2) = coupR1*coupR2*B1m2 
   End Do 
End Do 
SigL = SigL +1._dp* sumL
SigR = SigR +1._dp* sumR 
SigSL = SigSL +1._dp* sumSL 
SigSR = SigSR +1._dp* sumSR 
    End Do 
 !------------------------ 
! Hpm, Fv1 
!------------------------ 
    Do i1 = 1, 4
       Do i2 = 1, 3
 SumSL = 0._dp 
SumSR = 0._dp 
sumR = 0._dp 
sumL = 0._dp 
Do gO1 = 1, 3
  Do gO2 = 1, 3
B1m2 = -Real(SA_B1(p2,0._dp,MHpm2(i1)),dp) 
B0m2 = 0._dp*Real(SA_B0(p2,0._dp,MHpm2(i1)),dp) 
coupL1 = cplcUFeFv1HpmL(gO1,i2,i1)
coupR1 = cplcUFeFv1HpmR(gO1,i2,i1)
coupL2 =  Conjg(cplcUFeFv1HpmL(gO2,i2,i1))
coupR2 =  Conjg(cplcUFeFv1HpmR(gO2,i2,i1))
SumSL(gO1,gO2) = coupR1*coupL2*B0m2 
SumSR(gO1,gO2) = coupL1*coupR2*B0m2 
sumR(gO1,gO2) = coupR1*coupR2*B1m2 
sumL(gO1,gO2) = coupL1*coupL2*B1m2 
   End Do 
End Do 
SigL = SigL +1._dp* sumL
SigR = SigR +1._dp* sumR 
SigSL = SigSL +1._dp* sumSL 
SigSR = SigSR +1._dp* sumSR 
      End Do 
     End Do 
 !------------------------ 
! bar[Fv1], Hpm 
!------------------------ 
    Do i1 = 1, 3
       Do i2 = 1, 4
 SumSL = 0._dp 
SumSR = 0._dp 
sumR = 0._dp 
sumL = 0._dp 
Do gO1 = 1, 3
  Do gO2 = 1, 3
B1m2 = -Real(SA_B1(p2,0._dp,MHpm2(i2)),dp) 
B0m2 = 0._dp*Real(SA_B0(p2,0._dp,MHpm2(i2)),dp) 
coupL1 = cplcUFecFv1HpmL(gO1,i1,i2)
coupR1 = cplcUFecFv1HpmR(gO1,i1,i2)
coupL2 =  Conjg(cplcUFecFv1HpmL(gO2,i1,i2))
coupR2 =  Conjg(cplcUFecFv1HpmR(gO2,i1,i2))
SumSL(gO1,gO2) = coupR1*coupL2*B0m2 
SumSR(gO1,gO2) = coupL1*coupR2*B0m2 
sumR(gO1,gO2) = coupR1*coupR2*B1m2 
sumL(gO1,gO2) = coupL1*coupL2*B1m2 
   End Do 
End Do 
SigL = SigL +1._dp* sumL
SigR = SigR +1._dp* sumR 
SigSL = SigSL +1._dp* sumSL 
SigSR = SigSR +1._dp* sumSR 
      End Do 
     End Do 
 SigL = oo16pi2*SigL 
SigR = oo16pi2*SigR 
SigSL = oo16pi2*SigSL 
SigSR = oo16pi2*SigSR 
 
End Subroutine Sigma1LoopFe 
 
Subroutine Sigma1LoopFv1(p2,MHpm,MHpm2,MFe,MFe2,MVWp,MVWp2,MVZ,MVZ2,MVZp,             & 
& MVZp2,cplcUFv1FecHpmL,cplcUFv1FecHpmR,cplcUFv1FeVWpL,cplcUFv1FeVWpR,cplcUFv1Fv1VPL,    & 
& cplcUFv1Fv1VPR,cplcUFv1Fv1VZL,cplcUFv1Fv1VZR,cplcUFv1Fv1VZpL,cplcUFv1Fv1VZpR,          & 
& cplcFecUFv1HpmL,cplcFecUFv1HpmR,sigL,sigR,sigSL,sigSR)

Implicit None 
Real(dp), Intent(in) :: MHpm(4),MHpm2(4),MFe(3),MFe2(3),MVWp,MVWp2,MVZ,MVZ2,MVZp,MVZp2

Complex(dp), Intent(in) :: cplcUFv1FecHpmL(3,3,4),cplcUFv1FecHpmR(3,3,4),cplcUFv1FeVWpL(3,3),cplcUFv1FeVWpR(3,3),& 
& cplcUFv1Fv1VPL(3,3),cplcUFv1Fv1VPR(3,3),cplcUFv1Fv1VZL(3,3),cplcUFv1Fv1VZR(3,3),       & 
& cplcUFv1Fv1VZpL(3,3),cplcUFv1Fv1VZpR(3,3),cplcFecUFv1HpmL(3,3,4),cplcFecUFv1HpmR(3,3,4)

Complex(dp), Intent(out) :: SigL(3,3),SigR(3,3), SigSL(3,3), SigSR(3,3) 
Complex(dp) :: coupL1, coupR1, coupL2,coupR2, coup1,coup2,temp, sumL(3,3), sumR(3,3), sumSL(3,3), sumSR(3,3) 
Real(dp) :: B0m2, F0m2, G0m2,B1m2, m1, m2 
Real(dp), Intent(in) :: p2 
Complex(dp) :: A0m2 
Integer :: i1,i2,i3,i4, gO1, gO2, ierr 
 
 
SigL = Cmplx(0._dp,0._dp,dp) 
SigR = Cmplx(0._dp,0._dp,dp) 
SigSL = Cmplx(0._dp,0._dp,dp) 
 SigSR = Cmplx(0._dp,0._dp,dp) 
 
!------------------------ 
! conj[Hpm], Fe 
!------------------------ 
    Do i1 = 1, 4
       Do i2 = 1, 3
 SumSL = 0._dp 
SumSR = 0._dp 
sumR = 0._dp 
sumL = 0._dp 
Do gO1 = 1, 3
  Do gO2 = 1, 3
B1m2 = -Real(SA_B1(p2,MFe2(i2),MHpm2(i1)),dp) 
B0m2 = MFe(i2)*Real(SA_B0(p2,MFe2(i2),MHpm2(i1)),dp) 
coupL1 = cplcUFv1FecHpmL(gO1,i2,i1)
coupR1 = cplcUFv1FecHpmR(gO1,i2,i1)
coupL2 =  Conjg(cplcUFv1FecHpmL(gO2,i2,i1))
coupR2 =  Conjg(cplcUFv1FecHpmR(gO2,i2,i1))
SumSL(gO1,gO2) = coupR1*coupL2*B0m2 
SumSR(gO1,gO2) = coupL1*coupR2*B0m2 
sumR(gO1,gO2) = coupR1*coupR2*B1m2 
sumL(gO1,gO2) = coupL1*coupL2*B1m2 
   End Do 
End Do 
SigL = SigL +1._dp* sumL
SigR = SigR +1._dp* sumR 
SigSL = SigSL +1._dp* sumSL 
SigSR = SigSR +1._dp* sumSR 
      End Do 
     End Do 
 !------------------------ 
! VWp, Fe 
!------------------------ 
      Do i2 = 1, 3
 SumSL = 0._dp 
SumSR = 0._dp 
sumR = 0._dp 
sumL = 0._dp 
Do gO1 = 1, 3
  Do gO2 = 1, 3
B1m2 = -2._dp*Real(SA_B1(p2,MFe2(i2),MVWp2)+ 0.5_dp*rMS,dp) 
B0m2 = -4._dp*MFe(i2)*Real(SA_B0(p2,MFe2(i2),MVWp2)-0.5_dp*rMS,dp) 
coupL1 = cplcUFv1FeVWpL(gO1,i2)
coupR1 = cplcUFv1FeVWpR(gO1,i2)
coupL2 =  Conjg(cplcUFv1FeVWpL(gO2,i2))
coupR2 =  Conjg(cplcUFv1FeVWpR(gO2,i2))
SumSL(gO1,gO2) = coupL1*coupR2*B0m2 
SumSR(gO1,gO2) = coupR1*coupL2*B0m2 
sumR(gO1,gO2) = coupL1*coupL2*B1m2 
sumL(gO1,gO2) = coupR1*coupR2*B1m2 
   End Do 
End Do 
SigL = SigL +1._dp* sumL
SigR = SigR +1._dp* sumR 
SigSL = SigSL +1._dp* sumSL 
SigSR = SigSR +1._dp* sumSR 
    End Do 
 !------------------------ 
! VP, Fv1 
!------------------------ 
      Do i2 = 1, 3
 SumSL = 0._dp 
SumSR = 0._dp 
sumR = 0._dp 
sumL = 0._dp 
Do gO1 = 1, 3
  Do gO2 = 1, 3
B1m2 = -2._dp*Real(SA_B1(p2,0._dp,0._dp)+ 0.5_dp*rMS,dp) 
B0m2 = -4._dp*0._dp*Real(SA_B0(p2,0._dp,0._dp)-0.5_dp*rMS,dp) 
coupL1 = cplcUFv1Fv1VPL(gO1,i2)
coupR1 = cplcUFv1Fv1VPR(gO1,i2)
coupL2 =  Conjg(cplcUFv1Fv1VPL(gO2,i2))
coupR2 =  Conjg(cplcUFv1Fv1VPR(gO2,i2))
SumSL(gO1,gO2) = coupL1*coupR2*B0m2 
SumSR(gO1,gO2) = coupR1*coupL2*B0m2 
sumR(gO1,gO2) = coupL1*coupL2*B1m2 
sumL(gO1,gO2) = coupR1*coupR2*B1m2 
   End Do 
End Do 
SigL = SigL +1._dp* sumL
SigR = SigR +1._dp* sumR 
SigSL = SigSL +1._dp* sumSL 
SigSR = SigSR +1._dp* sumSR 
    End Do 
 !------------------------ 
! VZ, Fv1 
!------------------------ 
      Do i2 = 1, 3
 SumSL = 0._dp 
SumSR = 0._dp 
sumR = 0._dp 
sumL = 0._dp 
Do gO1 = 1, 3
  Do gO2 = 1, 3
B1m2 = -2._dp*Real(SA_B1(p2,0._dp,MVZ2)+ 0.5_dp*rMS,dp) 
B0m2 = -4._dp*0._dp*Real(SA_B0(p2,0._dp,MVZ2)-0.5_dp*rMS,dp) 
coupL1 = cplcUFv1Fv1VZL(gO1,i2)
coupR1 = cplcUFv1Fv1VZR(gO1,i2)
coupL2 =  Conjg(cplcUFv1Fv1VZL(gO2,i2))
coupR2 =  Conjg(cplcUFv1Fv1VZR(gO2,i2))
SumSL(gO1,gO2) = coupL1*coupR2*B0m2 
SumSR(gO1,gO2) = coupR1*coupL2*B0m2 
sumR(gO1,gO2) = coupL1*coupL2*B1m2 
sumL(gO1,gO2) = coupR1*coupR2*B1m2 
   End Do 
End Do 
SigL = SigL +1._dp* sumL
SigR = SigR +1._dp* sumR 
SigSL = SigSL +1._dp* sumSL 
SigSR = SigSR +1._dp* sumSR 
    End Do 
 !------------------------ 
! VZp, Fv1 
!------------------------ 
      Do i2 = 1, 3
 SumSL = 0._dp 
SumSR = 0._dp 
sumR = 0._dp 
sumL = 0._dp 
Do gO1 = 1, 3
  Do gO2 = 1, 3
B1m2 = -2._dp*Real(SA_B1(p2,0._dp,MVZp2)+ 0.5_dp*rMS,dp) 
B0m2 = -4._dp*0._dp*Real(SA_B0(p2,0._dp,MVZp2)-0.5_dp*rMS,dp) 
coupL1 = cplcUFv1Fv1VZpL(gO1,i2)
coupR1 = cplcUFv1Fv1VZpR(gO1,i2)
coupL2 =  Conjg(cplcUFv1Fv1VZpL(gO2,i2))
coupR2 =  Conjg(cplcUFv1Fv1VZpR(gO2,i2))
SumSL(gO1,gO2) = coupL1*coupR2*B0m2 
SumSR(gO1,gO2) = coupR1*coupL2*B0m2 
sumR(gO1,gO2) = coupL1*coupL2*B1m2 
sumL(gO1,gO2) = coupR1*coupR2*B1m2 
   End Do 
End Do 
SigL = SigL +1._dp* sumL
SigR = SigR +1._dp* sumR 
SigSL = SigSL +1._dp* sumSL 
SigSR = SigSR +1._dp* sumSR 
    End Do 
 !------------------------ 
! bar[Fe], Hpm 
!------------------------ 
    Do i1 = 1, 3
       Do i2 = 1, 4
 SumSL = 0._dp 
SumSR = 0._dp 
sumR = 0._dp 
sumL = 0._dp 
Do gO1 = 1, 3
  Do gO2 = 1, 3
B1m2 = -Real(SA_B1(p2,MFe2(i1),MHpm2(i2)),dp) 
B0m2 = MFe(i1)*Real(SA_B0(p2,MFe2(i1),MHpm2(i2)),dp) 
coupL1 = cplcFecUFv1HpmL(i1,gO1,i2)
coupR1 = cplcFecUFv1HpmR(i1,gO1,i2)
coupL2 =  Conjg(cplcFecUFv1HpmL(i1,gO2,i2))
coupR2 =  Conjg(cplcFecUFv1HpmR(i1,gO2,i2))
SumSL(gO1,gO2) = coupR1*coupL2*B0m2 
SumSR(gO1,gO2) = coupL1*coupR2*B0m2 
sumR(gO1,gO2) = coupR1*coupR2*B1m2 
sumL(gO1,gO2) = coupL1*coupL2*B1m2 
   End Do 
End Do 
SigL = SigL +1._dp* sumL
SigR = SigR +1._dp* sumR 
SigSL = SigSL +1._dp* sumSL 
SigSR = SigSR +1._dp* sumSR 
      End Do 
     End Do 
 SigL = oo16pi2*SigL 
SigR = oo16pi2*SigR 
SigSL = oo16pi2*SigSL 
SigSR = oo16pi2*SigSR 
 
End Subroutine Sigma1LoopFv1 
 
Subroutine Pi1LoopVG(p2,MFd,MFd2,MFu,MFu2,cplcFdFdVGL,cplcFdFdVGR,cplcFuFuVGL,        & 
& cplcFuFuVGR,cplcgGgGVG,cplVGVGVG,cplVGVGVGVG1,cplVGVGVGVG2,cplVGVGVGVG3,kont,res)

Implicit None 
Real(dp), Intent(in) :: MFd(5),MFd2(5),MFu(4),MFu2(4)

Complex(dp), Intent(in) :: cplcFdFdVGL(5,5),cplcFdFdVGR(5,5),cplcFuFuVGL(4,4),cplcFuFuVGR(4,4),cplcgGgGVG,       & 
& cplVGVGVG,cplVGVGVGVG1,cplVGVGVGVG2,cplVGVGVGVG3

Integer, Intent(inout) :: kont 
Real(dp) :: B0m2, F0m2, G0m2, B1m2, H0m2, B22m2, m1, m2 
Real(dp), Intent(in) :: p2 
Complex(dp) :: A0m2, A0m12, A0m22 
Complex(dp), Intent(inout) :: res 
Complex(dp) :: coupL1, coupR1, coupL2,coupR2, coup1,coup2, coup3, temp, sumI 
Integer :: i1,i2,i3,i4, gO1, gO2, ierr 
 
 
res = 0._dp 
 
!------------------------ 
! bar[Fd], Fd 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 5
       Do i2 = 1, 5
 H0m2 = Real(SA_Hloop(p2,MFd2(i1),MFd2(i2)),dp) 
B0m2 = 4._dp*MFd(i1)*MFd(i2)*Real(SA_B0(p2,MFd2(i1),MFd2(i2)),dp) 
coupL1 = cplcFdFdVGL(i1,i2)
coupR1 = cplcFdFdVGR(i1,i2)
    SumI = (Abs(coupL1)**2+Abs(coupR1)**2)*H0m2 & 
                & + (Real(Conjg(coupL1)*coupR1,dp))*B0m2 
res = res +0.5_dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[Fu], Fu 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
       Do i2 = 1, 4
 H0m2 = Real(SA_Hloop(p2,MFu2(i1),MFu2(i2)),dp) 
B0m2 = 4._dp*MFu(i1)*MFu(i2)*Real(SA_B0(p2,MFu2(i1),MFu2(i2)),dp) 
coupL1 = cplcFuFuVGL(i1,i2)
coupR1 = cplcFuFuVGR(i1,i2)
    SumI = (Abs(coupL1)**2+Abs(coupR1)**2)*H0m2 & 
                & + (Real(Conjg(coupL1)*coupR1,dp))*B0m2 
res = res +0.5_dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[gG], gG 
!------------------------ 
sumI = 0._dp 
 
SumI = 0._dp 
B0m2 = Real(VGGloop(p2,0._dp,0._dp),dp)
coup1 = cplcgGgGVG
coup2 = Conjg(coup1) 
   SumI = coup1*coup2*B0m2 
res = res +3._dp* SumI  
!------------------------ 
! VG, VG 
!------------------------ 
sumI = 0._dp 
 
coup1 = cplVGVGVG
coup2 = Conjg(coup1) 
    SumI = -VVVloop(p2,0._dp,0._dp)*coup1*coup2 
res = res +1.5_dp* SumI  
!------------------------ 
! VG 
!------------------------ 
SumI = 0._dp 
A0m2 = 3._dp/4._dp*SA_A0(0._dp) +RXi/4._dp*SA_A0(0._dp*RXi) 
coup1 = cplVGVGVGVG1
coup2 = cplVGVGVGVG2
coup3 = cplVGVGVGVG3
SumI = ((2._dp*rMS*coup1+(1-RXi**2)/8._dp*(coup2+coup3))*0._dp-(4._dp*coup1+coup2+coup3)*A0m2)
res = res +1._dp/2._dp* SumI  
res = oo16pi2*res 
 
End Subroutine Pi1LoopVG 
 
Subroutine DerPi1LoopVG(p2,MFd,MFd2,MFu,MFu2,cplcFdFdVGL,cplcFdFdVGR,cplcFuFuVGL,     & 
& cplcFuFuVGR,cplcgGgGVG,cplVGVGVG,cplVGVGVGVG1,cplVGVGVGVG2,cplVGVGVGVG3,kont,res)

Implicit None 
Real(dp), Intent(in) :: MFd(5),MFd2(5),MFu(4),MFu2(4)

Complex(dp), Intent(in) :: cplcFdFdVGL(5,5),cplcFdFdVGR(5,5),cplcFuFuVGL(4,4),cplcFuFuVGR(4,4),cplcgGgGVG,       & 
& cplVGVGVG,cplVGVGVGVG1,cplVGVGVGVG2,cplVGVGVGVG3

Integer, Intent(inout) :: kont 
Real(dp) :: B0m2, F0m2, G0m2, B1m2, H0m2, B22m2, m1, m2 
Real(dp), Intent(in) :: p2 
Complex(dp) :: A0m2, A0m12, A0m22 
Complex(dp), Intent(inout) :: res 
Complex(dp) :: coupL1, coupR1, coupL2,coupR2, coup1,coup2, coup3, temp, sumI 
Integer :: i1,i2,i3,i4, gO1, gO2, ierr 
 
 
Real(dp) ::MVG,MVP,MVG2,MVP2
MVG = Mass_Regulator_PhotonGluon 
MVP = Mass_Regulator_PhotonGluon 
MVG2 = Mass_Regulator_PhotonGluon**2 
MVP2 = Mass_Regulator_PhotonGluon**2 

res = 0._dp 
 
!------------------------ 
! bar[Fd], Fd 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 5
       Do i2 = 1, 5
 H0m2 = Real(SA_DerHloop(p2,MFd2(i1),MFd2(i2)),dp) 
B0m2 = 4._dp*MFd(i1)*MFd(i2)*Real(SA_DerB0(p2,MFd2(i1),MFd2(i2)),dp) 
coupL1 = cplcFdFdVGL(i1,i2)
coupR1 = cplcFdFdVGR(i1,i2)
    SumI = (Abs(coupL1)**2+Abs(coupR1)**2)*H0m2 & 
                & + (Real(Conjg(coupL1)*coupR1,dp))*B0m2 
res = res +0.5_dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[Fu], Fu 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
       Do i2 = 1, 4
 H0m2 = Real(SA_DerHloop(p2,MFu2(i1),MFu2(i2)),dp) 
B0m2 = 4._dp*MFu(i1)*MFu(i2)*Real(SA_DerB0(p2,MFu2(i1),MFu2(i2)),dp) 
coupL1 = cplcFuFuVGL(i1,i2)
coupR1 = cplcFuFuVGR(i1,i2)
    SumI = (Abs(coupL1)**2+Abs(coupR1)**2)*H0m2 & 
                & + (Real(Conjg(coupL1)*coupR1,dp))*B0m2 
res = res +0.5_dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[gG], gG 
!------------------------ 
sumI = 0._dp 
 
SumI = 0._dp 
B0m2 = Real(DerVGGloop(p2,MVG2,MVG2),dp)
coup1 = cplcgGgGVG
coup2 = Conjg(coup1) 
   SumI = coup1*coup2*B0m2 
res = res +3._dp* SumI  
!------------------------ 
! VG, VG 
!------------------------ 
sumI = 0._dp 
 
coup1 = cplVGVGVG
coup2 = Conjg(coup1) 
    SumI = -DerVVVloop(p2,MVG2,MVG2)*coup1*coup2 
res = res +1.5_dp* SumI  
!------------------------ 
! VG 
!------------------------ 
SumI = 0._dp 
A0m2 = 3._dp/4._dp*SA_DerA0(MVG2) +RXi/4._dp*SA_DerA0(MVG2*RXi) 
coup1 = cplVGVGVGVG1
coup2 = cplVGVGVGVG2
coup3 = cplVGVGVGVG3
SumI = ((2._dp*DerrMS*coup1+(1-RXi**2)/8._dp*(coup2+coup3))*MVG2-(4._dp*coup1+coup2+coup3)*A0m2)
res = res +1._dp/2._dp* SumI  
res = oo16pi2*res 
 
End Subroutine DerPi1LoopVG 
 
Subroutine Pi1LoopVP(p2,Mhh,Mhh2,MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,MFe2,               & 
& MFu,MFu2,MVZ,MVZ2,MVZp,MVZp2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,cplAhhhVP,               & 
& cplDpmcDpmVP,cplcFdFdVPL,cplcFdFdVPR,cplcFeFeVPL,cplcFeFeVPR,cplcFuFuVPL,              & 
& cplcFuFuVPR,cplcFv1Fv1VPL,cplcFv1Fv1VPR,cplcgWpgWpVP,cplcgWCgWCVP,cplcgXp1gXp1VP,      & 
& cplcgXp2gXp2VP,cplhhVPVZ,cplhhVPVZp,cplHpmcHpmVP,cplHpmVPVWp,cplHpmVPVXp,              & 
& cplcVWpVPVWp,cplcVXpVPVXp,cplAhAhVPVP,cplDpmcDpmVPVP,cplhhhhVPVP,cplHpmcHpmVPVP,       & 
& cplcVWpVPVPVWp3,cplcVWpVPVPVWp1,cplcVWpVPVPVWp2,cplcVXpVPVPVXp3,cplcVXpVPVPVXp1,       & 
& cplcVXpVPVPVXp2,kont,res)

Implicit None 
Real(dp), Intent(in) :: Mhh(3),Mhh2(3),MAh(3),MAh2(3),MDpm(2),MDpm2(2),MFd(5),MFd2(5),MFe(3),MFe2(3),         & 
& MFu(4),MFu2(4),MVZ,MVZ2,MVZp,MVZp2,MHpm(4),MHpm2(4),MVWp,MVWp2,MVXp,MVXp2

Complex(dp), Intent(in) :: cplAhhhVP(3,3),cplDpmcDpmVP(2,2),cplcFdFdVPL(5,5),cplcFdFdVPR(5,5),cplcFeFeVPL(3,3),  & 
& cplcFeFeVPR(3,3),cplcFuFuVPL(4,4),cplcFuFuVPR(4,4),cplcFv1Fv1VPL(3,3),cplcFv1Fv1VPR(3,3),& 
& cplcgWpgWpVP,cplcgWCgWCVP,cplcgXp1gXp1VP,cplcgXp2gXp2VP,cplhhVPVZ(3),cplhhVPVZp(3),    & 
& cplHpmcHpmVP(4,4),cplHpmVPVWp(4),cplHpmVPVXp(4),cplcVWpVPVWp,cplcVXpVPVXp,             & 
& cplAhAhVPVP(3,3),cplDpmcDpmVPVP(2,2),cplhhhhVPVP(3,3),cplHpmcHpmVPVP(4,4),             & 
& cplcVWpVPVPVWp3,cplcVWpVPVPVWp1,cplcVWpVPVPVWp2,cplcVXpVPVPVXp3,cplcVXpVPVPVXp1,       & 
& cplcVXpVPVPVXp2

Integer, Intent(inout) :: kont 
Real(dp) :: B0m2, F0m2, G0m2, B1m2, H0m2, B22m2, m1, m2 
Real(dp), Intent(in) :: p2 
Complex(dp) :: A0m2, A0m12, A0m22 
Complex(dp), Intent(inout) :: res 
Complex(dp) :: coupL1, coupR1, coupL2,coupR2, coup1,coup2, coup3, temp, sumI 
Integer :: i1,i2,i3,i4, gO1, gO2, ierr 
 
 
res = 0._dp 
 
!------------------------ 
! hh, Ah 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 3
       Do i2 = 1, 3
 If (((.not.OnlyHeavyStates).and.(.not.OnlyLightStates)) & 
  & .or.((OnlyHeavyStates).and.(MAh2(i2).gt.50._dp**2).and.(Mhh2(i1).gt.50._dp**2))   & 
  & .or.((OnlyLightStates).and.(MAh2(i2).lt.50._dp**2).and.(Mhh2(i1).lt.50._dp**2)) )   Then 
B22m2 = Real(VSSloop(p2,MAh2(i2),Mhh2(i1)),dp)  
coup1 = cplAhhhVP(i2,i1)
    SumI = Abs(coup1)**2*B22m2 
res = res +1._dp* SumI  
End If 
      End Do 
     End Do 
 !------------------------ 
! conj[Dpm], Dpm 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 2
       Do i2 = 1, 2
 If (((.not.OnlyHeavyStates).and.(.not.OnlyLightStates)) & 
  & .or.((OnlyHeavyStates).and.(MDpm2(i2).gt.50._dp**2).and.(MDpm2(i1).gt.50._dp**2))   & 
  & .or.((OnlyLightStates).and.(MDpm2(i2).lt.50._dp**2).and.(MDpm2(i1).lt.50._dp**2)) )   Then 
B22m2 = Real(VSSloop(p2,MDpm2(i2),MDpm2(i1)),dp)  
coup1 = cplDpmcDpmVP(i2,i1)
    SumI = Abs(coup1)**2*B22m2 
res = res +1._dp* SumI  
End If 
      End Do 
     End Do 
 !------------------------ 
! bar[Fd], Fd 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 5
       Do i2 = 1, 5
 If (((.not.OnlyHeavyStates).and.(.not.OnlyLightStates)) & 
  & .or.((OnlyHeavyStates).and.(MFd2(i1).gt.50._dp**2).and.(MFd2(i2).gt.50._dp**2))   & 
  & .or.((OnlyLightStates).and.(MFd2(i1).lt.50._dp**2).and.(MFd2(i2).lt.50._dp**2)) )   Then 
H0m2 = Real(SA_Hloop(p2,MFd2(i1),MFd2(i2)),dp) 
B0m2 = 4._dp*MFd(i1)*MFd(i2)*Real(SA_B0(p2,MFd2(i1),MFd2(i2)),dp) 
coupL1 = cplcFdFdVPL(i1,i2)
coupR1 = cplcFdFdVPR(i1,i2)
    SumI = (Abs(coupL1)**2+Abs(coupR1)**2)*H0m2 & 
                & + (Real(Conjg(coupL1)*coupR1,dp))*B0m2 
res = res +3._dp* SumI  
End If 
      End Do 
     End Do 
 !------------------------ 
! bar[Fe], Fe 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 3
       Do i2 = 1, 3
 If (((.not.OnlyHeavyStates).and.(.not.OnlyLightStates)) & 
  & .or.((OnlyHeavyStates).and.(MFe2(i1).gt.50._dp**2).and.(MFe2(i2).gt.50._dp**2))   & 
  & .or.((OnlyLightStates).and.(MFe2(i1).lt.50._dp**2).and.(MFe2(i2).lt.50._dp**2)) )   Then 
H0m2 = Real(SA_Hloop(p2,MFe2(i1),MFe2(i2)),dp) 
B0m2 = 4._dp*MFe(i1)*MFe(i2)*Real(SA_B0(p2,MFe2(i1),MFe2(i2)),dp) 
coupL1 = cplcFeFeVPL(i1,i2)
coupR1 = cplcFeFeVPR(i1,i2)
    SumI = (Abs(coupL1)**2+Abs(coupR1)**2)*H0m2 & 
                & + (Real(Conjg(coupL1)*coupR1,dp))*B0m2 
res = res +1._dp* SumI  
End If 
      End Do 
     End Do 
 !------------------------ 
! bar[Fu], Fu 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
       Do i2 = 1, 4
 If (((.not.OnlyHeavyStates).and.(.not.OnlyLightStates)) & 
  & .or.((OnlyHeavyStates).and.(MFu2(i1).gt.50._dp**2).and.(MFu2(i2).gt.50._dp**2))   & 
  & .or.((OnlyLightStates).and.(MFu2(i1).lt.50._dp**2).and.(MFu2(i2).lt.50._dp**2)) )   Then 
H0m2 = Real(SA_Hloop(p2,MFu2(i1),MFu2(i2)),dp) 
B0m2 = 4._dp*MFu(i1)*MFu(i2)*Real(SA_B0(p2,MFu2(i1),MFu2(i2)),dp) 
coupL1 = cplcFuFuVPL(i1,i2)
coupR1 = cplcFuFuVPR(i1,i2)
    SumI = (Abs(coupL1)**2+Abs(coupR1)**2)*H0m2 & 
                & + (Real(Conjg(coupL1)*coupR1,dp))*B0m2 
res = res +3._dp* SumI  
End If 
      End Do 
     End Do 
 !------------------------ 
! bar[Fv1], Fv1 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 3
       Do i2 = 1, 3
 If (((.not.OnlyHeavyStates).and.(.not.OnlyLightStates)) & 
  & .or.((OnlyHeavyStates).and.(0._dp.gt.50._dp**2).and.(0._dp.gt.50._dp**2))   & 
  & .or.((OnlyLightStates).and.(0._dp.lt.50._dp**2).and.(0._dp.lt.50._dp**2)) )   Then 
H0m2 = Real(SA_Hloop(p2,0._dp,0._dp),dp) 
B0m2 = 4._dp*0._dp*0._dp*Real(SA_B0(p2,0._dp,0._dp),dp) 
coupL1 = cplcFv1Fv1VPL(i1,i2)
coupR1 = cplcFv1Fv1VPR(i1,i2)
    SumI = (Abs(coupL1)**2+Abs(coupR1)**2)*H0m2 & 
                & + (Real(Conjg(coupL1)*coupR1,dp))*B0m2 
res = res +1._dp* SumI  
End If 
      End Do 
     End Do 
 !------------------------ 
! bar[gWp], gWp 
!------------------------ 
sumI = 0._dp 
 
If (((.not.OnlyHeavyStates).and.(.not.OnlyLightStates)) & 
  & .or.((OnlyHeavyStates).and.(MVWp2.gt.50._dp**2).and.(MVWp2.gt.50._dp**2))   & 
  & .or.((OnlyLightStates).and.(MVWp2.lt.50._dp**2).and.(MVWp2.lt.50._dp**2)) )   Then 
SumI = 0._dp 
B0m2 = Real(VGGloop(p2,MVWp2,MVWp2),dp)
coup1 = cplcgWpgWpVP
coup2 = Conjg(coup1) 
   SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
End If 
!------------------------ 
! bar[gWpC], gWpC 
!------------------------ 
sumI = 0._dp 
 
If (((.not.OnlyHeavyStates).and.(.not.OnlyLightStates)) & 
  & .or.((OnlyHeavyStates).and.(MVWp2.gt.50._dp**2).and.(MVWp2.gt.50._dp**2))   & 
  & .or.((OnlyLightStates).and.(MVWp2.lt.50._dp**2).and.(MVWp2.lt.50._dp**2)) )   Then 
SumI = 0._dp 
B0m2 = Real(VGGloop(p2,MVWp2,MVWp2),dp)
coup1 = cplcgWCgWCVP
coup2 = Conjg(coup1) 
   SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
End If 
!------------------------ 
! bar[gXp], gXp 
!------------------------ 
sumI = 0._dp 
 
If (((.not.OnlyHeavyStates).and.(.not.OnlyLightStates)) & 
  & .or.((OnlyHeavyStates).and.(MVXp2.gt.50._dp**2).and.(MVXp2.gt.50._dp**2))   & 
  & .or.((OnlyLightStates).and.(MVXp2.lt.50._dp**2).and.(MVXp2.lt.50._dp**2)) )   Then 
SumI = 0._dp 
B0m2 = Real(VGGloop(p2,MVXp2,MVXp2),dp)
coup1 = cplcgXp1gXp1VP
coup2 = Conjg(coup1) 
   SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
End If 
!------------------------ 
! bar[gXpC], gXpC 
!------------------------ 
sumI = 0._dp 
 
If (((.not.OnlyHeavyStates).and.(.not.OnlyLightStates)) & 
  & .or.((OnlyHeavyStates).and.(MVXp2.gt.50._dp**2).and.(MVXp2.gt.50._dp**2))   & 
  & .or.((OnlyLightStates).and.(MVXp2.lt.50._dp**2).and.(MVXp2.lt.50._dp**2)) )   Then 
SumI = 0._dp 
B0m2 = Real(VGGloop(p2,MVXp2,MVXp2),dp)
coup1 = cplcgXp2gXp2VP
coup2 = Conjg(coup1) 
   SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
End If 
!------------------------ 
! VZ, hh 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 3
 If (((.not.OnlyHeavyStates).and.(.not.OnlyLightStates)) & 
  & .or.((OnlyHeavyStates).and.(MVZ2.gt.50._dp**2).and.(Mhh2(i2).gt.50._dp**2))   & 
  & .or.((OnlyLightStates).and.(MVZ2.lt.50._dp**2).and.(Mhh2(i2).lt.50._dp**2)) )   Then 
B0m2 = Real(VVSloop(p2,MVZ2,Mhh2(i2)),dp)
coup1 = cplhhVPVZ(i2)
    SumI = Abs(coup1)**2*B0m2 
res = res +1._dp* SumI  
End If 
    End Do 
 !------------------------ 
! VZp, hh 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 3
 If (((.not.OnlyHeavyStates).and.(.not.OnlyLightStates)) & 
  & .or.((OnlyHeavyStates).and.(MVZp2.gt.50._dp**2).and.(Mhh2(i2).gt.50._dp**2))   & 
  & .or.((OnlyLightStates).and.(MVZp2.lt.50._dp**2).and.(Mhh2(i2).lt.50._dp**2)) )   Then 
B0m2 = Real(VVSloop(p2,MVZp2,Mhh2(i2)),dp)
coup1 = cplhhVPVZp(i2)
    SumI = Abs(coup1)**2*B0m2 
res = res +1._dp* SumI  
End If 
    End Do 
 !------------------------ 
! conj[Hpm], Hpm 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
       Do i2 = 1, 4
 If (((.not.OnlyHeavyStates).and.(.not.OnlyLightStates)) & 
  & .or.((OnlyHeavyStates).and.(MHpm2(i2).gt.50._dp**2).and.(MHpm2(i1).gt.50._dp**2))   & 
  & .or.((OnlyLightStates).and.(MHpm2(i2).lt.50._dp**2).and.(MHpm2(i1).lt.50._dp**2)) )   Then 
B22m2 = Real(VSSloop(p2,MHpm2(i2),MHpm2(i1)),dp)  
coup1 = cplHpmcHpmVP(i2,i1)
    SumI = Abs(coup1)**2*B22m2 
res = res +1._dp* SumI  
End If 
      End Do 
     End Do 
 !------------------------ 
! VWp, Hpm 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 If (((.not.OnlyHeavyStates).and.(.not.OnlyLightStates)) & 
  & .or.((OnlyHeavyStates).and.(MVWp2.gt.50._dp**2).and.(MHpm2(i2).gt.50._dp**2))   & 
  & .or.((OnlyLightStates).and.(MVWp2.lt.50._dp**2).and.(MHpm2(i2).lt.50._dp**2)) )   Then 
B0m2 = Real(VVSloop(p2,MVWp2,MHpm2(i2)),dp)
coup1 = cplHpmVPVWp(i2)
    SumI = Abs(coup1)**2*B0m2 
res = res +2._dp* SumI  
End If 
    End Do 
 !------------------------ 
! VXp, Hpm 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 If (((.not.OnlyHeavyStates).and.(.not.OnlyLightStates)) & 
  & .or.((OnlyHeavyStates).and.(MVXp2.gt.50._dp**2).and.(MHpm2(i2).gt.50._dp**2))   & 
  & .or.((OnlyLightStates).and.(MVXp2.lt.50._dp**2).and.(MHpm2(i2).lt.50._dp**2)) )   Then 
B0m2 = Real(VVSloop(p2,MVXp2,MHpm2(i2)),dp)
coup1 = cplHpmVPVXp(i2)
    SumI = Abs(coup1)**2*B0m2 
res = res +2._dp* SumI  
End If 
    End Do 
 !------------------------ 
! conj[VWp], VWp 
!------------------------ 
sumI = 0._dp 
 
If (((.not.OnlyHeavyStates).and.(.not.OnlyLightStates)) & 
  & .or.((OnlyHeavyStates).and.(MVWp2.gt.50._dp**2).and.(MVWp2.gt.50._dp**2))   & 
  & .or.((OnlyLightStates).and.(MVWp2.lt.50._dp**2).and.(MVWp2.lt.50._dp**2)) )   Then 
coup1 = cplcVWpVPVWp
coup2 = Conjg(coup1) 
    SumI = -VVVloop(p2,MVWp2,MVWp2)*coup1*coup2 
res = res +1._dp* SumI  
End If 
!------------------------ 
! conj[VXp], VXp 
!------------------------ 
sumI = 0._dp 
 
If (((.not.OnlyHeavyStates).and.(.not.OnlyLightStates)) & 
  & .or.((OnlyHeavyStates).and.(MVXp2.gt.50._dp**2).and.(MVXp2.gt.50._dp**2))   & 
  & .or.((OnlyLightStates).and.(MVXp2.lt.50._dp**2).and.(MVXp2.lt.50._dp**2)) )   Then 
coup1 = cplcVXpVPVXp
coup2 = Conjg(coup1) 
    SumI = -VVVloop(p2,MVXp2,MVXp2)*coup1*coup2 
res = res +1._dp* SumI  
End If 
!------------------------ 
! Ah 
!------------------------ 
    Do i1 = 1, 3
 If (((.not.OnlyHeavyStates).and.(.not.OnlyLightStates)) & 
  & .or.((OnlyHeavyStates).and.(MAh2(i1).gt.50._dp**2))   & 
  & .or.((OnlyLightStates).and.(MAh2(i1).lt.50._dp**2)) )   Then 
SumI = 0._dp 
 A0m2 = SA_A0(MAh2(i1))
 coup1 = cplAhAhVPVP(i1,i1)
 SumI = coup1*A0m2 
res = res +1._dp/2._dp* SumI  
End If 
      End Do 
 !------------------------ 
! conj[Dpm] 
!------------------------ 
    Do i1 = 1, 2
 If (((.not.OnlyHeavyStates).and.(.not.OnlyLightStates)) & 
  & .or.((OnlyHeavyStates).and.(MDpm2(i1).gt.50._dp**2))   & 
  & .or.((OnlyLightStates).and.(MDpm2(i1).lt.50._dp**2)) )   Then 
SumI = 0._dp 
 A0m2 = SA_A0(MDpm2(i1))
 coup1 = cplDpmcDpmVPVP(i1,i1)
 SumI = coup1*A0m2 
res = res +1* SumI  
End If 
      End Do 
 !------------------------ 
! hh 
!------------------------ 
    Do i1 = 1, 3
 If (((.not.OnlyHeavyStates).and.(.not.OnlyLightStates)) & 
  & .or.((OnlyHeavyStates).and.(Mhh2(i1).gt.50._dp**2))   & 
  & .or.((OnlyLightStates).and.(Mhh2(i1).lt.50._dp**2)) )   Then 
SumI = 0._dp 
 A0m2 = SA_A0(Mhh2(i1))
 coup1 = cplhhhhVPVP(i1,i1)
 SumI = coup1*A0m2 
res = res +1._dp/2._dp* SumI  
End If 
      End Do 
 !------------------------ 
! conj[Hpm] 
!------------------------ 
    Do i1 = 1, 4
 If (((.not.OnlyHeavyStates).and.(.not.OnlyLightStates)) & 
  & .or.((OnlyHeavyStates).and.(MHpm2(i1).gt.50._dp**2))   & 
  & .or.((OnlyLightStates).and.(MHpm2(i1).lt.50._dp**2)) )   Then 
SumI = 0._dp 
 A0m2 = SA_A0(MHpm2(i1))
 coup1 = cplHpmcHpmVPVP(i1,i1)
 SumI = coup1*A0m2 
res = res +1* SumI  
End If 
      End Do 
 !------------------------ 
! conj[VWp] 
!------------------------ 
If (((.not.OnlyHeavyStates).and.(.not.OnlyLightStates)) & 
  & .or.((OnlyHeavyStates).and.(MVWp2.gt.50._dp**2))   & 
  & .or.((OnlyLightStates).and.(MVWp2.lt.50._dp**2)) )   Then 
SumI = 0._dp 
A0m2 = 3._dp/4._dp*SA_A0(MVWp2) +RXi/4._dp*SA_A0(MVWp2*RXi) 
coup1 = cplcVWpVPVPVWp3
coup2 = cplcVWpVPVPVWp1
coup3 = cplcVWpVPVPVWp2
SumI = ((2._dp*rMS*coup1+(1-RXi**2)/8._dp*(coup2+coup3))*MVWp2-(4._dp*coup1+coup2+coup3)*A0m2)
res = res +1* SumI  
End If 
!------------------------ 
! conj[VXp] 
!------------------------ 
If (((.not.OnlyHeavyStates).and.(.not.OnlyLightStates)) & 
  & .or.((OnlyHeavyStates).and.(MVXp2.gt.50._dp**2))   & 
  & .or.((OnlyLightStates).and.(MVXp2.lt.50._dp**2)) )   Then 
SumI = 0._dp 
A0m2 = 3._dp/4._dp*SA_A0(MVXp2) +RXi/4._dp*SA_A0(MVXp2*RXi) 
coup1 = cplcVXpVPVPVXp3
coup2 = cplcVXpVPVPVXp1
coup3 = cplcVXpVPVPVXp2
SumI = ((2._dp*rMS*coup1+(1-RXi**2)/8._dp*(coup2+coup3))*MVXp2-(4._dp*coup1+coup2+coup3)*A0m2)
res = res +1* SumI  
End If 
res = oo16pi2*res 
 
End Subroutine Pi1LoopVP 
 
Subroutine DerPi1LoopVP(p2,Mhh,Mhh2,MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,MFe2,            & 
& MFu,MFu2,MVZ,MVZ2,MVZp,MVZp2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,cplAhhhVP,               & 
& cplDpmcDpmVP,cplcFdFdVPL,cplcFdFdVPR,cplcFeFeVPL,cplcFeFeVPR,cplcFuFuVPL,              & 
& cplcFuFuVPR,cplcFv1Fv1VPL,cplcFv1Fv1VPR,cplcgWpgWpVP,cplcgWCgWCVP,cplcgXp1gXp1VP,      & 
& cplcgXp2gXp2VP,cplhhVPVZ,cplhhVPVZp,cplHpmcHpmVP,cplHpmVPVWp,cplHpmVPVXp,              & 
& cplcVWpVPVWp,cplcVXpVPVXp,cplAhAhVPVP,cplDpmcDpmVPVP,cplhhhhVPVP,cplHpmcHpmVPVP,       & 
& cplcVWpVPVPVWp3,cplcVWpVPVPVWp1,cplcVWpVPVPVWp2,cplcVXpVPVPVXp3,cplcVXpVPVPVXp1,       & 
& cplcVXpVPVPVXp2,kont,res)

Implicit None 
Real(dp), Intent(in) :: Mhh(3),Mhh2(3),MAh(3),MAh2(3),MDpm(2),MDpm2(2),MFd(5),MFd2(5),MFe(3),MFe2(3),         & 
& MFu(4),MFu2(4),MVZ,MVZ2,MVZp,MVZp2,MHpm(4),MHpm2(4),MVWp,MVWp2,MVXp,MVXp2

Complex(dp), Intent(in) :: cplAhhhVP(3,3),cplDpmcDpmVP(2,2),cplcFdFdVPL(5,5),cplcFdFdVPR(5,5),cplcFeFeVPL(3,3),  & 
& cplcFeFeVPR(3,3),cplcFuFuVPL(4,4),cplcFuFuVPR(4,4),cplcFv1Fv1VPL(3,3),cplcFv1Fv1VPR(3,3),& 
& cplcgWpgWpVP,cplcgWCgWCVP,cplcgXp1gXp1VP,cplcgXp2gXp2VP,cplhhVPVZ(3),cplhhVPVZp(3),    & 
& cplHpmcHpmVP(4,4),cplHpmVPVWp(4),cplHpmVPVXp(4),cplcVWpVPVWp,cplcVXpVPVXp,             & 
& cplAhAhVPVP(3,3),cplDpmcDpmVPVP(2,2),cplhhhhVPVP(3,3),cplHpmcHpmVPVP(4,4),             & 
& cplcVWpVPVPVWp3,cplcVWpVPVPVWp1,cplcVWpVPVPVWp2,cplcVXpVPVPVXp3,cplcVXpVPVPVXp1,       & 
& cplcVXpVPVPVXp2

Integer, Intent(inout) :: kont 
Real(dp) :: B0m2, F0m2, G0m2, B1m2, H0m2, B22m2, m1, m2 
Real(dp), Intent(in) :: p2 
Complex(dp) :: A0m2, A0m12, A0m22 
Complex(dp), Intent(inout) :: res 
Complex(dp) :: coupL1, coupR1, coupL2,coupR2, coup1,coup2, coup3, temp, sumI 
Integer :: i1,i2,i3,i4, gO1, gO2, ierr 
 
 
Real(dp) ::MVG,MVP,MVG2,MVP2
MVG = Mass_Regulator_PhotonGluon 
MVP = Mass_Regulator_PhotonGluon 
MVG2 = Mass_Regulator_PhotonGluon**2 
MVP2 = Mass_Regulator_PhotonGluon**2 

res = 0._dp 
 
!------------------------ 
! hh, Ah 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 3
       Do i2 = 1, 3
 If (((.not.OnlyHeavyStates).and.(.not.OnlyLightStates)) & 
  & .or.((OnlyHeavyStates).and.(MAh2(i2).gt.50._dp**2).and.(Mhh2(i1).gt.50._dp**2))   & 
  & .or.((OnlyLightStates).and.(MAh2(i2).lt.50._dp**2).and.(Mhh2(i1).lt.50._dp**2)) )   Then 
B22m2 = Real(DerVSSloop(p2,MAh2(i2),Mhh2(i1)),dp)  
coup1 = cplAhhhVP(i2,i1)
    SumI = Abs(coup1)**2*B22m2 
res = res +1._dp* SumI  
End If 
      End Do 
     End Do 
 !------------------------ 
! conj[Dpm], Dpm 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 2
       Do i2 = 1, 2
 If (((.not.OnlyHeavyStates).and.(.not.OnlyLightStates)) & 
  & .or.((OnlyHeavyStates).and.(MDpm2(i2).gt.50._dp**2).and.(MDpm2(i1).gt.50._dp**2))   & 
  & .or.((OnlyLightStates).and.(MDpm2(i2).lt.50._dp**2).and.(MDpm2(i1).lt.50._dp**2)) )   Then 
B22m2 = Real(DerVSSloop(p2,MDpm2(i2),MDpm2(i1)),dp)  
coup1 = cplDpmcDpmVP(i2,i1)
    SumI = Abs(coup1)**2*B22m2 
res = res +1._dp* SumI  
End If 
      End Do 
     End Do 
 !------------------------ 
! bar[Fd], Fd 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 5
       Do i2 = 1, 5
 If (((.not.OnlyHeavyStates).and.(.not.OnlyLightStates)) & 
  & .or.((OnlyHeavyStates).and.(MFd2(i1).gt.50._dp**2).and.(MFd2(i2).gt.50._dp**2))   & 
  & .or.((OnlyLightStates).and.(MFd2(i1).lt.50._dp**2).and.(MFd2(i2).lt.50._dp**2)) )   Then 
H0m2 = Real(SA_DerHloop(p2,MFd2(i1),MFd2(i2)),dp) 
B0m2 = 4._dp*MFd(i1)*MFd(i2)*Real(SA_DerB0(p2,MFd2(i1),MFd2(i2)),dp) 
coupL1 = cplcFdFdVPL(i1,i2)
coupR1 = cplcFdFdVPR(i1,i2)
    SumI = (Abs(coupL1)**2+Abs(coupR1)**2)*H0m2 & 
                & + (Real(Conjg(coupL1)*coupR1,dp))*B0m2 
res = res +3._dp* SumI  
End If 
      End Do 
     End Do 
 !------------------------ 
! bar[Fe], Fe 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 3
       Do i2 = 1, 3
 If (((.not.OnlyHeavyStates).and.(.not.OnlyLightStates)) & 
  & .or.((OnlyHeavyStates).and.(MFe2(i1).gt.50._dp**2).and.(MFe2(i2).gt.50._dp**2))   & 
  & .or.((OnlyLightStates).and.(MFe2(i1).lt.50._dp**2).and.(MFe2(i2).lt.50._dp**2)) )   Then 
H0m2 = Real(SA_DerHloop(p2,MFe2(i1),MFe2(i2)),dp) 
B0m2 = 4._dp*MFe(i1)*MFe(i2)*Real(SA_DerB0(p2,MFe2(i1),MFe2(i2)),dp) 
coupL1 = cplcFeFeVPL(i1,i2)
coupR1 = cplcFeFeVPR(i1,i2)
    SumI = (Abs(coupL1)**2+Abs(coupR1)**2)*H0m2 & 
                & + (Real(Conjg(coupL1)*coupR1,dp))*B0m2 
res = res +1._dp* SumI  
End If 
      End Do 
     End Do 
 !------------------------ 
! bar[Fu], Fu 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
       Do i2 = 1, 4
 If (((.not.OnlyHeavyStates).and.(.not.OnlyLightStates)) & 
  & .or.((OnlyHeavyStates).and.(MFu2(i1).gt.50._dp**2).and.(MFu2(i2).gt.50._dp**2))   & 
  & .or.((OnlyLightStates).and.(MFu2(i1).lt.50._dp**2).and.(MFu2(i2).lt.50._dp**2)) )   Then 
H0m2 = Real(SA_DerHloop(p2,MFu2(i1),MFu2(i2)),dp) 
B0m2 = 4._dp*MFu(i1)*MFu(i2)*Real(SA_DerB0(p2,MFu2(i1),MFu2(i2)),dp) 
coupL1 = cplcFuFuVPL(i1,i2)
coupR1 = cplcFuFuVPR(i1,i2)
    SumI = (Abs(coupL1)**2+Abs(coupR1)**2)*H0m2 & 
                & + (Real(Conjg(coupL1)*coupR1,dp))*B0m2 
res = res +3._dp* SumI  
End If 
      End Do 
     End Do 
 !------------------------ 
! bar[Fv1], Fv1 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 3
       Do i2 = 1, 3
 If (((.not.OnlyHeavyStates).and.(.not.OnlyLightStates)) & 
  & .or.((OnlyHeavyStates).and.(0._dp.gt.50._dp**2).and.(0._dp.gt.50._dp**2))   & 
  & .or.((OnlyLightStates).and.(0._dp.lt.50._dp**2).and.(0._dp.lt.50._dp**2)) )   Then 
H0m2 = Real(SA_DerHloop(p2,0._dp,0._dp),dp) 
B0m2 = 4._dp*0._dp*0._dp*Real(SA_DerB0(p2,0._dp,0._dp),dp) 
coupL1 = cplcFv1Fv1VPL(i1,i2)
coupR1 = cplcFv1Fv1VPR(i1,i2)
    SumI = (Abs(coupL1)**2+Abs(coupR1)**2)*H0m2 & 
                & + (Real(Conjg(coupL1)*coupR1,dp))*B0m2 
res = res +1._dp* SumI  
End If 
      End Do 
     End Do 
 !------------------------ 
! bar[gWp], gWp 
!------------------------ 
sumI = 0._dp 
 
If (((.not.OnlyHeavyStates).and.(.not.OnlyLightStates)) & 
  & .or.((OnlyHeavyStates).and.(MVWp2.gt.50._dp**2).and.(MVWp2.gt.50._dp**2))   & 
  & .or.((OnlyLightStates).and.(MVWp2.lt.50._dp**2).and.(MVWp2.lt.50._dp**2)) )   Then 
SumI = 0._dp 
B0m2 = Real(DerVGGloop(p2,MVWp2,MVWp2),dp)
coup1 = cplcgWpgWpVP
coup2 = Conjg(coup1) 
   SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
End If 
!------------------------ 
! bar[gWpC], gWpC 
!------------------------ 
sumI = 0._dp 
 
If (((.not.OnlyHeavyStates).and.(.not.OnlyLightStates)) & 
  & .or.((OnlyHeavyStates).and.(MVWp2.gt.50._dp**2).and.(MVWp2.gt.50._dp**2))   & 
  & .or.((OnlyLightStates).and.(MVWp2.lt.50._dp**2).and.(MVWp2.lt.50._dp**2)) )   Then 
SumI = 0._dp 
B0m2 = Real(DerVGGloop(p2,MVWp2,MVWp2),dp)
coup1 = cplcgWCgWCVP
coup2 = Conjg(coup1) 
   SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
End If 
!------------------------ 
! bar[gXp], gXp 
!------------------------ 
sumI = 0._dp 
 
If (((.not.OnlyHeavyStates).and.(.not.OnlyLightStates)) & 
  & .or.((OnlyHeavyStates).and.(MVXp2.gt.50._dp**2).and.(MVXp2.gt.50._dp**2))   & 
  & .or.((OnlyLightStates).and.(MVXp2.lt.50._dp**2).and.(MVXp2.lt.50._dp**2)) )   Then 
SumI = 0._dp 
B0m2 = Real(DerVGGloop(p2,MVXp2,MVXp2),dp)
coup1 = cplcgXp1gXp1VP
coup2 = Conjg(coup1) 
   SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
End If 
!------------------------ 
! bar[gXpC], gXpC 
!------------------------ 
sumI = 0._dp 
 
If (((.not.OnlyHeavyStates).and.(.not.OnlyLightStates)) & 
  & .or.((OnlyHeavyStates).and.(MVXp2.gt.50._dp**2).and.(MVXp2.gt.50._dp**2))   & 
  & .or.((OnlyLightStates).and.(MVXp2.lt.50._dp**2).and.(MVXp2.lt.50._dp**2)) )   Then 
SumI = 0._dp 
B0m2 = Real(DerVGGloop(p2,MVXp2,MVXp2),dp)
coup1 = cplcgXp2gXp2VP
coup2 = Conjg(coup1) 
   SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
End If 
!------------------------ 
! VZ, hh 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 3
 If (((.not.OnlyHeavyStates).and.(.not.OnlyLightStates)) & 
  & .or.((OnlyHeavyStates).and.(MVZ2.gt.50._dp**2).and.(Mhh2(i2).gt.50._dp**2))   & 
  & .or.((OnlyLightStates).and.(MVZ2.lt.50._dp**2).and.(Mhh2(i2).lt.50._dp**2)) )   Then 
B0m2 = Real(DerVVSloop(p2,MVZ2,Mhh2(i2)),dp)
coup1 = cplhhVPVZ(i2)
    SumI = Abs(coup1)**2*B0m2 
res = res +1._dp* SumI  
End If 
    End Do 
 !------------------------ 
! VZp, hh 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 3
 If (((.not.OnlyHeavyStates).and.(.not.OnlyLightStates)) & 
  & .or.((OnlyHeavyStates).and.(MVZp2.gt.50._dp**2).and.(Mhh2(i2).gt.50._dp**2))   & 
  & .or.((OnlyLightStates).and.(MVZp2.lt.50._dp**2).and.(Mhh2(i2).lt.50._dp**2)) )   Then 
B0m2 = Real(DerVVSloop(p2,MVZp2,Mhh2(i2)),dp)
coup1 = cplhhVPVZp(i2)
    SumI = Abs(coup1)**2*B0m2 
res = res +1._dp* SumI  
End If 
    End Do 
 !------------------------ 
! conj[Hpm], Hpm 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
       Do i2 = 1, 4
 If (((.not.OnlyHeavyStates).and.(.not.OnlyLightStates)) & 
  & .or.((OnlyHeavyStates).and.(MHpm2(i2).gt.50._dp**2).and.(MHpm2(i1).gt.50._dp**2))   & 
  & .or.((OnlyLightStates).and.(MHpm2(i2).lt.50._dp**2).and.(MHpm2(i1).lt.50._dp**2)) )   Then 
B22m2 = Real(DerVSSloop(p2,MHpm2(i2),MHpm2(i1)),dp)  
coup1 = cplHpmcHpmVP(i2,i1)
    SumI = Abs(coup1)**2*B22m2 
res = res +1._dp* SumI  
End If 
      End Do 
     End Do 
 !------------------------ 
! VWp, Hpm 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 If (((.not.OnlyHeavyStates).and.(.not.OnlyLightStates)) & 
  & .or.((OnlyHeavyStates).and.(MVWp2.gt.50._dp**2).and.(MHpm2(i2).gt.50._dp**2))   & 
  & .or.((OnlyLightStates).and.(MVWp2.lt.50._dp**2).and.(MHpm2(i2).lt.50._dp**2)) )   Then 
B0m2 = Real(DerVVSloop(p2,MVWp2,MHpm2(i2)),dp)
coup1 = cplHpmVPVWp(i2)
    SumI = Abs(coup1)**2*B0m2 
res = res +2._dp* SumI  
End If 
    End Do 
 !------------------------ 
! VXp, Hpm 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 If (((.not.OnlyHeavyStates).and.(.not.OnlyLightStates)) & 
  & .or.((OnlyHeavyStates).and.(MVXp2.gt.50._dp**2).and.(MHpm2(i2).gt.50._dp**2))   & 
  & .or.((OnlyLightStates).and.(MVXp2.lt.50._dp**2).and.(MHpm2(i2).lt.50._dp**2)) )   Then 
B0m2 = Real(DerVVSloop(p2,MVXp2,MHpm2(i2)),dp)
coup1 = cplHpmVPVXp(i2)
    SumI = Abs(coup1)**2*B0m2 
res = res +2._dp* SumI  
End If 
    End Do 
 !------------------------ 
! conj[VWp], VWp 
!------------------------ 
sumI = 0._dp 
 
If (((.not.OnlyHeavyStates).and.(.not.OnlyLightStates)) & 
  & .or.((OnlyHeavyStates).and.(MVWp2.gt.50._dp**2).and.(MVWp2.gt.50._dp**2))   & 
  & .or.((OnlyLightStates).and.(MVWp2.lt.50._dp**2).and.(MVWp2.lt.50._dp**2)) )   Then 
coup1 = cplcVWpVPVWp
coup2 = Conjg(coup1) 
    SumI = -DerVVVloop(p2,MVWp2,MVWp2)*coup1*coup2 
res = res +1._dp* SumI  
End If 
!------------------------ 
! conj[VXp], VXp 
!------------------------ 
sumI = 0._dp 
 
If (((.not.OnlyHeavyStates).and.(.not.OnlyLightStates)) & 
  & .or.((OnlyHeavyStates).and.(MVXp2.gt.50._dp**2).and.(MVXp2.gt.50._dp**2))   & 
  & .or.((OnlyLightStates).and.(MVXp2.lt.50._dp**2).and.(MVXp2.lt.50._dp**2)) )   Then 
coup1 = cplcVXpVPVXp
coup2 = Conjg(coup1) 
    SumI = -DerVVVloop(p2,MVXp2,MVXp2)*coup1*coup2 
res = res +1._dp* SumI  
End If 
!------------------------ 
! Ah 
!------------------------ 
    Do i1 = 1, 3
 If (((.not.OnlyHeavyStates).and.(.not.OnlyLightStates)) & 
  & .or.((OnlyHeavyStates).and.(MAh2(i1).gt.50._dp**2))   & 
  & .or.((OnlyLightStates).and.(MAh2(i1).lt.50._dp**2)) )   Then 
SumI = 0._dp 
 A0m2 = SA_DerA0(MAh2(i1))
 coup1 = cplAhAhVPVP(i1,i1)
 SumI = coup1*A0m2 
res = res +1._dp/2._dp* SumI  
End If 
      End Do 
 !------------------------ 
! conj[Dpm] 
!------------------------ 
    Do i1 = 1, 2
 If (((.not.OnlyHeavyStates).and.(.not.OnlyLightStates)) & 
  & .or.((OnlyHeavyStates).and.(MDpm2(i1).gt.50._dp**2))   & 
  & .or.((OnlyLightStates).and.(MDpm2(i1).lt.50._dp**2)) )   Then 
SumI = 0._dp 
 A0m2 = SA_DerA0(MDpm2(i1))
 coup1 = cplDpmcDpmVPVP(i1,i1)
 SumI = coup1*A0m2 
res = res +1* SumI  
End If 
      End Do 
 !------------------------ 
! hh 
!------------------------ 
    Do i1 = 1, 3
 If (((.not.OnlyHeavyStates).and.(.not.OnlyLightStates)) & 
  & .or.((OnlyHeavyStates).and.(Mhh2(i1).gt.50._dp**2))   & 
  & .or.((OnlyLightStates).and.(Mhh2(i1).lt.50._dp**2)) )   Then 
SumI = 0._dp 
 A0m2 = SA_DerA0(Mhh2(i1))
 coup1 = cplhhhhVPVP(i1,i1)
 SumI = coup1*A0m2 
res = res +1._dp/2._dp* SumI  
End If 
      End Do 
 !------------------------ 
! conj[Hpm] 
!------------------------ 
    Do i1 = 1, 4
 If (((.not.OnlyHeavyStates).and.(.not.OnlyLightStates)) & 
  & .or.((OnlyHeavyStates).and.(MHpm2(i1).gt.50._dp**2))   & 
  & .or.((OnlyLightStates).and.(MHpm2(i1).lt.50._dp**2)) )   Then 
SumI = 0._dp 
 A0m2 = SA_DerA0(MHpm2(i1))
 coup1 = cplHpmcHpmVPVP(i1,i1)
 SumI = coup1*A0m2 
res = res +1* SumI  
End If 
      End Do 
 !------------------------ 
! conj[VWp] 
!------------------------ 
If (((.not.OnlyHeavyStates).and.(.not.OnlyLightStates)) & 
  & .or.((OnlyHeavyStates).and.(MVWp2.gt.50._dp**2))   & 
  & .or.((OnlyLightStates).and.(MVWp2.lt.50._dp**2)) )   Then 
SumI = 0._dp 
A0m2 = 3._dp/4._dp*SA_DerA0(MVWp2) +RXi/4._dp*SA_DerA0(MVWp2*RXi) 
coup1 = cplcVWpVPVPVWp3
coup2 = cplcVWpVPVPVWp1
coup3 = cplcVWpVPVPVWp2
SumI = ((2._dp*DerrMS*coup1+(1-RXi**2)/8._dp*(coup2+coup3))*MVWp2-(4._dp*coup1+coup2+coup3)*A0m2)
res = res +1* SumI  
End If 
!------------------------ 
! conj[VXp] 
!------------------------ 
If (((.not.OnlyHeavyStates).and.(.not.OnlyLightStates)) & 
  & .or.((OnlyHeavyStates).and.(MVXp2.gt.50._dp**2))   & 
  & .or.((OnlyLightStates).and.(MVXp2.lt.50._dp**2)) )   Then 
SumI = 0._dp 
A0m2 = 3._dp/4._dp*SA_DerA0(MVXp2) +RXi/4._dp*SA_DerA0(MVXp2*RXi) 
coup1 = cplcVXpVPVPVXp3
coup2 = cplcVXpVPVPVXp1
coup3 = cplcVXpVPVPVXp2
SumI = ((2._dp*DerrMS*coup1+(1-RXi**2)/8._dp*(coup2+coup3))*MVXp2-(4._dp*coup1+coup2+coup3)*A0m2)
res = res +1* SumI  
End If 
res = oo16pi2*res 
 
End Subroutine DerPi1LoopVP 
 
Subroutine OneLoopVZ(g1,g2,Vn,v1,v2,ZZ,Mhh,Mhh2,MAh,MAh2,MDpm,MDpm2,MFd,              & 
& MFd2,MFe,MFe2,MFu,MFu2,MVZ,MVZ2,MVZp,MVZp2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,           & 
& cplAhhhVZ,cplDpmcDpmVZ,cplcFdFdVZL,cplcFdFdVZR,cplcFeFeVZL,cplcFeFeVZR,cplcFuFuVZL,    & 
& cplcFuFuVZR,cplcFv1Fv1VZL,cplcFv1Fv1VZR,cplcgWpgWpVZ,cplcgWCgWCVZ,cplcgXp1gXp1VZ,      & 
& cplcgXp2gXp2VZ,cplhhVPVZ,cplhhVZVZ,cplhhVZVZp,cplHpmcHpmVZ,cplHpmVWpVZ,cplHpmVXpVZ,    & 
& cplcVWpVWpVZ,cplcVXpVXpVZ,cplAhAhVZVZ,cplDpmcDpmVZVZ,cplhhhhVZVZ,cplHpmcHpmVZVZ,       & 
& cplcVWpVWpVZVZ1,cplcVWpVWpVZVZ2,cplcVWpVWpVZVZ3,cplcVXpVXpVZVZ1,cplcVXpVXpVZVZ2,       & 
& cplcVXpVXpVZVZ3,delta,mass,mass2,kont)

Real(dp), Intent(in) :: Mhh(3),Mhh2(3),MAh(3),MAh2(3),MDpm(2),MDpm2(2),MFd(5),MFd2(5),MFe(3),MFe2(3),         & 
& MFu(4),MFu2(4),MVZ,MVZ2,MVZp,MVZp2,MHpm(4),MHpm2(4),MVWp,MVWp2,MVXp,MVXp2

Real(dp), Intent(in) :: g1,g2,Vn,v1,v2

Complex(dp), Intent(in) :: ZZ(3,3)

Complex(dp), Intent(in) :: cplAhhhVZ(3,3),cplDpmcDpmVZ(2,2),cplcFdFdVZL(5,5),cplcFdFdVZR(5,5),cplcFeFeVZL(3,3),  & 
& cplcFeFeVZR(3,3),cplcFuFuVZL(4,4),cplcFuFuVZR(4,4),cplcFv1Fv1VZL(3,3),cplcFv1Fv1VZR(3,3),& 
& cplcgWpgWpVZ,cplcgWCgWCVZ,cplcgXp1gXp1VZ,cplcgXp2gXp2VZ,cplhhVPVZ(3),cplhhVZVZ(3),     & 
& cplhhVZVZp(3),cplHpmcHpmVZ(4,4),cplHpmVWpVZ(4),cplHpmVXpVZ(4),cplcVWpVWpVZ,            & 
& cplcVXpVXpVZ,cplAhAhVZVZ(3,3),cplDpmcDpmVZVZ(2,2),cplhhhhVZVZ(3,3),cplHpmcHpmVZVZ(4,4),& 
& cplcVWpVWpVZVZ1,cplcVWpVWpVZVZ2,cplcVWpVWpVZVZ3,cplcVXpVXpVZVZ1,cplcVXpVXpVZVZ2,       & 
& cplcVXpVXpVZVZ3

Integer , Intent(inout):: kont 
Integer :: i1,i2,i3,i4,j1,j2,j3,j4,il,i_count, ierr 
Real(dp), Intent(in) :: delta 
Real(dp) :: mi, mi2, p2, test_m2 
Complex(dp) :: PiSf, SigL, SigR, SigSL, SigSR 
Real(dp), Intent(out) :: mass, mass2 
Iname = Iname + 1 
NameOfUnit(Iname) = 'OneLoopVZ'
 
mi2 = MVZ2 

 
p2 = MVZ2
PiSf = ZeroC 
Call Pi1LoopVZ(p2,Mhh,Mhh2,MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,MFe2,MFu,MFu2,            & 
& MVZ,MVZ2,MVZp,MVZp2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,cplAhhhVZ,cplDpmcDpmVZ,           & 
& cplcFdFdVZL,cplcFdFdVZR,cplcFeFeVZL,cplcFeFeVZR,cplcFuFuVZL,cplcFuFuVZR,               & 
& cplcFv1Fv1VZL,cplcFv1Fv1VZR,cplcgWpgWpVZ,cplcgWCgWCVZ,cplcgXp1gXp1VZ,cplcgXp2gXp2VZ,   & 
& cplhhVPVZ,cplhhVZVZ,cplhhVZVZp,cplHpmcHpmVZ,cplHpmVWpVZ,cplHpmVXpVZ,cplcVWpVWpVZ,      & 
& cplcVXpVXpVZ,cplAhAhVZVZ,cplDpmcDpmVZVZ,cplhhhhVZVZ,cplHpmcHpmVZVZ,cplcVWpVWpVZVZ1,    & 
& cplcVWpVWpVZVZ2,cplcVWpVWpVZVZ3,cplcVXpVXpVZVZ1,cplcVXpVXpVZVZ2,cplcVXpVXpVZVZ3,       & 
& kont,PiSf)

mass2 = mi2 + Real(PiSf,dp) 
mass = sqrt(mass2) 
i_count = 0 
Do  
i_count = i_count + 1 
test_m2 = mass2 
p2 =  mass2 
PiSf = ZeroC 
Call Pi1LoopVZ(p2,Mhh,Mhh2,MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,MFe2,MFu,MFu2,            & 
& MVZ,MVZ2,MVZp,MVZp2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,cplAhhhVZ,cplDpmcDpmVZ,           & 
& cplcFdFdVZL,cplcFdFdVZR,cplcFeFeVZL,cplcFeFeVZR,cplcFuFuVZL,cplcFuFuVZR,               & 
& cplcFv1Fv1VZL,cplcFv1Fv1VZR,cplcgWpgWpVZ,cplcgWCgWCVZ,cplcgXp1gXp1VZ,cplcgXp2gXp2VZ,   & 
& cplhhVPVZ,cplhhVZVZ,cplhhVZVZp,cplHpmcHpmVZ,cplHpmVWpVZ,cplHpmVXpVZ,cplcVWpVWpVZ,      & 
& cplcVXpVXpVZ,cplAhAhVZVZ,cplDpmcDpmVZVZ,cplhhhhVZVZ,cplHpmcHpmVZVZ,cplcVWpVWpVZVZ1,    & 
& cplcVWpVWpVZVZ2,cplcVWpVWpVZVZ3,cplcVXpVXpVZVZ1,cplcVXpVXpVZVZ2,cplcVXpVXpVZVZ3,       & 
& kont,PiSf)

mass2 = mi2 + Real(PiSf,dp) 
mass = sqrt(mass2) 
 If (test_m2.Ne.0._dp) Then 
    test_m2 = Abs(test_m2 - mass2) / test_m2 
 Else 
    test_m2 = Abs(mass2) 
 End If 
 If (mass2.Ge.0._dp) Then 
   If (RotateNegativeFermionMasses) Then 
    mass = sqrt(mass2) 
   End if 
  Else 
 If (Abs(mass2).lt.1.0E-30_dp) test_m2 = 0._dp 
     Write(ErrCan,*) 'Warning from routine'//NameOfUnit(Iname) 
     Write(ErrCan,*) 'in the calculation of the masses' 
     Write(ErrCan,*) 'occurred a negative mass squared!' 
   SignOfMassChanged = .True. 
   mass = 0._dp 
  End If 
If (test_m2.LT.0.1_dp*delta) Exit 
If (i_count.Gt.30) Then 
  Write(*,*) "Problem in "//NameOfUnit(Iname), test_m2, mass2 
  kont = -510 
  Call AddError(510) 
 Exit 
End If 
End Do 
 
 
Iname = Iname -1 
End Subroutine OneLoopVZ
 
 
Subroutine Pi1LoopVZ(p2,Mhh,Mhh2,MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,MFe2,               & 
& MFu,MFu2,MVZ,MVZ2,MVZp,MVZp2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,cplAhhhVZ,               & 
& cplDpmcDpmVZ,cplcFdFdVZL,cplcFdFdVZR,cplcFeFeVZL,cplcFeFeVZR,cplcFuFuVZL,              & 
& cplcFuFuVZR,cplcFv1Fv1VZL,cplcFv1Fv1VZR,cplcgWpgWpVZ,cplcgWCgWCVZ,cplcgXp1gXp1VZ,      & 
& cplcgXp2gXp2VZ,cplhhVPVZ,cplhhVZVZ,cplhhVZVZp,cplHpmcHpmVZ,cplHpmVWpVZ,cplHpmVXpVZ,    & 
& cplcVWpVWpVZ,cplcVXpVXpVZ,cplAhAhVZVZ,cplDpmcDpmVZVZ,cplhhhhVZVZ,cplHpmcHpmVZVZ,       & 
& cplcVWpVWpVZVZ1,cplcVWpVWpVZVZ2,cplcVWpVWpVZVZ3,cplcVXpVXpVZVZ1,cplcVXpVXpVZVZ2,       & 
& cplcVXpVXpVZVZ3,kont,res)

Implicit None 
Real(dp), Intent(in) :: Mhh(3),Mhh2(3),MAh(3),MAh2(3),MDpm(2),MDpm2(2),MFd(5),MFd2(5),MFe(3),MFe2(3),         & 
& MFu(4),MFu2(4),MVZ,MVZ2,MVZp,MVZp2,MHpm(4),MHpm2(4),MVWp,MVWp2,MVXp,MVXp2

Complex(dp), Intent(in) :: cplAhhhVZ(3,3),cplDpmcDpmVZ(2,2),cplcFdFdVZL(5,5),cplcFdFdVZR(5,5),cplcFeFeVZL(3,3),  & 
& cplcFeFeVZR(3,3),cplcFuFuVZL(4,4),cplcFuFuVZR(4,4),cplcFv1Fv1VZL(3,3),cplcFv1Fv1VZR(3,3),& 
& cplcgWpgWpVZ,cplcgWCgWCVZ,cplcgXp1gXp1VZ,cplcgXp2gXp2VZ,cplhhVPVZ(3),cplhhVZVZ(3),     & 
& cplhhVZVZp(3),cplHpmcHpmVZ(4,4),cplHpmVWpVZ(4),cplHpmVXpVZ(4),cplcVWpVWpVZ,            & 
& cplcVXpVXpVZ,cplAhAhVZVZ(3,3),cplDpmcDpmVZVZ(2,2),cplhhhhVZVZ(3,3),cplHpmcHpmVZVZ(4,4),& 
& cplcVWpVWpVZVZ1,cplcVWpVWpVZVZ2,cplcVWpVWpVZVZ3,cplcVXpVXpVZVZ1,cplcVXpVXpVZVZ2,       & 
& cplcVXpVXpVZVZ3

Integer, Intent(inout) :: kont 
Real(dp) :: B0m2, F0m2, G0m2, B1m2, H0m2, B22m2, m1, m2 
Real(dp), Intent(in) :: p2 
Complex(dp) :: A0m2, A0m12, A0m22 
Complex(dp), Intent(inout) :: res 
Complex(dp) :: coupL1, coupR1, coupL2,coupR2, coup1,coup2, coup3, temp, sumI 
Integer :: i1,i2,i3,i4, gO1, gO2, ierr 
 
 
res = 0._dp 
 
!------------------------ 
! hh, Ah 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 3
       Do i2 = 1, 3
 B22m2 = Real(VSSloop(p2,MAh2(i2),Mhh2(i1)),dp)  
coup1 = cplAhhhVZ(i2,i1)
    SumI = Abs(coup1)**2*B22m2 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! conj[Dpm], Dpm 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 2
       Do i2 = 1, 2
 B22m2 = Real(VSSloop(p2,MDpm2(i2),MDpm2(i1)),dp)  
coup1 = cplDpmcDpmVZ(i2,i1)
    SumI = Abs(coup1)**2*B22m2 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[Fd], Fd 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 5
       Do i2 = 1, 5
 H0m2 = Real(SA_Hloop(p2,MFd2(i1),MFd2(i2)),dp) 
B0m2 = 4._dp*MFd(i1)*MFd(i2)*Real(SA_B0(p2,MFd2(i1),MFd2(i2)),dp) 
coupL1 = cplcFdFdVZL(i1,i2)
coupR1 = cplcFdFdVZR(i1,i2)
    SumI = (Abs(coupL1)**2+Abs(coupR1)**2)*H0m2 & 
                & + (Real(Conjg(coupL1)*coupR1,dp))*B0m2 
res = res +3._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[Fe], Fe 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 3
       Do i2 = 1, 3
 H0m2 = Real(SA_Hloop(p2,MFe2(i1),MFe2(i2)),dp) 
B0m2 = 4._dp*MFe(i1)*MFe(i2)*Real(SA_B0(p2,MFe2(i1),MFe2(i2)),dp) 
coupL1 = cplcFeFeVZL(i1,i2)
coupR1 = cplcFeFeVZR(i1,i2)
    SumI = (Abs(coupL1)**2+Abs(coupR1)**2)*H0m2 & 
                & + (Real(Conjg(coupL1)*coupR1,dp))*B0m2 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[Fu], Fu 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
       Do i2 = 1, 4
 H0m2 = Real(SA_Hloop(p2,MFu2(i1),MFu2(i2)),dp) 
B0m2 = 4._dp*MFu(i1)*MFu(i2)*Real(SA_B0(p2,MFu2(i1),MFu2(i2)),dp) 
coupL1 = cplcFuFuVZL(i1,i2)
coupR1 = cplcFuFuVZR(i1,i2)
    SumI = (Abs(coupL1)**2+Abs(coupR1)**2)*H0m2 & 
                & + (Real(Conjg(coupL1)*coupR1,dp))*B0m2 
res = res +3._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[Fv1], Fv1 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 3
       Do i2 = 1, 3
 H0m2 = Real(SA_Hloop(p2,0._dp,0._dp),dp) 
B0m2 = 4._dp*0._dp*0._dp*Real(SA_B0(p2,0._dp,0._dp),dp) 
coupL1 = cplcFv1Fv1VZL(i1,i2)
coupR1 = cplcFv1Fv1VZR(i1,i2)
    SumI = (Abs(coupL1)**2+Abs(coupR1)**2)*H0m2 & 
                & + (Real(Conjg(coupL1)*coupR1,dp))*B0m2 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[gWp], gWp 
!------------------------ 
sumI = 0._dp 
 
SumI = 0._dp 
B0m2 = Real(VGGloop(p2,MVWp2,MVWp2),dp)
coup1 = cplcgWpgWpVZ
coup2 = Conjg(coup1) 
   SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
!------------------------ 
! bar[gWpC], gWpC 
!------------------------ 
sumI = 0._dp 
 
SumI = 0._dp 
B0m2 = Real(VGGloop(p2,MVWp2,MVWp2),dp)
coup1 = cplcgWCgWCVZ
coup2 = Conjg(coup1) 
   SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
!------------------------ 
! bar[gXp], gXp 
!------------------------ 
sumI = 0._dp 
 
SumI = 0._dp 
B0m2 = Real(VGGloop(p2,MVXp2,MVXp2),dp)
coup1 = cplcgXp1gXp1VZ
coup2 = Conjg(coup1) 
   SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
!------------------------ 
! bar[gXpC], gXpC 
!------------------------ 
sumI = 0._dp 
 
SumI = 0._dp 
B0m2 = Real(VGGloop(p2,MVXp2,MVXp2),dp)
coup1 = cplcgXp2gXp2VZ
coup2 = Conjg(coup1) 
   SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
!------------------------ 
! VP, hh 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 3
 B0m2 = Real(VVSloop(p2,0._dp,Mhh2(i2)),dp)
coup1 = cplhhVPVZ(i2)
    SumI = Abs(coup1)**2*B0m2 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! VZ, hh 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 3
 B0m2 = Real(VVSloop(p2,MVZ2,Mhh2(i2)),dp)
coup1 = cplhhVZVZ(i2)
    SumI = Abs(coup1)**2*B0m2 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! VZp, hh 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 3
 B0m2 = Real(VVSloop(p2,MVZp2,Mhh2(i2)),dp)
coup1 = cplhhVZVZp(i2)
    SumI = Abs(coup1)**2*B0m2 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! conj[Hpm], Hpm 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
       Do i2 = 1, 4
 B22m2 = Real(VSSloop(p2,MHpm2(i2),MHpm2(i1)),dp)  
coup1 = cplHpmcHpmVZ(i2,i1)
    SumI = Abs(coup1)**2*B22m2 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! VWp, Hpm 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 B0m2 = Real(VVSloop(p2,MVWp2,MHpm2(i2)),dp)
coup1 = cplHpmVWpVZ(i2)
    SumI = Abs(coup1)**2*B0m2 
res = res +2._dp* SumI  
    End Do 
 !------------------------ 
! VXp, Hpm 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 B0m2 = Real(VVSloop(p2,MVXp2,MHpm2(i2)),dp)
coup1 = cplHpmVXpVZ(i2)
    SumI = Abs(coup1)**2*B0m2 
res = res +2._dp* SumI  
    End Do 
 !------------------------ 
! conj[VWp], VWp 
!------------------------ 
sumI = 0._dp 
 
coup1 = cplcVWpVWpVZ
coup2 = Conjg(coup1) 
    SumI = -VVVloop(p2,MVWp2,MVWp2)*coup1*coup2 
res = res +1._dp* SumI  
!------------------------ 
! conj[VXp], VXp 
!------------------------ 
sumI = 0._dp 
 
coup1 = cplcVXpVXpVZ
coup2 = Conjg(coup1) 
    SumI = -VVVloop(p2,MVXp2,MVXp2)*coup1*coup2 
res = res +1._dp* SumI  
!------------------------ 
! Ah 
!------------------------ 
    Do i1 = 1, 3
 SumI = 0._dp 
 A0m2 = SA_A0(MAh2(i1))
 coup1 = cplAhAhVZVZ(i1,i1)
 SumI = coup1*A0m2 
res = res +1._dp/2._dp* SumI  
      End Do 
 !------------------------ 
! conj[Dpm] 
!------------------------ 
    Do i1 = 1, 2
 SumI = 0._dp 
 A0m2 = SA_A0(MDpm2(i1))
 coup1 = cplDpmcDpmVZVZ(i1,i1)
 SumI = coup1*A0m2 
res = res +1* SumI  
      End Do 
 !------------------------ 
! hh 
!------------------------ 
    Do i1 = 1, 3
 SumI = 0._dp 
 A0m2 = SA_A0(Mhh2(i1))
 coup1 = cplhhhhVZVZ(i1,i1)
 SumI = coup1*A0m2 
res = res +1._dp/2._dp* SumI  
      End Do 
 !------------------------ 
! conj[Hpm] 
!------------------------ 
    Do i1 = 1, 4
 SumI = 0._dp 
 A0m2 = SA_A0(MHpm2(i1))
 coup1 = cplHpmcHpmVZVZ(i1,i1)
 SumI = coup1*A0m2 
res = res +1* SumI  
      End Do 
 !------------------------ 
! conj[VWp] 
!------------------------ 
SumI = 0._dp 
A0m2 = 3._dp/4._dp*SA_A0(MVWp2) +RXi/4._dp*SA_A0(MVWp2*RXi) 
coup1 = cplcVWpVWpVZVZ1
coup2 = cplcVWpVWpVZVZ2
coup3 = cplcVWpVWpVZVZ3
SumI = ((2._dp*rMS*coup1+(1-RXi**2)/8._dp*(coup2+coup3))*MVWp2-(4._dp*coup1+coup2+coup3)*A0m2)
res = res +1* SumI  
!------------------------ 
! conj[VXp] 
!------------------------ 
SumI = 0._dp 
A0m2 = 3._dp/4._dp*SA_A0(MVXp2) +RXi/4._dp*SA_A0(MVXp2*RXi) 
coup1 = cplcVXpVXpVZVZ1
coup2 = cplcVXpVXpVZVZ2
coup3 = cplcVXpVXpVZVZ3
SumI = ((2._dp*rMS*coup1+(1-RXi**2)/8._dp*(coup2+coup3))*MVXp2-(4._dp*coup1+coup2+coup3)*A0m2)
res = res +1* SumI  
res = oo16pi2*res 
 
End Subroutine Pi1LoopVZ 
 
Subroutine DerPi1LoopVZ(p2,Mhh,Mhh2,MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,MFe2,            & 
& MFu,MFu2,MVZ,MVZ2,MVZp,MVZp2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,cplAhhhVZ,               & 
& cplDpmcDpmVZ,cplcFdFdVZL,cplcFdFdVZR,cplcFeFeVZL,cplcFeFeVZR,cplcFuFuVZL,              & 
& cplcFuFuVZR,cplcFv1Fv1VZL,cplcFv1Fv1VZR,cplcgWpgWpVZ,cplcgWCgWCVZ,cplcgXp1gXp1VZ,      & 
& cplcgXp2gXp2VZ,cplhhVPVZ,cplhhVZVZ,cplhhVZVZp,cplHpmcHpmVZ,cplHpmVWpVZ,cplHpmVXpVZ,    & 
& cplcVWpVWpVZ,cplcVXpVXpVZ,cplAhAhVZVZ,cplDpmcDpmVZVZ,cplhhhhVZVZ,cplHpmcHpmVZVZ,       & 
& cplcVWpVWpVZVZ1,cplcVWpVWpVZVZ2,cplcVWpVWpVZVZ3,cplcVXpVXpVZVZ1,cplcVXpVXpVZVZ2,       & 
& cplcVXpVXpVZVZ3,kont,res)

Implicit None 
Real(dp), Intent(in) :: Mhh(3),Mhh2(3),MAh(3),MAh2(3),MDpm(2),MDpm2(2),MFd(5),MFd2(5),MFe(3),MFe2(3),         & 
& MFu(4),MFu2(4),MVZ,MVZ2,MVZp,MVZp2,MHpm(4),MHpm2(4),MVWp,MVWp2,MVXp,MVXp2

Complex(dp), Intent(in) :: cplAhhhVZ(3,3),cplDpmcDpmVZ(2,2),cplcFdFdVZL(5,5),cplcFdFdVZR(5,5),cplcFeFeVZL(3,3),  & 
& cplcFeFeVZR(3,3),cplcFuFuVZL(4,4),cplcFuFuVZR(4,4),cplcFv1Fv1VZL(3,3),cplcFv1Fv1VZR(3,3),& 
& cplcgWpgWpVZ,cplcgWCgWCVZ,cplcgXp1gXp1VZ,cplcgXp2gXp2VZ,cplhhVPVZ(3),cplhhVZVZ(3),     & 
& cplhhVZVZp(3),cplHpmcHpmVZ(4,4),cplHpmVWpVZ(4),cplHpmVXpVZ(4),cplcVWpVWpVZ,            & 
& cplcVXpVXpVZ,cplAhAhVZVZ(3,3),cplDpmcDpmVZVZ(2,2),cplhhhhVZVZ(3,3),cplHpmcHpmVZVZ(4,4),& 
& cplcVWpVWpVZVZ1,cplcVWpVWpVZVZ2,cplcVWpVWpVZVZ3,cplcVXpVXpVZVZ1,cplcVXpVXpVZVZ2,       & 
& cplcVXpVXpVZVZ3

Integer, Intent(inout) :: kont 
Real(dp) :: B0m2, F0m2, G0m2, B1m2, H0m2, B22m2, m1, m2 
Real(dp), Intent(in) :: p2 
Complex(dp) :: A0m2, A0m12, A0m22 
Complex(dp), Intent(inout) :: res 
Complex(dp) :: coupL1, coupR1, coupL2,coupR2, coup1,coup2, coup3, temp, sumI 
Integer :: i1,i2,i3,i4, gO1, gO2, ierr 
 
 
Real(dp) ::MVG,MVP,MVG2,MVP2
MVG = Mass_Regulator_PhotonGluon 
MVP = Mass_Regulator_PhotonGluon 
MVG2 = Mass_Regulator_PhotonGluon**2 
MVP2 = Mass_Regulator_PhotonGluon**2 

res = 0._dp 
 
!------------------------ 
! hh, Ah 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 3
       Do i2 = 1, 3
 B22m2 = Real(DerVSSloop(p2,MAh2(i2),Mhh2(i1)),dp)  
coup1 = cplAhhhVZ(i2,i1)
    SumI = Abs(coup1)**2*B22m2 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! conj[Dpm], Dpm 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 2
       Do i2 = 1, 2
 B22m2 = Real(DerVSSloop(p2,MDpm2(i2),MDpm2(i1)),dp)  
coup1 = cplDpmcDpmVZ(i2,i1)
    SumI = Abs(coup1)**2*B22m2 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[Fd], Fd 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 5
       Do i2 = 1, 5
 H0m2 = Real(SA_DerHloop(p2,MFd2(i1),MFd2(i2)),dp) 
B0m2 = 4._dp*MFd(i1)*MFd(i2)*Real(SA_DerB0(p2,MFd2(i1),MFd2(i2)),dp) 
coupL1 = cplcFdFdVZL(i1,i2)
coupR1 = cplcFdFdVZR(i1,i2)
    SumI = (Abs(coupL1)**2+Abs(coupR1)**2)*H0m2 & 
                & + (Real(Conjg(coupL1)*coupR1,dp))*B0m2 
res = res +3._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[Fe], Fe 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 3
       Do i2 = 1, 3
 H0m2 = Real(SA_DerHloop(p2,MFe2(i1),MFe2(i2)),dp) 
B0m2 = 4._dp*MFe(i1)*MFe(i2)*Real(SA_DerB0(p2,MFe2(i1),MFe2(i2)),dp) 
coupL1 = cplcFeFeVZL(i1,i2)
coupR1 = cplcFeFeVZR(i1,i2)
    SumI = (Abs(coupL1)**2+Abs(coupR1)**2)*H0m2 & 
                & + (Real(Conjg(coupL1)*coupR1,dp))*B0m2 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[Fu], Fu 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
       Do i2 = 1, 4
 H0m2 = Real(SA_DerHloop(p2,MFu2(i1),MFu2(i2)),dp) 
B0m2 = 4._dp*MFu(i1)*MFu(i2)*Real(SA_DerB0(p2,MFu2(i1),MFu2(i2)),dp) 
coupL1 = cplcFuFuVZL(i1,i2)
coupR1 = cplcFuFuVZR(i1,i2)
    SumI = (Abs(coupL1)**2+Abs(coupR1)**2)*H0m2 & 
                & + (Real(Conjg(coupL1)*coupR1,dp))*B0m2 
res = res +3._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[Fv1], Fv1 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 3
       Do i2 = 1, 3
 H0m2 = Real(SA_DerHloop(p2,0._dp,0._dp),dp) 
B0m2 = 4._dp*0._dp*0._dp*Real(SA_DerB0(p2,0._dp,0._dp),dp) 
coupL1 = cplcFv1Fv1VZL(i1,i2)
coupR1 = cplcFv1Fv1VZR(i1,i2)
    SumI = (Abs(coupL1)**2+Abs(coupR1)**2)*H0m2 & 
                & + (Real(Conjg(coupL1)*coupR1,dp))*B0m2 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[gWp], gWp 
!------------------------ 
sumI = 0._dp 
 
SumI = 0._dp 
B0m2 = Real(DerVGGloop(p2,MVWp2,MVWp2),dp)
coup1 = cplcgWpgWpVZ
coup2 = Conjg(coup1) 
   SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
!------------------------ 
! bar[gWpC], gWpC 
!------------------------ 
sumI = 0._dp 
 
SumI = 0._dp 
B0m2 = Real(DerVGGloop(p2,MVWp2,MVWp2),dp)
coup1 = cplcgWCgWCVZ
coup2 = Conjg(coup1) 
   SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
!------------------------ 
! bar[gXp], gXp 
!------------------------ 
sumI = 0._dp 
 
SumI = 0._dp 
B0m2 = Real(DerVGGloop(p2,MVXp2,MVXp2),dp)
coup1 = cplcgXp1gXp1VZ
coup2 = Conjg(coup1) 
   SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
!------------------------ 
! bar[gXpC], gXpC 
!------------------------ 
sumI = 0._dp 
 
SumI = 0._dp 
B0m2 = Real(DerVGGloop(p2,MVXp2,MVXp2),dp)
coup1 = cplcgXp2gXp2VZ
coup2 = Conjg(coup1) 
   SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
!------------------------ 
! VP, hh 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 3
 B0m2 = Real(DerVVSloop(p2,MVP2,Mhh2(i2)),dp)
coup1 = cplhhVPVZ(i2)
    SumI = Abs(coup1)**2*B0m2 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! VZ, hh 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 3
 B0m2 = Real(DerVVSloop(p2,MVZ2,Mhh2(i2)),dp)
coup1 = cplhhVZVZ(i2)
    SumI = Abs(coup1)**2*B0m2 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! VZp, hh 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 3
 B0m2 = Real(DerVVSloop(p2,MVZp2,Mhh2(i2)),dp)
coup1 = cplhhVZVZp(i2)
    SumI = Abs(coup1)**2*B0m2 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! conj[Hpm], Hpm 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
       Do i2 = 1, 4
 B22m2 = Real(DerVSSloop(p2,MHpm2(i2),MHpm2(i1)),dp)  
coup1 = cplHpmcHpmVZ(i2,i1)
    SumI = Abs(coup1)**2*B22m2 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! VWp, Hpm 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 B0m2 = Real(DerVVSloop(p2,MVWp2,MHpm2(i2)),dp)
coup1 = cplHpmVWpVZ(i2)
    SumI = Abs(coup1)**2*B0m2 
res = res +2._dp* SumI  
    End Do 
 !------------------------ 
! VXp, Hpm 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 B0m2 = Real(DerVVSloop(p2,MVXp2,MHpm2(i2)),dp)
coup1 = cplHpmVXpVZ(i2)
    SumI = Abs(coup1)**2*B0m2 
res = res +2._dp* SumI  
    End Do 
 !------------------------ 
! conj[VWp], VWp 
!------------------------ 
sumI = 0._dp 
 
coup1 = cplcVWpVWpVZ
coup2 = Conjg(coup1) 
    SumI = -DerVVVloop(p2,MVWp2,MVWp2)*coup1*coup2 
res = res +1._dp* SumI  
!------------------------ 
! conj[VXp], VXp 
!------------------------ 
sumI = 0._dp 
 
coup1 = cplcVXpVXpVZ
coup2 = Conjg(coup1) 
    SumI = -DerVVVloop(p2,MVXp2,MVXp2)*coup1*coup2 
res = res +1._dp* SumI  
!------------------------ 
! Ah 
!------------------------ 
    Do i1 = 1, 3
 SumI = 0._dp 
 A0m2 = SA_DerA0(MAh2(i1))
 coup1 = cplAhAhVZVZ(i1,i1)
 SumI = coup1*A0m2 
res = res +1._dp/2._dp* SumI  
      End Do 
 !------------------------ 
! conj[Dpm] 
!------------------------ 
    Do i1 = 1, 2
 SumI = 0._dp 
 A0m2 = SA_DerA0(MDpm2(i1))
 coup1 = cplDpmcDpmVZVZ(i1,i1)
 SumI = coup1*A0m2 
res = res +1* SumI  
      End Do 
 !------------------------ 
! hh 
!------------------------ 
    Do i1 = 1, 3
 SumI = 0._dp 
 A0m2 = SA_DerA0(Mhh2(i1))
 coup1 = cplhhhhVZVZ(i1,i1)
 SumI = coup1*A0m2 
res = res +1._dp/2._dp* SumI  
      End Do 
 !------------------------ 
! conj[Hpm] 
!------------------------ 
    Do i1 = 1, 4
 SumI = 0._dp 
 A0m2 = SA_DerA0(MHpm2(i1))
 coup1 = cplHpmcHpmVZVZ(i1,i1)
 SumI = coup1*A0m2 
res = res +1* SumI  
      End Do 
 !------------------------ 
! conj[VWp] 
!------------------------ 
SumI = 0._dp 
A0m2 = 3._dp/4._dp*SA_DerA0(MVWp2) +RXi/4._dp*SA_DerA0(MVWp2*RXi) 
coup1 = cplcVWpVWpVZVZ1
coup2 = cplcVWpVWpVZVZ2
coup3 = cplcVWpVWpVZVZ3
SumI = ((2._dp*DerrMS*coup1+(1-RXi**2)/8._dp*(coup2+coup3))*MVWp2-(4._dp*coup1+coup2+coup3)*A0m2)
res = res +1* SumI  
!------------------------ 
! conj[VXp] 
!------------------------ 
SumI = 0._dp 
A0m2 = 3._dp/4._dp*SA_DerA0(MVXp2) +RXi/4._dp*SA_DerA0(MVXp2*RXi) 
coup1 = cplcVXpVXpVZVZ1
coup2 = cplcVXpVXpVZVZ2
coup3 = cplcVXpVXpVZVZ3
SumI = ((2._dp*DerrMS*coup1+(1-RXi**2)/8._dp*(coup2+coup3))*MVXp2-(4._dp*coup1+coup2+coup3)*A0m2)
res = res +1* SumI  
res = oo16pi2*res 
 
End Subroutine DerPi1LoopVZ 
 
Subroutine OneLoopVZp(g1,g2,Vn,v1,v2,ZZ,Mhh,Mhh2,MAh,MAh2,MDpm,MDpm2,MFd,             & 
& MFd2,MFe,MFe2,MFu,MFu2,MVZ,MVZ2,MVZp,MVZp2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,           & 
& cplAhhhVZp,cplDpmcDpmVZp,cplcFdFdVZpL,cplcFdFdVZpR,cplcFeFeVZpL,cplcFeFeVZpR,          & 
& cplcFuFuVZpL,cplcFuFuVZpR,cplcFv1Fv1VZpL,cplcFv1Fv1VZpR,cplcgWpgWpVZp,cplcgWCgWCVZp,   & 
& cplcgXp1gXp1VZp,cplcgXp2gXp2VZp,cplhhVPVZp,cplhhVZVZp,cplhhVZpVZp,cplHpmcHpmVZp,       & 
& cplHpmVWpVZp,cplHpmVXpVZp,cplcVWpVWpVZp,cplcVXpVXpVZp,cplAhAhVZpVZp,cplDpmcDpmVZpVZp,  & 
& cplhhhhVZpVZp,cplHpmcHpmVZpVZp,cplcVWpVWpVZpVZp1,cplcVWpVWpVZpVZp2,cplcVWpVWpVZpVZp3,  & 
& cplcVXpVXpVZpVZp1,cplcVXpVXpVZpVZp2,cplcVXpVXpVZpVZp3,delta,mass,mass2,kont)

Real(dp), Intent(in) :: Mhh(3),Mhh2(3),MAh(3),MAh2(3),MDpm(2),MDpm2(2),MFd(5),MFd2(5),MFe(3),MFe2(3),         & 
& MFu(4),MFu2(4),MVZ,MVZ2,MVZp,MVZp2,MHpm(4),MHpm2(4),MVWp,MVWp2,MVXp,MVXp2

Real(dp), Intent(in) :: g1,g2,Vn,v1,v2

Complex(dp), Intent(in) :: ZZ(3,3)

Complex(dp), Intent(in) :: cplAhhhVZp(3,3),cplDpmcDpmVZp(2,2),cplcFdFdVZpL(5,5),cplcFdFdVZpR(5,5),               & 
& cplcFeFeVZpL(3,3),cplcFeFeVZpR(3,3),cplcFuFuVZpL(4,4),cplcFuFuVZpR(4,4),               & 
& cplcFv1Fv1VZpL(3,3),cplcFv1Fv1VZpR(3,3),cplcgWpgWpVZp,cplcgWCgWCVZp,cplcgXp1gXp1VZp,   & 
& cplcgXp2gXp2VZp,cplhhVPVZp(3),cplhhVZVZp(3),cplhhVZpVZp(3),cplHpmcHpmVZp(4,4),         & 
& cplHpmVWpVZp(4),cplHpmVXpVZp(4),cplcVWpVWpVZp,cplcVXpVXpVZp,cplAhAhVZpVZp(3,3),        & 
& cplDpmcDpmVZpVZp(2,2),cplhhhhVZpVZp(3,3),cplHpmcHpmVZpVZp(4,4),cplcVWpVWpVZpVZp1,      & 
& cplcVWpVWpVZpVZp2,cplcVWpVWpVZpVZp3,cplcVXpVXpVZpVZp1,cplcVXpVXpVZpVZp2,               & 
& cplcVXpVXpVZpVZp3

Integer , Intent(inout):: kont 
Integer :: i1,i2,i3,i4,j1,j2,j3,j4,il,i_count, ierr 
Real(dp), Intent(in) :: delta 
Real(dp) :: mi, mi2, p2, test_m2 
Complex(dp) :: PiSf, SigL, SigR, SigSL, SigSR 
Real(dp), Intent(out) :: mass, mass2 
Iname = Iname + 1 
NameOfUnit(Iname) = 'OneLoopVZp'
 
mi2 = MVZp2 

 
p2 = MVZp2
PiSf = ZeroC 
Call Pi1LoopVZp(p2,Mhh,Mhh2,MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,MFe2,MFu,MFu2,           & 
& MVZ,MVZ2,MVZp,MVZp2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,cplAhhhVZp,cplDpmcDpmVZp,         & 
& cplcFdFdVZpL,cplcFdFdVZpR,cplcFeFeVZpL,cplcFeFeVZpR,cplcFuFuVZpL,cplcFuFuVZpR,         & 
& cplcFv1Fv1VZpL,cplcFv1Fv1VZpR,cplcgWpgWpVZp,cplcgWCgWCVZp,cplcgXp1gXp1VZp,             & 
& cplcgXp2gXp2VZp,cplhhVPVZp,cplhhVZVZp,cplhhVZpVZp,cplHpmcHpmVZp,cplHpmVWpVZp,          & 
& cplHpmVXpVZp,cplcVWpVWpVZp,cplcVXpVXpVZp,cplAhAhVZpVZp,cplDpmcDpmVZpVZp,               & 
& cplhhhhVZpVZp,cplHpmcHpmVZpVZp,cplcVWpVWpVZpVZp1,cplcVWpVWpVZpVZp2,cplcVWpVWpVZpVZp3,  & 
& cplcVXpVXpVZpVZp1,cplcVXpVXpVZpVZp2,cplcVXpVXpVZpVZp3,kont,PiSf)

mass2 = mi2 + Real(PiSf,dp) 
mass = sqrt(mass2) 
i_count = 0 
Do  
i_count = i_count + 1 
test_m2 = mass2 
p2 =  mass2 
PiSf = ZeroC 
Call Pi1LoopVZp(p2,Mhh,Mhh2,MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,MFe2,MFu,MFu2,           & 
& MVZ,MVZ2,MVZp,MVZp2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,cplAhhhVZp,cplDpmcDpmVZp,         & 
& cplcFdFdVZpL,cplcFdFdVZpR,cplcFeFeVZpL,cplcFeFeVZpR,cplcFuFuVZpL,cplcFuFuVZpR,         & 
& cplcFv1Fv1VZpL,cplcFv1Fv1VZpR,cplcgWpgWpVZp,cplcgWCgWCVZp,cplcgXp1gXp1VZp,             & 
& cplcgXp2gXp2VZp,cplhhVPVZp,cplhhVZVZp,cplhhVZpVZp,cplHpmcHpmVZp,cplHpmVWpVZp,          & 
& cplHpmVXpVZp,cplcVWpVWpVZp,cplcVXpVXpVZp,cplAhAhVZpVZp,cplDpmcDpmVZpVZp,               & 
& cplhhhhVZpVZp,cplHpmcHpmVZpVZp,cplcVWpVWpVZpVZp1,cplcVWpVWpVZpVZp2,cplcVWpVWpVZpVZp3,  & 
& cplcVXpVXpVZpVZp1,cplcVXpVXpVZpVZp2,cplcVXpVXpVZpVZp3,kont,PiSf)

mass2 = mi2 + Real(PiSf,dp) 
mass = sqrt(mass2) 
 If (test_m2.Ne.0._dp) Then 
    test_m2 = Abs(test_m2 - mass2) / test_m2 
 Else 
    test_m2 = Abs(mass2) 
 End If 
 If (mass2.Ge.0._dp) Then 
   If (RotateNegativeFermionMasses) Then 
    mass = sqrt(mass2) 
   End if 
  Else 
 If (Abs(mass2).lt.1.0E-30_dp) test_m2 = 0._dp 
     Write(ErrCan,*) 'Warning from routine'//NameOfUnit(Iname) 
     Write(ErrCan,*) 'in the calculation of the masses' 
     Write(ErrCan,*) 'occurred a negative mass squared!' 
   SignOfMassChanged = .True. 
   mass = 0._dp 
  End If 
If (test_m2.LT.0.1_dp*delta) Exit 
If (i_count.Gt.30) Then 
  Write(*,*) "Problem in "//NameOfUnit(Iname), test_m2, mass2 
  kont = -510 
  Call AddError(510) 
 Exit 
End If 
End Do 
 
 
Iname = Iname -1 
End Subroutine OneLoopVZp
 
 
Subroutine Pi1LoopVZp(p2,Mhh,Mhh2,MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,MFe2,              & 
& MFu,MFu2,MVZ,MVZ2,MVZp,MVZp2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,cplAhhhVZp,              & 
& cplDpmcDpmVZp,cplcFdFdVZpL,cplcFdFdVZpR,cplcFeFeVZpL,cplcFeFeVZpR,cplcFuFuVZpL,        & 
& cplcFuFuVZpR,cplcFv1Fv1VZpL,cplcFv1Fv1VZpR,cplcgWpgWpVZp,cplcgWCgWCVZp,cplcgXp1gXp1VZp,& 
& cplcgXp2gXp2VZp,cplhhVPVZp,cplhhVZVZp,cplhhVZpVZp,cplHpmcHpmVZp,cplHpmVWpVZp,          & 
& cplHpmVXpVZp,cplcVWpVWpVZp,cplcVXpVXpVZp,cplAhAhVZpVZp,cplDpmcDpmVZpVZp,               & 
& cplhhhhVZpVZp,cplHpmcHpmVZpVZp,cplcVWpVWpVZpVZp1,cplcVWpVWpVZpVZp2,cplcVWpVWpVZpVZp3,  & 
& cplcVXpVXpVZpVZp1,cplcVXpVXpVZpVZp2,cplcVXpVXpVZpVZp3,kont,res)

Implicit None 
Real(dp), Intent(in) :: Mhh(3),Mhh2(3),MAh(3),MAh2(3),MDpm(2),MDpm2(2),MFd(5),MFd2(5),MFe(3),MFe2(3),         & 
& MFu(4),MFu2(4),MVZ,MVZ2,MVZp,MVZp2,MHpm(4),MHpm2(4),MVWp,MVWp2,MVXp,MVXp2

Complex(dp), Intent(in) :: cplAhhhVZp(3,3),cplDpmcDpmVZp(2,2),cplcFdFdVZpL(5,5),cplcFdFdVZpR(5,5),               & 
& cplcFeFeVZpL(3,3),cplcFeFeVZpR(3,3),cplcFuFuVZpL(4,4),cplcFuFuVZpR(4,4),               & 
& cplcFv1Fv1VZpL(3,3),cplcFv1Fv1VZpR(3,3),cplcgWpgWpVZp,cplcgWCgWCVZp,cplcgXp1gXp1VZp,   & 
& cplcgXp2gXp2VZp,cplhhVPVZp(3),cplhhVZVZp(3),cplhhVZpVZp(3),cplHpmcHpmVZp(4,4),         & 
& cplHpmVWpVZp(4),cplHpmVXpVZp(4),cplcVWpVWpVZp,cplcVXpVXpVZp,cplAhAhVZpVZp(3,3),        & 
& cplDpmcDpmVZpVZp(2,2),cplhhhhVZpVZp(3,3),cplHpmcHpmVZpVZp(4,4),cplcVWpVWpVZpVZp1,      & 
& cplcVWpVWpVZpVZp2,cplcVWpVWpVZpVZp3,cplcVXpVXpVZpVZp1,cplcVXpVXpVZpVZp2,               & 
& cplcVXpVXpVZpVZp3

Integer, Intent(inout) :: kont 
Real(dp) :: B0m2, F0m2, G0m2, B1m2, H0m2, B22m2, m1, m2 
Real(dp), Intent(in) :: p2 
Complex(dp) :: A0m2, A0m12, A0m22 
Complex(dp), Intent(inout) :: res 
Complex(dp) :: coupL1, coupR1, coupL2,coupR2, coup1,coup2, coup3, temp, sumI 
Integer :: i1,i2,i3,i4, gO1, gO2, ierr 
 
 
res = 0._dp 
 
!------------------------ 
! hh, Ah 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 3
       Do i2 = 1, 3
 B22m2 = Real(VSSloop(p2,MAh2(i2),Mhh2(i1)),dp)  
coup1 = cplAhhhVZp(i2,i1)
    SumI = Abs(coup1)**2*B22m2 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! conj[Dpm], Dpm 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 2
       Do i2 = 1, 2
 B22m2 = Real(VSSloop(p2,MDpm2(i2),MDpm2(i1)),dp)  
coup1 = cplDpmcDpmVZp(i2,i1)
    SumI = Abs(coup1)**2*B22m2 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[Fd], Fd 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 5
       Do i2 = 1, 5
 H0m2 = Real(SA_Hloop(p2,MFd2(i1),MFd2(i2)),dp) 
B0m2 = 4._dp*MFd(i1)*MFd(i2)*Real(SA_B0(p2,MFd2(i1),MFd2(i2)),dp) 
coupL1 = cplcFdFdVZpL(i1,i2)
coupR1 = cplcFdFdVZpR(i1,i2)
    SumI = (Abs(coupL1)**2+Abs(coupR1)**2)*H0m2 & 
                & + (Real(Conjg(coupL1)*coupR1,dp))*B0m2 
res = res +3._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[Fe], Fe 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 3
       Do i2 = 1, 3
 H0m2 = Real(SA_Hloop(p2,MFe2(i1),MFe2(i2)),dp) 
B0m2 = 4._dp*MFe(i1)*MFe(i2)*Real(SA_B0(p2,MFe2(i1),MFe2(i2)),dp) 
coupL1 = cplcFeFeVZpL(i1,i2)
coupR1 = cplcFeFeVZpR(i1,i2)
    SumI = (Abs(coupL1)**2+Abs(coupR1)**2)*H0m2 & 
                & + (Real(Conjg(coupL1)*coupR1,dp))*B0m2 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[Fu], Fu 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
       Do i2 = 1, 4
 H0m2 = Real(SA_Hloop(p2,MFu2(i1),MFu2(i2)),dp) 
B0m2 = 4._dp*MFu(i1)*MFu(i2)*Real(SA_B0(p2,MFu2(i1),MFu2(i2)),dp) 
coupL1 = cplcFuFuVZpL(i1,i2)
coupR1 = cplcFuFuVZpR(i1,i2)
    SumI = (Abs(coupL1)**2+Abs(coupR1)**2)*H0m2 & 
                & + (Real(Conjg(coupL1)*coupR1,dp))*B0m2 
res = res +3._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[Fv1], Fv1 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 3
       Do i2 = 1, 3
 H0m2 = Real(SA_Hloop(p2,0._dp,0._dp),dp) 
B0m2 = 4._dp*0._dp*0._dp*Real(SA_B0(p2,0._dp,0._dp),dp) 
coupL1 = cplcFv1Fv1VZpL(i1,i2)
coupR1 = cplcFv1Fv1VZpR(i1,i2)
    SumI = (Abs(coupL1)**2+Abs(coupR1)**2)*H0m2 & 
                & + (Real(Conjg(coupL1)*coupR1,dp))*B0m2 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[gWp], gWp 
!------------------------ 
sumI = 0._dp 
 
SumI = 0._dp 
B0m2 = Real(VGGloop(p2,MVWp2,MVWp2),dp)
coup1 = cplcgWpgWpVZp
coup2 = Conjg(coup1) 
   SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
!------------------------ 
! bar[gWpC], gWpC 
!------------------------ 
sumI = 0._dp 
 
SumI = 0._dp 
B0m2 = Real(VGGloop(p2,MVWp2,MVWp2),dp)
coup1 = cplcgWCgWCVZp
coup2 = Conjg(coup1) 
   SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
!------------------------ 
! bar[gXp], gXp 
!------------------------ 
sumI = 0._dp 
 
SumI = 0._dp 
B0m2 = Real(VGGloop(p2,MVXp2,MVXp2),dp)
coup1 = cplcgXp1gXp1VZp
coup2 = Conjg(coup1) 
   SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
!------------------------ 
! bar[gXpC], gXpC 
!------------------------ 
sumI = 0._dp 
 
SumI = 0._dp 
B0m2 = Real(VGGloop(p2,MVXp2,MVXp2),dp)
coup1 = cplcgXp2gXp2VZp
coup2 = Conjg(coup1) 
   SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
!------------------------ 
! VP, hh 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 3
 B0m2 = Real(VVSloop(p2,0._dp,Mhh2(i2)),dp)
coup1 = cplhhVPVZp(i2)
    SumI = Abs(coup1)**2*B0m2 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! VZ, hh 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 3
 B0m2 = Real(VVSloop(p2,MVZ2,Mhh2(i2)),dp)
coup1 = cplhhVZVZp(i2)
    SumI = Abs(coup1)**2*B0m2 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! VZp, hh 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 3
 B0m2 = Real(VVSloop(p2,MVZp2,Mhh2(i2)),dp)
coup1 = cplhhVZpVZp(i2)
    SumI = Abs(coup1)**2*B0m2 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! conj[Hpm], Hpm 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
       Do i2 = 1, 4
 B22m2 = Real(VSSloop(p2,MHpm2(i2),MHpm2(i1)),dp)  
coup1 = cplHpmcHpmVZp(i2,i1)
    SumI = Abs(coup1)**2*B22m2 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! VWp, Hpm 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 B0m2 = Real(VVSloop(p2,MVWp2,MHpm2(i2)),dp)
coup1 = cplHpmVWpVZp(i2)
    SumI = Abs(coup1)**2*B0m2 
res = res +2._dp* SumI  
    End Do 
 !------------------------ 
! VXp, Hpm 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 B0m2 = Real(VVSloop(p2,MVXp2,MHpm2(i2)),dp)
coup1 = cplHpmVXpVZp(i2)
    SumI = Abs(coup1)**2*B0m2 
res = res +2._dp* SumI  
    End Do 
 !------------------------ 
! conj[VWp], VWp 
!------------------------ 
sumI = 0._dp 
 
coup1 = cplcVWpVWpVZp
coup2 = Conjg(coup1) 
    SumI = -VVVloop(p2,MVWp2,MVWp2)*coup1*coup2 
res = res +1._dp* SumI  
!------------------------ 
! conj[VXp], VXp 
!------------------------ 
sumI = 0._dp 
 
coup1 = cplcVXpVXpVZp
coup2 = Conjg(coup1) 
    SumI = -VVVloop(p2,MVXp2,MVXp2)*coup1*coup2 
res = res +1._dp* SumI  
!------------------------ 
! Ah 
!------------------------ 
    Do i1 = 1, 3
 SumI = 0._dp 
 A0m2 = SA_A0(MAh2(i1))
 coup1 = cplAhAhVZpVZp(i1,i1)
 SumI = coup1*A0m2 
res = res +1._dp/2._dp* SumI  
      End Do 
 !------------------------ 
! conj[Dpm] 
!------------------------ 
    Do i1 = 1, 2
 SumI = 0._dp 
 A0m2 = SA_A0(MDpm2(i1))
 coup1 = cplDpmcDpmVZpVZp(i1,i1)
 SumI = coup1*A0m2 
res = res +1* SumI  
      End Do 
 !------------------------ 
! hh 
!------------------------ 
    Do i1 = 1, 3
 SumI = 0._dp 
 A0m2 = SA_A0(Mhh2(i1))
 coup1 = cplhhhhVZpVZp(i1,i1)
 SumI = coup1*A0m2 
res = res +1._dp/2._dp* SumI  
      End Do 
 !------------------------ 
! conj[Hpm] 
!------------------------ 
    Do i1 = 1, 4
 SumI = 0._dp 
 A0m2 = SA_A0(MHpm2(i1))
 coup1 = cplHpmcHpmVZpVZp(i1,i1)
 SumI = coup1*A0m2 
res = res +1* SumI  
      End Do 
 !------------------------ 
! conj[VWp] 
!------------------------ 
SumI = 0._dp 
A0m2 = 3._dp/4._dp*SA_A0(MVWp2) +RXi/4._dp*SA_A0(MVWp2*RXi) 
coup1 = cplcVWpVWpVZpVZp1
coup2 = cplcVWpVWpVZpVZp2
coup3 = cplcVWpVWpVZpVZp3
SumI = ((2._dp*rMS*coup1+(1-RXi**2)/8._dp*(coup2+coup3))*MVWp2-(4._dp*coup1+coup2+coup3)*A0m2)
res = res +1* SumI  
!------------------------ 
! conj[VXp] 
!------------------------ 
SumI = 0._dp 
A0m2 = 3._dp/4._dp*SA_A0(MVXp2) +RXi/4._dp*SA_A0(MVXp2*RXi) 
coup1 = cplcVXpVXpVZpVZp1
coup2 = cplcVXpVXpVZpVZp2
coup3 = cplcVXpVXpVZpVZp3
SumI = ((2._dp*rMS*coup1+(1-RXi**2)/8._dp*(coup2+coup3))*MVXp2-(4._dp*coup1+coup2+coup3)*A0m2)
res = res +1* SumI  
res = oo16pi2*res 
 
End Subroutine Pi1LoopVZp 
 
Subroutine DerPi1LoopVZp(p2,Mhh,Mhh2,MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,MFe2,           & 
& MFu,MFu2,MVZ,MVZ2,MVZp,MVZp2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,cplAhhhVZp,              & 
& cplDpmcDpmVZp,cplcFdFdVZpL,cplcFdFdVZpR,cplcFeFeVZpL,cplcFeFeVZpR,cplcFuFuVZpL,        & 
& cplcFuFuVZpR,cplcFv1Fv1VZpL,cplcFv1Fv1VZpR,cplcgWpgWpVZp,cplcgWCgWCVZp,cplcgXp1gXp1VZp,& 
& cplcgXp2gXp2VZp,cplhhVPVZp,cplhhVZVZp,cplhhVZpVZp,cplHpmcHpmVZp,cplHpmVWpVZp,          & 
& cplHpmVXpVZp,cplcVWpVWpVZp,cplcVXpVXpVZp,cplAhAhVZpVZp,cplDpmcDpmVZpVZp,               & 
& cplhhhhVZpVZp,cplHpmcHpmVZpVZp,cplcVWpVWpVZpVZp1,cplcVWpVWpVZpVZp2,cplcVWpVWpVZpVZp3,  & 
& cplcVXpVXpVZpVZp1,cplcVXpVXpVZpVZp2,cplcVXpVXpVZpVZp3,kont,res)

Implicit None 
Real(dp), Intent(in) :: Mhh(3),Mhh2(3),MAh(3),MAh2(3),MDpm(2),MDpm2(2),MFd(5),MFd2(5),MFe(3),MFe2(3),         & 
& MFu(4),MFu2(4),MVZ,MVZ2,MVZp,MVZp2,MHpm(4),MHpm2(4),MVWp,MVWp2,MVXp,MVXp2

Complex(dp), Intent(in) :: cplAhhhVZp(3,3),cplDpmcDpmVZp(2,2),cplcFdFdVZpL(5,5),cplcFdFdVZpR(5,5),               & 
& cplcFeFeVZpL(3,3),cplcFeFeVZpR(3,3),cplcFuFuVZpL(4,4),cplcFuFuVZpR(4,4),               & 
& cplcFv1Fv1VZpL(3,3),cplcFv1Fv1VZpR(3,3),cplcgWpgWpVZp,cplcgWCgWCVZp,cplcgXp1gXp1VZp,   & 
& cplcgXp2gXp2VZp,cplhhVPVZp(3),cplhhVZVZp(3),cplhhVZpVZp(3),cplHpmcHpmVZp(4,4),         & 
& cplHpmVWpVZp(4),cplHpmVXpVZp(4),cplcVWpVWpVZp,cplcVXpVXpVZp,cplAhAhVZpVZp(3,3),        & 
& cplDpmcDpmVZpVZp(2,2),cplhhhhVZpVZp(3,3),cplHpmcHpmVZpVZp(4,4),cplcVWpVWpVZpVZp1,      & 
& cplcVWpVWpVZpVZp2,cplcVWpVWpVZpVZp3,cplcVXpVXpVZpVZp1,cplcVXpVXpVZpVZp2,               & 
& cplcVXpVXpVZpVZp3

Integer, Intent(inout) :: kont 
Real(dp) :: B0m2, F0m2, G0m2, B1m2, H0m2, B22m2, m1, m2 
Real(dp), Intent(in) :: p2 
Complex(dp) :: A0m2, A0m12, A0m22 
Complex(dp), Intent(inout) :: res 
Complex(dp) :: coupL1, coupR1, coupL2,coupR2, coup1,coup2, coup3, temp, sumI 
Integer :: i1,i2,i3,i4, gO1, gO2, ierr 
 
 
Real(dp) ::MVG,MVP,MVG2,MVP2
MVG = Mass_Regulator_PhotonGluon 
MVP = Mass_Regulator_PhotonGluon 
MVG2 = Mass_Regulator_PhotonGluon**2 
MVP2 = Mass_Regulator_PhotonGluon**2 

res = 0._dp 
 
!------------------------ 
! hh, Ah 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 3
       Do i2 = 1, 3
 B22m2 = Real(DerVSSloop(p2,MAh2(i2),Mhh2(i1)),dp)  
coup1 = cplAhhhVZp(i2,i1)
    SumI = Abs(coup1)**2*B22m2 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! conj[Dpm], Dpm 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 2
       Do i2 = 1, 2
 B22m2 = Real(DerVSSloop(p2,MDpm2(i2),MDpm2(i1)),dp)  
coup1 = cplDpmcDpmVZp(i2,i1)
    SumI = Abs(coup1)**2*B22m2 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[Fd], Fd 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 5
       Do i2 = 1, 5
 H0m2 = Real(SA_DerHloop(p2,MFd2(i1),MFd2(i2)),dp) 
B0m2 = 4._dp*MFd(i1)*MFd(i2)*Real(SA_DerB0(p2,MFd2(i1),MFd2(i2)),dp) 
coupL1 = cplcFdFdVZpL(i1,i2)
coupR1 = cplcFdFdVZpR(i1,i2)
    SumI = (Abs(coupL1)**2+Abs(coupR1)**2)*H0m2 & 
                & + (Real(Conjg(coupL1)*coupR1,dp))*B0m2 
res = res +3._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[Fe], Fe 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 3
       Do i2 = 1, 3
 H0m2 = Real(SA_DerHloop(p2,MFe2(i1),MFe2(i2)),dp) 
B0m2 = 4._dp*MFe(i1)*MFe(i2)*Real(SA_DerB0(p2,MFe2(i1),MFe2(i2)),dp) 
coupL1 = cplcFeFeVZpL(i1,i2)
coupR1 = cplcFeFeVZpR(i1,i2)
    SumI = (Abs(coupL1)**2+Abs(coupR1)**2)*H0m2 & 
                & + (Real(Conjg(coupL1)*coupR1,dp))*B0m2 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[Fu], Fu 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
       Do i2 = 1, 4
 H0m2 = Real(SA_DerHloop(p2,MFu2(i1),MFu2(i2)),dp) 
B0m2 = 4._dp*MFu(i1)*MFu(i2)*Real(SA_DerB0(p2,MFu2(i1),MFu2(i2)),dp) 
coupL1 = cplcFuFuVZpL(i1,i2)
coupR1 = cplcFuFuVZpR(i1,i2)
    SumI = (Abs(coupL1)**2+Abs(coupR1)**2)*H0m2 & 
                & + (Real(Conjg(coupL1)*coupR1,dp))*B0m2 
res = res +3._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[Fv1], Fv1 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 3
       Do i2 = 1, 3
 H0m2 = Real(SA_DerHloop(p2,0._dp,0._dp),dp) 
B0m2 = 4._dp*0._dp*0._dp*Real(SA_DerB0(p2,0._dp,0._dp),dp) 
coupL1 = cplcFv1Fv1VZpL(i1,i2)
coupR1 = cplcFv1Fv1VZpR(i1,i2)
    SumI = (Abs(coupL1)**2+Abs(coupR1)**2)*H0m2 & 
                & + (Real(Conjg(coupL1)*coupR1,dp))*B0m2 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[gWp], gWp 
!------------------------ 
sumI = 0._dp 
 
SumI = 0._dp 
B0m2 = Real(DerVGGloop(p2,MVWp2,MVWp2),dp)
coup1 = cplcgWpgWpVZp
coup2 = Conjg(coup1) 
   SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
!------------------------ 
! bar[gWpC], gWpC 
!------------------------ 
sumI = 0._dp 
 
SumI = 0._dp 
B0m2 = Real(DerVGGloop(p2,MVWp2,MVWp2),dp)
coup1 = cplcgWCgWCVZp
coup2 = Conjg(coup1) 
   SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
!------------------------ 
! bar[gXp], gXp 
!------------------------ 
sumI = 0._dp 
 
SumI = 0._dp 
B0m2 = Real(DerVGGloop(p2,MVXp2,MVXp2),dp)
coup1 = cplcgXp1gXp1VZp
coup2 = Conjg(coup1) 
   SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
!------------------------ 
! bar[gXpC], gXpC 
!------------------------ 
sumI = 0._dp 
 
SumI = 0._dp 
B0m2 = Real(DerVGGloop(p2,MVXp2,MVXp2),dp)
coup1 = cplcgXp2gXp2VZp
coup2 = Conjg(coup1) 
   SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
!------------------------ 
! VP, hh 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 3
 B0m2 = Real(DerVVSloop(p2,MVP2,Mhh2(i2)),dp)
coup1 = cplhhVPVZp(i2)
    SumI = Abs(coup1)**2*B0m2 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! VZ, hh 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 3
 B0m2 = Real(DerVVSloop(p2,MVZ2,Mhh2(i2)),dp)
coup1 = cplhhVZVZp(i2)
    SumI = Abs(coup1)**2*B0m2 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! VZp, hh 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 3
 B0m2 = Real(DerVVSloop(p2,MVZp2,Mhh2(i2)),dp)
coup1 = cplhhVZpVZp(i2)
    SumI = Abs(coup1)**2*B0m2 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! conj[Hpm], Hpm 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
       Do i2 = 1, 4
 B22m2 = Real(DerVSSloop(p2,MHpm2(i2),MHpm2(i1)),dp)  
coup1 = cplHpmcHpmVZp(i2,i1)
    SumI = Abs(coup1)**2*B22m2 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! VWp, Hpm 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 B0m2 = Real(DerVVSloop(p2,MVWp2,MHpm2(i2)),dp)
coup1 = cplHpmVWpVZp(i2)
    SumI = Abs(coup1)**2*B0m2 
res = res +2._dp* SumI  
    End Do 
 !------------------------ 
! VXp, Hpm 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 B0m2 = Real(DerVVSloop(p2,MVXp2,MHpm2(i2)),dp)
coup1 = cplHpmVXpVZp(i2)
    SumI = Abs(coup1)**2*B0m2 
res = res +2._dp* SumI  
    End Do 
 !------------------------ 
! conj[VWp], VWp 
!------------------------ 
sumI = 0._dp 
 
coup1 = cplcVWpVWpVZp
coup2 = Conjg(coup1) 
    SumI = -DerVVVloop(p2,MVWp2,MVWp2)*coup1*coup2 
res = res +1._dp* SumI  
!------------------------ 
! conj[VXp], VXp 
!------------------------ 
sumI = 0._dp 
 
coup1 = cplcVXpVXpVZp
coup2 = Conjg(coup1) 
    SumI = -DerVVVloop(p2,MVXp2,MVXp2)*coup1*coup2 
res = res +1._dp* SumI  
!------------------------ 
! Ah 
!------------------------ 
    Do i1 = 1, 3
 SumI = 0._dp 
 A0m2 = SA_DerA0(MAh2(i1))
 coup1 = cplAhAhVZpVZp(i1,i1)
 SumI = coup1*A0m2 
res = res +1._dp/2._dp* SumI  
      End Do 
 !------------------------ 
! conj[Dpm] 
!------------------------ 
    Do i1 = 1, 2
 SumI = 0._dp 
 A0m2 = SA_DerA0(MDpm2(i1))
 coup1 = cplDpmcDpmVZpVZp(i1,i1)
 SumI = coup1*A0m2 
res = res +1* SumI  
      End Do 
 !------------------------ 
! hh 
!------------------------ 
    Do i1 = 1, 3
 SumI = 0._dp 
 A0m2 = SA_DerA0(Mhh2(i1))
 coup1 = cplhhhhVZpVZp(i1,i1)
 SumI = coup1*A0m2 
res = res +1._dp/2._dp* SumI  
      End Do 
 !------------------------ 
! conj[Hpm] 
!------------------------ 
    Do i1 = 1, 4
 SumI = 0._dp 
 A0m2 = SA_DerA0(MHpm2(i1))
 coup1 = cplHpmcHpmVZpVZp(i1,i1)
 SumI = coup1*A0m2 
res = res +1* SumI  
      End Do 
 !------------------------ 
! conj[VWp] 
!------------------------ 
SumI = 0._dp 
A0m2 = 3._dp/4._dp*SA_DerA0(MVWp2) +RXi/4._dp*SA_DerA0(MVWp2*RXi) 
coup1 = cplcVWpVWpVZpVZp1
coup2 = cplcVWpVWpVZpVZp2
coup3 = cplcVWpVWpVZpVZp3
SumI = ((2._dp*DerrMS*coup1+(1-RXi**2)/8._dp*(coup2+coup3))*MVWp2-(4._dp*coup1+coup2+coup3)*A0m2)
res = res +1* SumI  
!------------------------ 
! conj[VXp] 
!------------------------ 
SumI = 0._dp 
A0m2 = 3._dp/4._dp*SA_DerA0(MVXp2) +RXi/4._dp*SA_DerA0(MVXp2*RXi) 
coup1 = cplcVXpVXpVZpVZp1
coup2 = cplcVXpVXpVZpVZp2
coup3 = cplcVXpVXpVZpVZp3
SumI = ((2._dp*DerrMS*coup1+(1-RXi**2)/8._dp*(coup2+coup3))*MVXp2-(4._dp*coup1+coup2+coup3)*A0m2)
res = res +1* SumI  
res = oo16pi2*res 
 
End Subroutine DerPi1LoopVZp 
 
Subroutine OneLoopVWp(g2,v1,v2,MHpm,MHpm2,MAh,MAh2,MDpm,MDpm2,MVXp,MVXp2,             & 
& MFd,MFd2,MFu,MFu2,MFe,MFe2,Mhh,Mhh2,MVWp,MVWp2,MVZ,MVZ2,MVZp,MVZp2,cplAhcHpmcVWp,      & 
& cplDpmcHpmcVWp,cplDpmcVWpVXp,cplcFdFucVWpL,cplcFdFucVWpR,cplcFeFv1cVWpL,               & 
& cplcFeFv1cVWpR,cplcgWCgAcVWp,cplcgAgWpcVWp,cplcgZgWpcVWp,cplcgZpgWpcVWp,               & 
& cplcgWCgZcVWp,cplcgWCgZpcVWp,cplhhcHpmcVWp,cplhhcVWpVWp,cplcHpmcVWpVP,cplcVWpVPVWp,    & 
& cplcVWpVWpVZ,cplcVWpVWpVZp,cplcHpmcVWpVZ,cplcHpmcVWpVZp,cplAhAhcVWpVWp,cplDpmcDpmcVWpVWp,& 
& cplhhhhcVWpVWp,cplHpmcHpmcVWpVWp,cplcVWpVPVPVWp3,cplcVWpVPVPVWp1,cplcVWpVPVPVWp2,      & 
& cplcVWpcVWpVWpVWp2,cplcVWpcVWpVWpVWp3,cplcVWpcVWpVWpVWp1,cplcVWpcVXpVWpVXp2,           & 
& cplcVWpcVXpVWpVXp3,cplcVWpcVXpVWpVXp1,cplcVWpVWpVZVZ1,cplcVWpVWpVZVZ2,cplcVWpVWpVZVZ3, & 
& cplcVWpVWpVZpVZp1,cplcVWpVWpVZpVZp2,cplcVWpVWpVZpVZp3,delta,mass,mass2,kont)

Real(dp), Intent(in) :: MHpm(4),MHpm2(4),MAh(3),MAh2(3),MDpm(2),MDpm2(2),MVXp,MVXp2,MFd(5),MFd2(5),           & 
& MFu(4),MFu2(4),MFe(3),MFe2(3),Mhh(3),Mhh2(3),MVWp,MVWp2,MVZ,MVZ2,MVZp,MVZp2

Real(dp), Intent(in) :: g2,v1,v2

Complex(dp), Intent(in) :: cplAhcHpmcVWp(3,4),cplDpmcHpmcVWp(2,4),cplDpmcVWpVXp(2),cplcFdFucVWpL(5,4),           & 
& cplcFdFucVWpR(5,4),cplcFeFv1cVWpL(3,3),cplcFeFv1cVWpR(3,3),cplcgWCgAcVWp,              & 
& cplcgAgWpcVWp,cplcgZgWpcVWp,cplcgZpgWpcVWp,cplcgWCgZcVWp,cplcgWCgZpcVWp,               & 
& cplhhcHpmcVWp(3,4),cplhhcVWpVWp(3),cplcHpmcVWpVP(4),cplcVWpVPVWp,cplcVWpVWpVZ,         & 
& cplcVWpVWpVZp,cplcHpmcVWpVZ(4),cplcHpmcVWpVZp(4),cplAhAhcVWpVWp(3,3),cplDpmcDpmcVWpVWp(2,2),& 
& cplhhhhcVWpVWp(3,3),cplHpmcHpmcVWpVWp(4,4),cplcVWpVPVPVWp3,cplcVWpVPVPVWp1,            & 
& cplcVWpVPVPVWp2,cplcVWpcVWpVWpVWp2,cplcVWpcVWpVWpVWp3,cplcVWpcVWpVWpVWp1,              & 
& cplcVWpcVXpVWpVXp2,cplcVWpcVXpVWpVXp3,cplcVWpcVXpVWpVXp1,cplcVWpVWpVZVZ1,              & 
& cplcVWpVWpVZVZ2,cplcVWpVWpVZVZ3,cplcVWpVWpVZpVZp1,cplcVWpVWpVZpVZp2,cplcVWpVWpVZpVZp3

Integer , Intent(inout):: kont 
Integer :: i1,i2,i3,i4,j1,j2,j3,j4,il,i_count, ierr 
Real(dp), Intent(in) :: delta 
Real(dp) :: mi, mi2, p2, test_m2 
Complex(dp) :: PiSf, SigL, SigR, SigSL, SigSR 
Real(dp), Intent(out) :: mass, mass2 
Iname = Iname + 1 
NameOfUnit(Iname) = 'OneLoopVWp'
 
mi2 = MVWp2 

 
p2 = MVWp2
PiSf = ZeroC 
Call Pi1LoopVWp(p2,MHpm,MHpm2,MAh,MAh2,MDpm,MDpm2,MVXp,MVXp2,MFd,MFd2,MFu,            & 
& MFu2,MFe,MFe2,Mhh,Mhh2,MVWp,MVWp2,MVZ,MVZ2,MVZp,MVZp2,cplAhcHpmcVWp,cplDpmcHpmcVWp,    & 
& cplDpmcVWpVXp,cplcFdFucVWpL,cplcFdFucVWpR,cplcFeFv1cVWpL,cplcFeFv1cVWpR,               & 
& cplcgWCgAcVWp,cplcgAgWpcVWp,cplcgZgWpcVWp,cplcgZpgWpcVWp,cplcgWCgZcVWp,cplcgWCgZpcVWp, & 
& cplhhcHpmcVWp,cplhhcVWpVWp,cplcHpmcVWpVP,cplcVWpVPVWp,cplcVWpVWpVZ,cplcVWpVWpVZp,      & 
& cplcHpmcVWpVZ,cplcHpmcVWpVZp,cplAhAhcVWpVWp,cplDpmcDpmcVWpVWp,cplhhhhcVWpVWp,          & 
& cplHpmcHpmcVWpVWp,cplcVWpVPVPVWp3,cplcVWpVPVPVWp1,cplcVWpVPVPVWp2,cplcVWpcVWpVWpVWp2,  & 
& cplcVWpcVWpVWpVWp3,cplcVWpcVWpVWpVWp1,cplcVWpcVXpVWpVXp2,cplcVWpcVXpVWpVXp3,           & 
& cplcVWpcVXpVWpVXp1,cplcVWpVWpVZVZ1,cplcVWpVWpVZVZ2,cplcVWpVWpVZVZ3,cplcVWpVWpVZpVZp1,  & 
& cplcVWpVWpVZpVZp2,cplcVWpVWpVZpVZp3,kont,PiSf)

mass2 = mi2 + Real(PiSf,dp) 
mass = sqrt(mass2) 
i_count = 0 
Do  
i_count = i_count + 1 
test_m2 = mass2 
p2 =  mass2 
PiSf = ZeroC 
Call Pi1LoopVWp(p2,MHpm,MHpm2,MAh,MAh2,MDpm,MDpm2,MVXp,MVXp2,MFd,MFd2,MFu,            & 
& MFu2,MFe,MFe2,Mhh,Mhh2,MVWp,MVWp2,MVZ,MVZ2,MVZp,MVZp2,cplAhcHpmcVWp,cplDpmcHpmcVWp,    & 
& cplDpmcVWpVXp,cplcFdFucVWpL,cplcFdFucVWpR,cplcFeFv1cVWpL,cplcFeFv1cVWpR,               & 
& cplcgWCgAcVWp,cplcgAgWpcVWp,cplcgZgWpcVWp,cplcgZpgWpcVWp,cplcgWCgZcVWp,cplcgWCgZpcVWp, & 
& cplhhcHpmcVWp,cplhhcVWpVWp,cplcHpmcVWpVP,cplcVWpVPVWp,cplcVWpVWpVZ,cplcVWpVWpVZp,      & 
& cplcHpmcVWpVZ,cplcHpmcVWpVZp,cplAhAhcVWpVWp,cplDpmcDpmcVWpVWp,cplhhhhcVWpVWp,          & 
& cplHpmcHpmcVWpVWp,cplcVWpVPVPVWp3,cplcVWpVPVPVWp1,cplcVWpVPVPVWp2,cplcVWpcVWpVWpVWp2,  & 
& cplcVWpcVWpVWpVWp3,cplcVWpcVWpVWpVWp1,cplcVWpcVXpVWpVXp2,cplcVWpcVXpVWpVXp3,           & 
& cplcVWpcVXpVWpVXp1,cplcVWpVWpVZVZ1,cplcVWpVWpVZVZ2,cplcVWpVWpVZVZ3,cplcVWpVWpVZpVZp1,  & 
& cplcVWpVWpVZpVZp2,cplcVWpVWpVZpVZp3,kont,PiSf)

mass2 = mi2 + Real(PiSf,dp) 
mass = sqrt(mass2) 
 If (test_m2.Ne.0._dp) Then 
    test_m2 = Abs(test_m2 - mass2) / test_m2 
 Else 
    test_m2 = Abs(mass2) 
 End If 
 If (mass2.Ge.0._dp) Then 
   If (RotateNegativeFermionMasses) Then 
    mass = sqrt(mass2) 
   End if 
  Else 
 If (Abs(mass2).lt.1.0E-30_dp) test_m2 = 0._dp 
     Write(ErrCan,*) 'Warning from routine'//NameOfUnit(Iname) 
     Write(ErrCan,*) 'in the calculation of the masses' 
     Write(ErrCan,*) 'occurred a negative mass squared!' 
   SignOfMassChanged = .True. 
   mass = 0._dp 
  End If 
If (test_m2.LT.0.1_dp*delta) Exit 
If (i_count.Gt.30) Then 
  Write(*,*) "Problem in "//NameOfUnit(Iname), test_m2, mass2 
  kont = -510 
  Call AddError(510) 
 Exit 
End If 
End Do 
 
 
Iname = Iname -1 
End Subroutine OneLoopVWp
 
 
Subroutine Pi1LoopVWp(p2,MHpm,MHpm2,MAh,MAh2,MDpm,MDpm2,MVXp,MVXp2,MFd,               & 
& MFd2,MFu,MFu2,MFe,MFe2,Mhh,Mhh2,MVWp,MVWp2,MVZ,MVZ2,MVZp,MVZp2,cplAhcHpmcVWp,          & 
& cplDpmcHpmcVWp,cplDpmcVWpVXp,cplcFdFucVWpL,cplcFdFucVWpR,cplcFeFv1cVWpL,               & 
& cplcFeFv1cVWpR,cplcgWCgAcVWp,cplcgAgWpcVWp,cplcgZgWpcVWp,cplcgZpgWpcVWp,               & 
& cplcgWCgZcVWp,cplcgWCgZpcVWp,cplhhcHpmcVWp,cplhhcVWpVWp,cplcHpmcVWpVP,cplcVWpVPVWp,    & 
& cplcVWpVWpVZ,cplcVWpVWpVZp,cplcHpmcVWpVZ,cplcHpmcVWpVZp,cplAhAhcVWpVWp,cplDpmcDpmcVWpVWp,& 
& cplhhhhcVWpVWp,cplHpmcHpmcVWpVWp,cplcVWpVPVPVWp3,cplcVWpVPVPVWp1,cplcVWpVPVPVWp2,      & 
& cplcVWpcVWpVWpVWp2,cplcVWpcVWpVWpVWp3,cplcVWpcVWpVWpVWp1,cplcVWpcVXpVWpVXp2,           & 
& cplcVWpcVXpVWpVXp3,cplcVWpcVXpVWpVXp1,cplcVWpVWpVZVZ1,cplcVWpVWpVZVZ2,cplcVWpVWpVZVZ3, & 
& cplcVWpVWpVZpVZp1,cplcVWpVWpVZpVZp2,cplcVWpVWpVZpVZp3,kont,res)

Implicit None 
Real(dp), Intent(in) :: MHpm(4),MHpm2(4),MAh(3),MAh2(3),MDpm(2),MDpm2(2),MVXp,MVXp2,MFd(5),MFd2(5),           & 
& MFu(4),MFu2(4),MFe(3),MFe2(3),Mhh(3),Mhh2(3),MVWp,MVWp2,MVZ,MVZ2,MVZp,MVZp2

Complex(dp), Intent(in) :: cplAhcHpmcVWp(3,4),cplDpmcHpmcVWp(2,4),cplDpmcVWpVXp(2),cplcFdFucVWpL(5,4),           & 
& cplcFdFucVWpR(5,4),cplcFeFv1cVWpL(3,3),cplcFeFv1cVWpR(3,3),cplcgWCgAcVWp,              & 
& cplcgAgWpcVWp,cplcgZgWpcVWp,cplcgZpgWpcVWp,cplcgWCgZcVWp,cplcgWCgZpcVWp,               & 
& cplhhcHpmcVWp(3,4),cplhhcVWpVWp(3),cplcHpmcVWpVP(4),cplcVWpVPVWp,cplcVWpVWpVZ,         & 
& cplcVWpVWpVZp,cplcHpmcVWpVZ(4),cplcHpmcVWpVZp(4),cplAhAhcVWpVWp(3,3),cplDpmcDpmcVWpVWp(2,2),& 
& cplhhhhcVWpVWp(3,3),cplHpmcHpmcVWpVWp(4,4),cplcVWpVPVPVWp3,cplcVWpVPVPVWp1,            & 
& cplcVWpVPVPVWp2,cplcVWpcVWpVWpVWp2,cplcVWpcVWpVWpVWp3,cplcVWpcVWpVWpVWp1,              & 
& cplcVWpcVXpVWpVXp2,cplcVWpcVXpVWpVXp3,cplcVWpcVXpVWpVXp1,cplcVWpVWpVZVZ1,              & 
& cplcVWpVWpVZVZ2,cplcVWpVWpVZVZ3,cplcVWpVWpVZpVZp1,cplcVWpVWpVZpVZp2,cplcVWpVWpVZpVZp3

Integer, Intent(inout) :: kont 
Real(dp) :: B0m2, F0m2, G0m2, B1m2, H0m2, B22m2, m1, m2 
Real(dp), Intent(in) :: p2 
Complex(dp) :: A0m2, A0m12, A0m22 
Complex(dp), Intent(inout) :: res 
Complex(dp) :: coupL1, coupR1, coupL2,coupR2, coup1,coup2, coup3, temp, sumI 
Integer :: i1,i2,i3,i4, gO1, gO2, ierr 
 
 
res = 0._dp 
 
!------------------------ 
! conj[Hpm], Ah 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
       Do i2 = 1, 3
 B22m2 = Real(VSSloop(p2,MAh2(i2),MHpm2(i1)),dp)  
coup1 = cplAhcHpmcVWp(i2,i1)
    SumI = Abs(coup1)**2*B22m2 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! conj[Hpm], Dpm 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
       Do i2 = 1, 2
 B22m2 = Real(VSSloop(p2,MDpm2(i2),MHpm2(i1)),dp)  
coup1 = cplDpmcHpmcVWp(i2,i1)
    SumI = Abs(coup1)**2*B22m2 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! VXp, Dpm 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 2
 B0m2 = Real(VVSloop(p2,MVXp2,MDpm2(i2)),dp)
coup1 = cplDpmcVWpVXp(i2)
    SumI = Abs(coup1)**2*B0m2 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! bar[Fd], Fu 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 5
       Do i2 = 1, 4
 H0m2 = Real(SA_Hloop(p2,MFd2(i1),MFu2(i2)),dp) 
B0m2 = 4._dp*MFd(i1)*MFu(i2)*Real(SA_B0(p2,MFd2(i1),MFu2(i2)),dp) 
coupL1 = cplcFdFucVWpL(i1,i2)
coupR1 = cplcFdFucVWpR(i1,i2)
    SumI = (Abs(coupL1)**2+Abs(coupR1)**2)*H0m2 & 
                & + (Real(Conjg(coupL1)*coupR1,dp))*B0m2 
res = res +3._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[Fe], Fv1 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 3
       Do i2 = 1, 3
 H0m2 = Real(SA_Hloop(p2,MFe2(i1),0._dp),dp) 
B0m2 = 4._dp*MFe(i1)*0._dp*Real(SA_B0(p2,MFe2(i1),0._dp),dp) 
coupL1 = cplcFeFv1cVWpL(i1,i2)
coupR1 = cplcFeFv1cVWpR(i1,i2)
    SumI = (Abs(coupL1)**2+Abs(coupR1)**2)*H0m2 & 
                & + (Real(Conjg(coupL1)*coupR1,dp))*B0m2 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[gWpC], gP 
!------------------------ 
sumI = 0._dp 
 
SumI = 0._dp 
B0m2 = Real(VGGloop(p2,0._dp,MVWp2),dp)
coup1 = cplcgWCgAcVWp
coup2 = Conjg(coup1) 
   SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
!------------------------ 
! bar[gP], gWp 
!------------------------ 
sumI = 0._dp 
 
SumI = 0._dp 
B0m2 = Real(VGGloop(p2,MVWp2,0._dp),dp)
coup1 = cplcgAgWpcVWp
coup2 = Conjg(coup1) 
   SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
!------------------------ 
! bar[gZ], gWp 
!------------------------ 
sumI = 0._dp 
 
SumI = 0._dp 
B0m2 = Real(VGGloop(p2,MVWp2,MVZ2),dp)
coup1 = cplcgZgWpcVWp
coup2 = Conjg(coup1) 
   SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
!------------------------ 
! bar[gZp], gWp 
!------------------------ 
sumI = 0._dp 
 
SumI = 0._dp 
B0m2 = Real(VGGloop(p2,MVWp2,MVZp2),dp)
coup1 = cplcgZpgWpcVWp
coup2 = Conjg(coup1) 
   SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
!------------------------ 
! bar[gWpC], gZ 
!------------------------ 
sumI = 0._dp 
 
SumI = 0._dp 
B0m2 = Real(VGGloop(p2,MVZ2,MVWp2),dp)
coup1 = cplcgWCgZcVWp
coup2 = Conjg(coup1) 
   SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
!------------------------ 
! bar[gWpC], gZp 
!------------------------ 
sumI = 0._dp 
 
SumI = 0._dp 
B0m2 = Real(VGGloop(p2,MVZp2,MVWp2),dp)
coup1 = cplcgWCgZpcVWp
coup2 = Conjg(coup1) 
   SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
!------------------------ 
! conj[Hpm], hh 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
       Do i2 = 1, 3
 B22m2 = Real(VSSloop(p2,Mhh2(i2),MHpm2(i1)),dp)  
coup1 = cplhhcHpmcVWp(i2,i1)
    SumI = Abs(coup1)**2*B22m2 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! VWp, hh 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 3
 B0m2 = Real(VVSloop(p2,MVWp2,Mhh2(i2)),dp)
coup1 = cplhhcVWpVWp(i2)
    SumI = Abs(coup1)**2*B0m2 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! conj[Hpm], VP 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
 B0m2 = Real(VVSloop(p2,0._dp,MHpm2(i1)),dp)
coup1 = cplcHpmcVWpVP(i1)
    SumI = Abs(coup1)**2*B0m2 
res = res +1._dp* SumI  
      End Do 
 !------------------------ 
! VWp, VP 
!------------------------ 
sumI = 0._dp 
 
coup1 = cplcVWpVPVWp
coup2 = Conjg(coup1) 
    SumI = -VVVloop(p2,MVWp2,0._dp)*coup1*coup2 
res = res +1._dp* SumI  
!------------------------ 
! VZ, VWp 
!------------------------ 
sumI = 0._dp 
 
coup1 = cplcVWpVWpVZ
coup2 = Conjg(coup1) 
    SumI = -VVVloop(p2,MVZ2,MVWp2)*coup1*coup2 
res = res +1._dp* SumI  
!------------------------ 
! VZp, VWp 
!------------------------ 
sumI = 0._dp 
 
coup1 = cplcVWpVWpVZp
coup2 = Conjg(coup1) 
    SumI = -VVVloop(p2,MVZp2,MVWp2)*coup1*coup2 
res = res +1._dp* SumI  
!------------------------ 
! conj[Hpm], VZ 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
 B0m2 = Real(VVSloop(p2,MVZ2,MHpm2(i1)),dp)
coup1 = cplcHpmcVWpVZ(i1)
    SumI = Abs(coup1)**2*B0m2 
res = res +1._dp* SumI  
      End Do 
 !------------------------ 
! conj[Hpm], VZp 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
 B0m2 = Real(VVSloop(p2,MVZp2,MHpm2(i1)),dp)
coup1 = cplcHpmcVWpVZp(i1)
    SumI = Abs(coup1)**2*B0m2 
res = res +1._dp* SumI  
      End Do 
 !------------------------ 
! Ah 
!------------------------ 
    Do i1 = 1, 3
 SumI = 0._dp 
 A0m2 = SA_A0(MAh2(i1))
 coup1 = cplAhAhcVWpVWp(i1,i1)
 SumI = coup1*A0m2 
res = res +1._dp/2._dp* SumI  
      End Do 
 !------------------------ 
! conj[Dpm] 
!------------------------ 
    Do i1 = 1, 2
 SumI = 0._dp 
 A0m2 = SA_A0(MDpm2(i1))
 coup1 = cplDpmcDpmcVWpVWp(i1,i1)
 SumI = coup1*A0m2 
res = res +1* SumI  
      End Do 
 !------------------------ 
! hh 
!------------------------ 
    Do i1 = 1, 3
 SumI = 0._dp 
 A0m2 = SA_A0(Mhh2(i1))
 coup1 = cplhhhhcVWpVWp(i1,i1)
 SumI = coup1*A0m2 
res = res +1._dp/2._dp* SumI  
      End Do 
 !------------------------ 
! conj[Hpm] 
!------------------------ 
    Do i1 = 1, 4
 SumI = 0._dp 
 A0m2 = SA_A0(MHpm2(i1))
 coup1 = cplHpmcHpmcVWpVWp(i1,i1)
 SumI = coup1*A0m2 
res = res +1* SumI  
      End Do 
 !------------------------ 
! VP 
!------------------------ 
SumI = 0._dp 
A0m2 = 3._dp/4._dp*SA_A0(0._dp) +RXi/4._dp*SA_A0(0._dp*RXi) 
coup1 = cplcVWpVPVPVWp3
coup2 = cplcVWpVPVPVWp1
coup3 = cplcVWpVPVPVWp2
SumI = ((2._dp*rMS*coup1+(1-RXi**2)/8._dp*(coup2+coup3))*0._dp-(4._dp*coup1+coup2+coup3)*A0m2)
res = res +1._dp/2._dp* SumI  
!------------------------ 
! conj[VWp] 
!------------------------ 
SumI = 0._dp 
A0m2 = 3._dp/4._dp*SA_A0(MVWp2) +RXi/4._dp*SA_A0(MVWp2*RXi) 
coup1 = cplcVWpcVWpVWpVWp2
coup2 = cplcVWpcVWpVWpVWp3
coup3 = cplcVWpcVWpVWpVWp1
SumI = ((2._dp*rMS*coup1+(1-RXi**2)/8._dp*(coup2+coup3))*MVWp2-(4._dp*coup1+coup2+coup3)*A0m2)
res = res +1* SumI  
!------------------------ 
! conj[VXp] 
!------------------------ 
SumI = 0._dp 
A0m2 = 3._dp/4._dp*SA_A0(MVXp2) +RXi/4._dp*SA_A0(MVXp2*RXi) 
coup1 = cplcVWpcVXpVWpVXp2
coup2 = cplcVWpcVXpVWpVXp3
coup3 = cplcVWpcVXpVWpVXp1
SumI = ((2._dp*rMS*coup1+(1-RXi**2)/8._dp*(coup2+coup3))*MVXp2-(4._dp*coup1+coup2+coup3)*A0m2)
res = res +1* SumI  
!------------------------ 
! VZ 
!------------------------ 
SumI = 0._dp 
A0m2 = 3._dp/4._dp*SA_A0(MVZ2) +RXi/4._dp*SA_A0(MVZ2*RXi) 
coup1 = cplcVWpVWpVZVZ1
coup2 = cplcVWpVWpVZVZ2
coup3 = cplcVWpVWpVZVZ3
SumI = ((2._dp*rMS*coup1+(1-RXi**2)/8._dp*(coup2+coup3))*MVZ2-(4._dp*coup1+coup2+coup3)*A0m2)
res = res +1._dp/2._dp* SumI  
!------------------------ 
! VZp 
!------------------------ 
SumI = 0._dp 
A0m2 = 3._dp/4._dp*SA_A0(MVZp2) +RXi/4._dp*SA_A0(MVZp2*RXi) 
coup1 = cplcVWpVWpVZpVZp1
coup2 = cplcVWpVWpVZpVZp2
coup3 = cplcVWpVWpVZpVZp3
SumI = ((2._dp*rMS*coup1+(1-RXi**2)/8._dp*(coup2+coup3))*MVZp2-(4._dp*coup1+coup2+coup3)*A0m2)
res = res +1._dp/2._dp* SumI  
res = oo16pi2*res 
 
End Subroutine Pi1LoopVWp 
 
Subroutine DerPi1LoopVWp(p2,MHpm,MHpm2,MAh,MAh2,MDpm,MDpm2,MVXp,MVXp2,MFd,            & 
& MFd2,MFu,MFu2,MFe,MFe2,Mhh,Mhh2,MVWp,MVWp2,MVZ,MVZ2,MVZp,MVZp2,cplAhcHpmcVWp,          & 
& cplDpmcHpmcVWp,cplDpmcVWpVXp,cplcFdFucVWpL,cplcFdFucVWpR,cplcFeFv1cVWpL,               & 
& cplcFeFv1cVWpR,cplcgWCgAcVWp,cplcgAgWpcVWp,cplcgZgWpcVWp,cplcgZpgWpcVWp,               & 
& cplcgWCgZcVWp,cplcgWCgZpcVWp,cplhhcHpmcVWp,cplhhcVWpVWp,cplcHpmcVWpVP,cplcVWpVPVWp,    & 
& cplcVWpVWpVZ,cplcVWpVWpVZp,cplcHpmcVWpVZ,cplcHpmcVWpVZp,cplAhAhcVWpVWp,cplDpmcDpmcVWpVWp,& 
& cplhhhhcVWpVWp,cplHpmcHpmcVWpVWp,cplcVWpVPVPVWp3,cplcVWpVPVPVWp1,cplcVWpVPVPVWp2,      & 
& cplcVWpcVWpVWpVWp2,cplcVWpcVWpVWpVWp3,cplcVWpcVWpVWpVWp1,cplcVWpcVXpVWpVXp2,           & 
& cplcVWpcVXpVWpVXp3,cplcVWpcVXpVWpVXp1,cplcVWpVWpVZVZ1,cplcVWpVWpVZVZ2,cplcVWpVWpVZVZ3, & 
& cplcVWpVWpVZpVZp1,cplcVWpVWpVZpVZp2,cplcVWpVWpVZpVZp3,kont,res)

Implicit None 
Real(dp), Intent(in) :: MHpm(4),MHpm2(4),MAh(3),MAh2(3),MDpm(2),MDpm2(2),MVXp,MVXp2,MFd(5),MFd2(5),           & 
& MFu(4),MFu2(4),MFe(3),MFe2(3),Mhh(3),Mhh2(3),MVWp,MVWp2,MVZ,MVZ2,MVZp,MVZp2

Complex(dp), Intent(in) :: cplAhcHpmcVWp(3,4),cplDpmcHpmcVWp(2,4),cplDpmcVWpVXp(2),cplcFdFucVWpL(5,4),           & 
& cplcFdFucVWpR(5,4),cplcFeFv1cVWpL(3,3),cplcFeFv1cVWpR(3,3),cplcgWCgAcVWp,              & 
& cplcgAgWpcVWp,cplcgZgWpcVWp,cplcgZpgWpcVWp,cplcgWCgZcVWp,cplcgWCgZpcVWp,               & 
& cplhhcHpmcVWp(3,4),cplhhcVWpVWp(3),cplcHpmcVWpVP(4),cplcVWpVPVWp,cplcVWpVWpVZ,         & 
& cplcVWpVWpVZp,cplcHpmcVWpVZ(4),cplcHpmcVWpVZp(4),cplAhAhcVWpVWp(3,3),cplDpmcDpmcVWpVWp(2,2),& 
& cplhhhhcVWpVWp(3,3),cplHpmcHpmcVWpVWp(4,4),cplcVWpVPVPVWp3,cplcVWpVPVPVWp1,            & 
& cplcVWpVPVPVWp2,cplcVWpcVWpVWpVWp2,cplcVWpcVWpVWpVWp3,cplcVWpcVWpVWpVWp1,              & 
& cplcVWpcVXpVWpVXp2,cplcVWpcVXpVWpVXp3,cplcVWpcVXpVWpVXp1,cplcVWpVWpVZVZ1,              & 
& cplcVWpVWpVZVZ2,cplcVWpVWpVZVZ3,cplcVWpVWpVZpVZp1,cplcVWpVWpVZpVZp2,cplcVWpVWpVZpVZp3

Integer, Intent(inout) :: kont 
Real(dp) :: B0m2, F0m2, G0m2, B1m2, H0m2, B22m2, m1, m2 
Real(dp), Intent(in) :: p2 
Complex(dp) :: A0m2, A0m12, A0m22 
Complex(dp), Intent(inout) :: res 
Complex(dp) :: coupL1, coupR1, coupL2,coupR2, coup1,coup2, coup3, temp, sumI 
Integer :: i1,i2,i3,i4, gO1, gO2, ierr 
 
 
Real(dp) ::MVG,MVP,MVG2,MVP2
MVG = Mass_Regulator_PhotonGluon 
MVP = Mass_Regulator_PhotonGluon 
MVG2 = Mass_Regulator_PhotonGluon**2 
MVP2 = Mass_Regulator_PhotonGluon**2 

res = 0._dp 
 
!------------------------ 
! conj[Hpm], Ah 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
       Do i2 = 1, 3
 B22m2 = Real(DerVSSloop(p2,MAh2(i2),MHpm2(i1)),dp)  
coup1 = cplAhcHpmcVWp(i2,i1)
    SumI = Abs(coup1)**2*B22m2 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! conj[Hpm], Dpm 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
       Do i2 = 1, 2
 B22m2 = Real(DerVSSloop(p2,MDpm2(i2),MHpm2(i1)),dp)  
coup1 = cplDpmcHpmcVWp(i2,i1)
    SumI = Abs(coup1)**2*B22m2 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! VXp, Dpm 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 2
 B0m2 = Real(DerVVSloop(p2,MVXp2,MDpm2(i2)),dp)
coup1 = cplDpmcVWpVXp(i2)
    SumI = Abs(coup1)**2*B0m2 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! bar[Fd], Fu 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 5
       Do i2 = 1, 4
 H0m2 = Real(SA_DerHloop(p2,MFd2(i1),MFu2(i2)),dp) 
B0m2 = 4._dp*MFd(i1)*MFu(i2)*Real(SA_DerB0(p2,MFd2(i1),MFu2(i2)),dp) 
coupL1 = cplcFdFucVWpL(i1,i2)
coupR1 = cplcFdFucVWpR(i1,i2)
    SumI = (Abs(coupL1)**2+Abs(coupR1)**2)*H0m2 & 
                & + (Real(Conjg(coupL1)*coupR1,dp))*B0m2 
res = res +3._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[Fe], Fv1 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 3
       Do i2 = 1, 3
 H0m2 = Real(SA_DerHloop(p2,MFe2(i1),0._dp),dp) 
B0m2 = 4._dp*MFe(i1)*0._dp*Real(SA_DerB0(p2,MFe2(i1),0._dp),dp) 
coupL1 = cplcFeFv1cVWpL(i1,i2)
coupR1 = cplcFeFv1cVWpR(i1,i2)
    SumI = (Abs(coupL1)**2+Abs(coupR1)**2)*H0m2 & 
                & + (Real(Conjg(coupL1)*coupR1,dp))*B0m2 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[gWpC], gP 
!------------------------ 
sumI = 0._dp 
 
SumI = 0._dp 
B0m2 = Real(DerVGGloop(p2,MVP2,MVWp2),dp)
coup1 = cplcgWCgAcVWp
coup2 = Conjg(coup1) 
   SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
!------------------------ 
! bar[gP], gWp 
!------------------------ 
sumI = 0._dp 
 
SumI = 0._dp 
B0m2 = Real(DerVGGloop(p2,MVWp2,MVP2),dp)
coup1 = cplcgAgWpcVWp
coup2 = Conjg(coup1) 
   SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
!------------------------ 
! bar[gZ], gWp 
!------------------------ 
sumI = 0._dp 
 
SumI = 0._dp 
B0m2 = Real(DerVGGloop(p2,MVWp2,MVZ2),dp)
coup1 = cplcgZgWpcVWp
coup2 = Conjg(coup1) 
   SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
!------------------------ 
! bar[gZp], gWp 
!------------------------ 
sumI = 0._dp 
 
SumI = 0._dp 
B0m2 = Real(DerVGGloop(p2,MVWp2,MVZp2),dp)
coup1 = cplcgZpgWpcVWp
coup2 = Conjg(coup1) 
   SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
!------------------------ 
! bar[gWpC], gZ 
!------------------------ 
sumI = 0._dp 
 
SumI = 0._dp 
B0m2 = Real(DerVGGloop(p2,MVZ2,MVWp2),dp)
coup1 = cplcgWCgZcVWp
coup2 = Conjg(coup1) 
   SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
!------------------------ 
! bar[gWpC], gZp 
!------------------------ 
sumI = 0._dp 
 
SumI = 0._dp 
B0m2 = Real(DerVGGloop(p2,MVZp2,MVWp2),dp)
coup1 = cplcgWCgZpcVWp
coup2 = Conjg(coup1) 
   SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
!------------------------ 
! conj[Hpm], hh 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
       Do i2 = 1, 3
 B22m2 = Real(DerVSSloop(p2,Mhh2(i2),MHpm2(i1)),dp)  
coup1 = cplhhcHpmcVWp(i2,i1)
    SumI = Abs(coup1)**2*B22m2 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! VWp, hh 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 3
 B0m2 = Real(DerVVSloop(p2,MVWp2,Mhh2(i2)),dp)
coup1 = cplhhcVWpVWp(i2)
    SumI = Abs(coup1)**2*B0m2 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! conj[Hpm], VP 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
 B0m2 = Real(DerVVSloop(p2,MVP2,MHpm2(i1)),dp)
coup1 = cplcHpmcVWpVP(i1)
    SumI = Abs(coup1)**2*B0m2 
res = res +1._dp* SumI  
      End Do 
 !------------------------ 
! VWp, VP 
!------------------------ 
sumI = 0._dp 
 
coup1 = cplcVWpVPVWp
coup2 = Conjg(coup1) 
    SumI = -DerVVVloop(p2,MVWp2,MVP2)*coup1*coup2 
res = res +1._dp* SumI  
!------------------------ 
! VZ, VWp 
!------------------------ 
sumI = 0._dp 
 
coup1 = cplcVWpVWpVZ
coup2 = Conjg(coup1) 
    SumI = -DerVVVloop(p2,MVZ2,MVWp2)*coup1*coup2 
res = res +1._dp* SumI  
!------------------------ 
! VZp, VWp 
!------------------------ 
sumI = 0._dp 
 
coup1 = cplcVWpVWpVZp
coup2 = Conjg(coup1) 
    SumI = -DerVVVloop(p2,MVZp2,MVWp2)*coup1*coup2 
res = res +1._dp* SumI  
!------------------------ 
! conj[Hpm], VZ 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
 B0m2 = Real(DerVVSloop(p2,MVZ2,MHpm2(i1)),dp)
coup1 = cplcHpmcVWpVZ(i1)
    SumI = Abs(coup1)**2*B0m2 
res = res +1._dp* SumI  
      End Do 
 !------------------------ 
! conj[Hpm], VZp 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
 B0m2 = Real(DerVVSloop(p2,MVZp2,MHpm2(i1)),dp)
coup1 = cplcHpmcVWpVZp(i1)
    SumI = Abs(coup1)**2*B0m2 
res = res +1._dp* SumI  
      End Do 
 !------------------------ 
! Ah 
!------------------------ 
    Do i1 = 1, 3
 SumI = 0._dp 
 A0m2 = SA_DerA0(MAh2(i1))
 coup1 = cplAhAhcVWpVWp(i1,i1)
 SumI = coup1*A0m2 
res = res +1._dp/2._dp* SumI  
      End Do 
 !------------------------ 
! conj[Dpm] 
!------------------------ 
    Do i1 = 1, 2
 SumI = 0._dp 
 A0m2 = SA_DerA0(MDpm2(i1))
 coup1 = cplDpmcDpmcVWpVWp(i1,i1)
 SumI = coup1*A0m2 
res = res +1* SumI  
      End Do 
 !------------------------ 
! hh 
!------------------------ 
    Do i1 = 1, 3
 SumI = 0._dp 
 A0m2 = SA_DerA0(Mhh2(i1))
 coup1 = cplhhhhcVWpVWp(i1,i1)
 SumI = coup1*A0m2 
res = res +1._dp/2._dp* SumI  
      End Do 
 !------------------------ 
! conj[Hpm] 
!------------------------ 
    Do i1 = 1, 4
 SumI = 0._dp 
 A0m2 = SA_DerA0(MHpm2(i1))
 coup1 = cplHpmcHpmcVWpVWp(i1,i1)
 SumI = coup1*A0m2 
res = res +1* SumI  
      End Do 
 !------------------------ 
! VP 
!------------------------ 
SumI = 0._dp 
A0m2 = 3._dp/4._dp*SA_DerA0(MVP2) +RXi/4._dp*SA_DerA0(MVP2*RXi) 
coup1 = cplcVWpVPVPVWp3
coup2 = cplcVWpVPVPVWp1
coup3 = cplcVWpVPVPVWp2
SumI = ((2._dp*DerrMS*coup1+(1-RXi**2)/8._dp*(coup2+coup3))*MVP2-(4._dp*coup1+coup2+coup3)*A0m2)
res = res +1._dp/2._dp* SumI  
!------------------------ 
! conj[VWp] 
!------------------------ 
SumI = 0._dp 
A0m2 = 3._dp/4._dp*SA_DerA0(MVWp2) +RXi/4._dp*SA_DerA0(MVWp2*RXi) 
coup1 = cplcVWpcVWpVWpVWp2
coup2 = cplcVWpcVWpVWpVWp3
coup3 = cplcVWpcVWpVWpVWp1
SumI = ((2._dp*DerrMS*coup1+(1-RXi**2)/8._dp*(coup2+coup3))*MVWp2-(4._dp*coup1+coup2+coup3)*A0m2)
res = res +1* SumI  
!------------------------ 
! conj[VXp] 
!------------------------ 
SumI = 0._dp 
A0m2 = 3._dp/4._dp*SA_DerA0(MVXp2) +RXi/4._dp*SA_DerA0(MVXp2*RXi) 
coup1 = cplcVWpcVXpVWpVXp2
coup2 = cplcVWpcVXpVWpVXp3
coup3 = cplcVWpcVXpVWpVXp1
SumI = ((2._dp*DerrMS*coup1+(1-RXi**2)/8._dp*(coup2+coup3))*MVXp2-(4._dp*coup1+coup2+coup3)*A0m2)
res = res +1* SumI  
!------------------------ 
! VZ 
!------------------------ 
SumI = 0._dp 
A0m2 = 3._dp/4._dp*SA_DerA0(MVZ2) +RXi/4._dp*SA_DerA0(MVZ2*RXi) 
coup1 = cplcVWpVWpVZVZ1
coup2 = cplcVWpVWpVZVZ2
coup3 = cplcVWpVWpVZVZ3
SumI = ((2._dp*DerrMS*coup1+(1-RXi**2)/8._dp*(coup2+coup3))*MVZ2-(4._dp*coup1+coup2+coup3)*A0m2)
res = res +1._dp/2._dp* SumI  
!------------------------ 
! VZp 
!------------------------ 
SumI = 0._dp 
A0m2 = 3._dp/4._dp*SA_DerA0(MVZp2) +RXi/4._dp*SA_DerA0(MVZp2*RXi) 
coup1 = cplcVWpVWpVZpVZp1
coup2 = cplcVWpVWpVZpVZp2
coup3 = cplcVWpVWpVZpVZp3
SumI = ((2._dp*DerrMS*coup1+(1-RXi**2)/8._dp*(coup2+coup3))*MVZp2-(4._dp*coup1+coup2+coup3)*A0m2)
res = res +1._dp/2._dp* SumI  
res = oo16pi2*res 
 
End Subroutine DerPi1LoopVWp 
 
Subroutine OneLoopVXp(g2,Vn,v2,MHpm,MHpm2,MAh,MAh2,MFd,MFd2,MFu,MFu2,Mhh,             & 
& Mhh2,MVXp,MVXp2,MDpm,MDpm2,MVWp,MVWp2,MVZ,MVZ2,MVZp,MVZp2,cplAhcHpmcVXp,               & 
& cplcFdFucVXpL,cplcFdFucVXpR,cplcgXp2gAcVXp,cplcgAgXp1cVXp,cplcgZgXp1cVXp,              & 
& cplcgZpgXp1cVXp,cplcgXp2gZcVXp,cplcgXp2gZpcVXp,cplhhcHpmcVXp,cplhhcVXpVXp,             & 
& cplcHpmcVXpVP,cplcVXpVPVXp,cplcDpmcVXpVWp,cplcVXpVXpVZ,cplcVXpVXpVZp,cplcHpmcVXpVZ,    & 
& cplcHpmcVXpVZp,cplcDpmcHpmcVXp,cplAhAhcVXpVXp,cplDpmcDpmcVXpVXp,cplhhhhcVXpVXp,        & 
& cplHpmcHpmcVXpVXp,cplcVXpVPVPVXp3,cplcVXpVPVPVXp1,cplcVXpVPVPVXp2,cplcVWpcVXpVWpVXp2,  & 
& cplcVWpcVXpVWpVXp3,cplcVWpcVXpVWpVXp1,cplcVXpcVXpVXpVXp2,cplcVXpcVXpVXpVXp3,           & 
& cplcVXpcVXpVXpVXp1,cplcVXpVXpVZVZ1,cplcVXpVXpVZVZ2,cplcVXpVXpVZVZ3,cplcVXpVXpVZpVZp1,  & 
& cplcVXpVXpVZpVZp2,cplcVXpVXpVZpVZp3,delta,mass,mass2,kont)

Real(dp), Intent(in) :: MHpm(4),MHpm2(4),MAh(3),MAh2(3),MFd(5),MFd2(5),MFu(4),MFu2(4),Mhh(3),Mhh2(3),         & 
& MVXp,MVXp2,MDpm(2),MDpm2(2),MVWp,MVWp2,MVZ,MVZ2,MVZp,MVZp2

Real(dp), Intent(in) :: g2,Vn,v2

Complex(dp), Intent(in) :: cplAhcHpmcVXp(3,4),cplcFdFucVXpL(5,4),cplcFdFucVXpR(5,4),cplcgXp2gAcVXp,              & 
& cplcgAgXp1cVXp,cplcgZgXp1cVXp,cplcgZpgXp1cVXp,cplcgXp2gZcVXp,cplcgXp2gZpcVXp,          & 
& cplhhcHpmcVXp(3,4),cplhhcVXpVXp(3),cplcHpmcVXpVP(4),cplcVXpVPVXp,cplcDpmcVXpVWp(2),    & 
& cplcVXpVXpVZ,cplcVXpVXpVZp,cplcHpmcVXpVZ(4),cplcHpmcVXpVZp(4),cplcDpmcHpmcVXp(2,4),    & 
& cplAhAhcVXpVXp(3,3),cplDpmcDpmcVXpVXp(2,2),cplhhhhcVXpVXp(3,3),cplHpmcHpmcVXpVXp(4,4), & 
& cplcVXpVPVPVXp3,cplcVXpVPVPVXp1,cplcVXpVPVPVXp2,cplcVWpcVXpVWpVXp2,cplcVWpcVXpVWpVXp3, & 
& cplcVWpcVXpVWpVXp1,cplcVXpcVXpVXpVXp2,cplcVXpcVXpVXpVXp3,cplcVXpcVXpVXpVXp1,           & 
& cplcVXpVXpVZVZ1,cplcVXpVXpVZVZ2,cplcVXpVXpVZVZ3,cplcVXpVXpVZpVZp1,cplcVXpVXpVZpVZp2,   & 
& cplcVXpVXpVZpVZp3

Integer , Intent(inout):: kont 
Integer :: i1,i2,i3,i4,j1,j2,j3,j4,il,i_count, ierr 
Real(dp), Intent(in) :: delta 
Real(dp) :: mi, mi2, p2, test_m2 
Complex(dp) :: PiSf, SigL, SigR, SigSL, SigSR 
Real(dp), Intent(out) :: mass, mass2 
Iname = Iname + 1 
NameOfUnit(Iname) = 'OneLoopVXp'
 
mi2 = MVXp2 

 
p2 = MVXp2
PiSf = ZeroC 
Call Pi1LoopVXp(p2,MHpm,MHpm2,MAh,MAh2,MFd,MFd2,MFu,MFu2,Mhh,Mhh2,MVXp,               & 
& MVXp2,MDpm,MDpm2,MVWp,MVWp2,MVZ,MVZ2,MVZp,MVZp2,cplAhcHpmcVXp,cplcFdFucVXpL,           & 
& cplcFdFucVXpR,cplcgXp2gAcVXp,cplcgAgXp1cVXp,cplcgZgXp1cVXp,cplcgZpgXp1cVXp,            & 
& cplcgXp2gZcVXp,cplcgXp2gZpcVXp,cplhhcHpmcVXp,cplhhcVXpVXp,cplcHpmcVXpVP,               & 
& cplcVXpVPVXp,cplcDpmcVXpVWp,cplcVXpVXpVZ,cplcVXpVXpVZp,cplcHpmcVXpVZ,cplcHpmcVXpVZp,   & 
& cplcDpmcHpmcVXp,cplAhAhcVXpVXp,cplDpmcDpmcVXpVXp,cplhhhhcVXpVXp,cplHpmcHpmcVXpVXp,     & 
& cplcVXpVPVPVXp3,cplcVXpVPVPVXp1,cplcVXpVPVPVXp2,cplcVWpcVXpVWpVXp2,cplcVWpcVXpVWpVXp3, & 
& cplcVWpcVXpVWpVXp1,cplcVXpcVXpVXpVXp2,cplcVXpcVXpVXpVXp3,cplcVXpcVXpVXpVXp1,           & 
& cplcVXpVXpVZVZ1,cplcVXpVXpVZVZ2,cplcVXpVXpVZVZ3,cplcVXpVXpVZpVZp1,cplcVXpVXpVZpVZp2,   & 
& cplcVXpVXpVZpVZp3,kont,PiSf)

mass2 = mi2 + Real(PiSf,dp) 
mass = sqrt(mass2) 
i_count = 0 
Do  
i_count = i_count + 1 
test_m2 = mass2 
p2 =  mass2 
PiSf = ZeroC 
Call Pi1LoopVXp(p2,MHpm,MHpm2,MAh,MAh2,MFd,MFd2,MFu,MFu2,Mhh,Mhh2,MVXp,               & 
& MVXp2,MDpm,MDpm2,MVWp,MVWp2,MVZ,MVZ2,MVZp,MVZp2,cplAhcHpmcVXp,cplcFdFucVXpL,           & 
& cplcFdFucVXpR,cplcgXp2gAcVXp,cplcgAgXp1cVXp,cplcgZgXp1cVXp,cplcgZpgXp1cVXp,            & 
& cplcgXp2gZcVXp,cplcgXp2gZpcVXp,cplhhcHpmcVXp,cplhhcVXpVXp,cplcHpmcVXpVP,               & 
& cplcVXpVPVXp,cplcDpmcVXpVWp,cplcVXpVXpVZ,cplcVXpVXpVZp,cplcHpmcVXpVZ,cplcHpmcVXpVZp,   & 
& cplcDpmcHpmcVXp,cplAhAhcVXpVXp,cplDpmcDpmcVXpVXp,cplhhhhcVXpVXp,cplHpmcHpmcVXpVXp,     & 
& cplcVXpVPVPVXp3,cplcVXpVPVPVXp1,cplcVXpVPVPVXp2,cplcVWpcVXpVWpVXp2,cplcVWpcVXpVWpVXp3, & 
& cplcVWpcVXpVWpVXp1,cplcVXpcVXpVXpVXp2,cplcVXpcVXpVXpVXp3,cplcVXpcVXpVXpVXp1,           & 
& cplcVXpVXpVZVZ1,cplcVXpVXpVZVZ2,cplcVXpVXpVZVZ3,cplcVXpVXpVZpVZp1,cplcVXpVXpVZpVZp2,   & 
& cplcVXpVXpVZpVZp3,kont,PiSf)

mass2 = mi2 + Real(PiSf,dp) 
mass = sqrt(mass2) 
 If (test_m2.Ne.0._dp) Then 
    test_m2 = Abs(test_m2 - mass2) / test_m2 
 Else 
    test_m2 = Abs(mass2) 
 End If 
 If (mass2.Ge.0._dp) Then 
   If (RotateNegativeFermionMasses) Then 
    mass = sqrt(mass2) 
   End if 
  Else 
 If (Abs(mass2).lt.1.0E-30_dp) test_m2 = 0._dp 
     Write(ErrCan,*) 'Warning from routine'//NameOfUnit(Iname) 
     Write(ErrCan,*) 'in the calculation of the masses' 
     Write(ErrCan,*) 'occurred a negative mass squared!' 
   SignOfMassChanged = .True. 
   mass = 0._dp 
  End If 
If (test_m2.LT.0.1_dp*delta) Exit 
If (i_count.Gt.30) Then 
  Write(*,*) "Problem in "//NameOfUnit(Iname), test_m2, mass2 
  kont = -510 
  Call AddError(510) 
 Exit 
End If 
End Do 
 
 
Iname = Iname -1 
End Subroutine OneLoopVXp
 
 
Subroutine Pi1LoopVXp(p2,MHpm,MHpm2,MAh,MAh2,MFd,MFd2,MFu,MFu2,Mhh,Mhh2,              & 
& MVXp,MVXp2,MDpm,MDpm2,MVWp,MVWp2,MVZ,MVZ2,MVZp,MVZp2,cplAhcHpmcVXp,cplcFdFucVXpL,      & 
& cplcFdFucVXpR,cplcgXp2gAcVXp,cplcgAgXp1cVXp,cplcgZgXp1cVXp,cplcgZpgXp1cVXp,            & 
& cplcgXp2gZcVXp,cplcgXp2gZpcVXp,cplhhcHpmcVXp,cplhhcVXpVXp,cplcHpmcVXpVP,               & 
& cplcVXpVPVXp,cplcDpmcVXpVWp,cplcVXpVXpVZ,cplcVXpVXpVZp,cplcHpmcVXpVZ,cplcHpmcVXpVZp,   & 
& cplcDpmcHpmcVXp,cplAhAhcVXpVXp,cplDpmcDpmcVXpVXp,cplhhhhcVXpVXp,cplHpmcHpmcVXpVXp,     & 
& cplcVXpVPVPVXp3,cplcVXpVPVPVXp1,cplcVXpVPVPVXp2,cplcVWpcVXpVWpVXp2,cplcVWpcVXpVWpVXp3, & 
& cplcVWpcVXpVWpVXp1,cplcVXpcVXpVXpVXp2,cplcVXpcVXpVXpVXp3,cplcVXpcVXpVXpVXp1,           & 
& cplcVXpVXpVZVZ1,cplcVXpVXpVZVZ2,cplcVXpVXpVZVZ3,cplcVXpVXpVZpVZp1,cplcVXpVXpVZpVZp2,   & 
& cplcVXpVXpVZpVZp3,kont,res)

Implicit None 
Real(dp), Intent(in) :: MHpm(4),MHpm2(4),MAh(3),MAh2(3),MFd(5),MFd2(5),MFu(4),MFu2(4),Mhh(3),Mhh2(3),         & 
& MVXp,MVXp2,MDpm(2),MDpm2(2),MVWp,MVWp2,MVZ,MVZ2,MVZp,MVZp2

Complex(dp), Intent(in) :: cplAhcHpmcVXp(3,4),cplcFdFucVXpL(5,4),cplcFdFucVXpR(5,4),cplcgXp2gAcVXp,              & 
& cplcgAgXp1cVXp,cplcgZgXp1cVXp,cplcgZpgXp1cVXp,cplcgXp2gZcVXp,cplcgXp2gZpcVXp,          & 
& cplhhcHpmcVXp(3,4),cplhhcVXpVXp(3),cplcHpmcVXpVP(4),cplcVXpVPVXp,cplcDpmcVXpVWp(2),    & 
& cplcVXpVXpVZ,cplcVXpVXpVZp,cplcHpmcVXpVZ(4),cplcHpmcVXpVZp(4),cplcDpmcHpmcVXp(2,4),    & 
& cplAhAhcVXpVXp(3,3),cplDpmcDpmcVXpVXp(2,2),cplhhhhcVXpVXp(3,3),cplHpmcHpmcVXpVXp(4,4), & 
& cplcVXpVPVPVXp3,cplcVXpVPVPVXp1,cplcVXpVPVPVXp2,cplcVWpcVXpVWpVXp2,cplcVWpcVXpVWpVXp3, & 
& cplcVWpcVXpVWpVXp1,cplcVXpcVXpVXpVXp2,cplcVXpcVXpVXpVXp3,cplcVXpcVXpVXpVXp1,           & 
& cplcVXpVXpVZVZ1,cplcVXpVXpVZVZ2,cplcVXpVXpVZVZ3,cplcVXpVXpVZpVZp1,cplcVXpVXpVZpVZp2,   & 
& cplcVXpVXpVZpVZp3

Integer, Intent(inout) :: kont 
Real(dp) :: B0m2, F0m2, G0m2, B1m2, H0m2, B22m2, m1, m2 
Real(dp), Intent(in) :: p2 
Complex(dp) :: A0m2, A0m12, A0m22 
Complex(dp), Intent(inout) :: res 
Complex(dp) :: coupL1, coupR1, coupL2,coupR2, coup1,coup2, coup3, temp, sumI 
Integer :: i1,i2,i3,i4, gO1, gO2, ierr 
 
 
res = 0._dp 
 
!------------------------ 
! conj[Hpm], Ah 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
       Do i2 = 1, 3
 B22m2 = Real(VSSloop(p2,MAh2(i2),MHpm2(i1)),dp)  
coup1 = cplAhcHpmcVXp(i2,i1)
    SumI = Abs(coup1)**2*B22m2 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[Fd], Fu 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 5
       Do i2 = 1, 4
 H0m2 = Real(SA_Hloop(p2,MFd2(i1),MFu2(i2)),dp) 
B0m2 = 4._dp*MFd(i1)*MFu(i2)*Real(SA_B0(p2,MFd2(i1),MFu2(i2)),dp) 
coupL1 = cplcFdFucVXpL(i1,i2)
coupR1 = cplcFdFucVXpR(i1,i2)
    SumI = (Abs(coupL1)**2+Abs(coupR1)**2)*H0m2 & 
                & + (Real(Conjg(coupL1)*coupR1,dp))*B0m2 
res = res +3._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[gXpC], gP 
!------------------------ 
sumI = 0._dp 
 
SumI = 0._dp 
B0m2 = Real(VGGloop(p2,0._dp,MVXp2),dp)
coup1 = cplcgXp2gAcVXp
coup2 = Conjg(coup1) 
   SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
!------------------------ 
! bar[gP], gXp 
!------------------------ 
sumI = 0._dp 
 
SumI = 0._dp 
B0m2 = Real(VGGloop(p2,MVXp2,0._dp),dp)
coup1 = cplcgAgXp1cVXp
coup2 = Conjg(coup1) 
   SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
!------------------------ 
! bar[gZ], gXp 
!------------------------ 
sumI = 0._dp 
 
SumI = 0._dp 
B0m2 = Real(VGGloop(p2,MVXp2,MVZ2),dp)
coup1 = cplcgZgXp1cVXp
coup2 = Conjg(coup1) 
   SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
!------------------------ 
! bar[gZp], gXp 
!------------------------ 
sumI = 0._dp 
 
SumI = 0._dp 
B0m2 = Real(VGGloop(p2,MVXp2,MVZp2),dp)
coup1 = cplcgZpgXp1cVXp
coup2 = Conjg(coup1) 
   SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
!------------------------ 
! bar[gXpC], gZ 
!------------------------ 
sumI = 0._dp 
 
SumI = 0._dp 
B0m2 = Real(VGGloop(p2,MVZ2,MVXp2),dp)
coup1 = cplcgXp2gZcVXp
coup2 = Conjg(coup1) 
   SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
!------------------------ 
! bar[gXpC], gZp 
!------------------------ 
sumI = 0._dp 
 
SumI = 0._dp 
B0m2 = Real(VGGloop(p2,MVZp2,MVXp2),dp)
coup1 = cplcgXp2gZpcVXp
coup2 = Conjg(coup1) 
   SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
!------------------------ 
! conj[Hpm], hh 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
       Do i2 = 1, 3
 B22m2 = Real(VSSloop(p2,Mhh2(i2),MHpm2(i1)),dp)  
coup1 = cplhhcHpmcVXp(i2,i1)
    SumI = Abs(coup1)**2*B22m2 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! VXp, hh 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 3
 B0m2 = Real(VVSloop(p2,MVXp2,Mhh2(i2)),dp)
coup1 = cplhhcVXpVXp(i2)
    SumI = Abs(coup1)**2*B0m2 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! conj[Hpm], VP 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
 B0m2 = Real(VVSloop(p2,0._dp,MHpm2(i1)),dp)
coup1 = cplcHpmcVXpVP(i1)
    SumI = Abs(coup1)**2*B0m2 
res = res +1._dp* SumI  
      End Do 
 !------------------------ 
! VXp, VP 
!------------------------ 
sumI = 0._dp 
 
coup1 = cplcVXpVPVXp
coup2 = Conjg(coup1) 
    SumI = -VVVloop(p2,MVXp2,0._dp)*coup1*coup2 
res = res +1._dp* SumI  
!------------------------ 
! conj[Dpm], VWp 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 2
 B0m2 = Real(VVSloop(p2,MVWp2,MDpm2(i1)),dp)
coup1 = cplcDpmcVXpVWp(i1)
    SumI = Abs(coup1)**2*B0m2 
res = res +1._dp* SumI  
      End Do 
 !------------------------ 
! VZ, VXp 
!------------------------ 
sumI = 0._dp 
 
coup1 = cplcVXpVXpVZ
coup2 = Conjg(coup1) 
    SumI = -VVVloop(p2,MVZ2,MVXp2)*coup1*coup2 
res = res +1._dp* SumI  
!------------------------ 
! VZp, VXp 
!------------------------ 
sumI = 0._dp 
 
coup1 = cplcVXpVXpVZp
coup2 = Conjg(coup1) 
    SumI = -VVVloop(p2,MVZp2,MVXp2)*coup1*coup2 
res = res +1._dp* SumI  
!------------------------ 
! conj[Hpm], VZ 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
 B0m2 = Real(VVSloop(p2,MVZ2,MHpm2(i1)),dp)
coup1 = cplcHpmcVXpVZ(i1)
    SumI = Abs(coup1)**2*B0m2 
res = res +1._dp* SumI  
      End Do 
 !------------------------ 
! conj[Hpm], VZp 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
 B0m2 = Real(VVSloop(p2,MVZp2,MHpm2(i1)),dp)
coup1 = cplcHpmcVXpVZp(i1)
    SumI = Abs(coup1)**2*B0m2 
res = res +1._dp* SumI  
      End Do 
 !------------------------ 
! conj[Hpm], conj[Dpm] 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
       Do i2 = 1, 2
 B22m2 = Real(VSSloop(p2,MDpm2(i2),MHpm2(i1)),dp)  
coup1 = cplcDpmcHpmcVXp(i2,i1)
    SumI = Abs(coup1)**2*B22m2 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! Ah 
!------------------------ 
    Do i1 = 1, 3
 SumI = 0._dp 
 A0m2 = SA_A0(MAh2(i1))
 coup1 = cplAhAhcVXpVXp(i1,i1)
 SumI = coup1*A0m2 
res = res +1._dp/2._dp* SumI  
      End Do 
 !------------------------ 
! conj[Dpm] 
!------------------------ 
    Do i1 = 1, 2
 SumI = 0._dp 
 A0m2 = SA_A0(MDpm2(i1))
 coup1 = cplDpmcDpmcVXpVXp(i1,i1)
 SumI = coup1*A0m2 
res = res +1* SumI  
      End Do 
 !------------------------ 
! hh 
!------------------------ 
    Do i1 = 1, 3
 SumI = 0._dp 
 A0m2 = SA_A0(Mhh2(i1))
 coup1 = cplhhhhcVXpVXp(i1,i1)
 SumI = coup1*A0m2 
res = res +1._dp/2._dp* SumI  
      End Do 
 !------------------------ 
! conj[Hpm] 
!------------------------ 
    Do i1 = 1, 4
 SumI = 0._dp 
 A0m2 = SA_A0(MHpm2(i1))
 coup1 = cplHpmcHpmcVXpVXp(i1,i1)
 SumI = coup1*A0m2 
res = res +1* SumI  
      End Do 
 !------------------------ 
! VP 
!------------------------ 
SumI = 0._dp 
A0m2 = 3._dp/4._dp*SA_A0(0._dp) +RXi/4._dp*SA_A0(0._dp*RXi) 
coup1 = cplcVXpVPVPVXp3
coup2 = cplcVXpVPVPVXp1
coup3 = cplcVXpVPVPVXp2
SumI = ((2._dp*rMS*coup1+(1-RXi**2)/8._dp*(coup2+coup3))*0._dp-(4._dp*coup1+coup2+coup3)*A0m2)
res = res +1._dp/2._dp* SumI  
!------------------------ 
! conj[VWp] 
!------------------------ 
SumI = 0._dp 
A0m2 = 3._dp/4._dp*SA_A0(MVWp2) +RXi/4._dp*SA_A0(MVWp2*RXi) 
coup1 = cplcVWpcVXpVWpVXp2
coup2 = cplcVWpcVXpVWpVXp3
coup3 = cplcVWpcVXpVWpVXp1
SumI = ((2._dp*rMS*coup1+(1-RXi**2)/8._dp*(coup2+coup3))*MVWp2-(4._dp*coup1+coup2+coup3)*A0m2)
res = res +1* SumI  
!------------------------ 
! conj[VXp] 
!------------------------ 
SumI = 0._dp 
A0m2 = 3._dp/4._dp*SA_A0(MVXp2) +RXi/4._dp*SA_A0(MVXp2*RXi) 
coup1 = cplcVXpcVXpVXpVXp2
coup2 = cplcVXpcVXpVXpVXp3
coup3 = cplcVXpcVXpVXpVXp1
SumI = ((2._dp*rMS*coup1+(1-RXi**2)/8._dp*(coup2+coup3))*MVXp2-(4._dp*coup1+coup2+coup3)*A0m2)
res = res +1* SumI  
!------------------------ 
! VZ 
!------------------------ 
SumI = 0._dp 
A0m2 = 3._dp/4._dp*SA_A0(MVZ2) +RXi/4._dp*SA_A0(MVZ2*RXi) 
coup1 = cplcVXpVXpVZVZ1
coup2 = cplcVXpVXpVZVZ2
coup3 = cplcVXpVXpVZVZ3
SumI = ((2._dp*rMS*coup1+(1-RXi**2)/8._dp*(coup2+coup3))*MVZ2-(4._dp*coup1+coup2+coup3)*A0m2)
res = res +1._dp/2._dp* SumI  
!------------------------ 
! VZp 
!------------------------ 
SumI = 0._dp 
A0m2 = 3._dp/4._dp*SA_A0(MVZp2) +RXi/4._dp*SA_A0(MVZp2*RXi) 
coup1 = cplcVXpVXpVZpVZp1
coup2 = cplcVXpVXpVZpVZp2
coup3 = cplcVXpVXpVZpVZp3
SumI = ((2._dp*rMS*coup1+(1-RXi**2)/8._dp*(coup2+coup3))*MVZp2-(4._dp*coup1+coup2+coup3)*A0m2)
res = res +1._dp/2._dp* SumI  
res = oo16pi2*res 
 
End Subroutine Pi1LoopVXp 
 
Subroutine DerPi1LoopVXp(p2,MHpm,MHpm2,MAh,MAh2,MFd,MFd2,MFu,MFu2,Mhh,Mhh2,           & 
& MVXp,MVXp2,MDpm,MDpm2,MVWp,MVWp2,MVZ,MVZ2,MVZp,MVZp2,cplAhcHpmcVXp,cplcFdFucVXpL,      & 
& cplcFdFucVXpR,cplcgXp2gAcVXp,cplcgAgXp1cVXp,cplcgZgXp1cVXp,cplcgZpgXp1cVXp,            & 
& cplcgXp2gZcVXp,cplcgXp2gZpcVXp,cplhhcHpmcVXp,cplhhcVXpVXp,cplcHpmcVXpVP,               & 
& cplcVXpVPVXp,cplcDpmcVXpVWp,cplcVXpVXpVZ,cplcVXpVXpVZp,cplcHpmcVXpVZ,cplcHpmcVXpVZp,   & 
& cplcDpmcHpmcVXp,cplAhAhcVXpVXp,cplDpmcDpmcVXpVXp,cplhhhhcVXpVXp,cplHpmcHpmcVXpVXp,     & 
& cplcVXpVPVPVXp3,cplcVXpVPVPVXp1,cplcVXpVPVPVXp2,cplcVWpcVXpVWpVXp2,cplcVWpcVXpVWpVXp3, & 
& cplcVWpcVXpVWpVXp1,cplcVXpcVXpVXpVXp2,cplcVXpcVXpVXpVXp3,cplcVXpcVXpVXpVXp1,           & 
& cplcVXpVXpVZVZ1,cplcVXpVXpVZVZ2,cplcVXpVXpVZVZ3,cplcVXpVXpVZpVZp1,cplcVXpVXpVZpVZp2,   & 
& cplcVXpVXpVZpVZp3,kont,res)

Implicit None 
Real(dp), Intent(in) :: MHpm(4),MHpm2(4),MAh(3),MAh2(3),MFd(5),MFd2(5),MFu(4),MFu2(4),Mhh(3),Mhh2(3),         & 
& MVXp,MVXp2,MDpm(2),MDpm2(2),MVWp,MVWp2,MVZ,MVZ2,MVZp,MVZp2

Complex(dp), Intent(in) :: cplAhcHpmcVXp(3,4),cplcFdFucVXpL(5,4),cplcFdFucVXpR(5,4),cplcgXp2gAcVXp,              & 
& cplcgAgXp1cVXp,cplcgZgXp1cVXp,cplcgZpgXp1cVXp,cplcgXp2gZcVXp,cplcgXp2gZpcVXp,          & 
& cplhhcHpmcVXp(3,4),cplhhcVXpVXp(3),cplcHpmcVXpVP(4),cplcVXpVPVXp,cplcDpmcVXpVWp(2),    & 
& cplcVXpVXpVZ,cplcVXpVXpVZp,cplcHpmcVXpVZ(4),cplcHpmcVXpVZp(4),cplcDpmcHpmcVXp(2,4),    & 
& cplAhAhcVXpVXp(3,3),cplDpmcDpmcVXpVXp(2,2),cplhhhhcVXpVXp(3,3),cplHpmcHpmcVXpVXp(4,4), & 
& cplcVXpVPVPVXp3,cplcVXpVPVPVXp1,cplcVXpVPVPVXp2,cplcVWpcVXpVWpVXp2,cplcVWpcVXpVWpVXp3, & 
& cplcVWpcVXpVWpVXp1,cplcVXpcVXpVXpVXp2,cplcVXpcVXpVXpVXp3,cplcVXpcVXpVXpVXp1,           & 
& cplcVXpVXpVZVZ1,cplcVXpVXpVZVZ2,cplcVXpVXpVZVZ3,cplcVXpVXpVZpVZp1,cplcVXpVXpVZpVZp2,   & 
& cplcVXpVXpVZpVZp3

Integer, Intent(inout) :: kont 
Real(dp) :: B0m2, F0m2, G0m2, B1m2, H0m2, B22m2, m1, m2 
Real(dp), Intent(in) :: p2 
Complex(dp) :: A0m2, A0m12, A0m22 
Complex(dp), Intent(inout) :: res 
Complex(dp) :: coupL1, coupR1, coupL2,coupR2, coup1,coup2, coup3, temp, sumI 
Integer :: i1,i2,i3,i4, gO1, gO2, ierr 
 
 
Real(dp) ::MVG,MVP,MVG2,MVP2
MVG = Mass_Regulator_PhotonGluon 
MVP = Mass_Regulator_PhotonGluon 
MVG2 = Mass_Regulator_PhotonGluon**2 
MVP2 = Mass_Regulator_PhotonGluon**2 

res = 0._dp 
 
!------------------------ 
! conj[Hpm], Ah 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
       Do i2 = 1, 3
 B22m2 = Real(DerVSSloop(p2,MAh2(i2),MHpm2(i1)),dp)  
coup1 = cplAhcHpmcVXp(i2,i1)
    SumI = Abs(coup1)**2*B22m2 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[Fd], Fu 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 5
       Do i2 = 1, 4
 H0m2 = Real(SA_DerHloop(p2,MFd2(i1),MFu2(i2)),dp) 
B0m2 = 4._dp*MFd(i1)*MFu(i2)*Real(SA_DerB0(p2,MFd2(i1),MFu2(i2)),dp) 
coupL1 = cplcFdFucVXpL(i1,i2)
coupR1 = cplcFdFucVXpR(i1,i2)
    SumI = (Abs(coupL1)**2+Abs(coupR1)**2)*H0m2 & 
                & + (Real(Conjg(coupL1)*coupR1,dp))*B0m2 
res = res +3._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[gXpC], gP 
!------------------------ 
sumI = 0._dp 
 
SumI = 0._dp 
B0m2 = Real(DerVGGloop(p2,MVP2,MVXp2),dp)
coup1 = cplcgXp2gAcVXp
coup2 = Conjg(coup1) 
   SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
!------------------------ 
! bar[gP], gXp 
!------------------------ 
sumI = 0._dp 
 
SumI = 0._dp 
B0m2 = Real(DerVGGloop(p2,MVXp2,MVP2),dp)
coup1 = cplcgAgXp1cVXp
coup2 = Conjg(coup1) 
   SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
!------------------------ 
! bar[gZ], gXp 
!------------------------ 
sumI = 0._dp 
 
SumI = 0._dp 
B0m2 = Real(DerVGGloop(p2,MVXp2,MVZ2),dp)
coup1 = cplcgZgXp1cVXp
coup2 = Conjg(coup1) 
   SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
!------------------------ 
! bar[gZp], gXp 
!------------------------ 
sumI = 0._dp 
 
SumI = 0._dp 
B0m2 = Real(DerVGGloop(p2,MVXp2,MVZp2),dp)
coup1 = cplcgZpgXp1cVXp
coup2 = Conjg(coup1) 
   SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
!------------------------ 
! bar[gXpC], gZ 
!------------------------ 
sumI = 0._dp 
 
SumI = 0._dp 
B0m2 = Real(DerVGGloop(p2,MVZ2,MVXp2),dp)
coup1 = cplcgXp2gZcVXp
coup2 = Conjg(coup1) 
   SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
!------------------------ 
! bar[gXpC], gZp 
!------------------------ 
sumI = 0._dp 
 
SumI = 0._dp 
B0m2 = Real(DerVGGloop(p2,MVZp2,MVXp2),dp)
coup1 = cplcgXp2gZpcVXp
coup2 = Conjg(coup1) 
   SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
!------------------------ 
! conj[Hpm], hh 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
       Do i2 = 1, 3
 B22m2 = Real(DerVSSloop(p2,Mhh2(i2),MHpm2(i1)),dp)  
coup1 = cplhhcHpmcVXp(i2,i1)
    SumI = Abs(coup1)**2*B22m2 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! VXp, hh 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 3
 B0m2 = Real(DerVVSloop(p2,MVXp2,Mhh2(i2)),dp)
coup1 = cplhhcVXpVXp(i2)
    SumI = Abs(coup1)**2*B0m2 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! conj[Hpm], VP 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
 B0m2 = Real(DerVVSloop(p2,MVP2,MHpm2(i1)),dp)
coup1 = cplcHpmcVXpVP(i1)
    SumI = Abs(coup1)**2*B0m2 
res = res +1._dp* SumI  
      End Do 
 !------------------------ 
! VXp, VP 
!------------------------ 
sumI = 0._dp 
 
coup1 = cplcVXpVPVXp
coup2 = Conjg(coup1) 
    SumI = -DerVVVloop(p2,MVXp2,MVP2)*coup1*coup2 
res = res +1._dp* SumI  
!------------------------ 
! conj[Dpm], VWp 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 2
 B0m2 = Real(DerVVSloop(p2,MVWp2,MDpm2(i1)),dp)
coup1 = cplcDpmcVXpVWp(i1)
    SumI = Abs(coup1)**2*B0m2 
res = res +1._dp* SumI  
      End Do 
 !------------------------ 
! VZ, VXp 
!------------------------ 
sumI = 0._dp 
 
coup1 = cplcVXpVXpVZ
coup2 = Conjg(coup1) 
    SumI = -DerVVVloop(p2,MVZ2,MVXp2)*coup1*coup2 
res = res +1._dp* SumI  
!------------------------ 
! VZp, VXp 
!------------------------ 
sumI = 0._dp 
 
coup1 = cplcVXpVXpVZp
coup2 = Conjg(coup1) 
    SumI = -DerVVVloop(p2,MVZp2,MVXp2)*coup1*coup2 
res = res +1._dp* SumI  
!------------------------ 
! conj[Hpm], VZ 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
 B0m2 = Real(DerVVSloop(p2,MVZ2,MHpm2(i1)),dp)
coup1 = cplcHpmcVXpVZ(i1)
    SumI = Abs(coup1)**2*B0m2 
res = res +1._dp* SumI  
      End Do 
 !------------------------ 
! conj[Hpm], VZp 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
 B0m2 = Real(DerVVSloop(p2,MVZp2,MHpm2(i1)),dp)
coup1 = cplcHpmcVXpVZp(i1)
    SumI = Abs(coup1)**2*B0m2 
res = res +1._dp* SumI  
      End Do 
 !------------------------ 
! conj[Hpm], conj[Dpm] 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
       Do i2 = 1, 2
 B22m2 = Real(DerVSSloop(p2,MDpm2(i2),MHpm2(i1)),dp)  
coup1 = cplcDpmcHpmcVXp(i2,i1)
    SumI = Abs(coup1)**2*B22m2 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! Ah 
!------------------------ 
    Do i1 = 1, 3
 SumI = 0._dp 
 A0m2 = SA_DerA0(MAh2(i1))
 coup1 = cplAhAhcVXpVXp(i1,i1)
 SumI = coup1*A0m2 
res = res +1._dp/2._dp* SumI  
      End Do 
 !------------------------ 
! conj[Dpm] 
!------------------------ 
    Do i1 = 1, 2
 SumI = 0._dp 
 A0m2 = SA_DerA0(MDpm2(i1))
 coup1 = cplDpmcDpmcVXpVXp(i1,i1)
 SumI = coup1*A0m2 
res = res +1* SumI  
      End Do 
 !------------------------ 
! hh 
!------------------------ 
    Do i1 = 1, 3
 SumI = 0._dp 
 A0m2 = SA_DerA0(Mhh2(i1))
 coup1 = cplhhhhcVXpVXp(i1,i1)
 SumI = coup1*A0m2 
res = res +1._dp/2._dp* SumI  
      End Do 
 !------------------------ 
! conj[Hpm] 
!------------------------ 
    Do i1 = 1, 4
 SumI = 0._dp 
 A0m2 = SA_DerA0(MHpm2(i1))
 coup1 = cplHpmcHpmcVXpVXp(i1,i1)
 SumI = coup1*A0m2 
res = res +1* SumI  
      End Do 
 !------------------------ 
! VP 
!------------------------ 
SumI = 0._dp 
A0m2 = 3._dp/4._dp*SA_DerA0(MVP2) +RXi/4._dp*SA_DerA0(MVP2*RXi) 
coup1 = cplcVXpVPVPVXp3
coup2 = cplcVXpVPVPVXp1
coup3 = cplcVXpVPVPVXp2
SumI = ((2._dp*DerrMS*coup1+(1-RXi**2)/8._dp*(coup2+coup3))*MVP2-(4._dp*coup1+coup2+coup3)*A0m2)
res = res +1._dp/2._dp* SumI  
!------------------------ 
! conj[VWp] 
!------------------------ 
SumI = 0._dp 
A0m2 = 3._dp/4._dp*SA_DerA0(MVWp2) +RXi/4._dp*SA_DerA0(MVWp2*RXi) 
coup1 = cplcVWpcVXpVWpVXp2
coup2 = cplcVWpcVXpVWpVXp3
coup3 = cplcVWpcVXpVWpVXp1
SumI = ((2._dp*DerrMS*coup1+(1-RXi**2)/8._dp*(coup2+coup3))*MVWp2-(4._dp*coup1+coup2+coup3)*A0m2)
res = res +1* SumI  
!------------------------ 
! conj[VXp] 
!------------------------ 
SumI = 0._dp 
A0m2 = 3._dp/4._dp*SA_DerA0(MVXp2) +RXi/4._dp*SA_DerA0(MVXp2*RXi) 
coup1 = cplcVXpcVXpVXpVXp2
coup2 = cplcVXpcVXpVXpVXp3
coup3 = cplcVXpcVXpVXpVXp1
SumI = ((2._dp*DerrMS*coup1+(1-RXi**2)/8._dp*(coup2+coup3))*MVXp2-(4._dp*coup1+coup2+coup3)*A0m2)
res = res +1* SumI  
!------------------------ 
! VZ 
!------------------------ 
SumI = 0._dp 
A0m2 = 3._dp/4._dp*SA_DerA0(MVZ2) +RXi/4._dp*SA_DerA0(MVZ2*RXi) 
coup1 = cplcVXpVXpVZVZ1
coup2 = cplcVXpVXpVZVZ2
coup3 = cplcVXpVXpVZVZ3
SumI = ((2._dp*DerrMS*coup1+(1-RXi**2)/8._dp*(coup2+coup3))*MVZ2-(4._dp*coup1+coup2+coup3)*A0m2)
res = res +1._dp/2._dp* SumI  
!------------------------ 
! VZp 
!------------------------ 
SumI = 0._dp 
A0m2 = 3._dp/4._dp*SA_DerA0(MVZp2) +RXi/4._dp*SA_DerA0(MVZp2*RXi) 
coup1 = cplcVXpVXpVZpVZp1
coup2 = cplcVXpVXpVZpVZp2
coup3 = cplcVXpVXpVZpVZp3
SumI = ((2._dp*DerrMS*coup1+(1-RXi**2)/8._dp*(coup2+coup3))*MVZp2-(4._dp*coup1+coup2+coup3)*A0m2)
res = res +1._dp/2._dp* SumI  
res = oo16pi2*res 
 
End Subroutine DerPi1LoopVXp 
 
Subroutine Sigma1LoopFeMZ(p2,MFe,MFe2,MAh,MAh2,Mhh,Mhh2,MVZ,MVZ2,MVZp,MVZp2,          & 
& MVWp,MVWp2,MHpm,MHpm2,cplcUFeFeAhL,cplcUFeFeAhR,cplcUFeFehhL,cplcUFeFehhR,             & 
& cplcUFeFeVPL,cplcUFeFeVPR,cplcUFeFeVZL,cplcUFeFeVZR,cplcUFeFeVZpL,cplcUFeFeVZpR,       & 
& cplcUFeFv1cVWpL,cplcUFeFv1cVWpR,cplcUFeFv1HpmL,cplcUFeFv1HpmR,cplcUFecFv1HpmL,         & 
& cplcUFecFv1HpmR,sigL,sigR,sigSL,sigSR)

Implicit None 
Real(dp), Intent(in) :: MFe(3),MFe2(3),MAh(3),MAh2(3),Mhh(3),Mhh2(3),MVZ,MVZ2,MVZp,MVZp2,MVWp,MVWp2,          & 
& MHpm(4),MHpm2(4)

Complex(dp), Intent(in) :: cplcUFeFeAhL(3,3,3),cplcUFeFeAhR(3,3,3),cplcUFeFehhL(3,3,3),cplcUFeFehhR(3,3,3),      & 
& cplcUFeFeVPL(3,3),cplcUFeFeVPR(3,3),cplcUFeFeVZL(3,3),cplcUFeFeVZR(3,3),               & 
& cplcUFeFeVZpL(3,3),cplcUFeFeVZpR(3,3),cplcUFeFv1cVWpL(3,3),cplcUFeFv1cVWpR(3,3),       & 
& cplcUFeFv1HpmL(3,3,4),cplcUFeFv1HpmR(3,3,4),cplcUFecFv1HpmL(3,3,4),cplcUFecFv1HpmR(3,3,4)

Complex(dp), Intent(out) :: SigL(3,3),SigR(3,3), SigSL(3,3), SigSR(3,3) 
Complex(dp) :: coupL1, coupR1, coupL2,coupR2, coup1,coup2,temp, sumL(3,3), sumR(3,3), sumSL(3,3), sumSR(3,3) 
Real(dp) :: B0m2, F0m2, G0m2,B1m2, m1, m2 
Real(dp), Intent(in) :: p2 
Complex(dp) :: A0m2 
Integer :: i1,i2,i3,i4, gO1, gO2, ierr 
 
 
SigL = Cmplx(0._dp,0._dp,dp) 
SigR = Cmplx(0._dp,0._dp,dp) 
SigSL = Cmplx(0._dp,0._dp,dp) 
 SigSR = Cmplx(0._dp,0._dp,dp) 
 
!------------------------ 
! Fe, Ah 
!------------------------ 
    Do i1 = 1, 3
       Do i2 = 1, 3
 SumSL = 0._dp 
SumSR = 0._dp 
sumR = 0._dp 
sumL = 0._dp 
Do gO1 = 1, 3
  Do gO2 = 1, 3
If(gO1.eq.gO2) Then 
B1m2 = -Real(SA_B1(MFe2(gO1),MFe2(i1),MAh2(i2)),dp) 
B0m2 = MFe(i1)*Real(SA_B0(MFe2(gO1),MFe2(i1),MAh2(i2)),dp) 
Else 
B1m2 = -Real(SA_B1(p2,MFe2(i1),MAh2(i2)),dp) 
B0m2 = MFe(i1)*Real(SA_B0(p2,MFe2(i1),MAh2(i2)),dp) 
End If 
coupL1 = cplcUFeFeAhL(gO1,i1,i2)
coupR1 = cplcUFeFeAhR(gO1,i1,i2)
coupL2 =  Conjg(cplcUFeFeAhL(gO2,i1,i2))
coupR2 =  Conjg(cplcUFeFeAhR(gO2,i1,i2))
SumSL(gO1,gO2) = coupR1*coupL2*B0m2 
SumSR(gO1,gO2) = coupL1*coupR2*B0m2 
sumR(gO1,gO2) = coupR1*coupR2*B1m2 
sumL(gO1,gO2) = coupL1*coupL2*B1m2 
   End Do 
End Do 
SigL = SigL +1._dp* sumL
SigR = SigR +1._dp* sumR 
SigSL = SigSL +1._dp* sumSL 
SigSR = SigSR +1._dp* sumSR 
      End Do 
     End Do 
 !------------------------ 
! hh, Fe 
!------------------------ 
    Do i1 = 1, 3
       Do i2 = 1, 3
 SumSL = 0._dp 
SumSR = 0._dp 
sumR = 0._dp 
sumL = 0._dp 
Do gO1 = 1, 3
  Do gO2 = 1, 3
If(gO1.eq.gO2) Then 
B1m2 = -Real(SA_B1(MFe2(gO1),MFe2(i2),Mhh2(i1)),dp) 
B0m2 = MFe(i2)*Real(SA_B0(MFe2(gO1),MFe2(i2),Mhh2(i1)),dp) 
Else 
B1m2 = -Real(SA_B1(p2,MFe2(i2),Mhh2(i1)),dp) 
B0m2 = MFe(i2)*Real(SA_B0(p2,MFe2(i2),Mhh2(i1)),dp) 
End If 
coupL1 = cplcUFeFehhL(gO1,i2,i1)
coupR1 = cplcUFeFehhR(gO1,i2,i1)
coupL2 =  Conjg(cplcUFeFehhL(gO2,i2,i1))
coupR2 =  Conjg(cplcUFeFehhR(gO2,i2,i1))
SumSL(gO1,gO2) = coupR1*coupL2*B0m2 
SumSR(gO1,gO2) = coupL1*coupR2*B0m2 
sumR(gO1,gO2) = coupR1*coupR2*B1m2 
sumL(gO1,gO2) = coupL1*coupL2*B1m2 
   End Do 
End Do 
SigL = SigL +1._dp* sumL
SigR = SigR +1._dp* sumR 
SigSL = SigSL +1._dp* sumSL 
SigSR = SigSR +1._dp* sumSR 
      End Do 
     End Do 
 !------------------------ 
! VZ, Fe 
!------------------------ 
      Do i2 = 1, 3
 SumSL = 0._dp 
SumSR = 0._dp 
sumR = 0._dp 
sumL = 0._dp 
Do gO1 = 1, 3
  Do gO2 = 1, 3
If(gO1.eq.gO2) Then 
B1m2 = -2._dp*Real(SA_B1(MFe2(gO1),MFe2(i2),MVZ2),dp) 
B0m2 = -4._dp*MFe(i2)*Real(SA_B0(MFe2(gO1),MFe2(i2),MVZ2)-0.5_dp*rMS,dp) 
Else 
B1m2 = -2._dp*Real(SA_B1(p2,MFe2(i2),MVZ2)+ 0.5_dp*rMS,dp) 
B0m2 = -4._dp*MFe(i2)*Real(SA_B0(p2,MFe2(i2),MVZ2)-0.5_dp*rMS,dp) 
End If 
coupL1 = cplcUFeFeVZL(gO1,i2)
coupR1 = cplcUFeFeVZR(gO1,i2)
coupL2 =  Conjg(cplcUFeFeVZL(gO2,i2))
coupR2 =  Conjg(cplcUFeFeVZR(gO2,i2))
SumSL(gO1,gO2) = coupL1*coupR2*B0m2 
SumSR(gO1,gO2) = coupR1*coupL2*B0m2 
sumR(gO1,gO2) = coupL1*coupL2*B1m2 
sumL(gO1,gO2) = coupR1*coupR2*B1m2 
   End Do 
End Do 
SigL = SigL +1._dp* sumL
SigR = SigR +1._dp* sumR 
SigSL = SigSL +1._dp* sumSL 
SigSR = SigSR +1._dp* sumSR 
    End Do 
 !------------------------ 
! VZp, Fe 
!------------------------ 
      Do i2 = 1, 3
 SumSL = 0._dp 
SumSR = 0._dp 
sumR = 0._dp 
sumL = 0._dp 
Do gO1 = 1, 3
  Do gO2 = 1, 3
If(gO1.eq.gO2) Then 
B1m2 = -2._dp*Real(SA_B1(MFe2(gO1),MFe2(i2),MVZp2),dp) 
B0m2 = -4._dp*MFe(i2)*Real(SA_B0(MFe2(gO1),MFe2(i2),MVZp2)-0.5_dp*rMS,dp) 
Else 
B1m2 = -2._dp*Real(SA_B1(p2,MFe2(i2),MVZp2)+ 0.5_dp*rMS,dp) 
B0m2 = -4._dp*MFe(i2)*Real(SA_B0(p2,MFe2(i2),MVZp2)-0.5_dp*rMS,dp) 
End If 
coupL1 = cplcUFeFeVZpL(gO1,i2)
coupR1 = cplcUFeFeVZpR(gO1,i2)
coupL2 =  Conjg(cplcUFeFeVZpL(gO2,i2))
coupR2 =  Conjg(cplcUFeFeVZpR(gO2,i2))
SumSL(gO1,gO2) = coupL1*coupR2*B0m2 
SumSR(gO1,gO2) = coupR1*coupL2*B0m2 
sumR(gO1,gO2) = coupL1*coupL2*B1m2 
sumL(gO1,gO2) = coupR1*coupR2*B1m2 
   End Do 
End Do 
SigL = SigL +1._dp* sumL
SigR = SigR +1._dp* sumR 
SigSL = SigSL +1._dp* sumSL 
SigSR = SigSR +1._dp* sumSR 
    End Do 
 !------------------------ 
! conj[VWp], Fv1 
!------------------------ 
      Do i2 = 1, 3
 SumSL = 0._dp 
SumSR = 0._dp 
sumR = 0._dp 
sumL = 0._dp 
Do gO1 = 1, 3
  Do gO2 = 1, 3
If(gO1.eq.gO2) Then 
B1m2 = -2._dp*Real(SA_B1(MFe2(gO1),0._dp,MVWp2),dp) 
B0m2 = -4._dp*0._dp*Real(SA_B0(MFe2(gO1),0._dp,MVWp2)-0.5_dp*rMS,dp) 
Else 
B1m2 = -2._dp*Real(SA_B1(p2,0._dp,MVWp2)+ 0.5_dp*rMS,dp) 
B0m2 = -4._dp*0._dp*Real(SA_B0(p2,0._dp,MVWp2)-0.5_dp*rMS,dp) 
End If 
coupL1 = cplcUFeFv1cVWpL(gO1,i2)
coupR1 = cplcUFeFv1cVWpR(gO1,i2)
coupL2 =  Conjg(cplcUFeFv1cVWpL(gO2,i2))
coupR2 =  Conjg(cplcUFeFv1cVWpR(gO2,i2))
SumSL(gO1,gO2) = coupL1*coupR2*B0m2 
SumSR(gO1,gO2) = coupR1*coupL2*B0m2 
sumR(gO1,gO2) = coupL1*coupL2*B1m2 
sumL(gO1,gO2) = coupR1*coupR2*B1m2 
   End Do 
End Do 
SigL = SigL +1._dp* sumL
SigR = SigR +1._dp* sumR 
SigSL = SigSL +1._dp* sumSL 
SigSR = SigSR +1._dp* sumSR 
    End Do 
 !------------------------ 
! Hpm, Fv1 
!------------------------ 
    Do i1 = 1, 4
       Do i2 = 1, 3
 SumSL = 0._dp 
SumSR = 0._dp 
sumR = 0._dp 
sumL = 0._dp 
Do gO1 = 1, 3
  Do gO2 = 1, 3
If(gO1.eq.gO2) Then 
B1m2 = -Real(SA_B1(MFe2(gO1),0._dp,MHpm2(i1)),dp) 
B0m2 = 0._dp*Real(SA_B0(MFe2(gO1),0._dp,MHpm2(i1)),dp) 
Else 
B1m2 = -Real(SA_B1(p2,0._dp,MHpm2(i1)),dp) 
B0m2 = 0._dp*Real(SA_B0(p2,0._dp,MHpm2(i1)),dp) 
End If 
coupL1 = cplcUFeFv1HpmL(gO1,i2,i1)
coupR1 = cplcUFeFv1HpmR(gO1,i2,i1)
coupL2 =  Conjg(cplcUFeFv1HpmL(gO2,i2,i1))
coupR2 =  Conjg(cplcUFeFv1HpmR(gO2,i2,i1))
SumSL(gO1,gO2) = coupR1*coupL2*B0m2 
SumSR(gO1,gO2) = coupL1*coupR2*B0m2 
sumR(gO1,gO2) = coupR1*coupR2*B1m2 
sumL(gO1,gO2) = coupL1*coupL2*B1m2 
   End Do 
End Do 
SigL = SigL +1._dp* sumL
SigR = SigR +1._dp* sumR 
SigSL = SigSL +1._dp* sumSL 
SigSR = SigSR +1._dp* sumSR 
      End Do 
     End Do 
 !------------------------ 
! bar[Fv1], Hpm 
!------------------------ 
    Do i1 = 1, 3
       Do i2 = 1, 4
 SumSL = 0._dp 
SumSR = 0._dp 
sumR = 0._dp 
sumL = 0._dp 
Do gO1 = 1, 3
  Do gO2 = 1, 3
If(gO1.eq.gO2) Then 
B1m2 = -Real(SA_B1(MFe2(gO1),0._dp,MHpm2(i2)),dp) 
B0m2 = 0._dp*Real(SA_B0(MFe2(gO1),0._dp,MHpm2(i2)),dp) 
Else 
B1m2 = -Real(SA_B1(p2,0._dp,MHpm2(i2)),dp) 
B0m2 = 0._dp*Real(SA_B0(p2,0._dp,MHpm2(i2)),dp) 
End If 
coupL1 = cplcUFecFv1HpmL(gO1,i1,i2)
coupR1 = cplcUFecFv1HpmR(gO1,i1,i2)
coupL2 =  Conjg(cplcUFecFv1HpmL(gO2,i1,i2))
coupR2 =  Conjg(cplcUFecFv1HpmR(gO2,i1,i2))
SumSL(gO1,gO2) = coupR1*coupL2*B0m2 
SumSR(gO1,gO2) = coupL1*coupR2*B0m2 
sumR(gO1,gO2) = coupR1*coupR2*B1m2 
sumL(gO1,gO2) = coupL1*coupL2*B1m2 
   End Do 
End Do 
SigL = SigL +1._dp* sumL
SigR = SigR +1._dp* sumR 
SigSL = SigSL +1._dp* sumSL 
SigSR = SigSR +1._dp* sumSR 
      End Do 
     End Do 
 SigL = oo16pi2*SigL 
SigR = oo16pi2*SigR 
SigSL = oo16pi2*SigSL 
SigSR = oo16pi2*SigSR 
 
End Subroutine Sigma1LoopFeMZ 
 
Subroutine Sigma1LoopFdMZ(p2,MFd,MFd2,MAh,MAh2,MDpm,MDpm2,Mhh,Mhh2,MVZ,               & 
& MVZ2,MVZp,MVZp2,MVWp,MVWp2,MFu,MFu2,MVXp,MVXp2,MHpm,MHpm2,cplcUFdFdAhL,cplcUFdFdAhR,   & 
& cplcUFdFdDpmL,cplcUFdFdDpmR,cplcUFdFdhhL,cplcUFdFdhhR,cplcUFdFdVGL,cplcUFdFdVGR,       & 
& cplcUFdFdVPL,cplcUFdFdVPR,cplcUFdFdVZL,cplcUFdFdVZR,cplcUFdFdVZpL,cplcUFdFdVZpR,       & 
& cplcUFdFucVWpL,cplcUFdFucVWpR,cplcUFdFucVXpL,cplcUFdFucVXpR,cplcUFdFuHpmL,             & 
& cplcUFdFuHpmR,sigL,sigR,sigSL,sigSR)

Implicit None 
Real(dp), Intent(in) :: MFd(5),MFd2(5),MAh(3),MAh2(3),MDpm(2),MDpm2(2),Mhh(3),Mhh2(3),MVZ,MVZ2,               & 
& MVZp,MVZp2,MVWp,MVWp2,MFu(4),MFu2(4),MVXp,MVXp2,MHpm(4),MHpm2(4)

Complex(dp), Intent(in) :: cplcUFdFdAhL(5,5,3),cplcUFdFdAhR(5,5,3),cplcUFdFdDpmL(5,5,2),cplcUFdFdDpmR(5,5,2),    & 
& cplcUFdFdhhL(5,5,3),cplcUFdFdhhR(5,5,3),cplcUFdFdVGL(5,5),cplcUFdFdVGR(5,5),           & 
& cplcUFdFdVPL(5,5),cplcUFdFdVPR(5,5),cplcUFdFdVZL(5,5),cplcUFdFdVZR(5,5),               & 
& cplcUFdFdVZpL(5,5),cplcUFdFdVZpR(5,5),cplcUFdFucVWpL(5,4),cplcUFdFucVWpR(5,4),         & 
& cplcUFdFucVXpL(5,4),cplcUFdFucVXpR(5,4),cplcUFdFuHpmL(5,4,4),cplcUFdFuHpmR(5,4,4)

Complex(dp), Intent(out) :: SigL(5,5),SigR(5,5), SigSL(5,5), SigSR(5,5) 
Complex(dp) :: coupL1, coupR1, coupL2,coupR2, coup1,coup2,temp, sumL(5,5), sumR(5,5), sumSL(5,5), sumSR(5,5) 
Real(dp) :: B0m2, F0m2, G0m2,B1m2, m1, m2 
Real(dp), Intent(in) :: p2 
Complex(dp) :: A0m2 
Integer :: i1,i2,i3,i4, gO1, gO2, ierr 
 
 
SigL = Cmplx(0._dp,0._dp,dp) 
SigR = Cmplx(0._dp,0._dp,dp) 
SigSL = Cmplx(0._dp,0._dp,dp) 
 SigSR = Cmplx(0._dp,0._dp,dp) 
 
!------------------------ 
! Fd, Ah 
!------------------------ 
    Do i1 = 1, 5
       Do i2 = 1, 3
 SumSL = 0._dp 
SumSR = 0._dp 
sumR = 0._dp 
sumL = 0._dp 
Do gO1 = 1, 5
  Do gO2 = 1, 5
If(gO1.eq.gO2) Then 
B1m2 = -Real(SA_B1(MFd2(gO1),MFd2(i1),MAh2(i2)),dp) 
B0m2 = MFd(i1)*Real(SA_B0(MFd2(gO1),MFd2(i1),MAh2(i2)),dp) 
Else 
B1m2 = -Real(SA_B1(p2,MFd2(i1),MAh2(i2)),dp) 
B0m2 = MFd(i1)*Real(SA_B0(p2,MFd2(i1),MAh2(i2)),dp) 
End If 
coupL1 = cplcUFdFdAhL(gO1,i1,i2)
coupR1 = cplcUFdFdAhR(gO1,i1,i2)
coupL2 =  Conjg(cplcUFdFdAhL(gO2,i1,i2))
coupR2 =  Conjg(cplcUFdFdAhR(gO2,i1,i2))
SumSL(gO1,gO2) = coupR1*coupL2*B0m2 
SumSR(gO1,gO2) = coupL1*coupR2*B0m2 
sumR(gO1,gO2) = coupR1*coupR2*B1m2 
sumL(gO1,gO2) = coupL1*coupL2*B1m2 
   End Do 
End Do 
SigL = SigL +1._dp* sumL
SigR = SigR +1._dp* sumR 
SigSL = SigSL +1._dp* sumSL 
SigSR = SigSR +1._dp* sumSR 
      End Do 
     End Do 
 !------------------------ 
! Fd, Dpm 
!------------------------ 
    Do i1 = 1, 5
       Do i2 = 1, 2
 SumSL = 0._dp 
SumSR = 0._dp 
sumR = 0._dp 
sumL = 0._dp 
Do gO1 = 1, 5
  Do gO2 = 1, 5
If(gO1.eq.gO2) Then 
B1m2 = -Real(SA_B1(MFd2(gO1),MFd2(i1),MDpm2(i2)),dp) 
B0m2 = MFd(i1)*Real(SA_B0(MFd2(gO1),MFd2(i1),MDpm2(i2)),dp) 
Else 
B1m2 = -Real(SA_B1(p2,MFd2(i1),MDpm2(i2)),dp) 
B0m2 = MFd(i1)*Real(SA_B0(p2,MFd2(i1),MDpm2(i2)),dp) 
End If 
coupL1 = cplcUFdFdDpmL(gO1,i1,i2)
coupR1 = cplcUFdFdDpmR(gO1,i1,i2)
coupL2 =  Conjg(cplcUFdFdDpmL(gO2,i1,i2))
coupR2 =  Conjg(cplcUFdFdDpmR(gO2,i1,i2))
SumSL(gO1,gO2) = coupR1*coupL2*B0m2 
SumSR(gO1,gO2) = coupL1*coupR2*B0m2 
sumR(gO1,gO2) = coupR1*coupR2*B1m2 
sumL(gO1,gO2) = coupL1*coupL2*B1m2 
   End Do 
End Do 
SigL = SigL +1._dp* sumL
SigR = SigR +1._dp* sumR 
SigSL = SigSL +1._dp* sumSL 
SigSR = SigSR +1._dp* sumSR 
      End Do 
     End Do 
 !------------------------ 
! hh, Fd 
!------------------------ 
    Do i1 = 1, 3
       Do i2 = 1, 5
 SumSL = 0._dp 
SumSR = 0._dp 
sumR = 0._dp 
sumL = 0._dp 
Do gO1 = 1, 5
  Do gO2 = 1, 5
If(gO1.eq.gO2) Then 
B1m2 = -Real(SA_B1(MFd2(gO1),MFd2(i2),Mhh2(i1)),dp) 
B0m2 = MFd(i2)*Real(SA_B0(MFd2(gO1),MFd2(i2),Mhh2(i1)),dp) 
Else 
B1m2 = -Real(SA_B1(p2,MFd2(i2),Mhh2(i1)),dp) 
B0m2 = MFd(i2)*Real(SA_B0(p2,MFd2(i2),Mhh2(i1)),dp) 
End If 
coupL1 = cplcUFdFdhhL(gO1,i2,i1)
coupR1 = cplcUFdFdhhR(gO1,i2,i1)
coupL2 =  Conjg(cplcUFdFdhhL(gO2,i2,i1))
coupR2 =  Conjg(cplcUFdFdhhR(gO2,i2,i1))
SumSL(gO1,gO2) = coupR1*coupL2*B0m2 
SumSR(gO1,gO2) = coupL1*coupR2*B0m2 
sumR(gO1,gO2) = coupR1*coupR2*B1m2 
sumL(gO1,gO2) = coupL1*coupL2*B1m2 
   End Do 
End Do 
SigL = SigL +1._dp* sumL
SigR = SigR +1._dp* sumR 
SigSL = SigSL +1._dp* sumSL 
SigSR = SigSR +1._dp* sumSR 
      End Do 
     End Do 
 !------------------------ 
! VZ, Fd 
!------------------------ 
      Do i2 = 1, 5
 SumSL = 0._dp 
SumSR = 0._dp 
sumR = 0._dp 
sumL = 0._dp 
Do gO1 = 1, 5
  Do gO2 = 1, 5
If(gO1.eq.gO2) Then 
B1m2 = -2._dp*Real(SA_B1(MFd2(gO1),MFd2(i2),MVZ2),dp) 
B0m2 = -4._dp*MFd(i2)*Real(SA_B0(MFd2(gO1),MFd2(i2),MVZ2)-0.5_dp*rMS,dp) 
Else 
B1m2 = -2._dp*Real(SA_B1(p2,MFd2(i2),MVZ2)+ 0.5_dp*rMS,dp) 
B0m2 = -4._dp*MFd(i2)*Real(SA_B0(p2,MFd2(i2),MVZ2)-0.5_dp*rMS,dp) 
End If 
coupL1 = cplcUFdFdVZL(gO1,i2)
coupR1 = cplcUFdFdVZR(gO1,i2)
coupL2 =  Conjg(cplcUFdFdVZL(gO2,i2))
coupR2 =  Conjg(cplcUFdFdVZR(gO2,i2))
SumSL(gO1,gO2) = coupL1*coupR2*B0m2 
SumSR(gO1,gO2) = coupR1*coupL2*B0m2 
sumR(gO1,gO2) = coupL1*coupL2*B1m2 
sumL(gO1,gO2) = coupR1*coupR2*B1m2 
   End Do 
End Do 
SigL = SigL +1._dp* sumL
SigR = SigR +1._dp* sumR 
SigSL = SigSL +1._dp* sumSL 
SigSR = SigSR +1._dp* sumSR 
    End Do 
 !------------------------ 
! VZp, Fd 
!------------------------ 
      Do i2 = 1, 5
 SumSL = 0._dp 
SumSR = 0._dp 
sumR = 0._dp 
sumL = 0._dp 
Do gO1 = 1, 5
  Do gO2 = 1, 5
If(gO1.eq.gO2) Then 
B1m2 = -2._dp*Real(SA_B1(MFd2(gO1),MFd2(i2),MVZp2),dp) 
B0m2 = -4._dp*MFd(i2)*Real(SA_B0(MFd2(gO1),MFd2(i2),MVZp2)-0.5_dp*rMS,dp) 
Else 
B1m2 = -2._dp*Real(SA_B1(p2,MFd2(i2),MVZp2)+ 0.5_dp*rMS,dp) 
B0m2 = -4._dp*MFd(i2)*Real(SA_B0(p2,MFd2(i2),MVZp2)-0.5_dp*rMS,dp) 
End If 
coupL1 = cplcUFdFdVZpL(gO1,i2)
coupR1 = cplcUFdFdVZpR(gO1,i2)
coupL2 =  Conjg(cplcUFdFdVZpL(gO2,i2))
coupR2 =  Conjg(cplcUFdFdVZpR(gO2,i2))
SumSL(gO1,gO2) = coupL1*coupR2*B0m2 
SumSR(gO1,gO2) = coupR1*coupL2*B0m2 
sumR(gO1,gO2) = coupL1*coupL2*B1m2 
sumL(gO1,gO2) = coupR1*coupR2*B1m2 
   End Do 
End Do 
SigL = SigL +1._dp* sumL
SigR = SigR +1._dp* sumR 
SigSL = SigSL +1._dp* sumSL 
SigSR = SigSR +1._dp* sumSR 
    End Do 
 !------------------------ 
! conj[VWp], Fu 
!------------------------ 
      Do i2 = 1, 4
 SumSL = 0._dp 
SumSR = 0._dp 
sumR = 0._dp 
sumL = 0._dp 
Do gO1 = 1, 5
  Do gO2 = 1, 5
If(gO1.eq.gO2) Then 
B1m2 = -2._dp*Real(SA_B1(MFd2(gO1),MFu2(i2),MVWp2),dp) 
B0m2 = -4._dp*MFu(i2)*Real(SA_B0(MFd2(gO1),MFu2(i2),MVWp2)-0.5_dp*rMS,dp) 
Else 
B1m2 = -2._dp*Real(SA_B1(p2,MFu2(i2),MVWp2)+ 0.5_dp*rMS,dp) 
B0m2 = -4._dp*MFu(i2)*Real(SA_B0(p2,MFu2(i2),MVWp2)-0.5_dp*rMS,dp) 
End If 
coupL1 = cplcUFdFucVWpL(gO1,i2)
coupR1 = cplcUFdFucVWpR(gO1,i2)
coupL2 =  Conjg(cplcUFdFucVWpL(gO2,i2))
coupR2 =  Conjg(cplcUFdFucVWpR(gO2,i2))
SumSL(gO1,gO2) = coupL1*coupR2*B0m2 
SumSR(gO1,gO2) = coupR1*coupL2*B0m2 
sumR(gO1,gO2) = coupL1*coupL2*B1m2 
sumL(gO1,gO2) = coupR1*coupR2*B1m2 
   End Do 
End Do 
SigL = SigL +1._dp* sumL
SigR = SigR +1._dp* sumR 
SigSL = SigSL +1._dp* sumSL 
SigSR = SigSR +1._dp* sumSR 
    End Do 
 !------------------------ 
! conj[VXp], Fu 
!------------------------ 
      Do i2 = 1, 4
 SumSL = 0._dp 
SumSR = 0._dp 
sumR = 0._dp 
sumL = 0._dp 
Do gO1 = 1, 5
  Do gO2 = 1, 5
If(gO1.eq.gO2) Then 
B1m2 = -2._dp*Real(SA_B1(MFd2(gO1),MFu2(i2),MVXp2),dp) 
B0m2 = -4._dp*MFu(i2)*Real(SA_B0(MFd2(gO1),MFu2(i2),MVXp2)-0.5_dp*rMS,dp) 
Else 
B1m2 = -2._dp*Real(SA_B1(p2,MFu2(i2),MVXp2)+ 0.5_dp*rMS,dp) 
B0m2 = -4._dp*MFu(i2)*Real(SA_B0(p2,MFu2(i2),MVXp2)-0.5_dp*rMS,dp) 
End If 
coupL1 = cplcUFdFucVXpL(gO1,i2)
coupR1 = cplcUFdFucVXpR(gO1,i2)
coupL2 =  Conjg(cplcUFdFucVXpL(gO2,i2))
coupR2 =  Conjg(cplcUFdFucVXpR(gO2,i2))
SumSL(gO1,gO2) = coupL1*coupR2*B0m2 
SumSR(gO1,gO2) = coupR1*coupL2*B0m2 
sumR(gO1,gO2) = coupL1*coupL2*B1m2 
sumL(gO1,gO2) = coupR1*coupR2*B1m2 
   End Do 
End Do 
SigL = SigL +1._dp* sumL
SigR = SigR +1._dp* sumR 
SigSL = SigSL +1._dp* sumSL 
SigSR = SigSR +1._dp* sumSR 
    End Do 
 !------------------------ 
! Hpm, Fu 
!------------------------ 
    Do i1 = 1, 4
       Do i2 = 1, 4
 SumSL = 0._dp 
SumSR = 0._dp 
sumR = 0._dp 
sumL = 0._dp 
Do gO1 = 1, 5
  Do gO2 = 1, 5
If(gO1.eq.gO2) Then 
B1m2 = -Real(SA_B1(MFd2(gO1),MFu2(i2),MHpm2(i1)),dp) 
B0m2 = MFu(i2)*Real(SA_B0(MFd2(gO1),MFu2(i2),MHpm2(i1)),dp) 
Else 
B1m2 = -Real(SA_B1(p2,MFu2(i2),MHpm2(i1)),dp) 
B0m2 = MFu(i2)*Real(SA_B0(p2,MFu2(i2),MHpm2(i1)),dp) 
End If 
coupL1 = cplcUFdFuHpmL(gO1,i2,i1)
coupR1 = cplcUFdFuHpmR(gO1,i2,i1)
coupL2 =  Conjg(cplcUFdFuHpmL(gO2,i2,i1))
coupR2 =  Conjg(cplcUFdFuHpmR(gO2,i2,i1))
SumSL(gO1,gO2) = coupR1*coupL2*B0m2 
SumSR(gO1,gO2) = coupL1*coupR2*B0m2 
sumR(gO1,gO2) = coupR1*coupR2*B1m2 
sumL(gO1,gO2) = coupL1*coupL2*B1m2 
   End Do 
End Do 
SigL = SigL +1._dp* sumL
SigR = SigR +1._dp* sumR 
SigSL = SigSL +1._dp* sumSL 
SigSR = SigSR +1._dp* sumSR 
      End Do 
     End Do 
 SigL = oo16pi2*SigL 
SigR = oo16pi2*SigR 
SigSL = oo16pi2*SigSL 
SigSR = oo16pi2*SigSR 
 
End Subroutine Sigma1LoopFdMZ 
 
Subroutine Sigma1LoopFuMZ(p2,MFu,MFu2,MAh,MAh2,MDpm,MDpm2,MHpm,MHpm2,MFd,             & 
& MFd2,MVWp,MVWp2,MVXp,MVXp2,Mhh,Mhh2,MVZ,MVZ2,MVZp,MVZp2,cplcUFuFuAhL,cplcUFuFuAhR,     & 
& cplcUFuFuDpmL,cplcUFuFuDpmR,cplcUFuFdcHpmL,cplcUFuFdcHpmR,cplcUFuFdVWpL,               & 
& cplcUFuFdVWpR,cplcUFuFdVXpL,cplcUFuFdVXpR,cplcUFuFuhhL,cplcUFuFuhhR,cplcUFuFuVGL,      & 
& cplcUFuFuVGR,cplcUFuFuVPL,cplcUFuFuVPR,cplcUFuFuVZL,cplcUFuFuVZR,cplcUFuFuVZpL,        & 
& cplcUFuFuVZpR,sigL,sigR,sigSL,sigSR)

Implicit None 
Real(dp), Intent(in) :: MFu(4),MFu2(4),MAh(3),MAh2(3),MDpm(2),MDpm2(2),MHpm(4),MHpm2(4),MFd(5),               & 
& MFd2(5),MVWp,MVWp2,MVXp,MVXp2,Mhh(3),Mhh2(3),MVZ,MVZ2,MVZp,MVZp2

Complex(dp), Intent(in) :: cplcUFuFuAhL(4,4,3),cplcUFuFuAhR(4,4,3),cplcUFuFuDpmL(4,4,2),cplcUFuFuDpmR(4,4,2),    & 
& cplcUFuFdcHpmL(4,5,4),cplcUFuFdcHpmR(4,5,4),cplcUFuFdVWpL(4,5),cplcUFuFdVWpR(4,5),     & 
& cplcUFuFdVXpL(4,5),cplcUFuFdVXpR(4,5),cplcUFuFuhhL(4,4,3),cplcUFuFuhhR(4,4,3),         & 
& cplcUFuFuVGL(4,4),cplcUFuFuVGR(4,4),cplcUFuFuVPL(4,4),cplcUFuFuVPR(4,4),               & 
& cplcUFuFuVZL(4,4),cplcUFuFuVZR(4,4),cplcUFuFuVZpL(4,4),cplcUFuFuVZpR(4,4)

Complex(dp), Intent(out) :: SigL(4,4),SigR(4,4), SigSL(4,4), SigSR(4,4) 
Complex(dp) :: coupL1, coupR1, coupL2,coupR2, coup1,coup2,temp, sumL(4,4), sumR(4,4), sumSL(4,4), sumSR(4,4) 
Real(dp) :: B0m2, F0m2, G0m2,B1m2, m1, m2 
Real(dp), Intent(in) :: p2 
Complex(dp) :: A0m2 
Integer :: i1,i2,i3,i4, gO1, gO2, ierr 
 
 
SigL = Cmplx(0._dp,0._dp,dp) 
SigR = Cmplx(0._dp,0._dp,dp) 
SigSL = Cmplx(0._dp,0._dp,dp) 
 SigSR = Cmplx(0._dp,0._dp,dp) 
 
!------------------------ 
! Fu, Ah 
!------------------------ 
    Do i1 = 1, 4
       Do i2 = 1, 3
 SumSL = 0._dp 
SumSR = 0._dp 
sumR = 0._dp 
sumL = 0._dp 
Do gO1 = 1, 4
  Do gO2 = 1, 4
If(gO1.eq.gO2) Then 
B1m2 = -Real(SA_B1(MFu2(gO1),MFu2(i1),MAh2(i2)),dp) 
B0m2 = MFu(i1)*Real(SA_B0(MFu2(gO1),MFu2(i1),MAh2(i2)),dp) 
Else 
B1m2 = -Real(SA_B1(p2,MFu2(i1),MAh2(i2)),dp) 
B0m2 = MFu(i1)*Real(SA_B0(p2,MFu2(i1),MAh2(i2)),dp) 
End If 
coupL1 = cplcUFuFuAhL(gO1,i1,i2)
coupR1 = cplcUFuFuAhR(gO1,i1,i2)
coupL2 =  Conjg(cplcUFuFuAhL(gO2,i1,i2))
coupR2 =  Conjg(cplcUFuFuAhR(gO2,i1,i2))
SumSL(gO1,gO2) = coupR1*coupL2*B0m2 
SumSR(gO1,gO2) = coupL1*coupR2*B0m2 
sumR(gO1,gO2) = coupR1*coupR2*B1m2 
sumL(gO1,gO2) = coupL1*coupL2*B1m2 
   End Do 
End Do 
SigL = SigL +1._dp* sumL
SigR = SigR +1._dp* sumR 
SigSL = SigSL +1._dp* sumSL 
SigSR = SigSR +1._dp* sumSR 
      End Do 
     End Do 
 !------------------------ 
! Fu, Dpm 
!------------------------ 
    Do i1 = 1, 4
       Do i2 = 1, 2
 SumSL = 0._dp 
SumSR = 0._dp 
sumR = 0._dp 
sumL = 0._dp 
Do gO1 = 1, 4
  Do gO2 = 1, 4
If(gO1.eq.gO2) Then 
B1m2 = -Real(SA_B1(MFu2(gO1),MFu2(i1),MDpm2(i2)),dp) 
B0m2 = MFu(i1)*Real(SA_B0(MFu2(gO1),MFu2(i1),MDpm2(i2)),dp) 
Else 
B1m2 = -Real(SA_B1(p2,MFu2(i1),MDpm2(i2)),dp) 
B0m2 = MFu(i1)*Real(SA_B0(p2,MFu2(i1),MDpm2(i2)),dp) 
End If 
coupL1 = cplcUFuFuDpmL(gO1,i1,i2)
coupR1 = cplcUFuFuDpmR(gO1,i1,i2)
coupL2 =  Conjg(cplcUFuFuDpmL(gO2,i1,i2))
coupR2 =  Conjg(cplcUFuFuDpmR(gO2,i1,i2))
SumSL(gO1,gO2) = coupR1*coupL2*B0m2 
SumSR(gO1,gO2) = coupL1*coupR2*B0m2 
sumR(gO1,gO2) = coupR1*coupR2*B1m2 
sumL(gO1,gO2) = coupL1*coupL2*B1m2 
   End Do 
End Do 
SigL = SigL +1._dp* sumL
SigR = SigR +1._dp* sumR 
SigSL = SigSL +1._dp* sumSL 
SigSR = SigSR +1._dp* sumSR 
      End Do 
     End Do 
 !------------------------ 
! conj[Hpm], Fd 
!------------------------ 
    Do i1 = 1, 4
       Do i2 = 1, 5
 SumSL = 0._dp 
SumSR = 0._dp 
sumR = 0._dp 
sumL = 0._dp 
Do gO1 = 1, 4
  Do gO2 = 1, 4
If(gO1.eq.gO2) Then 
B1m2 = -Real(SA_B1(MFu2(gO1),MFd2(i2),MHpm2(i1)),dp) 
B0m2 = MFd(i2)*Real(SA_B0(MFu2(gO1),MFd2(i2),MHpm2(i1)),dp) 
Else 
B1m2 = -Real(SA_B1(p2,MFd2(i2),MHpm2(i1)),dp) 
B0m2 = MFd(i2)*Real(SA_B0(p2,MFd2(i2),MHpm2(i1)),dp) 
End If 
coupL1 = cplcUFuFdcHpmL(gO1,i2,i1)
coupR1 = cplcUFuFdcHpmR(gO1,i2,i1)
coupL2 =  Conjg(cplcUFuFdcHpmL(gO2,i2,i1))
coupR2 =  Conjg(cplcUFuFdcHpmR(gO2,i2,i1))
SumSL(gO1,gO2) = coupR1*coupL2*B0m2 
SumSR(gO1,gO2) = coupL1*coupR2*B0m2 
sumR(gO1,gO2) = coupR1*coupR2*B1m2 
sumL(gO1,gO2) = coupL1*coupL2*B1m2 
   End Do 
End Do 
SigL = SigL +1._dp* sumL
SigR = SigR +1._dp* sumR 
SigSL = SigSL +1._dp* sumSL 
SigSR = SigSR +1._dp* sumSR 
      End Do 
     End Do 
 !------------------------ 
! VWp, Fd 
!------------------------ 
      Do i2 = 1, 5
 SumSL = 0._dp 
SumSR = 0._dp 
sumR = 0._dp 
sumL = 0._dp 
Do gO1 = 1, 4
  Do gO2 = 1, 4
If(gO1.eq.gO2) Then 
B1m2 = -2._dp*Real(SA_B1(MFu2(gO1),MFd2(i2),MVWp2),dp) 
B0m2 = -4._dp*MFd(i2)*Real(SA_B0(MFu2(gO1),MFd2(i2),MVWp2)-0.5_dp*rMS,dp) 
Else 
B1m2 = -2._dp*Real(SA_B1(p2,MFd2(i2),MVWp2)+ 0.5_dp*rMS,dp) 
B0m2 = -4._dp*MFd(i2)*Real(SA_B0(p2,MFd2(i2),MVWp2)-0.5_dp*rMS,dp) 
End If 
coupL1 = cplcUFuFdVWpL(gO1,i2)
coupR1 = cplcUFuFdVWpR(gO1,i2)
coupL2 =  Conjg(cplcUFuFdVWpL(gO2,i2))
coupR2 =  Conjg(cplcUFuFdVWpR(gO2,i2))
SumSL(gO1,gO2) = coupL1*coupR2*B0m2 
SumSR(gO1,gO2) = coupR1*coupL2*B0m2 
sumR(gO1,gO2) = coupL1*coupL2*B1m2 
sumL(gO1,gO2) = coupR1*coupR2*B1m2 
   End Do 
End Do 
SigL = SigL +1._dp* sumL
SigR = SigR +1._dp* sumR 
SigSL = SigSL +1._dp* sumSL 
SigSR = SigSR +1._dp* sumSR 
    End Do 
 !------------------------ 
! VXp, Fd 
!------------------------ 
      Do i2 = 1, 5
 SumSL = 0._dp 
SumSR = 0._dp 
sumR = 0._dp 
sumL = 0._dp 
Do gO1 = 1, 4
  Do gO2 = 1, 4
If(gO1.eq.gO2) Then 
B1m2 = -2._dp*Real(SA_B1(MFu2(gO1),MFd2(i2),MVXp2),dp) 
B0m2 = -4._dp*MFd(i2)*Real(SA_B0(MFu2(gO1),MFd2(i2),MVXp2)-0.5_dp*rMS,dp) 
Else 
B1m2 = -2._dp*Real(SA_B1(p2,MFd2(i2),MVXp2)+ 0.5_dp*rMS,dp) 
B0m2 = -4._dp*MFd(i2)*Real(SA_B0(p2,MFd2(i2),MVXp2)-0.5_dp*rMS,dp) 
End If 
coupL1 = cplcUFuFdVXpL(gO1,i2)
coupR1 = cplcUFuFdVXpR(gO1,i2)
coupL2 =  Conjg(cplcUFuFdVXpL(gO2,i2))
coupR2 =  Conjg(cplcUFuFdVXpR(gO2,i2))
SumSL(gO1,gO2) = coupL1*coupR2*B0m2 
SumSR(gO1,gO2) = coupR1*coupL2*B0m2 
sumR(gO1,gO2) = coupL1*coupL2*B1m2 
sumL(gO1,gO2) = coupR1*coupR2*B1m2 
   End Do 
End Do 
SigL = SigL +1._dp* sumL
SigR = SigR +1._dp* sumR 
SigSL = SigSL +1._dp* sumSL 
SigSR = SigSR +1._dp* sumSR 
    End Do 
 !------------------------ 
! hh, Fu 
!------------------------ 
    Do i1 = 1, 3
       Do i2 = 1, 4
 SumSL = 0._dp 
SumSR = 0._dp 
sumR = 0._dp 
sumL = 0._dp 
Do gO1 = 1, 4
  Do gO2 = 1, 4
If(gO1.eq.gO2) Then 
B1m2 = -Real(SA_B1(MFu2(gO1),MFu2(i2),Mhh2(i1)),dp) 
B0m2 = MFu(i2)*Real(SA_B0(MFu2(gO1),MFu2(i2),Mhh2(i1)),dp) 
Else 
B1m2 = -Real(SA_B1(p2,MFu2(i2),Mhh2(i1)),dp) 
B0m2 = MFu(i2)*Real(SA_B0(p2,MFu2(i2),Mhh2(i1)),dp) 
End If 
coupL1 = cplcUFuFuhhL(gO1,i2,i1)
coupR1 = cplcUFuFuhhR(gO1,i2,i1)
coupL2 =  Conjg(cplcUFuFuhhL(gO2,i2,i1))
coupR2 =  Conjg(cplcUFuFuhhR(gO2,i2,i1))
SumSL(gO1,gO2) = coupR1*coupL2*B0m2 
SumSR(gO1,gO2) = coupL1*coupR2*B0m2 
sumR(gO1,gO2) = coupR1*coupR2*B1m2 
sumL(gO1,gO2) = coupL1*coupL2*B1m2 
   End Do 
End Do 
SigL = SigL +1._dp* sumL
SigR = SigR +1._dp* sumR 
SigSL = SigSL +1._dp* sumSL 
SigSR = SigSR +1._dp* sumSR 
      End Do 
     End Do 
 !------------------------ 
! VZ, Fu 
!------------------------ 
      Do i2 = 1, 4
 SumSL = 0._dp 
SumSR = 0._dp 
sumR = 0._dp 
sumL = 0._dp 
Do gO1 = 1, 4
  Do gO2 = 1, 4
If(gO1.eq.gO2) Then 
B1m2 = -2._dp*Real(SA_B1(MFu2(gO1),MFu2(i2),MVZ2),dp) 
B0m2 = -4._dp*MFu(i2)*Real(SA_B0(MFu2(gO1),MFu2(i2),MVZ2)-0.5_dp*rMS,dp) 
Else 
B1m2 = -2._dp*Real(SA_B1(p2,MFu2(i2),MVZ2)+ 0.5_dp*rMS,dp) 
B0m2 = -4._dp*MFu(i2)*Real(SA_B0(p2,MFu2(i2),MVZ2)-0.5_dp*rMS,dp) 
End If 
coupL1 = cplcUFuFuVZL(gO1,i2)
coupR1 = cplcUFuFuVZR(gO1,i2)
coupL2 =  Conjg(cplcUFuFuVZL(gO2,i2))
coupR2 =  Conjg(cplcUFuFuVZR(gO2,i2))
SumSL(gO1,gO2) = coupL1*coupR2*B0m2 
SumSR(gO1,gO2) = coupR1*coupL2*B0m2 
sumR(gO1,gO2) = coupL1*coupL2*B1m2 
sumL(gO1,gO2) = coupR1*coupR2*B1m2 
   End Do 
End Do 
SigL = SigL +1._dp* sumL
SigR = SigR +1._dp* sumR 
SigSL = SigSL +1._dp* sumSL 
SigSR = SigSR +1._dp* sumSR 
    End Do 
 !------------------------ 
! VZp, Fu 
!------------------------ 
      Do i2 = 1, 4
 SumSL = 0._dp 
SumSR = 0._dp 
sumR = 0._dp 
sumL = 0._dp 
Do gO1 = 1, 4
  Do gO2 = 1, 4
If(gO1.eq.gO2) Then 
B1m2 = -2._dp*Real(SA_B1(MFu2(gO1),MFu2(i2),MVZp2),dp) 
B0m2 = -4._dp*MFu(i2)*Real(SA_B0(MFu2(gO1),MFu2(i2),MVZp2)-0.5_dp*rMS,dp) 
Else 
B1m2 = -2._dp*Real(SA_B1(p2,MFu2(i2),MVZp2)+ 0.5_dp*rMS,dp) 
B0m2 = -4._dp*MFu(i2)*Real(SA_B0(p2,MFu2(i2),MVZp2)-0.5_dp*rMS,dp) 
End If 
coupL1 = cplcUFuFuVZpL(gO1,i2)
coupR1 = cplcUFuFuVZpR(gO1,i2)
coupL2 =  Conjg(cplcUFuFuVZpL(gO2,i2))
coupR2 =  Conjg(cplcUFuFuVZpR(gO2,i2))
SumSL(gO1,gO2) = coupL1*coupR2*B0m2 
SumSR(gO1,gO2) = coupR1*coupL2*B0m2 
sumR(gO1,gO2) = coupL1*coupL2*B1m2 
sumL(gO1,gO2) = coupR1*coupR2*B1m2 
   End Do 
End Do 
SigL = SigL +1._dp* sumL
SigR = SigR +1._dp* sumR 
SigSL = SigSL +1._dp* sumSL 
SigSR = SigSR +1._dp* sumSR 
    End Do 
 SigL = oo16pi2*SigL 
SigR = oo16pi2*SigR 
SigSL = oo16pi2*SigSL 
SigSR = oo16pi2*SigSR 
 
End Subroutine Sigma1LoopFuMZ 
 
Subroutine Pi1LoopVPVZ(p2,MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,MFe2,MFu,MFu2,             & 
& Mhh,Mhh2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,cplAhAhVPVZ,             & 
& cplAhhhVP,cplAhhhVZ,cplcFdFdVPL,cplcFdFdVPR,cplcFdFdVZL,cplcFdFdVZR,cplcFeFeVPL,       & 
& cplcFeFeVPR,cplcFeFeVZL,cplcFeFeVZR,cplcFuFuVPL,cplcFuFuVPR,cplcFuFuVZL,               & 
& cplcFuFuVZR,cplcFv1Fv1VPL,cplcFv1Fv1VPR,cplcFv1Fv1VZL,cplcFv1Fv1VZR,cplcgWCgWCVP,      & 
& cplcgWCgWCVZ,cplcgWpgWpVP,cplcgWpgWpVZ,cplcgXp1gXp1VP,cplcgXp1gXp1VZ,cplcgXp2gXp2VP,   & 
& cplcgXp2gXp2VZ,cplcHpmcVWpVP,cplcHpmcVWpVZ,cplcHpmcVXpVP,cplcHpmcVXpVZ,cplcVWpVPVWp,   & 
& cplcVWpVPVWpVZ1,cplcVWpVPVWpVZ2,cplcVWpVPVWpVZ3,cplcVWpVWpVZ,cplcVXpVPVXp,             & 
& cplcVXpVPVXpVZ1,cplcVXpVPVXpVZ2,cplcVXpVPVXpVZ3,cplcVXpVXpVZ,cplDpmcDpmVP,             & 
& cplDpmcDpmVPVZ,cplDpmcDpmVZ,cplhhhhVPVZ,cplhhVPVZ,cplhhVPVZp,cplhhVZVZ,cplhhVZVZp,     & 
& cplHpmcHpmVP,cplHpmcHpmVPVZ,cplHpmcHpmVZ,cplHpmVPVWp,cplHpmVPVXp,cplHpmVWpVZ,          & 
& cplHpmVXpVZ,kont,res)

Implicit None 
Real(dp), Intent(in) :: MAh(3),MAh2(3),MDpm(2),MDpm2(2),MFd(5),MFd2(5),MFe(3),MFe2(3),MFu(4),MFu2(4),         & 
& Mhh(3),Mhh2(3),MHpm(4),MHpm2(4),MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2

Complex(dp), Intent(in) :: cplAhAhVPVZ(3,3),cplAhhhVP(3,3),cplAhhhVZ(3,3),cplcFdFdVPL(5,5),cplcFdFdVPR(5,5),     & 
& cplcFdFdVZL(5,5),cplcFdFdVZR(5,5),cplcFeFeVPL(3,3),cplcFeFeVPR(3,3),cplcFeFeVZL(3,3),  & 
& cplcFeFeVZR(3,3),cplcFuFuVPL(4,4),cplcFuFuVPR(4,4),cplcFuFuVZL(4,4),cplcFuFuVZR(4,4),  & 
& cplcFv1Fv1VPL(3,3),cplcFv1Fv1VPR(3,3),cplcFv1Fv1VZL(3,3),cplcFv1Fv1VZR(3,3),           & 
& cplcgWCgWCVP,cplcgWCgWCVZ,cplcgWpgWpVP,cplcgWpgWpVZ,cplcgXp1gXp1VP,cplcgXp1gXp1VZ,     & 
& cplcgXp2gXp2VP,cplcgXp2gXp2VZ,cplcHpmcVWpVP(4),cplcHpmcVWpVZ(4),cplcHpmcVXpVP(4),      & 
& cplcHpmcVXpVZ(4),cplcVWpVPVWp,cplcVWpVPVWpVZ1,cplcVWpVPVWpVZ2,cplcVWpVPVWpVZ3,         & 
& cplcVWpVWpVZ,cplcVXpVPVXp,cplcVXpVPVXpVZ1,cplcVXpVPVXpVZ2,cplcVXpVPVXpVZ3,             & 
& cplcVXpVXpVZ,cplDpmcDpmVP(2,2),cplDpmcDpmVPVZ(2,2),cplDpmcDpmVZ(2,2),cplhhhhVPVZ(3,3), & 
& cplhhVPVZ(3),cplhhVPVZp(3),cplhhVZVZ(3),cplhhVZVZp(3),cplHpmcHpmVP(4,4),               & 
& cplHpmcHpmVPVZ(4,4),cplHpmcHpmVZ(4,4),cplHpmVPVWp(4),cplHpmVPVXp(4),cplHpmVWpVZ(4),    & 
& cplHpmVXpVZ(4)

Integer, Intent(inout) :: kont 
Real(dp) :: B0m2, F0m2, G0m2, B1m2, H0m2, B22m2, m1, m2 
Real(dp), Intent(in) :: p2 
Complex(dp) :: A0m2 
Complex(dp), Intent(inout) :: res 
Complex(dp) :: coupL1, coupR1, coupL2,coupR2, coup1,coup2, coup3, temp, sumI 
Integer :: i1,i2,i3,i4, gO1, gO2, ierr 
 
 
res = 0._dp 
 
!------------------------ 
! hh, Ah 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 3
       Do i2 = 1, 3
 B22m2 = Real(VSSloop(p2,MAh2(i2),Mhh2(i1)),dp) 
coup1 = cplAhhhVP(i2,i1)
coup2 = cplAhhhVZ(i2,i1)
    SumI = coup1*coup2*B22m2 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! conj[Dpm], Dpm 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 2
       Do i2 = 1, 2
 B22m2 = Real(VSSloop(p2,MDpm2(i2),MDpm2(i1)),dp) 
coup1 = cplDpmcDpmVP(i2,i1)
coup2 = cplDpmcDpmVZ(i1,i2)
    SumI = coup1*coup2*B22m2 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[Fd], Fd 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 5
       Do i2 = 1, 5
 H0m2 = Real(SA_Hloop(p2,MFd2(i1),MFd2(i2)),dp) 
B0m2 = 4._dp*MFd(i1)*MFd(i2)*Real(SA_B0(p2,MFd2(i1),MFd2(i2)),dp) 
coupL1 = cplcFdFdVPL(i1,i2)
coupR1 = cplcFdFdVPR(i1,i2)
coupL2 = cplcFdFdVZL(i2,i1)
coupR2 = cplcFdFdVZR(i2,i1)
    SumI = (coupL1*coupL2+coupR1*coupR2)*H0m2 & 
                & + 0.5_dp*(coupL1*coupR2 + coupL2*coupR1)*B0m2 
res = res +3._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[Fe], Fe 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 3
       Do i2 = 1, 3
 H0m2 = Real(SA_Hloop(p2,MFe2(i1),MFe2(i2)),dp) 
B0m2 = 4._dp*MFe(i1)*MFe(i2)*Real(SA_B0(p2,MFe2(i1),MFe2(i2)),dp) 
coupL1 = cplcFeFeVPL(i1,i2)
coupR1 = cplcFeFeVPR(i1,i2)
coupL2 = cplcFeFeVZL(i2,i1)
coupR2 = cplcFeFeVZR(i2,i1)
    SumI = (coupL1*coupL2+coupR1*coupR2)*H0m2 & 
                & + 0.5_dp*(coupL1*coupR2 + coupL2*coupR1)*B0m2 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[Fu], Fu 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
       Do i2 = 1, 4
 H0m2 = Real(SA_Hloop(p2,MFu2(i1),MFu2(i2)),dp) 
B0m2 = 4._dp*MFu(i1)*MFu(i2)*Real(SA_B0(p2,MFu2(i1),MFu2(i2)),dp) 
coupL1 = cplcFuFuVPL(i1,i2)
coupR1 = cplcFuFuVPR(i1,i2)
coupL2 = cplcFuFuVZL(i2,i1)
coupR2 = cplcFuFuVZR(i2,i1)
    SumI = (coupL1*coupL2+coupR1*coupR2)*H0m2 & 
                & + 0.5_dp*(coupL1*coupR2 + coupL2*coupR1)*B0m2 
res = res +3._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[Fv1], Fv1 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 3
       Do i2 = 1, 3
 H0m2 = Real(SA_Hloop(p2,0._dp,0._dp),dp) 
B0m2 = 4._dp*0._dp*0._dp*Real(SA_B0(p2,0._dp,0._dp),dp) 
coupL1 = cplcFv1Fv1VPL(i1,i2)
coupR1 = cplcFv1Fv1VPR(i1,i2)
coupL2 = cplcFv1Fv1VZL(i2,i1)
coupR2 = cplcFv1Fv1VZR(i2,i1)
    SumI = (coupL1*coupL2+coupR1*coupR2)*H0m2 & 
                & + 0.5_dp*(coupL1*coupR2 + coupL2*coupR1)*B0m2 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[gWp], gWp 
!------------------------ 
sumI = 0._dp 
 
B0m2 = Real(VGGloop(p2,MVWp2,MVWp2),dp)
coup1 = cplcgWpgWpVP
coup2 = cplcgWpgWpVZ 
   SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
!------------------------ 
! bar[gWpC], gWpC 
!------------------------ 
sumI = 0._dp 
 
B0m2 = Real(VGGloop(p2,MVWp2,MVWp2),dp)
coup1 = cplcgWCgWCVP
coup2 = cplcgWCgWCVZ 
   SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
!------------------------ 
! bar[gXp], gXp 
!------------------------ 
sumI = 0._dp 
 
B0m2 = Real(VGGloop(p2,MVXp2,MVXp2),dp)
coup1 = cplcgXp1gXp1VP
coup2 = cplcgXp1gXp1VZ 
   SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
!------------------------ 
! bar[gXpC], gXpC 
!------------------------ 
sumI = 0._dp 
 
B0m2 = Real(VGGloop(p2,MVXp2,MVXp2),dp)
coup1 = cplcgXp2gXp2VP
coup2 = cplcgXp2gXp2VZ 
   SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
!------------------------ 
! VZ, hh 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 3
 B0m2 = Real(VVSloop(p2,MVZ2,Mhh2(i2)),dp) 
coup1 = cplhhVPVZ(i2)
coup2 = cplhhVZVZ(i2)
    SumI = coup1*coup2*B0m2 
res = res +0.5_dp* SumI  
    End Do 
 !------------------------ 
! VZp, hh 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 3
 B0m2 = Real(VVSloop(p2,MVZp2,Mhh2(i2)),dp) 
coup1 = cplhhVPVZp(i2)
coup2 = cplhhVZVZp(i2)
    SumI = coup1*coup2*B0m2 
res = res +0.5_dp* SumI  
    End Do 
 !------------------------ 
! conj[Hpm], Hpm 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
       Do i2 = 1, 4
 B22m2 = Real(VSSloop(p2,MHpm2(i2),MHpm2(i1)),dp) 
coup1 = cplHpmcHpmVP(i2,i1)
coup2 = cplHpmcHpmVZ(i1,i2)
    SumI = coup1*coup2*B22m2 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! VWp, Hpm 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 B0m2 = Real(VVSloop(p2,MVWp2,MHpm2(i2)),dp) 
coup1 = cplHpmVPVWp(i2)
coup2 = cplcHpmcVWpVZ(i2)
    SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! VXp, Hpm 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 B0m2 = Real(VVSloop(p2,MVXp2,MHpm2(i2)),dp) 
coup1 = cplHpmVPVXp(i2)
coup2 = cplcHpmcVXpVZ(i2)
    SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! conj[VWp], VWp 
!------------------------ 
sumI = 0._dp 
 
B0m2 = Real(VVVloop(p2,MVWp2,MVWp2),dp) 
coup1 = cplcVWpVPVWp
coup2 = cplcVWpVWpVZ
    SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
!------------------------ 
! conj[VXp], VXp 
!------------------------ 
sumI = 0._dp 
 
B0m2 = Real(VVVloop(p2,MVXp2,MVXp2),dp) 
coup1 = cplcVXpVPVXp
coup2 = cplcVXpVXpVZ
    SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
!------------------------ 
! conj[VWp], conj[Hpm] 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 B0m2 = Real(VVSloop(p2,MVWp2,MHpm2(i2)),dp) 
coup1 = cplcHpmcVWpVP(i2)
coup2 = cplHpmVWpVZ(i2)
    SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! conj[VXp], conj[Hpm] 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 B0m2 = Real(VVSloop(p2,MVXp2,MHpm2(i2)),dp) 
coup1 = cplcHpmcVXpVP(i2)
coup2 = cplHpmVXpVZ(i2)
    SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! Ah 
!------------------------ 
    Do i1 = 1, 3
 SumI = 0._dp 
 A0m2 = SA_A0(MAh2(i1))
 coup1 = cplAhAhVPVZ(i1,i1)
 SumI = coup1*A0m2 
res = res +1._dp/2._dp* SumI  
      End Do 
 !------------------------ 
! conj[Dpm] 
!------------------------ 
    Do i1 = 1, 2
 SumI = 0._dp 
 A0m2 = SA_A0(MDpm2(i1))
 coup1 = cplDpmcDpmVPVZ(i1,i1)
 SumI = coup1*A0m2 
res = res +1* SumI  
      End Do 
 !------------------------ 
! hh 
!------------------------ 
    Do i1 = 1, 3
 SumI = 0._dp 
 A0m2 = SA_A0(Mhh2(i1))
 coup1 = cplhhhhVPVZ(i1,i1)
 SumI = coup1*A0m2 
res = res +1._dp/2._dp* SumI  
      End Do 
 !------------------------ 
! conj[Hpm] 
!------------------------ 
    Do i1 = 1, 4
 SumI = 0._dp 
 A0m2 = SA_A0(MHpm2(i1))
 coup1 = cplHpmcHpmVPVZ(i1,i1)
 SumI = coup1*A0m2 
res = res +1* SumI  
      End Do 
 !------------------------ 
! conj[VWp] 
!------------------------ 
SumI = 0._dp 
A0m2 = 3._dp/4._dp*SA_A0(MVWp2) +RXi/4._dp*SA_A0(MVWp2*RXi) 
coup1 = cplcVWpVPVWpVZ2
coup2 = cplcVWpVPVWpVZ1
coup3 = cplcVWpVPVWpVZ3
SumI = ((2._dp*rMS*coup1+(1-RXi**2)/8._dp*(coup2+coup3))*MVWp2-(4._dp*coup1+coup2+coup3)*A0m2)
res = res +1* SumI  
!------------------------ 
! conj[VXp] 
!------------------------ 
SumI = 0._dp 
A0m2 = 3._dp/4._dp*SA_A0(MVXp2) +RXi/4._dp*SA_A0(MVXp2*RXi) 
coup1 = cplcVXpVPVXpVZ2
coup2 = cplcVXpVPVXpVZ1
coup3 = cplcVXpVPVXpVZ3
SumI = ((2._dp*rMS*coup1+(1-RXi**2)/8._dp*(coup2+coup3))*MVXp2-(4._dp*coup1+coup2+coup3)*A0m2)
res = res +1* SumI  
res = oo16pi2*res 
 
End Subroutine Pi1LoopVPVZ 
 
Subroutine DerPi1LoopVPVZ(p2,MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,MFe2,MFu,               & 
& MFu2,Mhh,Mhh2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,cplAhAhVPVZ,        & 
& cplAhhhVP,cplAhhhVZ,cplcFdFdVPL,cplcFdFdVPR,cplcFdFdVZL,cplcFdFdVZR,cplcFeFeVPL,       & 
& cplcFeFeVPR,cplcFeFeVZL,cplcFeFeVZR,cplcFuFuVPL,cplcFuFuVPR,cplcFuFuVZL,               & 
& cplcFuFuVZR,cplcFv1Fv1VPL,cplcFv1Fv1VPR,cplcFv1Fv1VZL,cplcFv1Fv1VZR,cplcgWCgWCVP,      & 
& cplcgWCgWCVZ,cplcgWpgWpVP,cplcgWpgWpVZ,cplcgXp1gXp1VP,cplcgXp1gXp1VZ,cplcgXp2gXp2VP,   & 
& cplcgXp2gXp2VZ,cplcHpmcVWpVP,cplcHpmcVWpVZ,cplcHpmcVXpVP,cplcHpmcVXpVZ,cplcVWpVPVWp,   & 
& cplcVWpVPVWpVZ1,cplcVWpVPVWpVZ2,cplcVWpVPVWpVZ3,cplcVWpVWpVZ,cplcVXpVPVXp,             & 
& cplcVXpVPVXpVZ1,cplcVXpVPVXpVZ2,cplcVXpVPVXpVZ3,cplcVXpVXpVZ,cplDpmcDpmVP,             & 
& cplDpmcDpmVPVZ,cplDpmcDpmVZ,cplhhhhVPVZ,cplhhVPVZ,cplhhVPVZp,cplhhVZVZ,cplhhVZVZp,     & 
& cplHpmcHpmVP,cplHpmcHpmVPVZ,cplHpmcHpmVZ,cplHpmVPVWp,cplHpmVPVXp,cplHpmVWpVZ,          & 
& cplHpmVXpVZ,kont,res)

Implicit None 
Real(dp), Intent(in) :: MAh(3),MAh2(3),MDpm(2),MDpm2(2),MFd(5),MFd2(5),MFe(3),MFe2(3),MFu(4),MFu2(4),         & 
& Mhh(3),Mhh2(3),MHpm(4),MHpm2(4),MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2

Complex(dp), Intent(in) :: cplAhAhVPVZ(3,3),cplAhhhVP(3,3),cplAhhhVZ(3,3),cplcFdFdVPL(5,5),cplcFdFdVPR(5,5),     & 
& cplcFdFdVZL(5,5),cplcFdFdVZR(5,5),cplcFeFeVPL(3,3),cplcFeFeVPR(3,3),cplcFeFeVZL(3,3),  & 
& cplcFeFeVZR(3,3),cplcFuFuVPL(4,4),cplcFuFuVPR(4,4),cplcFuFuVZL(4,4),cplcFuFuVZR(4,4),  & 
& cplcFv1Fv1VPL(3,3),cplcFv1Fv1VPR(3,3),cplcFv1Fv1VZL(3,3),cplcFv1Fv1VZR(3,3),           & 
& cplcgWCgWCVP,cplcgWCgWCVZ,cplcgWpgWpVP,cplcgWpgWpVZ,cplcgXp1gXp1VP,cplcgXp1gXp1VZ,     & 
& cplcgXp2gXp2VP,cplcgXp2gXp2VZ,cplcHpmcVWpVP(4),cplcHpmcVWpVZ(4),cplcHpmcVXpVP(4),      & 
& cplcHpmcVXpVZ(4),cplcVWpVPVWp,cplcVWpVPVWpVZ1,cplcVWpVPVWpVZ2,cplcVWpVPVWpVZ3,         & 
& cplcVWpVWpVZ,cplcVXpVPVXp,cplcVXpVPVXpVZ1,cplcVXpVPVXpVZ2,cplcVXpVPVXpVZ3,             & 
& cplcVXpVXpVZ,cplDpmcDpmVP(2,2),cplDpmcDpmVPVZ(2,2),cplDpmcDpmVZ(2,2),cplhhhhVPVZ(3,3), & 
& cplhhVPVZ(3),cplhhVPVZp(3),cplhhVZVZ(3),cplhhVZVZp(3),cplHpmcHpmVP(4,4),               & 
& cplHpmcHpmVPVZ(4,4),cplHpmcHpmVZ(4,4),cplHpmVPVWp(4),cplHpmVPVXp(4),cplHpmVWpVZ(4),    & 
& cplHpmVXpVZ(4)

Integer, Intent(inout) :: kont 
Real(dp) :: B0m2, F0m2, G0m2, B1m2, H0m2, B22m2, m1, m2 
Real(dp), Intent(in) :: p2 
Complex(dp) :: A0m2 
Complex(dp), Intent(inout) :: res 
Complex(dp) :: coupL1, coupR1, coupL2,coupR2, coup1,coup2, coup3, temp, sumI 
Integer :: i1,i2,i3,i4, gO1, gO2, ierr 
 
 
Real(dp) ::MVG,MVP,MVG2,MVP2
MVG = Mass_Regulator_PhotonGluon 
MVP = Mass_Regulator_PhotonGluon 
MVG2 = Mass_Regulator_PhotonGluon**2 
MVP2 = Mass_Regulator_PhotonGluon**2 

res = 0._dp 
 
!------------------------ 
! hh, Ah 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 3
       Do i2 = 1, 3
 B22m2 = Real(DerVSSloop(p2,MAh2(i2),Mhh2(i1)),dp) 
coup1 = cplAhhhVP(i2,i1)
coup2 = cplAhhhVZ(i2,i1)
    SumI = coup1*coup2*B22m2 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! conj[Dpm], Dpm 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 2
       Do i2 = 1, 2
 B22m2 = Real(DerVSSloop(p2,MDpm2(i2),MDpm2(i1)),dp) 
coup1 = cplDpmcDpmVP(i2,i1)
coup2 = cplDpmcDpmVZ(i1,i2)
    SumI = coup1*coup2*B22m2 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[Fd], Fd 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 5
       Do i2 = 1, 5
 H0m2 = Real(SA_DerHloop(p2,MFd2(i1),MFd2(i2)),dp) 
B0m2 = 2._dp*MFd(i1)*MFd(i2)*Real(SA_DerB0(p2,MFd2(i1),MFd2(i2)),dp) 
coupL1 = cplcFdFdVPL(i1,i2)
coupR1 = cplcFdFdVPR(i1,i2)
coupL2 = cplcFdFdVZL(i2,i1)
coupR2 = cplcFdFdVZR(i2,i1)
    SumI = (coupL1*coupL2+coupR1*coupR2)*H0m2 & 
                & + 0.5_dp*(coupL1*coupR2 + coupL2*coupR1)*B0m2 
res = res +3._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[Fe], Fe 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 3
       Do i2 = 1, 3
 H0m2 = Real(SA_DerHloop(p2,MFe2(i1),MFe2(i2)),dp) 
B0m2 = 2._dp*MFe(i1)*MFe(i2)*Real(SA_DerB0(p2,MFe2(i1),MFe2(i2)),dp) 
coupL1 = cplcFeFeVPL(i1,i2)
coupR1 = cplcFeFeVPR(i1,i2)
coupL2 = cplcFeFeVZL(i2,i1)
coupR2 = cplcFeFeVZR(i2,i1)
    SumI = (coupL1*coupL2+coupR1*coupR2)*H0m2 & 
                & + 0.5_dp*(coupL1*coupR2 + coupL2*coupR1)*B0m2 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[Fu], Fu 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
       Do i2 = 1, 4
 H0m2 = Real(SA_DerHloop(p2,MFu2(i1),MFu2(i2)),dp) 
B0m2 = 2._dp*MFu(i1)*MFu(i2)*Real(SA_DerB0(p2,MFu2(i1),MFu2(i2)),dp) 
coupL1 = cplcFuFuVPL(i1,i2)
coupR1 = cplcFuFuVPR(i1,i2)
coupL2 = cplcFuFuVZL(i2,i1)
coupR2 = cplcFuFuVZR(i2,i1)
    SumI = (coupL1*coupL2+coupR1*coupR2)*H0m2 & 
                & + 0.5_dp*(coupL1*coupR2 + coupL2*coupR1)*B0m2 
res = res +3._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[Fv1], Fv1 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 3
       Do i2 = 1, 3
 H0m2 = Real(SA_DerHloop(p2,0._dp,0._dp),dp) 
B0m2 = 2._dp*0._dp*0._dp*Real(SA_DerB0(p2,0._dp,0._dp),dp) 
coupL1 = cplcFv1Fv1VPL(i1,i2)
coupR1 = cplcFv1Fv1VPR(i1,i2)
coupL2 = cplcFv1Fv1VZL(i2,i1)
coupR2 = cplcFv1Fv1VZR(i2,i1)
    SumI = (coupL1*coupL2+coupR1*coupR2)*H0m2 & 
                & + 0.5_dp*(coupL1*coupR2 + coupL2*coupR1)*B0m2 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[gWp], gWp 
!------------------------ 
sumI = 0._dp 
 
B0m2 = Real(DerVGGloop(p2,MVWp2,MVWp2),dp)
coup1 = cplcgWpgWpVP
coup2 = cplcgWpgWpVZ 
   SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
!------------------------ 
! bar[gWpC], gWpC 
!------------------------ 
sumI = 0._dp 
 
B0m2 = Real(DerVGGloop(p2,MVWp2,MVWp2),dp)
coup1 = cplcgWCgWCVP
coup2 = cplcgWCgWCVZ 
   SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
!------------------------ 
! bar[gXp], gXp 
!------------------------ 
sumI = 0._dp 
 
B0m2 = Real(DerVGGloop(p2,MVXp2,MVXp2),dp)
coup1 = cplcgXp1gXp1VP
coup2 = cplcgXp1gXp1VZ 
   SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
!------------------------ 
! bar[gXpC], gXpC 
!------------------------ 
sumI = 0._dp 
 
B0m2 = Real(DerVGGloop(p2,MVXp2,MVXp2),dp)
coup1 = cplcgXp2gXp2VP
coup2 = cplcgXp2gXp2VZ 
   SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
!------------------------ 
! VZ, hh 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 3
 B0m2 = Real(DerVVSloop(p2,MVZ2,Mhh2(i2)),dp) 
coup1 = cplhhVPVZ(i2)
coup2 = cplhhVZVZ(i2)
    SumI = coup1*coup2*B0m2 
res = res +0.5_dp* SumI  
    End Do 
 !------------------------ 
! VZp, hh 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 3
 B0m2 = Real(DerVVSloop(p2,MVZp2,Mhh2(i2)),dp) 
coup1 = cplhhVPVZp(i2)
coup2 = cplhhVZVZp(i2)
    SumI = coup1*coup2*B0m2 
res = res +0.5_dp* SumI  
    End Do 
 !------------------------ 
! conj[Hpm], Hpm 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
       Do i2 = 1, 4
 B22m2 = Real(DerVSSloop(p2,MHpm2(i2),MHpm2(i1)),dp) 
coup1 = cplHpmcHpmVP(i2,i1)
coup2 = cplHpmcHpmVZ(i1,i2)
    SumI = coup1*coup2*B22m2 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! VWp, Hpm 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 B0m2 = Real(DerVVSloop(p2,MVWp2,MHpm2(i2)),dp) 
coup1 = cplHpmVPVWp(i2)
coup2 = cplcHpmcVWpVZ(i2)
    SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! VXp, Hpm 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 B0m2 = Real(DerVVSloop(p2,MVXp2,MHpm2(i2)),dp) 
coup1 = cplHpmVPVXp(i2)
coup2 = cplcHpmcVXpVZ(i2)
    SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! conj[VWp], VWp 
!------------------------ 
sumI = 0._dp 
 
B0m2 = Real(DerVVVloop(p2,MVWp2,MVWp2),dp) 
coup1 = cplcVWpVPVWp
coup2 = cplcVWpVWpVZ
    SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
!------------------------ 
! conj[VXp], VXp 
!------------------------ 
sumI = 0._dp 
 
B0m2 = Real(DerVVVloop(p2,MVXp2,MVXp2),dp) 
coup1 = cplcVXpVPVXp
coup2 = cplcVXpVXpVZ
    SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
!------------------------ 
! conj[VWp], conj[Hpm] 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 B0m2 = Real(DerVVSloop(p2,MVWp2,MHpm2(i2)),dp) 
coup1 = cplcHpmcVWpVP(i2)
coup2 = cplHpmVWpVZ(i2)
    SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! conj[VXp], conj[Hpm] 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 B0m2 = Real(DerVVSloop(p2,MVXp2,MHpm2(i2)),dp) 
coup1 = cplcHpmcVXpVP(i2)
coup2 = cplHpmVXpVZ(i2)
    SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! Ah 
!------------------------ 
    Do i1 = 1, 3
 SumI = 0._dp 
 A0m2 = SA_DerA0(MAh2(i1))
 coup1 = cplAhAhVPVZ(i1,i1)
 SumI = coup1*A0m2 
res = res +1._dp/2._dp* SumI  
      End Do 
 !------------------------ 
! conj[Dpm] 
!------------------------ 
    Do i1 = 1, 2
 SumI = 0._dp 
 A0m2 = SA_DerA0(MDpm2(i1))
 coup1 = cplDpmcDpmVPVZ(i1,i1)
 SumI = coup1*A0m2 
res = res +1* SumI  
      End Do 
 !------------------------ 
! hh 
!------------------------ 
    Do i1 = 1, 3
 SumI = 0._dp 
 A0m2 = SA_DerA0(Mhh2(i1))
 coup1 = cplhhhhVPVZ(i1,i1)
 SumI = coup1*A0m2 
res = res +1._dp/2._dp* SumI  
      End Do 
 !------------------------ 
! conj[Hpm] 
!------------------------ 
    Do i1 = 1, 4
 SumI = 0._dp 
 A0m2 = SA_DerA0(MHpm2(i1))
 coup1 = cplHpmcHpmVPVZ(i1,i1)
 SumI = coup1*A0m2 
res = res +1* SumI  
      End Do 
 !------------------------ 
! conj[VWp] 
!------------------------ 
SumI = 0._dp 
A0m2 = 3._dp/4._dp*SA_DerA0(MVWp2) +RXi/4._dp*SA_DerA0(MVWp2*RXi) 
coup1 = cplcVWpVPVWpVZ2
coup2 = cplcVWpVPVWpVZ1
coup3 = cplcVWpVPVWpVZ3
SumI = ((2._dp*DerrMS*coup1+(1-RXi**2)/8._dp*(coup2+coup3))*MVWp2-(4._dp*coup1+coup2+coup3)*A0m2)
res = res +1* SumI  
!------------------------ 
! conj[VXp] 
!------------------------ 
SumI = 0._dp 
A0m2 = 3._dp/4._dp*SA_DerA0(MVXp2) +RXi/4._dp*SA_DerA0(MVXp2*RXi) 
coup1 = cplcVXpVPVXpVZ2
coup2 = cplcVXpVPVXpVZ1
coup3 = cplcVXpVPVXpVZ3
SumI = ((2._dp*DerrMS*coup1+(1-RXi**2)/8._dp*(coup2+coup3))*MVXp2-(4._dp*coup1+coup2+coup3)*A0m2)
res = res +1* SumI  
res = oo16pi2*res 
 
End Subroutine DerPi1LoopVPVZ 
 
Subroutine Pi1LoopVPVZp(p2,MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,MFe2,MFu,MFu2,            & 
& Mhh,Mhh2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,cplAhAhVPVZp,            & 
& cplAhhhVP,cplAhhhVZp,cplcFdFdVPL,cplcFdFdVPR,cplcFdFdVZpL,cplcFdFdVZpR,cplcFeFeVPL,    & 
& cplcFeFeVPR,cplcFeFeVZpL,cplcFeFeVZpR,cplcFuFuVPL,cplcFuFuVPR,cplcFuFuVZpL,            & 
& cplcFuFuVZpR,cplcFv1Fv1VPL,cplcFv1Fv1VPR,cplcFv1Fv1VZpL,cplcFv1Fv1VZpR,cplcgWCgWCVP,   & 
& cplcgWCgWCVZp,cplcgWpgWpVP,cplcgWpgWpVZp,cplcgXp1gXp1VP,cplcgXp1gXp1VZp,               & 
& cplcgXp2gXp2VP,cplcgXp2gXp2VZp,cplcHpmcVWpVP,cplcHpmcVWpVZp,cplcHpmcVXpVP,             & 
& cplcHpmcVXpVZp,cplcVWpVPVWp,cplcVWpVPVWpVZp1,cplcVWpVPVWpVZp2,cplcVWpVPVWpVZp3,        & 
& cplcVWpVWpVZp,cplcVXpVPVXp,cplcVXpVPVXpVZp1,cplcVXpVPVXpVZp2,cplcVXpVPVXpVZp3,         & 
& cplcVXpVXpVZp,cplDpmcDpmVP,cplDpmcDpmVPVZp,cplDpmcDpmVZp,cplhhhhVPVZp,cplhhVPVZ,       & 
& cplhhVPVZp,cplhhVZpVZp,cplhhVZVZp,cplHpmcHpmVP,cplHpmcHpmVPVZp,cplHpmcHpmVZp,          & 
& cplHpmVPVWp,cplHpmVPVXp,cplHpmVWpVZp,cplHpmVXpVZp,kont,res)

Implicit None 
Real(dp), Intent(in) :: MAh(3),MAh2(3),MDpm(2),MDpm2(2),MFd(5),MFd2(5),MFe(3),MFe2(3),MFu(4),MFu2(4),         & 
& Mhh(3),Mhh2(3),MHpm(4),MHpm2(4),MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2

Complex(dp), Intent(in) :: cplAhAhVPVZp(3,3),cplAhhhVP(3,3),cplAhhhVZp(3,3),cplcFdFdVPL(5,5),cplcFdFdVPR(5,5),   & 
& cplcFdFdVZpL(5,5),cplcFdFdVZpR(5,5),cplcFeFeVPL(3,3),cplcFeFeVPR(3,3),cplcFeFeVZpL(3,3),& 
& cplcFeFeVZpR(3,3),cplcFuFuVPL(4,4),cplcFuFuVPR(4,4),cplcFuFuVZpL(4,4),cplcFuFuVZpR(4,4),& 
& cplcFv1Fv1VPL(3,3),cplcFv1Fv1VPR(3,3),cplcFv1Fv1VZpL(3,3),cplcFv1Fv1VZpR(3,3),         & 
& cplcgWCgWCVP,cplcgWCgWCVZp,cplcgWpgWpVP,cplcgWpgWpVZp,cplcgXp1gXp1VP,cplcgXp1gXp1VZp,  & 
& cplcgXp2gXp2VP,cplcgXp2gXp2VZp,cplcHpmcVWpVP(4),cplcHpmcVWpVZp(4),cplcHpmcVXpVP(4),    & 
& cplcHpmcVXpVZp(4),cplcVWpVPVWp,cplcVWpVPVWpVZp1,cplcVWpVPVWpVZp2,cplcVWpVPVWpVZp3,     & 
& cplcVWpVWpVZp,cplcVXpVPVXp,cplcVXpVPVXpVZp1,cplcVXpVPVXpVZp2,cplcVXpVPVXpVZp3,         & 
& cplcVXpVXpVZp,cplDpmcDpmVP(2,2),cplDpmcDpmVPVZp(2,2),cplDpmcDpmVZp(2,2),               & 
& cplhhhhVPVZp(3,3),cplhhVPVZ(3),cplhhVPVZp(3),cplhhVZpVZp(3),cplhhVZVZp(3),             & 
& cplHpmcHpmVP(4,4),cplHpmcHpmVPVZp(4,4),cplHpmcHpmVZp(4,4),cplHpmVPVWp(4),              & 
& cplHpmVPVXp(4),cplHpmVWpVZp(4),cplHpmVXpVZp(4)

Integer, Intent(inout) :: kont 
Real(dp) :: B0m2, F0m2, G0m2, B1m2, H0m2, B22m2, m1, m2 
Real(dp), Intent(in) :: p2 
Complex(dp) :: A0m2 
Complex(dp), Intent(inout) :: res 
Complex(dp) :: coupL1, coupR1, coupL2,coupR2, coup1,coup2, coup3, temp, sumI 
Integer :: i1,i2,i3,i4, gO1, gO2, ierr 
 
 
res = 0._dp 
 
!------------------------ 
! hh, Ah 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 3
       Do i2 = 1, 3
 B22m2 = Real(VSSloop(p2,MAh2(i2),Mhh2(i1)),dp) 
coup1 = cplAhhhVP(i2,i1)
coup2 = cplAhhhVZp(i2,i1)
    SumI = coup1*coup2*B22m2 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! conj[Dpm], Dpm 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 2
       Do i2 = 1, 2
 B22m2 = Real(VSSloop(p2,MDpm2(i2),MDpm2(i1)),dp) 
coup1 = cplDpmcDpmVP(i2,i1)
coup2 = cplDpmcDpmVZp(i1,i2)
    SumI = coup1*coup2*B22m2 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[Fd], Fd 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 5
       Do i2 = 1, 5
 H0m2 = Real(SA_Hloop(p2,MFd2(i1),MFd2(i2)),dp) 
B0m2 = 4._dp*MFd(i1)*MFd(i2)*Real(SA_B0(p2,MFd2(i1),MFd2(i2)),dp) 
coupL1 = cplcFdFdVPL(i1,i2)
coupR1 = cplcFdFdVPR(i1,i2)
coupL2 = cplcFdFdVZpL(i2,i1)
coupR2 = cplcFdFdVZpR(i2,i1)
    SumI = (coupL1*coupL2+coupR1*coupR2)*H0m2 & 
                & + 0.5_dp*(coupL1*coupR2 + coupL2*coupR1)*B0m2 
res = res +3._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[Fe], Fe 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 3
       Do i2 = 1, 3
 H0m2 = Real(SA_Hloop(p2,MFe2(i1),MFe2(i2)),dp) 
B0m2 = 4._dp*MFe(i1)*MFe(i2)*Real(SA_B0(p2,MFe2(i1),MFe2(i2)),dp) 
coupL1 = cplcFeFeVPL(i1,i2)
coupR1 = cplcFeFeVPR(i1,i2)
coupL2 = cplcFeFeVZpL(i2,i1)
coupR2 = cplcFeFeVZpR(i2,i1)
    SumI = (coupL1*coupL2+coupR1*coupR2)*H0m2 & 
                & + 0.5_dp*(coupL1*coupR2 + coupL2*coupR1)*B0m2 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[Fu], Fu 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
       Do i2 = 1, 4
 H0m2 = Real(SA_Hloop(p2,MFu2(i1),MFu2(i2)),dp) 
B0m2 = 4._dp*MFu(i1)*MFu(i2)*Real(SA_B0(p2,MFu2(i1),MFu2(i2)),dp) 
coupL1 = cplcFuFuVPL(i1,i2)
coupR1 = cplcFuFuVPR(i1,i2)
coupL2 = cplcFuFuVZpL(i2,i1)
coupR2 = cplcFuFuVZpR(i2,i1)
    SumI = (coupL1*coupL2+coupR1*coupR2)*H0m2 & 
                & + 0.5_dp*(coupL1*coupR2 + coupL2*coupR1)*B0m2 
res = res +3._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[Fv1], Fv1 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 3
       Do i2 = 1, 3
 H0m2 = Real(SA_Hloop(p2,0._dp,0._dp),dp) 
B0m2 = 4._dp*0._dp*0._dp*Real(SA_B0(p2,0._dp,0._dp),dp) 
coupL1 = cplcFv1Fv1VPL(i1,i2)
coupR1 = cplcFv1Fv1VPR(i1,i2)
coupL2 = cplcFv1Fv1VZpL(i2,i1)
coupR2 = cplcFv1Fv1VZpR(i2,i1)
    SumI = (coupL1*coupL2+coupR1*coupR2)*H0m2 & 
                & + 0.5_dp*(coupL1*coupR2 + coupL2*coupR1)*B0m2 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[gWp], gWp 
!------------------------ 
sumI = 0._dp 
 
B0m2 = Real(VGGloop(p2,MVWp2,MVWp2),dp)
coup1 = cplcgWpgWpVP
coup2 = cplcgWpgWpVZp 
   SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
!------------------------ 
! bar[gWpC], gWpC 
!------------------------ 
sumI = 0._dp 
 
B0m2 = Real(VGGloop(p2,MVWp2,MVWp2),dp)
coup1 = cplcgWCgWCVP
coup2 = cplcgWCgWCVZp 
   SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
!------------------------ 
! bar[gXp], gXp 
!------------------------ 
sumI = 0._dp 
 
B0m2 = Real(VGGloop(p2,MVXp2,MVXp2),dp)
coup1 = cplcgXp1gXp1VP
coup2 = cplcgXp1gXp1VZp 
   SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
!------------------------ 
! bar[gXpC], gXpC 
!------------------------ 
sumI = 0._dp 
 
B0m2 = Real(VGGloop(p2,MVXp2,MVXp2),dp)
coup1 = cplcgXp2gXp2VP
coup2 = cplcgXp2gXp2VZp 
   SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
!------------------------ 
! VZ, hh 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 3
 B0m2 = Real(VVSloop(p2,MVZ2,Mhh2(i2)),dp) 
coup1 = cplhhVPVZ(i2)
coup2 = cplhhVZVZp(i2)
    SumI = coup1*coup2*B0m2 
res = res +0.5_dp* SumI  
    End Do 
 !------------------------ 
! VZp, hh 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 3
 B0m2 = Real(VVSloop(p2,MVZp2,Mhh2(i2)),dp) 
coup1 = cplhhVPVZp(i2)
coup2 = cplhhVZpVZp(i2)
    SumI = coup1*coup2*B0m2 
res = res +0.5_dp* SumI  
    End Do 
 !------------------------ 
! conj[Hpm], Hpm 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
       Do i2 = 1, 4
 B22m2 = Real(VSSloop(p2,MHpm2(i2),MHpm2(i1)),dp) 
coup1 = cplHpmcHpmVP(i2,i1)
coup2 = cplHpmcHpmVZp(i1,i2)
    SumI = coup1*coup2*B22m2 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! VWp, Hpm 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 B0m2 = Real(VVSloop(p2,MVWp2,MHpm2(i2)),dp) 
coup1 = cplHpmVPVWp(i2)
coup2 = cplcHpmcVWpVZp(i2)
    SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! VXp, Hpm 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 B0m2 = Real(VVSloop(p2,MVXp2,MHpm2(i2)),dp) 
coup1 = cplHpmVPVXp(i2)
coup2 = cplcHpmcVXpVZp(i2)
    SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! conj[VWp], VWp 
!------------------------ 
sumI = 0._dp 
 
B0m2 = Real(VVVloop(p2,MVWp2,MVWp2),dp) 
coup1 = cplcVWpVPVWp
coup2 = cplcVWpVWpVZp
    SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
!------------------------ 
! conj[VXp], VXp 
!------------------------ 
sumI = 0._dp 
 
B0m2 = Real(VVVloop(p2,MVXp2,MVXp2),dp) 
coup1 = cplcVXpVPVXp
coup2 = cplcVXpVXpVZp
    SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
!------------------------ 
! conj[VWp], conj[Hpm] 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 B0m2 = Real(VVSloop(p2,MVWp2,MHpm2(i2)),dp) 
coup1 = cplcHpmcVWpVP(i2)
coup2 = cplHpmVWpVZp(i2)
    SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! conj[VXp], conj[Hpm] 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 B0m2 = Real(VVSloop(p2,MVXp2,MHpm2(i2)),dp) 
coup1 = cplcHpmcVXpVP(i2)
coup2 = cplHpmVXpVZp(i2)
    SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! Ah 
!------------------------ 
    Do i1 = 1, 3
 SumI = 0._dp 
 A0m2 = SA_A0(MAh2(i1))
 coup1 = cplAhAhVPVZp(i1,i1)
 SumI = coup1*A0m2 
res = res +1._dp/2._dp* SumI  
      End Do 
 !------------------------ 
! conj[Dpm] 
!------------------------ 
    Do i1 = 1, 2
 SumI = 0._dp 
 A0m2 = SA_A0(MDpm2(i1))
 coup1 = cplDpmcDpmVPVZp(i1,i1)
 SumI = coup1*A0m2 
res = res +1* SumI  
      End Do 
 !------------------------ 
! hh 
!------------------------ 
    Do i1 = 1, 3
 SumI = 0._dp 
 A0m2 = SA_A0(Mhh2(i1))
 coup1 = cplhhhhVPVZp(i1,i1)
 SumI = coup1*A0m2 
res = res +1._dp/2._dp* SumI  
      End Do 
 !------------------------ 
! conj[Hpm] 
!------------------------ 
    Do i1 = 1, 4
 SumI = 0._dp 
 A0m2 = SA_A0(MHpm2(i1))
 coup1 = cplHpmcHpmVPVZp(i1,i1)
 SumI = coup1*A0m2 
res = res +1* SumI  
      End Do 
 !------------------------ 
! conj[VWp] 
!------------------------ 
SumI = 0._dp 
A0m2 = 3._dp/4._dp*SA_A0(MVWp2) +RXi/4._dp*SA_A0(MVWp2*RXi) 
coup1 = cplcVWpVPVWpVZp2
coup2 = cplcVWpVPVWpVZp1
coup3 = cplcVWpVPVWpVZp3
SumI = ((2._dp*rMS*coup1+(1-RXi**2)/8._dp*(coup2+coup3))*MVWp2-(4._dp*coup1+coup2+coup3)*A0m2)
res = res +1* SumI  
!------------------------ 
! conj[VXp] 
!------------------------ 
SumI = 0._dp 
A0m2 = 3._dp/4._dp*SA_A0(MVXp2) +RXi/4._dp*SA_A0(MVXp2*RXi) 
coup1 = cplcVXpVPVXpVZp2
coup2 = cplcVXpVPVXpVZp1
coup3 = cplcVXpVPVXpVZp3
SumI = ((2._dp*rMS*coup1+(1-RXi**2)/8._dp*(coup2+coup3))*MVXp2-(4._dp*coup1+coup2+coup3)*A0m2)
res = res +1* SumI  
res = oo16pi2*res 
 
End Subroutine Pi1LoopVPVZp 
 
Subroutine DerPi1LoopVPVZp(p2,MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,MFe2,MFu,              & 
& MFu2,Mhh,Mhh2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,cplAhAhVPVZp,       & 
& cplAhhhVP,cplAhhhVZp,cplcFdFdVPL,cplcFdFdVPR,cplcFdFdVZpL,cplcFdFdVZpR,cplcFeFeVPL,    & 
& cplcFeFeVPR,cplcFeFeVZpL,cplcFeFeVZpR,cplcFuFuVPL,cplcFuFuVPR,cplcFuFuVZpL,            & 
& cplcFuFuVZpR,cplcFv1Fv1VPL,cplcFv1Fv1VPR,cplcFv1Fv1VZpL,cplcFv1Fv1VZpR,cplcgWCgWCVP,   & 
& cplcgWCgWCVZp,cplcgWpgWpVP,cplcgWpgWpVZp,cplcgXp1gXp1VP,cplcgXp1gXp1VZp,               & 
& cplcgXp2gXp2VP,cplcgXp2gXp2VZp,cplcHpmcVWpVP,cplcHpmcVWpVZp,cplcHpmcVXpVP,             & 
& cplcHpmcVXpVZp,cplcVWpVPVWp,cplcVWpVPVWpVZp1,cplcVWpVPVWpVZp2,cplcVWpVPVWpVZp3,        & 
& cplcVWpVWpVZp,cplcVXpVPVXp,cplcVXpVPVXpVZp1,cplcVXpVPVXpVZp2,cplcVXpVPVXpVZp3,         & 
& cplcVXpVXpVZp,cplDpmcDpmVP,cplDpmcDpmVPVZp,cplDpmcDpmVZp,cplhhhhVPVZp,cplhhVPVZ,       & 
& cplhhVPVZp,cplhhVZpVZp,cplhhVZVZp,cplHpmcHpmVP,cplHpmcHpmVPVZp,cplHpmcHpmVZp,          & 
& cplHpmVPVWp,cplHpmVPVXp,cplHpmVWpVZp,cplHpmVXpVZp,kont,res)

Implicit None 
Real(dp), Intent(in) :: MAh(3),MAh2(3),MDpm(2),MDpm2(2),MFd(5),MFd2(5),MFe(3),MFe2(3),MFu(4),MFu2(4),         & 
& Mhh(3),Mhh2(3),MHpm(4),MHpm2(4),MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2

Complex(dp), Intent(in) :: cplAhAhVPVZp(3,3),cplAhhhVP(3,3),cplAhhhVZp(3,3),cplcFdFdVPL(5,5),cplcFdFdVPR(5,5),   & 
& cplcFdFdVZpL(5,5),cplcFdFdVZpR(5,5),cplcFeFeVPL(3,3),cplcFeFeVPR(3,3),cplcFeFeVZpL(3,3),& 
& cplcFeFeVZpR(3,3),cplcFuFuVPL(4,4),cplcFuFuVPR(4,4),cplcFuFuVZpL(4,4),cplcFuFuVZpR(4,4),& 
& cplcFv1Fv1VPL(3,3),cplcFv1Fv1VPR(3,3),cplcFv1Fv1VZpL(3,3),cplcFv1Fv1VZpR(3,3),         & 
& cplcgWCgWCVP,cplcgWCgWCVZp,cplcgWpgWpVP,cplcgWpgWpVZp,cplcgXp1gXp1VP,cplcgXp1gXp1VZp,  & 
& cplcgXp2gXp2VP,cplcgXp2gXp2VZp,cplcHpmcVWpVP(4),cplcHpmcVWpVZp(4),cplcHpmcVXpVP(4),    & 
& cplcHpmcVXpVZp(4),cplcVWpVPVWp,cplcVWpVPVWpVZp1,cplcVWpVPVWpVZp2,cplcVWpVPVWpVZp3,     & 
& cplcVWpVWpVZp,cplcVXpVPVXp,cplcVXpVPVXpVZp1,cplcVXpVPVXpVZp2,cplcVXpVPVXpVZp3,         & 
& cplcVXpVXpVZp,cplDpmcDpmVP(2,2),cplDpmcDpmVPVZp(2,2),cplDpmcDpmVZp(2,2),               & 
& cplhhhhVPVZp(3,3),cplhhVPVZ(3),cplhhVPVZp(3),cplhhVZpVZp(3),cplhhVZVZp(3),             & 
& cplHpmcHpmVP(4,4),cplHpmcHpmVPVZp(4,4),cplHpmcHpmVZp(4,4),cplHpmVPVWp(4),              & 
& cplHpmVPVXp(4),cplHpmVWpVZp(4),cplHpmVXpVZp(4)

Integer, Intent(inout) :: kont 
Real(dp) :: B0m2, F0m2, G0m2, B1m2, H0m2, B22m2, m1, m2 
Real(dp), Intent(in) :: p2 
Complex(dp) :: A0m2 
Complex(dp), Intent(inout) :: res 
Complex(dp) :: coupL1, coupR1, coupL2,coupR2, coup1,coup2, coup3, temp, sumI 
Integer :: i1,i2,i3,i4, gO1, gO2, ierr 
 
 
Real(dp) ::MVG,MVP,MVG2,MVP2
MVG = Mass_Regulator_PhotonGluon 
MVP = Mass_Regulator_PhotonGluon 
MVG2 = Mass_Regulator_PhotonGluon**2 
MVP2 = Mass_Regulator_PhotonGluon**2 

res = 0._dp 
 
!------------------------ 
! hh, Ah 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 3
       Do i2 = 1, 3
 B22m2 = Real(DerVSSloop(p2,MAh2(i2),Mhh2(i1)),dp) 
coup1 = cplAhhhVP(i2,i1)
coup2 = cplAhhhVZp(i2,i1)
    SumI = coup1*coup2*B22m2 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! conj[Dpm], Dpm 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 2
       Do i2 = 1, 2
 B22m2 = Real(DerVSSloop(p2,MDpm2(i2),MDpm2(i1)),dp) 
coup1 = cplDpmcDpmVP(i2,i1)
coup2 = cplDpmcDpmVZp(i1,i2)
    SumI = coup1*coup2*B22m2 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[Fd], Fd 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 5
       Do i2 = 1, 5
 H0m2 = Real(SA_DerHloop(p2,MFd2(i1),MFd2(i2)),dp) 
B0m2 = 2._dp*MFd(i1)*MFd(i2)*Real(SA_DerB0(p2,MFd2(i1),MFd2(i2)),dp) 
coupL1 = cplcFdFdVPL(i1,i2)
coupR1 = cplcFdFdVPR(i1,i2)
coupL2 = cplcFdFdVZpL(i2,i1)
coupR2 = cplcFdFdVZpR(i2,i1)
    SumI = (coupL1*coupL2+coupR1*coupR2)*H0m2 & 
                & + 0.5_dp*(coupL1*coupR2 + coupL2*coupR1)*B0m2 
res = res +3._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[Fe], Fe 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 3
       Do i2 = 1, 3
 H0m2 = Real(SA_DerHloop(p2,MFe2(i1),MFe2(i2)),dp) 
B0m2 = 2._dp*MFe(i1)*MFe(i2)*Real(SA_DerB0(p2,MFe2(i1),MFe2(i2)),dp) 
coupL1 = cplcFeFeVPL(i1,i2)
coupR1 = cplcFeFeVPR(i1,i2)
coupL2 = cplcFeFeVZpL(i2,i1)
coupR2 = cplcFeFeVZpR(i2,i1)
    SumI = (coupL1*coupL2+coupR1*coupR2)*H0m2 & 
                & + 0.5_dp*(coupL1*coupR2 + coupL2*coupR1)*B0m2 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[Fu], Fu 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
       Do i2 = 1, 4
 H0m2 = Real(SA_DerHloop(p2,MFu2(i1),MFu2(i2)),dp) 
B0m2 = 2._dp*MFu(i1)*MFu(i2)*Real(SA_DerB0(p2,MFu2(i1),MFu2(i2)),dp) 
coupL1 = cplcFuFuVPL(i1,i2)
coupR1 = cplcFuFuVPR(i1,i2)
coupL2 = cplcFuFuVZpL(i2,i1)
coupR2 = cplcFuFuVZpR(i2,i1)
    SumI = (coupL1*coupL2+coupR1*coupR2)*H0m2 & 
                & + 0.5_dp*(coupL1*coupR2 + coupL2*coupR1)*B0m2 
res = res +3._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[Fv1], Fv1 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 3
       Do i2 = 1, 3
 H0m2 = Real(SA_DerHloop(p2,0._dp,0._dp),dp) 
B0m2 = 2._dp*0._dp*0._dp*Real(SA_DerB0(p2,0._dp,0._dp),dp) 
coupL1 = cplcFv1Fv1VPL(i1,i2)
coupR1 = cplcFv1Fv1VPR(i1,i2)
coupL2 = cplcFv1Fv1VZpL(i2,i1)
coupR2 = cplcFv1Fv1VZpR(i2,i1)
    SumI = (coupL1*coupL2+coupR1*coupR2)*H0m2 & 
                & + 0.5_dp*(coupL1*coupR2 + coupL2*coupR1)*B0m2 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[gWp], gWp 
!------------------------ 
sumI = 0._dp 
 
B0m2 = Real(DerVGGloop(p2,MVWp2,MVWp2),dp)
coup1 = cplcgWpgWpVP
coup2 = cplcgWpgWpVZp 
   SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
!------------------------ 
! bar[gWpC], gWpC 
!------------------------ 
sumI = 0._dp 
 
B0m2 = Real(DerVGGloop(p2,MVWp2,MVWp2),dp)
coup1 = cplcgWCgWCVP
coup2 = cplcgWCgWCVZp 
   SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
!------------------------ 
! bar[gXp], gXp 
!------------------------ 
sumI = 0._dp 
 
B0m2 = Real(DerVGGloop(p2,MVXp2,MVXp2),dp)
coup1 = cplcgXp1gXp1VP
coup2 = cplcgXp1gXp1VZp 
   SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
!------------------------ 
! bar[gXpC], gXpC 
!------------------------ 
sumI = 0._dp 
 
B0m2 = Real(DerVGGloop(p2,MVXp2,MVXp2),dp)
coup1 = cplcgXp2gXp2VP
coup2 = cplcgXp2gXp2VZp 
   SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
!------------------------ 
! VZ, hh 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 3
 B0m2 = Real(DerVVSloop(p2,MVZ2,Mhh2(i2)),dp) 
coup1 = cplhhVPVZ(i2)
coup2 = cplhhVZVZp(i2)
    SumI = coup1*coup2*B0m2 
res = res +0.5_dp* SumI  
    End Do 
 !------------------------ 
! VZp, hh 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 3
 B0m2 = Real(DerVVSloop(p2,MVZp2,Mhh2(i2)),dp) 
coup1 = cplhhVPVZp(i2)
coup2 = cplhhVZpVZp(i2)
    SumI = coup1*coup2*B0m2 
res = res +0.5_dp* SumI  
    End Do 
 !------------------------ 
! conj[Hpm], Hpm 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
       Do i2 = 1, 4
 B22m2 = Real(DerVSSloop(p2,MHpm2(i2),MHpm2(i1)),dp) 
coup1 = cplHpmcHpmVP(i2,i1)
coup2 = cplHpmcHpmVZp(i1,i2)
    SumI = coup1*coup2*B22m2 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! VWp, Hpm 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 B0m2 = Real(DerVVSloop(p2,MVWp2,MHpm2(i2)),dp) 
coup1 = cplHpmVPVWp(i2)
coup2 = cplcHpmcVWpVZp(i2)
    SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! VXp, Hpm 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 B0m2 = Real(DerVVSloop(p2,MVXp2,MHpm2(i2)),dp) 
coup1 = cplHpmVPVXp(i2)
coup2 = cplcHpmcVXpVZp(i2)
    SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! conj[VWp], VWp 
!------------------------ 
sumI = 0._dp 
 
B0m2 = Real(DerVVVloop(p2,MVWp2,MVWp2),dp) 
coup1 = cplcVWpVPVWp
coup2 = cplcVWpVWpVZp
    SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
!------------------------ 
! conj[VXp], VXp 
!------------------------ 
sumI = 0._dp 
 
B0m2 = Real(DerVVVloop(p2,MVXp2,MVXp2),dp) 
coup1 = cplcVXpVPVXp
coup2 = cplcVXpVXpVZp
    SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
!------------------------ 
! conj[VWp], conj[Hpm] 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 B0m2 = Real(DerVVSloop(p2,MVWp2,MHpm2(i2)),dp) 
coup1 = cplcHpmcVWpVP(i2)
coup2 = cplHpmVWpVZp(i2)
    SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! conj[VXp], conj[Hpm] 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 B0m2 = Real(DerVVSloop(p2,MVXp2,MHpm2(i2)),dp) 
coup1 = cplcHpmcVXpVP(i2)
coup2 = cplHpmVXpVZp(i2)
    SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! Ah 
!------------------------ 
    Do i1 = 1, 3
 SumI = 0._dp 
 A0m2 = SA_DerA0(MAh2(i1))
 coup1 = cplAhAhVPVZp(i1,i1)
 SumI = coup1*A0m2 
res = res +1._dp/2._dp* SumI  
      End Do 
 !------------------------ 
! conj[Dpm] 
!------------------------ 
    Do i1 = 1, 2
 SumI = 0._dp 
 A0m2 = SA_DerA0(MDpm2(i1))
 coup1 = cplDpmcDpmVPVZp(i1,i1)
 SumI = coup1*A0m2 
res = res +1* SumI  
      End Do 
 !------------------------ 
! hh 
!------------------------ 
    Do i1 = 1, 3
 SumI = 0._dp 
 A0m2 = SA_DerA0(Mhh2(i1))
 coup1 = cplhhhhVPVZp(i1,i1)
 SumI = coup1*A0m2 
res = res +1._dp/2._dp* SumI  
      End Do 
 !------------------------ 
! conj[Hpm] 
!------------------------ 
    Do i1 = 1, 4
 SumI = 0._dp 
 A0m2 = SA_DerA0(MHpm2(i1))
 coup1 = cplHpmcHpmVPVZp(i1,i1)
 SumI = coup1*A0m2 
res = res +1* SumI  
      End Do 
 !------------------------ 
! conj[VWp] 
!------------------------ 
SumI = 0._dp 
A0m2 = 3._dp/4._dp*SA_DerA0(MVWp2) +RXi/4._dp*SA_DerA0(MVWp2*RXi) 
coup1 = cplcVWpVPVWpVZp2
coup2 = cplcVWpVPVWpVZp1
coup3 = cplcVWpVPVWpVZp3
SumI = ((2._dp*DerrMS*coup1+(1-RXi**2)/8._dp*(coup2+coup3))*MVWp2-(4._dp*coup1+coup2+coup3)*A0m2)
res = res +1* SumI  
!------------------------ 
! conj[VXp] 
!------------------------ 
SumI = 0._dp 
A0m2 = 3._dp/4._dp*SA_DerA0(MVXp2) +RXi/4._dp*SA_DerA0(MVXp2*RXi) 
coup1 = cplcVXpVPVXpVZp2
coup2 = cplcVXpVPVXpVZp1
coup3 = cplcVXpVPVXpVZp3
SumI = ((2._dp*DerrMS*coup1+(1-RXi**2)/8._dp*(coup2+coup3))*MVXp2-(4._dp*coup1+coup2+coup3)*A0m2)
res = res +1* SumI  
res = oo16pi2*res 
 
End Subroutine DerPi1LoopVPVZp 
 
Subroutine Pi1LoopVZVZp(p2,MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,MFe2,MFu,MFu2,            & 
& Mhh,Mhh2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,cplAhAhVZVZp,            & 
& cplAhhhVZ,cplAhhhVZp,cplcFdFdVZL,cplcFdFdVZpL,cplcFdFdVZpR,cplcFdFdVZR,cplcFeFeVZL,    & 
& cplcFeFeVZpL,cplcFeFeVZpR,cplcFeFeVZR,cplcFuFuVZL,cplcFuFuVZpL,cplcFuFuVZpR,           & 
& cplcFuFuVZR,cplcFv1Fv1VZL,cplcFv1Fv1VZpL,cplcFv1Fv1VZpR,cplcFv1Fv1VZR,cplcgWCgWCVZ,    & 
& cplcgWCgWCVZp,cplcgWpgWpVZ,cplcgWpgWpVZp,cplcgXp1gXp1VZ,cplcgXp1gXp1VZp,               & 
& cplcgXp2gXp2VZ,cplcgXp2gXp2VZp,cplcHpmcVWpVZ,cplcHpmcVWpVZp,cplcHpmcVXpVZ,             & 
& cplcHpmcVXpVZp,cplcVWpVWpVZ,cplcVWpVWpVZp,cplcVWpVWpVZVZp1,cplcVWpVWpVZVZp2,           & 
& cplcVWpVWpVZVZp3,cplcVXpVXpVZ,cplcVXpVXpVZp,cplcVXpVXpVZVZp1,cplcVXpVXpVZVZp2,         & 
& cplcVXpVXpVZVZp3,cplDpmcDpmVZ,cplDpmcDpmVZp,cplDpmcDpmVZVZp,cplhhhhVZVZp,              & 
& cplhhVPVZ,cplhhVPVZp,cplhhVZpVZp,cplhhVZVZ,cplhhVZVZp,cplHpmcHpmVZ,cplHpmcHpmVZp,      & 
& cplHpmcHpmVZVZp,cplHpmVWpVZ,cplHpmVWpVZp,cplHpmVXpVZ,cplHpmVXpVZp,kont,res)

Implicit None 
Real(dp), Intent(in) :: MAh(3),MAh2(3),MDpm(2),MDpm2(2),MFd(5),MFd2(5),MFe(3),MFe2(3),MFu(4),MFu2(4),         & 
& Mhh(3),Mhh2(3),MHpm(4),MHpm2(4),MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2

Complex(dp), Intent(in) :: cplAhAhVZVZp(3,3),cplAhhhVZ(3,3),cplAhhhVZp(3,3),cplcFdFdVZL(5,5),cplcFdFdVZpL(5,5),  & 
& cplcFdFdVZpR(5,5),cplcFdFdVZR(5,5),cplcFeFeVZL(3,3),cplcFeFeVZpL(3,3),cplcFeFeVZpR(3,3),& 
& cplcFeFeVZR(3,3),cplcFuFuVZL(4,4),cplcFuFuVZpL(4,4),cplcFuFuVZpR(4,4),cplcFuFuVZR(4,4),& 
& cplcFv1Fv1VZL(3,3),cplcFv1Fv1VZpL(3,3),cplcFv1Fv1VZpR(3,3),cplcFv1Fv1VZR(3,3),         & 
& cplcgWCgWCVZ,cplcgWCgWCVZp,cplcgWpgWpVZ,cplcgWpgWpVZp,cplcgXp1gXp1VZ,cplcgXp1gXp1VZp,  & 
& cplcgXp2gXp2VZ,cplcgXp2gXp2VZp,cplcHpmcVWpVZ(4),cplcHpmcVWpVZp(4),cplcHpmcVXpVZ(4),    & 
& cplcHpmcVXpVZp(4),cplcVWpVWpVZ,cplcVWpVWpVZp,cplcVWpVWpVZVZp1,cplcVWpVWpVZVZp2,        & 
& cplcVWpVWpVZVZp3,cplcVXpVXpVZ,cplcVXpVXpVZp,cplcVXpVXpVZVZp1,cplcVXpVXpVZVZp2,         & 
& cplcVXpVXpVZVZp3,cplDpmcDpmVZ(2,2),cplDpmcDpmVZp(2,2),cplDpmcDpmVZVZp(2,2),            & 
& cplhhhhVZVZp(3,3),cplhhVPVZ(3),cplhhVPVZp(3),cplhhVZpVZp(3),cplhhVZVZ(3),              & 
& cplhhVZVZp(3),cplHpmcHpmVZ(4,4),cplHpmcHpmVZp(4,4),cplHpmcHpmVZVZp(4,4),               & 
& cplHpmVWpVZ(4),cplHpmVWpVZp(4),cplHpmVXpVZ(4),cplHpmVXpVZp(4)

Integer, Intent(inout) :: kont 
Real(dp) :: B0m2, F0m2, G0m2, B1m2, H0m2, B22m2, m1, m2 
Real(dp), Intent(in) :: p2 
Complex(dp) :: A0m2 
Complex(dp), Intent(inout) :: res 
Complex(dp) :: coupL1, coupR1, coupL2,coupR2, coup1,coup2, coup3, temp, sumI 
Integer :: i1,i2,i3,i4, gO1, gO2, ierr 
 
 
res = 0._dp 
 
!------------------------ 
! hh, Ah 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 3
       Do i2 = 1, 3
 B22m2 = Real(VSSloop(p2,MAh2(i2),Mhh2(i1)),dp) 
coup1 = cplAhhhVZ(i2,i1)
coup2 = cplAhhhVZp(i2,i1)
    SumI = coup1*coup2*B22m2 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! conj[Dpm], Dpm 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 2
       Do i2 = 1, 2
 B22m2 = Real(VSSloop(p2,MDpm2(i2),MDpm2(i1)),dp) 
coup1 = cplDpmcDpmVZ(i2,i1)
coup2 = cplDpmcDpmVZp(i1,i2)
    SumI = coup1*coup2*B22m2 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[Fd], Fd 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 5
       Do i2 = 1, 5
 H0m2 = Real(SA_Hloop(p2,MFd2(i1),MFd2(i2)),dp) 
B0m2 = 4._dp*MFd(i1)*MFd(i2)*Real(SA_B0(p2,MFd2(i1),MFd2(i2)),dp) 
coupL1 = cplcFdFdVZL(i1,i2)
coupR1 = cplcFdFdVZR(i1,i2)
coupL2 = cplcFdFdVZpL(i2,i1)
coupR2 = cplcFdFdVZpR(i2,i1)
    SumI = (coupL1*coupL2+coupR1*coupR2)*H0m2 & 
                & + 0.5_dp*(coupL1*coupR2 + coupL2*coupR1)*B0m2 
res = res +3._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[Fe], Fe 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 3
       Do i2 = 1, 3
 H0m2 = Real(SA_Hloop(p2,MFe2(i1),MFe2(i2)),dp) 
B0m2 = 4._dp*MFe(i1)*MFe(i2)*Real(SA_B0(p2,MFe2(i1),MFe2(i2)),dp) 
coupL1 = cplcFeFeVZL(i1,i2)
coupR1 = cplcFeFeVZR(i1,i2)
coupL2 = cplcFeFeVZpL(i2,i1)
coupR2 = cplcFeFeVZpR(i2,i1)
    SumI = (coupL1*coupL2+coupR1*coupR2)*H0m2 & 
                & + 0.5_dp*(coupL1*coupR2 + coupL2*coupR1)*B0m2 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[Fu], Fu 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
       Do i2 = 1, 4
 H0m2 = Real(SA_Hloop(p2,MFu2(i1),MFu2(i2)),dp) 
B0m2 = 4._dp*MFu(i1)*MFu(i2)*Real(SA_B0(p2,MFu2(i1),MFu2(i2)),dp) 
coupL1 = cplcFuFuVZL(i1,i2)
coupR1 = cplcFuFuVZR(i1,i2)
coupL2 = cplcFuFuVZpL(i2,i1)
coupR2 = cplcFuFuVZpR(i2,i1)
    SumI = (coupL1*coupL2+coupR1*coupR2)*H0m2 & 
                & + 0.5_dp*(coupL1*coupR2 + coupL2*coupR1)*B0m2 
res = res +3._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[Fv1], Fv1 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 3
       Do i2 = 1, 3
 H0m2 = Real(SA_Hloop(p2,0._dp,0._dp),dp) 
B0m2 = 4._dp*0._dp*0._dp*Real(SA_B0(p2,0._dp,0._dp),dp) 
coupL1 = cplcFv1Fv1VZL(i1,i2)
coupR1 = cplcFv1Fv1VZR(i1,i2)
coupL2 = cplcFv1Fv1VZpL(i2,i1)
coupR2 = cplcFv1Fv1VZpR(i2,i1)
    SumI = (coupL1*coupL2+coupR1*coupR2)*H0m2 & 
                & + 0.5_dp*(coupL1*coupR2 + coupL2*coupR1)*B0m2 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[gWp], gWp 
!------------------------ 
sumI = 0._dp 
 
B0m2 = Real(VGGloop(p2,MVWp2,MVWp2),dp)
coup1 = cplcgWpgWpVZ
coup2 = cplcgWpgWpVZp 
   SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
!------------------------ 
! bar[gWpC], gWpC 
!------------------------ 
sumI = 0._dp 
 
B0m2 = Real(VGGloop(p2,MVWp2,MVWp2),dp)
coup1 = cplcgWCgWCVZ
coup2 = cplcgWCgWCVZp 
   SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
!------------------------ 
! bar[gXp], gXp 
!------------------------ 
sumI = 0._dp 
 
B0m2 = Real(VGGloop(p2,MVXp2,MVXp2),dp)
coup1 = cplcgXp1gXp1VZ
coup2 = cplcgXp1gXp1VZp 
   SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
!------------------------ 
! bar[gXpC], gXpC 
!------------------------ 
sumI = 0._dp 
 
B0m2 = Real(VGGloop(p2,MVXp2,MVXp2),dp)
coup1 = cplcgXp2gXp2VZ
coup2 = cplcgXp2gXp2VZp 
   SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
!------------------------ 
! VP, hh 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 3
 res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! VZ, hh 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 3
 B0m2 = Real(VVSloop(p2,MVZ2,Mhh2(i2)),dp) 
coup1 = cplhhVZVZ(i2)
coup2 = cplhhVZVZp(i2)
    SumI = coup1*coup2*B0m2 
res = res +0.5_dp* SumI  
    End Do 
 !------------------------ 
! VZp, hh 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 3
 B0m2 = Real(VVSloop(p2,MVZp2,Mhh2(i2)),dp) 
coup1 = cplhhVZVZp(i2)
coup2 = cplhhVZpVZp(i2)
    SumI = coup1*coup2*B0m2 
res = res +0.5_dp* SumI  
    End Do 
 !------------------------ 
! conj[Hpm], Hpm 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
       Do i2 = 1, 4
 B22m2 = Real(VSSloop(p2,MHpm2(i2),MHpm2(i1)),dp) 
coup1 = cplHpmcHpmVZ(i2,i1)
coup2 = cplHpmcHpmVZp(i1,i2)
    SumI = coup1*coup2*B22m2 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! VWp, Hpm 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 B0m2 = Real(VVSloop(p2,MVWp2,MHpm2(i2)),dp) 
coup1 = cplHpmVWpVZ(i2)
coup2 = cplcHpmcVWpVZp(i2)
    SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! VXp, Hpm 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 B0m2 = Real(VVSloop(p2,MVXp2,MHpm2(i2)),dp) 
coup1 = cplHpmVXpVZ(i2)
coup2 = cplcHpmcVXpVZp(i2)
    SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! conj[VWp], VWp 
!------------------------ 
sumI = 0._dp 
 
B0m2 = Real(VVVloop(p2,MVWp2,MVWp2),dp) 
coup1 = cplcVWpVWpVZ
coup2 = cplcVWpVWpVZp
    SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
!------------------------ 
! conj[VXp], VXp 
!------------------------ 
sumI = 0._dp 
 
B0m2 = Real(VVVloop(p2,MVXp2,MVXp2),dp) 
coup1 = cplcVXpVXpVZ
coup2 = cplcVXpVXpVZp
    SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
!------------------------ 
! conj[VWp], conj[Hpm] 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 B0m2 = Real(VVSloop(p2,MVWp2,MHpm2(i2)),dp) 
coup1 = cplcHpmcVWpVZ(i2)
coup2 = cplHpmVWpVZp(i2)
    SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! conj[VXp], conj[Hpm] 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 B0m2 = Real(VVSloop(p2,MVXp2,MHpm2(i2)),dp) 
coup1 = cplcHpmcVXpVZ(i2)
coup2 = cplHpmVXpVZp(i2)
    SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! Ah 
!------------------------ 
    Do i1 = 1, 3
 SumI = 0._dp 
 A0m2 = SA_A0(MAh2(i1))
 coup1 = cplAhAhVZVZp(i1,i1)
 SumI = coup1*A0m2 
res = res +1._dp/2._dp* SumI  
      End Do 
 !------------------------ 
! conj[Dpm] 
!------------------------ 
    Do i1 = 1, 2
 SumI = 0._dp 
 A0m2 = SA_A0(MDpm2(i1))
 coup1 = cplDpmcDpmVZVZp(i1,i1)
 SumI = coup1*A0m2 
res = res +1* SumI  
      End Do 
 !------------------------ 
! hh 
!------------------------ 
    Do i1 = 1, 3
 SumI = 0._dp 
 A0m2 = SA_A0(Mhh2(i1))
 coup1 = cplhhhhVZVZp(i1,i1)
 SumI = coup1*A0m2 
res = res +1._dp/2._dp* SumI  
      End Do 
 !------------------------ 
! conj[Hpm] 
!------------------------ 
    Do i1 = 1, 4
 SumI = 0._dp 
 A0m2 = SA_A0(MHpm2(i1))
 coup1 = cplHpmcHpmVZVZp(i1,i1)
 SumI = coup1*A0m2 
res = res +1* SumI  
      End Do 
 !------------------------ 
! conj[VWp] 
!------------------------ 
SumI = 0._dp 
A0m2 = 3._dp/4._dp*SA_A0(MVWp2) +RXi/4._dp*SA_A0(MVWp2*RXi) 
coup1 = cplcVWpVWpVZVZp1
coup2 = cplcVWpVWpVZVZp2
coup3 = cplcVWpVWpVZVZp3
SumI = ((2._dp*rMS*coup1+(1-RXi**2)/8._dp*(coup2+coup3))*MVWp2-(4._dp*coup1+coup2+coup3)*A0m2)
res = res +1* SumI  
!------------------------ 
! conj[VXp] 
!------------------------ 
SumI = 0._dp 
A0m2 = 3._dp/4._dp*SA_A0(MVXp2) +RXi/4._dp*SA_A0(MVXp2*RXi) 
coup1 = cplcVXpVXpVZVZp1
coup2 = cplcVXpVXpVZVZp2
coup3 = cplcVXpVXpVZVZp3
SumI = ((2._dp*rMS*coup1+(1-RXi**2)/8._dp*(coup2+coup3))*MVXp2-(4._dp*coup1+coup2+coup3)*A0m2)
res = res +1* SumI  
res = oo16pi2*res 
 
End Subroutine Pi1LoopVZVZp 
 
Subroutine DerPi1LoopVZVZp(p2,MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,MFe2,MFu,              & 
& MFu2,Mhh,Mhh2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,cplAhAhVZVZp,       & 
& cplAhhhVZ,cplAhhhVZp,cplcFdFdVZL,cplcFdFdVZpL,cplcFdFdVZpR,cplcFdFdVZR,cplcFeFeVZL,    & 
& cplcFeFeVZpL,cplcFeFeVZpR,cplcFeFeVZR,cplcFuFuVZL,cplcFuFuVZpL,cplcFuFuVZpR,           & 
& cplcFuFuVZR,cplcFv1Fv1VZL,cplcFv1Fv1VZpL,cplcFv1Fv1VZpR,cplcFv1Fv1VZR,cplcgWCgWCVZ,    & 
& cplcgWCgWCVZp,cplcgWpgWpVZ,cplcgWpgWpVZp,cplcgXp1gXp1VZ,cplcgXp1gXp1VZp,               & 
& cplcgXp2gXp2VZ,cplcgXp2gXp2VZp,cplcHpmcVWpVZ,cplcHpmcVWpVZp,cplcHpmcVXpVZ,             & 
& cplcHpmcVXpVZp,cplcVWpVWpVZ,cplcVWpVWpVZp,cplcVWpVWpVZVZp1,cplcVWpVWpVZVZp2,           & 
& cplcVWpVWpVZVZp3,cplcVXpVXpVZ,cplcVXpVXpVZp,cplcVXpVXpVZVZp1,cplcVXpVXpVZVZp2,         & 
& cplcVXpVXpVZVZp3,cplDpmcDpmVZ,cplDpmcDpmVZp,cplDpmcDpmVZVZp,cplhhhhVZVZp,              & 
& cplhhVPVZ,cplhhVPVZp,cplhhVZpVZp,cplhhVZVZ,cplhhVZVZp,cplHpmcHpmVZ,cplHpmcHpmVZp,      & 
& cplHpmcHpmVZVZp,cplHpmVWpVZ,cplHpmVWpVZp,cplHpmVXpVZ,cplHpmVXpVZp,kont,res)

Implicit None 
Real(dp), Intent(in) :: MAh(3),MAh2(3),MDpm(2),MDpm2(2),MFd(5),MFd2(5),MFe(3),MFe2(3),MFu(4),MFu2(4),         & 
& Mhh(3),Mhh2(3),MHpm(4),MHpm2(4),MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2

Complex(dp), Intent(in) :: cplAhAhVZVZp(3,3),cplAhhhVZ(3,3),cplAhhhVZp(3,3),cplcFdFdVZL(5,5),cplcFdFdVZpL(5,5),  & 
& cplcFdFdVZpR(5,5),cplcFdFdVZR(5,5),cplcFeFeVZL(3,3),cplcFeFeVZpL(3,3),cplcFeFeVZpR(3,3),& 
& cplcFeFeVZR(3,3),cplcFuFuVZL(4,4),cplcFuFuVZpL(4,4),cplcFuFuVZpR(4,4),cplcFuFuVZR(4,4),& 
& cplcFv1Fv1VZL(3,3),cplcFv1Fv1VZpL(3,3),cplcFv1Fv1VZpR(3,3),cplcFv1Fv1VZR(3,3),         & 
& cplcgWCgWCVZ,cplcgWCgWCVZp,cplcgWpgWpVZ,cplcgWpgWpVZp,cplcgXp1gXp1VZ,cplcgXp1gXp1VZp,  & 
& cplcgXp2gXp2VZ,cplcgXp2gXp2VZp,cplcHpmcVWpVZ(4),cplcHpmcVWpVZp(4),cplcHpmcVXpVZ(4),    & 
& cplcHpmcVXpVZp(4),cplcVWpVWpVZ,cplcVWpVWpVZp,cplcVWpVWpVZVZp1,cplcVWpVWpVZVZp2,        & 
& cplcVWpVWpVZVZp3,cplcVXpVXpVZ,cplcVXpVXpVZp,cplcVXpVXpVZVZp1,cplcVXpVXpVZVZp2,         & 
& cplcVXpVXpVZVZp3,cplDpmcDpmVZ(2,2),cplDpmcDpmVZp(2,2),cplDpmcDpmVZVZp(2,2),            & 
& cplhhhhVZVZp(3,3),cplhhVPVZ(3),cplhhVPVZp(3),cplhhVZpVZp(3),cplhhVZVZ(3),              & 
& cplhhVZVZp(3),cplHpmcHpmVZ(4,4),cplHpmcHpmVZp(4,4),cplHpmcHpmVZVZp(4,4),               & 
& cplHpmVWpVZ(4),cplHpmVWpVZp(4),cplHpmVXpVZ(4),cplHpmVXpVZp(4)

Integer, Intent(inout) :: kont 
Real(dp) :: B0m2, F0m2, G0m2, B1m2, H0m2, B22m2, m1, m2 
Real(dp), Intent(in) :: p2 
Complex(dp) :: A0m2 
Complex(dp), Intent(inout) :: res 
Complex(dp) :: coupL1, coupR1, coupL2,coupR2, coup1,coup2, coup3, temp, sumI 
Integer :: i1,i2,i3,i4, gO1, gO2, ierr 
 
 
Real(dp) ::MVG,MVP,MVG2,MVP2
MVG = Mass_Regulator_PhotonGluon 
MVP = Mass_Regulator_PhotonGluon 
MVG2 = Mass_Regulator_PhotonGluon**2 
MVP2 = Mass_Regulator_PhotonGluon**2 

res = 0._dp 
 
!------------------------ 
! hh, Ah 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 3
       Do i2 = 1, 3
 B22m2 = Real(DerVSSloop(p2,MAh2(i2),Mhh2(i1)),dp) 
coup1 = cplAhhhVZ(i2,i1)
coup2 = cplAhhhVZp(i2,i1)
    SumI = coup1*coup2*B22m2 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! conj[Dpm], Dpm 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 2
       Do i2 = 1, 2
 B22m2 = Real(DerVSSloop(p2,MDpm2(i2),MDpm2(i1)),dp) 
coup1 = cplDpmcDpmVZ(i2,i1)
coup2 = cplDpmcDpmVZp(i1,i2)
    SumI = coup1*coup2*B22m2 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[Fd], Fd 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 5
       Do i2 = 1, 5
 H0m2 = Real(SA_DerHloop(p2,MFd2(i1),MFd2(i2)),dp) 
B0m2 = 2._dp*MFd(i1)*MFd(i2)*Real(SA_DerB0(p2,MFd2(i1),MFd2(i2)),dp) 
coupL1 = cplcFdFdVZL(i1,i2)
coupR1 = cplcFdFdVZR(i1,i2)
coupL2 = cplcFdFdVZpL(i2,i1)
coupR2 = cplcFdFdVZpR(i2,i1)
    SumI = (coupL1*coupL2+coupR1*coupR2)*H0m2 & 
                & + 0.5_dp*(coupL1*coupR2 + coupL2*coupR1)*B0m2 
res = res +3._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[Fe], Fe 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 3
       Do i2 = 1, 3
 H0m2 = Real(SA_DerHloop(p2,MFe2(i1),MFe2(i2)),dp) 
B0m2 = 2._dp*MFe(i1)*MFe(i2)*Real(SA_DerB0(p2,MFe2(i1),MFe2(i2)),dp) 
coupL1 = cplcFeFeVZL(i1,i2)
coupR1 = cplcFeFeVZR(i1,i2)
coupL2 = cplcFeFeVZpL(i2,i1)
coupR2 = cplcFeFeVZpR(i2,i1)
    SumI = (coupL1*coupL2+coupR1*coupR2)*H0m2 & 
                & + 0.5_dp*(coupL1*coupR2 + coupL2*coupR1)*B0m2 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[Fu], Fu 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
       Do i2 = 1, 4
 H0m2 = Real(SA_DerHloop(p2,MFu2(i1),MFu2(i2)),dp) 
B0m2 = 2._dp*MFu(i1)*MFu(i2)*Real(SA_DerB0(p2,MFu2(i1),MFu2(i2)),dp) 
coupL1 = cplcFuFuVZL(i1,i2)
coupR1 = cplcFuFuVZR(i1,i2)
coupL2 = cplcFuFuVZpL(i2,i1)
coupR2 = cplcFuFuVZpR(i2,i1)
    SumI = (coupL1*coupL2+coupR1*coupR2)*H0m2 & 
                & + 0.5_dp*(coupL1*coupR2 + coupL2*coupR1)*B0m2 
res = res +3._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[Fv1], Fv1 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 3
       Do i2 = 1, 3
 H0m2 = Real(SA_DerHloop(p2,0._dp,0._dp),dp) 
B0m2 = 2._dp*0._dp*0._dp*Real(SA_DerB0(p2,0._dp,0._dp),dp) 
coupL1 = cplcFv1Fv1VZL(i1,i2)
coupR1 = cplcFv1Fv1VZR(i1,i2)
coupL2 = cplcFv1Fv1VZpL(i2,i1)
coupR2 = cplcFv1Fv1VZpR(i2,i1)
    SumI = (coupL1*coupL2+coupR1*coupR2)*H0m2 & 
                & + 0.5_dp*(coupL1*coupR2 + coupL2*coupR1)*B0m2 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[gWp], gWp 
!------------------------ 
sumI = 0._dp 
 
B0m2 = Real(DerVGGloop(p2,MVWp2,MVWp2),dp)
coup1 = cplcgWpgWpVZ
coup2 = cplcgWpgWpVZp 
   SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
!------------------------ 
! bar[gWpC], gWpC 
!------------------------ 
sumI = 0._dp 
 
B0m2 = Real(DerVGGloop(p2,MVWp2,MVWp2),dp)
coup1 = cplcgWCgWCVZ
coup2 = cplcgWCgWCVZp 
   SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
!------------------------ 
! bar[gXp], gXp 
!------------------------ 
sumI = 0._dp 
 
B0m2 = Real(DerVGGloop(p2,MVXp2,MVXp2),dp)
coup1 = cplcgXp1gXp1VZ
coup2 = cplcgXp1gXp1VZp 
   SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
!------------------------ 
! bar[gXpC], gXpC 
!------------------------ 
sumI = 0._dp 
 
B0m2 = Real(DerVGGloop(p2,MVXp2,MVXp2),dp)
coup1 = cplcgXp2gXp2VZ
coup2 = cplcgXp2gXp2VZp 
   SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
!------------------------ 
! VP, hh 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 3
 B0m2 = Real(DerVVSloop(p2,MVP2,Mhh2(i2)),dp) 
coup1 = cplhhVPVZ(i2)
coup2 = cplhhVPVZp(i2)
    SumI = coup1*coup2*B0m2 
res = res +0.5_dp* SumI  
    End Do 
 !------------------------ 
! VZ, hh 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 3
 B0m2 = Real(DerVVSloop(p2,MVZ2,Mhh2(i2)),dp) 
coup1 = cplhhVZVZ(i2)
coup2 = cplhhVZVZp(i2)
    SumI = coup1*coup2*B0m2 
res = res +0.5_dp* SumI  
    End Do 
 !------------------------ 
! VZp, hh 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 3
 B0m2 = Real(DerVVSloop(p2,MVZp2,Mhh2(i2)),dp) 
coup1 = cplhhVZVZp(i2)
coup2 = cplhhVZpVZp(i2)
    SumI = coup1*coup2*B0m2 
res = res +0.5_dp* SumI  
    End Do 
 !------------------------ 
! conj[Hpm], Hpm 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
       Do i2 = 1, 4
 B22m2 = Real(DerVSSloop(p2,MHpm2(i2),MHpm2(i1)),dp) 
coup1 = cplHpmcHpmVZ(i2,i1)
coup2 = cplHpmcHpmVZp(i1,i2)
    SumI = coup1*coup2*B22m2 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! VWp, Hpm 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 B0m2 = Real(DerVVSloop(p2,MVWp2,MHpm2(i2)),dp) 
coup1 = cplHpmVWpVZ(i2)
coup2 = cplcHpmcVWpVZp(i2)
    SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! VXp, Hpm 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 B0m2 = Real(DerVVSloop(p2,MVXp2,MHpm2(i2)),dp) 
coup1 = cplHpmVXpVZ(i2)
coup2 = cplcHpmcVXpVZp(i2)
    SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! conj[VWp], VWp 
!------------------------ 
sumI = 0._dp 
 
B0m2 = Real(DerVVVloop(p2,MVWp2,MVWp2),dp) 
coup1 = cplcVWpVWpVZ
coup2 = cplcVWpVWpVZp
    SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
!------------------------ 
! conj[VXp], VXp 
!------------------------ 
sumI = 0._dp 
 
B0m2 = Real(DerVVVloop(p2,MVXp2,MVXp2),dp) 
coup1 = cplcVXpVXpVZ
coup2 = cplcVXpVXpVZp
    SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
!------------------------ 
! conj[VWp], conj[Hpm] 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 B0m2 = Real(DerVVSloop(p2,MVWp2,MHpm2(i2)),dp) 
coup1 = cplcHpmcVWpVZ(i2)
coup2 = cplHpmVWpVZp(i2)
    SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! conj[VXp], conj[Hpm] 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 B0m2 = Real(DerVVSloop(p2,MVXp2,MHpm2(i2)),dp) 
coup1 = cplcHpmcVXpVZ(i2)
coup2 = cplHpmVXpVZp(i2)
    SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! Ah 
!------------------------ 
    Do i1 = 1, 3
 SumI = 0._dp 
 A0m2 = SA_DerA0(MAh2(i1))
 coup1 = cplAhAhVZVZp(i1,i1)
 SumI = coup1*A0m2 
res = res +1._dp/2._dp* SumI  
      End Do 
 !------------------------ 
! conj[Dpm] 
!------------------------ 
    Do i1 = 1, 2
 SumI = 0._dp 
 A0m2 = SA_DerA0(MDpm2(i1))
 coup1 = cplDpmcDpmVZVZp(i1,i1)
 SumI = coup1*A0m2 
res = res +1* SumI  
      End Do 
 !------------------------ 
! hh 
!------------------------ 
    Do i1 = 1, 3
 SumI = 0._dp 
 A0m2 = SA_DerA0(Mhh2(i1))
 coup1 = cplhhhhVZVZp(i1,i1)
 SumI = coup1*A0m2 
res = res +1._dp/2._dp* SumI  
      End Do 
 !------------------------ 
! conj[Hpm] 
!------------------------ 
    Do i1 = 1, 4
 SumI = 0._dp 
 A0m2 = SA_DerA0(MHpm2(i1))
 coup1 = cplHpmcHpmVZVZp(i1,i1)
 SumI = coup1*A0m2 
res = res +1* SumI  
      End Do 
 !------------------------ 
! conj[VWp] 
!------------------------ 
SumI = 0._dp 
A0m2 = 3._dp/4._dp*SA_DerA0(MVWp2) +RXi/4._dp*SA_DerA0(MVWp2*RXi) 
coup1 = cplcVWpVWpVZVZp1
coup2 = cplcVWpVWpVZVZp2
coup3 = cplcVWpVWpVZVZp3
SumI = ((2._dp*DerrMS*coup1+(1-RXi**2)/8._dp*(coup2+coup3))*MVWp2-(4._dp*coup1+coup2+coup3)*A0m2)
res = res +1* SumI  
!------------------------ 
! conj[VXp] 
!------------------------ 
SumI = 0._dp 
A0m2 = 3._dp/4._dp*SA_DerA0(MVXp2) +RXi/4._dp*SA_DerA0(MVXp2*RXi) 
coup1 = cplcVXpVXpVZVZp1
coup2 = cplcVXpVXpVZVZp2
coup3 = cplcVXpVXpVZVZp3
SumI = ((2._dp*DerrMS*coup1+(1-RXi**2)/8._dp*(coup2+coup3))*MVXp2-(4._dp*coup1+coup2+coup3)*A0m2)
res = res +1* SumI  
res = oo16pi2*res 
 
End Subroutine DerPi1LoopVZVZp 
 
Subroutine Pi1LoopVWpVXp(p2,MAh,MAh2,MFd,MFd2,MFu,MFu2,Mhh,Mhh2,MHpm,MHpm2,           & 
& MVZ,MVZ2,MVZp,MVZp2,cplAhcHpmcVXp,cplAhHpmVWp,cplcFdFucVXpL,cplcFdFucVXpR,             & 
& cplcFuFdVWpL,cplcFuFdVWpR,cplcHpmcVXpVP,cplcHpmcVXpVZ,cplcHpmcVXpVZp,cplhhcHpmcVXp,    & 
& cplhhHpmVWp,cplHpmcHpmcVXpVWp,cplHpmVPVWp,cplHpmVWpVZ,cplHpmVWpVZp,kont,res)

Implicit None 
Real(dp), Intent(in) :: MAh(3),MAh2(3),MFd(5),MFd2(5),MFu(4),MFu2(4),Mhh(3),Mhh2(3),MHpm(4),MHpm2(4),         & 
& MVZ,MVZ2,MVZp,MVZp2

Complex(dp), Intent(in) :: cplAhcHpmcVXp(3,4),cplAhHpmVWp(3,4),cplcFdFucVXpL(5,4),cplcFdFucVXpR(5,4),            & 
& cplcFuFdVWpL(4,5),cplcFuFdVWpR(4,5),cplcHpmcVXpVP(4),cplcHpmcVXpVZ(4),cplcHpmcVXpVZp(4),& 
& cplhhcHpmcVXp(3,4),cplhhHpmVWp(3,4),cplHpmcHpmcVXpVWp(4,4),cplHpmVPVWp(4),             & 
& cplHpmVWpVZ(4),cplHpmVWpVZp(4)

Integer, Intent(inout) :: kont 
Real(dp) :: B0m2, F0m2, G0m2, B1m2, H0m2, B22m2, m1, m2 
Real(dp), Intent(in) :: p2 
Complex(dp) :: A0m2 
Complex(dp), Intent(inout) :: res 
Complex(dp) :: coupL1, coupR1, coupL2,coupR2, coup1,coup2, coup3, temp, sumI 
Integer :: i1,i2,i3,i4, gO1, gO2, ierr 
 
 
res = 0._dp 
 
!------------------------ 
! Hpm, Ah 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
       Do i2 = 1, 3
 B22m2 = Real(VSSloop(p2,MAh2(i2),MHpm2(i1)),dp) 
coup1 = cplAhHpmVWp(i2,i1)
coup2 = cplAhcHpmcVXp(i2,i1)
    SumI = coup1*coup2*B22m2 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[Fu], Fd 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
       Do i2 = 1, 5
 H0m2 = Real(SA_Hloop(p2,MFu2(i1),MFd2(i2)),dp) 
B0m2 = 4._dp*MFu(i1)*MFd(i2)*Real(SA_B0(p2,MFu2(i1),MFd2(i2)),dp) 
coupL1 = cplcFuFdVWpL(i1,i2)
coupR1 = cplcFuFdVWpR(i1,i2)
coupL2 = cplcFdFucVXpL(i2,i1)
coupR2 = cplcFdFucVXpR(i2,i1)
    SumI = (coupL1*coupL2+coupR1*coupR2)*H0m2 & 
                & + 0.5_dp*(coupL1*coupR2 + coupL2*coupR1)*B0m2 
res = res +3._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! Hpm, hh 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
       Do i2 = 1, 3
 B22m2 = Real(VSSloop(p2,Mhh2(i2),MHpm2(i1)),dp) 
coup1 = cplhhHpmVWp(i2,i1)
coup2 = cplhhcHpmcVXp(i2,i1)
    SumI = coup1*coup2*B22m2 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! VP, Hpm 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! VZ, Hpm 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 B0m2 = Real(VVSloop(p2,MVZ2,MHpm2(i2)),dp) 
coup1 = cplHpmVWpVZ(i2)
coup2 = cplcHpmcVXpVZ(i2)
    SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! VZp, Hpm 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 B0m2 = Real(VVSloop(p2,MVZp2,MHpm2(i2)),dp) 
coup1 = cplHpmVWpVZp(i2)
coup2 = cplcHpmcVXpVZp(i2)
    SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! conj[Hpm] 
!------------------------ 
    Do i1 = 1, 4
 SumI = 0._dp 
 A0m2 = SA_A0(MHpm2(i1))
 coup1 = cplHpmcHpmcVXpVWp(i1,i1)
 SumI = coup1*A0m2 
res = res +1* SumI  
      End Do 
 res = oo16pi2*res 
 
End Subroutine Pi1LoopVWpVXp 
 
Subroutine DerPi1LoopVWpVXp(p2,MAh,MAh2,MFd,MFd2,MFu,MFu2,Mhh,Mhh2,MHpm,              & 
& MHpm2,MVZ,MVZ2,MVZp,MVZp2,cplAhcHpmcVXp,cplAhHpmVWp,cplcFdFucVXpL,cplcFdFucVXpR,       & 
& cplcFuFdVWpL,cplcFuFdVWpR,cplcHpmcVXpVP,cplcHpmcVXpVZ,cplcHpmcVXpVZp,cplhhcHpmcVXp,    & 
& cplhhHpmVWp,cplHpmcHpmcVXpVWp,cplHpmVPVWp,cplHpmVWpVZ,cplHpmVWpVZp,kont,res)

Implicit None 
Real(dp), Intent(in) :: MAh(3),MAh2(3),MFd(5),MFd2(5),MFu(4),MFu2(4),Mhh(3),Mhh2(3),MHpm(4),MHpm2(4),         & 
& MVZ,MVZ2,MVZp,MVZp2

Complex(dp), Intent(in) :: cplAhcHpmcVXp(3,4),cplAhHpmVWp(3,4),cplcFdFucVXpL(5,4),cplcFdFucVXpR(5,4),            & 
& cplcFuFdVWpL(4,5),cplcFuFdVWpR(4,5),cplcHpmcVXpVP(4),cplcHpmcVXpVZ(4),cplcHpmcVXpVZp(4),& 
& cplhhcHpmcVXp(3,4),cplhhHpmVWp(3,4),cplHpmcHpmcVXpVWp(4,4),cplHpmVPVWp(4),             & 
& cplHpmVWpVZ(4),cplHpmVWpVZp(4)

Integer, Intent(inout) :: kont 
Real(dp) :: B0m2, F0m2, G0m2, B1m2, H0m2, B22m2, m1, m2 
Real(dp), Intent(in) :: p2 
Complex(dp) :: A0m2 
Complex(dp), Intent(inout) :: res 
Complex(dp) :: coupL1, coupR1, coupL2,coupR2, coup1,coup2, coup3, temp, sumI 
Integer :: i1,i2,i3,i4, gO1, gO2, ierr 
 
 
Real(dp) ::MVG,MVP,MVG2,MVP2
MVG = Mass_Regulator_PhotonGluon 
MVP = Mass_Regulator_PhotonGluon 
MVG2 = Mass_Regulator_PhotonGluon**2 
MVP2 = Mass_Regulator_PhotonGluon**2 

res = 0._dp 
 
!------------------------ 
! Hpm, Ah 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
       Do i2 = 1, 3
 B22m2 = Real(DerVSSloop(p2,MAh2(i2),MHpm2(i1)),dp) 
coup1 = cplAhHpmVWp(i2,i1)
coup2 = cplAhcHpmcVXp(i2,i1)
    SumI = coup1*coup2*B22m2 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[Fu], Fd 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
       Do i2 = 1, 5
 H0m2 = Real(SA_DerHloop(p2,MFu2(i1),MFd2(i2)),dp) 
B0m2 = 2._dp*MFu(i1)*MFd(i2)*Real(SA_DerB0(p2,MFu2(i1),MFd2(i2)),dp) 
coupL1 = cplcFuFdVWpL(i1,i2)
coupR1 = cplcFuFdVWpR(i1,i2)
coupL2 = cplcFdFucVXpL(i2,i1)
coupR2 = cplcFdFucVXpR(i2,i1)
    SumI = (coupL1*coupL2+coupR1*coupR2)*H0m2 & 
                & + 0.5_dp*(coupL1*coupR2 + coupL2*coupR1)*B0m2 
res = res +3._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! Hpm, hh 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
       Do i2 = 1, 3
 B22m2 = Real(DerVSSloop(p2,Mhh2(i2),MHpm2(i1)),dp) 
coup1 = cplhhHpmVWp(i2,i1)
coup2 = cplhhcHpmcVXp(i2,i1)
    SumI = coup1*coup2*B22m2 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! VP, Hpm 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 B0m2 = Real(DerVVSloop(p2,MVP2,MHpm2(i2)),dp) 
coup1 = cplHpmVPVWp(i2)
coup2 = cplcHpmcVXpVP(i2)
    SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! VZ, Hpm 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 B0m2 = Real(DerVVSloop(p2,MVZ2,MHpm2(i2)),dp) 
coup1 = cplHpmVWpVZ(i2)
coup2 = cplcHpmcVXpVZ(i2)
    SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! VZp, Hpm 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 B0m2 = Real(DerVVSloop(p2,MVZp2,MHpm2(i2)),dp) 
coup1 = cplHpmVWpVZp(i2)
coup2 = cplcHpmcVXpVZp(i2)
    SumI = coup1*coup2*B0m2 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! conj[Hpm] 
!------------------------ 
    Do i1 = 1, 4
 SumI = 0._dp 
 A0m2 = SA_DerA0(MHpm2(i1))
 coup1 = cplHpmcHpmcVXpVWp(i1,i1)
 SumI = coup1*A0m2 
res = res +1* SumI  
      End Do 
 res = oo16pi2*res 
 
End Subroutine DerPi1LoopVWpVXp 
 
Subroutine Pi1LoopVZhh(p2,MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,MFe2,MFu,MFu2,             & 
& Mhh,Mhh2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,cplAhhhhh,cplAhhhVZ,cplcFdFdhhL,             & 
& cplcFdFdhhR,cplcFdFdVZL,cplcFdFdVZR,cplcFeFehhL,cplcFeFehhR,cplcFeFeVZL,               & 
& cplcFeFeVZR,cplcFuFuhhL,cplcFuFuhhR,cplcFuFuVZL,cplcFuFuVZR,cplcgWCgWChh,              & 
& cplcgWCgWCVZ,cplcgWpgWphh,cplcgWpgWpVZ,cplcgXp1gXp1hh,cplcgXp1gXp1VZ,cplcgXp2gXp2hh,   & 
& cplcgXp2gXp2VZ,cplcHpmcVWpVZ,cplcHpmcVXpVZ,cplcVWpVWpVZ,cplcVXpVXpVZ,cplDpmcDpmVZ,     & 
& cplDpmhhcDpm,cplhhcHpmcVWp,cplhhcHpmcVXp,cplhhcVWpVWp,cplhhcVXpVXp,cplhhHpmcHpm,       & 
& cplhhHpmVWp,cplhhHpmVXp,cplHpmcHpmVZ,cplHpmVWpVZ,cplHpmVXpVZ,kont,res)

Implicit None 
Real(dp), Intent(in) :: MAh(3),MAh2(3),MDpm(2),MDpm2(2),MFd(5),MFd2(5),MFe(3),MFe2(3),MFu(4),MFu2(4),         & 
& Mhh(3),Mhh2(3),MHpm(4),MHpm2(4),MVWp,MVWp2,MVXp,MVXp2

Complex(dp), Intent(in) :: cplAhhhhh(3,3,3),cplAhhhVZ(3,3),cplcFdFdhhL(5,5,3),cplcFdFdhhR(5,5,3),cplcFdFdVZL(5,5),& 
& cplcFdFdVZR(5,5),cplcFeFehhL(3,3,3),cplcFeFehhR(3,3,3),cplcFeFeVZL(3,3),               & 
& cplcFeFeVZR(3,3),cplcFuFuhhL(4,4,3),cplcFuFuhhR(4,4,3),cplcFuFuVZL(4,4),               & 
& cplcFuFuVZR(4,4),cplcgWCgWChh(3),cplcgWCgWCVZ,cplcgWpgWphh(3),cplcgWpgWpVZ,            & 
& cplcgXp1gXp1hh(3),cplcgXp1gXp1VZ,cplcgXp2gXp2hh(3),cplcgXp2gXp2VZ,cplcHpmcVWpVZ(4),    & 
& cplcHpmcVXpVZ(4),cplcVWpVWpVZ,cplcVXpVXpVZ,cplDpmcDpmVZ(2,2),cplDpmhhcDpm(2,3,2),      & 
& cplhhcHpmcVWp(3,4),cplhhcHpmcVXp(3,4),cplhhcVWpVWp(3),cplhhcVXpVXp(3),cplhhHpmcHpm(3,4,4),& 
& cplhhHpmVWp(3,4),cplhhHpmVXp(3,4),cplHpmcHpmVZ(4,4),cplHpmVWpVZ(4),cplHpmVXpVZ(4)

Integer, Intent(inout) :: kont 
Real(dp) :: B0m2, F0m2, G0m2, B1m2, H0m2, B22m2, m1, m2 
Real(dp), Intent(in) :: p2 
Complex(dp) :: A0m2 
Complex(dp), Intent(inout) :: res(3) 
Complex(dp) :: coupL1, coupR1, coupL2,coupR2, coup1,coup2, coup3, temp, sumI 
Integer :: i1,i2,i3,i4, gO1, gO2, ierr 
 
 
res = 0._dp 
 
!------------------------ 
! hh, Ah 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 3
       Do i2 = 1, 3
 Do gO2=1,3 
B0m2 = Real(SA_B0(p2,MAh2(i2),Mhh2(i1)),dp) 
B1m2 = Real(SA_B1(p2,MAh2(i2),Mhh2(i1)),dp) 
coup1 = cplAhhhVZ(i2,i1)
coup2 = cplAhhhhh(i2,gO2,i1)
    SumI = -coup1*coup2*(B1m2+0.5_dp*B0m2)
End do 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! conj[Dpm], Dpm 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 2
       Do i2 = 1, 2
 Do gO2=1,3 
B0m2 = Real(SA_B0(p2,MDpm2(i2),MDpm2(i1)),dp) 
B1m2 = Real(SA_B1(p2,MDpm2(i2),MDpm2(i1)),dp) 
coup1 = cplDpmcDpmVZ(i2,i1)
coup2 = cplDpmhhcDpm(i1,gO2,i2)
    SumI = -coup1*coup2*(B1m2+0.5_dp*B0m2)
End do 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[Fd], Fd 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 5
       Do i2 = 1, 5
 Do gO2=1,3 
B0m2 = Real(SA_B0(p2,MFd2(i1),MFd2(i2)),dp) 
B1m2 = Real(SA_B1(p2,MFd2(i1),MFd2(i2)),dp) 
coupL1 = cplcFdFdVZL(i1,i2)
coupR1 = cplcFdFdVZR(i1,i2)
coupL2 = cplcFdFdhhL(i2,i1,gO2)
coupR2 = cplcFdFdhhR(i2,i1,gO2)
    SumI = (coupL1*coupL2+coupR1*coupR2)*MFd(i1)*(B0m2+B1m2) & 
  & + (coupL1*coupR2+coupR1*coupL2)*MFd(i2)*B1m2  
End do 
res = res +3._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[Fe], Fe 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 3
       Do i2 = 1, 3
 Do gO2=1,3 
B0m2 = Real(SA_B0(p2,MFe2(i1),MFe2(i2)),dp) 
B1m2 = Real(SA_B1(p2,MFe2(i1),MFe2(i2)),dp) 
coupL1 = cplcFeFeVZL(i1,i2)
coupR1 = cplcFeFeVZR(i1,i2)
coupL2 = cplcFeFehhL(i2,i1,gO2)
coupR2 = cplcFeFehhR(i2,i1,gO2)
    SumI = (coupL1*coupL2+coupR1*coupR2)*MFe(i1)*(B0m2+B1m2) & 
  & + (coupL1*coupR2+coupR1*coupL2)*MFe(i2)*B1m2  
End do 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[Fu], Fu 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
       Do i2 = 1, 4
 Do gO2=1,3 
B0m2 = Real(SA_B0(p2,MFu2(i1),MFu2(i2)),dp) 
B1m2 = Real(SA_B1(p2,MFu2(i1),MFu2(i2)),dp) 
coupL1 = cplcFuFuVZL(i1,i2)
coupR1 = cplcFuFuVZR(i1,i2)
coupL2 = cplcFuFuhhL(i2,i1,gO2)
coupR2 = cplcFuFuhhR(i2,i1,gO2)
    SumI = (coupL1*coupL2+coupR1*coupR2)*MFu(i1)*(B0m2+B1m2) & 
  & + (coupL1*coupR2+coupR1*coupL2)*MFu(i2)*B1m2  
End do 
res = res +3._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[gWp], gWp 
!------------------------ 
sumI = 0._dp 
 
Do gO2=1,3 
B0m2 = Real(SA_B0(p2,MVWp2,MVWp2),dp) 
B1m2 = Real(SA_B1(p2,MVWp2,MVWp2),dp) 
coup1 = cplcgWpgWpVZ
coup2 = cplcgWpgWphh(gO2) 
   SumI = -0.5_dp*coup1*coup2*(B0m2+B1m2) 
End do 
res = res +1._dp* SumI  
!------------------------ 
! bar[gWpC], gWpC 
!------------------------ 
sumI = 0._dp 
 
Do gO2=1,3 
B0m2 = Real(SA_B0(p2,MVWp2,MVWp2),dp) 
B1m2 = Real(SA_B1(p2,MVWp2,MVWp2),dp) 
coup1 = cplcgWCgWCVZ
coup2 = cplcgWCgWChh(gO2) 
   SumI = -0.5_dp*coup1*coup2*(B0m2+B1m2) 
End do 
res = res +1._dp* SumI  
!------------------------ 
! bar[gXp], gXp 
!------------------------ 
sumI = 0._dp 
 
Do gO2=1,3 
B0m2 = Real(SA_B0(p2,MVXp2,MVXp2),dp) 
B1m2 = Real(SA_B1(p2,MVXp2,MVXp2),dp) 
coup1 = cplcgXp1gXp1VZ
coup2 = cplcgXp1gXp1hh(gO2) 
   SumI = -0.5_dp*coup1*coup2*(B0m2+B1m2) 
End do 
res = res +1._dp* SumI  
!------------------------ 
! bar[gXpC], gXpC 
!------------------------ 
sumI = 0._dp 
 
Do gO2=1,3 
B0m2 = Real(SA_B0(p2,MVXp2,MVXp2),dp) 
B1m2 = Real(SA_B1(p2,MVXp2,MVXp2),dp) 
coup1 = cplcgXp2gXp2VZ
coup2 = cplcgXp2gXp2hh(gO2) 
   SumI = -0.5_dp*coup1*coup2*(B0m2+B1m2) 
End do 
res = res +1._dp* SumI  
!------------------------ 
! conj[Hpm], Hpm 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
       Do i2 = 1, 4
 Do gO2=1,3 
B0m2 = Real(SA_B0(p2,MHpm2(i2),MHpm2(i1)),dp) 
B1m2 = Real(SA_B1(p2,MHpm2(i2),MHpm2(i1)),dp) 
coup1 = cplHpmcHpmVZ(i2,i1)
coup2 = cplhhHpmcHpm(gO2,i1,i2)
    SumI = -coup1*coup2*(B1m2+0.5_dp*B0m2)
End do 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! VWp, Hpm 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 Do gO2=1,3 
B0m2 = Real(SA_B0(p2,MVWp2,MHpm2(i2)),dp) 
B1m2 = Real(SA_B1(p2,MVWp2,MHpm2(i2)),dp) 
coup1 = cplHpmVWpVZ(i2)
coup2 = cplhhcHpmcVWp(gO2,i2)
    SumI = coup1*coup2*(B1m2-B0m2) 
End do 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! VXp, Hpm 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 Do gO2=1,3 
B0m2 = Real(SA_B0(p2,MVXp2,MHpm2(i2)),dp) 
B1m2 = Real(SA_B1(p2,MVXp2,MHpm2(i2)),dp) 
coup1 = cplHpmVXpVZ(i2)
coup2 = cplhhcHpmcVXp(gO2,i2)
    SumI = coup1*coup2*(B1m2-B0m2) 
End do 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! conj[VWp], VWp 
!------------------------ 
sumI = 0._dp 
 
Do gO2=1,3 
B0m2 = Real(SA_B0(p2,MVWp2,MVWp2),dp)
B1m2 = Real(SA_B1(p2,MVWp2,MVWp2),dp) 
coup1 = cplcVWpVWpVZ
coup2 = cplhhcVWpVWp(gO2)
    SumI = coup1*coup2*(3._dp/2._dp*B0m2+3._dp*B1m2) 
End do 
res = res +1._dp* SumI  
!------------------------ 
! conj[VXp], VXp 
!------------------------ 
sumI = 0._dp 
 
Do gO2=1,3 
B0m2 = Real(SA_B0(p2,MVXp2,MVXp2),dp)
B1m2 = Real(SA_B1(p2,MVXp2,MVXp2),dp) 
coup1 = cplcVXpVXpVZ
coup2 = cplhhcVXpVXp(gO2)
    SumI = coup1*coup2*(3._dp/2._dp*B0m2+3._dp*B1m2) 
End do 
res = res +1._dp* SumI  
!------------------------ 
! conj[VWp], conj[Hpm] 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 Do gO2=1,3 
B0m2 = Real(SA_B0(p2,MVWp2,MHpm2(i2)),dp) 
B1m2 = Real(SA_B1(p2,MVWp2,MHpm2(i2)),dp) 
coup1 = cplcHpmcVWpVZ(i2)
coup2 = cplhhHpmVWp(gO2,i2)
    SumI = coup1*coup2*(B1m2-B0m2) 
End do 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! conj[VXp], conj[Hpm] 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 Do gO2=1,3 
B0m2 = Real(SA_B0(p2,MVXp2,MHpm2(i2)),dp) 
B1m2 = Real(SA_B1(p2,MVXp2,MHpm2(i2)),dp) 
coup1 = cplcHpmcVXpVZ(i2)
coup2 = cplhhHpmVXp(gO2,i2)
    SumI = coup1*coup2*(B1m2-B0m2) 
End do 
res = res +1._dp* SumI  
    End Do 
 res = oo16pi2*res 
 
End Subroutine Pi1LoopVZhh 
 
Subroutine DerPi1LoopVZhh(p2,MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,MFe2,MFu,               & 
& MFu2,Mhh,Mhh2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,cplAhhhhh,cplAhhhVZ,cplcFdFdhhL,        & 
& cplcFdFdhhR,cplcFdFdVZL,cplcFdFdVZR,cplcFeFehhL,cplcFeFehhR,cplcFeFeVZL,               & 
& cplcFeFeVZR,cplcFuFuhhL,cplcFuFuhhR,cplcFuFuVZL,cplcFuFuVZR,cplcgWCgWChh,              & 
& cplcgWCgWCVZ,cplcgWpgWphh,cplcgWpgWpVZ,cplcgXp1gXp1hh,cplcgXp1gXp1VZ,cplcgXp2gXp2hh,   & 
& cplcgXp2gXp2VZ,cplcHpmcVWpVZ,cplcHpmcVXpVZ,cplcVWpVWpVZ,cplcVXpVXpVZ,cplDpmcDpmVZ,     & 
& cplDpmhhcDpm,cplhhcHpmcVWp,cplhhcHpmcVXp,cplhhcVWpVWp,cplhhcVXpVXp,cplhhHpmcHpm,       & 
& cplhhHpmVWp,cplhhHpmVXp,cplHpmcHpmVZ,cplHpmVWpVZ,cplHpmVXpVZ,kont,res)

Implicit None 
Real(dp), Intent(in) :: MAh(3),MAh2(3),MDpm(2),MDpm2(2),MFd(5),MFd2(5),MFe(3),MFe2(3),MFu(4),MFu2(4),         & 
& Mhh(3),Mhh2(3),MHpm(4),MHpm2(4),MVWp,MVWp2,MVXp,MVXp2

Complex(dp), Intent(in) :: cplAhhhhh(3,3,3),cplAhhhVZ(3,3),cplcFdFdhhL(5,5,3),cplcFdFdhhR(5,5,3),cplcFdFdVZL(5,5),& 
& cplcFdFdVZR(5,5),cplcFeFehhL(3,3,3),cplcFeFehhR(3,3,3),cplcFeFeVZL(3,3),               & 
& cplcFeFeVZR(3,3),cplcFuFuhhL(4,4,3),cplcFuFuhhR(4,4,3),cplcFuFuVZL(4,4),               & 
& cplcFuFuVZR(4,4),cplcgWCgWChh(3),cplcgWCgWCVZ,cplcgWpgWphh(3),cplcgWpgWpVZ,            & 
& cplcgXp1gXp1hh(3),cplcgXp1gXp1VZ,cplcgXp2gXp2hh(3),cplcgXp2gXp2VZ,cplcHpmcVWpVZ(4),    & 
& cplcHpmcVXpVZ(4),cplcVWpVWpVZ,cplcVXpVXpVZ,cplDpmcDpmVZ(2,2),cplDpmhhcDpm(2,3,2),      & 
& cplhhcHpmcVWp(3,4),cplhhcHpmcVXp(3,4),cplhhcVWpVWp(3),cplhhcVXpVXp(3),cplhhHpmcHpm(3,4,4),& 
& cplhhHpmVWp(3,4),cplhhHpmVXp(3,4),cplHpmcHpmVZ(4,4),cplHpmVWpVZ(4),cplHpmVXpVZ(4)

Integer, Intent(inout) :: kont 
Real(dp) :: B0m2, F0m2, G0m2, B1m2, H0m2, B22m2, m1, m2 
Real(dp), Intent(in) :: p2 
Complex(dp) :: A0m2 
Complex(dp), Intent(inout) :: res(3) 
Complex(dp) :: coupL1, coupR1, coupL2,coupR2, coup1,coup2, coup3, temp, sumI 
Integer :: i1,i2,i3,i4, gO1, gO2, ierr 
 
 
Real(dp) ::MVG,MVP,MVG2,MVP2
MVG = Mass_Regulator_PhotonGluon 
MVP = Mass_Regulator_PhotonGluon 
MVG2 = Mass_Regulator_PhotonGluon**2 
MVP2 = Mass_Regulator_PhotonGluon**2 

res = 0._dp 
 
!------------------------ 
! hh, Ah 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 3
       Do i2 = 1, 3
 Do gO2=1,3 
B0m2 = Real(SA_DerB0(p2,MAh2(i2),Mhh2(i1)),dp) 
B1m2 = Real(SA_DerB1(p2,MAh2(i2),Mhh2(i1)),dp) 
coup1 = cplAhhhVZ(i2,i1)
coup2 = cplAhhhhh(i2,gO2,i1)
    SumI = -coup1*coup2*(B1m2+0.5_dp*B0m2)
End do 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! conj[Dpm], Dpm 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 2
       Do i2 = 1, 2
 Do gO2=1,3 
B0m2 = Real(SA_DerB0(p2,MDpm2(i2),MDpm2(i1)),dp) 
B1m2 = Real(SA_DerB1(p2,MDpm2(i2),MDpm2(i1)),dp) 
coup1 = cplDpmcDpmVZ(i2,i1)
coup2 = cplDpmhhcDpm(i1,gO2,i2)
    SumI = -coup1*coup2*(B1m2+0.5_dp*B0m2)
End do 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[Fd], Fd 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 5
       Do i2 = 1, 5
 Do gO2=1,3 
B0m2 = Real(SA_DerB0(p2,MFd2(i1),MFd2(i2)),dp) 
B1m2 = Real(SA_DerB1(p2,MFd2(i1),MFd2(i2)),dp) 
coupL1 = cplcFdFdVZL(i1,i2)
coupR1 = cplcFdFdVZR(i1,i2)
coupL2 = cplcFdFdhhL(i2,i1,gO2)
coupR2 = cplcFdFdhhR(i2,i1,gO2)
    SumI = (coupL1*coupL2+coupR1*coupR2)*MFd(i1)*(B0m2+B1m2) & 
  & + (coupL1*coupR2+coupR1*coupL2)*MFd(i2)*B1m2  
End do 
res = res +3._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[Fe], Fe 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 3
       Do i2 = 1, 3
 Do gO2=1,3 
B0m2 = Real(SA_DerB0(p2,MFe2(i1),MFe2(i2)),dp) 
B1m2 = Real(SA_DerB1(p2,MFe2(i1),MFe2(i2)),dp) 
coupL1 = cplcFeFeVZL(i1,i2)
coupR1 = cplcFeFeVZR(i1,i2)
coupL2 = cplcFeFehhL(i2,i1,gO2)
coupR2 = cplcFeFehhR(i2,i1,gO2)
    SumI = (coupL1*coupL2+coupR1*coupR2)*MFe(i1)*(B0m2+B1m2) & 
  & + (coupL1*coupR2+coupR1*coupL2)*MFe(i2)*B1m2  
End do 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[Fu], Fu 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
       Do i2 = 1, 4
 Do gO2=1,3 
B0m2 = Real(SA_DerB0(p2,MFu2(i1),MFu2(i2)),dp) 
B1m2 = Real(SA_DerB1(p2,MFu2(i1),MFu2(i2)),dp) 
coupL1 = cplcFuFuVZL(i1,i2)
coupR1 = cplcFuFuVZR(i1,i2)
coupL2 = cplcFuFuhhL(i2,i1,gO2)
coupR2 = cplcFuFuhhR(i2,i1,gO2)
    SumI = (coupL1*coupL2+coupR1*coupR2)*MFu(i1)*(B0m2+B1m2) & 
  & + (coupL1*coupR2+coupR1*coupL2)*MFu(i2)*B1m2  
End do 
res = res +3._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[gWp], gWp 
!------------------------ 
sumI = 0._dp 
 
Do gO2=1,3 
B0m2 = Real(SA_DerB0(p2,MVWp2,MVWp2),dp) 
B1m2 = Real(SA_DerB1(p2,MVWp2,MVWp2),dp) 
coup1 = cplcgWpgWpVZ
coup2 = cplcgWpgWphh(gO2) 
   SumI = -0.5_dp*coup1*coup2*(B0m2+B1m2) 
End do 
res = res +1._dp* SumI  
!------------------------ 
! bar[gWpC], gWpC 
!------------------------ 
sumI = 0._dp 
 
Do gO2=1,3 
B0m2 = Real(SA_DerB0(p2,MVWp2,MVWp2),dp) 
B1m2 = Real(SA_DerB1(p2,MVWp2,MVWp2),dp) 
coup1 = cplcgWCgWCVZ
coup2 = cplcgWCgWChh(gO2) 
   SumI = -0.5_dp*coup1*coup2*(B0m2+B1m2) 
End do 
res = res +1._dp* SumI  
!------------------------ 
! bar[gXp], gXp 
!------------------------ 
sumI = 0._dp 
 
Do gO2=1,3 
B0m2 = Real(SA_DerB0(p2,MVXp2,MVXp2),dp) 
B1m2 = Real(SA_DerB1(p2,MVXp2,MVXp2),dp) 
coup1 = cplcgXp1gXp1VZ
coup2 = cplcgXp1gXp1hh(gO2) 
   SumI = -0.5_dp*coup1*coup2*(B0m2+B1m2) 
End do 
res = res +1._dp* SumI  
!------------------------ 
! bar[gXpC], gXpC 
!------------------------ 
sumI = 0._dp 
 
Do gO2=1,3 
B0m2 = Real(SA_DerB0(p2,MVXp2,MVXp2),dp) 
B1m2 = Real(SA_DerB1(p2,MVXp2,MVXp2),dp) 
coup1 = cplcgXp2gXp2VZ
coup2 = cplcgXp2gXp2hh(gO2) 
   SumI = -0.5_dp*coup1*coup2*(B0m2+B1m2) 
End do 
res = res +1._dp* SumI  
!------------------------ 
! conj[Hpm], Hpm 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
       Do i2 = 1, 4
 Do gO2=1,3 
B0m2 = Real(SA_DerB0(p2,MHpm2(i2),MHpm2(i1)),dp) 
B1m2 = Real(SA_DerB1(p2,MHpm2(i2),MHpm2(i1)),dp) 
coup1 = cplHpmcHpmVZ(i2,i1)
coup2 = cplhhHpmcHpm(gO2,i1,i2)
    SumI = -coup1*coup2*(B1m2+0.5_dp*B0m2)
End do 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! VWp, Hpm 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 Do gO2=1,3 
B0m2 = Real(SA_DerB0(p2,MVWp2,MHpm2(i2)),dp) 
B1m2 = Real(SA_DerB1(p2,MVWp2,MHpm2(i2)),dp) 
coup1 = cplHpmVWpVZ(i2)
coup2 = cplhhcHpmcVWp(gO2,i2)
    SumI = coup1*coup2*(B1m2-B0m2) 
End do 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! VXp, Hpm 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 Do gO2=1,3 
B0m2 = Real(SA_DerB0(p2,MVXp2,MHpm2(i2)),dp) 
B1m2 = Real(SA_DerB1(p2,MVXp2,MHpm2(i2)),dp) 
coup1 = cplHpmVXpVZ(i2)
coup2 = cplhhcHpmcVXp(gO2,i2)
    SumI = coup1*coup2*(B1m2-B0m2) 
End do 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! conj[VWp], VWp 
!------------------------ 
sumI = 0._dp 
 
Do gO2=1,3 
B0m2 = Real(SA_DerB0(p2,MVWp2,MVWp2),dp)
B1m2 = Real(SA_DerB1(p2,MVWp2,MVWp2),dp) 
coup1 = cplcVWpVWpVZ
coup2 = cplhhcVWpVWp(gO2)
    SumI = coup1*coup2*(3._dp/2._dp*B0m2+3._dp*B1m2) 
End do 
res = res +1._dp* SumI  
!------------------------ 
! conj[VXp], VXp 
!------------------------ 
sumI = 0._dp 
 
Do gO2=1,3 
B0m2 = Real(SA_DerB0(p2,MVXp2,MVXp2),dp)
B1m2 = Real(SA_DerB1(p2,MVXp2,MVXp2),dp) 
coup1 = cplcVXpVXpVZ
coup2 = cplhhcVXpVXp(gO2)
    SumI = coup1*coup2*(3._dp/2._dp*B0m2+3._dp*B1m2) 
End do 
res = res +1._dp* SumI  
!------------------------ 
! conj[VWp], conj[Hpm] 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 Do gO2=1,3 
B0m2 = Real(SA_DerB0(p2,MVWp2,MHpm2(i2)),dp) 
B1m2 = Real(SA_DerB1(p2,MVWp2,MHpm2(i2)),dp) 
coup1 = cplcHpmcVWpVZ(i2)
coup2 = cplhhHpmVWp(gO2,i2)
    SumI = coup1*coup2*(B1m2-B0m2) 
End do 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! conj[VXp], conj[Hpm] 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 Do gO2=1,3 
B0m2 = Real(SA_DerB0(p2,MVXp2,MHpm2(i2)),dp) 
B1m2 = Real(SA_DerB1(p2,MVXp2,MHpm2(i2)),dp) 
coup1 = cplcHpmcVXpVZ(i2)
coup2 = cplhhHpmVXp(gO2,i2)
    SumI = coup1*coup2*(B1m2-B0m2) 
End do 
res = res +1._dp* SumI  
    End Do 
 res = oo16pi2*res 
 
End Subroutine DerPi1LoopVZhh 
 
Subroutine Pi1LoopVZAh(p2,MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,MFe2,MFu,MFu2,             & 
& Mhh,Mhh2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,cplAhAhhh,               & 
& cplAhcHpmcVWp,cplAhcHpmcVXp,cplAhDpmcDpm,cplAhhhVP,cplAhhhVZ,cplAhhhVZp,               & 
& cplAhHpmcHpm,cplAhHpmVWp,cplAhHpmVXp,cplcFdFdAhL,cplcFdFdAhR,cplcFdFdVZL,              & 
& cplcFdFdVZR,cplcFeFeAhL,cplcFeFeAhR,cplcFeFeVZL,cplcFeFeVZR,cplcFuFuAhL,               & 
& cplcFuFuAhR,cplcFuFuVZL,cplcFuFuVZR,cplcgWCgWCAh,cplcgWCgWCVZ,cplcgWpgWpAh,            & 
& cplcgWpgWpVZ,cplcgXp1gXp1Ah,cplcgXp1gXp1VZ,cplcgXp2gXp2Ah,cplcgXp2gXp2VZ,              & 
& cplcHpmcVWpVZ,cplcHpmcVXpVZ,cplDpmcDpmVZ,cplhhVPVZ,cplhhVZVZ,cplhhVZVZp,               & 
& cplHpmcHpmVZ,cplHpmVWpVZ,cplHpmVXpVZ,kont,res)

Implicit None 
Real(dp), Intent(in) :: MAh(3),MAh2(3),MDpm(2),MDpm2(2),MFd(5),MFd2(5),MFe(3),MFe2(3),MFu(4),MFu2(4),         & 
& Mhh(3),Mhh2(3),MHpm(4),MHpm2(4),MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2

Complex(dp), Intent(in) :: cplAhAhhh(3,3,3),cplAhcHpmcVWp(3,4),cplAhcHpmcVXp(3,4),cplAhDpmcDpm(3,2,2),           & 
& cplAhhhVP(3,3),cplAhhhVZ(3,3),cplAhhhVZp(3,3),cplAhHpmcHpm(3,4,4),cplAhHpmVWp(3,4),    & 
& cplAhHpmVXp(3,4),cplcFdFdAhL(5,5,3),cplcFdFdAhR(5,5,3),cplcFdFdVZL(5,5),               & 
& cplcFdFdVZR(5,5),cplcFeFeAhL(3,3,3),cplcFeFeAhR(3,3,3),cplcFeFeVZL(3,3),               & 
& cplcFeFeVZR(3,3),cplcFuFuAhL(4,4,3),cplcFuFuAhR(4,4,3),cplcFuFuVZL(4,4),               & 
& cplcFuFuVZR(4,4),cplcgWCgWCAh(3),cplcgWCgWCVZ,cplcgWpgWpAh(3),cplcgWpgWpVZ,            & 
& cplcgXp1gXp1Ah(3),cplcgXp1gXp1VZ,cplcgXp2gXp2Ah(3),cplcgXp2gXp2VZ,cplcHpmcVWpVZ(4),    & 
& cplcHpmcVXpVZ(4),cplDpmcDpmVZ(2,2),cplhhVPVZ(3),cplhhVZVZ(3),cplhhVZVZp(3),            & 
& cplHpmcHpmVZ(4,4),cplHpmVWpVZ(4),cplHpmVXpVZ(4)

Integer, Intent(inout) :: kont 
Real(dp) :: B0m2, F0m2, G0m2, B1m2, H0m2, B22m2, m1, m2 
Real(dp), Intent(in) :: p2 
Complex(dp) :: A0m2 
Complex(dp), Intent(inout) :: res(3) 
Complex(dp) :: coupL1, coupR1, coupL2,coupR2, coup1,coup2, coup3, temp, sumI 
Integer :: i1,i2,i3,i4, gO1, gO2, ierr 
 
 
res = 0._dp 
 
!------------------------ 
! hh, Ah 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 3
       Do i2 = 1, 3
 Do gO2=1,3 
B0m2 = Real(SA_B0(p2,MAh2(i2),Mhh2(i1)),dp) 
B1m2 = Real(SA_B1(p2,MAh2(i2),Mhh2(i1)),dp) 
coup1 = cplAhhhVZ(i2,i1)
coup2 = cplAhAhhh(gO2,i2,i1)
    SumI = -coup1*coup2*(B1m2+0.5_dp*B0m2)
End do 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! conj[Dpm], Dpm 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 2
       Do i2 = 1, 2
 Do gO2=1,3 
B0m2 = Real(SA_B0(p2,MDpm2(i2),MDpm2(i1)),dp) 
B1m2 = Real(SA_B1(p2,MDpm2(i2),MDpm2(i1)),dp) 
coup1 = cplDpmcDpmVZ(i2,i1)
coup2 = cplAhDpmcDpm(gO2,i1,i2)
    SumI = -coup1*coup2*(B1m2+0.5_dp*B0m2)
End do 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[Fd], Fd 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 5
       Do i2 = 1, 5
 Do gO2=1,3 
B0m2 = Real(SA_B0(p2,MFd2(i1),MFd2(i2)),dp) 
B1m2 = Real(SA_B1(p2,MFd2(i1),MFd2(i2)),dp) 
coupL1 = cplcFdFdVZL(i1,i2)
coupR1 = cplcFdFdVZR(i1,i2)
coupL2 = cplcFdFdAhL(i2,i1,gO2)
coupR2 = cplcFdFdAhR(i2,i1,gO2)
    SumI = (coupL1*coupL2+coupR1*coupR2)*MFd(i1)*(B0m2+B1m2) & 
  & + (coupL1*coupR2+coupR1*coupL2)*MFd(i2)*B1m2  
End do 
res = res +3._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[Fe], Fe 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 3
       Do i2 = 1, 3
 Do gO2=1,3 
B0m2 = Real(SA_B0(p2,MFe2(i1),MFe2(i2)),dp) 
B1m2 = Real(SA_B1(p2,MFe2(i1),MFe2(i2)),dp) 
coupL1 = cplcFeFeVZL(i1,i2)
coupR1 = cplcFeFeVZR(i1,i2)
coupL2 = cplcFeFeAhL(i2,i1,gO2)
coupR2 = cplcFeFeAhR(i2,i1,gO2)
    SumI = (coupL1*coupL2+coupR1*coupR2)*MFe(i1)*(B0m2+B1m2) & 
  & + (coupL1*coupR2+coupR1*coupL2)*MFe(i2)*B1m2  
End do 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[Fu], Fu 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
       Do i2 = 1, 4
 Do gO2=1,3 
B0m2 = Real(SA_B0(p2,MFu2(i1),MFu2(i2)),dp) 
B1m2 = Real(SA_B1(p2,MFu2(i1),MFu2(i2)),dp) 
coupL1 = cplcFuFuVZL(i1,i2)
coupR1 = cplcFuFuVZR(i1,i2)
coupL2 = cplcFuFuAhL(i2,i1,gO2)
coupR2 = cplcFuFuAhR(i2,i1,gO2)
    SumI = (coupL1*coupL2+coupR1*coupR2)*MFu(i1)*(B0m2+B1m2) & 
  & + (coupL1*coupR2+coupR1*coupL2)*MFu(i2)*B1m2  
End do 
res = res +3._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[gWp], gWp 
!------------------------ 
sumI = 0._dp 
 
Do gO2=1,3 
B0m2 = Real(SA_B0(p2,MVWp2,MVWp2),dp) 
B1m2 = Real(SA_B1(p2,MVWp2,MVWp2),dp) 
coup1 = cplcgWpgWpVZ
coup2 = cplcgWpgWpAh(gO2) 
   SumI = -0.5_dp*coup1*coup2*(B0m2+B1m2) 
End do 
res = res +1._dp* SumI  
!------------------------ 
! bar[gWpC], gWpC 
!------------------------ 
sumI = 0._dp 
 
Do gO2=1,3 
B0m2 = Real(SA_B0(p2,MVWp2,MVWp2),dp) 
B1m2 = Real(SA_B1(p2,MVWp2,MVWp2),dp) 
coup1 = cplcgWCgWCVZ
coup2 = cplcgWCgWCAh(gO2) 
   SumI = -0.5_dp*coup1*coup2*(B0m2+B1m2) 
End do 
res = res +1._dp* SumI  
!------------------------ 
! bar[gXp], gXp 
!------------------------ 
sumI = 0._dp 
 
Do gO2=1,3 
B0m2 = Real(SA_B0(p2,MVXp2,MVXp2),dp) 
B1m2 = Real(SA_B1(p2,MVXp2,MVXp2),dp) 
coup1 = cplcgXp1gXp1VZ
coup2 = cplcgXp1gXp1Ah(gO2) 
   SumI = -0.5_dp*coup1*coup2*(B0m2+B1m2) 
End do 
res = res +1._dp* SumI  
!------------------------ 
! bar[gXpC], gXpC 
!------------------------ 
sumI = 0._dp 
 
Do gO2=1,3 
B0m2 = Real(SA_B0(p2,MVXp2,MVXp2),dp) 
B1m2 = Real(SA_B1(p2,MVXp2,MVXp2),dp) 
coup1 = cplcgXp2gXp2VZ
coup2 = cplcgXp2gXp2Ah(gO2) 
   SumI = -0.5_dp*coup1*coup2*(B0m2+B1m2) 
End do 
res = res +1._dp* SumI  
!------------------------ 
! VP, hh 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 3
 Do gO2=1,3 
B0m2 = Real(SA_B0(p2,0._dp,Mhh2(i2)),dp) 
B1m2 = Real(SA_B1(p2,0._dp,Mhh2(i2)),dp) 
coup1 = cplhhVPVZ(i2)
coup2 = cplAhhhVP(gO2,i2)
    SumI = coup1*coup2*(B1m2-B0m2) 
End do 
res = res +0.5_dp* SumI  
    End Do 
 !------------------------ 
! VZ, hh 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 3
 Do gO2=1,3 
B0m2 = Real(SA_B0(p2,MVZ2,Mhh2(i2)),dp) 
B1m2 = Real(SA_B1(p2,MVZ2,Mhh2(i2)),dp) 
coup1 = cplhhVZVZ(i2)
coup2 = cplAhhhVZ(gO2,i2)
    SumI = coup1*coup2*(B1m2-B0m2) 
End do 
res = res +0.5_dp* SumI  
    End Do 
 !------------------------ 
! VZp, hh 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 3
 Do gO2=1,3 
B0m2 = Real(SA_B0(p2,MVZp2,Mhh2(i2)),dp) 
B1m2 = Real(SA_B1(p2,MVZp2,Mhh2(i2)),dp) 
coup1 = cplhhVZVZp(i2)
coup2 = cplAhhhVZp(gO2,i2)
    SumI = coup1*coup2*(B1m2-B0m2) 
End do 
res = res +0.5_dp* SumI  
    End Do 
 !------------------------ 
! conj[Hpm], Hpm 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
       Do i2 = 1, 4
 Do gO2=1,3 
B0m2 = Real(SA_B0(p2,MHpm2(i2),MHpm2(i1)),dp) 
B1m2 = Real(SA_B1(p2,MHpm2(i2),MHpm2(i1)),dp) 
coup1 = cplHpmcHpmVZ(i2,i1)
coup2 = cplAhHpmcHpm(gO2,i1,i2)
    SumI = -coup1*coup2*(B1m2+0.5_dp*B0m2)
End do 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! VWp, Hpm 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 Do gO2=1,3 
B0m2 = Real(SA_B0(p2,MVWp2,MHpm2(i2)),dp) 
B1m2 = Real(SA_B1(p2,MVWp2,MHpm2(i2)),dp) 
coup1 = cplHpmVWpVZ(i2)
coup2 = cplAhcHpmcVWp(gO2,i2)
    SumI = coup1*coup2*(B1m2-B0m2) 
End do 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! VXp, Hpm 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 Do gO2=1,3 
B0m2 = Real(SA_B0(p2,MVXp2,MHpm2(i2)),dp) 
B1m2 = Real(SA_B1(p2,MVXp2,MHpm2(i2)),dp) 
coup1 = cplHpmVXpVZ(i2)
coup2 = cplAhcHpmcVXp(gO2,i2)
    SumI = coup1*coup2*(B1m2-B0m2) 
End do 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! conj[VWp], conj[Hpm] 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 Do gO2=1,3 
B0m2 = Real(SA_B0(p2,MVWp2,MHpm2(i2)),dp) 
B1m2 = Real(SA_B1(p2,MVWp2,MHpm2(i2)),dp) 
coup1 = cplcHpmcVWpVZ(i2)
coup2 = cplAhHpmVWp(gO2,i2)
    SumI = coup1*coup2*(B1m2-B0m2) 
End do 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! conj[VXp], conj[Hpm] 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 Do gO2=1,3 
B0m2 = Real(SA_B0(p2,MVXp2,MHpm2(i2)),dp) 
B1m2 = Real(SA_B1(p2,MVXp2,MHpm2(i2)),dp) 
coup1 = cplcHpmcVXpVZ(i2)
coup2 = cplAhHpmVXp(gO2,i2)
    SumI = coup1*coup2*(B1m2-B0m2) 
End do 
res = res +1._dp* SumI  
    End Do 
 res = oo16pi2*res 
 
End Subroutine Pi1LoopVZAh 
 
Subroutine DerPi1LoopVZAh(p2,MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,MFe2,MFu,               & 
& MFu2,Mhh,Mhh2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,cplAhAhhh,          & 
& cplAhcHpmcVWp,cplAhcHpmcVXp,cplAhDpmcDpm,cplAhhhVP,cplAhhhVZ,cplAhhhVZp,               & 
& cplAhHpmcHpm,cplAhHpmVWp,cplAhHpmVXp,cplcFdFdAhL,cplcFdFdAhR,cplcFdFdVZL,              & 
& cplcFdFdVZR,cplcFeFeAhL,cplcFeFeAhR,cplcFeFeVZL,cplcFeFeVZR,cplcFuFuAhL,               & 
& cplcFuFuAhR,cplcFuFuVZL,cplcFuFuVZR,cplcgWCgWCAh,cplcgWCgWCVZ,cplcgWpgWpAh,            & 
& cplcgWpgWpVZ,cplcgXp1gXp1Ah,cplcgXp1gXp1VZ,cplcgXp2gXp2Ah,cplcgXp2gXp2VZ,              & 
& cplcHpmcVWpVZ,cplcHpmcVXpVZ,cplDpmcDpmVZ,cplhhVPVZ,cplhhVZVZ,cplhhVZVZp,               & 
& cplHpmcHpmVZ,cplHpmVWpVZ,cplHpmVXpVZ,kont,res)

Implicit None 
Real(dp), Intent(in) :: MAh(3),MAh2(3),MDpm(2),MDpm2(2),MFd(5),MFd2(5),MFe(3),MFe2(3),MFu(4),MFu2(4),         & 
& Mhh(3),Mhh2(3),MHpm(4),MHpm2(4),MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2

Complex(dp), Intent(in) :: cplAhAhhh(3,3,3),cplAhcHpmcVWp(3,4),cplAhcHpmcVXp(3,4),cplAhDpmcDpm(3,2,2),           & 
& cplAhhhVP(3,3),cplAhhhVZ(3,3),cplAhhhVZp(3,3),cplAhHpmcHpm(3,4,4),cplAhHpmVWp(3,4),    & 
& cplAhHpmVXp(3,4),cplcFdFdAhL(5,5,3),cplcFdFdAhR(5,5,3),cplcFdFdVZL(5,5),               & 
& cplcFdFdVZR(5,5),cplcFeFeAhL(3,3,3),cplcFeFeAhR(3,3,3),cplcFeFeVZL(3,3),               & 
& cplcFeFeVZR(3,3),cplcFuFuAhL(4,4,3),cplcFuFuAhR(4,4,3),cplcFuFuVZL(4,4),               & 
& cplcFuFuVZR(4,4),cplcgWCgWCAh(3),cplcgWCgWCVZ,cplcgWpgWpAh(3),cplcgWpgWpVZ,            & 
& cplcgXp1gXp1Ah(3),cplcgXp1gXp1VZ,cplcgXp2gXp2Ah(3),cplcgXp2gXp2VZ,cplcHpmcVWpVZ(4),    & 
& cplcHpmcVXpVZ(4),cplDpmcDpmVZ(2,2),cplhhVPVZ(3),cplhhVZVZ(3),cplhhVZVZp(3),            & 
& cplHpmcHpmVZ(4,4),cplHpmVWpVZ(4),cplHpmVXpVZ(4)

Integer, Intent(inout) :: kont 
Real(dp) :: B0m2, F0m2, G0m2, B1m2, H0m2, B22m2, m1, m2 
Real(dp), Intent(in) :: p2 
Complex(dp) :: A0m2 
Complex(dp), Intent(inout) :: res(3) 
Complex(dp) :: coupL1, coupR1, coupL2,coupR2, coup1,coup2, coup3, temp, sumI 
Integer :: i1,i2,i3,i4, gO1, gO2, ierr 
 
 
Real(dp) ::MVG,MVP,MVG2,MVP2
MVG = Mass_Regulator_PhotonGluon 
MVP = Mass_Regulator_PhotonGluon 
MVG2 = Mass_Regulator_PhotonGluon**2 
MVP2 = Mass_Regulator_PhotonGluon**2 

res = 0._dp 
 
!------------------------ 
! hh, Ah 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 3
       Do i2 = 1, 3
 Do gO2=1,3 
B0m2 = Real(SA_DerB0(p2,MAh2(i2),Mhh2(i1)),dp) 
B1m2 = Real(SA_DerB1(p2,MAh2(i2),Mhh2(i1)),dp) 
coup1 = cplAhhhVZ(i2,i1)
coup2 = cplAhAhhh(gO2,i2,i1)
    SumI = -coup1*coup2*(B1m2+0.5_dp*B0m2)
End do 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! conj[Dpm], Dpm 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 2
       Do i2 = 1, 2
 Do gO2=1,3 
B0m2 = Real(SA_DerB0(p2,MDpm2(i2),MDpm2(i1)),dp) 
B1m2 = Real(SA_DerB1(p2,MDpm2(i2),MDpm2(i1)),dp) 
coup1 = cplDpmcDpmVZ(i2,i1)
coup2 = cplAhDpmcDpm(gO2,i1,i2)
    SumI = -coup1*coup2*(B1m2+0.5_dp*B0m2)
End do 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[Fd], Fd 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 5
       Do i2 = 1, 5
 Do gO2=1,3 
B0m2 = Real(SA_DerB0(p2,MFd2(i1),MFd2(i2)),dp) 
B1m2 = Real(SA_DerB1(p2,MFd2(i1),MFd2(i2)),dp) 
coupL1 = cplcFdFdVZL(i1,i2)
coupR1 = cplcFdFdVZR(i1,i2)
coupL2 = cplcFdFdAhL(i2,i1,gO2)
coupR2 = cplcFdFdAhR(i2,i1,gO2)
    SumI = (coupL1*coupL2+coupR1*coupR2)*MFd(i1)*(B0m2+B1m2) & 
  & + (coupL1*coupR2+coupR1*coupL2)*MFd(i2)*B1m2  
End do 
res = res +3._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[Fe], Fe 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 3
       Do i2 = 1, 3
 Do gO2=1,3 
B0m2 = Real(SA_DerB0(p2,MFe2(i1),MFe2(i2)),dp) 
B1m2 = Real(SA_DerB1(p2,MFe2(i1),MFe2(i2)),dp) 
coupL1 = cplcFeFeVZL(i1,i2)
coupR1 = cplcFeFeVZR(i1,i2)
coupL2 = cplcFeFeAhL(i2,i1,gO2)
coupR2 = cplcFeFeAhR(i2,i1,gO2)
    SumI = (coupL1*coupL2+coupR1*coupR2)*MFe(i1)*(B0m2+B1m2) & 
  & + (coupL1*coupR2+coupR1*coupL2)*MFe(i2)*B1m2  
End do 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[Fu], Fu 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
       Do i2 = 1, 4
 Do gO2=1,3 
B0m2 = Real(SA_DerB0(p2,MFu2(i1),MFu2(i2)),dp) 
B1m2 = Real(SA_DerB1(p2,MFu2(i1),MFu2(i2)),dp) 
coupL1 = cplcFuFuVZL(i1,i2)
coupR1 = cplcFuFuVZR(i1,i2)
coupL2 = cplcFuFuAhL(i2,i1,gO2)
coupR2 = cplcFuFuAhR(i2,i1,gO2)
    SumI = (coupL1*coupL2+coupR1*coupR2)*MFu(i1)*(B0m2+B1m2) & 
  & + (coupL1*coupR2+coupR1*coupL2)*MFu(i2)*B1m2  
End do 
res = res +3._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[gWp], gWp 
!------------------------ 
sumI = 0._dp 
 
Do gO2=1,3 
B0m2 = Real(SA_DerB0(p2,MVWp2,MVWp2),dp) 
B1m2 = Real(SA_DerB1(p2,MVWp2,MVWp2),dp) 
coup1 = cplcgWpgWpVZ
coup2 = cplcgWpgWpAh(gO2) 
   SumI = -0.5_dp*coup1*coup2*(B0m2+B1m2) 
End do 
res = res +1._dp* SumI  
!------------------------ 
! bar[gWpC], gWpC 
!------------------------ 
sumI = 0._dp 
 
Do gO2=1,3 
B0m2 = Real(SA_DerB0(p2,MVWp2,MVWp2),dp) 
B1m2 = Real(SA_DerB1(p2,MVWp2,MVWp2),dp) 
coup1 = cplcgWCgWCVZ
coup2 = cplcgWCgWCAh(gO2) 
   SumI = -0.5_dp*coup1*coup2*(B0m2+B1m2) 
End do 
res = res +1._dp* SumI  
!------------------------ 
! bar[gXp], gXp 
!------------------------ 
sumI = 0._dp 
 
Do gO2=1,3 
B0m2 = Real(SA_DerB0(p2,MVXp2,MVXp2),dp) 
B1m2 = Real(SA_DerB1(p2,MVXp2,MVXp2),dp) 
coup1 = cplcgXp1gXp1VZ
coup2 = cplcgXp1gXp1Ah(gO2) 
   SumI = -0.5_dp*coup1*coup2*(B0m2+B1m2) 
End do 
res = res +1._dp* SumI  
!------------------------ 
! bar[gXpC], gXpC 
!------------------------ 
sumI = 0._dp 
 
Do gO2=1,3 
B0m2 = Real(SA_DerB0(p2,MVXp2,MVXp2),dp) 
B1m2 = Real(SA_DerB1(p2,MVXp2,MVXp2),dp) 
coup1 = cplcgXp2gXp2VZ
coup2 = cplcgXp2gXp2Ah(gO2) 
   SumI = -0.5_dp*coup1*coup2*(B0m2+B1m2) 
End do 
res = res +1._dp* SumI  
!------------------------ 
! VP, hh 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 3
 Do gO2=1,3 
B0m2 = Real(SA_DerB0(p2,MVP2,Mhh2(i2)),dp) 
B1m2 = Real(SA_DerB1(p2,MVP2,Mhh2(i2)),dp) 
coup1 = cplhhVPVZ(i2)
coup2 = cplAhhhVP(gO2,i2)
    SumI = coup1*coup2*(B1m2-B0m2) 
End do 
res = res +0.5_dp* SumI  
    End Do 
 !------------------------ 
! VZ, hh 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 3
 Do gO2=1,3 
B0m2 = Real(SA_DerB0(p2,MVZ2,Mhh2(i2)),dp) 
B1m2 = Real(SA_DerB1(p2,MVZ2,Mhh2(i2)),dp) 
coup1 = cplhhVZVZ(i2)
coup2 = cplAhhhVZ(gO2,i2)
    SumI = coup1*coup2*(B1m2-B0m2) 
End do 
res = res +0.5_dp* SumI  
    End Do 
 !------------------------ 
! VZp, hh 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 3
 Do gO2=1,3 
B0m2 = Real(SA_DerB0(p2,MVZp2,Mhh2(i2)),dp) 
B1m2 = Real(SA_DerB1(p2,MVZp2,Mhh2(i2)),dp) 
coup1 = cplhhVZVZp(i2)
coup2 = cplAhhhVZp(gO2,i2)
    SumI = coup1*coup2*(B1m2-B0m2) 
End do 
res = res +0.5_dp* SumI  
    End Do 
 !------------------------ 
! conj[Hpm], Hpm 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
       Do i2 = 1, 4
 Do gO2=1,3 
B0m2 = Real(SA_DerB0(p2,MHpm2(i2),MHpm2(i1)),dp) 
B1m2 = Real(SA_DerB1(p2,MHpm2(i2),MHpm2(i1)),dp) 
coup1 = cplHpmcHpmVZ(i2,i1)
coup2 = cplAhHpmcHpm(gO2,i1,i2)
    SumI = -coup1*coup2*(B1m2+0.5_dp*B0m2)
End do 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! VWp, Hpm 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 Do gO2=1,3 
B0m2 = Real(SA_DerB0(p2,MVWp2,MHpm2(i2)),dp) 
B1m2 = Real(SA_DerB1(p2,MVWp2,MHpm2(i2)),dp) 
coup1 = cplHpmVWpVZ(i2)
coup2 = cplAhcHpmcVWp(gO2,i2)
    SumI = coup1*coup2*(B1m2-B0m2) 
End do 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! VXp, Hpm 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 Do gO2=1,3 
B0m2 = Real(SA_DerB0(p2,MVXp2,MHpm2(i2)),dp) 
B1m2 = Real(SA_DerB1(p2,MVXp2,MHpm2(i2)),dp) 
coup1 = cplHpmVXpVZ(i2)
coup2 = cplAhcHpmcVXp(gO2,i2)
    SumI = coup1*coup2*(B1m2-B0m2) 
End do 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! conj[VWp], conj[Hpm] 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 Do gO2=1,3 
B0m2 = Real(SA_DerB0(p2,MVWp2,MHpm2(i2)),dp) 
B1m2 = Real(SA_DerB1(p2,MVWp2,MHpm2(i2)),dp) 
coup1 = cplcHpmcVWpVZ(i2)
coup2 = cplAhHpmVWp(gO2,i2)
    SumI = coup1*coup2*(B1m2-B0m2) 
End do 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! conj[VXp], conj[Hpm] 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 Do gO2=1,3 
B0m2 = Real(SA_DerB0(p2,MVXp2,MHpm2(i2)),dp) 
B1m2 = Real(SA_DerB1(p2,MVXp2,MHpm2(i2)),dp) 
coup1 = cplcHpmcVXpVZ(i2)
coup2 = cplAhHpmVXp(gO2,i2)
    SumI = coup1*coup2*(B1m2-B0m2) 
End do 
res = res +1._dp* SumI  
    End Do 
 res = oo16pi2*res 
 
End Subroutine DerPi1LoopVZAh 
 
Subroutine Pi1LoopVZDpm(p2,MFd,MFd2,MFu,MFu2,MHpm,MHpm2,MVWp,MVWp2,MVXp,              & 
& MVXp2,cplcDpmcHpmcVXp,cplcFdFdcDpmL,cplcFdFdcDpmR,cplcFdFdVZL,cplcFdFdVZR,             & 
& cplcFuFucDpmL,cplcFuFucDpmR,cplcFuFuVZL,cplcFuFuVZR,cplcHpmcVWpVZ,cplHpmcDpmcHpm,      & 
& cplHpmcDpmVWp,cplHpmcHpmVZ,cplHpmVXpVZ,kont,res)

Implicit None 
Real(dp), Intent(in) :: MFd(5),MFd2(5),MFu(4),MFu2(4),MHpm(4),MHpm2(4),MVWp,MVWp2,MVXp,MVXp2

Complex(dp), Intent(in) :: cplcDpmcHpmcVXp(2,4),cplcFdFdcDpmL(5,5,2),cplcFdFdcDpmR(5,5,2),cplcFdFdVZL(5,5),      & 
& cplcFdFdVZR(5,5),cplcFuFucDpmL(4,4,2),cplcFuFucDpmR(4,4,2),cplcFuFuVZL(4,4),           & 
& cplcFuFuVZR(4,4),cplcHpmcVWpVZ(4),cplHpmcDpmcHpm(4,2,4),cplHpmcDpmVWp(4,2),            & 
& cplHpmcHpmVZ(4,4),cplHpmVXpVZ(4)

Integer, Intent(inout) :: kont 
Real(dp) :: B0m2, F0m2, G0m2, B1m2, H0m2, B22m2, m1, m2 
Real(dp), Intent(in) :: p2 
Complex(dp) :: A0m2 
Complex(dp), Intent(inout) :: res(2) 
Complex(dp) :: coupL1, coupR1, coupL2,coupR2, coup1,coup2, coup3, temp, sumI 
Integer :: i1,i2,i3,i4, gO1, gO2, ierr 
 
 
res = 0._dp 
 
!------------------------ 
! bar[Fd], Fd 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 5
       Do i2 = 1, 5
 Do gO2=1,2 
B0m2 = Real(SA_B0(p2,MFd2(i1),MFd2(i2)),dp) 
B1m2 = Real(SA_B1(p2,MFd2(i1),MFd2(i2)),dp) 
coupL1 = cplcFdFdVZL(i1,i2)
coupR1 = cplcFdFdVZR(i1,i2)
coupL2 = cplcFdFdcDpmL(i2,i1,gO2)
coupR2 = cplcFdFdcDpmR(i2,i1,gO2)
    SumI = (coupL1*coupL2+coupR1*coupR2)*MFd(i1)*(B0m2+B1m2) & 
  & + (coupL1*coupR2+coupR1*coupL2)*MFd(i2)*B1m2  
End do 
res = res +1.5_dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[Fu], Fu 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
       Do i2 = 1, 4
 Do gO2=1,2 
B0m2 = Real(SA_B0(p2,MFu2(i1),MFu2(i2)),dp) 
B1m2 = Real(SA_B1(p2,MFu2(i1),MFu2(i2)),dp) 
coupL1 = cplcFuFuVZL(i1,i2)
coupR1 = cplcFuFuVZR(i1,i2)
coupL2 = cplcFuFucDpmL(i2,i1,gO2)
coupR2 = cplcFuFucDpmR(i2,i1,gO2)
    SumI = (coupL1*coupL2+coupR1*coupR2)*MFu(i1)*(B0m2+B1m2) & 
  & + (coupL1*coupR2+coupR1*coupL2)*MFu(i2)*B1m2  
End do 
res = res +1.5_dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! conj[Hpm], Hpm 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
       Do i2 = 1, 4
 Do gO2=1,2 
B0m2 = Real(SA_B0(p2,MHpm2(i2),MHpm2(i1)),dp) 
B1m2 = Real(SA_B1(p2,MHpm2(i2),MHpm2(i1)),dp) 
coup1 = cplHpmcHpmVZ(i2,i1)
coup2 = cplHpmcDpmcHpm(i1,gO2,i2)
    SumI = -coup1*coup2*(B1m2+0.5_dp*B0m2)
End do 
res = res +0.5_dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! VXp, Hpm 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 Do gO2=1,2 
B0m2 = Real(SA_B0(p2,MVXp2,MHpm2(i2)),dp) 
B1m2 = Real(SA_B1(p2,MVXp2,MHpm2(i2)),dp) 
coup1 = cplHpmVXpVZ(i2)
coup2 = cplcDpmcHpmcVXp(gO2,i2)
    SumI = coup1*coup2*(B1m2-B0m2) 
End do 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! conj[VWp], conj[Hpm] 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 Do gO2=1,2 
B0m2 = Real(SA_B0(p2,MVWp2,MHpm2(i2)),dp) 
B1m2 = Real(SA_B1(p2,MVWp2,MHpm2(i2)),dp) 
coup1 = cplcHpmcVWpVZ(i2)
coup2 = cplHpmcDpmVWp(i2,gO2)
    SumI = coup1*coup2*(B1m2-B0m2) 
End do 
res = res +1._dp* SumI  
    End Do 
 res = oo16pi2*res 
 
End Subroutine Pi1LoopVZDpm 
 
Subroutine DerPi1LoopVZDpm(p2,MFd,MFd2,MFu,MFu2,MHpm,MHpm2,MVWp,MVWp2,MVXp,           & 
& MVXp2,cplcDpmcHpmcVXp,cplcFdFdcDpmL,cplcFdFdcDpmR,cplcFdFdVZL,cplcFdFdVZR,             & 
& cplcFuFucDpmL,cplcFuFucDpmR,cplcFuFuVZL,cplcFuFuVZR,cplcHpmcVWpVZ,cplHpmcDpmcHpm,      & 
& cplHpmcDpmVWp,cplHpmcHpmVZ,cplHpmVXpVZ,kont,res)

Implicit None 
Real(dp), Intent(in) :: MFd(5),MFd2(5),MFu(4),MFu2(4),MHpm(4),MHpm2(4),MVWp,MVWp2,MVXp,MVXp2

Complex(dp), Intent(in) :: cplcDpmcHpmcVXp(2,4),cplcFdFdcDpmL(5,5,2),cplcFdFdcDpmR(5,5,2),cplcFdFdVZL(5,5),      & 
& cplcFdFdVZR(5,5),cplcFuFucDpmL(4,4,2),cplcFuFucDpmR(4,4,2),cplcFuFuVZL(4,4),           & 
& cplcFuFuVZR(4,4),cplcHpmcVWpVZ(4),cplHpmcDpmcHpm(4,2,4),cplHpmcDpmVWp(4,2),            & 
& cplHpmcHpmVZ(4,4),cplHpmVXpVZ(4)

Integer, Intent(inout) :: kont 
Real(dp) :: B0m2, F0m2, G0m2, B1m2, H0m2, B22m2, m1, m2 
Real(dp), Intent(in) :: p2 
Complex(dp) :: A0m2 
Complex(dp), Intent(inout) :: res(2) 
Complex(dp) :: coupL1, coupR1, coupL2,coupR2, coup1,coup2, coup3, temp, sumI 
Integer :: i1,i2,i3,i4, gO1, gO2, ierr 
 
 
Real(dp) ::MVG,MVP,MVG2,MVP2
MVG = Mass_Regulator_PhotonGluon 
MVP = Mass_Regulator_PhotonGluon 
MVG2 = Mass_Regulator_PhotonGluon**2 
MVP2 = Mass_Regulator_PhotonGluon**2 

res = 0._dp 
 
!------------------------ 
! bar[Fd], Fd 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 5
       Do i2 = 1, 5
 Do gO2=1,2 
B0m2 = Real(SA_DerB0(p2,MFd2(i1),MFd2(i2)),dp) 
B1m2 = Real(SA_DerB1(p2,MFd2(i1),MFd2(i2)),dp) 
coupL1 = cplcFdFdVZL(i1,i2)
coupR1 = cplcFdFdVZR(i1,i2)
coupL2 = cplcFdFdcDpmL(i2,i1,gO2)
coupR2 = cplcFdFdcDpmR(i2,i1,gO2)
    SumI = (coupL1*coupL2+coupR1*coupR2)*MFd(i1)*(B0m2+B1m2) & 
  & + (coupL1*coupR2+coupR1*coupL2)*MFd(i2)*B1m2  
End do 
res = res +1.5_dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[Fu], Fu 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
       Do i2 = 1, 4
 Do gO2=1,2 
B0m2 = Real(SA_DerB0(p2,MFu2(i1),MFu2(i2)),dp) 
B1m2 = Real(SA_DerB1(p2,MFu2(i1),MFu2(i2)),dp) 
coupL1 = cplcFuFuVZL(i1,i2)
coupR1 = cplcFuFuVZR(i1,i2)
coupL2 = cplcFuFucDpmL(i2,i1,gO2)
coupR2 = cplcFuFucDpmR(i2,i1,gO2)
    SumI = (coupL1*coupL2+coupR1*coupR2)*MFu(i1)*(B0m2+B1m2) & 
  & + (coupL1*coupR2+coupR1*coupL2)*MFu(i2)*B1m2  
End do 
res = res +1.5_dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! conj[Hpm], Hpm 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
       Do i2 = 1, 4
 Do gO2=1,2 
B0m2 = Real(SA_DerB0(p2,MHpm2(i2),MHpm2(i1)),dp) 
B1m2 = Real(SA_DerB1(p2,MHpm2(i2),MHpm2(i1)),dp) 
coup1 = cplHpmcHpmVZ(i2,i1)
coup2 = cplHpmcDpmcHpm(i1,gO2,i2)
    SumI = -coup1*coup2*(B1m2+0.5_dp*B0m2)
End do 
res = res +0.5_dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! VXp, Hpm 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 Do gO2=1,2 
B0m2 = Real(SA_DerB0(p2,MVXp2,MHpm2(i2)),dp) 
B1m2 = Real(SA_DerB1(p2,MVXp2,MHpm2(i2)),dp) 
coup1 = cplHpmVXpVZ(i2)
coup2 = cplcDpmcHpmcVXp(gO2,i2)
    SumI = coup1*coup2*(B1m2-B0m2) 
End do 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! conj[VWp], conj[Hpm] 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 Do gO2=1,2 
B0m2 = Real(SA_DerB0(p2,MVWp2,MHpm2(i2)),dp) 
B1m2 = Real(SA_DerB1(p2,MVWp2,MHpm2(i2)),dp) 
coup1 = cplcHpmcVWpVZ(i2)
coup2 = cplHpmcDpmVWp(i2,gO2)
    SumI = coup1*coup2*(B1m2-B0m2) 
End do 
res = res +1._dp* SumI  
    End Do 
 res = oo16pi2*res 
 
End Subroutine DerPi1LoopVZDpm 
 
Subroutine Pi1LoopVZphh(p2,MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,MFe2,MFu,MFu2,            & 
& Mhh,Mhh2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,cplAhhhhh,cplAhhhVZp,cplcFdFdhhL,            & 
& cplcFdFdhhR,cplcFdFdVZpL,cplcFdFdVZpR,cplcFeFehhL,cplcFeFehhR,cplcFeFeVZpL,            & 
& cplcFeFeVZpR,cplcFuFuhhL,cplcFuFuhhR,cplcFuFuVZpL,cplcFuFuVZpR,cplcgWCgWChh,           & 
& cplcgWCgWCVZp,cplcgWpgWphh,cplcgWpgWpVZp,cplcgXp1gXp1hh,cplcgXp1gXp1VZp,               & 
& cplcgXp2gXp2hh,cplcgXp2gXp2VZp,cplcHpmcVWpVZp,cplcHpmcVXpVZp,cplcVWpVWpVZp,            & 
& cplcVXpVXpVZp,cplDpmcDpmVZp,cplDpmhhcDpm,cplhhcHpmcVWp,cplhhcHpmcVXp,cplhhcVWpVWp,     & 
& cplhhcVXpVXp,cplhhHpmcHpm,cplhhHpmVWp,cplhhHpmVXp,cplHpmcHpmVZp,cplHpmVWpVZp,          & 
& cplHpmVXpVZp,kont,res)

Implicit None 
Real(dp), Intent(in) :: MAh(3),MAh2(3),MDpm(2),MDpm2(2),MFd(5),MFd2(5),MFe(3),MFe2(3),MFu(4),MFu2(4),         & 
& Mhh(3),Mhh2(3),MHpm(4),MHpm2(4),MVWp,MVWp2,MVXp,MVXp2

Complex(dp), Intent(in) :: cplAhhhhh(3,3,3),cplAhhhVZp(3,3),cplcFdFdhhL(5,5,3),cplcFdFdhhR(5,5,3),               & 
& cplcFdFdVZpL(5,5),cplcFdFdVZpR(5,5),cplcFeFehhL(3,3,3),cplcFeFehhR(3,3,3),             & 
& cplcFeFeVZpL(3,3),cplcFeFeVZpR(3,3),cplcFuFuhhL(4,4,3),cplcFuFuhhR(4,4,3),             & 
& cplcFuFuVZpL(4,4),cplcFuFuVZpR(4,4),cplcgWCgWChh(3),cplcgWCgWCVZp,cplcgWpgWphh(3),     & 
& cplcgWpgWpVZp,cplcgXp1gXp1hh(3),cplcgXp1gXp1VZp,cplcgXp2gXp2hh(3),cplcgXp2gXp2VZp,     & 
& cplcHpmcVWpVZp(4),cplcHpmcVXpVZp(4),cplcVWpVWpVZp,cplcVXpVXpVZp,cplDpmcDpmVZp(2,2),    & 
& cplDpmhhcDpm(2,3,2),cplhhcHpmcVWp(3,4),cplhhcHpmcVXp(3,4),cplhhcVWpVWp(3),             & 
& cplhhcVXpVXp(3),cplhhHpmcHpm(3,4,4),cplhhHpmVWp(3,4),cplhhHpmVXp(3,4),cplHpmcHpmVZp(4,4),& 
& cplHpmVWpVZp(4),cplHpmVXpVZp(4)

Integer, Intent(inout) :: kont 
Real(dp) :: B0m2, F0m2, G0m2, B1m2, H0m2, B22m2, m1, m2 
Real(dp), Intent(in) :: p2 
Complex(dp) :: A0m2 
Complex(dp), Intent(inout) :: res(3) 
Complex(dp) :: coupL1, coupR1, coupL2,coupR2, coup1,coup2, coup3, temp, sumI 
Integer :: i1,i2,i3,i4, gO1, gO2, ierr 
 
 
res = 0._dp 
 
!------------------------ 
! hh, Ah 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 3
       Do i2 = 1, 3
 Do gO2=1,3 
B0m2 = Real(SA_B0(p2,MAh2(i2),Mhh2(i1)),dp) 
B1m2 = Real(SA_B1(p2,MAh2(i2),Mhh2(i1)),dp) 
coup1 = cplAhhhVZp(i2,i1)
coup2 = cplAhhhhh(i2,gO2,i1)
    SumI = -coup1*coup2*(B1m2+0.5_dp*B0m2)
End do 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! conj[Dpm], Dpm 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 2
       Do i2 = 1, 2
 Do gO2=1,3 
B0m2 = Real(SA_B0(p2,MDpm2(i2),MDpm2(i1)),dp) 
B1m2 = Real(SA_B1(p2,MDpm2(i2),MDpm2(i1)),dp) 
coup1 = cplDpmcDpmVZp(i2,i1)
coup2 = cplDpmhhcDpm(i1,gO2,i2)
    SumI = -coup1*coup2*(B1m2+0.5_dp*B0m2)
End do 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[Fd], Fd 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 5
       Do i2 = 1, 5
 Do gO2=1,3 
B0m2 = Real(SA_B0(p2,MFd2(i1),MFd2(i2)),dp) 
B1m2 = Real(SA_B1(p2,MFd2(i1),MFd2(i2)),dp) 
coupL1 = cplcFdFdVZpL(i1,i2)
coupR1 = cplcFdFdVZpR(i1,i2)
coupL2 = cplcFdFdhhL(i2,i1,gO2)
coupR2 = cplcFdFdhhR(i2,i1,gO2)
    SumI = (coupL1*coupL2+coupR1*coupR2)*MFd(i1)*(B0m2+B1m2) & 
  & + (coupL1*coupR2+coupR1*coupL2)*MFd(i2)*B1m2  
End do 
res = res +3._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[Fe], Fe 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 3
       Do i2 = 1, 3
 Do gO2=1,3 
B0m2 = Real(SA_B0(p2,MFe2(i1),MFe2(i2)),dp) 
B1m2 = Real(SA_B1(p2,MFe2(i1),MFe2(i2)),dp) 
coupL1 = cplcFeFeVZpL(i1,i2)
coupR1 = cplcFeFeVZpR(i1,i2)
coupL2 = cplcFeFehhL(i2,i1,gO2)
coupR2 = cplcFeFehhR(i2,i1,gO2)
    SumI = (coupL1*coupL2+coupR1*coupR2)*MFe(i1)*(B0m2+B1m2) & 
  & + (coupL1*coupR2+coupR1*coupL2)*MFe(i2)*B1m2  
End do 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[Fu], Fu 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
       Do i2 = 1, 4
 Do gO2=1,3 
B0m2 = Real(SA_B0(p2,MFu2(i1),MFu2(i2)),dp) 
B1m2 = Real(SA_B1(p2,MFu2(i1),MFu2(i2)),dp) 
coupL1 = cplcFuFuVZpL(i1,i2)
coupR1 = cplcFuFuVZpR(i1,i2)
coupL2 = cplcFuFuhhL(i2,i1,gO2)
coupR2 = cplcFuFuhhR(i2,i1,gO2)
    SumI = (coupL1*coupL2+coupR1*coupR2)*MFu(i1)*(B0m2+B1m2) & 
  & + (coupL1*coupR2+coupR1*coupL2)*MFu(i2)*B1m2  
End do 
res = res +3._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[gWp], gWp 
!------------------------ 
sumI = 0._dp 
 
Do gO2=1,3 
B0m2 = Real(SA_B0(p2,MVWp2,MVWp2),dp) 
B1m2 = Real(SA_B1(p2,MVWp2,MVWp2),dp) 
coup1 = cplcgWpgWpVZp
coup2 = cplcgWpgWphh(gO2) 
   SumI = -0.5_dp*coup1*coup2*(B0m2+B1m2) 
End do 
res = res +1._dp* SumI  
!------------------------ 
! bar[gWpC], gWpC 
!------------------------ 
sumI = 0._dp 
 
Do gO2=1,3 
B0m2 = Real(SA_B0(p2,MVWp2,MVWp2),dp) 
B1m2 = Real(SA_B1(p2,MVWp2,MVWp2),dp) 
coup1 = cplcgWCgWCVZp
coup2 = cplcgWCgWChh(gO2) 
   SumI = -0.5_dp*coup1*coup2*(B0m2+B1m2) 
End do 
res = res +1._dp* SumI  
!------------------------ 
! bar[gXp], gXp 
!------------------------ 
sumI = 0._dp 
 
Do gO2=1,3 
B0m2 = Real(SA_B0(p2,MVXp2,MVXp2),dp) 
B1m2 = Real(SA_B1(p2,MVXp2,MVXp2),dp) 
coup1 = cplcgXp1gXp1VZp
coup2 = cplcgXp1gXp1hh(gO2) 
   SumI = -0.5_dp*coup1*coup2*(B0m2+B1m2) 
End do 
res = res +1._dp* SumI  
!------------------------ 
! bar[gXpC], gXpC 
!------------------------ 
sumI = 0._dp 
 
Do gO2=1,3 
B0m2 = Real(SA_B0(p2,MVXp2,MVXp2),dp) 
B1m2 = Real(SA_B1(p2,MVXp2,MVXp2),dp) 
coup1 = cplcgXp2gXp2VZp
coup2 = cplcgXp2gXp2hh(gO2) 
   SumI = -0.5_dp*coup1*coup2*(B0m2+B1m2) 
End do 
res = res +1._dp* SumI  
!------------------------ 
! conj[Hpm], Hpm 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
       Do i2 = 1, 4
 Do gO2=1,3 
B0m2 = Real(SA_B0(p2,MHpm2(i2),MHpm2(i1)),dp) 
B1m2 = Real(SA_B1(p2,MHpm2(i2),MHpm2(i1)),dp) 
coup1 = cplHpmcHpmVZp(i2,i1)
coup2 = cplhhHpmcHpm(gO2,i1,i2)
    SumI = -coup1*coup2*(B1m2+0.5_dp*B0m2)
End do 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! VWp, Hpm 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 Do gO2=1,3 
B0m2 = Real(SA_B0(p2,MVWp2,MHpm2(i2)),dp) 
B1m2 = Real(SA_B1(p2,MVWp2,MHpm2(i2)),dp) 
coup1 = cplHpmVWpVZp(i2)
coup2 = cplhhcHpmcVWp(gO2,i2)
    SumI = coup1*coup2*(B1m2-B0m2) 
End do 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! VXp, Hpm 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 Do gO2=1,3 
B0m2 = Real(SA_B0(p2,MVXp2,MHpm2(i2)),dp) 
B1m2 = Real(SA_B1(p2,MVXp2,MHpm2(i2)),dp) 
coup1 = cplHpmVXpVZp(i2)
coup2 = cplhhcHpmcVXp(gO2,i2)
    SumI = coup1*coup2*(B1m2-B0m2) 
End do 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! conj[VWp], VWp 
!------------------------ 
sumI = 0._dp 
 
Do gO2=1,3 
B0m2 = Real(SA_B0(p2,MVWp2,MVWp2),dp)
B1m2 = Real(SA_B1(p2,MVWp2,MVWp2),dp) 
coup1 = cplcVWpVWpVZp
coup2 = cplhhcVWpVWp(gO2)
    SumI = coup1*coup2*(3._dp/2._dp*B0m2+3._dp*B1m2) 
End do 
res = res +1._dp* SumI  
!------------------------ 
! conj[VXp], VXp 
!------------------------ 
sumI = 0._dp 
 
Do gO2=1,3 
B0m2 = Real(SA_B0(p2,MVXp2,MVXp2),dp)
B1m2 = Real(SA_B1(p2,MVXp2,MVXp2),dp) 
coup1 = cplcVXpVXpVZp
coup2 = cplhhcVXpVXp(gO2)
    SumI = coup1*coup2*(3._dp/2._dp*B0m2+3._dp*B1m2) 
End do 
res = res +1._dp* SumI  
!------------------------ 
! conj[VWp], conj[Hpm] 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 Do gO2=1,3 
B0m2 = Real(SA_B0(p2,MVWp2,MHpm2(i2)),dp) 
B1m2 = Real(SA_B1(p2,MVWp2,MHpm2(i2)),dp) 
coup1 = cplcHpmcVWpVZp(i2)
coup2 = cplhhHpmVWp(gO2,i2)
    SumI = coup1*coup2*(B1m2-B0m2) 
End do 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! conj[VXp], conj[Hpm] 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 Do gO2=1,3 
B0m2 = Real(SA_B0(p2,MVXp2,MHpm2(i2)),dp) 
B1m2 = Real(SA_B1(p2,MVXp2,MHpm2(i2)),dp) 
coup1 = cplcHpmcVXpVZp(i2)
coup2 = cplhhHpmVXp(gO2,i2)
    SumI = coup1*coup2*(B1m2-B0m2) 
End do 
res = res +1._dp* SumI  
    End Do 
 res = oo16pi2*res 
 
End Subroutine Pi1LoopVZphh 
 
Subroutine DerPi1LoopVZphh(p2,MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,MFe2,MFu,              & 
& MFu2,Mhh,Mhh2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,cplAhhhhh,cplAhhhVZp,cplcFdFdhhL,       & 
& cplcFdFdhhR,cplcFdFdVZpL,cplcFdFdVZpR,cplcFeFehhL,cplcFeFehhR,cplcFeFeVZpL,            & 
& cplcFeFeVZpR,cplcFuFuhhL,cplcFuFuhhR,cplcFuFuVZpL,cplcFuFuVZpR,cplcgWCgWChh,           & 
& cplcgWCgWCVZp,cplcgWpgWphh,cplcgWpgWpVZp,cplcgXp1gXp1hh,cplcgXp1gXp1VZp,               & 
& cplcgXp2gXp2hh,cplcgXp2gXp2VZp,cplcHpmcVWpVZp,cplcHpmcVXpVZp,cplcVWpVWpVZp,            & 
& cplcVXpVXpVZp,cplDpmcDpmVZp,cplDpmhhcDpm,cplhhcHpmcVWp,cplhhcHpmcVXp,cplhhcVWpVWp,     & 
& cplhhcVXpVXp,cplhhHpmcHpm,cplhhHpmVWp,cplhhHpmVXp,cplHpmcHpmVZp,cplHpmVWpVZp,          & 
& cplHpmVXpVZp,kont,res)

Implicit None 
Real(dp), Intent(in) :: MAh(3),MAh2(3),MDpm(2),MDpm2(2),MFd(5),MFd2(5),MFe(3),MFe2(3),MFu(4),MFu2(4),         & 
& Mhh(3),Mhh2(3),MHpm(4),MHpm2(4),MVWp,MVWp2,MVXp,MVXp2

Complex(dp), Intent(in) :: cplAhhhhh(3,3,3),cplAhhhVZp(3,3),cplcFdFdhhL(5,5,3),cplcFdFdhhR(5,5,3),               & 
& cplcFdFdVZpL(5,5),cplcFdFdVZpR(5,5),cplcFeFehhL(3,3,3),cplcFeFehhR(3,3,3),             & 
& cplcFeFeVZpL(3,3),cplcFeFeVZpR(3,3),cplcFuFuhhL(4,4,3),cplcFuFuhhR(4,4,3),             & 
& cplcFuFuVZpL(4,4),cplcFuFuVZpR(4,4),cplcgWCgWChh(3),cplcgWCgWCVZp,cplcgWpgWphh(3),     & 
& cplcgWpgWpVZp,cplcgXp1gXp1hh(3),cplcgXp1gXp1VZp,cplcgXp2gXp2hh(3),cplcgXp2gXp2VZp,     & 
& cplcHpmcVWpVZp(4),cplcHpmcVXpVZp(4),cplcVWpVWpVZp,cplcVXpVXpVZp,cplDpmcDpmVZp(2,2),    & 
& cplDpmhhcDpm(2,3,2),cplhhcHpmcVWp(3,4),cplhhcHpmcVXp(3,4),cplhhcVWpVWp(3),             & 
& cplhhcVXpVXp(3),cplhhHpmcHpm(3,4,4),cplhhHpmVWp(3,4),cplhhHpmVXp(3,4),cplHpmcHpmVZp(4,4),& 
& cplHpmVWpVZp(4),cplHpmVXpVZp(4)

Integer, Intent(inout) :: kont 
Real(dp) :: B0m2, F0m2, G0m2, B1m2, H0m2, B22m2, m1, m2 
Real(dp), Intent(in) :: p2 
Complex(dp) :: A0m2 
Complex(dp), Intent(inout) :: res(3) 
Complex(dp) :: coupL1, coupR1, coupL2,coupR2, coup1,coup2, coup3, temp, sumI 
Integer :: i1,i2,i3,i4, gO1, gO2, ierr 
 
 
Real(dp) ::MVG,MVP,MVG2,MVP2
MVG = Mass_Regulator_PhotonGluon 
MVP = Mass_Regulator_PhotonGluon 
MVG2 = Mass_Regulator_PhotonGluon**2 
MVP2 = Mass_Regulator_PhotonGluon**2 

res = 0._dp 
 
!------------------------ 
! hh, Ah 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 3
       Do i2 = 1, 3
 Do gO2=1,3 
B0m2 = Real(SA_DerB0(p2,MAh2(i2),Mhh2(i1)),dp) 
B1m2 = Real(SA_DerB1(p2,MAh2(i2),Mhh2(i1)),dp) 
coup1 = cplAhhhVZp(i2,i1)
coup2 = cplAhhhhh(i2,gO2,i1)
    SumI = -coup1*coup2*(B1m2+0.5_dp*B0m2)
End do 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! conj[Dpm], Dpm 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 2
       Do i2 = 1, 2
 Do gO2=1,3 
B0m2 = Real(SA_DerB0(p2,MDpm2(i2),MDpm2(i1)),dp) 
B1m2 = Real(SA_DerB1(p2,MDpm2(i2),MDpm2(i1)),dp) 
coup1 = cplDpmcDpmVZp(i2,i1)
coup2 = cplDpmhhcDpm(i1,gO2,i2)
    SumI = -coup1*coup2*(B1m2+0.5_dp*B0m2)
End do 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[Fd], Fd 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 5
       Do i2 = 1, 5
 Do gO2=1,3 
B0m2 = Real(SA_DerB0(p2,MFd2(i1),MFd2(i2)),dp) 
B1m2 = Real(SA_DerB1(p2,MFd2(i1),MFd2(i2)),dp) 
coupL1 = cplcFdFdVZpL(i1,i2)
coupR1 = cplcFdFdVZpR(i1,i2)
coupL2 = cplcFdFdhhL(i2,i1,gO2)
coupR2 = cplcFdFdhhR(i2,i1,gO2)
    SumI = (coupL1*coupL2+coupR1*coupR2)*MFd(i1)*(B0m2+B1m2) & 
  & + (coupL1*coupR2+coupR1*coupL2)*MFd(i2)*B1m2  
End do 
res = res +3._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[Fe], Fe 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 3
       Do i2 = 1, 3
 Do gO2=1,3 
B0m2 = Real(SA_DerB0(p2,MFe2(i1),MFe2(i2)),dp) 
B1m2 = Real(SA_DerB1(p2,MFe2(i1),MFe2(i2)),dp) 
coupL1 = cplcFeFeVZpL(i1,i2)
coupR1 = cplcFeFeVZpR(i1,i2)
coupL2 = cplcFeFehhL(i2,i1,gO2)
coupR2 = cplcFeFehhR(i2,i1,gO2)
    SumI = (coupL1*coupL2+coupR1*coupR2)*MFe(i1)*(B0m2+B1m2) & 
  & + (coupL1*coupR2+coupR1*coupL2)*MFe(i2)*B1m2  
End do 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[Fu], Fu 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
       Do i2 = 1, 4
 Do gO2=1,3 
B0m2 = Real(SA_DerB0(p2,MFu2(i1),MFu2(i2)),dp) 
B1m2 = Real(SA_DerB1(p2,MFu2(i1),MFu2(i2)),dp) 
coupL1 = cplcFuFuVZpL(i1,i2)
coupR1 = cplcFuFuVZpR(i1,i2)
coupL2 = cplcFuFuhhL(i2,i1,gO2)
coupR2 = cplcFuFuhhR(i2,i1,gO2)
    SumI = (coupL1*coupL2+coupR1*coupR2)*MFu(i1)*(B0m2+B1m2) & 
  & + (coupL1*coupR2+coupR1*coupL2)*MFu(i2)*B1m2  
End do 
res = res +3._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[gWp], gWp 
!------------------------ 
sumI = 0._dp 
 
Do gO2=1,3 
B0m2 = Real(SA_DerB0(p2,MVWp2,MVWp2),dp) 
B1m2 = Real(SA_DerB1(p2,MVWp2,MVWp2),dp) 
coup1 = cplcgWpgWpVZp
coup2 = cplcgWpgWphh(gO2) 
   SumI = -0.5_dp*coup1*coup2*(B0m2+B1m2) 
End do 
res = res +1._dp* SumI  
!------------------------ 
! bar[gWpC], gWpC 
!------------------------ 
sumI = 0._dp 
 
Do gO2=1,3 
B0m2 = Real(SA_DerB0(p2,MVWp2,MVWp2),dp) 
B1m2 = Real(SA_DerB1(p2,MVWp2,MVWp2),dp) 
coup1 = cplcgWCgWCVZp
coup2 = cplcgWCgWChh(gO2) 
   SumI = -0.5_dp*coup1*coup2*(B0m2+B1m2) 
End do 
res = res +1._dp* SumI  
!------------------------ 
! bar[gXp], gXp 
!------------------------ 
sumI = 0._dp 
 
Do gO2=1,3 
B0m2 = Real(SA_DerB0(p2,MVXp2,MVXp2),dp) 
B1m2 = Real(SA_DerB1(p2,MVXp2,MVXp2),dp) 
coup1 = cplcgXp1gXp1VZp
coup2 = cplcgXp1gXp1hh(gO2) 
   SumI = -0.5_dp*coup1*coup2*(B0m2+B1m2) 
End do 
res = res +1._dp* SumI  
!------------------------ 
! bar[gXpC], gXpC 
!------------------------ 
sumI = 0._dp 
 
Do gO2=1,3 
B0m2 = Real(SA_DerB0(p2,MVXp2,MVXp2),dp) 
B1m2 = Real(SA_DerB1(p2,MVXp2,MVXp2),dp) 
coup1 = cplcgXp2gXp2VZp
coup2 = cplcgXp2gXp2hh(gO2) 
   SumI = -0.5_dp*coup1*coup2*(B0m2+B1m2) 
End do 
res = res +1._dp* SumI  
!------------------------ 
! conj[Hpm], Hpm 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
       Do i2 = 1, 4
 Do gO2=1,3 
B0m2 = Real(SA_DerB0(p2,MHpm2(i2),MHpm2(i1)),dp) 
B1m2 = Real(SA_DerB1(p2,MHpm2(i2),MHpm2(i1)),dp) 
coup1 = cplHpmcHpmVZp(i2,i1)
coup2 = cplhhHpmcHpm(gO2,i1,i2)
    SumI = -coup1*coup2*(B1m2+0.5_dp*B0m2)
End do 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! VWp, Hpm 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 Do gO2=1,3 
B0m2 = Real(SA_DerB0(p2,MVWp2,MHpm2(i2)),dp) 
B1m2 = Real(SA_DerB1(p2,MVWp2,MHpm2(i2)),dp) 
coup1 = cplHpmVWpVZp(i2)
coup2 = cplhhcHpmcVWp(gO2,i2)
    SumI = coup1*coup2*(B1m2-B0m2) 
End do 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! VXp, Hpm 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 Do gO2=1,3 
B0m2 = Real(SA_DerB0(p2,MVXp2,MHpm2(i2)),dp) 
B1m2 = Real(SA_DerB1(p2,MVXp2,MHpm2(i2)),dp) 
coup1 = cplHpmVXpVZp(i2)
coup2 = cplhhcHpmcVXp(gO2,i2)
    SumI = coup1*coup2*(B1m2-B0m2) 
End do 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! conj[VWp], VWp 
!------------------------ 
sumI = 0._dp 
 
Do gO2=1,3 
B0m2 = Real(SA_DerB0(p2,MVWp2,MVWp2),dp)
B1m2 = Real(SA_DerB1(p2,MVWp2,MVWp2),dp) 
coup1 = cplcVWpVWpVZp
coup2 = cplhhcVWpVWp(gO2)
    SumI = coup1*coup2*(3._dp/2._dp*B0m2+3._dp*B1m2) 
End do 
res = res +1._dp* SumI  
!------------------------ 
! conj[VXp], VXp 
!------------------------ 
sumI = 0._dp 
 
Do gO2=1,3 
B0m2 = Real(SA_DerB0(p2,MVXp2,MVXp2),dp)
B1m2 = Real(SA_DerB1(p2,MVXp2,MVXp2),dp) 
coup1 = cplcVXpVXpVZp
coup2 = cplhhcVXpVXp(gO2)
    SumI = coup1*coup2*(3._dp/2._dp*B0m2+3._dp*B1m2) 
End do 
res = res +1._dp* SumI  
!------------------------ 
! conj[VWp], conj[Hpm] 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 Do gO2=1,3 
B0m2 = Real(SA_DerB0(p2,MVWp2,MHpm2(i2)),dp) 
B1m2 = Real(SA_DerB1(p2,MVWp2,MHpm2(i2)),dp) 
coup1 = cplcHpmcVWpVZp(i2)
coup2 = cplhhHpmVWp(gO2,i2)
    SumI = coup1*coup2*(B1m2-B0m2) 
End do 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! conj[VXp], conj[Hpm] 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 Do gO2=1,3 
B0m2 = Real(SA_DerB0(p2,MVXp2,MHpm2(i2)),dp) 
B1m2 = Real(SA_DerB1(p2,MVXp2,MHpm2(i2)),dp) 
coup1 = cplcHpmcVXpVZp(i2)
coup2 = cplhhHpmVXp(gO2,i2)
    SumI = coup1*coup2*(B1m2-B0m2) 
End do 
res = res +1._dp* SumI  
    End Do 
 res = oo16pi2*res 
 
End Subroutine DerPi1LoopVZphh 
 
Subroutine Pi1LoopVZpAh(p2,MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,MFe2,MFu,MFu2,            & 
& Mhh,Mhh2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,cplAhAhhh,               & 
& cplAhcHpmcVWp,cplAhcHpmcVXp,cplAhDpmcDpm,cplAhhhVP,cplAhhhVZ,cplAhhhVZp,               & 
& cplAhHpmcHpm,cplAhHpmVWp,cplAhHpmVXp,cplcFdFdAhL,cplcFdFdAhR,cplcFdFdVZpL,             & 
& cplcFdFdVZpR,cplcFeFeAhL,cplcFeFeAhR,cplcFeFeVZpL,cplcFeFeVZpR,cplcFuFuAhL,            & 
& cplcFuFuAhR,cplcFuFuVZpL,cplcFuFuVZpR,cplcgWCgWCAh,cplcgWCgWCVZp,cplcgWpgWpAh,         & 
& cplcgWpgWpVZp,cplcgXp1gXp1Ah,cplcgXp1gXp1VZp,cplcgXp2gXp2Ah,cplcgXp2gXp2VZp,           & 
& cplcHpmcVWpVZp,cplcHpmcVXpVZp,cplDpmcDpmVZp,cplhhVPVZp,cplhhVZpVZp,cplhhVZVZp,         & 
& cplHpmcHpmVZp,cplHpmVWpVZp,cplHpmVXpVZp,kont,res)

Implicit None 
Real(dp), Intent(in) :: MAh(3),MAh2(3),MDpm(2),MDpm2(2),MFd(5),MFd2(5),MFe(3),MFe2(3),MFu(4),MFu2(4),         & 
& Mhh(3),Mhh2(3),MHpm(4),MHpm2(4),MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2

Complex(dp), Intent(in) :: cplAhAhhh(3,3,3),cplAhcHpmcVWp(3,4),cplAhcHpmcVXp(3,4),cplAhDpmcDpm(3,2,2),           & 
& cplAhhhVP(3,3),cplAhhhVZ(3,3),cplAhhhVZp(3,3),cplAhHpmcHpm(3,4,4),cplAhHpmVWp(3,4),    & 
& cplAhHpmVXp(3,4),cplcFdFdAhL(5,5,3),cplcFdFdAhR(5,5,3),cplcFdFdVZpL(5,5),              & 
& cplcFdFdVZpR(5,5),cplcFeFeAhL(3,3,3),cplcFeFeAhR(3,3,3),cplcFeFeVZpL(3,3),             & 
& cplcFeFeVZpR(3,3),cplcFuFuAhL(4,4,3),cplcFuFuAhR(4,4,3),cplcFuFuVZpL(4,4),             & 
& cplcFuFuVZpR(4,4),cplcgWCgWCAh(3),cplcgWCgWCVZp,cplcgWpgWpAh(3),cplcgWpgWpVZp,         & 
& cplcgXp1gXp1Ah(3),cplcgXp1gXp1VZp,cplcgXp2gXp2Ah(3),cplcgXp2gXp2VZp,cplcHpmcVWpVZp(4), & 
& cplcHpmcVXpVZp(4),cplDpmcDpmVZp(2,2),cplhhVPVZp(3),cplhhVZpVZp(3),cplhhVZVZp(3),       & 
& cplHpmcHpmVZp(4,4),cplHpmVWpVZp(4),cplHpmVXpVZp(4)

Integer, Intent(inout) :: kont 
Real(dp) :: B0m2, F0m2, G0m2, B1m2, H0m2, B22m2, m1, m2 
Real(dp), Intent(in) :: p2 
Complex(dp) :: A0m2 
Complex(dp), Intent(inout) :: res(3) 
Complex(dp) :: coupL1, coupR1, coupL2,coupR2, coup1,coup2, coup3, temp, sumI 
Integer :: i1,i2,i3,i4, gO1, gO2, ierr 
 
 
res = 0._dp 
 
!------------------------ 
! hh, Ah 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 3
       Do i2 = 1, 3
 Do gO2=1,3 
B0m2 = Real(SA_B0(p2,MAh2(i2),Mhh2(i1)),dp) 
B1m2 = Real(SA_B1(p2,MAh2(i2),Mhh2(i1)),dp) 
coup1 = cplAhhhVZp(i2,i1)
coup2 = cplAhAhhh(gO2,i2,i1)
    SumI = -coup1*coup2*(B1m2+0.5_dp*B0m2)
End do 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! conj[Dpm], Dpm 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 2
       Do i2 = 1, 2
 Do gO2=1,3 
B0m2 = Real(SA_B0(p2,MDpm2(i2),MDpm2(i1)),dp) 
B1m2 = Real(SA_B1(p2,MDpm2(i2),MDpm2(i1)),dp) 
coup1 = cplDpmcDpmVZp(i2,i1)
coup2 = cplAhDpmcDpm(gO2,i1,i2)
    SumI = -coup1*coup2*(B1m2+0.5_dp*B0m2)
End do 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[Fd], Fd 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 5
       Do i2 = 1, 5
 Do gO2=1,3 
B0m2 = Real(SA_B0(p2,MFd2(i1),MFd2(i2)),dp) 
B1m2 = Real(SA_B1(p2,MFd2(i1),MFd2(i2)),dp) 
coupL1 = cplcFdFdVZpL(i1,i2)
coupR1 = cplcFdFdVZpR(i1,i2)
coupL2 = cplcFdFdAhL(i2,i1,gO2)
coupR2 = cplcFdFdAhR(i2,i1,gO2)
    SumI = (coupL1*coupL2+coupR1*coupR2)*MFd(i1)*(B0m2+B1m2) & 
  & + (coupL1*coupR2+coupR1*coupL2)*MFd(i2)*B1m2  
End do 
res = res +3._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[Fe], Fe 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 3
       Do i2 = 1, 3
 Do gO2=1,3 
B0m2 = Real(SA_B0(p2,MFe2(i1),MFe2(i2)),dp) 
B1m2 = Real(SA_B1(p2,MFe2(i1),MFe2(i2)),dp) 
coupL1 = cplcFeFeVZpL(i1,i2)
coupR1 = cplcFeFeVZpR(i1,i2)
coupL2 = cplcFeFeAhL(i2,i1,gO2)
coupR2 = cplcFeFeAhR(i2,i1,gO2)
    SumI = (coupL1*coupL2+coupR1*coupR2)*MFe(i1)*(B0m2+B1m2) & 
  & + (coupL1*coupR2+coupR1*coupL2)*MFe(i2)*B1m2  
End do 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[Fu], Fu 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
       Do i2 = 1, 4
 Do gO2=1,3 
B0m2 = Real(SA_B0(p2,MFu2(i1),MFu2(i2)),dp) 
B1m2 = Real(SA_B1(p2,MFu2(i1),MFu2(i2)),dp) 
coupL1 = cplcFuFuVZpL(i1,i2)
coupR1 = cplcFuFuVZpR(i1,i2)
coupL2 = cplcFuFuAhL(i2,i1,gO2)
coupR2 = cplcFuFuAhR(i2,i1,gO2)
    SumI = (coupL1*coupL2+coupR1*coupR2)*MFu(i1)*(B0m2+B1m2) & 
  & + (coupL1*coupR2+coupR1*coupL2)*MFu(i2)*B1m2  
End do 
res = res +3._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[gWp], gWp 
!------------------------ 
sumI = 0._dp 
 
Do gO2=1,3 
B0m2 = Real(SA_B0(p2,MVWp2,MVWp2),dp) 
B1m2 = Real(SA_B1(p2,MVWp2,MVWp2),dp) 
coup1 = cplcgWpgWpVZp
coup2 = cplcgWpgWpAh(gO2) 
   SumI = -0.5_dp*coup1*coup2*(B0m2+B1m2) 
End do 
res = res +1._dp* SumI  
!------------------------ 
! bar[gWpC], gWpC 
!------------------------ 
sumI = 0._dp 
 
Do gO2=1,3 
B0m2 = Real(SA_B0(p2,MVWp2,MVWp2),dp) 
B1m2 = Real(SA_B1(p2,MVWp2,MVWp2),dp) 
coup1 = cplcgWCgWCVZp
coup2 = cplcgWCgWCAh(gO2) 
   SumI = -0.5_dp*coup1*coup2*(B0m2+B1m2) 
End do 
res = res +1._dp* SumI  
!------------------------ 
! bar[gXp], gXp 
!------------------------ 
sumI = 0._dp 
 
Do gO2=1,3 
B0m2 = Real(SA_B0(p2,MVXp2,MVXp2),dp) 
B1m2 = Real(SA_B1(p2,MVXp2,MVXp2),dp) 
coup1 = cplcgXp1gXp1VZp
coup2 = cplcgXp1gXp1Ah(gO2) 
   SumI = -0.5_dp*coup1*coup2*(B0m2+B1m2) 
End do 
res = res +1._dp* SumI  
!------------------------ 
! bar[gXpC], gXpC 
!------------------------ 
sumI = 0._dp 
 
Do gO2=1,3 
B0m2 = Real(SA_B0(p2,MVXp2,MVXp2),dp) 
B1m2 = Real(SA_B1(p2,MVXp2,MVXp2),dp) 
coup1 = cplcgXp2gXp2VZp
coup2 = cplcgXp2gXp2Ah(gO2) 
   SumI = -0.5_dp*coup1*coup2*(B0m2+B1m2) 
End do 
res = res +1._dp* SumI  
!------------------------ 
! VP, hh 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 3
 Do gO2=1,3 
B0m2 = Real(SA_B0(p2,0._dp,Mhh2(i2)),dp) 
B1m2 = Real(SA_B1(p2,0._dp,Mhh2(i2)),dp) 
coup1 = cplhhVPVZp(i2)
coup2 = cplAhhhVP(gO2,i2)
    SumI = coup1*coup2*(B1m2-B0m2) 
End do 
res = res +0.5_dp* SumI  
    End Do 
 !------------------------ 
! VZ, hh 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 3
 Do gO2=1,3 
B0m2 = Real(SA_B0(p2,MVZ2,Mhh2(i2)),dp) 
B1m2 = Real(SA_B1(p2,MVZ2,Mhh2(i2)),dp) 
coup1 = cplhhVZVZp(i2)
coup2 = cplAhhhVZ(gO2,i2)
    SumI = coup1*coup2*(B1m2-B0m2) 
End do 
res = res +0.5_dp* SumI  
    End Do 
 !------------------------ 
! VZp, hh 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 3
 Do gO2=1,3 
B0m2 = Real(SA_B0(p2,MVZp2,Mhh2(i2)),dp) 
B1m2 = Real(SA_B1(p2,MVZp2,Mhh2(i2)),dp) 
coup1 = cplhhVZpVZp(i2)
coup2 = cplAhhhVZp(gO2,i2)
    SumI = coup1*coup2*(B1m2-B0m2) 
End do 
res = res +0.5_dp* SumI  
    End Do 
 !------------------------ 
! conj[Hpm], Hpm 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
       Do i2 = 1, 4
 Do gO2=1,3 
B0m2 = Real(SA_B0(p2,MHpm2(i2),MHpm2(i1)),dp) 
B1m2 = Real(SA_B1(p2,MHpm2(i2),MHpm2(i1)),dp) 
coup1 = cplHpmcHpmVZp(i2,i1)
coup2 = cplAhHpmcHpm(gO2,i1,i2)
    SumI = -coup1*coup2*(B1m2+0.5_dp*B0m2)
End do 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! VWp, Hpm 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 Do gO2=1,3 
B0m2 = Real(SA_B0(p2,MVWp2,MHpm2(i2)),dp) 
B1m2 = Real(SA_B1(p2,MVWp2,MHpm2(i2)),dp) 
coup1 = cplHpmVWpVZp(i2)
coup2 = cplAhcHpmcVWp(gO2,i2)
    SumI = coup1*coup2*(B1m2-B0m2) 
End do 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! VXp, Hpm 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 Do gO2=1,3 
B0m2 = Real(SA_B0(p2,MVXp2,MHpm2(i2)),dp) 
B1m2 = Real(SA_B1(p2,MVXp2,MHpm2(i2)),dp) 
coup1 = cplHpmVXpVZp(i2)
coup2 = cplAhcHpmcVXp(gO2,i2)
    SumI = coup1*coup2*(B1m2-B0m2) 
End do 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! conj[VWp], conj[Hpm] 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 Do gO2=1,3 
B0m2 = Real(SA_B0(p2,MVWp2,MHpm2(i2)),dp) 
B1m2 = Real(SA_B1(p2,MVWp2,MHpm2(i2)),dp) 
coup1 = cplcHpmcVWpVZp(i2)
coup2 = cplAhHpmVWp(gO2,i2)
    SumI = coup1*coup2*(B1m2-B0m2) 
End do 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! conj[VXp], conj[Hpm] 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 Do gO2=1,3 
B0m2 = Real(SA_B0(p2,MVXp2,MHpm2(i2)),dp) 
B1m2 = Real(SA_B1(p2,MVXp2,MHpm2(i2)),dp) 
coup1 = cplcHpmcVXpVZp(i2)
coup2 = cplAhHpmVXp(gO2,i2)
    SumI = coup1*coup2*(B1m2-B0m2) 
End do 
res = res +1._dp* SumI  
    End Do 
 res = oo16pi2*res 
 
End Subroutine Pi1LoopVZpAh 
 
Subroutine DerPi1LoopVZpAh(p2,MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,MFe2,MFu,              & 
& MFu2,Mhh,Mhh2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,cplAhAhhh,          & 
& cplAhcHpmcVWp,cplAhcHpmcVXp,cplAhDpmcDpm,cplAhhhVP,cplAhhhVZ,cplAhhhVZp,               & 
& cplAhHpmcHpm,cplAhHpmVWp,cplAhHpmVXp,cplcFdFdAhL,cplcFdFdAhR,cplcFdFdVZpL,             & 
& cplcFdFdVZpR,cplcFeFeAhL,cplcFeFeAhR,cplcFeFeVZpL,cplcFeFeVZpR,cplcFuFuAhL,            & 
& cplcFuFuAhR,cplcFuFuVZpL,cplcFuFuVZpR,cplcgWCgWCAh,cplcgWCgWCVZp,cplcgWpgWpAh,         & 
& cplcgWpgWpVZp,cplcgXp1gXp1Ah,cplcgXp1gXp1VZp,cplcgXp2gXp2Ah,cplcgXp2gXp2VZp,           & 
& cplcHpmcVWpVZp,cplcHpmcVXpVZp,cplDpmcDpmVZp,cplhhVPVZp,cplhhVZpVZp,cplhhVZVZp,         & 
& cplHpmcHpmVZp,cplHpmVWpVZp,cplHpmVXpVZp,kont,res)

Implicit None 
Real(dp), Intent(in) :: MAh(3),MAh2(3),MDpm(2),MDpm2(2),MFd(5),MFd2(5),MFe(3),MFe2(3),MFu(4),MFu2(4),         & 
& Mhh(3),Mhh2(3),MHpm(4),MHpm2(4),MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2

Complex(dp), Intent(in) :: cplAhAhhh(3,3,3),cplAhcHpmcVWp(3,4),cplAhcHpmcVXp(3,4),cplAhDpmcDpm(3,2,2),           & 
& cplAhhhVP(3,3),cplAhhhVZ(3,3),cplAhhhVZp(3,3),cplAhHpmcHpm(3,4,4),cplAhHpmVWp(3,4),    & 
& cplAhHpmVXp(3,4),cplcFdFdAhL(5,5,3),cplcFdFdAhR(5,5,3),cplcFdFdVZpL(5,5),              & 
& cplcFdFdVZpR(5,5),cplcFeFeAhL(3,3,3),cplcFeFeAhR(3,3,3),cplcFeFeVZpL(3,3),             & 
& cplcFeFeVZpR(3,3),cplcFuFuAhL(4,4,3),cplcFuFuAhR(4,4,3),cplcFuFuVZpL(4,4),             & 
& cplcFuFuVZpR(4,4),cplcgWCgWCAh(3),cplcgWCgWCVZp,cplcgWpgWpAh(3),cplcgWpgWpVZp,         & 
& cplcgXp1gXp1Ah(3),cplcgXp1gXp1VZp,cplcgXp2gXp2Ah(3),cplcgXp2gXp2VZp,cplcHpmcVWpVZp(4), & 
& cplcHpmcVXpVZp(4),cplDpmcDpmVZp(2,2),cplhhVPVZp(3),cplhhVZpVZp(3),cplhhVZVZp(3),       & 
& cplHpmcHpmVZp(4,4),cplHpmVWpVZp(4),cplHpmVXpVZp(4)

Integer, Intent(inout) :: kont 
Real(dp) :: B0m2, F0m2, G0m2, B1m2, H0m2, B22m2, m1, m2 
Real(dp), Intent(in) :: p2 
Complex(dp) :: A0m2 
Complex(dp), Intent(inout) :: res(3) 
Complex(dp) :: coupL1, coupR1, coupL2,coupR2, coup1,coup2, coup3, temp, sumI 
Integer :: i1,i2,i3,i4, gO1, gO2, ierr 
 
 
Real(dp) ::MVG,MVP,MVG2,MVP2
MVG = Mass_Regulator_PhotonGluon 
MVP = Mass_Regulator_PhotonGluon 
MVG2 = Mass_Regulator_PhotonGluon**2 
MVP2 = Mass_Regulator_PhotonGluon**2 

res = 0._dp 
 
!------------------------ 
! hh, Ah 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 3
       Do i2 = 1, 3
 Do gO2=1,3 
B0m2 = Real(SA_DerB0(p2,MAh2(i2),Mhh2(i1)),dp) 
B1m2 = Real(SA_DerB1(p2,MAh2(i2),Mhh2(i1)),dp) 
coup1 = cplAhhhVZp(i2,i1)
coup2 = cplAhAhhh(gO2,i2,i1)
    SumI = -coup1*coup2*(B1m2+0.5_dp*B0m2)
End do 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! conj[Dpm], Dpm 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 2
       Do i2 = 1, 2
 Do gO2=1,3 
B0m2 = Real(SA_DerB0(p2,MDpm2(i2),MDpm2(i1)),dp) 
B1m2 = Real(SA_DerB1(p2,MDpm2(i2),MDpm2(i1)),dp) 
coup1 = cplDpmcDpmVZp(i2,i1)
coup2 = cplAhDpmcDpm(gO2,i1,i2)
    SumI = -coup1*coup2*(B1m2+0.5_dp*B0m2)
End do 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[Fd], Fd 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 5
       Do i2 = 1, 5
 Do gO2=1,3 
B0m2 = Real(SA_DerB0(p2,MFd2(i1),MFd2(i2)),dp) 
B1m2 = Real(SA_DerB1(p2,MFd2(i1),MFd2(i2)),dp) 
coupL1 = cplcFdFdVZpL(i1,i2)
coupR1 = cplcFdFdVZpR(i1,i2)
coupL2 = cplcFdFdAhL(i2,i1,gO2)
coupR2 = cplcFdFdAhR(i2,i1,gO2)
    SumI = (coupL1*coupL2+coupR1*coupR2)*MFd(i1)*(B0m2+B1m2) & 
  & + (coupL1*coupR2+coupR1*coupL2)*MFd(i2)*B1m2  
End do 
res = res +3._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[Fe], Fe 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 3
       Do i2 = 1, 3
 Do gO2=1,3 
B0m2 = Real(SA_DerB0(p2,MFe2(i1),MFe2(i2)),dp) 
B1m2 = Real(SA_DerB1(p2,MFe2(i1),MFe2(i2)),dp) 
coupL1 = cplcFeFeVZpL(i1,i2)
coupR1 = cplcFeFeVZpR(i1,i2)
coupL2 = cplcFeFeAhL(i2,i1,gO2)
coupR2 = cplcFeFeAhR(i2,i1,gO2)
    SumI = (coupL1*coupL2+coupR1*coupR2)*MFe(i1)*(B0m2+B1m2) & 
  & + (coupL1*coupR2+coupR1*coupL2)*MFe(i2)*B1m2  
End do 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[Fu], Fu 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
       Do i2 = 1, 4
 Do gO2=1,3 
B0m2 = Real(SA_DerB0(p2,MFu2(i1),MFu2(i2)),dp) 
B1m2 = Real(SA_DerB1(p2,MFu2(i1),MFu2(i2)),dp) 
coupL1 = cplcFuFuVZpL(i1,i2)
coupR1 = cplcFuFuVZpR(i1,i2)
coupL2 = cplcFuFuAhL(i2,i1,gO2)
coupR2 = cplcFuFuAhR(i2,i1,gO2)
    SumI = (coupL1*coupL2+coupR1*coupR2)*MFu(i1)*(B0m2+B1m2) & 
  & + (coupL1*coupR2+coupR1*coupL2)*MFu(i2)*B1m2  
End do 
res = res +3._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[gWp], gWp 
!------------------------ 
sumI = 0._dp 
 
Do gO2=1,3 
B0m2 = Real(SA_DerB0(p2,MVWp2,MVWp2),dp) 
B1m2 = Real(SA_DerB1(p2,MVWp2,MVWp2),dp) 
coup1 = cplcgWpgWpVZp
coup2 = cplcgWpgWpAh(gO2) 
   SumI = -0.5_dp*coup1*coup2*(B0m2+B1m2) 
End do 
res = res +1._dp* SumI  
!------------------------ 
! bar[gWpC], gWpC 
!------------------------ 
sumI = 0._dp 
 
Do gO2=1,3 
B0m2 = Real(SA_DerB0(p2,MVWp2,MVWp2),dp) 
B1m2 = Real(SA_DerB1(p2,MVWp2,MVWp2),dp) 
coup1 = cplcgWCgWCVZp
coup2 = cplcgWCgWCAh(gO2) 
   SumI = -0.5_dp*coup1*coup2*(B0m2+B1m2) 
End do 
res = res +1._dp* SumI  
!------------------------ 
! bar[gXp], gXp 
!------------------------ 
sumI = 0._dp 
 
Do gO2=1,3 
B0m2 = Real(SA_DerB0(p2,MVXp2,MVXp2),dp) 
B1m2 = Real(SA_DerB1(p2,MVXp2,MVXp2),dp) 
coup1 = cplcgXp1gXp1VZp
coup2 = cplcgXp1gXp1Ah(gO2) 
   SumI = -0.5_dp*coup1*coup2*(B0m2+B1m2) 
End do 
res = res +1._dp* SumI  
!------------------------ 
! bar[gXpC], gXpC 
!------------------------ 
sumI = 0._dp 
 
Do gO2=1,3 
B0m2 = Real(SA_DerB0(p2,MVXp2,MVXp2),dp) 
B1m2 = Real(SA_DerB1(p2,MVXp2,MVXp2),dp) 
coup1 = cplcgXp2gXp2VZp
coup2 = cplcgXp2gXp2Ah(gO2) 
   SumI = -0.5_dp*coup1*coup2*(B0m2+B1m2) 
End do 
res = res +1._dp* SumI  
!------------------------ 
! VP, hh 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 3
 Do gO2=1,3 
B0m2 = Real(SA_DerB0(p2,MVP2,Mhh2(i2)),dp) 
B1m2 = Real(SA_DerB1(p2,MVP2,Mhh2(i2)),dp) 
coup1 = cplhhVPVZp(i2)
coup2 = cplAhhhVP(gO2,i2)
    SumI = coup1*coup2*(B1m2-B0m2) 
End do 
res = res +0.5_dp* SumI  
    End Do 
 !------------------------ 
! VZ, hh 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 3
 Do gO2=1,3 
B0m2 = Real(SA_DerB0(p2,MVZ2,Mhh2(i2)),dp) 
B1m2 = Real(SA_DerB1(p2,MVZ2,Mhh2(i2)),dp) 
coup1 = cplhhVZVZp(i2)
coup2 = cplAhhhVZ(gO2,i2)
    SumI = coup1*coup2*(B1m2-B0m2) 
End do 
res = res +0.5_dp* SumI  
    End Do 
 !------------------------ 
! VZp, hh 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 3
 Do gO2=1,3 
B0m2 = Real(SA_DerB0(p2,MVZp2,Mhh2(i2)),dp) 
B1m2 = Real(SA_DerB1(p2,MVZp2,Mhh2(i2)),dp) 
coup1 = cplhhVZpVZp(i2)
coup2 = cplAhhhVZp(gO2,i2)
    SumI = coup1*coup2*(B1m2-B0m2) 
End do 
res = res +0.5_dp* SumI  
    End Do 
 !------------------------ 
! conj[Hpm], Hpm 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
       Do i2 = 1, 4
 Do gO2=1,3 
B0m2 = Real(SA_DerB0(p2,MHpm2(i2),MHpm2(i1)),dp) 
B1m2 = Real(SA_DerB1(p2,MHpm2(i2),MHpm2(i1)),dp) 
coup1 = cplHpmcHpmVZp(i2,i1)
coup2 = cplAhHpmcHpm(gO2,i1,i2)
    SumI = -coup1*coup2*(B1m2+0.5_dp*B0m2)
End do 
res = res +1._dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! VWp, Hpm 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 Do gO2=1,3 
B0m2 = Real(SA_DerB0(p2,MVWp2,MHpm2(i2)),dp) 
B1m2 = Real(SA_DerB1(p2,MVWp2,MHpm2(i2)),dp) 
coup1 = cplHpmVWpVZp(i2)
coup2 = cplAhcHpmcVWp(gO2,i2)
    SumI = coup1*coup2*(B1m2-B0m2) 
End do 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! VXp, Hpm 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 Do gO2=1,3 
B0m2 = Real(SA_DerB0(p2,MVXp2,MHpm2(i2)),dp) 
B1m2 = Real(SA_DerB1(p2,MVXp2,MHpm2(i2)),dp) 
coup1 = cplHpmVXpVZp(i2)
coup2 = cplAhcHpmcVXp(gO2,i2)
    SumI = coup1*coup2*(B1m2-B0m2) 
End do 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! conj[VWp], conj[Hpm] 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 Do gO2=1,3 
B0m2 = Real(SA_DerB0(p2,MVWp2,MHpm2(i2)),dp) 
B1m2 = Real(SA_DerB1(p2,MVWp2,MHpm2(i2)),dp) 
coup1 = cplcHpmcVWpVZp(i2)
coup2 = cplAhHpmVWp(gO2,i2)
    SumI = coup1*coup2*(B1m2-B0m2) 
End do 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! conj[VXp], conj[Hpm] 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 Do gO2=1,3 
B0m2 = Real(SA_DerB0(p2,MVXp2,MHpm2(i2)),dp) 
B1m2 = Real(SA_DerB1(p2,MVXp2,MHpm2(i2)),dp) 
coup1 = cplcHpmcVXpVZp(i2)
coup2 = cplAhHpmVXp(gO2,i2)
    SumI = coup1*coup2*(B1m2-B0m2) 
End do 
res = res +1._dp* SumI  
    End Do 
 res = oo16pi2*res 
 
End Subroutine DerPi1LoopVZpAh 
 
Subroutine Pi1LoopVZpDpm(p2,MFd,MFd2,MFu,MFu2,MHpm,MHpm2,MVWp,MVWp2,MVXp,             & 
& MVXp2,cplcDpmcHpmcVXp,cplcFdFdcDpmL,cplcFdFdcDpmR,cplcFdFdVZpL,cplcFdFdVZpR,           & 
& cplcFuFucDpmL,cplcFuFucDpmR,cplcFuFuVZpL,cplcFuFuVZpR,cplcHpmcVWpVZp,cplHpmcDpmcHpm,   & 
& cplHpmcDpmVWp,cplHpmcHpmVZp,cplHpmVXpVZp,kont,res)

Implicit None 
Real(dp), Intent(in) :: MFd(5),MFd2(5),MFu(4),MFu2(4),MHpm(4),MHpm2(4),MVWp,MVWp2,MVXp,MVXp2

Complex(dp), Intent(in) :: cplcDpmcHpmcVXp(2,4),cplcFdFdcDpmL(5,5,2),cplcFdFdcDpmR(5,5,2),cplcFdFdVZpL(5,5),     & 
& cplcFdFdVZpR(5,5),cplcFuFucDpmL(4,4,2),cplcFuFucDpmR(4,4,2),cplcFuFuVZpL(4,4),         & 
& cplcFuFuVZpR(4,4),cplcHpmcVWpVZp(4),cplHpmcDpmcHpm(4,2,4),cplHpmcDpmVWp(4,2),          & 
& cplHpmcHpmVZp(4,4),cplHpmVXpVZp(4)

Integer, Intent(inout) :: kont 
Real(dp) :: B0m2, F0m2, G0m2, B1m2, H0m2, B22m2, m1, m2 
Real(dp), Intent(in) :: p2 
Complex(dp) :: A0m2 
Complex(dp), Intent(inout) :: res(2) 
Complex(dp) :: coupL1, coupR1, coupL2,coupR2, coup1,coup2, coup3, temp, sumI 
Integer :: i1,i2,i3,i4, gO1, gO2, ierr 
 
 
res = 0._dp 
 
!------------------------ 
! bar[Fd], Fd 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 5
       Do i2 = 1, 5
 Do gO2=1,2 
B0m2 = Real(SA_B0(p2,MFd2(i1),MFd2(i2)),dp) 
B1m2 = Real(SA_B1(p2,MFd2(i1),MFd2(i2)),dp) 
coupL1 = cplcFdFdVZpL(i1,i2)
coupR1 = cplcFdFdVZpR(i1,i2)
coupL2 = cplcFdFdcDpmL(i2,i1,gO2)
coupR2 = cplcFdFdcDpmR(i2,i1,gO2)
    SumI = (coupL1*coupL2+coupR1*coupR2)*MFd(i1)*(B0m2+B1m2) & 
  & + (coupL1*coupR2+coupR1*coupL2)*MFd(i2)*B1m2  
End do 
res = res +1.5_dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[Fu], Fu 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
       Do i2 = 1, 4
 Do gO2=1,2 
B0m2 = Real(SA_B0(p2,MFu2(i1),MFu2(i2)),dp) 
B1m2 = Real(SA_B1(p2,MFu2(i1),MFu2(i2)),dp) 
coupL1 = cplcFuFuVZpL(i1,i2)
coupR1 = cplcFuFuVZpR(i1,i2)
coupL2 = cplcFuFucDpmL(i2,i1,gO2)
coupR2 = cplcFuFucDpmR(i2,i1,gO2)
    SumI = (coupL1*coupL2+coupR1*coupR2)*MFu(i1)*(B0m2+B1m2) & 
  & + (coupL1*coupR2+coupR1*coupL2)*MFu(i2)*B1m2  
End do 
res = res +1.5_dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! conj[Hpm], Hpm 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
       Do i2 = 1, 4
 Do gO2=1,2 
B0m2 = Real(SA_B0(p2,MHpm2(i2),MHpm2(i1)),dp) 
B1m2 = Real(SA_B1(p2,MHpm2(i2),MHpm2(i1)),dp) 
coup1 = cplHpmcHpmVZp(i2,i1)
coup2 = cplHpmcDpmcHpm(i1,gO2,i2)
    SumI = -coup1*coup2*(B1m2+0.5_dp*B0m2)
End do 
res = res +0.5_dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! VXp, Hpm 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 Do gO2=1,2 
B0m2 = Real(SA_B0(p2,MVXp2,MHpm2(i2)),dp) 
B1m2 = Real(SA_B1(p2,MVXp2,MHpm2(i2)),dp) 
coup1 = cplHpmVXpVZp(i2)
coup2 = cplcDpmcHpmcVXp(gO2,i2)
    SumI = coup1*coup2*(B1m2-B0m2) 
End do 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! conj[VWp], conj[Hpm] 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 Do gO2=1,2 
B0m2 = Real(SA_B0(p2,MVWp2,MHpm2(i2)),dp) 
B1m2 = Real(SA_B1(p2,MVWp2,MHpm2(i2)),dp) 
coup1 = cplcHpmcVWpVZp(i2)
coup2 = cplHpmcDpmVWp(i2,gO2)
    SumI = coup1*coup2*(B1m2-B0m2) 
End do 
res = res +1._dp* SumI  
    End Do 
 res = oo16pi2*res 
 
End Subroutine Pi1LoopVZpDpm 
 
Subroutine DerPi1LoopVZpDpm(p2,MFd,MFd2,MFu,MFu2,MHpm,MHpm2,MVWp,MVWp2,               & 
& MVXp,MVXp2,cplcDpmcHpmcVXp,cplcFdFdcDpmL,cplcFdFdcDpmR,cplcFdFdVZpL,cplcFdFdVZpR,      & 
& cplcFuFucDpmL,cplcFuFucDpmR,cplcFuFuVZpL,cplcFuFuVZpR,cplcHpmcVWpVZp,cplHpmcDpmcHpm,   & 
& cplHpmcDpmVWp,cplHpmcHpmVZp,cplHpmVXpVZp,kont,res)

Implicit None 
Real(dp), Intent(in) :: MFd(5),MFd2(5),MFu(4),MFu2(4),MHpm(4),MHpm2(4),MVWp,MVWp2,MVXp,MVXp2

Complex(dp), Intent(in) :: cplcDpmcHpmcVXp(2,4),cplcFdFdcDpmL(5,5,2),cplcFdFdcDpmR(5,5,2),cplcFdFdVZpL(5,5),     & 
& cplcFdFdVZpR(5,5),cplcFuFucDpmL(4,4,2),cplcFuFucDpmR(4,4,2),cplcFuFuVZpL(4,4),         & 
& cplcFuFuVZpR(4,4),cplcHpmcVWpVZp(4),cplHpmcDpmcHpm(4,2,4),cplHpmcDpmVWp(4,2),          & 
& cplHpmcHpmVZp(4,4),cplHpmVXpVZp(4)

Integer, Intent(inout) :: kont 
Real(dp) :: B0m2, F0m2, G0m2, B1m2, H0m2, B22m2, m1, m2 
Real(dp), Intent(in) :: p2 
Complex(dp) :: A0m2 
Complex(dp), Intent(inout) :: res(2) 
Complex(dp) :: coupL1, coupR1, coupL2,coupR2, coup1,coup2, coup3, temp, sumI 
Integer :: i1,i2,i3,i4, gO1, gO2, ierr 
 
 
Real(dp) ::MVG,MVP,MVG2,MVP2
MVG = Mass_Regulator_PhotonGluon 
MVP = Mass_Regulator_PhotonGluon 
MVG2 = Mass_Regulator_PhotonGluon**2 
MVP2 = Mass_Regulator_PhotonGluon**2 

res = 0._dp 
 
!------------------------ 
! bar[Fd], Fd 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 5
       Do i2 = 1, 5
 Do gO2=1,2 
B0m2 = Real(SA_DerB0(p2,MFd2(i1),MFd2(i2)),dp) 
B1m2 = Real(SA_DerB1(p2,MFd2(i1),MFd2(i2)),dp) 
coupL1 = cplcFdFdVZpL(i1,i2)
coupR1 = cplcFdFdVZpR(i1,i2)
coupL2 = cplcFdFdcDpmL(i2,i1,gO2)
coupR2 = cplcFdFdcDpmR(i2,i1,gO2)
    SumI = (coupL1*coupL2+coupR1*coupR2)*MFd(i1)*(B0m2+B1m2) & 
  & + (coupL1*coupR2+coupR1*coupL2)*MFd(i2)*B1m2  
End do 
res = res +1.5_dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! bar[Fu], Fu 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
       Do i2 = 1, 4
 Do gO2=1,2 
B0m2 = Real(SA_DerB0(p2,MFu2(i1),MFu2(i2)),dp) 
B1m2 = Real(SA_DerB1(p2,MFu2(i1),MFu2(i2)),dp) 
coupL1 = cplcFuFuVZpL(i1,i2)
coupR1 = cplcFuFuVZpR(i1,i2)
coupL2 = cplcFuFucDpmL(i2,i1,gO2)
coupR2 = cplcFuFucDpmR(i2,i1,gO2)
    SumI = (coupL1*coupL2+coupR1*coupR2)*MFu(i1)*(B0m2+B1m2) & 
  & + (coupL1*coupR2+coupR1*coupL2)*MFu(i2)*B1m2  
End do 
res = res +1.5_dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! conj[Hpm], Hpm 
!------------------------ 
sumI = 0._dp 
 
    Do i1 = 1, 4
       Do i2 = 1, 4
 Do gO2=1,2 
B0m2 = Real(SA_DerB0(p2,MHpm2(i2),MHpm2(i1)),dp) 
B1m2 = Real(SA_DerB1(p2,MHpm2(i2),MHpm2(i1)),dp) 
coup1 = cplHpmcHpmVZp(i2,i1)
coup2 = cplHpmcDpmcHpm(i1,gO2,i2)
    SumI = -coup1*coup2*(B1m2+0.5_dp*B0m2)
End do 
res = res +0.5_dp* SumI  
      End Do 
     End Do 
 !------------------------ 
! VXp, Hpm 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 Do gO2=1,2 
B0m2 = Real(SA_DerB0(p2,MVXp2,MHpm2(i2)),dp) 
B1m2 = Real(SA_DerB1(p2,MVXp2,MHpm2(i2)),dp) 
coup1 = cplHpmVXpVZp(i2)
coup2 = cplcDpmcHpmcVXp(gO2,i2)
    SumI = coup1*coup2*(B1m2-B0m2) 
End do 
res = res +1._dp* SumI  
    End Do 
 !------------------------ 
! conj[VWp], conj[Hpm] 
!------------------------ 
sumI = 0._dp 
 
      Do i2 = 1, 4
 Do gO2=1,2 
B0m2 = Real(SA_DerB0(p2,MVWp2,MHpm2(i2)),dp) 
B1m2 = Real(SA_DerB1(p2,MVWp2,MHpm2(i2)),dp) 
coup1 = cplcHpmcVWpVZp(i2)
coup2 = cplHpmcDpmVWp(i2,gO2)
    SumI = coup1*coup2*(B1m2-B0m2) 
End do 
res = res +1._dp* SumI  
    End Do 
 res = oo16pi2*res 
 
End Subroutine DerPi1LoopVZpDpm 
 
End Module LoopMasses_331v3 
