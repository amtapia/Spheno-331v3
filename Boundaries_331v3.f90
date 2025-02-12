! -----------------------------------------------------------------------------  
! This file was automatically created by SARAH version 4.14.3 
! SARAH References: arXiv:0806.0538, 0909.2863, 1002.0840, 1207.0906, 1309.7223  
! (c) Florian Staub, 2013  
! ------------------------------------------------------------------------------  
! File created at 16:44 on 3.7.2020   
! ----------------------------------------------------------------------  
 
 
Module Boundaries_331v3 
 
Use Control 
Use Settings 
Use LoopCouplings_331v3 
Use LoopMasses_331v3 
Use LoopFunctions 
Use Mathematics 
Use Model_Data_331v3 
Use RGEs_331v3 
Use RunSM_331v3 
 
Use Tadpoles_331v3 
Use RGEs_SM_HC 
Use LoopMasses_SM_HC 
Use CouplingsForDecays_331v3 
Use StandardModel 
 

 
Integer, save :: YukScen 
Real(dp), save :: Lambda, MlambdaS,F_GMSB 
Real(dp),save::mGUT_save,sinW2_Q_mZ&
&, mf_l_Q_SM(3),mf_d_Q_SM(3),mf_u_Q_SM(3) & 
&, mf_l_MS_SM(3),mf_d_MS_SM(3),mf_u_MS_SM(3) 
Complex(dp),save::Yl_mZ(3,3),Yu_mZ(3,3),Yd_mZ(3,3),Yl_Q(3,3),Yu_Q(3,3),Yd_Q(3,3)
Real(dp),Save::vevs_DR_save(2), vSM_save
Contains 
 
Subroutine BoundarySM(i_run,Lambda_SM,delta0,g_SM,kont)

Implicit None 
Real(dp), Intent(out)::g_SM(62)
Integer, Intent(in) :: i_run 
Real(dp) :: mHiggs 
Real(dp), Intent(in) :: delta0 
Integer, Intent(inout) :: kont 
Integer :: i1,i2,i3,i4 
Real(dp)::mW2_run,mZ2_run,test, D_mat(3,3)
Real(dp)::alphaMZ,alpha3,gSU2,rho,delta_rho,delta_rho0,sinW2_Q,vev2&
&,vevs_Q(2),mZ2_mZ,CosW2SinW2,gauge(3),delta,sinW2_old,delta_r&
&,p2,gSU3,tanb,xt2,fac(2),SigQCD,delta_rw,sinW2,cosW2,cosW
Real(dp),Dimension(3)::mf_d_Q,mf_l_Q,mf_u_Q
Real(dp) :: g1SM, g2SM, g3SM, vSM 
Complex(dp) :: dmZ2,dmW2,dmW2_0,yuk_tau,yuk_t,yuk_b
Complex(dp) ::uU_L(3,3),uU_R(3,3),uD_L(3,3),uD_R(3,3), NoMatrix(3,3) &
&,uL_L(3,3),uL_R(3,3)
Complex(dp) ::uU_L_T(3,3),uU_R_T(3,3),uD_L_T(3,3),uD_R_T(3,3),uL_L_T(3,3),uL_R_T(3,3)
Complex(dp) :: SigSR_u(3,3),SigSL_u(3,3),sigR_u(3,3),SigL_u(3,3)
Complex(dp) :: SigSR_d(3,3),SigSL_d(3,3),SigR_d(3,3),SigL_d(3,3)
Complex(dp) :: SigSR_l(3,3),SigSL_l(3,3),sigR_l(3,3),SigL_l(3,3)
Complex(dp) :: YuSM(3,3),YdSM(3,3),YeSM(3,3), MuSM, adCKM(3,3),Y_l_old(3,3),Y_d_old(3,3),Y_u_old(3,3) 
Complex(dp), Intent(in) :: Lambda_SM 
Logical::converge
Integer :: i_loop, i_loop_max 
Real(dp),Parameter::&
& as2loop=1._dp/24._dp+2011._dp*oo32Pi2/12._dp&
&+Log2/12._dp-oo8Pi2*Zeta3&
&,log2loop_a=123._dp*oo32Pi2,log2loop_b=33._dp*oo32Pi2
Real(dp) :: Q2, logQ 


Real(dp) :: VEVSM1,VEVSM2,VEVSM1MZ,VEVSM2MZ 
Complex(dp) ::MassFu(3,3),MassFd(3,3),MassFe(3,3) 
Iname=Iname+1
NameOfUnit(Iname)='BoundarySM'
sinW2 = 1 - mW**2/mZ**2 
test = SetRenormalizationScale(mZ2) 
!-----------------
!sin(theta_W)^2
!-----------------
If (i_run.Eq.1) Then
   vSM = 246._dp 
   sinW2_Q=sinW2
   sinW2_old=sinW2_Q
   Y_l=0._dp
   Do i1=1,3
       y_l(i1,i1)=sqrt2*mf_l_mZ(i1)/vevSM(1)
       yl_MZ(i1,i1)=sqrt2*mf_l_mZ(i1)/vSM 
       yd_MZ(i1,i1)=sqrt2*mf_d_mZ(i1)/vSM 
       yu_MZ(i1,i1)=sqrt2*mf_u_mZ(i1)/vSM 
   End Do
   mf_l2=mf_l_mZ**2
   mf_d2=mf_d_mZ**2
   mf_u2=mf_u_mZ**2
Else
   vSM = vSM_save 
   sinW2_Q=sinW2_Q_mZ
   sinW2_old=sinW2_Q
   Y_l=Yl_mZ
   Call FermionMass(Yd_mZ,vSM,mf_d2,uD_L_T,uD_R_T,kont)
   Call FermionMass(Yl_mZ,vSM,mf_l2,uL_L_T,uL_R_T,kont)
   Call FermionMass(Yu_mZ,vSM,mf_u2,uU_L_T,uU_R_T,kont)
   mf_l2=mf_l2**2
   mf_d2=mf_d2**2
   mf_u2=mf_u2**2
End If
mHiggs= sqrt(Lambda_SM)*vSM 
MuSM = 0.5_dp*Lambda_SM*vSM**2 
alphaMZ = AlphaEW_MS_SM(mZ,mf_d,mf_u,mf_l) 
 
alpha3 = AlphaS_MS_SM(mZ,mf_d,mf_u) 
If (.not.OneLoopMatching) alpha3= AlphaS_mZ 
If (.not.OneLoopMatching) alphaMZ = Alpha_MZ_MS 
gSU3 = Sqrt(4._dp*pi*alpha3) 
g3SM = Sqrt(4._dp*pi*alpha3) 
!--------------------
!for 2-loop parts
!--------------------
xt2=3._dp*(G_F*mf_u(3)**2*oo8pi2*oosqrt2)**2&
    &*rho_2(mHiggs/mf_u(3)) 
fac(1)=alphaMZ*alphaS_mZ*oo4pi&
      &*(2.145_dp*mf_u(3)**2/mZ2+0.575*Log(mf_u(3)/mZ)-0.224_dp&
      &-0.144_dp*mZ2/mf_u(3)**2)/Pi
fac(2)=alphamZ*alphaS_mZ*oo4pi&
      &*(-2.145_dp*mf_u(3)**2/mW2+1.262*Log(mf_u(3)/mZ)-2.24_dp&
      &-0.85_dp*mZ2/mf_u(3)**2)/Pi
Do i1=1,100 
gSU2 = Sqrt( 4._dp*pi*alphamZ/sinW2_Q) 
g1SM =gSU2*Sqrt(sinW2_Q/(1._dp-sinW2_Q)) 
g2SM =gSU2 
YeSM=Yl_MZ
YdSM=Yd_MZ
YuSM=Yu_MZ
TW= Asin(Sqrt(sinw2_Q)) 
mHiggs= sqrt(Lambda_SM)*vSM 
MuSM = 0.5_dp*Lambda_SM*vSM**2 
Yu_MZ(3,3)=mf_u(3)/vSM*Sqrt(2._dp) 
YuSM=Yu_MZ 
Call OneLoop_Z_W_SM(vSM,g1SM,g2SM,g3SM,Lambda_SM,-YuSM,YdSM,YeSM,kont,dmZ2,           & 
& dmW2,dmW2_0)

If (.not.OneLoopMatching) dmZ2= 0._dp 
If (.not.OneLoopMatching) dmW2= 0._dp 
If (.not.OneLoopMatching) dmW2_0= 0._dp 
mZ2_mZ = Real(dmZ2 + mZ2,dp) 
If (mZ2_mZ.Lt.0._dp) Then
    Iname=Iname-1
    kont=-402
    Call AddError(402)
    Write(*,*) " MZ  getting negative at EW scale" 
    Call TerminateProgram
End If

mZ2_run=mZ2_mZ
mW2_run=mZ2_mZ*(1._dp-sinW2_Q) +0  
CosW2SinW2=(1._dp-sinW2_Q)*sinW2_Q
vev2=mZ2_mZ*CosW2SinW2/(pi*alphamZ) -(0) 
vSM=Sqrt(vev2)
MuSM = 0.5_dp*Lambda_SM*vSM**2 
Yu_MZ(3,3)=mf_u(3)/vSM*Sqrt(2._dp) 
YuSM=Yu_MZ 
Call OneLoop_Z_W_SM(vSM,g1SM,g2SM,g3SM,Lambda_SM,-YuSM,YdSM,YeSM,kont,dmZ2,           & 
& dmW2,dmW2_0)

If (.not.OneLoopMatching) dmZ2= 0._dp 
If (.not.OneLoopMatching) dmW2= 0._dp 
If (.not.OneLoopMatching) dmW2_0= 0._dp 
mZ2_mZ = Real(dmZ2 + mZ2,dp) 
If (mZ2_mZ.Lt.0._dp) Then
    Iname=Iname-1
    kont=-402
    Call AddError(402)
    Write(*,*) " MZ  getting negative at EW scale" 
    Call TerminateProgram
End If

mZ2_run=mZ2_mZ
mW2_run=mZ2_mZ*(1._dp-sinW2_Q)  
CosW2SinW2=(1._dp-sinW2_Q)*sinW2_Q
vev2=mZ2_mZ *CosW2SinW2/(pi*alphamZ) 
vSM=sqrt(vev2) 
mHiggs= sqrt(Lambda_SM)*vSM 
MuSM = 0.5_dp*Lambda_SM*vSM**2 
Yu_MZ(3,3)=mf_u(3)/vSM*Sqrt(2._dp) 
YuSM=Yu_MZ 
Call OneLoop_Z_W_SM(vSM,g1SM,g2SM,g3SM,Lambda_SM,-YuSM,YdSM,YeSM,kont,dmZ2,           & 
& dmW2,dmW2_0)

If (.not.OneLoopMatching) dmZ2= 0._dp 
If (.not.OneLoopMatching) dmW2= 0._dp 
If (.not.OneLoopMatching) dmW2_0= 0._dp 
rho=(1._dp+Real(dmZ2,dp)/mZ2)/(1._dp+Real(dmW2,dp)/mW2)  
delta_rho=1._dp-1._dp/rho
rho=1._dp/(1._dp-delta_rho)
CosW2SinW2=(1._dp-sinW2_Q)*sinW2_Q
If (IncludeDeltaVB) Then 
Call DeltaVB_SM(sinW2,sinW2_Q,g2SM,rho,delta)

Else 
delta = 0._dp 
End if 
If (.not.OneLoopMatching) delta= 0._dp 
delta_rho0=0._dp
delta_r=rho*Real(dmW2_0,dp)/mW2-Real(dmZ2,dp)/mZ2+delta
rho=1._dp/(1._dp-delta_rho-delta_rho0-fac(2)/sinW2_Q-xt2)
delta_r=rho*Real(dmW2_0,dp)/mW2-Real(dmZ2,dp)/mZ2+delta&
        &+fac(1)/CosW2SinW2-xt2*(1-delta_r)*rho
CosW2SinW2=pi*alphamZ/(sqrt2*mZ2*G_F*(1-delta_r))
sinW2_Q=0.5_dp-Sqrt(0.25_dp-CosW2SinW2)

If (sinW2_Q.Lt.0._dp) Then
    kont=-403
    Call AddError(403)
    Iname=Iname-1
    Write(*,*) " sinW2 getting negtive at EW scale " 
    Call TerminateProgram
End If
 
If (Abs(sinW2_Q-sinW2_old).Lt.0.1_dp*delta0) Exit

sinW2_old=sinW2_Q
delta_rw=(delta_rho+fac(2)/sinW2_Q+xt2)*(1._dp-delta_r)+delta_r
If ((0.25_dp-alphamz*pi/(sqrt2*G_F*mz2*rho*(1._dp-delta_rw))).Lt.0._dp) Then
    kont=-404
    Call AddError(404)
    Iname=Iname-1
     Return
End If

mW2=mZ2*rho*(0.5_dp&
    &+Sqrt(0.25_dp-alphamz*pi/(sqrt2*G_F*mz2*rho*(1._dp-delta_rw))))
cosW2=mW2/mZ2
cosW=Sqrt(cosW2)
sinW2=1._dp-cosW2
End Do

delta_rw=(delta_rho+fac(2)/sinW2_Q+xt2)*(1._dp-delta_r)+delta_r
mW2=mZ2*rho*(0.5_dp& 
   &+Sqrt(0.25_dp-alphamz*pi/(sqrt2*G_F*mz2*rho*(1._dp-delta_rw))))
mW=Sqrt(mW2)
cosW2=mW2/mZ2
cosW=Sqrt(cosW2)
sinW2=1._dp-cosW2
g1SM=Sqrt(4._dp*pi*alphamZ/(1._dp-sinW2_Q))
g2SM=Sqrt(4._dp*pi*alphamZ/sinW2_Q)
g3SM=Sqrt(4._dp*pi*alpha3)
vev2=mZ2_mZ*CosW2SinW2/(pi*alphamZ)  
vSM=sqrt(vev2) 


! -------------------------
!  Calculate Yukawas
! -------------------------
uU_L=id3C
uU_R=id3C
uD_L=id3C
uD_R=id3C
uL_L=id3C
uL_R=id3C
If (GenerationMixing) Then
    Call Adjungate(CKM,adCKM)
 If (YukawaScheme.Eq.1) Then
    uU_L(1:3,1:3)=CKM
 Else
    uD_L(1:3,1:3)=adCKM
 End If
End If
If (i_run.Eq.1) Then
  mf_l_MS_SM=mf_l_MZ
  mf_d_MS_SM=mf_d_MZ
  mf_u_MS_SM=mf_u_MZ
  mf_l_Q=mf_l_MS_SM
  mf_d_Q=mf_d_MS_SM
  mf_u_Q=mf_u_MS_SM
  YdSM=0._dp
  YuSM=0._dp
  YeSM=0._dp
Do i1=1,3
    YuSM(i1,i1)=sqrt2*mf_u_MS_SM(i1)/vSM
    YeSM(i1,i1)=sqrt2*mf_l_MS_SM(i1)/vSM
    YdSM(i1,i1)=sqrt2*mf_d_MS_SM(i1)/vSM
End Do
If (GenerationMixing) Then
  If (YukawaScheme.Eq.1) Then
    YuSM=Matmul(Transpose(uU_L(1:3,1:3)),YuSM)
  Else
    YdSM=Matmul(Transpose(uD_L(1:3,1:3)),YdSM)
  End If
End If
Else
YeSM=Yl_MZ
YdSM=Yd_MZ
YuSM=Yu_MZ
End If! i_run.eq.1

converge= .False.
Y_l_old=YeSM
Y_d_old=YdSM
Y_u_old=YuSM


! -------------------------
!  Main Loop
! -------------------------
if (FermionMassResummation) then
  i_loop_max=100! this should be sufficient
else
  i_loop_max=1
end if
Do i_loop=1,i_loop_max
p2=0._dp! for off-diagonal elements


! Full one-loop corrections
Call OneLoop_d_u_e_SM(vSM,g1SM,g2SM,g3SM,Lambda_SM,-YuSM,YdSM,YeSM,sigR_d,            & 
& sigL_d,sigSR_d,sigSL_d,sigR_u,sigL_u,sigSR_u,sigSL_u,sigR_l,sigL_l,sigSR_l,            & 
& sigSL_l,kont)

If (.not.OneLoopMatching) Then 
sigR_l = 0._dp 
sigL_l = 0._dp 
sigSR_l = 0._dp 
sigSL_l = 0._dp 
sigR_d = 0._dp 
sigL_d = 0._dp 
sigSR_d = 0._dp 
sigSL_d = 0._dp 
sigR_u = 0._dp 
sigL_u = 0._dp 
sigSR_u = 0._dp 
sigSL_u = 0._dp 
End if


! SM two-loop corrections
! Two-loop Non-SUSY from hep-ph/9803493
Q2=GetRenormalizationScale()
logQ=Log(Q2/MFu(3)**2)
If (OneLoopMatching) Then 
SigQCD=-4._dp/3._dp*gSU3**2*MFu(3)*(4._dp+3._dp*LogQ) &
&-MFu(3)*(-2._dp/3._dp*gSU2)**2*sinW2_Q*(4+3._dp*LogQ)
Else  
SigQCD=0._dp 
End if 
If (TwoLoopMatching) Then 
SigQCD=-4._dp/3._dp*gSU3**2*MFu(3)*(4._dp+3._dp*LogQ) &
& -oo16pi2*MFu(3)*((2821._dp + 2028._dp*LogQ + 396._dp*LogQ**2 + 16._dp*Pi**2*(1._dp + 2._dp*log2) - 48._dp*Zeta3)*gSU3**4/18._dp) &
&-MFu(3)*(-2._dp/3._dp*gSU2)**2*sinW2_Q*(4+3._dp*LogQ)
End if 
SigQCD=oo16pi2*SigQCD

mf_u_MS_SM(3)=mf_u(3)+SigQCD



! Obtain Yukawas
Call Yukawas(mf_u_MS_SM,vSM,uU_L,uU_R,SigSL_u,SigL_u,SigR_u&
      &,YuSM, FermionMassResummation,kont) 
If (kont.Ne.0) Then 
    Iname=Iname-1
    Write(*,*) " Fit of Yukawa couplings at EW scale failed" 
    Call TerminateProgram
End If
Call Yukawas(mf_d_MS_SM,vSM,uD_L,uD_R,SigSL_d,SigL_d,SigR_d& 
      &,YdSM,FermionMassResummation,kont)
If (kont.Ne.0) Then
    Iname=Iname-1
    Write(*,*) " Fit of Yukawa couplings at EW scale failed" 
    Call TerminateProgram
End If 
Call Yukawas(mf_l_MS_SM,vSM,uL_L,uL_R,SigSL_l,SigL_l,SigR_l&
     &,YeSM,.False.,kont) 
If (kont.Ne.0) Then
    Iname=Iname-1
    Write(*,*) " Fit of Yukawa couplings at EW scale failed" 
    Call TerminateProgram
End If
Call FermionMass(YdSM,vSM,mf_d_Q,uD_L_T,uD_R_T,kont) 
Call FermionMass(YeSM,vSM,mf_l_Q,uL_L_T,uL_R_T,kont)
Call FermionMass(YuSM,vSM,mf_u_Q,uU_L_T,uU_R_T,kont)


! Check convergence 
converge= .True. 
D_mat=Abs(Abs(YeSM)-Abs(Y_l_old))
Where (Abs(YeSM).Ne.0._dp) D_mat=D_mat/Abs(YeSM)
Do i1=1,3
 If (D_mat(i1,i1).Gt.0.1_dp*delta0) converge= .False. 
  Do i2=i1+1,3 
   If (D_mat(i1,i2).Gt.delta0) converge= .False. 
   If (D_mat(i2,i1).Gt.delta0) converge= .False. 
 End Do 
End Do 
D_mat=Abs(Abs(YdSM)-Abs(Y_d_old))
Where (Abs(YdSM).Ne.0._dp) D_mat=D_mat/Abs(YdSM)
Do i1=1,3 
 If (D_mat(i1,i1).Gt.0.1_dp*delta0) converge= .False. 
   Do i2=i1+1,3 
    If (D_mat(i1,i2).Gt.10._dp*delta0) converge= .False. 
    If (D_mat(i2,i1).Gt.10._dp*delta0) converge= .False. 
   End Do 
End Do 
D_mat=Abs(Abs(YuSM)-Abs(Y_u_old))
Where (Abs(YuSM).Ne.0._dp) D_mat=D_mat/Abs(YuSM)
Do i1=1,3
 If (D_mat(i1,i1).Gt.0.1_dp*delta0) converge= .False. 
  Do i2=i1+1,3 
   If (D_mat(i1,i2).Gt.10._dp*delta0) converge= .False. 
   If (D_mat(i2,i1).Gt.10._dp*delta0) converge= .False. 
  End Do 
End Do
If (converge) Exit
  Y_l_old=YeSM
  Y_u_old=YuSM
  Y_d_old=YdSM
!-------------------------------------------------- 
!Either we have run into a numerical problem or 
!perturbation theory breaks down 
!-------------------------------------------------- 
If ((Minval(Abs(mf_l_Q/mf_l)).Lt.0.1_dp)&
&.Or.(Maxval(Abs(mf_l_Q/mf_l)).Gt.10._dp)) Then
Iname=Iname-1
kont=-405
Call AddError(405)
    Write(*,*) " Loop corrections to Yukawa couplings at EW scale too large!" 
    Call TerminateProgram
Else If ((Minval(Abs(mf_d_Q/mf_d)).Lt.0.1_dp)&
&.Or.(Minval(Abs(mf_d_Q/mf_d)).Gt.10._dp)) Then
Iname=Iname-1
kont=-406
Call AddError(406)
    Write(*,*) " Loop corrections to Yukawa couplings at EW scale too large!" 
    Call TerminateProgram
Else If ((Minval(Abs(mf_u_Q/mf_u)).Lt.0.1_dp)&
&.Or.(Minval(Abs(mf_u_Q/mf_u)).Gt.10._dp)) Then
Iname=Iname-1
kont=-407
Call AddError(407)
    Write(*,*) " Loop corrections to Yukawa couplings at EW scale too large!" 
    Call TerminateProgram
End If
End Do! i_loop
If ((.Not.converge).and.FermionMassResummation) Then
Write (ErrCan,*)'Problem in subroutine BoundaryEW!!'
Write (ErrCan,*) "After-1 + (i_loop)iterations no convergence of Yukawas"
End If
Yl_MZ=YeSM
Yd_MZ=YdSM
Yu_MZ=YuSM
sinW2_Q_mZ=sinW2_Q
vSM_save=vSM
gauge_mZ=gauge
Call ParametersToG62_SM(g1SM,g2SM,g3SM,Lambda_SM,YuSM,YdSM,YeSM,MuSM,vSM,g_SM)

test=SetRenormalizationScale(test)
Iname=Iname-1

Contains

Real(dp) Function rho_2(r)
Implicit None
Real(dp),Intent(in)::r
Real(dp)::r2,r3
r2=r*r
r3=r2*r
rho_2=19._dp-16.5_dp*r+43._dp*r2/12._dp&
&+7._dp*r3/120._dp&
&-Pi*Sqrt(r)*(4._dp-1.5_dp*r+3._dp*r2/32._dp&
&+r3/256._dp)&
&-Pi2*(2._dp-2._dp*r+0.5_dp*r2)&
&-Log(r)*(3._dp*r-0.5_dp*r2)
End Function rho_2


Subroutine Yukawas(mf,vev,uL,uR,SigS,SigL,SigR,Y,ReSum,kont)
Implicit None
Integer,Intent(inout)::kont
Real(dp),Intent(in)::mf(3),vev
Complex(dp),Dimension(3,3),Intent(in)::uL,uR,SigS,SigL,SigR
Logical,Intent(in)::ReSum
Complex(dp),Intent(inout)::Y(3,3)
Integer::i1
Complex(dp),Dimension(3,3)::mass,uLa,uRa,f,invf,invY
Call Adjungate(uL,uLa)
Call Adjungate(uR,uRa)
mass=ZeroC
Do i1=1,3
mass(i1,i1)=mf(i1)
End Do
mass=Matmul(Transpose(uL),Matmul(mass,uR))
Y=Y*vev*oosqrt2
If (ReSum) Then
kont=0
Call chop(Y)
invY=Y
Call gaussj(kont,invY,3,3)
If (kont.Ne.0) Return
f=id3C-Matmul(SigS,invY)-Transpose(SigL)-Matmul(Y,Matmul(SigR,invY))
invf=f
Call gaussj(kont,invf,3,3)
If (kont.Ne.0) Return
Y=Matmul(invf,mass)
Else
Y=mass+SigS+Matmul(Transpose(SigL),Y)+Matmul(Y,SigR)
End If
Y=sqrt2*Y/vev
Call chop(y)
End Subroutine Yukawas

End Subroutine BoundarySM 
 
Subroutine BoundaryBSM(i_run,g_SM,MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,MFe2,              & 
& MFu,MFu2,Mhh,Mhh2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,TW,             & 
& Ud,Ue,Uu,Vd,Ve,Vu,ZA,ZH,ZP,ZW,zy,ZZ,Vn,v1,v2,g1,g2,g3,l1,l12,l13,l12t,l13t,            & 
& l2,l23,l23t,l3,hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,              & 
& hup21,hUp2,hd3,hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,delta0,gMZ,kont)

Implicit None 
Real(dp),Intent(out)::gMZ(:) 
Real(dp),Intent(in) :: g_SM(62) 
Real(dp),Intent(inout) :: g1,g2,g3,ftri,mu12,mu22,mu32

Complex(dp),Intent(inout) :: l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,hll1(3,3),hdp11(3),hd1(3),hdtp11(2),              & 
& hdt1(2),hup11(3),hUp1,hdp1(3),hd2(3),hdtp1(2),hdt2(2),hup21(3),hUp2,hd3(3),            & 
& hdt3(2),hu11(3),h12(3),hU1,hU2

Real(dp),Intent(inout) :: MAh(3),MAh2(3),MDpm(2),MDpm2(2),MFd(5),MFd2(5),MFe(3),MFe2(3),MFu(4),MFu2(4),         & 
& Mhh(3),Mhh2(3),MHpm(4),MHpm2(4),MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,TW

Complex(dp),Intent(inout) :: Ud(5,5),Ue(3,3),Uu(4,4),Vd(5,5),Ve(3,3),Vu(4,4),ZA(3,3),ZH(3,3),ZP(4,4),              & 
& ZW(4,4),zy(2,2),ZZ(3,3)

Real(dp),Intent(inout) :: Vn,v1,v2

Complex(dp) :: cplAhhhVP(3,3),cplDpmcDpmVP(2,2),cplcFdFdVPL(5,5),cplcFdFdVPR(5,5),cplcFeFeVPL(3,3),  & 
& cplcFeFeVPR(3,3),cplcFuFuVPL(4,4),cplcFuFuVPR(4,4),cplcFv1Fv1VPL(3,3),cplcFv1Fv1VPR(3,3),& 
& cplcgWpgWpVP,cplcgWCgWCVP,cplcgXp1gXp1VP,cplcgXp2gXp2VP,cplhhVPVZ(3),cplhhVPVZp(3),    & 
& cplHpmcHpmVP(4,4),cplHpmVPVWp(4),cplHpmVPVXp(4),cplcVWpVPVWp,cplcVXpVPVXp,             & 
& cplAhAhVPVP(3,3),cplDpmcDpmVPVP(2,2),cplhhhhVPVP(3,3),cplHpmcHpmVPVP(4,4),             & 
& cplcVWpVPVPVWp1,cplcVWpVPVPVWp2,cplcVWpVPVPVWp3,cplcVXpVPVPVXp1,cplcVXpVPVPVXp2,       & 
& cplcVXpVPVPVXp3,cplAhhhVZ(3,3),cplDpmcDpmVZ(2,2),cplcFdFdVZL(5,5),cplcFdFdVZR(5,5),    & 
& cplcFeFeVZL(3,3),cplcFeFeVZR(3,3),cplcFuFuVZL(4,4),cplcFuFuVZR(4,4),cplcFv1Fv1VZL(3,3),& 
& cplcFv1Fv1VZR(3,3),cplcgWpgWpVZ,cplcgWCgWCVZ,cplcgXp1gXp1VZ,cplcgXp2gXp2VZ,            & 
& cplhhVZVZ(3),cplhhVZVZp(3),cplHpmcHpmVZ(4,4),cplHpmVWpVZ(4),cplHpmVXpVZ(4),            & 
& cplcVWpVWpVZ,cplcVXpVXpVZ,cplAhAhVZVZ(3,3),cplDpmcDpmVZVZ(2,2),cplhhhhVZVZ(3,3),       & 
& cplHpmcHpmVZVZ(4,4),cplcVWpVWpVZVZ1,cplcVWpVWpVZVZ2,cplcVWpVWpVZVZ3,cplcVXpVXpVZVZ1,   & 
& cplcVXpVXpVZVZ2,cplcVXpVXpVZVZ3,cplHpmVWpVZp(4),cplcVWpVWpVZp,cplcVWpVWpVZpVZp1,       & 
& cplcVWpVWpVZpVZp2,cplcVWpVWpVZpVZp3,cplAhcHpmcVWp(3,4),cplDpmcHpmcVWp(2,4),            & 
& cplDpmcVWpVXp(2),cplcFdFucVWpL(5,4),cplcFdFucVWpR(5,4),cplcFeFv1cVWpL(3,3),            & 
& cplcFeFv1cVWpR(3,3),cplcgWCgAcVWp,cplcgAgWpcVWp,cplcgZgWpcVWp,cplcgZpgWpcVWp,          & 
& cplcgWCgZcVWp,cplcgWCgZpcVWp,cplhhcHpmcVWp(3,4),cplhhcVWpVWp(3),cplcHpmcVWpVP(4),      & 
& cplcHpmcVWpVZ(4),cplcHpmcVWpVZp(4),cplAhAhcVWpVWp(3,3),cplDpmcDpmcVWpVWp(2,2),         & 
& cplhhhhcVWpVWp(3,3),cplHpmcHpmcVWpVWp(4,4),cplcVWpcVWpVWpVWp1,cplcVWpcVWpVWpVWp2,      & 
& cplcVWpcVWpVWpVWp3,cplcVWpcVXpVWpVXp1,cplcVWpcVXpVWpVXp2,cplcVWpcVXpVWpVXp3,           & 
& cplcHpmcVXpVP(4),cplcDpmcVXpVWp(2),cplcHpmcVXpVZ(4),cplAhAhVPVZ(3,3),cplDpmcDpmVPVZ(2,2),& 
& cplhhhhVPVZ(3,3),cplHpmcHpmVPVZ(4,4),cplcVWpVPVWpVZ1,cplcVWpVPVWpVZ2,cplcVWpVPVWpVZ3,  & 
& cplcVXpVPVXpVZ1,cplcVXpVPVXpVZ2,cplcVXpVPVXpVZ3,cplAhAhVPVZp(3,3),cplDpmcDpmVPVZp(2,2),& 
& cplhhhhVPVZp(3,3),cplHpmcHpmVPVZp(4,4),cplcVWpVPVWpVZp1,cplcVWpVPVWpVZp2,              & 
& cplcVWpVPVWpVZp3,cplcVXpVPVXpVZp1,cplcVXpVPVXpVZp2,cplcVXpVPVXpVZp3,cplAhAhVZVZp(3,3), & 
& cplDpmcDpmVZVZp(2,2),cplhhhhVZVZp(3,3),cplHpmcHpmVZVZp(4,4),cplcVWpVWpVZVZp1,          & 
& cplcVWpVWpVZVZp2,cplcVWpVWpVZVZp3,cplcVXpVXpVZVZp1,cplcVXpVXpVZVZp2,cplcVXpVXpVZVZp3,  & 
& cplAhHpmVWp(3,4),cplcFuFdVWpL(4,5),cplcFuFdVWpR(4,5),cplhhHpmVWp(3,4),cplHpmcHpmcVXpVWp(4,4)

Complex(dp) :: cplcUFdFdAhL(5,5,3),cplcUFdFdAhR(5,5,3),cplcUFdFdDpmL(5,5,2),cplcUFdFdDpmR(5,5,2),    & 
& cplcUFdFdhhL(5,5,3),cplcUFdFdhhR(5,5,3),cplcUFdFdVGL(5,5),cplcUFdFdVGR(5,5),           & 
& cplcUFdFdVPL(5,5),cplcUFdFdVPR(5,5),cplcUFdFdVZL(5,5),cplcUFdFdVZR(5,5),               & 
& cplcUFdFdVZpL(5,5),cplcUFdFdVZpR(5,5),cplcUFdFucVWpL(5,4),cplcUFdFucVWpR(5,4),         & 
& cplcUFdFucVXpL(5,4),cplcUFdFucVXpR(5,4),cplcUFdFuHpmL(5,4,4),cplcUFdFuHpmR(5,4,4),     & 
& cplcUFuFuAhL(4,4,3),cplcUFuFuAhR(4,4,3),cplcUFuFuDpmL(4,4,2),cplcUFuFuDpmR(4,4,2),     & 
& cplcUFuFdcHpmL(4,5,4),cplcUFuFdcHpmR(4,5,4),cplcUFuFdVWpL(4,5),cplcUFuFdVWpR(4,5),     & 
& cplcUFuFdVXpL(4,5),cplcUFuFdVXpR(4,5),cplcUFuFuhhL(4,4,3),cplcUFuFuhhR(4,4,3),         & 
& cplcUFuFuVGL(4,4),cplcUFuFuVGR(4,4),cplcUFuFuVPL(4,4),cplcUFuFuVPR(4,4),               & 
& cplcUFuFuVZL(4,4),cplcUFuFuVZR(4,4),cplcUFuFuVZpL(4,4),cplcUFuFuVZpR(4,4),             & 
& cplcUFeFeAhL(3,3,3),cplcUFeFeAhR(3,3,3),cplcUFeFehhL(3,3,3),cplcUFeFehhR(3,3,3),       & 
& cplcUFeFeVPL(3,3),cplcUFeFeVPR(3,3),cplcUFeFeVZL(3,3),cplcUFeFeVZR(3,3),               & 
& cplcUFeFeVZpL(3,3),cplcUFeFeVZpR(3,3),cplcUFeFv1cVWpL(3,3),cplcUFeFv1cVWpR(3,3),       & 
& cplcUFeFv1HpmL(3,3,4),cplcUFeFv1HpmR(3,3,4),cplcUFecFv1HpmL(3,3,4),cplcUFecFv1HpmR(3,3,4)

Integer, Intent(in) :: i_run 
Real(dp), Intent(in) :: delta0 
Integer, Intent(inout) :: kont 
Integer :: i1,i2,i3,i4 
Complex(dp) ::uU_L(4,4),uU_R(4,4),uD_L(5,5),uD_R(5,5), NoMatrix(3,3) &
&,uL_L(3,3),uL_R(3,3)
Real(dp)::mW2_run,mZ2_run,test, D_mat(3,3)
Real(dp)::alphaQ,alpha3,gSU2,rho,delta_rho,delta_rho0,sinW2_Q,vev2&
&,vevs_Q(2),mZ2_Q,CosW2SinW2,gauge(3),delta,delta_SM,sinW2_old,delta_r&
&,p2,gSU3,tanb,xt2,fac(2),SigQCD,delta_rw,sinW2,cosW2,cosW
Real(dp),Dimension(3)::mf_d_Q,mf_l_Q,mf_u_Q
Real(dp) :: g1SM, g2SM, g3SM, vSM 
Complex(dp) :: dMZ2_SM, dMW2_SM, dMW2_0_SM 
Complex(dp) :: dmZ2,dmW2,dmW2_0,yuk_tau,yuk_t,yuk_b
Complex(dp) :: SigSR_u(4,4),SigSL_u(4,4),sigR_u(4,4),SigL_u(4,4)
Complex(dp) :: SigSR_d(5,5),SigSL_d(5,5),SigR_d(5,5),SigL_d(5,5)
Complex(dp) :: SigSR_l(3,3),SigSL_l(3,3),sigR_l(3,3),SigL_l(3,3)
Complex(dp) :: SigSR_u_SM(3,3),SigSL_u_SM(3,3),sigR_u_SM(3,3),SigL_u_SM(3,3)
Complex(dp) :: SigSR_d_SM(3,3),SigSL_d_SM(3,3),SigR_d_SM(3,3),SigL_d_SM(3,3)
Complex(dp) :: SigSR_l_SM(3,3),SigSL_l_SM(3,3),sigR_l_SM(3,3),SigL_l_SM(3,3)
Complex(dp) :: YuSM(3,3),YdSM(3,3),YeSM(3,3), adCKM(3,3),Y_l_old(3,3),Y_d_old(3,3),Y_u_old(3,3) 
Real(dp) :: g1_MS, g2_MS,g3_MS,v_MS, mf_d_MS(3), mf_u_MS(3), mf_e_MS(3) 
Complex(dp) :: Yu_MS(3,3),Yd_MS(3,3),Ye_MS(3,3), Mu_MS, Lam_MS, MuSM 
Complex(dp) :: uU_L_MS(3,3),uU_R_MS(3,3)&
&,uD_L_MS(3,3),uD_R_MS(3,3),uL_L_MS(3,3),uL_R_MS(3,3), CKM_MS(3,3), delta_r_SM
Complex(dp) :: uU_L_T(4,4),uU_R_T(4,4)&
&,uD_L_T(5,5),uD_R_T(5,5),uL_L_T(3,3),uL_R_T(3,3)
Logical::converge
Integer :: i_loop, i_loop_max 
Real(dp),Parameter::&
& as2loop=1._dp/24._dp+2011._dp*oo32Pi2/12._dp&
&+Log2/12._dp-oo8Pi2*Zeta3&
&,log2loop_a=123._dp*oo32Pi2,log2loop_b=33._dp*oo32Pi2
Real(dp)::Q2,logQ, sinTW_MS, alphaEW_MS, alphaS_MS, mudim, mz2_MS, mw2_MS 


Real(dp) :: VEVSM1,VEVSM2,VEVSM1MZ,VEVSM2MZ 
Complex(dp) ::MassFu(4,4),MassFd(5,5),MassFe(3,3) 
Real(dp),Parameter::id5R(5,5)=& 
   & Reshape(Source=(/& 
   & 1,0,0,0,0,& 
 &0,1,0,0,0,& 
 &0,0,1,0,0,& 
 &0,0,0,1,0,& 
 &0,0,0,0,1& 
 &/),shape=(/5,5/)) 
Complex(dp),Parameter::id5C(5,5)=& 
   & Reshape(Source=(/& 
   & 1,0,0,0,0,& 
 &0,1,0,0,0,& 
 &0,0,1,0,0,& 
 &0,0,0,1,0,& 
 &0,0,0,0,1& 
 &/),shape=(/5,5/)) 
Iname=Iname+1
NameOfUnit(Iname)='BoundaryBSM'
rMS_SM = rMS 
tanb = tanbetaMZ 
sinW2 = 1 - mW**2/mZ**2 
mudim = GetRenormalizationScale() 
mudim = sqrt(mudim) 
Call GToParameters62_SM(g_SM,g1_MS,g2_MS,g3_MS,Lam_MS,Yu_MS,Yd_MS,Ye_MS,Mu_MS,v_MS) 
sinTW_MS = g1_MS/sqrt(g1_MS**2+g2_MS**2) 
sinW2_Q = sinTW_MS**2 
alphaEW_MS = (sinTW_MS*g2_MS)**2/(4._dp*Pi) 
alphaS_MS = g3_MS**2/(4._dp*Pi) 
mz2_MS = (g1_MS**2+g2_MS**2)/(4._dp)*(v_MS**2) 
delta_r_SM = 1._dp - alphaEW_MS*Pi/(G_F*mz2*sqrt2*sinW2_Q*(1-sinW2_Q))
   Call FermionMass(Yd_MS,v_MS,mf_d_MS,uD_L_MS,uD_R_MS,kont)
   Call FermionMass(Ye_MS,v_MS,mf_e_MS,uL_L_MS,uL_R_MS,kont)
   Call FermionMass(Yu_MS,v_MS,mf_u_MS,uU_L_MS,uU_R_MS,kont)
   CKM_MS = MatMul(uU_R_MS,Transpose(Conjg(uD_R_MS))) 
!-----------------
!sin(theta_W)^2
!-----------------
vSM = v_MS 
   sinW2_old=sinW2_Q
   mf_l2=mf_e_MS**2
   mf_d2=mf_d_MS**2
   mf_u2=mf_u_MS**2
MFe2(1:3) = mf_l**2 
MFd2(1:3) = mf_d**2 
MFu2(1:3) = mf_u**2 
MFe = sqrt(MFe2) 
MFd = sqrt(MFd2) 
MFu = sqrt(MFu2) 
alphaQ = AlphaEw_T(alphaEW_MS,mudim,Abs(MVWp),Abs(MVXp),Abs(MHpm),Abs(MDpm),Abs(MFd),Abs(MFu),Abs(MFe)) 
 
MFe2(1:3) = mf_l2 
MFd2(1:3) = mf_d2 
MFu2(1:3) = mf_u2 
MFe = sqrt(MFe2) 
MFd = sqrt(MFd2) 
MFu = sqrt(MFu2) 
alpha3 = AlphaS_T(alphaS_MS,mudim,Abs(MFd),Abs(MFu)) 
If (.not.OneLoopMatching) alpha3 = alphaS_MS 
gSU3 = Sqrt(4._dp*pi*alpha3) 
g3SM = Sqrt(4._dp*pi*alpha3) 
Do i1=1,100 
gSU2 = Sqrt( 4._dp*pi*alphaQ/sinW2_Q) 
g1SM =gSU2*Sqrt(sinW2_Q/(1._dp-sinW2_Q)) 
g2SM =gSU2 
If (i_run.eq.1) Then 
 YeSM=Yl_MZ
 YdSM=Yd_MZ
 YuSM=Yu_MZ
Else 
 YeSM=Yl_Q
 YdSM=Yd_Q
 YuSM=Yu_Q
End if 
Call SetMatchingConditions(g1SM,g2SM,g3SM,YuSM,YdSM,YeSM,vSM,Vn,v1,v2,g1,             & 
& g2,g3,l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,hll1,hdp11,hd1,hdtp11,hdt1,hup11,            & 
& hUp1,hdp1,hd2,hdtp1,hdt2,hup21,hUp2,hd3,hdt3,hu11,h12,hU1,hU2,ftri,mu12,               & 
& mu22,mu32,.False.)

Call TreeMasses(MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,MFe2,MFu,MFu2,Mhh,Mhh2,              & 
& MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,TW,Ud,Ue,Uu,Vd,Ve,Vu,             & 
& ZA,ZH,ZP,ZW,zy,ZZ,Vn,v1,v2,g1,g2,g3,l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,               & 
& hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,hUp2,hd3,              & 
& hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,GenerationMixing,kont)

TW= Asin(Sqrt(sinw2_Q)) 

 
 ! --- Boundary conditions at EW-scale --- 
Select Case(BoundaryCondition) 
End Select 

! ----------------------- 
 
MVZ2 = mZ2 
MVZ= Sqrt(MVZ2) 
MVWp2 = mW2 
MVWp= Sqrt(MVWp2) 
MAh(1)=MVZ
MAh2(1)=MVZ2
MAh(2)=MVZp
MAh2(2)=MVZp2
MHpm(1)=MVWp
MHpm2(1)=MVWp2
MHpm(2)=MVXp
MHpm2(2)=MVXp2
If (.not.MatchZWpoleMasses) Then 
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

Call Pi1LoopVZ(mZ2,Mhh,Mhh2,MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,MFe2,MFu,MFu2,           & 
& MVZ,MVZ2,MVZp,MVZp2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,cplAhhhVZ,cplDpmcDpmVZ,           & 
& cplcFdFdVZL,cplcFdFdVZR,cplcFeFeVZL,cplcFeFeVZR,cplcFuFuVZL,cplcFuFuVZR,               & 
& cplcFv1Fv1VZL,cplcFv1Fv1VZR,cplcgWpgWpVZ,cplcgWCgWCVZ,cplcgXp1gXp1VZ,cplcgXp2gXp2VZ,   & 
& cplhhVPVZ,cplhhVZVZ,cplhhVZVZp,cplHpmcHpmVZ,cplHpmVWpVZ,cplHpmVXpVZ,cplcVWpVWpVZ,      & 
& cplcVXpVXpVZ,cplAhAhVZVZ,cplDpmcDpmVZVZ,cplhhhhVZVZ,cplHpmcHpmVZVZ,cplcVWpVWpVZVZ1,    & 
& cplcVWpVWpVZVZ2,cplcVWpVWpVZVZ3,cplcVXpVXpVZVZ1,cplcVXpVXpVZVZ2,cplcVXpVXpVZVZ3,       & 
& kont,dmZ2)

Call OneLoop_Z_W_SM(vSM,g1SM,g2SM,g3SM,Lam_MS,-YuSM,YdSM,YeSM,kont,dmZ2_SM,           & 
& dmW2_SM,dmW2_0_SM)

dmZ2 = dmZ2 - dmZ2_SM
If (.not.OneLoopMatching) dmZ2 = 0._dp 
mZ2_Q = Real(dmZ2 + mZ2_MS,dp) 
If (mZ2_Q.Lt.0._dp) Then
    Iname=Iname-1
    kont=-402
    Call AddError(402)
    Write(*,*) " MZ  getting negative at renormalisation scale" 
    Call TerminateProgram
End If

mZ2_run=mZ2_Q
mW2_run=mZ2_Q*(1._dp-sinW2_Q) +0  
MVZ2 = mZ2_run 
MVZ= Sqrt(MVZ2) 
MVWp2 = mW2_run 
MVWp= Sqrt(MVWp2) 
MAh(1)=MVZ
MAh2(1)=MVZ2
MAh(2)=MVZp
MAh2(2)=MVZp2
MHpm(1)=MVWp
MHpm2(1)=MVWp2
MHpm(2)=MVXp
MHpm2(2)=MVXp2
CosW2SinW2=(1._dp-sinW2_Q)*sinW2_Q
vev2=mZ2_Q*CosW2SinW2/(pi*alphaQ) -(0) 
vSM=Sqrt(vev2)
Call SetMatchingConditions(g1SM,g2SM,g3SM,YuSM,YdSM,YeSM,vSM,Vn,v1,v2,g1,             & 
& g2,g3,l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,hll1,hdp11,hd1,hdtp11,hdt1,hup11,            & 
& hUp1,hdp1,hd2,hdtp1,hdt2,hup21,hUp2,hd3,hdt3,hu11,h12,hU1,hU2,ftri,mu12,               & 
& mu22,mu32,.False.)

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

Call Pi1LoopVZ(mZ2,Mhh,Mhh2,MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,MFe2,MFu,MFu2,           & 
& MVZ,MVZ2,MVZp,MVZp2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,cplAhhhVZ,cplDpmcDpmVZ,           & 
& cplcFdFdVZL,cplcFdFdVZR,cplcFeFeVZL,cplcFeFeVZR,cplcFuFuVZL,cplcFuFuVZR,               & 
& cplcFv1Fv1VZL,cplcFv1Fv1VZR,cplcgWpgWpVZ,cplcgWCgWCVZ,cplcgXp1gXp1VZ,cplcgXp2gXp2VZ,   & 
& cplhhVPVZ,cplhhVZVZ,cplhhVZVZp,cplHpmcHpmVZ,cplHpmVWpVZ,cplHpmVXpVZ,cplcVWpVWpVZ,      & 
& cplcVXpVXpVZ,cplAhAhVZVZ,cplDpmcDpmVZVZ,cplhhhhVZVZ,cplHpmcHpmVZVZ,cplcVWpVWpVZVZ1,    & 
& cplcVWpVWpVZVZ2,cplcVWpVWpVZVZ3,cplcVXpVXpVZVZ1,cplcVXpVXpVZVZ2,cplcVXpVXpVZVZ3,       & 
& kont,dmZ2)

Call OneLoop_Z_W_SM(vSM,g1SM,g2SM,g3SM,Lam_MS,-YuSM,YdSM,YeSM,kont,dmZ2_SM,           & 
& dmW2_SM,dmW2_0_SM)

dmZ2 = dmZ2 - dmZ2_SM
If (.not.OneLoopMatching) dmZ2 = 0._dp 
mZ2_Q = Real(dmZ2 + mZ2_MS,dp) 
If (mZ2_Q.Lt.0._dp) Then
    Iname=Iname-1
    kont=-402
    Call AddError(402)
    Write(*,*) " MZ  getting negative at renormalisation scale" 
    Call TerminateProgram
End If

mZ2_run=mZ2_Q
mW2_run=mZ2_Q*(1._dp-sinW2_Q) +0  
MVZ2 = mZ2_run 
MVZ= Sqrt(MVZ2) 
MVWp2 = mW2_run 
MVWp= Sqrt(MVWp2) 
MAh(1)=MVZ
MAh2(1)=MVZ2
MAh(2)=MVZp
MAh2(2)=MVZp2
MHpm(1)=MVWp
MHpm2(1)=MVWp2
MHpm(2)=MVXp
MHpm2(2)=MVXp2
CosW2SinW2=(1._dp-sinW2_Q)*sinW2_Q
vev2=mZ2_Q *CosW2SinW2/(pi*alphaQ) -(0) 
vSM=sqrt(vev2) 
Call SetMatchingConditions(g1SM,g2SM,g3SM,YuSM,YdSM,YeSM,vSM,Vn,v1,v2,g1,             & 
& g2,g3,l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,hll1,hdp11,hd1,hdtp11,hdt1,hup11,            & 
& hUp1,hdp1,hd2,hdtp1,hdt2,hup21,hUp2,hd3,hdt3,hu11,h12,hU1,hU2,ftri,mu12,               & 
& mu22,mu32,.False.)

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

Call Pi1LoopVWp(mW2,MHpm,MHpm2,MAh,MAh2,MDpm,MDpm2,MVXp,MVXp2,MFd,MFd2,               & 
& MFu,MFu2,MFe,MFe2,Mhh,Mhh2,MVWp,MVWp2,MVZ,MVZ2,MVZp,MVZp2,cplAhcHpmcVWp,               & 
& cplDpmcHpmcVWp,cplDpmcVWpVXp,cplcFdFucVWpL,cplcFdFucVWpR,cplcFeFv1cVWpL,               & 
& cplcFeFv1cVWpR,cplcgWCgAcVWp,cplcgAgWpcVWp,cplcgZgWpcVWp,cplcgZpgWpcVWp,               & 
& cplcgWCgZcVWp,cplcgWCgZpcVWp,cplhhcHpmcVWp,cplhhcVWpVWp,cplcHpmcVWpVP,cplcVWpVPVWp,    & 
& cplcVWpVWpVZ,cplcVWpVWpVZp,cplcHpmcVWpVZ,cplcHpmcVWpVZp,cplAhAhcVWpVWp,cplDpmcDpmcVWpVWp,& 
& cplhhhhcVWpVWp,cplHpmcHpmcVWpVWp,cplcVWpVPVPVWp3,cplcVWpVPVPVWp1,cplcVWpVPVPVWp2,      & 
& cplcVWpcVWpVWpVWp2,cplcVWpcVWpVWpVWp3,cplcVWpcVWpVWpVWp1,cplcVWpcVXpVWpVXp2,           & 
& cplcVWpcVXpVWpVXp3,cplcVWpcVXpVWpVXp1,cplcVWpVWpVZVZ1,cplcVWpVWpVZVZ2,cplcVWpVWpVZVZ3, & 
& cplcVWpVWpVZpVZp1,cplcVWpVWpVZpVZp2,cplcVWpVWpVZpVZp3,kont,dmW2)

Call Pi1LoopVWp(0._dp,MHpm,MHpm2,MAh,MAh2,MDpm,MDpm2,MVXp,MVXp2,MFd,MFd2,             & 
& MFu,MFu2,MFe,MFe2,Mhh,Mhh2,MVWp,MVWp2,MVZ,MVZ2,MVZp,MVZp2,cplAhcHpmcVWp,               & 
& cplDpmcHpmcVWp,cplDpmcVWpVXp,cplcFdFucVWpL,cplcFdFucVWpR,cplcFeFv1cVWpL,               & 
& cplcFeFv1cVWpR,cplcgWCgAcVWp,cplcgAgWpcVWp,cplcgZgWpcVWp,cplcgZpgWpcVWp,               & 
& cplcgWCgZcVWp,cplcgWCgZpcVWp,cplhhcHpmcVWp,cplhhcVWpVWp,cplcHpmcVWpVP,cplcVWpVPVWp,    & 
& cplcVWpVWpVZ,cplcVWpVWpVZp,cplcHpmcVWpVZ,cplcHpmcVWpVZp,cplAhAhcVWpVWp,cplDpmcDpmcVWpVWp,& 
& cplhhhhcVWpVWp,cplHpmcHpmcVWpVWp,cplcVWpVPVPVWp3,cplcVWpVPVPVWp1,cplcVWpVPVPVWp2,      & 
& cplcVWpcVWpVWpVWp2,cplcVWpcVWpVWpVWp3,cplcVWpcVWpVWpVWp1,cplcVWpcVXpVWpVXp2,           & 
& cplcVWpcVXpVWpVXp3,cplcVWpcVXpVWpVXp1,cplcVWpVWpVZVZ1,cplcVWpVWpVZVZ2,cplcVWpVWpVZVZ3, & 
& cplcVWpVWpVZpVZp1,cplcVWpVWpVZpVZp2,cplcVWpVWpVZpVZp3,kont,dmW2_0)

Call OneLoop_Z_W_SM(vSM,g1SM,g2SM,g3SM,Lam_MS,-YuSM,YdSM,YeSM,kont,dmZ2_SM,           & 
& dmW2_SM,dmW2_0_SM)

dmW2 = dmW2 - dmW2_SM
dmW2_0 = dmW2_0 - dmW2_0_SM
If (.not.OneLoopMatching) dmW2 = 0._dp 
If (.not.OneLoopMatching) dmW2_0 = 0._dp 
rho=(1._dp+Real(dmZ2,dp)/mZ2)/(1._dp+Real(dmW2,dp)/mW2)  
delta_rho=1._dp-1._dp/rho
delta_rho0=0
rho=1._dp/(1._dp-delta_rho-delta_rho0)
CosW2SinW2=(1._dp-sinW2_Q)*sinW2_Q
If (IncludeDeltaVB) Then 
Call DeltaVB(sinW2,sinW2_Q,rho,MAh,MFe,Mhh,MHpm,MVZp,g1,g2,h12l,hll1,Ue,              & 
& Ve,ZA,ZH,ZP,ZZ,delta)

Call DeltaVB_SM(sinW2,sinW2_Q,g2SM,rho,delta_SM)

 delta=delta-delta_SM 
Else 
 delta = 0._dp 
End if 
If (.not.OneLoopMatching) delta = 0._dp 
delta_r=rho*Real(dmW2_0,dp)/mW2-Real(dmZ2,dp)/mZ2+delta
delta_rho0=0
rho=1._dp/(1._dp-delta_rho-delta_rho0)
delta_r=rho*Real(dmW2_0,dp)/mW2-Real(dmZ2,dp)/mZ2+delta
CosW2SinW2=pi*alphaQ/(sqrt2*mZ2*G_F*(1-delta_r_SM - delta_r))
sinW2_Q=0.5_dp-Sqrt(0.25_dp-CosW2SinW2)

If (sinW2_Q.Lt.0._dp) Then
    kont=-403
    Call AddError(403)
    Iname=Iname-1
    Write(*,*) " sinW2 getting negtive at renormalisation scale " 
    Call TerminateProgram
End If
 
If (Abs(sinW2_Q-sinW2_old).Lt.0.1_dp*delta0) Exit

sinW2_old=sinW2_Q
delta_rw=delta_rho*(1._dp-delta_r_SM - delta_r)+delta_r_SM + delta_r
If ((0.25_dp-alphaQ*pi/(sqrt2*G_F*mz2*rho*(1._dp-delta_rw))).Lt.0._dp) Then
    kont=-404
    Call AddError(404)
    Iname=Iname-1
     Return
End If

mW2=mZ2*rho*(0.5_dp&
    &+Sqrt(0.25_dp-alphaQ*pi/(sqrt2*G_F*mz2*rho*(1._dp-delta_rw))))
MAh(1)=MVZ
MAh2(1)=MVZ2
MAh(2)=MVZp
MAh2(2)=MVZp2
MHpm(1)=MVWp
MHpm2(1)=MVWp2
MHpm(2)=MVXp
MHpm2(2)=MVXp2
cosW2=mW2/mZ2
cosW=Sqrt(cosW2)
sinW2=1._dp-cosW2
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

Call Pi1LoopVZ(mZ2,Mhh,Mhh2,MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,MFe2,MFu,MFu2,           & 
& MVZ,MVZ2,MVZp,MVZp2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,cplAhhhVZ,cplDpmcDpmVZ,           & 
& cplcFdFdVZL,cplcFdFdVZR,cplcFeFeVZL,cplcFeFeVZR,cplcFuFuVZL,cplcFuFuVZR,               & 
& cplcFv1Fv1VZL,cplcFv1Fv1VZR,cplcgWpgWpVZ,cplcgWCgWCVZ,cplcgXp1gXp1VZ,cplcgXp2gXp2VZ,   & 
& cplhhVPVZ,cplhhVZVZ,cplhhVZVZp,cplHpmcHpmVZ,cplHpmVWpVZ,cplHpmVXpVZ,cplcVWpVWpVZ,      & 
& cplcVXpVXpVZ,cplAhAhVZVZ,cplDpmcDpmVZVZ,cplhhhhVZVZ,cplHpmcHpmVZVZ,cplcVWpVWpVZVZ1,    & 
& cplcVWpVWpVZVZ2,cplcVWpVWpVZVZ3,cplcVXpVXpVZVZ1,cplcVXpVXpVZVZ2,cplcVXpVXpVZVZ3,       & 
& kont,dmZ2)

Call Pi1LoopVWp(mW2,MHpm,MHpm2,MAh,MAh2,MDpm,MDpm2,MVXp,MVXp2,MFd,MFd2,               & 
& MFu,MFu2,MFe,MFe2,Mhh,Mhh2,MVWp,MVWp2,MVZ,MVZ2,MVZp,MVZp2,cplAhcHpmcVWp,               & 
& cplDpmcHpmcVWp,cplDpmcVWpVXp,cplcFdFucVWpL,cplcFdFucVWpR,cplcFeFv1cVWpL,               & 
& cplcFeFv1cVWpR,cplcgWCgAcVWp,cplcgAgWpcVWp,cplcgZgWpcVWp,cplcgZpgWpcVWp,               & 
& cplcgWCgZcVWp,cplcgWCgZpcVWp,cplhhcHpmcVWp,cplhhcVWpVWp,cplcHpmcVWpVP,cplcVWpVPVWp,    & 
& cplcVWpVWpVZ,cplcVWpVWpVZp,cplcHpmcVWpVZ,cplcHpmcVWpVZp,cplAhAhcVWpVWp,cplDpmcDpmcVWpVWp,& 
& cplhhhhcVWpVWp,cplHpmcHpmcVWpVWp,cplcVWpVPVPVWp3,cplcVWpVPVPVWp1,cplcVWpVPVPVWp2,      & 
& cplcVWpcVWpVWpVWp2,cplcVWpcVWpVWpVWp3,cplcVWpcVWpVWpVWp1,cplcVWpcVXpVWpVXp2,           & 
& cplcVWpcVXpVWpVXp3,cplcVWpcVXpVWpVXp1,cplcVWpVWpVZVZ1,cplcVWpVWpVZVZ2,cplcVWpVWpVZVZ3, & 
& cplcVWpVWpVZpVZp1,cplcVWpVWpVZpVZp2,cplcVWpVWpVZpVZp3,kont,dmW2)

Call OneLoop_Z_W_SM(v_MS,g1_MS,g2_MS,g3_MS,Lam_MS,Yu_MS,Yd_MS,Ye_MS,kont,             & 
& dmZ2_SM,dmW2_SM,dmW2_0_SM)

If (.not.OneLoopMatching) dmZ2_SM = 0._dp 
If (.not.OneLoopMatching) dmW2_SM = 0._dp 
If (.not.OneLoopMatching) dmW2_0_SM = 0._dp 
mZ2_run=mZ2_MS-dmZ2+dmz2_SM
mW2_run=mw2_MS-dmW2+dmw2_SM
sinW2_Q=1._dp-mW2_run/MZ2_run
g1SM=Sqrt(4._dp*pi*alphaQ/(1._dp-sinW2_Q))
g2SM=Sqrt(4._dp*pi*alphaQ/sinW2_Q)
g3SM=Sqrt(4._dp*pi*alpha3)
vSM=sqrt(4._dp*mz2_run/(g1SM**2+g2SM**2))
Call SetMatchingConditions(g1SM,g2SM,g3SM,YuSM,YdSM,YeSM,vSM,Vn,v1,v2,g1,             & 
& g2,g3,l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,hll1,hdp11,hd1,hdtp11,hdt1,hup11,            & 
& hUp1,hdp1,hd2,hdtp1,hdt2,hup21,hUp2,hd3,hdt3,hu11,h12,hU1,hU2,ftri,mu12,               & 
& mu22,mu32,.False.)

vev2=4._dp*mz2_run/(g1SM**2+g2SM**2) -(0) 
vSM=sqrt(vev2) 
End If 
End Do

MAh(1)=MVZ
MAh2(1)=MVZ2
MAh(2)=MVZp
MAh2(2)=MVZp2
MHpm(1)=MVWp
MHpm2(1)=MVWp2
MHpm(2)=MVXp
MHpm2(2)=MVXp2
If (.not.MatchZWpoleMasses) Then 
delta_rw=delta_rho*(1._dp-delta_r_SM - delta_r)+delta_r_SM + delta_r
mW2=mZ2*rho*(0.5_dp& 
   &+Sqrt(0.25_dp-alphaQ*pi/(sqrt2*G_F*mz2*rho*(1._dp-delta_rw))))
mW=Sqrt(mW2)
vev2=mZ2_Q*CosW2SinW2/(pi*alphaQ) -(0) 
vSM=sqrt(vev2) 
Else 
mW2=(1._dp-sinW2_Q)*MZ2 
mW=Sqrt(mW2)
End If 
cosW2=mW2/mZ2
cosW=Sqrt(cosW2)
sinW2=1._dp-cosW2
g1SM=Sqrt(4._dp*pi*alphaQ/(1._dp-sinW2_Q))
g2SM=Sqrt(4._dp*pi*alphaQ/sinW2_Q)
g3SM=Sqrt(4._dp*pi*alpha3)
vSM_Q = vSM
Call SetMatchingConditions(g1SM,g2SM,g3SM,YuSM,YdSM,YeSM,vSM,Vn,v1,v2,g1,             & 
& g2,g3,l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,hll1,hdp11,hd1,hdtp11,hdt1,hup11,            & 
& hUp1,hdp1,hd2,hdtp1,hdt2,hup21,hUp2,hd3,hdt3,hu11,h12,hU1,hU2,ftri,mu12,               & 
& mu22,mu32,.False.)

Call SetMatchingConditions(g1SM,g2SM,g3SM,YuSM,YdSM,YeSM,vSM,Vn,v1,v2,g1,             & 
& g2,g3,l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,hll1,hdp11,hd1,hdtp11,hdt1,hup11,            & 
& hUp1,hdp1,hd2,hdtp1,hdt2,hup21,hUp2,hd3,hdt3,hu11,h12,hU1,hU2,ftri,mu12,               & 
& mu22,mu32,.True.)



! -------------------------
!  Calculate Yukawas
! -------------------------
uU_L=id4C
uU_R=id4C
uD_L=id5C
uD_R=id5C
uL_L=id3C
uL_R=id3C
If (GenerationMixing) Then
    Call Adjungate(CKM_MS,adCKM)
 If (YukawaScheme.Eq.1) Then
    uU_L(1:3,1:3)=CKM_MS
 Else
    uD_L(1:3,1:3)=adCKM
 End If
End If
If (rMS.lt.0.5_dp) Then ! shift to DR if necessary 
   mf_l_Q_SM=&
            & mf_e_MS*(1._dp-alphaQ/(4._dp*Pi))
   mf_d_Q_SM=mf_d_MS*(1._dp-alpha3/(3._dp*pi)&
           &-43._dp*alpha3**2/(144._dp*Pi2) - alphaQ/(36._dp*Pi))
   mf_u_Q_SM(1:3)=mf_u_MS(1:3)*(1._dp-alpha3/(3._dp*pi)&
               &-43._dp*alpha3**2/(144._dp*Pi2)- alphaQ/(9._dp*Pi))
Else 
   mf_l_Q_SM=mf_e_MS
   mf_d_Q_SM=mf_d_MS
   mf_u_Q_SM=mf_u_MS
End if 
mf_l_Q=mf_l_Q_SM
mf_d_Q=mf_d_Q_SM
mf_u_Q=mf_u_Q_SM
YdSM=0._dp
YuSM=0._dp
YeSM=0._dp
Do i1=1,3
    YuSM(i1,i1)=sqrt2*mf_u_Q_SM(i1)/vSM
    YeSM(i1,i1)=sqrt2*mf_l_Q_SM(i1)/vSM
    YdSM(i1,i1)=sqrt2*mf_d_Q_SM(i1)/vSM
End Do
If (GenerationMixing) Then
  If (YukawaScheme.Eq.1) Then
    YuSM=Matmul(Transpose(uU_L(1:3,1:3)),YuSM)
  Else
    YdSM=Matmul(Transpose(uD_L(1:3,1:3)),YdSM)
  End If
End If
converge= .False.
Y_l_old=YeSM
Y_d_old=YdSM
Y_u_old=YuSM
Call SetMatchingConditions(g1SM,g2SM,g3SM,YuSM,YdSM,YeSM,vSM,Vn,v1,v2,g1,             & 
& g2,g3,l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,hll1,hdp11,hd1,hdtp11,hdt1,hup11,            & 
& hUp1,hdp1,hd2,hdtp1,hdt2,hup21,hUp2,hd3,hdt3,hu11,h12,hU1,hU2,ftri,mu12,               & 
& mu22,mu32,.False.)



! -------------------------
!  Main Loop
! -------------------------
if (FermionMassResummation) then
  i_loop_max=100! this should be sufficient
else
  i_loop_max=1
end if
Do i_loop=1,i_loop_max
p2=0._dp! for off-diagonal elements

 
 ! --- Boundary conditions at EW-scale --- 
Select Case(BoundaryCondition) 
End Select 

! ----------------------- 
 


! Full one-loop corrections
Call CouplingsForSMfermions(hdp11,hd1,hdtp11,hdt1,hdp1,hd2,hdtp1,hdt2,hd3,            & 
& hdt3,ZA,Vd,Ud,zy,ZH,g3,g1,g2,ZZ,Vu,hup11,hUp1,hup21,hUp2,hu11,h12,hU1,hU2,             & 
& ZP,Uu,hll1,Ve,Ue,h12l,cplcUFdFdAhL,cplcUFdFdAhR,cplcUFdFdDpmL,cplcUFdFdDpmR,           & 
& cplcUFdFdhhL,cplcUFdFdhhR,cplcUFdFdVGL,cplcUFdFdVGR,cplcUFdFdVPL,cplcUFdFdVPR,         & 
& cplcUFdFdVZL,cplcUFdFdVZR,cplcUFdFdVZpL,cplcUFdFdVZpR,cplcUFdFucVWpL,cplcUFdFucVWpR,   & 
& cplcUFdFucVXpL,cplcUFdFucVXpR,cplcUFdFuHpmL,cplcUFdFuHpmR,cplcUFuFuAhL,cplcUFuFuAhR,   & 
& cplcUFuFuDpmL,cplcUFuFuDpmR,cplcUFuFdcHpmL,cplcUFuFdcHpmR,cplcUFuFdVWpL,               & 
& cplcUFuFdVWpR,cplcUFuFdVXpL,cplcUFuFdVXpR,cplcUFuFuhhL,cplcUFuFuhhR,cplcUFuFuVGL,      & 
& cplcUFuFuVGR,cplcUFuFuVPL,cplcUFuFuVPR,cplcUFuFuVZL,cplcUFuFuVZR,cplcUFuFuVZpL,        & 
& cplcUFuFuVZpR,cplcUFeFeAhL,cplcUFeFeAhR,cplcUFeFehhL,cplcUFeFehhR,cplcUFeFeVPL,        & 
& cplcUFeFeVPR,cplcUFeFeVZL,cplcUFeFeVZR,cplcUFeFeVZpL,cplcUFeFeVZpR,cplcUFeFv1cVWpL,    & 
& cplcUFeFv1cVWpR,cplcUFeFv1HpmL,cplcUFeFv1HpmR,cplcUFecFv1HpmL,cplcUFecFv1HpmR)

Call Sigma1LoopFeMZ(p2,MFe,MFe2,MAh,MAh2,Mhh,Mhh2,MVZ,MVZ2,MVZp,MVZp2,MVWp,           & 
& MVWp2,MHpm,MHpm2,cplcUFeFeAhL,cplcUFeFeAhR,cplcUFeFehhL,cplcUFeFehhR,cplcUFeFeVPL,     & 
& cplcUFeFeVPR,cplcUFeFeVZL,cplcUFeFeVZR,cplcUFeFeVZpL,cplcUFeFeVZpR,cplcUFeFv1cVWpL,    & 
& cplcUFeFv1cVWpR,cplcUFeFv1HpmL,cplcUFeFv1HpmR,cplcUFecFv1HpmL,cplcUFecFv1HpmR,         & 
& sigR_l,sigL_l,sigSL_l,sigSR_l)

Call Sigma1LoopFdMZ(p2,MFd,MFd2,MAh,MAh2,MDpm,MDpm2,Mhh,Mhh2,MVZ,MVZ2,MVZp,           & 
& MVZp2,MVWp,MVWp2,MFu,MFu2,MVXp,MVXp2,MHpm,MHpm2,cplcUFdFdAhL,cplcUFdFdAhR,             & 
& cplcUFdFdDpmL,cplcUFdFdDpmR,cplcUFdFdhhL,cplcUFdFdhhR,cplcUFdFdVGL,cplcUFdFdVGR,       & 
& cplcUFdFdVPL,cplcUFdFdVPR,cplcUFdFdVZL,cplcUFdFdVZR,cplcUFdFdVZpL,cplcUFdFdVZpR,       & 
& cplcUFdFucVWpL,cplcUFdFucVWpR,cplcUFdFucVXpL,cplcUFdFucVXpR,cplcUFdFuHpmL,             & 
& cplcUFdFuHpmR,sigR_d,sigL_d,sigSL_d,sigSR_d)

Call Sigma1LoopFuMZ(p2,MFu,MFu2,MAh,MAh2,MDpm,MDpm2,MHpm,MHpm2,MFd,MFd2,              & 
& MVWp,MVWp2,MVXp,MVXp2,Mhh,Mhh2,MVZ,MVZ2,MVZp,MVZp2,cplcUFuFuAhL,cplcUFuFuAhR,          & 
& cplcUFuFuDpmL,cplcUFuFuDpmR,cplcUFuFdcHpmL,cplcUFuFdcHpmR,cplcUFuFdVWpL,               & 
& cplcUFuFdVWpR,cplcUFuFdVXpL,cplcUFuFdVXpR,cplcUFuFuhhL,cplcUFuFuhhR,cplcUFuFuVGL,      & 
& cplcUFuFuVGR,cplcUFuFuVPL,cplcUFuFuVPR,cplcUFuFuVZL,cplcUFuFuVZR,cplcUFuFuVZpL,        & 
& cplcUFuFuVZpR,sigR_u,sigL_u,sigSL_u,sigSR_u)

! Take care of the new normalisation of Sigma 
SigR_l = 0.5_dp*SigR_L 
SigL_l = 0.5_dp*SigL_L 
SigR_d = 0.5_dp*SigR_d 
SigL_d = 0.5_dp*SigL_d 
SigR_u = 0.5_dp*SigR_u 
SigL_u = 0.5_dp*SigL_u 

Call OneLoop_d_u_e_SM(vSM,g1SM,g2SM,g3SM,Lam_MS,-YuSM,YdSM,YeSM,sigR_d_SM,            & 
& sigL_d_SM,sigSR_d_SM,sigSL_d_SM,sigR_u_SM,sigL_u_SM,sigSR_u_SM,sigSL_u_SM,             & 
& sigR_l_SM,sigL_l_SM,sigSR_l_SM,sigSL_l_SM,kont)

sigR_l(1:3,1:3) = sigR_l(1:3,1:3) - sigR_l_SM
sigL_l(1:3,1:3) = sigL_l(1:3,1:3) - sigL_l_SM
sigSR_l(1:3,1:3) = sigSR_l(1:3,1:3) - sigSR_l_SM
sigSL_l(1:3,1:3) = sigSL_l(1:3,1:3) - sigSL_l_SM
sigR_d(1:3,1:3) = sigR_d(1:3,1:3) - sigR_d_SM
sigL_d(1:3,1:3) = sigL_d(1:3,1:3) - sigL_d_SM
sigSR_d(1:3,1:3) = sigSR_d(1:3,1:3) - sigSR_d_SM
sigSL_d(1:3,1:3) = sigSL_d(1:3,1:3) - sigSL_d_SM
sigR_u(1:3,1:3) = sigR_u(1:3,1:3) - sigR_u_SM
sigL_u(1:3,1:3) = sigL_u(1:3,1:3) - sigL_u_SM
sigSR_u(1:3,1:3) = sigSR_u(1:3,1:3) - sigSR_u_SM
sigSL_u(1:3,1:3) = sigSL_u(1:3,1:3) - sigSL_u_SM


If (.not.OneLoopMatching) Then 
sigR_l = 0._dp 
sigL_l = 0._dp 
sigSR_l = 0._dp 
sigSL_l = 0._dp 
sigR_d = 0._dp 
sigL_d = 0._dp 
sigSR_d = 0._dp 
sigSL_d = 0._dp 
sigR_u = 0._dp 
sigL_u = 0._dp 
sigSR_u = 0._dp 
sigSL_u = 0._dp 
End if


! Construct tree-level masses
! Needed for models with additional states mixing with SM particles
Call CalculateMFe(hll1,v2,Ve,Ue,MFe,kont)

MassFe=0._dp 
Do i1 = 1,3
 MassFe(i1,i1)=MFe(i1) 
End do
MassFe = MatMul(Transpose(Ve),MatMul(MassFe,Conjg(Ue))) 
MFe(1:3) =mf_l_Q_SM 
Call CalculateMFu(hup11,hUp1,hup21,hUp2,hu11,h12,hU1,hU2,Vn,v1,v2,Vu,Uu,MFu,kont)

MassFu=0._dp 
Do i1 = 1,4
 MassFu(i1,i1)=MFu(i1) 
End do
MassFu = MatMul(Transpose(Vu),MatMul(MassFu,Conjg(Uu))) 
MFu(1:3) =mf_u_Q_SM 
Call CalculateMFd(hdp11,hd1,hdtp11,hdt1,hdp1,hd2,hdtp1,hdt2,hd3,hdt3,Vn,              & 
& v1,v2,Vd,Ud,MFd,kont)

MassFd=0._dp 
Do i1 = 1,5
 MassFd(i1,i1)=MFd(i1) 
End do
MassFd = MatMul(Transpose(Vd),MatMul(MassFd,Conjg(Ud))) 
MFd(1:3) =mf_d_Q_SM 


! Obtain Yukawas
Call Yukawas4(MFu,vSM,uU_L,uU_R,SigSL_u,SigL_u,SigR_u&
      &,massFu,YuSM, FermionMassResummation,kont) 
If (kont.Ne.0) Then 
    Iname=Iname-1
    Write(*,*) " Fit of Yukawa couplings at renormalisation scale failed" 
    Call TerminateProgram
End If
Call Yukawas5(MFd,vSM,uD_L,uD_R,SigSL_d,SigL_d,SigR_d& 
      &,massFd,YdSM,FermionMassResummation,kont)
If (kont.Ne.0) Then
    Iname=Iname-1
    Write(*,*) " Fit of Yukawa couplings at renormalisation scale failed" 
    Call TerminateProgram
End If 
Call Yukawas3(MFe,vSM,uL_L,uL_R,SigSL_l,SigL_l,SigR_l&
     &,massFe,YeSM,.False.,kont) 
If (kont.Ne.0) Then
    Iname=Iname-1
    Write(*,*) " Fit of Yukawa couplings at renormalisation scale failed" 
    Call TerminateProgram
End If


! Transpose Yukawas to fit conventions 
YuSM = Transpose(YuSM) 
YdSM= Transpose(YdSM)
YeSM= Transpose(YeSM)
Call SetMatchingConditions(g1SM,g2SM,g3SM,YuSM,YdSM,YeSM,vSM,Vn,v1,v2,g1,             & 
& g2,g3,l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,hll1,hdp11,hd1,hdtp11,hdt1,hup11,            & 
& hUp1,hdp1,hd2,hdtp1,hdt2,hup21,hUp2,hd3,hdt3,hu11,h12,hU1,hU2,ftri,mu12,               & 
& mu22,mu32,.False.)



! Re-calculate quarks with new Yukawas
Call CalculateMFe(hll1,v2,Ve,Ue,MFe,kont)

MFe2 = MFe**2 
Call CalculateMFu(hup11,hUp1,hup21,hUp2,hu11,h12,hU1,hU2,Vn,v1,v2,Vu,Uu,MFu,kont)

MFu2 = MFu**2 
Call CalculateMFd(hdp11,hd1,hdtp11,hdt1,hdp1,hd2,hdtp1,hdt2,hd3,hdt3,Vn,              & 
& v1,v2,Vd,Ud,MFd,kont)

MFd2 = MFd**2 
mf_l_Q  = MFe(1:3) 
mf_d_Q  = MFd(1:3) 
mf_u_Q  = MFu(1:3) 


! Re-calculate other masses which depend on Yukawas


! Check convergence 
converge= .True. 
D_mat=Abs(Abs(YeSM)-Abs(Y_l_old))
Where (Abs(YeSM).Ne.0._dp) D_mat=D_mat/Abs(YeSM)
Do i1=1,3
 If (D_mat(i1,i1).Gt.0.1_dp*delta0) converge= .False. 
  Do i2=i1+1,3 
   If (D_mat(i1,i2).Gt.delta0) converge= .False. 
   If (D_mat(i2,i1).Gt.delta0) converge= .False. 
 End Do 
End Do 
D_mat=Abs(Abs(YdSM)-Abs(Y_d_old))
Where (Abs(YdSM).Ne.0._dp) D_mat=D_mat/Abs(YdSM)
Do i1=1,3 
 If (D_mat(i1,i1).Gt.0.1_dp*delta0) converge= .False. 
   Do i2=i1+1,3 
    If (D_mat(i1,i2).Gt.10._dp*delta0) converge= .False. 
    If (D_mat(i2,i1).Gt.10._dp*delta0) converge= .False. 
   End Do 
End Do 
D_mat=Abs(Abs(YuSM)-Abs(Y_u_old))
Where (Abs(YuSM).Ne.0._dp) D_mat=D_mat/Abs(YuSM)
Do i1=1,3
 If (D_mat(i1,i1).Gt.0.1_dp*delta0) converge= .False. 
  Do i2=i1+1,3 
   If (D_mat(i1,i2).Gt.10._dp*delta0) converge= .False. 
   If (D_mat(i2,i1).Gt.10._dp*delta0) converge= .False. 
  End Do 
End Do
If (converge) Exit
  Y_l_old=YeSM
  Y_u_old=YuSM
  Y_d_old=YdSM
!-------------------------------------------------- 
!Either we have run into a numerical problem or 
!perturbation theory breaks down 
!-------------------------------------------------- 
If ((Minval(Abs(mf_l_Q/mf_l)).Lt.0.1_dp)&
&.Or.(Maxval(Abs(mf_l_Q/mf_l)).Gt.10._dp)) Then
Iname=Iname-1
kont=-405
Call AddError(405)
    Write(*,*) " Loop corrections to Yukawa couplings at renormalisation scale too large!" 
    Call TerminateProgram
Else If ((Minval(Abs(mf_d_Q/mf_d)).Lt.0.1_dp)&
&.Or.(Minval(Abs(mf_d_Q/mf_d)).Gt.10._dp)) Then
Iname=Iname-1
kont=-406
Call AddError(406)
    Write(*,*) " Loop corrections to Yukawa couplings at renormalisation scale too large!" 
    Call TerminateProgram
Else If ((Minval(Abs(mf_u_Q/mf_u)).Lt.0.1_dp)&
&.Or.(Minval(Abs(mf_u_Q/mf_u)).Gt.10._dp)) Then
Iname=Iname-1
kont=-407
Call AddError(407)
    Write(*,*) " Loop corrections to Yukawa couplings at renormalisation scale too large!" 
    Call TerminateProgram
End If
End Do! i_loop
If ((.Not.converge).and.FermionMassResummation) Then
Write (ErrCan,*)'Problem in subroutine BoundaryEW!!'
Write (ErrCan,*) "After-1 + (i_loop)iterations no convergence of Yukawas"
End If
Yl_Q=YeSM
Yd_Q=YdSM
Yu_Q=YuSM
Call SetMatchingConditions(g1SM,g2SM,g3SM,YuSM,YdSM,YeSM,vSM,Vn,v1,v2,g1,             & 
& g2,g3,l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,hll1,hdp11,hd1,hdtp11,hdt1,hup11,            & 
& hUp1,hdp1,hd2,hdtp1,hdt2,hup21,hUp2,hd3,hdt3,hu11,h12,hU1,hU2,ftri,mu12,               & 
& mu22,mu32,.False.)

Call SetMatchingConditions(g1SM,g2SM,g3SM,YuSM,YdSM,YeSM,vSM,Vn,v1,v2,g1,             & 
& g2,g3,l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,hll1,hdp11,hd1,hdtp11,hdt1,hup11,            & 
& hUp1,hdp1,hd2,hdtp1,hdt2,hup21,hUp2,hd3,hdt3,hu11,h12,hU1,hU2,ftri,mu12,               & 
& mu22,mu32,.False.)

sinW2_Q_mZ=sinW2_Q
vSM_save=vSM
gauge_mZ=gauge

 
 ! --- Boundary conditions at EW-scale --- 
Select Case(BoundaryCondition) 
End Select 

! ----------------------- 
 
Call SolveTadpoleEquations(g1,g2,g3,l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,              & 
& hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,hUp2,hd3,              & 
& hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,Vn,v1,v2,(/ ZeroC, ZeroC, ZeroC /))


 
 ! --- GUT normalize gauge couplings --- 
g1 = 1*g1 
! ----------------------- 
 
Call ParametersToG125(g1,g2,g3,l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,hll1,              & 
& hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,hUp2,hd3,hdt3,              & 
& hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,gMZ)

rMS_SM = 1._dp 
Iname=Iname-1

Contains

Real(dp) Function rho_2(r)
Implicit None
Real(dp),Intent(in)::r
Real(dp)::r2,r3
r2=r*r
r3=r2*r
rho_2=19._dp-16.5_dp*r+43._dp*r2/12._dp&
&+7._dp*r3/120._dp&
&-Pi*Sqrt(r)*(4._dp-1.5_dp*r+3._dp*r2/32._dp&
&+r3/256._dp)&
&-Pi2*(2._dp-2._dp*r+0.5_dp*r2)&
&-Log(r)*(3._dp*r-0.5_dp*r2)
End Function rho_2


Subroutine Yukawas3(mf,vev,uL,uR,SigS,SigL,SigR,MassMatrix,Y,ReSum,kont)
Implicit None
Integer,Intent(inout)::kont
Real(dp),Intent(in)::mf(3),vev
Complex(dp),Dimension(3,3),Intent(in)::uL,uR,SigS,SigL,SigR
Logical,Intent(in)::ReSum
Complex(dp),Intent(inout)::MassMatrix(3,3)
Complex(dp),Intent(out)::Y(3,3)
Integer::i1
Complex(dp),Dimension(3,3)::mass,uLa,uRa,f,invf,invMass2,Ytemp
Call Adjungate(uL,uLa)
Call Adjungate(uR,uRa)
mass=ZeroC
Do i1=1,3
mass(i1,i1)=mf(i1)
End Do
mass=Matmul(Transpose(uL),Matmul(mass,uR))
If (ReSum) Then
kont=0
Call chop(MassMatrix)
invMass2=MassMatrix
Call gaussj(kont,invMass2,3,3)
If (kont.Ne.0) Return
f=id3C-Matmul(SigS,invMass2)-Transpose(SigL)-Matmul(MassMatrix,Matmul(SigR,invMass2))
invf=f
Call gaussj(kont,invf,3,3)
If (kont.Ne.0) Return
Ytemp=Matmul(invf,mass)
Else
Ytemp=mass+SigS+Matmul(Transpose(SigL),MassMatrix)+Matmul(MassMatrix,SigR)
End If
Y=sqrt2*Ytemp(1:3,1:3)/vev
Call chop(y)
End Subroutine Yukawas3

Subroutine Yukawas4(mf,vev,uL,uR,SigS,SigL,SigR,MassMatrix,Y,ReSum,kont)
Implicit None
Integer,Intent(inout)::kont
Real(dp),Intent(in)::mf(4),vev
Complex(dp),Dimension(4,4),Intent(in)::uL,uR,SigS,SigL,SigR
Logical,Intent(in)::ReSum
Complex(dp),Intent(inout)::MassMatrix(4,4)
Complex(dp),Intent(out)::Y(3,3)
Complex(dp) :: Ysave(3,3) 
Integer::i1, i2, ierr
Logical::converged=.false.
Complex(dp),Dimension(4,4) :: mass, uLa, uRa, f, invf, invMass2, Ytemp, & 
 &  uLnew, uRnew, mat2(4,4), mat1(4,4)
Real(dp) :: Mf2_t(4),test2(2),diff(3,3)
Ysave=1._dp 

Do i2=1,100 
  mat1=MassMatrix-SigS-MatMul(SigL,MassMatrix)-MatMul(MassMatrix,SigR) 
  mat2=Matmul(Transpose(Conjg(mat1)),mat1)
  Call EigenSystem(mat2,Mf2_t,uRnew,ierr,test2) 
  mat2=Matmul(mat1,Transpose(Conjg(mat1)))
  Call EigenSystem(mat2,Mf2_t,uLnew,ierr,test2)

  uLnew(1:3,1:3)=uL(1:3,1:3) 
  uRnew(1:3,1:3)=uR(1:3,1:3) 
  mass=0._dp
   Do i1=1,3 
    mass(i1,i1)=mf(i1) 
   End Do

   Do i1=4,4 
    mass(i1,i1)= sqrt(Mf2_t(i1)) 
   End Do

  mass=Matmul(Transpose(uLnew),Matmul(mass,uRnew))
  Ytemp=mass+SigS+Matmul(SigL,MassMatrix)+Matmul(MassMatrix,SigR)
  Y=sqrt2*Ytemp(1:3,1:3)/vev 
  Call chop(y)
  MassMatrix(1:3,1:3)=Ytemp(1:3,1:3)
  diff=Abs(Y-Ysave)
  Where (diff.gt.1.E-10_dp) diff=diff/Y
  Ysave=Y
 If (Maxval(diff).lt.10E-7_dp) Exit
End do 

End Subroutine Yukawas4

Subroutine Yukawas5(mf,vev,uL,uR,SigS,SigL,SigR,MassMatrix,Y,ReSum,kont)
Implicit None
Integer,Intent(inout)::kont
Real(dp),Intent(in)::mf(5),vev
Complex(dp),Dimension(5,5),Intent(in)::uL,uR,SigS,SigL,SigR
Logical,Intent(in)::ReSum
Complex(dp),Intent(inout)::MassMatrix(5,5)
Complex(dp),Intent(out)::Y(3,3)
Complex(dp) :: Ysave(3,3) 
Integer::i1, i2, ierr
Logical::converged=.false.
Complex(dp),Dimension(5,5) :: mass, uLa, uRa, f, invf, invMass2, Ytemp, & 
 &  uLnew, uRnew, mat2(5,5), mat1(5,5)
Real(dp) :: Mf2_t(5),test2(2),diff(3,3)
Ysave=1._dp 

Do i2=1,100 
  mat1=MassMatrix-SigS-MatMul(SigL,MassMatrix)-MatMul(MassMatrix,SigR) 
  mat2=Matmul(Transpose(Conjg(mat1)),mat1)
  Call EigenSystem(mat2,Mf2_t,uRnew,ierr,test2) 
  mat2=Matmul(mat1,Transpose(Conjg(mat1)))
  Call EigenSystem(mat2,Mf2_t,uLnew,ierr,test2)

  uLnew(1:3,1:3)=uL(1:3,1:3) 
  uRnew(1:3,1:3)=uR(1:3,1:3) 
  mass=0._dp
   Do i1=1,3 
    mass(i1,i1)=mf(i1) 
   End Do

   Do i1=4,5 
    mass(i1,i1)= sqrt(Mf2_t(i1)) 
   End Do

  mass=Matmul(Transpose(uLnew),Matmul(mass,uRnew))
  Ytemp=mass+SigS+Matmul(SigL,MassMatrix)+Matmul(MassMatrix,SigR)
  Y=sqrt2*Ytemp(1:3,1:3)/vev 
  Call chop(y)
  MassMatrix(1:3,1:3)=Ytemp(1:3,1:3)
  diff=Abs(Y-Ysave)
  Where (diff.gt.1.E-10_dp) diff=diff/Y
  Ysave=Y
 If (Maxval(diff).lt.10E-7_dp) Exit
End do 

End Subroutine Yukawas5

End Subroutine BoundaryBSM 
 
Subroutine Match_and_Run(delta0,MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,MFe2,MFu,            & 
& MFu2,Mhh,Mhh2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,TW,Ud,              & 
& Ue,Uu,Vd,Ve,Vu,ZA,ZH,ZP,ZW,zy,ZZ,g1,g2,g3,l1,l12,l13,l12t,l13t,l2,l23,l23t,            & 
& l3,hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,hUp2,               & 
& hd3,hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,mGut,kont,WriteComment,niter)

Implicit None
Logical,Intent(in) :: WriteComment
Integer,Intent(inout) :: kont
Integer,Intent(in) :: niter
Real(dp) :: g_SM(62) 
Real(dp) :: delta0,deltaG0, gA(125), gB(125)
Real(dp) :: gC(128),  gD(128) 
Real(dp),Intent(out) :: mGUT
Complex(dp) :: Tad1Loop(3), lambda_SM, lambda_MZ 
Real(dp) :: comp(3), tanbQ, vev2 
Complex(dp) :: cplAhAhUhh(3,3,3),cplAhUhhhh(3,3,3),cplAhUhhVP(3,3),cplAhUhhVZ(3,3),cplAhUhhVZp(3,3), & 
& cplDpmUhhcDpm(2,3,2),cplcFdFdUhhL(5,5,3),cplcFdFdUhhR(5,5,3),cplcFeFeUhhL(3,3,3),      & 
& cplcFeFeUhhR(3,3,3),cplcFuFuUhhL(4,4,3),cplcFuFuUhhR(4,4,3),cplcgWpgWpUhh(3),          & 
& cplcgWCgWCUhh(3),cplcgXp1gXp1Uhh(3),cplcgXp2gXp2Uhh(3),cplcgZgZUhh(3),cplcgZpgZUhh(3), & 
& cplcgZgZpUhh(3),cplcgZpgZpUhh(3),cplUhhhhhh(3,3,3),cplUhhHpmcHpm(3,4,4),               & 
& cplUhhHpmVWp(3,4),cplUhhHpmVXp(3,4),cplUhhVPVZ(3),cplUhhVPVZp(3),cplUhhcVWpVWp(3),     & 
& cplUhhcVXpVXp(3),cplUhhVZVZ(3),cplUhhVZVZp(3),cplUhhVZpVZp(3),cplAhAhUhhUhh(3,3,3,3),  & 
& cplDpmUhhUhhcDpm(2,3,3,2),cplUhhUhhhhhh(3,3,3,3),cplUhhUhhHpmcHpm(3,3,4,4),            & 
& cplUhhUhhVPVP(3,3),cplUhhUhhcVWpVWp(3,3),cplUhhUhhcVXpVXp(3,3),cplUhhUhhVZVZ(3,3),     & 
& cplUhhUhhVZpVZp(3,3)

Real(dp),Intent(inout) :: MAh(3),MAh2(3),MDpm(2),MDpm2(2),MFd(5),MFd2(5),MFe(3),MFe2(3),MFu(4),MFu2(4),         & 
& Mhh(3),Mhh2(3),MHpm(4),MHpm2(4),MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,TW

Complex(dp),Intent(inout) :: Ud(5,5),Ue(3,3),Uu(4,4),Vd(5,5),Ve(3,3),Vu(4,4),ZA(3,3),ZH(3,3),ZP(4,4),              & 
& ZW(4,4),zy(2,2),ZZ(3,3)

Real(dp),Intent(inout) :: g1,g2,g3,ftri,mu12,mu22,mu32

Complex(dp),Intent(inout) :: l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,hll1(3,3),hdp11(3),hd1(3),hdtp11(2),              & 
& hdt1(2),hup11(3),hUp1,hdp1(3),hd2(3),hdtp1(2),hdt2(2),hup21(3),hUp2,hd3(3),            & 
& hdt3(2),hu11(3),h12(3),hU1,hU2

Real(dp) ::mass_new(24),mass_old(24),diff_m(24)
Real(dp) :: tz,dt,q,q2,mudim,mudimNew, vev, sinW2, mh_SM 
Logical::FoundResult, SignMassChangedSave 
Integer::j,n_tot, i_count, i1, i2 
Iname=Iname+1
NameOfUnit(Iname)='Match_and_Run'
kont=0
FoundResult= .False.
n_tot =1
mass_old(n_tot:n_tot+2) = Mhh
n_tot = n_tot + 3 
mass_old(n_tot:n_tot+2) = MAh
n_tot = n_tot + 3 
mass_old(n_tot:n_tot+3) = MHpm
n_tot = n_tot + 4 
mass_old(n_tot:n_tot+1) = MDpm
Write(*,*) "Calculating mass spectrum" 
CalculateOneLoopMassesSave = CalculateOneLoopMasses 
CalculateOneLoopMasses = .false. 
Lambda_MZ = 0.1_dp 
Do j=1,niter 
Write(*,*) "  ", j,".-iteration" 
Write(ErrCan,*) "RGE Running ", j,".-iteration" 
Call BoundarySM(j,Lambda_MZ,delta0,g_SM,kont)

g_SM_save = g_SM 
mudim=GetRenormalizationScale()
mudim=Max(mudim,mZ2)
tz=0.5_dp*Log(mZ2/mudim)
dt=tz/100._dp
g_SM(1) = Sqrt(5._dp/3._dp)*g_SM(1) 
Call odeint(g_SM,62,tz,0._dp,delta0,dt,0._dp,rge62_SM,kont)

g_SM(1) = Sqrt(3._dp/5._dp)*g_SM(1) 
If (kont.Ne.0) Then 
  Iname=Iname-1 
  Write(*,*) " Problem with RGE running. Errorcode:", kont 
  Call TerminateProgram 
End If 
Call BoundaryBSM(j,g_SM,MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,MFe2,MFu,MFu2,               & 
& Mhh,Mhh2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,TW,Ud,Ue,Uu,             & 
& Vd,Ve,Vu,ZA,ZH,ZP,ZW,zy,ZZ,Vn,v1,v2,g1,g2,g3,l1,l12,l13,l12t,l13t,l2,l23,              & 
& l23t,l3,hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,               & 
& hUp2,hd3,hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,delta0,gB,kont)

If (kont.Ne.0) Then
Iname=Iname-1
    Write(*,*) " Problem with boundary conditions at EW scale" 
    Call TerminateProgram
End If
 
mGUT = 1._dp 
Call GToParameters125(gB,g1,g2,g3,l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,hll1,           & 
& hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,hUp2,hd3,hdt3,              & 
& hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32)


 
 ! --- Boundary conditions at SUSY-scale --- 
If (HighScaleModel.ne."LOW") Then 
 else If (HighScaleModel.Eq."LOW") Then 
 ! Setting values 
 Vn = VnIN 
 v1 = v1IN 
 g1 = g1IN 
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
End if
 
 ! ----------------------- 
 

 
 ! --- Remove GUT-normalization of gauge couplings --- 
g1 = 1*g1 
! ----------------------- 
 
Call SolveTadpoleEquations(g1,g2,g3,l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,              & 
& hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,hUp2,hd3,              & 
& hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,Vn,v1,v2,(/ ZeroC, ZeroC, ZeroC /))

If (kont.Ne.0) Then
Iname=Iname-1
    Write(*,*) " RGE running not possible. Errorcode:", kont 
    Call TerminateProgram
End If
Call OneLoopMasses(MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,MFe2,MFu,MFu2,Mhh,Mhh2,           & 
& MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,TW,Ud,Ue,Uu,Vd,Ve,Vu,             & 
& ZA,ZH,ZP,ZW,zy,ZZ,Vn,v1,v2,g1,g2,g3,l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,               & 
& hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,hUp2,hd3,              & 
& hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,kont)

 FirstRun = .False. 
If (kont.Ne.0) Then
Iname=Iname-1
    Write(*,*) " Problem in RGE Running. Errorcode:", kont 
    If (kont.eq.-12) Then 
      Write(*,*) "Stepsize underflow in rkqs (most likely due to a Landau pole) " 
    Else If ((kont.eq.-1).or.(kont.eq.-5).or.(kont.eq.-9)) Then 
      Write(*,*) "Stepsize smaller than minimum." 
    Else If ((kont.eq.-2).or.(kont.eq.-6).or.(kont.eq.-10)) Then 
      Write(*,*) "Running values larger 10^36." 
    Else If ((kont.eq.-3).or.(kont.eq.-7).or.(kont.eq.-11)) Then 
      Write(*,*) "Too many steps: Running has not converged." 
    Else If ((kont.eq.-4).or.(kont.eq.-8)) Then 
      Write(*,*) "No GUT scale found." 
End If
    Call TerminateProgram
End If
n_tot =1
mass_new(n_tot:n_tot+2) = Mhh
n_tot = n_tot + 3 
mass_new(n_tot:n_tot+2) = MAh
n_tot = n_tot + 3 
mass_new(n_tot:n_tot+3) = MHpm
n_tot = n_tot + 4 
mass_new(n_tot:n_tot+1) = MDpm
Where (mass_new.lt.1E-10_dp) mass_new=0._dp 
diff_m=Abs(mass_new-mass_old)
Where (Abs(mass_old).Gt.0._dp) diff_m=diff_m/Abs(mass_old)
deltag0=Maxval(diff_m)
Write(*,*) "  ... reached precision:", deltag0 
If (WriteComment) Write(*,*) "Sugra,Comparing",deltag0
If ((deltag0.Lt.delta0).And.(j.Gt.1)) Then! require at least two iterations
   FoundResult= .True.
If (SignOfMassChanged) Then
  If (.Not.IgnoreNegativeMasses) Then
  Write(*,*) " Mass spectrum converged, but negative mass squared present." 
   Call TerminateProgram 
  Else 
   SignOfMassChanged = .False. 
   kont = 0 
  End If
End If
If (SignOfMuChanged) Then
  If (.Not.IgnoreMuSignFlip) Then
  Write(*,*) " Mass spectrum converged, but negative |mu|^2 from tadpoles." 
   Call TerminateProgram 
  Else 
   SignOfMuChanged = .False. 
   kont = 0 
  End If
End If
Exit
Else
If (SignOfMassChanged) Then
  If ((j.ge.MinimalNumberIterations).And.(.Not.IgnoreNegativeMasses)) Then
  Write(*,*) " Still a negative mass squared after ",MinimalNumberIterations," iterations. Stop calculation. "  
   Call TerminateProgram 
  Else 
   SignOfMassChanged = .False. 
   kont = 0 
  End If
End If
If (SignOfMuChanged) Then
  If ((j.ge.MinimalNumberIterations).And.(.Not.IgnoreMuSignFlip)) Then
  Write(*,*) " Still a negative |mu|^2 after ",MinimalNumberIterations," iterations. Stop calculation. "  
   Call TerminateProgram 
  Else 
   SignOfMuChanged = .False. 
   kont = 0 
  End If
End If
mass_old=mass_new 
If (j.lt.niter) Then 
mudim=GetRenormalizationScale()
mudim=Max(mudim,mZ2)
tz=0.5_dp*Log(mZ2/mudim)
dt=tz/100._dp 
g_SM(1)=g_SM(1)*sqrt(5._dp/3._dp) 
g_SM(4)=Mhh2(1)/g_SM(62)**2 
Call odeint(g_SM,62,0._dp,tz,delta0,dt,0._dp,rge62_SM,kont) 
g_SM(1)=g_SM(1)/sqrt(5._dp/3._dp) 
Lambda_MZ=g_SM(4) 
If (.Not.UseFixedScale) Then 
Call SetRGEScale(mudimNew) 
UseFixedScale= .False. 
End If 
Else
  FoundIterativeSolution = .False. 
End if
End If
End Do
If (CalculateOneLoopMassesSave) Then 
CalculateOneLoopMasses =  CalculateOneLoopMassesSave 
Write(*,*) "Calculate loop corrected masses " 
Call OneLoopMasses(MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,MFe2,MFu,MFu2,Mhh,Mhh2,           & 
& MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,TW,Ud,Ue,Uu,Vd,Ve,Vu,             & 
& ZA,ZH,ZP,ZW,zy,ZZ,Vn,v1,v2,g1,g2,g3,l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,               & 
& hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,hUp2,hd3,              & 
& hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,kont)

If (((Calculate_mh_within_SM).and.(Mhh(2).gt.300._dp)).OR.(Force_mh_within_SM))Then
Write(*,*) "Calculate Higgs mass within effective SM " 
Call Get_mh_pole_SM(g_SM,mudim,delta0,Mhh2(1),mh_SM) 
Mhh2(1) = mh_SM**2 
Mhh(1) = mh_SM 
End if
If (SignOfMassChanged) Then
  If (.Not.IgnoreNegativeMasses) Then
  Write(*,*) " Mass spectrum converged, but negative mass squared present." 
   Call TerminateProgram 
  Else 
   SignOfMassChanged = .False. 
   kont = 0 
  End If
End If
If (SignOfMuChanged) Then
  If (.Not.IgnoreMuSignFlip) Then
  Write(*,*) " Mass spectrum converged, but negative |mu|^2 from tadpoles." 
   Call TerminateProgram 
  Else 
   SignOfMuChanged = .False. 
   kont = 0 
  End If
End If
End if 
Iname=Iname-1
 
End Subroutine Match_and_Run
 
Subroutine FirstGuess(MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,MFe2,MFu,MFu2,Mhh,             & 
& Mhh2,MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,TW,Ud,Ue,Uu,Vd,              & 
& Ve,Vu,ZA,ZH,ZP,ZW,zy,ZZ,Vn,v1,v2,g1,g2,g3,l1,l12,l13,l12t,l13t,l2,l23,l23t,            & 
& l3,hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,hUp2,               & 
& hd3,hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,kont)

Implicit None 
Real(dp),Intent(out) :: g1,g2,g3,ftri,mu12,mu22,mu32

Complex(dp),Intent(out) :: l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,hll1(3,3),hdp11(3),hd1(3),hdtp11(2),              & 
& hdt1(2),hup11(3),hUp1,hdp1(3),hd2(3),hdtp1(2),hdt2(2),hup21(3),hUp2,hd3(3),            & 
& hdt3(2),hu11(3),h12(3),hU1,hU2

Real(dp),Intent(out) :: MAh(3),MAh2(3),MDpm(2),MDpm2(2),MFd(5),MFd2(5),MFe(3),MFe2(3),MFu(4),MFu2(4),         & 
& Mhh(3),Mhh2(3),MHpm(4),MHpm2(4),MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,TW

Complex(dp),Intent(out) :: Ud(5,5),Ue(3,3),Uu(4,4),Vd(5,5),Ve(3,3),Vu(4,4),ZA(3,3),ZH(3,3),ZP(4,4),              & 
& ZW(4,4),zy(2,2),ZZ(3,3)

Integer,Intent(inout)::kont
Integer :: i1, i2
Real(dp),Intent(inout) :: Vn,v1,v2

Real(dp)::vev,vevs(2),vev2,mgut,mudim,mudimNew,sigma(2),cosW,cosW2,sinW2 
Complex(dp):: YeSM(3,3), YdSM(3,3), YuSM(3,3) 
Real(dp) :: k_fac, g1SM, g2SM, g3SM, vSM 
Real(dp), Parameter :: oo2pi=1._dp/(2._dp*pi),oo6pi=oo2pi/3._dp 
Real(dp):: gA(125), gB(125), Scale_Save 
Logical::TwoLoopRGE_save, UseFixedScale_save 
Real(dp) :: VEVSM1,VEVSM2,VEVSM1MZ,VEVSM2MZ 
Iname=Iname+1 
NameOfUnit(Iname)="FirstGuess" 
If (HighScaleModel.eq."LOW") UseFixedGUTScale = .true. 

mW2=mZ2*(0.5_dp+Sqrt(0.25_dp-Alpha_Mz*pi/(sqrt2*G_F*mZ2)))
mW=Sqrt(mW2) 
cosW2=mw2/mZ2 
sinW2=1._dp-cosW2 
cosW=Sqrt(cosW2) 
 
g1SM=Sqrt(3._dp/5._dp)*Sqrt(20._dp*pi*alpha_mZ/(3._dp*(1._dp-sinW2))) 
g2SM=Sqrt(4._dp*pi*alpha_mZ/(sinW2)) 
g3SM=Sqrt(4._dp*pi*alphas_mZ) 
vSM=2._dp*mW/g2SM 
YeSM=0._dp 
YdSM=0._dp 
YuSM=0._dp 
Do i1=1,3 
  YeSM(i1,i1)=sqrt2*mf_L_mZ(i1)/vSM 
  If (i1.Eq.3) Then! top and bottom are special: 
  ! TanBeta Aufsummierung fehlt bei Yd!! 
  YuSM(i1,i1)=sqrt2*mf_U(i1)/vSM& 
    &*(1._dp-oo3pi*alphas_mZ*(5._dp+3._dp*Log(mZ2/mf_u2(3)))) 
  YdSM(i1,i1)=sqrt2*mf_D_mZ(i1)/(vSM * (1._dp + 0.015*tanb)) 
Else 
  YuSM(i1,i1)=sqrt2*mf_U_mZ(i1)/vSM 
  YdSM(i1,i1)=sqrt2*mf_D_mZ(i1)/vSM 
End If  
End Do 
If (GenerationMixing) Then 
  If (YukawaScheme.Eq.1) Then 
    YuSM=Matmul(Transpose(CKM),YuSM) 
  Else 
    YdSM=Matmul(Conjg(CKM),YdSM) 
  End If 
End If 
Call SetMatchingConditions(g1SM,g2SM,g3SM,YuSM,YdSM,YeSM,vSM,Vn,v1,v2,g1,             & 
& g2,g3,l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,hll1,hdp11,hd1,hdtp11,hdt1,hup11,            & 
& hUp1,hdp1,hd2,hdtp1,hdt2,hup21,hUp2,hd3,hdt3,hu11,h12,hU1,hU2,ftri,mu12,               & 
& mu22,mu32,.False.)


 
 ! --- Boundary conditions at SUSY-scale --- 
If (HighScaleModel.ne."LOW") Then 
 else If (HighScaleModel.Eq."LOW") Then 
 ! Setting values 
 Vn = VnIN 
 v1 = v1IN 
 g1 = g1IN 
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
End if
 
 ! ----------------------- 
 
Call SolveTadpoleEquations(g1,g2,g3,l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,              & 
& hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,hUp2,hd3,              & 
& hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,Vn,v1,v2,(/ ZeroC, ZeroC, ZeroC /))

Call TreeMasses(MAh,MAh2,MDpm,MDpm2,MFd,MFd2,MFe,MFe2,MFu,MFu2,Mhh,Mhh2,              & 
& MHpm,MHpm2,MVWp,MVWp2,MVXp,MVXp2,MVZ,MVZ2,MVZp,MVZp2,TW,Ud,Ue,Uu,Vd,Ve,Vu,             & 
& ZA,ZH,ZP,ZW,zy,ZZ,Vn,v1,v2,g1,g2,g3,l1,l12,l13,l12t,l13t,l2,l23,l23t,l3,               & 
& hll1,hdp11,hd1,hdtp11,hdt1,hup11,hUp1,hdp1,hd2,hdtp1,hdt2,hup21,hUp2,hd3,              & 
& hdt3,hu11,h12,hU1,hU2,ftri,mu12,mu22,mu32,GenerationMixing,kont)

MVWp = mW 
MVWp2 = mW2 
MVZ = mZ 
MVZ2 = mZ2 
MFe(1:3) = mf_l 
MFe2(1:3) = mf_l**2 
MFu(1:3) = mf_u 
MFu2(1:3) = mf_u**2 
MFd(1:3) = mf_d 
MFd2(1:3) = mf_d**2 
Iname=Iname-1 
End subroutine FirstGuess 
End Module Boundaries_331v3 
