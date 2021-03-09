//START_TABLE sw_reg
`SWREG_W(KNN_RESET,          1, 0) // KNN soft reset
`SWREG_W(KNN_ENABLE,         1, 0) // KNN enable
`SWREG_W(KNN_X,        32, 0) // KNN point A
`SWREG_W(KNN_Y,         32, 0) // KNN point B
`SWREG_W(KNN_LABEL, 8, 0) // Train point label
`SWREG_R(KNN_DIST,         32, 0) // KNN distance (A,B)
