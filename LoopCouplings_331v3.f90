! -----------------------------------------------------------------------------  
! This file was automatically created by SARAH version 4.14.3 
! SARAH References: arXiv:0806.0538, 0909.2863, 1002.0840, 1207.0906, 1309.7223  
! (c) Florian Staub, 2013  
! ------------------------------------------------------------------------------  
! File created at 16:42 on 3.7.2020   
! ----------------------------------------------------------------------  
 
 
Module LoopCouplings_331v3 
 
Use Control 
Use Settings 
Use Couplings_331v3 
Use Mathematics 
Use LoopFunctions 
Use StandardModel 
 
 Contains 
 
Real(dp) Function Alpha_MSbar(Q,mW,mt) 
Implicit None 
Real(dp),Intent(in)::Q,mW 
Real(dp),Intent(in),Optional::mt 
Real(dp)::DeltaAlpha 
If (MZ_input) Then 
Alpha_MSbar=Alpha_mZ_MS 
If (Present(mt)) Then 
DeltaAlpha=-8._dp*Log(Q/mt)/(9._dp*Pi) 
Alpha_MSbar=Alpha_MSbar/(1._dp+DeltaAlpha*alpha) 
End If 
Else 
DeltaAlpha=3.5_dp*Log(Q/mW)/Pi+0.5_dp*oo3pi 
If (Present(mt)) DeltaAlpha=DeltaAlpha-8._dp*Log(Q/mt)/(9._dp*Pi) 
Alpha_MSbar=Alpha/(1._dp-Delta_Alpha_Lepton-Delta_Alpha_Hadron& 
&+DeltaAlpha*alpha) 
Alpha_MZ_MS=Alpha_MSbar 
End If 
End Function Alpha_MSbar
 
 
Real(dp) Function AlphaEwDR(Q,MVWp,MVXp,MHpm,MDpm,MFd,MFu,MFe) 
 
Real(dp),Intent(in)::Q,MVWp,MVXp,MHpm(4),MDpm(2),MFd(5),MFu(4),MFe(3)
Integer::i1 
Real(dp)::DeltaAlpha 
If (MZ_input) then 
DeltaAlpha=1._dp-Alpha/Alpha_MZ_MS! MSbar value^=mW+light fermions 
DeltaAlpha=DeltaAlpha+alpha/(6._dp*Pi)*(1._dp-rMS)! conversion to DRbar if necessary 
If (MVWp.gt.Q) Then 
DeltaAlpha=DeltaAlpha-1._dp/3._dp*Log(MVWp/ Q)*Alpha/(2._dp*pi) 
End if 
If (MVXp.gt.Q) Then 
DeltaAlpha=DeltaAlpha-1._dp/3._dp*Log(MVXp/ Q)*Alpha/(2._dp*pi) 
End if 
Do i1=3,4
If (MHpm(i1).gt.Q) Then 
DeltaAlpha=DeltaAlpha-1._dp/3._dp*Log(MHpm(i1)/ Q)*Alpha/(2._dp*pi)  
End if 
End Do 
Do i1=1,2
If (MDpm(i1).gt.Q) Then 
DeltaAlpha=DeltaAlpha-4._dp/3._dp*Log(MDpm(i1)/ Q)*Alpha/(2._dp*pi)  
End if 
End Do 
Do i1=1,5
If (MFd(i1).gt.Q) Then 
DeltaAlpha=DeltaAlpha-4._dp/9._dp*Log(MFd(i1)/ Q)*Alpha/(2._dp*pi)  
End if 
End Do 
Do i1=1,4
If (MFu(i1).gt.Q) Then 
DeltaAlpha=DeltaAlpha-16._dp/9._dp*Log(MFu(i1)/ Q)*Alpha/(2._dp*pi)  
End if 
End Do 
Do i1=1,3
If (MFe(i1).gt.Q) Then 
DeltaAlpha=DeltaAlpha-4._dp/3._dp*Log(MFe(i1)/ Q)*Alpha/(2._dp*pi)  
End if 
End Do 
Else 
DeltaAlpha=7._dp*Log(Q/mW)
If (MVWp.gt.Q) Then 
DeltaAlpha=DeltaAlpha+1._dp/3._dp*Log(MVWp/ Q)
End if 
If (MVXp.gt.Q) Then 
DeltaAlpha=DeltaAlpha+1._dp/3._dp*Log(MVXp/ Q)
End if 
Do i1=3,4
If (MHpm(i1).gt.Q) Then 
DeltaAlpha=DeltaAlpha+1._dp/3._dp*Log(MHpm(i1)/ Q) 
End if 
End Do 
Do i1=1,2
If (MDpm(i1).gt.Q) Then 
DeltaAlpha=DeltaAlpha+4._dp/3._dp*Log(MDpm(i1)/ Q) 
End if 
End Do 
Do i1=1,5
If (MFd(i1).gt.Q) Then 
DeltaAlpha=DeltaAlpha+4._dp/9._dp*Log(MFd(i1)/ Q) 
End if 
End Do 
Do i1=1,4
If (MFu(i1).gt.Q) Then 
DeltaAlpha=DeltaAlpha+16._dp/9._dp*Log(MFu(i1)/ Q) 
End if 
End Do 
Do i1=1,3
If (MFe(i1).gt.Q) Then 
DeltaAlpha=DeltaAlpha+4._dp/3._dp*Log(MFe(i1)/ Q) 
End if 
End Do 
DeltaAlpha=Delta_Alpha_Lepton+Delta_Alpha_Hadron& 
    &-alpha*DeltaAlpha/(2._dp*Pi) 
End If 
 
AlphaEwDR=Alpha/(1._dp-DeltaAlpha) 
 
End Function AlphaEwDR 
 
 
Real(dp) Function AlphaSDR(Q,MFd,MFu) 
Real(dp),Intent(in)::Q,MFd(5),MFu(4) 
Integer::i1 
Real(dp)::DeltaAlpha 
DeltaAlpha = 0._dp 
If (rMS.lt.0.5_dp) Then 
DeltaAlpha = 0.5_dp 
End if 
Do i1=1,5
 If (Abs(MFd(i1)/ Q).gt.1._dp) Then 
  DeltaAlpha=DeltaAlpha-2._dp/3._dp*Log(MFd(i1)/ Q) 
 End If 
End Do 
Do i1=1,4
 If (Abs(MFu(i1)/ Q).gt.1._dp) Then 
  DeltaAlpha=DeltaAlpha-2._dp/3._dp*Log(MFu(i1)/ Q) 
 End If 
End Do 
DeltaAlpha=AlphaS_mZ*DeltaAlpha/(2._dp*Pi) 
AlphaSDR=AlphaS_mZ/(1._dp-DeltaAlpha)
 
End Function AlphaSDR 
Real(dp) Function AlphaEW_T(AlphaEW_In, Q,MVWp,MVXp,MHpm,MDpm,MFd,MFu,MFe) 
 
Real(dp),Intent(in)::AlphaEW_In, Q,MVWp,MVXp,MHpm(4),MDpm(2),MFd(5),MFu(4),MFe(3)
Integer::i1 
Real(dp)::DeltaAlpha 
DeltaAlpha=1._dp/(6._dp)*(1._dp-rMS)! conversion to DRbar if necessary 
DeltaAlpha=DeltaAlpha+1._dp/3._dp*Log(MVXp/ Q)
Do i1=3,4
DeltaAlpha=DeltaAlpha+1._dp/3._dp*Log(MHpm(i1)/ Q) 
End Do 
Do i1=1,2
DeltaAlpha=DeltaAlpha+4._dp/3._dp*Log(MDpm(i1)/ Q) 
End Do 
DeltaAlpha=-AlphaEW_in*DeltaAlpha/(2._dp*Pi) 
AlphaEW_T=AlphaEW_in/(1._dp-DeltaAlpha) 
 
End Function AlphaEW_T 
 
 
Real(dp) Function AlphaS_T(AlphaS_In, Q,MFd,MFu) 
Real(dp),Intent(in):: AlphaS_In, Q,MFd(5),MFu(4) 
Integer::i1 
Real(dp)::DeltaAlpha 
DeltaAlpha=0._dp 
!Conversion to DR bar if necessary 
If (rMS.lt.0.5_dp) Then 
DeltaAlpha=0.5_dp 
End if
Do i1=4,5
DeltaAlpha=DeltaAlpha-2._dp/3._dp*Log(MFd(i1)/ Q) 
End Do 
Do i1=4,4
DeltaAlpha=DeltaAlpha-2._dp/3._dp*Log(MFu(i1)/ Q) 
End Do 
DeltaAlpha=AlphaS_In*DeltaAlpha/(2._dp*Pi) 
   AlphaS_T=AlphaS_In/(1._dp-DeltaAlpha)
 
End Function AlphaS_T



Subroutine DeltaVB(sinW2,sinW2_dr,rho,MAh,MFe,Mhh,MHpm,MVZp,g1,g2,h12l,               & 
& hll1,Ue,Ve,ZA,ZH,ZP,ZZ,res)

Implicit None 
Real(dp),Intent(in) :: MAh(3),MFe(3),Mhh(3),MHpm(4),MVZp,g1,g2

Complex(dp),Intent(in) :: h12l(3,3),hll1(3,3),Ue(3,3),Ve(3,3),ZA(3,3),ZH(3,3),ZP(4,4),ZZ(3,3)

Real(dp) :: MAh2(3),MFe2(3),Mhh2(3),MHpm2(4),MVZp2

Complex(dp) :: cplcFecFv1HpmL(3,3,4),cplcFecFv1HpmR(3,3,4),cplcFeFeAhL(3,3,3),cplcFeFeAhR(3,3,3),    & 
& cplcFeFehhL(3,3,3),cplcFeFehhR(3,3,3),cplcFeFeVZpL(3,3),cplcFeFeVZpR(3,3),             & 
& cplcFeFv1HpmL(3,3,4),cplcFeFv1HpmR(3,3,4),cplcFv1FecHpmL(3,3,4),cplcFv1FecHpmR(3,3,4), & 
& cplcFv1Fv1VZpL(3,3),cplcFv1Fv1VZpR(3,3),cplFeFv1cHpmL(3,3,4),cplFeFv1cHpmR(3,3,4)

Integer :: i1,i2,i3,i4,gt1,gt2,gt3,gt4 
Real(dp), Intent(in) :: sinW2,sinW2_Dr, rho 
Real(dp), Intent(out) :: res 
 
Complex(dp) :: sumI, coup1L,coup1R,coup2L,coup2R,coup3L,coup3R,coup3, coup4L,coup4R, teil 
Complex(dp) :: D27m2, D0m2, vertex, phase 
Real(dp) :: cosW2, cosW2_Dr, chargefactor 
Iname = Iname+1
NameOfUnit(Iname) = "DeltaVB" 
MAh2 = MAh**2 
MFe2 = MFe**2 
Mhh2 = Mhh**2 
MHpm2 = MHpm**2 
MVZp2 = MVZp**2 

 
 ! Fix neutrino phases 
 
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


cplcFeFeVZpL = 0._dp 
cplcFeFeVZpR = 0._dp 
Do gt1 = 1, 3
 Do gt2 = 1, 3
Call CouplingcFeFeVZpT(gt1,gt2,g1,g2,ZZ,cplcFeFeVZpL(gt1,gt2),cplcFeFeVZpR(gt1,gt2))

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


cplcFv1Fv1VZpL = 0._dp 
cplcFv1Fv1VZpR = 0._dp 
Do gt1 = 1, 3
 Do gt2 = 1, 3
Call CouplingcFv1Fv1VZpT(gt1,gt2,g2,ZZ,cplcFv1Fv1VZpL(gt1,gt2),cplcFv1Fv1VZpR(gt1,gt2))

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


!-------------------------- 
!SM Contributions 
!-------------------------- 
cosW2 = 1._dp - sinW2 
cosW2_DR = 1._dp - sinW2_DR 
sumI = 6._dp & 
  & + Log(cosW2)*(3.5_dp - 2.5_dp *sinW2   & 
  & - sinW2_DR*(5._dp - 1.5_dp*cosW2/cosW2_DR))/sinW2   
res = sumI*g2**2*rho 
 
 
If (IncludeBSMdeltaVB) Then 
!-------------------------- 
!BSM  Contributions 
!-------------------------- 
teil = 0._dp 
 
Do gt1=1,3 
 Do gt2=1,3 
sumI = 0._dp 
 
chargefactor = 1 
Do i1=1,3
  Do i2=1,4
If ((MFe2(i1).gt.mf_l2(2)).Or.(MHpm2(i2).gt.mf_l2(2))) Then
coup1L = cplFeFv1cHpmL(i1,gt1,i2)
coup1R = cplFeFv1cHpmR(i1,gt1,i2)
coup2R = Conjg(cplFeFv1cHpmL(i1,gt2,i2))
coup2L = Conjg(cplFeFv1cHpmR(i1,gt2,i2))
sumI = sumI + chargefactor*0.5_dp*coup1L*coup2R*B1(0._dp,MFe2(i1),MHpm2(i2))  
End if 
   End Do
  End Do




chargefactor = 1 
Do i1=1,4
  Do i2=1,3
If ((MHpm2(i1).gt.mf_l2(2)).Or.(MFe2(i2).gt.mf_l2(2))) Then
coup1L = cplcFeFv1HpmL(i2,gt1,i1)
coup1R = cplcFeFv1HpmR(i2,gt1,i1)
coup2R = Conjg(cplcFeFv1HpmL(i2,gt2,i1))
coup2L = Conjg(cplcFeFv1HpmR(i2,gt2,i1))
sumI = sumI + chargefactor*0.5_dp*coup1L*coup2R*B1(0._dp,MFe2(i2),MHpm2(i1))  
End if 
   End Do
  End Do




chargefactor = 1 
  Do i2=1,3
If ((MVZp2.gt.mf_l2(2)).Or.(0._dp.gt.mf_l2(2))) Then
coup1L = cplcFv1Fv1VZpL(i2,gt1)
coup1R = cplcFv1Fv1VZpR(i2,gt1)
coup2L = Conjg(cplcFv1Fv1VZpL(i2,gt2))
coup2R = Conjg(cplcFv1Fv1VZpR(i2,gt2))
End if 
  End Do




res = res + sumI*(Kronecker(gt2,1)+Kronecker(gt2,2)) 
End Do 
 
End Do 
 
Do gt1=1,2 
Do  gt2=1,3 
sumI = 0._dp 
 
chargefactor = 1 
Do i1=1,3
  Do i2=1,3
If ((MAh2(i1).gt.mf_l2(2)).Or.(MFe2(i2).gt.mf_l2(2))) Then
coup1L = cplcFeFeAhL(i2,gt1,i1)
coup1R = cplcFeFeAhR(i2,gt1,i1)
coup2R = Conjg(cplcFeFeAhL(i2,gt2,i1))
coup2L = Conjg(cplcFeFeAhR(i2,gt2,i1))
sumI = sumI + chargefactor*0.5_dp*coup1L*coup2R*B1(0._dp,MFe2(i2),MAh2(i1))  
End if 
   End Do
  End Do




chargefactor = 1 
Do i1=1,3
  Do i2=1,4
If ((0._dp.gt.mf_l2(2)).Or.(MHpm2(i2).gt.mf_l2(2))) Then
coup1L = cplFeFv1cHpmL(gt1,i1,i2)
coup1R = cplFeFv1cHpmR(gt1,i1,i2)
coup2R = Conjg(cplFeFv1cHpmL(gt2,i1,i2))
coup2L = Conjg(cplFeFv1cHpmR(gt2,i1,i2))
sumI = sumI + chargefactor*0.5_dp*coup1L*coup2R*B1(0._dp,0._dp,MHpm2(i2))  
End if 
   End Do
  End Do




chargefactor = 1 
Do i1=1,3
  Do i2=1,3
If ((Mhh2(i1).gt.mf_l2(2)).Or.(MFe2(i2).gt.mf_l2(2))) Then
coup1L = cplcFeFehhL(i2,gt1,i1)
coup1R = cplcFeFehhR(i2,gt1,i1)
coup2R = Conjg(cplcFeFehhL(i2,gt2,i1))
coup2L = Conjg(cplcFeFehhR(i2,gt2,i1))
sumI = sumI + chargefactor*0.5_dp*coup1L*coup2R*B1(0._dp,MFe2(i2),Mhh2(i1))  
End if 
   End Do
  End Do




chargefactor = 1 
  Do i2=1,3
If ((MVZp2.gt.mf_l2(2)).Or.(MFe2(i2).gt.mf_l2(2))) Then
coup1L = cplcFeFeVZpL(i2,gt1)
coup1R = cplcFeFeVZpR(i2,gt1)
coup2L = Conjg(cplcFeFeVZpL(i2,gt2))
coup2R = Conjg(cplcFeFeVZpR(i2,gt2))
End if 
  End Do




chargefactor = 1 
Do i1=1,3
  Do i2=1,4
If ((0._dp.gt.mf_l2(2)).Or.(MHpm2(i2).gt.mf_l2(2))) Then
coup1L = cplcFv1FecHpmL(i1,gt1,i2)
coup1R = cplcFv1FecHpmR(i1,gt1,i2)
coup2R = Conjg(cplcFv1FecHpmL(i1,gt2,i2))
coup2L = Conjg(cplcFv1FecHpmR(i1,gt2,i2))
sumI = sumI + chargefactor*0.5_dp*coup1L*coup2R*B1(0._dp,0._dp,MHpm2(i2))  
End if 
   End Do
  End Do




res = res + sumI 
End Do 
 
End Do 
 
vertex = 0._dp 
 
Do gt1=1,3 
 Do gt2=1,2 
 End Do 
 
End Do 
 
res = res + vertex/g2 
Do gt1=1,3 
 Do gt2=1,3 
gt3 = 2 
gt4 = 1 
! Fe,Hpm,Fv1,Hpm
chargefactor = 1 
Do i1=1,3
  Do i2=1,4
    Do i3=1,3
      Do i4=1,4
If ((MFe2(i1).gt.mf_l2(2)).Or.(MHpm2(i2).gt.mf_l2(2)).Or.(0._dp.gt.mf_l2(2)).Or.(MHpm2(i4).gt.mf_l2(2))) Then
coup1L = cplFeFv1cHpmL(i1,gt1,i4)
coup1R = cplFeFv1cHpmR(i1,gt1,i4)
coup2L = cplcFecFv1HpmL(i1,gt2,i2)
coup2R = cplcFecFv1HpmR(i1,gt2,i2)
coup3L = cplFeFv1cHpmL(gt3,i3,i2)
coup3R = cplFeFv1cHpmR(gt3,i3,i2)
coup4L = cplcFecFv1HpmL(gt4,i3,i4)
coup4R = cplcFecFv1HpmR(gt4,i3,i4)
D27m2 = D27_Bagger(MHpm2(i2),MHpm2(i4),MFe2(i1),0._dp)
If(Real(D27m2,dp).eq.Real(D27m2,dp)) Then 
teil = teil + D27m2*chargefactor*coup1L*coup2R*coup3L*coup4R 
End if
End if 
    End Do 
   End Do 
  End Do 
End Do 


 ! Fe,Hpm,bar[Fv1],Hpm
chargefactor = 1 
Do i1=1,3
  Do i2=1,4
    Do i3=1,3
      Do i4=1,4
If ((MFe2(i1).gt.mf_l2(2)).Or.(MHpm2(i2).gt.mf_l2(2)).Or.(0._dp.gt.mf_l2(2)).Or.(MHpm2(i4).gt.mf_l2(2))) Then
coup1L = cplFeFv1cHpmL(i1,gt1,i4)
coup1R = cplFeFv1cHpmR(i1,gt1,i4)
coup2L = cplcFecFv1HpmL(i1,gt2,i2)
coup2R = cplcFecFv1HpmR(i1,gt2,i2)
coup3L = cplcFv1FecHpmL(i3,gt3,i2)
coup3R = cplcFv1FecHpmR(i3,gt3,i2)
coup4L = cplcFeFv1HpmL(gt4,i3,i4)
coup4R = cplcFeFv1HpmR(gt4,i3,i4)
D27m2 = D27_Bagger(MHpm2(i2),MHpm2(i4),MFe2(i1),0._dp)
If(Real(D27m2,dp).eq.Real(D27m2,dp)) Then 
teil = teil + D27m2*chargefactor*coup1L*coup2R*coup3L*coup4R 
End if
End if 
    End Do 
   End Do 
  End Do 
End Do 


 ! bar[Fv1],VZp,bar[Fe],VZp
chargefactor = 1 
Do i1=1,3
    Do i3=1,3
If ((0._dp.gt.mf_l2(2)).Or.(MVZp2.gt.mf_l2(2)).Or.(MFe2(i3).gt.mf_l2(2)).Or.(MVZp2.gt.mf_l2(2))) Then
coup1L = cplcFv1Fv1VZpL(i1,gt1)
coup1R = cplcFv1Fv1VZpR(i1,gt1)
coup2L = cplcFv1Fv1VZpL(gt2,i1)
coup2R = cplcFv1Fv1VZpR(gt2,i1)
coup3L = cplcFeFeVZpL(i3,gt3)
coup3R = cplcFeFeVZpR(i3,gt3)
coup4L = cplcFeFeVZpL(gt4,i3)
coup4R = cplcFeFeVZpR(gt4,i3)
End if 
    End Do 
  End Do 


 ! conj[Hpm],bar[Fe],Ah,bar[Fe]
chargefactor = 1 
Do i1=1,4
  Do i2=1,3
    Do i3=1,3
      Do i4=1,3
If ((MHpm2(i1).gt.mf_l2(2)).Or.(MFe2(i2).gt.mf_l2(2)).Or.(MAh2(i3).gt.mf_l2(2)).Or.(MFe2(i4).gt.mf_l2(2))) Then
coup1L = cplFeFv1cHpmL(i4,gt1,i1)
coup1R = cplFeFv1cHpmR(i4,gt1,i1)
coup2L = cplcFecFv1HpmL(i2,gt2,i1)
coup2R = cplcFecFv1HpmR(i2,gt2,i1)
coup3L = cplcFeFeAhL(gt4,i2,i3)
coup3R = cplcFeFeAhR(gt4,i2,i3)
coup4L = cplcFeFeAhL(i4,gt3,i3)
coup4R = cplcFeFeAhR(i4,gt3,i3)
D0m2 = D0_Bagger(MHpm2(i1),MAh2(i3),MFe2(i2),MFe2(i4))*MFe(i2)*MFe(i4) 
D27m2 = D27_Bagger(MHpm2(i1),MAh2(i3),MFe2(i2),MFe2(i4))
If ((Real(D27m2,dp).eq.Real(D27m2,dp)).And.(Real(D0m2,dp).eq.Real(D0m2,dp))) Then 
teil = teil + 0.5_dp*chargefactor*D27m2*coup1L*coup2R*coup3L*coup4R+D0m2*coup1L*coup2L*coup3R*coup4R 
End if
End if 
    End Do 
   End Do 
  End Do 
End Do 


 ! conj[Hpm],bar[Fe],hh,bar[Fe]
chargefactor = 1 
Do i1=1,4
  Do i2=1,3
    Do i3=1,3
      Do i4=1,3
If ((MHpm2(i1).gt.mf_l2(2)).Or.(MFe2(i2).gt.mf_l2(2)).Or.(Mhh2(i3).gt.mf_l2(2)).Or.(MFe2(i4).gt.mf_l2(2))) Then
coup1L = cplFeFv1cHpmL(i4,gt1,i1)
coup1R = cplFeFv1cHpmR(i4,gt1,i1)
coup2L = cplcFecFv1HpmL(i2,gt2,i1)
coup2R = cplcFecFv1HpmR(i2,gt2,i1)
coup3L = cplcFeFehhL(gt4,i2,i3)
coup3R = cplcFeFehhR(gt4,i2,i3)
coup4L = cplcFeFehhL(i4,gt3,i3)
coup4R = cplcFeFehhR(i4,gt3,i3)
D0m2 = D0_Bagger(MHpm2(i1),Mhh2(i3),MFe2(i2),MFe2(i4))*MFe(i2)*MFe(i4) 
D27m2 = D27_Bagger(MHpm2(i1),Mhh2(i3),MFe2(i2),MFe2(i4))
If ((Real(D27m2,dp).eq.Real(D27m2,dp)).And.(Real(D0m2,dp).eq.Real(D0m2,dp))) Then 
teil = teil + 0.5_dp*chargefactor*D27m2*coup1L*coup2R*coup3L*coup4R+D0m2*coup1L*coup2L*coup3R*coup4R 
End if
End if 
    End Do 
   End Do 
  End Do 
End Do 


 ! conj[Hpm],bar[Fe],VZp,bar[Fe]
chargefactor = 1 
Do i1=1,4
  Do i2=1,3
      Do i4=1,3
If ((MHpm2(i1).gt.mf_l2(2)).Or.(MFe2(i2).gt.mf_l2(2)).Or.(MVZp2.gt.mf_l2(2)).Or.(MFe2(i4).gt.mf_l2(2))) Then
coup1L = cplFeFv1cHpmL(i4,gt1,i1)
coup1R = cplFeFv1cHpmR(i4,gt1,i1)
coup2L = cplcFecFv1HpmL(i2,gt2,i1)
coup2R = cplcFecFv1HpmR(i2,gt2,i1)
coup3L = cplcFeFeVZpL(gt4,i2)
coup3R = cplcFeFeVZpR(gt4,i2)
coup4L = cplcFeFeVZpL(i4,gt3)
coup4R = cplcFeFeVZpR(i4,gt3)
End if 
    End Do 
   End Do 
End Do 


 ! conj[Hpm],bar[Fv1],VZp,bar[Fe]
chargefactor = 1 
Do i1=1,4
  Do i2=1,3
      Do i4=1,3
If ((MHpm2(i1).gt.mf_l2(2)).Or.(0._dp.gt.mf_l2(2)).Or.(MVZp2.gt.mf_l2(2)).Or.(MFe2(i4).gt.mf_l2(2))) Then
coup1L = cplFeFv1cHpmL(i4,gt1,i1)
coup1R = cplFeFv1cHpmR(i4,gt1,i1)
coup2L = cplcFecFv1HpmL(gt4,i2,i1)
coup2R = cplcFecFv1HpmR(gt4,i2,i1)
coup3L = cplcFv1Fv1VZpL(gt2,i2)
coup3R = cplcFv1Fv1VZpR(gt2,i2)
coup4L = cplcFeFeVZpL(i4,gt3)
coup4R = cplcFeFeVZpR(i4,gt3)
End if 
    End Do 
   End Do 
End Do 


  End Do 
 
End Do 
 

 
sumI = -2._dp*cosW2_DR*mz2*Real(teil,dp)/g2**2 
res = res + SumI 
End if ! BSM part 
res = res*oo16pi2 
Iname = Iname-1
End subroutine DeltaVB 
 
 
Subroutine CoupHiggsToPhoton(mHiggs,inG,ratDpm,ratFd,ratFe,ratFu,ratHpm,              & 
& ratVWp,ratVXp,MDpm,MFd,MFe,MFu,MHpm,MVWp,MVXp,gNLO,coup)

Implicit None 
Complex(dp),Intent(in) :: ratDpm(2),ratFd(5),ratFe(3),ratFu(4),ratHpm(4),ratVWp,ratVXp

Real(dp),Intent(in) :: MDpm(2),MFd(5),MFe(3),MFu(4),MHpm(4),MVWp,MVXp

Integer, Intent(in) :: inG 
Real(dp), Intent(in) :: mHiggs, gNLO 
Complex(dp), Intent(out) :: coup 
Integer :: i1 
Real(dp) :: Mh2p 
mH2p = 0.25_dp*mHiggs**2 
coup = 0._dp 
 
coup = coup + 1*(1)**2*ratVWp*A_one(mH2p/MVWp**2)
HPPloopVWp(inG) = HPPloopVWp(inG)+1*(1)**2*ratVWp*A_one(mH2p/MVWp**2)
coup = coup + 1*(1)**2*ratVXp*A_one(mH2p/MVXp**2)
HPPloopVXp(inG) = HPPloopVXp(inG)+1*(1)**2*ratVXp*A_one(mH2p/MVXp**2)
Do i1 = 3 , 4
coup = coup + 1*(-1)**2*ratHpm(i1)*A_zero(mH2p/MHpm(i1)**2)
HPPloopHpm(i1,inG) = HPPloopHpm(i1,inG)+1*(-1)**2*ratHpm(i1)*A_zero(mH2p/MHpm(i1)**2)
End Do 
Do i1 = 1 , 2
coup = coup + 1*(2)**2*ratDpm(i1)*A_zero(mH2p/MDpm(i1)**2)
HPPloopDpm(i1,inG) = HPPloopDpm(i1,inG)+1*(2)**2*ratDpm(i1)*A_zero(mH2p/MDpm(i1)**2)
End Do 
Do i1 = 1 , 5
coup = coup + cNLO_onehalf(mHiggs,MFd(i1),gNLO)*3*(-1._dp/3._dp)**2*ratFd(i1)*A_onehalf(mH2p/MFd(i1)**2)
HPPloopFd(i1,inG) = HPPloopFd(i1,inG) + cNLO_onehalf(mHiggs,MFd(i1),gNLO)*3*(-1._dp/3._dp)**2*ratFd(i1)*A_onehalf(mH2p/MFd(i1)**2)
End Do 
Do i1 = 1 , 4
coup = coup + cNLO_onehalf(mHiggs,MFu(i1),gNLO)*3*(2._dp/3._dp)**2*ratFu(i1)*A_onehalf(mH2p/MFu(i1)**2)
HPPloopFu(i1,inG) = HPPloopFu(i1,inG) + cNLO_onehalf(mHiggs,MFu(i1),gNLO)*3*(2._dp/3._dp)**2*ratFu(i1)*A_onehalf(mH2p/MFu(i1)**2)
End Do 
Do i1 = 1 , 3
coup = coup + 1*(-1)**2*ratFe(i1)*A_onehalf(mH2p/MFe(i1)**2)
HPPloopFe(i1,inG) = HPPloopFe(i1,inG)+1*(-1)**2*ratFe(i1)*A_onehalf(mH2p/MFe(i1)**2)
End Do 
End Subroutine CoupHiggsToPhoton

Subroutine CoupHiggsToGluon(mHiggs,inG,ratFd,ratFu,MFd,MFu,gNLO,coup)

Implicit None 
Complex(dp),Intent(in) :: ratFd(5),ratFu(4)

Real(dp),Intent(in) :: MFd(5),MFu(4)

Integer, Intent(in) :: inG 
Real(dp), Intent(in) :: mHiggs, gNLO 
Complex(dp), Intent(out) :: coup 
Integer :: i1 
Real(dp) :: Mh2p 
mH2p = 0.25_dp*mHiggs**2 
coup = 0._dp 
 
Do i1 = 1 , 5
coup = coup + 1*ratFd(i1)*A_onehalf(mH2p/MFd(i1)**2)
End Do 
Do i1 = 1 , 4
coup = coup + 1*ratFu(i1)*A_onehalf(mH2p/MFu(i1)**2)
End Do 
coup = 0.75_dp*coup 
End Subroutine CoupHiggsToGluon

Subroutine CoupHiggsToPhotonSM(mHiggs,MDpm,MFd,MFe,MFu,MHpm,MVWp,MVXp,gNLO,coup)

Implicit None 
Real(dp),Intent(in) :: MDpm(2),MFd(5),MFe(3),MFu(4),MHpm(4),MVWp,MVXp

Real(dp), Intent(in) :: mHiggs, gNLO 
Complex(dp), Intent(out) :: coup 
Integer :: i1 
Real(dp) :: Mh2p 
mH2p = 0.25_dp*mHiggs**2 
coup = 0._dp 
 
coup = coup + 1*(1)**2*A_one(mH2p/MVWp**2)
Do i1 =1, 3 
coup = coup + cNLO_onehalf(mHiggs,MFd(i1),gNLO)*3*(-1._dp/3._dp)**2*A_onehalf(mH2p/MFd(i1)**2)
End Do 
Do i1 =1, 3 
coup = coup + cNLO_onehalf(mHiggs,MFu(i1),gNLO)*3*(2._dp/3._dp)**2*A_onehalf(mH2p/MFu(i1)**2)
End Do 
Do i1 =1, 3 
coup = coup + 1*(-1)**2*A_onehalf(mH2p/MFe(i1)**2)
End Do 
End Subroutine CoupHiggsToPhotonSM 

Subroutine CoupHiggsToGluonSM(mHiggs,MFd,MFu,gNLO,coup)

Implicit None 
Real(dp),Intent(in) :: MFd(5),MFu(4)

Real(dp), Intent(in) :: mHiggs, gNLO 
Complex(dp), Intent(out) :: coup 
Integer :: i1 
Real(dp) :: Mh2p 
mH2p = 0.25_dp*mHiggs**2 
coup = 0._dp 
 
Do i1 =1, 3 
coup = coup + 1*A_onehalf(mH2p/MFd(i1)**2)
End Do 
Do i1 =1, 3 
coup = coup + 1*A_onehalf(mH2p/MFu(i1)**2)
End Do 
coup = 0.75_dp*coup 
End Subroutine CoupHiggsToGluonSM 

Subroutine CoupPseudoHiggsToPhoton(mHiggs,inG,ratDpm,ratFd,ratFe,ratFu,               & 
& ratHpm,ratVWp,ratVXp,MDpm,MFd,MFe,MFu,MHpm,MVWp,MVXp,gNLO,coup)

Implicit None 
Complex(dp),Intent(in) :: ratDpm(2),ratFd(5),ratFe(3),ratFu(4),ratHpm(4),ratVWp,ratVXp

Real(dp),Intent(in) :: MDpm(2),MFd(5),MFe(3),MFu(4),MHpm(4),MVWp,MVXp

Real(dp), Intent(in) :: mHiggs, gNLO 
Complex(dp), Intent(out) :: coup 
Integer :: i1 
Integer, Intent(in) :: inG 
Real(dp) :: Mh2p 
mH2p = 0.25_dp*mHiggs**2 
coup = 0._dp 
 
Do i1 =1, 5
coup = coup + cANLO_onehalf(mHiggs,MFd(i1),gNLO)*3*(-1._dp/3._dp)**2*ratFd(i1)*AP_onehalf(mH2p/MFd(i1)**2)
End Do 
Do i1 =1, 4
coup = coup + cANLO_onehalf(mHiggs,MFu(i1),gNLO)*3*(2._dp/3._dp)**2*ratFu(i1)*AP_onehalf(mH2p/MFu(i1)**2)
End Do 
Do i1 =1, 3
coup = coup + cANLO_onehalf(mHiggs,MFe(i1),gNLO)*1*(-1)**2*ratFe(i1)*AP_onehalf(mH2p/MFe(i1)**2)
End Do 
End Subroutine CoupPseudoHiggsToPhoton

Subroutine CoupPseudoHiggsToGluon(mHiggs,inG,ratFd,ratFu,MFd,MFu,gNLO,coup)

Implicit None 
Complex(dp),Intent(in) :: ratFd(5),ratFu(4)

Real(dp),Intent(in) :: MFd(5),MFu(4)

Real(dp), Intent(in) :: mHiggs, gNLO 
Complex(dp), Intent(out) :: coup 
Integer :: i1 
Integer, Intent(in) :: inG 
Real(dp) :: Mh2p 
mH2p = 0.25_dp*mHiggs**2 
coup = 0._dp 
 
Do i1 =1, 5
coup = coup + 1*ratFd(i1)*AP_onehalf(mH2p/MFd(i1)**2)
End Do 
Do i1 =1, 4
coup = coup + 1*ratFu(i1)*AP_onehalf(mH2p/MFu(i1)**2)
End Do 
coup = 0.75_dp*coup 
End Subroutine CoupPseudoHiggsToGluon

Subroutine CoupPseudoHiggsToPhotonSM(mHiggs,MDpm,MFd,MFe,MFu,MHpm,MVWp,               & 
& MVXp,gNLO,coup)

Implicit None 
Real(dp),Intent(in) :: MDpm(2),MFd(5),MFe(3),MFu(4),MHpm(4),MVWp,MVXp

Real(dp), Intent(in) :: mHiggs,gNLO 
Complex(dp), Intent(out) :: coup 
Integer :: i1 
Real(dp) :: Mh2p 
mH2p = 0.25_dp*mHiggs**2 
coup = 0._dp 
 
Do i1 =1, 5
coup = coup + cANLO_onehalf(mHiggs,MFd(i1),gNLO)*3*(-1._dp/3._dp)**2**AP_onehalf(mH2p/MFd(i1)**2)
End Do 
Do i1 =1, 4
coup = coup + cANLO_onehalf(mHiggs,MFu(i1),gNLO)*3*(2._dp/3._dp)**2**AP_onehalf(mH2p/MFu(i1)**2)
End Do 
Do i1 =1, 3
coup = coup + cANLO_onehalf(mHiggs,MFe(i1),gNLO)*1*(-1)**2**AP_onehalf(mH2p/MFe(i1)**2)
End Do 
End Subroutine CoupPseudoHiggsToPhotonSM 

Subroutine CoupPseudoHiggsToGluonSM(mHiggs,MFd,MFu,gNLO,coup)

Implicit None 
Real(dp),Intent(in) :: MFd(5),MFu(4)

Real(dp), Intent(in) :: mHiggs,gNLO 
Complex(dp), Intent(out) :: coup 
Integer :: i1 
Real(dp) :: Mh2p 
mH2p = 0.25_dp*mHiggs**2 
coup = 0._dp 
 
Do i1 =1, 5
coup = coup + 1*AP_onehalf(mH2p/MFd(i1)**2)
End Do 
Do i1 =1, 4
coup = coup + 1*AP_onehalf(mH2p/MFu(i1)**2)
End Do 
coup = 0.75_dp*coup 
End Subroutine CoupPseudoHiggsToGluonSM 

Complex(dp) Function cNLO_onehalf(mH,mQ,g) 
Real(dp), Intent(in) :: mH, mQ, g
Real(dp)::tau 
tau=mH**2/(4._dp*mQ**2) 
If (g.lt.0._dp) Then 
  cNLO_onehalf = 1._dp 
Else 
  If (mH.lt.mQ) Then 
    cNLO_onehalf = 1._dp - oo4pi2*g**2  
  Else if (mH.gt.(2._dp*mQ)) Then 
   If (tau.lt.100._dp) Then 
    If (tau.lt.1.1_dp) Then 
      cNLO_onehalf=1._dp+(g**2/(4*Pi**2))*(&
       & (-1.033208159703536+7.10655096733206*tau-88.20900604676405*tau**2+598.6773733788388*tau**3-1967.3257953814561*tau**4+& 
       & 3247.6715405319346*tau**5-2330.127086890616*tau**6+677.9294006001846*tau**8-142.7923161120851*tau**10)& 
       &+(0._dp,1._dp)*(8.29739339711994-7.888861883558018/tau**3+10.437838040782095/tau**2-8.42394029242545/tau+0.2842283337270764*tau-&
       & 0.054995208547411904*tau*Log(tau)-1.6113597681662795*Log(4*tau)+0.000021811438531828155*tau**2*Log(tau**2))) 
    Else 
      cNLO_onehalf=1._dp+(g**2/(4*Pi**2))*(&
       & (-1.6170280814404576+0.40530581525102677/tau**3-0.33530992103515084/tau**2+3.9718559902660684/tau-0.000111953515865919*tau+& 
       & 9.129881821626589e-6*tau*Log(tau)+0.1338033886479311*Log(4*tau)-1.121902907800696e-12*tau**2*Log(tau**2))& 
       &+(0._dp,1._dp)*(8.29739339711994-7.888861883558018/tau**3+10.437838040782095/tau**2-8.42394029242545/tau+0.2842283337270764*tau-& 
       & 0.054995208547411904*tau*Log(tau)-1.6113597681662795*Log(4*tau)+0.000021811438531828155*tau**2*Log(tau**2))) 
    End if 
   Else ! mQ->0 
     cNLO_onehalf=1._dp+(g**2/(4*Pi**2))*&
      & (-(2._dp*Log(mH**2/mQ**2))/3._dp+(Pi**2-(Log(mH**2/mQ**2))**2)/18._dp+2*log(mH**2/4/mQ**2)&
      &+(0._dp,1._dp)*Pi/3*((Log(mH**2/mQ**2))/3+2._dp))
    End if 
  Else ! mQ~mH 
    cNLO_onehalf = 1._dp 
  End if 
End if 
End Function cNLO_onehalf 
 
Complex(dp) Function cANLO_onehalf(mH,mQ,g) 
Real(dp), Intent(in) :: mH, mQ, g
Real(dp)::tau 
tau=mH**2/(4._dp*mQ**2) 
If (g.lt.0._dp) Then 
  cANLO_onehalf = 1._dp 
Else 
  If (mH.lt.mQ) Then 
    cANLO_onehalf = 1._dp  
  Else if (mH.gt.(2._dp*mQ)) Then 
   If (tau.lt.100._dp) Then 
    If (tau.lt.1.1_dp) Then 
      cANLO_onehalf=1._dp+(g**2/(4*Pi**2))*(&
       & (-1.033208159703536+7.10655096733206*tau-88.20900604676405*tau**2+598.6773733788388*tau**3-1967.3257953814561*tau**4+& 
       & 3247.6715405319346*tau**5-2330.127086890616*tau**6+677.9294006001846*tau**8-142.7923161120851*tau**10)& 
       &+(0._dp,1._dp)*(8.29739339711994-7.888861883558018/tau**3+10.437838040782095/tau**2-8.42394029242545/tau+0.2842283337270764*tau-&
       & 0.054995208547411904*tau*Log(tau)-1.6113597681662795*Log(4*tau)+0.000021811438531828155*tau**2*Log(tau**2))) 
    Else 
      cANLO_onehalf=1._dp+(g**2/(4*Pi**2))*(&
       & (-1.6170280814404576+0.40530581525102677/tau**3-0.33530992103515084/tau**2+3.9718559902660684/tau-0.000111953515865919*tau+& 
       & 9.129881821626589e-6*tau*Log(tau)+0.1338033886479311*Log(4*tau)-1.121902907800696e-12*tau**2*Log(tau**2))& 
       &+(0._dp,1._dp)*(8.29739339711994-7.888861883558018/tau**3+10.437838040782095/tau**2-8.42394029242545/tau+0.2842283337270764*tau-& 
       & 0.054995208547411904*tau*Log(tau)-1.6113597681662795*Log(4*tau)+0.000021811438531828155*tau**2*Log(tau**2))) 
    End if 
   Else ! mQ->0 
     cANLO_onehalf=1._dp+(g**2/(4*Pi**2))*&
      & (-(2._dp*Log(mH**2/mQ**2))/3._dp+(Pi**2-(Log(mH**2/mQ**2))**2)/18._dp+2*log(mH**2/4/mQ**2)&
      &+(0._dp,1._dp)*Pi/3*((Log(mH**2/mQ**2))/3+2._dp))
    End if 
  Else ! mQ~mH 
    cANLO_onehalf = 1._dp 
  End if 
End if 
End Function cANLO_onehalf 
 
Real(dp) Function cNLO_zero(mH,mQ,g) 
Real(dp), Intent(in) :: mH, mQ, g
If (g.lt.0._dp) Then 
   cNLO_zero= 1._dp 
Else 
  If (mH.lt.mQ) Then 
    cNLO_zero = 1._dp + 2._dp*oo3pi2*g**2  
  Else  
    cNLO_zero = 1._dp 
  End if 
End if 
End Function cNLO_zero 
End Module LoopCouplings_331v3 
 
