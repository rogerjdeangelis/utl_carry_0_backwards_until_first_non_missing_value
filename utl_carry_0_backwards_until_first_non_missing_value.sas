Carry 0 backwards until first non missing value

  WPS/SAS same result

see
https://mail.google.com/mail/u/0/#inbox/161adca188ac9c81

INPUT
=====

WORK.HAVE total obs=18

    PT     FLAG  |  RULE   RETFLG
                 |
   1002      .   |           0
   1002      .   |           0
   1002      .   |           0
   1002      1   |           1
   1002      .   |           1
   1002      .   |           1
   1002      .   |           1
   1002      .   |           1
   1002      .   |           1

   1003      .   |           0
   1003      .   |           0
   1003      .   |           0
   1003      .   |           0
   1003      .   |           0
   1003      1   |           1
   1003      .   |           1
   1003      .   |           1
   1003      .   |           1


PROCESS
=======

data want;
  retain retFlg been_there .;
  do until (last.pt);
    set have;
    by pt;
    if flag=. and been_there=. then do;
       retFLg=0;
       been_there=1;
    end;
  end;
  been_there=.;
  do until (last.pt);
    set have;
    by pt;
    if flag=. and been_there=. then do;
       retFlg=0 ;
       been_there=1;
    end;
    else if flag ne . then do;
      retflg=flag;
    end;
    output;
  end;
run;quit;

OUTPUT
=====

The WPS System

 WORK.WANT total obs=18

    PT     FLAG   RETFLG

   1002      .      0
   1002      .      0
   1002      .      0
   1002      1      1
   1002      .      1
   1002      .      1
   1002      .      1
   1002      .      1
   1002      .      1

   1003      .      0
   1003      .      0
   1003      .      0
   1003      .      0
   1003      .      0
   1003      1      1
   1003      .      1
   1003      .      1
   1003      .      1

*                _              _       _
 _ __ ___   __ _| | _____    __| | __ _| |_ __ _
| '_ ` _ \ / _` | |/ / _ \  / _` |/ _` | __/ _` |
| | | | | | (_| |   <  __/ | (_| | (_| | || (_| |
|_| |_| |_|\__,_|_|\_\___|  \__,_|\__,_|\__\__,_|

;

data have;
informat PT ADT AVISITN ASTDT AENDT AVAL adt2 $10.;
input PT ADT AVISITN ASTDT AENDT AVAL adt2 flag;
drop ADT AVISITN ASTDT AENDT AVAL adt2;
cards4;
1002 15Nov2013 0 24Oct2013 30Oct2013 14.000 29Nov2013 .
1002 15Nov2013 1 30Oct2013 05Nov2013 14.000 29Nov2013 .
1002 15Nov2013 2 06Nov2013 12Nov2013 14.000 29Nov2013 .
1002 15Nov2013 3 13Nov2013 19Nov2013 14.000 29Nov2013 1
1002 15Nov2013 4 20Nov2013 26Nov2013 14.000 29Nov2013 .
1002 15Nov2013 5 27Nov2013 03Dec2013 14.000 29Nov2013 .
1002 15Nov2013 6 04Dec2013 10Dec2013 14.000 29Nov2013 .
1002 15Nov2013 7 11Dec2013 17Dec2013 14.000 29Nov2013 .
1002 15Nov2013 8 18Dec2013 24Dec2013 14.000 29Nov2013 .
1003 15Nov2013 0 24Oct2013 30Oct2013 14.000 29Nov2013 .
1003 15Nov2013 1 30Oct2013 05Nov2013 14.000 29Nov2013 .
1003 15Nov2013 2 06Nov2013 12Nov2013 14.000 29Nov2013 .
1003 15Nov2013 3 13Nov2013 19Nov2013 14.000 29Nov2013 .
1003 15Nov2013 4 20Nov2013 26Nov2013 14.000 29Nov2013 .
1003 15Nov2013 5 27Nov2013 03Dec2013 14.000 29Nov2013 1
1003 15Nov2013 6 04Dec2013 10Dec2013 14.000 29Nov2013 .
1003 15Nov2013 7 11Dec2013 17Dec2013 14.000 29Nov2013 .
1003 15Nov2013 8 18Dec2013 24Dec2013 14.000 29Nov2013 .
;;;;
run;quit;

*          _       _   _
 ___  ___ | |_   _| |_(_) ___  _ __
/ __|/ _ \| | | | | __| |/ _ \| '_ \
\__ \ (_) | | |_| | |_| | (_) | | | |
|___/\___/|_|\__,_|\__|_|\___/|_| |_|

;

%utl_submit_wps64('
libname wrk sas7bdat "%sysfunc(pathname(work))";
data wrk.wantwps;
  retain retFlg been_there .;
  do until (last.pt);
    set wrk.have;
    by pt;
    if flag=. and been_there=. then do;
       retFLg=0;
       been_there=1;
    end;
  end;
  been_there=.;
  do until (last.pt);
    set wrk.have;
    by pt;
    if flag=. and been_there=. then do;
       retFlg=0 ;
       been_there=1;
    end;
    else if flag ne . then do;
      retflg=flag;
    end;
    output;
  end;
run;quit;
proc print;
run;quit;
');

data want;
  retain retFlg been_there .;
  do until (last.pt);
    set have;
    by pt;
    if flag=. and been_there=. then do;
       retFLg=0;
       been_there=1;
    end;
  end;
  been_there=.;
  do until (last.pt);
    set have;
    by pt;
    if flag=. and been_there=. then do;
       retFlg=0 ;
       been_there=1;
    end;
    else if flag ne . then do;
      retflg=flag;
    end;
    output;
  end;
run;quit;


