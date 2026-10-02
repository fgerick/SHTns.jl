using Test
using CUDA
using SHTns


@testset "CUDA: synth and analys batched" begin

	L = 64
	for howmany in (1, 10), contiguous_phi in (true, false), transform in (Real, ) #Complex not working
		if howmany > 1 && contiguous_phi
			@test_throws AssertionError cfg = SHTnsCfg(L; howmany, transform, shtype=SHTns.QuickInit(; contiguous_phi))
			@test_throws AssertionError cfg_gpu = SHTnsCfg(L; howmany, transform, shtype=SHTns.QuickInit(; gpu=true, contiguous_phi))
		else
			cfg = SHTnsCfg(L; howmany, transform, shtype=SHTns.QuickInit(; contiguous_phi))
			cfg_gpu = SHTnsCfg(L; howmany, transform, shtype=SHTns.QuickInit(; gpu=true, contiguous_phi))
	

			# using spectral arrays as vectors:
			q = zeros(ComplexF64, howmany*nlm(cfg))
			for i in 0:howmany-1
				q[nlm(cfg)*i .+ 2:5] .= (i+1)*1.0 
			end
			s = t = q
			s_gpu = CuArray(s)
			t_gpu = CuArray(t)
			q_gpu = CuArray(q)

			_s_gpu = CuArray(s)
			_t_gpu = CuArray(t)
			_q_gpu = CuArray(q)

			
			x = synth(cfg, q)
			x_gpu = synth(cfg_gpu, q_gpu)
			@test x ≈ Array(x_gpu)
			analys!(cfg_gpu, x_gpu, _q_gpu)
			@test _q_gpu ≈ q_gpu
			# @test synth(cfg, q) ≈ x

			# x,y = synth(cfg, q,s) 
			x_gpu,y_gpu = synth(cfg_gpu, q_gpu,s_gpu) 
			analys!(cfg_gpu, x_gpu,y_gpu, _q_gpu, _s_gpu)
			@test _q_gpu ≈ q_gpu
			@test _s_gpu ≈ s_gpu
			
			x,y,z = synth(cfg, q,s,t) 
			x_gpu,y_gpu,z_gpu = synth(cfg_gpu, q_gpu,s_gpu,t_gpu) 
			analys!(cfg_gpu, x_gpu,y_gpu,z_gpu, _q_gpu,_s_gpu,_t_gpu)
			@test _q_gpu ≈ q_gpu
			@test _s_gpu ≈ s_gpu
			@test _t_gpu ≈ t_gpu

			#spectral arrays as matrices:
			q = zeros(ComplexF64, nlm(cfg), howmany)
			for i in 1:howmany
				q[2:5,i] .= i*1.0 
			end
			s = t = q
			s_gpu = CuArray(s)
			t_gpu = CuArray(t)
			q_gpu = CuArray(q)

			
			x = synth(cfg, q)
			x_gpu = synth(cfg_gpu, q_gpu)
			@test x ≈ Array(x_gpu)
			@test analys(cfg_gpu, x_gpu) ≈ q_gpu
			# @test synth(cfg, q) ≈ x

			# x,y = synth(cfg, q,s) 
			x_gpu,y_gpu = synth(cfg_gpu, q_gpu,s_gpu) 
			_q_gpu,_s_gpu = analys(cfg_gpu, x_gpu,y_gpu)
			@test _q_gpu ≈ q_gpu
			@test _s_gpu ≈ s_gpu
			
			x,y,z = synth(cfg, q,s,t) 
			x_gpu,y_gpu,z_gpu = synth(cfg_gpu, q_gpu,s_gpu,t_gpu) 
			_q_gpu,_s_gpu,_t_gpu = analys(cfg_gpu, x_gpu,y_gpu,z_gpu)
			@test _q_gpu ≈ q_gpu
			@test _s_gpu ≈ s_gpu
			@test _t_gpu ≈ t_gpu
		end
	end
	
end
