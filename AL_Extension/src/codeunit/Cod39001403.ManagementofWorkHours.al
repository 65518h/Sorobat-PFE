
Codeunit 39001403 "Management of Work Hours"
{
    //GL2024  ID dans Nav 2009 : "39001403"
    TableNo = "Heures sup. m";

    trigger OnRun()
    var
        HeuresSupEreg: Record "Heures sup. eregistrées m";
        NTransaction: Integer;
        Window: Dialog;
    begin
        HeuresSupEreg.Reset;
        if HeuresSupEreg.Find('+')
          then
            NTransaction := HeuresSupEreg."N° transaction" + 1
        else
            NTransaction := 1;

        with Rec do begin
            if Find('-')
              then begin
                Window.Open('Validation des lignes d''heures sup. en cours :\' +
                             '  N° ligne    : #######1\' +
                             '  N° salarié  : #######2\');
                LockTable;
                repeat
                    Window.Update(1, "N° Ligne");
                    Window.Update(2, "N° Salarié");
                    CalculerRémunérationHeuresSup(NTransaction, Rec);
                until Next = 0;
                Window.Close;
            end
            else
                Error('Erreur :\Le formulaire est vide.\Impossible de poursuivre.');
        end;
    end;

    var
        SuppHourLines: Record "Heures sup. eregistrées m";
        Contrat: Record "Employment Contract";
        LigRegim: record "Bon Reglement";
        PramRessHum: Record "Human Resources Setup";
        RecIndemnity: Record "Default Indemnities";
        DecTarif: Decimal;
        Employee: Record Employee;


    procedure "CalculerRémunérationHeuresSup"("N°Transaction": Integer; LigneHeureSup: Record "Heures sup. m")
    var
        "Salarié": Record Employee;
        HeuresSupEnreg: Record "Heures sup. eregistrées m";
        NewLigneHeureSup: Record "Heures sup. m";
        LigneHeureSupSlr: Record "Heures sup. m";
        Total: Decimal;
        "RégimeTravail": record "Regimes of work";
        errorSlrNotFound: label 'Erreur :\Salarié introuvable. Vérifier le N° salarié saisi.';
        errorRegTravailSlr: label 'Erreur :\La mention du Régime de travail auquel appartient le salarié est un paramètre indispensable\à la poursuite du calacul.\Veuillez vérifier ce paramètre sur la fiche salarié.\N° salarié  : ##########1\Nom salarié : ###########################2';
        NbrHeures: Decimal;
        DSemaine: Date;
        FSemaine: Date;
        Std: Decimal;
        TarifHorraire: Decimal;
        IndSlr: Record "Default Indemnities";
        CodeInd: record Indemnity;
        TotalInd: Decimal;
        ParamRessHum: Record "Human Resources Setup";
        NbrHeuresTmp: Decimal;
        i: Integer;
        NbreHeureInit: Decimal;
        Heuresup: Decimal;
    begin
        /*//IF RégimeTravail.FIND('-') THEN                  //  RAMZI POUR ALTEK
        //IF  RégimeTravail."Appliquer Régime" = TRUE THEN  //  RAMZI POUR ALTEK
         BEGIN
          IF NOT Salarié.GET (LigneHeureSup."N° Salarié") THEN
            ERROR (errorSlrNotFound);
            Salarié.CALCFIELDS("Heures sup. validées");
            Contrat.GET(Salarié."Emplymt. Contract Code");
             IF Contrat."Appliquer Heure Supp"=FALSE THEN
              ERROR('Salarié %1 ne peut Pas avoir des Heurs Supp !!',Salarié."No.");
               IF NOT RégimeTravail.GET (Contrat."Regimes of work") THEN
                ERROR (errorRegTravailSlr,Salarié."No.",(Salarié."First Name" + ' ' +Salarié."Last Name"));

                LigRegim.RESET;
                LigRegim.ASCENDING(FALSE);
                LigRegim.SETFILTER("Regime of work",Contrat."Regimes of work");
                LigRegim.SETFILTER("Lower limit",'>0');

                IF NOT LigRegim.FIND('-') THEN
                ERROR (errorRegTravailSlr,Salarié."No.",(Salarié."First Name" + ' ' +Salarié."Last Name"));

               IF LigneHeureSup.Date = 0D THEN
                 ERROR ('Erreur :\La Date doit être mentionnée sur la ligne\'+
                 'N° ligne    : %1\'+
                 'N° salarié  : %2\'+
                 'Impossible de poursuivre.',LigneHeureSup."N° Ligne",LigneHeureSup."N° Salarié");

        //Std           := RégimeTravail."Durée hebdomadaire étendue"
        //               - RégimeTravail."Durée hebdomadaire normale";
        FSemaine      := CALCDATE ('<CW>',LigneHeureSup.Date);
        DSemaine      := FSemaine - 6;

        //  RH
        IF Salarié."Employee's type" = Salarié."Employee's type"::"Month based" THEN
        TarifHorraire := Salarié."Basis salary" / RégimeTravail."Work Hours per month"
        ELSE
        IF Salarié."Employee's type" = Salarié."Employee's type"::"Month based" THEN
        TarifHorraire := Salarié."Basis salary";

        LigneHeureSup.SETFILTER ("Filtre date",FORMAT(DSemaine)+'..'+FORMAT(FSemaine));
        LigneHeureSup.CALCFIELDS ("Heures sup. enreg.");

        LigneHeureSupSlr.SETRANGE ("N° Salarié",LigneHeureSup."N° Salarié");
        IF LigneHeureSupSlr.FIND ('+') THEN;
        // Chômé Payé
        CASE LigneHeureSup."Type Jours" OF 1 :
             BEGIN
               LigneHeureSup."Tarif unitaire"     := TarifHorraire;
               LigneHeureSup."Taux de majoration" := RégimeTravail."Rate of No Working Paied Day";
               LigneHeureSup."Montant ligne"      := LigneHeureSup."Tarif unitaire"
                                                   * LigneHeureSup."Nombre d'heures"
                                                   * (100 + LigneHeureSup."Taux de majoration") / 100;
             END;
         // Régime de travail Chômé Non Payé
               2 :
             BEGIN
               LigneHeureSup."Tarif unitaire"     := TarifHorraire;
               LigneHeureSup."Taux de majoration" := RégimeTravail."Rate of No Working Day";
               LigneHeureSup."Montant ligne"      := LigneHeureSup."Tarif unitaire"
                                                   * LigneHeureSup."Nombre d'heures"
                                                   * (100 + LigneHeureSup."Taux de majoration") / 100;
             END;

         // Régime de travail de nuit
               3 :
             BEGIN
               LigneHeureSup."Tarif unitaire"     := TarifHorraire;
               LigneHeureSup."Taux de majoration" := RégimeTravail."Rate of Night";
               LigneHeureSup."Montant ligne"      := LigneHeureSup."Tarif unitaire"
                                                   * LigneHeureSup."Nombre d'heures"
                                                   * (100 + LigneHeureSup."Taux de majoration") / 100;
             END;

        // Régime de travail 48 heures
               0,4 :
               IF NOT(NOT (RégimeTravail."Activer Jour Repos") OR (LigneHeureSup."Type Jours"=0)) THEN  BEGIN
               IF RégimeTravail."Activer Jour Repos" THEN
             BEGIN
              // Régime de travail jour Repos
               LigneHeureSup."Tarif unitaire"     := TarifHorraire;
               LigneHeureSup."Taux de majoration" := RégimeTravail."Rate of Repos Days";
               LigneHeureSup."Montant ligne"      := LigneHeureSup."Tarif unitaire"
                                                   * LigneHeureSup."Nombre d'heures"
                                                   * (100 + LigneHeureSup."Taux de majoration") / 100;
             END;
             END
          ELSE
             BEGIN
               i:=0;
               NbrHeuresTmp:=0;
               NbreHeureInit:=LigneHeureSup."Nombre d'heures";
               IF LigneHeureSup."Type heure"=0 THEN BEGIN
               NbrHeures:=RégimeTravail."Work Hours per week"+LigneHeureSup."Nombre d'heures"+LigneHeureSup."Heures sup. enreg.";
               REPEAT
               IF NbrHeures>LigRegim."Lower limit" THEN BEGIN
                  i:=i+1;
                  IF (NbrHeures-LigRegim."Lower limit"-NbrHeuresTmp)> (NbreHeureInit-NbrHeuresTmp) THEN  BEGIN
                    Heuresup:=(NbreHeureInit-NbrHeuresTmp);
                    NbrHeuresTmp:=NbrHeuresTmp+(NbreHeureInit-NbrHeuresTmp);
                    END
                  ELSE
                 BEGIN
                    Heuresup:= (NbrHeures-LigRegim."Lower limit"-NbrHeuresTmp);
                    NbrHeuresTmp:=NbrHeuresTmp+(NbrHeures-LigRegim."Lower limit"-NbrHeuresTmp);
                   END;
                  IF i=1 THEN BEGIN
                  LigneHeureSup."Nombre d'heures"    := Heuresup;
                  LigneHeureSup."Tarif unitaire"     := TarifHorraire;
                  LigneHeureSup."Taux de majoration" := LigRegim."Rate of overcharge";
                  LigneHeureSup."Montant ligne"      := LigneHeureSup."Tarif unitaire"
                                                   * Heuresup
                                                   * (100 + LigneHeureSup."Taux de majoration") / 100;

                    END ELSE BEGIN
                           NewLigneHeureSup.RESET;
                           NewLigneHeureSup.COPY (LigneHeureSup);
                           NewLigneHeureSup."N° Ligne"           := LigneHeureSupSlr."N° Ligne" + (i*1000);
                           NewLigneHeureSup."Nombre d'heures"    := Heuresup;
                           NewLigneHeureSup."Tarif unitaire"     := TarifHorraire;
                           NewLigneHeureSup."Taux de majoration" := LigRegim."Rate of overcharge";
                                                                   //+ RégimeTravail."% sur durée normale";
                           NewLigneHeureSup."Montant ligne"      := NewLigneHeureSup."Tarif unitaire"
                                                                  * Heuresup
                                                                  * (100 + NewLigneHeureSup."Taux de majoration") / 100;


                            NewLigneHeureSup.INSERT;
                            EnregistrerHeuresSup ("N°Transaction",NewLigneHeureSup,WORKDATE);
                       END;
                     END;
               UNTIL (LigRegim.NEXT=0) OR (NbrHeuresTmp>=NbreHeureInit);
               END ELSE BEGIN
                  LigneHeureSup."Tarif unitaire"     := ROUND(TarifHorraire,0.001);
                  LigneHeureSup."Taux de majoration" := RégimeTravail."Rate of Roulement";
                  LigneHeureSup."Montant ligne"      := LigneHeureSup."Tarif unitaire"
                                                   * LigneHeureSup."Nombre d'heures"
                                                   * (100 + LigneHeureSup."Taux de majoration") / 100;

                END;
                //EnregistrerHeuresSup ("N°Transaction",LigneHeureSup,WORKDATE);
             END;

             END;

        LigneHeureSup.MODIFY;


           END;  */


        EnregistrerHeuresSup("N°Transaction", LigneHeureSup, WorkDate);  //  RAMZI POUR ALTEK
        //ELSE            //  RAMZI POUR ALTEK
        //EnregistrerHeuresSup ("N°Transaction",LigneHeureSup,WORKDATE);  //  RAMZI POUR ALTEK

    end;


    procedure EnregistrerHeuresSup("N°Transaction": Integer; HeuresSup: Record "Heures sup. m"; DateValidation: Date)
    var
        HeuresSupEreg: Record "Heures sup. eregistrées m";
        NTransaction: Integer;
        Sal: Record Employee;
    begin

        if ((HeuresSup."N° Salarié" <> '')
            and
            (HeuresSup.Date <> 0D)
            and
            (HeuresSup."Nombre d'heures" <> 0)
          AND
          //(HeuresSup."Tarif unitaire" <> 0)
          //AND
          (HeuresSup."Montant ligne" <> 0)

           ) then begin
            Clear(Sal);
            Sal.Get(HeuresSup."N° Salarié");
            HeuresSupEreg.Reset;
            HeuresSupEreg.Init;
            HeuresSupEreg."N° transaction" := "N°Transaction";
            HeuresSupEreg."N° Ligne" := HeuresSup."N° Ligne";
            HeuresSupEreg."N° Salarié" := HeuresSup."N° Salarié";
            HeuresSupEreg."Nom usuel" := HeuresSup."Nom usuel";
            HeuresSupEreg.Prénom := HeuresSup.Prénom;
            HeuresSupEreg.Date := HeuresSup.Date;
            HeuresSupEreg."Code departement" := HeuresSup."Code departement";
            HeuresSupEreg."Code dossier" := HeuresSup."Code dossier";
            HeuresSupEreg."Employee Statistic Group" := HeuresSup."Employee Statistic Group";
            HeuresSupEreg."Nombre d'heures" := HeuresSup."Nombre d'heures";
            HeuresSupEreg."Tarif unitaire" := HeuresSup."Tarif unitaire";
            HeuresSupEreg."Montant Ligne" := HeuresSup."Montant Ligne";
            HeuresSupEreg."Date comptabilisation" := DateValidation;
            HeuresSupEreg."Mois de paiement" := HeuresSup."Mois de paiement";
            HeuresSupEreg."Année de paiement" := HeuresSup."Année de paiement";
            HeuresSupEreg."Taux de majoration" := HeuresSup."Taux de majoration";
            HeuresSupEreg."Type Jours" := HeuresSup."Type Jours";
            HeuresSupEreg."Type heure" := HeuresSup."Type heure";
            HeuresSupEreg.Système := HeuresSup.Système;
            HeuresSupEreg.Semaine := HeuresSup.Semaine;
            //>> DSFT AGA 120410
            HeuresSupEreg.Quinzaine := HeuresSup.Quinzaine;
            //>> DSFT AGA 120410
            HeuresSupEreg."Employee Posting Group" := Sal."Employee Posting Group";
            /* HeuresSupEreg."Nombre Jours Supp" := HeuresSup."Nombre Jours Supp Maj 75%";
             HeuresSupEreg."Montant Jours Supp" := HeuresSup."Montant Jours Supp";
             HeuresSupEreg.Affectation := HeuresSup.Affectation;
             HeuresSupEreg.Qualification := HeuresSup.Qualification;
             HeuresSupEreg."Heure Normal" := HeuresSup."Heure Normal";
             HeuresSupEreg.Prime := HeuresSup.Prime;*/
            HeuresSupEreg.Insert;
            HeuresSup.Delete;
        end;
    end;


    procedure ValiderHeuresSup()
    var
        "Salarié": Record Employee;
        HeuresSup: Record "Heures sup. m";
        HeuresSupNules: Record "Heures sup. m";
        HeuresSupValides: Record "Heures sup. eregistrées m";
        NTransaction: Integer;
        NLigne: Integer;
        temp: Decimal;
        Somme: Decimal;
        ok: Boolean;
        "actions": Text[30];
        errorEmptyTable: label 'Il n''y a rien à valider : Pas de lignes dans la Table des Heures Sup.';
        dialogWindow: label 'Validation des Heures Sup. en cours :\\   N° Salarié         : #########1\   N° Ligne           : #########2\   Date               : #########3\   Action             : #########4\\\Avancement            : @@@@@@@@@5';
        errorUpdateNeeded: label 'Erreur :\Validation impossible.\Certaines lignes ont des montants nuls.\Veuillez lancer la procédure de calcul en premier.';
        confirmOverPassing: label 'Dépassement du nombre d''''Heures Sup. autorisé.\Poursuivre quand même ?';
        recValid: label 'Enregistrement validé';
        recNotValid: label 'Enregistrement non validé';
        Fenetre: Dialog;
        "RégimeTravail": record "Regimes of work";
    begin
        if not HeuresSup.Find('-') then
            Error(errorEmptyTable);

        HeuresSupNules.SetRange("Montant Ligne", 0);
        if HeuresSupNules.Find('-') then
            Error(errorUpdateNeeded);

        NLigne := 0;
        Fenetre.Open(dialogWindow);
        if not HeuresSupValides.Find('+') then
            NTransaction := 1
        else
            NTransaction := HeuresSupValides."N° transaction" + 1;

        repeat
            Fenetre.Update(1, HeuresSup."N° Salarié");
            Fenetre.Update(2, HeuresSup."N° Ligne");
            Fenetre.Update(3, HeuresSup.Date);
            NLigne := 1;
            if HeuresSup.Count <> 0 then
                temp := ROUND((NLigne / HeuresSup.Count) * 10000, 1)
            else
                temp := 10000;
            NLigne := NLigne + 1;
            Fenetre.Update(5, temp);

            Salarié.Get(HeuresSup."N° Salarié");
            Clear(Contrat);
            Contrat.Get(Salarié."Emplymt. Contract Code");
            Clear(RégimeTravail);
            RégimeTravail.Get(Contrat."Regimes of work");
            if RégimeTravail."Max. Supp. Hours per month" <> 0 then begin
                // MC : Cas des Salariés pour lesquels on a spécifié un Max. heures sup. par Mois
                HeuresSupValides.SetRange(Date, CalcDate('<CM-1M+1D>', WorkDate), CalcDate('<CM>', WorkDate));
                if HeuresSupValides.Find('-') then begin
                    repeat
                        Somme := 0;
                        Somme := HeuresSupValides."Nombre d'heures" + Somme;
                    until HeuresSupValides.Next = 0;
                end;
                if Somme > RégimeTravail."Max. Supp. Hours per month" then begin
                    ok := Confirm(confirmOverPassing, false);
                    if ok then begin
                        // MC : Confirmation de validation (Avec dépassement du Max.)
                        HeuresSupValides."N° transaction" := NTransaction;
                        HeuresSupValides."N° Salarié" := HeuresSup."N° Salarié";
                        HeuresSupValides."N° Ligne" := HeuresSup."N° Ligne";
                        HeuresSupValides.Date := HeuresSup.Date;
                        HeuresSupValides."Mois de paiement" := HeuresSup."Mois de paiement";
                        HeuresSupValides."Année de paiement" := HeuresSup."Année de paiement";
                        HeuresSupValides."Nom usuel" := HeuresSup."Nom usuel";
                        HeuresSupValides.Prénom := HeuresSup.Prénom;
                        HeuresSupValides."Code departement" := HeuresSup."Code departement";
                        HeuresSupValides."Code dossier" := HeuresSup."Code dossier";
                        HeuresSupValides."Nombre d'heures" := HeuresSup."Nombre d'heures";
                        HeuresSupValides."Tarif unitaire" := HeuresSup."Tarif unitaire";
                        HeuresSupValides."Montant Ligne" := HeuresSup."Montant Ligne";
                        HeuresSupValides.Insert;

                        HeuresSup.Delete;

                        actions := recValid;
                    end
                    else
                        // MC : Refus de validation (Avec dépassement du Max.)
                        actions := recNotValid;
                end
                else begin
                    // MC : Validation pour le cas de Max. non dépassé
                    HeuresSupValides."N° transaction" := NTransaction;
                    HeuresSupValides."N° Salarié" := HeuresSup."N° Salarié";
                    HeuresSupValides."N° Ligne" := HeuresSup."N° Ligne";
                    HeuresSupValides.Date := HeuresSup.Date;
                    HeuresSupValides."Mois de paiement" := HeuresSup."Mois de paiement";
                    HeuresSupValides."Année de paiement" := HeuresSup."Année de paiement";
                    HeuresSupValides."Nom usuel" := HeuresSup."Nom usuel";
                    HeuresSupValides.Prénom := HeuresSup.Prénom;
                    HeuresSupValides."Code departement" := HeuresSup."Code departement";
                    HeuresSupValides."Code dossier" := HeuresSup."Code dossier";
                    HeuresSupValides."Nombre d'heures" := HeuresSup."Nombre d'heures";
                    HeuresSupValides."Tarif unitaire" := HeuresSup."Tarif unitaire";
                    HeuresSupValides."Montant Ligne" := HeuresSup."Montant Ligne";
                    HeuresSupValides.Insert;

                    HeuresSup.Delete;

                    actions := recValid;
                end
            end
            else begin
                // MC : Cas des Salariés sans mention du Max du nombre d'heures sup.
                HeuresSupValides."N° transaction" := NTransaction;
                HeuresSupValides."N° Salarié" := HeuresSup."N° Salarié";
                HeuresSupValides."N° Ligne" := HeuresSup."N° Ligne";
                HeuresSupValides.Date := HeuresSup.Date;
                HeuresSupValides."Mois de paiement" := HeuresSup."Mois de paiement";
                HeuresSupValides."Année de paiement" := HeuresSup."Année de paiement";
                HeuresSupValides."Nom usuel" := HeuresSup."Nom usuel";
                HeuresSupValides.Prénom := HeuresSup.Prénom;
                HeuresSupValides."Code departement" := HeuresSup."Code departement";
                HeuresSupValides."Code dossier" := HeuresSup."Code dossier";
                HeuresSupValides."Nombre d'heures" := HeuresSup."Nombre d'heures";
                HeuresSupValides."Tarif unitaire" := HeuresSup."Tarif unitaire";
                HeuresSupValides."Montant Ligne" := HeuresSup."Montant Ligne";
                HeuresSupValides.Insert;

                HeuresSup.Delete;

                actions := recValid;
            end;

            Fenetre.Update(4, actions);


        until HeuresSup.Next = 0;
        Fenetre.Close;
    end;


    procedure Validerjourtravail("N°Transaction": Integer; LigneHeureSup: Record "Heures occasionnelles")
    var
        "Salarié": Record Employee;
        HeuresSupEnreg: Record "Heures occa. enreg. m";
        NewLigneHeureSup: Record Language;
        LigneHeureSupSlr: Record "Heures sup. m";
        Total: Decimal;
        "RégimeTravail": record "Regimes of work";
        errorSlrNotFound: label 'Erreur :\Salarié introuvable. Vérifier le N° salarié saisi.';
        errorRegTravailSlr: label 'Erreur :\La mention du Régime de travail auquel appartient le salarié est un paramètre indispensable\à la poursuite du calacul.\Veuillez vérifier ce paramètre sur la fiche salarié.\N° salarié  : ##########1\Nom salarié : ##########2';
        Contrat: Record "Employment Contract";
        NbrHeures: Decimal;
        DSemaine: Date;
        FSemaine: Date;
        Std: Decimal;
        TarifHorraire: Decimal;
        IndSlr: Record "Default Indemnities";
        CodeInd: record Indemnity;
        TotalInd: Decimal;
        ParamRessHum: Record "Human Resources Setup";
        ErrorContrat: label 'Erreur :\Heures du travail pour les occasionnels inexistant ...';
        LigHeuresSuptmp: Record "Heures sup. m";
        HeuresSupEnregtmp: Record "Heures occa. enreg. m";
        HeuresSupEnregtmptr: Record "Heures sup. eregistrées m";
        trns: Integer;
        LigHeuresSuptmp1: Record "Heures sup. m";
        heureT: Decimal;
        LigHeuresSuptmp2: Record "Heures sup. m";
        i: Integer;
        LigneRegim: record "Bon Reglement";
        Heb: Time;
        Hfin: Time;
        HeureN: Decimal;
        DateJ: Date;
        CalendarMgmt: Codeunit "Calendar Management";
        Nonworking: Boolean;
        JF: Boolean;
        Nbrejouv: Decimal;
        x: Integer;
        Dim: Boolean;
    begin
        /*IF NOT Salarié.GET (LigneHeureSup."N° Salarié") THEN
          ERROR (errorSlrNotFound);
        //Salarié.CALCFIELDS("Heures sup. validées");
        RégimeTravail.RESET;
        FSemaine      := CALCDATE ('<CW>',LigneHeureSup.Date);
        DSemaine      := FSemaine - 6;
         CLEAR(Contrat);
         Contrat.RESET;
         Contrat.GET(Salarié."Emplymt. Contract Code");
         IF NOT (Contrat."Employee's type"=0) THEN
            ERROR(STRSUBSTNO('Le Salarié %1 %2 n''est pas un Occasionnel ',Salarié."No.",Salarié."Last Name"+' '+Salarié."First Name"));*/
        IF HeuresSupEnregtmp.FIND('+') THEN;
        /* IF NOT Contrat.GET(Salarié."Emplymt. Contract Code") THEN
          ERROR(ErrorContrat);
         ParamRessHum.GET;
         LigneHeureSup.SETFILTER("Filtre date",'%1..%2',DSemaine,FSemaine);

         LigneHeureSup.CALCFIELDS("Heures Enregistrées","Heures Sup Enregistrées");
         RégimeTravail.GET(Contrat."Regimes of work");
           DateJ:=DMY2DATE(1,LigneHeureSup."Mois de paiement"+1,LigneHeureSup."Année de paiement");
           x:=-1;
           Nbrejouv:=0;
           REPEAT
             x:=x+1;
             Nonworking := CalendarMgmt.CheckDateStatusJF(Contrat."Code Calendar",CALCDATE(STRSUBSTNO('+%1J',x),DateJ),JF);
             IF NOT Nonworking THEN
                Nbrejouv:=Nbrejouv+1;
                UNTIL   CALCDATE(STRSUBSTNO('+%1J',x),DateJ)> CALCDATE('+FM',DateJ);
         IF LigneHeureSup."Type Jours"=1 THEN
            LigneHeureSup."Type Jours":=0;
         LigneRegim.RESET;
         LigneRegim.SETFILTER("Regime of work",RégimeTravail.Code);
         IF Contrat."Appliquer Heure Supp" THEN BEGIN
           HeureN:=0;
           IF (LigneHeureSup."Heure debut"<>0T) AND (LigneHeureSup."Heure Fin"<>0T) THEN
           IF (CalcHnuit(LigneHeureSup)<>0 ) THEN
              HeureN:=ROUND(CalcHnuit(LigneHeureSup),0.01,'>');;
           JF:=FALSE;
           Dim:=FALSE;
           Nonworking := CalendarMgmt.CheckDateStatusJF(Contrat."Code Calendar",LigneHeureSup.Date,JF);
           Dim:=CalendarMgmt.CheckDateStatusNW(Contrat."Code Calendar",LigneHeureSup.Date);
           // IF  Nonworking THEN
           //     HeureN:=0;
            //LigneHeureSup."Nombre d'heures":=LigneHeureSup."Nombre d'heures"-HeureN;
         IF NOT LigneRegim.FIND('-') THEN
            ERROR('Regime de Travail Incomplete   !!!');

          // heures supp
            RégimeTravail.TESTFIELD("Work Hours per week");
            CASE RégimeTravail."Type Calcul H. Supp." OF
            0 :
            heureT:=(LigneHeureSup."Heures Enregistrées"+LigneHeureSup."Nombre d'heures"+LigneHeureSup."Heures Sup Enregistrées")-
                    RégimeTravail."Work Hours per week";
            1 :
            heureT:=ROUND((LigneHeureSup."Heures Enregistrées"+LigneHeureSup."Nombre d'heures"+LigneHeureSup."Heures Sup Enregistrées")-
                    ((RégimeTravail."Work Hours per month"/RégimeTravail."Worked Day Per Month")*Nbrejouv)-
                    (LigneHeureSup."Heures Sup Enregistrées"),0.01,'>');
            ELSE
            heureT:=0;
            END;
            IF JF AND (NOT Dim) THEN
               LigneHeureSup."Type Jours":=1;

            IF LigneHeureSup."Type Jours"=1 THEN
               heureT:= LigneHeureSup."Nombre d'heures";

            IF heureT>LigneHeureSup."Nombre d'heures" THEN
               heureT:=LigneHeureSup."Nombre d'heures";
           IF heureT<0 THEN
              heureT:=0;


          IF Dim  AND (RégimeTravail."Activer Jour Repos") THEN BEGIN
              heureT:=LigneHeureSup."Nombre d'heures";
             HeureN:=0;
              END;
          IF RégimeTravail."Type Calcul H Nuit"=0 THEN
          LigneHeureSup."Nombre d'heures":=LigneHeureSup."Nombre d'heures"- heureT-HeureN
          ELSE
          LigneHeureSup."Nombre d'heures":=LigneHeureSup."Nombre d'heures"- heureT;

         //MBY 05/01/2012
         Dectarif:=0;
         RecIndemnity.reset;
         RecIndemnity.setrange("Employment Contract Code","N° Salarié");
         RecIndemnity.("Inclus dans heures supp",true);
         if RecIndemnity.find('-') then
           repeat
             Dectarif := Dectarif + RecIndemnity."Default amount";
           until RecIndemnity.next=0;
         //MBY 05/01/2012

          LigneHeureSup."Tarif unitaire":=ROUND((Salarié."Basis salary"+Dectarif)/RégimeTravail."Work Hours per month",0.00001);
          LigneHeureSup."Taux de majoration":=0;
          LigneHeureSup."Montant ligne":=ROUND((Salarié."Basis salary"+Dectarif)/RégimeTravail."Work Hours per month")
          *LigneHeureSup."Nombre d'heures",0.001);
         IF (heureT>0) THEN BEGIN*/
        IF HeuresSupEnregtmptr.FIND('+') THEN
            trns := HeuresSupEnregtmptr."N° transaction" + 1
        ELSE
            trns := 1;
        /*  CLEAR(LigHeuresSuptmp);

          LigHeuresSuptmp."N° Salarié":=LigneHeureSup."N° Salarié";
          LigHeuresSuptmp.SETCURRENTKEY("N° Ligne");
          IF  LigHeuresSuptmp1.FIND('+') THEN
          LigHeuresSuptmp."N° Ligne":=LigHeuresSuptmp1."N° Ligne"+1
          ELSE
          LigHeuresSuptmp."N° Ligne":=1;

          LigHeuresSuptmp."Code departement":=LigneHeureSup."Code departement";
          LigHeuresSuptmp."Code dossier":=LigneHeureSup."Code dossier";
          LigHeuresSuptmp."Nom usuel":=LigneHeureSup."Nom usuel";
          LigHeuresSuptmp.Prénom:=LigneHeureSup.Prénom;
          LigHeuresSuptmp.Date:=LigneHeureSup.Date;
          LigHeuresSuptmp.VALIDATE("Nombre d'heures",heureT);
           IF Nonworking THEN BEGIN
            IF JF AND (NOT Dim) THEN
              LigHeuresSuptmp."Type Jours":=1
              ELSE
             LigHeuresSuptmp."Type Jours":=4;
             END;

          LigHeuresSuptmp."Mois de paiement":=LigneHeureSup."Mois de paiement";
          LigHeuresSuptmp."Année de paiement":=LigneHeureSup."Année de paiement";
          LigHeuresSuptmp.Système:=TRUE;
          LigHeuresSuptmp."Heure debut" := LigneHeureSup."Heure debut";
          LigHeuresSuptmp."Heure Fin"   := LigneHeureSup."Heure Fin";
          LigHeuresSuptmp.INSERT;
          LigHeuresSuptmp2.RESET;
          LigHeuresSuptmp2.SETRANGE(Système,TRUE);
          i:=0;
          IF LigHeuresSuptmp2.FIND('-') THEN REPEAT
          i:=i+1;
          CalculerRémunérationHeuresSup(trns-1+i,LigHeuresSuptmp2);
          UNTIL  LigHeuresSuptmp2.NEXT=0;
          END;
       IF (HeureN>0) THEN BEGIN
        IF heureT>0 THEN
            trns:=trns+1
            ELSE BEGIN
         IF  HeuresSupEnregtmptr.FIND('+') THEN
            trns:=HeuresSupEnregtmptr."N° transaction"+1
            ELSE
            trns:=1;
            END;
          LigHeuresSuptmp.INIT;

          LigHeuresSuptmp."N° Salarié":=LigneHeureSup."N° Salarié";
          IF  LigHeuresSuptmp1.FIND('+') THEN
          LigHeuresSuptmp."N° Ligne":=LigHeuresSuptmp1."N° Ligne"+30000
          ELSE
          LigHeuresSuptmp."N° Ligne":=30000;

          LigHeuresSuptmp."Code departement":=LigneHeureSup."Code departement";
          LigHeuresSuptmp."Code dossier":=LigneHeureSup."Code dossier";
          LigHeuresSuptmp."Nom usuel":=LigneHeureSup."Nom usuel";
          LigHeuresSuptmp.Prénom:=LigneHeureSup.Prénom;
          LigHeuresSuptmp.Date:=LigneHeureSup.Date;
          LigHeuresSuptmp.VALIDATE("Nombre d'heures",HeureN);
          LigHeuresSuptmp."Type Jours":=3;
          LigHeuresSuptmp."Mois de paiement":=LigneHeureSup."Mois de paiement";
          LigHeuresSuptmp."Année de paiement":=LigneHeureSup."Année de paiement";
          LigHeuresSuptmp.Système:=TRUE;
          LigHeuresSuptmp."Heure debut" := LigneHeureSup."Heure debut";
          LigHeuresSuptmp."Heure Fin"   := LigneHeureSup."Heure Fin";

          LigHeuresSuptmp.INSERT;
          LigHeuresSuptmp2.RESET;
          LigHeuresSuptmp2.SETRANGE(Système,TRUE);
          i:=0;
          IF LigHeuresSuptmp2.FIND('-') THEN REPEAT
          i:=i+1;
          CalculerRémunérationHeuresSup(trns-1+i,LigHeuresSuptmp2);
          UNTIL  LigHeuresSuptmp2.NEXT=0;
          END;
         END;

         IF ROUND(LigneHeureSup."Nombre d'heures",0.001)<>0 THEN BEGIN
        LigneHeureSup."Tarif unitaire":=ROUND((Salarié."Basis salary"+Dectarif)/RégimeTravail."Work Hours per month",0.00001);
        LigneHeureSup."Taux de majoration":=0;
        LigneHeureSup."Montant ligne":=ROUND(((Salarié."Basis salary"+Dectarif)/RégimeTravail."Work Hours per month")
        *LigneHeureSup."Nombre d'heures",0.001);

        HeuresSupEnreg.TRANSFERFIELDS(LigneHeureSup);*/
        /*  HeuresSupEnreg."Date comptabilisation" := LigneHeureSup.Date;
          HeuresSupEnreg."Année de paiement" := LigneHeureSup."Année de paiement";
          HeuresSupEnreg."Mois de paiement" := LigneHeureSup."Mois de paiement";
          HeuresSupEnreg."N° transaction" := HeuresSupEnregtmp."N° transaction" + 1;*/
        //HeuresSupEnreg."Nbre Jour":=1;
        /*    IF LigneHeureSup."Montant ligne" = 0 THEN
                ERROR(' Vous devez verifier Salaire !!!');*/
        //  HeuresSupEnreg."Heure debut" := LigneHeureSup."Heure debut";
        //  HeuresSupEnreg."Heure Fin" := LigneHeureSup."Heure Fin";
        /*  HeuresSupEnreg.INSERT;
          //END;
          LigneHeureSup.DELETE;

          if HeuresSupEnregtmp.Find('+') then;

          if HeuresSupEnregtmptr.Find('+') then
              trns := HeuresSupEnregtmptr."N° transaction" + 1
          else
              trns := 1;
          if Employee.Get(LigneHeureSup."N° Salarié") then;*/
        HeuresSupEnreg.TransferFields(LigneHeureSup);
        HeuresSupEnreg."Date comptabilisation" := LigneHeureSup.Date;
        HeuresSupEnreg."Année de paiement" := LigneHeureSup."Année de paiement";
        HeuresSupEnreg."Mois de paiement" := LigneHeureSup."Mois de paiement";
        HeuresSupEnreg."N° transaction" := HeuresSupEnregtmp."N° transaction" + 1;
        HeuresSupEnreg."Heure debut" := LigneHeureSup."Heure debut";
        HeuresSupEnreg."Heure Fin" := LigneHeureSup."Heure Fin";
        HeuresSupEnreg.Quinzaine := LigneHeureSup.Quinzaine;
        HeuresSupEnreg.Productivité := LigneHeureSup.Productivité;
        HeuresSupEnreg."Jour indemnité" := LigneHeureSup."Jour indemnité";
        /*  HeuresSupEnreg.Affectation := Employee.Affectation;
          HeuresSupEnreg.Qualification := Employee.Qualification;
          HeuresSupEnreg."Jours Deplacement" := LigneHeureSup."Jours Deplacement";
          HeuresSupEnreg.Retenu := LigneHeureSup.Retenu;
          HeuresSupEnreg.Rappel := LigneHeureSup.Rappel;
          HeuresSupEnreg.Cession := LigneHeureSup.Cession;
          HeuresSupEnreg."Nombre d'heures" := LigneHeureSup."Heure Travaillé";*/
        HeuresSupEnreg.Insert;

        LigneHeureSup.Delete;

    end;


    procedure DevaliderHeuresTravail(HeuresSupEreg: Record "Heures occa. enreg. m"; Nligne: Integer)
    var
        HeuresSup: Record "Heures occasionnelles";
        NTransaction: Integer;
        Sal: Record Employee;
    // Complement: Record Complement;
    //  DetailComplement: Record "Detail Complement";
    begin
        IF (HeuresSupEreg."N° Salarié" <> '') AND (HeuresSupEreg.Date <> 0D) THEN begin
            Clear(Sal);
            Sal.Get(HeuresSupEreg."N° Salarié");
            /* if Complement.Get(HeuresSupEreg."N° Salarié") then
                 if Complement.Actif then begin
                     DetailComplement.SetRange(Matricule, HeuresSupEreg."N° Salarié");
                     DetailComplement.SetRange(Annee, HeuresSupEreg."Année de paiement");
                     DetailComplement.SetRange(Mois, HeuresSupEreg."Mois de paiement");
                     if DetailComplement.FindFirst then DetailComplement.Delete;
                 end;*/

            HeuresSup.Reset;
            HeuresSup.Init;
            HeuresSup."N° Ligne" := Nligne;
            HeuresSup."N° Salarié" := HeuresSupEreg."N° Salarié";
            HeuresSup."Nom usuel" := HeuresSupEreg."Nom usuel";
            HeuresSup.Prénom := HeuresSupEreg.Prénom;
            HeuresSup.Date := HeuresSupEreg.Date;
            HeuresSup."Code departement" := HeuresSupEreg."Code departement";
            HeuresSup."Code dossier" := HeuresSupEreg."Code dossier";
            HeuresSup."Montant ligne" := HeuresSupEreg."Montant ligne";
            HeuresSup.Validate("Type Jours", HeuresSupEreg."Type Jours");
            HeuresSup."Taux de majoration" := HeuresSupEreg."Taux de majoration";
            HeuresSup.Validate("Nombre d'heures", HeuresSupEreg."Nombre d'heures");
            HeuresSup.Validate("Nbre Jour", HeuresSupEreg."Nbre Jour");
            HeuresSup.Validate("Tarif unitaire", HeuresSupEreg."Tarif unitaire");
            HeuresSup."Mois de paiement" := HeuresSupEreg."Mois de paiement";
            HeuresSup."Année de paiement" := HeuresSupEreg."Année de paiement";
            HeuresSup.Quinzaine := HeuresSupEreg.Quinzaine;
            HeuresSup.Productivité := HeuresSupEreg.Productivité;
            HeuresSup."Jour indemnité" := HeuresSupEreg."Jour indemnité";
            //HeuresSup."Taux de majoration"    := HeuresSupEreg."Taux de majoration";
            HeuresSup.Insert;
            HeuresSupEreg.Delete;

        end;
    end;


    procedure DevaliderHeuresSup(HeuresSupEreg: Record "Heures sup. eregistrées m"; Nligne: Integer)
    var
        HeuresSup: Record "Heures sup. m";
        NTransaction: Integer;
        Sal: Record Employee;
    begin
        if ((HeuresSupEreg."N° Salarié" <> '')
            and
            (HeuresSupEreg.Date <> 0D)
            and
            (HeuresSupEreg."Nombre d'heures" <> 0)
            and
            (HeuresSupEreg."Paiement No." = '')
           ) then begin
            Clear(Sal);
            Sal.Get(HeuresSupEreg."N° Salarié");
            HeuresSup.Reset;
            HeuresSup.Init;
            HeuresSup."N° Ligne" := Nligne;
            HeuresSup."N° Salarié" := HeuresSupEreg."N° Salarié";
            HeuresSup."Nom usuel" := HeuresSupEreg."Nom usuel";
            HeuresSup.Prénom := HeuresSupEreg.Prénom;
            HeuresSup.Date := HeuresSupEreg.Date;
            HeuresSup."Code departement" := HeuresSupEreg."Code departement";
            HeuresSup."Code dossier" := HeuresSupEreg."Code dossier";
            HeuresSup."Montant Ligne" := HeuresSupEreg."Montant Ligne";
            HeuresSup.Validate("Type Jours", HeuresSupEreg."Type Jours");
            HeuresSup."Taux de majoration" := HeuresSupEreg."Taux de majoration";
            HeuresSup.Validate("Nombre d'heures", HeuresSupEreg."Nombre d'heures");
            HeuresSup.Validate("Tarif unitaire", HeuresSupEreg."Tarif unitaire");
            HeuresSup."Mois de paiement" := HeuresSupEreg."Mois de paiement";
            HeuresSup."Année de paiement" := HeuresSupEreg."Année de paiement";
            HeuresSup."Taux de majoration" := HeuresSupEreg."Taux de majoration";
            HeuresSup."Type heure" := HeuresSupEreg."Type heure";
            HeuresSup.Système := HeuresSupEreg.Système;
            //>> DSFT AGA 120410
            HeuresSup.Quinzaine := HeuresSupEreg.Quinzaine;
            //>> DSFT AGA 120410
            HeuresSup.Insert;
            HeuresSupEreg.Delete;
        end;
    end;


    procedure CalcHnuit(LigneHeureSup: Record "Heures occasionnelles") Nbre: Decimal
    var
        Hdeb: Time;
        Hfin: Time;
        ParamRessHum: Record "Human Resources Setup";
    begin
        ParamRessHum.Get;
        Nbre := 0;
        Hdeb := 000000T;
        Hfin := 000000T;

        if (LigneHeureSup."Heure Fin" <= 235959T) and (LigneHeureSup."Heure Fin" > ParamRessHum."Heure Début Nuit") then begin
            Hfin := LigneHeureSup."Heure Fin";
            if LigneHeureSup."Heure debut" > ParamRessHum."Heure Début Nuit" then
                Hdeb := LigneHeureSup."Heure debut"
            else
                Hdeb := ParamRessHum."Heure Début Nuit";
        end
        else
            if (LigneHeureSup."Heure Fin" <= ParamRessHum."Heure Fin Nuit") then begin
                if LigneHeureSup."Heure debut" < LigneHeureSup."Heure Fin" then begin
                    Hdeb := LigneHeureSup."Heure debut";
                    Hfin := LigneHeureSup."Heure Fin";
                end else
                    if LigneHeureSup."Heure debut" > ParamRessHum."Heure Début Nuit" then
                        Hdeb := LigneHeureSup."Heure debut"
                    else
                        Hdeb := ParamRessHum."Heure Début Nuit";
            end
            else
                if LigneHeureSup."Heure Fin" > ParamRessHum."Heure Fin Nuit" then begin
                    if LigneHeureSup."Heure debut" < ParamRessHum."Heure Fin Nuit" then begin
                        Hfin := ParamRessHum."Heure Fin Nuit";
                        Hdeb := LigneHeureSup."Heure debut";
                    end
                    else
                        if LigneHeureSup."Heure debut" > ParamRessHum."Heure Début Nuit" then begin
                            Hdeb := LigneHeureSup."Heure debut";
                            Hfin := ParamRessHum."Heure Fin Nuit";
                        end else
                            if LigneHeureSup."Heure debut" > LigneHeureSup."Heure Fin" then begin
                                Hfin := ParamRessHum."Heure Fin Nuit";
                                Hdeb := ParamRessHum."Heure Début Nuit";
                            end;
                end;
        if Hdeb > Hfin then
            Nbre := ((235959T - Hdeb) + (Hfin - 000000T) + 1)
        else
            Nbre := (Hfin - Hdeb);
        Nbre := Nbre / 3600000;
    end;


    procedure Validersup("N°Transaction": Integer; LigneHeureSup: Record "Heures sup. m")
    var
        "Salarié": Record Employee;
        HeuresSupEnreg: Record "Heures occa. enreg. m";
        NewLigneHeureSup: Record Language;
        LigneHeureSupSlr: Record "Heures sup. m";
        Total: Decimal;
        "RégimeTravail": record "Regimes of work";
        errorSlrNotFound: label 'Erreur :\Salarié introuvable. Vérifier le N° salarié saisi.';
        errorRegTravailSlr: label 'Erreur :\La mention du Régime de travail auquel appartient le salarié est un paramètre indispensable\à la poursuite du calacul.\Veuillez vérifier ce paramètre sur la fiche salarié.\N° salarié  : ##########1\Nom salarié : ##########2';
        Contrat: Record "Employment Contract";
        NbrHeures: Decimal;
        DSemaine: Date;
        FSemaine: Date;
        Std: Decimal;
        TarifHorraire: Decimal;
        IndSlr: Record "Default Indemnities";
        CodeInd: record Indemnity;
        TotalInd: Decimal;
        ParamRessHum: Record "Human Resources Setup";
        ErrorContrat: label 'Erreur :\Heures du travail pour les occasionnels inexistant ...';
        LigHeuresSuptmp: Record "Heures sup. m";
        HeuresSupEnregtmp: Record "Heures occa. enreg. m";
        HeuresSupEnregtmptr: Record "Heures sup. eregistrées m";
        trns: Integer;
        LigHeuresSuptmp1: Record "Heures sup. m";
        heureT: Decimal;
        LigHeuresSuptmp2: Record "Heures sup. m";
        i: Integer;
        LigneRegim: record "Bon Reglement";
        Heb: Time;
        Hfin: Time;
        HeureN: Decimal;
        DateJ: Date;
        CalendarMgmt: Codeunit "Calendar Management";
        Nonworking: Boolean;
        JF: Boolean;
        Nbrejouv: Decimal;
        x: Integer;
        Dim: Boolean;
    begin
        // if not Salarié.Get(LigneHeureSup."N° Salarié") then
        //     Error(errorSlrNotFound);
        // //Salarié.CALCFIELDS("Heures sup. validées");
        // RégimeTravail.Reset;
        // FSemaine := CalcDate('+FM', LigneHeureSup.Date);
        // DSemaine := CalcDate('-1M+FM+1J', FSemaine);
        // Clear(Contrat);
        // Contrat.Reset;
        // Contrat.Get(Salarié."Emplymt. Contract Code");
        // if not (Contrat."Employee's type" = 1) then
        //     Error(StrSubstNo('Le Salarié %1 %2 n''est pas un Mensuel ', Salarié."No.", Salarié."Last Name" + ' ' +
        //     Salarié."First Name"));

        // if HeuresSupEnregtmp.Find('+') then;
        // if not Contrat.Get(Salarié."Emplymt. Contract Code") then
        //     Error(ErrorContrat);
        // ParamRessHum.Get;
        // LigneHeureSup.SetFilter("Filtre date", '%1..%2', DSemaine, FSemaine);
        // LigneHeureSup.CalcFields("Heures sup. enreg.");
        // RégimeTravail.Get(Contrat."Regimes of work");
        // DateJ := Dmy2date(1, LigneHeureSup."Mois de paiement" + 1, LigneHeureSup."Année de paiement");
        // x := -1;
        // Nbrejouv := 0;
        // repeat
        //     x := x + 1;
        //     //Nonworking := CalendarMgmt.CheckDateStatusJF(Contrat."Code Calendar",CALCDATE(STRSUBSTNO('+%1J',x),DateJ),JF);
        //     if not Nonworking then
        //         Nbrejouv := Nbrejouv + 1;
        // until CalcDate(StrSubstNo('+%1J', x), DateJ) > CalcDate('+FM', DateJ);

        // if LigneHeureSup."Type Jours" = 1 then
        //     LigneHeureSup."Type Jours" := 0;
        // LigneRegim.Reset;
        // LigneRegim.SetFilter("N° Bon", RégimeTravail.Code);
        // if Contrat."Appliquer Heure Supp" then begin
        //     HeureN := 0;
        //     if CalcHnuitsup(LigneHeureSup) <> 0 then
        //         HeureN := ROUND(CalcHnuitsup(LigneHeureSup), 0.01, '>');
        //     JF := false;
        //     Dim := false;
        //     //Nonworking := CalendarMgmt.CheckDateStatusJF(Contrat."Code Calendar",LigneHeureSup.Date,JF);
        //     // Dim:=CalendarMgmt.CheckDateStatusNW(Contrat."Code Calendar",LigneHeureSup.Date);
        //     // IF  Nonworking THEN
        //     //     HeureN:=0;
        //     //LigneHeureSup."Nombre d'heures":=LigneHeureSup."Nombre d'heures"-HeureN;
        //     if not LigneRegim.Find('-') then
        //         Error('Regime de Travail Incomplete   !!!');
        //     // heures supp
        //     RégimeTravail.TestField("Work Hours per week");
        //     case RégimeTravail."Type Calcul H. Supp." of
        //         0:
        //             heureT := (LigneHeureSup."Nombre Heure Supp" + LigneHeureSup."Heures sup. enreg.") - LigneHeureSup."Heures sup. enreg.";
        //         1:
        //             heureT := ROUND((LigneHeureSup."Nombre Heure Supp" + LigneHeureSup."Heures sup. enreg.") -
        //                     //((RégimeTravail."Work Hours per month"/RégimeTravail."Worked Day Per Month")*Nbrejouv)-
        //                     (LigneHeureSup."Heures sup. enreg."), 0.01, '>');
        //         else
        //             heureT := 0;
        //     end;
        //     if heureT < 0 then
        //         heureT := 0;


        //     if Dim then begin
        //         heureT := LigneHeureSup."Nombre Heure Supp";
        //         HeureN := 0;
        //     end;

        //     /*IF (heureT>0)  THEN BEGIN
        //       IF  HeuresSupEnregtmptr.FIND('+') THEN
        //          trns:=HeuresSupEnregtmptr."N° transaction"+1
        //          ELSE
        //          trns:=1;
        //        CLEAR(LigHeuresSuptmp);

        //        LigHeuresSuptmp."N° Salarié":=LigneHeureSup."N° Salarié";
        //        LigHeuresSuptmp.SETCURRENTKEY("N° Ligne");
        //        IF  LigHeuresSuptmp1.FIND('+') THEN
        //        LigHeuresSuptmp."N° Ligne":=LigHeuresSuptmp1."N° Ligne"+1
        //        ELSE
        //        LigHeuresSuptmp."N° Ligne":=1;

        //        LigHeuresSuptmp."Code departement":=LigneHeureSup."Code departement";
        //        LigHeuresSuptmp."Code dossier":=LigneHeureSup."Code dossier";
        //        LigHeuresSuptmp."Nom usuel":=LigneHeureSup."Nom usuel";
        //        LigHeuresSuptmp.Prénom:=LigneHeureSup.Prénom;
        //        LigHeuresSuptmp.Date:=LigneHeureSup.Date;
        //        LigHeuresSuptmp.VALIDATE("Nombre d'heures",heureT);
        //         IF Nonworking THEN BEGIN
        //          IF JF AND (NOT Dim) THEN
        //            LigHeuresSuptmp."Type Jours":=1
        //            ELSE
        //           LigHeuresSuptmp."Type Jours":=4;
        //           END;
        //        LigHeuresSuptmp."Mois de paiement":=LigneHeureSup."Mois de paiement";
        //        LigHeuresSuptmp."Année de paiement":=LigneHeureSup."Année de paiement";
        //        LigHeuresSuptmp."Heure debut":=  LigneHeureSup."Heure debut";
        //        LigHeuresSuptmp."Heure Fin"  :=  LigneHeureSup."Heure Fin" ;

        //        LigHeuresSuptmp.Système:=TRUE;
        //        LigHeuresSuptmp.INSERT;
        //        LigHeuresSuptmp2.RESET;
        //        LigHeuresSuptmp2.SETRANGE(Système,TRUE);
        //        i:=0;
        //        IF LigHeuresSuptmp2.FIND('-') THEN REPEAT
        //        i:=i+1;
        //        IF HeureN<>0 THEN
        //        CalculerRémunérationHeuresSup(trns-1+i,LigHeuresSuptmp2);
        //        UNTIL  LigHeuresSuptmp2.NEXT=0;
        //        END; */
        //     if (HeureN > 0) then begin
        //         if heureT > 0 then
        //             trns := trns + 1
        //         else begin
        //             if HeuresSupEnregtmptr.Find('+') then
        //                 trns := HeuresSupEnregtmptr."N° transaction" + 1
        //             else
        //                 trns := 1;
        //         end;
        //         LigHeuresSuptmp.Init;

        //         LigHeuresSuptmp."N° Salarié" := LigneHeureSup."N° Salarié";
        //         // IF  LigHeuresSuptmp1.FIND('+') THEN
        //         // LigHeuresSuptmp."N° Ligne":=LigHeuresSup."N° Ligne"+5000
        //         // ELSE
        //         LigHeuresSuptmp."N° Ligne" := LigneHeureSup."N° Ligne" + 5000;

        //         LigHeuresSuptmp."Code departement" := LigneHeureSup."Code departement";
        //         LigHeuresSuptmp."Code dossier" := LigneHeureSup."Code dossier";
        //         LigHeuresSuptmp."Nom usuel" := LigneHeureSup."Nom usuel";
        //         LigHeuresSuptmp.Prénom := LigneHeureSup.Prénom;
        //         LigHeuresSuptmp.Date := LigneHeureSup.Date;
        //         LigHeuresSuptmp.Validate("Nombre Heure Supp", HeureN);
        //         LigHeuresSuptmp."Type Jours" := 3;
        //         LigHeuresSuptmp."Mois de paiement" := LigneHeureSup."Mois de paiement";
        //         LigHeuresSuptmp."Année de paiement" := LigneHeureSup."Année de paiement";
        //         LigHeuresSuptmp."Heure debut" := LigneHeureSup."Heure debut";
        //         LigHeuresSuptmp."Heure Fin" := LigneHeureSup."Heure Fin";
        //         LigHeuresSuptmp.Système := true;
        //         LigHeuresSuptmp.Insert;
        //         LigHeuresSuptmp2.Reset;
        //         LigHeuresSuptmp2.SetRange(Système, true);
        //         i := 0;
        //         if LigHeuresSuptmp2.Find('-') then
        //             repeat
        //                 i := i + 1;
        //                 CalculerRémunérationHeuresSup(trns - 1 + i, LigHeuresSuptmp2);
        //             until LigHeuresSuptmp2.Next = 0;
        //     end;
        //     if (heureT <> 0) then
        //         CalculerRémunérationHeuresSup("N°Transaction", LigneHeureSup);
        // end;

    end;


    procedure CalcHnuitsup(LigneHeureSup: Record "Heures sup. m") Nbre: Decimal
    var
        Hdeb: Time;
        Hfin: Time;
        ParamRessHum: Record "Human Resources Setup";
    begin
        ParamRessHum.Get;
        Nbre := 0;
        Hdeb := 000000T;
        Hfin := 000000T;

        if (LigneHeureSup."Heure Fin" <= 235959T) and (LigneHeureSup."Heure Fin" > ParamRessHum."Heure Début Nuit") then begin
            Hfin := LigneHeureSup."Heure Fin";
            if LigneHeureSup."Heure debut" > ParamRessHum."Heure Début Nuit" then
                Hdeb := LigneHeureSup."Heure debut"
            else
                Hdeb := ParamRessHum."Heure Début Nuit";
        end
        else
            if (LigneHeureSup."Heure Fin" <= ParamRessHum."Heure Fin Nuit") then begin
                if LigneHeureSup."Heure debut" < LigneHeureSup."Heure Fin" then begin
                    Hdeb := LigneHeureSup."Heure debut";
                    Hfin := LigneHeureSup."Heure Fin";
                end else
                    if LigneHeureSup."Heure debut" > ParamRessHum."Heure Début Nuit" then
                        Hdeb := LigneHeureSup."Heure debut"
                    else
                        Hdeb := ParamRessHum."Heure Début Nuit";
            end
            else
                if LigneHeureSup."Heure Fin" > ParamRessHum."Heure Fin Nuit" then begin
                    if LigneHeureSup."Heure debut" < ParamRessHum."Heure Fin Nuit" then begin
                        Hfin := ParamRessHum."Heure Fin Nuit";
                        Hdeb := LigneHeureSup."Heure debut";
                    end
                    else
                        if LigneHeureSup."Heure debut" > ParamRessHum."Heure Début Nuit" then begin
                            Hdeb := LigneHeureSup."Heure debut";
                            Hfin := ParamRessHum."Heure Fin Nuit";
                        end else
                            if LigneHeureSup."Heure debut" > LigneHeureSup."Heure Fin" then begin
                                Hfin := ParamRessHum."Heure Fin Nuit";
                                Hdeb := ParamRessHum."Heure Début Nuit";
                            end;
                end;
        if Hdeb > Hfin then
            Nbre := ((235959T - Hdeb) + (Hfin - 000000T) + 1)
        else
            Nbre := (Hfin - Hdeb);
        Nbre := Nbre / 3600000;
    end;


    procedure H1(SuppHour: Record "Heures occasionnelles"; Tran: Integer)
    var
        Employee: Record Employee;
        RegimeWork: record "Regimes of work";
        EmploymentContract: Record "Employment Contract";
        OverchargeHourCost: record "Bon Reglement";
        RecordedSuppHours: Record "Heures occa. enreg. m";
        diff: Decimal;
        temp: Decimal;
        comp: Decimal;
        NewSuppHour: Record "Heures occasionnelles";
        XOverchargeHourCost: record "Bon Reglement";
        NewLine: Boolean;
        Restant: Decimal;
        Found: Boolean;
        N: Integer;
        L: Integer;
        WorkHour: Record "Heures occasionnelles";
        Id: Integer;
        EclaterLigne: Boolean;
        "type ligne": Option "Heure normal","Heures suppl.";
    begin
        /*L2024 SuppHour.CALCFIELDS("Same week worked hour");
         Found := FALSE;

         OverchargeHourCost.RESET;
         OverchargeHourCost.SETRANGE("N° Bon", SuppHour."Regime of work");
         IF OverchargeHourCost.FIND('-') THEN
             REPEAT
                 IF ((OverchargeHourCost.Mois <= SuppHour."Same week worked hour")
                     AND
                     (SuppHour."Same week worked hour" < OverchargeHourCost.Matricule))
                   THEN BEGIN
                     XOverchargeHourCost.COPY(OverchargeHourCost);
                     Found := TRUE;
                 END;
             UNTIL OverchargeHourCost.NEXT = 0;
         IF NOT Found THEN
             XOverchargeHourCost.COPY(OverchargeHourCost);

         SuppHour."Overcharge line" := XOverchargeHourCost.Annee;
         SuppHour.MODIFY;
         IF (XOverchargeHourCost.Mois <= (SuppHour."Same week worked hour" + SuppHour."Nombre d'heures"))
             AND
             ((SuppHour."Nombre d'heures" + SuppHour."Same week worked hour") <= XOverchargeHourCost.Matricule)
             THEN
             EclaterLigne := FALSE
         ELSE
             EclaterLigne := TRUE;

         Found := FALSE;
         OverchargeHourCost.RESET;
         OverchargeHourCost.SETRANGE("N° Bon", SuppHour."Regime of work");
         IF OverchargeHourCost.FIND('-') THEN
             REPEAT
                 IF ((OverchargeHourCost.Mois <= (SuppHour."Nombre d'heures" + SuppHour."Same week worked hour"))
                     AND
                     ((SuppHour."Nombre d'heures" + SuppHour."Same week worked hour") <= OverchargeHourCost.Matricule))
                   THEN BEGIN
                     XOverchargeHourCost.COPY(OverchargeHourCost);
                     Found := TRUE;
                 END;
             UNTIL OverchargeHourCost.NEXT = 0;
         IF NOT Found THEN
             XOverchargeHourCost.COPY(OverchargeHourCost);*/


        SuppHour."Overcharge target line" := XOverchargeHourCost.Annee;
        SuppHour.Modify;
        WorkHour.SetRange("N° Salarié", SuppHour."N° Salarié");
        if WorkHour.Find('+') then
            N := WorkHour."N° Ligne" + 10000
        else
            N := 10000;
        OverchargeHourCost.Find('+');
        /*
        IF (EclaterLigne AND  (SuppHour."Overcharge line" <> OverchargeHourCost.Identifier))THEN
          BEGIN
          //Créer la 1ere ligne--------------------------------------------------------------------------------------------------------

            NewSuppHour.RESET;
            NewSuppHour."N° Salarié"           := SuppHour."N° Salarié";
            NewSuppHour."N° Ligne"             := N;
            NewSuppHour."Nom usuel"            := SuppHour."Nom usuel";
            NewSuppHour.prénom                 := SuppHour.prénom;
            NewSuppHour.Date                   := SuppHour.Date;
            NewSuppHour.semaine                := SuppHour.semaine;
            NewSuppHour."Année de paiement"    := SuppHour."Année de paiement";
            NewSuppHour."Mois de paiement"     := SuppHour."Mois de paiement";
          //NewSuppHour."Posting year"          := SuppHour."Posting year";
          //  NewSuppHour."Begining hour"         := SuppHour."Begining hour";

            OverchargeHourCost.RESET;
            OverchargeHourCost.SETRANGE ("Regime of work",SuppHour."Regime of work");
            OverchargeHourCost.SETRANGE (Identifier,SuppHour."Overcharge line");
            IF OverchargeHourCost.FIND ('-') THEN
                IF OverchargeHourCost."Rate of overcharge" > 0 THEN
                  "type ligne"      := 1;
              END;
              BEGIN
                NewSuppHour."Nombre d'heures"               := OverchargeHourCost."Upper limit" - SuppHour."Same week worked hour";
                NewSuppHour."Taux de majoration":= OverchargeHourCost."Rate of overcharge";

          //NewSuppHour."Ending hour"
         //   NewSuppHour."Hour base"             := SuppHour."Hour base";
            NewSuppHour."Montant ligne"           := SuppHour."Montant ligne"
                                                 * NewSuppHour."Nombre d'heures"
                                                 * (NewSuppHour."Taux de majoration" + 100)
                                                 / 100;
                   := SuppHour."Employee's type";
            NewSuppHour."Regime of work"        := SuppHour."Regime of work";
            NewSuppHour."Overcharge line"       := SuppHour."Overcharge line";
            NewSuppHour."User ID"               := SuppHour."User ID";
            NewSuppHour."Last Date Modified"    := SuppHour."Last Date Modified";

            RecordedSuppHours.RESET;
            RecordedSuppHours.SETRANGE ("Transaction No.",Tran);
            RecordedSuppHours.SETRANGE ("Emplyee No.",SuppHour."Emplyee No.");
            IF RecordedSuppHours.FIND ('+') THEN
              L := RecordedSuppHours."Entry No." + 1
             ELSE
              L := 1;

            RecordedSuppHours.RESET;
            RecordedSuppHours."Transaction No."        := Tran;
            RecordedSuppHours."Emplyee No."            := NewSuppHour."Emplyee No.";
            RecordedSuppHours."Entry No."              := L;
            L := L + 1;
            RecordedSuppHours."First Name"             := NewSuppHour."First Name";
            RecordedSuppHours."Last Name"              := NewSuppHour."Last Name";
            RecordedSuppHours.Date                     := NewSuppHour.Date;
            RecordedSuppHours.Week                     := NewSuppHour.Week;
            RecordedSuppHours.Year                     := NewSuppHour.Year;
            RecordedSuppHours."Posting month"          := NewSuppHour."Posting month";
            RecordedSuppHours."Posting year"           := NewSuppHour."Posting year";
            IF Employee.GET (NewSuppHour."Emplyee No.") THEN
              RecordedSuppHours."Employee Posting Group" := Employee."Employee Posting Group";
            RecordedSuppHours."Begining hour"          := NewSuppHour."Begining hour";
            RecordedSuppHours."Ending hour"            := NewSuppHour."Ending hour";
            RecordedSuppHours.Hours                    := NewSuppHour.Hours;
            RecordedSuppHours."Hour base"              := NewSuppHour."Hour base";
            RecordedSuppHours."Rate of overcharge"     := NewSuppHour."Rate of overcharge";
            RecordedSuppHours."Line amount"            := NewSuppHour."Line amount";
            IF NewSuppHour."Rate of overcharge" > 0 THEN
              RecordedSuppHours."Entry type"           := 1;
            RecordedSuppHours."Employee's type"        := NewSuppHour."Employee's type";
            RecordedSuppHours."User ID"                := USERID;
            RecordedSuppHours."Last Date Modified"     := WORKDATE;
            RecordedSuppHours.INSERT;

            //NewSuppHour.INSERT;
         */

    end;


    procedure "DefalcationHeuresSuppl."(EtatMensuelDePaie: Record "Etat Mensuelle Paie")
    var
        GRecSalary: Record Employee;
        GRecRegieOfWork: record "Regimes of work";
        EmployeeContract: Record "Employment Contract";
        LigRegim: record "Bon Reglement";
        PramRessHum: Record "Human Resources Setup";
        DecNBheure: Decimal;
        OverchargeHourCost: record "Bon Reglement";
        taux: Decimal;
        limitesupper: Decimal;
        DecNbHeureSuppl: Decimal;
    begin
        //>> DSFT AGA 22/03/2010
        /* DecNBheure:=0;
        GRecSalary.GET(EtatMensuelDePaie.Matricule);
        EmployeeContract.GET(GRecSalary."Emplymt. Contract Code");
        GRecRegieOfWork.GET(EmployeeContract."Regimes of work");
        //PramRessHum.GET();
        CASE GRecSalary."Employee's type" OF
        0: BEGIN
          IF  EtatMensuelDePaie.Heure>GRecRegieOfWork."Work Hours per month" THEN BEGIN
            DecNBheure:= EtatMensuelDePaie.Heure;
              IF (DecNBheure)>GRecRegieOfWork."Work Hours per month" THEN BEGIN  // début test defalcation heure supp
              OverchargeHourCost.SETFILTER("N° Bon",'%1',GRecRegieOfWork.Code) ;
              IF OverchargeHourCost.FIND('-') THEN BEGIN
                REPEAT
                 IF OverchargeHourCost.Categorie<>0 THEN BEGIN
                   IF DecNBheure < OverchargeHourCost.Matricule THEN BEGIN
                      DecNbHeureSuppl:=DecNBheure-OverchargeHourCost.Mois;
                      IF DecNbHeureSuppl<0 THEN
                         DecNbHeureSuppl:=0;
                      taux:=OverchargeHourCost.Categorie;
                   END ELSE BEGIN
                      DecNbHeureSuppl:=OverchargeHourCost.Matricule-OverchargeHourCost.Mois;
                      taux:=OverchargeHourCost.Categorie;
                   END;

                    EtatMensuelDePaie."Heure 50":=DecNbHeureSuppl;
                 END;  END;
                    EtatMensuelDePaie.MODIFY
                UNTIL OverchargeHourCost.NEXT=0 ;
              END;  // fin boocle teaux de majoration
            END;
          EtatMensuelDePaie.Heure:=GRecRegieOfWork."Work Hours per month";
          EtatMensuelDePaie.MODIFY
          END;
          END;
        //   end;
        1: BEGIN
          IF  EtatMensuelDePaie.Heure>GRecRegieOfWork."Worked Day Per Month" THEN BEGIN
            DecNBheure:= EtatMensuelDePaie.Heure *GRecRegieOfWork."From Work day to Work hour";
              IF (DecNBheure)>GRecRegieOfWork."Work Hours per month" THEN BEGIN  // début test defalcation heure supp
              OverchargeHourCost.SETFILTER("N° Bon",'%1',GRecRegieOfWork.Code) ;
              IF OverchargeHourCost.FIND('-') THEN BEGIN
                REPEAT
                DecNbHeureSuppl:=0;
                 IF OverchargeHourCost.Categorie<>0 THEN BEGIN
                   IF (DecNBheure < OverchargeHourCost.Matricule)THEN BEGIN
                      DecNbHeureSuppl:=DecNBheure-OverchargeHourCost.Mois;
                      IF DecNbHeureSuppl<0 THEN
                         DecNbHeureSuppl:=0;
                      taux:=OverchargeHourCost.Categorie;
                   END ELSE BEGIN
                      DecNbHeureSuppl:=OverchargeHourCost.Matricule-OverchargeHourCost.Mois;
                      taux:=OverchargeHourCost.Categorie;
                   END;

                   IF OverchargeHourCost.Categorie=25 THEN BEGIN
                       EtatMensuelDePaie."Heure 15":=DecNbHeureSuppl;
                   END ELSE IF OverchargeHourCost.Categorie=50 THEN BEGIN
                     EtatMensuelDePaie."Heure 35":=DecNbHeureSuppl;
                 END ELSE IF OverchargeHourCost.Categorie=75 THEN BEGIN
                       EtatMensuelDePaie."Heure 50":=DecNbHeureSuppl;
                       
                  // END ELSE IF OverchargeHourCost.Categorie=75 THEN BEGIN
                     //  EtatMensuelDePaie."Heure Sup Majoré à 75 %":=DecNbHeureSuppl;
                   END ELSE BEGIN
                       EtatMensuelDePaie."Heure Sup Majoré à 100 %":=DecNbHeureSuppl;
                   END;
                 END;
                    EtatMensuelDePaie.MODIFY
                UNTIL OverchargeHourCost.NEXT=0 ;
              END;  // fin boocle teaux de majoration
            END;
          EtatMensuelDePaie.Heure:=GRecRegieOfWork."Worked Day Per Month";
          EtatMensuelDePaie.MODIFY
          END;
          END;
        END;
          */
        // DSFT AGA 22/03/2010

    end;
}

