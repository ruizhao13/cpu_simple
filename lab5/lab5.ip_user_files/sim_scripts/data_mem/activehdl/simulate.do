onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+data_mem -L unisims_ver -L unimacro_ver -L secureip -L dist_mem_gen_v8_0_10 -L xil_defaultlib -O5 xil_defaultlib.data_mem xil_defaultlib.glbl

do {wave.do}

view wave
view structure
view signals

do {data_mem.udo}

run -all

endsim

quit -force
