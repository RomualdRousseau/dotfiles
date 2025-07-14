const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#150c11", /* black   */
  [1] = "#672CA5", /* red     */
  [2] = "#6D41AB", /* green   */
  [3] = "#9766AD", /* yellow  */
  [4] = "#9537C5", /* blue    */
  [5] = "#A860D1", /* magenta */
  [6] = "#2DD1BD", /* cyan    */
  [7] = "#d9cbd1", /* white   */

  /* 8 bright colors */
  [8]  = "#978e92",  /* black   */
  [9]  = "#672CA5",  /* red     */
  [10] = "#6D41AB", /* green   */
  [11] = "#9766AD", /* yellow  */
  [12] = "#9537C5", /* blue    */
  [13] = "#A860D1", /* magenta */
  [14] = "#2DD1BD", /* cyan    */
  [15] = "#d9cbd1", /* white   */

  /* special colors */
  [256] = "#150c11", /* background */
  [257] = "#d9cbd1", /* foreground */
  [258] = "#d9cbd1",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
