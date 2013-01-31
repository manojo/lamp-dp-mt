StringReplace[-- VHDL Model Created for "system firModule"        <>Null<>;<>Null<>;<>Null<>;<>Null<>;               , --------- ->                                              ]
              -- 23/4/2010 14:36:40.441920
              -- Alpha2Vhdl Version 0.9                                                              END BEHAVIOURAL;               -- Components for calls to external functions

              LIBRARY IEEE;                                                                                                         -- Component for cellfirModule1
              USE IEEE.std_logic_1164.all;                                                                                          COMPONENT cellFirModule1
              USE IEEE.std_logic_signed.all;                                                                                        PORT(
              USE IEEE.numeric_std.all;                                                                                               clk: IN STD_LOGIC;
                                                                                                                                      CE : IN STD_LOGIC;
              USE work.TYPES.all                                                                                                      Rst : IN STD_LOGIC;
                                                                                                                                      H_mirr1 : IN SIGNED (15 DOWNTO 0);
              ENTITY firModule IS                                                                                                     x_mirr1 : IN SIGNED (15 DOWNTO 0);
              PORT(                                                                                                                   Y : OUT SIGNED (15 DOWNTO 0);
                clk: IN STD_LOGIC;                                                                                                    xPipe : OUT SIGNED (15 DOWNTO 0);
                CE : IN STD_LOGIC;                                                                                                    HPipeES : OUT SIGNED (15 DOWNTO 0);
                Rst : IN STD_LOGIC;                                                                                                   xPipeES : OUT SIGNED (15 DOWNTO 0)
                H_mirr1In : IN  SIGNED (15 DOWNTO 0);                                                                               );
                x_mirr1In : IN  SIGNED (15 DOWNTO 0);                                                                               END COMPONENT;
                YOut : OUT Array0To5OfInteger
              );                                                                                                                    -- Component for cellfirModule3
              END firModule;                                                                                                        COMPONENT cellFirModule3
                                                                                                                                    PORT(
              ARCHITECTURE behavioural OF firModule IS                                                                                clk: IN STD_LOGIC;
                  SIGNAL HPipe_ctl1P_Init :  STD_LOGIC;                                                                               CE : IN STD_LOGIC;
                  SIGNAL xPipe_ctl2P_Init :  STD_LOGIC;                                                                               Rst : IN STD_LOGIC;
                  SIGNAL H_mirr1 :  SIGNED (15 DOWNTO 0);                                                                             Y_reg7loc : IN SIGNED (15 DOWNTO 0);
                  SIGNAL x_mirr1 :  SIGNED (15 DOWNTO 0);                                                                             xPipe_reg5loc : IN SIGNED (15 DOWNTO 0);
                  SIGNAL Y : Array0To5OfInteger;                                                                                      HPipeES_reg4loc : IN SIGNED (15 DOWNTO 0);
                  SIGNAL Y1 :  SIGNED (15 DOWNTO 0);                                                                                  xPipeES_reg3loc : IN SIGNED (15 DOWNTO 0);
                  SIGNAL Y_reg7loc : Array1To6OfInteger;                                                                              xPipe_ctl2P_reg2loc : IN STD_LOGIC;
                  SIGNAL xPipe1 :  SIGNED (15 DOWNTO 0);                                                                              HPipe_ctl1P_reg1loc : IN STD_LOGIC;
                  SIGNAL xPipe_reg5loc : Array1To6OfInteger;                                                                          Y : OUT SIGNED (15 DOWNTO 0);
                  SIGNAL HPipeES1 :  SIGNED (15 DOWNTO 0);                                                                            xPipe : OUT SIGNED (15 DOWNTO 0);
                  SIGNAL HPipeES_reg4loc : Array1To6OfInteger;                                                                        HPipeES : OUT SIGNED (15 DOWNTO 0);
                  SIGNAL xPipeES1 :  SIGNED (15 DOWNTO 0);                                                                            xPipeES : OUT SIGNED (15 DOWNTO 0);
                  SIGNAL xPipeES_reg3loc : Array1To6OfInteger;                                                                        xPipe_ctl2P : OUT STD_LOGIC;
                  SIGNAL Y3 : Array2To5OfInteger;                                                                                     HPipe_ctl1P : OUT STD_LOGIC
                  SIGNAL xPipe3 : Array2To5OfInteger;                                                                               );
                  SIGNAL HPipeES3 : Array2To5OfInteger;                                                                             END COMPONENT;
                  SIGNAL xPipeES3 : Array2To5OfInteger;
                  SIGNAL xPipe_ctl2P3 : Array2To5OfBoolean;                                                                         -- Component for cellfirModule4
                  SIGNAL xPipe_ctl2P_reg2loc : Array2To6OfBoolean;                                                                  COMPONENT cellFirModule4
                  SIGNAL HPipe_ctl1P3 : Array2To5OfBoolean;                                                                         PORT(
                  SIGNAL HPipe_ctl1P_reg1loc : Array2To6OfBoolean;                                                                    clk: IN STD_LOGIC;
                  SIGNAL Y4 :  SIGNED (15 DOWNTO 0);                                                                                  CE : IN STD_LOGIC;
                  SIGNAL xPipe4 :  SIGNED (15 DOWNTO 0);                                                                              Rst : IN STD_LOGIC;
                  SIGNAL HPipeES4 :  SIGNED (15 DOWNTO 0);                                                                            Y_reg7loc : IN SIGNED (15 DOWNTO 0);
                  SIGNAL xPipeES4 :  SIGNED (15 DOWNTO 0);                                                                            xPipe_reg5loc : IN SIGNED (15 DOWNTO 0);
                  SIGNAL xPipe_ctl2P4 :  STD_LOGIC;                                                                                   HPipeES_reg4loc : IN SIGNED (15 DOWNTO 0);
                  SIGNAL HPipe_ctl1P4 :  STD_LOGIC;                                                                                   xPipeES_reg3loc : IN SIGNED (15 DOWNTO 0);
                  SIGNAL HPipe_ctl1P_Init_In :  STD_LOGIC;                                                                            HPipe_ctl1P_Init_In : IN STD_LOGIC;
                  SIGNAL xPipe_ctl2P_Init_In :  STD_LOGIC;                                                                            xPipe_ctl2P_Init_In : IN STD_LOGIC;
                                                                                                                                      Y : OUT SIGNED (15 DOWNTO 0);
                                                                                                                                      xPipe : OUT SIGNED (15 DOWNTO 0);
                -- Insert missing components here!                                                                                    HPipeES : OUT SIGNED (15 DOWNTO 0);
                                                                                                                                      xPipeES : OUT SIGNED (15 DOWNTO 0);
              ---------                                                                                                               xPipe_ctl2P : OUT STD_LOGIC;
                -- $MissingComponents$                                                                                                HPipe_ctl1P : OUT STD_LOGIC
                                                                                                                                    );
                                                                                                                                    END COMPONENT;
              BEGIN
                                                                                                                                    -- Component for ControlfirModule
                H_mirr1 <= H_mirr1In;                                                                                               COMPONENT controlFirModule
                                                                                                                                    PORT(
                HPipe_ctl1P_Init_In <= HPipe_ctl1P_Init;                                                                              clk: IN STD_LOGIC;
                                                                                                                                      CE : IN STD_LOGIC;
                G1 : FOR p IN 3 TO 6 GENERATE                                                                                         Rst : IN STD_LOGIC;
                  HPipe_ctl1P_reg1loc(p) <= HPipe_ctl1P3(-1 + p);                                                                     HPipe_ctl1P_Init : OUT STD_LOGIC;
                END GENERATE;                                                                                                         xPipe_ctl2P_Init : OUT STD_LOGIC
                                                                                                                                    );
                HPipe_ctl1P_reg1loc(2) <= HPipe_ctl1P4;                                                                             END COMPONENT;

                HPipeES_reg4loc(1) <= HPipeES1;

                G2 : FOR p IN 3 TO 6 GENERATE
                  HPipeES_reg4loc(p) <= HPipeES3(-1 + p);
                END GENERATE;

                HPipeES_reg4loc(2) <= HPipeES4;

                x_mirr1 <= x_mirr1In;

                xPipe_ctl2P_Init_In <= xPipe_ctl2P_Init;

                G3 : FOR p IN 3 TO 6 GENERATE
                  xPipe_ctl2P_reg2loc(p) <= xPipe_ctl2P3(-1 + p);
                END GENERATE;

                xPipe_ctl2P_reg2loc(2) <= xPipe_ctl2P4;

                xPipeES_reg3loc(1) <= xPipeES1;

                G4 : FOR p IN 3 TO 6 GENERATE
                  xPipeES_reg3loc(p) <= xPipeES3(-1 + p);
                END GENERATE;

                xPipeES_reg3loc(2) <= xPipeES4;

                xPipe_reg5loc(1) <= xPipe1;

                G5 : FOR p IN 3 TO 6 GENERATE
                  xPipe_reg5loc(p) <= xPipe3(-1 + p);
                END GENERATE;

                xPipe_reg5loc(2) <= xPipe4;

                Y(0) <= Y1;

                G6 : FOR p IN 2 TO 5 GENERATE
                  Y(p) <= Y3(p);
                END GENERATE;

                Y(1) <= Y4;

                G7 : FOR p IN 0 TO 5 GENERATE
                  YOut(p) <= Y(p);
                END GENERATE;

                Y_reg7loc(1) <= Y1;

                G8 : FOR p IN 3 TO 6 GENERATE
                  Y_reg7loc(p) <= Y3(-1 + p);
                END GENERATE;

                Y_reg7loc(2) <= Y4;

