//START_TABLE sw_reg
`SWREG_W(KNN_RESET,   1, 0) // KNN soft reset
`SWREG_W(KNN_ENABLE,  1, 0) // KNN enable
`SWREG_W(KNN_X,    32, 0) // KNN point A
`SWREG_W(KNN_Y,    32, 0) // KNN point B
`SWREG_R(KNN_INFO, 8, 0) //
`SWREG_W(KNN_ID,   4, 0)
`SWREG_W(KNN_READY, 1, 0)
`SWREG_W(KNN_GET, 1, 0)
