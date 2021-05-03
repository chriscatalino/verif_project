clear -all
analyze -v2k src/Control_Unit.v
analyze -v2k src/Datapath_Unit.v
analyze -sv sva/v_UART_XMTR.sv

elaborate -top UART_XMTR_Props

clock Clock
reset -expression {!(rst_b)}
prove -bg -all
