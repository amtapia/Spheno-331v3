! -----------------------------------------------------------------------------  
! This file was automatically created by SARAH version 4.14.3 
! SARAH References: arXiv:0806.0538, 0909.2863, 1002.0840, 1207.0906, 1309.7223  
! (c) Florian Staub, 2013  
! ------------------------------------------------------------------------------  
! File created at 16:50 on 3.7.2020   
! ----------------------------------------------------------------------  
 
 
Module Tadpoles_331v3 
 
Use Model_Data_331v3 
Use TreeLevelMasses_331v3 
Use RGEs_331v3 
Use Control 
Use Settings 
Use Mathematics 

Contains 


Subroutine SolveTadpoleEquations(g1,g2,g3,l1,l12,l13,l12t,l13t,l2,l23,l23t,           & 
& l3,hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,hUp2,               & 
& hd3,hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,Vn,v1,v2,Tad1Loop)

Implicit None
Real(dp),Intent(inout) :: g1,g2,g3,ftri,mu12,mu22,mu32,Vn,v1,v2

Complex(dp),Intent(inout) :: l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,hll1(3,3),hdp11(3),hd1(3),hdtp11(2),              & 
& hdt1(2),hup11(3),hUp1,hdp1(3),hd2(3),hdtp1(2),hdt2(2),hup21(3),hUp2,hd3(3),            & 
& hdt3(2),hu11(3),h12(3),hU1,hU2

Complex(dp), Intent(in) :: Tad1Loop(3)

! For numerical routines 
Real(dp) :: gC(128)
logical :: broycheck 
Real(dp) :: broyx(3)

If (HighScaleModel.Eq."LOW") Then 
mu12 = l1*Vn**2 + l12*v1**2 - (ftri*v1*v2)/(sqrt(2._dp)*Vn) + l13*v2**2 + Tad1Loop(1)/(sqrt(2._dp)*Vn)
mu22 = -(2*l12*Vn**2*v1 + 2*l2*v1**3 - sqrt(2._dp)*ftri*Vn*v2 + 2*l23*v1*v2**2 +             & 
&  sqrt(2._dp)*Tad1Loop(2))/(2._dp*v1)
mu32 = -(-3*sqrt(2._dp)*ftri*Vn*v1 + 6*l13*Vn**2*v2 + 6*l23*v1**2*v2 + 4*l3*v2**3 +          & 
&  3*sqrt(2._dp)*Tad1Loop(3))/(6._dp*v2)

 ! ----------- Check solutions for consistency  -------- 

 ! Check for NaNs 
If (mu12.ne.mu12) Then 
   Write(*,*) "NaN appearing in solution of tadpole equations for mu12" 
   Call TerminateProgram  
 End If 
 If (mu22.ne.mu22) Then 
   Write(*,*) "NaN appearing in solution of tadpole equations for mu22" 
   Call TerminateProgram  
 End If 
 If (mu32.ne.mu32) Then 
   Write(*,*) "NaN appearing in solution of tadpole equations for mu32" 
   Call TerminateProgram  
 End If 
 Else 
mu12 = l1*Vn**2 + l12*v1**2 - (ftri*v1*v2)/(sqrt(2._dp)*Vn) + l13*v2**2 + Tad1Loop(1)/(sqrt(2._dp)*Vn)
mu22 = -(2*l12*Vn**2*v1 + 2*l2*v1**3 - sqrt(2._dp)*ftri*Vn*v2 + 2*l23*v1*v2**2 +             & 
&  sqrt(2._dp)*Tad1Loop(2))/(2._dp*v1)
mu32 = -(-3*sqrt(2._dp)*ftri*Vn*v1 + 6*l13*Vn**2*v2 + 6*l23*v1**2*v2 + 4*l3*v2**3 +          & 
&  3*sqrt(2._dp)*Tad1Loop(3))/(6._dp*v2)

 ! ----------- Check solutions for consistency  -------- 

 ! Check for NaNs 
If (mu12.ne.mu12) Then 
   Write(*,*) "NaN appearing in solution of tadpole equations for mu12" 
   Call TerminateProgram  
 End If 
 If (mu22.ne.mu22) Then 
   Write(*,*) "NaN appearing in solution of tadpole equations for mu22" 
   Call TerminateProgram  
 End If 
 If (mu32.ne.mu32) Then 
   Write(*,*) "NaN appearing in solution of tadpole equations for mu32" 
   Call TerminateProgram  
 End If 
 End if 
End Subroutine SolveTadpoleEquations

Subroutine CalculateTadpoles(g1,g2,g3,l1,l12,l13,l12t,l13t,l2,l23,l23t,               & 
& l3,hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,hUp2,               & 
& hd3,hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,Vn,v1,v2,Tad1Loop,TadpoleValues)

Real(dp),Intent(in) :: g1,g2,g3,ftri,mu12,mu22,mu32,Vn,v1,v2

Complex(dp),Intent(in) :: l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,hll1(3,3),hdp11(3),hd1(3),hdtp11(2),              & 
& hdt1(2),hup11(3),hUp1,hdp1(3),hd2(3),hdtp1(2),hdt2(2),hup21(3),hUp2,hd3(3),            & 
& hdt3(2),hu11(3),h12(3),hU1,hU2

Complex(dp), Intent(in) :: Tad1Loop(3)

Real(dp), Intent(out) :: TadpoleValues(3)

TadpoleValues(1) = Real(-(sqrt(2._dp)*l1*Vn**3) + ftri*v1*v2 + sqrt(2._dp)            & 
& *Vn*(mu12 - l12*v1**2 - l13*v2**2) - Tad1Loop(1),dp) 
TadpoleValues(2) = Real(-(sqrt(2._dp)*l2*v1**3) + ftri*Vn*v2 - sqrt(2._dp)            & 
& *v1*(mu22 + l12*Vn**2 + l23*v2**2) - Tad1Loop(2),dp) 
TadpoleValues(3) = Real(ftri*Vn*v1 - sqrt(2._dp)*l13*Vn**2*v2 - (sqrt(2._dp)          & 
& *v2*(3._dp*(mu32) + 3*l23*v1**2 + 2*l3*v2**2))/3._dp - Tad1Loop(3),dp) 
End Subroutine CalculateTadpoles 

End Module Tadpoles_331v3 
 
