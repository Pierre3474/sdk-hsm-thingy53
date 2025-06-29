 OUTPUT_FORMAT("elf32-littlearm")
_region_min_align = 32;
MEMORY
    {
    FLASH (rx) : ORIGIN = 0x0, LENGTH = 0xfc000
    RAM (wx) : ORIGIN = 0x20000000, LENGTH = 0x70000
   
    IDT_LIST (wx) : ORIGIN = 0xFFFFF7FF, LENGTH = 2K
    }
ENTRY("__start")
SECTIONS
    {
 .rel.plt :
 {
 *(.rel.plt)
 PROVIDE_HIDDEN (__rel_iplt_start = .);
 *(.rel.iplt)
 PROVIDE_HIDDEN (__rel_iplt_end = .);
 }
 .rela.plt :
 {
 *(.rela.plt)
 PROVIDE_HIDDEN (__rela_iplt_start = .);
 *(.rela.iplt)
 PROVIDE_HIDDEN (__rela_iplt_end = .);
 }
 .rel.dyn :
 {
 *(.rel.*)
 }
 .rela.dyn :
 {
 *(.rela.*)
 }
    /DISCARD/ :
 {
 *(.plt)
 }
    /DISCARD/ :
 {
 *(.iplt)
 }
   
 __rom_region_start = 0x0;
    rom_start :
 {
. = 0x0;
. = ALIGN(4);
. = ALIGN( 1 << ((((4 * 32) <= 4) ? 2 : (((4 * 32) <= 8) ? 3 : (((4 * 32) <= 16) ? 4 : (((4 * 32) <= 32) ? 5 : (((4 * 32) <= 64) ? 6 : (((4 * 32) <= 128) ? 7 : (((4 * 32) <= 256) ? 8 : (((4 * 32) <= 512) ? 9 : (((4 * 32) <= 1024) ? 10 : (((4 * 32) <= 2048) ? 11 : (((4 * 32) <= 4096) ? 12 : (((4 * 32) <= 8192) ? 13 : (((4 * 32) <= 16384) ? 14 : (((4 * 32) <= 32768) ? 15:(((4 * 32) <= 65536) ? 16 : (((4 * 32) <= 131072) ? 17 : (((4 * 32) <= 262144) ? 18:(((4 * 32) <= 524288) ? 19 : (((4 * 32) <= 1048576) ? 20 : (((4 * 32) <= 2097152) ? 21 : (((4 * 32) <= 4194304) ? 22 : (((4 * 32) <= 8388608) ? 23 : (((4 * 32) <= 16777216) ? 24 : (((4 * 32) <= 33554432) ? 25 : (((4 * 32) <= 67108864) ? 26 : (((4 * 32) <= 134217728) ? 27 : (((4 * 32) <= 268435456) ? 28 : (((4 * 32) <= 536870912) ? 29 : (((4 * 32) <= 1073741824) ? 30 : (((4 * 32) <= 2147483648) ? 31 : 32))))))))))))))))))))))))))))))) );
. = ALIGN( 1 << ((((4 * (16 + 69)) <= 4) ? 2 : (((4 * (16 + 69)) <= 8) ? 3 : (((4 * (16 + 69)) <= 16) ? 4 : (((4 * (16 + 69)) <= 32) ? 5 : (((4 * (16 + 69)) <= 64) ? 6 : (((4 * (16 + 69)) <= 128) ? 7 : (((4 * (16 + 69)) <= 256) ? 8 : (((4 * (16 + 69)) <= 512) ? 9 : (((4 * (16 + 69)) <= 1024) ? 10 : (((4 * (16 + 69)) <= 2048) ? 11 : (((4 * (16 + 69)) <= 4096) ? 12 : (((4 * (16 + 69)) <= 8192) ? 13 : (((4 * (16 + 69)) <= 16384) ? 14 : (((4 * (16 + 69)) <= 32768) ? 15:(((4 * (16 + 69)) <= 65536) ? 16 : (((4 * (16 + 69)) <= 131072) ? 17 : (((4 * (16 + 69)) <= 262144) ? 18:(((4 * (16 + 69)) <= 524288) ? 19 : (((4 * (16 + 69)) <= 1048576) ? 20 : (((4 * (16 + 69)) <= 2097152) ? 21 : (((4 * (16 + 69)) <= 4194304) ? 22 : (((4 * (16 + 69)) <= 8388608) ? 23 : (((4 * (16 + 69)) <= 16777216) ? 24 : (((4 * (16 + 69)) <= 33554432) ? 25 : (((4 * (16 + 69)) <= 67108864) ? 26 : (((4 * (16 + 69)) <= 134217728) ? 27 : (((4 * (16 + 69)) <= 268435456) ? 28 : (((4 * (16 + 69)) <= 536870912) ? 29 : (((4 * (16 + 69)) <= 1073741824) ? 30 : (((4 * (16 + 69)) <= 2147483648) ? 31 : 32))))))))))))))))))))))))))))))) );
_vector_start = .;
KEEP(*(.exc_vector_table))
KEEP(*(".exc_vector_table.*"))
KEEP(*(.vectors))
_vector_end = .;
. = ALIGN(4);
KEEP(*(.gnu.linkonce.irq_vector_table*))
 _vector_end = .;
 } > FLASH
    text :
 {
 __text_region_start = .;
 *(.text)
 *(".text.*")
 *(".TEXT.*")
 *(.gnu.linkonce.t.*)
 *(.glue_7t) *(.glue_7) *(.vfp11_veneer) *(.v4_bx)
 . = ALIGN(4);
 } > FLASH
 __text_region_end = .;
 .ARM.extab :
 {
 *(.ARM.extab* .gnu.linkonce.armextab.*)
 } > FLASH
 .ARM.exidx :
 {
 __exidx_start = .;
 *(.ARM.exidx* gnu.linkonce.armexidx.*)
 __exidx_end = .;
 } > FLASH
 __rodata_region_start = .;
 initlevel :
 {
  __init_start = .;
  __init_EARLY_start = .; KEEP(*(SORT(.z_init_EARLY[0-9]_*))); KEEP(*(SORT(.z_init_EARLY[1-9][0-9]_*)));
  __init_PRE_KERNEL_1_start = .; KEEP(*(SORT(.z_init_PRE_KERNEL_1[0-9]_*))); KEEP(*(SORT(.z_init_PRE_KERNEL_1[1-9][0-9]_*)));
  __init_PRE_KERNEL_2_start = .; KEEP(*(SORT(.z_init_PRE_KERNEL_2[0-9]_*))); KEEP(*(SORT(.z_init_PRE_KERNEL_2[1-9][0-9]_*)));
  __init_POST_KERNEL_start = .; KEEP(*(SORT(.z_init_POST_KERNEL[0-9]_*))); KEEP(*(SORT(.z_init_POST_KERNEL[1-9][0-9]_*)));
  __init_APPLICATION_start = .; KEEP(*(SORT(.z_init_APPLICATION[0-9]_*))); KEEP(*(SORT(.z_init_APPLICATION[1-9][0-9]_*)));
  __init_SMP_start = .; KEEP(*(SORT(.z_init_SMP[0-9]_*))); KEEP(*(SORT(.z_init_SMP[1-9][0-9]_*)));
  __init_end = .;
 } > FLASH
 devices :
 {
  __device_start = .;
  __device_EARLY_start = .; KEEP(*(SORT(.z_device_EARLY[0-9]_*))); KEEP(*(SORT(.z_device_EARLY[1-9][0-9]_*)));
  __device_PRE_KERNEL_1_start = .; KEEP(*(SORT(.z_device_PRE_KERNEL_1[0-9]_*))); KEEP(*(SORT(.z_device_PRE_KERNEL_1[1-9][0-9]_*)));
  __device_PRE_KERNEL_2_start = .; KEEP(*(SORT(.z_device_PRE_KERNEL_2[0-9]_*))); KEEP(*(SORT(.z_device_PRE_KERNEL_2[1-9][0-9]_*)));
  __device_POST_KERNEL_start = .; KEEP(*(SORT(.z_device_POST_KERNEL[0-9]_*))); KEEP(*(SORT(.z_device_POST_KERNEL[1-9][0-9]_*)));
  __device_APPLICATION_start = .; KEEP(*(SORT(.z_device_APPLICATION[0-9]_*))); KEEP(*(SORT(.z_device_APPLICATION[1-9][0-9]_*)));
  __device_SMP_start = .; KEEP(*(SORT(.z_device_SMP[0-9]_*))); KEEP(*(SORT(.z_device_SMP[1-9][0-9]_*)));
  __device_end = .;
 } > FLASH
 sw_isr_table :
 {
  . = ALIGN(4);
  *(.gnu.linkonce.sw_isr_table*)
 } > FLASH
 initlevel_error :
 {
  KEEP(*(SORT(.z_init_[_A-Z0-9]*)))
 }
 ASSERT(SIZEOF(initlevel_error) == 0, "Undefined initialization levels used.")
 app_shmem_regions : ALIGN_WITH_INPUT
 {
  __app_shmem_regions_start = .;
  KEEP(*(SORT(.app_regions.*)));
  __app_shmem_regions_end = .;
 } > FLASH
 k_p4wq_initparam_area : SUBALIGN(4) { _k_p4wq_initparam_list_start = .; KEEP(*(SORT_BY_NAME(._k_p4wq_initparam.static.*))); _k_p4wq_initparam_list_end = .; } > FLASH
 _static_thread_data_area : SUBALIGN(4) { __static_thread_data_list_start = .; KEEP(*(SORT_BY_NAME(.__static_thread_data.static.*))); __static_thread_data_list_end = .; } > FLASH
 device_handles : ALIGN_WITH_INPUT
 {
__device_handles_start = .;
KEEP(*(SORT(.__device_handles_pass2*)));
__device_handles_end = .;
 } > FLASH
ztest :
{
 _ztest_expected_result_entry_list_start = .; KEEP(*(SORT_BY_NAME(._ztest_expected_result_entry.static.*))); _ztest_expected_result_entry_list_end = .;
 _ztest_suite_node_list_start = .; KEEP(*(SORT_BY_NAME(._ztest_suite_node.static.*))); _ztest_suite_node_list_end = .;
 _ztest_unit_test_list_start = .; KEEP(*(SORT_BY_NAME(._ztest_unit_test.static.*))); _ztest_unit_test_list_end = .;
 _ztest_test_rule_list_start = .; KEEP(*(SORT_BY_NAME(._ztest_test_rule.static.*))); _ztest_test_rule_list_end = .;
} > FLASH
 ctors :
 {
  . = ALIGN(4);
  __ZEPHYR_CTOR_LIST__ = .;
  LONG((__ZEPHYR_CTOR_END__ - __ZEPHYR_CTOR_LIST__) / 4 - 2)
  KEEP(*(SORT_BY_NAME(".ctors*")))
  __CTOR_LIST__ = .;
  LONG(0)
  __ZEPHYR_CTOR_END__ = .;
  LONG(0)
  __CTOR_END__ = .;
 } > FLASH
 init_array :
 {
  . = ALIGN(4);
  __init_array_start = .;
  __init_array_end = .;
  __zephyr_init_array_start = .;
  KEEP(*(SORT_BY_NAME(".init_array*")))
  __zephyr_init_array_end = .;
 } > FLASH
 net_socket_register_area : SUBALIGN(4) { _net_socket_register_list_start = .; KEEP(*(SORT_BY_NAME(._net_socket_register.static.*))); _net_socket_register_list_end = .; } > FLASH
 bt_l2cap_fixed_chan_area : SUBALIGN(4) { _bt_l2cap_fixed_chan_list_start = .; KEEP(*(SORT_BY_NAME(._bt_l2cap_fixed_chan.static.*))); _bt_l2cap_fixed_chan_list_end = .; } > FLASH
 bt_gatt_service_static_area : SUBALIGN(4) { _bt_gatt_service_static_list_start = .; KEEP(*(SORT_BY_NAME(._bt_gatt_service_static.static.*))); _bt_gatt_service_static_list_end = .; } > FLASH
 log_strings_sections : ALIGN_WITH_INPUT
 {
  __log_strings_start = .;
  KEEP(*(SORT(.log_strings*)));
  __log_strings_end = .;
 } > FLASH
 log_const_sections : ALIGN_WITH_INPUT
 {
  __log_const_start = .;
  KEEP(*(SORT(.log_const_*)));
  __log_const_end = .;
 } > FLASH
 log_backend_area : SUBALIGN(4) { _log_backend_list_start = .; KEEP(*(SORT_BY_NAME(._log_backend.static.*))); _log_backend_list_end = .; } > FLASH
 log_link_area : SUBALIGN(4) { _log_link_list_start = .; KEEP(*(SORT_BY_NAME(._log_link.static.*))); _log_link_list_end = .; } > FLASH
 tracing_backend_area : SUBALIGN(4) { _tracing_backend_list_start = .; KEEP(*(SORT_BY_NAME(._tracing_backend.static.*))); _tracing_backend_list_end = .; } > FLASH
 zephyr_dbg_info : ALIGN_WITH_INPUT
 {
  KEEP(*(".dbg_thread_info"));
 } > FLASH
 settings_handler_static_area : SUBALIGN(4) { _settings_handler_static_list_start = .; KEEP(*(SORT_BY_NAME(._settings_handler_static.static.*))); _settings_handler_static_list_end = .; } > FLASH
 symbol_to_keep : ALIGN_WITH_INPUT
 {
  __symbol_to_keep_start = .;
  KEEP(*(SORT(.symbol_to_keep*)));
  __symbol_to_keep_end = .;
 } > FLASH
 shell_area : SUBALIGN(4) { _shell_list_start = .; KEEP(*(SORT_BY_NAME(._shell.static.*))); _shell_list_end = .; } > FLASH
 shell_root_cmds_sections : ALIGN_WITH_INPUT
 {
  __shell_root_cmds_start = .;
  KEEP(*(SORT(.shell_root_cmd_*)));
  __shell_root_cmds_end = .;
 } > FLASH
 shell_subcmds_sections : ALIGN_WITH_INPUT
 {
  __shell_subcmds_start = .;
  KEEP(*(SORT(.shell_subcmd_*)));
  __shell_subcmds_end = .;
 } > FLASH
 shell_dynamic_subcmds_sections : ALIGN_WITH_INPUT
 {
  __shell_dynamic_subcmds_start = .;
  KEEP(*(SORT(.shell_dynamic_subcmd_*)));
  __shell_dynamic_subcmds_end = .;
 } > FLASH
 font_entry_sections : ALIGN_WITH_INPUT
 {
  __font_entry_start = .;
  KEEP(*(SORT_BY_NAME("._cfb_font.*")))
  __font_entry_end = .;
 } > FLASH
    rodata :
 {
 *(.rodata)
 *(".rodata.*")
 *(.gnu.linkonce.r.*)
 . = ALIGN(4);
 } > FLASH
 .gcc_except_table : ONLY_IF_RO
 {
 *(.gcc_except_table .gcc_except_table.*)
 } > FLASH
 .eh_frame_hdr :
 {
 *(.eh_frame_hdr)
 } > FLASH
 .eh_frame :
 {
 KEEP (*(SORT_NONE(EXCLUDE_FILE (*crtend.o) .eh_frame)))
 KEEP (*(SORT_NONE(.eh_frame)))
 } > FLASH
 __rodata_region_end = .;
 . = ALIGN(_region_min_align);
 __rom_region_end = __rom_region_start + . - ADDR(rom_start);
   
    /DISCARD/ : {
 *(.got.plt)
 *(.igot.plt)
 *(.got)
 *(.igot)
 }
   
 . = 0x20000000;
 . = ALIGN(_region_min_align);
 _image_ram_start = .;
.ramfunc : ALIGN_WITH_INPUT
{
 . = ALIGN(_region_min_align);
 __ramfunc_start = .;
 *(.ramfunc)
 *(".ramfunc.*")
 . = ALIGN(_region_min_align);
 __ramfunc_end = .;
} > RAM AT > FLASH
__ramfunc_size = __ramfunc_end - __ramfunc_start;
__ramfunc_load_start = LOADADDR(.ramfunc);
   
    datas : ALIGN_WITH_INPUT
 {
 __data_region_start = .;
 __data_start = .;
 *(.data)
 *(".data.*")
 *(".kernel.*")
 __data_end = .;
 } > RAM AT > FLASH
    __data_size = __data_end - __data_start;
    __data_load_start = LOADADDR(datas);
    __data_region_load_start = LOADADDR(datas);
        device_states : ALIGN_WITH_INPUT
        {
                __device_states_start = .;
  KEEP(*(".z_devstate"));
  KEEP(*(".z_devstate.*"));
                __device_states_end = .;
        } > RAM AT > FLASH
 initshell : ALIGN_WITH_INPUT
 {
  __shell_module_start = .;
  KEEP(*(".shell_module_*"));
  __shell_module_end = .;
  __shell_cmd_start = .;
  KEEP(*(".shell_cmd_*"));
  __shell_cmd_end = .;
 } > RAM AT > FLASH
 log_mpsc_pbuf_area : ALIGN_WITH_INPUT SUBALIGN(4) { _log_mpsc_pbuf_list_start = .; *(SORT_BY_NAME(._log_mpsc_pbuf.static.*)); _log_mpsc_pbuf_list_end = .; } > RAM AT > FLASH
 log_msg_ptr_area : ALIGN_WITH_INPUT SUBALIGN(4) { _log_msg_ptr_list_start = .; KEEP(*(SORT_BY_NAME(._log_msg_ptr.static.*))); _log_msg_ptr_list_end = .; } > RAM AT > FLASH
 log_dynamic_sections : ALIGN_WITH_INPUT
 {
  __log_dynamic_start = .;
  KEEP(*(SORT(.log_dynamic_*)));
  __log_dynamic_end = .;
 } > RAM AT > FLASH
 k_timer_area : ALIGN_WITH_INPUT SUBALIGN(4) { _k_timer_list_start = .; *(SORT_BY_NAME(._k_timer.static.*)); _k_timer_list_end = .; } > RAM AT > FLASH
 k_mem_slab_area : ALIGN_WITH_INPUT SUBALIGN(4) { _k_mem_slab_list_start = .; *(SORT_BY_NAME(._k_mem_slab.static.*)); _k_mem_slab_list_end = .; } > RAM AT > FLASH
 k_heap_area : ALIGN_WITH_INPUT SUBALIGN(4) { _k_heap_list_start = .; *(SORT_BY_NAME(._k_heap.static.*)); _k_heap_list_end = .; } > RAM AT > FLASH
 k_mutex_area : ALIGN_WITH_INPUT SUBALIGN(4) { _k_mutex_list_start = .; *(SORT_BY_NAME(._k_mutex.static.*)); _k_mutex_list_end = .; } > RAM AT > FLASH
 k_stack_area : ALIGN_WITH_INPUT SUBALIGN(4) { _k_stack_list_start = .; *(SORT_BY_NAME(._k_stack.static.*)); _k_stack_list_end = .; } > RAM AT > FLASH
 k_msgq_area : ALIGN_WITH_INPUT SUBALIGN(4) { _k_msgq_list_start = .; *(SORT_BY_NAME(._k_msgq.static.*)); _k_msgq_list_end = .; } > RAM AT > FLASH
 k_mbox_area : ALIGN_WITH_INPUT SUBALIGN(4) { _k_mbox_list_start = .; *(SORT_BY_NAME(._k_mbox.static.*)); _k_mbox_list_end = .; } > RAM AT > FLASH
 k_pipe_area : ALIGN_WITH_INPUT SUBALIGN(4) { _k_pipe_list_start = .; *(SORT_BY_NAME(._k_pipe.static.*)); _k_pipe_list_end = .; } > RAM AT > FLASH
 k_sem_area : ALIGN_WITH_INPUT SUBALIGN(4) { _k_sem_list_start = .; *(SORT_BY_NAME(._k_sem.static.*)); _k_sem_list_end = .; } > RAM AT > FLASH
 k_event_area : ALIGN_WITH_INPUT SUBALIGN(4) { _k_event_list_start = .; *(SORT_BY_NAME(._k_event.static.*)); _k_event_list_end = .; } > RAM AT > FLASH
 k_queue_area : ALIGN_WITH_INPUT SUBALIGN(4) { _k_queue_list_start = .; *(SORT_BY_NAME(._k_queue.static.*)); _k_queue_list_end = .; } > RAM AT > FLASH
 k_condvar_area : ALIGN_WITH_INPUT SUBALIGN(4) { _k_condvar_list_start = .; *(SORT_BY_NAME(._k_condvar.static.*)); _k_condvar_list_end = .; } > RAM AT > FLASH
 _net_buf_pool_area : ALIGN_WITH_INPUT SUBALIGN(4)
 {
  _net_buf_pool_list = .;
  KEEP(*(SORT_BY_NAME("._net_buf_pool.static.*")))
 } > RAM AT > FLASH
 net_if_area : ALIGN_WITH_INPUT SUBALIGN(4) { _net_if_list_start = .; KEEP(*(SORT_BY_NAME(._net_if.static.*))); _net_if_list_end = .; } > RAM AT > FLASH net_if_dev_area : ALIGN_WITH_INPUT SUBALIGN(4) { _net_if_dev_list_start = .; KEEP(*(SORT_BY_NAME(._net_if_dev.static.*))); _net_if_dev_list_end = .; } > RAM AT > FLASH net_l2_area : ALIGN_WITH_INPUT SUBALIGN(4) { _net_l2_list_start = .; KEEP(*(SORT_BY_NAME(._net_l2.static.*))); _net_l2_list_end = .; } > RAM AT > FLASH eth_bridge_area : ALIGN_WITH_INPUT SUBALIGN(4) { _eth_bridge_list_start = .; KEEP(*(SORT_BY_NAME(._eth_bridge.static.*))); _eth_bridge_list_end = .; } > RAM AT > FLASH
 .gcc_except_table : ALIGN_WITH_INPUT ONLY_IF_RW
 {
 *(.gcc_except_table .gcc_except_table.*)
 } > RAM AT > FLASH
    .tm_clone_table :
 {
 KEEP (*(SORT_NONE(EXCLUDE_FILE (*crtend.o) .tm_clone_table)))
 KEEP (*(SORT_NONE(.tm_clone_table)))
 } > RAM AT > FLASH
    __data_region_end = .;
   bss (NOLOAD) : ALIGN_WITH_INPUT
 {
        . = ALIGN(4);
 __bss_start = .;
 __kernel_ram_start = .;
 *(.bss)
 *(".bss.*")
 *(COMMON)
 *(".kernel_bss.*")
 __bss_end = ALIGN(4);
 } > RAM AT > RAM
    noinit (NOLOAD) :
        {
        *(.noinit)
        *(".noinit.*")
 *(".kernel_noinit.*")
        } > RAM AT > RAM
    _image_ram_end = .;
    _end = .;
    __kernel_ram_end = 0x20000000 + 0x70000;
    __kernel_ram_size = __kernel_ram_end - __kernel_ram_start;
   
.intList :
{
 KEEP(*(.irq_info*))
 KEEP(*(.intList*))
} > IDT_LIST
 .stab 0 : { *(.stab) }
 .stabstr 0 : { *(.stabstr) }
 .stab.excl 0 : { *(.stab.excl) }
 .stab.exclstr 0 : { *(.stab.exclstr) }
 .stab.index 0 : { *(.stab.index) }
 .stab.indexstr 0 : { *(.stab.indexstr) }
 .gnu.build.attributes 0 : { *(.gnu.build.attributes .gnu.build.attributes.*) }
 .comment 0 : { *(.comment) }
 .debug 0 : { *(.debug) }
 .line 0 : { *(.line) }
 .debug_srcinfo 0 : { *(.debug_srcinfo) }
 .debug_sfnames 0 : { *(.debug_sfnames) }
 .debug_aranges 0 : { *(.debug_aranges) }
 .debug_pubnames 0 : { *(.debug_pubnames) }
 .debug_info 0 : { *(.debug_info .gnu.linkonce.wi.*) }
 .debug_abbrev 0 : { *(.debug_abbrev) }
 .debug_line 0 : { *(.debug_line .debug_line.* .debug_line_end ) }
 .debug_frame 0 : { *(.debug_frame) }
 .debug_str 0 : { *(.debug_str) }
 .debug_loc 0 : { *(.debug_loc) }
 .debug_macinfo 0 : { *(.debug_macinfo) }
 .debug_weaknames 0 : { *(.debug_weaknames) }
 .debug_funcnames 0 : { *(.debug_funcnames) }
 .debug_typenames 0 : { *(.debug_typenames) }
 .debug_varnames 0 : { *(.debug_varnames) }
 .debug_pubtypes 0 : { *(.debug_pubtypes) }
 .debug_ranges 0 : { *(.debug_ranges) }
 .debug_macro 0 : { *(.debug_macro) }
 .debug_line_str 0 : { *(.debug_line_str) }
 .debug_loclists 0 : { *(.debug_loclists) }
 .debug_rnglists 0 : { *(.debug_rnglists) }
    /DISCARD/ : { *(.note.GNU-stack) }
    .ARM.attributes 0 :
 {
 KEEP(*(.ARM.attributes))
 KEEP(*(.gnu.attributes))
 }
   
.last_section :
{
  LONG(0xE015E015)
} > FLASH
_flash_used = LOADADDR(.last_section) + SIZEOF(.last_section) - __rom_region_start;
    }
