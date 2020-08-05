! -----------------------------------------------------------------------------  
! This file was automatically created by SARAH version 4.14.3 
! SARAH References: arXiv:0806.0538, 0909.2863, 1002.0840, 1207.0906, 1309.7223  
! (c) Florian Staub, 2013  
! ------------------------------------------------------------------------------  
! File created at 16:42 on 3.7.2020   
! ----------------------------------------------------------------------  
 
 
Module RGEs_331v3 
 
Use Control 
Use Settings 
Use Model_Data_331v3 
Use Mathematics 
 
Logical,Private,Save::OnlyDiagonal

Real(dp),Parameter::id3R(3,3)=& 
   & Reshape(Source=(/& 
   & 1,0,0,& 
 &0,1,0,& 
 &0,0,1& 
 &/),shape=(/3,3/)) 
Contains 


Subroutine GToParameters125(g,g1,g2,g3,l1,l12,l13,l12t,l13t,l2,l23,l23t,              & 
& l3,hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,hUp2,               & 
& hd3,hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32)

Implicit None 
Real(dp), Intent(in) :: g(125) 
Real(dp),Intent(out) :: g1,g2,g3,ftri,mu12,mu22,mu32

Complex(dp),Intent(out) :: l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,hll1(3,3),hdp11(3),hd1(3),hdtp11(2),              & 
& hdt1(2),hup11(3),hUp1,hdp1(3),hd2(3),hdtp1(2),hdt2(2),hup21(3),hUp2,hd3(3),            & 
& hdt3(2),hu11(3),h12(3),hU1,hU2

Integer i1, i2, i3, i4, SumI 
 
Iname = Iname +1 
NameOfUnit(Iname) = 'GToParameters125' 
 
g1= g(1) 
g2= g(2) 
g3= g(3) 
l1= Cmplx(g(4),g(5),dp) 
l12= Cmplx(g(6),g(7),dp) 
l13= Cmplx(g(8),g(9),dp) 
l12t= Cmplx(g(10),g(11),dp) 
l13t= Cmplx(g(12),g(13),dp) 
l2= Cmplx(g(14),g(15),dp) 
l23= Cmplx(g(16),g(17),dp) 
l23t= Cmplx(g(18),g(19),dp) 
l3= Cmplx(g(20),g(21),dp) 
Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
hll1(i1,i2) = Cmplx( g(SumI+22), g(SumI+23), dp) 
End Do 
 End Do 
 
Do i1 = 1,3
SumI = (i1-1) 
SumI = SumI*2 
hdp11(i1) = Cmplx( g(SumI+40), g(SumI+41), dp) 
End Do 
 
Do i1 = 1,3
SumI = (i1-1) 
SumI = SumI*2 
hd1(i1) = Cmplx( g(SumI+46), g(SumI+47), dp) 
End Do 
 
Do i1 = 1,2
SumI = (i1-1) 
SumI = SumI*2 
hdtp11(i1) = Cmplx( g(SumI+52), g(SumI+53), dp) 
End Do 
 
Do i1 = 1,2
SumI = (i1-1) 
SumI = SumI*2 
hdt1(i1) = Cmplx( g(SumI+56), g(SumI+57), dp) 
End Do 
 
Do i1 = 1,3
SumI = (i1-1) 
SumI = SumI*2 
hup11(i1) = Cmplx( g(SumI+60), g(SumI+61), dp) 
End Do 
 
hUp1= Cmplx(g(66),g(67),dp) 
Do i1 = 1,3
SumI = (i1-1) 
SumI = SumI*2 
hdp1(i1) = Cmplx( g(SumI+68), g(SumI+69), dp) 
End Do 
 
Do i1 = 1,3
SumI = (i1-1) 
SumI = SumI*2 
hd2(i1) = Cmplx( g(SumI+74), g(SumI+75), dp) 
End Do 
 
Do i1 = 1,2
SumI = (i1-1) 
SumI = SumI*2 
hdtp1(i1) = Cmplx( g(SumI+80), g(SumI+81), dp) 
End Do 
 
Do i1 = 1,2
SumI = (i1-1) 
SumI = SumI*2 
hdt2(i1) = Cmplx( g(SumI+84), g(SumI+85), dp) 
End Do 
 
Do i1 = 1,3
SumI = (i1-1) 
SumI = SumI*2 
hup21(i1) = Cmplx( g(SumI+88), g(SumI+89), dp) 
End Do 
 
hUp2= Cmplx(g(94),g(95),dp) 
Do i1 = 1,3
SumI = (i1-1) 
SumI = SumI*2 
hd3(i1) = Cmplx( g(SumI+96), g(SumI+97), dp) 
End Do 
 
Do i1 = 1,2
SumI = (i1-1) 
SumI = SumI*2 
hdt3(i1) = Cmplx( g(SumI+102), g(SumI+103), dp) 
End Do 
 
Do i1 = 1,3
SumI = (i1-1) 
SumI = SumI*2 
hu11(i1) = Cmplx( g(SumI+106), g(SumI+107), dp) 
End Do 
 
Do i1 = 1,3
SumI = (i1-1) 
SumI = SumI*2 
h12(i1) = Cmplx( g(SumI+112), g(SumI+113), dp) 
End Do 
 
hU1= Cmplx(g(118),g(119),dp) 
hU2= Cmplx(g(120),g(121),dp) 
ftri= g(122) 
mu12= g(123) 
mu22= g(124) 
mu32= g(125) 
Do i1=1,125 
If (g(i1).ne.g(i1)) Then 
 Write(*,*) "NaN appearing in ",NameOfUnit(Iname) 
 Write(*,*) "At position ", i1 
 Call TerminateProgram 
End if 
End do 
Iname = Iname - 1 
 
End Subroutine GToParameters125

Subroutine ParametersToG125(g1,g2,g3,l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,             & 
& hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,hUp2,hd3,              & 
& hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,g)

Implicit None 
Real(dp), Intent(out) :: g(125) 
Real(dp), Intent(in) :: g1,g2,g3,ftri,mu12,mu22,mu32

Complex(dp), Intent(in) :: l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,hll1(3,3),hdp11(3),hd1(3),hdtp11(2),              & 
& hdt1(2),hup11(3),hUp1,hdp1(3),hd2(3),hdtp1(2),hdt2(2),hup21(3),hUp2,hd3(3),            & 
& hdt3(2),hu11(3),h12(3),hU1,hU2

Integer i1, i2, i3, i4, SumI 
 
Iname = Iname +1 
NameOfUnit(Iname) = 'ParametersToG125' 
 
g(1) = g1  
g(2) = g2  
g(3) = g3  
g(4) = Real(l1,dp)  
g(5) = Aimag(l1)  
g(6) = Real(l12,dp)  
g(7) = Aimag(l12)  
g(8) = Real(l13,dp)  
g(9) = Aimag(l13)  
g(10) = Real(l12t,dp)  
g(11) = Aimag(l12t)  
g(12) = Real(l13t,dp)  
g(13) = Aimag(l13t)  
g(14) = Real(l2,dp)  
g(15) = Aimag(l2)  
g(16) = Real(l23,dp)  
g(17) = Aimag(l23)  
g(18) = Real(l23t,dp)  
g(19) = Aimag(l23t)  
g(20) = Real(l3,dp)  
g(21) = Aimag(l3)  
Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
g(SumI+22) = Real(hll1(i1,i2), dp) 
g(SumI+23) = Aimag(hll1(i1,i2)) 
End Do 
End Do 

Do i1 = 1,3
SumI = (i1-1) 
SumI = SumI*2 
g(SumI+40) = Real(hdp11(i1), dp) 
g(SumI+41) = Aimag(hdp11(i1)) 
End Do 

Do i1 = 1,3
SumI = (i1-1) 
SumI = SumI*2 
g(SumI+46) = Real(hd1(i1), dp) 
g(SumI+47) = Aimag(hd1(i1)) 
End Do 

Do i1 = 1,2
SumI = (i1-1) 
SumI = SumI*2 
g(SumI+52) = Real(hdtp11(i1), dp) 
g(SumI+53) = Aimag(hdtp11(i1)) 
End Do 

Do i1 = 1,2
SumI = (i1-1) 
SumI = SumI*2 
g(SumI+56) = Real(hdt1(i1), dp) 
g(SumI+57) = Aimag(hdt1(i1)) 
End Do 

Do i1 = 1,3
SumI = (i1-1) 
SumI = SumI*2 
g(SumI+60) = Real(hup11(i1), dp) 
g(SumI+61) = Aimag(hup11(i1)) 
End Do 

g(66) = Real(hUp1,dp)  
g(67) = Aimag(hUp1)  
Do i1 = 1,3
SumI = (i1-1) 
SumI = SumI*2 
g(SumI+68) = Real(hdp1(i1), dp) 
g(SumI+69) = Aimag(hdp1(i1)) 
End Do 

Do i1 = 1,3
SumI = (i1-1) 
SumI = SumI*2 
g(SumI+74) = Real(hd2(i1), dp) 
g(SumI+75) = Aimag(hd2(i1)) 
End Do 

Do i1 = 1,2
SumI = (i1-1) 
SumI = SumI*2 
g(SumI+80) = Real(hdtp1(i1), dp) 
g(SumI+81) = Aimag(hdtp1(i1)) 
End Do 

Do i1 = 1,2
SumI = (i1-1) 
SumI = SumI*2 
g(SumI+84) = Real(hdt2(i1), dp) 
g(SumI+85) = Aimag(hdt2(i1)) 
End Do 

Do i1 = 1,3
SumI = (i1-1) 
SumI = SumI*2 
g(SumI+88) = Real(hup21(i1), dp) 
g(SumI+89) = Aimag(hup21(i1)) 
End Do 

g(94) = Real(hUp2,dp)  
g(95) = Aimag(hUp2)  
Do i1 = 1,3
SumI = (i1-1) 
SumI = SumI*2 
g(SumI+96) = Real(hd3(i1), dp) 
g(SumI+97) = Aimag(hd3(i1)) 
End Do 

Do i1 = 1,2
SumI = (i1-1) 
SumI = SumI*2 
g(SumI+102) = Real(hdt3(i1), dp) 
g(SumI+103) = Aimag(hdt3(i1)) 
End Do 

Do i1 = 1,3
SumI = (i1-1) 
SumI = SumI*2 
g(SumI+106) = Real(hu11(i1), dp) 
g(SumI+107) = Aimag(hu11(i1)) 
End Do 

Do i1 = 1,3
SumI = (i1-1) 
SumI = SumI*2 
g(SumI+112) = Real(h12(i1), dp) 
g(SumI+113) = Aimag(h12(i1)) 
End Do 

g(118) = Real(hU1,dp)  
g(119) = Aimag(hU1)  
g(120) = Real(hU2,dp)  
g(121) = Aimag(hU2)  
g(122) = ftri  
g(123) = mu12  
g(124) = mu22  
g(125) = mu32  
Iname = Iname - 1 
 
End Subroutine ParametersToG125

Subroutine rge125(len, T, GY, F) 
Implicit None 
Integer, Intent(in) :: len 
Real(dp), Intent(in) :: T, GY(len) 
Real(dp), Intent(out) :: F(len) 
Integer :: i1,i2,i3,i4 
Integer :: j1,j2,j3,j4,j5,j6,j7 
Real(dp) :: q 
Real(dp) :: g1,betag11,betag12,Dg1,g2,betag21,betag22,Dg2,g3,betag31,betag32,         & 
& Dg3,ftri,betaftri1,betaftri2,Dftri,mu12,betamu121,betamu122,Dmu12,mu22,betamu221,      & 
& betamu222,Dmu22,mu32,betamu321,betamu322,Dmu32
Complex(dp) :: l1,betal11,betal12,Dl1,l12,betal121,betal122,Dl12,l13,betal131,        & 
& betal132,Dl13,l12t,betal12t1,betal12t2,Dl12t,l13t,betal13t1,betal13t2,Dl13t,           & 
& l2,betal21,betal22,Dl2,l23,betal231,betal232,Dl23,l23t,betal23t1,betal23t2,            & 
& Dl23t,l3,betal31,betal32,Dl3,hll1(3,3),betahll11(3,3),betahll12(3,3),Dhll1(3,3)        & 
& ,adjhll1(3,3),hdp11(3),betahdp111(3),betahdp112(3),Dhdp11(3),hd1(3),betahd11(3)        & 
& ,betahd12(3),Dhd1(3),hdtp11(2),betahdtp111(2),betahdtp112(2),Dhdtp11(2),               & 
& hdt1(2),betahdt11(2),betahdt12(2),Dhdt1(2),hup11(3),betahup111(3),betahup112(3)        & 
& ,Dhup11(3),hUp1,betahUp11,betahUp12,DhUp1,hdp1(3),betahdp11(3),betahdp12(3)            & 
& ,Dhdp1(3),hd2(3),betahd21(3),betahd22(3),Dhd2(3),hdtp1(2),betahdtp11(2),               & 
& betahdtp12(2),Dhdtp1(2),hdt2(2),betahdt21(2),betahdt22(2),Dhdt2(2),hup21(3)            & 
& ,betahup211(3),betahup212(3),Dhup21(3),hUp2,betahUp21,betahUp22,DhUp2,hd3(3)           & 
& ,betahd31(3),betahd32(3),Dhd3(3),hdt3(2),betahdt31(2),betahdt32(2),Dhdt3(2)            & 
& ,hu11(3),betahu111(3),betahu112(3),Dhu11(3),h12(3),betah121(3),betah122(3)             & 
& ,Dh12(3),hU1,betahU11,betahU12,DhU1,hU2,betahU21,betahU22,DhU2
Iname = Iname +1 
NameOfUnit(Iname) = 'rge125' 
 
OnlyDiagonal = .Not.GenerationMixing 
q = t 
 
Call GToParameters125(gy,g1,g2,g3,l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,hll1,           & 
& hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,hUp2,hd3,hdt3,              & 
& hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32)

Call Adjungate(hll1,adjhll1)


If (TwoLoopRGE) Then 
End If 
 
 
!-------------------- 
! g1 
!-------------------- 
 
betag11  = 0

 
 
If (TwoLoopRGE) Then 
betag12 = 0

 
Dg1 = oo16pi2*( betag11 + oo16pi2 * betag12 ) 

 
Else 
Dg1 = oo16pi2* betag11 
End If 
 
 
!-------------------- 
! g2 
!-------------------- 
 
betag21  = 0

 
 
If (TwoLoopRGE) Then 
betag22 = 0

 
Dg2 = oo16pi2*( betag21 + oo16pi2 * betag22 ) 

 
Else 
Dg2 = oo16pi2* betag21 
End If 
 
 
!-------------------- 
! g3 
!-------------------- 
 
betag31  = 0

 
 
If (TwoLoopRGE) Then 
betag32 = 0

 
Dg3 = oo16pi2*( betag31 + oo16pi2 * betag32 ) 

 
Else 
Dg3 = oo16pi2* betag31 
End If 
 
 
!-------------------- 
! l1 
!-------------------- 
 
betal11  = 0

 
 
If (TwoLoopRGE) Then 
betal12 = 0

 
Dl1 = oo16pi2*( betal11 + oo16pi2 * betal12 ) 

 
Else 
Dl1 = oo16pi2* betal11 
End If 
 
 
Call Chop(Dl1) 

!-------------------- 
! l12 
!-------------------- 
 
betal121  = 0

 
 
If (TwoLoopRGE) Then 
betal122 = 0

 
Dl12 = oo16pi2*( betal121 + oo16pi2 * betal122 ) 

 
Else 
Dl12 = oo16pi2* betal121 
End If 
 
 
Call Chop(Dl12) 

!-------------------- 
! l13 
!-------------------- 
 
betal131  = 0

 
 
If (TwoLoopRGE) Then 
betal132 = 0

 
Dl13 = oo16pi2*( betal131 + oo16pi2 * betal132 ) 

 
Else 
Dl13 = oo16pi2* betal131 
End If 
 
 
Call Chop(Dl13) 

!-------------------- 
! l12t 
!-------------------- 
 
betal12t1  = 0

 
 
If (TwoLoopRGE) Then 
betal12t2 = 0

 
Dl12t = oo16pi2*( betal12t1 + oo16pi2 * betal12t2 ) 

 
Else 
Dl12t = oo16pi2* betal12t1 
End If 
 
 
Call Chop(Dl12t) 

!-------------------- 
! l13t 
!-------------------- 
 
betal13t1  = 0

 
 
If (TwoLoopRGE) Then 
betal13t2 = 0

 
Dl13t = oo16pi2*( betal13t1 + oo16pi2 * betal13t2 ) 

 
Else 
Dl13t = oo16pi2* betal13t1 
End If 
 
 
Call Chop(Dl13t) 

!-------------------- 
! l2 
!-------------------- 
 
betal21  = 0

 
 
If (TwoLoopRGE) Then 
betal22 = 0

 
Dl2 = oo16pi2*( betal21 + oo16pi2 * betal22 ) 

 
Else 
Dl2 = oo16pi2* betal21 
End If 
 
 
Call Chop(Dl2) 

!-------------------- 
! l23 
!-------------------- 
 
betal231  = 0

 
 
If (TwoLoopRGE) Then 
betal232 = 0

 
Dl23 = oo16pi2*( betal231 + oo16pi2 * betal232 ) 

 
Else 
Dl23 = oo16pi2* betal231 
End If 
 
 
Call Chop(Dl23) 

!-------------------- 
! l23t 
!-------------------- 
 
betal23t1  = 0

 
 
If (TwoLoopRGE) Then 
betal23t2 = 0

 
Dl23t = oo16pi2*( betal23t1 + oo16pi2 * betal23t2 ) 

 
Else 
Dl23t = oo16pi2* betal23t1 
End If 
 
 
Call Chop(Dl23t) 

!-------------------- 
! l3 
!-------------------- 
 
betal31  = 0

 
 
If (TwoLoopRGE) Then 
betal32 = 0

 
Dl3 = oo16pi2*( betal31 + oo16pi2 * betal32 ) 

 
Else 
Dl3 = oo16pi2* betal31 
End If 
 
 
Call Chop(Dl3) 

!-------------------- 
! hll1 
!-------------------- 
 
betahll11  = 0

 
 
If (TwoLoopRGE) Then 
betahll12 = 0

 
Dhll1 = oo16pi2*( betahll11 + oo16pi2 * betahll12 ) 

 
Else 
Dhll1 = oo16pi2* betahll11 
End If 
 
 
Call Chop(Dhll1) 

!-------------------- 
! hdp11 
!-------------------- 
 
betahdp111  = 0

 
 
If (TwoLoopRGE) Then 
betahdp112 = 0

 
Dhdp11 = oo16pi2*( betahdp111 + oo16pi2 * betahdp112 ) 

 
Else 
Dhdp11 = oo16pi2* betahdp111 
End If 
 
 
Call Chop(Dhdp11) 

!-------------------- 
! hd1 
!-------------------- 
 
betahd11  = 0

 
 
If (TwoLoopRGE) Then 
betahd12 = 0

 
Dhd1 = oo16pi2*( betahd11 + oo16pi2 * betahd12 ) 

 
Else 
Dhd1 = oo16pi2* betahd11 
End If 
 
 
Call Chop(Dhd1) 

!-------------------- 
! hdtp11 
!-------------------- 
 
betahdtp111  = 0

 
 
If (TwoLoopRGE) Then 
betahdtp112 = 0

 
Dhdtp11 = oo16pi2*( betahdtp111 + oo16pi2 * betahdtp112 ) 

 
Else 
Dhdtp11 = oo16pi2* betahdtp111 
End If 
 
 
Call Chop(Dhdtp11) 

!-------------------- 
! hdt1 
!-------------------- 
 
betahdt11  = 0

 
 
If (TwoLoopRGE) Then 
betahdt12 = 0

 
Dhdt1 = oo16pi2*( betahdt11 + oo16pi2 * betahdt12 ) 

 
Else 
Dhdt1 = oo16pi2* betahdt11 
End If 
 
 
Call Chop(Dhdt1) 

!-------------------- 
! hup11 
!-------------------- 
 
betahup111  = 0

 
 
If (TwoLoopRGE) Then 
betahup112 = 0

 
Dhup11 = oo16pi2*( betahup111 + oo16pi2 * betahup112 ) 

 
Else 
Dhup11 = oo16pi2* betahup111 
End If 
 
 
Call Chop(Dhup11) 

!-------------------- 
! hUp1 
!-------------------- 
 
betahUp11  = 0

 
 
If (TwoLoopRGE) Then 
betahUp12 = 0

 
DhUp1 = oo16pi2*( betahUp11 + oo16pi2 * betahUp12 ) 

 
Else 
DhUp1 = oo16pi2* betahUp11 
End If 
 
 
Call Chop(DhUp1) 

!-------------------- 
! hdp1 
!-------------------- 
 
betahdp11  = 0

 
 
If (TwoLoopRGE) Then 
betahdp12 = 0

 
Dhdp1 = oo16pi2*( betahdp11 + oo16pi2 * betahdp12 ) 

 
Else 
Dhdp1 = oo16pi2* betahdp11 
End If 
 
 
Call Chop(Dhdp1) 

!-------------------- 
! hd2 
!-------------------- 
 
betahd21  = 0

 
 
If (TwoLoopRGE) Then 
betahd22 = 0

 
Dhd2 = oo16pi2*( betahd21 + oo16pi2 * betahd22 ) 

 
Else 
Dhd2 = oo16pi2* betahd21 
End If 
 
 
Call Chop(Dhd2) 

!-------------------- 
! hdtp1 
!-------------------- 
 
betahdtp11  = 0

 
 
If (TwoLoopRGE) Then 
betahdtp12 = 0

 
Dhdtp1 = oo16pi2*( betahdtp11 + oo16pi2 * betahdtp12 ) 

 
Else 
Dhdtp1 = oo16pi2* betahdtp11 
End If 
 
 
Call Chop(Dhdtp1) 

!-------------------- 
! hdt2 
!-------------------- 
 
betahdt21  = 0

 
 
If (TwoLoopRGE) Then 
betahdt22 = 0

 
Dhdt2 = oo16pi2*( betahdt21 + oo16pi2 * betahdt22 ) 

 
Else 
Dhdt2 = oo16pi2* betahdt21 
End If 
 
 
Call Chop(Dhdt2) 

!-------------------- 
! hup21 
!-------------------- 
 
betahup211  = 0

 
 
If (TwoLoopRGE) Then 
betahup212 = 0

 
Dhup21 = oo16pi2*( betahup211 + oo16pi2 * betahup212 ) 

 
Else 
Dhup21 = oo16pi2* betahup211 
End If 
 
 
Call Chop(Dhup21) 

!-------------------- 
! hUp2 
!-------------------- 
 
betahUp21  = 0

 
 
If (TwoLoopRGE) Then 
betahUp22 = 0

 
DhUp2 = oo16pi2*( betahUp21 + oo16pi2 * betahUp22 ) 

 
Else 
DhUp2 = oo16pi2* betahUp21 
End If 
 
 
Call Chop(DhUp2) 

!-------------------- 
! hd3 
!-------------------- 
 
betahd31  = 0

 
 
If (TwoLoopRGE) Then 
betahd32 = 0

 
Dhd3 = oo16pi2*( betahd31 + oo16pi2 * betahd32 ) 

 
Else 
Dhd3 = oo16pi2* betahd31 
End If 
 
 
Call Chop(Dhd3) 

!-------------------- 
! hdt3 
!-------------------- 
 
betahdt31  = 0

 
 
If (TwoLoopRGE) Then 
betahdt32 = 0

 
Dhdt3 = oo16pi2*( betahdt31 + oo16pi2 * betahdt32 ) 

 
Else 
Dhdt3 = oo16pi2* betahdt31 
End If 
 
 
Call Chop(Dhdt3) 

!-------------------- 
! hu11 
!-------------------- 
 
betahu111  = 0

 
 
If (TwoLoopRGE) Then 
betahu112 = 0

 
Dhu11 = oo16pi2*( betahu111 + oo16pi2 * betahu112 ) 

 
Else 
Dhu11 = oo16pi2* betahu111 
End If 
 
 
Call Chop(Dhu11) 

!-------------------- 
! h12 
!-------------------- 
 
betah121  = 0

 
 
If (TwoLoopRGE) Then 
betah122 = 0

 
Dh12 = oo16pi2*( betah121 + oo16pi2 * betah122 ) 

 
Else 
Dh12 = oo16pi2* betah121 
End If 
 
 
Call Chop(Dh12) 

!-------------------- 
! hU1 
!-------------------- 
 
betahU11  = 0

 
 
If (TwoLoopRGE) Then 
betahU12 = 0

 
DhU1 = oo16pi2*( betahU11 + oo16pi2 * betahU12 ) 

 
Else 
DhU1 = oo16pi2* betahU11 
End If 
 
 
Call Chop(DhU1) 

!-------------------- 
! hU2 
!-------------------- 
 
betahU21  = 0

 
 
If (TwoLoopRGE) Then 
betahU22 = 0

 
DhU2 = oo16pi2*( betahU21 + oo16pi2 * betahU22 ) 

 
Else 
DhU2 = oo16pi2* betahU21 
End If 
 
 
Call Chop(DhU2) 

!-------------------- 
! ftri 
!-------------------- 
 
betaftri1  = 0

 
 
If (TwoLoopRGE) Then 
betaftri2 = 0

 
Dftri = oo16pi2*( betaftri1 + oo16pi2 * betaftri2 ) 

 
Else 
Dftri = oo16pi2* betaftri1 
End If 
 
 
!-------------------- 
! mu12 
!-------------------- 
 
betamu121  = 0

 
 
If (TwoLoopRGE) Then 
betamu122 = 0

 
Dmu12 = oo16pi2*( betamu121 + oo16pi2 * betamu122 ) 

 
Else 
Dmu12 = oo16pi2* betamu121 
End If 
 
 
!-------------------- 
! mu22 
!-------------------- 
 
betamu221  = 0

 
 
If (TwoLoopRGE) Then 
betamu222 = 0

 
Dmu22 = oo16pi2*( betamu221 + oo16pi2 * betamu222 ) 

 
Else 
Dmu22 = oo16pi2* betamu221 
End If 
 
 
!-------------------- 
! mu32 
!-------------------- 
 
betamu321  = 0

 
 
If (TwoLoopRGE) Then 
betamu322 = 0

 
Dmu32 = oo16pi2*( betamu321 + oo16pi2 * betamu322 ) 

 
Else 
Dmu32 = oo16pi2* betamu321 
End If 
 
 
Call ParametersToG125(Dg1,Dg2,Dg3,Dl1,Dl12,Dl13,Dl12t,Dl13t,Dl2,Dl23,Dl23t,           & 
& Dl3,Dhll1,Dhdp11,Dhd1,Dhdtp11,Dhdt1,Dhup11,DhUp1,Dhdp1,Dhd2,Dhdtp1,Dhdt2,              & 
& Dhup21,DhUp2,Dhd3,Dhdt3,Dhu11,Dh12,DhU1,DhU2,Dftri,Dmu12,Dmu22,Dmu32,f)

Iname = Iname - 1 
 
End Subroutine rge125  

Subroutine GToParameters128(g,g1,g2,g3,l1,l12,l13,l12t,l13t,l2,l23,l23t,              & 
& l3,hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,hUp2,               & 
& hd3,hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,Vn,v1,v2)

Implicit None 
Real(dp), Intent(in) :: g(128) 
Real(dp),Intent(out) :: g1,g2,g3,ftri,mu12,mu22,mu32,Vn,v1,v2

Complex(dp),Intent(out) :: l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,hll1(3,3),hdp11(3),hd1(3),hdtp11(2),              & 
& hdt1(2),hup11(3),hUp1,hdp1(3),hd2(3),hdtp1(2),hdt2(2),hup21(3),hUp2,hd3(3),            & 
& hdt3(2),hu11(3),h12(3),hU1,hU2

Integer i1, i2, i3, i4, SumI 
 
Iname = Iname +1 
NameOfUnit(Iname) = 'GToParameters128' 
 
g1= g(1) 
g2= g(2) 
g3= g(3) 
l1= Cmplx(g(4),g(5),dp) 
l12= Cmplx(g(6),g(7),dp) 
l13= Cmplx(g(8),g(9),dp) 
l12t= Cmplx(g(10),g(11),dp) 
l13t= Cmplx(g(12),g(13),dp) 
l2= Cmplx(g(14),g(15),dp) 
l23= Cmplx(g(16),g(17),dp) 
l23t= Cmplx(g(18),g(19),dp) 
l3= Cmplx(g(20),g(21),dp) 
Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
hll1(i1,i2) = Cmplx( g(SumI+22), g(SumI+23), dp) 
End Do 
 End Do 
 
Do i1 = 1,3
SumI = (i1-1) 
SumI = SumI*2 
hdp11(i1) = Cmplx( g(SumI+40), g(SumI+41), dp) 
End Do 
 
Do i1 = 1,3
SumI = (i1-1) 
SumI = SumI*2 
hd1(i1) = Cmplx( g(SumI+46), g(SumI+47), dp) 
End Do 
 
Do i1 = 1,2
SumI = (i1-1) 
SumI = SumI*2 
hdtp11(i1) = Cmplx( g(SumI+52), g(SumI+53), dp) 
End Do 
 
Do i1 = 1,2
SumI = (i1-1) 
SumI = SumI*2 
hdt1(i1) = Cmplx( g(SumI+56), g(SumI+57), dp) 
End Do 
 
Do i1 = 1,3
SumI = (i1-1) 
SumI = SumI*2 
hup11(i1) = Cmplx( g(SumI+60), g(SumI+61), dp) 
End Do 
 
hUp1= Cmplx(g(66),g(67),dp) 
Do i1 = 1,3
SumI = (i1-1) 
SumI = SumI*2 
hdp1(i1) = Cmplx( g(SumI+68), g(SumI+69), dp) 
End Do 
 
Do i1 = 1,3
SumI = (i1-1) 
SumI = SumI*2 
hd2(i1) = Cmplx( g(SumI+74), g(SumI+75), dp) 
End Do 
 
Do i1 = 1,2
SumI = (i1-1) 
SumI = SumI*2 
hdtp1(i1) = Cmplx( g(SumI+80), g(SumI+81), dp) 
End Do 
 
Do i1 = 1,2
SumI = (i1-1) 
SumI = SumI*2 
hdt2(i1) = Cmplx( g(SumI+84), g(SumI+85), dp) 
End Do 
 
Do i1 = 1,3
SumI = (i1-1) 
SumI = SumI*2 
hup21(i1) = Cmplx( g(SumI+88), g(SumI+89), dp) 
End Do 
 
hUp2= Cmplx(g(94),g(95),dp) 
Do i1 = 1,3
SumI = (i1-1) 
SumI = SumI*2 
hd3(i1) = Cmplx( g(SumI+96), g(SumI+97), dp) 
End Do 
 
Do i1 = 1,2
SumI = (i1-1) 
SumI = SumI*2 
hdt3(i1) = Cmplx( g(SumI+102), g(SumI+103), dp) 
End Do 
 
Do i1 = 1,3
SumI = (i1-1) 
SumI = SumI*2 
hu11(i1) = Cmplx( g(SumI+106), g(SumI+107), dp) 
End Do 
 
Do i1 = 1,3
SumI = (i1-1) 
SumI = SumI*2 
h12(i1) = Cmplx( g(SumI+112), g(SumI+113), dp) 
End Do 
 
hU1= Cmplx(g(118),g(119),dp) 
hU2= Cmplx(g(120),g(121),dp) 
ftri= g(122) 
mu12= g(123) 
mu22= g(124) 
mu32= g(125) 
Vn= g(126) 
v1= g(127) 
v2= g(128) 
Do i1=1,128 
If (g(i1).ne.g(i1)) Then 
 Write(*,*) "NaN appearing in ",NameOfUnit(Iname) 
 Write(*,*) "At position ", i1 
 Call TerminateProgram 
End if 
End do 
Iname = Iname - 1 
 
End Subroutine GToParameters128

Subroutine ParametersToG128(g1,g2,g3,l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,             & 
& hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,hUp2,hd3,              & 
& hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,Vn,v1,v2,g)

Implicit None 
Real(dp), Intent(out) :: g(128) 
Real(dp), Intent(in) :: g1,g2,g3,ftri,mu12,mu22,mu32,Vn,v1,v2

Complex(dp), Intent(in) :: l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,hll1(3,3),hdp11(3),hd1(3),hdtp11(2),              & 
& hdt1(2),hup11(3),hUp1,hdp1(3),hd2(3),hdtp1(2),hdt2(2),hup21(3),hUp2,hd3(3),            & 
& hdt3(2),hu11(3),h12(3),hU1,hU2

Integer i1, i2, i3, i4, SumI 
 
Iname = Iname +1 
NameOfUnit(Iname) = 'ParametersToG128' 
 
g(1) = g1  
g(2) = g2  
g(3) = g3  
g(4) = Real(l1,dp)  
g(5) = Aimag(l1)  
g(6) = Real(l12,dp)  
g(7) = Aimag(l12)  
g(8) = Real(l13,dp)  
g(9) = Aimag(l13)  
g(10) = Real(l12t,dp)  
g(11) = Aimag(l12t)  
g(12) = Real(l13t,dp)  
g(13) = Aimag(l13t)  
g(14) = Real(l2,dp)  
g(15) = Aimag(l2)  
g(16) = Real(l23,dp)  
g(17) = Aimag(l23)  
g(18) = Real(l23t,dp)  
g(19) = Aimag(l23t)  
g(20) = Real(l3,dp)  
g(21) = Aimag(l3)  
Do i1 = 1,3
Do i2 = 1,3
SumI = (i2-1) + (i1-1)*3
SumI = SumI*2 
g(SumI+22) = Real(hll1(i1,i2), dp) 
g(SumI+23) = Aimag(hll1(i1,i2)) 
End Do 
End Do 

Do i1 = 1,3
SumI = (i1-1) 
SumI = SumI*2 
g(SumI+40) = Real(hdp11(i1), dp) 
g(SumI+41) = Aimag(hdp11(i1)) 
End Do 

Do i1 = 1,3
SumI = (i1-1) 
SumI = SumI*2 
g(SumI+46) = Real(hd1(i1), dp) 
g(SumI+47) = Aimag(hd1(i1)) 
End Do 

Do i1 = 1,2
SumI = (i1-1) 
SumI = SumI*2 
g(SumI+52) = Real(hdtp11(i1), dp) 
g(SumI+53) = Aimag(hdtp11(i1)) 
End Do 

Do i1 = 1,2
SumI = (i1-1) 
SumI = SumI*2 
g(SumI+56) = Real(hdt1(i1), dp) 
g(SumI+57) = Aimag(hdt1(i1)) 
End Do 

Do i1 = 1,3
SumI = (i1-1) 
SumI = SumI*2 
g(SumI+60) = Real(hup11(i1), dp) 
g(SumI+61) = Aimag(hup11(i1)) 
End Do 

g(66) = Real(hUp1,dp)  
g(67) = Aimag(hUp1)  
Do i1 = 1,3
SumI = (i1-1) 
SumI = SumI*2 
g(SumI+68) = Real(hdp1(i1), dp) 
g(SumI+69) = Aimag(hdp1(i1)) 
End Do 

Do i1 = 1,3
SumI = (i1-1) 
SumI = SumI*2 
g(SumI+74) = Real(hd2(i1), dp) 
g(SumI+75) = Aimag(hd2(i1)) 
End Do 

Do i1 = 1,2
SumI = (i1-1) 
SumI = SumI*2 
g(SumI+80) = Real(hdtp1(i1), dp) 
g(SumI+81) = Aimag(hdtp1(i1)) 
End Do 

Do i1 = 1,2
SumI = (i1-1) 
SumI = SumI*2 
g(SumI+84) = Real(hdt2(i1), dp) 
g(SumI+85) = Aimag(hdt2(i1)) 
End Do 

Do i1 = 1,3
SumI = (i1-1) 
SumI = SumI*2 
g(SumI+88) = Real(hup21(i1), dp) 
g(SumI+89) = Aimag(hup21(i1)) 
End Do 

g(94) = Real(hUp2,dp)  
g(95) = Aimag(hUp2)  
Do i1 = 1,3
SumI = (i1-1) 
SumI = SumI*2 
g(SumI+96) = Real(hd3(i1), dp) 
g(SumI+97) = Aimag(hd3(i1)) 
End Do 

Do i1 = 1,2
SumI = (i1-1) 
SumI = SumI*2 
g(SumI+102) = Real(hdt3(i1), dp) 
g(SumI+103) = Aimag(hdt3(i1)) 
End Do 

Do i1 = 1,3
SumI = (i1-1) 
SumI = SumI*2 
g(SumI+106) = Real(hu11(i1), dp) 
g(SumI+107) = Aimag(hu11(i1)) 
End Do 

Do i1 = 1,3
SumI = (i1-1) 
SumI = SumI*2 
g(SumI+112) = Real(h12(i1), dp) 
g(SumI+113) = Aimag(h12(i1)) 
End Do 

g(118) = Real(hU1,dp)  
g(119) = Aimag(hU1)  
g(120) = Real(hU2,dp)  
g(121) = Aimag(hU2)  
g(122) = ftri  
g(123) = mu12  
g(124) = mu22  
g(125) = mu32  
g(126) = Vn  
g(127) = v1  
g(128) = v2  
Iname = Iname - 1 
 
End Subroutine ParametersToG128

Subroutine rge128(len, T, GY, F) 
Implicit None 
Integer, Intent(in) :: len 
Real(dp), Intent(in) :: T, GY(len) 
Real(dp), Intent(out) :: F(len) 
Integer :: i1,i2,i3,i4 
Integer :: j1,j2,j3,j4,j5,j6,j7 
Real(dp) :: q 
Real(dp) :: g1,betag11,betag12,Dg1,g2,betag21,betag22,Dg2,g3,betag31,betag32,         & 
& Dg3,ftri,betaftri1,betaftri2,Dftri,mu12,betamu121,betamu122,Dmu12,mu22,betamu221,      & 
& betamu222,Dmu22,mu32,betamu321,betamu322,Dmu32,Vn,betaVn1,betaVn2,DVn,v1,              & 
& betav11,betav12,Dv1,v2,betav21,betav22,Dv2
Complex(dp) :: l1,betal11,betal12,Dl1,l12,betal121,betal122,Dl12,l13,betal131,        & 
& betal132,Dl13,l12t,betal12t1,betal12t2,Dl12t,l13t,betal13t1,betal13t2,Dl13t,           & 
& l2,betal21,betal22,Dl2,l23,betal231,betal232,Dl23,l23t,betal23t1,betal23t2,            & 
& Dl23t,l3,betal31,betal32,Dl3,hll1(3,3),betahll11(3,3),betahll12(3,3),Dhll1(3,3)        & 
& ,adjhll1(3,3),hdp11(3),betahdp111(3),betahdp112(3),Dhdp11(3),hd1(3),betahd11(3)        & 
& ,betahd12(3),Dhd1(3),hdtp11(2),betahdtp111(2),betahdtp112(2),Dhdtp11(2),               & 
& hdt1(2),betahdt11(2),betahdt12(2),Dhdt1(2),hup11(3),betahup111(3),betahup112(3)        & 
& ,Dhup11(3),hUp1,betahUp11,betahUp12,DhUp1,hdp1(3),betahdp11(3),betahdp12(3)            & 
& ,Dhdp1(3),hd2(3),betahd21(3),betahd22(3),Dhd2(3),hdtp1(2),betahdtp11(2),               & 
& betahdtp12(2),Dhdtp1(2),hdt2(2),betahdt21(2),betahdt22(2),Dhdt2(2),hup21(3)            & 
& ,betahup211(3),betahup212(3),Dhup21(3),hUp2,betahUp21,betahUp22,DhUp2,hd3(3)           & 
& ,betahd31(3),betahd32(3),Dhd3(3),hdt3(2),betahdt31(2),betahdt32(2),Dhdt3(2)            & 
& ,hu11(3),betahu111(3),betahu112(3),Dhu11(3),h12(3),betah121(3),betah122(3)             & 
& ,Dh12(3),hU1,betahU11,betahU12,DhU1,hU2,betahU21,betahU22,DhU2
Iname = Iname +1 
NameOfUnit(Iname) = 'rge128' 
 
OnlyDiagonal = .Not.GenerationMixing 
q = t 
 
Call GToParameters128(gy,g1,g2,g3,l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,hll1,           & 
& hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,hUp2,hd3,hdt3,              & 
& hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,Vn,v1,v2)

Call Adjungate(hll1,adjhll1)


If (TwoLoopRGE) Then 
End If 
 
 
!-------------------- 
! g1 
!-------------------- 
 
betag11  = 0

 
 
If (TwoLoopRGE) Then 
betag12 = 0

 
Dg1 = oo16pi2*( betag11 + oo16pi2 * betag12 ) 

 
Else 
Dg1 = oo16pi2* betag11 
End If 
 
 
!-------------------- 
! g2 
!-------------------- 
 
betag21  = 0

 
 
If (TwoLoopRGE) Then 
betag22 = 0

 
Dg2 = oo16pi2*( betag21 + oo16pi2 * betag22 ) 

 
Else 
Dg2 = oo16pi2* betag21 
End If 
 
 
!-------------------- 
! g3 
!-------------------- 
 
betag31  = 0

 
 
If (TwoLoopRGE) Then 
betag32 = 0

 
Dg3 = oo16pi2*( betag31 + oo16pi2 * betag32 ) 

 
Else 
Dg3 = oo16pi2* betag31 
End If 
 
 
!-------------------- 
! l1 
!-------------------- 
 
betal11  = 0

 
 
If (TwoLoopRGE) Then 
betal12 = 0

 
Dl1 = oo16pi2*( betal11 + oo16pi2 * betal12 ) 

 
Else 
Dl1 = oo16pi2* betal11 
End If 
 
 
Call Chop(Dl1) 

!-------------------- 
! l12 
!-------------------- 
 
betal121  = 0

 
 
If (TwoLoopRGE) Then 
betal122 = 0

 
Dl12 = oo16pi2*( betal121 + oo16pi2 * betal122 ) 

 
Else 
Dl12 = oo16pi2* betal121 
End If 
 
 
Call Chop(Dl12) 

!-------------------- 
! l13 
!-------------------- 
 
betal131  = 0

 
 
If (TwoLoopRGE) Then 
betal132 = 0

 
Dl13 = oo16pi2*( betal131 + oo16pi2 * betal132 ) 

 
Else 
Dl13 = oo16pi2* betal131 
End If 
 
 
Call Chop(Dl13) 

!-------------------- 
! l12t 
!-------------------- 
 
betal12t1  = 0

 
 
If (TwoLoopRGE) Then 
betal12t2 = 0

 
Dl12t = oo16pi2*( betal12t1 + oo16pi2 * betal12t2 ) 

 
Else 
Dl12t = oo16pi2* betal12t1 
End If 
 
 
Call Chop(Dl12t) 

!-------------------- 
! l13t 
!-------------------- 
 
betal13t1  = 0

 
 
If (TwoLoopRGE) Then 
betal13t2 = 0

 
Dl13t = oo16pi2*( betal13t1 + oo16pi2 * betal13t2 ) 

 
Else 
Dl13t = oo16pi2* betal13t1 
End If 
 
 
Call Chop(Dl13t) 

!-------------------- 
! l2 
!-------------------- 
 
betal21  = 0

 
 
If (TwoLoopRGE) Then 
betal22 = 0

 
Dl2 = oo16pi2*( betal21 + oo16pi2 * betal22 ) 

 
Else 
Dl2 = oo16pi2* betal21 
End If 
 
 
Call Chop(Dl2) 

!-------------------- 
! l23 
!-------------------- 
 
betal231  = 0

 
 
If (TwoLoopRGE) Then 
betal232 = 0

 
Dl23 = oo16pi2*( betal231 + oo16pi2 * betal232 ) 

 
Else 
Dl23 = oo16pi2* betal231 
End If 
 
 
Call Chop(Dl23) 

!-------------------- 
! l23t 
!-------------------- 
 
betal23t1  = 0

 
 
If (TwoLoopRGE) Then 
betal23t2 = 0

 
Dl23t = oo16pi2*( betal23t1 + oo16pi2 * betal23t2 ) 

 
Else 
Dl23t = oo16pi2* betal23t1 
End If 
 
 
Call Chop(Dl23t) 

!-------------------- 
! l3 
!-------------------- 
 
betal31  = 0

 
 
If (TwoLoopRGE) Then 
betal32 = 0

 
Dl3 = oo16pi2*( betal31 + oo16pi2 * betal32 ) 

 
Else 
Dl3 = oo16pi2* betal31 
End If 
 
 
Call Chop(Dl3) 

!-------------------- 
! hll1 
!-------------------- 
 
betahll11  = 0

 
 
If (TwoLoopRGE) Then 
betahll12 = 0

 
Dhll1 = oo16pi2*( betahll11 + oo16pi2 * betahll12 ) 

 
Else 
Dhll1 = oo16pi2* betahll11 
End If 
 
 
Call Chop(Dhll1) 

!-------------------- 
! hdp11 
!-------------------- 
 
betahdp111  = 0

 
 
If (TwoLoopRGE) Then 
betahdp112 = 0

 
Dhdp11 = oo16pi2*( betahdp111 + oo16pi2 * betahdp112 ) 

 
Else 
Dhdp11 = oo16pi2* betahdp111 
End If 
 
 
Call Chop(Dhdp11) 

!-------------------- 
! hd1 
!-------------------- 
 
betahd11  = 0

 
 
If (TwoLoopRGE) Then 
betahd12 = 0

 
Dhd1 = oo16pi2*( betahd11 + oo16pi2 * betahd12 ) 

 
Else 
Dhd1 = oo16pi2* betahd11 
End If 
 
 
Call Chop(Dhd1) 

!-------------------- 
! hdtp11 
!-------------------- 
 
betahdtp111  = 0

 
 
If (TwoLoopRGE) Then 
betahdtp112 = 0

 
Dhdtp11 = oo16pi2*( betahdtp111 + oo16pi2 * betahdtp112 ) 

 
Else 
Dhdtp11 = oo16pi2* betahdtp111 
End If 
 
 
Call Chop(Dhdtp11) 

!-------------------- 
! hdt1 
!-------------------- 
 
betahdt11  = 0

 
 
If (TwoLoopRGE) Then 
betahdt12 = 0

 
Dhdt1 = oo16pi2*( betahdt11 + oo16pi2 * betahdt12 ) 

 
Else 
Dhdt1 = oo16pi2* betahdt11 
End If 
 
 
Call Chop(Dhdt1) 

!-------------------- 
! hup11 
!-------------------- 
 
betahup111  = 0

 
 
If (TwoLoopRGE) Then 
betahup112 = 0

 
Dhup11 = oo16pi2*( betahup111 + oo16pi2 * betahup112 ) 

 
Else 
Dhup11 = oo16pi2* betahup111 
End If 
 
 
Call Chop(Dhup11) 

!-------------------- 
! hUp1 
!-------------------- 
 
betahUp11  = 0

 
 
If (TwoLoopRGE) Then 
betahUp12 = 0

 
DhUp1 = oo16pi2*( betahUp11 + oo16pi2 * betahUp12 ) 

 
Else 
DhUp1 = oo16pi2* betahUp11 
End If 
 
 
Call Chop(DhUp1) 

!-------------------- 
! hdp1 
!-------------------- 
 
betahdp11  = 0

 
 
If (TwoLoopRGE) Then 
betahdp12 = 0

 
Dhdp1 = oo16pi2*( betahdp11 + oo16pi2 * betahdp12 ) 

 
Else 
Dhdp1 = oo16pi2* betahdp11 
End If 
 
 
Call Chop(Dhdp1) 

!-------------------- 
! hd2 
!-------------------- 
 
betahd21  = 0

 
 
If (TwoLoopRGE) Then 
betahd22 = 0

 
Dhd2 = oo16pi2*( betahd21 + oo16pi2 * betahd22 ) 

 
Else 
Dhd2 = oo16pi2* betahd21 
End If 
 
 
Call Chop(Dhd2) 

!-------------------- 
! hdtp1 
!-------------------- 
 
betahdtp11  = 0

 
 
If (TwoLoopRGE) Then 
betahdtp12 = 0

 
Dhdtp1 = oo16pi2*( betahdtp11 + oo16pi2 * betahdtp12 ) 

 
Else 
Dhdtp1 = oo16pi2* betahdtp11 
End If 
 
 
Call Chop(Dhdtp1) 

!-------------------- 
! hdt2 
!-------------------- 
 
betahdt21  = 0

 
 
If (TwoLoopRGE) Then 
betahdt22 = 0

 
Dhdt2 = oo16pi2*( betahdt21 + oo16pi2 * betahdt22 ) 

 
Else 
Dhdt2 = oo16pi2* betahdt21 
End If 
 
 
Call Chop(Dhdt2) 

!-------------------- 
! hup21 
!-------------------- 
 
betahup211  = 0

 
 
If (TwoLoopRGE) Then 
betahup212 = 0

 
Dhup21 = oo16pi2*( betahup211 + oo16pi2 * betahup212 ) 

 
Else 
Dhup21 = oo16pi2* betahup211 
End If 
 
 
Call Chop(Dhup21) 

!-------------------- 
! hUp2 
!-------------------- 
 
betahUp21  = 0

 
 
If (TwoLoopRGE) Then 
betahUp22 = 0

 
DhUp2 = oo16pi2*( betahUp21 + oo16pi2 * betahUp22 ) 

 
Else 
DhUp2 = oo16pi2* betahUp21 
End If 
 
 
Call Chop(DhUp2) 

!-------------------- 
! hd3 
!-------------------- 
 
betahd31  = 0

 
 
If (TwoLoopRGE) Then 
betahd32 = 0

 
Dhd3 = oo16pi2*( betahd31 + oo16pi2 * betahd32 ) 

 
Else 
Dhd3 = oo16pi2* betahd31 
End If 
 
 
Call Chop(Dhd3) 

!-------------------- 
! hdt3 
!-------------------- 
 
betahdt31  = 0

 
 
If (TwoLoopRGE) Then 
betahdt32 = 0

 
Dhdt3 = oo16pi2*( betahdt31 + oo16pi2 * betahdt32 ) 

 
Else 
Dhdt3 = oo16pi2* betahdt31 
End If 
 
 
Call Chop(Dhdt3) 

!-------------------- 
! hu11 
!-------------------- 
 
betahu111  = 0

 
 
If (TwoLoopRGE) Then 
betahu112 = 0

 
Dhu11 = oo16pi2*( betahu111 + oo16pi2 * betahu112 ) 

 
Else 
Dhu11 = oo16pi2* betahu111 
End If 
 
 
Call Chop(Dhu11) 

!-------------------- 
! h12 
!-------------------- 
 
betah121  = 0

 
 
If (TwoLoopRGE) Then 
betah122 = 0

 
Dh12 = oo16pi2*( betah121 + oo16pi2 * betah122 ) 

 
Else 
Dh12 = oo16pi2* betah121 
End If 
 
 
Call Chop(Dh12) 

!-------------------- 
! hU1 
!-------------------- 
 
betahU11  = 0

 
 
If (TwoLoopRGE) Then 
betahU12 = 0

 
DhU1 = oo16pi2*( betahU11 + oo16pi2 * betahU12 ) 

 
Else 
DhU1 = oo16pi2* betahU11 
End If 
 
 
Call Chop(DhU1) 

!-------------------- 
! hU2 
!-------------------- 
 
betahU21  = 0

 
 
If (TwoLoopRGE) Then 
betahU22 = 0

 
DhU2 = oo16pi2*( betahU21 + oo16pi2 * betahU22 ) 

 
Else 
DhU2 = oo16pi2* betahU21 
End If 
 
 
Call Chop(DhU2) 

!-------------------- 
! ftri 
!-------------------- 
 
betaftri1  = 0

 
 
If (TwoLoopRGE) Then 
betaftri2 = 0

 
Dftri = oo16pi2*( betaftri1 + oo16pi2 * betaftri2 ) 

 
Else 
Dftri = oo16pi2* betaftri1 
End If 
 
 
!-------------------- 
! mu12 
!-------------------- 
 
betamu121  = 0

 
 
If (TwoLoopRGE) Then 
betamu122 = 0

 
Dmu12 = oo16pi2*( betamu121 + oo16pi2 * betamu122 ) 

 
Else 
Dmu12 = oo16pi2* betamu121 
End If 
 
 
!-------------------- 
! mu22 
!-------------------- 
 
betamu221  = 0

 
 
If (TwoLoopRGE) Then 
betamu222 = 0

 
Dmu22 = oo16pi2*( betamu221 + oo16pi2 * betamu222 ) 

 
Else 
Dmu22 = oo16pi2* betamu221 
End If 
 
 
!-------------------- 
! mu32 
!-------------------- 
 
betamu321  = 0

 
 
If (TwoLoopRGE) Then 
betamu322 = 0

 
Dmu32 = oo16pi2*( betamu321 + oo16pi2 * betamu322 ) 

 
Else 
Dmu32 = oo16pi2* betamu321 
End If 
 
 
!-------------------- 
! Vn 
!-------------------- 
 
betaVn1  = 0

 
 
If (TwoLoopRGE) Then 
betaVn2 = 0

 
DVn = oo16pi2*( betaVn1 + oo16pi2 * betaVn2 ) 

 
Else 
DVn = oo16pi2* betaVn1 
End If 
 
 
!-------------------- 
! v1 
!-------------------- 
 
betav11  = 0

 
 
If (TwoLoopRGE) Then 
betav12 = 0

 
Dv1 = oo16pi2*( betav11 + oo16pi2 * betav12 ) 

 
Else 
Dv1 = oo16pi2* betav11 
End If 
 
 
!-------------------- 
! v2 
!-------------------- 
 
betav21  = 0

 
 
If (TwoLoopRGE) Then 
betav22 = 0

 
Dv2 = oo16pi2*( betav21 + oo16pi2 * betav22 ) 

 
Else 
Dv2 = oo16pi2* betav21 
End If 
 
 
Call ParametersToG128(Dg1,Dg2,Dg3,Dl1,Dl12,Dl13,Dl12t,Dl13t,Dl2,Dl23,Dl23t,           & 
& Dl3,Dhll1,Dhdp11,Dhd1,Dhdtp11,Dhdt1,Dhup11,DhUp1,Dhdp1,Dhd2,Dhdtp1,Dhdt2,              & 
& Dhup21,DhUp2,Dhd3,Dhdt3,Dhu11,Dh12,DhU1,DhU2,Dftri,Dmu12,Dmu22,Dmu32,DVn,              & 
& Dv1,Dv2,f)

Iname = Iname - 1 
 
End Subroutine rge128  

End Module RGEs_331v3 
 
