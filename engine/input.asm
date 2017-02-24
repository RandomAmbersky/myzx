  MODULE input

  ;------------------------------------------------------------------
  ; Inspired by ZX Spectrum libzx library by Sebastian Mihai, 2016
  ;-------------------------------------------------------------------

KEY_B_BIT equ 4
KEY_H_BIT equ 4
KEY_Y_BIT equ 4
KEY_6_BIT equ 4
KEY_5_BIT equ 4
KEY_T_BIT equ 4
KEY_G_BIT equ 4
KEY_V_BIT equ 4

KEY_N_BIT equ 3
KEY_J_BIT equ 3
KEY_U_BIT equ 3
KEY_7_BIT equ 3
KEY_4_BIT equ 3
KEY_R_BIT equ 3
KEY_F_BIT equ 3
KEY_C_BIT equ 3

KEY_M_BIT equ 2
KEY_K_BIT equ 2
KEY_I_BIT equ 2
KEY_8_BIT equ 2
KEY_3_BIT equ 2
KEY_E_BIT equ 2
KEY_D_BIT equ 2
KEY_X_BIT equ 2

KEY_SYMBOL_SHIFT_BIT equ 1
KEY_L_BIT equ 1
KEY_O_BIT equ 1
KEY_9_BIT equ 1
KEY_2_BIT equ 1
KEY_W_BIT equ 1
KEY_S_BIT equ 1
KEY_Z_BIT equ 1

KEY_SPACE_BIT equ 0
KEY_ENTER_BIT equ 0
KEY_P_BIT equ 0
KEY_0_BIT equ 0
KEY_1_BIT equ 0
KEY_Q_BIT equ 0
KEY_A_BIT equ 0
KEY_CAPS_SHIFT_BIT equ 0

port_keys_b_n_m_ss_sp equ #7F
port_keys_h_j_k_l_en equ #BF
port_keys_y_u_i_o_p equ #DF
port_keys_6_7_8_9_0 equ #EF
port_keys_5_4_3_2_1 equ #F7
port_keys_t_r_e_w_q equ #FB
port_keys_g_f_d_s_a equ #FD
port_keys_v_c_x_z_cs equ #FE

  ; универсальные коды :)
PRESS_FIRE equ  %11111111
PRESS_UP equ    %00000001
PRESS_DOWN equ  %00000010
PRESS_RIGHT equ %00000100
PRESS_LEFT equ  %00001000

  ; ожидание ввода одной из клавиш синклер-джойстика
  ; после нажатия возвращаем код PRESS_X в A
get_sinclair_key:
    LD A, port_keys_6_7_8_9_0
    IN A, (#FE)
    BIT KEY_6_BIT, A
    JR Z,key_press_left
    BIT KEY_7_BIT, A
    JR Z,key_press_right
    BIT KEY_8_BIT, A
    JR Z,key_press_down
    BIT KEY_9_BIT, A
    JR Z,key_press_up
    BIT KEY_0_BIT, A
    JR Z,key_press_fire
    JR get_sinclair_key
key_press_left:
    LD A, PRESS_LEFT
    RET
key_press_right:
    LD A, PRESS_RIGHT
    RET
key_press_down:
    LD A, PRESS_DOWN
    RET
key_press_up:
    LD A, PRESS_UP
    RET
key_press_fire:
    LD A, PRESS_FIRE
    RET

  ; How to read the keyboard:
  ;
  ; Step 1 - select key row in the accumulator by loading port number to the left
  ;
  ; $7F - B, N, M, Symbol Shift, Space
  ; $BF - H, J, K, L, Enter
  ; $DF - Y, U, I, O, P
  ; $EF - 6, 7, 8, 9, 0
  ; $F7 - 5, 4, 3, 2, 1
  ; $FB - T, R, E, W, Q
  ; $FD - G, F, D, S, A
  ; $FE - V, C, X, Z, Caps Shift
  ;
  ;       4  3  2  1  0        These bits will be 0 if the corresponding
  ;                            key is pressed
  ; Step 2 - in a, ($FE)
  ; Step 3 - look for bit values of 0 to find pressed keys, as shown above

  ; example

  ; ld a, port_keys_b_n_m_ss_sp
  ; in a, ($FE)
  ; BIT KEY_M_BIT, A
  ; JR Z,a_PRESSED
  ; ...

  ENDMODULE
