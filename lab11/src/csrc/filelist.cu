PIC_LD=ld

ARCHIVE_OBJS=
ARCHIVE_OBJS += _16881_archive_1.so
_16881_archive_1.so : archive.49/_16881_archive_1.a
	@$(AR) -s $<
	@$(PIC_LD) -shared  -o .//../simv.daidir//_16881_archive_1.so --whole-archive $< --no-whole-archive
	@rm -f $@
	@ln -sf .//../simv.daidir//_16881_archive_1.so $@



VCS_ARC0 =_csrc0.so

VCS_OBJS0 =objs/amcQw_d.o 



%.o: %.c
	$(CC_CG) $(CFLAGS_CG) -c -o $@ $<

$(VCS_ARC0) : $(VCS_OBJS0)
	$(PIC_LD) -shared  -o .//../simv.daidir//$(VCS_ARC0) $(VCS_OBJS0)
	rm -f $(VCS_ARC0)
	@ln -sf .//../simv.daidir//$(VCS_ARC0) $(VCS_ARC0)

CU_UDP_OBJS = \


CU_LVL_OBJS = \
SIM_l.o 

MAIN_OBJS = \
amcQwB.o 

CU_OBJS = $(MAIN_OBJS) $(ARCHIVE_OBJS) $(VCS_ARC0) $(CU_UDP_OBJS) $(CU_LVL_OBJS)

