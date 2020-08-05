! -----------------------------------------------------------------------------  
! This file was automatically created by SARAH version 4.14.3 
! SARAH References: arXiv:0806.0538, 0909.2863, 1002.0840, 1207.0906, 1309.7223  
! (c) Florian Staub, 2013  
! ------------------------------------------------------------------------------  
! File created at 16:43 on 3.7.2020   
! ----------------------------------------------------------------------  
 
 
Module TreeLevelDecays_331v3
 
Use Control 
Use DecayFunctions 
Use Settings 
Use LoopCouplings_331v3 
Use CouplingsForDecays_331v3 
Use Model_Data_331v3 
Use Mathematics, Only: Li2 
 
 Contains 
 
  
Subroutine FuTwoBodyDecay(i_in,deltaM,MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,               & 
& MFe2,MFu,MFu2,Mhh,Mhh2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,           & 
& TW,Ud,Ue,Uu,Vd,Ve,Vu,ZA,ZH,ZP,ZW,zy,ZZ,g1,g2,g3,l1,l12,l13,l12t,l13t,l2,               & 
& l23,l23t,l3,hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,           & 
& hUp2,hd3,hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,Vn,v1,v2,gPartial,gT,BR)

Implicit None 
 
Real(dp),Intent(in) :: g1,g2,g3,ftri,mu12,mu22,mu32,Vn,v1,v2,MAh(3),MAh2(3),MDpm(2),MDpm2(2),MFd(5),         & 
& MFd2(5),MFe(3),MFe2(3),MFu(4),MFu2(4),Mhh(3),Mhh2(3),MHpm(4),MHpm2(4),MVWp,            & 
& MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,TW

Complex(dp),Intent(in) :: l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,hll1(3,3),hdp11(3),hd1(3),hdtp11(2),              & 
& hdt1(2),hup11(3),hUp1,hdp1(3),hd2(3),hdtp1(2),hdt2(2),hup21(3),hUp2,hd3(3),            & 
& hdt3(2),hu11(3),h12(3),hU1,hU2,Ud(5,5),Ue(3,3),Uu(4,4),Vd(5,5),Ve(3,3),Vu(4,4),        & 
& ZA(3,3),ZH(3,3),ZP(4,4),ZW(4,4),zy(2,2),ZZ(3,3)

Complex(dp) :: cplcFuFuAhL(4,4,3),cplcFuFuAhR(4,4,3),cplcFuFuDpmL(4,4,2),cplcFuFuDpmR(4,4,2),        & 
& cplcFuFdVWpL(4,5),cplcFuFdVWpR(4,5),cplcFuFdVXpL(4,5),cplcFuFdVXpR(4,5),               & 
& cplcFuFdcHpmL(4,5,4),cplcFuFdcHpmR(4,5,4),cplcFuFuhhL(4,4,3),cplcFuFuhhR(4,4,3),       & 
& cplcFuFuVZL(4,4),cplcFuFuVZR(4,4),cplcFuFuVZpL(4,4),cplcFuFuVZpR(4,4),cplcFuFucDpmL(4,4,2),& 
& cplcFuFucDpmR(4,4,2)

Integer, Intent(in) :: i_in 
Real(dp), Intent(inout) :: gPartial(:,:), gT(:) 
Real(dp), Intent(in) :: deltaM 
Real(dp), Optional, Intent(inout) :: BR(:,:) 
Integer :: i1, i2, i3, i4, i_start, i_end, i_count, gt1, gt2, gt3, gt4 
Real(dp) :: gam, m_in, m1out, m2out, coupReal 
Complex(dp) :: coupC, coupR, coupL, coup 
 
Iname = Iname + 1 
NameOfUnit(Iname) = 'FuTwoBodyDecay'
 
If (i_in.Lt.0) Then 
  i_start = 1 
  i_end = 4
  gT = 0._dp 
  gPartial = 0._dp 
Else If ( (i_in.Ge.1).And.(i_in.Le.4) ) Then 
  i_start = i_in 
  i_end = i_in 
  gT(i_in) = 0._dp 
  gPartial(i_in,:) = 0._dp 
Else 
  If (ErrorLevel.Ge.-1) Then 
     Write(ErrCan,*) 'Problem in subroutine '//NameOfUnit(Iname) 
     Write(ErrCan,*) 'Value of i_in out of range, (i_in,i_max) = ', i_in,4

     Write(*,*) 'Problem in subroutine '//NameOfUnit(Iname) 
     Write(*,*) 'Value of i_in out of range, (i_in,i_max) = ', i_in,4

  End If 
  If (ErrorLevel.Gt.0) Call TerminateProgram 
  If (Present(BR)) BR = 0._dp 
  Iname = Iname -1 
  Return 
End If 
 
Do i1=i_start,i_end 
m_in = MFu(i1) 
If (m_in.Eq.0._dp) Cycle 
Call CouplingsFor_Fu_decays_2B(m_in,i1,MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,              & 
& MFe2,MFu,MFu2,Mhh,Mhh2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,           & 
& TW,Ud,Ue,Uu,Vd,Ve,Vu,ZA,ZH,ZP,ZW,zy,ZZ,g1,g2,g3,l1,l12,l13,l12t,l13t,l2,               & 
& l23,l23t,l3,hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,           & 
& hUp2,hd3,hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,Vn,v1,v2,cplcFuFuAhL,               & 
& cplcFuFuAhR,cplcFuFuDpmL,cplcFuFuDpmR,cplcFuFdVWpL,cplcFuFdVWpR,cplcFuFdVXpL,          & 
& cplcFuFdVXpR,cplcFuFdcHpmL,cplcFuFdcHpmR,cplcFuFuhhL,cplcFuFuhhR,cplcFuFuVZL,          & 
& cplcFuFuVZR,cplcFuFuVZpL,cplcFuFuVZpR,cplcFuFucDpmL,cplcFuFucDpmR,deltaM)

i_count = 1 

 
! ----------------------------------------------
! Fu, Ah
! ----------------------------------------------

 
Do gt1= 1, 4
  Do gt2=3, 3
m1out = MFu(gt1)
m2out = MAh(gt2)
coupL = cplcFuFuAhL(i1,gt1,gt2)
coupR = cplcFuFuAhR(i1,gt1,gt2)
Call FermionToFermionScalar(m_in,m1out,m2out,coupL,coupR,gam) 
gPartial(i1,i_count) = 1*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
i_count = i_count +1 
  End Do 
End Do 
 

 
! ----------------------------------------------
! Fu, Dpm
! ----------------------------------------------

 
Do gt1= 1, 4
  Do gt2=1, 2
m1out = MFu(gt1)
m2out = MDpm(gt2)
coupL = cplcFuFuDpmL(i1,gt1,gt2)
coupR = cplcFuFuDpmR(i1,gt1,gt2)
Call FermionToFermionScalar(m_in,m1out,m2out,coupL,coupR,gam) 
gPartial(i1,i_count) = 1*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
i_count = i_count +1 
  End Do 
End Do 
 

 
! ----------------------------------------------
! Fd, VWp
! ----------------------------------------------

 
Do gt1= 1, 5
m1out = MFd(gt1)
m2out = MVWp
coupL = cplcFuFdVWpL(i1,gt1)
coupR = cplcFuFdVWpR(i1,gt1)
Call FermionToFermionVectorBoson(m_in,m1out,m2out,coupL,coupR,gam) 
gPartial(i1,i_count) = 1*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
If (gt1.eq.3) Then 
  BR_tWb = gPartial(i1,i_count) 
End if 
i_count = i_count +1 
  End Do 

 
! ----------------------------------------------
! Fd, VXp
! ----------------------------------------------

 
Do gt1= 1, 5
m1out = MFd(gt1)
m2out = MVXp
coupL = cplcFuFdVXpL(i1,gt1)
coupR = cplcFuFdVXpR(i1,gt1)
Call FermionToFermionVectorBoson(m_in,m1out,m2out,coupL,coupR,gam) 
gPartial(i1,i_count) = 1*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
i_count = i_count +1 
  End Do 

 
! ----------------------------------------------
! Fd, conj[Hpm]
! ----------------------------------------------

 
Do gt1= 1, 5
  Do gt2=3, 4
m1out = MFd(gt1)
m2out = MHpm(gt2)
coupL = cplcFuFdcHpmL(i1,gt1,gt2)
coupR = cplcFuFdcHpmR(i1,gt1,gt2)
Call FermionToFermionScalar(m_in,m1out,m2out,coupL,coupR,gam) 
gPartial(i1,i_count) = 1*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
If (gt1.eq.3) Then 
  BR_tHb = gPartial(i1,i_count) 
End if 
i_count = i_count +1 
  End Do 
End Do 
 

 
! ----------------------------------------------
! Fu, hh
! ----------------------------------------------

 
Do gt1= 1, 4
  Do gt2=1, 3
m1out = MFu(gt1)
m2out = Mhh(gt2)
coupL = cplcFuFuhhL(i1,gt1,gt2)
coupR = cplcFuFuhhR(i1,gt1,gt2)
Call FermionToFermionScalar(m_in,m1out,m2out,coupL,coupR,gam) 
gPartial(i1,i_count) = 1*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
i_count = i_count +1 
  End Do 
End Do 
 

 
! ----------------------------------------------
! Fu, VZ
! ----------------------------------------------

 
Do gt1= 1, 4
m1out = MFu(gt1)
m2out = MVZ
coupL = cplcFuFuVZL(i1,gt1)
coupR = cplcFuFuVZR(i1,gt1)
Call FermionToFermionVectorBoson(m_in,m1out,m2out,coupL,coupR,gam) 
gPartial(i1,i_count) = 1*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
i_count = i_count +1 
  End Do 

 
! ----------------------------------------------
! Fu, VZp
! ----------------------------------------------

 
Do gt1= 1, 4
m1out = MFu(gt1)
m2out = MVZp
coupL = cplcFuFuVZpL(i1,gt1)
coupR = cplcFuFuVZpR(i1,gt1)
Call FermionToFermionVectorBoson(m_in,m1out,m2out,coupL,coupR,gam) 
gPartial(i1,i_count) = 1*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
i_count = i_count +1 
  End Do 

 
! ----------------------------------------------
! Fu, conj[Dpm]
! ----------------------------------------------

 
Do gt1= 1, 4
  Do gt2=1, 2
m1out = MFu(gt1)
m2out = MDpm(gt2)
coupL = cplcFuFucDpmL(i1,gt1,gt2)
coupR = cplcFuFucDpmR(i1,gt1,gt2)
Call FermionToFermionScalar(m_in,m1out,m2out,coupL,coupR,gam) 
gPartial(i1,i_count) = 1*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
i_count = i_count +1 
  End Do 
End Do 
 
If ((Present(BR)).And.(gT(i1).Eq.0)) Then 
  BR(i1,:) = 0._dp 
Else If (Present(BR)) Then 
  BR(i1,:) = gPartial(i1,:)/gT(i1) 
End if 
 
End Do 
 
Iname = Iname - 1 
 
End Subroutine FuTwoBodyDecay
 
 
Subroutine FeTwoBodyDecay(i_in,deltaM,MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,               & 
& MFe2,MFu,MFu2,Mhh,Mhh2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,           & 
& TW,Ud,Ue,Uu,Vd,Ve,Vu,ZA,ZH,ZP,ZW,zy,ZZ,g1,g2,g3,l1,l12,l13,l12t,l13t,l2,               & 
& l23,l23t,l3,hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,           & 
& hUp2,hd3,hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,Vn,v1,v2,gPartial,gT,BR)

Implicit None 
 
Real(dp),Intent(in) :: g1,g2,g3,ftri,mu12,mu22,mu32,Vn,v1,v2,MAh(3),MAh2(3),MDpm(2),MDpm2(2),MFd(5),         & 
& MFd2(5),MFe(3),MFe2(3),MFu(4),MFu2(4),Mhh(3),Mhh2(3),MHpm(4),MHpm2(4),MVWp,            & 
& MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,TW

Complex(dp),Intent(in) :: l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,hll1(3,3),hdp11(3),hd1(3),hdtp11(2),              & 
& hdt1(2),hup11(3),hUp1,hdp1(3),hd2(3),hdtp1(2),hdt2(2),hup21(3),hUp2,hd3(3),            & 
& hdt3(2),hu11(3),h12(3),hU1,hU2,Ud(5,5),Ue(3,3),Uu(4,4),Vd(5,5),Ve(3,3),Vu(4,4),        & 
& ZA(3,3),ZH(3,3),ZP(4,4),ZW(4,4),zy(2,2),ZZ(3,3)

Complex(dp) :: cplcFeFeAhL(3,3,3),cplcFeFeAhR(3,3,3),cplcFeFehhL(3,3,3),cplcFeFehhR(3,3,3),          & 
& cplcFeFeVZL(3,3),cplcFeFeVZR(3,3),cplcFeFeVZpL(3,3),cplcFeFeVZpR(3,3),cplcFeFv1HpmL(3,3,4),& 
& cplcFeFv1HpmR(3,3,4),cplcFeFv1cVWpL(3,3),cplcFeFv1cVWpR(3,3),cplcFecFv1HpmL(3,3,4),    & 
& cplcFecFv1HpmR(3,3,4)

Integer, Intent(in) :: i_in 
Real(dp), Intent(inout) :: gPartial(:,:), gT(:) 
Real(dp), Intent(in) :: deltaM 
Real(dp), Optional, Intent(inout) :: BR(:,:) 
Integer :: i1, i2, i3, i4, i_start, i_end, i_count, gt1, gt2, gt3, gt4 
Real(dp) :: gam, m_in, m1out, m2out, coupReal 
Complex(dp) :: coupC, coupR, coupL, coup 
 
Iname = Iname + 1 
NameOfUnit(Iname) = 'FeTwoBodyDecay'
 
If (i_in.Lt.0) Then 
  i_start = 1 
  i_end = 3
  gT = 0._dp 
  gPartial = 0._dp 
Else If ( (i_in.Ge.1).And.(i_in.Le.3) ) Then 
  i_start = i_in 
  i_end = i_in 
  gT(i_in) = 0._dp 
  gPartial(i_in,:) = 0._dp 
Else 
  If (ErrorLevel.Ge.-1) Then 
     Write(ErrCan,*) 'Problem in subroutine '//NameOfUnit(Iname) 
     Write(ErrCan,*) 'Value of i_in out of range, (i_in,i_max) = ', i_in,3

     Write(*,*) 'Problem in subroutine '//NameOfUnit(Iname) 
     Write(*,*) 'Value of i_in out of range, (i_in,i_max) = ', i_in,3

  End If 
  If (ErrorLevel.Gt.0) Call TerminateProgram 
  If (Present(BR)) BR = 0._dp 
  Iname = Iname -1 
  Return 
End If 
 
Do i1=i_start,i_end 
m_in = MFe(i1) 
If (m_in.Eq.0._dp) Cycle 
Call CouplingsFor_Fe_decays_2B(m_in,i1,MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,              & 
& MFe2,MFu,MFu2,Mhh,Mhh2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,           & 
& TW,Ud,Ue,Uu,Vd,Ve,Vu,ZA,ZH,ZP,ZW,zy,ZZ,g1,g2,g3,l1,l12,l13,l12t,l13t,l2,               & 
& l23,l23t,l3,hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,           & 
& hUp2,hd3,hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,Vn,v1,v2,cplcFeFeAhL,               & 
& cplcFeFeAhR,cplcFeFehhL,cplcFeFehhR,cplcFeFeVZL,cplcFeFeVZR,cplcFeFeVZpL,              & 
& cplcFeFeVZpR,cplcFeFv1HpmL,cplcFeFv1HpmR,cplcFeFv1cVWpL,cplcFeFv1cVWpR,cplcFecFv1HpmL, & 
& cplcFecFv1HpmR,deltaM)

i_count = 1 

 
! ----------------------------------------------
! Fe, Ah
! ----------------------------------------------

 
Do gt1= 1, 3
  Do gt2=3, 3
m1out = MFe(gt1)
m2out = MAh(gt2)
coupL = cplcFeFeAhL(i1,gt1,gt2)
coupR = cplcFeFeAhR(i1,gt1,gt2)
Call FermionToFermionScalar(m_in,m1out,m2out,coupL,coupR,gam) 
gPartial(i1,i_count) = 1*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
i_count = i_count +1 
  End Do 
End Do 
 

 
! ----------------------------------------------
! Fe, hh
! ----------------------------------------------

 
Do gt1= 1, 3
  Do gt2=1, 3
m1out = MFe(gt1)
m2out = Mhh(gt2)
coupL = cplcFeFehhL(i1,gt1,gt2)
coupR = cplcFeFehhR(i1,gt1,gt2)
Call FermionToFermionScalar(m_in,m1out,m2out,coupL,coupR,gam) 
gPartial(i1,i_count) = 1*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
i_count = i_count +1 
  End Do 
End Do 
 

 
! ----------------------------------------------
! Fe, VZ
! ----------------------------------------------

 
Do gt1= 1, 3
m1out = MFe(gt1)
m2out = MVZ
coupL = cplcFeFeVZL(i1,gt1)
coupR = cplcFeFeVZR(i1,gt1)
Call FermionToFermionVectorBoson(m_in,m1out,m2out,coupL,coupR,gam) 
gPartial(i1,i_count) = 1*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
i_count = i_count +1 
  End Do 

 
! ----------------------------------------------
! Fe, VZp
! ----------------------------------------------

 
Do gt1= 1, 3
m1out = MFe(gt1)
m2out = MVZp
coupL = cplcFeFeVZpL(i1,gt1)
coupR = cplcFeFeVZpR(i1,gt1)
Call FermionToFermionVectorBoson(m_in,m1out,m2out,coupL,coupR,gam) 
gPartial(i1,i_count) = 1*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
i_count = i_count +1 
  End Do 

 
! ----------------------------------------------
! Fv1, Hpm
! ----------------------------------------------

 
Do gt1= 1, 3
  Do gt2=3, 4
m1out = 0._dp
m2out = MHpm(gt2)
coupL = cplcFeFv1HpmL(i1,gt1,gt2)
coupR = cplcFeFv1HpmR(i1,gt1,gt2)
Call FermionToFermionScalar(m_in,m1out,m2out,coupL,coupR,gam) 
gPartial(i1,i_count) = 1*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
i_count = i_count +1 
  End Do 
End Do 
 

 
! ----------------------------------------------
! Fv1, conj[VWp]
! ----------------------------------------------

 
Do gt1= 1, 3
m1out = 0._dp
m2out = MVWp
coupL = cplcFeFv1cVWpL(i1,gt1)
coupR = cplcFeFv1cVWpR(i1,gt1)
Call FermionToFermionVectorBoson(m_in,m1out,m2out,coupL,coupR,gam) 
gPartial(i1,i_count) = 1*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
i_count = i_count +1 
  End Do 

 
! ----------------------------------------------
! bar[Fv1], Hpm
! ----------------------------------------------

 
Do gt1= 1, 3
  Do gt2=3, 4
m1out = 0._dp
m2out = MHpm(gt2)
coupL = cplcFecFv1HpmL(i1,gt1,gt2)
coupR = cplcFecFv1HpmR(i1,gt1,gt2)
Call FermionToFermionScalar(m_in,m1out,m2out,coupL,coupR,gam) 
gPartial(i1,i_count) = 1*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
i_count = i_count +1 
  End Do 
End Do 
 
If ((Present(BR)).And.(gT(i1).Eq.0)) Then 
  BR(i1,:) = 0._dp 
Else If (Present(BR)) Then 
  BR(i1,:) = gPartial(i1,:)/gT(i1) 
End if 
 
End Do 
 
Iname = Iname - 1 
 
End Subroutine FeTwoBodyDecay
 
 
Subroutine FdTwoBodyDecay(i_in,deltaM,MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,               & 
& MFe2,MFu,MFu2,Mhh,Mhh2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,           & 
& TW,Ud,Ue,Uu,Vd,Ve,Vu,ZA,ZH,ZP,ZW,zy,ZZ,g1,g2,g3,l1,l12,l13,l12t,l13t,l2,               & 
& l23,l23t,l3,hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,           & 
& hUp2,hd3,hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,Vn,v1,v2,gPartial,gT,BR)

Implicit None 
 
Real(dp),Intent(in) :: g1,g2,g3,ftri,mu12,mu22,mu32,Vn,v1,v2,MAh(3),MAh2(3),MDpm(2),MDpm2(2),MFd(5),         & 
& MFd2(5),MFe(3),MFe2(3),MFu(4),MFu2(4),Mhh(3),Mhh2(3),MHpm(4),MHpm2(4),MVWp,            & 
& MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,TW

Complex(dp),Intent(in) :: l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,hll1(3,3),hdp11(3),hd1(3),hdtp11(2),              & 
& hdt1(2),hup11(3),hUp1,hdp1(3),hd2(3),hdtp1(2),hdt2(2),hup21(3),hUp2,hd3(3),            & 
& hdt3(2),hu11(3),h12(3),hU1,hU2,Ud(5,5),Ue(3,3),Uu(4,4),Vd(5,5),Ve(3,3),Vu(4,4),        & 
& ZA(3,3),ZH(3,3),ZP(4,4),ZW(4,4),zy(2,2),ZZ(3,3)

Complex(dp) :: cplcFdFdAhL(5,5,3),cplcFdFdAhR(5,5,3),cplcFdFdDpmL(5,5,2),cplcFdFdDpmR(5,5,2),        & 
& cplcFdFdhhL(5,5,3),cplcFdFdhhR(5,5,3),cplcFdFdVZL(5,5),cplcFdFdVZR(5,5),               & 
& cplcFdFdVZpL(5,5),cplcFdFdVZpR(5,5),cplcFdFdcDpmL(5,5,2),cplcFdFdcDpmR(5,5,2),         & 
& cplcFdFuHpmL(5,4,4),cplcFdFuHpmR(5,4,4),cplcFdFucVWpL(5,4),cplcFdFucVWpR(5,4),         & 
& cplcFdFucVXpL(5,4),cplcFdFucVXpR(5,4)

Integer, Intent(in) :: i_in 
Real(dp), Intent(inout) :: gPartial(:,:), gT(:) 
Real(dp), Intent(in) :: deltaM 
Real(dp), Optional, Intent(inout) :: BR(:,:) 
Integer :: i1, i2, i3, i4, i_start, i_end, i_count, gt1, gt2, gt3, gt4 
Real(dp) :: gam, m_in, m1out, m2out, coupReal 
Complex(dp) :: coupC, coupR, coupL, coup 
 
Iname = Iname + 1 
NameOfUnit(Iname) = 'FdTwoBodyDecay'
 
If (i_in.Lt.0) Then 
  i_start = 1 
  i_end = 5
  gT = 0._dp 
  gPartial = 0._dp 
Else If ( (i_in.Ge.1).And.(i_in.Le.5) ) Then 
  i_start = i_in 
  i_end = i_in 
  gT(i_in) = 0._dp 
  gPartial(i_in,:) = 0._dp 
Else 
  If (ErrorLevel.Ge.-1) Then 
     Write(ErrCan,*) 'Problem in subroutine '//NameOfUnit(Iname) 
     Write(ErrCan,*) 'Value of i_in out of range, (i_in,i_max) = ', i_in,5

     Write(*,*) 'Problem in subroutine '//NameOfUnit(Iname) 
     Write(*,*) 'Value of i_in out of range, (i_in,i_max) = ', i_in,5

  End If 
  If (ErrorLevel.Gt.0) Call TerminateProgram 
  If (Present(BR)) BR = 0._dp 
  Iname = Iname -1 
  Return 
End If 
 
Do i1=i_start,i_end 
m_in = MFd(i1) 
If (m_in.Eq.0._dp) Cycle 
Call CouplingsFor_Fd_decays_2B(m_in,i1,MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,              & 
& MFe2,MFu,MFu2,Mhh,Mhh2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,           & 
& TW,Ud,Ue,Uu,Vd,Ve,Vu,ZA,ZH,ZP,ZW,zy,ZZ,g1,g2,g3,l1,l12,l13,l12t,l13t,l2,               & 
& l23,l23t,l3,hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,           & 
& hUp2,hd3,hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,Vn,v1,v2,cplcFdFdAhL,               & 
& cplcFdFdAhR,cplcFdFdDpmL,cplcFdFdDpmR,cplcFdFdhhL,cplcFdFdhhR,cplcFdFdVZL,             & 
& cplcFdFdVZR,cplcFdFdVZpL,cplcFdFdVZpR,cplcFdFdcDpmL,cplcFdFdcDpmR,cplcFdFuHpmL,        & 
& cplcFdFuHpmR,cplcFdFucVWpL,cplcFdFucVWpR,cplcFdFucVXpL,cplcFdFucVXpR,deltaM)

i_count = 1 

 
! ----------------------------------------------
! Fd, Ah
! ----------------------------------------------

 
Do gt1= 1, 5
  Do gt2=3, 3
m1out = MFd(gt1)
m2out = MAh(gt2)
coupL = cplcFdFdAhL(i1,gt1,gt2)
coupR = cplcFdFdAhR(i1,gt1,gt2)
Call FermionToFermionScalar(m_in,m1out,m2out,coupL,coupR,gam) 
gPartial(i1,i_count) = 1*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
i_count = i_count +1 
  End Do 
End Do 
 

 
! ----------------------------------------------
! Fd, Dpm
! ----------------------------------------------

 
Do gt1= 1, 5
  Do gt2=1, 2
m1out = MFd(gt1)
m2out = MDpm(gt2)
coupL = cplcFdFdDpmL(i1,gt1,gt2)
coupR = cplcFdFdDpmR(i1,gt1,gt2)
Call FermionToFermionScalar(m_in,m1out,m2out,coupL,coupR,gam) 
gPartial(i1,i_count) = 1*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
i_count = i_count +1 
  End Do 
End Do 
 

 
! ----------------------------------------------
! Fd, hh
! ----------------------------------------------

 
Do gt1= 1, 5
  Do gt2=1, 3
m1out = MFd(gt1)
m2out = Mhh(gt2)
coupL = cplcFdFdhhL(i1,gt1,gt2)
coupR = cplcFdFdhhR(i1,gt1,gt2)
Call FermionToFermionScalar(m_in,m1out,m2out,coupL,coupR,gam) 
gPartial(i1,i_count) = 1*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
i_count = i_count +1 
  End Do 
End Do 
 

 
! ----------------------------------------------
! Fd, VZ
! ----------------------------------------------

 
Do gt1= 1, 5
m1out = MFd(gt1)
m2out = MVZ
coupL = cplcFdFdVZL(i1,gt1)
coupR = cplcFdFdVZR(i1,gt1)
Call FermionToFermionVectorBoson(m_in,m1out,m2out,coupL,coupR,gam) 
gPartial(i1,i_count) = 1*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
i_count = i_count +1 
  End Do 

 
! ----------------------------------------------
! Fd, VZp
! ----------------------------------------------

 
Do gt1= 1, 5
m1out = MFd(gt1)
m2out = MVZp
coupL = cplcFdFdVZpL(i1,gt1)
coupR = cplcFdFdVZpR(i1,gt1)
Call FermionToFermionVectorBoson(m_in,m1out,m2out,coupL,coupR,gam) 
gPartial(i1,i_count) = 1*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
i_count = i_count +1 
  End Do 

 
! ----------------------------------------------
! Fd, conj[Dpm]
! ----------------------------------------------

 
Do gt1= 1, 5
  Do gt2=1, 2
m1out = MFd(gt1)
m2out = MDpm(gt2)
coupL = cplcFdFdcDpmL(i1,gt1,gt2)
coupR = cplcFdFdcDpmR(i1,gt1,gt2)
Call FermionToFermionScalar(m_in,m1out,m2out,coupL,coupR,gam) 
gPartial(i1,i_count) = 1*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
i_count = i_count +1 
  End Do 
End Do 
 

 
! ----------------------------------------------
! Fu, Hpm
! ----------------------------------------------

 
Do gt1= 1, 4
  Do gt2=3, 4
m1out = MFu(gt1)
m2out = MHpm(gt2)
coupL = cplcFdFuHpmL(i1,gt1,gt2)
coupR = cplcFdFuHpmR(i1,gt1,gt2)
Call FermionToFermionScalar(m_in,m1out,m2out,coupL,coupR,gam) 
gPartial(i1,i_count) = 1*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
i_count = i_count +1 
  End Do 
End Do 
 

 
! ----------------------------------------------
! Fu, conj[VWp]
! ----------------------------------------------

 
Do gt1= 1, 4
m1out = MFu(gt1)
m2out = MVWp
coupL = cplcFdFucVWpL(i1,gt1)
coupR = cplcFdFucVWpR(i1,gt1)
Call FermionToFermionVectorBoson(m_in,m1out,m2out,coupL,coupR,gam) 
gPartial(i1,i_count) = 1*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
i_count = i_count +1 
  End Do 

 
! ----------------------------------------------
! Fu, conj[VXp]
! ----------------------------------------------

 
Do gt1= 1, 4
m1out = MFu(gt1)
m2out = MVXp
coupL = cplcFdFucVXpL(i1,gt1)
coupR = cplcFdFucVXpR(i1,gt1)
Call FermionToFermionVectorBoson(m_in,m1out,m2out,coupL,coupR,gam) 
gPartial(i1,i_count) = 1*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
i_count = i_count +1 
  End Do 
If ((Present(BR)).And.(gT(i1).Eq.0)) Then 
  BR(i1,:) = 0._dp 
Else If (Present(BR)) Then 
  BR(i1,:) = gPartial(i1,:)/gT(i1) 
End if 
 
End Do 
 
Iname = Iname - 1 
 
End Subroutine FdTwoBodyDecay
 
 
Subroutine hhTwoBodyDecay(i_in,deltaM,MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,               & 
& MFe2,MFu,MFu2,Mhh,Mhh2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,           & 
& TW,Ud,Ue,Uu,Vd,Ve,Vu,ZA,ZH,ZP,ZW,zy,ZZ,g1,g2,g3,l1,l12,l13,l12t,l13t,l2,               & 
& l23,l23t,l3,hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,           & 
& hUp2,hd3,hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,Vn,v1,v2,gPartial,gT,BR)

Implicit None 
 
Real(dp),Intent(in) :: g1,g2,g3,ftri,mu12,mu22,mu32,Vn,v1,v2,MAh(3),MAh2(3),MDpm(2),MDpm2(2),MFd(5),         & 
& MFd2(5),MFe(3),MFe2(3),MFu(4),MFu2(4),Mhh(3),Mhh2(3),MHpm(4),MHpm2(4),MVWp,            & 
& MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,TW

Complex(dp),Intent(in) :: l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,hll1(3,3),hdp11(3),hd1(3),hdtp11(2),              & 
& hdt1(2),hup11(3),hUp1,hdp1(3),hd2(3),hdtp1(2),hdt2(2),hup21(3),hUp2,hd3(3),            & 
& hdt3(2),hu11(3),h12(3),hU1,hU2,Ud(5,5),Ue(3,3),Uu(4,4),Vd(5,5),Ve(3,3),Vu(4,4),        & 
& ZA(3,3),ZH(3,3),ZP(4,4),ZW(4,4),zy(2,2),ZZ(3,3)

Complex(dp) :: cplHiggsPP(3),cplHiggsGG(3),cplHiggsZZvirt(3),cplHiggsWWvirt(3),cplAhAhhh(3,3,3),     & 
& cplAhhhhh(3,3,3),cplAhhhVZ(3,3),cplAhhhVZp(3,3),cplDpmhhcDpm(2,3,2),cplcFdFdhhL(5,5,3),& 
& cplcFdFdhhR(5,5,3),cplcFeFehhL(3,3,3),cplcFeFehhR(3,3,3),cplcFuFuhhL(4,4,3),           & 
& cplcFuFuhhR(4,4,3),cplhhhhhh(3,3,3),cplhhHpmVWp(3,4),cplhhHpmVXp(3,4),cplhhHpmcHpm(3,4,4),& 
& cplhhcVWpVWp(3),cplhhcVXpVXp(3),cplhhVZVZ(3),cplhhVZVZp(3),cplhhVZpVZp(3)

Integer, Intent(in) :: i_in 
Real(dp), Intent(inout) :: gPartial(:,:), gT(:) 
Real(dp), Intent(in) :: deltaM 
Real(dp), Optional, Intent(inout) :: BR(:,:) 
Integer :: i1, i2, i3, i4, i_start, i_end, i_count, gt1, gt2, gt3, gt4 
Real(dp) :: gam, m_in, m1out, m2out, coupReal 
Complex(dp) :: coupC, coupR, coupL, coup 
 
Real(dp) :: alpha3 
Iname = Iname + 1 
NameOfUnit(Iname) = 'hhTwoBodyDecay'
 
If (i_in.Lt.0) Then 
  i_start = 1 
  i_end = 3
  gT = 0._dp 
  gPartial = 0._dp 
Else If ( (i_in.Ge.1).And.(i_in.Le.3) ) Then 
  i_start = i_in 
  i_end = i_in 
  gT(i_in) = 0._dp 
  gPartial(i_in,:) = 0._dp 
Else 
  If (ErrorLevel.Ge.-1) Then 
     Write(ErrCan,*) 'Problem in subroutine '//NameOfUnit(Iname) 
     Write(ErrCan,*) 'Value of i_in out of range, (i_in,i_max) = ', i_in,3

     Write(*,*) 'Problem in subroutine '//NameOfUnit(Iname) 
     Write(*,*) 'Value of i_in out of range, (i_in,i_max) = ', i_in,3

  End If 
  If (ErrorLevel.Gt.0) Call TerminateProgram 
  If (Present(BR)) BR = 0._dp 
  Iname = Iname -1 
  Return 
End If 
 
Do i1=i_start,i_end 
m_in = Mhh(i1) 
If (m_in.Eq.0._dp) Cycle 
Call CouplingsFor_hh_decays_2B(m_in,i1,MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,              & 
& MFe2,MFu,MFu2,Mhh,Mhh2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,           & 
& TW,Ud,Ue,Uu,Vd,Ve,Vu,ZA,ZH,ZP,ZW,zy,ZZ,g1,g2,g3,l1,l12,l13,l12t,l13t,l2,               & 
& l23,l23t,l3,hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,           & 
& hUp2,hd3,hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,Vn,v1,v2,cplHiggsPP,cplHiggsGG,     & 
& cplHiggsZZvirt,cplHiggsWWvirt,cplAhAhhh,cplAhhhhh,cplAhhhVZ,cplAhhhVZp,cplDpmhhcDpm,   & 
& cplcFdFdhhL,cplcFdFdhhR,cplcFeFehhL,cplcFeFehhR,cplcFuFuhhL,cplcFuFuhhR,               & 
& cplhhhhhh,cplhhHpmVWp,cplhhHpmVXp,cplhhHpmcHpm,cplhhcVWpVWp,cplhhcVXpVXp,              & 
& cplhhVZVZ,cplhhVZVZp,cplhhVZpVZp,deltaM)

i_count = 1 

 
! ----------------------------------------------
! VP, VP
! ----------------------------------------------

 
m1out = 0._dp
m2out = 0._dp
gam = G_F * m_in**3 * oosqrt2 * oo128pi3 * Abs(cplHiggsPP(i1))**2 
gPartial(i1,i_count) = 1*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
i_count = i_count +1 

 
! ----------------------------------------------
! VG, VG
! ----------------------------------------------

 
m1out = 0._dp
m2out = 0._dp
gam = G_F * m_in**3 * oosqrt2 * oo36pi3 * Abs(cplHiggsGG(i1))**2 
gPartial(i1,i_count) = 1*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
i_count = i_count +1 

 
! ----------------------------------------------
! VZ, VZ
! ----------------------------------------------

 
m1out = MVZ
m2out = MVZ
If (m_in.le.2._dp*m1out) Then 
coupReal = cplHiggsZZvirt(i1)
Call ScalarToVectorBosonsVR(m_in,m1out,coupReal,gam) 
Else 
gam = 0._dp 
End if 
gPartial(i1,i_count) = 1*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
i_count = i_count +1 

 
! ----------------------------------------------
! VWp, VWp
! ----------------------------------------------

 
m1out = MVWp
m2out = MVWp
If (m_in.le.2._dp*m1out) Then 
coupReal = cplHiggsWWvirt(i1)
Call ScalarToVectorBosonsVR(m_in,m1out,coupReal,gam) 
Else 
gam = 0._dp 
End if 
gPartial(i1,i_count) = 1*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
i_count = i_count +1 

 
! ----------------------------------------------
! Ah, Ah
! ----------------------------------------------

 
Do gt1= 3, 3
  Do gt2= gt1, 3
m1out = MAh(gt1)
m2out = MAh(gt2)
coup = cplAhAhhh(gt1,gt2,i1)
Call ScalarToTwoScalars(m_in,m1out,m2out,coup,gam) 
If (gt1.ne.gt2) gam = 2._dp*gam 
gPartial(i1,i_count) = 1._dp/2._dp*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
If (gt1.eq.gt2) Then 
  BRHAA(i1,gt1) = gPartial(i1,i_count) 
End if 
  BRHAAijk(i1,gt1,gt2) = gPartial(i1,i_count) 
i_count = i_count +1 
  End Do 
End Do 
 

 
! ----------------------------------------------
! hh, Ah
! ----------------------------------------------

 
Do gt1= 1, 3
  Do gt2=3, 3
m1out = Mhh(gt1)
m2out = MAh(gt2)
coup = cplAhhhhh(gt2,i1,gt1)
Call ScalarToTwoScalars(m_in,m1out,m2out,coup,gam) 
gPartial(i1,i_count) = 1*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
  BRHHAijk(i1,gt1,gt2) = gPartial(i1,i_count) 
i_count = i_count +1 
  End Do 
End Do 
 

 
! ----------------------------------------------
! Ah, VZ
! ----------------------------------------------

 
Do gt1= 3, 3
m1out = MAh(gt1)
m2out = MVZ
coup = cplAhhhVZ(gt1,i1)
Call ScalarToScalarVectorBoson(m_in,m1out,m2out,coup,gam) 
gPartial(i1,i_count) = 1*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
  BRHAZ(i1,gt1) = gPartial(i1,i_count) 
i_count = i_count +1 
  End Do 

 
! ----------------------------------------------
! Ah, VZp
! ----------------------------------------------

 
Do gt1= 3, 3
m1out = MAh(gt1)
m2out = MVZp
coup = cplAhhhVZp(gt1,i1)
Call ScalarToScalarVectorBoson(m_in,m1out,m2out,coup,gam) 
gPartial(i1,i_count) = 1*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
i_count = i_count +1 
  End Do 

 
! ----------------------------------------------
! conj[Dpm], Dpm
! ----------------------------------------------

 
Do gt1= 1, 2
  Do gt2=1, 2
m1out = MDpm(gt1)
m2out = MDpm(gt2)
coup = cplDpmhhcDpm(gt2,i1,gt1)
Call ScalarToTwoScalars(m_in,m1out,m2out,coup,gam) 
gPartial(i1,i_count) = 1*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
i_count = i_count +1 
  End Do 
End Do 
 

 
! ----------------------------------------------
! bar[Fd], Fd
! ----------------------------------------------

 
Do gt1= 1, 5
  Do gt2=1, 5
m1out = MFd(gt1)
m2out = MFd(gt2)
coupL = cplcFdFdhhL(gt1,gt2,i1)
coupR = cplcFdFdhhR(gt1,gt2,i1)
Call ScalarToTwoFermions(m_in,m1out,m2out,coupL,coupR,gam) 
gPartial(i1,i_count) = 3*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
i_count = i_count +1 
  End Do 
End Do 
 

 
! ----------------------------------------------
! bar[Fe], Fe
! ----------------------------------------------

 
Do gt1= 1, 3
  Do gt2=1, 3
m1out = MFe(gt1)
m2out = MFe(gt2)
coupL = cplcFeFehhL(gt1,gt2,i1)
coupR = cplcFeFehhR(gt1,gt2,i1)
Call ScalarToTwoFermions(m_in,m1out,m2out,coupL,coupR,gam) 
gPartial(i1,i_count) = 1*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
i_count = i_count +1 
  End Do 
End Do 
 

 
! ----------------------------------------------
! bar[Fu], Fu
! ----------------------------------------------

 
Do gt1= 1, 4
  Do gt2=1, 4
m1out = MFu(gt1)
m2out = MFu(gt2)
coupL = cplcFuFuhhL(gt1,gt2,i1)
coupR = cplcFuFuhhR(gt1,gt2,i1)
Call ScalarToTwoFermions(m_in,m1out,m2out,coupL,coupR,gam) 
gPartial(i1,i_count) = 3*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
i_count = i_count +1 
  End Do 
End Do 
 

 
! ----------------------------------------------
! hh, hh
! ----------------------------------------------

 
Do gt1= 1, 3
  Do gt2= gt1, 3
m1out = Mhh(gt1)
m2out = Mhh(gt2)
coup = cplhhhhhh(i1,gt1,gt2)
Call ScalarToTwoScalars(m_in,m1out,m2out,coup,gam) 
If (gt1.ne.gt2) gam = 2._dp*gam 
gPartial(i1,i_count) = 1._dp/2._dp*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
If (gt1.eq.gt2) Then 
  BRHHH(i1,gt1) = gPartial(i1,i_count) 
End if 
  BRHHHijk(i1,gt1,gt2) = gPartial(i1,i_count) 
i_count = i_count +1 
  End Do 
End Do 
 

 
! ----------------------------------------------
! Hpm, VWp
! ----------------------------------------------

 
Do gt1= 3, 4
m1out = MHpm(gt1)
m2out = MVWp
coup = cplhhHpmVWp(i1,gt1)
Call ScalarToScalarVectorBoson(m_in,m1out,m2out,coup,gam) 
gPartial(i1,i_count) = 2*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
  BRHHpW(i1,gt2) = gPartial(i1,i_count) 
i_count = i_count +1 
  End Do 

 
! ----------------------------------------------
! Hpm, VXp
! ----------------------------------------------

 
Do gt1= 3, 4
m1out = MHpm(gt1)
m2out = MVXp
coup = cplhhHpmVXp(i1,gt1)
Call ScalarToScalarVectorBoson(m_in,m1out,m2out,coup,gam) 
gPartial(i1,i_count) = 2*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
i_count = i_count +1 
  End Do 

 
! ----------------------------------------------
! conj[Hpm], Hpm
! ----------------------------------------------

 
Do gt1= 3, 4
  Do gt2=3, 4
m1out = MHpm(gt1)
m2out = MHpm(gt2)
coup = cplhhHpmcHpm(i1,gt2,gt1)
Call ScalarToTwoScalars(m_in,m1out,m2out,coup,gam) 
gPartial(i1,i_count) = 1*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
i_count = i_count +1 
  End Do 
End Do 
 

 
! ----------------------------------------------
! VWp, conj[VWp]
! ----------------------------------------------

 
m1out = MVWp
m2out = MVWp
coup = cplhhcVWpVWp(i1)
Call ScalarToTwoVectorBosons(m_in,m1out,m2out,coup,gam) 
gPartial(i1,i_count) = 1*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
i_count = i_count +1 

 
! ----------------------------------------------
! VXp, conj[VXp]
! ----------------------------------------------

 
m1out = MVXp
m2out = MVXp
coup = cplhhcVXpVXp(i1)
Call ScalarToTwoVectorBosons(m_in,m1out,m2out,coup,gam) 
gPartial(i1,i_count) = 1*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
i_count = i_count +1 

 
! ----------------------------------------------
! VZ, VZ
! ----------------------------------------------

 
m1out = MVZ
m2out = MVZ
coup = cplhhVZVZ(i1)
Call ScalarToTwoVectorBosons(m_in,m1out,m2out,coup,gam) 
gPartial(i1,i_count) = 1._dp/2._dp*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
i_count = i_count +1 

 
! ----------------------------------------------
! VZ, VZp
! ----------------------------------------------

 
m1out = MVZ
m2out = MVZp
coup = cplhhVZVZp(i1)
Call ScalarToTwoVectorBosons(m_in,m1out,m2out,coup,gam) 
gPartial(i1,i_count) = 1*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
i_count = i_count +1 

 
! ----------------------------------------------
! VZp, VZp
! ----------------------------------------------

 
m1out = MVZp
m2out = MVZp
coup = cplhhVZpVZp(i1)
Call ScalarToTwoVectorBosons(m_in,m1out,m2out,coup,gam) 
gPartial(i1,i_count) = 1._dp/2._dp*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
i_count = i_count +1 
If ((Present(BR)).And.(gT(i1).Eq.0)) Then 
  BR(i1,:) = 0._dp 
Else If (Present(BR)) Then 
  BR(i1,:) = gPartial(i1,:)/gT(i1) 
End if 
 
End Do 
 
Iname = Iname - 1 
 
Contains 
 
  Real(dp) Function FFqcd(mf, mA, alpha_s)
  Implicit None
   Real(dp) , Intent(in) :: mf, mA, alpha_s
   Real(dp) :: fac, beta, beta2, ratio, R_beta_1, Ln_R_beta_1, Ln_beta

   FFqcd = 0._dp
   ratio = mf / mA
   If (ratio.Ge.0.5_dp) Return ! decay is kinematically forbitten

   If (ratio.Ge.0.495_dp) Return ! Coloumb singularity

    beta2 = 1._dp - 4._dp * ratio**2
    beta = Sqrt(beta2)
    
    R_beta_1 = (1. - beta) / (1._dp + beta)
    Ln_beta = Log(beta)
    Ln_R_beta_1 = Log(R_beta_1)

    fac = (3._dp + 34._dp * beta2 - 13._dp * beta**4) / (16._dp * beta**3)  &
      &     * (-Ln_R_beta_1)                                                &
      & + 0.375_dp * (7._dp - beta2) - 3._dp * Log(4._dp/(1._dp - beta**2)) &
      & - 4._dp * Ln_beta                                                   &
      & + (1._dp + beta**2)                                                 &
      &       * ( 4._dp * Li2(R_beta_1) + 2._dp * Li2(- R_beta_1)           &
      &         + Ln_R_beta_1 * ( 3._dp * Log(2._dp/(1._dp + beta))         &
      &                         + 2._dp * Ln_beta )  ) / beta

    fac = fac - 3._dp * Log(ratio)  ! absorb large logarithms in mass

    FFqcd = 1._dp + 5._dp * alpha_s * fac * oo3pi 

  End  Function FFqcd
End Subroutine hhTwoBodyDecay
 
 
Subroutine AhTwoBodyDecay(i_in,deltaM,MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,               & 
& MFe2,MFu,MFu2,Mhh,Mhh2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,           & 
& TW,Ud,Ue,Uu,Vd,Ve,Vu,ZA,ZH,ZP,ZW,zy,ZZ,g1,g2,g3,l1,l12,l13,l12t,l13t,l2,               & 
& l23,l23t,l3,hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,           & 
& hUp2,hd3,hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,Vn,v1,v2,gPartial,gT,BR)

Implicit None 
 
Real(dp),Intent(in) :: g1,g2,g3,ftri,mu12,mu22,mu32,Vn,v1,v2,MAh(3),MAh2(3),MDpm(2),MDpm2(2),MFd(5),         & 
& MFd2(5),MFe(3),MFe2(3),MFu(4),MFu2(4),Mhh(3),Mhh2(3),MHpm(4),MHpm2(4),MVWp,            & 
& MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,TW

Complex(dp),Intent(in) :: l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,hll1(3,3),hdp11(3),hd1(3),hdtp11(2),              & 
& hdt1(2),hup11(3),hUp1,hdp1(3),hd2(3),hdtp1(2),hdt2(2),hup21(3),hUp2,hd3(3),            & 
& hdt3(2),hu11(3),h12(3),hU1,hU2,Ud(5,5),Ue(3,3),Uu(4,4),Vd(5,5),Ve(3,3),Vu(4,4),        & 
& ZA(3,3),ZH(3,3),ZP(4,4),ZW(4,4),zy(2,2),ZZ(3,3)

Complex(dp) :: cplPseudoHiggsPP(3),cplPseudoHiggsGG(3),cplAhAhAh(3,3,3),cplAhAhhh(3,3,3),            & 
& cplAhDpmcDpm(3,2,2),cplcFdFdAhL(5,5,3),cplcFdFdAhR(5,5,3),cplcFeFeAhL(3,3,3),          & 
& cplcFeFeAhR(3,3,3),cplcFuFuAhL(4,4,3),cplcFuFuAhR(4,4,3),cplAhhhhh(3,3,3),             & 
& cplAhhhVZ(3,3),cplAhhhVZp(3,3),cplAhHpmVWp(3,4),cplAhHpmVXp(3,4),cplAhHpmcHpm(3,4,4)

Integer, Intent(in) :: i_in 
Real(dp), Intent(inout) :: gPartial(:,:), gT(:) 
Real(dp), Intent(in) :: deltaM 
Real(dp), Optional, Intent(inout) :: BR(:,:) 
Integer :: i1, i2, i3, i4, i_start, i_end, i_count, gt1, gt2, gt3, gt4 
Real(dp) :: gam, m_in, m1out, m2out, coupReal 
Complex(dp) :: coupC, coupR, coupL, coup 
 
Real(dp) :: alpha3 
Iname = Iname + 1 
NameOfUnit(Iname) = 'AhTwoBodyDecay'
 
If (i_in.Lt.0) Then 
  i_start = 3 
  i_end = 3
  gT = 0._dp 
  gPartial = 0._dp 
Else If ( (i_in.Ge.1).And.(i_in.Le.3) ) Then 
  i_start = i_in 
  i_end = i_in 
  gT(i_in) = 0._dp 
  gPartial(i_in,:) = 0._dp 
Else 
  If (ErrorLevel.Ge.-1) Then 
     Write(ErrCan,*) 'Problem in subroutine '//NameOfUnit(Iname) 
     Write(ErrCan,*) 'Value of i_in out of range, (i_in,i_max) = ', i_in,3

     Write(*,*) 'Problem in subroutine '//NameOfUnit(Iname) 
     Write(*,*) 'Value of i_in out of range, (i_in,i_max) = ', i_in,3

  End If 
  If (ErrorLevel.Gt.0) Call TerminateProgram 
  If (Present(BR)) BR = 0._dp 
  Iname = Iname -1 
  Return 
End If 
 
Do i1=i_start,i_end 
m_in = MAh(i1) 
If (m_in.Eq.0._dp) Cycle 
Call CouplingsFor_Ah_decays_2B(m_in,i1,MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,              & 
& MFe2,MFu,MFu2,Mhh,Mhh2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,           & 
& TW,Ud,Ue,Uu,Vd,Ve,Vu,ZA,ZH,ZP,ZW,zy,ZZ,g1,g2,g3,l1,l12,l13,l12t,l13t,l2,               & 
& l23,l23t,l3,hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,           & 
& hUp2,hd3,hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,Vn,v1,v2,cplPseudoHiggsPP,          & 
& cplPseudoHiggsGG,cplAhAhAh,cplAhAhhh,cplAhDpmcDpm,cplcFdFdAhL,cplcFdFdAhR,             & 
& cplcFeFeAhL,cplcFeFeAhR,cplcFuFuAhL,cplcFuFuAhR,cplAhhhhh,cplAhhhVZ,cplAhhhVZp,        & 
& cplAhHpmVWp,cplAhHpmVXp,cplAhHpmcHpm,deltaM)

i_count = 1 

 
! ----------------------------------------------
! VP, VP
! ----------------------------------------------

 
m1out = 0._dp
m2out = 0._dp
gam = G_F * m_in**3 * oosqrt2 * oo128pi3 * Abs(cplPseudoHiggsPP(i1))**2 
gPartial(i1,i_count) = 1*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
i_count = i_count +1 

 
! ----------------------------------------------
! VG, VG
! ----------------------------------------------

 
m1out = 0._dp
m2out = 0._dp
gam = G_F * m_in**3 * oosqrt2 * oo36pi3 * Abs(cplPseudoHiggsGG(i1))**2 
gPartial(i1,i_count) = 1*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
i_count = i_count +1 

 
! ----------------------------------------------
! Ah, Ah
! ----------------------------------------------

 
Do gt1= 3, 3
  Do gt2= gt1, 3
m1out = MAh(gt1)
m2out = MAh(gt2)
coup = cplAhAhAh(i1,gt1,gt2)
Call ScalarToTwoScalars(m_in,m1out,m2out,coup,gam) 
If (gt1.ne.gt2) gam = 2._dp*gam 
gPartial(i1,i_count) = 1._dp/2._dp*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
If (gt1.eq.gt2) Then 
  BRAAA(i1,gt1) = gPartial(i1,i_count) 
End if 
  BRAAAijk(i1,gt1,gt2) = gPartial(i1,i_count) 
i_count = i_count +1 
  End Do 
End Do 
 

 
! ----------------------------------------------
! hh, Ah
! ----------------------------------------------

 
Do gt1= 1, 3
  Do gt2=3, 3
m1out = Mhh(gt1)
m2out = MAh(gt2)
coup = cplAhAhhh(i1,gt2,gt1)
Call ScalarToTwoScalars(m_in,m1out,m2out,coup,gam) 
gPartial(i1,i_count) = 1*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
  BRAHAijk(i1,gt1,gt2) = gPartial(i1,i_count) 
i_count = i_count +1 
  End Do 
End Do 
 

 
! ----------------------------------------------
! conj[Dpm], Dpm
! ----------------------------------------------

 
Do gt1= 1, 2
  Do gt2=1, 2
m1out = MDpm(gt1)
m2out = MDpm(gt2)
coup = cplAhDpmcDpm(i1,gt2,gt1)
Call ScalarToTwoScalars(m_in,m1out,m2out,coup,gam) 
gPartial(i1,i_count) = 1*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
i_count = i_count +1 
  End Do 
End Do 
 

 
! ----------------------------------------------
! bar[Fd], Fd
! ----------------------------------------------

 
Do gt1= 1, 5
  Do gt2=1, 5
m1out = MFd(gt1)
m2out = MFd(gt2)
coupL = cplcFdFdAhL(gt1,gt2,i1)
coupR = cplcFdFdAhR(gt1,gt2,i1)
Call ScalarToTwoFermions(m_in,m1out,m2out,coupL,coupR,gam) 
gPartial(i1,i_count) = 3*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
i_count = i_count +1 
  End Do 
End Do 
 

 
! ----------------------------------------------
! bar[Fe], Fe
! ----------------------------------------------

 
Do gt1= 1, 3
  Do gt2=1, 3
m1out = MFe(gt1)
m2out = MFe(gt2)
coupL = cplcFeFeAhL(gt1,gt2,i1)
coupR = cplcFeFeAhR(gt1,gt2,i1)
Call ScalarToTwoFermions(m_in,m1out,m2out,coupL,coupR,gam) 
gPartial(i1,i_count) = 1*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
i_count = i_count +1 
  End Do 
End Do 
 

 
! ----------------------------------------------
! bar[Fu], Fu
! ----------------------------------------------

 
Do gt1= 1, 4
  Do gt2=1, 4
m1out = MFu(gt1)
m2out = MFu(gt2)
coupL = cplcFuFuAhL(gt1,gt2,i1)
coupR = cplcFuFuAhR(gt1,gt2,i1)
Call ScalarToTwoFermions(m_in,m1out,m2out,coupL,coupR,gam) 
gPartial(i1,i_count) = 3*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
i_count = i_count +1 
  End Do 
End Do 
 

 
! ----------------------------------------------
! hh, hh
! ----------------------------------------------

 
Do gt1= 1, 3
  Do gt2= gt1, 3
m1out = Mhh(gt1)
m2out = Mhh(gt2)
coup = cplAhhhhh(i1,gt1,gt2)
Call ScalarToTwoScalars(m_in,m1out,m2out,coup,gam) 
If (gt1.ne.gt2) gam = 2._dp*gam 
gPartial(i1,i_count) = 1._dp/2._dp*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
If (gt1.eq.gt2) Then 
  BRAHH(i1,gt1) = gPartial(i1,i_count) 
End if 
  BRAHHijk(i1,gt1,gt2) = gPartial(i1,i_count) 
i_count = i_count +1 
  End Do 
End Do 
 

 
! ----------------------------------------------
! hh, VZ
! ----------------------------------------------

 
Do gt1= 1, 3
m1out = Mhh(gt1)
m2out = MVZ
coup = cplAhhhVZ(i1,gt1)
Call ScalarToScalarVectorBoson(m_in,m1out,m2out,coup,gam) 
gPartial(i1,i_count) = 1*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
  BRAHZ(i1,gt1) = gPartial(i1,i_count) 
i_count = i_count +1 
  End Do 

 
! ----------------------------------------------
! hh, VZp
! ----------------------------------------------

 
Do gt1= 1, 3
m1out = Mhh(gt1)
m2out = MVZp
coup = cplAhhhVZp(i1,gt1)
Call ScalarToScalarVectorBoson(m_in,m1out,m2out,coup,gam) 
gPartial(i1,i_count) = 1*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
i_count = i_count +1 
  End Do 

 
! ----------------------------------------------
! Hpm, VWp
! ----------------------------------------------

 
Do gt1= 3, 4
m1out = MHpm(gt1)
m2out = MVWp
coup = cplAhHpmVWp(i1,gt1)
Call ScalarToScalarVectorBoson(m_in,m1out,m2out,coup,gam) 
gPartial(i1,i_count) = 2*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
  BRAHpW(i1,gt2) = gPartial(i1,i_count) 
i_count = i_count +1 
  End Do 

 
! ----------------------------------------------
! Hpm, VXp
! ----------------------------------------------

 
Do gt1= 3, 4
m1out = MHpm(gt1)
m2out = MVXp
coup = cplAhHpmVXp(i1,gt1)
Call ScalarToScalarVectorBoson(m_in,m1out,m2out,coup,gam) 
gPartial(i1,i_count) = 2*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
i_count = i_count +1 
  End Do 

 
! ----------------------------------------------
! conj[Hpm], Hpm
! ----------------------------------------------

 
Do gt1= 3, 4
  Do gt2=3, 4
m1out = MHpm(gt1)
m2out = MHpm(gt2)
coup = cplAhHpmcHpm(i1,gt2,gt1)
Call ScalarToTwoScalars(m_in,m1out,m2out,coup,gam) 
gPartial(i1,i_count) = 1*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
i_count = i_count +1 
  End Do 
End Do 
 
If ((Present(BR)).And.(gT(i1).Eq.0)) Then 
  BR(i1,:) = 0._dp 
Else If (Present(BR)) Then 
  BR(i1,:) = gPartial(i1,:)/gT(i1) 
End if 
 
End Do 
 
Iname = Iname - 1 
 
Contains 
 
 Real(dp) Function FFqcd(mf, mA, alpha_s)
  implicit none
   Real(dp) , Intent(in) :: mf, mA, alpha_s
   Real(dp) :: fac, beta, beta2, ratio, R_beta_1, Ln_R_beta_1, Ln_beta

   FFqcd = 0._dp
   ratio = mf / mA
   if (ratio.ge.0.5_dp) return ! decay is kinematically forbitten

   if (ratio.ge.0.495_dp) return ! Coloumb singularity

    beta2 = 1._dp - 4._dp * ratio**2
    beta = Sqrt(beta2)
    
    R_beta_1 = (1. - beta) / (1._dp + beta)
    Ln_beta = Log(beta)
    Ln_R_beta_1 = Log(R_beta_1)

    fac = (19._dp + 2._dp * beta2 + 3._dp * beta**4) / (16._dp * beta)      &
      &     * (-Ln_R_beta_1)                                                &
      & + 0.375_dp * (7._dp - beta2) - 3._dp * Log(4._dp/(1._dp - beta**2)) &
      & - 4._dp * Ln_beta                                                   &
      & + (1._dp + beta**2)                                                 &
      &       * ( 4._dp * Li2(R_beta_1) + 2._dp * Li2(- R_beta_1)           &
      &         + Ln_R_beta_1 * ( 3._dp * Log(2._dp/(1._dp + beta))         &
      &                         + 2._dp * Ln_beta )  ) / beta
    fac =  fac - 3._dp * Log(ratio)  ! absorb large logarithms in mass

    FFqcd = 1._dp + 5._dp * alpha_s * fac * oo3pi 

  end  Function FFqcd
End Subroutine AhTwoBodyDecay
 
 
Subroutine HpmTwoBodyDecay(i_in,deltaM,MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,              & 
& MFe2,MFu,MFu2,Mhh,Mhh2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,           & 
& TW,Ud,Ue,Uu,Vd,Ve,Vu,ZA,ZH,ZP,ZW,zy,ZZ,g1,g2,g3,l1,l12,l13,l12t,l13t,l2,               & 
& l23,l23t,l3,hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,           & 
& hUp2,hd3,hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,Vn,v1,v2,gPartial,gT,BR)

Implicit None 
 
Real(dp),Intent(in) :: g1,g2,g3,ftri,mu12,mu22,mu32,Vn,v1,v2,MAh(3),MAh2(3),MDpm(2),MDpm2(2),MFd(5),         & 
& MFd2(5),MFe(3),MFe2(3),MFu(4),MFu2(4),Mhh(3),Mhh2(3),MHpm(4),MHpm2(4),MVWp,            & 
& MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,TW

Complex(dp),Intent(in) :: l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,hll1(3,3),hdp11(3),hd1(3),hdtp11(2),              & 
& hdt1(2),hup11(3),hUp1,hdp1(3),hd2(3),hdtp1(2),hdt2(2),hup21(3),hUp2,hd3(3),            & 
& hdt3(2),hu11(3),h12(3),hU1,hU2,Ud(5,5),Ue(3,3),Uu(4,4),Vd(5,5),Ve(3,3),Vu(4,4),        & 
& ZA(3,3),ZH(3,3),ZP(4,4),ZW(4,4),zy(2,2),ZZ(3,3)

Complex(dp) :: cplAhHpmcHpm(3,4,4),cplAhcHpmcVWp(3,4),cplAhcHpmcVXp(3,4),cplDpmHpmcHpm(2,4,4),       & 
& cplDpmcHpmcVWp(2,4),cplcFuFdcHpmL(4,5,4),cplcFuFdcHpmR(4,5,4),cplFeFv1cHpmL(3,3,4),    & 
& cplFeFv1cHpmR(3,3,4),cplcFv1FecHpmL(3,3,4),cplcFv1FecHpmR(3,3,4),cplhhHpmcHpm(3,4,4),  & 
& cplhhcHpmcVWp(3,4),cplhhcHpmcVXp(3,4),cplHpmcHpmVZ(4,4),cplHpmcHpmVZp(4,4),            & 
& cplHpmcDpmcHpm(4,2,4),cplcHpmcVWpVZ(4),cplcHpmcVXpVZ(4),cplcHpmcVWpVZp(4),             & 
& cplcHpmcVXpVZp(4),cplcDpmcHpmcVXp(2,4)

Integer, Intent(in) :: i_in 
Real(dp), Intent(inout) :: gPartial(:,:), gT(:) 
Real(dp), Intent(in) :: deltaM 
Real(dp), Optional, Intent(inout) :: BR(:,:) 
Integer :: i1, i2, i3, i4, i_start, i_end, i_count, gt1, gt2, gt3, gt4 
Real(dp) :: gam, m_in, m1out, m2out, coupReal 
Complex(dp) :: coupC, coupR, coupL, coup 
 
Iname = Iname + 1 
NameOfUnit(Iname) = 'HpmTwoBodyDecay'
 
If (i_in.Lt.0) Then 
  i_start = 3 
  i_end = 4
  gT = 0._dp 
  gPartial = 0._dp 
Else If ( (i_in.Ge.1).And.(i_in.Le.4) ) Then 
  i_start = i_in 
  i_end = i_in 
  gT(i_in) = 0._dp 
  gPartial(i_in,:) = 0._dp 
Else 
  If (ErrorLevel.Ge.-1) Then 
     Write(ErrCan,*) 'Problem in subroutine '//NameOfUnit(Iname) 
     Write(ErrCan,*) 'Value of i_in out of range, (i_in,i_max) = ', i_in,4

     Write(*,*) 'Problem in subroutine '//NameOfUnit(Iname) 
     Write(*,*) 'Value of i_in out of range, (i_in,i_max) = ', i_in,4

  End If 
  If (ErrorLevel.Gt.0) Call TerminateProgram 
  If (Present(BR)) BR = 0._dp 
  Iname = Iname -1 
  Return 
End If 
 
Do i1=i_start,i_end 
m_in = MHpm(i1) 
If (m_in.Eq.0._dp) Cycle 
Call CouplingsFor_Hpm_decays_2B(m_in,i1,MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,             & 
& MFe2,MFu,MFu2,Mhh,Mhh2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,           & 
& TW,Ud,Ue,Uu,Vd,Ve,Vu,ZA,ZH,ZP,ZW,zy,ZZ,g1,g2,g3,l1,l12,l13,l12t,l13t,l2,               & 
& l23,l23t,l3,hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,           & 
& hUp2,hd3,hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,Vn,v1,v2,cplAhHpmcHpm,              & 
& cplAhcHpmcVWp,cplAhcHpmcVXp,cplDpmHpmcHpm,cplDpmcHpmcVWp,cplcFuFdcHpmL,cplcFuFdcHpmR,  & 
& cplFeFv1cHpmL,cplFeFv1cHpmR,cplcFv1FecHpmL,cplcFv1FecHpmR,cplhhHpmcHpm,cplhhcHpmcVWp,  & 
& cplhhcHpmcVXp,cplHpmcHpmVZ,cplHpmcHpmVZp,cplHpmcDpmcHpm,cplcHpmcVWpVZ,cplcHpmcVXpVZ,   & 
& cplcHpmcVWpVZp,cplcHpmcVXpVZp,cplcDpmcHpmcVXp,deltaM)

i_count = 1 

 
! ----------------------------------------------
! Hpm, Ah
! ----------------------------------------------

 
Do gt1= 3, 4
  Do gt2=3, 3
m1out = MHpm(gt1)
m2out = MAh(gt2)
coup = cplAhHpmcHpm(gt2,gt1,i1)
Call ScalarToTwoScalars(m_in,m1out,m2out,coup,gam) 
gPartial(i1,i_count) = 1*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
i_count = i_count +1 
  End Do 
End Do 
 

 
! ----------------------------------------------
! Ah, conj[VWp]
! ----------------------------------------------

 
Do gt1= 3, 3
m1out = MAh(gt1)
m2out = MVWp
coup = cplAhcHpmcVWp(gt1,i1)
Call ScalarToScalarVectorBoson(m_in,m1out,m2out,coup,gam) 
gPartial(i1,i_count) = 1*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
  BR_HpAW(i1,gt1) = gPartial(i1,i_count) 
i_count = i_count +1 
  End Do 

 
! ----------------------------------------------
! Ah, conj[VXp]
! ----------------------------------------------

 
Do gt1= 3, 3
m1out = MAh(gt1)
m2out = MVXp
coup = cplAhcHpmcVXp(gt1,i1)
Call ScalarToScalarVectorBoson(m_in,m1out,m2out,coup,gam) 
gPartial(i1,i_count) = 1*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
i_count = i_count +1 
  End Do 

 
! ----------------------------------------------
! Hpm, Dpm
! ----------------------------------------------

 
Do gt1= 3, 4
  Do gt2=1, 2
m1out = MHpm(gt1)
m2out = MDpm(gt2)
coup = cplDpmHpmcHpm(gt2,gt1,i1)
Call ScalarToTwoScalars(m_in,m1out,m2out,coup,gam) 
gPartial(i1,i_count) = 1*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
i_count = i_count +1 
  End Do 
End Do 
 

 
! ----------------------------------------------
! Dpm, conj[VWp]
! ----------------------------------------------

 
Do gt1= 1, 2
m1out = MDpm(gt1)
m2out = MVWp
coup = cplDpmcHpmcVWp(gt1,i1)
Call ScalarToScalarVectorBoson(m_in,m1out,m2out,coup,gam) 
gPartial(i1,i_count) = 1*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
i_count = i_count +1 
  End Do 

 
! ----------------------------------------------
! bar[Fu], Fd
! ----------------------------------------------

 
Do gt1= 1, 4
  Do gt2=1, 5
m1out = MFu(gt1)
m2out = MFd(gt2)
coupL = cplcFuFdcHpmL(gt1,gt2,i1)
coupR = cplcFuFdcHpmR(gt1,gt2,i1)
Call ScalarToTwoFermions(m_in,m1out,m2out,coupL,coupR,gam) 
gPartial(i1,i_count) = 3*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
If ((gt1.eq.2).and.(gt2.eq.3)) Then 
  BR_Hcb(i1) = gPartial(i1,i_count) 
End if 
If ((gt1.eq.2).and.(gt2.eq.2)) Then 
  BR_Hcs(i1) = gPartial(i1,i_count) 
End if 
If ((gt1.eq.3).and.(gt2.eq.3)) Then 
  BR_HpTB(i1) = gPartial(i1,i_count) 
End if 
i_count = i_count +1 
  End Do 
End Do 
 

 
! ----------------------------------------------
! Fv1, Fe
! ----------------------------------------------

 
Do gt1= 1, 3
  Do gt2=1, 3
m1out = 0._dp
m2out = MFe(gt2)
coupL = cplFeFv1cHpmL(gt2,gt1,i1)
coupR = cplFeFv1cHpmR(gt2,gt1,i1)
Call ScalarToTwoFermions(m_in,m1out,m2out,coupL,coupR,gam) 
gPartial(i1,i_count) = 1*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
If ((gt1.eq.gt2).and.(gt1.eq.3)) Then 
  BR_Htaunu(i1) = gPartial(i1,i_count) 
End if 
i_count = i_count +1 
  End Do 
End Do 
 

 
! ----------------------------------------------
! bar[Fv1], Fe
! ----------------------------------------------

 
Do gt1= 1, 3
  Do gt2=1, 3
m1out = 0._dp
m2out = MFe(gt2)
coupL = cplcFv1FecHpmL(gt1,gt2,i1)
coupR = cplcFv1FecHpmR(gt1,gt2,i1)
Call ScalarToTwoFermions(m_in,m1out,m2out,coupL,coupR,gam) 
gPartial(i1,i_count) = 1*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
If ((gt1.eq.gt2).and.(gt1.eq.3)) Then 
  BR_Htaunu(i1) = gPartial(i1,i_count) 
End if 
i_count = i_count +1 
  End Do 
End Do 
 

 
! ----------------------------------------------
! Hpm, hh
! ----------------------------------------------

 
Do gt1= 3, 4
  Do gt2=1, 3
m1out = MHpm(gt1)
m2out = Mhh(gt2)
coup = cplhhHpmcHpm(gt2,gt1,i1)
Call ScalarToTwoScalars(m_in,m1out,m2out,coup,gam) 
gPartial(i1,i_count) = 1*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
i_count = i_count +1 
  End Do 
End Do 
 

 
! ----------------------------------------------
! hh, conj[VWp]
! ----------------------------------------------

 
Do gt1= 1, 3
m1out = Mhh(gt1)
m2out = MVWp
coup = cplhhcHpmcVWp(gt1,i1)
Call ScalarToScalarVectorBoson(m_in,m1out,m2out,coup,gam) 
gPartial(i1,i_count) = 1*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
  BR_HpHW(i1,gt1) = gPartial(i1,i_count) 
i_count = i_count +1 
  End Do 

 
! ----------------------------------------------
! hh, conj[VXp]
! ----------------------------------------------

 
Do gt1= 1, 3
m1out = Mhh(gt1)
m2out = MVXp
coup = cplhhcHpmcVXp(gt1,i1)
Call ScalarToScalarVectorBoson(m_in,m1out,m2out,coup,gam) 
gPartial(i1,i_count) = 1*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
i_count = i_count +1 
  End Do 

 
! ----------------------------------------------
! Hpm, VZ
! ----------------------------------------------

 
Do gt1= 3, 4
m1out = MHpm(gt1)
m2out = MVZ
coup = cplHpmcHpmVZ(gt1,i1)
Call ScalarToScalarVectorBoson(m_in,m1out,m2out,coup,gam) 
gPartial(i1,i_count) = 1*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
i_count = i_count +1 
  End Do 

 
! ----------------------------------------------
! Hpm, VZp
! ----------------------------------------------

 
Do gt1= 3, 4
m1out = MHpm(gt1)
m2out = MVZp
coup = cplHpmcHpmVZp(gt1,i1)
Call ScalarToScalarVectorBoson(m_in,m1out,m2out,coup,gam) 
gPartial(i1,i_count) = 1*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
i_count = i_count +1 
  End Do 

 
! ----------------------------------------------
! conj[Dpm], Hpm
! ----------------------------------------------

 
Do gt1= 1, 2
  Do gt2=3, 4
m1out = MDpm(gt1)
m2out = MHpm(gt2)
coup = cplHpmcDpmcHpm(gt2,gt1,i1)
Call ScalarToTwoScalars(m_in,m1out,m2out,coup,gam) 
gPartial(i1,i_count) = 1*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
i_count = i_count +1 
  End Do 
End Do 
 

 
! ----------------------------------------------
! VZ, conj[VWp]
! ----------------------------------------------

 
m1out = MVZ
m2out = MVWp
coup = cplcHpmcVWpVZ(i1)
Call ScalarToTwoVectorBosons(m_in,m1out,m2out,coup,gam) 
gPartial(i1,i_count) = 1*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
  BR_HpWZ(i1) = gPartial(i1,i_count) 
i_count = i_count +1 

 
! ----------------------------------------------
! VZ, conj[VXp]
! ----------------------------------------------

 
m1out = MVZ
m2out = MVXp
coup = cplcHpmcVXpVZ(i1)
Call ScalarToTwoVectorBosons(m_in,m1out,m2out,coup,gam) 
gPartial(i1,i_count) = 1*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
i_count = i_count +1 

 
! ----------------------------------------------
! VZp, conj[VWp]
! ----------------------------------------------

 
m1out = MVZp
m2out = MVWp
coup = cplcHpmcVWpVZp(i1)
Call ScalarToTwoVectorBosons(m_in,m1out,m2out,coup,gam) 
gPartial(i1,i_count) = 1*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
i_count = i_count +1 

 
! ----------------------------------------------
! VZp, conj[VXp]
! ----------------------------------------------

 
m1out = MVZp
m2out = MVXp
coup = cplcHpmcVXpVZp(i1)
Call ScalarToTwoVectorBosons(m_in,m1out,m2out,coup,gam) 
gPartial(i1,i_count) = 1*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
i_count = i_count +1 

 
! ----------------------------------------------
! conj[Dpm], conj[VXp]
! ----------------------------------------------

 
Do gt1= 1, 2
m1out = MDpm(gt1)
m2out = MVXp
coup = cplcDpmcHpmcVXp(gt1,i1)
Call ScalarToScalarVectorBoson(m_in,m1out,m2out,coup,gam) 
gPartial(i1,i_count) = 1*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
i_count = i_count +1 
  End Do 
If ((Present(BR)).And.(gT(i1).Eq.0)) Then 
  BR(i1,:) = 0._dp 
Else If (Present(BR)) Then 
  BR(i1,:) = gPartial(i1,:)/gT(i1) 
End if 
 
End Do 
 
Iname = Iname - 1 
 
End Subroutine HpmTwoBodyDecay
 
 
Subroutine DpmTwoBodyDecay(i_in,deltaM,MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,              & 
& MFe2,MFu,MFu2,Mhh,Mhh2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,           & 
& TW,Ud,Ue,Uu,Vd,Ve,Vu,ZA,ZH,ZP,ZW,zy,ZZ,g1,g2,g3,l1,l12,l13,l12t,l13t,l2,               & 
& l23,l23t,l3,hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,           & 
& hUp2,hd3,hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,Vn,v1,v2,gPartial,gT,BR)

Implicit None 
 
Real(dp),Intent(in) :: g1,g2,g3,ftri,mu12,mu22,mu32,Vn,v1,v2,MAh(3),MAh2(3),MDpm(2),MDpm2(2),MFd(5),         & 
& MFd2(5),MFe(3),MFe2(3),MFu(4),MFu2(4),Mhh(3),Mhh2(3),MHpm(4),MHpm2(4),MVWp,            & 
& MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,TW

Complex(dp),Intent(in) :: l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,hll1(3,3),hdp11(3),hd1(3),hdtp11(2),              & 
& hdt1(2),hup11(3),hUp1,hdp1(3),hd2(3),hdtp1(2),hdt2(2),hup21(3),hUp2,hd3(3),            & 
& hdt3(2),hu11(3),h12(3),hU1,hU2,Ud(5,5),Ue(3,3),Uu(4,4),Vd(5,5),Ve(3,3),Vu(4,4),        & 
& ZA(3,3),ZH(3,3),ZP(4,4),ZW(4,4),zy(2,2),ZZ(3,3)

Complex(dp) :: cplAhDpmcDpm(3,2,2),cplDpmhhcDpm(2,3,2),cplDpmcDpmVZ(2,2),cplDpmcDpmVZp(2,2),         & 
& cplcFdFdcDpmL(5,5,2),cplcFdFdcDpmR(5,5,2),cplcFuFucDpmL(4,4,2),cplcFuFucDpmR(4,4,2),   & 
& cplHpmcDpmVWp(4,2),cplHpmcDpmcHpm(4,2,4),cplcDpmcVXpVWp(2),cplcDpmcHpmcVXp(2,4)

Integer, Intent(in) :: i_in 
Real(dp), Intent(inout) :: gPartial(:,:), gT(:) 
Real(dp), Intent(in) :: deltaM 
Real(dp), Optional, Intent(inout) :: BR(:,:) 
Integer :: i1, i2, i3, i4, i_start, i_end, i_count, gt1, gt2, gt3, gt4 
Real(dp) :: gam, m_in, m1out, m2out, coupReal 
Complex(dp) :: coupC, coupR, coupL, coup 
 
Iname = Iname + 1 
NameOfUnit(Iname) = 'DpmTwoBodyDecay'
 
If (i_in.Lt.0) Then 
  i_start = 1 
  i_end = 2
  gT = 0._dp 
  gPartial = 0._dp 
Else If ( (i_in.Ge.1).And.(i_in.Le.2) ) Then 
  i_start = i_in 
  i_end = i_in 
  gT(i_in) = 0._dp 
  gPartial(i_in,:) = 0._dp 
Else 
  If (ErrorLevel.Ge.-1) Then 
     Write(ErrCan,*) 'Problem in subroutine '//NameOfUnit(Iname) 
     Write(ErrCan,*) 'Value of i_in out of range, (i_in,i_max) = ', i_in,2

     Write(*,*) 'Problem in subroutine '//NameOfUnit(Iname) 
     Write(*,*) 'Value of i_in out of range, (i_in,i_max) = ', i_in,2

  End If 
  If (ErrorLevel.Gt.0) Call TerminateProgram 
  If (Present(BR)) BR = 0._dp 
  Iname = Iname -1 
  Return 
End If 
 
Do i1=i_start,i_end 
m_in = MDpm(i1) 
If (m_in.Eq.0._dp) Cycle 
Call CouplingsFor_Dpm_decays_2B(m_in,i1,MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,             & 
& MFe2,MFu,MFu2,Mhh,Mhh2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,           & 
& TW,Ud,Ue,Uu,Vd,Ve,Vu,ZA,ZH,ZP,ZW,zy,ZZ,g1,g2,g3,l1,l12,l13,l12t,l13t,l2,               & 
& l23,l23t,l3,hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,           & 
& hUp2,hd3,hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,Vn,v1,v2,cplAhDpmcDpm,              & 
& cplDpmhhcDpm,cplDpmcDpmVZ,cplDpmcDpmVZp,cplcFdFdcDpmL,cplcFdFdcDpmR,cplcFuFucDpmL,     & 
& cplcFuFucDpmR,cplHpmcDpmVWp,cplHpmcDpmcHpm,cplcDpmcVXpVWp,cplcDpmcHpmcVXp,deltaM)

i_count = 1 

 
! ----------------------------------------------
! Dpm, Ah
! ----------------------------------------------

 
Do gt1= 1, 2
  Do gt2=3, 3
m1out = MDpm(gt1)
m2out = MAh(gt2)
coup = cplAhDpmcDpm(gt2,gt1,i1)
Call ScalarToTwoScalars(m_in,m1out,m2out,coup,gam) 
gPartial(i1,i_count) = 1*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
i_count = i_count +1 
  End Do 
End Do 
 

 
! ----------------------------------------------
! hh, Dpm
! ----------------------------------------------

 
Do gt1= 1, 3
  Do gt2=1, 2
m1out = Mhh(gt1)
m2out = MDpm(gt2)
coup = cplDpmhhcDpm(gt2,gt1,i1)
Call ScalarToTwoScalars(m_in,m1out,m2out,coup,gam) 
gPartial(i1,i_count) = 1*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
i_count = i_count +1 
  End Do 
End Do 
 

 
! ----------------------------------------------
! Dpm, VZ
! ----------------------------------------------

 
Do gt1= 1, 2
m1out = MDpm(gt1)
m2out = MVZ
coup = cplDpmcDpmVZ(gt1,i1)
Call ScalarToScalarVectorBoson(m_in,m1out,m2out,coup,gam) 
gPartial(i1,i_count) = 1*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
i_count = i_count +1 
  End Do 

 
! ----------------------------------------------
! Dpm, VZp
! ----------------------------------------------

 
Do gt1= 1, 2
m1out = MDpm(gt1)
m2out = MVZp
coup = cplDpmcDpmVZp(gt1,i1)
Call ScalarToScalarVectorBoson(m_in,m1out,m2out,coup,gam) 
gPartial(i1,i_count) = 1*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
i_count = i_count +1 
  End Do 

 
! ----------------------------------------------
! bar[Fd], Fd
! ----------------------------------------------

 
Do gt1= 1, 5
  Do gt2=1, 5
m1out = MFd(gt1)
m2out = MFd(gt2)
coupL = cplcFdFdcDpmL(gt1,gt2,i1)
coupR = cplcFdFdcDpmR(gt1,gt2,i1)
Call ScalarToTwoFermions(m_in,m1out,m2out,coupL,coupR,gam) 
gPartial(i1,i_count) = 3*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
i_count = i_count +1 
  End Do 
End Do 
 

 
! ----------------------------------------------
! bar[Fu], Fu
! ----------------------------------------------

 
Do gt1= 1, 4
  Do gt2=1, 4
m1out = MFu(gt1)
m2out = MFu(gt2)
coupL = cplcFuFucDpmL(gt1,gt2,i1)
coupR = cplcFuFucDpmR(gt1,gt2,i1)
Call ScalarToTwoFermions(m_in,m1out,m2out,coupL,coupR,gam) 
gPartial(i1,i_count) = 3*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
i_count = i_count +1 
  End Do 
End Do 
 

 
! ----------------------------------------------
! Hpm, VWp
! ----------------------------------------------

 
Do gt1= 3, 4
m1out = MHpm(gt1)
m2out = MVWp
coup = cplHpmcDpmVWp(gt1,i1)
Call ScalarToScalarVectorBoson(m_in,m1out,m2out,coup,gam) 
gPartial(i1,i_count) = 1*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
i_count = i_count +1 
  End Do 

 
! ----------------------------------------------
! conj[Hpm], Hpm
! ----------------------------------------------

 
Do gt1= 3, 4
  Do gt2=3, 4
m1out = MHpm(gt1)
m2out = MHpm(gt2)
coup = cplHpmcDpmcHpm(gt2,i1,gt1)
Call ScalarToTwoScalars(m_in,m1out,m2out,coup,gam) 
gPartial(i1,i_count) = 1*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
i_count = i_count +1 
  End Do 
End Do 
 

 
! ----------------------------------------------
! VWp, conj[VXp]
! ----------------------------------------------

 
m1out = MVWp
m2out = MVXp
coup = cplcDpmcVXpVWp(i1)
Call ScalarToTwoVectorBosons(m_in,m1out,m2out,coup,gam) 
gPartial(i1,i_count) = 1*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
i_count = i_count +1 

 
! ----------------------------------------------
! conj[Hpm], conj[VXp]
! ----------------------------------------------

 
Do gt1= 3, 4
m1out = MHpm(gt1)
m2out = MVXp
coup = cplcDpmcHpmcVXp(i1,gt1)
Call ScalarToScalarVectorBoson(m_in,m1out,m2out,coup,gam) 
gPartial(i1,i_count) = 1*gam 
gT(i1) = gT(i1) + gPartial(i1,i_count) 
i_count = i_count +1 
  End Do 
If ((Present(BR)).And.(gT(i1).Eq.0)) Then 
  BR(i1,:) = 0._dp 
Else If (Present(BR)) Then 
  BR(i1,:) = gPartial(i1,:)/gT(i1) 
End if 
 
End Do 
 
Iname = Iname - 1 
 
End Subroutine DpmTwoBodyDecay
 
 
Subroutine VZTwoBodyDecay(i_in,deltaM,MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,               & 
& MFe2,MFu,MFu2,Mhh,Mhh2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,           & 
& TW,Ud,Ue,Uu,Vd,Ve,Vu,ZA,ZH,ZP,ZW,zy,ZZ,g1,g2,g3,l1,l12,l13,l12t,l13t,l2,               & 
& l23,l23t,l3,hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,           & 
& hUp2,hd3,hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,Vn,v1,v2,gPartial,gT,BR)

Implicit None 
 
Real(dp),Intent(in) :: g1,g2,g3,ftri,mu12,mu22,mu32,Vn,v1,v2,MAh(3),MAh2(3),MDpm(2),MDpm2(2),MFd(5),         & 
& MFd2(5),MFe(3),MFe2(3),MFu(4),MFu2(4),Mhh(3),Mhh2(3),MHpm(4),MHpm2(4),MVWp,            & 
& MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,TW

Complex(dp),Intent(in) :: l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,hll1(3,3),hdp11(3),hd1(3),hdtp11(2),              & 
& hdt1(2),hup11(3),hUp1,hdp1(3),hd2(3),hdtp1(2),hdt2(2),hup21(3),hUp2,hd3(3),            & 
& hdt3(2),hu11(3),h12(3),hU1,hU2,Ud(5,5),Ue(3,3),Uu(4,4),Vd(5,5),Ve(3,3),Vu(4,4),        & 
& ZA(3,3),ZH(3,3),ZP(4,4),ZW(4,4),zy(2,2),ZZ(3,3)

Complex(dp) :: cplAhhhVZ(3,3),cplDpmcDpmVZ(2,2),cplcFdFdVZL(5,5),cplcFdFdVZR(5,5),cplcFeFeVZL(3,3),  & 
& cplcFeFeVZR(3,3),cplcFuFuVZL(4,4),cplcFuFuVZR(4,4),cplcFv1Fv1VZL(3,3),cplcFv1Fv1VZR(3,3),& 
& cplhhVZVZ(3),cplhhVZVZp(3),cplHpmVWpVZ(4),cplHpmVXpVZ(4),cplHpmcHpmVZ(4,4),            & 
& cplcVWpVWpVZ,cplcVXpVXpVZ

Integer, Intent(in) :: i_in 
Real(dp), Intent(inout) :: gPartial(:,:), gT 
Real(dp), Intent(in) :: deltaM 
Real(dp), Optional, Intent(inout) :: BR(:,:) 
Integer :: i1, i2, i3, i4, i_start, i_end, i_count, gt1, gt2, gt3, gt4 
Real(dp) :: gam, m_in, m1out, m2out, coupReal 
Complex(dp) :: coupC, coupR, coupL, coup 
 
Iname = Iname + 1 
NameOfUnit(Iname) = 'VZTwoBodyDecay'
 
If (i_in.Lt.0) Then 
  i_start = 1 
  i_end = 1 
  gT = 0._dp 
  gPartial = 0._dp 
Else 
  If (ErrorLevel.Ge.-1) Then 
     Write(ErrCan,*) 'Problem in subroutine '//NameOfUnit(Iname) 
     Write(ErrCan,*) 'Value of i_in out of range, (i_in,i_max) = ', i_in,1

     Write(*,*) 'Problem in subroutine '//NameOfUnit(Iname) 
     Write(*,*) 'Value of i_in out of range, (i_in,i_max) = ', i_in,1

  End If 
  If (ErrorLevel.Gt.0) Call TerminateProgram 
  If (Present(BR)) BR = 0._dp 
  Iname = Iname -1 
  Return 
End If 
 
i1=1 
m_in = MVZ 
Call CouplingsFor_VZ_decays_2B(m_in,i1,MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,              & 
& MFe2,MFu,MFu2,Mhh,Mhh2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,           & 
& TW,Ud,Ue,Uu,Vd,Ve,Vu,ZA,ZH,ZP,ZW,zy,ZZ,g1,g2,g3,l1,l12,l13,l12t,l13t,l2,               & 
& l23,l23t,l3,hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,           & 
& hUp2,hd3,hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,Vn,v1,v2,cplAhhhVZ,cplDpmcDpmVZ,    & 
& cplcFdFdVZL,cplcFdFdVZR,cplcFeFeVZL,cplcFeFeVZR,cplcFuFuVZL,cplcFuFuVZR,               & 
& cplcFv1Fv1VZL,cplcFv1Fv1VZR,cplhhVZVZ,cplhhVZVZp,cplHpmVWpVZ,cplHpmVXpVZ,              & 
& cplHpmcHpmVZ,cplcVWpVWpVZ,cplcVXpVXpVZ,deltaM)

i_count = 1 

 
! ----------------------------------------------
! hh, Ah
! ----------------------------------------------

 
Do gt1= 1, 3
  Do gt2=3, 3
m1out = Mhh(gt1)
m2out = MAh(gt2)
coup = cplAhhhVZ(gt2,gt1)
Call VectorBosonToTwoScalars(m_in,m1out,m2out,1,coup,gam) 
gPartial(1,i_count) = 1*gam 
gT = gT + gPartial(1,i_count) 
i_count = i_count +1 
  End Do 
End Do 
 

 
! ----------------------------------------------
! conj[Dpm], Dpm
! ----------------------------------------------

 
Do gt1= 1, 2
  Do gt2=1, 2
m1out = MDpm(gt1)
m2out = MDpm(gt2)
coup = cplDpmcDpmVZ(gt2,gt1)
Call VectorBosonToTwoScalars(m_in,m1out,m2out,1,coup,gam) 
gPartial(1,i_count) = 1*gam 
gT = gT + gPartial(1,i_count) 
i_count = i_count +1 
  End Do 
End Do 
 

 
! ----------------------------------------------
! bar[Fd], Fd
! ----------------------------------------------

 
Do gt1= 1, 5
  Do gt2=1, 5
m1out = MFd(gt1)
m2out = MFd(gt2)
coupL = cplcFdFdVZL(gt1,gt2)
coupR = cplcFdFdVZR(gt1,gt2)
Call VectorBosonToTwoFermions(m_in,m1out,m2out,1,coupL,coupR,gam) 
gPartial(1,i_count) = 3*gam 
gT = gT + gPartial(1,i_count) 
i_count = i_count +1 
  End Do 
End Do 
 

 
! ----------------------------------------------
! bar[Fe], Fe
! ----------------------------------------------

 
Do gt1= 1, 3
  Do gt2=1, 3
m1out = MFe(gt1)
m2out = MFe(gt2)
coupL = cplcFeFeVZL(gt1,gt2)
coupR = cplcFeFeVZR(gt1,gt2)
Call VectorBosonToTwoFermions(m_in,m1out,m2out,1,coupL,coupR,gam) 
gPartial(1,i_count) = 1*gam 
gT = gT + gPartial(1,i_count) 
i_count = i_count +1 
  End Do 
End Do 
 

 
! ----------------------------------------------
! bar[Fu], Fu
! ----------------------------------------------

 
Do gt1= 1, 4
  Do gt2=1, 4
m1out = MFu(gt1)
m2out = MFu(gt2)
coupL = cplcFuFuVZL(gt1,gt2)
coupR = cplcFuFuVZR(gt1,gt2)
Call VectorBosonToTwoFermions(m_in,m1out,m2out,1,coupL,coupR,gam) 
gPartial(1,i_count) = 3*gam 
gT = gT + gPartial(1,i_count) 
i_count = i_count +1 
  End Do 
End Do 
 

 
! ----------------------------------------------
! bar[Fv1], Fv1
! ----------------------------------------------

 
Do gt1= 1, 3
  Do gt2=1, 3
m1out = 0._dp
m2out = 0._dp
coupL = cplcFv1Fv1VZL(gt1,gt2)
coupR = cplcFv1Fv1VZR(gt1,gt2)
Call VectorBosonToTwoFermions(m_in,m1out,m2out,1,coupL,coupR,gam) 
gPartial(1,i_count) = 1*gam 
gT = gT + gPartial(1,i_count) 
i_count = i_count +1 
  End Do 
End Do 
 

 
! ----------------------------------------------
! hh, VZ
! ----------------------------------------------

 
Do gt1= 1, 3
m1out = Mhh(gt1)
m2out = MVZ
coup = cplhhVZVZ(gt1)
Call VectorBosonToScalarAndVectorBoson(m_in,m1out,m2out,coup,gam) 
gPartial(1,i_count) = 1*gam 
gT = gT + gPartial(1,i_count) 
i_count = i_count +1 
  End Do 

 
! ----------------------------------------------
! hh, VZp
! ----------------------------------------------

 
Do gt1= 1, 3
m1out = Mhh(gt1)
m2out = MVZp
coup = cplhhVZVZp(gt1)
Call VectorBosonToScalarAndVectorBoson(m_in,m1out,m2out,coup,gam) 
gPartial(1,i_count) = 1*gam 
gT = gT + gPartial(1,i_count) 
i_count = i_count +1 
  End Do 

 
! ----------------------------------------------
! Hpm, VWp
! ----------------------------------------------

 
Do gt1= 3, 4
m1out = MHpm(gt1)
m2out = MVWp
coup = cplHpmVWpVZ(gt1)
Call VectorBosonToScalarAndVectorBoson(m_in,m1out,m2out,coup,gam) 
gPartial(1,i_count) = 2*gam 
gT = gT + gPartial(1,i_count) 
i_count = i_count +1 
  End Do 

 
! ----------------------------------------------
! Hpm, VXp
! ----------------------------------------------

 
Do gt1= 3, 4
m1out = MHpm(gt1)
m2out = MVXp
coup = cplHpmVXpVZ(gt1)
Call VectorBosonToScalarAndVectorBoson(m_in,m1out,m2out,coup,gam) 
gPartial(1,i_count) = 2*gam 
gT = gT + gPartial(1,i_count) 
i_count = i_count +1 
  End Do 

 
! ----------------------------------------------
! conj[Hpm], Hpm
! ----------------------------------------------

 
Do gt1= 3, 4
  Do gt2=3, 4
m1out = MHpm(gt1)
m2out = MHpm(gt2)
coup = cplHpmcHpmVZ(gt2,gt1)
Call VectorBosonToTwoScalars(m_in,m1out,m2out,1,coup,gam) 
gPartial(1,i_count) = 1*gam 
gT = gT + gPartial(1,i_count) 
i_count = i_count +1 
  End Do 
End Do 
 

 
! ----------------------------------------------
! VWp, conj[VWp]
! ----------------------------------------------

 
m1out = MVWp
m2out = MVWp
coup = cplcVWpVWpVZ
Call VectorBosonToTwoVectorBosons(m_in,m1out,m2out,coup,gam) 
gPartial(1,i_count) = 1*gam 
gT = gT + gPartial(1,i_count) 
i_count = i_count +1 

 
! ----------------------------------------------
! VXp, conj[VXp]
! ----------------------------------------------

 
m1out = MVXp
m2out = MVXp
coup = cplcVXpVXpVZ
Call VectorBosonToTwoVectorBosons(m_in,m1out,m2out,coup,gam) 
gPartial(1,i_count) = 1*gam 
gT = gT + gPartial(1,i_count) 
i_count = i_count +1 
If ((Present(BR)).And.(gT.Eq.0)) Then 
  BR(1,:) = 0._dp 
Else If (Present(BR)) Then 
  BR(1,:) = gPartial(1,:)/gT 
End if 
 
Iname = Iname - 1 
 
End Subroutine VZTwoBodyDecay
 
 
Subroutine VZpTwoBodyDecay(i_in,deltaM,MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,              & 
& MFe2,MFu,MFu2,Mhh,Mhh2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,           & 
& TW,Ud,Ue,Uu,Vd,Ve,Vu,ZA,ZH,ZP,ZW,zy,ZZ,g1,g2,g3,l1,l12,l13,l12t,l13t,l2,               & 
& l23,l23t,l3,hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,           & 
& hUp2,hd3,hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,Vn,v1,v2,gPartial,gT,BR)

Implicit None 
 
Real(dp),Intent(in) :: g1,g2,g3,ftri,mu12,mu22,mu32,Vn,v1,v2,MAh(3),MAh2(3),MDpm(2),MDpm2(2),MFd(5),         & 
& MFd2(5),MFe(3),MFe2(3),MFu(4),MFu2(4),Mhh(3),Mhh2(3),MHpm(4),MHpm2(4),MVWp,            & 
& MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,TW

Complex(dp),Intent(in) :: l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,hll1(3,3),hdp11(3),hd1(3),hdtp11(2),              & 
& hdt1(2),hup11(3),hUp1,hdp1(3),hd2(3),hdtp1(2),hdt2(2),hup21(3),hUp2,hd3(3),            & 
& hdt3(2),hu11(3),h12(3),hU1,hU2,Ud(5,5),Ue(3,3),Uu(4,4),Vd(5,5),Ve(3,3),Vu(4,4),        & 
& ZA(3,3),ZH(3,3),ZP(4,4),ZW(4,4),zy(2,2),ZZ(3,3)

Complex(dp) :: cplAhhhVZp(3,3),cplDpmcDpmVZp(2,2),cplcFdFdVZpL(5,5),cplcFdFdVZpR(5,5),               & 
& cplcFeFeVZpL(3,3),cplcFeFeVZpR(3,3),cplcFuFuVZpL(4,4),cplcFuFuVZpR(4,4),               & 
& cplcFv1Fv1VZpL(3,3),cplcFv1Fv1VZpR(3,3),cplhhVZVZp(3),cplhhVZpVZp(3),cplHpmVWpVZp(4),  & 
& cplHpmVXpVZp(4),cplHpmcHpmVZp(4,4),cplcVWpVWpVZp,cplcVXpVXpVZp

Integer, Intent(in) :: i_in 
Real(dp), Intent(inout) :: gPartial(:,:), gT 
Real(dp), Intent(in) :: deltaM 
Real(dp), Optional, Intent(inout) :: BR(:,:) 
Integer :: i1, i2, i3, i4, i_start, i_end, i_count, gt1, gt2, gt3, gt4 
Real(dp) :: gam, m_in, m1out, m2out, coupReal 
Complex(dp) :: coupC, coupR, coupL, coup 
 
Iname = Iname + 1 
NameOfUnit(Iname) = 'VZpTwoBodyDecay'
 
If (i_in.Lt.0) Then 
  i_start = 1 
  i_end = 1 
  gT = 0._dp 
  gPartial = 0._dp 
Else 
  If (ErrorLevel.Ge.-1) Then 
     Write(ErrCan,*) 'Problem in subroutine '//NameOfUnit(Iname) 
     Write(ErrCan,*) 'Value of i_in out of range, (i_in,i_max) = ', i_in,1

     Write(*,*) 'Problem in subroutine '//NameOfUnit(Iname) 
     Write(*,*) 'Value of i_in out of range, (i_in,i_max) = ', i_in,1

  End If 
  If (ErrorLevel.Gt.0) Call TerminateProgram 
  If (Present(BR)) BR = 0._dp 
  Iname = Iname -1 
  Return 
End If 
 
i1=1 
m_in = MVZp 
Call CouplingsFor_VZp_decays_2B(m_in,i1,MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,             & 
& MFe2,MFu,MFu2,Mhh,Mhh2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,           & 
& TW,Ud,Ue,Uu,Vd,Ve,Vu,ZA,ZH,ZP,ZW,zy,ZZ,g1,g2,g3,l1,l12,l13,l12t,l13t,l2,               & 
& l23,l23t,l3,hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,           & 
& hUp2,hd3,hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,Vn,v1,v2,cplAhhhVZp,cplDpmcDpmVZp,  & 
& cplcFdFdVZpL,cplcFdFdVZpR,cplcFeFeVZpL,cplcFeFeVZpR,cplcFuFuVZpL,cplcFuFuVZpR,         & 
& cplcFv1Fv1VZpL,cplcFv1Fv1VZpR,cplhhVZVZp,cplhhVZpVZp,cplHpmVWpVZp,cplHpmVXpVZp,        & 
& cplHpmcHpmVZp,cplcVWpVWpVZp,cplcVXpVXpVZp,deltaM)

i_count = 1 

 
! ----------------------------------------------
! hh, Ah
! ----------------------------------------------

 
Do gt1= 1, 3
  Do gt2=3, 3
m1out = Mhh(gt1)
m2out = MAh(gt2)
coup = cplAhhhVZp(gt2,gt1)
Call VectorBosonToTwoScalars(m_in,m1out,m2out,1,coup,gam) 
gPartial(1,i_count) = 1*gam 
gT = gT + gPartial(1,i_count) 
i_count = i_count +1 
  End Do 
End Do 
 

 
! ----------------------------------------------
! conj[Dpm], Dpm
! ----------------------------------------------

 
Do gt1= 1, 2
  Do gt2=1, 2
m1out = MDpm(gt1)
m2out = MDpm(gt2)
coup = cplDpmcDpmVZp(gt2,gt1)
Call VectorBosonToTwoScalars(m_in,m1out,m2out,1,coup,gam) 
gPartial(1,i_count) = 1*gam 
gT = gT + gPartial(1,i_count) 
i_count = i_count +1 
  End Do 
End Do 
 

 
! ----------------------------------------------
! bar[Fd], Fd
! ----------------------------------------------

 
Do gt1= 1, 5
  Do gt2=1, 5
m1out = MFd(gt1)
m2out = MFd(gt2)
coupL = cplcFdFdVZpL(gt1,gt2)
coupR = cplcFdFdVZpR(gt1,gt2)
Call VectorBosonToTwoFermions(m_in,m1out,m2out,1,coupL,coupR,gam) 
gPartial(1,i_count) = 3*gam 
gT = gT + gPartial(1,i_count) 
i_count = i_count +1 
  End Do 
End Do 
 

 
! ----------------------------------------------
! bar[Fe], Fe
! ----------------------------------------------

 
Do gt1= 1, 3
  Do gt2=1, 3
m1out = MFe(gt1)
m2out = MFe(gt2)
coupL = cplcFeFeVZpL(gt1,gt2)
coupR = cplcFeFeVZpR(gt1,gt2)
Call VectorBosonToTwoFermions(m_in,m1out,m2out,1,coupL,coupR,gam) 
gPartial(1,i_count) = 1*gam 
gT = gT + gPartial(1,i_count) 
i_count = i_count +1 
  End Do 
End Do 
 

 
! ----------------------------------------------
! bar[Fu], Fu
! ----------------------------------------------

 
Do gt1= 1, 4
  Do gt2=1, 4
m1out = MFu(gt1)
m2out = MFu(gt2)
coupL = cplcFuFuVZpL(gt1,gt2)
coupR = cplcFuFuVZpR(gt1,gt2)
Call VectorBosonToTwoFermions(m_in,m1out,m2out,1,coupL,coupR,gam) 
gPartial(1,i_count) = 3*gam 
gT = gT + gPartial(1,i_count) 
i_count = i_count +1 
  End Do 
End Do 
 

 
! ----------------------------------------------
! bar[Fv1], Fv1
! ----------------------------------------------

 
Do gt1= 1, 3
  Do gt2=1, 3
m1out = 0._dp
m2out = 0._dp
coupL = cplcFv1Fv1VZpL(gt1,gt2)
coupR = cplcFv1Fv1VZpR(gt1,gt2)
Call VectorBosonToTwoFermions(m_in,m1out,m2out,1,coupL,coupR,gam) 
gPartial(1,i_count) = 1*gam 
gT = gT + gPartial(1,i_count) 
i_count = i_count +1 
  End Do 
End Do 
 

 
! ----------------------------------------------
! hh, VZ
! ----------------------------------------------

 
Do gt1= 1, 3
m1out = Mhh(gt1)
m2out = MVZ
coup = cplhhVZVZp(gt1)
Call VectorBosonToScalarAndVectorBoson(m_in,m1out,m2out,coup,gam) 
gPartial(1,i_count) = 1*gam 
gT = gT + gPartial(1,i_count) 
i_count = i_count +1 
  End Do 

 
! ----------------------------------------------
! hh, VZp
! ----------------------------------------------

 
Do gt1= 1, 3
m1out = Mhh(gt1)
m2out = MVZp
coup = cplhhVZpVZp(gt1)
Call VectorBosonToScalarAndVectorBoson(m_in,m1out,m2out,coup,gam) 
gPartial(1,i_count) = 1*gam 
gT = gT + gPartial(1,i_count) 
i_count = i_count +1 
  End Do 

 
! ----------------------------------------------
! Hpm, VWp
! ----------------------------------------------

 
Do gt1= 3, 4
m1out = MHpm(gt1)
m2out = MVWp
coup = cplHpmVWpVZp(gt1)
Call VectorBosonToScalarAndVectorBoson(m_in,m1out,m2out,coup,gam) 
gPartial(1,i_count) = 2*gam 
gT = gT + gPartial(1,i_count) 
i_count = i_count +1 
  End Do 

 
! ----------------------------------------------
! Hpm, VXp
! ----------------------------------------------

 
Do gt1= 3, 4
m1out = MHpm(gt1)
m2out = MVXp
coup = cplHpmVXpVZp(gt1)
Call VectorBosonToScalarAndVectorBoson(m_in,m1out,m2out,coup,gam) 
gPartial(1,i_count) = 2*gam 
gT = gT + gPartial(1,i_count) 
i_count = i_count +1 
  End Do 

 
! ----------------------------------------------
! conj[Hpm], Hpm
! ----------------------------------------------

 
Do gt1= 3, 4
  Do gt2=3, 4
m1out = MHpm(gt1)
m2out = MHpm(gt2)
coup = cplHpmcHpmVZp(gt2,gt1)
Call VectorBosonToTwoScalars(m_in,m1out,m2out,1,coup,gam) 
gPartial(1,i_count) = 1*gam 
gT = gT + gPartial(1,i_count) 
i_count = i_count +1 
  End Do 
End Do 
 

 
! ----------------------------------------------
! VWp, conj[VWp]
! ----------------------------------------------

 
m1out = MVWp
m2out = MVWp
coup = cplcVWpVWpVZp
Call VectorBosonToTwoVectorBosons(m_in,m1out,m2out,coup,gam) 
gPartial(1,i_count) = 1*gam 
gT = gT + gPartial(1,i_count) 
i_count = i_count +1 

 
! ----------------------------------------------
! VXp, conj[VXp]
! ----------------------------------------------

 
m1out = MVXp
m2out = MVXp
coup = cplcVXpVXpVZp
Call VectorBosonToTwoVectorBosons(m_in,m1out,m2out,coup,gam) 
gPartial(1,i_count) = 1*gam 
gT = gT + gPartial(1,i_count) 
i_count = i_count +1 
If ((Present(BR)).And.(gT.Eq.0)) Then 
  BR(1,:) = 0._dp 
Else If (Present(BR)) Then 
  BR(1,:) = gPartial(1,:)/gT 
End if 
 
Iname = Iname - 1 
 
End Subroutine VZpTwoBodyDecay
 
 
Subroutine VXpTwoBodyDecay(i_in,deltaM,MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,              & 
& MFe2,MFu,MFu2,Mhh,Mhh2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,           & 
& TW,Ud,Ue,Uu,Vd,Ve,Vu,ZA,ZH,ZP,ZW,zy,ZZ,g1,g2,g3,l1,l12,l13,l12t,l13t,l2,               & 
& l23,l23t,l3,hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,           & 
& hUp2,hd3,hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,Vn,v1,v2,gPartial,gT,BR)

Implicit None 
 
Real(dp),Intent(in) :: g1,g2,g3,ftri,mu12,mu22,mu32,Vn,v1,v2,MAh(3),MAh2(3),MDpm(2),MDpm2(2),MFd(5),         & 
& MFd2(5),MFe(3),MFe2(3),MFu(4),MFu2(4),Mhh(3),Mhh2(3),MHpm(4),MHpm2(4),MVWp,            & 
& MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,TW

Complex(dp),Intent(in) :: l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,hll1(3,3),hdp11(3),hd1(3),hdtp11(2),              & 
& hdt1(2),hup11(3),hUp1,hdp1(3),hd2(3),hdtp1(2),hdt2(2),hup21(3),hUp2,hd3(3),            & 
& hdt3(2),hu11(3),h12(3),hU1,hU2,Ud(5,5),Ue(3,3),Uu(4,4),Vd(5,5),Ve(3,3),Vu(4,4),        & 
& ZA(3,3),ZH(3,3),ZP(4,4),ZW(4,4),zy(2,2),ZZ(3,3)

Complex(dp) :: cplAhcHpmcVXp(3,4),cplcFdFucVXpL(5,4),cplcFdFucVXpR(5,4),cplhhcVXpVXp(3),             & 
& cplhhcHpmcVXp(3,4),cplcDpmcVXpVWp(2),cplcVXpVXpVZ,cplcVXpVXpVZp,cplcHpmcVXpVZ(4),      & 
& cplcHpmcVXpVZp(4),cplcDpmcHpmcVXp(2,4)

Integer, Intent(in) :: i_in 
Real(dp), Intent(inout) :: gPartial(:,:), gT 
Real(dp), Intent(in) :: deltaM 
Real(dp), Optional, Intent(inout) :: BR(:,:) 
Integer :: i1, i2, i3, i4, i_start, i_end, i_count, gt1, gt2, gt3, gt4 
Real(dp) :: gam, m_in, m1out, m2out, coupReal 
Complex(dp) :: coupC, coupR, coupL, coup 
 
Iname = Iname + 1 
NameOfUnit(Iname) = 'VXpTwoBodyDecay'
 
If (i_in.Lt.0) Then 
  i_start = 1 
  i_end = 1 
  gT = 0._dp 
  gPartial = 0._dp 
Else 
  If (ErrorLevel.Ge.-1) Then 
     Write(ErrCan,*) 'Problem in subroutine '//NameOfUnit(Iname) 
     Write(ErrCan,*) 'Value of i_in out of range, (i_in,i_max) = ', i_in,1

     Write(*,*) 'Problem in subroutine '//NameOfUnit(Iname) 
     Write(*,*) 'Value of i_in out of range, (i_in,i_max) = ', i_in,1

  End If 
  If (ErrorLevel.Gt.0) Call TerminateProgram 
  If (Present(BR)) BR = 0._dp 
  Iname = Iname -1 
  Return 
End If 
 
i1=1 
m_in = MVXp 
Call CouplingsFor_VXp_decays_2B(m_in,i1,MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,             & 
& MFe2,MFu,MFu2,Mhh,Mhh2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,           & 
& TW,Ud,Ue,Uu,Vd,Ve,Vu,ZA,ZH,ZP,ZW,zy,ZZ,g1,g2,g3,l1,l12,l13,l12t,l13t,l2,               & 
& l23,l23t,l3,hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,           & 
& hUp2,hd3,hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,Vn,v1,v2,cplAhcHpmcVXp,             & 
& cplcFdFucVXpL,cplcFdFucVXpR,cplhhcVXpVXp,cplhhcHpmcVXp,cplcDpmcVXpVWp,cplcVXpVXpVZ,    & 
& cplcVXpVXpVZp,cplcHpmcVXpVZ,cplcHpmcVXpVZp,cplcDpmcHpmcVXp,deltaM)

i_count = 1 

 
! ----------------------------------------------
! conj[Hpm], Ah
! ----------------------------------------------

 
Do gt1= 3, 4
  Do gt2=3, 3
m1out = MHpm(gt1)
m2out = MAh(gt2)
coup = cplAhcHpmcVXp(gt2,gt1)
Call VectorBosonToTwoScalars(m_in,m1out,m2out,1,coup,gam) 
gPartial(1,i_count) = 1*gam 
gT = gT + gPartial(1,i_count) 
i_count = i_count +1 
  End Do 
End Do 
 

 
! ----------------------------------------------
! bar[Fd], Fu
! ----------------------------------------------

 
Do gt1= 1, 5
  Do gt2=1, 4
m1out = MFd(gt1)
m2out = MFu(gt2)
coupL = cplcFdFucVXpL(gt1,gt2)
coupR = cplcFdFucVXpR(gt1,gt2)
Call VectorBosonToTwoFermions(m_in,m1out,m2out,1,coupL,coupR,gam) 
gPartial(1,i_count) = 3*gam 
gT = gT + gPartial(1,i_count) 
i_count = i_count +1 
  End Do 
End Do 
 

 
! ----------------------------------------------
! hh, VXp
! ----------------------------------------------

 
Do gt1= 1, 3
m1out = Mhh(gt1)
m2out = MVXp
coup = cplhhcVXpVXp(gt1)
Call VectorBosonToScalarAndVectorBoson(m_in,m1out,m2out,coup,gam) 
gPartial(1,i_count) = 1*gam 
gT = gT + gPartial(1,i_count) 
i_count = i_count +1 
  End Do 

 
! ----------------------------------------------
! conj[Hpm], hh
! ----------------------------------------------

 
Do gt1= 3, 4
  Do gt2=1, 3
m1out = MHpm(gt1)
m2out = Mhh(gt2)
coup = cplhhcHpmcVXp(gt2,gt1)
Call VectorBosonToTwoScalars(m_in,m1out,m2out,1,coup,gam) 
gPartial(1,i_count) = 1*gam 
gT = gT + gPartial(1,i_count) 
i_count = i_count +1 
  End Do 
End Do 
 

 
! ----------------------------------------------
! conj[Dpm], VWp
! ----------------------------------------------

 
Do gt1= 1, 2
m1out = MDpm(gt1)
m2out = MVWp
coup = cplcDpmcVXpVWp(gt1)
Call VectorBosonToScalarAndVectorBoson(m_in,m1out,m2out,coup,gam) 
gPartial(1,i_count) = 1*gam 
gT = gT + gPartial(1,i_count) 
i_count = i_count +1 
  End Do 

 
! ----------------------------------------------
! VXp, VZ
! ----------------------------------------------

 
m1out = MVXp
m2out = MVZ
coup = cplcVXpVXpVZ
Call VectorBosonToTwoVectorBosons(m_in,m1out,m2out,coup,gam) 
gPartial(1,i_count) = 1*gam 
gT = gT + gPartial(1,i_count) 
i_count = i_count +1 

 
! ----------------------------------------------
! VXp, VZp
! ----------------------------------------------

 
m1out = MVXp
m2out = MVZp
coup = cplcVXpVXpVZp
Call VectorBosonToTwoVectorBosons(m_in,m1out,m2out,coup,gam) 
gPartial(1,i_count) = 1*gam 
gT = gT + gPartial(1,i_count) 
i_count = i_count +1 

 
! ----------------------------------------------
! conj[Hpm], VZ
! ----------------------------------------------

 
Do gt1= 3, 4
m1out = MHpm(gt1)
m2out = MVZ
coup = cplcHpmcVXpVZ(gt1)
Call VectorBosonToScalarAndVectorBoson(m_in,m1out,m2out,coup,gam) 
gPartial(1,i_count) = 1*gam 
gT = gT + gPartial(1,i_count) 
i_count = i_count +1 
  End Do 

 
! ----------------------------------------------
! conj[Hpm], VZp
! ----------------------------------------------

 
Do gt1= 3, 4
m1out = MHpm(gt1)
m2out = MVZp
coup = cplcHpmcVXpVZp(gt1)
Call VectorBosonToScalarAndVectorBoson(m_in,m1out,m2out,coup,gam) 
gPartial(1,i_count) = 1*gam 
gT = gT + gPartial(1,i_count) 
i_count = i_count +1 
  End Do 

 
! ----------------------------------------------
! conj[Hpm], conj[Dpm]
! ----------------------------------------------

 
Do gt1= 3, 4
  Do gt2=1, 2
m1out = MHpm(gt1)
m2out = MDpm(gt2)
coup = cplcDpmcHpmcVXp(gt2,gt1)
Call VectorBosonToTwoScalars(m_in,m1out,m2out,1,coup,gam) 
gPartial(1,i_count) = 1*gam 
gT = gT + gPartial(1,i_count) 
i_count = i_count +1 
  End Do 
End Do 
 
If ((Present(BR)).And.(gT.Eq.0)) Then 
  BR(1,:) = 0._dp 
Else If (Present(BR)) Then 
  BR(1,:) = gPartial(1,:)/gT 
End if 
 
Iname = Iname - 1 
 
End Subroutine VXpTwoBodyDecay
 
 
Subroutine ScalarToTwoVectorbosonsNew(mS,mV1,mV2,coup,width)
  implicit none
   real(dp), intent(in) :: mS,mV1,mV2
   real(dp), intent(out) :: width
   complex(dp), intent(in) :: coup

   real(dp) :: mSsq,mV1sq, mV2sq,kappa

   if ( abs(mS).le.( abs(mV1)+abs(mV2) ) ) then
    width = 0._dp

   elseif (mV1.eq.0._dp) then
    write(ErrCan,*) 'Server warning, in subroutine ScalarToTwoVectorbosons'
    write(ErrCan,*) 'm_V1 = 0, setting width to 0'
    width = 0._dp

   elseif (mV2.eq.0._dp) then
    write(ErrCan,*) 'Server warning, in subroutine ScalarToTwoVectorbosons'
    write(ErrCan,*) 'm_V2 = 0, setting width to 0'
    width = 0._dp


   elseif (Abs(coup).eq.0._dp) then
    width = 0._dp

   else
    mSsq = mS * mS
    mV1sq = mV1**2
    mV2sq = mV2**2
    kappa = Sqrt( (mSsq-mV1sq-mV2sq)**2 - 4._dp * mV1sq*mV2sq )/(mS**3)
    width = coup**2/(4._dp*mV1sq*mV2sq)*(mV1sq**2 + 10._dp*mV1sq*mV2sq - &
             & 2._dp*(mV1sq+mV2sq)*mSsq + mV2sq**2 +mSsq**2)
    width = oo16Pi*width*kappa

   endif

  End Subroutine ScalarToTwoVectorbosonsNew

Subroutine FermionToFermionVectorBosonMassless(mFin,mFout,mV,coupL,coupR,width)
  implicit none
   real(dp), intent(in) :: mFin,mFout,mV
   real(dp), intent(out) :: width
   complex(dp), intent(in) :: coupL, coupR


   if ( abs(mFin).le.( abs(mFout)+abs(mV) ) ) then
    width = 0._dp

   else

    width = 0.5_dp*oo16Pi*(Abs(coupL)**2 + Abs(coupR)**2)*mFin**3


   endif

  End Subroutine FermionToFermionVectorBosonMassless

End Module TreeLevelDecays_331v3 
 
