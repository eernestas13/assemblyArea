PROGRAM Assignment
  VAR
    sortArea AT %IX100.1 : BOOL;
    sortAreaMetal AT %IX100.4 : BOOL;
    sortSol AT %QX100.0 : BOOL;
    ChainConv AT %QX100.1 : BOOL;
    BeltConv AT %QX100.2 : BOOL;
  END_VAR
  VAR
    sortTimer : DINT;
  END_VAR
  VAR
    alwaysON AT %M0.0 : BOOL;
    sortTimeOut AT %M0.1 : BOOL;
    QFull AT %M0.2 : BOOL;
    QEmpty AT %M0.3 : BOOL;
  END_VAR
  VAR
    TON0 : TON;
    CTUD0 : CTUD;
    R_TRIG1 : R_TRIG;
  END_VAR

  alwaysON := NOT(alwaysON) OR alwaysON;
  ChainConv := alwaysON;
  BeltConv := alwaysON;
  sortSol := NOT(sortTimeOut) AND (NOT(sortAreaMetal) AND sortArea OR sortSol);
  TON0(IN := sortSol, PT := T#3.5s);
  sortTimeOut := TON0.Q;
  R_TRIG1(CLK := sortTimeOut);
  CTUD0(CU := R_TRIG1.Q, LD := 0, PV := 5);
  QFull := CTUD0.QU;
  QEmpty := CTUD0.QD;
END_PROGRAM


CONFIGURATION Config0

  RESOURCE Res0 ON PLC
    TASK task0(INTERVAL := T#20ms,PRIORITY := 0);
    PROGRAM instance0 WITH task0 : Assignment;
  END_RESOURCE
END_CONFIGURATION
