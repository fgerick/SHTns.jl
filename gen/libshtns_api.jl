# Julia wrapper for header: shtns.h
# Automatically generated using Clang.jl


function nlm_calc(lmax, mmax, mres)
    ccall((:nlm_calc, libshtns), Clong, (Clong, Clong, Clong), lmax, mmax, mres)
end

function nlm_cplx_calc(lmax, mmax, mres)
    ccall((:nlm_cplx_calc, libshtns), Clong, (Clong, Clong, Clong), lmax, mmax, mres)
end

function shtns_verbose(arg1)
    ccall((:shtns_verbose, libshtns), Cvoid, (Cint,), arg1)
end

function shtns_print_version()
    ccall((:shtns_print_version, libshtns), Cvoid, ())
end

function shtns_print_cfg(arg1)
    ccall((:shtns_print_cfg, libshtns), Cvoid, (shtns_cfg,), arg1)
end

function shtns_init(flags, lmax, mmax, mres, nlat, nphi)
    ccall((:shtns_init, libshtns), shtns_cfg, (shtns_type, Cint, Cint, Cint, Cint, Cint), flags, lmax, mmax, mres, nlat, nphi)
end

function shtns_create(lmax, mmax, mres, norm)
    ccall((:shtns_create, libshtns), shtns_cfg, (Cint, Cint, Cint, shtns_norm), lmax, mmax, mres, norm)
end

function shtns_set_grid(arg1, flags, eps, nlat, nphi)
    ccall((:shtns_set_grid, libshtns), Cint, (shtns_cfg, shtns_type, Cdouble, Cint, Cint), arg1, flags, eps, nlat, nphi)
end

function shtns_set_grid_auto(arg1, flags, eps, nl_order, nlat, nphi)
    ccall((:shtns_set_grid_auto, libshtns), Cint, (shtns_cfg, shtns_type, Cdouble, Cint, Ptr{Cint}, Ptr{Cint}), arg1, flags, eps, nl_order, nlat, nphi)
end

function shtns_create_with_grid(arg1, mmax, nofft)
    ccall((:shtns_create_with_grid, libshtns), shtns_cfg, (shtns_cfg, Cint, Cint), arg1, mmax, nofft)
end

function shtns_use_threads(num_threads)
    ccall((:shtns_use_threads, libshtns), Cint, (Cint,), num_threads)
end

function shtns_use_gpu(device_id)
    ccall((:shtns_use_gpu, libshtns), Cint, (Cint,), device_id)
end

function shtns_reset()
    ccall((:shtns_reset, libshtns), Cvoid, ())
end

function shtns_destroy(arg1)
    ccall((:shtns_destroy, libshtns), Cvoid, (shtns_cfg,), arg1)
end

function shtns_unset_grid(arg1)
    ccall((:shtns_unset_grid, libshtns), Cvoid, (shtns_cfg,), arg1)
end

function shtns_robert_form(arg1, robert)
    ccall((:shtns_robert_form, libshtns), Cvoid, (shtns_cfg, Cint), arg1, robert)
end

function shtns_malloc(bytes)
    ccall((:shtns_malloc, libshtns), Ptr{Cvoid}, (Cint,), bytes)
end

function shtns_free(p)
    ccall((:shtns_free, libshtns), Cvoid, (Ptr{Cvoid},), p)
end

function sh00_1(arg1)
    ccall((:sh00_1, libshtns), Cdouble, (shtns_cfg,), arg1)
end

function sh10_ct(arg1)
    ccall((:sh10_ct, libshtns), Cdouble, (shtns_cfg,), arg1)
end

function sh11_st(arg1)
    ccall((:sh11_st, libshtns), Cdouble, (shtns_cfg,), arg1)
end

function shlm_e1(arg1, l, m)
    ccall((:shlm_e1, libshtns), Cdouble, (shtns_cfg, Cint, Cint), arg1, l, m)
end

function shtns_gauss_wts(arg1, wts)
    ccall((:shtns_gauss_wts, libshtns), Cint, (shtns_cfg, Ptr{Cdouble}), arg1, wts)
end

function SH_Zrotate(arg1, Qlm, alpha, Rlm)
    ccall((:SH_Zrotate, libshtns), Cvoid, (shtns_cfg, Ptr{Cint}, Cdouble, Ptr{Cint}), arg1, Qlm, alpha, Rlm)
end

function SH_Yrotate(arg1, Qlm, alpha, Rlm)
    ccall((:SH_Yrotate, libshtns), Cvoid, (shtns_cfg, Ptr{Cint}, Cdouble, Ptr{Cint}), arg1, Qlm, alpha, Rlm)
end

function SH_Yrotate90(arg1, Qlm, Rlm)
    ccall((:SH_Yrotate90, libshtns), Cvoid, (shtns_cfg, Ptr{Cint}, Ptr{Cint}), arg1, Qlm, Rlm)
end

function SH_Xrotate90(arg1, Qlm, Rlm)
    ccall((:SH_Xrotate90, libshtns), Cvoid, (shtns_cfg, Ptr{Cint}, Ptr{Cint}), arg1, Qlm, Rlm)
end

function shtns_rotation_create(lmax, mmax)
    ccall((:shtns_rotation_create, libshtns), shtns_rot, (Cint, Cint), lmax, mmax)
end

function shtns_rotation_destroy(r)
    ccall((:shtns_rotation_destroy, libshtns), Cvoid, (shtns_rot,), r)
end

function shtns_rotation_set_angles_ZYZ(r, alpha, beta, gamma)
    ccall((:shtns_rotation_set_angles_ZYZ, libshtns), Cvoid, (shtns_rot, Cdouble, Cdouble, Cdouble), r, alpha, beta, gamma)
end

function shtns_rotation_set_angles_ZXZ(r, alpha, beta, gamma)
    ccall((:shtns_rotation_set_angles_ZXZ, libshtns), Cvoid, (shtns_rot, Cdouble, Cdouble, Cdouble), r, alpha, beta, gamma)
end

function shtns_rotation_set_angle_axis(r, theta, Vx, Vy, Vz)
    ccall((:shtns_rotation_set_angle_axis, libshtns), Cvoid, (shtns_rot, Cdouble, Cdouble, Cdouble, Cdouble), r, theta, Vx, Vy, Vz)
end

function shtns_rotation_wigner_d_matrix(r, l, mx)
    ccall((:shtns_rotation_wigner_d_matrix, libshtns), Cvoid, (shtns_rot, Cint, Ptr{Cdouble}), r, l, mx)
end

function shtns_rotation_apply_cplx(r, Zlm, Rlm)
    ccall((:shtns_rotation_apply_cplx, libshtns), Cvoid, (shtns_rot, Ptr{Cint}, Ptr{Cint}), r, Zlm, Rlm)
end

function shtns_rotation_apply_real(r, Qlm, Rlm)
    ccall((:shtns_rotation_apply_real, libshtns), Cvoid, (shtns_rot, Ptr{Cint}, Ptr{Cint}), r, Qlm, Rlm)
end

function legendre_sphPlm_array(shtns, lmax, im, x, yl)
    ccall((:legendre_sphPlm_array, libshtns), Cvoid, (shtns_cfg, Cint, Cint, Cdouble, Ptr{Cdouble}), shtns, lmax, im, x, yl)
end

function legendre_sphPlm_deriv_array(shtns, lmax, im, x, sint, yl, dyl)
    ccall((:legendre_sphPlm_deriv_array, libshtns), Cvoid, (shtns_cfg, Cint, Cint, Cdouble, Cdouble, Ptr{Cdouble}, Ptr{Cdouble}), shtns, lmax, im, x, sint, yl, dyl)
end

function mul_ct_matrix(arg1, mx)
    ccall((:mul_ct_matrix, libshtns), Cvoid, (shtns_cfg, Ptr{Cdouble}), arg1, mx)
end

function st_dt_matrix(arg1, mx)
    ccall((:st_dt_matrix, libshtns), Cvoid, (shtns_cfg, Ptr{Cdouble}), arg1, mx)
end

function SH_mul_mx(arg1, mx, Qlm, Rlm)
    ccall((:SH_mul_mx, libshtns), Cvoid, (shtns_cfg, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint}), arg1, mx, Qlm, Rlm)
end

function spat_to_SH(shtns, Vr, Qlm)
    ccall((:spat_to_SH, libshtns), Cvoid, (shtns_cfg, Ptr{Cdouble}, Ptr{Cint}), shtns, Vr, Qlm)
end

function SH_to_spat(shtns, Qlm, Vr)
    ccall((:SH_to_spat, libshtns), Cvoid, (shtns_cfg, Ptr{Cint}, Ptr{Cdouble}), shtns, Qlm, Vr)
end

function SH_to_spat_cplx(shtns, alm, z)
    ccall((:SH_to_spat_cplx, libshtns), Cvoid, (shtns_cfg, Ptr{Cint}, Ptr{Cint}), shtns, alm, z)
end

function spat_cplx_to_SH(shtns, z, alm)
    ccall((:spat_cplx_to_SH, libshtns), Cvoid, (shtns_cfg, Ptr{Cint}, Ptr{Cint}), shtns, z, alm)
end

function spat_to_SHsphtor(arg1, Vt, Vp, Slm, Tlm)
    ccall((:spat_to_SHsphtor, libshtns), Cvoid, (shtns_cfg, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint}), arg1, Vt, Vp, Slm, Tlm)
end

function SHsphtor_to_spat(arg1, Slm, Tlm, Vt, Vp)
    ccall((:SHsphtor_to_spat, libshtns), Cvoid, (shtns_cfg, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble}), arg1, Slm, Tlm, Vt, Vp)
end

function SHsph_to_spat(arg1, Slm, Vt, Vp)
    ccall((:SHsph_to_spat, libshtns), Cvoid, (shtns_cfg, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble}), arg1, Slm, Vt, Vp)
end

function SHtor_to_spat(arg1, Tlm, Vt, Vp)
    ccall((:SHtor_to_spat, libshtns), Cvoid, (shtns_cfg, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble}), arg1, Tlm, Vt, Vp)
end

function spat_cplx_to_SHsphtor(arg1, Vt, Vp, Slm, Tlm)
    ccall((:spat_cplx_to_SHsphtor, libshtns), Cvoid, (shtns_cfg, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), arg1, Vt, Vp, Slm, Tlm)
end

function SHsphtor_to_spat_cplx(arg1, Slm, Tlm, Vt, Vp)
    ccall((:SHsphtor_to_spat_cplx, libshtns), Cvoid, (shtns_cfg, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), arg1, Slm, Tlm, Vt, Vp)
end

function spat_to_SHqst(arg1, Vr, Vt, Vp, Qlm, Slm, Tlm)
    ccall((:spat_to_SHqst, libshtns), Cvoid, (shtns_cfg, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), arg1, Vr, Vt, Vp, Qlm, Slm, Tlm)
end

function SHqst_to_spat(arg1, Qlm, Slm, Tlm, Vr, Vt, Vp)
    ccall((:SHqst_to_spat, libshtns), Cvoid, (shtns_cfg, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}), arg1, Qlm, Slm, Tlm, Vr, Vt, Vp)
end

function spat_cplx_to_SHqst(arg1, Vr, Vt, Vp, Qlm, Slm, Tlm)
    ccall((:spat_cplx_to_SHqst, libshtns), Cvoid, (shtns_cfg, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), arg1, Vr, Vt, Vp, Qlm, Slm, Tlm)
end

function SHqst_to_spat_cplx(arg1, Qlm, Slm, Tlm, Vr, Vt, Vp)
    ccall((:SHqst_to_spat_cplx, libshtns), Cvoid, (shtns_cfg, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), arg1, Qlm, Slm, Tlm, Vr, Vt, Vp)
end

function spat_to_SH_l(arg1, Vr, Qlm, ltr)
    ccall((:spat_to_SH_l, libshtns), Cvoid, (shtns_cfg, Ptr{Cdouble}, Ptr{Cint}, Cint), arg1, Vr, Qlm, ltr)
end

function SH_to_spat_l(arg1, Qlm, Vr, ltr)
    ccall((:SH_to_spat_l, libshtns), Cvoid, (shtns_cfg, Ptr{Cint}, Ptr{Cdouble}, Cint), arg1, Qlm, Vr, ltr)
end

function SHsphtor_to_spat_l(arg1, Slm, Tlm, Vt, Vp, ltr)
    ccall((:SHsphtor_to_spat_l, libshtns), Cvoid, (shtns_cfg, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble}, Cint), arg1, Slm, Tlm, Vt, Vp, ltr)
end

function SHsph_to_spat_l(arg1, Slm, Vt, Vp, ltr)
    ccall((:SHsph_to_spat_l, libshtns), Cvoid, (shtns_cfg, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble}, Cint), arg1, Slm, Vt, Vp, ltr)
end

function SHtor_to_spat_l(arg1, Tlm, Vt, Vp, ltr)
    ccall((:SHtor_to_spat_l, libshtns), Cvoid, (shtns_cfg, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble}, Cint), arg1, Tlm, Vt, Vp, ltr)
end

function spat_to_SHsphtor_l(arg1, Vt, Vp, Slm, Tlm, ltr)
    ccall((:spat_to_SHsphtor_l, libshtns), Cvoid, (shtns_cfg, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint}, Cint), arg1, Vt, Vp, Slm, Tlm, ltr)
end

function spat_to_SHqst_l(arg1, Vr, Vt, Vp, Qlm, Slm, Tlm, ltr)
    ccall((:spat_to_SHqst_l, libshtns), Cvoid, (shtns_cfg, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Cint), arg1, Vr, Vt, Vp, Qlm, Slm, Tlm, ltr)
end

function SHqst_to_spat_l(arg1, Qlm, Slm, Tlm, Vr, Vt, Vp, ltr)
    ccall((:SHqst_to_spat_l, libshtns), Cvoid, (shtns_cfg, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}, Cint), arg1, Qlm, Slm, Tlm, Vr, Vt, Vp, ltr)
end

function spat_to_SH_ml(arg1, im, Vr, Ql, ltr)
    ccall((:spat_to_SH_ml, libshtns), Cvoid, (shtns_cfg, Cint, Ptr{Cint}, Ptr{Cint}, Cint), arg1, im, Vr, Ql, ltr)
end

function SH_to_spat_ml(arg1, im, Ql, Vr, ltr)
    ccall((:SH_to_spat_ml, libshtns), Cvoid, (shtns_cfg, Cint, Ptr{Cint}, Ptr{Cint}, Cint), arg1, im, Ql, Vr, ltr)
end

function spat_to_SHsphtor_ml(arg1, im, Vt, Vp, Sl, Tl, ltr)
    ccall((:spat_to_SHsphtor_ml, libshtns), Cvoid, (shtns_cfg, Cint, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Cint), arg1, im, Vt, Vp, Sl, Tl, ltr)
end

function SHsphtor_to_spat_ml(arg1, im, Sl, Tl, Vt, Vp, ltr)
    ccall((:SHsphtor_to_spat_ml, libshtns), Cvoid, (shtns_cfg, Cint, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Cint), arg1, im, Sl, Tl, Vt, Vp, ltr)
end

function SHsph_to_spat_ml(arg1, im, Sl, Vt, Vp, ltr)
    ccall((:SHsph_to_spat_ml, libshtns), Cvoid, (shtns_cfg, Cint, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Cint), arg1, im, Sl, Vt, Vp, ltr)
end

function SHtor_to_spat_ml(arg1, im, Tl, Vt, Vp, ltr)
    ccall((:SHtor_to_spat_ml, libshtns), Cvoid, (shtns_cfg, Cint, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Cint), arg1, im, Tl, Vt, Vp, ltr)
end

function spat_to_SHqst_ml(arg1, im, Vr, Vt, Vp, Ql, Sl, Tl, ltr)
    ccall((:spat_to_SHqst_ml, libshtns), Cvoid, (shtns_cfg, Cint, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Cint), arg1, im, Vr, Vt, Vp, Ql, Sl, Tl, ltr)
end

function SHqst_to_spat_ml(arg1, im, Ql, Sl, Tl, Vr, Vt, Vp, ltr)
    ccall((:SHqst_to_spat_ml, libshtns), Cvoid, (shtns_cfg, Cint, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Cint), arg1, im, Ql, Sl, Tl, Vr, Vt, Vp, ltr)
end

function SH_to_point(arg1, Qlm, cost, phi)
    ccall((:SH_to_point, libshtns), Cdouble, (shtns_cfg, Ptr{Cint}, Cdouble, Cdouble), arg1, Qlm, cost, phi)
end

function SH_to_grad_point(arg1, DrSlm, Slm, cost, phi, vr, vt, vp)
    ccall((:SH_to_grad_point, libshtns), Cvoid, (shtns_cfg, Ptr{Cint}, Ptr{Cint}, Cdouble, Cdouble, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}), arg1, DrSlm, Slm, cost, phi, vr, vt, vp)
end

function SHqst_to_point(arg1, Qlm, Slm, Tlm, cost, phi, vr, vt, vp)
    ccall((:SHqst_to_point, libshtns), Cvoid, (shtns_cfg, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Cdouble, Cdouble, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}), arg1, Qlm, Slm, Tlm, cost, phi, vr, vt, vp)
end

function SH_to_lat(shtns, Qlm, cost, vr, nphi, ltr, mtr)
    ccall((:SH_to_lat, libshtns), Cvoid, (shtns_cfg, Ptr{Cint}, Cdouble, Ptr{Cdouble}, Cint, Cint, Cint), shtns, Qlm, cost, vr, nphi, ltr, mtr)
end

function SHqst_to_lat(arg1, Qlm, Slm, Tlm, cost, vr, vt, vp, nphi, ltr, mtr)
    ccall((:SHqst_to_lat, libshtns), Cvoid, (shtns_cfg, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Cdouble, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}, Cint, Cint, Cint), arg1, Qlm, Slm, Tlm, cost, vr, vt, vp, nphi, ltr, mtr)
end
