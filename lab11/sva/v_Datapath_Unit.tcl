clear -all
analyze -v2k src/Datapath_Unit.v
analyze -sv sva/v_Datapath_Unit.sv

elaborate -top Datapath_Unit

clock Clock
reset -expression {!(rst_b)}
prove -bg -all
