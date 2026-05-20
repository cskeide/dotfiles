-- Input config for sydney (Norwegian keyboard, desktop — no touchpad, no accel)
hl.config({
    input = {
        kb_layout  = "no",
        kb_variant = "nodeadkeys",
        kb_model   = "",
        kb_options = "lv3:ralt_switch_none,grp:alt_space_toggle",
        kb_rules   = "",

        follow_mouse   = 1,
        sensitivity    = 0,
        force_no_accel = true,

        touchpad = {
            natural_scroll = true,
        },
    },
})
