! -----------------------------------------------------------------------------  
! This file was automatically created by SARAH version 4.14.3 
! SARAH References: arXiv:0806.0538, 0909.2863, 1002.0840, 1207.0906, 1309.7223  
! (c) Florian Staub, 2013  
! ------------------------------------------------------------------------------  
! File created at 16:42 on 3.7.2020   
! ----------------------------------------------------------------------  
 
 
Module TreeLevelMasses_331v3 
 
Use Control 
Use Mathematics 
Use MathematicsQP 
Use Settings 
Use Model_Data_331v3 

 
Logical :: SignOfMassChanged =.False.  
Logical :: SignOfMuChanged =.False.  
Contains 
 
Subroutine TreeMasses(MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,MFe2,MFu,MFu2,Mhh,             & 
& Mhh2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,TW,Ud,Ue,Uu,Vd,              & 
& Ve,Vu,ZA,ZH,ZP,ZW,zy,ZZ,Vn,v1,v2,g1,g2,g3,l1,l12,l13,l12t,l13t,l2,l23,l23t,            & 
& l3,hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,hUp2,               & 
& hd3,hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,GenerationMixing,kont)

Implicit None 
 
Real(dp),Intent(in) :: g1,g2,g3,ftri,mu12,mu22,mu32

Complex(dp),Intent(in) :: l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,hll1(3,3),hdp11(3),hd1(3),hdtp11(2),              & 
& hdt1(2),hup11(3),hUp1,hdp1(3),hd2(3),hdtp1(2),hdt2(2),hup21(3),hUp2,hd3(3),            & 
& hdt3(2),hu11(3),h12(3),hU1,hU2

Real(dp),Intent(out) :: MAh(3),MAh2(3),MDpm(2),MDpm2(2),MFd(5),MFd2(5),MFe(3),MFe2(3),MFu(4),MFu2(4),         & 
& Mhh(3),Mhh2(3),MHpm(4),MHpm2(4),MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,TW

Complex(dp),Intent(out) :: Ud(5,5),Ue(3,3),Uu(4,4),Vd(5,5),Ve(3,3),Vu(4,4),ZA(3,3),ZH(3,3),ZP(4,4),              & 
& ZW(4,4),zy(2,2),ZZ(3,3)

Real(dp),Intent(in) :: Vn,v1,v2

Logical, Intent(in) :: GenerationMixing 
Integer, Intent(inout) :: kont 
Integer :: i1,i2,i3,i4,j1,j2,j3,kontSave 
Iname = Iname + 1 
NameOfUnit(Iname) = 'TreeMasses331/v3'
 
kont = 0 
Call CalculateVPVZVZp(g1,g2,Vn,v1,v2,ZZ,MVZ,MVZp,MVZ2,MVZp2,kont)

Call CalculateVWpVXp(g2,Vn,v1,v2,ZW,MVWp,MVXp,MVWp2,MVXp2,kont)

Call CalculateMhh(mu12,mu22,mu32,ftri,l1,l12,l13,l2,l23,l3,Vn,v1,v2,ZH,               & 
& Mhh,Mhh2,kont)

kontSave = kont 
Call CalculateMAh(g1,g2,mu12,mu22,mu32,ftri,l1,l12,l13,l2,l23,l3,Vn,v1,               & 
& v2,ZZ,ZA,MAh,MAh2,kont)

kont = kontSave 
kontSave = kont 
Call CalculateMHpm(g2,mu12,mu22,mu32,ftri,l1,l12,l13,l13t,l2,l23,l23t,l3,             & 
& Vn,v1,v2,ZP,MHpm,MHpm2,kont)

kont = kontSave 
Call CalculateMDpm(mu12,mu22,ftri,l1,l12,l13,l12t,l2,l23,Vn,v1,v2,zy,MDpm,            & 
& MDpm2,kont)

Call CalculateMFd(hdp11,hd1,hdtp11,hdt1,hdp1,hd2,hdtp1,hdt2,hd3,hdt3,Vn,              & 
& v1,v2,Vd,Ud,MFd,kont)

MFd2 = MFd**2 
Call CalculateMFu(hup11,hUp1,hup21,hUp2,hu11,h12,hU1,hU2,Vn,v1,v2,Vu,Uu,MFu,kont)

MFu2 = MFu**2 
Call CalculateMFe(hll1,v2,Ve,Ue,MFe,kont)

MFe2 = MFe**2 

 
 Call SortGoldstones(MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,MFe2,MFu,MFu2,Mhh,               & 
& Mhh2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,TW,Ud,Ue,Uu,Vd,              & 
& Ve,Vu,ZA,ZH,ZP,ZW,zy,ZZ,kont)

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

 ! -------------------------------- 
! Setting Goldstone masses 
! -------------------------------- 
 
MAh(1)=MVZ*sqrt(RXiZ)
MAh2(1)=MVZ2*RXiZ
MAh(2)=MVZp*sqrt(RXiZp)
MAh2(2)=MVZp2*RXiZp
MHpm(1)=MVWp*sqrt(RXiWp)
MHpm2(1)=MVWp2*RXiWp
MHpm(2)=MVXp*sqrt(RXiXp)
MHpm2(2)=MVXp2*RXiXp
TW = ACos(Abs(ZZ(1,1)))
Iname = Iname - 1 
 
End Subroutine  TreeMasses 
 
 
Subroutine RunningFermionMasses(MFeIN,MFe2IN,MFdIN,MFd2IN,MFuIN,MFu2IN,               & 
& Vn,v1,v2,g1,g2,g3,l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,hll1,hdp11,hd1,hdtp11,           & 
& hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,hUp2,hd3,hdt3,hu11,h12,hU1,hU2,              & 
& ftri,mu12,mu22,mu32,kont)

Implicit None 
 
Integer, Intent(inout) :: kont 
Real(dp),Intent(in) :: g1,g2,g3,ftri,mu12,mu22,mu32

Complex(dp),Intent(in) :: l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,hll1(3,3),hdp11(3),hd1(3),hdtp11(2),              & 
& hdt1(2),hup11(3),hUp1,hdp1(3),hd2(3),hdtp1(2),hdt2(2),hup21(3),hUp2,hd3(3),            & 
& hdt3(2),hu11(3),h12(3),hU1,hU2

Real(dp),Intent(in) :: Vn,v1,v2

Real(dp),Intent(inout) :: MFeIN(3),MFe2IN(3),MFdIN(5),MFd2IN(5),MFuIN(4),MFu2IN(4)

Real(dp) :: MFe(3),MFe2(3),MFd(5),MFd2(5),MFu(4),MFu2(4)

Call CalculateMFe(hll1,v2,Ve,Ue,MFe,kont)

MFe2 = MFe**2 
MFeIN(1:2) = MFe(1:2) 
MFe2IN(1:2) = MFe2(1:2) 
Call CalculateMFd(hdp11,hd1,hdtp11,hdt1,hdp1,hd2,hdtp1,hdt2,hd3,hdt3,Vn,              & 
& v1,v2,Vd,Ud,MFd,kont)

MFd2 = MFd**2 
MFdIN(1:2) = MFd(1:2) 
MFd2IN(1:2) = MFd2(1:2) 
Call CalculateMFu(hup11,hUp1,hup21,hUp2,hu11,h12,hU1,hU2,Vn,v1,v2,Vu,Uu,MFu,kont)

MFu2 = MFu**2 
MFuIN(1:2) = MFu(1:2) 
MFu2IN(1:2) = MFu2(1:2) 
End Subroutine RunningFermionMasses 

Subroutine TreeMassesEffPot(MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,MFe2,MFu,MFu2,           & 
& Mhh,Mhh2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,TW,Ud,Ue,Uu,             & 
& Vd,Ve,Vu,ZA,ZH,ZP,ZW,zy,ZZ,Vn,v1,v2,g1,g2,g3,l1,l12,l13,l12t,l13t,l2,l23,              & 
& l23t,l3,hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,               & 
& hUp2,hd3,hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,GenerationMixing,kont)

Implicit None 
 
Real(dp),Intent(in) :: g1,g2,g3,ftri,mu12,mu22,mu32

Complex(dp),Intent(in) :: l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,hll1(3,3),hdp11(3),hd1(3),hdtp11(2),              & 
& hdt1(2),hup11(3),hUp1,hdp1(3),hd2(3),hdtp1(2),hdt2(2),hup21(3),hUp2,hd3(3),            & 
& hdt3(2),hu11(3),h12(3),hU1,hU2

Real(dp),Intent(out) :: MAh(3),MAh2(3),MDpm(2),MDpm2(2),MFd(5),MFd2(5),MFe(3),MFe2(3),MFu(4),MFu2(4),         & 
& Mhh(3),Mhh2(3),MHpm(4),MHpm2(4),MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,TW

Complex(dp),Intent(out) :: Ud(5,5),Ue(3,3),Uu(4,4),Vd(5,5),Ve(3,3),Vu(4,4),ZA(3,3),ZH(3,3),ZP(4,4),              & 
& ZW(4,4),zy(2,2),ZZ(3,3)

Real(dp),Intent(in) :: Vn,v1,v2

Logical, Intent(in) :: GenerationMixing 
Integer, Intent(inout) :: kont 
Integer :: i1,i2,i3,i4,j1,j2,j3,kontSave 
Iname = Iname + 1 
NameOfUnit(Iname) = 'TreeMasses331/v3'
 
kont = 0 
Call CalculateVPVZVZpEffPot(g1,g2,Vn,v1,v2,ZZ,MVZ,MVZp,MVZ2,MVZp2,kont)

Call CalculateVWpVXpEffPot(g2,Vn,v1,v2,ZW,MVWp,MVXp,MVWp2,MVXp2,kont)

Call CalculateMhhEffPot(mu12,mu22,mu32,ftri,l1,l12,l13,l2,l23,l3,Vn,v1,               & 
& v2,ZH,Mhh,Mhh2,kont)

kontSave = kont 
Call CalculateMAhEffPot(g1,g2,mu12,mu22,mu32,ftri,l1,l12,l13,l2,l23,l3,               & 
& Vn,v1,v2,ZZ,ZA,MAh,MAh2,kont)

kont = kontSave 
kontSave = kont 
Call CalculateMHpmEffPot(g2,mu12,mu22,mu32,ftri,l1,l12,l13,l13t,l2,l23,               & 
& l23t,l3,Vn,v1,v2,ZP,MHpm,MHpm2,kont)

kont = kontSave 
Call CalculateMDpmEffPot(mu12,mu22,ftri,l1,l12,l13,l12t,l2,l23,Vn,v1,v2,              & 
& zy,MDpm,MDpm2,kont)

Call CalculateMFdEffPot(hdp11,hd1,hdtp11,hdt1,hdp1,hd2,hdtp1,hdt2,hd3,hdt3,           & 
& Vn,v1,v2,Vd,Ud,MFd,kont)

MFd2 = MFd**2 
Call CalculateMFuEffPot(hup11,hUp1,hup21,hUp2,hu11,h12,hU1,hU2,Vn,v1,v2,              & 
& Vu,Uu,MFu,kont)

MFu2 = MFu**2 
Call CalculateMFeEffPot(hll1,v2,Ve,Ue,MFe,kont)

MFe2 = MFe**2 

 
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
Iname = Iname - 1 
 
End Subroutine  TreeMassesEffPot 
 
 
Subroutine CalculateMhh(mu12,mu22,mu32,ftri,l1,l12,l13,l2,l23,l3,Vn,v1,               & 
& v2,ZH,Mhh,Mhh2,kont)

Real(dp), Intent(in) :: mu12,mu22,mu32,ftri,Vn,v1,v2

Complex(dp), Intent(in) :: l1,l12,l13,l2,l23,l3

Integer, Intent(inout) :: kont 
Integer :: i1,i2,i3,i4, ierr 
Integer :: j1,j2,j3,j4, pos 
Real(dp), Intent(out) :: Mhh(3), Mhh2(3) 
Complex(dp), Intent(out) :: ZH(3,3) 
 
Complex(dp) :: mat(3,3)  

Real(dp) ::  test(2) 

Iname = Iname + 1 
NameOfUnit(Iname) = 'CalculateMhh'
 
mat(1,1) = 0._dp 
mat(1,1) = mat(1,1)-1._dp*(mu12)
mat(1,1) = mat(1,1)+3*l1*Vn**2
mat(1,1) = mat(1,1)+l12*v1**2
mat(1,1) = mat(1,1)+l13*v2**2
mat(1,2) = 0._dp 
mat(1,2) = mat(1,2)+2*l12*Vn*v1
mat(1,2) = mat(1,2)-((ftri*v2)/sqrt(2._dp))
mat(1,3) = 0._dp 
mat(1,3) = mat(1,3)-((ftri*v1)/sqrt(2._dp))
mat(1,3) = mat(1,3)+2*l13*Vn*v2
mat(2,2) = 0._dp 
mat(2,2) = mat(2,2)+mu22
mat(2,2) = mat(2,2)+l12*Vn**2
mat(2,2) = mat(2,2)+3*l2*v1**2
mat(2,2) = mat(2,2)+l23*v2**2
mat(2,3) = 0._dp 
mat(2,3) = mat(2,3)-((ftri*Vn)/sqrt(2._dp))
mat(2,3) = mat(2,3)+2*l23*v1*v2
mat(3,3) = 0._dp 
mat(3,3) = mat(3,3)+mu32
mat(3,3) = mat(3,3)+l13*Vn**2
mat(3,3) = mat(3,3)+l23*v1**2
mat(3,3) = mat(3,3)+2*l3*v2**2

 
 Do i1=2,3
  Do i2 = 1, i1-1 
  mat(i1,i2) = mat(i2,i1) 
  End do 
End do 

 
Call EigenSystem(mat,Mhh2,ZH,ierr,test) 
 
 
If ((ierr.Eq.-8).Or.(ierr.Eq.-9)) Then 
  Write(ErrCan,*) "Possible numerical problem in "//NameOfUnit(Iname) 
  If (ErrorLevel.Eq.2) Then 
  Write(*,*) "Possible numerical problem in "//NameOfUnit(Iname) 
    Call TerminateProgram 
  End If 
  ierr = 0 
End If 
 
If ((ierr.Ne.0.).And.(ErrorLevel.Ge.-1)) Then 
  Write(10,*) 'Warning from Subroutine '//NameOfUnit(Iname) 
  Write(10,*) 'Diagonalization failed, ierr : ',ierr 
  kont = ierr 
  Iname = Iname - 1 
  Return 
End If 


Do i1=1,3
  If (Abs(Mhh2(i1)).Le.MaxMassNumericalZero) Mhh2(i1) = 1.E-10_dp 
  If (Mhh2(i1).ne.Mhh2(i1)) Then 
      Write(*,*) 'NaN appearing in '//NameOfUnit(Iname) 
      Call TerminateProgram 
    End If 
  If (Mhh2(i1).Ge.0._dp) Then 
  Mhh(i1)=Sqrt(Mhh2(i1) ) 
  Else 
    If (ErrorLevel.Ge.0) Then 
      Write(10,*) 'Warning from Subroutine '//NameOfUnit(Iname) 
      Write(10,*) 'a mass squarred is negative: ',i1,Mhh2(i1) 
    End If 
  Mhh(i1) = 1._dp 
     Write(ErrCan,*) 'Warning from routine '//NameOfUnit(Iname) 
     Write(ErrCan,*) 'in the calculation of the masses' 
     Write(ErrCan,*) 'occurred a negative mass squared!' 
     Write(ErrCan,*) i1,Mhh2(i1) 
     Write(*,*) 'Warning from routine '//NameOfUnit(Iname) 
     Write(*,*) 'in the calculation of the masses' 
     Write(*,*) 'occurred a negative mass squared!' 
     Write(*,*) i1,Mhh2(i1) 
  Mhh2(i1) = 1._dp 
   SignOfMassChanged = .True. 
! kont = -104 
 End if 
End Do 
Iname = Iname - 1 
 
End Subroutine CalculateMhh 

Subroutine CalculateMAh(g1,g2,mu12,mu22,mu32,ftri,l1,l12,l13,l2,l23,l3,               & 
& Vn,v1,v2,ZZ,ZA,MAh,MAh2,kont)

Real(dp), Intent(in) :: g1,g2,mu12,mu22,mu32,ftri,Vn,v1,v2

Complex(dp), Intent(in) :: l1,l12,l13,l2,l23,l3,ZZ(3,3)

Integer, Intent(inout) :: kont 
Integer :: i1,i2,i3,i4, ierr 
Integer :: j1,j2,j3,j4, pos 
Real(dp), Intent(out) :: MAh(3), MAh2(3) 
Complex(dp), Intent(out) :: ZA(3,3) 
 
Complex(dp) :: mat(3,3)  

Real(dp) ::  test(2) 

Iname = Iname + 1 
NameOfUnit(Iname) = 'CalculateMAh'
 
mat(1,1) = 0._dp 
mat(1,1) = mat(1,1)-1._dp*(mu12)
mat(1,1) = mat(1,1)+l1*Vn**2
mat(1,1) = mat(1,1)+l12*v1**2
mat(1,1) = mat(1,1)+l13*v2**2
mat(1,1) = mat(1,1)+(2*g1**2*Vn**2*Conjg(ZZ(1,2))*RXiZ*ZZ(1,2))/9._dp
mat(1,1) = mat(1,1)+(2*g1*g2*Vn**2*Conjg(ZZ(2,2))*RXiZ*ZZ(1,2))/(3._dp*sqrt(3._dp))
mat(1,1) = mat(1,1)+(2*g1**2*Vn**2*Conjg(ZZ(1,3))*RXiZp*ZZ(1,3))/9._dp
mat(1,1) = mat(1,1)+(2*g1*g2*Vn**2*Conjg(ZZ(2,3))*RXiZp*ZZ(1,3))/(3._dp*sqrt(3._dp))
mat(1,1) = mat(1,1)+(2*g1*g2*Vn**2*Conjg(ZZ(1,2))*RXiZ*ZZ(2,2))/(3._dp*sqrt(3._dp))
mat(1,1) = mat(1,1)+(2*g2**2*Vn**2*Conjg(ZZ(2,2))*RXiZ*ZZ(2,2))/3._dp
mat(1,1) = mat(1,1)+(2*g1*g2*Vn**2*Conjg(ZZ(1,3))*RXiZp*ZZ(2,3))/(3._dp*sqrt(3._dp))
mat(1,1) = mat(1,1)+(2*g2**2*Vn**2*Conjg(ZZ(2,3))*RXiZp*ZZ(2,3))/3._dp
mat(1,2) = 0._dp 
mat(1,2) = mat(1,2)+(ftri*v2)/sqrt(2._dp)
mat(1,2) = mat(1,2)+(2*g1**2*Vn*v1*Conjg(ZZ(1,2))*RXiZ*ZZ(1,2))/9._dp
mat(1,2) = mat(1,2)+(g1*g2*Vn*v1*Conjg(ZZ(2,2))*RXiZ*ZZ(1,2))/(6._dp*sqrt(3._dp))
mat(1,2) = mat(1,2)+(g1*g2*Vn*v1*Conjg(ZZ(3,2))*RXiZ*ZZ(1,2))/6._dp
mat(1,2) = mat(1,2)+(2*g1**2*Vn*v1*Conjg(ZZ(1,3))*RXiZp*ZZ(1,3))/9._dp
mat(1,2) = mat(1,2)+(g1*g2*Vn*v1*Conjg(ZZ(2,3))*RXiZp*ZZ(1,3))/(6._dp*sqrt(3._dp))
mat(1,2) = mat(1,2)+(g1*g2*Vn*v1*Conjg(ZZ(3,3))*RXiZp*ZZ(1,3))/6._dp
mat(1,2) = mat(1,2)+(g1*g2*Vn*v1*Conjg(ZZ(1,2))*RXiZ*ZZ(2,2))/(6._dp*sqrt(3._dp))
mat(1,2) = mat(1,2)-(g2**2*Vn*v1*Conjg(ZZ(2,2))*RXiZ*ZZ(2,2))/3._dp
mat(1,2) = mat(1,2)+(g2**2*Vn*v1*Conjg(ZZ(3,2))*RXiZ*ZZ(2,2))/(2._dp*sqrt(3._dp))
mat(1,2) = mat(1,2)+(g1*g2*Vn*v1*Conjg(ZZ(1,3))*RXiZp*ZZ(2,3))/(6._dp*sqrt(3._dp))
mat(1,2) = mat(1,2)-(g2**2*Vn*v1*Conjg(ZZ(2,3))*RXiZp*ZZ(2,3))/3._dp
mat(1,2) = mat(1,2)+(g2**2*Vn*v1*Conjg(ZZ(3,3))*RXiZp*ZZ(2,3))/(2._dp*sqrt(3._dp))
mat(1,2) = mat(1,2)+(g1*g2*Vn*v1*Conjg(ZZ(1,2))*RXiZ*ZZ(3,2))/6._dp
mat(1,2) = mat(1,2)+(g2**2*Vn*v1*Conjg(ZZ(2,2))*RXiZ*ZZ(3,2))/(2._dp*sqrt(3._dp))
mat(1,2) = mat(1,2)+(g1*g2*Vn*v1*Conjg(ZZ(1,3))*RXiZp*ZZ(3,3))/6._dp
mat(1,2) = mat(1,2)+(g2**2*Vn*v1*Conjg(ZZ(2,3))*RXiZp*ZZ(3,3))/(2._dp*sqrt(3._dp))
mat(1,3) = 0._dp 
mat(1,3) = mat(1,3)+(ftri*v1)/sqrt(2._dp)
mat(1,3) = mat(1,3)+(-4*g1**2*Vn*v2*Conjg(ZZ(1,2))*RXiZ*ZZ(1,2))/9._dp
mat(1,3) = mat(1,3)+(-5*g1*g2*Vn*v2*Conjg(ZZ(2,2))*RXiZ*ZZ(1,2))/(6._dp*sqrt(3._dp))
mat(1,3) = mat(1,3)-(g1*g2*Vn*v2*Conjg(ZZ(3,2))*RXiZ*ZZ(1,2))/6._dp
mat(1,3) = mat(1,3)+(-4*g1**2*Vn*v2*Conjg(ZZ(1,3))*RXiZp*ZZ(1,3))/9._dp
mat(1,3) = mat(1,3)+(-5*g1*g2*Vn*v2*Conjg(ZZ(2,3))*RXiZp*ZZ(1,3))/(6._dp*sqrt(3._dp))
mat(1,3) = mat(1,3)-(g1*g2*Vn*v2*Conjg(ZZ(3,3))*RXiZp*ZZ(1,3))/6._dp
mat(1,3) = mat(1,3)+(-5*g1*g2*Vn*v2*Conjg(ZZ(1,2))*RXiZ*ZZ(2,2))/(6._dp*sqrt(3._dp))
mat(1,3) = mat(1,3)-(g2**2*Vn*v2*Conjg(ZZ(2,2))*RXiZ*ZZ(2,2))/3._dp
mat(1,3) = mat(1,3)-(g2**2*Vn*v2*Conjg(ZZ(3,2))*RXiZ*ZZ(2,2))/(2._dp*sqrt(3._dp))
mat(1,3) = mat(1,3)+(-5*g1*g2*Vn*v2*Conjg(ZZ(1,3))*RXiZp*ZZ(2,3))/(6._dp*sqrt(3._dp))
mat(1,3) = mat(1,3)-(g2**2*Vn*v2*Conjg(ZZ(2,3))*RXiZp*ZZ(2,3))/3._dp
mat(1,3) = mat(1,3)-(g2**2*Vn*v2*Conjg(ZZ(3,3))*RXiZp*ZZ(2,3))/(2._dp*sqrt(3._dp))
mat(1,3) = mat(1,3)-(g1*g2*Vn*v2*Conjg(ZZ(1,2))*RXiZ*ZZ(3,2))/6._dp
mat(1,3) = mat(1,3)-(g2**2*Vn*v2*Conjg(ZZ(2,2))*RXiZ*ZZ(3,2))/(2._dp*sqrt(3._dp))
mat(1,3) = mat(1,3)-(g1*g2*Vn*v2*Conjg(ZZ(1,3))*RXiZp*ZZ(3,3))/6._dp
mat(1,3) = mat(1,3)-(g2**2*Vn*v2*Conjg(ZZ(2,3))*RXiZp*ZZ(3,3))/(2._dp*sqrt(3._dp))
mat(2,2) = 0._dp 
mat(2,2) = mat(2,2)+mu22
mat(2,2) = mat(2,2)+l12*Vn**2
mat(2,2) = mat(2,2)+l2*v1**2
mat(2,2) = mat(2,2)+l23*v2**2
mat(2,2) = mat(2,2)+(2*g1**2*v1**2*Conjg(ZZ(1,2))*RXiZ*ZZ(1,2))/9._dp
mat(2,2) = mat(2,2)-(g1*g2*v1**2*Conjg(ZZ(2,2))*RXiZ*ZZ(1,2))/(3._dp*sqrt(3._dp))
mat(2,2) = mat(2,2)+(g1*g2*v1**2*Conjg(ZZ(3,2))*RXiZ*ZZ(1,2))/3._dp
mat(2,2) = mat(2,2)+(2*g1**2*v1**2*Conjg(ZZ(1,3))*RXiZp*ZZ(1,3))/9._dp
mat(2,2) = mat(2,2)-(g1*g2*v1**2*Conjg(ZZ(2,3))*RXiZp*ZZ(1,3))/(3._dp*sqrt(3._dp))
mat(2,2) = mat(2,2)+(g1*g2*v1**2*Conjg(ZZ(3,3))*RXiZp*ZZ(1,3))/3._dp
mat(2,2) = mat(2,2)-(g1*g2*v1**2*Conjg(ZZ(1,2))*RXiZ*ZZ(2,2))/(3._dp*sqrt(3._dp))
mat(2,2) = mat(2,2)+(g2**2*v1**2*Conjg(ZZ(2,2))*RXiZ*ZZ(2,2))/6._dp
mat(2,2) = mat(2,2)-(g2**2*v1**2*Conjg(ZZ(3,2))*RXiZ*ZZ(2,2))/(2._dp*sqrt(3._dp))
mat(2,2) = mat(2,2)-(g1*g2*v1**2*Conjg(ZZ(1,3))*RXiZp*ZZ(2,3))/(3._dp*sqrt(3._dp))
mat(2,2) = mat(2,2)+(g2**2*v1**2*Conjg(ZZ(2,3))*RXiZp*ZZ(2,3))/6._dp
mat(2,2) = mat(2,2)-(g2**2*v1**2*Conjg(ZZ(3,3))*RXiZp*ZZ(2,3))/(2._dp*sqrt(3._dp))
mat(2,2) = mat(2,2)+(g1*g2*v1**2*Conjg(ZZ(1,2))*RXiZ*ZZ(3,2))/3._dp
mat(2,2) = mat(2,2)-(g2**2*v1**2*Conjg(ZZ(2,2))*RXiZ*ZZ(3,2))/(2._dp*sqrt(3._dp))
mat(2,2) = mat(2,2)+(g2**2*v1**2*Conjg(ZZ(3,2))*RXiZ*ZZ(3,2))/2._dp
mat(2,2) = mat(2,2)+(g1*g2*v1**2*Conjg(ZZ(1,3))*RXiZp*ZZ(3,3))/3._dp
mat(2,2) = mat(2,2)-(g2**2*v1**2*Conjg(ZZ(2,3))*RXiZp*ZZ(3,3))/(2._dp*sqrt(3._dp))
mat(2,2) = mat(2,2)+(g2**2*v1**2*Conjg(ZZ(3,3))*RXiZp*ZZ(3,3))/2._dp
mat(2,3) = 0._dp 
mat(2,3) = mat(2,3)+(ftri*Vn)/sqrt(2._dp)
mat(2,3) = mat(2,3)+(-4*g1**2*v1*v2*Conjg(ZZ(1,2))*RXiZ*ZZ(1,2))/9._dp
mat(2,3) = mat(2,3)+(g1*g2*v1*v2*Conjg(ZZ(2,2))*RXiZ*ZZ(1,2))/(6._dp*sqrt(3._dp))
mat(2,3) = mat(2,3)-(g1*g2*v1*v2*Conjg(ZZ(3,2))*RXiZ*ZZ(1,2))/2._dp
mat(2,3) = mat(2,3)+(-4*g1**2*v1*v2*Conjg(ZZ(1,3))*RXiZp*ZZ(1,3))/9._dp
mat(2,3) = mat(2,3)+(g1*g2*v1*v2*Conjg(ZZ(2,3))*RXiZp*ZZ(1,3))/(6._dp*sqrt(3._dp))
mat(2,3) = mat(2,3)-(g1*g2*v1*v2*Conjg(ZZ(3,3))*RXiZp*ZZ(1,3))/2._dp
mat(2,3) = mat(2,3)+(g1*g2*v1*v2*Conjg(ZZ(1,2))*RXiZ*ZZ(2,2))/(6._dp*sqrt(3._dp))
mat(2,3) = mat(2,3)+(g2**2*v1*v2*Conjg(ZZ(2,2))*RXiZ*ZZ(2,2))/6._dp
mat(2,3) = mat(2,3)+(g1*g2*v1*v2*Conjg(ZZ(1,3))*RXiZp*ZZ(2,3))/(6._dp*sqrt(3._dp))
mat(2,3) = mat(2,3)+(g2**2*v1*v2*Conjg(ZZ(2,3))*RXiZp*ZZ(2,3))/6._dp
mat(2,3) = mat(2,3)-(g1*g2*v1*v2*Conjg(ZZ(1,2))*RXiZ*ZZ(3,2))/2._dp
mat(2,3) = mat(2,3)-(g2**2*v1*v2*Conjg(ZZ(3,2))*RXiZ*ZZ(3,2))/2._dp
mat(2,3) = mat(2,3)-(g1*g2*v1*v2*Conjg(ZZ(1,3))*RXiZp*ZZ(3,3))/2._dp
mat(2,3) = mat(2,3)-(g2**2*v1*v2*Conjg(ZZ(3,3))*RXiZp*ZZ(3,3))/2._dp
mat(3,3) = 0._dp 
mat(3,3) = mat(3,3)+mu32
mat(3,3) = mat(3,3)+l13*Vn**2
mat(3,3) = mat(3,3)+l23*v1**2
mat(3,3) = mat(3,3)+(2*l3*v2**2)/3._dp
mat(3,3) = mat(3,3)+(8*g1**2*v2**2*Conjg(ZZ(1,2))*RXiZ*ZZ(1,2))/9._dp
mat(3,3) = mat(3,3)+(2*g1*g2*v2**2*Conjg(ZZ(2,2))*RXiZ*ZZ(1,2))/(3._dp*sqrt(3._dp))
mat(3,3) = mat(3,3)+(2*g1*g2*v2**2*Conjg(ZZ(3,2))*RXiZ*ZZ(1,2))/3._dp
mat(3,3) = mat(3,3)+(8*g1**2*v2**2*Conjg(ZZ(1,3))*RXiZp*ZZ(1,3))/9._dp
mat(3,3) = mat(3,3)+(2*g1*g2*v2**2*Conjg(ZZ(2,3))*RXiZp*ZZ(1,3))/(3._dp*sqrt(3._dp))
mat(3,3) = mat(3,3)+(2*g1*g2*v2**2*Conjg(ZZ(3,3))*RXiZp*ZZ(1,3))/3._dp
mat(3,3) = mat(3,3)+(2*g1*g2*v2**2*Conjg(ZZ(1,2))*RXiZ*ZZ(2,2))/(3._dp*sqrt(3._dp))
mat(3,3) = mat(3,3)+(g2**2*v2**2*Conjg(ZZ(2,2))*RXiZ*ZZ(2,2))/6._dp
mat(3,3) = mat(3,3)+(g2**2*v2**2*Conjg(ZZ(3,2))*RXiZ*ZZ(2,2))/(2._dp*sqrt(3._dp))
mat(3,3) = mat(3,3)+(2*g1*g2*v2**2*Conjg(ZZ(1,3))*RXiZp*ZZ(2,3))/(3._dp*sqrt(3._dp))
mat(3,3) = mat(3,3)+(g2**2*v2**2*Conjg(ZZ(2,3))*RXiZp*ZZ(2,3))/6._dp
mat(3,3) = mat(3,3)+(g2**2*v2**2*Conjg(ZZ(3,3))*RXiZp*ZZ(2,3))/(2._dp*sqrt(3._dp))
mat(3,3) = mat(3,3)+(2*g1*g2*v2**2*Conjg(ZZ(1,2))*RXiZ*ZZ(3,2))/3._dp
mat(3,3) = mat(3,3)+(g2**2*v2**2*Conjg(ZZ(2,2))*RXiZ*ZZ(3,2))/(2._dp*sqrt(3._dp))
mat(3,3) = mat(3,3)+(g2**2*v2**2*Conjg(ZZ(3,2))*RXiZ*ZZ(3,2))/2._dp
mat(3,3) = mat(3,3)+(2*g1*g2*v2**2*Conjg(ZZ(1,3))*RXiZp*ZZ(3,3))/3._dp
mat(3,3) = mat(3,3)+(g2**2*v2**2*Conjg(ZZ(2,3))*RXiZp*ZZ(3,3))/(2._dp*sqrt(3._dp))
mat(3,3) = mat(3,3)+(g2**2*v2**2*Conjg(ZZ(3,3))*RXiZp*ZZ(3,3))/2._dp

 
 Do i1=2,3
  Do i2 = 1, i1-1 
  mat(i1,i2) = mat(i2,i1) 
  End do 
End do 

 
Call EigenSystem(mat,MAh2,ZA,ierr,test) 
 
 
If ((ierr.Eq.-8).Or.(ierr.Eq.-9)) Then 
  Write(ErrCan,*) "Possible numerical problem in "//NameOfUnit(Iname) 
  If (ErrorLevel.Eq.2) Then 
  Write(*,*) "Possible numerical problem in "//NameOfUnit(Iname) 
    Call TerminateProgram 
  End If 
  ierr = 0 
End If 
 
If ((ierr.Ne.0.).And.(ErrorLevel.Ge.-1)) Then 
  Write(10,*) 'Warning from Subroutine '//NameOfUnit(Iname) 
  Write(10,*) 'Diagonalization failed, ierr : ',ierr 
  kont = ierr 
  Iname = Iname - 1 
  Return 
End If 


Do i1=1,3
  If (Abs(MAh2(i1)).Le.MaxMassNumericalZero) MAh2(i1) = 1.E-10_dp 
  If (MAh2(i1).ne.MAh2(i1)) Then 
      Write(*,*) 'NaN appearing in '//NameOfUnit(Iname) 
      Call TerminateProgram 
    End If 
  If (MAh2(i1).Ge.0._dp) Then 
  MAh(i1)=Sqrt(MAh2(i1) ) 
  Else 
    If (ErrorLevel.Ge.0) Then 
      Write(10,*) 'Warning from Subroutine '//NameOfUnit(Iname) 
      Write(10,*) 'a mass squarred is negative: ',i1,MAh2(i1) 
    End If 
  MAh(i1) = 1._dp 
     Write(ErrCan,*) 'Warning from routine '//NameOfUnit(Iname) 
     Write(ErrCan,*) 'in the calculation of the masses' 
     Write(ErrCan,*) 'occurred a negative mass squared!' 
     Write(ErrCan,*) i1,MAh2(i1) 
     Write(*,*) 'Warning from routine '//NameOfUnit(Iname) 
     Write(*,*) 'in the calculation of the masses' 
     Write(*,*) 'occurred a negative mass squared!' 
     Write(*,*) i1,MAh2(i1) 
  MAh2(i1) = 1._dp 
   SignOfMassChanged = .True. 
! kont = -104 
 End if 
End Do 
Iname = Iname - 1 
 
End Subroutine CalculateMAh 

Subroutine CalculateMHpm(g2,mu12,mu22,mu32,ftri,l1,l12,l13,l13t,l2,l23,               & 
& l23t,l3,Vn,v1,v2,ZP,MHpm,MHpm2,kont)

Real(dp), Intent(in) :: g2,mu12,mu22,mu32,ftri,Vn,v1,v2

Complex(dp), Intent(in) :: l1,l12,l13,l13t,l2,l23,l23t,l3

Integer, Intent(inout) :: kont 
Integer :: i1,i2,i3,i4, ierr 
Integer :: j1,j2,j3,j4, pos 
Real(dp), Intent(out) :: MHpm(4), MHpm2(4) 
Complex(dp), Intent(out) :: ZP(4,4) 
 
Complex(dp) :: mat(4,4)  

Real(dp) ::  test(2) 

Iname = Iname + 1 
NameOfUnit(Iname) = 'CalculateMHpm'
 
mat(1,1) = 0._dp 
mat(1,1) = mat(1,1)-1._dp*(mu12)
mat(1,1) = mat(1,1)+l1*Vn**2
mat(1,1) = mat(1,1)+l12*v1**2
mat(1,1) = mat(1,1)+l13*v2**2
mat(1,1) = mat(1,1)+l13t*v2**2
mat(1,1) = mat(1,1)+(g2**2*Vn**2*RXiXp)/2._dp
mat(1,2) = 0._dp 
mat(1,3) = 0._dp 
mat(1,4) = 0._dp 
mat(1,4) = mat(1,4)+sqrt(2._dp)*ftri*v1
mat(1,4) = mat(1,4)+l13t*Vn*v2
mat(1,4) = mat(1,4)-(g2**2*Vn*v2*RXiXp)/2._dp
mat(2,2) = 0._dp 
mat(2,2) = mat(2,2)+mu22
mat(2,2) = mat(2,2)+l12*Vn**2
mat(2,2) = mat(2,2)+l2*v1**2
mat(2,2) = mat(2,2)+l23*v2**2
mat(2,2) = mat(2,2)+l23t*v2**2
mat(2,2) = mat(2,2)+(g2**2*v1**2*RXiWp)/2._dp
mat(2,3) = 0._dp 
mat(2,3) = mat(2,3)+sqrt(2._dp)*ftri*Vn
mat(2,3) = mat(2,3)+l23t*v1*v2
mat(2,3) = mat(2,3)-(g2**2*v1*v2*RXiWp)/2._dp
mat(2,4) = 0._dp 
mat(3,3) = 0._dp 
mat(3,3) = mat(3,3)+mu32
mat(3,3) = mat(3,3)+l13*Vn**2
mat(3,3) = mat(3,3)+l23*v1**2
mat(3,3) = mat(3,3)+l23t*v1**2
mat(3,3) = mat(3,3)+(2*l3*v2**2)/3._dp
mat(3,3) = mat(3,3)+(g2**2*v2**2*RXiWp)/2._dp
mat(3,4) = 0._dp 
mat(4,4) = 0._dp 
mat(4,4) = mat(4,4)+mu32
mat(4,4) = mat(4,4)+l13*Vn**2
mat(4,4) = mat(4,4)+l13t*Vn**2
mat(4,4) = mat(4,4)+l23*v1**2
mat(4,4) = mat(4,4)+(2*l3*v2**2)/3._dp
mat(4,4) = mat(4,4)+(g2**2*v2**2*RXiXp)/2._dp

 
 Do i1=2,4
  Do i2 = 1, i1-1 
  mat(i1,i2) = Conjg(mat(i2,i1)) 
  End do 
End do 

 
Call EigenSystem(mat,MHpm2,ZP,ierr,test) 
 
 
If ((ierr.Eq.-8).Or.(ierr.Eq.-9)) Then 
  Write(ErrCan,*) "Possible numerical problem in "//NameOfUnit(Iname) 
  If (ErrorLevel.Eq.2) Then 
  Write(*,*) "Possible numerical problem in "//NameOfUnit(Iname) 
    Call TerminateProgram 
  End If 
  ierr = 0 
End If 
 
If ((ierr.Ne.0.).And.(ErrorLevel.Ge.-1)) Then 
  Write(10,*) 'Warning from Subroutine '//NameOfUnit(Iname) 
  Write(10,*) 'Diagonalization failed, ierr : ',ierr 
  kont = ierr 
  Iname = Iname - 1 
  Return 
End If 


Do i1=1,4
  If (Abs(MHpm2(i1)).Le.MaxMassNumericalZero) MHpm2(i1) = 1.E-10_dp 
  If (MHpm2(i1).ne.MHpm2(i1)) Then 
      Write(*,*) 'NaN appearing in '//NameOfUnit(Iname) 
      Call TerminateProgram 
    End If 
  If (MHpm2(i1).Ge.0._dp) Then 
  MHpm(i1)=Sqrt(MHpm2(i1) ) 
  Else 
    If (ErrorLevel.Ge.0) Then 
      Write(10,*) 'Warning from Subroutine '//NameOfUnit(Iname) 
      Write(10,*) 'a mass squarred is negative: ',i1,MHpm2(i1) 
    End If 
  MHpm(i1) = 1._dp 
     Write(ErrCan,*) 'Warning from routine '//NameOfUnit(Iname) 
     Write(ErrCan,*) 'in the calculation of the masses' 
     Write(ErrCan,*) 'occurred a negative mass squared!' 
     Write(ErrCan,*) i1,MHpm2(i1) 
     Write(*,*) 'Warning from routine '//NameOfUnit(Iname) 
     Write(*,*) 'in the calculation of the masses' 
     Write(*,*) 'occurred a negative mass squared!' 
     Write(*,*) i1,MHpm2(i1) 
  MHpm2(i1) = 1._dp 
   SignOfMassChanged = .True. 
! kont = -104 
 End if 
End Do 
Iname = Iname - 1 
 
End Subroutine CalculateMHpm 

Subroutine CalculateMDpm(mu12,mu22,ftri,l1,l12,l13,l12t,l2,l23,Vn,v1,v2,              & 
& zy,MDpm,MDpm2,kont)

Real(dp), Intent(in) :: mu12,mu22,ftri,Vn,v1,v2

Complex(dp), Intent(in) :: l1,l12,l13,l12t,l2,l23

Integer, Intent(inout) :: kont 
Integer :: i1,i2,i3,i4, ierr 
Integer :: j1,j2,j3,j4, pos 
Real(dp), Intent(out) :: MDpm(2), MDpm2(2) 
Complex(dp), Intent(out) :: zy(2,2) 
 
Complex(dp) :: mat(2,2)  

Real(dp) ::  test(2) 

Iname = Iname + 1 
NameOfUnit(Iname) = 'CalculateMDpm'
 
mat(1,1) = 0._dp 
mat(1,1) = mat(1,1)-1._dp*(mu12)
mat(1,1) = mat(1,1)+l1*Vn**2
mat(1,1) = mat(1,1)+l12*v1**2
mat(1,1) = mat(1,1)+l12t*v1**2
mat(1,1) = mat(1,1)+l13*v2**2
mat(1,2) = 0._dp 
mat(1,2) = mat(1,2)+l12t*Vn*v1
mat(1,2) = mat(1,2)+sqrt(2._dp)*ftri*v2
mat(2,2) = 0._dp 
mat(2,2) = mat(2,2)+mu22
mat(2,2) = mat(2,2)+l12*Vn**2
mat(2,2) = mat(2,2)+l12t*Vn**2
mat(2,2) = mat(2,2)+l2*v1**2
mat(2,2) = mat(2,2)+l23*v2**2

 
 Do i1=2,2
  Do i2 = 1, i1-1 
  mat(i1,i2) = Conjg(mat(i2,i1)) 
  End do 
End do 

 
Call EigenSystem(mat,MDpm2,zy,ierr,test) 
 
 
If ((ierr.Eq.-8).Or.(ierr.Eq.-9)) Then 
  Write(ErrCan,*) "Possible numerical problem in "//NameOfUnit(Iname) 
  If (ErrorLevel.Eq.2) Then 
  Write(*,*) "Possible numerical problem in "//NameOfUnit(Iname) 
    Call TerminateProgram 
  End If 
  ierr = 0 
End If 
 
If ((ierr.Ne.0.).And.(ErrorLevel.Ge.-1)) Then 
  Write(10,*) 'Warning from Subroutine '//NameOfUnit(Iname) 
  Write(10,*) 'Diagonalization failed, ierr : ',ierr 
  kont = ierr 
  Iname = Iname - 1 
  Return 
End If 


Do i1=1,2
  If (Abs(MDpm2(i1)).Le.MaxMassNumericalZero) MDpm2(i1) = 1.E-10_dp 
  If (MDpm2(i1).ne.MDpm2(i1)) Then 
      Write(*,*) 'NaN appearing in '//NameOfUnit(Iname) 
      Call TerminateProgram 
    End If 
  If (MDpm2(i1).Ge.0._dp) Then 
  MDpm(i1)=Sqrt(MDpm2(i1) ) 
  Else 
    If (ErrorLevel.Ge.0) Then 
      Write(10,*) 'Warning from Subroutine '//NameOfUnit(Iname) 
      Write(10,*) 'a mass squarred is negative: ',i1,MDpm2(i1) 
    End If 
  MDpm(i1) = 1._dp 
     Write(ErrCan,*) 'Warning from routine '//NameOfUnit(Iname) 
     Write(ErrCan,*) 'in the calculation of the masses' 
     Write(ErrCan,*) 'occurred a negative mass squared!' 
     Write(ErrCan,*) i1,MDpm2(i1) 
     Write(*,*) 'Warning from routine '//NameOfUnit(Iname) 
     Write(*,*) 'in the calculation of the masses' 
     Write(*,*) 'occurred a negative mass squared!' 
     Write(*,*) i1,MDpm2(i1) 
  MDpm2(i1) = 1._dp 
   SignOfMassChanged = .True. 
! kont = -104 
 End if 
End Do 
Iname = Iname - 1 
 
End Subroutine CalculateMDpm 

Subroutine CalculateMFd(hdp11,hd1,hdtp11,hdt1,hdp1,hd2,hdtp1,hdt2,hd3,hdt3,           & 
& Vn,v1,v2,Vd,Ud,MFd,kont)

Real(dp),Intent(in) :: Vn,v1,v2

Complex(dp),Intent(in) :: hdp11(3),hd1(3),hdtp11(2),hdt1(2),hdp1(3),hd2(3),hdtp1(2),hdt2(2),hd3(3),hdt3(2)

Integer, Intent(inout) :: kont 
Integer :: i1,i2,i3,i4, ierr 
Integer :: j1,j2,j3,j4 
Real(dp), Intent(out) :: MFd(5) 
 Complex(dp), Intent(out) :: Vd(5,5), Ud(5,5) 
 
 Complex(dp) :: mat(5,5)=0._dp, mat2(5,5)=0._dp, phaseM 

Complex(dp) :: Vd2(5,5), Ud2(5,5) 
 
 Real(dp) :: Vd1(5,5), Ud1(5,5), test(2), MFd2(5) 
 
 Iname = Iname + 1 
NameOfUnit(Iname) = 'CalculateMFd'
 
MFd = 0._dp 
Vd = 0._dp 
Ud = 0._dp 
mat(1,1) = 0._dp 
mat(1,1) = mat(1,1)+v1*hd1(1)
mat(1,2) = 0._dp 
mat(1,2) = mat(1,2)+v1*hd1(2)
mat(1,3) = 0._dp 
mat(1,3) = mat(1,3)+v1*hd1(3)
mat(1,4) = 0._dp 
mat(1,4) = mat(1,4)+v1*hdt1(1)
mat(1,5) = 0._dp 
mat(1,5) = mat(1,5)+v1*hdt1(2)
mat(2,1) = 0._dp 
mat(2,1) = mat(2,1)+v1*hd2(1)
mat(2,2) = 0._dp 
mat(2,2) = mat(2,2)+v1*hd2(2)
mat(2,3) = 0._dp 
mat(2,3) = mat(2,3)+v1*hd2(3)
mat(2,4) = 0._dp 
mat(2,4) = mat(2,4)+v1*hdt2(1)
mat(2,5) = 0._dp 
mat(2,5) = mat(2,5)+v1*hdt2(2)
mat(3,1) = 0._dp 
mat(3,1) = mat(3,1)+v2*hd3(1)
mat(3,2) = 0._dp 
mat(3,2) = mat(3,2)+v2*hd3(2)
mat(3,3) = 0._dp 
mat(3,3) = mat(3,3)+v2*hd3(3)
mat(3,4) = 0._dp 
mat(3,4) = mat(3,4)+v2*hdt3(1)
mat(3,5) = 0._dp 
mat(3,5) = mat(3,5)+v2*hdt3(2)
mat(4,1) = 0._dp 
mat(4,1) = mat(4,1)+Vn*hdp11(1)
mat(4,2) = 0._dp 
mat(4,2) = mat(4,2)+Vn*hdp11(2)
mat(4,3) = 0._dp 
mat(4,3) = mat(4,3)+Vn*hdp11(3)
mat(4,4) = 0._dp 
mat(4,4) = mat(4,4)+Vn*hdtp11(1)
mat(4,5) = 0._dp 
mat(4,5) = mat(4,5)+Vn*hdtp11(2)
mat(5,1) = 0._dp 
mat(5,1) = mat(5,1)+Vn*hdp1(1)
mat(5,2) = 0._dp 
mat(5,2) = mat(5,2)+Vn*hdp1(2)
mat(5,3) = 0._dp 
mat(5,3) = mat(5,3)+Vn*hdp1(3)
mat(5,4) = 0._dp 
mat(5,4) = mat(5,4)+Vn*hdtp1(1)
mat(5,5) = 0._dp 
mat(5,5) = mat(5,5)+Vn*hdtp1(2)

 
mat2 = Matmul(Transpose(Conjg(mat)),mat) 
If (Maxval(Abs(Aimag(mat2))).Eq.0._dp) Then 
Call EigenSystem(Real(mat2,dp),MFd2,Ud1,ierr,test) 
Ud2 = Ud1 
Else 
Call EigenSystem(mat2,MFd2,Ud2,ierr,test) 
 End If 
 
If ((ierr.Eq.-8).Or.(ierr.Eq.-9)) Then 
  Write(ErrCan,*) "Possible numerical problem in "//NameOfUnit(Iname) 
  If (ErrorLevel.Eq.2) Then 
  Write(*,*) "Possible numerical problem in "//NameOfUnit(Iname) 
    Call TerminateProgram 
  End If 
  ierr = 0 
End If 
 
mat2 = Matmul(mat,Transpose(Conjg(mat))) 
If (Maxval(Abs(Aimag(mat2))).Eq.0._dp) Then 
Call EigenSystem (Real(mat2,dp),MFd2,Vd1,ierr,test) 
                  
                  
Vd2 = Vd1 
Else 
Call EigenSystem(mat2,MFd2,Vd2,ierr,test) 
 
 
End If 
Vd2 = Conjg(Vd2) 
 
If ((ierr.Eq.-8).Or.(ierr.Eq.-9)) Then 
  Write(ErrCan,*) "Possible numerical problem in "//NameOfUnit(Iname) 
  If (ErrorLevel.Eq.2) Then 
  Write(*,*) "Possible numerical problem in "//NameOfUnit(Iname) 
    Call TerminateProgram 
  End If 
  ierr = 0 
End If 
 
mat2 = Matmul(Matmul( Conjg(Vd2),mat),Transpose( Conjg(Ud2))) 
Do i1=1,5
If (Abs(mat2(i1,i1)).gt.0._dp) Then 
phaseM = mat2(i1,i1) / Abs(mat2(i1,i1)) 
Ud2(i1,:) = phaseM *Ud2(i1,:) 
 End if 
End Do 
 
Do i1=1,5
If (Abs(Ud2(i1,i1)).gt.0._dp) Then 
phaseM = Ud2(i1,i1) / Abs(Ud2(i1,i1)) 
Ud2(i1,:) = Conjg(phaseM) *Ud2(i1,:) 
 Vd2(i1,:) = phaseM *Vd2(i1,:) 
 End if 
  If (MFd2(i1).ne.MFd2(i1)) Then 
      Write(*,*) 'NaN appearing in '//NameOfUnit(Iname) 
      Call TerminateProgram 
    End If 
  If (Abs(MFd2(i1)).Le.MaxMassNumericalZero) MFd2(i1) = Abs(MFd2(i1))+1.E-10_dp 
  If (MFd2(i1).Le.0._dp) Then 
    If (ErrorLevel.Ge.0) Then 
      Write(10,*) 'Warning from Subroutine '//NameOfUnit(Iname) 
      Write(10,*) 'a mass squarred is negative: ',i1,MFd2(i1) 
      Write(*,*) 'Warning from Subroutine '//NameOfUnit(Iname) 
      Write(*,*) 'a mass squarred is negative: ',i1,MFd2(i1) 
      Call TerminateProgram 
    End If 
     Write(ErrCan,*) 'Warning from routine '//NameOfUnit(Iname) 
     Write(ErrCan,*) 'in the calculation of the masses' 
     Write(ErrCan,*) 'occurred a negative mass squared!' 
     Write(ErrCan,*) i1,MFd2(i1) 
     Write(*,*) 'Warning from routine '//NameOfUnit(Iname) 
     Write(*,*) 'in the calculation of the masses' 
     Write(*,*) 'occurred a negative mass squared!' 
     Write(*,*) i1,MFd2(i1) 
  MFd2(i1) = 1._dp 
   SignOfMassChanged = .True. 
! kont = -104 
 End if 
End Do 
 
If (ierr.Ne.0.) Then 
  Write(ErrCan,*) 'Warning from Subroutine CalculateMFd, ierr =',ierr 
  kont = ierr 
  Iname = Iname - 1 
  Return 
End If 


MFd = Sqrt( MFd2 ) 
Vd = Vd2 
Ud = Ud2 
Iname = Iname - 1 
 
End Subroutine CalculateMFd 

Subroutine CalculateMFu(hup11,hUp1,hup21,hUp2,hu11,h12,hU1,hU2,Vn,v1,v2,              & 
& Vu,Uu,MFu,kont)

Real(dp),Intent(in) :: Vn,v1,v2

Complex(dp),Intent(in) :: hup11(3),hUp1,hup21(3),hUp2,hu11(3),h12(3),hU1,hU2

Integer, Intent(inout) :: kont 
Integer :: i1,i2,i3,i4, ierr 
Integer :: j1,j2,j3,j4 
Real(dp), Intent(out) :: MFu(4) 
 Complex(dp), Intent(out) :: Vu(4,4), Uu(4,4) 
 
 Complex(dp) :: mat(4,4)=0._dp, mat2(4,4)=0._dp, phaseM 

Complex(dp) :: Vu2(4,4), Uu2(4,4) 
 
 Real(dp) :: Vu1(4,4), Uu1(4,4), test(2), MFu2(4) 
 
 Iname = Iname + 1 
NameOfUnit(Iname) = 'CalculateMFu'
 
MFu = 0._dp 
Vu = 0._dp 
Uu = 0._dp 
mat(1,1) = 0._dp 
mat(1,1) = mat(1,1)+v2*hup11(1)
mat(1,2) = 0._dp 
mat(1,2) = mat(1,2)+v2*hup11(2)
mat(1,3) = 0._dp 
mat(1,3) = mat(1,3)+v2*hup11(3)
mat(1,4) = 0._dp 
mat(1,4) = mat(1,4)+hUp1*v2
mat(2,1) = 0._dp 
mat(2,1) = mat(2,1)+v2*hup21(1)
mat(2,2) = 0._dp 
mat(2,2) = mat(2,2)+v2*hup21(2)
mat(2,3) = 0._dp 
mat(2,3) = mat(2,3)+v2*hup21(3)
mat(2,4) = 0._dp 
mat(2,4) = mat(2,4)+hUp2*v2
mat(3,1) = 0._dp 
mat(3,1) = mat(3,1)+v1*h12(1)
mat(3,2) = 0._dp 
mat(3,2) = mat(3,2)+v1*h12(2)
mat(3,3) = 0._dp 
mat(3,3) = mat(3,3)+v1*h12(3)
mat(3,4) = 0._dp 
mat(3,4) = mat(3,4)+hU2*v1
mat(4,1) = 0._dp 
mat(4,1) = mat(4,1)+Vn*hu11(1)
mat(4,2) = 0._dp 
mat(4,2) = mat(4,2)+Vn*hu11(2)
mat(4,3) = 0._dp 
mat(4,3) = mat(4,3)+Vn*hu11(3)
mat(4,4) = 0._dp 
mat(4,4) = mat(4,4)+hU1*Vn

 
mat2 = Matmul(Transpose(Conjg(mat)),mat) 
If (Maxval(Abs(Aimag(mat2))).Eq.0._dp) Then 
Call EigenSystem(Real(mat2,dp),MFu2,Uu1,ierr,test) 
Uu2 = Uu1 
Else 
Call EigenSystem(mat2,MFu2,Uu2,ierr,test) 
 End If 
 
If ((ierr.Eq.-8).Or.(ierr.Eq.-9)) Then 
  Write(ErrCan,*) "Possible numerical problem in "//NameOfUnit(Iname) 
  If (ErrorLevel.Eq.2) Then 
  Write(*,*) "Possible numerical problem in "//NameOfUnit(Iname) 
    Call TerminateProgram 
  End If 
  ierr = 0 
End If 
 
mat2 = Matmul(mat,Transpose(Conjg(mat))) 
If (Maxval(Abs(Aimag(mat2))).Eq.0._dp) Then 
Call EigenSystem (Real(mat2,dp),MFu2,Vu1,ierr,test) 
                  
                  
Vu2 = Vu1 
Else 
Call EigenSystem(mat2,MFu2,Vu2,ierr,test) 
 
 
End If 
Vu2 = Conjg(Vu2) 
 
If ((ierr.Eq.-8).Or.(ierr.Eq.-9)) Then 
  Write(ErrCan,*) "Possible numerical problem in "//NameOfUnit(Iname) 
  If (ErrorLevel.Eq.2) Then 
  Write(*,*) "Possible numerical problem in "//NameOfUnit(Iname) 
    Call TerminateProgram 
  End If 
  ierr = 0 
End If 
 
mat2 = Matmul(Matmul( Conjg(Vu2),mat),Transpose( Conjg(Uu2))) 
Do i1=1,4
If (Abs(mat2(i1,i1)).gt.0._dp) Then 
phaseM = mat2(i1,i1) / Abs(mat2(i1,i1)) 
Uu2(i1,:) = phaseM *Uu2(i1,:) 
 End if 
End Do 
 
Do i1=1,4
If (Abs(Uu2(i1,i1)).gt.0._dp) Then 
phaseM = Uu2(i1,i1) / Abs(Uu2(i1,i1)) 
Uu2(i1,:) = Conjg(phaseM) *Uu2(i1,:) 
 Vu2(i1,:) = phaseM *Vu2(i1,:) 
 End if 
  If (MFu2(i1).ne.MFu2(i1)) Then 
      Write(*,*) 'NaN appearing in '//NameOfUnit(Iname) 
      Call TerminateProgram 
    End If 
  If (Abs(MFu2(i1)).Le.MaxMassNumericalZero) MFu2(i1) = 0!Abs(MFu2(i1))+1.E-10_dp 
  If (MFu2(i1).Lt.0._dp) Then 
    If (ErrorLevel.Ge.0) Then 
      Write(10,*) 'Warning from Subroutine '//NameOfUnit(Iname) 
      Write(10,*) 'a mass squarred is negative: ',i1,MFu2(i1) 
      Write(*,*) 'Warning from Subroutine '//NameOfUnit(Iname) 
      Write(*,*) 'a mass squarred is negative: ',i1,MFu2(i1) 
      Call TerminateProgram 
    End If 
     Write(ErrCan,*) 'Warning from routine '//NameOfUnit(Iname) 
     Write(ErrCan,*) 'in the calculation of the masses' 
     Write(ErrCan,*) 'occurred a negative mass squared!' 
     Write(ErrCan,*) i1,MFu2(i1) 
     Write(*,*) 'Warning from routine '//NameOfUnit(Iname) 
     Write(*,*) 'in the calculation of the masses' 
     Write(*,*) 'occurred a negative mass squared!' 
     Write(*,*) i1,MFu2(i1) 
  MFu2(i1) = 1._dp 
   SignOfMassChanged = .True. 
! kont = -104 
 End if 
End Do 
 
If (ierr.Ne.0.) Then 
  Write(ErrCan,*) 'Warning from Subroutine CalculateMFu, ierr =',ierr 
  kont = ierr 
  Iname = Iname - 1 
  Return 
End If 


MFu = Sqrt( MFu2 ) 
Vu = Vu2 
Uu = Uu2 
Iname = Iname - 1 
 
End Subroutine CalculateMFu 

Subroutine CalculateMFe(hll1,v2,Ve,Ue,MFe,kont)

Real(dp),Intent(in) :: v2

Complex(dp),Intent(in) :: hll1(3,3)

Integer, Intent(inout) :: kont 
Integer :: i1,i2,i3,i4, ierr 
Integer :: j1,j2,j3,j4 
Real(dp), Intent(out) :: MFe(3) 
 Complex(dp), Intent(out) :: Ve(3,3), Ue(3,3) 
 
 Complex(dp) :: mat(3,3)=0._dp, mat2(3,3)=0._dp, phaseM 

Complex(dp) :: Ve2(3,3), Ue2(3,3) 
 
 Real(dp) :: Ve1(3,3), Ue1(3,3), test(2), MFe2(3) 
 
 Iname = Iname + 1 
NameOfUnit(Iname) = 'CalculateMFe'
 
MFe = 0._dp 
Ve = 0._dp 
Ue = 0._dp 
mat(1,1) = 0._dp 
mat(1,1) = mat(1,1)+v2*hll1(1,1)
mat(1,2) = 0._dp 
mat(1,2) = mat(1,2)+v2*hll1(1,2)
mat(1,3) = 0._dp 
mat(1,3) = mat(1,3)+v2*hll1(1,3)
mat(2,1) = 0._dp 
mat(2,1) = mat(2,1)+v2*hll1(2,1)
mat(2,2) = 0._dp 
mat(2,2) = mat(2,2)+v2*hll1(2,2)
mat(2,3) = 0._dp 
mat(2,3) = mat(2,3)+v2*hll1(2,3)
mat(3,1) = 0._dp 
mat(3,1) = mat(3,1)+v2*hll1(3,1)
mat(3,2) = 0._dp 
mat(3,2) = mat(3,2)+v2*hll1(3,2)
mat(3,3) = 0._dp 
mat(3,3) = mat(3,3)+v2*hll1(3,3)

 
mat2 = Matmul(Transpose(Conjg(mat)),mat) 
If (Maxval(Abs(Aimag(mat2))).Eq.0._dp) Then 
Call EigenSystem(Real(mat2,dp),MFe2,Ue1,ierr,test) 
Ue2 = Ue1 
Else 
Call EigenSystem(mat2,MFe2,Ue2,ierr,test) 
 End If 
 
If ((ierr.Eq.-8).Or.(ierr.Eq.-9)) Then 
  Write(ErrCan,*) "Possible numerical problem in "//NameOfUnit(Iname) 
  If (ErrorLevel.Eq.2) Then 
  Write(*,*) "Possible numerical problem in "//NameOfUnit(Iname) 
    Call TerminateProgram 
  End If 
  ierr = 0 
End If 
 
mat2 = Matmul(mat,Transpose(Conjg(mat))) 
If (Maxval(Abs(Aimag(mat2))).Eq.0._dp) Then 
Call EigenSystem (Real(mat2,dp),MFe2,Ve1,ierr,test) 
                  
                  
Ve2 = Ve1 
Else 
Call EigenSystem(mat2,MFe2,Ve2,ierr,test) 
 
 
End If 
Ve2 = Conjg(Ve2) 
 
If ((ierr.Eq.-8).Or.(ierr.Eq.-9)) Then 
  Write(ErrCan,*) "Possible numerical problem in "//NameOfUnit(Iname) 
  If (ErrorLevel.Eq.2) Then 
  Write(*,*) "Possible numerical problem in "//NameOfUnit(Iname) 
    Call TerminateProgram 
  End If 
  ierr = 0 
End If 
 
mat2 = Matmul(Matmul( Conjg(Ve2),mat),Transpose( Conjg(Ue2))) 
Do i1=1,3
If (Abs(mat2(i1,i1)).gt.0._dp) Then 
phaseM = mat2(i1,i1) / Abs(mat2(i1,i1)) 
Ue2(i1,:) = phaseM *Ue2(i1,:) 
 End if 
End Do 
 
Do i1=1,3
If (Abs(Ue2(i1,i1)).gt.0._dp) Then 
phaseM = Ue2(i1,i1) / Abs(Ue2(i1,i1)) 
Ue2(i1,:) = Conjg(phaseM) *Ue2(i1,:) 
 Ve2(i1,:) = phaseM *Ve2(i1,:) 
 End if 
  If (MFe2(i1).ne.MFe2(i1)) Then 
      Write(*,*) 'NaN appearing in '//NameOfUnit(Iname) 
      Call TerminateProgram 
    End If 
  If (Abs(MFe2(i1)).Le.MaxMassNumericalZero) MFe2(i1) = Abs(MFe2(i1))+1.E-10_dp 
  If (MFe2(i1).Le.0._dp) Then 
    If (ErrorLevel.Ge.0) Then 
      Write(10,*) 'Warning from Subroutine '//NameOfUnit(Iname) 
      Write(10,*) 'a mass squarred is negative: ',i1,MFe2(i1) 
      Write(*,*) 'Warning from Subroutine '//NameOfUnit(Iname) 
      Write(*,*) 'a mass squarred is negative: ',i1,MFe2(i1) 
      Call TerminateProgram 
    End If 
     Write(ErrCan,*) 'Warning from routine '//NameOfUnit(Iname) 
     Write(ErrCan,*) 'in the calculation of the masses' 
     Write(ErrCan,*) 'occurred a negative mass squared!' 
     Write(ErrCan,*) i1,MFe2(i1) 
     Write(*,*) 'Warning from routine '//NameOfUnit(Iname) 
     Write(*,*) 'in the calculation of the masses' 
     Write(*,*) 'occurred a negative mass squared!' 
     Write(*,*) i1,MFe2(i1) 
  MFe2(i1) = 1._dp 
   SignOfMassChanged = .True. 
! kont = -104 
 End if 
End Do 
 
If (ierr.Ne.0.) Then 
  Write(ErrCan,*) 'Warning from Subroutine CalculateMFe, ierr =',ierr 
  kont = ierr 
  Iname = Iname - 1 
  Return 
End If 


MFe = Sqrt( MFe2 ) 
Ve = Ve2 
Ue = Ue2 
Iname = Iname - 1 
 
End Subroutine CalculateMFe 

Subroutine CalculateVPVZVZp(g1,g2,Vn,v1,v2,ZZ,MVZ,MVZp,MVZ2,MVZp2,kont)

Real(dp), Intent(in) :: g1,g2,Vn,v1,v2

Integer, Intent(inout) :: kont 
Integer :: i1,i2,i3,i4, ierr 
Integer :: j1,j2,j3,j4 
Real(dp), Intent(out) :: MVZ, MVZ2
Real(dp), Intent(out) :: MVZp, MVZp2
Real(dp) :: VPVZVZp2(3),VPVZVZp(3)  

Complex(dp), Intent(out) :: ZZ(3,3) 
 
Complex(dp) :: mat(3,3)  

Real(dp) ::  test(2) 

Iname = Iname + 1 
NameOfUnit(Iname) = 'CalculateVPVZVZp'
 
mat(1,1) = 0._dp 
mat(1,1) = mat(1,1)+(2*g1**2*Vn**2)/9._dp
mat(1,1) = mat(1,1)+(2*g1**2*v1**2)/9._dp
mat(1,1) = mat(1,1)+(8*g1**2*v2**2)/9._dp
mat(1,2) = 0._dp 
mat(1,2) = mat(1,2)+(2*g1*g2*Vn**2)/(3._dp*sqrt(3._dp))
mat(1,2) = mat(1,2)-(g1*g2*v1**2)/(3._dp*sqrt(3._dp))
mat(1,2) = mat(1,2)+(2*g1*g2*v2**2)/(3._dp*sqrt(3._dp))
mat(1,3) = 0._dp 
mat(1,3) = mat(1,3)+(g1*g2*v1**2)/3._dp
mat(1,3) = mat(1,3)+(2*g1*g2*v2**2)/3._dp
mat(2,2) = 0._dp 
mat(2,2) = mat(2,2)+(2*g2**2*Vn**2)/3._dp
mat(2,2) = mat(2,2)+(g2**2*v1**2)/6._dp
mat(2,2) = mat(2,2)+(g2**2*v2**2)/6._dp
mat(2,3) = 0._dp 
mat(2,3) = mat(2,3)-(g2**2*v1**2)/(2._dp*sqrt(3._dp))
mat(2,3) = mat(2,3)+(g2**2*v2**2)/(2._dp*sqrt(3._dp))
mat(3,3) = 0._dp 
mat(3,3) = mat(3,3)+(g2**2*v1**2)/2._dp
mat(3,3) = mat(3,3)+(g2**2*v2**2)/2._dp

 
 Do i1=2,3
  Do i2 = 1, i1-1 
  mat(i1,i2) = Conjg(mat(i2,i1)) 
  End do 
End do 

 
Call EigenSystem(mat,VPVZVZp2,ZZ,ierr,test) 
 
 
ZZ = Transpose(ZZ) 
If ((ierr.Eq.-8).Or.(ierr.Eq.-9)) Then 
  Write(ErrCan,*) "Possible numerical problem in "//NameOfUnit(Iname) 
  If (ErrorLevel.Eq.2) Then 
  Write(*,*) "Possible numerical problem in "//NameOfUnit(Iname) 
    Call TerminateProgram 
  End If 
  ierr = 0 
End If 
 
If ((ierr.Ne.0.).And.(ErrorLevel.Ge.-1)) Then 
  Write(10,*) 'Warning from Subroutine '//NameOfUnit(Iname) 
  Write(10,*) 'Diagonalization failed, ierr : ',ierr 
  kont = ierr 
  Iname = Iname - 1 
  Return 
End If 


Do i1=1,3
  If (Abs(VPVZVZp2(i1)).Le.1.E-10_dp*(Maxval(VPVZVZp2))) VPVZVZp2(i1) = 1.E-10_dp 
  If (VPVZVZp2(i1).ne.VPVZVZp2(i1)) Then 
      Write(*,*) 'NaN appearing in '//NameOfUnit(Iname) 
      Call TerminateProgram 
    End If 
  If (VPVZVZp2(i1).Ge.0._dp) Then 
  VPVZVZp(i1) =Sqrt(VPVZVZp2(i1) ) 
  Else 
    If (ErrorLevel.Ge.0) Then 
      Write(10,*) 'Warning from Subroutine '//NameOfUnit(Iname) 
      Write(10,*) 'a mass squarred is negative: ',i1,VPVZVZp2(i1) 
    End If 
  VPVZVZp(i1)= 1._dp 
  VPVZVZp2(i1)= 1._dp  
     Write(ErrCan,*) 'Warning from routine '//NameOfUnit(Iname) 
     Write(ErrCan,*) 'in the calculation of the masses' 
     Write(ErrCan,*) 'occurred a negative mass squared!' 
     Write(ErrCan,*) i1,VPVZVZp2(i1) 
     Write(*,*) 'Warning from routine '//NameOfUnit(Iname) 
     Write(*,*) 'in the calculation of the masses' 
     Write(*,*) 'occurred a negative mass squared!' 
     Write(*,*) i1,VPVZVZp2(i1) 
  VPVZVZp(i1)= 1._dp 
  VPVZVZp2(i1) = 1._dp  
   SignOfMassChanged = .True. 
! kont = -104 
 End if 
End Do 
 
MVZ = VPVZVZp(2) 
MVZ2 = VPVZVZp2(2) 
MVZp = VPVZVZp(3) 
MVZp2 = VPVZVZp2(3) 

 Iname = Iname - 1 
 
End Subroutine CalculateVPVZVZp 

Subroutine CalculateVWpVXp(g2,Vn,v1,v2,ZW,MVWp,MVXp,MVWp2,MVXp2,kont)

Real(dp), Intent(in) :: g2,Vn,v1,v2

Integer, Intent(inout) :: kont 
Integer :: i1,i2,i3,i4, ierr 
Integer :: j1,j2,j3,j4 
Real(dp), Intent(out) :: MVWp, MVWp2
Real(dp), Intent(out) :: MVXp, MVXp2
Real(dp) :: VWpVXp2(4),VWpVXp(4)  

Complex(dp), Intent(out) :: ZW(4,4) 
 
Complex(dp) :: mat(4,4)  

Real(dp) ::  test(2) 

Iname = Iname + 1 
NameOfUnit(Iname) = 'CalculateVWpVXp'
 
mat(1,1) = 0._dp 
mat(1,1) = mat(1,1)+(g2**2*v1**2)/2._dp
mat(1,1) = mat(1,1)+(g2**2*v2**2)/2._dp
mat(1,2) = 0._dp 
mat(1,3) = 0._dp 
mat(1,4) = 0._dp 
mat(2,2) = 0._dp 
mat(2,2) = mat(2,2)+(g2**2*v1**2)/2._dp
mat(2,2) = mat(2,2)+(g2**2*v2**2)/2._dp
mat(2,3) = 0._dp 
mat(2,4) = 0._dp 
mat(3,3) = 0._dp 
mat(3,3) = mat(3,3)+(g2**2*Vn**2)/2._dp
mat(3,3) = mat(3,3)+(g2**2*v2**2)/2._dp
mat(3,4) = 0._dp 
mat(4,4) = 0._dp 
mat(4,4) = mat(4,4)+(g2**2*Vn**2)/2._dp
mat(4,4) = mat(4,4)+(g2**2*v2**2)/2._dp

 
 Do i1=2,4
  Do i2 = 1, i1-1 
  mat(i1,i2) = Conjg(mat(i2,i1)) 
  End do 
End do 

 
Call EigenSystem(mat,VWpVXp2,ZW,ierr,test) 
 
 
ZW = Transpose(ZW) 
If ((ierr.Eq.-8).Or.(ierr.Eq.-9)) Then 
  Write(ErrCan,*) "Possible numerical problem in "//NameOfUnit(Iname) 
  If (ErrorLevel.Eq.2) Then 
  Write(*,*) "Possible numerical problem in "//NameOfUnit(Iname) 
    Call TerminateProgram 
  End If 
  ierr = 0 
End If 
 
If ((ierr.Ne.0.).And.(ErrorLevel.Ge.-1)) Then 
  Write(10,*) 'Warning from Subroutine '//NameOfUnit(Iname) 
  Write(10,*) 'Diagonalization failed, ierr : ',ierr 
  kont = ierr 
  Iname = Iname - 1 
  Return 
End If 


Do i1=1,4
  If (Abs(VWpVXp2(i1)).Le.1.E-10_dp*(Maxval(VWpVXp2))) VWpVXp2(i1) = 1.E-10_dp 
  If (VWpVXp2(i1).ne.VWpVXp2(i1)) Then 
      Write(*,*) 'NaN appearing in '//NameOfUnit(Iname) 
      Call TerminateProgram 
    End If 
  If (VWpVXp2(i1).Ge.0._dp) Then 
  VWpVXp(i1) =Sqrt(VWpVXp2(i1) ) 
  Else 
    If (ErrorLevel.Ge.0) Then 
      Write(10,*) 'Warning from Subroutine '//NameOfUnit(Iname) 
      Write(10,*) 'a mass squarred is negative: ',i1,VWpVXp2(i1) 
    End If 
  VWpVXp(i1)= 1._dp 
  VWpVXp2(i1)= 1._dp  
     Write(ErrCan,*) 'Warning from routine '//NameOfUnit(Iname) 
     Write(ErrCan,*) 'in the calculation of the masses' 
     Write(ErrCan,*) 'occurred a negative mass squared!' 
     Write(ErrCan,*) i1,VWpVXp2(i1) 
     Write(*,*) 'Warning from routine '//NameOfUnit(Iname) 
     Write(*,*) 'in the calculation of the masses' 
     Write(*,*) 'occurred a negative mass squared!' 
     Write(*,*) i1,VWpVXp2(i1) 
  VWpVXp(i1)= 1._dp 
  VWpVXp2(i1) = 1._dp  
   SignOfMassChanged = .True. 
! kont = -104 
 End if 
End Do 
 
MVWp = VWpVXp(1) 
MVWp2 = VWpVXp2(1) 
MVXp = VWpVXp(3) 
MVXp2 = VWpVXp2(3) 

 Iname = Iname - 1 
 
End Subroutine CalculateVWpVXp 

Subroutine CalculateMhhEffPot(mu12,mu22,mu32,ftri,l1,l12,l13,l2,l23,l3,               & 
& Vn,v1,v2,ZH,Mhh,Mhh2,kont)

Real(dp), Intent(in) :: mu12,mu22,mu32,ftri,Vn,v1,v2

Complex(dp), Intent(in) :: l1,l12,l13,l2,l23,l3

Integer, Intent(inout) :: kont 
Integer :: i1,i2,i3,i4, ierr 
Integer :: j1,j2,j3,j4, pos 
Real(dp), Intent(out) :: Mhh(3), Mhh2(3) 
Complex(dp), Intent(out) :: ZH(3,3) 
 
Complex(dp) :: mat(3,3)  

Real(dp) :: Mhh2temp(3), Q2 
Complex(dp) :: ZHtemp(3,3), ZHtemp2(3,3) 
 
Real(dp) ::  test(2) 

Iname = Iname + 1 
NameOfUnit(Iname) = 'CalculateMhh'
 
mat(1,1) = 0._dp 
mat(1,1) = mat(1,1)-1._dp*(mu12)
mat(1,1) = mat(1,1)+3*l1*Vn**2
mat(1,1) = mat(1,1)+l12*v1**2
mat(1,1) = mat(1,1)+l13*v2**2
mat(1,2) = 0._dp 
mat(1,2) = mat(1,2)+2*l12*Vn*v1
mat(1,2) = mat(1,2)-((ftri*v2)/sqrt(2._dp))
mat(1,3) = 0._dp 
mat(1,3) = mat(1,3)-((ftri*v1)/sqrt(2._dp))
mat(1,3) = mat(1,3)+2*l13*Vn*v2
mat(2,2) = 0._dp 
mat(2,2) = mat(2,2)+mu22
mat(2,2) = mat(2,2)+l12*Vn**2
mat(2,2) = mat(2,2)+3*l2*v1**2
mat(2,2) = mat(2,2)+l23*v2**2
mat(2,3) = 0._dp 
mat(2,3) = mat(2,3)-((ftri*Vn)/sqrt(2._dp))
mat(2,3) = mat(2,3)+2*l23*v1*v2
mat(3,3) = 0._dp 
mat(3,3) = mat(3,3)+mu32
mat(3,3) = mat(3,3)+l13*Vn**2
mat(3,3) = mat(3,3)+l23*v1**2
mat(3,3) = mat(3,3)+2*l3*v2**2

 
 Do i1=2,3
  Do i2 = 1, i1-1 
  mat(i1,i2) = mat(i2,i1) 
  End do 
End do 

 
Call EigenSystem(mat,Mhh2,ZH,ierr,test) 
 
 
! Fix order
  ZHtemp2=ZH
Do i1=1,3
  pos=Maxloc(Abs(ZHtemp2(i1,:)),1)
  ZHtemp(pos,:)=ZH(i1,:)
  Mhh2temp(pos)=Mhh2(i1)
  ZHtemp2(:,pos)=0._dp
End do
  Mhh2 = Mhh2temp
  ZH = ZHtemp
! Fix phases
Do i1=1,3
  pos=Maxloc(Abs(ZH(i1,:)),1)
  If (Real(ZH(i1,pos),dp).lt.0._dp) Then
    ZH(i1,:)=-ZH(i1,:)
  End if
End do
If ((ierr.Eq.-8).Or.(ierr.Eq.-9)) Then 
  Write(ErrCan,*) "Possible numerical problem in "//NameOfUnit(Iname) 
  If (ErrorLevel.Eq.2) Then 
  Write(*,*) "Possible numerical problem in "//NameOfUnit(Iname) 
    Call TerminateProgram 
  End If 
  ierr = 0 
End If 
 
If ((ierr.Ne.0.).And.(ErrorLevel.Ge.-1)) Then 
  Write(10,*) 'Warning from Subroutine '//NameOfUnit(Iname) 
  Write(10,*) 'Diagonalization failed, ierr : ',ierr 
  kont = ierr 
  Iname = Iname - 1 
  Return 
End If 


Do i1=1,3
  If (Mhh2(i1).ne.Mhh2(i1)) Then 
      Write(*,*) 'NaN appearing in '//NameOfUnit(Iname) 
      Call TerminateProgram 
    End If 
  If (Mhh2(i1).Ge.0._dp) Then 
  Mhh(i1)=Sqrt(Mhh2(i1) ) 
  Else 
  Mhh(i1) = 1._dp 
! kont = -104 
 End if 
End Do 
Iname = Iname - 1 
 
End Subroutine CalculateMhhEffPot 

Subroutine CalculateMAhEffPot(g1,g2,mu12,mu22,mu32,ftri,l1,l12,l13,l2,l23,            & 
& l3,Vn,v1,v2,ZZ,ZA,MAh,MAh2,kont)

Real(dp), Intent(in) :: g1,g2,mu12,mu22,mu32,ftri,Vn,v1,v2

Complex(dp), Intent(in) :: l1,l12,l13,l2,l23,l3,ZZ(3,3)

Integer, Intent(inout) :: kont 
Integer :: i1,i2,i3,i4, ierr, pos 
Integer :: j1,j2,j3,j4 
Real(dp), Intent(out) :: MAh(3), MAh2(3) 
Complex(dp), Intent(out) :: ZA(3,3) 
 
Complex(dp) :: ZAFIX(3,3) 
 
Complex(dp) :: mat(3,3)  

Real(dp) ::  test(2), Q2 

Iname = Iname + 1 
NameOfUnit(Iname) = 'CalculateMAh'
 
mat(1,1) = 0._dp 
mat(1,1) = mat(1,1)-1._dp*(mu12)
mat(1,1) = mat(1,1)+l1*Vn**2
mat(1,1) = mat(1,1)+l12*v1**2
mat(1,1) = mat(1,1)+l13*v2**2
mat(1,2) = 0._dp 
mat(1,2) = mat(1,2)+(ftri*v2)/sqrt(2._dp)
mat(1,3) = 0._dp 
mat(1,3) = mat(1,3)+(ftri*v1)/sqrt(2._dp)
mat(2,2) = 0._dp 
mat(2,2) = mat(2,2)+mu22
mat(2,2) = mat(2,2)+l12*Vn**2
mat(2,2) = mat(2,2)+l2*v1**2
mat(2,2) = mat(2,2)+l23*v2**2
mat(2,3) = 0._dp 
mat(2,3) = mat(2,3)+(ftri*Vn)/sqrt(2._dp)
mat(3,3) = 0._dp 
mat(3,3) = mat(3,3)+mu32
mat(3,3) = mat(3,3)+l13*Vn**2
mat(3,3) = mat(3,3)+l23*v1**2
mat(3,3) = mat(3,3)+(2*l3*v2**2)/3._dp

 
 Do i1=2,3
  Do i2 = 1, i1-1 
  mat(i1,i2) = mat(i2,i1) 
  End do 
End do 

 
Call EigenSystem(mat,MAh2,ZA,ierr,test) 
 
 
! Fix phases
Do i1=1,3
  pos=Maxloc(Abs(ZA(i1,:)),1)
  If (Real(ZA(i1,pos),dp).lt.0._dp) Then
    ZA(i1,:)=-ZA(i1,:)
  End if
End do
If ((ierr.Eq.-8).Or.(ierr.Eq.-9)) Then 
  Write(ErrCan,*) "Possible numerical problem in "//NameOfUnit(Iname) 
  If (ErrorLevel.Eq.2) Then 
  Write(*,*) "Possible numerical problem in "//NameOfUnit(Iname) 
    Call TerminateProgram 
  End If 
  ierr = 0 
End If 
 
If ((ierr.Ne.0.).And.(ErrorLevel.Ge.-1)) Then 
  Write(10,*) 'Warning from Subroutine '//NameOfUnit(Iname) 
  Write(10,*) 'Diagonalization failed, ierr : ',ierr 
  kont = ierr 
  Iname = Iname - 1 
  Return 
End If 


Do i1=1,3
  If (MAh2(i1).ne.MAh2(i1)) Then 
      Write(*,*) 'NaN appearing in '//NameOfUnit(Iname) 
      Call TerminateProgram 
    End If 
  If (MAh2(i1).Ge.0._dp) Then 
  MAh(i1)=Sqrt(MAh2(i1) ) 
  Else 
  MAh(i1) = 1._dp 
! kont = -104 
 End if 
End Do 
Iname = Iname - 1 
 
End Subroutine CalculateMAhEffPot 

Subroutine CalculateMHpmEffPot(g2,mu12,mu22,mu32,ftri,l1,l12,l13,l13t,l2,             & 
& l23,l23t,l3,Vn,v1,v2,ZP,MHpm,MHpm2,kont)

Real(dp), Intent(in) :: g2,mu12,mu22,mu32,ftri,Vn,v1,v2

Complex(dp), Intent(in) :: l1,l12,l13,l13t,l2,l23,l23t,l3

Integer, Intent(inout) :: kont 
Integer :: i1,i2,i3,i4, ierr, pos 
Integer :: j1,j2,j3,j4 
Real(dp), Intent(out) :: MHpm(4), MHpm2(4) 
Complex(dp), Intent(out) :: ZP(4,4) 
 
Complex(dp) :: ZPFIX(4,4) 
 
Complex(dp) :: mat(4,4)  

Real(dp) ::  test(2), Q2 

Iname = Iname + 1 
NameOfUnit(Iname) = 'CalculateMHpm'
 
mat(1,1) = 0._dp 
mat(1,1) = mat(1,1)-1._dp*(mu12)
mat(1,1) = mat(1,1)+l1*Vn**2
mat(1,1) = mat(1,1)+l12*v1**2
mat(1,1) = mat(1,1)+l13*v2**2
mat(1,1) = mat(1,1)+l13t*v2**2
mat(1,2) = 0._dp 
mat(1,3) = 0._dp 
mat(1,4) = 0._dp 
mat(1,4) = mat(1,4)+sqrt(2._dp)*ftri*v1
mat(1,4) = mat(1,4)+l13t*Vn*v2
mat(2,2) = 0._dp 
mat(2,2) = mat(2,2)+mu22
mat(2,2) = mat(2,2)+l12*Vn**2
mat(2,2) = mat(2,2)+l2*v1**2
mat(2,2) = mat(2,2)+l23*v2**2
mat(2,2) = mat(2,2)+l23t*v2**2
mat(2,3) = 0._dp 
mat(2,3) = mat(2,3)+sqrt(2._dp)*ftri*Vn
mat(2,3) = mat(2,3)+l23t*v1*v2
mat(2,4) = 0._dp 
mat(3,3) = 0._dp 
mat(3,3) = mat(3,3)+mu32
mat(3,3) = mat(3,3)+l13*Vn**2
mat(3,3) = mat(3,3)+l23*v1**2
mat(3,3) = mat(3,3)+l23t*v1**2
mat(3,3) = mat(3,3)+(2*l3*v2**2)/3._dp
mat(3,4) = 0._dp 
mat(4,4) = 0._dp 
mat(4,4) = mat(4,4)+mu32
mat(4,4) = mat(4,4)+l13*Vn**2
mat(4,4) = mat(4,4)+l13t*Vn**2
mat(4,4) = mat(4,4)+l23*v1**2
mat(4,4) = mat(4,4)+(2*l3*v2**2)/3._dp

 
 Do i1=2,4
  Do i2 = 1, i1-1 
  mat(i1,i2) = Conjg(mat(i2,i1)) 
  End do 
End do 

 
Call EigenSystem(mat,MHpm2,ZP,ierr,test) 
 
 
! Fix phases
Do i1=1,4
  pos=Maxloc(Abs(ZP(i1,:)),1)
  If (Real(ZP(i1,pos),dp).lt.0._dp) Then
    ZP(i1,:)=-ZP(i1,:)
  End if
End do
If ((ierr.Eq.-8).Or.(ierr.Eq.-9)) Then 
  Write(ErrCan,*) "Possible numerical problem in "//NameOfUnit(Iname) 
  If (ErrorLevel.Eq.2) Then 
  Write(*,*) "Possible numerical problem in "//NameOfUnit(Iname) 
    Call TerminateProgram 
  End If 
  ierr = 0 
End If 
 
If ((ierr.Ne.0.).And.(ErrorLevel.Ge.-1)) Then 
  Write(10,*) 'Warning from Subroutine '//NameOfUnit(Iname) 
  Write(10,*) 'Diagonalization failed, ierr : ',ierr 
  kont = ierr 
  Iname = Iname - 1 
  Return 
End If 


Do i1=1,4
  If (MHpm2(i1).ne.MHpm2(i1)) Then 
      Write(*,*) 'NaN appearing in '//NameOfUnit(Iname) 
      Call TerminateProgram 
    End If 
  If (MHpm2(i1).Ge.0._dp) Then 
  MHpm(i1)=Sqrt(MHpm2(i1) ) 
  Else 
  MHpm(i1) = 1._dp 
! kont = -104 
 End if 
End Do 
Iname = Iname - 1 
 
End Subroutine CalculateMHpmEffPot 

Subroutine CalculateMDpmEffPot(mu12,mu22,ftri,l1,l12,l13,l12t,l2,l23,Vn,              & 
& v1,v2,zy,MDpm,MDpm2,kont)

Real(dp), Intent(in) :: mu12,mu22,ftri,Vn,v1,v2

Complex(dp), Intent(in) :: l1,l12,l13,l12t,l2,l23

Integer, Intent(inout) :: kont 
Integer :: i1,i2,i3,i4, ierr 
Integer :: j1,j2,j3,j4, pos 
Real(dp), Intent(out) :: MDpm(2), MDpm2(2) 
Complex(dp), Intent(out) :: zy(2,2) 
 
Complex(dp) :: mat(2,2)  

Real(dp) :: MDpm2temp(2), Q2 
Complex(dp) :: zytemp(2,2), zytemp2(2,2) 
 
Real(dp) ::  test(2) 

Iname = Iname + 1 
NameOfUnit(Iname) = 'CalculateMDpm'
 
mat(1,1) = 0._dp 
mat(1,1) = mat(1,1)-1._dp*(mu12)
mat(1,1) = mat(1,1)+l1*Vn**2
mat(1,1) = mat(1,1)+l12*v1**2
mat(1,1) = mat(1,1)+l12t*v1**2
mat(1,1) = mat(1,1)+l13*v2**2
mat(1,2) = 0._dp 
mat(1,2) = mat(1,2)+l12t*Vn*v1
mat(1,2) = mat(1,2)+sqrt(2._dp)*ftri*v2
mat(2,2) = 0._dp 
mat(2,2) = mat(2,2)+mu22
mat(2,2) = mat(2,2)+l12*Vn**2
mat(2,2) = mat(2,2)+l12t*Vn**2
mat(2,2) = mat(2,2)+l2*v1**2
mat(2,2) = mat(2,2)+l23*v2**2

 
 Do i1=2,2
  Do i2 = 1, i1-1 
  mat(i1,i2) = Conjg(mat(i2,i1)) 
  End do 
End do 

 
Call EigenSystem(mat,MDpm2,zy,ierr,test) 
 
 
! Fix order
  zytemp2=zy
Do i1=1,2
  pos=Maxloc(Abs(zytemp2(i1,:)),1)
  zytemp(pos,:)=zy(i1,:)
  MDpm2temp(pos)=MDpm2(i1)
  zytemp2(:,pos)=0._dp
End do
  MDpm2 = MDpm2temp
  zy = zytemp
! Fix phases
Do i1=1,2
  pos=Maxloc(Abs(zy(i1,:)),1)
  If (Real(zy(i1,pos),dp).lt.0._dp) Then
    zy(i1,:)=-zy(i1,:)
  End if
End do
If ((ierr.Eq.-8).Or.(ierr.Eq.-9)) Then 
  Write(ErrCan,*) "Possible numerical problem in "//NameOfUnit(Iname) 
  If (ErrorLevel.Eq.2) Then 
  Write(*,*) "Possible numerical problem in "//NameOfUnit(Iname) 
    Call TerminateProgram 
  End If 
  ierr = 0 
End If 
 
If ((ierr.Ne.0.).And.(ErrorLevel.Ge.-1)) Then 
  Write(10,*) 'Warning from Subroutine '//NameOfUnit(Iname) 
  Write(10,*) 'Diagonalization failed, ierr : ',ierr 
  kont = ierr 
  Iname = Iname - 1 
  Return 
End If 


Do i1=1,2
  If (MDpm2(i1).ne.MDpm2(i1)) Then 
      Write(*,*) 'NaN appearing in '//NameOfUnit(Iname) 
      Call TerminateProgram 
    End If 
  If (MDpm2(i1).Ge.0._dp) Then 
  MDpm(i1)=Sqrt(MDpm2(i1) ) 
  Else 
  MDpm(i1) = 1._dp 
! kont = -104 
 End if 
End Do 
Iname = Iname - 1 
 
End Subroutine CalculateMDpmEffPot 

Subroutine CalculateMFdEffPot(hdp11,hd1,hdtp11,hdt1,hdp1,hd2,hdtp1,hdt2,              & 
& hd3,hdt3,Vn,v1,v2,Vd,Ud,MFd,kont)

Real(dp),Intent(in) :: Vn,v1,v2

Complex(dp),Intent(in) :: hdp11(3),hd1(3),hdtp11(2),hdt1(2),hdp1(3),hd2(3),hdtp1(2),hdt2(2),hd3(3),hdt3(2)

Integer, Intent(inout) :: kont 
Integer :: i1,i2,i3,i4, ierr 
Integer :: j1,j2,j3,j4 
Real(dp), Intent(out) :: MFd(5) 
 Complex(dp), Intent(out) :: Vd(5,5), Ud(5,5) 
 
 Complex(dp) :: mat(5,5)=0._dp, mat2(5,5)=0._dp, phaseM 

Complex(dp) :: Vd2(5,5), Ud2(5,5) 
 
 Real(dp) :: Vd1(5,5), Ud1(5,5), test(2), MFd2(5) 
 
 Iname = Iname + 1 
NameOfUnit(Iname) = 'CalculateMFd'
 
MFd = 0._dp 
Vd = 0._dp 
Ud = 0._dp 
mat(1,1) = 0._dp 
mat(1,1) = mat(1,1)+v1*hd1(1)
mat(1,2) = 0._dp 
mat(1,2) = mat(1,2)+v1*hd1(2)
mat(1,3) = 0._dp 
mat(1,3) = mat(1,3)+v1*hd1(3)
mat(1,4) = 0._dp 
mat(1,4) = mat(1,4)+v1*hdt1(1)
mat(1,5) = 0._dp 
mat(1,5) = mat(1,5)+v1*hdt1(2)
mat(2,1) = 0._dp 
mat(2,1) = mat(2,1)+v1*hd2(1)
mat(2,2) = 0._dp 
mat(2,2) = mat(2,2)+v1*hd2(2)
mat(2,3) = 0._dp 
mat(2,3) = mat(2,3)+v1*hd2(3)
mat(2,4) = 0._dp 
mat(2,4) = mat(2,4)+v1*hdt2(1)
mat(2,5) = 0._dp 
mat(2,5) = mat(2,5)+v1*hdt2(2)
mat(3,1) = 0._dp 
mat(3,1) = mat(3,1)+v2*hd3(1)
mat(3,2) = 0._dp 
mat(3,2) = mat(3,2)+v2*hd3(2)
mat(3,3) = 0._dp 
mat(3,3) = mat(3,3)+v2*hd3(3)
mat(3,4) = 0._dp 
mat(3,4) = mat(3,4)+v2*hdt3(1)
mat(3,5) = 0._dp 
mat(3,5) = mat(3,5)+v2*hdt3(2)
mat(4,1) = 0._dp 
mat(4,1) = mat(4,1)+Vn*hdp11(1)
mat(4,2) = 0._dp 
mat(4,2) = mat(4,2)+Vn*hdp11(2)
mat(4,3) = 0._dp 
mat(4,3) = mat(4,3)+Vn*hdp11(3)
mat(4,4) = 0._dp 
mat(4,4) = mat(4,4)+Vn*hdtp11(1)
mat(4,5) = 0._dp 
mat(4,5) = mat(4,5)+Vn*hdtp11(2)
mat(5,1) = 0._dp 
mat(5,1) = mat(5,1)+Vn*hdp1(1)
mat(5,2) = 0._dp 
mat(5,2) = mat(5,2)+Vn*hdp1(2)
mat(5,3) = 0._dp 
mat(5,3) = mat(5,3)+Vn*hdp1(3)
mat(5,4) = 0._dp 
mat(5,4) = mat(5,4)+Vn*hdtp1(1)
mat(5,5) = 0._dp 
mat(5,5) = mat(5,5)+Vn*hdtp1(2)

 
mat2 = Matmul(Transpose(Conjg(mat)),mat) 
If (Maxval(Abs(Aimag(mat2))).Eq.0._dp) Then 
Call EigenSystem(Real(mat2,dp),MFd2,Ud1,ierr,test) 
Ud2 = Ud1 
Else 
Call EigenSystem(mat2,MFd2,Ud2,ierr,test) 
 End If 
 
If ((ierr.Eq.-8).Or.(ierr.Eq.-9)) Then 
  Write(ErrCan,*) "Possible numerical problem in "//NameOfUnit(Iname) 
  If (ErrorLevel.Eq.2) Then 
  Write(*,*) "Possible numerical problem in "//NameOfUnit(Iname) 
    Call TerminateProgram 
  End If 
  ierr = 0 
End If 
 
mat2 = Matmul(mat,Transpose(Conjg(mat))) 
If (Maxval(Abs(Aimag(mat2))).Eq.0._dp) Then 
Call EigenSystem (Real(mat2,dp),MFd2,Vd1,ierr,test) 
                  
                  
Vd2 = Vd1 
Else 
Call EigenSystem(mat2,MFd2,Vd2,ierr,test) 
 
 
End If 
Vd2 = Conjg(Vd2) 
 
If ((ierr.Eq.-8).Or.(ierr.Eq.-9)) Then 
  Write(ErrCan,*) "Possible numerical problem in "//NameOfUnit(Iname) 
  If (ErrorLevel.Eq.2) Then 
  Write(*,*) "Possible numerical problem in "//NameOfUnit(Iname) 
    Call TerminateProgram 
  End If 
  ierr = 0 
End If 
 
mat2 = Matmul(Matmul( Conjg(Vd2),mat),Transpose( Conjg(Ud2))) 
Do i1=1,5
If (Abs(mat2(i1,i1)).gt.0._dp) Then 
phaseM = mat2(i1,i1) / Abs(mat2(i1,i1)) 
Ud2(i1,:) = phaseM *Ud2(i1,:) 
 End if 
End Do 
 
Do i1=1,5
If (Abs(Ud2(i1,i1)).gt.0._dp) Then 
phaseM = Ud2(i1,i1) / Abs(Ud2(i1,i1)) 
Ud2(i1,:) = Conjg(phaseM) *Ud2(i1,:) 
 Vd2(i1,:) = phaseM *Vd2(i1,:) 
 End if 
  If (MFd2(i1).ne.MFd2(i1)) Then 
      Write(*,*) 'NaN appearing in '//NameOfUnit(Iname) 
      Call TerminateProgram 
    End If 
  If (Abs(MFd2(i1)).Le.MaxMassNumericalZero) MFd2(i1) = Abs(MFd2(i1))+1.E-10_dp 
  If (MFd2(i1).Le.0._dp) Then 
! kont = -104 
 End if 
End Do 
 
If (ierr.Ne.0.) Then 
  Write(ErrCan,*) 'Warning from Subroutine CalculateMFd, ierr =',ierr 
  kont = ierr 
  Iname = Iname - 1 
  Return 
End If 


MFd = Sqrt( MFd2 ) 
Vd = Vd2 
Ud = Ud2 
Iname = Iname - 1 
 
End Subroutine CalculateMFdEffPot 

Subroutine CalculateMFuEffPot(hup11,hUp1,hup21,hUp2,hu11,h12,hU1,hU2,Vn,              & 
& v1,v2,Vu,Uu,MFu,kont)

Real(dp),Intent(in) :: Vn,v1,v2

Complex(dp),Intent(in) :: hup11(3),hUp1,hup21(3),hUp2,hu11(3),h12(3),hU1,hU2

Integer, Intent(inout) :: kont 
Integer :: i1,i2,i3,i4, ierr 
Integer :: j1,j2,j3,j4 
Real(dp), Intent(out) :: MFu(4) 
 Complex(dp), Intent(out) :: Vu(4,4), Uu(4,4) 
 
 Complex(dp) :: mat(4,4)=0._dp, mat2(4,4)=0._dp, phaseM 

Complex(dp) :: Vu2(4,4), Uu2(4,4) 
 
 Real(dp) :: Vu1(4,4), Uu1(4,4), test(2), MFu2(4) 
 
 Iname = Iname + 1 
NameOfUnit(Iname) = 'CalculateMFu'
 
MFu = 0._dp 
Vu = 0._dp 
Uu = 0._dp 
mat(1,1) = 0._dp 
mat(1,1) = mat(1,1)+v2*hup11(1)
mat(1,2) = 0._dp 
mat(1,2) = mat(1,2)+v2*hup11(2)
mat(1,3) = 0._dp 
mat(1,3) = mat(1,3)+v2*hup11(3)
mat(1,4) = 0._dp 
mat(1,4) = mat(1,4)+hUp1*v2
mat(2,1) = 0._dp 
mat(2,1) = mat(2,1)+v2*hup21(1)
mat(2,2) = 0._dp 
mat(2,2) = mat(2,2)+v2*hup21(2)
mat(2,3) = 0._dp 
mat(2,3) = mat(2,3)+v2*hup21(3)
mat(2,4) = 0._dp 
mat(2,4) = mat(2,4)+hUp2*v2
mat(3,1) = 0._dp 
mat(3,1) = mat(3,1)+v1*h12(1)
mat(3,2) = 0._dp 
mat(3,2) = mat(3,2)+v1*h12(2)
mat(3,3) = 0._dp 
mat(3,3) = mat(3,3)+v1*h12(3)
mat(3,4) = 0._dp 
mat(3,4) = mat(3,4)+hU2*v1
mat(4,1) = 0._dp 
mat(4,1) = mat(4,1)+Vn*hu11(1)
mat(4,2) = 0._dp 
mat(4,2) = mat(4,2)+Vn*hu11(2)
mat(4,3) = 0._dp 
mat(4,3) = mat(4,3)+Vn*hu11(3)
mat(4,4) = 0._dp 
mat(4,4) = mat(4,4)+hU1*Vn

 
mat2 = Matmul(Transpose(Conjg(mat)),mat) 
If (Maxval(Abs(Aimag(mat2))).Eq.0._dp) Then 
Call EigenSystem(Real(mat2,dp),MFu2,Uu1,ierr,test) 
Uu2 = Uu1 
Else 
Call EigenSystem(mat2,MFu2,Uu2,ierr,test) 
 End If 
 
If ((ierr.Eq.-8).Or.(ierr.Eq.-9)) Then 
  Write(ErrCan,*) "Possible numerical problem in "//NameOfUnit(Iname) 
  If (ErrorLevel.Eq.2) Then 
  Write(*,*) "Possible numerical problem in "//NameOfUnit(Iname) 
    Call TerminateProgram 
  End If 
  ierr = 0 
End If 
 
mat2 = Matmul(mat,Transpose(Conjg(mat))) 
If (Maxval(Abs(Aimag(mat2))).Eq.0._dp) Then 
Call EigenSystem (Real(mat2,dp),MFu2,Vu1,ierr,test) 
                  
                  
Vu2 = Vu1 
Else 
Call EigenSystem(mat2,MFu2,Vu2,ierr,test) 
 
 
End If 
Vu2 = Conjg(Vu2) 
 
If ((ierr.Eq.-8).Or.(ierr.Eq.-9)) Then 
  Write(ErrCan,*) "Possible numerical problem in "//NameOfUnit(Iname) 
  If (ErrorLevel.Eq.2) Then 
  Write(*,*) "Possible numerical problem in "//NameOfUnit(Iname) 
    Call TerminateProgram 
  End If 
  ierr = 0 
End If 
 
mat2 = Matmul(Matmul( Conjg(Vu2),mat),Transpose( Conjg(Uu2))) 
Do i1=1,4
If (Abs(mat2(i1,i1)).gt.0._dp) Then 
phaseM = mat2(i1,i1) / Abs(mat2(i1,i1)) 
Uu2(i1,:) = phaseM *Uu2(i1,:) 
 End if 
End Do 
 
Do i1=1,4
If (Abs(Uu2(i1,i1)).gt.0._dp) Then 
phaseM = Uu2(i1,i1) / Abs(Uu2(i1,i1)) 
Uu2(i1,:) = Conjg(phaseM) *Uu2(i1,:) 
 Vu2(i1,:) = phaseM *Vu2(i1,:) 
 End if 
  If (MFu2(i1).ne.MFu2(i1)) Then 
      Write(*,*) 'NaN appearing in '//NameOfUnit(Iname) 
      Call TerminateProgram 
    End If 
  If (Abs(MFu2(i1)).Le.MaxMassNumericalZero) MFu2(i1) = Abs(MFu2(i1))+1.E-10_dp 
  If (MFu2(i1).Le.0._dp) Then 
! kont = -104 
 End if 
End Do 
 
If (ierr.Ne.0.) Then 
  Write(ErrCan,*) 'Warning from Subroutine CalculateMFu, ierr =',ierr 
  kont = ierr 
  Iname = Iname - 1 
  Return 
End If 


MFu = Sqrt( MFu2 ) 
Vu = Vu2 
Uu = Uu2 
Iname = Iname - 1 
 
End Subroutine CalculateMFuEffPot 

Subroutine CalculateMFeEffPot(hll1,v2,Ve,Ue,MFe,kont)

Real(dp),Intent(in) :: v2

Complex(dp),Intent(in) :: hll1(3,3)

Integer, Intent(inout) :: kont 
Integer :: i1,i2,i3,i4, ierr 
Integer :: j1,j2,j3,j4 
Real(dp), Intent(out) :: MFe(3) 
 Complex(dp), Intent(out) :: Ve(3,3), Ue(3,3) 
 
 Complex(dp) :: mat(3,3)=0._dp, mat2(3,3)=0._dp, phaseM 

Complex(dp) :: Ve2(3,3), Ue2(3,3) 
 
 Real(dp) :: Ve1(3,3), Ue1(3,3), test(2), MFe2(3) 
 
 Iname = Iname + 1 
NameOfUnit(Iname) = 'CalculateMFe'
 
MFe = 0._dp 
Ve = 0._dp 
Ue = 0._dp 
mat(1,1) = 0._dp 
mat(1,1) = mat(1,1)+v2*hll1(1,1)
mat(1,2) = 0._dp 
mat(1,2) = mat(1,2)+v2*hll1(1,2)
mat(1,3) = 0._dp 
mat(1,3) = mat(1,3)+v2*hll1(1,3)
mat(2,1) = 0._dp 
mat(2,1) = mat(2,1)+v2*hll1(2,1)
mat(2,2) = 0._dp 
mat(2,2) = mat(2,2)+v2*hll1(2,2)
mat(2,3) = 0._dp 
mat(2,3) = mat(2,3)+v2*hll1(2,3)
mat(3,1) = 0._dp 
mat(3,1) = mat(3,1)+v2*hll1(3,1)
mat(3,2) = 0._dp 
mat(3,2) = mat(3,2)+v2*hll1(3,2)
mat(3,3) = 0._dp 
mat(3,3) = mat(3,3)+v2*hll1(3,3)

 
mat2 = Matmul(Transpose(Conjg(mat)),mat) 
If (Maxval(Abs(Aimag(mat2))).Eq.0._dp) Then 
Call EigenSystem(Real(mat2,dp),MFe2,Ue1,ierr,test) 
Ue2 = Ue1 
Else 
Call EigenSystem(mat2,MFe2,Ue2,ierr,test) 
 End If 
 
If ((ierr.Eq.-8).Or.(ierr.Eq.-9)) Then 
  Write(ErrCan,*) "Possible numerical problem in "//NameOfUnit(Iname) 
  If (ErrorLevel.Eq.2) Then 
  Write(*,*) "Possible numerical problem in "//NameOfUnit(Iname) 
    Call TerminateProgram 
  End If 
  ierr = 0 
End If 
 
mat2 = Matmul(mat,Transpose(Conjg(mat))) 
If (Maxval(Abs(Aimag(mat2))).Eq.0._dp) Then 
Call EigenSystem (Real(mat2,dp),MFe2,Ve1,ierr,test) 
                  
                  
Ve2 = Ve1 
Else 
Call EigenSystem(mat2,MFe2,Ve2,ierr,test) 
 
 
End If 
Ve2 = Conjg(Ve2) 
 
If ((ierr.Eq.-8).Or.(ierr.Eq.-9)) Then 
  Write(ErrCan,*) "Possible numerical problem in "//NameOfUnit(Iname) 
  If (ErrorLevel.Eq.2) Then 
  Write(*,*) "Possible numerical problem in "//NameOfUnit(Iname) 
    Call TerminateProgram 
  End If 
  ierr = 0 
End If 
 
mat2 = Matmul(Matmul( Conjg(Ve2),mat),Transpose( Conjg(Ue2))) 
Do i1=1,3
If (Abs(mat2(i1,i1)).gt.0._dp) Then 
phaseM = mat2(i1,i1) / Abs(mat2(i1,i1)) 
Ue2(i1,:) = phaseM *Ue2(i1,:) 
 End if 
End Do 
 
Do i1=1,3
If (Abs(Ue2(i1,i1)).gt.0._dp) Then 
phaseM = Ue2(i1,i1) / Abs(Ue2(i1,i1)) 
Ue2(i1,:) = Conjg(phaseM) *Ue2(i1,:) 
 Ve2(i1,:) = phaseM *Ve2(i1,:) 
 End if 
  If (MFe2(i1).ne.MFe2(i1)) Then 
      Write(*,*) 'NaN appearing in '//NameOfUnit(Iname) 
      Call TerminateProgram 
    End If 
  If (Abs(MFe2(i1)).Le.MaxMassNumericalZero) MFe2(i1) = Abs(MFe2(i1))+1.E-10_dp 
  If (MFe2(i1).Le.0._dp) Then 
! kont = -104 
 End if 
End Do 
 
If (ierr.Ne.0.) Then 
  Write(ErrCan,*) 'Warning from Subroutine CalculateMFe, ierr =',ierr 
  kont = ierr 
  Iname = Iname - 1 
  Return 
End If 


MFe = Sqrt( MFe2 ) 
Ve = Ve2 
Ue = Ue2 
Iname = Iname - 1 
 
End Subroutine CalculateMFeEffPot 

Subroutine CalculateVPVZVZpEffPot(g1,g2,Vn,v1,v2,ZZ,MVZ,MVZp,MVZ2,MVZp2,kont)

Real(dp), Intent(in) :: g1,g2,Vn,v1,v2

Integer, Intent(inout) :: kont 
Integer :: i1,i2,i3,i4, ierr 
Integer :: j1,j2,j3,j4 
Real(dp), Intent(out) :: MVZ, MVZ2
Real(dp), Intent(out) :: MVZp, MVZp2
Real(dp) :: VPVZVZp2(3),VPVZVZp(3)  

Complex(dp), Intent(out) :: ZZ(3,3) 
 
Complex(dp) :: mat(3,3)  

Real(dp) ::  test(2) 

Iname = Iname + 1 
NameOfUnit(Iname) = 'CalculateVPVZVZp'
 
mat(1,1) = 0._dp 
mat(1,1) = mat(1,1)+(2*g1**2*v1Fix**2)/9._dp
mat(1,1) = mat(1,1)+(8*g1**2*v2Fix**2)/9._dp
mat(1,1) = mat(1,1)+(2*g1**2*VnFix**2)/9._dp
mat(1,2) = 0._dp 
mat(1,2) = mat(1,2)-(g1*g2*v1Fix**2)/(3._dp*sqrt(3._dp))
mat(1,2) = mat(1,2)+(2*g1*g2*v2Fix**2)/(3._dp*sqrt(3._dp))
mat(1,2) = mat(1,2)+(2*g1*g2*VnFix**2)/(3._dp*sqrt(3._dp))
mat(1,3) = 0._dp 
mat(1,3) = mat(1,3)+(g1*g2*v1Fix**2)/3._dp
mat(1,3) = mat(1,3)+(2*g1*g2*v2Fix**2)/3._dp
mat(2,2) = 0._dp 
mat(2,2) = mat(2,2)+(g2**2*v1Fix**2)/6._dp
mat(2,2) = mat(2,2)+(g2**2*v2Fix**2)/6._dp
mat(2,2) = mat(2,2)+(2*g2**2*VnFix**2)/3._dp
mat(2,3) = 0._dp 
mat(2,3) = mat(2,3)-(g2**2*v1Fix**2)/(2._dp*sqrt(3._dp))
mat(2,3) = mat(2,3)+(g2**2*v2Fix**2)/(2._dp*sqrt(3._dp))
mat(3,3) = 0._dp 
mat(3,3) = mat(3,3)+(g2**2*v1Fix**2)/2._dp
mat(3,3) = mat(3,3)+(g2**2*v2Fix**2)/2._dp

 
 Do i1=2,3
  Do i2 = 1, i1-1 
  mat(i1,i2) = Conjg(mat(i2,i1)) 
  End do 
End do 

 
Call EigenSystem(mat,VPVZVZp2,ZZ,ierr,test) 
 
 
ZZ = Transpose(ZZ) 
If ((ierr.Eq.-8).Or.(ierr.Eq.-9)) Then 
  Write(ErrCan,*) "Possible numerical problem in "//NameOfUnit(Iname) 
  If (ErrorLevel.Eq.2) Then 
  Write(*,*) "Possible numerical problem in "//NameOfUnit(Iname) 
    Call TerminateProgram 
  End If 
  ierr = 0 
End If 
 
If ((ierr.Ne.0.).And.(ErrorLevel.Ge.-1)) Then 
  Write(10,*) 'Warning from Subroutine '//NameOfUnit(Iname) 
  Write(10,*) 'Diagonalization failed, ierr : ',ierr 
  kont = ierr 
  Iname = Iname - 1 
  Return 
End If 


Do i1=1,3
  If (Abs(VPVZVZp2(i1)).Le.1.E-10_dp*(Maxval(VPVZVZp2))) VPVZVZp2(i1) = 1.E-10_dp 
  If (VPVZVZp2(i1).ne.VPVZVZp2(i1)) Then 
      Write(*,*) 'NaN appearing in '//NameOfUnit(Iname) 
      Call TerminateProgram 
    End If 
  If (VPVZVZp2(i1).Ge.0._dp) Then 
  VPVZVZp(i1) =Sqrt(VPVZVZp2(i1) ) 
  Else 
  VPVZVZp(i1)= 1._dp 
  VPVZVZp(i1)= 1._dp 
! kont = -104 
 End if 
End Do 
 
MVZ = VPVZVZp(2) 
MVZ2 = VPVZVZp2(2) 
MVZp = VPVZVZp(3) 
MVZp2 = VPVZVZp2(3) 

 Iname = Iname - 1 
 
End Subroutine CalculateVPVZVZpEffPot 

Subroutine CalculateVWpVXpEffPot(g2,Vn,v1,v2,ZW,MVWp,MVXp,MVWp2,MVXp2,kont)

Real(dp), Intent(in) :: g2,Vn,v1,v2

Integer, Intent(inout) :: kont 
Integer :: i1,i2,i3,i4, ierr 
Integer :: j1,j2,j3,j4 
Real(dp), Intent(out) :: MVWp, MVWp2
Real(dp), Intent(out) :: MVXp, MVXp2
Real(dp) :: VWpVXp2(4),VWpVXp(4)  

Complex(dp), Intent(out) :: ZW(4,4) 
 
Complex(dp) :: mat(4,4)  

Real(dp) ::  test(2) 

Iname = Iname + 1 
NameOfUnit(Iname) = 'CalculateVWpVXp'
 
mat(1,1) = 0._dp 
mat(1,1) = mat(1,1)+(g2**2*v1Fix**2)/2._dp
mat(1,1) = mat(1,1)+(g2**2*v2Fix**2)/2._dp
mat(1,2) = 0._dp 
mat(1,3) = 0._dp 
mat(1,4) = 0._dp 
mat(2,2) = 0._dp 
mat(2,2) = mat(2,2)+(g2**2*v1Fix**2)/2._dp
mat(2,2) = mat(2,2)+(g2**2*v2Fix**2)/2._dp
mat(2,3) = 0._dp 
mat(2,4) = 0._dp 
mat(3,3) = 0._dp 
mat(3,3) = mat(3,3)+(g2**2*v2Fix**2)/2._dp
mat(3,3) = mat(3,3)+(g2**2*VnFix**2)/2._dp
mat(3,4) = 0._dp 
mat(4,4) = 0._dp 
mat(4,4) = mat(4,4)+(g2**2*v2Fix**2)/2._dp
mat(4,4) = mat(4,4)+(g2**2*VnFix**2)/2._dp

 
 Do i1=2,4
  Do i2 = 1, i1-1 
  mat(i1,i2) = Conjg(mat(i2,i1)) 
  End do 
End do 

 
Call EigenSystem(mat,VWpVXp2,ZW,ierr,test) 
 
 
ZW = Transpose(ZW) 
If ((ierr.Eq.-8).Or.(ierr.Eq.-9)) Then 
  Write(ErrCan,*) "Possible numerical problem in "//NameOfUnit(Iname) 
  If (ErrorLevel.Eq.2) Then 
  Write(*,*) "Possible numerical problem in "//NameOfUnit(Iname) 
    Call TerminateProgram 
  End If 
  ierr = 0 
End If 
 
If ((ierr.Ne.0.).And.(ErrorLevel.Ge.-1)) Then 
  Write(10,*) 'Warning from Subroutine '//NameOfUnit(Iname) 
  Write(10,*) 'Diagonalization failed, ierr : ',ierr 
  kont = ierr 
  Iname = Iname - 1 
  Return 
End If 


Do i1=1,4
  If (Abs(VWpVXp2(i1)).Le.1.E-10_dp*(Maxval(VWpVXp2))) VWpVXp2(i1) = 1.E-10_dp 
  If (VWpVXp2(i1).ne.VWpVXp2(i1)) Then 
      Write(*,*) 'NaN appearing in '//NameOfUnit(Iname) 
      Call TerminateProgram 
    End If 
  If (VWpVXp2(i1).Ge.0._dp) Then 
  VWpVXp(i1) =Sqrt(VWpVXp2(i1) ) 
  Else 
  VWpVXp(i1)= 1._dp 
  VWpVXp(i1)= 1._dp 
! kont = -104 
 End if 
End Do 
 
MVWp = VWpVXp(1) 
MVWp2 = VWpVXp2(1) 
MVXp = VWpVXp(3) 
MVXp2 = VWpVXp2(3) 

 Iname = Iname - 1 
 
End Subroutine CalculateVWpVXpEffPot 

Subroutine TreeMassesSM(MFd,MFd2,MFe,MFe2,MFu,MFu2,MVWp,MVWp2,MVXp,MVXp2,             & 
& MVZ,MVZ2,MVZp,MVZp2,Ud,Ue,Uu,Vd,Ve,Vu,ZW,ZZ,Vn,v1,v2,g1,g2,g3,l1,l12,l13,              & 
& l12t,l13t,l2,l23,l23t,l3,hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,               & 
& hdtp1,hdt2,hup21,hUp2,hd3,hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,GenerationMixing,kont)

Implicit None 
 
Real(dp),Intent(in) :: g1,g2,g3,ftri,mu12,mu22,mu32

Complex(dp),Intent(in) :: l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,hll1(3,3),hdp11(3),hd1(3),hdtp11(2),              & 
& hdt1(2),hup11(3),hUp1,hdp1(3),hd2(3),hdtp1(2),hdt2(2),hup21(3),hUp2,hd3(3),            & 
& hdt3(2),hu11(3),h12(3),hU1,hU2

Real(dp),Intent(out) :: MFd(5),MFd2(5),MFe(3),MFe2(3),MFu(4),MFu2(4),MVWp,MVWp2,MVXp,MVXp2,MVZ,               & 
& MVZ2,MVZp,MVZp2

Complex(dp),Intent(out) :: Ud(5,5),Ue(3,3),Uu(4,4),Vd(5,5),Ve(3,3),Vu(4,4),ZW(4,4),ZZ(3,3)

Real(dp),Intent(in) :: Vn,v1,v2

Logical, Intent(in) :: GenerationMixing 
Integer, Intent(inout) :: kont 
Integer :: i1,i2,i3,i4,j1,j2,j3,kontSave 
Iname = Iname + 1 
NameOfUnit(Iname) = 'TreeMasses331/v3'
 
kont = 0 
Call CalculateMFd(hdp11,hd1,hdtp11,hdt1,hdp1,hd2,hdtp1,hdt2,hd3,hdt3,Vn,              & 
& v1,v2,Vd,Ud,MFd,kont)

MFd2 = MFd**2 
Call CalculateMFu(hup11,hUp1,hup21,hUp2,hu11,h12,hU1,hU2,Vn,v1,v2,Vu,Uu,MFu,kont)

MFu2 = MFu**2 
Call CalculateMFe(hll1,v2,Ve,Ue,MFe,kont)

MFe2 = MFe**2 

 
 Call CalculateVPVZVZp(g1,g2,Vn,v1,v2,ZZ,MVZ,MVZp,MVZ2,MVZp2,kont)

Call CalculateVWpVXp(g2,Vn,v1,v2,ZW,MVWp,MVXp,MVWp2,MVXp2,kont)

Iname = Iname - 1 
 
End Subroutine  TreeMassesSM 
 
 
Subroutine SortGoldstones(MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,MFe2,MFu,MFu2,             & 
& Mhh,Mhh2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,TW,Ud,Ue,Uu,             & 
& Vd,Ve,Vu,ZA,ZH,ZP,ZW,zy,ZZ,kont)

Real(dp),Intent(inout) :: MAh(3),MAh2(3),MDpm(2),MDpm2(2),MFd(5),MFd2(5),MFe(3),MFe2(3),MFu(4),MFu2(4),         & 
& Mhh(3),Mhh2(3),MHpm(4),MHpm2(4),MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,TW

Complex(dp),Intent(inout) :: Ud(5,5),Ue(3,3),Uu(4,4),Vd(5,5),Ve(3,3),Vu(4,4),ZA(3,3),ZH(3,3),ZP(4,4),              & 
& ZW(4,4),zy(2,2),ZZ(3,3)

Integer, Intent(inout) :: kont 
Integer :: i1, i2, pos 
Real(dp) :: MAhtemp(3) 
Complex(dp) :: ZAhtemp(3,3) 
Real(dp) :: MHpmtemp(4) 
Complex(dp) :: ZHpmtemp(4,4) 


pos = MinLoc(Abs(MAh2-MVZ2*RXiZ),1) 
If (pos.ne.1) Then 
  MAhtemp = MAh2 
  ZAhtemp = ZA 
  MAh2(1) = MAhtemp(pos) 
  ZA(1,:) = ZAhtemp(pos,:) 
  MAh2(pos) = MAhtemp(1) 
  ZA(pos,:) = ZAhtemp(1,:) 
End if 
pos = MinLoc(Abs(MAh2-MVZp2*RXiZp),1) 
If (pos.ne.2) Then 
  MAhtemp = MAh2 
  ZAhtemp = ZA 
  MAh2(2) = MAhtemp(pos) 
  ZA(2,:) = ZAhtemp(pos,:) 
  MAh2(pos) = MAhtemp(2) 
  ZA(pos,:) = ZAhtemp(2,:) 
End if 

 ! Reorder the physical states by their mass 
Do i1=3,3
 pos = Minloc(MAh2(i1:3),1) + i1 -1  
If (pos.ne.i1) Then 
  MAhtemp = MAh2 
  ZAhtemp = ZA 
  MAh2(i1) = MAhtemp(pos) 
  ZA(i1,:) = ZAhtemp(pos,:) 
  MAh2(pos) = MAhtemp(i1) 
  ZA(pos,:) = ZAhtemp(i1,:) 
End if 
End do 
MAh = sqrt(MAh2) 

 
 
pos = MinLoc(Abs(MHpm2-MVWp2*RXiWp),1) 
If (pos.ne.1) Then 
  MHpmtemp = MHpm2 
  ZHpmtemp = ZP 
  MHpm2(1) = MHpmtemp(pos) 
  ZP(1,:) = ZHpmtemp(pos,:) 
  MHpm2(pos) = MHpmtemp(1) 
  ZP(pos,:) = ZHpmtemp(1,:) 
End if 
pos = MinLoc(Abs(MHpm2-MVXp2*RXiXp),1) 
If (pos.ne.2) Then 
  MHpmtemp = MHpm2 
  ZHpmtemp = ZP 
  MHpm2(2) = MHpmtemp(pos) 
  ZP(2,:) = ZHpmtemp(pos,:) 
  MHpm2(pos) = MHpmtemp(2) 
  ZP(pos,:) = ZHpmtemp(2,:) 
End if 

 ! Reorder the physical states by their mass 
Do i1=3,4
 pos = Minloc(MHpm2(i1:4),1) + i1 -1  
If (pos.ne.i1) Then 
  MHpmtemp = MHpm2 
  ZHpmtemp = ZP 
  MHpm2(i1) = MHpmtemp(pos) 
  ZP(i1,:) = ZHpmtemp(pos,:) 
  MHpm2(pos) = MHpmtemp(i1) 
  ZP(pos,:) = ZHpmtemp(i1,:) 
End if 
End do 
MHpm = sqrt(MHpm2) 

 
 
End subroutine SortGoldstones 


End Module TreeLevelMasses_331v3 
 
