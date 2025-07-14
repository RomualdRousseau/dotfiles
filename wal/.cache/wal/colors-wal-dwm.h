static const char norm_fg[] = "#d9cbd1";
static const char norm_bg[] = "#150c11";
static const char norm_border[] = "#978e92";

static const char sel_fg[] = "#d9cbd1";
static const char sel_bg[] = "#6D41AB";
static const char sel_border[] = "#d9cbd1";

static const char urg_fg[] = "#d9cbd1";
static const char urg_bg[] = "#672CA5";
static const char urg_border[] = "#672CA5";

static const char *colors[][3]      = {
    /*               fg           bg         border                         */
    [SchemeNorm] = { norm_fg,     norm_bg,   norm_border }, // unfocused wins
    [SchemeSel]  = { sel_fg,      sel_bg,    sel_border },  // the focused win
    [SchemeUrg] =  { urg_fg,      urg_bg,    urg_border },
};
