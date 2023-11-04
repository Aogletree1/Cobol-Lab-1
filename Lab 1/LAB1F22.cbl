       IDENTIFICATION DIVISION.
       PROGRAM-ID    LAB1F22
       AUTHOR.     AUSTIN H OGLETREE.
      **********************************************************
      *  This program reads data from an external data file.
      *  It will create a report that could be printed.The output will
      *  contain the name of the salesperson and 
      *  the number of shoes, belts
      *  and socks sold by that salesperson 
      *
      *  INPUT: Each Record will look like this:
      *        FIELD:  name     FIELD LENGTH 20 DATA TYPE ALPHANUMERIC
      *        FIELD:  shoes    FIELD LENGTH 3  DATA TYPE NUMERIC
      *        FIELD:  belts    FIELD LENGTH 3  DATA TYPE NUMERIC
      *        FIELD:  socks    FIELD LENGTH 3  DATA TYPE NUMERIC
      *
      *  OUTPUT: name and original amount read in of shoes, belts
      *          and socks for each salesperson
      *
      *  CALCULATIONS:  THERE ARE NO CALCULATIONS
      *
      *LAB INSTRUCTIONS:
      *    YOU ARE TO FIND ANY ERRORS WHICH I MAY HAVE PUT IN THE
      *    PROGRAM.  YOU ARE TO ALSO LOOK FOR ANY COMMENTS I
      *    HAVE INCLUDED WHICH ARE INSTRUCTIONS.  THESE INSTRUCTIONS
      *    WILL TELL YOU WHAT YOU NEED TO INCLUDE IN YOUR PROGRAM
      *    TO MAKE IT WORK.
      **********************************************************
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SOURCE-COMPUTER.    IBMPC.
       OBJECT-COMPUTER.    IBMPC.

       INPUT OUTPUT SECTION.
       FILE-CONTROL.

      * ASSIGN A FILE NAME FOR THE DISK FILE
      * USE SALES-FILE.TXT AS THE DISK NAME FOR THE INCOMING

           SELECT SALES-FILE     
               ASSIGN TO 'SALES.DAT'
               ORGANIZATION IS LINE SEQUENTIAL.

      * USE SALES-REPORT.TXT FOR THE PRINTER FILE

           SELECT SALES-REPORT-FILE 
             ASSIGN TO 'LAB1.TXT'.

      *
       DATA DIVISION.
       FILE SECTION.

      * SAME NAME AS THE SELECT STATEMENT

       FD    SALES-FILE.
       01    SALES-REC.

      *MUST IDENTIFY AND ACCOUNT FOR ALL FIELDS OF SCOUT-REC OF 
      *THE INCOMING RECORD.
      *USE 05 LEVELS 

          05  SR-NAME                  PIC X(20).
          05  SR-SHOES                 PIC 9(3).
          05  SR-BELTS                 PIC 9(3).
          05  SR-SOCKS                 PIC 9(3).
      *
       FD    SALES-REPORT-FILE.
       01    SALES-REPORT-REC    PIC X(80).

      ********
       WORKING-STORAGE SECTION.
       O1    WS-WORK-AREAS.
             05    ARE-THERE-MORE-RECORDS    PIC X(3) VALUE 'YES'.

      *************************OUTPUT AREA**************************
       01 REPORT-HEADER.
          05 FILLER          PIC X(34) VALUE SPACES.
          05 FILLER          PIC X(12) VALUE 'SALES REPORT'.
      *
       01 DETAIL-LINE.
          05 FILLER          PIC X(5) VALUE SPACES.
          05 DL-NAME-OUT     PIC X(20).
          05 FILLER          PIC X(5) VALUE SPACES.
          05 DL-SHOES-OUT    PIC 999.
          05 FILLER          PIC X(5) VALLUE SPACES.
          05 DL-BELTS-OUT    PIC 999.
          05 FILLER          PIC X(5) VALUE SPACES.
          05 DL-SOCKS-OUT    PIC 999.
      *

       PROCEDURE DIVISION.

       100-MAIN-MODULE.

           PERFORM 125-HOUSKEEPING
           PERFORM 150-READ-RECORDS
           PERFORM 250-END-ROUTINE

           .
      *
       125-HOUSEKEEPING.

      *SAME FILE NAME AS SELECT STATEMENT

           OPEN    INPUT SALES-FILE
                   OUTPUT    SALES-REPORT-FILE

           MOVE REPORT-HEADER TO SALES-REPORT-REC
           WRITE SALES-REPORT-REC 
                   AFTER ADVANCING 1 LINE
           .
      *
       150-READ-RECORDS.

             PERFORM UNTIL ARE-THERE-MORE-RECORDS = 'NO'
                  READ SALES-FILE
                      AT END
                          MOVE 'NO' TO ARE-THERE-MORE-RECORDS
                      NOT AT END
                          PERFORM 200-PROCESS-RTN
                  END-READ
              END-PERFORM
           .
      *
       200-PROCESS-RTN.

      *MOVE YOUR INCOMING FIELD TO YOUR OUTGOING FIELDS IN THE DETAIL
      *LINE GROUP ABOVE

              MOVE   SR-NAME     TO DL-NAME-OUT
              MOVE   SR-SHOES    TO DL-SHOES-OUT
              MOVE   SR-BELTS    TO DL-BELTS-OUT
              MOVE   SR-SOCKS    TO DL-SOCKS-OUT


      * MOVE THE ENTIRE DETAIL-LINE GROUP
      * IN THE OUTPUT ARE TO THE SALES-REPORT-REC WHICH IS CONNECTED 
      * TO THE EXTERNAL REPORT FILE.

              MOVE DETAIL-LINE      TO SALES-REPORT-REC  

      * WRITE OUT WHAT IS IN THE REPORT-REC MEMORY TO THE EXTERNAL
      * FILE THAT IT IS CONNECTED TO

              WRITE SALES-REPORT-REC AFTER 
                   ADVANCING 1 LINE
           .

       250-CLOSE-ROUTINE.        

      *SAME FILE NAME AS SELECT STATEMENT

              CLOSE    SALES-FILE
                 SALES-REPORT-FILE
                 STOP RUN
            
           .

