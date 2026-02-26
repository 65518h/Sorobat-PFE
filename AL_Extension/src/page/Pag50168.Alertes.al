Page 50168 Alertes
{
    PageType = List;
    SourceTable = Alerte;
    ApplicationArea = all;
    UsageCategory = Lists;
    Caption = 'Alertes';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("<Type Alerte>"; REC."Type Alerte")
                {
                    ApplicationArea = all;
                    Caption = 'Type Alerte';
                    Style = Unfavorable;
                    StyleExpr = Rec."Alerte Declencher";

                }
                field(AlerteIcon; AlerteSymbol)
                {
                    Caption = 'Alerte Declencher';
                    ApplicationArea = All;
                    Style = Unfavorable;
                    StyleExpr = Rec."Alerte Declencher";
                    Visible = false;
                    trigger OnDrillDown()
                    begin


                        IF rec."Type Alerte" = rec."Type Alerte"::"Seuil Min Article" THEN
                            IF rec."Alerte Declencher" THEN Page.RUNMODAL(Page::"Alerte Seuil min");

                        IF rec."Type Alerte" = rec."Type Alerte"::"Delais DA" THEN BEGIN
                            SalesHeader.RESET;
                            SalesHeader.SETFILTER("Jours Retard", '>%1', 4);
                            SalesHeader.SETFILTER(Status, '<>%1', SalesHeader.Status::Archivé);
                            IF rec."Alerte Declencher" AND SalesHeader.FINDFIRST THEN Page.RUNMODAL(Page::"Alerte DA", SalesHeader);
                        END;

                        IF rec."Type Alerte" = rec."Type Alerte"::"Vidange Moteur" THEN
                            IF rec."Alerte Declencher" THEN Page.RUNMODAL(Page::"Alerte  Vidange Moteur");

                        IF rec."Type Alerte" = rec."Type Alerte"::"Consommation Gasoil Depasser" THEN BEGIN
                            LigneGasoil.RESET;
                            LigneGasoil.SETRANGE(Journee, WORKDATE - 7, WORKDATE);
                            LigneGasoil.SETRANGE("Alerte Consommation Gasoil", TRUE);

                            IF rec."Alerte Declencher" THEN Page.RUNMODAL(Page::"Alerte Fiche Gasoil", LigneGasoil);
                        END;

                        IF rec."Type Alerte" = rec."Type Alerte"::"Compteur En Panne" THEN BEGIN
                            LigneGasoil.RESET;
                            LigneGasoil.SETRANGE(Journee, WORKDATE - 15, WORKDATE);
                            LigneGasoil.SETRANGE("Compteur En Panne", TRUE);
                            IF rec."Alerte Declencher" THEN Page.RUNMODAL(Page::"Compteur Panne", LigneGasoil);
                        END;

                        IF (rec."Type Alerte" = rec."Type Alerte"::"Papier Materiel") THEN BEGIN
                            IF rec."Alerte Declencher" THEN
                                Page.RUNMODAL(Page::"Alerte Papier");
                        END;

                        IF (rec."Type Alerte" = rec."Type Alerte"::"DA Imminente") THEN BEGIN
                            IF rec."Alerte Declencher" THEN
                                Page.RUNMODAL(Page::"Alerte Imminente DA");
                        END;

                        IF (rec."Type Alerte" = rec."Type Alerte"::"Frequence Changement") THEN BEGIN
                            IF rec."Alerte Declencher" THEN
                                Page.RUNMODAL(Page::"Alerte  Frequence Changement");
                        END;

                        IF rec."Type Alerte" = rec."Type Alerte"::"Vidange Boite" THEN
                            IF rec."Alerte Declencher" THEN Page.RUNMODAL(Page::"Alerte vidange boite");

                        IF rec."Type Alerte" = rec."Type Alerte"::"Vidange 1000H" THEN
                            IF rec."Alerte Declencher" THEN Page.RUNMODAL(Page::"Alerte vidange 1000H");

                        IF rec."Type Alerte" = rec."Type Alerte"::"Vidange 2000H" THEN
                            IF rec."Alerte Declencher" THEN Page.RUNMODAL(Page::"Alerte vidange 2000H");

                        IF rec."Type Alerte" = rec."Type Alerte"::"Chaine de destr." THEN
                            IF rec."Alerte Declencher" THEN Page.RUNMODAL(Page::"Alerte chaine");

                    end;

                }
                field("<Alerte Declencher>"; REC."Alerte Declencher")
                {
                    ApplicationArea = all;
                    Caption = 'Alerte Declencher';
                    Style = Unfavorable;
                    StyleExpr = Rec."Alerte Declencher";
                    Visible = true;

                    trigger OnDrillDown()
                    begin


                        IF rec."Type Alerte" = rec."Type Alerte"::"Seuil Min Article" THEN
                            IF rec."Alerte Declencher" THEN Page.RUNMODAL(Page::"Alerte Seuil min");

                        IF rec."Type Alerte" = rec."Type Alerte"::"Delais DA" THEN BEGIN
                            SalesHeader.RESET;
                            SalesHeader.SETFILTER("Jours Retard", '>%1', 4);
                            SalesHeader.SETFILTER(Status, '<>%1', SalesHeader.Status::Archivé);
                            IF rec."Alerte Declencher" AND SalesHeader.FINDFIRST THEN Page.RUNMODAL(Page::"Alerte DA", SalesHeader);
                        END;

                        IF rec."Type Alerte" = rec."Type Alerte"::"Vidange Moteur" THEN
                            IF rec."Alerte Declencher" THEN Page.RUNMODAL(Page::"Alerte  Vidange Moteur");

                        IF rec."Type Alerte" = rec."Type Alerte"::"Consommation Gasoil Depasser" THEN BEGIN
                            LigneGasoil.RESET;
                            LigneGasoil.SETRANGE(Journee, WORKDATE - 7, WORKDATE);
                            LigneGasoil.SETRANGE("Alerte Consommation Gasoil", TRUE);

                            IF rec."Alerte Declencher" THEN Page.RUNMODAL(Page::"Alerte Fiche Gasoil", LigneGasoil);
                        END;

                        IF rec."Type Alerte" = rec."Type Alerte"::"Compteur En Panne" THEN BEGIN
                            LigneGasoil.RESET;
                            LigneGasoil.SETRANGE(Journee, WORKDATE - 15, WORKDATE);
                            LigneGasoil.SETRANGE("Compteur En Panne", TRUE);
                            IF rec."Alerte Declencher" THEN Page.RUNMODAL(Page::"Compteur Panne", LigneGasoil);
                        END;

                        IF (rec."Type Alerte" = rec."Type Alerte"::"Papier Materiel") THEN BEGIN
                            IF rec."Alerte Declencher" THEN
                                Page.RUNMODAL(Page::"Alerte Papier");
                        END;

                        IF (rec."Type Alerte" = rec."Type Alerte"::"DA Imminente") THEN BEGIN
                            IF rec."Alerte Declencher" THEN
                                Page.RUNMODAL(Page::"Alerte Imminente DA");
                        END;

                        IF (rec."Type Alerte" = rec."Type Alerte"::"Frequence Changement") THEN BEGIN
                            IF rec."Alerte Declencher" THEN
                                Page.RUNMODAL(Page::"Alerte  Frequence Changement");
                        END;

                        IF rec."Type Alerte" = rec."Type Alerte"::"Vidange Boite" THEN
                            IF rec."Alerte Declencher" THEN Page.RUNMODAL(Page::"Alerte vidange boite");

                        IF rec."Type Alerte" = rec."Type Alerte"::"Vidange 1000H" THEN
                            IF rec."Alerte Declencher" THEN Page.RUNMODAL(Page::"Alerte vidange 1000H");

                        IF rec."Type Alerte" = rec."Type Alerte"::"Vidange 2000H" THEN
                            IF rec."Alerte Declencher" THEN Page.RUNMODAL(Page::"Alerte vidange 2000H");

                        IF rec."Type Alerte" = rec."Type Alerte"::"Chaine de destr." THEN
                            IF rec."Alerte Declencher" THEN Page.RUNMODAL(Page::"Alerte chaine");

                    end;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            // group("Tableau De Bords")
            // {
            //     Caption = 'Tableau De Bords';
            action("SUIVI DA")
            {
                ApplicationArea = all;

                trigger OnAction()
                begin
                    Report.RunModal(50126);
                end;
            }
            action("RAPPORT JOURNALIER")
            {
                ApplicationArea = all;

                trigger OnAction()
                begin
                    Page.RunModal(Page::"Rapport Journalier");
                end;
            }
            action(STOCK)
            {
                ApplicationArea = all;

                trigger OnAction()
                begin
                    Report.RunModal(50090);
                end;
            }
            action("COMMADER NON RECU")
            {
                ApplicationArea = all;

                trigger OnAction()
                begin
                    Page.RunModal(Page::"Commande Non Recu");
                end;
            }
            action("RECU NON FACTURER")
            {
                ApplicationArea = all;

                trigger OnAction()
                begin
                    Page.RunModal(Page::"Commande Recu Non Facturé");
                end;
            }
            action("POINTAGE ENGINS")
            {
                ApplicationArea = all;

                trigger OnAction()
                begin
                    Report.RunModal(50060);
                end;
            }
            action("VIDANGE ENGINS")
            {
                ApplicationArea = all;

                trigger OnAction()
                begin
                    Page.RunModal(Page::"Alerte  Vidange Moteur");
                end;
            }
            action("CONSOMMATION ENGINS")
            {
                ApplicationArea = all;

                trigger OnAction()
                begin
                    Report.RunModal(50039);
                end;
            }
            action("REPARATION ENGINS")
            {
                ApplicationArea = all;

                trigger OnAction()
                begin
                    Page.RunModal(52049036);
                end;
            }
            action("STATUT ENGINS")
            {
                ApplicationArea = all;

                trigger OnAction()
                begin
                    Vehicule.Reset;
                    Vehicule.SetFilter("Vidange A", '<>%1', 0);
                    Page.RunModal(Page::"List Véhicules", Vehicule);
                end;
            }
            action("RENDEMENT CAMION")
            {
                ApplicationArea = all;

                trigger OnAction()
                begin
                    Report.RunModal(50194);
                end;
            }
            action("ATTACHEMENT PERSONNEL")
            {
                ApplicationArea = all;

                trigger OnAction()
                begin
                    Report.RunModal(50194);
                end;
            }
            action("BON REGLEMENT")
            {
                ApplicationArea = all;

                trigger OnAction()
                begin
                    Report.RunModal(50294);
                end;
            }
            action("CALCUL COUT MATERIEL")
            {
                ApplicationArea = all;

                trigger OnAction()
                begin
                    Report.RunModal(50192);
                end;
            }
            action("CALCUL COUT TRANSPORT")
            {
                ApplicationArea = all;

                trigger OnAction()
                begin
                    Report.RunModal(50204);
                end;
            }
            action("PRODUCTION CARRIERE")
            {
                ApplicationArea = all;

                trigger OnAction()
                begin
                    Report.RunModal(50201);
                end;
            }
            action("LIVRAISON CARRIERE")
            {
                ApplicationArea = all;

                trigger OnAction()
                begin
                    Report.RunModal(50203);
                end;
            }
            action("PRODUCTION CENTRALE ENROBE")
            {
                ApplicationArea = all;

                trigger OnAction()
                begin
                    Report.RunModal(50205);
                end;
            }
            action("LIVRAISON CENTRALE ENROBE")
            {
                ApplicationArea = all;

                trigger OnAction()
                begin
                    Report.RunModal(50207);
                end;
            }
            action("PRODUCTION CENTRALE BETON")
            {
                ApplicationArea = all;

                trigger OnAction()
                begin
                    Report.RunModal(50202);
                end;
            }
            action("LIVRAISON CENTRALE BETON")
            {
                ApplicationArea = all;

                trigger OnAction()
                begin
                    Report.RunModal(50208);
                end;
            }
            action("PRODUCTION PREFA")
            {
                ApplicationArea = all;

                trigger OnAction()
                begin
                    Report.RunModal(50201);
                end;
            }
            action("LIVRAISON PREFA")
            {
                ApplicationArea = all;

                trigger OnAction()
                begin
                    Report.RunModal(50209);
                end;
            }
            action("RECOUP. CENTRALE BETON")
            {
                ApplicationArea = all;

                trigger OnAction()
                begin
                    Report.RunModal(50203);
                end;
            }
            action("RECOUP. PREFA")
            {
                ApplicationArea = all;

                trigger OnAction()
                begin
                    Report.RunModal(50203);
                end;
            }
            action("RECOUP. TRANSPORT")
            {
                ApplicationArea = all;

                trigger OnAction()
                begin
                    Report.RunModal(50203);
                end;
            }
            action("RECOUPEMENT CARRIERE")
            {
                ApplicationArea = all;

                trigger OnAction()
                begin
                    Report.RunModal(50203);
                end;
            }
            action("RECOUP. CENTRALE ENROBE")
            {
                ApplicationArea = all;

                trigger OnAction()
                begin
                    Report.RunModal(50203);
                end;
            }
            // }
            // group(DASHBORD)
            // {
            // Caption = 'DASHBORD';
            /*GL2024     action(ACHAT)
                 {
                     ApplicationArea = all;

                     trigger OnAction()
                     begin
                         ExecName := 'C:\Dashbord\Qv.Exe';
                         Fichier := 'C:\Dashbord\RDASHBOARD ACHAT.qvw';
                         //DYS a verifier
                         // RET := SHELL(ExecName, Fichier);
                     end;
                 }
                 action(MAGASIN)
                 {
                     ApplicationArea = all;

                     trigger OnAction()
                     begin
                         ExecName := 'C:\Dashbord\Qv.Exe';
                         Fichier := 'C:\Dashbord\DASHBOARD Magasin.qvw';
                         //DYS a verifier
                         //RET := rec.SHELL(ExecName, Fichier);
                     end;
                 }
                 action(GASOIL)
                 {
                     ApplicationArea = all;

                     trigger OnAction()
                     begin
                         ExecName := 'C:\Dashbord\Qv.Exe';
                         Fichier := 'C:\Dashbord\DASHBOARD GAZOIL.qvw';
                         //DYS a verifier
                         //RET := SHELL(ExecName, Fichier);
                     end;
                 }
                 action(PARC)
                 {
                     ApplicationArea = all;

                     trigger OnAction()
                     begin
                         ExecName := 'C:\Dashbord\Qv.Exe';
                         Fichier := 'C:\Dashbord\Pointage Materiel.qvw';
                         //DYS a verifier
                         // RET := SHELL(ExecName, Fichier);
                     end;
                 }
                 action(PRODUCTION)
                 {
                     ApplicationArea = all;

                     trigger OnAction()
                     begin
                         ExecName := 'C:\Dashbord\Qv.Exe';
                         Fichier := 'C:\Dashbord\Productions.qvw';
                         //DYS a verifier
                         // RET := SHELL(ExecName, Fichier);
                     end;
                 }
                 action(PAIE)
                 {
                     ApplicationArea = all;

                     trigger OnAction()
                     begin
                         ExecName := 'C:\Dashbord\Qv.Exe';
                         Fichier := 'C:\Dashbord\Dashbord PAIE.qvw';
                         //DYS a verifier
                         //  RET := SHELL(ExecName, Fichier);
                     end;
                 }
                 action("RAPPORT CHANTIER")
                 {
                     ApplicationArea = all;

                     trigger OnAction()
                     begin
                         ExecName := 'C:\Dashbord\Qv.Exe';
                         Fichier := 'C:\Dashbord\Rapport Chantier.qvw';
                         //DYS a verifier
                         //RET := SHELL(ExecName, Fichier);
                     end;
                 }*/
            //   }
        }
    }

    trigger OnOpenPage()
    var
        LPurchaseLine: Record "Purchase Line";
    begin

        SalesHeader.RESET;
        SalesHeader.SETFILTER(Status, '>=%1', SalesHeader.Status::Released);
        SalesHeader.SETRANGE("Document Type", SalesHeader."Document Type"::Order);
        SalesHeader.SETRANGE("Order Type", SalesHeader."Order Type"::"Supply Order");
        //SalesHeader.SETFILTER("Commande Achat Associé",'');
        SalesHeader.SETFILTER("Posting Date", '<>%1', 0D);
        IF SalesHeader.FINDFIRST THEN
            REPEAT
                SalesHeader.CALCFIELDS("Commande Achat Associé");
                IF (SalesHeader.Status <> SalesHeader.Status::Archivé) THEN BEGIN
                    IF (SalesHeader."Posting Date" - 4 <= WORKDATE) AND (SalesHeader."Commande Achat Associé" = '') THEN BEGIN
                        SalesHeader."Jours Retard" := WORKDATE - SalesHeader."Posting Date";
                        SalesHeader.MODIFY;
                    END
                    ELSE BEGIN
                        SalesHeader."Jours Retard" := 0;
                        SalesHeader.MODIFY;

                    END;
                END;
            UNTIL SalesHeader.NEXT = 0;

        Declencheur := 0;
        Description := '';
        IF RecAlerte.FINDFIRST THEN
            REPEAT
                IF RecAlerte."Type Alerte" = RecAlerte."Type Alerte"::"Seuil Min Article" THEN BEGIN
                    Item.SETFILTER("Seuil Min", '<>%1', 0);
                    IF Item.FINDFIRST THEN
                        REPEAT
                            Item.CALCFIELDS(Inventory);
                            IF Item.Inventory <= Item."Seuil Min" THEN BEGIN
                                RecAlerte."Alerte Declencher" := TRUE;
                                RecAlerte.MODIFY;
                                Item."Alerte Declenche" := TRUE;
                                Item.MODIFY;
                            END
                            ELSE BEGIN
                                // RecAlerte."Alerte Declencher":=FALSE;
                                // RecAlerte.MODIFY;
                                Item."Alerte Declenche" := FALSE;
                                Item.MODIFY;
                            END;


                        UNTIL Item.NEXT = 0;
                END;
                RecAlerte.RESET;
                IF RecAlerte."Type Alerte" = RecAlerte."Type Alerte"::"Delais DA" THEN BEGIN
                    SalesHeader.RESET;
                    //GL2024 SalesHeader.SETFILTER(Status, '>=%1', SalesHeader.Status::Released);
                    SalesHeader.SETFILTER(Status, '%1', SalesHeader.Status::Open);
                    SalesHeader.SETRANGE("Document Type", SalesHeader."Document Type"::Order);
                    SalesHeader.SETRANGE("Order Type", SalesHeader."Order Type"::"Supply Order");
                    SalesHeader.SETFILTER("Commande Achat Associé", '');
                    SalesHeader.SETFILTER("Jours Retard", '>%1', 4);
                    IF SalesHeader.FINDFIRST THEN BEGIN
                        IF SalesHeader.Status <> SalesHeader.Status::Archivé THEN BEGIN
                            RecAlerte."Alerte Declencher" := TRUE;
                            RecAlerte.MODIFY;
                        END;
                    END
                    ELSE BEGIN
                        RecAlerte."Alerte Declencher" := FALSE;
                        RecAlerte.MODIFY;

                    END;

                END;


                IF RecAlerte."Type Alerte" = RecAlerte."Type Alerte"::"Vidange Moteur" THEN BEGIN
                    Vehicule.SETFILTER("Reste Pour Alerte", '<=%1', 0);
                    Vehicule.SETFILTER("Prochain Vidange", '<>%1', 0);

                    IF Vehicule.FINDFIRST THEN BEGIN
                        RecAlerte."Alerte Declencher" := TRUE;
                        RecAlerte.MODIFY;
                    END
                    ELSE BEGIN
                        RecAlerte."Alerte Declencher" := FALSE;
                        RecAlerte.MODIFY;

                    END;
                END;
                Vehicule.RESET;
                IF RecAlerte."Type Alerte" = RecAlerte."Type Alerte"::"Vidange Boite" THEN BEGIN
                    Vehicule.SETFILTER("Reste pour alerte 1", '<=%1', 0);
                    Vehicule.SETFILTER("Prochain vidange 1", '<>%1', 0);

                    IF Vehicule.FINDFIRST THEN BEGIN
                        RecAlerte."Alerte Declencher" := TRUE;
                        RecAlerte.MODIFY;
                    END
                    ELSE BEGIN
                        RecAlerte."Alerte Declencher" := FALSE;
                        RecAlerte.MODIFY;

                    END;
                END;
                Vehicule.RESET;

                IF RecAlerte."Type Alerte" = RecAlerte."Type Alerte"::"Vidange 1000H" THEN BEGIN
                    Vehicule.SETFILTER("Reste pour alerte 1000H", '<=%1', 0);
                    Vehicule.SETFILTER("Prochain vidange 1000H", '<>%1', 0);

                    IF Vehicule.FINDFIRST THEN BEGIN
                        RecAlerte."Alerte Declencher" := TRUE;
                        RecAlerte.MODIFY;
                    END
                    ELSE BEGIN
                        RecAlerte."Alerte Declencher" := FALSE;
                        RecAlerte.MODIFY;

                    END;
                END;
                Vehicule.RESET;

                IF RecAlerte."Type Alerte" = RecAlerte."Type Alerte"::"Vidange 2000H" THEN BEGIN
                    Vehicule.SETFILTER("Reste pour alerte 2", '<=%1', 0);
                    Vehicule.SETFILTER("Prochain vidange 2", '<>%1', 0);

                    IF Vehicule.FINDFIRST THEN BEGIN
                        RecAlerte."Alerte Declencher" := TRUE;
                        RecAlerte.MODIFY;
                    END
                    ELSE BEGIN
                        RecAlerte."Alerte Declencher" := FALSE;
                        RecAlerte.MODIFY;

                    END;
                END;
                Vehicule.RESET;

                IF RecAlerte."Type Alerte" = RecAlerte."Type Alerte"::"Chaine de destr." THEN BEGIN
                    Vehicule.SETFILTER("Reste pour alerte 3", '<=%1', 0);
                    Vehicule.SETFILTER("Prochain vidange 3", '<>%1', 0);

                    IF Vehicule.FINDFIRST THEN BEGIN
                        RecAlerte."Alerte Declencher" := TRUE;
                        RecAlerte.MODIFY;
                    END
                    ELSE BEGIN
                        RecAlerte."Alerte Declencher" := FALSE;
                        RecAlerte.MODIFY;

                    END;
                END;
                Vehicule.RESET;


                IF RecAlerte."Type Alerte" = RecAlerte."Type Alerte"::"Papier Materiel" THEN BEGIN
                    Vehicule.RESET;
                    Vehicule.SETRANGE("Alerte Papier", TRUE);

                    IF Vehicule.FINDFIRST THEN BEGIN
                        RecAlerte."Alerte Declencher" := TRUE;
                        RecAlerte.MODIFY;
                    END
                    ELSE BEGIN
                        RecAlerte."Alerte Declencher" := FALSE;
                        RecAlerte.MODIFY;

                    END;

                END;

                IF RecAlerte."Type Alerte" = RecAlerte."Type Alerte"::"Consommation Gasoil Depasser" THEN BEGIN
                    LigneGasoil.SETRANGE(Journee, WORKDATE - 7, WORKDATE);
                    LigneGasoil.SETRANGE("Alerte Consommation Gasoil", TRUE);
                    IF LigneGasoil.FINDFIRST THEN BEGIN
                        RecAlerte."Alerte Declencher" := TRUE;
                        RecAlerte.MODIFY;

                    END
                    ELSE BEGIN
                        RecAlerte."Alerte Declencher" := FALSE;
                        RecAlerte.MODIFY;

                    END;


                END;

                IF RecAlerte."Type Alerte" = RecAlerte."Type Alerte"::"Compteur En Panne" THEN BEGIN
                    LigneGasoil.RESET;
                    LigneGasoil.SETRANGE(Journee, WORKDATE - 17, WORKDATE);
                    LigneGasoil.SETRANGE("Compteur En Panne", TRUE);
                    IF LigneGasoil.FINDFIRST THEN BEGIN
                        RecAlerte."Alerte Declencher" := TRUE;
                        RecAlerte.MODIFY;
                    END
                    ELSE BEGIN
                        RecAlerte."Alerte Declencher" := FALSE;
                        RecAlerte.MODIFY;

                    END;

                END;
            UNTIL RecAlerte.NEXT = 0;
        // Frequence changement
        IF RecAlerte."Type Alerte" = RecAlerte."Type Alerte"::"Frequence Changement" THEN BEGIN
            ItemLedgerEntry.SETCURRENTKEY("Posting Date", "Alerte Frequence Changement");
            ItemLedgerEntry.SETRANGE("Posting Date", WORKDATE - 7, WORKDATE + 7);
            ItemLedgerEntry.SETRANGE("Alerte Frequence Changement", TRUE);
            IF ItemLedgerEntry.FINDFIRST THEN BEGIN
                RecAlerte."Alerte Declencher" := TRUE;
                RecAlerte.MODIFY;
            END
            ELSE BEGIN
                RecAlerte."Alerte Declencher" := FALSE;
                RecAlerte.MODIFY;

            END;

        END;


        // DA IMMINNTE

        // >> HJ SORO 08-11-2016
        SalesHeader2.RESET;
        SalesHeader2.SETRANGE("Document Type", SalesHeader2."Document Type"::Order);
        SalesHeader2.SETRANGE("Order Type", SalesHeader2."Order Type"::"Supply Order");
        SalesHeader2.SETRANGE("Alerte Imminente", TRUE);
        SalesHeader2.SETRANGE("Alerte Imminente Desactivé", FALSE);
        IF SalesHeader2.FINDFIRST THEN
            REPEAT
                SalesHeader2.CALCFIELDS("Commande Achat Associé");
                IF SalesHeader2."Commande Achat Associé" <> '' THEN BEGIN
                    LPurchaseLine.SETRANGE("Document Type", LPurchaseLine."Document Type"::Order);
                    LPurchaseLine.SETRANGE("Document No.", SalesHeader2."Commande Achat Associé");
                    LPurchaseLine.SETFILTER("Quantity Received", '<>%1', 0);
                    IF LPurchaseLine.FINDFIRST THEN BEGIN
                        SalesHeader2."Alerte Imminente Declanché" := TRUE;
                        SalesHeader2.MODIFY;
                        RecAlerte."Alerte Declencher" := TRUE;
                        RecAlerte.MODIFY;

                    END;
                END;
            UNTIL SalesHeader2.NEXT = 0;
        // >> HJ SORO 08-11-2016

    end;

    trigger OnAfterGetRecord()
    begin
        if Rec."Alerte Declencher" then
            AlerteSymbol := '✔'
        else
            AlerteSymbol := '';

    end;

    var
        AlerteSymbol: Text[5];
        ItemLedgerEntry: Record "Item Ledger Entry";
        Declencheur: Integer;
        Item: Record Item;
        SalesHeader: Record "Sales Header";
        SalesHeader2: Record "Sales Header";
        Vehicule: Record "Véhicule";
        LigneGasoil: Record "Ligne Fiche Gasoil";
        Afficher: Text[30];
        Description: Text[100];
        Choix: Integer;
        RecAlerte: Record Alerte;
        ExecName: Text[100];
        Fichier: Text[100];
        RET: Integer;
        Text001: label 'AT,Assurance,Visite Technique,Vignette';


}

