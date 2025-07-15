/* Taken from https://github.com/djpohly/dwl/issues/466 */
#define COLOR(hex)    { ((hex >> 24) & 0xFF) / 255.0f, \
                        ((hex >> 16) & 0xFF) / 255.0f, \
                        ((hex >> 8) & 0xFF) / 255.0f, \
                        (hex & 0xFF) / 255.0f }

static const float rootcolor[]             = COLOR(0x200e18ff);
static uint32_t colors[][3]                = {
	/*               fg          bg          border    */
	[SchemeNorm] = { 0xc7c2c5ff, 0x200e18ff, 0x7d6671ff },
	[SchemeSel]  = { 0xc7c2c5ff, 0x854ed1ff, 0x903de7ff },
	[SchemeUrg]  = { 0xc7c2c5ff, 0x903de7ff, 0x854ed1ff },
};
