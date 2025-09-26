# run_vsim_decoder.tcl
#transcript on
#if {[file exists work]} { vdel -lib work -all }
#vlib work
#vmap work work

vlog -sv +acc shift_register.sv shift_register_tb.sv

vsim -voptargs=+acc work.shift_register_tb -do {
    quietly set NumericStdNoWarnings 1
    view wave
    add wave -r /*
    run -all
    wave zoom full
}