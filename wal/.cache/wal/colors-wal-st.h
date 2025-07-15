const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#200e18", /* black   */
  [1] = "#903de7", /* red     */
  [2] = "#854ed1", /* green   */
  [3] = "#875b9b", /* yellow  */
  [4] = "#9f3ad2", /* blue    */
  [5] = "#8f52b1", /* magenta */
  [6] = "#219c8d", /* cyan    */
  [7] = "#9b9097", /* white   */

  /* 8 bright colors */
  [8]  = "#7d6671",  /* black   */
  [9]  = "#903ee7",  /* red     */
  [10] = "#854fd1", /* green   */
  [11] = "#9766AD", /* yellow  */
  [12] = "#9f3ad2", /* blue    */
  [13] = "#A860D1", /* magenta */
  [14] = "#2DD1BD", /* cyan    */
  [15] = "#c7c2c5", /* white   */

  /* special colors */
  [256] = "#200e18", /* background */
  [257] = "#c7c2c5", /* foreground */
  [258] = "#c7c2c5",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
