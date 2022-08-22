/* RTVRCYDMN CODE INCLUDE */

             RTVRCYDMN  CRG(IASP01) RCYDMN(&CRGRTN) CRGACT(&STS)

             CHGVAR     VAR(&WKCLUOK) VALUE('1')

             IF         COND(&STS *NE '1') +
                          THEN(DO)
                        SNDPGMMSG MSG('NODE IS INACTIVE')
             CHGVAR     VAR(&WKCLUOK) VALUE(0)
             GOTO       CMDLBL(RCY_END)
             ENDDO

             CHGVAR     VAR(%OFFSET(&CRGPTR)) +
                          VALUE(%OFFSET(&CRGPTR) + 4)

             IF         COND(&LISTNUM *EQ 0) THEN(DO)
             SNDPGMMSG  MSG('NO CRG FOUND')
             CHGVAR     VAR(&WKCLUOK) VALUE(0)
             GOTO       CMDLBL(RCY_END)
             ENDDO

             DOFOR      VAR(&I) FROM(1) TO(&LISTNUM)
             CHGVAR     VAR(&NODESTS) VALUE(&CRGSTS)
             CHGVAR     VAR(&NODETYP) VALUE(&CRGTYP)
             SNDPGMMSG  MSG(&CRGNOD *CAT &NODESTS *CAT '  ' *CAT &NODETYP)
             IF         COND(&NODESTS *EQ 'INACTIVE') THEN(DO)
             CHGVAR     VAR(&WKCLUOK) VALUE(0)
             GOTO       CMDLBL(RCY_END)
             ENDDO
             CHGVAR     VAR(%OFFSET(&CRGPTR)) +
                          VALUE(%OFFSET(&CRGPTR) + &CRGOFF)
             ENDDO

 RCY_END:
