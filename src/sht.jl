#direct bindings to SHTns generated with Clang.jl

function SHsph_to_spat(cfg, Slm, Vt, Vp)
    ccall((:SHsph_to_spat, libshtns[]), Nothing, (shtns_cfg, Ptr{ComplexF64}, Ptr{Float64}, Ptr{Float64}), cfg, Slm, Vt, Vp)
end

function SHsph_to_spat_l(cfg, Slm, Vt, Vp, ltr)
    ccall((:SHsph_to_spat_l, libshtns[]), Nothing, (shtns_cfg, Ptr{ComplexF64}, Ptr{Float64}, Ptr{Float64}, Int32), cfg, Slm, Vt, Vp, ltr)
end

function SHsph_to_spat_ml(cfg, im, Sl, Vt, Vp, ltr)
    ccall((:SHsph_to_spat_ml, libshtns[]), Nothing, (shtns_cfg, Int32, Ptr{ComplexF64}, Ptr{ComplexF64}, Ptr{ComplexF64}, Int32), cfg, im, Sl, Vt, Vp, ltr)
end

function nlm_calc(lmax, mmax, mres)
    ccall((:nlm_calc, libshtns[]), Int64, (Int64, Int64, Int64), lmax, mmax, mres)
end

function nlm_cplx_calc(lmax, mmax, mres)
    ccall((:nlm_cplx_calc, libshtns[]), Int64, (Int64, Int64, Int64), lmax, mmax, mres)
end

function shtns_verbose(cfg)
    ccall((:shtns_verbose, libshtns[]), Nothing, (Int32,), cfg)
end

function shtns_print_version()
    ccall((:shtns_print_version, libshtns[]), Nothing, ())
end

function shtns_get_build_info()
    ccall((:shtns_get_build_info, libshtns[]), Ptr{Cchar}, ())
end

function shtns_print_cfg(cfg)
    ccall((:shtns_print_cfg, libshtns[]), Nothing, (shtns_cfg,), cfg)
end

function shtns_init(flags, lmax, mmax, mres, nlat, nphi)
    ccall((:shtns_init, libshtns[]), shtns_cfg, (shtns_type, Int32, Int32, Int32, Int32, Int32), flags, lmax, mmax, mres, nlat, nphi)
end

function shtns_create(lmax, mmax, mres, norm)
    ccall((:shtns_create, libshtns[]), shtns_cfg, (Int32, Int32, Int32, shtns_norm), lmax, mmax, mres, norm)
end

function shtns_set_grid(cfg, flags, eps, nlat, nphi)
    ccall((:shtns_set_grid, libshtns[]), Int32, (shtns_cfg, shtns_type, Float64, Int32, Int32), cfg, flags, eps, nlat, nphi)
end

function shtns_set_grid_auto(cfg, flags, eps, nl_order, nlat, nphi)
    ccall((:shtns_set_grid_auto, libshtns[]), Int32, (shtns_cfg, shtns_type, Float64, Int32, Ptr{Cuint}, Ptr{Cuint}), cfg, flags, eps, nl_order, nlat, nphi)
end

function shtns_create_with_grid(cfg, mmax, nofft)
    ccall((:shtns_create_with_grid, libshtns[]), shtns_cfg, (shtns_cfg, Int32, Int32), cfg, mmax, nofft)
end

function shtns_use_threads(num_threads)
    ccall((:shtns_use_threads, libshtns[]), Int32, (Int32,), num_threads)
end

function shtns_use_gpu(device_id)
    ccall((:shtns_use_gpu, libshtns[]), Int32, (Int32,), device_id)
end

function shtns_reset()
    ccall((:shtns_reset, libshtns[]), Nothing, ())
end

function shtns_destroy(cfg)
    ccall((:shtns_destroy, libshtns[]), Nothing, (shtns_cfg,), cfg)
end

function shtns_unset_grid(cfg)
    ccall((:shtns_unset_grid, libshtns[]), Nothing, (shtns_cfg,), cfg)
end

function shtns_robert_form(cfg, robert)
    ccall((:shtns_robert_form, libshtns[]), Nothing, (shtns_cfg, Int32), cfg, robert)
end

function shtns_malloc(bytes)
    ccall((:shtns_malloc, libshtns[]), Ptr{Nothing}, (Int32,), bytes)
end

function shtns_free(p)
    ccall((:shtns_free, libshtns[]), Nothing, (Ptr{Nothing},), p)
end

function sh00_1(cfg)
    ccall((:sh00_1, libshtns[]), Float64, (shtns_cfg,), cfg)
end

function sh10_ct(cfg)
    ccall((:sh10_ct, libshtns[]), Float64, (shtns_cfg,), cfg)
end

function sh11_st(cfg)
    ccall((:sh11_st, libshtns[]), Float64, (shtns_cfg,), cfg)
end

function shlm_e1(cfg, l, m)
    ccall((:shlm_e1, libshtns[]), Float64, (shtns_cfg, Int32, Int32), cfg, l, m)
end

function shtns_gauss_wts(cfg, wts)
    ccall((:shtns_gauss_wts, libshtns[]), Int32, (shtns_cfg, Ptr{Float64}), cfg, wts)
end

function SH_Zrotate(cfg, Qlm, alpha, Rlm)
    ccall((:SH_Zrotate, libshtns[]), Nothing, (shtns_cfg, Ptr{ComplexF64}, Float64, Ptr{ComplexF64}), cfg, Qlm, alpha, Rlm)
end

function SH_Yrotate(cfg, Qlm, alpha, Rlm)
    ccall((:SH_Yrotate, libshtns[]), Nothing, (shtns_cfg, Ptr{ComplexF64}, Float64, Ptr{ComplexF64}), cfg, Qlm, alpha, Rlm)
end

function SH_Yrotate90(cfg, Qlm, Rlm)
    ccall((:SH_Yrotate90, libshtns[]), Nothing, (shtns_cfg, Ptr{ComplexF64}, Ptr{ComplexF64}), cfg, Qlm, Rlm)
end

function SH_Xrotate90(cfg, Qlm, Rlm)
    ccall((:SH_Xrotate90, libshtns[]), Nothing, (shtns_cfg, Ptr{ComplexF64}, Ptr{ComplexF64}), cfg, Qlm, Rlm)
end

function shtns_rotation_create(lmax, mmax, norm)
    ccall((:shtns_rotation_create, libshtns[]), shtns_rot, (Int32, Int32, Int32), lmax, mmax, norm)
end

function shtns_rotation_destroy(r)
    ccall((:shtns_rotation_destroy, libshtns[]), Nothing, (shtns_rot,), r)
end

function shtns_rotation_set_angles_ZYZ(r, alpha, beta, gamma)
    ccall((:shtns_rotation_set_angles_ZYZ, libshtns[]), Nothing, (shtns_rot, Float64, Float64, Float64), r, alpha, beta, gamma)
end

function shtns_rotation_set_angles_ZXZ(r, alpha, beta, gamma)
    ccall((:shtns_rotation_set_angles_ZXZ, libshtns[]), Nothing, (shtns_rot, Float64, Float64, Float64), r, alpha, beta, gamma)
end

function shtns_rotation_set_angle_axis(r, theta, Vx, Vy, Vz)
    ccall((:shtns_rotation_set_angle_axis, libshtns[]), Nothing, (shtns_rot, Float64, Float64, Float64, Float64), r, theta, Vx, Vy, Vz)
end

function shtns_rotation_wigner_d_matrix(r, l, mx)
    ccall((:shtns_rotation_wigner_d_matrix, libshtns[]), Int32, (shtns_rot, Int32, Ptr{Float64}), r, l, mx)
end

function shtns_rotation_apply_cplx(r, Zlm, Rlm)
    ccall((:shtns_rotation_apply_cplx, libshtns[]), Nothing, (shtns_rot, Ptr{ComplexF64}, Ptr{ComplexF64}), r, Zlm, Rlm)
end

function shtns_rotation_apply_real(r, Qlm, Rlm)
    ccall((:shtns_rotation_apply_real, libshtns[]), Nothing, (shtns_rot, Ptr{ComplexF64}, Ptr{ComplexF64}), r, Qlm, Rlm)
end

function legendre_sphPlm_array(shtns, lmax, im, x, yl)
    ccall((:legendre_sphPlm_array, libshtns[]), Int32, (shtns_cfg, Int32, Int32, Float64, Ptr{Float64}), shtns, lmax, im, x, yl)
end

function legendre_sphPlm_deriv_array(shtns, lmax, im, x, sint, yl, dyl)
    ccall((:legendre_sphPlm_deriv_array, libshtns[]), Int32, (shtns_cfg, Int32, Int32, Float64, Float64, Ptr{Float64}, Ptr{Float64}), shtns, lmax, im, x, sint, yl, dyl)
end

function mul_ct_matrix(cfg, mx)
    ccall((:mul_ct_matrix, libshtns[]), Nothing, (shtns_cfg, Ptr{Float64}), cfg, mx)
end

function st_dt_matrix(cfg, mx)
    ccall((:st_dt_matrix, libshtns[]), Nothing, (shtns_cfg, Ptr{Float64}), cfg, mx)
end

function SH_mul_mx(cfg, mx, Qlm, Rlm)
    ccall((:SH_mul_mx, libshtns[]), Nothing, (shtns_cfg, Ptr{Float64}, Ptr{ComplexF64}, Ptr{ComplexF64}), cfg, mx, Qlm, Rlm)
end

function spat_to_SH(shtns, Vr, Qlm)
    ccall((:spat_to_SH, libshtns[]), Nothing, (shtns_cfg, Ptr{Float64}, Ptr{ComplexF64}), shtns, Vr, Qlm)
end

function SH_to_spat(shtns, Qlm, Vr)
    ccall((:SH_to_spat, libshtns[]), Nothing, (shtns_cfg, Ptr{ComplexF64}, Ptr{Float64}), shtns, Qlm, Vr)
end

function SH_to_spat_cplx(shtns, alm, z)
    ccall((:SH_to_spat_cplx, libshtns[]), Nothing, (shtns_cfg, Ptr{ComplexF64}, Ptr{ComplexF64}), shtns, alm, z)
end

function spat_cplx_to_SH(shtns, z, alm)
    ccall((:spat_cplx_to_SH, libshtns[]), Nothing, (shtns_cfg, Ptr{ComplexF64}, Ptr{ComplexF64}), shtns, z, alm)
end

function spat_to_SHsphtor(cfg, Vt, Vp, Slm, Tlm)
    ccall((:spat_to_SHsphtor, libshtns[]), Nothing, (shtns_cfg, Ptr{Float64}, Ptr{Float64}, Ptr{ComplexF64}, Ptr{ComplexF64}), cfg, Vt, Vp, Slm, Tlm)
end

function SHsphtor_to_spat(cfg, Slm, Tlm, Vt, Vp)
    ccall((:SHsphtor_to_spat, libshtns[]), Nothing, (shtns_cfg, Ptr{ComplexF64}, Ptr{ComplexF64}, Ptr{Float64}, Ptr{Float64}), cfg, Slm, Tlm, Vt, Vp)
end

function SHtor_to_spat(cfg, Tlm, Vt, Vp)
    ccall((:SHtor_to_spat, libshtns[]), Nothing, (shtns_cfg, Ptr{ComplexF64}, Ptr{Float64}, Ptr{Float64}), cfg, Tlm, Vt, Vp)
end

function spat_cplx_to_SHsphtor(cfg, Vt, Vp, Slm, Tlm)
    ccall((:spat_cplx_to_SHsphtor, libshtns[]), Nothing, (shtns_cfg, Ptr{ComplexF64}, Ptr{ComplexF64}, Ptr{ComplexF64}, Ptr{ComplexF64}), cfg, Vt, Vp, Slm, Tlm)
end

function SHsphtor_to_spat_cplx(cfg, Slm, Tlm, Vt, Vp)
    ccall((:SHsphtor_to_spat_cplx, libshtns[]), Nothing, (shtns_cfg, Ptr{ComplexF64}, Ptr{ComplexF64}, Ptr{ComplexF64}, Ptr{ComplexF64}), cfg, Slm, Tlm, Vt, Vp)
end

function spat_to_SHqst(cfg, Vr, Vt, Vp, Qlm, Slm, Tlm)
    ccall((:spat_to_SHqst, libshtns[]), Nothing, (shtns_cfg, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}, Ptr{ComplexF64}, Ptr{ComplexF64}, Ptr{ComplexF64}), cfg, Vr, Vt, Vp, Qlm, Slm, Tlm)
end

function SHqst_to_spat(cfg, Qlm, Slm, Tlm, Vr, Vt, Vp)
    ccall((:SHqst_to_spat, libshtns[]), Nothing, (shtns_cfg, Ptr{ComplexF64}, Ptr{ComplexF64}, Ptr{ComplexF64}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}), cfg, Qlm, Slm, Tlm, Vr, Vt, Vp)
end

function spat_cplx_to_SHqst(cfg, Vr, Vt, Vp, Qlm, Slm, Tlm)
    ccall((:spat_cplx_to_SHqst, libshtns[]), Nothing, (shtns_cfg, Ptr{ComplexF64}, Ptr{ComplexF64}, Ptr{ComplexF64}, Ptr{ComplexF64}, Ptr{ComplexF64}, Ptr{ComplexF64}), cfg, Vr, Vt, Vp, Qlm, Slm, Tlm)
end

function SHqst_to_spat_cplx(cfg, Qlm, Slm, Tlm, Vr, Vt, Vp)
    ccall((:SHqst_to_spat_cplx, libshtns[]), Nothing, (shtns_cfg, Ptr{ComplexF64}, Ptr{ComplexF64}, Ptr{ComplexF64}, Ptr{ComplexF64}, Ptr{ComplexF64}, Ptr{ComplexF64}), cfg, Qlm, Slm, Tlm, Vr, Vt, Vp)
end

function spat_to_SH_l(cfg, Vr, Qlm, ltr)
    ccall((:spat_to_SH_l, libshtns[]), Nothing, (shtns_cfg, Ptr{Float64}, Ptr{ComplexF64}, Int32), cfg, Vr, Qlm, ltr)
end

function SH_to_spat_l(cfg, Qlm, Vr, ltr)
    ccall((:SH_to_spat_l, libshtns[]), Nothing, (shtns_cfg, Ptr{ComplexF64}, Ptr{Float64}, Int32), cfg, Qlm, Vr, ltr)
end

function SHsphtor_to_spat_l(cfg, Slm, Tlm, Vt, Vp, ltr)
    ccall((:SHsphtor_to_spat_l, libshtns[]), Nothing, (shtns_cfg, Ptr{ComplexF64}, Ptr{ComplexF64}, Ptr{Float64}, Ptr{Float64}, Int32), cfg, Slm, Tlm, Vt, Vp, ltr)
end

function SHtor_to_spat_l(cfg, Tlm, Vt, Vp, ltr)
    ccall((:SHtor_to_spat_l, libshtns[]), Nothing, (shtns_cfg, Ptr{ComplexF64}, Ptr{Float64}, Ptr{Float64}, Int32), cfg, Tlm, Vt, Vp, ltr)
end

function spat_to_SHsphtor_l(cfg, Vt, Vp, Slm, Tlm, ltr)
    ccall((:spat_to_SHsphtor_l, libshtns[]), Nothing, (shtns_cfg, Ptr{Float64}, Ptr{Float64}, Ptr{ComplexF64}, Ptr{ComplexF64}, Int32), cfg, Vt, Vp, Slm, Tlm, ltr)
end

function spat_to_SHqst_l(cfg, Vr, Vt, Vp, Qlm, Slm, Tlm, ltr)
    ccall((:spat_to_SHqst_l, libshtns[]), Nothing, (shtns_cfg, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}, Ptr{ComplexF64}, Ptr{ComplexF64}, Ptr{ComplexF64}, Int32), cfg, Vr, Vt, Vp, Qlm, Slm, Tlm, ltr)
end

function SHqst_to_spat_l(cfg, Qlm, Slm, Tlm, Vr, Vt, Vp, ltr)
    ccall((:SHqst_to_spat_l, libshtns[]), Nothing, (shtns_cfg, Ptr{ComplexF64}, Ptr{ComplexF64}, Ptr{ComplexF64}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}, Int32), cfg, Qlm, Slm, Tlm, Vr, Vt, Vp, ltr)
end

function spat_to_SH_ml(cfg, im, Vr, Ql, ltr)
    ccall((:spat_to_SH_ml, libshtns[]), Nothing, (shtns_cfg, Int32, Ptr{ComplexF64}, Ptr{ComplexF64}, Int32), cfg, im, Vr, Ql, ltr)
end

function SH_to_spat_ml(cfg, im, Ql, Vr, ltr)
    ccall((:SH_to_spat_ml, libshtns[]), Nothing, (shtns_cfg, Int32, Ptr{ComplexF64}, Ptr{ComplexF64}, Int32), cfg, im, Ql, Vr, ltr)
end

function spat_to_SHsphtor_ml(cfg, im, Vt, Vp, Sl, Tl, ltr)
    ccall((:spat_to_SHsphtor_ml, libshtns[]), Nothing, (shtns_cfg, Int32, Ptr{ComplexF64}, Ptr{ComplexF64}, Ptr{ComplexF64}, Ptr{ComplexF64}, Int32), cfg, im, Vt, Vp, Sl, Tl, ltr)
end

function SHsphtor_to_spat_ml(cfg, im, Sl, Tl, Vt, Vp, ltr)
    ccall((:SHsphtor_to_spat_ml, libshtns[]), Nothing, (shtns_cfg, Int32, Ptr{ComplexF64}, Ptr{ComplexF64}, Ptr{ComplexF64}, Ptr{ComplexF64}, Int32), cfg, im, Sl, Tl, Vt, Vp, ltr)
end

function SHtor_to_spat_ml(cfg, im, Tl, Vt, Vp, ltr)
    ccall((:SHtor_to_spat_ml, libshtns[]), Nothing, (shtns_cfg, Int32, Ptr{ComplexF64}, Ptr{ComplexF64}, Ptr{ComplexF64}, Int32), cfg, im, Tl, Vt, Vp, ltr)
end

function spat_to_SHqst_ml(cfg, im, Vr, Vt, Vp, Ql, Sl, Tl, ltr)
    ccall((:spat_to_SHqst_ml, libshtns[]), Nothing, (shtns_cfg, Int32, Ptr{ComplexF64}, Ptr{ComplexF64}, Ptr{ComplexF64}, Ptr{ComplexF64}, Ptr{ComplexF64}, Ptr{ComplexF64}, Int32), cfg, im, Vr, Vt, Vp, Ql, Sl, Tl, ltr)
end

function SHqst_to_spat_ml(cfg, im, Ql, Sl, Tl, Vr, Vt, Vp, ltr)
    ccall((:SHqst_to_spat_ml, libshtns[]), Nothing, (shtns_cfg, Int32, Ptr{ComplexF64}, Ptr{ComplexF64}, Ptr{ComplexF64}, Ptr{ComplexF64}, Ptr{ComplexF64}, Ptr{ComplexF64}, Int32), cfg, im, Ql, Sl, Tl, Vr, Vt, Vp, ltr)
end

function SH_to_point(cfg, Qlm, cost, phi)
    ccall((:SH_to_point, libshtns[]), Float64, (shtns_cfg, Ptr{ComplexF64}, Float64, Float64), cfg, Qlm, cost, phi)
end

function SH_to_point_cplx(cfg, alm, cost, phi)
    ccall((:SH_to_point_cplx, libshtns[]), ComplexF64, (shtns_cfg, Ptr{ComplexF64}, Float64, Float64), cfg, alm, cost, phi)
end

function SH_to_grad_point(cfg, DrSlm, Slm, cost, phi, vr, vt, vp)
    ccall((:SH_to_grad_point, libshtns[]), Nothing, (shtns_cfg, Ptr{ComplexF64}, Ptr{ComplexF64}, Float64, Float64, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}), cfg, DrSlm, Slm, cost, phi, vr, vt, vp)
end

function SHqst_to_point(cfg, Qlm, Slm, Tlm, cost, phi, vr, vt, vp)
    ccall((:SHqst_to_point, libshtns[]), Nothing, (shtns_cfg, Ptr{ComplexF64}, Ptr{ComplexF64}, Ptr{ComplexF64}, Float64, Float64, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}), cfg, Qlm, Slm, Tlm, cost, phi, vr, vt, vp)
end

function SH_to_lat(shtns, Qlm, cost, vr, nphi, ltr, mtr)
    ccall((:SH_to_lat, libshtns[]), Nothing, (shtns_cfg, Ptr{ComplexF64}, Float64, Ptr{Float64}, Int32, Int32, Int32), shtns, Qlm, cost, vr, nphi, ltr, mtr)
end

function SHqst_to_lat(cfg, Qlm, Slm, Tlm, cost, vr, vt, vp, nphi, ltr, mtr)
    ccall((:SHqst_to_lat, libshtns[]), Nothing, (shtns_cfg, Ptr{ComplexF64}, Ptr{ComplexF64}, Ptr{ComplexF64}, Float64, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}, Int32, Int32, Int32), cfg, Qlm, Slm, Tlm, cost, vr, vt, vp, nphi, ltr, mtr)
end

function shtns_set_many(shtns, howmany, spec_dist)
    hm = ccall((:shtns_set_many, libshtns[]), Int32, (shtns_cfg, Int32, Int64), shtns, howmany, spec_dist)
    @assert hm == howmany
end