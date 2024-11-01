transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/linor/Documents/Maestria/DigitalSystemsDesign/Github_Projects/Infinite_Process {C:/Users/linor/Documents/Maestria/DigitalSystemsDesign/Github_Projects/Infinite_Process/Mux3_1.v}

