#direct bindings to SHTns generated with Clang.jl

function SHsph_to_spat(cfg, Slm, Vt, Vp)
    ccall((:SHsph_to_spat, libshtns[]), Cvoid, (shtns_cfg, Ptr{cplx}, Ptr{Cdouble}, Ptr{Cdouble}), cfg, Slm, Vt, Vp)
end

function SHsph_to_spat_l(cfg, Slm, Vt, Vp, ltr)
    ccall((:SHsph_to_spat_l, libshtns[]), Cvoid, (shtns_cfg, Ptr{cplx}, Ptr{Cdouble}, Ptr{Cdouble}, Cint), cfg, Slm, Vt, Vp, ltr)
end

function SHsph_to_spat_ml(cfg, im, Sl, Vt, Vp, ltr)
    ccall((:SHsph_to_spat_ml, libshtns[]), Cvoid, (shtns_cfg, Cint, Ptr{cplx}, Ptr{cplx}, Ptr{cplx}, Cint), cfg, im, Sl, Vt, Vp, ltr)
end

function nlm_calc(lmax, mmax, mres)
    ccall((:nlm_calc, libshtns[]), Clong, (Clong, Clong, Clong), lmax, mmax, mres)
end

function nlm_cplx_calc(lmax, mmax, mres)
    ccall((:nlm_cplx_calc, libshtns[]), Clong, (Clong, Clong, Clong), lmax, mmax, mres)
end

function shtns_verbose(cfg)
    ccall((:shtns_verbose, libshtns[]), Cvoid, (Cint,), cfg)
end

function shtns_print_version()
    ccall((:shtns_print_version, libshtns[]), Cvoid, ())
end

function shtns_get_build_info()
    ccall((:shtns_get_build_info, libshtns[]), Ptr{Cchar}, ())
end

function shtns_print_cfg(cfg)
    ccall((:shtns_print_cfg, libshtns[]), Cvoid, (shtns_cfg,), cfg)
end

function shtns_init(flags, lmax, mmax, mres, nlat, nphi)
    ccall((:shtns_init, libshtns[]), shtns_cfg, (shtns_type, Cint, Cint, Cint, Cint, Cint), flags, lmax, mmax, mres, nlat, nphi)
end

function shtns_create(lmax, mmax, mres, norm)
    ccall((:shtns_create, libshtns[]), shtns_cfg, (Cint, Cint, Cint, shtns_norm), lmax, mmax, mres, norm)
end

function shtns_set_grid(cfg, flags, eps, nlat, nphi)
    ccall((:shtns_set_grid, libshtns[]), Cint, (shtns_cfg, shtns_type, Cdouble, Cint, Cint), cfg, flags, eps, nlat, nphi)
end

function shtns_set_grid_auto(cfg, flags, eps, nl_order, nlat, nphi)
    ccall((:shtns_set_grid_auto, libshtns[]), Cint, (shtns_cfg, shtns_type, Cdouble, Cint, Ptr{Cuint}, Ptr{Cuint}), cfg, flags, eps, nl_order, nlat, nphi)
end

function shtns_create_with_grid(cfg, mmax, nofft)
    ccall((:shtns_create_with_grid, libshtns[]), shtns_cfg, (shtns_cfg, Cint, Cint), cfg, mmax, nofft)
end

function shtns_use_threads(num_threads)
    ccall((:shtns_use_threads, libshtns[]), Cint, (Cint,), num_threads)
end

function shtns_use_gpu(device_id)
    ccall((:shtns_use_gpu, libshtns[]), Cint, (Cint,), device_id)
end

function shtns_reset()
    ccall((:shtns_reset, libshtns[]), Cvoid, ())
end

function shtns_destroy(cfg)
    ccall((:shtns_destroy, libshtns[]), Cvoid, (shtns_cfg,), cfg)
end

function shtns_unset_grid(cfg)
    ccall((:shtns_unset_grid, libshtns[]), Cvoid, (shtns_cfg,), cfg)
end

function shtns_robert_form(cfg, robert)
    ccall((:shtns_robert_form, libshtns[]), Cvoid, (shtns_cfg, Cint), cfg, robert)
end

function shtns_malloc(bytes)
    ccall((:shtns_malloc, libshtns[]), Ptr{Cvoid}, (Cint,), bytes)
end

function shtns_free(p)
    ccall((:shtns_free, libshtns[]), Cvoid, (Ptr{Cvoid},), p)
end

function sh00_1(cfg)
    ccall((:sh00_1, libshtns[]), Cdouble, (shtns_cfg,), cfg)
end

function sh10_ct(cfg)
    ccall((:sh10_ct, libshtns[]), Cdouble, (shtns_cfg,), cfg)
end

function sh11_st(cfg)
    ccall((:sh11_st, libshtns[]), Cdouble, (shtns_cfg,), cfg)
end

function shlm_e1(cfg, l, m)
    ccall((:shlm_e1, libshtns[]), Cdouble, (shtns_cfg, Cint, Cint), cfg, l, m)
end

function shtns_gauss_wts(cfg, wts)
    ccall((:shtns_gauss_wts, libshtns[]), Cint, (shtns_cfg, Ptr{Cdouble}), cfg, wts)
end

function SH_Zrotate(cfg, Qlm, alpha, Rlm)
    ccall((:SH_Zrotate, libshtns[]), Cvoid, (shtns_cfg, Ptr{cplx}, Cdouble, Ptr{cplx}), cfg, Qlm, alpha, Rlm)
end

function SH_Yrotate(cfg, Qlm, alpha, Rlm)
    ccall((:SH_Yrotate, libshtns[]), Cvoid, (shtns_cfg, Ptr{cplx}, Cdouble, Ptr{cplx}), cfg, Qlm, alpha, Rlm)
end

function SH_Yrotate90(cfg, Qlm, Rlm)
    ccall((:SH_Yrotate90, libshtns[]), Cvoid, (shtns_cfg, Ptr{cplx}, Ptr{cplx}), cfg, Qlm, Rlm)
end

function SH_Xrotate90(cfg, Qlm, Rlm)
    ccall((:SH_Xrotate90, libshtns[]), Cvoid, (shtns_cfg, Ptr{cplx}, Ptr{cplx}), cfg, Qlm, Rlm)
end

function shtns_rotation_create(lmax, mmax, norm)
    ccall((:shtns_rotation_create, libshtns[]), shtns_rot, (Cint, Cint, Cint), lmax, mmax, norm)
end

function shtns_rotation_destroy(r)
    ccall((:shtns_rotation_destroy, libshtns[]), Cvoid, (shtns_rot,), r)
end

function shtns_rotation_set_angles_ZYZ(r, alpha, beta, gamma)
    ccall((:shtns_rotation_set_angles_ZYZ, libshtns[]), Cvoid, (shtns_rot, Cdouble, Cdouble, Cdouble), r, alpha, beta, gamma)
end

function shtns_rotation_set_angles_ZXZ(r, alpha, beta, gamma)
    ccall((:shtns_rotation_set_angles_ZXZ, libshtns[]), Cvoid, (shtns_rot, Cdouble, Cdouble, Cdouble), r, alpha, beta, gamma)
end

function shtns_rotation_set_angle_axis(r, theta, Vx, Vy, Vz)
    ccall((:shtns_rotation_set_angle_axis, libshtns[]), Cvoid, (shtns_rot, Cdouble, Cdouble, Cdouble, Cdouble), r, theta, Vx, Vy, Vz)
end

function shtns_rotation_wigner_d_matrix(r, l, mx)
    ccall((:shtns_rotation_wigner_d_matrix, libshtns[]), Cint, (shtns_rot, Cint, Ptr{Cdouble}), r, l, mx)
end

function shtns_rotation_apply_cplx(r, Zlm, Rlm)
    ccall((:shtns_rotation_apply_cplx, libshtns[]), Cvoid, (shtns_rot, Ptr{cplx}, Ptr{cplx}), r, Zlm, Rlm)
end

function shtns_rotation_apply_real(r, Qlm, Rlm)
    ccall((:shtns_rotation_apply_real, libshtns[]), Cvoid, (shtns_rot, Ptr{cplx}, Ptr{cplx}), r, Qlm, Rlm)
end

function legendre_sphPlm_array(shtns, lmax, im, x, yl)
    ccall((:legendre_sphPlm_array, libshtns[]), Cint, (shtns_cfg, Cint, Cint, Cdouble, Ptr{Cdouble}), shtns, lmax, im, x, yl)
end

function legendre_sphPlm_deriv_array(shtns, lmax, im, x, sint, yl, dyl)
    ccall((:legendre_sphPlm_deriv_array, libshtns[]), Cint, (shtns_cfg, Cint, Cint, Cdouble, Cdouble, Ptr{Cdouble}, Ptr{Cdouble}), shtns, lmax, im, x, sint, yl, dyl)
end

function mul_ct_matrix(cfg, mx)
    ccall((:mul_ct_matrix, libshtns[]), Cvoid, (shtns_cfg, Ptr{Cdouble}), cfg, mx)
end

function st_dt_matrix(cfg, mx)
    ccall((:st_dt_matrix, libshtns[]), Cvoid, (shtns_cfg, Ptr{Cdouble}), cfg, mx)
end

function SH_mul_mx(cfg, mx, Qlm, Rlm)
    ccall((:SH_mul_mx, libshtns[]), Cvoid, (shtns_cfg, Ptr{Cdouble}, Ptr{cplx}, Ptr{cplx}), cfg, mx, Qlm, Rlm)
end

function spat_to_SH(shtns, Vr, Qlm)
    ccall((:spat_to_SH, libshtns[]), Cvoid, (shtns_cfg, Ptr{Cdouble}, Ptr{cplx}), shtns, Vr, Qlm)
end

function SH_to_spat(shtns, Qlm, Vr)
    ccall((:SH_to_spat, libshtns[]), Cvoid, (shtns_cfg, Ptr{cplx}, Ptr{Cdouble}), shtns, Qlm, Vr)
end

function SH_to_spat_cplx(shtns, alm, z)
    ccall((:SH_to_spat_cplx, libshtns[]), Cvoid, (shtns_cfg, Ptr{cplx}, Ptr{cplx}), shtns, alm, z)
end

function spat_cplx_to_SH(shtns, z, alm)
    ccall((:spat_cplx_to_SH, libshtns[]), Cvoid, (shtns_cfg, Ptr{cplx}, Ptr{cplx}), shtns, z, alm)
end

function spat_to_SHsphtor(cfg, Vt, Vp, Slm, Tlm)
    ccall((:spat_to_SHsphtor, libshtns[]), Cvoid, (shtns_cfg, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{cplx}, Ptr{cplx}), cfg, Vt, Vp, Slm, Tlm)
end

function SHsphtor_to_spat(cfg, Slm, Tlm, Vt, Vp)
    ccall((:SHsphtor_to_spat, libshtns[]), Cvoid, (shtns_cfg, Ptr{cplx}, Ptr{cplx}, Ptr{Cdouble}, Ptr{Cdouble}), cfg, Slm, Tlm, Vt, Vp)
end

function SHtor_to_spat(cfg, Tlm, Vt, Vp)
    ccall((:SHtor_to_spat, libshtns[]), Cvoid, (shtns_cfg, Ptr{cplx}, Ptr{Cdouble}, Ptr{Cdouble}), cfg, Tlm, Vt, Vp)
end

function spat_cplx_to_SHsphtor(cfg, Vt, Vp, Slm, Tlm)
    ccall((:spat_cplx_to_SHsphtor, libshtns[]), Cvoid, (shtns_cfg, Ptr{cplx}, Ptr{cplx}, Ptr{cplx}, Ptr{cplx}), cfg, Vt, Vp, Slm, Tlm)
end

function SHsphtor_to_spat_cplx(cfg, Slm, Tlm, Vt, Vp)
    ccall((:SHsphtor_to_spat_cplx, libshtns[]), Cvoid, (shtns_cfg, Ptr{cplx}, Ptr{cplx}, Ptr{cplx}, Ptr{cplx}), cfg, Slm, Tlm, Vt, Vp)
end

function spat_to_SHqst(cfg, Vr, Vt, Vp, Qlm, Slm, Tlm)
    ccall((:spat_to_SHqst, libshtns[]), Cvoid, (shtns_cfg, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{cplx}, Ptr{cplx}, Ptr{cplx}), cfg, Vr, Vt, Vp, Qlm, Slm, Tlm)
end

function SHqst_to_spat(cfg, Qlm, Slm, Tlm, Vr, Vt, Vp)
    ccall((:SHqst_to_spat, libshtns[]), Cvoid, (shtns_cfg, Ptr{cplx}, Ptr{cplx}, Ptr{cplx}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}), cfg, Qlm, Slm, Tlm, Vr, Vt, Vp)
end

function spat_cplx_to_SHqst(cfg, Vr, Vt, Vp, Qlm, Slm, Tlm)
    ccall((:spat_cplx_to_SHqst, libshtns[]), Cvoid, (shtns_cfg, Ptr{cplx}, Ptr{cplx}, Ptr{cplx}, Ptr{cplx}, Ptr{cplx}, Ptr{cplx}), cfg, Vr, Vt, Vp, Qlm, Slm, Tlm)
end

function SHqst_to_spat_cplx(cfg, Qlm, Slm, Tlm, Vr, Vt, Vp)
    ccall((:SHqst_to_spat_cplx, libshtns[]), Cvoid, (shtns_cfg, Ptr{cplx}, Ptr{cplx}, Ptr{cplx}, Ptr{cplx}, Ptr{cplx}, Ptr{cplx}), cfg, Qlm, Slm, Tlm, Vr, Vt, Vp)
end

function spat_to_SH_l(cfg, Vr, Qlm, ltr)
    ccall((:spat_to_SH_l, libshtns[]), Cvoid, (shtns_cfg, Ptr{Cdouble}, Ptr{cplx}, Cint), cfg, Vr, Qlm, ltr)
end

function SH_to_spat_l(cfg, Qlm, Vr, ltr)
    ccall((:SH_to_spat_l, libshtns[]), Cvoid, (shtns_cfg, Ptr{cplx}, Ptr{Cdouble}, Cint), cfg, Qlm, Vr, ltr)
end

function SHsphtor_to_spat_l(cfg, Slm, Tlm, Vt, Vp, ltr)
    ccall((:SHsphtor_to_spat_l, libshtns[]), Cvoid, (shtns_cfg, Ptr{cplx}, Ptr{cplx}, Ptr{Cdouble}, Ptr{Cdouble}, Cint), cfg, Slm, Tlm, Vt, Vp, ltr)
end

function SHtor_to_spat_l(cfg, Tlm, Vt, Vp, ltr)
    ccall((:SHtor_to_spat_l, libshtns[]), Cvoid, (shtns_cfg, Ptr{cplx}, Ptr{Cdouble}, Ptr{Cdouble}, Cint), cfg, Tlm, Vt, Vp, ltr)
end

function spat_to_SHsphtor_l(cfg, Vt, Vp, Slm, Tlm, ltr)
    ccall((:spat_to_SHsphtor_l, libshtns[]), Cvoid, (shtns_cfg, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{cplx}, Ptr{cplx}, Cint), cfg, Vt, Vp, Slm, Tlm, ltr)
end

function spat_to_SHqst_l(cfg, Vr, Vt, Vp, Qlm, Slm, Tlm, ltr)
    ccall((:spat_to_SHqst_l, libshtns[]), Cvoid, (shtns_cfg, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{cplx}, Ptr{cplx}, Ptr{cplx}, Cint), cfg, Vr, Vt, Vp, Qlm, Slm, Tlm, ltr)
end

function SHqst_to_spat_l(cfg, Qlm, Slm, Tlm, Vr, Vt, Vp, ltr)
    ccall((:SHqst_to_spat_l, libshtns[]), Cvoid, (shtns_cfg, Ptr{cplx}, Ptr{cplx}, Ptr{cplx}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}, Cint), cfg, Qlm, Slm, Tlm, Vr, Vt, Vp, ltr)
end

function spat_to_SH_ml(cfg, im, Vr, Ql, ltr)
    ccall((:spat_to_SH_ml, libshtns[]), Cvoid, (shtns_cfg, Cint, Ptr{cplx}, Ptr{cplx}, Cint), cfg, im, Vr, Ql, ltr)
end

function SH_to_spat_ml(cfg, im, Ql, Vr, ltr)
    ccall((:SH_to_spat_ml, libshtns[]), Cvoid, (shtns_cfg, Cint, Ptr{cplx}, Ptr{cplx}, Cint), cfg, im, Ql, Vr, ltr)
end

function spat_to_SHsphtor_ml(cfg, im, Vt, Vp, Sl, Tl, ltr)
    ccall((:spat_to_SHsphtor_ml, libshtns[]), Cvoid, (shtns_cfg, Cint, Ptr{cplx}, Ptr{cplx}, Ptr{cplx}, Ptr{cplx}, Cint), cfg, im, Vt, Vp, Sl, Tl, ltr)
end

function SHsphtor_to_spat_ml(cfg, im, Sl, Tl, Vt, Vp, ltr)
    ccall((:SHsphtor_to_spat_ml, libshtns[]), Cvoid, (shtns_cfg, Cint, Ptr{cplx}, Ptr{cplx}, Ptr{cplx}, Ptr{cplx}, Cint), cfg, im, Sl, Tl, Vt, Vp, ltr)
end

function SHtor_to_spat_ml(cfg, im, Tl, Vt, Vp, ltr)
    ccall((:SHtor_to_spat_ml, libshtns[]), Cvoid, (shtns_cfg, Cint, Ptr{cplx}, Ptr{cplx}, Ptr{cplx}, Cint), cfg, im, Tl, Vt, Vp, ltr)
end

function spat_to_SHqst_ml(cfg, im, Vr, Vt, Vp, Ql, Sl, Tl, ltr)
    ccall((:spat_to_SHqst_ml, libshtns[]), Cvoid, (shtns_cfg, Cint, Ptr{cplx}, Ptr{cplx}, Ptr{cplx}, Ptr{cplx}, Ptr{cplx}, Ptr{cplx}, Cint), cfg, im, Vr, Vt, Vp, Ql, Sl, Tl, ltr)
end

function SHqst_to_spat_ml(cfg, im, Ql, Sl, Tl, Vr, Vt, Vp, ltr)
    ccall((:SHqst_to_spat_ml, libshtns[]), Cvoid, (shtns_cfg, Cint, Ptr{cplx}, Ptr{cplx}, Ptr{cplx}, Ptr{cplx}, Ptr{cplx}, Ptr{cplx}, Cint), cfg, im, Ql, Sl, Tl, Vr, Vt, Vp, ltr)
end

function SH_to_point(cfg, Qlm, cost, phi)
    ccall((:SH_to_point, libshtns[]), Cdouble, (shtns_cfg, Ptr{cplx}, Cdouble, Cdouble), cfg, Qlm, cost, phi)
end

function SH_to_point_cplx(cfg, alm, cost, phi)
    ccall((:SH_to_point_cplx, libshtns[]), cplx, (shtns_cfg, Ptr{cplx}, Cdouble, Cdouble), cfg, alm, cost, phi)
end

function SH_to_grad_point(cfg, DrSlm, Slm, cost, phi, vr, vt, vp)
    ccall((:SH_to_grad_point, libshtns[]), Cvoid, (shtns_cfg, Ptr{cplx}, Ptr{cplx}, Cdouble, Cdouble, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}), cfg, DrSlm, Slm, cost, phi, vr, vt, vp)
end

function SHqst_to_point(cfg, Qlm, Slm, Tlm, cost, phi, vr, vt, vp)
    ccall((:SHqst_to_point, libshtns[]), Cvoid, (shtns_cfg, Ptr{cplx}, Ptr{cplx}, Ptr{cplx}, Cdouble, Cdouble, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}), cfg, Qlm, Slm, Tlm, cost, phi, vr, vt, vp)
end

function SH_to_lat(shtns, Qlm, cost, vr, nphi, ltr, mtr)
    ccall((:SH_to_lat, libshtns[]), Cvoid, (shtns_cfg, Ptr{cplx}, Cdouble, Ptr{Cdouble}, Cint, Cint, Cint), shtns, Qlm, cost, vr, nphi, ltr, mtr)
end

function SHqst_to_lat(cfg, Qlm, Slm, Tlm, cost, vr, vt, vp, nphi, ltr, mtr)
    ccall((:SHqst_to_lat, libshtns[]), Cvoid, (shtns_cfg, Ptr{cplx}, Ptr{cplx}, Ptr{cplx}, Cdouble, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}, Cint, Cint, Cint), cfg, Qlm, Slm, Tlm, cost, vr, vt, vp, nphi, ltr, mtr)
end

