function cu_spat_to_SH(cfg, Vr::CuArray{Float64}, Qlm::CuVector{Complex{Float64}}, lmax)
    ccall((:cu_spat_to_SH, libshtns[]), Nothing, (shtns_cfg, CuPtr{Float64}, CuPtr{Complex{Float64}}, Clong), cfg, Vr, Qlm, lmax)
end

function cu_SH_to_spat(cfg, Qlm::CuVector{Complex{Float64}}, Vr::CuArray{Float64}, lmax)
    ccall((:cu_SH_to_spat, libshtns[]), Nothing, (shtns_cfg, CuPtr{Complex{Float64}}, CuPtr{Float64}, Clong), cfg, Qlm, Vr, lmax)
end

function cu_spat_to_SHsphtor(cfg, Vt::CuArray{Float64}, Vp::CuArray{Float64}, Slm::CuVector{Complex{Float64}}, Tlm::CuVector{Complex{Float64}}, lmax)
    ccall((:cu_spat_to_SHsphtor, libshtns[]), Nothing, (shtns_cfg,CuPtr{Float64},CuPtr{Float64},CuPtr{ComplexF64},CuPtr{ComplexF64}, Clong), cfg, Vt, Vp, Slm, Tlm, lmax)
end

function cu_SHsphtor_to_spat(cfg, Slm::CuVector{Complex{Float64}}, Tlm::CuVector{Complex{Float64}}, Vt::CuArray{Float64}, Vp::CuArray{Float64}, lmax)
    ccall((:cu_SHsphtor_to_spat, libshtns[]), Nothing, (shtns_cfg,CuPtr{ComplexF64},CuPtr{ComplexF64},CuPtr{Float64},CuPtr{Float64}, Clong), cfg, Slm, Tlm, Vt, Vp, lmax)
end

function spat_to_SHqst(cfg, Vr::CuArray{Float64}, Vt::CuArray{Float64}, Vp::CuArray{Float64}, Qlm::CuVector{Complex{Float64}}, Slm::CuVector{Complex{Float64}}, Tlm::CuVector{Complex{Float64}}, lmax)
    ccall((:cu_spat_to_SHqst, libshtns[]), Nothing, (shtns_cfg,CuPtr{Float64},CuPtr{Float64},CuPtr{Float64},CuPtr{ComplexF64},CuPtr{ComplexF64},CuPtr{ComplexF64}, Clong), cfg, Vr, Vt, Vp, Qlm, Slm, Tlm, lmax)
end

function SHqst_to_spat(cfg, Qlm::CuVector{Complex{Float64}}, Slm::CuVector{Complex{Float64}}, Tlm::CuVector{Complex{Float64}}, Vr::CuArray{Float64}, Vt::CuArray{Float64}, Vp::CuArray{Float64}, lmax)
    ccall((:cu_SHqst_to_spat, libshtns[]), Nothing, (shtns_cfg,CuPtr{ComplexF64},CuPtr{ComplexF64},CuPtr{ComplexF64},CuPtr{Float64},CuPtr{Float64},CuPtr{Float64}, Clong), cfg, Qlm, Slm, Tlm, Vr, Vt, Vp, lmax)
end


