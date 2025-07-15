static const char norm_fg[] = "#c7c2c5";
static const char norm_bg[] = "#200e18";
static const char norm_border[] = "#7d6671";

static const char sel_fg[] = "#c7c2c5";
static const char sel_bg[] = "#854ed1";
static const char sel_border[] = "#c7c2c5";

static const char urg_fg[] = "#c7c2c5";
static const char urg_bg[] = "#903de7";
static const char urg_border[] = "#903de7";

static const char *colors[][3]      = {
    /*               fg           bg         border                         */
    [SchemeNorm] = { norm_fg,     norm_bg,   norm_border }, // unfocused wins
    [SchemeSel]  = { sel_fg,      sel_bg,    sel_border },  // the focused win
    [SchemeUrg] =  { urg_fg,      urg_bg,    urg_border },
};
