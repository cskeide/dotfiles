-- Monitor config for sydney (dual Dell monitors)
hl.monitor({
    output   = "desc:Dell Inc. DELL U2515H 9X2VY72609UL",
    mode     = "2560x1440",
    position = "0x0",
    scale    = 1,
})
hl.monitor({
    output   = "desc:Dell Inc. DELL U2715H GH85D72K28SS",
    mode     = "2560x1440",
    position = "auto-right",
    scale    = 1,
})

-- Left monitor (U2515H) — workspace 1 only
hl.workspace_rule({ workspace = "1", monitor = "desc:Dell Inc. DELL U2515H 9X2VY72609UL", default = true, persistent = true })

-- Right monitor (U2715H) — workspaces 2-5
hl.workspace_rule({ workspace = "2", monitor = "desc:Dell Inc. DELL U2715H GH85D72K28SS", default = true, persistent = true })
hl.workspace_rule({ workspace = "3", monitor = "desc:Dell Inc. DELL U2715H GH85D72K28SS", persistent = true })
hl.workspace_rule({ workspace = "4", monitor = "desc:Dell Inc. DELL U2715H GH85D72K28SS", persistent = true })
hl.workspace_rule({ workspace = "5", monitor = "desc:Dell Inc. DELL U2715H GH85D72K28SS", persistent = true })
